                                                             9B01A
                                                             7-01-58
       REM
       REM          9B01 A
       REM
       ORG 24
       REM          TEST DATA TRANSMISSION
       REM          USING PUNCH, PRINTER
       REM          AND CARD READER
       REM
       TRA WPRA     PRINT IDENTIFICATION
       REM
 TEST  TSX IOC,4    TO ENTER I/O SELECTION
       REM
*ENTER INTO KEYS ON HALT AT 5517-EY 20 FOR CHANNEL
*A-KEY 19 FOR CHANNEL C AND KEY 18 FOR CHANNEL E,
*ALSO ENTER KEY 35 TO SPECIFY CARD READER
*KEY 34 TO SPECIFY PRINTER
*KEY 33 TO SPECIFY PUNCH
       REM
*IF CHANNELS C+D WERE SELECTED IN TAG BITS AT
*FIRST STOP SECOND STOP WILL OCCUR AT 5533
*ENTER KEYS 35,34,33 AS NEEDED FOR CHANNELS C+D.
       REM
*IF CHANNELS E+F WERE SELECTED IN TAG BITS AT
*FIRST STOP SECOND STOP WILL OCCUR AT 5540
*ENTER KEYS 35,34,33 AS NEEDED FOR CHANNELS E+F.
       REM
*IF NO TAG KEYS WERE THROWN DOWN ON FIRST HALT
*AN ADDITIONAL HALT MAY OCCUR AT 5525 TO INDICATE THIS
       REM
* SECTION 1 WILL TEST PUNCHING,PRINTING AND
* READING SHIFTING BCD RECORDS WITH SENSE SWITCH
* 5 UP
       REM
* SECTION 2 WILL TEST PUNCH AND CARD READER
* BY USING BINARY RECORDS AND READ PRINTER IS
* CHECKED BY USING SHIFTING BCD RECORDS
* WITH SENSE SWITCH 5 DOWN
       REM
       REM
       CLA ENK+2     POST RESTART TO TRANSFER
       STO 0          TO 30
       REM
       LDI CTRL1
       RNT 0,1       TEST FOR CHAN A
       TRA TCHC      NO-CHECK FOR CHAN C
       AXT TCHC,2    YES
       TRA BEG
       REM
 TCHC  LDI CTRL2
       RNT 0,2       TEST FOR CHAN C
       TRA TCHE      NO-TEST FOR CHAN E
       AXT TCHE,2    YES
       TRA CHANC
       REM
 TCHE  LDI CTRL3
       RNT 0,4       TEST FOR CHAN E.
       TRA RST1      OUT TO RESET TO CHAN A
       AXT RST1,2    YES
       TRA CHANE
       REM
 CHANC LDI CTRL2
       TRA TSX
       REM
 CHANE LDI CTRL3
       TRA TSX
       REM
 TSX   TSX CTX,4     OUT TO CONTROL
       HTR BEG,0,FINAL
       TRA BEG
       REM
 RST1  LDI RESET     RESET TO CHAN A
       STI CTRL1
       STZ CTRL2
       STZ CTRL3
       TSX CTX,4
       HTR BEG,0,FINAL
       TRA H53+3
       REM
 BEG   LXA K6,1      L+30
       CAL K5+24,1   RELOCATE RECORD
       SLW K50+24,1  IMAGE
       TIX BEG+1,1,1
       SWT 5
       TRA F19-1     UP-SECTION 1
       TRA GENRN-1   GO TO SECTION 2
       REM
       SXA COUNT,2
 F19   RNT 000004    IS CARD PUNCH ON LINE
       TRA F28A      NO
       TRA WPU-1     YES
       REM
       REM
       BCD 1WPUA
       REM
       AXT 3,1
 WPU   WPUA          PUNCH THREE CARDS
       RCHA PU       WITH NO TGRS ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR A.
       SCHA SCHA
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA      RESULTS SCH OPERATION
       LDQ ARSR      CORRECT CONTENTS DSC
       CAS ARSR
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP     DISCONNECT
       TSX ERROR-1,4 RCH COMMAND DID
       NOP *-7       NOT SET
       REM           DSC PROPERLY
       HTR WPU       RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR ONE CARD
       SCHA SCHA+1   SAVE CONTENTS OF CHANNEL
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+1    RESULTS SCH OPERATION
       LDQ ARSR+1    CORRECT CONTENTS DSC
       CAS ARSR+1
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX WPU,1,1   RETURN FOR THREE CARDS
       REM
       TSX F43,4     OUT TO RIPPLE IMAGE
       REM
 WPU1  WPUA          PUNCH THREE CARDS
       RCHA PU1      WITH S TRG ON-RIPPLE
       REM           BCD IMAGE-FIRT CHAR. B
       SCHA SCHA+2   SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+2    RESULTS SCH OPERATION
       LDQ ARSR+2    CORRECT CONTECT DSC
       CAS ARSR+2
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP+1   DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPU1      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE CARDS
       SCHA SCHA+3   SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+3    RESULT SCH OPERATION
       LDQ ARSR+3    CORRECT CONTENTS DSC
       CAS ARSR+3
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
 WPU2  WPUA          PUNCH THREE CARDS
       RCHA PU2      WITH TGR 1 ON
       REM           BCD IMAGE-FIRST CHAR C
       SCHA SCHA+4   SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+4    RESULTS SCH OPERATION
       LDQ ARSR+4    CORRECT CONTENTS DSC
       CAS ARSR+4
       TRA *+2       ERROR
       TRA *+5
       RCHA STOP+2   DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPU2      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE CARDS
       SCHA SCHA+5   SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+5    RESULTS SCH OPERATION
       LDQ ARSR+5    CORRECT CONTENTS DSC
       CAS ARSR+5
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
 WPU3  WPUA
       RCHA PU3      PUNCH THREE CARDS
       REM           WITH TGR 2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR D
       SCHA SCHA+6   SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+6    RESULTS SCH OPERATION
       LDQ ARSR+6    CORRECT CONTENTS
       CAS ARSR+6
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP+3   DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPU3      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE CARDS
       SCHA SCHA+7   SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+7    RESULTS SCH OPERATION
       LDQ ARSR+7    CORRECT CONTENTS DSC
       CAS ARSR+7
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
 WPU4  WPUA
       RCHA PU4      PUNCH THREE CARDS
       REM           WITH S+1 TGRS ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR E
       SCHA SCHA+8
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+8    RESULT SCH OPERATION
       LDQ ARSR+8    CORRECT CONTENTS DSC
       CAS ARSR+8
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP+4   DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPU4      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE CARDS
       SCHA SCHA+9   SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+9    RESULTS SCH OPERATION
       LDQ ARSR+9    CORRECT CONTENTS DSC
       CAS ARSR+9
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 2,1
 WPU5  WPUA
       RCHA PU5      PUNCH THREE CARDS
       LCHA PU5+2    WITH TGRS 1+2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR F
       SCHA SCHA+10  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+10   RESULT SCH INSTRUCTION
       LDQ ARSR+10   CORRECT CONTENTS DSC
       CAS ARSR+10
       TRA *+2       ERROR
       TRA *+5
       RCHA STOP+5   DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPU5      RETURN TO TRY AGAIN
       REM
       TIX WPU5+2,1,1 RETURN FOR THREE CARDS
       TCOA *        WAIT FOR DSC TO END OP.
       SCHA SCHA+11  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+10   RESULTS SCH OPERATION
       LDQ ARSR+10   CORRECT CONTENTS DSC
       CAS ARSR+10
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 2,1
 WPU6  WPUA
       RCHA PU6      PUNCH THREE CARDS
       LCHA PU6+2    WITH TGRS S+1 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR G
       SCHA SCHA+12  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+12   RESULT SCH OPERATION
       LDQ ARSR+12   CORRECT CONTENTS DSC
       CAS ARSR+12
       TRA *+2       ERROR
       TRA *+5
       RCHA STOP+6   DISCONNECT
       TSX ERROR-1,4 LCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPU6      RETURN TO TRY AGAIN
       REM
       TIX WPU6+2,1,1 RETURN FOR THREE CARDS
       TCOA *        WAIT FOR DSC TO END OP
       SCHA SCHA+13
       TRA *+2
       REM
       BCD 1SCHA
       CLA SCHA+13   RESULTS SCH OPERATION
       LDQ ARSR+13   CORRECT CONTENTS DSC
       CAS ARSR+13
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 2,1
 WPU7  WPUA
       RCHA PU7      PUNCH THREE CARDS
       LCHA PU7+2    WITH TGRS S,1+2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR H
       SCHA SCHA+14  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+14   RESULT SCH OPERATION
       LDQ ARSR+14   CORRECT CONTENTS DSC
       CAS ARSR+14
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP+7   DISCONNECT
       TSX ERROR-1,4 LCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPU7      RETURN TO TRY AGAIN
       REM
       TIX WPU7+2,1,1 RETURN FOR THREE CARDS
       TCOA *        WAIT FOR DSC TO END OP
       SCHA SCHA+15  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA+15   RESULTS SCH OPERATION
       LDQ ARSR+15   CORRECT CONTENTS DSC
       CAS ARSR+15
       TRA *+2
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TSX F43,4     SHIFT IMAGE
       TRA *+2       CONTINUE TO RELIABILITY
       REM           SECTION
       REM
       REM
