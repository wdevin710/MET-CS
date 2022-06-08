'''
 CS677 - Data Science with Python
 
 Linear Regression
 By: Farshid Alizadeh-Shabdiz

'''

import numpy as np
from sklearn.metrics import mean_squared_error , r2_score
import matplotlib as plt

# Create a sample data
x = np.array([1, 2, 3, 4, 6, 8]) 
y = np.array([1, 1, 5, 8, 3, 5]) 

# Simple linear model
degree = 1
weights = np.polyfit(x,y, degree) 	# The highest power comes 
									#first in that array and the last item is the intercept of the model.
model = np.poly1d(weights) 
predicted = model(x)
rmse = np.sqrt(mean_squared_error(y,predicted)) 
r2 = r2_score(y,predicted)


print(weights)
print(model)
print(rmse)
print(r2)


# Ploting the line
id_list = ['1','2','3','4','5','6']
x_points = np.linspace(0.75,9.5, 1000) 
y_points = model(x_points)
ax, fig = plt.subplots()
plt.xlim(0, 10)
plt.ylim(0, 10)
plt.xlabel('X')
plt.ylabel('Y', rotation=0)
plt.plot(x_points , y_points , lw=4, color='blue') 
plt.scatter(x, y, color='black', s=200)
for i, txt in enumerate(id_list): 
	plt.text(x[i]+0.2, y[i]+0.2, txt, fontsize=10)

x_new = 9
y_new = model(x_new)
plt.scatter(x_new, y_new, color='blue', edgecolor='k', s=400) 
plt.plot([x_new, x_new],[0, y_new], color='black', ls='dotted') 
plt.text(x_new +0.4, y_new +0.2, '7', fontsize=10)
plt.show()


# Polynomial linear regression
degree = 2
weights = np.polyfit(x,y, degree) 
model = np.poly1d(weights) 
predicted = model(x)
rmse = np.sqrt(mean_squared_error(y,predicted)) 
r2 = r2_score(y,predicted)

print(weights)
print(model)
print(rmse)
print(r2)

# degree of 3 polynomial
degree = 3
weights = np.polyfit(x,y, degree) 
model = np.poly1d(weights) 
predicted = model(x)
rmse = np.sqrt(mean_squared_error(y,predicted)) 
r2 = r2_score(y,predicted)

print(weights)
print(model)
print(rmse)
print(r2)


noise = np.random.normal(loc=0,scale=0.1,size=(6,)) 
y = y + noise
weights = np.polyfit(x,y, degree)
model = np.poly1d(weights)
predicted = model(x)
rmse = np.sqrt(mean_squared_error(y,predicted)) 
r2 = r2_score(y,predicted)

print(weights)
print(model)
print(rmse)
print(r2)


###
### Linear Regression using Scikit Learn module
from sklearn.linear_model import LinearRegression
x = np.array([1,2,3,4,6,8])
y = np.array([1,1,5,8,3,5])
x_2 = x[:,np.newaxis]
lin_reg = LinearRegression(fit_intercept=True) 
lin_reg.fit(x_2, y)

r2 = lin_reg.score(x_2,y) # R2 calculation

print(r2)
print(lin_reg.coef_)
print(lin_reg.intercept_)

r2_adj = 1 - (1-lin_reg.score(x_2, y))*(len(y)-1)/(len(y)-x_2.shape[1]-1) # Adjusted R2
print(r2_adj)

