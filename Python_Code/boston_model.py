"""
This script implements a machine learning model on the
Boston house prices dataset to predict the price of a house
given a number of features.

The model is then converted to .mlmodel file to be used in an iOS
native app.

Author: Dr J Rogel

Last modified: 20191009
"""

import coremltools
import pandas as pd
from sklearn import datasets, linear_model
from sklearn.model_selection import train_test_split
from sklearn import metrics
import numpy as np


def glm_boston(X, y):
    print("Implementing a simple linear regression.")
    lm = linear_model.LinearRegression()
    gml = lm.fit(X, y)
    return gml


def main():
    print('Starting up - Loading Boston dataset.')
    boston = datasets.load_boston()
    boston_df = pd.DataFrame(boston.data)
    boston_df.columns = boston.feature_names
    print(boston_df.columns)

    print("We now choose the features to be included in our model.")
    X = boston_df[['CRIM', 'RM']]
    y = boston.target

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=7)

    my_model = glm_boston(X_train, y_train)

    coefs = [my_model.intercept_, my_model.coef_]

    print("The intercept is {0}.".format(coefs[0]))
    print("The coefficients are {0}.".format(coefs[1]))
    print(coefs)

    print("Let us check the predictions:")
    y_pred = my_model.predict(X_test)

    # calculate MAE, MSE, RMSE
    print("The mean absolute error is {0}.".format(
        metrics.mean_absolute_error(y_test, y_pred)))
    print("The mean squared error is {0}.".format(
        metrics.mean_squared_error(y_test, y_pred)))
    print("The root mean squared error is {0}.".format(
        np.sqrt(metrics.mean_squared_error(y_test, y_pred))))
    print("The r-squared {0}.".format(
        metrics.r2_score(y_test, y_pred)))

    print("Let us now convert this model into a Core ML object:")

    # Convert model to Core ML
    coreml_model = coremltools.converters.sklearn.convert(my_model,
                                            input_features=["crime", "rooms"],
                                            output_feature_names="price")

    # Save Core ML Model
    coreml_model.author = 'JRogel'
    coreml_model.license = 'BSD'
    coreml_model.short_description = 'Predicts the price of a house in the Boston area (1970s).'
    coreml_model.save('PriceBoston.mlmodel')
    print('Done!')


if __name__ == '__main__':
    main()
