# https://towardsml.com/2019/09/17/bert-explained-a-complete-guide-with-theory-and-tutorial/
"""
 4) Using BERT for Text Classification
    using the Yelp Reviews Polarity dataset

"""

# Importing the necessary modules
import pandas as pd
import tarfile
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split


# 1) Load Data
DATA_DIR = "../../data/yelp_review_polarity_csv/"
train_df = pd.read_csv(DATA_DIR + 'train.csv', header=None)
test_df = pd.read_csv(DATA_DIR + 'test.csv', header=None)
print(train_df.head())

# 2) Change data labels 1 & 2 to a more standard labels of 0 and 1
train_df[0] = (train_df[0] == 2).astype(int)
test_df[0] = (test_df[0] == 2).astype(int)

# 3) Creating TRAIN dataframe according to BERT by adding the required columns
df_bert = pd.DataFrame({
    'id':range(len(train_df)),
    'label':train_df[0],
    'alpha':['a']*train_df.shape[0],
    'text': train_df[1].replace(r'\n', ' ', regex=True)
})


# 4) Splitting TRAIN data file into *train* and *dev*
df_bert_train, df_bert_dev = train_test_split(df_bert, test_size=0.01)


# 5) Creating TEST dataframe according to BERT
df_bert_test = pd.DataFrame({
    'id':range(len(test_df)),
    'text': test_df[1].replace(r'\n', ' ', regex=True)
})

df_bert_test.head()

# 6) Saving dataframes to .tsv format as required by BERT
df_bert_train.to_csv(DATA_DIR + 'train.tsv', sep='\t', index=False, header=False)
df_bert_dev.to_csv(DATA_DIR + 'dev.tsv', sep='\t', index=False, header=False)
df_bert_test.to_csv(DATA_DIR + 'test.tsv', sep='\t', index=False, header=False)



print("End")


