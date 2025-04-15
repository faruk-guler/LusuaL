# dns_inventory.sh
#!/bin/bash

DOMAIN="google.com"
HOSTS=$(dig +short -t A "*.web.${DOMAIN}" | sort -u)

echo '{
  "dns_hosts": {
    "hosts": ['$(for ip in $HOSTS; do echo "\"$ip\","; done | sed '$s/,$//')']
  }
}
