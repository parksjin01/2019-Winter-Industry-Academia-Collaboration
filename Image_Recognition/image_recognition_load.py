#! -*- encoding: utf-8 -*-

from keras.models import Sequential
from keras.layers import Convolution2D, MaxPooling2D
from keras.layers import Activation, Dropout, Flatten, Dense
import h5py
from PIL import Image
import numpy as np
import os
import image_recognition_makedata
import preprocessing
import sys

file_path = (os.path.dirname(os.path.realpath(__file__)) )

def predict_animal(image_file, categories, stored_model_name = "MNIST_MODEL_IMPROVED"):
    # 카테고리 지정하기
    nb_classes = len(categories)

    # Check trained model is appropriate for this category
    if "-".join(categories) != stored_model_name.split("/")[-1].strip(".hdf5"):
        return "Given model is inappropriate for this category"

    # 이미지 크기 지정하기
    image_w = 64
    image_h = 64

    # 데이터 불러오기
    # try:
    #     X_train, X_test, y_train, y_test = np.load("./image/" + "-".join(categories) + ".npy")
    # except:
    #     image_recognition_makedata.make_data(categories)
    #     X_train, X_test, y_train, y_test = np.load("./image/" + "-".join(categories) + ".npy")

    # 데이터 정규화하기
    # X_train = X_train.astype("float") / 256
    # X_test  = X_test.astype("float")  / 256
    # print('X_train shape:', X_train.shape)

    print(image_file)
    preprocessing.resizing(image_file, size=(image_w, image_h))
    X_train = np.load(file_path + "/image" + image_file.split("/")[-1] + ".npy")

    # 모델 구축하기
    model = Sequential()
    model.add(Convolution2D(32, 3, 3,
                            border_mode='same',
                            input_shape=X_train.shape[1:]))
    model.add(Activation('relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Dropout(0.25))

    model.add(Convolution2D(64, 3, 3, border_mode='same'))
    model.add(Activation('relu'))
    model.add(Convolution2D(64, 3, 3))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Dropout(0.25))

    model.add(Flatten())
    model.add(Dense(512))
    model.add(Activation('relu'))
    model.add(Dropout(0.5))
    model.add(Dense(nb_classes))
    model.add(Activation('softmax'))

    model.compile(loss='binary_crossentropy',
                  optimizer='rmsprop',
                  metrics=['accuracy'])

    # 모델 훈련하기
    # 기존에 학습된 모델 읽어 들이기
    hdf5_file = stored_model_name
    model.load_weights(file_path + "/" + hdf5_file)

    # 모델 평가하기
    # 예측하기
    pre = model.predict(X_train)
    # 예측 결과 테스트하기
    for i, v in enumerate(pre):
        pre_ans = v.argmax()    # 예측한 레이블

    return categories[pre_ans]

if __name__ == '__main__':
  if len(sys.argv) == 3:
    result = predict_animal(sys.argv[1], sys.argv[2].split(" "))

  elif len(sys.argv) == 4:
    result = predict_animal(sys.argv[1], sys.argv[2].split(" "), sys.argv[3])

  else:
      result = "USAGE: ./model_load.py <image name> <image category> <Trained model --optional>"

  print "Prediction:", result