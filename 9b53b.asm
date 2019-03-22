                                                             9 B 5 3 B
                                                            3/1/61
       REM 9B53B
       REM
*      9B03B-WORST CASE B TIME
       REM
       ORG 24
       CLA SW6+2     POST
       STO 0         RESTART
       REM
       SWT 3
       TRA *+2
       TRA *+3
BEGIN  WPRA
       RCHA STCTL    CONTROL FOR PRINTING
       REM           STARTING HEADING
       REM
       TSX IOC,4     ENTER CONTROL WORDS
       REM
       CLA CTRL1     L CONTROL WORD
       TMI *+4       FIX SELECT
       CLA READ5+2   IF THE SIGN
       SUB ONE       KEY WAS
       STO SW6+5     DEPRESSED
       REM
       ZET CTRA      SEE IF CHN. A IS ON LINE
       TRA *+4       NO ZERO
       REM
       TSX CTX,4     MODIFY PROGRAM FOR
       REM           FIRST UNIT TO BE TESTED
       HTR ABLE-4,0,OR2+1
       TRA IONT+1
       CLA CTRL1
       ANA EXCL      MASK OUT CHN A
       ORA EXCL+1    OR IN EXCL UNIT TWO
       SLW CTRL1
IONT   TSX IOCNT,4
       REM
       TRA CHNG
       CLA COUNT     SWITCH TO BYPASS
       TNZ TEST      INITIAL SECTIONS
       REM
* ROUTINES FROM THIS POINT TO SYMBOLIC LOCATION ***TEST*** WILL CHECK
* BUFFER AND SYNCHRONIZER INSTRUCTIONS FOR ALL THE CHANNELS SELECTED
       REM
* THE FOLLOWING ROUTINES WILL BE MODIFIED FOR ALL CHANNELS BY IOC
       REM
       REM
       ETTA
       REWA 2
       TRA *+2
       REM
       BCD 1TCOA     TEST TRANS CHANNEL A IN OPN
       REM
ABLE   WTBA 2
       TCOA *+3      CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL ABLE
       REM
       RCHA CNTL     NO TRGS ON-WORD. CNT. 1
       TCOA *+3      SHOULD TRANS.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL ABLE
       REM
       TCOA *        IF UNIT RUNS AWAY,OR
       REM           MACHINE HANGS ON THIS
       REM           OR ANY PREVIOUS TCOA
       REM           OPN.,BUFFER MAY NOT BE
       REM           RECEIVING END OPER. FROM
       REM           SYNC.
       TCOA *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 TRANS. IN ERROR-TCOA
       TXL ABLE
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA ABLE      REPEAT
       REM
       BCD 1TCNA     TEST TRANS. CHAN NOT IN OPN
       REM
BAKER  TCNA *+3      SHOULD TRANS.
       TSX ERROR-1,4 FAILED TO TRANS.
       TXL BAKER
       REM
       WTBA 2
       TCNA *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL BAKER
       REM
       RCHA CNTL+1   NO TGRS. ON-WRD. CNT. 1
       TCNA *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL BAKER
       REM
       TCOA *
       TCNA *+3      SHOULD TRANS.
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL BAKER
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA BAKER     REPEAT
       REM
       BCD 1BTTA     TEST BEGIN. TAPE
       REM
CHUCK  REWA 2
       BSRA 2        BACKSPACE TO LOAD PT.
       REWA 2        SHOULD ACT AS NOP
       BSRA 2        TRY TO BACKSP OVER LD. PT.
       TCOA *        DELAY
       REM           BEGIN. TAPE TGR. SHOULD
       REM           BE TURNED ON HERE
       BTTA
       TRA *+3       OK-SHOULD BE ON
       TSX ERROR-1,4 SHLD NOT SKIP TO ENTER HERE
       TXL CHUCK
       REM
       BTTA
       TRA *+2       ERROR-BTT SHOULD BE OFF
       TRA *+3       OK-OFF
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL CHUCK
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA CHUCK
       REM
       BCD 1IOT      TEST I/O CHECK TGR.
       REM
DOG    WTBA 2
       RCHA CNTL     NO TGRS. ON-WRD. CNT. 1
       TCOA *
       LCHA CNTL+1   SHOULD TURN ON IOT
       IOT
       TRA *+3       SHOULD ENTER HERE-OK
       TSX ERROR-1,4 ERROR-SHOULD NOT SKIP
       TXL DOG
       REM
       IOT
       TRA *+2       ERROR-TGR WAS NOT TURNED
       REM           OFF BY PREVIOUS SEQUENCE
       TRA *+3       OK-TGR SHOULD BE OFF
       TSX ERROR-1,4
       TXL DOG
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA DOG
       REM
       BCD 1WEFA     TEST TO SEE THAT WEF
       REM           BCD OR BINARY, BOTH
       REM           WRITE TAPE MARKS
       REM
* WRITE 1 WORD RECORD OF 1-S, AN EOF, 1 WORD RECORD OF 0-S AND AN EOF
       REM
       WTDA 2        WRITE 1 WORD RECORD OF 1-S
       RCHA CNTL     NO TRGS. ON-WRD. CNT. 1
       WEFA 2        BCD EOF
       WTBA 2        WRITE 1 WORD RECORD OF 0-S
       RCHA CNTL+1   NO. TGRS ON-WRD. CNT. 1
       WEFA 18       BINARY EOF, SHOULD
       REM           WRITE BCD TAPE MARK
       TRA *+2
       REM
       BCD 1BSRA 1
       REM
EASY   BSRA 18
       BSRA 2
       RTBA 2        READ 1 WORD RECORD OF 0-S
       RCHA CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOA *
       REM
       AXT 3,2       L 3 IN XRB
       SXA WDNO,2    ADJUST PRINTOUT  76413
       AXT 64,1
       SXA RDNCK,1     764X7
       TIX *+1,2,2   ..... NUMBER
       TIX *,1,1
       REM
*     CHECK 2ND WRD IS ZERO AND FOR EOF AT THE RECORD
       REM
       CLA READ      WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP EASY      DO NOT REPEAT
       TSX RDNCK,4
       TRA EASY
       REM
       TEFA *+3      SHOULD TRANS.
       TSX ERROR-1,4 EOF DID NOT COME UP
       TXL GEORG
       TRA *+2
       REM
       BCD 1BSFA 2
       REM
FOX    BSFA 2        BKSP OVER EOF
       BSFA 2        BKSP OVER EOF AND 1 REC
       BSRA 2        BKSP OVER 1 REC
       RTDA 2
       RCHA CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOA *        TO READ ONE WD AND BCD EOF
       TRA *+2       CONTINUE
       REM
       BCD 1TEFA     TEST EOF TGR + INDICATOR
       REM
GEORG  TEFA *+3      SHOULD TRANS.
       TSX ERROR-1,4
       TXL GEORG,4,0 DO NOT REPEAT
       REM
       TEFA *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 ERROR-TGR SHOULD BE OFF
       TXL GEORG,4,0 DO NOT REPEAT
       REM
       RTBA 2
       RCHA CNTLR+2  NO TGRS ON-WRD CNT 2
       REM           TO READ ONE WD AND BIN EOF
       TCOA *        DELAY
       TRA *+2
       REM
       BCD 1 TEFA    TEST EOF TGR + INDICATOR
       REM
       TEFA *+3
       TSX ERROR-1,4
       TXL *-2,4,0   DO NOT REPEAT
       REM
*      CHECK 1ST RECORD IS ONES
       REM
       AXT 2,2       L 2 IN XRB
       CLA READ      WORD READ
       LDQ ONES      WORD WRITTEN
       CAS ONES
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4,1 TO ERROR ROUTINE
       NOP FOX
       TSX RDNCK,4   TEST RDNCY
       TRA FOX
       REM
