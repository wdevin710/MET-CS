# -*- coding: utf-8 -*-
"""
Created on Tue Oct 30 16:18:58 2018

@author: epinsky
detailed analysis of iris dataset
# https://datascience.stackexchange.com/questions/32753/find-cluster-diameter-and-associated-cluster-points-with-kmeans-clustering-scik
"""
import os
from sklearn import datasets 
import numpy as np 
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
import matplotlib.patches as mpatches
from scipy.cluster.hierarchy import dendrogram, linkage
from sklearn.cluster import DBSCAN


iris = datasets.load_iris()

x = iris.data
y = iris.target


estimator = KMeans(n_clusters=3)
y_kmeans = estimator.fit_predict(x)


clusters_centroids=dict()
clusters_radii= dict()

'''looping over clusters and calculate Euclidian distance of 
each point within that cluster from its centroid and 
pick the maximum which is the radius of that cluster'''

for cluster in list(set(y)):
    clusters_centroids[cluster]=list(zip(estimator.cluster_centers_[:, 0],
                      estimator.cluster_centers_[:,1]))[cluster]
    cluster_points = zip(x[y_kmeans == cluster, 0],x[y_kmeans == cluster, 1])
    clusters_radii[cluster]=max([np.linalg.norm(np.array(i)-clusters_centroids[cluster]) for i in cluster_points])


fig, ax = plt.subplots(1,figsize=(7,5))

plt.scatter(x[y_kmeans == 0, 0], x[y_kmeans == 0, 1], s = 75, c = 'red', label = 'Iris-setosa')
#art = mpatches.Circle(clusters_centroids[0],clusters_radii[0], edgecolor='r',ls='--', fill=False)
#ax.add_patch(art)

plt.scatter(x[y_kmeans == 1, 0], x[y_kmeans == 1, 1], s = 75, c = 'blue', label = 'Iris-versicolour')
#art = mpatches.Circle(clusters_centroids[1],clusters_radii[1], edgecolor='b', ls='--', fill=False)
#ax.add_patch(art)

plt.scatter(x[y_kmeans == 2, 0], x[y_kmeans == 2, 1], s = 75, c = 'green', label = 'Iris-virginica')
#art = mpatches.Circle(clusters_centroids[2],clusters_radii[2], edgecolor='g',ls='--', fill=False)
#ax.add_patch(art)

#Plotting the centroids of the clusters
plt.scatter(estimator.cluster_centers_[:, 0], estimator.cluster_centers_[:,1], s = 200, c = 'black', label = 'Centroids')

plt.legend()
plt.tight_layout()

# Save 
input_dir = r"C:\Users\epinsky\bu\python\data_science_with_Python\plots"
filename = os.path.join(input_dir,'iris_clustering.pdf')
plt.savefig(filename,dpi=300)

plt.show()

# let us do hierarchical
Z = linkage(x, 'ward')

# set cut-off to 150
max_d = 7.08                # max_d as in max_distance

plt.figure(figsize=(25, 10))
plt.title('Iris Hierarchical Clustering Dendrogram')
plt.xlabel('Species')
plt.ylabel('distance')
dendrogram(
    Z,
    truncate_mode='lastp',  # show only the last p merged clusters
    p=150,                  # Try changing values of p
    leaf_rotation=90.,      # rotates the x axis labels
    leaf_font_size=8.,      # font size for the x axis labels
)
plt.axhline(y=max_d, c='k')
plt.show()



# example with DBSCAN for IRIS
from sklearn.preprocessing import StandardScaler
dbscan=DBSCAN()

scaler = StandardScaler()
scaler.fit(x)
x_scaled = scaler.transform(x)

dbscan.fit(x_scaled)
dbOutput = pd.DataFrame()
dbOutput = dbscan.fit_predict(x_scaled)

print(dbscan.labels_)

plt.scatter(x_scaled[:, 0], x_scaled[:, 1], c=dbOutput, s=32, cmap="viridis")


## USING PCA for plotting
# taken from https://fangya18.com/2018/12/19/clustering-analysis-iris-dataset/
from sklearn.decomposition import PCA

pca=PCA(n_components=2).fit(x)
pca_2d=pca.transform(x)
for i in range(0, pca_2d.shape[0]):
    if dbscan.labels_[i] == 0:
        c1 = plt.scatter(pca_2d[i, 0], pca_2d[i, 1], c='r', marker='+')
    elif dbscan.labels_[i] == 1:
        c2 = plt.scatter(pca_2d[i, 0], pca_2d[i, 1], c='g', marker='o')
    elif dbscan.labels_[i] == -1:
        c3 = plt.scatter(pca_2d[i, 0], pca_2d[i, 1], c='b', marker='*')

