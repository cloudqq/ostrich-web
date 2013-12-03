# -*- coding: utf-8 -*-
require File.expand_path('../base' ,__FILE__)

module Datatable
  class CpInfoTable < Base
    def initialize(view)
      super
      self.model = CpInfo
    end

    def data
      result = []
      fetch_data.each do |x|
        result <<
        [
          x.CPID,
          x.LOGINNAME,
          x.CPNAME,
          x.STATUS,
          x.CREATETIME.strftime("%Y-%m-%d"),
          ""
        ]
      end
      return result
    end
  end
end
