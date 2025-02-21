ropebwt3 fa2kmer -k151 -w10 hs38.fa | ropebwt3 sw --all -t64 -N100 human472.fmd - 2> hg38.472-k151.e2e.log | gzip > hg38.472-k151.e2e.gz
ropebwt3 fa2kmer -k151 -w10 hs38.fa | ropebwt3 sw --all -t64 -N100 GRCh38.fmd - 2> hg38.hg38-k151.e2e.log | gzip > hg38.hg38-k151.e2e.gz

# 472 genomes; 354 chrX; 120 chrY

./rb3tools.js mapflt 1 hg38.hg38-k151.e2e.gz | bgzip > hg38.hg38-k151.flt1.bed.gz
./rb3tools.js mapflt 477 hg38.472-k151.e2e.gz | bgzip > hg38.472-k151.flt477.bed.gz
./rb3tools.js mapflt 358 hg38.472-k151.e2e.gz | bgzip > hg38.472-k151.flt358.bed.gz
./rb3tools.js mapflt 121 hg38.472-k151.e2e.gz | bgzip > hg38.472-k151.flt121.bed.gz

genmap map -I hs38.genmap -O hg38-K151E4 -K 151 -E 4 --bedgraph -T 64
zcat hg38-K151E4.bed.gz | awk '$4<1{print $1"\t"$2"\t"$3+150}' | bgzip > hg38.genmap.flt1.bed.gz

echo -e 'chrY\t2781479\t56887902'  | bedtk isec - hg38.472-k151.flt121.bed.gz | bgzip > hg38.472-k151.flt121y.bed.gz
echo -e 'chrX\t2781479\t155701382' | bedtk isec - hg38.472-k151.flt358.bed.gz | bgzip > hg38.472-k151.flt358x.bed.gz
echo -e 'chrX\t0\t2781479\nchrX\t155701382\t156030895' | bedtk isec - hg38.472-k151.flt477.bed.gz | bgzip > hg38.472-k151.flt477p.bed.gz
echo -e 'chrX\t0\t156040895\nchrY\t0\t57217415' | bedtk sub hg38.472-k151.flt477.bed.gz - | bgzip > hg38.472-k151.flt477a.bed.gz

(zcat hg38.472-k151.flt{121y,358x,477p,477a}.bed.gz hg38.*.flt1.bed.gz; cat GRCh38.gap.bed)|awk '$1~/^chr([0-9]+|[XY])$/'|bedtk merge|awk '$3-$2>151'|sort-alt -k1,1N -k2,2n|bgzip > hg38.472-k151.excl.bed.gz
awk '$1~/^chr([0-9]+|[XY])$/{print $1"\t0\t"$2}' hs38.fa.fai | bedtk sub - hg38.472-k151.excl.bed.gz | bgzip > hg38.472-k151.incl.bed.gz
