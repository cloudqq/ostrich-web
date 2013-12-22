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

    redirect_to :back
  end

  def submit_create
    region = params[:input_region]
    policy_id = params[:input_policy_id]

    found =  CpPolicyItem.province_exsit?(policy_id, region)
    unless found
      pi = CpPolicyItem.new
      pi.PARENT_ID = 0
      pi.TARGET = region
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

  end
end
