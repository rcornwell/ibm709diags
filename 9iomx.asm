       TTL  9IOMA
*               9 I O M A
*       709 ROUTINE FOR MODIFICATION OF
*              I-O INSTRUCTIONS
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
*
*     ENTER CONTROL WORDS FOTR CHANNELS AND UNITS
*
IOC    STZ CTRL1     CLEAR
       STZ CTRL2     CONTROL
       STZ CTRL3     WORDS.
       SPACE 3
       HTR *+1       ENTER KEYS WITH CONTROL
       REM           WORD FOR CHN A AND/OR B
*     INCLUDE THE DATA SYSNC TO BE USED IN THE TAG
*     OF THE CONTROL WORD
       SPACE 1
*   NOTE - A TAG OF 1 WILL SPECIFY CHAN A AND/OR B
*          A TAG OF 2 WILL SPECIFY CHAN C AND/OR D
*          A TAG OF 4 WILL SPECIFY CHAN E AND/OR F
       SPACE 1
*      IF 2 OR MORE DS ARE TO BE TESTED THE 1ST CONTROL
*      WORD ENTERED IN THE KEYS SHOULD CONTIAN A MULTIPLE TAG
       SPACE 1
       ENK           PLACE WORD
       XCL           ENTERED ON KEYS
       PAI           IN INDICATORS
DSC    RFT 0,7       DO WE HAVE A TAG BIT
       TRA DSC1      YES
       HTR *-5       NO TAG BIT - RE-ENTER FIRST
       REM           CONTROL WORD SPECIFYING 
       REM           OS IN TAG OF KEYS
DSC1   RNT 0,1       TEST FOR CHAN A AND/OR B
       TRA DSC2      NO
       STI CTRL1     CNTL WORD FOR A AND/OR B
DSC2   RNT 0,2       TEST FOR CHAN C AND/OR D
       TRA DSC3      NO
       HTR *+1       SET CONT WORD IN KEYS
       REM           FOR CHAN C AND/OR D
       ENK
       STQ CTRL2
DSC3   RNT 0,4       TEST FOR CHAN E AND/OR F
       TRA *+4       NO
       SPACE 2
       HTR *+1       SET CONT WORD IN KEYS
       REM           FOR CHAN E AND/OR F
       ENK
       STQ CTRL3
*    ESTABLISH UNIT COUNT FROM CONTROL WORDS
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
       CLA KON+2     YES - L + 1 FOR COUNT
       STO CTRA+6,1  SAVE CHN UNIT CONT
       ADD IOCT
       STO IOCT	    SAVE TOTAL UNIT COUNT
       TIX *+1,1,1,
       TIX AB-2,4,1
       TIX AB-3,2,1
       LXA ACCX,4    RELOAD XRC
       SPACE 1
CNT    CLA FOUR      L +4
       PAX 0,2       L ACC IN XRB
       SXA *+4,2     L XRB IN ADDRESS
       AXT 3,1       L +3 IN XRA
       CLM
       LDI CTRL3+1,1
       RNT           CHECK NUMBER OF
       REM           CARD MACHINES ON LINE
       TRA *+2       NO
       ADD KON+2     YES - L +1
       TIX *-4,1,1
       CAS IOCT
       STA IOCT
       NOP
       PXA 0,2       L XRB IN ACC
       ARS 1
       TIX CNT+1,2,1
       TRA 1,4       EXIT TO MAIN PROG
*      MODIFY I-O INSTRUCTIONS
CTX1   STO ACCX      ACC CONTENTS
       STI IND       SAVE INDICATORS
       NOP
       SXA ACCX+2,1
       SXD ACCX+2,2
       STQ ACCX+3
*    EXTABLISH PROGRAM AREA TO MODIFY
       CLA 1,4       L FIRST AND LAST ADDRESS
       REM           PROGRAM AREA TO BE MODIFED
       STA CTRX      SAVE FIRST ADDRESS
       ARS 18
       STA KON+1     SAVE LAST ADDRESS
*   IDENTIFY I-O INSTRUCTION
CTRX   CAL 0         L CURRENT INSTRUCTION
       NOP
       SLW INST      SAVE CURRENT INSTRUCTION
       PAI           PLACE INST IN INDICATORS
       STA ADDR      TEST INST IN I/O TABLE
       LXD TEN,1     L +12
       CLA OPTAB+10,1
       STA *+2
       STT *+1
       SPACE 2
       LNT 0         TEST FOR I/O INSTRUCTION
       TRA *+5
       LFT 300100
       TRA *+3
       LNT 077400
       TRA OPR1
       TIX *-9,1,1
*      TEST FOR BCD WORD
       RNT 206000
       TRA TRCX
       RFT 501700
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
       TRA FINE
       SPACE
OPR1   TRA *+11,1
       TRA WTDX      BSFX
       TRA BTTX      ETTX
       TRA WTBX      REWX
       TRA WTBX
       TRA WPRX
       TRA WTBX      BRXX
       TRA WPRX
       TRA WPRX
       TRA WTBX
       TRA WTBX
       SPACE
