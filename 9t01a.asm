                                                            9 T 0 1 A
                                                            7-01-58
       REM
       REM
       REM
*                             9 T 0 1 A
*                           729 UNIT TEST
       REM
       REM
       ORG 24
 IDN   TRA IDNT       TO PRINT OUT TEST IDENTITY
       REM            THIS INSTR IS REPLACED BY
       REM            TRA AA DURING FIRST PASS
       REM
       TSX IOC,4      TO ENTER CONTROL WORDS
       REM
 RUC   TSX IOCNT,4    TO RESET UNIT COUNT
       REM
       REM
*             CHECK FOR EXCLUSIVE TAPE FRAME BITS IN
*             I-O CONTROL WORD AND ESTABLISH INITIAL
*             STATUS OF UNIT ADDRESSES
       REM
 INTL  LDI CTRL1      L INDS WITH CHN A CONTROL
       RFT 000340     CHECK FOR MORE THAN UNIT 1
       RNT 000400     IF MORE THEN UNIT 1
       REM            CHECK FOR EXCLUSIVE BIT
       RNT 000020     IS NOT MORE THANT UNIT 1
       REM            OR IS NOT EXCLUSIVE BIT
       REM            CHECK FOR UNIT 1
       TRA TCTX       EXCLUSIVE UNIT HIGHER THEN
       REM            UNIT 1 OR NO UNITS ON CHN A
       REM
       CLA CTRL1
       TPL *+4        CHECK FOR SIGN BIT SHOWING
       REM            PROGRAM READ FROM CARDS
       CLA K8+2       L RTBA 1
       STO K7+4
       TRA *+3
       CLA K8+3       L RTBA 2
       STO K7+4
       REM
 INTL2 CLA BSR3       UNIT 1 OK - ESTABLISH
       REM            INITIAL STATUS OF INSTRS
       CAS K7+4
       TRA *+2
       TRA *+4        OK FOR UNIT 1 - PROCEED
       TSX CTX,4      GO TO ADJUST PROGRAM FOR
       HTR AA,0,GEN1  CHANNEL A - UNIT 1
       TRA INTL2
       NOP            REPLACE WITH TRA AC
       REM            AFTER FIRST PASS
       REM
       REM
*             TEST LOAD TAPE BUTTON
       REM
       REWA 1
       WTBA 1         WRITE THREE WORD LOAD
       RCHA CT20      SEQUENCE PLUS 10 WORDS
       WEFA 1         OF INFORMATION
       REWA 1
       HTR *          PRESS LOAD TAPE BUTTON
       REM
*             WHEN TESTING LOAD TAPE BUTTON
*                 LOC 0   IOCD RDFLD,0,10
*                 LOC 1   TCOA 1
*                 LOC 2   TRA TLBA
       REM
       BCD 1LTB       TEST LOAD TAPE BUTTON
 LTB   REWA 1         THESE 3 INSTRUCTIONS
       RTBA 1         USED ONLY IN LOOP
       RCHA CT21      FROM LTB2+2
       REM
 LTBA  LXA K5,1       L +4043 IN XRA
       TIX *,1,1      DELAY
       CLA TEN        L +12
       PAX 0,1        L +12 IN XRA
       ADD ONE        L +1
       STO WDNO       SAVE WORD COUNT +1
       REM
       CLA ONE        L +1
       PAX 0,2        L +1 IN XRB
       ADD ONE        L +1
       STO RECNO      SAVE RECORD COUNT +1
       REM
 LTB1  CLA RDFLD+10,1 L WORD READ
       CAS FIX+10,1   COMPARE WORD GENERATED
       TRA *+2        ERROR
       TRA LTB2       OK
       LDQ FIX+10,1   L WORD GNEERATED IN MQ
       TSX ERROR-2,4  COMPARISON ERROR
       NOP LTB
       REM
 LTB2  TIX LTB1,1,1
       TSX OK,4
       TRA LTB
       REM
       NOP
       CLA TRA1       L TRA AC
       STO INTL2+7
       REM
       REM
 AC    CLA IOCT
       TZE FINL       ALL UNITS CALLED CHECKED
       SUB ONE        L +1
       STO IOCT
       REM
       REM
 AA    CLA K2+5       POST
       STO 0          RESTART
       TRA *+2
       REM
* NOTE -- ERROR PRINT OUTS FROM EXIT INSTRS
       REM
*                            TSX ERROR-1,4
*                            TXL XXX        TO FOLLOWING
*                                           BCD TEST INSTR
       REM
*         WILL BEONLY ONE LINE LONG. IF TXL IS TAGGED
*         BY 4, PROGRAM WILL NOT GO TO LOC XXX WHEN
*         SSW 1 IS DOWN BUT WILL PROCEED TO NEXT INSTR.
       REM
       REM
*            CHECK DS DISCONNECT AFER SELECT
*            AND ZERO CONTROL WORD FOLLOWING
*            A NON-DATA INSTRUCTION
       REM
       BCD 1DSCN      TEST CONDITION
 DSCN  IOT            TURN OFF I-O CHECK OF ON
       NOP
       REWA 1
       BSRA 1
       WTBA 1
       RCHA ZERO      SHOULD DISCONNECT AT ONCE
       WEFA 1
       BSRA 1         BKSP OVER EOF
       BSRA 1         BKSP TO LOAD POINT
       RTDA 1
       RCHA ZERO      IF PROGRAM HANGS UP AT ANY
       BSFA 1         BKSP OVER EOF
       BSFA 1         BKSP TO LOAD POINT
       WTBA 1
       RCHA ZERO      OF THESE RCH INSTRS --
       BSFA 1         BKSP TO LOAD POINT
       RTDA 1
       RCHA ZERO      DS FAILS TO DISCONNECT
       REM
       REM            CHECK FOR LOSS OF UNIT
       REM            OR CLASS ON DS
       REM
       TEFA *+1       TURN OFF EOF TGR IF ON
       TSX RDNCK,4    CHECK FOR REDUNDANCY
       NOP DSCN
       IOT
       TRA *+2        ON - ERROR
       TRA TCO        OFF - OK
       TSX ERROR-1,4  I-O CHECK ERROR - SHOULD
       TXL DSCN,4     NOT BE ON
       TRA TCO
       REM
       TRA TCO
       REM
       REM
*             CHECK CHANNEL IN OPERATION TESTS
       REM
       BCD 1TCOA
 TCO   REWA 1         POSITION TAPE
       WTBA 1         ONE WORD
       RCHA CT1       FROM LOAD POINT
       BSRA 1         BKSP OVER RECORD
       BSRA 1         BKSP TO LOAD POINT
       REWA 1         REWIND TEST UNIT
       AXT 4095,1     LXA K5,1       L +4043 IN XRA
       TIX *,1,1
       TCOA *+2       SHOULD NOT TRANSFER
       TRA TCO1
       TSX ERROR-1,4  FALSE XFER WITH CHANNEL
       REM            NOT IN OPERATION
       TXL TCO
       REM
 TCO1  WTBA 1
       TCOA TCO2      SHOULD XFER
       TSX ERROR-1,4  FAILED TO XFER WITH CHANNEL
       REM            IN OPERATION AFTER SELECT
       TXL TCO
       REM
       WTBA 1         RE-SELECT AFTER PRINT
 TCO2  RCHA CT1       WRITE 1 ONE WORD RECORD
       TCOA TCO3      SHOULD XFER
       TSX ERROR-1,4  FAILED TO XFER WITH
       REM            CHANNEL IN OPERATION
       TXL TCO
       REM
 TCO3  TCOA *         DELAY
       REM            IF PROGRAM HANGS UP HERE
       REM            CHANNEL FAILS TO DISCONNECT
       REM            OR GIVE OUT OF OPN IND
       REM
       TCOA *+2       SHOULD NOT XFER
       TRA *+3
       TSX ERROR-1,4  FALSE XFER WITH CHANNEL
       REM            NOT IN OPN AFTER DISCONNECT
       TXL TCO
       REM
       TSX OK,4
       TRA TCO
       REM
       REM
       BCD 1TCNA
 TCN   LXA K2+1,1     L +622 IN XRA
       TIX *,1,1      DELAY TO CLEAR CHANNEL
       TCNA TCN1      SHOULD XFER
       TSX ERROR-1,4  FAILED TO XFER WITH
       REM            CHANNEL NOT IN OPERATION
       TXL TCN
       REM
 TCN1  WTBA 1
       TCNA *+2       SHOULD NOT XFER
       TRA TCN2
       TSX ERROR-1,4  FALSE XFER AFTER SELECT
       TXL TCN
       REM
       WTBA 1         RE-SELECT AFTER PRINT
 TCN2  RCHA CT1       WRITE 1 ONE WORD RECORD
       TCNA *+2       SHOULD NOT XFER
       TRA TCN3
       TSX ERROR-1,4  FALSE XFER WITH CHANNEL
       REM            IN OPERATION
       TXL TCN
       REM
 TCN3  TCOA *         DELAY
       TCNA *+3
       TSX ERROR-1,4  FAILED TO XFER AFTER DISCN
       TXL TCN
       TSX OK,4
       TRA TCN
       REM
       REM
*             CHECK ETT IN OFF STATUS
       REM
       BCD 1ETTA
 ETT   ETTA           TURN OFF ETT INDICATOR
       TRA *+1        IF ON
       REWA 1
       CLA ONES       L -37777777777
       BSRA 1
       ETTA
       TRA *+2        SHOULD NOT XFER
       TRA ETT1
       TSX ERROR-1,4  FALSE ETT INDICATION OR
       REM            FAILURE TO SKIP ON NO IND
       TXL ETT,4
       REM
 ETT1  TNZ ETT2
       TSX ERROR-1,4  FALSE CLEARING OF ACC
       REM            CHECK AGAINST CLM INSTR
       NOP ETT
 ETT2  TSX OK,4
       TRA ETT
       REM
       REM
