require 'spec_helper'

describe CpPolicyItemController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'submit_create'" do
    it "returns http success" do
      get 'submit_create'
      response.should be_success
    end
  end

end
