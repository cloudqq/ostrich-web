class CpBusiness < ActiveRecord::Base
  self.table_name = "CP_BUSINESS"

  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  belongs_to :cpinfo, :class_name => 'CpInfo', :foreign_key => 'CPID'
  belongs_to :spbusiness, :class_name => 'SpBusiness', :foreign_key => 'SP_BUSINESS_ID'

  scope :onlines, where(OFFLINE: 0) 

  def self.business_cmd_occupied? spid, spnumber, cmd
    where("SPID=?  and SPNUMBER=? and CMD=? and OFFLINE = 0",spid,spnumber,cmd).length > 0
  end
end
