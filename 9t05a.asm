*                                                          9 T 0 5 A
*                                                           3-15-59
       REM
       REM
*                          9 T 0 5 A
       REM
*           709 TAPE INTER-RECORD GAP,LOAD CHANNEL
*                   TIMING AND CREEP TEST
       REM
*                          729-1 TEST
       REM
       REM
************************************************************************
       REM
*                  I N I T I A L I Z A T I O N
       REM
       ORG 24
       REM
       NOP
       REM
       SWT 3         TEST SENSE SWITCH 3
IDN    TSX PRID,4    TO PRINT OUT TEST IDENTITY
       REM
       TSX IOC,4     TO ENTER CONTROL WORDS
       CLA K21       L LDI CTRL1
       STO INTL1
       REM
       REM
*             CHECK FOR EXCLUSIVE TAPE FRAME BITS IN
*             I-O CONTROL WORD AND ESTABLISH INITIAL
*             STATUS OF UNIT ADDRESSES
       REM
INTL   CLA CTRL1     L CHANNEL A CONTROL
       TPL *+5       CHECK IF PROGRAM READ
       REM           FROM CARDS
       CLA K20+4     YES - L READ CARDS
       STO FINL1
       CLA K20+1     L WTBA 1
       TRA *+4
       REM
       CLA K20+3     NOT READ FROM CARDS --
       REM           L RTBA 1
       STO FINL1
       CLA K20+2     L WTBA 2
       STO K20       SET WTBA X
       STA K20+5     SET RTBA X
       REM
RUC    TSX IOCNT,4   TO RESET UNIT COUNT
       REM
INTL1  LDI CTRL1     L IND WITH CHN A CONTROL
       RFT 00360     CHK FOR TAPE ON CHN A
       TRA *+2       YES - TAPE ON CHN A
       TRA *+4       NO TAPE ON CHN A
       REM           GO TO ADJUST PROGRAM
       RFT 00340     CHK FOR UNITS ABOVE 1
       RNT 00400     YES - CHK FOR EXCLUSIVE BI
       TRA INTL2     UNIT 1 OK - GO TO
       REM           ESTABLISH STATUS OF
       REM           SELECT INSTRUCTIONS
       CLA TRA3      L TRA INTLA
       STO TCTX+6
       TRA TCTX
       REM
INTLA  CLA TYM+1     L SELECT
       STA K20
       STA K20+5
       CLA TRA3+1    L TRA AC
       STO TCTX+6
       CLA TRA3+3    L TRA INTL2
       STO INTL1
       REM
INTL2  CLA TYM+1     UNIT 1 OK -- ESTABLISH
       STO REST-1
       CAS K20       STATUS OF SELECT INSTRS
       TRA *+2
       TRA INTLB     UNIT ADDR OK - PROCEED
       TSX CTX,4     GO TO ADJUST PROGRAM
       HTR ALF,0,OMG1  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF1,0,OMG2  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF2,0,OMG3  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF3,0,OMG4  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF4,0,OMG  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR REST-2,0,REST+8 MODIFICATION AREA
       TRA INTL2
INTLB  NOP
       REM
       REM
AC     CLA IOCT      L UNIT COUNT
       TZE PASS1     ALL UNITS CALLED CHECKED
       REM           FOR RESET-LOAD CHANNEL
       SUB ONE       L +1
       STO IOCT
       REM
AA     CLA TRA1      L TRA TYM-13
ALF    STO 0         POST RESTART
       TRA *+2       SKIP BCD WORD
       REM
       REM
********************************************************************
       REM
*    R E S E T - L O A D   C H A N N E L   T I M I N G T E S T     *
       REM
       REM
*            CHECK RESET-LOAD CHANNEL TIMING
*              AFTER SELECT INSTRUCTION
       REM
       REM
*            CHECK FOR WRITE AT LOAD POINT
       REM
       BCD 1TYM      TEST CONDITION
       REM
       TSX REST,4    GO TO RESET INDICATORS
       CLA TYMK      L NORMINAL MAX TIME DELAY
       REM           FOR WRITE AT LOAD POINT
       SWT 5         TEST SENSE SWITCH 5
       TRA *+2       UP - PROCEED
       ARS 1         DN - DIVIDE BY 2 FOR
       STO TYMK+1    REPEAT TILL FAILURE
       REM
       REM
       BSFA 1        RETURN
       BSFA 1        TAPE TO
       BSFA 1        LOAD POINT
       TCOA *        DELAY
       BTTA          CHECK FOR TAPE REWOUND
       TRA *+2       ON - TAPE REWOUND TO LP
       TRA *-5       OFF - TAPE NOT YET TO LP
TYM    LXA TYMK+1,1  L CURRENT DELAY IN XRA
       WTBA 1
       TIX *,1,1     DELAY
       RCHA CT1
       TSX RDNCK,4   REDUNDANCY ERROR CHECK
       NOP TYM-13
       IOT
TYMA   TRA *+2       ON -  TIMING EXCEEDED
       TRA TYMC      OFF - OK
       REM
       SWT 5         TEST SENSE SWITCH 5
       TRA TYMB+4    UP - GO TO PRINT
       CLA TYMK+1    L DELAY COUNT
       SUB TYMK4     REDUCE COUNT TO LAST
       STO TYMK+1    SUCCESSFUL PASS COUNT
       CLA TYMK4+1   L ADD ONE
       STO TYMC+3
       CLA TYMK4+2   L TRA TYMB
       STO TYMA
       TRA TYM-6
       REM
TYMB   CLA TYMK4+3   L ADD TYMK4
       STO TYMC+3
       CLA TYMK4+4   L TRA TYMA+2
       STO TYMA
       REM
       SWT 2         CHECK SENSE SWITCH 2
       TRA *+2       UP - PROCEED
       TRA TYMC+1    DN - IGNORE ERROR
       REM
       REM
*             CLEAR PRINT IMAGE 1
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 1
       CAL MASK1     L +377540037400
       ANS PR1+21,1
       REM
       REM
*             ADJUST FOR PRINT IMAGE 1
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ TYMK+1
       STQ TYMK+2
       AXT 5,2       L +5 IN XRB
       CLA TYMK+2
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT8+1,2  L BIT FOR IMAGE
       ORS PR1+19,1
       REM
       REWA 1        REWRITE RECORD
       WTBA 1        ERASE BY
       RCHA CT1      EXCESSIVE DELAY
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       UP - PRINT
       HTR TYMC+6    DN - BYPASS PRINT - CHECK
       REM           TYMK+2 FOR MAX TIME
       TSX PRT1,2    GO TO PRINT
       REM
TYMC   SWT 5         TEST SENSE SWITCH 5
       TRA *+5       UP - PROCEED
       CLA TYMK+1    STEP
       ADD TYMK4     DELAY
       STO TYMK+1    COUNT
       TRA TYM-6     REPEAT TILL FAILURE
       REM
       SWT 1         TEST SENSE SWITCH 1
       TRA *+3       UP - PROCEED
       TRA TYM-13    DN - REPEAT CHECK
       REM
       REM
*             CHECK FOR READ AT LOAD POINT
       REM
       BCD 1TWM1     TEST CONDITION
       REM
       TSX REST,4    GO TO RESET INDICATORS
       REM
       AXT 64,1      L +100 IN XRA
       STZ RDFD+64,1 CLEAR
       TIX *-1,1,1   READ FIELD
       REM
       CLA TYMK1     L NOMINAL MAX TIME DELAY
       REM           FOR READ AT LOAD POINT
       SWT 5         TEDT SENSE SWITCH 5
       TRA *+2       UP - PROCEED
       ARS 1         DN - DIVIDE BY 2 FOR
       STO TYMK1+1   REPEAT TILL FAILURE
       REM
       REM
       BSFA 1        RETURN
       BSFA 1        TAPE TO
       BSFA 1        LOAD POINT
       TCOA *        DELAY
       BTTA          CHECK FOR TAPE REWOUND
       TRA *+2       ON - TAPE REWOUND TO LP
       TRA *-5       OFF - TAPE NOT YET TO LP
TYM1   LXA TYMK1+1,1 L CURRENT DELAY IN XRA
       RTBA 1
       TIX *,1,1     DELAY
       RCHA CT2
       TSX RDNCK,4   REDUNDANCY ERROR CHECK
       NOP TYM1-16
       IOT
TYM1A  TRA *+2       ON - TIMING EXCEEDED
       TRA TYM1C     OFF - OK
       SWT 5         TEST SENSE SWITCH 5
       TRA TYM1B+4   UP - GO TO PRINT
       CLA TYMK1+1   DN - L DELAY COUNT
       SUB TYMK4     REDUCE COUNT TO LAST
       STO TYMK1+1   SUCCESSFUL PASS COUNT
       CLA TYMK4+1   L ADD ONE
       STO TYM1C+3
       CLA TYMK4+5   L TRA TYM1B
       STO TYM1A
       TRA TYM1-6
       REM
TYM1B  CLA TYMK4+3   L ADD TYMK4
       STO TYM1C+3
       CLA TYMK4+6   L TRA TYM1A+2
       STO TYM1A
       REM
       SWT 2         CHECK SENSE SWITCH 2
       TRA *+2       UP - PROCEED
       TRA TYM1D     DN - IGNORE ERROR
       REM
       REM
*             CLEAR PRINT IMAGE 2
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 2
       CAL MASK1     L +377540037400
       ANS PR2+21,1
       REM
       REM
*             ADJUST FOR PRINT IMAGE 2
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ TYMK1+1
       STQ TYMK1+2
       REM
       AXT 5,2       L +5 IN XRB
       CLA TYMK1+2
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT8+1,2  L BIT FOR IMAGE
       ORS PR2+19,1
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       UP - PRINT
       HTR TYM1D     DN - BYPASS PRINT - CHECK
       REM           TYMK1+2 FOR MAX TIME
       REM
       TSX PRT2,2    GO TO PRINT
       REM
TYM1C  SWT 5         TEST SENSE SWITCH 5
       TRA *+5       UP - PROCEED
       CLA TYMK1+1   STEP
       ADD TYMK4     DELAY
       STO TYMK1+1   COUNT
       TRA TYM1-6    REPEAT TILL FAILURE
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+3       UP - SKIP BCD WORD
       TRA TYM1D     DN - BYPASS CHECK OF WORDS
       REM
*             CHECK RECORD WRITTEN
       REM
       BCD 1RTBA 1   TEST INSTRUCTION
       CLA TWO       L +2
       STO RECNO
       AXT 1,2       L +1 IN XRB
       CLA K4+3      L +41
       STO WDNO
       AXT 32,1      L +40 IN XRA
       CLA RDFD+32,1 L WORD READ
       CAS FIX+32,1  COMPARE WORD GENERATED
       TRA *+2
       TRA *+4
       LDQ FIX+32,1  L WORD GENERATED IN MQ
       TSX ERROR-2,4 READ-WRITE ERROR
       NOP *-12
       TIX *-7,1,1
       REM
       REM
TYM1D  SWT 1         TEST SENSE SWITCH 1
       TRA *+3       UP - PROCEED
       TRA TYM1-16   DN - REPEAT CHECK
       REM
       REM
*            CHECK FOR WRITE NOT AT LOAD POINT
       REM
       BCD 1TYM2     TEST CONDITION
       REM
       TSX REST,4    GO TO RESET INDICATORS
       CLA TYMK2     L NOMINAL MAX TIME DELAY
       REM           FOR WRITE NOT AT LP
       SWT 5         TEST SENSE SWITCH 5
       TRA *+2       UP - PROCEED
       ARS 1         DN - DIVIDE BY 2 FOR
       STO TYMK2+1   REPEAT TILL FAILURE
       REM
       WEFA 1        WRITE END OF FILE
       REM
       TCOA *        DELAY
       LXA TYMK2+1,1 L CURRENT DELAY IN XRA
TYM2   WTBA 1
       TIX *,1,1     DELAY
       RCHA CT3
       TSX RDNCK,4   REDUNDANCY ERROR CHECK
       NOP TYM2-9
       IOT
TYM2A  TRA *+2       ON - TIMING EXCEEDED
       TRA TYM2C     OFF - OK
       REM
       SWT 5         TEST SENSE SWITCH 5
       TRA TYM2B+4   UP - GO TO PRINT
       CLA TYMK2+1   DN - L DELAY COUNT
       SUB K+1       REDUCE COUNT TO LAST
       STO TYMK2+1   SUCCESSFUL PASS COUNT
       CLA TYMK4+1   L ADD ONE
       STO TYM2C+3
       CLA TYMK4+7   L TRA TYM2B
       STO TYM2A
       TRA TYM2-3
       REM
TYM2B  CLA TYMK4+12  L ADD K+1
       STO TYM2C+3
       CLA TYMK4+8   L TRA TYM2A+2
       STO TYM2A
       REM
       SWT 2         CHECK SENSE SWITCH 2
       TRA *+2       UP - PROCEED
       TRA TYM2C+1   DN - IGNORE ERROR
       REM
       REM
*            CLEAR PRINT IMAGE 3
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 3
       CAL MASK1     L +377540037400
       ANS PR3+21,1
       REM
       REM
*            ADJUST FOR PRINT IMAGE 3
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ TYMK2+1
       STQ TYMK2+2
       REM
       AXT 5,2       L +5 IN XRB
       CLA TYMK2+2
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT8+1,2  L BIT FOR IMAGE
       ORS PR3+19,1
       REM
       WEFA 1        REWRITE RECORD
       WTBA 1        ERASED BY
       RCHA CT3      EXCESSIVE DELAY
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       UP - PRINT
       HTR TYM2C+6   DN - BYPASS PRINT - CHECK
       REM           TYMK2+2FOR MAX TIME
       REM
       TSX PRT3,2    GO TO PRINT
       REM
       REM
TYM2C  SWT 5         TEST SENSE SWITCH 5
       TRA *+5       UP - PROCEED
       CLA TYMK2+1   STEP
       ADD K+1       DELAY
       STO TYMK2+1   COUNT
       TRA TYM2-3    DN - REPEAT TILL FAILURE
       REM
       SWT 1         TEST SENSE SWITCH 1
       TRA *+3       UP - PROCEED
       TRA TYM2-9    DN - REPEAT CHECK
       REM
       REM
*             CHECK FOR READ NOT AT LOAD POINT
       REM
       BCD 1TYM3     TEST CONDITION
       REM
       TSX REST,4    GO TO RESET INDICATORS
       REM
       AXT 64,1      L +100 IN XRA
       STZ RDFD+64,1 CLEAR
       TIX *-1,1,1   READ FIELD
       REM
       CLA TYMK3     L NOMINAL MAX TIME DELAY
       REM           FOR READ NOT AT LP
       SWT 5         TEST SENSE SWITCH 5
       TRA *+2       UP - PROCEED
       ARS 1         DN - DIVIDE BY 2 FOR
       STO TYMK3+1   REPEAT TILL FAILURE
       REM
       BSRA 1
       AXT 3482,1    L +6632 IN XRA
       TIX *,1,1     DELAY 76 DEC MILSEC
       LXA TYMK3+1,1 L CURRENT DELAY IN XRA
TYM3   RTBA 1
       TIX *,1,1
       RCHA CT4
       TSX RDNCK,4   REDUNDANCY ERROR CHECK
       NOP TYM3-13
       IOT
TYM3A  TRA *+2       ON - TIMING EXCEEDED
       TRA TYM3C     OFF - OK
       SWT 5         TEST SENSE SWITCH 5
       TRA TYM3B+4   UP - GO TO PRINT
       CLA TYMK3+1   DN - L DELAY COUNT
       SUB EIGHT     REDUCE DELAY COUNT TO
       STO TYMK3+1   LAST SUCCESSFUL PASS
       CLA TYMK4+1   L ADD ONE
       STO TYM3C+3
       CLA TYMK4+9   L TRA TYM3B
       STO TYM3A
       TRA TYM3-4
       REM
TYM3B  CLA TYMK4+10  L ADD EIGHT
       STO TYM3C+3
       CLA TYMK4+11  L TRA TYM3A+2
       STO TYM3A
       REM
       SWT 2         CHECK SENSE SWITCH 2
       TRA *+2       UP - PROCEED
       TRA TYM3D     DN - IGNORE ERROR
       REM
       REM
