#
# Make diagnostics programs

.SUFFIXES: .asm .obj .lst .img .cbn .pdf .ctl .dck .tap

.asm.cbn: mkbcdtape listtape 9dap.tap
	rm -f $@ sysou1.tap syspun.cbn sysut1.tap
	./mkbcdtape -o sysin.tap -b1 $<
	i7090 asm.ini	
	mv syspun.cbn $@
	./listtape -m sysou1.tap > $*.lst
	rm sysou1.tap sysut1.tap sysin.tap

.ctl.pdf:
	./mkpdf -v $<

all: mkbcdtape listtape mkdeck 9dap.tap \
     9a01a.pdf 9b01a.pdf 9b02a.pdf 9b03b.pdf 9c01a.pdf 9c02a.pdf 9cnpa.pdf \
     9cnpb.dck 9comb.pdf 9d01a.pdf 9dd1a.pdf 9depra.pdf 9deprx.pdf 9drsa.pdf \
     9efpa.pdf 9esla.pdf 9ioma.pdf 9iota.pdf 9ld01a.pdf \
     9m01b.pdf 9m02a.pdf 9m03a.pdf 9m04a.pdf 9m05b.pdf 9m06a.pdf 9m08a.pdf \
     9m10a.pdf 9m21a.pdf 9mlta.pdf 9pacc.pdf 9r01a.pdf 9p01c.pdf 9p02a.pdf \
     9s01hl.pdf 9s02hl.pdf 9s03hl.pdf 9s04hl.pdf 9s05hl.pdf 9s10a.pdf \
     9sy1a.pdf 9swa.pdf 9v01a.pdf 9b53b.pdf 9glta.dck xcomc.pdf  \
     9t01a.pdf 9t02b.pdf 9t03a.pdf 9t04a.pdf 9t05a.pdf 9t10a.pdf 9t11a.pdf

decks: mkbcdtape listtape mkdeck 9dap.tap \
     9a01a.dck 9b01a.dck 9b02a.dck 9b03b.dck 9c01a.dck 9c02a.dck 9cnpa.dck \
     9cnpb.dck 9comb.dck 9d01a.dck 9dd1a.dck 9drsa.dck 9efpa.dck 9esla.dck \
     9iota.dck 9m01b.dck 9m02a.dck 9m03a.dck 9m04a.dck 9m05b.dck \
     9m08a.dck \
     9m10a.dck 9m21a.dck 9mlta.dck 9pacc.dck 9r01a.dck 9p01c.dck 9p02a.dck \
     9s01ha.dck 9s01la.dck 9s02ha.dck 9s02la.dck 9s03ha.dck 9s03la.dck 9s04ha.dck 9s04la.dck 9s05ha.dck 9s05la.dck 9s10a.dck \
     9sy1a.dck 9swa.dck 9v01a.dck 9b53b.dck 9glta.dck xcomc.dck \
     9t01a.dck 9t02b.dck 9t03a.dck 9t04a.dck 9t05a.dck 9t10a.dck 9t11a.dck 

mkdeck: mkdeck.c
	cc -o $@ $^

mkbcdtape: mkbcdtape.c
	cc -o $@ $^

listtape: listtape.c
	cc -o $@ $^

9dap.dck: boc.cbn 9dap.cbn
	./mkdeck -i -o $@ $^

9dap.tap: 9dap.dck
	i7090 9dap.ini

9dap.pdf: 9dap.ctl 9dap.dck

9dap.cbn: 9dap.asm 9ap.bcd mkbcdtape listtape
	rm -f $@ sysou1.tap syspun.cbn sysut1.tap
	./mkbcdtape -o sysin.tap -b1 $<
	i7090 9dap_asm.ini	
	mv syspun.cbn $@
	./listtape sysou1.tap > $*.lst
	rm sysou1.tap sysut1.tap sysin.tap

boc.cbn: boc.src 9ap.bcd mkbcdtape listtape mkdeck
	rm -f $@ sysou1.tap syspun.cbn sysut1.tap
	./mkbcdtape -o sysin.tap -b1 $<
	i7090 boc_asm.ini	
	./mkdeck -o $@ syspun.cbn
	./listtape sysou1.tap > $*.lst
	rm sysou1.tap sysut1.tap sysin.tap
	
