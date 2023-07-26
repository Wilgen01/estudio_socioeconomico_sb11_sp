# Verificar y ajustar los niveles de las variables de educación de los padres
SB11_2013$sb11_fami_educacionpadre <- factor(SB11_2013$FAMI_EDUCACIONPADRE, 
                                            levels = c("Ninguno", "Primaria incompleta",
                                                       "Primaria completa", "Secundaria (Bachillerato) incompleta",
                                                       "Secundaria (Bachillerato) completa", "Técnico o tecnólogo incompleto",
                                                       "Técnico o tecnólogo completo", "Educación profesional incompleta",
                                                       "Educación profesional completa", "Postgrado"))

SB11_2013$sb11_fami_educacionmadre <- factor(SB11_2013$sb11_fami_educacionmadre, 
                                            levels = c("Ninguno", "Primaria incompleta",
                                                       "Primaria completa", "Secundaria (Bachillerato) incompleta",
                                                       "Secundaria (Bachillerato) completa", "Técnico o tecnólogo incompleto",
                                                       "Técnico o tecnólogo completo", "Educación profesional incompleta",
                                                       "Educación profesional completa", "Postgrado"))

ggplot(SB11_2013, aes(x = sb11_fami_educacionpadre, y = sb11_fami_educacionmadre, color = sb11_punt_global)) +
  geom_point() +
  labs(title = "Relación entre Rendimiento y Nivel Educativo de los Padres",
       x = "Nivel Educativo del Padre",
       y = "Nivel Educativo de la Madre",
       color = "Puntaje Saber 11")


# Cargar las librerías
library(dplyr)
library(ggplot2)


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
