                                                            9 I O M C
                                                            7-01-58
       REM
       REM
       REM
*                            9 I O M B
       REM
*                 709 ROUTINE FOR MODIFICATION OF
*                        I-O INSTRUCTIONS
       ORG 2880
CTRL1  OCT +0        COUNT WORD FOR DS A+B
CTRL2  OCT +0        COUNT WORD FOR DS C+D
CTRL3  OCT +0        COUNT WORD FOR DS E+F
IOCT   OCT +0        I-O COUNT
CTRA   OCT +0        NUMBER OF UNITS - CHN A
CTRB   OCT +0        NUMBER OF UNITS - CHN B
CTRC   OCT +0        NUMBER OF UNITS - CHN C
CTRD   OCT +0        NUMBER OF UNITS - CHN D
CTRE   OCT +0        NUMBER OF UNITS - CHN E
CTRF   OCT +0        NUMBER OF UNITS - CHN F
CTX    TRA CTX1      TO MODIFY PROGRAM
IOCNT  TRA IOC1      TO RELOAD I-O COUNT
       REM
       REM
       REM
*     ENTER CONTROL WORDS FOTR CHANNELS AND UNITS
       REM
IOC    STZ CTRL1     CLEAR
       STZ CTRL2     CONTROL
       STZ CTRL3     WORDS.
       REM
       REM
       REM
       HTR *+1       ENTER KEYS WITH CONTROL
       REM           WORD FOR CHN A AND/OR B
*     INCLUDE THE DATA SYSNC TO BE USED IN THE TAG
*     OF THE CONTROL WORD
       REM
*   NOTE - A TAG OF 1 WILL SPECIFY CHAN A AND/OR B
*          A TAG OF 2 WILL SPECIFY CHAN C AND/OR D
*          A TAG OF 4 WILL SPECIFY CHAN E AND/OR F
       REM
*      IF 2 OR MORE DS ARE TO BE TESTED THE 1ST CONTROL
*      WORD ENTERED IN THE KEYS SHOULD CONTIAN A MULTIPLE TAG
       REM
       REM
       ENK           PLACE WORD
       XCL           ENTERED ON KEYS
       PAI           IN INDICATORS
DSC    RFT 0,7       DO WE HAVE A TAG BIT
       TRA DSC1      YES
       REM
       REM
       HTR *-5       NO TAG BIT - RE-ENTER FIRST
       REM           CONTROL WORD SPECIFYING 
       REM           OS IN TAG OF KEYS
       REM
       REM
DSC1   RNT 0,1       TEST FOR CHAN A AND/OR B
       TRA DSC2      NO
       STI CTRL1     CNTL WORD FOR A AND/OR B
DSC2   RNT 0,2       TEST FOR CHAN C AND/OR D
       TRA DSC3      NO
       REM
       REM
       HTR *+1       SET CONT WORD IN KEYS
       REM           FOR CHAN C AND/OR D
       REM
       REM
       ENK
       STQ CTRL2
DSC3   RNT 0,4       TEST FOR CHAN E AND/OR F
       TRA *+4       NO
       REM
       REM
       HTR *+1       SET CONT WORD IN KEYS
       REM           FOR CHAN E AND/OR F
       ENK
       STQ CTRL3
       REM
       REM
*    ESTABLISH UNIT COUNT FROM CONTROL WORDS
       REM
       REM
IOC1   STZ IOCT      CLEAR UNIT COUNT
       SXA ACCX,4    SAVE XRC
       AXT 3,2       L +3 IN XRB
       AXT 6,1       L +6 IN XRA
       AXT 2,4       L +2 IN XRC
       CLA FOUR+2,4
       STA AB+1
AB     CAL CTRL1+3,2 l CHANNEL CONTROL WORD
       ARS 4
       PAI
       ANA KON2      L + 17 - CLEAR ACC TO COUNT
       RNT 20        CHECK FOR EXCLUSIVE BIT
       TRA *+2       NO
       CLA KON+1     YES - L + 1 FOR COUNT
       STO CTRA+6,1  SAVE CHN UNIT CONT
       ADD IOCT
       STO IOCT	    SAVE TOTAL UNIT COUNT
       TIX *+1,1,1,
       TIX AB-2,4,1
       TIX AB-3,2,1
       LXA ACCX,4    RELOAD XRC
       REM
       REM
