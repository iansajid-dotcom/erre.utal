#######################################################
# Practica de R base 
# 2026 - Ian Acuña.                    
# Utalca
#######################################################

# los 3 comandos:
# definir el directorio de trabajo (working directory)
# la libreria
# y borrar todo en el environment
setwd("C:/erre/cursos/MEA_2026") # el working directory
.libPaths(new = "C:/erre/erre.lib")  # definir librería local (la "mia")
rm(list=ls())   # borrar el "environment"

# Llamar librerías
#install.packages("tidyverse")
library(tidyverse)

# fin de lo infaltable


# leer ARCHIVOS! ----------------------------------------

# de texto
nat.t <- read.table("d1.nativas.txt", header = T)
summary(nat.t)

# separados por comas
nat.c <- read.csv("d1.nativas.csv", header=T)
summary(nat.c)

# transformando el texto a factor (categorías)
nat.c2 <- read.csv("d1.nativas.csv",
                   header=T,
                   stringsAsFactors = T)
head(nat.c2)
tail(nat.c2)
summary(nat.c2)

#confirmar en spp
levels(nat.c2$spp)

# incorporar los "na´s"
nat.c3 <- read.csv("d1.nativas.csv",
                   header=T,
                   stringsAsFactors = T,
                   na.strings = c("NAN","Na","na","NA"))
summary (nat.c3)

# los números a factores (categorías)
nat.c3$trat <- factor(nat.c3$trat)
nat.c3$tiempo.f <- factor(nat.c3$tiempo)

# desde excel
# install.packages("readxl") # solo la primera vez
library(readxl)            # llamar el paquete a la sesion
nat.x <- read_excel(path = "d1.nativas.xlsx",
                    sheet = "bosque",
                    na = "na")

# los números a factores
nat.x$trat <- factor(nat.x$trat)
nat.x$tiempo.f <- factor(nat.x$tiempo)

summary(nat.x)

write.csv(nat.x, "copia.nat.csv")

nat.x2 <- nat.x[nat.x$spp %in% c("maiten", "prosopis"),]

nat.x2

# ejercicio

# escribir en DD un archivo exclusivo para "maiten" y "prosopis"
# cargar un set de datos propio (de ustedes)
# cambiar todas las variables categóricas de texto a "factores"
# verificar con "summary"


# dplyr
library(dplyr)

# dplyr usa Tibbles
nat.ti <- tibble(nat.c3)

# seleccionar columnas
select(nat.ti, spp, altura, nudos)
select(nat.ti, 1:5)
select(nat.ti, spp:hojas)
select(nat.ti, -"ind")
select(nat.ti, contains("tiem")) # see help

arrange(nat.ti, altura) # como cambiar la dirección?
arrange(nat.ti, trat, altura)

dplyr::filter(nat.ti, nudos > 24)

arrange(filter(nat.ti, nudos > 24,
               tiempo == 2), nudos)

filter(nat.ti, spp %in% c("maiten", "prosopis"))

filter(nat.ti, spp != "tara")   # ! = otras ideas de filtro?

nat.ti <- mutate(nat.ti, vol.tallo = pi*(altura * diam.tallo)) # quedó?

# cambiar nombre a 1 columna
rename(nat.ti, vol.t = vol.tallo)


# unir datasets...
data(band_instruments)
data(band_members)

inner_join(band_members,
           band_instruments, by = "name")
left_join(band_members,
          band_instruments)
right_join(band_members,
           band_instruments)
full_join(band_members,
          band_instruments)

data(band_instruments2)

inner_join(band_members,
           band_instruments2, join_by(name == artist))

# resumir los datos...
summarise(nat.ti, prom = mean(nudos))

summarise(group_by(nat.ti, spp), prom = mean(nudos))

summarise(group_by(nat.ti, spp, trat, tiempo),
          prom = mean(nudos), std=sd(nudos))

colnames(nat.ti)

# pipe operator
nat.x %>%                  # ctrl + shift + m
  group_by(spp) %>%
  summarise(prom = mean(nudos),
            std=sd(nudos)) -> nat.sum

# all in once
nat.x %>%                  # ctrl + shift + m
  group_by(spp, trat, tiempo) %>%
  summarise(nu.prom = mean(nudos),
            nu.std=sd(nudos),
            dit.prom = mean(diam.tallo, na.rm = T),
            dit.std=sd(diam.tallo, na.rm = T),
            alt.prom = mean(altura),
            alt.std=sd(altura),
            ene = n()) -> nat.sum2
# check...
# nueva columna con nuevos nombres
nat.ti %>%
  mutate(especie = case_when(spp == "tara" ~ "C. espinosa",
                             spp == "maiten" ~ "M. boaria",
                             spp == "prosopis" ~ "P. chilensis",
                             spp == "quillay" ~ "Q. saponaria")) -> nat.ti



#fin