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
	if [ "$#" -eq 1 ]; then   # only the last $1 lines
		tail -$1 thermistor > tmp; mv tmp thermistor
		tail -$1 waterproof > tmp; mv tmp waterproof
		tail -$1 light > tmp;      mv tmp light
	fi
	echo "Making time graphs."
	echo "------------------"
	echo "	temperatures.."
	wp_current=$(tail -1 waterproof | awk {'print $2'})
	th_current=$(tail -1 thermistor | awk {'print $2'})
	title="Waterproof: $wp_current F; Thermistor: $th_current F"
	$python timegraph.py T.png     "$title" "date" "temp (°F)"      waterproof thermistor
	echo "	light.."
	title="Light: "$(tail -1 light | awk {'print $2'})
	$python timegraph.py LIGHT.png "$title" "date" "LIGHT"         light

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
		cat "$x" | awk {'if ($2 == 0) { print $2; } else { print log($2); }'} >> light
	done
	
	echo "";
	echo "Making correlation graphs."
	echo "------------------"
	echo "	temp + log(light).."
	paste thermistor light > air-temp_light_corr;
	$python correlations.py TL.png "temp (F)" "log( light )" air-temp_light_corr

	echo ""
	echo "Making histogram graphs."
	echo "------------------"
	# HISTOGRAMS
	cat air-temp_light_corr | awk {'print $2,$1'} > lt
	#$python histograms.py HISTO2D_TL.png "log( light )" "temp (F)" lt
	echo "	temperatures.."
	$python histograms.py  HISTO_T.png  "Temperature (F)" "count"  waterproof thermistor
	echo "	light.."
	$python histograms.py  HISTO_LIGHT.png "log( light )" "count" light

	rm lt light    air-temp_light_corr thermistor waterproof
	echo ""
	echo "Done. waiting for a min."
	sleep 300;
done
