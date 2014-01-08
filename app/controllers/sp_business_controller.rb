# -*- coding: utf-8 -*-
require File.expand_path('../../../lib/datatables/sp_business_table',__FILE__)

class SpBusinessController < ApplicationController
#  before_filter :authenticate_user!
  def create
    if params[:spid].blank?
      respond_to do |format|
        format.html {render :inline => 'failed to create sp business without spid.'}
      end
    end
    @spbusiness = SpBusiness.new
    @spbusiness.BUSINESSID = Serial.new_serial("BZ")
    @spbusiness.STATUS = 0
    @spbusiness.PRICE = 1
    @spbusiness.SPID = params[:spid]

    respond_to do | format|
      format.html
    end
  end

  def submit_create
    if params[:spid].blank?
      respond_to do |format|
        format.html { render :inline => "create sp business failed."}
      end
    end

    @spinfo = SpInfo.find(params[:spid])

    @spbusiness = SpBusiness.new
    @spbusiness.SPID = @spinfo.SPID
    @spbusiness.BUSINESSTYPE = @spinfo.ACCEPTTYPE
    @spbusiness.BUSINESSID = params[:input_businessid]
    @spbusiness.CMD = params[:input_cmd]
    @spbusiness.SPNUMBER = params[:input_spnumber]
    @spbusiness.CMDTYPE = params[:input_cmdtype].to_i
    @spbusiness.PRICE = params[:input_price].to_i
    @spbusiness.AREALIST = params[:input_arealist]
    @spbusiness.STATUS = params[:input_enabled].blank? ? 0: 1
    @spbusiness.save!

    respond_to do |format|
      format.html { render :action=> "list", :id => @spinfo.SPID }
    end
  end

  def list
    @spid = params[:id]
  end

  def list_for_table
    @extra = params[:sEcho].to_i
    count, @items = SpBusiness.list_for_table params
  end

  def destroy
  end

  def update
  end


  def submit_configure
    if params[:id].blank?
      respond_to do |format|
        format.html { render :inline => "configure sp business failed without id." }
      end
    end
    @spbusiness = SpBusiness.find_by_ID params[:id]

    unless @spbusiness.nil?
      @spbusiness.CMD = params[:input_cmd]
      @spbusiness.CMDTYPE = params[:input_cmdtype].to_i
      @spbusiness.SPNUMBER = params[:input_spnumber]
      @spbusiness.PRICE = params[:input_price].to_i
      @spbusiness.STATUS = params[:input_enabled].blank? ? 0: 1
      @spbusiness.AREALIST = params[:input_arealist]
      @spbusiness.BUSINESS_NAME = params[:input_business_name]
      @spbusiness.save!
    end

    respond_to do |format|
      format.html { render :action => "list" }
    end
  end


  def configure
    id = params[:id]
    @spbusiness = SpBusiness.find_by_ID id
  end

  def policy
    if params[:id].blank?
      render :text => 'not find sp business id'
      return
    end

    spbusiness = SpBusiness.find(params[:id])
    unless spbusiness.nil?
      if spbusiness.POLICY_ID == 0
        policy = SpPolicy.new
        policy.SP_BUSINESS_ID = params[:id].to_i
        policy.ENABLED = 1
        policy.save!

        spbusiness.POLICY_ID = policy.ID
        spbusiness.save!
      end

      redirect_to "/sp_policy/configure/#{spbusiness.POLICY_ID}"
      return 
    end

    render :text => 'create sp policy failed.'
  end

  def mt
    if params[:id].blank?
      render :text => 'not find business id'
      return
    end
    @sp_business = SpBusiness.find(params[:id])
  end

  def  mt_for_table
    @extra = params[:sEcho].to_i
    count, @items = SpBusinessMt.list_for_table params
  end

  # 增加新的MT信息
  def  add_new_mt
    if params[:sp_business_id].blank?
      render :text => 'no sp business id'
      return
    end
    mt =  SpBusinessMt.new
    mt.SP_BUSINESS_ID = params[:sp_business_id]
    mt.MT_CONTENT = params[:mt_content]

    mt.save!
    render :text => 'ok'
  end

  def remove_mt
    if params[:id].blank?
      render :text => 'node sp business mt id'
      return
    end

    SpBusinessMt.delete(params[:id])
    
    render :text => 'ok'
  end
end
