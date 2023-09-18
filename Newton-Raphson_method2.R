newtonraphson = function(fun, x0, tol = 0.000000005, maxiter = 100){
  numiter = 0
  library(Deriv)
  fp = Deriv(fun) # fun’ respecto a x
  correccion = -fun(x0)/fp(x0)
  #Una tabla para imprimir la corrida del programa
  tabla = data.frame(A=" ", B= x0, ErrorEstimado=correccion)
  while (abs(correccion) >= tol && numiter <= maxiter) {
    numiter = numiter + 1
    # "correccion" podría accidentalmente convertirse en NA (dato no disponible)
    if (fp(x0) == 0 | is.na(correccion)) stop("Problemas en la corrección")
    x1 = x0 + correccion
    correccion = -fun(x1)/fp(x1)
    x0 = x1
    tabla =rbind(tabla,data.frame(A=" ", B= x0, ErrorEstimado=correccion))
  }
  if (numiter > maxiter){ warning("Se alcanzó el máximo número de iteraciones.")
    cat("Estado:\n")
    cat("k = ", k, "x = ", x1, " f(x) = ", fun(x1), "Error estimado <= ", correccion, "\n\n")
  } else {
    #return(list(cero = x0, fun.cero = fun(x0), numeroiter=numiter, error.est = correccion))
    colnames(tabla)=c("k", "xk"," -fun(x1)/fp(x1)")
    print(tabla,right=F) #nombres alineados a la derecha
  }
}
## --- Pruebas
f = function(x) x^2-6 # definir función f
newtonraphson(f, 1, 0.00000005, 10)
#