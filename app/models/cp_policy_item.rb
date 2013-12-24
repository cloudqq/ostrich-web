class CpPolicyItem < ActiveRecord::Base
  self.table_name = 'CP_POLICY_ITEMS'
    belongs_to :policy, :class_name=> 'CpPolicy', :foreign_key => 'POLICY_ID'

  scope :provinces, lambda {|policy_id| where("POLICY_ID=? AND PURGED=0 AND PARENT_ID=0", policy_id)}
  scope :cities, lambda{|policy_id, parent_id| where("POLICY_ID=? AND PURGED=0 AND PARENT_ID=?", policy_id, parent_id)}

  def self.province_exsit?(policy_id, province)
     found = CpPolicyItem.joins(:policy).where("CP_POLICIES.ID=#{policy_id} AND TARGET='#{province}' AND PURGED=0")
     return found.length > 0
  end
end
