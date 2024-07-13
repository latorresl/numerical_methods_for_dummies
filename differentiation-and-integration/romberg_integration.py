import numpy as np
from scipy import integrate

f = lambda x: 1/(x*np.log(x))
a=np.exp(1)
b=2*np.exp(1)
integral = integrate.romberg(f,a,b,show=True,tol=1e-6,divmax=10)