*         TEST PUNCH-24 CARDS-BCD
       REM
       REM           PUNCH 24 RIPPLE CARDS
       BCD 1WPUA     CARD PUNCH
       REM
 F22   LXD K6,2      L+30
       IOT           TURN I/O CHECK OFF
       TRA *+1
 PUNCH WPUA
       RCHA K8       RESET LOAD CHAN A
       LCHA K8+3     S AND 1 TGR ON
       LCHA K8A+2    IND ADDRESS
       REM
       TCOA *
       TRA *+2
       REM
       BCD 1IOT      TEST I/O TGR+IND
       REM
       IOT           TEST I/O CHECK IND
       TRA *+2       ON-ERROR
       TRA *+3       OK
       TSX ERROR-1,4 I/O IND ON IN ERROR
       TXL *-4,4,0   FOR CARD PUNCH
       REM
 F24   TSX F43,4     RIPPLE CARD IMAGE
 F27   TIX PUNCH,2,1 24 CARDS HAVE BEEN PUNCHED
       REM
 F28A  RNT 000002    IS PRINTER ON LINE
       TRA F35       NO-CHECK CARD READER
       TRA WPR-5     YES-PRINT
       REM           NO ECHO CHECKING
       REM
       BCD 1WPRA
       REM
       LXA K6,1      L30
       CAL K5+24,1   INITIALIZE RECORD IMAGE
       SLW K50+24,1
       TIX *-2,1,1
       REM
       AXT 3,1
 WPR   WPRA          PRINT THREE LINES
       REM           WITH NO TGRS ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR A.
       REM
       RCHA* IND
       REM           RCH INDIRECTLY ADDRESSED
       SCHA SCHA1
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1     RESULTS SCH OPERATION
       LDQ ARSR1     CORRECT CONTENTS DSC
       CAS ARSR1
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP1    DISCONNECT
       TSX ERROR-1,4 RCH COMMAND DID
       NOP *-7       NOT SET
       REM           DSC PROPERLY
       HTR WPR       RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR ONE CARD
       SCHA SCHA1+1  SAVE CONTENTS OF CHANNEL
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+1   RESULTS SCH OPERATION
       LDQ ARSR1+1   CORRECT CONTENTS DSC
       CAS ARSR1+1
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX WPR,1,1   RETURN FOR THREE LINES
       REM
       TSX F43,4     OUT TO RIPPLE IMAGE
       REM
       AXT 1,1
 WPR1  WPRA          PRINT THREE LINES
       REM           WITH S TGR ON-RIPPLE
       REM           BCD IMAGE-FIRT CHAR. B
       RCHA* IND+2,1
       REM           RCH INDIRECTLY ADDRESSED
       REM           AND INDEXED
       SCHA SCHA1+2  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+2   RESULTS SCH OPERATION
       LDQ ARSR1+2   CORRECT CONTENTS DSC
       CAS ARSR1+2
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP1+1  DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPR1      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE LINES
       SCHA SCHA1+3  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+3   RESULTS SCH OPERATION
       LDQ ARSR1+3   CORRECT CONTENTS DSC
       CAS ARSR1+3
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
 WPR2  WPRA          PRINT THREE LINES
       RCHA PR2      WITH TGR 1 ON
       REM           BCD IMAGE-FIRST CHAR C
       SCHA* IND+5
       REM           SCH INDIRECTLY ADDRESSSED
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+4   RESULTS SCH OPERATION
       LDQ ARSR1+4   CORRECT CONTENTS DSC
       CAS ARSR1+4
       TRA *+2       ERROR
       TRA *+5
       RCHA STOP1+2  DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPR2      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE LINES
       SCHA SCHA1+5  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+5   RESULTS SCH OPERATION
       LDQ ARSR1+5   CORRECT CONTENTS DSC
       CAS ARSR1+5
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 1,1
 WPR3  WPRA
       RCHA PR3      PRINT THREE LINES
       REM           WITH TGR 2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR D
       SCHA SCHA1+6  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+6   RESULTS SCH OPERATION
       LDQ ARSR1+6   CORRECT CONTENTS
       CAS ARSR1+6
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP1+3  DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPR3      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE LINES
       SCHA* IND+7,1
       REM           SCH INDIRECTLY ADDRESSED
       REM           AND INDEXED
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+7   RESULTS SCH OPERATION
       LDQ ARSR1+7   CORRECT CONTENTS DSC
       CAS ARSR1+7
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
 WPR4  WPRA
       RCHA PR4      PRINT THREE LINES
       REM           WITH S+1 TGRS ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR E
       SCHA SCHA1+8
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+8   RESULTS SCH OPERATION
       LDQ ARSR1+8   CORRECT CONTENTS DSC
       CAS ARSR1+8
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP1+4  DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPR4      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE LINES
       SCHA SCHA1+9  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+9   RESULTS SCH OPERATION
       LDQ ARSR1+9   CORRECT CONTENTS DSC
       CAS ARSR1+9
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 3,1
 WPR5  WPRA
       RCHA PR5      PRINT THREE LINES
       LCHA PR5+2    WITH TGRS 1+2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR F
       SCHA SCHA1+10 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+10  RESULT SCH INSTRUCTION
       LDQ ARSR1+10  CORRECT CONTENTS DSC
       CAS ARSR1+10
       TRA *+2       ERROR
       TRA *+5
       RCHA STOP1+5  DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPR5      RETURN TO TRY AGAIN
       REM
       TIX WPR5+2,1,1 RETURN FOR THREE LINES
       TCOA *        WAIT FOR DSC TO END OP.
       SCHA SCHA1+11 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+11  RESULTS SCH OPERATION
       LDQ ARSR1+11  CORRECT CONTENTS DSC
       CAS ARSR1+11
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 2,1
 WPR6  WPRA
       RCHA PR6      PRINT THREE LINES
       REM           WITH TGRS S+2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR G
       LCHA* IND+2
       REM           LCH INDIRECTLY ADDRESSED
       SCHA SCHA1+12 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+12  RESULTS SCH OPERATION
       LDQ ARSR1+12  CORRECT CONTENTS DSC
       CAS ARSR1+12
       TRA *+2       ERROR
       TRA *+5
       RCHA STOP1+6  DISCONNECT
       TSX ERROR-1,4 LCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPR6      RETURN TO TRY AGAIN
       REM
       TIX WPR6+2,1,1 RETURN FOR THREE CARDS
       TCOA *        WAIT FOR DSC TO END OP
       SCHA SCHA1+13
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+13  RESULTS SCH OPERATION
       LDQ ARSR1+13  CORRECT CONTENTS DSC
       CAS ARSR1+13
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 2,1
 WPR7  WPRA
       RCHA PR7      PUNCH THREE CARDS
       REM           WITH TGRS S,1+2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR H
       LCHA* IND+5,1
       REM           LCH INDIRECTLY ADDRESSED
       REM           AND INDEXED
       SCHA SCHA1+14 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+14  RESULTS SCH OPERATION
       LDQ ARSR1+14  CORRECT CONTENTS DSC
       CAS ARSR1+14
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP1+7  DISCONNECT
       TSX ERROR-1,4 LCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR WPR7      RETURN TO TRY AGAIN
       REM
       TIX WPR7+2,1,1 RETURN FOR THREE CARDS
       TCOA *        WAIT FOR DSC TO END OP
       SCHA SCHA1+15 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA1+15  RESULTS SCH OPERATION
       LDQ ARSR1+15  CORRECT CONTENTS DSC
       CAS ARSR1+15
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TRA *+2       CONTINUE TO RELIABILITY
       REM           SECTION
       REM
       REM
