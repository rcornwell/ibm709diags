                                                             9S04 HA
                                                             7-01-58                     
       REM           9S04H
       REM           
       REM HALF SELECT CORE MEMORY BEAT TEST
       REM FOR A 738 CORE STORAGE
       REM THE FIRST HALF OF THE PROGRAM TESTS
       REM HIGH END OF MEMORY FROM 2000 TO 77777
       REM AND THE SECOND HALF TESTS THE LOW END
       REM OF MEMORY FROM 00000 TO 75777
       REM           
       TRA NPER      TO PRINT IDENTIFICATION
       REM           
 C     SLF           TURN OFF ALL SENSE LIGHTS
       SLN 4         TURN SENSE LIGHT 4 ON TO
       REM           INDICATE THAT THE HIGH END
       REM           OF MEMORY IS BEING TESTED
       REM           
       REM           
       REM           
       REM           FILL MEMORY WITH ZEROS AND
       REM           BEAT WITH ONES
       CLA TEST1     L +0
       STO FILL      
       CLA TEST2     L ONES
       STO BEAT      
       REM           
       REM           
       REM           
       REM           
START1 LXA ZERO,1    
       CLA FILL      
       STO 32767,1   LOAD TEST AREA
       TXH C1,1,32767-CNTL4-2
       TXI START1+2,1,1
       REM           
 C1    CLA K11-1     L+2000
       STO LOW       
       CLA K10       L+77777
       STO HIGH      
       CLA HIGH      HIGHEST ADDRESS TESTED
       STA ADR       RESTORE BEAT ADDRESS
       LXA K6,1      L+1
       SXD COUNT,1   SAVE INDEX COUNT
       LDQ BEAT      L TEST PATTERN
 C2    RQL 1         
       REM           
       REM           
       REM           
       REM           SET Y ADDRESS
       REM           
 C3    CLA ADR       L BEAT ADDRESS
       ORA K11       L+1600
       STA C7        SAVE ADDRESS
       LXA ZERO,6    
       REM           
       REM           SET X ADDRESS
       REM           
       CLA ADR       L BEAT ADDRESS
       ORA K3+1      L+70
       STA C8        SAVE ADDRESS
       REM           
       SWT 4         TEST SENSE SWITCH 4
       TRA C5        BEAT EACH ADDRESS 500 TIMES
       SWT 5         TEST SENSE SWITCH 5
       TRA C4        BEAT EACH ADDRESS 1000 TIMES
       LXA K1750,1   
       TRA C6        BEAT EACH ADDRESS 5000 TIMES
 C4    LXA K310,1    
       TRA C6        
 C5    LXA K144,1    
       REM           
       REM           
       REM           
       REM           BEAT TEST
       REM           
 C6    CLA ADR       L BEAT ADDRESS
       STA C6+7      
       STA C6A       
       STA C6A+1     
       STA C6A+2     
       STA C6A+3     
       STA C6A+4     
       CLA           L WORD AT BEAT ADDRESS
       CAS FILL      
       TRA C6+11     ERROR
       TRA C6A       OK
       SWT 2         TEST SENSE SWITCH 2
       TRA *+2       INDICATE ERROR
       TRA C6A       BY PASS ERROR
       REM           
       SWT 3         TEST SENSE SWITCH 3
       TRA P         PRINT ERROR
       HTR C6A       ERROR - THE BEAT ADDRESS
       REM           WAS NOT CORRECT BEFORE
       REM           BEATING - ERROR WORD IS IN
       REM           THE ACCUMULATOR , ADDRESS
       REM           OF WORD IS AT ADR
       REM           
       REM           
 C6A   STQ           BEAT THE ADDRESS
       STQ           
       STQ           
       STQ           
       STQ           
       TIX C6A,1,1   
       REM           
       REM           
       REM           
       REM           CHECK Y ADDRESSES
       REM           
 C7    CLA 0,2       Y ADDRESS BEING CHECKED
       CAS FILL      
       TRA C7A       MAYBE AN ERROR
       TRA C7+5      OK
       TRA C7A       MAYBE AN ERROR
       TXH C8,2,768  
       TXI C7,2,128  
       REM           
 C7A   CLA C7        
       STA T1        TEMPORARY STORAGE
       PXD 0,2       
       ARS 18        
       SUB T1        
       SSP           
       CAS ADR       L BEAT ADDRESS
       TRA C7B       MAY BE AN ERROR
       TRA C7+5      OK-BEAT ADDRESS
 C7B   CAS K9        L HIGHEST LOCATION OF PROG
       TRA C7B+4     ERROR
       TRA C7+5      OK-PROGRAM AREA
       TRA C7+5      OK-PROGRAM AREA
       REM           
       SWT 2         TEST SENSE SWITCH 2
       TRA *+2       INDICATE ERROR
       TRA C7C       BY PASS ERROR
       REM           
       SWT 3         TEST SENSE SWITCH 3
       TRA P1        PRINT ERROR
       HTR C7C       Y ERROR ADR IN ACC
       REM           BEAT ADDRESS LOCATED AT ADR
       REM           
 C7C   STA C7C+2     
       CLA FILL      
       STO           REPAIR Y ERROR
       TRA C7        CHECK REPAIR ADDRESS
       REM           
       REM           
       REM           
       REM           CHECK X ADDRESSES
       REM           
 C8    CLA 0,4       X ADDRESS BEING CHECKED
       CAS FILL      
       TRA C9        MAYBE AN ERROR
       TRA C8+5      OK
       TRA C9        MAYBE AN ERROR
       TXH C10,4,48  
       TXI C8,4,8    
       REM           
 C9    CLA C8        
       STA T1        TEMPORARY STORAGE
       PXD 0,4       
       ARS 18        
       SUB T1        
       SSP           
       CAS ADR       L BEAT ADDRESS
       TRA C9A       MAY BE AN ERROR
       TRA C8+5      OK BEAT ADDRESS
 C9A   CAS K9        L HIGHEST LOC OF PROGRAM
       TRA C9A+4     ERROR
       TRA C8+5      OK - PROGRAM AREA
       TRA C8+5      OK - PROGRAM AREA
       SWT 2         TEST SENSE SWITCH 2
       TRA *+2       INDICATE ERROR
       TRA C9B       BY PASS ERROR
       REM           
       SWT 3         TEST SENSE SWITCH 3
       TRA P2        PRINT ERROR
       HTR C9B       X  ERROR ADR IN ACC
       REM           BEAT ADDRESS LOCATED AT ADR
       REM           
 C9B   STA C9B+2     
       CLA FILL      
       STO           REPAIR X ERROR
       TRA C8        CHECK REPAIR ADDRESS
       REM           
       REM           
       REM           
       REM           
 C10   CLA ADR       L BEAT ADDRESS
       STA C10+4     
       STA C11       
       STQ T2        TEMPORARY STORAGE
       CLA           BEAT WORD
       CAS T2        CHECK BEAT WORD
       TRA C10A      ERROR
       TRA C11-1     OK
 C10A  SWT 2         TEST SENSE SWITCH 2
       TRA *+2       INDICATE ERROR
       TRA C11-1     BY PASS ERROR
       REM           
       SWT 3         TEST SENSE SWITCH 3
       TRA P3        PRINT ERROR
       HTR C11-1     ERROR IN BEAT WORD
       REM           BEAT PATTERN IN MQ
       REM           BEAT WORD IN ACC
       REM           BEAT ADDRESS LOCATED
       REM           AT ADR IN STORAGE
       REM           
       CLA FILL      
 C11   STO           RESET LAST BEAT ADDRESS
       CLA ADR       L BEAT ADDRESS
       SUB ONE       DEACREASE BEAT ADDRESS
       CAS LOW       LOWEST ADDRESS TESTED
       TRA C11A      
       TRA C12       REPEAT TEST WITH
       REM           NEXT PATTERN
       HTR C11+5     SHOULD NEVER ENTER HERE
       REM           
 C11A  STA ADR       NEW BEAT ADDRESS
       TRA C3        
 C12   CLA HIGH      HIGHEST ADDRESS TESTED
       STA ADR       L BEAT ADDRESS
       LXD COUNT,1   
       TIX C13,1,1   
       REM
       TRA PCOM      FIRST HALF OF TEST COMPLETE
       REM           
 C13   SXD COUNT,1   
       TRA C2        
       REM           
 PCOM  SWT 3         
       TRA *+2       
       TRA C14       
       REM           
       WPRA          TO PRINT PASS COMPLETE
       SPRA 3        
       RCHA *+2      
       TRA C14       
       REM           
       IOCD PPER,0,24 
       REM           
 C14   SWT 1         TEST SENSE SWITCH 1
       TRA C14+3     
       TRA C1+4      LOOP IN TEST
       REM           
       SWT 6         TEST SENSE SWITCH 6
       TRA *+2       
       TRA C1        REPEAT TEST
       RCDA          READ IN NEXT TEST
       RCHA CNTL     
       LCHA 0        
       TRA 1         
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           ERROR ROUTINES
 P     CLA ADR       ERROR ADDRESS
       STO P6        
       CLA K9A       L HTR C6+11
       STO P7        ERROR EXIT
       CLA C6+10     L TRA C6A
       STO P13       PROGRAM RETURN
       TRA P4        
 P1    STO P6        ERROR ADDRESS
       CLA K9A+1     L HTR C7B+4
       STO P7        ERROR EXIT
       CLA K9A+4     L TRA C7C
       STO P13       PROGRAM RETURN
       TRA P4        
 P2    STO P6        ERROR ADDRESS
       CLA K9A+2     L HTR C9A+4
       STO P7        ERROR EXIT
       CLA K9A+5     L TRA C9B
       STO P13       PROGRAM RETURN
       TRA P4        
 P3    CLA ADR       
       STO P6        
       CLA K9A+3     L HTR C10A
       STO P7        ERROR EXIT
       CLA C10+7     L TRA C11-1
       STO P13       PROGRAM RETURN
       STQ QUOT      
       CAL QUOT      TEST WORD
       SLW PR5       
       COM           
       SLW PR5+2     COMPLEMENT OF TEST WORD
       TRA P5        
       REM           
 P4    CAL FILL      TEST WORD
       SLW PR5       
       COM           
       SLW PR5+2     COMPLEMENT OF TEST WORD
       REM           
 P5    CLA P6        L ERROR ADDRESS
       STA *+1       
       CAL           ERROR WORD
       SLW PR4       
       COM           
       SLW PR4+2     COMPLEMENT OF ERROR WORD
       REM           
       STQ QUOT      
       CAL QUOT      BEAT WORD
       SLW PR6       
       COM           
       SLW PR6+2     COMPLEMENT OF BEAT WORD
       REM           
       REM           
       REM           PRINT ERROR
 E13   SXD SAVE,1    SAVE XRA
       LXA M+3,1     L +10
       STZ PR7+8,1   CLEAR IMAGE
       TIX E13+2,1,1 
       CLA K3        L +7
       ANA P6        L ERROR ADDRESS
       PAX 0,1       
       CLA K2        L 20000
       ORS PR7+7,1   
       REM           
       CLA K3+1      L +70
       ANA P6        L ERROR ADDRESS
       ARS 3         
       PAX 0,1       
       CLA K2+1      L 40000
       ORS PR7+7,1   
       REM           
       CLA K3+2      L +700
       ANA P6        L ERROR ADDRESS
       ARS 6         
       PAX 0,1       
       CLA K2+2      L 100000
       ORS PR7+7,1   
       REM           
       CLA K3+3      L +7000
       ANA P6        L ERROR ADDRESS
       ARS 9         
       PAX 0,1       
       CLA K2+3      L 200000
       ORS PR7+7,1   
       REM           
       CLA K3+4      L +70000
       ANA P6        L ERROR ADDRESS
       ARS 12        
       PAX 0,1       
       CLA K2+4      L 400000
       ORS PR7+7,1   
       REM           ADJUST PRINT IMAGE
       LXD M+2,1     L +27
       CLA K4        L +777777017777
 P10AA ANS PR4+6,1   
       TIX P10AA,1,2 
       REM           
       CLA K5        L ORS PR1+
       STO P10A      
       LXA M+3,1     L +10
       CLA PR7+8,1   
 P10A  ORS PR1+12,1  
       CLA P10A      
       SUB ONE       
       STA P10A      
       TIX P10A-1,1,1 
       REM           
       WPRA          PRINT FIRST LINE
       SPRA 3        DOUBLE SPACE
       SPRA 4        TO GET OCTAL SPACING
       RCHA CNTL1    
       REM           
       REM           
       LXA M+3,1     L +10
 P11A  STZ PR7+8,1   CLEAR IMAGE
       TIX P11A,1,1  
       CLA K3        L +7
       ANA P7        L ERROR EXIT
       PAX 0,1       
       CLA K2        L 20000
       ORS PR7+7,1   
       REM           
       CLA K3+1      L +70
       ANA P7        L ERROR EXIT
       ARS 3         
       PAX 0,1       
       CLA K2+1      L 40000
       ORS PR7+7,1   
       REM           
       CLA K3+2      L +700
       ANA P7        L ERROR EXIT
       ARS 6         
       PAX 0,1       
       CLA K2+2      L 100000
       ORS PR7+7,1   
       REM
       CLA K3+3      L +7000
       ANA P7        L ERROR EXIT
       ARS 9         
       PAX 0,1       
       CLA K2+3      L 200000
       ORS PR7+7,1   
       REM           
       CLA K3+4      L +70000
       ANA P7        L ERROR EXIT
       ARS 12        
       PAX 0,1       
       CLA K2+4      L 400000
       ORS PR7+7,1   
       REM           ADJUST PRINT IMAGE
       LXD M+2,1     L +27
       CLA K4        L +777777017777
 P11AA ANS PR5+6,1   
       TIX P11AA,1,2 
       REM           
       CLA K5+1      L ORS PR2+12,1
       STO P11B      
       LXA M+3,1     L +10
       CLA PR7+8,1   
 P11B  ORS PR2+12,1  
       CLA P11B      
       SUB ONE       
       STA P11B      
       TIX P11B-1,1,1 
       REM           
       WPRA          PRINT SECOND LINE
       SPRA 4        TO GET OCTAL SPACING
       RCHA CNTL2    
       REM           
       REM           
       LXA M+3,1     L +10
 PP    STZ PR7+8,1   CLEAR IMAGE
       TIX PP,1,1    
       CLA K3        L +7
       ANA ADR       L BEAT ADDRESS
       PAX 0,1       
       CLA K2        L 20000
       ORS PR7+7,1   
       REM           
       CLA K3+1      L +70
       ANA ADR       L BEAT ADDRESS
       ARS 3         
       PAX 0,1       
       CLA K2+1      L 40000
       ORS PR7+7,1   
       REM           
       CLA K3+2      L +700
       ANA ADR       L BEAT ADDRESS
       ARS 6         
       PAX 0,1       
       CLA K2+2      L 100000
       ORS PR7+7,1   
       CLA K3+3      L +7000
       ANA ADR       L BEAT ADDRESS
       ARS 9         
       PAX 0,1       
       CLA K2+3      L 200000
       ORA PR7+7,1   
       REM           
       CLA K3+4      L +70000
       ANA ADR       L BEAT ADDRESS
       ARS 12        
       PAX 0,1       
       CLA K2+4      L 400000
       ORA PR7+7,1   
       REM           ADJUST PRINT IMAGE
       LXD M+2,1     L +27
       CLA K4        L +777777017777
 PP1   ANS PR6+6,1   
       TIX PP1,1,2   
       REM           
       CLA K5+2      L ORS PR8+12,1
       STO PP1B      
       LXA M+3,1     L +10
       CLA PR7+8,1   
 PP1B  ORS PR8+12,1  
       CLA PP1B      
       SUB ONE       
       STA PP1B      
       TIX PP1B-1,1,1 
       REM           
       REM           
       WPRA          PRINT THIRD LINE
       SPRA 4        TO GET OCTAL SPACING
       RCHA CNTL3    
       REM           
       REM           
       REM           
       CAL PR11+1    L 777777777377
       ANS PR10+10   
       ANS PR10+12   RESET PRINT IMAGE
       ANS PR10+14   
       ANS PR10+16   
       REM           
       CAL PR12+5    L 757673777576
       LXD M+3,1     L 20
 P12A  ANS PR10+19,1 RESET PRINT IMAGE
       TIX P12A,1,2  
       REM           
       CLA K10       L +77777
       ANA P6        ERROR ADDRESS
       STO K10-1     SAVE ADDRESS
       REM           
       CAS K10+8     L +40000
       TRA Y3        3RD OR 4TH QUADRANT
       TRA Y3        
       REM           1ST OR 2ND QUADRANT
       REM
       CAS K10+12    L +20000
       TRA Y1        1ST 4 COLUMNS
       TRA Y1        
       TRA Y112      LAST COLUMNS
       REM           Y1 OR Y2
 Y1    CAS K10+9     L +34000
       TRA R1A       COLUMN 1
       TRA R1A       
       CAS K10+10    L +30000
       TRA R2A       COLUMN 2
       TRA R2A       
       CAS K10+11    L +24000
       TRA R3A       COLUMN 3
       TRA R3A       
       TRA R4A       COLUMN 4
       REM           
 Y112  CAS K10+13    L +14000
       TRA R5A       COLUMN 5
       TRA R5A       
       CAS K10+14    L +10000
       TRA R6A       COLUMN 6
       TRA R6A       
       CAS K10+15    L +4000
       TRA R7A       COLUMN 7
       TRA R7A       
       TRA R8A       COLUMN 8
       REM           
 R1A   CLA PR12+1    
       ORS PR10+17   COL 1 Y MATRIX
       CLA K10-1     
       SUB K10+9     L 34000
       TRA R9        
       REM           
 R2A   CLA PR12+1    
       ORS PR10+15   COL 2 Y MATRIX
       CLA K10-1     
       SUB K10+10    L 30000
       TRA R9        
       REM           
 R3A   CLA PR12+1    
       ORS PR10+13   COL 3 Y MATRIX
       CLA K10-1     
       SUB K10+11    L 24000
       TRA R9        
       REM           
 R4A   CLA PR12+1    
       ORS PR10+11   COL 4 Y MATRIX
       CLA K10-1     
       SUB K10+12    L 20000
       TRA R9        
       REM           
 R5A   CLA PR12+1    
       ORS PR10+9    COL 5 Y MATRIX
       CLA K10-1     
       SUB K10+13    L 14000
       TRA R9        
       REM           
 R6A   CLA PR12+1    
       ORS PR10+7    COL 6 Y MATRIX
       CLA K10-1     
       SUB K10+14    L 10000
       TRA R9        
       REM           
 R7A   CLA PR12+1    
       ORS PR10+5    COL 7 Y MATRIX
       CLA K10-1     
       SUB K10+15    L 4000
       TRA R9        
       REM           
 R8A   CLA PR12+1    
       ORS PR10+3    COL 8 Y MATRIX
       CLA K10-1     
       REM           
 R9    STO K10-2     
       CAS K10+16    L 2000
       TRA R10       
       TRA R10       
       CLA PR11      
       ORS PR10+16   Y1 MATRIX
       CLA K10-2     
       TRA R13A      
       REM           
 R10   CLA PR11      
       ORS PR10+14   Y2 MATRIX
       CLA K10-2     
       SUB K10+16    L 2000
       REM           
 R13A  CAS K11+3     L 1000
       TRA R14A      1ST FOUR ROWS
       TRA R14A      
       CAS K11+4     L 600
       TRA R15A      ROW 5
       TRA R15A      
       CAS K11+5     L 400
       TRA R16A      ROW 6
       TRA R16A      
       CAS K11+6     L 200
       TRA R17A      ROW 7
       TRA R17A      
       TRA R18A      ROW 8
       REM           
 R14A  CAS K11       L 1600
       TRA R19A      ROW 1
       TRA R19A      
       CAS K11+1     L 1400
       TRA R20A      ROW 2
       TRA R20A      
       CAS K11+2     L 1200
       TRA R21A      ROW 3
       TRA R21A      
       TRA R22A      ROW 4
       REM           
 R15A  CLA PR12      
       ORS PR10+9    ROW 5 Y MATRIX
       CLA K10-2     
       SUB K11+4     L 600
       TRA R23       
       REM           
 R16A  CLA PR12      
       ORS PR10+7    ROW 6 Y MATRIX
       CLA K10-2     
       SUB K11+5     L 400
       TRA R23       
       REM           
 R17A  CLA PR12      
       ORS PR10+5    ROW 7 Y MATRIX
       CLA K10-2     
       SUB K11+6     L 200
       TRA R23       
       REM           
 R18A  CLA PR12      
       ORS PR10+3    ROW 8 Y MATRIX
       CLA K10-2     
       TRA R23       
       REM           
 R19A  CLA PR12      
       ORS PR10+17   ROW 1 Y MATRIX
       CLA K10-2     
       SUB K11       L 1600
       TRA R23       
       REM           
 R20A  CLA PR12      
       ORS PR10+15   ROW 2 Y MATRIX
       CLA K10-2     
       SUB K11+1     L 1400
       TRA R23       
       REM           
 R21A  CLA PR12      
       ORS PR10+13   ROW 3 Y MATRIX
       CLA K10-2     
       SUB K11+2     L 1200
       TRA R23       
       REM           
 R22A  CLA PR12      
       ORS PR10+11   ROW 4 Y MATRIX
       CLA K10-2     
       SUB K11+3     L 1200
       TRA R23       
       REM           
 Y3    CAS K10+4     L +60000
       TRA Y3+4      Y3 OR Y4 1ST 4 COLUMNS
       TRA Y3+4      
       TRA Y312      Y3 OR Y4 LAST 4 COLUMNS
       REM           Y3 OR Y4
       CAS K10+1     L +74000
       TRA R1B       COLUMN 1
       TRA R1B       
       CAS K10+2     L +70000
       TRA R2B       COLUMN 2
       TRA R2B       
       CAS K10+3     L +64000
       TRA R3B       COLUMN 3
       TRA R3B       
       TRA R4B       COLUMN 4
       REM           
 Y312  CAS K10+5     L +54000
       TRA R5B       COLUMN 5
       TRA R5B       
       CAS K10+6     L +50000
       TRA R6B       COLUMN 6
       TRA R6B       
       CAS K10+7     L +44000
       TRA R7B       COLUMN 7
       TRA R7B       
       TRA R8B       COLUMN 8
       REM           
 R1B   CLA PR12+1    
       ORS PR10+17   COL 1 Y MATRIX
       CLA K10-1     
       SUB K10+1     L 74000
       TRA R11       
       REM           
 R2B   CLA PR12+1    
       ORS PR10+15   COL 2 Y MATRIX
       CLA K10-1     
       SUB K10+2     L 70000
       TRA R11       
       REM           
 R3B   CLA PR12+1    
       ORS PR10+13   COL 3 Y MATRIX
       CLA K10-1     
       SUB K10+3     L 64000
       TRA R11       
       REM           
 R4B   CLA PR12+1    
       ORS PR10+11   COL 4 Y MATRIX
       CLA K10-1     
       SUB K10+4     L 60000
       TRA R11       
       REM           
 R5B   CLA PR12+1    
       ORS PR10+9    COL 5 Y MATRIX
       CLA K10-1     
       SUB K10+5     L 54000
       TRA R11       
       REM           
 R6B   CLA PR12+1    
       ORS PR10+7    COL 6 Y MATRIX
       CLA K10-1     
       SUB K10+6     L 50000
       TRA R11       
       REM           
 R7B   CLA PR12+1    
       ORS PR10+5    COL 7 Y MATRIX
       CLA K10-1     
       SUB K10+7     L 44000
       TRA R11       
       REM           
 R8B   CLA PR12+1    
       ORS PR10+3    COL 8 Y MATRIX
       CLA K10-1     
       SUB K10+8     L 40000
       TRA R11       
       REM           
 R11   STO K10-2     
       CAS K10+16    L 2000
       TRA R12       
       TRA R12       
       CLA PR11      
       ORS PR10+12   Y3 MATRIX
       CLA K10-2     
       TRA R13B      
       REM           
 R12   CLA PR11      
       ORS PR10+10   Y4 MATRIX
       CLA K10-2     
       SUB K10+16    L 2000
       REM           
 R13B  CAS K11+3     L 1000
       TRA R14B      LAST FOUR ROWS
       TRA R14B      
       CAS K11+4     L 600
       TRA R15B      ROW 4
       TRA R15B      
       CAS K11+5     L 400
       TRA R16B      ROW 3
       TRA R16B      
       CAS K11+6     L 200
       TRA R17B      ROW 2
       TRA R17B      
       TRA R18B      ROW 1
       REM           
 R14B  CAS K11       L 1600
       TRA R19B      ROW 8
       TRA R19B      
       CAS K11+1     L 1400
       TRA R20B      ROW 7
       TRA R20B      
       CAS K11+2     L 1200
       TRA R21B      ROW 6
       TRA R21B      
       TRA R22B      ROW 5
       REM           
 R15B  CLA PR12      
       ORS PR10+11   ROW 4 Y MATRIX
       CLA K10-2     
       SUB K11+4     L 600
       TRA R23       
       REM           
 R16B  CLA PR12      
       ORS PR10+13   ROW 3 Y MATRIX
       CLA K10-2     
       SUB K11+5     L 400
       TRA R23       
       REM           
 R17B  CLA PR12      
       ORS PR10+15   ROW 2 Y MATRIX
       CLA K10-2     
       SUB K11+6     L 200
       TRA R23       
       REM           
 R18B  CLA PR12      
       ORS PR10+17   ROW 1 Y MATRIX
       CLA K10-2     
       TRA R23       
       REM           
 R19B  CLA PR12      
       ORS PR10+3    ROW 8 Y MATRIX
       CLA K10-2     
       SUB K11       L 1600
       TRA R23       
       REM           
 R20B  CLA PR12      
       ORS PR10+5    ROW 7 Y MATRIX
       CLA K10-2     
       SUB K11+1     L 1400
       TRA R23       
       REM           
 R21B  CLA PR12      
       ORS PR10+7    ROW 6 Y MATRIX
       CLA K10-2     
       SUB K11+2     L 1200
       TRA R23       
       REM           
 R22B  CLA PR12      
       ORS PR10+9    ROW 5 Y MATRIX
       CLA K10-2     
       SUB K11+3     L 1200
       REM           
 R23   STO K10-2     
       ANA K11+7     L7
       CAS K11+8     L4
       TRA R24D      1ST 4 COLUMNS
       TRA R24D      
       TNZ R24A      
       CLA PR12+4    
       ORS PR10+3    COLUMN 8 X MATRIX
       TRA R25       
       REM           
 R24A  SUB K11+9     L1
       TNZ R24B      
       CLA PR12+4    
       ORS PR10+5    COLUMN 7 X MATRIX
       TRA R25       
       REM           
 R24B  SUB K11+9     L1
       TNZ R24C      
       CLA PR12+4    
       ORS PR10+7    COLUMN 6 X MATRIX
       TRA R25       
       REM           
 R24C  CLA PR12+4    
       ORS PR10+9    COLUMN 5 X MATRIX
       TRA R25       
       REM           
 R24D  SUB K11+8     L4
       TNZ R24E      
       CLA PR12+4    
       ORS PR10+11   COLUMN 4 X MATRIX
       TRA R25       
       REM           
 R24E  SUB K11+9     L1
       TNZ R24F      
       CLA PR12+4    
       ORS PR10+13   COLUMN 3 X MATRIX
       TRA R25       
       REM           
 R24F  SUB K11+9     L1
       TNZ R24G      
       CLA PR12+4    
       ORS PR10+15   COLUMN 2 X MATRIX
       TRA R25       
       REM           
 R24G  CLA PR12+4    
       ORS PR10+17   COLUMN 1 X MATRIX
       REM           
 R25   CLA K10-2     
       ANA K11+10    L 770
       STO K10-2     TEMP STORAGE
       CAS K11+11    L 100
       TRA R26       X2 MATRIX
       TRA R26       
       CLA PR12+2    
       ORS PR10+17   X 1 MATRIX
       TRA R27       
       REM           
 R26   CLA PR12+2    
       ORS PR10+15   X 2 MATRIX
       CLA K10-2     
       SUB K11+11    L 100
       TZE R27G      ROW 1 X2 MATRIX
       SUB K11+12    L 10
       TZE R27F+2    ROW 2 X2
       SUB K11+12    
       TZE R27E+2    ROW 3 X2
       SUB K11+12    
       TZE R27D+2    ROW 4 X2
       SUB K11+12    
       TZE R27C+2    ROW 5 X2
       SUB K11+12    
       TZE R27B+2    ROW 6 X2
       SUB K11+12    
       TZE R27A+2    ROW 7 X2
       TRA R27+2     TOW 8 X2
       REM           
 R27   CLA K10-2     
       TNZ R27A      
       CLA PR12+3    
       ORS PR10+3    ROW 8 X MATRIX
       TRA R28       
       REM           
 R27A  SUB K11+12    L 10
       TNZ R27B      
       CLA PR12+3    
       ORS PR10+5    ROW 7 X MATRIX
       TRA R28       
       REM           
 R27B  SUB K11+12    L 10
       TNZ R27C      
       CLA PR12+3    
       ORS PR10+7    ROW 6 X MATRIX
       TRA R28       
       REM           
 R27C  SUB K11+12    L 10
       TNZ R27D      
       CLA PR12+3    
       ORS PR10+9    ROW 5 X MATRIX
       TRA R28       
       REM           
 R27D  SUB K11+12    L 10
       TNZ R27E      
       CLA PR12+3    
       ORS PR10+11   ROW 4 X MATRIX
       TRA R28       
       REM           
 R27E  SUB K11+12    L 10
       TNZ R27F      
       CLA PR12+3    
       ORS PR10+13   ROW 3 X MATRIX
       TRA R28       
       REM           
 R27F  SUB K11+12    L 10
       TNZ R27G      
       CLA PR12+3    
       ORS PR10+15   ROW 7 X MATRIX
       TRA R28       
       REM           
 R27G  CLA PR12+3    
       ORS PR10+17   ROW 1 X MATRIX
       REM           
 R28   WPRA          
       RCHA CNTL4    PRINT FOURTH LINE
       REM           
       CLA P6        RETURN TO PROGRAM
       LDQ QUOT      
       LXD SAVE,1    RESTORE INDEX COUNT
 P13   TRA           TO PROGRAM WHERE ERROR
       REM           OCCURRED
       REM           
       REM           
       REM           
       REM           
       REM           CONSTANTS
       REM           
 K6    OCT 1         NUMBER OF ROTATIONS
       REM           
       REM           
 TEST1 OCT 0                 FILL MEMORY
 TEST2 OCT 777777777777      BEAT WORD
       REM           
       REM           
 LOW   OCT           2000 IS THE MIN VALUE THAT
       REM           CAN BE USED
 HIGH  OCT           77777 IS THE MAX VALUE THAT
       REM           CAN BE USED
       REM           
 ADR   OCT 77777     
 BEAT  OCT           BEAT PATTERN
 FILL  OCT           FILL MEMORY WITH THIS WORD
 COUNT OCT           ROTATION COUNT IN DEC
 SAVE  OCT           INDEX STORAGE
       REM           
 T1    OCT 0         ADDRESS STORAGE
 T2    OCT 0         TEMPORARY STORAGE
       REM           
 ZERO  OCT 0         
 ONE   OCT 1         
 M     OCT 00004001777
       OCT 00003000007
       OCT 27000030  
       OCT 000020000010
 K1    OCT 2000      
       OCT 7000000   
 K2    OCT 20000     
       OCT 40000     
       OCT 100000    
       OCT 200000    
       OCT 400000    
 K3    OCT 7         
       OCT 70        
       OCT 700       
       OCT 7000      
       OCT 70000     
 K4    OCT 777777017777
       REM           
 K5    ORS PR1+12,1  
       ORS PR2+12,1  
       ORS PR8+12,1  
       REM           
 K9    HTR PR12+5    
 K9A   HTR C6+11     
       HTR C7B+4     
       HTR C9A+4     
       HTR C10A      
       TRA C7C       
       TRA C9B       
       REM           
       OCT 0         TEMP STG.
       OCT 0         ERROR ADDRESS
 K10   OCT 77777     
       OCT 74000     
       OCT 70000     
       OCT 64000     
       OCT 60000     
       OCT 54000     
       OCT 50000     
       OCT 44000     
       OCT 40000     
       OCT 34000     
       OCT 30000     
       OCT 24000     
       OCT 20000     
       OCT 14000     
       OCT 10000     
       OCT 4000      
       OCT 2000      
 K11   OCT 1600      
       OCT 1400      
       OCT 1200      
       OCT 1000      
       OCT 600       
       OCT 400       
       OCT 200       
       OCT 7         
       OCT 4         
       OCT 1         
       OCT 770       
       OCT 100       
       OCT 10        
       REM           
 K144  OCT 144       
 K310  OCT 310       
 K1750 OCT 1750      
       REM           
 P6    OCT           ERROR ADDRESS
 P7    OCT           ERROR EXIT
 QUOT  OCT           TEMP STG FOR BEAT PATTERN
       REM           
       REM           PRINT IMAGE FOR FIRST
       REM           LINE
       REM           
 PR1   OCT 32040001504 9 ROW LEFT
       OCT             9 ROW RIGHT
       OCT             8
       OCT           
       OCT             7
       OCT           
       OCT 4000000230  6
       OCT           
       OCT 40020002000 5
       OCT           
       OCT 300000002   4
       OCT           
       OCT             3
       OCT           
       OCT 14000000    2
       OCT           
       OCT 400000000   1
 PR4   OCT             ERROR WORD
       OCT 14000020    0
       OCT              COMPLEMENT OF ERROR WORD
       OCT 36040001714 11
       OCT           
       OCT 40720002002 12
       OCT           
       REM           
       REM           PRINT IMAGE FOR SECOND
       REM           LINE
       REM           
 PR2   OCT 32100000004 9
       OCT           
       OCT             8
       OCT           
       OCT 200000000   7
       OCT           
       OCT 4000000030  6
       OCT           
       OCT 40400000400 5
       OCT           
       OCT 760002      4
       OCT           
       OCT 40001100    3
       OCT           
       OCT 200         2
       OCT           
       OCT 0           1
 PR5   OCT             TEST WORD
       OCT 240001320   0
       OCT             COMPLEMENT OF TEST WORD
       OCT 36000000014 11
       OCT           
       OCT 40500000402 12
       OCT           
       REM           
       REM           ERROR ADDRESSING FORM
 PR7   OCT           7
       OCT           6
       OCT           5
       OCT           4
       OCT           3
       OCT           2
       OCT           1
       OCT           0
       REM           
       REM           PRINT IMAGE FOR 3RD LINE
 PR8   OCT 40000004    9
       OCT           
       OCT             8
       OCT           
       OCT 200000      7
       OCT 0         
       OCT 30          6
       OCT 0         
       OCT 20020000400 5
       OCT 0         
       OCT 300040002   4
       OCT 0         
       OCT 4000000100  3
       OCT 0         
       OCT 40014521000 2
       OCT           
       OCT 10400000200 1
 PR6   OCT           BEAT WORD
       OCT 4014000120  0
       OCT           COMPLEMENT OF BEAT WORD
       OCT 40000014    11
       OCT 0         
       OCT 70720001602 12
       OCT 0         
       REM           
       REM           PRINT IMAGE FOR 4TH LINE
 PR10  OCT 10010040014   9L
       OCT 400000144000  9R
       OCT 1001000       8
       OCT 10000000100
       OCT 2             7
       OCT 10020000  
       OCT 204620100000  6
       OCT 301000003010
       OCT 2000020000    5
       OCT 1         
       OCT 100           4
       OCT 1000000   
       OCT 520006200020  3
       OCT 12400200324
       OCT 40010400      2
       OCT 100000000 
       OCT 40000000040   1
       OCT 20004400000
       OCT 20064011022   0
       OCT 110010221100
       OCT 606400144110  11
       OCT 601441106014
       OCT 150213220044  12
       OCT 2000440020 
 PR11  OCT 400           Y1, Y2, Y3, OR Y4
       OCT 777777777377
 PR12  OCT 20000000000   ROW Y MATRIX
       OCT 100000000     COL Y MATRIX
       OCT 4000000       X1 OR X2
       OCT 200           ROW X MATRIX
       OCT 1             COL X MATRIX
       OCT 757673777576
       REM           
 NPER  SWT 3         
       TRA *+2       
       TRA C         
       REM           
       WPRA          
       SPRA 3        
       RCHA *+2      
       TRA C         
       REM           
       IOCD PNPER,0,24
       REM           