CNT    CLA FOUR      L +4
       STZ L6367     * NEW!
       PAX 0,2       L ACC IN XRB
       SXA *+4,2     L XRB IN ADDRESS
       AXT 3,1       L +3 IN XRA
       PXD 0,0	     * Changed
       LDI CTRL3+1,1
       RNT           CHECK NUMBER OF
       REM           CARD MACHINES ON LINE
       TRA *+2       NO
       ADD KON+1     YES - L +1
       TIX *-4,1,1
       CAS IOCT
       STA IOCT
       NOP
       CAL IOCT,1	     * NEW.
       ANA FOUR+2	     * NEW.
       XEC CTX1,1	     * NEW.
       ORS TEN		     * NEW.
       PXA 0,2       L XRB IN ACC
       ARS 1
       TIX CNT+2,2,1
       TRA 1,4       EXIT TO MAIN PROG
       REM
       REM
*      MODIFY I-O INSTRUCTIONS
       REM
       ALS 18	     * NEW.
       ALS 6	     * NEW.
       NOP 	     * NEW.
CTX1   STO ACCX      ACC CONTENTS
       ARS 35
       SLW ACCX+1
       SXA ACCX+2,1
       SXD ACCX+2,2
       STQ ACCX+3
       STI IND       SAVE INDICATORS
       REM
       REM
*    EXTABLISH PROGRAM AREA TO MODIFY
       REM
       CLA 1,4       L FIRST AND LAST ADDRESS
       REM           PROGRAM AREA TO BE MODIFED
       STA CTRX      SAVE FIRST ADDRESS
       ARS 18
       STA LASTA     SAVE LAST ADDRESS
       REM
       REM
*   IDENTIFY I-O INSTRUCTION
       REM
CTRX   CAL 0         L CURRENT INSTRUCTION
       SLW INST      SAVE CURRENT INSTRUCTION
       PAI           PLACE INST IN INDICATORS
       STA ADDR      TEST INST IN I/O TABLE
       AXT 7,1  
       CLA OPTAB+8,1
       STA *+2
       STT *+1
       REM
       REM
       LNT 0         TEST FOR I/O INSTRUCTION
       TRA *+5
       LFT 300000
       TRA *+3
       LNT 077400
       TRA OPR1
       LNT 077500     *NEW
       TIX *-9,1,1
       TXH OPR1,1,1         * NEW
       REM      TEST FOR BCD WORD
       RNT 206000
       TRA TRCX
       RFT 401700
       TRA TRCX
       LFT 77
       TRA *+2
       TRA TRCX
       LFT 370000
       TRA *+2
       TRA TRCX
       LFT 7700
       TRA *+2
       TRA TRCX
       STI BCD
       LXA CTRX,1
       SXA BCDX,1    SAVE ADDRESS
       REM    
FINE   CAL KON3+1    L +7000
       ORS WTBX+2
       ORS WTDX+2
       ORS BTTX+2
       ORS WPRX+2
       ORS WPUX+2
       ORS RCDX+2
       ORS XXXX+2    * NEW
       ORS YYYX+2    * NEW
       CAL KON4      MASK  6220
       ANS WTBX+2
       ANS WTDX+2
       ANS BTTX+2
       CAL KON4+1
       ANS WPRX+2
       ANS WPUX+2
       ANS RCDX+2
       ANS XXXX+2         * NEW
       ANS YYYX+2         * NEW
       REM    
       CLA CTRX      L CURRENT LOCATION IN PROGRAM
       CAS LASTA     LAST LOCATION IN PROG
       TRA *+3
       TRA FIN
       HTR *-1       EXIT
       SUB KON+1     L+1
       STA CTRX
       TRA CTRX
       REM
FIN    LDI IND
       CLA ACCX+1    RESTORE REGISTERS
       LDQ ACCX      ETC.
       LLS 35
       LDQ ACCX+3
       LXA ACCX+2,1
       LXD ACCX+2,2
       TRA 2,4
       REM    
OPR1   TRA *+10,1
       TRA WTBX      BSFX
       TRA WTBX      ETTX
       TRA WTBX      REWX
       TRA WPRX+1
       TRA WTBX
       TRA WPRX+1    BRXX
       LFT 701777    *NEW
       TRA FINE
WPRX   TRA WTBX
       AXT 6,1
       RNT 6360
       TRA FINE+1
