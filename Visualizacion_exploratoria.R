# Visualizacion exploratoria
setwd("~/Datos/Morlan/Mapaton/Analisis")
library(sp)
library(rgdal)
library(dplyr)
library(leaflet)

# cargado de datos
estatal <- readOGR(dsn = "Datos", layer = "df_estatal") %>%
           geometry()
delegaciones <- readOGR(dsn = "Datos", layer = "df_municipal") %>%
           geometry()
# rutas antiguas
rutas <- readRDS("Datos/Rutas_viales.Rds")
# rutas mapaton
mapaton <- readRDS("Datos/Rutas_mapaton.Rds")

## Mapas en leaflet

# rutas antiguas
mapa <- leaflet() %>%
        setView(-99.168, 19.383, zoom = 12) %>%
        addProviderTiles("CartoDB.PositronNoLabels",
                         options = tileOptions(minZoom = 11, maxZoom = 14)) %>%
        setMaxBounds(-99.3649, 19.0482,-98.9403, 19.70) %>%
        addPolygons(data = estatal, color = "darkgrey", fill = FALSE, opacity = 1,
                    weight = 4) %>%
        addPolygons(data = delegaciones, weight = 2, color = "darkgrey", 
                    fill = FALSE, opacity = 1) %>%
        addPolylines(data = rutas, color = "#0B2161", opacity = 0.95, weight = 1.5)
mapa

# rutas nuevas
mapa_ton <- leaflet() %>%
            setView(-99.168, 19.383, zoom = 12) %>%
            addProviderTiles("CartoDB.PositronNoLabels",
                             options = tileOptions(minZoom = 11, maxZoom = 14)) %>%
            setMaxBounds(-99.3649, 19.0482,-98.9403, 19.8) %>%
            addPolygons(data = estatal, color = "darkgrey", fill = FALSE, opacity = 1,
                        weight = 4) %>%
            addPolygons(data = delegaciones, weight = 2, color = "darkgrey", 
                        fill = FALSE, opacity = 1) %>%
            addPolylines(data = mapaton, color = "#3A01DF", opacity = 0.95, weight = 1.5)
mapa_ton
