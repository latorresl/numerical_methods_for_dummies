secante = function(fun, x0, x1, tol, epsilon = 1e-10, maxiter = 100){
  f0 = fun(x0)
  f1 = fun(x1);
  k = 0;
  #Una tabla para imprimir la corrida del programa
  tabla = data.frame(A=" ", B=x0,C=x1,D=abs(x1-x0), E=fun(x1))
  while ( (abs(x1-x0)>tol*(abs(x1)+1) | abs(f1)>epsilon) & k <= maxiter ) {
    k = k+1
    pendiente = (f1 - f0)/(x1 - x0)
    # "pendiente" podría accidentalmente convertirse en NA (dato no disponible)
    if (pendiente ==0 | is.na(pendiente)){cat( "Problemas en la ’corrección’", "\n"); break}
    x2 = x1 - f1/pendiente # la correción es f1/pendiente
    f2 = fun(x2)
    x0 = x1; f0 = f1
    x1 = x2; f1 = f2
    # cada iteración es una nueva fila en la tabla
    tabla =rbind(tabla,data.frame(A=" ", B=x0,C=x1,D=abs(x1-x0), E=fun(x1)))
  }
  if (k > maxiter) {
    warning("Se alcanzó el número de iteraciones sin resultados")
  }
  # return(list(cero=x2, fun.cero=f2, iter=k, ErrorEst =abs(x2-x1)))
  colnames(tabla)=c("k", "x1","x2","|x1-x0|", "f(x1)")
  tabla
}
f = function(x) -0.00018201*x^8+0.00832472*x^7-0.15312966*x^6+1.45824748*x^5-7.69147799*x^4+22.03248204*x^3-30.28592681*x^2+14.32381607*x+75
options(digits=15)
secante(f,11,13,1e-4)