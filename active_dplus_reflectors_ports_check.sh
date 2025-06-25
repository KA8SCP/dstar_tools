
#!/bin/bash

# Define the list of systems to check
SYSTEMS=("ref001.dstargateway.org" "ref002.dstargateway.org" "ref003.dstargateway.org" "ref004.dstargateway.org" "ref005.dstargateway.org" "ref006.dstargateway.org" "ref007.dstargateway.org" "ref008.dstargateway.org" "ref009.dstargateway.org" "ref010.dstargateway.org" "ref011.dstargateway.org" "ref012.dstargateway.org" "ref013.dstargateway.org" "ref014.dstargateway.org" "ref015.dstargateway.org" "ref016.dstargateway.org" "ref017.dstargateway.org" "ref018.dstargateway.org" "ref019.dstargateway.org" "ref020.dstargateway.org" "ref021.dstargateway.org" "ref022.dstargateway.org" "ref023.dstargateway.org" "ref024.dstargateway.org" "ref025.dstargateway.org" "ref026.dstargateway.org" "ref027.dstargateway.org" "ref028.dstargateway.org" "ref029.dstargateway.org" "ref030.dstargateway.org" "ref031.dstargateway.org" "ref032.dstargateway.org" "ref033.dstargateway.org" "ref034.dstargateway.org" "ref035.dstargateway.org" "ref036.dstargateway.org" "ref037.dstargateway.org" "ref038.dstargateway.org" "ref039.dstargateway.org" "ref040.dstargateway.org" "ref041.dstargateway.org" "ref042.dstargateway.org" "ref043.dstargateway.org" "ref044.dstargateway.org" "ref045.dstargateway.org" "ref046.dstargateway.org" "ref047.dstargateway.org" "ref048.dstargateway.org" "ref049.dstargateway.org" "ref050.dstargateway.org" "ref051.dstargateway.org" "ref052.dstargateway.org" "ref053.dstargateway.org" "ref054.dstargateway.org" "ref055.dstargateway.org" "ref056.dstargateway.org" "ref057.dstargateway.org" "ref058.dstargateway.org" "ref059.dstargateway.org" "ref060.dstargateway.org" "ref061.dstargateway.org" "ref062.dstargateway.org" "ref063.dstargateway.org" "ref064.dstargateway.org" "ref065.dstargateway.org" "ref066.dstargateway.org" "ref067.dstargateway.org" "ref068.dstargateway.org" "ref069.dstargateway.org" "ref070.dstargateway.org" "ref071.dstargateway.org" "ref072.dstargateway.org" "ref073.dstargateway.org" "ref074.dstargateway.org" "ref075.dstargateway.org" "ref076.dstargateway.org" "ref077.dstargateway.org" "ref078.dstargateway.org" "ref079.dstargateway.org" "ref080.dstargateway.org" "ref081.dstargateway.org" "ref082.dstargateway.org" "ref083.dstargateway.org" "ref084.dstargateway.org" "ref085.dstargateway.org" "ref086.dstargateway.org" "ref087.dstargateway.org" "ref088.dstargateway.org" "ref089.dstargateway.org" "ref090.dstargateway.org" "ref091.dstargateway.org" "ref092.dstargateway.org" "ref093.dstargateway.org" "ref094.dstargateway.org" "ref095.dstargateway.org" "ref096.dstargateway.org" "ref097.dstargateway.org" "ref098.dstargateway.org") # Replace with your system names or IP addresses

# Define the ports to check
TCP_PORTS=("80" "443")
UDP_PORT=("20001" "30001" "30051")

# Define the output file
OUTPUT_FILE="/var/www/html/dplus_reflector_port_status_report.txt"

# Clear the output file before starting a new scan
> "$OUTPUT_FILE"

# Get the current date and time
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Iterate through each system
for system in "${SYSTEMS[@]}"; do
    echo "--- Checking system: $system ---" >> "$OUTPUT_FILE"
    echo "Scan started at: $timestamp" >> "$OUTPUT_FILE"

    # Check TCP ports using nmap
    for tcp_port in "${TCP_PORTS[@]}"; do
        echo "  Checking TCP port $tcp_port..." >> "$OUTPUT_FILE"
        nmap -sT -p "$tcp_port" "$system" | grep -E "tcp.*open|tcp.*closed" >> "$OUTPUT_FILE"
    done

    # Check UDP port using nmap
    echo "  Checking UDP port $UDP_PORT..." >> "$OUTPUT_FILE"
    nmap -sU -p "$UDP_PORT" "$system" | grep -E "udp.*open|udp.*closed|udp.*open|udp.*filtered" >> "$OUTPUT_FILE"

    echo "--- Scan finished for system: $system ---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE" # Add a blank line for readability

done

echo "Port status check complete. Results appended to $OUTPUT_FILE"
