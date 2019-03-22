                                                             9GLTA
                                                            11-8-59
*NOW PERFORMING 9GLT-A PROGRAM FOR TESTING
*GAPLESS TAPE OPERATION ON THE 709
       ORG 24         
BEGIN  WPRA           
       RCHA PRNT1     PRINT IDENTIFICATION
       CLA POST1,          TRA BEGIN+4
       STO 0          
       REWA 1         REWIND TAPE
       AXT 640,1           RDFLD CT
       STZ RDFLD+640,1     CLEAR RDFLD
       TIX *-1,1,1    
       REM            
       REM            
*TEST ONE CONSISTS OF FIVE FILES.
*EACH FILE CONTAINS DEC640 OCT1200 WORDS.
       REM            
       AXT 5,2             L-5 FILE COUNT
WRTP1  WTBA 1         NON WRITING TEST 1
       RCHA CWD1      640DEC 1200OCT WRD FILE
       TCOA *         
       TSX RDNCK,4            IO CHECK
       NOP BEGIN+4            IO CHECK
       WEFA 1         
       TIX WRTP1,2,1       WR FIVE FILES
       REM            
*TEST ONE WRITTEN     
       REM            
       REM            
*WILL NOW READ AND COMPARE TEST ONE
       REM            
       REWA 1         
       CLA WCNT1           L-641 WORD COUNT+1
       STO WDNO            FOR DEPR ROUTINE
       CLA RECT1      L-6 REC COUNT+1
       STO RECNO           FOR DEPR ROUTINE
       AXT 5,2        L 5
       TRA *+2        
       REM            
       BCD 1RTBA1          READ AND CHK TEST1
       REM            
START  RTBA 1         
       RCHA RDW1      READ FILE
       TCOA *         
       TEFA *-3       
       TSX RDNCK,4          TEST IO CHK
       NOP START      
       AXT 640,1           LOAD WRD CT
       CLA NINE            L-9 GRP1 REPEAT
       STO TEM2       
       AXT 32,4            L-32, GRP WRD CT
       CLA RDFLD+640,1    WORD READ
       LDQ GRP1+32,4      WORD GEN
RDT    CAS GRP1+32,4      COMPARE
       TRA *+2             ERROR GO TO DEPR
       TRA *+5             OK PROCEED
       SXA XRC,4           SAVE XRC
       TSX ERROR-2,4       ERROR GO TO DEPR
       NOP START-8    
       LXA XRC,4           REPLACE XRC
       TIX *+1,1,1         WORD COUNT
       TIX *-10,4,1        GRP WORD CT
       CLA TEM2            L-9 GRP REPEAT
       SUB ONE        
       STO TEM2       
       TZE *+2        
       TRA RDT-3           REP GRP1 9 TIMES
       AXT 32,4       
       CLA RDFLD+640,1    WORD READ
       LDQ GRP2+32,4      WORD GEN
       CAS GRP2+32,4      COMPARE
       TRA *+2             ERROR
       TRA *+5             OK PROCEED
       SXA XRC,4           ERROR
       TSX ERROR-2,4       GO TO DEPR
       NOP 0          
       LXA XRC,4           RESTORE XRC
       TIX *+1,1,1         WORD CT
       TIX *-10,4,1        GRP WRD CT
       TIX START,2,1       REC COUNT
       REM            
*TEST ONE NOW WRITTEN AND CHECKED
*PROCEED TO WRITE TEST TWO
       REM            
       AXT 680,1      
       STZ RDFLD+680,1     CLR RDFLD FOR
       TIX *-1,1,1         TEST TWO
       REM            
*NOW WRITE TEST TWO ON TAPE
*CONSISTS OF ONE FILE OF TEN REC
       REM            
       AXT 10,2            L-10 REC COUNT
       WEFA 1         
WRT2   WTBA 1         
       RCHA CWD2      WRITE ONE REC
       TCOA *         
       TEFA WRT2      
       TSX RDNCK,4    
       NOP WRT2       
       TIX WRT2,2,1        REPEAT REC 10 TIMES
       BSFA 1         BSP ONE FILE
       REM            
