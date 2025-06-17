####################
# General comments #
####################

# This Makefile is written for human472 *ONLY*
# which consists of 472 genomes including 354 chrX and 120 chrY
#
# This Makefile requires multiple input files you have to manually prepare.
# Most input files, except the BED file for pseudoautomsomal regions (PAR),
# can be generated from a reference FASTA and the ropebwt3 indices. The GRCh38
# section below shows the command lines. You additionally need to put bedtk,
# seqtk, bgzip and k8 on $PATH.
#
# run with "make -f thisFile.mak -j 8 build=hg38"

build=hg38

# put these executable in the working directory
rb3tools=./rb3tools.js
sdust=./sdust

# count thresholds for autosomes/PARs, non-PAR chrX and non-PAR chrY, respectively
thres_ap=477
thres_x=358
thres_y=122

##########
# GRCh38 #
##########

ifeq ($(build), hg38)
prefix=hg38.pm401
ref_fa=hg38.fa
ref_par=hg38.PAR.bed          # this is the only file that can't be generated from the reference or the pangenome
e2e_pan=hg38.472-k401.e2e.gz  # ropebwt3 fa2kmer -k401 -w10 hs38.fa | ropebwt3 sw --all -t64 -N100 human472.fmd - 2> hg38.472-k401.e2e.log | gzip > hg38.472-k401.e2e.gz
e2e_ref=hg38.hg38-k401.e2e.gz # ropebwt3 fa2kmer -k401 -w10 hs38.fa | ropebwt3 sw --all -t64 -N100 GRCh38.fmd - 2> hg38.hg38-k401.e2e.log | gzip > hg38.hg38-k401.e2e.gz

#############
# T2T-CHM13 #
#############

else
ifeq ($(build), chm13)
prefix=chm13.pm401
ref_fa=chm13v2.fa
ref_par=chm13v2.PAR.bed
e2e_pan=chm13.472-k401.e2e.gz
e2e_ref=chm13.chm13-k401.e2e.gz

endif
endif

.PHONY: all

all: $(prefix)a.easy.bed.gz $(prefix)b.easy.bed.gz

$(prefix).ref-gap.bed.gz:$(ref_fa)
	seqtk gap -l1 $< | bgzip > $@

$(prefix).ref-chr.bed:$(ref_fa)
	seqtk comp $< | awk '$$1~/^chr([0-9]+|[XY])$$/{print $$1"\t0\t"$$2}' > $@

$(prefix).ref-dust.bed.gz:$(ref_fa)
	$(sdust) -t 30 $< | bgzip > $@

$(prefix).flt$(thres_ap).bed.gz:$(e2e_ref) $(e2e_pan)
	$(rb3tools) mapflt2 -r5 -p9 $(thres_ap) $(e2e_ref) $(e2e_pan) | bgzip > $@

$(prefix).flt$(thres_x).bed.gz:$(e2e_ref) $(e2e_pan)
	$(rb3tools) mapflt2 -r5 -p9 $(thres_x) $(e2e_ref) $(e2e_pan) | bgzip > $@

$(prefix).flt$(thres_y).bed.gz:$(e2e_ref) $(e2e_pan)
	$(rb3tools) mapflt2 -r5 -p9 $(thres_y) $(e2e_ref) $(e2e_pan) | bgzip > $@

$(prefix).flt$(thres_ap)ap.bed.gz:$(prefix).flt$(thres_ap).bed.gz $(prefix).ref-chr.bed $(ref_par)
	(grep ^chr[0-9] $(prefix).ref-chr.bed; grep ^chrX $(ref_par)) | bedtk isec - $(prefix).flt$(thres_ap).bed.gz | bgzip > $@

$(prefix).flt$(thres_x)x.bed.gz:$(prefix).flt$(thres_x).bed.gz $(prefix).ref-chr.bed $(ref_par)
	bedtk sub $(prefix).ref-chr.bed $(ref_par) | grep ^chrX | bedtk isec - $(prefix).flt$(thres_x).bed.gz | bgzip > $@

$(prefix).flt$(thres_y)y.bed.gz:$(prefix).flt$(thres_y).bed.gz $(prefix).ref-chr.bed $(ref_par)
	bedtk sub $(prefix).ref-chr.bed $(ref_par) | grep ^chrY | bedtk isec - $(prefix).flt$(thres_y).bed.gz | bgzip > $@

$(prefix)a.hard.bed.gz:$(prefix).flt$(thres_ap)ap.bed.gz $(prefix).flt$(thres_x)x.bed.gz $(prefix).flt$(thres_y)y.bed.gz $(prefix).ref-gap.bed.gz
	(gzip -dc $(prefix).flt{$(thres_ap)ap,$(thres_x)x,$(thres_y)y}.bed.gz $(prefix).ref-gap.bed.gz) | awk '$$1~/^chr([0-9]+|[XY])$$/' | bedtk merge | awk '$$3-$$2>151' | bgzip > $@

$(prefix)a.easy.bed.gz:$(prefix)a.hard.bed.gz $(prefix).ref-chr.bed
	bedtk sub $(prefix).ref-chr.bed $(prefix)a.hard.bed.gz | bgzip > $@

$(prefix)b.easy.bed.gz:$(prefix)a.easy.bed.gz $(prefix).ref-dust.bed.gz
	gzip -dc $(prefix).ref-dust.bed.gz | awk '$$3-$$2>=31' | bedtk sub $(prefix)a.easy.bed.gz - | bgzip > $@
