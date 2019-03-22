## IBM 709 Diagnostic programs.

Here is a collection of IBM 709 diagnostic programs. Use "make" to rebuild the binary
files. The "mkpdf" utility will rebuild the PDF copies of the diagnostics. To rebuild
diagnostics without "mkpdf" use "make decks". The "i7090" simulator must be in your
path.

    
Volume  |Diag   |Description
--------|-------|------------
1       |9LD01  |Loader 
        |9LD02  |  
1       |9M01B  |Cpu main diag  
1       |9M02A  |Cpu main diag  
1       |9M03A  |Indexing test  
1       |9M04A  |Indirect test  
1       |9M05B  |Floating point test  
2       |9M06A  |9M01B manual load.  
2       |9M08A  |Float test 2  
2       |9M10A  |Instruction count test.  
2       |9M21A  |Main frame test.  
2       |9S01HA |Combined storage test  
        |9S01L  |  
2       |9S02H  |Core compliment test.  
        |9S02L  |  
2       |9S03H  |Half select beat  
        |9S03L  |  
2       |9S04H  |Half select beat  
        |9S04L  |  
2       |9S05H  |Core compliment test.  
        |9S05L  |  
2       |9S10A  |Test for walking core in 738 core on 709  
3       |9COMB  |Compatiblity test  
3       |9T01A  |Tape test  
3       |9T02B  |Buffer tape test  
3       |9T03A  |Tape multi channel test  
3       |9T04A  |Tape interchange test  
3       |9T05A  |Tape inter-record gap  
3       |9T10A  |Write diag to tape  
3       |9LREW  |Low Rewind  
3       |9HREW  |High Rewind  
3       |9T11A  |Read diag from tape  
3       |9B01A  |Buffer test  
3       |9B02A  |Diag mode test  
3       |9B03A  |Worst case timing.  
4       |9C01A  |Card reader diag  
4       |9D01A  |Drum diags  
4       |9R01A  |Card punch test, ripple and rand number  
4       |9P01C  |Printer test 9p01.1 9p01.2  
4       |9P02A  |Printer interrow timing test  
5       |9IOMA  |I/O control program.  
        |9IOMB  |I/O control program.  
        |9IOMC  |I/O control program.  
5       |9DEPRA |Program monitor  
5       |9V01A  |CRT display diag  
5       |9SY1A  |Reliabilty test  
5       |9PAC   |Program accounting.  
5       |9MLTA  |Eight sense lights  
5       |9A01A  |Test for real time controls  
5       |9SWA   |Test for six additional sense switchs  
5       |9CNPA  |Consecutive number punch test  
*       |9CNPB  |Consecutive number punch test  
5       |9DRSA  |Drop ready and test ready status  
5       |9IOTA  |Data sync trap  
6       |9C02A  |Card reader timing  
6       |9DD1A  |Direct data device  
6       |9ESLA  |Extended floating point test  
6       |9EFPA  |Extended floating point test 2  
6       |9GLTA  |Gapless tape operations  
None    |9DEPRX |Program monitor New version  
None    |9COMX  |9COM New version  
None    |9B53B  |9B53B  
None    |9DAP   |9Diagnostics Assembler Program  
None    |BOC    |Bootstrap loader.  


