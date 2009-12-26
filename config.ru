
mountpath = '/'

require 'regdel'


Regdel::Main.set :run, false
Regdel::Main.set :environment, :development



map mountpath do
  # Remove leading slash if there is no path
	run Regdel.new(mountpath.gsub(/^\/$/,''))
end
