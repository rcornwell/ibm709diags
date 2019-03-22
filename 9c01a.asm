                                                             9C01A
                                                            7/1/58
       REM 9C01A
       REM            
*CARD READER TIMING AND RELIABILITY TEST
       REM
       ORG 24         
       REM            
       REM PROGRAM IDENTIFICATION
       REM            
       SWT 3          
       TRA PI7        
       REM            
*ADJUST CARD READER TEST FOR CHANNELS A,C OR E
       REM            
MP     TSX IOC,4      TO ENTER CONTROL
       REM            WORDS IN KEYS
       REM            
*WITH A PROGRAM STOP AT LOCATION 05517, ENTER INTO KEYS INFORMATION
*DESIGNATING THE NUMBER OF BUFFERS ON LINE THAT HAVE CARD
*READERS TO BE CHECKED.IF A PASS HAS BEEN MADE ON THE CARD READERS.
*RELOAD CARDS 114-413 AND READY READERS.
       REM            
*      CHANNEL A ON LINE KEYS 20 AND 35
       REM            
*TO TEST CARD READERS ON CHANNELS OTHER THEN A, THERE IS AN ADDITIONAL
*PROGRAM STOP FOR EACH CHANNEL.PUSH START AFTER EACH STOP.
       REM            
*      CHANNEL C ON LINE KEYS 19 AND 35
*      CHANNEL E ON LINE KEYS 18 AND 35
*      CHANNELS A AND C ON LINE KEYS 19,20 AND 35
*      CHANNELS A AND E ON LINE KEYS 18,20, AND 35
*      CHANNELS C AND E ON LINE KEYS 18,19 AND 35
*      CHANNELS A,C AND E ON LINE KEYS 18,19,20 AND 35
       REM            
       LDI CTRL1      CONTROL WORD FOR CHAN A
       RNT 1,1        IS CHANNEL A ON LINE
       TRA *+2        NO
       TRA *+5        YES
TCTX   TSX CTX,4      NO-ADJUST ADR FOR CHAN C,E
       HTR CRS,0,FILE     1ST AND LAST ADDRESS
       REM            TO BE ADJUSTED
       REM            
       CLA IOCT       L NO OF BUFFERS
       TZE SEN6       ALL CARD READERS
       REM            HAVE BEEN CHECKED
       REM            
       CLA K1         
       STO 0          
       REM            
       REM CARD READER TEST
       REM            
       CLA K+3        L +454
       STO SX+1       
       ADD KK+10      L +1
       STO RECNO      SET RECORD NUMBER CONSTANT
       REM            
       CLA K          L +30
       ADD KK+10      L +1
       STO WDNO       SET WORD NUMBER CONSTANT
       REM            
*CHECK SPEED OF CARD READER
       REM            
       CLA K0+19      
       STO RDRDY      
       REM            
       IOT            TURN OFF I/O CHECK LIGHT
       TRA *+1        
       REM            
CRS    RCDA           SELECT CARD READER
       REM            
       RCHA CW        9 L CONTROL WORD TO BUFFER
       LCHA CW+1      9 L CONTROL WORD EXECUTED
       REM            
*MOVE CARD READER TO EOR WITHOUT TRANSIMITTING WORDS TO STORAGE
*AT EOR TIME BRING IN 9 LEFT COTNROL WORD TO BUFFER
       REM            
       TSX REDUC,4    TO REDUCE RECORD COUNT
       REM            
       AXT 2,2        L 2 IN XRB
       AXT 4078,1     L 7756 IN XRA
       TIX *,1,1      TOTAL DELAY
       TIX  *-2,2,1   OF 196 MS
       REM            
       LXA RDRDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY
       REM            
       LCHA CW+1      9 R CONTROL WORD TO BUFFER
       REM            EXECUTE 9 LEFT WORD
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE-3,4   YES
       TRA CRS1       NO
       REM            
       CLA K0+7       L +576714
       STO P+4        
       REM            
       LDI PI+4       TURN ON INDICATOR 7
       REM            
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR1        TO TIMING PRINT ROUTINE
       REM            
CRS1   TSX REDUC,4    TO REDUCE RECORD COUNT
       REM            
       REM            
       REM            
       CLA RDRDY      ADD
       ADD K0+5       1 MS
       STO RDRDY      TO DELAY
       TRA CRS+2      
       REM            
       TSX REDUC,4    TO REDUCE RECORD COUNT
       REM            
TIME   CLA K0         SET
       STO SELDY      
       REM            
       CLA K0+1       UP
       STO WORDY      
       REM            
       CLA K0+3       ALL
       STO ROWD1      
       REM            
       CLA K0+2       THE
       STO ROWDY      
       REM            
       CLA KK+11      INITIAL
       STO CONDY
       REM            
       CLS KK         TIMING 
       STO EORDY 
       REM            
       CLA K0+4       UNITS
       STO KONDY      
       REM            
       CLA K          INITERMITTENT
       SUB KK+10      LATCH UP
       STO NUM        CONSTANT
       REM            
       SLF            SENSE LIGHTS OFF
       REM            
       LDI KK+11      ALL INDICATORS OFF
       REM            
       IOT            TURN OFF I/O CHECK LIGHT
       TRA *+1        
       REM            
       TSX CLEAR,4    CLEAR CARD IMAGE AREA
       REM            
*CHECK TIMING BETWEEN SELECT AND RESET LOAD CHANNEL
       REM            
CR     RCDA           SELECT CARD READER
       REM            
       ANA            36 USEC DELAY
       LXA SELDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 55 MS
       REM            
       RCHA CW1       9 L CONTROL WORD TO BUFFER
       REM            
       LCHA CW1+1     9 R CONTROL WORD TO BUFFER
       REM            FOR SYNCHRONOUS OPERATION
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR1        NO
       REM            
       CLA K0+11      L +140
       STO P+4        STORE TIMING VALUE
       REM            
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR1        TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 9 LEFT AND 9 RIGHT
       REM            
CR1    LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+2     8 L CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ONE
       TSX LINE,4     YES
       TRA CR2        NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK         L -11
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 9 RIGHT AND 8 LEFT
       REM            
CR2    LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 8 MS
       REM            
       LCHA CW1+3     8 R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR3        NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK         L -11
       STO P+1        
       SUB KK+8       L -1
       STO P+3        STORE A -10
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 8 LEFT AND 8 RIGHT
       REM            
