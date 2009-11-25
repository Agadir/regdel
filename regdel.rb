require 'rubygems'
require 'sinatra'
require 'builder'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'data/regdel_dm'





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
    erb :'erb/account_new'
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
    mydebit = params[:debit]
    mydebit = mydebit.to_f * 100
    mycredit = params[:credit].to_f * 100
    @entry = Entry.new(:memorandum => params[:entry_name])
    @entry.save
    @credit = @entry.credits.create(:amount => mycredit)
    @debit = @entry.debits.create(:amount => mydebit)
    redirect '/entries'
end


get '/raw/entries' do
    content_type 'application/xml', :charset => 'utf-8'
    @myentries = Entry.all
    builder :'xml/entries'
end