*TEST TWO WRITTEN     
*NOW READ ANC CHECK TEST TWO
       REM            
       CLA WCNT2           L-681 WC+1
       STO WDNO            FOR DEPR
       CLA RECT2      L-11 REC+1
       STO RECNO           FOR DEPR
       TRA *+2        
       BCD 1RTBA1          OPER BEING TESTED
RDCK2  RTBA 1         READ ONE REC
       RCHA RDW2      680 DEC - 1250 OCT WRDS
       TCOA *         
       TEFA *-3       TEST END FILE
       TSX RDNCK,4         IO CHECK
       NOP RDCK2      
       AXT 680,1           L-680 WRD COUNT
       AXT 10,2            L-10 REC COUNT
       CLA TWO             L-2 REPEAT CT
       STO TEM3       
       AXT 34,4            L-34 GRP WRD CT
       CLA RDFLD+680,1    WORD READ
       LDQ GRP3+34,4      WORD GEN
RDT2   CAS GRP3+34,4      COMPARE
       TRA *+2             ERROR
       TRA *+5             OK PROCEED
       SXA XRC,4           SAVE XRC
       TSX ERROR-2,4       GO TO DEPR
       NOP RDCK2      
       LXA XRC,4           RESTORE XRC
       TIX *+1,1,1         WORD COUNT
       TIX *-10,4,1        GRP WRD COUNT
       CLA TEM3            L-2 GROUP
       SUB ONE             REPEAT COUNT
       STO TEM3       
       TZE *+2        
       TRA RDT2-3      
       TIX RDT2-5,2,1      REC COUNT
       REM            
       WEFA 1         WR END OF FILE
*TEST TWO NOW WRITTEN AND CHECKED
       REM            
*NOW WRITE TEST THREE 
*CONSISTS OF ONE FILE OF TEN RECORDS
*ONE FOOT OF BLANK TAPE BETWEEN EACH REC
       REM            
       AXT 680,1      
       STZ RDFLD+680,1     CLEAR RDFLD
       TIX *-1,1,1    
       REM            
       AXT 10,2            L-10 REC COUNT
WRT3   WTBA 1         WRITE TAPE
       RCHA CWD3      ONE REC
       TCOA *         
       TEFA *-3       
       AXT 3,1        
       WTBA 1         SPACE TAPE
       TCOA *         
       TIX *-2,1,1    
       TIX WRT3,2,1        WR TEN REC
       BSFA 1         BACKSPACE FILE
       REM            
*TEST THREE NOW WRITTEN
*NOW READ AND CHECK TEST THREE
       REM            
       CLA WCNT3         L 1251
       STO WDNO            FOR DEPR
       CLA RECT3      L-11 REC CT+1
       STO RECNO           FOR DEPR
       TRA *+2        
       BCD 1RTBA1          OPER BEING TESTED
RDCK3  RTBA 1         READ TAPE
       RCHA RDW3      TEN REC
       TCOA *           1250 WORDS
       TEFA *-3       TEST END FILE
       TSX RDNCK,4         IO CHK
       NOP RDCK3      
       REM            
       AXT 680,1           L L       1250 WRDS
       AXT 10,2            L-10 REC COUNT
       CLA TWO        
       STO TEM5       
       AXT 34,4           GRP WORD COUNT
       CLA RDFLD+680,1 
       LDQ GRP3+34,4       WORD GENERATED
RDT3   CAS GRP3+34,4      COMPARE
       TRA *+2             ERROR GO TO DEPR
       TRA *+5             OK PROCEED
       SXA XRC,4           SAVE XRC
       TSX ERROR-2,4       GO TO DEPR
       NOP RDCK3           RETURN FROM DEPR
       LXA XRC,4           RESTORE XRC
       TIX *+1,1,1         WORD COUNT
       TIX *-10,4,1        GRP WRD COUNT
       CLA TEM5            L-2 REPEAT CT
       SUB ONE        
       STO TEM5       
       TZE *+2        
       TRA RDT3-3          REPEAT GRP
       TIX RDT3-5,2,1      REC COUNT
       REM            
       WEFA 1         WR END FILE