*             CHECK BEGINNING OF TAPE TEST
       REM
       BCD 1BTTA      TEST INSTRUCTION
 BTT   REWA 1
       BSRA 1
       REWA 1
       TCOA *         DELAY
       BTTA           TURN OFF BTT
       TRA *+1        INDICATOR IF ON
       CLA ONES       L -37777777777
       BSRA 1         TURN ON BTT INDICATOR
       REWA 1
       TCOA *
       BTTA           SHOULD BE ON
       TRA BTT1       OK, BTT TGR SHOULD BE ON
       REM            SHOULD NOT SKIP
       TCOA *         OFF - ERROR. RECHECK
       REM            CHANNEL OUT OF OPN
       BTTA
       TRA *+4        ON - LATE
       TSX ERROR-1,4  FAILED TO TURN ON BTT IND
       TXL BTT
       TRA BTT1
       TSX ERROR-1,4  TIMING ERROR IN TURNING
       REM            ON BTT INDICATOR
       TXL BTT
       TRA BTT4
       REM
 BTT1  BTTA
       TRA *+2
       TRA BTT2       OK, TGR SHOULD BE OFF
       TSX ERROR-1,4  BTT INSTR FAILED TO TURN
       REM            OOF BTT TGR
       TXL BTT
       TRA BTT4
       REM
 BTT2  BSFA 1         TURN ON BTT TGR
       REWA 1         TIME DELAY TO
       TCOA *         BRING UP BTT IND
       BTTA
       TRA *+3        OK, TGR SHOULD BE ON
       REM            SHOULD NOT SKIP
       TSX ERROR-1,4  BSF INSTR FAILED TO TURN
       REM            ON BTT TGR
       TXL BTT
       REM
 BTT3  REWA 1
       REWA 1
       TCOA *         DELAY
       BTTA           SHOULD BE OFF
       TRA *+2        ON - ERROR
       TRA *+3        OFF - OK
       TSX ERROR-1,4  REWIND INSTR SHOULD NOT
       REM            TURN ON BTT TRG
       TXL BTT
       REM
 BTT4  TNZ BTT5       SHOULD XFER
       TSX ERROR-1,4  FALSE CLEARING OF ACC
       REM            CHECK AGAINST CLM INSTR
       NOP BTT
       REM
 BTT5  TSX OK,4
       TRA BTT
       REM
       REM
*             CHECK INPUT-OUTPUT TEST
       REM
       BCD 1IOT       TEST INSTRUCTION
 IOT   IOT            TURN OFF TAPE CHECK
       NOP            INDICATOR IF ON
       WTBA 1         WRITE 10 WORDS AND CALL
       RCHA CT3       FOR LCH
       TCOA *         DELAY UNTIL CHN DISCONNECTS
       LCHA CT1       TOO LATE
       TCOA *
       IOT            SHOULD BE ON
       TRA *+3        ON - OK
       TSX ERROR-1,4  FAILED TO TURN IOT IND ON
       REM            OR FALSE SKIP WITH IND ON
       TXL IOT
       REM
       IOT            SHOULD BE OFF
       TRA *+2        ON - ERROR
       TRA *+3        OFF - OK
       TSX ERROR-1,4  IOT INSTR FAILED TO
       TXL IOT        TURN OFF INDICATOR
       REM
       WTBA 1         SELECT WITH NO RESET AND
       LCHA CT8       LOAD CHANNEL INSTR
       TCOA *         DELAY
       IOT            SHOULD BE ON
       TRA *+3        ON - OK
       TSX ERROR-1,4  LCH AFTER WTB AND WITHOUT
       REM            RCH FAILED TO TURN ON IND
       TXL IOT
       REM
       TCOA *         DELAY
       LCHA CT8
       IOT            SHOULD BE ON
       TRA *+3        ON - OK
       TSX ERROR-1,4  LCH WITH NO UNIT SELECTED
       TXL IOT        FAILED TO TURN ON INDICATOR
       TCOA *         DELAY
       RCHA CT8
       IOT            SHOULD BE ON
       TRA *+3        ON - OK
       TSX ERROR-1,4  RCH WITH NO UNIT SELECTED
       TXL IOT        FAILED TO TURN ON INDICATOR
       REM
       WTBA 1
       RCHA CT8
       TCOA *         DELAY
       IOT            SHOULD BE OFF
       TRA *+2        ON - ERROR
       TRA *+3        OFF - OK
       TSX ERROR-1,4  FALSE IOT INDICATION
       TXL IOT
       TSX OK,4
       TRA IOT
       REM
       REM
*             TEST SENSE TAPE CHECK
       REM
       BCD 1TRCA      TEST INSTRUCTION
TRC    TRCA *+1       TURN OFF TAPE CHECK IF ON
       REWA 1
       WTBA 1         WRITE TAPE IN BINARY
       RCHA CT8
       BSRA 1
       RTDA 1         READ TAPE IN DECIMAL
       RCHA CT7       TURN ON TAPE CHECK IND
       TCOA *         DELAY UNTIL CHN NOT IN OPRN
       TRCA *+3
       TSX ERROR-1,4  TAPE CHECK NOT TURNED ON OR
       REM            FAILED TO XFER WITH IND ON
       TXL TRC
       REM
       TRCA *+2       SHOULD BE OFF, NO XFER
       TRA *+3
       TSX ERROR-1,4  TRC INSTR FAILED TO TRUN
       REM            OFF TAPE CHECK INDICATOR
       REM            OR FALSE XFER WITH IND OFF
       TXL TRC
       TSX OK,4
       TRA TRC
       REM
       REM
*             TEST BACKSPACE RECORD AT LOAD POINT
       REM
       BCD 1BSRA      TEST INSTRUCTION
BLP    REWA 1         REWIND TAPE UNIT
       BTTA           TURN OFF BTT INDICATOR
       TRA *+1
       LXA K6+5,1     L +36 IN XRA
       WTBA 1
       RCHA CT1       WRITE 1 ONE WORD RECORD
       BSRA 1         BACKSPACE OVER RECORD
       BSRA 1         BACKSPACE TO LOAD POINT
       BSRA 1         ATTEMPT BACKSPACE OVER LP
       TIX *-1,1,1
       BTTA           TEST FOR BEGINNING OF TAPE
       TRA BLP1       ON - OK
       TSX ERROR-1,4  FAILED TO TURN ON BTT IND
       TXL BLP
       REM
BLP1   RTBA 1         READ SELECT TAPE
       STZ RDFLD      CLEAR RDFLD
       RCHA CT2       READ ONE WORD
       LXA ONE,1      L +1 IN XRA - WDS PER REC
       LXA ONE,2      L +1 IN XRB - NO. OF RECS
       CLA TWO
       STO WDNO
       STO RECNO
       TCOA *         DELAY
       CLA RDFLD      L WORD READ
       CAS FIX        COMPARE WORD GENERATED
       TRA *+2
       TRA *+3        OK
       LDQ FIX        L WORD GENERATED IN MQ
       TSX ERROR-4,4  COMPARE ERROR AT LOAD POINT
       TSX OK,4
       TRA BLP
       REM
       REM
*             TEST BACKSPACE FILE AT LOAD POINT
       REM
       BCD 1BSFA      TEST INSTRUCTION
BLP2   REWA 1         REWIND TAPE UNIT
       BTTA           TURN OFF BTT INDICATOR
       TRA *+1
       LXA K6+5,1     L +36 IN XRA
       WTBA 1
       RCHA CT1       WRITE 1 ONE WORD RECORD
       BSFA 1         BACKSPACE OVER RECORD
       BSFA 1         BACKSPACE TO LOAD POINT
       BSFA 1         ATTEMPT BACKSPACE OVER LP
       TIX *-1,1,1
       BTTA
       TRA BLP3       ON - OK
       TSX ERROR-1,4  FAILED TO TURN ON BTT IND
       TXL BLP2
       REM
BLP3   RTBA 1         READ SELECT TAPE
       STZ RDFLD      CLEAR RDFLD
       RCHA CT2       READ ONE WORD
       LXA ONE,1      L +1 IN XRA - WDS PER REC
       TCOA *         DELAY
       CLA RDFLD      L WORD READ
       CAS FIX        COMPARE WORD GENERATED
       TRA *+2
       TRA *+3        OK
       LDQ FIX        L WORD GENERATED IN MQ
       TSX ERROR-4,4  ERROR AT LOAD POINT
       TSX OK,4
       TRA BLP2
       REM
       REM
*             TEST REWIND AT LOAD POINT
       REM
       BCD 1REWA      TEST INSTRUCTION
RLP    BTTA           TURN OFF BTT INSDICATOR
       TRA *+1
       REWA 1         REWIND TAPE UNIT
       LXA K6+5,1     L +36 IN XRA
       WTBA 1
       RCHA CT1       WRITE 1 ONE WORD RECORD
       REWA 1         REWIND OVER RECORD
       REWA 1         ATTEMPT TO REWIND OVER LP
       TIX *-1,1,1
       BTTA           TEST FOR BEGINNING OF TAPE
       TRA *+2        ON - ERROR
       TRA *+3        OFF - OK
       TSX ERROR-1,4  FALSE BTT IND
       REM            AFTER REPEATED REWINDINGS
       TXL RLP
       REM
RLP1   RTBA 1         READ SELECT TAPE
       STZ RDFLD      CLEAR RDFLD
       RCHA CT2       READ ONE WORD
       LXA ONE,1      L +1 IN XRA - WDS PER REC
       TCOA *         DELAY
       CLA RDFLD      L WORD READ
       CAS FIX        COMPARE WORD GENERATED
       TRA *+2
       TRA *+3        OK
       LDQ FIX        L WORD GENERATED IN MQ
       TSX ERROR-4,4  ERROR AT LOAD POINT
       TSX OK,4
       TRA RLP
       REM
       REM
*             CHECK XFER ON END OF FILE
       REM
       BCD 1TEFA      TEST INSTRUCTION
TEF    REWA 1
       TEFA *+1       TURN OFF EOF IND IF ON
       TRCA *+1       TURN OFF TRC TGR IF ON
       WTBA 1         WRITE FIRST FILE OF
       RCHA CT6       2 ONE WORD RECORDS
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TEF
       WEFA 1         WRITE END OF FILE
       WTBA 1         WRITE SECOND FILE OF
       RCHA CT6A      2 ONE WORD RECORDS
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TEF
       WEFA 1         WRITE END OF FILE
       REM
       REWA 1
       TSX CLR,4      GO TO CLEAR READ FIELD
       RTBA 1
       RCHA CT4       READ 2 WORDS
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TEF
       AXT 1,1        L +1 IN XRA
       CLA TWO        L +2
       STO WDNO
       AXT 2,2        L +2 IN XRB
       CLA THREE      L +3
       STO RECNO
       CLA RDFLD+2,2  L WORD READ
       CAS FIX+2,2    COMPARE WORD GENERATED
       TRA *+2        ERROR
       TRA TEF1       OK
       LDQ FIX+2,2    L WORD GENERATED IN MQ
       TSX ERROR-2,4  FAILED TO READ OR WRITE
       REM            CORRECTLY FIRST FILE AT LP
       NOP TEF
       TIX *-7,2,1
       REM
