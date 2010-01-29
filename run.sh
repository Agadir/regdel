touch public/s/xhtml/*
rake files:welcome_html
ENV["RACK_ENV"]=development /var/lib/gems/1.8/gems/unicorn-0.95.3/bin/unicorn -c /var/www/dev/regdel/config/unicorn.dev.conf --env development -l 3000

