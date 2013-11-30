# -*- coding: utf-8 -*-
class SpInfoTable
  delegate :params , :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecord: SpInfo.count,
      iTotalDisplayRecords: SpInfo.count,
      aaData: data
    }
  end

private

  def data
    result = []
    sp_info_list.each do |x|
      result << [x.SPID, x.SPNAME,x.PAYPERIOD,x.CREATETIME, "操作"]
    end
    return result
  end

  def sp_info_list
    fetch_sp_info_list
  end

  def fetch_sp_info_list
    result = SpInfo.page(page).per_page(per_page)
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
