#!/bin/sh
#
# $scrotwm: baraction.sh,v 1.17 2010/07/01 19:49:37 marco Exp $

update_mem() {
    MEM=`/usr/bin/top | grep Free: | cut -d " " -f6`
}

_update_cpu() {
    CPU_USR=$1
    CPU_NCE=$2
    CPU_SYS=$3
    CPU_INT=$4
    CPU_IDL=$5
}

update_cpu() {
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
    _update_cpu $OUT

    CPU_SPEED=`/sbin/sysctl hw.cpuspeed | cut -d "=" -f2`
}

_update_apm() {
    BAT_STATUS=$1
    BAT_LEVEL=$2
    AC_STATUS=$3
}

update_apm() {
    _update_apm `/usr/sbin/apm -alb`
}

update_ifs() {
    NETIFS=`systat ifstat | grep up:U`
}

update_wifi_signal() {
    WIFI_SIGNAL=`/sbin/ifconfig $1 | grep ieee80211 | cut -d' ' -f 8`
}

update_volume() {
    MUTE=`mixerctl outputs.master.mute | cut -d= -f 2`
    VOLUME=`mixerctl -n outputs.master`
}

print_mem() {
    echo -n "$MEM"
}

print_cpu() {
    echo -n "$CPU_USR $CPU_NCE $CPU_SYS $CPU_INT $CPU_IDL $CPU_SPEED"
}

print_bat() {
    case $AC_STATUS in
        1)
            AC_STRING="AC "
            ;;
        2)
            AC_STRING="ac "
            ;;
        *)
            AC_STRING=""
            ;;
    esac

    if [ $BAT_STATUS -lt 4 ]; then
        echo -n "$AC_STRING$BAT_LEVEL%"
    fi
}

print_ifs() {
    echo $NETIFS | while read nif; do
        update_wifi_signal
        echo -n "$WIFI_SIGNAL$x"
        x=" "
    done
}

print_vol() {
    if [ $MUTE = "on" ]; then
        echo -n "mute"
    else
        echo -n "$VOLUME"
    fi
}

while :; do
    # instead of sleeping, use iostat as the update timer.
    # cache the output of apm(8), no need to call that every second.
    /usr/sbin/iostat -C -c 3600 |&  # wish infinity was an option
    PID="$!"
    I=0
    trap "kill $PID; exit" TERM
    
    while read -p; do
        if [ $(( ${I} % 5 )) -eq 0 ]; then
            update_apm
            update_ifs
        fi

        if [ $I -gt 2 ]; then
            update_mem
            update_cpu $REPLY
            update_volume

            print_mem
            echo -n " "
            print_cpu
            echo -n " "
            print_bat
            echo -n " "
            print_ifs
            echo -n " "
            print_vol
            echo ""
        fi

        I=$(( ${I} + 1 ));
    done
done
