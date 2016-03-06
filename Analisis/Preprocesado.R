# Exploración inicial
setwd("~/Datos/Morlan/Mapaton/Analisis")
library(sp)
library(rgdal)
library(dplyr)

# cargo los datos
estatal <- readOGR(dsn = "Datos", layer = "df_estatal") %>%
           geometry()
delegaciones <- readOGR(dsn = "Datos", layer = "df_municipal") %>%
                geometry()

#eje_vial <- readOGR(dsn = "Datos", layer = "df_eje_vial") %>% geometry()
# mapas
par(mar = c(0, 0, 0, 0) + 0.1, xaxs = "i", yaxs = "i",  lwd = 0.3, cex = 2, 
    family = "serif", bg = "gray98")
plot(estatal)
plot(delegaciones, add = TRUE)
#plot(eje_vial, add = TRUE, col = "gray20")
