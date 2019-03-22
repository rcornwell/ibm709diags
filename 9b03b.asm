                                                             9 B 0 3 B
                                                             2/1/59
       REM
       REM 9B03B-WORST CASE B TIME
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
       HTR *+1       HALT TO ENTER KEYS
       REM
*ENTER INTO KEYS-BIT 20 TO DEFINE CHANNELS A+B
*                BIT 19 TO DEFINE CHANNELS C+D
*                BIT 18 TO DEFINE CHANNELS E+F
       REM
       ENK
       STQ CTRL
       LDI CTRL
       REM
       RFT 700000    TEST FOR ANY TAG BIT
       TRA *+2       YES
       REM
       HTR BEGIN+3   NO TAG KEYS DOWN-THROW
       REM           DOWN CORRECT KEYS, AND
       REM           PROGRAM WILL PROCEED,
       REM           AFTER START KEY IS
       REM           DEPRESSED.
       REM
       TRA CHNG
       CLA COUNT     SWITCH TO BYPASS
       TNZ TEST      INITIAL SECTIONS
       STL COUNT     AFTER FIRST PASS
       RNT 0,1       TEST FOR CHANNELS A+B
       TRA OPAL-6    NO
       REM
*THE ROUTINES FROM THIS POINT TO SYMBOLIC LOCATION-TEST-,
*WILL TEST BUFFER AND SYNCHRONIZER INSTRUCTIONS FOR ALL CHANNELS SELECTED
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
       WTDA 2
       RCHA CNTL     NO TRGS. ON-WRD. CNT. 1
       WEFA 2        BCD EOF
       WTBA 2
       RCHA CNTL+1   NO. TGRS ON-WRD. CNT. 1
       WEFA 18       BINARY EOF, SHOULD
       REM           WRITE BCD TAPE MARK
       TRA *+2
       REM
       BCD 1BSRA 1
       REM
EASY   BSRA 18
       BSRA 2
       RTBA 2
       RCHA CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOA *
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
       CLA READ      WORD READ
       LDQ ONES      WORD WRITTEN
       CAS ONES
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP FOX
       TSX RDNCK,4   TEST RDNCY
       TRA FOX
       REM
       CLA READ+2    WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP FOX
       TSX OK,4      OUT TO TEST SWITCHES
       TRA FOX
       NOP
       REM
       REM
       REM
       ETTB
       REWB 1
       TRA *+2
       REM
       BCD 1TCOB     TEST TRANS CHANNEL B IN OPN
       REM
HOG    WTBB 1
       TCOB *+3      CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL HOG
       REM
       RCHB CNTL     NO TGRS ON-WORD. CNT. 1
       TCOB *+3      SHOULD TRANS.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL HOG
       REM
       TCOB *        IF UNIT RUNS AWAY,OR
       REM           MACHINE HANGS ON THIS
       REM           OR ANY PREVIOUS TCOB
       REM           IPN.,BUFFER MAY NOT BE
       REM           RECEIVING END OPER. FROM
       REM           SYNC.
       TCOB *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 TRANS. IN ERROR-TCOB
       TXL HOG
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA HOG
       REM
       BCD 1TCNB     TEST TRANS. CHAN NOT IN OPN
       REM
INDIA  TCNB *+3      SHOULD TRANS
       TSX ERROR-1,4 FAILED TO TRANS.
       TXL INDIA
       REM
       WTBB 1
       TCNB *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL INDIA
       REM
       RCHB CNTL+1   NO TGRS. ON-WRD. CNT. 1
       TCNB *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL INDIA
       REM
       TCOB *
       TCNB *+3      SHOULD TRANS.
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL INDIA
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA INDIA
       REM
       BCD 1BTTB     TEST BEGIN. TAPE
       REM
JACK   REWB 1
       BSRB 1        BACKSPACE TO LOAD PT.
       REWB 1        SHOULD ACT AS NOP
       BSRB 1        TRY TO BCKSP OVER LD. PT.
       TCOB *        DELAY
       REM           BEGIN. TAPE TGR. SHOULD
       REM           BE TURNED ON HERE
       BTTB
       TRA *+3       OK-SHOULD BE ON
       TSX ERROR-1,4 SHLD NOT SKIP TO ENTER HERE
       TXL JACK
       REM
       BTTB
       TRA *+2       ERROR-BIT SHOULD BE OFF
       TRA *+3       OK-OFF
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL JACK
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA JACK
       REM
       BCD 1IOT      TEST I/O CHECK TGR.
       REM
KING   WTBB 1
       RCHB CNTL     NO TGRS. ON-WRD. CNT. 1
       TCOB *
       LCHB CNTL+1   SHOULD TURN ON IOT
       IOT
       TRA *+3       SHOULD ENTER HERE-OK
       TSX ERROR-1,4 ERROR-SHOULD NOT SKIP
       TXL KING
       REM
       IOT
       TRA *+2       ERROR-TGR WAS NOT TURNED
       REM           OFF BY PREVIOUS SEQUENCE
       TRA *+3       OK-TGR SHOULD BE OFF
       TSX ERROR-1,4
       TXL KING
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA KING
       REM
       BCD 1WEFB     TEST TO SEE THAT WEF
       REM           BCD OR BINARY BOTH
       REM           WRITE TAPE MARKS
       REM
       WTDB 1
       RCHB CNTL     NO TGRS. ON-WRD. CNT. 1
       WEFB 1        BCD EOF
       WTBB 1
       RCHB CNTL+1   NO. TGRS ON-WRD. CNT. 1
       WEFB 17       BINARY EOF. SHOULD
       REM           WRITE BCD TAPE MARK
       TRA *+2
       REM
       BCD 1BSRB 1
       REM
LOST   BSRB 17
       BSRB 1
       RTBB 1
       RCHB CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOB *
       REM
       CLA READ      WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP LOST
       TSX RDNCK,4
       TRA LOST
       REM
       TEFB *+3      SHOULD TRANS.
       TSX ERROR-1,4 EOF DID NOT COME UP
       TXL NILL
       TRA *+2
       REM
       BCD 1BSFB 1
       REM
MOST   BSFB 1        BKSP OVER EOF
       BSFB 1        BKSP OVER EOF AND 1 REC.
       BSRB 1        BKSP OVER 1 REC
       RTDB 1
       RCHB CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOB *        TO READ ONE WD AND BCD EOF
       TRA *+2       CONTINUE
       REM
       BCD 1TEFB     TEST EOF TGR + INDICATOR
       REM
NILL   TEFB *+3      SHOULD TRANS
       TSX ERROR-1,4
       TXL NILL,4    DO NOT REPEAT
       REM
       TEFB *+2      SHOULD NOT TRANS
       TRA *+3       OK
       TSX ERROR-1,4 ERROR-TGR SHOULD BE OFF
       TXL NILL,4    DO NOT REPEAT
       REM
       RTBB 1
       RCHB CNTLR+2  NO TGRS ON-WRD CNT 2
       REM           TO READ ONE WD AND BIN EOF
       TCOB *        DELAY
       TRA *+2
       REM
       BCD 1 TEFB    TEST EOF TGR + INDICATOR
       REM
       TEFB *+3
       TSX ERROR-1,4
       TXL *-2,4,0   DO NOT REPEAT
       REM
       CLA READ      WORD READ
       LDQ ONES      WORD WRITTEN
       CAS ONES
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP MOST
       TSX RDNCK,4   TEST RDNCY
       TRA MOST
       REM
       CLA READ+2    WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP MOST
       TSX OK,4      OUT TO TEST SWITCHES
       TRA MOST
       NOP
       REM
       REM
       RNT 0,2       TEST FOR CHANNELS C+D
       TRA GO-6      NO
       REM
       ETTC
       REWC 1
       TRA *+2
       REM
       BCD 1TCOC     TEST TRANS CHANNEL C IN OPR
       REM
OPAL   WTBC 1
       TCOC *+3      CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL OPAL
       REM
       RCHC CNTL     NO TGRS ON-WORDS+ CNT. 1
       TCOC *+3      SHOULD TRANS.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL OPAL
       REM
       TCOC *        IF UNIT RUNS AWAY,OR
       REM           MACHINE HANGS ON THIS
       REM           OR ANY PREVIOUS TCOC
       REM           OPN.,BUFFER MAY NOT BE
       REM           RECEIVING END OPER. FROM
       REM           SYNC.
       TCOC *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 TRANS. IN ERROR-TCOC
       TXL OPAL
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA OPAL
       REM
       BCD 1TCNC     TEST TRNS. CHAN NOT IN OPN
       REM
