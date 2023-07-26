str(data)
missmap(data)
data[data$nacimiento.x == data$nacimiento.y]
data$estu <- NULL
colnames(data)[colnames(data) == "estu_mcpio_reside.y"] <- "mcpio_residencia"
names(data)

outputDir <- "D:/seminario/scripts/limpieza-icfes-saber-11/data_final/data_final_ajustada_con_long.csv"
coordenadas <- "D:/seminario/scripts/limpieza-icfes-saber-11/data_final/worldcities.csv"
write.csv(df_completo, outputDir)

data_coord <- read.csv(coordenadas)
data_coord <- data_coord %>% filter(str_detect(country, "Colombia"))
table(data$nacimiento.y)
str(data$nacimiento.y)
names(data)[12] = "city"
names(data)
df_completo <- merge(data, data_coord, by = "city")
data$city <- tolower(data$city)
data_coord$city <- tolower(data_coord$city)
table(df_completo$city)
