                                                            9 T 0 4 A
                                                            7-01-58
       REM
       REM
       REM
*                            9 T 0 4 A
       REM
*               729 TAPE FRAME INTERCHANGEABILITY TEST
       REM
       REM
       ORG 24
       NOP
AA     SWT 3
       TRA *+2        TO PRINT OUT IDENTITY
       TRA *+2        BYPASS PRINT
IDN    TSX PRID,4     GO TO PRINT TEST IDENTITY
       REM
       TSX IOC,4      ENTER ON KEY IN THE USUAL
       REM            MANNER, I-O CONTROL WORDS
       REM            CALLING FOR 1 TAPE FRAME
       REM            ON EACH CHN DESIRED TO
       REM            BE TESTED
RUC    TSX IOCNT,4    GO TO RESET UNIT COUNT
       REM
INTL   CLA CTRL1
       TPL *+4        CHECK IF PROGRAM READ
       REM            FROM CARDS
       CLA WTBA1      YES - L WTBA 1
       STO WTB
       TRA *+5
       CLA WTBA2      NOT READ FROM CARDS -
       STO WTB        SET WTBA 2
       CLA RTB        L RTBA 1
       STO FINL1
       REM
       CLA CTRA       CHECK FOR CHN A UNIT
       TZE TCTX       NO UNIT -
       CLA B21+1      L WTB CURRENT UNIT
       CAS WTB
       TRA *+2
       TRA *+4
       TSX CTX,4
       HTR B19-1,0,PASS+1 MODIFCATION AREA
       TRA *-6
       REM
       CLA *+4        L TRA B19
       STO 0          POST RESTART FOR WRITE
       REM
       SWT 6
       HTR *-1
       TRA B19
       REM
*             SENSE SWITCH 6 MUST BE DOWN TO CHECK MULTIPLE FRAMES.  AS
*             LONG AS SENSE SWITCH 6 IS DOWN THE PROGRAM WILL HALT AFTER
*             EACH FRAME IS READ AND CHECKED TO PERMIT CHANGING FRAMES.
*             PRESS START TO CONTINUE.  AS LAST FRAME IS CHECKED SENSE
*             SWITCH 6 MAY BE RAISED TO CALL IN THE NEXT PROGRAM.
       REM
*             WRITE 400 RANDOM BINARY RECORDS
       REM
B19    REWA 1
       LXA K3+4,1     L10
       CAL K10+8,1    INITIALIZE RANDOM
       SLW K11+8,1    GENERATOR
       TIX  *-2,1,1
       TRA B20
       REM
       BCD 1WTBA 1
B20    LXA K2,2       L NO OF RECORDS IN XRB
       REM
       LXA K2,2       L +400
       CLA K2         L NUMBER OF RECORDS
       ADD ONE        L +1
       STO RECNO
B21A   TRCA *+1       TURN REDUNDANCY TAPE
       REM            CHECK OFF
       IOT            TURN INPUT-OUTPUT CHECK
       TRA *+1        LIGHT OFF
       REM
B21    TSX GEN1,4     TO GENERATE RANDOM
       REM            BINARY RECORDS
       REM
       WTBA 1         WRITE RANDOM BINARY
       REM            RECORDS
       TRCA *+1       TURN OFF TRC IND IF ON
       RCHA CT10      TRANSFER REC TO TAPE
       REM
       REM            DELAY BEFORE DISCONNECT
       TCNA B23       UNIT SHOULD NOT BE IN
       REM            OPERATION
       TCOA *-1
       REM
B23    TSX RDNCK,4    REDUNDANCY CHECK
       TRA B20        IF A TAPE CHECK OCCURS
       REM            THERE WILL BE NO
       REM            ATTEMPT TO REWRITE THE
       REM            RECORD
       CLA K11+7
       LBT
       TRA B29        DO NOT BACKSPACE READ
       TRA B25
       REM
       REM
       REM            BACKSPACE READ AFTER
       REM            WRITING CURRENT LAST RECORD
       REM
       BCD 1RTBA 1