*      CHECK 2ND RECORD IS ZEROS
       REM
       CLA READ+2    WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TIX *+3,2,1   ERROR
       TRA *+4       OK
       TIX *+1,2,1   ERROR
       TSX ERROR-2,4,1 TO ERROR ROUTINE
       NOP FOX
       TSX OK,4      OUT TO TEST SWITCHES
       TRA FOX
       REM
*     PERFORM TAPE OPERATION AND EXECUTE ORS INSTRUCTION
       REM
       BCD 1RTBORS
       REM
OR     AXC *+4,4     2-S COMPLEMENT TO XRC
       AXT 512,1     L 1000 IN XRA
       STZ RCHA+512,1 CLEAR THISE
       TIX *-1,1,1    LOCATIONS
       TRA 1,4        PROCEED
       REM
*      WRITE 1000 OCTAL WORD RECORD OF ZEROS
       REM
       WTBA 2        1000 WORDS
       RCHA ORWRD    OF ZEROS
       LCHA ORWRD+1  ON TAPE
       REM
       ETTA          CHECK FOR END OF TAPE
       TRA *+3       REACHED END OF TAPE
       TCOA *-2      REPEAT CHECKING FOR EOT
       TRA *+4       NO END OF TAPE, PROCEED
       REM
       RDCA          BLAST THE CHANNEL
       XEC IONT+5    REWIND TAPE AT EOT
       TRA OR        REPEAT ROUTINE
       REM
       BSRA 2        BACKSPACE RECORD
       AXT 512,1     L 1000 IN XRA
       PXD           CLEAR ACCUMLATOR
       COM           ACC Q-35 NOR ONES
       SLW RCHA+512,1 STORE 1-S IN
       TIX *-1,1,1    READ FIELD
       COM           ACCUMULATOR NOW ZEROS
       REM
*      READ TAPE AND EXECUTE 100 SUCCESSIVE ORS
       REM
       RTBA 2        START
       RCHA ORWRD    READING
       LCHA ORWRD+1  TAPE
       REM
OR1    ORS ORTST     EXECUTE SUCCESSIVE ORS
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
       ORS ORTST
OR2    TCOA OR1      ORS IF CHANNEL IN OPERATION
       REM
       AXT 513       WORD NUMBER
       SXA WDNO,1    AND
       AXT 2,2       RECORD NUMBER
       SXA RECNO,2   FOR ERRORS
       TIX *+1,1,1   1000 IN XRA
       TIX *+2,2,1   2 IN XRB
       REM
*      CHECK LOCATIONS IN READ FIELD ARE ZEROS
       REM
       CLA RCHA+512,1 L CONTENTS READ FIELD
       TZE *+4       ARE LOCATIONS IN ZERO
       LDQ ZEROS     NO, CLEAR MQ
       TSX ERROR-2,4,1 CHECK CIRCUIT 3G
       NOP OR        SYSTEMS PAGE 2.09.00.1
       TIX *-5,1,1   CHECK 1000 OCTAL LOCATION
       REM
       CLA ORTST     CHECK ORS LOCATION
       CAS ONES      IS LOCATION 1-S
       TRA *+2       NO
       TRA *+3       YES
       LDQ ONES      1-S TO MQ
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4
       TRA OR
       REM
       NOP
       TSX OR+1,4    TO CLEAR READ FIELD
       REM
       TSX CTX,4
       HTR ABLE-4,0,OR2+1
       CLA IOCT
       SUB ONE
       STO IOCT
       TNZ IONT+4    CHECK ALL TAPE UNITS
       REM
       STL COUNT
       REM
       REM
*THIS SECTION WRITES A 100 WORD RECORD ON ALL CHANNELS
*SELECTED TO MOVE FROM LOAD POINT, THEN REPEAT THE SAME RECORD FOR TEST.
       REM
TEST   AXT 300,1
       AXT 65,2
       REM
       NZT CTRA      TEST FOR CHANNEL-A
       TRA *+3       NO-GO TO B
       WTBA 2        WRITE CHANNEL-A
       RCHA WR1
       NZT CTRB      TEST FOR CHANNEL-B
       TRA *+3       NO-GO TO C
       WTBB 1        WRITE CHANNEL-B
       RCHB WR2
       NZT CTRC      TEST FOR CHANNEL-C
       TRA *+3       NO-GO TO D
       WTBC 1        WRITE CHANNEL C
       RCHA WR3
       NZT CTRD      TEST FOR CHANNEL-D
       TRA *+3       NO-GO TO E
       WTBD 1        WRITE CHANNEL-D
       RCHD WR4 
       NZT CTRE      TEST FOR CHANNEL-E
       TRA *+3       NO-GO TO F
       WTBE 1        WRITE CHANNEL E
       RCHE WR5
       NZT CTRF      TEST FOR CHANNEL-F
       TRA *+3       NO-GO TO G
       WTBF 1        WRITE CHANNEL-F
       RCHF WR6
       NZT CTRG      TEST FOR CHANNEL-G
       TRA *+3       NO-GO TO H
TEST2  WTBG 1        WRITE CHANNEL-G
       RCHG WR7     
       NZT CTRH      TEST FOR CHANNEL-H
       TRA *+3       NO
       WTBH 1        WRITE CHANNEL-H
       RCHH WR10
       TRA CLEAR+5
       TIX TEST+2,2,1 TAPE WILL BE WRITTEN 101
       REM           TIMES. THE FIRST TIME
       REM           TO MOVE FROM LOAD POINT
       REM
       TSX OK,4
       TRA TEST+2
       NOP
       REM
*START WORST CASE SECTION
       REM
       TRA *+2
       REM
       BCD 1WTB
       REM
       TSX RDNCK,4   TEST FOR TAPE CHECKS
       NOP *-1
       REM
*THIS SECTION READS A 100 WORD RECORD FROM EACH CHANNEL SELECTED
*WHILE ANS INDIRECTLY ADDRESSED GOES ON IN MF
       REM
*TEST FOR BACKSPACE
       REM
       SWT 5         TEST SWITCH #5
       TRA ANS       TRY TO PIN POINT TROUBLE
       REM           TEST WORST CASE
       REM
       REM
       AXT 64,2
RPEAT  NZT CTRA 
       TRA *+2
       BSRA 2
       NZT CTRB
       TRA *+2
       BSRB 1
       NZT CTRC
       TRA *+2
       BSRC 1
       NZT CTRD
       TRA *+2
       BSRD 1
       NZT CTRE
       TRA *+2
       BSRE 1
       NZT CTRF
       TRA *+2
       BSRF 1
       NZT CTRG
       TRA *+2
       BSRG 1
       NZT CTRH
       TRA *+2
       BSRH 1
       TIX RPEAT,2,1 BACKSPACE 100 RECS.
       REM
       AXT 64,2
READ5  NZT CTRA  
       TRA *+3   
       RTBA 2        READ TAPE CHAN A
       RCHA CCHA
       NZT CTRB
       TRA *+3
       RTBB 1        READ TAPE CHAN B
       RCHB **   
       NZT CTRC
       TRA *+3
       RTBC 1        READ TAPE CHAN C
       RCHC **
       NZT CTRD
       TRA *+3
       RTBD 1        READ TAPE CHAN D
       RCHD **
       NZT CTRE 
       TRA *+3   
       RTBE 1        READ TAPE CHAN E
       RCHE **
       NZT CTRF 
       TRA *+3   
       RTBF 1        READ TAPE CHAN F
       RCHF **
       NZT CTRG
       TRA *+3
       RTBG 1        READ TAPE CHAN G
       RCHG **
       NZT CTRH 
       TRA *+3   
       RTBH 1        READ TAPE CHAN H
       RCHH **
       REM
       ANS* SAVE     CONTINUOUS
       ANS* SAVE     ANS INDIRECTLY
       ANS* SAVE     ADDRESSED
       ANS* SAVE     THESE INSTRUCTIONS
       ANS* SAVE     SHOULD NOT
       ANS* SAVE     INTERRUPT OR,
       ANS* SAVE     SHARE FOR
       ANS* SAVE     B TIME
       ANS* SAVE     FROM
       ANS* SAVE     BUFFER
       TIX *-10,1,1
       REM
       TSX OK,4
       TRA RPEAT
       NOP
       REM
