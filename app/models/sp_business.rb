class SpBusiness < ActiveRecord::Base
  self.table_name = "SP_BUSINESS"
  self.primary_keys = [ :SPID, :BUSINESSID]

end
