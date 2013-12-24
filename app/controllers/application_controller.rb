class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_cache_strategy
  layout :layout_by_resource

  protected
  def layout_by_resource
    if devise_controller?
      "devise_layout"
    else
      "application"
    end
  end

  def set_cache_strategy
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end


end
