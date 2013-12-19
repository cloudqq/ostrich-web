class SpPolicyController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :policy_not_found

  def policy_not_found
    render :template => 'sp_policy/policy_not_found'
  end

  def create
    SpPolicy.new
    SpPolicy.SP_BUSINESS_ID = params[:id]
    SpPolicy.ENABLED = 1
    SpPolicy.save

    redirect_to :action=> 'configure', :id=> params[:id]
  end

  def update
  end

  def destroy
  end

  def list
  end

  def show
  end

  def configure
    if (params[:id].blank?)
      respond_to do |format|
        format.html { render :text => 'not sp policy id was found.'}
      end
      return
    end

    @policy = SpPolicy.find_by_SP_BUSINESS_ID(params[:id])

    if @policy.nil?

    end

  end
end
