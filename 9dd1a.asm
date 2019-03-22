                                                             9DD1A          
                                                            10-20-59       
       REM            
       REM            
*      9 D D 1 A      
       REM            
*PROGRAM TO TEST DIRECT DATA INPUT ON 709 WITH SIMULATION
       REM            
       ORG 24         
       REM            
       NOP            
       SWT 3          CHECK SENSE SWITCH 3
       TRA *+2        UP - PRINT TEST IDENTITY
       TRA *+11       DN - BYPASS PRINT
       TSX SPLAT-1,4  
       MZE 8,0,1      
       BCD 6NOW PERFORMING DIAGNOSTIC DIRECT DAT
       BCD 2A TEST  9DD1
       REM            
*****************************************************************
       REM            
*      I N I T I A L I Z A T I O N
       REM            
       REM            
       STZ TEST       CLEAR TEST
CBEGN  TSX IOC,4      TO ENTER CONTROL WORDS
       REM            
*     NOTE -- ONLY ONE DS - 2 CHANNELS - SHOULD BE CALLED AT EACH
*     KEY ENTRY       
       REM            
       AXT 3,2        L +3 IN XRB
       AXT 6,1        L +6 IN XRA
       CAL CTRL1+3,2  L CONTROL WORD
       SLW ORIG+3,2   SAVE ORIGINAL CONTROL WORD
       ANA SK1+1      CLEAR TO CARD MACHINES
       ZET CTRA+6,1   
       ORA SYNCW+6,1  OR IN EXCLUSIVE UNIT 1
       ZET CTRA+7,1   
       ORA SYNCW+7,1  OR IN EXCLUSIVE UNIT 1
       SLW CTRL1+3,2  SAVE ADJUSTED CONTROL WORD
       TIX *+1,2,1    
       TIX *-9,1,2    
       REM            
       CLA ORIG       L ORIGINAL CHN A CONTROL
       TPL *+3        CHECK IF PROGRAM READ
       REM            FROM CARDS
       CLA SK1+1      YES - L READ CARDS
       TRA *+2        
       CLA SK1        NOT READ FROM CARDS
       REM            L READ TAPE
       STO FINL1      
RUC    TSX IOCNT,4    RECALCULATE UNIT COUNT
       REM            
       CLA K          L +764
       STO CTRCK      
       STZ CTR        
       CLA POST       POST
       STO 0          RESTART
       REM            
INTL1  AXT 6,1        L +6 IN XRA
       AXT 3,2        L +3 IN XRB
       CLA CTRA+6,1   L CHANNEL UNIT COUNT
       TZE NEXT       CHECK NEXT CHANNEL
       STZ CTRA+6,1   CLEAR UNIT COUNT
       STZ CTRA+7,1   CLEAR UNIT COUNT
       STZ CTRL1      CLEAR CONTROL
       STZ CTRL2      WORDS
       STZ CTRL3      FROM 9IOM
       CLA SYNCW+6,1  L SYNTHETIC CONTROL WORD
       STO CTRL1+3,2  
       TSX CTX,4      GO TO MODIFY PROGRAM
       PZE BEGA,0,ENDA MODIFICATION AREA
       CLA SYNCW+7,1  L SYNTHETIC CONTROL WORD
       STO CTRL1+3,2  
       TSX CTX,4      GO TO MODIFY PROGRAM
       PZE BEGB,0,ENDB MODIFICATION AREA
       TRA TROT       BEGIN TEST
       REM            
       REM            
*RESET CHANNEL TRIGGERS
       REM            
       REM            
SETR   WDDB           RESET TRAP
       RCHB ZERO      TRIGGERS
       XEC CHANA+7    WRITE SELECT
       PSLB PSL+6     PULSE TCU SELECTED
       PSLB PSL+4     PULSE EOR-CHAN A
       XEC CHANA+6    END OF TAPE TEST
       NOP            
       XEC CHANA+18   REDUNDANCY CHECK
       XEC CHANA+19   END OF FILE CHECK
       XEC CHANA      BEGINNING OF TAPE TEST
       NOP            
       TRA 1,4        
       REM            
       REM            
NEXT   TIX *+1,1,2    
       TIX INTL1+2,2,1 
       AXT 3,1        RESTORE
       CLA ORIG+3,1   ORIGINAL
       STO CTRL1+3,1  CONTROL
       TIX *-2,1,1    WORDS
       TRA SWT5       
       TRA RUC        
       REM            
       REM            
*TRY STORE SENSE LINES AND SEE IF IT DECODES AS STORE CHANNEL
       REM            
       BCD 1SSLB      
TROT   TSX RESET,4    MONITOR RESET
       TSX SETR,4     GO TO RESET TRIGGERS
       RCHB AALLO     PLACE BITS IN REGISTERS
       SSLB TO        STORE SENSE LINES. POSITION
       REM            15 SHOULD HAVE A BIT, THE
       REM            REMAINDER SHOULD BE ZERO
       REM            
       CLA TO         RESULT OF STORING S. LINES
       LDQ ME         CORRECT RESULT
       CAS ME         
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  ERROR IN STORING SENSE
       NOP TROT       LINES. MQ SHOULD HAVE
       TSX SPLAT,4    CORRECT BITS. ACC SHOULD
       PZE PASS       HAVE INCORRECT BITS
       IOT            TURN OFF I/O CK LITE
       NOP            
       TSX OK,4       REPEAT IF NECESSARY
       TRA TROT       
       REM            
       REM            
*PRESENT SENSE LINES WITH ZEROS IN ALL POSITIONS
*ONLY ETT ON CHAN A SHOULD COME UP
       REM            
       BCD 1PSLB      
TROOP  TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       PSLB ZERO      L +0
       STZ TO         CLEAR TEMP STORAGE
       SSLB TO        SAVE SENSE LINES
       CLA TO         BITS STORED
       LDQ ME         CORRECT LINES
       CAS ME         
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  SOME POSITION WAS UP IN ERROR
       TXL TROOP      
       REM            
       XEC CHANA      BTTA
       TRA *+2        ON-ERROR
       TRA *+3        OK
       TSX ERROR-1,4  POSITION 8 WAS UP
       TXL TROOP      AFTER PSL WITH ZERO
       REM            
       XEC CHANA+13   TRCA
       TRA *+3        OK
TRUMP  TSX ERROR-1,4  POSITION 10 WAS UP
       TXL TROOP      AFTER PSL WITH ZERO
       XEC CHANA+14   TEFA
       TRA *+3        OK
       TSX ERROR-1,4  POSITION 16 WAS UP
       TXL TROOP      AFTER PSL WITH ZERO
       TSX OK,4       REPEAT
       TRA TROOP      
       REM            
       REM            
*TEST PRESENT SENSE LINES-POSITIONS 8,10,16-SHOULD GET
*EOF ON CHANNEL A, REDUNDANCY CHECK ON CHANNEL A AND
*BOT ON CHANNEL A.    
       REM            
       REM            
       BCD 1PSLB      
       REM            
OUT    TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       XEC CHANA+3    TURN OFF BTT IND-CHAN A
       NOP            
       XEC CHANA+4    TURN OFF RDNCY IND-CHAN A
       XEC CHANA+5    TURN OFF EOF IND-CHAN A
       PSLB PSL+10    PULSE BTT, EOF AND RDNCY-CHAN A
       REM            
       XEC CHANA      TEST POSITION 8-BTTA
       TRA *+5        ON-OK
       TSX ERROR-1,4  PRINT ERROR EXIT
       TXL OUT        
       TSX SPLAT,4    
       PZE HIM        
       REM            
       REM            
       XEC CHANA+1    TEST FOR POSITION 10-TRCA
       TSX ERROR-1,4  RDNCY IND NOT
       TXL OUT        ON-ERROR IN
       TSX SPLAT,4    POSITION 10 OF PSL
       PZE HIS        
       REM            
       REM            
BOOZE  XEC CHANA+2    TEST FOR POSITION 16-TEFA
       TSX ERROR-1,4  EOF IND NOT ON
       TXL OUT        POSITION 16 OF
       TSX SPLAT,4    PSL FAILED
       PZE HAT        
       REM            
       REM            
