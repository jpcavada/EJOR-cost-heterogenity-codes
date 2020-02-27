
sql_connection <- function() {
  
  library("DBI")
  library("RMySQL")
  
  con <-dbConnect(RMySQL::MySQL(),
                  dbname = "xeroxdb",
                  host = "localhost",
                  port = 3306,
                  user = "root",
                  password = "Colonus1502")
  
  
  return(con)
  
}

#data <- dbReadTable(con, "raw_data")
#dbWriteTable(con, value = data, name = "raw_data", append = TRUE, row.names=FALSE )

#Instancia Base (Todos los clientes de la semana 15)
get_baseInstace <- function(con){
  
  query <- "select nomComuna, idCom as place, direccion, razonSocial, dayofCall, weekofCall, monthofCall, weekday, (serviceTime*60) as serviceTime from raw_data where monthofCall = 4 and weekofCall=15 and (nomComuna = 'Vitacura' or nomComuna = 'Las Condes' or nomComuna='Santiago' or idCom=20 or nomComuna = 'Providencia') and serviceTime != 0 order by weekday asc limit 2000"
  dbGetQuery(con, query)
  
  return(dbGetQuery(con, query))
}


get_randomSample_instance <- function(con, n){
  
  q1 <-paste("select nomComuna, idCom as place, direccion, razonSocial, dayofCall, weekofCall, monthofCall, weekday, (serviceTime*60) as serviceTime from raw_data where monthofCall = 4 and weekofCall=15 and dayofCall=7 and (nomComuna = 'Vitacura' or nomComuna = 'Las Condes' or nomComuna='Santiago' or idCom=20 or nomComuna = 'Providencia') and serviceTime != 0 order by rand()", "limit", toString(n), sep = " ")
  d1Samp <- dbGetQuery(con, q1)
  
  q2 <-paste("select nomComuna, idCom as place, direccion, razonSocial, dayofCall, weekofCall, monthofCall, weekday, (serviceTime*60) as serviceTime from raw_data where monthofCall = 4 and weekofCall=15 and dayofCall=8 and (nomComuna = 'Vitacura' or nomComuna = 'Las Condes' or nomComuna='Santiago' or idCom=20 or nomComuna = 'Providencia') and serviceTime != 0 order by rand()", "limit", toString(n-10), sep=" ")
  d2Samp <- dbGetQuery(con, q2)
  
  q3 <-paste("select nomComuna, idCom as place, direccion, razonSocial, dayofCall, weekofCall, monthofCall, weekday, (serviceTime*60) as serviceTime from raw_data where monthofCall = 4 and weekofCall=15 and dayofCall=9 and (nomComuna = 'Vitacura' or nomComuna = 'Las Condes' or nomComuna='Santiago' or idCom=20 or nomComuna = 'Providencia') and serviceTime != 0 order by rand()", "limit",  toString(n-20), sep=" ")
  d3Samp <- dbGetQuery(con, q3)
  
  q4 <-paste("select nomComuna, idCom as place, direccion, razonSocial, dayofCall, weekofCall, monthofCall, weekday, (serviceTime*60) as serviceTime from raw_data where monthofCall = 4 and weekofCall=15 and dayofCall=10 and (nomComuna = 'Vitacura' or nomComuna = 'Las Condes' or nomComuna='Santiago' or idCom=20 or nomComuna = 'Providencia') and serviceTime != 0 order by rand()",  "limit",  toString(n-30), sep = " ")
  d4Samp <- dbGetQuery(con, q4)
  
  q5 <-paste("select nomComuna, idCom as place, direccion, razonSocial, dayofCall, weekofCall, monthofCall, weekday, (serviceTime*60) as serviceTime from raw_data where monthofCall = 4 and weekofCall=15 and dayofCall=11 and (nomComuna = 'Vitacura' or nomComuna = 'Las Condes' or nomComuna='Santiago' or idCom=20 or nomComuna = 'Providencia') and serviceTime != 0 order by rand()",  "limit",  toString(n-40), sep = " ")
  d5Samp <- dbGetQuery(con, q5)
  
  return(rbind(d1Samp, d2Samp, d3Samp, d4Samp, d5Samp))
  
  
  
}

#Lista de clientes de la semana estudiada.
get_cust_list <- function(){
  
  q<- "select razonSocial, count(razonSocial) from raw_data 
      where monthofCall = 4 and weekofCall=15 
      and (nomComuna = 'Vitacura' or nomComuna = 'Las Condes' or nomComuna='Santiago' or idCom=20 or nomComuna = 'Providencia') 
      and serviceTime != 0 
      group by razonSocial
      limit 2000"
  
  custList <- dbGetQuery(con, q)
  
  return(custList)
  
}



