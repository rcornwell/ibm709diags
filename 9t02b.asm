*                                                            9T02B
*                                                           8-01-59
*                            9T02B
       REM
*                 BUFFER TAPE TEST
       REM
       ORG 24
       REM
       TSX PRID,4     GO TO PRINT TEST ROUTINE
       REM
INIT   CLA WTBA1      INITIALIZE
       SUB PRSEL      CHANGE TO CH A
       TZE IAL
       TSX CTX,4
       HTR B1-4,0,B32A+6
       TRA INIT
IAL    CLA ETTB
       SUB E3
       TZE IZE
       TSX CTX,4
       HTR E1-4,0,E32A+6
       TRA IAL
IZE    CLA ETTA
       SUB F1+2       CHANGE TO CH A
       TZE AM
       TSX CTX,4
       HTR  TESAB,0,F11
       TRA IZE
AM     CLA SEP2
       SUB WTBB1      CHANGE TO CH B
       TZE ENTER
       TSX CTX,4
       HTR TESBA,0,F12+2
       TRA AM
       REM
       REM
       REM
ENTER  TSX IOC,4      ENTER CONTROL WORDS
       REM
       CLA POST       POST RESTART
       STO 0
       REM
       CLA B1
       ADD CONST
       STO  FIX1
MOD1   CLA CTRL1      SAVE ORIGINAL
       STO SAVE1      CONTROL WORDS
       CLA CTRL2
       STO SAVE2
       CLA CTRL3
       STO SAVE3
       CLA ANB        INSERT SYNTHETIC
       STO CTRL1      CONTROL WORDS
       CLA CND        SO THAT PROG
       STO CTRL2      CAN INTERROGATE
       CLA ENF        ALL CHANNELS
       STO CTRL3
       REM
       CLA SAVE1      IS DIAGNOSTIC
       TPL TAPE       ON TAPE
       TRA STA        NO
TAPE   CLA MIANB      YES
       STO CTRL1      TEST TU2
       CLA RTBA       READ NEXT
       STO PROG       DIAGNOSTIC
       REM            FROM TAPE
       CLA WTBA2      IS TU2 SET UP
       SUB PRSEL
       TZE STA        YES
IOM    TSX CTX,4      NO
       HTR B1-4,0,B32A+6
       TSX CTX,4
       HTR TESAB,0,F11
       TRA TAPE
       REM
*    TEST TAPE CHANNEL A
       REM
*            TEST CHANNEL A - UNIT ONE
       REM
STA    CLA B1         WHICH CHAN IS
       CAS FIX1       BEING TESTED SEC 1
       TRA C33        CH E
       TRA C22        CH C
       TRA C11        CH A
       REM
C11    CLA SAVE1
       ARS 3
       LBT
       TRA SECB       NO CH A TEST
       TRA B1-3       TEST CH A
SECB   ARS 6
       LBT
       TRA MOD        NO CH A OR B TEST
       TRA E1-3       TEST CH B
C22    CLA SAVE2
       ARS 3
       LBT
       TRA SECD       NO CH C TEST
       TRA B1-3       TEST CH C
SECD   ARS 6
       LBT
       TRA MOD        NO CH C OR D TEST
       TRA E1-3       TEST CH D
C33    CLA SAVE3
       ARS 3
       LBT
       TRA SECF       NO CH E TEST
       TRA B1-3       TEST CH E
SECF   ARS 6
       LBT
       TRA F19        NO CH E OR F TEST
       TRA E1-3       TEST CH F
       REM
       REM
       BCD 1TEFA      TEST TRANSFER ON DSU A
       REM            END OF FILE
       REM
       TRA *+2
       WTBA 1         DUMMY SELECT
       TEFA *+1
B1     TEFA *+2       EOF INDICATOR SHOULD BE
       REM            OFF
       TRA *+5        OK
       TSX ERROR-1,4
       TXL B1,4,0
       TRA B3         CONTINUE
       REM
       BCD 1WTBA      TEST WRITE TAPE BINARY
       REM
B3     ETTA
       REWA 1         PREPARE TO WRITE ONE
       REM            WORD
PRSEL  WTBA 1
       RCHA K1        RESET AND LOAD CHAN A
       TCNA *+2       DSU A NOT IN OPERATION
       TRA *-1
       STZ K25        SET STORAGE TO ZEROS
       SCHA K25       STORE CHANNEL A
       REM
       TSX RDNCK,4    CHECK TAPE CK
       TRA B3
       TRA B4         CONTINUE
       REM
       BCD 1TCOA      TEST TCOA-TRANSFER ON
       REM            DSU A IN OPERATION
       REM
B4     TCOA *+2
       TRA B5          OK
       TSX ERROR-1,4
       TXL B4         REPEAT
       TRA *+2
       REM
       BCD 1SCHA      TEST SCHA-STO. CHAN. A
       REM
B5     CLA K23        LOC. REG,ADDR. REG.
       LDQ K25
       CAS K25        CHANNEL A CONTENTS
       TRA *+2        ERROR
       TRA B6         OK
       REM
       REM            IF INCORRECT INFORMATION
       REM            IS IN CHANNEL A THE ERROR
       REM            OCCURRED AT B3-TEST WRS
       TSX ERROR-1,4
       NOP B5
       TRA B6         CONTINUE
       REM
       BCD 1TCNA      TEST TR ON CHAN NOT IN OPN
       REM
B6     TCNA *+3
       TSX ERROR-1,4
       TXL B6,4,0     DO NOT REPEAT
       TSX OK,4
       TRA B3         REPEAT
       REM
       BCD 1RTBA      TEST READ TAPE BINARY
       REM            CHANNEL A
       REM
B7     LXA K6+2,3     L+1
       CLA K6+6       L+2
       STO WDNO       SET WORD NO CONSTANT
       STO RECNO      SET REC NO CONSTANT
       REM
       BSRA 1         BACKSPACE TAPE
       STZ K21+1
       RTBA 1         READ RECORD
       RCHA K1A1
       TCOA *
       SCHA K25       SAVE CONTENTS OF CHANNEL
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA B7
       REM
B8     CLA K20        WORD WRITTEN
       LDQ K21        WORD READ
       CAS K21        WORD READ
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       TRA B7
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
B8A    NZT K21+1
       TRA *+5        OK
       TSX ERROR-1,4
       TRA B3         WROTE MORE THAN ONE WORD
       TRA *+2        CONTINUE
       REM
       BCD 1SCHA      TEST SCHA-STO. CHAN. A
       REM
