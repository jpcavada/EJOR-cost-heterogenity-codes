rm(list=ls())
graphics.off()	
options(digits = 3)	

setwd("~/Dropbox/Paper2018/Instancias")
source("sql_query.R")


con <-sql_connection()


df <- get_baseInstace(con)
#dbDisconnect(con)

sampleInstance100 <-  get_randomSample_instance(con, 100)

baseInst100 <- sampleInstance100

######
######
#Construccion de Escenarios
#Entrega lista de clientes de la semana estudiada.
custList <- aggregate(baseInst100$razonSocial, by=list(baseInst100$razonSocial), FUN = length )

N <- 249
mu <- 28800

p <- data.frame(rep(mu, N))
p05 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.05)))
p10 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.1)))
p20 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.2)))
p25 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.5)))
p15 <- data.frame(sort(rnorm(N, mean = mu, sd = mu*0.15)))
p50 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu*0.50))))
p100 <- data.frame(sort(abs(rnorm(N, mean = mu, sd =mu))))

custData <- cbind(custList[,1], p, p05,p10, p15, p20, p25, p50,p100)
colnames(custData) <- c('razonSocial','p', 'p05', 'p10', 'p15', 'p20', 'p25', 'p50', 'p100')
baseInst100 <-merge(baseInst100,custData, by='razonSocial')

write.csv(baseInst100, file = "baseInst100_2.csv")

mu_multa <- 28800
sd_multa <- mu_multa*0.30

penalty <- rnorm(249, mean=mu_multa, sd=sd_multa)
abs(penalty)
hist(abs(penalty))
df <- cbind(customers, penalty)

range.names = c('razonSocial', 'N', 'penalty')
names(df) = range.names
df <-merge(abril,df, by='razonSocial')



E <- function(mu,sigma){
  aux <- mu+0.5*sima^2
  return(exp(aux))
}

df <- data.frame(penalty)

library(ggplot2)
theme_set(theme_classic())

# Plot
qplot(penalty, geom="histogram") 
ggplot(data=df, aes(df$penalty)) + geom_histogram()

allcust <- aggregate(raw_data$razonSocial, by=list(raw_data$razonSocial), FUN = length)


#Disposición a Esperar 1 Dia por la Atención. ($)
disp <- rexp(N, rate = 1/sqrt(V))*1000
customers <-cbind.data.frame(customers, disp)

write.csv(customers, file = "~/Desktop/cust-expV2.csv")

