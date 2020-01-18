#!/bin/bash

# IDs
# T1:       temperature, RH sensor
# RH:       rel humidity, RH sensor
# LIGHT:    light sensor
# T2:       temperature, thermistor
# T3:       temperature, waterproof probe

while [ 1 ]; do

    scp sci:~/arduino/output_* .

    c=0
    for x in ./output_*; do
        cat "$x" | awk {'print $1, $2'} > DATA/T1_$c.dat
        cat "$x" | awk {'print $1, $3'} > DATA/RH_$c.dat
        cat "$x" | awk {'print $1, $4'} > DATA/LIGHT_$c.dat
        cat "$x" | awk {'print $1, $5'} > DATA/T2_$c.dat
        cat "$x" | awk {'print $1, $6'} > DATA/T3_$c.dat
        let c=$c+1
    done

    # to convert timestamp -> UTC -> EST
    #python -c "stmp=1577035548; import datetime;  print( datetime.datetime.utcfromtimestamp( stmp + 3600 ).strftime('%d %b %Y %H:%M:%S') );"

    scp DATA/*dat web:/var/www/html/arduino/DATA

    sleep 60;
done
