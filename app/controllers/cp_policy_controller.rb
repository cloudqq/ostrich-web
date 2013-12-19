class CpPolicyController < ApplicationController
  def create

  end

  def update
  end

  def destroy
  end

  def list
  end

  def show
  end

  def new
    id = params[:id]

    if Policy.find_by_CP_BUSINESS_ID(id) != nil
      respond_to do |format|
        format.html { render :text => "policy existed."}
      end
      return
    end

    p = CpPolicy.new
    p.CP_BUSINESS_ID = id
    p.ENABLED = 0
    p.save

    respond_to do |format|
      format.html { redirect_to "/policy/configure/#{id}"}
    end

  end

  def configure
    if params[:id].blank?
      respond_to do |format|
        format.html { render :inline => 'not find cp business.' }
      end

    else
      policy = CpPolicy.find_by_CP_BUSINESS_ID params[:id]
      if policy.nil?
        respond_to do |format|
          format.html { redirect_to "/policy/create/#{params[:id]}"}
        end
      else



      end
    end
  end
end