B9     CLA K23A       CORRECT CONTS. OF CHANNEL A
       LDQ K25        RESULTS SCHA OPERATION
       CAS K25
       TRA *+2        ERROR
       TRA *+3        OK
       REM
       TSX ERROR-1,4
       NOP B9
       TSX OK,4
       TRA B7         REPEAT
       REM
       REM
       BCD 1WTBA      TEST WRITING 2-1 WORD RECS
B10    ETTA
       REWA 1
       WTBA 1
       RCHA K1A2      TGR S HAS A BIT
       WEFA 17
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA B10
       TRA *+2
       REM
       BCD 1RTBA      TEST READING 2-1 WORD RECS
       REM
B11    BSRA 1         BACKSPACE
       BSRA 1         OVER EOF + TWO RECS
       BSRA 1
       LXA K6+6,3     L+2
       CLA K6+5       L+3
       STO WDNO
       STO RECNO      RESET REC NUMBER
       STZ K21+1
       STZ K21A+1
       RTBA 1
       RCHA K1A9      READ TWO 1-WORD REC + EOF
       REM            S+1 TGRS ON
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA B11
       REM
B12    CLA K20A       WORD WRITTEN
       LDQ K21        WORD READ
       CAS K21        WORD READ
       TRA *+2        ERROR
       TRA *+3        OK CHECK NEXT RECORD
       TSX ERROR-2,4
       NOP B11        DO NOT REPEAT
       TIX *+1,1,1    DECREMENT WORD NO
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
B13    CLA K20A1      WORD WRITTEN
       LDQ K21A       WORD READ
       CAS K21A       WORD READ
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-2,4
       TRA B11
       TRA *+2        CONTINUE
       REM
       BCD 1TEFA
       REM
       TEFA *+3       IS IND ON-YES/OK
       TSX ERROR-1,4  NO-ERROR
       TXL *-2        REPEAT
       TEFA *+2       IS IND ON-YES-ERROR
       TRA *+3        NO-OK
       TSX ERROR-1,4
       TXL *-6,4,0    CONTINUE
       TRCA *+1       TURN OFF RND IND
       REM
B13A   CLA K21+1      CHECK IF THESE TWO
       ADD K21A+1     POSITIONS CONTAIN ZEROS
       TZE *+2        OK
       TSX ERROR,4
       TSX OK,4
       TRA B10        ERROR IN WRITING TWO
       REM            ONE WORD RECORDS REPEAT
       REM            COMPLETE TEST
       REM
       BCD 1IOT       TEST IOT INSTRUCTION
       REM
B14    LCHA K1        TURN ON I/O CHECK IND
       IOT            I/O CHECK TEST
       TRA *+3        OK
       TSX ERROR-1,4
       TXL B14        REPEAT
       REM
B15    IOT            I/O CHECK TEST
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       TXL B14        REPEAT
       TSX OK,4
       TRA B14        REPEAT
       REM
       BCD 1WTBA      TEST OPERN OF TGRS 1 AND 2
       REM            WHEN WRITING
       REM            THE FOURTH RECORD
       REM
B16    ETTA           END OF TAPE TEST
       REWA 1
       WTBA 1
       RCHA K1A6
       STZ K25        STORE ZEROS IN K25
       SCHA K25       CHECK STATUS OF TGRS
       LCHA K1A7
       TRA *+2        CONTINUE
       REM
       BCD 1IOT       TEST I/O TGR + IND
       REM
       IOT
       TRA *+2        ERROR-CHANNEL A WAS
       REM            NOT SELECTED
       TRA *+3
       REM
B16A   TSX ERROR-1,4
       TXL *-4        REPEAT
       TRA B16B       CONTINUE
       REM
       BCD 1SCHA      TEST TGRS.-SCHA INSTR.
       REM
B16B   CAL K25
       PBT            WAS S TGR ON
       TRA *+2        ERROR
       TRA B17
       TSX ERROR-1,4
       NOP B16B
       REM
B17    ALS 1
       PBT            WAS TGR 1 ON
       TRA *+3        OK
       TSX ERROR-1,4
       NOP B16B
       REM
B18    ALS 1
       PBT            WAS TGR 2 ON
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP B16B
       REM
B19    TSX RDNCK,4    CHECK TAPE RDN IND
       TRA B16
       TSX OK,4
       TRA B16        REPEAT
       REM
       BCD 1RTBA 1    TEST IF 4TH RECORD WAS
       REM            WRITTEN CORRECTLY
       REM
B20    BSRA 1         BACKSPACE ONE RECORD
       LXA K6+6,3     L+2
       RTBA 1         READ TAPE IN BINARY
       STZ K21+1
       STZ K21A+1
       RCHA K2        TGRS S AND 2 ARE ON
       LCHA K1A8      S AND 1 ARE OFF, 2-ON
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA B20
       REM
B21    CLA K20A       WORD WRITTEN
       LDQ K21        WORD READ
       CAS K21        WORD READ
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       NOP B20        DO NOT REPEAT
       TIX *+1,1,1    DECREMENT WORD NO
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
B22    CLA K20A3      WORD WRITTEN
       LDQ K21A       WORD READ
       CAS K21A       WORD READ
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       TRA B20
       REM
B22A   CLA K21+1
       ADD K21A+1
       TZE *+2        OK
       TSX ERROR,4
       TSX OK,4
       TRA B20        TRY AGAIN
       REM
       BCD 1WTBA 1    TEST WRITING WITH TGR 1 ON
       REM
B23    ETTA
       REWA 1
       WTBA 1
       RCHA K2A2      WR 2-ONE WORD RECORDS
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA B23
       TRA *+2
       REM
       BCD 1RTBA 1    TEST READING WITH TGR 2 ON
       REM
B24    BSRA 1
       BSRA 1
       LXA K6+6,3     L+2
       RTBA 1
       REM
       RCHA K2A4
       REM
       TSX RDNCK,4    CHECK RDN TAPE IND
       TRA B24
       REM
B25    CLA K20A4      WORD WRITTEN
       LDQ K21        WORD READ
       CAS K21        WORD READ
       TRA *+2        ERROR
       TRA *+3
       TSX ERROR-2,4
       NOP B24        DO NOT REPEAT
       TIX *+1,1,1    DECREMENT WORD NO
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
B26    CLA K20A5      WORD WRITTEN
       LDQ K21A       WORD READ
       CAS K21A
       TRA *+2        ERROR
       TRA *+2        OK
       REM
       TSX ERROR-4,4
       TSX OK,4
       TRA B24
       REM
       BCD 1WTBA 1    TEST WRITING WITH TGR 2 ON
       REM
B27    ETTA           CHECK END OF TAPE TEST
       REWA 1
       REM            FOR CHANNEL 1
       WTBA 1         DSC A
       RCHA K2A5
       TSX RDNCK,4    CHECK RDN TAPE IND
       TRA B27
       TRA *+2
       REM
       BCD 1RTBA 1    TEST READING WITH TGR 2 ON
       REM
