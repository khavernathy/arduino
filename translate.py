import numpy as np
import convert

f = open("DATA/T3.dat")
x = f.readlines()

f2 = open("DATA/T3.conv", "w")

for i in np.arange( 0, len(x), 1):
    s = x[i].split()
    f2.write( str( convert.convert( s[0] ) ) + " " + str( s[1] ) + "\n" ) 

f2.close()
f.close()
