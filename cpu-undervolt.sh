#!/bin/sh -e

#newVID="43 23 1 0"  # maybe not caused by this but sometimes chrome tabs were crashing, benchmarks were stable
#original 43 37 23 17

newVID="43 25 3 2"

echo -n "CPU undervolting. Found VID values: "
cat /sys/devices/system/cpu/cpu0/cpufreq/phc_vids

echo "Writing new VIDs $newVID"

for i in /sys/devices/system/cpu/cpu*/cpufreq/phc_vids; do
  echo $newVID > $i
done
