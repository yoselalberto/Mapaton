# Exploro la densidad de los autos
setwd("~/Datos/Morlan/Mapaton/Analisis")
library(sp)
library(rgdal)
library(dplyr)
library(stringr)
library(leaflet)

# cargado de datos
estatal <- readOGR(dsn = "Datos", layer = "df_estatal") %>%
           geometry()
delegaciones <- readOGR(dsn = "Datos", layer = "df_municipal") %>%
                geometry()
ageb <- readOGR("Datos", layer = "df_ageb_urb")
ageb <- ageb[, "CVEGEO"]
# rutas de transporte
mapaton <- readRDS("Datos/Rutas_mapaton.Rds")
# indice de la densidad de autos
ind_auto <- readRDS("Datos/Indice_densidad_autos.Rds")
# clave de la posecion de autos
ageb_info <- read.csv("Datos/tablas/df_cpv2010_ageb_urb_viviendas.csv", 
              header = TRUE, row.names = NULL, as.is = TRUE, 
              na.strings = c("-8.0", "-6.0")) %>%
              tbl_df

# extraigo las densidades
info_auto <- ageb_info %>% 
             select(CVEGEO.C.13, contains("VIV28_R")) %>%
             rename(CVEGEO = CVEGEO.C.13, per_auto = VIV28_R.N.5.1) %>%
             mutate(per_auto = per_auto/100)
            
# macheo los porcentajes con las agebs
orden <- apply(sapply(ageb[["CVEGEO"]], FUN = "==", info_auto$CVEGEO),
               MARGIN = 2, FUN = which)
ageb$per_auto <- unlist(info_auto[orden, "per_auto"])


## Mapeos de info de AGEB

mapa_auto <- leaflet(data = ageb) %>%
             setView(-99.168, 19.383, zoom = 12) %>%
             addProviderTiles("CartoDB.PositronNoLabels",
                              options = tileOptions(minZoom = 11, maxZoom = 14)) %>%
             setMaxBounds(-99.3649, 19.0482,-98.9403, 19.6) %>%
             addPolygons(data = estatal, color = "darkgrey", fill = FALSE, opacity = 1,
                         weight = 4) %>%
             addPolygons(data = delegaciones, weight = 2, color = "darkgrey", 
                         fill = FALSE, opacity = 1) %>%
             addPolygons(color = "#DF3A01", fillOpacity = ageb$per_auto, weight = 1.5,
                         stroke = FALSE) %>%
             addPolylines(data = mapaton, color = "#0431B4", opacity = 0.85, weight = 0.35)
mapa_auto


