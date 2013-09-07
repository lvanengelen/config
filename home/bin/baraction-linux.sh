#!/bin/sh

SLEEP_SEC=5

while :; do
    TEMP_STR=$(sensors -u | \
        awk '/temp.*_input/ { printf "%d ", $2 }' | \
        awk '{ printf "Temps:%d,%d,%d,%d,%ddegC", $1, $2, $3, $4, $5 }')

    eval $(cat /proc/net/wireless | sed s/[.]//g | awk '/^[[:alnum:]]+:/ {printf "WLAN_QULTY=%s; WLAN_SIGNL=%s; WLAN_NOISE=%s", $3,$4,$5};' -)
    BCSCRIPT="scale=0;a=100*$WLAN_QULTY/70;print a"
    WLAN_QPCT=`echo $BCSCRIPT | bc -l`
    WLAN_STR="Q=$WLAN_QPCT% S/N="$WLAN_SIGNL"/"$WLAN_NOISE"dBm"

    CPUFREQ_STR=`echo "Freq:"$(cat /proc/cpuinfo | grep 'cpu MHz' | sed 's/.*: //g; s/\..*//g;')`
    CPULOAD_STR="Load:$(uptime | sed 's/.*://; s/,//g')"

    eval $(awk '/^MemTotal/ {printf "MTOT=%s;", $2}; /^MemFree/ {printf "MFREE=%s;",$2}' /proc/meminfo)
    MUSED=$(( $MTOT - $MFREE ))
    MUSEDPT=$(( ($MUSED * 100) / $MTOT ))
    MEM_STR="Mem:${MUSEDPT}%"

    MIXER_STR="Vol:$(amixer get Master | sed -n '$s/^.*\[\(.*\)%].*$/\1/p')%"

    echo -e "$TEMP_STR  $MEM_STR  $WLAN_STR  $MIXER_STR"

    sleep $SLEEP_SEC
done
