#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

lastcpus=$(cat /proc/stat | grep 'cpu'[0-9])

array=($(sudo cat /proc/net/dev))

lastT=$(expr ${array[29]} + ${array[46]} + ${array[63]})
lastR=$(expr ${array[21]} + ${array[38]} + ${array[55]})

arrayT=()
arrayR=()

sumT=0
sumR=0


while true;
do
    sleep 1 &

    array=($(sudo cat /proc/net/dev))

    newT=$(expr ${array[29]} + ${array[46]} + ${array[63]})
    newR=$(expr ${array[21]} + ${array[38]} + ${array[55]})

    arrayT+=("$(expr $newT - $lastT)")
    arrayR+=("$(expr $newR - $lastR)")

    sumT=$(expr $(expr $newT - $lastT) + $sumT)
    sumR=$(expr $(expr $newR - $lastR) + $sumR)

    maxT=0

    for i in ${arrayT[@]};
    do
        if [ $i -gt $maxT ];
        then
            maxT=$i
        fi
    done

    Tunit="b"
    devideBy=10

    if [ $maxT -gt 10240 ];
    then
        Tunit="kb"
        devideBy=10240
    fi

    if [ $maxT -gt 10485760 ];
    then
        Tunit="mb"
        devideBy=10485760
    fi

    diagram=''
    for (( i=10; i>0; i--));
    do
        x=$(expr $i \* $maxT / $devideBy)
        y=$(expr $i \* $maxT / 10)
        z=$(expr $(expr $i - 1) \* $maxT / 10)
        avg=$(expr $sumT / ${#arrayT[@]})
        diagram+="$x $Tunit/s "
        for t in ${arrayT[@]};
        do
            if [ $t -ge $y ]
            then
                diagram+="|"
            elif [ $y -ge  $avg ] && [ $z -le $avg ]
            then
                diagram+="${RED}-${NC}"
            else
                diagram+="."
            fi
        done
        diagram+="\n"
    done

    output=''

    Runit="b"
    devideBy=10

    avgR=$(expr $sumR / ${#arrayR[@]})

    if [ $avgR -gt 10240 ];
    then
        Runit="kb"
        devideBy=10240
    fi

    if [ $avgR -gt 10485760 ];
    then
        Runit="mb"
        devideBy=10485760
    fi

    output+="avg receving: $(expr $avgR / $devideBy) $Runit\n"

    lastT=$newT
    lastR=$newR

    seconds=`sudo cat /proc/uptime | tr "." " "`
    seconds=($seconds)
    seconds=${seconds[0]}

    output+="System is running $(expr $seconds / 86400) days or $(expr $seconds / 3600) hours or $(expr $seconds / 60) minutes or $seconds seconds\n"

    percentage=`sudo cat /sys/class/power_supply/BAT0/uevent | grep -w POWER_SUPPLY_CAPACITY=*`
    percentage=${percentage:22}

    output+="Batery: $percentage %\n"

    memTotal=`sudo cat /proc/meminfo | grep -w MemTotal:*`
    memTotal=($memTotal)
    memTotal=${memTotal[1]}

    memAvailable=`sudo cat /proc/meminfo | grep -w MemAvailable:*`
    memAvailable=($memAvailable)
    memAvailable=${memAvailable[1]}

    output+="Memory: $(expr $(expr $memTotal - $memAvailable) \* 100 / $memTotal) %\n"

    loadavg=`sudo cat /proc/loadavg`

    output+="Loadavg: $loadavg\n"

    cpus=$(cat /proc/stat | grep 'cpu'[0-9])
    
    lastIFS=$IFS
    IFS=$'\n'
    for cpu in $cpus
    do
        IFS=$' '
        values=($cpu)
        lastcpu=$(grep ${values[0]} -w <<< $lastcpus)
        lastvalues=($lastcpu)
        sum=0
        for i in 1 2 3 4 5 6 7 8 9 10
        do
            sum=$(expr $sum + ${values[$i]} - ${lastvalues[$i]})
        done

        idle=$(expr ${values[4]} - ${lastvalues[4]})
        used=$(expr $sum - $idle)

        output+="${values[0]}: $(expr 100 \* $used / $sum) %\n"
    done

    IFS=$lastIFS
    lastcpus=$cpus

    echo "Transmiting: "
    echo -e $diagram | column -t
    echo -e $output
    wait
done
