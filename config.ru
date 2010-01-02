if ENV['RACK_ENV'] == "demo"
  mountpath = '/demo/regdel'
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
