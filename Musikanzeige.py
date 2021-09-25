import json
import codecs
import time
import os
import sys
import numpy as np

cstate = str(sys.argv[1])
cname = sys.argv[2]
cinterpret = sys.argv[3]
clength = sys.argv[4]
ctime = sys.argv[5]


def updateSong():
    os.system('cls' if os.name == 'nt' else 'clear') 
    print("\n" + cname + "\n" + cinterpret)
    progressBar(0,clength)


def progressBar(current, total, barLength = 25):
    percent = float(current) * 100 / int(total)
    arrow   = '-' * int(percent/100 * barLength - 1) + '>'
    spaces  = ' ' * (barLength - len(arrow))

    print('Progress: [%s%s] %d %%' % (arrow, spaces, percent), end='\r')

def progressedBar(current, total, barLength = 25):
    percent = float(current) * 100 / int(total)
    arrow   = '-' * int(percent/100 * barLength - 1) + '>'
    spaces  = ' ' * (barLength - len(arrow))

    print('Progress: [%s%s] %d  %%' % (arrow, spaces, percent))


updateSong()
if(cstate == "play"):
    while(int(ctime)<int(clength)):
        progressBar(ctime,clength)
        time.sleep(1)
        ctime =  1 + int(ctime)
else:
    progressedBar(ctime,clength)
