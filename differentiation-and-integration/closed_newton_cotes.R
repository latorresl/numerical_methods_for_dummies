# NUMERICAL INTEGRATION BY CLOSED NEWTON COTES 

# Trapezoidal rule (n = 1)
trapezoidal_rule <- function(f, a, b) {
  h <- (b - a)
  x0 <- a
  x1 <- b
  return((h/2) * (f(x0) + f(x1)))
}

# Simpson Rule 1/3 (n = 2)
simpson_13_rule <- function(f, a, b) {
  h <- (b - a) / 2
  x0 <- a
  x1 <- a + h
  x2 <- b
  return((h/3) * (f(x0) + 4*f(x1) + f(x2)))
}

# Simpson Rule 3/8 (n = 3)
simpson_38_rule <- function(f, a, b) {
  h <- (b - a) / 3
  x0 <- a
  x1 <- a + h
  x2 <- a + 2*h
  x3 <- b
  return((3*h/8) * (f(x0) + 3*f(x1) + 3*f(x2) + f(x3)))
}

# (n = 4)
n4 <- function(f, a, b) {
  h <- (b - a) / 4
  x0 <- a
  x1 <- a + h
  x2 <- a + 2*h
  x3 <- a + 3*h
  x4 <- b
  return((2*h/45) * (7*f(x0) + 32*f(x1) + 12*f(x2) + 32*f(x3) +7*f(x4)))
}

# Usage
f <- function(x) 2/(x-4)
a <- 0
b <- 0.5

# Real value of the integral
integral <- integrate(f, lower = a, upper = b)
real_result <- integral$value

# Apply rules
result_trapezoidal <- trapezoidal_rule(f, a, b)
result_simpson_13 <- simpson_13_rule(f, a, b)
result_simpson_38 <- simpson_38_rule(f, a, b)
result_n4 <- n4(f, a, b)

# Calculate errors
error1 <- abs(integral$value-result_trapezoidal)
error2 <- abs(integral$value-result_simpson_13)
error3 <- abs(integral$value-result_simpson_38)
error4 <- abs(integral$value-result_n4)

# Print results
print(paste("Trapezoidal rule (n = 1):", result_trapezoidal))
print(paste("Error:", error1))
print(paste("Simpson Rule 1/3 (n = 2):", result_simpson_13))
print(paste("Error:", error2))
print(paste("Simpson Rule 3/8 (n = 3):", result_simpson_38))
print(paste("Error:", error3))
print(paste("(n = 4):", result_n4))
print(paste("Error:", error4))