CR3    LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+4     7 L CONTROL WORD TO BUFFER
       REM            
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR4        NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+1       L -10
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 8 RIGHT AND 7 LEFT
       REM            
CR4    LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 8 MS
       REM            
       LCHA CW1+5     7 R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR5        NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+1       L -10
       STO P+1        
       SUB KK+8       L -1
       STO P+3        STORE A -7
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 7 LEFT AND 7 RIGHT
       REM            
CR5    LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+6     6 L CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR6        NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+2       L -7
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 7 RIGHT AND 6 LEFT
       REM            
CR6    LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 8 MS
       REM            
       LCHA CW1+7     6 R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR7        NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+2       L -7
       STO P+1        
       SUB KK+8       L -1
       STO P+3        STORE A -6
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 6 LEFT AND 6 RIGHT
       REM            
CR7    LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+8     5 L CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR8        NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+3       L -6
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 6 RIGHT AND 5 LEFT
       REM            
CR8    LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 8 MS
       REM            
       LCHA CW1+9     5 R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR9        NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+3       L -6
       STO P+1        
       SUB KK+8       L -1
       STO P+3        STORE A -5
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 5 LEFT AND 5 RIGHT
       REM            
CR9    LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+10    4 L CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR10       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+4       L -5
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 5 RIGHT AND 4 LEFT
       REM            
CR10   LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 4 MS
       REM            
       LCHA CW1+11    5 R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR11       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+4       L -5
       STO P+1        
       SUB KK+8       L -1
       STO P+3        STORE A -4
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 4 LEFT AND 4 RIGHT
       REM            
CR11   LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+12    3 L CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR12       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+5       L -4
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 4 RIGHT AND 3 LEFT
       REM            
CR12   LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 8 MS
       REM            
       LCHA CW1+13    3 R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR13       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+5       L -4
       STO P+1        
       SUB KK+8       L -1
       STO P+3        STORE A -3
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 3 LEFT AND 3 RIGHT
       REM            
CR13   LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+14    2 L CONTROL WORD TO BUFFER (2277)
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR14       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+6       L -3
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 3 RIGHT AND 2 LEFT
       REM            
CR14   LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 8 MS
       REM            
       LCHA CW1+15    3 R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR15       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+6       L -3
       STO P+1        
       SUB KK+8       L -1
       STO P+3        STORE A -2
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 2 LEFT AND 2 RIGHT
       REM            
CR15   LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 4 MS
       REM            
       LCHA CW1+16    1 L CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR16       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+7       L -2
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 2 RIGHT AND 1 LEFT
       REM            
CR16   LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+17    1 R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR17       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+7       L -2
       STO P+1        
       SUB KK+8       L -1
       STO P+3        STORE A -1
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 1 LEFT AND 1 RIGHT
       REM            
CR17   LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+18    0 L CONTROL WORD TO BUFFER 
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR18       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+8       L -1
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 1 RIGHT AND 0 LEFT
       REM            
CR18   LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 8 MS
       REM            
       LCHA CW1+19    0 R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR19       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+8       L -1
       STO P+1        
       SUB KK+8       L -1
       STO P+3        STORE A -0
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 0 LEFT AND 0 RIGHT
       REM            
CR19   LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+20    11L CONTROL WORD TO BUFFER 
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR20       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       STZ P+2        
       CLA KK+9       L -0
       STO P+1        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 0 RIGHT AND 11 LEFT
       REM            
CR20   LXA ROWDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 4 MS
       REM            
       LCHA CW1+21    11R CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR21       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       STZ P          
       CLA KK+9       L -0
       STO P+1        
       CLA KK+8       L -1
       STO P+2        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 11 LEFT AND 12 RIGHT
       REM            
CR21   LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1+22    12L CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR22       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       CLA KK+8       L -1
       STO P          
       STO P+1        
       STO P+2        
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 11 RIGHT AND 12 LEFT
       REM            
CR22   ENK            KEYS TO MQ
       XCA            MQ TO ACCUMULATOR
       PAI            ACCUMULATOR TO INDICATORS
       LNT 100000     CHECK TIME BETWEEN WORDS
       TRA CR22A      NO
       TRA *+1        YES
       REM            
       LXA ROWD1,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 8 MS
       REM            
       LCHA CW1+23    12R CONTROL WORD TO BUFFER
       REM            WITH S AND 2 TRIGGER ON
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TRA CR22A+4    YES
       TRA CR23       NO
       REM            
CR22A  LXA ROWD1,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 8 MS
       REM            
       LCHA CW1+24    12R CONTROL WORD TO BUFFER
       REM            WITH 1 AND 2 TRIGGER ON
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE-1,4   YES
       TRA CR24       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       CLA KK+8       L -1
       STO P          
       STO P+1        
       STO P+2        
       ADD KK+8       L -1
       STO P+3        STORE A -2
       REM            
       CLA K0+12      L +374
       STO P+4
       REM
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
*CHECK TIMING BETWEEN 12 LEFT AND 12 RIGHT
       REM            
CR23   LXA WORDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY 300 USEC
       REM            
       LCHA CW1       WITH S AND 2 TRIGGERS ON 9
       REM            LEFT CONTROL WORD TO BUFFER
       REM            PREVENTING DISCONNECT OF CR
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR24       NO
       REM            
       REM SAVE CARD LOCATIONS TESTING
       REM            
       CLA KK+8       L -1
       STO P          
       STO P+2        
       ADD KK+8       L -1
       STO P+1        STORE A -2
       STO P+3        
       REM            
       TSX VALUE,4    TO TIMING VALUE ROUTINE
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR         TO TIMING PRINT ROUTINE
       REM            
       BCD 1RCDA      CHECK INFORMATION
       REM            READ FROM CARD
