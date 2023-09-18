bisection = function(f, xa, xb, tol){
  if( sign(f(xa)) == sign(f(xb)) ){stop("f(xa) y f(xb) tienen el mismo signo")}
  # a = min(xa,xb)
  # b = max(xa,xb)
  a = xa; b = xb
  k = 0
  # Tabla imprimir
  tabla = data.frame(k="","a"=a,"b"=b,"m"=a+0.5*(b-a),
                     "errorEstimado"=(b-a)/2)
  repeat{
    m = a + 0.5*(b-a)
    if(f(m)==0){cat("Cero de f en [",xa,",",xb,"] es:", m)}
    if(sign(f(a)) != sign(f(m))){
      b = m
    }
    else { a = m}
    dx = (b-a)/2
    # cada iteración es una nuva fila en la tabla
    tabla = rbind(tabla,data.frame(k="","a"=a,"b"=b,"m"=m,
                                   "errorEstimado"=dx)
                  )
    k = k+1
    # until
    if(dx < tol){
      cat("Cero de f en [",xa,",",xb,"] es approx:",m,"con error <=",dx,"\n")
      cat("-------------------------------------------------\n\n")
      break;
    }
  } #repeat
  #imprimir tabla
  colnames(tabla)=c("k","a","b","m","(b-a)/2^k")
  print(tabla,right=F)#nombres alineados a la izquierda
}
f = function(x) 3*(x+1)*(x-0.5)*(x-1)
bisection(f,-1.25,2.5,1e-4)
