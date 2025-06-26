# dstar_tools
A series of scripts I use to make my life easier for working with D-STAR users and systems.

1. active_dplus_reflectors_ports_check.sh - 
This script does a port scan of TCP ports 80 and 443 and UDP port 20001. TCP port 80 is the REF dashboard
whereas UDP port 20001 is what the DREFD application listends for for incoming dplus connections.
TCP port 443 support is recently put in use by AA4RC for when at DV3K Dongle is implemented so dashboard
users can listen to audio on that reflector. This script does NOT qualify html content, only that the port
is open to incoming requests.

2. check-for-my_refs.sh - This script checks to see what HTML response code comes from a collection of DPLUS
and XLX reflectors. The output is saved as a text file to the /var/www/html directory. It will also email and SMS
a "down" system status to the email account and cell phone number you enter. HTTP code 000 is a non-responsive
website, 200 is a normal response, 301 indicates a "redirect"... maybe https versus http?

3. gateway_ranks.sh - This script runs PSQL query on a Centos 7-based G3.0 or G3.1 based system to output to
/var/www/html/gateway_ranks.txt for dispaly on a host. It checks the number of registered users on each registration
server.

4. status.sh - For Centos 7-based G3.0 and G3.1 systems. This script outputs a text file to the /var/www/html directory
that lists dstar gateway information including: system clock; what is my ip; last database sync; users pending licensing;
dstar users ls report; Local users registered on multiple gateways; gateway status; dstarmon status; dsync status;
dplus status; g2_link status (comment out of not used). It will also email you using mutt the same report. Use a cron job
to schedule as needed.
