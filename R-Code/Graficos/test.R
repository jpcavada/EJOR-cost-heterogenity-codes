

ins_p05 <- read.csv("~/Downloads/Resultados-Paper - Hoja 2.csv")


#test <- aggregate(p05_ins1$Penalty, by=list(p05_ins1$Flex, p05$weekday), FUN = mean)


boxplot(Penalty~Flex, data=ins_p05)
boxplot(ins_p05$T.Servicio~Flex, data=ins_p05)
