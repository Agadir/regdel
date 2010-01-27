touch public/s/xhtml/*
rake files:welcome_html
ENV["RACK_ENV"]=alternate /var/lib/gems/1.8/gems/unicorn-0.95.3/bin/unicorn --env alternate -l 3000

