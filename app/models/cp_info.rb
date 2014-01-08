# -*- coding: utf-8 -*-
class CpInfo < ActiveRecord::Base
  self.table_name = "CP_INFO"
  self.primary_key = "CPID"

  validates :CPNAME,  :presence => { :message => "CP名称不能为空" }
  validates :LOGINNAME, :presence => { :message => "登录名称不能为空" }
  validates :LOGINPASSWORD, :presence => { :message => "密码不能为空" }
end
