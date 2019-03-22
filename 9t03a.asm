                                                             9 T 0 3 A
                                                            7-01-58
       REM
       REM
       REM
*                            9 T 0 3 A
       REM
*                      PERFORM TAPE MULTI-CHANNEL OPERATION
       REM
*                               729 TEST
       REM
       REM
       ORG 24
       REM
       NOP            THIS INSTR IS REPLACED BY
       REM            TRA RUC DURING 1ST PASS
       REM
       REM
       TSX PRID,4     GO TO PRINT TEST IDENTITY
       REM
       REM
       CLA TRA1       L TRA RUC
       STO 24
       REM
       TSX IOC,4      TO ENTER CONTROL WORDS
       REM
RUC    TSX IOCNT,4    TO RESET UNIT COUNT
       REM
       REM
*             CHECK FOR EXCLUSIVE TAPE FRAME BITS IN
*             I-O CONTROL WORDS AND ESTABLISH INITIAL
*             STATUS OF UNIT ADDRESSES
       REM
INTL   CLA CTRL1
       TPL *+4        CHECK FOR SIGN BIT SHOWING
       REM            PROGRAM READ FROM CARDS
       CLA WTBA+6     L WTBA 1 - BIT
       STO WTBA       OK FOR UNIT 1
       TRA *+5
       CLA WTBA+7     L WTBA 2 - NO BIT
       STO WTBA       BLOCK OUT UNIT 1
       CLA RTBA       L RTBA 1
       STO FINL1
       CLA TRA4       L TRA STPA
       STO INTL4
       REM
       AXT 6,2        L +6 IN XRB
       AXT 3,1        L +3 IN XRA
       REM
       AXT 2,4        L +2 IN XRC
INTL2  NZT CTRA+6,2   CHECK IF CHANNEL CALLED
       TRA INTL5      NO - GO TO CHK NEXT CHN
INTL3  CLA CTRL1+3,1
       ANA MASK+2,4   CLEAR TO EXCLUSIVE BIT
       TNZ INTL4-3    YES - GO TO SET EXCLU UNIT
       CLA* NDRA+6,2  L WRITE TAPE CURRENT UNIT
       CAS WTBA+6,2   COMPARE WRITE UNIT ONE
       TRA *+2        NO
       TRA INTL5      ADDRESS CORRECT
       REM            CHECK NEXT CHANNEL
       TRA *+2
       SLN 1          TURN ON SENSE LIGHT 1
       SXA TEMP,4     SAVE XRC
       STL XRC        ADDRESS WRONG
INTL4  TRA STPA       GO TO STEP I-O INSTRS
       LXA TEMP,4     RELOAD XRC
       SLT 1          TEST SENSE LIGHT 1
       TRA INTL3+3    OFF - CHECK UNIT AGAIN
INTL5  CLA INTL4
       ADD THREE      L +3
       STA INTL4      SET CHANNEL STEP ADDRESS
       TIX *+1,2,1
       TIX INTL2,4,1
       TIX INTL2-1,1,1
       NOP            REPLACEABLE BY XFER
       REM
       REM
       TSX REWA,2     TO REWIND ALL UNITS
       SLF            TURN OFF ALL SENSE LIGHTS
       REM
*             POST RESTART
       REM
AA     CLA TRA2       L TRA AA
       STO 0          POST RESTART
       REM
       REM
       TSX REST,4
       REM
       TSX WEFA,4     TO WRITE EOF ALL UNITS
       REM
       REM
*             FORM FIXED PATTERN WRITE FIELDS
       REM
FRM    AXT 64,1       L +100 IN XRA
       AXT 6,2        L +6 IN XRB
       CAL FIX+64,1
       ANA MASK1
       ORA MASK1+7,2  INSERT CHN IDENTITY BITS
       SLW* K3B+6,2
       TIX *-3,2,1
       TIX FRM+1,1,1
       TRA WTA
       REM
       REM
*             CHANNEL A INSTRUCTIONS
       REM
       REM
*             REWIND ALL UNITS
       REM
REWA   ZET CTRA
       REWA 1         REWIND CURRENT UNIT-CHN A
       TRA REWB
       REM
*             WRITE END OF FILE ALL UNITS
       REM
WEFA   ZET CTRA
       WEFA 1         WRITE END OF FILE - CHN A
       TRA WEFB
       REM
       REM
*             TEST WRITING IN BINARY MODE
       REM
       REM
*             WRITE ONE 100 WORD RECORD
       REM
       BCD 1WTB       TEST INSTRUCTION
       BCD 1WTBA 1    TEST INSTRUCTION
WTA    NZT CTRA
       TRA WTB
       WTBA 1
       RCHA CT1A      WRITE 100 WDS FROM WRFDA
       TSX ETT,4      GO TO CHECK FOR END OF TAPE
       REM
       SLT 1
       TRA WTB        OFF - CONTINUE
       TRA WTA        ON - REPEAT
       REM
WTA1   TSX RDNCK,4    CHECK FOR REDUNDANCY
       NOP WTA-1
       REM
       TSX CLR,4      GO TO CLEAR READ FIELDS
       REM
       TRA RTA
       REM
*             IF REDUNDANCY OCCURS THERE WILL BE
*             NO ATTEMPT TO REWRITE THE RECORD
       REM
       REM
*             READ ONE 100 WORD RECORD
       REM
       BCD 1RTB       TEST INSTRUCTION
       BCD 1RTBA 1    TEST INSTRUCTION
RTA    NZT CTRA
       TRA RTB
       BSFA 1
       TRCA *+1       TURN OFF TRCA IND IF ON
       TRA RTB
       REM
RTA1   NZT CTRA
       TRA RTB1
       RTBA 1         READ OVER
       RCHA CT7       END OF FILE
       TRA RTB1
       REM
RTA2   NZT CTRA
       TRA RTB2
       TCOA *         DELAY
       RTBA 1
       RCHA CT2       READ 100 WORDS - CHN A
       TRA RTB2
       REM
       TSX RDNCK,4
       NOP RTA-1
       REM
*             COMPARE 100 WORD RECORD
       REM
RTA3   NZT CTRA
       TRA RTB3+1
       CLA K3C        L HTR RDFDA+100
       STA RWC1
       CLA K3B        L HTR WRFDA+100,1
       STA RWC1+1
       STA RWC1+4
       TSX RTB3,2     SET RETURN FROM COMPARE
       AXT 1,2        L NO. OF RECORDS IN XRB
       TSX ERROR-2,4  COMPARISON ERROR
       NOP RTA
       TRA RWC2-2
       REM
RTA3A  TSX RWC,4      SET RETURN TO CONTINUE
       REM
       TSX OK,4
       TRA WTA
       REM
       NOP
       SLF            TURN ALL SENSE LIGHTS OFF
       TRA *+2
       REM
       REM
       BCD 1WTB       TEST INSTRUCTION
FRM1   LXA EIGHT,1    L +10 IN XRA
       CAL K10+8,1    INITIALIZE RANDOM
       SLW K11+8,1    GENERATOR
       TIX *-2,1,1
       REM
       TSX WEFA,4     GO TO WRITE EOF ALL UNITS
       REM
       REM
*             WRITE RANDOM WORD RANDOM LENGTH RECORDS
       REM
       CLA K2         L NO. OF REANDOM RECORDS
       PAX 0,2        IN XRB
       ADD ONE        L +1
       STO RECNO
       REM
       TSX REST,4     GO TO RESET INDICATORS
       REM
       REM
       TSX GEN1,4
       REM
       REM
A1     NZT CTRA
       TRA B1
       WTBA 1
       RCHA CT10A
       TRA B1
       TSX RDNCK,4
       NOP WTA-1
       REM
       TSX ETT,4      GO TO CHECK FOR END OF TAPE
       REM
       SLT 1          TEST SENSE LIGHT 1
       TRA *+2        OFF - CONTINUE
       TRA FRM1       ON - REPEAT.
       REM
       REM
       CLA K11+7
       LBT
       TRA A4A        DO NOT BACKSPACE
       REM
       TSX CLR,4      GO TO CLEAR READ FIELDS
       REM
       REM
*             BACKSPACE AND READ CURRENT RECORD
       REM
A2     ZET CTRA
       BSRA 1
       TRA B2
       REM
