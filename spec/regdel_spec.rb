# <!--
# Program: http://www.regdel.com
# Component: regdel_spec.rb
# Copyright: Savonix Corporation
# Author: Albert L. Lash, IV
# License: Gnu Affero Public License version 3
# http://www.gnu.org/licenses
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, see http://www.gnu.org/licenses
# or write to the Free Software Foundation, Inc., 51 Franklin Street,
# Fifth Floor, Boston, MA 02110-1301 USA
# -->
require File.dirname(__FILE__) + '/spec_helper'

describe "Regdel" do
  include Rack::Test::Methods

  def app
    @app ||= Regdel.new('')
  end

  it "should respond to /accounts" do
    get '/accounts'
    last_response.should be_ok
  end
  it "should respond to /journal/0" do
    get '/journal/0'
    last_response.should be_ok
  end
  it "should respond to /journal/full" do
    get '/journal/full'
    last_response.should be_ok
  end

  it "should respond to /raw/journal" do
    get '/raw/journal'
    last_response.should be_ok
  end

  it "should respond to /raw/account/select" do
    get '/raw/account/select'
    last_response.should be_ok
  end
  it "should respond to /raw/accounts" do
    get '/raw/accounts'
    last_response.should be_ok
  end

  it "should respond to /json/account/1" do
    get '/json/account/1'
    last_response.should be_ok
  end
  it "should be able to delete ledger" do
    delete '/delete/ledger'
    follow_redirect!
    last_response.body.should include("</html>")
  end
  it "should respond to /ledger" do
    get '/ledger'
    last_response.body.should include("</html>")
  end
  it "should respond to /ledgers/account/1" do
    get '/ledgers/account/1'
    last_response.body.should include("</html>")
  end
  it "should respond to /account/new" do
    get '/account/new'
    last_response.body.should include("</form>")
  end
  it "should rebuild ledger on post" do
    post '/'
    last_response.body.should include("</html>")
  end
  it "should respond to /stylesheet.css" do
    get '/stylesheet.css'
    last_response.headers["Content-Type"].should == "text/css;charset=utf-8"
  end
end
