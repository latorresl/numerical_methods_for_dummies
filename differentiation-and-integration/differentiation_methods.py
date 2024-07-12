# BACKWARD, CENTRAL AND FORWARD DIFFERENTIATION METHODS
import numpy as np
import matplotlib.pyplot as plt

def derivative(f,a,m,h):
    if m == 'central':
        return (f(a + h) - f(a - h))/(2*h)
    elif m == 'forward':
        return (f(a + h) - f(a))/h
    elif m == 'backward':
        return (f(a) - f(a - h))/h
    else: 
        raise ValueError("Method should be 'central', 'forward' or 'backward'.")

x = np.linspace(0,5*np.pi,100)
f = derivative(np.sin,x,'central',0.01)
fp = np.cos(x)

plt.figure(figsize=(12,5))
plt.plot(x,f,'r', label='Central difference')
plt.plot(x,fp,'b',label='True value')
plt.title('Derivative central difference of y = cos(x)')
plt.legend(loc='best')
plt.show()

# RICHARDSON METHOD
import numpy as np
import sympy as sym
x = sym.symbols('x')

def richardson(f,x0,n,h):
    d = np.array( [[0] * (n + 1)] * (n + 1), float)
    for i in range(n + 1):
        d[i,0] = 0.5*( f(x0 + h) - f(x0 - h) ) / h
        
        pd4 = 1
        for j in range(1,i + 1):
            pd4 = 4 * pd4
            d[i,j] = d[i,j - 1] + ( d[i,j - 1] - d[i - 1,j - 1] ) / (pd4 - 1)
        h = 0.5 * h
    return d

x0 = 2
h = 0.2
n = 3

def f(x):
    return x*sym.exp(x)

def fp(x):
    return sym.diff(f(x),x)

Derivativedef = sym.lambdify((x),fp(x), 'numpy')
print('Derivative of f(x)={} is f´(x)={}'.format(f(x),fp(x)))

d = richardson(f,x0,n,h)
error = abs((d[n,n]-Derivativedef(x0)/Derivativedef(x0)))
print(d)
print('Derivative approximation \n f´({}) = {}'.format(x0,d[n,n]))
print('Exact derivative value \n f´({}) = {}'.format(x0,Derivativedef(x0)))
print('Relative error is {}'.format(error))
