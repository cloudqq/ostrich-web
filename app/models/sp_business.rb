class SpBusiness < ActiveRecord::Base
  self.table_name = "SP_BUSINESS"

  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  has_many :cmd_usage, :class_name => 'CmdUsage', :foreign_key => 'ID'

  def self.assignment_for_table params

    per_page = params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    page = params[:iDisplayStart].to_i / per_page + 1
    sort_direction = params[:sSortDir_0] == "desc" ? "desc" : "asc"
    conditions = " 1=1 "
    conditions = conditions << " AND ID NOT IN ( SELECT SP_BUSINESS_ID FROM CMD_USAGE WHERE CMD_TYPE = 2) "

    fields = %w(
             SPINFO.SPNAME
             SPNUMBER
             CMD
             AREALIST
             BUSINESSTYPE
             ISASSIGN
             STATUS
             PRICE
             CMDTYPE
             SPINFO.SPID
    )
    return [
            SpBusiness.where(conditions).count,
            SpBusiness.select(fields).includes(:spinfo).where(conditions).page(page).per_page(per_page)
    ]
  end
end
