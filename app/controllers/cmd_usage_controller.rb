class CmdUsageController < ApplicationController
  respond_to :json

  def list
    @extra  = params[:sEcho].to_i
    @usages = CmdUsage.all
  end

  def get
  end
end
