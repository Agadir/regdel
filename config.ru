require 'rails'
path_prefix = Rails.env.demo? ? '/demo/regdel' : '/'
map path_prefix do
  require ::File.expand_path('../config/environment',  __FILE__)
  run RegdelRails::Application
end
#require ::File.expand_path('../config/environment',  __FILE__)
#run RegdelRails::Application