B29    BSRA 1
       LXA K6+6,3     L+2
       RTBA 1
       STZ K21+1
       STZ K21A+1
       RCHA K2A6
       SCHA K25       SAVE CONTENTS CHANNEL A
       REM
       TSX RDNCK,4    CHECK RDN TAPE IND
       TRA B29
       TRA B30        CONTINUE
       REM
       BCD 1SCHA      TEST CONTENT DSCU REGISTERS
       REM
B30    CLA K23+2      K21 IN ADDR-K2A6+3 IN DECR
       LDQ K25        RESULTS SCHA OPERATION
       CAS K25
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       TXL B30
       REM
B31    CLA K20A6      REC WRITTEN
       LDQ K21        RECORD READ
       CAS K21
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       NOP B29
       TIX *+1,2,1    DECREMENT REC NO
       TIX *+1,1,1    DECREMENT WDNO
       REM
B32    CLA K20A6+1    REC WRITTEN
       LDQ K21A       RECORD READ
       CAS K21A       RECORD READ
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       TRA B29        TRY AGAIN
       REM
B32A   CLA K21+1      CHECK IF THESE TWO
       ADD K21A+1     POSITIONS CONTAIN ZERO
       TZE *+2
       TSX ERROR,4
       TSX OK,4
       TRA B27        ERROR IN WRITING  REPEAT
       NOP
       REM
       REM
*    TEST  TAPE CHANNEL B
       REM
*          TEST CHANNEL B - UNIT ON
       REM
       REM            DATA TRANSMISSION
       REM            INSTRUCTIONS
       CLA B1
       CAS FIX1       WHAT CHANNEL
       REM
       TRA D3         CH F
       TRA D2         CH D
       TRA D1         CH B
D1     CLA SAVE1
       ARS 9
       LBT
       TRA PRA        PRINT A ONLY
       TRA E1-3
D2     CLA SAVE2
       ARS 9
       LBT
       TRA PRC        PRINT C ONLY
       TRA E1-3
D3     CLA SAVE3
       ARS 9
       LBT
       TRA PRE        PRINT E ONLY
       TRA E1-3
       REM
       BCD 1TEFB      TEST TRANSFER ON DSU B
       REM            END OF FILE
       REM
       TRA *+2
       WTBB 1         DUMMY SELECT
       TEFB *+1
E1     TEFB *+2       EOF INDICATOR SHOULD BE
       REM            OFF
       TRA *+5        OK
       TSX ERROR-1,4
       TXL E1,4,0
       TRA E3         CONTINUE
       REM
       BCD 1WTBB      TEST WRITE SELECT
       REM
E3     ETTB
       REWB 1         PREPARE TO WRITE 1 WORD
       WTBB 1
       RCHB K1
       TCNB *+2       DSC B NOT IN OPN
       TRA *-1
       REM
       STZ K25        SET STORAGE TO ZEROS
       SCHB K25       STORE CHANNEL B
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E3
       TRA *+2        CONTINUE
       REM
       BCD 1TC0B      TEST TCOB,
       REM            DSU B IN OPERATION
       REM
E4     TCOB *+2
       TRA E5         OK
       TSX ERROR-1,4
       TXL E4         REPEAT
       TRA E5         CONTINUE
       REM
       BCD 1SCHB      TEST SCHB-STO. CHAN. B
E5     CLA K23        LOC REG, ADDR REG
       LDQ K25        LOC REG, ADDR
       CAS K25        CHANNEL CONTENTS
       TRA *+2        ERROR
       TRA E6         OK
       REM            IF INCORRECT INFORMATION
       REM            IS IN CHANNEL B THE ERROR
       REM            OCCURED AT E3-TEST WRS
       TSX ERROR-1,4
       NOP E5
       TRA E6         CONTINUE
       REM
       BCD 1TCNB      TEST CHANNEL TRANS ON
       REM            DSU B NOT IN OPERATION
       REM
E6     TCNB *+3
       TSX ERROR-1,4
       TXL E6,4,0     DO NOT REPEAT
       TSX OK,4
       TRA E3         REPEAT
       REM
       BCD 1RTBB      TEST READ SELECT
       REM
E7     LXA K6+2,3     L+1
       CLA K6+6       L+2
       STO WDNO       SET WORD NO CONSTANT
       STO RECNO      SET REC NO CONSTANT
       BSRB 1         BACKSPACE TEST
       STZ K21+1
       RTBB 1         READ RECORD
       RCHB K1A1      TGRS S AND 1 ON
       TCOB *
       SCHB K25       TEMPORARY STORAGE
       REM
       REM
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E7
       REM
E8     CLA K20        WORD WRITTEN
       LDQ K21        WORD READ
       CAS K21        WORD READ
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       TRA E7
       REM
E8A    NZT K21+1
       TRA *+3
       TSX ERROR-1,4
       TRA E3         WROTE MORE THAN ONE WORD
       REM            REPEAT COMPLETE TEST
       TRA E9         CONTINUE
       REM
       BCD 1SCHB      TEST STATUS CHANNEL B
       REM
       REM
E9     CLA K23A
       LDQ K25        CHAN CONTENTS
       CAS K25
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP E9
       TSX OK,4
       TRA E7         REPEAT
       REM
       BCD 1WTBB 1    TEST WRITING 2-1 WORD REC
       REM
E10    ETTB           END OF TAPE TEST
       REWB 1
       WTBB 1
       RCHB K1A2
       WEFB 17
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E10
       TRA E11
       REM
       BCD 1RTBB 1    TEST READING 2 ONE WORD REC
       REM
E11    BSRB 1         BACKSPACE
       BSRB 1         OVER EOF + TWO RECS
       BSRB 1
       LXA K6+6,3     L+2
       CLA K6+5       L+3
       STO WDNO
       STO RECNO      RESET REC NUMBER
       STZ K21+1
       STZ K21A+1
       RTBB 1
       RCHB K1A9      READ TWO 1-WORD REC + EOF
       REM            S AND 1 TGRS ON
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E11
       REM
E12    CLA K20A       WORD WRITTEN
       LDQ K21        WORD READ
       CAS K21        WORD READ
       TRA *+2        ERROR
       TRA *+3
       TSX ERROR-2,4
       NOP E11        DO NOT REPEAT
       TIX *+1,1,1    DECREMENT WORD NO
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
E13    CLA K20A1      WORD WRITTEN
       LDQ K21A       WORD READ
       CAS K21A
       TRA *+2        ERROR
       TRA *+5        OK
       TSX ERROR-2,4
       TRA E11
       TRA *+2        CONTINUE
       BCD 1TEFB
       REM
       TEFB *+3       IS IND ON-YES/OK
       TSX ERROR-1,4  NO-ERROR
       TXL *-2        REPEAT
       TEFB *+2       IS IND ON-YES-ERROR
       TRA *+3        NO-OK
       TSX ERROR-1,4
       TXL *-6,4,0    CONTINUE
       TRCB *+1       TURN OFF RDN IND
       REM
