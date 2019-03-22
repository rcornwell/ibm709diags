*                                                           9 I O T A       
*                                                           8-15-59
       REM
       REM
       REM
       REM
*              9 I O T A
       REM
*      709 INPUT-OUTPUT TRAP DIAGNOSTIC TEST
       REM
       REM
       REM
       REM
       ORG 24
       REM
       NOP
       SWT 3         CHECK SENSE SWITCH 3
       TRA *+2       UP - PRINT TEST IDENTITY
       TRA *+11      DN - BYPASS PRINT
       REM
       TSX SPLAT,4
       MZE 8,0,1
       BCD 6NOW PERFORMING DIAGNOSTIC I-O TRAP T
       BCD 2EST  9IOT
       REM
       REM
****************************************************************************
       REM
       REM
*                   I N I T I A L I Z A T I O N
       REM
       REM
CBEGN  TSX IOC,4     TO ENTER CONTROL WORDS
       REM
       AXT 3,2       L +3 IN XRB
       AXT 6,1       L +6 IN XRA
       PXD 0,0       CLEAR ACC
       CAL CTRL1+3,2 L DS CONTROL WORD
       ANA SK+4      CLEAR TO CARD MACHINES
       NZT CTRA+6,1
       TRA *+2       ZERO - NO TAPE CALLED
       ORA SCH+6,1   OR IN EXCLUSIVE UNIT 2
       NZT CTRA+7,1
       TRA *+2       ZERO - NO TAPE CALLED
       ORA SCH+7,1   OR IN EXCLUSIVE UNIT 2
       SLW CTRL1+3,2 SAVE ADJUSTED CONTROL WORD
       TIX *+1,2,1
       TIX *-11,1,2
       REM
       REM
       REM
RUC    TSX IOCNT,4
       REM
INTL   CLA CTRL1     L CHANNEL A CONTROL
       TPL *+3       CHECK IF PROGRAM READ
       REM           FROM CARDS
       CLA SK1+1     YES - L READ CARDS
       TRA *+2
       CLA SK1       NOT READ FROM CARDS
       REM           L READ TAPE
       STO FINL1
       REM
       REM
INTL1  NZT CTRA      CHECK FOR TAPE UNIT ON A
       TRA SCTX      NO UNIT ON CHN A
       CLA CX+3      UNIT ON CHAN A - L SELECT
       CAS SK        COMPARE WTBA 2
       TRA *+2       NOT SAME - ADJUST
       TRA *+8       UNIT ADDR OK - PROCEED
       TSX SCAN,4    GO TO SET SCAN ROUTINE
       PZE CX+3      LOC OF SELECT FOR SCAN
       TSX CTX,4     GO TO ADJUST PROGRAM 
       PZE ALF,0,OMG SEARCH AREA
       TSX SCAN1,4   GO TO SCAN FOR TSX SCHCK,4
       PZE ALF,0,OMG SEARCH AREA
       TRA *-10
       NOP
       REM
SAC    CLA IOCT      L UNIT COUNT
       TZE CZIB-8    ALL UNITS CALLED CHECKED
       REM           FOR SINGLE CHN OPERATION
ALF    SUB ONE       L+1
       STO IOCT
       TRA *+2
       STL SKIP1     MANUAL ENTRY TO HALT
       REM           ROUTINES
       REM
SAA    CLA STRA1     L TRA SSA
       STO 0         POST RESTART
       REM
       TSX SETUP,4
       TRA DW
       REM
       REM
SETUP  TCOA *        WAIT FOR END OPN
       ENB ZEROS     ALL CHANNELS DISABLED
       WTBA 2        RESET TRAP
       TCOA *        DELAY
       TRCA *+1      TURN OFF RDNCY CK
       TEFA *+1      TURN OFF EOF
       IOT           TURN OFF IOT
       NOP
       TRA 1,4       RETURN
       REM
       REM
*    SINGLE CHANNEL OPERATIONS
       REM
       REM
       REM
DW     TSX RESET,4   SET MONITOR
       NZT SKIP1
       TRA CK	    SKIP HALT TESTS
       REM
       REM
*ON FIRST PASS TEST THE HALT INSTRUCTION AND
*FOR ALL SUCCEEDING PASSES TRANSFER ARROUND THIS SECTION TO SYMBOLIC LOCATION
*CK
       REM
       REM
*CHECK THAT THE MACHINE IS ABLE TO TRAP CORRECTLY BEFORE
*A HALT INSTRUCTION IS DECODED
*IT IS NECESSARY TO ONLY TEST ONE TYPE OF HALT IN THIS SECTION
       REM
       REM
       TSX SREST,4   FOR RESET ONLY
       ENB CNA       SET UP COMMAND TRAP
       WTBA 2
       RCHA CNTL     WRITE 1 WORD WITH AN IOCT
       REM
       TCOA *        SHOULD TRAP HERE
       REM
       TRA *+2
       REM
       HTR DW        ERROR-DID NOT RETURN
       REM           FROM TRAP CORRECTLY.
       REM
       AXT CNA,2
       TSX SCHCK,4,1 CHECK TRAP EXECUTION
       PZE *-5,0,1
       REM
       TRA *+3       OK-TRAPPED CORRECTLY
       TSX SPLAT,4
       PZE A
       REM
       REM
*CHECK THAT THE MACHINE WILL HALT + NOT TRAP WHEN NOT ENABLED.-SYSTEMS 4.05.01
*THIRD LEF OF AND CKT. 1034N WILL PREVENT THE MASTER STOP TRIGGER FROM
*BEING TURNED OFF UNTIL THE START BUTTON IS DPRESSED.
*IT IS NECESSARY TO ONLY TEST ONE TYPE OF HALT IN THIS SECTION.
       REM
       REM
       ENB ZEROS    ALL CHANNELS DISABLED
       WTBA 2
       RCHA CNTL    WRITE 1 WORD WITH AN IOCT
       REM
       HPR          PRESS START-SHOULD
       REM          NOT HAVE TRAPPED HERE.
       REM
       AXT CNA,2
       TSX SCHCK,4,1 CHECK TRAP EXECUTION.
       PZE *-4,2,1
       REM
       TRA DW1       OK - DID NOT TRAP
       REM
       TSX SPLAT,4
       PZE B
       REM
       REM
       REM
*CHECK THAT THE MACHINE IS ABLE TO TRAP CORRECTLY ONE INSTRUCTION
*BEFORE HTR IS DECODED.
*IT IS NECESSARY TO ONLY TEST ONE TYPE OF HALT IN THIS SECTION.
       REM
       REM
DW1    TSX SETUP,4   RESET I/O TRIGGERS
       ENB CNA       ENABLE FOR COMMAND TRAP
       WTBA 2
       RCHA CNTL     WRITE 1 WORD WITH AN IOCT
       REM
       TCOA *        SHOULD TRAP HERE
       REM
       HTR *+2       OK-PRESS STARTT
       REM
       HTR DW1       ERROR-DID NOT RETURN
       REM           FROM TRAP CORRECTLY.
       REM
       AXT CNA,2
       TSX SCHCK,4,1 CHECK TRAP EXECUTION
       PZE *-5,0,1
       TRA *+3       OK-TRAPPED CORRECTLY
       REM
       TSX SPLAT,4
       PZE C
       REM
       REM
       REM
       REM
*CHECK THAT THE MACHINE WILL TRAP ON A HTR INSTRUCTION
       REM
       REM
DW2    ENB CNA       ENABLE FOR COMMAND TRAP
       WTBA 2
       RCHA CNTL     IOCT-WC1
       NOP           SHOULD NOT COME BACK FOR
       REM           LCH FOR APPROXIMATELY 36 US
       REM
       HTR *+2       SHOULD TRAP HERE AND
       REM           RETURN HERE.-PRESS START
       REM
       HTR DW2       ERROR-DID NOT RETURN
       REM           FROM TRAP CORRECTLY
       REM
       AXT CNA,2
       TSX SCHCK,4,1 CHECK TRAP EXECUTION.
       PZE *-4,0,1
       REM
       TRA *+3        OK-TRAPPED CORRECTLY
       REM
       TSX SPLAT,4
       PZE D
       REM
       REM
*CHECK THAT MACHINE LEAVES THE TRAP MODE ON RESET.
       REM
       REM
       CLA RF2       L TRA DW6+2
       STO 0
DW6    ENB CNA	    ENABLE FOR COMMAND TRAP
       HTR *+1       RESET MACHINE + START
       REM
       WTBA 2
       RCHA CNTL     IOCT-WC1
       REM
       TCOA *        SHOULD NOT TRAP HERE
       REM
       AXT CNA,2
       TSX SCHCK,4,1 CHECK FOR NO TRAP
       PZE *-3,2,1
       REM
       TRA *+3       OK-DID NOT TRAP
       REM
       TSX SPLAT,4
       PZE H
       REM    
       REM    
       REM    
       REM    
*CHECK THAT IT IS POSSIBLE TO ENABLE AND TRAP AFTER THE MACHINE HAS BEEN RESET.
       REM
DW7    TSX SETUP,4
       ENB CNA       ENABLE FOR COMMAND TRAP
       WTBA 2
       RCHA CNTL     IOCT-WC1
       REM
       TCOA *        SHOULD TRAP HERE AND
       REM           RETURN HERE
       REM
       AXT CNA,2
       TSX SCHCK,4,1 CHECK TRAP EXECUTION
       PZE *-3,0,1
       REM
       TRA *+3       OK-TRAPPED CORRECTLY
       REM
       TSX SPLAT,4
       PZE J
       REM
       REM
       REM
*CHECK THAT THE MACHINE CANNOT BE IN MANUAL STATUS IN ORDER
*TO TRAP ON A HALT INSTRUCTION.
*SYSTEMS 4.05.01-AND CKT. 1034N-CANNOT TURN OFF MST IN MANUAL.
*IT IS NECESSARY TO ONLY TRST ONE TYPE OF HALT IN THIS SECTION.
       REM
       REM
DW8    HTR *+1       PUT MACHINE IN MANUAL
       REM           STATUS AND PUSH SINGLE
       REM           STEP BUTTON TWICE
       REM
       ENB CNA       ENABLE FOR COMMAND TRAP
       WTBA 2
       RCHA CNTL     IOCT-WC1
       REM
       HTR *+1       SHOULD NOT TRAP UNTIL
       REM           START * SINGLE STEP ARE
       REM           DEPRESSED THREE TIMES.
       REM           AFTER TRAPPING THE PROGRAM
       REM           AGAIN MUST RETURN TO AUTO
       REM           AND PRESS START AFTER 2NO
       REM           HALT AT THIS LOCATION
       REM
       REM
       AXT CNA,2
       TSX SCHCK,4,1 CHECK FOR TRAP
       PZE *-3,0,1
       REM
       TRA *+3       OK-TRAPPED CORRECTLY
       REM
       TSX SPLAT,4
       PZE K
       REM
       REM
       TSX OK,4
       TRA DW
       REM
       REM
       REM
       BCD 1SCHA
       REM
CK     TSX CLEAR,4   CHECK SEQUENCE
       STZ SKIP1     SET SKIP CHECK
       REM
       WTBA 2
       RCHA CRTB2    NO INDS ON WC 2
       SCHA CSAVE    STORE DSC RESGISTERS
       REM
       CLA CSAVE     INFORMATION FROM DSC
       LDQ CCC       CORRECT INFO.
       CAS CCC
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP CK
       REM
       TCOA *        WAIT
       SCHA CSAVE    STORE CHANNEL INFO.
       CLA CSAVE     INFORMATION FROM DSC
       LDQ CCC1      CORRECT DATA
       CAS CCC1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       REM
       NOP CK
       TSX OK,4
       TRA CK
       NOP
       REM
*CHECK THAT THE MACHINE WILL TRAP ON A HPR INSTRUCTION.
       REM
       REM
DW3    TSX CLEAR,4
       TSX SETUP,4   RESET I/O TRIGGERS
       ENB CNA       ENABLE FOR COMMAND TRAP
       WTBA 2
       RCHA CNTL     IOCT-WC1
       NOP           SHOULD NOT COME BACK FOR
       REM           LCH FOR APPROXIMATELY 36 US
       REM
       HPR           SHOULD TRAP HERE AND
       REM           RETURN HERE, AND CONTINUE
       REM           WITHOUT HALTING
       REM
       AXT CNA,2
       TSX SCHCK,4,1 CHECK TRAP EXECUTION.
       PZE *-2,0,1
       REM
       TRA *+3       OK-TRAPPED CORRECTLY
       REM
       TSX SPLAT,4
       PZE E
       REM
       REM
       REM
*CHECK THAT THE MACHINE WILL TRAP ON A DVH INSTRUCTION.
       REM
       REM
DW4    ENB CNA       ENABLE FOR COMMAND TRAP
       WTBA 2
       RCHA CNTL     IOCT-WC1
       NOP           SHOULD NOT COME BACK FOR
       REM           LCH FOR APPROXIMATELY 36 US
       REM
       DVH ZEROS     SHOULD TRAP HERE AND
       REM           RETURN HERE, AND CONTINUE
       REM           WITHOUT HALTING
       REM
       AXT CNA,2
       TSX SCHCK,4,1 CHECK TRAP EXECUTION.
       PZE *-2,0,1
       REM
       TRA *+3       OK-TRAPPED CORRECTLY
       REM
       TSX SPLAT,4
       PZE F 
       REM
       REM
       DCT           TURN OFF DIV. CK. LITE
       TRA *+2
       HTR *+1       DID NOT TURN ON CK LIGHT
       REM
       TSX OK,4
       TRA DW3
       REM
       REM
*THIS SECTION TEST ALL COMBINATIONS OF INDICATORS TO MAKE
*SURE THEY OPERATE CORRECTLY BEFORE USING INDICATOR 18
       REM
*ONE ERROR WILL CAUSE OTHER. IGNORE ALL ERRORS, EXCEPT FIRST
       REM
       REM
       BCD 1SCHA
       REM
CL     TSX CLEAR,4
       TSX SETUP,4
       WTBA 2        USE ALL COMBINATIONS
       RCHA CFCTL    OF INDICATIORS WITH
       REM           ON RESET LOAD CHANNEL
       SCHA CSAVE    STORE CHANNEL DATA
       CLA CSAVE     BRING IN CHANNEL INFO.
       LDQ CHECK     CORRECT CONTENTS
       CAS CHECK
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP CL
       REM
       LCHA CFCTL+6  IOST-WC 2
       SCHA CSAVE    STORE CONTENTS DSC
       CLA CSAVE     CONTENTS DSC
       LDQ CHECK+1   CORRECT CONTENTS
       CAS CHECK+1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP CL
       REM
       LCHA CFCTL+7  IORT-WC 2
       SCHA CSAVE    STORE CONTENTS DSC
       CLA CSAVE     CONTENTS DSC
       LDQ CHECK+2   CORRECT CONTENTS
       CAS CHECK+2
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP CL
       REM
       LCHA CFCTL+8  IOCD-WC 2
       SCHA CSAVE    STORE CONTENTS DSC
       CLA CSAVE     CONTENTS DSC
       LDQ CHECK+3   CORRECT CONTENTS
       CAS CHECK+3
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP CL
       REM
       TCOA *        WAIT
       SCHA CSAVE    STORE CONTENTS DSC
       CLA CSAVE     CONTENTS DSC
       LDQ CHECK+4   CORRECT CONTENTS
       CAS CHECK+4
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4
       NOP CL
       TSX OK,4
       TRA CL
       REM
       BCD 1IND 19
       REM
CM     TSX CLEAR,4   CHECK SEQUENCE
       WTBA 2
       RCHA CWTB6    IOCD-WC3
       BSRA 2        BACKSPACE RECORD
       RTBA 2
       RCHA CRTB6    IND 19 ON - WC 2
       STZ CREAD     CLEAR
       STZ CREAD+1   READ AREA
       AXT 0,2
       AXT 2,1       SET
       CLA ONE       UP
       STO RECNO     FOR
       PXA ,1        PRINT
       ADD ONE       ROUTINE
       STO WDNO
       TCOA *	    WAIT
       REM
       CLA CREAD+2,1 WORD READ
       LDQ ZEROS     CORRECT WORD
       CAS ZEROS
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4
       NOP CM
       TIX *-7,1,1   CHECK BOTH WORDS
       REM
       TSX OK,4      OF REPEAT
       TRA CM
       REM
       REM
