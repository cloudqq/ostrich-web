class MrLog < ActiveRecord::Base
  self.table_name = "SP_MRLOG"
  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  belongs_to :cpinfo, :class_name => 'CpInfo', :foreign_key => 'CPID'
  belongs_to :spbusiness, :class_name => 'SpBusiness', :foreign_key => [:SPID,:BUSINESSID]
  belongs_to :molog, :class_name => 'MoLog', :foreign_key => 'LINKID'
end
