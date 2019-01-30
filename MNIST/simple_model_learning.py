from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)

import tensorflow as tf
import os

file_path = (os.path.dirname(os.path.realpath(__file__)) )

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

# Training
for i in range(10000):
    if i % 100 == 0:
        print "[", i, "10,000 ]"
    batch_xs, batch_ys = mnist.train.next_batch(100)
    sess.run(train_step, feed_dict={x: batch_xs, y_: batch_ys})

# Calculate prediction accuracy by compare test set's predicted number and label
correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(y_,1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
print(sess.run(accuracy, feed_dict={x: mnist.test.images, y_: mnist.test.labels}))

# Save that model
saver.save(sess, file_path + "/MNIST_MODEL_SIMPLE")