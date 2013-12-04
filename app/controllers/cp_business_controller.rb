# -*- coding: utf-8 -*-
require File.expand_path('../../../lib/datatables/cp_business_table',__FILE__)
require File.expand_path('../../../app/models/cp_business', __FILE__)
class CpBusinessController < ApplicationController
=begin
   获取参数，并自动创建cp业务。 在创建前，必须先检查是否有想通的指令已经被分配掉，则创建失败，返回原来页面并给出提示。
   这部分使用ajax，在创建前自动获取比较好

   参数
   c - cmd
   cpid
   dp    dis_percent
   pp    pay_percent
   spid
=end
  def create
    @spbusiness = SpBusiness.find_by_SPID params[:spid]
    unless @spbusiness.nil?
      cmd = params[:c].blank? ? @spbusiness.CMD : @spbusiness.CMD + params[:c]
      unless CpBusiness.business_cmd_occupied?(@spbusiness.SPID, cmd)
        cpbusiness = CpBusiness.new
        cpbusiness.CMD = cmd
        cpbusiness.BUSINESSID = Serial.new_serial("BZ")
        cpbusiness.save!
      end
    end

    respond_to do |format|
      format.html { redirect_to "/cp_business/configure/#{cpbusiness.ID}"}
    end
  end

  def configure
    @spbusiness = SpBusiness.find(params[:id])



  end

  def occupied
    @spbusiness = SpBusiness.find_by_SPID params[:spid]

    cmd = ""
    unless @spbusiness.nil?
      cmd = params[:cmd].blank? ? @spbusiness.CMD : @spbusiness.CMD + params[:cmd]
    end

    ret = CpBusiness.business_cmd_occupied? @spbusiness.SPID, cmd

    respond_to do |format|
      format.json { render :json => '{ "occupied":"#{ret}" }' }
    end
  end

  def submit_create


  end

  def list
  end

  def destroy
  end

  def update
  end

  def configure
  end

  def submit_configure
  end

  def list_for_table
    respond_to do |format|
      format.html
      format.xml
      format.json { render json: Datatable::CpBusinessTable.new(view_context)}
    end
  end

end
