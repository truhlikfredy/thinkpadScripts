#!/bin/bash

#now have sandybridge i7-2760qm - 2.4ghz with 3.5ghz turbo
under=2100000
noturbo=`cat /sys/devices/system/cpu/intel_pstate/no_turbo`
status=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
min=`cat /sys/bus/cpu/devices/cpu0/cpufreq/cpuinfo_min_freq`
max=`cat /sys/bus/cpu/devices/cpu0/cpufreq/cpuinfo_max_freq`
freq=`cat /sys/bus/cpu/devices/cpu0/cpufreq/scaling_max_freq`

function maxFreq {
    echo "Setting max cpu clock to $1"
    for cpu in `ls /sys/bus/cpu/devices/`
    do
	echo $cpu
	echo $1 >  /sys/bus/cpu/devices/$cpu/cpufreq/scaling_max_freq
    done
}

function pState {
    echo $1 | tee /sys/devices/system/cpu/intel_pstate/min_perf_pct
    echo $2 | tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
    echo $3 | tee /sys/devices/system/cpu/intel_pstate/no_turbo
    echo "pstate min=$1 max=$2, turboDisabled=$3"
}

function governor {
    echo "$1" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
}

function setpoint {
    echo $1 | tee /sys/kernel/debug/pstate_snb/setpoint
}

function msg {
    xmessage -timeout 1 -nearmouse -center "$1"
}

cat /sys/bus/cpu/devices/cpu0/cpufreq/scaling_max_freq
echo Switching to mode:

#0 to 1
if [ "$freq" = "$min" ]; then
    echo "0 -> 1"
    governor powersave
    setpoint 98
    maxFreq $under
    pState 22 65 1
    msg 1-low-$under=1.4GHz
fi

#1 to 2
if [ "$freq" = "$under" ]; then
    echo "1 -> 2"
    governor powersave
    setpoint 97
    maxFreq $max
    pState 22 90 1
    msg 2-low-$max=2.1GHz
fi

#2 to 3
if [ "$freq" = "$max" ] && [ "$status" = "powersave" ] && [ "$noturbo" = "1" ]; then
    echo "2 -> 3"
    governor powersave
    setpoint 97
    maxFreq $max
    pState 22 100 0
    msg 3-medium-powersave-TURBO=3.5GHz
fi

#3 to 4
if [ "$status" = "powersave" ] && [ "$noturbo" = "0" ]; then
    echo "3 -> 4"
    governor performance
    setpoint 97
    maxFreq $max
    pState 50 100 0
    msg 4-high-performance
fi

#4 to 0
if [ "$status" = "performance" ]; then
    echo "4 -> 0"
    governor powersave
    setpoint 98
    maxFreq $min
    pState 22 22 1
    msg 0-ultra-low-$min=0.8GHz
fi

echo Max freq now:
cat /sys/bus/cpu/devices/cpu0/cpufreq/scaling_max_freq
