import sys
import datetime


def convert( a ):
    ts = float( a ) + 1*3600   #  convert to EST

    value = datetime.datetime.fromtimestamp( ts )
    exct_time = value.strftime('%m/%d/%Y %H:%M:%S')

    return exct_time

    #print( sys.argv[1] );
