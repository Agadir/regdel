touch public/s/xhtml/*
touch public/d/xhtml/*
#rake files:welcome_html
/var/lib/gems/1.9.1/bin/unicorn -c /var/www/dev/regdel/config/unicorn.dev.conf --env development -l 3000

