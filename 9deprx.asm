              DIAGNOSTIC ERROR PRINT SUB ROUTINE             DEPRX
                                                             3/15/60
       REM
       REM
       REM DEPRX
       REM
       REM
* SENSE SWITCHES INTERROGATION AND DIAGNOSTIC
*              PRINT SUBROUTINE
       REM
       ORG 32000
       REM
       TRA ERROR-4
       HTR PR        ILLEGAL ENTRY.
       TRA ERROR-2
       TRA ERROR-1
       TRA ERROR
       TRA OK
       TRA RDNCK
       REM
WDNO   OCT
RECNO  OCT
       REM
KONST  OCT 1
       OCT 50
       OCT 50        COUNT CONSTANT
       OCT 1
       OCT 1
       TRA OK-1      EXIT FROM PRINT PROG
       TRA OK2       EXIT FROM PRINT WHEN
       REM           ENTRY IS TO ERROR-1
       OCT 1
       REM
CH14   WRS 753       PRINTER
       SPRA 3        DOUBLE SPACE
       TSX WPRA+1,1  PRINT FIRST LINE
       CLA LOC       IS THIS A 1 LINE PR OUT
       TMI CH35-7
       TRA CH18      NO
       REM
WPRA   WPRA
       RCHA CTWD     IOCD PR,0,24
       TCOA *
       TRA 1,1       EXIT
       REM
WPR    WPRA
       SPRA 4        OCT SPACE
       TRA WPRA+1
       REM
       REM
LOC    OCT 0          TEST LOC + ERROR ADDR
       OCT 0          DECREMENT CONTAINS 2,5
       REM            COMP OF LAST ROUTINE
       OCT 0          +0
       OCT 0          TRAP ROUTINE INDICATOR
       OCT -0
       OCT 7
       REM
       STZ KONST+3   INDICATE I/O TYPE PRINT
       REM           OUT
       TRA ERROR
       STZ KONST+3   SET  STORAGE TO ZEROS
       REM           MODIFY INSTRUCTIONS FOR
       REM           RETURN ADDR TO MAIN PROG
       TRA MOD
       REM
ERROR  STZ KONST     DO NOT REPEAT SECTION
       STZ KONST+1   IF SENSE SW 4 IS DOWN
       REM
       SXD STOR+6    SAVE XRC
       AXT KONST+5,4 CORRECT ADDRESS
       SXA RELY-1,4  TO EXIT INSTRUCTION
       LXD STOR+6,4  RESTORE SAVED XRC
       REM
       PSE 114       SSW 2
       TRA SSW3      UP-INDICATE ERRORS
       TIX OK,4,1
       REM
OK     SXD LOC+1,4   2'S COMPL OF PROGRAM
       REM           LOCATION LAST PREFORMED
       REM
       PSE 113       IF SENSE SW 1 IS UP THEN
       TRA RELY      CHECK SS 4
       TRA 1,4       IF DOWN REPEAR SECTION
       REM           OF PROG
       REM
SSW3   PSE 115       IF SENSE SW 3 IS UP
       TRA PRINT     PRINT ON ERROR
       REM           IF SS 3 IS DOWN STOP ON
       SXD STOR+6,4  ERROR
       LDC STOR+6,4
       HTR *-1       TRUE ERROR LOC IS IN XRC
       REM
       LXD STOR+6,4  RESTOER SAVED XRC
       TRA           EXIT INSTRUCTION
       REM
       REM
       REM
RELY   PSE 116       IF SENSE SWITCH 5 IS UP
       TRA 3,4       GO TO NEXT SECTION OF
       REM THE PROGRAM. IF DOWN REPEAT SECTION
       REM OF THE PROGRAM N TIMES OR THE NUMEBR
       REM OF TIMES INSERTED IN LOC KONST+2
       REM
       CLA KONST+1   COUNTER
       SUB KONST     L+1 REDUCE COUNT BY 1
       STO KONST+1
       TNZ OK+3
       CLA KONST+2   L+50 COUNT CONSTANT
       STO KONST+1
       CLA STOR+7    L+1
       STO KONST
       TRA 3,4
       REM
       REM
