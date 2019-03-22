                                                             9D01A          
                                                            7-01-58
***********************************************************
*                   9D01A                                 *
*      DRUM DIAGNOSTIC AND RELIABLITY TEST                *
*             ALSO DRUM SPEED TEST                        *
***********************************************************
       REM
       ORG 24
       REM
***********************************************************
*               INITIALIZATION                            *
***********************************************************
       REM
*    SET COUNT FOR BYPASSING LOAD DRUM TEST
       REM
CCCC   SWT 3
       TSX WPRA2,1   TO PRINT HEADING
       REM
       CLA ONE       L 1
       STA CT4
       REM
* TO TEST DRUMS ENTER INTO KEYS ON HALT.
* DRUM 1-KEY 1, DRUM 2-KEY 2, DRUM 3-KEY 3,
* DRUM 4-KEY 4, ......................DRUM 16-KEY 16
       REM
* KEYS MAY BE CHANGED TO CHANGE SELECTION
* ANYTIME AFTER START KEY IS DEPRESSED
       REM
* SWITCH FIVE DOWN TO SELECT LONG LDA TEST
       REM
       REM
       HTR *+1
       REM
*     CLEAR DRUM CONTROL IMAGE
       REM
       LXA T20,1    L 20
CC     STZ DCC,1
       TIX CC,1,1
       REM
       CLA T20      L+20
       STO Z20      COUNT FOR IND CNTRL
       REM
       ENK          BRING IN DRUMS TO TEST
       STQ CNTRL
       AXT 0,3
       LDI CNTRL    PLACE KEYS IN INDICATORS
HUNT   LNT 200000   TEST FOR INDICATORS
       TRA *+4      IF NO BIT GO TO DECR. ADDR.
       CLA K301,1   CORRECT DRUM SELECTED
       STO DC1,2    PLACE IN CONTROL IMAGE
       TXI *+1,2,-1 DECREMENT CONTROL IMAGE
       TXI *+1,1,-1 DECREMENT CORRECT DRUM
       CLA Z20      L+20
       SUB ONE      L+1 - FOR COUNT OF SHIFTS
       STO Z20      SAVE COUNT
       TZE DS-6
       CLA HUNT     L LNT INSTRUCTION
       ARS 1        SHIFT TO TEST NEXT IND.
       STA HUNT     STORE NEW ADDR
       STT HUNT     STORE NEW TAG
       TRA HUNT
       REM
*RESTORE INITIAL LNT INSTRUCTION
       REM
       CLA RESTR    L LNT INSTR
       STO HUNT     RESTORE HUNT
       AXT 0,2      CLEAR XRB
       REM
*     SELECT CORRECT DRUM TO BE TESTED
       REM
       CLA T20      L 20
       STA DC
       SLF          TURN OFF ALL SENSE LIGHT
DS     LXA DC,1
       CLA DCC,1
       STA DCC      SAVE 
       TZE SW6      HAVE ALL DRUMS BEEN TESTED
       REM
       CAS K310     L 310
       TRA HIGH     Y LESS AC FR3 OR FR4
       TRA F2       Y EQUAL AC
       CAS K304     L 304
       TRA F2       Y LESS AC
       TRA DR4      Y EQUAL AC
       CAS K302     L 302
       TRA DR3      Y LESS AC
       TRA DR2      Y EQUAL AC
       TRA DR1      Y GREATER AC
       REM
F2     CAS K306     L 3056
       TRA F2+4     Y LESS AC
       TRA DR6      Y EQUAL AC
       TRA DR5      Y GREATER AC
       SUB K307     L 307
       TZE DR7
       TRA DR8
       REM
HIGH   CAS K314     L 314
       TRA FR4      Y LESS AC
       TRA DR4      Y EQUAL AC DR14
       CAS K312     L 312
       TRA DR3      Y LESS AC DR13
       TRA DR2      Y EQUAL AC DR12
       TRA DR1      Y GREATER AC DR11
       REM
FR4    CAS K316     L 316
       TRA FR4+4    Y LESS AC
       TRA DR6      Y EQUAL AC DR 16
       TRA DR5      Y GREATER AC DR15
       SUB K317     L 317
       TZE DR7      DR 17
       TRA DR8      DR 20
       REM
       REM
*   TURN ON LIGHTS FOR SELECTED DRUM OF FR1 OR FR2
       REM
DR1    SLN 1        TURN ON LIGHT 1
       TRA DR8  
DR2    SLN 2        TURN ON LIGHT 2
       TRA DR8  
DR3    SLN 1        TURN ON LIGHT 1
       SLN 2        TURN ON LIGHT 2
       TRA DR8  
DR4    SLN 3        TURN ON LIGHT 3
       TRA DR8  
       REM
*   TURN ON LIGHTS FOR SELECTED DRUM OF FR2 OR FR4
       REM
DR5    SLN 1        TURN ON LIGHT 1
       SLN 3        TURN ON LIGHT 3
       TRA DR8  
DR6    SLN 2        TURN ON LIGHT 2
       SLN 3        TURN ON LIGHT 3
       TRA DR8  
DR7    SLN 1        TURN ON LIGHT 1
       SLN 2        TURN ON LIGHT 2
       SLN 3        TURN ON LIGHT 3
       TRA DR8  
       REM
*   STORE SELECTED DRUM ADDRESS IN ALL RDS AND WRS INSTRUCTIONS
       REM
DR8    CLA DCC      SELECTED DRUM ADDRESS
       STA A+1
       STA A1
       STA A2
       STA CPYNO+1
       STA LDAA
       STA LDAB-2
       STA 1LDA
       STA LDA5+2
       STA LDA7+4
       STA DRUM
       STA DR+3
       REM
       STA R10
       STA A7+1
       STA A9
       STA A11
       STA TPU
       STA TP1
       STA TP2
       STA TP3
       STA TP4
       STA TP5
       REM
       STA R
       STA R3
       STA R4
       STA R13
       STA R14
       REM
       STA D500
       STA L62
       STA L62A
       REM
       STA BEGIN+4
       STA BUG
       STA AGAIN+1
       STA AGAIN+8
       STA INDEX+10
       STA BUGS
       STA BUGS+19
       STA BUGS+22
       REM
*   ADJUST DUMMY INSTRUCTIONS FOR PRINT ROUTINE
       REM
       REM
       CLA DRUM      L ADDRESS OF SELECTED DRUM
       SUB K300      L 300
       REM
       CAS K10       L 10
       TRA UP        Y LESS AC
       TRA FM2       Y EQUAL AC
       CAS K4        L 4
       TRA FM2       Y LESS AC
       TRA D4        Y EQUAL AC
       CAS TWO       L 2
       TRA D3        Y LESS AC
       TRA D2        Y EQUAL AC
       TRA D1        Y GREATER AC
       REM
FM2    CAS D6B       L+6
       TRA FM2+4     Y LESS AC
       TRA D6        Y EQUAL AC
       TRA D5        Y GREATER AC
       SUB D7B
       TZE D7
       TRA D10
       REM
UP     CAS K14       L 14
       TRA FM4       Y LESS AC
       TRA D14       Y EQUAL AC
       CAS K12       L 12
       TRA D13       Y LESS AC
       TRA D12       Y EQUAL AC
       TRA D11
       REM
FM4    CAS K16       L 16
       TRA FM4+4     Y LESS AC
       TRA D16       Y EQUAL AC
       TRA D15
       SUB K17       L 17
       TZE D17
       TRA D20
       REM
D1     CLA D1B       L 00 01
       TRA SD
D2     CLA D2B       L 00 02
       TRA SD
D3     CLA D3B       L 00 03
       TRA SD
D4     CLA D4B       L 00 04
       TRA SD
D5     CLA D5B       L 00 05
       TRA SD
D6     CLA D6B       L 00 06
       TRA SD
D7     CLA D7B       L 00 07
       TRA SD
D10    CLA D8B       L 00 10
       TRA SD
D11    CLA D9B       L 00 11
       TRA SD
D12    CLA D10B      L 01 00
       TRA SD
D13    CLA D11B      L 01 01
       TRA SD
D14    CLA D12B      L 01 02
       TRA SD
D15    CLA D13B      L 01 03
       TRA SD
D16    CLA D14B      L 01 04
       TRA SD
D17    CLA D15B      L 01 05
       TRA SD
D20    CLA D16B      L 01 06
       REM
SD     STA DUMY
       REM
       CLA MASK1     TO SET UP PASS IMAGE
       LXA TWTY,4    L 24
       ANS PRIMG+21,4 CLEAR DRUM ADDR BITS
       TIX *-1,4,2
       REM
       CLA DUMY      L DRUM UNIT
       ANA K17       L 17
       ALS 1         DOUBLE ADDR
       PAX 0,4       DRUM ADDR TO INDEX
       CLA LBIT      L 4000000
       ORS PRIMG+19,4 OR IN LOW BIT
       REM
       CLA DUMY      L DRUM UNIT
       ANA K3700     L 3700
       ARS 5         SHIFT INTO PLACE
       PAX 0,4       DRUM ADDR TO INDEX
       CLA HBIT      L 10000000
       ORS PRIMG+19,4 OR IN HIGH BIT
       REM
DMR    CLA DUMY
       ORA RDR       L 512451600000
       SLW A1-1
       SLW A2-1
       SLW LDAB-3
       SLW DR-1
       SLW A11-1
       SLW D500-1
       SLW R15-1
       REM
DML    CLA DUMY
       ORA LDA      L 432421600000 
       SLW R4-1
       SLW 1LDA-1
       SLW LDA5-1
       SLW TP1-1
       SLW TP2-1
       SLW TP3-1
       SLW TP5-1
       SLW R10-1
       SLW L62A-1 
       REM
*    ADJUST CONSTANTS FOR PRINT ROUTINE
       REM
       CLA K4000     L 4000
       STO WDNO
       CLA ONE
       STO RECNO     SET REC NO CONSTANT
       REM
*    ADJUST FOR SELECTING NEXT DRUM
       REM
DND    TIX DND+1,1,1,
       PXD 0,1
       ARS 18
       STA DC
       REM
       REM
*    ENTER LOAD DRUM TEST FOR DRUM 1 ONLY
       REM
       CLA K301      L 301
       SUB DRUM      SELECT DRUM
       TMI NP
       REM
*    BYPASS LOAD DRUM TEST WHEN REPEATING TESTS
       REM
       CLA ONE       L 1
       SUB CT4       INIT LOAD 1
       TMI NP
       CLA CT4
       ADD ONE       L 1
       STA CT4
       TRA LOAD
       REM
********************************************************************
*                  TEST LOAD DRUM                                  *
********************************************************************
       REM
       BCD 1WDR 01
