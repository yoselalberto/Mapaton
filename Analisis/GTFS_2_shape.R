# convierto el GTFS 
setwd("~/Datos/Morlan/Mapaton/Analisis")
library(sp)
library(rgdal)
library(dplyr)
library(ggplot2)

# cargo los datos
shapes <- read.csv("Datos/mapatonGTFS/shapes.txt", header = TRUE,
                   row.names = NULL)

# visualizacion