#!/bin/bash

# temperature and light
rm t; touch t;
for x in ./T3_*; do
	cat "$x" | awk {'print $2'} >> t
done
rm l; touch l;
for x in ./LIGHT_*; do
	cat "$x" | awk {'print $2'} >> l
done
rm h; touch h;
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
