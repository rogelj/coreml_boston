"""
This script lets us explore the values in the Boston prices
dataset . We will use this information to develop a machine learning
model to be deployed in an iOS app.

Author: Dr J Rogel

Last modified: 20171230
"""

import pandas as pd
from sklearn import datasets

boston = datasets.load_boston()
boston_df = pd.DataFrame(boston.data)
boston_df.columns = boston.feature_names
y = boston.target


X = boston_df[['CRIM', 'RM']]
X.columns = ['Crime', 'Rooms']
X.describe()

# Crime       Rooms
# count  506.000000  506.000000
# mean     3.593761    6.284634
# std      8.596783    0.702617
# min      0.006320    3.561000
# 25%      0.082045    5.885500
# 50%      0.256510    6.208500
# 75%      3.647423    6.623500
# max     88.976200    8.780000
