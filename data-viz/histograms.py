import matplotlib
matplotlib.use('Agg');


import numpy as np
import matplotlib.pyplot as plt
import sys

from mpl_toolkits import mplot3d


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
        nbin = 25
        hi = np.histogram2d( data[:,0], data[:,1], bins=nbin ) 
        first =  np.array( hi[0] )
        second = np.array(  hi[1] )
        third =  np.array( hi[2] )
        first = np.insert( first, 0, np.array( [np.zeros(nbin)] ), axis=0) 
        #first[0] = np.insert( first[0], 0, 0, axis=0)

        plt.show()
        a = len(first)
        b = len(second)
        c = len(third)
        nx = []
        ny = []
        nz = []
        for i in np.arange(0,a,1):
            for j in np.arange(0, len(first[i]), 1):
                nx.append( second[i] )
                ny.append( third[j] )
                nz.append( first[i][j] )
        nx = np.array( nx)
        ny = np.array( ny )
        nz = np.array( nz)
        fig = plt.figure()
        ax = plt.axes(projection="3d")
        #ax.plot3D( nx,ny,nz, 'gray')
        #ax.scatter3D( nx,ny,nz, 'gray')
        #NX, NY = np.meshgrid( nx,ny)
        #ax.plot_surface(NX,NY, first,cmap='viridis', edgecolor='none')
        #ax.plot_wireframe( nx,ny,nz, color='gray')
        nzt = nz
        c=0
        for i in nz:
            if ( i > 0 ):
                nzt[c] = np.log10( i )
            else:
                nzt[c] =0
            c = c+1
        ax.plot_trisurf(nx,ny,nz, cmap='viridis', edgecolor='none')
        #print( nx.size, ny.size, nz.size)
        ax.set_zlabel('log10(count)');
    else:
        nbin=50
        hi = np.histogram(data, bins=nbin)
        first = np.array( hi[0] )
        second = np.array( hi[1] )
        first = np.insert( first, 0, 0, axis=0) # prepend a 0
#    print(first)
#    print( " " );
#    print(second)
#    print(len(first), len(second))
        plt.plot( second, first, label=sys.argv[i] )

plt.legend(loc="upper left")
plt.xlabel( xlab )
plt.ylabel( ylab )
plt.grid( True )
plt.savefig( picname )
#plt.show()
