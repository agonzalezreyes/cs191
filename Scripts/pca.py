import pandas as pd
from sklearn import decomposition
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
import seaborn as sb
from sklearn import preprocessing

def not_normalized():
    files = ['OutwardRot_0', 'Away_10', 'Closer_15', 'InwardRot_6', 'Left_4', 'Right_5']
    for file in files:
        data = pd.read_csv("./Samples/" + file + ".csv")
        pca = decomposition.PCA()
        motion_pca = pca.fit_transform(data[['accelerationX', 'accelerationY', 'accelerationZ', 'rotationRateX', 'rotationRateY', 'rotationRateZ']])
        print(pca.explained_variance_ratio_)
        motion_comps = pd.DataFrame(pca.components_, columns=['accelerationX', 'accelerationY', 'accelerationZ', 'rotationRateX', 'rotationRateY', 'rotationRateZ'])
        sb.heatmap(motion_comps, annot=True)
        plt.show()

def normalized():
    files = ['OutwardRot_0', 'Away_10', 'Closer_15', 'InwardRot_6', 'Left_4', 'Right_5']
    for file in files:
        data = pd.read_csv("./Samples/" + file + ".csv")
        pre_norm_data = data[['accelerationX', 'accelerationY', 'accelerationZ', 'rotationRateX', 'rotationRateY', 'rotationRateZ']].values
        min_max_scaler = preprocessing.MinMaxScaler()
        motion_scaler = min_max_scaler.fit_transform(pre_norm_data)
        motion_scaled = pd.DataFrame(motion_scaler, columns=['accelerationX', 'accelerationY', 'accelerationZ', 'rotationRateX', 'rotationRateY', 'rotationRateZ'])
        pca = decomposition.PCA()
        motion_pca = pca.fit_transform(motion_scaled[['accelerationX', 'accelerationY', 'accelerationZ', 'rotationRateX', 'rotationRateY', 'rotationRateZ']])
        print(pca.explained_variance_ratio_)
        motion_comps = pd.DataFrame(pca.components_, columns=['Acc_X', 'Acc_Y', 'Acc_Z', 'RotX', 'RotY', 'RotY'])
        ax = sb.heatmap(motion_comps, annot=True)
        print(sum(pca.explained_variance_ratio_[0:4])) # keep ~ 95 % of info from data
        plt.savefig("Normalized_" + file + ".png")
        plt.show()

normalized()
