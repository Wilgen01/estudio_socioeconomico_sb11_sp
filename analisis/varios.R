library(ggplot2)

min(SP$pn_global)
max(SP$pn_global)

md <- mean(SP$pn_global)
sd <- sd(SP$pn_global)

x <- seq(0, 100, length.out = 743473)

pdf_global <- dnorm(x, mean = md, sd = sd)
pdf_ingles <- dnorm(x, mean = md, sd = sd)

plot(x, pdf_global, type = "l", lwd = 2, col = "blue", xlab = "Valores", ylab = "Densidad de probabilidad",
     main = "Comparación de Campanas de Gauss (Distribución normal)")

lines(x, pdf_global, lwd = 2, col = "red")


# Cargamos la librería

labs
# DataFrame con columna 'resultado'
df <- data.frame(resultado = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100))

# Gráfico de densidad para la columna 'resultado'
ggplot(df, aes(x = resultado)) +
  geom_density(fill = "blue", alpha = 0.6) +
  labs(title = "Campana de Gauss - Datos originales", x = "Resultado", y = "Densidad")

# DataFrame con columna 'pn_resultados'
df_pnorm <- data.frame(pn_resultados = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100))
densidad <- density(SP$pn_ingles)
plot(densidad, main = "Campana de Gauss", xlab = "Resultado", ylab = "Densidad")
names(swiss)
view(swiss)
hist(SP$pn_ingles)
plot(SP$punt_global,SP$nacimiento,main ="Influencia de LECTURA CRÍTICA sobre el puntaje global",xlab = "LECTURA CRÍTICA", ylab = "Global")
names(SP)

## grafica de dispersion con ggplot
grafica = ggplot(SP, aes(x=punt_global, y=estu_genero))
grafica + geom_point() + geom_smooth(method = "lm", colour="red")
grafica
