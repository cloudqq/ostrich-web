# -*- coding: utf-8 -*-
require File.expand_path('../datatable_base',__FILE__)

module Datatable
  class SpBusinessTable 
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
            spname: x.SPNAME,
            businessid: x.BUSINESSID,
            spnumber: x.SPNUMBER,
            cmd: x.CMD,
            price: x.PRICE,
            businesstype: x.BUSINESSTYPE,
            createtime: x.CREATETIME.strftime("%Y-%m-%d"),
            options: "",
            spid: x.SPID,
            cmdtype: x.CMDTYPE,
            id: x.ID,
            isassign: x.ISASSIGN,
            arealist: x.AREALIST
          }
      end
      return result
    end

    def fetch_data
      conditions = " 1 = 1 "
      conditions << " AND SP_INFO.SPNAME LIKE '%#{params[:spname]}%'" unless params[:spname].blank?
      conditions << " AND SP_INFO.SPID = #{params[:spid]}" unless params[:spid].blank?
      conditions << " AND SPNUMBER LIKE '%#{params[:spnumber]}%'" unless params[:spnumber].blank?
      conditions << " AND CMD LIKE '%#{params[:cmd]}%'" unless params[:cmd].blank?

        fields = %w(
          SP_INFO.SPNAME
          BUSINESSID
          SPNUMBER
          CMD
          CMDTYPE
          PRICE
          BUSINESSTYPE
          SP_BUSINESS.CREATETIME
          SP_BUSINESS.SPID
          ID
          ISASSIGN
          AREALIST
        )

      self.total_count = SpBusiness.select(fields).joins(:spinfo).where(conditions).count
      records = SpBusiness.select(fields).joins(:spinfo).where(conditions)
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
