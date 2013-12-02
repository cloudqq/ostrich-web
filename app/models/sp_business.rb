class SpBusiness < ActiveRecord::Base
  self.table_name = "SP_BUSINESS"
  self.primary_keys = [ :SPID, :BUSINESSID]

  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
end
