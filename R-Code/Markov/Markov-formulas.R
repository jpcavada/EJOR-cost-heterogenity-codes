
c = 2 # Número de servidores
lambda = 6.43 # Tasa de llegada
mu = 4 # Tasa de Servicio

# utilización
p = lambda / (c * mu)

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

# Mean number of customers in system
L = L_q + lambda / mu

