###
# Program:: http://www.regdel.com
# Component:: config.ru
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

###
# This is a rackup configuration file. It is useful, but its not totally
# required.
#
# I use run.sh for development, and rund.sh for the demo, along with
# daemontools as the process manager. See:
# http://www.docunext.com/wiki/Vlad
##

if ENV['RACK_ENV'] == "demo"
  mountpath = '/demo/regdel'
  ENV['DATABASE_URL'] = 'sqlite3:///var/www/dev/regdel/rbeans.sqlite3'
elsif ENV['RACK_ENV'] == "development"
  mountpath = '/'
  ENV['DATABASE_URL'] = 'sqlite3:///var/www/dev/regdel/rbeans.sqlite3'
else
  mountpath = '/'
end

require 'regdel'

Regdel::Main.set :run, false
Regdel::Main.set :environment, ENV['RACK_ENV']

map mountpath do
  # Remove leading slash if there is no path
	run Regdel.new(mountpath.gsub(/^\/$/,''),File.dirname(__FILE__))
end
