"""
Gathering gesture motion data into a single file organized by GESTURE NAME & ROTATION
"""
import os, os.path
import pandas as pd
import numpy as np

END = 3.0

df = pd.read_csv('motion.csv')
print(df)

df.columns = df.columns.str.replace(' ', '')
indexTimes = df[ (df['time'] > END) ].index
df.drop(indexTimes , inplace=True)
print(df)

def get_ranges(data):
    num_samples = 0
    ranges = []
    for i in range(len(data)):
        if np.isclose(data['time'].iloc[i], 0.0):
            ranges.append(i) # sample start
            num_samples += 1
    print(num_samples == len(ranges))
    ranges.append(len(data)) # end of data
    return ranges

ranges = get_ranges(df)
print(ranges)

clean_df = pd.DataFrame(columns=['gesture','rotRate'])
for i in range(0, len(ranges)-1):
    type = df.iloc[ranges[i]]['direction']
    start = ranges[i]
    end = ranges[i+1] - 1
    df_sample = df.iloc[start:end]
    x = df_sample[['rotationRateX', 'rotationRateY', 'rotationRateZ']].to_numpy()
    series = pd.Series(data={'gesture':type, 'rotRate':x.tolist()})
    df2 = pd.DataFrame([series])
    clean_df = pd.concat([clean_df,df2], ignore_index=True)

print(clean_df)
clean_df.to_csv('compact_data.csv', index=False)
    