*THIS ROUTINE WILL RCH WITH NO SELECT TO INITIALLY
*CHECK IND 18 BEFORE MOVING TAPE
       REM
       REM
       BCD 1IND18
CHUMP  TSX CLEAR,4
       REM
       RCHA CHIPS    TCH AND IND 18
       SCHA CSAVE
       CLA CSAVE     INFO FROM CHANNEL
       REM
       LDQ CK1+5     CORRECT INFO
       CAS CK1+5
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD HAVE TAKEN ONLY
       NOP CHUMP     ONE IA CYCLE BEFORE DISC
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT           CHECK IOT
       TRA *+3       OK
       TSX ERROR-1   IOT LIGHT SHOULD BE OFF
       TXL *-3
       REM
       REM
*THIS SECTION WILL CHECK IND 18 AND TCH IN FIRST CONTROL WORD
*TO BE SURE A BCW AND A BDW CYCLE ARE NOT TAKEN AT THE SAME TIME
       REM
       REM
       WTBA 2
       RCHA CHIPS    TCH AND IND 18 TO IOCT-WC2
       SCHA CSAVE
       CLA CSAVE
       LDQ CK1+6     CORRECT CONTENTS
       CAS CK1+6
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4 SHOULD HAVE TAKEN ON IA
       NOP CHUMP     CYCLE, ONE BCW CYCLE, AND
       TRA CN        ONE BDW CYCLE, BEFORE
       REM           SCH SHOULD GET IN
       REM
       BSRA 2        BACKSPACE THE RECORD
       RTBA 2
       RCHA CIOC+4   ICOD-WC2
       AXT 2,1       CLEAR
       STZ CREAD+2   READ
       TIX *-1,1,1   AREA
       REM
*SET CONSTANTS FOR PRINT ROUTINE
       REM
       AXT 2,1
       PXA 0,1
       ADD ONE
       STO WDNO
       AXT 0,2
       CLA ONE
       STO RECNO
       TCOA *
       REM
       CLA CREAD+2,1 WORD READ
       LDQ CWRIT+2,1 CORRECT WORD
       CAS CWRIT+2,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4 ERROR HERE MIGHT MEAN
       NOP CHUMP     THAT BCW AND BDW
       TIX *-7,1,1   CYCLES CAME AT SAME
       REM           TIME DURING WRITE
       TSX OK,4
       TRA CHUMP
       REM
       REM
*THIS ROUTINE CHECKS IND 18 WITH ALL CONBINATIONS OF OTHER INDICATORS
       REM
*ONE ERRROR WILL CAUSE OTHER, DISREGARD ALL ERRORS, EXCEPT THE FIRST
       REM
       REM
       BCD 1IND 18
       REM
CN     TSX CLEAR,4    CHECK SEQUENCE
       WTBA 2
       RCHA CFCTL+8   IOCD-WC2
       BSRA 2         BACKSPACE 1 RECORD
       RTBA 2
       RCHA CID18     TEST INDICATOR 18
       AXT 14,1       CLEAR
       STZ CRDFD+14,1 READ
       TIX *-1,1,1
       TCOA *         WAIT
       REM
       AXT 2,1
       CLA CRDFD+2,1  WORD READ
       LDQ CWRIT+14,1 CORRECT WORD
       CAS CWRIT+14,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       NOP CN
       TIX *-7,1,1    CHECK ALL WORDS
       REM
       TSX OK,4
       TRA CN
       REM
       BCD 1IND 18
       REM
CP     TSX CLEAR,4
       WTBA 2
       RCHA CRUD      IORP-WC6
       BSRA 2         BACKSPACE
       BSRA 2         THREE
       BSRA 2         RECORDS
       RTBA 2
       RCHA CID
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK1        CORRECT CONTENTS
       CAS CK1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CP
       REM
       LCHA CID+6     IND 18-IOST
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK1+1      CORRECT CONTENTS
       CAS CK1+1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CP
       REM
       LCHA CID+7     IND 18-IORT
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK1+2      CORRECT CONTENTS
       CAS CK1+2
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CP
       REM
       LCHA CID+8     IND 18-IOCD
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK1+3      CORRECT CONTENTS
       CAS CK1+3
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CP
       REM
       TCOA *         WAIT
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK1+4      CORRECT CONTENTS
       CAS CK1+4
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CP
       REM
       AXT 6,1
       AXT 3,2
       PXA ,1         TO
       ADD ONE        SET UP
       STO WDNO       PRINT
       PXA ,2         ROUTINE
       ADD ONE
       STO RECNO
       REM
       CLA CRDFD+6,1  WORD READ
       LDQ CWRIT+6,1  CORRECT WORD
       CAS CWRIT+6,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       NOP CP
       TIX *-7,1,1
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
       AXT 6,1
       CLA CRDFD+12,1 WORD READ
       LDQ CWRIT+12,1 CORRECT WORD
       CAS CWRIT+12,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       NOP CP
       TIX *-7,1,1
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
       AXT 2,1
       CLA THREE      L +3
       STO WDNO
       CLA CRDFD+14,1 WORD READ
       LDQ CWRIT+14,1 CORRECT WORD
       CAS CWRIT+14,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       NOP CP
       TIX *-7,1,1
       TSX OK,4
       TRA CP
       REM
       REM
*THIS ROUTINE WILL TEST ALL COMBINATIONS OF
*INDICATORS, WITH IND 18 AND 19
       REM
*ONE ERROR WILL CAUSE OTHERS. DISREGARD ALL ERRORS EXCEPT THE FIRST
       REM
       REM
       BCD 1IND 19
       REM
CQ     TSX CLEAR,4
       WTBA 2
       RCHA CRUD      IORP-WC6
       BSRA 2         BACKSPACE
       BSRA 2         THREE
       BSRA 2         RECORDS
       RTBA 2
       RCHA IND19
       SCHA CSAVE     STORE CONTENTS DSC
       REM
       AXT 14,1       CLEAR
       STZ CRDFD+14,1 READ
       TIX *-1,1,1    AREA
       REM
       CLA CSAVE      CONTENTS DSC
       LDQ CK2        CORRECT CONTENTS
       CAS CK2
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CR
       REM
       LCHA IND19+6  
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK2+1      CORRECT CONTENTS
       CAS CK2+1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CR
       REM
       LCHA IND19+7  
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK2+2      CORRECT CONTENTS
       CAS CK2+2
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CR
       REM
       LCHA IND19+8  
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK2+3      CORRECT CONTENTS
       CAS CK2+3
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CR
       REM
       TCOA *         WAIT
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK2+4      CORRECT CONTENTS
       CAS CK2+4
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP CR
       REM
       TSX OK,4
       TRA CQ
       REM
       BCD 1SCHA
       REM
CR     TSX CLEAR,4    SEQUENCE
       WTBA 2
       RCHA CCCC
       NOP
       SCHA CSAVE     STORE CONTENTS DSC
       CLA CSAVE      CONTENTS DSC
       LDQ CK3        CORRECT CONTENTS
       CAS CK3
       TRA *+2        ERROR
       TRA *+4        OK
       SLN 1
       TSX ERROR-1,4
       NOP CR
       REM
       SLT 1          IF LIGHT IS ON-ERROR
       TRA *+3        OK-OFF
       TSX SPLAT,4
       PZE L
       REM
       TSX OK,4
       TRA CR
       REM
       REM
*TEST FP TRAP OUT OF MODE
       REM
       REM
       BCD 1FAD-
       REM
CS     TSX PART2,4    TURN ON LITE 4-CLAEAR
       CLA CTTR1      L TRA SEQ
       STO 8
       AXT CT,1       RETURN ADDRESS
       SXA SECT2,1    STORE RETURN ADDRESS
       CLA CCNST      L 003304725371
       FAD CCNST+1    L 035015665047
       REM
       STQ CSAVE      SAVE MQ
       CAS CCNST+2    L 030673242370
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ CCNST+2    L 030673242370
       TSX ERROR-1,4
       NOP CS
       REM
       XCA
       CAS CCNST+3    L 375472537200
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ CCNST+3    L 375472537200
       TSX ERROR-1,4
       NOP CS
       REM
       TRA *+2
       REM
       BCD 1FP TRP
       REM
       CLA 0         TRAP ADDRESS
       CAS CBIT      CORRECT CONTENTS 0
       TRA *+2       ERROR
       TRA *+4       OK
       LDQ CBIT      CORRECT CONTENTS 0
       TSX ERROR-1,4
       NOP *-6
       TSX OK,4
       TRA CS
       REM
       REM
*TEST STR OUT OF I/O TRAP MODE
       REM
       REM
       BCD 1STR-
       REM
CT     TSX CLEAR,4
       CLA CTTR       L TTR CT+4
       STO 2
       STR
       CLA 0          TRAP ADDRESS
       CAS CBIT1
       TRA *+2        ERROR
       TRA *+3        OK
       LDQ CBIT1
       TSX ERROR,4
       TSX OK,4
       TRA CT
       REM
       REM
*     -----------------       *
*-----ENTER DS TRAP MODE------*
*     -----------------       *
       REM
*     SET IN DS TRAPPING MODE AND TEST THAT STR INSTRUCTION PREFORMS
*     CORRECTLY . CHECK BOTH STORE AND TRAP FUNCTIONS OF STR OPERATION
       REM
       REM
       BCD 1STR
       REM
PNABL  TSX CLEAR,4     SET MONITOR
       ENB CNA+8       SET IN MODE
       REM
PSET   AXT 23,1
       CLA PP2         L TRA P2
       STO 24,1
       TIX *-1,1,1
       STZ 0
       CLA PP3         L TRA P3
       STO 2
       REM
       REM
*      CHECK STR CORRECT EXECUTION IN MODE
*      -----------------------------------
       REM
       STR 
P1     TRA P2
       REM
*      SHOULD NEVER ENTER HERE, BUT IF WE SHOULD
*      CHECK FOR STORE WHEN FAIL TO TRAP TO 2
       REM
P2     CLA 0
       ANA P7777       AND IN ADDRESS
       CAS PZR         L P1
       TRA *+2
       TRA P4          STR STORED OK
       REM             BUT FAILED TO TRAP
       TSX ERROR-1,4   STR FAILED TO STORE OR
       TXL PNABL       TRAP TO LOC 2
       REM
       REM
*      SHOULD ENTER HERE AFTER STR INSTRUCTION AT PSTR + 1.
*      IF SO, CHECK STR FOR STORE AND TRAP TO 2
       REM
P3     CLA 0
       CAS PZR         L P1
       TRA *+2         ERROR
       TRA P4          OK STORE AND TRAP 2
       REM
       REM
       TSX ERROR-1,4   STR TRAPPED OK BUT
       TXL PNABL       FAILED TO STORE
       REM
*      CHECK LOCATIONS 1,3-27 NOT INTERFERRED BY STR
*      WHEN IN DS TRAP MODE
       REM
P4     AXT 20,1
       CLA 1           SHOULD BE TRA TO P2
       CAS PP2         L TRA P2
       TRA *+2
       TRA P4A
       REM
       REM
       TSX ERROR-1,4   STR STORED AT LOC 1
       TXL PNABL
       REM
P4A    CLA PP2         L TRA TO P2
       CAS 23,1
       TRA *+2
       TRA P4B         OK
       REM
       REM
       TSX ERROR-1,4   STR INTERFERRED WITH
       TXL PNABL       SOME LOC 3-27
       REM
P4B    TIX P4A+1,1,1
       REM
       TSX OK,4
       TRA PNABL
       REM
*      CHECK FLOATING POINT TRAP IN MODE WITH NO I-O TRAPS
*      ---------------------------------------------------
       REM
       BCD 1FAD-       TEST INSTRUCT
P5     TSX PART2,4
       AXT 23,1
       CLA PP6         L TRA P6
       STO 24,1        SET ERROR TRA
       TIX *-1,1,1
       STZ 0
       CLA PP7         L TRA P7
       STO 8          SET CORRECT TRA
       REM
*      ENTER FLOATING POINT TRAP ROUTINE
*      SHOULD ALWAYS TRAP
       REM
P5A    CLA CCNST      L ACC FP NO
       FAD CCNST+1    L SR FP NO
       REM
*      DID NOT TRAP TO 10 CHECK CONTENTS OF 0
       REM
P6     CLA 0
       ANA P7777      AND IN ADDRESS
       CAS PP57       L FP ANS
       TRA *+2        ERROR
       TRA P6A        CONTENTS 0 OK
       REM
       REM
       TSX ERROR-1,4  FAD FAILED TO TRAP AND
       TXL P5         STORE AT LOC 0
       REM
       TRA P8         SKIP TO CHECK INTERFERE
       REM
P6A    TSX ERROR-1,4  FAD FAILT TO TRAP, BUT
       TXL P5         STORED AT LOC 0
       TRA P8         PIGGY-BACK LEAP-FROG
       REM
*      SHOULD ENTER HERE AFTER FAD TRAP TO 10
*      TRAPPED TO 10 OK CHECK STORE AT 0
       REM
P7     CLA 0
       ANA P7777      AND IN ADDRESS
       CAS P5BB       
       TRA *+2        ERROR ON STORE 0
       TRA P8         OK ON TRAP AND STORE
       REM
       REM
       TSX ERROR-1,4  FAD TRAPPED OK, BUT FAILED
       TXL P5         STORE AT LOC 0
       REM
*      CHECK LOCATIONS 1-7, 11-27 NOT INTERFERRED
*      BY FAD TRAP WHEN IN DS TRAP MODE
       REM
P8     CLA PP6        L TRA P6
       STO 8
       AXT 23,1
P8A    CAS 24,1
       TRA *+2        ERROR
       TRA P8B        OK
       REM
       REM
       TSX ERROR-1,4  FAD INTERFERRED WITH
       TXL P5         SOME LOC 1-27
       CLA PP6        L TRA P6
       REM
P8B    TIX P8A,1,1
       REM
       REM
       TSX OK,4
       TRA P5
       REM
*      ZERO LOCATION 1-27
       REM
       BCD 1LDQ
PLDQ   TSX CLEAR,4
       AXT 23,1
P9     STZ 24,1
       TIX P9,1,1
       REM
*      CHECK THAT ENABLE INSTRUCTION DOES NOT
*      ACT AS LDQ INSTRUCTION SINCE THEIR
*      OPERATIONS CODE DIFFER IN ONLY ONE POSITION
*      LDQ BEING 0560 AND ENABLE 0564
       REM
*      --------------------------------------
       LDQ ZEROS       L 0
       ENB CNA         ENABLE FOR COMMAND TRAP
       PXD 0,0         CLEAR ACC
       XCA             MQ TO ACC FOR CHECK
       TZE P10
       REM
       REM
       TSX ERROR,4     ENABLE ACTED AS LDQ
P10    TSX OK,4
       TXL PLDQ
       REM
       BCD 1LDQ
P10A   TSX CLEAR,4
       LDQ CWRIT+13    L 161616161616 IN MQ
       ENB CNA         ENABLE FOR COMMAND TRAP
       CLA PP42        L +140321513065
       TLQ *+2
       TRA P11
       REM
       TSX ERROR,4     ENABLE ACTED AS LDQ
P11    TSX OK,4
       TXL P10A
       REM
*      TEST ENABLE INSTRUCTION WORKS CORRECTLY WHEN INDEXED
*      ----------------------------------------------------
       REM
       BCD 1EOF
P12    TSX CLEAR,4     MONITOR
       TSX SREST,4     FOR RESET ONLY
       TSX SETUP,4
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       WEFA 2          SET UP EOF
       BSFA 2          TRAP CONDITION
       RTDA 2
       RCHA PREAD      READ ONE WORD
       TCOA *          WAIT
       REM
       AXT 7,2         L +7 IN XRB
