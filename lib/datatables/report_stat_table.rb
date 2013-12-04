# -*- coding: utf-8 -*-
require File.expand_path('../datatable_base',__FILE__)
require File.expand_path('../../../app/models/cp_business', __FILE__)

module Datatable
  class ReportStatTable
    delegate :params, :h, :link_to, :number_to_currency, to: :@view
    attr_accessor :total_count

    def initialize(view)
      @view = view
    end

    def data
      result = []
      fetch_data.each do |x|
        result << [
          x.STATDATE,
          x.SPID,
          x.spinfo.SPNAME,
          x.CPID,
          x.cpinfo.CPNAME,
          x.COUNT,
          x.spbusiness.nil? ? 0.0 : x.spbusiness.PRICE,
          "",
          x.VALIDCOUNT,
          ""
        ]
      end
      result
    end

    def fetch_data
      conditions = " 1=1 "
      conditions << " AND SP_INFO.SPNAME LIKE '%#{params[:spname]}%'" unless params[:spname].blank?
      conditions << " AND CP_INFO.CPNAME LIKE '%#{params[:cpname]}%'" unless params[:cpname].blank?
      conditions << " AND STATDATE  =  '#{params[:date]}'" unless params[:date].blank?
      if !params[:sdate].blank? && !params[:edate].blank?
        conditions << " AND STATDATE >= '#{params[:sdate]}' AND STATDATE <= '#{params[:edate]}' "
      end

      self.total_count = Report.includes(:spinfo, :cpinfo,:spbusiness).where(conditions).count
      records = Report.includes(:spinfo,:cpinfo,:spbusiness).where(conditions)
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