CR24   LXA K,1        L 30 IN XRA
       LXA SX+1,2     RECORD NUMBER TO XRB
       CLA CI+24,1    WORD READ FROM CARD
       LDQ CBI+24,1   WORD IN STORAGE
       CAS CBI+24,1   
       TRA *+2        ERROR
       TRA *+5        OK
       SLN 1          TURN ON SENSE LIGHT 1
       TSX ERROR-2,4  TO ERROR ROUTINE
       NOP CR24       
       REM            
       TRA 0          IF ERROR, SELECT CARD READER
       REM            
       TIX CR24+2,1,1 CHECK ENTIRE RECORD    
       TNX FILE,2,1   REDUCE RECORD COUNT UNTIL
       REM            LAST CARD HAS BEEN READ
       REM            
       SXA SX+1,2     SAVE RECORD COUNT
       REM            
       TSX CLEAR,4    CLEAR CARD IMAGE AREA
       TRA CLEAR+4    
       REM            
CLEAR  LXA K,1        L 30 IN XRA
       STZ CI+24,1    CLEAR CARD
       TIX *-1,1,1    IMAGE AREA
       TRA 1,4        
       REM            
*INCREMENT DELAY CONSTANTS TO INCREASE DELAYS
       REM
       REM            
       LNT 200000     INCREASE DELAY BETWEEN 
       REM            SELECT AND RESET LD CHAN
       REM            
       TRA CR25       NO
       CLA SELDY      ADD
       ADD K0+5       ABOUT
       STO SELDY      1 MS
       REM            
*DELAY ABOUT 10 MS AFTER 12 RIGHT TIME NO LAOD CHANNEL WAITING
*DISCONNECT AND RESELECT THE CARD READER
       REM            
       AXT 1070,1     L 2056 IN XRA
       TIX *,1,1      DELAY
       TRA CR         
       REM            
CR25   LNT 100000     INCREASE DELAY
       REM            BETWEEN WORDS
       REM            
       TRA CR26       NO
       CLA WORDY      ADD
       ADD KK+10      24
       STO WORDY      USEC
       ANA            36 USEC DELAY
       AXT 3340,1     L 6414 IN XRA
       TIX *,1,1      DELAY 85 MS
       REM            
       LCHA CW1+1     9 R NEXT RECORD TO BUFFER
       REM            
       TRA CR+8       READ NEXT RECORD
       REM            
CR26   LNT 40000      INCREASE DELAY
       REM            BETWEEN ROWS
       REM            
       TRA CR27       NO
       CLA ROWDY      ADD
       SUB KK+4       
       STO ROWDY      ABOUT
       CLA ROWD1      
       SUB KK+4       1/10 MS
       STO ROWD1      
       ANA            36 USEC DELAY
       AXT 17,1       L 21 IN XRA
       TIX *,1,1      DELAY 5 MS FROM 12 R TIME
       REM            
*AT EOR TIME-224 ON INDEX, LOAD CHANNEL INSTR FOR 9L OF NEXT RECORD
       REM            
       LCHA CW1       9L CONTROL WORD TO BUFFER
       REM            
       ANA            36 USEC DELAY
       AXT 3538,1     L 6722 IN XRA
       TIX *,1,1      DELAY 85 MS
       REM            
       LCHA CW1+1     9 R NEXT RECORD TO BUFFER
       REM            
       TRA CR+8       READ NEXT RECORD
       REM            
*CHECK TIMING BETWEEN RECORDS FROM EOR TIME TO 9L TIME
       REM            
CR27   LNT 20000      INCREASE DELAY
       REM            BETWEEN RECORDS
       REM            
       TRA CR28       NO
       ANA            36 USEC DELAY
       AXT 20,1       L 24 IN XRA
       TIX  *,1,1     DELAY 5 MS FROM 12 R TIME
       REM            
*AT EOR TIME-224 ON INDEX. LOAD CHANNEL INSTR FOR 9L OF NEXT RECORD
       REM            
       LCHA CW1       9L CONTROL WORD TO BUFFER
       REM            
*COMMENCE WITH 42 MS DELAY THRU LOAD CHANNEL INSTRUCTION
       REM            
       CLA CONDY      ADD
       ADD K0+5       ABOUT
       STO CONDY      1 MS
       AXT 3492,1     L 6644 IN XRA
       TIX *,1,1      DELAY
       ANA            36 USEC DELAY
       LXA CONDY,3    L DELAY CONSTANT TO XR
       TIX *,1,1      DELAY
       REM            
       LCHA CW1+1     9 R NEXT RECORD TO BUFFER
       REM            
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR1        
       REM            
       CLA K0+10      L +244040
       STO P+4        
       REM            
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR1        
       REM            
*CHECK TIMING BETWEEN 12 RIGHT AND END OF RECORD
       REM            
CR28   LNT 10000      INCREASE DELAY BETWEEN
       REM            12 RIGHT AND END OF RECORD
       REM            
       TRA CR29       NO
       CLA EORDY      ADD
       SUB KK+4       ABOUT
       STO EORDY      1/10 MS
       ANA            36 USEC DELAY
       LXA EORDY,3    L DELAY CONSTANT TO XR
       TIX  *,1,1     DELAY 5 MS FROM 12 R TIME
       REM            
       LCHA CW1       9L CONTROL WORD TO BUFFER
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TSX LINE,4     YES
       TRA CR28A      NO
       REM            
       CLA K0+6       L +5230
       STO P+4        
       REM            
       TSX SAVE,4     TO SAVE XRB ROUTINE
       TRA PR1        TO TIMING PRINT ROUTINE
       REM            
CR28A  AXT 3536,1     L 6720 IN XRA
       TIX  *,1,1     DELAY 85 MS
       ANA            36 USEC DELAY
       REM            
       LCHA CW1+1     9R CONTROL WORD TO BUFFER
       REM            
       TRA CR+8       
       REM            
*CHECK TIMING BETWEEN 12 RIGHT TIME AND SELECT
       REM            
CR29   LNT 4000       INCREASE DELAY BETWEEN
       REM            12 RIGHT AND SELECT
       REM            
       TRA CR30       NO
       REM            
       RCDA           SELECT CARD READER
       REM            
       RCHA CW9       9 LEFT THRU 12 RIGHT
       REM            CONTROL WORDS
       REM            
       TCOA *         READ ENTIRE CARD
       REM            
       TSX REDUC,4    TO REDUCE RECORD COUNT
       REM            
       AXT 1535,1      L 2777 IN XRA
       TXI *+1,1,1    XRA NOW 3000
       LXA KONDY,2    L DELAY CONSTANT TO XRB
       TXI *+1,2,14   ADD 1 MS DELAY
       SXA KONDY,2    SAVE CONSTANT
       REM            
