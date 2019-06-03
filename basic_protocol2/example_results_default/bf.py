#!/usr/bin/env python
# Utility to calculate the Bayes factors and model probabilities
# (c) Peter Beerli 2010, updated 2015
#
from __future__ import print_function
import sys
import math
data = []

def help():
    print  ("bf.py ---------------------------------------------------------begin help")
    print  ("")
    print  ("This utility calculates Bayes factors and model probabilities")
    print  ("from MIGRATE output text files. Example usage:")
    print  ("grep \"  All    \" outfile* | sort -n -k 4,4  | bf.py <#col>")
    print  ("")
    print  ("A longer example:")
    print  ("grep \"  All    \" outfile_x0Bx outfile_xB0x | sort -n -k 4,4" )
    print  ("generates")
    print  ("outfile_xB0x:  All  -10762.43   -9649.33   -9540.74")
    print  ("outfile_x0Bx:  All  -10726.56   -9638.69   -9535.84")
    print  ("these lines then get parsed and with the default it will parse column 4")
    print  ("for the table, using the full command")
    print  ("grep \"  All    \" outfile_x0Bx outfile_xB0x | sort -n -k 4,4 | bf.py" )
    print  ("you get something like this")
    print  (" ")
    print  ("Model                       Log(mL)   LBF     Model-probability")
    print  ("---------------------------------------------------------------")
    print  ("1:outfile_xB0x:                 -9649.33   -10.64        0.0000")
    print  ("2:outfile_x0Bx:                 -9638.69     0.00        1.0000")
    print  ("")
    print  ("")
    print  ("bf.py ----------------------------------------------------------end help")
    
def read():
    data = []
    for line in sys.stdin:
        myline = line.split()
        data.append(myline)
    return data

def bftable(data,index):
    ml=[]
    lastv = -10000000.0;
    for i in data:
        v = float(i[index])
        #print v,index,i
        if lastv < v:
            lastv = v
        ml.append(v)

    maxml = [lastv for i in range(len(ml))]
    sml = ml[:]
    maxsml = max(sml)
    bf = [smli - maxsml for smli in sml]
    es = [math.exp(smli-maxsml) for smli in sml]
    s = sum(es)
    r = [esi/s for esi in es]
    print ("Model                       Log(mL)   LBF     Model-probability")
    print ("---------------------------------------------------------------")
    di = iter(data)
    si = iter(sml)
    bfi = iter(bf)
    count = 0
    for ri in r:
        count += 1
        print ("%d:%-28.28s  %8.2f %8.2f %13.4f " % (count, di.next()[0], si.next(), bfi.next(), ri))


if __name__ == '__main__':
    index=3
    if len(sys.argv)==2:
        if sys.argv[1]=='-h' or sys.argv[1]=='--help':
            help()
            sys.exit(-1)

        if sys.argv[1]=='-m':
            index=1
        else:
            if len(sys.argv)>1:
                index = int(sys.argv[1])-1
            else:
                index=3

    data = read()
    bftable(data,index)
