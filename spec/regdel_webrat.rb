# <!--
# Program: http://www.regdel.com
# Component: regdel_webrat.rb
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
require File.join(File.dirname(__FILE__), '..', 'regdel.rb')


require 'rubygems'
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
    @app ||= Regdel.new('')
  end

  def test_it_works
    visit "/"
    assert_have_selector("#ft")
  end

  def test_the_app
    visit "/ledger"
    assert_have_selector("#ft")
  end


  def test_new_account
    visit "/account/new"
    assert_have_selector(".form-table")
    assert_have_selector("#ft")
  end

  def test_new_account_public
    visit "/s/xhtml/account_form.html"
    assert_have_selector(".form-table")
    assert_have_selector("#ft")
  end
  
  def test_new_entry
    visit "/s/xhtml/entry_all_form.html"
    assert_have_selector("#memorandum")
    assert_have_selector("#ft")
  end

end