TEF1   RTDA 1         READ OVER
       RCHA CT7       END OF FILE
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TEF
       TEFA TEF2      SHOULD XFER
       TSX ERROR-1,4  FAILED TO XFER ON EOF
       REM            OR FAILED TO RECOGNIZE
       REM            EOF CORRECTLY IN BCD MODE
       TXL TEF,4
       REM
TEF2   RTBA 1
       RCHA CT4A      READ 2 WORDS INTO RDFLD+2
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TEF
       AXT 2,2        L +2 IN XRB
       CLA RDFLD+4,2  L WORD READ
       CAS FIX+4,2    COMPARE WORD GENERATED
       TRA *+2        ERROR
       TRA TEF3       OK
       LDQ FIX+4,2    L WORD GENERATED IN MQ
       TSX ERROR-2,4  FAILED TO READ OR WRITE
       REM            CORRECTLY SECOND FILE
       NOP TEF
       TIX *-7,2,1
       REM
TEF3   RTBA 1
       RCHA CT7
       TCOA *         DELAY
       TRCA *+2       SHOULD NOT XFER
       TRA *+3        OK
       TSX ERROR-1,4  READING TAPE MARK SHOULD
       TXL TEF5       NOT GIVE TRC INDICATION
       TEFA TEF4      SHOULD XFER
       TSX ERROR-1,4  FAILED TO XFER ON EOF
       REM            OR FAILED TO RECOGNIZE
       REM            EOF CORRECTLY IN BIN MODE
       TXL TEF,4
       REM
TEF4   TSX OK,4
       TRA TEF
       REM
       REM
*             CHECK FOR FALSE REGOITION OF SIMULATED TAPE MARK
       REM
       BCD 1TEFA      TEST INSTRUCTION
TEF5   REWA 1
       TEFA *+1       TURN OFF EOF IND IF ON
       TRCA *+1       TURN OFF TRC IND IF ON
       WEFA 1         WRITE END OF FILE
       WTDA 1         WRITE IN BCD MODE THREE
       RCHA CT30      1 WORD RECORDS FROM BINARY
       REM            FIELDS. THE 2ND RECORD
       REM            WILL BE AN ILLEGAL BIT
       REM            PATTERN SIMULATING A
       REM            TAPE MARK
       REM
       WEFA 1         WRITE END OF FILE
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TEF5
       REWA 1
       STZ TEMP       CLEAR READ AREA
       TSX CLR,4      GO TO CLEAR READ AREA
       RTDA 1         READ OVER END OF FILE
       RCHA CT7
       TCOA *         DELAY
       TEFA *+3       SHOULD XFER
       TSX ERROR-1,4  FAILED TO RECOGNIZE INITIAL
       TXL TEF5,4     END OF FILE AT LOAD POINT
       TRCA *+2       SHOULD NOT XFER
       TRA *+3        OK
       TSX ERROR-1,4  FALSE TRC IND AFTER
       TXL TEF5,4     READING TAPE MARK
       REM
       CLA TEMP       L WORD READ IF ANY
       CAS ZERO       SHOULD BE NO WORD READ
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ ZERO
       TSX ERROR-2,4  TAPE MARK READ INTO
       NOP TEF5       STORAGE
       RTDA 1
       RCHA CT4       READ 2 WORDS
       TCOA *         DELAY
       TEFA *+2       SHOULD NOT XFER
       TRA *+3
       TSX ERROR-1,4  ILLEGAL BIT PATTERN
       TXL TEF5,4     SIMULATING A TAPE MARK
       REM            FALSELY RECOGNIZED AS EOF
       TRCA TEF6      SHOULD XFER
       TSX ERROR-1,4  ILLEGAL BIT PATTERN
       TXL TEF5,4     SIMULATING A TAPE MARK
       REM            FAILED TO SET TRC
       REM
TEF6   AXT 1,1        L +1 IN XRA
       CLA TWO        L +2
       STO WDNO
       AXT 2,2        L +2 IN XRB
       CLA THREE
       STO RECNO
       CLA RDFLD+2,2  L WORD READ
       CAS KK1+2,2    COMPARE WORD GENERATED
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ KK1+2,2    L WORD GENERATED IN MQ
       TSX ERROR-2,4  COMPARISON ERROR. NOTE-
       NOP TEF5       WORD GENERATED IN REC 2
       REM            SHOWS 1ST 2 CHARS AS ZERO
       REM            AS THE FALSE TAPE MARK
       REM            SHOULD BE READ INTO STG
       TIX *-7,2,1
       REM
TEF7   RTDA 1         READ 1 WORD AND EOF
       RCHA CT4A
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TEF5
       TEFA *+3       SHOULD XFER
       TSX ERROR-1,4  FAILED TO RECOGNIZE
       TXL TEF5,4     TERMINAL END OF FILE
       REM
       CLA RDFLD+2    L WORD READ
       CAS KK1+2      COMPARE WORD GENERATED
       TRA *+2        ERROR
       TRA *+5        OK
       LDQ KK1+2      L WORD GENERATED IN MQ
       AXT 0,2        L +0 IN XRB
       TSX ERROR-2,4
       NOP TEF5
       REM
       BSFA 1         BACKSPACE OVER TAPE MARK
       BSFA 1         BACKSPACE OVER FILE
       TSX CLR,4      GO TO CLEAR READ AREA
       RTDA 1         SHOULD READ OVER
       RCHA CT7       INITIAL END OF FILE
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TEF5
       TEFA *+1       TURN OFF EOF IND IF ON
       RTDA 1         READ TAPE IN BCDMODE
       RCHA CT4
       TCOA *         DELAY
       TRCA *+1       SHOULD XFER AND TURN OFF
       REM            TRC IND
       AXT 2,2        L +2 IN XRB
       CLA RDFLD+1    L WORD READ
       CAS KK1+1      COMPARE WORD GENERATED
       TRA TEF8       ERROR
       TRA TEF9       OK
       LDQ KK1+1      L WORD GENERATED IN MQ
       TSX ERROR-2,4  POSSIBLE BACKSPACE FILE
       NOP TEF5       ERROR
       TRA TEF9
TEF8   LDQ KK1+1      L WORD GENERATED IN MQ
       TSX ERROR-4,4  PROBABLE FALSE RECOGNITION
       REM            OF SIMULATED TAPE MARK
       REM            DURING BACKSPACE FILE
TEF9   TSX OK,4
       TRA TEF5
       REM
       REM
*             CHECK MAX DELAY BETWEEN WTB + RCH
       REM
       BCD 1WTBA 1    TEST INSTRUCTION
TVM    IOT            TURN OFF I-O CHECK
       NOP            INDICATOR IF ON
       TRCA *+1       TURN OFF TRC TGR IF ON
       REWA 1
       AXT 1666,1     L +3202 IN XRA
       TCOA *         DELAY
       WTBA 1
       TIX *,1,1      DELAY FOR 40 MILSEC
       RCHA CT6       WRITE TWO 1 WORD RECORDS
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TVM
       IOT            IS INPUT-OUTPUT CHK IND ON
       TRA *+2        YES - ERROR
       TRA *+3        NO - OK
       TSX ERROR-1,4  TIMING ERROR BETWEEN WTB
       TXL TVM        AND RCH INSTR AT LP
       REM
       AXT 256,1      L + 400 IN XRA
       WTBA 1
       TIX *,1,1      DELAY FOR 6 MILSEC
       RCHA CT6A      WRITE TWO 1 WORD RECORDS
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TVM
       IOT            IS INPUT-OUTPUT CHK IND ON
       TRA *+2        YES - ERROR
       TRA TVM1       NO - OK
       TSX ERROR-1,4  TIMING ERROR BETWEEN WTB
       TXL TVM        AND RCH INSTR NOT AT LP
       REM
       REM
*             CHECK MAX DELAY BETWEEN RTB + RCH
       REM
       BCD 1RTBA 1    TEST INSTRUCTION
TVM1A  TRA TVM
TVM1   IOT            TURN OFF I-O CHECK
       NOP            INDICATOR IFON
       REWA 1
       TSX CLR,4      GO TO CLEAR READ FIELD
       AXT 833,1      L +1500 IN XRA
       TCOA *         DELAY
       RTBA 1
       TIX *,1,1      DELAY FOR 20 MILSEC
       RCHA CT4       READ 2 WORDS INTO FIX
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TVM1A
       IOT            IS INPUT-OUTPUT CHK IND ON
       TRA *+2        YES - ERROR
       TRA *+3        NO - OK
       TSX ERROR-1,4  TIMING ERROR BETWEEN RTB
       TXL TVM1A      AND RCH INSTR AT LP
       REM
       AXT 125,1      L +175 IN XRA
       RTBA 1
       TIX *,1,1      DELAY FOR 3 MILSEC
       RCHA CT4A      READ 2 WDS INTO RDFLD+2
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP TVM1A
       IOT            IS INPUT-OUTPUT CHK IND ON
       TRA *+2        YES - ERROR
       TRA *+3        NO - OK
       TSX ERROR-1,4  TIMING ERROR BETWEEN RTB
       TXL TVM1A      AND RCH INSTR NOT AT LP
       REM
*             COMPARE
       REM
       CLA TWO        L +2
       STO WDNO
       AXT 1,1        L +1 IN XRA
       CLA FIVE       L +5
       STO RECNO
       AXT 4,2        L +4 IN XRB
       CLA RDFLD+4,2
       CAS FIX+4,2
       TRA *+2        YES - ERROR
       TRA *+4        OK
       LDQ FIX+4,2
       TSX ERROR-2,4  COMPARISON ERROR AFTER
       REM            WR-DELAY-BACKSPACE-RD-DELAY
       NOP TVM1A
       TIX *-7,2,1
       REM
       TSX OK,4
       TRA TVM
       REM
       REM
*             TEST BACKSPACE RECORD
       REM
*             WRITE 100 ONE WORD RECORD
       REM
       REM
       BCD 1BSRA 1    TEST INSTRUCTION      +
