                                                             2P02A
                                                             6/5/59
       REM           
*      PRINTER INTERROW TIMING TEST
       REM           
       ORG 24
       REM           
START  WPRA 1        SPACE PRINTER
       REM           
       CLA INITA     RESTORE INCREMENT
       STO INCR      
       REM           
       CLA INITB     RESTORE INITIAL
       STO DELAY     DELAY.
       REM           
       CLA INITC     RESTORE FIRST
       STO LOCNA     LOCATION.
       REM           
       CLA PONE      RESTORE PRINTER
       STO PAHD      AHEAD DELAY.
       REM           
       STZ SYNC      CLEAR STORE AREAS.
       STZ TEMPA     
       STZ TEMPB     
       STZ ROW       
       STZ VARD      
       AXT 11,2      SET XRB FOR TIMING LOOP.
GET    AXT 0,1       RESET XRA
DELAY  AXT 644,4     SET XRC FOR DELAY
       REM           
*      SET UP CONTROL WORD, SELECT PRINTER + LOOK
*      FOR 9 LEFT.   
       REM           
       CLA CW        PUT CTRL WORD
       STO 32K       IN UPPER MEM.
       WPRA          SEL PRINTER
       RCHA 32K      GIVE COMMAND
       SCHA SYNC     INTERROGATE DSU
       CLA SYNC      SCHA INFO INTO ACC.
       ALS 24        SHIFT OUT HIGH ORDER
       TNZ *-3       IS ACC ZERO
       REM           
*      FOUND 9 LEFT-DELAY + LOOK FOR NEXT
*      LEFT TIME.    
       REM           
       TIX *,4,1     YES-TAKE DELAY
       SCHA TEMPA    INTERROGATE DSU
       CLA TEMPA     LOAD ACC
SCHAD  SCHA TEMPB    INTERROGATE DSU
       CAS TEMPB     HAS ADR REG CHANGED
       HTR *         POSSIBLE DSU FAILURE, RERUN
       TXI SCHAD,1,3 NO-BACK THRU LOOP
       REM           
*      FOUND NEXT LEFT TIME-STORE INDEX +
*      CALCUCLATE TIMINGS.
       REM           
       SXA ROW,1     YES-STORE INDEX
       LXA DELAY,4   PUT DELAY IN XRC
       SXA VARD,4    STORE DELAY
       LDQ ROW       FIND TOTAL DELAY
       MPY 28US      THRU LOOP.
       STQ TEMPC     STORE TOTAL DELAY
       CLA VARD      GET VARIABLE DELAY
       ADD PAHD      ADD PRINTER AHEAD DELAY
       STO TOT       STORE IT.
       LDQ TOT       FIND DELAY IN USEC
       MPY 24US      AND ADD IT
       XCA           TO LOOP DELAY
       ADD TEMPC     FOR INTERROW
LOCNA  STO RO        TIMING.
       REM           
*      MODIFY ADDRESSES + CONSTANTS.
       REM           
       CLA LOCNA     STEP STORE
       ADD PONE      LOCATION FOR
       STO LOCNA     NEXT TIMING.
       REM           
       CLA INCR      DECREASE AMOUNT
       SUB PONE      OF INCREMENT AS
       STO INCR      TIMING PROGRESS.
       REM           
       CLA DELAY     INCREASE DELAY
       ADD INCR      FOR NEXT TIMING.
       STO DELAY     
       REM           
       CLA PAHD      INCREASE PRINTER
       ADD PONE      AHEAD DELAY
       STO PAHD      
       REM           
       TIX GET,2,1   REPEAT TILL ALL
       REM           TIMINGS ARE COMPLETED.
*      INTERROW TIMINGS COMPLETED
*      PRINT OUT TIMINGS.
       REM           
       WPRA 1        SPACE PRINTER
       REM           
       AXT 11,1      SET XRA TO PRINT
PRINT  CLA RO+11,1   OUT INTRROW
       TSX BTEN,4    TIMINGS.
       NOP           CALL IN SPALT
       STQ TIME      PRINT ROUTINE.
       CAL LT+11,1   
       SLW DESIG     
       TSX SPLAT,4   
       HTR 7,,1      
TIME   BCD 1         
       BCD 4 MICROSECONDS 9 LEFT TO
DESIG  BCD 1         
       BCD 1T.       
       TIX PRINT,1,1 
       REM
       SWT 6         REPEAT PROGRAM
       HTR START     NO-IF SENSE SW IS UP
       TRA START     YES-IF SENSE SW IS DOWN
       REM           
       REM           
       REM           
