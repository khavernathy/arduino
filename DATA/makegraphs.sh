#!/bin/bash

#xmgrace -autoscale none -par myfile.par -hdevice PNG -hardcopy -printfile image.png file.txt
#xmgrace -hdevice PNG -hardcopy -printfile T.png    T3_*.dat
#xmgrace -hdevice PNG -hardcopy -printfile LIGHT.png    LIGHT_*.dat
#xmgrace -hdevice PNG -hardcopy -printfile RH.png    RH_*.dat 

while [ 1 ]; do
	export DISPLAY=:0
	python="/usr/bin/python3.6"
	$python timegraph.py T3.png     T3_*.dat
	$python timegraph.py LIGHT.png  LIGHT_*.dat
	$python timegraph.py RH.png     RH_*.dat


	[ -f t ] && rm t;
	touch t;
	for x in ./T3_*; do
		cat "$x" | awk {'print $2'} >> t
	done
	[ -f l ] && rm l;
	touch l;
	for x in ./LIGHT_*; do
		cat "$x" | awk {'print $2'} >> l
	done
	[ -f h ] && rm h;
	touch h;
	for x in ./RH_*; do
		cat "$x" | awk {'print $2'} >> h
	done

	paste t l > tl;
	paste t h > th;
	paste l h > lh;
	rm l t h;
	python="/usr/bin/python3.6"
	$python coorelations.py TL.png tl
	$python coorelations.py TH.png th
	$python coorelations.py LH.png lh

	rm tl th lh;

	sleep 60;
done