BSR    TRA *+2
       REWA 1
       WEFA 1         WRITE END OF FILE
       TEFA *+1       TURN OFF EOF TGR IF ON
       WTBA 1
       RCHA CT8
BSR1   LXA CONST+1,1  L +100 IN XRA
       CLA FIX+64,1
       STO TEMP
       WTBA 1
       RCHA CT7
       ETTA
       TRA BSR+1
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP BSR
       TIX *-6,1,1
       WEFA 1
       REM
*             BACKSPACE OVER LAST 15 RECORDS
       REM
       LXA K6,1       L +17 IN XRA
       BSRA 1         BACKSPACE OVER TAPE MARK
BSR2   BSRA 1         BACKSPACE OVER
       TIX BSR2,1,1   LAST 15 RECORDS
       REM
*             READ AND COMPARE
       REM
       AXT 1,4        L +1 IN XRC
       AXT 15,2       L +17 IN XRA
       TSX CLR,4      GO TO CLEAR READ FIELD
BSR3   RTBA 1
       RCHA CT7
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP BSR
       TEFA *+2       SHOULD NOT XFER
       TRA *+6        OK
       CLA TEMP
       LDQ FIX+63,2
       SXA XRC,4
       TSX ERROR-2,4  PROBABLE BSR ERROR
REM                   TO BEGINNING OF FILE
       NOP BSR
       LXA XRC,4
       TRA BSR4
       REM
       CLA TEMP
       STO RDFLD+15,2
       TXI *+1,4,1
       TIX BSR3,2,1
       REM
       CLA K6+3       L +100
       SUB NINE       L +11
       STO RECNO
       SUB ONE        L +1
       PAX 0,2        SET RECORD COUNT
       CLA TWO        L +2
       STO WDNO
       LXA ONE,1      L +1 IN XRA - WDS PER REC
       CLA RDFLD+5    L WORD READ
       CAS FIX+54     COMPARE WORD GENERATED
       TRA *+6        ERROR
       TRA BSR4       OK
       LDQ FIX+54     L WORD GENERATED IN MQ
       TSX ERROR-2,4  BACKSPACE RECORD LONG
       TRA BSR
       TRA BSR4
       LDQ FIX+54     L WORD GENERATED IN MQ
       TSX ERROR-2,4  BACKSPACE RECORD SHORT
       TRA BSR
       REM
BSR4   TSX OK,4
       TRA BSR
       REM
       REM
*             CHECK MULTIPLE WRITE SELECTS
*             AND CHECK FOR NOISE
       REM
       BCD 1WTBA 1
A1     TRCA *+1       TURN OFF TRC IND IF ON
       LXA K6,1       L +17 IN XRA
A1A    WTBA 1
       ETTA
       TRA *+2
       TRA *+3
       REWA 1
       TRA A1
       TIX A1A,1,1
       TSX RDNCK,4    REDUNDANCY ERROR FROM NOISE
       TRA A1
       REM
       IOT            IS INPUT-OUTPUT CHK IND ON
       TRA *+2        ON - ERROR
       TRA *+3        OFF - OK
       TSX ERROR-1,4  FALSE IOT INDICATION
       TXL A1,4
       TSX OK,4
       TRA A1
       REM
       REM
*             TEST BACKSPACE FILE
       REM
       BCD 1BSFA 1
BSF    TRA *+2
       REWA 1
       TEFA *+1       TURN OFF EOF IND IF ON
       WEFA 1         WRITE END OF FILE
       WTBA 1
       RCHA CT8
       LXA K6+5,1     L +36 IN XRA
BSF2   CLA FIX+30,1
       STO TEMP
       WEFA 1         WRITE END OF FILE
       WTBA 1
       RCHA CT7
       ETTA
       TRA BSF+1
       TIX BSF2,1,1
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP BSF
       REM
       LXA K6,1       L +17 IN XRA
BSF3   BSFA 1
       TIX BSF3,1,1
       RTDA 1         READ OVER END OF FILE
       RCHA CT7
       LXA ONE,1      L +1 IN XRA - WDS PER REC
       LXA K6,2       L +17 IN XRB - NO. OF RECS
       CLA K6+6       L +20
       STO RECNO
       TCOA *         DELAY
       TRCA *+2       SHOULD NOT BE ON
       TRA *+2        OFF - OK
       TRA BSF4-8     ON - ERROR
       TEFA *+2       SHOULD XFER
       TRA BSF4-8
       STZ TEMP       CLEAR READ AREA
       RTBA 1
       RCHA CT7
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP BSF
       CLA TEMP       L WORD READ
       LDQ FIX+15     L WORD GENERATED IN MQ
       CAS FIX+15     COMPARE WORD GENERATED
       TRA BSF4
       TRA BSF4+1     OK
       TSX ERROR-2,4  BACKSPACE FILE ERROR-LONG
       TRA BSF
       TRA *+2
BSF4   TSX ERROR-4,4  BACKSPACE FIEL ERROR-SHORT
       TSX OK,4
       TRA BSF
       REM
*             FORM FIXED PATTERN
       REM
       BCD 1FRM       TEST ROUTINE
FRM    AXT 256,4      L +400 IN XRC
       AXT 4,1        L +4 IN XRA
       AXT 64,2       L +100 IN XRB
       CLA FIX+64,2
       STO WRFLD+256,4
       TIX *+1,4,1
       TIX *-3,2,1
       TIX *-5,1,1
       REM
*             COMPARE
       REM
       AXT 256,4      L +400 IN XRC
       AXT 4,1        L +4 IN XRA
       AXT 64,2       L +100 IN XRB
       CLA WRFLD+256,4
       LDQ FIX+64,2
       CAS FIX+64,2
       TRA *+2
       TRA FRM2
       SXA TEMP,4     SAVE XRC
       TSX ERROR-1,4  FAILED TO FORM FIXED
       REM            PATTERN CORRECTLY - MAIN
       REM            FRAME ERROR
       REM            IF SENSE LIGHT 1 IS ON
       REM            PROGRAM IS IN BCD SECTION
       TRA FRM
       LXA TEMP,4     RESET XRC
FRM2   TIX *+1,4,1
       TIX *-10,2,1
       TIX *-12,1,1
FRM3   TRA WTB
       REM
       REM
*             TEST WRITING IN BINARY MODE
       REM
       BCD 1WTBA 1    TEST INSTRUCTION
WTB    TRA *+2
       REWA 1
WTB1   TRCA *+1       TURN OFF TRC IND IF ON
       WEFA 1         WRITE END OF FILE
       REM
*             WRITE ONE 400 WORD RECORD
       REM
       WTBA 1         WRITE IN BINARY MODE
       RCHA CT16      ONE 400 WORD RECORD
       ETTA           PHYSICAL END OF TAPE TEST
       TRA WTB+1      YES - ED OF TAPE
       TSX RDNCK,4    REDUNDANCY ERROR
       TRA WTB
       TRA RTB1
       REM
       REM
       REM
*             TEST READING IN BINARY MODE
       REM
       BCD 1RTBA 1    TEST INSTRUCTION
RTB    TRA WTB1
RTB1   BSFA 1
       TRCA *+1       TURN OFF TRC IND IF ON
       TEFA *+1       TURN OFF EOF IND IF ON
       TSX CLR,4      GO TO CLEAR READ FIELD
       REM
*             READ ONE 400 WORD RECORD
       REM
       RTBA 1         READ OVER
       RCHA CT7       END OF FILE
       TCOA *         DELAY
       TEFA *+4       SHOULD BE ON
       TSX ERROR-1,4  FAILED TO WRITE OR READ
       TXL RTB,4      EOF CORRECTLY
       REM            POSSIBLE BACKSPACE ERROR
       TRA RWC2+1
       RTBA 1         READ TAPE IN BINARY MODE
       RCHA CT18
       TSX RDNCK,4    REDUNDANCY ERROR CHECK
       TRA RTB
       REM
*             COMPARE
       REM
RWC    CLA TWO        L +2
       STO RECNO
       CLA K2+9       L +401
       STO WDNO
       AXT 256,1      L +400 IN XRA
       AXT 1,2        L +2 IN XRB
RWC1   CLA RDFLD+256,1 L WORD READ
       CAS WRFLD+256,1 COMPARE WORD GENERATED
       TRA *+2
       TRA RWC2       OK
       LDQ WRFLD+256,1 L WORD GENERATED IN MQ
       TSX ERROR-2,4  COMPARISON ERROR
       NOP RTB
RWC2   TIX RWC1,1,1   DECREMENT WD READ COUNT
       TSX OK,4
       TRA RTB
       REM
       REM
*             WRITE 100 ONE WORD RECORDS
       REM
       BCD 1WTBA 1    TEST INSTRUCTION
WTB2   TRA *+2
       REWA 1
       AXT 64,2       L +100 IN XRB
       WEFA 1         WRITE END OF FILE
       CLA CT22A      L IOC WRFLF,0,1
       STO CT22
       CLA K6+4       L +101
       STO RECNO
       CLA TWO        L +2
       STO WDNO
       AXT 1,1        L +1 IN XRA
WTB3   TRCA *+1       TURN OFF TRC IND IF ON
       WTBA 1         WRITE IN BINARY MODE
       RCHA CT22      ONE RECORD
       TCOA *         DELAY
       TRCA *+2       TEST FOR REDUNDANCY CHECK
       TRA WTB4
       BSRA 1
       STZ TEMP       CLEAR READ AREA
       RTBA 1         READ TAPE IN BINARY MODE
       RCHA CT7
       TCOA *         DELAY
       CLA TEMP       L WORD READ
       LDQ WRFLD+64,2 L WORD GENERATED IN MQ
       TSX ERROR-2,4  REDUNDANCY ERROR
       NOP WTB2
       BSRA 1
       WTBA 1         WRITE TAPE IN BINARY MODE
       RCHA CT22
WTB4   CLA CT22
       ADD ONE        L +1
       STO CT22
       ETTA           PHYSICAL END OF TAPE TEST
       TRA WTB2+1
       TCOA *         DELAY
       TIX WTB3,2,1
       REM
       TSX OK,4
       TRA WTB2+2
       REM
       REM
*             READ 100 ONE WORD RECORDS
       REM
       BCD 1RTBA 1    TEST INSTRUCTION
