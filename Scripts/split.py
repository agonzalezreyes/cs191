"""
Split motion.csv to individual  motion data files and save in ./Samples/ folder
"""

import numpy as np
import pandas as pd
import os.path

end_mark = 3.0
FOLDER = './Samples/'

data = pd.read_csv("motion.csv")
data.columns = data.columns.str.replace(' ', '')

# remove rows with time > 3s
indexTimes = data[ (data['time'] > end_mark) ].index
data.drop(indexTimes , inplace=True)
print(data)

data_dict = {}
num_sample = 0
file_title = str(data.iloc[num_sample][-1]) + "_" + str(num_sample)
num_samples = 0
start_indices = []
for i in range(len(data)):
    if np.isclose(data['time'].iloc[i], 0.0):
        start_indices.append(i) # sample start
        num_samples += 1
print(num_samples == len(start_indices))
print(start_indices)
start_indices.append(len(data)) # end of data

def clean_file_name(direction, num_sample):
    return FOLDER + str(direction).replace(' ', '') + "_" + str(num_sample) + '.csv'

num_sample = 0
for i in range(0, len(start_indices)-1):
    type = data.iloc[start_indices[i]]['direction']
    file_name = clean_file_name(type, num_sample) #FOLDER + str(data.iloc[start_indices[i]]['direction']).replace(' ', '') + "_" + str(num_sample) + '.csv'
    print(file_name)
    start = start_indices[i]
    end = start_indices[i+1] - 1
    print((start, end))
    df_sample = data.iloc[start:end]
    print(df_sample)
    df_sample.to_csv(file_name, index=False)
    num_sample += 1
