set t po eps enhance co so "Helvetica, 18"

set pointsize 2.5

set xran [0:*]
set yran [0:*]

set out "eval-INDEL.eps"
set size 1,1.1

set multiplot layout 4,4

reset
#set style line 1 pt 4 lc rgb "#b80033" lw 2
#set style line 3 pt 41 lc rgb "#009cfe" lw 2
#set style line 2 pt 6 lc rgb "#00bf5b" lw 2
set auto x
set style data histogram
set style histogram cluster gap 1
set style fill solid
set tics nomirror
set boxwidth 0.7

set key top left

# top left
set origin 0,0.63
set size 1,.45
set yran [0:3]; set ytics 1
set mytics 5
set lmargin 8
set bmargin 0
set ylab "INDEL %FDR" off -.5
set border 3
unset xtics
plot \
	"<grep DeepVariant 12eval.txt | egrep -v 'All-chr|ENCODE|Umap|ens'" u 7:xtic(4) not, \
	"<grep Strelka2 12eval.txt | egrep -v 'All-chr|ENCODE|Umap|ens'"      u 7:xtic(4) not, \
	"<grep Octopus 12eval.txt | egrep -v 'All-chr|ENCODE|Umap|ens'"     u 7:xtic(4) not, \
	"<grep GATK 12eval.txt | egrep -v 'All-chr|ENCODE|Umap|ens'"        u 7:xtic(4) not

unset label

# bottom left
set origin 0,0.00
set size 1,.63
set xtic rotate by -45 scale 0
set ylab "INDEL %FNR" off +.5
set yran [14:0]; set ytics 2
set mytics 2
set tmargin 0
set bmargin
set border 2
plot \
	"<grep DeepVariant 12eval.txt | egrep -v 'All-chr|ENCODE|Umap|ens'" u 8:xtic(4) not, \
	"<grep Strelka2 12eval.txt | egrep -v 'All-chr|ENCODE|Umap|ens'"      u 8:xtic(4) not, \
	"<grep Octopus 12eval.txt | egrep -v 'All-chr|ENCODE|Umap|ens'"     u 8:xtic(4) not, \
	"<grep GATK 12eval.txt | egrep -v 'All-chr|ENCODE|Umap|ens'"        u 8:xtic(4) not
