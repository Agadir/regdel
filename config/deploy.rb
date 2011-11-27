require "bundler/capistrano"

set :application, 'regdel'
set :repository, 'git@github.com:docunext/regdel.git'
set :scm, :git
set :user, 'app'
set :deploy_to, "/home/app/webapps/#{application}"
set :use_sudo, false
set :normalize_asset_timestamps, false

server '192.168.8.121', :app, :web, :db, :primary => true

after "deploy:update_code", "db:symlink"


namespace :db do
  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end
