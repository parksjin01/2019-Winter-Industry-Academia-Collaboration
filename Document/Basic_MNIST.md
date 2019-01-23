Improved_MNIST model
====================

This model is basic version of MNIST model (with just 1 layer).  
It classify handwritten number images to digit. ![handwritten](https://i.imgur.com/s5DJSoM.jpg)

For example, model will classify above image as 2. Basic MNIST model's accuracy was about 92%. It may seem very high, but it means if user upload 10 images, nearly always 1 image could be classified as wrong value. Let's see how this basic ANN can predict hand written number.

### Model Architecture

![Basic_MNIST_Architecture](https://i.imgur.com/QQ7A5XO.jpg)

There are three layers in model. First layer is input layer. Input layer receive image as [?, 784] size lists(tensors). One MNIST image size is 28 * 28 and we can flatten it into 784 1D arrays. ? means it is variable. So input layer receive image as flatten 1D arrays and user can pass one or more images at once.

Second layer is only hidden layer in this model. Input layer forwards user input into hidden layer. This layer predict number by using weight and bias. This layer multiply weight with input layer and add bias. This should reduce 784 array into 10 array (0 ~ 9). So weight size is [784, 10] and bias size is [10]. Tensorflow modify weight and bias to reduce difference between predicted value and label.

Last layer is output of hidden layer which is called as output layer.

This is the most basic architecture for MNIST problems. This architecture's accuracy is not good because architecture is too simple. Only hidden layer has weight and bias to predict number but it has only one. If we want to improve accuracy we have to increase number of hidden layer, training more and select more appropriate features.
