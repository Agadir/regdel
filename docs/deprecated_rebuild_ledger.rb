###
# Program: http://www.regdel.com
# Component: rebuild_ledger.rb
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
##
require File.join(File.dirname(__FILE__), '..', 'regdel.rb')

Ledger.all.destroy!
amounts = Amount.all

amounts.each do |myamount|

  myid = myamount.entry_id
  myentry = Entry.get(myid)

  newtrans = Ledger.new(
    :posted_on => myentry.entered_on,
    :memorandum => myentry.memorandum,
    :amount => myamount.amount,
    :account_id => myamount.account_id,
    :entry_id => myamount.entry_id,
    :entry_amount_id => myamount.id
    ).save
end
