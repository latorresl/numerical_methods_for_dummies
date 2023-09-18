bisection = function(f, xa, xb, tol){
  if( sign(f(xa)) == sign(f(xb)) ){stop("f(xa) & f(xb) have the same sign")}
  # a = min(xa,xb)
  # b = max(xa,xb)
  a = xa; b = xb
  k = 0
  # print table
  table = data.frame(k="","a"=a,"b"=b,"m"=a+0.5*(b-a),
                     "estimatedError"=(b-a)/2)
  repeat{
    m = a + 0.5*(b-a)
    if(f(m)==0){cat("Zero of f in [",xa,",",xb,"] is:", m)}
    if(sign(f(a)) != sign(f(m))){
      b = m
    }
    else { a = m}
    dx = (b-a)/2
    # each iteration is a new row in the table
    table = rbind(table,data.frame(k="","a"=a,"b"=b,"m"=m,
                                   "estimatedError"=dx)
                  )
    k = k+1
    # until
    if(dx < tol){
      cat("Zero of f in [",xa,",",xb,"] is approx:",m,"with an error of <=",dx,"\n")
      cat("-------------------------------------------------\n\n")
      break;
    }
  } #repeat
  # print table
  colnames(table)=c("k","a","b","m","(b-a)/2^k")
  print(table,right=F)# aling to the left
}

f = function(x) ... # write the f function
bisection(f,a,b,1e-4) # set tolerance value as a negative n-th power of 10
