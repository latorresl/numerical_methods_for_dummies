# COMPOSED SIMPSON RULE
# Calcula el ancho de cada subintervalo
h <- (b - a) / n

# Initialize sum
sum <- f(a) + f(b)
# Calcula la suma de las evaluaciones impares
for (i in seq(1, n-1, by=2)) {
  xi <- a + i*h
  sum <- sum + 4 * f(xi)
}
# Calcula la suma de las evaluaciones pares
for (i in seq(2, n-2, by=2)) {
  xi <- a + i*h
  sum <- sum + 2 * f(xi)
}
result <- (h / 3) * sum
cat("Result:", result, "\n")

# COMPOSED TRAPEZOIDAL RULE
trapezoidal_rule <- function(f, a, b, n) {
  # f: Function to be integrated
  # a, b: Integration limits
  # n: Number of subintervals
  h <- (b - a) / n
  x <- seq(a, b, by = h)
  integral <- 0
  for (i in 2:n) {
    integral <- integral + f(x[i])
  }
  integral <- h * (0.5 * f(a) + integral + 0.5 * f(b))
  return(integral)
}
result <- trapezoidal_rule(f, a, b, n)
print(paste("Result:", result))

# Usage
f <- function(x) x^2*exp(-x^2)
# Define los límites de integración
a <- 0
b <- 2
# Define el número de subintervalos (debe ser un número par)
n <- 8

