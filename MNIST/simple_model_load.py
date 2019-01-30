import tensorflow as tf
import sys
import one_hot_encoding
import preprocessing
import numpy
import os

file_path = (os.path.dirname(os.path.realpath(__file__)) )
flatten = lambda x:numpy.array(x).reshape((1, 784))

def predict_number(image_file, stored_model_name = "MNIST_MODEL_SIMPLE"):
    x = tf.placeholder(tf.float32, [None, 784])

    # Layer1 parameter and bias
    W = tf.Variable(tf.zeros([784, 10]))
    b = tf.Variable(tf.zeros([10]))

    # Predicted number between 0 to 9
    y = tf.nn.softmax(tf.matmul(x, W) + b)

    # Label of dataset
    y_ = tf.placeholder(tf.float32, [None, 10])

    # Calculate the difference between predicted number and label
    cross_entropy = tf.reduce_mean(-tf.reduce_sum(y_ * tf.log(y), reduction_indices=[1]))

    # Training algorithm (Minimizing the cross_entropy which means difference between prediction and label)
    train_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)

    # Operation to init parameter and bias
    init = tf.global_variables_initializer()

    # Create saver object to save model
    saver = tf.train.Saver()
    sess = tf.Session()

    # Running initialization operation
    sess.run(init)

    # Load the saved trained model
    saver.restore(sess, file_path + "/" + stored_model_name)

    data = preprocessing.resizing(image_file, (28, 28))
    print data
    data = flatten(one_hot_encoding.read(data))

    # Calculate prediction accuracy by compare test set's predicted number and label
    correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(y_,1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
    result = sess.run(y, feed_dict={x: data,}).tolist()
    return result[0].index(max(result[0]))

if __name__ == '__main__':
  if len(sys.argv) == 2:
    result = predict_number(sys.argv[1])

  elif len(sys.argv) == 3:
    result = predict_number(sys.argv[1], sys.argv[2])

  else:
      result = "USAGE: ./model_load.py <image name> <Trained model --optional>"

  print "Prediction:", result