LOAD   WDR 1
       CPY K3        L TRA LOAD1
       CPY K2        L TRA LOAD+4
       HTR 0         PRESS LOAD DRUM BUTTON
       LDQ K3
       CLA 0
       TSX ERROR-1,4 TRANSFERED TO 1 INSTEAD OF 0
       TRA LOAD
       REM
LOAD1  CLA 1
       CAS K2       L TRA LOAD+4
       TRA LOAD1+4  ERROR
       TRA LOAD1+6  OK
       LDQ K2
       TSX ERROR,4  DID NOT LOAD CORRECT
       REM          INFORMATION INTO ADDRESS
       TSX OK,4
       TRA LOAD
       REM
*            POST RESTART
       REM
       NOP
NP     CLA K5       L TRA CCCC+4
       STO 0
       STO RN+63    PRIME RN GEN
       REM
********************************************************************
*         ENTER ALL ZEROS TEST AND ALL ONES TEST                   *
********************************************************************
       REM
AA     CLA TEST1    L +0
       STO T1
       SLT 4        TURN OFF SENSE LIGHT 4
       NOP
       REM
*     TEST WRITE ON DRUM
       REM
A      LXA K4000,1  L 4000
       WRS          WRITE ON SELECTED DRUM
       CPY T1
       TIX A+2,1,1
       TSX OK,4
       TRA A        LOOP IN WRITE ON DRUM
       REM
*     TEST READ ON DRUM
       REM
       BCD 1RDR
A1     RDS          READ OUT DRUM TO INSURE
       REM          THAT READING DOES NOT
       REM          AFFECT STORED INFO
       LXA K4000,1  L 4000
       CPY X-1
       TIX A1+2,1,1
       TSX OK,4
       TRA A1       LOOP IN DRUM READ OUT
       REM
*     READ DRUM INTO STORAGE
       REM
       BCD 1RDR
A2     RDS 
       LXA K4000,1  L 4000
       CPY X,1      COPY DRUM INTO STORAGE
       TIX A2+2,1,1
       REM
       LXA K4000,1  L 4000
A3     CLA X,1      ERROR WORD IN ACC
       CAS T1
       TRA A3+4     ERROR
       TRA A4       OK
       LDQ T1       CORRECT WORD
       TSX ERROR-2,4
       TRA A2
       REM
A4     TIX A3,1,1
       TSX OK,4
       TRA A2
       REM
       NOP
A5     SLT 4        TEST SENSE LIGHT 4
       TRA A5+3     ENTER ALL ONES TEST
       TRA CPYNO    ALL ONES TEST COMPLETED
       CLA TEST2    L ALL ONES
       STO T1
       SLN 4        TURN ON SENSE LIGHT 4
       TRA A        ENTER ALL ONES TEST
       REM
********************************************************************
*        TEST FOR A SLIVER ANA CPY TIMING CONDITION                *
********************************************************************
       REM
CPYNO  LXA K50,1
       WRS 
       CPY ONES     IOT MAY COME UP HERE
       ANA          36 US INSTR-THIS INSTR.
       REM          MAY BE CHANGED MANUALLY
       REM          FOR CHANGE IN TIMING
       CPY ONES
       TIX CPYNO+2,1,1
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2      ERROR-SHBE OFF
       TRA *+3      OK
       TSX ERROR-1,4 IOT ON TIMING
       TXL *-4,4    BETWEEN COPYS LESS THEN
       TSX OK,4     36US
       TRA CPYNO
       NOP
       REM
       REM
***************************************************************
*      SHORT LDA TEST WRITTEN PRIMARILY TO BE                 *
*      IDENTICAL WITH THE LAD PATTERN USED IN                 *
*      THE WORST PATTER TEST WHICH FOLLOWS                    *
*      SO THAT IF AN ERROR OCCURS IN THE WORST PATTERN        *
*      TEST THE POSSIBILIY OF IT BEING AN LDA ERROR           *
*      MAY BE ELIMINATED.                                     *
***************************************************************
       REM
L61    STZ LD37
       LXA K4000,1   L 4000
       REM
L62    WRS
       LDA LD37
       CPY LD37
       CLA LD37
       ADD K62       L 62
       STO LD37      ADJUST LDA
       LDQ TP
       RQL 1
       STQ TP
       TIX L62,1,50
       REM
       LXA K4000,1   L 4000
       STZ LD37
       TRA L62A
       REM
       BCD 1LDA
L62A   RDS
       LDA LD37
       CPY WPA
       CLA WPA       WORD READ
       CAS LD37
       TRA L62A+7    ERROR-LDA
       TRA L62B      OK
       LDQ LD37      ERROR-LDA
       TSX ERROR-2,4
       TRA L62A
       REM
L62B   CLA LD37
       ADD K62
       STO LD37
       LDQ TPP
       RQL 1
       STQ TPP
       TIX L62A,1,50 NEXT PASS
       TSX OK,4
       TRA L61
       REM
********************************************************************
*       ENTER WORST PATTERN TEST                                   *
********************************************************************
       REM
       NOP
A6     CLA TEST1    L +0
       STO T1
       SLT 4        TURN LIGHT 4 OFF
       NOP
       CLA ONE      L 1
       STO T5
       REM
*      LOAD DRUM WITH ALL ZEROS
       REM
A7     LXA K4000,1
       WRS 
       CPY T1
       TIX A7+2,1,1
       TSX OK,4
       TRA A7       WRITE LOOP
       REM
*      WRITE 41 TEST WORDS WELL SPACED ON DRUM JUST LOADED
       REM
       NOP
       LXA K4000,1  L 4000
       STZ LD37
       LDQ T5
       STQ TP
       STQ TPP
       REM
A9     WRS
       LDA LD37
       CPY TP
       CLA LD37
       ADD K62      L 62
       STO LD37
       LDQ TP       ADJUST FOR WRITTING
       RQL 1        NEXT TEST WORD
       STQ TP
       TIX A9,1,50
       REM
*      READ DRUM INTO STORAGE AND COMPARE
       REM
       LXA K4000,1  L 40000
       STZ LD37
       TRA A11
       REM
*      AN ERROR HERE IS MOST LIKELY DUE TO DROPPING 
*      OR PICKING UP A BIT AND WOULD THEREFORE
*      BE A WRITE OR READ ERROR. ONLY WHEN THE
*      LDA TEST, WHICH IMMEDIATELY PRECEDES THIS TEST.
*      FAILS SHOULD AN LDA ERROR BE CONSIDERED.
       REM
       BCD 1RDR
A11    RDS
       LDA LD37
       CPY WPA
       CLA WPA
       CAS TPP
       TRA A11+7    ERROR
       TRA A12      OK
       LDQ TPP      ERROR
       TSX ERROR-2,4
       TRA A11
A12    CLA LD37     ADJUST FOR NEXT LDA
       ADD K62      L 62
       STA LD37
       LDQ TPP
       RQL 1        SHIFT WORD
       STQ TPP
       TIX A11,1,50 NEXT PASS
       TSX OK,4
       TRA A6       REPEAT TEST
       REM
*      ENTER ALTERNATE WORST PATTERN
       REM
       NOP
A15    MSE 100      TEST LIGHT 4
       TRA A15+3
       TRA TPU
       CLA KP0      L 777 777 777 776
       STO T5
       CLA TEST2
       STO T1
       SLN 4        TURN ON SENSE LIGHT FOUR
       TRA A7
       REM
********************************************************************
*      ENTER TIMINIG PULSE TEST                                    *
********************************************************************
       REM
*      LOAD ENTIRE DRUM BEGINNING AT LOCATION LDA 3472
       REM
TPU    WRS
       LXA K3777,1  L 3777
       LDA K3472    L 3472
       CPY TEST2    L ALL ONES
       CPY TEST1    L 0
       TIX TPU+4,1,1
       TSX OK,4
       TRA TPU      REPEAT TEST6
       REM
*      CHECK LOCATION LDA 3472
       REM
       BCD 1LDA
TP1    RDS
       LXA K306,1   ADJUST FOR PRINT PROGRAM
       LDA K3472    L 3472
       CPY WPA
       CLA WPA      WORD READ
       CAS TEST2    L ALL ONES
       TRA TP1+8    ERROR
       TRA TP2      OK
       LDQ TEST2    ERROR
       TSX ERROR-2,4
       TRA TP1
       TRA TP2
       REM
*      CHECK LOCATION ZERO
       REM
       REM
       BCD 1LDA
TP2    RDS
       LXA K4000,1  ADJUST FOR PRINT PROGRAM
       LDA ZERO
       CPY WPA
       CLA WPA      WORD READ
       CAS TEST1    L 0
       TRA TP2+8    ERROR
       TRA TP3      OK
       LDQ TEST1    ERROR-CORRECT WORD
       TSX ERROR-2,4
       TRA TP2
       TRA TP3
       REM
*      CHECK LOCATION 3777
       REM
       BCD 1LDA
TP3    RDS
       LXA ONE,1     ADJUST FOR PRINT PROGRAM
       LDA K3777    L 3777
       CPY WPA
       CLA WPA      WORD READ
       CAS TEST1    L 0
       TRA TP3+8    ERROR
       TRA TP4      OK
       LDQ TEST1    ERROR-CORRECT WORD
       TSX ERROR-2,4
       TRA TP3
       REM
*      LOAD DRUM AGAIN AND WRITE OVER STARTING LDA 307 WITH NEW WORD
       REM
TP4    WRS
       LXA K3777,1  L 3777
       LDA K307     L 307
       CPY TEST2    L ONES
       CPY TEST1    L 0
       TIX TP4+4,1,1
       CPY TEST3    L 252525252525
       TSX OK,4
       TRA TP4
       REM
*      CHECK LDA 307 AFTER WRITING WITH NEW WORD
       REM
       BCD 1LDA
TP5    RDS
       LXA K3471,1  ADJUST FOR RPINT PROGRAM
       LDA K307     L 307
       CPY WPA
       CLA WPA      WORD READ
       CAS TEST3    L 0
       TRA TP5+8    ERROR
       TRA TP6
       LDQ TEST3    ERROR-CORRECT WORD
       TSX ERROR-2,4
       TRA TP5
TP6    TSX OK,4
       TRA TPU      REPEAT TEST
       REM
********************************************************************
*                  ENTER LDA TEST                                  *
********************************************************************
       REM
       BCD 1WDR
LDAA   WRS
       LXA K4000,1   L 4000
       CLA ZERO      L 0
       STO X,1       LOAD STORAGE WITH INFOR
       ADD K6        L+2000001
       TIX LDAA+3,1,1
       REM
*     WRITE DRUM ADDRESSES IN THE ADDRESS ON THE DRUM
*     THE DECREMENT CONTAINS THE POCKET AND THE ADDRESS THE ADDRESS
       REM
       LXA K4000,1   L+4000
LDA1   CPY X,1
       TIX LDA1,1,1  LOAD DRUM
       TSX OK,4
       TRA LDAA      LOOP IN WRITE ROUTINE
       REM
