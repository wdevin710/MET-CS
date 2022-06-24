##########################
### Lecture SVM - CS677 
### Farshid Alizadeh-Shabdiz
### 


import pandas as pd
import numpy as np
from sklearn import svm
from sklearn.preprocessing import StandardScaler

data = pd.DataFrame( 
	{'id': [ 1,2,3,4,5,6,7,8], 
	'Label': ['green', 'green', 'green', 'green','red', 'red', 'red', 'red'], 
	'Height': [5, 5.5, 5.33, 5.75,6.00 , 5.92 , 5.58 , 5.92] , 
	'Weight': [100, 150, 130, 150,180, 190, 170, 165],
	'Foot': [6, 8, 7, 9, 13, 11, 12, 10]}, 
	columns = ['id', 'Height', 'Weight','Foot', 'Label'] ) 

print(data)


X = data[['Height', 'Weight']].values 
scaler = StandardScaler() 
scaler.fit(X)
X = scaler.transform(X)
Y = data['Label'].values

svm_classifier = svm.SVC(kernel='linear')
svm_classifier.fit(X,Y)

new_x = scaler.transform(np.asmatrix([6, 160])) 
predicted = svm_classifier.predict(new_x) 
accuracy = svm_classifier.score(X, Y)

print(predicted[0])
print(accuracy)

# SVM with modified dataset
data['Height'].iloc[0] = 6
data['Weight'].iloc[0] = 170 
data['Foot'].iloc[0] = 10

X = data[['Height', 'Weight']].values 
scaler = StandardScaler() 
scaler.fit(X)
X = scaler.transform(X)
Y = data['Label'].values

svm_classifier = svm.SVC(kernel='linear')
svm_classifier.fit(X,Y)

new_x = scaler.transform(np.asmatrix([6, 160])) 
predicted = svm_classifier.predict(new_x) 
accuracy = svm_classifier.score(X, Y)

print(predicted[0])
print(accuracy)


###
# Gaussian SVM with modified dataset
X = data[['Height', 'Weight']].values 
scaler = StandardScaler() 
scaler.fit(X)
X = scaler.transform(X)
Y = data['Label'].values

svm_classifier = svm.SVC(kernel='rbf')
svm_classifier.fit(X,Y)

new_x = scaler.transform(np.asmatrix([6, 160])) 
predicted = svm_classifier.predict(new_x) 
accuracy = svm_classifier.score(X, Y)

print(predicted[0])
print(accuracy)


###
# Polynomial (d=2) SVM with modified dataset
X = data[['Height', 'Weight']].values 
scaler = StandardScaler() 
scaler.fit(X)
X = scaler.transform(X)
Y = data['Label'].values

svm_classifier = svm.SVC(kernel='poly', degree=2)
svm_classifier.fit(X,Y)

new_x = scaler.transform(np.asmatrix([6, 160])) 
predicted = svm_classifier.predict(new_x) 
accuracy = svm_classifier.score(X, Y)

print(predicted[0])
print(accuracy)

###
# Polynomial (d=5) SVM with modified dataset
X = data[['Height', 'Weight']].values 
scaler = StandardScaler() 
scaler.fit(X)
X = scaler.transform(X)
Y = data['Label'].values

svm_classifier = svm.SVC(kernel='poly', degree=5)
svm_classifier.fit(X,Y)

new_x = scaler.transform(np.asmatrix([6, 160])) 
predicted = svm_classifier.predict(new_x) 
accuracy = svm_classifier.score(X, Y)

print(predicted[0])
print(accuracy)


###
# Polynomial (d=9) SVM with modified dataset
X = data[['Height', 'Weight']].values 
scaler = StandardScaler() 
scaler.fit(X)
X = scaler.transform(X)
Y = data['Label'].values

svm_classifier = svm.SVC(kernel='poly', degree=9)
svm_classifier.fit(X,Y)

new_x = scaler.transform(np.asmatrix([6, 160])) 
predicted = svm_classifier.predict(new_x) 
accuracy = svm_classifier.score(X, Y)

print(predicted[0])
print(accuracy)

