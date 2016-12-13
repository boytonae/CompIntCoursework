require 'csv'

data = CSV.read('cwk_test.csv')
print data

# Split data 2/3 for training
# and 1/3 for checking to avoid overfitting
