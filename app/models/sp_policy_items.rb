# -*- coding: utf-8 -*-
class SpPolicyItems< ActiveRecord::Base
  self.table_name = 'SP_POLICY_ITEMS'
  self.primary_key = 'ID'


  # 二次类型,默认为无
  TWICE_TYPE = {
    :default => 0,          # 无二次
    :reply_any => 1,        # 回复任意
    :reply_specific = 2,    # 回复特定
    :dynmic_question => 3,  # 智能问答
    :unknown =>4            # 未分类
  }
end