MOD    SXD STOR+6,4  SAVE XRC
       AXT KONST+6,4 CORRECT ADDRESS
       SXA RELY-1,4  TO EXIT ROUTINE
       LXD STOR+6,4  RESTORE SAVED XRC
       STZ KONST+4   SET STORAGE TO ZEROS
       STZ KONST+1
       STZ KONST
ERR    PSE 114       SSW 2
       TRA SSW3      INDICATES ERRORS
       REM
OK2    PSE 113       SSW1
       TRA 2,4       UP-GO TO NEXT ROUTINE
       TRA 1,4       REPEAT TEST
       REM           PUT DSC REDUNDANCY
       REM           CHECKS IN PRINT RECORD
RDNCK  STO STOR      ACC CONTENTS
       ARS 35
       SLW STOR+6    OVFL BITS P + Q
       STQ STOR+2    MQ CONTENTS
       SXD STOR+4,1  PLACE XRA IN DECR.
       REM
       CAL MASK+9    RESET RECORD IMAGE
       ANS REC4R+9   INDICATIONS
       CAL BIT2+3
       SLW REC4R+8   FOR REDUNDANCY TAPE CK
       SLW KONST+7   PUT A BIT IN WORD
       REM
       TCOA *        CHECK CHAN IN OPERATION
       TCOB *
       TCOC *
       TCOD *
       TCOE *
       TCOF *
       TCOG *
       TCOH *
       REM
*      CHECK CHANNELS A-B-C-D-E-F-G-H- FOR REDUNDANCY CHECK.
       REM
       CLA  IDE+7    INITIALIZE IDE
       STO IDE
       REM
       AXT 8,1
       CAL IDE       GET CURSOR
       REM
TRC    TRCA YES      AN ERROR ON THIS CHAN.
       ORS REC4R+9   NO ERROR ON THIS CHAN.
       LGR 3         SHIFT CURSOR TO
       STO IDE       NEXT CHAN. LOC.
       REM
       CLA TRC       GET INST.
       TPL *+2       IS IT PLUS
       ADD STOR+8,1  NO- CHANGE INST.
       CHS           YES- CHANGE SGN.
       STO TRC       STO NEW INST.
       TIX TRC-1,1,1 BACK FOR NEXT INST.
       REM           WAS THERE A REDUNDANCY
       CLA REC4R+8   TAPE CHECK ON ANY CHAN
       SUB BIT2+3    IF NOT-RETURN TO MAIN
       TZE CONT      PROGRAM-OK
       STZ KONST+7
       REM
CONT   CLA STOR+6    RESET REGISTERS
       LDQ STOR
       LLS 35
       LDQ STOR+2
       LXD STOR+4,1  RESTORE SAVED XRA
       REM
       ZET KONST+7   TAPE CHK REDUNDANCY
       TRA 2,4       NO-CONTINUE PROG
       TRA ERROR-2   YES-INTERROGATE SENSE SWS
       REM
*       PRINT ROUTINE
       REM
PRINT  STO STOR      ACC CONTENTS
       ARS 35
       SLW STOR+6    OV FL BITS
       PXA 2,2
       STA STOR+4    XRB
       SXD STOR+4,1  PLACE XRA INTO DECR
       SXD STOR+6,4  PLACE XRC INTO DECR
       STQ STOR+2    MQ CONTENTS
       STI INDS      SAVE INDICATORS
       REM