FINE   CAL KON3+1    L +7000
       ORS WTBX+2
       ORS WTDX+2
       ORS BTTX+2
       ORS WPRX+2
       ORS WPUX+2
       ORS RCDX+2
       CAL KON4      MASK  6220
       ANS WTBX+2
       ANS WTDX+2
       ANS BTTX+2
       CAL KON4+1
       ANS WPRX+2
       ANS WPUX+2
       ANS RCDX+2
       SPACE 1
       CLA CTRX      L CURRENT LOCATION IN PROGRAM
       CAS KON+1     LAST LOCATION IN PROG
       TRA *+3
       TRA FIN
       HTR *-1       EXIT
       SUB KON+2     L+1
       STA CTRX
       TRA CTRX
       SPACE 1
FIN    LDI IND
       CLA ACCX+1    RESTORE REGISTERS
       LDQ ACCX      ETC.
       LLS 35
       LDQ ACCX+3
       LXA ACCX+2,1
       LXD ACCX+2,2
       TRA 2,4
WPRX   LXA KON+4,1   L +3
       LXA *+1,2
       RNT 5360      TEST FOR PRINTER ADDR
       TRA *+2       NO
       TRA WPR
       SPACE 1
       CAL WPRX+2
       SUB KON+5     L+ 2000
       STA WPRX+2
       TIX WPRX+1,1,1
WPUX   LXA KON+4,1   L+3
       LXA *+1,2
       RNT 5340      TEST FOR PUNCH ADDR
       TRA *+2
       TRA WPU
       CAL WPUX+2
       SUB KON+5     L + 2000
       STA WPUX+2
       TIX WPUX+1,1,1
       SPACE 1
RCDX   LXA KON+4,1   L+3
       LXA *+1,2
       RNT 5320      TEST FOR READER ADDR
       TRA *+2
       TRA RCD       YES
       CAL RCDX+2
       SUB KON+5
       STA RCDX+2
       TIX RCDX+1,1,1
       SPACE 1
WTBX   LXA KON,1     L +6
       LXA *+1,2     PUT ADDR INTO XRB
       RNT 6220      TEST FOR BINARY ADDR
       TRA *+2       NO
       TRA WTB       YES
       SPACE
       CAL WTBX+2
       SUB KON+3     L 1000
       STA WTBX+2
       TIX WTBX+1,1,1
WTDX   LXA KON,1     L+ 6
       LXA *+1,2
       RNT 6200      TEST FOR BCD MODE
       TRA *+2
       TRA WTB
       SPACE
       CAL WTDX+2
       SUB KON+3     L + 1000
       STA WTDX+2
       TIX WTDX+1,1,1
BTTX   LXA KON,1     L+6
       LXA *+1,2
       RNT 6000      CHECK BEGINNING OF TAPE
       TRA *+2       TEST + END OF TAPE TEST
       TRA BTT
       CAL BTTX+2
       SUB KON+3     L +1000
       STA BTTX+2
       TIX BTTX+1,1,1
       TRA FINE
       SPACE
BTT    CLA CHX
       ALS 9
       TZE FINE
       STA INST
       TRA CHAN
       SPACE
WTB    SXA KON2+1,2  INITIAL ADDR INTO STOR
       TRA *+7,1
       TRA WTBF
       TRA WTBE
       TRA WTBD
       TRA WTBC
       TRA WTBB
       SPACE
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
       ADD KON+2    L +1  - STEP UNIT
       TXH *+5,1,1  CHECK FOR CHANNEL A
       LFT 400000   IS CHN A - CHECK FOR BIT
       REM          SIGNIFYING PROGRAM READ
       REM          FROM CARDS
       TRA *+5      BIT - ANY UNIT OK
       PAI          NO BIT - L NEW UNIT ADDR
       RFT 000016   TO CHECK FOR UNIT 1
       REM          WHICH MUST BE BLOCKED OUT
       TRA *+2      NOT UNIT 1
       SPACE
       ADD KON+2    IS UNIT 1 - L +1
       SPACE
       STA INST
       SXA CHX,1    SAVE CHANNEL COUNT
       TRA CHAN
       SPACE 2
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
RCDA   LDI CTRL2
       RNT 200001
       TRA RCDC
       TRA WPRA+3
       SPACE
RCDC   LDI CTRL3
       RNT 400001
       TRA RCDE
       TRA WPRC+3
RCDE   LDI CTRL1
       RNT 100001
       TRA FINE
       TRA WPRE+3
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
       CLA CHX
       ALS 12
       ORS BCD        BCD WORD
       CLA INST       PRESENT I/O WORD
       ANA KON2       L +17
       TZE FINE
       ORA BCD        OBTAIN UNIT NUMBER
BCDX   SLW 0
       STZ BCD
       TRA FINE
       SPACE
EQU    TRA *+7,1
       TRA CHB
       TRA CHF
       TRA CHE
       TRA CHD
       TRA CHC
       SPACE
