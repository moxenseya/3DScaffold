import matplotlib.pyplot as plt

from skimage import data
from skimage.filters import try_all_threshold

#img = data.page()
import numpy as np
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

img = final[153,:,:]


fig, ax = try_all_threshold(img, figsize=(10, 8), verbose=False)
plt.show()