A3     NZT CTRA
       TRA B3
       RTBA 1         READ CURRENT RECORD
       RCHA CT12A
       TRA B3
       REM
       TSX RDNCK,4
       NOP RTA-1
       REM
       REM
       TSX GEN3,4
       TRA *+2
       REM
       BCD 1WTBA 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE        L +1
       STO WDNO
       REM
A4     NZT CTRA
       TRA B4-4
       CLA 0,1        L WORD READ CHN A
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+6
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP A4-4
       REM            NOTE - THIS ROUTINE SPOT
       REM            CHECKS RANDOM RECORDS
       REM
       REM
       LXA XRC,4      RESET XRC
       TIX A4+2,1,1   DECREMENT WORD COUNT
       REM
       REM
       TRA B4-4
       REM
       REM
A4A    TIX A1-2,2,1   DECREMENT RECORD COUNT
       REM
       TSX WEFA,4     TO WRITE EOF ALL UNITS
       REM
       REM
*             READ RANDOM BINARY RECORDS
       REM
A5     NZT CTRA
       TRA B5
       BSFA 1         BKSP OVER END OF FILE
       BSFA 1         BKSP OVER FILE
       REM
       TRA B5
       REM
       REM
       LXA EIGHT,1    L + 10 IN XRA
       CAL K10+8,1    INITIALIZE RANDOM
       SLW K11+8,1    GENERATOR
       TIX *-2,1,1
       REM
       REM
A6     NZT CTRA
       TRA B6
       RTBA 1
       RCHA CT7       READ OVER EOF
       TRA B6
       REM
       REM
       CLA K2         L NO. OF RANDOM RECORDS
       PAX 0,2        IN XRB
       ADD ONE        L +1
       STO RECNO
       REM
       TSX CLR,4      GO TO CLEAR READ FIELDS
       REM
       REM
       TSX GEN1,4     GNERATE RANDOM RECORD
       TRA *+2
       REM
       REM
       BCD 1RTB       TEST INSTRUCTION
A7     NZT CTRA
       TRA B7
       RTBA 1
       RCHA CT12A
       TRA B7
       REM
       TSX RDNCK,4
       NOP RTA-1
       TSX GEN3,4
       TRA *+2
       REM
       REM
*             COMPARE
       REM
       BCD 1RTBA 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE        L +1
       STO WDNO
       REM
       NZT CTRA
       TRA A9+2
       REM
A8     CLA 0,1        L WORD READ - CHN A
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+7
       LDQ 0,1        L WORD GENERATED
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP A8-6
       LXA XRC,4      RESET XRC
       SLN 2          TURN ON SENSE LIGHT 2
       TIX A8,1,1     DECREMENT WORD COUNT
       REM
       SLT 2          TEST SENSE LIGHT TWO
       TRA A9+3       OFF -  DO NOT BACKSPACE
       CAL K11+7      ON - L RANDOM WORD
       PBT
       TRA A9+3       NO - DO NOT BACKSPACE
       BSRA 1         BACKSPACE TO CHECK READ
       CLA TRA3       L TRA A9
       STO A8+11
       RTBA 1
       RCHA CT12A
       REM
       TSX RDNCK,4
       NOP  RTA-1
       TRA A8-6
       REM
       REM
A9     CLA SLT2       L SLT 2
       STO A8+11
       SLF            TURN ALL SENSE LIGHTS OFF
       TRA B8-6
       REM
       REM
       TIX A7-4,2,1   DECREMENT RECORD COUNT
       TRA A10
       REM
       REM
       BCD 1WEFA 1    TEST INSTRUCTION
A10    NZT CTRA
       TRA B10
       RTBA 1         READ EOF
       RCHA K4A
       TRA B10
       REM
A11    NZT CTRA
       TRA B11
       TCOA *         DELAY
       SCHA K4A+2     DSC CONTROL WORD
       TRA B11
       REM
       NZT CTRA
       TRA B11+5
       LDQ K4A+4
       CLA K4A+2
       CAS K4A+4
       TRA *+2
       TRA *+9        OK - SHOULD XFER
       CAS K4A+3
       TRA *+2
       TRA *+4
       TSX ERROR-1,4  FAILURE TO DISCN CORRECTLY
       REM            OR FAILURE TO SCH CORRECTLY
       NOP A10
       TRA B11+5
       TSX ERROR-1,4  FALSE EOR READ AT EOF
       TXL A10,4
       TRA B11+5
       REM
A12    NZT CTRA
       TRA B12
       TEFA *+3       EOF SHOULD BE ON
       TSX ERROR-1,4  FAILED TO READ EOF-CHN A
       TXL A10,4
       TRA B12
       REM
       TSX OK,4
       TRA FRM1-3
       REM
       NOP
       TRA PRNT
       REM
       REM
*             RANDOM BINARY GENERATOR
       REM
GEN1   SXA XRB,2      SAVE XRB
       LDQ K11+7      RANDOM NUMBER GENERATOR
       CLA ZERO       CLEAR ACC
       LGL 6          SHIFT FOR RANDOM NO OF WDS
       REM            MAXIMUM OF 77
       ADD ONE         L +1
       PAX 0,1        L NO OF WDS PER REC IN XRA
       REM
       SXA WDCT,1     SET UP WORD COUNT IN
       SXD CT10A,1
       SXD CT10B,1    WRITE
       SXD CT10C,1
       SXD CT10D,1
       SXD CT10E,1    FIELDS
       SXD CT10F,1
       REM            AND
       SXD CT12A,1
       SXD CT12B,1    READ
       SXD CT12C,1
       SXD CT12D,1
       SXD CT12E,1    FIELDS
       SXD CT12F,1
       REM
       AXT 18,2       L +22 IN XRB
       ADM K3         INITIAL ADDR - WRFDA
       STA GEN2+22,2
       ADM K6+3       L +100
       TIX *-2,2,3
       PXA 0,1
       ADD K3+6       INITIAL ADDR OF RANDOM FLD
       STA GEN2+1
       REM
GEN2   CAL K11+7      GENERATE N-RANDOM WORDS
       ADM 0,1
       ANA MASK1      L 777700007777
       ORA MASK1+1    L 000021210000
       SLW 0,1
       ANA MASK1
       ORA MASK1+2    L 000022220000
       SLW 0,1
       ANA MASK1
       ORA MASK1+3    L 000023230000
       SLW 0,1
       ANA MASK1
       ORA MASK1+4    L 000024240000
       SLW 0,1
       ANA MASK1
       ORA MASK1+5    L 000025250000
       SLW 0,1
       ANA MASK1
       ORA MASK1+6    L 000026260000
       SLW 0,1
       TIX GEN2+1,1,1
       SLW WRFDA-1
       LXA XRB,2      RESET XRB
       TRA 1,4        EXIT
       REM
GEN3   CLA K3A        INITIAL ADDR READ FIELD - A
       ADD WDCT       WORD COUNT
       STA A4+2
       STA A8
       CLA K3A+1      INITIAL ADDR READ FIELD - B
       ADD WDCT
       STA B4+2
       STA B8
       CLA K3A+2      INITIAL ADDR READ FIELD - C
       ADD WDCT
       STA C4+2
       STA C8
       CLA K3A+3      INITIAL ADDR READ FIELD - D
       ADD WDCT
       STA D4+2
       STA D8
       CLA K3A+4      INITIAL ADDR READ FIELD - E
       ADD WDCT
       STA E4+2
       STA E8
       CLA K3A+5      INITIAL ADDR READ FIELD - F
       ADD WDCT
       STA F4+2
       STA F8
       CLA K3         INITIAL ADDR WR FIELD - A
       ADD WDCT
       STA A4+3
       STA A4+6
       STA A8+1
       STA A8+4
       CLA K3+1       INITIAL ADDR WR FIELD - B
       ADD WDCT
       STA B4+3
       STA B4+6
       STA B8+1
       STA B8+4
       CLA K3+2       INITIAL ADDR WR FIELD - C
       ADD WDCT
       STA C4+3
       STA C4+6
       STA C8+1
       STA C8+4
       CLA K3+3       INITIAL ADDR WR FIELD - D
       ADD WDCT
       STA D4+3
       STA D4+6
       STA D8+1
       STA D8+4
       CLA K3+4       INITIAL ADDR WR FIELD - E
       ADD WDCT
       STA E4+3
       STA E4+6
       STA E8+1
       STA E8+4
       CLA K3+5       INITIAL ADDR WR FIELD - F
       ADD WDCT
       STA F4+3
       STA F4+6
       STA F8+1
       STA F8+4
       REM
       TRA 1,4        CONTINUE PROGRAM
       REM
       REM
