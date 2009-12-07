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
require 'xml/libxml'
require 'xml/libxslt'
require 'json'

require 'data/regdel_dm'


class RdMoney < String
    def no_d
        return (self.gsub(/[^0-9\.]/,'').to_d * 100).to_i
    end
end

for i in 1..5
    @entry = Entry.new(:memorandum => "Hi",:entered_on => Time.now.to_i)
    @entry.save
    @entry.credits.create(:amount => RdMoney.new("#{i}.00").no_d, :account_id => 1)
    @entry.debits.create(:amount => RdMoney.new("#{i}.00").no_d, :account_id => 2)
end
