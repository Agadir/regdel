###
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
##
require File.dirname(__FILE__) + '/spec_helper'

describe "Regdel" do
  include Rack::Test::Methods

  def app
    @app ||= Regdel.new('')
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end


  # JOURNAL TESTS
  it "should redirect from /journal" do
    get '/journal'
    follow_redirect!
    last_response.should be_ok
  end
  it "should respond to /journal/0" do
    get '/journal/0'
    last_response.should be_ok
  end

  it "should respond to /raw/journal" do
    get '/raw/journal'
    last_response.should be_ok
  end

  it "should respond to /raw/xml/ledger" do
    get '/raw/xml/ledger'
    last_response.should be_ok
  end
  it "should respond to /raw/transactions" do
    get '/raw/transactions'
    last_response.should be_ok
  end

  it "should respond to /json/entry/1" do
    get '/json/entry/1'
    last_response.should be_ok
  end
  it "should respond to /entry/edit/1" do
    get '/entry/edit/1'
    last_response.should be_ok
  end
  it "should respond to /raw/xml/entry/1" do
    get '/raw/xml/entry/1'
    last_response.should be_ok
  end
  
  
  # ACCOUNT TESTS
  it "should respond to /raw/account/select" do
    get '/raw/account/select'
    last_response.should be_ok
  end
  it "should respond to /json/account/1" do
    get '/json/account/1'
    last_response.should be_ok
  end
  it "should respond to /accounts" do
    get '/accounts'
    last_response.should be_ok
  end
  it "should respond to /raw/accounts" do
    get '/raw/accounts'
    last_response.should be_ok
  end
  it "should be able to create new account" do
    post '/account/submit', params={
      "name" => "Testing",
      "type_id" => 50000,
      "number" => 50013,
      "description" => "Test account"
    }
    follow_redirect!
    last_response.body.should include("</html>")
  end
  it "should be able to edit this account" do
    @account = Account.first(:name => "Testing")
    post '/account/submit', params={
      "id" => @account.id,
      "name" => "Testing OK",
      "type_id" => 50000,
      "number" => 50013,
      "description" => "Test account"
    }
    follow_redirect!
    last_response.body.should include("</html>")
  end
  it "should be able to delete that account" do
    @account = Account.first(:name => "Testing OK")
    post '/account/delete', params={
      "id" => @account.id
    }
    follow_redirect!
    last_response.body.should include("</html>")
  end
  it "should be able to close account" do
    post '/account/close', params={"id" => 1}
    last_response.body.should include("</success>")
  end
  it "should be able to reopen account" do
    post '/account/reopen', params={"id" => 1}
    last_response.body.should include("</success>")
  end
  it "should respond to /account/new" do
    get '/account/new'
    last_response.body.should include("</form>")
  end




  # LEDGER TESTS
  it "should respond to /ledger" do
    get '/ledger'
    last_response.body.should include("</html>")
  end
  it "should respond to /ledgers/account/1" do
    get '/ledgers/account/1'
    last_response.body.should include("</html>")
  end
  it "should rebuild ledger on post" do
    post '/'
    last_response.body.should include("</html>")
  end
  it "should be able to delete ledger" do
    delete '/delete/ledger'
    follow_redirect!
    last_response.body.should include("</html>")
  end
  it "should respond to /raw/ledger" do
    get '/raw/ledger'
    last_response.body.should include("General Ledger")
  end
  
  
  
  
  
  
  it "should respond to /stylesheet.css" do
    get '/stylesheet.css'
    last_response.headers["Content-Type"].should == "text/css;charset=utf-8"
  end
  
  it "should respond with not found to /sldkjhf94hg" do
    get "/skdfh43fh9hg"
    last_response.body.should include("This is nowhere to be found")
  end
end
