class SpBusiness < ActiveRecord::Base
  self.table_name = "SP_BUSINESS"

  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
end