*             PRINT PASS COMPLETE FOR FRAME
       REM
PRNT   TSX PRT,2      GO TO SPACE PRINTER
       AXT 6,1        L +6 IN XRA
       NZT CTRF+1,1
       TRA *+6
       CLA NDRA+6,1
       STA PASS+7
       SXA TEMP,1     SAVE XRA
       TSX PASS,4     GO TO PRINT
       LXA TEMP,1     RESET XRA
       TIX *-7,1,1
       TRA RDUS
       REM
       REM
*             REDUCE UNIT COUNT
RDUS   AXT 6,1
       CLA CTRF+1,1   L CURRENT UNIT COUNT
       TZE *+3        NO COUNT - CHECK NEXT CHN
       SUB ONE        L +1
       STO CTRF+1,1   SAVE NEW COUNT
       TIX *-4,1,1
       REM
       REM
*             CHECK UNIT COUNT TO STEP UNIT ADDRESS
       REM
CHK    AXT 6,1        L +6 IN XRA TO TEST LOOP
       REM            THROUGH 6 UNIT COUNTS
       AXT 18,2       L +20 IN XRC
       NZT CTRF+1,1   CHECK CURRENT UNIT COUNT
       TRA *+4        NO COUNT - TRY NEXT CHN
       STL XRC        COUNT REMAINING - PROCEED
       TRA STPF+3,2
       REM
       SLN 2          INDICATE UNITS LEFT TO TEST
       TIX *+1,2,3
       TIX *-6,1,1
       SLT 2          CHECK FOR UNITS UNTESTED
       TRA PASS3      OFF-PASS COMPLETE ALL UNITS
       TRA AA         ON - CONTINUE TESTING
       REM
       REM
PASS   SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA RDUS       BYPASS PRINT
       REM
       LXA K2+3,1     L +22 IN XRA
       CAL MASK2      L -341737707030
       ANS PR1+22,1
       TIX *-2,1,2
       REM
       CLA 0          L WRITE TAPE CURRENT UNIT
       STA TEMP3
       ANA K6         L +17
       PAI            L INDS WITH ACC
       RNT 00012      TEST FOR UNIT 10
       TRA PASS1      NO
       AXT 4,1        YES - L +4 IN XRA
       REM
       CLA ONE        L +1
       ORS PR1+18,1
       AXT 2,1        L +2 IN XRA
       CLA TWO        L +2
       ORS PR1+18,1
       TRA PASS2
       REM
PASS1  CLA TEMP3
       ANA SEVEN      CLEAR TO RIGHT DIGIT
       ALS 1          DOUBLE INCREMENT
       PAX 0,1
       CLA ONE        L LOW BIT
       ORS PR1+18,1
       AXT 0,1        L +0 IN XRA
       CLA TWO        L HIGH BIT
       ORS PR1+18,1
       REM
       CLA TEMP3
       ANA K2+7
       ARS 8          MOVE TO LOW ORDER + DOUBLE
       PAX 0,1
       CLA K2+6       L +200  BIT TO PRINT CHN
       ORS PR1+18,1
       REM
PASS2  TSX PRT1,2
       TRA 1,4
       REM
PASS3  SWT 3          TEST SENSE SWITCH 3
       REM
       TRA PRT2       UP - GO TO PRINT
       REM
FINL   SWT 6
       TRA FINL1
       SWT 5
       TRA *+4
       CLA K1         L NOP
       STO AA-2
       TRA RUC
       REM
       CLA K1+1       L TSX REWA,2
       STO AA-2
       TRA RUC-1
       REM
FINL1  RCDA           SELECT CARD READER
       REM            NOTE -  THIS INSTR IS
       REM            REPLACED BY RTBA 1 IF
       REM            DIAGNOSTIC WAS READ
       REM            FROM TAPE
       RCHA FNLX      READ IN
       LCHA 0         NEXT
       TRA 1          PROGRAM
       REM
FNLX   IOCT 0,0,3
       REM
       REM
*             CHANNEL B INSTRUCTIONS
       REM
REWB   ZET CTRB
       REWB 1         REWIND CURRENT UNIT-CHN B
       TRA REWC
       REM
       REM
WEFB   ZET CTRB
       WEFB 1         WTITE END OF FILE - CHN B
       TRA WEFC
       REM
       REM
*             WRITE ONE 100 WORD RECORD
       REM
       BCD 1WTBB      TEST INSTRUCTION
WTB    NZT CTRB
       TRA WTC
       WTBB 1
       RCHB CT1B      WRITE 100 WDS FROM WRFDB
       TSX ETT,4      GO TO CHECK FOR END OF TAPE
       REM
       SLT 1
       TRA WTC        OFF - CONTINUE
       TRA WTA        ON - REPEAT
       REM
       REM
*             READ ONE 100 WORD RECORD
       REM
       BCD 1RTBB 1    TEST INSTRUCTION
RTB    NZT CTRB
       TRA RTC
       BSFB 1
       TRCB *+1       TURN OFF TRCB IND IF ON
       TRA RTC
       REM
RTB1   NZT CTRB
       TRA RTC1
       RTBB 1         READ OVER
       RCHB CT7+2     END OF FILE
       TRA RTC1
       REM
RTB2   NZT CTRB
       TRA RTC2
       TCOB *         DELAY
       RTBB 1
       RCHB CT2+2     READ 100 WORDS - CHN B
       TRA RTC2
       REM
       REM
*             COMPARE 100 WORD RECORD
       REM
RTB3   TSX RWC,4      SET RETURN TO CONTINUE
       NZT CTRB
       TRA RTC3+1
       CLA K3C+1      L HTR RDFDB+100
       STA RWC1
       REM
       CLA K3B+1      L HTR WRFDB+100,1
       STA RWC1+1
       STA RWC1+4
       TSX RTC3,2     SET RETURN FROM COMPARE
       AXT 1,2        L NO. OF RECORDS IN XRB
       TSX ERROR-2,4  COMPARISON ERROR
       NOP RTB
       TRA RWC2-2
       REM
       REM
*             WRITE RANDOM WORD LENGTH RECORDS
       REM
       REM
B1     NZT CTRB
       TRA C1
       WTBB 1
       RCHB CT10B
       TRA C1
B2     ZET CTRB
       BSRB 1
       TRA C2
       REM
B3     NZT CTRB
       TRA C3
       RTBB 1
       RCHB CT12B
       TRA C3
       REM
       REM
       BCD 1RTBB 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE        L +1
       STO WDNO
       REM
B4     NZT CTRB
       TRA C4
       CLA 0,1        L WORD READ CHN B
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+6
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP B4-4
       REM            NOTE - THIS ROUTINE SPOT
       REM            CHECKS RANDOM RECORDS
       LXA XRC,4      RESET XRC
       TIX B4+2,1,1   DECREMENT WORD COUNT
       TRA C4-4
       REM
       REM
*             READ RANDOM BINARY RECORDS
       REM
B5     NZT CTRB
       TRA C5
       BSFB 1         BKSP OVER END OF FILE
       BSFB 1         BKSP OVER FILE
       TRA C5
       REM
B6     NZT CTRB
       TRA C6
       RTBB 1
       RCHB CT7+2     READ OVER EOF
       TRA C6
       REM
       REM
B7     NZT CTRB
       TRA C7
       RTBB 1
       RCHB CT12B
       TRA C7
       REM
       REM
*             COMPARE
       REM
       BCD 1RTBB1 1   TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE        L +1
       STO WDNO
       REM
       NZT CTRB
       TRA C8-2
       REM
B8     CLA 0,1        L WORD READ CHN B
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+7
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP B8-6
       LXA XRC,4      RESET XRC
       SLN 2          TURN ON SENSE LIGHT TWO
       TIX B8,1,1     DECREMENT WORD COUNT
       REM
       SLT 2          TEST SENSE LIGHT TWO
       TRA C8-6       OFF -  DO NOT BACKSPACE
       CAL K11+7
       PBT
       TRA C8-6       NO - DO NOT BACKSPACE
       BSRB 1
       CLA TRA3+1     L TRA B9
       STO B8+11
       RTBB 1
       RCHB CT12B
       SXA XRC,4      SAVE XRC
       TSX RDNCK,4
       NOP B8-6
       LXA XRC,4      RESET XRC
       TRA B8-6