TCO    TCOA *        DELAY
       TCOB *        TO
       TCOC *        ENABLE
       TCOD *        SCH TO
       TCOE *        GET CORRECT
       TCOF *        INFORMATION
       TCOG *
       TCOH *
       REM
       NZT CTRA      TEST FOR CHAN A
       TRA *+2 
       SCHA SCH
       NZT CTRB      TEST FOR CHAN B
       TRA *+2 
       SCHB SCH+1
       NZT CTRC      TEST FOR CHAN C
       TRA *+2 
       SCHC SCH+2
       NZT CTRD      TEST FOR CHAN D
       TRA *+2 
       SCHD SCH+3
       NZT CTRE      TEST FOR CHAN E
       TRA *+2 
       SCHE SCH+4
       NZT CTRF      TEST FOR CHAN F
       TRA *+2 
       SCHF SCH+5
       NZT CTRG      TEST FOR CHAN G
       TRA *+2 
       SCHG SCH+6
       NZT CTRH      TEST FOR CHAN H
       TRA *+2 
       SCHH SCH+7
       REM
       CLA CT
       STO WDNO
       STO RECNO
       REM
       TRA *+2
       REM
*THE ROUTINES FROM THIS POINT TO END OF PROGRAM, TESTS FOR THE CHECKS,
*IOT LIGHT, INFORMATION STORED FROM CHANNELS, END OF FILE, AND INFORMATION
*TRANSMITTED FOR ALL CHANNELS SELECTED
       REM
       BCD 1RTB
       REM
       TSX RDNCK,4   CHECK REDUNDANCY
       NOP *-1
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       REM
       NZT CTRA      TEST FOR CHANS A
       TRA TRB       NO-GO TO B
       TRA *+2       YES
       REM
       BCD 1SCHA
       REM
       CLA SCH       WORD FROM CHANNEL
       LDQ CINFO     CORRECT INFORMATION
       CAS CINFO
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1 TEFA
       REM
       TEFA *+2      ERROR
       TRA *+5       OK
       TSX ERROR-1,4 EXIT HERE WILL INDICATE
       TXL *-3,4     A DISCONNECT ON A FALSE EOF
       TRA *+2       CHANNEL A
       REM
       BCD 1RTBA 2
       REM
       AXT 64,1
       CLA RCHA+64,1 WORD READ
       LDQ WTCHA+64,1 WORD GENERATED
       CAS WTCHA+64,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP *-7
       TIX *-7,1,1   RETURN TO CHECK ALL WORDS
       TRA *+2
       REM
       BCD 1SCHB
       REM
TRB    NZT CTRB      TEST FOR CHN. B
       TRA TRC       NO-GO TO C
       CLA SCH+1     WORD FROM CHANNEL
       LDQ CINFO+1   CORRECT INFORMATION
       CAS CINFO+1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1 TEFB
       REM
       TEFB *+2      ERROR
       TRA *+5
       TSX ERROR-1,4 EXIT HERE WILL
       TXL *-3,4     INDICATE FALSE EOF
       TRA *+2       CHANNEL B
       REM
       BCD 1RTBB 1
       REM
       AXT 64,1
       CLA RCHB+64,1 WORD READ
       LDQ WTCHB+64,1 WORD GENERATED
       CAS WTCHB+64,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP *-7
       TIX *-7,1,1   RETURN TO CHECK ALL WORDS
       REM
       TRA *+2       YES
       REM
       BCD 1SCHC
       REM
TRC    NZT CTRC      TEST FOR CHN. C
       TRA TRD       NO-GO TO D
       CLA SCH+2     WORD FROM CHANNEL
       LDQ CINFO+2   CORRECT INFORMATION
       CAS CINFO+2
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1TEFC
       REM
       TEFC *+2      ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       TXL *-3,4
       TRA *+2
       REM
       BCD 1RTBC
       REM
       AXT 64,1
       CLA RCHC+64,1 WORD READ
       LDQ WTCHC+64,1 WORD GENERATED
       CAS WTCHC+64,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP *-7
       TIX *-7,1,1   RETURN TO CHECK ALL WORDS
       TRA *+2
       REM
       BCD 1SCHD
       REM
TRD    NZT CTRD      TEST FOR CHN. D
       TRA TRE       NO-GO TO E
       CLA SCH+3     WORD FOR CHANNEL
       LDQ CINFO+3   CORRECT INFORMATION
       CAS CINFO+3
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1TEFD
       REM
       TEFD *+2      ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       TXL *-3,4
       TRA *+2
       REM
       BCD 1RTBD 1
       REM
       AXT 64,1
       CLA RCHD+64,1 WORD READ
       LDQ WTCHD+64,1 WORD GENERATED
       CAS WTCHD+64,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP *-7
       TIX *-7,1,1   RETURN TO CHECK ALL WORDS
       REM
       TRA *+2 
       REM
       BCD 1SCHE
       REM
TRE    NZT CTRE      TEST FOR CHN. E
       TRA TRF       NO-GO TO F
       CLA SCH+4     WORD FROM CHANNEL
       LDQ CINFO+4   CORRECT INFORMATION
       CAS CINFO+4
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1TEFE
       REM
       TEFE *+2      ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       TXL *-3,4
       TRA *+2
       REM
       BCD 1RTBE
       REM
       AXT 64,1
       CLA RCHE+64,1 WORD READ
       LDQ WTCHE+64,1 WORD GENERATED
       CAS WTCHE+64,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP *-7
       TIX *-7,1,1   RETURN TO CHECK ALL WORDS
       TRA *+2
       REM
       BCD 1SCHF
       REM
TRF    NZT CTRF      TEST FOR CHN. F
       TRA TRG       NO-GO TO G
       CLA SCH+5     WORD FROM CHANNEL
       LDQ CINFO+5   CORRECT INFORMATION
       CAS CINFO+5
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1TEFF
       REM
       TEFF *+2      ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       TXL *-3,4
       TRA *+2
       REM
       BCD 1RTBF 1
       REM
       AXT 64,1
       CLA RCHF+64,1 WORD READ
       LDQ WTCHF+64,1 WORD GENERATED
       CAS WTCHF+64,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP *-7
       TIX *-7,1,1   RETURN TO CHECK ALL WORDS
       TRA *+2 
       REM
       BCD 1SCHG
       REM
TRG    NZT CTRG      TEST FOR CHN. G
       TRA TRH       NO-GO TO H
       CLA SCH+6     WORD FROM CHANNEL
       LDQ CINFO+6   CORRECT INFORMATION
       CAS CINFO+6
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1TEFG
       REM
       TEFG *+2      ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       TXL *-3,4
       TRA *+2
       REM
       BCD 1RTBG 1
       REM
       AXT 64,1
       CLA RCHG+64,1 WORD READ
       LDQ WTCHG+64,1 WORD GENERATED
       CAS WTCHG+64,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP *-7
       TIX *-7,1,1   RETURN TO CHECK ALL WORDS
       TRA *+2
       REM
       BCD 1SCHH
       REM
