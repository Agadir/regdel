###
# Program:: http://www.regdel.com
# Component:: regdel_dm.rb
# Copyright:: Savonix Corporation
# Author:: Albert L. Lash, IV
# License:: Gnu Affero Public License version 3
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
##
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


# The Account class includes all the accounts held by the business,
# organization, or other entity with numerous financial accounts
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
    mybal = Ledger.sum(:amount, :account_id => self.id)
    self.cached_ledger_balance = mybal ? mybal : 0
    self.save
  end
end

class Asset < Account; end
class Liability < Account; end
class Equity < Account; end
class Revenue < Account; end
class Expense < Account; end

class BankAccount < Asset; end

  
# Entries comprise the journal. Each entry must have one or more debit or
# credit amount.
class Entry
  
  include DataMapper::Resource
  include HasAmounts

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
    # UPDATE: I hacked dm-aggregates to make it work
    return "%.2f" % (Credit.sum(:amount, :entry_id => self.id).to_r.to_d / 100)
    
    # Works fine, but isn't it the same thing?
    #return Amount.sum(:amount, :type => 'Credit', :entry_id => self.id)
  end

end

# Amounts are directly related to entries.
class Amount
  
  include DataMapper::Resource
  include HasAmounts

  property :id,Serial
  property :entry_id,Integer
  property :type,Discriminator
  property :amount,Integer
  property :account_id,Integer
  property :memorandum,String
  property :currency_id,Integer
  belongs_to :entry


end


class Credit < Amount; end

class Debit < Amount; end

# Ledgers are all the transactions which take place within each account.
class Ledger
  include DataMapper::Resource
  include HasAmounts

  property :id,Serial
  property :posted_on,Integer
  property :memorandum,String
  property :amount,Integer
  property :account_id,Integer
  property :entry_id,Integer
  property :entry_amount_id,Integer
  property :fiscal_period_id,Integer
  property :currency_id,Integer
  belongs_to :account, :model => 'Account', :child_key => [ :account_id ]
  belongs_to :entry
  belongs_to :entry_amount, :model => 'Amount', :child_key => [ :entry_amount_id ]

end


DataMapper.auto_upgrade!