PAUL   TCNC *+3      SHOULD TRANS
       TSX ERROR-1,4 FAILED TO TRANS.
       TXL PAUL
       REM
       WTBC 1
       TCNC *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL PAUL
       REM
       RCHC CNTL+1   NO TGRS. ON-WRD. CNT. 1
       TCNC *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL PAUL
       REM
       TCOC *
       TCNC *+3      SHOULD TRANS.
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL PAUL
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA PAUL
       REM
       BCD 1BTTC     TEST BEGIN. TAPE
       REM
QUICK  REWC 1
       BSRC 1        BACKSPACE TO LOAD PT.
       REWC 1        SHOULD ACT AS NOP
       BSRC 1        TRY TO BCKSP OVER LD. PT.
       TCOC *        DELAY
       REM           BEGIN. TAPE TGR. SHOULD
       REM           BE TURNED ON HERE
       BTTC
       TRA *+3       OK-SHOULD BE ON
       TSX ERROR-1,4 SHLD NOT SKIP TO ENTER HERE
       TXL QUICK
       REM
       BTTC
       TRA *+2       ERROR-BTT SHOULD BE OFF
       TRA *+3       OK-OFF
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL QUICK
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA QUICK
       REM
       BCD 1IOT
       REM
RATS   WTBC 1
       RCHC CNTL     NO TGRS. ON-WRD. CNT. 1
       TCOC *
       LCHC CNTL+1   SHOULD TURN ON IOT
       IOT
       TRA *+3       SHOULD ENTER HERE-OK
       TSX ERROR-1,4 ERROR-SHOULD NOT SKIP
       TXL RATS
       REM
       IOT
       TRA *+2       ERROR-TGR WAS NOT TURNED
       REM           OFF BY PREVIOUS SEQUENCE
       TRA *+3       OK-TGR SHOULD BE OFF
       TSX ERROR-1,4
       TXL RATS
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA RATS
       REM
       BCD 1WEFC     TEST TO SEE THAT WEF
       REM           BCD OR BINARY, BOTH
       REM           WRITE TAPE MARKS
       REM
       WTDC 1
       RCHC CNTL     NO TGRS. ON-WRD. CNT. 1
       WEFC 1        BCD EOF
       WTBC 1
       RCHC CNTL+1   NO. TGRS ON-WRD. CNT. 1
       WEFC 17       BINARY EOF. SHOULD
       REM           WRITE BCD TAPE MARK
       TRA *+2
       REM
       BCD 1BSRC 1
       REM
STAG   BSRC 17
       BSRC 1
       RTBC 1
       RCHC CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOC *
       REM
       CLA READ      WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP STAG
       TSX RDNCK,4
       TRA STAG
       REM
       TEFC *+3      SHOULD TRANS.
       TSX ERROR-1,4 EOF DID NOT COME UP
       TXL UNCLE
       TRA *+2
       REM
       BCD 1BSFC 1
       REM
TOP    BSFC 1        BKSP OVER EOF
       BSFC 1        BKSP OVER EOF AND 1REC.
       BSRC 1        BKSP OVER 1 REC
       RTDC 1
       RCHC CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOC *        TO READ ONE WD AND BCD EOF
       TRA *+2       CONTINUE
       REM
       BCD 1TEFC     TEST EOF TGR + INDICATOR
       REM
UNCLE  TEFC *+3      SHOULD TRANS
       TSX ERROR-1,4
       TXL UNCLE,4   DO NOT REPEAT
       REM
       TEFC *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 ERROR-TGR SHOULD BE OFF
       TXL UNCLE,4   DO NOT REPEAT
       REM
       RTBC 1
       RCHC CNTLR+2  NO TGRS ON-WRD CNT 2
       REM           TO READ ONE WD AND BIN EOF
       TCOC *        DELAY
       TRA *+2
       REM
       BCD 1 TEFC    TEST EOF TGR + INDICATOR
       REM
       TEFC *+3
       TSX ERROR-1,4
       TXL *-2,4,0   DO NOT REPEAT
       REM
       CLA READ      WORD READ
       LDQ ONES      WORD WRITTEN
       CAS ONES
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP TOP
       TSX RDNCK,4   TEST RDNCY
       TRA TOP
       REM
       CLA READ+2    WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP TOP
       TSX OK,4      OUT TO TEST SWITCHES
       TRA TOP
       NOP
       REM
       REM
       REM
       ETTD
       REWD 1
       TRA *+2
       REM
       BCD 1TCOD     TEST TRANS CHANNEL D IN OPN
       REM
VERY   WTBD 1
       TCOD *+3      CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4 FAILED TO TRANS. OPN.
       TXL VERY
       REM
       RCHD CNTL     NO TGRS ON-WORD. CNT. 1
       TCOD *+3      SHOULD TRANS.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL VERY
       REM
       TCOD *        IF UNIT RUNS AWAY,OR
       REM           MACHINE HANGS ON THIS
       REM           OR ANY PREVIOUS TCOD
       REM           OPN.,BUFFER MAY NOT BE
       REM           RECEIVING END OPER. FROM
       REM           SYNC.
       TCOD *+2      SHOULD NOT TRANS.
       TRA *+3
       TSX ERROR-1,4 TRANS. IN ERROR-TCOD
       TXL VERY
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA VERY
       REM
       BCD 1TCND     TEST TRANS. CHAN NOT IN OPN
       REM
WAKE   TCND *+3      SHOULD TRANS
       TSX ERROR-1,4 FAILED TO TRANS.
       TXL WAKE
       REM
       WTBD 1
       TCND *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL WAKE
       REM
       RCHD CNTL+1   NO TGRS. ON-WRD. CNT. 1
       TCND *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL WAKE
       REM
       TCOD *
       TCND *+3      SHOULD TRANS.
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL WAKE
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA WAKE
       REM
       BCD 1BTTD     TEST BEGIN. TAPE
       REM
XTRA   REWD 1
       BSRD 1        BACKSPACE TO LOAD PT.
       REWD 1        SHOULD ACT AS NOP
       BSRD 1        TRY TO BCKSP OVER LD. PT.
       TCOD *        DELAY
       REM           BEGIN. TAPE TGR. SHOULD
       REM           BE TURNED ON HERE
       BTTD
       TRA *+3       OK-SHOULD BE ON
       TSX ERROR-1,4 SHLD NOT SKIP TO ENTER HERE
       TXL XTRA
       REM
       BTTD
       TRA *+2       ERROR-BTT SHOULD BE OFF
       TRA *+3       OK-OFF
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL XTRA
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA XTRA
       REM
       BCD 1IOT      TEST I/O CHECK TGR.
       REM
YALE   WTBD 1
       RCHD CNTL     NO TGRS. ON-WRD. CNT. 1
       TCOD *
       LCHD CNTL+1   SHOULD TURN ON IOT
       IOT
       TRA *+3       SHOULD ENTER HERE-OK
       TSX ERROR-1,4 ERROR-SHOULD NOT SKIP
       TXL YALE
       REM
       IOT
       TRA *+2       ERROR-TGR WAS NOT TURNED
       REM           OFF BY PREVIOUS SEQUENCE
       TRA *+3       OK-TGR SHOULD BE OFF
       TSX ERROR-1,4
       TXL YALE
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA YALE
       REM
       BCD 1WEFD     TEST TO SEE THAT WEF
       REM           BCD OR BINARY, BOTH
       REM           WRITE TAPE MARKS
       REM
       WTDD 1
       RCHD CNTL     NO TGRS. ON-WRD. CNT. 1
       WEFD 1        BCD EOF
       WTBD 1
       RCHD CNTL+1   NO. TGRS ON-WRD. CNT. 1
       WEFD 17       BINARY EOF. SHOULD
       REM           WRITE BCD TAPE MARK
       TRA *+2
       REM
       BCD 1BSRD 1
       REM
ZEKE   BSRD 17
       BSRD 1
       RTBD 1
       RCHD CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOD *
       REM
       CLA READ      WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP ZEKE
       TSX RDNCK,4
       TRA ZEKE
       REM
       TEFD *+3      SHOULD TRANS.
       TSX ERROR-1,4 EOF DID NOT COME UP
       TXL BETA
       TRA *+2
       REM
       BCD 1BSFD 1
       REM