blank.cbn: mkdeck
	./mkdeck -o $@ -b

9a01a.pdf: 9a01a.ctl 9a01a.dck 9a01a.cbn 9a01a.txt \
	9a01a-1.png 9a01a-2.png 9a01a-3.png 

9a01a.dck: 9ld01a.cbn 9a01a.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9b01a.pdf: 9b01a.ctl 9b01a.dck 9b01a.cbn 9b01a.txt \
	9b01a-0.png 9b01a-1.png 9b01a-2.png 

9b01a.dck: 9ld01a.cbn 9b01a.cbn 9ioma.cbn 9depra.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9b02a.pdf: 9b02a.ctl 9b02a.dck 9b02a.cbn 9b02a.txt 

9b02a.dck: 9ld01a.cbn 9b02a.cbn 9depra.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9b03b.pdf: 9b03b.ctl 9b03b.dck 9b03b.cbn 9b03b.txt \
	9b03b-0.png 9b03b-1.png

9b03b.dck: 9ld01a.cbn 9b03b.cbn 9depra.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9b53b.pdf: 9b53b.ctl 9b53b.dck 9b53b.cbn 9ioca.cbn 9b53b.txt 

9b53b.dck: 9ld01a.cbn 9b53b.cbn 9ioca.cbn 9deprx.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9c01a.pdf: 9c01a.ctl 9c01a.dck 9c01a.cbn 9c01a.txt \
	9c01a-1.png 9c01a-2.png 9c01a-3.png

9c01a.dck: 9ld01a.cbn 9c01a.cbn 9ioma.cbn 9depra.cbn 9c0x_test.dck
	./mkdeck -l `basename $@ .dck`000 -s -o $@ 9ld01a.cbn 9c01a.cbn 9ioma.cbn \
		 9depra.cbn -t 030 9c0x_test.dck -b -B

9c02a.pdf: 9c02a.ctl 9c02a.dck 9c02a.cbn 9c02a.txt 

9c02a.dck: 9ld01a.cbn 9c02a.cbn 9ioma.cbn 9depra.cbn 9c0x_test.dck
	./mkdeck -l `basename $@ .dck`000 -s -o $@ 9ld01a.cbn 9c02a.cbn 9ioma.cbn \
		9depra.cbn -t 030 9c0x_test.dck -b -B

9c0x_test.dck: 9c0x_test.cbn
	./mkdeck -o $@_1 $^ $^ $^ $^ $^ $^ $^ $^ $^ $^
	./mkdeck -o $@_2 $@_1 $@_1 $@_1 $@_1 $@_1 $@_1 $@_1 $@_1 $@_1 $@_1
	./mkdeck -o $@ $@_2 $@_2 $@_2 
	rm -f $@_1 $@_2

9comb.pdf: 9comb.ctl 9comb.dck 9comb.txt 9comb-1.png 9comb-2.png \
	 9comb-3.png 9comb-4.png 9comb-5.png

9comb.dck: 9comb.cbn 
	cat $^ > $@ 

9cnpa.pdf: 9cnpa.ctl 9cnpa.dck 9cnpa.cbn 9cnpa.txt \
	9cnpa-1.png 9cnpa-2.png

9cnpa.dck: 9ld01a.cbn 9cnpa.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9cnpb.dck: 9ld01a.cbn 9cnpb.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9d01a.pdf: 9d01a.ctl 9d01a.dck 9d01a.cbn 9d01a.txt \
	9d01a-1.png 9d01a-2.png 9d01a-3.png 9d01a-4.png \
	9d01a-5.png 9d01a-6.png

9d01a.dck: 9ld01a.cbn 9d01a.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9dd1a.pdf: 9dd1a.ctl 9dd1a.dck 9dd1a.cbn 9dd1a.txt \
	9dd1a-0.png 9dd1a-1.png 9dd1a-2.png 9dd1a-3.png \
	9dd1a-4.png 9dd1a-5.png 9dd1a-6.png

