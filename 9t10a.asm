                                                             9T10A
                                                            11/1/58
*PROGRAM TO WRITE A NEW DIAGNOSTIC TAPE WITH SENSE SWITCH 5 UP
*
*PROGRAM TO WRITE MODIFIED AND ADDITIONAL DIAGNOSTICS WITH SENSE SWITCH
*
       ORG 24
       REM
       SWT 5
       TRA START      WRITE NEW TAPE FROM CARDS
       TRA TAPE       WRITE MODIFICATION FROM
       REM            CARDS AND TAPE
       REM
       REM
*WRITE A NEW TAPE FROM CARDS
*RESET INDICATORS
       REM
START  REWB 1         REW TAPE 1
       TEFA *+1       RESET EOF INDICATOR
       TEFB *+1
       TRCA *+1       RESET REDUNDANCY INDICATOR
       TRCB *+1
       SLF            TURN SENSE LITES OFF
       REM
*SELECT CARD READER INITIALLY AT THIS LOCATION
       REM
STRTA  RCDA           READ CARD
       RCHA CWA
STRTB  TCOA *
       TEFA EOF       TRANSFER ON EOF INDICATES
       REM            EOF ON CARD READER
       REM
       REM
*COMPUTE CHECK SUM BEFORE WRITING ON TAPE
       REM
       AXT 24,4       FORM CHECK SUM
       PXD
       ACL TSA+24,4
       TIX *-1,4,1
       SLW TSC        STORE CHECK SUM
       REM
       TNZ AA         CARD NOT BLANK
       REM
*TWO BLANK CARDS INDICATES END OF DIAGNOSTIC BEING WRITTEN.
       REM
       SLT 1          IS THIS 2ND BLANK CARD
       TRA *+4        NO-TURN ON LITE 1
       SLN 2          YES-2ND BLANK CARD
       SLN 4          TURN ON LITE 4
       TRA AB
       SLN 1          TURN ON LITE 1
       TRA AB         1ST BLANK CARD
AA     SLT 1          WAS PREVIOUS CARD BLANK
       TRA AB         NO - PROCEED.
      #BRBB 1         YES - BLANK CARD IN THE
      #HPR            MIDDLE OF THE DECK
       REM            RUN OF CARDS. 4TH CARD
       REM            BACK WILL BE BLANK. REMOVE
       REM            BLANK AND RELOAD LAST 3
       REM            CARDS AND THE REMAINDER OF
       REM            THE DECK. PRESS START.
       #TRA STRTA
       REM
*WRITE EACH CARD AS A RECORD ON CH B TAPE 1
       REM
AB     AXT 0,4        CLEAR XRC
       WTBB 1         WRITE CARD IMAGE ON TAPE
       RCHB CWA
       TCOB *
       TRCB *+2       TRA ON TAPE CHECK
       TRA AC         OK
      #BRBB 1         BACKSPACE RECORD
      #TXI *+1,4,1    TRY AGAIN
      #TXL *+2,4,5
      #HPR            TAPE WOULD NOT WRITE IN
      #TRA AB         5 TRIES - GET OFF MACHINE.
       REM
AC     BRBB 1         BACKSPACE TAPE
       REM
       SWT 5          TEST SENSE SWITCH 5
       TRA RCDA       SELECT CARD READER
       SLT 4          IS LITE 4 ON
       TRA RCDA       NO SELECT CARD READER
       TRA *+3        YES DO NOT SELECT
       REM            CARD READER
       REM
       REM
*READ IN NEXT CARD WHILE CHECKING RECORD JUST WRITTEN
       REM
RCDA   RCDA           READ NEXT CARD
       RCHA CWA
       REM
       RTBB 1         READ TAPE
       RCHB CWB       FOR CHECKING
       TCOB *
       TRCB *+2       TEST FOR TAPE CHECK
       TRA AD         OK
       #HPR           TAPE CHECK ON READ.
       REM            TO RESTART - RUN OUT CARDS
       REM            AND RELOAD LAST 3 CARDS
       REM            WITH REST OF DECK. THEN
       REM            PRESS START TO TRY AGAIN.
      #BRBB 1
      #TRA STRTA
       REM
*COMPUTE CHECK SUM ON RECORD JUST WRITTEN
       REM
AD     AXT 24,4       FORM CHECK SUM.
       PXD            CLEAR ACC.
       ACL TSB+24,4
       TIX *-1,4,1
       SLW TSD        TAPE CHECK SUM
       REM
*COMPARE CHECK SUM OF RECORD JUST WRITTEN AGAINST CHECK SUM
*FROM CARD READER
       REM
       CLA TSC        CARD TO STG. CHECK SUM
       SUB TSD         COMPARE CHECK SUMS
       TZE AE         OK
      #HPR            CHECK SUM ERROR
       REM            TO RESTART - RUN OUT CARDS
       REM            AND RELOAD LAST 3 CARDS
       REM            WITH REST OF DECK. THEN
       REM            PRESS START TO TRY AGAIN
       #BRBB 1
       #TRA STRTA
       REM
AE     SLT 2          TEST FOR TAPE EOF DUE TO
       REM            TWO BLANK CARDS.
       TRA STRTB      NO - CONTINUE
       REM
       WFBB 1         YES - WRITE END OF FILE AND
       SWT 5
       TRA STRTB      CONTINUE
       TRA COUNT      WRITE NEW TAPE FROM CARDS
       REM            AND TAPE
       REM
