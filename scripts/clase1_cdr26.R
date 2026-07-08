#####################################################################
#########  MANEJO DE DATOS EN R - UTalca 2025
######     Ian Acuña, código de...     dia1
#####################################################################

# -----
setwd("C:/erre/cursos/MEA_2026") # el working directory
.libPaths(new = "C:/erre/erre.lib")  # definir librería local (la "mia")
rm(list=ls())   # borrar el "environment"

# librerías
#install.packages("tidyverse")
library(tidyverse)

# fin de lo infaltable  -----

list.files()
dir.create("dia1")

ian



# FUNDAMENTOS DEL LENGUAJE ORIENTADO A *OBJETOS*

# Texto como "nombre"
nativas

# elementos "unicos"

5 # un número, funcional como calculadora

567 - 9008 * 67/9

"ian" # texto entre comillas

# más de un número, más de una texto

# números consecutivos, usar :
-5:23

# pero si no lo son... hay que concatenar (texto ó número)




# estos objetos son más interesantes si les damos "nombre"

tor <- c(57,7,102, 2, 34, 11) # vectores (listas) 1 dimensión

##### SIEMPRE "VER" LO QUE SE NOMBRA !!!!
##   como????
###  escribiendo su nombre y dando "enter" 
###  para visualizar lo que sale en pantalla 

tor # desde el script, control + enter

## atributos de los objetos #####

## atributos de un vector
length(tor)

# orden de elementos
sort(tor)
sort(tor, decreasing = TRUE)

order(tor) 
order(tor, decreasing = T)

# operaciones con vectores
sum(tor)
mean(tor)
max(tor)
min(tor)
tor2 <- c(tor, tor, 4, 56, 7008, pi)
tor2

tor > 11
tf <- tor == 11
tor2 <- tor * 2
tor2a <- tor / 5
tor2b <- tor + pi*2
tor3 <- tor + tor2


# indexación
tor[2]
tor[tf]
tor[c(2,4:6)]
tor %in% c(3, 5, 57)

tor.tf <- tor %in% c(3, 5, 11)
tor[tor.tf]

# al azar
sample(10:20, 10, replace = T) #  h

# vectores
x <- c(0.5, 0.6)       ## numeric
x2 <- 9:29              ## integer
x3 <- c(TRUE, FALSE)    ## logical
x4 <- c(T, F)           ## logical
x5 <- c("a", "b", "c")  ## character
x5b <- letters[1:10]    ## character
x6 <- c(1+0i, 2+4i)     ## complex

# todos los elementos deben ser iguales

tor.n <- c(0.18, 23, 4, sqrt(55), 301, pi/3)
tor.nl <- c(0.18, "bat", 23, 4, sqrt(55), 301, pi/3) 

##
# MATRIX "hojas de calculo o tablas", pero de un solo tipo --------------------------
#
mx <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 9)
mx

mt <- matrix(c("a","b","c","d","e","f"), nrow = 2, ncol = 3)
mt

x <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3)
z <- matrix(c(68,54,8,13),     nrow = 5, ncol = 3)

xz <- rbind(x,z)

# que pasa si...?
m1 <- matrix(c(1,2,3,4,5,6))
m2 <- matrix(seq(from = 1, to = 6), nrow = 20, ncol = 3)
m2b <- matrix(seq(1,6, by = 0.15), nrow = 20, ncol = 3)
m2c <- matrix(seq(1,6, length.out = 60), nrow = 20, ncol = 3)
m3 <- matrix(nrow = 20, ncol = 3)
m3b <- matrix(rep(x = 0, times = 60), nrow = 20, ncol = 3)


# rep, por supuesto, repíte un vector
rep(1, times = 3)
rep(c("A", "B", "C"), times = c(3, 1, 2))




# names (celda), rownames (fila), colnames (columna)
rownames(m3) <- as.character(seq(100, 119))
colnames(m3) <- rep("chile", 3)
class(m3)



# dataframes COLUMNAS DE DISTÍNTOS TIPOS --------------------------
tmin <- c(8.5, 11.5, 12.2, 14.3, 11.5, 9.1)
tmax <- c(28.5, 27.1, 23.3, 16.6, 20.1, 21.7)
dia <- c("lun", "lun", "mar", "mar", "mier", "mier")
lugar <- c("talca", "chillan", "talca", "chillan","talca",
           "chillan")

temps <- data.frame(tmin,tmax, dia, lugar)
temps

# atributos
dim(temps)
class(temps)
colnames(temps)
summary(temps)

# como "ver" (explorar) el dataframe?
temps

View(temps)

summary(temps)

temps$dia <- factor(temps$dia)
summary(temps)
temps$dia

# cómo escoger una(s) columna del data-frame?
temps$tmin
temps[,1]

# subset 
subset(temps, lugar == "chillan")
subset(temps, lugar == "chillan", select = c("tmin", "dia"))

# subsets indexados   data[filas , columnas]
temps[1:3,2] # posición

temps[1:3,1:2]

temps[1:3,2, drop = F] # mantener el df. en 1 columna

temps[,c(1,4)]          # el "vacio" indica "todos"

temps[-1,-4]          # los negativos indican "ese no"

temps[, c("dia","lugar")] # por nombre

temps[temps$tmin > 10, 1:3] # por condición lógica


# wide to long
library(dplyr)
library(tidyr)

temps_long <- temps %>%
  pivot_longer(
    cols = c(tmin, tmax),
    names_to = "temperaturas",
    values_to = "valores"
  )


#EJERCICIO:que ciudad tiene la temp menor y mayor?
# ORDENAR EL DATAFRAME "temps" POR tmax de mayor a menor
#                              POR tmin de menor a mayor

sort(temps$tmin)

# ordenar un dataframe x una columna
temps[ order(temps$tmin), ]

temps[c(2,3,1,4,6,5) , ]

temps[order(temps$tmax, decreasing = T), ]

which.max(tmax)

dia[which.max(tmax)]


# tablas (frecuencias)
table(temps$tmin)
table(temps$dia, temps$tmin, temps$lugar)

# generar una nueva colúmna de una operación entre vectores
temps$prom <- (temps$tmin + temps$tmax) / 2 # nuevas "columnas" con el simbolo "$"

# volvamos "factores" a las colúmnas categóricas
#cómo modificarla?
summary(temps)
#como es?
temps$dia <- factor(temps$dia)
temps$lugar <- factor(temps$lugar)
levels(temps$dia)

hume <- factor(c("media","baja","media","alta","alta","baja"),
                levels = c("baja","media","alta"))

temps$humedad <- hume

clim <- temps

# promedios
apply(temps,2,mean)  # uno = fila, 2 = columna

apply(temps[,c(1:2,5)],2,mean) 


# por sitio
tapply(temps$tmin, temps$lugar, mean)



# como asignar nuevos valores?
temps[1:2,"tmin"] <- c(4.5, 5.9)

temps$salon <- 20.5

temps[temps$tmax > 20.5,"salon"] <- "hot"

temps[temps$salon == "hot","salon"] <- 20.1

# Ejercicio: hacer un "mazo de cartas" digital en R

# columnas: nombre, pinta, valor

#ejemplo de carta: cinco, diamantes, 5

# hacer una nueva columna "valor2" donde el as valga 14 (y no 1) 


