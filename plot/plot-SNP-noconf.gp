set t po eps enhance co so "Helvetica, 18"

set pointsize 2.5

set xran [0:*]
set yran [0:*]

set out "eval-SNP-noconf.eps"
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
set origin 0,0.6
set size 1,.45
set yran [0:12]; set ytics 2
set lmargin 8
set bmargin 0
set ylab "SNP %FDR" off +.0
set border 3
unset xtics
plot \
	"<(grep DeepVariant 12eval.txt|egrep 'HG002-GIAB|Q100|noconf'; grep DeepVariant.*easy2 12eval.txt)" u 5:xtic(4) t "DeepVariant", \
	"<(grep Streka 12eval.txt|egrep 'HG002-GIAB|Q100|noconf'; grep Streka.*easy2 12eval.txt)"           u 5:xtic(4) t "Streka2", \
	"<(grep Octopus 12eval.txt|egrep 'HG002-GIAB|Q100|noconf'; grep Octopus.*easy2 12eval.txt)"         u 5:xtic(4) t "Octopus", \
	"<(grep GATK 12eval.txt|egrep 'HG002-GIAB|Q100|noconf'; grep GATK.*easy2 12eval.txt)"               u 5:xtic(4) t "GATK4"

unset label

# bottom left
set origin 0,0.00
set size 1,.60
set xtic rotate by -45 scale 0
set ylab "SNP %FNR" off +.0
set yran [12:0]; set ytics 2
set tmargin 0
set bmargin
set border 2
plot \
	"<(grep DeepVariant 12eval.txt|egrep 'HG002-GIAB|Q100|noconf'; grep DeepVariant.*easy2 12eval.txt)" u 6:xtic(4) not, \
	"<(grep Streka 12eval.txt|egrep 'HG002-GIAB|Q100|noconf'; grep Streka.*easy2 12eval.txt)"           u 6:xtic(4) not, \
	"<(grep Octopus 12eval.txt|egrep 'HG002-GIAB|Q100|noconf'; grep Octopus.*easy2 12eval.txt)"         u 6:xtic(4) not, \
	"<(grep GATK 12eval.txt|egrep 'HG002-GIAB|Q100|noconf'; grep GATK.*easy2 12eval.txt)"               u 6:xtic(4) not
