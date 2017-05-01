# Script de explorandoMaiz

# Cargar archivo
x <- read.delim("../meta/maizteocintle_SNP50k_meta_extended.txt", sep="\t") # Cargar la tabla

# ??Qu?? tipo de objeto creamos al cargar la base?
class (x) # Es un data.frame

# ??C??mo se ven las primeras 6 l??neas del archivo?
head (x) # Ver las primeras 6 lineas del archivo

# ??Cu??ntas muestras hay?
nrow (x) # Hay 165 muestras

# ??De cu??ntos estados se tienen muestras?
levels (x$Estado) # Hay 19 estados.

# Cuantas muestras fueron colectadas antes de 1980
table (fullmat$A..o._de_colecta < 1980)

# Contar cu??ntas muestras hay de cada raza

table (fullmat$Raza)

# En promedio a qu?? altitud se encuentran

mean (fullmat$Altitud)

# A qu?? altitud m??xima y m??nima fueron colectadas:
max (fullmat$Altitud)
min (fullmat$Altitud)

# Crear un nuevo df con los datos de la raza Olotillo

Olotillo <- subset (fullmat, Raza == "Olotillo")

# Crear un nuevo df con los datos de las razas Reventador, Jala y Ancho

Varias <- subset(fullmat, Raza == c("Reventador", "Jala", "Ancho"))

# Escribir la matriz anterior en un archivo llamado submat.csv en meta

write.csv(Varias, "Unidad6/Prac_Uni6/maices/meta/submat.csv")