B9     CLA SLT2       L SLT 2
       STO B8+11
       SLF            TURN ALL SENSE LIGHTS OFF
       TRA C8-6
       REM
       REM
       BCD 1WEFB 1    TEST INSTRUCTION
B10    NZT CTRB
       TRA C10
       RTBB 1         READ EOF
       RCHB K4B
       TRA C10
       REM
B11    NZT CTRB
       TRA C11
       TCOB *         DELAY
       SCHB K4B+2     DSC CONTROL WORD
       TRA C11
       REM
       NZT CTRB
       TRA C11+5
       LDQ K4B+4
       CLA K4B+2
       CAS K4B+4
       TRA *+2
       TRA *+13       OK - SHOULD XFER
       CAS K4B+3
       TRA *+2
       TRA *+6
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FAILURE TO DISCN CORRECTLY
       REM            OF FAILED TO SCH CORRECTLY
       NOP B10
       LXA XRC,4      RESET XRC
       TRA *+5
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FALSE EOR READ AT EOF
       TXL B10,4
       LXA XRC,4      RESET XRC
       TRA C11+5
       REM
B12    NZT CTRB
       TRA C12
       TEFB *+3       EOF SHOULD BE ON
       TSX ERROR-1,4  FAILED TO READ EOF-CHN B
       TXL A10,4
       TRA C12
       REM
       REM
*             CHANNEL C INSTRUCTIONS
       REM
REWC   ZET CTRC
       REWC 1         REWIND CURRENT UNIT-CHN C
       TRA REWD
       REM
       REM
WEFC   ZET CTRC
       WEFC 1         WRITE END OF FILE - CHN C
       TRA WEFD
       REM
       REM
*             WRITE ONE 100 WORD RECORD
       REM
       REM
       BCD 1WTBC 1    TEST INSTRUCTION
WTC    NZT CTRC
       TRA WTD
       WTBC 1
       RCHC CT1C      WRITE 100 WDS FROM WRFDC
       TSX ETT,4      GO TO CHECK FOR END OF TAPE
       REM
       SLT 1
       TRA WTD        OFF - CONTINUE
       TRA WTA        ON - REPEAT
       REM
       REM
*             READ ONE 100 WORD RECORD
       REM
       BCD 1RTBC 1    TEST INSTRUCTION
RTC    NZT CTRC
       TRA RTD
       BSFC 1
       TRCC *+1       TURN OFF TRCC IND IF ON
       TRA RTD
       REM
RTC1   NZT CTRC
       TRA RTD1
       RTBC 1         READ OVER
       RCHC CT7+4
       TRA RTD1
       REM
RTC2   NZT CTRC
       TRA RTD2
       TCOC *         DELAY
       RTBC 1
       RCHC CT2+4     READ 100 WORDS - CHN C
       TRA RTD2
       REM
       REM
*             COMPARE 100 WORD RECORDS
       REM
RTC3   TSX RWC,4      SET RETURN TO CONTINUE
       NZT CTRC
       TRA RTD3+1
       CLA K3C+2      L HTR RDFDC+100
       STA RWC1
       CLA K3B+2      L HTR WRFDC+100,1
       STA RWC1+1
       STA RWC1+4
       TSX RTD3,2     SET RETURN FROM COMPARE
       AXT 1,2        L NO. OF RECORDS IN XRB
       REM
       TSX ERROR-2,4  COMPARISON ERROR
       NOP RTC
       TRA RWC2-2
       REM
       REM
*             WRITE RANDOM WORD RANDOM LENGTH RECORDS
       REM
C1     NZT CTRC
       TRA D1
       WTBC 1
       RCHC CT10C
       TRA D1
       REM
C2     ZET CTRC
       BSRC 1
       TRA D2
       REM
C3     NZT CTRC
       TRA D3
       RTBC 1
       RCHC CT12C
       TRA D3
       REM
       REM
       BCD 1RTBC 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE        L +1
       STO WDNO
       REM
C4     NZT CTRC
       TRA D4
       CLA 0,1        L WORD READ CHN  C
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+6
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP C4-4
       REM            NOTE - THIS ROUTINE SPOT
       REM            CHECKS RANDOM RECORDS
       LXA XRC,4      RESET XRC
       TIX C4+2,1,1   DECREMENT WORD COUNT
       TRA D4-4
       REM
       REM
*             READ RANDOM BINARY RECORDS
C5     NZT CTRC
       TRA D5
       BSFC 1         BKSP OVER END OF FILE
       BSFC 1         BKSP OVER FILE
       TRA D5
       REM
C6     NZT CTRC
       TRA D6
       RTBC 1
       RCHC CT7+4     READ OVER EOF
       TRA D6
       REM
       REM
C7     NZT CTRC
       TRA D7
       RTBC 1
       RCHC CT12C
       TRA D7
       REM
       REM
*             COMPARE
       REM
       BCD 1RTBC 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE        L +1
       STO WDNO
       REM
       NZT CTRC
       TRA D8-2
       REM
C8     CLA 0,1        L WORD READ - CHN C
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+7
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP C8-6
       LXA XRC,4      RESET XRC
       SLN 2          TURN ON SENSE LIGHT TWO
       TIX C8,1,1     DECREMENT WORD COUNT
       REM
       SLT 2          TEST SENSE LIGHT TWO
       TRA D8-6       OFF - DO NOT BACKSPACE
       CAL K11+7
       PBT
       TRA D8-6       NO - DO NOT BACKSPACE
       BSRC 1
       CLA TRA3+2     L TRA C9
       STO C8+11
       RTBC 1
       RCHC CT12C
       SXA XRC,4      SAVE XRC
       TSX RDNCK,4
       NOP C8-6
       LXA XRC,4      RESET XRC
       TRA C8-6
       REM
C9     CLA SLT2       L SLT2 2
       STO C8+11
       SLF            TURN ALL SENSE LIGHTS OFF
       TRA D8-6
       REM
       REM
       BCD 1WEFC 1    TEST INSTRUCTION
C10    NZT CTRC
       TRA D10
       RTBC 1
       RCHC K4C
       TRA D10
       REM
C11    NZT CTRC
       TRA D11
       TCOC *         DELAY
       SCHC K4C+2     DSC CONTROL WORD
       TRA D11
       REM
       NZT CTRC
       TRA D11+5
       LDQ K4C+4
       CLA K4C+2
       CAS K4C+4
       TRA *+2
       TRA *+13       OK - SHOULD XFER
       CAS K4C+3
       TRA *+2
       TRA *+6
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FAILURE TO DISCN CORRECTLY
       REM            OF FAILED TO SCH CORRECTLY
       NOP C10
       LXA XRC,4      RESET XRC
       TRA *+5
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FALSE EOR READ AT EOF
       TXL C10,4
       LXA XRC,4      RESET XRC
       TRA D11+5
       REM
C12    NZT CTRC
       TRA D12
       TEFC *+3       EOF SHOULD BE ON
       TSX ERROR-1,4  FAILED TO READ EOF-CHN C
       TXL C10,4
       TRA D12
       REM
       REM
*             CHANNEL D INSTRUCTIONS
       REM
       REM
REWD   ZET CTRD
       REWD 1         REWIND CURRENT UNIT-CHN D
       TRA REWE
       REM
       REM
WEFD   ZET CTRD
       WEFD 1         WRITE END OF FILE - CHN D
       TRA WEFE
       REM
       REM
*             WRITE ONE 100 WORD RECORD
       REM
       REM
       BCD 1WTBD 1    TEST INSTRUCTION
WTD    NZT CTRD
       TRA WTE
       WTBD 1
       RCHD CT1D      WRITE 100 WDS FROM WRFDD
       TSX ETT,4      GO TO CHECK FOR END OF TAPE
       REM
       SLT 1
       TRA WTE        OFF - CONTINUE
       TRA WTA        ON - REPEAT
       REM
       REM
*             READ ONE 100 WORD RECORD
       REM
       BCD 1RTBD 1    TEST INSTRUCTION
RTD    NZT CTRD
       TRA RTE
       BSFD 1
       TRCD *+1       TURN OFF TRCD IND IF ON
       TRA RTE
       REM
RTD1   NZT CTRD
       TRA RTE1
       RTBD 1         READ OVER
       RCHD CT7+6     END OF FILE
       TRA RTE1
       REM
