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

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3:///var/www/dev/regdel/rbeans-alternate.sqlite3')


# Xact = transaction
class Xact
  include DataMapper::Resource

  property :id,Serial
  property :posted_on,Integer
  property :memorandum,String
  has n, :assets
  has n, :liabilities
  has n, :equities
  has n, :expenses
  has n, :revenues
  has n, :banks

end


# Postings are the individual account changes
class Posting
  include DataMapper::Resource

  property :id,Serial
  property :type,Discriminator
  property :xact_id,Integer
  property :commodity,String
  property :quantity,BigDecimal, :scale => 2, :precision => 5

  belongs_to :xact
end

# Single table inheritance for every account
class Asset < Posting; end
class Liability < Posting; end
class Equity < Posting; end
class Revenue < Posting; end
class Expense < Posting; end
class Bank < Asset; end

DataMapper.auto_upgrade!

@ok = Xact.new(
  :memorandum => '1222')

@ok.save

sum = BigDecimal.new("1.23")
bd = BigDecimal.new("#{sum.round(2).to_s}")

@ok1 = @ok.banks.create(
    :quantity => bd,
    :commodity => '$'
    )

unless @ok1.save
  puts "error"
end
