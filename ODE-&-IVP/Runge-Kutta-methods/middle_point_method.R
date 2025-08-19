# Define function (RK2)
runge_kutta_midp <- function(f, t_0, t_f, y0, h) {
  num_steps <- (t_f - t_0) / h
  ti <- seq(t_0, t_f, by = h)
  yi <- numeric(length(ti))
  yi[1] <- y0
  
  for (i in 1:(length(ti) - 1)) {
    k1 <- h * f(ti[i], yi[i])
    k2 <- h * f(ti[i] + h/2, yi[i] + k1/2)
    yi[i + 1] <- yi[i] + k2
  }
  
  # Create dataframe with results and evaluate the exact solution
  results <- data.frame(t = ti, y_aprox = yi)
  results$y_t<- sqrt(4 - 3*exp(-ti^2))  # Exact solution y(t) = (1/5)te^(3t) - (1/25)e^(3t) + (1/25)e^(-2t)
  
  return(results)
}

# Define ODE and function f(t,y)
f <- function(t, y) -t*y + 4*t/y

# Define interval, initial value and step size
t_0 <- 0 # Superior limit
t_f <- 1 # Inferior limit
y0 <- 1 # Initial condition
h <- 0.1 # step size
results <- runge_kutta_midp(f, t_0, t_f, y0, h)
print("Middple point method:")
print(results)