HIC    XEC CHANA+6    TEST FOR SENSE OUTPUT RESET
       TRA *+2        ON-ERROR
       TRA *+5        OK-OFF
       TSX ERROR-1,4  ON-SENSE OUTPUT RESET
       TXL OUT        SHOULD NOT COME UP. PAGE
       TSX SPLAT,4    60.04.41
       PZE HES        
       TSX OK,4       REPEAT IF NECESSARY
       TRA OUT        
       REM            
*SEE IF DIRECT DATA SELECTS WILL SELECT AND SEND
*SELECT LINE TO OUTSIDE WORLD.
       REM            
       BCD 1WDDB      
       REM            
CUP    TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       WDDB           WRITE DIRECT DATA
       STZ LEAD       CLEAR TEMP STORAGE
       SSLB LEAD      SAVE SENSE LINES
       RCHB ZERO      DISCONNECT
       CAL LEAD       CONTENTS OF SENSE LINES
       ERA SSL        SHOULD LEAVE ZERO
       TZE TOP        OK-IF ZERO-CORRECT COMPARE
       TSX ERROR-1,4  EITHER SENSE INPUT POSITION
       TXL CUP        15 OR 13 FAILED-DR NOT LDD
       ARS 20         OR WDD
       LBT            TEST FOR DR NOT LDD
       TRA *+3        DID NOT FAIL
       TSX SPLAT,4    DR NOT LDD FAILED
       PZE LEAV       
       ARS 1          TEST FOR WDD
       TZE TOP        OK-IF ZERO-CORRECT COMPARE
       TSX SPLAT,4    WDD SENSE INPUT LINE
       PZE ING        13 FAILED
TOP    TSX OK,4       REPEAT IF NECESSARY
       TRA CUP        
       REM            
       REM            
*TEST  RDD AS ABOVE TEST FOR WRITE
       REM            
       BCD 1RDDB      
DRAW   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       RDDB           READ DIRECT DATA
       STZ LEAD       CLEAR TEMP STORAGE
       SSLB LEAD      SAVE SENSE LINES
       RCHB ZERO      DISCCONECT
       PSLB PSL+4     PULSE EOR-CHAN A
       CAL LEAD       CONTENTS OF SENSE LINES
       ERA SSL+1      SHOULD LEAVE ZERO
       TZE ER         OK-IF ZERO-CORRECT COMPARE
       TSX ERROR-1,4  EITHER SENSE INPUT POSITION
       TXL DRAW       14 OR 15 FAILED-DR NOT LDD
       ARS 20         OR RDD
       LBT            TEST FOR DR NOT LDD
       TRA *+3        DID NOT FAIL
       TSX SPLAT,4    DR NOT LDD FAILED
       PZE LEAV       
       ARS 1          TEST FOR RDD
       TZE ER         OK-IF ZERO-CORRECT COMPARE
       TSX SPLAT,4    RDD SENSE INPUT LINE
       PZE OLD        14 FAILED
ER     TSX OK,4       REPEAT IF NECESSARY
       TRA DRAW       
       REM            
*SELECT TAPE ON CHANNEL A UNITS 1-5 TO TEST SENSE
*INPUT LINES 8-12     
       REM            
       REM            
       BCD 1SSLB      
HIPS   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       CLA CHANA+7    L WTBA 1
       STO WELP       STO UNIT ONE
       ADD ONE        L +1
       STO KELP       STO UNIT TWO
       ADD ONE        L +1
       STO YELP       STO UNIT THREE
       ADD ONE        L +1
       STO HELP       STO UNIT FOUR
       ADD ONE        L +1
       STO *+1        STO UNIT FIVE
       WTBA 5         SELECT CHAN A - UNIT 5
       STZ LEAD       CLEAR TEMP STORAGE
       STZ TO         CLEAR TEMP STORAGE
       SSLB TO        SHOULD STORE POSITION 12
       PSLB PSL+6     PULSE TCU SELECTED
       PSLB PSL+4     PULSE EOR-CHAN A
       CLA TO         
       CAS PSL2       
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  POSITION 12 OF SSL FAILED
       TXL HIPS       
       TSX SPLAT,4    
       PZE SIDE       
       REM            
       CAL SIDE+4     CHANGE
       SUB SALON      SSL
       SLW SIDE+4     BIT
       CLA SIDE+8     POSITION TO 11
       ADD ADD        AND UNIT ADDR
       STO SIDE+8     TO 4
       REM            
HELP   WTBA 4         
       STZ TO         
       SSLB TO        SHOULD STORE POSITION 11
       PSLB PSL+6     PULSE TCU SELECTED
       PSLB PSL+4     PULSE EOR-CHAN A
       CLA TO         
       CAS PSL2+1     
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  ERROR DID NOT STORE
       TXL HIPS       POSITION 11-UNIT ADDR 2
       TSX SPLAT,4    
       PZE SIDE       
       CAL SIDE+4     CHANGE
       SUB SALON      SSL
       SLW SIDE+4     BIT POSITION TO 10
       CLA SIDE+8     AND UNIT ADDR
       ADD ADD        TO 3
       STO SIDE+8     
       REM            
YELP   WTBA 3         SELECT UNIT 3
       STZ TO         CLEAR TEMP STORAGE
       SSLB TO        SHOULD STORE POSITION 10
       PSLB PSL+6     PULSE TCU SELECTED
       PSLB PSL+4     PULSE EOR-CHAN A
       CLA TO         
       CAS PSL2+2     
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  ERROR DID NOT STORE
       TXL HIPS       POSITION 10
       TSX SPLAT,4    
       PZE SIDE       
       CAL SIDE+4     CHANGE UNIT PRINT
       ANA MASK       L 777777700077
       ADD NINE       L 01100
       SLW SIDE+4     ADJUST TO BCD 9
       CLA SIDE+8     UNIT ADDR
       ADD ADD        MAKE IT 2
       STO SIDE+8     
       REM            
KELP   WTBA 2         SELECT UNIT 2
       STZ TO         CLEAR TEMP STORAGE
       SSLB TO        SHOULD STORE POSITION 9
       PSLB PSL+6     PULSE TCU SELECTED
       PSLB PSL+4     PULSE EOR-CHAN A
       CLA TO         
       CAS PSL2+3     
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  ERROR DID NOT STORE
       TXL HIPS       POSITION 10
       TSX SPLAT,4    
       PZE SIDE       
       CAL SIDE+4     CHANGE
       SUB SALON      SSL
       SLW SIDE+4     BIT POSITION TO 8
       CLA SIDE+8     AND UNIT ADDR
       ADD ADD        TO 1
       STO SIDE+8     
       REM            
WELP   WTBA 1         SELECT UNIT 1
       STZ TO         CLEAR TEMP STORAGE
       SSLB TO        SHOULD STORE POSITION 10
       PSLB PSL+6     PULSE TCU SELECTED
       PSLB PSL+4     PULSE EOR-CHAN A
       CLA TO         
       CAS PSL2+4     
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  ERROR DID NOT STORE
       TXL HIPS       POSITION 10
       TSX SPLAT,4    
       PZE SIDE       
       CLA SALO       RESTORE SSL POSITION
       STO SIDE+8     AND INITIAL
       CLA SAL        UNIT ADDR
       STO SIDE+4     IN PRINT OUT
       TSX OK,4       
       TRA HIPS       REPEAT
       REM            
       REM            
*TEST FOR SSL POSITION 16 BY GIVING WRD DD AND RCH TO BRING UP
*CHANNEL RDY WRITE    
       REM            
       BCD 1SSLB      
HOLY   TSX CLEAR,4    
       TSX SETR,4     GO TO RESET TRIGGERS
       WDDB           WRITE DIRECT DATA
       RCHB OPER      IOCD-WC 1
       STZ TO         CLEAR TEMPORARY STORAGE
       SSLB TO        STORE SENSE LINES
       RCHB ZERO      WRITE DD, RESPECTIVELY
       CLA TO         
       LDQ COMP       CORRECT RESULT
       CAS COMP       
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  TEST FOR POSITION 16-SSLB
       TXL HOLY       ALL OTHERS HAVE BEEN TESTED
       TSX SPLAT,4    HOWEVER, POSITION 15 MIGHT
       PZE KICK       BE UP, AND SHOULD BE DOWN
       REM            OR POSITION 13 MIGHT BE
       REM            DOWN AND SHOULD BE UP.
       REM            DATA REG NOT LOADED AND
       TSX OK,4       
       TRA HOLY       
       REM            
       REM            
       BCD 1SSLB      
       REM            