CHK1   CLA STOR+9    L 100000
       DCT           DIV CK TEST
       TRA DVPLO     DCT LITE IS ON
       ARS 3
       REM
       TNO CHK4-3    ACC OV FL-YES
       ORS STOR+6    NO
       CLA BIT2+3
       ALS 7         TO TURN OVFL BACK ON
       REM
       CLA NOP0      TO INSURE OVFL LITE
       STO EXIT-1    IS ON BEFORE EXITING
       TRA CHK4-1
       REM
       CLA OFF       TO INSURE OVFL LINE
       STO EXIT-1    IS OFF BEFORE EXITING
       CLM           CLEAR ACC.
       REM
CHK4   AXT 4,1       L +4 SENSE LITES
       ALS 3
       MSE 101,1
       TRA *+3
       ADD STOR+10   L +1 - WAS ON
       PSE 101,1     RESET LITES
       TIX CHK4+1,1,1
       REM
       REM
       REM
CHK3   AXT 6,1       L +6 SENSE SWITCHES
       ALS 3
       PSE 119,1     IS SSW UP
       TRA CHK3+5    WAS UP
       ADD STOR+10   L +1 - WAS DOWN
       TIX CHK3+1,1,1
       REM
       SLW STOR+8    STO PSE + MSE INDICATIONS
       REM
*      CHECK IF ERROR TRACK IDENTIFICATION WAS CALLED FOR
       REM
       LDQ TRPRI     PUT TRA IN MQ
       LDI 0,4       GET TSX INSTR.
       LFT 1         IS THIS A TAPE TEST
       STQ MUNGN     YES-SET UP FOR ETI
       REM
*      CHECK IF ENTRY TO SUB ROUTINE WAS AT ERROR -1
       REM
CHK3A  CLA KONST+4   ERROR-1 IND.
       TZE CHK3A+7   YES
       CLA PRINT+3   NO
       STA CHK5+1    RESET ADDR TO 2
       CLA KONST+5   SET UP FOR
       STO EXIT      RETURN TO OK-1
       TRA CHK5
       REM
       CLA STOR+10   L+1
       STO KONST+4
       STA CHK5+1    RESET ADDR TO 1
       CLA KONST+6   SET UP FOR
       STO EXIT      RETURN TO OK2
       REM
*      OBTAIN TEST LOC AND ERROR ADDRESS
       REM
CHK5   LXD STOR+6,4  XRC
       PXD 2,4
       COM
       ADD BIT2+2    +1 TO DECREMENT
       STD LOC       ERROR ADDR INTO DECR
       ARS 18
       SUB CHK5+1    L +2
       STA CHK6
       REM
CHK6   CAL 0         PLACE
       STA LOC       TEST LOC INTO ADDR
       STP LOC
       REM
*     OBTAIN BCD OPERATION
       REM
       SUB STOR+10   L +1
       STA *+1
       LDQ 0         BCD OPERATION
       REM
       REM
       REM
       REM
CHK7   AXT 6,1
       CLM
       LGL 2
       PAX 0,4       ZONE BIT
       LGL 4
       CAS BIT+2     CHECK FOR BLANK L +60
       TRA *+2
       TRA CHK7A     YES
       CAS BIT+9     CHECK FOR HYPHEN
       TRA *+2
       TRA TRAP      YES- INDICATES A TRAP
       REM           ROUTINE
       ANA BIT+11    MASK FOR NUMERIC
       PAX 0,2
       TXH CHK7A,2,10 IGNORE SPECIAL CHARS
       CLA BIT+1     COL INDICATOR
       ARS 6,1
       ORS REC1L+9,2
       TXL *+2,4
       ORS REC1L+12,4
CHK7A  TIX CHK7+1,1,1
       REM
CHK8   LDQ 0
       AXT 12,1
       TSX CH22,2
       CAL BIT+10    COL IND
       ARS 12,1
       ORS REC1R+9,4
       TIX *-4,1,1
       REM