CR29B  TIX *+4,2,1      CHECK INCREASED 
       TXL *+4,2,0      TIMING DELAY
       REM              BETWEEN 12 RIGHT
       RCDA             AND SELECT WHILE
       REM              KEEPING TIMING
       TXI *+2,2,32767 DELAY BETWEEN 12
       NOP            RIGHT AND 9 LEFT
       TIX CR29B,1,1    CONSTANT
       REM            
       RCHA CW10      9 LEFT THRU 12 RIGHT
       REM            CONTROL WORDS
       REM            
       TCOA *         READ ENTIRE CARD
       REM            
       LXA KONDY,2    L DELAY VALUE IN XRB
       REM            
       IOT            IS I/O CHECK LIGHT ON
       TRA CR24       YES
       TSX LINE,4     NO
       NOP            
       REM            
*CONVERT 6 CYCLE DELAY CONSTANT TO 2 CYCLE
       REM            
       LDQ KONDY      6 CYCLE CONSTANT
       MPY KK+6       L -3
       XCA            PRODUCT TO ACCUMULATOR
       CHS            
       STO SX         SAVE CONVERTED CONSTANT
       REM            
       CLA K0+14      L +60
       STO P+4        
       REM            
       TRA PR1        TO TIMING PRINT ROUTINE
       REM            
*TEST SENSE SWITCH 5 TO CHECK CARD READER RELIABILITY
*READING WITH NORMAL DELAYS OR WITH VARIABLE DELAYS
*CAUSING CARD READER TO INTERMITTENTLY LATCH UP
       REM            
CR30   SWT 5          TEST SENSE SWITCH 5
       TRA *+11       NORMAL DELAY
       CLA NUM        
       ADD KK+10      L +1
       STO NUM        SAVE
       STA *+1        
       CLA            
       PAX 0,1        ADDRESS TO XRA
       TIX *,1,1      DELAY
       AXT 788,1      L 1424
       TIX *,1,1      DELAY
       TRA CR         TO SELECT CARD READER
       REM            
       AXT 11,1       L 13 XRA
       TIX *,1,1      DELAY 5 MIS FROM 12 R TIME 
       ANA            36 USE DELAY
       REM            
*AT EOR TIME-224 ON INDEX, LOAD CHANNEL INSTR FOR 9L OF NEXT RECORD
       REM            
       LCHA CW1       9L CONTROL WORD TO BUFFER
       REM            
       ANA            36 USEC DELAY
       AXT 3538,1     L 6722 IN XRA
       TIX *,1,1      DELAY 85 MS
       REM            
       LCHA CW1+1     9R CONTROL WORD TO BUFFER
       REM            
       TRA CR+8       
       REM            
*CHECK FOR PRINTER ON LINE
       REM            
       SLN 2          TURN ON SENSE LIGHT 2
       TRA LINE       
       SLN 3          TURN ON SENSE LIGHT 3
LINE   SWT 3          TEST SENSE SWITCH 3
       TRA 2,4        YES-PRINT
       TSX SAVE,4     
       LNT 10000      INDICATOR POSITION 5 ON
       HTR TIME-1     
       HTR TIME       
       REM            
SAVE   SXA SX,2       SAVE XRB
       TRA 1,4        
       REM            
VALUE  CLA K0+13      L +154
       STO P+4        SAVE TIMING VALUE
       TRA 1,4        
       REM            
REDUC  LXA SX+1,2     L RECORD COUNT TO XRB
       TNX FILE,2,1   REDUCE RECORD COUNT UNTIL
       REM            LAST CARD HAS BEEN READ
       SXA SX+1,2     SAVE RECORD COUNT
       TRA 1,4        
       REM            
       BCD 1TEFA      CHECK FOR FALSE EOF
       REM            
FILE   TEFA *+2       NEVER AN EOF HERE
       REM            SHOULD NOT TRANSFER
       TRA *+3        OK-NO TRANSFER
       TSX ERROR-2,4  
       TXL FILE,4     
       REM            
       SWT 3          IS PRINTER ON LINE
       TSX PASS,4     YES-PRINT PASS COMPLETE
       CLA IOCT       L NO OF BUFFERS
       SUB KK+10      L +1
       STO IOCT       ALL CARD READERS
       REM            HAVE BEEN CHECKED
       TZE *+2        YES
       TRA TCTX       NO-GO CHECK OTHERS
       REM            
       CLA IOCTL      L CONTROL WORD
       STO CTRL1      FOR CHANNEL A
       STZ CTRL2      AND CLEAR CONTROL
       STZ CTRL3      WORDS FOR CHANNEL C,E
       TRA TCTX       ADJUST TEST FOR CHAN A
       REM            
SEN6   SWT 6          TEST SENSE SWITCH 6
       TRA *+4        TO LOAD NEXT PROGRAM
       REM            
*BYPASS CARD READER SPEED TEST AFTER FIRST PASS
       REM            
       CLA IOCTL+2    L TRA TIME
       STO TCTX+8     
       TRA MP         REPEAT TEST
       REM            
*RUN OUT CARDS IN READER AND RELOAD CARDS      TEST AND BLANK CARDS
*IN HOPPER AND READY CARD READER.SET KEYS AS PER INSTRUCTIONS
*AFTER LOCATION 00032 AND PUSH START.
       REM            
       RCDA           LOAD
       RCHA CWA       THE
       LCHA 0         NEXT
       TRA 1          PROGRAM
       REM            
PASS   LDI CR         SELECT INSTR TO IND
       RNT 5321,0     TESTING ON CHANNEL E
       TRA *+2        NO
       TRA FIX        YES
       RNT 3321,0     TESTING ON CHANNEL C
       TRA *+2        NO
       TRA FIX1       YES
       REM            
*ADJUST PASS COMPLETE PRINT IMAGE FOR CHANNEL A
       REM            
       CAL IOCTL+1    L 777777074000
       ANS IMAG8+13   ADJUST 3R ROW
       ANS IMAG8+9    ADJUST 5R ROW
       CAL BIT+7      L 000000200000
       ORS IMAG8+17   ADJUST 1R ROW
       TRA PI8        
       REM            
*ADJUST PASS COMPLETE PRINT IMAGE FOR CHANNEL E
       REM            