TOLE   TSX CLEAR,4    
       TSX SETR,4     GO TO RESET TRIGGERS
       RDDB           READ DIRECT DATA
       RCHB OPER      IOCD-WC 1
       STZ TO         CLEAR TEMP STORAGE
       SSLB TO        STORE SENSE LINES
       RCHB ZERO      DISCONNECT
       CLA TO         
       LDQ COMP+1     CORRECT RESULT
       CAS COMP+1     
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  TEST POSITION 17-SSLB
       TXL TOLE       ALL OTHER HAVE BEEN TESTED
       TSX SPLAT,4    HOWEVER, POSITION 15 MIGHT BE
       PZE MULE       DOWN AND SHOULD BE UP OR
       PSLB PSL+6     POSITION 14 MIGHT BE DOWN
       REM            AND SHOULD BE UP
       TSX OK,4       
       TRA TOLE       
       REM            
       REM            
*RESET AND LOAD CHANNEL B WITH IND 1 ON-WC - 0 TO
*TEST FEED BACK TO CHAN B EOF FROM WD CNT 0-IND 1 ON LINE.
       REM            
       BCD 1EOF       
DO     TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       RDDB           READ DIRECT DATA
       RCHB OPER1     IORP-WC0 TO TEST
       REM            TIE BACK TO EOF CHAN B
       TEFB *+5       
       TSX ERROR-1,4  IND 1-WC0 DID NOT
       TXL DO         BRING UP EOF CHAN B
       TSX SPLAT,4    
       PZE TRAIN      
       TSX OK,4       
       TRA DO         
       REM            
       REM            
*TEST PSL AND SSL INDEXED, INDIRECTLY ADDRESSED
*AND INDEXED AND INDIRECTLY ADDRESSED
       REM            
       BCD 1PSL X     
SPOT   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       AXT 512,1      L 1000 IN XA
       PSLB PSL+519,1 PULSE RDNCK - CHAN A
       XEC CHANA+15   TEST EOF - CHAN A
       TSX ERROR-1,4  PRESENT SENSE LINES
       TXL SPOT       INDEXED FAILED
       TSX SPLAT,4    
       PZE SONG       
       TSX OK,4       
       TRA SPOT       
       REM            
       REM            
*                     
*                     
       REM            
       BCD 1PSL IA    
       REM            
CHECK  TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       PSLB* FIX      SHOULD PULSE EOF - CHAN A
       XEC CHANA+16   TEST EOF - CHAN A
       TSX ERROR-1,4  PRESENT SENSE LINES
       TXL CHECK      INDIRECTLY ADDRESSED
       TSX SPLAT,4    FAILED
       PZE BIRD       
       TSX OK,4       
       TRA CHECK      
       REM            
       REM            
       BCD 1PSLXIA    PSL-INDEXED AND I ADDR
ROL    TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       AXT 512,1      
       PSLB* FIX+513,1 SHOULD PULSE RDNCK - CHAN A
       XEC CHANA+17   TEST EOF-CHAN A
       TSX ERROR-1,4  PRESENT SENSE LINES
       TXL ROL        INDIRECTLY ADDRESSED
       TSX SPLAT,4    AND INDEXED-FAILED
       PZE PARA       
       TSX OK,4       
       TRA ROL        
       REM            
       REM            
       BCD 1SSL X     
LING   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       STZ WAIT       
       AXT 512,1      
       SSLB WAIT+512,1 SHOULD STORE POSITION 15
       CLA WAIT       RESULT OF SSL
       LDQ ME         CORRECT BIT
       CAS ME         
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  SSL INDEXED-FAILED
       TXL LING       
       TSX SPLAT,4    
       PZE DISE       
       TSX OK,4       
       TRA LING       
       REM            
       REM            
       BCD 1SSL IA    
STONE  TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       STZ WAIT       
       SSLB* WAIT+1   SHOULD POSITION 15
       CLA WAIT       
       LDQ ME         CORRECT BIT
       CAS ME         
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  SSL INDIRECTLY
       TXL STONE      ADDRESS-FAILED
       TSX SPLAT,4    
       PZE EDEN       
       TSX OK,4       
       TRA STONE      
       REM            
       BCD 1SSLXIA    
       REM            
STOP   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       STZ WAIT       CLEAR TEMP STORAGE
       AXT 512,1      
       SSLB* WAIT+513,1 SHOULD POS. 15
       CLA WAIT       RESULT SSL
       LDQ ME         CORRECT BIT
       CAS ME         
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-1,4  SSL INDIRECTLY
       TXL STOP       ADDRESSED AND
       TSX SPLAT,4    INDEXED-FAILED
       PZE ADAM       
       TSX OK,4       
       TRA STOP       
       REM            
       REM            
*WRITE DIRECT DATA AND PULSE EOR ON CHANNEL B TO FORCE
*DISCONNECT FROM DIRECT DATA
       REM            
       BCD 1PSLB      
GREY   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       XEC CHANA+6    TURN OFF ETT IND
       NOP            
       WDDB           
       RCHB NOD       IORP - WC 10
       PSLB PSL+3     PULSE EOR - CHAN B TO DISCN
       TCOB *+2       ERROR
       TRA *+6        OK
       RCHB OPER1     DISCONNECT WITH EOF, IF
       TSX ERROR-1,4  EOR DID NOT WORK
       TXL GREY       
       TSX SPLAT,4    PRESENT SENSE LINE 14 DID
       PZE CLIP       NOT DISCONNECT CHAN B
       REM            ON EOR
       TSX OK,4       
       TRA GREY       
       REM            
       REM            
**WRITE SELECT DIRECT DATA CHAN B AND RDS CHAN A-TRY
*TO MOVE DATA WITH FIRST WORD TEST, AND DEMANDS
       REM            
       BCD 1WDDB      
MARE   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       WDDB           
       RCHB OPER2     IOCD-WC1 ALL ONES
       STZ RINK       CLEAR TEMP STORAGE
       REM            
       XEC CHANA+8    READ CHAN A
       XEC CHANA+10   RCHA-IOCD WC1
       PSLB PSL+6     PULSE TCU SELECTED-CHANA
       PSLB PSL+5     PULSE 1ST WD TEST-CHAN A
       PSLB PSL+8     PULSE DEMAND CHAN A
       PSLB PSL       PULSE DMD - CHAN B
       PSLB PSL+8     PULSE DMD - CHAN A
       REM            
       CLA RINK       WORD READ
       LDQ ONES       CORRECT WORD
       CAS ONES       
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-2,4  FIRST TRY AT TRANSMITTING
       TXL MARE       WORD OF ALL ONES
       TSX SPLAT,4    
       PZE CLOP       
       TSX OK,4       REPEAT
       TRA MARE       
       REM            
       REM            
*TRANSMIT 36 WORDS WITH A RIPPLE OF ONE BIT TO CHECK
*EACH POSITION OF THE DATA REGISTER CABLE
       REM            
       BCD 1WDDB      
