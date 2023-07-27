## instalar librerias
require(magrittr)
require(readr)
require(tidyverse)
require(dplyr)
library(Amelia)
library(janitor)

outputDir <- "D:/seminario/SB11/limpia/SB11_2015.csv"

## importar data
periodo1 <- read_delim("D:/seminario/SB11/SB11_20151.TXT", 
                       delim = "¬", escape_double = FALSE, 
                       trim_ws = TRUE)
periodo2 <- read_delim("D:/seminario/SB11/SB11_20152.TXT", 
                       delim = "¬", escape_double = FALSE, 
                       trim_ws = TRUE)

## copiar los datos a una nueva variable
data_periodo1 <- periodo1
periodo1 <- NULL
data_periodo2 <- periodo2
periodo2 <- NULL


# eliminar las columnas inecesarias del periodo 1
names(data_periodo1)
mantener_columnas_p1 <- c(3,4,6,8,16,18,23,24,28,33,34,111,113,115,117,123,126)
data_limpiap1 <- data_periodo1[mantener_columnas_p1]
names(data_limpiap1)

# eliminar las columnas inecesarias del periodo 2
names(data_periodo2)
mantener_columnas_p2 <- c(3,4,6,8,17,19,24,25,29,34,35,69,71,73,75,81,84)
data_limpiap2 <- data_periodo2[mantener_columnas_p2]
names(data_limpiap2)

## cambiar nombre a las variables para que coincidan con el otro periodo
names(data_limpiap1)
names(data_limpiap1)[15] = "punt_sociales_ciudadanas"
names(data_limpiap1)[16] = "punt_ingles"
names(data_limpiap1)[12] = "punt_lectura_critica"
names(data_limpiap1)[13] = "punt_matematicas"
names(data_limpiap1)[14] = "punt_c_naturales"

names(data_limpiap2)
names(data_limpiap2)[15] = "punt_sociales_ciudadanas"
names(data_limpiap2)[16] = "punt_ingles"
names(data_limpiap2)[12] = "punt_lectura_critica"
names(data_limpiap2)[13] = "punt_matematicas"
names(data_limpiap2)[14] = "punt_c_naturales"

## cambiar nombre a las variables para que coincidan con años superiores
dataUnida <- merge(data_limpiap1, data_limpiap2, all = T)
names(dataUnida)

## normalizar nombres
dataUnida %<>%  clean_names()
names(dataUnida)

## calcular puntaje global
dataUnida$punt_global <- round((dataUnida$punt_c_naturales+dataUnida$punt_sociales_ciudadanas+dataUnida$punt_ingles+dataUnida$punt_lectura_critica+dataUnida$punt_matematicas)/5)


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