*     CLEAR STORAGE
       REM
       NOP
       LXA K4000,1   L 4000
LDA1A  STZ X,1
       TIX LDA1A,1,1
       TRA LDAB-2
       REM
*     READ ENTIRE DRUM INTO STORAGE
       REM
       BCD 1RDR
       RDS
       LXA K4000,1   L 4000
LDAB   CPY X,1
       TIX LDAB,1,1
       REM
*     COMPARE THE WORD READ TO THE WORD WRITTEN
       REM
       LXA K4000,1   L 4000
       CLA ZERO      L 0
LDAC   CAS X,1
       TRA LDAC+3    ERROR
       TRA LDAD      OK
       LDQ X,1       ERROR WORD
       XCA           ERROR WORD TO ACC
       REM           CORRECT WORD TO MQ
       TSX ERROR-2,4
       TRA LDAB-2
       XCA           RESTORE ACC AND MQ
       REM
LDAD   ADD K6        L+2000001
       TIX LDAC,1,1
       TRA *+2
       REM
******  TEST LDA TRANSMISSION TO MQ ******
       REM
       BCD 1LDA
1LDA   RDS
       LDA K3777    L 3777
       STQ LDA10
       CPY X-1      IF I/O COMES UP
       REM          HERE,CHECK THE DRUM COUNTER
       REM          ON PAGE 7.02.01
       REM
       CLA LDA10
       SUB K7776    L 7775
       TZE 1LDA+8
       TSX ERROR,4
       TSX OK,4
       TRA 1LDA
       REM
       BCD 1IOT
       REM
       IOT
       TRA *+2      ERROR-SHBE OFF
       TRA *+3
       TSX ERROR-1,4
       TXL *-4,4
       REM
*      TEST SW 5 FOR ENTRY INTO SHORT OR LONG LDA TEST
       REM
PICK   SWT 5
       TRA NSEQ
       REM
*      ADJUST CONSTANTS FOR SEQUENTIAL LDA TEST
       REM
       CLA K6+1     L DEC 10, ADR 400
       STO K
       CLA K6+2     L DEC 1000, ADR 400
       STO K+1
       CLA K7       L DEC 10776, ADR 4377
       STO K+2
       CLA K6+1     L DEC 10, ADR 400
       ALS 18
       STD LDA8-5
       CLA K+6      L DEC 3377, ADR 3757
       STD LDA8-2
       TRA LDA5
       REM
*      ADJUST CONSTANTS FOR NON-SEQUENTIAL LDA TEST
       REM
NSEQ   CLA K+3      L DEC 200, ADR 20
       STO K
       CLA K+4      L DEC 40, ADR 20
       STO K+1
       CLA K+5      L DEC 10036, ADR 4017
       STO K+2
       CLA K+3      L DEC 200, ADR 20
       ALS 18
       STD LDA8-5
       CLA K+6      L DEC 3377, ADR 3757
       ALS 18
       STD LDA8-2
       TRA LDA5
       REM
*      LOCATE ALL DRUM ADDRESSES IN THE DRUM COUNTER SEQUENCE AND CHECK
       REM
       BCD 1LDA
LDA5   CLA ZERO     L 0
       STO CSC      CLEAR CHECK SUM COUNTER
       RDS
       CLA K6       L +2000001
       STA LDA10    SET LDA COUNTER TO ONE
       LXA K6+3,1   L+37877 ADJUST XRA FOR
       REM          PRINT PROGRAM
       REM
       LXA K,2
       LXD K,4
LDA6   LDA LDA10
       CPY T2       TEMP STORAGE
       CAS T2
       TRA LDA6+5   ERROR
       TRA LDA7     OK
       LDQ T2       WORD READ IN MQ
       XCA          CORRECT WORD TO MQ
       REM          ERROR WORD TO ACC
       SXD T1,4     SAVE INDEX COUNT
       SXA T1,2     SAVE XRB
       AXT 0,2      CLEAR XRB
       TSX ERROR-2,4 MQ CONTAINS POCKET NUMBER
       REM           IN ITS DEC, AND DRUM
       REM           ADDRESS IN ITS ADDRESS
       TRA LDA5
       XCA           RESTORE ACC AND MQ
       LXA T1,2      RESTORE XRB
       REM
       REM
       REM
       LXD T1,4      RESTORE INDEX COUNT
LDA7   STO T1        SAVE ACCUMULATOR
       CLA T2        WORD READ
       ACL CSC
       STO CSC       INCREASE CHECK SUM COUNTER
       REM
       REM
       RDS
       CLA T1        RESTORE ACCUMULATOR
       ADD K+1       INCREATE THE PKT AND ADR
       CAS K+2
       REM
*     THE APPROACH OF ADDRESS ZERO
       REM
       HTR LDA7+10   SHOULD NEVER ENTER HERE
       TRA LDA8      THE NEXT ADDRESS IS ZERO
       STA LDA10
       TIX LDA7+12,1,0 ADJUST XRA FOR PRINT
       TIX LDA6,4,1  
       REM
       REM
       SUB K6+3      L+7776003777-INCREAESE
       REM           SECTOR BY A COUNT OF ONE
       TXI LDA8-1,1,0  ADJUST FOR PRINT PROG
       TRA LDA8+2
       REM
LDA8   CLA ZERO      L 0
       LXA K4000,1   ADJUST FOR PRINT PROGRAM
       STA LDA10
       TIX LDA6-1,2,1
       REM
       CPY X-1       DRUM DISCONNECT
       CLA CS        GENERATE CHECK SUM
       CAS CSC
       TRA LDA8+9    ERROR IN CHECK SUM
       TRA LDA9      CHECK SUM
       AXT 0,2       CLEAR XRB
       LDQ CSC       CORRECT CHECK SUM
       XCA 
       TSX ERROR-2,4 ERROR IN CHECK SUM
       TRA LDA5
LDA9   TSX OK,4
       TRA LDA5
       NOP
********************************************************************
*                                                                  *
*     THIS IS A RIPPLE LDA SWITCHING PHYSICAL DRUMS TEST           *
*                                                                  *
********************************************************************
       REM
*      SELECT CORRECT FRAME
       REM
       REM
DAS    CLA DRUM      L DRUM ADDRESS
       SUB K311      L 311
       TMI DL01      DRUM 1 OR 2
       REM
DHI    SUB K4        L 4
       TMI DH1       DRUM FRAME 3
       REM
DH2    CLA K315      L 315 F4
       STA DA        SAVE
       STA DST       L WRS INST
       CLA D13B      L 0103
       ORA LDA
       SLW LCP1-1
       REM
       CLA D14B      L 0104
       ORA LDA
       SLW LCP2-1
       REM
       CLA D15B      L 0105
       ORA LDA
       SLW LCP3-1
       REM
       CLA D16B      L 0106
       ORA LDA
       SLW LCP4-1
       REM
       TRA DST-1     START
       REM
DH1    CLA K311      L 311 F3
       STA DA        SAVE
       STA DST       L WRS INST
       REM
       CLA D9B       L 0011
       ORA LDA
       SLW LCP1-1
       REM
       CLA D10B      L 0100
       ORA LDA
       SLW LCP2-1
       REM
       CLA D11B      L 0101
       ORA LDA
       SLW LCP3-1
       REM
       CLA D12B      L 0102
       ORA LDA
       SLW LCP4-1
       REM
       TRA DST-1     START
       REM
DL01   CLA DRUM
       SUB K305      L 305
       TMI DL1       DRUM FRAME 1
       REM
DL02   CLA K305      L 305 F2
       STA DA        SAVE
       STA DST       L WRS INST
       REM
       CLA D5B       L 0005
       ORA LDA
       SLW LCP1-1
       REM
       CLA D6B       L 0006
       ORA LDA
       SLW LCP2-1
       REM
       CLA D7B       L 0007
       ORA LDA
       SLW LCP3-1
       REM
       CLA D8B       L 0010
       ORA LDA
       SLW LCP4-1
       REM
       TRA DST-1     START
       REM
DL1    CLA K301      L 301 F1
       STA DA        SAVE
       STA DST       L WRS INST
       REM
       CLA D1B       L 0001
       ORA LDA
       SLW LCP1-1
       REM
       CLA D2B       L 0002
       ORA LDA
       SLW LCP2-1
       REM
       CLA D3B       L 0003
       ORA LDA
       SLW LCP3-1
       REM
       CLA D4B       L 0004
       ORA LDA
       SLW LCP4-1
       REM
*      LOAD ALL DRUMS COMPLETE WITH 25 PATTERN
       REM
       LXA K4,4     L 4
DST    WRS 
       LXA K4000,1  L 4000
       CPY TEST3    L 25 PATTERN
       TIX DST+2,1,1
       REM
       CLA DST
       ADD ONE      L ONE
       STA DST
       TIX DST,4,1  LOAD ALL DRUMS
       REM
*      ENTER LDA RIPPLE SWITCHING PHYSICAL DRUM
       REM
DST0   CLA DA
       STA DST      RESTORE
       STA LWD1     DRUM ONE OF SELECTED FR
       STA LRD1     
       ADD ONE      L ONE
       STA LWD2     DRUM TWO OF SELECTED FR
       STA LRD2     
       ADD ONE      L ONE
       STA LWD3     
       STA LRD3     DRUM THREE OF SELECTED FR
       ADD ONE      L ONE
       STA LWD4     DRUM FOUR OF SELECTED FR
       STA LRD4     
       REM
*     WRITE SINGLE WORDS ON ALL DRUMSWITH ASCENDING LDA ADDRESS
       REM
LWD1   WRS 
       LDA D02      L 4000002
       CPY D02
       REM
       REM
LWD3   WRS 
       LDA D52      L 124000252
       CPY D52
       REM
LWD2   WRS 
       LDA D252     L 524000252
       CPY D252
       REM
       REM
LWD4   WRS 
       LDA D1252    L 2524001252
       CPY D1252
       REM
*     READ SINGLE WORDS FROM LDA S JUST WRITTEN
       REM
LRD1   RDS 
       LDA D02      L 4000002
       CPY D111     L 0
       REM
LRD3   RDS 
       LDA D52      L 124000252
       CPY D333     L 0
       REM
LRD2   RDS 
       LDA D252     L 524000252
       CPY D222     L 0
       REM
LRD4   RDS 
       LDA D1252    L 2524001252
       CPY D444     L 0
       TRA LCP1
       REM
*      CHECK FOR CORRECT LDA EXECUTION FOR DRUM 1
       REM
       BCD 1LDA
LCP1   CLA D02      L 40000002
       CAS D111
       TRA LCP1+4   ERROR
       TRA LCP2     OK
       LDQ D111     ERROR
       XCA
       TSX ERROR-2,4
       TRA LCP1
       TRA LCP2
       REM
*      CHECK FOR CORRECT LDA EXECUTION FOR DRUM 2
       REM
       BCD 1LDA
