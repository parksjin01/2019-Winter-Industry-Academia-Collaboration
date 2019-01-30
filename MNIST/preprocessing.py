#! -*- encoding:utf-8 -*-
import sys
import os
from PIL import Image
import pprint
reload(sys)
sys.setdefaultencoding('utf-8')

file_path = (os.path.dirname(os.path.realpath(__file__)) )

# Resizing image to fit tensorflow model input size
# Parameter
#     image_name: File name of user input
#     size:       Size of input for tensorflow model
# Return
#     The file name of preprocessed file

def resizing(image_name, size):

    processed = os.listdir(file_path + "/user_input")
    print processed
    if image_name.split("/")[-1] + "_preprocessed.png" in processed:
        print("Image loaded successfully")
        return file_path + "/user_input/" + image_name.split("/")[-1] + "_preprocessed.png"
    if type(size) != type(()):
        print "Size should be tuple (width, height)"
        return 0

    try:
        im = Image.open(image_name)
        res = color2mono(im)
        res = make_thicker(res, 10)
        # res = make_thicker(res)
        # res = make_thicker(res)
        # res = make_thicker(res)
        # res = make_thicker(res)
        # res = make_thicker(res)
        # res = make_thicker(res)
        res = res.resize(size)
        # res = reverse(res)
        # res = make_darker(res)
        # res = filling(res, 2)
        # res = filling(res, 3)
        image_name = image_name.split("/")[-1]
        res.save(file_path + "/user_input/" + image_name + "_preprocessed.png", "PNG")
        print("Image preprocessed successfully")
        return file_path + "/user_input/" + image_name.strip("./") + "_preprocessed.png"
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

def pixel2array(pixel, size):
    res = []
    for y in range(size[1]):
        tmp = []
        for x in range(size[0]):
            tmp.append(pixel[x, y])
        res.append(tmp)

    return res

def filling(image, level):
    # print pixel
    pixel = image.load()
    size = image.size

    new_pixel = pixel2array(pixel, size)
    for y in range(size[1]):
        for x in range(size[0]):
            cnt = 0
            try:
                if new_pixel[y][x + 1][0] < 128:
                    cnt += 1
            except Exception, e:
                pass

            try:
                if new_pixel[y][x - 1][0] < 128:
                    cnt += 1
            except Exception, e:
                pass

            try:
                if new_pixel[y + 1][x][0] < 128:
                    cnt += 1
            except Exception, e:
                pass

            try:
                if new_pixel[y - 1][x][0] < 128:
                    cnt += 1
            except Exception, e:
                pass

            try:
                if new_pixel[y + 1][x + 1][0] < 128:
                    cnt += 1
            except Exception, e:
                pass

            try:
                if new_pixel[y + 1][x - 1][0] < 128:
                    cnt += 1
            except Exception, e:
                pass

            try:
                if new_pixel[y - 1][x + 1][0] < 128:
                    cnt += 1
            except Exception, e:
                pass

            try:
                if new_pixel[y - 1][x - 1][0] < 128:
                    cnt += 1
            except Exception, e:
                pass

            if cnt > level:
                pixel[x, y] = (0, pixel[x, y][1])
            else:
                pixel[x, y] = pixel[x, y]

    return image

def reverse(image):
    pixel = image.load()
    size = image.size
    dark = 0

    for y in range(size[1]):
        for x in range(size[0]):
            if pixel[x, y][0] < 160:
                dark += 1

    print dark
    if dark > size[0] * size[1] * 0.6:
        for y in range(size[1]):
            for x in range(size[0]):
                print "BEFORE", pixel[x, y]
                pixel[x, y] = (255 - pixel[x, y][0], pixel[x, y][1])
                print "AFTER", pixel[x, y]

    return image

def make_thicker(image, level = 1):
    pixel = image.load()
    size = image.size

    arr = pixel2array(pixel, size)

    for y in range(size[1]):
        for x in range(size[0]):
            if arr[y][x][0] < 100:
                pixel[x, y] = (0, 255)
                for add in range(1, level + 1):
                    try:
                        pixel[x + add, y] = (0, 255)
                    except Exception, e:
                        print e
                        pass

                for add in range(1, level + 1):
                    try:
                        pixel[x - add, y] = (0, 255)
                    except Exception, e:
                        print e
                        pass

                for add in range(1, level + 1):
                    try:
                        pixel[x, y + add] = (0, 255)
                    except Exception, e:
                        print e
                        pass

                for add in range(1, level + 1):
                    try:
                        pixel[x, y - add] = (0, 255)
                    except Exception, e:
                        print e
                        pass

                for add in range(1, level + 1):
                    try:
                        pixel[x + add, y + add] = (0, 255)
                    except Exception, e:
                        print e
                        pass

                for add in range(1, level + 1):
                    try:
                        pixel[x + add, y - add] = (0, 255)
                    except Exception, e:
                        print e
                        pass

                for add in range(1, level + 1):
                    try:
                        pixel[x - add, y + add] = (0, 255)
                    except Exception, e:
                        print e
                        pass

                for add in range(1, level + 1):
                    try:
                        pixel[x - add, y - add] = (0, 255)
                    except Exception, e:
                        print e
                        pass
    return image
