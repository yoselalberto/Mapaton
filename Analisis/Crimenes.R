# exploro la info de homicidios
setwd("~/Datos/Morlan/Mapaton/Analisis")
library(sp)
library(rgdal)
library(jsonlite)
library(dplyr)
library(leaflet)

# cargo los espaciales
estatal <- readOGR(dsn = "Datos", layer = "df_estatal") %>%
           geometry()
delegaciones <- readOGR(dsn = "Datos", layer = "df_municipal") %>%
                geometry()
mapaton <- readRDS("Datos/Rutas_mapaton.Rds")
cuadrantes <- readOGR("Datos/", "cuadrantes-sspdf-no-errors")

# preprocesado atributos
sspdf <- fromJSON("Datos/Homicidios/cuadrantes-sspdf-no-errors.json")
cuadr_inten <- fromJSON("Datos/Homicidios/cuadrantexintensidad.json")
# macheo los cuadrantes con crimenes
orden_cuar <- apply(sapply(cuadrantes[["id"]], FUN = "==", cuadr_inten$Cuadrante),
               MARGIN = 2, FUN = which)
cuadrantes$crimen <- unlist(cuadr_inten[orden_cuar, "Intensidad"])


# orden_cuar
mapa_crim <- leaflet() %>%
             setView(-99.168, 19.383, zoom = 12) %>%
             addProviderTiles("CartoDB.PositronNoLabels",
                              options = tileOptions(minZoom = 11, maxZoom = 14)) %>%
             setMaxBounds(-99.3649, 19.0482,-98.9403, 19.8) %>%
             addPolygons(data = estatal, color = "darkgrey", fill = FALSE, opacity = 1,
                         weight = 3) %>%
             addPolygons(data = delegaciones, weight = 1.5, color = "darkgrey", 
                         fill = FALSE, opacity = 1) %>%
             addPolygons(data = cuadrantes, fillColor = "#B40404", 
                         fillOpacity = cuadrantes$crimen, weight = 0.3) %>%
            addPolylines(data = mapaton, color = "#0431B4", opacity = 0.85, weight = 0.35)
mapa_crim

