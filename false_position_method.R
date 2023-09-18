false_position <- function(f, a, b, delta = 1e-6, maxItr = 1000) {
  k <- 0
  an <- a
  bn <- b
  
  iter_table <- data.frame(Iteración = integer(),
                           an = numeric(),
                           bn = numeric(),
                           xn = numeric(),
                           e1 = numeric(),
                           e2 = numeric())
  
  repeat {
    xn <- an - f(an) * (bn - an) / (f(bn) - f(an))
    e1 <- xn - an
    e2 <- bn - xn
    
    if (f(xn) * f(an) > 0) {
      an <- xn
    } else {
      bn <- xn
    }
    
    k <- k + 1
    
    iter_table <- rbind(iter_table, data.frame(Iteración = k,
                                               an = an,
                                               bn = bn,
                                               xn = xn,
                                               e1 = e1,
                                               e2 = e2))
    
    if (max(e1, e2) <= delta || k >= maxItr) {
      break
    }
  }
  
  return(iter_table)
}

f = function(x) x^3-2*x^2-5
a = 1
b = 2

false_position(f,a,b)

# Obtener valores iniciales desde la terminal
a <- as.numeric(readline("Introduce el valor de a: "))
b <- as.numeric(readline("Introduce el valor de b: "))

# Ejecutar el método de posición falsa y obtener la tabla de iteraciones
iteraciones <- false_position(f, a, b)

# Imprimir la tabla de iteraciones
for (i in 1:nrow(iteraciones)) {
  cat("Iteración:", iteraciones$Iteración[i],
      "an:", iteraciones$an[i],
      "bn:", iteraciones$bn[i],
      "xi:", iteraciones$xn[i],
      "ErrorAbsoluto:", iteraciones$e1[i],
      "f(xi):", iteraciones$e2[i], "\n")
}