ALPHA  BSFD 1        BKSP OVER EOF
       BSFD 1        BKSP OVER EOF AND 1 REC.
       BSRD 1        BKSP OVER 1 REC
       RTDD 1
       RCHD CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOD *        TO READ ONE WD AND BCD EOF
       TRA *+2       CONTINUE
       REM
       BCD 1TEFD     TEST EOF TGR + INDICATOR
       REM
BETA   TEFD *+3      SHOULD TRANS
       TSX ERROR-1,4
       TXL BETA,4
       REM
       TEFD *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 ERROR-TGR SHOULD BE OFF
       TXL BETA,4
       REM
       RTBD 1
       RCHD CNTLR+2  NO TGRS ON-WRD CNT 2
       REM           TO READ ONE WD AND BIN EOF
       TCOD *        DELAY
       TRA *+2
       REM
       BCD 1TEFD     TEST EOF + INDICATOR
       REM
       TEFD *+3
       TSX ERROR-1,4
       TXL *-2,4,0   DO NOT REPEAT
       REM
       CLA READ      WORD READ
       LDQ ONES      WORD WRITTEN
       CAS ONES
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP ALPHA
       TSX RDNCK,4   TEST RDNCY
       TRA ALPHA
       REM
       CLA READ+2    WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP ALPHA
       TSX OK,4      OUT TO TEST SWITCHES
       TRA ALPHA
       NOP
       REM
       REM
       RNT 0,4       TEST FOR CHANNELS E+F
       TRA TEST      NO
       REM
       ETTE
       REWE 1
       TRA *+2
       REM
       BCD 1TCOE     TEST TRANS CHANNEL E IN OPN
       REM
GO     WTBE 1
       TCOE *+3      CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL GO
       REM
       RCHE CNTL     NO TGRS ON-WORD. CNT. 1
       TCOE *+3      SHOULD TRANS.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL GO
       REM
       TCOE *        IF UNIT RUNS AWAY,OR
       REM           MACHINE HANGS ON THIS
       REM           OR ANY PREVIOUS TCOE
       REM           OPN.,BUFFER MAY NOT BE
       REM           RECEIVING END OPER. FROM
       REM           SYNC.
       TCOE *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 TRANS. IN ERROR-TCOE
       TXL GO
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA GO
       REM
       BCD 1TCNE     TEST TRANS. CHAN NOT IN OPN
       REM
JUMP   TCNE *+3      SHOULD TRANS
       TSX ERROR-1,4 FAILED TO TRANS.
       TXL JUMP
       REM
       WTBE 1
       TCNE *+2      SHOULD NOT TRANS,
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL JUMP
       REM
       RCHE CNTL+1   NO TGRS. ON-WRD. CNT. 1
       TCNE *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL JUMP
       REM
       TCOE *
       TCNE *+3      SHOULD TRANS.
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL JUMP
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA JUMP
       REM
       BCD 1BTTE     TEST BEGIN. TAPE
       REM
INTO   REWE 1
       BSRE 1        BACKSPACE TO LOAD PT.
       REWE 1        SHOULD ACT AS NOP
       BSRE 1        TRY TO BSKSP OVER LD. PT.
       TCOE *        DELAY
       REM           BEGIN. TAPE TGR. SHOULD
       REM           BE TURNED ON HERE
       BTTE
       TRA *+3       OK-SHOULD BE ON
       TSX ERROR-1,4 SHLD NOT SKIP TO ENTER HERE
       TXL INTO
       REM
       BTTE
       TRA *+2       ERROR-BTT SHOULD BE OFF
       TRA *+3       OK-OFF
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL INTO
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA INTO
       REM
       BCD 1IOT      TEST I/O CHECK TGR.
       REM
THE    WTBE 1
       RCHE CNTL     NO TGRS. ON-WRD. CNT. 1
       TCOE *
       LCHE CNTL+1   SHOULD TURN ON IOT
       IOT
       TRA *+3       SHOULD ENTER HERE-OK
       TSX ERROR-1,4 ERROR-SHOULD NOT SKIP
       TXL THE
       REM
       IOT
       TRA *+2       ERROR-TGR WAS NOT TURNED
       REM           OFF BY PREVIOUS SEQUENCE
       TRA *+3       OK-TGR SHOULD BE OFF
       TSX ERROR-1,4
       TXL THE
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA THE
       REM
       BCD 1WEFE     TEST TO SEE THAT WEF
       REM           BCD OR BINARY, BOTH
       REM           WRITE TAPE MARKS
       REM
       WTDE 1
       RCHE CNTL     NO TGRS. ON-WRD. CNT. 1
       WEFE 1        BCD EOF
       WTBE 1
       RCHE CNTL+1   NO. TGRS ON-WRD. CNT. 1
       WEFE 17       BINARY EOF. SHOULD
       REM           WRITE BCD TAPE MARK
       TRA *+2
       REM
       BCD 1BSFE 1
       REM
LAKE   BSRE 17
       BSRE 1
       RTBE 1
       RCHE CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOE *
       REM
       CLA READ      WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP LAKE
       TSX RDNCK,4
       TRA LAKE
       REM
       TEFE *+3      SHOULD TRANS.
       TSX ERROR-1,4 EOF DID NOT COME UP
       TXL A
       TRA *+2
       REM
       BCD 1BSRE 1
       REM
RING   BSFE 1        BKSP OVER EOF
       BSFE 1        BKSP OVER EOF AND 1 REC
       BSRE 1        BKSP OVER 1 REC
       RTDE 1
       RCHE CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOE *        TO READ ONE WD AND BCD EOF
       TRA *+2       CONTINUE
       REM
       BCD 1TEFE     TEST EOF TGR + INDICATOR
       REM
A      TEFE *+3      SHOULD TRANS
       TSX ERROR-1,4
       TXL A,4
       REM
       TEFE *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 ERROR-TGR SHOULD BE OFF
       TXL A,4
       REM
       RTBE 1
       RCHE CNTLR+2  NO TGRS ON-WRD CNT 2
       REM           TO READ ONE WD AND BIN EOF
       TCOE *        DELAY
       TRA *+2
       REM
       BCD 1TEFE     TEST EOF TGR + INDICATOR
       REM
       TEFE *+3
       TSX ERROR-1,4
       TXL *-2,4,0   DO NOT REPEAT
       REM
       CLA READ      WORD READ
       LDQ ONES      WORD WRITTEN
       CAS ONES
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RING
       TSX RDNCK,4   TEST RDNCY
       TRA RING
       REM
       CLA READ+2    WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RING
       TSX OK,4      OUT TO TEST SWITCHES
       TRA RING
       NOP
       REM
       REM
       REM
       ETTF
       REWF 1
       TRA *+2
       REM
       BCD 1TCOF     TEST TRANS CHANNEL F IN OPN
       REM
ROUND  WTBF 1
       TCOF *+3      CHNA. SHOULD BE IN OPN.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN.
       TXL ROUND
       REM
       RCHF CNTL     NO TGRS ON-WORD. CNT. 1
       TCOF *+3      SHOULD TRANS.
       TSX ERROR-1,4 FAILED TO TRANS. IN OPN
       TXL ROUND
       REM
       TCOF *        IF UNIT RUNS AWAY,OR
       REM           MACHINE HANGS ON THIS
       REM           OR ANY PREVIOUS TCOF
       REM           OPN.,BUFFER MAY NOT BE
       REM           RECEIVING END OPER. FROM
       REM           SYNC.
       TCOF *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 TRANS. IN ERROR-TCOF
       TXL ROUND
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA ROUND
       REM
       BCD 1TCNF     TEST TRANS. CHAN NOT IN OPN
       REM
ROSY   TCNF *+3      SHOULD TRANS
       TSX ERROR-1,4 FAILED TO TRANS.
       TXL ROSY
       REM
       WTBF 1
       TCNF *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL ROSY
       REM
       RCHF CNTL+1   NO TGRS. ON-WRD. CNT. 1
       TCNF *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL ROSY
       REM
       TCOF *
       TCNF *+3      SHOULD TRANS.
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL ROSY
       REM
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA ROSY
       REM
       BCD 1BTTF     TEST BEGIN. TAP
       REM
