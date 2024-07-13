# Define the function f(x)
f <- function(x) exp(2*x) * sin(3*x)

# Define the adaptive quadrature function
adaptive_quadrature <- function(f, a, b, epsilon, max_depth = 10) {
  # Define the midpoint of the interval
  c <- (a + b) / 2
  
  # Calculate the approximations using Simpson's rule
  I_ab <- (b - a) / 6 * (f(a) + 4*f(c) + f(b))
  I_ac <- (c - a) / 6 * (f(a) + 4*f((a + c) / 2) + f(c))
  I_cb <- (b - c) / 6 * (f(c) + 4*f((c + b) / 2) + f(b))
  
  # Calculate the difference between the approximations
  diff_I <- abs(I_ab - (I_ac + I_cb))
  
  # Check if the difference is within the tolerance
  if (diff_I <= epsilon || max_depth == 0) {
    return(I_ac + I_cb)
  } else {
    # Recur on the subintervals
    left_result <- adaptive_quadrature(f, a, c, epsilon/2, max_depth - 1)
    right_result <- adaptive_quadrature(f, c, b, epsilon/2, max_depth - 1)
    return(left_result + right_result)
  }
}

# Define the interval [a, b] and tolerance epsilon
a <- 1
b <- 3
epsilon <- 1e-5

# Call the adaptive quadrature function
result <- adaptive_quadrature(f, a, b, epsilon)
print(paste("Approximation:", result))
