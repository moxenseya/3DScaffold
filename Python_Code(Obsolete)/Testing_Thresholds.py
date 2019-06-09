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

import skimage
from skimage.feature import canny
from scipy import ndimage as ndi

edges = canny(final[153,:,:]/255.)

edges
fill_bones = ndi.binary_fill_holes(edges)


plt.imshow(fill_bones)














import numpy as np
import matplotlib.pyplot as plt

from skimage import data

#coins = data.coins()

#hotswap slices here
coins = final[,:,:]


hist = np.histogram(coins, bins=np.arange(0, 256))

fig, axes = plt.subplots(1, 2, figsize=(8, 3))
axes[0].imshow(coins, cmap=plt.cm.gray, interpolation='nearest')
axes[0].axis('off')
axes[1].plot(hist[1][:-1], hist[0], lw=2)
axes[1].set_title('histogram of gray values')





fig, axes = plt.subplots(1, 2, figsize=(8, 3), sharey=True)

axes[0].imshow(coins > 100, cmap=plt.cm.gray, interpolation='nearest')
axes[0].set_title('coins > 100')

axes[1].imshow(coins > 150, cmap=plt.cm.gray, interpolation='nearest')
axes[1].set_title('coins > 150')

for a in axes:
    a.axis('off')

plt.tight_layout()

from skimage.feature import canny

edges = canny(coins)

fig, ax = plt.subplots(figsize=(4, 3))
ax.imshow(edges, cmap=plt.cm.gray, interpolation='nearest')
ax.set_title('Canny detector')
ax.axis('off')


from scipy import ndimage as ndi

fill_coins = ndi.binary_fill_holes(edges)

fig, ax = plt.subplots(figsize=(4, 3))
ax.imshow(fill_coins, cmap=plt.cm.gray, interpolation='nearest')
ax.set_title('filling the holes')
ax.axis('off')

from skimage import morphology

coins_cleaned = morphology.remove_small_objects(fill_coins, 21)

fig, ax = plt.subplots(figsize=(4, 3))
ax.imshow(coins_cleaned, cmap=plt.cm.gray, interpolation='nearest')
ax.set_title('removing small objects')
ax.axis('off')



from skimage.filters import sobel



elevation_map = sobel(coins)

fig, ax = plt.subplots(figsize=(4, 3))
ax.imshow(elevation_map, cmap=plt.cm.gray, interpolation='nearest')
ax.set_title('elevation map')
ax.axis('off')


markers = np.zeros_like(coins)
markers[coins < 30] = 1
markers[coins > 150] = 2

fig, ax = plt.subplots(figsize=(4, 3))
ax.imshow(markers, cmap=plt.cm.nipy_spectral, interpolation='nearest')
ax.set_title('markers')
ax.axis('off')



segmentation = morphology.watershed(elevation_map, markers)

fig, ax = plt.subplots(figsize=(4, 3))
ax.imshow(segmentation, cmap=plt.cm.gray, interpolation='nearest')
ax.set_title('segmentation')
ax.axis('off')


from skimage.color import label2rgb


segmentation = ndi.binary_fill_holes(segmentation - 1)
labeled_coins, _ = ndi.label(segmentation)
image_label_overlay = label2rgb(labeled_coins, image=coins)

fig, axes = plt.subplots(1, 2, figsize=(8, 3), sharey=True)
axes[0].imshow(coins, cmap=plt.cm.gray, interpolation='nearest')
axes[0].contour(segmentation, [0.5], linewidths=1.2, colors='y')
axes[1].imshow(image_label_overlay, interpolation='nearest')

for a in axes:
    a.axis('off')

plt.tight_layout()

plt.show()



'''
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

'''
#sample_img = final[:,:,153]
#plt.imshow(sample_img)

#sample_img = final[:,153,:]
#plt.imshow(sample_img)
#sample_img = final[153,:,:]
#plt.imshow(sample_img)
