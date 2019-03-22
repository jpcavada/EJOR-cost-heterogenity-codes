rm(list=ls())
graphics.off()	
options(digits = 3)	

setwd("~/Gitlab/xerox-paper/Data/final")

######
#Escenario Final: media
#Costo por distancia $3.300 / ($50 /min)
#Costo por Atraso: $4.800  / ($60 / min)
#Penalty Promedio: mu = log(21.600)
######

#Abir instancia aleatoria generada
baseInst100 <- read.csv("~/Gitlab/xerox-paper/Data/baseInst100.csv")

custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

N <- 249
mu <- log(21600)

p10 <- data.frame(exp(sort(rnorm(N, mean = mu, sd = 0.10))))
p15 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd = 0.15)))))
p20 <- data.frame(exp(sort(rnorm(N, mean = mu, sd = 0.20))))
p25 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd = 0.25)))))
p30 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd =0.30)))))
p35 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd =0.35)))))
p40 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd =0.4)))))

custData <- cbind(custList[,1], p10, p15, p20, p25, p30,p35,p40)
colnames(custData) <- c('razonSocial', 'p10', 'p15', 'p20', 'p25', 'p30', 'p35', 'p40')

final_medio <-merge(baseInst100,custData, by='razonSocial')
write.csv(final_medio, file="~/Gitlab/xerox-Paper/Data/medio.csv")

######
#Escenario Final: alto.
#Costo por distancia $3.300 / ($50 /min)
#Costo por Atraso: $4.800  / ($60 / min)
#Penalty Promedio: mu = log(32.400)
######

#Abir instancia aleatoria generada
baseInst100 <- read.csv("~/Gitlab/xerox-paper/Data/baseInst100.csv")

custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

N <- 249
mu <- log(32400)

p10 <- exp(sort(rnorm(N, mean = mu, sd = 0.10)))
p15 <- exp(sort(abs(rnorm(N, mean = mu, sd = 0.15))))
p20 <- exp(sort(rnorm(N, mean = mu, sd = 0.20)))
p25 <- exp(sort(abs(rnorm(N, mean = mu, sd = 0.25))))
p30 <- exp(sort(abs(rnorm(N, mean = mu, sd =0.30))))
p35 <- exp(sort(abs(rnorm(N, mean = mu, sd =0.35))))
p40 <- exp(sort(abs(rnorm(N, mean = mu, sd =0.4))))

custData <- cbind(custList[,1], p05,p10, p15, p20, p25, p50,p100)
colnames(custData) <- c('razonSocial', 'p05', 'p10', 'p15', 'p20', 'p25', 'p50', 'p100')

ins_alta <-merge(baseInst100,custData, by='razonSocial')
write.csv(ins2, file="~/Gitlab/xerox-Paper/Data/ins2.csv")
