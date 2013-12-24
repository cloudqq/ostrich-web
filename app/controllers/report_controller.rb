# -*- coding: utf-8 -*-
require File.expand_path('../../../lib/datatables/report_stat_table',__FILE__)
require File.expand_path('../../../lib/datatables/report_detail_table',__FILE__)
require 'iconv'
class ReportController < ApplicationController
#  before_filter :authenticate_user!
  # before_filter :authenticate_admin!
  # before_filter do
  #   redirect_to "/" unless current_admin && admin_signed_in?
  # end

  respond_to :html, :xml, :json
  def moindex
    @mologs = MrLog.includes(:spinfo).limit(10)
    list = []
    @mologs.each do |item| 
      obj = {}
      obj['SPID'] = item['SPID']
      obj['SPNAME'] = item.spinfo['SPNAME']
      list << obj
    end
    @result = {'Result' => 'OK','Records' => list}
    respond_with(@result, :location=>nil)
  end

  def mo
  end

  def mt
  end
  
  def export_detail
    conditions = " 1=1 "
    if params[:sdate] && !params[:sdate].blank?
      t1 = Time.parse(params['sdate'])
    else
      t1 = Time.now
    end
    t1 = t1.strftime("%Y-%m-%d")

    if params[:edate] && !params[:edate].blank?
      t2 = Time.parse(params['edate'])
    else
      t2 = Time.now
    end
    t2 = t2.strftime("%Y-%m-%d")

    conditions << " AND SP_MOLOG.CREATETIME > '#{t1}' AND SP_MOLOG.CREATETIME < '#{t2}' "

    conditions << " AND SP_INFO.SPNAME LIKE '%#{params[:spname]}%' " unless params[:spname].blank?

    conditions << " AND CP_INFO.CPNAME LIKE '%#{params[:cpname]}%' " unless params[:cpname].blank?
    @data = MoLog.select('SP_MOLOG.CREATETIME,SP_MOLOG.SPNUMBER,SP_MOLOG.CONTENT,SP_MOLOG.PHONENUMBER,SP_MOLOG.SPID,SP_MOLOG.CPID,SP_MRLOG.LINKID,SP_INFO.SPNAME AS SPNAME, CP_INFO.CPNAME AS CPNAME,SP_MRLOG.STATUS AS STATUS, SP_MRLOG.ISDISCOUNT AS ISDISCOUNT ')
                 .joins(:mrlog,:cpinfo,:spinfo)
                 .where(conditions)

    respond_to do | format|
      format.html
      format.xls do
        render :xls => @data, 
        :columns => [:CREATETIME,:SPID,:CPID,:SPNAME,:CPNAME,:PHONENUMBER,:CONTENT,:STATUS,:ISDISCOUNT],
        :headers => %w[ CreateTime SpId CpId SpName CpName Phone Content Status IsDiscount]
      end
    end
  end

  def get_detail_data

  end

  def detail

  end

  def alert
    @alerts = SpAlert.find(:all, :order=> 'CREATETIME DESC', :limit=>10)
    respond_with(@alerts)
  end

  # 按省份分组查询
  def view_by_province
    t = Time.now
    @now = t.strftime("%Y-%m-%d")
  end

  def stat_by_province
    conditions = " 1=1 "
    if params[:statdate] && !params[:statdate].blank?
      t = Time.parse(params['statdate'])
    else
      t = Time.now
    end
    t1 = t
    t1 = t1.strftime("%Y-%m-%d")
    t2 = t + 86400
    t2 = t2.strftime("%Y-%m-%d")
    conditions << " AND SP_MOLOG.CREATETIME > '#{t1}' AND SP_MOLOG.CREATETIME < '#{t2}' "

    if params[:spnumber] && !params[:spnumber].blank?
      spnumber_filter = params[:spnumber]
    else
      spnumber_filter = ""
    end

    @data = MoLog.select("SP_MOLOG.SPNUMBER, SP_MRLOG.VALID AS VALID, SP_ROUTER.PROVINCE AS PROVINCE, COUNT(1) AS CNT")
      .joins(:router, :mrlog)
      .where(conditions)
      .group("SP_MOLOG.SPNUMBER,SP_MRLOG.VALID, SP_ROUTER.PROVINCE")
      .order("SP_MOLOG.SPNUMBER, SP_ROUTER.PROVINCE")

    list = []
    last = nil
    @data.each do |x|
      next if !spnumber_filter.empty? && x.SPNUMBER != spnumber_filter
      if list.length > 0
        last = list.last
        if last[:spnumber] == x.SPNUMBER && last[:province] == x.PROVINCE
          last[:valid_count] += x.VALID == 1 ? x.CNT : 0
          last[:invalid_count] += x.VALID == 0 ? x.CNT : 0
        else
          obj = {
            :spnumber => x.SPNUMBER,
            :province => x.PROVINCE,
            :valid_count => x.VALID == 1 ? x.CNT : 0 ,
            :invalid_count => x.VALID == 0 ? x.CNT : 0
          }
          list << obj
        end
      else
        obj = {
          :spnumber => x.SPNUMBER,
          :province => x.PROVINCE,
          :valid_count => x.VALID == 1 ? x.CNT : 0,
          :invalid_count => x.VALID == 0 ? x.CNT : 0
        }
        list << obj
      end
    end

    @result = {'Result' => 'OK', 'Records' => list, 'TotalRecordCount' => list.length}
    respond_with(@result, :location => nil)
    return
   end

  def view_by_hour
    t = Time.now
    @now = t.strftime("%Y-%m-%d")
  end

  def stat_by_hour
    conditions = " 1=1 "
    if params[:statdate] && !params[:statdate].blank?
      t = Time.parse(params['statdate'])
    else
      t = Time.now
    end
    t1 = t
    t1 = t1.strftime("%Y-%m-%d")
    t2 = t + 86400
    t2 = t2.strftime("%Y-%m-%d")
    conditions << " AND SP_MOLOG.CREATETIME > '#{t1}' AND SP_MOLOG.CREATETIME < '#{t2}' "

    spnumber_filter = ""
    if params[:spnumber] && !params[:spnumber].blank?
      spnumber_filter = params[:spnumber]
    end

    @data = MoLog.select("HOUR(SP_MRLOG.CREATETIME) HOUR,SP_MOLOG.SPNUMBER, COUNT(1) AS CNT").joins(:mrlog).where(conditions).group("HOUR(SP_MRLOG.CREATETIME),SP_MOLOG.SPNUMBER")

    list = []
    @data.each do |item|
      next if !spnumber_filter.empty? && item.SPNUMBER != spnumber_filter      
      obj = {
        :spnumber   => item['SPNUMBER'],
        :hour       => item['HOUR'],
        :count      => item['CNT']
      }
      list << obj
    end
    @result = {'Result' => 'OK', 'Records' => list, 'TotalRecordCount' => list.length}
    respond_with(@result, :location => nil)
  end

  def statdata
  end

  def stat
  end

  def ivr
  end

  def list_detail_for_table
    respond_to do |format|
      format.json {render json: Datatable::ReportDetailTable.new(view_context)}
    end
  end

  def list_stat_for_table
    respond_to do |format|
      format.json {render json: Datatable::ReportStatTable.new(view_context) }
    end
  end
end
