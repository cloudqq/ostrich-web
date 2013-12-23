class SysInfo < ActiveRecord::Base
  self.table_name = "SYS_INFO"
  self.primary_key= "ID"

  scope :provinces, where(INFO_TYPE: 'REGION', PARENT_ID: 0)
  scope :cities, lambda {|parent_id| where('PARENT_ID=?', parent_id)}
end
