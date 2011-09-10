!/bin/sh
cd /var/www/dev/regdel/current
exec softlimit -m 131457280 -o 100 bundle unicorn --env demo -l 3000
