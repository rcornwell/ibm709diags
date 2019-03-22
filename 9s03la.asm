                                                             9S03 LA               
                                                            7-01-58               
       REM            9S03 L
       REM            
       REM            HALF SELECT
       REM            CORE MEMORY BEAT TEST
       REM            FOR ONE OR TWO
       REM            737 CORE STORAGES
       REM            
       ORG 8016       
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
AA     CLA A2         L +0
       STO 8191       +0 IN HIGH POS 8K
       ADD A8         L +1
       STO 4095       +1 IN HIGH POS 4K
       REM            
       CLA 8191       
       TZE F          8K STORAGE
       SUB A8         
       TZE B          4K STORAGE
       SWT 1          ERROR IN STG TEST
       HTR B          CONTINUE DIAGNOSTIC FOR A
       REM            4K MEMORY
       HTR AA         REPEAT STG TEST
       REM            
F      CLA G          L 17600
       STO A          
       TRA B          
       REM            
G      OCT 17600      
       REM            
* IMAGE - NOW PERFORMING-9S03L-STORAGE TEST
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
       OCT 000000000006  3 L
       OCT 201100000000  3 R
       OCT 000000000020  2 L
       OCT 400200000000  2 R
       OCT 000000000000  1 L
       OCT 020000000000  1 R
       OCT 000001000030  0 L
       OCT 601300000000  0 R
       OCT 000006256503  11 L
       OCT 140000000000  11 R
       OCT 000000121200  12 L
       OCT 034400000000  12 R
       REM            
       REM            BEGIN TEST
       REM            
B      LXA A,1        L +77600
       STZ B,1        CLEAR TEST
       TIX *-1,1,1    AREA
       REM            
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
       LXA A7+1,1     L+500
       TRA C2         
C      LXD A7,1       L+100
       TRA C2         
C1     LXA A7,1       L+20
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
       TNZ D          MAY BE AN ERROR
       TIX B1,2,64    
       REM            
       REM            
       REM            CHECK X ADDRESSES
       REM            
B2     CAL 0,4        X ADDRESS BEING CHECKED
       TNZ D1         MAY BE AN ERROR
       TIX B2,4,1     
       REM            
       CLA A2         L BEAT ADDRESS
       STA B3         
       STA B3-5       
       STQ A2+2       
       CLA            BEAT WORD
       CAS A2+2       CHECK BEAT WORD
       TRA D6         ERROR
       TRA B3         OK
       TRA D6         ERROR
B3     STZ            RESET LAST BEAT ADDRESS
       CLA A2         L BEAT ADDRESS
       ADD A8         L+1 -INCREASE BEAT ADDRESS
       CAS A          L +7600
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
       TRA D4         MAY BE AN ERROR
       TRA B1+2       OK-BEAT ADDRESS
       HTR D1-3       Y ERROR ADDR IN ACC
       REM            BEAT ADDRESS LOCATED AT A2
       STA D1-2       
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
       TRA D5         MAY BE AN ERROR
       TRA B2+2       OK BEAT ADDRESS
       HTR D2-4       X ERROR ADR IN ACC
       REM            BEAT ADDRESS LOCATED AT A2
       STA D2-2       
       STZ            REPAIR X ERROR
       TRA B2         CHECK REPAIR ADDRESS
       REM            
D2     CLM            
       STA A2         L BEAT ADDRESS
       TRA D7         
       REM            
D4     CAS A          
       TRA B1+2       OK-PROGRAM AREA
       TRA B1+2       OK-PROGRAM AREA
       TRA D+9        ERROR
       REM            
D5     CAS A          
       TRA B2+2       OK - PROGRAM AREA
       TRA B2+2       OK - PROGRAM AREA
       TRA D1+9       ERROR
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
       REM            
D10    SWT 6          TEST SWITCH 6
       TRA *+2        UP-READ NEXT PROGRAM
       TRA B+3        REPEAT TEST
       RCDA           
       RCHA A10       
       LCHA 0         
       TRA 1          
       REM            
       REM            CONSTANTS
       REM            
A      OCT 7600       OR 17600,27600,37600
       REM            47600,57600,67600 OR 77600
       REM            DEPENDING ON SIZE OF STG
A2     OCT 0          BEAT ADDRESS
       OCT 0          TEMPORARY STORAGE
       OCT 0          TEMPORARY STORAGE
A3     OCT 77077      
A4     OCT 1000       
A5     OCT 77770      
A6     OCT 10         
A7     OCT 100000020  
       OCT 500        
A8     OCT 1          
       OCT            ROTATION COUNT
A9     OCT 44         
A10    MON 0,0,3      CONTROL RCD
A1     OCT 010101010101 BEAT PATTERN
       END            
