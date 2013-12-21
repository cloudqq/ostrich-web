class CpPolicyItem < ActiveRecord::Base
  self.table_name = 'CP_POLICY_ITEMS'
    belongs_to :policy, :class_name=> 'CpPolicy', :foreign_key => 'POLICY_ID'

  def self.province_exsit?(cp_business_id, province)
     found = CpPolicyItem.joins(:policy).where("CP_POLICIES.CP_BUSINESS_ID=#{cp_business_id} AND TARGET='#{province}'")
     return found.length > 0
  end
end
