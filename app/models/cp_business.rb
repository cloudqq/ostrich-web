class CpBusiness < ActiveRecord::Base
  self.table_name = "CP_BUSINESS"

  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  belongs_to :cpinfo, :class_name => 'CpInfo', :foreign_key => 'CPID'

  def self.business_cmd_occupied? spid, cmd
    where("SPID=? and CMD=?",spid,cmd).length > 0
  end
end
