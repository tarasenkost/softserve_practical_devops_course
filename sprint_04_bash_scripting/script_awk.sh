#!/bin/bash

file=$1

awk '
BEGIN { total = 0; } 
      { if ($10 + 0 == $10) 
      { ip[$1] += $10; total += $10 } }
END   { 
        command = "echo " total " | numfmt --to=iec-i --suffix=B --format=\"%.1f\""
        command | getline formatted_total
        close(command)

        print "There are", length(ip), "unique ips";
        print "Total downloaded:", total, "(" formatted_total ")"

        if (length(ip) > 0) {
        for (i in ip) printf "%-15s %9d\n", i, ip[i] | "sort -k2,2nr -k1,1"} 
      }' "$file"
     

#### var2

# awk '{ if ($10 + 0 == $10) { ip[$1] += $10; total += $10 } }
#      END {
#          print "There are", length(ip), "unique ips";
#          print "Total downloaded: " total;
#          for (i in ip) printf "%-15s %9d\n", i, ip[i] | "sort -k2,2nr -k1,1"
#      }' "$FILE"

### var2

# declare -A report
# eval $(awk '
#     BEGIN { total = 0 } 
#     { if ($10 + 0 == $10) { ip[$1] += $10; total += $10 } }
#     END {
#         printf "total=%d\n", total
#         for (i in ip) { printf "report[%s]=%d\n", i, ip[i] }
#     }' "$FILE")    

# echo "There are ${#report[@]} unique ips"
# echo "Total downloaded: $total ($(numfmt --to=iec-i --suffix=B --format="%.1f" $total))"

# for ip in "${!report[@]}"; do
#     printf "%-15s %9d\n" "$ip" "${report[$ip]}" 
# done | sort -k2,2nr -k1,1