CHA    LDI CTRL1      CONTROL WORD FOR DS A+B
       TXI *+1,1,1
       RNT 101000     CHECK FOR DSC B + TAPE
       TRA CHC        NOT CHANNEL B
       RFT 40000      CHECK FOR EXCLUSIVE BIT
       REM            FOR CHANNEL B,D,F
       STO BIT        SET CHK FOR EXCLU UNIT BIT
       TRA *+3        NO BIT - SET FOR UNIT 1
       SPACE
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
       SPACE 2
CHC    LDI CTRL2
       RNT 200010     CHECK FOR DSC C + TAPE 
       TXI CHD,1,1
       TXI CHA+7,1,1
       SPACE
CHD    LDI CTRL2
       RNT 201000     CHECK FOR DSC D + TAPE 
       TXI CHE,1,1
       TXI CHA+4,1,1
       SPACE
CHE    LDI CTRL3      CONTROL 3
       RNT 400010     CHECK FOR DSC E + TAPE 
       TXI CHF,1,1
       TXI CHA+7,1,1
       SPACE
CHF    LDI CTRL3
       RNT 401000     CHECK FOR DSC F + TAPE 
       TXI CHB,1,1
       TXI CHA+4,1,1
       SPACE
CHB    LDI CTRL1
       RNT 100010     CHECK FOR DSC A + TAPE 
       TXI CHA,1,5
       TXI CHA+7,1,5
       SPACE
TRCX   LXA CHX,1      CHANNEL TO BE TESTED
       LNT 064000
       TRA *+4
       LFT 013000
       TRA *+4
       TRA SCH
       SPACE
       LNT 054000     RESET LOAD INST
       TRA *+4
       LFT 023000
       TRA *+2        NO
       TRA LCH        YES
       SPACE
       LNT 006000     CHANNEL OPERATION
       TRA *+4
       LFT 71000
       TRA *+2        
       TRA TCO        YES
       LNT 003000     END OF FILE CONTROL
       TRA *+4
       LFT 074000
       TRA *+2        NO
       TRA TEF        YES
       LNT 002000     IS THIS A CONTROL
       TRA *+5
       LFT 600
       LFT 375100
       TRA *+2        INSTRUCTION- NO
       TRA TRC        YES
       TRA FINE
       SPACE
TRAN   LNT 000060
       TRA *+2
       ORA K          L HTR 0,0,60
       STD INST
       STP INST
       TRA CHAN
       SPACE
TRC    CAL *+8,1
       TRA TRAN
       SPACE
       TRCF 0
       TRCE 0
       TRCD 0
       TRCC 0
       TRCB 0        INSTRUCTION	
       TRCA 0        REDUNDANCY TAPE TEST
       SPACE
TEF    CAL *+8,1
       TRA TRAN
       SPACE
       TEFF 0
       TEFE 0
       TEFD 0
       TEFC 0
       TEFB 0        INSTRUCTION	
       TEFA 0        END OF FILE TEST
       SPACE
TCO    CAL *+10,1    L CHN IN OPN INSTRUCTION
       LFT 400000    CHK IF CHN NOT IN OPN REQ,0
       ORA KON2+2    YES - SET SIGN MINUS
       TRA TRAN      NO - GO TO SET INST
       SPACE
       TCOF 0
       TCOE 0
       TCOD 0
       TCOC 0
       TCOB 0        
       TCOA 0       
       SPACE
LCH    LNT 054400    IS THIS A LOAD CHAN INST
       TRA RCH
       CAL *+8,1
       TRA TRAN
       SPACE
       LCHF
       LCHE 
       LCHD 
       LCHC 
       LCHB         
       LCHA        
       SPACE
SCH    LFT 300000 
       TRA FINE
       CAL *+8,1
       TRA TRAN
       SPACE
       SCHF
       SCHE 
       SCHD 
       SCHC 
       SCHB         
       SCHA        
       SPACE
RCH    CAL *+8,1
       TRA TRAN
       SPACE
       RCHF
       RCHE
       RCHD
       RCHC 
       RCHB
       RCHA
       SPACE
OPTAB  OCT 476400    BACKSPACE FILE
       OCT 476000    END OFTAPE TEST
       OCT 077200
       OCT 077000    WRITE END OF FILE
       OCT 076600    WRITE SELECT
       OCT 076400    BACKSPACE RECORD
       OCT 076200    READ SELECT
       OCT 076000    BEGINNING OF TAPE TEST
       OCT 077500    DROP READY
       OCT 477500    TEST READY
       SPACE 3
       REM          COSNTANT
FOUR   OCT +4
TEN    OCT +12
       SPACE
KON    HTR 6,0,8
       CAL 0         L LAST ADDR OF PROGRAM
       OCT +1
       OCT 1000
       OCT 3
       OCT 2000
KON2   OCT +17
       HTR 0         INITIAL ADDR OF UNIT
       OCT -0
KON3   PZE 24
       OCT +7000
KON4   RNT 6220
       RNT 5367
       SPACE
ADDR   HTR 0
       HTR CTRX
INST   PZE 0
       OCT 221
       OCT 1367
       OCT 4000
CHX    OCT 0
IND    OCT
BCD    PZE 0
       OCT 777777707700
BIT    OCT 0
ACCX   OCT 0
       OCT
       OCT 0
       OCT 0
K      HTR 0,0,48 
       END