P13    ENB CNA+7,2     ENABLE EOF TRAP
       REM
PTR    TRA *+3         OK RETURN
       HTR *+6         ERROR RETURN
       HTR *+5         ERROR RETURN
       AXT CNA,2
       TSX SCHCK,4,1
       PZE PTR,0,4
       TRA *+1
       REM
       TSX OK,4
       TRA P12
       REM
*      TEST ENABLE INSTRUCTION WORKS CORRECTLY WHEN INDIRECTLY ADDRESSED
       REM
       BCD 1EOF
P14    TSX CLEAR,4    MONITOR
       ENB ZEROS      ALL CHANNELS DISABLED
       REM
       WEFA 2         SET UP EOF
       BSFA 2         TRAP CONDITION
       RTDA 2
       RCHA PREAD     READ ONE WORD
       TCOA *         WAIT
       REM
P14A   ENB* P1D       ENABLE FOR EOF TRAP
       REM
P15    TRA *+3         OK RETURN
       HTR *+6         ERROR RETURN
       HTR *+5         ERROR RETURN
       AXT CNA,2
       TSX SCHCK,4,1
       PZE P15,0,4
       TRA *+1
       REM
       TSX OK,4
       TRA P14
       REM
*      TEST THAT ENABLE INSTRUCTION WORKS CORRECTLY USING
*      BOTH INDEXING AND INDIRECT ADDRESSING
       BCD 1EOF
P16    TSX CLEAR,4    MONITOR
       ENB ZEROS      ALL CHANNELS DISABLED
       REM
       WEFA 2         SET UP EOF
       BSFA 2         TRAP CONDITION
       RTDA 2
       RCHA PREAD     READ ONE WORD
       TCOA *         WAIT
       REM
       AXT 64,2
P17    ENB* P1D+64,2   ENABLE FOR EOF TRAP
       REM
P18    TRA *+3         OK RETURN
       HTR *+6         ERROR RETURN
       HTR *+5         ERROR RETURN
       AXT CNA,2
       TSX SCHCK,4,1
       PZE P18,0,4
       TRA *+1
       REM
       TSX OK,4
       TRA P16
       REM
       REM
*      TEST TRAP DOES NOT OCCUR ON RESTORE OUT OF MODE
*      -----------------------------------------------
       REM
       BCD 1RESTOR
P24    TSX CLEAR,4
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
*      SET UP REDUNDANCY TRAP
       REM
       WTBA 2
       RCHA PRD2       L IOCD TEMP,0,2
       WEFA 2
       BSRA 2
       BSRA 2
       REM
       RTDA 2
       RCHA PRD2       L IOCD TEMP,0,2
       TCOA *          WAIT HERE MF
       REM
*      A REDUNDANCY TRAP REQUEST SHOULD NOW BE WAITING
       REM
*      GIVE ENABLE FOR REDUNDANCY AND EOF. EOF NOT YET
*      REQUESTED, BUT WILL BE SET UP DURING INHIBIT
*      CONDITION THAT FOLLOWS REDUNDANCY TRAP.
       REM
P25    ENB CNA+2       ENABLE ALL TRAPS-ONE CHAN
       REM
       TRA *+3         OK RETURN
       HTR *+6         ERROR RETURN
       HTR *+5         ERROR RETURN
       AXT CNA+2,2
       TSX SCHCK,4,1
       PZE P25+1,0,2
       TRA *+1
       REM
       TSX OK,4
       TRA P24
       REM
*      NOW, SET UP EOF TRAP REQUEST WHILE INHIBITED
       REM
       BCD 1RESTOR
P26    TSX CLEAR,4     MONITOR
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       RTBA 2
       RCHA PREAD      L IOCD TEMP,0,1
       TCOA *          WAIT HER MF
       REM
*      DISABLE NOW AND GIVE RESTOR OUT OF MODE
*      TO MAKE SURE THAT RESTOR INEFFECTIVE OUT OF MODE
       REM
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
P27    RCT             GIVEN OUT OF MODE
       REM
*      NOW, ENABLE TO SEE THAT EOF TRAP REQUEST WAITING
       REM
P28    ENB CNA+2       ENABLE ALL TRAPS-SAME CHAN
       REM
       TRA *+3         OK RETURN
       HTR *+6         ERROR RETURN
       HTR *+5         ERROR RETURN
       AXT CNA+2,2
       TSX SCHCK,4,1
       PZE P28+1,0,4
       TRA *+1
       REM
       BSRA 2
       TSX OK,4
       TRA P26
       REM
*      TEST THAT WHEN INHIBITED THE INSTRUCTION WHICH
*      FOLLOWS THE NEXT RESTOR OR CORRECT ENABLE INSTRUCTION
*      WILL ALWAYS BE PREFORMED BEFORE TRAP OCCURS.
       REM
       BCD 1NEXT
P29    TSX CLEAR,4    MONITOR
       ENB ZEROS      ALL CHANNELS DISABLED
       REM
       WTBA 2
       RCHA PRD2      L IOCD TEMP,0,2
       WEFA 2
       BSRA 2
       BSRA 2
       REM
       RTDA 2
       RCHA PRD2      L IOCD TEMP,0,2
       TCOA *         WAIT HERE IN MF
       REM
P30    ENB CNA+2      ENABLE ALL TRAPS-SAME CHAN
       REM
       TRA *+3         OK RETURN
       HTR *+6         ERROR RETURN
       HTR *+5         ERROR RETURN
       AXT CNA+2,2
       TSX SCHCK,4,1
       PZE P30+1,0,2
       TRA *+1
       REM
       TSX OK,4
       TRA P29
       REM
       BCD 1NEXT
P31    TSX CLEAR,4     MONITOR
       REM
       RTBA 2
       RCHA PREAD      L IOCD TEMP,0,1
       TCOA *          WAIT HERE MF
       REM
       RCT             OBTAIN RDNCY TRAP
P31A   NOP             EOF TRAP
       REM
       TRA *+3         CORRECT RETURN
       HTR *+6         ERROR RETURN
       HTR *+5         ERROR RETURN
       AXT CNA+2,2
       TSX SCHCK,4,1
       PZE P31A+1,0,4
       TRA *+1
       REM
       BSRA 2          BKSP OVER EOF IF REPEAT
       TSX OK,4
       TRA P31
       REM
*      CHECK THAT DS TRAP FOLLOWS CORRECT SEQUENCE OF OPERATIONS
*      WHEN USING DIFFERENT TYPE OF OPERATIONS
*      AT EXECUTION LOCATION
*      ---------------------------------------------------------
       REM
       BCD 1AXT
P32    TSX CLEAR,4     MONITOR
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       WEFA 2          SET UP EOF
       BSFA 2          TRAP CONDITION
       RTDA 2
       RCHA PREAD      READ ONE WORD
       TCOA *
       REM
P32A   ENB CNA         ENABLE FOR EOF TRAP
       REM
       TRA *+3         OK RETURN
       HTR *+6         ERROR RETURN
       HTR *+5         ERROR RETURN
       AXT CNA,2
       TSX SCHCK,4,1
       PZE P32A+1,0,4
       TRA *+1         OK
       REM
       TSX OK,4
       TRA P32
       REM
       BCD 1TRA
P32B   TSX CLEAR,4     MONITOR
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       WEFA 2          SET UP EOF
       BSFA 2          TRAP CONDITION
       RTDA 2
       RCHA PREAD      READ ONE WORD
       TCOA *
       REM
       CLA PP33        L TRA TO P33
       STO 11          OCT 13 EXECUTE ON TRAP 
       STO 13          OCT 15 EXECUTE ON TRAP 
       STO 15          OCT 17 EXECUTE ON TRAP 
       STO 17          OCT 21 EXECUTE ON TRAP 
       STO 19          OCT 23 EXECUTE ON TRAP 
       STO 21          OCT 25 EXECUTE ON TRAP 
       REM
P32C   ENB CNA         ENABLE FOR EOF TRAP
       TSX ERROR,4     DID NOT PREFORM TRA
       REM             AT EXECUTE LOCATION
       REM
       REM
P33    TSX OK,4        TRA RETURN OK
       TXL P32B
       REM
       BCD 1XEC
P34    TSX CLEAR,4     MONITOR
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       WEFA 2          SET UP EOF
       BSFA 2          TRA CONDITION
       RTDA 2
       RCHA PREAD      READ ONE WORD
       TCOA *
       REM
       CLA PP31        L XEC PP34
       STO 11          OCT 13 EXECUTE ON TRAP 
       STO 13          OCT 15 EXECUTE ON TRAP 
       STO 15          OCT 17 EXECUTE ON TRAP 
       STO 17          OCT 21 EXECUTE ON TRAP 
       STO 19          OCT 23 EXECUTE ON TRAP 
       STO 21          OCT 25 EXECUTE ON TRAP 
       REM
P35    ENB CNA         ENABLE FOR EOF TRAP
       TRA *+3         CORRECT RETURN - IF
       REM             EC 298774A HAS BEEN MADE
       HTR *+2         ERROR RETURN - BUT WILL
       REM             RETURN HERE IF EC 298784A
       REM             HAS NOT BEEN INSTALLED
       HTR *+1         ERROR RETURN
       LDQ ONES
       CAS ONES
       TRA *+2         ERROR
       TRA *+3         OK
       TSX ERROR-1,4
       NOP P34
       REM
       REM
       TSX OK,4
       TRA P34
       REM
       BCD 1XEC
P36    TSX CLEAR,4     MONITOR
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       WEFA 2          SET UP EOF
       BSFA 2          TRAP CONDITION
       RTDA 2
       RCHA PREAD      READ ONE WORD
       TCOA *
       REM
       CLA PP32        L XEC PP38
       STO 11          OCT 13 EXECUTED ON TRAP
       STO 13          OCT 15 EXECUTED ON TRAP
       STO 15          OCT 17 EXECUTED ON TRAP
       STO 17          OCT 21 EXECUTED ON TRAP
       STO 19          OCT 23 EXECUTED ON TRAP
       STO 21          OCT 25 EXECUTED ON TRAP
       REM
P37    ENB CNA         ENABLE FOR EOF TRAP
       REM
       TSX ERROR,4     XEC TO TRA INSTRUCTION
       REM             FAILED, ON TRAP
       REM
       REM
P38    TSX OK,4        CORRECT RETURN
       TXL P36         FROM TRAP USING
       REM             XEC TO TRA INST
       REM
       BCD 1LDI
P39    TSX CLEAR,4     MONITOR
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       WEFA 2          SET UP EOF
       BSFA 2          TRAP CONDITION
       RTDA 2
       RCHA PREAD      READ ONE WORD
       TCOA *
       REM
       CLA PP40        L LDI ONES
       STO 11          OCT 13 EXECUTED ON TRAP
       STO 13          OCT 15 EXECUTED ON TRAP
       STO 15          OCT 17 EXECUTED ON TRAP
       STO 17          OCT 21 EXECUTED ON TRAP
       STO 19          OCT 23 EXECUTED ON TRAP
       STO 21          OCT 25 EXECUTED ON TRAP
       LDI ZEROS
       REM
P40    ENB CNA         ENABLE FOR EOF TRAP
       REM
       TRA *+3         CORRECT RETURN
       HTR *+2         ERROR RETURN
       HTR *+1         ERROR RETURN
       ONT ONES
       TRA *+2         ERROR
       TRA P41         OK
       TSX ERROR,4     LDI FAILED TO EXECUTE
       REM             ON EOF TRAP
       REM
P41    TSX OK,4
       TXL P39
       REM
       BCD 1FAD-       TEST INSTRUCTION
P42    TSX CLEAR,4     MONITOR
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       WEFA 2          SET UP EOF
       BSFA 2          TRAP CONDITION
       RTDA 2
       RCHA PREAD      READ ONE WORD
       TCOA *
       REM
       CLA PP41        L FAD PP42
       STO 11          OCT 13 EXECUTED ON TRAP
       STO 13          OCT 15 EXECUTED ON TRAP
       STO 15          OCT 17 EXECUTED ON TRAP
       STO 17          OCT 21 EXECUTED ON TRAP
       STO 19          OCT 23 EXECUTED ON TRAP
       STO 21          OCT 25 EXECUTED ON TRAP
       CLA PP58
       STO 8           L TRA P43
       CLA CCNST       L FP ACC NO
       REM
P43    ENB CNA         ENABLE FOR EOF TRAP
       REM
       TRA P43A
       HTR P43A        ERROR RETURN
       HTR P43A        ERROR RETURN
       HTR P43A        ERROR RETURN
       REM
P43A   LDQ PP44
       CAS PP44        FAD ANS
       TRA *+2         ERROR
       TRA *+3         OK
       TSX ERROR-1,4    ERROR
       NOP P42
       REM
       TSX OK,4
       TRA P42
       REM
       BCD 1XECXEC
P43B   TSX CLEAR,4     MONITOR
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       WEFA 2          SET UP EOF
       BSFA 2          TRAP CONDITION
       RTDA 2
       RCHA PREAD      READ ONE WORD
       TCOA *
       REM
       REM
       CLA PP45        L FAD PP46
       STO 11          OCT 13 EXECUTED ON TRAP
       STO 13          OCT 15 EXECUTED ON TRAP
       STO 15          OCT 17 EXECUTED ON TRAP
       STO 17          OCT 21 EXECUTED ON TRAP
       STO 19          OCT 23 EXECUTED ON TRAP
       STO 21          OCT 25 EXECUTED ON TRAP
       REM
P44    ENB CNA         ENABLE FOR EOF TRAP
       REM
       TRA P44A        CORRECT RETURN - IF
       REM             EC 298784A HAS BEEN MADE
       REM
       HTR P44A        ERROR RETURN - BUT WILL
       REM             RETURN HERE IF EC 298784A
       REM             HAS NOT BEEN INSTALLED
       HTR P44A       
       HTR P44A      
       HTR P44A     
       HTR P44A     
       HTR P44A     
       HTR P44A     
       HTR P44A     
       HTR P44A     
       REM
P44A   LDQ ONES
       CAS ONES
       TRA *+2        ERROR
       TRA P45        OK
       TSX ERROR-1,4   ERROR
       NOP P43B
       REM
P45    TSX OK,4
       TRA P43B
       REM
       BCD 1PBT        SKIP TEST
P46    TSX CLEAR,4     MONITOR
       ENB ZEROS       ALL CHANNELS DISABLED
       REM
       WEFA 2          SET UP EOF
       BSFA 2          TRAP CONDITION
       RTDA 2
       RCHA PREAD      READ ONE WORD
       TCOA *
       REM
       CLA PP51        L PBT
       STO 11          OCT 13 EXECUTED ON TRAP
       STO 13          OCT 15 EXECUTED ON TRAP
       STO 15          OCT 17 EXECUTED ON TRAP
       STO 17          OCT 21 EXECUTED ON TRAP
       STO 19          OCT 23 EXECUTED ON TRAP
       STO 21          OCT 25 EXECUTED ON TRAP
       REM
       CAL ONES        ONE IN P
P47    ENB CNA         ENABLE FOR EOF TRAP
       REM
       HTR P48         ERROR RETURNS
       REM
       TRA P48         OK RETURN
       HTR P48
       HTR P48
       HTR P48
       REM
P48    TSX OK,4
       TRA P46
       REM
*      TEST THAT FLOATING POINT TRAP TAKES PRIORITY
*      OVER CHANNEL TRAPS WHEN THEY OCCUR AT SAME TIME
       REM
       BCD 1FADEOF
P49    TSX CLEAR,4      TRAP EXPECTED
       TSX SREST,4
       TSX SETUP,4      RESET I/O TRIGGERS
       ENB ZEROS        ALL CHANNELS DISABLED
       REM
