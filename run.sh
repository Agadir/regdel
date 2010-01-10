touch public/s/xhtml/*
rake files:welcome_html
ENV["RACK_ENV"]=development /var/lib/gems/1.8/gems/unicorn-0.95.3/bin/unicorn --env development -l 3000

