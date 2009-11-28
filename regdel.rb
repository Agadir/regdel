require 'rubygems'
require 'sinatra'
require 'builder'
require 'bigdecimal'
require 'bigdecimal/util'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'data/regdel_dm'
require 'views/utils/template'




get '/' do
    @myaccounts = Account.all
    erb :'erb/list'
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


get '/entries' do
    @myitems = Entry.all()
    erb :'erb/entry_list'
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


get '/raw/entries' do
    content_type 'application/xml', :charset => 'utf-8'
    @myentries = Entry.all
    builder :'xml/entries'
end