*      WRITE IN BINARY MODE AND READ IN DECIMAL MODE
*      TO SET UP REDUNDANCY TRAP REQUEST. THEN, WHILE
*      INHIBITED, SET UP EOF TRAP SIGNAL AND INITIATE
*      A DEMAND FOR EOF TRAP AND FLOATING POINT TRAP AT
*      THE SAME TIME.
       REM
       WTBA 2
       RCHA PRD2        L IOCD TEMP,0,2
       WEFA 2
       BSRA 2
       BSRA 2
       REM
       RTDA 2
       RCHA PRD2        L IOCD TEMP,0,2
       TCOA *           MF WAIT HERE 
       REM
*      INITIATE REDUNDANCY TRAP
       REM
P50    ENB CNA+2        ENABLE ALL TRAPS-ONE CHAN
       REM
       TRA *+3          CORRECT RETURN
       HTR *+6          ERROR RETURN
       HTR *+5          ERROR RETURN
       AXT CNA+2,2
       TSX SCHCK,4,1
       PZE P50+1,0,2
       TRA *+1
       REM
       REM
P51    RTBA 2           ASK FOR EOF TRAP
       RCHA PREAD       L IOCD TEMP,0,1
       TCOA *           MF WAIT HERE
       REM
       CLA PP56         L TRA P52
       STO 8            FP TRAP RETURN
       CLA CCNST        L ACC FP NO
       REM
P51A   RCT              OBTAIN TRAP DURING FP TRAP
P51B   FAD CCNST+1      L SR FP NO
       REM
*      SHOULD NOT ENTER HERE. SHOULD RETURN
*      TO P52. A RETURN HERE INDICATES A RETURN
*      FROM THE EOF TRAP.
       REM
       TRA *+3         DS TRAP RETURN
       HTR *+6         ERROR RETURN
       HTR *+5         ERROR RETURN
       AXT CNA+2,2
       TSX SCHCK,4,1
       PZE P51B+1,2,4
       TRA *+1
       REM
       TSX SPLAT,4
       PZE M
       REM
       REM
       REM
       REM
*      SHOULD ENTER HERE AFTER EXECUTING RESTOR
*      AND FAD INSTRUCTIONS, CAUSING TRAP TO 10
*      AND TRA TO P52. FLOATING POINT TRAP TAKING
*      PRIORITY OVER DS TRAPS
       REM
P52    LDQ PP57       L 030673242370
       CAS PP57       L FP ANS
       TRA *+2        ERROR
       TRA P54        OK
       TSX ERROR-1,4
       NOP P49
       REM
P54    RCT
P55    NOP
       REM
       TRA *+3        OK RETURN
       HTR *+6        ERROR RETURN
       HTR *+5        ERROR RETURN
       AXT CNA+2,2
       TSX SCHCK,4,1
       HTR 8,0,4
       TRA *+1
       REM
       TSX OK,4       OK
       TRA P49
       REM
* TEST COMPLETION OF INSTRUCTION BEING EXECUTED WHEN TRAP OCCURS
* AT EXECUTE
       REM
       BCD 1XEC
       REM
SXEC   TSX CLEAR,4     MONITOR
       TSX SETUP,4     RESET I/O TRIGGERS
       ENB ZEROS       DISABLE ALL CHANNELS
       WEFA 2          CONDITION
       BSFA 2          FOR
       RTDA 2          END OF FILE
       RCHA PREAD      TRAP
       REM
       PXA 0,0,0       CLEAR ACC
       TCOA *          DELAY
       ENB CNA         ENABLE FOR END OF FILE TRAP
       XEC PP59        CLA ALL ONES
       REM
       TRA *+3         CORRECT RETURN IF EC298784A
       REM             HAS BEEN INSTALLED
       HTR *+2         ERROR RETURN - BUT WILL
       REM             RETURN HERE IF EC 298784A
       REM             HAS NOT BEEN INSTALLED
       HTR *+1         ERROR RETURN
       REM
       AXT CNA,2
       TSX SCHCK,4,1   GO TO CHECK TRAP
       HTR *-6,0,4     CORRECT INFORMATION FOR
       REM             TRAP LOCATION
       TRA *+1
       CAS ONES        CHECK IF EXECUTE COMPLETED
       REM             OPERATION BEFORE TRAP
       TRA *+2         ERROR
       TRA *+6         OK
       LDQ ONES        L ALL ONES IN MQ
       TSX ERROR-1,4
       NOP SXEC
       TSX SPLAT,4     INSTRUCTION BEING EXECUTED
       PZE SA          AT TIME TRAP OCCURRED
       REM             FAILED TO COMPLETE
       REM             OPERATION
       TSX OK,4
       TRA SXEC
       REM
       REM
*THIS SECTION WILL TEST THAT ONE ENABLE RESETS THE
*PREVIOUS ENABLE, SO THAT IT NO LONGER HAS ANY AFFECT.
       REM
*A TEST WILL ALSO BE PREFORMED TO SEE THAT LCH GINVEN
*IN TIME DOES NOT TRAP.
       REM
       BCD 1ENABLE
       REM
CU     TSX CLEAR,4     CHECK SEQUENCE
       REM
       REM
       TSX SETUP,4     RESET I/O TRIGGERS
       REM
       CLA STRA1       L TRA SAA
       STO 0           POST RESTART
       REM
       ENB CNA         ENABLE FOR COMMAND TRAP
       WTBA 2          WRITE ONE RECORD-BINARY
       RCHA CALL       IOCT-WC2
       LCHA CALL+1     IOST-WC2
       LCHA CALL+2     IOCT-WC2
       LCHA CALL+3     IOST-WC2
       LCHA CALL+4     IORT-WC6.
       LCHA ZEROS
       REM
       TRA *+2
       HTR *+4
       AXT CNA,2
       TSX SCHCK,4,1  OUT TO CHECK FOR TRAP
       HTR 0,2,0
       TRA *+3        OK
       TSX SPLAT,4    SPACE PRINTER AND
       PZE N
       REM
       REM
       TSX OK,4
       TRA CU
       REM
*THIS SECTION WILL TEST EACH TYPE OF TRAP INDIVIDUALLY
       REM
       BCD 1TRAPS
       REM
CV     TSX CLEAR,4    CHECK SEQUENCE
       REM
       TSX SETUP,4    RESET I/O TRIGGERS
       REM
       ENB CNA        ENABLE FOR COMMAND TRPA
       WTBA 2
       RCHA CALL      IOCT-WC2
       TCOA *         SHOULD TRAP HERE
       REM
       TRA *+2
       HTR *+4        IN CASE OF IC FAILURE
       AXT CNA,2      ENABLE Y LOCATION
       TSX SCHCK,4,1  OUT TO CHECK TRAP
       REM
       REM            THE TRAP ADDRESS SHOULD
       HTR *-5,0,1    CONTAIN THIS INFORMATION
       TRA *+3        OK
       TSX SPLAT,4    SPACE PRINTER-ERROR
       PZE P
       REM
       TSX OK,4
       TRA CV
       REM
       BCD 1TRAPS
       REM
*      TEST FOR EOF TRAP
       REM
CW     TSX CLEAR,4
       REM
       TSX SETUP,4    RESET I/O TRIGGERS
       REM
       ENB CNA        ENABLE FOR EOF TRAP
       WTBA 2
       RCHA CFCTL+8   IOCD-WC2
       WEFA 2
       BSRA 2         BKSPACE OVER EOF
       BSRA 2         BACKSPACE ONE RECORD
       RTBA 2
       RCHA CRTB      READ RECORD
       RTBA 2         READ EOF
       AXT 4095,1     IF NO TRAP OCCURS PROGRAM
       TXH *,1,64     WILL REMAIN AT THIS LOC
       REM
       TRA *+2
       HTR *+4        IN CASE OF IC FAILURE
       AXT CNA,2      ENABLE Y LOCATION
       TSX SCHCK,4,1  OUT TO CHECK TRAP
       REM
       REM            THE TRAP ADDRESS SHOULD
       HTR *-5,0,4    CONTAIN THIS INFORMATION
       TRA *+3        OK
       TSX SPLAT,4
       PZE Q
       REM
       TSX OK,4
       TRA CW
       REM
       BCD 1TRAPS
       REM
*      TEST FOR REDUNDANCY TRAP
       REM
CX     TSX CLEAR,4
       REM
       TSX SETUP,4    RESET I/O TRIGGERS
       REM
       ENB CNA+1      ENABLE FOR EOF TRAP
       WTBA 2
       RCHA CWTB      WRITE ONE WORD-BINARY
       WTDA 2
       RCHA CWTB+1    WRITE ONE WORD-BCD
       REM
       BSRA 2         BACKSPACE OVER 1 RECORD
       BSRA 2         BACKSPACE OVER 1 RECORD
       REM
       TSX RDNCK,4    CHECK FOR REDUNDANCY
       NOP CX
       REM
       STZ CRDFD+1
       RTBA 2         READ BOTH RECORDS-BINARY
       RCHA CHECK+5   READ ONE WORD RECORD
       LCHA CWTB1     READ ONE WORD RECORD
       REM            2ND RECORD SHOULD TRAP
       REM            AND DISCONNECT WITHOUT
       REM            TRANSMITTING WORD
       AXT 4095,1     IF NO TRAP OCCURS PROGRAM
       TXH *,1,64     WILL REMAIN AT THIS LOC
       REM
       AXT CNA+1,2
       TSX SCHCK,4,1  OUT TO CHECK TRAP
       REM            THE TRAP ADDRESS SHOULD
       HTR *-3,0,2    CONTAIN THIS INFORMATION
       REM
       TRA *+3        OK
       TSX SPLAT,4
       PZE R
       REM
       AXT 2,2        SET UP
       CLA ONE        SET UP
       STO WDNO       ERROR
       PXA 0,2        ROUTINE
       ADD ONE        CONSTANT
       STO RECNO
       REM
       CLA CRDFD      WORD READ
       LDQ CWRIT      CORRECT WORD
       CAS CWRIT
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       NOP CX
       TIX *+1,2,1
       REM
       CLA CRDFD+1    WORD READ
       LDQ ZEROS      CORRECT WORD
       CAS ZEROS
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR HERE INDICATES
       NOP CX         THAT WORD WAS TRANSMITTED
       REM            AFTER REDUNDANCY
       REM
       REM
*THIS SECTION WILL TEST THAT ENABLE WITH ZERO
*RESETS THE PREVIOUS ENABLE INSTRUCTION AND THAT
*A TRAP WILL NOT OCCUR
       REM
       REM
       RCT            TURN OFF INHIBIT TRIGGER
       BSRA 2         GET BACK TO
       BSRA 2         BEGINNING
       RTBA 2
       RCHA CHECK+5   READ TO GET
       LCHA CWTB1     REDUNDANCY CHECK
       AXT 4095,1     IF NO TRAP OCCURS PROGRAM
       TXH *,1,64     WILL REMAIN AT THIS LOC
       REM
       TRA *+2
       HTR *+4        IN CASE OF IC FAILURE
       AXT CNA+1,2
       TSX SCHCK,4,1  OUT TO CHECK FOR TRAP
       REM            THE TRAP ADDRESS SHOULD
       HTR *-5,0,2    CONTAIN THIS INFORMATION
       REM
       REM
       TRA *+3        OK
       REM
       TSX SPLAT,4
       PZE S
       REM
*TEST THAT ENABLE WITH 0 RESETS PREVIOUS ENABLE
       REM
       TSX SETUP,4    RESET I/O TRIGGERS
       REM
       ENB CNA+9      ENABLE WITH ZERO
       REM
       BSRA 2         BACKSPACE TWO
       BSRA 2         RECORDS
       RTBA 2    
       RCHA CHECK+5   READ ONE RECORD
       LCHA CWTB1     READ REDUNDANCY RECORD
       TCOA *
       REM
       TRA *+2
       HTR *+4        IN CASE OF IC FAILURE
       AXT CNA+9,2
       TSX SCHCK,4,1  OUT TO CHECK FOR TRAP
       REM            THE TRAP ADDRESS SHOULD
       HTR *-5,2,2    CONTAIN THIS INFORMATION
       REM
       TRA *+3        OK
       REM
       TSX SPLAT,4
       PZE T
       REM
       TSX OK,4
       TRA CX
       REM
*THIS SECTION TESTS THAT ONE TRAPS INHIBITS ANOTHER AND ALL TRAPS
*ON ONE CHANNEL AT THE SAME TIME WILL INDICATE AFTER ENABLE
       REM
       BCD 1TRAPS
       REM
CZ     TSX CLEAR,4
       REM
       TSX SETUP,4    RESET I/O TRIGGERS
       REM
       WTDA 2         WRITE 1 WORD RECORD BCD
       RCHA CWTB
       BSRA 2
       ENB CNA+2      ENABLE ALL TRAPS-ONE CHAN
       RTBA 2         READ RECORD
       RCHA CWTB1     IN BINARY TO FORCE
       REM            TRAP
       AXT 4095,1     IF NO TRAP OCCURS PROGRAM
       TXH *,1,64     WILL REMAIN AT THIS LOC
       REM
       TRA *+2
       HTR *+4
       AXT CNA+2,2
       TSX SCHCK,4,1  OUT TO CHECK FOR TRAP
       REM
       HTR *-5,0,2    CONTAIN THIS INFORMATION
       TRA *+3        OK
       TSX SPLAT,4
       PZE U
       REM
       WTBA 2         WRITE ONE WORD IN BINARY
       RCHA CWTB
       WTDA 2         WRITE ONE WORD IN DECIMAL
       RCHA CWTB+1
       WEFA 2         WRITE EOF
       REM
       BSRA 2         BACKSPACE OVER EOF
       BSRA 2         BACKSPACE OVER BCD RECORD
       REM
       RTBA 2         READ BCD IN BINARY
       RCHA CWTB1     FOR RDNCY TRAP-IOCD WC 1
       REM
       REM
       RTBA 2         READ EOF
       RCHA CWTB1     IOCD-WC 1
       REM
       WTBA 2         WRITE ONE WORD
       RCHA CRTB3     IOCT-WC 2
       REM            NO LCH SHOULD BRING
       REM            UP COMMAND TRAP
       REM
       TCOA *         IF DESIRED-PLACE HTR HERE
       REM            TO GIVE VISUAL CHECK FOR
       REM            ALL TRAPS BEING UP
       ARS 77         DELAY FOR ALL TRAPS
       ENB CNA+2      ENABLE ALL TRAPS-ONE CHAN
       TRA *+2
       HTR *+4
       AXT CNA+2,2
       TSX SCHCK,4,1  OUT TO CHECK FOR TRAP
       HTR *-2,0,7    TRAP ADDRESS SHOULD CONTAIN
       REM            THIS INFORMATION
       TRA *+3        OK
       REM
       TSX SPLAT,4
       PZE V
       REM
       REM
       TSX OK,4
       TRA CZ
       REM
*THIS SECTION WILL TEST THAT ENABLE AFTER TRAP INDCATION
*WILL TRAP IMMEDIATELY AND FUTURE TRAPS ARE INHIBITED
       REM
       BCD 1TRAPS
       REM
CZA    TSX CLEAR,4
       TSX SETUP,4    RESET I/O TRIGGERS
       WTBA 2
       REM
       RCHA CALL+2    IOCT-WC2
       WEFA 2         SHOULD NOT TRAP-ALL TRAP
       REM            CONDITIONS WERE RESET BY
       REM            LAST ENABLE
       REM
       TRA *+2
       HTR *+4 
       AXT CNA+9,2
       TSX SCHCK,4,1  OUT TO CHECK FOR TRAP
       HTR *-5,2,1 
       TRA *+3        OK
       REM
       TSX SPLAT,4
       PZE W
       REM
       BSRA 2         BACKSPACE. TWO
       BSRA 2         RECORDS
       RTBA 2        
       RCHA CRTB      READ TWO WORDS
       RTBA 2
       RCHA CRTB      READ EOF
       TCOA *         
       ENB CNA+2      ENABLE ALL TRAPS-ONE CHAN
       TRA *+2        SHOULD TRAP HERE
       HTR *+4
       AXT CNA,2
       TSX SCHCK,4,1  OUT TO CHECK FOR TRAP
       HTR *-4,0,4
       TRA *+2        OK
       NOP
       WTBA 2	
       RCHA CIOC      2OCT-WC1
       TCOA *         COMAMND TRAP CONDITIONED
       REM            BUT SHOULD BE INHIBITED
       TRA *+2 
       HTR *+4
       AXT CNA+1,2
       TSX SCHCK,4,1  OUT TO CHECK FOR TRAP
       HTR *-5,2,1
       TRA *+3        OK
       REM
       TSX SPLAT,4
       PZE X
       REM   
       TSX OK,4
       TRA CZA
       REM
