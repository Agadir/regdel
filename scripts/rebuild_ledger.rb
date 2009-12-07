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

Ledger.all.destroy!
amounts = Amount.all

amounts.each do |myamount|
  newtrans = Ledger.new(
    :posted_on => myamount.entry.entered_on,
    :memorandum => myamount.entry.memorandum,
    :amount => myamount.amount,
    :account_id => myamount.account_id,
    :entry_id => myamount.entry_id,
    :entry_amount_id => myamount.id
    ).save
end