POCK   REWF 1
       BSRF 1        BACKSPACE TO LOAD PT.
       REWF 1        SHOULD ACT AS NOP
       BSRF 1        TRY TO BCKSP OVER LD. PT.
       TCOF *        DELAY
       REM           BEGIN. TAPE TGR. SHOULD
       REM           BE TURNED ON HERE
       BTTF
       TRA *+3       ON SHOULD BE OK
       TSX ERROR-1,4 SHLD NOT SKIP TO ENTER HERE
       TXL POCK
       REM
       BTTF
       TRA *+2       ERROR-BTT SHOULD BE OFF
       TRA *+3       OK-OFF
       TSX ERROR-1,4 SHOULD NOT ENTER HERE
       TXL POCK
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA POCK
       REM
       BCD 1IOT      TEST I/O CHECK TGR.
       REM
ET     WTBF 1
       RCHF CNTL     NO TGRS. ON-WRD. CNT. 1
       TCOF *
       LCHF CNTL+1   SHOULD TURN ON IOT
       IOT
       TRA *+3       SHOULD ENTER HERE-OK
       TSX ERROR-1,4 ERROR-SHOULD NOT SKIP
       TXL ET
       REM
       IOT
       TRA *+2       ERROR-TGR WAS NOT TURNED
       REM           OFF BY PREVIOUS SEQUENCE
       TRA *+3       OK-TGR SHOULD BE OFF
       TSX ERROR-1,4
       TXL ET
       TSX OK,4      OUT TO CHECK SWITCHES
       TRA ET
       REM
       BCD 1WEFF     TEST TO SEE THAT WEF
       REM           BCD OR BINARY, BOTH
       REM           WRITE TAPE MARKS
       REM
       WTDF 1
       RCHF CNTL     NO TGRS. ON-WRD. CNT. 1
       WEFF 1        BCD EOF
       WTBF 1
       RCHF CNTL+1   NO. TGRS ON-WRD. CNT. 1
       WEFF 17       BINARY EOF. SHOULD
       REM           WRITE BCD TAPE MARK
       TRA *+2
       REM
       BCD 1BSRF 1
       REM
FULL   BSRF 17
       BSRF 1
       RTBF 1
       RCHF CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOF *
       REM
       CLA READ      WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP FULL
       TSX RDNCK,4
       TRA FULL
       REM
       TEFF *+3      SHOULD TRANS.
       TSX ERROR-1,4 EOF DID NOT COME UP
       TXL POSYS
       TRA *+2
       REM
       BCD 1BSFF 1
       REM
OF     BSFF 1        BKSP OVER EOF
       BSFF 1        BKSP OVER EOF AND 1 REC
       BSRF 1        BKSP OVER 1 REC
       RTDF 1
       RCHF CNTLR+1  NO TGRS ON-WRD CNT 2
       TCOF *        TO READ ONE WD AND BCD EOF
       TRA *+2       CONTINUE
       REM
       BCD 1TEFF     TEST EOF TGR + INDICATOR
       REM
POSYS  TEFF *+3      SHOULD TRANS
       TSX ERROR-1,4
       TXL POSYS,4
       REM
       TEFF *+2      SHOULD NOT TRANS.
       TRA *+3       OK
       TSX ERROR-1,4 ERROR-TGR SHOULD BE OFF
       TXL POSYS,4
       REM
       RTBF 1
       RCHF CNTLR+2  NO TGRS ON-WRD CNT 2
       REM           TO READ ONE WD AND BIN EOF
       TCOF *        DELAY
       TRA *+2
       REM
       BCD 1TEFF     TEST EOF TGR + INDICATOR
       REM
       TEFF *+3
       TSX ERROR-1,4
       TXL *-2,4,0   DO NOT REPEAT
       REM
       CLA READ      WORD READ
       LDQ ONES      WORD WRITTEN
       CAS ONES
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP OF
       TSX RDNCK,4   TEST RDNCY
       TRA OF
       REM
       CLA READ+2    WORD READ
       LDQ ZEROS     WORD WRITTEN
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP OF
       TSX OK,4      OUT TO TEST SWITCHES
       TRA OF
       NOP
       REM
*THIS SECTION WRITES A 100 WORD RECORD ON ALL CHANNELS
*SELECTED TO MOVE FROM LOAD POINT, THEN REPEAT THE SAME RECORD FOR TEST.
       REM
TEST   AXT 70,1
       AXT 65,2
       REM
       RNT 0,1       TEST FOR CHANNELS A+B
       TRA TEST1     NO
       WTBA 2        WRITE CHAN A
       RCHA WR1
       WTBB 1        WRITE CHAN B
       RCHB WR2
       REM
TEST1  RNT 0,2       TEST FOR CHANNELS C+D
       TRA TEST2     NO
       WTBC 1        WRITE CHAN C
       RCHC WR3
       WTBD 1        WRITE CHAN D
       RCHD WR4
       REM
TEST2  RNT 0,4       TEST FOR CHANNELS E+F
       TRA TEST2+6   NO
       WTBE 1        WRITE CHAN E
       RCHE WR5
       WTBF 1        WRITE CHAN F
       RCHF WR6
       TRA CLEAR+5
       TIX TEST+2,2,1 TAPE WILL BE WRITTEN 101
       REM           TIMES. THE FIRST TIME
       REM           TO MOVE FROM LOAD POINT
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
RPEAT  RNT 0,1       TEST BKSPAC A+B
       TRA *+3
       BSRA 2
       BSRB 1
       REM
       RNT 0,2       TEST BACKSPACE C+D
       TRA *+3
       BSRC 1
       BSRD 1
       REM
       RNT 0,4       TEST BACKSPACE E+F
       TRA *+3
       BSRE 1
       BSRF 1
       TIX RPEAT,2,1 BACKSPACE 100 RECS.
       REM
       AXT 64,2
READ5  RNT 0,1       TEST FOR READ
       TRA *+5       NO
       RTBA 2        READ TAPE CHAN A
       RCHA CCHA
       RTBB 1        READ TAPE CHAN B
       RCHB CCHB
       REM
       RNT 0,2       TEST TO READ C+D
       TRA *+5       NO
       RTBC 1        READ TAPE CHAN C
       RCHC CCHC
       RTBD 1        READ TAPE CHAN D
       RCHD CCHD
       REM
       RNT 0,4       TEST TO READ E+F
       TRA *+5       NO
       RTBE 1        READ TAPE CHAN E
       RCHE CCHE
       RTBF 1        READ TAPE CHAN F
       RCHF CCHF
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
       REM
       RNT 0,1       TEST FOR CHAN A+B
       TRA *+3       NO
       SCHA SCH
       SCHB SCH+1
       REM
       RNT 0,2       TEST FOR CHAN C+D
       TRA *+3       NO
       SCHC SCH+2
       SCHD SCH+3
       REM
       RNT 0,4       TEST FOR CHAN E+F
       TRA *+3       NO
       SCHE SCH+4
       SCHF SCH+5
       REM
       CLA CT
       STO WDNO
       CLA CT1
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
       RNT 0,1       TEST FOR CHANS A+B
       TRA A1        NO
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
       BCD 1SCHB
       REM
       REM
       CLA SCH+1     WORD FROM CHANNEL
       LDQ CINFO+1   CORRECT INFORMATION
       CAS CINFO+1
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
       BCD 1 TEFB
       REM
       TEFB *+2      ERROR
       TRA *+5
       TSX ERROR-1,4 EXIT HERE WILL
       TXL *-3,4     INDICATE FALSE EOF
       TRA *+2       CHANNEL B
       REM
       BCD 1 RTBA
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
A1     RNT 0,2       TEST FOR CHANNELS C+D
       TRA A2        NO
       TRA *+2       YES
       REM
       BCD 1SCHC
       REM
       CLA SCH+2     WORD FROM CHANNEL
       LDQ CINFO+2   CORRECT INFORMATION
       CAS CINFO+2
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1SCHD
       REM
       CLA SCH+3     WORD FOR CHANNEL
       LDQ CINFO+3   CORRECT INFORMATION
       CAS CINFO+3
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
       BCD 1TEFD
       REM
       TEFD *+2      ERROR
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
A2     RNT 0,4       TEST FOR CHANNELS E+F
       TRA CLEAR      NO-GO TO CLEAR READ AREA
       TRA *+2
       REM
       BCD 1SCHE
       REM
       CLA SCH+4     WORD FROM CHANNEL
       LDQ CINFO+4   CORRECT INFORMATION
       CAS CINFO+4
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1SCHF
       REM
       CLA SCH+5     WORD FROM CHANNEL
       LDQ CINFO+5   CORRECT INFORMATION
       CAS CINFO+5
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
       BCD 1TEFF
       REM
       TEFF *+2      ERROR
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
       REM