LT     BCD 1 8 LEF   
       BCD 1 7 LEF   
       BCD 1 6 LEF   
       BCD 1 5 LEF   
       BCD 1 4 LEF   
       BCD 1 3 LEF   
       BCD 1 2 LEF   
       BCD 1 1 LEF   
       BCD 1 0 LEF   
       BCD 111 LEF   
       BCD 112 LEF   
       REM           
CW     IOCD 32K-1,0,24
       REM           
SYNC                 
TEMPA                
TEMPB                
TEMPC                
VARD                 
ROW                  
TOT                  
       REM           
PONE   DEC 1         
24US   DEC 24        
PAHD   DEC 1         
28US   DEC 28        
INCR   DEC 694       
INITA  DEC 694       
       REM           
INITB  AXT 644,4     
INITC  STO RO        
RO     BSS 11        
32K    EQU 32767     
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM INDEXABLE BCD PRINT SUBROUTINE.
       REM           
*THIS  SUBROUTINE USES THREE SYMBOLS, THEY ARE...
       REM           
       REM SPLAT, THE FIRST WORD OF THE ROUTINE
       REM           
       REM CI, USED FOR CARD IMAGE, 26 LOCATION
       REM           
       REM SUBET, THE CONTENTS OF XRC ARE STORED
       REM IN THE ADDRESS OF SUBET.
       REM           
*CONDTION  OF THE ACC, MQ, AND ACC OVERFLOW
*TRIGGER  IS NOT GUARANTEED ON EXIT FROM THIS ROUTINE.
       REM           
       REM THE PRINTER ON CHANNEL A IS USED
       REM YOU MAY ENTER SPLAT+1 IF YOU HAVE
       REM ALREADY GIVEN WRIT SELECT.
       REM           
       REM THE RCHA INSTRUCTION IS AT SPLAT+60.
       REM           
       REM THERE IS NO CHANNEL DELAY IN THE
       REM SUBROUTINE, THEREFORE TAKE CARE NOT
       REM TO USE CI UNTIL AFTER 12 ROW-RIGTH
       REM HAS BEEN WRITTEN. FOR THIS REASON,
       REM YOU MUST GIVE WRS FOR EACH ENTRY
       REM OR ENTER AT SPLAT.
       REM           
       REM           
SPLAT  WPRA          GET GOING
       SXA SPLAT+61,1 
       SXA SPLAT+62,2 
       SXA SUBET,4   SAVE ORGINAL XRC.
       NZT 1,4       IF CONTROL WORD ZERO.
       REM           
*5                   
       TRA 2,4       RETURN
       REM           
       CAL 1,4       GET NON-ZERO WORD
       SLW SPLAT+85  SAVE CONTROL WORD
       PDX 0,1       TYPE WHEEL NO.
       TXL SPLAT+65,1,0 IF DECR. ZERO, GET
       REM           NEW CONTROL WORD
       REM           
*10                  
       SXD *+2,4     GET EXIT ADDRESS
       PAC 0,2       BY ADDING TWOS COMP.
       TXI *+1,2,0   OF N TO XRC.
       SXA SPLAT+63,2 EXIT VALUE.
       REM           
       REM SET BIT INDEX TO STARTING WHEEL
       REM           
       SXA *+3,1     FOR SHIFTING
       REM           
*15                  
       AXT 1,3       1 TO XRA AND XRB
       CAL SPLAT+82  BIT INDEX TO P
       LGR 0,1       SHIFT TO STARTING POINT
       TNZ *+3       IF ACC IS ZERO, SET FOR
       STQ SPLAT+83  RIGHT ROW, AND MAKE
       REM           
*20                  
       TXI *+2,2,1   XRB A DUECE
       SLW SPLAT+83  OTHERWISE, LEFT ROW.
       AXT 26,1      
       STZ CI+26,1   CLEAR CARD IMAGE
       TIX *-1,1,1   
       REM           
       REM           
       REM FORM CARD IMAGE.
       REM           
*25                  
       TIX *+1,4,1   ADDRESS OF FIRST WORD.
       AXT 6,1       CHARACTER COUNT.
       LDQ 1,4       GET THE WORD.
       REM           SOME PEOPLE NEVER
       REM           DO, YOU KNOW
       REM           
       SXA SPLAT+54,1 SAVE CHARACTER COUNT.
       PXD           CLEAR ACC
       REM           
