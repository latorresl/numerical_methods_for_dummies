import matplotlib.pyplot as plt
import numpy as np

def print_var(var_name, value):
    print("{} = {}".format(var_name, value))

def taylor2(f, df1, a, b, n, ya):
    vx = np.zeros(n)
    vy = np.zeros(n)
    exact = np.zeros(n)
    error = np.zeros(n)
    
    h = (b-a) / n
    x = a
    y = ya
    
    vx[0] = x
    vy[0] = y
    
    exact[0] = -np.sqrt(2)*(2*x - 4)*np.exp(1 - x/2) + 2*np.exp(2 - x) + x**2 - 4*x + 4 # EXACT SOLUTION (IF NEEDED)
    error[0] = abs(exact[0] - y)
    
    print("i: {:02d}\t t: {:.6f}\t w: {:.6f}\t y(t): {:.6f}\t |y(t)-w|: {:.6f}\n".format(0, x, y, exact[0], error[0]), end="")
    
    for i in range(0, n):
        y += h*(f(x,y) + 0.5*h*df1(x,y))
        x = a + (i + 1)*h
        
        exact_i = -np.sqrt(2)*(2*x - 4)*np.exp(1 - x/2) + 2*np.exp(2 - x) + x**2 - 4*x + 4 # EXACT SOLUTION (IF NEEDED)
        error_i = abs(exact_i - y)
        
        print(
            "i: {:02d}\t t: {:.6f}\t w: {:.6f}\t y(t): {:.6f}\t |y(t)-w|: {:.6f}\n".format(
                i + 1, x, y, exact_i, error_i), end="")
        
        vx[i] = x
        vy[i] = y
        exact[i] = exact_i
        error[i] = error_i
        
    return [vx,vy,exact,error]

def problem():
    print("\n\n[Problem] EDO: Taylor (2nd order)")
    
    def f(x,y): # x = t, so f(t,y)
        return x**(-2)*np.sin(2*x - 2*x*y)
    
    def df1(x,y): # x = t, so df1(t,y)
        return -(2*np.sin(2*x - 2*x*y))/(x**3) + ( np.cos(2*x - 2*x*y)*(2 - 2*(y+x*x**(-2)*np.sin(2*x - 2*x*y))) )/(x**2) 
    
    a = 1.0
    b = 2.0
    n = 4
    ya = 2
    print_var("a", a)
    print_var("b", b)
    print_var("n", n)
    print_var("ya", ya)
    
    [vx, vy, exact, error] = taylor2(f, df1, a, b, n, ya)
    print("For the mesh: {}".format((b - a)/n))
      
    plt.figure(figsize = (12,8))
    plt.plot(vx,vy,'r')
    plt.plot(vx,vy,'ob')
    x = np.arange(0,2,0.1)
    plt.title('Approximated solution')
    plt.xlabel('x')
    plt.ylabel('f(x)')
    plt.grid()
    
problem()
