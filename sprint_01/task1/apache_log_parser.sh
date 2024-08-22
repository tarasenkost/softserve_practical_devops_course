#!/bin/bash

code="404"
input_file=apache_logs
output_file=not_found.txt

awk -v code="$code" '{if ($9 == code) print $1, $6, $7}' $input_file > $output_file

# Input: 5.102.173.71 - - [17/May/2015:11:05:06 +0000] "GET /projects/xdotool/ HTTP/1.1" 200 12292 "-" "Mozilla/5.0 (compatible; MojeekBot/0.6; http://www.mojeek.com/bot.html)"
# Output: 208.91.156.11 "GET /files/logstash/logstash-1.3.2-monolithic.jar
