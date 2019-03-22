                                                             9S03 HA               
                                                            7-01-58               
       REM            9S03 H
       REM            
       REM            HALF SELECT
       REM            CORE MEMORY BEAT TEST
       REM            FOR ONE, TWO, OR FOUR
       REM            737 CORE STORAGES
       REM            
       REM            
       REM            BEGIN TEST
       REM            
       STZ 32767      
B      LXA A,1        L +7600
       STZ 4095,1     CLEAR TEST AREA
       TIX *-1,1,1    
       REM            
       CLA A-1        
       STA A2         RESTORE BEAT ADDRESS
       LXA A9,1       L +44
       SXD A9-1,1     SAVE INDEX COUNT
       LDQ A1         L TEST PATTERN
BA     RQL 1          
       REM            
       REM            SET Y ADDRESS
       REM            
BB     CLA A2         L BEAT ADDRESS
       ANA A3         L +77077
       ADD A4         L+1000
       STA B1         SAVE ADDRESS
       LXA A4,2       L+1000
       REM            
       REM            SET X ADDRESS
       REM            
       CLA A2         L BEAT ADDRESS
       ANA A5         L+77770
       ADD A6         L+10
       STA B2         SAVE ADDRESS
       LXA A6,4       L+10
       REM            
       SWT 4          TEST SWITCH 4
       TRA C1         
       SWT 5          TEST SWITCH 5
       TRA C          
       LXA A7+1,1     L +500
       TRA C2         
C      LXD A7,1       L+100
       TRA C2         
C1     LXA A7,1       L +20
       REM            
       REM            BEAT TEST
       REM            
C2     CLA A2         L BEAT ADDRESS
       STA C2+3       
       STA C2+5       
       CLA            L WORD AT BEAT ADDRESS
       TNZ D9         ERROR-WORD SHOULD BE ZERO
       STQ            BEAT THE ADDRESS
       TIX C2+5,1,1   
       REM            
       REM            CHECK Y ADDRESSES
       REM            
B1     CAL 0,2        Y ADDRESS BEING CHECKED
       TNZ D          
       TIX B1,2,64    
       REM            
       REM            CHECK X ADDRESSES
       REM            
B2     CAL 0,4        X ADDRESS BEING CHECKED
       TNZ D1         MAY BE AN ERROR
       TIX B2,4,1     
       REM            
       CLA A2         L BEAT ADDRESS
       STA B3-5       
       STA B3         
       STQ A2+2       
       CLA            BEAT WORD
       CAS A2+2       CHECK BEAT WORD
       TRA D6         ERROR
       TRA B3         OK
       TRA D6         ERROR
B3     STZ            RESET LAST BEAT ADDRESS
       CLA A2         L BEAT ADDRESS
       ADD A8         L+1 -INCREASE BEAT ADDRESS
       CAS A+1        L HIGHEST POSITION IN STG
       HTR B3+5       
       TRA D2         REPEAT TEST WITH
       REM            NEXT PATTERN
       STA A2         NEW BEAT ADDRESS
       TRA BB         
       REM            
D      CLA B1         
       STA A2+1       
       PXD 0,2        
       ARS 18         
       SUB A2+1       
       SSP            
       CAS A2         L BEAT ADDRESS
       TRA DA         MAY BE AN ERROR
       TRA B1+2       OK-BEAT ADDRESS
DA     CAS A-1        L HIGHEST LOCATION OF PROG
       HTR D1-3       Y ERROR ADDR IN ACC
       REM            BEAT ADDRESS LOCATED AT A2
       TRA B1+2       OK-PROGRAM AREA
       TRA B1+2       OK-PROGRAM AREA
       REM            
       STA *+1        
       STZ            REPAIR Y ERROR
       TRA B1         CHECK REPAIR ADDRESS
       REM            
D1     CLA B2         
       STA A2+1       
       PXD 0,4        
       ARS 18         
       SUB A2+1       
       SSP            
       CAS A2         L BEAT ADDRESS
       TRA D1A        MAY BE AN ERROR
       TRA B2+2       OK BEAT ADDRESS
D1A    CAS A-1        L HIGHEST LOCATION OF PROG
       HTR D2-3       X ERROR ADR IN ACC
       REM            BEAT ADDRESS LOCATED AT A2
       TRA B2+2       OK - PROGRAM AREA
       TRA B2+2       OK - PROGRAM AREA
       REM            
       STA *+1        
       STZ            REPAIR X ERROR
       TRA B2         CHECK REPAIR ADDRESS
       REM            
