#!/bin/sh
cd /var/www/dev/regdel/current
exec softlimit -m 131457280 -o 100 exec /var/lib/gems/1.9.1/gems/unicorn-0.95.3/bin/unicorn -c /var/www/dev/regdel/current/config/unicorn.conf --env demo -l 3000
