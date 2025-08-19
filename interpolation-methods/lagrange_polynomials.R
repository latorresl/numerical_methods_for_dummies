lagrange_interpolation <- function(x_values, y_values, x) {
  n <- length(x_values)
  lagrange_polynomial <- 0
  
  for (i in 1:n) {
    term <- y_values[i]
    for (j in 1:n) {
      if (i != j) {
        term <- term * (x - x_values[j]) / (x_values[i] - x_values[j])
      }
    }
    lagrange_polynomial <- lagrange_polynomial + term
  }
  
  return(lagrange_polynomial)
}

print_lagrange_polynomial <- function(x_values, y_values) {
  n <- length(x_values)
  lagrange_polynomial <- ""
  
  for (i in 1:n) {
    term <- paste(y_values[i])
    for (j in 1:n) {
      if (i != j) {
        term <- paste(term, "*", "(x -", x_values[j], ")/(", x_values[i], "-", x_values[j], ")", sep = "")
      }
    }
    lagrange_polynomial <- paste(lagrange_polynomial, "+", term, sep = "")
  }
  
  lagrange_polynomial <- substring(lagrange_polynomial, 2)
  cat("Interpolation polynomial is:", lagrange_polynomial, "\n")
}

# Usage
x_values <- c(0.6, 0.7)
y_values <- c(-0.17694460, 0.01375227)
x_interpolate <- 0.9

result <- lagrange_interpolation(x_values, y_values, x_interpolate)
print_lagrange_polynomial(x_values, y_values)
cat("Interpolated value in x =", x_interpolate, "is:", result, "\n")