*         TEST PRINTER-24 LINES-WRITE PRINTER
       REM
       BCD 1WPRA     TEST PRINTER
       REM
 F28   LXD K6,2      L+30
       IOT           TURN I/O CHECK OFF
       TRA *+1
 PRNTR WPRA
       RCHA K8       S TGR ON
       LCHA K8+3     S AND 1 TGRS ON
       LCHA K8A+2    IND ADDRESS
       TCOA *
       SCHA Z2       CHECK DSC - LOC AND ADDR
       TRA *+2
       REM
       BCD 1IOT      TEST I/O TGR+IND
       REM
       IOT           TEST I/O CHECK IND
       TRA *+2       ON-ERROR
       TRA *+3       OK
       TSX ERROR-1,4  I/O IND ON IN ERROR
       TXL *-4,4,0   FOR PRINTER
       TRA *+2       CONTINUE
       REM
       BCD 1SCHA     TEST SCHA INSTR
       REM
       CLA Z2+3      CORRECT CONTENTS
       CAS Z2        RESULTS STO CHAN OPER
       TRA *+2       ERROR
       TRA F30
       LDQ Z2        ERROR LOC AND ADDR OF
       TSX ERROR-1,4  DSC
       NOP *-6       DO NOT REPEAT
       REM
 F30   TSX F43,4     RIPPLE CARD IMAGE
       REM
       TIX PRNTR,2,1 24 PRINT RECORDS COMPLETE
       REM
 F35   RNT 1         IS CARD READER ON LINE
       TRA F50
       TRA F36
       REM
 F36   LXA K6,1      L 30
       CAL K5+24,1   INITIALIZE RECORD IMAGE
       SLW K50+24,1
       TIX F36+1,1,1
       REM
       CLA K6        L+30
       ADD K6+2      L+1
       STA WDNO      SET WORD NO CONSTANT
       CLA SVNTW
       ARS 18        SHIFT TO ADDR
       ADD K6+2      L+1
       STO RECNO     SET RECORD NO,CONSTANT
       AXT 72,2
       TRA *+2
       REM
       BCD 1RCDA
       REM
       AXT 3,1
 RCD   RCDA          READ THREE CARDS
       RCHA CR       WITH NO TGRS ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR A.
       SCHA SCHA2
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2     RESULTS SCH OPERATION
       LDQ ARSR2     CORRECT CONTENTS DSC
       CAS ARSR2
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP2    DISCONNECT
       TSX ERROR-1,4 RCH COMMAND DID
       NOP *-7       NOT SET
       REM           DSC PROPERLY
       HTR RCD       RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR ONE CARD
       SCHA SCHA2+1  SAVE CONTENTS OF CHANNEL
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+1   RESULTS SCH OPERATION
       LDQ ARSR2+1   CORRECT CONTENTS DSC
       CAS ARSR2+1
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX RCD,1,1   RETURN FOR THREE CARDS
       TIX *+1,2,2
       REM
       LXA K6,1      L 30
       CLA Q2+48,1   WORD READ
       LDQ K50+24,1  WORD GENERATED
       CAS K50+24,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RCD-1
       TIX *-7,1,1   RETURN TO TEST ALL WORDS
       TIX *+1,2,1
       REM
       TSX F43,4     OUT TO RIPPLE IMAGE
       REM
 RCD1  RCDA          READ THREE CARDS
       RCHA CR1      WITH S TGR ON-RIPPLE
       REM           BCD IMAGE-FIRT CHAR. B
       SCHA SCHA2+2  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+2   RESULTS SCH OPERATION
       LDQ ARSR2+2   CORRECT CONTENTS DSC
       CAS ARSR2+2
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP2+1  DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR RCD1      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE CARDS
       SCHA SCHA2+3  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+3   RESULTS SCH OPERATION
       LDQ ARSR2+3   CORRECT CONTENTS DSC
       CAS ARSR2+3
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX *+1,2,2
       REM
       LXA K6,1      L 30
       CLA Q2+48,1   WORD READ
       LDQ K50+24,1  WORD GENERATED
       CAS K50+24,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RCD-1
       TIX *-7,1,1   RETURN TO TEST ALL WORDS
       TIX *+1,2,1
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
 RCD2  RCDA          READ THREE CARDS
       RCHA CR2      WITH TGR 1 ON
       REM           BCD IMAGE-FIRST CHAR C
       SCHA SCHA2+4  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+4   RESULTS SCH OPERATION
       LDQ ARSR2+4   CORRECT CONTENTS DSC
       CAS ARSR2+4
       TRA *+2       ERROR
       TRA *+5
       RCHA STOP2+2  DISCONNNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR RCD2      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE CARDS
       SCHA SCHA2+5  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+5   RESULTS SCH OPERATION
       LDQ ARSR2+5   CORRECT CONTENTS DSC
       CAS ARSR2+5
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX *+1,2,2
       REM
       LXA K6,1      L 30
       CLA Q2+48,1   WORD READ
       LDQ K50+24,1  WORD GENERATED
       CAS K50+24,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RCD-1
       TIX *-7,1,1   RETURN TO TEST ALL WORDS
       TIX *+1,2,1
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
 RCD3  RCDA
       RCHA CR3      READ THREE CARDS
       REM           WITH TGR 2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR D
       SCHA SCHA2+6  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+6   RESULTS SCH OPERATION
       LDQ ARSR2+6   CORRECT CONTENTS
       CAS ARSR2+6
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP2+3  DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR RCD3      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE CARDS
       SCHA SCHA2+7  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+7   RESULTS SCH OPERATION
       LDQ ARSR2+7   CORRECT CONTENTS DSC
       CAS ARSR2+7
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX *+1,2,2
       REM
       LXA K6,1      L 30
       CLA Q2+48,1   WORD READ
       LDQ K50+24,1  WORD GENERATED
       CAS K50+24,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RCD-1
       TIX *-7,1,1   RETURN TO TEST ALL WORDS
       TIX *+1,2,1
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
 RCD4  RCDA
       RCHA CR4      READ THREE CARDS
       REM           WITH S+1 TGRS ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR E
       SCHA SCHA2+8
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+8   RESULTS SCH OPERATION
       LDQ ARSR2+8   CORRECT CONTENTS DSC
       CAS ARSR2+8
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP+4   DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR RCD4      RETURN TO TRY AGAIN
       REM
       TCOA *        WAIT FOR THREE CARDS
       SCHA SCHA2+9  SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+9   RESULTS SCH OPERATION
       LDQ ARSR2+9   CORRECT CONTENTS DSC
       CAS ARSR2+9
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX *+1,2,2
       REM
       LXA K6,1      L 30
       CLA Q2+48,1   WORD READ
       LDQ K50+24,1  WORD GENERATOR
       CAS K50+24,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RCD-1
       TIX *-7,1,1   RETURN TO TEST ALL WORDS
       TIX *+1,2,1
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 2,1
 RCD5  RCDA
       RCHA CR5      READ THREE CARDS
       LCHA CR5+2    WITH TGRS 1+2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR F
       SCHA SCHA2+10 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+10  RESULT SCH INSTRUCTION
       LDQ ARSR2+10  CORRECT CONTENTS DSC
       CAS ARSR2+10
       TRA *+2       ERROR
       TRA *+5
       RCHA STOP2+5  DISCONNECT
       TSX ERROR-1,4 RCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR RCD5      RETURN TO TRY AGAIN
       REM
       TIX RCD5+2,1,1 RETURN FOR THREE CARDS
       TCOA *        WAIT FOR DSC TO END OP,
       SCHA SCHA2+11 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+11  RESULTS SCH OPERATION
       LDQ ARSR2+11  CORRECT CONTENTS DSC
       CAS ARSR2+11
       TRA *+2       ERROR
       TRA *+5       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX *+1,2,2
       REM
       LXA K6,1      L 30
       CLA Q2+48,1   WORD READ
       LDQ K50+24,1  WORD GENERATED
       CAS K50+24,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RCD-1
       TIX *-7,1,1   RETURN TO TEST ALL WORDS
       TIX *+1,2,1
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 2,1
 RCD6  RCDA
       RCHA CR6      READ THREE CARDS
       LCHA CR6+2    WITH TGRS S+1 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR G
       SCHA SCHA2+12 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+12  RESULTS SCH OPERATION
       LDQ SCHA2+12  CORRECT CONTENTS DSC
       CAS ARSR2+12
       TRA *+2       ERROR
       TRA *+5
       RCHA STOP2+6  DISCONNECT
       TSX ERROR-1,4 LCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR RCD6      RETURN TO TRY AGAIN
       REM
       TIX RCD6+2,1,1 RETURN FOR THREE CARDS
       TCOA *        WAIT FOR DSC TO END OP
       SCHA SCHA2+13
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+13  RESULTS SCH OPERATION
       LDQ ARSR2+13  CORRECT CONTENTS DSC
       CAS ARSR2+13
       TRA *+2       ERROR
       TRA *+5
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX *+1,2,2
       REM
       LXA K6,1      L 30
       CLA Q2+48,1   WORD READ
       LDQ K50+24,1  WORD GENERATED
       CAS K50+24,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RCD-1
       TIX *-7,1,1   RETURN TO TEST ALL WORDS
       TIX *+1,2,1
       REM
       TSX F43,4     OUT TO SHIFT IMAGE
       REM
       AXT 2,1
 RCD7  RCDA
       RCHA CR7      READ THREE CARDS
       LCHA CR7+2    WITH TGRS S,1+2 ON-RIPPLE
       REM           BCD IMAGE-FIRST CHAR H
       SCHA SCHA2+14 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+14  RESULTS SCH OPERATION
       LDQ ARSR2+14  CORRECT CONTENTS DSC
       CAS ARSR2+14
       TRA *+2       ERROR
       TRA *+5       OK
       RCHA STOP2+7  DISCONNECT
       TSX ERROR-1,4 LCH COMMAND
       NOP *-7       DID NOT SET
       REM           DSC PROPERLY
       HTR RCD7      RETURN TO TRY AGAIN
       REM
       TIX RCD7+2,1,1 RETURN FOR THREE CARDS
       TCOA *        WAIT FOR DSC TO END OF
       SCHA SCHA2+15 SAVE CONTENTS DSC
       TRA *+2
       REM
       BCD 1SCHA
       REM
       CLA SCHA2+15  RESULTS SCH OPERATION
       LDQ ARSR2+15  CORRECT CONTENTS DSC
       CAS ARSR2+15
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP *-6
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2       INDICATOR ON-ERROR
       TRA *+3       OFF-OK
       TSX ERROR-1,4
       TXL *-4,4
       TIX *+1,2,2
       REM
       LXA K6,1      L 30
       CLA Q2+48,1   WORD READ
       LDQ K50+24,1  WORD GENERATED
       CAS K50+24,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP RCD-1
       TIX *-7,1,1   RETURN TO TEST ALL WORDS
       TIX *+1,2,1
       TSX F43,4     SHIFT IMAGE
       TRA *+2       CONTINUE TO RELIABILITY
       REM           SECTION
       REM
       REM
