require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'builder'
require 'xml/libxml'
require 'xml/libxslt'
require 'sass'

require 'data/regdel_dm'
require 'data/account_types'
require 'helpers/xslview'



module Regdel
  class Main < Sinatra::Base
    
    helpers Sinatra::XSLView
    set :static, true
    set :views, File.dirname(__FILE__) + '/views'
    set :public, File.dirname(__FILE__) + '/public'
    #set :dump_errors, false
    #set :raise_errors, true
    set :pagination, 10
    enable :sessions
    
    before do
      headers 'Cache-Control' => 'proxy-revalidate, max-age=1200'
      if request.env['REQUEST_METHOD'].upcase == 'POST'
        ledgerfile = "/var/www/dev/regdel/public/s/xhtml/ledger.html"
        if File.exists?(ledgerfile)
          puts File.delete(ledgerfile)
          puts request
        end
      end
    end
    get '/accounts' do
        @my_account_types = @@account_types
        @accounts = Account.open
        accounts = builder :'xml/accounts'
        xslview accounts, '/var/www/dev/regdel/views/xsl/accounts.xsl'
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
          redirect '/accounts'
        else
          myerrors = ""
          @account.errors.each do |e|
              myerrors << e.to_s
          end
          redirect error_target + '?error=' + myerrors
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
          myerrors = ""
          @account.errors.each do |e|
              myerrors << e.to_s
          end
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
          #puts x
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
        
        redirect '/journal'
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
        redirect '/journal/0'
    end
    get '/journal/:offset' do
      count = Entry.count()
      myoffset = params[:offset].to_i
      incr = options.pagination

      @myentries = Entry.all(:limit => options.pagination, :offset => myoffset)
      @prev = (myoffset - incr) < 0 ? 0 : myoffset - incr
      @next = myoffset + incr > count ? myoffset : myoffset + incr
      entries = builder :'xml/entries'
      xslview entries, '/var/www/dev/regdel/views/xsl/entries_simpler.xsl'
    end
    get '/journal/full' do
      @myentries = Entry.all
      entries = builder :'xml/entries'
      xslview entries, '/var/www/dev/regdel/views/xsl/entries.xsl'
    end

    get '/ledger' do
      @ledger_label = "General"
      @ledger_type = "general"
      @mytransactions = Ledger.all( :order => [ :posted_on.desc ])
      transactions = builder :'xml/transactions'
      xslview transactions, '/var/www/dev/regdel/views/xsl/ledgers.xsl'
    end

    get '/ledgers/account/:account_id' do
      @ledger_label = Account.get(params[:account_id]).name
      @ledger_type = "account"
      @mytransactions = Ledger.all(:account_id => params[:account_id],:order => [ :posted_on.desc,:amount.desc ])
      transactions = builder :'xml/transactions'
      xslview transactions, '/var/www/dev/regdel/views/xsl/ledgers.xsl'
    end
    
    get '/stylesheet.css' do
      content_type 'text/css', :charset => 'utf-8'
      sass :'css/regdel'
    end
    get '/journal_entry_form.css' do
      content_type 'text/css', :charset => 'utf-8'
      sass :'css/journal_entry_form'
    end
    
    error do
      'So what happened was...' + request.env['sinatra.error'].message
    end
    
    not_found do
      headers 'Last-Modified' => Time.now.httpdate, 'Cache-Control' => 'no-store'
      if (request.path_info == '/s/xhtml/ledger.html')
        myfile = File.new("/var/www/dev/regdel/public/s/xhtml/ledger.html","w")
        @ledger_label = "General"
        @ledger_type = "general"
        @mytransactions = Ledger.all( :order => [ :posted_on.desc ])
        transactions = builder :'xml/transactions'
        xhtmltransaction = xslview transactions, '/var/www/dev/regdel/views/xsl/ledgers.xsl'
        myfile.write(xhtmltransaction)
        myfile.close
        #redirect request.fullpath
        redirect '/ledger'
      end
      '<p>This is nowhere to be found. <a href="/">Start over?</a></p>'
    end
    
    
    
    
    
    
    
    
    
    
    
    
    get '/raw/journal' do
        @myentries = Entry.all
        builder :'xml/journal_complete'
    end
    get '/raw/ledger' do
      @ledger_label = "General"
      @ledger_type = "general"
      @mytransactions = Ledger.all( :order => [ :posted_on.desc ])
      transactions = builder :'xml/transactions'
      xslview transactions, '/var/www/dev/regdel/views/xsl/ledgers.xsl'
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
    get '/raw/json/transactions' do
      content_type :json
        @mytrans = Ledger.all
        @mytrans.to_json
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
    get '/raw/dm-init/accounts' do
        content_type :json
        @my_account_types = @@account_types
        @accounts = Account.open
        @accounts.to_json
    end
    
    
    
    
    
    # TESTS

    get '/raw/ledger' do
      @ledger_label = Account.get(params[:account_id]).name
      @ledger_type = "account"
      @mytransactions = Ledger.all(:account_id => params[:account_id],:order => [ :posted_on.asc ])
      transactions = builder :'xml/transactions'
      xslview transactions, '/var/www/dev/regdel/views/xsl/ledgers.xsl'
    end
    get '/raw/test' do
        content_type 'application/xml', :charset => 'utf-8'
        builder :'xml/test'
    end
    
    get '/raw/test/entries' do
        content_type 'application/xml', :charset => 'utf-8'
        @myentries = Entry.all(:limit => 4, :offset => 0)
        builder :'xml/entries_test_sum'
    end
    get '/raw/test/entries/:offset' do
        content_type 'application/xml', :charset => 'utf-8'
        @myentries = Entry.all(:limit => 4, :offset => params[:offset].to_i)
        builder :'xml/entries_test_sum'
    end
    get '/raw/test/entries2' do
        content_type 'application/xml', :charset => 'utf-8'
        @myentries = Entry.all
        @mycredits = Credit.all
        @mydebits = Debit.all
        builder :'xml/entries_test_big'
    end
    get '/raw/test/entries3' do
        content_type 'application/xml', :charset => 'utf-8'
        @myentries = Entry.all
        builder :'xml/entries_test_sum'
    end
    
    get '/raw/test/to_json' do
        content_type :json
        @myentries = Entry.all
        @myentries.to_json()
    end
    get '/raw/test/to_jsonassoc' do
        content_type :json
        @myentries = Entry.all
        @myentries.to_json(:methods => [:credits,:debits])
    end
    get '/raw/test/to_xml' do
        content_type 'application/xml'
        @myentries = Entry.all
        @myentries.to_xml()
    end
    get '/raw/test/to_xmlassoc' do
        content_type 'application/xml'
        @myentries = Entry.all
        @myentries.to_xml(:methods => [:credits,:debits])
    end
    
    
    
    
  end
end