AINT   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       AXT 36,1       
       CLA ONE        L+1
       SLW WRFLD+36,1 FORM
       ALS 1          36 POSITION
       TIX *-2,1,1    RIPPLE PATTERN
       AXT 1,2        
       PXA 0,2        SET UP
       ADD ONE        RECNO
       STO RECNO      FOR PRINT RT
       REM            
       WDDB           
       RCHB BUT       IOCD-WC 36
       AXT 36,1       
       XEC CHANA+8    RDS CHAN A
       XEC CHANA+9    RCHA-IOCD WC 36
       PSLB PSL+6     PULSE TCU SELECTED
       PSLB PSL+5     PULSE 1ST WD TEST
       PSLB PSL+8     PULSE DMD-CHAN A
       PSLB PSL       PULSE DMD-CHAN B
       TIX *-2,1,1    
       PSLB DONT      PULSE EOR CHAN A + CHAN B
       NOP            
       AXT 36,1       
       PXA 0,1        
       ADD ONE        L+1
       STO WDNO       
       CLA RDFLD+36,1 WORD READ
       LDQ WRFLD+36,1 CORRECT WORD
       CAS WRFLD+36,1 
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-2,4  
       NOP AINT       
       SLN 1          LITE ONE ON IF ERROR
       TIX *-8,1,1    CHECK 36 WORDS
       SLT 1          TEST FOR ERROR
       TRA *+3        OK
       TSX SPLAT,4    PRINT COMMENT
       PZE PIN        
       TSX OK,4       REPEAT
       TRA AINT       
       REM            
       REM            
*TEST WRITE CHAN A AND READ DIRECT DATA FOR
*TRANSMISSION OF ONE WORD
       REM            
       BCD 1RDDB      
WHAT   TSX CLEAR,4    
       TSX SETR,4     GO TO RESET TRIGGERS
       XEC CHANA+7    WRS CHAN A
       XEC CHANA+11   RCHA-IOCD-WC1
       RDDB           
       RCHB OPER      IOCD-WC1
       PSLB PSL+6     PULSE TCU SELECTED
       PSLB PSL+11    PULSE DEMAND A AND B
       PSLB PSL+4     PULSE EOR-A
       CLA TEMP       WORD READ
       LDQ ONES       CORRECT WORD
       CAS ONES       
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-2,4  TRY AT READING
       NOP WHAT       DIRECT DATA
       TSX SPLAT,4    FAILED. WORD EITHER
       PZE OVER       NOT TRANSMITTED, OR
       TSX OK,4       ERROR IN WORD
       TRA WHAT       
       REM            
       REM            
*ATTEMPT TO HIT WORST CASE, WHICH WOULD BE TO TRANSMIT
*A WORD EVERY 36US.  60US IS AS CLOSE AS PROGRAM CAN COME.
       REM            
       BCD 1WDDB      
       REM            
SHE    TSX CLEAR,4    
       TSX SETR,4     GO TO RESET TRIGGERS
       WDDB           WRITE DIRECT DATA
       RCHB MAKE      IORP-WC 36
       XEC CHANA+8    RDS CHAN A
       XEC CHANA+12   
       PSLB PSL+6     PULSE TCU SELECTED
       AXT 36,1       
       STZ RDFLD+36,1 CLEAR
       TIX *-1,1,1    READ FIELD
       PSLB PSL+5     PULSE 1ST WD TEST-A
       PSLB PSL+11    PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       XEC SHE+11     PULSE DEMAND A AND B
       PSLB DONT      PULSE EOR - A AND B
       AXT 36,1       
       CLA RDFLD+36,1 WORD READ
       LDQ WRFLD+36,1 CORRECT WORD
       CAS WRFLD+36,1 
       TRA *+2        ERROR
       TRA *+4        OK
       SLN 1          
       TSX ERROR-2,4  DATA FAILURE DURING
       NOP SHE        48 US WORST CASE
       TIX *-8,1,1    CHECK ALL WORDS
       SLT 1          
       TRA *+3        OK-OFF
       TSX SPLAT,4    
       PZE OVER       
       TRA *+2        CONTINUE
       REM            
       BCD 1IOT       
       REM            
USTA   IOT            
       TRA *+2        ON-ERROR
       TRA *+7        OFF-OK
       TSX ERROR-1,4  I/O CK LIGHT ON
       TXL USTA       PROBABLY AS RESULT OF
       TSX SPLAT,4    RATE OF TRANSMISSION
       PZE HILLN      OF DATA
       TSX SPLAT,4    
       PZE HILLN+13   
       TRA *+2        
       REM            
       BCD 1EOF       
       REM            
BE     TEFB *+5       
       TSX ERROR-1,4  IND 1 ON-WC 0
       TXL BE         DID NOT BRING
       TSX SPLAT,4    UP EOF CHAN B
       PZE DALE       
       TSX OK,4       
       TRA SHE        
       REM            
       REM            
       NOP            
       REM            
       REM            
*TEST FOR POSSIBLE TRANSMISSION OF DATA EVERY 36 US
       REM            
       REM            
TIME   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       CLA TEST       TEST FOR FIRST PASS
       TZE *+2        ZERO - YES
       TRA TRP        NOT ZERO - CONTINUE
       STL TEST       SET SWITCH
       REM            
       REM            
       HTR *+1        THROW END OPN SW ON MF C.E.
       REM            PANEL TO ON POSITION
       REM            
       REM            
       WDDB           
       RCHB OPER2     IOCD - WC1, ALL ONES
       XEC CHANA+8    READ SELECT CHAN A
       XEC CHANA+10   RCHA, IOCD - WC 1
       PSLB PSL+6     PULSE TCU SEL - A
       PSLB PSL+5     PULSE 1ST WD TEST - TEST
       PSLB PSL+11    PULSE DEMAND A AND B
       TCOB *         IF PROGRAM HANGS UP AT
       REM            THIS LOCATION , B TIME WAS
       REM            NOT ABLE TO GET IN DURING
       REM            ER TIME OF TCOB.
       REM            PAGE 8.05.05
       HTR *+1        RETURN END OPN SW TO
       REM            OFF POSITION
       PSLB PSL+4     PULSE EOR CHANNEL A
       RCHB ZERO      DISCONNECT
       TSX OK,4       
       TRA TIME       
       REM            
       REM            
*      CHECK THAT INTERRUPT WHEN NOT ENABLED DOES NOT TRAP
       REM            
       BCD 1TRAP      TEST CONDITION
TRP    TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       TSX RSTRP,4    
       WDDB           RESET TRAP TRIGGERS OFF
       RCHB ZERO      DISCONNECT
       TCOB *         SHOULD BE OUT OF OPN
       ENB ZERO       DISABLE ALL CHANNELS
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          
       TRA *+3        OK - SHOULD NOT TRAP
       TSX SPLAT,4    
       PZE SBCD5,0,0  TRAPPED WITH ALL CHANNELS
       REM            DISABLED
       TSX OK,4       
       TRA TRP        
       REM            
       REM            
*      ENABLE AND INTERRUPT - CHECK FOR TRAP AND RETURN
       REM            
       BCD 1TRAP      TEST CONDITION
TRP1   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       TSX RSTRP,4    
       WDDB           RESET TRAP TGRS
       RCHB ZERO      DISCONNECT
       TCOB *         SHOULD BE OUT OF OPN
       REM            
       REM            
       ENB ALL        ENABLE ALL CHANNELS
       STZ TPCK       TRAP EXPECTED
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          TRAP FROM THIS LOCATION
       TRA *+2        
       TRA *+4        OK - SHOULD TRAP
       TSX SPRT,2     
       TSX SPLAT,4    
       PZE SBCD6,0,0  FAILED TO TRAP WITH ALL
       REM            CHANNELS ENABLED
       TSX OK,4       
       TRA TRP1       
       REM            
       REM            
*      CHECK THAT ENABLE WITH ZERO DISABLES CHANNEL AFTER PREVIOUS TRAP
       REM            
       BCD 1TRAP      TEST CONDITION
TRP2   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       TSX RSTRP,4    
       WDDB           RESET TRAP TRIGGERS OFF
       RCHB ZERO      DISCONNECT
       TCOB *         SHOULD BE OUT OF OPN
       ENB ALL        ENABLE ALL CHANNELS
       STZ TPCK       TRAP EXPECTED
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          TRAP FROM THIS LOCATION
       TRA *+2        ERROR-FAILED TO TRAP
       TRA *+5        OK - SHOULD TRAP
       TSX SPRT,2     
       TSX SPLAT,4    
       PZE SBCD6,0,0  FAILED TO TRAP WITH ALL
       REM            CHANNELS ENABLED
       TRA *+12       
       REM            
       TSX RSTRP,4    
       WDDB           RESET TRAP TRIGGERS OFF
       RCHB ZERO      DISCONNECT
       TCOB *         SHOULD BE OUT OF OPN
       ENB ZERO       DISABLE ALL CHANNELS
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          TRAP FROM THIS LOCATION
       TRA *+3        OK-SHOULD NOT TRAP
       TSX SPLAT,4    
       PZE SBCD5,0,0  TRAPPED WITH ALL CHANNELS
       REM            DISABLED
       TSX OK,4       
       TRA TRP2       
       REM            
       REM            
