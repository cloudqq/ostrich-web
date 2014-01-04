class CpBusiness < ActiveRecord::Base
  self.table_name = "CP_BUSINESS"

  belongs_to :spinfo, :class_name => 'SpInfo', :foreign_key => 'SPID'
  belongs_to :cpinfo, :class_name => 'CpInfo', :foreign_key => 'CPID'
  belongs_to :spbusiness, :class_name => 'SpBusiness', :foreign_key => 'SP_BUSINESS_ID'

  scope :onlines, where(OFFLINE: 0) 

  def self.business_cmd_occupied? spid, spnumber, cmd
    where("SPID=?  and SPNUMBER=? and CMD=? and OFFLINE = 0",spid,spnumber,cmd).length > 0
  end

  def self.list_for_datatable params
    per_page = params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    page = params[:iDisplayStart].to_i / per_page + 1
    sort_direction = params[:sSortDir_0] == "desc" ? "desc" : "asc"

      conditions = " 1=1 "
      conditions << " AND CP_INFO.CPNAME LIKE '%#{params[:cpname]}%'" unless params[:cpname].blank?
      conditions << " AND SP_INFO.SPNAME LIKE '%#{params[:spname]}%'" unless params[:spname].blank?
      conditions << " AND SPNUMBER LIKE '%#{params[:spnumber]}%'" unless params[:spnumber].blank?
      conditions << " AND CMD LIKE '%#{params[:cmd]}%'" unless params[:cmd].blank?

      if params[:offline].blank?
        conditions << " AND OFFLINE = 0 "
      else
        conditions << " AND OFFLINE = 1 "
      end

      fields = %w(
          ID
          CP_INFO.CPNAME
          SP_INFO.SPNAME
          SPNUMBER
          CMD
          PRICE
          PAYPRCT
          DISCOUNTPRCT
          STATUS
          CREATETIME
          INTERFACEURL
          REPORTVALID
          REQUESTMETHOD
          URLTEMPLATE
          CPID
          SPID
          CMDTYPE
          POLICY_ID
      )

      return [CpBusiness.select(fields).includes(:cpinfo,:spinfo).where(conditions).count ,
       CpBusiness.select(fields).includes(:cpinfo, :spinfo).where(conditions)
        .page(page)
      .per_page(per_page)]
  end
end
