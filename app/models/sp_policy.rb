class SpPolicy <ActiveRecord::Base
  self.table_name = 'SP_POLICIES'
  self.primary_key = 'ID'

  has_many :items, :class_name=>'SpPolicyItem', :foreign_key => "POLICY_ID"
end
