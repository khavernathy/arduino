#!/bin/bash


while [ 1 ]; do

    scp sci:~/arduino/output_202* .
    
    cat output_202* | awk {'print $1, $2'} > DATA/T1.dat
    cat output_202* | awk {'print $1, $3'} > DATA/RH.dat
    cat output_202* | awk {'print $1, $4'} > DATA/LIGHT.dat
    cat output_202* | awk {'print $1, $5'} > DATA/T2.dat
    cat output_202* | awk {'print $1, $6'} > DATA/T3.dat

    # to convert timestamp -> UTC -> EST
    #python -c "stmp=1577035548; import datetime;  print( datetime.datetime.utcfromtimestamp( stmp + 3600 ).strftime('%d %b %Y %H:%M:%S') );"

    sleep 60;
done
