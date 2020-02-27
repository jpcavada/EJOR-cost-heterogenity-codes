
Ts <- function(c,p) {

  # c -> Número de servidores
  # utilización: p = lambda / (c * mu)
  
  mu = 4 # Tasa de Servicio: 4 pag/min
  lambda = p * (c * mu)
  
  # cero clientes en el sistema
  i = c(0:(c-1))
  first = sum( (c * p) ^ i / factorial(i) )
  p_0 = 1 / ( first + (c * p) ^ c / ( factorial(c) * (1-p) ) )
  
  # n clientes en el sistema
  p_n = function(p_0, c, p, n){
    if( n <= c){ return( p_0 * ( (c*p)^n / factorial(n)) ) }
    else return( p_0 * ( c^c * p^n) / factorial(c) )
  }
  p_n(p_0, c, p, 6)
  
  # the mean number of customers waiting in queue
  L_q = p_0 * ( ((c^c) * p^(c+1)) / (factorial(c) * (1-p)^2) )
  
  # Mean time customers spend in queue
  W_q = L_q / lambda
  
  # Mean time customers spend in the system
  W = W_q + 1 / mu
  
  return(W)
}

totalPages <-function(c, p) {
  
  mu = 4 # Tasa de Servicio: 4 pag/min
  lambda = p * (c * mu)
  
  return(lambda*60*8)
  
}

Ts_1 <- function(c,p) {
  
  mu = 4 # Tasa de Servicio: 4 pag/min
  lambda = p * (c * mu)
  p = lambda / ((c-1) * mu)
  
  if (p>=1) {
    return("inf")
  } else {
    tsystem <- Ts(c,p)
    return(tsystem)
  }
}