CH1    CAL LOC       PUT TEST LOC INTO IMAGE
       LRS 15
       AXT 5,1
       TSX CH21,2
       REM
       CAL BIT       BIT COLUMN 10
       ARS 5,1
       ORS REC1L+9,4
       TIX CH1+3,1,1
       REM
       REM           PUT ERROR ADDR INTO IMAGE
       REM
CH5    LXD LOC,4
       PXD 0,4
       LRS 33
       AXT 5,1
       TSX CH21,2
       CAL LOC+4     -0
       ARS 6,1
       ORS REC1R+9,4
       TIX CH5+4,1,1
       REM
       REM
       REM
       REM
       REM           PUT PSE SW INTO
CH7    CAL STOR+8    IMAGE
       LRS 18
       AXT 6,1
       TSX CH21,2
       CAL BIT+9
       ARS 6,1
       ORS REC1R+9,4
       TIX CH7+3,1,1
       REM
CH10   AXT 12,4      PUT 1ST REC IN PR IMAGE
       AXT 24,1
       CAL REC1L+12,4 LEFT HALF IMAGE
       SLW PR+24,1
       CAL REC1R+12,4
       SLW PR+25,1
       TIX CH10+7,4,1
       TIX CH10+2,1,2
       REM
*     RESET IMAGES BY MASKING
       REM
CH11   AXT 12,4
       CAL MASK
       ANS REC1L+12,4   RESET REC1L
       REM
       CAL MASK+1
       ANS REC1R+12,4   RESET REC1R
       REM
       CAL MASK+2
       ANS REC2L+12,4   RESET REC2L
       REM
       CAL MASK+3
       ANS REC2R+12,4   RESET REC2R
       REM
       CAL MASK+4
       ANS REC3L+12,4   RESET REC3L
       REM
       CAL MASK+5
       ANS REC3R+12,4   RESET REC3R
       REM
       CAL MASK+8
       ANS REC4L+12,4   RESET REC4L
       REM
       CAL MASK+6
       ANS P92+1,4      RESET I/O IMAGE 2L
       REM
       CAL MASK+7
       ANS P95+1,4      RESET I/O IMAGE 3L
       TIX CH11+1,4,1
       TRA CH14
       REM
       REM
       REM
       REM
       REM
       REM
       REM
CH18   CLA STOR+8    PUT MSE LITES INTO IMAGE
       LRS 30
       AXT 4,1
       TSX CH21,2
       CAL BIT+12    BIT COL 6
       ARS 4,1
       ORS REC2L+9,4
       CAL BIT+6     BIT COL 5
       ARS 4,1
       ORS P92-2,4
       TIX CH18+3,1,1
       REM
       CLA KONST+3   IS THIS A MAIN FRAME
       TZE CH41      PRINT OUT -NO
       REM
       REM           FORM CARD IMAGE FOR 2ND REC
       REM
CH15   CLA STOR+4
       LRS 33
       AXT 4,1
       TSX CH21,2
       CAL BIT+5     BIT COLUMN
       ARS 4,1
       ORS REC2L+9,4
       TIX CH15+3,1,1
       TSX CH21,2
       CAL LOC+4     L-0
       ORS REC2R+9,4
       REM
CH16   TSX CH21,2
       AXT 5,1
       TSX CH21,2
       CAL BIT2      BIT COL 8
       ARS 5,1
       ORS REC2R+9,4  BIT IN IMAGE
       TIX CH16+2,1,1
       REM
CH17   CLA STOR+6    PUT XRC INTO IMAGE
       LRS 33
       AXT 5,1
       TSX CH21,2
       CAL BIT2+1    BIT IN COL 19
       ARS 5,1
       ORS REC2R+9,4 BIT IN IMAGE
       TIX CH17+3,1,1
       REM
