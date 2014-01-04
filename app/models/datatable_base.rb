module DataTableBase
    def get_page(params)
      params[:iDisplayStart].to_i / per_page + 1
    end

    def get_per_page(params)
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_direction(params)
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
end
