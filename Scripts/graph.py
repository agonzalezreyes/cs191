import numpy as np
import pandas as pd
import matplotlib as plt
import seaborn as sb
import matplotlib.pyplot as plt

sb.set_palette("husl",3)
sb.set_style("whitegrid")

fist_outward = pd.read_csv("./Samples/OutwardRot_0.csv")
print ('Number of samples: '+ str(len(fist_outward)))
fist_pairplot = sb.pairplot(fist_outward)
fist_pairplot.savefig("OutwardRot_0.png")
