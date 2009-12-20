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
end
