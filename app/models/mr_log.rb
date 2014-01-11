# -*- coding: utf-8 -*-
class MrLog < ActiveRecord::Base
  self.table_name = "SP_MRLOG"
  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  belongs_to :cpinfo, :class_name => 'CpInfo', :foreign_key => 'CPID'
  belongs_to :spbusiness, :class_name => 'SpBusiness', :foreign_key => [:SPID,:BUSINESSID]
  belongs_to :molog, :class_name => 'MoLog', :foreign_key => 'LINKID'

  # 查询某天的运行状况
def self.province_status_for_table params
  per_page = params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  page = params[:iDisplayStart].to_i / per_page + 1
  sort_direction = params[:sSortDir_0] == "desc" ? "desc" : "asc"

  start_date = Time.now.strftime("%F")+" 00:00:01"
  end_date = Time.now.strftime("%F") + " 23:59:59"

  unless params[:date].blank?
    start_date = params[:date] + " 00:00:01"
    end_date = params[:date] + "23:59:59"
  end

  conditions = " 1 = 1 "
  conditions = conditions << " AND SP_MRLOG.STATUS = 'DELIVRD' "
  conditions = conditions << " AND SP_MOLOG.CREATETIME > '#{start_date}' AND SP_MOLOG.CREATETIME < '#{end_date}' "
  conditions = conditions << " AND SP_MOLOG.PROVINCE LIKE '%#{params[:province]}%' " unless params[:province].blank?
  conditions = conditions << " AND SP_MOLOG.SPNUMBER LIKE '%#{params[:spnumber]}%' " unless params[:spnumber].blank?
  conditions = conditions << " AND CP_INFO.CPNAME like '%#{params[:cpname]}%' " unless params[:cpname].blank?
  conditions = conditions << " AND SP_INFO.SPNAME like '%#{params[:spname]}%' " unless params[:spname].blank?
  conditions = conditions << " AND SP_MOLOG.CONTENT like '%#{params[:cmd]}%' " unless params[:cmd].blank?

  group_by = %w(
    SP_MOLOG.SPID
    SP_MOLOG.CPID
    SP_MOLOG.SPNUMBER
    SP_MOLOG.CONTENT
    SP_MOLOG.PROVINCE
  )

  order_by = %w(
    SP_MOLOG.CPID
    SP_MOLOG.PROVINCE
  )

  fields = %w(
    SP_MOLOG.SPID
    SP_MOLOG.CPID
    CP_INFO.CPNAME
    SP_INFO.SPNAME
    SP_MOLOG.SPNUMBER
    SP_MOLOG.CONTENT
    SP_MOLOG.PROVINCE
    COUNT(1)\ AS\ MO
    CAST(SUM(IF(SP_MOLOG.DISCOUNT=1,1,0))\ AS\ SIGNED)\ AS\ DISCOUNT
    CAST(SUM(IF(SP_MRLOG.FORWARD=0,1,0))\ AS\ SIGNED)\ AS\ NOT_FORWARD
    CAST(SUM(IF(SP_MRLOG.DISPATCH=1,1,0))\ AS\ SIGNED)\ AS\ DISPATCHED
  )

  return [
    MrLog.select(fields)
    .joins(:molog,:cpinfo,:spinfo)
    .where(conditions)
    .group(group_by).length ,
  MrLog.select(fields)
    .joins(:molog,:cpinfo,:spinfo)
    .where(conditions)
    .group(group_by)
    .order(order_by)
    .page(page)
    .per_page(per_page)
  ]
end


end