*             CLEAR PRINT IMAGE 4
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 4
       CAL MASK1     L +377540037400
       ANS PR4+21,1
       REM
       REM
*             ADJUST FOR PRINT IAMGE 4
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ TYMK3+1
       STQ TYMK3+2
       REM
       AXT 5,2       L +5 IN XRB
       CLA TYMK3+2
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT8+1,2  L BIT FOR IMAGE
       ORS PR4+19,1
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       UP - PRINT
       HTR TYM3D     DON - BYPASS PRINT - CHECK
       REM           TYMK3+2 FOR MAX TIME
       REM
       TSX PRT4,2    GO TO PRINT
       REM
TYM3C  SWT 5         TEST SENSE SWITCH 5
       TRA *+5       UP - PROCEED
       CLA TYMK3+1   STEP
       ADD EIGHT     DELAY
       STO TYMK3+1   COUNT
       TRA TYM3-4    REPEAT TILL FAILURE
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+3       UP - SKIP BCD WORD
       TRA TYM3D     DN - BYPASS CHECK OF W
       REM
*             CHECK RECORD WRITTEN
       REM
       BCD 1RTBA 1   TEST INSTRUCTION
       CLA TWO       L +2
       STO RECNO
       AXT 1,2       L +1 IN XRB
       CLA K4+3      L +41
       STO WDNO
       AXT 32,1      L +40 IN XRA
       CLA RDFD+64,1 L WORD READ
       CAS FIX+64,1  COMPRARE WORD GENERATED
       TRA *+2
       TRA *+4
       LDQ FIX+64,1
       TSX ERROR-2,4 READ-WRITE ERROR
       NOP *-12
       TIX *-7,1,1
       REM
       REM
TYM3D  SWT 1         TEST SENSE SWITCH 1
       TRA *+2       UP - PROCEED
       TRA TYM3-13   DN - REPEAT CHECK
       REM
       NZT IOCT      CHECK UNIT COUNT
       SWT 4         NO UNIT COUNT - CHECK SSW 4
       REWA 1        UP - OR UNIT COUNT LEFT
       REM           REWIND TEST UNIT
       SWT 3         DN - CHECK SENSE SWITCH 3
       TRA *+2       UP - PRINT
OMG1   TRA TCTX      DN - BYPASS PRINT
       REM
       REM
*             CLEAR PRINT IMAGE 5
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 5
       CAL MASK2     L +701400377777
       ANS PR5+20,1
       REM
       REM
       REM
*             ADJUST FOR PRINT IMAGE 5
       REM
       TSX UNIT,4
       REM
       CAL TYM+1     L SELECT
       CLA BIT3      L BIT IN COL 13
       ORS PR5+18,1
       CLA BIT2+1    L BIT IN COL 12
       CLA BIT1      L BIT IN COL  5
       REM
       TSX PRT5,2    GO TO PRINT UNIT PASS
       REM
       REM
TCTX   CAL TYM+1     L SELECT
       SLW REST-1
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF,0,OMG1 MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR REST-2,0,REST+8
       REM
       TRA AC
       REM
       REM
PASS1  SWT 4         TEST SENSE SWITCH 4
       TRA RUC1      UP - PROCEED
       TRA RUC       DN - REPEAT LD CHN TEST
       REM
       REM
************************************************************************
       REM
*             I N T E R - R E C O R D    G A P    T E S T              *
       REM
       REM
GAP    CLA TRA1+1    L TRA AC1-5
       STO INTLB
       STO TCTX1+6
       TRA IDN-1
       REM
RUC1   TSX IOCNT,4   TO RESET UNIT COUNT
       REM
INTL3  CLA W         ESTABLISH INITIAL
       STO REST-1
       CAS K20       STATUS OF SELECT INSTRS
       TRA *+2
       TRA *+6       UNIT ADDR OK - PROCEED
       TSX CTX,4     GO TO ADJUST PROGRAM
       HTR ALF1,0,OMG2  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR REST-2,0,REST+8 MODIFICATION AREA
       TRA INTL3
       NOP
       REM
*             RESET SENSE SWITCHES USED IN
*                RESET-LOAD CHANNEL TEST
       REM
       SWT 1         TEST SENSE SWITCH 1
       TRA *+2       UP - PROCEED
       SLN 1         TURN ON SENSE LIGHT 1
       SWT 4         TEST SENSE SWITCH 4
       TRA *+2       UP - PROCEED
       SLN 1         TURN ON SENSE LIGHT 1
       SWT 5         TEST SENSE SWITCH 5
       TRA *+2       UP - PROCEED
       SLN 1         TURN ON SENSE LIGHT 1
       SLT 1         TEST SENSE LIGHT 1
       TRA *+2       OFF - PROCEED
       HTR *-5       ON - HALT TO ADJUST SENSE
       REM           SWITCHES BEFORE PROCEEDING
       REM
       CLA NOP       L NOP
       STO INTLB
       CLA TRA1+4    L TRA AC1-1
       STO TCTX1+6
       REM
       SLF           TURN OFF ALL SENSE LIGHTS
       REM
AC1    CLA IOCT      L UNIT COUNT
       TZE RUC2      ALL UNITS CALLED WRITTEN
       REM           - GO TO READ
       SUB ONE       L +1
       STO IOCT
       REM
AA1    CLA TRA1+2    L TRA AA1
       STO 0         POST RESTART TO
       REM           WRITE GAP TEST
       REM
       REM
       XEC W-2       REWIND TEST UNIT
       REM
       REM
WB     CLA K3+4      L +03060500 -- RESET MIN
       STO K3        ADJUSTED VARIABLE DELAY
       CLA K+6       L +01724 --
       STO K+5       MINIMUM VARIABLE WR DELAY
       REM           OF .98 MILSEC
       CLA K+1       L +0751 --
       STO K         MINIMUM VARIABLE INDEX
       REM           COUNT FOR .98 DELAY
       REM
       STZ REC       RESET RECORD COUNT TO ZERO
       REM
WA     SWT 5         TEST SENSE SWITCH 5
       TRA WA+3      UP - CONTINUE TO WRITE
       HTR WA2       DN - TAPE COMPLETE --
       REM           RAISE SSW 5 AND PRESS
       REM           START TO WRITE NEXT TAPE
       REM
       CLA K+5       L DELAY WRITE
       ADD K+7       L +30 -- STEP DELAY WRITE
       STO K+5       CURRENT DELAY WRITE
       REM
WA1    CAL K3+3      L 545050505077 --
       REM            -A- RECORD MASK
       ANS K2+1      CLEAR WRITE DELAY TIME
       REM           IN -A- RECORD
       CAL K3        L CURRENT WRITE DELAY
       ACL K3+1      L 70707600 -- ADJUSTED
       REM           STEP WRITE DELAY
       ANA K3+2      L 7070770700
       ORS K2+1      L -A- RECORD WITH
       REM           WRITE DELAY
       SLW K3        SAVE CURRENT WRITE DELAY
       REM
       CLA K         L INDEX VARIABLE DELAY
       ADD K+2       L +1 --STEP INDEX DELAY
       STO K         CURRENT INDEX DELAY
       SUB K+3       L +01222 --
       REM           MAXIMUM VARIABLE INDEX
       REM           COUNT FOR 5.01 DELAY
       TMI W         CONTINUE TO WRITE ON TAPE
       REM
       REM
WA2    XEC W-1       STOP WRITING ON TAPE X
       REM           MAXIMUM DELAY EXCEEDED
       TCOA *        DELAY
       XEC W-2       REWIND TEST UNIT
       REM
TCTX1  CAL W         L SELECT
       SLW REST-1
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF1,0,OMG2  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR REST-2,0,REST+8
       REM
ALF1   TRA AC1-1
       REM
       REM
       REM
*             WRITE TAPE
       REM
       REWA 1        DUMMY REWIND
       WEFA 1        DUMMY WRITE  END OF FILE
       REM
W      WTBA 1
       TSX REST,4    GO TO RESET INDICATORS
       CLA K         L VARIABLE INDEX DELAY
       ARS 1         DIVIDE BY 2 TO REDUCE NO
       REM           OF WORDS WRITTEN SO FIRST
       REM           RECORD LENGTH IS COMPARABLE
       REM           TO VARIABLE DELAY
       PAX 0,1       L ADJUST DELAY IN XRA
       RCHA CT6
       LCHA CT6
       TIX *-1,1,1
       LCHA CT7+2    WRITE 2 -A- WORDS -- END
       LCHA CT7      OF VARIABLE LENGTH RECORD
       REM
*             10 MILSEC DELAY BEFORE WRITING -10- RECORD
       REM
       LXA K+4,1     L +01067
       REM           10 MILSEC INDEX DELAY PLUS
       REM           3.61 DELAY FROM LCH TO
       TIX *,1,1     GO DOWN
       WTBA 1
       RCHA CT8      WRITE -10- RECORD
       REM
*             VARIABLE TIME DELAY BEFORE WRITING -V- RECORD
       REM
       LXA K,1       L +0701 INDEX DELAY FOR
       TIX *,1,1     WTB + ONE WORD TO GO DOWN
       REM           PLUS VARIABLE DELAY
       WTBA 1
       RCHA CT9      WRITE -V- RECORD
*             GO LINE DOWN MINIMUM LENGTH OF TIME BEFORE
*                    WRITING -O- RECORD
       REM
       WTBA 1
       RCHA CT10     WRITE -O- RECORD
       LXA K4+2,1    L INDEX DELAY FOR
       TIX *,1,1     10 MILSEC UTILITY GAP
       IOT           TEST I-O CHECK
       HTR WB-1      ON - ERROR, TRY AGAIN
       TRA *+3       OFF - OK, SKIP BCD WORD
       REM           AND DUMMY INSTRUCTION
       REM
       BCD 1WTBA 1   TEST INSTRUCTION
       WTBA 1        DUMMY INSTRUCTION FOR 9IOM
       CLA REC       L NUMBER OF RECORD GROUPS
       ADD ONE       L +1
OMG2   STO REC       SAVE NEW NUMBER
       REM
*             CHECK FOR REDUNDANCY DURING WRITE
       REM
       TSX RDNCK,4   CHECK FOR REDUNDANCY
       NOP *-5
       TRA WA        TO INCREASE DELAY
       REM
       REM
*             LOAD UNIT COUNT FROM CONTROL WORD
       REM
RUC2   TSX IOCNT,4   TO RESET UNIT COUNT
       TSX REST,4    GO TO RESET INDICATORS
       REM
INTL4  CLA R         ESTABLISH INITIAL
       STO REST-1
       CAS K20+5     STATUS OF SELECT INSTRS
       TRA *+2
       TRA AC2       UNIT ADDR OK - PROCEED
       TSX CTX,4     GO TO ADJUST PROGRAM
       HTR ALF2,0,OMG3  MODIFICATION AREA
       TSX CTX,4     GO TO ADJUST PROGRAM
       HTR ALF3,0,OMG4  MODIFICATION AREA
       TSX CTX,4     GO TO ADJUST PROGRAM
       HTR ALF4,0,OMG  MODIFICATION ARE
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR REST-2,0,REST+8 MODIFICATION AREA
       TRA INTL4
       REM
AC2    CLA IOCT      L UNIT COUNT
       TZE PASS2     ALL UNITS CALLED READ
       SUB ONE       L +1
       STO IOCT
       REM
AA2    CLA TRA1+3    L TRA RB
       STO 0         POST RESTART
       REM           TO READ GAP TEST
       REM
*             RESET READ GAP TIMES
       REM
RB     CLA GT4       L +1232
       STO GT1B      RESET INITIAL
       STO GT2B      VALUES IN LOWEST
       STO GT3B      READ GAP TIMES
       REM
       STZ GT1A      RESET INITIAL
       STZ GT2A      VALUES IN HIGHEST
       STZ GT3A      READ GAP TIMES
       REM
       STZ TCP4      RESET TOTAL
       STZ TCP5      GAP TIMES
       STZ TCP6      TO ZERO
       REM
       STZ AV1       RESET AVERAGE
       STZ AV2       READ GAP TIMES
       STZ AV3       TO ZERO
       REM
       STZ GT1C      RESET RANGE
       STZ GT2C      READ GAP TIMES
       STZ GT3C      TO ZERO
       REM
ALF2   STZ REC       RESET RECORD COUNT TO ZERO
       REM
       STZ CRLCK     RESET CREEP LOOP CHECK
       REM
       REM
*             READ TAPE
       REM
R      RTBA 1
       STZ CP1       CLEAR TEMP STORAGE
       STZ CP2       CLEAR TEMP STORAGE
       TSX REST,4    GO RESET INDICATORS
       RCHA CT11
       LCHA CT11
R1     LCHA CT11
       TEFA RDA-3    EOF - GO TO BACKSPACE
       TCNA RDA      EOR - OUT OF PHASE. GO TO
       REM           LOOK FOR NEXT UTILITY GAP
       REM
       CAL CP1       L WORD READ
       LAS K2        TEST FOR -U- WORD
       TRA RDA       SHOULD NEVER ENTER THIS ADR
       TRA R1
       ANA K3+3      MASK TO -A- WORD
       LAS K3+3      TEST FOR -A- WORD
       TRA RDA
       TRA *+2       IT IS AN -A- WORD
       TRA RDA
       RCHA CT12
       NZT CP2       CHECK STG FOR ARRIVAL OF
       REM           WORD FROM TAPE
       TRA *-1       NO WORD - CHECK AGAIN
       TRA RR1-3
       REM
       REM
       REM
       IOT           TURN OFF IOT IND IF ON
       NOP
       TRA SMP       GO TO SUMMARY PRINT
       REM
       REM
*             RECORD OUT OF PHASE SEARCH
       REM
RDA    RTBA 1        ERROR IN READING -U- OR -A-
       RCHA CT11+2   WORD -- SOMETHING OUT OF
       TCOA *        PHASE, FIND UTILITY GAP
       CLA CP1       AND PROCEED FROM THERE
       CAS K2+2      -10- RECORD
       TRA RDA2
       TRA RDA1-3    IS A -10- RECORD
       TRA RDA1-5    ASSUME AN -A- RECORD
RDA2   CAS K2+3      -V- RECORD
       TRA RDA3      ASSUME -O- RECORD
       TRA RDA1-1    IS -V- RECORD
       TRA RDA1-1
       REM
       LXA THREE,1
       TRA RDA1
       REM
       LXA TWO,1
       TRA RDA1
       REM
       LXA ONE,1
RDA1   RTBA 1
       RCHA CT11+2
       TCOA *        DELAY
       TIX RDA1,1,1
RDA3   HTR *+1       TURN SSW 5 UP TO CONTINUE
       REM           TO READ SAME UNIT -- DOWN
       REM           TO GO TO READ NEXT UNIT
       REM
       REM           PRESS START
       SWT 5         CHECK SENSE SWITCH 5
       TRA R         UP - CONTINUE TO READ SAME UNI
       HTR *+1       RAISE SENSE SWITCH 5
       REM
       REM           PRESS START
       REM
       SWT 5         DN - RE-CHECK SENSE SWITCH 5
       TRA *+2       UP - OK, PROCEED
       HTR *-2       DN - ERROR, SSW 5 SHOULD
       REM           BE UP BEFORE GOING TO TEST
       REM           NEXT UNIT
       REM
*             ADJUST FOR PRINT IMAGE 11
       REM
       TSX CLR2,4
       CAL MASK2     L +701400377777
       ANS PR11+20,1
       REM
       REM
*             SET UNIT IN PRINT IMAGE 11
       REM
       TSX UNIT,4
       REM
       CAL RDC
       CLA BIT3      L BIT IN COL 13
       ORS PR11+18,1
       CLA BIT2+1    L BIT IN COL 12
       CLA BIT1      L BIT IN COL 5
       REM
       SWT 3         CHECK SENSE SWITCH 3
       TSX PRT11,2   UP - GO TO PRINT
       TRA TCTX2     DN - BYPASS PRINT
       REM
       REM
       REM
       CLA CP2       L -A- WORD
       STO SS1       SAVE VARIABLE WRITE TIME
       AXT 12,1      L +12 IN XRA
       REM
       REM
*             READ -10- RECORD
       REM
