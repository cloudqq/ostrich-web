class CpPolicyController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_foud
    render :text=> 'policy record was not found.'
  end


  def create
      if params[:id].blank?
        render :text => 'not found cp business id.'
        return
      end

      policy = CpPolicy.new
      policy.CP_BUSINESS_ID = params[:id]
      policy.ENABLED = 1
      policy.save

      redirect_to :action => 'configure', :id => policy.id
  end

  def update
  end

  def destroy
  end

  def list
  end

  def show
  end

  #@param
  # id is cp_business_id
  def new

  end

  def configure
    if params[:id].blank?
      respond_to do |format|
        format.html { render :inline => 'require policy id.' }
      end

    else
      @policy = CpPolicy.find(params[:id])
    end
  end
end
