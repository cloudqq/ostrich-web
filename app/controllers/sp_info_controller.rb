class SpInfoController < ApplicationController
  respond_to :html, :xml, :json

  def indexdata
    @infos = SpInfo.all
    @result = {'Result' => 'OK','Records' => @infos}
    respond_with(@result, :location=>nil)
  end

  def index

  end

  def update
  end

  def delete
  end

  def create
  end

end