TRH    NZT CTRH      TEST FOR CHN. H
       TRA CLEAR     NO-GO TO CLEAR READ AREA
       CLA SCH+7     WORD FROM CHANNEL
       LDQ CINFO+7   CORRECT INFORMATION
       CAS CINFO+7
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1TEFH
       REM
       TEFH *+2      ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       TXL *-3,4
       TRA *+2
       REM
       BCD 1RTBH 1
       REM
       AXT 64,1
       CLA RCHH+64,1 WORD READ
       LDQ WTCHH+64,1 WORD GENERATED
       CAS WTCHH+64,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP *-7
       TIX *-7,1,1   RETURN TO CHECK ALL WORDS
       REM
*CLEAR READ FIELD AREAS
       REM
CLEAR  AXT 512,1     L 1000 IN XRA
       STZ RCHA+512,1
       TIX *-1,1,1
       TIX READ5,2,1 REPEAT 100 TIMES
       TRA PRINT     PASS COMPLETE
       REM
       REM
       NZT CTRA 
       TRA *+3
       ETTA
       TRA EOT       REWIND
       NZT CTRB 
       TRA *+3
       ETTB
       TRA EOT       REWIND
       NZT CTRC 
       TRA *+3
       ETTC
       TRA EOT       REWIND
       NZT CTRD 
       TRA *+3
       ETTD
       TRA EOT       REWIND
       NZT CTRE 
       TRA *+3
       ETTE
       TRA EOT       REWIND
       NZT CTRF 
       TRA *+3
       ETTF
       TRA EOT       REWIND
       NZT CTRG 
       TRA *+3
       ETTG
       TRA EOT       REWIND
       NZT CTRH 
       TRA *+3
       ETTH
       TRA EOT       REWIND
       TRA TEST2+7   CONTINUE WRITING
       REM
       REM
       REM
       REM
SW6    SWT 6         TEST SWITCH 6
       TRA *+2       UP-TURN ON LITE 1
       REM           AND GO TO REWIND
       TRA BEGIN+2   DOWN-RETURN TO
       REM           ENTER KEYS
       SLN 1
       TRA EOT       REWIND TAPES
       REM
       REM
       RCDA          CALL IN
       RCHA *+3      NEXT PROGRAM
       LCHA 0
       TRA 1
       REM
       IOCT 0,0,3
       REM
CHNG   CLA ZEROS
       AXT 8,1       L-10
       ZET CTRA+8,1  ZERO TEST CTRA-CTRH
       ADD ONE       ADD ONE FOR EACH UNIT
       TIX *-2,1,1   TIX UNTIL EIGHT CHNS CHECKED
       REM
       REM
       STO CNT       NUMBER OF UNITS ON LINE
       NZT CNT 
       HTR BEGIN+2   NO UNITS ON LINE
HERE   CLA BUFTM     THIS IS 72 US X100
       LRS 35        MACH CYCLE X 100
       CLM
       DVP MCYCL
       XCA
       SUB SIX
       XCA
       STQ BUF1      WORST CASE TIME
       REM           BETWEEN BDW ON
       REM           ONE CHANNEL.
       CLM 
       DVP CNT       NO. OF CHANNELS
       REM           ON LINE.
       STQ BUBAS     BASIC B CYCLES FOR
       REM           ALL CHANNELS.
       CLA BUBAS
       MPY CNT
       STQ TEM
       CLA BUF1
       SUB TEM
       STO TEM       NO. OF CHANNELS
       REM           NEEDING AN EXTRA
       REM           BCW
       CLA TCH       ORIGINAL TCH
       NZT CTRA      TEST FOR CHANNEL A
       TRA BEE       NO
       REM
       TSX CNVRT,4   ALTER INDEX COUNT NUMBER
       STA READ5+3   YES-STORE ADDRESS OF FIRST
       REM           COMMAND IN RCHA
       LDQ IOCPA     GENERATE
       AXT 63,4      COMMANDS
       LXA BCYCL,2   
       STA *+3       CHANNEL
       ADD ONE       A
       XCL
       SLW
       ADD ONE
       XCL
       STA *+2
       ADD ONE
       SLW
       TIX *-3,1,1
       TIX *-11,4,1
       LDQ IOCDA
       STA *+1
       STQ
       ADD ONE
       PAX ,1        STORE PROPER CONSTANT TO TEST
       SXD CINFO,1   STORE CHANNEL
BEE    NZT CTRB      TEST FOR CHANNEL B
       TRA CEE
       TSX CNVRT,4   ALTER INDEX COUNT NUMBER
       STA READ5+7   STORE ADDR OF FIRST
       STA RD10+7    COMMAND IN RCHB
       LDQ IOCPB     B
       AXT 63,4
       LXA BCYCL,2
       STA *+3
       ADD ONE
       XCL
       SLW
       ADD ONE
       XCL
       STA *+2
       ADD ONE
       SLW
       TIX *-3,2,1
       TIX *-11,4,1
       LDQ IOCDB
       STA *+1
       STQ
       ADD ONE
       PAX ,1
       SXD CINFO+1,1
CEE    NZT CTRC      TEST FOR CHANNEL C
       TRA DEE       NO
       TSX CNVRT,4   ALTER INDEX COUNT NUMBER
       STA READ5+11  YES-STORE ADDRESS OF FIRST
       STA RD10+11   COMMAND IN RCHC
       LDQ IOCPC     C
       AXT 63,4
       LXA BCYCL,2
       STA *+3
       ADD ONE
       XCL
       SLW
       ADD ONE         
       XCL
       STA *+2
       ADD ONE
       SLW
       TIX *-3,1,1
       TIX *-11,4,1     
       LDQ IOCDC
       STA *+1
       STQ
       ADD ONE
       PAX ,1
       SXD CINFO+2,1  
DEE    NZT CTRD       TEST FOR CHANNEL D
       TRA EEE        NO
       TSX CNVRT,4    ALTER INDEX COUNT NUMBER
       STA READ5+15
       STA RD10+15
       LDQ IOCPD     D
       AXT 63,4
       LXA BCYCL,2
       STA *+3
       ADD ONE
       XCL               
       SLW
       ADD ONE
       XCL
       STA *+2
       ADD ONE
       SLW
       TIX *-3,2,1
       TIX *-11,4,1
       LDQ IOCDD          
       STA *+1
       STQ
       ADD ONE
       PAX ,1
       SXD CINFO+3,1
EEE    NZT CTRE      TEST FOR CHANNEL E
       TRA FFF    
       TSX CNVRT,4   ALTER INDEX COUNT NUMBER
       STA READ5+19  YES
       STA RD10+19
       LDQ IOCPE
       AXT 63,4
       LXA BCYCL,2
       STA *+3
       ADD ONE
       XCL
       SLW
       ADD ONE
       XCL     
       STA *+2
       ADD ONE
       SLW
       TIX *-3,1,1
       TIX *-11,4,1
       LDQ IOCDE 
       STA *+1
       STQ
       ADD ONE
       PAX ,1
       SXD CINFO+4,1
FFF    NZT CTRF      TEST FOR CHANNEL F
       TRA GGG       NO
       TSX CNVRT,4   ALTER INDEX COUNT NUMBER
       STA READ5+23
       STA RD10+23
       LDQ IOCPF     F
       AXT 63,4
       LXA BCYCL,2
       STA *+3  
       ADD ONE
       XCL
       SLW
       ADD ONE
       XCL
       STA *+2
       ADD ONE
       SLW
       TIX *-3,2,1
       TIX *-11,4,1
       LDQ IOCDF
       STA *+1
       STQ
       ADD ONE
       PAX ,1
       SXD CINFO+5,1
GGG    NZT CTRG
       TRA HHH    
       TSX CNVRT,4   ALTER INDEX COUNT NUMBER
       STA READ5+27  YES
       STA RD10+27
       REM           OF FIRST COMMAND
       LDQ IOCPG     GENERATE COMMANDS
       AXT 63,4      FOR CHANNEL
       LXA BCYCL,2
       STA *+3
       ADD ONE
       XCL
       SLW
       ADD ONE
       XCL     
       STA *+2
       ADD ONE
       SLW
       TIX *-3,1,1
       TIX *-11,4,1
       LDQ IOCDG 
       STA *+1
       STQ
       ADD ONE
       PAX ,1
       SXD CINFO+6,1