CH27   LDQ STOR+2    CONTENTS OF MQ
       AXT 12,1
       TSX CH22,2
       CAL BIT+10    BIT COL 15
       ARS 12,1
       ORS REC2L+9,4
       TIX CH27+2,1,1
       REM
       REM
       REM
       CAL LOC+3     WAS ROUTINE USING TRAP
       SUB BIT+9
       TNZ *+4       NO
       CAL STOR+10   L +1
       ORS REC2R+8
       TRA *+3
       REM
       CAL STOR+7    L +1
       ORS REC2R+9
       REM
       STZ LOC+3
       REM
CH23   AXT 12,4
       AXT 24,1
       CAL REC2L+12,4 LEFT HALF
       SLW PR+24,1
       CAL REC2R+12,4 RIGHT HALF IMAGE
       SLW PR+25,1
       TIX CH23+7,4,1
       TIX CH23+2,1,2
       REM
       TSX WPRA,1    PRINT 2ND LINE
       REM
CH20   CAL STOR+6    PUT TRGS INTO
       LRS 18        IMAGE
       TSX CH21,2
       CAL STOR+10   BIT IN 35
       ORS REC3L+9,4  INDICATE DIV CK
       TSX CH21,2
       CAL BIT+4     BIT COL 12
       ARS 1
       ORS REC3R+9,4 ACC OVFL
       REM
CH24   CLM           PUT Q + P BITS
       LLS 11        INTO IMAGE
       PAX 0,4
       CAL BIT+4     BIT IN COL 4
       ALS 2
       ORS REC3L+9,4 Q BIT
       REM
       CLM           GET P BIT
       LLS 1
       PAX 0,4
       CAL BIT+4
       ARS 2         BIT IN COL 13
       ORS REC3L+9,4
       REM
CH25   LDQ STOR
       CAL BIT+6     PUT + SIGN OF
       TQP CH25+5    ACC IN IMAGE
       ORS REC3L+10  MINUS SIGN OF ACC IN IMAGE
       TRA CH26
       REM
       ORS REC3L+11  INTO IMAGE
       REM
       REM
CH26   AXT 12,1
       TSX CH22,2
       CAL BIT+10    BIT COL 15
       ARS 12,1
       ORS REC3L+9,4
       TIX CH26+1,1,1
       REM
CH30   AXT 12,4   PUT 3RD REC INTO
       AXT 24,1   PRINT IMAGE
       CAL REC3L+12,4 LEFT HALF
       SLW PR+24,1
       CAL REC3R+12,4 RIGHT HALF
       SLW PR+25,1
       TIX CH30+7,4,1
       TIX CH30+2,1,2
       REM
       TSX WPRA,1    PRINT 3RD LINE
       REM
CH32   CLA INDS      PUT INDICATORS IN ACC.
       STO PR        PUT INDS. IN PR. IMAGE
       LDQ PR        INDICATOR FROM STORAGE
       AXT 12,1
       TSX CH22,2
       CAL BIT+6
       ARS 13,1
       ORS REC4L+9,4 INDICATORS INTO
       TIX CH32+3,1,1 PRINT RECORD
       REM
       REM           PUT CONTENT OF KEYS IN
       REM
CH33   ENK           PRINT RECORD
       AXT 12,1
       TSX CH22,2
       CAL BIT+1
       ARS 16,1
       ORS REC4L+9,4 KEYS CONTENTS INTO
       TIX CH33+2,1,1 PRINT REC
       REM
CH34   AXT 12,4      PUT 4TH REC
       REM           INTO PRINT IMAGE
       AXT 24,1
       CAL REC4L+12,4
       SLW PR+24,1
       CAL REC4R+12,4 TAPE CHECK INDICATORS
       SLW PR+25,1
       ZET KONST+7    IS THERE A TAPE CHK
       STZ PR+25,1    NO-  CLEAR RIGHT IMAGE
       TIX *+1,4,1    YES- KEEP RIGHT IMAGE
       TIX CH34+2,1,2
       REM
