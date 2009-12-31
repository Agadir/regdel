###
# Program: http://www.regdel.com
# Component: default_accounts.rb
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
require 'data/regdel_dm'

Account.new(
:id =>  1,
:number =>  "12344",
:name =>  "Bank USA",
:type_id =>  10000,
:description =>  "",
:created_on =>  1260181164,
:closed_on =>  0
).save

Account.new(
:id =>  2,
:number =>  "11222",
:name =>  "Cash",
:type_id =>  10000,
:description =>  " ",
:created_on =>  1260181164,
:closed_on =>  0
).save

Account.new(
:id =>  3,
:number =>  "22333",
:name =>  "Electricity",
:type_id =>  20000,
:description =>  "",
:created_on =>  1260181164,
:closed_on =>  0
).save

Account.new(
:id =>  4,
:number =>  "22334",
:name =>  "Taxes",
:type_id =>  20000,
:description =>  "",
:created_on =>  1260181164,
:closed_on =>  0
).save

Account.new(
:id =>  5,
:number =>  "40011",
:name =>  "Professional Services",
:type_id =>  40000,
:description =>  "",
:created_on =>  1260181164,
:closed_on =>  0
).save
