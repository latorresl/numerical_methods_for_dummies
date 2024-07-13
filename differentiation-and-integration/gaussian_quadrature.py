import numpy as np
from scipy.integrate import quad
from scipy.special import legendre

a = 0  # Inferior limit
b = np.pi/4  # Superior limit
n = 2

# Example function
def f(x):
    return (np.cos(x))**2

def gauss_quad(f, a, b, n):
    x, w = np.polynomial.legendre.leggauss(n)
    xp = 0.5*(b - a)*x + 0.5*(b + a)
    wp = 0.5*(b - a)*w
    integral = np.sum(wp * f(xp))
    return integral

integral_gauss = gauss_quad(f, a, b, n)

print(f'Integral gaussian quadrature: {integral_gauss}')
