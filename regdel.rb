require 'rubygems'
require 'sinatra'
require 'builder'
require 'bigdecimal'
require 'bigdecimal/util'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-serializer'
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


get '/accounts' do
    @myaccounts = Account.all
    accounts = @myaccounts.to_xml
    xslview accounts, '/var/www/dev/regdel/views/xsl/accounts.xsl'
end

post '/account-edit' do
  @account = Account.new(:name => params[:account_name])
  redirect '/accounts'
end

post '/entry/new' do
    @entry = Entry.new(:memorandum => params[:memorandum])
    @entry.save
    @entry.credits.create(:amount => RdMoney.new(params[:credit]).no_d)
    @entry.debits.create(:amount => RdMoney.new(params[:debit]).no_d)
    redirect '/entries'
end

get '/journal' do
    @myentries = Entry.all
    entries = builder :'xml/entries'
    xslview entries, '/var/www/dev/regdel/views/xsl/entries.xsl'
end


get '/raw/entries' do
    content_type 'application/xml', :charset => 'utf-8'
    @myentries = Entry.all
    builder :'xml/entries'
end
get '/raw/accounts' do
    @accounts = Account.all
    accounts = builder :'xml/accounts'
end
get '/raw/test' do
    content_type 'application/xml', :charset => 'utf-8'
    builder :'xml/test'
end




get '/raw/jsontest' do
    content_type :json
    @myentries = Entry.all
    @myentries.to_json()
end
get '/raw/jsontestassoc' do
    content_type :json
    @myentries = Entry.all
    @myentries.to_json(:methods => [:credits,:debits])
end
get '/raw/xmltest' do
    content_type 'application/xml'
    @myentries = Entry.all
    @myentries.to_xml()
end