FIX    CAL IOCTL+1    L 777777074000
       ANS IMAG8+13   ADJUST 3R ROW
       ANS IMAG8+17   ADJUST 5R ROW
       CAL BIT+7      L 000000200000
       ORS IMAG8+9    ADJUST 5R ROW
       TRA PI8        
       REM            
*ADJUST PASS COMPLETE PRINT IMAGE FOR CHANNEL E
       REM            
FIX1   CAL IOCTL+1    L 777777074000
       ANS IMAG8+9    ADJUST 5R ROW
       ANS IMAG8+17   ADJUST 1R ROW
       CAL BIT+7      L 000000200000
       ORS IMAG8+13   ADJUST 3R ROW
       TRA PI8        
       REM            
*ADJUST CARD LOCATION INSERTION ROUTINE
       REM            
PR     CLA K1+1       L HTR P
       STA PRA1+1     
       REM            
       LNT 100000     INDICATOR POSITION 2 ON
       TRA *+6        NO
       CLA K1+3       L ORS IMAG1+19,4
       STO PRA1+6     INSTR FOR INDICATOR 2 ON
       CAL K1+8       L ANS IMAG1+21,1
       STO PRA+2      INSTR FOR INDICATOR 2 ON
       TRA PRA        
       REM            
       CLA K1+4       L ORS IMAG2+19,4
       STO PRA1+6     INSTR FOR INDICATOR 3 ON
       CLA K1+9       L ANS IMAG2+21,1
       STO PRA+2      INSTR FOR INDICATOR 3 ON
       REM            
*MASK CARD IN CORRECT IMAGE
       REM            
PRA    LXA K+1,1      L 24 IN XRA
       CAL MASK       L 477177777777
       OCT            MASK CARD LOCATIONS
       TIX *-1,1,2    IN PRINT IMAGE
       REM            
*INSERT CARD LOCATIONS IN PRINT IMAGE
       REM            
PRA1   LXA KK+5,1     L 4 IN XRA
       CLA            L STORED VALUE
       TPL PRA2       SKIP LOCATION INSERTION
       ALS 1          DOUBLE VALUE
       PAX 0,4        PUT ACCUMULATOR IN XRC
       CLA BIT+4,1    L LOCATION BIT
       OCT            INSERT PRINT IMAGE
PRA2   CLA PRA1+1     L CLA INSTR
       ADD KK+10      L +1
       STA PRA1+1     STORE NEXT ADDRESS
       TIX PRA1+1,1,1 
       REM            
       REM CONVERT XRB VALUE TO USEC IN OCTAL
       REM            
PR1    LDQ SX         L SAVED XRB IN MQ
       MPY K          MPY BY OCT 30,EQU USEC
       XCA            PUT PRODUCT IN ACC
       ADD P+4        
       STO P+5        TOTAL USEC
       REM            
       LNT 100000     INDICATOR POSITION 2 ON
       TRA *+2        NO
       TRA PR2A       
       REM            
       REM CONVERT USEC TO MILLISEC
       REM            
       LNT 2000       INDICATOR POSITION 7 ON
       TRA *+2        NO
       TRA *+4        YES
       REM            
       CLA K0+16      L HTR K0+9
       STA PR1A       
       TRA *+3        
       REM            
       CLA K1+15      L HTR K+4
       STA PR1A       
       REM            
       LDQ P+5        PUT USEC IN MQ
       CLA KK+11      CLEAR ACCUMULATOR
       REM            
*DIV BY DEC 100 EQU MS AND TENTHS-DIV BY DEC 1000 EQU MS
       REM            
PR1A   DVP            
       STQ P+5        
       REM            
*TEST INDICATORS FOR CORRECT PRINT IMAGE
       REM            
PR2    LNT 200000     INDICATOR POSITON 1 ON
       TRA PR2B       NO
       CLA K1+7       L ANS IMAG+21,1
       STO PR4A+1     INSTR FOR INDICATOR 1 ON
       CLA K1+2       L ORS IMAG+19,4
       STO PR6        INSTR FOR INDICATOR 1 ON
       LXA KK+3,2     L 6 IN XRB
       TRA PR4        
       REM            
PR2A   CLA K1+8       L ANS IMAG1+21,1
       STO PR4A+1     INSTR FOR INDICATOR 2 ON
       CLA K1+3       L ORS IMAG1+19,4
       STO PR6        INSTR FOR INDICATOR 2 ON
       LXA KK+4,2     L 5 IN XRB
       TRA PR4        
       REM            
PR2B   LNT 40000      INDICATOR POSITION 3 ON
       TRA PR2C       NO
       CLA K1+9       L ANS IMAG2+21,1
       STO PR4A+1     INSTR FOR INDICATOR 3 ON
       CLA K1+4       L ORS IMAG2+19,4
       STO PR6        INSTR FOR INDICATOR 3 ON
       LXA KK+5,2     L 4 IN XRB
       TRA PR4        
       REM            
PR2C   LNT 20000      INDICATOR POSITION 4 ON
       TRA PR2D       NO
       CLA K1+10      L ANS IMAG3+21,1
       STO PR4A+1     INSTR FOR INDICATOR 4 ON
       CLA K1+5       L ORS IMAG3+19,4
       STO PR6        INSTR FOR INDICATOR 4 ON
       LXA KK+6,2     L 3 IN XRB
       TRA PR4        
       REM            
PR2D   LNT 10000      INDICATOR POSITION 5 ON
       TRA PR2E       NO
       CLA K1+11      L ANS IMAG4+21,1
       STO PR4A+1     INSTR FOR INDICATOR 5 ON
       CLA K1+6       L ORS IMAG4+19,4
       STO PR6        INSTR FOR INDICATOR 5 ON
       LXA KK+7,2     L 2 IN XRB
       TRA PR4        
       REM            
PR2E   LNT 4000       INDICATOR POSITION 6 ON
       TRA PR2G       NO
       CLA K1+16      L ANS IMAG5+21,1
       STO PR4A+1     INSTR FOR INDICATOR 6 ON
       CLA K1+17      L ORS IMAG5+19,4
       STO PR6        INSTR FOR INDICATOR 6 ON
       LXA KK+8,2     L 1 IN XRB
       TRA PR4        
       REM            
