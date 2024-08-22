#!/bin/bash

code="404"
input_file=apache_logs
output_file=not_found.txt

awk '{
    if ($9 == "404") {
    print $1, $6, $7}}' apache_logs > not_found.txt

# awk -v code="$code" '{if ($9 == code) print $1, $6, $7}' $input_file > $output_file



# Doesn't work

# awk '/404/ {print $1, $6, $7}' ./apache_logs > ./not_found.txt
# grep "404" ./apache_logs | cut -d ' ' -f 1,6,7 > ./not_found.txt
# egrep "404" ./apache_logs | awk '{print $1, $6, $7}' > ./not_found.txt

# while read -r line; do 
# awk '/404/ {print $1, $6, $7}' <<< "$line" >> ./not_found.txt
# done < apache_logs

## this one also works.
# awk '{
#     if ($9 == "404") {
#         ip = $1
#         method = $6
#         path = $7
#         print ip " " method " " path}}' apache_logs > not_found.txt
