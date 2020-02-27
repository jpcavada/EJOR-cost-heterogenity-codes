rm(list=ls())
graphics.off()	
options(digits = 3)	

setwd("C:/Users/juanignacio.zambrano/Desktop/xerox-paper")
library(xlsx)

######
#Escenario Final: media
#Costo por distancia $3.300 / ($50 /min)
#Costo por Atraso: $4.800  / ($60 / min)
#Penalty Promedio: mu = log(21.600)
######

baseInst100 <- baseInst100[,-10]
custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

set.seed(1)

N <- 249
mu <- log(21600)*0.7

p10 <- data.frame(exp(sort(rnorm(N, mean = mu, sd = 0.10))))
p15 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd = 0.15)))))
p20 <- data.frame(exp(sort(rnorm(N, mean = mu, sd = 0.20))))
p25 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd = 0.25)))))
p30 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd =0.30)))))
p35 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd =0.35)))))
p40 <- data.frame(exp(sort(abs(rnorm(N, mean = mu, sd =0.4)))))


custData <- cbind(custList[,1], p10, p15, p20, p25, p30,p35,p40)
colnames(custData) <- c('razonSocial', 'p10', 'p15', 'p20', 'p25', 'p30', 'p35', 'p40')

base<-merge(baseInst100,custData, by='razonSocial')
write.xlsx(base, file='base2.xlsx')
