'''
 CS677 - Data Science with Python
 lecture - Algorithm evaluation
 By: Farshid Alizadeh-Shabdiz

'''
###
# Confusion matrix
###
import pandas as pd
from sklearn.metrics import confusion_matrix

data = pd.DataFrame(
		{'id': [ 1,2,3,4,5,6,7,8],
		'Label': ['green','green','green','green', 'red','red','red','red'],
		'Height': [5, 5.5, 5.33, 5.75,
		6.00 , 5.92 , 5.58 , 5.92] ,
		'Weight': [100, 150, 130, 150, 180, 190, 170, 165],
		'Foot': [6, 8, 7, 9, 13, 11, 12, 10]}, 
		columns = ['id', 'Height', 'Weight',
			'Foot', 'Label'] ) 
data['Class'] = data['Label'].apply(lambda x: 1 if x=='green' else 0)
y_true = data['Class'].values
# assume that we got predictions from 3 models: 
y_pred_1 = [0,0,0,1,0,0,1,1]
y_pred_2 = [0,0,1,1,0,1,1,1]
y_pred_3 = [1,1,1,1,1,1,1,0]
cf_1 = confusion_matrix(y_true ,y_pred_3) 
cf_2 = confusion_matrix(y_true ,y_pred_3) 
cf_3 = confusion_matrix(y_true ,y_pred_3)

###
# Recall
###
import pandas as pd
from sklearn.metrics import recall_score

data = pd.DataFrame(
		{'id': [ 1,2,3,4,5,6,7,8],
		'Label': ['green','green','green','green', 'red','red','red','red'],
		'Height': [5, 5.5, 5.33, 5.75,
		6.00 , 5.92 , 5.58 , 5.92] ,
		'Weight': [100, 150, 130, 150, 180, 190, 170, 165],
		'Foot': [6, 8, 7, 9, 13, 11, 12, 10]}, 
		columns = ['id', 'Height', 'Weight',
			'Foot', 'Label'] ) 
data['Class'] = data['Label'].apply(lambda x: 1 if x=='green' else 0)
y_true = data['Class'].values
# assume that we got predictions from 3 models: 
y_pred_1 = [0,0,0,1,0,0,1,1]
y_pred_2 = [0,0,1,1,0,1,1,1]
y_pred_3 = [1,1,1,1,1,1,1,0]

tpr_1 = recall_score(y_true , y_pred_1) 
tpr_2 = recall_score(y_true , y_pred_2) 
tpr_3 =	recall_score(y_true , y_pred_3)

###
# Precision
###
from sklearn.metrics import precision_score

ppv_1 = precision_score(y_true , y_pred_1) 
ppv_2 = precision_score(y_true , y_pred_2) 
ppv_3 = precision_score(y_true , y_pred_3)


###
# accuracy score = (TP+TN) / All
###
from sklearn.metrics import accuracy_score

acc_1 = accuracy_score(y_true , y_pred_1) 
acc_2 = accuracy_score(y_true , y_pred_2) 
acc_3 = accuracy_score(y_true , y_pred_3)


###
# F1 score
###
from sklearn.metrics import f1_score

f1_1 = f1_score(y_true , y_pred_1) 
f1_2 = f1_score(y_true , y_pred_2) 
f1_3 = f1_score(y_true , y_pred_3)

###
# False negative rate: FN / (FN+TP)
# False postive rate: FP/(FP+TN)
# False Discovery rate: FDR = FP/(FP+TP)
# False omision rate: FN/(FN+TN)
###

###
# ROC and AUC
###
from sklearn.metrics import roc_auc_score

auc_1 = roc_auc_score(y_true , y_pred_1) 
auc_2 = roc_auc_score(y_true , y_pred_2) 
auc_3 = roc_auc_score(y_true , y_pred_3)








