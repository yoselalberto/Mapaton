# preproceso el los dbf
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
# clave de la posecion de autos
descr <- read.csv("Datos/descriptores/desc_cpv2010.csv", header = TRUE,
                  row.names = NULL, as.is = TRUE)
names(descr) <- c("campo", "descripcion")

# busco las variables interesantes
ind_auto <- descr$descripcion %>% str_detect("(auto)|(coche)") %>% which()
descr[ind_auto, ]
autos <- descr[609, ]
#saveRDS(autos, "Datos/Indice_densidad_autos.Rds", compress = FALSE)

