require File.expand_path('../../../lib/datatables/cp_info_table', __FILE__)
require File.expand_path('../../../lib/datatables/assignment_table', __FILE__)

class CpInfoController < ApplicationController
  #before_filter :authenticate_user!
  def dashboard

  end

  def create

  end

  def submit_create
    cpinfo = CpInfo.new
    cpinfo.CPNAME = params[:cpname]
    cpinfo.LOGINNAME = params[:loginname]
    cpinfo.LOGINPASSWORD = params[:loginpassword]

    cpinfo.save!

    respond_to do | format|
      format.html { redirect_to :action => "list" }
    end
  end

  def list_for_table
    respond_to do |format|
      format.html
      format.xml
      format.json {render json: Datatable::CpInfoTable.new(view_context)}
    end
  end

  def list
  end

  def configure
    id = params[:id]
    @cp_info = CpInfo.find(id)
  end

  def submit_configure
    id = params[:id]
    enabled = params[:enabled]
    loginname = params[:loginname]
    loginpassword = params[:loginpassword]

    cpinfo = CpInfo.find(id)
    unless cpinfo.nil?
      cpinfo.LOGINNAME = loginname
      cpinfo.LOGINPASSWORD = loginpassword
      cpinfo.SYNC_URL = params[:sync_url] unless params[:sync_url].blank?
      cpinfo.STATUS = enabled.nil? ? 0 : 1

      cpinfo.save!
    end
    respond_to do |format|
      format.html { redirect_to :action => "list"}
    end
  end

  def list_for_assignment_table
    @extra = params[:sEcho].to_i
    count, @assignments = SpBusiness.assignment_for_table params
  end

  def cmd_assignment
  end

  def province

  end

  def province_for_table
    @extra = params[:sEcho].to_i
    count, @items = CpPolicyItem.province_for_table params
  end
end
