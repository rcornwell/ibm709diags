                                                             9S05 HA
                                                             7-01-58
       REM           9S05 H
       REM
       REM             COMPLEMENT CHECKERBOARD TEST
       REM             ALL ZERO TEST, AND
       REM             ALL ONES TEST
       REM             FOR A 738 CORE STORAGE
       REM THE FIRST HALF OF THE PROGRAM TESTS
       REM THE HIGH END OF MEMORY FROM 2000 TO
       REM 77777, AND THE SECOND HALF TESTS THE
       REM LOW END OF MEMORY FROM 00000 TO 76000
       REM
       REM SENSE LIGHTS 2+3 OFF- COMPLEMENT
       REM CHECKERBOARD TEST
       REM SENSE LIGHT 2 ON- ZEROS TEST
       REM SENSE LIGHT 3 ON- ONES TEST
       REM
       REM
       TRA NPER      TO PRINT IDENTIFICATION
 AA    SLF           TURN ALL SENSE LIGHTS OFF
       SLN 4         TURN SENSE LIGHT 4 ON TO
       REM           INDICATE THAT THE HIGH END
       REM           OF MEMORY IS BEING TESTED
       REM
       REM ENTER COMPLEMENT CHECKERBOARD TEST
       CLA TEST1
       STO T1
       CLA TEST2
       STO T2
       REM
 AA1   CLA K+2       L +2
       STO K+4       RESTORE COUNTER
       TRA E10A      REPEAT TEST
       REM
       REM
       REM
       LXA M+1,4     L +7
 A2    LXD M,2       L +4
 A1    LXA K0,1      L +0
       CLA T1
 A     STO 32767,1   WRITE PATTERN
       STO 32766,1
       CLA T2
       STO 32765,1
       STO 32764,1
       TXI A3,1,4
 A3    TXH A4,1,1023
       TRA A-1
 A4    CLA A
       SUB K1        L +2000
       STO A
       SUB K+1       L +1
       STO A+1
       SUB K+1       L +1
       STO A+3
       SUB K+1       L +1
       STO A+4
       TXL B,2,1
       REM
       LDQ T1
       CLA T2        REVERSE PATTERN FOR
       STO T1        NEXT BLOCK
       STQ T2
       TIX A1,2,1
       REM
 B     TIX A2,4,1    REVERSE SECTION
       REM
 C     CLA K         L +2 OR +1---ENTERING
       REM           LAST SECTION
       SUB K+1       L+1
       TZE D         START TESTING
       REM
       REM           PATTERN WRITTEN FROM
       REM           02000 TO 777777
       STO K         L +3
       LXD M+1,2     L +3
       TRA A1
       REM
       REM           TEST PATTERN
       REM
 D     CLA K+2       L+2
       STO K         RESTORE 2 COUNT
       LDQ T1
       CLA T2
       STO T1        SET INITIAL PATTERN
       STQ T2
       LXA M+1,4     L +7
 E     LXD M,2       L +4
 E1    LXA K0,1      L +0
       REM
       CLA T1
 E2    CAS 32767,1
       TRA P         ERROR
       TRA E3        OK
       TRA P         ERROR
       REM
 E3    CLA T2
       STO 32767,1   COMPLEMENT WORD
       CAS 32767,1
       TRA P1        COMPLEMENT ERROR
       TRA E4
       TRA P1        COMPLEMENT ERROR
       REM
 E4    CLA T1
       STO 32767,1   RESTORE PATTERN
       CAS 32766,1   NEXT WORD
       TRA P2        ERROR
       TRA E5        OK
       TRA P2        ERROR
       REM
 E5    CLA T2
       STO 32766,1   COMPLEMENT WORD
       CAS 32766,1
       TRA P3        COMPLEMENT ERROR
       TRA E6        OK
       TRA P3        COMPLEMENT ERROR
       REM
 E6    CLA T1
       STO 32766,1   RESTORE WORD
       TXI E6+3,1,2
       LDQ T1
       CLA T2        REVERSE PATTERN
       STO T1
       STQ T2
       TXH E7,1,1023
       TRA E2
       REM
       REM
 E7    CLA E2        BLOCK REVERSAL
       SUB K1        L +2000
       STA E2
       STA E3+1
       STA E3+2      READJUST ADDRESS
       STA E4+1
       SUB K+1       L +1
       STA E4+2
       STA E5+1
       STA E5+2
       STA E6+1
       REM
       TXL E9,2,1
       LDQ T1        REVERSE PATTERN FOR
       CLA T2        NEXT BLOCK
       STO T1
       STQ T2
       TIX E1,2,1
 E9    TIX E,4,1     REVERSE SECTION
       REM
       CLA K         L +2 OR +1---ENTERING
       REM           LAST SECTION
       SUB K+1       L +1
       TZE E10       TESTING COMPLETE
       STO K
       LXD M+1,2     L +3
       TRA E1
       REM
 E10   CLA K+4       L COUNTER
       SUB K+1       L +1
       TZE E11       PASS COMPLETED
       STO K+4       INVERT PREVIOUS PATTERN
       REM
 E10A  CLA K+2       L +2
       STO K
       CLA K+3       L+77777
       STA A
       STA E2        RESTORE INITIAL VALUES
       STA E3+1
       STA E3+2
       STA E4+1
       SUB K+1       L +1
       STA A+1
       STA E4+2
       STA E5+1
       STA E5+2
       STA E6+1
       SUB K+1       L +1
       STA A+3
       SUB K+1       L +1
       STA A+4
       TRA A2-1      WRITE INVERSE PATTERN
       REM
       REM
 E11   SWT 1         TEST SENSE SWITCH 1
       TRA E11+3     GO TO NEXT TEST
       TRA AA1       LOOP IN PRESENT TEST
       REM
       SLT 2         TEST SENSE LIGHT 2
       TRA E11A      OFF - TEST LIGHT 3
       REM           JUST COMPLETED ALL ZEROS TEST
       SLN 3         TURN SENSE LIGHT 3 ON
       CLA ONES
       STO T1
       CLA ONES+1
       STO T2
       TRA AA1       ENTER ALL ONES TEST
       REM
       REM
 E11A  SLT 3         TEST SENSE LIGHT 3
       TRA E11B      OFF - ENTER ZEROS TEST
 PCOM  SWT 3
       TRA *+2
       TRA SW6
       REM
       WPRA          TO PRINT PASS COMPLETE
       SPRA 3
       RCHA *+2
       TRA SW6
       REM
       IOCD PPER,0,24
 SW6   SWT 6         TEST SWITCH 6
       TRA *+2       UP-READ NEXT PROGRAM
       TRA AA        REPEAT TEST
       RCDA          READ IN NEXT TEST
       RCHA CNTL
       LCHA 0
       TRA 1
       REM
       REM
 E11B  SLN 2         TURN ON SENSE LIGHT 2
       CLA ZEROS
       STO T1
       CLA ZEROS+1
       STO T2
       TRA AA1       ENTER ALL ZEROS TEST
       REM
       REM
       REM
       REM           ERROR ROUTINES
       REM
 P     CLA E2        ERROR
       STA K-1
       CLA E2+2      L TRA E3
       STO P13       PROGRAM RETURN
       TRA P2+4
       REM
       REM
 P1    CLA E3+2      COMPLEMENT ERROR
       STA K-1
       CLA E3+4      L TRA E4
       STO P13       PROGRAM RETURN
       TRA P3+4
       REM
       REM
 P2    CLA E4+2      ERROR
       STA K-1
       CLA E4+4      L TRA E5
       STO P13       PROGRAM RETURN
       CAL T1        TEST WORD
       SLW PR5
       COM
       SLW PR5+2     COMPLEMENT OF TEST WORD
       CLA K0        L +0---INITIAL PATTERN
       TRA P3A
       REM
       REM
 P3    CLA E5+2      COMPLEMENT ERROR
       STA K-1
       CLA E5+4      L TRA E6
       STO P13       PROGRAM RETURN
       CAL T2        TEST WORD
       SLW PR5
       COM
       SLW PR5+2     COMPLEMENT OF TEST WORD
       CLA K1+1      L +7000000
       REM
       REM
 P3A   STO P6        INITIAL OR COMPLEMENT
       PXD 0,1
       LRS 18
       SUB K-1
       STA P3A+6     ADDRESS OF ERROR WORD
       STA P6
       CAL           ERROR WORD
       SLW PR4
       COM
       SLW PR4+2     COMPLEMENT OF ERROR WORD
       REM
       REM
 P10   SWT 2         TEST SENSE SWITCH 2
       TRA P10+3     INDICATE ERROR
       TRA P13       BYPASS ERROR
       SWT 3         TEST SENSE SWITCH 3
       TRA E13       PRINT
       LDQ P6        ERROR ADDRESS
       CLA PR4       ERROR WORD
       HTR P13       PROGRAM RETURN
       REM
       REM
 E13   SXD K-2,1     PRINT ERROR
       LXA M+3,1     L +10
       STZ PR7+8,1
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
       LXD M+2,1     L +27
       CLA K4+1      L 37777777
 P10AB ANS PR5+6,1
       TIX P10AB,1,2
       REM
       CLA K5
       STO P10A
       LXA M+3,1     L +10
       CLA PR7+8,1
 P10A  ORS PR1+12,1
       CLA P10A
       SUB K+1       L -1
       STA P10A
       TIX P10A-1,1,1
       LXA M+2,1     L +30
       CLA K1+1      L 7000000
       ANA P6        L ERROR ADDRESS
       TNZ PP1       COMPLEMENT PATTERN
       REM
 PP    CLA PR8+24,1  INITIAL PATTERN
       ORS PR2+24,1
       TIX PP,1,2
       TRA PP1+3
       REM
 PP1   CLA PR8+25,1  COMPLEMENT
       ORS PR2+24,1
       TIX PP1,1,2
       REM
       WPRA          PRINT FIRST LINE
       SPRA 3        DOUBLE SPACE
       SPRA 4        TO GET OCTAL SPACING
       RCHA CNTL1    L CONTROL FIRST LINE
       REM
       WPRA          PRINT SECOND LINE
       SPRA 4        TO GET OCTAL SPACING
       RCHA CNTL2    L CONTROL SECOND LINE
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
       REM           1ST OT 2ND QUADRANT
       CAS K10+12    L +20000
       TRA Y1        1ST 4 COLUMNS
       TRA Y1
       TRA Y112      LAST 4 COLUMNS
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
       TRA R27+2     ROW 8 X2
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
       ORS PR10+15   ROW 2 X MATRIX
       TRA R28
       REM
 R27G  CLA PR12+3
       ORS PR10+17   ROW 1 X MATRIX
       REM
 R28   WPRA
       RCHA CNTL3    PRINT-CNTRL 3RD LINE
       REM
       REM           RETURN TO PROGRAM
       LXD K-2,1     RESTORE INDEX COUNT
 P13   TRA           TO E3, E4, E5, OR E6
       REM
       REM
       REM           TEST WORDS FOR COMPLEMENT
       REM           CHECKERBOARD TEST
 TEST1 OCT 0
 TEST2 OCT 777777777777
       REM         TEST WORDS FOR ALL ZEROS TEST
 ZEROS OCT 0
       OCT 0
       REM         TEST WORDS FOR ALL ONES TEST
 ONES  OCT 777777777777
       OCT 777777777777
       REM
       REM
 T1    OCT           TEST
 T2    OCT               PATTERN
       REM
 K0    OCT 0
       OCT           INDEX COUNT
       OCT           TEMPORARY STORAGE
 K     OCT 2         COUNTER
       OCT 1         CONSTANTS
       OCT 2         CONSTANT
       OCT 77777
       OCT 2         COUNTER
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
       OCT 37777777
       REM
 K5    ORS PR1+12,1  ORS TO PR1+12,1
       REM
       OCT 0             TEMP STG.
       OCT 0             ERROR ADDRESS
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
 P6    OCT           ERROR ADDRESS
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
       OCT             COMPLEMENT OF ERROR WORD
       OCT 36040001714 11
       OCT
       OCT 40720002002 12
       OCT
       REM
       REM           PRINT IMAGE FOR SECOND
       REM           LINE
       REM
 PR2   OCT 200004      9
       OCT
       OCT             8
       OCT
       OCT 10000000    7
       OCT
       OCT 30          6
       OCT
       OCT 500400      5
       OCT
       OCT 2           4
       OCT
       OCT 3001100     3
       OCT
       OCT 200         2
       OCT
       OCT 4000000     1
 PR5   OCT             TEST WORD
       OCT 3001320     0
       OCT             COMPLEMENT OF TEST WORD
       OCT 10300014    11
       OCT
       OCT 4400402     12
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
       REM           ADDRESSING FORM FOR
 PR8   OCT 52000000000 9 INITIAL
       OCT             COMPLEMENT
       OCT             8
       OCT
       OCT             7
       OCT 4000000000
       OCT             6
       OCT 20000000000
       OCT 20000000000 5
       OCT 1300000000
       OCT             4
       OCT 10400000000
       OCT 4400000000  3
       OCT 42040000000
       OCT             2
       OCT
       OCT 1000000000  1
       OCT
       OCT 4000000000  0
       OCT 40000000
       OCT 20400000000 11
       OCT 36500000000
       OCT 53000000000 12
       OCT 41200000000
       REM
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
 CNTL  MON 0,0,3
 CNTL1 PZE PR1,0,24  CNTRL PRINT 1ST LINE
 CNTL2 PZE PR2,0,24  CNTRL PRINT 2ND LINE
 CNTL3 PZE PR10,0,24 CNTRL PRINT 3RD LINE
 NPER  SWT 3
       TRA *+2
       TRA AA
       REM
       WPRA
       SPRA 3
       RCHA *+2
       TRA AA
       REM
       IOCD PNPER,0,24
       REM
* PRINT -                NOW PERFORMING-9S05H-STORAGE TEST
* IMAGE -                NOW PERFORMING-9S05H-STORAGE TEST
 PNPER OCT 000000045040  9 ROW LEFT
       OCT 040000000000  9 ROW RIGHT
       OCT 000000000002  8 L
       OCT 000000000000  8 R
       OCT 000000200200  7 L
       OCT 010000000000  7 R
       OCT 000003030000  6 L
       OCT 100000000000  6 R
       OCT 000004100404  5 L
       OCT 004400000000  5 R
       OCT 000000002000  4 L
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
* PRINT -                   PASS COMPLETE-9S05H-STORAGE TEST
* IMAGE -                   PASS COMPLETE-9S05H-STORAGE TEST
 PPER  OCT 000000000010  9 ROW LEFT
       OCT 010000000000  9 ROW RIGHT
       OCT 000000000000  8 L
       OCT 400000000000  8 R
       OCT 000000401000  7 L
       OCT 002000000000  7 R
       OCT 000000004000  6 L
       OCT 020000000000  6 R
       OCT 000000000241  5 L
       OCT 001100000000  5 R
       OCT 000000002000  4 L
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
       END