*TEST THREE NOW WRITTEN AND CHECKED
*NOW WRITE TEST FOUR  
*EACH REC CONTAINS 66DEC 1020CT WRDS
       REM            
       WTBA 1         WRITE REC 1
       RCHA CWD4      
       WTBA 1         WRITE REC 2
       RCHA CWD5      
       TCOA *         
       REM            
*TAPE TEST FOUR WRITTEN
*NOW READ AND CHECK TEST FOUR
* CONSTIS OF ONE FILE OF TWO RECORDS
       REM            
       BSFA 1         BKSP FILE
       CLA WCNT4           L-331 WRD COUNT+1
       STO WDNO       
       CLA RECT4      L-6 REC COUNT+1
       STO RECNO      
       TRA *+2        
       BCD 1RTBA1          OPER BEING TESTED
RDCK4  RTBA 1         READ 5 REC
       RCHA RDW4           204 OCT WORDS
       TCOA *         
       TEFA *-3       
       TSX RDNCK,4       IO CHK
       NOP RDCK4      
       AXT 132,1         L 132 D
       AXT 2,2             L2 REC CT
       CLA TWO           L-2
       STO TEM4       
       AXT 32,4          L-32 GRP WD CT
       CLA RDFLD+132,1            WORD READ
       LDQ GRP1+32,4    WORD GEN
RDT4   CAS GRP1+32,4        COMPARE
       TRA *+2           ERROR
       TRA *+5           OK PROCEED
       SXA XRC,4      
       TSX ERROR-2,4     ERROR
       NOP RDCK4      
       LXA XRC,4      
       TIX *+1,1,1       WORD COUNT
       TIX *-10,4,1      GRP WD CT
SPEC   CLA RDFLD+132,1          WORD READ
       LDQ GRP5         WORD GEN
       CAS GRP5             COMPARE
       TRA *+2           ERROR
       TRA *+3           OK PROCEED
       TSX ERROR-2,4     ERROR
       NOP RDCK4      
       TIX *+1,1,1       WRD COUNT
       CLA TEM4          L-2
       SUB ONE        
       STO TEM4       
       TZE *+2        
       TRA RDT4-3,    
       CLA SPEC+1     
       ADD ONE        
       STA SPEC+1     
       STA SPEC+2     
       TIX RDT4-5,2,1    REC COUNT
       CLA ADDR       
       STA SPEC+1     
       STA SPEC+2     
       WEFA 1         WR END FILE
       REWA 1         
*TEST FOUR NOW WRITTEN AND CHECKED
       REM            
       REM            
       WPRA           
       RCHA PRNT2     
       TCOA *         
       HTR *+2        
       REM            
       REM            
*WE ARE NOW READY TO TEST READ GAPLESS
*TAPE FEATURE. SET GAPLESS SWITCH AND
*HIT START KEY TO PROCEED.
       REM            
       REM            
       REM            
       BCD 1RTBA1     
 TES1A REWA 1         
*NOW IN GAPLESS MODE. PROCEED TO FIRST GAPLESS TEST.
       CLA POST2      
       STO 0          
       REM            
*THE PURPOSE OF TEST ONE IS TO READ REC-RDS WITH NO
*8MGAPS BETWEEN THEM  
       REM            
       CLA ONE        
       STO FILE       
       REM            
 REP   AXT 640,1      
       STZ RDFLD+640,1      CLEAR RDFLD
       TIX *-1,1,1    
       CLA REDY1            L OCT1201 DEC641
       STO WDNO       
       CLA REDY2            L-3 REC CT+1
       STO RECNO      
       RTBA 1               READ TAPE
       RCHA TWD1             READ DEC 640 OCT 1200
       TCOA *         
       TEFA *-3             TEST END FILE
       TSX RDNCK,4          IO CHECK
 CHNG1 TRA TES1A      
       AXT 640,1            L-1200
       AXT 2,2              L-2
       CLA NINE             L-11
       STO TS1        
       AXT 32,4       
       LDQ GRP1+32,4        CORRECT WORD
       CLA RDFLD+640,1      WRD READ
 CPRA1 CAS GRP1+32,4        COMPARE GRP1
       TRA *+2              ERROR
       TRA *+5              OK PROCEED
       SXA XRC,4      
       TSX ERROR-2,4        ERROR GO TO DEPR
 CHNG2 TRA TES1A            RETURN
       LXA XRC,4      
       TIX *+1,1,1          WRD COUNT
       TIX CPRA1-2,4,1      GRP WRD COUNT
       CLA TS1              REP COUNT
       SUB ONE        
       STO TS1        
       TZE *+2        
       TRA CPRA1-3          REP GROUP
       AXT 32,4             L-40
       CLA RDFLD+640,1      CORRECT WORD
       LDQ GRP2+32,4        WORD READ
 CPRA2 CAS GRP2+32,4        COMPARE GRP2
       TRA *+2              ERROR
       TRA *+5              OK PROCEED
       SXA XRC,4      
       TSX ERROR-2,4        ERROR
 CHNG3 TRA TES1A            RETURN FM DEPR
       LXA XRC,4      
       TIX *+1,1,1          WORD COUNT
       TIX CPRA2-2,4,1      GRP 2 WRD CT
       TIX CPRA1-5,2,1   REC COUNT
       REM                  HAVE CHKED REC 1 AND 2