HHH    NZT CTRH     
       TRA IONT+2    RETURN TO PROGRAM
       TSX CNVRT,4   ALTER INDEX COUNT NUMBER
       STA READ5+31
       STA RD10+31   ADDRESS OF H COMMANDS
       LDQ IOCPH     
       AXT 63,4
       LXA BCYCL,2
       STA *+3  
       ADD ONE
       XCL
       SLW
       ADD ONE
       XCL
       STA *+2
       ADD ONE
       SLW
       TIX *-3,2,1
       TIX *-11,4,1
       LDQ IOCDH
       STA *+1
       STQ
       ADD ONE
       PAX ,1
       SXD CINFO+7,1
       TRA IONT+2    RETURN TO PROGRAM
       REM
       REM
ANS    AXT 64,2
BKSP   NZT CTRA      TEST FOR CHANNEL A
       TRA *+2
       BSRA 2
       NZT CTRB      TEST FOR CHANNEL B
       TRA *+2
       BSRB 1
       NZT CTRC      TEST FOR CHANNEL C
       TRA *+2
       BSRC 1
       NZT CTRD      TEST FOR CHANNEL D
       TRA *+2
       BSRD 1
       NZT CTRE      TEST FOR CHANNEL E
       TRA *+2
       BSRE 1
       NZT CTRF      TEST FOR CHANNEL F
       TRA *+2
       BSRF 1
       NZT CTRG      TEST FOR CHANNEL G
       TRA *+2
       BSRG 1
       NZT CTRH      TEST FOR CHANNEL H
       TRA *+2
       BSRH 1
       TIX BKSP,2,1  BACKSPACE 100 RECORDS
       REM
*THIS SECTION WILL TEST THE CONTENTS OF THE CHANNELS
*WHILE THE READ OPERATION IS BEING PERFORMED. IT
*WILL RESET AND LOAD CHANNEL WITH ZEROS, IF THE CONTENTS
       REM
       REM
*OF THE DSC EVER BECOME LARGER THAN THEY SHOULD.
*THIS WILL NOT RESET THE DSC COMPLETELY,
*BUT IT WILL STOP THE READ OPERATION, AND HALT, SO
*THAT MEMORY WILL NOT BE WIPED OUT BY A LARGE
*WORD COUNT.
       REM
       AXT 64,2
RD10   NZT CTRA      TEST FOR CHANNEL A
       TRA *+3       NO
       RTBA 2
       RCHA CCHA   
       NZT CTRB      TEST FOR CHANNEL B
       TRA *+3       NO
       RTBB 1
       RCHB **      
       NZT CTRC      TEST FOR CHANNEL C
       TRA *+3       NO
       RTBC 1        
       RCHC **  
       NZT CTRD      TEST FOR CHANNEL D
       TRA *+3       NO
       RTBD 1       
       RCHD **  
       NZT CTRE      TEST FOR CHANNEL E
       TRA *+3       NO
       RTBE 1       
       RCHE **  
       NZT CTRF      TEST FOR CHANNEL F
       TRA *+3       NO
       RTBF 1      
       RCHF **  
       NZT CTRG      TEST FOR CHANNEL G
       TRA *+3       NO
       RTBG 1       
       RCHG **  
       NZT CTRH      TEST FOR CHANNEL H
       TRA *+3       NO
       RTBH 1      
       RCHH **  
       REM
SCHS   SCHA SCH      STORE
       SCHB SCH+1    ADDRESS AND
       SCHC SCH+2    LOCATION
       SCHD SCH+3    REGISTERS FOR
       SCHE SCH+4    EACH
       SCHF SCH+5    CHANNEL
       SCHG SCH+6 
       SCHH SCH+7 
       REM
       REM
TRY    AXT 6,1
       AXT 18,4
       ANS* SAVE
       LDQ CINFO+8,1
       CAL CINFO+8,1 CORRECT INFORMATION
       STD *+13      STORE LOCATION REG.
       ALS 18
       STD *+8       STORE ADDRESS REG.
       SUB K1000
       STD *+8
       REM
       CAL SCH+8,1   CONTENTS DSC
       SXD SINDX,1   SAVE XRA
       SXA SINDX,4   SAVE XRC
       PAX 0,1       ADDRESS REGISTER TO XRA
       PDX 0,4       LOCATION REGISTER TO XRC
       TXH TOOT,1,** IF HIGH ADDR. REG. ERROR
       REM
       TXL *+3,1,0
       TXH HOOT,1,** IF EQUAL READ NEXT REC.
       REM
       TXH TOOT,4,** IF HIGH LOC. REG. ERROR
       REM
       LXA SINDX,4   RESTORE XRC
       LXD SINDX,1   RESTORE XRA
       TIX *+1,4,3   DECREMENT ERROR LOC.
       TIX TRY+2,1,1 BACK FOR NEXT SCH
       TRA SCHS      AROUND AGAIN
       REM
TOOT   LXA SINDX,4   ERROR
       TRA ERCHA+24,4
       REM
HOOT   TIX RD10,2,1
       TRA TCO
       REM
ERCHA  STL HPR
       RCHA BLCHA    BLAST CHANNEL A
       TRA XEC
       REM
ERCHB  STL HPR
       RCHB BLCHB    BLAST CHANNEL B
       TRA XEC
       REM
ERCHC  STL HPR
       RCHC BLCHC    BLAST CHANNEL C
       TRA XEC
       REM
       STL HPR
ERCHD  RCHD BLCHD    BLAST CHANNEL D
       TRA XEC
       REM
       STL HPR
ERCHE  RCHE BLCHE    BLAST CHANNEL E
       TRA XEC
       REM
       STL HPR
ERCHF  RCHF BLCHF    BLAST CHANNEL F
       TRA XEC
       REM
       STL HPR
ERCHG  RCHG BLCHG    BLAST CHANNEL G
       TRA XEC
       REM
       STL HPR
ERCHH  RCHH BLCHH    BLAST CHANNEL H
       TRA XEC
       REM
       REM
XEC    IOT           TURN OFF
       NOP           IOT INDICATOR
       REM
HPR    HPR **
       REM
*THE STORAGE REGISTER WILL CONTAIN THE ADDRESS OF THE RESET CHANNEL
*INSTRUCTION WHICH DISCONNECTED THE BUFFER.
       REM
*THE INFORMATION RECEIVED DURING THE STORE CHANNEL
*INSTRUCTION WAS HIGHER THAN IT SHOULD HAVE BEEN.
       REM
*THE LOCATION REGISTER AND ADDRESS REGISTER SHOULD
*BE NO LARGER THAN WHAT IS DISPLAYED IN THE MQ AT
*THIS TIME. THE INFORMATION RECEIVED FROM THE DSC
*APPEARS IN THE ACCUMULATOR.
       REM
*THE DS IN ERROR MAY HAVE TO BE RESET MANUALLY
*BEFORE THE START BUTTON IS DEPRESSED. BECUASE RESET
*CHANNEL WITH ZEROS MAY NOT COMPLETELY DISCONNECT THE
*CHANNEL, AND A HANG UP CONDITION MAY OCCUR.
       REM
       TIX TEST,2,1  RETURN TO WRITE AGAIN
       REM
*IF A HALT HAS OCCURRED AT THE ABOVE LOCATION, IT IS
*ADVISABLE NOT TO ENTER THE WORST CASE SECTION OF
*THIS TEST, AS THE TEST ITSELF MAY BE WIPED OUT.
       REM
       TSX OK,4
       TRA BKSP-1    REPEAT
       NOP
       TRA TCO
       REM
       REM
