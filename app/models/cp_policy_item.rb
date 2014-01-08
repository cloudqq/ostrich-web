class CpPolicyItem < ActiveRecord::Base
  self.table_name = 'CP_POLICY_ITEMS'

  belongs_to :policy, :class_name=> 'CpPolicy', :foreign_key => 'POLICY_ID'
  belongs_to :sysinfo, :class_name=> 'SysInfo', :foreign_key => 'SYS_INFO_ID'
  has_one :cpbusiness, :class_name => 'CpBusiness', :through => :policy

  scope :provinces, lambda {|policy_id| where("POLICY_ID=? AND PURGED=0 AND PARENT_ID=0", policy_id)}
  scope :cities, lambda{|policy_id, parent_id| where("POLICY_ID=? AND PURGED=0 AND PARENT_ID=?", policy_id, parent_id)}

  def self.province_exsit?(policy_id, province)
     found = CpPolicyItem.joins(:policy).where("CP_POLICIES.ID=#{policy_id} AND TARGET='#{province}' AND PURGED=0")
     return found.length > 0
  end

  def self.province(cp_info_id)
    conditions = " 1 = 1 "
    conditions = conditions << " AND CP_BUSINESS.CPID=#{cp_info_id}"

    fields = %w(
                 CP_POLICY_ITEMS.POLICY_ID
                 CP_POLICY_ITEMS.PARENT_ID
                 CP_POLICY_ITEMS.TARGET
                 CP_POLICY_ITEMS.HASH
                 CP_POLICY_ITEMS.ENABLED
                 CP_POLICY_ITEMS.LIMITED_DAY_MAX
                 CP_POLICY_ITEMS.LIMITED_MON_MAX
                 CP_POLICY_ITEMS.LIMITED_DAY_PHONE
                 CP_POLICY_ITEMS.LIMITED_MON_PHONE
                 CP_POLICY_ITEMS.CREATED_AT
                 CP_POLICY_ITEMS.UPDATED_AT
                 CP_BUSINESS.SPNUMBER,
                 CP_BUSINESS.CMD
    )
    CpPolicyItem.includes(:cpbusiness).where(conditions)
  end

  def self.province_for_table params
    per_page = params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    page = params[:iDisplayStart].to_i / per_page + 1
    sort_direction = params[:sSortDir_0] == "desc" ? "desc" : "asc"

    conditions = " 1 = 1 "
    conditions = conditions << " AND PURGED=0 AND PARENT_ID = 0"
    conditions = conditions << " AND CP_BUSINESS.CPID=#{params[:cp_id]}" unless params[:cp_business_id].blank?

    fields = %w(
                 CP_POLICY_ITEMS.POLICY_ID
                 CP_POLICY_ITEMS.PARENT_ID
                 CP_POLICY_ITEMS.TARGET
                 CP_POLICY_ITEMS.HASH
                 CP_POLICY_ITEMS.ENABLED
                 CP_POLICY_ITEMS.LIMITED_DAY_MAX
                 CP_POLICY_ITEMS.LIMITED_MON_MAX
                 CP_POLICY_ITEMS.LIMITED_DAY_PHONE
                 CP_POLICY_ITEMS.LIMITED_MON_PHONE
                 CP_POLICY_ITEMS.CREATED_AT
                 CP_POLICY_ITEMS.UPDATED_AT
                 CP_BUSINESS.SPNUMBER,
                 CP_BUSINESS.CMD
    )

    return [CpPolicyItem.includes(:cpbusiness).where(conditions).count,
            CpPolicyItem.includes(:cpbusiness).where(conditions)
                           .page(page)
                           .per_page(per_page)
           ]
  end

end