* THIS CHECKS ONE FILE. LOOP TO CHECK FIVE FILES.
* FILE COUNT IS NOW IN LOCATION FILE
       CLA FILE       
       ADD ONE        
       STO FILE       
       CAS SIX        
       TRA REP        
       TRA *+3        
       TRA REP        
*TEST TWO CHECKS BACKSPACING OVER RECORDS WITH GAPES BETWEEN THEM.
*IT CONSISTS OF 20 GAPLESS MODE RECORDS
       REM            
*THE FIRST ROUTINE WILL READ AND CHECK ALL 20 RECORDS
       BCD 1RTBA1     
 TES1B AXT 680,1      
       STZ RDFLD+680,1    CLEAR RDFLD
       TIX *-1,1,1    
       RTBA 1         
       RCHA TWD3          READ 10 REC
       TCOA *         
       TEFA *-3       
       CLA REDY5      
       STO WDNO       
       CLA REDY6          REC CT+1
       STO RECNO      
       AXT 680,1          L-1250 WC
       AXT 20,2           L-24 REC CT
       AXT 34,4       
       CLA RDFLD+680,1    WORD READ
       LDQ GRP3+34,4      WORD GENERATED
 CPRB1 CAS GRP3+34,4      COMPR GRP3
       TRA *+2            ERROR
       TRA *+5            OK
       SXA XRC,4          STO XR4
       TSX ERROR-2,4      ERROR
       TRA TES1B          RETURN
       LXA XRC,4          RESTORE XR4
       TIX *+1,1,1        WRD CT
       TIX CPRB1-2,4,1    GRP WD CT
       TIX CPRB1-3,2,1    REC CT
       REM                20 REC READ AND CHKED
       REM            
       REM NOW BACKSPACE TWO RECS
       REM AND READ TWO RECORDS
       TRA *+2        
       BCD 1BSRA1     
 GOB1  BSRA 1         
       TCOA *         
       BSRA 1       BKSP 2 RECORDS
       TCOA *         
       AXT 68,1       
       STZ RDFLD+68,1 
       TIX *-1,1,1    
       RTBA 1         
       RCHA BWRD1     
       TCOA *         
       TSX RDNCK,4      IO CHECK
       CLA BREC1      
       STO RECNO      
       CLA BCT1         L 105
       STO WDNO       
       AXT 68,1     WRD COUNT L 104
       AXT 2,2     REC COUNT L 2
       AXT 34,4       
       CLA RDFLD+68,1    WORD READ
       LDQ GRP3+34,4     WORD GENERATED
       CAS GRP3+34,4     COMPARE
       TRA *+2        
       TRA *+5  OK PROCEED
       SXA XRC,4      
       TSX ERROR-2,4     ERROR
       TRA GOB1       
       LXA XRC,4      
       TIX *+1,1,1    
       TIX *-10,4,1   
       TIX *-12,2,1   
*BACKSPACED TWO RECS AND CHECKED OK
       REM                TEST TWO COMPLETED
* PROCEED TO TEST THREE
*TEST THREE CHECKS BACKSPACING OVER RECORDS WHICH
*HAVE LARGE GAPS BETWEEN THEM.
       REM            
       TRA *+2        
       BCD 1RTBA1     