LCP2   CLA D252     L 124000252
       CAS D222
       TRA LCP2+4   ERROR
       TRA LCP3     OK
       LDQ D222     ERROR
       XCA
       TSX ERROR-2,4
       TRA LCP2
       TRA LCP3
       REM
*      CHECK FOR CORRECT LDA EXECUTION FOR DRUM 3
       REM
       BCD 1LDA
LCP3   CLA D52     L 524000252
       CAS D333
       TRA LCP3+4   ERROR
       TRA LCP4     OK
       LDQ D333     ERROR
       XCA
       TSX ERROR-2,4
       TRA LCP3
       TRA LCP4
       REM
*      CHECK FOR CORRECT LDA EXECUTION FOR DRUM 4
       REM
       BCD 1LDA
LCP4   CLA D1252    L 2524001252
       CAS D444
       TRA LCP4+4   ERROR
       TRA LEND     OK
       LDQ D444     ERROR
       XCA
       TSX ERROR-2,4
       TRA LCP4
       REM
LEND   TSX OK,4
       TRA DAS
       NOP
       REM
********************************************************************
*               WORST SWITCHING CONDITIONS TEST                    *
********************************************************************
       REM
*     SELECT CORRECT DRUM FRAME FOR THE DRUM BEING TESTED
       REM
       CLA TEST3     L 25 PATTERN
       STO T3
       CLA TEST4     L 52 PATTERN
       STO T4
       CLA TWO       L 2
       STO T5
       CLA TWO       L 2
       STA CT3
FR     SLT 4         TURN OFF SENSE LIGHT 4
       NOP
       CLA DRUM      L ADDRESS OF SELECTED DRUM
       SUB K311      L 311
       TMI 1OR2
       REM
3OR4   SUB K15       L 15
       TMI FR3
       REM
FRM4   CLA K315      L 315
       STA DA
       STA DL
       TRA SET-4
       REM
FR3    CLA K311      L 311
       STA DA
       STA DL
       TRA SET-4
       REM
1OR2   SUB D5B       L 5
       TMI FR1
       REM
FR2    CLA K305      L 305
       STA DA
       STA DL
       TRA SET-4
       REM
FR1    CLA K301      L 301
       STA DA
       STA DL
       REM
*   ADJUST CONSTANTS FOR LOAD AND TEST PATTERNS
       REM
       CLA ZERO      L 0
       STO LDA3
       CLA K400      L 400
       STA LDA4
SET    CLA K400      ADJUST PRINT PROGRAM
       STA WDNO
       CLA TWO       L 2
       STO CT2
       CLA TWO       L 2
       STO CT1
       LXA K4,2      L 4
       CLA LDA3      L 0
       STO LDA2
       REM
*    WRITE LOAD PATTERN TWICE ON ALL DRUMS OF FRAME SELECTED
       REM
DL     WRS
       LXA K400,1    L 400
       LDA LDA2
       CPY T3        L 25252525252525
       TIX DL+3,1,1
       REM
       TSX OK,4
       TRA DL
       REM
       NOP
       CLA LDA2      ADJUST LDA FOR TEST
       REM           PASS ON DRUM
       ADD K1000     L 1000
       STO LDA2
       TIX DL,2,1
       REM
       CLA CT1       IS THIS DRUM LOADED
       SUB ONE       L 1
       TZE DL2       YES
       STA CT1       NO
       REM
       CLA LDA4      L 400 ADJUST LDA
       STA LDA2      FOR LOADING SECOND HALF
       REM           OF DRUM
       CLA T3        REVERSE LOAD
       LDQ T4        AND TEST PATTERN
       STO T4
       STQ T3
       LXA K4,2      L 4
       TRA DL        LOAD SECOND HALF OF DRUM
       REM
*     LOAD ENTIRE DRUM AGAIN WITH SAME PATTERN
       REM
DL2    SLT 4         TEST SENSE LIGHT 4
       TRA DL2+3
       TRA DR        HAS TEST PATTERN BEEN
       REM           WRITTEN ON TEST DRUM
       REM           IF SO, PREPARE TO READ
       REM
       REM
       CLA CT2       L 2
       SUB ONE       HAS DRUM BEEN LOADED TWICE
       TZE DN        YES
       STA CT2       NO
       REM
       REM
       CLA T3        REVERSE LOAD
       LDQ T4        AND TEST PATTERN
       STO T4        TO ORIGINAL SETTINGS
       STQ T3
       TRA DL-5
       REM
       REM
*     LOAD REMAINING DRUM IN SELECTED
       REM
DN     CLA DA        ADJUST DRUM ADDRESS
       ADD ONE       FOR LOADING NEXT DRUM
       STA DA
       STA DL
       REM
*    HAVE ALL DRUMS IN SELECTED FRAME BEEN LOADED TWICE
       REM
       SUB K321      L 321
       TZE DT        YES
       REM
       CLA DA
       SUB K315      L 315
       TZE DT        YES
       REM
       CAL DA
       SUB K311 
       TZE DT        YES
       REM
       CLA DA
       SUB K305    
       TZE DT        YES
       TRA SET-4     NO LOAD NEXT DRUM
       REM
*     WRITE TEST PATTERN ONCE ON THE DRUM TO BE TESTED
       REM
DT     SLN 4         TURN ON LIGHT 4
       CLA DRUM
       STA DL
       TRA SET+4
       REM
*     ALL DRUM IN THIS FRAME HAVE NOW BEEN LOADED FOR TEST
       REM
       REM
*                READ TEST DRUM INTO STORAGE
       REM
       BCD 1RDR
DR     LXA TEN,2     L 10
       CLA ZERO      L 0
       STO LDA2
       RDS 
       LXA K400,1    L 400
       LDA LDA2
       CPY X,1
       TIX DR+6,1,1
       REM
*     COMPARE WORD READ FROM DRUM TO TEST WORD
       REM
       LXA K400,1     L 400
       CLA X,1        WORD READ
       CAS T4
       TRA DR+13      ERROR-COMPLEMENTED PATTERN
       TRA DR+19      OK
       SXA T1,2       SAVE XRB
       AXT 0,2        CLEAR XRB
       LDQ T4         ERROR ADDRESS IS
       REM            NUMBER AT WDNO
       TSX ERROR-2,4
       TRA DR
       LXA T1,2       RESTORE XRB
       TIX *-10,1,1
       REM
       CLA LDA2       ADJUST LDA
       ADD K400       L 400
       STA LDA2
       ADD K400       ADJUST PRINT PROGRAM
       STO WDNO
       CLA T3         REVERSE TEST WORDS
       LDQ T4
       STO T4
       STQ T3
       TIX DR+3,2,1
       TSX OK,4
       TRA FR
       REM
*    REVERSE PROCEDURE OF WRITING ON DRUMS AND REPEAT TEST
       REM
       NOP
FRR    CLA K400       L 400 REVERSE
       STO LDA3       LDA PATTERN FOR
       CLA ZERO       LOADING DRUMS
       STO LDA4
       CLA CT3        HAS REVERSE LOADING
       SUB ONE        PROCEDURE BEEN DONE
       TZE FRE        YES
       TMI FRE
       STA CT3        NO
       TRA FR
       REM
FRE    TSX OK,4
       TRA FR-8
       REM
********************************************************************
*          REPEAT SWITCHING TEST USING PATTERN 707070007070 AND ITS*
*          ALTERNATE 070707770707 INSTEAD OF THE 25 AND 52 PATTERN *
********************************************************************
       REM
       NOP
       CLA T5
       SUB ONE
       TZE FRE+12
       STA T5
       CLA TEST5      L 707070007070
       STO T3
       CLA TEST6      L 070707770707
       STO T4
       TRA FR-2
       REM
       TSX OK,4
       TRA FR-8
       REM
********************************************************************
*      ENTER RANDOM NUMBERS TEST                                   *
********************************************************************
       REM
*      ZERO SELECTED DRUM
       REM
       BCD 1WDR
R      WRS 
       LXA K4000,1    L 4000
       CPY TEST1      L ZERO
       TIX R+2,1,1
       CLA THREE      L 3
       STO CT6
       REM
*     GENERATE 100 OCTAL RANDOM NUMBERS
       REM
R1     CLA RN+63
       STO PRNG
       LXA K100,1     L 100
       LDQ RN+63
       RQL 1
       MPY RR         L 357642357563
       STQ RN+64,1
       TIX R1+4,1,1
       REM
*      CREATE RANDOM LDA ADDRESS
       REM
R2     CAL RN+63
       ANA K3777      L 3777
       STA RN7
       PXD            CLEAR ACC
       REM
*      SELECT RANDOM LDA AND WRITE 100 OCTAL LOCATIONS
*      WITH RANDOM NUMBERS
       REM
*      FINISH LOADING ENTIRE DRUM -3700 OCTAL LOCATIONS-
*      WITH ZERO WORDS
       REM
R3     WRS
       LXA K100,1     L 100
       LXA K3700,2    L 3700
       LDA RN7
       CAD RN+64,1
       TIX R3+4,1,1
       CAD TEST1
       TIX R3+6,2,1
       SLW CAD
       AXT 0,2        CLEAR XRB
       TRA R4
       REM
*      READ ENTIRE DRUM INTO STORAGE
       REM
       BCD 1LDA
R4     RDS
       PXD            CLEAR ACC
       LXA K4000,1    L 4000
       CAD X,1
       TIX R4+3,1,1
       SLW Z20        SAVE CHECK SUM
       REM
*      COMPATE RANDOM NUMBER WRITTEN AT RANDOM LDA
*      WITH WORD GENERATED FOR THAT POSITION
       REM
*      CHECK FIRST RANDOM ADDRESS
       REM
       CLA K4000      ADJUST WORD NUMBER
       SUB RN7        FOR PRINT ROUTINE
       PAX 0,1
       REM
R5     CLA RN7        RANDOM LDA
       ADD K2377
       STA R5+5       TO CAS CORRECT ADDRESS
       STA R5+8       TO LOAD CORRECT WORD IN MQ
       CLA RN
       CAS 0          N WORDS
       TRA R5+8
       TRA R6         OK
       LDQ 0          CORRECT WORD
       TSX ERROR-2,4  LDA ERROR FIRST WORD
       TRA R4
       REM
*      CHECK DRUM ADDRESS ZERO
       REM
R6     CLA RN7        RANDOM LDA
       SUB K3700      L 3700
       TMI R7         K 3700 GREATER THEN RN7
       TZE R7         K 3700 EQUAL TO RN7
       STA WDNO
       PAX 0,1        RN7 GREATER THEN K 3700
       CLA RN+64,1    WORD READ
       CAS X-2048
       TRA R6+10
       TRA *+4
       LDQ X-2048     CORRECT WORD
       TSX ERROR-2,4
       TRA R4
       CLA K4000
       STO WDNO
       REM
