class CpPolicy < ActiveRecord::Base
  self.table_name = 'CP_POLICIES'
  self.primary_key = 'ID'

  belongs_to :cpbusiness, :class_name => 'CpBusiness', :foreign_key => 'CP_BUSINESS_ID'
end