PR2G   LNT 2000       INDICATOR POSITION 7 ON
       TRA 0          NO
       CLA K1+18      L ANS IMAG6+21,1
       STO PR4A+1     INSTR FOR INDICATOR 7 ON
       CLA K1+19      L ORS IMAG6+19,4
       STO PR6        INSTR FOR INDICATOR 7 ON
       LXA KK+9,2     L 0 IN XRB
       REM            
PR4    LXA K+1,1      L 24 IN XRA
       LNT 100000     INDICATOR POSITION 2 ON
       TRA *+2        NO
       TRA PR4A       YES
       LNT 2000       INDICATOR POSITION 7 ON
       TRA *+2        NO
       TRA PR4A       YES
       CAL MASK+1     MASK
       TRA *+2        TIMING
PR4A   CAL MASK+2     SECTION
       OCT            OF
       TIX *-1,1,2    IMAGE
       REM            
*CONVERT TIMING TO DECIMAL AND INSERT
*IN THE CORRECT PRINT IMAGE
       REM            
       LNT 100000     INDICATOR POSITION 2 ON
       TRA *+2        NO
       TRA PR4B       YES
       LNT 2000       INDICATOR POSITION 7 ON
       TRA *+2        NO
       TRA PR4B       YES
       CLA K1+12      L HTR KK+5
       STA PR5        
       CLA K1+14      L HTR K+2
       STA PR5+1      
       STA PR5+5      
       CLA K0+18      L CLA BIT+8,1
       STO PR6-1      
       TRA PR5        
       REM            
PR4B   CLA K1+13      L HTR KK+6
       STA PR5        
       CLA K1+15      L HTR K+4
       STA PR5+1      
       STA PR5+5      
       CLA K0+17      L CLA BIT+7,1
       STO PR6-1      
       REM            
PR5    LXA 0,1        L 4 OR 3 IN XRA
       CLA            L 10 TO 4TH OR 3RD
       SUB KK+10      L +1
       XCA            10 TO POWER MINUS 1 TO MQ
       CLA P+5        TIME IN OCTAL
       DVP            DIV BY 10 TO 4TH OR 3RD
       MPY K0+8       MPY BY 10 DECIMAL
       ALS 1          DOUBLE THE VALUE
       PAX 0,4        PUT ACC IN XRC
       OCT            L BIT
PR6    OCT            BIT TO PRINT IMAGE
       TIX PR5+6,1,1  
       REM            
       TRA TT+6,2     TO TRANSFER TABLE
       REM            
TT     TRA PI         TIME BETWEEN SEL-RCHA
       TRA PI1        TIME BETWEEN WORDS
       TRA PI2        TIME BETWEEN ROWS
       TRA PI3        TIME BETWEEN RECORDS
       TRA PI4        TIME BETWEEN 12R-EOR
       TRA PI5        TIME BETWEEN 12 R-SELECT
       TRA PI6        CARD READER SPEED
       REM            
       REM PRINT ROUTINES
       REM            
PI     WPRA           
       SPRA 3         
       WPRA           
       RCHA CW2       
       TRA 0          
       REM            
PI1    WPRA           
       SPRA 3         
       RCHA CW3       
       TRA 0          
       REM            
PI2    WPRA           
       SPRA 3         
       RCHA CW4       
       TRA 0          
       REM            
PI3    WPRA           
       SPRA 3         
       WPRA           
       RCHA CW5       
       TRA 0          
       REM            
PI4    WPRA           
       SPRA 3         
       RCHA CW6       
       TRA TIME          
       REM            
PI5    WPRA           
       SPRA 3         
       RCHA CW7       
       TRA 0          
       REM            
PI6    WPRA           
       SPRA 3         
       RCHA CW8       
       TRA 0          
       REM            
PI7    WPRA           
       SPRA 3         
       RCHA CW11      
       TRA MP         
       REM            
PI8    WPRA           SELECT PRINTER TO PRINT
       SPRA 3         
       RCHA CW12      PASS COMPLETE
       TRA 1,4       
       REM            
       REM PRINT IMAGES
       REM            
IMAG   OCT 10100000020      9 L
       OCT 0                9 R
       OCT 0                8 L
       OCT 10000400000      8 R
       OCT 20000000000      7 L
       OCT 0                7 R
       OCT 400000           6 L
       OCT 0                6 R
       OCT 22344212         5 L
       OCT 3400000000       5 R
       OCT 107040000100     4 L
       OCT 100000040000     4 R
       OCT 201002001        3 L
       OCT 220200400000     3 R
       OCT 4010004          2 L
       OCT 20000            2 R
       OCT 40000000400      1 L
       OCT 4000000000       1 R
       OCT 22201410005      0 L
       OCT 7220000          0 R
       OCT 105040042220     11L
       OCT 203200040000     11R
       OCT 50126304512      12L
       OCT 134400400000     12R
       OCT 22044004004      9 L
       OCT 400100000000     9 R
       OCT 0                8 L
       OCT 0                8 R
       OCT 1000             7 L
       OCT 4000000          7 R
       OCT 400010           6 L
       OCT 1000000000       6 R
       OCT 1100342020       5 L
       OCT 100450000000     5 R
       OCT 10210000000      4 L
       OCT 204020000000     4 R
       OCT 100001030101     3 L
       OCT 0                3 R
       OCT 2000000          2 L
       OCT 30000000000      2 R
       OCT 40400000200      1 L
       OCT 0                1 R
       OCT 2010101          0 L
       OCT 4000000          0 R
       OCT 22040702014      11L
       OCT 201440000000     11R
       OCT 151715065220     12L
       OCT 500130000000     12R
       REM            
IMAG1  OCT 20200004         9 L
       OCT 100000000        9 R
       OCT 0                8 L
       OCT 0                8 R
       OCT 40000000         7 L
       OCT 0                7 R
       OCT 1030             6 L
       OCT 0                6 R
       OCT 44700            5 L
       OCT 4000040000       5 R
       OCT 216100002        4 L
       OCT 2000200000       4 R
       OCT 402000           3 L
       OCT 40000020000      3 R
       OCT 10001            2 L
       OCT 100000           2 R
       OCT 100000000        1 L
       OCT 10000000000      1 R
       OCT 44403021         0 L
       OCT 7300000          0 R
       OCT 212100114        11L
       OCT 44100000000      11R
       OCT 120254602        12L
       OCT 12000060000      12R
       REM            
