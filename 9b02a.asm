                                                             9B02A
                                                             7-01-58
       REM
*                            9B02A
       REM
*       DIAGNOSTIC MODE FEATURE TEST
       REM
       ORG 24
       REM
       REM       TEST B TIME CONTROL
       REM
       HTR B1        TURN OFF ALL SWITCHES
       REM           ON CE TEST PANEL
*  TURN CONTINUOUS STORAGE READ IN SWITCH ON
       REM           ON DSU CE PANEL
       REM
*  PUT ADDR K20 IN KEYS AND LOAD CNTL WORD
*  SET ONES IN KEYS AND LOAD DATA REGISTER
       REM
       BCD 1ALS
 B1    STZ K20       SET STORAGE READ IN AREA
       REM           TO ZEROS
       REM       TEST PRI OPN 76- SHIFT OPN
       REM           WITH SHARE INTERRUPT,
       REM           AND END OPN SWITCHES
       REM           OFF
       CLM
       CLA K1+2      L +1
       ALS 35        SHOULD NOT GO TO B
       REM           TIME
       PBT           WAS ACC SHIFT EXECUTED
       REM           PROPERLY
       TRA B2-4      NO-ERROR
       TRA B2        YES CHECK READ IN AREA
       REM           OR WORD IF TRANSMITTED
       TSX ERROR,4   ERROR SUBROUTINE
       TRA B2
       TRA B1
       NOP
       REM
 B2    CLA K20       READ IN AREA
       TZE B3        SHOULD BE ZEROS
       REM
       TSX ERROR,4   POSSIBLE ERROR B CYCLE
       TRA B3        DEMAND
       TRA B1
       NOP
 B3    STZ K20       SET READ IN AREA TO
       TRA B4
       REM           ZERO
       REM
       REM       TEST PRIMARY OPERATIONS
       REM           20, 22 AND F. P. OPNS
       REM           MULTIPLY DIVIDE AND F.P.
       REM           INSTRUCTIONS WITH
       REM           SHARE, INTERRUPT, AND END
       REM           OPN SWITCHES OFF
       REM
       BCD 1FPOPS
 B4    CLA K21       CHAR 234 FRAC-600000000
       FAD K21+1     CHAR 233 FRAC 40000000000
       ADD K21+2     CHAR 234 FRAC 40000000000
       REM           ACC SHOULD BE ZERO AT
       REM           THIS TIME
       LDQ K21+3     L +177777777777
       ADD K21+4     L -3400000
       VDP K21+5     L +7777777
       REM           MQ SHOULD CONTAIN ALL
       REM           ONES
       VLM K21+5     VARIABLE MPY BY L +7000000
       ALS 1         LEFT SHIFT ONE
       ADD K21+5     L +70000000
       TZE B5-3      OK ACC SHOULD BE ZEROS
       REM           CHECK READ IN AREA
       TSX ERROR,4   EXECUTE ERROR OF
       TSX OK,4      PRI OPNS ABOVE
       TRA B4
       NOP
 B5    CLA K20       READ IN AREA
       REM           SHOULD BE ZERO
       TZE *+2       OK
       REM
       REM
       TSX ERROR,4   POSSIBLE B DEMAND CYCLE
       TSX OK,4      EXECUTED AS A RESULT
       TRA B4        OF THE ABOVE OPERATIONS
       REM           AT B4 WITH SWITCHES OFF
       REM           ON CE PANEL
       REM           PERFORM CONVERT OPNS
       BCD 1CVR
 B6    CLA K1        L +010506100407
       CVR K2,0,6    CONVERT FROM ACC
       SUB K1+1      L 070302000401
       REM           ACC SHOULD BE ZERO HERE
       REM
       LDQ K15       L +010203040506
       REM
       REM           CONVERT FROM MQ
       REM           FULL WORD CONVERSION
       CRQ K15,0,6
       LLS 35
       SUB K16       L +212223242526
       TZE B7-3      OK
       REM
       TSX ERROR,4   CONVERT OPERATIONS
       TSX OK,4      IN ERROR
       TRA B6
       NOP
 B7    CLA K20       CHECK READ IN AREA
       TZE B8        OK-STORAGE DID NOT
       REM           CHANGE NOT B CYCLE
       REM
       TSX ERROR,4
       TSX OK,4
       TRA B6
       NOP
       REM
       REM
 B8    HTR *+1       PUT SHARE SWITCH ON
       REM           AND TEST B CYCLE DEMAND
       REM
       STZ K20       SET READ IN AREA TO
       TRA B9        ZEROS
       REM           PERFORM A F.P OPERATION
       REM           B DEMAND SHOULD SHARE
       REM           IN THE ER TIME OF F.P.
       REM           INSTRUCTION
       BCD 1FAD
 B9    CLA K21       CHAR 234 FRAC-60000000
       FAD K21+1     CHAR 233 FRAC 400000000
       ADD K21+2     CHAR 234 FRAC 400000000
       TZE *+5       OK
       REM
       TSX ERROR,4   F.P ADD ERROR
       TRA B10       WHEN I/O SERVICING IS
       TRA B9        REQUIRED GO TO CHECK
       NOP           WORD- IF ANY- TRANSMITTED
       REM           TO STOR FROM DSU
       CLA K20       TRANSMITTED AREA
       TZE *+2       SHOULD NOT TRANSFER ON ZERO
       TRA B10       ZERO
       TSX ERROR,4   FAILED TO EXECUTE I/O
       TRA B11       SERVICING-NO B CYCLE
       TRA B9        DEMAND RECOGNIZED OR
       REM           WORD TRANSMITTED TO
       REM           WRONG LOCATION IN STOR
       REM
 B10   LDQ K21+6     L ALL ONES
       CAS K21+6
       TRA B11-4     ERROR
       TRA B11-3     OK
       REM
       TSX ERROR-4,4 WORD TRANSMITTED TO
       TSX OK,4      STOR INCORRECTLY DURING
       TRA B9        B DEMAND SHARE OPERATION
       REM
       BCD 1LGL
 B11   STZ K20       SET TRANSMIT AREA TO
       REM           ZEROS
       REM           EXECUTE A SHIFT OPER
       REM           AND TEST B TIME CONTROL
       LGL
       LDQ K1+2      L +1
       LGL 71
       PBT           A BIT SHOULD BE IN P POS
       TRA B12       ERROR
       TRA B13       OK CHECK TRANSMIT AREA
       REM           DID B CYCLE OCCUR
       REM           PROPERLY
 B12   TSX ERROR,4   ERROR IN LOGICAL LEFT
       TRA B13       SHIFTING
       TRA B11
       NOP
 B13   ZET K20       STORAGE SHOULD NOT BE
       TRA B14       ZERO-OK
       REM
       TSX ERROR,4
       TSX OK,4
       TRA B11
       NOP
       TRA B15       CONT TEST
       REM
 B14   CLA K20       TRANSMIT WORD
       LDQ K21+6     ALL ONES
       CAS K21+6
       TRA B15-4     I/O SERVICING ERROR
       TRA B15-3     OK
       REM           B DEMAND ERROR
       TSX ERROR-4,4 WORD TRANMITTED
       TSX OK,4      INCORRECTLY
       TRA B11
       REM
       BCD 1MPY
 B15   STZ K20       SET TRANSMIT AREA WORD
       REM           TO ZERO
       REM           PERFORM A MULTIPLY OPN
       LDQ K22       L +377777777777
       MPY K22       L +377777777777
       ADD K22+1     L +1
       TOV *+1       RESET ACC OVERFLOW TER
       ADD K22+1     L +1 RIPPLE ACC CONTENTS
       TNO B17-4     SHOULD NOT TRANSFER
       REM           ACC OVFW SHOULD BE ON
       STQ K22+2
       CLA K22+2     MQ CONTENTS
       SUB K22+1     L +1
       TZE B17
       REM
       TSX ERROR,4   MULTIPLY ERROR
       TSX OK,4
       TRA B15
                     DID MEMORY SHARE
       NOP
       REM
 B17   CLA K20       IN I/O SERVICING
       TZE B18-3     ERROR - FAILED TO
       REM           TRANSMIT TO STORAGE
       LDQ K21+6     ALL ONES
       CAS K21+6     LOC OF ALL ONES
       TRA B18-4     ERROR
       TRA B18-3
       REM
       TSX ERROR-4,4 B-CYCLE DEMAND ERROR
       TSX OK,4      WHEN PERFORMING A MPY
       TRA B15       OPN
       REM           TEST SHARE INTERRUPT
       BCD 1VDP      IN VARIABLE LENGTH DIV.
 B18   CLA K21+4     L -3400000
       LDQ K21+3     L +1777777777777
       REM
       VDP K21+5     L +700000
       REM
       STQ K22+2
       CLA K22+2
       LDQ K21+3     L ALL ONES
       CAS K21+3
       TRA B19-4     VARIABLE LENGTH DIV-ERR
       TRA B19       OK-CHECK I/O SERVICING
       REM
       TSX ERROR,4   VDP ERROR
       TSX OK,4
       TRA B18
       REM
       NOP
 B19   CLA K20       WAS WORD TRANSMITTED
       TZE *+5       TO STORAGE-NO
       REM           YES
       LDQ K21+6     L ALL ONES
       CAS K21+6
       TRA B20-4     ERROR
       TRA B20-3     OK
       REM
       TSX ERROR-4,4 B CYCLE DEMAND ERROR
       TSX OK,4      PERFORMING VARIABLE
       TRA B18       LENGTH DIVIDE OPN
       NOP
 B20   HTR B21       PUT SHARE SWITCH OFF
       REM           AND INTERRUPT SWITCH ON
       REM
       REM
       REM           TEST CONVERT INSTRUCTION
       BCD 1CVR      CONVERT FROM ACC
       REM           DSU SHOULD CAPTURE A
       REM           CYCLE AND EXECUTE I/O
       REM           SERVICING
 B21   STZ K20       SET TRANSMIT AREA TO
       REM           ZEROS
       CLA K1        L +010506100407
       CVR K2,0,6    CONVERT FROM ACC
       REM           DID CONVERT FROM ACC
       REM           OCCUR PROPERLY
 B22   LDQ K1+1
       CAS K1+1      L +070302000401
       TRA B23-4     NO-ERROR
       TRA B23-3     OK-CHECK STORAGE AREA
       REM
       TSX ERROR,4   ERROR-CONVERT FROM ACC
       TSX OK,4      WITH INTERRUPT SW DOWN
       TRA B21
       NOP
       REM
 B23   ZET K20       ARE THERE ANY BITS IN
       TRA B24       STORAGE AREA-YES
       REM           NO-
       REM
       TSX ERROR,4   ERROR-I/O SERVICING
       TRA B25
       TRA B21
       TRA B25
       REM
 B24   CLA K21+6     ALL ONES
       LDQ K20       STORAGE AREA
       CAS K20
       TRA B25-4     ERROR WORD TERNSMITTED
       TRA B25-3     OK
       REM
       TSX ERROR-4,4 B CYCLE INTERRUPT
       TSX OK,4      OCCURED-ERROR IN WORD
       TRA B21       TRANSMITTED
       REM
       BCD 1CRQ      TEST CONVERT FROM MQ
 B25   CLM           WITH INTERRUPT SW ON
       STZ K20       SET STORAGE TO ZEROS
       REM
       LDQ K15       L +010203040506
       REM
       CRQ K15,0,6   FULL WORD CONVERSION
       REM
       REM           WAS CONVERT FROM MQ
       REM           EXECUTED CORRECTLY
       REM
       CAL K16       L +2123242526
       CAS K16
       TRA B26-4     ERROR-CONVERT FROM MQ
       TRA B26-3     WITH INTERRUPT SW ON
       REM
       TSX ERROR,4   FAILED TO EXECUTE
       TSX OK,4      CONVERT FROM MQ
       TRA B25
       NOP
 B26   ZET K20       DID I/O SERVICING
       TRA B27       OCCUR-YES
       REM           NO
       TSX ERROR,4   B CYCLE DEMAND ERROR
       TSX OK,4
       TRA B25
       NOP
 B27   CLA K20       STORAGE AREA
       LDQ K21+6     ALL ONES
       CAS K21+6     STORAGE AREA
       TRA B28-4     ERROR
       TRA B28-3     OK
       REM
       TSX ERROR-4,4 POSSIBLE IO SERVICING
       TSX OK,4      ERROR WITH INTERRUPT
       TRA B25       SW ON
       NOP
       REM           TEST END OPN SW
       REM
 B28   HTR B29       PUT INTERRUPT SW OFF
       REM           AND END OPN SW ON
       REM
 B29   STZ K20       SET STORAGE AREA TO
       REM           ZEROS
       REM           SHOULD GO TO B CYCLE
       NOP           DEMAND AT END OF E TIME
       CLA K20       STORAGE AREA
       TNZ B30
       TSX ERROR,4   I.O SERVICING ERROR
       TSX OK,4      WITH END OPN SW ON
       TRA B29       FAILED TO TRANSMIT
       REM           WORD TO STORAGE
       NOP
       REM
 B30   LDQ K21+6     ALL ONES
       CAS K21+6
       TRA B31-4     ERROR
       TRA B31-3     OK
       REM
       TSX ERROR-4,4 TRANSMITTED WORD TO
       TSX OK,4      STORAGE INCORRECTLY
       TRA B29       DURING I/O SERVICING
       NOP
 B31   HTR 24        REPEAT TEST
 K1    OCT 010506100407
       OCT 070302000401
       OCT +1
       REM           CONVERT FIELD
 K2    PZE K2        8 K2
       PSE K2        7 K2
       SLW K2        6 K2
       CLA K2        5 K2
       ADD K2        4 K2
       FAD K2        3 K2
       MPY K2        2 K2
       TZE K2        1 K2
       HTR K2        0 K2
       REM
 K10   OCT
       OCT
       OCT
 K7    HTR
       OCT 0
       HTR K10,0,2
 K15   OCT 010203040506
       TIX K15,0,4096 21
       TIX K15,0,8192 22
       TIX K15,0,12288 23
       TIX K15,0,16384 24
       TIX K15,0,20480 25
       TIX K15,0,24576 26
 K16   OCT 212223242526
       OCT
 K21   OCT -234600000000
       OCT 233400000000
       OCT 234400000000
       OCT 177777777777
       OCT -340000
       OCT +700000
       OCT -377777777777 ALL ONES
 K22   OCT 377777777777
       OCT +1
       OCT
 K20   OCT
       REM
 ERROR EQU 3396
 OK    EQU 3401
       END
