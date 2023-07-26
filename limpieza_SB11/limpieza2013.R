## instalar librerias
require(magrittr)
require(readr)
require(tidyverse)
require(dplyr)
library(Amelia)
library(janitor)

outputDir <- "D:/seminario/SB11/limpia/SB11_2013.csv"

## importar data
periodo1 <- read_delim("D:/seminario/SB11/SB11_20131.TXT", 
                       delim = "¬", escape_double = FALSE, 
                       trim_ws = TRUE)
periodo2 <- read_delim("D:/seminario/SB11/SB11_20132.TXT", 
                       delim = "¬", escape_double = FALSE, 
                       trim_ws = TRUE)

## copiar los datos a una nueva variable
data_periodo1 <- periodo1
data_periodo2 <- periodo2


# eliminar las columnas inecesarias del periodo 1
names(data_periodo1)
mantener_columnas_p1 <- c(3,4,6,8,9,11,16,17,20,25,26,131:135)
data_limpiap1 <- data_periodo1[mantener_columnas_p1]
names(data_limpiap1)

# eliminar las columnas inecesarias del periodo 2
names(data_periodo2)
mantener_columnas_p2 <- c(3,4,6,8,9,11,16,17,20,25,26,131:135)
data_limpiap2 <- data_periodo2[mantener_columnas_p2]
names(data_limpiap2)

## cambiar nombre a las variables para que coincidan con años superiores
dataUnida <- merge(data_limpiap1, data_limpiap2, all = T)
names(dataUnida)

## cambiar nombre a las variables para que coincidan con años superiores
names(dataUnida)
names(dataUnida)[12] = "punt_sociales_ciudadanas"
names(dataUnida)[13] = "punt_ingles"
names(dataUnida)[14] = "punt_lectura_critica"
names(dataUnida)[15] = "punt_matematicas"
names(dataUnida)[16] = "punt_c_naturales"

## calcular puntaje global
dataUnida$punt_global <- round((dataUnida$punt_c_naturales+dataUnida$punt_sociales_ciudadanas+dataUnida$punt_ingles+dataUnida$punt_lectura_critica+dataUnida$punt_matematicas)/5)

## normalizar nombres
dataUnida %<>%  clean_names()
names(dataUnida)

## separar la fecha de nacimiento
dataUnida$nacimeinto <- substr(dataUnida$estu_fechanacimiento, 7, 10)
dataUnida$estu_fechanacimiento <- NULL
dataUnida$nacimeinto %>% class()

## validar datos nulos
missmap(dataUnida)

## de ser necesario convertir nulos a 0
dataUnida[is.na(dataUnida)] <- 0

## obtener estadisticas 
md<-mean(dataUnida$punt_sociales_ciudadanas)
sd<-sd(dataUnida$punt_sociales_ciudadanas)
dataUnida$pn_sociales<-round(pnorm(dataUnida$punt_sociales_ciudadanas, md, sd)*100)

md<-mean(dataUnida$punt_ingles)
sd<-sd(dataUnida$punt_ingles)
dataUnida$pn_ingles<-round(pnorm(dataUnida$punt_ingles, md, sd)*100) 

md<-mean(dataUnida$punt_c_naturales)
sd<-sd(dataUnida$punt_c_naturales)
dataUnida$pn_naturales<-round(pnorm(dataUnida$punt_c_naturales, md, sd)*100) 

md<-mean(dataUnida$punt_matematicas)
sd<-sd(dataUnida$punt_matematicas)
dataUnida$pn_matematicas<-round(pnorm(dataUnida$punt_matematicas, md, sd)*100) 

md<-mean(dataUnida$punt_lectura_critica)
sd<-sd(dataUnida$punt_lectura_critica)
dataUnida$pn_lectura<-round(pnorm(dataUnida$punt_lectura_critica, md, sd)*100) 

md<-mean(dataUnida$punt_global)
sd<-sd(dataUnida$punt_global)
dataUnida$pn_global<-round(pnorm(dataUnida$punt_global, md, sd)*100) 


## convertir txt a factor
dataUnida %<>% mutate_if(is.character, as.factor) 
str(dataUnida)

## añadir prefijo para no confundir con data de SP
dataUnida <- dataUnida %>%
  rename_with(~paste0("sb11_", .), everything())
names(dataUnida)

## guardar a CSV 
write.csv(dataUnida, outputDir)