* PRINT -                NOW PERFORMING-9S04H-STORAGE TEST
* IMAGE -                NOW PERFORMING-9S04H-STORAGE TEST
 PNPER OCT 000000045040  9 ROW LEFT
       OCT 040000000000  9 ROW RIGHT
       OCT 000000000002  8 L
       OCT 000000000000  8 R
       OCT 000000200200  7 L
       OCT 010000000000  7 R
       OCT 000003030000  6 L
       OCT 100000000000  6 R
       OCT 000004100400  5 L
       OCT 004400000000  5 R
       OCT 000000002004  4 L
       OCT 000000000000  4 R
       OCT 000000000000  3 L
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
       REM           
* PRINT -                   PASS COMPLETE-9S04H-STORAGE TEST
* IMAGE -                   PASS COMPLETE-9S04H-STORAGE TEST
 PPER  OCT 000000000010  9 ROW LEFT
       OCT 010000000000  9 ROW RIGHT
       OCT 000000000000  8 L
       OCT 400000000000  8 R
       OCT 000000401000  7 L
       OCT 002000000000  7 R
       OCT 000000004000  6 L
       OCT 020000000000  6 R
       OCT 000000000240  5 L
       OCT 001100000000  5 R
       OCT 000000002001  4 L
       OCT 000000000000  4 R
       OCT 000000010500  3 L
       OCT 040220000000  3 R
       OCT 000000140004  2 L
       OCT 100040000000  2 R
       OCT 000000200000  1 L
       OCT 004000000000  1 R
       OCT 000000140106  0 L
       OCT 140260000000  0 R
       OCT 000000407420  11 L
       OCT 230000000000  11 R
       OCT 000000210240  12 L
       OCT 407100000000  12 R
 CNTL  MON 0,0,3     
 CNTL1 PZE PR1,0,24  CNTRL PRINT 1ST LINE
 CNTL2 PZE PR2,0,24  CNTRL PRINT 2ND LINE
 CNTL3 PZE PR8,0,24  CNTRL PRINT 3RD LINE
 CNTL4 PZE PR10,0,24 CNTRL PRINT 4TH LINE
       END           