*30                  
       LGL 2         ZONE
       ALS 1         TIMES 2
       PAX 0,1       
       SXA SPLAT+45,1 FOR FUTURE REFERENCE.
       CLM           
       REM           
*35                  
       LGL 4         DIGIT
       ALS 1         TIMES 2
       SLW CI        TEMP0
       CAL SPLAT+83  BIT INDEX
       NZT CI        IS DIGIT ZERO.
       REM           
*40                  
       TXH SPLAT+80,1,0 IS ZERO ZONE TOO.
       LXA CI,1      OK, PROCEED
       TXH SPLAT+48,1,24 CHECK FOR ILLEGAL
       TXH SPLAT+78,1,20 SPECIAL CHARACTER.
       ORS* SPLAT+92,2 XRB PICKS LEFT OR RIGHT.
       REM           
*45                  
       AXT 0,1       ZONE AGAIN.
       TXL *+2,1,0   NOTHING FOR ZERO ZONE
       ORS* SPLAT+90,2 PLACE ZONE BIT.
       REM           
       REM  COLUMN SET.
       REM           
       ARS 1         SET BIT INDEX TO 
       TNZ *+4       NEXT COLUMN, IF ANY.
       REM           
*50                  
       TXH SPLAT+60,2,1 IF BX ZERO,+XRB 1, STOP
       REM           
       CAL SPLAT+82  IF NOT, SET TO RIGHT
       TXI *+1,2,1   ROW AND PROCEED.
       SLW SPLAT+83  BX READY FOR NEXT COLUMN.
       AXT 0,1       MORE CHARACTERS.
       REM           
*55                  
       TIX SPLAT+28,1,1 NEXT COLUMN
       LXA SPLAT+85,1 MORE WORDS MAYBE.
       TNX *+3,1,1    IF NOT, STOP.
       SXA SPLAT+85,1 YUMMY, GO GET EM.
       TXI SPLAT+25  
       REM           
       REM FIFTEEN MEN ON A DEAD MANS CHEST.
       REM           
*60                  
       RCHA SPLAT+84  LET HER RIP
       AXT 0,1       
       AXT 0,2       
       AXT 0,4       
       TRA 2,4         EXIT
       REM           
       REM           
       REM  GET NEW CONTROL WORD FROM SOMPLACE
       REM           
       REM           
*65                  
       SXA SPLAT+63,4 FOR EXIT
       LXA SPLAT+61,1 RESTORE XRA
       NZT* SPLAT+85 IF CONTROL WORD ZERO
       TRA SPLAT+61  RETURN.
       CAL SPLAT+85  OLD CONTROL WORD
       REM           
*70                  
       STT *+1       BRING OUT INDEX
       SXD *+2,0     REGISTER, IF ONE IS TAGED.
       PAC 0,4       
       TXI *+1,4,0   GET EFFECTIVE ADDRESS.
       CAL 0,4       NEW CONTROL WORD.
       REM           
*75                  
       PDX 0,1       TYPE WHEEL ID.
       SLW SPLAT+85  
       TXI SPLAT+14,4,1 PROCEED
       REM           
       REM YOUR AN OLD SMOOOTHY.
       REM           
       ORS* SPLAT+88,2 PUT EIGHT IN, TAKE
       TIX SPLAT+44,1,16 16 OUT, - GOOD BUSINESS
       REM           
*80                  
       TXL SPLAT+47,1,4 IF NOT BLANK, SET ZONE.
       TRA SPLAT+48    BLANK.
       REM           
       MZE             FOR BIT INDEX.
       HTR             DYNAMIC BIT INDEX.
       IOCD CI+2,,24   BUFFER COMMAND
       REM           
*85                  
       HTR             SPECIAL SALON FOR
       REM             THE CONTROL WORD
       HTR CI+5      
       HTR CI+4        BROW ADDRESSES
       HTR CI+27,1   
       HTR CI+26,1     ZONE ROW ADDRESSES
       REM           
*90                  
       HTR CI+21,1   
       HTR CI+20,1     DIGIG ROW ADDRESSES
       REM           
CI     BSS 26        
SUBET  BSS 1         
       REM           
       REM   TO WRITE PUNCH, USE TSX CRNCH,4.
       REM           
CRNCH  WPUA          
       TRA SPLAT+1   
       REM           
       REM           
       REM           
