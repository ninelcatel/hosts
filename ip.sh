#!/bin/bash
cat /etc/hosts | while read -r ip name; do
	if [ -z "$ip" ]; then
		continue
	fi
	if [ "$ip" == "#" ]; then
	break
	fi
ip_real=$(nslookup "$name" 8.8.8.8 2>/dev/null | grep -m 1 "Address: " | cut -d ' ' -f 2)
if [ "$ip_real" != "$ip" ]; then
	echo "bogus ip for $name in /etc/hosts"
else
	echo "real ip for $name is $ip_real"
fi
done
