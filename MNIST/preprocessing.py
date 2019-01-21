#! -*- encoding:utf-8 -*-
import sys
import os
from PIL import Image
reload(sys)
sys.setdefaultencoding('utf-8')

# Resizing image to fit tensorflow model input size
# Parameter
#     image_name: File name of user input
#     size:       Size of input for tensorflow model
# Return
#     The file name of preprocessed file

def resizing(image_name, size):

    processed = os.listdir("./user_input")
    if image_name.strip("./") + "_preprocessed.png" in processed:
        print("Image preprocessed successfully")
        return "./user_input/" + image_name.strip("./") + "_preprocessed.png"
    if type(size) != type(()):
        print "Size should be tuple (width, height)"
        return 0

    try:
        im = Image.open(image_name)
        res = im.resize(size)
        res = color2mono(res)
        res = make_darker(res)
        image_name = image_name.split("/")[-1]
        res.save("./user_input/" + image_name + "_preprocessed.png", "PNG")
        print("Image preprocessed successfully")
        return "./user_input/" + image_name.strip("./") + "_preprocessed.png"
    except IOError, e:
        print e
        print("Can't find Image")

# Convert colorful RGB image to monotone image
# Parameter
#   image: Image object which wants to conver RGB to greyscale
# Return
#   Converted Image object
def color2mono(image):
    mono = image.convert('LA')
    return mono

def make_darker(image):
    pixel = image.load()
    size = image.size

    for y in range(size[1]):
        for x in range(size[0]):
            if pixel[x, y][0] < 200:
                pixel[x, y] = (max(pixel[x, y][0] - 100, 0), pixel[x, y][1])

    return image