*CLEAR READ FIELD AREAS
       REM
CLEAR  AXT 384,1     L 600 IN XRA
       STZ RCHA+384,1
       TIX *-1,1,1
       TIX READ5,2,1 REPEAT 100 TIMES
       TRA PRINT     PASS COMPLETE
       REM
       REM
       ETTA
       TRA EOT       REWIND
       ETTB
       TRA EOT       REWIND
       ETTC
       TRA EOT       REWIND
       ETTD
       TRA EOT       REWIND
       ETTE
       TRA EOT       REWIND
       ETTF
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
CHNG   RNT 700000    TEST FOR ALL CHANNELS
       TRA *+3       NO
       AXT 1,3       YES SET UP FOR 38 CYCLES EACH
       TRA ALL       GO GENERATE COMMANDS
       AXT 3,1       SET UP 58 CYCLES,CHANS A,C AND OR E
       AXT 2,2       SET UP 48 CYCLES, CHANS B,D AND OR F
       RNT 600000    AB+CD
       TRA *+2       NO
       TRA ALL       YES
       RNT 500000    AB+EF
       TRA *+2       NO
       TRA ALL       YESS
       RNT 300000    CD+EF
       TRA *+2       NO
       TRA ALL       YES
       AXT 7,3       SET UP 98 CYCLES
       RFT 700000    ANY
       TRA ALL       YES
       TRA BEGIN+8   NO CHANNELS SPECIFIED
ALL    SXA XRA,1     STORE # OF TCH COMMANDS FOR A,B,E
       SXA XRB,2     B,D,F.
       CAL TCH       GET ORIGNAL TCH
       RNT 100000    A+B
       TRA B         NO
       STA READ5+3   YES-STORE ADDRESS OF FIRST
       REM           COMMAND IN RCHA
       LDQ IOCPA     GENERATE
       AXT 63,4      COMMANDS
       LXA XRA,1     FOR
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
       STA READ5+5   STORE ADDR OF FIRST
       STA RD10+5    COMMMAND IN RCHB
       PAX ,1        STORE PROPER CONSTANT TO TEST
       SXD CINFO,1   STORE CHANNEL
       LDQ IOCPB     B
       AXT 63,4
       LXA XRB,2
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
B      RNT 200000    C+D
       TRA C         NO
       STA READ5+9   YES-STORE ADDRESS OF FIRST
       STA RD10+9    COMMAND IN RCHC
       LDQ IOCPC     C
       AXT 63,4
       LXA XRA,1
       STA *+3
       ADD ONE
       XCL
       SLW
       ADD ONE              THIS
       XCL
       STA *+2
       ADD ONE
       SLW
       TIX *-3,1,1
       TIX *-11,4,1         ROUTINE
       LDQ IOCDC
       STA *+1
       STQ
       ADD ONE
       STA READ5+11
       STA RD10+11
       PAX ,1
       SXD CINFO+2,1
       LDQ IOCPD     D
       AXT 63,4
       LXA XRB,2
       STA *+3
       ADD ONE
       XCL                 WILL STORE
       SLW
       ADD ONE
       XCL
       STA *+2
       ADD ONE
       SLW
       TIX *-3,2,1
       TIX *-11,4,1
       LDQ IOCDD           ADDED TCH
       STA *+1
       STQ
       ADD ONE
       PAX ,1
       SXD CINFO+3,1
C      RNT 400000    ESF
       TRA BEGIN+10  NO
       STA READ5+15  YES
       STA RD10+15         COMMANDS
       LDQ IOCPE
       AXT 63,4
       LXA XRA,1
       STA *+3
       ADD ONE
       XCL
       SLW
       ADD ONE
       XCL                 FOR
       STA *+2
       ADD ONE
       SLW
       TIX *-3,1,1
       TIX *-11,4,1
       LDQ IOCDE           CHANNELS
       STA *+1
       STQ
       ADD ONE
       STA READ5+17
       STA RD10+17
       PAX ,1
       SXD CINFO+4,1
       LDQ IOCPF     F
       AXT 63,4
       LXA XRB,2
       STA *+3             C AND E-F
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
       TRA BEGIN+10  RETURN TO PROGRAM
       REM
       REM
ANS    AXT 64,2
BKSP   RNT 0,1       TEST FOR BACKSPACE A+B
       TRA *+3
       BSRA 2
       BSRB 1
       REM
       RNT 0,2       TEST FOR BACKSPACE C+D
       TRA *+3
       BSRC 1
       BSRD 1
       REM
       RNT 0,4       TEST FOR BACKSPACE E+F
       TRA *+3
       BSRE 1
       BSRF 1
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
RD10   RNT 0,1       TEST FOR READ A+B
       TRA *+5       NO
       RTBA 2
       RCHA CCHA     READ TAPE-A
       RTBB 1
       RCHB CCHB     READ TAPE-B
       REM
       RNT 0,2       TEST TO READ C+D
       TRA *+5       NO
       RTBC 1        READ TAPE-C
       RCHC CCHC
       RTBD 1        READ TAPE-D
       RCHD CCHD
       REM
       RNT 0,4       TEST TO READ E+F
       TRA *+5       NO
       RTBE 1        READ TAPE-E
       RCHE CCHE
       RTBF 1        READ TAPE-F
       RCHF CCHF
       REM
SCHS   SCHA SCH      STORE
       SCHB SCH+1    ADDRESS AND
       SCHC SCH+2    LOCATION
       SCHD SCH+3    REGISTERS FOR
       SCHE SCH+4    EACH
       SCHF SCH+5    CHANNEL
       REM
       REM
TRY    AXT 6,1
       AXT 18,4
       ANS* SAVE
       LDQ CINFO+6,1
       CAL CINFO+6,1 CORRECT INFORMATION
       STD *+13      STORE LOCATION REG.
       ALS 18
       STD *+8       STORE ADDRESS REG.
       SUB K1000
       STD *+8
       REM
       CAL SCH+6,1   CONTENTS DSC
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
       TRA ERCHA+18,4
       REM
HOOT   TIX RD10,2,1
       TRA TCO
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
EOT    RNT 0,1       TEST FOR DSC A+B
       TRA *+3
       REWA 2
       REWB 1
       RNT 0,2       TEST FOR DSC C+D
       TRA *+3
       REWC 1
       REWD 1
       RNT 0,4       TEST FOR DSC E+F
       TRA *+3
       REWE 1
       REWF 1
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
PCOM   OCT 10           9L
       OCT 4000400000   9R
       OCT 0            8L
       OCT 0            8R
       OCT 2004000      7L
       OCT 0            7R
       OCT 20000        6L
       OCT 30000000000  6R
       OCT 1200         5L
       OCT 20100000     5R
       OCT 10000        4L
       OCT 200000       4R
       OCT 42401        3L
       OCT 1201000000   3R
       OCT 600004       2L
       OCT 2044000000   2R
       OCT 1000000      1L
       OCT 100000000    1R
       OCT 600402       0L
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
       OCT 10201000     5L
       OCT 40200000     5R
       OCT 4000         4L
       OCT 400000       4R
       OCT 2            3L
       OCT 2402000000   3R
       OCT 10           2L
       OCT 4110000000   2R
       OCT 0            1L
       OCT 200000000    1R
       OCT 2000004      0L
       OCT 46102000000  0R
       OCT 14535100     11L
       OCT 230000400000 11R
       OCT 242410       12R
       OCT 651200000    12L
       REM
CTRL   OCT 0
STCTL  IOCD PPER,0,24
       REM
WR1    IOCD WTCHA,0,64 TO WRITE TAPE CHAN A
WR2    IOCD WTCHB,0,64 TO WRITE TAPE CHAN B
WR3    IOCD WTCHC,0,64 TO WRITE TAPE CHAN C
WR4    IOCD WTCHD,0,64 TO WRITE TAPE CHAN D
WR5    IOCD WTCHE,0,64 TO WRITE TAPE CHAN E
WR6    IOCD WTCHF,0,64 TO WRITE TAPE CHAN F
       REM
