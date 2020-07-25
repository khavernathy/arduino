import matplotlib
matplotlib.use('Agg');


import numpy as np
import matplotlib.pyplot as plt
import sys

import convert 
import datetime

n = len( sys.argv )

picname = sys.argv[1]
xlab = sys.argv[3]
ylab = sys.argv[4]
title = sys.argv[2]
if ( n < 6):
    print("Need at least 1 file")
    sys.exit()

# loop files
for i in np.arange(5,n,1):
    data = np.loadtxt( sys.argv[i] )

    if (np.size(data) / len(data) == 2):
        dates = data[:,0]
        dates2 = []
        for x in dates:
            dates2.append( datetime.datetime.strptime (str(convert.convert( x )), "%m/%d/%Y %H:%M:%S" ) )
        #print(dates2)
        #dates2 = matplotlib.dates.date2num( dates2 )
        #plt.plot_date( dates2, data[:,1], label=sys.argv[i], s=1 )
        plt.scatter( dates2, data[:,1], label=sys.argv[i], s=1 )
        plt.gcf().autofmt_xdate()
    else:
        plt.plot( data, label=sys.argv[i] )

plt.legend(loc="upper left")
plt.xlabel( xlab ) 
plt.ylabel( ylab )
plt.title( title )
plt.grid( True )
plt.savefig( picname )
#plt.show()