RTB2   BSFA 1
       TSX CLR,4      GO TO CLEAR READ FIELD
       CLA CT23A
       STO CT23
       AXT 1,1        L +1 IN XRA
       AXT 64,2       L +100 IN XRB
       CLA TWO         L +2
       STO WDNO
       CLA K6+4       L +101
       STO RECNO
       RTBA 1         READ OVER
       RCHA CT7       END OF FILE
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP RTB2
       TEFA *+4       SHOULD BE ON
       TSX ERROR-1,4  FAILED TO WRITE OR READ
       TXL RTB2,4     EOF CORRECTLY
       REM            POSSIBLE BACKSPACE ERROR
       TRA RTB6+5
       REM
RTB3   RTBA 1         READ TAPE IN BIN MODE
       RCHA CT23      FIRST READ
       TCOA *         DELAY
       TRCA *+8       TEST FOR REDUNDANCY CHECK
       CLA RDFLD+64,2 L WORD READ
       CAS WRFLD+64,2 COMPARE WORD GENERATED
       TRA *+2        ERROR
       TRA RTB6
       LDQ WRFLD+64,2 L WORD GENERATED IN MQ
       TSX ERROR-2,4  ERROR ON FIRST READ
       NOP RTB2
       BSRA 1
       RTBA 1         READ TAPE IN BINARY MODE
       RCHA CT23      SECOND READ
       TCOA *         DELAY
       CLA RDFLD+64,2 L WORD READ
       CAS WRFLD+64,2 COMPARE WORD GENERATED
       TRA *+2
RTB4   TRA RTB5
       TRCA RTB5+2    TEST FOR REDUNDANCY CHECK
       LDQ WRFLD+64,2 L WORD GENERATED IN MQ
       TSX ERROR-2,4  COMPARISON ERROR
       NOP RTB2
       TRA RTB6
RTB5   TRCA *+2       TEST FOR REDUNDANCY CHECK
       TRA *+4
       LDQ WRFLD+64,2 L WORD GENERATED IN MQ
       TSX ERROR-2,4  REDUNDANCY ERROR
       NOP RTB2
RTB6   CLA CT23
       ADD ONE        L +1
       STO CT23
       TCOA *         DELAY
       TIX RTB3,2,1   DECREMENT RECORD COUNT
       TSX OK,4
       TRA RTB2
       REM
       NOP
RTB7   TRA BCD
       REM
       REM
*             PERFORM BCD WRITE AND READ TEST
       REM
BCD    CLA K9         L +012301230123
       STO FIX+9
       STO FIX+14
       STO FIX+41
       STO FIX+46
       CLA WTB1+2
       SUB K6+6       L +20
       STA WTB1+1
       STA WTB1+2
       STA WTB2+3
       STA WTB3+1
       STA WTB3+8
       STA WTB4-2
       STA RTB1+4
       STA RTB1+11
       STA RTB3-8
       STA RTB3
       STA RTB3+12
       CLA BCDA       L BCD 1WTDA 1
       STO WTB-1
       STO WTB2-1
       CLA BCDA+2     L BCD 1RTDA 1
       STO RTB-1
       STO RTB2-1
       CLA K7         L TRA BCD1
       STO RTB7
       SLN 1          TURN ON SENSE LIGHT 1
       TRA FRM
       REM
       REM
BCDA   BCD 1WTDA 1    USED AS CONSTANT
       WTDA 1         DETERMINANT FOR IOM
       REM
       BCD 1RTDA 1
       WTDA 1         DETERMINANT FOR IOM
       REM
       BCD 1WTBA 1
       WTBA 1         DETERMINANT FOR IOM
       REM
       BCD 1RTBA
       WTBA 1         DETERMINANT FOR IOM
       REM
       REM
BCD1   CLA K9+1       L +17171717171717
       STO FIX+14
       CLA K9+2       L +17575757575757
       STO FIX+46
       CLA K9+3       L +12121212121212
       STO FIX+9
       CLA K9+4       L +12525252525252
       STO FIX+41
       CLA WTB1+2
       ADD K6+6       L +20
       STA WTB1+1
       STA WTB1+2
       STA WTB2+3
       STA WTB3+1
       STA WTB3+8
       STA WTB4-2
       STA RTB1+4
       STA RTB1+11
       STA RTB3-8
       STA RTB3
       STA RTB3+12
       CLA K7+2       L TRA BCD2
       STO FRM3
       TRA FRM
       REM
       REM
BCD2   CLA BCDA+4     L BCD 1WTBA 1
       STO WTB-1
       STO WTB2-1
       CLA BCDA+6     L BCD 1RTBA 1
       STO RTB-1
       STO RTB2-1
       CLA K7+3       L TRA WTB
       STO FRM3
       CLA K7+1       L TRA BCD
       STO RTB7
       SLT 1          TURN OFF SENSE LIGHT 1
       TRA *+3
       TRA *+2
       REM
       REM
*             TEST READ UNDER IND 19 CONTROL
       REM
       BCD 1IND 19    TEST CONDITION
       REM
IN19   TRA *+2
       REWA 1
       WEFA 1         WRITE END OF FILE
       WTBA 1         WRITE ONE 100 WORD RECORD
       RCHA CT29      START WITH WRFLD
       ETTA           PHYSICAL END OF TAPE TEST
       TRA IN19+1
       TCOA *-2
       BSFA 1
       TSX CLR,4      GO TO CLEAR READ AREA
       REM
       RTBA 1         READ OVER
       RCHA CT7       END OF FILE
       TCOA *         DELAY
       TEFA *+4       SHOUL DBE ON
       TSX ERROR-1,4  FAILED TO WRITE OR READ
       TXL IN19,4     EOF CORRECTLY
       TRA IN19D
       REM
       REM
       RTBA 1
       RCHA CT29+2    READ 16 WORDS
       LCHA CT29+4    SPACE 16 WORDS
       LCHA CT29+6    READ 16 WORDS
       LCHA CT29+8    SPACE 16 WORDS
       REM
       AXT 64,1       L +100 IN XRA - NO OF WDS
       CLA K6+4       L +101
       STO WDNO
       CLA TWO
       STO RECNO
       AXT 1,2        L +1 IN XRB - NO OF RECS
       CLA TWO L +2
       STO TEMP       SAVE COUNT
       TCOA *         DELAY
       REM
IN19A  AXT 16,4       L +20 IN XRC - COUNTER
       CLA RDFLD+64,1
       CAS WRFLD+64,1
       TRA IN19B
       TRA *+2
       TRA IN19B
       TIX *+1,1,1    DECREMENT WORD COUND
       TIX *-6,4,1    DECREMENT COUNTER
       REM
       AXT 16,4       L +20 IN XRC - COUNTER
       CLA RDFLD+64,1
       CAS ZERO
       TRA IN19C
       TRA *+2
       TRA IN19C
       TIX *+1,1,1    DECREMENT WORD COUNT
       TIX *-6,4,1    DECREMENT COUNTER
       REM
       CLA TEMP
       SUB ONE        L +1
       TZE IN19D      TO OK
       STO TEMP
       TRA IN19A
       REM
IN19B  SXA TEMP1,4    SAVE COUNTER
       LDQ WRFLD+64,1
       TSX ERROR-2,4  FAILED TO READ OR WRITE
       NOP IN19       CORRECTLY
       LXA TEMP1,4    RELOAD COUNTER
       TRA IN19A+6
       REM
IN19C  SXA TEMP1,4    SAVE COUNTER
       LDQ WRFLD+64,1
       TSX ERROR-2,4  WORD READ SHOULD BE ZERO
       NOP IN19       WORD GENERATED SHOWS WORD
       REM            WHICH SHOULD HAVE BEEN
       REM            SPACED OVER BY IND 19
       REM            CONTROL
       LXA TEMP1,4    RELOAD COUNTER
       TRA IN19A+14
       REM
IN19D  TSX OK,4
       TRA IN19
       REM
       REM
*             TEST BACKSPACE WRITE
       REM
       BCD 1WTBA 1
BWB    TRA *+2
       REWA 1
       WEFA 1         WRITE END OF FILE
       CLA K6+4       L +101
       STO RECNO
       AXT 64,2       L +100 IN XRB
       CLA TWO        L +2
       STO WDNO
       AXT 1,1        L +1 IN XRA - WDS PER REC
       CLA CT22A
       STO CT22
       REM
BWB1   WTBA 1
       RCHA CT22
       TCOA *         DELAY
       TRCA *+1       TURN OFF TRC IND IF ON
       CLA CT22
       ADD ONE
       STO CT22
       WTBA 1
       RCHA CT22
       BSRA 1
       WTBA 1
       RCHA CT22
       ETTA
       TRA BWB+1
       TCOA *         DELAY
       TRCA *+2       TEST FOR REDUNDANCY CHECK
       TRA BWB2
       BSRA 1
       RTBA 1
       RCHA CT7
       TCOA *         DELAY
       CLA TEMP       L WORD READ
       LDQ WRFLD+65,2 L WORD GENERATED IN MQ
       TSX ERROR-2,4  REDUNDANCY ERROR
       NOP BWB
       REM
BWB2   CLA CT22
       ADD ONE
       STO CT22
       TIX BWB1,2,2   DECREMENT RECORD COUNT
       REM
       BSFA 1
       TSX CLR,4      GO TO CLEAR READ AREA
       RTBA 1         READ OVER
       RCHA CT7       END OF FILE
       RTBA 1
       RCHA CT18A
       CLA K6+4       L +101
       STO RECNO
       AXT 64,2       L +100 IN XRB
       TCOA *         DELAY
BWB3   CLA RDFLD+64,2 L WORD READ
       CAS WRFLD+64,2 COMPARE WORD GENERATED
       TRA *+2
       TRA BWB4       OK
       LDQ WRFLD+64,2 L WORD GENERATED IN MQ
       TSX ERROR-2,4  COMPARISON ERROR
       NOP BWB
BWB4   TIX BWB3,2,1   DECREMENT RECORD COUNT
       REM
       TSX OK,4
       TRA BWB
       REM
*             CHECK READ, BACKSPACE, READ
       REM
       BCD 1RTBA 1
RBR    BSFA 1
       LXA ONE,1      SET WORD COUNT
       CLA TWO         L +2
       STO WDNO
       AXT 64,2       L +100 IN XRB
       CLA K6+7
       STO RECNO
       CLA CT23A
       STO CT23
       RTBA 1         READ OVER END OF FILE
       RCHA CT7
