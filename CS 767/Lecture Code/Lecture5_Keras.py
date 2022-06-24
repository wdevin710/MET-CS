###############
### CS767 - Machine Learning
### By: Farshid Alizadeh-Shabdiz

### Keras lecture
## Examples 
## Reference: Hands on machine learning with Sci-Kit learn, Keras and TensorFlow 

##

import numpy as np
import pandas as pd

import tensorflow as tf
from tensorflow import keras

import matplotlib.pyplot as plt

print(tf.__version__)
print(keras.__version__)


########################################## 
### Sequential API
######

# Example of sequential API - fashion_mnist classification
fashion_mnist = keras.datasets.fashion_mnist

(X_train_full, Y_train_full), (X_test, Y_test) = fashion_mnist.load_data()

print("Training data shape - {}".format(X_train_full.shape))
print("Training data type - {}".format(X_train_full.dtype))

# Max normalization
X_valid, X_train = X_train_full[:5000]/255.0 , X_train_full[5000:]/255.0
Y_valid, Y_train = Y_train_full[:5000] , Y_train_full[5000:]
X_test = X_test / 255.0


class_names = ["T-shirt/top", "Trouser", "pullover", "Dress", "Coat", 
				"Sandal", "Shirt", "Sneaker", "Bag", "Ankle_boot"]

## Let us look at the data
n_rows = 4
n_cols = 10
plt.figure(figsize=(n_cols * 1.2, n_rows * 1.2))
for row in range(n_rows):
    for col in range(n_cols):
        index = n_cols * row + col
        plt.subplot(n_rows, n_cols, index + 1)
        plt.imshow(X_train[index], cmap="binary", interpolation="nearest")
        plt.axis('off')
        plt.title(class_names[Y_train[index]], fontsize=12)
plt.subplots_adjust(wspace=0.2, hspace=0.5)
plt.show()


# Creating the model
model = keras.models.Sequential()
model.add(keras.layers.Flatten(input_shape=[28,28])) # Converts 28x28 images to 1D array (have to). 
model.add(keras.layers.Dense(300, activation="relu"))
model.add(keras.layers.Dense(100, activation="relu"))
model.add(keras.layers.Dense(10, activation="softmax"))

# input shaoe is optional. If it is not specified, Keras will build the model at the "build" time
# or when input is given.
# Giving input shape is recommended, since model can be built and memory allocation can happen.

# Writing the model as one line
model = keras.models.Sequential([
		keras.layers.Flatten(input_shape=[28,28]),
		keras.layers.Dense(300, activation="relu",name="Hidden1"),
		keras.layers.Dense(100, activation="relu",name="Hidden2"),
		keras.layers.Dense(10, activation="softmax",name="Output")
	])

# start from a known place
keras.backend.clear_session()
tf.random.set_seed(42)


#
model.summary()

# Fetch layers by index
model.layers
hidden1 = model.layers[1]
# fetch layers by name
print(hidden1.name)

model.get_layer('dense') is hidden1
model.get_layer(hidden1.name) is hidden1

weights, biases = hidden1.get_weights()
print(weights)
print(weights.shape)
print(biases)
print(biases.shape)



# Compiling the model
model.compile(loss="sparse_categorical_crossentropy",       # We could also use "categorical_crossentropy", 
                                                            # but this is sparce (only one target for 0-9 classes exclusively)
	optimizer="sgd",  										# note the default learning rate here is lr=0.01.
	metrics=["accuracy"])  									# calculates accuracy - how often label match output
# Alternative compiler
model.compile(loss="sparse_categorical_crossentropy",
	optimizer=keras.optimizers.SGD(lr=0.1), 				# provides an option to change learning rate
	metrics=["accuracy"])
# other options are "categorical_crossentropy" for one-hot case or "binary_crossentropy" for binary classification. 
# Note activation can be "sigmoid" for binary classification.


history = model.fit(X_train , Y_train , epochs = 30,
	validation_data=(X_valid,Y_valid))                      # Validation optional. 