EOT    NZT CTRA  
       TRA *+2       ZERO
       REWA 2
       NZT CTRB  
       TRA *+2       ZERO
       REWB 1
       NZT CTRC  
       TRA *+2       ZERO
       REWC 1
       NZT CTRD  
       TRA *+2       ZERO
       REWD 1
       NZT CTRE  
       TRA *+2       ZERO
       REWE 1
       NZT CTRF  
       TRA *+2       ZERO
       REWF 1
       NZT CTRG  
       TRA *+2       ZERO
       REWG 1
       NZT CTRH  
       TRA *+2       ZERO
       REWH 1
       REM
       REM
       SLT 1
       TRA TEST      LITE OFF-START WRITE AGAIN
       TRA SW6+5     RETURN TO CALL NEXT PROGRAM
       REM
PRINT  SWT 3
       TRA *+2
       TRA SW5
       REM
       WPRA          TO
       SPRA 3        PRINT
       RCHA *+2      PASS
       TRA SW5
       REM
       IOCD PCOM,0,24
       REM
       REM
SW5    SWT 5         TEST FOR REPEAT OF
       REM           6 CHANNEL OPERATION
       TRA SW6       UP-TEST SWITCH 6
       REM
       REM
       TRA TEST      DN-REPEAT MULTI-
       REM           CHANNEL OPERATION
       REM
       REM
       REM
CNVRT  STO TEM
       NZT TEM1      NUMBER OF CHAN. NEEDING
       REM           EXTRA BCW
       TRA *+8       ALL CHAN. NEED SAME
       REM           NUMBER OF BCW
       CLA BUBAS
       SUB ONE
       STO BCYCL
       CLA TEM1
       SUB ONE
       STO TEM1
       TRA *+4
       CLA BUBAS
       SUB TWO
       STO BCYCL
       CLA TEM
       TRA 1,4
       REM
       REM
PCOM   OCT 10           9L
       OCT 4000400000   9R
       OCT 0            8L
       OCT 0            8R
       OCT 2004000      7L
       OCT 0            7R
       OCT 20000        6L
       OCT 30000000000  6R
       OCT 1202         5L
       OCT 20100000     5R
       OCT 10000        4L
       OCT 200000       4R
       OCT 42401        3L
       OCT 1201000000   3R
       OCT 600004       2L
       OCT 2044000000   2R
       OCT 1000000      1L
       OCT 100000000    1R
       OCT 600400       0L
       OCT 23041000000  0R
       OCT 2036040      11L
       OCT 114000200000 11R
       OCT 1041204      12L
       OCT 324500000    12R
       REM
PPER   OCT 112020       9L
       OCT 10001000000  9R
       OCT 0            8L
       OCT 0            8R
       OCT 400400       7L
       OCT 0            7R
       OCT 6060000      6L
       OCT 60000000000  6R
       OCT 10201004     5L
       OCT 40200000     5R
       OCT 4000         4L
       OCT 400000       4R
       OCT 2            3L
       OCT 2402000000   3R
       OCT 10           2L
       OCT 4110000000   2R
       OCT 0            1L
       OCT 200000000    1R
       OCT 2000000      0L
       OCT 46102000000  0R
       OCT 14535100     11L
       OCT 230000400000 11R
       OCT 242410       12R
       OCT 651200000    12L
       REM
CTRL   OCT 0
STCTL  IOCD PPER,0,24
       REM
CNT    OCT 0
MCYCL  DEC 218       MACH CYCLE X 100
BUFTM  DEC 7200
BUF1   OCT **
BUBAS  OCT **
TEM    OCT **
TEM1   OCT **
BCYCL  OCT **
       REM
WR1    IOCD WTCHA,0,64 TO WRITE TAPE CHAN A
WR2    IOCD WTCHB,0,64 TO WRITE TAPE CHAN B
WR3    IOCD WTCHC,0,64 TO WRITE TAPE CHAN C
WR4    IOCD WTCHD,0,64 TO WRITE TAPE CHAN D
WR5    IOCD WTCHE,0,64 TO WRITE TAPE CHAN E
WR6    IOCD WTCHF,0,64 TO WRITE TAPE CHAN F
WR7    IOCD WTCHG,0,64 TO WRITE TAPE CHAN G
WR10   IOCD WTCHH,0,64 TO WRITE TAPE CHAN H
       REM
SAVE   NOP *+1
SAVE1
RCHA   BSS 64        100 WORD
RCHB   BSS 64
RCHC   BSS 64         BLOCKS FOR
RCHD   BSS 64
RCHE   BSS 64        TAPE READ
RCHF   BSS 64
RCHG   BSS 64
RCHH   BSS 64
       REM
CNTL   IOCD ONES,0,1 WRITE ONE WORD-ONES
       IOCD ZEROS,0,1 WRITE ONE WORD-ZEROS
       REM
CNTLR  IOCD READ,0,1 READ ONE WORD
       IOCD READ,0,2 READ ONE WORD AND BCD EOF
       IOCD READ+2,0,2 READ ONE WORD AND BIN EOF
       REM
ZEROS  OCT 0
ONES   OCT 777777777777
       REM
READ   OCT 0
       OCT 0
       OCT 0
       OCT 0
       REM
CINFO  IOCD RCHA+64,0,CCHA+127 CORRECT
       IOCD RCHB+64,0,** INFORMATION
       IOCD RCHC+64,0,** TO COMPARE
       IOCD RCHD+64,0,** STORE
       IOCD RCHE+64,0,** CHANNEL
       IOCD RCHF+64,0,** OPERATIONS
       IOCD RCHG+64,0,**
       IOCD RCHH+64,0,**
       REM
SCH    OCT 0
       OCT 0
       OCT 0
       OCT 0
       OCT 0
       OCT 0
       OCT 0
       OCT 0
COUNT  OCT 0
       REM
CT     DEC 65
       REM
SAVE2  OCT 0         STORAGE
SAVE3  OCT 0         FOR
SAVE4  OCT 0         STORE
SAVE5  OCT 0         CHANNEL
SAVE6  OCT 0         INFORMATION
SAVE7  OCT 0
SAVE8  OCT 0
SAVE9  OCT 0
       REM
BLCHA  IOCD ERCHA+1
BLCHB  IOCD ERCHB+1
BLCHC  IOCD ERCHC+1
BLCHD  IOCD ERCHD+1
BLCHE  IOCD ERCHE+1
BLCHF  IOCD ERCHF+1
BLCHG  IOCD ERCHG+1
BLCHH  IOCD ERCHH+1
MASK   OCT 077777777777
       REM
EXCL   OCT 777777777407
       OCT 220
       REM
TCH    TCH CCHA
IOCPA  IOCP RCHA,0,1
IOCDA  IOCD RCHA+63,0,1
IOCPB  IOCP RCHB,0,1
IOCDB  IOCD RCHB+63,0,1
IOCPC  IOCP RCHC,0,1
IOCDC  IOCD RCHC+63,0,1
IOCPD  IOCP RCHD,0,1
IOCDD  IOCD RCHD+63,0,1
IOCPE  IOCP RCHE,0,1
IOCDE  IOCD RCHE+63,0,1
IOCPF  IOCP RCHF,0,1
IOCDF  IOCD RCHF+63,0,1
IOCPG  IOCP RCHG,0,1
IOCDG  IOCD RCHG+63,0,1
IOCPH  IOCP RCHH,0,1
IOCDH  IOCD RCHH+63,0,1
XRA    PZE
XRB    PZE
K1000  OCT 1000000
SINDX  OCT 0
ONE    OCT 1
TWO    DEC 2
SIX    DEC 6
       REM