*THIS SECTION WILL TEST THAT NO TRAP OCCURS UNTIL
*AFTER EXECUTING THE INSTRUCTION FOLLOWING A SELECT
       REM
       BCD 1ENABLE
       REM
CZB    TSX CLEAR,4    CHECK SEQUENCE
       TSX SETUP,4    RESET I/O TRIGGERS
       ENB CNA        ENABLE FOR COMMAND TRAP
       WTBA 2
       RCHA CIOC+1    IORT-WC1
       TCOA *         GET TRAP HERE
       RCT            TURN OFF INHIBIT TRIGGER
       WTDA 2
       RCHA CIOC+2    IOST-WC1
       NOP
       WTDA 2         SHOULD NOT COME BACK FOR LCH
       REM            FOR APPROX. 36 US
       RCHA CWRIT-1   IOCD-WC 2
       TRA *+2        SHOULD TRAP AT THIS LOC.
       HTR *+4        IN CASE OF IC FAILURE
       AXT CNA,2
       TSX SCHCK,4,1  OUT TO CHECK TRAP
       HTR *-4,0,1
       TRA *+3        OK
       TSX SPLAT,4
       PZE Y
       REM
       BSRA 2         BACKUP 1 RECORD
       RTDA 2         READ BCD
       RCHA CRTB      IOCD-WC2
       TCOA *
       REM
       CLA THREE      SET UP
       STO WDNO       PRINT
       STO RECNO      ROUTINE
       AXT 2,3        CONSTANTS
       REM
       CLA CREAD+2,1  WORD READ
       LDQ CWRIT+14,1 CORRECT WORD
       CAS CWRIT+14,1
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-2,4
       NOP CZA
       TSX SPLAT,4
       MZE Z
       REM
       TIX *+1,2,1
       TIX *-10,1,1
       REM
       TSX OK,4
       TRA CZB
       REM
       BCD 1TRAPS
       REM
CZZ    TSX CLEAR,4    CHECK SEQUENCE
       TSX SETUP,4    RESET I/O TRIGGERS
       ENB CNA        ENABLE FOR EOF TRAP
       WEFA 2         WRITE EOF
       BSRA 2         BACKUP OVER TM
       RTBA 2         SHOULD HIT EOF HERE
       WTBA 2         SHOULD NOT TRAP HERE
       TRA *+2        SHOULD NOT TRAP HERE
       HTR *+4 
       REM
       AXT CNA,2      SHOULD TRAP HERE
       TSX SCHCK,4,1 
       HTR *-2,0,4
       TRA *+3        OK
       REM
       TSX SPLAT,4
       PZE AA
       TSX OK,4
       TRA CZZ
       REM
       REM
*THIS SECTION TEST THAT TRA AND RDNCK AND TRA AND EOF
*WILL ACT AS NOPS IF ENABLED FOR THESE CONDITIONS
*ALSO THAT A SELECT WILL NOT RESET THE COMMAND DISC
*TRG IF ENABLED FOR COMMAND DISC
       REM
       REM
       BCD 1NOPS      TEST CONDITION
       REM
NOPS   TSX CLEAR,4
       TSX SETUP,4
       ENB CNA+2      ENABLE ALL TRAPS-ONE CHAN
       WTBA 2
       RCHA CRTB3     IOCT - WC 2 - TO BRING UP
       TCOA *         TRAP AND INHIBIT
       WEFA 2         WRITE EOF
       BSRA 2         OVER EOF
       BSRA 2         OVER RECORD
       RTDA 2         READ IN BCD TO FORCE RDNCK
       RCHA CWTB1     IOCD - WC 1
       RTDA 2         READ EOF
       RCHA CWTB1     IOCD - WC 1
       WTBA 2
       RCHA CRTB3     TOCT - WC 2
       REM
       TEFA *+2       SHOULD ACT AS NOP
       TRA *+3        OK
       TSX ERROR-1,4  TEF SHOULD ACT AS NOP IF
       TXL NOPS       ENBALED AND RDNCK TRG IS ON
       REM 
       TRCA *+2       SHOULD ACT AS NOP
       TRA *+3        OK
       TSX ERROR-1,4  TCR SHOULD ACT AS NOP IF
       TXL NOPS       ENBALED AND EOF TRG SI ON
       REM
       WTBA 2         SELECT TO SEE THAT IT
       RCHA CWRIT-1   DOES NOT TURN OFF COMM DISC
       TCOA *
       REM
       RCT            SHOULD INDICATE ALL TRAPS
       NOP
       TRA *+2        SHOULD TRAP HERE
       HTR *+4 
       AXT CNA+2,2
       TSX SCHCK,4,1  OUT TO CHECK TRAP
       REM
       HTR *-4,0,7    
       TRA *+3        NO ERROR
       REM
       TSX SPLAT,4
       PZE AC
       TSX OK,4
       TRA NOPS
       REM
       REM
*THIS SECTION TEST THAT ALL TRAP INDICATORS ARE TURNED
*OFF WHEN A CORRESPONDING TRAP OCCURS
       REM
       REM
       BCD 1TRAPS     TEST CONDITION
       REM
CZC    TSX CLEAR,4    CHECK SEQUENCE
       TSX SETUP,4    RESET I/O TRIGGERS
       WTDA 2         WRITE THREE WORDS BCD
       RCHA CFCTL+8
       WEFA 2         WRITE EOF
       REM
       BSRA 2         BACKSPACE OVER EOF
       BSRA 2         BACKSPACE OVER RECORD
       REM
       REM
       RTBA 2         
       RCHA CWTB1     CONDITION RDNCK-IOCD WC 1
       REM
       RTBA 2  
       RCHA CWTB1     CONDITION EOF-IOCD WC 1
       REM
       WTBA 2
       RCHA CRTB3     IOCT WC 2 CONDTIONS COMMAND
       REM
       TCOA *
       ENB CNA+2      ENABLE ALL TRAPS-ONE CHAN
       NOP
       REM
       ENB ZEROS      ALL CHANNELS DISABLED
       TEFA *+2       SHOULD NOT BE ON
       TRA *+3        OK
       TSX ERROR-1,4  ERROR - TRAP SHOULD HAVE
       REM            RESET EOF TRIGGER
       TXL CZC
       REM 
       TRCA *+2       SHOULD NOT BE ON
       TRA *+3        OK
       TSX ERROR-1,4  ERROR - TRAP SHOULD HAVE
       REM            RESET RDNCK TRIGGER
       TXL CZC
       REM
       AXT CNA+9,2
       TSX SCHCK,4,1  OUT TO CHECK TRAP
       HTR *-12,0,7    
       TRA *+3        NO ERROR
       REM
OMG    TSX SPLAT,4 ERROR
       PZE AB
       REM
       TSX OK,4
       TRA CZC
       NOP
       REM
       REM
       CAL SMSK+2    L 777777777770
       ANS S1ULN     CLEAR CHANNEL
       CAL CX+3      L SELECT
       ANA SMSK+3    AND WITH 000000007000
       ARS 9
       ORS S1ULN
       REM
       TSX SPLAT,4
       MZE 7,0,1
S1ULN  BCD 5 CHN A   SINGLE CHANNEL OPERAT
       BCD 2ION COMPLETE
       REM
SCTX   TSX SCAN,4    GO TO SET SCAN ROUTINE
       PZE CX+3      LOC OF SELECT FOR SCAN
       TSX CTX,4     GO TO ADJUST PROGRAM
       PZE ALF,0,OMG MODIFICATION AREA
       TSX SCAN1,4   GO TO SCAN FOR TSX SCHCK,4
       PZE ALF,0,OMG SCAN AREA
       TRA SAC
       REM
       CLA TRA       L TRA 1,4
       STO CZC+15
       TSX CZC+11,4  RETURN TO TURN ON INHIBIT TGR
       CLA P31A      L NOP
       STO CZC+15    RESTORE NOP
       REM
       REM
*       MULTI-CHANNEL OPERATION
       REM
       REM
*THIS SECTION WILL TEST MULTI-CHANNEL
*OPERATION FOR SEQUENCE TRAPS
       TRA *+3       SKIP BCD WORD
       TRA CZC
       REM
       BCD 1SEQ TP
       REM
CZIB   TSX CLEAR,4
       NZT CTRA      TAPE CHANNEL A
       TRA *+5       NO
       ETTA
       TSX SREW,2    GO TO REWIND ALL UNITS
       REM
       REM
       WTBA 2
       RCHA CWTB     IOCD-WC 1
       REM
       NZT CTRA+1    TAPE CHANNEL B
       TRA *+5       NO
       ETTB
       TSX SREW,2    GO REWIND ALL UNITS
       REM
       WTBB 2
       RCHB CWTB     IOCD-WC 1
       REM
       NZT CTRA+2    TAPE CHANNEL C
       TRA *+5       NO
       ETTC
       TSX SREW,2    GO REWIND ALL UNITS
       REM
       WTBC 2
       RCHC CWTB     IOCD-WC 1
       REM
       NZT CTRA+3    TAPE CHANNEL D
       TRA *+5       NO
       ETTD
       TSX SREW,2    GO REWIND ALL UNITS
       REM
       WTBD 2
       RCHD CWTB     IOCD-WC 1
       REM
       NZT CTRA+4    TAPE CHANNEL E
       TRA *+5       NO
       ETTE
       TSX SREW,2    GO REWIND ALL UNITS
       REM
       WTBE 2
       RCHE CWTB     IOCD-WC 1
       REM
       NZT CTRA+5    TAPE CHANNEL F
       TRA *+5       NO
       ETTF
       TSX SREW,2    GO REWIND ALL UNITS
       REM
       WTBF 2
       RCHF CWTB     IOCD-WC 1
       REM
*TEST FOR WRITING EOF
       REM
       NZT CTRA
       TRA *+4
       WEFA 2        WRITE EOF
       BSRA 2
       BSRA 2
       REM
       NZT CTRA+1
       TRA *+4
       WEFB 2        AND
       BSRB 2
       BSRB 2
       REM
       NZT CTRA+2
       TRA *+4
       WEFC 2        BACKSPACE
       BSRC 2
       BSRC 2
       REM
       NZT CTRA+3
       TRA *+4
       WEFD 2        OVER EOF
       BSRD 2
       BSRD 2
       REM
       NZT CTRA+4
       TRA *+4
       WEFE 2        AND BINARY
       BSRE 2
       BSRE 2
       REM
       NZT CTRA+5
       TRA *+4
       WEFF 2        RECORD
       BSRF 2
       BSRF 2
       REM
       REM
*BRING UP ALL TRAP CONDITIONS FOR ALL CHANNELS SELECTED
       REM
       REM
       NZT CTRA
       TRA *+7       SKIP TO NEXT CHANNEL
       RTDA 2        READ BINARY RECORD
       RCHA CWTB1    IOCD-WC 1
       RTBA 2        READ EOF
       RCHA CWTB1    IOCD-WC 1
       WTBA 2        CONDITION COMMAND DISC
       RCHA CRTB3    IOCT-WC 2
       REM
       NZT CTRA+1
       TRA *+7       SKIP TO NEXT CHANNEL
       RTDB 2        READ BINARY RECORD
       RCHB CWTB1    IOCD-WC 1
       RTBB 2        READ EOF
       RCHB CWTB1    IOCD-WC 1
       WTBB 2        CONDITION COMMAND DISC
       RCHB CRTB3    IOCT-WC 2
       REM
       NZT CTRA+2
       TRA *+7       SKIP TO NEXT CHANNEL
       RTDC 2        READ BINARY RECORD
       RCHC CWTB1    IOCD-WC 1
       RTBC 2        READ EOF
       RCHC CWTB1    IOCD-WC 1
       WTBC 2        CONDITION COMMAND DISC
       RCHC CRTB3    IOCT-WC 2
       REM
       NZT CTRA+3
       TRA *+7       SKIP TO NEXT CHANNEL
       RTDD 2        READ BINARY RECORD
       RCHD CWTB1    IOCD-WC 1
       RTBD 2        READ EOF
       RCHD CWTB1    IOCD-WC 1
       WTBD 2        CONDITION COMMAND DISC
       RCHD CRTB3    IOCT-WC 2
       REM
       NZT CTRA+4
       TRA *+7       SKIP TO NEXT CHANNEL
       RTDE 2        READ BINARY RECORD
       RCHE CWTB1    IOCD-WC 1
       RTBE 2        READ EOF
       RCHE CWTB1    IOCD-WC 1
       WTBE 2        CONDITION COMMAND DISC
       RCHE CRTB3    IOCT-WC 2
       REM
       NZT CTRA+5
       TRA *+7       SKIP TO NEXT CHANNEL
       RTDF 2        READ BINARY RECORD
       RCHF CWTB1    IOCD-WC 1
       RTBF 2        READ EOF
       RCHF CWTB1    IOCD-WC 1
       WTBF 2        CONDITION COMMAND DISC
       RCHF CRTB3    IOCT-WC 2
       REM
       TCOA *        WAIT
       TCOB *        FOR
       TCOC *        ALL
       TCOD *        CHANNELS
       TCOE *        TO
       TCOF *        STOP
       REM
       TSX SREST,4   RESET TRAP LOCATIONS
       REM
*ENABLE ALL CHANNELS, ALL TRAPS AND SEQUENCE
       REM
       NZT CTRA       CHANNEL A
       TRA *+10       NO
       ENB CNA+8      SHOULD OBTAIN COMMAND TRAP
       NOP            REDUNDANCY TRAP, AND EOF
       TRA *+2        TRAP HERE
       HTR *+6
       AXT CNA+8,2
       TSX SCHCK,4,1  CHECK TRAPS
       HTR *-4,0,7
       TRA *+2
       SLN 1          TURN ON LITE ONE IF ERROR
       REM
       NZT CTRA+1     CHANNEL B
       TRA *+10       NO
       ENB CNA+8      OBTAIN TRAPS ON CHAN B
       NOP            SHOULD GET ALL
       TRA *+2        TRAPS HERE
       HTR *+6
       AXT CNA+8,2
       TSX SCHCK,4,2  CHECK TRAPS
       HTR *-4,0,7
       TRA *+2
       SLN 1          LITE ONE IF ERROR
       REM
       NZT CTRA+2     CHANNEL C
       TRA *+10       NO
       ENB CNA+8      OBTAIN TRAPS ON CHAN C
       NOP            SHOULD GET ALL
       TRA *+2        TRAPS HERE
       HTR *+6
       AXT CNA+8,2
       TSX SCHCK,4,4 
       HTR *-4,0,7
       TRA *+2
       SLN 1          LITE ONE ON-IF ERROR
       REM
       REM
       NZT CTRA+3     CHANNEL D
       TRA *+10       NO
       ENB CNA+8      OBTAIN TRAPS ON CHAN D
       NOP            SHOULD GET ALL
       TRA *+2        TRAPS HERE
       HTR *+6
       AXT CNA+8,2
       TSX SCHCK,4,8
       HTR *-4,0,7
       TRA *+2
       SLN 1          LITE ONE ON-IF ERROR
       REM
       REM
       NZT CTRA+4     CHANNEL E
       TRA *+10       NO
       ENB CNA+8      OBTAIN TRAPS ON CHAN E
       NOP            SHOULD GET ALL
       TRA *+2        TRAPS HERE
       HTR *+6
       AXT CNA+8,2
       TSX SCHCK,4,16 
       HTR *-4,0,7
       TRA *+2
       SLN 1          LITE ONE ON IF ERROR
       REM
       REM
       NZT CTRA+5     CHANNEL F
       TRA *+10       NO
       ENB CNA+8      OBTAIN TRAPS ON CHAN E
       NOP            SHOULD GET ALL
       TRA *+2        TRAPS HERE
       HTR *+6
       AXT CNA+8,2
       TSX SCHCK,4,32
       HTR *-4,0,7
       REM     
       REM
       TRA *+2
       SLN 1          LITE ONE IF ERROR
       REM
       REM
       SLT 1          TEST FOR ERROR
       TRA *+15       NO ERROR
       TSX SPLAT,4 
       PZE 12,0,1
       BCD 6ABOVE ERRORS OCCURRED WHILE TRYING T
       BCD 6O SEQUENCE TRAPS ON ALL CHANNELS
       REM
       TSX OK,4
       TRA CZIB
       REM
       NOP
       REM     
       REM     
       REM     
       REM     
       REM     