# Another option to set a validation 
# history = model.fit(X_train , Y_train , epochs = 30,
#     validation_split=0.05)                     # Validation set can be set as a ratio of training set
# Class weight: 
# 

history.params
history.epoch
history.history.keys()
history.history.get('accuracy') 		# Get any keys <function dict.get(key, default=None, /)>

# Calling fit function again, continues from where it left and continue learning 
history = model.fit(X_train , Y_train , epochs = 4,
    validation_data=(X_valid,Y_valid))                      # Validation optional. 


# Plot the learing curve 
import pandas as pd
import matplotlib.pyplot as plt
# history.history is a dictionary containing the loss and measurements. 
# Change it to DataFrame, then method plot() can be used to get the learning curves.
print(pd.DataFrame(history.history))

pd.DataFrame(history.history).plot(figsize=(8, 5)) 
plt.grid(True)
plt.gca().set_ylim(0, 1) # Set the virtical range to [0,1]
plt.show()

# Evaluation of the results
model.evaluate(X_test, Y_test)

X_new = X_test[:3]
Y_prob = model.predict(X_new)
Y_prob.round(2)

Y_pred = model.predict_classes(X_new)
Y_pred
np.array(class_names)[Y_pred]

Y_test[:3]


## For fun let us look at the pictures also
plt.figure(figsize=(7.2, 2.4))
for index, image in enumerate(X_new):
    plt.subplot(1, 3, index + 1)
    plt.imshow(image, cmap="binary", interpolation="nearest")
    plt.axis('off')
    plt.title(class_names[Y_test[index]], fontsize=12)
plt.subplots_adjust(wspace=0.2, hspace=0.5)
plt.show()


########################################################################
### Using sequential model for regression
# Example California housing dataset 

from sklearn.datasets import fetch_california_housing
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

housing = fetch_california_housing() # This is a simpler set with only numerical features
									 # and no missing data
housing.data.shape

X_train_full, X_test, y_train_full, y_test = train_test_split(housing.data, housing.target, random_state=42) # Data already divided to training and test
X_train, X_valid, y_train, y_valid = train_test_split(X_train_full, y_train_full, random_state=42) # Put aside validation data

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)             # Standardise the training set. Fit gives mean and sd, and transform applies standardization
X_valid = scaler.transform(X_valid)                 # Valid set only standardized since mean and sd of trianing are used.
X_test = scaler.transform(X_test)

# Start from a known random place
np.random.seed(42)
tf.random.set_seed(42)

# Regressin => the output is a single neuron + no activation function + loss function is the MSE
model = keras.models.Sequential([
    keras.layers.Dense(30, activation="relu", input_shape=X_train.shape[1:]),
    keras.layers.Dense(1)
])
model.compile(loss="mean_squared_error", optimizer=keras.optimizers.SGD(lr=1e-3))
history = model.fit(X_train, y_train, epochs=20, validation_data=(X_valid, y_valid))
mse_test = model.evaluate(X_test, y_test)
X_new = X_test[:3]
y_pred = model.predict(X_new)
y_new = y_test[:3] 
# accuracy of the model
y_pred          # Prediction
y_new           # ground truth

# Plot learning curve
plt.plot(pd.DataFrame(history.history))
plt.grid(True)
plt.gca().set_ylim(0, 1)
plt.show()



################################################################## 
### Functional API
######
# Building a Wide & Deep network for California Housing problem
# Start from a known state
np.random.seed(42)
tf.random.set_seed(42)

input_ = keras.layers.Input(shape=X_train.shape[1:]) 			# Input kind, shape, and dtype
hidden1 = keras.layers.Dense(30, activation="relu")(input_) 	# Note the layer was called like a function with input_ was passed into. 
hidden2 = keras.layers.Dense(30, activation="relu")(hidden1)	# Same as above, a function like definition
concat = keras.layers.concatenate([input_, hidden2])			# Concatenates tensors 
output = keras.layers.Dense(1)(concat)							# Note to activation defined

model = keras.models.Model(inputs=[input_], outputs=[output])	# Last step, a model is created with input and output defined