ORTST  OCT 077777777777
ORWRD  IOCT RCHA,0,1
       IOCD RCHA+1,0,511
       REM
*FROM THIS POINT TO SYMBOLIC LOCATION CCHA-, IS THE INFORMATION WRITTEN
*ON TAPE. EACH CHANNELS INFOMRATION IS UNIQUE. THE SECOND TWO CHARACTERS FOR
*CHANNEL A IS A BCD A. THE SECOND TWO CHARACTERS FOR CHANNEL B IS A BCD B E
*EACH CHANNEL HAS ITS CORRESPONDING LETTER IN THE MIDDLE TWO CHARACTERS OF EACH
*WORD TRANSMITTED.
       REM
WTCHA  OCT 010121210101 FROM WTCHA
       OCT 020221210202
       OCT 030321210303 TO WTCHA+63
       OCT 040421210404
       OCT 050521210505 IS FIXED PATTERN
       OCT 060621210606
       OCT 070721210707 FOR WRITING TAPE
       OCT 101021211010
       OCT 111121211111 CHANNEL A.
       OCT 121221211212
       OCT 131321211313
       OCT 141421211414
       OCT 151521211515
       OCT 161621211616
       OCT 171721211717
       OCT 202021212020
       OCT 212121212121
       OCT 222221212222
       OCT 232321212323
       OCT 242421212424
       OCT 252521212525
       OCT 262621212626
       OCT 272721212727
       OCT 303021213030
       OCT 313121213131
       OCT 323221213232
       OCT 333321213333
       OCT 343421213434
       OCT 353521213535
       OCT 363621213636
       OCT 373721213737
       OCT 404021214040
       OCT 414121214141
       OCT 424221214242
       OCT 434321214343
       OCT 444421214444
       OCT 454521214545
       OCT 464621214646
       OCT 474721214747
       OCT 505021215050
       OCT 515121215151
       OCT 525221215252
       OCT 535321215353
       OCT 545421215454
       OCT 555521215555
       OCT 565621215656
       OCT 575721215757
       OCT 606021216060
       OCT 616121216161
       OCT 626221216262
       OCT 636321216363
       OCT 646421216464
       OCT 656521216565
       OCT 666621216666
       OCT 676721216767
       OCT 707021217070
       OCT 717121217171
       OCT 727221217272
       OCT 737321217373
       OCT 747421217474
       OCT 757521217575
       OCT 767621217676
       OCT 777721217777
       OCT 010121210100
       REM
WTCHB  OCT 010122220101 FROM WTCHB
       OCT 020222220202
       OCT 030322220303 TO WTCHB+63
       OCT 040422220404
       OCT 050522220505 IS FIXED PATTERN
       OCT 060622220606
       OCT 070722220707 FOR WRITING TAPE
       OCT 101022221010
       OCT 111122221111 CHANNEL B.
       OCT 121222221212
       OCT 131322221313
       OCT 141422221414
       OCT 151522221515
       OCT 161622221616
       OCT 171722221717
       OCT 202022222020
       OCT 212122222121
       OCT 222222222222
       OCT 232322222323
       OCT 242422222424
       OCT 252522222525
       OCT 262622222626
       OCT 272722222727
       OCT 303022223030
       OCT 313122223131
       OCT 323222223232
       OCT 333322223333
       OCT 343422223434
       OCT 353522223535
       OCT 363622223636
       OCT 373722223737
       OCT 404022224040
       OCT 414122224141
       OCT 424222224242
       OCT 434322224343
       OCT 444422224444
       OCT 454522224545
       OCT 464622224646
       OCT 474722224747
       OCT 505022225050
       OCT 515122225151
       OCT 525222225252
       OCT 535322225353
       OCT 545422225454
       OCT 555522225555
       OCT 565622225656
       OCT 575722225757
       OCT 606022226060
       OCT 616122226161
       OCT 626222226262
       OCT 636322226363
       OCT 646422226464
       OCT 656522226565
       OCT 666622226666
       OCT 676722226767
       OCT 707022227070
       OCT 717122227171
       OCT 727222227272
       OCT 737322227373
       OCT 747422227474
       OCT 757522227575
       OCT 767622227676
       OCT 777722227777
       OCT 010122220100
       REM
WTCHC  OCT 010123230101 FROM WTCHC
       OCT 020223230202
       OCT 030323230303 TO WTCHC+63
       OCT 040423230404
       OCT 050523230505 IS FIXED PATTERN
       OCT 060623230606
       OCT 070723230707 FOR WRITING TAPE
       OCT 101023231010
       OCT 111123231111 CHANNEL C.
       OCT 121223231212
       OCT 131323231313
       OCT 141423231414
       OCT 151523231515
       OCT 161623231616
       OCT 171723231717
       OCT 202023232020
       OCT 212123232121
       OCT 222223232222
       OCT 232323232323
       OCT 242423232424
       OCT 252523232525
       OCT 262623232626
       OCT 272723232727
       OCT 303023233030
       OCT 313123233131
       OCT 323223233232
       OCT 333323233333
       OCT 343423233434
       OCT 353523233535
       OCT 363623233636
       OCT 373723233737
       OCT 404023234040
       OCT 414123234141
       OCT 424223234242
       OCT 434323234343
       OCT 444423234444
       OCT 454523234545
       OCT 464623234646
       OCT 474723234747
       OCT 505023235050
       OCT 515123235151
       OCT 525223235252
       OCT 535323235353
       OCT 545423235454
       OCT 555523235555
       OCT 565623235656
       OCT 575723235757
       OCT 606023236060
       OCT 616123236161
       OCT 626223236262
       OCT 636323236363
       OCT 646423236464
       OCT 656523236565
       OCT 666623236666
       OCT 676723236767
       OCT 707023237070
       OCT 717123237171
       OCT 727223237272
       OCT 737323237373
       OCT 747423237474
       OCT 757523237575
       OCT 767623237676
       OCT 777723237777
       OCT 010123230100
       REM
WTCHD  OCT 010124240101
       OCT 020224240202
       OCT 030324240303
       OCT 040424240404
       OCT 050524240505
       OCT 060624240606
       OCT 070724240707
       OCT 101024241010
       OCT 111124241111
       OCT 121224241212
       OCT 131324241313
       OCT 141424241414
       OCT 151524241515
       OCT 161624241616
       OCT 171724241717
       OCT 202024242020
       OCT 212124242121
       OCT 222224242222
       OCT 232324242323
       OCT 242424242424
       OCT 252524242525
       OCT 262624242626
       OCT 272724242727
       OCT 303024243030
       OCT 313124243131
       OCT 323224243232
       OCT 333324243333
       OCT 343424243434
       OCT 353524243535
       OCT 363624243636
       OCT 373724243737
       OCT 404024244040
       OCT 414124244141
       OCT 424224244242
       OCT 434324244343
       OCT 444424244444
       OCT 454524244545
       OCT 464624244646
       OCT 474724244747
       OCT 505024245050
       OCT 515124245151
       OCT 525224245252
       OCT 535324245353
       OCT 545424245454
       OCT 555524245555
       OCT 565624245656
       OCT 575724245757
       OCT 606024246060
       OCT 616124246161
       OCT 626224246262
       OCT 636324246363
       OCT 646424246464
       OCT 656524246565
       OCT 666624246666
       OCT 676724246767
       OCT 707024247070
       OCT 717124247171
       OCT 727224247272
       OCT 737324247373
       OCT 747424247474
       OCT 757524247575
       OCT 767624247676
       OCT 777724247777
       OCT 010124240100
       REM
