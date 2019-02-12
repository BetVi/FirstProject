#Read data
ExistProd <- read.csv("C:/Users/xispi/OneDrive/Escritorio/BLACKWELL/Task 3 Multiple Regression in R/existingproductattributes2017.2.csv")


###Recall necessary libraries
library(readr)
library(readxl)
library(party)
library(caret)
library(lattice)
library(ggplot2)
library(e1071)
library(foreach)
library(grid)
library(rpart)
library(rpart.plot)
library(outliers)
##Data Exploration

### We started having a look at the dataset structure and a summary
str(ExistProd)
summary(ExistProd)
attributes(ExistProd)
###Que hacer con los missing values de Best Sellers Rank?
####eliminar amazon no hay maneraa de substituir
is.na(ExistProd)
sum(is.na(ExistProd))
esquisse::esquisser()
###posibles outliers
ggplot(data = ExistProd) +
  aes(x = ProductType, y = x5StarReviews) +
  geom_boxplot(fill = "#0c4c8a") +
  theme_minimal()
ggplot(data = ExistProd) +
  aes(x = ProductType, y = Price) +
  geom_boxplot(fill = "#0c4c8a") +
  theme_minimal()
###outliers en el volumen
ggplot(data = ExistProd) +
  aes(x = Volume) +
  geom_histogram(bins = 30, fill = "#0c4c8a") +
  theme_minimal()
#borrar outliers volume

#### Found two outliers 11204volume and 7036 volume
ggplot(data = ExistProd) +
aes(x = Volume, y = Price, color = Volume) +
  geom_point() +  theme_minimal()
 
# Histogram of salary and brand
ggplot(ExistProd, aes(x=Volume, fill=Price)) + 
  geom_histogram(color="black", bins=10) +
  labs(title="Relationship between Volume and Price")+
  scale_x_continuous(breaks=seq(3000, 6000, 9000))
  ###observamos los outliers
ggplot(ExistProd,aes(x="",y=Volume)) + geom_boxplot()
####guardamos el ggplot del volumen para luego poder extraer información
VolumePlot<-ggplot(ExistProd,aes(x="",y=Volume)) + geom_boxplot()
###Aquí podemos seleccionar los datos que nos interesa ver se pone VolumePlot$ y aparece la lista
VolumePlot$data
####Ojo datos duplicados Extended Warranty(del 34 al 41)
####Como cambiar el valor de una columna 
boxplot(ExistProd$Volume)
SimpleBoxPlotVolume<-boxplot(ExistProd$Volume)
###Haciendo esto me muestra los valores de los puntos(outliers) que salían en el boplot
SimpleBoxPlotVolume$out
####Remove outliers in the dataset
ExistProd2<- ExistProd[!ExistProd$Volume>6000,]
str(ExistProd2)
summary(ExistProd2)
attributes(ExistProd2)
