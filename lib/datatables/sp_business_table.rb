# -*- coding: utf-8 -*-
require File.expand_path('../base',__FILE__)

module Datatable
  class SpBusinessTable < Base
    def initialize(view)
      super
      self.model = SpBusiness
    end

    def data
      result = []
      fetch_data.each do |x|
        result << [x.BUSINESSID,x.SPID, x.SPNUMBER,x.CMD,x.CREATETIME, "操作"]        
      end
      return result
    end
  end
end