*      CHECK ADDRESS OF LAST RANDOM WORD WRITTEN
       REM
R7     CLA RN7
       ADD K100
       ANA K3777
       ADD K3777
       ANA K3777
       REM
       STA T21        ADJUST WORD NUMBER
       CLA K4000      FOR PRINT ROUTINE
       SUB T21
       PAX 0,1
       REM
       CLA T21
       ADD K2377
       STA R7+14
       STA R7+17
       CLA RN+63      WORD READ
       CAS 0
       TRA R7+17
       TRA R8
       LDQ 0          CORRECT WORD
       TSX ERROR-2,4 
       TRA R4
       REM
*      CHECK SUM TEST WRITE DRUM AGAINST MEMORY
       REM
R8     PXD            CLEAR AC
       LXA K4000,1
       ACL X,1
       TIX R8+2,1,1
       SLW T6         CHECK SUM DRUM-WRITE
       TRA *+2
       REM
       BCD 1CAD
       REM
       CAL Z20        COMPUTED SUM
       LDQ T6         CORRECT CHECK SUM
       LAS T6         TEST CHECK SUM
       TRA *+2        ERROR
       TRA *+3
       TSX ERROR-2,4
       NOP *-6
       REM
R9     PXD            CLEAR AC
       LXA K100,1
       ACL RN+64,1
       TIX R9+2,1,1
       SLW T7         CHECK SUM MEMORY
       TRA *+2
       REM
       BCD 1CAD
       REM
       CAL CAD        COMPUTED SUM
       LDQ T7         CORRECT SUM
       LAS T7         FORMED FROM 100 NOS IN MEM.
       TRA *+2        ERROR
       TRA *+3
       TSX ERROR-2,4
       NOP *-6
       REM
       CLA T6
       CAS T7
       TRA *+2
       TRA R10
       LDQ T7
       TSX ERROR-2,4  LDA CHECK SUM ERROR
       TRA R4
       TSX OK,4
       TRA R
       REM
*      CHECK SUM TEST READ LDA CHECK SUM
       REM
       BCD 1LDA
R10    RDS
       LXA K100,1
       LDA RN7
       CPY X-1984,1
       TIX R10+3,1,1
       REM
R11    PXD            CLEAR AC
       LXA K100,1
       ACL X-1984,1
       TIX R11+2,1,1
       SLW T7
       CLA T6
       CAS T7
       TRA R11+9      ERROR
       TRA R12-2      OK
       LDQ T7
       TSX ERROR-2,4  READ LDA ERROR-CK SUM
       TRA R10
       REM
*      GENERATE 4000 OCTAL RANDOM NUMBERS
       REM
       AXT 3,2        LOAD XRB-3
       AXT 2,4        LOAD XRC-2
R12    LXA K4000,1
       LDQ RN+63
       RQL 1
       MPY RR         L 357642357563
       STQ X,1
       TIX R12+2,1,1
       REM 
*      LOAD FULL RANDOM DRUM THREE TIMES WITH SAME RANDOM PATTERN
       REM
R13    WRS
       LXA K4000,1  LOAD XRA-4000
       CPY X,1
       TIX *-1,1,1  COPY FULL DRUM FROM ZERO
       TIX *-3,2,1  RETURN TO WRITE DRUM
       REM          THREE TIMES WITHOUT
       REM          RE-SELECTING. THIS ROUTINE
       REM          TAKES ADVANTAGE OF THE 
       REM          INDEX GAP.
       TIX R13A,4,1 DECREMENT TO RE-WRITE 
       REM          WITH NEW PATTERN
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT          CHECK IOT LIGHT
       TRA *+2      ERROR-SHOULD NOT BE ON
       TRA *+3      OK-LIGHT IS OFF
       TSX ERROR-1,4 IF I/O CHECK COMES UP AT
       TXL *-3,4,0   THIS POINT. THE DRUM
       REM           DISCONNECTED. 72 US WERE
       REM           USED IN THE INDEX GAP.
       REM           AS THE GAP SHOULD BE 
       REM           150-350 US. THE GAP IS
       REM           MUCH TO SHORT, AND DRUM
       REM           SHOULD BE RE-WRITTEN
       TRA R14       DRUM HAS BEEN RE-WRITTEN
       REM           WITH NEW PATTERN. GO TO
       REM           READ NEW PATTERN.
       REM
*      GENERATE 4000 OCTAL RANDOM NUMBERS
*      WRITE NEW RANDOM PATTERN ONCE
       REM
R13A   LXA K4000,1   L 4000
       CLA X,1
       STO RN+63
       TRA R12+1
       REM
*      READ ENTIRE DRUM BACK INTO MEMORY
       REM
R14    RDS
       LXA K4000,1
       CPY X,1
       TIX R14+2,1,1
       TRA R15
       REM
*      COMPARE WORD WRITTEN TO WORD READ
       REM
       BCD 1RDR
R15    LXA K4000,1
       LDQ RN+63
       RQL 1
       MPY RR
       STQ T10
       CLA X,1       WORD READ
       CAS T10       CORRECT WORD
       TRA R15+9
       TRA R16       OK
       LDQ T10       CORRECT WORD
       TSX ERROR-2,4
       TRA R15
       REM
R16    LDQ T10
       TIX R15+2,1,1
       CLA RR        MODIFY RN GENERATOR
       ADD K7        L 010776004377
       STO RR
       TSX OK,4
       TRA R
       REM
*      TEST FOR DELAY OF OVER 500 U-SEC BETWEEN RDS AND LDA
       REM
       BCD 1RDR
D500   RDS
       LXA K22,1
       TIX D500+2,1,1 552 U-SEC DELAY
       LDA K3777
       CPY WPA
       STZ WPA
       TRA *+2
       REM
       BCD 1IOT
       REM
       IOT 
       TRA *+2       ERROR-552 US DELAY
       TRA *+3       SELECT AND LDA SHOULD
       TSX ERROR-1,4 NOT TURN ON I/O TGR
       TXL *-4,4
       REM
********************************************************************
* TEST LDA-IND. ADDR., LDA-INDEXED, AND NO HANG UP ON COPY         *
********************************************************************
       REM
       REM
BEGIN  LXA THREE,1   L+3
       PXA 0,1
       ADD ONE       L+1
       STO WDNO      SET WDNO CONSTANT
       WDR
       LDA* WRDR-2   L ADDR K1000
       CPY TEST3     L+2525252525225
       TIX *,1,1
       CPY TEST4     HANG UP CONDITION MY OCCUR
       REM           AT THIS POINT. IF SO DRUM
       REM           MAY NOT HAVE DISCONNECTED
       REM           AFTER DELAY. LOOK AT SYSTEM
       REM           PAGE 5.03.01.
       TRA *+2
       REM
       BCD 1IOT      TEST I/O TGR AND INDICATOR
       REM
       IOT           IS INDICATOR ON
       TRA *+5       YES-OK
       REM
       TSX ERROR-1,4 INDICATOR SHOULD HAVE BEEN
       REM           TURNED ON WHEN CPY WAS 
       REM           GIVEN AFTER DELAY OF OVER
       REM           36US. LOOK AT SYSTEMS
       REM           PAGE 5.03.01
       TXL *-3,4,0
       REM
       TRA *+2       CONTINUE
       REM
       BCD 1LD 1A    TEST LDA IND. ADDRESSED
       REM
BUG    RDR
       LDA K1000     CORRECT LDA
       CPY CHECK     READ ONE WORD
       CPY CHECK+1   READ LOC. OF DUMMY COPY
       REM
       CLA CHECK     WORD READ
       LDQ TEST3     WORD WRITTEN
       CAS TEST3
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4 ERROR COULD HAVE BEEN A
       NOP BUG       OR WRITE ERROR
       TIX *+2,1,1   CONTINUE
       TRA *+2
       REM
       BCD 1CPY      TEST THAT COPY AFTER
       REM           DISCONNECT DOES NOT
       REM           TRANSMIT
       REM
       CLA CHECK+1   WORD READ
       CAS TEST4     WORD WAS WRITTEN BUT
       REM           IT SHOULD NOT HAVE BEEN
       TRA *+5       OK
       TRA *+2       ERROR-WORD SHOULD NOT
       REM           HAVE BEEN TRANSMITTED
       TRA *+3       OK
       TSX ERROR-1,4 COPY AFTER LAPSE OF MORE
       TXL *-6,4,0   THEN 36US WAS COMPLETED
       REM          COPY SHOULD HAVE ACTED AS
       REM          A NOP
       REM
       TSX OK,4     OUT TO TEST SWITCHES
       TRA BEGIN    REPEAT WITH SW=1 DOWN
       REM 
       NOP
AGAIN  LXA THREE,1  L+3
       WDR
       LDA K3700,1  EFFECTED ADDR K1000
       CPY TEST2+3,1 COPY THREE WORDS
       TIX *-1,1,1
       REM
       CLA D4B      L+4
       STO WDNO     SET WD NO CONSTANT
       LXA THREE,1  L+3
       RDR 
       LDA K1000    L ADDR. 1000
       CPY CHECK+3,1 READ THREE WORDS
       TIX *-1,1,1
       TRA *+2
       REM
       BCD 1LDA IX   TEST LDA INDEXED
       REM
INDEX  LXA THREE,1  L+3
       CLA CHECK+3,1 WORD READ
       LDQ TEST2+3,1 WORD WRITTEN
       CAS TEST2+3,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4 ERROR COULD HAVE BEEN READ
       NOP INDEX     OR WRITE ERROR
       TIX INDEX+1,1,1
       LXA TWO,1     L+2
       WDR 
       LDA* WRDR,1   EFFECTIVE ADDR, K1000
       CPY TEST2+2,1 WRITE TWO WORDS
       TIX *-1,1,1
       TRA *+2       CONTINUE
       REM
       BCD 1LDX XI   TEST LDA INDEXED + INDIRECT
       REM
