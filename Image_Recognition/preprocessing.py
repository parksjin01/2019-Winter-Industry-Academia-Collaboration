#! -*- encoding: utf-8 -*-

from PIL import Image
import os, glob
import numpy as np
from sklearn.model_selection import train_test_split

def resizing(image_name, size):
    if len(size) != 2 or type(size) != type(()):
        print "Size parameter is wrong"
        return "ERROR"

    # 이미지 크기 지정
    image_w = 64
    image_h = 64
    pixels = image_w * image_h * 3

    # 이미지 데이터 읽어 들이기
    X = []
    try:
        # 이미지
        img = Image.open(image_name)
        img = img.convert("RGB")
        img = img.resize((image_w, image_h))
        data = np.asarray(img)
        X.append(data)
    except:
        print "Can't find image"
        return "ERROR"

    # X = np.array(X)

    np.save("/Users/Knight/Documents/GitHub/2019-Winter-Industry-Academia-Collaboration/Image_Recognition/image" + image_name.split("/")[-1] + ".npy", X)