WPUX   TXI L6154+6,1,2
       NOP
       RNT 6340
       TRA *+2
RCDX   TXI L6154,1,2
       NOP           * CHANGED
       RNT 6320
       TRA *+2
XXXX   TXI L6154+2,1,2
       LXA *+1,2
       RNT 6240
       TRA *+2
YYYX   TRA L5777
       LXA *+1,2
       RNT 6000
       TRA L6001
       RFT 776
       TRA L6001
L5777  STO L6407
       TRA L6040
L6001  AXT 20,2
       CAL L5777,2
       SUB KON+4     L+ 1000
       SLW L5777,2
       TIX L6001+1,2,4
       TIX WPRX+2,1,1
WTBX   AXT 6,1
       LXA *+1,2
       RNT 6220
       TRA *+2
WTDX   TRA L6040
       LXA *+1,2
       RNT 6200
       TRA *+2
BTTX   TRA L6040
       LXA *+1,2
       RNT 6000
       TRA *+2
       TRA BTT
       AXT 22,2
       CAL *,2
       SUB KON+4     L+ 1000
       SLW *-2,2
       TIX *-3,2,4
       TIX WTBX+1,1,1
       TRA FINE
       REM
BTT    CLA CHX
       ALS 9
       TZE FINE
       STA INST
       TRA CHAN
       REM
L6040  SXA KON4+1,2
       STL L6113
       TRA L6103
L6043  XEC L6103,1
       PAI
       ANA KON4
       ADD KON4+1
       CAS L6375
       TRA *+3
       TIX L6113+1,1,1
       TIX L6113+1,1,1
       ZET L6407
       TRA L6113+1
       RNT 20
       TRA *+2
       TRA *+3
       CAL L6377
       ADD KON+1         L +1
       TXH L6072,1,1
       LDI CTRL1
       LFT 400000
       TRA L6072
       PAI
       RFT 16
       TRA L6072
       ADD KON+1         L +1
L6072  STA L6377
       SXA CHX,1
       TRA CHAN
       ARS 10
       ARS 4
       ARS 10
       ARS 4
       ARS 10
       ARS 4
L6103  CLA L6113
       ADD KON+1         L +1
       STA L6113
       CAL CTRL3
       TXH L6113,1,4
       CAL CTRL2
       TXH L6113,1,2
       CAL CTRL1
L6113  TRA 0
       TXL *+1,1,6
       AXT 1,1
       STL L6113
       TRA L6103
L6120  XEC L6103,1
       PAI
       RFT 37
       TRA *+2
       TXI L6113+1,1,1
       NZT L6407
       TRA L6132
       CAL L6377
       ANA L6376
       TRA L6136
L6132  RFT 20
       STO L6406
       PXA 0,2
       ANA L6400
L6136  STO L6372
       PXA 0,1
       ALS 9
       ADD L6372
       PAX 0,2
       NZT L6407
       TRA L6147
       STZ L6407
       TRA L6072
       NZT L6406
       TRA L6061
       STO L6375
       STZ L6406
       TRA L6040
L6154  CAL L6364
       TRA *+4
       CAL KON+1         L +1
       TRA *+2
       CAL KON+1         L +2
       STA L6167
       SXA KON,1
L6163  TXH L6172,1,5
       STL L6113
       TRA L6103
       PAI
L6167  RNT 0
       TXI L6163,1,2
       TRA L6200
L6172  ZET L6410
       TRA *+4
       AXT 1,1
       STL L6410
       TRA L6163+1
       LXA KON,1
       CAL L6375
       ANA L6401
       ADD L6425,1
       STZ L6410
       TRA L6072
       REM    
TRCX   LXA L6410,1      CHANNEL TO BE TESTED
       LNT 064000
       TRA *+8
       LFT 311000
       TRA *+6
       LNT 066000
       TRA L6251
       LNT 066400
       TRA L6253
       TRA L6255
       REM
       LNT 07400
       TRA *+2        NO
       TRA TEF        YES
       LNT 054000     RESET LOAD INST
       TRA *+4
       LFT 023000
       TRA *+2        NO
       LNT 054400     
       TRA L6257
       TRA LCH        YES
       REM
       LNT 006000     CHANNEL OPERATION
       TRA *+4
       LNT 371000
       TRA *+2        
       LNT 400000
       TRA L6266
       TRA TCO        YES
       LFT 375700
       LNT 002000     IS THIS A CONTROL
       TRA *+5
       LFT 374000
       TRA *+2        INSTRUCTION- NO
       LNT 003000     END OF FILE CONTROL
       TRA *+4