plt.legend([c1, c2, c3], ['Cluster 1', 'Cluster 2', 'Noise'])
plt.title('DBSCAN finds 2 clusters and Noise')
plt.show()


### DBSCAN
#Example from Hands-on machine leanring with Scikit-learn, Keras, and TF, by Geron
from sklearn.datasets import make_moons

X, y = make_moons(n_samples=1000, noise=0.05, random_state=42)

from sklearn.cluster import DBSCAN

dbscan = DBSCAN(eps=0.05, min_samples=5)
dbscan.fit(X)

dbscan.labels_[:10]

len(dbscan.core_sample_indices_)

dbscan.core_sample_indices_[:10]

dbscan.components_[:3]

np.unique(dbscan.labels_)

dbscan2 = DBSCAN(eps=0.2)
dbscan2.fit(X)

def plot_dbscan(dbscan, X, size, show_xlabels=True, show_ylabels=True):
    core_mask = np.zeros_like(dbscan.labels_, dtype=bool)
    core_mask[dbscan.core_sample_indices_] = True
    anomalies_mask = dbscan.labels_ == -1
    non_core_mask = ~(core_mask | anomalies_mask)

    cores = dbscan.components_
    anomalies = X[anomalies_mask]
    non_cores = X[non_core_mask]
    
    plt.scatter(cores[:, 0], cores[:, 1],
                c=dbscan.labels_[core_mask], marker='o', s=size, cmap="Paired")
    plt.scatter(cores[:, 0], cores[:, 1], marker='*', s=20, c=dbscan.labels_[core_mask])
    plt.scatter(anomalies[:, 0], anomalies[:, 1],
                c="r", marker="x", s=100)
    plt.scatter(non_cores[:, 0], non_cores[:, 1], c=dbscan.labels_[non_core_mask], marker=".")
    if show_xlabels:
        plt.xlabel("$x_1$", fontsize=14)
    else:
        plt.tick_params(labelbottom=False)
    if show_ylabels:
        plt.ylabel("$x_2$", fontsize=14, rotation=0)
    else:
        plt.tick_params(labelleft=False)
    plt.title("eps={:.2f}, min_samples={}".format(dbscan.eps, dbscan.min_samples), fontsize=14)

plt.figure(figsize=(9, 3.2))

plt.subplot(121)
plot_dbscan(dbscan, X, size=100)

plt.subplot(122)
plot_dbscan(dbscan2, X, size=600, show_ylabels=False)

plt.show()


## K means classifier
dbscan = dbscan2
from sklearn.neighbors import KNeighborsClassifier

knn = KNeighborsClassifier(n_neighbors=50)
knn.fit(dbscan.components_, dbscan.labels_[dbscan.core_sample_indices_])

X_new = np.array([[-0.5, 0], [0, 0.5], [1, -0.1], [2, 1]])
knn.predict(X_new)

knn.predict_proba(X_new)

def plot_data(X):
    plt.plot(X[:, 0], X[:, 1], 'k.', markersize=2)

def plot_centroids(centroids, weights=None, circle_color='w', cross_color='k'):
    if weights is not None:
        centroids = centroids[weights > weights.max() / 10]
    plt.scatter(centroids[:, 0], centroids[:, 1],
                marker='o', s=35, linewidths=8,
                color=circle_color, zorder=10, alpha=0.9)
    plt.scatter(centroids[:, 0], centroids[:, 1],
                marker='x', s=2, linewidths=12,
                color=cross_color, zorder=11, alpha=1)
# Resoluiton 1000 takes time - can be changed to 100 !    
def plot_decision_boundaries(clusterer, X, resolution=100, show_centroids=True,
                             show_xlabels=True, show_ylabels=True):
    mins = X.min(axis=0) - 0.1
    maxs = X.max(axis=0) + 0.1
    xx, yy = np.meshgrid(np.linspace(mins[0], maxs[0], resolution),
                         np.linspace(mins[1], maxs[1], resolution))
    Z = clusterer.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)

    plt.contourf(Z, extent=(mins[0], maxs[0], mins[1], maxs[1]),
                cmap="Pastel2")
    plt.contour(Z, extent=(mins[0], maxs[0], mins[1], maxs[1]),
                linewidths=1, colors='k')
    plot_data(X)
    if show_centroids:
        plot_centroids(clusterer.cluster_centers_)

    if show_xlabels:
        plt.xlabel("$x_1$", fontsize=14)
    else:
        plt.tick_params(labelbottom=False)
    if show_ylabels:
        plt.ylabel("$x_2$", fontsize=14, rotation=0)
    else:
        plt.tick_params(labelleft=False)

plt.figure(figsize=(6, 3))
plot_decision_boundaries(knn, X, show_centroids=False)
plt.scatter(X_new[:, 0], X_new[:, 1], c="b", marker="+", s=200, zorder=10)
plt.show()



