#!/bin/sh
cd /var/www/dev/regdel/current
exec softlimit -m 131457280 -o 100 "/home/app/.rvm/bin/rvm exec bundle exec unicorn -c /var/www/dev/regdel/current/config/unicorn.conf  --env demo -l 3000"
