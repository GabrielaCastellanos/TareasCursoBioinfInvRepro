## AVANCE 2

Querido diario:

La semana pasada descargue de la red el genoma de Cucurbita pepo para utilizar como referencia para el llamado de SNPs.

Esta semana me he dedicado a los análisis de limpieza de SNPs utilizando Fast X Tools, y ya tengo las secuencias limpias y cortadas para alinear al genoma de referencia.

Este es mi script para correr Fast X Tools con los archivos raw de C. pepo

1. Iniciar un contenedor docker con Fast X Tools instalado, montando la carpeta en donde tengo mis secuencias crudas.
```
docker run -v /Users/gabriela/Documents/PosDocCalabazas/CalabacitasTiernas/C_pepo/Analisis/tGBS/Analisis_Pepo/:/data -it fastxtools/0.0.14 
```
2. Para filtro de calidad: Los parametros de filtrado son una calidad mínima de 15 (-q) en el 80% de las bases (-p).
```
for i in $(cat Nombres_nuevos.txt); do
fastq_quality_filter -q 15 -v -i $i.gz -o ../Filtradas/Fil_$i -p 80
done
```
-z Comprime el output. OJO, fastx_clipper no esta reconociendo archivos comprimidos; -v Imprime en la pantalla el número de secuencias; -i Se refiere al input file; -o Se refiere al output file.

3. Utilizar clipper para quitar las secuencias de menos de 30 nucleótidos (-l), quedarse con secuencias con nucleotidos desconocidos N (-n), reportar el numero de secuencias (-v).
```
for i in $(cat Nombres_nuevos.txt); do
fastx_clipper -l 30 -n -v -i ../Filtradas/Fil_$i.gz -o ../Clipped/Clipped_$i
done
```
4. Recortar las secuencias para que queden del mismo tamaño (250) y quitar las últimas bases de mala calidad
```
for i in $(cat Nombres_nuevos.txt); do
fastx_trimmer -l 250 -v -i ../Clipped/Clipped_$i -o ../Trimmed/Trimmed_$i
done
```

La alineación se realizará con bwa mem y posteriormente correré STACKS para el llamado de SNPs y obtener los archivos en formato para adegenet y Structure.