SPAS1  TSX SPLAT,4
       MZE 7,0,6
       BCD 59IOT - PASS COMPLETE ON ALL UN
       BCD 2ITS CALLED
       REM
       REM
CZIC   SWT 5         TEST SWITCH 5
       TRA *+2       UP-TEST SWITCH 6
       TRA RUC       DOWN - REPEAT WITHOUT
       REM           9IOM HALT
       SWT 6 
       TRA *+2       UP-CALL NEXT PROGRAM
       TRA CBEGN     REPEAT AFTER HALT TO
       REM           ENTER KEYS
       TSX SREW,2    GO TO REWIND ALL UNITS
       REM
FINL1  PZE **        READ SELECT NEXT PROGRAM
       RCHA *+3
       LCHA 0
       TRA 1
       IOCT 0,0,3
       REM     
       REM     
       REM     
*      REWIND ALL TEST UNITS
       REM
SREW   ZET CTRA
       REWA 2
       ZET CTRB
       REWB 2
       ZET CTRC
       REWC 2
       ZET CTRD
       REWD 2
       ZET CTRE
       REWE 2
       ZET CTRF
       REWF 2
       TRA 1,2       RETURN
       REM
       REM
SCAN   CLA* 1,4      L CURRENT SELECT 
       STO SCANA     SAVE
       SXA SXRC,4    COMPLEMENT
       LAC SXRC,4    INDEX
       PXD 0,0       CLEAR ACC
       PXA 0,4
       ADD ONE
       STA SCAN1
       LXA SXRC,4    RELOAD XRC
       TRA 2,4       RETURN
       REM
       REM
       REM
SCAN1  CAL* **       L ALTERED SELECT
       STO SCANB
       REM
       CLA 1,4       L SCAN ADDRESSES
       STA SHIFT+2   SET FIRST
       STA SCNW      LOC TO CHECK
       ARS 18        MOVE DECR TO ADDR
       ADD ONE
       STA SLNTR     SAVE LAST LOC TO CHECK
       REM
       REM
SCNZ   AXT 2,1       L 2 IN XRA
       CAL SCANA+2,1 L SELECT
       ANA SMSK+3    AND WITH 07000
       ARS 9
       STO SCANA+2,1 SAVE CHANNEL COUNT
       TIX *-4,1,1
       REM
       AXT 2,1
       LAS SCANA
       TRA SCNY      NEW CHN HIGHER - SHIFT
       TRA SCNX      NO CHANGE - NO SHIFT
       CLA SCANA     NEW CHN LOWER - SHIFT R
       SUB SCANB
       STA SHF1
       CLA SHF1      L ARS **
       TRA SCNX+1
       REM
SCNY   CLA SCANB
       SUB SCANA
       STA SHF2
       CLA SHF2      L ALS **
       TRA SCNX+1
       REM
SCNX   CLA SNP       L NOP
       STO SHIFT
       REM
       REM
SCNW   CAL **        L INSTRUCTION
       ANA SMSK+4    AND WITH 7777007777777
       LAS SCMP      COMPARE TSX SCHCK,4
       TRA *+2
       TRA SHIFT-2   YES - IS TSX INSTR
       CLA *-5 
       SUB ONE       STEP ADDRESS
       STA SHIFT+2
       STA SCNW
       ADD SLNTR     CHECK FOR LAST INSTR
       TMI SHNBL-6   IS LAST INSTRUCTION
       TRA SCNW      CONTRINUE TO SCAN
       REM
       REM
       XEC SCNW
       ANA SMSK+1    AND WITH 000077000000
SHIFT  PZE **        VARIABLE SHIFT
       ORA SCMP
       SLW **        RESTORE INSTR
       TRA SCNW+5    CHECK NEXT INSTR
       REM
       SXA SXRC,4
       XEC SCAN1     L SELECT
       TSX SHNBL+1,4     TO SET ENABLE WORDS
       NOP
       REM
       LXA SXRC,4
       TRA 2,4       RETURN TO PROGRAM
       REM
SHNBL  CLA* 1,4      L SELECT
       ANA SMSK+3    AND WITH 07000
       ARS 9
       SUB ONE       L +1
       STA *+3
       AXT 3,1       L +3 IN XRA
       CLA NABLR+3,1
       ALS **
       STO NABL+3,1
       COM 
       ANA NABL+8
       STO NABL+6,1
       TIX *-6,1,1
       REM
       TRA 2,4       RETURN
       REM
       REM
       REM
       REM
       REM
*      I-O TRAP ERROR CHECK SUBROUTINE
       REM
       REM
SCHCK  SWT 2
       TRA *+2       UP - PROCEED
       TRA SEGRS     DN-RETURN TO PROGRAM
       REM
       REM
*      SAVE TRAP INFORMATION
       REM
       SXA SRTA,4    SAVE XRC FOR RETURN
       LAC SRTA,4    COMPLEMENT TO INDEX
       SXA SXRC,4    SAVE ERROR EXIT
       LXA SRTA,4    RELOAD XRC
       SXA SXQN,1    SAVE EXECUTION LOC
       SXA SXRB,2    SAVE LOC OF ENABLE WORD
       SXA SCK3,2    SET ADDR OF ENABLE
       REM
       STZ STRAP     RESET TRAP-NO TRAP CHECK
       STO SACC      SAVE ACC
       ARS 35        SHIFT P AND Q BITS
       SLW SACC+1    SAVE P AND Q BITS
       STQ SACC+2    SAVE MQ
       STI SIND      SAVE INDICATORS
       STZ SZCK      RESET
       CLA ONES      L ALL ONES
       STO SERCK     SET NO ERROR CHECK
       REM
       REM
       REM
*      SET FOR TYPE OF TRAP EXPECTED AND INDICATED
       REM
       CAL 1,4       L DUMMY INSTRUCTION
       STT STRAP     SET TRAP-NO TRAP CHECK
       REM           ZERO FOR TRAP EXPECTED
       ANA SMSK      AND WITH 7777777077777
       SLW SDUM      SAVE DUMMY INSTRUCTION
       REM
       AXT 4,1       L 4 IN XRA
       SLT 1+4,1     CHECK SENSE LIGHT
       TRA *+3       OFF
       STO SLCK+4,1  ON - SAVE ON CHECK
       TRA *+2
       STZ SLCK+4,1  SAVE OFF CHECK
       TIX *-5,1,1   LOOP THROUGH 4 LIGHTS
       REM
       SLF           TURN OFF ALL SENSE LIGHTS
       AXT 1,2       L CHN A COUNT IN XRB
       CAL 0,4       L TSX SCHCK,4 INSTRUCTION
       ANA SMSK+1    AND WITH 077000000
       ARS 17        MOVE BIT 0T
       ARS 1         LOW ORDER
       LBT           CHECK FOR BIT
       TXI *-2,2,1   NO BIT - STEP CHN COUNT
       SXA SCHN1,2   INITIALIZE CURRETN CHANNEL
       SXA SCHN,2    SAVE CORRECT TRAP CHANNEL
       REM
       REM
       NZT SXQN      CHECK TRAP EXECUTION
       TRA SCHK      ZERO - NO EXECUTION
       ZET STRAP     CHECK TRAP-NO TRAP
       TRA SCHK2+2   NOT ZERO - GO TO PRINT
       CLA SEXLC+6,2 L EXECUTION RESULT EXPECTED
       CAS SXQN      COMPARE EXECUTION RESULT
       TRA SCHK2+2   ERROR
       TRA *+4       SAME - OK
       TRA SCHK2+2   ERROR
       REM
SCHK   CLA ONES      L ALL ONES
       STO SZCK
       REM
       CAL* STRLC+6,2 l TRAP LOCATION
       TZE *+5       ZERO - CHECK OTHER LOCS
       CAS SDUM      NOT ZERO - COMPARE
       TRA SCHK2+2   ERROR
       TRA *+4       SAME - OK
       TRA SCHK2+2   ERROR
       REM
       CLA ONES      L ALL ONES
       STO SZCK 
       REM
       SLN 1         TURN ON SENSE LIGHT ONE
       REM           TO SHOW NO PRINT YET
SCHK1  SXA SCK2-1,2  SET CHANNEL COUNT FROM XRB
SCK1   TIX *+2,2,1
       TRA SCK2-1
       SXA SCHN1,2   SAVE CHN UNDER INSPECTION
       CAL* STRLC+6,2 L TRAP LOCATION
       TZE SCK1      OK - TRAP LOCATION ZERO
       TRA SCHK2     NOT ZERO - ERROR
       REM
       AXT **,2
SCK2   TXH *+6,2,5 
       TXI *+1,2,1
       SXA SCHN1,2   SAVE CHN UNDER INSPECTION
       CAL* STRLC+6,2 L TRAP LOCATION
       TZE SCK2      OK - TRAP LOCATION ZERO
       TRA SCHK2+1   NOT ZERO - ERROR
       REM
       REM
       ZET STRAP     CHECK TRAP-NO TRAP
       TRA SREST-2   NOT ZERO - NOT TRAP OK
       REM
       NZT SZCK      TRAP EXPECTED - CHECK
       REM           NO TRAP INDICATION
       TRA SREST-2   ZERO - TRAP INDICATED
       SLN 3         NOT ZERO - TURN ON SENSE
       REM           LIGHT 3 TO SHOW FAILURE
       REM           TO TRAP
       TRA SCHK2+2
       REM
       REM
*      RESET FOR NEXT ROUTINE AND RETURN TO PROGRAM
       REM
       LXA SRTA,4    RESTORE XRC FOR RETURN
       TRA *+3       SKIP PROGRAM ENTRY
       REM
SREST  STZ SERCK     CLEAR ERROR CHECK
       TXI SRST1,4,2 INCREMENT XRC BY 2
       REM
       LDI SIND      RESTORE INDICATORS
       REM
       SLF           TURN OFF ALL SENSE LIGTHS
       AXT 4,1       L +4 IN XRA
       CLA SLCK+4,1
       TZE *+2
       SLN 1+4,1     NOT ZERO - TURN ON SL
       TIX *-3,1,1
       REM
SRST1  AXT 14,1      L +14 IN XRA
       CLA SAXT+14,1 L AXT INSTRUCTION
       STO 11+14,1   RESET EXECUTION LOCATION'
       STZ 10+14,1   RESET TRAP LOCATION
       TIX *-3,1,2
       REM
       CLA SACC+1    L P AND Q BITS
       LDQ SACC      RESTORE
       LLS 35        ACC
       LDQ SACC+2    RESTORE MQ
       REM
       AXT 0,3       CLEAR XRA AND XRB
       NZT SERCK     CHECK FOR ERROR
       TRA 3,4       ZERO - ERROR RETURN
SEGRS  TRA 2,4       NOT ZERO - NO ERROR RETURN
       REM
       REM
       REM
*      INDICATE ERROR IN TRAP OPERATION
       REM
SCHK2  SLN 2         TURN ON SENSE LIGHT 2
       TRA *+2 
       SLN 1         TURN ON SENSE LIGHT 1
       STZ SZCK      CLEAR NO INDICATION CHECK
       REM
       SWT 3         CHECK SENSE SWITCH 3
       TRA *+2       PRINT ON ERROR
       HTR SREST-2   HALT ON ERROR
       SLT 1         CHECK SENSE LIGHT 1
       TRA STSP3     OFF - SKIP FIRST LINE
       REM           ON - PRINT FIRST LINE
       REM
       REM
*      SET PRINT IMAGE FOR 1ST LINE OF ERROR PRINT
       REM
       REM
       CLA ZEROS
       STO S1LNB     CLEAR
       STO S1LNA+5   INFORMATION
       STP S1LNA+2   FROM
       STD S1LNA+2   PRINT
       STA S1LNA+1   IMAGES
       REM
       REM
*      SET PROGRAM EXIT LOC IN PRINT IMAGE
       REM
       PXD 0,0       CLEAR ACC
       LDQ SXRC      L PROGRAM EXIT IN MQ
       TSX SSLW,4    INSERT
       RQL 9
       STA S1LNA+1   PROGRAM
       TSX SSLW,4
       NOP           EXIT IN
       STP S1LNA+2
       STD S1LNA+2
       CLA SIX
       ALS 15
       STT S1LNA+1
       REM
       REM
*      SET ENABLE CONTROL WORD IN PRINT IMAGE
       REM
       TSX SSLW,4    INSERT
       REM
SCK3   LDQ **        ENABLE
       SLW S1LNA+5   WORD
       REM
       TSX SSLW,4    IN BCD
       PXD 0,0       PRINT
       SLW S1LNB     IMAGE
       REM
       REM
*      CHECK IF SHOULD TRAP AND DID OR DID NOT TRAP
       REM
       ZET STRAP     CHECK TRAP-NO TRAP
       TRA STSP1     NOT ZERO - SHOULD NOT TRAP
       REM           SKIP 2ND LINE PRINT
       SLT 3         STRAP ZERO - SHOULD TRAP
       REM           CHECK FOR TRAP INDICATION
       TRA *+2       OFF - TRAP INDICATED
       TRA STSP2     ON - NO TRAP INDICATED
       REM
       REM
*      SET SHOULD TRAP, TRAP IN ERROR IN 1ST LINE IMAGE
       REM
       AXT 5,1       INSERT -
       CLA SBCD1+5,1 SHOULD TRAP, TRAP IN ERROR
       STO S1LNB+6,1 IN BCD
       TIX *-2,1,1   PRINT IMAGE
       TRA SPRT      GO PRINT 1ST LINE
       REM
       REM
*      SET NO TRAP SHOULD OCCUR IN 1ST LINE IMAGE
       REM
STSP1  SLN 3         TURN ON SENSE LIGHT 3
       AXT 5,1       INSERT -
       CLA SBCD2+5,1 NO TRAP SHOULD OCCUR
       STO S1LNB+6,1 IN BCD
       TIX *-2,1,1   PRINT IMAGE
       TRA SPRT      GO TO PRINT 1ST LINE
       REM
       REM
*      SET SHOULD TRAP, NO TRAP SHOWN IN 1ST LINE IMAGE
       REM
STSP2  SLN 4         TURN ON SENSE LIGHT 4
       AXT 5,1       INSERT -
       CLA SBCD3+5,1 SHOULD TRAP, NO TRAP SHOWN
       STO S1LNB+6,1 IN BCD
       TIX *-2,1,1   PRINT IMAGE
       REM
       REM
SPRT   TSX SPLAT,4   PRINT 1ST LINE
       MZE 12,0,1
S1LNA  BCD 6PRGM EXIT         TRAP ENABLE
S1LNB  BCD 6
       REM
       REM
*      CHECK IF SHOULD PRINT 2ND LINE
       REM
       SLT 3         CHECK SENSE LIGHT 3
       TRA *+2       OFF - PRINT LINE 2
       TRA STSP3     ON - SKIP LINE 2
       REM
       REM
