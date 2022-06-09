'''
 CS677 - Data Science with Python
 lecture - K-means
 By: Farshid Alizadeh-Shabdiz

'''


### Simple example
import pandas as pd
from sklearn.datasets import make_blobs
features , _ = make_blobs(n_samples=50, n_features=2, centers=3,  random_state=0)

#cluster_std=0.6,
dataframe = pd.DataFrame(features, columns=["feature_1", "feature_2"])
MyCluster = KMeans(n_clusters=3, random_state=0)

MyCluster.fit(features)

dataframe['group'] = MyCluster.predict(features)

dataframe.head(5)


print(MyCluster.labels_)

centers = MyCluster.cluster_centers_
print(centers)


plt.scatter(features[:, 0], features[:, 1], c=MyCluster.labels_, s=32, cmap="viridis")
plt.scatter(centers[:, 0], centers[:, 1], c='red', s=128, alpha=0.4);

MyCluster.predict([[0.5, 2.6], [2, 2], [3, 2], [1.23, 2.34]])

X = np.array([[1, 2], [1, 4], [1, 0],
              [2, 1], [3, 1],
              [4, 2], [4, 4], [4, 0]])

MyCluster.fit_predict(X) 		# Compute cluster centers and predict cluster index for each sample.
								# Convenience method; equivalent to calling fit(X) followed by predict(X).
MyCluster.fit_transform(X)		# Compute clustering and transform X to cluster-distance space.
								# In the new space, each dimension is the distance to the cluster centers. 
								# Note that even if X is sparse, the array returned by transform will typically be dense.


##############
import pandas as pd
import numpy as np
from sklearn.cluster import KMeans


data = pd.DataFrame(
		{'id': [ 1,2,3,4,5,6,7,8],
		'Label': ['green','green','green','green', 'red','red','red','red'],
		'Height': [5, 5.5, 5.33, 5.75,
			6.00 , 5.92 , 5.58 , 5.92] ,
		'Weight': [100, 150, 130, 150, 180, 190, 170, 165],
		'Foot': [6, 8, 7, 9, 13, 11, 12, 10]}, 
		columns = ['id', 'Height', 'Weight',
			'Foot', 'Label'] ) 

##############################
### k-Means 

init_centers = np.array([[5.0,7.0],[5.5, 9.0]])
colmap = {0: 'blue', 1: 'grey'}
n_clusters = 2
x = data[['Height', 'Foot']].values
kmeans_classifier = KMeans(n_clusters=n_clusters ,
		init=init_centers) 
y_kmeans=kmeans_classifier.fit_predict(x)

kmeans_classifier.cluster_centers_
y_kmeans


### Plotting
import matplotlib.pyplot as plt

fig = plt.figure()
centroids = kmeans_classifier.cluster_centers_

for i in range(n_clusters):
	new_df = data[y_kmeans==i] 
	plt.scatter(new_df['Height'],new_df['Foot'], color=colmap[i],
		s=100, label='points in cluster ' + str(i+1))
for i in range(n_clusters):
	plt.scatter(centroids[i][0], centroids[i][1], color=colmap[i],
		marker='x', s=300,label='centroid ' + str(i+1))
for i in range(len(data)):
	x_text = data['Height'].iloc[i] + 0.05
	y_text = data['Foot'].iloc[i] + 0.2
	id_text = data['id'].iloc[i]
	plt.text(x_text, y_text, str(id_text), fontsize=14)
 
plt.legend(loc='upper left') 
plt.xlim(4, 7)
plt.ylim(5, 15) 
plt.xlabel('Height') 
plt.ylabel('Foot') 
plt.show()

##############################
### Random initial centroids
colmap = {0: 'blue', 1: 'grey'}
x = data[['Height', 'Foot']].values 
kmeans_classifier = KMeans(n_clusters=n_clusters) 
y_kmeans=kmeans_classifier.fit_predict(x) 
centroids = kmeans_classifier.cluster_centers_

centroids
y_kmeans
##############################
### IRIS data clustering
from sklearn import datasets

iris = datasets.load_iris() 
x = iris.data

kmeans_classifier = KMeans(n_clusters=3) 
y_kmeans = kmeans_classifier.fit_predict(x) 
centroids = kmeans_classifier.cluster_centers_

centroids
y_kmeans

### Plotting
import matplotlib.pyplot as plt
fig, ax = plt.subplots(1,figsize=(7,5)) 
plt.scatter(x[y_kmeans == 0, 0], x[y_kmeans == 0, 1],
			s = 75, c = 'red', label = 'Iris-setosa') 
plt.scatter(x[y_kmeans == 1, 0], x[y_kmeans == 1, 1],
			s = 75, c = 'blue', label = 'Iris-versicolour') 
plt.scatter(x[y_kmeans == 2, 0], x[y_kmeans == 2, 1],
			s = 75, c = 'green', label = 'Iris-virginica') 
plt.scatter(centroids[:, 0], centroids[:,1],
			s = 200, c = 'black', label = 'Centroids') 

x_label = iris.feature_names[0]
y_label = iris.feature_names[1]

plt.legend() 
plt.xlabel(x_label) 
plt.ylabel(y_label) 
plt.tight_layout() 
plt.show()

### Code to compute K
from sklearn import datasets 
import matplotlib.pyplot as plt 
from sklearn.cluster import KMeans

iris = datasets.load_iris()
x = iris.data 
inertia_list = []
for k in range (1 ,26):
	kmeans_classifier = KMeans(n_clusters=k) 
	y_kmeans = kmeans_classifier.fit_predict(x) 
	inertia = kmeans_classifier.inertia_ 
	inertia_list.append(inertia)

fig, ax = plt.subplots(1,figsize=(7,5)) 
plt.plot(range(1, 26), inertia_list , marker='o', color='green')

plt.legend()
plt.xlabel('number of clusters: k') 
plt.ylabel('inertia') 
plt.tight_layout()
plt.show()