E13A   CLA K21+1      CHECK IF THESE TWO
       ADD K21A+1     POSITIONS CONTAIN ZEROS
       TZE *+2
       TSX ERROR,4
       TSX OK,4
       TRA E10        ERROR IN WRITTING TWO
       REM            ONE WORD RECORDS REPEAT
       REM            COMPLETE TEST
       REM
       BCD 1IOT       I/O CHECK TEST
       REM
E14    LCHB K1        TURN ON I/O CHECK IND
       IOT            I/O CHECK TEST
       TRA *+3        I/O UNIT ON-OK
       TSX ERROR-1,4
       TXL E14
       REM
E15    IOT            I/O CHECK TEST
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       TXL E15
       TSX OK,4
       TRA E14        REPEAT
       REM
       BCD 1WTBB 1    TEST OPN, OF TGRS 1 AND 2
       REM            WHEN WRITING
       REM            THE FOURTH RECORD
       REM
E16    ETTB           CHECK END OF TAPE TEST
       REWB 1
       WTBB 1
       RCHB K1A6
       STZ K25        STORE ZEROS IN K25
       SCHB K25       CHECK STATUS OF TGRS
       LCHB K1A7
       TRA *+2        CONTINUE
       REM
       BCD 1IOT       TEST I/O CK TGR+IND
       REM
       IOT
       TRA *+2        ERROR-CHANNEL B WAS
       REM            NOT SELECTED
       TRA *+3
       REM
E16A   TSX ERROR-1,4
       TXL *-4        REPEAT
       TRA E16B       CONTINUE
       REM
       BCD 1SCHB      TEST SCHB-STO. CHAN. B
       REM
E16B   CAL K25
       PBT            WAS S TGR ON
       TRA *+2        ERROR
       TRA E17        NO-OK
       TSX ERROR-1,4
       NOP E16B
       REM
E17    ALS 1
       PBT            WAS TGR 1 ON
       TRA *+3        OK
       TSX ERROR-1,4
       NOP E16B
       REM
E18    ALS 1
       PBT            WAS TGR 2 ON
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP E16B
       REM
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E16
       TRA *+2        CONTINUE
       REM
       BCD 1RTBB 1    TEST IF 4TH RECORD WAS
       REM            WRITTEN CORRECTLY
       REM
E20    BSRB 1         BACKSPACE DSC B UNIT
       LXA K6+6,3     L+2
       RTBB 1
       STZ K21+1
       STZ K21A+1
       RCHB K2        TGRS S AND 2 ON
       LCHB K1A8      TGRS S,1, AND 2 OFF
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E20
       REM
E21    CLA K20A       WORD WRITTEN
       LDQ K21        WORD READ
       CAS K21
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       NOP E20        DO NOT REPEAT
       TIX *+1,1,1    DECREMENT WORD NO
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
E22    CLA K20A3      WORD WRITTEN
       LDQ K21A       WORD READ
       REM
       CAS K21A       WORD READ
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       TRA E20
       REM
E22A   CLA K21+1
       ADD K21A+1
       TZE *+2        OK
       TSX ERROR,4
       TSX OK,4
       TRA E20        TRY AGAIN
       REM
       BCD 1WTBB 1    TEST WRITING WITH TGR 1 ON
       REM
E23    ETTB           CHECK END OF TAPE TEST
       REWB 1
       WTBB 1
       RCHB K2A2      WRITE TWO-1 WORD REC
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E23
       TRA *+2
       REM
       BCD 1RTBB 1    TEST READING WITH TGR 2 ON
       REM
E24    BSRB 1
       BSRB 1
       LXA K6+6,3     L+2
       RTBB 1
       RCHB K2A4
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E24
       REM
E25    CLA K20A4      WORD WRITTEN
       LDQ K21        WORD READ
       CAS K21
       TRA *+2        ERROR
       TRA *+3
       TSX ERROR-2,4
       NOP E24
       TIX *+1,1,1    DECREMENT WORD NO
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
E26    CLA K20A5      WORD WRITTEN
       LDQ K21A       WORD READ
       CAS K21A
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR-4,4
       TSX OK,4
       TRA E24
       BCD 1WTBB 1    TEST WRITING WITH TGR 2 ON
       REM
E27    ETTB           CHECK END OF TAPE TEST
       REWB 1
       WTBB 1
       RCHB K2A5
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E27
       TRA *+2
       REM
       BCD 1RTBB 1    TEST READING WITH TGR 2 ON
       REM
E29    BSRB 1
       LXA K6+6,3     L+2
       RTBB 1
       STZ K21+1
       STZ K21A+1
       RCHB K2A6
       SCHB K25       CHECK CONTS. DTUC REGISTERS
       REM
       TSX RDNCK,4    CHECK TAPE RDN IND
       TRA E29        REPEAT SECTION
       TRA E30
       REM
       BCD 1SCHB      TEST SCHB INSTRUCTION
       REM
E30    CLA K23+2      K21 IN ADDR,K2A6+3 IN DECR
       LDQ K25
       CAS K25        CHANNEL CONTENTS
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4
       NOP E30
       REM
E31    CLA K20A6      REC WRITTEN
       LDQ K21        REC READ
       CAS K21
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       NOP E29
       TIX *+1,2,1    DECREMENT REC NO
       TIX *+1,1,1    DECREMENT WDNO
       REM
E32    CLA K20A6+1    REC WRITTEN
       LDQ K21A       REC READ
       CAS K21A
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4
       TRA E29        TRY AGAIN
       REM
E32A   CLA K21+1      CHECK IF THESE TWO
       ADD K21A+1     POSITIONS CONTAIN ZEROS
       TZE *+2
       TSX ERROR,4
       TSX OK,4
       TRA E27        ERROR IN WRITING REPEAT
       REM            THE COMPLETE TEST
       NOP
       REM
*      MULTI CHANNEL OPERATION
       REM
       REM
       REM
       REM
       REM
       REM
       CLA B1         WHICH CHAN ARE
       CAS FIX1       BEING TESTED SEC3
       TRA Q3         CHECK CTRL3 EF
       TRA Q2         CHECK CTRL2 CD
       TRA Q1         CHECK CTRL1 AB