B25    NOP
       BSRA 1
       RTBA 1         READ RECORD WRITTEN
       RCHA CT12
       TCNA B26
       TRA *-1
       REM
B26    TSX RDNCK,4    CHECK REDUNDANCY TAPE
       TRA B25        CHECK
       REM
       TSX GEN3,4
       REM
       REM
       LXA WDCT,1     WORD COUNT
       CLA WDCT       L NUMBER OF WORDS
       ADD ONE        L +1
       STO WDNO
B27    CLA 0,1        WRFLD
       LDQ 0,1        RDFLDT
       CAS 0,1
       TRA *+2        COMPARISON ERROR
       TRA *+3
       REM
       TSX ERROR-2,4  COMPARISON ERROR
       TRA B25
       REM
       TIX B27,1,1    DECEMENT WORD NUMBER
       REM
       REM            PHYSICAL
B28    ETTA           END OF TAPE TEST
       TRA B19
       REM
B29    TIX B21A,2,1   DECEMENT RECORD NUMBER
       WEFA 1         WRITE END OF FILE
       REM
       REM
*             REWIND AND READ VARIABLE LENGTH BINARY RECORDS
       REM
       LXA K3+4,1     L10
       CAL K10+8,1    INITIALIZE RANDOM
       SLW K11+8,1    GENERATOR
       TIX *-2,1,1
       TRA B30
       BCD 1RTBA 1
B30    REWA 1
       TCOA *         DELAY
       IOT            TURN IOT IND OFF IF ON
       NOP
       REM
       CLA B37A+4     L TRA B30-6
       STO 0          POST RESTART FOR READ
       REM
B31    LXA K2,2       L +1000
       CLA K2         L NUMBER OF RECORDS
       ADD ONE        L +1
       STO RECNO
       REM
B31A   TSX GEN1,4     GENERATE RANDOM RECORD
       REM
       TRCA *+1       TURN OFF RDNCY IND IF ON
       RTBA 1         READ TAPE BINARY
       RCHA CT12      TRANSFER CONTROL WORD
       REM
       REM            TO BUFFER
       TCNA B34       TRA WITH CHAN NOT IN OPN
       TRA *-1
B34    TSX RDNCK,4
       TRA B30
       TSX GEN3,4     FORM COMPARE ADDRESSES
       REM
       LXA WDCT,1     WORD COUNT
       CLA WDCT       L NUMBER OF WORDS
       ADD ONE        L +1
       STO WDNO
B35    CLA 0,1        WORD WRITTEN
       LDQ 0,1        WORD READ
       CAS 0,1        AND COMPARE
       TRA B36        ERROR
       TRA B36+3
       REM
B36    TSX ERROR-2,4
       TRA B30
       REM
       SLN 2          TURN ON SL2 ON ERROR
       TIX B35,1,1    DECREASE WORD COUNT BY
       REM            1
       SLT 2          TEST SL2
       TRA B36B       OFF
       CAL K11+7
       PBT
       TRA B36B       DO NOT BACKSPACE READ
       REM
*             BACKSPACE READ AFTER READING
*             CURRENT LAST RECORD
       REM
       BSRA 1
       RTBA 1
       RCHA CT12
       TCOA *         DELAY
       TSX RDNCK,4    CHECK REDUNDANCY
       NOP B30
       REM
       TSX GEN3,4
       REM
       LXA WDCT,1
       CLA WDCT
       ADD ONE        L +1
       STO WDNO
B36A   CLA 0,1
       LDQ 0,1
       CAS 0,1
       TRA *+2
       TRA *+3
       TSX ERROR-2,4  COMPARISON ERROR
       NOP B30
       TIX B36A,1,1   DECREMENT WORD NUMBER
       REM
B36B   TIX B31A,2,1   DECREMENT RECORD NUMBER
       TRA B37        GO TO READ NEXT VARIABLE
       REM            LENGTH BINARY RECORD
       BCD 1WEFA 1
