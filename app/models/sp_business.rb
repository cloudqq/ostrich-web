class SpBusiness < ActiveRecord::Base
  self.table_name = "SP_BUSINESS"

  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  has_many :cmd_usage, :class_name => 'CmdUsage', :foreign_key => 'ID'
  belongs_to :policy, :class_name => 'SpPolicy', :foreign_key => 'POLICY_ID'


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

  def self.list_for_table params
    per_page = params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    page = params[:iDisplayStart].to_i / per_page + 1
    sort_direction = params[:sSortDir_0] == "desc" ? "desc" : "asc"

      conditions = " 1 = 1 "
      conditions << " AND SP_INFO.SPNAME LIKE '%#{params[:spname]}%'" unless params[:spname].blank?
      conditions << " AND SP_INFO.SPID = #{params[:spid]}" unless params[:spid].blank?
      conditions << " AND SPNUMBER LIKE '%#{params[:spnumber]}%'" unless params[:spnumber].blank?
      conditions << " AND CMD LIKE '%#{params[:cmd]}%'" unless params[:cmd].blank?


        fields = %w(
          SP_INFO.SPNAME
          BUSINESSID
          BUSINESS_NAME
          SPNUMBER
          CMD
          CMDTYPE
          PRICE
          BUSINESSTYPE
          SP_BUSINESS.CREATETIME
          SP_BUSINESS.SPID
          ID
          ISASSIGN
          AREALIST
        )

      return [SpBusiness.select(fields).joins(:spinfo).where(conditions).count,
              SpBusiness.select(fields).joins(:spinfo).where(conditions).page(page).per_page(per_page)
             ]
  end
end
