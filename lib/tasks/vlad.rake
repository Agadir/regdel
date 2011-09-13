begin
  require 'vlad'
  Vlad.load :scm => :git
rescue
 # do nothing
end

namespace :vlad do
  remote_task :mkdaemon do
    run "mkdir -p /tmp/#{myapp}/log"
    run "echo '#!/bin/sh' > /tmp/#{myapp}/run"
    run "echo 'exec /var/www/dev/#{myapp}/current/demo.sh' >> /tmp/#{myapp}/run"
    run "echo '#!/bin/sh' > /tmp/#{myapp}/log/run"
    run "echo 'exec setuidgid daemon multilog t ./main' >> /tmp/#{myapp}/log/run"
    run "sudo chown -R root:root /tmp/#{myapp}"
    run "sudo chmod +x /tmp/#{myapp}/run"
    run "sudo chmod +x /tmp/#{myapp}/log/run"
    run "sudo mv /tmp/#{myapp} /service/"
  end
  remote_task :bundle do
    run "cd /var/www/dev/#{myapp}/current/ && sudo /var/lib/gems/1.8/bin/bundle install --path /var/www/dev/gems"
  end
  remote_task :render do
    run "cd /var/www/dev/#{myapp}/current/ && /var/lib/gems/1.8/bin/bundle exec rake render:partials"
  end
  remote_task :migrate do
    run "cd /var/www/dev/#{myapp}/current/ && /var/lib/gems/1.8/bin/bundle exec rake db:migrate"
  end
  remote_task :seed do
    run "cd /var/www/dev/#{myapp}/current/ && /var/lib/gems/1.8/bin/bundle exec rake db:seed"
  end
  remote_task :restart do 
    run "sudo svc -d /service/#{myapp}" 
    run "sudo svc -u /service/#{myapp}" 
  end 
  remote_task :fix do 
    run "mkdir -p /var/www/dev/#{myapp}/current/public/d/xhtml" 
    run "chmod 0777 /var/www/dev/#{myapp}/current/public/d/xhtml" 
  end
  remote_task :logtail do
    run "tail /tmp/webapps/#{myapp}.log -n 100"
  end
  task :deploy => [:update, :bundle, :restart, :fix]
end