*      SET CORRECT TRAP INFORMATION IN 2ND LINE IMAGE
       REM
       LXA SCHN,2    INSERT -
       LDQ STRLC+6,2 CORRECT
       TSX SSLW,4    TRAP LOCATION
       REM
       RQL 18        IN BCD
       SLW S2LNA+3   IMAGE
       CAL S2LNB
       STP S2LNA+3
       REM
       LDQ SEXLC+6,2 INSERT -
       TSX SSLW,4    CORRECT
       REM
       RQL 18        EXECUTION LOCATION
       SLW S2LNB+5
       CAL S2LNB
       STP S2LNB+5
       REM
       LXA SRTA,2    INSERT - 
       TSX SSLW,4    TRAP
       REM
       LDQ 1,2       LOCATION
       ALS 18        DECREMENT
       REM
       SLW S2LNA+5   IN
       CAL SBCD4     BCD
       ORS S2LNA+5   IMAGE
       REM
       PXD 0,0       CLEAR ACC
       REM
       TSX SSLW,4    INSERT -
       REM
       LGR 6         TRAP
       SLW S2LNB+2   LOCATION
       REM
       CAL SBCD4+1   ADDRESS
       ORS S2LNB+2   IN
       TSX SSLW,4    BCD
       REM
       LXA SCHN,2    RESTORE CHN TO XRB
       SLW S2LNB+3   IMAGE
       REM
       REM
       CAL SBCD4+2   OF 2ND
       ORS S2LNB+3   LINE
       REM
       REM
       TSX SPLAT,4   PRINT 2ND LINE
       PZE 12,0,1
S2LNA  BCD 6CORRECT -  TRP LOC         TYPE
S2LNB  BCD 6  TRP LOC ADDR         XEC LOC
       REM
       REM
*      SET ERROR TRAP INFORMATION IN 3RD LINE IMAGE
       REM
STSP3  STZ SERCK     SET ERROR CHECK
       SLT 4         CHECK SENSE LITE 4
       TRA *+2
       TRA SREST-2   ON
       REM
       LXA SCHN1,2   INSERT -
       LDQ STRLC+6,2 ERROR
       REM
       TSX SSLW,4    TRAP LOC
       REM
       RQL 18        IN BCD
       SLW S3LNA+3   IMAGE
       CAL S2LNB
       STP S3LNA+3
       REM
       REM
       LDQ SXQN      INSERT -
       TSX SSLW,4    ERROR
       REM
       RQL 18        EXECUTION LOC
       SLW S3LNB+5   IN BCD IMAGE
       CAL S2LNB
       STP S3LNB+5
       REM
       TSX SSLW,4    INSERT -
       REM
       LDQ* STRLC+6,2 ERROR
       ALS 18        TRAP
       REM
       SLW S3LNA+5   LOCATION
       CAL SBCD4     DECREMENT
       ORS S3LNA+5   IN BCD IMAGE
       PXD 0,0       CLEAR ACC
       REM
       TSX SSLW,4    INSERT -
       REM
       LGR 6         TRAP
       SLW S3LNB+2   LOCATION
       REM
       CAL SBCD4+1   ADDRESS
       ORS S3LNB+2   IN BCD
       REM
       TSX SSLW,4    IMAGE
       REM
       NOP           OF
       SLW S3LNB+3
       REM
       CAL SBCD4+2   3RD LINE
       ORS S3LNB+3
       REM
       REM
       TSX SPLAT,4   PRINT 3RD LINE
       PZE 12,0,1
S3LNA  BCD 6ERROR - -  TRP LOC         TYPE
S3LNB  BCD 6  TRP LOC ADDR         XEC LOC
       REM
       REM
       REM
       SLT 2          CHECK SENSE LIGHT 2
       TRA SCK2       OFF
       TRA SCK1       ON
       REM
       REM
       REM
*      SUBROUTINE TO ADJUST BCD IMAGE
       REM
SSLW   AXT 6,1
       XEC 1,4
       ALS 3          SAPCE
       LGL 3          MOVE DIGIT TO ACC
       TIX *-2,1,1
       XEC 2,4
       TRA 3,4        RETURN
       REM
       REM
       REM
       REM
*      CONSTANTS FOR I-O TRAP ERROR CHECK ROUTINE
       REM
       REM
SXQN   OCT **         STG FOR EXECUTION LOC
SXRC   OCT **         SAVE ERROR ADDRESS
SXRB   OCT **         SAVE LOC OF ENABLE WORD
SRTA   OCT **         SAVE XRC FOR RETURN
STRAP  OCT **         TRAP-NO TRAP CHECK
SACC   OCT **         STG FOR ACC
       OCT **         STG FOR P AND Q BITS
       OCT **         STG FOR MQ
SIND   OCT **         STG FOR INDICATORS
       REM
SMSK   OCT 777777077777 MASK OUT TAG
       OCT 077000000  MASK FOR CHANNEL
       OCT 777777777770
       OCT 000000007000
       OCT 777700777777
       OCT **         TEMP STORAGE
       REM
SDUM   OCT **         STG FOR DUMMY INSTRUCTION
       REM
SLCK   OCT **         CHECK FOR SENSE LIGHT 1
       OCT **         CHECK FOR SENSE LIGHT 2
       OCT **         CHECK FOR SENSE LIGHT 3
       OCT **         CHECK FOR SENSE LIGHT 4
       REM
SCHN   OCT **         STG FOR CHANNEL
SCHN1  OCT **         STG FOR CURRENT CHANNEL
       REM
SERCK  OCT **         ERROR-NO ERROR CHECK
SZCK   OCT **         FIRST LINE PRINT CHECK
       REM
SAXT   AXT 11,1       INSTRUCTIONS
       PZE 0
       AXT 13,1       USED
       PZE 0
       AXT 15,1       TO
       PZE 0
       AXT 17,1       RESET
       PZE 0
       AXT 19,1       TRAP
       PZE 0
       AXT 21,1       LOCATIONS
       PZE 0
       REM
STRLC  OCT 24         TRAP LOC - CHN F 
       OCT 22         TRAP LOC - CHN E 
       OCT 20         TRAP LOC - CHN D 
       OCT 16         TRAP LOC - CHN C 
       OCT 14         TRAP LOC - CHN B 
       OCT 12         TRAP LOC - CHN A 
       REM
SLHA   OCT **         STG FOR BCD INFO
       REM
SEXLC  OCT 25         EXECUTION LOC - CHN F
       OCT 23         EXECUTION LOC - CHN E
       OCT 21         EXECUTION LOC - CHN D
       OCT 17         EXECUTION LOC - CHN C
       OCT 15         EXECUTION LOC - CHN B
       OCT 13         EXECUTION LOC - CHN A
       REM
SBCD1  BCD 5   SHOULD TRAP, TRAP IN ERROR
SBCD2  BCD 5   NO TRAP SHOULD OCCUR
SBCD3  BCD 5   SHOULD TRAP, NO TRAP SHOWN
SBCD4  BCD 1E 0
       BCD 1DR 000
       BCD 100   X
       REM
SK     WTBA 2
       OCT 000000000077
       OCT 000077000000
       OCT 000077000077
       OCT -000000000007
       REM
SK1    WTBA 1
       RCDA
       REM
SCH    OCT 000000100450 EXCLU UNIT 2 - CHN A
       OCT 000000145000 EXCLU UNIT 2 - CHN B
       OCT 000000200450 EXCLU UNIT 2 - CHN C
       OCT 000000245000 EXCLU UNIT 2 - CHN D
       OCT 000000400450 EXCLU UNIT 2 - CHN E
       OCT 000000445000 EXCLU UNIT 2 - CHN F
       REM
STRA1  TRA SAA
SCANA  OCT **         STG FOR PREVIOUS CHANNEL
SCANB  OCT **         STG FOR NEW SELECT
SLNTR  CLA **         STG
SCMP   TSX SCHCK,4    COMPARISON FOR SCAN
SHF1   ARS **         VARIABLE SHIFT FOR SCAN
SHF2   ALS **         VARIABLE SHIFT FOR SCAN
SNP    NOP
       REM
NABL   OCT 000000000001
       OCT 000001000000
       OCT 000001000001
       REM
       OCT 000000000076
       OCT 000076000000
       OCT 000076000076
       REM
       OCT 000000000077
       OCT 000077000000
       OCT 000077000077
       REM
       OCT 000000000000
       REM
       REM
NABLR  OCT 000000000001
       OCT 000001000000
       OCT 000001000001
       REM
SKIP1  OCT 77777     SKIP CHK FOR HALT TESTS
       REM
       REM           CONSTANTS FOR RFW AND DW
       REM
CNTL   IOCT ONES,0,1
RF2    TRA DW6+2
       REM
       REM   
*      CONSTANTS AND IMAGES
*      --------------------
       REM   
ONE    OCT 1
TWO    OCT 2
THREE  OCT 3
SIX    OCT 6
       REM
ONES   OCT 777777777777
ZEROS  OCT 0
       REM
PREAD  IOCD TEMP,0,1
PRD2   IOCD TEMP,0,2
       REM
PZR    PZE P1
P1D    PZE CNA
P7777  OCT 77777      MASK FOR ADDRESS
PP2    TRA P2
PP3    TRA P3
P5BB   PZE P6
PP6    TRA P6
PP7    TRA P7
PP31   XEC PP34
PP32   XEC PP38
PP33   TRA P33
PP34   CLA ONES
PP38   TRA P38
PP40   LDI ONES
PP41   FAD CCNST+1
PP42   OCT 140321513065 SR NO.
PP43   OCT 766375071640 ACC NO.
PP44   OCT 765772163500 ACC ANS
PP45   XEC PP46
PP46   XEC PP47
PP47   XEC PP48
PP48   XEC PP49
PP49   XEC PP50
PP50   XEC PP34
PP51   PBT
PP53   FAD PP42
PP54   PZE P31
PP55   HTR P31
PP56   TRA P52
PP57   OCT 030673242370
PP58   TRA P43B
PP59   CLA ONES
       REM
TEMP   PZE **        TEMPORARY
       PZE **        STORAGE
       REM
       REM   
       REM
CRTB   IOCD CREAD,0,2
CTRB1  IOCD CREAD+2,0,2
CRTB2  IOCD ONES,0,2
CSAVE  OCT 0
CCC    IOCD ONES+1,0,CRTB2+1
CCC1   IOCD ONES+2,0,CRTB2+1
CRTB6  IOCD CREAD,2,2
CFCTL  IOCP CWRIT,0,2
       IOSP CWRIT+2,0,2
       IORP CWRIT+4,0,2
       TCH *+2
       IOCD
       IOCT CWRIT+6,0,2
       IOST CWRIT+8,0,2
       IORT CWRIT+10,0,2
       IOCD CWRIT+12,0,2
       REM
CRUD   IORP CWRIT,0,6
       IORP CWRIT+6,0,6
       IOCD CWRIT+12,0,2
       REM
CWRIT  OCT 010101010101 
       OCT 020202020202 
       OCT 030303030303 
       OCT 040404040404 
       OCT 050505050505 
       OCT 060606060606 
       OCT 070707070707 
       OCT 101010101010 
       OCT 111111111111 
       OCT 121212121212 
       OCT 131313131313 
       OCT 141414141414 
       OCT 151515151515 
       OCT 161616161616 
       REM
CRDFD  BSS 14
CHECK  IOCP CWRIT+1,0,CFCTL+1
       IOST CWRIT+9,0,CFCTL+7
       IORT CWRIT+11,0,CFCTL+8
       IOCD CWRIT+13,0,CFCTL+9
       IOCD CWRIT+14,0,CFCTL+9
       REM
       IOCT CRDFD,0,1
CID18  IOCD CID18-1,4,2
       REM
CID    IOCP CADDR,4,2    THE ADDRESSES
       IOSP CADDR+1,4,2  OF THESE
       IORP CADDR+2,4,2  CONTROL WORDS
       TCH CADDR+3,4     WILL BE
       IOCD              CHANGED
       IOCT CADDR+5,4,2  TO THE
       IOST CADDR+6,4,2  ADDRESSES OF
       IORT CADDR+7,4,2  THE FOLLOWING
       IOCD CADDR+8,4,2  SET OF CONTROL WORDS
       REM               BY THE USE OF IND 18
       REM
CADDR  IOCP CRDFD,0,2
       IOSP CRDFD+2,0,2  THESE ADDRESSES
       IORP CRDFD+4,0,1  WILL BE PICKED
       TCH CID+5,0       UP BY IND 18
       IOCD
       IOCT CRDFD+6,0,1
       IOST CRDFD+8,0,1
       IORT CRDFD+10,0,1
       IOCD CRDFD+12,0,1
       REM
CK1    IOCP CRDFD,0,CID+1
       IOST CRDFD+8,0,CID+7
       IORT CRDFD+10,0,CID+8
       IOCD CRDFD+12,0,CID+9
       IOCD CRDFD+14,0,CID+9
       TCH CHIPS+2,0,CHIPS+1
       IOCT CWRIT+1,0,CHIPS+3
       REM
IND19  IOCP CADDR,6,2
       IOSP CADDR+1,6,2
       IORT CADDR+2,6,2
       TCH CHUNK,6,2
       IOCD
       IOCT CADDR+5,6,2
       IOST CADDR+6,6,2
       IORT CADDR+7,6,2
       IOCD CADDR+8,6,2
       REM
CHUNK  TCH IND19+5,0
       REM
CHIPS  TCH CHIPS+1,4,0
       TCH CHIPS+2
       IOCT CWRIT,0,2
       REM
CK2    IOCP CRDFD,2,IND19+1
       IOST CRDFD+8,2,IND19+7
       IORT CRDFD+10,2,IND19+8
       IOCD CRDFD+12,2,IND19+9
       IOCD CRDFD+14,2,IND19+9
       REM
CCCC   TCH CHOP,4,5
CHOP   TCH CHOP+1
       TCH CHOP+2,4,5
       TCH CHOP+3
       IOCD CWRIT,0,14
       REM
CK3    IOCD CWRIT+1,0,CHOP+4
       REM
CIOC   IOCT CWRIT,0,1
       IORT CWRIT+1,0,1
       IOST CWRIT+2,0,1
       IOCD CWRIT+3,0,1
       IOCD CREAD,0,2
CRTB3  IOCT CREAD,0,2
CWTB6  IOCD CWRIT,0,3
       REM
TRA    TRA 1,4
       REM
CCNST  OCT 003304725372
       OCT 035015665047
       OCT 030673242370
       OCT 375472537200
CBIT   HTR CS+4,0,1
CTTR   TTR CT+4
CTTR1  TTR SEQ
CBIT1  HTR CT+4
CWTB   IOCD CWRIT,0,1
       IOCD CWRIT+1,0,1
CWTB1  IOCD CRDFD+1,0,1
       REM
CALL   IOCT CWRIT,0,2
       IOST CWRIT+2,0,2
       IOCT CWRIT+4,0,2
       IOST CWRIT+6,0,2
       IORT CWRIT+8,0,6
       REM
       REM
       REM
*THE FOLLOWING SUBROUTINES ARE THE MONITOR AND TRAP
*SEQUENCE ROUTINES
       REM
SEQ    LTM
       SLT 4         WAS TRAP EXPECTED
       TXI WHAT,0,32767 NO, ERROR
       SLN 4         YES, TRAP EXPECTED
       TXH XRCE,4,0  IF XRC IS STILL
       LXA 0,4       ZERO-OK
       SXD COMP+2,4  SAVE TRAP ADDRESS
       LXD SECT2,4   CLEAR XRC
SECT2  TXI 0         RETURN
       REM
       REM
WHAT   SXD TRAP-2,1
       LXA 0,1       WAS AN ADDRESS PUT AT 0
       TXL OUTER,1,0 IF NOT, ERROR
COMP   SXD FREE,1    IF SO, IS IT LAST
       LDC FREE,1    TRAP ADDRESS
       TXI *+1,1,0
       TXL OUTER,1,0 IF ZERO, NO TRAP
       REM           BUT SKIPPED TO REM
       REM
       LXA 0,1
       SXD COMP+2,1  SAVE TRAP ADDRESS
       LXD TRAP-2,1  RESTORE XRA
       TXI FADED     TRAP ERROR
       REM
       BCD 1FP TRP
       REM