EOF    WEFB 1
       SWT 5
       TRA *+2        WRITE NEW TAPE FROM CARDS
       TRA COUNT      WRITE NEW TAPE FROM CARDS
       REM            AND TAPE
       REWB 1
       HPR -1         CARD READER EOF
       TRA *-1        PROGRAM COMPLETED
       REM
****************************************************************
       REM
*ROUTINE FOR MODIFICATION OF DIAGNOSTIC TAPE WITH SENSE SWITCH 5 ON
       REM
*RESET INDICATORS
       REM
TAPE   REWB 1
       TEFA *+1       RESET EOF INDICATOR
       TEFB *+1
       TRCA *+1       RESET REDUNDANCY INDICATOR
       TRCB *+1
       REM
       HPR            PUT TOTAL NUMBER OF FILES
       ENK            IN ADDRESS
       STQ CTR        TOTAL NUMBER OF FILES
       REM            ON TAPE
       HPR            ENTER KEY OR KEYS FOR FILE
       REM            OR FILES TO BE READ FROM
       REM            CARD READER
       REM
       REM            IF PROGRAM IS TO BE ADDED
       REM            TO TAPE. SET SIGN BIT AND
       REM            TOTAL NUMBER OF FILES ON
       REM            TAPE IN ADDRESS OF KEYS
       ENK
       XCA
       TMI C          ADD PROGRAM TO REAR OF
       REM            TAPE
       REWA 1
       REM
B1     ALS 1
       SLW T          SAVE KEY
       PBT            CHECK FOR P BIT
       TRA B2         READ FROM TAPE CHA AND
       REM            WRITE ON CHB
*
*   SKIP OVER FILE BEING REPLACED BY NEW MODIFICATION ON TAPE 1 CH A
*
       RTBA 1         DO NOT TRANSMITT
       RCHA CW1       TO STG.
       TCOA *
       TEFA *+2       TRANSFER ON EOF
       HTR START-3    NO EOF TRY AGAIN
       REM            RELOAD CARDS
       TRA START+1    READ FROM CARD READER
       REM
*READ FROM CHA TAPE 1
       REM
B2     RTBA 1         READ FROM CH A
       RCHA CWA
       TCOA *
       TEFA B9        EOF ON TAPE 1 CHA
       REM
       REM
*COMPUTE CHECK SUM FROM CH A
       REM
       AXT 24,4       COMPUTE CHECK SUM
       PXD            CLEAR ACC
       ACL TSA+24,4
       TIX *-1,4,1
       SLW TSC        STORE CHECK SUM
       REM
       TRCA B3        TRA ON TAPE CHECK
       TRA B4         OK
       REM
B3     HPR            ERROR REDUNDANCY CHECK
       BSFA 1         BACKSPACE RECORD TRY AGAIN
       REM
       TRA B2
       REM
*WRITE RECORD ON TAPE 1 CH B
       REM
B4     WTBB 1         WRITE RECORD JUST READ
       RCHB CWA
       TCOB *
       REM
       TRCB B5        ERROR ON WRITING
       TRA B6         OK
       REM
B5     HPR            REDUNDANCY ERROR TRY AGAIN
       BSRB 1
       TRA B4
       REM
B6     BSRB 1         BACKSPACE RECORD
       REM
       REM
*CHECK RECORD JUST WRITTEN
       REM
B7     RTBB 1
       RCHAB CWB
       TCOB *
       TRCB *+2       TEST FOR TAPE CHECK
       TRA B8
       HPR            REDUNDANCY ERROR BST + TRY
       REM            AGAIN
       TRA B6
       REM
* COMPUTE CHECK SUM ON RECORD JUST WRITTEN
       REM
B8     AXT 24,4       COMPUTE CHECK SUM
       PXD            CLEAR ACC.
       ACL TSB+24,4
       TIX *-1,4,1
       SLW TSD
       REM
* COMPARE CHECK SUM WRITTEN AGAINST SUM READ
       REM
       CLA TSC
       SUB TSD
       TZE B2         OK
       HPR            ERROR ON CHECK SUM
       BSRA 1         TRY READING AND WRITING
       BSRB 1         AGAIN
       TRA B2
       REM
B9     WEFB 1         WRITE EOF OF FILE ON
       REM            NEW TAPE
       REM
*REDUCE COUNTER CONTAINING NUMBER OF FILES ON TAPE
       REM
COUNT  CLA CTR        NO OF FILES
       SUB PONE       L +1
       STO CTR
       TZE REW        LAST PROG. ON TAPE
       CAL T
       TRA B1         READ NEXT FILE
       REM
REW    REWA 1
       REWB 1
       HTR 24         FINISHED NEW TAPE COMPLETED
       REM
*ROUTINE TO ADD NEW PROGRAM ON END OF TAPE
       REM
C      STA CTR
 C1    RTBB 1         DO NOT TRANSMITT TO STG.
       RCHB CW1
       TCOB *
       TEFB C2
       HTR 24         NO EOF TRY AGAIN
       REM            RELOAD CARDS
       REM
C2     CLA CTR
       SUB PONE
       STO CTR
       TZE *+2
       TRA C1
       HTR START+1    HALT TO PUT SWT 5 UP. THIS
       REM            WILL ALLOW FULL USE OF
       REM            CARD READER
       REM
PONE   OCT 1
CTR    OCT 0
CW1    IOCP 0,2,-1
       TCH *-1
CWA    IOCD TSA,0,24
CWB    IOCD TSB,0,24
TSA    BSS 24
TSB    BSS 24
TSC    BSS 1
TSD    BSS 1
T      BSS 1
       REM
       END
