class CpPolicyItem < ActiveRecord::Base
  self.table_name = 'CP_POLICY_ITEMS'
    belongs_to :policy, :class_name=> 'CpPolicy', :foreign_key => 'POLICY_ID'

  def self.province_exsit?(policy_id, province)
     found = CpPolicyItem.joins(:policy).where("CP_POLICIES.ID=#{policy_id} AND TARGET='#{province}'")
     return found.length > 0
  end
end
