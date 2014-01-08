# -*- coding: utf-8 -*-
class SpPolicyItem< ActiveRecord::Base
  self.table_name = 'SP_POLICY_ITEMS'
  self.primary_key = 'ID'
  belongs_to :policy, :class_name => 'SpPolicy', :foreign_key => "POLICY_ID"
  belongs_to :sysinfo, :class_name => 'SysInfo', :foreign_key => 'SYS_INFO_ID'

  # 二次类型,默认为无
  TWICE_TYPE = {
    :default => 0,          # 无二次
    :reply_any => 1,        # 回复任意
    :reply_specific => 2,    # 回复特定
    :dynmic_question => 3,  # 智能问答
    :unknown =>4            # 未分类
  }

  scope :provinces, lambda {|policy_id| where("POLICY_ID=? AND PARENT_ID=0", policy_id)}
  scope :cities, lambda{|policy_id, parent_id| where("POLICY_ID=? AND PARENT_ID=?", policy_id, parent_id)}


  def self.province_exsit?(policy_id, province)
     found = SpPolicyItem.joins(:policy).where("SP_POLICIES.ID=#{policy_id} AND TARGET='#{province}'")
     return found.length > 0
  end

  def self.list_for_table params
    per_page = params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    page = params[:iDisplayStart].to_i / per_page + 1
    sort_direction = params[:sSortDir_0] == "desc" ? "desc" : "asc"

      conditions = " 1=1 AND PARENT_ID=0 AND PURGED=0"
      conditions << " AND SP_POLICY_ITEMS.POLICY_ID = #{params[:policy_id]} " unless params[:policy_id].blank?

      fields = %w(
                   SP_POLICY_ITEMS.ID
                   SP_POLICY_ITEMS.POLICY_ID
                   SP_POLICY_ITEMS.PARENT_ID
                   SP_POLICY_ITEMS.TARGET
                   SP_POLICY_ITEMS.HASH
                   SP_POLICY_ITEMS.ENABLED
                   SP_POLICY_ITEMS.LIMITED_DAY_MAX
                   SP_POLICY_ITEMS.LIMITED_MON_MAX
                   SP_POLICY_ITEMS.LIMITED_DAY_PHONE
                   SP_POLICY_ITEMS.LIMITED_MON_PHONE
                   SP_POLICY_ITEMS.TWICE_TYPE
                   SP_POLICY_ITEMS.CREATED_AT
                   SP_POLICY_ITEMS.UPDATED_AT
                 )

    return [SpPolicyItem.select(fields).joins(:policy).where(conditions).count,
      SpPolicyItem.select(fields).joins(:policy).where(conditions)
              .page(page)
              .per_page(per_page)
    ]
  end
end
