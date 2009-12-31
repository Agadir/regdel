###
# Program: http://www.regdel.com
# Component: journal_complete.builder
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
xml.entries() {
  @myentries.each do |entry|

    newdate = Time.at(entry.entered_on) ? Time.at(entry.entered_on) : ""

    xml.entry( :memorandum=>entry.memorandum, :id=>entry.id, :date=>newdate ) {

      entry.credits.each do |credit|
          xml.credit(:id=>credit.id,:amount=>credit.to_usd,:account=>credit.account_id)
      end

      entry.debits.each do |debit|
          xml.debit(:id=>debit.id,:amount=>debit.to_usd,:account=>debit.account_id)
      end
    }
  end
}
