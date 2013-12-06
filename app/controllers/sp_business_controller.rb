require File.expand_path('../../../lib/datatables/sp_business_table',__FILE__)

class SpBusinessController < ApplicationController
  def create
    if params[:spid].blank?
      respond_to do |format|
        format.html {render :inline => 'failed to create sp business without spid.'}
      end
    end
    @spbusiness = SpBusiness.new
    @spbusiness.BUSINESSID = Serial.new_serial("BZ")
    @spbusiness.STATUS = 0
    @spbusiness.PRICE = 1
    @spbusiness.SPID = params[:spid]

    respond_to do | format|
      format.html
    end
  end

  def submit_create
    if params[:spid].blank?
      respond_to do |format|
        format.html { render :inline => "create sp business failed."}
      end
    end

    @spinfo = SpInfo.find(params[:spid])

    @spbusiness = SpBusiness.new
    @spbusiness.SPID = @spinfo.SPID
    @spbusiness.BUSINESSTYPE = @spinfo.ACCEPTTYPE
    @spbusiness.BUSINESSID = params[:input_businessid]
    @spbusiness.CMD = params[:input_cmd]
    @spbusiness.SPNUMBER = params[:input_spnumber]
    @spbusiness.CMDTYPE = params[:input_cmdtype].to_i
    @spbusiness.PRICE = params[:input_price].to_i
    @spbusiness.AREALIST = params[:input_arealist]
    @spbusiness.STATUS = params[:input_enabled].blank? ? 0: 1
    @spbusiness.save!

    respond_to do |format|
      format.html { render :action=> "list", :id => @spinfo.SPID }
    end
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


  def submit_configure
    if params[:id].blank?
      respond_to do |format|
        format.html { render :inline => "configure sp business failed without id." }
      end
    end
    @spbusiness = SpBusiness.find_by_ID params[:id]

    unless @spbusiness.nil?
      @spbusiness.CMD = params[:input_cmd]
      @spbusiness.CMDTYPE = params[:input_cmdtype].to_i
      @spbusiness.SPNUMBER = params[:input_spnumber]
      @spbusiness.PRICE = params[:input_price].to_i
      @spbusiness.STATUS = params[:input_enabled].blank? ? 0: 1
      @spbusiness.AREALIST = params[:input_arealist]
      @spbusiness.save!
    end

    respond_to do |format|
      format.html { render :action => "list" }
    end
  end


  def configure
    id = params[:id]
    @spbusiness = SpBusiness.find_by_ID id
  end
end