TRAP   LXA 0,4       RETURN TO PROG
       SXA *+2,4
       LXD *+1,4     RESTORE XRC
       TXI           RETURN
       REM
FADED  SXD *-1,4     SAVE XRC
       TSX ERROR-1,4 TRAP IN ERROR, OR
       TRA TRAP      TRS TO 10 IS ILLEGAL
       TRA TRAP      SET ADDRESS AT ZERO
XRCE   SXD FREE,2    SAVE XRB
       SXD FREE+1,4  AND XRC
       LXD FREE+1,2  MOVE XRC TO XRB
       TXI *+2
       REM
       BCD 1ITIME-
       REM
       TSX ERROR-1,4 XRC WAS NOT ZERO
       NOP XRCE+5
       LXA 0,4       SAVE TRAP
       SXD COMP+2,4  ADDRESS
       LXD FREE,2    RESTORE XRB
       TRA SECT2-1   RETURN TO TRAP PROG
OUTER  LXD TRAP-2,1  RESTORE XRA
       TSX SPACE,4   GO TO 10 BY MISTAKE
       REM
       BCD 1SPACE
       REM
SPACE  SXD BIN,4     SPACE ADDRESS
       LDC BIN,4     XRC TRUE DECREMENT
       SXD BIN,4     OF BIN
       LDC MONIT,4   ADDRESS OF TEST
       SXA BIN,4     THAT LOST CONTROL
       REM           TO ADDRESS
       REM
       LDI BIN       ADDRESS PROGRAM SKIPPED
       REM           TO IN DECREMENT OF
       REM           INDICATORS.
       REM
       REM           ADDRESS OF TEST BEING
       REM           PREFORMED IN ADDRESS
       REM           OF INDICATORS
       TSX ERROR-1,4
       NOP SPACE
       REM
       LXD MONIT,4
       CLA -2,4      RESET MONIT
       PAC 0,2       AND RETURN
       SXD MONIT,2   TO PROPER
       TRA *+4       SEQUENCE
       REM
CLEAR  SLF
       SWT 1
       TRA *+2
       TRA *+3
       SWT 4
       TRA *+4       NOT REPEATED
       PXD 0,4       TEST REPEATED
       SUB MONIT     OR WILL BE
       TZE RESET+1   REPEATED-IF ZERO
       REM           PROGRAM SEQUENCE OK.
       REM
       STZ FREE
       SXD FREE,4    SAVE TEST ADDRESS
       CLA -2,4      PRECEEDING TEST ADDRESS
       REM
       PAC 0,4       COMPLEMENT
       PXD 0,4
       SUB MONIT     SHOULD BE ZERO
       LXD FREE,4    RESTORE XRC
       TZE RESET+1   IF ZERO, PROGRAM
       REM           SEQUENCE OK.
       REM
       ENK           CHECK FOR MANUAL TRANSFER
       XCA
       PAC 0,4       COMPLEMENT KEYS ADDRESS
       LRS 21        CHECK TRA ONLY
       SUB K41       -0200
       TNZ *+5       SEQUENCE N.G. IF NOT 0
       PXD 0,4       OK, CHECK ADDRESS
       SUB FREE
       LXD FREE,4    RESTORE
       TZE RESET+1   OK IF ZERO
       REM
       LXD FREE,4    PROGRAM OUT OF
       TTR SPACE     SEQUENCE
       REM
       REM
RESET  SLF
       SXD MONIT,4   MONITOR
       LDC MONIT,4
       TXI *+1,4,1   FOR RETURN
       SXA EXIT,4
       PXD 0,0       CLEAR ACC
       STZ 0         CLEAR LOC ZERO
       LDQ           CLEAR MQ
       TOV *+1       TURN OFF
       NOP
       DCT
       NOP
       PAI           RESET
       LXD 0,7       CLEAR ALL XRS
EXIT   TRA           RETURN TO PROGRAM
PART2  SLF
       SLN 4         LIGHT 4 ON
       TRA CLEAR+1
BIN    OCT 0
MONIT  OCT 0
K41    OCT 200
FREE   BSS 2 
       REM           INDEXABLE BCD PRINT SUBROUTINE.
       REM
       REM
SPLAT  TRA SPLT1     CHECK FOR SENSE PRINTER
       SXA SPLAT+61,1
       SXA SPLAT+62,2
       SXA SUBET,4   SAVE ORGINAL XRC.
       NZT 1,4       IF CONTROL WORD ZERO.
       REM
*5
       TRA 2,4       RETURN
       REM
       CAL 1,4       GET NON-ZERO WORD
       SLW SPLAT+85  SAVE CONTROL WORD
       PDX 0,1       TYPE WHEEL NO.
       TXL SPLAT+65,1,0 IF DECR. ZERO, GET
       REM           NEW CONTROL WORD
       REM
*10
       SXD *+2,4     GET EXIT ADDRESS
       PAC 0,2       BY ADDING TWOS COMP.
       TXI *+1,2,0   OF N TO XRC.
       SXA SPLAT+63,2 EXIT VALUE.
       REM
       REM SET BIT INDEX TO STARTING WHEEL
       REM
       SXA *+3,1     FOR SHIFTING
       REM
*15
       AXT 1,3       1 TO XRA AND XRB
       CAL SPLAT+82  BIT INDEX TO P
       LGR 0,1       SHIFT TO STARTING POINT
       TNZ *+3       IF ACC IS ZERO, SET FOR
       STQ SPLAT+83  RIGHT ROW, AND MAKE
       REM
*20
       TXI *+2,2,1   XRB A DUECE
       SLW SPLAT+83  OTHERWISE, LEFT ROW.
       AXT 26,1
       STZ CI+26,1   CLEAR CARD IMAGE
       TIX *-1,1,1
       REM
       REM
       REM FORM CARD IMAGE.
       REM
*25
       TIX *+1,4,1   ADDRESS OF FIRST WORD.
       AXT 6,1       CHARACTER COUNT.
       LDQ 1,4       GET THE WORD.
       REM           SOME PEOPLE NEVER
       REM           DO, YOU KNOW
       SXA SPLAT+54,1 SAVE CHARACTER COUNT.
       PXD           CLEAR ACC
       REM   
*30
       LGL 2         ZONE
       ALS 1         TIMES 2
       PAX 0,1
       SXA SPLAT+45,1 FOR FUTURE REFERENCE.
       CLM
       REM
*35
       LGL 4         DIGIT
       ALS 1         TIMES 2
       SLW CI        TEMP0
       CAL SPLAT+83  BIT INDEX
       NZT CI        IS DIGIT ZERO.
       REM   
       REM   
*40
       TXH SPLAT+80,1,0 IS ZERO ZONE TOO.
       LXA CI,1      OK, PROCEED
       TXH SPLAT+48,1,24 CHECK FOR ILLEGAL
       TXH SPLAT+78,1,20 SPECIAL CHARACTER.
       ORS* SPLAT+92,2 XRB PICKS LEFT OR RIGHT.
       REM
*45
       AXT 0,1       ZONE AGAIN.
       TXL *+2,1,0   NOTHING FOR ZERO ZONE
       ORS* SPLAT+90,2 PLACE ZONE BIT.
       REM
       REM  COLUMN SET.
       REM
       ARS 1         SET BIT INDEX TO 
       TNZ *+4       NEXT COLUMN, IF ANY.
       REM
*50
       TXH SPLAT+60,2,1 IF BX ZERO,+XRB 1, STOP
       REM
       CAL SPLAT+82  IF NOT, SET TO RIGHT
       TXI *+1,2,1   ROW AND PROCEED.
       SLW SPLAT+83  BX READY FOR NEXT COLUMN.
       AXT 0,1       MORE CHARACTERS.
       REM   
*55
       TIX SPLAT+28,1,1 NEXT COLUMN
       LXA SPLAT+85,1 MORE WORDS MAYBE.
       TNX *+3,1,1    IF NOT, STOP.
       SXA SPLAT+85,1 YUMMY, GO GET EM.
       TXI SPLAT+25
       REM
       REM FIFTEEN MEN ON A DEAD MANS CHEST.
       REM
*60
       RCHA SPLAT+84  LET HER RIP
       AXT 0,1
       AXT 0,2
       AXT 0,4
       TRA 2,4         EXIT
       REM
       REM
       REM  GET NEW CONTROL WORD FROM SOMPLACE
       REM
       REM
*65
       SXA SPLAT+63,4 FOR EXIT
       LXA SPLAT+61,1 RESTORE XRA
       NZT* SPLAT+85 IF CONTROL WORD ZERO
       TRA SPLAT+61  RETURN.
       CAL SPLAT+85  OLD CONTROL WORD
       REM
*70
       STT *+1       BRING OUT INDEX
       SXD *+2,0     REGISTER, IF ONE IS TAGED.
       PAC 0,4
       TXI *+1,4,0   GET EFFECTIVE ADDRESS.
       CAL 0,4       NEW CONTROL WORD.
       REM
*75
       PDX 0,1       TYPE WHEEL ID.
       SLW SPLAT+85
       TXI SPLAT+14,4,1 PROCEED
       REM
       REM YOUR AN OLD SMOOOTHY.
       REM
       ORS* SPLAT+88,2 PUT EIGTH IN, TAKE
       TIX SPLAT+44,1,16 16 OUTM, - GOOD BUSINESS
       REM   
*80
       TXL SPLAT+47,1,4 IF NOT BLANK, SET ZONE.
       TRA SPLAT+48    BLANK.
       REM
       MZE             FOR BIT INDEX.
       HTR             DYNAMIC BIT INDEX.
       IOCD CI+2,,24   BUFFER COMMAND
       REM   
*85
       HTR             SPECIAL SALON FOR
       REM             THE CONTROL WORD
       HTR CI+5
       HTR CI+4        BROW ADDRESSES
       HTR CI+27,1
       HTR CI+26,1     ZONE ROW ADDRESSES
       REM
*90  
       HTR CI+21,1
       HTR CI+20,1     DIGIT ROW ADDRESSES
       REM
CI     BSS 26
SUBET  BSS 1
       REM
SPLT1  SWT 2          AND SWITCHES
       TRA *+2        CHECK SWITCH 3
       TRA SPLIT      IGNORE ERROR
       REM
       SWT 3          TEST THREE
       TRA *+2        UP-PRINT
       TRA SPLIT      DOWN-RETURN
       REM
       CLA 1,4
       WPRA
       TMI *+2        SENSE PRINTER
       TRA SPLAT+1
       SPRA 3
       TRA SPLAT+1
       REM
SPLIT  CLA 1,4        SPLAT PROGRAM CONTROL WORD
       STA *+5        SET RETURN ADDRESS
       ARS 18         MOVE DECREMENT TO ADDRESS
       TNZ *+2        ZERO IF REMOTE
       STA *+2        SET RETURN ADDRESS
       TIX *+1,4,2
       TRA **,4       RETURN TO PROGRAM
       REM
START  AXT 32767-TERM,1
       CLA *+4        L TSX SPACE,4
       STO 0,1
       TIX *-1,1,1
       TRA 24
       TSX SPACE,4    CONSTANT
       REM
       REM
A      PZE 8,0,1
       BCD 6DID NOT TRAP CORRECTLY BEFORE DECODI
       BCD 2NG HTR.
       REM
B      PZE 5,0,1
       BCD 5SHOULD NOT TRAP WHEN DISABLED
       REM
C      PZE 8,0,1
       BCD 6DID NOT TRAP CORRECTLY 1 INSTRUCTION
       BCD 2 BEFORE HTR.
       REM
D      PZE 5,0,1
       BCD 5DID NOT TRAP CORRECTLY ON HTR.
       REM
E      PZE 5,0,1
       BCD 5DID NOT TRAP CORRECTLY ON HPR.
       REM
F      PZE 5,0,1
       BCD 5DID NOT TRAP CORRECTLY ON DVH.
       REM
G      PZE 5,0,1
       BCD 5DID NOT TRAP CORRECTLY ON DVP.
       REM
H      PZE 8,0,1
       BCD 6MACHINE TRAPPED AFTER BEING DISABLED
       BCD 2 BY RESET.
       REM
J      PZE 9,0,1
       BCD 6DID NOT TRAP WHEN ENABLED AFTER HAVI
       BCD 3NG BEEN RESET.
       REM
K      PZE 6,0,1
       BCD 6DID NOT TRAP CORRECTLY IN MANUAL.
       REM
L      PZE 7,0,18
       BCD 6MULTI-LEVEL INDIRECT ADDRESSING FAIL
       BCD 1ED
       REM
M      PZE 8,0,1
       BCD 6FP TRAP FAILED TO TAKE PRIORITY OVER
       BCD 2 DS TRAP
       REM
SA     PZE 12,0,1
       BCD 6INSTRUCTION BEING EXECUTED WHEN TRAP
       BCD 6 OCCURRED FAILED COMPLETE OPERATION
       REM
N      PZE 11,0,1
       BCD 6ABOVE ERROR OCCURRED WITH LCH GIVEN
       BCD 5IN TIME-NO TRAP WAS EXPECTED
       REM
P      PZE 9,0,1
       BCD 6ABOVE ERROR OCCURRED TESTING DS COMM
       BCD 3AND TRAP ALONE
       REM
Q      PZE 8,0,1
       BCD 6ABOVE ERROR OCCURRED TESTING EOF TRA
       BCD 2P ALONE
       REM
R      PZE 8,0,1
       BCD 6ABOVE ERROR OCCURRED TESTING RDNCK T
       BCD 2RAP ALONE
       REM
S      PZE 9,0,1
       BCD 6CHANNEL DID NOT STAY ENABLED AFTER T
       BCD 3RAP AND RESTORE
       REM
T      PZE 9,0,1
       BCD 6RESTORE WITH ZEROS DID NOT RESET THE
       BCD 3 PREVIOUS ENABLE
       REM
U      PZE 8,0,1
       BCD 6RDNCK DID NOT TRAP AFTER PREVIOUSLY
       BCD 2BEING TESTED
       REM
V      PZE 8,0,1
       BCD 6SHOULD HAVE INDICATED ALL TRAPS-SAME
       BCD 2 CHANNEL
       REM
W      PZE 12,0,1
       BCD 6SHOULD NOT HAVE TRAPPED-LAST ENABLE
       BCD 6INSTR RESET ALL PREVIOUS ENABLES
       REM
X      PZE 9,0,1
       BCD 6SHOULD NOT HAVE TRAPPED-INHIBITED BY
       BCD 3 LAST PREVIOUS TRAP
       REM
Y      PZE 9,0,1
       BCD 6TRAP DID NOT DELAY FOR SELECT AND RE
       BCD 3SET LOAD CHANNEL
       REM
Z      MZE 12,0,1
       BCD 6TRAP WAS NOT DELAYED UNTIL SELECT AN
       BCD 6D RESET LOAD CHANNEL WERE COMPLETED
       REM
       ORG 4043
AA     PZE 12,0,1
       BCD 6SHOULD NOT HAVE TRAPPED UNTIL AFTER
       BCD 6SECOND SELECT HAS BEEN PERFORMED
       REM
AB     PZE 12,0,1
       BCD 6SHOULD SHOW ALL TRAPS SAME CHAN. EOF
       BCD 6 AND RDNCY TRIGGERS SHOULD BE OFF
       REM
AC     PZE 12,0,1
       BCD 6ERRORS SHOW THAT WHILE ENABLED AND T
       BCD 6RAP COND. - TRIGGERS WERE TURNED OFF
       REM
TERM   EQU 4082
OK     EQU 3401
ERROR  EQU 3396
CTRA   EQU 2884
CTRB   EQU 2885
CTRC   EQU 2886
CTRD   EQU 2887
CTRE   EQU 2888
CTRF   EQU 2889
IOCNT  EQU 2891
IOC    EQU 2892
CTX    EQU 2890
IOCT   EQU 2883
CTRL1  EQU 2880
CTRL2  EQU 2881
CTRL3  EQU 2882
WDNO   EQU 3438
RECNO  EQU 3439
RDNCK  EQU 3440
CNA    EQU NABL
CREAD  EQU CRDFD
       REM
       END
