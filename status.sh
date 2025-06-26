#!/bin/bash
#
cd /tmp
rm -f status.txt
#
echo -e "[system clock]" >> status.txt
date >> status.txt
#
sleep 3
#
echo -e "\n[what is my ip]" >> status.txt
curl ipinfo.io/ip >> status.txt
#
echo -e "\n[last database sync]" >> status.txt
grep SYNC_DB_SYNC /var/log/dsipsvd.log | tail -1 >> status.txt
#
echo -e "\n[users pending licensing]" >> status.txt
#PSQL='/opt/products/dstar/pgsql-8.2.3/bin/psql'
PSQL='/usr/bin/psql'
$PSQL dstar_global dstar -c "select user_cs from unsync_user_mng where regist_flg = false;" >> status.txt
#
#
echo -e "\n[dstar users ls report]" >> status.txt
/dstar/tools/dstarusersls >> status.txt
#
echo "[gateway status]" >> status.txt
/sbin/service dstar_gw status >> status.txt
#
#echo -e "\n[named status]" >> status.txt
#/sbin/service named status >> status.txt
#
echo -e "\n[dstarmon status]" >> status.txt
/sbin/service dsm status >> status.txt
#
echo -e "\n[dsync status]" >> status.txt
/dstar/scripts/gw_schedule_g3 -d >> status.txt
#
echo -e "\n[dplus status]" >> status.txt
/sbin/service dplus status >> status.txt
#
cat /dstar/tmp/status >> status.txt
#
#echo -e "\n[monlink info]" >> status.txt
#/sbin/service monlink status >> status.txt
#/sbin/service monlink version >> status.txt
#
#echo -e "\n[g2_link status]" >> status.txt
#/sbin/service g2_link status >> status.txt
#grep initialized /var/log/g2_link.log | tail -1 >> status.txt
#cat /root/g2_link/RPT_STATUS.txt >> status.txt
#
mutt -s "WB1GOF daily status $(date +%d%b%Y)" ka8scp@wb1gof.org < status.txt
#
cp /tmp/status.txt /var/www/html/status.txt
