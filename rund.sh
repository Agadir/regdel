#!/bin/sh
cd /var/www/dev/regdel/current
exec /var/lib/gems/1.9.1/gems/unicorn-0.95.3/bin/unicorn -c /var/www/dev/regdel/current/config/unicorn.conf --env demo -l 3000
