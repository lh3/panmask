Easy regions (where variant calls tend to be accurate in most samples):

* [ENCODE][encode]: ENCODE blacklist regions v2, published in [Amemiya et al (2019)][pub-encode]
* [umap-k100][umap]: Umap for 100bp single-end reads, published in [Karimzadeh et al (2018)][pub-umap]
* [GIAB-easy][GIAB-easy]: GIAB genome stratification v3.5, published in [Dwarshuis et al (2024)][pub-GIAB-easy]

[GIAB-easy]: https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/genome-stratifications/v3.5/GRCh38@all/Union/
[pub-GIAB-easy]: https://www.nature.com/articles/s41467-024-53260-y
[umap]: https://bismap.hoffmanlab.org
[pub-umap]: https://academic.oup.com/nar/article/46/20/e120/5086676?login=false
[encode]: https://github.com/Boyle-Lab/Blacklist
[pub-encode]: https://www.nature.com/articles/s41598-019-45839-z

HG002 confident regions (where small variant calls can be trusted):

* [HG002-GIAB][GIAB-old]: NIST confident regions, v4.2.1
* [HG002-Q100][GIAB-new]: T2TQ100 v1.1

[GIAB-old]: https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/AshkenazimTrio/HG002_NA24385_son/NISTv4.2.1/GRCh38/
[GIAB-new]: https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/AshkenazimTrio/analysis/NIST_HG002_DraftBenchmark_defrabbV0.019-20241113/

<!--
|                    |GIAB-easy| ENCODE  |umap-k100| pm151   | pm151a  |HG002-Q100|HG002-GIAB|
|:-------------------|--------:|--------:|--------:|--------:|--------:|---------:|---------:|
|Size (Gb)           |2.31     |2.83     |2.82     |2.55     |2.59     |2.74      |2.54      |
|# blocks            |4.84M    |731      |242k     |1.20M    |299k     |28.7k     |481k      |
|N50 block length    |860      |16.1M    |142k     |4158     |22.9k    |183k      |11.2k     |
|% GRCh38            |79.0     |96.8     |96.7     |87.2     |88.7     |93.7      |87.0      |
|% GenCode CDS       |72.6     |98.5     |97.6     |92.0     |92.3     |95.8      |91.8      |
|% ClinVar patho     |77.4     |99.8     |99.6     |95.1     |95.8     |98.8      |90.2      |
-->
<!--
|% gnomAD SNP20 pass| 89.8        | 78.2    | 99.6       |
|% gnomAD SNP20 flt | 26.8        | 7.1     | 86.5       |

* % gnomAD SNP20 pass: percent PASS SNPs at 20% allele frequency in gnomAD are included in the confident regions
* % gnomAD SNP20 flt: percent filtered SNPs at 20% allele frequency in gnomAD are included in the confident regions
* ClinVar version: 20250209
* GenCode version: v47
* Q100 version: 20241113
-->