RTD2   NZT CTRD
       TRA RTE2
       TCOD *         DELAY
       RTBD 1
       RCHD CT2+6     READ 100 WORDS - CHN D
       TRA RTE2
       REM
       REM
*             COMPARE 100 WORD RECORD
       REM
RTD3   TSX RWC,4      SET RETURN TO CONTINUE
       NZT CTRD
       TRA RTE3+1
       CLA K3C+3      L HTR RDFDD+100
       STA RWC1
       CLA K3B+3      L HTR WRFDD+100,1
       STA RWC1+1
       STA RWC1+4
       TSX RTE3,2     SET RETURN FROM COMPARE
       AXT 1,2        L NO. OF RECORDS IN XRB
       TSX ERROR-2,4  COMPARISON ERROR
       NOP RTD
       TRA RWC2-2
       REM
       REM
*             WRITE RANDOM WORD RANDOM LENGTH RECORDS
       REM
D1     NZT CTRD
       TRA E1
       WTBD 1
       RCHD CT10D
       TRA E1
       REM
D2     ZET CTRD
       BSRD 1
       TRA E2
       REM
D3     NZT CTRD
       TRA E3
       RTBD 1
       RCHD CT12D
       TRA E3
       REM
       BCD 1RTBD 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE        L +1
       STO WDNO
       REM
D4     NZT CTRD
       TRA E4
       CLA 0,1        L WORD READ CHN D
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+6
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP D4-4
       REM            NOTE - THIS ROUTINE SPOT
       REM            CHECKS RANDOM RECORDS
       LXA XRC,4      RESET XRC
       TIX D4+2,1,1   DECREMENT WORD COUNT
       TRA E4-4
       REM
       REM
*             READ RANDOM BINARY RECORDS
       REM
D5     NZT CTRD
       TRA E5
       BSFD 1         BKSP OVER END OF FILE
       BSFD 1         BKSP OVER FILE
       TRA E5
       REM
D6     NZT CTRD
       TRA E6
       RTBD 1
       RCHD CT7+6     READ OVER EOF
       TRA E6
       REM
       REM
D7     NZT CTRD
       TRA E7
       RTBD 1
       RCHD CT12D
       TRA E7
       REM
       REM
*             COMPARE
       REM
       BCD 1RTBD 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE         L +1
       STO WDNO
       REM
       NZT CTRD
       TRA E8-2
       REM
D8     CLA 0,1        L WORD READ - CHN D
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+7
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP D8-6
       LXA XRC,4      RESET XRC
       SLN 2          TURN ON SENSE LIGHT TWO
       TIX D8,1,1     DECREMENT WORD COUNT
       REM
       SLT 2          TEST SENSE LIGHT TWO
       TRA E8-6       OFF - DO NOT BACKSPACE
       CAL K11+7
       PBT
       TRA E8-6       NO - DO NOT BACKSPACE
       BSRD 1
       CLA TRA3+3     L TRA D9
       STO D8+11
       RTBD 1
       RCHD CT12D
       SXA XRC,4      SAVE XRC
       TSX RDNCK,4
       NOP D8-6
       LXA XRC,4      RESET XRC
       TRA D8-6
       REM
D9     CLA SLT2       L SLT 2
       STO D8+11
       SLF            TURN ALL SENSE LIGHTS OFF
       TRA E8-6
       REM
       REM
       BCD 1WEFD 1    TEST INSTRUCTION
D10    NZT CTRD
       TRA E10
       RTBD 1
       RCHD K4D
       TRA E10
       REM
D11    NZT CTRD
       TRA E11
       TCOD *         DELAY
       SCHD K4D+2
       TRA E11
       REM
       NZT CTRD
       TRA E11+5
       LDQ K4D+4
       CLA K4D+2
       CAS K4D+4
       TRA *+2
       TRA *+13       OK - SHOULD XFER
       CAS K4D+3
       TRA *+2
       TRA *+6
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FAILURE TO DISCN CORRECTLY
       REM            OR FAILED TO SCH CORRECTLY
       NOP D10
       LXA XRC,4      RESET XRC
       TRA *+5
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FALSE EOF READ AT EOF
       TXL D10,4
       LXA XRC,4      RESET XRC
       TRA E11+5
       REM
D12    NZT CTRD
       TRA E12
       TEFD *+3       EOF SHOULD BE ON
       TSX ERROR-1,4  FAILED TO READ EOF-CHN D
       TXL D10,4
       TRA E12
       REM
       REM
*             CHANNEL E INSTRUCTIONS
       REM
       REM
REWE   ZET CTRE
       REWE 1         REWIND CURRENT UNIT-CHN E
       TRA REWF
       REM
       REM
WEFE   ZET CTRE
       WEFE 1         WRITE END OF FILE - CHN E
       TRA WEFF
       REM
       REM
*             WRITE ONE 100 WORD RECORD
       REM
       REM
       BCD 1WTBE 1    TEST INSTRUCTION
WTE    NZT CTRE
       TRA WTF
       WTBE 1
       RCHE CT1E      WRITE 100 WDS FROM WRFDD
       TSX ETT,4      GO TO CHECK FOR END OF TAPE
       REM
       SLT 1
       TRA WTF        OFF - CONTINUE
       TRA WTA        ON - REPEAT
       REM
       REM
*             READ ONE 100 WORD RECORD
       REM
       BCD 1RTBE 1    TEST INSTRUCTION
RTE    NZT CTRE
       TRA RTF
       BSFE 1
       TRCE *+1       TURN OFF TRCD IND IF ON
       TRA RTF
       REM
RTE1   NZT CTRE
       TRA RTF1
       RTBE 1         READ OVER
       RCHE CT7+8     END OF FILE
       TRA RTF1
       REM
RTE2   NZT CTRE
       TRA RTF2
       TCOE *         DELAY
       RTBE 1
       RCHE CT2+8     READ 100 WORDS - CHN E
       TRA RTF2
       REM
       REM
*             COMPARE 100 WORD RECORD
       REM
RTE3   TSX RWC,4      SET RETURN TO CONTINUE
       NZT CTRE
       TRA RTF3+1
       CLA K3C+4      L HTR RDFDE+100
       STA RWC1
       CLA K3B+4      L HTR WRFDE+100,1
       STA RWC1+1
       STA RWC1+4
       TSX RTF3,2     SET RETURN FROM COMPARE
       AXT 1,2        L NO. OF RECORDS IN XRB
       TSX ERROR-2,4  COMPARISON ERROR
       NOP RTE
       TRA RWC2-2
       REM
       REM
*             WRITE RANDOM WORD RANDOM LENGTH RECORDS
       REM
E1     NZT CTRE
       TRA F1
       WTBE 1
       RCHE CT10E
       TRA F1
       REM
E2     ZET CTRE
       BSRE 1
       TRA F2
       REM
E3     NZT CTRE
       TRA F3
       RTBE 1
       RCHE CT12E
       TRA F3
       REM
       BCD 1RTBE 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE        L +1
       STO WDNO
       REM
E4     NZT CTRE
       TRA F4
       CLA 0,1        L WORD READ CHN D
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+6
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP E4-4
       REM            NOTE - THIS ROUTINE SPOT
       REM            CHECKS RANDOM RECORDS
       LXA XRC,4      RESET XRC
       TIX E4+2,1,1   DECREMENT WORD COUNT
       TRA F4-4
       REM
       REM
*             READ RANDOM BINARY RECORDS
       REM
E5     NZT CTRE
       TRA F5
       BSFE 1         BKSP OVER END OF FILE
       BSFE 1         BKSP OVER FILE
       TRA F5
       REM
E6     NZT CTRE
       TRA F6
       RTBE 1
       RCHE CT7+6     READ OVER EOF
       TRA F6
E7     NZT CTRE
       TRA F7
       RTBE 1
       RCHE CT12E
       TRA F7
       REM
       REM
       REM
       REM
*             COMPARE
       REM
       BCD 1RTBE 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE         L +1
       STO WDNO
       REM
       NZT CTRE
       TRA F8-2
       REM
