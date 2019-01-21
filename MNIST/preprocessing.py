#! -*- encoding:utf-8 -*-
import sys
import os
from PIL import Image
reload(sys)
sys.setdefaultencoding('utf-8')

def resizing(image_name, size):
    processed = os.listdir("./user_input")
    if image_name.strip("./") + "_preprocessed.png" in processed:
        print("Image preprocessed successfully")
        return image_name.strip("./") + "_preprocessed.png"
    if type(size) != type(()):
        print "Size should be tuple (width, height)"
        return 0

    try:
        im = Image.open(image_name)
        res = im.resize(size)
        res = color2mono(res, size)
        res.save("./user_input/" + image_name + "_preprocessed.png", "PNG")
        print("Image preprocessed successfully")
        return image_name.strip("./") + "_preprocessed.png"
    except IOError:
        print("Can't find Image")

def color2mono(image, size):
    mono = image.convert('1')
    return mono

resizing("./VMware_vCloud.jpg", (128, 128))