RR1    RTBA 1
       STZ CP2       CLEAR TEMP STORAGE
       CLA ZERO      CLEAR ACCUMULATOR
       RCHA CT12
       NZT CP2       CHECK STG FOR ARRIVAL OF
       REM           WORD FROM TAPE
       TXI *-1,1,2   NO WORD - STEP INDEX COUNT
       SXA TCP1,1    SAVE GAP TIME INDEX COUNT
       PXA 0,1       COMPARE MAX READ GAPE
       CAS GMAX      COMPARE MAX READ GAP
       TRA ERR1      ABOVE MAX
       NOP           INSIDE MAX READ GAP TIME
       CAS GMIN      COMPARE MIN READ GAP
       TRA OK1       INSIDE MIN READ GAP TIME
       TRA OK1       TO COPY CONTINUE
ERR1   SWT 2         TEST SENSE SWITCH 2
       TRA ECA       UP - TO SET ERROR CONTROL
       TRA OK1       DN - IGNORE ERROR
       REM
ECA    CLA ONES      L ALL ONES
       STO EC1       SET ERROR CONTROL
       AXT 15,1      L +17 IN XRA
       TRA RR2
       REM
OK1    STZ EC1       SET NO ERROR CONTROL
       AXT 13,1      L +15 IN XRA
       REM
       REM
*             READ -V- RECORD
       REM
RR2    RTBA 1
       STZ CP2       CLEAR TEMP STORAGE
       CLA ZERO      CLEAR ACCUMULATOR
       RCHA CT12
       NZT CP2       CHECK STG FOR ARRIVAL OF
       REM           WORD FROM TAPE
       TXI *-1,1,2   NO WORD - STEP INDEX COUNT
       SXA TCP2,1    SAVE GAP TIME INDEX COUNT
       PXA 0,1       L GAP TIME INDEX CONUT
       CAS GMAX      COMPARE MAX READ GAP
       TRA ERR2      ABOVE MAX
       NOP           INSIDE MAX READ GAP TIME
       CAS GMIN      COMPARE MIN READ GAP
       TRA OK2       INSIDE MIN READ GAP TIME
       TRA OK2       TO COPY CONTINUE
ERR2   SWT 2         TEST SENSE SWITCH 2
       TRA ECB       UP - TO SET ERROR CONTROL
       TRA OK2       DN - IGNORE ERROR
       REM
ECB    CLA ONES      L ALL ONES
       STO EC2       SET ERROR CONTROL
       AXT 15,1      L +17 IN XRA
       TRA RR3
       REM
OK2    STZ EC2       SET NO ERROR CONTROL
       AXT 13,1      L +15 IN XRA
       REM
*             READ -O- RECORD
       REM
RR3    RTBA 1
       STZ CP2       CLEAR TEMP STORAGE
       CLA ZERO      CLEAR ACCUMULATOR
       RCHA CT12
       NZT CP2       CHECK STG FOR ARRIVAL OF
       REM           WORD FROM TAPE
       TXI *-1,1,2   NO WORD - STEP INDEX COUNT
       SXA TCP3,1    SAVE GAP TIME INDEX COUNT
       PXA 0,1       L GAP TIME INDEX COUNT
       CAS GMAX      COMPARE MAX READ GAP
       TRA ERR3      ABOVE MAX
       NOP           INSIDE MAX READ GAP TIME
       CAS GMIN      COMPARE MIN READ GAP
       TRA OK3       INSIDE MIN READ GAP TIME
       TRA OK3       TO COPY CONTINUE
ERR3   SWT 2         TEST SENSE SWITCH 2
       TRA ECC       UP - TO SET ERROR CONTROL
       TRA OK3       DN - IGNORE ERROR
       REM
ECC    CLA ONES      L ALL ONES
       STO EC3       SET ERROR CONTROL
       REM
       TRA G
       REM
OK3    STZ EC3       SET NO ERROR CONTROL
       TRA *+3       OFF - OK, SKIP BCD WORD
       REM           AND DUMMY INSTRUCTION
       REM
       BCD 1RTBA 1   TEST INSTRUCTION
       RTBA 1        DUMMY INSTRUCTION FOR 9IOM
G      CLA REC       L NUMBER OF RECORD GROUPS
       ADD ONE       STEP BY +1
OMG3   STO REC       SAVE NO OF RECORDS
       REM
*             CHECK FOR REDUNDANCY DURING READ
       REM
       TSX RDNCK,4   CHECK FOR REDUNDANCY
       NOP *-5
       REM
       REM
*             SAVE READ GAP TIMES
       REM
       REM
*             -10- RECORD GAP TIMES
       REM
       CLA TCP1      L CURRENT -10- GAP TIME
       CAS GT1A      HIGH -10- GAP TIME
       TRA GA1
       NOP
       TRA GA2
       REM
GA1    STO GT1A      SAVE HIGHER -10- GAP TIME
GA2    CAS GT1B      LOWEST -10- GAP TIME
       NOP
       TRA GA3
       STO GT1B      SAVE LOWER -10- GAP TIME
GA3    CLA GT1A      L HIGHEST -10- GAP TIME
       SUB GT1B      SUB LOWEST -10- GAP TIME
       STO GT1C      SAVE RANGE -10- GAP TIME
       REM
*             -V- RECORD GAP TIMES
       REM
       CLA TCP2      L CURRENT -V- GAP TIME
       CAS GT2A      HIGH -V- GAP TIME
       TRA GB1
       NOP
       TRA GB2
       REM
GB1    STO GT2A      SAVE HIGHER -V- GAP TIME
GB2    CAS GT2B      LOW -V- GAP TIME
       NOP
       TRA GB3
       STO GT2B      SAVE LOWER -V- GAP TIME
GB3    CLA GT2A      L HIGHEST -V- GAP TIME
       SUB GT2B      SUB LOWEST -V- GAP TIME
       STO GT2C      SAVE RANGE -V- GAP TIME
       REM
*             -O- RECORD GAP TIMES
       REM
       CLA TCP3      L CURRENT -O- GAP TIME
       CAS GT3A      HIGH -O- GAP TIME
       TRA GC1
       NOP
       TRA GC2
       REM
GC1    STO GT3A      SAVE HIGHER -O- GAP TIME
GC2    CAS GT3B      LOW -O- GAP TIME
       NOP
       TRA GC3
       STO GT3B      SAVE LOWER -O- GAP TIME
GC3    CLA GT3A      L HIGHEST -O- GAP TIME
       SUB GT3B      SUB LOWEST -O- GAP TIME
       STO GT3C      SAVE RANGE -O- GAP TIME
       REM
       REM
*             DETERMINE AVERAGE READ GAP TIMES
       REM
       REM
*             AVERAGE -10- GAP TIME
       REM
       CLA TCP1      L CURRENT -10- GAP TIME
       ADD TCP4      ADD TOTAL -10- GAP TIME
       STO TCP4      SAVE NEW TOTAL TIME
       CLM           CLEAR ACC
       LDQ TCP4      L TOTAL TIME IN MQ
       DVP REC       DIV BY NO OF RECORDS
       STQ AV1       SAVE AVERAGE -10- GAP TIME
       REM
*             AVERAGE -V- GAP TIME
       REM
       CLA TCP2      L CURRENT -V- GAP TIME
       ADD TCP5      ADD TOTAL -V- GAP TIME
       STO TCP5      SAVE NEW TOTAL TIME
       CLM           CLEAR ACC
       LDQ TCP5      L TOTAL TIME IN MQ
       DVP REC       DIV BY NO OF RECORDS
       STQ AV2       SAVE AVERAGE -V- GAP TIME
       REM
*             AVERAGE -O- GAP TIME
       REM
       CLA TCP3      L CURRENT -O- GAP TIME
       ADD TCP6      ADD TOTAL -O- GAP TIME
       STO TCP6      SAVE NEW TOTAL TIME
       CLM           CLEAR ACC
       LDQ TCP6      L TOTAL TIME IN MQ
       DVP REC       DIV BY NO OF RECORDS
       STQ AV3       SAVE AVERAGE -O- GAP TIME
       REM
       REM
*             ERROR PRINT OUT CHECK
       REM
ER1    CLA EC1       L -10- ERROR INDICATOR
       TZE ER2       NO ERROR
       REM
       CLA EP1A      L -10- GO DOWN TIME
       STO EP4
       CLA TCP1      L -10- READ GAP TIME
       STO EP5       SAVE
       TSX EPR,2     GO TO CLEAR PRINT IMAGE
       REM
       TSX EPR1,2    GO TO SET CHANNEL AND UNIT
       REM
       STL XRC
       TRA EPR2      GO TO SET GO DOWN TIME
       STL XRC
       TRA EPR3      GO TO SET READ GAP TIME
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       PRINT
       HTR *+2       BYPASS PRINT - CHECK EP4
       REM           FOR -10- GO DOWN TIME AND
       REM           CHECK EP5 FOR -10- READ
       REM           GAP TIME
       TSX PRT6,4    GO TO PRINT
       REM
       REM
ER2    CLA EC2       L -V- ERROR INDICATOR
       TZE ER3       ZERO ON NO ERROR
       REM
*             SET -V- ERROR PRINT
       REM
       REM
*             ASSEMBLE GO DOWN TIME FROM -A-
*                  WORD READ FROM TAPE
       REM
       CLA EG1+1     L +7
       STO EG1
       CLA EG2+1     L +70
       STO EG2
       CLA EG3+1     L +700
       STO EG3
       CLA EG4+1     L +7000
       STO EG4
       REM
       STZ EP2A      CLEAR VARIABLE GO TIME STG
       CLA SS1       L -A- WORD
       ANA K2+5      CLEAR TO GO DOWN TIME
       ARS 6
       ANS EG1       SAVE LAST DIGIT
       ARS 3
       ANS EG2       SAVE THIRD DIGIT
       ARS 3
       ANS EG3       SAVE SECOND DIGIT
       ARS 3
       ANS EG4       SAVE FIRST DIGIT
       REM
       CLA EP2A
       ORA EG1       LOW ORDER DIGIT
       ORA EG2       THIRD DIGIT
       ORA EG3       SECOND DIGIT
       ORA EG4       FIRST DIGIT
       STO EP2A
       REM
       CLM
       LDQ EP2A      L VARIABLE GO DOWN TIME
       MPY FOUR      RESTORE TO MICROSECONDS
       STQ EP2A      SAVE VARIABLE GO DOWN TIME
       DVP TEN       DIVIDE BY 10 DECIMAL
       REM
       STQ EP4       SAVE MILSEC+100S NUMBER
       REM
       CLA TCP2      L READ TIME
       STO EP5
       REM
       TSX EPR,2     GO TO CLEAR  RINT IMAGE
       REM
       TSX EPR1,2    GO TO SET CHANNEL AND UNIT
       REM
       STL XRC
       TRA EPR2      GO TO SET GO DOWN TIME
       REM
       STL XRC
       TRA EPR3      GO TO SET READ GAP TIME
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       PRINT
       HTR *+2       BYPASS PRINT - CHECK EP3
       REM           FOR -10- GO DOWN TIME AND
       REM           FOR -V- GO DOWN TIME
       REM           CHECK EP5 FOR -V- READ
       REM           GAP TIME
       TSX PRT6,4    GO TO PRINT
       REM
       REM
ER3    CLA EC3       L -0- ERROR INDICATOR
       TZE SSW5-2    ZERO ON NO ERROR
       REM
*             SET -O- ERROR PRINT
       REM
       CLA EP3A      L +0 -- GO DOWN TIME
       STO EP4       SAVE
       CLA TCP3      L READ TIME
       STO EP5
       TSX EPR,2     GO TO CLEAR PRINT IMAGE
       REM
       TSX EPR1,2    GO TO SET CHANNEL AND UNIT
       REM
       STL XRC
       TRA EPR2      GO TO SET GO DOWN TIME
       REM
       STL XRC
       TRA EPR3      GO TO SET READ GAP TIME
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       PRINT
       HTR *+2       BYPASS PRINT - CHECK EP4
       REM           FOR -O- GO DOWN TIME
       REM           CHECK EP5 FOR -O- READ
       REM           GAP TIME
       TSX PRT6,4    GO TO PRINT
       REM
       REM
       SLT 3         TEST SENSE LIGHT 3 AND
       NOP           TURN OFF IF ON
       REM
       REM
SSW5   SWT 5         TEST SENSE SWITCH 5
       TRA R         UP - TO CONTINUE READ
       SLN 1         DN - TURN ON SENSE LIGHT 1
       REM           TO SHOW FORCING OF SUMMARY
       REM           PRINT OUT
       REM
       REM
*             GAP SUMMARY PRINT OUT
       REM
SMP    SLT 3         TEST SENSE LIGHT 3
       TRA *+2       OFF - PRINT
       TRA SMP1      ON - BYPASS PRINT
       REM
       REM
*             CLEAR GAP SUMMARY PRINT IMAGES
       REM
*             CLEAR GAP SUMMARY PRINT LINE 1
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 7
       CAL MASK4     L +701400007757
       ANS PR7+20,1  CLEAR LEFT PRINT IMAGE
       REM
       REM
*             CLEAR GAP SUMMARY PRINT LINE 2
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 7A
       CAL MASK4+1   L +0000000000077
       ANS PR7A+21,1 CLEAR RIGHT PRINT IMAGE
       REM
       REM
*             CLEAR GAP SUMMARY PRINT LINE 3
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 7B
       CAL MASK4+1   L +000000000077
       ANS PR7B+21,1 CLEAR RIGHT PRINT IMAGE
       REM
       REM
*             CLEAR GAP SUMMARY PRINT LINE 4
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 7C
       CAL MASK4+1   L +000000000077
       ANS PR7C+21,1 CLEAR RIGHT PRINT IMAGE
       REM
       REM
*             ADJUST FOR PRINT IMAGE 7
       REM
*             SET UNIT AND CHANNEL IN IMAGE
       REM
       TSX UNIT,4
       REM
       CAL R         L CURRENT SELECT
       CLA BIT3      L BIT IN COL 13
       ORS PR7+18,1
       CLA BIT2+1    L BIT IN COL 12
       CLA BIT1      L BIT IN COL 5
       REM
*             SET NUMBER OF RECORDS IN IMAGE
       REM
       TSX SPR,4
       TRA *+9
       REM
       NOP
       NOP
       REM
       AXT 4,2
       CLA REC
       LDQ K11       L 10 FOURTH-1 IN MQ
       DVP K10       DIVIDE BY 10 FOURTH
       CAL BIT5+1,2  L BIT FOR IMAGE
       ORS PR7+18,1
       REM
       REM
*             ADJUST FOR PRINT IMAGE 7A
       REM
*             SET LOW -10- READ GAP TIME
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ GT1B
       STQ GT1B+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA GT1B+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT2+1,2  L BIT FOR IMAGE
       ORS PR7A+19,1
       REM
       REM
*             SET RANGE -10- READ GAP TIME
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ GT1C
       STQ GT1C+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA GT1C+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT4+1,2  L BIT FOR IMAGE
       ORS PR7A+19,1
       REM
       REM
*             SET AVERAGE -10- READ GAP TIME
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ AV1
       STQ AV1+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA AV1+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT6+1,2  L BIT FOR IMAGE
       ORS PR7A+19,1
       REM
       REM
*             ADJUST FOR PRINT IMAGE 7B
       REM
*             SET LOW -V- READ GAP TIME
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ GT2B
       STQ GT2B+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA GT2B+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT2+1,2  L BIT FOR IMAGE
       ORS PR7B+19,1
       REM
       REM
*             SET RANGE -V- READ GAP TIME
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ GT2C
       STQ GT2C+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA GT2C+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT4+1,2  L BIT FOR IMAGE
       ORS PR7B+19,1
       REM
       REM
*             SET AVERAGE -V- READ GAP TIME
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ AV2
       STQ AV2+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA AV2+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT6+1,2  L BIT FOR IMAGE
       ORS PR7B+19,1
       REM
       REM
*             ADJUST FOR PRINT IMAGE 7C
       REM
*             SET LOW -O- READ GAP TIME
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ GT3B
       STQ GT3B+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA GT3B+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT2+1,2  L BIT FOR IMAGE
       ORS PR7C+19,1
       REM
       REM
*             SET RANGE -O- READ GAP TIME
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ GT3C
       STQ GT3C+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA GT3C+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT4+1,2  L BIT FOR IMAGE
       ORS PR7C+19,1
       REM
       REM