RBR1   RTBA 1         READ TAPE IN BINARY MODE
       RCHA CT23
       CLA CT23
       ADD ONE        L +1
       STO CT23
       RTBA 1         READ OVER END OF FILE
       RCHA CT23
       BSRA 1
       RTBA 1         READ TAPE IN BINARY MODE
       RCHA CT23
       TCOA *         DELAY
       CLA RDFLD+65,2 L WORD READ
       CAS WRFLD+65,2 COMPARE WORD GENERATED
       TRA *+2
       TRA *+4        OK
       LDQ WRFLD+65,2 L WORD GENERATED IN MQ
       TSX ERROR-2,4  COMPARISON ERROR
       NOP RBR
       REM
       CLA CT23
       ADD ONE        L +1
       STO CT23
       TIX RBR1,2,2   DECREMENT RECORD COUNT
       TSX OK,4
       TRA RBR
       REM
       REM
*             WRITE, BACKSPACE, WRITE TO CHECK
*             FOR BACKSPACE CREEP ERROR
       REM
*             TEST BACKSPACE CREEP
*             WITH ONE WORD RECORDS
       REM
*             WRITE FOUR 1 WORD RECORDS
       REM
       BCD 1BSRA      TEST INSTRUCTION
BSW    TRA *+2
       REWA 1
       CLA CT1        L IOCD FIX,0,1
       STO CT28
       WEFA 1         WRITE END OF FILE
       REM
       AXT 4,2        L +4 IN XRB
BSW1   WTBA 1
       RCHA CT28
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP WTB
       CLA CT28
       ADD ONE
       STO CT28
       TIX BSW1,2,1
       REM
       ETTA           PHYSICAL END OF TAPE TEST
       TRA BSW+1
       REM
       AXT 4,1        L +4 IN XRA
       BSRA 1
       TIX *-1,1,1
       TSX CLR,4      GO TO CLEAR READ AREA
       REM
*             READ AND COMPARE
       REM
       TEFA *+1       TURN OFF TEF IND IF ON
       AXT 4,2        L +4 IN XRB - NO OF RECS
       AXT 1,1        L +1 IN XRA - WDS PER REC
       CLA FIVE       L +5
       STO RECNO
       CLA TWO
       STO WDNO
       REM
       RTBA 1
       RCHA CT28A
       TCOA *         DELAY
       TEFA BSW4      SHOULD NOT XFER
BSW2   CLA RDFLD+4,2  L WORD READ
       CAS FIX+4,2    COMPARE WORD GENERATED
       TRA *+2
       TRA *+4        OK
       LDQ FIX+4,2    L WORD GENERATED IN MQ
       TSX ERROR-2,4  COMPARISON ERROR IN RD-WR
       NOP RTB
       TIX BSW2,2,1
       REM
*             BACKSPACE AND REWRITE FORTH RECORD
*             15 TIMES
       REM
       AXT 15,1       L +17 IN XRA
BSW3   BSRA 1
       WTBA 1
       RCHA CT28B
       TIX BSW3,1,1
       REM
       BSRA 1
       BSRA 1
       RTBA 1
       RCHA CT7
       TCOA *         DELAY
       TEFA *+2       SHOULD NOT XFER
       TRA *+4
BSW4   TSX ERROR-1,4  BKSP LONG OVER EOR GAPS
       REM            TO BEGINNING OF FILE
       TXL BSW,4
       TRA BSW5
       REM
       AXT 3,2        L +3 IN XRB
       AXT 1,1        L +1 IN XRA
       CLA TEMP       L WORD READ
       CAS FIX+2      COMPARE WORD GENERATED
       TRA BSW5-2
       TRA BSW5
       LDQ FIX+2      L WORD GENERATED IN MQ
       TSX ERROR-2,4  BACKSPACE LONG
       NOP BSW
       TRA *+3
       REM
       LDQ FIX+2      L WORD GENERATED IN MQ
       TSX ERROR-4,4  BACKSPACE SHORT
BSW5   TSX OK,4
       TRA BSW
       REM
       REM
*             TEST BACKSPACE CREEP
*             WITH 400 WORD RECORDS
       REM
*              WRITE FOUR 400 WORD RECORDS
       REM
       BCD 1BSRA 1    TEST INSTRUCTION
       TRA *+2
       REWA 1
       AXT 4,4        L +4 IN XRC
       CLA CT1        L IOCD FIX,0,1
       STA CT22C
       STA CT28
BSW6   LXA K2+8,1     L +375 IN XRA
       WTBA 1
       RCHA CT22C
       LCHA CT22C
       LCHA CT22C
       TIX *-1,1,1
       LCHA CT28
       TCOA *         DELAY
       CLA CT22C
       SUB ONE        L +1
       STA CT22C
       STA CT28
       ETTA           PHYSICAL END OF TAPE TEST
       TRA BSW6-5
       TIX BSW6,4,1
       REM
       AXT 4,1        L +4 IN XRA
       BSRA 1
       TIX *-1,1,1
       REM
       TSX CLR,4      GO TO CLEAR READ AREA
       REM
*             READ AND COMPARE
       REM
       TEFA *+1       TURN OFF TEF IND IF ON
       AXT 4,2        L +4 IN XRB - NO OF RECS
       CLA FIVE       L +5
       STO RECNO
BSW7   CLA K2+6       L +400
       PAX 0,1        L +400 IN XRA
       ADD ONE
       STO WDNO
       RTBA 1
       RCHA CT22D
       TCOA *         DELAY
       TEFA BSW10     SHOULD NOT XFER
BSW8   CLA RDFLD+256,1 L WORD READ
       LDQ FIX+4,2    L WORD GENERATED
       CAS FIX+4,2    COMPARE WORD GENERATED
       TRA *+2
       TRA *+3        OK
       TSX ERROR-2,4  COMPARISON ERROR IN RD-WR
       NOP RTB
       TIX BSW8,1,1
       TIX BSW7,2,1
       REM
*             BACKSPACE AND REWRITE FORTH RECORD
*             15 TIMES
       REM
       AXT 15,4       L +17 IN XRC
BSW9   BSRA 1
       LXA K2+8,1     L +375 IN XRA
       WTBA 1
       RCHA CT22E
       LCHA CT22E
       LCHA CT22E
       TIX *-1,1,1
       LCHA CT22F
       TIX BSW9,4,1
       REM
       BSRA 1
       BSRA 1
       RTBA 1
       RCHA CT7
       TCOA *         DELAY
       TEFA *+2       SHOULD NOT XFER
       TRA *+4
BSW10  TSX ERROR-1,4  BKSP LONG - OVER EOR GAPS
       REM            TO BEGINNING OF FILE
       TXL BSW6-6,4
       TRA BSW11      OK
       CLA TEMP       L WORD READ
       LDQ FIX+2      L WORD GENERATED IN MQ
       CAS FIX+2      COMPARE WORD GENERATED
       TRA *+5
       TRA BSW11      OK
       TSX ERROR-2,4  BACKSPACE LONG
       NOP BSW6-6
       TRA *+2
       TSX ERROR-4,4  BACKSPACE SHORT
BSW11  TSX OK,4
       TRA BSW6-6
       REM
       REM
*             CHECK WRITING AND RECOGNITION
*             OF EXTRA-LONG RECORD GAPS
       REM
       BCD 1LRG       TEST IDENTIFICATION
LRG    TRA *+2
       REWA 1
       SLF            TURN OFF ALL SENSE LIGHTS
       TRCA *+1       TURN OFF TRC IND IF ON
       TEFA *+1       TURN OFF TEF IND IF ON
       TSX CLR,4      GO TO CLEAR READ AREA
       REM
       WEFA 1         WRITE END OF FILE
       WTBA 1         WRITE 1ST 8 WORD RECORD
       RCHA CT24      STARTING WITH FIX, 1ST
       REM            LONG RECORD GAP,AND 2ND
       REM            8 WORD RECORD STARTING
       REM            WITH FIX+8.   ALL
       REM            WRITTEN BY TGR CONTROL
       REM
       WTBA 1         WRITE 2ND LONG RECORD GAP
       TCOA *         BY WRS AND NO CHN INSTR
       REM
       WTBA 1         WRITE THIRD 8 WORD RECORD
       RCHA CT24+4    STARTING WITH FIX+16
       WEFA 1         WRITE END OF FILE
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP LRG
       ETTA           PHYSICAL END OF TAPE TEST
       TRA LRG+1
       BSRA 1         BKSP OVER END OF FILE
       BSFA 1         BKSP OVER THREE RECORDS
       REM            AND TAPE MARK
       TSX CLR,4      GO TO CLEAR READ FIELD
       RTBA 1
       RCHA CT24+6    READ OVER END OF FILE
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP LRG
       TEFA LRG1      SHOULD XFER
       REM
       AXT 1,1        L +1 IN XRA
       AXT 1,2        L +1 IN XRB
       CLA TWO        L +2
       STO WDNO
       STO RECNO
       CLA RDFLD      L WORD READ - SHOULD
       LDQ ZERO       BE ZERO
       TSX ERROR-2,4  FAILED TO RECOGNIZE
       NOP LRG        INITIAL END OF FILE OR
       REM            POSSIBLE BKSP ERROR
LRG1   RTBA 1         SHOULD READ THREE
       RCHA CT24+6    8 WORD RECORDS
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP LRG1
       TEFA *+2       SHOULD NOT XFER
       TRA *+3
       TSX ERROR-1,4  FALSE EOF INDICATION
       NOP LRG
       REM
       AXT 3,2        L +3 IN XRB
       CLA FOUR       L +4
       STO RECNO
       AXT 24,1       L +30 IN XRA
       CLA K3+6       L +31
       STO WDNO
       REM
       AXT 8,4        L +10 IN REC
LRG2   CLA RDFLD+24,1 L WORD READ
       CAS FIX+24,1   COMPARE WORD GENERATED
       TRA *+2        ERROR
       TRA LRG3
       LDQ FIX+24,1
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  READ-WRITE ERROR
       NOP LRG
       LXA XRC,4      RESET XRC
LRG3   TIX *+1,1,1
       TIX LRG2,4,1
       TIX LRG2-1,2,1
       TRA LRG4
       REM
       BCD 1BSRA 1    TEST INSTRUCTION