TEST3  AXT 680,1      
       STZ RDFLD+680,1       CLEAR RDFLD
       TIX *-1,1,1    
       CLA DECM2      
       STO WDNO               L 1251
       CLA DECM3             L 21
       STO RECNO      
       RTBA 1             READ TAPE
       RCHA TWD6              1250 WORDS
       TCOA *         
       TEFA *-3           TEST END OF FILE
       TSX RDNCK,4         TEST IO CHK
XCH1   TRA TEST3      
       AXT 680,1              L 1250   WRD CT
       AXT 20,2           L-24 REC CT
       AXT 34,4       
       CLA RDFLD+680,1         WORD READ
       LDQ GRP3+34,4     WORD GENERATED
CPRC1  CAS GRP3+34,4      COMPARE
       TRA *+2            ERROR
       TRA *+5            OK PROCEED
       SXA XRC,4      
       TSX ERROR-2,4      ERROR
XCH2   TRA TEST3      
       LXA XRC,4      
       TIX *+1,1,1        WRD CT
       TIX CPRC1-2,4,1    GRP WC
       TIX CPRC1-3,2,1    REC COUNT
       REM                20 REC NOW CHECKED
       REM            
       REM            
       REM            
       REM                BACKSPACE TWO RECORDS
       REM                AND READ TWO RECORDS
       TRA *+2        
       BCD 1BSRA1     
GOB2   BSRA 1         
       TCOA *         
       BSRA 1         
       TCOA *         
       AXT 68,1       
       STZ RDFLD+68,1 
       TIX *-1,1,1    
       RTBA 1         
       RCHA BWRD1     
       TCOA *         
       TSX RDNCK,4         IO CHECK
       CLA BREC1      
       STO RECNO      
       CLA BCT1          L 105
       STO WDNO       
       AXT 68,1       WRD COUNT L 104
       AXT 2,2       REC COUNT L 2
       AXT 34,4       
       CLA RDFLD+68,1     WORD READ
       LDQ GRP3+34,4      WORD GENERATED
       CAS GRP3+34,4      COMPARE
       TRA *+2        
       TRA *+5  OK PROCEED
       SXA XRC,4      
       TSX ERROR-2,4     ERROR
       TRA GOB2       
       LXA XRC,4      
       TIX *+1,1,1    
       TIX *-10,4,1   
       TIX *-12,2,1   
*BACKSPACED TWO RECS AND CHECKED OK
       REM                 TEST THREE
       REM                 COMPLETED
       REM            
* THE PURPOSE OF TEST FOUR IS TO RECOGNIZE B BITS IN
* DIFFERENT POSITIONS OF A WORD.
* TEST CONSITS OF FOUR RECORDS
*EACH RECORD CONTAINS DEC 33 OCT 41 WORDS
       REM            
       REM            
       TRA *+2        
       BCD 1RTBA1     
 TES1D AXT 132,1      
       STZ RDFLD+132,1 
       TIX *-1,1,1    
       RTBA 1              READ TAPE
       RCHA TWD8          FOUR RECORDS
       TCOA *         
       TEFA *-3                TEST END FILE
       TSX RDNCK,4    
       CLA BWRD2      
       STO WDNO       
       CLA BREC2      
       STO RECNO      
       AXT 132,1      
       AXT 32,4       
       CLA RDFLD+132,1 
       LDQ GRP1+32,4  
 CPRD1 CAS GRP1+32,4  
       TRA *+2             ERROR
       TRA *+5             OK PROCEED
       SXA XRC,4      
       TSX ERROR-2,4       ERROR
       TRA TES1D      
       LXA XRC,4      
       TIX *+1,1,1         WRD CT
       TIX CPRD1-2,4,1 
       AXT 100,4      
DNE6   CLA RDFLD+132,1 
       LDQ GRP6+100,4 
       CAS GRP6+100,4 
       TRA *+2             ERROR
       TRA *+5             OK PROCEED
       SXA XRC,4      
       TSX ERROR-2,4  
       TRA DNE6       
       LXA XRC,4      
       TIX *+1,1,1    
       TIX DNE6,4,1   
