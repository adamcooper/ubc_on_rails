require 'spec_helper'

describe AboutController do

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'download'" do
    it "returns http success" do
      session[:has_rated] = true
      get 'download'
      response.should be_success
    end
    it "redirects if the user hasn't rated" do
      session[:has_rated] = nil
      get 'download'
      response.should be_redirect
    end
  end

end
