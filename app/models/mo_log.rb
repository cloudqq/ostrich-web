class MoLog < ActiveRecord::Base
  self.table_name = "SP_MOLOG"
  self.primary_key = "LINKID"
  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  belongs_to :cpinfo, :class_name => 'CpInfo', :foreign_key => 'CPID'
  has_one :mrlog, :class_name => 'MrLog', :foreign_key => 'LINKID'
  has_one :router, :class_name => 'SpRouter', :primary_key => 'TELESEG', :foreign_key => 'TELSEG'
end
