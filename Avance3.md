# AVANCE 3
Querido diario

Hasta el día de he realizado los siguientes avances:

1. Corrí el programa bwa utilizando el genoma de C. pepo reportado por Blanca et al. para anotar mis secuencias con el siguiente script:
```
#!/bin/sh
#USAGE: nohup ./fastq2bam.sh genoma_referencia.fasta lista_secuencias > log.txt &
#Se debe generar una lista de las secuencias FASTQ que se quieran analizar (e.g., "ls *.fastq").
#Ajustar la ruta donde se encuentran tus archivos fastq en la línea 13 del script. 
#Descomprimir el genoma de referencia

GENOMA=$1
LISTA=$2

bwa index GenomaCpepoBlanca/${GENOMA}

for ARCHIVO in $(cat ${LISTA}); do 
	PREFIX=$(echo ${ARCHIVO} | cut -d "." -f 1)
	bwa mem -t 2 -M ${GENOMA} ../Trimmed/${ARCHIVO} | samtools view -hbS > ${PREFIX}.bam
	samtools sort -o ${PREFIX}.sorted.bam ${PREFIX}.bam
	rm ${PREFIX}.bam
	samtools index ${PREFIX}.sorted.bam 
done

rm ${GENOMA}.amb
rm ${GENOMA}.ann 
rm ${GENOMA}.bwt
rm ${GENOMA}.pac
rm ${GENOMA}.sa 


exit 0
```
2. Una vez realizada la anotación corrí el modulo populations del programa STACKS utilizando los archivos .sam con entrada, utilizando el siguiente script:

```
nohup ref_map.pl -T 6 -O popmap --samples ./samples/ -b 1 -o ./stacks/ -S -m 3 &
```
Se obtuvieron 12123 SNPs

3. El archivo de salida de STACKS se corrió en vcftools para eliminar aquellos sitios con más de 50% de NA.
```
vcftools --vcf batch_1.vcf -max-missing 0.5 --recode --out batch1SinNa --plink
```
Se obtuvieron 2763 SNPs

4. El archivo de salida de vcftools se corrió en el modulo populations de STACKS con el siguiente script para obtener las bases de datos :
```
nohup populations -P ./stacks/ -b 1 -O ./populations/ -M popmap -t 6 -p 2 -r 0.75 --min_maf 0.05 --max_obs_het 0.7 -m 3 --write_single_snp --fstats -k --vcf --vcf_haplotypes --genepop --phylip &

# -p Número mínimo de poblaciones en un locus para procesarlo: 2
# -r Porcentaje mínimo de individuos en una poblacion requerido para procesar el locus: 0.75
# --min_maf Frecuencia alélica mínima (MAF) para retenerlo
# --max_obs_het Heterocigosis observada máxima permitida en un locus: 0.7
# -m Profundidad de un stack mínima requerida para procesar el locus
# --write_single_snp Escribir sólo un snp por stack
# --fstat Estimar estadísiticos F
# -k Calcular el kernel para obtener los estadísticos F en ventanas
# --vcf Escibir el archivo en formato vcf
# --vcf_haplotype Escribe un archivo de los haplotipos en formato vcf
# --genepop Escribe el formato para genepop
# --phylip Escribe un archivo con los snps para hacer arboles con phylip-
```
5. He estado intentando correr fastStructure sin obtener buen resultado, por lo que mejor realizaré un análisis de DAPC en adegenet utilizando como base de datos de entrada el archivo genepop de los 2763 SNPs. Con el mismo programa obtendré las medidas básicas de diversidad genética para cada una de las poblaciones analizadas.

