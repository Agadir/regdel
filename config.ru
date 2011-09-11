map "/demo/regdel" do
  require ::File.expand_path('../config/environment',  __FILE__)
  run RegdelRails::Application
end