*TRANSFORM THE CONTENTS OF ACC 1-35 TO OCTAL IN BCD FORMAT.
*A SIGN CHARACTER FOR MINUS, AND THE Q AND P BITS
*ARE STORED IN THE ADDRESS OF X+1. IF THERE ARE 6
*CHARACTERS OF LESS, RETURN IS MADE TO X+3, OTHER
*WISE, TO X+2. TRANSFORMED WORDS IN MQ AND ACC.
*THIS SUBROUTINE STORES XRC IN SUBSET, WHICH MUST BE 
*SUPPLIED BY THE PROGRAM. NO BLANKS ARE INSERTED
       REM           
       REM           
PX     SXA PX+24,1   
       SXA PX+25,2   
       SXA SUBET,4   SAVE XRC
       STO FREE      
       ARS 35        P AND Q
       REM           
*5                   
       STA 1,4       P AND Q TO X+1
       LDQ FREE      
       PXD           CLEAR ACC
       LGL 1         
       ALS 11        SIGN IF MINUS
       REM           
*10                  
       ORS 1,4       SIGN TO X+1
       LGR 1         DROP SIGN
       AXT 6,3       
       PXD           CLEAR ACC
       ALS 3         ZONE
       REM           
*15                  
       LGL 3         DIGIT
       TIX *-2,1,1   6 TIMES.
       SLW FREE+1    
       PXD           CLEAR ACC
       ALS 3         ZONE
       REM           
*20                  
       LGL 3         DIGIT
       TIX *-2,2,1   6 TIMES
       XCL           SECOND WORD TO MQ,
       CAL FREE+1    FIRST TO ACC
       AXT 0,1       
       REM           
*25                  
       AXT 0,2       
       TZE 3,4       X+3 FOR 1 WORD.
       TRA 2,4       X+2 FOR 2 WORDS.
       REM           
FREE   BSS 10        
       REM           
*FIXED BINARY TO FIXED BCD. BINARY WORD IN THE ACC ON
*ENTRY, BCD WORDS IN ACC AND MQ ON EXIT.
       REM LEADING BLANKS FOR LEADING ZEROS.
       REM BLANKS FOR PLUS, - FOR MINUS
       REM           
*IF THE HIGH ORDER 6 CHARACTERS AR BLANK, RETURN IS
*MADE TO X+2, OTHERWISE X+1.
       REM           
       REM XRC IS STORED AT SUBET, WHICH MUST
       REM BE SUPPLIED BY THE PROGRAM.
       REM           
BTEN   SXA BTEN+23,1 
       SXA BTEN+24,2 
       SXA SUBET,4   SAVE XRC
       SLW FREE      DROP SIGN
       CLM           
       REM           
*5                   
       STO FREE+3    SAVE SIGN
       STZ FREE+1    
       STZ FREE+2    
       AXT 2,2       
       AXT 36,1      
       REM           
*10                  
       PXD           CLEAR ACC.
       LDQ FREE      
       NZT FREE      WHEN ZERO-
       TRA BTEN+26   FINISHED.
       DVP BTEN+38   BY 10 DECIMAL.
       REM           
*15                  
       STQ FREE      
       ALS 36,1      SHIFT TO POSITION,
       ACL FREE+3,2  TACK ON LOW ORDER-
       SLW FREE+3,2  SAVE PARTIAL RESULT.
       TIX BTEN+10,1,6 GET NEXT DIGIT, OR
       REM           
*20                  
       TIX BTEN+9,2,1 SECOND WORD.
       CAL FREE+2    IF XRB RUNS OUT BEFORE
       REM           QUOT. IS ZERO, NO
       REM           ROOM FOR SIGN.
       LDQ FREE+1    LOW ORDER TO MQ.
       AXT 0,1       
       AXT 0,2       
       REM           
*25                  
       TRA 1,4       EXIT-TO X+1 FOR 2 WORDS.
       REM           
       REM HE IS A FOWL CANINE.
       REM           
       CLA FREE+3    BRING IN SIGN.
       ORA BTEN+36   BLANK-MINUS.
       TMI *+2       WAS WORD MINUS.
       CAL BTEN+37   NO, GET BLANKS
       REM           
*30                  
       ALS 36,1      BUMBSIE DAISY.
       ACL FREE+3,2  NON-ZERO DIGITS.
       TXL BTEN+22,2,1 OUT ON HIGH ORDER
       XCL           
       CAL BTEN+37   HIGH ORDER BLANK.
       REM           
*35                  
       TXI BTEN+23,4,-1 RETURN TO X+2
       OCT -406060606040 BLANK MINUS.
       OCT 606060606060  BLANK PLUS
       HTR 10        DIVISOR
       REM           
       END START     
