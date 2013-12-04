# -*- coding: utf-8 -*-
require File.expand_path('../base',__FILE__)

module Datatable
  class SpBusinessTable < Base
    def initialize(view)
      super
      self.model = SpBusiness
      if params[:spid].present?
        self.cause = "SPID = #{params[:spid]}"
      else
        self.cause = nil
      end
    end

    def data
      result = []
      fetch_data.each do |x|
        result << 
          [
          x.spinfo.SPNAME,
          x.BUSINESSID,
          x.SPNUMBER,
          x.CMD,
          x.PRICE,
          x.BUSINESSTYPE,
          x.CREATETIME.strftime("%Y-%m-%d"), 
          "<a href=/sp_business/configure/#{x.ID}>配置</a>",
          x.SPID, 
          x.CMDTYPE
        ]        
      end
      return result
    end
  end
end