LRG4   BSRA 1         BKSP OVER 3RD RECORD
       TSX CLR,4      GO TO CLEAR READ AREA
       RTBA 1         READ 3RD RECORD
       RCHA CT24+8
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP LRG
       AXT 3,2        L +3 IN XRB
       AXT 1,1        L +1 IN XRA
       CLA TWO        L +2
       STO WDNO
       CLA RDFLD+16   L WORD READ
       CAS FIX+16     COMPARE WORD GENERATED
       REM            1ST WORD OF 3RD RECORD
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ FIX+16     L WORD GENERATED IN MQ
       TSX ERROR-2,4  ERROR IN READING 3RD REC
       NOP LRG
       TEFA *+2       SHOULD NOT XFER
       TRA *+4        OK
       TSX ERROR-1,4  FALSE EOF INDICATION
       TXL LRG,4
       TRA LRG5       TO OK
       REM
       BSRA 1         BKSP OVER 3RD RECORD
       BSRA 1         BKSP OVER 2ND RECORD
       TSX CLR,4      GO TO CLEAR READ AREA
       RTBA 1         READ SECOND AND
       RCHA CT24+7    THIRD RECORDS
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP LRG
       AXT 2,2        L +2 IN XRB
       CLA RDFLD+8    L WORD READ
       CAS FIX+8      COMPARE WORD GENERATED
       REM            1ST WORD OF 2ND RECORD
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ FIX+8      L WORD GENERATED IN MQ
       TSX ERROR-2,4  ERROR IN READING 2ND REC
       NOP LRG        OR ERROR IN BKSP
       TEFA *+2       SHOULD NOT XFER
       TRA *+4        OK
       TSX ERROR-1,4  FALSE RECOGINITION OF LONG
       TXL LRG,4      RECORD GAP WRITTEN BY WRS
       REM            AND DELAY
       TRA LRG5       TO OK
       REM
       BSRA 1         BKSP OVER 3RD RECORD
       BSRA 1         BKSP OVER 2ND RECORD
       BSRA 1         BKSP OVER 1ST RECORD
       TSX CLR,4      GO TO CLEAR READ FIELD
       RTBA 1         READ THREE
       RCHA CT24+6    8 WORD RECORDS
       TSX RDNCK,4    REDUNDANCY TAPE CHECK
       NOP LRG
       AXT 1,2        L +1 IN XRA
       CLA RDFLD      L WORD READ
       CAS FIX        COMPARE WORD GENERATED
       REM            1ST WORD OF 1ST RECORD
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ FIX        L WORD GENERATED IN MQ
       TSX ERROR-2,4  ERROR IN READING 1ST REC
       NOP LRG        OR ERROR IN BKSP
       TEFA *+2       SHOULD NOT XFER
       TRA *+3        OK
       TSX ERROR-1,4  FALSE RECOGNITION OF LONG
       TXL LRG,4      RECORD GAP WRITTEN UNDER
       REM            INDICATOR CONTROL
LRG5   TSX OK,4
       TRA LRG
       REM
       REM
*             TESTS USING RANDOM NUMBER PATTERNS
       REM
       NOP
       SLF            TURN OFF ALL SENSE LIGHTS
       REM
*             WRITE RANDOM BINARY RECORDS
       REM
B19    TRA *+2
       REWA 1
       LXA K3+4,1     L10
       CAL K10+8,1    INITIALIZE RANDOM
       SLW K11+8,1    GENERATOR
       TIX  *-2,1,1
       TRA B20
       REM
       BCD 1WTBA 1
B20    WEFA 1         WRITE END OF FILE
       REM
       LXA K2,2       L NO. OF RECORDS IN XRB
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
B23    TSX RDNCK,4    REDUNDANCY CHECK
       NOP B20        IF A TAPE CHECK OCCURS
       REM            THRERE WILL BE NO
       REM            ATTEMPT TO REWRITE THE
       REM            RECORD
       CLA K11+7
       LBT
       TRA B29        DO NOT BACKSPACE READ
       TRA B25
       REM
*             BACKSPACE AND READ AFTER WRITING
*                   CURRENT RECORD
       BCD 1RTBA 1
B25    BSRA 1         BKSP OVER CURRENT RECORD
       TSX CLR,4      GO TO CLEAR READ AREA
       RTBA 1         READ RECORD WRITTEN
       RCHA CT12
       REM
B26    TSX RDNCK,4    CHECK REDUNDANCY TAPE
       NOP B25
       REM
       TSX GEN3,4
       LXA WDCT,1     WORD COUNT
       CLA WDCT       L NUMBER OF WORDS
       ADD ONE        L +1
       STO WDNO
B27    CLA 0,1        L WORD READ
       LDQ 0,1        L WORD GENERATED IN MQ
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2        COMPARISON ERROR
       TRA *+3
       TSX ERROR-2,4  COMPARISON ERROR
       NOP B25
       REM
       TIX B27,1,1    DECREMENT WORD NUMBER
       REM
B28    ETTA           END OF TAPE TEST
       TRA B19+1
       REM
B29    TIX B21A,2,1   DECREMENT RECORD NUMBER
       WEFA 1         WRITE END OF FILE
       REM
*             RESET RANDOM GENERATOR
       REM
       LXA K3+4,1     L10
       CAL K10+8,1    INITIALIZE RANDOM
       SLW K11+8,1    GENERATOR
       TIX *-2,1,1
       TRA B30
       REM
*             BACKSPACE FILE AND READ RANDOM REC
       REM
       BCD 1RTBA 1
B30    BSFA 1         BACKSPAE OVER TAPE MARK
       BSFA 1         BACKSPACE ONE FILE
       TRCA *+1       TURN TAPE CHECK OFF
       IOT            TURN INPUT-OUTPUT CHECK
       NOP
       RTBA 1         READ OVER END OF FILE
       RCHA CT7
       TCOA *         DELAY
       TEFA *+1       TURN OFF EOF IND
       REM            SHOULD BE ON
       REM
       REM
B31    LXA K2,2       L NO. OF RECORDS IN XRB
       CLA K2         L NUMBER OF RECORDS
       ADD ONE        L +1
       STO RECNO
B31A   TSX GEN1,4     GENERATE RANDOM RECORD
       TSX CLR,4      GO TO CLEAR READ AREA
       TRCA *+1       TURN OFF RDNCY IND IF ON
       RTBA 1         READ TAPE BINARY
       RCHA CT12      TRANSFER CONTROL WORD
       REM            TO BUFFER
       REM
B34    TSX RDNCK,4
       NOP B30
       TSX GEN3,4     FORM COMPARE ADDRESSES
       REM
       LXA WDCT,1     WORD COUNT
       CLA WDCT       L NUMBER OF WORDS
       ADD ONE        L +1
       STO WDNO
       REM
B35    CLA 0,1        L WORD READ
       LDQ 0,1        L WORD GENERATED IN MQ
       CAS 0,1        COMPARE WORD GENERATED
       TRA B36        ERROR
       TRA B36+3
       REM
B36    TSX ERROR-2,4
       NOP B30
       REM
       SLN 2          TURN ON SL2 ON ERROR
       TIX B35,1,1    DECRMENT WORD COUNT
       SLT 2          TEST SL2
       TRA B36B
       CAL K11+7
       PBT
       TRA B36B       DO NOT BACKSPACE READ
       REM
*             BACKSPACE AND READ AFTER READING
*             CURRENT LAST RECORD
       REM
       BSRA 1
       TSX CLR,4      GO TO CLEAR READ AREA
       RTBA 1
       RCHA CT12
       TSX RDNCK,4    CHECK REDUNDANCY
       NOP B30
       TSX GEN3,4
       LXA WDCT,1
       CLA WDCT
       ADD ONE        L +1
       STO WDNO
B36A   CLA 0,1        L WORD READ
       LDQ 0,1        L WORD GENERATED IN MQ
       CAS 0,1        COMPARE WORD GENERATED
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
       REM
       TSX ERROR-1,4  FALSE EOR READ AT EOF
       NOP B37
       REM
B37A   TEFA *+3       EOF SHOULD BE ON
       TSX ERROR-1,4  FAILED TO READ EOF
       NOP B37
       REM
       TSX OK,4
       TRA B19
       REM
       NOP
       REWA 1         REWIND TEST FRAME
       TRA PASS
       REM
       REM
*             RANDOM NUMBER GENERATOR
       REM
GEN1   LDQ K11+7      RANDOM NUMBER GENERATOR
       CLA ZERO       CLEAR ACC
       LGL 8          SHIFT FOR RANDOM NO OF WDS
       REM            MAXIMUM OF 377
       ADD K3         L+1
       PAX 3,1        FORM NO.OF WORDS PER REC
       SXA WDCT,1
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
GEN3   CLA K3+2       INITIAL ADDR OF RDFLD
       ADD WDCT       WORD COUNT
       STA B27
       STA B35
       STA B36A
       CLA K3+1       INITIAL ADDR OF WRFLD
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
*             UTILITY SUB-ROUTINES
       REM
       REM
*             ADJUST UNTILITY PRINT ROUTINES FOR DESIRED CHANNEL
       REM
ADJ    AXT 3,1        SAVE
       CLA CTRL1+3,1  I-O CONTROL
       STO TEMP+3,1   WORDS FOR
       TIX *-2,1,1    ALL CHANNELS
       REM
       TSX IOC,4      TO ENTER CONTROL WORD FOR
       REM            PRINTER ON DESIRED CHANNEL
       REM
       TSX CTX,4
       HTR CH14-1,0,CH14+1
       TSX CTX,4
       HTR WPRA-1,0,WPRA+6
       TSX CTX,4
       HTR IDNT+2,0,TCTX
       REM
       AXT 3,1        RESET
       CLA TEMP+3,1   I-O CONTROL
       STO CTRL1+3,1  WORDS FOR
       TIX *-2,1,1    ALL CHANNELS
       REM
       HTR RUC        GO TO RESET UNIT COUNT
       REM            AND REENTER PROGRAM
       REM
       REM
*             CLEAR READ FIELD
       REM
CLR    AXT 256,1      L +400 IN XRA
       STZ RDFLD+256,1
       TIX *-1,1,1
       TRA 1,4        RETURN TO PROGRAM
       REM
       REM
*             PRINT - NOW PERFORMING DIAGNOSTIC TEST 9T01
IDNT   SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS PRINT
       REM
       WPRA 1
       SPRA 3         DOUBLE SPACE
       RCHA CT26A
       CLA K2+5       L TRA AA
       STO 24
       TRA IDN+1
       REM
       REM