MUNGN  TSX WPRA,1    PRINT CONTENTS OF INDS
       REM           OR SET UP ETI
       REM
       CLA STOR+10    L+1
       STO KONST+3
       REM
       REM           RESET ACC + MQ CONTENTS
       REM
       STO KONST+7
       CLA STOR+6    OVFL BITS
       LDQ STOR      ACC CONTENTS
       LLS 35
       LDQ STOR+2
       LDI INDS
       REM
CH35   LXA STOR+4,2  XRB
       LXD STOR+4,1  XRA
       LXD STOR+6,4  XRC
       REM
       CLA ORIG      GET-TSX WPRA,1
       STO MUNGN
       REM
       TOV EXIT
EXIT   TRA OK-1
       REM
CH41   CLA KONST+7   IS THIS A REDUNDANCY
       REM           TAPE CK PRINT-OUT
       TZE CH32      YES
       AXT 24,1      CLEAR RECORD IMAGE
       STZ PR+24,1
       TIX *-1,1,1
       REM
       CAL STOR+2    WORD GENERATED
CH43   SLW PR+17
       COM
       SLW PR+19     PRINT IMAGE
       AXT 12,1
       AXT 24,1
       CAL P92+1,1
       SLW PR+24,2
       TIX CH43+8,1,1
       TIX CH43+5,2,2
       REM
       TSX WPR,1     PRINT WORD GENERATED
       REM
CH45   CLA STOR+4
       ARS 18
       SUB WDNO      WORD NUMBER
       LRS 15
       AXT 5,1
       REM
CH46   TSX CH21,2
       CAL BIT+7     BIT COL 17
       ARS 5,1
       ORS P93,4     WORD NUMBER INTO
       TIX CH46,1,1  IMAGE
       REM
       REM
       REM
       REM
       REM
       REM
CH47   LXA STOR+4,2  XRB
       CLM
       PXA 0,2
       SUB RECNO     RECORD NUMBER
       LRS 15
       AXT 5,1
       REM
CH48   TSX CH21,2
       CAL BIT+6     BIT COL 5
       ARS 5,1
       ORS P93,4
       TIX CH48,1,1
       REM
CH49   AXT 24,1      CLEAR RECORD IMAGE
       STZ PR+24,1   LOCATION
       TIX *-1,1,1
       REM
       CAL STOR      WORD READ
CH50   SLW PR+17
       COM
       SLW PR+19
       REM
CH51   AXT 12,1
       AXT 24,2
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
TRAP   STO LOC+3
       TRA CHK7A
       REM
DVPLO  ORS STOR+6    OCT 100000
       DVP STOR+10   OCT 1-GET DIV-CHK TO
       TRA CHK1+3    TURN ON DCT LITE
       REM
       REM
       REM
       REM
       REM
       REM
       REM
YES    ORA REC4R+8
       TRA TRC+2
       REM
TRPRI  TRA PRI
       REM
ORIG   TSX WPRA,1
       REM
NOP0   NOP
       REM
OFF    TOV EXIT
       REM
INDS   OCT 0         STORAGE FOR INDS.
       REM
       REM
REC1L  OCT 320,10001000,1000000
       OCT 4002000042,200000400400
       OCT 0,452010001005
       OCT 100000000000,0,540010001000
       OCT 14003400366,202000000401
       REM
REC1R  OCT 0,4000001000,0,100000200
       OCT 0,0,4240001000,400,0
       OCT 5000001600,000300000000
       OCT 40000000
       REM
REC2L  OCT 200000000100,440001000
       OCT 200,0,40000000000
       OCT 100000000
       OCT -500400001000,0,40
       OCT 100400001200
       OCT -400140000100
       OCT 240000000040
       REM
       REM
       REM
       REM
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
REC3R  OCT 0,-400040000000,0
       OCT 5000000000,2000000000,0
       OCT -460440000000,0
       PON
       OCT -402040000000
       OCT 4400000000,161000000000
       REM
