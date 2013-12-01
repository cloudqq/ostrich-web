require 'spec_helper'

describe CpBusinessController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'list'" do
    it "returns http success" do
      get 'list'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'configure'" do
    it "returns http success" do
      get 'configure'
      response.should be_success
    end
  end

  describe "GET 'submit_configure'" do
    it "returns http success" do
      get 'submit_configure'
      response.should be_success
    end
  end

end
