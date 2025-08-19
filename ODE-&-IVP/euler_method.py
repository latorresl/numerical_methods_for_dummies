import matplotlib.pyplot as plt
import numpy as np

# ODE, where f(t,y) = y'(t)
def f(t,y): return t*np.exp(3*t) - 2*y

# Real solution (for plotting if needed)
def f1(t): return t*np.exp(3*t)/5 - np.exp(3*t)/25 + (1/25*np.exp(2*t))

def euler(a, b, N, y0):
    """ Euler method in [a,b] interval using
        N partitions and initial condition y0 """
    h = (b-a)/N
    t = np.zeros(N+1)
    y = np.zeros(N+1)
    t[0] = a 
    y[0] = y0
    for k in range(N):
        y[k + 1] = y[k] + h*f(t[k], y[k])
        t[k + 1] = t[k] + h
    return (t,y)

a = 0 # Superior limit
b = 1 # Inferior limit
N = 2 # Partitions --> Related to h=(b-a)/N --> N=(b-a)/h
y0 = 0 # Initial condition
(t,y) = euler(a, b, N, y0)
yex = f1(t)

for i in range(N+1):
    print("i: {:d}\t t: {:.6f}\t w: {:.6f}\t y(t):\
          {:.6f}\t |y(t)-w|: {:.6f}\n".format(i, t[i], y[i], yex[i], np.abs(f1(t[i])-y[i])), end="")

print('For the mesh: ' + str((b-a)/N))
plt.figure(figsize = (12,8))
plt.plot(t, y, 'r.-')
plt.plot(t, yex, 'b')
plt.xlabel('t')
plt.ylabel('y')
plt.legend([ 'Euler', 'Exact'])
plt.grid(True)
