# -*- coding: utf-8 -*-
require File.expand_path('../../../lib/datatables/cp_business_table',__FILE__)
require File.expand_path('../../../app/models/cp_business', __FILE__)
class CpBusinessController < ApplicationController
  #before_filter :authenticate_user!
=begin
   获取参数，并自动创建cp业务。 在创建前，必须先检查是否有想通的指令已经被分配掉，则创建失败，返回原来页面并给出提示。
   这部分使用ajax，在创建前自动获取比较好

   参数
   c - cmd
   cpid
   dp    dis_percent
   pp    pay_percent
   spid
   spuid sp business uid
=end
  def create
    @spbusiness = SpBusiness.find_by_ID(params[:spuid])

    unless @spbusiness.nil?
      cmd = params[:c].blank? ? @spbusiness.CMD : @spbusiness.CMD + params[:c]
      unless CpBusiness.business_cmd_occupied?(@spbusiness.SPID, @spbusiness.SPNUMBER, cmd)
        cpbusiness = CpBusiness.new
        cpbusiness.CMD = cmd.upcase
        cpbusiness.BUSINESSID = @spbusiness.BUSINESSID
        cpbusiness.PAYPRCT = params[:pp].to_f
        cpbusiness.DISCOUNTPRCT = params[:dp].to_i
        cpbusiness.SPNUMBER = @spbusiness.SPNUMBER
        cpbusiness.CMDTYPE = @spbusiness.CMDTYPE
        cpbusiness.PRICE = @spbusiness.PRICE
        cpbusiness.CPID = params[:cpid]
        cpbusiness.SPID = params[:spid]
        cpbusiness.REQUESTMETHOD = 0
        cpbusiness.INTERFACEURL = ""
        cpbusiness.URLTEMPLATE = "linkid=$(LINKID)&content=$(MOCMD)&spnumber=$(SPNUMBER)&mobile=$(PHONE)&sendtime=$(MOTIME)&status=DELIVRD&feeprice=100"
        cpbusiness.save!

        respond_to do |format|
          format.html { redirect_to "/cp_business/configure/#{cpbusiness.ID}"}
        end
        return 
      end
    end

    respond_to do |format|
      format.html { render :inline => "create cp business failed."}
    end
  end

  def configure
    cpbiz = CpBusiness.find(params[:id])
    @cpbusiness = {
      "id"     => cpbiz.ID,
      "cpname" => cpbiz.cpinfo.CPNAME,
      "spname" => cpbiz.spinfo.SPNAME,
      "cmd"    => cpbiz.CMD,
      "status" => cpbiz.STATUS,
      "spnumber" => cpbiz.SPNUMBER,
      "pay_percent" => cpbiz.PAYPRCT,
      "dis_percent" => cpbiz.DISCOUNTPRCT,
      "interface_url" => cpbiz.INTERFACEURL,
      "url_template" => cpbiz.URLTEMPLATE,
      "report_valid" => cpbiz.REPORTVALID,
      "request_method" => cpbiz.REQUESTMETHOD,
      "price" => cpbiz.PRICE
    }
  end

  def occupied
    @spbusiness = SpBusiness.find_by_SPID params[:spid]

    cmd = ""
    unless @spbusiness.nil?
      cmd = params[:cmd].blank? ? @spbusiness.CMD : @spbusiness.CMD + params[:cmd]
    end

    ret = CpBusiness.business_cmd_occupied? @spbusiness.SPID, @spbusiness.SPNUMBER, cmd

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

  def submit_configure
    cpbusiness = CpBusiness.find(params[:id])
    unless cpbusiness.nil?
      cpbusiness.PAYPRCT = params[:pay_percent].to_i
      cpbusiness.DISCOUNTPRCT = params[:dis_percent].to_i
      cpbusiness.STATUS = params[:enabled].blank? ? 0 : 1
      cpbusiness.REQUESTMETHOD = params[:request_method]
      cpbusiness.URLTEMPLATE = params[:url_template]
      cpbusiness.INTERFACEURL = params[:interface_url]
      cpbusiness.REPORTVALID = params[:report_valid]
      cpbusiness.save!
    end
    respond_to do |format|
      format.html { redirect_to :action => "list"}
    end
  end

  def list_for_table
    respond_to do |format|
      format.html
      format.xml
      format.json { render json: Datatable::CpBusinessTable.new(view_context)}
    end
  end

end
