rm(list=ls())
graphics.off()	
options(digits = 3)	

setwd("~/Gitlab/xerox-paper/Data")


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
#Penalty Promedio: 21.600
######

custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

N <- 249
mu <- 21600

p <- data.frame(rep(mu, N))
p05 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.05)))
p10 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.1)))
p20 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.15)))
p25 <- data.frame(sort(abs(rnorm(N, mean = mu, sd = mu*0.2))))
p15 <- data.frame(sort(abs(rnorm(N, mean = mu, sd = mu*0.25))))
p50 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu*0.5))))
p100 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu))))

custData <- cbind(custList[,1], p, p05,p10, p15, p20, p25, p50,p100)
colnames(custData) <- c('razonSocial','p', 'p05', 'p10', 'p15', 'p20', 'p25', 'p50', 'p100')

ins2_2 <-merge(baseInst100,custData, by='razonSocial')
write.csv(ins2_2, file="ins2_2.csv")

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

ins3_2<-merge(baseInst100,custData, by='razonSocial')
write.csv(ins3_2, file="ins3_2.csv")

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
#Costo por Atraso: $4.800  / ($60 / min)
#Penalty Promedio: 21.600 (Mismo que ins2-pero tservice ordenado)
######

baseInst100 <- read.csv("~/Gitlab/xerox-paper/Data/baseInst100.csv")
custList <- aggregate(baseInst100$serviceTime, by=list(baseInst100$razonSocial), FUN = mean)

tservice <- sort(custList$x)

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

custData <- cbind(custList[,1], tservice, p05,p10, p15, p20, p25, p50,p100)
colnames(custData) <- c('razonSocial','serviceTime', 'p05', 'p10', 'p15', 'p20', 'p25', 'p50', 'p100')

ins5 <-merge(baseInst100,custData, by='razonSocial')
write.csv(ins5, file="~/Gitlab/xerox-Paper/Data/ins5.csv")


######
#Escenario 7.
#Costo por distancia $3.300 / ($50 /min)
#Costo por Atraso: $4.800  / ($60 / min)
#Penalty Promedio: 10.800 (Mismo que ins4-pero tservice ordenado)
######

baseInst100 <- read.csv("~/Gitlab/xerox-paper/Data/baseInst100.csv")
custList <- aggregate(baseInst100$serviceTime, by=list(baseInst100$razonSocial), FUN = mean)

tservice <- sort(custList$x)

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

custData <- cbind(custList[,1], tservice, p05,p10, p15, p20, p25, p50,p100)
colnames(custData) <- c('razonSocial','serviceTime', 'p05', 'p10', 'p15', 'p20', 'p25', 'p50', 'p100')

ins7 <-merge(baseInst100,custData, by='razonSocial')
write.csv(ins7, file="ins7.csv")




######
#Escenario Markov 1.
#Costo por distancia $3.300 / ($50 /min)
#Costo por Atraso: $4.800  / ($50 / min)
#Impresoras Promedio: 20, rho: Uniforme 
######

source("~/Gitlab/xerox-paper/R-Code/Markov/markov-functions.R")
baseInst100 <- read.csv("~/Gitlab/xerox-paper/Data/baseInst100.csv")
custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

N <- 249

#c <- floor(runif(N, min=1, max =5))
#p <- runif(N, min = 0.25, max=0.75)

d <-c()
for (i in 1:N) {
  
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

custData <- cbind(custList[,1],c , p, d)
colnames(custData) <- c('razonSocial','c','p','damage')

insMarkov_1 <-merge(baseInst100,custData, by='razonSocial')
write.csv(insMarkov_1, file="~/Gitlab/xerox-Paper/Data/insMarkov_1.csv")

#Graficas de Markov (4-5-6-7):
p <- c(0.1,0.15,0.20,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85)
d <- c()
for (i in 1:16) {
  
  if (Ts_1(10,p[i])!="inf") {
    
    foo <- abs(Ts(10,p[i])-Ts_1(10,p[i]))
    d <- append(d,foo)
    
  } else {
    d <- append(d,"inf")
  }
}

ws <-c()
for (i in 1:16) {
  
  if (Ts(10,p[i])!="inf") {
    
    foo <- Ts(10,p[i])
    ws <- append(ws,foo)
    
  } else {
    ws <- append(ws,"inf")
  }
}

rm(foo)
rm(i)

d <- data.frame(d)
ws <- data.frame(ws)
p <- data.frame(p)
markov4 <-cbind(p,ws,d)

write.csv(markov4, file='markov-graph4.csv')