L6247  CAL L6334
       TRA L6264
L6251  CAL L6334+1
       TRA L6264
L6253  CAL L6334+2
       TRA L6264
L6255  CAL L6334+3
       TRA L6264
L6257  CAL L6334+4
       TRA L6264
L6261  CAL L6334+5
       TRA L6264
L6263  CAL L6334+7,1
L6264  ACL L6334,1
       TRA TRAN
L6266  CAL L6334+6
       TRA *+2
L6270  CAL L6334+7
       ACL L6333,1
       ACL L6334,1
TRAN   LNT 000060
       TRA *+2
       ORA K          L HTR 0,0,60
       STD INST
       STP INST
       REM
CHAN   CLA CTRX
       STA *+2
       CLA INST       INSTRUCTION
       STO 0
       NZT BCD        CHECK BCD WORD
       TRA FINE       CHECK NEXT WORD
       LDI INST       PLACE CURRENT INSTR IN INDS
       LNT 070000
       TRA FINE
       CAL BCD+1
       ANS BCD        MASK
       CLA L6410
       ALS 12
       ORS BCD        BCD WORD
       CLA INST       PRESENT I/O WORD
       ANA KON2       L +17
       TZE FINE
       ORA BCD        OBTAIN UNIT NUMBER
BCDX   SLW 0
       STZ BCD
       TRA FINE
       REM
L6325  OCT  000300000000
       OCT -000200000000
       OCT  000200000000
       OCT -000100000000
       OCT  000100000000
       OCT -000000000000
L6333  OCT 0
L6334  OCT 003000000000
       OCT 064000000000
       OCT 066400000000
       OCT 066000000000
       OCT 054400000000
       OCT 054000000000
       OCT -006000000000
       OCT 006000000000
       OCT 002400000000
       OCT 002400000000
       OCT 002300000000
       OCT 002300000000
       OCT 002200000000
       OCT 002200000000
       HTR 75500
       HTR 77200
       HTR 77000
       HTR 76600
       HTR 76400
       HTR 76200
       HTR 76000
       REM
       REM
       REM
       REM          COSNTANT
       REM
KON    OCT 0
       OCT 1
       OCT 3
FOUR   OCT 4
TEN    OCT +12
       OCT 7
L6367  OCT 0
LASTA  CAL 0         L LAST ADDR OF PROGRAM
KON2   OCT +17
L6372  OCT 0
KON4   RNT 6220
       RNT 6367
L6375  OCT 0
L6376  OCT 777
L6377  OCT 0
       OCT 220
       OCT 367
CHX    OCT 0
IND    OCT 0
BCD    OCT 0
       OCT 777777707700
       OCT 0
L6407  OCT 0
L6410  OCT 0
ACCX   OCT 0
       OCT 0
       OCT 0
       OCT 0
       OCT 4000
       OCT 2000
       OCT 1000
       HTR 0         INITIAL ADDR OF UNIT
       OCT -0
KON3   PZE 24
       OCT +7000
       REM
ADDR   HTR 0
       HTR CTRX
INST   PZE 0
       OCT 221
       OCT 367
BCD    PZE 0
BIT    OCT 0
TRC    CAL *+8,1
       TRA TRAN
       REM
       TRCF 0
       TRCE 0
       TRCD 0
       TRCC 0
       TRCB 0        INSTRUCTION	
       TRCA 0        REDUNDANCY TAPE TEST
       REM
TEF    CAL *+8,1
       TRA TRAN
       REM
       TEFF 0
       TEFE 0
       TEFD 0
       TEFC 0
       TEFB 0        INSTRUCTION	
       TEFA 0        END OF FILE TEST
       REM
TCO    CAL *+10,1    L CHN IN OPN INSTRUCTION
       LFT 400000    CHK IF CHN NOT IN OPN REQ,0
       ORA KON2+2    YES - SET SIGN MINUS
       TRA TRAN      NO - GO TO SET INST
       REM
       TCOF 0
       TCOE 0
       TCOD 0
       TCOC 0
       TCOB 0        
       TCOA 0       
       REM
