#!/bin/bash

# Configuration
WEBSITES="http://ref038.dstargateway.org http://ref039.dstargateway.org http://ref049.dstargateway.org http://xlx139.dyndns.org http://xlx978.dyndns.org http://xlx351.dyndns.org http://xrf221.dyndns.org http://xlx049.dyndns.org"  # List of websites to check
EMAIL_RECIPIENT="email@address.com"  # Your email address for failure notifications
SMS_RECIPIENT="your cellphone @ email address" # email-to-SMS address
LOG_FILE="/var/www/html/website_check.txt"  # Log file for script output
TEMP_STATUS_FILE="/dstar/tmp/website_status.tmp"  # Temporary file to store status

# Function to send email
send_email() {
  subject="$1"
  body="$2"
  echo -e "$body" | mutt -s "$subject" "$EMAIL_RECIPIENT"
}

# Function to send SMS (via email-to-SMS gateway)
send_sms() {
  message="$1"
  # Use mail command to send to the T-Mobile gateway
  echo "$message" | mutt -s "" "$SMS_RECIPIENT"
}
# Clear the output file if it exists
> "$LOG_FILE"

# Check website status
check_website() {
  url="$1"
  response=$(curl --write-out "%{http_code}" --silent --output /dev/null "$url")

  if [ "$response" -eq 200 ]; then
    echo "$(date) - $url is UP (HTTP $response)" | tee -a "$LOG_FILE"
    # Remove temp status file if website is now up
    if [ -f "$TEMP_STATUS_FILE" ]; then
      grep -v "$url" "$TEMP_STATUS_FILE" > "$TEMP_STATUS_FILE.new" && mv "$TEMP_STATUS_FILE.new" "$TEMP_STATUS_FILE"
    fi
  else
    echo "$(date) - $url is DOWN (HTTP $response)" | tee -a "$LOG_FILE"
    # Check if a notification has already been sent for this website
    if ! grep -q "$url" "$TEMP_STATUS_FILE"; then
      send_email "Website Down Alert: $url" "The website $url returned HTTP status code $response."
      send_sms "Website Down Alert: $url" # T-Mobile SMS gateway might not work for individuals
      echo "$url" >> "$TEMP_STATUS_FILE" # Record that a notification has been sent
    fi
  fi
}

# Main script logic
for website in $WEBSITES; do
  check_website "$website"
done
