import numpy as np
import pandas as pd
import datetime
import re
import os, os.path
import time
from sklearn.model_selection import train_test_split
import random
import tensorflow as tf

train_ratio = 0.75
validation_ratio = 0.15
test_ratio = 0.10

df = pd.read_csv('compact_data.csv')
train_set, test_set = train_test_split(df, test_size=1-train_ratio, random_state=0)
val_set, test_set = train_test_split(test_set, test_size=test_ratio/(test_ratio+validation_ratio), random_state=0)

print('len of train_set: '+ str(len(train_set)))
print('len of test_set: '+ str(len(test_set)))
print('len of val_set: '+ str(len(val_set)))
train_set.to_csv('train_set.csv', index=False)
test_set.to_csv('test_set.csv', index=False)
val_set.to_csv('val_set.csv', index=False)
