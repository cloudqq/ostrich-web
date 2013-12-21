# -*- coding: utf-8 -*-
require File.expand_path('../datatable_base',__FILE__)

module Datatable
  class ReportDetailTable
    delegate :params, :h, :link_to, :number_to_currency, to: :@view
    attr_accessor :total_count

    def initialize(view)
      @view = view
    end

    def data
      result = []
      fetch_data.each do |x|
        result << 
          {
            createtime: x.CREATETIME.strftime("%Y-%m-%d %T"),
            phonenumber: x.PHONENUMBER,
            content: x.CONTENT,
            linkid: x.LINKID,
            spname: x.SPNAME,
            cpname: x.CPNAME,
            status: x.STATUS,
            discount: x.ISDISCOUNT,
            cpid: x.CPID,
            spid: x.SPID
          }
      end
      result
    end

    def fetch_data
      unless params[:date].blank?
        sdate = "#{params[:date]} 00:00:01"
        edate = "#{params[:date]} 23:59:59"
      end

      conditions = " 1=1 "
      conditions << " AND SP_MOLOG.CREATETIME > '#{sdate}' AND SP_MOLOG.CREATETIME < '#{edate}' "
      conditions << " AND SP_INFO.SPNAME LIKE '%#{params[:spname]}%'" unless params[:spname].blank?
      conditions << " AND CP_INFO.CPNAME LIKE '%#{params[:cpname]}%'" unless params[:cpname].blank?
      conditions << " AND SP_MOLOG.PHONENUMBER LIKE '%#{params[:phone]}%'" unless params[:phone].blank?
      conditions << " AND SP_MOLOG.CONTENT LIKE '#{params[:cmd]}%'" unless params[:cmd].blank?

      fields = %w(
                   SP_MOLOG.CREATETIME
                   SP_MOLOG.SPNUMBER
                   SP_MOLOG.CONTENT
                   SP_MOLOG.PHONENUMBER
                   SP_MOLOG.SPID
                   SP_MOLOG.CPID
                   SP_MRLOG.LINKID
                   SP_INFO.SPNAME
                   CP_INFO.CPNAME
                   SP_MRLOG.STATUS
                   SP_MRLOG.ISDISCOUNT
                 )

      self.total_count = MoLog.select(fields).joins(:mrlog, :cpinfo,:spinfo).where(conditions).count
      records = MoLog.select(fields).joins(:mrlog, :cpinfo,:spinfo).where(conditions).order("CREATETIME DESC")
        .page(page)
        .per_page(per_page)
    end

    def as_json(options = {})
      mydata = data
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecord: self.total_count,
        iTotalDisplayRecords: self.total_count,
        aaData: mydata
      }
    end

    private
    include DataTableBase
  end
end

