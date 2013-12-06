# -*- coding: utf-8 -*-
require File.expand_path('../datatable_base' ,__FILE__)

module Datatable
  class SpInfoTable
    delegate :params, :h, :link_to, to: :@view
    attr_accessor :total_count

    def initialize(view)
      @view = view
    end

    def data
      result = []
      fetch_data.each do |x|
        result <<
        {
          spid: x.SPID,
          spname: x.SPNAME,
          payperiod: x.PAYPERIOD,
          payperiodtype: x.PAYPERIODTYPE,
          catagory: x.CATAGORY,
          createtime: x.CREATETIME.strftime("%Y-%m-%d"),
          status: x.STATUS,
          options: "",
          mo_suffix: x.MOREQSUFFIX,
          mo_params: x.MOREQPRAMLIST,
          mr_suffix: x.MRREQSUFFIX,
          mr_params: x.MRREQPRAMLIST
        }
      end
      return result
    end

    def fetch_data

      conditions = " 1=1 "
      conditions << "AND SP_INFO.SPNAME LIKE '%#{params[:spname]}%'" unless params[:spname].blank?

      fields = %w(
        SPID
        SPNAME
        PAYPERIOD
        PAYPERIODTYPE
        ACCEPTTYPE
        CATAGORY
        CREATETIME
        STATUS
        MOREQSUFFIX
        MOREQPRAMLIST
        MRREQSUFFIX
        MRREQPRAMLIST
      )

      self.total_count = SpInfo.select(fields).where(conditions).count
      records = SpInfo.select(fields).where(conditions)
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

