Image Recognition model
=======================

This model classify which animal is taken a picture with 85% accuracy.  
![cat](https://i.imgur.com/4jDTLBZ.jpg) With above picture, this model will classify it as cat.  
Then how this model can classify animal in the picture accurately?

### CNN (Convolutional Neural Network)

This model use CNN to extract feature. When input data of ANN model is image, it's hard to select feature of image manually. To improve accuracy of ANN model when input data type is image, we can use ANN to extract feature of image automatically. CNN is basic technology to extract feature in image. In MNIST problem, input data is image of handwritten number, So we can improve accuracy by using CNN to extract feature

CNN is consist of convolution layer and pooling layer. Convolution layer extract feature of image by matrix multiplication. Pooling layer is used to reduce feature size or emphasize specific feature.

CNN can improve accuracy of model which handle image data. The reason of improvement is, Fully connected layer only support 1D data and image is 2D data. We need to flatten 2D image to 1D data to use fully connected layer. In this step, spatial information of 2D image is lost. To avoid lost of spatial informations, we use CNN which extract spatial information as feature. So when we use spatial data as input, we can improve accuracy by using CNN

### Model Architecture

![MNIST Model](https://i.imgur.com/3Fm4XwO.jpg)

Above picture depict architecture of image recognition model. First layer is input layer which accept user input. Input layer accept user input as [?, 64 * 64] list. Input layer forward this value to CNN layer.

From 2nd layer to 5th layer is CNN layer. One CNN layer is consist of 1 convolution layer and 1 pulling layer. So we can say that there are 2 CNN layers. Second CNN layer forward extracted feature to ANN.

6th and 7th layer is ANN layer. This layer using feature which is extracted from CNN layer and classify number. 6th layer using ReLu as loss function and 7th layer using Softmax as loss function.

Last layer is called output layer, There are number 5 (Cat, Dog, Butterfly, Elephant, Flamingo) neurons and the index of neuron which has the largest value will be the result of classification.

###### Additional things

This model is same with CNN MNIST model. Because both model accept image as input and classify it. Both model use image as input so CNN will be helpful to increase accuracy.

###### Reference

This model was introduced in [tensorflow korea gitbook](https://tensorflowkorea.gitbooks.io/tensorflow-kr/content/g3doc/tutorials/mnist/pros/)
