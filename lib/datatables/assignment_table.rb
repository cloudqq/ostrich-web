# -*- coding: utf-8 -*-
require File.expand_path('../datatable_base',__FILE__)
require File.expand_path('../../../app/models/cp_business', __FILE__)

module Datatable
  class AssignmentTable
    delegate :params, :h, :link_to, :number_to_currency, to: :@view

    attr_accessor :total_count

    def initialize(view)
      @view = view
    end

    def data
      result = []
      fetch_data.each do |x|
        result << [
          x.spinfo.SPNAME,
          x.SPNUMBER,
          x.CMD,
          '',
          '0',
          '0',
          x.AREALIST,
          x.CMDTYPE,
          x.spinfo.SPID,
          x.ID
        ]
      end
      result
    end

    def fetch_data
      fields = %w(SPINFO.SPNAME SPNUMBER CMD AREALIST BUSINESSTYPE ISASSIGN STATUS PRICE CMDTYPE SPINFO.SPID)
      self.total_count = SpBusiness.count
      records = SpBusiness.select(fields).includes(:spinfo).page(page).per_page(per_page)
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