*         TEST CARD READER-24 CARDS-BCD
       REM
       BCD 1RCDA     TEST CARD READER CHAN-A
       REM
       REM
 F38   IOT           TURN OFF I/O CHECK
       TRA *+1
       REM
 CRDR  RCDA
       RCHA K9       DSC NOT IN OPERATION
       LCHA K9+5
       LCHA K9+7
       TCOA *
       SCHA Z2       CHECK DSC LOC AND ADDR
       TRA *+2
       REM
       BCD 1IOT      TEST I/O TGR+IND
       REM
       IOT           TEST I/O CHECK IND
       TRA *+2       ON-ERROR
       TRA *+3       OK
       REM
       TSX ERROR-1,4 I/O IND ON IN ERROR
       TXL *-4,4,0   FOR CARD READER
       TRA *+2
       REM
       BCD 1SCHA     TEST SCHA INSTR
       REM
       CLA Z2        RESULTS SCH OPERATION
       CAS Z2+2
       TRA *+2       ERROR
       TRA *+4       OK-CORRECT LOC AND ADDR
       LDQ Z2+2      CORRECT CONTENTS DSC
       TSX ERROR-1,4
       NOP *-6
       REM           COMPARE CARD IMAGE WITH
       REM           IMAGE IN STORAGE
       REM
       REM
 F39   LXA K6,1      L 30
       CLA K50+48,1  WORD READ
       LDQ K50+24,1  WORD GENERATED
       CAS K50+24,1
       TRA F41-2     ERROR
       TRA F41       OK
       TSX ERROR-2,4 COMPARISON ERROR
       NOP F38
       REM
 F41   TIX F39+1,1,1 DECREMENT WORD NUMBER
       TSX F43,4     R
 F40   LXA K12+7,4   L 14
       STZ K50+36,4   SET ZEROS IN 1ST 12
       TIX *-1,4,1   WORDS OF READ IN AREA
       TIX *+1,2,1   DECREMENT RECORD NUMBER
       REM
       IOT           TURN I/O CHECK OFF
       TRA *+1
       REM
       REM
*         TEST CARD READER USING TGR 19
       REM
       REM           READ CARD WITH BIT
       RCDA          IN 19 OF CONTROL WORD
       RCHA K13
       LCHA K13+2    SHOULD NOT READ IN 1ST 12
       TCOA *        WORDS
       SCHA Z2
       TRA *+2       CONTINUE
       REM
       BCD 1IOT      TEST I/O TGR+IND
       REM
       IOT           TEST I/O CHECK IND
       TRA *+2       ON-ERROR
       TRA *+3       OK
       TSX ERROR-1,4 I/O IND ON IN ERROR
       TXL *-4,4,0   FOR CARD READER
       TRA *+2
       REM
       BCD 1SCHA     TEST STO CHAN INSTR
       REM
       CLA Z2        RESULTS SCH OPERATION
       CAS K13+5
       TRA *+2       ERROR IN CHAN CONTENTS
       TRA *+4
       LDQ K13+5     CORRECT CONTENTS DSC
       TSX ERROR-1,4
       NOP *-6       DO NOT REPEAT
       REM
       REM
       CLA K12+1     L+14
       ADD K6+2      L+1
       STO WDNO      SET WORD NO CONSTANT
       LXA K12+1,1   L 14
       CLA K50+36,1  WORD READ
       CAS K12+2
       TRA *+2
       TRA *+4       OK
       LDQ K12+2     WORD GENERATED
       REM
*  ERROR USING TGR 19 OF CONTROL WORD
       REM
       TSX ERROR-2,4 1ST 12 WORDS OF STORAGE
       TRA F38
       TIX *-7,1,1
       REM
       CLA K6        L+30
       ADD K6+2      L+1
       STA WDNO      WORD NUMBER
       REM
       LXA K12+1,1   L 14
       CLA K50+48,1  WORD READ
       CAS K50+24,1
       TRA *+2       ERROR
       TRA *+4       OK
       LDQ K50+24,1  WORD GENERATED
       TSX ERROR-2,4
       TRA F38
       TIX *-7,1,1
       REM
       TSX F43,4
       TIX CRDR,2,1  24 CARDS HAVE BEEN READ
       REM
       TRA F50
       REM
       REM           RIPPLE STORAGE IMAGE
 F43   LXA K6,1      L 30
       CAL K50+24,1
       LDQ K50+25,1
       PBT
       TRA F44
       TRA F45
 F44   LGL 1
       SLW K50+24,1
       LGL 36
       SLW K50+25,1
       TIX F43+1,1,2
       TRA F46
 F45   LGL 1
       SLW K50+24,1
       LGL 36
       ADD K6+2      L +1
       TRA F44+3
 F46   TRA 1,4
       REM
       REM
*         TEST FOR SECOND SECTION-BINARY RECS
       REM
 F50   SWT 5         TEST SWITCH 5
       TRA CHECK     UP-CHECK TO SEE IF ALL DSCS
       REM           SELECTED HAVE BEEN TESTED
       TRA GENRN-1   DOWN-CONTINUE WITH RAND.
       REM           NOS.
       REM
       SXA COUNT,2
 GENRN LXA K12+3,2   L+60
       CAL K17
       ADM K17
       SLW Q1+61,2   FORM RANDOM NUMBERS
       TIX GENRN+2,2,1
       REM
       REM
 GEN1  LXA K12+3,2   L+60
       CAL Q1+61,2
       LXA K12+4,1   L+0030
       ADM Q1+61,2
       SLW Q2+24,1   FORM RECORD IMAGE
       TIX GEN1+3,1,1
       REM
       RNT 4         IS PUNCH TO BE TESTED
       TRA G9        NO-LOOK FOR NEXT UNIT-CR
       TRA G7        YES
       REM
       REM
*         TEST PUNCHING BINARY RECORDS-60 CARDS
       REM
       BCD 1WPUA     TEST PUNCHING BINARY RECORDS
       REM
 G7    TCNA G7+2     IS DSC A IN OPN-NO
       TRA G7        YES
       IOT           TURN I/O CHECK OFF
       TRA *+1
       WPUA          PUNCH BINARY RECORDS
       REM
       RCHA K18      S TGR ON PUNCH 9L+9R
       LCHA K18+3    S AND 1 TGRS,6+5 ROWS
       LCHA K18A+2   IND ADDR
       TCOA *
       TRA *+2
       REM
       BCD 1IOT      TEST I/O TGR+IND
       REM
       IOT           TEST I/O CHECK IND
       TRA *+2       ON-ERROR
       TRA *+3       OK
       TSX ERROR-1,4 I/O IND ON IN ERROR
       TXL *-4,4,0   FOR CARD PUNCH
       REM
       REM           CHECK CTRL WORD FOR CR
       REM           IS CARD READER TO BE
       REM           TESTED
 G9    RNT 1         RT HALF INDS ON TEST
       TRA G15-1     NO CHECK FOR READ PRINTER
       TRA G11       YES
       REM
       REM
*         TEST READING BINARY RECORDS-60 CARDS
       REM
       BCD 1RCDA     TEST READING BINARY RECORDS
       REM           FROM CARD READER
 G11   TCNA G11+2    IS CHAN A IN OPER-NO
       TRA G11       YES
       IOT           TURN I/O CHECK OFF
       TRA *+1
       REM
       CLA K12+4     L+30
       ADD K6+2      L+1
       STO WDNO      SET WORD NO CONSTANT
       CLA K12+3     L+60
       ADD K6+2      L+1
       STO RECNO     SET REC NO CONSTANT
       REM
       RCDA
       RCHA K20      IND ADDR
       REM
       LCHA K21      S AND 2 TGRS ON
       REM
       LCHA K21+2    S TGR ON READ 5L
       REM
       LCHA K22      S TGR ON-READ 2L-1R
       REM
       TCNA *+2      HAS LAST WORD BEEN READ
       TRA *-1       NO
       SCHA Z2       TEST STORE CHAN INST
       TRA *+2       CONTINUE
       REM
       BCD 1IOT      TEST I/O TGR+IND
       REM
       IOT           TEST I/O CHECK IND
       TRA *+2       ON-ERROR
       TRA *+3       OK
       TSX ERROR-1,4 I/O IND ON IN ERROR
       TXL *-4,4,0   FOR CARD READER
       TRA *+2       CONTINUE
       REM
       BCD 1SCHA     TEST STO CHAN INSTR
       REM
       CLA Z2        RESULTS SCH OPERATION
       CAS Z2+1
       TRA *+2       ERROR IN CHAN CONTENTS
       TRA *+4       OK
       LDQ Z2+1      CORRECT CONTENTS DSC
       TSX ERROR-1,4
       NOP *-6       DO NOT REPEAT
       REM
       REM
 G13   LXA K12+4,1   L0030
       CLA Q2+48,1   WORD READ
       LDQ Q2+24,1   WORD GENERATED
       CAS Q2+24,1
       TRA G14       ERROR
       TRA *+3       OK
       REM
 G14   TSX ERROR-2,4 GO TO ERROR ROUTINE
       NOP G11
       TIX G13+1,1,1
       REM
       REM
       REM           IS PRINTER TO BE TESTED
       REM
       SXD XRAB+1,2   SAVE XRB
 G15   RNT 2         RT-HALF IND ON TEST
       TRA H40
       TRA F34
       REM
       REM
