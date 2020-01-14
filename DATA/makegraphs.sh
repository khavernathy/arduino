#!/bin/bash

#xmgrace -autoscale none -par myfile.par -hdevice PNG -hardcopy -printfile image.png file.txt
#xmgrace -hdevice PNG -hardcopy -printfile T.png    T3_*.dat
#xmgrace -hdevice PNG -hardcopy -printfile LIGHT.png    LIGHT_*.dat
#xmgrace -hdevice PNG -hardcopy -printfile RH.png    RH_*.dat 

while [ 1 ]; do
export DISPLAY=:0
python="/usr/bin/python3.6"
$python graph.py T3.png     T3_*.dat
$python graph.py LIGHT.png  LIGHT_*.dat
$python graph.py RH.png     RH_*.dat

bash coorelations.sh   # will make 3 more for coorelations of Temp,Humid,Light
sleep 60;
done
