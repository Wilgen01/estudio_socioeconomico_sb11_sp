## instalar librerias
require(magrittr)
require(readr)
require(tidyverse)
require(dplyr)
library(Amelia)
library(janitor)

outputDir <- "D:/seminario/SB11/limpia/SB11_2012.csv"

## importar data
periodo1 <- read_delim("D:/seminario/SB11/SB11_20121.TXT", 
                       delim = "¬", escape_double = FALSE, 
                       trim_ws = TRUE)
periodo2 <- read_delim("D:/seminario/SB11/SB11_20122.TXT", 
                       delim = "¬", escape_double = FALSE, 
                       trim_ws = TRUE)

## copiar los datos a una nueva variable
data_periodo1 <- periodo1
data_periodo2 <- periodo2

# eliminar las columnas inecesarias del periodo 1
names(data_periodo1)
mantener_columnas_p1 <- c(3,4,6,8,9,11,19,20,23,28,30,115:119)
data_limpiap1 <- data_periodo1[mantener_columnas_p1]
names(data_limpiap1)

# eliminar las columnas inecesarias del periodo 2
names(data_periodo2)
mantener_columnas_p2 <- c(3,4,6,8,9,11,19,20,23,28,30,116:120)
data_limpiap2 <- data_periodo2[mantener_columnas_p2]
names(data_limpiap2)

## cambiar nombre a las variables para que coincidan con años superiores
dataUnida2012 <- merge(data_limpiap1, data_limpiap2, all = T)
names(dataUnida2012)

## cambiar nombre a las variables para que coincidan con años superiores
names(dataUnida2012)
names(dataUnida2012)[12] = "punt_sociales_ciudadanas"
names(dataUnida2012)[13] = "punt_ingles"
names(dataUnida2012)[14] = "punt_lectura_critica"
names(dataUnida2012)[15] = "punt_matematicas"
names(dataUnida2012)[16] = "punt_c_naturales"

## calcular puntaje global
dataUnida2012$punt_global <- round((dataUnida2012$punt_c_naturales+dataUnida2012$punt_sociales_ciudadanas+dataUnida2012$punt_ingles+dataUnida2012$punt_lectura_critica+dataUnida2012$punt_matematicas)/5)

## normalizar nombres
dataUnida2012 %<>%  clean_names()
names(dataUnida2012)

## separar la fecha de nacimiento
dataUnida2012$nacimeinto <- substr(dataUnida2012$estu_fechanacimiento, 7, 10)
dataUnida2012$estu_fechanacimiento <- NULL
dataUnida2012$nacimeinto %>% class()

## validar datos nulos
missmap(dataUnida2012)

## de ser necesario convertir nulos a 0
dataUnida2012[is.na(dataUnida2012)] <- 0

## obtener estadisticas 
md<-mean(dataUnida2012$punt_sociales_ciudadanas)
sd<-sd(dataUnida2012$punt_sociales_ciudadanas)
dataUnida2012$pn_sociales<-round(pnorm(dataUnida2012$punt_sociales_ciudadanas, md, sd)*100)

md<-mean(dataUnida2012$punt_ingles)
sd<-sd(dataUnida2012$punt_ingles)
dataUnida2012$pn_ingles<-round(pnorm(dataUnida2012$punt_ingles, md, sd)*100) 

md<-mean(dataUnida2012$punt_c_naturales)
sd<-sd(dataUnida2012$punt_c_naturales)
dataUnida2012$pn_naturales<-round(pnorm(dataUnida2012$punt_c_naturales, md, sd)*100) 

md<-mean(dataUnida2012$punt_matematicas)
sd<-sd(dataUnida2012$punt_matematicas)
dataUnida2012$pn_matematicas<-round(pnorm(dataUnida2012$punt_matematicas, md, sd)*100) 

md<-mean(dataUnida2012$punt_lectura_critica)
sd<-sd(dataUnida2012$punt_lectura_critica)
dataUnida2012$pn_lectura<-round(pnorm(dataUnida2012$punt_lectura_critica, md, sd)*100) 

md<-mean(dataUnida2012$punt_global)
sd<-sd(dataUnida2012$punt_global)
dataUnida2012$pn_global<-round(pnorm(dataUnida2012$punt_global, md, sd)*100) 


## convertir txt a factor
dataUnida2012 %<>% mutate_if(is.character, as.factor) 
str(dataUnida2012)

## añadir prefijo para no confundir con data de SP
dataUnida2012 <- dataUnida2012 %>%
  rename_with(~paste0("sb11_", .), everything())
names(dataUnida2012)

## guardar a CSV 
write.csv(dataUnida2012, outputDir)