Q1     CLA SAVE1
       ARS 3
       LBT
       TRA PRB        PRINT B ONLY
       TRA F1
Q2     CLA SAVE2
       ARS 3
       LBT
       TRA PRD        PRINT D ONLY
       TRA F1
Q3     CLA SAVE3
       ARS 3
       LBT
       TRA PRF        PRINT F ONLY
       TRA F1
TESAB  BCD 1WTBB      TEST CHANNEL A AND B
       REM            FOR WRITING
       REM
F1     TRA *+2
       WTBA 1         DUMMY SELECT
       ETTA           CHECK END OF TAPE TEST
       REWA 1         UNIT ON CHANNEL A
       TRA TESBA
SEP1   WTBA 1
       TRCA *+1       TURN OFF RDN CHECK IND
       RCHA K3        WRITE FIVE-5 WORD REC
       TRA SEP2
       BCD 1TCOA      TEST TRANS CHAN IN OPER
SEP3   TRA *+2
       WTBA 1         DUMMY SELECT
       REM
       TCOA *+3       IS DSC A IN OPERATION
       TSX ERROR-1,4   NO-ERROR
       TXL *-2        REPEAT
       REM
F2     TSX RDNCK,4    CHECK TAPE RDN IND
       TRA F1
       TRA F3         GO TO CH B
       REM
       BCD 1RTBA      TEST CHANNELS A AND B
       REM            FOR READING
       REM
F5     CLA K6+1       L+5
       ADD K6+2       L+1
       STA WDNO       WORD NUMBER
       STA RECNO      RECORD NUMBER
       REM
       LXA K6+1,3     L +5
IT     BSRA 1         BACKSPACE DSU A AND B
       TRA SEP5
SEP6   RTBA 1
       TRCA *+1       TURN OFF RDN CHECK
       RCHA K4
       TRA SEP7
       REM
       BCD 1TCOA      TEST TRANS CHAN IN OPER
SEP8   TRA *+2
       WTBA 1         DUMMY SELECT
       REM
       REM
       TCOA *+3       IS DSC A IN OPERATION
       TSX ERROR-1,4   NO-ERROR
       TXL *-2        REPEAT
       REM
F6     TSX RDNCK,4    CHECK TAPE RDN IND
       TRA F5
       TRA F7
       BCD 1TCOA      TEST TRANS CHAN IN OPER
F10    TRA *+2
       WTBA 1         DUMMY SELECT
       TCOA *+2       IS DSC A IN OPERATION
       TRA F11        NO-OK
       TSX ERROR-1,4
       TXL F10
       REM
F11    TSX RDNCK,4    CHECK TAPE RDN IND
       TRA F5
       TRA F12        CONTINUE
       REM
       REM
TESBA  TRA *+2
       WTBB 1         DUMMY SELECT
       ETTB           DSC B
       REWB 1
       TRA SEP1
SEP2   WTBB 1
       TRCB *+1       TURN OFF RDN CHECK IND
       RCHB K3        WRITE FIVE 5-WORD REC
       TRA SEP3
       BCD 1TCOB      TEST TRANS CHAN IN OPER
       REM
F3     TRA *+2
       WTBB 1         DUMMY SELECT
       TCOB *+2       IS DSC B IN OPERATION
       TRA *+3
       TSX ERROR-1,4
       TXL F3,4,0
       TSX OK,4
       TRA F1         REPEAT
       REM
       NOP
       TRA F5
SEP5   TRA *+2
       WTBB 1         DUMMY SELECT
       BSRB 1
       TIX IT,1,1
       TRA SEP6
       REM
SEP7   RTBB 1
       TRCB *+1       TURN OFF RDN CHECK
       RCHB K4A
       TRA SEP8
       BCD 1TCOB      TEST TRANS CHAN IN OPER
F7     TRA *+2
       WTBB 1         DUMMY SELECT
       TCOB *+2
       TRA *+3        NO-OK
       TSX ERROR-1,4
       TXL F7
       REM
F8     TSX RDNCK,4    CHECK TAPE RDN IND
       TRA F5
       REM
F9     LXA K6+1,1     L +5
       LDQ C1+5,1     WORD WRITTEN
       CLA K21+5,1    WORD READ
       CAS C1+5,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN 1ST RECORD DSU A
       NOP F5
       TIX F9+1,1,1
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
F9A    LXA K6+1,1     L +5
       LDQ C1+10,1    WORD WRITTEN
       CLA K21A+5,1   WORD READ
       CAS C1+10,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN 2ND RECORD DSU A
       NOP F5
       TIX F9A+1,1,1
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
F9B    LXA K6+1,1     L +5
       LDQ C2+5,1     WORD WRITTEN
       CLA K21B+5,1    WORD READ
       CAS C2+5,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN 3RD RECORD DSU A
       NOP F5
       TIX F9B+1,1,1
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
F9C    LXA K6+1,1     L +5
       LDQ C2+10,1    WORD WRITTEN
       CLA K21C+5,1   WORD READ
       CAS C2+10,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN 4TH RECORD DSU A
       NOP F5
       TIX F9C+1,1,1
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
F9D    LXA K6+1,1     L +5
       LDQ C3+5,1     WORD WRITTEN
       CLA K21D+5,1   WORD READ
       CAS C3+5,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN 5TH RECORD DSU A
       TRA F5
       TIX F9D+1,1,1
       TRA F9E        CONTINUE
       REM
       REM
       BCD 1RTBB 1
       REM
F9E    LXA K6+1,3     L +5
       LDQ C1+5,1     WORD WRITTEN
       CLA K22+5,1    WORD READ
       CAS C1+5,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN 1ST RECORD DSU B
       NOP F9E
       TIX F9E+1,1,1
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
F9F    LXA K6+1,1     L +5
       LDQ C1+10,1    WORD WRITTEN
       CLA K22A+5,1   WORD READ
       CAS C1+10,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN 2ND RECORD DSU B
       NOP F9E
       TIX F9F+1,1,1
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
F9G    LXA K6+1,1     L +5
       LDQ C2+5,1     WORD WRITTEN
       CLA K22B+5,1   WORD READ
       CAS C2+5,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN 3RD RECORD DSU B
       NOP F9E
       TIX F9G+1,1,1
       TIX *+1,2,1    DECREMENT REC. NO.
       REM
F9H    LXA K6+1,1     L +5
       LDQ C2+10,1    WORD WRITTEN
       CLA K22C+5,1   WORD READ
       CAS C2+10,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN FORTH RECORD DSU B
       NOP F9E
       TIX F9H+1,1,1
       REM
