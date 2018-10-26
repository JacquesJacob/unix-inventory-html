#!/bin/bash
#
# Backup saida cfg2html 
#

for i in `ls /var/www/html/inventory/ | grep .html | cut -d. -f 1`; do cp /var/www/html/inventory/$i.html /var/www/html/inventory/backup/$i'_'`date +%m.%d.%Y`.html; done

