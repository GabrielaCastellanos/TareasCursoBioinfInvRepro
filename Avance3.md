# AVANCE 3
Querido diario

Hasta el día de he realizado los siguientes avances:

1. Corrí el programa bwa utilizando el genoma de C. pepo reportado por Blanca et al. para anotar mis secuencias con el siguiente script:
```
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
ref_map.pl --samples ./Sam -o ./populations -m 3 -T 2 -O popmap -b 1 -S
```

3. El archivo de salida de STACKS se corrió en vcftools para eliminar aquellos sitios con más de 50% de NA.
```
vcftools
```