*         TEST READ PRINTER-BCD RECORDS
*         SHIFTING PRINT IMAGE
       REM
       REM
       BCD 1RPRA     TEST READ PRINTER
 F34   NOP
       IOT           TURN I/O CHECK OFF
       TRA *+1
       RPRA          READ PRINTER USING
       REM           RIPPLE BCD RECORDS
       REM
       RCHA K19      S + 1 TGRS ON-9-2 ROWS
       LCHA K19+2    S TGR ON
       LCHA K19B     S TGR ON
       TCOA *
       SCHA Z2
       TRA *+2       CONTINUE
       REM
       BCD 1IOT      TEST I/O TGR+IND
       REM
       IOT           TEST I/O CHECK IND
       TRA *+2       ON-ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       TXL *-4,4,0
       TRA *+2       CONTINUE
       REM
       BCD 1SCHA     TEST STO CHAN INSTR
       REM
       CLA Z2        RESULTS SCH OPERATION
       CAS K19B+3
       TRA *+2       CHAN ERROR
       TRA *+4       OK
       LDQ K19B+3    CORRECT CONTENTS DSC
       TSX ERROR-1,4
 FINAL NOP *-6       DO NOT REPEAT
       REM           CHECK ECHO IMAGE
       CAL K50+47
       ACL K50+27    8 ROW RIGHT
       SLW K50+27
       REM
       CAL K50+46    8 ROW LEFT
       ACL K50+26
       SLW K50+26
       REM
       CAL K50+45
       ACL K50+27
       SLW K50+27
       REM
       CAL K50+44
       ACL K50+26
       SLW K50+26
       REM
       CAL K50+47
       ACL K50+37
       SLW K50+37
       REM
       CAL K50+46
       ACL K50+36
       SLW K50+36
       REM
       CAL K50+45    4 ROW RIGHT
       ACL K50+35
       SLW K50+35
       REM
       CAL K50+44    4 ROW LEFT
       ACL K50+34
       SLW K50+34
       REM
       CLA K26       L+22
       ADD K6+2      L+1
       STA WDNO      WORD NUMBER
       LXA K26,1      L 22
       CLA K50+42,1  WORD READ
       LDQ K50+18,1  WORD GENERATED
       CAS K50+18,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4  ERROR IN ECHO CHECKING
       TRA F34       PRINTER
       TIX *-7,1,1
       TSX F43,4
       REM
       REM
 H40   LXA K12+4,1   L+30
       LXD XRAB+1,2
       CAL Q1+61,2
       ADM Q1+61,2
       SLW Q2+24,1
       TIX H40+3,1,1
 H54   TIX G7-4,2,1
       REM
 CHECK CLA COUNT
       STA *+1
       TRA
       REM
 H53   SWT 6         TEST SWITCH 6
       TRA NEXT
       TRA TEST      DOWN-REPEAT
       REM
       SWT 3
       TRA PASS
       TRA H53       TEST SW6
       REM
 NEXT  RCDA
       RCHA *+3
       LCHA 0
       TRA 1
       MON 0,0,3     CONTROL-READ CARD
       REM
 PASS  WPRA          PRINT PASS COMPLETE
       SPRA 3
       RCHA PASS1
       TRA H53       TEST SW6
 PASS1 IOCD PASSC,0,24
       REM
       REM
 WPRA  SWT 3         TEST FOR PRINTER
       TRA *+2
       TRA TEST
       REM
       WPRA
       SPRA 3
       RCHA *+2
       TRA TEST
       REM
       IOCD PRINT,0,24
       REM
 PRINT OCT 450          9L
       OCT 100004000000 9R
       OCT 0            8L
       OCT 0            8R
       OCT 2002         7L
       OCT 0            7R
       OCT 30300        6L
       OCT 60000000     6R
       OCT 41004        5L
       OCT 10400000     5R
       OCT 20           4L
       OCT 100000000    4R
       OCT 0            3L
       OCT 1100000      3R
       OCT 0            2L
       OCT 40200200000  2R
       OCT 0            1L
       OCT 14000000000  1R
       OCT 10000        0L
       OCT 20101300000  0R
       OCT 62564        11L
       OCT 401004000000 11R
       OCT 1212         12L
       OCT 44270400000  12R
       REM
* PRINT -            9B01-PASS COMPLETE
* IMAGE -            9B01-PASS COMPLETE
 PASSC OCT 000002000000  9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000000000000  8 L
       OCT 000000000000  8 R
       OCT 000000040100  7 L
       OCT 000000000000  7 R
       OCT 000000000400  6 L
       OCT 000000000000  6 R
       OCT 000000000024  5 L
       OCT 000000000000  5 R
       OCT 000000000200  4 L
       OCT 000000000000  4 R
       OCT 000000001050  3 L
       OCT 000000000000  3 R
       OCT 000001014000  2 L
       OCT 000000000000  2 R
       OCT 000000220000  1 L
       OCT 000000000000  1 R
       OCT 000000414010  0 L
       OCT 000000000000  0 R
       OCT 000000140740  11 L
       OCT 000000000000  11 R
       OCT 000001021024  12 L
       OCT 000000000000  12 R
       REM
 RESET HTR 7,1
       REM
       REM
*CONTENTS OF DSC IF ERROR HALT OCCURS, DSC ADDRESS
*WILL CONTAIN ADDRESS OF RESET CHANNEL WHICH
*DISCONNECTED THE DSC, WHILE PUNCHING
       REM
 STOP  IOCD WPU+10,0,0 ERROR WITH ALL TGRS OFF
       IOCD WPU1+10,0,0 ERROR WITH S TGR ON
       IOCD WPU2+10,0,0 ERROR WITH TGR 1 ON
       IOCD WPU3+10,0,0 ERROR WITH TGR 2 ON
       IOCD WPU4+10,0,0 ERROR WITH S+1 TGRS ON
       IOCD WPU5+11,0,0 ERROR WITH 1+2 TGRS ON
       IOCD WPU6+11,0,0 ERROR WITH S+2 TGRS ON
       IOCD WPU7+11,0,0 ERROR WITH ALL TGRS ON
       REM
       REM
*CONTENTS OF DSC IF ERROR HALT OCCURS. DSC ADDRESS
*WILL CONTAIN ADDRESS OF RESET CHANNEL WHICH
*DISCONNECTED THE DSC, WHILE PRINTING.
       REM
 STOP1 IOCD WPR+10,0,0 ERROR WITH ALL TGRS OFF
       IOCD WPR1+10,0,0 ERROR WITH S TGR ON
       IOCD WPR2+10,0,0 ERROR WITH TGR 1 ON
       IOCD WPR3+10,0,0 ERROR WITH TGR 2 ON
       IOCD WPR4+10,0,0 ERROR WITH S+1 TGRS ON
       IOCD WPR5+11,0,0 ERROR WITH 1+2 TGRS ON
       IOCD WPR6+11,0,0 ERROR WITH S+2 TGRS ON
       IOCD WPR7+11,0,0 ERROR WITH ALL TGRS ON
       REM
       REM