B37    RTBA 1
       RCHA K4
       TCOA *         DELAY
       SCHA K4+2      DSC CONTROL WORD
       LDQ K4+4
       CLA K4+2
       CAS K4+4
       TRA *+2        ERROR
       TRA B37A       SHOULD XFER
       CAS K4+3
       TRA *+2
       TRA *+4
       TSX ERROR-1,4  FAILURE TO DISCN CORRECTLY
       REM            OR FAILED TO SCH CORRECTLY
       NOP B37
       TRA B37A
       TSX ERROR-1,4  FALSE EOR READ AT EOF
       NOP B37
       REM
B37A   TEFA *+3       EOF SHOULD BE ON
       TSX ERROR-1,4  FAILED TO READ EOF
       NOP B37
       TSX OK,4
       TRA B30-6
       REM
       NOP
       TRA PASS
       REM
       REM            RANDOM BINARY GENERATOR
       REM
GEN1   LDQ K11+7      RANDOM NUMBER GENERATOR
       CLA ZERO       CLEAR ACC
       LGL 9
       ADD K3         L+1
       PAX 3,1        FORM NO.OF WORDS PER REC
       SXA WDCT,1     SET UP WORD COUNT IN
       SXD CT10,1
       SXD CT12,1
       ADM K3+1       INITIAL ADDR OF WR FLD
       STA GEN2+2
       PXA 0,1
       ADD K3+3       START OF RANDOM NO. FLD
       STA GEN2+1
       REM
GEN2   CAL K11+7      GENERATE N-RANDOM WORDS
       ADM 0,1
       SLW 0,1
       TIX *-2,1,1
       SLW WRFLD-1
       TRA 1,4        EXIT
       REM
GEN3   CLA K3+1       INITIAL ADDR WRITE FIELD
       ADD WDCT       WORD COUNT
       STA B27
       STA B35
       STA B36A
       CLA K3+2       INITIAL ADDR READ FIELD
       ADD WDCT
       STA B27+1
       STA B27+2
       STA B35+1
       STA B35+2
       STA B36A+1
       STA B36A+2
       REM
       TRA 1,4        CONTINUE PROGRAM
       REM
       REM
PASS   REWA 1         REWIND TEST FRAME
       SWT 3          TEST SENSE SWITCH 3
       TRA PRT1       GO TO PRINT PASS COMPLETE
       REM
       REM
FINL   SWT 6
       TRA FINL1
       SWT 5
       TRA TCTX
       HTR B30-6
       REM
*    REMOVE TAPE REEL FROM FRAME 1 AND PLACE IT ON NEXT FRAME TO BE
*    TESTED.   SET DIAL OF NEW TEST FRAME TO 1 AND PASS FRAME TO 0.
*    PRESS START
       REM
       REM
TCTX   TSX CTX,4
       HTR B19-1,0,PASS+1   MODIFICATION AREA
       TRA B19
       REM
FINL1  RCDA           SELECT CARD READER
       RCHA FNLX      READ IN
       LCHA 0         NEXT
       TRA 1          PROGRAM
       REM
FNLX   MON 0,0,3
       REM
       REM
*             PRINT - NOW PERFORMING DIAGNOSTIC TEST 9T04
       REM
PRID   WPRA 1         PRINT
       SPRA 3         DOUBLE SPACE
       RCHA CT1       TEST IDENTITY
       TRA 1,4
       REM
       REM
*             PRINT - 9T04  PASS COMPLETE
       REM
PRT1   WPRA 1         PRINT
       SPRA 3         DOUBLE SPACE
       RCHA CT2       PASS COMPLETE
       TRA FINL
       REM
*             CONSTANT
       REM
ONES   OCT -3777777777777
ZERO   OCT 0000000000000
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
CT1    IOCD PRIDN,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT2    IOCD PR1,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT10   IOCD WRFLD    CONTROL WORD FOR
       REM           WRITING RANDOM BINARY
       HTR 0         RECORDS
CT12   IOCD RDFLD,0,0 CONTROL WORD FOR READ
       HTR           REC BINARY
       REM
       REM
