                                                             9S01 LA
                                                            7-01-58
       REM            9S01 L
       REM            
       REM            
*STORAGE DEFLECTION, STORAGE ONES AND ZEROS,
*AND RANDOM NUMBERS TESTS FOR 1,2, OR 4
*737 CORE STORAGES OF FOR ONE 738 CORE STORAGE
       REM            
       REM            
       REM            
       REM TEST FOR CAPACITY OF STORAGE
       REM            
       REM            THIS SECTION WILL BE
       REM            WRITTEN OVER DURING TEST
       REM            
       ORG 32479      
NPER   SWT 3          
       TRA *+2        
       TRA Z          
       REM            
       WPRA           
       SPRA 3         
       RCHA *+3       
       TCOA *         
       TRA Z          
       REM            
       IOCD PNPER,0,24 
       REM            
Z      CLA ZERO       L +0
       STO 32767      
       ADD K1+1       L +1
       STO 16383      
       ADD K1+1       
       STO 8191       
       ADD K1+1       
       STO 4095       
       REM            
       CLA 32767      L IS DEPENDENT UPON
       REM            SIZE OF STORAGE
       REM            
       TZE D          32K STORAGE
       SUB K1+1       L+1
       TZE D4         16K STORAGE
       SUB K1+1       
       TZE D6         
       SUB K1+1       
       TZE A1-3       4K STORAGE-BEGIN TESTING
       REM            
       HTR A1-3       ERROR IN TESTING
       REM            SIZE OF STORAGE
       REM            
D      CLA G8         
       STO K2         
       CLA H8         
       STO K3         
       CLA TS1        L +77777 IN DECR.
       TRA D7-1       
       REM            
D4     CLA G4         
       STO K2         
       CLA H4         
       STO K3         
       CLA TS1+1      L +37777
       TRA D7-1       
       REM            
D6     CLA G2         
       STO K2         
       CLA H2         
       STO K3         
       CLA TS1+2      L +17777
       REM            
       REM            
       SUB K1         
D7     STO BA         ADJUST CONSTANTS
       ARS 18         
       STA B5         
       STA B6         
       STA B7+5       
       STA C1+1       
       STA E4+4       
       STA E4+5       
       STA E7+1       
       STA E7+3       
       STA E9+4       
       STA E9+5       
       STA E12+3      
       STA E13+6      
       STA F1-6       
       STA F1+1       
       STA E14+10     
       STA B12        
       TRA A1-3       
       REM            
TS1    OCT 77777000000 
       OCT 37777000000 
       OCT 17777000000 
       REM            
K1     OCT 277000000  
       OCT 1          
       REM            
       REM            CHANGE K3 DEPEND SIZE STG
       REM            
H2     OCT 076404217501
H4     OCT 176404437501
H8     OCT 376404077501
       REM            
       REM            CHANGE K2 DEPEND SIZE STG
       REM            
G2     OCT 000000200000
G4     OCT 000000400000
G8     OCT 0          
       REM
* PRINT - NOW PERFORMING-9S01L-STORAGE TEST
* IMAGE - NOW PERFORMING-9S01L-STORAGE TEST
PNPER  OCT 000000045040  9 ROW LEFT
       OCT 040000000000  9 ROW RIGHT
       OCT 000000000000  8 L
       OCT 000000000000  8 R
       OCT 000000200200  7 L
       OCT 010000000000  7 R
       OCT 000003030000  6 L
       OCT 100000000000  6 R
       OCT 000004100400  5 L
       OCT 004400000000  5 R
       OCT 000000002000  4 L
       OCT 000000000000  4 R
       OCT 000000000002  3 L
       OCT 201100000000  3 R
       OCT 000000000020  2 L
       OCT 400200000000  2 R
       OCT 000000000004  1 L
       OCT 020000000000  1 R
       OCT 000001000030  0 L
       OCT 601300000000  0 R
       OCT 000006256503  11 L
       OCT 140000000000  11 R
       OCT 000000121200  12 L
       OCT 034400000000  12 R
       REM            
       REM            
       REM            
       REM BEGIN. DEFLECTION TEST
       REM            
       REM            
       SLF            
       SLN 1          LIGHT ONE FOR VISUAL
       REM            SIGNAL TO DEFINE WORKING
       REM            IN STORAGE DEFLECTION
       REM            
       REM            
       CLA K3         L 036404107501
A1     SUB K4         L 000004000001
       STA A2         
A2     STO 0          PUT IN STORAGE
       REM            
       CAS K2         L 000001000000
       TRA *+2        STG. LESS THAN ACC.
       TRA A3         OUT WHEN STORAGE IS EQUAL
       TRA A1         CONT.-STG MORE OR LESS
       REM            
