class CpBusiness < ActiveRecord::Base
  self.table_name = "CP_BUSINESS"

  def self.business_cmd_occupied? spid, cmd
    where("SPID=? and CMD=?",spid,cmd).length > 0
  end
end
