# exploro las rutas por ageb
setwd("~/Datos/Morlan/Mapaton/Analisis")
library(sp)
library(rgdal)
library(jsonlite)
library(dplyr)
library(leaflet)

# cargado de datos
estatal <- readOGR(dsn = "Datos", layer = "df_estatal") %>%
           geometry()
delegaciones <- readOGR(dsn = "Datos", layer = "df_municipal") %>%
           geometry()
# ageb
ageb <- readOGR("Datos", layer = "df_ageb_urb")
ageb <- ageb[, "CVEGEO"]        
densidades <- fromJSON("Datos/JSONes/agebDen.json")
# rutas mapaton
mapaton <- readRDS("Datos/Rutas_mapaton.Rds")
proy <- CRS("+proj=longlat +ellps=WGS84 +no_defs")
proj4string(mapaton) <- proy

# macheo las ageb's con las rutas de transporte
orden <- apply(sapply(ageb[["CVEGEO"]], FUN = "==", densidades$id),
                    MARGIN = 2, FUN = which)
ageb$densidad <- unlist(densidades[orden, "densidad"])

# visualizo las densidades en leaflet
mapa_ageb <- leaflet(data = ageb) %>%
            setView(-99.168, 19.383, zoom = 12) %>%
            addProviderTiles("CartoDB.PositronNoLabels", options = tileOptions(minZoom = 11, maxZoom = 14)) %>%
            setMaxBounds(-99.3649, 19.0482,-98.9403, 19.6) %>%
            addPolygons(data = estatal, color = "darkgrey", fill = FALSE, opacity = 1, weight = 3) %>%
            addPolygons(data = delegaciones, weight = 1.5, color = "darkgrey", fill = FALSE, opacity = 1) %>%
            addPolygons(color = "#B40404", fillOpacity = ageb$densidad, weight = 1, stroke = FALSE) %>%
            addPolylines(data = mapaton, color = "#0431B4", opacity = 0.85, weight = 0.35)
mapa_ageb

