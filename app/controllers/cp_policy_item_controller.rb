# -*- coding: utf-8 -*-
require  File.expand_path('../../../lib/datatables/policy_table', __FILE__)
class CpPolicyItemController < ApplicationController
  def create
  end

  def destroy
    if params[:id].blank?
      render :text => "require a id to delete policy item"
      return
    end

    policy_item = CpPolicyItem.find(params[:id])
    policy_item.PURGED = 1
    policy_item.UPDATED_AT = Time.now.strftime("%F %T")
    policy_item.save

    redirect_to :back
  end

  def update
    if params[:id].blank?
      render :text => 'not find param id'
      return
    end

    region = params[:input_region]
    policy_id = params[:input_policy_id]

    pi =  CpPolicyItem.find(params[:id])

    pi.PARENT_ID = 0
    pi.POLICY_ID         = policy_id
    pi.LIMITED_DAY_PHONE = params[:input_day_phone_limit] unless params[:input_day_phone_limit].blank?
    pi.LIMITED_MON_PHONE = params[:input_mon_phone_limit] unless params[:input_mon_phone_limit].blank?
    pi.LIMITED_DAY_MAX   = params[:input_day_limit] unless params[:input_day_limit].blank?
    pi.LIMITED_MON_MAX   = params[:input_mon_limit] unless params[:input_mon_limit].blank?
    pi.DISCOUNT_DAY_MAX  = params[:input_discount_day_limit] unless params[:input_discount_day_limit].blank?
    pi.DISCOUNT_MON_MAX  = params[:input_discount_mon_limit] unless params[:input_discount_mon_limit].blank?
    pi.DISCOUNT_BASE     = params[:input_discount_base] unless params[:input_discount_base].blank?
    pi.DISCOUNT_START    = params[:input_discount_start] unless params[:input_discount_start].blank?
    pi.ENABLED           = 1 unless params[:input_enabled].blank?
    pi.UPDATED_AT        = Time.now.strftime("%F %T")
    pi.save

    if params[:cities].length > 0
      CpPolicyItem.update_all(['PURGED=?, UPDATED_AT =? ',1, Time.now.strftime("%F %T")],['POLICY_ID=? AND PARENT_ID=?', policy_id,pi.ID])
        CpPolicyItem.transaction do
          params[:cities].each do |city|
            CpPolicyItem.create(
                                POLICY_ID: "#{policy_id}",
                                PARENT_ID: "#{pi.ID}",
                                TARGET: "#{city[0]}",
                                SYS_INFO_ID: "#{city[1]}",
                                ENABLED: 0,
                                UPDATED_AT: Time.now.strftime("%F %T")
                                )
        end
      end
    end
    redirect_to :back
  end

  def submit_create
    region = params[:input_region]
    policy_id = params[:input_policy_id]

    info = SysInfo.find(region)

    found =  CpPolicyItem.province_exsit?(policy_id, info.CONTEXT)
    unless found
      pi = CpPolicyItem.new
      pi.PARENT_ID = 0
      pi.SYS_INFO_ID = info.ID
      pi.TARGET = info.CONTEXT
      pi.POLICY_ID         = policy_id
      pi.LIMITED_DAY_PHONE = params[:input_day_phone_limit] unless params[:input_day_phone_limit].blank?
      pi.LIMITED_MON_PHONE = params[:input_mon_phone_limit] unless params[:input_mon_phone_limit].blank?
      pi.LIMITED_DAY_MAX   = params[:input_day_limit] unless params[:input_day_limit].blank?
      pi.LIMITED_MON_MAX   = params[:input_mon_limit] unless params[:input_mon_limit].blank?
      pi.DISCOUNT_DAY_MAX  = params[:input_discount_day_limit] unless params[:input_discount_day_limit].blank?
      pi.DISCOUNT_MON_MAX  = params[:input_discount_mon_limit] unless params[:input_discount_mon_limit].blank?
      pi.DISCOUNT_BASE     = params[:input_discount_base] unless params[:input_discount_base].blank?
      pi.DISCOUNT_START    = params[:input_discount_start] unless params[:input_discount_start].blank?
      pi.ENABLED           = 1 unless params[:input_enabled].blank?
      pi.save

    if params[:cities].length > 0
      CpPolicyItem.update_all(['PURGED=?, UPDATED_AT =? ',1, Time.now.strftime("%F %T")],['POLICY_ID=? AND PARENT_ID=?', policy_id,pi.ID])
      CpPolicyItem.transaction do
        params[:cities].each do |city|
          CpPolicyItem.create(
                                POLICY_ID: "#{policy_id}",
                                PARENT_ID: "#{pi.ID}",
                                TARGET: "#{city[0]}",
                                SYS_INFO_ID: "#{city[1]}",
                                ENABLED: 0,
                                UPDATED_AT: Time.now.strftime("%F %T")
                                )
        end
      end
    end

      redirect_to :back
      return 
    end
    render :text => '省份已经存在'
  end

  def list_for_table
    respond_to do | format|
      format.json { render json: Datatable::PolicyTable.new(view_context)}
    end
  end

  def get_data
    if params[:id].blank?
      render json: "{result: 'no id'}"
      return
    end

    policy_item = CpPolicyItem.find(params[:id])
    respond_to do |format|
      format.json { render json: policy_item }
    end
    #
    # policy_id -- policy_id
    # parent_id    
    def get_policy_cities
      if params[:policy_id].blank? or params[:parent_id].blank?
        render :text=> 'param policy_id or parent_id missed'
        return
      end

      respond_to do |format|
        format.json { render json: CpPolicyItem.cities("#{params[:policy_id]}","#{params[:parent_id]}")}
      end
    end
  end
end
