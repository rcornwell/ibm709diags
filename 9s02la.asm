                                                             9S02 LA
                                                            7-01-58
       REM            9S02 L
       REM            
       REM          CORE COMPLEMENT CHECKERBOARD
       REM            FOR ONE, TWO, OR FOUR
       REM            737 CORE STORAGES
       REM            
       ORG 32563      
       REM            
       REM TEST FOR CAPACITY OF STORAGE
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
AA     CLA K0         L +0
       STO 32767      
       ADD K1+2       L +1
       STO 16383      
       ADD K1+2       
       STO 8191       
       ADD K1+2       
       STO 4095       
       REM            
       CLA 32767      L IS DEPENDENT UPON
       REM            SIZE OF STORAGE
       TZE D-1        32 K STORAGE-SHOULD NOT BE RUN
       SUB K1+2       L +1
       TZE D4         16 K
       SUB K1+2       
       TZE D6         8 K
       SUB K1+2       
       TZE D          4 K
       HTR D          ERROR IN TESTING
       REM            SIZE OF STORAGE
       REM            ASSUME  A 4K STORAGE
       REM            
D      CLA TS1        L +7777 IN DEC
       TRA D7         
       REM            
D4     CLA TS1+1      L +37777 IN DECR
       TRA D7         
       REM            
D6     CLA TS1+2      L +17777 IN DECR
       REM            
D7     STO K2+1       ADJUST CONSTANTS
       SUB TS         
       STD K2+2       
       ARS 18         
       STA B          
       STA C+3        
       STA C1+1       
       STA C1+2       
       STA C2+1       
       TRA BB-2       BEGIN TEST
       REM            
       REM            
TS     OCT 210000000  
TS1    OCT 7777000000 
       OCT 37777000000 
       OCT 17777000000 
       REM            
* PRINT - NOW PERFORMING-9S02L-STORAGE TEST
* IMAGE - NOW PERFORMING-9S02L-STORAGE TEST
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
       OCT 000000000024  2 L
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
       REM            
       REM            WRITE PATTERN
       LXD K2+2,1     L +77567
       LXD K1,2       L +2000
BB     LXA K1,4       L +20
       CLA T1         L TEST WORD
B      STO BB-2,1     
       TNX C,1,1      PATTERN COMPLETE
       TNX BB-1,2,1   BLOCK COMPLETE
       REM            
       TIX B,4,1      
       LDQ T2         REVERSE
       STO T2         CONSTANTS
       STQ T1         
       TRA BB         
       REM            
       REM            
       REM            TEST PATTERN
       REM            
C      LXD K2+2,1     L +77567
       LXD K1,2       L +2000
       LXA K1,4       L +20
       CLA BB-2,1     
       CAS T1         COMPARE INITIAL WORD
       TRA E          ERROR
       TRA C1         OK
       TRA E          ERROR
       REM            
C1     CLA T2         
       STO BB-2,1     
       CLA BB-2,1     
       CAS T2         COMPARE COMPLEMENT WORD
       TRA E1         ERROR
       TRA C2         OK
       TRA E1         ERROR
       REM            
C2     CLA T1         
       STO BB-2,1     RESTORE INITIAL WORD
       TNX F,1,1      PATTERN COMPLETE
       TNX C+1,2,1    BLOCK COMPLETE
       REM            
       TIX C+3,4,1    
       LDQ T2         REVERSE
       STO T2         CONSTANTS
       STQ T1         
       TRA C+2        
       REM            
       REM            
F      LDQ T2         REVERSE PATTERN
       STO T2         
       STQ T1         
       CLA K1+3       L COUNTER
       SUB K1+2       L 1
       TZE F1         INITIAL AND INVERSE
       REM            PATTERNS TESTED
       STO K1+3       
       TRA BB-2       WRITE INVERSE PATTERN
       REM            
       REM            
E      STO P2         ERROR WORD
       CLA T1         
       STO P1         TEST WORD
       STZ P3         
       CLA C+6        L TRA TO C1
       STO PC         PROGRAM RETURN
       TRA P          
       REM            