F9J    LXA K6+1,1     L +5
       LDQ C3+5,1     WORD WRITTEN
       CLA K22D+5,1   WORD READ
       CAS C3+5,1
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR IN 5TH RECORD DSU B
       TRA F9E
       TIX F9J+1,1,1
       TRA F10        CONTINUE
       REM
       BCD 1TCOB      TEST TRANS CHAN IN OPER
       REM
F12    TRA *+2
       WTBB 1         DUMMY SELECT
       TCOB *+2       IN DSCB IN OPERATION
       TRA *+3        NO-OK
       TSX ERROR-1,4
       TXL F12
       TSX OK,4
       TRA F5         REPEAT READ MULTICHANNEL
       NOP
       CLA B1
       CAS FIX1
       TRA PREF       PRINT E AND F
       TRA PRCD       PRINT C AND D
       TRA PRAB       PRINT A AND B
       REM
       REM
       REM
       REM
       REM
MOD    AXT 2,1
       TSX CTX,4
       HTR B1-4,0,B32A+6
       TSX CTX,4
       HTR E1-2,0,E32A+6
       TSX CTX,4
       HTR TESAB,0,F11
       TSX CTX,4
       HTR TESBA,0,F12+2
       TIX *-8,1,1
       TRA STA
       REM
F19    SWT 3
       TRA PRAUC
       TRA MOD
       REM
*      PRINT ALL UNITS CALLED
PRAUC  WPRA
       SPRA 3
       RCHA CTALL
       SWT 5          TEST SW 5
       TRA *+2
       TRA MOD        REPEAT SAME SEQUENCE
       SWT 6          TEST SW, 6
       TRA PROG       TO NEXT PROG
       TRA INIT
CTALL  IOCD AUC,0,24
       REM
PROG   RCDA
       RCHA K56
       LCHA 0
       TRA 1
       REM
       REM
       REM
       REM PRINT CH A
PRA    SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS PRINT
       WPRA
       SPRA 3
       RCHA CTA
       TRA MOD
       REM
       HTR 0
       REM
       REM PRINT CH B
PRB    SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS PRINT
       WPRA
       WPRA
       RCHA CTB
       SPRA 3
       TRA MOD
       REM
       HTR 0
       REM
       REM PRINT CH C
PRC    SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS PRINT
       WPRA
       SPRA 3
       RCHA CTC
       TRA MOD
       REM
       HTR 0
       REM
       REM PRINT CH D
PRD    SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS PRINT
       WPRA
       SPRA 3
       RCHA CTD
       TRA MOD
       REM
       HTR 0
       REM
       REM PRINT CH E
PRE    SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS PRINT
       WPRA
       SPRA 3
       RCHA CTE
       TRA F19
       REM
       HTR 0
       REM
       REM PRINT CH F
PRF    SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS PRINT
       WPRA
       SPRA 3
       RCHA CTF
       TRA F19
       HTR 0
CTCD   IOCD PTCD,0,24
CTEF   IOCD PTEF,0,24
CTA    IOCD PTA,0,24
CTB    IOCD PTB,0,24
CTC    IOCD PTC,0,24
CTD    IOCD PTD,0,24
CTE    IOCD PTE,0,24
CTF    IOCD PTF,0,24
CTAB   IOCD PTAB,0,24
       REM
       REM
       REM PRINT CH AB
PRAB   SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS SWITCH
       WPRA
       SPRA 3
       RCHA CTAB
       TRA MOD
       REM
       HTR 0
       REM PRINT CH CD
PRCD   SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS PRINT
       WPRA
       SPRA 3
       RCHA CTCD
       TRA MOD
       REM
       HTR 0
       REM PRINT CH EF
PREF   SWT 3          TEST SENSE SWITCH 3
       TRA *+2
       TRA *+4        BYPASS PRINT
       WPRA
       SPRA 3
       RCHA CTEF
       TRA F19
       HTR 0
C1     OCT 111111111111
       OCT 222222222222
       OCT 333333333333
       OCT -444444444444
       OCT -555555555555
       OCT -666666666666
       OCT 121212121212
       OCT 343434343434
       OCT 321670123457
       OCT 012345123456
C2     OCT -71543075423
       OCT 337733773377
       OCT 236546234534
       OCT 775511334454
       OCT 113321123575
       OCT -45723454776
       OCT 345611123455
       OCT -34672167121
       OCT 305020407060
       OCT -43210432104
C3     OCT -71717171717
       OCT 547065423042
       OCT 345670544432
       OCT -47474745546
       OCT -54467024562
       REM            READ AREA
K1     PZE K20,0,1    WR CTR WD FIRST RECORD
       PZE K1+2
       PZE K100
K1A1   MTW K21,0,1    RD CTL WORD 1ST RECORD
       PZE K1A1+2
       PZE K101
K1A2   PTW K20A,0,1   WR CTR WD SECOND RECORD
       PZE K20A1,0,1  WR CTR WD THIRD RECORD
       PZE K1A2+3
       PZE K100
K1A4   MTW K21,0,1    RD CTR WD SECOND RECORD
       PZE K21A,0,1   RD CTR WORD THIRD RECORD
       PZE
K1A6   MON K20A,0,1   WR CTR WD FOURTH RECORD
       PZE K1A6+2
       PZE K100
K1A7   PZE K20A3,0,1  WR CTR WD FOURTH RECORD
       PZE K1A7+2
       PZE K100
K1A8   PON K2A,0,2    RD CTR WD FOURTH RECORD
       PZE K101
K1A9   MTW K21,0,1
       PZE K21A,0,2
K2     MON K21,0,1    RD CTR WD FOURTH RECORD
       PZE K21+1,0,1
       PZE K101
K2A    PZE K21A,0,1   RD CTR WD FOURTH RECORD
       PZE K2A+2
       PZE K101
K2A2   PTW K20A4,0,1  WR CTR WD FIFTH RECORD
       PZE K20A5,0,1
       PZE 100
K2A4   PON K2A6+2
       PZE K21,0,1
       PZE K21A,0,1
       PON K2A4+5,0,2
       PZE K21+1,0,1
       PZE K22A
K2A5   PON K2A5+2,0,3
       PON K2A5+4
       PZE K20A6,0,2
K2A6   PON K2A6+2     TGR 2 ON
       PZE K21+1      NO TGRS ON
       MZE K21,0,1    S TGR ON
       MZE K21A,0,1   S TGR ON
       PON K2A6+1,0,8 TGR 2 ON
*WRITE 5-5 WORD RECORDS
K3     PTW C1,0,5     1 TGR ON WRITE EOR
       PTW C1+5,0,5    INDICATION AND BRING
       PTW C2,0,5      IN NEW CONTROL WORD
       PTW C2+5,0,5
       PZE C3,0,5     WR EOR AND DISCONNECT
       REM            UNIT
       REM
