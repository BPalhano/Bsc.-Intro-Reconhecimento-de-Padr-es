import numpy as np
from scipy.spatial.distance import mahalanobis

class Covariance:

    def __init__(self, data):
        self._data = data
    
    def std_cov(self):
        pass

    def mat_cov(self):
        pass

    def vet_cov(self):
        pass

    def svd_cov(self):
        pass


class Correlation:
    
    def __init__(self, data):
        self._data = data

    def mat_corr(self):
        pass

    def recursive_corr(self):
        pass


class Quadratic_classifier:

    def __init__(self, data, num_rep, perc_train):
        
        self._data = data
        self._nr   = num_rep 
        self._ptrain = perc_train

    def mean_centroid(self, n_ind, n_exp, size):
        
        centroid = np.zeros((size, n_ind))
        for feat in range(n_ind): # Centroide pela média
            mean_centroid = np.mean(self._data[n_exp*feat:n_exp*feat + (n_exp-1),:], axis=0)
            centroid[:,feat] = mean_centroid[0:size]
        return centroid

    def mean_centroid(self, n_ind, n_exp, size):
        
        centroid = np.zeros((size, n_ind))
        for feat in range(n_ind): # Centroide pela mediana
            median_centroid = np.median(self._data[n_exp*feat:n_exp*feat + (n_exp-1),:], axis=0)
            centroid[:,feat] = median_centroid[0:size]
        return centroid
    
    def quad_default(self):
        pass

    def quad_mode_1(self):
        pass
    
    def quad_mode_2(self):
        pass
    
    def quad_mode_3(self):
        pass
        
    def quad_mode_4(self):
        pass

    def linear_MQ(self):
        pass