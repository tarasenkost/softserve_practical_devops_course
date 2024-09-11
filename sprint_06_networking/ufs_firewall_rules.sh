#!/bin/bash

file=$1

ufw allow from 172.168.0.100 port 3000 to 172.168.0.100 port 3306
ufw allow from 192.168.32.55 to 172.168.0.100 port 3005
ufw reject in 3005
ufw allow in on eth0 to any port 8099
ufw limit to any port 6050:6055 proto tcp

ufw status verbose > "$file"
