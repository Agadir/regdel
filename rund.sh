#!/bin/sh
cd /var/www/dev/regdel/
exec /var/lib/gems/1.8/gems/unicorn-0.95.3/bin/unicorn --env none -l 3000
