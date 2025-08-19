import numpy as np
import sympy as sym

# NATURAL CUBIC SPLINE METHOD
def CubicNatural(xi, yi):
    m = xi.size # m is the number of datapoints
    n = m - 1
    a = np.zeros(m)
    b = np.zeros(n)
    c = np.zeros(m)
    d = np.zeros(n)
    for i in range(m):
        a[i] = yi[i]
    h = np.zeros(n)
    for i in range(n):
        h[i] = xi[i+1] - xi[i]
    alfa = np.zeros(n)
    alfa[0] = 0
    for i in range(1, n):
        alfa[i] = 3*(a[i+1]-a[i])/h[i]-3*(a[i]-a[i-1])/h[i-1]
    l = np.zeros(m)
    z = np.zeros(m)
    u = np.zeros(n)
    l[0] = 1
    z[0] = 0
    u[0] = 0
    for i in range(1, n):
        l[i] = 2*(xi[i+1]-xi[i-1])-h[i-1]*u[i-1]
        u[i] = h[i]/l[i]
        z[i] = (alfa[i]-h[i-1]*z[i-1])/l[i]
    l[m-1] = 1
    z[m-1] = 0
    c[m-1] = 0
    for i in np.flip(np.arange(n)):
        c[i] = z[i]-u[i]*c[i+1]
        b[i] = (a[i+1]-a[i])/h[i]-h[i]*(c[i+1]+2*c[i])/3
        d[i] = (c[i+1]-c[i])/(3*h[i])
    
    x = sym.Symbol('x')
    px_tabla = []
    for j in range(0,n,1):
        
        pxtramo = d[j]*(x-xi[j])**3 + c[j]*(x-xi[j])**2
        pxtramo = pxtramo + b[j]*(x-xi[j])+ a[j]
        
        px_tabla.append(pxtramo)
    return a, b, c, d,px_tabla

# CLAMPED CUBIC SPLINE METHOD
def CubicCon(xi, yi, yprima_x0, yprima_xn):
    m = xi.size
    n = m - 1
    A = np.zeros(m)
    B = np.zeros(n)
    C = np.zeros(m)
    D = np.zeros(n)
    for i in range(m):
        A[i] = yi[i]
    h = np.zeros(n)
    for i in range(n):
        h[i] = xi[i+1] - xi[i]
    u = np.zeros(m)
    u[0] = 3*(A[1]-A[0])/h[0]-3*yprima_x0
    u[m-1] = 3*yprima_xn-3*(A[n-1]-A[m-2])/h[m-2]
    for i in range(1, n):
        u[i] = 3*(A[i+1]-A[i])/h[i]-3*(A[i]-A[i-1])/h[i-1]
    s = np.zeros(m)
    z = np.zeros(m)
    t = np.zeros(n)
    s[0] = 2*h[0]
    t[0] = 0.5
    z[0] = u[0]/s[0]
    for i in range(1, n):
        s[i] = 2*(xi[i+1]-xi[i-1])-h[i-1]*t[i-1]
        t[i] = h[i]/s[i]
        z[i] = (u[i]-h[i-1]*z[i-1])/s[i]
    s[m-1] = h[m-2]*(2-t[n-2])
    z[m-1] = (u[m-1]-h[m-2]*z[m-2])/s[m-1]
    C[m-1] = z[m-1]
    for i in np.flip(np.arange(n)):
        C[i] = z[i]-t[i]*C[i+1]
        B[i] = (A[i+1]-A[i])/h[i]-h[i]*(C[i+1]+2*C[i])/3
        D[i] = (C[i+1]-C[i])/(3*h[i])
    x = sym.Symbol('x')
    px_tabla = []
    for j in range(0,n,1):
        
        pxtramo = D[j]*(x-xi[j])**3 + C[j]*(x-xi[j])**2
        pxtramo = pxtramo + B[j]*(x-xi[j])+ A[j]
        
        px_tabla.append(pxtramo)
    return A, B, C, D,px_tabla

# Usage
xi = np.array([0.1,0.2,0.3,0.4]) # xi values
fi = np.array([-0.62049958,-0.28398668,0.00660095,0.24842440]) # f(xi) values
# If needed for clamped cubic spline(example)
# yprime_x0 = 1
# yprime_xn = 1

# :: SELECT THE METHOD ::
# a,b,c,d,px_tabla = SC.CubicNatural(xi, fi)
# A, B, C, D,px_tabla = SCC.CubicCon(xi, fi, yprime_x0, yprime_xn)