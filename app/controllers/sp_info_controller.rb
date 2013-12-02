require File.expand_path('../../../lib/datatables/sp_info_table', __FILE__)

class SpInfoController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
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
      format.json {render json: Datatable::SpInfoTable.new(view_context)} 
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

  def submit_create_and_configure_spinfo
    spname = params[:spname]
    info = SpInfo.new
    info.SPNAME = spname
    info.ACCEPTTYPE = 0
    info.CATAGORY = 0
    info.save!

    @sp_info = SpInfo.find(info.SPID)
  end

  def configure
    id = params[:id]
    @sp_info = SpInfo.find(id)
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

  def submit_configure
    id          = params[:id]
    accept_type = params[:accept_type]
    category    = params[:category]
    mo_suffix   = params[:mo_suffix]
    mr_suffix   = params[:mr_suffix]
    mo_params   = params[:mo_params]
    mr_params   = params[:mr_params]

    enabled = params[:enabled]

    spinfo = SpInfo.find(id)
    unless spinfo.nil?
      spinfo.ACCEPTTYPE = accept_type.to_i
      spinfo.CATAGORY = category.to_i
      spinfo.MOREQSUFFIX = mo_suffix
      spinfo.MRREQSUFFIX = mr_suffix
      spinfo.MOREQPRAMLIST = mo_params
      spinfo.MRREQPRAMLIST = mr_params

      if enabled != nil
        spinfo.STATUS = 1
      else
        spinfo.STATUS = 0
      end

      spinfo.save!
    end

    respond_to do | format|
      format.html { redirect_to :action => "list"}
    end
  end

   def record_not_found
     render text: "404 Not Found", status: 404
   end

end
