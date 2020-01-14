import matplotlib
matplotlib.use('Agg');


import numpy as np
import matplotlib.pyplot as plt
import sys

import convert 
import datetime

n = len( sys.argv )

if ( n== 2):
    print("Need at least 1 file")
    sys.exit()

# loop files
for i in np.arange(2,n,1):
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
plt.xlabel("datetime")
plt.ylabel("val")
plt.grid( True )
plt.savefig(sys.argv[1])
#plt.show()