*      INTERRUPT WHEN NOT ENABLED - THEN ENABLE AND CHECK FOR TRAP
       REM            
       BCD 1TRAP      TEST CONDITION
TRP3   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       TSX RSTRP,4    
       WDDB           RESET TRAP TRIGGERS OFF
       RCHB ZERO      DISCONNECT
       TCOB *         SHOULD BE OUT OF OPN
       ENB ZERO       DISABLE ALL CHANNELS
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          TRAP FROM THIS LOCATION
       TRA *+4        OK-SHOULD NOT TRAP
       TSX SPLAT,4    
       PZE SBCD5,0,0  TRAPPED WITH ALL CHANNELS
       REM            DISABLED
       TRA *+11       
       REM            
       TSX RSTRP,4    
       STZ TPCK       TRAP EXPECTED
       TSX *+1,2      SET XRB FOR RETURN
       ENB ALL        ENABLE ALL CHANNELS
       NOP *          TRAP FROM THIS LOCATION
       TRA *+2        ERROR-FAILED TO TRAP
       TRA *+4        OK-SHOULD TRAP
       TSX SPRT,2     
       TSX SPLAT,4    
       PZE SBCD7,0,0  FAILED TO TRAP FROM ENABLE
       REM            WITH A TRAP CONDITIONED
       TSX OK,4       
       TRA TRP3       
       REM            
       REM            
*      INTERRUPT WHEN INHIBITED - RESTORE AND CHECK FOR TRAP
       REM            
       BCD 1TRAP      TEST CONDITION
TRP4   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       TSX RSTRP,4    
       WDDB           RESET TRAP TRIGGERS OFF
       RCHB ZERO      DISCONNECT
       TCOB *         SHOULD BE OUT OF OPN
       ENB ALL        ENABLE ALL CHANNELS
       STZ TPCK       TRAP EXPECTED
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          TRAP FROM THIS LOCATION
       TRA *+2        ERROR-FAILED TO TRAP
       TRA *+5        OK-SHOULD HAVE TRAPPED
       TSX SPRT,2     
       TSX SPLAT,4    
       PZE SBCD6,0,0  FAILED TO TRAP WITH ALL
       REM            CHANNELS ENABLED
       TRA *+18       
       REM            
       REM            
*      NOW CHANNEL SHOULD BE INHIBITED
       REM            
       TSX RSTRP,4    
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          TRAP FROM THIS LOCATION
       TRA *+4        OK-SHOULD NOT TRAP
       TSX SPLAT,4    
       PZE SBCD8,0,0  TRAPPED IN ERROR WHILE
       REM            INHIBITED
       TRA *+10       
       STZ TPCK       TRAP EXPECTED
       TSX *+1,2      SET XRB FOR RETURN
       RCT            RESTORE
       NOP *+1        TRAP FROM NEXT LOCATION
       TRA *+2        ERROR - FAILED TO TRAP
       TRA *+4        OK-SHOULD TRAP
       TSX SPRT,2     
       TSX SPLAT,4    
       PZE SBCD9,0,0  FAILED TO TRAP FROM RESTORE
       REM            WITH AN INHIBITED TRAP
       REM            CONDITIONED
       TSX OK,4       
       TRA TRP4       
       REM            
       REM            
*      INTERRUPT WHEN INHIBITED - ENABLE AND CHECK FOR TRAP
       REM            
       REM            
       BCD 1TRAP      TEST CONDITION
       REM            
TRP4A  TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       TSX RSTRP,4    
       WDDB           RESET TRAP TRIGGERS OFF
       RCHB ZERO      DISCONNECT
       TCOB *         SHOULD BE OUT OF OPERATION
       ENB ALL        ENABLE ALL CHANNELS
       STZ TPCK       TRAP EXPECTED
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          TRAP FROM THIS LOCATION
       TRA *+2        ERROR - FAILED TO TRAP
       TRA *+5        OK - SHOULD HAVE TRAPPED
       TSX SPRT,2     
       TSX SPLAT,4    
       PZE SBCD6,0,0  FAILED TO TRAP WITH ALL
       REM            CHANNELS ENABLED
       TRA *+18       
       REM            
       REM            
*      NOW CHANNEL SHOULD BE INHIBITED
       REM            
       TSX RSTRP,4    
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          MIGHT TRAP FROM THIS LOC
       TRA *+4        OK - SHOULD NOT TRAP
       TSX SPLAT,4    
       PZE SBCD8,0,0  TRAPPED IN ERROR WHILE
       REM            INHIBITED
       TRA *+10       
       STZ TPCK       TRAP EXPECTED
       TSX *+1,2      SET XRB FOR RETURN
       ENB ALL        ENABLE ALL CHANNELS
       NOP *+1        TRAP FROM NEXT LOCATION
       TRA *+2        ERROR - FAILED TO TRAP
       TRA *+4        OK - SHOULD TRAP
       TSX SPRT,2     
       TSX SPLAT,4    
       PZE BCD49,0,0  FAILED TO TRAP FROM ENABLE
       REM            WITH AN INHIBITED TRAP
       REM            CONDITIONED
       TSX OK,4       
       TRA TRP4A      
       REM            
       REM            
*      ENABLE FOR A DIFFERENT CHANNEL AND CHECL THAT NO TRAP OCCURS
       REM            
       REM            
       BCD 1TRAP      TEST CONDITION
       REM            
TRP5   TSX CLEAR,4    MONITOR
       TSX SETR,4     GO TO RESET TRIGGERS
       TSX RSTRP,4    
       WDDB           RESET TRAP TRIGGERS OFF
       RCHB ZERO      DISCONNECT
       TCOB *         SHOULD BE OUT OF OPN
       CLA CHANA+7    L SELECT
       ARS 9          MOVE CHANNEL TO LOW ORDER
       ANA SEVEN      
       PAX 0,1        L CHN COUNT IN XRA
       STA *+16       SET CHANNEL COUNT
       ENB ENBC,1     ENABLE CURRENT CHANNEL
       STZ TPCK       TRAP EXPECTED
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          TRAP FROM THIS LOCATION
       TRA *+2        ERROR-FAILED TO TRAP
       TRA *+5        OK - SHOULD TRAP
       TSX SPRT,2     
       TSX SPLAT,4    
       PZE BCD50,0,0  FAILED TO TRAP WITH SINGLE
       REM            CHANNEL ENABLED
       TRA *+13       
       REM            
       REM            
       TSX RSTRP,4    
       WDDB           RESET TRAP TRIGGERS OFF
       RCHB ZERO      DISCONNECT
       TCOB *         SHOULD BE OUT OF OPN
       AXT **,1       L CHN COUNT IN XRA
       ENB ENBC+1,2   ENABLE OTHER CHANNELS
       TSX *+1,2      SET XRB FOR RETURN
       PSLB NTRPT     INTERRUPT
       NOP *          TRAP FROM THIS LOCATION
       TRA *+3        OK - SHOULD NOT TRAP
       TSX SPLAT,4    
       PZE BCD51,0,0  TRAPPED IN ERROR WHEN
       REM            ENABLED FOR A DIFFERENT CHN
       WDDB           
       RCHB ZERO      
       TSX OK,4       
       TRA TRP5       
       REM            
       REM            
       NOP            
       CLA CTR        
       ADD ONE        
       STO CTR        
       SUB CTRCK      
       TMI TROT       
       REM            
       CAL MSK1       CLEAR
       ANS SWT5+8     PRINT
       ANS SWT5+9     IMAGE
       REM            
       CAL CHANA-1    L CHANNEL A SELECT
       ANA MSK3       RETAIN CHANNEL
       LGR 3          INSERT CURRENT
       ORS SWT5+8     CHANNEL IN IMAGE
       REM            
       CAL TRP5+3     L CHN B SELECT
       ANA MSK3       RETAIN CHANNEL
       LGR 3          INSERT CURRENT
       ORS SWT5+9     CHANNEL IN IMAGE
       REM            
       TRA INTL1-5    
       REM            
       REM            
