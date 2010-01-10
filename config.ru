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
	run Regdel.new(mountpath.gsub(/^\/$/,''))
end