*             SET AVERAGE -O- READ GAP TIME
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ AV3
       STQ AV3+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA AV3+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT6+1,2  L BIT FOR IMAGE
       ORS PR7C+19,1
       REM
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       PRINT
       HTR *+2       BYPASS PRINT - HALT TO
       REM           CHECK GAP SUMMARY VALUES
       REM           SEE WRITE-UP FOR LOCATIONS
       REM
       TSX PRT7,2
       REM
       REM
*             CHECK SENSE LIGHT 1 TO SEE IF SUMMARY PRINT
*             OUT WAS FORCED BY SENSE SWITCH 5
       REM
       SLT 1         TEST SENSE LIGTH 1
       TRA *+3       OFF
       SLN 3         ON - TURN ON SENSE LIGHT 3
       REM           AFTER FORCED SUMMARY PRINT
       TRA R         CONTINUE TO READ
       REM
SMP1   SWT 1         CHECK SENSE SWITCH 1
       TRA SMP1A     UP - PROCEED
       TRA SMP2,4    DN - GO TO PRINT UNIT PASS
       REM
       SLN 2         DN - REPEAT GAP TEST ON
       REM           SAME UNIT - TURN ON SL 2
       CLA K20       L INITIAL SELECT
       STA K20A      SAVE
       CLA R         L CURRENT SELECT
       STA K20       SET UNIT IN
       STA K20+5     INITIALIZING ROUTINE
       CLA IOCT      L UNIT COUNT
       STO TEMP      SAVE
       TRA RUC1      TO REPEAT GAP TEST
       REM
       REM
SMP1A  SLT 2         CHECK SENSE LIGHT 2
       TRA *+6       OFF - PROCEED
       CLA K20A      RESET
       STA K20       INITIAL
       STA K20+5     SELECTS
       CLA TEMP      RESET
       STO IOCT      UNIT COUNT
       REM
       REM
*             CHECK BACKSPACE BY MEASURING FROM READ SELECT
*             FOLLOWING A BACKSPACE TO ARRIVAL OF WORD IN STORAGE
       REM
       AXT 2,1       L +2 IN XRA
       STZ TCP12     RESET
       STZ TCP12+1   BKSP-READ
ALF3   STZ TCP12+2   TIMES
       STZ CTR2      RESET COUNTER FOR BKSPS
       BSRA 1        BACKSPACE OVER TAPE MARK
       AXT 6750,1    L +15136 IN XRA
       TIX *,1,1     DELAY FOR 162 DEC MILSEC
       REM
BSRD   CLA TCP12     L CURRENT TIME
       ADD TCP12+1   ADD TOTAL TIME
       STO TCP12+1   SAVE NEW TOTAL TIME
       CLA CTR2
       SUB TCP13     L +62
       TZE BSRD1     BKSP-READ COMPLETE
       STZ CP1       CLEAR READ-IN AREA
       BSRA 1        BACKSPACE OVER LAST RECORD
       AXT 2523,1    L +4733 IN XRA
       TIX *,1,1     DELAY FOR 60 DEC MILSEC
       RTBA 1
       AXT 5,1       L +5 IN XRA
       RCHA CT11+2
       ZET CP1       CHECK STG FOR ARRIVAL
       REM           OF WORD FROM TAPE
       TRA *+3       WORD HAS ARRIVED
       TXH BSRD-3,1,1051 WORD HAS NOT ARRIVED
       REM           IF INDEX COUNT IS EXCEEDED
       REM               AFTER 25 DEC MILSEC
       REM           GO TO BACKSPACE EXTRA TIME
       REM           TO LOOK FOR RECORD
       TXI *-3,1,3   NO WORD - STEP TIME COUNT
       SXA TCP12,1   SAVE CURRENT TIME
       CLA CTR2      L BKSP COUNTER
       ADD ONE       L +1 - STEP COUNTER
       STO CTR2      SAVE NEW COUNT
       TRA BSRD
       REM
BSRD1  CLM           CLEAR ADD
       LDQ TCP12+1   L TOTAL TIME IN MQ
       DVP CTR2      DIVIDE BY NO OF BKSPS
       STQ TCP12+2   SAVE AVERAGE TIME
       REM
       REM
*             CLEAR PRINT IMAGE PR7D
       REM
       TSX CLR2,4    GO TO CLEAR PRINT IMAGE 7D
       CAL MASK7     L 737757010773
       ANS PR7D+20,1
       REM
       TSX CLR2,4
       CAL MASK7+1   L 577335676740
       ANS PR7D+21,1
       REM
       REM
*             ADJUST PRINT IMAGE 7D
       REM
       TSX TSP,4
       TRA *+9
       REM
       LDQ TCP12+2
       STQ TCP12+2
       REM
       AXT 5,2       L +5 IN XRB
       CLA TCP12+2
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT9+1,2  L BIT FOR IMAGE
       ORS PR7D+18,1
       REM
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       UP - PRINT
       TRA *+2       DN - BYPASS PRINT
       REM
       TSX PRT7A,2   GO TO PRINT
       REM
       TSX SMP2,4    GO TO PRINT UNIT PASS
       TSX SMP2B
       REM
SMP2   SXA XRC,4     SAVE XRC RETURN
       SWT 3         CHECK SENSE SWITCH 3
       TRA *+2       UP - PRINT UNIT PASS
       TRA SMP2A-1   DN - BYPASS PRINT
       REM
*             ADJUST FOR PRINT IMAGE 8
       REM
       TSX CLR2,4
       CAL MASK2     L +701400377777
       ANS PR8+20,1
       REM
       REM
       TSX UNIT,4
       REM
       CAL R         L SELECT
       CLA BIT3      L BIT IN COL 13
       ORS PR8+18,1
       CLA BIT2+1    L BIT IN COL 12
       CLA BIT1      L BIT IN COL 5
       REM
       TSX PRT8,2    GO TO PRINT UNIT PASS
       REM
       LXA XRC,4     RESET XRC FOR RETURN
SMP2A  TRA 1,4       RETURN
       REM
       REM
SMP2B  RTBA 1        READ
       RCHA CT20     END OF FILE
       TCOA *        DELAY
       TEFA *+2      END OF FILE -- OK
       WEFA 1        WRITE END OF FILE
       SLF           TURN OF ALL SENSE LIGHTS
OMG4   TRA AA3-12    BEGIN CREEP TEST
       REM
       REM
       REM
       REM
TCTX2  CAL R         L SELECT
       SLW REST-1
       TSX CTX,4     GO TO MODIFY PROGRAM
       PZE ALF2,0,OMG3 MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       PZE ALF3,0,OMG4
       TSX CTX,4     GO TO MODIFY PROGRAM
       PZE ALF4,0,OMG MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR REST-2,0,REST+8
       TRA AC2
       REM
       REM
PASS2  SWT 4         TEST SENSE SWITCH 4
       TRA PASS3     UP - PROCEED
       TRA RUC1      DN - REPEAT GAP TEST
       REM
       REM
       REM
*             CLEAR GAP ERROR PRINT IMAGE
       REM
EPR    TSX CLR2,4    GO TO CLEAR PRINT IMAGE 4
       CAL MASK3     L 701401573600
       ANS PR6+20,1
       REM
       TSX CLR2,4
       CAL MASK3+1   L 360367400740
       ANS PR6+21,1
       TRA 1,2       RETURN
       REM
       REM
*             SET CHANNEL AND UNIT IN GAP
*                  ERROR PRINT IMAGE
       REM
EPR1   TSX UNIT,4
       CAL R         L CURRENT SELECT
       CLA BIT3      L BIT IN COL 13
       ORS PR6+18,1
       CLA BIT2+1    L BIT IN COL 12
       CLA BIT1      L BIT IN COL 5
       TRA 1,2
       REM
       REM
*             SET GO DOWN TIME IN GAP
*                ERROR PRINT IMAGE
       REM
EPR2   TSX SPR,4
       TRA *+9
       REM
       NOP
       NOP
       AXT 5,2       L +5 IN XRA
       CLA EP4       L GO DOWN TIME
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT7+1,2  L BIT FOR IMAGE
       ORS PR6+18,1  INSERT BIT IN IMAGE
       REM
       LAC XRC,4
       TRA 1,4       RETURN
       REM
       REM
*             SET READ GAP TIME IN GAP
       REM
*             ERROR PRINT IMAGE
       REM
EPR3   TSX TSP,4
       TRA *+9
       REM
       LDQ EP5       L READ GAP TIME IN MQ
       STQ EP5
       REM
       AXT 5,2       L +5 IN XRB
       CLA EP5       L READ GAP TIME
       LDQ K11+1
       DVP K10+1
       CAL BIT9+1,2  L BIT FOR IMAGE
       ORS PR6+19,1
       LAC XRC,4
       TRA 1,4       RETURN
       REM
       REM
       REM
************************************************************************
       REM
*             B A C K S P A C E   C R E E P   T E S T                  *
       REM
       REM
       REM
CREEP  CLA TRA1+5    L TRA AC3-5
       STO INTLB
       STO TCTX3+6
       TRA IDN-1
       REM
RUC3   TSX IOCNT,4   TO RESET UNIT COUNT
       REM
INTL5  CLA WRC       ESTABLISH INITIAL
       STO REST-1
       CAS K20       STATUS OF SELECT INSTRS
       TRA *+2
       TRA *+10      UNIT ADDR OK - PROCEED
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF2,0,OMG3  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF3,0,OMG4  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF4,0,OMG  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR REST-2,0,REST+8 MODIFICATION AREA
       TRA INTL5
       NOP
       REM
       CLA NOP       L NOP
       STO INTLB
       CLA TRA1+6    L TRA AC3-1
       STO TCTX3+6
       REM
       SLF           TURN OFF ALL SENSE LIGHTS
       REM
AC3    CLA IOCT      L UNIT COUNT
       TZE PASS3     ALL UNITS CALLED TESTED
       REM
ALF4   SUB ONE       L +1
       STO IOCT
       CLA ONES      LOAD CHECK INDICATOR TO
       STO CRLCK     SHOW LOOPING IN CREEP TEST
       WEFA 1
       TRA AA3
       REM
*            RESET SENSE SWITCHES USED IN
*                INTER-RECORD GAP TEST
       REM
       SWT 1         TEST SENSE SWITCH 1
       TRA *+2       UP - PROCEED
       SLN 1         TURN ON SENSE LIGHT 1
       SWT 4         TEST SENSE SWITCH 4
       TRA *+2       UP - PROCEED
       SLN 1         TURN ON SENSE LIGHT 1
       SWT 5         TEST SENSE SWITCH 5
       TRA *+2       UP - PROCEED
       SLN 1         TURN ON SENSE LIGHT 1
       SLT 1         TEST SENSE LIGHT 1
       TRA *+2       OFF - PROCEED
       HTR *-5       ON - HALT TO ADJUST SENSE
       REM           SWITCHES BEFORE PROCEEDING
       REM
AA3    CLA TRA1+7    L TRA AA3
       STO 0         POST RESTART TO BEGIN
       REM           BACKSPACE CREEP TEST
       REM
       REM
*            ROUTINE FOR VISUAL CHECKING AND ADJUSTMENT OF CREEP
       REM
CRA    SWT 2         TEST SENSE SWITCH 2
       TRA CR1
       REWA 1        REWIND TEST UNIT
       WTBA 1        WRITE 4 ONE WORD
       RCHA CT18     RECORDS FROM FIX
       WEFA 1        WRITE END OF FILE
       BSRA 1        BKSP OVER END OF FILE
CRB    BSRA 1        BSKP OVER 4TH RECORD
       BSRA 1        BKSP OVER 3RD RECORD
       AXT 10,1      L +12 IN XRA
       TIX *,1,1     DELAY
       WTBA 1        REWRITE 3RD RECORD
       RCHA CT18+7
       BSRA 1        BKSP OVER 3RD RECORD
       BSRA 1        BKSP OVER 2ND RECORD
       RTBA 1
       RCHA CT18+5   READ 3 ONE WORD RECORDS
       TCOA *        DELAY
       TEFA *+6      EOF FROM FORWARD CREEP
       BTTA          NO END OF FILE
       TRA *+2       ON - BACKWARD CREEP
       TRA CRB       CONTINUE
       SLN 1         TURN ON SENSE LIGHT 1
       TRA *+1
       SLN 2         TURN ON SENSE LIGHT 2
       SWT 5         CHECK SENSE SWITCH 5
       HTR *+1       UP - HALT TO SHOW CREEP
       REM           SL 1 ON TO SHOW BACKWARD
       REM           SL 2 ON TO SHOW FORWARD
       SLF           TURN OFF ALL SENSE LIGHTS
       TRCA *+1      TURN OFF RDNCY IND IF ON
       SWT 1         CHECK SENSE SWITCH 1
       TRA TCTX3-2   UP - PROCEED TO NEXT UNIT
       TRA CRA+2
       REM
       REM
       TRA *+2
       WEFA 1        WRITE INITIAL END OF FILE
       REM
CR1    STZ TCP7      RESET INITIAL GAP TIME
       STZ TCP8      RESET CURRENT GAP TIME
       STZ TCP8+1    RESET PREVIOUS GAP TIME
       STZ TCP8+2    RESET CURRENT FWD CREEP TIME
       STZ TCP8+3    RESET CURRENT BKWD CREEP
       STZ TCP9      RESET TOTAL GAP TIME
       STZ TCP9+1    RESET TOTAL FWD CREEP TIME
       STZ TCP9+2    RESET TOTAL BKWD CREEP TIME
       STZ TCP9+3    RESET AVG FWD CREEP TIME
       STZ TCP9+4    RESET AVG BKWD CREEP TIME
       STZ TCP10     RESET AVG. CREEP GAP TIME
       STZ CTR       RESET BACKSPACE COUNTER
       STZ CTRF      RESET FWD CREEP COUNTER
       STZ CTRB      RESET BKWD CREEP COUNTER
       STZ EFCK      CLEAR END OF FILE CHECK
       STZ CRCK      CLEAR EXCESS FWD CREEP CHK
       CLA LOC1      L ADDR OF INITIAL GAP TIME
       STA RDC3
       CLA LOC1+2    L ADDR OF PREVIOUS GAP TIME
       STA RDC3+1
       TEFA *+1      TURN OFF EOF IND IF ON
       TRA *+2       SKIP BCD WORD
       REM
       REM
*            WRITE 4 RECORDS
       REM
       REM
*            WRITE 1ST RECORD - 30 WORDS
       REM
       BCD 1WTBA 1   TEST INSTRUCTION
WRC    WTBA 1
       TSX REST,4    GO TO RESET INDICATORS
       RCHA CT13
       TSX RDNCK,4   REDUNDANCY CHECK-1ST REC
       NOP WRC
       REM
*            WRITE 2ND RECORD - 1 WORD
       REM
       WTBA 1
       RCHA CT14
       TSX RDNCK,4   REDUNDANCY CHECK-2ND REC
       NOP WRC
       REM
*            WRITE 3RD RECORD - 1 WORD
       REM
       WTBA 1
       RCHA CT15
       TSX RDNCK,4   REDUNDANCY CHECK-3RD REC
       NOP WRC
       REM
*            WRITE 4TH RECORD - 100 WORDS
       REM
       WTBA 1
       RCHA CT16
       TSX RDNCK,4   REDUNDANCY CHECK-4TH REC
       NOP WRC
       REM
       WEFA 1
       REM
       BSFA 1        BKSP OVER TAPE MARK
       REM
       REM
*            CLEAR READ FIELD
       REM
       AXT 64,1      L +100 IN XRA
       STZ RDFD+64,1 CLEAR
       TIX *-1,1,1   READ FIELD
       REM
       REM
       BSFA 1        BKSP OVER 4 RECORDS
       RTBA 1        READ OVER INITIAL
       RCHA CT20     TAPE MARK
       TCOA *        DELAY
       TEFA RDC      OK
       WEFA 1        LOST PLACE
       HTR CR1       START AGAIN
       REM           IF REPEATED HALTS OCCUR
       REM           HERE, CHECK FOR ABILITY
       REM           TO WRITE OR RECOGNIZE
       REM           END OF FILE
       REM
       REM
*            READ AND CHECK FOUR RECORDS
       REM
       BCD 1RTBA 1   TEST INSTRUCTION
