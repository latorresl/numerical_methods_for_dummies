neville_interpolation <- function(x_values, y_values, x) {
  n <- length(x_values)
  Q <- matrix(0, n, n)  # Create a matrix for the Neville's chart
  
  # Initialize first column with known values
  for (i in 1:n) {
    Q[i, 1] <- y_values[i]
  }
  
  # Build the recursive chart
  for (j in 2:n) {
    for (i in j:n) {
      Q[i, j] <- ((x - x_values[i - j + 1]) * Q[i, j - 1] - (x - x_values[i]) * Q[i - 1, j - 1]) / (x_values[i] - x_values[i - j + 1])
    }
  }
  
  # The interoplation result is found in Q[n,n]
  interpolated_value <- Q[n, n]
  
  # Show recursive chart
  cat("Tabla de Neville:\n")
  print(Q)
  
  return(interpolated_value)
}

# Usage
x_values <- c(1, 1.3, 1.6, 1.9, 2.2)
y_values <- c(0.7651977, 0.6200860, 0.4554022, 0.2818186, 0.1103623)
x_interpolate <- 1.5 # xo to interpolate

result <- neville_interpolation(x_values, y_values, x_interpolate)
cat("\nEl valor interpolado en x =", x_interpolate, "es:", result, "\n")

# Just using pracma function
x_values <- c(1, 1.3, 1.6, 1.9, 2.2)
y_values <- c(0.7651977, 0.6200860, 0.4554022, 0.2818186, 0.1103623)
x_interpolate <- 1.5
library(pracma)
neville(x_values,y_values,x_interpolate)
