# -*- coding: utf-8 -*-
require File.expand_path('../base',__FILE__)

module Datatable
  class CpBusinessTable < Base
    def initialize(view)
      super
      self.model = CpBusiness
    end

    def data
      result = []
      fetch_data.each do |x|
        result <<
          [
          x.ID,
          x.CMD,
          x.CPID,
          x.SPID,
          x.BUSINESSID,
          x.CMDTYPE,
          x.PAYPRCT,
          x.DISCOUNTPRCT,
          x.STATUS,
          x.CMD,
          x.CREATETIME.strftime("%Y-%m-%d"), 
          "<a href=/cp_business/configure/#{x.ID}>配置</a>"
        ]
      end
      return result
    end
  end
end
