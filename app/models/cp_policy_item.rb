class CpPolicyItem < ActiveRecord::Base
  self.table_name 'POLICY_ITEMS'
    belongs_to :policy, :class_name=> 'Policy', :foreign_key => 'POLIY_ID'
end