BUGS   RDR
       LDA K1000     L 1000 IN ADDR
       LXA TWO,1     L+2
       CPY CHECK+2,1 READ TWO WORDS
       TIX *-1,1,1
       REM
       LXA TWO,1     L+2
       CLA THREE     L+3
       STO WDNO      SET WORD NO CONSTANT
       REM
       CLA CHECK+2,1 WORD READ
       LDQ TEST2+2,1 WORD WRITTEN
       CAS TEST2+2,1
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4 ERROR COULD HAVE BEEN A
       REM           READ OR WRITE ERROR
       REM           IF NO ERROR INDICATION IN
       REM           READ AND WRITE SECTION OF
       REM           THIS TEST, LDA IND. ADDR.
       REM           OR LDA INDEXED, IT MUST BE
       REM           ASSUMED THAT THE ERROR
       REM           CAME ABOUT THROUGH THE USE
       REM           OF THE COMBINED INDEXING
       REM           AND IND. ADDRESSING OF LDA
       NOP BUGS
       TIX *-7,1,1   CHECK ALL WORDS
       TSX OK,4      OUT TO TEST SWITCHES
       TRA INDEX
       NOP
       REM
       RDR
       LDA WRDR
       CPY CHEC
       RDR
       LDA WRDR-2
       CPY CHEC+1
       CLA CHEC
       CAS TEST2
       TRA *+5        OK
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ERROR HERE WOULD INDICATE
       TXL INDEX,4,0  LDA INDEXING FAILURE
       REM           THIS ERROR WOULD BE TIED IN
       REM           WITH AN ERROR IN ROUTINE
       REM           AT BUGS
       REM
       TIX *+1,1,1
       CLA CHEC+1
       CAS TEST2
       TRA *+5        OK
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ERROR HERE WOULD INDICATE
       TXL BUG,4,0   LDA IND. ADDRESS FAILURE
       REM           THIS ERROR WOULD BE TIED IN
       REM           WITH AN ERROR IN ROUTINE
       REM           AT BUGS
       REM
       TSX OK,4      OUT TO TEST SWITCHES
       TRA AGAIN     REPEAT SW=1 DOWN
       REM
       NOP
       AXT 0,2       CLEAR XRB
       SWT 3
       TRA WPRA1
       TRA DS-1      TEST NEXT DRUM
WPRA1  WPRA
       SPRA 3       DOUBLE REM
       RCHA FINIS
       TCOA *
       TRA DS-1
FINIS  PZE PRIMG,0,24
       REM
SW6    SWT 6        TEST SENSE SWITCH 6
       TRA SW6+3
       TRA CCCC+4   REPORT COMPLETE TEST
       REM
       RCDA 
       RCHA *+3
       LCHA 0
       TRA 1
       MON 0,0,3
       REM
********************************************************************
*                  CONSTANTS                                       *
********************************************************************
       REM
RESTR  LNT 200000
CS     OCT 374007776000   CHECK SUM
CSC    OCT           CHECK SUM COUNTER
CT1    OCT 0
CT2    OCT 0
CT3    OCT 0
CT4    OCT 0
CT6    OCT 0
       REM
Z20    OCT 0
DA     OCT 0
DC     OCT 0
DC1    OCT 0
DC2    OCT 0
DC3    OCT 0
DC4    OCT 0
DC5    OCT 0
DC6    OCT 0
DC7    OCT 0
DC10   OCT 0
DC11   OCT 
DC12   OCT
DC13   OCT
DC14   OCT
DC15   OCT
DC16   OCT
DC17   OCT
DC20   OCT
DCC    OCT 0
       REM
DRUM   OCT 0
DUMY   OCT 0
       REM
D1B    OCT 0001
D2B    OCT 0002
D3B    OCT 0003
D4B    OCT 0004
D5B    OCT 0005
D6B    OCT 0006
D7B    OCT 0007
D8B    OCT 0010
D9B    OCT 0011
D10B   OCT 0100
D11B   OCT 0101
D12B   OCT 0102
D13B   OCT 0103
D14B   OCT 0104
D15B   OCT 0105
D16B   OCT 0106
CAD    OCT 0
       REM
       REM
KP0    OCT 777777777776
K      OCT 0
       OCT 0
       OCT 0
       OCT 200000020
       OCT 40000020
       OCT 10036004017
       OCT 3377003757
K2     TRA LOAD+4
K3     TRA LOAD1
K4     OCT 4
K5     TRA CCCC+4
K6     OCT 2000001
       OCT 10000400  DEC 10, ADR 400
       OCT 1000000400
       OCT 7776003777
K7     OCT 10776004377
K10    OCT 10
K12    OCT 12
K14    OCT 14
K15    OCT 15
K16    OCT 16
K17    OCT 17
K22    OCT 22
K50    OCT 50
K62    OCT 62
K100   OCT 100
K300   OCT 300
K301   OCT 301
K302   OCT 302
K303   OCT 303
K304   OCT 304
K305   OCT 305
K306   OCT 306
K307   OCT 307
K310   OCT 310
K311   OCT 311
K312   OCT 312
K313   OCT 313
K314   OCT 314
K315   OCT 315
K316   OCT 316
K317   OCT 317
K320   OCT 320
K321   OCT 321
K400   OCT 400
K1000  OCT 1000
K3471  OCT 3471
K3472  OCT 3472
K3700  OCT 3700
K3770  OCT 3770
K3777  OCT 3777
K4000  OCT 4000
K7776  OCT 7776
       REM
LDA    OCT 432421600000
LDA2   OCT 0
LDA3   OCT 0
LDA4   OCT 0
LDA10  OCT           LDA ADDRESS
LD37   OCT 0
       REM
ONE    OCT 1
ONES   OCT 777777777777
       REM
PRNG   OCT 0
       REM
RDR    OCT 512451600000
       REM
RN7    OCT 0
RR     OCT 357642357563
       REM
TEN    OCT 10
TEST1  OCT 0             TEST WORD
TEST2  OCT 777777777777  TEST WORD
TEST3  OCT 252525252525
TEST4  OCT 525252525252
TEST5  OCT 707070007070
TEST6  OCT 070707770707
THREE  OCT 3
TP     OCT 0
TPP    OCT 0
TWO    OCT 2
T1     OCT 0           TEMP STORAGE
T2     OCT 0           TEMP STORAGE
T3     OCT             TEMP STORAGE
T4     OCT 0
T5     OCT 0
T6     OCT 0
T7     OCT 0
T10    OCT 0
T20    OCT 20
       REM
T21    OCT 0
WDR    OCT 662451600000
ZERO   OCT 0
       REM
CNTRL  OCT 0
       NOP K1000       LDA IN ADDRESS
       OCT 7777
WRDR   OCT 7775
CHECK  OCT 0
       OCT 0
       OCT 0
CHEC   OCT 0
       OCT 0
MASK1  OCT 776740000000
LBIT   OCT 4000000
TWTY   OCT 24
HBIT   OCT 10000000
SVTY   OCT 70
       REM
D02    OCT 4000002
D52    OCT 124000052
D252   OCT 524000252
D1252  OCT 2524001252
D111   OCT 0
D222   OCT 0
D333   OCT 0
D444   OCT 0
       REM
PRIMG  OCT 40             9L
       OCT 20200000000    9R
       OCT 0              8L
       OCT 0              8R
       OCT 2004000        7L
       OCT 40000000000    7R 
       OCT 20000          6L
       OCT 100000000000   6R
       OCT 1200           5L
       OCT 0              R5
       OCT 10020          4L
       OCT 540000000      4R
       OCT 42400          3L
       OCT 212000000000   3R
       OCT 600000         2L
       OCT 0              2R
       OCT 1000004        1L
       OCT 4000000000    
       OCT 600410         0L
       OCT 100000000      0R
       OCT 2036103       11L
       OCT 702240000000  11R
       OCT 1041220       12L
       OCT 74400000000   12R
X      BES 2048
K2377  HTR X-2048     CONST FOR LDA TEST
WPA    EQU X-2040
RN     BSS 64
       REM
       REM
B      HED
       REM
*THIS SECTION OF THE TEST-DRUM SPEED TEST-
*MUST BE TRANSFERRED INTO,MANUALLY
       REM
       REM
       REM
*IN ORDER FOR THIS PROGRAM TO OPERATE CORRECTLY
*A JUMPER WIRE MUST BE RUN FROM MF3 R06-1, SYSTEMS
*PAGE 7.03, TO MF4 F02-3,SYSTEMS PAGE 5.05.03
       REM
A      CLA K       POST
       STO 0       RESTART
       REM
       CLM         CLEAR ACC
       REM           TEST SW FIVE
       SWT 5       UP- DR FR 1, DWN DR FR 2
       TRA A2
       REM          MEASURE DRUM FRAME 2
       REM          TEST SW 1
       SWT 1       UP PH DR A DN PH DR B
       TRA A1
       REM
       RDR 7       MEASURE DRUM B
       TRA A4
A1     RDR 5       MEASURE DRUM A
       TRA A4
       REM          MEASURE DRUM FRAME 1
A2     SWT 1
       TRA A3
       REM
       RDR 3       MEASURE DRUM B
       TRA A4
       REM
A3     RDR 1       MEASURE DRUM A
       REM
       REM
       REM
A4     LXA ZERO1,4  L 0
       SLF        TURN OFF SENSE LIGHTS
       SLT 1      TEST UNTIL LIGHT
       TRA A4+2    COMES ON
       REM    
       REM
       REM    
A5     SLT 1      COUNT UNTIL LIGHT COMES
       TXI A5,4,1   ON AGAIN
       REM
       REM CONVERT CYCLES TO MISCROSECONDS
       REM
       ADD THRTY   L30
A6     ADD SIXTY    L60
       TIX A6,4,1
       REM
       REM CONVERT CYCLES TO MISCROSECONDS
       REM
A7     ALS 6        TO RPM
       STO TEMP
       CLM
       LDQ K+1      L 344705 606000
       DVH TEMP
       REM
       REM          CONVERT BINARY TO BCD
A8     CLM
       SLW TEMP
       LLS 35
       ADD FOUR     L 4
       LRS 38
       LXA THRTY,1  L 30
A9     CLA ZERO1    L 0
       DVH TWL      L 12
       ALS 24,1
       ADD TEMP
       STO TEMP
       TIX A9,1,6
       HTR SWT6
       REM    
       REM    
SWT6   SWT 6       TEST SWITCH SIX
       TRA SWT6+3
       TRA A+2
       RCDA 
       RCHA *+3
       LCHA 0
       TRA 1
       MON 0,0,3
       REM
       REM CONSTANTS
       REM
K      TRA A+2
       OCT 344705606000
ZERO1  OCT 0
THRTY  OCT 30
SIXTY  OCT 60
TEMP   OCT 0
FOUR   OCT 4
TWL    OCT 12
       REM
       REM
* SENSE SWITCHES INTERROGATION AND DIAGNOSTIC
*            PRINT SUBROUTINE FOR 709
       REM
0A     HED
       REM
       STZ KONST+3  INDICATE I/O TYPE PRINT
       REM          OUT
       TRA ERROR
       STZ KONST+3  SET STORAGE TO ZEROS
       REM          MODIFY INSTRUCTIONS FOR
       REM          RETURN ADDR TO MAIN PROG
       TRA MOD
ERROR  STZ KONST    DO NOT REPEAT SECTION
       STZ KONST+1  IF SENSE SW 4 IS DOWN
       REM 
       REM
       REM 
       PSE 114      IF SENSE SW 2 IS UP THEN-
       TRA SSW3     CHECK SSW 3
       TIX OK,4,1
       REM
       REM