A3     CLA K3         L 036404107501
       SUB K4         L 000004000001
       STA A4         
       STA A4+3       
       REM            
A4     CAS 0          COMPARE TEST WORD
       TRA *+2        STG LESS THAN ACC -NG
       TRA A5         STG EQUAL-OK
       LDQ 0          STG MORE OR LESS-NG
       REM
       HTR A5         ADDRESS OF MQ CONTAINS
       REM            LOCATION OF ERROR IN STG.
       REM            
       REM            FULL 36 BITS OF MQ
       REM            CONTAIN ERROR WORD
       REM            
       REM            ACC. ADDR. CONTAINS
       REM            CORRECT ADDRESS
       REM            
       REM            FULL 36 BITS OF ACC.
       REM            CONTAIN CORRECT WORD
       REM            
A5     LDQ K5         L TRA A7-1
       STA A6         ADJUST STQ ADDR
       STA A6+1       ADJUST TRA ADDR
       STA A6+2       ADJUST STO ADDR
A6     STQ            PLACE RETURN TRA INTO X ADDR
       TRA            TRA TO X ADDR
       STO            CORRECT WORD BACK INTO STG
       REM            
A7     CAS K2         L 000001000000
       TRA A3+1       NO
       TRA A8         EQUAL-TEST FOR REPEAT
       TRA A3+1       NO
A8     SWT 1          TEST SWITCH FOR REPEAT
       TRA B2         NO-OUT TO ONES AND ZEROS
       TRA A1-2       YES-REPEAT
       REM            
       REM            
       REM BEGIN. ONES AND ZEROS
       REM            
       REM            
B2     SLF            TURN OFF LIGHT ONE
       REM            
       SLN 2          LIGHT TWO FOR VISUAL
       REM            SIGNAL TO DEFINE WORKING
       REM            IN ONES AND ZEROS
       REM            
       CLA B11        L-377777777777
       REM            
       REM            TEST SENSE SWITCH 5
       SWT 5          DOWN-ONES ONLY
       TRA B3         NO EFFECT
       TRA B4         TEST ONES ONLY
       REM            
       REM            TEST SENSE SWITCH 4
B3     SWT 4          DOWN-ZEROS ONLY
       SLN 4          TURN ON SIGNAL AND
       REM            ALTERNATE ZEROS AND ONES
       REM            
       CLA ZERO       L ZERO TEST WORD
B4     LXA B12,3      L IS DEPENDENT UPON
       REM            SIZE OF STORAGE
B5     STO A1-3,2     WRITE TEST WORD
       TIX B5,2,1     
B6     CAS A1-3,1     READ AND CHECK
       REM            TEST WORD
       TRA B7         ERROR
       TRA B8         OK
       REM            
       REM            TEST SENSE SWITCH 3
B7     SWT 3          ERROR, PRINT OR STOP
       TRA C1         PRINT ON ERROR
       STO B          SAVE CORRECT WORD
       PXD 0,1        STOP ON ERROR
       REM            
       SUB BA         ERROR ADDR IN ACC DECR.
       REM            
       LDQ A1-3,1     TESTO WORD IN ERROR IN
       REM            QUOTIENT
       HTR PRINT-5    ERROR STOP
       REM            
B8     TIX B6,1,1     
       SLT 4          TEST AND RESET SIGNAL
       TRA PRINT-3    REPEAT TEST
       CLA B11        L ONES
       TRA B4         TEST ONES
       REM            
C1     STO B          SAVE TEST WORD
       CAL A1-3,1     TEST WORD IN ERROR
       SLW C3         
       COM            
       SLW C5         ERROR ZEROS IN PRINT
       PXD 0,1        
       SUB BA         L 7502 IN DECR
       STD C2         ERROR ADDRESS ONES
       REM            IN PRINT
       COM            
       STD C4         ERROR ADDRESS ZEROS
       REM            IN PRINT
       TSX PRINT,4    
       CLA B          CORRECT WORD
       TIX B6,1,1     CONTINUE COMPARING
       SWT 1          
       TRA E1         UP-GO TO RANDOM NUMBERS
       TRA B2+2       DOWN-REPEAT ONES-ZEROS
       REM            
       REM            
       REM PRINT ROUTINE FOR ERROR
       REM            
       REM            
