## instalar librerias
require(magrittr)
require(readr)
require(tidyverse)
require(dplyr)
library(Amelia)
library(janitor)

outputDir <- "D:/seminario/SB11/limpia/SB11_unida.csv"
## preparando directorios
data2012 <- "D:/seminario/SB11/limpia/SB11_2012.csv"
data2013 <- "D:/seminario/SB11/limpia/SB11_2013.csv"
data2014 <- "D:/seminario/SB11/limpia/SB11_2014.csv"
data2015 <- "D:/seminario/SB11/limpia/SB11_2015.csv"

## importar data

df2012 <- read_delim(data2012, 
                     delim = ",", escape_double = FALSE, 
                     trim_ws = TRUE)

df2013 <- read_delim(data2013, 
                     delim = ",", escape_double = FALSE, 
                     trim_ws = TRUE)

df2014 <- read_delim(data2014, 
                     delim = ",", escape_double = FALSE, 
                     trim_ws = TRUE)

df2015 <- read_delim(data2015, 
                     delim = ",", escape_double = FALSE, 
                     trim_ws = TRUE)

## limpiar indice y validar que tengan las mismas columnas
df2012$...1 <- NULL
df2013$...1 <- NULL
df2014$...1 <- NULL
df2015$...1 <- NULL

## normalizar nombres
df2012 %<>% clean_names() 
df2013 %<>% clean_names() 
df2014 %<>% clean_names() 
df2015 %<>% clean_names() 

## unir data o cargarla 
dataUnida <- rbind(df2012, df2013, df2014, df2015)

## guardar data
write.csv(dataUnida, outputDir)

