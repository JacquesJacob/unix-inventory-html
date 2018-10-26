#!/bin/bash
#
# Script copia saida cfg2html para consola
#

#for i in `ls /var/www/html/inventory/ | grep .html | cut -d. -f 1`; do cp /var/www/html/inventory/$i.html /var/www/html/inventory/backup/$i_`date +%m.%d.%Y`.html; done

scp -q -o LogLevel=QUIET 15.128.1.132:/inventory/*.html /var/www/html/inventory/

