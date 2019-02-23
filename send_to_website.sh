#!/bin/bash

numlines=30000 # 60000
numcol=7 # number of data columns for filtering bad lines
emailto="khaverim7@gmail.com ilonastenstrom@yahoo.com" # dfranz@mail.usf.edu"
lastemail=0

# float number comparison
fcomp() {
    awk -v n1="$1" -v n2="$2" 'BEGIN {if (n1+0<n2+0) exit 0; exit 1}'
}

timestamp() {
    date +"%s" 
}

while true; do
    thetime=$(timestamp)
    email="off"
    cat putty.log | grep -v "PuTTY" | tail -$numlines | awk -v nc=$numcol {'if (NF==nc) print; '}> putty.tmp
    cat putty.tmp | awk {'print $1, $2, $3'} > T_hu.dat
    cat putty.tmp | awk {'print $1, $2, $6'} > T_th.dat
    cat putty.tmp | grep -v "\-196\.60" | awk {'print $1, $2, $7'} > T_wa.dat  # catch false readings -196.60
    cat putty.tmp | awk {'print $1, $2, $4'} > RH.dat    
    cat putty.tmp | awk {'print $1, $2, $5'} > light.dat

    dos2unix *dat;

    python makegraphs.py

    scp *dat.png r59cz9hyyldq@166.62.72.227:~/public_html/fish/
    echo "sent arduino data to website at "$(date)


    # check if we need to send email notice
    maxT=79; which=""
    minT=66;  
    while read p; do
        temp=$(echo $p | awk {'print $3'})
        if fcomp $maxT $temp; then
            which="hot"
        elif fcomp $temp $minT; then
            which="cold"
        fi
        if [[ "$which" != "" ]]; then
            offender=$(echo $p | awk {'print $1,$2,"...",$3," deg F"'})
            email="on"  
            subject="The house temperature is a bit $which"
            content="Hey the temperature from the office thermometer is $temp F in at least one of the last 100 data points
                     The offending entry is:
                     $offender"
            break
        fi
    done < <(cat T_th.dat | tail -100)


    # send email if needed
    if [[ "$email" == "on" ]]; then
        timediff=$(echo "$thetime - $lastemail" | bc -l)
        if fcomp $timediff 3600; then  # if it's been less than 1hr since last email, dont
            email="off"
        fi
        if [[ "$email" == "on" ]]; then
            echo "$content" | mail -s "$subject" $emailto   # ~ /etc/ssmtp/ssmtp.conf
            lastemail=$(timestamp)
            echo "Sent alert email to $emailto at "$(date)". Last email was "$(echo $timediff'/60.0' | bc -l)" minutes ago."
        fi
    fi

    sleep 60;
done