model.summary()

model.compile(loss="mean_squared_error", optimizer=keras.optimizers.SGD(lr=1e-3))
history = model.fit(X_train, y_train, epochs=20,
                    validation_data=(X_valid, y_valid))

# What if you want to send different subsets of input features through the wide or deep paths? 
# We will send 5 features (features 0 to 4) through wide path, and 6 through the deep path (features 2 to 7). 
# Note that 3 features will go through both (features 2, 3 and 4).
np.random.seed(42)
tf.random.set_seed(42)

input_A = keras.layers.Input(shape=[5], name="wide_input")
input_B = keras.layers.Input(shape=[6], name="deep_input")
hidden1 = keras.layers.Dense(30, activation="relu")(input_B)
hidden2 = keras.layers.Dense(30, activation="relu")(hidden1)
concat = keras.layers.concatenate([input_A, hidden2])
output = keras.layers.Dense(1, name="output")(concat)

model = keras.models.Model(inputs=[input_A, input_B], outputs=[output])

model.compile(loss="mse", optimizer=keras.optimizers.SGD(lr=1e-3))

X_train_A, X_train_B = X_train[:, :5], X_train[:, 2:]
X_valid_A, X_valid_B = X_valid[:, :5], X_valid[:, 2:]
X_test_A, X_test_B = X_test[:, :5], X_test[:, 2:]
X_new_A, X_new_B = X_test_A[:3], X_test_B[:3]

history = model.fit((X_train_A, X_train_B), y_train, epochs=20,
                    validation_data=((X_valid_A, X_valid_B), y_valid))

mse_test = model.evaluate((X_test_A, X_test_B), y_test)
y_pred = model.predict((X_new_A, X_new_B))


#########################
# Adding an auxiliary output which can be used for 
# Multi output
#   - maybe task is regression and classfication (detect an object and find its location)
#   - Running multiple similar independent task as part of one network is mostly better
#   - Regularization technique by introducing an auxiliary output

np.random.seed(42)
tf.random.set_seed(42)

input_A = keras.layers.Input(shape=[5], name="wide_input")
input_B = keras.layers.Input(shape=[6], name="deep_input")
hidden1 = keras.layers.Dense(30, activation="relu")(input_B)
hidden2 = keras.layers.Dense(30, activation="relu")(hidden1)
concat = keras.layers.concatenate([input_A, hidden2])
output = keras.layers.Dense(1, name="main_output")(concat)
aux_output = keras.layers.Dense(1, name="aux_output")(hidden2)
model = keras.models.Model(inputs=[input_A, input_B],
                           outputs=[output, aux_output])
model.compile(loss=["mse", "mse"], loss_weights=[0.9, 0.1], optimizer=keras.optimizers.SGD(lr=1e-3))

history = model.fit([X_train_A, X_train_B], [y_train, y_train], epochs=20,
                    validation_data=([X_valid_A, X_valid_B], [y_valid, y_valid]))

total_loss, main_loss, aux_loss = model.evaluate(
    [X_test_A, X_test_B], [y_test, y_test])
y_pred_main, y_pred_aux = model.predict([X_new_A, X_new_B])





#################################################################################
# Subclass API
class WideAndDeepModel(keras.models.Model):
    def __init__(self, units=30, activation="relu", **kwargs):
        super().__init__(**kwargs)
        self.hidden1 = keras.layers.Dense(units, activation=activation)
        self.hidden2 = keras.layers.Dense(units, activation=activation)
        self.main_output = keras.layers.Dense(1)
        self.aux_output = keras.layers.Dense(1)
        
    def call(self, inputs):
        input_A, input_B = inputs
        hidden1 = self.hidden1(input_B)
        hidden2 = self.hidden2(hidden1)
        concat = keras.layers.concatenate([input_A, hidden2])
        main_output = self.main_output(concat)
        aux_output = self.aux_output(hidden2)
        return main_output, aux_output

model = WideAndDeepModel(30, activation="relu")

