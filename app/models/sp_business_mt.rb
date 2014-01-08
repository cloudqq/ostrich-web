# -*- coding: utf-8 -*-
class SpBusinessMt< ActiveRecord::Base
  self.table_name = 'SP_BUSINESS_MT'

  MT_TYPE = {
    :mt => 0,
    :twice_mt => 1
  }
  scope  :all_mt, where(MT_TYPE: MT_TYPE[:mt])
  scope  :all_twice_mt, where(MT_TYPE: MT_TYPE[:twice_mt])

  def self.list_for_table params
    per_page = params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    page = params[:iDisplayStart].to_i / per_page + 1
    sort_direction = params[:sSortDir_0] == "desc" ? "desc" : "asc"

    conditions = " 1=1 "
    conditions = conditions << " SP_BUSINESS_ID = #{params[:sp_business_id]} " unless params[:sp_business_id].blank?

    fields = %w(
             ID
             MT_CONTENT
             SP_BUSINESS_ID
    )
    return [
            SpBusinessMt.where(conditions).count,
            SpBusinessMt.select(fields).where(conditions).page(page).per_page(per_page)
    ]
  end
end
