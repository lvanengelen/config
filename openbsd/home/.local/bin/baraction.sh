#!/bin/sh
#
# $scrotwm: baraction.sh,v 1.17 2010/07/01 19:49:37 marco Exp $

print_mem() {
    MEM=`/usr/bin/top | grep Free: | cut -d " " -f6`
    echo -n "M: $MEM "
}

_print_cpu() {
    echo -n "U: ${1}% N: ${2}% S: ${3}% I: ${4}% Id: ${5}% "
}

print_cpu() {
    OUT=""
    # iostat prints each column justified to 3 chars, so if one counter
    # is 100, it jams up agains the preceeding one. sort this out.
    while [ "${1}x" != "x" ]; do
        if [ ${1} -gt 99 ]; then
            OUT="$OUT ${1%100} 100"
        else
            OUT="$OUT ${1}"
        fi
        shift;
    done
    _print_cpu $OUT
}

print_apm() {
    BAT_STATUS=$1
    BAT_LEVEL=$2
    AC_STATUS=$3

    if [ $AC_STATUS -ne 255 -o $BAT_STATUS -lt 4 ]; then
        if [ $AC_STATUS -eq 0 ]; then
            echo -n "on batt (${BAT_LEVEL}%)"
        else
            case $AC_STATUS in
            1)
                AC_STRING="AC: "
                ;;
            2)
                AC_STRING="backup AC: "
                ;;
            *)
                AC_STRING=""
                ;;
            esac;
            case $BAT_STATUS in
            4)
                BAT_STRING="(no batt)"
                ;;
            [0-3])
                BAT_STRING="(batt ${BAT_LEVEL}%)"
                ;;
            *)
                BAT_STRING="(batt ???)"
                ;;
            esac;
        
            FULL="${AC_STRING}${BAT_STRING} "
            if [ "$FULL" != "" ]; then
                echo -n "$FULL"
            fi
        fi
    fi
    echo -n "  "
}

print_cpuspeed() {
    CPU_SPEED=`/sbin/sysctl hw.cpuspeed | cut -d "=" -f2`
    echo -n "$CPU_SPEED MHz "
}

print_wifi_signal() {
    WIFI_SIGNAL=`/sbin/ifconfig athn0 | grep ieee80211 | cut -d' ' -f 8`
    echo -n "W: $WIFI_SIGNAL  "
}

print_volume() {
    MUTE=`mixerctl outputs.master.mute | cut -d= -f 2`
    if [ "x$MUTE" = "xon" ]; then
        VOLUME=mute
    else
        VOLUME=`mixerctl -n outputs.master`
    fi
    echo -n "V: $VOLUME "
}

while :; do
    # instead of sleeping, use iostat as the update timer.
    # cache the output of apm(8), no need to call that every second.
    /usr/sbin/iostat -C -c 3600 |&  # wish infinity was an option
    PID="$!"
    APM_DATA=""
    I=0
    trap "kill $PID; exit" TERM
    while read -p; do
        if [ $(( ${I} % 1 )) -eq 0 ]; then
            APM_DATA=`/usr/sbin/apm -alb`
        fi
        if [ $I -gt 2 ]; then
            # print_date
            print_mem $MEM
            print_cpu $REPLY
            print_cpuspeed
            print_apm $APM_DATA
            print_wifi_signal
            print_volume
            echo ""
        fi
        I=$(( ${I} + 1 ));
    done
done
