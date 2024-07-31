# Define ODE, f(t,y)
f <- function(t, y) -5*y + 5*t^2 + 2*t

# Real ODE solution
y_real <- function(t) t^2 + 1/3*exp(-5*t)

# Modified Euler method
euler_mod <- function(f, y0, t_values, h) {
  # Initialize vectors to store results & errors
  t <- numeric(length(t_values))
  y <- numeric(length(t_values))
  error <- numeric(length(t_values))
  
  # Asign initial value
  t[1] <- t_values[1]
  y[1] <- y0
  
  # Implement mod Euler method & calculate absolute error
  for (i in 1:(length(t_values) - 1)) {
    t[i] <- t_values[i]
    k1 <- h * f(t[i], y[i])
    k2 <- h * f(t[i] + h, y[i] + k1)
    y[i+1] <- y[i] + 0.5 * (k1 + k2)
    error[i] <- abs(y_real(t[i]) - y[i])
  }
  
  # Asign las t value & calculate error
  t[length(t_values)] <- t_values[length(t_values)]
  error[length(t_values)] <- abs(y_real(t[length(t_values)]) - y[length(t_values)])
  
  # Return results & errors as a list
  results <- list(t = t, y = y, error = error)
  return(results)
}

# Define initial values and step size
y0 <- 1/3 
N <- 10 # partitions
h <- 0.1 # step size
t_values <- seq(0, 1, by = 0.1)  # t_i = 0.2i para i = 0, 1, ..., N=10

results <- euler_mod(f, y0, t_values, h)

options(digits = 8) 

# Print results
print("Resultados:")
print("t\t\ty\t\tError")
for (i in 1:length(resultado$t)) {
  cat(resultado$t[i], "\t\t", resultado$y[i], "\t\n")
}
