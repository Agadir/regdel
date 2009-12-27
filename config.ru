mountpath = '/'

require 'regdel'

# Unicorn sets up Rack::Lint, but that causes problems with 304 responses
# for some reason
ENV['RACK_ENV'] = 'none'

Regdel::Main.set :run, false
Regdel::Main.set :environment, :production



map mountpath do
  # Remove leading slash if there is no path
	run Regdel.new(mountpath.gsub(/^\/$/,''))
end
