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
        plt.scatter( data[:,0], data[:,1], label=sys.argv[i], s=1 )
    else:
        plt.plot( data, label=sys.argv[i] )

plt.legend(loc="upper left")
plt.xlabel("x")
plt.ylabel("y")
plt.grid( True )
plt.savefig(sys.argv[1])
#plt.show()
