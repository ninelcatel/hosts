#!/bin/bash
validate_ip() {
    local ip=$1
    local name=$2
    local dns=$3
    ip_real=$(nslookup "$name" "$dns" 2>/dev/null | grep -m 1 "Address: " | cut -d ' ' -f 2)
    
    if [ "$ip_real" != "$ip" ]; then
        echo "bogus ip for $name in /etc/hosts"
    else
        echo "real ip for $name is $ip_real"
    fi
}
cat /etc/hosts | while read -r ip name; do

    if [ -z "$ip" ]; then
        continue
    fi

    if [[ "$ip" == \#* ]]; then
        break
    fi

    validate_ip "$ip" "$name" "8.8.8.8"
done
