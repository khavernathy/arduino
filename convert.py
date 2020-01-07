import sys
import datetime

ts = float(sys.argv[1]) + 6*3600   #  convert to EST

value = datetime.datetime.fromtimestamp( ts )
exct_time = value.strftime('%d %B %Y %H:%M:%S')

print( exct_time )

#print( sys.argv[1] );
