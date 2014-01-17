# -*- coding: utf-8 -*-
class CpPolicyController < ApplicationController
#  before_filter :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_foud
    render :text=> 'policy record was not found.'
  end


  def create

  end

  def update
  end

  def destroy
  end

  def list
  end

  def show
  end

  # 同步SP的省份默认使用SP的参数
  def sync_policy
    if params[:id].blank?
      render :text => 'not found cp business id.'
      return
    end

    
  end

  #@param
  # id is cp_business_id
  def new
      if params[:id].blank?
        render :text => 'not found cp business id.'
        return
      end

    cpbusiness = CpBusiness.find_by_ID(params[:id])
    unless cpbusiness.nil?
      policy = CpPolicy.new
      policy.CP_BUSINESS_ID = params[:id]
      policy.ENABLED = 1
      policy.save

      cpbusiness.POLICY_ID = policy.ID
      cpbusiness.save
      redirect_to :action => 'configure', :id => policy.id
    end


  end

  def configure
    if params[:id].blank?
      respond_to do |format|
        format.html { render :inline => 'require policy id.' }
      end
    else
      @policy = CpPolicy.find(params[:id])
      @cpbusiness = CpBusiness.find_by_POLICY_ID params[:id].to_i
    end
  end
end