model.compile(loss="mse", loss_weights=[0.9, 0.1], optimizer=keras.optimizers.SGD(lr=1e-3))
history = model.fit((X_train_A, X_train_B), (y_train, y_train), epochs=10,
                    validation_data=((X_valid_A, X_valid_B), (y_valid, y_valid)))
total_loss, main_loss, aux_loss = model.evaluate((X_test_A, X_test_B), (y_test, y_test))
y_pred_main, y_pred_aux = model.predict((X_new_A, X_new_B))



##########################################################################################
### Saving and loading a model
np.random.seed(42)
tf.random.set_seed(42)

model = keras.models.Sequential([
    keras.layers.Dense(30, activation="relu", input_shape=[8]),
    keras.layers.Dense(30, activation="relu"),
    keras.layers.Dense(1)
])

model.compile(loss="mse", optimizer=keras.optimizers.SGD(lr=1e-3))
history = model.fit(X_train, y_train, epochs=10, validation_data=(X_valid, y_valid))
mse_test = model.evaluate(X_test, y_test)

model.save("my_keras_model.h5") # HDF5 format - Hierarchical data format #5
model = keras.models.load_model("my_keras_model.h5")
model.predict(X_new)

# When using subclassing, the weights can be saved (and loaded) as follows
model.save_weights("my_keras_weights.ckpt")
model.load_weights("my_keras_weights.ckpt")


#######################################################################################
### Callbacks during training
#########
keras.backend.clear_session()
np.random.seed(42)
tf.random.set_seed(42)

model = keras.models.Sequential([
    keras.layers.Dense(30, activation="relu", input_shape=[8]),
    keras.layers.Dense(30, activation="relu"),
    keras.layers.Dense(1)
])

model.compile(loss="mse", optimizer=keras.optimizers.SGD(lr=1e-3))
checkpoint_cb = keras.callbacks.ModelCheckpoint("my_keras_model.h5", save_best_only=True) # By default saves the model at the end of each Epoch
history = model.fit(X_train, y_train, epochs=10,
                    validation_data=(X_valid, y_valid),
                    callbacks=[checkpoint_cb])
model    = keras.models.load_model("my_keras_model.h5") # rollback to best model
mse_test = model.evaluate(X_test, y_test)

model.compile(loss="mse", optimizer=keras.optimizers.SGD(lr=1e-3))
early_stopping_cb = keras.callbacks.EarlyStopping(patience=10,
                                                  restore_best_weights=True)
history = model.fit(X_train, y_train, epochs=100,
                    validation_data=(X_valid, y_valid),
                    callbacks=[checkpoint_cb, early_stopping_cb])
mse_test = model.evaluate(X_test, y_test)

class PrintValTrainRatioCallback(keras.callbacks.Callback):
    def on_epoch_end(self, epoch, logs):
        #print("\nval/train: {:.2f}".format(logs["val_loss"] / logs["loss"]))
        print("\n Write anything here!")


val_train_ratio_cb = PrintValTrainRatioCallback()
history = model.fit(X_train, y_train, epochs=1,
                    validation_data=(X_valid, y_valid),
                    callbacks=[val_train_ratio_cb])


# List of available Keras call backs can be found here: https://keras.io/callbacks
# Available callbacks:
    # Base Callback class
    # ModelCheckpoint
    # TensorBoard
    # EarlyStopping
    # LearningRateScheduler
    # ReduceLROnPlateau
    # RemoteMonitor
    # LambdaCallback
    # TerminateOnNaN
    # CSVLogger
    # ProgbarLogger 

#######################################################################################
### TensorBoard
#########
import os

root_logdir = os.path.join(os.curdir, "my_logs")

def get_run_logdir():
    import time
    run_id = time.strftime("run_%Y_%m_%d-%H_%M_%S")
    return os.path.join(root_logdir, run_id)

run_logdir = get_run_logdir()
run_logdir

keras.backend.clear_session()
np.random.seed(42)
tf.random.set_seed(42)