SWT5   TSX SPLAT-1,4  
       MZE 8,0,6      
       BCD 69DD1 -- 200 PASSES COMPLETE ON CHANN
       BCD 2ELS A AND B
       REM            
       REM            
       SWT 5          CHECK SENSE SWITCH 5
       TRA *+2        UP-TEST SWITCH 6
       TRA RUC        DOWN - REPEAT WITHOUT
       REM            9IOM HALT
       SWT 6          
       TRA *+2        UP-CALL NEXT PROGRAM
       TRA CBEGN      REPEAT AFTER HALT TO
       REM            ENTER KEYS
       REM            
*      IF CHANNELS ARE CHANGED HERE THE DIRECT DATA TEST EQUIPMENT
*      BOX AND CABLES MUST BE SHIFTED TO SUIT BEFORE PRESSING
*      START WITH THE NEW KEY ENTRY
       REM            
       REM            
FINL1  PZE **         READ SELECT NEXT PROGRAM
       RCHA *+3       
       LCHA 0         
       TRA 1          
       REM            
       IOCT 0,0,3     
       REM            
       REM            
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
       REM            
*      ERROR CHECK AND PRINT SUBROUTINE
       REM            
RSTRP  AXT 25,1       L +25 IN XRA
       STZ 26,1       CLEAR
       TIX *-1,1,1    TRAP AREAS
       CLA STR1       L TRA STPRT - SET
       STO 4          RETURN FROM TRAP
       STO TPCK       SET NO TRAP INDICATION
       TRA 1,4        RETURN TO PROGRAM
       REM            
SPRT   CAL -3,2       L TRAP LOCATION
       ANA ADRS       CLEAR TO ADDRESS
       SLW MSK2       SAVE CORRECT TRAP WORD
       CLA TRP4+3     L SELECT
       ARS 9          MOVE CHANNEL TO LOW ORDER
       ANA SEVEN      CLEAR TO CHANNEL COUNT
       PAX 0,1        L CHANNEL COUNT IN XRA
       CLA TPDC+8,1   L CORRECT DECREMENT
       ORS MSK2       PLACE INTO CORRECT WORD
       TSX LOC3,4     GO TO INSERT PRINT IMAGES
       TSX SPLAT,4    GO TO PRINT
       MZE SBCD1      
       SLN 1          TURN ON SENSE LIGHT 1
       TRA SPRT1      
       REM            
STPRT  CAL 2,2        L TRAP LOCATION
       ANA ADRS       CLEAR TO ADDRESS
       SLW MSK2       SAVE CORRECT TRAP WORD
       CLA TRP4+3     L SELECT
       ARS 9          MOVE CHANNEL TO LOW ORDER
       ANA SEVEN      CLEAR TO CHANNEL COUNT
       PAX 0,1        L CHANNEL COUNT IN XRA
       CLA TPDC+8,1   L CORRECT DECREMENT
       ORS MSK2       PLACE INTO CORRECT WORD
       NZT TPCK       CHK IF SHOULD TRAP
       TRA *+5        ZERO - SHOULD TRAP
       TSX LOC3,4     GO TO INSERT PRINT IMAGES
       TSX SPLAT,4    GO TO PRINT
       MZE SBCD       
       TRA SPRT1      
       CLA MSK2       L CORRECT TRAP WORD
       CAS 3          COMPARE TRAP LOCATION
       TRA *+2        ERROR
       TRA RET1-2     OK
       TSX LOC3,4     GO TO INSERT PRINT IMAGES
       TSX SPLAT,4    GO TO PRINT
       MZE SBCD2      
SPRT1  TSX SPLAT,4    
       PZE SBCD3      
       TSX SPLAT,4    GO TO PRINT
       PZE SBCD4      
       SLT 1          CHECK SENSE LIGHT 1
       TRA 4,2        OFF - RETURN TO PROGRAM
RET1   TRA 1,2        ON - RETURN TO PROGRAM
       REM            
LOC3   AXT 36,1       L +44 IN XRA
       LDQ 3          L TRAP LOC CONTENTS IN MQ
       PXA 0,0        CLEAR ACC
       ALS 3          SPACE TRAP
       LGL 3          INFORMATION
       TIX *-2,1,6    FOR PRINT IMAGES
       SLW SBCD4+5    STORE IN BCD IMAGE
       ALS 3          SPACE TRAP
       LGL 3          INFORMATION
       TIX *-2,1,1    FOR PRINT IMAGES
       SLW SBCD4+6    STORE IN BCD IMAGE
       ORA MTW        L +6 IN PREFIX
       SLW SBCD+9     STORE IN BCD IMAGE
       SLW SBCD2+9    STORE IN BCD IMAGE
       AXT 36,1       L +44 IN XRA
       LDQ MSK2       L CORRECT WORD IN MQ
       PXA 0,0        CLEAR ACC
       ALS 3          SPACE TRAP
       LGL 3          INFORMATION
       TIX *-2,1,6    FOR PRINT IMAGES
       SLW SBCD3+5    STORE IN BCD IMAGE
       ALS 3          SPACE TRAP
       LGL 3          INFORMATION
       TIX *-2,1,1    FOR PRINT IMAGES
       SLW SBCD3+6    STORE IN BCD IMAGE
       ORA MTW        L +6 IN PREFIX
       SLW SBCD1+9    STORE IN BCD IMAGE
       TRA 1,4        RETURN
       REM            
       REM            
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
       REM            
       REM            
*      MONITOR SUBROUTINE
*      PROGRAM PROGRESSION CONTROL
       REM            
       REM            
       BCD 1SPACE     
       REM            
SPACE  SXD BIN,4      SPACE ADDRESS
       LDC BIN,4      XRC TRUE TO DECREMENT
       SXD BIN,4      OF BIN
       LDC MONIT,4    ADDRESS OF TEST
       SXA BIN,4      THAT LOST CONTROL
       REM            TO ADDRESS
       REM            
       LDI BIN        ADDRESS PROGRAM SKIPPED
       REM            TO IN DECREMENT OF
       REM            INDICATORS.
       REM            
       REM            ADDRESS OF TEST BEING
       REM            PERFORMED IN ADDRESS
       REM            OF INDICATORS
       TSX ERROR-1,4  
       NOP SPACE      
       LXD MONIT,4    
       CLA -2,4       RESET MONIT
       PAC 0,2        AND RETURN
       SXD MONIT,2    TO PROPER
       TRA *+4        SEQUENCE
       REM            
CLEAR  SLF            
       SWT 1          
       TRA *+2        
       TRA *+3        
       SWT 4          
       TRA *+4        NOT REPEATED
       PXD 0,4        TEST REPEATED
       SUB MONIT      OR WILL BE
       TZE RESET+1    REPEATED-IF ZERO
       REM            PROGRAM SEQUENCE OK.
       REM            
       STZ FREE       
       SXD FREE,4     SAVE TEST ADDRESS
       CLA -2,4       PRECEEDING TEST ADDRESS
       PAC 0,4        COMPLEMENT
       PXD 0,4        
       SUB MONIT      SHOULD BE ZERO
       LXD FREE,4     RESTORE XRC
       TZE RESET+1    IF ZERO, PROGRAM
       REM            SEQUENCE OK.
       REM            
       ENK            CHECK FOR MANUAL TRANSFER
       XCA            
       PAC 0,4        COMPLEMENT KEYS ADDRESS
       LRS 21         CHECK TRA ONLY
       REM            
       SUB K41        -0200
       TNZ *+5        SEQUENCE N.G. IF NOT 0
       PXD 0,4        OK, CHECK ADDRESS
       SUB FREE       
       LXD FREE,4     RESTORE
       TZE RESET+1    OK IF ZERO
       REM            
       LXD FREE,4     PROGRAM OUT OF
       TTR SPACE      SEQUENCE
       REM            
       REM            