E1     STO P2         ERROR WORD
       CLA T2         
       STO P1         TEST WORD
       CLA K2+1       
       REM
       ARS 18         
       STA P3         ONES IN ADDRESS
       CLA C1+5       L TRA TO C2
       STO PC         PROGRAM RETURN
       REM            
       REM            
P      SXD K2,1       
       CLA K2+2       L DEPENDS UPON SIZE
       REM            OF STORAGE
       SUB K2         
       STO P4         ERROR ADDRESS
       REM            
       REM            
       SWT 3          STOP OR PRINT
       TRA P+10       
       REM            
       REM            STOP
       LDQ P1         ERROR WORD IN MQ
       CLA P4         
       ORA P3         ERROR ADDRESS IN ACC DEC
       REM            ONES IN ACC ADR FOR
       REM            COMPLEMENT PATTERN
       HTR PC         RETURN TO PROGRAM
       REM            
       REM            
       REM            
       REM            PRINT ERROR
       WPRA           PRINT FIRST LINE
       SPRA 4         TO GET OCTAL SPACING
       SXD K1+4,1     SAVE COUNT
       LXA K1+4,1     L +17
       RCHA K3        PRINT 9L ROW
       LCHA K3        PRINT 9R-2R ROWS
       TIX *-1,1,1    
       LCHA K3+1      PRINT 1+0 ROWS
       CLA P4         
       COM            
       ANA K2+1       L+7777000000
       STO P5         
       CAL P1         
       COM            
       SLW P6         
       REM            
       WPRA           PRINT SECOND LINE
       SPRA 4         TO GET OCTAL SPACING
       LXA K1+4,1     L +17
       RCHA K3        PRINT 9L ROW
       LCHA K3        PRINT 9R-2R ROWS
       TIX *-1,1,1    
       LCHA K4        PRINT 1+0 ROWS
       CAL P2         
       COM            
       SLW P5         
       LXD K2,1       RESTORE INDEX
       LXD K1+4,1     
PC     TRA            RETURN TO PROGRAM
       REM            
F2     CLA K1+1       L +2
       STO K1+3       RESTORE PASS COMPLETE
       REM            COUNTER
       TRA BB-2       REPEAT TEST
       REM            
       REM            
F1     SWT 6          TEST SWITCH 6
       TRA *+2        UP-READ NEXT PROGRAM
       TRA F2         REPEAT TEST
       RCDA           
       RCHA K5        
       LCHA 0         
       TRA 1          
       REM            
       REM            
       REM            
       REM            CONSTANTS
       REM            
K0     OCT 0          
K1     OCT 2000000020 
       OCT 2          
       OCT 1          
       OCT 2          PASS COMPLETE COUNTER
       OCT 17         
K2     OCT            TEMPORARY STORAGE
       OCT 77777000000  THE DEC OF THIS
       REM            LOCATION WILL CONTAIN
       REM            THE HIGHEST LOCATION
       REM            IN STORAGE
       OCT 77567000000 
       REM            
       REM            PRINT AREA
P1     OCT            TEST WORD
P2     OCT            ERROR WORD
P3     OCT            INITIAL OR COMPLEMENT
P4     OCT            ERROR ADDRESS
P5                    
P6                    
K3     MON K0,0,1     
       MZE P4,0,1     ERROR ADDRESS
       MZE P1,0,1     TEST WORD
       MZE P5,0,1     COMPL OF ERROR ADDRESS
       PZE P6,0,1     COMPLEMENT OF TEST WORD
K4     MZE P3,0,1     INITIAL OR COMPLEMENT
       MZE P2,0,1     ERROR WORD
       MZE K0,0,1     
       PZE P5,0,1     COMPLEMENT OF ERROR WORD
K5     MON 0,0,3      CONTROL RCD
       REM            
       REM            
T1     OCT 0             TEST WORD
T2     OCT 777777777777  TEST WORD
       REM            
       END            