E8     CLA 0,1        L WORD READ - CHN E
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+7
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP E8-6
       LXA XRC,4      RESET XRC
       SLN 2          TURN ON SENSE LIGHT TWO
       TIX E8,1,1     DECREMENT WORD COUNT
       REM
       SLT 2          TEST SENSE LIGHT TWO
       TRA F8-6       OFF - DO NOT BACKSPACE
       CAL K11+7
       PBT
       TRA F8-6       NO - DO NOT BACKSPACE
       BSRE 1
       CLA TRA3+4     L TRA E9
       STO E8+11
       RTBE 1
       RCHE CT12E
       SXA XRC,4      SAVE XRC
       TSX RDNCK,4
       NOP E8-6
       LXA XRC,4      RESET XRC
       TRA E8-6
       REM
E9     CLA SLT2       L SLT 2
       STO E8+11
       SLF            TURN ALL SENSE LIGHTS OFF
       TRA F8-6
       REM
       REM
       BCD 1WEFE 1    TEST INSTRUCTION
E10    NZT CTRE
       TRA F10
       RTBE 1
       RCHE K4E
       TRA F10
       REM
E11    NZT CTRE
       TRA F11
       TCOE *         DELAY
       SCHE K4E+2
       TRA F11
       REM
       NZT CTRE
       TRA F11+5
       LDQ K4E+4
       CLA K4E+2
       CAS K4E+4
       TRA *+2
       TRA *+13       OK - SHOULD XFER
       CAS K4E+3
       TRA *+2
       TRA *+6
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FAILURE TO DISCN CORRECTLY
       REM            OR FAILED TO SCH CORRECTLY
       NOP E10
       LXA XRC,4      RESET XRC
       TRA *+5
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FALSE EOF READ AT EOF
       TXL E10,4
       LXA XRC,4      RESET XRC
       TRA F11+5
       REM
E12    NZT CTRE
       TRA F12
       TEFE *+3       EOF SHOULD BE ON
       TSX ERROR-1,4  FAILED TO READ EOF-CHN E
       TXL E10,4
       TRA F12
       REM
       REM
*             CHANNEL F INSTRUCTIONS
       REM
       REM
REWF   ZET CTRF
       REWF 1         REWIND CURRENT UNIT-CHN F
       SLN 1          TURN ON SENSE LIGHT ONE
       TRA 1,2        TO CONTINUE PROGRAM
       REM
       REM
WEFF   ZET CTRF
       WEFF 1         WRITE END OF FILE - CHN F
       TRA 1,4
       REM
       REM
*             WRITE ONE 100 WORD RECORD
       REM
       REM
       BCD 1WTBF 1    TEST INSTRUCTION
WTF    NZT CTRF
       TRA WTA1
       WTBF 1
       RCHF CT1F      WRITE 100 WDS FROM WRFDF
       TSX ETT,4      GO TO CHECK FOR END OF TAPE
       REM
       SLT 1
       TRA WTA1       OFF - CONTINUE
       TRA WTA        ON - REPEAT
       REM
       REM
*             READ ONE 100 WORD RECORD
       REM
       BCD 1RTBF 1    TEST INSTRUCTION
RTF    NZT CTRF
       TRA RTA1
       BSFF 1
       TRCF *+1       TURN OFF TRCF IND IF ON
       TRA RTA1
       REM
RTF1   NZT CTRF
       TRA RTA2
       RTBF 1         READ OVER
       RCHF CT7+10    END OF FILE
       TRA RTA2
       REM
RTF2   NZT CTRF
       TRA RTA2+6
       TCOF *         DELAY
       RTBF 1
       RCHF CT2+10    READ 100 WORDS - CHN F
       TRA RTA2+6
       REM
       REM
*             COMPARE 100 WORD RECORD
       REM
RTF3   TSX RWC,4      SET RETURN TO CONTINUE
       NZT CTRF
       TRA RTA3A+1
       CLA K3C+5      L HTR RDFDF+100
       STA RWC1
       CLA K3B+5      L HTR WRFDF+100,1
       STA RWC1+1
       STA RWC1+4
       TSX RTA3A,2    SET RETURN FROM COMPARE
       AXT 1,2        L NO. OF RECORDS IN XRB
       TSX ERROR-2,4  COMPARISON ERROR
       NOP RTF
       TRA RWC2-2
       REM
       REM
*             WRITE RANDOM WORD RANDOM LENGTH RECORDS
       REM
F1     NZT CTRF
       TRA A1+5
       WTBF 1
       RCHF CT10F
       TRA A1+5
       REM
F2     ZET CTRF
       BSRF 1
       TRA A3
       REM
F3     NZT CTRF
       TRA A3+5
       RTBF 1
       RCHF CT12F
       TRA A3+5
       REM
       BCD 1RTBF 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE        L +1
       STO WDNO
       REM
F4     NZT CTRF
       TRA A4A
       CLA 0,1        L WORD READ CHN F
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+6
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP F4-4
       REM            NOTE - THIS ROUTINE SPOT
       REM            CHECKS RANDOM RECORDS
       LXA XRC,4      RESET XRC
       TIX F4+2,1,1   DECREMENT WORD COUNT
       TRA A4A
       REM
       REM
*             READ RANDOM BINARY RECORDS
       REM
F5     NZT CTRF
       TRA A5+5
       BSFF 1         BKSP OVER END OF FILE
       BSFF 1         BKSP OVER FILE
       TRA A5+5
       REM
F6     NZT CTRF
       TRA A6+5
       RTBF 1
       RCHF CT7+10    READ OVER EOF
       TRA A6+5
       REM
F7     NZT CTRF
       TRA A7+5
       RTBF 1
       RCHF CT12F
       TRA A7+5
       REM
       REM
*             COMPARE
       REM
       BCD 1RTBF 1    TEST INSTRUCTION
       LXA WDCT,1     L WORD COUNT IN XRA
       CLA WDCT       L WORD COUNT
       ADD ONE         L +1
       STO WDNO
       REM
       NZT CTRF
       TRA A9+4
       REM
F8     CLA 0,1        L WORD READ - CHN F
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA *+7
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA XRC,4      SAVE XRC
       TSX ERROR-2,4  COMPARISON ERROR
       NOP F8-6
       LXA XRC,4      RESET XRC
       SLN 2          TURN ON SENSE LIGHT TWO
       TIX F8,1,1     DECREMENT WORD COUNT
       REM
       SLT 2          TEST SENSE LIGHT TWO
       TRA A9+4       OFF - DO NOT BACKSPACE
       CAL K11+7
       PBT
       TRA A9+4       NO - DO NOT BACKSPACE
       BSRE 1
       CLA TRA3+5     L TRA F9
       STO F8+11
       RTBF 1
       RCHF CT12F
       SXA XRC,4      SAVE XRC
       TSX RDNCK,4
       NOP F8-6
       LXA XRC,4      RESET XRC
       TRA F8-6
       REM
F9     CLA SLT2       L SLT 2
       STO F8+11
       SLF            TURN ALL SENSE LIGHTS OFF
       TRA A9+4
       REM
       REM
       BCD 1WEFF 1    TEST INSTRUCTION
F10    NZT CTRF
       TRA A11
       RTBF 1
       RCHF K4F
       TRA A11
       REM
F11    NZT CTRF
       TRA A11+5
       TCOF *         DELAY
       SCHF K4F+2
       TRA A11+5
       REM
       NZT CTRF
       TRA A12
       LDQ K4F+4
       CLA K4F+2
       CAS K4F+4
       TRA *+2
       TRA *+13       OK - SHOULD XFER
       CAS K4F+3
       TRA *+2
       TRA *+6
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FAILURE TO DISCN CORRECTLY
       REM            OR FAILED TO SCH CORRECTLY
       NOP F10
       LXA XRC,4      RESET XRC
       TRA *+5
       SXA XRC,4      SAVE XRC
       TSX ERROR-1,4  FALSE EOF READ AT EOF
       TXL F10,4
       LXA XRC,4      RESET XRC
       TRA A12
       REM
F12    NZT CTRF
       TRA A12+6
       TEFF *+3       EOF SHOULD BE ON
       TSX ERROR-1,4  FAILED TO READ EOF-CHN F
       TXL F10,4
       TRA A12+6
       REM
       REM
*             UTILITY SUB-ROUTINE
       REM
       REM
RWC    CLA TWO        L +2
       STO RECNO
       CLA K5+1       L +101
       STO WDNO
       SXA TEMP2,2    SAVE RETURN FROM COMPARE
       AXT 64,1       L +100 IN XRA - WD COUNT
