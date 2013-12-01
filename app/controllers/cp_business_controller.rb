require File.expand_path('../../../lib/datatables/cp_business_table',__FILE__)
class CpBusinessController < ApplicationController
  def create
  end

  def list
  end

  def destroy
  end

  def update
  end

  def configure
  end

  def submit_configure
  end

  def list_for_table
    respond_to do |format|
      format.html
      format.xml
      format.json { render json: Datatable::CpBusinessTable.new(view_context)}
    end
  end

end
