#!/bin/bash

file=$1
total=0
declare -A report

# Get IPs and valid data_sizes list
ip_datasize=$(awk '{ if ($10 + 0 == $10) print $1, $10 }' "$file")
 
# Calc downloads per IP and total size
if [[ -n "$ip_datasize" ]]; then
    while read -r ip data_size; do
        ((report["$ip"] += data_size))
        ((total +=  data_size))
    done <<< "$ip_datasize"
fi

# Output the results
echo "There are ${#report[@]} unique ips"
echo "Total downloaded: $total ($(numfmt --to=iec-i --suffix=B --format="%.1f" $total))"

for ip in "${!report[@]}"; do
    printf "%-15s %9d\n" "$ip" "${report[$ip]}"
done | sort -k2,2nr -k1,1