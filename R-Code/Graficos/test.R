rm(list=ls())
graphics.off()	
options(digits = 3)	

setwd("~/Gitlab/xerox-paper/Data")
#data <- read.csv("~/Gitlab/xerox-paper/Data/data.csv")

library("DBI")
library("RMySQL")

#Llamadas Mensuales Sector Oriente, Sector Sur.

con <-dbConnect(RMySQL::MySQL(),
                dbname = "xeroxdb",
                host = "127.0.0.1",
                port = 3306,
                user = "root",
                password = "Colonus1502")

query <- "select nomComuna, idCom as place, direccion, razonSocial, dayofCall, weekofCall, monthofCall,yearofCall, weekday, (serviceTime*60) as serviceTime from raw_data where (nomComuna = 'Vitacura' or nomComuna = 'Las Condes' or nomComuna='Santiago' or idCom=20 or nomComuna = 'Providencia') and serviceTime != 0 limit 150000"
oriente <- dbGetQuery(con, query)

calls <- aggregate(oriente$razonSocial, by=list(oriente$nomComuna, oriente$razonSocial, oriente$dayofCall, oriente$monthofCall, oriente$yearofCall), FUN = length )
colnames(calls) <-c('comuna', 'razonSocial','dia', 'mes','ano','llamados')
calls_perday <- aggregate(calls$llamados, by=list(calls$dia, calls$mes, calls$ano), FUN=length)

write.csv(calls_perday, file='graph3_3.csv')

query <- "select nomComuna, idCom as place, direccion, razonSocial, dayofCall, weekofCall, monthofCall, yearofCall, weekday, (serviceTime*60) as serviceTime from raw_data 
where (nomComuna = 'Maipu' or 
nomComuna = 'Lo Espejo' or 
nomComuna='Cerrillos' or 
nomComuna = 'Peñalolen' or
nomComuna = 'La Cisterna' or
nomComuna = 'San Ramon' or 
nomComuna = 'La Granja' or
nomComuna = 'La Florida' or
nomComuna = 'El Bosque' or
nomComuna = 'La Pintana' or
nomComuna = 'Puente Alto'  or
nomComuna = 'Pirque' or
nomComuna = 'Peñaflor' or
nomComuna = 'El Monte' or
nomComuna = 'Talagante' or
nomComuna = 'Isla de Maipo' or
nomComuna = 'Calera de Tango'  or
nomComuna = 'San Bernardo' or
nomComuna = 'Paine') and serviceTime != 0 limit 150000"

sur <- dbGetQuery(con, query)

calls <- aggregate(sur$razonSocial, by=list(sur$nomComuna, sur$razonSocial, sur$dayofCall, sur$monthofCall, sur$yearofCall), FUN = length )
colnames(calls) <-c('comuna', 'razonSocial','dia', 'mes','ano','llamados')
calls_perday <- aggregate(calls$llamados, by=list(calls$dia, calls$mes, calls$ano), FUN=length)

write.csv(calls_perday, file='graph3_4.csv')

#Abir instancia aleatoria generada
baseInst100 <- read.csv("~/Gitlab/xerox-paper/Data/baseInst100.csv")

rq <-aggregate(baseInst100$serviceTime, by=list(baseInst100$nomComuna, baseInst100$weekday), FUN = mean)
colnames(rq) <- c('razonSocial', 'comuna', 'weekday', 'llamado')

rq_ <- aggregate(rq$llamado, by=list(rq$comuna, rq$weekday), FUN=sum)
write.csv(rq, file = 'instance_desc_1.csv')

#oriente Service time Histogram

hist(oriente$serviceTime, col='#6495ed', border = 'white', xlab='Service Time (min)', main =" ")


boxplot(ins2_v2_boxblot$Penalty~ins2_v2_boxblot$Satisfied+ins2_v2_boxblot$Penalty)

