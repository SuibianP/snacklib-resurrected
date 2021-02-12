#! /usr/bin/env python

from __future__ import print_function
import sys
if sys.version_info[0] == 2:
    from Tkinter import *
else:
    from tkinter import *

from tkSnack import *

root = Tkinter.Tk()

initializeSnack(root)

# Load the sphere format package

Tk().tk.eval('package require snacksphere')

snd = Sound()

file = 'test.sph'

print('reading sphere file \'%s\'' % file)
snd.read(file)

print('playing file \'%s\'' % file)
snd.play(blocking=1)

print('writing wav file \'%s\'' % file)
snd.write('new.wav')
