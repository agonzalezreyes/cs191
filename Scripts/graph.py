import numpy as np
import pandas as pd
import matplotlib as plt
import seaborn as sb
import matplotlib.pyplot as plt

files = ['OutwardRot_0', 'Away_10', 'Closer_15', 'InwardRot_6', 'Left_4', 'Right_5']

sb.set_palette("husl",3)
sb.set_style("whitegrid")

for file in files:
    data = pd.read_csv("./Samples/" + file + ".csv")
    clean_data = data.drop(['gravityX', 'gravityY', 'gravityZ','attitudeRoll', 'attitudePitch', 'attitudeYaw', 'direction'], axis=1)
    
    accel = data[['time', 'accelerationX', 'accelerationY', 'accelerationZ']]
    accel_melted = accel.melt('time',var_name='Accel''s', value_name='Meters/Sec^2')
    rot = data[['time','rotationRateX', 'rotationRateY', 'rotationRateZ']]
    rot_melted = rot.melt('time',var_name='Gyro''s',value_name='Rad/Sec')

    graph_accel = sb.relplot(x="time", y="Meters/Sec^2", hue='Accel''s', data=accel_melted, kind='line')
    graph_accel.set(ylim=(-22,22))
    graph_accel.savefig("graph_acc_" + file + ".png")
    graph_rot = sb.relplot(x="time", y="Rad/Sec", hue='Gyro''s', data=rot_melted, kind='line')
    graph_rot.set(ylim=(-5.5,5.5))
    graph_rot.savefig("graph_rot_" + file + ".png")

#    print(clean_data)
#    graph = sb.pairplot(clean_data)
#    graph.savefig(file + ".png")

"""
outward = pd.read_csv("./Samples/OutwardRot_0.csv")
print('Number of samples: '+ str(len(outward)))
outward = sb.pairplot(outward)
outward.savefig("Main_OutwardRot_0.png")
"""