LCH    LNT 054400    IS THIS A LOAD CHAN INST
       TRA RCH
       CAL *+8,1
       TRA TRAN
       REM
       LCHF
       LCHE 
       LCHD 
       LCHC 
       LCHB         
       LCHA        
       REM
SCH    LFT 300000 
       TRA FINE
       CAL *+8,1
       TRA TRAN
       REM
       SCHF
       SCHE 
       SCHD 
       SCHC 
       SCHB         
       SCHA        
       REM
RCH    CAL *+8,1
       TRA TRAN
       REM
       RCHF
       RCHE
       RCHD
       RCHC 
       RCHB
       RCHA
       REM
OPTAB  OCT 476400    BACKREM FILE
       OCT 476000    END OFTAPE TEST
       OCT 077200
       OCT 077000    WRITE END OF FILE
       OCT 076600    WRITE SELECT
       OCT 076400    BACKREM RECORD
       OCT 076200    READ SELECT
       OCT 076000    BEGINNING OF TAPE TEST
K      HTR 0,0,48 
RCDA   LDI CTRL2
       RNT 200001
       TRA RCDC
       TRA WPRA+3
       REM
RCDC   LDI CTRL3
       RNT 400001
       TRA RCDE
       TRA WPRC+3
RCDE   LDI CTRL1
       RNT 100001
       TRA FINE
       TRA WPRE+3
EQU    TRA *+7,1
       TRA CHB
       TRA CHF
       TRA CHE
       TRA CHD
       TRA CHC
       REM
CHA    LDI CTRL1      CONTROL WORD FOR DS A+B
       TXI *+1,1,1
       RNT 101000     CHECK FOR DSC B + TAPE
       TRA CHC        NOT CHANNEL B
       RFT 40000      CHECK FOR EXCLUSIVE BIT
       REM            FOR CHANNEL B,D,F
       STO BIT        SET CHK FOR EXCLU UNIT BIT
       TRA *+3        NO BIT - SET FOR UNIT 1
       REM
       RFT 400        CHECK FOR EXCLUSIVE BIT
       REM            FOR CHANNEL A,C,E
       STO BIT        SET CHK FOR EXCLU UNIT BIT 
       PXA 0,2        L CURRENT CHANNEL ADDRESS
       ANA INST+1     L +200 - CLEAR TO CLASS
       REM            AND MODE
       STO KON2+1
       PXA 0,1        L CHANNEL COUNTER
       ALS 9          POSITION FOR ADDRESS
       ADD KON2+1     ADD CLASS AND MODE
       PAX 0,2        SAVE ADJUSTED CHN ADDRESS
       NZT BIT        CHECK FOR EXCLU UNIT BIT
       TRA WTBB-11    NO - GO TO SET UNIT 1
       STO ADDR       SAVE NEW INITIAL ADDRESS
       STZ BIT        RESET EXCLU CHECK BIT
       TRA WTB        YES - GO TO SET EXCLU UNIT
       REM
       REM
CHC    LDI CTRL2
       RNT 200010     CHECK FOR DSC C + TAPE 
       TXI CHD,1,1
       TXI CHA+7,1,1
       REM
CHD    LDI CTRL2
       RNT 201000     CHECK FOR DSC D + TAPE 
       TXI CHE,1,1
       TXI CHA+4,1,1
       REM
CHE    LDI CTRL3      CONTROL 3
       RNT 400010     CHECK FOR DSC E + TAPE 
       TXI CHF,1,1
       TXI CHA+7,1,1
       REM
CHF    LDI CTRL3
       RNT 401000     CHECK FOR DSC F + TAPE 
       TXI CHB,1,1
       TXI CHA+4,1,1
       REM