RWC1   CLA 0,1        L WORD READ
       CAS 0,1        COMPARE WORD GENERATED
       TRA *+2
       TRA RWC2       TO OK
       LDQ 0,1        L WORD GENERATED IN MQ
       SXA TEMP,4     SAVE XRC
       TRA 1,2        GO TO CHANNEL ROUTINE TO
       REM            PRINT OUT ERROR
       LXA TEMP2,2    RESET RETURN FROM COMPARE
       LXA TEMP,4     RESET RETURN TO CONTINUE
RWC2   TIX RWC1,1,1   DECREMENT WORD COUNT
       TRA 1,4        RETURN TO CONTINUE
       REM
       REM
ETT    ETTA           CHECK
       TRA ETT1
       ETTB           FOR
       TRA ETT1
       ETTC           PHYSCIAL
       TRA ETT1
       ETTD           END
       TRA ETT1
       ETTE           OF
       TRA ETT1
       ETTF           TAPE
       REM
ETT1   TSX REWA,2
       TRA 1,4
       REM
       REM
REST   TRCA *+1       TURN
       TRCB *+1       OFF
       TRCC *+1       TRC
       TRCD *+1       INDICATORS
       TRCE *+1       IF
       TRCF *+1       ON
       REM
       IOT
       TRA *+1        TURN OFF IOT IND IFON
       REM
       REM
       TEFA *+1       TURN
       TEFB *+1       OFF
       TEFC *+1       END OF FILE
       TEFD *+1       INDICATORS
       TEFE *+1       IF
       TEFF *+1       ON
       REM
       BTTA           TURN
       NOP
       BTTB           OFF
       NOP
       BTTC           BEGINNING
       NOP
       BTTD           OF TAPE
       NOP
       BTTE           INDICATORS
       NOP
       BTTF           IF ON
       NOP
       REM
       ETTA           TURN
       NOP
       ETTB           OFF
       NOP
       ETTC           END OF
       NOP
       ETTD           TAPE
       NOP
       ETTE           INDICATORS
       NOP
       ETTF           IF ON
       NOP
       REM
       TRA 1,4        RETURN
       REM
       REM
CLR    AXT 384,1         CLEAR
       STZ RDFDA+384,1   READ
       TIX *-1,1,1       FIELD
       TRA 1,4
       REM
       REM
*             STEP UNIT ADDRESS
       REM
STPA   TSX CTX,4      STEP CHANNEL A
       HTR REWA,0,A12
       TRA STPF+2
       REM
STPB   TSX CTX,4      STEP CHANNEL B
       HTR REWB,0,B12
       TRA STPF+2
       REM
STPC   TSX CTX,4      STEP CHANNEL C
       HTR REWC,0,C12
       TRA STPF+2
       REM
STPD   TSX CTX,4      STEP CHANNEL D
       HTR REWD,0,D12
       TRA STPF+2
       REM
STPE   TSX CTX,4      STEP CHANNEL E
       HTR REWE,0,E12
       TRA STPF+2
       REM
STPF   TSX CTX,4      STEP CHANNEL F
       HTR REWF,0,F12
       LAC XRC,4      SET XRC FOR RETURN
       TRA 1,4        XFER TO CONTINUE PROGRAM
       REM
       REM
*             ADJUST UTILITY PRINT ROUTINES FOR DESIRED CHANNEL
       REM
       REM
ADJ    CLA CTRL1      SAVE
       STO XRA        CONTROL
       CLA CTRL2      WORDS
       STO XRB        FOR
       CLA CTRL3      ALL
       STO XRC        CHANNELS
       REM
       TSX IOC,4      ENTER CONTROL WORD FOR
       REM            PRINTER ON DESIRED CHANNEL
       REM
       TSX CTX,4
       HTR CH14-1,0,CH14+1
       TSX CTX,4
       HTR WPRA-1,0,WPRA+6
       TSX CTX,4
       HTR PRID,0,PRT2+3
       NOP
       NOP
       REM
       CLA XRA        RESET
       STO CTRL1      CONTROL
       CLA XRB        WORDS
       STO CTRL2      FOR
       CLA XRC        ALL
       STO CTRL3      CHANNELS
       REM
       TRA RUC        CONTINUE PROGRAM
       REM
       REM
* PRINT -  NOW PERFORMING DIAGNOSTICS TEST 9T03
       REM
PRID   SWT 3          TEST SENSE SWITCH 3
       TRA *+2        PRINT TEST IDENTITY
       TRA *+4        BYPASS PRINT
IDN    WPRA 1         PRINT OUT TEST IDENTITY
       SPRA 3         DOUBLE SPACE
       RCHA CTIDN
       WPRA 1         SPACE
       TRA 1,4        RETURN TO MAIN PROGRAM
       REM
       REM
*             SPACE PRINTER
       REM
PRT    WPRA 1
       TCOA *         DELAY
       TRA 1,2        RETURN
       REM
       REM
* PRINT - 9T03    PASS COMPLETE CHN +  TF
       REM
PRT1   WPRA 1
       RCHA CT3
       TCOA *         DELAY
       TRA 1,2        RETURN
       REM
       REM
* PRINT - 9T03    PASS COMPLETE  ALL UNITS
       REM
PRT2   WPRA
       SPRA 3         DOUBLE SPACE
       RCHA CTFIN
       TRA FINL
       REM
       REM
       REM
*             INDIRECT ADDRESSES
       REM
NDRA   HTR A1+2       WTBA X - CURRENT UNIT CHN A
       HTR B1+2       WTBB X - CURRENT UNIT CHN B
       HTR C1+2       WTBB X - CURRENT UNIT CHN C
       HTR D1+2       WTBB X - CURRENT UNIT CHN D
       HTR E1+2       WTBB X - CURRENT UNIT CHN E
       HTR F1+2       WTBB X - CURRENT UNIT CHN F
       REM
       REM
*             CONSTANTS FOR COMPARISON
       REM
WTBA   WTBA 1
       WTBB 1
       WTBC 1
       WTBD 1
       WTBE 1
       WTBF 1
       REM
       WTBA 1
       WTBA 2
       REM
RTBA   RTBA 1
       REM
       REM
MASK   OCT 000000000400 EXCLUSIVE TAPE FRAME
       REM              BIT FOR CHN A,C,E
       OCT 000000040000 EXCLUSIVE TAPE FRAME
       REM              BIT FOR CHN B,D,F
       REM
MASK1  OCT 777700007777
       OCT 000021210000
       OCT 000022220000
       OCT 000023230000
       OCT 000024240000
       OCT 000025250000
       OCT 000026260000
       REM
MASK2  OCT 741737707030
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
CTIDN  IOCD PRIDN,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
       REM
CT1A   IOCD WRFDA,0,64   WRITE 100 WDS - WRFDA
       HTR 0         PROGRAM PROTECT - I-O DISC
CT1B   IOCD WRFDB,0,64   WRITE 100 WDS - WRFDB
       HTR 0         PROGRAM PROTECT - I-O DISC
CT1C   IOCD WRFDC,0,64   WRITE 100 WDS - WRFDC
       HTR 0         PROGRAM PROTECT - I-O DISC
CT1D   IOCD WRFDD,0,64   WRITE 100 WDS - WRFDD
       HTR 0         PROGRAM PROTECT - I-O DISC
CT1E   IOCD WRFDE,0,64   WRITE 100 WDS - WRFDE
       HTR 0         PROGRAM PROTECT - I-O DISC
CT1F   IOCD WRFDF,0,64   WRITE 100 WDS - WRFDF
       HTR 0         PROGRAM PROTECT - I-O DISC
       REM
CT2    IOCD RDFDA,0,64  READ 100 WORDS-CHN A
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD RDFDB,0,64  READ 100 WORDS-CHN B
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD RDFDC,0,64  READ 100 WORDS-CHN C
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD RDFDD,0,64  READ 100 WORDS-CHN D
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD RDFDE,0,64  READ 100 WORDS-CHN E
       HTR 0         PROGRAM PROTECT - I-O DISC
       IOCD RDFDF,0,64  READ 100 WORDS-CHN F
       HTR 0         PROGRAM PROTECT - I-O DISC