*TEST FOUR NOW COMPLETE
       WPRA           
       RCHA CTFIN     
DONE   SWT 5          
       TRA *+2             UP TEST SW 6
       TRA TES1A-2         DN REP GAP TEST
       SWT 6          
       TRA CTRL            UP READ NEXT PRO
       CLA POST1           DN RESTORE PROGRAM
       STO 0               TO RESTART
       HTR 0               SET FEATURE SWITCH
       REM                 TO NORMAL AND
       REM                 PRESS START KEY
CTRL   RCDA           READ
       RCHA *+3       NEXT
       LCHA 0         PROGRAM
       TRA 1          
       IOCT 0,0,3     
GRP1   OCT 000000000000
       OCT 010101010101
       OCT 020202020202
       OCT 030303030303
       OCT 040404040404
       OCT 050505050505
       OCT 060606060606
       OCT 070707070707
       OCT 101010101010
       OCT 111111111111
       OCT 121212121212
       OCT 131313131313
       OCT 141414141414
       OCT 151515151515
       OCT 161616161616
       OCT 171717171717
       OCT 202020202020
       OCT 212121212121
       OCT 222222222222
       OCT 232323232323
       OCT 242424242424
       OCT 252525252525
       OCT 262626262626
       OCT 272727272727
       OCT 303030303030
       OCT 313131313131
       OCT 323232323232
       OCT 333333333333
       OCT 343434343434
       OCT 353535353535
       OCT 363636363636
       OCT 373737373737          
GRP2   OCT 000000000000
       OCT 010101010101
       OCT 020202020202
       OCT 030303030303
       OCT 040404040404
       OCT 050505050505
       OCT 060606060606
       OCT 070707070707
       OCT 101010101010
       OCT 111111111111
       OCT 121212121212
       OCT 131313131313
       OCT 141414141414
       OCT 151515151515
       OCT 161616161616
       OCT 171717171717
       OCT 202020202020
       OCT 212121212121
       OCT 222222222222
       OCT 232323232323
       OCT 242424242424
       OCT 252525252525
       OCT 262626262626
       OCT 272727272727
       OCT 303030303030
       OCT 313131313131
       OCT 323232323232
       OCT 333333333333
       OCT 343434343434
       OCT 353535353535
       OCT 363636363636
       OCT 373737373737
GRP3   OCT 000000000000
       OCT 010101010101
       OCT 020202020202
       OCT 030303030303
       OCT 040404040404
       OCT 050505050505
       OCT 060606060606
       OCT 070707070707
       OCT 101010101010
       OCT 111111111111
       OCT 121212121212
       OCT 131313131313
       OCT 141414141414
       OCT 151515151515
       OCT 161616161616
       OCT 171717171717
       OCT 202020202020
       OCT 212121212121
       OCT 222222222222
       OCT 232323232323
       OCT 242424242424
       OCT 252525252525
       OCT 262626262626
       OCT 272727272727
       OCT 303030303030
       OCT 313131313131
       OCT 323232323232
       OCT 333333333333
       OCT 343434343434
       OCT 353535353535
       OCT 363636363636
       OCT 373737373737
       OCT 000000000000
       OCT 010101010141
GRP5   OCT 000040000000
       OCT 400000000000
