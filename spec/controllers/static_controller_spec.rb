require 'spec_helper'

describe StaticController do

  describe "GET 'start'" do
    it "returns http success" do
      get 'start'
      response.should be_success
    end
  end

  describe "GET 'not_found'" do
    it "returns http success" do
      get 'not_found'
      response.should be_success
    end
  end

end