RDC    RTBA 1
       RCHA CT17
       TSX RDNCK,4   READ REDUNDANCY ERROR
       NOP RDC
       REM
       CLA FIVE      L +5
       STO RECNO
       AXT 4,2       L +4 IN XRB
       CLA K4+4      L +31
       STO WDNO
       AXT 24,1      L +30 IN XRA
       REM
       CLA RDFD+24,1 L WORD READ
       LDQ FIX+24,1  L WORD GENERATED IN MQ
       CAS FIX+24,1  COMPARE WORD GNERATED
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4 READ-WRITE ERROR
       NOP RDC
       TIX *-7,1,1
       TIX *+1,2,1
       REM
       CLA TWO       L +2
       STO WDNO
       AXT 1,1       L +1 IN XRA
       REM
       CLA RDFD+27,2 L WORD READ
       LDQ FIX+27,2  L WORD GENERATED IN MQ
       CAS FIX+27,2  COMPARE WORD GENERATED
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4 READ-WRITE ERROR
       NOP RDC
       TIX *-7,2,1
       REM
       REM
CR2    BSFA 1        BKSP OVER TAPE MARK
       RTBA 1        READ OVER INITIAL
       RCHA CT20     TAPE MARK
       TCOA *        DELAY
       TEFA *+3      OK
       WEFA 1        LOST PLACE
       HTR CR1       START AGAIN
       REM
       SLT 2         TEST SENSE LIGHT 2
       TRA *+2       OFF - OK
       TRA CR2A      ON - BACKWARD CREEP FAILURE
       REM           GO TO PRINT
       REM
       REM
       CLA TCP8      L CURRENT GAP TIME
       STO TCP8+1    SAVE AS PREVIOUS GAP TIME
       CLA CTR       L NO OF BACKSPACE OPNS
       SWT 1         TEST SENSE SWITCH 1
       TRA *+3       UP - SHORT BKSP COUNT
       SUB CTR+2     DN - LONG BKSP COUNT-L 201
       TRA *+2
       SUB CTR+1     L 31
       TMI RDC1      BKSP COUNT INCOMPLETE
       REM
CR2A   SLT 1         TEST SENSE LIGHT 1
       TRA SMP3      OFF - GO TO SUMMARY PRINT
       TRA CR4       ON - GO TO PASS PRINT
       REM
       REM
*             MEASURE GAP BETWEEN 2ND AND 3RD RECORDS
       REM
RDC1   RTBA 1
       STZ CP1       CLEAR TEMP STORAGE
       TSX REST,4    GO TO RESET INDICATORS
       RCHA CT11+4
       LCHA CT11+4
RDC2   AXT 0,1       L +0 IN XRA
       LCHA CT11+4
       TCNA *+4      END OF RECORD - ERROR
       TEFA *+3      END OF FILE - ERROR
       CAL CP1       L WORD READ
       LAS FIX+22    COMPARE 23RD WORD-1ST REC
       TRA RDC2A     OUT OF STEP - TRY AGAIN
       TRA *+2       OK-23RD WORD - 1ST REC
       TRA RDC2+1    NOT LAST WORD - CONTINUE
       LCHA CT11+2
       STZ CP1       CLEAR TEMP STORAGE
       NZT CP1       CHECK STG FOR ARRIVAL OF
       REM           WORD FROM TAPE
       TRA *-1       NO WORD - CHECK
       CAL CP1       L WORD READ
       LAS FIX+24    COMPARE 2ND RECORD
       TRA *+2       ERROR - BEGIN AGAIN
       TXI RDC2B,1,9 IT IS SECOND RECORD
RDC2A  WEFA 1        ERROR - BEGIN AGAIN
       HTR *+1       ADJUST SENSE SWITCH 5
       SWT 5         CHECK SENSE SWITCH 5
       HTR CR1       UP - TRY AGAIN
       HTR *+1       ADJUST SENSE SWITCH 5
       SWT 5         DN - RE-CHECK SENSE SWITCH
       TRA *+2       UP - OK, PROCEED
       HTR *-2       DN - ERROR, SSW 5 SHOULD
       REM           BE UP BEFORE GOING TO TEST
       REM           NEXT UNIT
       REM
*             ADJUST FOR PRINT IMAGE 12
       REM
       TSX CLR2,4
       REM
       CAL MASK2     L +7014003777777
       ANS PR12+20,1
       REM
*             SET UNIT IN PRINT IMAGE 12
       REM
       TSX UNIT,4
       REM
       CAL RDC
       CLA BIT3      L BIT IN COL 13
       ORS PR12+18,1
       CLA BIT2+1    L BIT IN COL 12
       CLA BIT1      L BIT IN COL 5
       REM
       REM
       SWT 3         CHECK SENSE SWITCH 3
       TSX PRT12,2   UP - GO TO PRINT
       TRA TCTX3-3   DN - BYPASS PRINT AND GO TO
       REM           TEST NEXT UNIT
       REM
       REM
RDC2B  RTBA 1
       CLA ZERO      CLEAR ACCUMULATOR
       STZ CP2       CLEAR TEMP STORAGE
       RCHA CT12
       NZT CP2       CHECK STG FOR ARRIVAL OF
       REM           THIRD RECORD FROM TAPE
       TXI *-1,1,2   NO WORD - STEP INDEX COUNT
RDC3   SXA **,1      SAVE INITIAL GAP-1ST READ
       SXA **,1      SAVE PREVIOUS GAP - 1ST READ
       SXA TCP8,1    SAVE CURRENT GAP TIME
       SLF           TURN OFF ALL SENSE LIGHTS
       REM
       REM
*             CHECK FOR BACKWARD CREEP FAILURE
       REM
       PXA 0,1       L CURRENT GAP TIME IN ACC
       CAS GMIN      COMPARE MIN READ GAP
       TRA *+3       OVER MIN - OK
       TRA *+2       EQUALS MIN - OK
       REM
       SLN 2         BELOW MIN GAP TIME - TURN
       REM           ON SENSE LIGHT 2 TO SHOW
       REM           FAILURE WITH BACKWARD CREEP
       REM
       CLA LOC1+1    L ADDR OF CURRENT GAP TIME
       STA RDC3
       STA RDC3+1
       REM
       CLA CTR       STEP
       ADD ONE       BACKSPACE
       STO CTR       COUNTER
       REM
       REM
*             ADJUST AVERAGE CREEP TIMES
       REM
       CLA TCP8      L CURRENT GAP
       SUB TCP8+1    SUBTRACT PREVIOUS TIME
       TPL *+15      PLUS ON FWD CREEP
       CLA TCP8+1    L PREVIOUS GAP TIME
       SUB TCP8      SUBTRACT CURRENT GAP
       SLW TCP8+3    SAVE NEW BKWD CREEP TIME
       CLA TCP8+3    L BKWD CREEP TIME
       ADD TCP9+2    ADD TOTAL BKWD CREEP TIME
       STO TCP9+2    SAVE NEW TOTAL TIME
       REM
       CLA CTRB      STEP
       ADD ONE       BKWD CREEP
       STO CTRB      COUNTER
       REM
       CLM           CLEAR ACCUMULATOR
       LDQ TCP9+2    L TOTAL BKWD CREEP IN MQ
       DVP CTRB      OBTAIN AVERAGE
       STQ TCP9+4    SAVE AVG BKWD CREEP TIME
       TRA *+11
       REM
       STO TCP8+2    SAVE CURRENT FWD CREEP
       ADD TCP9+1    ADD TOTAL FWD CREEP TIME
       STO TCP9+1    SAVE NEW TOTAL FWD CREEP
       REM
       CLA CTRF      STEP
       ADD ONE       FWD CREEP
       STO CTRF      COUNTER
       REM
       CLM           CLEAR ACCUMULATOR
       LDQ TCP9+1    L TOTAL FWD CREEP TIME
       DVP CTRF      OBTAIN AVERAGE
       STQ TCP9+3    SAVE AVG FWD CREEP TIME
       REM
       CLA TCP9      L TOTAL GAP TIME
       ADD TCP8      ADD CURRENT TIME
       STO TCP9      SAVE NEW TOTAL TIME
       CLM           CLEAR ACC
       LDQ TCP9      L TOTAL TIME IN MQ
       DVP CTR       DIVIDE BY NO OF BACKSPACES
       STQ TCP11     SAVE AVERAGE GAP TIME
       REM
       REM
*             CHECK FOR BACKWARD CREEP
       REM
       CLA TCP11     L AVERAGE GAP TIME
       CAS TCP7      COMPARE INITIAL TIME
       TRA *+6       AVG GAP LONGER -- FWD CREEP
       TRA *+5       AVG GAP SAME -- OK
       SLN 3         AVG GAP SHORTER -- TURN
       REM           ON SENSE LIGHT 3 TO SHOW
       REM           BACKWARD CREEP
       REM
       CLA TCP9+4    L AVG BKWD CREEP TIME
       STO TCP10     SAVE FOR PRINT
       TRA *+8       GO TO BACKSPACE
       REM
       REM
*             CHECK FOR EXCESSIVE FORWARD CREEP
       REM
       CLA TCP9+3    L AVG FWD CREEP TIME
       STO TCP10     SAVE FOR PRINT
       CAS TCP10+2   COMPARE MAX AVG CREEP
       TRA *+3       AVG GAP LONGER - EXCESSIVE
       TRA *+3       AVG GAP SAME - OK
       TRA *+2       AVG GAP SHORTER - OK
       SLN 4         TURN ON SENSE LIGHT 4 TO
       REM           SHOW EXCESSIVE FWD CREEP
       REM
       BSRA 1        BACKSPACE OVER 3RD REC
       AXT 10,1      L +12 IN XRA
       TIX *,1,1     DELAY
       WTBA 1        REWRITE
       RCHA CT15     THIRD RECORD
       REM
       STZ EFCK      RESET EOF CHECK
       TEFA *+1      TURN OFF EOF IND IF ON
       REM
       RTBA 1
       RCHA CT11+2
       BSFA 1        BKSP OVER 4 RECORDS
       TCOA *        DELAY
       REM
       REM
*             CHECK FOR END OF FILE
       REM
       TEFA *+2      CREEP TEST CAN NOT CONTINUE
       REM           TO READ -- GO TO PRINT
       TRA *+4       PROCEED
       REM
       REM
*             SET END OF FILE CHECK INDICATOR
       REM
OMG    CLA ONES      L ALL ONES
       STO EFCK
       TRA CR2A      GO TO CREEP PRINT
       REM
       REM
       SWT 5         TEST SENSE SWITCH 5
       TRA CR2+1     UP - CONTINUE BKSP-WRITE
       SLN 1         DN - TURN ON SENSE LIGHT 1
       REM           TO SHOW FORCING PRINT
       REM
*             BACKSPACE CREEP SUMMARY PRINT OUT
       REM
*             CLEAR PRINT IMAGE 9
       REM
SMP3   TSX CLR2,4
       CAL MASK2     L +701400377777
       ANS PR9+20,1
       REM
       TSX CLR2,4
       CAL MASK5     L +777577400000
       ANS PR9+21,1
       REM
       CAL MASK8     L 777774000000
       ANS PR9+21    CLEAR ZONES
       ANS PR9+23    COLS 20-36
       REM
       REM
*             CLEAR PRINT IMAGE 9A
       REM
       TSX CLR2,4
       CAL MASK6     L+177341077036
       ANS PR9A+20,1
       REM
       TSX CLR2,4
       CAL MASK6+1   L +001741077000
       ANS PR9A+21,1
       AXT 24,1      L +30 IN XRA
       CAL MASK8+2   L 777777777776
       ANS PR9A+24,1
       TIX *-1,1,2
       AXT 24,1      L +30 IN XRA
       CAL MASK8+1   L 577777777777
       ANS PR9A+25,1
       TIX *-1,1,2
       REM
       REM
*             ADJUST FOR PRINT IMAGE 9
       REM
       TSX UNIT,4
       REM
       CAL RDC       L SELECT
       CLA BIT3      L BIT IN COL 13
       ORS PR9+18,1
       CLA BIT2+1    L BIT IN COL 12
       CLA BIT1      L BIT IN COL 5
       REM
       REM
*             SET NUMBER OF BACKSPACE-WRITE
*              OPERATIONS IN PRINT IMAGE 9
       REM
       TSX SPR,4
       TRA *+9
       REM
       NOP
       NOP
       REM
       AXT 3,2       L +3 IN XRB
       CLA CTR
       LDQ K11+2     L 10 THIRD-1 IN MQ
       DVP K10+2     DIVIDE BY 10 THIRD
       CAL BIT8-1,2  L BIT FOR IMAGE
       ORS PR9+18,1
       REM
       REM
*             SET FAILURE IN PRINT IMAGE 9
       REM
       SLT 2         TEST SENSE LIGHT 2
       TRA CR3       OFF - NO GAP FAILURE
       SLN 2         ON - RESET SENSE LIGHT 2
       REM           ON TO SHOW GAP FAILURE
       CLA BIT6      L BIT IN COL 29
       ARS 1         SHIFT BIT
       ORS PR9+23
       ORS PR9+7
       ARS 1         SHIFT BIT
       ORS PR9+23
       ORS PR9+17
       ARS 1         SHIFT BIT
       ORS PR9+23
       ORS PR9+1
       ARS 1         SHIFT BIT
       ORS PR9+21
       ORS PR9+13
       ARS 1         SHIFT BIT
       ORS PR9+19
       ORS PR9+11
       ARS 1         SHIFT BIT
       ORS PR9+21
       ORS PR9+1
       ARS 1         SHIFT BIT
       ORS PR9+23
       ORS PR9+9
       REM
       REM
CR3    SLT 3         TEST SENSE LIGHT 3
       TRA FWD       OFF - FORWARD CREEP
       SLN 3         ON - RESET SENSE LIGHT 3
       REM           ON TO SHOW BACKWARD CREEP
       REM
*             SET BACKWARD IN PRINT IMAGE 9A
       REM
       CLA ONE       L BIT IN COL 36
       ORS PR9A+22
       ORS PR9A+14
       CLA BIT1+2    L BIT IN COL 7
       ORS PR9A+23
       ORS PR9A+11
       ALS 1         SHIFT BIT
       ORS PR9A+21
       ORS PR9A+1
       ALS 1         SHIFT BIT
       ORS PR9A+23
       ORS PR9A+17
       ALS 1         SHIFT BIT
       ORS PR9A+19
       ORS PR9A+7
       ALS 1         SHIFT BIT
       ORS PR9A+21
       ORS PR9A+15
       ALS 1         SHIFT BIT
       ORS PR9A+23
       ORS PR9A+13
       ALS 1         SHIFT BIT
       ORS PR9A+23
       ORS PR9A+17
       TRA SMP4
       REM
       REM
*             SET FORWARD IN PRINT IMAGE 9A
       REM
FWD    CLA BIT1+2    L BIT IN COL 7
       ORS PR9A+23
       ORS PR9A+11
       ALS 1         SHIFT BIT
       ORS PR9A+21
       ORS PR9A+1
       ALS 1         SHIFT BIT
       ORS PR9A+23
       ORS PR9A+17
       ALS 1         SHIFT BIT
       ORS PR9A+19
       ORS PR9A+7
       ALS 1         SHIFT BIT
       ORS PR9A+21
       ORS PR9A+1
       ALS 1         SHIFT BIT
       ORS PR9A+21
       ORS PR9A+7
       ALS 1         SHIFT BIT
       ORS PR9A+23
       ORS PR9A+7
       REM
       REM
       SLT 4         TEST SENSE LIGHT 4
       TRA *+3       OFF - OK INTO IMAGE
       SLN 4         ON - RESET SENSE LIGHT 4 ON
       REM           TO SHOW EXCESSIVE FWD CREEP
       TRA SMP4
       REM
       NZT EFCK      CHECK IF EOF READ
       TRA *+2       NO END OF FILE - INSERT OK
       TRA SMP4
       REM
       REM
*             SET OK IN PRINT IMAGE 9
       REM
       CLA BIT9      L BIT IN COL 26
       ORS PR9+7
       ORS PR9+21
       ARS 1         SHIFT BIT TO COL 27
       ORS PR9+15
       ORS PR9+21
       REM
       REM
*             ADJUST FOR PRINT IMAGE 9A
       REM
*             SET INITIAL GAP TIME IN PR 9A
       REM