SAVE   NOP *+1
SAVE1
RCHA   BSS 64        100 WORD
RCHB   BSS 64
RCHC   BSS 64         BLOCKS FOR
RCHD   BSS 64
RCHE   BSS 64        TAPE READ
RCHF   BSS 64
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
       IOCD RCHB+64,0,CCHB+127 INFORMATION
       IOCD RCHC+64,0,CCHC+127 TO COMPARE
       IOCD RCHD+64,0,CCHD+127 STORE
       IOCD RCHE+64,0,CCHE+127 CHANNEL
       IOCD RCHF+64,0,CCHF+127 OPERATIONS
       REM
SCH    OCT 0
       OCT 0
       OCT 0
       OCT 0
       OCT 0
       OCT 0
COUNT  OCT 0
       REM
CT     DEC 65
CT1    OCT 101
       REM
SAVE2  OCT 0         STORAGE
SAVE3  OCT 0         FOR
SAVE4  OCT 0         STORE
SAVE5  OCT 0         CHANNEL
SAVE6  OCT 0         INFORMATION
SAVE7  OCT 0
       REM
BLCHA  IOCD ERCHA+1
BLCHB  IOCD ERCHB+1
BLCHC  IOCD ERCHC+1
BLCHD  IOCD ERCHD+1
BLCHE  IOCD ERCHE+1
BLCHF  IOCD ERCHF+1
MASK   OCT 077777777777
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
XRA    PZE
XRB    PZE
K1000  OCT 1000000
SINDX  OCT 0
ONE    OCT 1
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
*FROM THIS POINT TO END OF CONSTANT FIELD ARE THE CONTROL WORDS USED FOR
*CHANNEL. EVERY OTHER CONTROL WORD READS ONE WORD FOLLOWED BY ONE INDIRECTLY
*ADDRESSED TO THE NEXT, WHICH READS ONE WORD.
       REM
*CONTROL TO READ 100 WORDS FROM TAPE-CHANNNNN
       REM
CCHA   IOCP RCHA,0,1
       TCH *+1
       IOCP RCHA+1,0,1
       TCH *+1
       IOCP RCHA+2,0,1
       TCH *+1
       IOCP RCHA+3,0,1
       TCH *+1
       IOCP RCHA+4,0,1
       TCH *+1
       IOCP RCHA+5,0,1
       TCH *+1
       IOCP RCHA+6,0,1
       TCH *+1
       IOCP RCHA+7,0,1
       TCH *+1
       IOCP RCHA+8,0,1
       TCH *+1
       IOCP RCHA+9,0,1
       TCH *+1
       IOCP RCHA+10,0,1
       TCH *+1
       IOCP RCHA+11,0,1
       TCH *+1
       IOCP RCHA+12,0,1
       TCH *+1
       IOCP RCHA+13,0,1
       TCH *+1
       IOCP RCHA+14,0,1
       TCH *+1
       IOCP RCHA+15,0,1
       TCH *+1
       IOCP RCHA+16,0,1
       TCH *+1
       IOCP RCHA+17,0,1
       TCH *+1
       IOCP RCHA+18,0,1
       TCH *+1
       IOCP RCHA+19,0,1
       TCH *+1
       IOCP RCHA+20,0,1
       TCH *+1
       IOCP RCHA+21,0,1
       TCH *+1
       IOCP RCHA+22,0,1
       TCH *+1
       IOCP RCHA+23,0,1
       TCH *+1
       IOCP RCHA+24,0,1
       TCH *+1
       IOCP RCHA+25,0,1
       TCH *+1
       IOCP RCHA+26,0,1
       TCH *+1
       IOCP RCHA+27,0,1
       TCH *+1
       IOCP RCHA+28,0,1
       TCH *+1
       IOCP RCHA+29,0,1
       TCH *+1
       IOCP RCHA+30,0,1
       TCH *+1
       IOCP RCHA+31,0,1
       TCH *+1
       IOCP RCHA+32,0,1
       TCH *+1
       IOCP RCHA+33,0,1
       TCH *+1
       IOCP RCHA+34,0,1
       TCH *+1
       IOCP RCHA+35,0,1
       TCH *+1
       IOCP RCHA+36,0,1
       TCH *+1
       IOCP RCHA+37,0,1
       TCH *+1
       IOCP RCHA+38,0,1
       TCH *+1
       IOCP RCHA+39,0,1
       TCH *+1
       IOCP RCHA+40,0,1
       TCH *+1
       IOCP RCHA+41,0,1
       TCH *+1
       IOCP RCHA+42,0,1
       TCH *+1
       IOCP RCHA+43,0,1
       TCH *+1
       IOCP RCHA+44,0,1
       TCH *+1
       IOCP RCHA+45,0,1
       TCH *+1
       IOCP RCHA+46,0,1
       TCH *+1
       IOCP RCHA+47,0,1
       TCH *+1
       IOCP RCHA+48,0,1
       TCH *+1
       IOCP RCHA+49,0,1
       TCH *+1
       IOCP RCHA+50,0,1
       TCH *+1
       IOCP RCHA+51,0,1
       TCH *+1
       IOCP RCHA+52,0,1
       TCH *+1
       IOCP RCHA+53,0,1
       TCH *+1
       IOCP RCHA+54,0,1
       TCH *+1
       IOCP RCHA+55,0,1
       TCH *+1
       IOCP RCHA+56,0,1
       TCH *+1
       IOCP RCHA+57,0,1
       TCH *+1
       IOCP RCHA+58,0,1
       TCH *+1
       IOCP RCHA+59,0,1
       TCH *+1
       IOCP RCHA+60,0,1
       TCH *+1
       IOCP RCHA+61,0,1
       TCH *+1
       IOCP RCHA+62,0,1
       TCH *+1
       IOCD RCHA+63,0,1
       REM
*CONTROL TO READ 100 WORDS FROM TAPE-CHANNEL B
       REM
CCHB   IOCP RCHB,0,1
       TCH *+1
       IOCP RCHB+1,0,1
       TCH *+1
       IOCP RCHB+2,0,1
       TCH *+1
       IOCP RCHB+3,0,1
       TCH *+1
       IOCP RCHB+4,0,1
       TCH *+1
       IOCP RCHB+5,0,1
       TCH *+1
       IOCP RCHB+6,0,1
       TCH *+1
       IOCP RCHB+7,0,1
       TCH *+1
       IOCP RCHB+8,0,1
       TCH *+1
       IOCP RCHB+9,0,1
       TCH *+1
       IOCP RCHB+10,0,1
       TCH *+1
       IOCP RCHB+11,0,1
       TCH *+1
       IOCP RCHB+12,0,1
       TCH *+1
       IOCP RCHB+13,0,1
       TCH *+1
       IOCP RCHB+14,0,1
       TCH *+1
       IOCP RCHB+15,0,1
       TCH *+1
       IOCP RCHB+16,0,1
       TCH *+1
       IOCP RCHB+17,0,1
       TCH *+1
       IOCP RCHB+18,0,1
       TCH *+1
       IOCP RCHB+19,0,1
       TCH *+1
       IOCP RCHB+20,0,1
       TCH *+1
       IOCP RCHB+21,0,1
       TCH *+1
       IOCP RCHB+22,0,1
       TCH *+1
       IOCP RCHB+23,0,1
       TCH *+1
       IOCP RCHB+24,0,1
       TCH *+1
       IOCP RCHB+25,0,1
       TCH *+1
       IOCP RCHB+26,0,1
       TCH *+1
       IOCP RCHB+27,0,1
       TCH *+1
       IOCP RCHB+28,0,1
       TCH *+1
       IOCP RCHB+29,0,1
       TCH *+1
       IOCP RCHB+30,0,1
       TCH *+1
       IOCP RCHB+31,0,1
       TCH *+1
       IOCP RCHB+32,0,1
       TCH *+1
       IOCP RCHB+33,0,1
       TCH *+1
       IOCP RCHB+34,0,1
       TCH *+1
       IOCP RCHB+35,0,1
       TCH *+1
       IOCP RCHB+36,0,1
       TCH *+1
       IOCP RCHB+37,0,1
       TCH *+1
       IOCP RCHB+38,0,1
       TCH *+1
       IOCP RCHB+39,0,1
       TCH *+1
       IOCP RCHB+40,0,1
       TCH *+1
       IOCP RCHB+41,0,1
       TCH *+1
       IOCP RCHB+42,0,1
       TCH *+1
       IOCP RCHB+43,0,1
       TCH *+1
       IOCP RCHB+44,0,1
       TCH *+1
       IOCP RCHB+45,0,1
       TCH *+1
       IOCP RCHB+46,0,1
       TCH *+1
       IOCP RCHB+47,0,1
       TCH *+1
       IOCP RCHB+48,0,1
       TCH *+1
       IOCP RCHB+49,0,1
       TCH *+1
       IOCP RCHB+50,0,1
       TCH *+1
       IOCP RCHB+51,0,1
       TCH *+1
       IOCP RCHB+52,0,1
       TCH *+1
       IOCP RCHB+53,0,1
       TCH *+1
       IOCP RCHB+54,0,1
       TCH *+1
       IOCP RCHB+55,0,1
       TCH *+1
       IOCP RCHB+56,0,1
       TCH *+1
       IOCP RCHB+57,0,1
       TCH *+1
       IOCP RCHB+58,0,1
       TCH *+1
       IOCP RCHB+59,0,1
       TCH *+1
       IOCP RCHB+60,0,1
       TCH *+1
       IOCP RCHB+61,0,1
       TCH *+1
       IOCP RCHB+62,0,1
       TCH *+1
       IOCD RCHB+63,0,1
       REM
