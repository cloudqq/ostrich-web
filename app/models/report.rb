class Report < ActiveRecord::Base
  self.table_name = "SP_REPORT"
  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  belongs_to :cpinfo, :class_name => 'CpInfo', :foreign_key => 'CPID'
  belongs_to :spbusiness, :class_name => 'SpBusiness', :foreign_key => [:SPID,:BUSINESSID]
end
