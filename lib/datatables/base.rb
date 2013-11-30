module Datatable
  class Base
    delegate :params, :h, :link_to, :number_to_currency, to: :@view
    attr_accessor :model

    def initialize(view, model)
      @view = view
      @model = model
    end

    def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecord: self.model.count,
      iTotalDisplayRecords: self.model.count,
      aaData: data
    }
    end

    def data


    end

    def fetch_data
      model.page(page).per_page(per_page)
    end

  private
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
end
