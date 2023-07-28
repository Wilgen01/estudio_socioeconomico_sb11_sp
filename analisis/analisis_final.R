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
     main = "Distribución normal puntaje naturales SB11")
lines(x, pdf_SB11, lwd = 2, col = "blue")

## graficos de gauss sin acceso a tecnología
area <- sin_internet$sb11_punt_global
md_SP <- mean(area)
sd_SP <- sd(area)

x <- seq(0, 100, length.out = nrow(data))

pdf_SP <- dnorm(x, mean = md_SP, sd = sd_SP)

plot(x, pdf_SP, type = "l", lwd = 2, col = "red", xlab = "Probabilidad", ylab = "Densidad de probabilidad",
     main = "Distribución normal puntaje comunucación escrita SP")

lines(x, pdf_SP, lwd = 2, col = "red")
legend("topright", legend = c("Saber 11", "Saber Pro"), col = c("blue", "red"), lwd = 2, cex = 0.8)



























# Convertir las variables sb11_fami_tieneinternet y sb11_fami_tienecomputador a variables categóricas
SB11_2013$sb11_fami_tieneinternet <- factor(SB11_2013$sb11_fami_tieneinternet,
                                                levels = c("0", "No", "Si"),
                                                labels = c("NA", "No", "Sí"))

SB11_2013$sb11_fami_tienecomputador <- factor(SB11_2013$sb11_fami_tienecomputador,
                                                  levels = c("0", "No", "Si"),
                                                  labels = c("NA", "No", "Sí"))

# Visualizar el rendimiento académico según el acceso a internet y el acceso a computador
ggplot(SB11_2013, aes(x = sb11_fami_tieneinternet, y = sb11_fami_tienecomputador, color = sb11_punt_global)) +
  geom_point() +
  labs(title = "Relación entre Rendimiento y Acceso a la Tecnología",
       x = "Acceso a Internet",
       y = "Acceso a Computador",
       color = "Puntaje Saber 11")

plot(SB11_2013$sb11_fami_tienecomputador,SB11_2013$sb11_pn_global,main ="Influencia de LECTURA CRÍTICA sobre el puntaje global",xlab = "LECTURA CRÍTICA", ylab = "Global")

# Crear un gráfico de barras apiladas para visualizar el acceso a internet y acceso a computador
ggplot(SB11_2013, aes(x = sb11_fami_tieneinternet, fill = sb11_fami_tienecomputador)) +
  geom_bar(position = "fill") +
  labs(title = "Relación entre Rendimiento y Acceso a la Tecnología",
       x = "Acceso a Internet",
       y = "Proporción",
       fill = "Acceso a Computador") +
  scale_fill_manual(values = c("No" = "gray", "Sí" = "blue")) +
  theme_minimal()


regresion1 <- lm(sb11_punt_global ~ sb11_fami_tienecomputador,data=SB11_2013)
regresion1



# Dividir los datos en dos grupos: acceso a internet y sin acceso a internet
con_internet <- SB11_2013[SB11_2013$sb11_fami_tieneinternet == "Si", ]
sin_internet <- SB11_2013[SB11_2013$sb11_fami_tieneinternet == "No", ]

# Análisis descriptivo de los puntajes globales
summary(con_internet$sb11_punt_global)
summary(sin_internet$sb11_punt_global)

# Visualización de los puntajes globales en cada grupo
hist(con_internet$sb11_punt_global, col = "blue", main = "Puntajes globales con acceso a internet")
hist(sin_internet$sb11_punt_global, col = "red", main = "Puntajes globales sin acceso a internet")

# Prueba de hipótesis (t-test) para comparar las medias de ambos grupos
t.test(con_internet$sb11_punt_global, sin_internet$sb11_punt_global)

t.test(con_internet$sb11_punt_global, sin_internet$sb11_punt_global)
print(result)
