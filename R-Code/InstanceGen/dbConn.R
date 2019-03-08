#Db Conection
#https://www.youtube.com/watch?v=9OSB9pmlJpI

rm(list=ls())
graphics.off()	
options(digits = 3)	

library("RMySQL")
library("DBI")

con <-dbConnect(RMySQL::MySQL(),
                dbname = "xeroxdb",
                host = "127.0.0.1",
                port = 3306,
                user = "root",
                password = "Colonus1502")


con2 <-dbConnect(RMySQL::MySQL(),
                dbname = "xeroxdb",
                host = "192.168.0.13",
                port = 3306,
                user = "root",
                password = "Colonus1502")

raw_data <- dbReadTable(con, "raw_data")

data <- dbReadTable(con2, "raw_data")

#
dbListTables(con2)
dbWriteTable(con2, name="raw_data", raw_data[1:23], overwrite=TRUE, row.names=FALSE)


#Para desconectarse de la BD.
dbDisconnect(con2)
