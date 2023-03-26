Q1: How many positions are found in this region in the VCF file?

`tabix -h CEU.exon.2010_03.genotypes.vcf.gz 1:1105411-44137860 | bcftools query -f '%POS\n' | wc -l`

A: 69 positions
   
Q2: How many samples included in the VCF file?

`bcftools query -l CEU.exon.2010_03.genotypes.vcf.gz  | wc -l`

A: 90 positions 
   
Q3: How many positions are there total in the VCF file?

`bcftools query -f '%POS\n' CEU.exon.2010_03.genotypes.vcf.gz | wc -l`

A: 3489

Q4: How many positions are there with AC = 1

`bcftools filter -i AC=1 CEU.exon.2010_03.genotypes.vcf.gz | bcftools query -f '%POS\n' | wc -l`

A: 1075

Q5: What is the ratio of transitions to transversions (ts/tv) in this file?

`bcftools stats CEU.exon.2010_03.genotypes.vcf.gz `

A: 3.4675 (2708/781)

A6: What is the median number of variants per sample in this data set?

A: 28


