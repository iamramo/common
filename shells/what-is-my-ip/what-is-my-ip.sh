#!/usr/bin/env sh

function what-is-my-ip() {
  data=$(curl -s https://ipinfo.io/json)

  if [ "$1" = "--json" ]; then
    echo "$data"
    return
  fi

  echo "IP Address: $(echo "$data" | jq -r '.ip')"
  echo "Hostname: $(echo "$data" | jq -r '.hostname')"
  echo "City: $(echo "$data" | jq -r '.city')"
  echo "Region: $(echo "$data" | jq -r '.region')"
  echo "Country: $(echo "$data" | jq -r '.country')"
  echo "Location: $(echo "$data" | jq -r '.loc')"
  echo "ISP: $(echo "$data" | jq -r '.org')"
}
