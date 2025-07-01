set t po eps enhance co so "Helvetica, 18"

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
set ylab "%excluded" off +.0
set yran [0:30]; set ytics 5
set lmargin 8
#set bmargin
set border 2
plot \
	"13cov.txt" u (100-$2/2923717335*100):xtic(1) t "GRCh38 non-gap", \
	""          u (100-$3/33797803*100):xtic(1) t "GenCode CDS", \
	""          u (100-$4/308259*100):xtic(1) t "ClinVar pathogenic"
