import json
import time
import os
cname = "Name"
cinterpret = "Interpret"
clength = 200

def updateSong():
    os.system('cls' if os.name == 'nt' else 'clear') 
    print("\n" + cname + "\n" + cinterpret)
    progressBar(0,clength)


def progressBar(current, total, barLength = 25):
    percent = float(current) * 100 / total
    arrow   = '-' * int(percent/100 * barLength - 1) + '>'
    spaces  = ' ' * (barLength - len(arrow))

    print('Progress: [%s%s] %d %%' % (arrow, spaces, percent), end='\r')

def jsonCheck():
   f = open('musicdb.json', 'r')
   db = json.load(f)

   print(db['teacher_db'][0]['name'])

jsonCheck()
