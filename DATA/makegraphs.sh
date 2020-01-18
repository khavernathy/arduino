#!/bin/bash

#xmgrace -autoscale none -par myfile.par -hdevice PNG -hardcopy -printfile image.png file.txt
#xmgrace -hdevice PNG -hardcopy -printfile T.png    T3_*.dat
#xmgrace -hdevice PNG -hardcopy -printfile LIGHT.png    LIGHT_*.dat
#xmgrace -hdevice PNG -hardcopy -printfile RH.png    RH_*.dat 

# IDs
# T1:       temperature, RH sensor
# RH:       rel humidity, RH sensor
# LIGHT:    light sensor
# T2:       temperature, thermistor
# T3:       temperature, waterproof probe

# list of output pngs
#	T.png  	-- thermistor and waterproof temps over time
# 	LIGHT.png	-- light over time
#	TL.png		-- thermistor temp + light correlation
# 	HISTO2D_TL.png	-- thermistor temp + light 2D histogram
#	HISTO_T.png	-- thermistor and waterproof probe 1D histogram
# 	HISTO_LIGHT.png -- light 1D histogram

while [ 1 ]; do
	# TIME FUNCTIONS
	export DISPLAY=:0
	python="/usr/bin/python3.6"
	[ -f thermistor ] && rm thermistor
	touch thermistor
	for x in ./T2_*.dat; do
		cat "$x" >> thermistor
	done
	[ -f waterproof ] && rm waterproof
	touch waterproof
	for x in ./T3_*.dat; do
		cat "$x" >> waterproof
	done
	[ -f light ] && rm light
	touch light
	for x in ./LIGHT_*.dat; do
		cat "$x" >> light
	done
	$python timegraph.py T.png     "date" "temp (F)"      waterproof thermistor
	$python timegraph.py LIGHT.png "date" "LIGHT"         light
#	$python timegraph.py RH.png    "date" "Rel Hum %"     RH_*.dat

	# CORRELATIONS
	[ -f thermistor ] && rm thermistor;
	touch thermistor
	for x in ./T2_*; do
		cat "$x" | awk {'print $2'} >> thermistor
	done
	[ -f waterproof ] && rm waterproof;
	touch waterproof;
	for x in ./T3_*; do
		cat "$x" | awk {'print $2'} >> waterproof
	done
	[ -f light ] && rm light;
	touch light;
	for x in ./LIGHT_*; do
		cat "$x" | awk {'print log($2)'} >> light
	done
#	[ -f h ] && rm h;
#	touch h;
#	for x in ./RH_*; do
#		cat "$x" | awk {'print $2'} >> h
#	done

	paste thermistor light > air-temp_light_corr;
#	paste t h > th;
#	paste l h > lh;
	$python correlations.py TL.png "temp (F)" "log( light )" air-temp_light_corr
#	$python correlations.py TH.png "temp (F)" "Rel Hum %" th
#	$python correlations.py LH.png "LIGHT" "Rel Hum %" lh

	# HISTOGRAMS
	cat air-temp_light_corr | awk {'print $2,$1'} > lt
	$python histograms.py HISTO2D_TL.png "log( light )" "temp (F)" lt
#	$python histograms.py HISTO2D_TH.png "temp (F)" "Rel Hum %" th
#	$python histograms.py HISTO2D_LH.png "LIGHT" "Rel Hum %" lh
	$python histograms.py  HISTO_T.png  "Temperature (F)" "count"  waterproof thermistor
	$python histograms.py  HISTO_LIGHT.png "log( light )" "log10( count )" light
#	$python histograms.py HISTO_RH.png "RH" "count" h

	rm lt light thermistor waterproof  air-temp_light_corr
	sleep 60;
done
