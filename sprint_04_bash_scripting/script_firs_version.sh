#!/bin/bash

FILE=$1
declare -A report

# Get the list of unique IPs
unique_ips_list=($(awk '{ print $1 }' "$FILE" | sort | uniq))

# Calculate total downloaded size
total_download=$(awk '{ sum += $10 } END { print sum+0 }' "$FILE")
total_download_frmt=$(numfmt --to=iec-i --suffix=B --format="%.1f" $total_download)


# Accumulate download sizes for each IP and store in the associative array
for ip in "${unique_ips_list[@]}"; do
    download_size=$(awk -v ip="$ip" '{ if ($1 == ip) sum += $10 } END { printf "%.0f", sum }' "$FILE")
    report["$ip"]=$download_size
done

# Print the results
echo "There are ${#report[@]} unique ips"                         # ${#unique_ips_list[@]}
echo "Total downloaded: $total_download ($total_download_frmt)"

# Sort and format the output from the associative array
for ip in "${!report[@]}"; do
    printf "%-15s %9s\n" "$ip" "${report[$ip]}"
done | sort -k2,2nr -k1,1


