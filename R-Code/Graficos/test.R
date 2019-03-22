

graph1<- read.csv("~/Gitlab/xerox-paper/Data/graph-data/graph1.csv")

std <-c(0.5,10,15,20,25,50,100)
plot(x,graph1$ins2, type='l')

boxplot(ins_p05$T.Servicio~Flex, data=ins_p05)
