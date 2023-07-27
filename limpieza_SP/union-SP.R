## instalar librerias
require(magrittr)
require(readr)
require(tidyverse)
require(dplyr)
library(Amelia)
library(janitor)

## preparando directorios
outputDir <- "D:/seminario/SP/limpia/SP_unida.csv"
data2017 <- "D:/seminario/SP/limpia/SP_2017.csv"
data2018 <- "D:/seminario/SP/limpia/SP_2018.csv"
data2019 <- "D:/seminario/SP/limpia/SP_2019.csv"




## importar data
df17 <- read_delim(data2017, 
                   delim = ",", escape_double = FALSE, 
                   trim_ws = TRUE)

df18 <- read_delim(data2018, 
                   delim = ",", escape_double = FALSE, 
                   trim_ws = TRUE)

df19 <- read_delim(data2019, 
                   delim = ",", escape_double = FALSE, 
                   trim_ws = TRUE)

## limpiar indice y validar que tengan las mismas columnas
df17$...1 <- NULL
df18$...1 <- NULL
df19$...1 <- NULL

dataUnida <- rbind(df17, df18, df19)
names(dataUnida)


## guardar data
write.csv(dataUnida, outputDir)
