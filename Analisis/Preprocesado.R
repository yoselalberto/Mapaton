# Exploración inicial
setwd("~/Datos/Morlan/Mapaton/Analisis")
library(sp)
library(rgdal)
library(dplyr)
library(Cairo)

# cargo los datos
estatal <- readOGR(dsn = "Datos", layer = "df_estatal") %>%
           geometry()
delegaciones <- readOGR(dsn = "Datos", layer = "df_municipal") %>%
                geometry()

seje_vial <- readOGR(dsn = "Datos", layer = "df_eje_vial") %>% geometry()
# mapa del df y las delegaciones
#CairoPNG("Imagenes/DF_vial.png", width = 1000, height = 1300, pointsize = 1)
par(mar = c(0, 0, 0, 0) + 0.1, xaxs = "i", yaxs = "i",  lwd = 0.1, cex = 2, 
    family = "serif", bg = "gray98")
plot(estatal)
plot(delegaciones, add = TRUE)
plot(eje_vial, add = TRUE, col = "gray20")
#dev.off()
