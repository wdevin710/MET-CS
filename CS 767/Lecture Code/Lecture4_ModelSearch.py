###
### Model Evaluation
## Examples 
## Refernce: Hands on machine learning with Sci-Kit learn, Keras and TensorFlow 

# Supervised learning: In the context of supervised learning
#  let us cover some of the basic functions

#####################
### Data splitting
from sklearn.datasets import make_blobs
from sklearn.model_selection import train_test_split

# create a synthetic dataset
X, y = make_blobs(random_state=0)
# split data and labels into a training and a test set. Default is 50/50. random_state for testing and repeatition.
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=0) 

# or for 
from  sklearn.datasets import  load_iris
iris = load_iris()
list( iris.keys() ) 

X = iris.data  
y = iris.target.astype(np.int)

x_train, x_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=10)


#####################
### Cross validation
from sklearn.model_selection import cross_val_score
from sklearn.datasets import load_iris
from sklearn.linear_model import LogisticRegression

iris = load_iris()
logreg = LogisticRegression(max_iter=1000)

scores = cross_val_score(logreg, iris.data, iris.target, cv = 6) # returns scores for each cross validation. Default cv is 5 
print("Cross-validation scores: {}".format(scores))

# avearge score of all the sectors is the final value
print("Average cross-validation score: {:.2f}".format(scores.mean()))

# Another function for cross validation 
from sklearn.model_selection import cross_validate
res = cross_validate(logreg, iris.data, iris.target, cv=5, # Returns a dictionary
                     return_train_score=True)
display(res)

#### Using KFold object
from sklearn.model_selection import KFold
kfold_obj = KFold(n_splits = 3) # By default non-stratified selection
res = cross_val_score(logreg, iris.data, iris.target, cv=kfold_obj)
display(res) # Note the results are [0, 0, 0] since each fold corresponding to only one class (we have 3 classes)

kfold_obj = KFold(n_splits=3, shuffle=True, random_state = 0) 
res = cross_val_score(logreg, iris.data, iris.target, cv=kfold_obj)
display(res)



# Change results to dataframe
res_df = pd.DataFrame(res)
display(res_df)
# average score
print("Mean times and scores:\n", res_df.mean())



#####################
## Simple Grid search code

# Read the dataset
from sklearn import datasets
iris = datasets.load_iris()
list(iris.keys())

print(iris.DESCR)


# Grid search 

from sklearn.model_selection import GridSearchCV
from sklearn.ensemble import RandomForestRegressor

param_grid = [
    # try 12 (3×4) combinations of hyperparameters
    {'n_estimators': [3, 10, 30], 'max_features': [2, 4, 6, 8]},
    # then try 6 (2×3) combinations with bootstrap set as False
    {'bootstrap': [False], 'n_estimators': [3, 10], 'max_features': [2, 3, 4]},
  ]

forest_reg = RandomForestRegressor(random_state=42)
# train across 5 folds, that's a total of (12+6)*5=90 rounds of training 
grid_search = GridSearchCV(forest_reg, param_grid, cv=5,
                           scoring='neg_mean_squared_error',
                           return_train_score=True)
grid_search.fit(iris.data, iris.target)


grid_search.best_params_


### Random search 
from sklearn.model_selection import RandomizedSearchCV
from scipy.stats import randint

param_distribs = {
        'n_estimators': randint(low=1, high=200),
        'max_features': randint(low=1, high=8),
    }

forest_reg = RandomForestRegressor(random_state=42)
rnd_search = RandomizedSearchCV(forest_reg, param_distributions=param_distribs,
                                n_iter=10, cv=5, scoring='neg_mean_squared_error', random_state=42)
rnd_search.fit(iris.data, iris.target)






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