IMAG2  OCT 10100010         9 L
       OCT 40000000000      9 R
       OCT 0                8 L
       OCT 400000           8 R
       OCT 20000000         7 L
       OCT 0                7 R
       OCT 406              6 L
       OCT 0                6 R
       OCT 22340            5 L
       OCT 4000000000       5 R
       OCT 107040000        4 L
       OCT 2000040000       4 R
       OCT 201000           3 L
       OCT 100400000        3 R
       OCT 4001             2 L
       OCT 20000            2 R
       OCT 40000000         1 L
       OCT 10000000000      1 R
       OCT 22201403         0 L
       OCT 7220000          0 R
       OCT 105040054        11L
       OCT 44100040000      11R
       OCT 50126300         12L
       OCT 12000400000      12R
       REM            
IMAG3  OCT 202000           9 L
       OCT 210000000000     9 R
       OCT 0                8 L
       OCT 400000           8 R
       OCT 400000           7 L
       OCT 0                7 R
       OCT 10               6 L
       OCT 20000000000      6 R
       OCT 447              5 L
       OCT 100000000000     5 R
       OCT 2161000          4 L
       OCT 4000040000       4 R
       OCT 4020             3 L
       OCT 40000400000      3 R
       OCT 100              2 L
       OCT 2000020000       2 R
       OCT 1000000          1 L
       OCT 0                1 R
       OCT 444030           0 L
       OCT 2007220000       0 R
       OCT 2121001          11L
       OCT 230000040000     11R
       OCT 1202546          12L
       OCT 144000400000     12R
       OCT 2002000          9 L
       OCT 40401000000      9 R
       OCT 0                8 L
       OCT 0                8 R
       OCT 0                7 L
       OCT 0                7 R
       OCT 10               6 L
       OCT 100020000000     6 R
       OCT 441047           5 L
       OCT 204040200000     5 R
       OCT 1104400          4 L
       OCT 2000400000       4 R
       OCT 4000020          3 L
       OCT 112000000        3 R
       OCT 10100            2 L
       OCT 0                2 R
       OCT 20000            1 L
       OCT 10000000000      1 R
       OCT 4014030          0 L
       OCT 12000000         0 R
       OCT 1102001          11L
       OCT 144100400000     11R
       OCT 2461546          12L
       OCT 212061200000     12R
       REM            
IMAG4  OCT 202000044        9 L
       OCT 2200000000       9 R
       OCT 0                8 L
       OCT 400000           8 R
       OCT 400000000        7 L
       OCT 0                7 R
       OCT 10000            6 L
       OCT 4000000000       6 R
       OCT 447001           5 L
       OCT 110040000000     5 R
       OCT 2161000002       4 L
       OCT 40100040000      4 R
       OCT 4020010          3 L
       OCT 400400000        3 R
       OCT 100100           2 L
       OCT 20000            2 R
       OCT 1000000200       1 L
       OCT 200000000000     1 R
       OCT 444030010        0 L
       OCT 407220000        0 R
       OCT 2121001042       11L
       OCT 106100040000     11R
       OCT 1202546005       12L
       OCT 250240400000     12R
       REM            
IMAG5  OCT 202000030        9 L
       OCT 0                9 R
       OCT 2                8 L
       OCT 400000           8 R
       OCT 400000004        7 L
       OCT 0                7 R
       OCT 10000            6 L
       OCT 0                6 R
       OCT 447000           5 L
       OCT 105000000000     5 R
       OCT 2161000000       4 L
       OCT 40000040000      4 R
       OCT 4020001          3 L
       OCT 2600400000       3 R
       OCT 100100           2 L
       OCT 10000020000      2 R
       OCT 1000000200       1 L
       OCT 200000000000     1 R
       OCT 444030001        0 L
       OCT 10207220000      0 R
       OCT 2121001020       11L
       OCT 102000040000     11R
       OCT 1202546016       12L
       OCT 245400400000     12R
       REM            
IMAG6  OCT 2                9 L
       OCT 44100004000      9 R
       OCT 4                8 L
       OCT 400              8 R
       OCT 4000             7 L
       OCT 20000            7 R
       OCT 140              6 L
       OCT 0                6 R
       OCT 3000             5 L
       OCT 2200010040       5 R
       OCT 400              4 L
       OCT 20400200000      4 R
       OCT 10               3 L
       OCT 200000001300     3 R
       OCT 10001            2 L
       OCT 100000           2 R
       OCT 0                1 L
       OCT 101000000000     1 R
       OCT 10011            0 L
       OCT 7100400          0 R
       OCT 4100             11L
       OCT 44100224100      11R
       OCT 3446             12L
       OCT 323600011240     12R
       REM            
IMAG7  OCT 224              9 L
       OCT 100440000000     9 R
       OCT 0                8 L
       OCT 0                8 R
       OCT 1001             7 L
       OCT 20000000000      7 R
       OCT 14140            6 L
       OCT 4010000000       6 R
       OCT 20402            5 L
       OCT 10000000000      5 R
       OCT 10               4 L
       OCT 200000000000     4 R
       OCT 0                3 L
       OCT 1220000000       3 R
       OCT 0                2 L
       OCT 2000000000       2 R
       OCT 0                1 L
       OCT 40004000000      1 R
       OCT 4000             0 L
       OCT 3000000000       0 R
       OCT 31272            11L
       OCT 14010000000      11R
       OCT 505              12L
       OCT 360620000000     12R
       REM            
IMAG8  OCT 42               9 L
       OCT 204000040000     9 R
       OCT 0                8 L
       OCT 40000000         8 R
       OCT 10020000         7 L
       OCT 0                7 R
       OCT 100300           6 L
       OCT 1000000000       6 R
       OCT 5000             5 L
       OCT 110416000000     5 R
       OCT 40001            4 L
       OCT 20000000000      4 R
       OCT 212010           3 L
       OCT 101020000        3 R
       OCT 3000000          2 L
       OCT 0                2 R
       OCT 4000004          1 L
       OCT 40020004000      1 R
       OCT 3002000          0 L
       OCT 10000            0 R
       OCT 10170142         11L
       OCT 205415000000     11R
       OCT 4205215          12L
       OCT 170162220000     12R
       REM            
       REM CARD IMAGE 
       REM            
