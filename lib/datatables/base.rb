require File.expand_path('../datatable_base',__FILE__)
module Datatable
  class Base
    delegate :params, :h, :link_to, :number_to_currency, to: :@view
    attr_accessor :model, :cause
    def initialize(view)
      @view = view
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
      if cause.nil?
        model.page(page).per_page(per_page)
      else
        model.page(page).per_page(per_page).where(cause)
      end
    end

  private
    include DataTableBase
  end
end
