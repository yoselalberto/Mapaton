# convierto el GTFS 
setwd("~/Datos/Morlan/Mapaton/Analisis")
library(sp)
library(rgdal)
library(dplyr)
library(ggplot2)
library(maps)
library(maptools)

# cargo los datos
shape <- read.csv("Datos/mapatonGTFS/shapes.txt", header = TRUE, row.names = NULL,
                  as.is = TRUE)

# preprocesado
ids <- unique(shape$shape_id)
shape_orig <- shape
shape <- shape[shape$shape_id == ids[1],] 

# prueba
shape_map <- list(x = shape$shape_pt_lon, y = shape$shape_pt_lat)
shape_lines <- map2SpatialLines(shape_map, IDs = ids[1])
# resto de las lineas
for(i in 2:length(ids)){
    shape <- shape_orig[shape_orig$shape_id == ids[i],]
    shape_map <- list(x = shape$shape_pt_lon, y = shape$shape_pt_lat)
    shape_temp <- map2SpatialLines(shape_map, IDs = ids[i])
    shape_lines <- spRbind(shape_lines, shape_temp)
}
# guardo el mapa en rds
saveRDS(shape_lines, "Datos/Rutas_mapaton.Rds", compress = FALSE)