RESET  SLF            
       SXD MONIT,4    MONITOR
       LDC MONIT,4    
       TXI *+1,4,1    FOR RETURN
       SXA EXIT,4     
       PXD 0,0        CLEAR ACC
       NOP            REPLACE WITH STZ 0 FOR FLPT
       LDQ            CLEAR MQ
       TOV *+1        TURN OFF
       NOP            
       DCT            
       NOP            
       PAI            RESET
       LXD 0,7        CLEAR ALL XRS
EXIT   TRA            RETURN TO PROGRAM
       REM            
BIN    OCT 0          
MONIT  OCT 0          
K41    OCT 200        
FREE   BSS 2          
       REM            
       REM            
       REM            INDEXABLE BCD PRINT SUBROUTINE.
       REM            
       REM            
       TRA SPLT1+3    
SPLAT  TRA SPLT1     CHECK FOR SENSE PRINTER
       SXA SPLAT+61,1 
       SXA SPLAT+62,2 
       SXA SUBET,4   SAVE ORGINAL XRC.
       NZT 1,4       IF CONTROL WORD ZERO.
       REM            
*5                    
       TRA 2,4       RETURN
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
       REM SET BIT INDEX TO STARTING WHEEL
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
       REM FORM CARD IMAGE.
       REM            
*25                   
       TIX *+1,4,1   ADDRESS OF FIRST WORD.
       AXT 6,1       CHARACTER COUNT.
       LDQ 1,4       GET THE WORD.
       REM           SOME PEOPLE NEVER
       REM           DO, YOU KNOW
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
       ORS* SPLAT+88,2 PUT EIGTH IN, TAKE
       TIX SPLAT+44,1,16 16 OUTM, - GOOD BUSINESS
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
SPLT1  SWT 2          AND SWITCHES
       TRA *+2        CHECK SWITCH 3
       TRA SPLIT      IGNORE ERROR
       REM            
       SWT 3          TEST THREE
       TRA *+2        UP-PRINT
       TRA SPLIT      DOWN-RETURN
       REM            
       CLA 1,4        
       WPRA           
       TMI *+2        SENSE PRINTER
       TRA SPLAT+1    
       SPRA 3         
       TRA SPLAT+1    
       REM            
SPLIT  CLA 1,4        SPLAT PROGRAM CONTROL WORD
       STA *+5        
       ARS 18         MOVE DECREMENT TO ADDRESS
       TNZ *+2        ZERO IF REMOTE
       STA *+2        SET RETURN ADDRESS
       TIX *+1,4,2    
       TRA **,4       RETURN TO PROGRAM
       REM            
       REM            
       REM            
START  AXT 32767-PR,1 
       CLA *+8        L TSX SPACE,4
       STO 0,1        
       TIX *-1,1,1    
       REM            
       AXT 2868-BCD51,1
       CLA *+4        L TSX SPACE,4
       STO 2880,1     
       TIX *-1,1,1    
       TRA 24         
       REM            
       TSX SPACE,4    CONSTANT
       REM            
       REM            
       REM            
*      CONSTANTS      
       REM            
       REM            
SEVEN  OCT 7          
ORIG   OCT **         ORIGINAL CTRL1
       OCT **         ORIGINAL CTRL2
       OCT **         ORIGINAL CTRL3
       REM            
K      OCT +310       200 PAUSES
CTR    OCT **         
CTRCK  OCT **         
       REM            
MSK1   OCT 777777776077
MSK3   OCT 000000017000
       REM            
STR1   TRA STPRT      
       REM            
       OCT 040000     ENABLE CHN F
       OCT 012000     ALL CHNS BUT F
       OCT 010000     ENABLE CHN D
       OCT 042000     ALL CHNS BUT D
       OCT 002000     ENABLE CHN B
ENBC   OCT 050000     ALL CHNS BUT B
       REM            
SK1    RTBA 1         READ TAPE UNIT 1 - CHN A
       RCDA           READ CARDS - CHN A
       OCT +000000000007 MASK FOR CARD MACHINES
       REM            
SYNCW  OCT -000000000430  EXCLU UNIT 1 - CHN A
       OCT +000000043000  EXCLU UNIT 1 - CHN B
       OCT +000000000430  EXCLU UNIT 1 - CHN C
       OCT +000000043000  EXCLU UNIT 1 - CHN D
       OCT +000000000430  EXCLU UNIT 1 - CHN E
       OCT +000000043000  EXCLU UNIT 1 - CHN F
       REM            
ZERO   OCT 0          
MSK2   OCT **         CORRECT CONTENTS OF LOC 3
ADRS   OCT 000000077777
TPCK   OCT **         ZERO IF SHOULD TRAP
MTW    MTW 0          6 IN PREFIX
ALL    OCT 000000052000
       REM            
TPDC   PZE 0,0,128    CHANNEL H
       PZE 0,0,64     CHANNEL G
       PZE 0,0,32     CHANNEL F
       PZE 0,0,16     CHANNEL E
       PZE 0,0,8      CHANNEL D
       PZE 0,0,4      CHANNEL C
       PZE 0,0,2      CHANNEL B
       PZE 0,0,1      CHANNEL A
       REM            
       REM            
PSL    PZE 0,0,1      PULSE DEMAND-CHAN B
       PZE 0,0,2      PULSE END OF FILE-CHAN A
       PZE 0,0,4      PULSE DD INTERRUPT
       PZE 0,0,8      PULSE EOR - CHAN B
       PZE 0,0,16     PULSE EOR - CHAN A
       PZE 0,0,32     PULSE 1ST WD TEST - CHAN A
       PZE 0,0,64     PULSE TCU SELECTED - CHAN A
       PZE 0,0,128    PULSE RDNCY CHECK - CHAN A
       PZE 0,0,256    PULSE DEMAND - CHAN A
       PZE 0,0,512    PULSE LD PT IND - CHAN A
       PZE 0,0,642    PULSE RDNCK, EOF, BOT
       PZE 0,0,257    PULSE DEMAND A AND B
       REM            
PSL2   PZE 0,0,36     
       PZE 0,0,68     
       PZE 0,0,132    
       PZE 0,0,260    
       PZE 0,0,516    
       REM            
SSL    PZE 0,0,20     
       PZE 0,0,12     
       REM            
SALON  OCT 100        
SAL    BCD 1ON 12     
ADD    OCT 10000      
MASK   OCT 777777700077
NINE   OCT 1100       
SALO   BCD 1SS 5.     
NOD    IORT WRFLD,0,10 
POST   TRA TROT       
TEST   OCT 0          
FIX    HTR PSL+7      
       HTR PSL+7      
WAIT   OCT 0          
       HTR WAIT       
TALLO  OCT 30         
AALLO  OCT 777777777776 ALMOST ALL ONES
ONE    OCT 1          
       REM            
       WTBA 1         DUMMY SELECT FROM 9IOM
CHANA  BTTA           TEST FOR POSITION 12
       TRCA BOOZE     TEST FOR POSITION 10
       TEFA HIC       TEST FOR POSITION 9
       BTTA           TURN OFF BOT IND
       TRCA OUT+5     
       TEFA OUT+6     
       ETTA           TEST FOR SENSE OUTPUT RESET
       WTBA 1         TEST FOR SENSE INPUTS 8-12
       RTBA 1         
       RCHA ALTAR     IOCD-WC 36
       RCHA THE       IOCD-WC 1
       RCHA OPER2     IOCD WC 1
       RCHA MED       IORP-WC 36
       TRCA TRUMP     TEST POSITION 10
       TEFA TRUMP+3   TEST POSITION 16
       TRCA SPOT+9    
       TRCA CHECK+8   
       TRCA ROL+9     
       TRCA SETR+8    
       TRCA SETR+9    
       REM            
WRFLD  BSS 36         BLOCK FOR 36 POSITION RIPPLE
RDFLD  BSS 36         BLOCK FOR READ AREA
       REM            
OPER2  IOCD ONES,0,1  
ONES   OCT 777777777777
OPER1  IORP 0         
       IOCD 0         
TEMP   OCT 0          
OPER   IOCD TEMP,0,1  
COMP   PZE 0,0,22     
       PZE 0,0,13     
       REM            