OK     SXD LOC+1,4  2'S COMPL OF PROGRAM
       REM          LOCATION LAST PREFORMED
       REM
       REM
       REM
       PSE 113      IF SENSE SW 1 IS UP THEN
       TRA RELY     CHECK SS 4
       TRA 1,4      IF DOWN REPEAR SECTION
       REM          OF PROG
       REM
SSW3   PSE 115      IF SENSE SW 3 IS UP
       TRA PRINT    PRINT ON ERROR
       REM          IF SS 3 IS DOWN STOP ON
       HTR OK-1     ERROR
       REM          HTR 2'S COMPLEMENT OF
       REM          INDEX REGISTER C
       REM          CONTIANS THE ERROR ADDRESS
       REM          OF THE SECTION OF THE
       REM          PROG IN ERROR
       REM
RELY   PSE 116      IF SENSE SWITCH 5 IS UP
       TRA 3,4      GO TO NEXT SECTION OF
       REM          THE PROG
       REM          IF DOWN REPEAR SECTION
       REM          OF THE PROGRAM N TIMES
       REM          OR THE NUMEBR OF TIMES
       REM          THAT IS SPECIFIED IN LOC
       REM          KONST+2
       REM
       REM
       REM
       CLA KONST+1  COUNTER
       SUB KONST    L+1 REDUCE COUNT BY 1
       STO KONST+1
       TNZ OK+3
       CLA KONST+2  L+50 COUNT CONSTANT
       STO KONST+1
       CLA STOR+7   L+1
       STO KONST
       TRA 3,4
       REM
       REM
MOD    STZ KONST+4  SET STORAGE TO ZEROS
       STZ KONST+1
       STZ KONST
       REM 
       REM
ERR    PSE 114      IF SS 2 IS UP CHECK
       TRA SSW3A    SENSE SWITHC 3
       REM
OK2    PSE 113      SSW1 UP-GO TO NEXT ROUTINE
       TRA 2,4      EXIT
       TRA 1,4      REPEAT TEST
       REM
SSW3A  PSE 115      IS SENSE SWITCH 3 IS UP
       TRA PRINT    PRINT ERROR
       REM          2'S COMPLEMENT OF XRC
       HTR OK2      CONTIANS THE ERROR ADDR
       REM          OF SECTION OF PROG LAST
       REM          EXECUTED
       REM   
       REM   
       REM   
KONST  OCT 1
       OCT 50
       OCT 50       COUNT CONSTANT
       OCT 1
       OCT 1
       TRA OK-1     EXIT FROM PRINT PROG
       TRA OK2      EXIT FROM PRINT WHEN
       REM          ENTRY IS TO ERROR-1
       OCT 1
       REM
WDNO   OCT
RECNO  OCT
       REM
       REM
       REM          PRINT ROUTINE
PRINT  STO STOR     ACC CONTENTS
       ARS 35
       SLW STOR+3   OV FL BITS
       PXA 2,2
       STA STOR+2   XRB
       SXD STOR+2,1 PLACE XRA INTO DECR
       SXD STOR+3,4 PLACE XRC INTO DECR
       STQ STOR+1   MQ CONTENTS
       REM    
       REM
       REM
CHK1   CLA STOR+5   L 100000
       NOP
       TRA CHK1+4   NO
       ORS STOR+3   YES
       ARS 3
       DCT          DIV CK TEST
       ORS STOR+3
       ARS 3
       NOP 
CHK2   TRA CHK2+2   NO
       ORS STOR+3
       ARS 3
       TNO CHK4-1   ACC OV FL-YES
       ORS STOR+3   NO
       CLM          SENSE SWITCHES
CHK4   LXA STOR+8,1 L +4
       ALS 3
       MSE 101,1
       TRA *+3
       ADD STOR+7   L +1
       PSE 101,1    RESET LITES
       TIX CHK4+1,1,1
CHK3   LXA STOR+6,1 L +6
       ALS 3
       PSE 119,1
       TRA CHK3+5
       ADD STOR+7   L +1
       TIX CHK3+1,1,1
       REM    
       REM 
       SLW STOR+4   RETAIN PSE + MSE
       REM          INDICATIONS
       REM          WAS ENTRY FROM SUB-
CHK3A  CLA KONST+4  ROUTINE AT ERROR-1
       TZE CHK3A+7  YES
       CLA PRINT+3  NO
       STA CHK5+1   RESET ADDR
       CLA KONST+5
       STO EXIT
       TRA CHK5
       REM
       CLA STOR+7   L+1
       STO KONST+4
       STA CHK5+1
       CLA KONST+6
       STO EXIT
       REM
       REM
       REM
       REM          OBTAIN TEST LOC
       REM          AND ERROR ADDR
CHK5   LXD STOR+3,4 XRC
       PXD 2,4
       COM 
       ADD BIT2+2   +1 TO DECREMENT
       STD LOC      ERROR ADDR INTO DECR
       ARS 18
       SUB CHK5+1   L +2
       STA CHK6
CHK6   CAL 0        PLACE
       STA LOC      TEST LOC INTO ADDR
       STP LOC
       REM
       REM          OBTAIN OPN OF INST
       SUB STOR+7   L +1
       STA *+1
       LDQ 0        BCD OPERATION 
       REM
CHK7   LXA STOR+6,1 L +6
       CLM
       LGL 2
       PAX 0,4      ZONE BIT
       LGL 4
       CAS BIT+2    CHECK FOR BLANK L +60
       TRA *+2
       TRA CHK7A    YES
       CAS BIT+9    CHECK FOR HYPHEN
       TRA *+2
       TRA TRAP     YES- INDICATES A TRAP
       REM          ROUTINE
       ANA BIT+11   MASK FOR NUMERIC
       PAX 0,2
       TXH CHK7A,2,10 IGNORE SPECIAL CHARS
       CLA BIT+1    COL INDICATOR
       ARS 6,1
       ORS REC1L+9,2
       TXL *+2,4
       ORS REC1L+12,4
CHK7A  TIX CHK7+1,1,1
       REM
CHK8   LDQ 0
       LXA BIT+3,1   L +14
       REM
       TSX CH22,2
       CAL BIT+10    COL IND
       ARS 12,1
       ORS REC1R+9,4
       TIX *-4,1,1
       REM
CH1    CAL LOC       PUT TEST LOC INTO IMAGE
       LRS 15
       LXA LOC+5,1   L +5
       TSX CH21,2
       REM
       CAL BIT       BIT COLUMN 10
       ARS 5,1
       ORS REC1L+9,4
       TIX CH1+3,1,1
       REM
       REM
       REM           PUT ERROR ADDR INTO IMAGE
CH5    LXD LOC,4
       PXD 0,4
       LRS 33
       LXA LOC+5,1   L +5
       TSX CH21,2
       CAL LOC+6     -0
       ARS 6,1
       ORS REC1R+9,4
       TIX CH5+4,1,1
       REM
       REM           PUT PSE SW INTO
CH7    CAL STOR+4    IMAGE
       LRS 18
       LXA STOR+6,1  L +6
       TSX CH21,2
       CAL BIT+9
       ARS 6,1
       ORS REC1R+9,4
       TIX CH7+3,1,1
       REM
CH10   LXA BIT+3,4   PUT 1ST REC IN PR IMAGE
       LXA LOC+4,1   L +30
       CAL REC1L+12,4 LEFT HALF IMAGE
       SLW PR+24,1
       CAL REC1R+12,4
       SLW PR+25,1
       REM
       TIX CH10+7,4,1
       TIX CH10+2,1,2
       REM
CH11   LXA BIT+3,4   MASK IMAGE
       CAL MASK      MASK
       ANS REC1L+12,4
       CAL MASK+1
       ANS REC1R+12,4
       CAL MASK+2    MASK LEFT HALF
       ANS REC2L+12,4 2ND RECORD
       CAL MASK+3    MASK RIGHT HALF
       ANS REC2R+12,4
       CAL MASK+4    MASK 3RD RECORD
       ANS REC3L+12,4 LEFT HALF
       CAL MASK+5
       ANS REC3R+12,4
       CAL MASK+8    MASK IND KEYS
       ANS REC4L+12,4 PRINT REC
       CAL MASK+6
       ANS P92+1,4   I/O IMAGE
       CAL MASK+7    REC=, WORD =, ETC
       ANS P95+1,4
       TIX CH11+1,4,1
       REM
       REM
       REM
CH14   WRS 753       PRINTER
       SPRA 3        DOUBLE REM
       REM           PRINT FIRST LINE
       REM           TEST LOC, ERROR ADDR
       TSX WPRA+1,1
       CLA LOC
       TMI CH35-6
       REM
CH18   CLA STOR+4    PUT MSE LITES INTO IMAGE
       LRS 30
       LXA STOR+8,1  L +4
       TSX CH21,2
       CAL BIT+12    BIT COL 6
       ARS 4,1
       ORS REC2L+9,4
       CAL BIT+6     BIT COL 5
       ARS 4,1
       REM
       ORS P92-2,4
       TIX CH18+3,1,1
       REM
       CLA KONST+3   IS THIS A MAIN FRAME
       TZE CH41      PRINT OUT -NO
       REM           FORM CARD IMAGE FOR 2ND REC
CH15   CLA STOR+2
       LRS 33
       LXA STOR+8,1  L +4
       TSX CH21,2
       REM
       CAL BIT+5     BIT COLUMN
       ARS 4,1
       ORS REC2L+9,4
       TIX CH15+3,1,1
       TSX CH21,2
       CAL LOC+6     L-0
       ORS REC2R+9,4
CH16   TSX CH21,2
       LXA LOC+5,1   L +5
       TSX CH21,2
       CAL BIT2      BIT COL 8
       ARS 5,1
       ORS REC2R+9,4  BIT IN IMAGE
       TIX CH16+2,1,1
       REM
CH17   CLA STOR+3    PUT XRC INTO IMAGE
       LRS 33
       LXA LOC+5,1   L +5
       TSX CH21,2
       REM
       CAL BIT2+1    BIT IN COL 19
       ARS 5,1
       ORS REC2R+9,4 BIT IN IMAGE
       TIX CH17+3,1,1
       REM
CH27   LDQ STOR+1    CONTENTS OF MQ
       LXA BIT+3,1   L +14
       TSX CH22,2
       CAL BIT+10    BIT COL 15
       ARS 12,1
       ORS REC2L+9,4
       TIX CH27+2,1,1
       REM
       CAL LOC+3     WAS ROUTINE USING TRAP
       SUB BIT+9
       TNZ *+4       NO
       CAL STOR+7    L +1
       ORS REC2R+8
       TRA *+3
       CAL STOR+7    L +1
       ORS REC2R+9
       STZ LOC+3
       REM
CH23   LXA BIT+3,4
       LXA LOC+4,1   L +30
       CAL REC2L+12,4 LEFT HALF
       SLW PR+24,1
       CAL REC2R+12,4 RIGHT HALF IMAGE
       SLW PR+25,1
       TIX CH23+7,4,1
       TIX CH23+2,1,2
       REM
       TSX WPRA,1    PRINT 2ND LINE
       REM
       REM