*CONTROL TO READ 100 WORDS FROM TAPE-CHANNEL C
       REM
CCHC   IOCP RCHC,0,1
       TCH *+1
       IOCP RCHC+1,0,1
       TCH *+1
       IOCP RCHC+2,0,1
       TCH *+1
       IOCP RCHC+3,0,1
       TCH *+1
       IOCP RCHC+4,0,1
       TCH *+1
       IOCP RCHC+5,0,1
       TCH *+1
       IOCP RCHC+6,0,1
       TCH *+1
       IOCP RCHC+7,0,1
       TCH *+1
       IOCP RCHC+8,0,1
       TCH *+1
       IOCP RCHC+9,0,1
       TCH *+1
       IOCP RCHC+10,0,1
       TCH *+1
       IOCP RCHC+11,0,1
       TCH *+1
       IOCP RCHC+12,0,1
       TCH *+1
       IOCP RCHC+13,0,1
       TCH *+1
       IOCP RCHC+14,0,1
       TCH *+1
       IOCP RCHC+15,0,1
       TCH *+1
       IOCP RCHC+16,0,1
       TCH *+1
       IOCP RCHC+17,0,1
       TCH *+1
       IOCP RCHC+18,0,1
       TCH *+1
       IOCP RCHC+19,0,1
       TCH *+1
       IOCP RCHC+20,0,1
       TCH *+1
       IOCP RCHC+21,0,1
       TCH *+1
       IOCP RCHC+22,0,1
       TCH *+1
       IOCP RCHC+23,0,1
       TCH *+1
       IOCP RCHC+24,0,1
       TCH *+1
       IOCP RCHC+25,0,1
       TCH *+1
       IOCP RCHC+26,0,1
       TCH *+1
       IOCP RCHC+27,0,1
       TCH *+1
       IOCP RCHC+28,0,1
       TCH *+1
       IOCP RCHC+29,0,1
       TCH *+1
       IOCP RCHC+30,0,1
       TCH *+1
       IOCP RCHC+31,0,1
       TCH *+1
       IOCP RCHC+32,0,1
       TCH *+1
       IOCP RCHC+33,0,1
       TCH *+1
       IOCP RCHC+34,0,1
       TCH *+1
       IOCP RCHC+35,0,1
       TCH *+1
       IOCP RCHC+36,0,1
       TCH *+1
       IOCP RCHC+37,0,1
       TCH *+1
       IOCP RCHC+38,0,1
       TCH *+1
       IOCP RCHC+39,0,1
       TCH *+1
       IOCP RCHC+40,0,1
       TCH *+1
       IOCP RCHC+41,0,1
       TCH *+1
       IOCP RCHC+42,0,1
       TCH *+1
       IOCP RCHC+43,0,1
       TCH *+1
       IOCP RCHC+44,0,1
       TCH *+1
       IOCP RCHC+45,0,1
       TCH *+1
       IOCP RCHC+46,0,1
       TCH *+1
       IOCP RCHC+47,0,1
       TCH *+1
       IOCP RCHC+48,0,1
       TCH *+1
       IOCP RCHC+49,0,1
       TCH *+1
       IOCP RCHC+50,0,1
       TCH *+1
       IOCP RCHC+51,0,1
       TCH *+1
       IOCP RCHC+52,0,1
       TCH *+1
       IOCP RCHC+53,0,1
       TCH *+1
       IOCP RCHC+54,0,1
       TCH *+1
       IOCP RCHC+55,0,1
       TCH *+1
       IOCP RCHC+56,0,1
       TCH *+1
       IOCP RCHC+57,0,1
       TCH *+1
       IOCP RCHC+58,0,1
       TCH *+1
       IOCP RCHC+59,0,1
       TCH *+1
       IOCP RCHC+60,0,1
       TCH *+1
       IOCP RCHC+61,0,1
       TCH *+1
       IOCP RCHC+62,0,1
       TCH *+1
       IOCD RCHC+63,0,1
       REM
*CONTROL TO READ 100 WORDS FROM TAPE-CHANNEL D
       REM
CCHD   IOCP RCHD,0,1
       TCH *+1
       IOCP RCHD+1,0,1
       TCH *+1
       IOCP RCHD+2,0,1
       TCH *+1
       IOCP RCHD+3,0,1
       TCH *+1
       IOCP RCHD+4,0,1
       TCH *+1
       IOCP RCHD+5,0,1
       TCH *+1
       IOCP RCHD+6,0,1
       TCH *+1
       IOCP RCHD+7,0,1
       TCH *+1
       IOCP RCHD+8,0,1
       TCH *+1
       IOCP RCHD+9,0,1
       TCH *+1
       IOCP RCHD+10,0,1
       TCH *+1
       IOCP RCHD+11,0,1
       TCH *+1
       IOCP RCHD+12,0,1
       TCH *+1
       IOCP RCHD+13,0,1
       TCH *+1
       IOCP RCHD+14,0,1
       TCH *+1
       IOCP RCHD+15,0,1
       TCH *+1
       IOCP RCHD+16,0,1
       TCH *+1
       IOCP RCHD+17,0,1
       TCH *+1
       IOCP RCHD+18,0,1
       TCH *+1
       IOCP RCHD+19,0,1
       TCH *+1
       IOCP RCHD+20,0,1
       TCH *+1
       IOCP RCHD+21,0,1
       TCH *+1
       IOCP RCHD+22,0,1
       TCH *+1
       IOCP RCHD+23,0,1
       TCH *+1
       IOCP RCHD+24,0,1
       TCH *+1
       IOCP RCHD+25,0,1
       TCH *+1
       IOCP RCHD+26,0,1
       TCH *+1
       IOCP RCHD+27,0,1
       TCH *+1
       IOCP RCHD+28,0,1
       TCH *+1
       IOCP RCHD+29,0,1
       TCH *+1
       IOCP RCHD+30,0,1
       TCH *+1
       IOCP RCHD+31,0,1
       TCH *+1
       IOCP RCHD+32,0,1
       TCH *+1
       IOCP RCHD+33,0,1
       TCH *+1
       IOCP RCHD+34,0,1
       TCH *+1
       IOCP RCHD+35,0,1
       TCH *+1
       IOCP RCHD+36,0,1
       TCH *+1
       IOCP RCHD+37,0,1
       TCH *+1
       IOCP RCHD+38,0,1
       TCH *+1
       IOCP RCHD+39,0,1
       TCH *+1
       IOCP RCHD+40,0,1
       TCH *+1
       IOCP RCHD+41,0,1
       TCH *+1
       IOCP RCHD+42,0,1
       TCH *+1
       IOCP RCHD+43,0,1
       TCH *+1
       IOCP RCHD+44,0,1
       TCH *+1
       IOCP RCHD+45,0,1
       TCH *+1
       IOCP RCHD+46,0,1
       TCH *+1
       IOCP RCHD+47,0,1
       TCH *+1
       IOCP RCHD+48,0,1
       TCH *+1
       IOCP RCHD+49,0,1
       TCH *+1
       IOCP RCHD+50,0,1
       TCH *+1
       IOCP RCHD+51,0,1
       TCH *+1
       IOCP RCHD+52,0,1
       TCH *+1
       IOCP RCHD+53,0,1
       TCH *+1
       IOCP RCHD+54,0,1
       TCH *+1
       IOCP RCHD+55,0,1
       TCH *+1
       IOCP RCHD+56,0,1
       TCH *+1
       IOCP RCHD+57,0,1
       TCH *+1
       IOCP RCHD+58,0,1
       TCH *+1
       IOCP RCHD+59,0,1
       TCH *+1
       IOCP RCHD+60,0,1
       TCH *+1
       IOCP RCHD+61,0,1
       TCH *+1
       IOCP RCHD+62,0,1
       TCH *+1
       IOCD RCHD+63,0,1
       REM
