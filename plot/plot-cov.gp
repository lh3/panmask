set t po eps enhance co so "Helvetica, 18"

set size 1.2,1
set pointsize 2.5

set xran [0:*]
set yran [0:*]

set out "cov.eps"

set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set tics nomirror
set boxwidth 0.7

set xtic rotate by -45 scale 0
set ylab "% excluded" off +.0
set yran [0:30]; set ytics 5
set lmargin 8
#set bmargin
set border 2
plot \
	"<grep -v ens 13cov.txt" u (100-$2/2923717335*100):xtic(1) t "GRCh38 non-gap", \
	""          u (100-$7/5672139*100):xtic(1) t "gnomAD SNPs (AF{/Symbol \263}10%)", \
	""          u (100-$3/33797803*100):xtic(1) t "GenCode CDS", \
	""          u (100-$4/308259*100):xtic(1) t "ClinVar pathogenic"

set out "indel.eps"
set yran [0:1.4]
set ytics 0.2; set mytics 4
set ylab "Variant density relative to HG002-Q100"
plot \
	"<grep -v ens 13cov.txt" u ($6/$2/0.0013356235559586916):xtic(1) t "SNP", \
	"" u ($5/$2/0.00031596273202172897):xtic(1) t "Indel", \
	1 not with lines linetype 2 linecolor "#202020" lw 1.5 dashtype "."
