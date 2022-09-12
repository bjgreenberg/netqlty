### Created by Brian Greenberg
### bjg@acm.org / briangreenberg.net
### ⓒ 2022 Brian Greenberg All Rights Reserved.

clear
wrk=netqlty.tmp
out=netqlty.txt

countdown() {
    secs=$((5 * 60))
    shift
    msg=$@
    while [ $secs -gt 0 ]; do
        printf "\r\033[KWaiting %.d seconds $msg" $((secs--))
        sleep 1
    done
    echo
    }

while true; do
    clear
    oldifs="${IFS}"
    IFS=","

    echo "Running networkQuality tool..."

    networkQuality -v > $wrk

    up=`grep "Upload capacity" $wrk|awk '{print $3}'`
    dn=`grep "Download capacity" $wrk|awk '{print $3}'`
    upfl=`grep "Upload flows" $wrk|awk '{print $3}'`
    dnfl=`grep "Download flows" $wrk|awk '{print $3}'`
    respon_level=`grep "Respons" $wrk|awk '{print $2}'`
    respon_qty=`grep "Respons" $wrk|awk '{print $3}'|tr -d '()'`
    rtt=`grep "Download flows" $wrk|awk '{print $3}'`
    date=`date`
    echo
    echo $date,$up,$dn,$upfl,$dnfl,$respon_level,$respon_qty,$rtt >> $out

    rm $wrk

    echo
    printf "%-30s %s\t%s  %s   %s   %s   %s   %s\n" "Date" "Upload" "Download" "Up" "Dn" "Respon" "RPM" "RTT"
    echo "------------------------------------------------------------------------------"
    while read -r date up down uflow dflow rlvl rrpm rtt ; do
        printf "%-30s %.3f\t%.3f   %i   %i   %s   %i   %i\n" "$date" "$up" "$down" "$uflow" "$dflow" "$rlvl" "$rrpm" "$rtt"
    done < <(tail $out)

    echo
    IFS="${oldifs}"
    countdown
    echo
done


 
