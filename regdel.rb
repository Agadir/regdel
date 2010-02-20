###
# Program:: http://www.regdel.com
# Component:: regdel.rb
# Copyright:: Savonix Corporation
# Author:: Albert L. Lash, IV
# License:: Gnu Affero Public License version 3
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
require 'rubygems'
require 'sinatra/base'
require 'builder'
require 'xml/xslt'
require 'sass'
require 'grit'
include Grit
require 'rack/utils'
require 'rack/contrib'
require 'rack-rewrite'
require 'rack-xslview'
require 'rexml/document'

require 'data/regdel-dm-modules'
require 'data/regdel_dm'
require 'data/development'
require 'sinatra/xslview'

# The container for the Regdel application
module Regdel

  class << self
    # uripfx     the prefix before Regdel's paths
    # omitxsl    paths which should not be transformed by rack-xslview
    # passenv    env vars to pass to rack-xslview
    # dirpfx     directory where regdel is located
    # xslt       xslt object
    # xslfile    xsl file
    # started_at the time when regdel was started
    attr_accessor(:uripfx, :omitxsl, :passenv, :dirpfx, :xslt, :xslfile, :started_at)
  end

  # Set the uriprefix
  def self.new(uripfx='', dirpfx='/var/www/dev/regdel')
    self.uripfx = uripfx
    self.dirpfx = dirpfx
    Main
  end


  # The sub-classed Sinatra application
  class Main < Sinatra::Base

    # BEGIN sub-classed Sinatra app Configuration and Rack middleware usage
    configure do
      Regdel.dirpfx = File.dirname(__FILE__)
      set :static, true
      set :pagination, 10
      set :views, Regdel.dirpfx + '/views'
      set :xslviews, Regdel.dirpfx + '/views/xsl/'
      set :public, Regdel.dirpfx + '/public'

      # Set request.env with application mount path
      use Rack::Config do |env|
        env['RACK_MOUNT_PATH'] = Regdel.uripfx
        env['RACK_ENV'] = ENV['RACK_ENV'] ? ENV['RACK_ENV'] : 'none'
      end

      # Setup XSL - better to do this only once
      Regdel.xslt = XML::XSLT.new()
      Regdel.xslfile = File.open(Regdel.dirpfx + '/views/xsl/html_main.xsl')
      Regdel.xslt.xsl = REXML::Document.new Regdel.xslfile

      # Used in runtime/info
      Regdel.started_at = Time.now.to_i

      # Setup paths to remove from Rack::XSLView, and params to include
      Regdel.omitxsl = ['/raw/', '/s/js/', '/s/css/', '/s/img/']
      Regdel.passenv = ['PATH_INFO', 'RACK_MOUNT_PATH', 'RACK_ENV']
    end

    configure :production do
      set :cachem, 3
    end

    configure :development do
      Sinatra::Application.reset!
      use Rack::Lint
      use Rack::Reloader
      set :logging, false
      set :cachem, 1
    end

    configure :demo do
      use Rack::CommonLogger
      set :logging, true
      set :cachem, 6
    end
    # CLOSE Regdel Configuration

    # Rewrite app url patterns to static files
    use Rack::Rewrite do
      rewrite Regdel.uripfx+'/ledger', '/d/xhtml/ledger.html'
      rewrite Regdel.uripfx+'/entry/new', '/s/xhtml/entry_all_form.html'
      rewrite %r{#{Regdel.uripfx}/entry/edit(.*)}, '/s/xhtml/entry_all_form.html'
      rewrite Regdel.uripfx+'/account/new', '/s/xhtml/account_form.html'
      rewrite %r{#{Regdel.uripfx}/account/new(.*)}, '/s/xhtml/account_form.html'
      rewrite %r{#{Regdel.uripfx}/account/edit/(.*)}, '/s/xhtml/account_form.html?id=$1'
      rewrite Regdel.uripfx+'/', '/s/xhtml/welcome.html'
      rewrite Regdel.uripfx+'/account/new', '/s/xhtml/account_form.html'
      r301 Regdel.uripfx+'/journal', Regdel.uripfx+'/journal/0'
    end

    # Use Rack-XSLView
    use Rack::XSLView, :myxsl => Regdel.xslt, :noxsl => Regdel.omitxsl, :passenv => Regdel.passenv

    # Sinatra Helpers
    helpers Sinatra::XSLView

    before do
      # More aggressive cache settings for static files
      if request.env['REQUEST_URI']
        if request.env['REQUEST_URI'].include? '/s/'
          if request.env['HTTP_IF_MODIFIED_SINCE']
            headers 'Cache-Control' => "public, max-age=#{options.cachem*80}"
          else
            headers 'Cache-Control' => "public, max-age=#{options.cachem*40}"
          end
        elsif request.env['REQUEST_URI'].include? '/d/'
          headers 'Cache-Control' => "must-revalidate, max-age=#{options.cachem*10}"
        else
          headers 'Cache-Control' => "max-age=#{options.cachem}"
        end
      end

      # POSTs indicate data alterations, rebuild cache and semi-dynamic database entries
      if request.env['REQUEST_METHOD'].upcase == 'POST'
        rebuild_ledger(Regdel.dirpfx + '/public/d/xhtml/ledger.html')
        Account.all.each do |myaccount|
          myaccount.update_ledger_balance
        end
      end
    end


    # Sinatra Helpers
    #register Sinatra::Cache

    # This is causing a segmentation fault if lint or reloader is enabled
    # Otherwise it does work
    #set :cache_enabled, true
    #set :cache_page_extension, '.html'
    #set :cache_output_dir, 'd/'


    helpers do
      # Just the usual Sinatra redirect with App prefix
      def mredirect(uri)
        redirect Regdel.uripfx+uri
      end

      # Simple XML response
      def xresult(message)
        "<result>#{message}</result>"
      end

      # Create a new hash based upon an array of keys and the params hash
      def params2attrs(params,atts)
        phash = Hash.new
        atts.each {|attr|
          phash[attr] = params[attr]
        }
        return phash
      end

      # Transform amounts, in this case, convert to cents cents
      def amt_decentify(amt)
        return (amt.gsub(/[^0-9\.]/,'').to_d * 100).to_i
      end

      # General ledger in XML
      def general_ledger_xml
        @ledger_label = Ledger::GENERAL
        @ledger_type  = Ledger::GENTYPE

        @mytransactions = Ledger.all( :order => [ :posted_on.desc ] )
        transactionstbl = builder :'xml/transactions'
      end

      # Create debits and credits
      def posting_xacts(posting,params)
        params[:credit_amount].each_index {|x|
          myamt = posting.credits.create(
            :amount => amt_decentify(params[:credit_amount][x]),
            :account_id => params[:credit_account_id][x]
          )
          myamt.save
        }
        params[:debit_amount].each_index {|x|
          myamt = posting.debits.create(
            :amount => amt_decentify(params[:debit_amount][x]),
            :account_id => params[:debit_account_id][x]
          )
          myamt.save
        }
      end
    end


    get '/accounts' do
      @acctypes = Account::ACCTYPES
      @accounts = Account.open
      accounts  = builder :'xml/accounts'
      xslview accounts, 'accounts.xsl'
    end

    get '/json/account/:id' do
      content_type :json
      Account.get(params[:id]).to_json
    end

    post '/account/submit' do
      # Get record id and error root path
      account_id = params[:id].to_i
      error_path = '/account/'

      # If this is an existing object, retrieve it; otherwise, create a new one
      if account_id > 0
        @account = Account.get(account_id)
        error_path << 'edit/' << account_id
      else
        @account = Account.new
        error_path << 'new'
      end

      # Set object attributes with query parameters
      @account.attributes = params2attrs params, Account::PUB_ATTR

      if @account.save
        mredirect '/accounts'
      else
        mredirect error_path + '?error=' + handle_error(@account.errors)
      end
    end


    post '/account/modify/:operation' do
      content_type :xml
      if @account = Account.get(params[:id])
        if @account.send params[:operation]
          xresult 'Success'
        else
          handle_error(@account.errors)
        end
      else
        xresult Account::NOTFOUND
      end
    end


    post '/account/delete' do
      @account = Account.get(params[:id])
      if @account.destroy!
        mredirect '/accounts'
      else
        handle_error(@account.errors)
      end
    end


    post '/entry/submit' do

      # If this is an existing record, retrieve it; otherwise, create a new one
      if params[:id].to_i > 0
        @entry = Entry.get(params[:id])
        @entry.credits.destroy!
        @entry.debits.destroy!
      else
        @entry = Entry.new
      end
      @entry.attributes = { :memorandum => params[:memorandum] }
      @entry.save

      posting_xacts @entry, params
      mredirect '/journal'
    end


    get '/json/entry/:id' do
      content_type :json
      Entry.get(params[:id]).json_entry
    end


    get '/journal/:offset' do
      # Number of journal entries for use with paginator
      count = Entry.count()

      posi = params[:offset].to_i
      incr = options.pagination

      @myentries = Entry.all(:limit => incr, :offset => posi)
      @prev   = (posi - incr) < 0 ? 0 : posi - incr
      @next   = (posi + incr) > count ? posi : posi + incr
      entries = builder :'xml/entries'
      xslview entries, 'journal.xsl'
    end


    get '/ledgers/account/:account_id' do
      account_id = params[:account_id].to_i

      @ledger_label   = Account.get(account_id).name
      @ledger_type    = Ledger::ACCTYPE
      @mytransactions = Ledger.account_ledger(account_id)
      transactions    = builder :'xml/transactions'
      xslview transactions, 'ledgers.xsl'
    end


    get '/stylesheet.css' do
      content_type 'text/css', :charset => 'utf-8'
      sass 'css/regdel'.to_sym
    end

    not_found do
      headers 'Last-Modified' => Time.now.httpdate, 'Cache-Control' => 'no-store'
      %(<div class="block"><div class="hd"><h2>Error</h2></div><div class="bd">This is nowhere to be found. <a href="#{Regdel.uripfx}/">Start over?</a></div></div>)
    end




    get '/raw/journal' do
      content_type :xml
      @myentries = Entry.all
      builder :'xml/journal_complete'
    end
    get '/raw/xml/ledger' do
      content_type :xml
      general_ledger_xml
    end
    get '/raw/entries' do
      content_type :xml
      @myentries = Entry.all
      builder :'xml/entries'
    end
    get '/raw/account/select' do
      content_type :xml
      @accounts = Account.open
      builder :'xml/account_select'
    end
    get '/raw/accounts' do
      content_type :xml
      Account.get(1).update_ledger_balance
      @acctypes = Account::ACCTYPES
      @accounts = Account.open
      builder :'xml/accounts'
    end
    get '/raw/ledger' do
      # This isn't raw, it isn't cached
      xslview general_ledger_xml, 'ledgers.xsl'
    end

    delete '/delete/ledger' do
      # TODO Use Sinatra-Cache
      rebuild_ledger(Regdel.dirpfx + '/public/d/xhtml/ledger.html')
      mredirect '/ledger'
    end


    get '/regdel/runtime/info' do
      @uptime   = (0 + Time.now.to_i - Regdel.started_at).to_s
      runtime   = builder :'xml/runtime'
      xslview runtime, 'runtime.xsl'
    end


    private
    # This rebuilds a static file from updated dynamic data sets
    def rebuild_ledger(targetfile)

      if File.exists?(targetfile)
        File.delete(targetfile)
      end

      Ledger.all.destroy!
      # Data set from DataMapper
      amounts = Amount.all

      amounts.each do |myamount|

        myid    = myamount.entry_id
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

      general_ledger_html = xslview general_ledger_xml, 'ledgers.xsl'

      begin
        myfile = File.new(targetfile,'w')
        myfile.write(general_ledger_html)
        myfile.close
      rescue StandardError
        # Close file handle and then delete
        myfile.close
        File.delete(myfile)
        halt %(<p><a href="#{Regdel.uripfx}/">Error, start over?</a></p>)
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
  Regdel.new('','.').run!
end
