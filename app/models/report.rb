class Report < ActiveRecord::Base
  self.table_name = "SP_REPORT"
  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  belongs_to :cpinfo, :class_name => 'CpInfo', :foreign_key => 'CPID'
  belongs_to :spbusiness, :class_name => 'SpBusiness', :foreign_key => 'SP_BUSINESS_ID'
  belongs_to :cpbusiness, :class_name => 'CpBusiness', :foreign_key => 'CP_BUSINESS_ID'
end
