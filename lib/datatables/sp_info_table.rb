# -*- coding: utf-8 -*-
require File.expand_path('../base' ,__FILE__)

module Datatable
  class SpInfoTable < Base
    def initialize(view)
      super
      self.model = SpInfo
    end

    def data
      result = []
      fetch_data.each do |x|
        result << 
        [
          x.SPID, 
          x.SPNAME,
          x.PAYPERIOD,
          x.CREATETIME,
          "<a href=configure/#{x.SPID}>配置</a>"
        ]
      end
      return result
    end
  end
end
