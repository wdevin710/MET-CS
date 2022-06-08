'''
 CS677 - Data Science with Python
 
Decision Tree
 By: Farshid Alizadeh-Shabdiz

'''
# Decision Trees

import numpy as np
import pandas as pd
from sklearn import tree
from sklearn.preprocessing import LabelEncoder


#######################
### Example 1
data = pd.DataFrame( 
 	{'Day':     	[1,2,3,4,5,6,7,8,9,10], 
 	 'Weather': 	['sunny','rainy','sunny','rainy',
						'sunny','overcast','sunny','overcast', 'rainy','rainy'],
	 'Temperature':	['hot', 'mild', 'cold','cold','cold',
						'mild','hot','hot', 'hot','mild'], 
	 'Wind':    	['low','high','low','high','high',
						'low','low', 'high','high','low'], 
	 'Play': 		['no', 'yes','yes','no','yes', 'yes','yes','yes','no','yes']},
	columns = ['Day','Weather','Temperature','Wind','Play'])

input_data = data[['Weather', 'Temperature', 'Wind']]
dummies = [pd.get_dummies(data[c]) for c in input_data.columns] 
binary_data = pd.concat(dummies, axis=1)
X = binary_data [0:10].values
le = LabelEncoder()
Y = le.fit_transform(data['Play'].values)
clf = tree.DecisionTreeClassifier(criterion='entropy', max_features=8) 
clf = clf.fit(X,Y)
# sunny -> (0,0,1), cold-> (0,1,0), low -> (0,1)
new_instance = np.asmatrix([0,0,1,1,0,0,0,1]) 
prediction = clf.predict(new_instance)

# label for x* = (sunny, cold, low)?
# • dummy x**=(0, 0, 1, 1, 0, 0, 0, 1)
# • labels: 0 (”no”) and 1 (”yes”)
# (a) mild ≤ 0.5, we take the left branch 
# (b) rainy ≤ 0.5, we take the left branch
# (c) high ≤ 0.5, we take the left branch 
# (d) cold ≥ 0.5, we take the right branch
# (e) leaf node → ”yes”


prediction[0] # Labels: No:0, Yes:1


#######################
### Example 2
data = pd.DataFrame( 
	{'id': [ 1,2,3,4,5,6,7,8], 
	'Label': ['green', 'green', 'green', 'green','red', 'red', 'red', 'red'], 
	'Height': [5, 5.5, 5.33, 5.75,6.00 , 5.92 , 5.58 , 5.92] , 
	'Weight': [100, 150, 130, 150,180, 190, 170, 165],
	'Foot': [6, 8, 7, 9, 13, 11, 12, 10]}, 
	columns = ['id', 'Height', 'Weight','Foot', 'Label'] ) 

X = data[['Height', 'Weight', 'Foot']].values
Y = data[['Label']].values
clf = tree.DecisionTreeClassifier(criterion = 'entropy') 
clf = clf.fit(X,Y)
prediction = clf.predict(np.asmatrix([6, 160, 10]))

prediction[0]


#######################
### Example 3
import pandas as pd
import numpy as np
from sklearn.naive_bayes import GaussianNB
from sklearn.model_selection import train_test_split 
from sklearn.preprocessing import LabelEncoder

url = r'https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data'
iris_feature_names = ['sepal-length', 'sepal-width', 'petal-length', 'petal-width']
data = pd.read_csv(url, names=['sepal-length', 'sepal-width', 'petal-length', 
								'petal-width', 'Class'])
class_labels = ['Iris-versicolor', 'Iris-virginica'] 
data = data[data['Class'].isin(class_labels)]
X = data[iris_feature_names].values
le = LabelEncoder ()
Y = le.fit_transform(data['Class'].values)
X_train ,X_test ,Y_train ,Y_test = train_test_split(X,Y, test_size=0.5,random_state=3)

tree_classifier = tree.DecisionTreeClassifier(criterion = 'entropy') 
tree_classifier = tree_classifier.fit(X, Y)
prediction = tree_classifier.predict(X_test) 
error_rate = np.mean(prediction != Y_test)

error_rate


#######################
### Example 4 - Random Forest
from sklearn.ensemble import RandomForestClassifier
data = pd.DataFrame( 
	{'id': [ 1,2,3,4,5,6,7,8], 
	'Label': ['green', 'green', 'green', 'green','red', 'red', 'red', 'red'], 
	'Height': [5, 5.5, 5.33, 5.75,6.00 , 5.92 , 5.58 , 5.92] , 
	'Weight': [100, 150, 130, 150,180, 190, 170, 165],
	'Foot': [6, 8, 7, 9, 13, 11, 12, 10]}, 
	columns = ['id', 'Height', 'Weight','Foot', 'Label'] ) 

X = data[['Height', 'Weight', 'Foot']].values
Y = data[['Label']].values

class_labels_dict = {'green': 1, 'red': 0} 
label_color_dict = {1: 'green', 0: 'red'} 
data['class_labels']= data['Label'].map(class_labels_dict) 
# RansomForestClassifier
#   n_estimators: 	# of trees
#	criterion: 		"gini" or "entropy"
#   max_depth: 		the max depth of the tree
#	min_samples_split:the min # of samples to split 
#	min_samples_leaf: the min # of samples required to be a leaf
# 	n_jobs:			# of jobs run in parallel


model = RandomForestClassifier(n_estimators=5, max_depth=3, criterion='entropy')
model.fit(X, Y)
test_instance = np.asmatrix([6, 160, 10]) 
rf_label = int(model.predict(test_instance[0])) 
rf_color = label_color_dict[random_forest_label]

rf_color


#######################
### Example 5 - Random Forest classifier
from sklearn.ensemble import RandomForestClassifier
url = r'https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data'
iris_feature_names = ['sepal-length', 'sepal-width', 'petal-length', 'petal-width']
data = pd.read_csv(url, names=['sepal-length', 'sepal-width', 'petal-length', 
								'petal-width', 'Class'])
class_labels = ['Iris-versicolor', 'Iris-virginica'] 
data = data[data['Class'].isin(class_labels)]
X = data[iris_feature_names].values
le = LabelEncoder ()
Y = le.fit_transform(data['Class'].values)
X_train ,X_test ,Y_train ,Y_test = train_test_split(X,Y, test_size=0.5,random_state=3)

model = RandomForestClassifier(n_estimators=25, max_depth=5, criterion='entropy')
model.fit(X_train , Y_train)
prediction = model.predict(X_test) 
error_rate = np.mean(prediction != Y_test)
error_rate


#######################
### Example 6 - Random Forest regressor
from sklearn.ensemble import RandomForestRegressor
from sklearn import datasets

boston = datasets.load_boston()
features = boston.data[:, 0:2]
target = boston.target

randomforest = RandomForestRegressor(random_state=0)
model = randomforest.fit(features, target)


