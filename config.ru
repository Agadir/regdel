
mountpath = '/regdel'

require 'regdel'


Regdel::Main.set :run, false
Regdel::Main.set :environment, :development



map mountpath do
	run Regdel.new(mountpath)
end
