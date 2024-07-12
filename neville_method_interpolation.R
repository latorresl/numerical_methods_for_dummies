neville_interpolation <- function(x_values, y_values, x) {
  n <- length(x_values)
  Q <- matrix(0, n, n)  # Crear una matriz para la tabla de Neville
  
  # Inicializar la primera columna con los valores conocidos
  for (i in 1:n) {
    Q[i, 1] <- y_values[i]
  }
  
  # Construir la tabla recursiva
  for (j in 2:n) {
    for (i in j:n) {
      Q[i, j] <- ((x - x_values[i - j + 1]) * Q[i, j - 1] - (x - x_values[i]) * Q[i - 1, j - 1]) / (x_values[i] - x_values[i - j + 1])
    }
  }
  
  # El resultado de la interpolación se encuentra en Q[n, n]
  interpolated_value <- Q[n, n]
  
  # Mostrar la tabla recursiva
  cat("Tabla de Neville:\n")
  print(Q)
  
  return(interpolated_value)
}

# Ejemplo de uso
x_values <- c(1, 1.3, 1.6, 1.9, 2.2)
y_values <- c(0.7651977, 0.6200860, 0.4554022, 0.2818186, 0.1103623)
x_interpolate <- 1.5 # Se debe poner el valor de x_o que se quiere interpolar, no f(x_o)

result <- neville_interpolation(x_values, y_values, x_interpolate)
cat("\nEl valor interpolado en x =", x_interpolate, "es:", result, "\n")

# Solución rápida con pracma
#library(pracma)
#neville(x_values,y_values,x_interpolate)

x_values <- c(1, 1.3, 1.6, 1.9, 2.2)
y_values <- c(0.7651977, 0.6200860, 0.4554022, 0.2818186, 0.1103623)
x_interpolate <- 1.5
library(pracma)
neville(x_values,y_values,x_interpolate)