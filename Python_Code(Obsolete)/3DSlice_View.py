import PIL
from PIL import Image
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy
import tifffile
import os

final = []

for fname in os.listdir('img/'):
#        print(os.listdir('img/'))

        im = Image.open(os.path.join('img/',fname))
        imarray = numpy.array(im)
        final.append(imarray)


final = numpy.asarray(final)

final.shape

round(final[:,153,:].shape[1]/2)
5/2

import tkinter
#from tkinter import *
#from PIL import ImageTk
from tkinter import filedialog

window = tkinter.Tk()
window.title("Slice View window")
height, width =  final[0].shape
height
width

#canvas= tkinter.Canvas(window,width = width, height = height)

def  updatetext():
    b.configure(text=w.get())
    photoX = PIL.ImageTk.PhotoImage(image = PIL.Image.fromarray(final[w.get(),:,:]))
    photoY = PIL.ImageTk.PhotoImage(image = PIL.Image.fromarray(final[:,w.get(),:]))
    photoZ = PIL.ImageTk.PhotoImage(image = PIL.Image.fromarray(final[:,:,w.get()]))

    panelX.configure(image=photoX)
    panelX.image = photoX

    panelY.configure(image=photoY)
    panelY.image = photoY

    panelZ.configure(image=photoZ)
    panelZ.image = photoZ
b = Button(window,text="Update Image", width=10,height=1,command = updatetext)
b.grid(row=0,column =0)
#photoX = PIL.ImageTk.PhotoImage(image = PIL.Image.fromarray(final[153,:,:]))
#photoY = PIL.ImageTk.PhotoImage(image = PIL.Image.fromarray(final[:,153,:]))
#photoZ = PIL.ImageTk.PhotoImage(image = PIL.Image.fromarray(final[:,:,153]))
photoX = Image.fromarray(final[153,:,:])
photoY = Image.fromarray(final[:,153,:])
photoZ = Image.fromarray(final[:,:,153])

photoX

photoXres=photoX.resize((round(photoX.width*.5), round(photoX.height*.5)))
photoYres=photoY.resize((round(photoY.width*.5), round(photoY.height*.5)))
photoZres=photoZ.resize((round(photoZ.width*.5), round(photoZ.height*.5)))

photoXres

#canvas.create_image(0,0, image=photo,anchor =tkinter.NW)
panelX = tkinter.Label(window, image= photoXres)
panelY = tkinter.Label(window, image= photoYres)
panelZ = tkinter.Label(window, image= photoZres)

w = Scale(window, from_=1, to=1024, orient=HORIZONTAL)
#w.pack()
w.grid(row=1,column=0)

#panel.pack()
panelX.grid(row=2,column=0)
panelY.grid(row=2,column=1)
panelZ.grid(row=2,column=2)


window.mainloop()


#sample_img = final[:,:,153]
#plt.imshow(sample_img)

#sample_img = final[:,153,:]
#plt.imshow(sample_img)
#sample_img = final[153,:,:]
#plt.imshow(sample_img)
