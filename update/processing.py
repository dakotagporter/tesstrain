import glob
import os
import cv2

from skimage import img_as_ubyte
from skimage.data import page
from skimage.filters import threshold_sauvola
from skimage.io import imsave

# Enter 'data' directory
os.chdir("./data")

# Search recursively through all files for the png's created by conversion.sh
for file in glob.glob("**/*.png", recursive = True):
    # Read in image file
    img = cv2.imread(file, 0)
    
    # Use skimage to process image
    window_size = 25
    thresh_sauvola = threshold_sauvola(img, window_size=window_size)
    binary_sauvola = img > thresh_sauvola
    unit_img = img_as_ubyte(binary_sauvola)
    
    # Print status to console and save new file
    string = f"{file}_bw.png"
    filename = string.replace(" ", "_")
    print(f"Writing {filename}")
    imsave(filename, unit_img)