SMP4   TSX TSP,4
       TRA *+9
       REM
       LDQ TCP7
       STQ TCP7+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA TCP7+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT4+1,2  L BIT FOR IMAGE
       ORS PR9A+18,1 INSERT BIT IN IMAGE
       REM
       REM
*             SET AVERAGE CREEP IN PR 9A
       REM
       TSX TSP,4
       TRA *+9
       LDQ TCP10
       STQ TCP10+1
       REM
       AXT 5,2       L +5 IN XRB
       CLA TCP10+1
       LDQ K11+1     L 10 FIFTH-1 IN MQ
       DVP K10+1     DIVIDE BY 10 FIFTH
       CAL BIT4+1,2  L BIT FOR IMAGE
       ORS PR9A+19,1 INSERT BIT IN IMAGE
       REM
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       UP - GO TO PRINT
       HTR *+2       DN - BYPASS PRINT -- HALT
       REM           TO CHECK CREEP TEST RESULTS
       REM
       TSX PRT9,2    GO TO PRINT CREEP TEST
       REM           SUMMARY PRINT OUT
       REM
       REM
       SLT 1         TEST SENSE LIGHT 1
       TRA CR4       OFF - PRINT NOT FORCED
       SLN 1         ON - RESET SENSE LIGHT 1
       REM           ON TO SHOW PRINT OUT FORCED
       SLT 2         TEST SENSE LIGHT 2
       TRA CR2+1     OFF - CONTINUE BKSP TEST
       REM           ON - BACKWARD CREEP ERROR
       REM           GO TO READ NEXT UNIT
       REM
       REM
*             ADJUST FOR PRINT IMAGE 10
       REM
CR4    TSX CLR2,4
       CAL MASK2     L +701400377777
       ANS PR10+20,1
       REM
       REM
*             SET UNIT IN PRINT IMAGE 10
       REM
       TSX UNIT,4
       CAL RDC
       CLA BIT3      L BIT IN COL 13
       ORS PR10+18,1
       CLA BIT2+1    L BIT IN COL 12
       CLA BIT1      L BIT IN COL 5
       REM
       REM
       SWT 3         TEST SENSE SWITCH 3
       TSX PRT10,2   UP - GO TO PRINT
       REM           DN - BYPASS PRINT
       SWT 4         TEST SENSE SWITCH 4
       TRA *+2       UP - PROCEED TO NEXT UNIT
       TRA CR1-1     DN -- REPEAT BKSP-CREEP
       REM           TEST ON SAME UNIT
       XEC CRA+2     REWIND TEST UNIT
       REM
       NZT CRLCK     TEST LOOP CHECK INDICATOR
       TRA TCTX2     ZERO - PROCEED TO GAP
       REM           TEST ON NEXT UNIT
       REM
       REM
TCTX3  CAL RDC       L SELECT
       STO REST-1
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF2,0,OMG3  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF3,0,OMG4  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR ALF4,0,OMG  MODIFICATION AREA
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR REST-2,0,REST+8 MODIFICATION AREA
       TRA AC3
       REM
       REM
PASS3  SWT 4          TEST SENSE SWITCH 4
       TRA FINL       UP - PROCEED
       HTR *+1        DN - HALT TO SET SSW 4
       REM
       SWT 4          TEST SENSE SWITCH 4
       TRA FINL       UP - PROCEED
       TRA RUC3       DN - REPEAT CREEP TEST
       REM            ON ALL UNITS CALLED
       REM
FINL   SWT 3
       TSX PRTFN,4    UP - GO TO PRINT
       SWT 6          DN - BYPASS PRINT AND
       REM            TEST SENSE SWITCH 6
       TRA *+2        UP - PROCEED TO NEXT
       REM            DIAGNOSTIC TEST
       TRA IDN+1      DN - REPEAT ENTIRE 9T05
FINL1  OCT **         SELECT
       RCHA FINLX     READ IN
       LCHA 0         NEXT
       TRA 1          PROGRAM
       REM
FINLX  IOCT 0,0,3
       REM
************************************************************************
       REM
*                   U T I L I T Y   R O U T I N E S                    *
       REM
       REM
       REM
       OCT **         SELECT INSTRUCTION
REST   BTTA
       NOP
       ETTA
       NOP
       IOT
       NOP
       TRCA *+1
       REM
       TEFA *+1
       TRA 1,4
       REM
       REM
       REM
       REM
CLR2   AXT 20,1      L +24 IN XRA
       XEC 1,4
       XEC 2,4
       TIX *-1,1,2
       TRA 3,4
       REM
       REM
*            CONVERT MICROSEC TO MILSEC
       REM
TSP    XEC 2,4       L BINARY NO - INDEX COUNT
       MPY K4+1      MULTIPLY BY 24 DECIMAL
       DVP TEN       DIVIDE BY 10 DECIMAL
TSP1   XEC 3,4       SAVE MILSEC+100S NUMBER
       REM
       REM
*            SET DECIMAL DIGITS IN PRINT IMAGE
       REM
SPR    SXA XRB,2     SAVE XRB
       XEC 4,4       L NO OF DIGITS IN XRB
SPR1   XEC 5,4       L TIME IN ACC
       XEC 6,4       L 10 TO X POWER-1 IN MQ
       XEC 7,4       DIVIDE BY 10 TO X PWR
SPR2   MPY TEN       MULTIPLY BY 10 DECIMAL
       ALS 1         DOUBLE INCREMENT
       PAX 0,1
SPR3   XEC 8,4       L ONE BIT
SPR4   XEC 9,4       SET BIT IN PRINT IMAGE
       CLM
       TIX SPR2,2,1
       REM
       LXA XRB,2     RESET XRB
SPR5   TRA 1,4       RETURN
       REM
       REM
*            SET CHANNEL AND UNIT IN PASS PRINT IMAGE
       REM
UNIT   XEC 1,4       L SELECT INSTRUCTION
       STO TEMP
       ANA K1        L +17
       PAI           L IND FROM ACC
       RNT 00012     CHECK FOR UNIT 10
       TRA UNIT2     NO UNIT 10
       AXT 0,1       L +0 IN XRA
       XEC 2,4       L LOW BIT
       XEC 3,4       INSERT BIT
       REM
       AXT 2,1       L +2 IN XRA
       XEC 4,4       L HIGH BIT
       XEC 3,4       INSERT BIT
       TRA UNIT3
       REM
UNIT2  CAL TEMP
       ANA K1        L +17
       ALS 1         DOUBLE INCREMENT
       PAX 0,1
       XEC 2,4       L LOW BIT
       XEC 3,4       INSERT BIT
       REM
       AXT 0,1       L +0 IN XRA
       XEC 4,4       L HIGH BIT
       XEC 3,4       INSERT BIT
       REM
UNIT3  CAL TEMP
       ANA K1+1      L +7000
       ARS 8         MOVE TO LOW ORDER + DOUBLE
       PAX 0,1
       XEC 5,4       L CHANNEL BIT
       XEC 3,4       INSERT BIT
       REM
       TRA 6,4       RETURN
       REM
       REM
*            ADJUST UTILITY PRINT ROUTINES FOR DESIRED CHANNEL
       REM
ADJ    CLA CTRL1     SAVE
       STO XRA       CONTROL
       CLA CTRL2     WORDS
       STO XRB       FOR
       CLA CTRL3     ALL
       STO XRC       CHANNELS
       REM
       TSX IOC,4     ENTER CONTROL WORD FOR
       REM           PRINTER ON DESIRED CHANNEL
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR CH14-1,0,CH14+2
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR WPRA-1,0,WPRA+6
       TSX CTX,4     GO TO MODIFY PROGRAM
       HTR PRID-1,PRTFN+3
       NOP
       NOP
       REM
       CLA XRA       RESET
       STO CTRL1     CONTROL
       CLA XRB       WORDS
       STO CTRL2     FOR
       CLA XRC       ALL
       STO CTRL3     CHANNELS
       REM
       TRA RUC       CONTINUE PROGRAM
       REM
*  PRINT --
* NOW PERFORMING DIAGNOSTIC TEST 9T05
       REM
PRID   WPRA          PRINT OUT TEST IDENTITY
       SPRA 3        DOUBLE SPACE
       RCHA CTIDN
       TRA 1,4       RETURN
       REM
       REM
*  PRINT --
*MAX TIME FROM WR SEL TO RESET LD CHN AT LD PT        .   MILSEC
       REM
PRT1   WPRA
       SPRA 3        DOUBLE SPACE
       RCHA CT1A
       TRA 7,2       RETURN
       REM
       REM
*  PRINT --
*MAX TIME FROM RD SEL TO RESET LD CHN AT LD PT        .   MILSEC
       REM
PRT2   WPRA
       RCHA CT2A
       TRA 25,2      RETURN
       REM
       REM
*  PRINT --
*MAX TIME FROM WR SEL TO REEST LD CHN NOT AT LD PT    .   MILSEC
       REM
PRT3   WPRA
       RCHA CT3A
       TRA 7,2       RETURN
       REM
       REM
*  PRINT --
*MAX TIME FROM RD SEL TO RESET LD CHN NO AT LD PT     .   MILSEC
       REM
PRT4   WPRA
       RCHA CT4A
       TRA 25,2      RETURN
       REM
       REM
*  PRINT --
*CHN +   TF         LD CHN TIMING TEST COMPLETE
       REM
PRT5   WPRA
       SPRA 3        DOUBLE SPACE
       RCHA CT5
       WPRA          SPACE
       TCOA *        PRINTER
       TRA 1,2       RETURN
       REM
       REM
*  PRINT --
*CHN +   TF    -  GO LINE DOWN    .   MSEC  -  READ TIME     .   MSEC
       REM
PRT6   WPRA
       RCHA CT6A
       TRA 1,4       RETURN
       REM
*  PRINT --
*CHN +   TF     --       RECORDS READ       LOW     RANGE     AVERAGE
*GO LINE DOWN 10 MILSEC                      .        .      .   MILSE
*GO LINE DOWN VARIABLE TIME                  .        .      .   MILSE
*GO LINE DOWN ZERO TIME                      .        .      .   MILSE
       REM
PRT7   WPRA
       SPRA 3        DOUBLE SPACE
       RCHA CT7A
       WPRA
       RCHA CT7A+2
       TRA 1,2       RETURN
       REM
       REM
*  PRINT --
* 50 BKSP-READ OPNS   .  MILSEC AVG BETWEEN RD SEL AND FIRST WORD
       REM
PRT7A  WPRA
       RCHA CT19
       TRA 1,2       RETURN
       REM
       REM
*  PRINT --
*CHN +   TF         GAP TEST COMPLETE
       REM
PRT8   WPRA
       SPRA 3        DOUBLE SPACE
       RCHA CT8A     RETURN
       TRA 1,2       RETURN
       REM
       REM
*  PRINT --
*CHN +   TF          BACKSPACE-WRITE OPERATIONS COMPLETE
*  INITIAL GAP    .   MILSEC    AVG.        CREEP    .    MILSEC
       REM
PRT9   WPRA
       SPRA 3        DOUBLE SPACE
       RCHA CT9A
       WPRA
       RCHA CT9A+2
       TRA 1,2       RETURN
       REM
       REM
*  PRINT --
*CHN +   TF         CREEP TEST COMPLETE
       REM
PRT10  WPRA
       SPRA 3        DOUBLE SPACE
       RCHA CT10A
       WPRA          SPACE
       TCOA *        PRINTER
       TRA 1,2       RETURN
       REM
       REM
*  PRINT --
*CHN +   TF        UNABLE TO PERFORM INTER-RECORD GAP TEST
       REM
PRT11  WPRA
       SPRA 3        DOUBLE SPACE
       RCHA CT11A
       TRA 1,2       RETURN
       REM
       REM
*  PRINT --
*CHN +   TF       UNABLE TO PERFORM BACKSPACE-WRITE CREEP TEST
       REM
PRT12  WPRA
       SPRA 3        DOUBLE SPACE
       RCHA CT12A
       TRA 1,2       RETURN
       REM
       REM
*  PRINT --
*9T05    PASS COMPLETE   ALL UNITS
       REM
PRTFN  WPRA 1
       SPRA 3        DOUBLE SPACE
       RCHA CTFN
       TRA 1,4       RETURN
       REM
       REM
************************************************************************
       REM
*                       C O N S T A N T S                              *
       REM
       REM
ONES   OCT -37777777777
ZERO   OCT 0
ONE    OCT +1
TWO    OCT +2
THREE  OCT +3
FOUR   OCT +4
FIVE   OCT +5
SIX    OCT +6
SEVEN  OCT +7
EIGHT  OCT +10
NINE   OCT +11
TEN    OCT +12
       REM
       REM
TYMK   OCT +2342     NORMINAL DELAY FOR WRITE
       REM           AT LOAD POINT - INDEX COUNT
       REM           EQUALING 30 DEC MILSEC
       OCT **        CURRENT DELAY - INDEX COUNT
       OCT **        CURRENT DELAY - MILSEC+100S
       REM
TYMK1  OCT +1161     NORMINAL DELAY FOR READ
       REM           AT LOAD POINT - INDEX COUNT
       REM           EQUALING 15 DEC MILSEC
       OCT **        CURRENT DELAY - INDEX COUNT
       OCT **        CURRENT DELAY - MILSEC+100S
       REM
TYMK2  OCT +247      NORMINAL DELAY FOR WRITE NOT
       REM           AT LOAD POINT - INDEX COUNT
       REM           EQUALING 4 DEC MILSEC
       OCT **        CURRENT DELAY - INDEX COUNT
       OCT **        CURRENT DELAY - MILSEC+100S
       REM
TYMK3  OCT +51       NORMINAL DELAY FOR READ NOT
       REM           AT LOAD POINT - INDEX COUNT
       REM           EQUALING 1 DEC MILSEC
       OCT **        CURRENT DELAY - INDEX COUNT
       OCT **        CURRENT DELAY - MILSEC+100S
       REM
       REM
TYMK4  OCT +50
       ADD ONE
       TRA TYMB
       ADD TYMK4
       TRA TYMA+2
       TRA TYM1B
       TRA TYM1A+2
       TRA TYM2B
       TRA TYM2A+2
       TRA TYM3B
       ADD  EIGHT
       TRA TYM3A+2
       ADD K+1
       REM
TRA1   TRA TYM-13
       TRA AC1-5
       TRA AA1
       TRA RB
       TRA AC1-1
       TRA AC3-5
       TRA AC3-1
TRA2   TRA TCTX
       TRA TCTX1
       TRA TCTX3
       REM
TRA3   TRA INTLA
       TRA AC
       TRA INTLA-3
       TRA INTL2
       REM
NOP    NOP
       REM
K      OCT **        INDEX VARIABLE DELAY
       OCT 751       INDEX MIN VARIABLE DELAY
       REM           .98 MILSEC
       OCT 1         INDEX DELAY STEP
       OCT 1222      INDEX MAX VARIABLE DELAY
       REM           5.01 MILSEC
       OCT 1067      INDEX COUNT FOR 10 MILSEC
       REM           DELAY PLUS 3.61 MILSEC TO
       REM           GO DOWN TIME
       OCT **        WRITE VARIABLE DELAY
       OCT 1724      OCT COUNT OF MICROSEC
       REM           EQUAL TO .98 MILSEC
       OCT 30        WRITE DELAY STEP
       REM
K1     OCT +17
       OCT +7000
       REM
       REM
K2     OCT 555550505050 -U- WORD
       OCT 545050505077 -A- WORD
       OCT 535350505050 -10- RECORD
       OCT 525250505050 -V- RECORD
       OCT 505050505050 -O- RECORD
       OCT 000707070707 GO TIME MASK
       REM
K3     OCT **        PRINT FORM VARIABLE DELAY
       OCT 000070707600 ADJUSTED DELAY STEP
       OCT 070707070700
       OCT 545050505077 -A- WORD MASK
       OCT 000003060500  ADJUST MINIMUM
       REM               VARIABLE DELAY
       REM
K4     OCT 000027000110 +27 AND +110
       OCT 000000000030 +30
       OCT 000020000616 +20 AND +616
       OCT 000000000041 +41
       OCT 000000000031 +31
       REM
K10    OCT 000000023420 10 FOURTH
       OCT 000000303240 10 FIFTH
       OCT 000000001750 10 THIRD
       REM
K11    OCT 000000023417 10 FOURTH -1
       OCT 000000303237 10 FIFTH-1
       OCT 000000001747 10 THIRD-1
       REM