9dd1a.dck: 9ld01a.cbn 9dd1a.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 02271 -b -B

9depra.pdf: 9depra.ctl 9depra.cbn 9depra.txt 9depr-1.png

9deprx.pdf: 9deprx.ctl 9deprx.cbn 9deprx.txt 9deprx-0.png 9deprx-1.png \
	9deprx-2.png 9deprx-3.png 9deprx-6.png

9drsa.pdf: 9drsa.ctl 9drsa.dck 9drsa.cbn 9drsa.txt \
	9drsa-1.png 9drsa-2.png 9drsa-3.png

9drsa.dck: 9ld01a.cbn 9drsa.cbn 9iomc.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9efpa.pdf: 9efpa.ctl 9efpa.dck 9efpa.cbn 9efpa.txt 9efpa-1.png 9efpa-2.png

9efpa.dck: 9ld02a.cbn 9efpa.cbn 9depra.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 05211 -b -B 

9esla.pdf: 9esla.ctl 9esla.dck 9esla.cbn 9esla.txt 9esla.png

9esla.dck: 9ld02a.cbn 9esla.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 00767 -b -B 

9ld01a.pdf: 9ld01a.ctl 9ld01a.cbn 9ld02a.cbn 9ld01a.txt 

9ioma.pdf: 9ioma.ctl 9ioma.cbn 9ioma.txt 9ioma.png

9iota.pdf: 9iota.ctl 9iota.dck 9iota.cbn 9iota.txt 9iota-0.png \
	  9iota-1.png 9iota-2.png 9iota-3.png 9iota-4.png

9iota.dck: 9ld01a.cbn 9iota.cbn 9ioma.cbn 9depra.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 05115 -b -B

9m01b.pdf: 9m01b.ctl 9m01b.dck 9m01b.cbn 9m01b.txt \
	9m01b-0.png 9m01b-1.png 9m01b-2.png 9m01b-3.png

9m01a.dck: 9ld01a.cbn 9m01a.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9m01b.dck: 9ld01a.cbn 9m01b.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9m02a.pdf: 9m02a.ctl 9m02a.dck 9m02a.cbn 9m02a.txt 9m02a-1.png 9m02a-2.png

9m02a.dck: 9ld02a.cbn 9m02a.cbn 9depra.cbn fastmpy.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ 9ld02a.cbn 9m02a.cbn 9depra.cbn \
		 -t 030 fastmpy.cbn -b -B

9m03a.pdf: 9m03a.ctl 9m03a.dck 9m03a.cbn 9m03a.txt 9m03a-1.png 9m03a-2.png 

9m03a.dck: 9ld02a.cbn 9m03a.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 06734 -b -B

9m04a.pdf: 9m04a.ctl 9m04a.dck 9m04a.cbn 9m04a.txt

9m04a.dck: 9ld01a.cbn 9m04a.cbn 9depra.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9m05b.pdf: 9m05b.ctl 9m05b.dck 9m05b.cbn 9m05b.txt 9m05b-1.png 9m05b-2.png 

9m05b.dck: 9ld02a.cbn 9m05b.cbn 9depra.cbn
	./mkdeck -o 9m05b-1.cbn -e 155 9m05b.cbn
	./mkdeck -o 9m05b-2.cbn -f 156 9m05b.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ 9ld02a.cbn 9m05b-1.cbn \
		9depra.cbn 9m05b-2.cbn -t 06315 -t 06341 -b \
		-c 06316 076100000000 -c 07714 076100000000 -b -B

9m06a.pdf: 9m06a.ctl 9m06a.cbn 9m06a.txt 9m06a-0.png

9m08a.pdf: 9m08a.ctl 9m08a.cbn 9m08a.dck 9m08a.txt

9m08a.dck: 9ld02a.cbn 9m08a.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -a 9m08a.data -b -B

9m10a.dck: 9m10a.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -b -B

9m10a.pdf: 9m10a.ctl 9m10a.cbn 9m10a.txt

