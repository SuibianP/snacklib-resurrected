#! /usr/bin/env python

import sys
if sys.version_info[0] == 2:
    from Tkinter import *
else:
    from tkinter import *

from tkSnack import *

root = Tkinter.Tk()

initializeSnack(root)

s = Sound(load='ex1.wav')
c = SnackCanvas(height=300, width=300)
c.pack()
c.create_section(0, 0, sound=s, start=6000, end=6100, height=300, width=300)

Button(root, text='Exit', command=root.quit).pack()

root.mainloop()
