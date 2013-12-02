require File.expand_path('../../../lib/datatables/sp_business_table',__FILE__)

class SpBusinessController < ApplicationController
  def create
  end

  def list
    @spid = params[:id]
  end

  def list_for_table
    respond_to do |format|
      format.html #
      format.xml { render :xml => @sp_infos }
      format.json {render json: Datatable::SpBusinessTable.new(view_context)} 
    end
  end

  def destroy
  end

  def update
  end

  def configure
    id = params[:id]
    @sp_business = SpBusiness.find_by_ID id
  end
end
