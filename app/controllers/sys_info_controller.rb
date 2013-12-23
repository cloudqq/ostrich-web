class SysInfoController < ApplicationController
  def create
  end

  def update
  end

  def delete
  end

  def get_cities
    if params[:id].blank?
      render json: "{result: 'no id'}"
      return
    end
    list = SysInfo.select("ID,CONTEXT").where("PARENT_ID=#{params[:id]}")
    respond_to do |format|
      format.json { render json: list }
    end

  end

end