GRP6   OCT 000040000000
       OCT 000000000000
       OCT 000000010101
       OCT 010101020202
       OCT 020202030303
       OCT 030303040404
       OCT 040404050505
       OCT 050505060606
       OCT 060606070707
       OCT 070707101010
       OCT 101010111111
       OCT 111111121212
       OCT 121212131313
       OCT 131313141414
       OCT 141414151515
       OCT 151515161616
       OCT 161616171717
       OCT 171717202020
       OCT 202020212121
       OCT 212121222222
       OCT 222222232323
       OCT 232323242424
       OCT 242424252525
       OCT 252525262626
       OCT 262626272727
       OCT 272727303030
       OCT 303030313131
       OCT 313131323232
       OCT 323232333333
       OCT 333333343434
       OCT 343434353535
       OCT 353535363636
       OCT 363636373737
       OCT 373737000040
       OCT 000000000000
       OCT 000000010101
       OCT 010101020202
       OCT 020202030303
       OCT 030303040404
       OCT 040404050505
       OCT 050505060606
       OCT 060606070707
       OCT 070707101010
       OCT 101010111111
       OCT 111111121212
       OCT 121212131313
       OCT 131313141414
       OCT 141414151515
       OCT 151515161616
       OCT 161616171717
       OCT 171717202020
       OCT 202020212121
       OCT 212121222222
       OCT 222222232323
       OCT 232323242424
       OCT 242424252525
       OCT 252525262626
       OCT 262626272727
       OCT 272727303030
       OCT 303030313131
       OCT 313131323232
       OCT 323232333333
       OCT 333333343434
       OCT 343434353535
       OCT 353535363636
       OCT 363636373737
       OCT 373737400000
       OCT 000000000000
       OCT 000000000001
       OCT 010101010102
       OCT 020202020203
       OCT 030303030304
       OCT 040404040405
       OCT 050505050506
       OCT 060606060607
       OCT 070707070710
       OCT 101010101011
       OCT 111111111112
       OCT 121212121213
       OCT 131313131314
       OCT 141414141415
       OCT 151515151516
       OCT 161616161617
       OCT 171717171720
       OCT 202020202021
       OCT 212121212122
       OCT 222222222223
       OCT 232323232324
       OCT 242424242425
       OCT 252525252526
       OCT 262626262627
       OCT 272727272730
       OCT 303030303031
       OCT 313131313132
       OCT 323232323233
       OCT 333333333334
       OCT 343434343435
       OCT 353535353536
       OCT 363636363637
       OCT 373737373740
CWD1   IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP2,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCP GRP1,0,32 
       IOCD GRP1,0,32 
RDW1   IOCD RDFLD,0,640
CWD2   IOCP GRP3,0,34 
       IOCD GRP3,0,34 
RDW2   IOCD RDFLD,0,680
CWD3   IOCP GRP3,0,34 
       IOCD GRP3,0,34 
RDW3   IOCD RDFLD,0,680
PRNT1  IOCD PRID,0,24 
PRNT2  IOCD SWTCH,0,48 
TWD1   IOCD RDFLD,0,640
TWD3   IOCD RDFLD,0,680
TWD4   IOCD RDFLD,0,204
TWD5   IOCD RDFLD,0,612
TWD6   IOCD RDFLD,0,680
TWD7   IOCD RDFLD,0,34 
TWD8   IOCD RDFLD,0,132
CWD4   IOCP GRP1,0,32 
       IOCP GRP5,0,1  
       IOCP GRP1,0,32 
       IOCD GRP5,0,1  
CWD5   IOCP GRP1,0,32 
       IOCP GRP5+1,0,1 
       IOCP GRP1,0,32 
       IOCD GRP5+1,0,1 
RDW4   IOCD RDFLD,0,132
CTFIN  IOCD FNPT,0,24 
*IMAGE                
*NOW PERFORMING 9GLT-A TEST FOR READING GAPLESS TAPE ON 709
PRID   OCT 004504000121    9 ROW LEFT
       OCT 000000040000   9R
       OCT 000000000000
       OCT 000000000000
       OCT 020022000000
       OCT 250020200000
       OCT 303000000600
       OCT 000000200000
       OCT 410040010010
       OCT 402011000000
       OCT 000200000002
       OCT 000000000000
       OCT 000001422000
       OCT 004100000000
       OCT 000000004000
       OCT 001400000000
       OCT 000000100004
       OCT 020040000000
       OCT 100000426000
       OCT 001500100000
       OCT 625641000320
       OCT 414023000000
       OCT 012122110417
       OCT 262050000000
*IMAGE                
*GAPLESS TAPE HAS BEEN WRITTEN
SWTCH  OCT 000000014000   9 ROW LEFT
       OCT 000000000000   9 ROW RIGHT
       OCT 000020000000   8 L
       OCT 000000000000   8 R
       OCT 500200000000   7 L
       OCT 000000000000   7 R
       OCT 000000020000   6 L
       OCT 000000000000   6 R
       OCT 020100700600   5 L
       OCT 000000000000   5 R
       OCT 000000000000   4 L
       OCT 000000000000   4 R
       OCT 041000003000   3 L
       OCT 000000000000   3 R
       OCT 014005000000   2 L
       OCT 000000000000   2 R
       OCT 200410000000   1 L
       OCT 000000000000   1 R
       OCT 015004023000   0 L
       OCT 000000000000   0 R
       OCT 140200110200   11 L
       OCT 000000000000   11 R
       OCT 620531604400   12 L
       OCT 000000000000   12 R