PRINT  WPRA           
       SPRA 4         TO GET OCTAL SPACING
       SXD B12,2      SAVE COUNT
       LXA E2,2       L +17
       RCHA C8        CONTROL PRINT 9L
       LCHA C8        CONTROL PRINT 9R-2R
       TIX *-1,2,1    
       LCHA C8+1      CONTROL PRINT 1L-0R
       TCOA *         DELAY
       REM
       LXD B12,2      
       TRA 1,4        RETURN TO CONTINUE COMPARING
       REM            
       REM BEGIN. RANDOM NUMBERS TEST
       REM            
       REM            
E1     SLF            TURN ON LIGHT TWO
       REM            
       SLN 3          LIGHT THREE FOR VISUAL
       REM            SIGNAL TO DEFINE WORKING
       REM            IN RANDOM NUMBERS
       REM            
       LXA B12,1      L 7500
       TIX E8,2,1     
       LXD E2,2       L +2
       LDQ E3         
       MPY E3         
E4     LGL 17         
       TNZ E5         
       LGL 18         
       TNZ E5         
       REM            
       LDQ A1-3,1     
       MPY A1-3,1     
E5     TOV E6         
       REM            
E6     LGL 1          
       TNO E7         
       SSM            
E7     TNX E1+2,1,1   
       STO A1-3,1     RANDOM NUMBER INTO STG.
       XCA            
       MPY A1-3,1     
       TRA E4         
       REM            
E8     LDQ E3         
       MPY E3         
E9     LGL 17         
       TNZ E10        
       LGL 18         
       TNZ E10        
       LDQ A1-3,1     
       MPY A1-3,1     
E10    TOV E11        
E11    LGL 1          
       TNO E12        
       SSM            
E12    TNX F1-3,1,1   
       REM            
       ALS 2          CLEAR P AND Q BITS
       ARS 2          
       CAS A1-3,1     COMPARE WORD WRITTEN
       REM            WITH WORD READ
       REM            
       TRA E13        ERROR
       TRA F1         OK
E13    STO B          SAVE CORRECT WORD
       XCA            
       PXD 0,1        
       SUB BA         L 7500 IN DECR
       REM            
       SWT 3          
       TRA E14        ERROR PRINT
       REM            
       LDQ A1-3,1     
       HTR F1-7       ERROR ADDRESS IN ACC DECR
       REM            ERROR WORD IN MQ
       REM            
E14    STD C2         ERROR ADDRESS
       COM            
       STD C4         COMPLEMENT OF ERROR ADDR
       STQ C3         CORRECT WORD
       XCL            
       COM            
       SLW C5         COMPLEMENT OF CORRECT WORD
       REM            WORD
       TSX PRINT,4    
       STZ C4         
       STZ C2         
       CAL A1-3,1     
       SLW C3         ERROR WORD
       COM            
       SLW C5         COMPLEMENT OF ERROR WORD
       REM            
       TSX PRINT,4    
       LDQ B          CORRECT WORD
       STQ A1-3,1     PUT CORRECT WORD
       REM            BACK INTO STORAGE
       MPY B          
       TRA E9         CONTINUE COMPARING
       REM            
       SWT 1          TEST SENSE SWITCH 1
       TRA F7         UP-GO TO READ NEXT PROG.
       REM            FROM CRD RDR OR CONTINUE
       REM            
       TRA F          
F1     XCA            
       MPY A1-3,1     
       TRA E9         
       REM            
F      CAL E3         CHANGE
       ACL BA         RANDOM NUMBER
       REM            
       STO E3         CONSTANT
       REM            
       TRA E1+2       REPEAT TEST
       REM            
F7     SWT 6          TEST SENSE SWITCH 6
       TRA F7+3       UP-CALL NEXT PROGRAM
       TRA A1-3       START AT BEGINNING OF
       REM            PROGRAM
       RCDA           
       RCHA F8        LOAD
       LCHA 0         CARDS
       TRA 1          
       REM            
       REM            
       REM CONSTANTS  
       REM            
       REM            
C2                    THIS IS
C3                    ERROR
C4                    PRINT
C5                    IMAGE
       REM            
ZERO   OCT 0          
B      OCT 0              TEST WORD
B11    OCT -377777777777  TEST WORD
B12    OCT 7500       
BA     OCT 7500000000 
C8     MON ZERO,0,1   CONTROL 9L-2R ROWS PRINT
       HTR C2,0,4     CONTROL 1L-0R ROWS PRINT
E      OCT 277        
E2     OCT 000002000017
E3     OCT 000007700000
F8     MON 0,0,3      CONTROL RCD
K2     OCT 000000100000
K3     OCT 036404107501
K4     OCT 000004000001
K5     TRA A7-1       
       END Z          
