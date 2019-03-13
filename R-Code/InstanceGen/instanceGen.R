rm(list=ls())
graphics.off()	
options(digits = 3)	

setwd("~/Gitlab/xerox-paper/R-Code/InstanceGen")


#Script para generar una instancia aleatoria de 100 clientes.
#source("sql_query.R")
#con <-sql_connection()
#df <- get_baseInstace(con)
#dbDisconnect(con)
#sampleInstance100 <-  get_randomSample_instance(con, 100)

#Abir instancia aleatoria generada
baseInst100 <- read.csv("~/Gitlab/xerox-paper/Data/baseInst100.csv")

#Construccion de Escenarios#
######
#Escenario 1.
#Costo por distancia $3.300 / ($55 /min)
#Costo por Atraso: $4.800  / ($80 / min)
######

custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

N <- 249
mu <- 28800

p <- data.frame(rep(mu, N))
p05 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.05)))
p10 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.1)))
p20 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.2)))
p25 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.25)))
p15 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.15)))
p50 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu*0.50))))
p100 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu))))

custData <- cbind(custList[,1], p, p05,p10, p15, p20, p25, p50,p100)
colnames(custData) <- c('razonSocial','p', 'p05', 'p10', 'p15', 'p20', 'p25', 'p50', 'p100')
baseInst100 <-merge(baseInst100,custData, by='razonSocial')

write.csv(baseInst100, file = "baseInst100_2.csv")

######
#Escenario 2.
#Costo por distancia $3.300 / ($50 /min)
#Costo por Atraso: $4.800  / ($60 / min)
#Penalty Promedio: 21.600 (Corriendo JP)
######

custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

N <- 249
mu <- 21600

p <- data.frame(rep(mu, N))
p05 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.05)))
p10 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.1)))
p20 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.2)))
p25 <- data.frame(sort(abs(rnorm(N, mean = mu, sd = mu*0.25))))
p15 <- data.frame(sort(abs(rnorm(N, mean = mu, sd = mu*0.15))))
p50 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu*0.50))))
p100 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu))))

custData <- cbind(custList[,1], p, p05,p10, p15, p20, p25, p50,p100)
colnames(custData) <- c('razonSocial','p', 'p05', 'p10', 'p15', 'p20', 'p25', 'p50', 'p100')

ins2 <-merge(baseInst100,custData, by='razonSocial')
write.csv(ins2, file="~/Gitlab/xerox-Paper/Data/ins2.csv")

######
#Escenario 3.
#Costo por distancia $3.300 / ($50 /min)
#Costo por Atraso: $4.800  / ($50 / min)
#Penalty Promedio:  32.400 
######

custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

N <- 249
mu <- 32400

p <- data.frame(rep(mu, N))
p05 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.05)))
p10 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.1)))
p20 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.2)))
p25 <- data.frame(sort(abs(rnorm(N, mean = mu, sd = mu*0.25))))
p15 <- data.frame(sort(abs(rnorm(N, mean = mu, sd = mu*0.15))))
p50 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu*0.50))))
p100 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu))))

custData <- cbind(custList[,1], p, p05,p10, p15, p20, p25, p50,p100)
colnames(custData) <- c('razonSocial','p', 'p05', 'p10', 'p15', 'p20', 'p25', 'p50', 'p100')

ins3 <-merge(baseInst100,custData, by='razonSocial')
write.csv(ins3, file="~/Gitlab/xerox-Paper/Data/ins3.csv")

######
#Escenario 4.
#Costo por distancia $3.300 / ($50 /min)
#Costo por Atraso: $4.800  / ($50 / min)
#Penalty Promedio:  10.800 
######

N <- 249
mu <- 10800

p <- data.frame(rep(mu, N))
p05 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.05)))
p10 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.1)))
p20 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.2)))
p25 <- data.frame(sort(abs(rnorm(N, mean = mu, sd = mu*0.25))))
p15 <- data.frame(sort(abs(rnorm(N, mean = mu, sd = mu*0.15))))
p50 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu*0.50))))
p100 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu))))

custData <- cbind(custList[,1], p, p05,p10, p15, p20, p25, p50,p100)
colnames(custData) <- c('razonSocial','p', 'p05', 'p10', 'p15', 'p20', 'p25', 'p50', 'p100')

ins4 <-merge(baseInst100,custData, by='razonSocial')
write.csv(ins4, file="~/Gitlab/xerox-Paper/Data/ins4.csv")


######
#Escenario 5.
#Costo por distancia $3.300 / ($50 /min)
#Costo por Atraso: $4.800  / ($50 / min)
#Impresoras Promedio: 20, rho: Uniforme 
######

source("~/Gitlab/xerox-paper/R-Code/Markov/markov-functions.R")
baseInst100 <- read.csv("~/Gitlab/xerox-paper/Data/baseInst100.csv")
custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

N <- 249

c <- rpois(N, lambda=20)
p <- runif(N, min = 0, max = 1)


d <-c()
pgs <- c()

for (i in 1:N) {
  
  pgs <- append(pgs,totalPages(c[i],p[i]))
  
  if (Ts_1(c[i],p[i])!="inf") {
    
    foo <- abs(Ts(c[i],p[i])-Ts_1(c[i],p[i]))
    d <- append(d,foo)
    
  } else {
    d <- append(d,"inf")
  }
}
rm(foo)
rm(i)

d <- data.frame(d)
pgs <-data.frame(pgs)

custData <- cbind(custList[,1], d, pgs)
colnames(custData) <- c('razonSocial','damage', 'pages')

ins5 <-merge(baseInst100,custData, by='razonSocial')
write.csv(ins5, file="~/Gitlab/xerox-Paper/Data/ins4.csv")