CHB    LDI CTRL1
       RNT 100010     CHECK FOR DSC A + TAPE 
       TXI CHA,1,5
       TXI CHA+7,1,5
       REM
       LXA *+1,2
       RNT 5340      TEST FOR PUNCH ADDR
       TRA *+2
       TRA WPU
       CAL WPUX+2
       SUB KON+5     L + 2000
       STA WPUX+2
       TIX WPUX+1,1,1
       REM
       LXA *+1,2
       RNT 5320      TEST FOR READER ADDR
       TRA *+2
       TRA RCD       YES
       CAL RCDX+2
       SUB KON+5
       STA RCDX+2
       TIX RCDX+1,1,1
       REM
       LXA *+1,2     PUT ADDR INTO XRB
       RNT 6220      TEST FOR BINARY ADDR
       TRA *+2       NO
       TRA WTB       YES
       REM
       CAL WTBX+2
       SUB KON+3     L 1000
       STA WTBX+2
       TIX WTBX+1,1,1
       LXA *+1,2
       RNT 6200      TEST FOR BCD MODE
       TRA *+2
       TRA WTB
       REM
       CAL WTDX+2
       SUB KON+3     L + 1000
       STA WTDX+2
       TIX WTDX+1,1,1
       LXA *+1,2
       RNT 6000      CHECK BEGINNING OF TAPE
       TRA *+2       TEST + END OF TAPE TEST
       TRA BTT
       CAL BTTX+2
       SUB KON+3     L +1000
       STA BTTX+2
       TIX BTTX+1,1,1
       TRA FINE
       REM
WTB    SXA KON2+1,2  INITIAL ADDR INTO STOR
       TRA *+7,1
       TRA WTBF
       TRA WTBE
       TRA WTBD
       TRA WTBC
       TRA WTBB
       REM
WTBA   CAL CTRL1    L CONTROL WORD FOR CHN A+B
       PAI          PUT ACC IN INDICATORS
       ARS 4
       ANA KON2     L +17 - CLEAR TO UNIT
       ADD KON2+1   L INITIAL ADDR FOR CHN
       CAS ADDR
       TRA *+3      OK - SET INSTRUCTION
       TRA EQU      EQUAL
       TRA EQU      CHECK FOR UNITS ON CHN B
       RNT 400      CHK FOR EXCLUSIVE UNIT BIT
       TRA *+2      NO - GO TO STEP UNIT
       TRA *+3      YES - GO TO SET EXCLU UNIT
       CAL INST     L CURRENT INSTRUCTION
       ADD KON+1    L +1  - STEP UNIT
       TXH *+5,1,1  CHECK FOR CHANNEL A
       LFT 400000   IS CHN A - CHECK FOR BIT
       REM          SIGNIFYING PROGRAM READ
       REM          FROM CARDS
       TRA *+5      BIT - ANY UNIT OK
       PAI          NO BIT - L NEW UNIT ADDR
       RFT 000016   TO CHECK FOR UNIT 1
       REM          WHICH MUST BE BLOCKED OUT
       TRA *+2      NOT UNIT 1
       REM
       ADD KON+1    IS UNIT 1 - L +1
       REM
       STA INST
       SXA CHX,1    SAVE CHANNEL COUNT
       TRA CHAN
       REM
       REM
WTBB   CLA CTRL1    
       ARS 6
       TRA WTBA+1
WTBC   CLA CTRL2    CONTROL WORD FOR DS C+D
       TRA WTBA+1
WTBD   CLA CTRL2    
       TRA WTBB+1
WTBE   CLA CTRL3    CONTROL WORD FOR DS E+F
       TRA WTBA+1
WTBF   CLA CTRL3   
       TRA WTBB+1
WPR    TRA *+4,1
       TRA WPRE
       TRA WPRC
WPRA   LDI CTRL2
       RNT 200002
       TRA WPRC
       TXI *+1,1,2
       CLA ADDR
       ANA INST+2    L+1367
       ADD KON+5
       TRA WTBB-3
WPRC   LDI CTRL3
       RNT 400002
       TRA WPRE
       TXI *+1,1,3
       CLA ADDR
       ANA INST+2    L+1367
       ADD INST+3
       TRA WTBB-3
WPRE   LDI CTRL1
       RNT 100002
       TRA *+4
       TXL *+2,1,3
       TIX *+1,1,1
       TIX *+1,1,1
       CLA ADDR
       ANA INST+2
       TRA WTBB-3
WPU    TRA *+4,1
       TRA WPUE
       TRA WPUC
WPUA   LDI CTRL2
       RNT 200004
       TRA WPUC
       TRA WPRA+3
WPUC   LDI CTRL3
       RNT 400004
       TRA WPUE
       TRA WPRC+3
WPUE   LDI CTRL1
       RNT 100004
       TRA WTBB-2
       TRA WPRE+3
RCD    TRA *+4,1
       TRA RCDE
       TRA RCDC
       END