*             PRINT - PASS COMPLETE
       REM
PASS   SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA TCTX       BYPASS PRINT
       REM
       LXA K2+4,1     L +22 IN XRA
       CAL K8+1       L -343677616030
       ANS PR1+22,1
       TIX *-2,1,2
       REM
       CLA BSR3       L READ CURRENT TAPE UNIT
       STO TEMP
       ANA K6         L +17
       PAI            L INDS FROM ACC
       RNT 00012
       TRA PASS2
       AXT 4,1        L +4 IN XRA
       CLA ONE        L LOW BIT
       ORS PR1+18,1
       AXT 2,1        L +2 IN XRA
       CLA TWO        L HIGH BIT
       ORS PR1+18,1
       TRA PASS3
       REM
PASS2  CLA TEMP
       ANA K6         L +17
       ALS 1          DOUBLE INCREMENT
       PAX 0,1
       CLA ONE        L ONE BIT
       ORS PR1+18,1
       AXT 0,1        L +0 IN XRA
       CLA TWO        L HIGH BIT
       ORS PR1+18,1
       REM
PASS3  CLA TEMP
       ANA K2+7
       ARS 8          MOVE TO LOW ORDER + DOUBLE
       PAX 0,1
       CLA K2+6       L +400  BIT TO PRINT CHN
       ORS PR118,1
       REM
       WPRA 1
       RCHA CT26
       REM
TCTX   TSX CTX,4      GO TO ADJUST CHN AND UNIT
       HTR AA,0,B37A+7
       TRA AC
       REM
       REM
FINL   SWT 6
       TRA *+2
       TRA IDN+1      REPEAT TEST AFTER STOP TO
       REM            LOAD NEW CONTROL WORD FROM
       REM            KEYS FOR CHANNELS + UNITS
       REM            NOTE - REPLACE THIS INSTR
       REM            WITH TRA RUC TO LOOP
       REM            CONTINUOUSLY ON SAME UNITS
       RCDA           SELECT CARD READER
       RCHA FNLX      READ IN
       LCHA 0         NEXT
       TRA 1          PROGRAM
       REM
FNLX   MON 0,0,3
       REM
       REM
       REM
*             CONSTANTS
       REM
       REM
ONES   OCT -377777777777
ZERO   OCT 000000000000
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
CT1    IOCD FIX,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT2    IOCD RDFLD,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT3    IOSP FIX,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT4    IOCD RDFLD,0,2
       HTR 0          PROGRAM PROTECT - I-O DISC
CT4A   IOCD RDFLD+2,0,2
       HTR 0          PROGRAM PROTECT - I-O DISC
CT5    IORP ONES,0,1
CT6    IORP FIX,0,1   WRITE TWO 1 WORD RECORDS
       IOCD FIX+1,0,1 FROM FIX AND FIX+1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT6A   IORP FIX+2,0,1 WRITE TWO 1 WORD RECORDS
       IOCD FIX+3,0,1 FROM FIX+2 AND FIX+3
       HTR 0          PROGRAM PROTECT - I-O DISC
CT7    IOCD TEMP,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
       IOCD TEMP1,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
       IOCD TEMP2,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT8    IOCD ONES,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT10   IOCD WRFLD     CONTROL WORD FOR
       REM            WRITE RANDOM BINARY
       HTR 0          RECORDS
CT12   IOCD RDFLD,0,0 CONTROL WORD FOR READ
       HTR            REC BINARY
*             NOTE- WORD COUNT STORED IN DECREMENT OF
*                   CT10 AND CT12 BY GEN1
CT16   IOCD WRFLD,0,256
       HTR 0          PROGRAM PROTECT - I-O DISC
CT17   IOCD FIX,0,64
       HTR 0          PROGRAM PROTECT - I-O DISC
CT18   IOCD RDFLD,0,256
       HTR 0          PROGRAM PROTECT - I-O DISC
CT18A  IOCD RDFLD,0,64
       HTR 0          PROGRAM PROTECT - I-O DISC
CT20   IOCD FIX-3,0,13
       HTR 0          PROGRAM PROTECT - I-O DISC
CT21   IOCP RDFLD+10,0,3
       IOCD RDFLD,0,10
       HTR 0          PROGRAM PROTECT - I-O DISC
CT22   IOCD WRFLD,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT22A  IOCD WRFLD,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT22C  IOCT FIX,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT22D  IOCD RDFLD,0,256
       HTR 0          PROGRAM PROTECT - I-O DISC
CT22E  IOCT FIX+3,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT22F  IOCD FIX+3,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT23   IOCD RDFLD,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT23A  IOCD RDFLD,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT24   IORP FIX,0,8
       IORP FIX+32,0,0
       IOCD FIX+8,0,8
       HTR 0          PROGRAM PROTECT - I-O DISC
       IOCD FIX+16,0,8
       HTR 0          PROGRAM PROTECT - I-O DISC
       IOCP RDFLD,0,8
       IOCP RDFLD+8,0,8
       IOCD RDFLD+16,0,8
       HTR 0          PROGRAM PROTECT - I-O DISC
CT25   IOCD RDFLD,0,8
       HTR 0          PROGRAM PROTECT - I-O DISC
       IOCD RDFLD+8,0,8
       HTR 0          PROGRAM PROTECT - I-O DISC
       IOCD RDFLD+16,0,8
       HTR 0          PROGRAM PROTECT - I-O DISC
       IOCD RDFLD+24,0,8
       HTR 0          PROGRAM PROTECT - I-O DISC
CT26   IOCD PR1,0,24
       HTR 0          PROGRAM PROTECT - I-O DISC
CT26A  IOCD PRIDN,0,24
       HTR 0          PROGRAM PROTECT - I-O DISC
CT28   IOCD FIX,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT28A  IOCD RDFLD,0,4
       HTR 0          PROGRAM PROTECT - I-O DISC
CT28B  IOCD FIX+3,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
CT29   IOCD WRFLD,0,64
       HTR +0         PROGRAM PROTECT - I-O DISC
       IOCT RDFLD,0,16
       HTR +0         PROGRAM PROTECT - I-O DISC
       IOCT RDFLD+16,2,16
       HTR +0         PROGRAM PROTECT - I-O DISC
       IOCT RDFLD+32,0,16
       HTR +0         PROGRAM PROTECT - I-O DISC
       IOCD RDFLD+48,2,16
       HTR +0         PROGRAM PROTECT - I-O DISC
CT30   IORP KK1,0,1
       IORP K9+1,0,1
       IOCD KK1+2,0,1
       HTR 0          PROGRAM PROTECT - I-O DISC
       REM
       REM
       IOCD RDFLD,0,10
       TCOA 1         DELAY
       TRA LTB
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
FIX1   OCT +007777777777  MASK FOR MULTI-FILE
       REM
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
       OCT +000102000000  4 L
       OCT +0
       OCT +000000012444  3 L
       OCT +0
       OCT +000000020100  2 L
       OCT +0
       OCT +000000400001  1 L
       OCT +0
       OCT +040000030546  0 L
       OCT +0
       OCT +312720140000  11 L
       OCT +0
       OCT +005053606200  12 L
       OCT +0
       REM
PR1    OCT -000000000000  9 ROW LEFT
       OCT +0             9 ROW RIGHT
       OCT +000000004000  8 L
       OCT +0
       OCT +002004000000  7 L
       OCT +0
       OCT +000020000010  6 L
       OCT +0
       OCT +000001202000  5 L
       OCT +0
       OCT +000010000000  4 L
       OCT +0
       OCT +200042410020  3 L
       OCT +0
       OCT +000600000000  2 L
       OCT +0
       OCT +041000000000  1 L
       OCT +0
PR118  OCT +300600400020  0 L
       OCT +0
       OCT +002036002000  11 L
       OCT +0
       OCT +001041214410  12 L
       OCT +0
       REM
       REM
CONST  OCT 00000000000
       OCT 00000000100
       OCT 00000000172
       OCT 00000000440
       OCT 00000000000
       OCT 00000000000
XRA    OCT 0
XRB    OCT 0
XRC    OCT 0
TEMP   OCT
TEMP1  OCT 00000000000
TEMP2  OCT 00000000000
TEMP3  OCT 00000000000
       HTR RDFLD,0,7
WDCT   OCT 0          WORD COUNT FORMED BY GEN1
       OCT            INITIAL WR ADDR + COUNT
       REM
TRA1   TRA AC
       REM
CTR1   OCT +760
CTR2   OCT +76000
       REM
KK1    OCT 000001010101
       OCT 000017171717
       OCT 000020202020
       REM
       REM
K2     OCT +200       RANDOM RECORD COUNT
       OCT 622
       OCT 300
       OCT 60
       OCT +26
       TRA AA         REPEAT PROGRAM
       OCT +400
       OCT +7000
       OCT +375
       OCT +401
K3     OCT +1
       HTR WRFLD
       HTR RDFLD
       HTR K11
       OCT 10
       OCT +30
       OCT +31
       OCT +377
K4     PTW RDFLD,0,30 TRIGGER 1 ON
       PZE K4+1      NO TRIGGERSON
       HTR
       PZE K4+1,0,K4+2
       IORP RDFLD,0,K4+1
       REM
K5     OCT 000000004043
K6     OCT +17
       OCT +1000
       OCT +1001
       OCT +100
       OCT +101
       OCT +36
       OCT +20
       OCT +102
K7     TRA BCD1
       TRA BCD
       TRA BCD2
       TRA WTB
       OCT 0         CONTROL WORD FOR CHN A
K8     OCT +377777777767
       OCT -343677616030  MASK FOR PASS PRINT
       RTBA 1
       RTBA 2
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
RDFLD  EQU WRFLD+256
       REM
       REM
ERROR  EQU 3396
OK     EQU 3401
RDNCK  EQU 3440
WDNO   EQU 3438
RECNO  EQU 3439
CH14   EQU 3636
WPRA   EQU 3845
       REM
CTRL1  EQU 2880
CTRL2  EQU 2881
CTRL3  EQU 2882
IOCT   EQU 2883
CTRA   EQU 2884
CTRB   EQU 2885
CTRC   EQU 2886
CTRD   EQU 2887
CTRE   EQU 2888
CTRF   EQU 2889
CTX    EQU 2890
IOCNT  EQU 2891
IOC    EQU 2892
       END