*   PRINT  -  NOW PERFORMING DIAGNOSTIC TEST 9T04
       REM
PRIDN  OCT +002241004010  9 ROW LEFT
       OCT +0             9 ROW RIGHT
       OCT +000000000000  8 L
       OCT +0
       OCT +010010200000  7 L
       OCT +0
       OCT +141400040000  6 L
       OCT +0
       OCT +204020100200  5 L
       OCT +0
       OCT +000102000001  4 L
       OCT +0
       OCT +000000012444  3 L
       OCT +0
       OCT +000000020100  2 L
       OCT +0
       OCT +000000400000  1 L
       OCT +0
       OCT +040000030546  0 L
       OCT +0
       OCT +312720140000  11 L
       OCT +0
       OCT +005053606200  12 L
       OCT +0
       REM
*    PRINT  -  9T04   PASS COMPLETE
       REM
PR1    OCT +010000000000  9 ROW LEFT
       OCT +0              9 ROW RIGHT
       OCT +000000000000  8 L
       OCT +0
       OCT +000010020000  7 L
       OCT +0
       OCT +000000100000  6 L
       OCT +0
       OCT +000000005000  5 L
       OCT +0
       OCT +001000040000  4 L
       OCT +0
       OCT +004000212000  3 L
       OCT +0
       OCT +000003000000  2 L
       OCT +0
       OCT +000004000000  1 L
       OCT +0
       OCT +006003002000  0 L
       OCT +0
       OCT +000010170000  11 L
       OCT +0
       OCT +000004205000  12 L
       OCT +0
       REM
       REM
CONST  OCT 0000000000000
       OCT 0000000000100
       OCT 0000000000172
       OCT 0000000000440
       OCT 0000000000000
       OCT 0000000000000
XRA    OCT 0
XRB    OCT 0
XRC    OCT 0
TEMP   OCT
TEMP1  OCT 0000000000000
TEMP2  OCT 0000000000000
TEMP3  OCT 0000000000000
       HTR RDFLD,0,7
WDCT   OCT
       OCT            INITIAL WR ADDR + COUNT
       REM
IOCTT  OCT +0         TAPE FRAME COUNT
       REM
CTR1   OCT +760
CTR2   OCT +76000
       REM
       REM
WTBA1  WTBA 1
WTBA2  WTBA 2
RTB    RTBA 1
WTB    OCT 0
       REM
       REM
       REM
K2     OCT +400       RANDOM RECORD COUNT
       OCT 622
       OCT 300
       OCT 60
       OCT +26
       TRA AA         REPEAT PROGRAM
       OCT +400
       OCT +7000
       OCT +375
K3     OCT +1
       REM
       HTR WRFLD
       HTR RDFLD
       HTR K11
       OCT 10
K4     PTW RDFLD,0,30 TRIGGER 1 ON
       PZE K4+1       NO TRIGGERS ON
       HTR
       PZE K4+1,0,K4+2
       IORP RDFLD,0,K4+1
       REM
K5     OCT 00000004043
K6     OCT +17
       OCT +1000
       OCT +1001
       OCT +100
       OCT +101
       OCT +36
       OCT +20
       OCT +102
K8     OCT +377777777767
       OCT -343677616030  MASK FOR PASS PRINT
K9     OCT +012301230123
       OCT +171717171717
       OCT +175757575757
       OCT +121212121212
       OCT +125252525252
K10    OCT -331011416132
       OCT +033420275437
       OCT -126044765051
       OCT +602037467555
       OCT -305552746526
       OCT -134703564071
       OCT +364271003007
       OCT +60203746526
K11    EQU K10+8
       REM
WRFLD  EQU K11+8
RDFLD  EQU WRFLD+512
       REM
       REM
ERROR  EQU 3396
OK     EQU 3401
RDNCK  EQU 3440
WDNO   EQU 3438
RECNO  EQU 3439
CTRL1  EQU 2880
CTRA   EQU 2884
CTX    EQU 2890
IOCNT  EQU 2891
IOC    EQU 2892
       REM
       END
