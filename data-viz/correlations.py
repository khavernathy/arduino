import matplotlib
matplotlib.use('Agg');


import numpy as np
import matplotlib.pyplot as plt
import sys

import convert 
import datetime

n = len( sys.argv )

picname = sys.argv[1]
xlab = sys.argv[2]
ylab = sys.argv[3]

if ( n < 5):
    print("Need at least 1 file")
    sys.exit()

# loop files
for i in np.arange(4,n,1):
    data = np.loadtxt( sys.argv[i] )

    if (np.size(data) / len(data) == 2):
        plt.scatter( data[:,0], data[:,1], label=sys.argv[i], s=1 )
    else:
        plt.plot( data, label=sys.argv[i] )

plt.legend(loc="upper left")
plt.xlabel( xlab )
plt.ylabel( ylab )
plt.grid( True )
plt.savefig( picname )
#plt.show()
