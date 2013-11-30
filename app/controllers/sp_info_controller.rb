require File.expand_path('../../../lib/datatables/sp_info_table', __FILE__)

class SpInfoController < ApplicationController
  respond_to :html, :xml, :json

  def indexdata
    @infos = SpInfo.all
    @result = {'Result' => 'OK','Records' => @infos}
    respond_with(@result, :location=>nil)
  end

  def list_for_table
    respond_to do |format|
      format.html #
      format.xml { render :xml => @sp_infos }
      format.json {render json: Datatable::SpInfoTable.new(view_context, SpInfo)} 
    end
  end

  def index

  end

  def list

  end

  def update
  end

  def delete
  end

  def create

  end

  def submit_create_spinfo
    spname = params[:spname]
    info = SpInfo.new
    info.SPNAME = spname
    info.ACCEPTTYPE = 0
    info.CATAGORY = 0
    info.save!
    respond_to do |format|
      format.html { redirect_to :action => "list"}
    end

  end

end
