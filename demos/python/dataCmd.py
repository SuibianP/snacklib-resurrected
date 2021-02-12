#! /usr/bin/env python
# -*- coding: iso-8859-1 -*-

import sys
if sys.version_info[0] == 2:
    import Tkinter
else:
    import tkinter as Tkinter

import tkSnack

root = Tkinter.Tk()
tkSnack.initializeSnack(root)

s = tkSnack.Sound()
data = open('ex1.wav', 'rb').read()
s.data(data)
s.write('copy.wav')