model = keras.models.Sequential([
    keras.layers.Dense(30, activation="relu", input_shape=[8]),
    keras.layers.Dense(30, activation="relu"),
    keras.layers.Dense(1)
])    
model.compile(loss="mse", optimizer=keras.optimizers.SGD(lr=1e-3))

tensorboard_cb = keras.callbacks.TensorBoard(run_logdir)
history = model.fit(X_train, y_train, epochs=30,
                    validation_data=(X_valid, y_valid),
                    callbacks=[checkpoint_cb, tensorboard_cb])

%load_ext tensorboard
%tensorboard --logdir=./my_logs --port=6006

run_logdir2 = get_run_logdir()
run_logdir2

keras.backend.clear_session()
np.random.seed(42)
tf.random.set_seed(42)

model = keras.models.Sequential([
    keras.layers.Dense(30, activation="relu", input_shape=[8]),
    keras.layers.Dense(30, activation="relu"),
    keras.layers.Dense(1)
])    
model.compile(loss="mse", optimizer=keras.optimizers.SGD(lr=0.05))

tensorboard_cb = keras.callbacks.TensorBoard(run_logdir2)
history = model.fit(X_train, y_train, epochs=30,
                    validation_data=(X_valid, y_valid),
                    callbacks=[checkpoint_cb, tensorboard_cb])

help(keras.callbacks.TensorBoard.__init__)

########################################################################
### Activation Functions
#########

# Plot/Review activation functions
def sigmoid(z):
    return 1 / (1 + np.exp(-z))

def relu(z):
    return np.maximum(0, z)

def derivative(f, z, eps=0.000001):
    return (f(z + eps) - f(z - eps))/(2 * eps)
z = np.linspace(-5, 5, 200)

plt.figure(figsize=(11,4))

plt.subplot(121)
plt.plot(z, np.sign(z), "r-", linewidth=1, label="Step")
plt.plot(z, sigmoid(z), "g--", linewidth=2, label="Sigmoid")
plt.plot(z, np.tanh(z), "b-", linewidth=2, label="Tanh")
plt.plot(z, relu(z), "m-.", linewidth=2, label="ReLU")
plt.grid(True)
plt.legend(loc="center right", fontsize=14)
plt.title("Activation functions", fontsize=14)
plt.axis([-5, 5, -1.2, 1.2])

plt.subplot(122)
plt.plot(z, derivative(np.sign, z), "r-", linewidth=1, label="Step")
plt.plot(0, 0, "ro", markersize=5)
plt.plot(0, 0, "rx", markersize=10)
plt.plot(z, derivative(sigmoid, z), "g--", linewidth=2, label="Sigmoid")
plt.plot(z, derivative(np.tanh, z), "b-", linewidth=2, label="Tanh")
plt.plot(z, derivative(relu, z), "m-.", linewidth=2, label="ReLU")
plt.grid(True)
#plt.legend(loc="center right", fontsize=14)
plt.title("Derivatives", fontsize=14)
plt.axis([-5, 5, -0.2, 1.2])

save_fig("activation_functions_plot")
plt.show()


# Keras model with activation functions
model = keras.models.Sequential([
    keras.layers.Flatten(input_shape=[28, 28]),
    keras.layers.Dense(300, kernel_initializer="he_normal"),
    keras.layers.LeakyReLU(),
    keras.layers.Dense(100, kernel_initializer="he_normal"),
    keras.layers.LeakyReLU(),
    keras.layers.Dense(10, activation="softmax")
])



#########################################################################
#########################################################################
### Batch Normalization
#########
model = keras.models.Sequential([
    keras.layers.Flatten(input_shape=[28, 28]),
    keras.layers.BatchNormalization(),
    keras.layers.Dense(300, activation="relu", use_bias=False),
    keras.layers.BatchNormalization(),
    keras.layers.Dense(100, activation="relu", use_bias=False),
    keras.layers.BatchNormalization(),
    keras.layers.Dense(10, activation="softmax")
])

### Gradient Clip
optimizer = keras.optimizers.SGD(clipvalue=1.0)

