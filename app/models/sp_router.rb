class SpRouter < ActiveRecord::Base
  self.table_name = "SP_ROUTER"
  self.primary_key = "TELSEG"
  belongs_to :molog, :class_name => 'MoLog', :foreign_key => 'TELESEG'
end
