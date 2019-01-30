#! -*- encoding: utf-8 -*-

from keras.models import Sequential
from keras.layers import Convolution2D, MaxPooling2D
from keras.layers import Activation, Dropout, Flatten, Dense
import h5py
from PIL import Image
import numpy as np
import os
import image_recognition_makedata

file_path = (os.path.dirname(os.path.realpath(__file__)) )

# 카테고리 지정하기
categories = ["kangaroo", "dolphin", "butterfly", "elephant", "flamingo"]
nb_classes = len(categories)

# 이미지 크기 지정하기
image_w = 64
image_h = 64

# 데이터 불러오기
try:
    X_train, X_test, y_train, y_test = np.load(file_path + "/image/" + "-".join(categories) + ".npy")
except:
    image_recognition_makedata.make_data(categories)
    X_train, X_test, y_train, y_test = np.load(file_path + "/image/" + "-".join(categories) + ".npy")

# 데이터 정규화하기
X_train = X_train.astype("float") / 256
X_test  = X_test.astype("float")  / 256
print('X_train shape:', X_train.shape)

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
hdf5_file = file_path + "/image/" + "-".join(categories) + ".hdf5"
if os.path.exists(hdf5_file):
    model.load_weights(hdf5_file)
# 학습한 모델을 파일로 저장하기
model.fit(X_train, y_train, batch_size=32, nb_epoch=10)
model.save_weights(hdf5_file)

# 모델 평가하기
# 예측하기
pre = model.predict(X_test)
# 예측 결과 테스트하기
for i, v in enumerate(pre):
    pre_ans = v.argmax()    # 예측한 레이블
    ans = y_test[i].argmax()    # 정답 레이블
    dat = X_test[i] # 이미지 데이터
    if ans == pre_ans: continue
    # 예측이 틀리면 무엇이 틀렸는지 출력하기
    print("[NG]", categories[pre_ans], "!=", categories[ans])
    print(v)
    # 이미지 출력하기
    fname = file_path + "/image/error/" + str(i) + "-" + categories[pre_ans] + \
        "-ne-" + categories[ans] + ".png"
    dat *= 256
    img = Image.fromarray(np.uint8(dat))
    img.save(fname)
score = model.evaluate(X_test, y_test)
print('loss=', score[0])
print('accuracy=', score[1])