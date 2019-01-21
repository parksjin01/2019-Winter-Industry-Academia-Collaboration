#! -*- encoding:utf-8 -*-
import sys
import os
from PIL import Image
reload(sys)
sys.setdefaultencoding('utf-8')

# Read image file and convert image to one-hot encoding list
# Parameter
#   image_name: Image file name which user wants to read
# Return
#   List of one-hot encoding
def read(image_name):
    try:
        img = Image.open(image_name)
        pixel = img.load()
        size = img.size
        one_hot = []

        for y in range(size[1]):
            tmp = []
            for x in range(size[0]):
                # print(pixel[x, y])
                tmp.append(abs(pixel[x, y] - 255) / 255.0)
            one_hot.append(tmp)

        return one_hot
    except IOError:
        print("Can't find image file")
