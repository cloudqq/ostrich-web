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
          "<a href=configure/#{x.CPID}>编辑</a>|<a href=/cp_info/change_password/#{x.CPID}>密码</a>"
        ]
      end
      return result
    end
  end
end