*CONTENTS OF DSC IF ERROR HALT OCCURS. DSC ADDRESS
*WILL CONTAIN ADDRESS OF RESET CHANNEL WHICH
*DISCONNECTED THE DSC, DURING READING.
       REM
 STOP2 IOCD RCD+10,0,0 ERROR WITH ALL TGRS OFF
       IOCD RCD1+10,0,0 ERROR WITH S TGR ON
       IOCD RCD2+10,0,0 ERROR WITH TGR 1 ON
       IOCD RCD3+10,0,0 ERROR WITH TGR 2 ON
       IOCD RCD4+10,0,0 ERROR WITH S+1 TGRS ON
       IOCD RCD5+11,0,0 ERROR WITH 1+2 TGRS ON
       IOCD RCD6+11,0,0 ERROR WITH S+2 TGRS ON
       IOCD RCD7+11,0,0 ERROR WITH ALL TGRS ON
       REM
       REM
 ARSR  IOCD K50+1,0,PU+1 CORRECT CONTENTS DSC
       REM               FIRST
       IOCD K50+24,0,PU+1 GROUP OF THREE CARDS
       REM           PUNCHED.
       REM
       IOCP K50+1,0,PU1+1 CORRECT CONTENTS DSC
       REM                SECOND
       IOCD PU1+3,0,PU1+4 GROUP OF THREE CARDS
       REM           PUNCHED.
       REM
       IORP K50+1,0,PU2+1 CORRECT CONTENTS DSC
       REM                THIRD
       IOCD PU2+3,0,PU2+4 GROUP OF THREE CARDS
       REM           PUNCHED.
       REM
       IOCP K50+1,0,PU3+3 CORRECT CONTENTS DSC
       REM                FOURTH
       IOCD K50+24,0,PU3+9 GROUP OF THREE CARDS
       REM           PUNCHED.
       REM
       IOSP K50+1,0,PU4+1 CORRECT CONTENTS DSC
       REM                FIFTH
       IOCD PU4+4,0,PU4+5 GROUP OF THREE CARDS
       REM           PUNCHED.
       REM
       IORT K50+1,0,PU5+3 CORRECT CONTENTS DSC
       REM                SIXTH
       IORT K50+24,0,PU5+3 GROUP OF THREE CARDS
       REM           PUNCHED.
       REM
       IOCT K50+1,0,PU6+3 CORRECT CONTENTS DSC
       IOCT K50+24,0,PU6+3 SEVENTH GROUP OF THREE
       REM           CARDS PUNCHED
       REM
       IOST K50+1,0,PU7+3 CORRECT CONTENTS DSC
       IOST K50+24,0,PU7+3 EIGHT GROUP OF THREE
       REM           CARDS PUNCHED.
       REM
       REM
 ARSR1 IOCD K50+1,0,PR+1    CORRECT CONTENTS DSC
       REM               FIRST
       IOCD K50+24,0,PR+1 GROUP OF THREE LINES
       REM           PRINTED.
       REM
       IOCP K50+1,0,PR1+1 CORRECT CONTENTS DSC
       REM                SECOND
       IOCD PR1+3,0,PR1+4 GROUP OF THREE LINES
       REM           PRINTED.
       REM
       IORP K50+1,0,PR2+1 CORRECT CONTENTS DSC
       REM                THIRD
       IOCD PR2+3,0,PR2+4 GROUP OF THREE LINES
       REM           PRINTED.
       REM
       IOCP K50+1,0,PR3+3 CORRECT CONTENTS DSC
       REM                FOURTH
       IOCD K50+24,0,PR3+9 GROUP OF THREE LINES
       REM            PRINTED.
       REM
       IOSP K50+1,0,PR4+1 CORRECT CONTENTS DSC
       REM                FIFTH
       IOCD PR4+4,0,PR4+5 GROUP OF THREE LINES
       REM           PRINTED.
       REM
       IORT K50+1,0,PR5+3 CORRECT CONTENTS DSC
       REM                SIXTH
       IORT K50+24,0,PR5+3 GROUP OF THREE LINES
       REM           PRINTED.
       REM
       IOCT K50+1,0,PR6+3 CORRECT CONTENTS DSC
       IOCT K50+24,0,PR6+3 SEVENTH GROUP OF THREE
       REM           LINES PRINTED.
       REM
       IOST K50+1,0,PR7+3 CORRECT CONTENTS DSC
       IOST K50+24,0,PR7+3 EIGTH GROUP OF THREE
       REM           LINES PRINTED.
       REM
       REM
 ARSR2 IOCD Q2+24,0,CR+1 CORRECT CONTENTS DSC
       REM               FIRST
       IOCD Q2+48,0,CR+1 GROUP OF THREE CARDS
       REM               READ.
       REM
       IOCP Q2+24,0,CR1+1 CORRECT CONTENTS DSC
       REM                SECOND
       IOCD CR1+3,0,CR1+4 GROUP OF THREE CARDS
       REM           READ.
       REM
       IORP Q2+24,0,CR2+1 CORRECT CONTENTS DSC
       REM                THIRD
       IOCD CR2+3,0,CR2+4 GROUP OF THREE CARDS
       REM           READ.
       REM
       IOCP Q2+24,0,CR3+3 CORRRECT CONTENTS DSC
       REM                FOURTH
       IOCD Q2+48,0,CR3+9 GROUP OF THREE CARDS
       REM                READ.
       REM
       IOSP Q2+24,0,CR4+1 CORRECT CONTENTS DSC
       REM                FIFTH
       IOCD CR4+4,0,CR4+5 GROUP FO THREE CARDS
       REM            READ.
       REM
       IORT Q2+24,0,CR5+3 CORRECT CONTENTS DSC
       REM                SIXTH
       IORT Q2+48,0,CR5+3 GROUP OF THREE CARDS
       REM                READ.
       REM
       IOCT Q2+24,0,CR6+3 CORRECT CONTENTS DSC
       IOCT Q2+48,0,CR6+3 SEVENTH GROUP OF THREE
       REM            CARDS READ.
       REM
       IOST Q2+24,0,CR7+3 CORRECT CONTENTS DSC
       IOST Q2+48,0,CR7+3 EIGHT GROUP OF THREE
       REM                CARDS READ.
       REM
       REM
       REM
*COMMAND TO PUNCH THREE BCD CARDS-NO TGRS ON
       REM
 PU    IOCD K50,0,24  NO TGRS ON-FIRST CHAR A
       REM
*COMMANDS TO PUNCH THREE CARDS-S TGR ON-BCD IMAGE
       REM
 PU1   IOCP K50,0,24 S TGR ON-FIRST CHAR B
       IOCP K50,0,24
       IOCP K50,0,24 SHOULD DISCONNECT WITH
       IOCD *,0,0    ADDRESS REGISTER THIS ADDR.
       REM
*COMMANDS TO PUNCH THREE BCD CARDS- TGR 1 ON
       REM
 PU2   IORP K50,0,24 TGR 1 ON-EOR TGR
       REM           FIRST CHAR C
       IORP K50,0,25 WORD COUNT GREATER THEN
       IORP K50,0,60 EOR. SHOULD NOT PUNCH MORE
       IOCD *,0,0    THAN ONE CARD FOR EACH
       REM           COMMAND.
       REM
*COMMANDS TO PUNCH THREE BCD CARDS-TGR 2 ON
       REM
       REM           FIRST CHARACTER D
 PU3   TCH *+2,0,0   TGR 2 ON-SHOULD GO TO OWN
       REM           ADDRESS FOR FIRST COMMAND.
       IOCD *,0,0    IF INDIRECT ADDRESS TGR
       IOCP K50,0,24 NOT WORKING, THE
       TCH *+2,0,0   ADDRESS OF WORD
       IOCD *,0,0    RECIEVED BY THE DSC
       IOCP K50,0,24 WILL APPEAR IN THE
       TCH *+2,0,0   ADDRESS REGISTER.
       IOCD *,0,0
       IOCD K50,0,24 SHOULD DISCONNECT HERE
       REM           AFTER WC GOES TO ZERO.
       REM
*COMMANDS TO PUNCH THREE BCD CARDS-TGRS S+1 ON
       REM
 PU4   IOSP K50,0,24 TGRS S+1 ON-FIRST CHAR E
       REM           THESE TGRS SHOULD PICK UP
       IOSP K50,0,12 NEXT FOLLOWING COMMAND ON
       REM           WHEN WC GOES TO ZERO
       IOSP K50+12,0,12
       IOSP K50,0,24
       IOCD *,0,0    ON DISCONNECT, ADDRESS
       REM           REGISTER SHOULD CONTAIN
       REM           ADDRESS OF THIS COMMAND.
       REM
*COMMANDS TO PUNCH THREE BCD CARDS-TGRS 1+2 ON
       REM
 PU5   IORT K50,0,0  TGRS 1+2 ON-FIRST CHAR F
       REM           FIRST IORT COMMAND SHOULD
       IOCD *,0,0    NOT PUNCH. IT IS A DUMMY
       REM           TO GET DSC SET FOR LCH
       REM           INSTR. SHOULD GET CONTROL
       REM           WORD FROM LCH INSTR. IN
       REM           MAIN PROGRAM AT EOR
       IORT K50,0,40 REGARDLESS OF WORD COUNT.
       IOCD *,0,0    IF THIS COMMAND IS PICKED
       REM           UP AT EOR, ADDRESS REGISTER
       REM           WILL CONTAIN ADDRESS OF
       REM           COMMAND RECEIVED BY DSC
       REM
*COMMANDS TO PUNCH THREE BCD CARDS-TGRS S+2 ON
       REM
 PU6   IOCT K50,0,24 TGRS S+2 ON-FIRST CHAR G
       IOCD *,0,0
       REM           SHOULD GET
       REM           COMMAND FROM LCD
       REM           INSTR. IN MAIN PROGRAM
       IOCT K50,0,24 WHEN WC GOES TO ZERO.
       IOCD *,0,0    IF THIS COMMAND IS
       REM           PICKED UP, THE DSC ADDRESS
       REM           REGISTER WILL CONTAIN
       REM           ADDRESS OF COMMAND
       REM           RECEIVED BY THE DSC
       REM
*COMMANDS TO PUNCH THREE BCD CARDS-S, 1+2 TGRS ON
       REM
 PU7   IOST K50,0,24 TGRS S,1+2 ON FIRST CHAR H
       IOCD *,0,0
       IOST K50,0,24 SHOULD GET THIS
       REM           COMMAND FROM LCH
       IOCD *,0,0    INSTR. IN MAIN PROGRAM
       REM           WHEN WORD COUNT GOES TO 0
       REM
       REM