CH20   CAL STOR+3    PUT TRGS INTO
       LRS 18        IMAGE
       TSX CH21,2
       CAL BIT+8     BIT COL 26
       ORS REC3R+9,4 F.P.-OVFL
       TSX CH21,2
       CAL STOR+7    BIT IN 35
       ORS REC3L+9,4  INDICATE DIV CK
       REM
       TSX CH21,2
       REM
       CAL STOR+7    L +1
       ALS 1         BIT IN 34
       ORS REC3R+9,4 F.P. UNFL
       TSX CH21,2
       CAL BIT+4     BIT COL 12
       ARS 1
       ORS REC3R+9,4 ACC OVFL
       REM
       REM
CH24   CLM           PUT Q + P BITS
       LLS 11        INTO IMAGE
       PAX 0,4
       CAL BIT+4     BIT IN COL 4
       ALS 2
       ORS REC3L+9,4 Q BIT
       CLM           GET P BIT
       LLS 1
       PAX 0,4
       CAL BIT+4
       ARS 2         BIT IN COL 13
       ORS REC3L+9,4
CH25   LDQ STOR
       CAL BIT+6     PUT + SIGN OF
       TQP CH25+5    ACC IN IMAGE
       ORS REC3L+10  MINUS SIGN OF ACC IN IMAGE
       TRA CH26
       ORS REC3L+11  INTO IMAGE
CH26   LXA BIT+3,1   L +14
       TSX CH22,2
       CAL BIT+10    BIT COL 15
       ARS 12,1
       ORS REC3L+9,4
       TIX CH26+1,1,1
       REM
CH30   LXA BIT+3,4   PUT 3RD REC INTO
       LXA LOC+4,1   PRINT IMAGE
       CAL REC3L+12,4 LEFT HALF
       SLW PR+24,1
       CAL REC3R+12,4 RIGHT HALF
       SLW PR+25,1
       TIX CH30+7,4,1
       TIX CH30+2,1,2
       REM
       TSX WPRA,1    PRINT 3RD LINE
       REM
       REM           PUT INDICATORS IN REC
CH32   STI PR        STORE INDICATORS
       LDQ PR        INDICATOR FROM STORAGE
       LXA BIT+3,1   L +14
       TSX CH22,2
       CAL BIT+6
       ARS 13,1
       ORS REC4L+9,4 INDICATORS INTO
       TIX CH32+3,1,1 PRINT RECORD
       REM
       REM           PUT CONTENT OF KEYS IN
CH33   ENK           PRINT RECORD
       LXA BIT+3,1   L +14
       TSX CH22,2
       CAL BIT+1
       ARS 16,1
       ORS REC4L+9,4 KEYS CONTENTS INTO
       TIX CH33+2,1,1 PRINT REC
       REM
CH34   LXA BIT+3,4   L+14 PUT 4TH REC
       REM           INTO PRINT IMAGE
       LXA LOC+4,1   L +30
       CAL REC4L+12,4
       SLW PR+24,1
       STZ PR+25,1
       TIX *+1,4,1
       TIX CH34+2,1,2
       REM
       REM
       REM
       TSX WPRA,1    PRINT CONTENTS OF INDS
       REM
       CLA STOR+7    L+1
       STO KONST+3
       REM           RESET ACC + MQ CONTENTS
       STO KONST+7
       CLA STOR+3    OVFL BITS
       LDQ STOR      ACC CONTENTS
       LLS 35
       LDQ STOR+1
       REM
CH35   LXA STOR+2,2  XRB
       LXD STOR+2,1  XRA
       LXD STOR+3,4  XRC
       TOV EXIT
EXIT   TRA OK-1 
CH41   CLA KONST+7   IS THIS A REDUNDANCY
       REM           TAPE CK PRINT-OUT
       TZE CH32      YES
       REM
       REM           CLEAR RECORD IMAGE
       LXA LOC+4,1   LOC +30
       STZ PR+24,1
       TIX *-1,1,1
       REM
       CAL STOR+1    WORD GENERATED
CH43   SLW PR+17
       REM
       COM
       SLW PR+19     PRINT IMAGE
       LXA BIT+3,1   L +14
       LXA LOC+4,2   LOC +30
       CAL P92+1,1
       SLW PR+24,2
       TIX CH43+8,1,1
       TIX CH43+5,2,2
       REM
       TSX WPR,1     PRINT WORD GENERATED
       REM
CH45   CLA STOR+2
       ARS 18
       SUB WDNO      WORD NUMBER
       LRS 15
       LXA LOC+5,1    L+5
CH46   TSX CH21,2
       CAL BIT+7     BIT COL 17
       ARS 5,1
       ORS P93,4     WORD NUMBER INTO
       TIX CH46,1,1  IMAGE
       REM
CH47   LXA STOR+2,2  XRB
       CLM
       PXA 0,2
       SUB RECNO     RECORD NUMBER
       LRS 15
       LXA LOC+5,1   L+5
CH48   TSX CH21,2
       CAL BIT+6     BIT COL 5
       ARS 5,1
       ORS P93,4
       TIX CH48,1,1
       REM
       REM
CH49   LXA LOC+4,1   L +30
       STZ PR+24,1
       TIX *-1,1,1
       REM
       CAL STOR      WORD READ
CH50   SLW PR+17
       COM
       SLW PR+19
       REM
       REM
CH51   LXA BIT+3,1   L +14
       LXA LOC+4,2   L +30
       CAL P95+1,1
       SLW PR+24,2
       TIX CH51+5,1,1
       TIX CH51+2,2,2
       REM
       TSX WPR,1     PRINT WORD WRITTEN
       REM
       TRA CH32      PRINT INDICATORS AND KEYS
       REM
CH21   CLM
       LLS 3
       PAX 0,4
       TRA 1,2
       REM
CH22   CLM
       LGL 3
       PAX 0,4
       TRA 1,2
       REM
WPRA   WPRA
       RCHA CTWD
       TCOA *
       TRA 1,1      EXIT
WPR    WPRA
       SPRA 4
       TRA WPRA+1
       REM
TRAP   STO LOC+3
       TRA CHK7A
       REM
REC1L  OCT 320,10001000,1000000
       OCT 4002000042,200000400400
       OCT 0,452010001005
       OCT 100000000000,0,540010001000
       OCT 14003400366,202000000401
REC1R  OCT 0,4000001000,0,100000200
       OCT 0,0,4240001000,400,0
       OCT 5000001600,000300000000
       OCT 40000000
REC2L  OCT 200000000100,440001000
       OCT 200,0,40000000000
       OCT 100000000
       OCT -500400001000,0,40
       OCT 100400001200
       OCT -400140000100
       OCT 240000000040
REC2R  OCT 20004000404
       OCT 200040010000
       OCT 40010000110,0,0,0
       OCT 200042011020
       OCT 10000000000,200
       OCT 240050011020
       OCT 20004000504,10002000210
REC3L  OCT 100,14420001000
       OCT 200000000,0,40,200
       OCT 310420001010,4,-0
       OCT 10420001040,4200000004
       OCT -700000000310
       REM
REC3R  OCT 0,-400042400401,1000000
       OCT 5004050020,2000020040,100
       OCT -460442404411,0
       OCT 100000000000,-402040020501
       OCT 4401244050,161006410020
REC4L  OCT -0,1040000,0,0
       OCT 200000100000,100000000000
       OCT 1000000,40000220000,0
       OCT 40001060000,200000200000
       OCT -500000100000
STOR   OCT 0         ACC CONTENTS
       OCT 0         MQ CONTENTS
       OCT 0         XRA AND XRB
       OCT 0         XRC, OVRL TRGS, TAPE CK
       OCT 0         PSE + MSE VALUES
       OCT 100000
       OCT +6
       OCT +1
       OCT +4
LOC    OCT 0         TEST LOC + ERROR ADDR
       OCT 0         DECREMENT CONTAINS 2,5
* COMPLEMENT OF LAST ROUTINE PREFORMED
       OCT 0         +0
       OCT 0         TRAP ROUTINE INDICATOR
       OCT +30
       OCT 5
       OCT -0
       OCT 7
BIT    OCT 400000000 BIT COL 10
       OCT 100000    BIT COL 21
       OCT 60
       OCT 14
       OCT 200000000 BIT COL 11
       OCT 10        BIT COL 33
       OCT 020000000000 BIT COL 5
       OCT 2000000   BIT COL 17
       OCT 1000      BIT COL 27
       OCT 40        BIT COL 31
       OCT 10000000  BIT COL 15
       OCT 17
       OCT 010000000000
BIT2   OCT 002000000000 BIT COL 8
       OCT 400000    BIT COL 19
       OCT 1000000
       OCT 100020000000
MASK   OCT 777017601777 TEST LOC ETC
       OCT 407760001700
       OCT -760760001760 MQ ETC
       OCT 374077017776
       REM              MAKE FOR REC3
       OCT -756720001776 ACC AND TRIGGER
       OCT -777677776775
       OCT -741777777777 I/O ETC
       OCT -740774077777
       OCT -760001760000 MASK FOR 4TH REC
       OCT -777773567356 MASK
       REM
       OCT 000003204020
       OCT 1000100000,20000400
       OCT 00100430000
       OCT 100004000342,-400040002001
       OCT 1200100004,200000000000
       OCT 10
       OCT 201000120004
       OCT -400163614120
P92    OCT 100204002653
       REM
       OCT -400020000220,400040000
       OCT 0,140001400
       OCT 200000000010,10000102
       OCT 100400040000,0,4
P93    OCT 500041000
       OCT -400060000620
P95    OCT 300010000116
CTWD   HTR PR,0,24    CONTROL WORD FOR PRINTING
PR     OCT            PRINT IMAGE
       REM
       ORG X-200
WPRA2  WPRA           TO PRINT
       RCHA COMC      START OF
       TCOA *         PROGRAM
       TRA CCCC+2
       REM
COMC   PZE *+1,0,24
       OCT 45040410       9R
       OCT 40222400000    9L
       OCT 0              8R
       OCT 100000         8L
       OCT 200200002      7R
       OCT 0              7L
       OCT 3030010000     6R
       OCT 400000000000   6L
       OCT 4100400001     5R
       OCT 2100010000     5L
       OCT 2021320        4R
       OCT 1000000000     4L
       OCT 0              3R
       OCT 120041222000   3L
       OCT 0              2R
       OCT 200004004000   2L
       OCT 4004           1R
       OCT 4010000000     1L
       OCT 1000000200     0R
       OCT 300000326000   0L
       OCT 6256410501    11R
       OCT 402241000000  11L
       OCT 121221036     12R
       OCT 65136410000   12L
       END

