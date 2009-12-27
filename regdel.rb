# <!--
# Program: http://www.regdel.com
# Component: regdel.rb
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
require 'rubygems'
require 'sinatra/base'
require 'builder'
require 'xml/libxml'
require 'xml/libxslt'
require 'sass'
require 'rack/utils'
require 'rack/contrib'
require 'rack-rewrite'
require 'rack-xslview'
require 'rexml/document'
require 'rack-docunext-content-length'


require 'data/regdel-dm-modules'
require 'data/regdel_dm'
require 'data/account_types'
require 'helpers/xslview'


class Ledger
  # Called from a Ledger instance object, returns the ledger balance for that entry
  def running_balance
    thesql = "account_id = ? AND (posted_on < ? OR ( posted_on = ? AND ( amount < ?  OR ( amount = ? AND id < ?))))"
    presum = Ledger.all(:conditions => [thesql, self.account_id,  self.posted_on, self.posted_on, self.amount, self.amount, self.id] ).sum(:amount)
    return "%.2f" % ( (presum.to_i.to_r.to_d + self.amount) / 100)
  end
end


module Regdel
  
  class << self
    attr_accessor :uripfx
  end
  def self.new(uripfx='')
    self.uripfx = uripfx
    Main
  end

  class RdMoney < String
    def no_d
        return (self.gsub(/[^0-9\.]/,'').to_d * 100).to_i
    end
  end

  class Main < Sinatra::Base

    configure do
      # Prefixes for URI and Regdel directory
      @@dirpfx = File.dirname(__FILE__)
      @@xslt = ::XML::XSLT.new()
      @@xslt.xsl = REXML::Document.new File.open("#{@@dirpfx}/views/xsl/html_main.xsl")
    end

    use Rack::Config do |env|
      env['RACK_MOUNT_PATH'] = Regdel.uripfx
    end

    use Rack::Rewrite do
      rewrite Regdel.uripfx+'/ledger', '/s/xhtml/ledger.html'
      rewrite Regdel.uripfx+'/entry/new', '/s/xhtml/entry_all_form.html'
      rewrite %r{/entry/edit(.*)}, '/s/xhtml/entry_all_form.html'
      rewrite Regdel.uripfx+'/account/new', '/s/xhtml/account_form.html'
      rewrite %r{\.?/account/new(.*)}, '/s/xhtml/account_form.html'
      rewrite %r{/account/edit/(.*)}, '/s/xhtml/account_form.html?id=$1'
      rewrite Regdel.uripfx+'/', '/s/xhtml/welcome.html'
      rewrite Regdel.uripfx+'/account/new', '/s/xhtml/account_form.html'
    end

    use Rack::DocunextContentLength
    omitxsl = ['/raw/', '/s/js/', '/s/css/', '/s/img/']
    passenv = ['PATH_INFO', 'RACK_MOUNT_PATH']
    use Rack::XSLView, :myxsl => @@xslt, :noxsl => omitxsl, :passenv => passenv

    helpers Sinatra::XSLView
    set :static, true
    set :views, @@dirpfx + '/views'
    set :public, @@dirpfx + '/public'
    set :pagination, 10
    enable :sessions

    before do
      headers 'Cache-Control' => 'proxy-revalidate, max-age=300'
      if request.env['REQUEST_METHOD'].upcase == 'POST'
        rebuild_ledger
        Account.all.each do |myaccount|
          myaccount.update_ledger_balance
        end
      end
    end


    get '/accounts' do
      @my_account_types = @@account_types
      @accounts = Account.open
      accounts = builder :'xml/accounts'
      xslview accounts, @@dirpfx + '/views/xsl/accounts.xsl'
    end

    get '/json/account/:id' do
      content_type :json
      Account.get(params[:id]).to_json
    end

    post '/account/submit' do
        if params[:id].to_i > 0
            @account = Account.get(params[:id])
            @account.attributes = {
                :name => params[:name],
                :type_id => params[:type_id],
                :number => params[:number],
                :description => params[:description],
                :hide => params[:hide]
            }
            error_target = '/account/edit/' + params[:id]
        else
            @account = Account.new(
                :name => params[:name],
                :type_id => params[:type_id],
                :number => params[:number],
                :description => params[:description],
                :hide => params[:hide]
            )
            error_target = '/account/new'
        end
  
        if @account.save
          redirect Regdel.uripfx+'/accounts'
        else
          redirect error_target + '?error=' + handle_error(@account.errors)
        end
    end
    
    post '/account/close' do
        content_type 'application/xml', :charset => 'utf-8'
        @account = Account.get(params[:id])
        @account.attributes = {
            :closed_on => Time.now.to_i
        }
        if @account.save
            "<success>Success</success>"
        else
          handle_error(@account.errors)
        end
    end
    post '/account/reopen' do
        content_type 'application/xml', :charset => 'utf-8'
        @account = Account.get(params[:id])
        @account.attributes = {
            :closed_on => 0
        }
        if @account.save
            "<success>Success</success>"
        else
          handle_error(@account.errors)
        end
    end
    post '/account/delete' do
        content_type 'application/xml', :charset => 'utf-8'
        @account = Account.get(params[:id])
        if @account.destroy!
          redirect Regdel.uripfx+'/accounts'
        else
          handle_error(@account.errors)
        end
    end
    post '/entry/submit' do
        if params[:id].to_i > 0
          @entry = Entry.get(params[:id])
          @entry.attributes = {
            :memorandum => params[:memorandum]
          }
        else
          @entry = Entry.new(:memorandum => params[:memorandum])
        end
        @entry.save
        @entry.credits.destroy!
        @entry.debits.destroy!
        params[:credit_amount].each_index {|x|
          @myamt = @entry.credits.create(
            :amount => RdMoney.new(params[:credit_amount][x]).no_d,
            :account_id => params[:credit_account_id][x]
          )
          @myamt.save
        }
        params[:debit_amount].each_index {|x|
          @myamt = @entry.debits.create(
            :amount => RdMoney.new(params[:debit_amount][x]).no_d,
            :account_id => params[:debit_account_id][x]
          )
          @myamt.save
        }
        redirect Regdel.uripfx+'/journal'
    end

    get '/json/entry/:id' do
        content_type :json
        Entry.get(params[:id]).to_json(:relationships=>{:credits=>{:methods => [:to_usd]},:debits=>{:methods => [:to_usd]}})
    end
    get '/raw/xml/entry/:id' do
        content_type :xml
        Entry.get(params[:id]).to_xml(:relationships=>{:credits=>{:methods => [:to_usd]},:debits=>{:methods => [:to_usd]}})
    end
    get '/journal' do
        redirect Regdel.uripfx+'/journal/0'
    end
    get '/journal/:offset' do
      count = Entry.count()
      myoffset = params[:offset].to_i
      incr = options.pagination

      @myentries = Entry.all(:limit => options.pagination, :offset => myoffset)
      @prev = (myoffset - incr) < 0 ? 0 : myoffset - incr
      @next = myoffset + incr > count ? myoffset : myoffset + incr
      entries = builder :'xml/entries'
      xslview entries, @@dirpfx + '/views/xsl/entries_simpler.xsl'
    end
    get '/journal/full' do
      @myentries = Entry.all
      entries = builder :'xml/entries'
      xslview entries, @@dirpfx + '/views/xsl/entries.xsl'
    end

  
    get '/ledgers/account/:account_id' do
      @ledger_label = Account.get(params[:account_id]).name
      @ledger_type = "account"
      @mytransactions = Ledger.all(:account_id => params[:account_id],:order => [ :posted_on.desc,:amount.desc ])
      transactions = builder :'xml/transactions'
      xslview transactions, @@dirpfx + '/views/xsl/ledgers.xsl'
    end
    
    get '/stylesheet.css' do
      content_type 'text/css', :charset => 'utf-8'
      sass :'css/regdel'
    end
    
    not_found do
      headers 'Last-Modified' => Time.now.httpdate, 'Cache-Control' => 'no-store'
      '<p>This is nowhere to be found. <a href="/">Start over?</a></p>'
    end
    
    
    
    
    
    
    
    
    
    
    
    
    get '/raw/journal' do
        @myentries = Entry.all
        builder :'xml/journal_complete'
    end
    get '/raw/xml/ledger' do
      @ledger_label = "General"
      @ledger_type = "general"
      @mytransactions = Ledger.all( :order => [ :posted_on.desc ])
      transactions = builder :'xml/transactions'
    end
    get '/raw/entries' do
        content_type 'application/xml', :charset => 'utf-8'
        @myentries = Entry.all
        builder :'xml/entries'
    end
    get '/raw/transactions' do
      content_type 'application/xml', :charset => 'utf-8'
      @mytrans = Ledger.all
      @mytrans.to_xml
    end
    get '/raw/account/select' do
      content_type 'application/xml', :charset => 'utf-8'
      @accounts = Account.open
      builder :'xml/account_select'
    end
    get '/raw/accounts' do
      Account.get(1).update_ledger_balance
      content_type 'application/xml', :charset => 'utf-8'
      @my_account_types = @@account_types
      @accounts = Account.open
      builder :'xml/accounts'
    end
    get '/raw/ledger' do
      @ledger_label = "General"
      @ledger_type = "general"
      @mytransactions = Ledger.all( :order => [ :posted_on.desc ])
      transactions = builder :'xml/transactions'
      xslview transactions, @@dirpfx + '/views/xsl/ledgers.xsl'
    end

    delete '/delete/ledger' do
      rebuild_ledger
      redirect '/ledger'
    end
    
    
    private
    # This rebuild the ledger useing data from the journal
    def rebuild_ledger

      ledgerfile = "#{@@dirpfx}/public/s/xhtml/ledger.html"
      if File.exists?(ledgerfile)
        File.delete(ledgerfile)
      end
      
      Ledger.all.destroy!
      amounts = Amount.all
      
      amounts.each do |myamount|
      
        myid = myamount.entry_id
        myentry = Entry.get(myid)
      
        newtrans = Ledger.new(
          :posted_on => myentry.entered_on,
          :memorandum => myentry.memorandum,
          :amount => myamount.amount,
          :account_id => myamount.account_id,
          :entry_id => myamount.entry_id,
          :entry_amount_id => myamount.id
          ).save
      end
      begin
        @ledger_label = "General"
        @ledger_type = "general"
        @mytransactions = Ledger.all( :order => [ :posted_on.desc ])
        transactions = builder :'xml/transactions'
        xhtmltransaction = xslview transactions, @@dirpfx + '/views/xsl/ledgers.xsl'
        myfile = File.new("#{@@dirpfx}/public/s/xhtml/ledger.html","w")
        myfile.write(xhtmltransaction)
        myfile.close
      rescue StandardError
        myfile.close
        File.delete(myfile)
        halt '<p> <a href="/">Error, start over?</a></p>'
      end
    end
    
    def handle_error(errors)
      myerrors = ""
      errors.each do |e|
        myerrors << e.to_s
      end
      return myerrors
    end
  end
end

if __FILE__ == $0
  Regdel.new('').run!
end