*COMMAND TO PRINT THREE LINES-NO TGRS ON
       REM
 PR    IOCD K50,0,24 NO TGRS ON-FIRST CHAR A
       REM
*COMMANDS TO PRINT THREE LINES-S TGR ON-BCD IMAGE
       REM
 PR1   IOCP K50,0,24 S TGR ON-FIRST CHAR B
       IOCP K50,0,24
       IOCP K50,0,24 SHOULD DISCONNECT WITH
       IOCD *,0,0    ADDRESS REGISTER THIS ADDR.
       REM
*COMMANDS TO PRINT THREE LINES- TGR 1 ON
       REM
 PR2   IORP K50,0,24 TGR 1 ON-EOR TGR
       REM           FIRST CHAR C
       IORP K50,0,25 WORD COUNT GREATER THEN
       IORP K50,0,60 EOR. SHOULD NOT PUNCH MORE
       IOCD *,0,0    THAN ONE CARD FOR EACH
       REM           COMMAND.
       REM
*COMMANDS TO PRINT THREE LINES-TGR 2 ON
       REM           FIRST CHARACTER D
       REM
 PR3   TCH *+2,0,0   TGR 2 ON-SHOULD GO TO OWN
       REM           ADDRESS FOR FIRST COMMAND.
       IOCD *,0,0    IF INDIRECT ADDRESS TGR
       IOCP K50,0,24 NOT WORKING, THE
       TCH *+2,0,0   ADDRESS OF WORD
       IOCD *,0,0    RECEIVED BY THE DSC
       IOCP K50,0,24 WILL APPEAR IN THE
       TCH *+2,0,0   ADDRESS REGISTER.
       IOCD *,0,0
       IOCD K50,0,24 SHOULD DISCONNECT HERE
       REM           AFTER WC GOES TO ZERO.
       REM
*COMMANDS TO PRINT THREE LINES-TGRS S+1 ON
 PR4   IOSP K50,0,24 TGRS S+1 ON-FIRST CHAR R
       REM           THESE TGRS SHOULD PICK UP
       IOSP K50,0,12 NEXT FOLLOWING COMMAND
       REM           WHEN WC GOES TO ZERO
       IOSP K50+12,0,12
       IOSP K50,0,24
       IOCD *,0,0    ON DISCONNECT, ADDRESS
       REM           REGISTER SHOULD CONTAIN
       REM           ADDRESS OF THIS COMMAND.
       REM
*COMMANDS TO PRINT THREE LINES-TGRS 1+2 ON
       REM
 PR5   IORT K50,0,0  TGRS 1+2 ON-FIRST CHAR F
       REM           FIRST IORT COMMAND SHOULD
       IOCD *,0,0    NOT PUNCH. IT IS A DUMMY
       REM           TO GET DSC SET FOR LCH
       REM           INSTR. SHOULD GET CONTROL
       REM           WORD FROM LCH INSTR. IN
       REM           MAIN PROGRAM AT EOR
       IORT K50,0,24 REGARDLESS OF WORD COUNT.
       IOCD *,0,0    IF THIS COMMAND IS PICKED
       REM           UP AT EOR, ADDRESS REGISTER
       REM           WILL CONTAIN ADDRESS OF
       REM           COMMAND RECEIVED BY DSC
       REM
*COMMANDS TO PRINT THREE LINES-TGRS S+2 ON
       REM
 PR6   IOCT K50,0,24 TGRS S+2 ON-FIRST CHAR G
       IOCD *,0,0
       REM           SHOULD GET
       REM           COMMAND FROM LCD
       REM           INSTR. IN MAIN PROGRAM
       IOCT K50,0,24 WHEN WC GOES TO ZERO.
       IOCD *,0,0    IF THIS COMMAND IS
       REM           PICKED UP, THE DSC ADDRESS
       REM           REGISTER WILL CONTAIN
       REM           ADDRESS OF COMMAND
       REM           RECEIVED BY THE DSC
       REM
*COMMANDS TO PRINT THREE LINES-S, 1+2 TGRS ON
       REM
 PR7   IOST K50,0,24 TGRS S, 1+2 ON-FIRST CHAR H
       IOCD *,0,0
       IOST K50,0,24 SHOULD GET THIS
       REM           COMMAND FROM LCH
       IOCD *,0,0    INSTR. IN MAIN PROGRAM
       REM           AT EOR, OR WHEN WC GOES
       REM           TO ZERO, WHICHEVER
       REM           COMES FIRST.
       REM
       REM
       REM
*COMMANDS TO READ THREE BCD CARDS-NO TGRS ON
       REM
 CR    IOCD Q2+24,0,24 NO TGRS ON-FIRST CHAR A
       REM
*COMMANDS TO READ THREE CARDS-S TGR ON-BCD IMAGE
       REM
 CR1   IOCP Q2+24,0,24 S TGR ON-FIRST CHAR B
       IOCP Q2+24,0,24
       IOCP Q2+24,0,24 SHOULD DISCONNECT WITH
       IOCD *,0,0    ADDRESS REGISTER THIS ADDR.
       REM
*COMMANDS TO READ THREE BCD CARDS- TGR 1 ON
       REM
 CR2   IORP Q2+24,0,24 TGR 1 ON-EOR TGR
       REM           FIRST CHAR C
       IORP Q2+24,0,25 WORD COUNT GREATER THEN
       IORP Q2+24,0,60 EOR. SHOULD NOT PUNCH MORE
       IOCD *,0,0    THAN ONE CARD FOR EACH
       REM           COMMAND.
       REM
*COMMANDS TO READ THREE BCD CARDS-TGR 2 ON
       REM           FIRST CHARACTER D
       REM
 CR3   TCH *+2,0,0   TGR 2 ON-SHOULD GO TO OWN
       REM           ADDRESS FOR FIRST COMMAND.
       IOCD *,0,0    IF INDIRECT ADDRESS TGR
       IOCP Q2+24,0,24 NOT WORKING, THE
       TCH *+2,0,0   ADDRESS OF WORD
       IOCD *,0,0    RECEIVED BY THE DSC
       IOCP Q2+24,0,24 WILL APPEAR IN THE
       TCH *+2,0,0   ADDRESS REGISTER.
       IOCD *,0,0
       IOCD Q2+24,0,24 SHOULD DISCONNECT HERE
       IOCD *,0,0    AFTER WC GOES TO ZERO.
       REM
*COMMANDS TO READ THREE BCD CARDS-TGRS S+1 ON
       REM
 CR4   IOSP Q2+24,0,25 TGRS S+1 ON-FIRST CHAR E
       REM           THESE TGRS SHOULD PICK UP
       IOSP Q2+24,0,12 NEXT FOLLOWING COMMAND ON
       REM           EOR, OR WHEN WC GOES TO
       REM           ZERO.
       IOSP Q2+36,0,24 WHICHEVER COMES FIRST
       IOSP Q2+24,0,60
       IOCD *,0,0    ON DISCONNECT, ADDRESS
       REM           REGISTER SHOULD CONTAIN
       REM           ADDRESS OF THIS COMMAND.
       REM
*COMMANDS TO READ THREE BCD CARDS-TGRS 1+2 ON
       REM
 CR5   IORT Q2+24,0,0 TGRS 1+2 ON-FIRST CHAR F
       REM           FIRST IORT COMMAND SHOULD
       IOCD *,0,0    NOT PUNCH. IT IS A DUMMY
       REM           TO GET DSC SET FOR LCH
       REM           INSTR. SHOULD GET CONTROL
       REM           WORD FROM LCH INSTR. IN
       REM           MAIN PROGRAM AT EOR
       IORT Q2+24,0,40  REGARDLESS OF WORD COUNT.
       IOCD *,0,0    IF THIS COMMAND IS PICKED
       REM           UP AT EOR, ADDRESS REGISTER
       REM           WILL CONTAIN ADDRESS OF
       REM           COMMAND RECEIVED BY DSC
       REM
*COMMANDS TO READ THREE BCD CARDS-TGRS S+2 ON
       REM
 CR6   IOCT Q2+24,0,24 TGRS S+2 ON-FIRST CHAR G
       IOCD *,0,0
       REM           SHOULD GET
       REM           COMMAND FROM LCH
       REM           INSTR. IN MAIN PROGRAM
       IOCT Q2+24,0,24 WHEN WC GOES TO ZERO
       REM
       IOCD *,0,0    IF THIS COMMAND IS
       REM           PICKED UP, THE DSC ADDRESS
       REM           REGISTER WILL CONTAIN
       REM           ADDRESS OF COMMAND
       REM           RECEIVED BY THE DSC
       REM