D2     CLA A-1        
       STA A2         L BEAT ADDRESS
       TRA D7         
       REM            
       REM            
D6     HTR B3         ERROR IN BEAT WORD
       REM            BEAT PATTERN IN MQ
       REM            BEAT WORD IN ACC
       REM            BEAT ADDRESS LOCATED
       REM            AT A2 IN STORAGE
       REM            
D7     LXD A9-1,1     
       TIX D8,1,1     
       TRA D10        
       REM            
D8     SXD A9-1,1     
       TRA BA         
       REM            
D9     HTR C2+5       ERROR-THE BEAT ADDRESS
       REM            WAS NOT ZERO BEFORE BEATING
       REM            ERROR WORD IS IN ACC
       REM            ADDRESS OF WORD AT A2
D10    SWT 6          TEST SWITCH 6
       TRA *+2        UP-READ NEXT PROGRAM
       TRA B+3        REPEAT TEST
       RCDA           
       RCHA A10       
       LCHA 0         
       TRA 1          
       REM            
       REM            
       REM            CONSTANTS
       REM            
       OCT 177        
A      OCT 7600       WILL VARY DEPENDING UPON
       REM            SIZE OF STORAGE
       REM            DEPENDING ON SIZE OF STG
       OCT 7777       OR HIGHEST LOCATION
       REM            IN STORAGE
A2     OCT 177        
       OCT 0          TEMPORARY STORAGE
       OCT 0          TEMPORARY STORAGE
A3     OCT 77077      
A4     OCT 1000       
A5     OCT 77770      
A6     OCT 10         
A7     OCT 100000020  
       OCT 500        
A8     OCT 1          
       OCT            ROTATION COUNT IN DEC
A9     OCT 44         
A10    MON 0,0,3      CONTROL RCD
       REM            
A1     OCT 010101010101 BEAT PATTERN
       REM            
       REM            DETERMINING SIZE OF STG
       REM            
NPER   SWT 3          
       TRA *+2        
       TRA AA         
       REM            
       WPRA           
       SPRA 3         
       RCHA *+3       
       TCOA *         
       TRA AA         
       REM            
       IOCD PNPER,0,24 
       REM            
AA     CLA A2+1       L +0
       STO 32767      STORE +0 IN HIGHEST
       REM            POS OF STORAGE 32K
       ADD A8         +1 IN ACC
       STO 16383      +1 IN HIGH POS 16K
       ADD A8         
       STO 8191       +2 IN HIGH POS 8K
       ADD A8         
       STO 4095       +3 IN HIGH POS 4K
       REM            
       CLA 32767      L IS DEPENDENT UPON
       REM            SIZE OF STORAGE
       TZE FF-1       32K STORAGE-SHOULD NOT BE RUN
       SUB A8         
       TZE F2         16K STORAGE
       SUB A8         
       TZE F          8K STORAGE
       SUB A8         
       TZE B-1        4K STORAGE
       HTR B-1        ERROR-ASSUME 4K STORAGE
       REM            
       REM            
FF     CLA G6         L 77777
       TRA F6         
       REM            
F      CLA G          L 17777
       TRA F6         
       REM            
F2     CLA G2         L 37777
       TRA F6         
       REM            
F6     STO A+1        
       STA B+1        
       SUB A-1        
       STO A          
       TRA B-1        
       REM            
G      OCT 17777      
G2     OCT 37777      
G6     OCT 77777      
       REM            
* PRINT - NOW PERFORMING-9S03H-STORAGE TEST
* IMAGE - NOW PERFORMING-9S03H-STORAGE TEST
PNPER  OCT 000000045040  9 ROW LEFT
       OCT 040000000000  9 ROW RIGHT
       OCT 000000000002  8 L
       OCT 000000000000  8 R
       OCT 000000200200  7 L
       OCT 010000000000  7 R
       OCT 000003030000  6 L
       OCT 100000000000  6 R
       OCT 000004100400  5 L
       OCT 004400000000  5 R
       OCT 000000002000  4 L
       OCT 000000000000  4 R
       OCT 000000000004  3 L
       OCT 201100000000  3 R
       OCT 000000000020  2 L
       OCT 400200000000  2 R
       OCT 000000000000  1 L
       OCT 020000000000  1 R
       OCT 000001000030  0 L
       OCT 601300000000  0 R
       OCT 000006256501  11 L
       OCT 140000000000  11 R
       OCT 000000121202  12 L
       OCT 034400000000  12 R
       END            
