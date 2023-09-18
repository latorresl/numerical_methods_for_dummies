# g = function(x) (3*x^4+2*x^2+3)/(4*x^3+4*x-1), por ejemplo
# xo es el valor que se quiera que tome p
#1e-9 = 0.000000001
fixed_point =function(g, x0, tol=1e-2, maxIteraciones=100){
  k = 1
  # iteración hasta que abs(x1 - x0) <= tol o se alcance maxIteraciones
  repeat{
    x1 = g(x0)
    dx = abs(x1 - x0)
    x0 = x1
    #Imprimir estado
    cat("x ->", k, "=", x1, "\n")
    k = k+1
    #until
    if(dx< tol|| k > maxIteraciones) break;
  }
  # Mensaje de salida
  if( dx > tol ){
    cat("No hubo convergencia ")#return(NULL)
  } else{ cat("x* es aproximadamente ", x1, " con error menor que ", tol)}
}
g = function(x) (3*x^2+3)^(1/4) # La función g(x) debe ser cualquier función que salga
                                # de despejar x de la función original f(x).
fixed_point(g, 1)
