# dstar_tools
A series of scripts I use to make my life easier for working with D-STAR users and systems.

1. active_dplus_reflectors_ports_check.sh
This script does a port scan of TCP ports 80 and 443 and UDP port 20001. TCP port 80 is the REF dashboard
whereas UDP port 20001 is what the DREFD application listends for for incoming dplus connections.
TCP port 443 support is recently put in use by AA4RC for when at DV3K Dongle is implemented so dashboard
users and listen to audio on that reflector. This script does NOT qualify html content, only that the port
is open to incoming requests.

2. 
