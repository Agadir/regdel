# <!--
# Program: http://www.regdel.com
# Component: regdel_dm.rb
# Copyright: Savonix Corporation
# Author: Albert L. Lash, IV
# License: Gnu Affero Public License version 3
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
# -->
require 'rubygems'
require 'bigdecimal'
require 'bigdecimal/util'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-serializer'
require 'dm-aggregates'
require 'dm-validations'

DataMapper.setup(:default, 'sqlite3:///var/www/dev/regdel/rbeans.sqlite3')


class RdMoney < String
    def no_d
        return (self.gsub(/[^0-9\.]/,'').to_d * 100).to_i
    end
end

class Account
  include DataMapper::Resource

  name_length_error = "Name is too long or too short."
  property :id,Serial
  property :number,String
  property :name,String
  property :type_id,Integer
  property :description,Text
  property :created_on,Integer, :default => Time.now.to_i
  property :closed_on,Integer, :default => 0
  property :hide,Boolean
  property :group_id,Integer
  property :cached_ledger_balance,Integer, :default => 0
  has n, :credits
  has n, :debits
  has n, :ledgers
  validates_present :name
  validates_length :name, :max => 12, :message => name_length_error
  validates_length :name, :min => 2, :message => name_length_error
  validates_is_unique :name


  def self.open
    all(:closed_on => 0)
  end
  def cached_ledger_balance_usd
    return "%.2f" % (cached_ledger_balance.to_r.to_d / 100)
  end
  def update_ledger_balance
    self.cached_ledger_balance = self.ledgers.sum(:amount) ? self.ledgers.sum(:amount) : 0;
    self.save;
  end
end

class Entry
  include DataMapper::Resource

  property :id,Serial
  property :memorandum,String
  property :status,Integer
  property :fiscal_period_id,Integer
  property :entered_on,Integer, :default => Time.now.to_i
  has n, :credits
  has n, :debits
  has n, :ledgers
  
  def credit_sum
    # Does not work: 
    # !! Unexpected error while processing request: 
    # +options[:fields]+ entry #<DataMapper::Property @model=Amount @name=:amount>
    # does not map to a property in Credit
    return "%.2f" % (Credit.sum(:amount, :entry_id => self.id).to_r.to_d / 100)
    
    # Works fine, but isn't it the same thing?
    #return Amount.sum(:amount, :type => 'Credit', :entry_id => self.id)
  end

end

class Amount
  include DataMapper::Resource

  property :id,Serial
  property :entry_id,Integer
  property :type,Discriminator
  property :amount,Integer
  property :account_id,Integer
  property :memorandum,String
  property :currency_id,Integer
  belongs_to :entry
  #belongs_to :entry, :model => 'Entry', :child_key => [:entry_id, Integer]


  def to_usd
      return "%.2f" % (self.amount.to_r.to_d / 100)
  end
  def self.sum_usd
    return self.entry.credits.sum(:amount)
  end

end


class Credit < Amount; end

class Debit < Amount; end

class Ledger
  include DataMapper::Resource

  property :id,Serial
  property :posted_on,Integer
  property :memorandum,String
  property :amount,Integer
  property :account_id,Integer
  property :entry_id,Integer
  property :entry_amount_id,Integer
  property :fiscal_period_id,Integer
  property :currency_id,Integer
  belongs_to :account
  belongs_to :entry
  belongs_to :entry_amount, :model => 'Amount', :child_key => [ :entry_amount_id ]
  
  def to_usd
      return "%.2f" % (self.amount.to_r.to_d / 100)
  end
  # Called from a Ledger instance object, returns the ledger balance for that entry
  def running_balance
    return "%.2f" % ( (Ledger.all(
      :conditions => ["account_id = ? AND ( posted_on < ? OR (( posted_on = ? AND amount < ? ) OR ( posted_on = ? AND amount = ? AND id < ?)))", self.account_id,  self.posted_on, self.posted_on, self.amount, self.posted_on, self.amount, self.id] ).sum(:amount).to_i.to_r.to_d + self.amount) / 100)
  end

end


DataMapper.auto_upgrade!
