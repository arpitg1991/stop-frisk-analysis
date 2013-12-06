# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

f = '../data/acsTract.csv'

# <codecell>

import pandas as pd
import numpy as np

# <codecell>

df = pd.read_csv(f, sep = ',')

# <codecell>

df.columns

# <codecell>

from sklearn.decomposition import FactorAnalysis 

# <codecell>

numComponents = 4

# <codecell>

featureList = ['ACS_p_white', 'ACS_p_black', 'ACS_p_hispanic', 'ACS_p_otherRaces', 
               'ACS_p_edu_less_HS', 'someEdu', 'collegeDegree',
               'ACS_p_US_citizen', 'ACS_p_pop_poverty', 'ACS_p_unemployed',
               'ACS_avg_per_capita_income', 'ACS_p_house_food_stamps', 'ACS_n_household', 'PCT']

# <codecell>

df2 = df[featureList]

# <codecell>

pct_df = df2.groupby(by = 'PCT').mean()

# <codecell>

pct_df

# <codecell>

fa = FactorAnalysis(n_components= 3).fit(X)
componentMatrix = fa.components_ 

# <codecell>

fa.noise_variance_

# <codecell>

comps = pd.DataFrame(componentMatrix).T

# <codecell>

comps.index = pct_df.columns
comps

# <codecell>

comps.to_csv('factors.csv',sep = ',')

# <codecell>

X_transformed = fa.transform(X)

# <codecell>

factored = pd.DataFrame(X_transformed)

# <codecell>

factored.to_csv('factoredX.csv', sep = ',')

# <codecell>

from sklearn.cluster import KMeans

# <codecell>

# collapse into precinct dataset--- +++ crime a

# <codecell>

X_normalized = X_transformed
for i in range(0, X_normalized.shape[1]):
    X_normalized[:,i] = X_normalized[:,i] / X_normalized[:,i].std()

# <codecell>

kmeans = KMeans(n_clusters=3, init='k-means++', n_init=10, max_iter=800, 
          tol=0.0001, precompute_distances=True, verbose=0, random_state=123, copy_x=True, n_jobs=2)

# <codecell>

pct_df.iloc[:,[1,4,9]]

# <codecell>

x = pct_df.iloc[:,[1,4,9]].values

# <codecell>

for i in range(0, 2):
    x[:,i] = x[:,i] / x[:,i].std()

# <codecell>

kmeans.fit(x)

# <codecell>

X_labels = kmeans.predict(x)

# <codecell>

scatter(x[:,1], x[:,2], c = X_labels)

# <codecell>

    