CI     OCT 0,0,0,0,0,0,0,0,0,0,0,0
       OCT 0,0,0,0,0,0,0,0,0,0,0,0
       REM            
       REM STORAGE IMAGE
       REM            
CBI    OCT 727272727272       9 L
       OCT 272727272727       9 R
       OCT 717171717171       8 L
       OCT 171717171717       8 R
       OCT 707070707070       7 L
       OCT 070707070707       7 R
       OCT 424242424242       6 L
       OCT 242424242424       6 R
       OCT 505050505050       5 L
       OCT 050505050505       5 R
       OCT 313131313131       4 L
       OCT 131313131313       4 R
       OCT 212121212121       3 L 
       OCT 121212121212       3 R
       OCT 202020202020       2 L
       OCT 020202020202       2 R
       OCT 101010101010       1 L
       OCT 010101010101       1 R
       OCT 737373737373       0 L
       OCT 373737373737       0 R
       OCT 747474747474       11L
       OCT 474747474747       11R
       OCT 757575757575       12L
       OCT 575757575757       12R
       REM            
       REM TEMPORARY STORAGE
       REM            
RDRDY  OCT 0          
SELDY  OCT 0          
WORDY  OCT 0          
ROWDY  OCT 0          
ROWD1  OCT 0          
CONDY  OCT 0          
EORDY  OCT 0          
KONDY  OCT 0          
MODL0  OCT 0          
NUM    OCT 0          
       REM            
P      OCT 0          
       OCT 0          
       OCT 0          
       OCT 0          
       OCT 0          
       OCT 0          
       REM            
SX     OCT 0          
       OCT 0          
       REM            
       REM CONTROL WORDS
       REM            
CWA    IOCT 0,0,3     S AND 2 TRIGGERS ON
       REM            
CW     IOCT CI,0,1    S AND 2 TRIGGERS ON
       IORP 0,0,0     1 TRIGGER ON
       REM            
CW1    IOCT CI,0,1    S AND 2 TRIGGERS ON  9 L
       IOCT CI+1,0,1                       9 R
       IOCT CI+2,0,1                       8 L
       IOCT CI+3,0,1                       8 R
       IOCT CI+4,0,1                       7 L
       IOCT CI+5,0,1                       7 R
       IOCT CI+6,0,1                       6 L
       IOCT CI+7,0,1                       6 R
       IOCT CI+8,0,1                       5 L
       IOCT CI+9,0,1                       5 R
       IOCT CI+10,0,1                      4 L
       IOCT CI+11,0,1                      4 R
       IOCT CI+12,0,1                      3 L
       IOCT CI+13,0,1                      3 R
       IOCT CI+14,0,1                      2 L
       IOCT CI+15,0,1                      2 R
       IOCT CI+16,0,1                      1 L
       IOCT CI+17,0,1                      1 R
       IOCT CI+18,0,1                      0 L
       IOCT CI+19,0,1                      0 R
       IOCT CI+20,0,1                      11L
       IOCT CI+21,0,1                      11R
       IOCT CI+22,0,1                      12L
       IOCT CI+23,0,1                      12R
       IORT CI+23,0,1  1 AND 2 TRIGGERS ON 12R
       REM            
CW2    IOCD IMAG,0,48 ALL TRIGGERS OFF
CW3    IOCD IMAG1,0,24 
CW4    IOCD IMAG2,0,24 
CW5    IOCD IMAG3,0,48 
CW6    IOCD IMAG4,0,24 
CW7    IOCD IMAG5,0,24 
CW8    IOCD IMAG6,0,24 
CW9    IOCT CI,0,24   S AND 2 TRIGGERS ON
CW10   IOCD CI,0,24   ALL TRIGGERS ON
CW11   IOCD IMAG7,0,24 
CW12   IOCD IMAG8,0,24 
       REM            
       REM            
       REM CONSTANTS  
       REM            
K0     OCT 4360       
       OCT 10         
       OCT 511
       OCT 503
       OCT 622
       OCT 52         
       OCT 11070 
       OCT 576714
       OCT 12         
       OCT 144        
       OCT 244040
       OCT 140        
       OCT 374        
       OCT 154        
       OCT 60         
       OCT 16         
       HTR K0+9       
       CLA BIT+7,1    
       CLA BIT+8,1    
       OCT 2607       
       REM            
KK     OCT -11        
       OCT -10        
       OCT -7         
       OCT -6         
       OCT -5         
       OCT -4         
       OCT -3         
       OCT -2         
       OCT -1         
       OCT -0         
       OCT 1          
       OCT 0          
       REM            
K      OCT 30         
       OCT 24         
       OCT 23420      
       OCT 454        
       OCT 1750       
       REM            
K1     TRA TIME-1     
       HTR P          
       ORS IMAG+19,4  
       ORS IMAG1+19,4 
       ORS IMAG2+19,4 
       ORS IMAG3+19,4 
       ORS IMAG4+19,4 
       ANS IMAG+21,1  
       ANS IMAG1+21,1 
       ANS IMAG2+21,1 
       ANS IMAG3+21,1 
       ANS IMAG4+21,1 
       HTR KK+5       
       HTR KK+6       
       HTR K+2        
       HTR K+4        
       ANS IMAG5+21,1 
       ORS IMAG5+19,4 
       ANS IMAG6+21,1 
       ORS IMAG6+19,4 
       REM            
BIT    OCT 200000000000
       OCT 100000000000
       OCT 000400000000
       OCT 000200000000
       OCT 000004000000
       OCT 000002000000
       OCT 000001000000
       OCT 000000200000
       REM            
MASK   OCT 477177777777
       OCT 777770477777
       OCT 777770777777
       REM            
IOCTL  OCT 000000100001 CONTROL WORD FOR CHAN A
       OCT 777777074000
       TRA TIME       
       REM            
CTRL1  EQU 2880       
CTRL2  EQU 2881       
CTRL3  EQU 2882       
IOCT   EQU 2883       
CTX    EQU 2890       
IOC    EQU 2892       
ERROR  EQU 3396       
WDNO   EQU 3438       
RECNO  EQU 3439       
       REM            
       END            