*                     READ CTRL FROM CHAN A
K4     PTW K21,0,10   ON EOR BRING IN CONTROL
       REM            WORD FROM LOC IN LR
       PTW K21A,0,5
       PTW K21B,0,5
       MTW K21C,0,10
       PZE K21D,0,5
       REM
       REM            READ CTRL FOR CHAN B
K4A    PTW K22,0,10
       PTW K22A,0,5
       PTW K22B,0,5
       MTW K22C,0,10
       PZE K22D,0,5
       REM
K20    OCT 452525252525 REC WRITTEN +1
       OCT 777777777777
K20A   OCT 370241567401 REC WRITTEN +2
       OCT 77777777777
K20A1  OCT 457632134556 REC WRITTEN +3
       OCT 7777777777
K20A2  OCT 246754321007 REC WRITTEN +4
       OCT 777777777
K20A3  OCT 546210735747 REC WRITTEN +4
       OCT 77777777
K20A4  OCT 022431776053
       OCT 7777777
K20A5  OCT 142367452310
       OCT 777777
K20A6  OCT 754321754632
       OCT 77777
       OCT 611744332016
       OCT 7777
       REM            READING AREA
K21    OCT 0,0,0,0,0,0
K21A   OCT 0,0,0,0,0,0
K21B   OCT 0,0,0,0,0,0
K21C   OCT 0,0,0,0,0,0
K21D   OCT 0,0,0,0,0,0
K22    OCT 0,0,0,0,0,0
K22A   OCT 0,0,0,0,0,0
K22B   OCT 0,0,0,0,0,0
K22C   OCT 0,0,0,0,0,0
K22D   OCT 0,0,0,0,0,0
K23    HTR K20+1,0,K1+1 TGRS, LR AR
       OCT 0
       MZE K21,0,K2A6+3
K23A   PZE K1A1+2,0,K1A1+2
K25    OCT +0         STORE CHANNEL CONTENTS
K55    OCT
K56    MON 0,0,3
K100   OCT
K101   OCT
K6     OCT 144000030
       OCT 1000005
       OCT 1
       TRA 24
       OCT 11
       OCT 3
       OCT 2
       REM
*PRINT - NOW PERFORMING DIAGNOSTIC TEST 9T02
PRID   SWT 3          TEST SENSE SWITCH 3
       TRA *+2        PRINT TEST IDENTITY
       TRA *+5        BYPASS PRINT
IDN    WPRA 1         PRINT OUT TEST IDENTITY
       SPRA 3         DOUBLE SPACE
       RCHA CTIDN
       WPRA 1         SPACE
       TRA 1,4        RETURN TO MAIN PROGRAM
       REM
       HTR 0          PROGRAM PROTECT - I-O DISC
       REM
       REM
CTIDN  IOCD PRIDN,0,24
       REM
       REM
*      PRINT FIELDS
*IMAGE - NOW PREFORMING DIAGNOSTIC TEST 9T02
       REM
PRIDN  OCT +002241004010  9 ROW LEFT
       OCT +0              9 ROW RIGHT
       OCT +000000000000  8 L
       OCT +0
       OCT +010010200000  7 L
       OCT +0
       OCT +141400040000  6 L
       OCT +0
       OCT +204020100200  5 L
       OCT +0
       OCT +000102000000  4 L
       OCT +0
       OCT 0000000012444  3 L
       OCT +0
       OCT +000000020101  2 L
       OCT +0
       OCT +000004000009  1 L
       OCT +0
       OCT +040000030546  0 L
       OCT +0
       OCT +312720140000  11 L
       OCT +0
       OCT +005053606200  12 L
       OCT +0
       REM
* IMAGE --
*PASS COMPLETE - CHN A  TF 1
PTA    OCT 000000000000 9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000001000000  8 L
       OCT 000000000000  8 R
       OCT 401000000000  7 L
       OCT 000000000000  7 R
       OCT 004000004000  6 L
       OCT 000000000000  6 R
       OCT 000240400000  5 L
       OCT 000000000000  5 R
       OCT 002000000000  4 L
       OCT 000000000000  4 R
       OCT 010502010000  3 L
       OCT 000000000000  3 R
       OCT 140000000000  2 L
       OCT 000000000000  2 R
       OCT 200000101000  1 L
       OCT 000000000000  1 R
       OCT 140100010000  0 L
       OCT 000000000000  0 R
       OCT 407410400000  11 L
       OCT 000000000000  11 R
       OCT 210243104000  12 L
       OCT 000000000000  12 R
*  IMAGE --
*PASS COMPLETE - CHN B  TF 1
       REM PAGE
PTB    OCT 000000000000 9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000001000000  8 L
       OCT 000000000000  8 R
       OCT 401000000000  7 L
       OCT 000000000000  7 R
       OCT 004000004000  6 L
       OCT 000000000000  6 R
       OCT 000240400000  5 L
       OCT 000000000000  5 R
       OCT 002000000000  4 L
       OCT 000000000000  4 R
       OCT 010502010000  3 L
       OCT 000000000000  3 R
       OCT 140000100000  2 L
       OCT 000000000000  2 R
       OCT 200000001000  1 L
       OCT 000000000000  1 R
       OCT 140100010000  0 L
       OCT 000000000000  0 R
       OCT 407410400000  11 L
       OCT 000000000000  11 R
       OCT 210243104000  12 L
       OCT 000000000000  12 R
*  IMAGE --
*PASS COMPLETE - CHN C TF 1
PTC    OCT 000000000000 9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000001000000  8 L
       OCT 000000000000  8 R
       OCT 401000000000  7 L
       OCT 000000000000  7 R
       OCT 004000004000  6 L
       OCT 000000000000  6 R
       OCT 000240400000  5 L
       OCT 000000000000  5 R
       OCT 002000000000  4 L
       OCT 000000000000  4 R
       OCT 010502110000  3 L
       OCT 000000000000  3 R
       OCT 140000000000  2 L
       OCT 000000000000  2 R
       OCT 200000001000  1 L
       OCT 000000000000  1 R
       OCT 140100010000  0 L
       OCT 000000000000  0 R
       OCT 407410400000  11 L
       OCT 000000000000  11 R
       OCT 210243104000  12 L
       OCT 000000000000  12 R
