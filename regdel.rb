require 'rubygems'
require 'sinatra'
require 'builder'
require 'bigdecimal'
require 'bigdecimal/util'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-serializer'
require 'dm-aggregates'
require 'dm-validations'
require 'xml/libxml'
require 'xml/libxslt'
require 'json'

require 'data/regdel_dm'
require 'helpers/xslview'


class RdMoney < String
    def no_d
        return (self.gsub(/[^0-9\.]/,'').to_d * 100).to_i
    end
end

set :views, File.dirname(__FILE__) + '/views'
set :public, File.dirname(__FILE__) + '/public'
set :dump_errors, false
set :raise_errors, true


get '/accounts' do
    @accounts = Account.all(:closed_on => 0)
    accounts = builder :'xml/accounts'
    xslview accounts, '/var/www/dev/regdel/views/xsl/accounts.xsl'
end

get '/json/account/:id' do
    content_type :json
    Account.get(params[:id]).to_json
end

post '/account/submit' do
    if params[:id]
        @account = Account.get(params[:id])
        @account.attributes = {
            :name => params[:name],
            :number => params[:number],
            :description => params[:description]
        }
    else
        @account = Account.new(
            :name => params[:name],
            :number => params[:number],
            :description => params[:description]
        )
    end

    if @account.save
      redirect '/accounts'
    else
      myerrors = ""
      @account.errors.each do |e|
          myerrors << e.to_s
      end
      redirect '/account/new?error='+myerrors
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
    @entry = Entry.new(:memorandum => params[:memorandum])
    @entry.save
    @entry.credits.create(:amount => RdMoney.new(params[:credit]).no_d)
    @entry.debits.create(:amount => RdMoney.new(params[:debit]).no_d)
    redirect '/journal'
end

get '/journal' do
    @myentries = Entry.all
    entries = builder :'xml/entries'
    xslview entries, '/var/www/dev/regdel/views/xsl/entries.xsl'
end

get '/ledger' do
    @myentries = Entry.all
    entries = builder :'xml/entries'
    xslview entries, '/var/www/dev/regdel/views/xsl/entries.xsl'
end

error do
  'So what happened was...' + request.env['sinatra.error'].message
end

not_found do
    'This is nowhere to be found'
end
    
# TESTS


get '/raw/entries' do
    content_type 'application/xml', :charset => 'utf-8'
    @myentries = Entry.all
    builder :'xml/entries'
end
get '/raw/accounts' do
    content_type 'application/xml', :charset => 'utf-8'
    @accounts = Account.all
    builder :'xml/accounts'
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