K20    OCT **        TEMP STOR - WRITE TAPE
       WTBA 1
       WTBA 2
       RTBA 1
       RCDA
       RTBA **       TEMP STOR - READ TAPE
       REM
K20A   OCT **        TEMP STOR - INITIAL SELECT
K21    LDI CTRL1     LD INDS WITH CHN A CONTROL
       REM
TEMP   OCT **        TEMPORARY STORAGE
       REM
XRA    OCT **        TEMPORARY STORAGE
XRB    OCT **        TEMPORARY STORAGE
XRC    OCT **        TEMPORARY STORAGE
       REM
       REM
MASK1  OCT 377540437400
       REM
MASK2  OCT 701400377777
       OCT 577400000000
       REM
MASK3  OCT 701411573604
       OCT 362367410740
       REM
MASK4  OCT 701400007757
       OCT 001001001077
       REM
MASK5  OCT 777577400000
       REM
MASK6  OCT 177341077036
       OCT 001741077000
       REM
MASK7  OCT 737757010773
       OCT 577335676740
       REM
MASK8  OCT 777777400000
       OCT 577777777777
       OCT 777777777776
       REM
CTIDN  IOCD PRIDN,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT1    IOCD FIX,0,32
       HTR 0         PROGRAM PROTECT - I-O DISC
CT1A   IOCD PR1,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT2    IOCD RDFD,0,32
       HTR 0         PROGRAM PROTECT - I-O DISC
CT2A   IOCD PR2,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT3    IOCD FIX+32,0,32
       HTR 0         PROGRAM PROTECT - I-O DISC
CT3A   IOCD PR3,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT4    IOCD RDFD+32,0,32
       HTR 0         PROGRAM PROTECT - I-O DISC
CT4A   IOCD PR4,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT5    IOCD PR5,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT6    IOCT K2,0,1   INITIAL -U- WORD
       HTR 0         PROGRAM PROTECT - I-O DISC
CT6A   IOCD PR6,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT7    IOCD K2+1,0,1 CONTROL FOR -A- WORD
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCT K2+1,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
CT7A   IOCD PR7,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD PR7A,0,72
       HTR 0         PROGRAM PROTECT - I-O DISC
CT8    IOCD K2+2,0,1 CONTROL FOR -10- WORD
       HTR 0         PROGRAM PROTECT - I-O DISC
CT8A   IOCD PR8,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT9    IOCD K2+3,0,1 CONTROL FOR -V- WORD
       HTR 0         PROGRAM PROTECT - I-O DISC
CT9A   IOCD PR9,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD PR9A,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT10   IOCD K2+4,0,1 CONTROL FOR -O- WORD
       HTR 0         PROGRAM PROTECT - I-O DISC
CT10A  IOCD PR10,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT11   IOST CP1,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD CP1,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCT CP1,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
CT11A  IOCD PR11,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT12   IOCD CP2,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
CT12A  IOCD PR12,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT13   IOCD FIX,0,24 FIRST RECORD OF CREEP TEST
       HTR 0         PROGRAM PROTECT - I-O DISC
CT14   IOCD FIX+24,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
CT15   IOCD FIX+25,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
CT16   IOCP FIX+26,0,37
       IOCD FIX,0,27
       HTR 0         PROGRAM PROTECT - I-O DISC
CT17   IOCD RDFD,0,27
       HTR 0         PROGRAM PROTECT - I-O DISC
CT18   IOCP FIX,0,1
       IOCP FIX+1,0,1
       IOCP FIX+2,0,1
       IOCD FIX+3,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD RDFD,0,3
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD FIX+2,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
CT19   IOCD PR7D,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT20   IOCD TEMP,0,1
       HTR 0         PROGRAM PROTECT - I-O DISC
CTFN   IOCD PRFN,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
       REM
       REM
       REM
BIT1   OCT 020000000000 ONE BIT IN COL 5
       REM
       OCT 010000000000 ONE BIT IN COL 6
       OCT 004000000000 ONE BIT IN COL 7
       OCT 002000000000 ONE BIT IN COL 8
       OCT 000400000000 ONE BIT IN COL 10
BIT2   OCT 000200000000 ONE BIT IN COL 11
       OCT 000100000000 ONE BIT IN COL 12
BIT3   OCT 000040000000 ONE BIT IN COL 13
       REM
       OCT 000010000000 ONE BIT IN COL 15
       OCT 000004000000 ONE BIT IN COL 16
       OCT 000002000000 ONE BIT IN COL 17
       OCT 000000400000 ONE BIT IN COL 19
BIT4   OCT 000000200000 ONE BIT IN COL 20
       OCT 000000100000 ONE BIT IN COL 21
       OCT 000000040000 ONE BIT IN COL 22
BIT5   OCT 000000020000 ONE BIT IN COL 23
       REM
       OCT 000000010000 ONE BIT IN COL 24
       OCT 000000004000 ONE BIT IN COL 25
       OCT 000000002000 ONE BIT IN COL 26
       OCT 000000000400 ONE BIT IN COL 28
BIT6   OCT 000000000200 ONE BIT IN COL 29
       REM
       OCT 000000000040 ONE BIT IN COL 31
       OCT 000000000020 ONE BIT IN COL 32
       OCT 000000000010 ONE BIT IN COL 33
       OCT 000000000002 ONE BIT IN COL 35
BIT7   OCT 000000000001 ONE BIT IN COL 36
       REM
       OCT 000004000000 ONE BIT IN COL 16
       OCT 000002000000 ONE BIT IN COL 17
       OCT 000001000000 ONE BIT IN COL 18
       OCT 000000200000 ONE BIT IN COL 20
BIT8   OCT 000000100000 ONE BIT IN COL 21
       OCT 000000040000 ONE BIT IN COL 22
       OCT 000000020000 ONE BIT IN COL 23
       OCT 000000004000 ONE BIT IN COL 25
BIT9   OCT 000000002000 ONE BIT IN COL 26
       REM
*             GAP TEST TIME DATA
       REM
TCP1   OCT **        CURRENT -10- GAP TIME
TCP2   OCT **        CURRENT -V- GAP TIME
TCP3   OCT **        CURRENT -O- GAP TIME
TCP4   OCT **        TOTAL -10- GAP TIME
TCP5   OCT **        TOTAL -V- GAP TIME
TCP6   OCT **        TOTAL -O- GAP TIME
       REM
CP1    OCT **        TEMP STORAGE - WORD READ
CP2    OCT **        TEMP STORAGE - WORD READ
       REM
SS1    OCT **        CURRENT -A- WORD
       REM
GMAX   OCT +1010     INDEX COUNT - MAX READ TIME
       REM           FOR +2.5 MILSEC GAP TOL
       REM           +.1875 INCH GAP TOL
GMIN   OCT +542      INDEX COUNT - MIN READ TIME
       REM           FOR -1.5 MILSEC GAP TOL
       REM           -.1125 INCH GAP TOL
       REM
       REM           +640 IN GMAX AND GMIN
       REM           FOR NO TOL ON READ GAP TO
       REM           PRINT ALL VARIATIONS FROM
       REM           .75 INCH GAP -- 10 MILSEC
       REM
REC    OCT **        NUMBER OF GAP RECORD GROUPS
       REM
*             READ GAP TIME DATA
       REM
GT1A   OCT **        HIGHEST -10- GAP TIME
GT1B   OCT **        LOWEST -10- GAP TIME
       OCT **        TEMP STOR FOR PRINT IMAGE
GT1C   OCT **        RANGE -10- GAP TIME
       OCT **        TEMP STOR FOR PRINT IMAGE
GT2A   OCT **        HIGHEST -V- GAP TIME
GT2B   OCT **        LOWEST -V- GAP TIME
       OCT **        TEMP STOR FOR RPINT IMAGE
GT2C   OCT **        RANGE -V- GAP TIME
       OCT **        TEMP STOR FOR PRINT IMAGE
GT3A   OCT **        HIGHEST -O- GAP TIME
GT3B   OCT **        LOWEST -O- GAP TIME
       OCT **        TEMP STOR FOR PRINT IMAGE
GT3C   OCT **        RANGE -O- GAP TIME
       OCT **        TEMP STOR FOR PRINT IMAGE
GT4    OCT +1232     RESTORE LOWEST GAP TIMES
       REM
AV1    OCT **        AVERAGE -10- GAP TIME
       OCT **        TEMP STOR FOR PRINT IMAGE
AV2    OCT **        AVERAGE -V- GAP TIME
       OCT **        TEMP STOR FOR PRINT IMAGE
AV3    OCT **        AVERAGE -O- GAP TIME
       OCT **        TEMP STOR FOR PRINT IMAGE
       REM
       REM
*             GAP ERROR PRINT DATA
       REM
EC1    OCT **        -10- ERROR CHECK INDICATOR
EC2    OCT **        -V- ERROR CHECK INDICATOR
EC3    OCT **        -O- ERROR CHECK INDICATOR
       REM
EP1A   OCT +1750     MILSEC GO DOWN -10-
EP2A   OCT **        MILSEC GO DOWN -V-
EP3A   OCT 0000000000000 MILSEC GO DOWN -O-
EP4    OCT **        CURRENT GO DOWN TIME
EP5    OCT **        CURRENT READ GAP TIME
*             GAP SUMMARY PRINT DATA
       REM
EG1    OCT **
       OCT 0000000000007
EG2    OCT **
       OCT 0000000000070
EG3    OCT **
       OCT 0000000000700
EG4    OCT **
       OCT 0000000007000
       REM
       REM
       REM
*             CREEP TEST TIME DATA
       REM
TCP7   OCT **        INITIAL GAP TIME
       OCT **        MILSEC+100S
TCP8   OCT **        CURRENT GAP TIME
       OCT **        PREVIOUS GAP TIME
       OCT **        CURRENT FWD CREEP TIME
       OCT **        CURRENT BKWD CREEP TIME
TCP9   OCT **        TOTAL GAP TIME
       OCT **        TOTAL FWD CREEP TIME
       OCT **        TOTAL BKWD CREEP TIME
       OCT **        AVG FWD CREEP TIME
       OCT **        AVG BKWD CREEP TIME
TCP10  OCT **        AVERAGE CREEP TIME
       OCT **        MILSEC+100S
       OCT +70       COMPARISON FOR AVG CREEP
       REM           FOR MAXIMUM FWD CREEP
       REM           --1.34 DEC MILSEC OR .1 INCH
TCP11  OCT **        AVERAGE GAP TIME
       REM
TCP12  OCT **        CURRENT BKSP-READ TIME
       OCT **        TOTAL BKSP-READ TIME
       OCT **        AVERAGE BKSP-READ TIME
       REM
TCP13  OCT +62
       REM
LOC1   HTR TCP7      LOC OF INITIAL GAP
       HTR TCP8      LOC OF CURRENT GAP
       HTR TCP8+1    LOC OF PREVIOUS GAP
       REM
CTR    OCT **        CREEP TEST BKSP COUNTER
       OCT 31        +31
       OCT 201       +201
CTR2   OCT **        COUNTER FOR BACKSPACE-READ
CTRF   OCT **        COUNTER FOR FWD CREEP
CTRB   OCT **        COUNTER FOR BKWD CREEP
       REM
EFCK   OCT **        END OF FILE CHECK INDICATOR
CRCK   OCT **        EXCESS FWD CREEP CHECK IND
CRLCK  OCT **        CREEP TEST LOOP CHECK IND
       REM
FIX    OCT 010101010101
       OCT 020202020202
       OCT 030303030303
       OCT 040404040404
       OCT 050505050505
       OCT 060606060606
       OCT 070707070707
       OCT 101010101010
       REM
       OCT 111111111111
       OCT 121212121212
       OCT 131313131313
       OCT 141414141414
       OCT 151515151515
       OCT 161616161616
       OCT 171717171717
       OCT 202020202020
       REM
       OCT 212121212121
       OCT 222222222222
       OCT 232323232323
       OCT 242424242424
       OCT 252525252525
       OCT 262626262626
       OCT 272727272727
       OCT 303030303030
       REM
       OCT 313131313131
       OCT 323232323232
       OCT 333333333333
       OCT 343434343434
       OCT 353535353535
       OCT 363636363636
       OCT 373737373737
       OCT 404040404040
       REM
       OCT 414141414141
       OCT 424242424242
       OCT 434343434343
       OCT 444444444444
       OCT 454545454545
       OCT 464646464646
       OCT 474747474747
       OCT 505050505050
       REM
       OCT 515151515151
       OCT 525252525252
       OCT 535353535353
       OCT 545454545454
       OCT 555555555555
       OCT 565656565656
       OCT 575757575757
       OCT 606060606060
       REM
       OCT 616161616161
       OCT 626262626262
       OCT 636363636363
       OCT 646464646464
       OCT 656565656565
       OCT 666666666666
       OCT 676767676767
       OCT 707070707070
       REM
       OCT 717171717171
       OCT 727272727272
       OCT 737373737373
       OCT 747474747474
       OCT 757575757575
       OCT 767676767676
       OCT 777777777777
       OCT 010101010100
       REM
       OCT 000000000000
       REM
       REM
RDFD   BSS 64
       REM
       REM
*  IMAGE --
* NOW PERFORMING DIAGNOSTIC TEST 9T05
       REM
PRIDN  OCT 002241004010  9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000000000000  8 L
       OCT 000000000000  8 R
       OCT 010010200000  7 L
       OCT 000000000000  7 R
       OCT 141400040000  6 L
       OCT 000000000000  6 R
       OCT 204020100201  5 L
       OCT 000000000000  5 R
       OCT 000102000000  4 L
       OCT 000000000000  4 R
       OCT 000000012444  3 L
       OCT 000000000000  3 R
       OCT 000000020100  2 L
       OCT 000000000000  2 R
       OCT 000000400000  1 L
       OCT 000000000000  1 R
       OCT 040000030546  0 L
       OCT 000000000000  0 R
       OCT 312720140000  11 L
       OCT 000000000000  11 R
       OCT 005053606200  12 L
       OCT 000000000000  12 R
       REM
       REM
*  IMAGE --
*MAX TIME FROM WR SEL TO RESET LD CHN AT LD PT     .   MILSEC
       REM
PR1    OCT 010204004000  9 ROW LEFT
       OCT 000000010000  9 ROW RIGHT
       OCT 000000000002  8 L
       OCT 000000400000  8 R
       OCT 100000000000  7 L
       OCT 002000000000  7 R
       OCT 000510020000  6 L
       OCT 000000000000  6 R
       OCT 002000402401  5 L
       OCT 000000001000  5 R
       OCT 404040000020  4 L
       OCT 010000020000  4 R
       OCT 020000240244  3 L
       OCT 121000404400  3 R
       OCT 000001001000  2 L
       OCT 000000002000  2 R
       OCT 200000000000  1 L
       OCT 200000000000  1 R
       OCT 120011041200  0 L
       OCT 101000002000  0 R
       OCT 404344224041  11 L
       OCT 022000024000  11 R
       OCT 212400402426  12 L
       OCT 210000411400  12 R
       REM
       REM
*  IMAGE --
*MAX TIME FROM RD SEL TO RESET LD CHN AT LD PT     .   MILSEC
       REM
PR2    OCT 010210004000  9 ROW LEFT
       OCT 000000010000  9 ROW RIGHT
       OCT 000000000002  8 L
       OCT 000000400000  8 R
       OCT 100000000000  7 L
       OCT 002000000000  7 R
       OCT 000500020000  6 L
       OCT 000000000000  6 R
       OCT 002000402401  5 L
       OCT 000000001000  5 R
       OCT 404044000020  4 L
       OCT 010000020000  4 R
       OCT 020000240244  3 L
       OCT 121000404400  3 R
       OCT 000001001000  2 L
       OCT 000000002000  2 R
       OCT 200000000000  1 L
       OCT 200000000000  1 R
       OCT 120001041200  0 L
       OCT 101000002000  0 R
       OCT 404350224041  11 L
       OCT 022000024000  11 R
       OCT 212404402426  12 L
       OCT 210000411400  12 R
       REM
       REM
*  IMAGE --
*MAX TIME FROM WR SEL TO RESET LD CHN NOT AT LD PT    .   MILSEC
       REM
