## instalar librerias
require(magrittr)
require(readr)
require(tidyverse)
require(dplyr)
library(Amelia)
library(janitor)
library(ggplot2)

## preparando directorios
dirData <- "D:/seminario/data_limpia/final/data_final.csv"

## importar data
data <- read_csv(dirData)
databk <- data

##limpiar data 
data <- data %>% filter(!str_detect(sb11_fami_tienecomputador, "0"))
data <- data %>% filter(!str_detect(sb11_fami_tieneinternet, "0"))
data <- data %>% filter(!str_detect(sp_fami_tienecomputador, "0"))
data <- data %>% filter(!str_detect(sp_fami_tieneinternet, "0"))


data$sb11_fami_tienecomputador <- factor(data$sb11_fami_tienecomputador,
                                         levels = c("No", "Si"),
                                         labels = c("No", "Sí"))

data$sp_fami_tieneinternet <- factor(data$sp_fami_tieneinternet,
                                     levels = c("No", "Si"),
                                     labels = c("No", "Sí"))

## ver el porcentaje de estudiantes que no tienen acceso a intenet o computador
prop.table(table(data$sb11_fami_tienecomputador)) * 100
prop.table(table(data$sb11_fami_tieneinternet)) * 100
prop.table(table(data$sp_fami_tienecomputador)) * 100
prop.table(table(data$sp_fami_tieneinternet)) * 100
porcentaje_mismo_valor <- sum(data$sp_fami_tienecomputador == "No" & data$sp_fami_tieneinternet == "No") / nrow(data) * 100

# Dividir los datos en dos grupos: acceso a internet y sin acceso a internet
con_internet <- data[data$sb11_fami_tieneinternet == "Si", ]
sin_internet <- data[data$sb11_fami_tieneinternet == "No", ]

## graficos de gauss con acceso a tecnología 
area <- con_internet$sb11_punt_global
md_SB11 <- mean(area)
sd_SB11 <- sd(area)

x <- seq(0, 100, length.out = nrow(data))

pdf_SB11 <- dnorm(x, mean = md_SB11, sd = sd_SB11)

plot(x, pdf_SB11, type = "l", lwd = 2, col = "blue", xlab = "Probabilidad", ylab = "Densidad de probabilidad",
     main = "Distribución normal puntaje global con acceso a internet")

##lines(x, pdf_SB11, lwd = 2, col = "blue")

## graficos de gauss sin acceso a tecnología
area <- sin_internet$sb11_punt_global
md_SP <- mean(area)
sd_SP <- sd(area)

x <- seq(0, 100, length.out = nrow(data))

pdf_SP <- dnorm(x, mean = md_SP, sd = sd_SP)

##plot(x, pdf_SP, type = "l", lwd = 2, col = "red", xlab = "Probabilidad", ylab = "Densidad de probabilidad",
##     main = "Distribución normal puntaje global sin acceso a internet")

lines(x, pdf_SP, lwd = 2, col = "red")
legend("topright", legend = c("con internet", "sin internet"), col = c("blue", "red"), lwd = 2, cex = 0.8)