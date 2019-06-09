import numpy as np
import matplotlib.pyplot as plt

from skimage import measure

import PIL
from PIL import Image
import os

final = []

for fname in os.listdir('img/'):
#        print(os.listdir('img/'))

        im = Image.open(os.path.join('img/',fname))
        imarray = np.array(im)
        final.append(imarray)


final = np.asarray(final)


# Construct some test data
#x, y = np.ogrid[-np.pi:np.pi:100j, -np.pi:np.pi:100j]
#r = np.sin(np.exp((np.sin(x)**3 + np.cos(y)**2)))
final[153,:,:]
# Find contours at a constant value of 0.8
#contours = measure.find_contours(r, 0.8)
contours2=measure.find_contours(final[153,:,:], 0.8)
# Display the image and plot all contours found
fig, ax = plt.subplots()
ax.imshow(r, interpolation='nearest', cmap=plt.cm.gray)

for n, contour in enumerate(contours2):
    ax.plot(contour[:, 1], contour[:, 0], linewidth=2)

ax.axis('image')
ax.set_xticks([])
ax.set_yticks([])
plt.show()