9m21a.pdf: 9m21a.ctl 9m21a.dck 9m21a.txt 9m21a-0.png 9m21a-1.png 9m21a-2.png

9m21a.dck: 9ld02a.cbn 9m21a.cbn 9depra.cbn fastmpy.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ 9ld02a.cbn 9m21a.cbn 9depra.cbn \
		 -t 030 fastmpy.cbn -b -B

9mlta.pdf: 9mlta.ctl 9mlta.dck 9mlta.cbn 9mlta.txt

9mlta.dck: 9ld01a.cbn 9mlta.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9pacc.pdf: 9pacc.ctl 9pacc.dck 9pacc.cbn 9pacc.txt 9pacc-0.png

9pacc.dck: 9ld01a.cbn 9pacc.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 01625 -b -B

9r01a.pdf: 9r01a.ctl 9r01a.dck 9r01a.cbn 9r01a.txt 9r01a-0.png 9r01a-1.png

9r01a.dck: 9ld01a.cbn 9r01a.cbn 9ioma.cbn 9depra.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9p01c.pdf: 9p01c.ctl 9p01c.dck 9p01c.cbn 9p01c.txt 9p01c-0.png 9p01c-1.png

9p01c.dck: 9ld01a.cbn 9p01c.cbn 
	./mkdeck -o 9p01c-1.cbn -f 171 -e 225 9p01c.cbn -t 012256
	./mkdeck -l `basename $@ .dck`000 -s -o $@ 9ld01a.cbn -e 169 9p01c.cbn \
	    -t 07754 9p01c-1.cbn -b -B

9p02a.pdf: 9p02a.ctl 9p02a.dck 9p02a.cbn 9p02a.txt 9p02a-0.png 9p02a-1.png

9p02a.dck: 9ld01a.cbn 9p02a.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9s01hl.pdf: 9s01hl.ctl 9s01ha.dck 9s01la.dck 9s01ha.cbn 9s01la.cbn 9s01hl.txt \
	9s01hl-0.png 9s01hl-1.png 9s01hl-2.png

9s01ha.dck: 9ld02a.cbn 9s01ha.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 0275 -b -B

9s01la.dck: 9ld01a.cbn 9s01la.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 077337 -b -B

9s02hl.pdf: 9s02hl.ctl 9s02ha.dck 9s02la.dck 9s02ha.cbn 9s02la.cbn 9s02hl.txt \
	9s02hl-0.png 9s02hl-1.png

9s02ha.dck: 9ld02a.cbn 9s02ha.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 0207 -b -B

9s02la.dck: 9ld01a.cbn 9s02la.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 077463 -b -B

9s03hl.pdf: 9s03hl.ctl 9s03ha.dck 9s03la.dck 9s03ha.cbn 9s03la.cbn 9s03hl.txt \
	9s03hl-0.png 9s03hl-1.png

9s03ha.dck: 9ld02a.cbn 9s03ha.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 0175 -b -B

9s03la.dck: 9ld01a.cbn 9s03la.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 017520 -b -B

9s04hl.pdf: 9s04hl.ctl 9s04ha.dck 9s04la.dck 9s04ha.cbn 9s04la.cbn 9s04hl.txt \
	9s04hl-0.png 9s04hl-1.png

9s04ha.dck: 9ld02a.cbn 9s04ha.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 0 

9s04la.dck: 9ld01a.cbn 9s04la.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 076000 -b -B

9s05hl.pdf: 9s05hl.ctl 9s05ha.dck 9s05la.dck 9s05ha.cbn 9s05la.cbn 9s05hl.txt \
	9s05hl-0.png 9s05hl-1.png 9s05hl-2.png 9s05hl-3.png

9s05ha.dck: 9ld02a.cbn 9s05ha.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 0 

9s05la.dck: 9ld01a.cbn 9s05la.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 076100 -b -B

9s10a.dck: 9s10a.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -b -B

9s10a.pdf: 9s10a.ctl 9s10a.cbn 9s10a.txt 

