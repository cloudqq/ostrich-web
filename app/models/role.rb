# -*- coding: utf-8 -*-
class Role < ActiveRecord::Base
  ROLE_TYPE_ADMIN = 0           # 管理员用户
  ROLE_TYPE_USER  = 1           # 普通用户

  attr_accessible :created_at, :name, :type, :updated_at
end