*COMMANDS TO READ THREE BCD CARDS-S, 1+2 TGRS ON
       REM
 CR7   IOST Q2+24,0,25 TGRS S,1+2 ON-FIRST CHAR H
       IOCD *,0,0
       IOST Q2+24,0,40 SHOULD GET THIS
       REM           COMMAND FROM LCH
       IOCD *,0,0    INSTR. IN MAIN PROGRAM
       REM           AT EOR. OR WHEN WC GOES
       REM           TO ZERO, WHICHEVER
       REM           COMES FIRST
       REM
       REM
 IND   HTR PR
       HTR PR1
       HTR PR6+2
       HTR PR7+2
       HTR PR7+2
       HTR SCHA1+4
       HTR SCHA1+7
       REM
 SCHA  BSS 16        STORAGE FOR CONTS. DSC
       REM
 SCHA1 BSS 16        STORAGE FOR CONTS. DSC
 SCHA2 BSS 16        STORAGE FOR CONTS. DSC
       REM
       REM           INITIAL PRINT AND PUNCH
       REM           IMAGE
 K5    OCT 1001002001    9L
       OCT 200200        9R
       OCT 2002004002    8L
       OCT 077600400401    8R
       OCT 4004010004    7L
       OCT 1001002       7R
       OCT 10010020010   6L
       OCT 2002004       6R
       OCT 20020040020   5L
       OCT 4004010       5R
       OCT 40040100040   4L
       OCT 74010010020   4R
       OCT 100100200100  3L
       OCT 3620020040    3R
       OCT 200200400200  2L
       OCT 40040100      2R
       OCT 400400000400  1L
       OCT 100100100000  1R
       OCT 777000        0L
       OCT 111000000177  0R
       OCT 777000000     11L
       OCT 220400177600  11R
       OCT 777000000000  12L
       OCT 440377600000  12R
       REM
 K6    OCT 60000030
       OCT 1000005
       OCT 1
 COUNT OCT 0         TEMP STORAGE
       REM
 K8    IOCP K50,0,2  CONTROL WORD FOR PUNCH AND
       REM           PRINTERS-S TGR ON FOR
       REM           1ST 2 WORDS- 9L,9R
       IOCT K50+2,0,4 S AND 2 TGRS ON
       IOCD *,0,0    FOR 8 AND 7 ROWS
       IOSP K50+6,0,4 S AND 1 TGRS ON FOR
       REM           6AND 5 ROWS
 K8A   IOST K50+10,0,8 S,1, AND 2 TGRS ON FOR
       REM           4,3,2,AND 1 ROWS
       IOCD *,0,0
       TCH *+2,0,2   GET CONTROL WORD FROM
       IOCD *,0,0    ADDR OF PREVIOUS WORD
       IORT K50+18,0,6 TGRS 1 AND 2 ON FOR
       REM           REMAINING WORDS
       REM
 K9    IOCP K50+24,0,4 S-TGR ON FOR 9,8, ROWS
       TCH *+2,0,4   2 TGR ON-SHOULD
       IOCD *,0,0     INDIRECT ADDRESS
       IOCT K50+28,0,4 S AND 2 TGRS ON
       IOCD *,0,0     7 AND 6 ROWS
       IOST K50+32,0,8 S,1,2-ON FOR 5,4,3,2
       IOCD *,0,0     ROWS
       IOCP K50+40,0,4 S TGR ON - FOR 0,1 ROWS
       IOCP K50+44,0,2 S TGR ON FOR
       REM            11 ROWS
       IOCP K50+46,0,2 S TGR ON FOR 12 ROW
       IORP K50,0,1  END OF RECORD
       REM            SHOULD BE RECOGNIZED
 K9A   IOCD K9
       REM
       REM
       REM           CONTROL WORD FOR
 K18   IOCP Q2,0,2   PUNCHING BINARY CARDS
       REM           1ST 2 WORDS 9L,9R
       IOCT  Q2+2,0,4  IND 2 TGR FOR
       IOCD *,0,0    8 AND 7 ROWS
       IOSP Q2+6,0,4 S AND 1 TGRS-FOR 6-5 ROW
 K18A  IOST Q2+10,0,8 S,1,2 TGRS ON FOR
       REM           4,3,2, AND 1 ROWS
       IOCD *,0,0
       TCH *+2,0,2   GET CONTROL WORD FROM
       IOCD *,0,0    ADDR OF PREVIOUS WORD
       IORT Q2+18,0,6 1 AND 2 TGRS ON FOR
       REM           REMAINING WORDS
       REM
       REM
* CONTROL WORDS FOR READING PRINTER
 K19   IOCT K50,0,16 9-2 ROWS OF CARD IMAGE
       IOCD *,0,0    S AND 2 TGRS ON
       IOCP K50+16,0,2 1 ROW OF CARD IMAGE
       IOCP K50+44,0,2 ECHO PULSES FOR 8-4
       TCH *+2       INDIRECT ADDR FOR
       IOCD *,0,0    ZERO ROW OF IMAGE  2- ON
       IOCP K50+18,0,2 ZERO ROW
       IOCP K50+46,0,1 ECHO PULSES FOR 8-3
       IOCP K50+47,0,1
 K19A  IOCP K50+20,0,2 11 ROW-S TGR ON
       TCH *+2,0,2   2 TGR ON-TAKE CW FROM
       IOCD *,0,0    ADDR OF PREVIOUS WORD
       IOCP K50+24,0,2 9 ECHO ROW
       IOSP K50+22,0,2 12 ROW OF CARD IMAGE
       IOCT K50+26,0,4  S AND 2 TGRS ON FOR
       IOCD *,0,0    8 AND 8 ROWS
 K19B  IOCP K50+30,0,8  6,5,4,3 ROWS OF CARDS
       IOCD K50+38,0,4  2 AND 1 ROWS-ALL TGRS OFF
       IOCD *,0,0
       REM
       REM
       IOCD K50+42,0,K19B+2  CHAN CONTENTS FOR
       REM            READ PRINTER
       REM
       REM
       REM           CARD READER CONTROL
 K20   TCH *+2,0,50  TGR 2 ON-WORD COUNT
       IOCD *,0,0    GREATER THEN 0
       IOCP Q2+24,0,2 S TGR ON-READ 1ST TWO
       REM           WORDS INTO STORAGE
       REM           9L AND 9R
       IOCP Q2+26,0,2 S TGR ON-READ 8L AND 8R
       TCH *+2
       IOCD *,0,0
       IOCT Q2+28,0,2 S AND 2 TGRS ON-READ 7L+7R
       REM            THEN EXECUTE LOAD CHAN ISNT
       IOCD *,0,0
 K21   IOCT Q2+30,0,2 READ 6L AND 6R THEN
       IOCD *,0,0    EXECUTE LOAD CHAN INST
       REM           S AND 2 TGRS SHOULD BEON
       IOCP Q2+32,0,1  S TGR ON-READ 5L
       IOSP Q2+33,0,1 AND 5R
       IOST Q2+34,0,4  S,1, AND 2 TGRS ON-READ 4L
       REM           4R,3L,+3R- THEN EXECUTE LCD
       IOCD *,0,0
 K22   IOCP Q2+38,0,4 READ 2L,2R,1L,1R WITH S ON
       IOCP Q2+42,0,2 READ 0L, AND 0R-S TGR ON
       TCH *+1
       IOCD Q2+44,0,4  READ 11L,11R,12L + 12R
       IOCD *,0,0    DISCONNECT CARD READER
       REM
 K13   IOCT K50+24,2,12 S AND 2 TGRS ON
       IOCD *,0,0
       IOCP K50+36,0,12  S TGR ON
       IORP K50      2 TGR ON
       IOCD K13,0,0  NEW CONTROL WORD HERE
       REM
       REM
       IOCD K13,0,K13+5 CONTENTS OF DSC
       REM
       REM
       REM
 K12   OCT 6,14,0,60
       OCT +30,44
       OCT +77,14
 K14   OCT 20
       OCT 60
 K16   OCT 6,-0
       HTR 0
       OCT +1
 K26   OCT +22
 Z1    OCT +62
       OCT +1
 Z2    IOCD 0
       IOCD Q2+48,0,K22+4
       IOCD K9,0,K9A+1
       IORT K50+24,0,K8A+5
       REM
 ENK   OCT 0
       OCT 0
       TRA 24
 SVNTW OCT 110000000
 CTR1A OCT 0
 CTR2A OCT 0
 CTR3A OCT 0
 XRAB  OCT +0         RECORD NUMBER
       OCT
       OCT
       REM
       REM            ROTATE CARD IMAGE
 K50   OCT 0,0,0,0,0,0,0,0,0,0,0,0
       OCT 0,0,0,0,0,0,0,0,0,0,0,0
       REM            CARD IMAGE
       OCT 0,0,0,0,0,0,0,0,0,0,0,0
       OCT 0,0,0,0,0,0,0,0,0,0,0,0
 K17   OCT -152347011427 RANDOM NUMBER
       REM            PROTOTYPE
 Q1    OCT +0         RANDOM NUMBERS
       REM            REC IMAGE
 Q2    EQU Q1+400     PUNCH IMAGE
       REM            READ IMAGE Q2+24
       REM
 ERROR EQU 3396
 OK    EQU 3401
 RDNCK EQU 3440
 RECNO EQU 3439
 WDNO  EQU 3438
 IOC   EQU 2892
 CTRL1 EQU 2880
 CTRL2 EQU 2881
 CTRL3 EQU 2882
 CTX   EQU 2890
       END
