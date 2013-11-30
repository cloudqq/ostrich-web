# -*- coding: utf-8 -*-
require 'base'
module Datatable
  class SpInfoTable < Base
    def initialize(view, model)
      super
    end

    def data
      result = []
      fetch_data.each do |x|
        result << [x.SPID, x.SPNAME,x.PAYPERIOD,x.CREATETIME, "操作"]        
      end
      return result
    end
  end
end