REC4L  OCT -0,100000,0,0
       OCT 200000200000
       OCT 100000000000
       OCT 0,40000440000
       OCT 0,40000140000
       OCT 200000400000
       OCT -500000200000
       REM
       REM
       REM
       REM
       REM
       REM
REC4R  OCT 0,-400204444446
       OCT 040000000020,000000000200
       OCT 020100002000,000000020000
       OCT -604404644444,002002000000
       OCT 100020000000,-600004444444
       OCT 043100000000,124622222222
       REM
       REM
STOR   OCT 0         ACC CONTENTS
       OCT -200000000   22 TO 24
       OCT 0         MQ CONTENTS
       OCT -200000000   24 TO 26
       OCT 0         XRA AND XRB
       OCT -100000000   26 TO 27
       OCT 0         XRC, OVRL TRGS, TAPE CK
       OCT -500000000   27 TO 22
       OCT 0         PSE + MSE VALUES
       OCT 100000
       OCT -1
       REM
BIT    OCT 400000000 BIT COL 10
       OCT 100000    BIT COL 21
       OCT 60
IDE    OCT 10000000
       OCT 200000000 BIT COL 11
       OCT 10        BIT COL 33
       OCT 020000000000 BIT COL 5
       OCT 2000000   BIT COL 17
       OCT 1000      BIT COL 27
       OCT 40        BIT COL 31
       OCT 10000000  BIT COL 15
       OCT 17
       OCT 010000000000
       REM
BIT2   OCT 002000000000 BIT COL 8
       OCT 400000    BIT COL 19
       OCT 1000000
       OCT 100020000000
       REM
MASK   OCT 777017601777  REC1L
       OCT 407760001700  REC1R
       OCT -760760001760 REC2L
       OCT 374077017776  REC2R
       OCT -756720001776 REC3L
       OCT -777670000000 REC3R
       OCT -741777777777 P92
       OCT -740774077777 P95
       OCT -760001760000 REC4L
       OCT -777776666666 REC4R+9
       REM
       REM
       REM
*      IMAGE FOR MSE- COMP ERROR- WORD GENERATED
       REM
       OCT 3210040,1000000000
       OCT 20001000,100460000
       OCT 100004000704
       OCT -000040004002
       OCT 1200000010
       OCT 200000000000,20
       OCT 201000040010
       OCT -000163630240
P92    OCT 100204005526
       REM
       REM
       REM
*      IMAGE FOR REC - WORD- WORD READ
       REM
       OCT -400020000220,400040000
       OCT 0,140001400
       OCT 200000000010,10000102
       OCT 100400040000,0,4
P93    OCT 500041000
       OCT -400060000620
P95    OCT 300010000116
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
CTWD   HTR PR,0,24    CTRL WORD FOR PRINTING
       REM
IMA    OCT 0,0,0      MASKS FOR ERROR TRACKS
       OCT 101010101010 8 BIT
       OCT 0,0,0,0,0,0,0
       OCT 040404040404 4 BIT
       OCT 0,0,0
       OCT 424242424242 2 + B BIT
       OCT 0
       OCT 212121212121 1 + A BIT
       OCT 0,0,0,0,0
       OCT 606060606060 B + A BITS
       REM
       REM
       REM
       REM
PRI    CLA KONST+7    ERROR INDICATORS
       TZE OUT        NO ERROR-
       CAL STOR+2     ERROR-GET BAD WORD
       ERA STOR       PUT ONES IN ERROR BITS
       REM
       AXT 23,1
MVE    LDQ IMA-23,1   PUT MASK IN PRINT
       STQ PR-24,1    IMAGE AND MODIFY
       ANS PR-24,1    WITH ERROR BITS
       TIX MVE,1,2
       REM
OUT    TSX WPR,1      PRINT LINE FOUR
       TRA MUNGN+1    CONTIUNE 9DEPRX
       REM
       REM
       REM
PR     OCT            PRINT IMAGE
       REM
       REM
       REM
       REM
       END
