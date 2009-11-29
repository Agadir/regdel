require 'rubygems'
require 'sinatra'
require 'builder'
require 'bigdecimal'
require 'bigdecimal/util'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
#require 'views/utils/template'
require 'xml/libxml'
require 'xml/libxslt'
require 'nokogiri'

require 'data/regdel_dm'
require 'helpers/xslview'

set :views, File.dirname(__FILE__) + '/views'


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
    @myentries = Entry.all
    myxml = builder :'xml/entries'
    h myxml, '/var/www/dev/regdel/views/xsl/entries.xsl'
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
    @myaccounts = Account.all
    builder :'xml/entries'
end






# Requires patched sinatra
#get '/remote/entries' do
#    doc = ''
#    open('http://192.168.8.48:3001/raw/entries').each_line do |line|
#       doc += line
#    end
#    xsl :'xsl/entries', :locals => { :myxml => doc }
#end
