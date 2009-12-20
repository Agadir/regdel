require File.dirname(__FILE__) + '/spec_helper'

describe "Regdel" do
  include Rack::Test::Methods

  def app
    @app ||= Regdel::Main
  end

  it "should respond to /accounts" do
    get '/accounts'
    last_response.should be_ok
  end

  it "should respond to /json/account/1" do
    get '/json/account/1'
    last_response.should be_ok
  end
  it "should respond to /ledger" do
    get '/ledger'
    last_response.should be_ok
    last_response.body.should include("</html>")
  end
  it "should respond to /stylesheet.css" do
    get '/stylesheet.css'
    last_response.headers["Content-Type"].should == "text/css;charset=utf-8"
  end
end