*IMAGE                
*SET SPECIAL FEATURE TAPE SWITCH AND PRESS START
       OCT 001001000400   9 ROW LEFT
       OCT 200400000000   9 ROW RIGHT
       OCT 000000000040   8 L
       OCT 000000000000   8 R
       OCT 010000020000   7 L
       OCT 400000000000   7 R
       OCT 000040001000   6 L
       OCT 000000000000   6 R
       OCT 204020410004   5 L
       OCT 100000000000   5 R
       OCT 000002000002   4 L 
       OCT 000000000000   4 R
       OCT 102204100300   3 L
       OCT 002200000000   3 R
       OCT 420000002000   2 L
       OCT 064000000000   2 R
       OCT 000410040010   1 L
       OCT 001000000000   1 R
       OCT 520006103200   0 L
       OCT 066200000000   0 R
       OCT 010201020004   11 L
       OCT 600400000000   11 R
       OCT 207470450552   12 L
       OCT 101000000000   12 R
* IMAGE               
* 9GLT TEST COMPLETE  
FNPT   OCT 200000000000
       OCT 000000000000
       OCT 000000000000
       OCT 000000000000
       OCT 100010000000
       OCT 000000000000
       OCT 000040000000
       OCT 000000000000
       OCT 002002400000
       OCT 000000000000
       OCT 000020000000
       OCT 000000000000
       OCT 064505000000
       OCT 000000000000
       OCT 001000000000
       OCT 000000000000
       OCT 000000000000
       OCT 000000000000
       OCT 025401000000
       OCT 000000000000
       OCT 040074000000
       OCT 000000000000
       OCT 10210240000 
       OCT 000000000000
RDFLD  BSS 1000       
BWRD1  IOCD RDFLD,0,68 
BREC1  DEC 3               L 3
BCT1   DEC 69         
WCNT1  DEC 641        
WCNT2  DEC 681        
WCNT3  DEC 681        
WCNT4  DEC 205        
XRC    OCT 0          
RECT1  DEC 6          
RECT2  DEC 11         
RECT3  DEC 11         
RECT4  DEC 3          
ABC    IOCD RDFLD,0,646
ABD    NOP TEST3      
ABE    TEFA *-3       
AAA    DEC 646        
ZERO   DEC 0          
ONE    DEC 1          
TWO    DEC 2          
FIVE   DEC 5          
SIX    DEC 6          
NINE   DEC 9          
TEN    DEC 10         
TWNTY  DEC 20         
TWTHR  OCT 23         
BACK1  TRA TES1A      
BACK5  TRA TEST3      
REDY1  DEC 641        
REDY2  DEC 3          
REDY3  DEC 321        
REDY4  DEC 2          
REDY5  DEC 681        
REDY6  DEC 21         
REDY7  DEC 205        
REDY8  DEC 7          
REDY9  DEC 612        
DECM   DEC 18         
DECM2  DEC 681        
DECM3  DEC 21         
DECM4  DEC 34         
DECM5  DEC 2          
       REM PAGE       
DECM6  DEC 331        
DECM7  DEC 11         
POST2  TRA TES1A      
TS1    DEC 0          
TEM    DEC 0          
TEM2   DEC 0          
TEM3   DEC 0          
TEM4   DEC 0          
TEM5   DEC 0          
POST1  TRA BEGIN+4    
FILE   DEC 0          
ADDR   CLA GRP5       
BREC2  DEC 2          
BWRD2  DEC 133        
NEED   OCT 3737374000000
NEED1  OCT 3737370000040
OK     EQU 3401       
ERROR  EQU 3396       
KONST  EQU 3430       
WDNO   EQU 3438       
RDNCK  EQU 3440       
RECNO  EQU 3439       
       END 24         