WTCHE  OCT 010125250101
       OCT 020225250202
       OCT 030325250303
       OCT 040425250404
       OCT 050525250505
       OCT 060625250606
       OCT 070725250707
       OCT 101025251010
       OCT 111125251111
       OCT 121225251212
       OCT 131325251313
       OCT 141425251414
       OCT 151525251515
       OCT 161625251616
       OCT 171725251717
       OCT 202025252020
       OCT 212125252121
       OCT 222225252222
       OCT 232325252323
       OCT 242425252424
       OCT 252525252525
       OCT 262625252626
       OCT 272725252727
       OCT 303025253030
       OCT 313125253131
       OCT 323225253232
       OCT 333325253333
       OCT 343425253434
       OCT 353525253535
       OCT 363625253636
       OCT 373725253737
       OCT 404025254040
       OCT 414125254141
       OCT 424225254242
       OCT 434325254343
       OCT 444425254444
       OCT 454525254545
       OCT 464625254646
       OCT 474725254747
       OCT 505025255050
       OCT 515125255151
       OCT 525225255252
       OCT 535325255353
       OCT 545425255454
       OCT 555525255555
       OCT 565625255656
       OCT 575725255757
       OCT 606025256060
       OCT 616125256161
       OCT 626225256262
       OCT 636325256363
       OCT 646425256464
       OCT 656525256565
       OCT 666625256666
       OCT 676725256767
       OCT 707025257070
       OCT 717125257171
       OCT 727225257272
       OCT 737325257373
       OCT 747425257474
       OCT 757525257575
       OCT 767625257676
       OCT 777725257777
       OCT 010125250100
       REM
WTCHF  OCT 010126260101
       OCT 020226260202
       OCT 030326260303
       OCT 040426260404
       OCT 050526260505
       OCT 060626260606
       OCT 070726260707
       OCT 101026261010
       OCT 111126261111
       OCT 121226261212
       OCT 131326261313
       OCT 141426261414
       OCT 151526261515
       OCT 161626261616
       OCT 171726261717
       OCT 202026262020
       OCT 212126262121
       OCT 222226262222
       OCT 232326262323
       OCT 242426262424
       OCT 252526262525
       OCT 262626262626
       OCT 272726262727
       OCT 303026263030
       OCT 313126263131
       OCT 323226263232
       OCT 333326263333
       OCT 343426263434
       OCT 353526263535
       OCT 363626263636
       OCT 373726263737
       OCT 404026264040
       OCT 414126264141
       OCT 424226264242
       OCT 434326264343
       OCT 444426264444
       OCT 454526264545
       OCT 464626264646
       OCT 474726264747
       OCT 505026265050
       OCT 515126265151
       OCT 525226265252
       OCT 535326265353
       OCT 545426265454
       OCT 555526265555
       OCT 565626265656
       OCT 575726265757
       OCT 606026266060
       OCT 616126266161
       OCT 626226266262
       OCT 636326266363
       OCT 646426266464
       OCT 656526266565
       OCT 666626266666
       OCT 676726266767
       OCT 707026267070
       OCT 717126267171
       OCT 727226267272
       OCT 737326267373
       OCT 747426267474
       OCT 757526267575
       OCT 767626267676
       OCT 777726267777
       OCT 010126260100
       REM
WTCHG  OCT 010127270101
       OCT 020227270202
       OCT 030327270303
       OCT 040427270404
       OCT 050527270505
       OCT 060627270606
       OCT 070727270707
       OCT 101027271010
       OCT 111127271111
       OCT 121227271212
       OCT 131327271313
       OCT 141427271414
       OCT 151527271515
       OCT 161627271616
       OCT 171727271717
       OCT 202027272020
       OCT 212127272121
       OCT 222227272222
       OCT 232327272323
       OCT 242427272424
       OCT 252527272525
       OCT 262627272626
       OCT 272727272727
       OCT 303027273030
       OCT 313127273131
       OCT 323227273232
       OCT 333327273333
       OCT 343427273434
       OCT 353527273535
       OCT 363627273636
       OCT 373727273737
       OCT 404027274040
       OCT 414127274141
       OCT 424227274242
       OCT 434327274343
       OCT 444427274444
       OCT 454527274545
       OCT 464627274646
       OCT 474727274747
       OCT 505027275050
       OCT 515127275151
       OCT 525227275252
       OCT 535327275353
       OCT 545427275454
       OCT 555527275555
       OCT 565627275656
       OCT 575727275757
       OCT 606027276060
       OCT 616127276161
       OCT 626227276262
       OCT 636327276363
       OCT 646427276464
       OCT 656527276565
       OCT 666627276666
       OCT 676727276767
       OCT 707027277070
       OCT 717127277171
       OCT 727227277272
       OCT 737327277373
       OCT 747427277474
       OCT 757527277575
       OCT 767627277676
       OCT 777727277777
       OCT 010127270100
       REM
WTCHH  OCT 010130300101
       OCT 020230300202
       OCT 030330300303
       OCT 040430300404
       OCT 050530300505
       OCT 060630300606
       OCT 070730300707
       OCT 101030301010
       OCT 111130301111
       OCT 121230301212
       OCT 131330301313
       OCT 141430301414
       OCT 151530301515
       OCT 161630301616
       OCT 171730301717
       OCT 202030302020
       OCT 212130302121
       OCT 222230302222
       OCT 232330302323
       OCT 242430302424
       OCT 252530302525
       OCT 262630302626
       OCT 272730302727
       OCT 303030303030
       OCT 313130303131
       OCT 323230303232
       OCT 333330303333
       OCT 343430303434
       OCT 353530303535
       OCT 363630303636
       OCT 373730303737
       OCT 404030304040
       OCT 414130304141
       OCT 424230304242
       OCT 434330304343
       OCT 444430304444
       OCT 454530304545
       OCT 464630304646
       OCT 474730304747
       OCT 505030305050
       OCT 515130305151
       OCT 525230305252
       OCT 535330305353
       OCT 545430305454
       OCT 555530305555
       OCT 565630305656
       OCT 575730305757
       OCT 606030306060
       OCT 626230306262
       OCT 636330306363
       OCT 646430306464
       OCT 656530306565
       OCT 666630306666
       OCT 676730306767
       OCT 707030307070
       OCT 717130307171
       OCT 727230307272
       OCT 737330307373
       OCT 747430307474
       OCT 757530307575
       OCT 767630307676
       OCT 777730307777
       OCT 010130300100
       REM
*   I - O   C O M M A N D    F I E L D
       REM
CCHA   BSS 1100     I-O CMMANDS WILL BE 
       REM          GENERATED FOR ALL 
       REM          COMBINATIONS OF CHANNELS.
       REM
       REM
       REM
CTRL1  EQU 31424    COUNT WORD FOR CHNS A-B-C-D
CTRL2  EQU 31425    COUNT WORD FOR CHNS E-F-G-H
IOCT   EQU 31426    TOTAL I-O COUNT
IOCNT  EQU 31436    ENTRY TO RECALCUATE COUNT
IOC    EQU 31438    ENTRY FOR CONTROL WORDS
CMKW   EQU 31435    COUNT WORD - CARD MACHINES
CTRA   EQU 31427    NO. OF TAPE UNITS - CHN A
CTRB   EQU 31428    NO. OF TAPE UNITS - CHN B
CTRC   EQU 31429    NO. OF TAPE UNITS - CHN C
CTRD   EQU 31430    NO. OF TAPE UNITS - CHN D
CTRE   EQU 31431    NO. OF TAPE UNITS - CHN E
CTRF   EQU 31432    NO. OF TAPE UNITS - CHN F
CTRG   EQU 31433    NO. OF TAPE UNITS - CHN G
CTRH   EQU 31434    NO. OF TAPE UNITS - CHN H
CTX    EQU 31437    ENTRY TO MODIFY PROGRAM
ERROR  EQU 32004
OK     EQU 32005
RDNCK  EQU 32007
WDNO   EQU 32008
RECNO  EQU 32006
       END
