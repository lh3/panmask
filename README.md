## Introduction

Panmask provides a list of easy/hard regions for short-read variant calling against the human genome GRCh38.
The easy regions harbor small variants that are easy to call, with most variant callers achieving 98-99.5% accuracy in the regions.
They cover 88.7% of GRCh38, 92.0% of coding regions and 95.1% of pathogenic variants in ClinVar.
The panmask regions may help to reduce variant calling artifacts and simplify variant filtering.
They can be downloaded [from Zenodo][zenodo].

[zenodo]: https://zenodo.org/records/14903542

## Other Datasets

GRCh38 easy regions (where variant calls tend to be accurate in most samples):

* [umap-k100][umap]: Umap for 100bp single-end reads, published in [Karimzadeh et al (2018)][pub-umap]
* [ENCODE][encode]: ENCODE blacklist regions v2, published in [Amemiya et al (2019)][pub-encode]
* [GIAB-easy][GIAB-easy]: GIAB genome stratification v3.5, published in [Dwarshuis et al (2024)][pub-GIAB-easy]

[GIAB-easy]: https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/genome-stratifications/v3.5/GRCh38@all/Union/
[pub-GIAB-easy]: https://www.nature.com/articles/s41467-024-53260-y
[umap]: https://bismap.hoffmanlab.org
[pub-umap]: https://academic.oup.com/nar/article/46/20/e120/5086676?login=false
[encode]: https://github.com/Boyle-Lab/Blacklist
[pub-encode]: https://www.nature.com/articles/s41598-019-45839-z

HG002 confident regions (where small variant calls can be trusted):

* [HG002-GIAB][GIAB-old]: NIST confident regions, v4.2.1
* [HG002-Q100][GIAB-new]: T2TQ100 v1.1/20241113

[GIAB-old]: https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/AshkenazimTrio/HG002_NA24385_son/NISTv4.2.1/GRCh38/
[GIAB-new]: https://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/AshkenazimTrio/analysis/NIST_HG002_DraftBenchmark_defrabbV0.019-20241113/

Other datasets used for evaluation:

* ClinVar, [20250209][clinvar-dw]
* GenCode basic gene annotation, [v47][gencode-gtp]

[clinvar-dw]: https://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/archive_2.0/2025/
[gencode-gtp]: https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_47/

Short-read [small variant calls][varcall], published in [Baid et al (2020)][pub-varcall].
Only VCFs called from HG002 PCR-free NovaSeq data at 50X are used.

[varcall]: https://console.cloud.google.com/storage/browser/brain-genomics-public/research/sequencing/grch38/vcf/novaseq/wgs_pcr_free/50x
[pub-varcall]: https://www.biorxiv.org/content/10.1101/2020.12.11.422022v1

<!--
|                    |GIAB-easy|GIAB-easy2| ENCODE  |umap-k100| pm151   | pm151a  |HG002-Q100|HG002-GIAB|
|:-------------------|--------:|---------:|--------:|--------:|--------:|--------:|---------:|---------:|
|Size (Gb)           |2.31     |2.31      |2.83     |2.82     |2.55     |2.59     |2.74      |2.54      |
|# blocks            |4.84M    |4.84M     |731      |242k     |1.20M    |299k     |28.7k     |481k      |
|N50 block length    |860      |860       |16.1M    |142k     |4158     |22.9k    |183k      |11.2k     |
|% GRCh38            |79.0     |90.0      |96.8     |96.7     |87.2     |88.7     |93.7      |87.0      |
|% GenCode CDS       |72.6     |92.0      |98.5     |97.6     |92.0     |92.3     |95.8      |91.8      |
|% ClinVar patho     |77.4     |95.6      |99.8     |99.6     |95.1     |95.8     |98.8      |90.2      |
-->
