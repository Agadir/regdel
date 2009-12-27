#!/bin/sh
cd /var/www/dev/regdel/
/var/lib/gems/1.8/gems/unicorn-0.95.2/bin/unicorn -l 3000