*CONTROL TO READ 100 WORDS FROM TAPE-CHANNEL E
       REM
CCHE   IOCP RCHE,0,1
       TCH *+1
       IOCP RCHE+1,0,1
       TCH *+1
       IOCP RCHE+2,0,1
       TCH *+1
       IOCP RCHE+3,0,1
       TCH *+1
       IOCP RCHE+4,0,1
       TCH *+1
       IOCP RCHE+5,0,1
       TCH *+1
       IOCP RCHE+6,0,1
       TCH *+1
       IOCP RCHE+7,0,1
       TCH *+1
       IOCP RCHE+8,0,1
       TCH *+1
       IOCP RCHE+9,0,1
       TCH *+1
       IOCP RCHE+10,0,1
       TCH *+1
       IOCP RCHE+11,0,1
       TCH *+1
       IOCP RCHE+12,0,1
       TCH *+1
       IOCP RCHE+13,0,1
       TCH *+1
       IOCP RCHE+14,0,1
       TCH *+1
       IOCP RCHE+15,0,1
       TCH *+1
       IOCP RCHE+16,0,1
       TCH *+1
       IOCP RCHE+17,0,1
       TCH *+1
       IOCP RCHE+18,0,1
       TCH *+1
       IOCP RCHE+19,0,1
       TCH *+1
       IOCP RCHE+20,0,1
       TCH *+1
       IOCP RCHE+21,0,1
       TCH *+1
       IOCP RCHE+22,0,1
       TCH *+1
       IOCP RCHE+23,0,1
       TCH *+1
       IOCP RCHE+24,0,1
       TCH *+1
       IOCP RCHE+25,0,1
       TCH *+1
       IOCP RCHE+26,0,1
       TCH *+1
       IOCP RCHE+27,0,1
       TCH *+1
       IOCP RCHE+28,0,1
       TCH *+1
       IOCP RCHE+29,0,1
       TCH *+1
       IOCP RCHE+30,0,1
       TCH *+1
       IOCP RCHE+31,0,1
       TCH *+1
       IOCP RCHE+32,0,1
       TCH *+1
       IOCP RCHE+33,0,1
       TCH *+1
       IOCP RCHE+34,0,1
       TCH *+1
       IOCP RCHE+35,0,1
       TCH *+1
       IOCP RCHE+36,0,1
       TCH *+1
       IOCP RCHE+37,0,1
       TCH *+1
       IOCP RCHE+38,0,1
       TCH *+1
       IOCP RCHE+39,0,1
       TCH *+1
       IOCP RCHE+40,0,1
       TCH *+1
       IOCP RCHE+41,0,1
       TCH *+1
       IOCP RCHE+42,0,1
       TCH *+1
       IOCP RCHE+43,0,1
       TCH *+1
       IOCP RCHE+44,0,1
       TCH *+1
       IOCP RCHE+45,0,1
       TCH *+1
       IOCP RCHE+46,0,1
       TCH *+1
       IOCP RCHE+47,0,1
       TCH *+1
       IOCP RCHE+48,0,1
       TCH *+1
       IOCP RCHE+49,0,1
       TCH *+1
       IOCP RCHE+50,0,1
       TCH *+1
       IOCP RCHE+51,0,1
       TCH *+1
       IOCP RCHE+52,0,1
       TCH *+1
       IOCP RCHE+53,0,1
       TCH *+1
       IOCP RCHE+54,0,1
       TCH *+1
       IOCP RCHE+55,0,1
       TCH *+1
       IOCP RCHE+56,0,1
       TCH *+1
       IOCP RCHE+57,0,1
       TCH *+1
       IOCP RCHE+58,0,1
       TCH *+1
       IOCP RCHE+59,0,1
       TCH *+1
       IOCP RCHE+60,0,1
       TCH *+1
       IOCP RCHE+61,0,1
       TCH *+1
       IOCP RCHE+62,0,1
       TCH *+1
       IOCD RCHE+63,0,1
       REM
*CONTROL TO READ 100 WORDS FROM TAPE-CHANNEL F
       REM
CCHF   IOCP RCHF,0,1
       TCH *+1
       IOCP RCHF+1,0,1
       TCH *+1
       IOCP RCHF+2,0,1
       TCH *+1
       IOCP RCHF+3,0,1
       TCH *+1
       IOCP RCHF+4,0,1
       TCH *+1
       IOCP RCHF+5,0,1
       TCH *+1
       IOCP RCHF+6,0,1
       TCH *+1
       IOCP RCHF+7,0,1
       TCH *+1
       IOCP RCHF+8,0,1
       TCH *+1
       IOCP RCHF+9,0,1
       TCH *+1
       IOCP RCHF+10,0,1
       TCH *+1
       IOCP RCHF+11,0,1
       TCH *+1
       IOCP RCHF+12,0,1
       TCH *+1
       IOCP RCHF+13,0,1
       TCH *+1
       IOCP RCHF+14,0,1
       TCH *+1
       IOCP RCHF+15,0,1
       TCH *+1
       IOCP RCHF+16,0,1
       TCH *+1
       IOCP RCHF+17,0,1
       TCH *+1
       IOCP RCHF+18,0,1
       TCH *+1
       IOCP RCHF+19,0,1
       TCH *+1
       IOCP RCHF+20,0,1
       TCH *+1
       IOCP RCHF+21,0,1
       TCH *+1
       IOCP RCHF+22,0,1
       TCH *+1
       IOCP RCHF+23,0,1
       TCH *+1
       IOCP RCHF+24,0,1
       TCH *+1
       IOCP RCHF+25,0,1
       TCH *+1
       IOCP RCHF+26,0,1
       TCH *+1
       IOCP RCHF+27,0,1
       TCH *+1
       IOCP RCHF+28,0,1
       TCH *+1
       IOCP RCHF+29,0,1
       TCH *+1
       IOCP RCHF+30,0,1
       TCH *+1
       IOCP RCHF+31,0,1
       TCH *+1
       IOCP RCHF+32,0,1
       TCH *+1
       IOCP RCHF+33,0,1
       TCH *+1
       IOCP RCHF+34,0,1
       TCH *+1
       IOCP RCHF+35,0,1
       TCH *+1
       IOCP RCHF+36,0,1
       TCH *+1
       IOCP RCHF+37,0,1
       TCH *+1
       IOCP RCHF+38,0,1
       TCH *+1
       IOCP RCHF+39,0,1
       TCH *+1
       IOCP RCHF+40,0,1
       TCH *+1
       IOCP RCHF+41,0,1
       TCH *+1
       IOCP RCHF+42,0,1
       TCH *+1
       IOCP RCHF+43,0,1
       TCH *+1
       IOCP RCHF+44,0,1
       TCH *+1
       IOCP RCHF+45,0,1
       TCH *+1
       IOCP RCHF+46,0,1
       TCH *+1
       IOCP RCHF+47,0,1
       TCH *+1
       IOCP RCHF+48,0,1
       TCH *+1
       IOCP RCHF+49,0,1
       TCH *+1
       IOCP RCHF+50,0,1
       TCH *+1
       IOCP RCHF+51,0,1
       TCH *+1
       IOCP RCHF+52,0,1
       TCH *+1
       IOCP RCHF+53,0,1
       TCH *+1
       IOCP RCHF+54,0,1
       TCH *+1
       IOCP RCHF+55,0,1
       TCH *+1
       IOCP RCHF+56,0,1
       TCH *+1
       IOCP RCHF+57,0,1
       TCH *+1
       IOCP RCHF+58,0,1
       TCH *+1
       IOCP RCHF+59,0,1
       TCH *+1
       IOCP RCHF+60,0,1
       TCH *+1
       IOCP RCHF+61,0,1
       TCH *+1
       IOCP RCHF+62,0,1
       TCH *+1
       IOCD RCHF+63,0,1
ERROR  EQU 3396
OK     EQU 3401
RDNCK  EQU 3440
WDNO   EQU 3438
RECNO  EQU 3439
       END