*  IMAGE --
*PASS COMPLETE - CHN D  TF 1
PTD    OCT 000000000000 9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000001000000  8 L
       OCT 000000000000  8 R
       OCT 401000000000  7 L
       OCT 000000000000  7 R
       OCT 004000004000  6 L
       OCT 000000000000  6 R
       OCT 000240400000  5 L
       OCT 000000000000  5 R
       OCT 002000100000  4 L
       OCT 000000000000  4 R
       OCT 010502010000  3 L
       OCT 000000000000  3 R
       OCT 140000000000  2 L
       OCT 000000000000  2 R
       OCT 200000001000  1 L
       OCT 000000000000  1 R
       OCT 140100010000  0 L
       OCT 000000000000  0 R
       OCT 407410400000  11 L
       OCT 000000000000  11 R
       OCT 210243104000  12 L
       OCT 000000000000  12 R
*  IMAGE --
*PASS COMPLETE - CHN E  TF 1
PTE    OCT 000000000000 9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000001000000  8 L
       OCT 000000000000  8 R
       OCT 401000000000  7 L
       OCT 000000000000  7 R
       OCT 004000004000  6 L
       OCT 000000000000  6 R
       OCT 000240500000  5 L
       OCT 000000000000  5 R
       OCT 002000000000  4 L
       OCT 000000000000  4 R
       OCT 010502010000  3 L
       OCT 000000000000  3 R
       OCT 140000000000  2 L
       OCT 000000000000  2 R
       OCT 200000001000  1 L
       OCT 000000000000  1 R
       OCT 140100010000  0 L
       OCT 000000000000  0 R
       OCT 407410400000  11 L
       OCT 000000000000  11 R
       OCT 210243104000  12 L
       OCT 000000000000  12 R
*  IMAGE --
*PASS COMPLETE - CHN F  TF 1
PTF    OCT 000000000000 9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000001000000  8 L
       OCT 000000000000  8 R
       OCT 401000000000  7 L
       OCT 000000000000  7 R
       OCT 004000104000  6 L
       OCT 000000000000  6 R
       OCT 000240400000  5 L
       OCT 000000000000  5 R
       OCT 002000000000  4 L
       OCT 000000000000  4 R
       OCT 010502010000  3 L
       OCT 000000000000  3 R
       OCT 140000000000  2 L
       OCT 000000000000  2 R
       OCT 200000001000  1 L
       OCT 000000000000  1 R
       OCT 140100010000  0 L
       OCT 000000000000  0 R
       OCT 407410400000  11 L
       OCT 000000000000  11 R
       OCT 210243104000  12 L
       OCT 000000000000  12 R
*IMAGE - PASS COMPLETE CHANNELS A AND B
PTAB   OCT +000000000000 9 ROW LEFT
       OCT +0            9 ROW RIGHT
       OCT +000004000000 8L
       OCT +0
       OCT -001000000000 7L
       OCT +0
       OCT +004000000000 6L
       OCT +0
       OCT +000241601000 5L
       OCT +0
       OCT +002000000400 4L
       OCT +0
       OCT +010510100000 3L
       OCT +0
       OCT +140000040100 2L
       OCT +0
       OCT +200002012000 1L
       OCT +0
       OCT +140100040000 0L
       OCT +0
       OCT -007401501000 11L
       OCT +0
       OCT +210256212500 12L
       OCT +0
*IMAGE - PASS COMPLETE CHANNELS C AND D
PTCD   OCT +000000000000 9 ROW LEFT
       OCT +0            9 ROW RIGHT
       OCT +000004000000 8L
       OCT +0
       OCT -001000000000 7L
       OCT +0
       OCT +004000000000 6L
       OCT +0
       OCT +000241601000 5L
       OCT +0
       OCT +002000000500 4L
       OCT +0
       OCT +010510110000 3L
       OCT +0
       OCT +140000040000 2L
       OCT +0
       OCT +200002002000 1L
       OCT +0
       OCT +140100040000 0L
       OCT +0
       OCT -007401501000 11L
       OCT +0
       OCT +210256212500 12L
       OCT +0
*IMAGE - PASS COMPLETE CHANNELS E AND F
PTEF   OCT +000000000000 9 ROW LEFT
       OCT +0            9 ROW RIGHT
       OCT +000004000000 8L
       OCT +0
       OCT -001000000000 7L
       OCT +0
       OCT +004000000100 6L
       OCT +0
       OCT +000241611000 5L
       OCT +0
       OCT +002000000400 4L
       OCT +0
       OCT +010510100000 3L
       OCT +0
       OCT +140000040000 2L
       OCT +0
       OCT +200002002000 1L
       OCT +0
       OCT +140100040000 0L
       OCT +0
       OCT -007401501000 11L
       OCT +0
       OCT +210256212500 12L
       OCT +0
*9T02  PASS COMPLETE - ALL UNITS CALLED
*  IMAGE --
*  PRINT --
*9T02  PASS COMPLETE - ALL UNITS CALLED
AUC    OCT 400000000100  9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 000000000000  8 L
       OCT 000000000000  8 R
       OCT 002004000000  7 L
       OCT 000000000000  7 R
       OCT 000020000000  6 L
       OCT 000000000000  6 R
       OCT 000001200200  5 L
       OCT 200000000000  5 R
       OCT 000010000400  4 L
       OCT 100000000000  4 R
       OCT 200042406045  3 L
       OCT 400000000000  3 R
       OCT 040600000020  2 L
       OCT 000000000000  2 R
       OCT 001000010002  1 L
       OCT 000000000000  1 R
       OCT 300600400460  0 L
       OCT 000000000000  0 R
       OCT 002036046201  11 L
       OCT 400000000000  11 R
       OCT 001041210106  12 L
       OCT 300000000000  12 R
       REM
MIANB  OCT 000000743450 EXCL TU2
WTBB1  WTBB 1
ETTB   OCT -076000002000
ETTA   OCT -076000001000
ENF    OCT 000000443430
CND    OCT 000000243430
ANB    OCT -000000743430
CONST  OCT 000100000000
       REM
ERROR  EQU 3396
OK     EQU 3401
RDNCK  EQU 3440
RECNO  EQU 3439
WDNO   EQU 3438
POST   TRA INIT-1
CHKA   OCT 0
       REM
       REM
FIX1   OCT 003100000045
       REM
WTBA2  WTBA 2
WTBA1  WTBA 1
RCDA   RCDA
RTBA   RTBA
FINL1  OCT 0
SAVE1  OCT 0
SAVE2  OCT 0
SAVE3  OCT 0
       ORG 2880
       OCT -0000000743430
       OCT 000000243430
       OCT 000000443430
CTRL1  EQU 2880
CTRL2  EQU 2881
CTRL3  EQU 2882
IOCT   EQU 2883
CTRA   EQU 2884
CTRB   EQU 2885
CTRC   EQU 2886
CTRD   EQU 2887
CTRE   EQU 2888
CTRF   EQU 2889
CTX    EQU 2890
IOCNT  EQU 2891
IOC    EQU 2892
       REM
       END
