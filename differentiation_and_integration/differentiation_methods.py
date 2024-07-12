# BACKWARDS, CENTRAL AND FORWARD DIFFERENTIATION METHODS
import numpy as np
import matplotlib.pyplot as plt

def derivada(f,a,m,h):
    if m == 'central':
        return (f(a + h) - f(a - h))/(2*h)
    elif m == 'adelante':
        return (f(a + h) - f(a))/h
    elif m == 'atras':
        return (f(a) - f(a - h))/h
    else: 
        raise ValueError("El método debería ser 'central', 'adelante' o 'atras'.")

x = np.linspace(0,5*np.pi,100)
f = derivada(np.sin,x,'central',0.01)
fp = np.cos(x)

plt.figure(figsize=(12,5))
plt.plot(x,f,'r', label='Diferencia Central')
plt.plot(x,fp,'b',label='Valor verdadero')
plt.title('Derivada Diferencia Central de y = cos(x)')
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
print('La derivada de f(x)={} es f´(x)={}'.format(f(x),fp(x)))

d = richardson(f,x0,n,h)
error = abs((d[n,n]-Derivativedef(x0)/Derivativedef(x0)))
print(d)
print('Aproximación de la derivada \n f´({}) = {}'.format(x0,d[n,n]))
print('Valor exacto de la derivada \n f´({}) = {}'.format(x0,Derivativedef(x0)))
print('El error relativo es {}'.format(error))