9sy1a.pdf: 9sy1a.ctl 9sy1a.cbn 9sy1a.txt 9sy1a.dck \
	9sy1a-1.png 9sy1a-2.png 9sy1a-3.png 9sy1a-4.png \
	9sy1a-5.png 9sy1a-6.png 9sy1a-7.png 9sy1a-8.png \
	9sy1a-9.png 9sy1a-a.png 9sy1a-b.png 9sy1a-c.png

9sy1a.dck: 9ld01a.cbn 9sy1a.cbn
	./mkdeck -o 9sy1a-1.cbn -e 99 9sy1a.cbn 
	./mkdeck -o 9sy1a-2.cbn -f 100 -e 227 9sy1a.cbn
	./mkdeck -o 9sy1a-3.cbn -f 228 -e 342 9sy1a.cbn
	./mkdeck -o 9sy1a-4.cbn -f 343 -e 345 9sy1a.cbn
	./mkdeck -o 9sy1a-5.cbn -f 346 -e 352 9sy1a.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ 9ld01a.cbn 9sy1a-1.cbn \
		 9sy1a-3.cbn 9sy1a-5.cbn -t 073764 \
		9ld01a.cbn 9sy1a-2.cbn 9sy1a-4.cbn -t 073764 -b -B

9swa.pdf: 9swa.ctl 9swa.dck 9swa.cbn 9swa.txt 9swa-1.png

9swa.dck: 9ld01a.cbn 9swa.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9glta.dck: 9ld01a.cbn 9glta.cbn 9depra.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9t01a.pdf: 9t01a.ctl 9t01a.cbn 9t01a.txt 9t01a.dck 9t01a-0.png

9t01a.dck: 9ld01a.cbn 9t01a.cbn 9ioma.cbn 9depra.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9t02b.pdf: 9t02b.ctl 9t02b.cbn 9t02b.txt 9t02b.dck

9t02b.dck: 9ld01a.cbn 9ioma.cbn 9t02b.cbn 9depra.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9t03a.pdf: 9t03a.ctl 9t03a.cbn 9t03a.txt 9t03a.dck 9t03a-0.png

9t03a.dck: 9ld01a.cbn 9t03a.cbn 9ioma.cbn 9depra.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9t04a.pdf: 9t04a.ctl 9t04a.cbn 9t04a.txt 9t04a.dck

9t04a.dck: 9ld01a.cbn 9t04a.cbn 9ioma.cbn 9depra.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9t05a.pdf: 9t05a.ctl 9t05a.cbn 9t05a.txt 9t05a.dck \
	9t05a-0.png  9t05a-1.png  9t05a-2.png  9t05a-3.png 

9t05a.dck: 9ld01a.cbn 9t05a.cbn 9ioma.cbn 9depra.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9t10a.pdf: 9t10a.ctl 9t10a.dck 9t10a.cbn 9lrew.cbn 9hrew.cbn  \
	9t10a-0.png 9t10a-1.png 9t10a-2.png 9t10a-3.png

9t10a.dck: 9ld01a.cbn 9t10a.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 

9t11a.pdf: 9t11a.ctl 9t11a.dck 9t11a.cbn 9t11a-0.png

9t11a.dck: 9ld01a.cbn 9t11a.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030 -b -B

9v01a.pdf: 9v01a.ctl 9v01a.dck 9v01a.cbn 9v01a.txt

9v01a.dck: 9ld01a.cbn 9v01a.cbn 
	./mkdeck -l `basename $@ .dck`000 -s -o $@ $^ -t 030  -b -B

xcomc.pdf: xcomc.ctl xcomc.dck xcomc.cbn xcomc.txt

xcomc.dck: 9ld02a.cbn 9m05b.cbn 9depra.cbn xcomc.cbn 
	./mkdeck -o 9m05b-1.cbn -e 155 9m05b.cbn
	./mkdeck -o 9m05b-2.cbn -f 156 9m05b.cbn
	./mkdeck -l `basename $@ .dck`000 -s -o $@ 9ld02a.cbn 9m05b-1.cbn \
		9depra.cbn 9m05b-2.cbn xcomc.cbn -t 12243  -b -B

clean:
	rm *.lst *.cbn *.pdf *.dck mkdeck listtape mkbcdtape

