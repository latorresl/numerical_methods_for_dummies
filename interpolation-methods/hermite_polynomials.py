import numpy as np
from sympy import Symbol, lambdify, expand, pprint
import matplotlib.pyplot as plt
x = Symbol('x')

def diferencia(x,y,yp):
    n = len(x)
    z = np.empty(shape=2 * n, dtype=float)
    Q = np.zeros(shape=(2 * n, 2 * n), dtype=float)
    d = np.empty(shape=2 * n, dtype=float)
    
    for i in np.arange(n):
        z[2 * i] = x[i]
        z[2 * i + 1] = x[i]
        Q[2 * i][0] = y[i]
        Q[2 * i + 1][0] = y[i]
        Q[2 * i + 1][1] = yp[i]
        if i !=0:
            Q[2 * i][1] = (Q[2 * i][0] - Q[2 * i - 1][0]) / (z[2 * i] - z[2 * i - 1])
    
    for i in np.arange(2, 2 * (n - 1) + 2):
        for j in np.arange(2, i + 1):
            f = Q[i][j - 1] - Q[i - 1][j - 1]
            g = z[i] - z[i - j]
            Q[i][j] = f / g
    d = Q.diagonal()
    return z, d

def polhermitesym(diff, z):
    n = len(z) - 1
    pol = diff[n]
    for k in np.arange(1, n + 1):
        pol = diff[n - k] + (x - z[n - k])*pol
    return pol

if __name__ == '__main__':
    # Usage
    datos_x = np.array([0.30, 0.32, 0.35], dtype=float) # xi values
    datos_y = np.array([0.29552, 0.31457, 0.34290], dtype=float) # f(xi) values
    datos_yp = [0.95534, 0.94924, 0.93937] # f'(xi) values
    
    d = diferencia(datos_x, datos_y, datos_yp)
    diff = d[1]
    polhermitesym = polhermitesym(diff, d[0])
    pprint('Hermite interpolating polynomial is:')
    pprint(expand(polhermitesym))
    pprint('Obtained aproximated value with x={0} is H({0})={1}'.format(0.34, polhermitesym.subs(x, 0.34))) # Here goes the point to interpolate
    polisimple = polhermitesym.expand()
    px = lambdify(x,polisimple)
    muestras = 101
    pxi = np.linspace(0.25,0.40,muestras)
    pfi = px(pxi)
    plt.plot(datos_x,datos_y,'o', label = 'Puntos', color = 'red')
    plt.plot(pxi,pfi, label = 'Polinomio', color = 'blue')
    plt.legend()
    plt.xlabel('xi')
    plt.ylabel('f(xi)')
    plt.title('Hermite Interpolation')
