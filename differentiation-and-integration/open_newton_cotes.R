# Middle point rule (n = 0)
n0_midpoint_rule <- function(f, a, b) {
  h <- (b - a)/2
  x0 <- a + h
  return(2*h * f(x0))
}

# (n = 1)
n1 <- function(f, a, b) {
  h <- (b - a)/3
  x0 <- a + h
  x1 <- a + 2*h
  return(((3*h)/2) * (f(x0) + f(x1)))
}

# (n = 2)
n2 <- function(f, a, b) {
  h <- (b - a) / 4
  x0 <- a + h
  x1 <- a + 2*h
  x2 <- a + 3*h
  return(((4*h)/3) * (2*f(x0) - f(x1) + 2*f(x2)))
}

# (n = 3)
n3 <- function(f, a, b) {
  h <- (b - a) / 5
  x0 <- a + h
  x1 <- a + 2*h
  x2 <- a + 3*h
  x3 <- a + 4*h
  return((5*h/24) * (11*f(x0) + f(x1) + f(x2) + 11*f(x3)))
}

# Usage
f <- function(x) 2/(x-4)
a <- 0
b <- 0.5

# Real integral value
integral <- integrate(f, lower = a, upper = b)
real_result <- integral$value

# Apply rules
result_n0_midpoint_rule <- n0_midpoint_rule(f, a, b)
result_n1 <- n1(f, a, b)
result_n2 <- n2(f, a, b)
result_n3 <- n3(f, a, b)

# Calculate errors
error0 <- abs(integral$value-result_n0_midpoint_rule)
error1 <- abs(integral$value-result_n1)
error2 <- abs(integral$value-result_n2)
error3 <- abs(integral$value-result_n3)

# Print results
print(paste("Middle point rule (n = 0):", result_n0_midpoint_rule))
print(paste("Error:", error0))
print(paste("Con n = 1:", result_n1))
print(paste("Error:", error1))
print(paste("Con n = 2:", result_n2))
print(paste("Error:", error2))
print(paste("Con n = 3:", result_n3))
print(paste("Error:", error3))
