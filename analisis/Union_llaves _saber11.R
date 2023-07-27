## instalar librerias
require(magrittr)
require(readr)
require(tidyverse)
require(dplyr)
library(Amelia)
library(janitor)

## establecer directorios
dir_data_11 <- "D:/seminario/SB11/limpia/SB11_unida.csv"
dir_data_sp <- "D:/seminario/SP/limpia/SP_unida.csv"
dir_data_keys <- "D:/seminario/llaves.txt"

## importar data
SB11 <- read_csv(dir_data_11)
SP <- read_csv(dir_data_sp)
keys <- read_csv(dir_data_keys)


## limpiar indice y validar que tengan las mismas columnas
names(SB11)
SB11$...1 <- NULL

names(SP)
SP$...1 <- NULL

## renombrar variable en las cruces
names(keys)
names(keys)[1]="sb11_estu_consecutivo"
names(keys)[2]="sp_estu_consecutivo"


## renombrar variables prob normal de sp
SP %>% names()
names(SP)[11] = "pn_sociales_sp"
names(SP)[12] = "pn_ingles_sp"
names(SP)[13] = "pn_com_escrita_sp"
names(SP)[14] = "pn_matematicas_sp"
names(SP)[15] = "pn_lectura_sp"
names(SP)[16] = "pn_global_sp"


## union 
union_llave<-merge(x=SB11, y=keys, by = "sb11_estu_consecutivo")
data_final<-merge(x=union_llave, y=SP, by = "sp_estu_consecutivo")

str(union_llave)


## graficando 
plot(data_final$pn_lectura_sp, data_final$pn_global_sp)


## guardar a CSV 
outputDir <- "D:/seminario/data_limpia/final/data_final.csv"
write.csv(data_final, outputDir)