LEAD   OCT 0          TEMP STORAGE
ME     PZE 0,0,4      BIT TO CHECK FOR SSL.
TO     OCT 0          TEMP STORAGE
THE    IOCD RINK,0,1  
ALTAR  IOCD RDFLD,0,36 
BUT    IOCD WRFLD,0,36 
DONT   PZE 0,0,24     EOR A AND B
MAKE   IORP WRFLD,0,36 
       IOCD 0         
MED    IORP RDFLD,0,36 
       IOCD 0         
RINK   OCT 0          
       REM            
PASS   PZE 10,0,1     
       BCD 6STORE SENSE LINES ACTED AS STORE CH
       BCD 4NNEL. PAGE 60.04.41
       REM            
HIM    PZE 10,0,1     
       BCD 6POSITION 12 FAILED DURING PRESENT SE
       BCD 4NSE LINES. PAGE 60.04.42
       REM            
HIS    PZE 10,0,1     
       BCD 6POSITION 10 FAILED DURING PRESENT SE
       BCD 4NSE LINES. PAGE 60.04.42
       REM            
HAT    PZE 10,0,1     
       BCD 6POSITION 16 FAILED DURING PRESENT SE
       BCD 4NSE LINES. PAGE 60.04.42
HES    PZE 11,0,1     
       BCD 6SENSE OUTPUT RESET DID NOT COME UP B
       BCD 5EFORE PSLB. PAGE 60.04.41
       REM            
LEAV   PZE 11,0,1     
       BCD 6SENSE INPUT POSITION 15 FAILED DATA
       BCD 5REG. NOT LDD. PAGE 60.06.01
       REM            
ING    PZE 11,0,1     
       BCD 6SENSE INPUT POSITION 13 FAILED. WRIT
       BCD 5E DIRECT DATA. PAGE 60.06.01
       REM            
OLD    PZE 11,0,1     
       BCD 6SENSE INPUT POSITION 14 FAILED. READ
       BCD 5 DIRECT DATA. PAGE 60.06.01
       REM            
SIDE   PZE 8,0,1      
       BCD 6SENSE INPUT POSITION 12 FAILED. UNIT
       BCD 2 ADDRESS 5.
       REM            
KICK   PZE 12,0,1     
       BCD 6SENSE INPUT POSITION 16-CHAN RFY WR
       BCD 6FAILED, OR POSITION 13,15-PRE TESTD.
       REM            
MULE   PZE 12,0,1     
       BCD 6SENSE INPUT POSITION 17-CHAN RDY RD
       BCD 6FAILED, OR POSITIONS 14,15-PRE TESTD
       REM            
TRAIN  PZE 9,0,1      
       BCD 6RCHB, IORP WC 0 DID NOT BRING UP EOF
       BCD 3 ON CHANNEL B.
       REM            
CLIP   PZE 9,0,1      
       BCD 6PRESENT SENSE LINE 14 DID NOT DISCON
       BCD 3NECT CHAN B ON EOR
       REM            
PITY   PZE 11,0,1     
       BCD 6PRESENT SENSE LINES DID NOT TURN ON
       BCD 5ETT IND-SENSE OUTPUT RESET
       REM            
CLOP   PZE 10,0,1     
       BCD 6 FIRST TRY AT TRANSMITTING INFORMATIO
       BCD 4N FAILED AS SHOWN ABOVE
       REM            
PIN    PZE 12,0,1     
       BCD 636 WORDS WERE WRITTEN-1 BIT IN EACH
       BCD 6WD IN RIPPLE FASHION. ERROR AS SHOWN
       REM            
OVER   PZE 10,0,1     
       BCD 6DATA FAILED AS ABOVE WHILE WRITING W
       BCD 4ITH 48US BETWEEN DEMANDS
       REM            
HILLN  PZE 12,0,1     
       BCD 6I/O CK LITE WAS ON IN ERROR PROBABLY
       BCD 6 BECAUSE OF THE RATE AT WHICH THE
       PZE 5,0,1      
       BCD 5DATA WAS TRANSMITTED-60US
       REM            
DALE   PZE 8,0,1      
       BCD 6IND 1 ON-WC GOING TO ZERO DID NOT BR
       BCD 2ING UP EOF 
       REM            
SONG   PZE 6,0,1      
       BCD 6PRESENT SENSE LINES-INDEXED-FAILED
       REM            
BIRD   PZE 8,0,1      
       BCD 6PRESENT SENSE LINES-ENDIRECTLY ADDRE
       BCD 2SSED FAILED
       REM            
PARA   PZE 10,0,1     
       BCD 6PRESENT SENSE LINES-INDIRECTLY ADDRE
       BCD 4SSED ADN INDEXED-FAILED
       REM            
DISE   PZE 6,0,1      
       BCD 6STORE SENSE LINES-INDEXED-FAILED
       REM            
EDEN   PZE 8,0,1      
       BCD 6STORE SENSE LINES-INDIRECTLY ADDRESS
       BCD 2ED-FAILED 
       REM            
ADAM   PZE 10,0,1     
       BCD 6STORE SENSE LINES-INDIRECTLY ADDRESS
       BCD ED AND INDEXED-FAILED
       REM            
SBCD   PZE 9,0,1      
       BCD 6DIRECT DATA INTERRUPT TRAPPED IN ERR
       BCD 3OR AT LOC    00000
       REM            
SBCD1  PZE 9,0,1      
       BCD 6DIRECT DATA INTERRUPT FAILED TO TRAP
       BCD 3 AT LOCATION 00000
       REM            
SBCD2  PZE 9,0,1      
       BCD 6DIRECT DATA INTERRUPT TRAPPED INCORR
       BCD 3ECTLY AT LOC 000000
       REM            
SBCD3  PZE 6,0,6      
       BCD 6CORRECT LOCATION 3      000000000000
       REM            
SBCD4  PZE 6,0,6      
       BCD 6CONTENTS OF LOC. 3      000000000000
       REM            
SBCD5  PZE 6,0,1      
       BCD 6TRAPPED WITH ALL CHANNELS DISABLED
       REM            
SBCD6  PZE 7,0,1      
       BCD 5FAILED TO TRAP WITH ALL CHANNE
       BCD 2LS ENABLED 
       REM            
SBCD7  PZE 9,0,1      
       BCD 6FAILED TO TRAP FROM ENABLE WITH A TR
       BCD 3AP CONDITIONED
       REM            
SBCD8  PZE 6,0,1      
       BCD 6TRAPPED IN ERROR WHILE INHIBITED
       REM            
SBCD9  PZE 11,0,1     
       BCD 6FAILED TO TRAP FROM RESTORE WITH AN
       BCD 5INHIBITED TRAP CONDITIONED
       REM            
BCD49  PZE 11,0,1     
       BCD 6FAILED TO TRAP FROM ENABLE WITH AN I
       BCD 5NHIBITED TRAP CONDITIONED
       REM            
BCD50  PZE 7,0,1      
       BCD 6FAILED TO TRAP WITH SINGLE CHANNEL E
       BCD 1NABLED    
       REM            
BCD51  PZE 11,0,1     
       BCD 6TRAPPED WITH OTHER CHANNELS ENABLED
       BCD 5BUT NOT CHANNEL OPERATING
       REM            
CTRA   EQU 2884       
CTRB   EQU 2885       
CTRC   EQU 2886       
CTRD   EQU 2887       
CTRE   EQU 2888       
CTRF   EQU 2889       
IOCNT  EQU 2891       
IOC    EQU 2892       
CTX    EQU 2890       
IOCT   EQU 2883       
CTRL1  EQU 2880       
CTRL2  EQU 2881       
CTRL3  EQU 2882       
ERROR  EQU 3396       
OK     EQU 3401       
RECNO  EQU 3439       
WDNO   EQU 3438       
PR     EQU 4018       
RDNCK  EQU 3440       
BEGA   EQU CHANA-1    
ENDA   EQU WRFLD-1    
BEGB   EQU SETR       
ENDB   EQU SWT5       
EORB   EQU PSL+3      
NTRPT  EQU PSL+2      
       REM            
       END START      
