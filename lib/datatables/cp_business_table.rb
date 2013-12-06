# -*- coding: utf-8 -*-
require File.expand_path('../datatable_base',__FILE__)

module Datatable
  class CpBusinessTable
    delegate :params, :h, :link_to, :number_to_currency, to: :@view

    attr_accessor :total_count

    def initialize(view)
      @view = view
    end

    def data
      result = []
      fetch_data.each do |x|
        result << {
          spname: x.spinfo.SPNAME,
          cpname: x.cpinfo.CPNAME,
          spnumber: x.SPNUMBER,
          cmd: x.CMD,
          cmdtype: x.CMDTYPE,
          price: x.PRICE,
          pay_percent: x.PAYPRCT,
          dis_percent: x.DISCOUNTPRCT,
          status: x.STATUS,
          createtime: x.CREATETIME.strftime("%Y-%m-%d"),
          options: "",
          interfaceurl: x.INTERFACEURL,
          report_valid: x.REPORTVALID,
          request_method: x.REQUESTMETHOD,
          url_template: x.URLTEMPLATE,
          cpid: x.CPID,
          spid: x.SPID,
          id: x.ID
        }
      end
      return result
    end

    def fetch_data

      conditions = " 1=1 "
      conditions << " AND CP_INFO.CPNAME LIKE '%#{params[:cpname]}%'" unless params[:cpname].blank?
      conditions << " AND SP_INFO.SPNAME LIKE '%#{params[:spname]}%'" unless params[:spname].blank?
      conditions << " AND SPNUMBER LIKE '%#{params[:spnumber]}%'" unless params[:spnumber].blank?
      conditions << " AND CMD LIKE '%#{params[:cmd]}%'" unless params[:cmd].blank?

      fields = %w(
          ID
          CP_INFO.CPNAME
          SP_INFO.SPNAME
          SPNUMBER
          CMD
          PRICE
          PAYPRCT
          DISCOUNTPRCT
          STATUS
          CREATETIME
          INTERFACEURL
          REPORTVALID
          REQUESTMETHOD
          URLTEMPLATE
          CPID
          SPID
          CMDTYPE
      )

      self.total_count = CpBusiness.select(fields).includes(:cpinfo,:spinfo).where(conditions).count
      records = CpBusiness.select(fields).includes(:cpinfo, :spinfo).where(conditions)
        .page(page)
        .per_page(per_page)
    end


    def as_json(options={})
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