PR3    OCT 010204004000   9 ROW LEFT
       OCT 000000010000   9 ROW RIGHT
       OCT 000000000002   8 L
       OCT 000000400000   8 R
       OCT 100000000000   7 L
       OCT 000100000000   7 R
       OCT 000510020000   6 L
       OCT 100000000000   6 R
       OCT 002000402401   5 L
       OCT 200000001000   5 R
       OCT 404040000020   4 L
       OCT 000400020000   4 R
       OCT 020000240244   3 L
       OCT 045040404400   3 R
       OCT 000001001000   2 L
       OCT 000000002000   2 R
       OCT 200000000000   1 L
       OCT 010000000000   1 R
       OCT 120011041200   10 L
       OCT 044040002000   10 R
       OCT 404344224041   11 L
       OCT 301100024000   11 R
       OCT 212400402426   12 L
       OCT 010400411400   12 R
       REM
       REM
*  IMAGE --
*MAX TIME FROM RD SEL TO RESET LD CHN NOT AT LD PT      .   MILSEC
       REM
PR4    OCT 010210004000   9 ROW LEFT
       OCT 000000010000   9 ROW RIGHT
       OCT 000000000002   8 L
       OCT 000000400000   8 R
       OCT 100000000000   7 L
       OCT 000100000000   7 R
       OCT 000500020000   6 L
       OCT 100000000000   6 R
       OCT 002000402401   5 L
       OCT 200000001000   5 R
       OCT 404044000020   4 L
       OCT 000400020000   4 R
       OCT 020000240244   3 L
       OCT 045040404400   3 R
       OCT 000001001000   2 L
       OCT 000000002000   2 R
       OCT 200000000000   1 L
       OCT 010000000000   1 R
       OCT 120001041200   0 L
       OCT 044040002000   0 R
       OCT 404350224041   11 L
       OCT 301100024000   11 R
       OCT 212404402426   12 L
       OCT 010400411400   12 R
       REM
       REM
       REM
*  IMAGE --
*CHN +   TF         LD CHN TIMING TEST COMPLETE
       REM
PR5    OCT 000000000500   9 ROW LEFT
       OCT 000000000000   9 ROW RIGHT
       OCT 200000010000   8 L
       OCT 000000000000   8 R
       OCT 000000000020   7 L
       OCT 010000000000   7 R
       OCT 000400000000   6 L
       OCT 040000000000   6 R
       OCT 100000004042   5 L
       OCT 002400000000   5 R
       OCT 000000100200   4 L
       OCT 020000000000   4 R
       OCT 401000221004   3 L
       OCT 505000000000   3 R
       OCT 000000000001   2 L
       OCT 000000000000   2 R
       OCT 000000000000   1 L
       OCT 000000000000   1 R
       OCT 001000001005   0 L
       OCT 401000000000   0 R
       OCT 100000204240   11 L
       OCT 074000000000   11 R
       OCT 620400130522   12 L
       OCT 102400000000   12 R
       REM
       REM
*  IMAGE --
*CHN +   TF    -  GO LINE DOWN   .   MSEC  -  READ TIME   .  MSEC
       REM
PR6    OCT 000000040000    9 ROW LEFT
       OCT 000202000000    9 ROW RIGHT
       OCT 200000000004    8 L
       OCT 000000010000    8 R
       OCT 000001000000    7 L
       OCT 000000000000    7 R
       OCT 000400401400    6 L
       OCT 000000000000    6 R
       OCT 100000030200    5 L
       OCT 040100400100    5 R
       OCT 000000002000    4 L
       OCT 200021000400    4 R
       OCT 401000100004    3 L
       OCT 020004010040    3 R
       OCT 000000000000    2 L
       OCT 100000000200    2 R
       OCT 000000000000    1 L
       OCT 000040000000    1 R
       OCT 001000000400    0 L
       OCT 100004000200    0 R
       OCT 100010521200    11 L
       OCT 202201000400    11 R
       OCT 620401052004    12 L
       OCT 060162410140    12 R
       REM
       REM
*  IMAGE --
*CHN +   TF     --     RECORDS READ      LOW    RANGE     AVERAGE
       REM
PR7    OCT 000000004210    9 ROW LEFT
       OCT 000004000040    9 ROW RIGHT
       OCT 200000000000    8 L
       OCT 000000000000    8 R
       OCT 000000000000    7 L
       OCT 000000400010    7 R
       OCT 000400000400    6 L
       OCT 001400000000    6 R
       OCT 100000002004    5 L
       OCT 000001200304    5 R
       OCT 000000000101    4 L
       OCT 000000000000    4 R
       OCT 401000001000    3 L
       OCT 002000000000    3 R
       OCT 000000000040    2 L
       OCT 000000000000    2 R
       OCT 000000000002    1 L
       OCT 000002000420    1 R
       OCT 001000000040    0 L
       OCT 000400000200    0 R
       OCT 100006004610    11 L
       OCT 003005000040    11 R
       OCT 620400003107    12 L
       OCT 000002600534    12 R
       REM
       REM
*  IMAGE --
*GO LINE DOWN 10 MILSEC            .       .       .    MILSE
       REM
PR7A   OCT 020001000000    9 ROW LEFT
       OCT 000000000020    9 ROW RIGHT
       OCT 000000000000    8 L
       OCT 001001001000    8 R
       OCT 400000000000    7 L
       OCT 000000000000    7 R
       OCT 200600000000    6 L
       OCT 000000000000    6 R
       OCT 014100100000    5 L
       OCT 000000000002    5 R
       OCT 001002000000    4 L
       OCT 000000000040    4 R
       OCT 040000440000    3 L
       OCT 001001001011    3 R
       OCT 000000200000    2 L
       OCT 000000000004    2 R
       OCT 000020000000    1 L
       OCT 000000000000    1 R
       OCT 000210200000    0 L
       OCT 000000000004    0 R
       OCT 250502400000    11 L
       OCT 000000000050    11 R
       OCT 425001140000    12 L
       OCT 001001001023    12 R
       REM
       REM
*  IMAGE --
*GO LINE DOWN VARIABLE TIME         .      .     .   MILSE
       REM
PR7B   OCT 020006010000    9 ROW LEFT
       OCT 000000000020    9 ROW RIGHT
       OCT 000000000000    8 L
       OCT 001001001000    8 R
       OCT 400000000000    7 L
       OCT 000000000000    7 R
       OCT 200600000000    6 L
       OCT 000000000000    6 R
       OCT 014120102000    5 L
       OCT 000000000002    5 R
       OCT 001000004000    4 L
       OCT 000000000040    4 R
       OCT 040000220000    3 L
       OCT 001001001011    3 R
       OCT 000000400000    2 L
       OCT 000000000004    2 R
       OCT 000011000000    1 L
       OCT 000000000000    1 R
       OCT 000220020000    0 L
       OCT 000000000004    0 R
       OCT 250504204000    11 L
       OCT 000000000050    11 R
       OCT 425013512000    12 L
       OCT 001001001023    12 R
       REM
       REM
*  IMAGE --
*GO LINE DOWN ZERO TIME           .       .      .   MILSE
       REM
PR7C   OCT 020024200000    9 ROW LEFT
       OCT 000000000020    9 ROW RIGHT
       OCT 000000000000    8 L
       OCT 001001001000    8 R
       OCT 400000000000    7 L
       OCT 000000000000    7 R
       OCT 200602000000    6 L
       OCT 000000000000    6 R
       OCT 014110040000    5 L
       OCT 000000000002    5 R
       OCT 001000100000    4 L
       OCT 000000000040    4 R
       OCT 040000400000    3 L
       OCT 001001001011    3 R
       OCT 000000000000    2 L
       OCT 000000000004    2 R
       OCT 000000000000    1 L
       OCT 000000000000    1 R
       OCT 000220400000    0 L
       OCT 000000000004    0 R
       OCT 250506100000    11 L
       OCT 000000000050    11 R
       OCT 425010240000    12 L
       OCT 001001001023    12 R
       REM
       REM
*  IMAGE --
* 50 BKSP-READ OPNS    .   MILSEC AVG BETWEEN RD SEL AND FIRST WORD
       REM
PR7D   OCT 000400000200     9 ROW LEFT
       OCT 000200030100     9 ROW RIGHT
       OCT 000000010000     8 L
       OCT 000000000000     8 R
       OCT 002004000000     7 L
       OCT 400000000000     7 R
       OCT 000010000000     6 L
       OCT 010000040600     6 R
       OCT 200202000021     5 L
       OCT 047010400000     5 R
       OCT 000040000400     4 L
       OCT 000100200040     4 R
       OCT 000000010110     3 L
       OCT 020004002000     3 R
       OCT 034001000040     2 L
       OCT 100020004000     2 R
       OCT 000100000002     1 L
       OCT 000001000000     1 R
       OCT 104001000041     0 L
       OCT 030020006400     0 R
       OCT 013416000500     11 L
       OCT 001204410300     11 R
       OCT 020340010232     12 L
       OCT 546111260040     12 R
       REM
       REM
*  IMAGE --
*CHN +   TF       GAP TEST COMPLETE
       REM
PR8    OCT 000000000000    9 ROW LEFT
       OCT 000000000000    9 ROW RIGHT
       OCT 200000000000    8 L
       OCT 000000000000    8 R
       OCT 000000240020    7 L
       OCT 000000000000    7 R
       OCT 000400000100    6 L
       OCT 000000000000    6 R
       OCT 100000004005    5 L
       OCT 000000000000    5 R
       OCT 000000000040    4 L
       OCT 000000000000    4 R
       OCT 401000011212    3 L
       OCT 000000000000    3 R
       OCT 000000002000    2 L
       OCT 000000000000    2 R
       OCT 000000100000    1 L
       OCT 000000000000    1 R
       OCT 001000013002    0 L
       OCT 000000000000    0 R
       OCT 100000040170    11 L
       OCT 000000000000    11 R
       OCT 620400304205    12 L
       OCT 000000000000    12 R
       REM
       REM
*  IMAGE --
*CHN +    TF        BACKSPACE-WRITE OPERATIONS COMPLETE
       REM
PR9    OCT 000000000030    9 ROW LEFT
       OCT 044000000000    9 ROW RIGHT
       OCT 200000000000    8 L
       OCT 000000000000    8 R
       OCT 000000002000    7 L
       OCT 200010000000    7 R
       OCT 000400000040    6 L
       OCT 402040000000    6 R
       OCT 100000000202    5 L
       OCT 101002400000    5 R
       OCT 000000000000    4 L
       OCT 000020000000    4 R
       OCT 401000020404    3 L
       OCT 010105000000    3 R
       OCT 000000114000    2 L
       OCT 000400000000    2 R
       OCT 000000041000    1 L
       OCT 020000000000    1 R
       OCT 001000004044    0 L
       OCT 010401000000    0 R
       OCT 100000012120    11 L
       OCT 643074000000    11 R
       OCT 620400161612    12 L
       OCT 124102400000    12 R
       REM
       REM
*  IMAGE --
*   INITIAL GAP     .   MILSEC   AVG.       CREEP      .  MILSEC
       REM
PR9A   OCT 124000020000    9 ROW LEFT
       OCT 000400020000    9 ROW RIGHT
       OCT 000001000002    8 L
       OCT 000001000000    8 R
       OCT 000240000004    7 L
       OCT 000040000000    7 R
       OCT 000000000000    6 L
       OCT 000000000000    6 R
       OCT 040000002010    5 L
       OCT 000300002000    5 R
       OCT 000000040000    4 L
       OCT 000000040000    4 R
       OCT 011001011002    3 L
       OCT 001001011000    3 R
       OCT 000000004000    2 L
       OCT 000000004000    2 R
       OCT 002100000020    1 L
       OCT 000000000000    1 R
       OCT 010000004010    0 L
       OCT 000000004000    0 R
       OCT 041040050000    11 L
       OCT 000440050000    11 R
       OCT 126301023026    12 L
       OCT 001301023000    12 R
       REM
       REM
*  IMAGE --
*CHN +   TF       CREEP TEST COMPLETE
       REM
PR10   OCT 000000100000    9 ROW LEFT
       OCT 000000000000    9 ROW RIGHT
       OCT 200000000000    8 L
       OCT 000000000000    8 R
       OCT 000000010004    7 L
       OCT 000000000000    7 R
       OCT 000400000020     6 L
       OCT 000000000000    6 R
       OCT 100000061001     5 L
       OCT 200000000000    5 R
       OCT 000000000010    4 L
       OCT 000000000000    4 R
       OCT 401000202242    3 L
       OCT 400000000000    3 R
       OCT 000000000400    2 L
       OCT 000000000000    2 R
       OCT 000000000000    1 L
       OCT 000000000000    1 R
       OCT 001000002600    0 L
       OCT 400000000000    0 R
       OCT 100000110036    11 L
       OCT 000000000000    11 R
       OCT 620400261041    12 L
       OCT 200000000000    12 R
       REM
       REM
*  IMAGE --
*CHN +   TF           UNABLE TO PERFORM INTER-RECORD GAP TEST
       REM
PR11   OCT 000000000022   9 ROW LEFT
       OCT 212100000000   9 ROW RIGHT
       OCT 200000000000   8 L
       OCT 000000000000   8 R
       OCT 000000000100   7 L
       OCT 000012000000   7 R
       OCT 000400000414   6 L
       OCT 000200000000   6 R
       OCT 100000104040   5 L
       OCT 121000200000   5 R
       OCT 000000200001   4 L
       OCT 000040000000   4 R
       OCT 401000011000   3 L
       OCT 040400440000   3 R
       OCT 000000020000   2 L
       OCT 000000100000   2 R
       OCT 000000040000   1 L
       OCT 000004000000   1 R
       OCT 001000201000   0 L
       OCT 040000540000   0 R
       OCT 100000110527   11 L
       OCT 116302000000   11 R
       OCT 620400064050   12 L
       OCT 221454200000   12 R
       REM
*  IMAGE --
*CHN +   TF           UNABLE TO PERFORM BACKSPACE-WRITE CREEP TEST
       REM
PR12   OCT 000000000022   9 ROW LEFT
       OCT 000060400000   9 ROW RIGHT
       OCT 200000000000   8 L
       OCT 000000000000   8 R
       OCT 000000000100   7 L
       OCT 004000040000   7 R
       OCT 000400000414   6 L
       OCT 000100000000   6 R
       OCT 100000104040   5 L
       OCT 000404304000   5 R
       OCT 000000200001   4 L
       OCT 000000000000   4 R
       OCT 401000011000   3 L
       OCT 041011011000   3 R
       OCT 000000020000   2 L
       OCT 230000002000   2 R
       OCT 000000040000   1 L
       OCT 102000000000   1 R
       OCT 001000201000   0 L
       OCT 010110013000   0 R
       OCT 100000110527   11 L
       OCT 024240440000   11 R
       OCT 620400064050   12 L
       OCT 343425304000   12 R
       REM
*  IMAGE --
*9T05    PASS COMPLETE   ALL UNITS
       REM
PRFN   OCT 400000000020   9 ROW LEFT
       OCT 000000000000   9 ROW RIGHT
       OCT 000000000000   8 L
       OCT 000000000000   8 R
       OCT 001002000000   7 L
       OCT 000000000000   7 R
       OCT 000010000000   6 L
       OCT 000000000000   6 R
       OCT 040000500040   5 L
       OCT 000000000000   5 R
       OCT 000004000100   4 L
       OCT 000000000000   4 R
       OCT 200021201410   3 L
       OCT 000000000000   3 R
       OCT 000300000004   2 L
       OCT 000000000000   2 R
       OCT 000400002000   1 L
       OCT 000000000000   1 R
       OCT 300300200114   0 L
       OCT 000000000000   0 R
       OCT 001017001440   11 L
       OCT 000000000000   11 R
       OCT 000420502020   12 L
       OCT 000000000000   12 R
       REM
       REM
*      EQUIVALENT ADDRESSES
       REM
ERROR  EQU 3396
OK     EQU 3401
RDNCK  EQU 3440
WDNO   EQU 3438
RECNO  EQU 3439
       REM
CH14   EQU 3632
WPRA   EQU 3841
       REM
CTRL1  EQU 2880
CTRL2  EQU 2881
CTRL3  EQU 2882
IOCT   EQU 2883
CTX    EQU 2890
IOCNT  EQU 2891
IOC    EQU 2892
       REM
       REM
       END