optimizer = keras.optimizers.SGD(clipnorm=1.0)



'''
Following code reference 
Examples of chapter 20.13 of the following book 
Reference: Machine Learning with Python Cookbok by Chris Albon 

Topic: How to run NN in sklearn GridSearch, RandomSearch and/or cross validation
'''

'''
k-Fold Cross-Validating Neural Networks
'''
# Load libraries
import numpy as np
import tensorflow as tf
from tensorflow import keras
from keras import models
from keras import layers
from keras.wrappers.scikit_learn import KerasClassifier
from sklearn.model_selection import cross_val_score
from sklearn.datasets import make_classification

# Set random seed
np.random.seed(0)

# Create Feature And Target Data
# Number of features
number_of_features = 100

# Generate features matrix and target vector
features, target = make_classification(n_samples = 10000,
                                       n_features = number_of_features,
                                       n_informative = 3,
                                       n_redundant = 0,
                                       n_classes = 2,
                                       weights = [.5, .5],
                                       random_state = 0)

# Create function returning a compiled network
def create_network():
        # Start neural network
    network = models.Sequential()
    # Add fully connected layer with a ReLU activation function
    network.add(layers.Dense(units=16, activation='relu', input_shape=(number_of_features,)))
    # Add fully connected layer with a ReLU activation function
    network.add(layers.Dense(units=16, activation='relu'))
    # Add fully connected layer with a sigmoid activation function
    network.add(layers.Dense(units=1, activation='sigmoid'))

    # Compile neural network
    network.compile(loss='binary_crossentropy', # Cross-entropy
                    optimizer='rmsprop', # Root Mean Square Propagation
                    metrics=['accuracy']) # Accuracy performance metric
    
    # Return compiled network
    return network

# Wrap Keras model so it can be used by scikit-learn
neural_network = KerasClassifier(build_fn=create_network, 
                                 epochs=10, 
                                 batch_size=100, 
                                 verbose=0)

# Conduct k-Fold Cross-Validation Using scikit-learn
# Evaluate neural network using three-fold cross-validation
cross_val_score(neural_network, features, target, cv=3)


#####################################################
######## Example of cross_val_score with regresssion
## Code modified by Farshid Alizadeh-Shabdiz from the original code from the book
# Load libraries
import numpy as np
from keras.preprocessing.text import Tokenizer
from keras import models
from keras import layers
from sklearn.datasets import make_regression
from sklearn.model_selection import train_test_split
from sklearn import preprocessing

from keras.wrappers.scikit_learn import KerasRegressor
# Set random seed
np.random.seed(0)

#Generate Training Data
# Generate features matrix and target vector
features, target = make_regression(n_samples = 10000,
                                   n_features = 3,
                                   n_informative = 3,
                                   n_targets = 1,
                                   noise = 0.0,
                                   random_state = 0)

# Divide our data into training and test sets
train_features, test_features, train_target, test_target = train_test_split(features, 
                                                                            target, 
                                                                            test_size=0.33, 
                                                                            random_state=0)
# Create Neural Network Architecture
# Create function returning a compiled network
def create_network():
  network = models.Sequential()
  # Add fully connected layer with a ReLU activation function
  network.add(layers.Dense(units=32, activation='relu', input_shape=(train_features.shape[1],)))
  # Add fully connected layer with a ReLU activation function
  network.add(layers.Dense(units=32, activation='relu'))
  # Add fully connected layer with no activation function
  network.add(layers.Dense(units=1))
  # Compile neural network
  network.compile(loss='mse', # Mean squared error
                optimizer='RMSprop', # Optimization algorithm
                metrics=['mse']) # Mean squared error
  return network


# Wrap Keras model so it can be used by scikit-learn
neural_network = KerasRegressor(build_fn=create_network, 
                                 epochs=10, 
                                 batch_size=100, 
                                 verbose=0)

# Conduct k-Fold Cross-Validation Using scikit-learn
# Evaluate neural network using three-fold cross-validation
cross_val_score(neural_network, features, target, cv=3)





