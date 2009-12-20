require File.join(File.dirname(__FILE__), '..', 'regdel.rb')


require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'
require "webrat"
require "test/unit"

Webrat.configure do |config|
  config.mode = :rack
end

class RegdelTest < Test::Unit::TestCase
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    Regdel::Main
  end

  def test_it_works
    visit "/ledger"
    assert_contain("Savonix")
  end
end
