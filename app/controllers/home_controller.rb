class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def user_dashboard
  end
  
  def admin_dashboard
  end
end
