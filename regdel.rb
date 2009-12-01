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

set :views, File.dirname(__FILE__) + '/views'
set :public, File.dirname(__FILE__) + '/public'


get '/' do
    @myaccounts = Account.all
    erb :'erb/account_list'
end

get '/accounts' do
    @myaccounts = Account.all
    erb :'erb/account_list'
end

get '/new/account' do
    @object_type = 'account'
    erb :'xhtml/account_form'
end

post '/new/account' do
  @account = Account.new(:name => params[:account_name])
  if @account.save
      redirect '/accounts'
  else
      redirect '/accounts'
  end
end


get '/new/entry' do
    @object_type = 'entry'
    erb :'erb/entry_new'
end

post '/new/entry' do
    @entry = Entry.new(:memorandum => params[:memorandum])
    @entry.save
    @entry.credits.create(:amount => RdMoney.new(params[:credit]).no_d)
    @entry.debits.create(:amount => RdMoney.new(params[:debit]).no_d)
    redirect '/entries'
end


get '/entries' do
    get_entries_and_accounts()
    builder :'xml/entries'
end


get '/raw/entries' do
    content_type 'application/xml', :charset => 'utf-8'
    get_entries_and_accounts()
    builder :'xml/entries'
end
get '/raw/test' do
    content_type 'application/xml', :charset => 'utf-8'
    builder :'xml/test'
end
get '/raw/jsontest' do
    # Need to figure out how to get these to nest properly
    #content_type :json
    content_type 'text/plain'
    @myentries = Entry.all
    @myentries.to_json(:methods => [:credits,:debits])
end


helpers do
    def get_entries_and_accounts()
        @myentries = Entry.all
        @myaccounts = Account.all
    end
end
