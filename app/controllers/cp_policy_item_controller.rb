# -*- coding: utf-8 -*-
require  File.expand_path('../../../lib/datatables/policy_table', __FILE__)
class CpPolicyItemController < ApplicationController
  def create
  end

  def submit_create
    region = params[:input_region]
    policy_id = params[:input_policy_id]

    found =  CpPolicyItem.province_exsit?(policy_id, region)
    unless found
      pi = CpPolicyItem.new
      pi.PARENT_ID = 0
      pi.TARGET = region
      pi.ENABLED = 1
      pi.POLICY_ID         = policy_id
      pi.LIMITED_DAY_PHONE = params[:input_day_phone_limit] if params[:input_day_phone_limit]
      pi.LIMITED_MON_PHONE = params[:input_mon_phone_limit] if params[:input_mon_phone_limit]
      pi.LIMITED_DAY_MAX   = params[:input_day_limit] if params[:input_day_limit]
      pi.LIMITED_MON_MAX   = params[:input_mon_limit] if params[:input_mon_limit]
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
end