CT3    IOCD PR1,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
CT7    IOCD TEMPA,0,1
       HTR           PROGRAM PROTECT - I-O DISC
       IOCD TEMPB,0,1
       HTR           PROGRAM PROTECT - I-O DISC
       IOCD TEMPC,0,1
       HTR           PROGRAM PROTECT - I-O DISC
       IOCD TEMPD,0,1
       HTR           PROGRAM PROTECT - I-O DISC
       IOCD TEMPE,0,1
       HTR           PROGRAM PROTECT - I-O DISC
       IOCD TEMPF,0,1
       HTR           PROGRAM PROTECT - I-O DISC
       REM
CT10A  IOCD WRFDA
       HTR 0         PROGRAM PROTECT - I-O DISC
CT10B  IOCD WRFDB
       HTR 0         PROGRAM PROTECT - I-O DISC
CT10C  IOCD WRFDC
       HTR 0         PROGRAM PROTECT - I-O DISC
CT10D  IOCD WRFDD
       HTR 0         PROGRAM PROTECT - I-O DISC
CT10E  IOCD WRFDE
       HTR 0         PROGRAM PROTECT - I-O DISC
CT10F  IOCD WRFDF
       HTR 0         PROGRAM PROTECT - I-O DISC
       REM
CT12A  IOCD RDFDA
       HTR 0         RECORDS
CT12B  IOCD RDFDB
       HTR 0         PROGRAM PROTECT - I-O DISC
CT12C  IOCD RDFDC
       HTR 0         PROGRAM PROTECT - I-O DISC
CT12D  IOCD RDFDD
       HTR 0         PROGRAM PROTECT - I-O DISC
CT12E  IOCD RDFDE
       HTR 0         PROGRAM PROTECT - I-O DISC
CT12F  IOCD RDFDF
       HTR 0         PROGRAM PROTECT - I-O DISC
CTFIN  IOCD FNPT,0,24
       HTR 0         PROGRAM PROTECT - I-O DISC
       REM
XRA    OCT 0
XRB    OCT 0
XRC    OCT 0
TEMP   OCT
TEMP1  OCT 00000000000
TEMP2  OCT 00000000000
TEMP3  OCT 00000000000
TEMPA  OCT +0         TEMPORARY STORAGE - CHN A
TEMPB  OCT +0         TEMPORARY STORAGE - CHN B
TEMPC  OCT +0         TEMPORARY STORAGE - CHN C
TEMPD  OCT +0         TEMPORARY STORAGE - CHN D
TEMPE  OCT +0         TEMPORARY STORAGE - CHN E
TEMPF  OCT +0         TEMPORARY STORAGE - CHN F
       REM
       REM
*             TRANSFER TABLE
       REM
TRA1   TRA RUC
TRA2   TRA AA
TRA3   TRA A9
       TRA B9
       TRA C9
       TRA D9
       TRA E9
       TRA F9
       REM
TRA4   TRA STPA
       REM
       REM
SLT2   SLT 2
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
WDCT   OCT
       OCT            INITIAL WR ADDR + COUNT
K1     NOP
       TSX REWA,2
K2     OCT +400       RANDOM RECORD COUNT
       OCT 622
       OCT 300
       OCT 60
       OCT +26
       TRA AA         REPEAT PROGRAM
       OCT +200
       OCT +7000
       OCT +375
       REM
K3     HTR WRFDA
       HTR WRFDB
       HTR WRFDC
       HTR WRFDD
       HTR WRFDE
       HTR WRFDF
       HTR K11
       REM
K3A    HTR RDFDA      LOC OF READFIELD CHN A
       HTR RDFDB      LOC OF READFIELD CHN B
       HTR RDFDC      LOC OF READFIELD CHN C
       HTR RDFDD      LOC OF READFIELD CHN D
       HTR RDFDE      LOC OF READFIELD CHN E
       HTR RDFDF      LOC OF READFIELD CHN F
       REM
K3B    HTR WRFDA+64,1
       HTR WRFDB+64,1
       HTR WRFDC+64,1
       HTR WRFDD+64,1
       HTR WRFDE+64,1
       HTR WRFDF+64,1
       REM
K3C    HTR RDFDA+64
       HTR RDFDB+64
       HTR RDFDC+64
       HTR RDFDD+64
       HTR RDFDE+64
       HTR RDFDF+64
       REM
K4A    IORP RDFDA,0,30
       IOCD K4A+1
       OCT +0
       IOCD K4A+1,0,K4A+2
       IORP RDFDA,0,K4A+1
K4B    IORP RDFDB,0,30
       IOCD K4B+1
       OCT +0
       IOCD K4B+1,0,K4B+2
       IORP RDFDB,0,K4B+1
K4C    IORP RDFDC,0,30
       IOCD K4C+1
       OCT +0
       IOCD K4C+1,0,K4C+2
       IORP RDFDC,0,K4C+1
K4D    IORP RDFDD,0,30
       IOCD K4D+1
       OCT +0
       IOCD K4D+1,0,K4D+2
       IORP RDFDD,0,K4D+1
K4E    IORP RDFDE,0,30
       IOCD K4E+1
       OCT +0
       IOCD K4E+1,0,K4E+2
       IORP RDFDE,0,K4E+1
K4F    IORP RDFDF,0,30
       IOCD K4F+1
       OCT +0
       IOCD K4F+1,0,K4F+2
       IORP RDFDF,0,K4F+1
K5     OCT +77
       OCT +101
K6     OCT +17
       OCT +1000
       OCT +1001
       OCT +100
       OCT +101
       OCT +36
       OCT +20
       OCT +102
K8     OCT +377777777767
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
       ORG K11+8
       REM
WRFDA  BSS 64
WRFDB  BSS 64
WRFDC  BSS 64
WRFDD  BSS 64
WRFDE  BSS 64
WRFDF  BSS 64
       REM
RDFDA  BSS 64
RDFDB  BSS 64
RDFDC  BSS 64
RDFDD  BSS 64
RDFDE  BSS 64
RDFDF  BSS 64
       REM
       REM
       REM
*             PRINT FIELDS
       REM
       REM
* IMAGE -  NOW PERFORMING DIAGNOSTIC TEST 9T03
       REM
PRIDN  OCT 002241004010  9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000000000000  8 L
       OCT 000000000000  8 R
       OCT 010010200000  7 L
       OCT 000000000000  7 R
       OCT 141400040000  6 L
       OCT 000000000000  6 R
       OCT 204020100200  5 L
       OCT 000000000000  5 R
       OCT 000102000000  4 L
       OCT 000000000000  4 R
       OCT 000000012445  3 L
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
* IMAGE - 9T03    PASS COMLETE   CHN +  TF
       REM
PR1    OCT 400000000000  9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000000002000  8 L
       OCT 000000000000  8 R
       OCT 001002000000  7 L
       OCT 000000000000  7 R
       OCT 000010000010  6 L
       OCT 000000000000  6 R
       OCT 000000501000  5 L
       OCT 000000000000  5 R
       OCT 000004000000  4 L
       OCT 000000000000  4 R
       OCT 240021204020  3 L
       OCT 000000000000  3 R
       OCT 000300000000  2 L
       OCT 000000000000  2 R
       OCT 000400000000  1 L
       OCT 000000000000  1 R
       OCT 300300200020  0 L
       OCT 000000000000  0 R
       OCT 001017001000  11 L
       OCT 000000000000  11 R
       OCT 000420506210  12 L
       OCT 000000000000  12 R
       REM
       REM
* IMAGE - 9T03     PASS COMPLETE ALL UNITS
       REM
FNPT   OCT 400000000040  9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000000000000  8 L
       OCT 000000000000  8 R
       OCT 001002000000  7 L
       OCT 000000000000  7 R
       OCT 000010000000  6 L
       OCT 000000000000  6 R
       OCT 000000500100  5 L
       OCT 000000000000  5 R
       OCT 000004000200  4 L
       OCT 000000000000  4 R
       OCT 240021203020  3 L
       OCT 000000000000  3 R
       OCT 000300000010  2 L
       OCT 000000000000  2 R
       OCT 000400004000  1 L
       OCT 000000000000  1 R
       OCT 300300200230  0 L
       OCT 000000000000  0 R
       OCT 001017003100  11 L
       OCT 000000000000  11 R
       OCT 000420504040  12 L
       OCT 000000000000  12 R
       REM
       REM
*             EQUIVALENT ADDRESSES
       REM
ERROR  EQU 3396
OK     EQU 3401
RDNCK  EQU 3440
WDNO   EQU 3438
RECNO  EQU 3439
       REM
CH14   EQU 3632
WPRA   EQU 3841
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
       REM
       END
