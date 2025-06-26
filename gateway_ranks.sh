#!/bin/bash
#
cd /tmp
rm -f gateway_ranks.txt
#
echo -e "[system clock]" >> gateway_ranks.txt
date >> gateway_ranks.txt
#
sleep 3
#
echo -e "\n[number of registered users per gateway]" >> gateway_ranks.txt
#PSQL='/opt/products/dstar/pgsql-8.2.3/bin/psql'
PSQL='/usr/bin/psql'
$PSQL dstar_global dstar -c "select count(*) as count, regist_rp_cs from sync_mng group by regist_rp_cs order by count desc;" >> gateway_ranks.txt
#
#
#
cp /tmp/gateway_ranks.txt /var/www/html/gateway_ranks.txt
