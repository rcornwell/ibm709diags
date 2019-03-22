                                                             9COMB          
                                                            3/1/59         
       REM            
       REM            
*                    9COMB          
       REM            
       REM            
*      709/704 COMPATABILITY AND EXECUTE INSTRUCTION PROGRAM
       REM
       REM
*WITH THIS LOADING PROCEDURE, THE PROGRAM CAN GET INTO STORAGE
*WITH THE LOAD CARDS BUTTON OR MANUAL LOADING FROM THE BUFFER.
       REM            
*IF THE CARDS CANNOT BE LOADED WITH THE CPU LOAD CARDS BUTTON, LOAD
*FROM THE DSU BY PUTTING THE BUFFER IN MANAUL STATUS FOR CHANNEL A, SET
*04217 IN THE DECREMENT PORTION OF THE DSU ENTRY KEYS AND PRESS THE
*LOAD CONTROL WORD KEYS. NOW PRESS THE READ CARD READER KEY.
*WHEN ALL THE CARDS HAVE BEEN READ BY THE CARD READER, SET THE
*DSU TO AUTOMATIC STATUS AND MANUALLY TRANSFER TO LOCATION
*00004 ON THE CPU.    
       REM            
       REM            
       FUL
       REM            
       ORG 0          
       REM            
       IOCD 3,0,TOTAL-2 CONTROL WORD
       REM              FOR LOADING
       REM            
       TCNA *+3     READ ENIRE DECK 
       TRA *-1        
       STR            
       REM            
*WITH 30 OCTAL WORDS PER CARD, THERE IS NO CHECK SUM CHECKING.
*COMPUTE A STORAGE CHECK SUM AND COMPARE IT TO A PREVIOUS
*DETERMINED CHECK SUM TO INSURE CARDS WERE READ CORRECTLY.
       REM            
       AXT TOTAL,1 LAST LOCATION TO XRA
       PXA         CLEAR ACCUMULATOR
       ACL TOTAL,1 COMPUTE THE 
       TIX *-1,1,1 CHECK SUM
       SLW SUM     SAVE CHECK SUM
       REM            
*CHECK COMPUTED CHECK SUM WITH KNOWN CHECK SUM
       REM            
       CLA SUM     L COMPUTED CHECK SUM
       SUB TOTAL   L KNOWN CHECK SUM
       TZE *+2     CARDS READ OK
       HTR         ERROR-RELOAD CARD READER
       REM         AND LOAD AGAIN
       REM            
       CLA K       L TRA ID-7
       STO 0       STORE IN LOCATION 000000
       HTR            
       REM            
       REM            
*LOGICAL DRUM 1 IS USED BY THIS PROGRAM. IF DRUMS ARE NOT
*IN THE SYSTEM, DREPSS KEY ON TO BYPASS THE ROUTINE REQUIRING LOGICAL
*DRUM 1 TO BE ON LINE.
       REM            
       REM            
*IF EC 245677 HAS BEEN INSTALLED ON THE MACHINE, THE C.E. CAN
*MAKE A FAST VISUAL CHECK OF THE BELOW LISTED TRIGGER NEONS
*TO DETERMINE IF THE COMPATABLITY TRIGGERS ARE IN THE CORRECT
*STATUS               
       REM            
*MF3 J04 01   I/O SENSE AND TRAP MODE TRGR NEON           SHOULD BE OFF
       REM            
*MF3 J04 03   COPY TRAP MODE TRGR NEON                    SHOULD BE ON
       REM            
*MF3 J04 05   FP TRAP MODE TRGR NEON                      SHOULD BE ON
       REM            
*MF3 J04 07   MEMORY NULLIFY MODE TRGR NEON               SHOULD BE ON
       REM            
*MF3 J16 03   SENSE PR/PU TRGR NEON                       SHOULD BE OFF
       REM            
*FOR A MORE COMPRESHENSIVE CHECK, THE CE, IF HE DESIRES, CAN SCOPE THE
*BELOW LISTED POINTS TO INSURE THE CATHODE FOLLOWER OUTPUTS FROM THE
*VARIOUS COMPATABILITY TRIGGERS ARE IN THE CORRECT STATUS. PUSH START
*IF NO CHECKING IS DESIRED.
       REM            
* 1. MF3 L16-7 MINUS ON PR/PU SENSE              SHOULD BE UP
       REM            
* 2. MF3 L16-2 TRAP ON I/O                       SHOULD BE DOWN
       REM            
* 3. MF3 K04-5 MINUS ON I/O AND SENSE TRAP MODE  SHOULD BE UP
       REM            
* 4. MF3 L04-1 I/O SENSE AND TRAP MODE           SHOULD BE DOWN
       REM            
* 5. MF3 M04-3 COPY TRAP MODE                    SHOULD BE DOWN
       REM            
* 6. MF3 N04-7 MINUS ON COPY TRAP MODE           SHOULD BE UP
       REM            
* 7. MF3 P04-3 PLUS IN MOEMORY NULLIFY MODE      SHOULD BE DOWN
       REM            
* 8. MF3 R04-6 MINUS IN MEMORY NULLIFY MODE      SHOULD BE UP
       REM            
* 9. MF3 P04-2 MINUS IN F.P. TRAP MODE           SHOULD BE DOWN
       REM            
*10. MF3 P04-5 F.P. TRAP MODE                    SHOULD BE UP
       REM            
*11. MF3 F24-2 TO SIMULATE INDICATOR             SHOULD BE DOWN
       REM            
*IF THESE POINTS ARE IN THE STATE DESCRIBED, PRESS START TO CONTINUE.
*IF NOT, PRESS RESET BUTTON AND OBSERVER IF THE POINTS ARE NOW SET TO
*THE STATE DESCIBED. 
       REM            
       REM            
*CHECK FOR DRUM 1 ON LINE
       REM            
       ENK           KEYS TO MQ
       XCA           MQ TO ACC
       PAI           ACC TO INDICATORS
       LNT 200000    IS DRUM 1 ON LINE
       TRA ID         YES-DO NOT ALTER PROGRAM
       CLA K1+3       NO-INSERT BYPASS IN TEST
       STO A21X       REQUIRING DRUM 1
       REM            
*WITH I/O AND SENSE AND TRAP TRIGGER RESET,PROGRAM IDENTIFICATION
*CAN BE PRINTED DEPENDING ON THE STATUS OF SENSE SWITCH 3.
       REM            
ID     SWT 3          TEST SENSE SWITCH 3
       TRA TITLE      IDENTIFY PROGRAM
       REM            
*DETERMINE SIZE OF STORAGE AND ADJUST ADDRESSES IF 8K OR 16 CAPACITY
       REM            
       AXT 32K,4      L 77777 IN REC
       TXL ADJ,4,16K  TRANSFER IF STG NOT 32K
       TRA STG        32K STORAGE
       REM            
       REM            ADJUST ADDRESSES FOR 8K OR 16K STORAGE
       REM            
ADJ    CLA K1+2       L FIRST AND LAST
       REM            ADDRESSTO MODIFY
       REM            
       STA ADJ1       STORE INITIAL ADDRESS
       STA FIX+4      TO BE CHECKED FOR
       STA FIX1+4     MODIFICATION
       STA FIX2+6     IN THESE LOCATIONS
       ARS 18         
       STA LADR       STORE LAST ADDRESS
       REM            
ADJ1   CAL            L INSTRUCTION
       PAI            ACC TO INDICATORS
       REM            
       RNT 70000      TEST FOR BITS 21,22,23
       TRA *+2        NO BITS
       TRA FIX        ADJUST ADDRESS
       REM            
       RNT 40000      TEST FOR BIT 21
       TRA *+2        NO BIT
       TRA FIX2       ADJUST ADDRESS
       REM            
       RNT 30000      TEST FOR BIT IN POS 22,23
       TRA ADR        NO BITS-GET NEXT ADR
       TRA FIX1       ADJUST ADDRESS
       REM            
FIX    TXH *+3,4,8K   TRANFER IF STG 16K
       REM            
*ADJUST ADDRESSES WITH BITS IN 21,22,23 FOR 8K
       REM            
       ANA NUM+14     L 7777777717777
       TRA *+2        
       REM            
*ADJUST ADDRESSES WITH BITS IN 21,22,23 FOR 16K
       REM            
       ANA NUM+15     L 7777777737777
       SLW            INSTR. WITH CORRECT ADR
       TRA ADR        
       REM            
FIX1   TXH *+3,4,8K   TRANSFER IF STG 16K
       REM            
*ADJUST ADDRESSES WITH BITS IN 22,23 FOR 8K
       REM            
       ANA NUM+16     L 7777777707777
       TRA *+2        
       REM            
*ADJUST ADDRESSES WITH BITS IN 22,23 FOR 16K
       REM            
       ANA NUM+14     L 7777777717777
       SLW            INSTR WITH CORRECT ADR
       TRA ADR        
       REM            
FIX2   TXH *+4,4,8K   TRANSFER IF STG 16K
       REM            
*ADJUST ADDRESSES WITH BIT IN 21 FOR 8K
       REM            
       ANA NUM+16     L 7777777707777
       ORA NUM+17     L 0000000010000
       TRA *+3        
       REM            
*ADJUST ADDRESSES WITH BIT IN 21 FOR 16K
       REM            
       ANA NUM+16     L 7777777707777
       ORA NUM+18     L 0000000020000
       SLW            INSTR. WITH CORRECT ADR
       REM            
ADR    CAL ADJ1       L LAST INSTR CHECKED
       ANA NUM+19     L 0000000007777
       ADD NUM+1      
       CAS LADR       
       HTR ADJ        STG NEVER BE LESS
       REM            CHECK ADDRESS TO BE
       REM            MODIFIED FOR 8K-16K AGAIN
       TRA STG1       
       STA ADJ1       ADDRESS
       STA FIX+4      OF THE
       STA FIX1+4     NEXT 
       STA FIX2+6     INSTRUCTION
       TRA ADJ1       TEST NEXT INSTR
       REM            
*MODIFY STG ROUTINE FOR 16K OR 8K STORAGE
       REM            
STG1   TXH STG2,4,8K  TRA IF STG 16K
       AXT 4K+17,4    LOCATION TO XRC
       SXA STG+2,4    XRC TO ADR OF LOC
       SXA STG+10,4   XRC TO ADR OF LOC
       SXA STG+11,4   XRC TO ADR OF LOC
       AXT 4K,4       XRC NOW 07777
       SXD STG+9,4    XRC TO DEC OF LOC
       SXD A5+7,4     XRC TO DEC OF LOC
       TXI *+1,4,1    XRC NOW 10000
       SXA RESET+4,4  XRC TO ADR OF INSTR
       TXI *+1,4,6    XRC NOW 10006
       SXA SPACE+3,4  XRC TO ADR OF INSTR
       TRA STG        
       REM            
STG2   AXT 8K+17,4    LOCATION TO XRC
       SXA STG+2,4    XRC TO ADR OF LOC
       SXA STG+10,4   XRC TO ADR OF LOC
       SXA STG+11,4   XRC TO ADR OF LOC
       AXT 8K,4       XRC NOW 17777
       SXD STG+9,4    XRC TO DEC TO LOC
       SXD A5+7,4     XRC TO DEC OF LOC
       TXI *+1,4,1    XRC NOW 20000
       SXA RESET+4,4  XRC TO ADR OF INSTR
       TXI *+1,4,6    XRC NOW 20006
       SXA SPACE+3,4  XRC TO ADR OF INSTR
       REM            
*PUT GROUP OF INSTR IN LOWER LOCATIONS OF UPPER HALF OF STORAGE
       REM            
STG    AXT 15,4       
       CLA TRAP+15,4  
       STO 16K+17,4   
       TIX *-2,4,1    
       REM            
*FILL BLANK LOCATIONS OF STORAGE FOR PROGRAM MONITOR
       REM            
       AXT TOTAL+1,4  LOCATION TO XRC
       CLA A20A-3     L STR
       STO TOTAL+1    STORE IN BLANK LOC
       TXI *+1,4,1    ADD ONE TO XRC
       SXA *-2,4      XRC TO ADR OF INSTR
       TXL *-3,4,16K  FILL STG FROM TOTAL+1
       REM            THRU16K
       REM            
       AXT 16K+17,4   LOCATION TO XRC
       STO 16K+17     
       TXI *+1,4,1    ADD ONE TO XRC
       SXA *-2,4      XRC TO ADR OF LOC
       TXH *-3,4,0    FILL STG FROM 16K+17
       REM            THRU32K
       REM            
STGB   AXT ID-7,4     LOCATION TO XRC
       STO ID-7       ACC TO LOCATION
       TXI *+1,4,1    ADD 1 TO XRC
       SXA *-2,4      XRC TO ADR OF LOC
       TXL *-3,4,STGB-1 FILL STG FROM ID-7
       REM              THRU STGB-1
       SLN 1          SENSE LIGHT 1 ON
       REM            
       REM            
*                                 NOTE           
       REM            
       REM            
*THE COMMENTS IN THE PROGRAM WERE WRITTEN FOR 32K STORAGE
*COMPATABLELOCATION FOR OTHER STORAGE UNITS ARE LISTED BELOW
       REM            
       REM            
*                          32K STG        16K STG        8K STG
       REM            
*HIGHEST LOC                77777         37777          17777
*HIGHEST LOC LOW HALF       37777         17777          07777
*LOWEST LOC UPPER HALF      40000         20000          10000
       REM            
       REM            
*THE PROGRAM OFTEN REFERS TO TRIGGERS AS BEING RESET AND SET.
*BY RESET, THE PROGRAM MEANS THE X RESET CONDITION OF THE
*TRIGGER AS SEEN ON THE SYSTEMS PAGES. BY SET, THE PROGRAM MEANS
*THE TRIGGER IS IN THE OPPOSITE STATUS OF THE X RESET AS SHOWN ON
*THE SYSTEMS PAGES. E.C. LEVEL SYSTESM PAGE 2.07.76 IS 244893.
       REM            
       REM            
*                              COMMENCE TEST  
       REM            
       REM            
*CHECK TRA DOES NOT BRING PLUS IN MEMORY NULLIFY MODE LINE UP
*SEE SYSTEMS PAGE 2.07.76
       REM            
AZ     AXT *,1        LOCATION TO XRA
       TRA RESET      INITIALIZE
       CLA K+1        L TRA AXA-2
       STO 7          STORE IN LOCATION 00007
       REM            
*WITH A TRA, ALL INPUTS TO AND CIRCUIT MF3 J04 H SHOULD NOT BE UP. THIS
*AND CIRCUIT CANNOT BE CONDITIONED TO SET THE NULLIFY TRIGGER AND BRING
*PLUS IN MEMORY NULLIFY MODE LINE UP-SYSTEMS PAGE 2.07.76.
       REM            
       TRA *+1        WAS NULLIFY TRIGGER SET
       TRA 16K+8      IF NO, TRA 40007
       REM            
       SWT 2          ERROR
       HPR            CHECK COMPONENTS
       REM            MENTIONED ABOVE
AZA    SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA AZ         REPEAT
       REM            
       REM            
*CHECK ABILITY TO SET NULLIFY TRIGGER AND HALF STORAGE
       REM            
A      AXT *,1        THIS LOCATION IN XRA
       TRA MONIT      MONITOR PROGRAM
       CLA K+2        L TRA AA
       STO 9          STORE IN LOCATION 00011
       REM            
*WITH NEXT INSTRUCTION, ALL 6 INPUTS TO AND CIRCUIT MF3 J04 H ON
*SYSTEM SPAGE 2.07.76 GO UP TO CONDITION THIS AND CIRCUIT TO SET
*TRIGGER MF3 J04 07 TO BRING PLUS IN MEMORY NULLIFY MODE LINE UP.
*MINUS IN MEMORY NULLIFY MODE LINE DOWN AND TURN ON SIMULATE INDICATOR
       REM            
       ESNT *+1       ENTER NULLIFICATION MODE
       REM            
*IN THE NULLIFICATION MODE, NO LOCATION GREATER THEN 37777 WITH A 
*32K STG., 17777 WITH A 16K STG., OR 77777 WITH AN 8K STG. CAN
*BE ADDRESSED. SEE NULLIFY TRIGGER AND ITS OUTPUTS ON SYSTEMS
*PAGES 2.07.76 AND SHEET 2 3.42.
       REM
       TRA 16K+10     TRY TRA TO UPPER HALF
       REM            STORAGE LOCATION
       REM            
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM            AND ITS OUPUTS
       REM            
*CHECK ABILITY TO RESET NULLIFY TRIGGER FOR FULL STORAGE USE
       REM            
AA     CLA K+3        L TRA AB-2
       STO 10         STORE IN LOCATION 00012
       REM            
*WITH NEXT INSTRUCTION, ALL 5 INPUTSTO AND CIRCUIT MF3 A18 H GO
*UP TO CONDITION BOTTOM LEG TO AND CIRCUIT MF3 J04 G. THE TOP
*LEG IS CONDITIONED BY UNIT ADR 10 WHICH SHOULD RESET TRIGGER
*MF3 J04 07 AND TURN THE SIMULATE INDICATOR OFF. SYSTEM 2.07.76
       REM            
       LSNM           EXIT NULLIFICATION MODE
       TRA 16K+11     TRA 40012
       REM            
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM            AND ITS OUTPUTS
AB     SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A          REPEAT
       REM            
       REM            
*CHECK TTR +0021 HAS NO EFFECT ON NULLIFY TRIGGER
       REM            
A1     AXT *,1        THIS LOCATION IN XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       CLA K+4        L TRA A1A-2
       STO 11         STORE IN LOCATION 00013
       REM            
*INSTR REG SIGN MINUS ON AND CIRCUIT MF J04 H SHOULD BE
*DOWN TO PREVENT CONDITIONING THE AND CIRCUIT TO SET
*THE NULLIFY TRIGGER. PLUS IN MEMORY NULLIFY MODE LINE SHOULD
*REMAIN DOWN AND MINUS IN MEMORY NULLIFY MODE LINE SHOULD
*REMAIN UP-SYSTEMS 2.07.76
       REM            
       TTR *+1        
       REM            
*CHECK NULLIFY TRIGGER STILL RESET
       REM            
       TRA 16K+12     TRA 40013
       REM            
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM            AND ITS OUTPUTS
A1A    SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A1         REPEAT
       REM            
       REM            
*CHECK TEFD-0031 HAS NO EFFECT ON NULLIFY TRIGGER
       REM            
       REM            
A2     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       CLA K+5        L TRA A2A-2
       STO 12         STORE IN LOCATION 00014
       REM            
*AND CIRCUIT MF3 J04 H SHOULD NOT BE CONDITIONED
*TO PREVENT SETTING NULLIFY TRIGGER-SYSTEMS 2.07.76
       REM            
       TEFD *+2       
       NOP            
       TRA 16K+13     TRA 40014
       REM            
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM            AND ITS OUTPUTS
A2A    SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A2         REPEAT
       REM            
       REM            
*CHECK RND +0760---10 HAS NO EFFECT ON NULLIFY TRIGGER
       REM            
A3     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       CLA K+6        L TRA A3A
       STO 13         STORE IN LOCATION 00015
       ESNT *+1       ENTER NULLIFY MODE
       REM            
*INSTR REG SIGN MINUS ON AND CIRCUIT MF3 A18 H SHOULD BE
*DOWN PREVENTING CONDITIONING AND CIRCUIT MF3 J04 G TO
*RESET NULLIFY TRIGGER-SYSTEMS 2.07.76
       REM            
       RND            
       TRA 16K+14     SHOULD TRA TO LOC 00015
       REM            
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM            AND ITS OUTPUT
A3A    SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A3         REPEAT
       REM            
       REM            
*CHECK XR INCREMENTED IN NULLIFY MODE
       REM            
A4     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       AXT 16K,2      37777,17777 OR 07777 TO XRB
       ESNT *+1       SET NULLIFY TRIGGER
       TXI *+1,2,1    ADD ONE TO XRB
       REM            
*WITH NULLIFY TRIGGER SET, XRB HIGH ORDER POSITION IS BLOCKED COMING
*FROM XRB INTO ADDER X-SYSTEMS 2.0.2.04
       REM            
       PXA 0,2        XRB TO ACC
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        OK-XRB HIGH ORDER
       REM            POSITION BLOCKED
       SWT 2          ERROR
       HPR            CHECK HIGH ORDER POS
       REM            XRB AND ADDERS
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A4         REPEAT
       REM            
       REM            
*CHECK AN XR WITH TIX IN NULLIFY MODE
       REM            
A5     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       AXT 16K+1,2    40000 TO XRB ON 32K STG.
       REM            20000 TO XRB ON 16K STG.
       REM            10000 TO XRB ON 8K STG
       REM            
       ESNT *+4       SET NULLIFY TRIGGER
       SWT 2          
       HPR            TIX TRANSFERRED
       TRA *+2        
       TIX *-3,2,16K  NO TRA UNDER ANY CONDITION
       REM            
*WITH NULLIFY TRIGGER SET, XRB HIGH ORDER POSITION IS BLOCKED COMING
*FORM XRB INTO ADDER X-SYSTEMS 2.02.04
       REM            
       PXA 0,2        XRB TO ACC
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        OK-XRB ZERO
       SWT 2          ERROR
       HPR            CHECK FOR ADDER
       REM            N CARRY OUTPUT
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A5         REPEAT
       REM            
       REM            
*CHECK TSX IN AND OUT OF NULLIFICATION MODE
       REM            
A5X    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+7        L TRA 2,2
       STO 14         STO IN LOCATION 00016
       REM            
*CHECK TSX WITH NULLIFY TRIGGER SET
       REM            
       ESNT *+1       ENTER NULLIFY MODE
       TSX 16K+15,2   HIGH ORDER ADR LINE DOWN
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       SWT 2          ERROR
       HPR            TRANSFERRED TO LOC 40016
       REM            
*CHECK TSX WITH NULLIFY TRIGGER RESET
       REM            
       LSNM           RESET NULLIFY TRIGGER
       TSX 16K+15,2   SHOULD TRA LOC 40016
       TRA *+3        OK-PROCEED
       SWT 2          ERROR
       HPR            TRANSFERRED TO LOC 00016
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A5X        REPEAT
       REM            
       REM            
*CHECK AN XR COUNT DOWN WITH TIX IN NULLIFY MODE
       REM            
A6     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       AXT 32K,2      77777 TO XRB ON 32K STG
       REM            37777 TO XRB ON 16K STG
       REM            17777 TO XRB ON 8K STG
       REM            
       ESNT *+1       SET NULLIFY TRIGGER
       TIX *,2,1      COUNT DOWN XRB
       PXA 0,2        XRB TO ACC
       SUB NUM+1      L+1
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        XRB COUNT DOWN OK
       SWT 2          ERROR
       HPR            ERROR IN COUNT DOWN
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A6         REPEAT
       REM            
       REM            
*CHECK ESTM IS INDIRECT ADDRESSABLE
       REM            
A6X    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K1+10      L TRA A6X+5
       STO 8          STORE IN LOCATION 00010
       ESNT* *+7      SET NULLIFY AND IA TRGS
       REM            
*TAKE AN E CYCLE TO READ CONTENTS OF ABOVE ADDRESS OUT OF STORAGE
*AND USE ITS ADDRESS TO OBTAIN THE NEXT INSTRUCTION
       REM            
       TSX 16K+15,2   TRA TO LOC 00016
       TRA *+2        ERROR
       TRA *+7        NULLIFY + IA TRGRS OK
       SWT 2          ERROR
       HPR            WAS NULLIFY TRGR SET
       TRA *+4        
       LSNM           DO NOT EXECUTE INSTR
       REM            USE ADR PORTION ONLY
       REM            TO GET ADR FOR ESNT INSTR
       REM            TO TRANSFER TO
       SWT 2          ERROR
       HPR            WAS IA CONTROL TRGR SET
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A6X        REPEAT
       REM            
       REM            
*CHECK I/O SENSE AND TRAP MODE TRIGGER
       REM            
A7     AXT *,1        THIS LOCATION IN XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       REM            
*FROM I/O SENSE AND TRAP MODE TRIGGER MF3 J04 01 SYSTEMS 2.0776 CHECK
*I/O SENSE AND TRAP MODE LINE COMES UP AND MINUS ON I/O SENSE AND TRAP
*MODE LINE GOES DOWN WITH THE NEXT INSTRUCTION.
       REM            
       ESTM           SET I/O SENSE AND TRAP TRGR
       ESNT *+1       SET NULLIFY TRIGGER
       REM            
*I/O SENSE AND TRAP MODE LINE UP FROM THE I/O SENSE AND TRAP TRIGGER,
*CONDITIONS TRAP ON I/O WHICH WILL RESET I/O SENSE TRAP TRIGGER, RESET
*NULLIFY TRIGGER, STORE THE SELECT INSTR LOCAION PLUS 1 IN THE ADDRESS
*PORTION OF LOCATION 40000 AND TRAP TO 40001 WITH A SELECT INSTRUCTION.
*SEE SYSTEMS 2.07.76, 3.40. SHEETS 1 AND 2 OF 3.42, 2.08.61, 2.07.70 AND
*5.01.01              
       REM            
       RTBA 1         RESET TAPE-SEC OP 02
A7A    SWT 2          ERROR
       HPR            DID NOT TRAP-SEE COMMENT
       REM            
*CHECK CONDITIONING AND CIRCUITS MF3 A18 H AND MF3 J04 A SETS SENSE
*AND TRAP MODE TRIGGER. CONDITIONING AND CIRCUIT MF3 J04 B RESETS
*THE TRIGGER          
       REM            
*CHECK NULLIFY TRIGGER NOW RESET
       REM            
       TSX 16K+15,2   SHOULD TRA LOC 40016
       TRA *+3        OK-PROCEED
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRGR RESET
       REM            
*CHECK CONTENTS LOWEST LOCATION UPPER HALF OF STG.
       REM            
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ K+8        L HTR A7A
       CAS K+8        
       TRA *+2        ERROR
       TRA *+3        LOC 40000 OK-PROCEED
       SWT 2          
       HPR            ERROR LOC 40000
       REM            
*CHECK I/O SENSE AND TRAP MODE TRIGGER NOW RESET AND SELECT
*INSTRUCTION WILL NOT TRAP-SYSTEMS 2.07.76 AND 5.01.01
       REM            
       RTBA 1         
       RCHA NUM       DISCONNECT I/O UNIT
       TRA *+3        OK-NO TRAP-TRANSFER
       SWT 2          ERROR
       HPR            TRAPPED
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A7         REPEAT
       REM            
       REM            
*CHECK IOT +0760---5 HAS NO EFFECT ON I/O SENSE TRAP TRGR
       REM            
A8     AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       REM            
*ON 2.0.76 INSTR SIGN MINUS BEING DOWN ON AND CIRCUIT
*MF3 A18 H PREVENTS CONDITIONS OCCURTTING AS DECRIBED IN INITIAL
*COMMENTS OF SECTION A7
       REM            
       ESNT *+1       ENTER NULLIFY MODE
       IOT            
       NOP            
       RTDA 1         DOES SELECT TRAP
       RCHA NUM       DISCONNECT I/O UNIT
       TRA *+3        OK-NO TRAP-TRANSFER
       SWT 2          ERROR
       HPR            I/O SENSE TRAP TRGR
       REM            SHOULD BE RESET
       REM            
*CHECK NULLIFY TRIGGER STILL SET
       REM            
       TSX 16K+15,2   SHOULD TRA LOC 00016
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       SWT 2          ERROR
       HPR            IS NULLIFY TRGR RESET
       REM            
*CHECK LOWEST LOCATION IN UPPER HALF STG.
       REM            
       LSNM           EXIT NULLIFY MODE
       CLA 16K+1      L LOC 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       SWT 2          ERROR
       HPR            LOC 40000 NOT ZERO
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A8         REPEAT
       REM            
       REM            
*PREVIOSLY, SEC OP 0.2 THE TOP LEG TO OR CIRCUIT MF3 A21 A ON SYSTEMS
*PAGE 5.01.01 WAS CHECKED.NOW CHECK THE NEXT 4 INPUTS TO THIS OR CIRCUIT
*WITH THE I/O SENSE AND TRAP TRIGGER SET.WITH EACH OF THE 4 INPUTS.
*THERE SHOULD BE A TRAP TO LOCATION 40001.IF THE 709 BEGINNING OF TAPE
*TEST AND END OF TAPE TEST INSTRCUTUONS ARE GIVEN--2 BOTTOM LEGS OF THE
*OR CIRCUIT--AND I/O SENSE AND TRAP MODE LINE IS UP,THE FOLLOWING
*CONDITIONS OCCUR     
       REM            
*                    1. THE MACHINE HANGS UP
       REM            
*                  2  . THE INSTRUCTION COUNTER IS RESET TO ZERO
       REM            
*                   3. THE BTT OR ETT INSTR IS IN THE SR
       REM            
*NOTE ON SYSTEMS PAGE 6.02, THAT ER TIME GATES EXECUTION OF 709 BTT
*AND ETT INSTRUCTIONS 
       REM            
A9     AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       REM            
*WRITE SELECT INSTRUCTION-SEC OPN 0,6
       REM            
       ESTM           SET I/O SENSE TRAP TRGR
       WTB 1          704 SELECT INSTR
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
*REWIND SEC OPN 1,2   
       REM            
       ESTM           SET I/O SENSE TRAP TRGR
       REW 1          704 SELECT INSTR
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
*WRITE END OF FILE-SEC OPN 1.0
       REM            
       ESTM           SET I/O SENSE TRAP TRGR
       WEF 1          704 SELECT INSTR
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
*BACKSPACE TAPE-SEC OPN 0,4
       REM            
       ESTM           SET I/O SENSE TRAP TRGR
       BST 1          704 SELECT INSTR
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A9         REPEAT
       REM            
       REM            
*CHECK SENSE PUNCH INSTRUCTION
       REM            
A10    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM           SET I/O SENSE TRAP TRGR
       REM            
*IN THE I/O SENSE AND TRAP MODE. 704 SENSE PUNCH INSTR WILL CONDITION AND
*CIRCUIT MF3 J16 B TO SET TRIGGER MF3 J16 03 AND TRAP-SYSTEMS 2.07.76
*AND 5.01.01          
       REM            
       PSE 225        SHOULD TRAP
       SWT 2          ERROR
       HPR            CHECK COMPONENTS
       REM            NOTED IN COMMENTS
       REM            
       ESTM           SET I/O SENSE TRAP TRGR
       SPUA 1         SHOULD TRAP
       SWT 2          ERROR
       HPR            CHECK COMPONENTS
       REM            NOTED IN COMENTS
       SWT 1          TEST SWITCH 1
       TRA *+2        PROCEED
       TRA A10        REPEAT
       REM            
       REM            
*CHECK SENSE PRINTER  
       REM            
A11    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM           SET I/O SENSE TRAP TRGR
       REM            
*AND CIRCUIT MF3 J16 C SHOULD CONDITION TRIGGER MF3 J16 03 SYSTEMS
*2.07.76 TO CAUSE A TRAP.
       REM            
       SPTA           SHOULD TRAP
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
*CHECK TRIGGER MF3 J16 03 SYSTEMS 2.07.76 CAN BE RESET
       REM            
       SPTA           SHOULD NOT TRAP
       TRA *+4        OK
       TRA *+3        OK
       SWT 2          ERROR
       HPR            CHECK TRIGGER RESET AT
       REM            15 TIME AFTER TRAP
       REM            
       RCHA NUM       CLEAR BUFFER
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A11        REPEAT
       REM            
       REM            
*CHECK SENSE PRINTER  
       REM            
A12    AXT *,1        LOCATION TO XRA
       TRA MONIT      MONITOR PROGRAM
       ESTM           I/O SENSE TRAP TRGR SET
       REM            
*AND CIRCUIT MF3 J16 C SHOULD CONDITION TRIGGER MF3 J16 03 SYSTEMS
*2.07.76 TO CAUSE A TRAP
       REM            
       SPT            SHOULD TRAP
       SWT 2          ERROR-NO TRAP
       HPR            CHECK COMPONETS
       REM            NOTED IN COMMENTS
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A12        REPEAT
       REM            
       REM            
*CHECK FRN +0760---11 AND 704 ETT -0760---11
       REM            
A13    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM           I/O SENSE TRAP TRGR SET
       FRN            SHOULD NOT TRAP
       TRA *+4        OK-NO TRAP
       NOP            
       SWT 2          ERROR
       HPR            FRN TRAPPED
       REM            
*IN THE I/O SENSE TRAP MODE, THE TOP LEG OF AND CIRCUIT MF3 J16 E
*SYSTEMS 2.07.76 IS UP. WITH 704 END OF TAPE TEST INSTR-0760---11,
*THE MIDDLE LEG IS CONDITIONED BY UNIT ADR 11 FROM SYSTEMS 5.01.02 AND
*THE BOTTOM LEG COMES UP AS A RESULT OF CONDITIONING AND CIRCUIT MF3 A18 H
*TO SET TRIGGER MF3 J16 03 AND CAUSE A TRAP
       REM            
       ETT 1          SHOULD TRAP
       SWT 2          ERROR-NO TRAP
       HPR            CHECK COMPONETS
       REM            NOTED IN COMMENTS
       REM            
       REM            NOTE THAT TRIGGER IS TURNED
       REM            OFF BY THE NEXT 15 PULSE
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A13        REPEAT
       REM            
       REM            
*CHECK DCT +0760----12 AND RTT-0760---12
       REM            
A14    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM           SET I/O SENSE TRAP TRGR
       REM            
*AND CIRCUIT MF3 J16 D SHOULD NOT BE CONDITIONED TO SET TRGR MF13 J16 03
*SYSTEMS 2.07.76-NOT TRAP WITH DCT +0760---12. WITH RTT -0760--12,
*THERE SHOULD BE A TRAP.
       REM            
       DCT            INDICTOR IS OFF
       NOP            NO TRAP AND
       TRA *+3        SKIP TO HERE
       SWT 2          ERROR
       HPR            SEE COMMENT ABOVE
       REM
       RTT            SHOULD TRAP
       SWT 2          ERROR
       HPR            NO RTT TRAP-SEE
       REM            COMMENT ABOVE
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A14        REPEAT
       REM            
       REM            
*CHECK TAGGED SENSE INSTRUCTION WITH COMPATABLIBLITY FEATURE
       REM            
A15    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLS NUM        L -0
       AXT 240,2      L 360 TO XRB
       ESNT *+1       ENTER NULLIFY MODE
       ESTM           ENTER I/O SENSE TRAP MODE
       PSE 243,2      SHOULD NOT TRAP-ONLY
       REM            MAKE ACC SIGN PLUS
       REM
       TRA *+4        OK-PROCEED
       NOP            
       SWT 2          ERROR
       HPR            TRAPPED
       REM            
       TPL *+3        OK-ACC SIGN PLUS
       SWT 2          ERROR
       HPR            ACC SIGN MINUS
       REM            
*CHECK NULLIFY TRIGGER REMAINED SET
       REM            
       TSX 16K+15,2   SHOULD TRA LOC 00016
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       SWT 2          ERROR
       HPR            IS NULLIFY TRIGGER RESET
       REM            
*CHECK COMPATABILITY FEATURE WITH XRB ZERO
       REM
       AXT 0,2        CLEAR XRB
       PSE 243,2      
A15A   SWT 2          ERROR
       HPR            NO TRAP
       REM            
*CHECK NULLIFY TRIGGER NOW RESET
       REM            
       TSX 16K+15,2   SHOULD TRA LOC 40016
       TRA *+3        OK-NULLIFY TRIGGER RESET
       SWT 2          ERROR
       HPR            NULLIFY TRIGGER NOT RESET
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ K+9        L HTR A15A
       CAS K+9        
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       SWT 2          ERROR
       HPR            ADR IN LOC 40000 NOT A15A
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A15        REPEAT
       REM            
       REM            
*CHECK COMPATABILITY FEATURE IN TRAPPING MODE
       REM            
A16    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       LTM            LEAVE TRAP MODE
       CLA K+10       L TTR A16A
       STO 1          STORE IN LOCATION 000001
       ESNT *+1       ENTER NULLIFY MODE
       ESTM           ENTER I/O SENSE TRAP MODE
       ETM            ENTER TRAP MODE
       LDQ NUM        L +0 TO MQ
       REM            
*ALTHOUGH TQP HAS A SEC OP 0.2, THIS SHOULD NOT DECODE TO AFFECT AND
*CIRCUIT MF3 A21 A SYSTEMS 5.01.01-TRAP ON I/O LINE SYSTEMS 3.42 SHEET
*2 SHOULD REMAIN DOWN AND A CONDITION MET TRA SHOULD TRAP TO LOCATION
*00001.               
       REM            
       TQP *+1        
       LTM            LEAVE TRAP MODE
       TRA *+5        ERROR
       REM            
       LTM            LEAVE TRAP MODE
       SWT 2          ERROR
       HPR            TRAPPED TO LCOC 40001
       TRA *+3        PROCEED
       REM            
       SWT 2          ERROR
       HPR            TQP DIDNOT TRAP TO 00001
       REM            
*CHECK CONTENTS LOCATION 00000
       REM            
A16A   LTM            LEAVE TRAP MODE
       CLA            L CONTENTS LOC 00000
       LDQ K+11       L STR A16A-9
       CAS K+11       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOC 00000 WRONG
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       LSNM           RESET NULLIFY TRIGGER
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       WRS 219        CONTENTS LOC 40000 OK
       REM            SELECT INSTR TO RESET
       REM            I/O SENSE TRAP TRGR-TRAP
       REM            AND TRANSFER TO A17-3
       REM            
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A16        REPEAT
       REM            
       REM            
*CHECK COPY WITH COPY TRAP TRIGGER RESET. ON SYSTEMS 2.07.76 THE LINE
*MINUS ON COPY TRAP MODE SHOULD BE UP AND THE LINE COPY TRAP MODE
*SHOULD BE DOWN TO PREVENT STORING THE COPY LOCATION PLUS 1 IN THE
*ADDRESS PORTION OF LOCATION 40000 AND TRAPPING TO 40002. OTHER SYSTEMS
*PAGES TO NOTE ARE SHEET 2-3.42 AND SHEET 2-3.100.
       REM            
A17    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CPY            TURN ON IOT LIGHT
       TRA *+4        AND NO TRAP
       NOP            
       SWT 2          ERROR
       HPR            TRAPPED
       REM            
       IOT            CHECK IOT LITE
       TRA *+3        OK-LIGHT WAS ON
       SWT 2          ERROR
       HPR            LIGHT WAS OFF
       REM            
*CHECK LOCATION 40000 
       REM            
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        
       TRA *+3        CONTENTS LOC 40000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       REM            
*CHECK COPY AND AND LOGICAL WORD
       REM            
       CAD            
       TRA *+4        OK
       NOP            
       SWT 2          ERROR
       HPR            TRAPPED
       REM            
       IOT            CHECK IOT LIGHT
       TRA *+3        OK-LIGHT WAS ON
       SWT 2          ERROR
       HPR            LIGHT WAS OFF
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOCATION 40000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOCATION 40000 WRONG
       REM            
*CHECK LDA-FOLLOW OUTPUTS FROM AND CIRCUIT MF3 A20 K SHEET 2-3.10
       REM            
       LDA 1          
       TRA *+4        OK-NO TRAP
       NOP            
       SWT 2          ERROR
       HPR            TRAPPED
       REM            
       IOT            CHECK IOT LIGHT
       TRA *+3        OK-LIGHT WAS ON
       SWT 2          ERROR
       HPR            LIGHT WAS OFF
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 40000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A17        REPEAT
       REM            
       REM            
*CHECK OPERATION WITH COPY TRAP TRIGGER SET
       REM            
A18    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESNT *+1       ENTER NULLIFY MODE
       REM            
*ON SYSTEMS 2 07.76 INSTR ENTER COPY TRAP MODE-0760---6 CONDITIONS AND
*CIRCUIT MF3 J04 C TO SET THE COPY TRAP MODE TRIGGER AND BRING UP THE
*LINE COPY TRAP MODE AND BRING DOWN THE LINE MINUS ON COPY TRAP MODE
       REM            
       ECTM           
       REM            
*COPY. CAD, OR LDA INSTRUCTION SHOULD RESET NULLIFY TRIGGER. STORE
*THE LOCATION PLUS OF CPY. CAD OR LDA IN THE ADDRESS OF LOCATION
*40000. TRAP TO LOCATION 40002 AND THE IOT LIGHT SHOULD REMAIN OFF
*SYSTEMS 2.07.76, 2.07.70, SHEET 2-3.10 AND SHEET 2-3.42
       REM            
       CPY            
A18A   SWT 2          ERROR
       HPR            NO TRAP
       REM            
*CHECK NULLIFY TRIGGER NOW RESET
       REM            
       TSX 16K+15,2   SHOULD TRA LOC 40016
       TRA *+3        OK-NULLIFY TRIGGER RESET
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ K+12       L HTR A17A
       CAS K+12       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 40000 OK
       SWT 2          ERROR
       HPR            CHECK ADR LOC 40000
       REM            
*CHECK IOT LIGHT      
       REM            
       IOT            CHECK IOT LITE
       TRA *+2        ERROR
       TRA *+3        OK-LIGHT WAS OFF
       SWT 2          ERROR
       HPR            IOT LIGHT WAS ON
       REM            
*CHECK COPY TRAP MODE TRIGGER NOW RESET
       REM            
       CPY            
       TRA *+4        OK-PROCEED
       NOP            
       SWT 2          ERROR
       HPR            CPY TRAP TRGR NOT RESET-SEE
       REM            AND CIR, MF3 J04 D 2.07.76
       REM            RESETS CPY TRAP TRIGGER
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A18        REPEAT
       REM            
       REM            
*CHECK CAD AND LDA TRAPS
       REM            
A18X   AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ECTM           SET CPY TRAP TRIGGER
       CAD            SHOULD TRAP LIKE CPY
       REM            SEE SYSTEMS 3.10 SHEET 2
       SWT 2          ERROR
       HPR            SEE COMENTS FOR A CPY
       REM            TRAP IN SECTION A17
       REM            
       ECTM           SET CPY TRAP TRIGGER
       LDA 1          
       SWT 2          ERROR
       HPR          NO TRAP-BOTTOM LEG UP
       REM            TO AND CIRCUIT MF3 A10 D AND
       REM            WITH CPY TRAP MODE UP, TRAP
       REM            TO LOC 40002. SEE SHT 2-3.10
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A18X       REPEAT
       REM            
       REM            
*CHECK COMPLEMENT +0760--06 HAS NO EFFECT ON CPY TRAP MODE TRIGGER
       REM            
A19    AXT *,1        LOCATION TO XRA
       TRA MONIT      
       REM            
*IN PREVIOUS TEST, INSTR REG SIGN MINUS LINE BEING DOWN TO AND CIRCUIT
*MF3 A18 H PREVENTED CONDITIONING TRIGGERS CONCERNED-SYSTEMS 2.07.76.
       REM            
       COM            SHOULD NOT SET TRGR
       REM            
*CHECK COPY TRAP MODE TRIGGER REMAIN RESET
       REM            
       CPY            
       TRA *+4        OK-NO TRAP
       NOP            
       SWT 2          ERROR
       HPR            CPY TRAP TRGR SHOULD
       REM            BE RESET
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A19        REPEAT
       REM            
       REM            
*CHECK STR TRAPS TO LOCATION 00002 WITH COMPATABILUITY FEATURE
       REM            
A20    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+13       L TRA A20A
       STO 2          STORE IN LOCATION 00002
       SUB K0         L +4
       STA 16K+1      STORE IN ADR LOC 40000
       ECTM           SET CPY TRAP TRIGGER
       REM            
*TRAP ON COPY LINE SHOULD BE DOWN ON AND CIRCUIT MF4 J18 Y SHT 2-3.42
*HOLDING DOWN AOR LINE 3. AND CIRCUIT MF4 J35 K SHT 1-3.42 CONTROLS
*TRAP.                
       REM            
       STR            
       SWT 2          ERROR
       HPR            TRAPPED TO LOC 40002
       REM            
*CHECK CONTENTS LOCATION 00000
       REM            
A20A   CLA            L CONTENTS LOCATION 00000
       LDQ K1         L STR A20A-2
       CAS K1         
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOC 0000 WRONG
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ K1+1       L HTR A20A-4
       CAS K1+1       
       TRA *+2        ERROR
       CPY            CONTENTS LOCATION 40000 OK
       REM            RESET CPY MODE TRIGGER
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A20        REPEAT
       REM            
       REM            
*PREVIOUSLY, IT WAS SHOWN RESESTTING I/O AND SENSE TRAP MODE TRIGGER OR
*COPY TRAP MODE TRIGGER RESET NULLIFY TRIGGER. NOW CHECK RESETTING THE
*FIRST 2 MENTIONED TRIGGERS BY EACH OTHER.
       REM            
A21    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM           SET I/O SENSE TRAP TRGR
       ECTM           SET COPY TRAP TRGR
       WDR 1          RESET I/O SENSE TRAP TRGR
       REM            
*ON SYSTEMS 2.07.76 WHEN TRGR MF3 J04 01 IS RESET, LINE I/O SENSE AND
*TRAP MODE GOES DOWN. FOLLOW THIS LINE TO TRIGGER MF3 J04 03 AND NOTE
*THIS TRIGGER. IF SET. WILL BE RESET WHEN THE LINE I/O SENSE AND
*TRAP MODE GOES DOWN. 
       REM            
       SWT 2          ERROR
       HPR            FAILED TO TRAP
       REM            
       CPY            HAS CPY TRAP TRGR
       REM            BEEN RESET
       REM            
       TRA *+4        YES
       NOP            
       SWT 2          ERROR
       HPR            CPY TRAP TRGR NOT RESET
       REM            SEE ABOVE COMMENT
       REM            
*CHECK CPY TRAP TRIGGER RESET ALSO RESETS I/O SENSE TRAP TRIGGER
       REM            
       ESTM           SET I/O SENSE TRAP TRGR
       ECTM           SET COPY TRAP TRGR
       CPY            
       SWT 2          ERROR
       HPR            FAILED TO TRAP
       REM            
*NOTE-IF E.C. 245719 HAS NOT BEEN INSTALLED. THERE WILL BE A DRUM SELECT
*HANGUP IN THIS SECTION OF THE PROGRAM. MANUALLY INSERT A TRA 00460
*AT LOCATION 00451 UNTIL THE E.C. HAS BEEN INSTALLED.
       REM            
A21X   RDR 1          HAS I/O SENSE TRAP
       REM            TRGR BEEN RESET
       TRA *+4        YES
       NOP            
       SWT 2          ERROR
       HPR            SEE CPY TRAP MODE LINE
       REM            TO I/O SENSE AND TRAP
       REM            MODE TRGR WHEN CPY
       REM            MODE TRGR IS RESET
       REM            BY A CPY INSTR
       REM            
       CPY            DRUM SHOULD BE SELECTED
       REM            DISCONNECT DRUM WITH CPY
       TRA *+4        
       NOP            
       SWT 2          ERROR
       HPR            CPY TRAPPED
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A21        REPEAT
       REM            
       REM            
*CHECK FLOATING POINT IN 704 MODE-NO FP TRAP ACCUMULATOR AND MQ INDICATORS ARE
*OPERATIVE AND TQO IS EXECUTED
       REM            
A22    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+14       L TRA A22A
       STO 8          STORE IN LOCATION 00010
       REM            
*WITH NEXT INSTRUCTION. OUTPUT FROM AND CIRCUIT MF3 A18 H WITH UNIT ADR 4
*CONDITIONS AND CIRCUIT MF3 J04 F TO SET TRIGGER MF3 J04 05 AND BRING
*UP THE LINE MINUS IN F.P. TRAP MODE-SYSTEMS 2.07.76
       REM            
       LFTM           SET F.P. TRAP MODE TRGR
       TQO *+1        MQ INDICATOR OFF
       CLS NUM+5      CH 000 FR 000002000
       REM            
*BEFORE PROCEEDING, CHECK CHS +0760---02 HAS NO EFFECT ON F.P. TRAP
*TRGR                 
       REM            
       CHS            TRGR REMAIN SET-ACC NOW
       REM            CH 000 FR +0000002000
       REM            
       FAD NUM+6      CH 000 FR -10000000
       REM            
*CHECK ACCUMULATOR INDICATOR
       REM            
       TOV *+3        OK-ACC IND WAS TURNED ON
       REM            TURN OFF AND TRANSFER
       SWT 2          ERROR
       HPR            ACC INDICATOR OFF
       REM            
*CHECK MQ INDICATOR   
       REM            
       TQO *+6        TQO SHOULD EXECUTE-MQ IND
       REM            WAS TURNED ON-TURN OFF
       REM            AND TRANSFER
       SWT 2          ERROR
       HPR            SEE IF CHS RESET TRGR
       REM            
       TRA *+3        PROCEED
       REM            
*IF FAD IS NOT EXECUTING IN 704 MODE. CHECK CHS IS CONDITIONING AND CIRCUIT
*MF3 J04 E TO RESET FP TRAP MODE TRGR MF3 J04 05-SYSTEM 2.07.76
       REM            
A22A   SWT 2          ERROR
       HPR            TRAPPED TO LOC 00010
       REM            
*CHECK CONTENTS LOCATION 00000
       REM            
       CLA            L CONTENTS LOCATION 00000
       LDQ A20A-3     L STR
       CAS A20A-3     
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 000000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOC 000000 WRONG
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A22        REPEAT
       REM            
       REM            
*CHECK FP MPY IN 704 MODE TURNS OFF ACCUMULATOR INDICATOR
       REM            
A23    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       TRA A23X       SKIP THIS TEST
       ALS 25         SHIFT TO TURN ON ACC IND
       LFTM           FP TRAP MODE TRGR SET
       LDQ NUM+7      CH 200 FR +77777770000
       FMP NUM+7      
       REM            
*CHECK ACCUMULATOR INDICATOR
       REM            
       TNO *+3        OK-ACC OVFLO IND OFF
       SWT 2          ERROR
       HPR            ACC IND NOT RESET OFF
       REM            SYSTEMS PAGES 2.08.40
       REM            AND 2.06.01
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A23        REPEAT
       REM            
       REM            
*CHECK FLOATING POINT IN 709 MODE-NO TRAP
       REM            
A23X   AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+15       L TRA A23V
       STO 8          STORE IN LOCATION 00010
       REM            
*NEXT INSTRUCTION SHOULD CONDITION AND CIRCUIT MF3 J04 E TO RESET TRGR
*MF3 J04 05 IF TRIGGER WAS SET AND EXECUTE FP IN 709 MODE-SYSTEMS
*2.07.76              
       REM            
       EFTM           RESET FP TRAP MODE TRGR
       CLA NUM+8      CH 234 FR-60000000
       FAD NUM+9      CH 233 FR+40000000
       LDQ NUM1       L -234400000000
       CAS NUM1       
       TRA *+2        ERROR
       TRA A23Y+2     FP EXECUTE OF
       SWT 2          ERROR
       HPR            EXECUTED WRONG
       TRA A23Y+2     PROCEED
       REM            
A23Y   SWT 2          ERROR
       HPR            TRAPPED
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A23X       REPEAT
       REM            
       REM            
*CHECK FP MPY IN 704 MODE WITH MULTIPLIER ZERO
       REM            
A23L   AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K1+11      TRA A23M
       STO 8          STORE IN LOC 00010
       LFTM           FP TRAP MODE TRGR SET
       LDQ NUM        MQ ZERO
       FMP NUM1+1     CH 175 FR +777777777777777
       REM            
*CHECK ACC RESULT IS ZERO
       REM            
       TZE *+3        OK-ACC ZERO
       SWT 2          ERROR
       HPR            ACC NOT ZERO
       REM            
*CHECK MQ RESULT IS ZERO
       REM            
       LLS 35         SHIFT TO ACC
       TZE *+3        OK-MQ ZERO
       SWT 2          ERROR
       HPR            MQ NOT ZERO
       REM            
*CHECK ACC OVERFLOW INDICATOR IS OFF
       REM            
       TNO *+6        TRA IF OVFLO IND OFF
       SWT 2          ERROR
       HPR            ACC OVFLO IND ON
       TRA *+3        
       REM            
A23M   SWT 2          ERROR
       HPR            TRAPPED TO LOC 00010
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        PROCEED
       TRA A23L       REPEAT
       REM            
       REM            
*TEST FLOATING POINT 709 MODE WITH TRAP AND ACCUMULATOR INDICATOR OFF
       REM            
A24    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+16       L TRA A24A
       STO 8          STORE IN LOCATION 00010
       REM            
*CONDITION AND CIRCUIT MF3 J04 E TO RESET TRGR MF3 J04 05 IF SET
       REM            
       EFTM           LINE F.P. TRAP MODE UP
       REM            
*BEFORE PROCEEDING CHECK ENK +0760---04 DOES NOT SET F.P. TRAP MODE
*TRIGGER IF TRIGGER IS SET, CHECK ENK CONDITIONING AND CIRCUIT MF3 J04 F
*TO SET FP TRAP MODE TRIGGER-SYSTEMS 2.07.76
       REM            
       ENK            TRGR REMAIN RESET
       CLM            CLEAR ACCUMULATOR
       LDQ NUM+10     CH 032 FR-404040404
       LLS 35         NO ACC OVERFLOW
       FDP NUM+11     CH 344 FR +440404040
       SWT 2          ERROR
       HPR            FAILED TO TRAP
       REM            
*CHECK ACCUMULATOR INDICATOR OFF
       REM            
A24A   TNO *+3        OK-ACC IND OFF
       SWT 2          ERROR
       HPR            ACC IND ON
       REM            
*CHECK CONTENTS LOCATION 00000
       REM            
       CLA            L CONTENTS LOCATION 00000
       LDQ K+17       L FP LOC +1 IN ADR AND
       REM            BITS IN DECREMENT POSITIONS
       REM            14,16,17 WITH OP CODE -1
       CAS K+17       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OF
       SWT 2          ERROR
       HPR            CONTENTS LOC 00000 WRONG
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A24        REPEAT
       REM            
       REM            
*CHECK EXECUTION TQO AND OPERATION MQ INDICATOR IN 709 MODE
       REM            
A26    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       LFTM           FP TRAP MODE TRGR SET
       TQO *+1        MQ INDICATOR OFF
       CLA NUM+5      CH 000 FR +000002000
       FAD NUM+6      CH 000 FR -100000000
       EFTM           TRIGGER NOW RESET
       TQO *+2        ACT AS NOP-NO TRA
       TRA *+3        OK
       SWT 2          ERROR
       HPR            TQO EXECUTED
       REM            
*MQ INDICATOR SHOULD REMAIN ON UNTIL FIRST E TIME INSTRUCTION
       REM            
       CLA            MQ INDICATOR OFF
       REM            
*CHECK MQ INDICATOR NOW OFF
       REM            
       LFTM           SET FP TRAP MODE TRGR
       TQO *+2        SHOULD NOT TRANSFER
       TRA *+3        PROCEED
       SWT 2          ERROR
       HPR            MQ INDICTOR ON
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A26        REPEAT
       REM            
       REM            
       SWT 5          TEST SENSE SWITCH 5
       TRA ALT        SKIP RESET AND LOAD
       REM            BUTTON TESTS
       SWT 3          IS PRINTER ON LINE
       TRA *+3        
       TRA A28X       TEST LOAD BUTTON ONLY
       REM            
       TRA A26        DUMMY INST FOR MONITOR
       REM            
       REM            
*CHECK RESET BUTTON RESTORES MACHINE TO 709 MODE-SEE SYSTEMS 2.07.76,4.08,AND
*4.09                 
       REM            
A27    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+18       L TRA AS27A
       STO            STORE IN LOCATION 00000
       REM            
*SET COMPATABILITY TRIGGGERS
       REM            
       ESNT *+1       
       ESTM           
       ECTM           
       LFTM           
       HPR            PUSH RESET BUTTON TO
       REM            RESET INSTR CTR TO 000000
       REM            
*ALL COMPATABILITY TRIGGERS SHOULD NOW BE RESET
*PUSH START           
       REM            
A27A   WPRA           SELECT PRINTER
       TRA *+4        OK-PROCEED
       NOP            
       SWT 2          ERROR
       HPR            CHECK IF I/O SENSE TRAP
       REM            MODE TRGR IS RESET
       REM            
       SPRA 3         
       TRA *+4        OK-PROCEED
       NOP            
       SWT 2          ERROR
       HPR            IF I/O SENSE TRAP TRGR
       REM            RESET. TRGR MF3 J16 03 ON
       REM            SYSTEMS 2.07.76 RESET
       REM            
       RCHA 16K+16    PRINT A LINE
       REM            
*IF THE PRINTER FAILS TO PRINT A LINE. IT IS AN INDICATOR THAT THE NULLIFY
*TRGR WAS NOT RESET WITH THE RESET BUTTON-SYSTEMS 4.08 AND 4.09, THE
*CONTROL WORD IS IN THE UPPER HALF OF STORAGE IN LOCATION 400017 AND
*THIS LOCATION SHOULD BE ACCESSIBLE.
       REM            
*CHECK COPY TRAP MODE TRIGGER IS RESET
       REM            
       CPY            SHOULD NOT TRAP
       TRA *+4        OK-PROCEED
       NOP            
       SWT 2          ERROR
       HPR            SEE COPY TRAP TRGR RESET
       REM            
*CHECK LOCATION 40000 
       REM            
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 40000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       REM            
*CHECK FLOATING POINT TRAP MODE TRIGGER RESET
       REM            
       CLA K+19       L TRA A27B
       STO 8          STORE IN LOCATION 00010
       CLA NUM+12     CH 001 FR +00777777
       FAD NUM+13     CH 004 FR +00444444
       SWT 2          ERROR
       HPR            IS FP TRAP MODE TRGR RESET
       REM            
A27B   CLA            L CONTENTS LOCATION 00000
       LDQ K+20       L FP LOC + 1 WITH BITS IN
       REM            DEC POSITIONS 16,17 AND
       REM            OP CODE 0000
       CAS K+20       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOC 00000 WRONG
       SWT 1          TEST SWITCH 1
       TRA A28        CONTINUE
       TRA A27        REPEAT
       REM            
       TRA A26        DUMMY INSTR FOR MONITOR
       REM            
A28X   AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       LXA *+3,1      L XRA WITH ADR OF INSTR
       SXD HOLD,1     PUT IN DEC OF LOC
       TRA A28        PROCEED
       REM            
       TRA A27        DUMMY INSTR FOR MONITOR
       REM            
       REM            
*CHECK LOAD TAPE BUTTON RESTORES MACHINE TO 709 MODE SEE SYSTEMS 2.07.76,4.08
*4.19 AND OUTPUTS FROM 4.19 TO VARIOUS PAGES CONCERNING LOAD CONTROL SEQUENC E
       REM            
A28    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA A27A+2     L NOP
       STO 3          STORE IN LOCATION 00003
       CLA K+21       L TRA A28A
       STO 4          STORE IN LOCATION 00004
       REM            
*WRITE 3 WORDS ON TAPE 
       REM            
       WTBA 1         SELECT TAPE CHAN A
       RCHA K+22      
       BSRA 1         BACKSPACE TAPE
       TCOA *         
       REM            
*SET COMPATABILITY TRIGGERS
       REM            
       ESNT *+1       
       ESTM           
       ECTM           
       LFTM           
       HPR            
       REM            
*PUSHING LOAD TAPE BUTTON, SHOULD RESET COMPATABILYTY TRGRS AND WRITE 3
*WORDS FROM TAPE INTO THE 3 INITIAL LOCATION OF STORAGE. THE FIRST 5
*STORAGE LOCATIONS SHOULD CONTAIN-
       REM            
*          00000     HTR
*          00001     RTBA 1
*          00002     TRA A28B
*          00003     NOP
*          00004     TRA A28A
       REM            
A28A   SWT 2          ERROR
       HPR            RTBA 1 TRAPPED
       REM            
*CHECK NULLIFY TRIGGER NOW RESET
       REM            
A28B   TSX 16K+15,2   SHOULD TRA LOC 40016
       TRA *+3        TRANSFERED OK
       SWT 2          ERROR
       HPR            ISNULLIFY TRGR RESET
       REM            
*CHECK COPY MODE TRIGGER NOW RESET
       REM            
       CPY            
       TRA *+4        OK-PROCEED
       NOP            
       SWT 2          ERROR
       HPR            IS CPY TRAP TRGR RESET
       REM            
*CHECK LOCATION 40000 
       REM            
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 40000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       REM            
*CHECK FLOATING POINT TRAP TRIGGER RESET
       REM            
       CLA K+26       L TRA A28C
       STO 8          STORE IN LOCATION 00010
       CLA NUM+12     CH 001 FR +00777777
       FAD NUM+13     CH 004 FR +00444444
       SWT 2          ERROR
       HPR            IS FP TRAP MODE TRGR RESET
       REM            
A28C   CLA            L CONTENTS LOC 00000
       LDQ K+27       L FP LOC+1 WITH BITS IN
       REM            DEC POSITIONS 16,17 AND
       REM            OP CODE 0000
       CAS K+27       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OK
       SWT 2          ERROR
       HPR            CONTENTS LOC 00000 WRONG
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A28        REPEAT
       REM            
*SINCE THE POSSIBILITY EXISTS THAT NULLIFICATION MODE MIGHT INTERFERE
*WITH THE HIGH ORDER INDEX REGISTER POSITION WITH A TSX INSTRUCTION
*DURING THE EXECUTION OF COMPATABILITY TEST. NOW TRANSFER OUT TO
*8DEPR TO TEST SENSE SWITCH 4 AND DETERMINE WHETHER TO REPEAT ENTIRE
*COMPATABILITY TEST 50 OCTAL TIMES FOR RELIABILITY.
       REM            
       LSNM           EXIT NULLIFY MODE
       TSX RELY,4     TRA TO 9DEPR AND WITH
       REM            SENSE SWITCH 4 DOWN, RETURN
       TRA AZ         TO THIS INSTRUCTION AND
       REM            REPEAT ENTIRE COMPATABILITY 
       REM            SECTION 50 OCTAL TIMES
       REM            
       NOP            
       TRA ALT        SWITCH 4 UP-PROCEED
       REM            
       REM            
*INSTRUCTIONS FOR LOWEST LOCATIONS IN UPPER HALF OF STORAGE
       REM            
TRAP   TTR 16K+4      TRA LOC 40003
       TTR 16K+4      
       CLA 16K+1      L CONTENTS LOC 40000
       ADD NUM+2      L +2
       STA 16K+7      ADR TO LOC 40006
       TTR            
       TRA AZA        
       STR            
       TRA AA-2       
       TRA AB         
       TRA A1A        
       TRA A2A        
       TRA A3A-2      
       TRA 1,2        
       IOCD RE,0,24   
       REM            
       REM
*COMPREHENSIVE TEST FOR EXECUTE INSTRUCTION
       REM            
ALT    SWT 5          IS SWITCH 5 UP
       TRA EX         YES
       HTR EXX        NO
       REM            
*IF RESET AND LOAD TAPE BUTTONS TESTS ARE NOT TO BE REPEATED.
*PUT SENSE SWITCH 5 UP 
       REM            
       TRA A28        DUMMY INSTRUCTION
       REM            
       NOP            
       REM            
       REM            
EXX    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       LXA *+3,1      L XRA WITH ADR OF INSTR
       SXD HOLD,1     PUT IN DEC OF LOC
       TRA EX         
       REM            
       TRA A26        DUMMY INSTRUCTION
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE CASUSE 709
       REM            TO TAKE NEXT INSTR FROM
       REM            EXECUTE ADR,PERFORM THAT
       REM            INSTR AND RETURN TO EXE-
       REM            CUTE INSTRUCTION PLUS 1
       REM            
EX     AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA NUM        CLEAR ACC
       REM            
*WITH EXECUTE INSTRUCTION. PERFORM ALL I TIME OPERATIONS EXCEPT AT I 11,
*SUPPRESS INSTRUCTION COUNTER ADVANCE-SEE SYSTEMS SHEET 2-3.10.01,
*3.20.02 AND 3.20.    
       REM            
       XEC *+2        
       TRA *+4        
       REM            
*AT I 11 TIME OF NEXT INSTRUCTION, ADVANCE INSTRUCTION COUNTER IN
*ORDER TO RETURN TO EXECUTE INSTRUCTION PLUS 1 AFTER PERFORMING THE
*E TIME OPERATION OF THE INSTRUCTION.
       REM            
       CLS NUM        L -0
       TSX ERROR-1,4  FAILED TO RETURN TO
       REM            EXECUTE INSTR PLUS 1
       TXL EX         
       REM            
       REM TEST FOR MINUS SIGN IN ACC
       REM            
       TMI *+2        OK-ACC SIGN MINUS
       TSX ERROR,4    ERROR-ACC SIGN PLS
       TSX OK,4       
       TRA EX         
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE TO TRANSFER 
       REM            DOES NOT RETURN TO
       REM            EXECUTE PLUS 1
       REM
EXA    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       XEC *+4        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TRA
       REM            INSTR AND TRANSFER
       TXL EXA        
       REM            
       TRA EXN        GO TO NEXT TEST IF ERROR
       REM            
*EXECUTING TO A TRA INSTRUCTION, THE ADR SIWTCHES, WHICH CONTAIN THE
*ADDRESS IN THE TRANFER INSTRUCTION, GO TO THE ADDRESS REGISTER AT
*ER 10, THE INSTRUCTION COUNTER IS RESET AT THE NEXT I2 TIME. THE
*ADDRESS REGISTER GOES TO THE STORAGE ADDRESS REGISTER FOR THE NEXT
*INSTRUCTION AND AT I3 TIME. THE ADDRESS REGISTER IS SET INTO THE
*INSTRUCTION COUNTER PREVENTING A RETURN TO EXECUTE INSTRUCTION PLUS
*1-SYSTEMS 3.40, 3.20.02 AND 1.05.03.
       REM            
       TRA *+1        CAME FROM EXECUTE
       TSX OK,4       OK AND CONTINUE
       TRA EXA        
       REM            
       REM            
       BCD 1XEC       TEST NZT PRI OP 5.2 DOES
       REM            NOT PERFORM AS EXECUTE
       REM            
EXN    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       PXA            CLEAR ACC
       REM            
*WITH A NZT INSTRUCTION AND CIRCUIT MF3 J35 A SYSTEMS PAGE 3.20.02
*SHOULD NOT BE CONDITIONED WITH INPUT LINE INSTR REG 8 DOWN.
*MINUS ON EXECUTE LINE SHOULD BE UP AND NZT SHOULD PERFORM AS
*A SKIP INSTRUCTION.  
       REM            
       NZT *+3        
       TRA *+3        ERROR-SHOULD NOT HIT
       REM            THIS INSTRUCTION
       TRA *+4        NZT SKIPPED OK
       REM            
       CLA NUM+1      
       REM            
       TSX ERROR-1,4  
       TXL EXN        
       REM            
       TZE *+2        ACC SHOULD BE ZERO
       TSX ERROR,4    
       TSX OK,4       
       TRA EXN        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXI
       REM            
EXB    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       AXT 6,2        L 6 IN XRB
       XEC *+4        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TXI
       TXL EXB        INSTRUCTION AND TRANSFER
       REM            
       TRA EXC        GO TO NEXT TEST IF ERROR
       REM            
       TXI *+1,2,1    INCREMENT XRB WITH ONE
       REM            AND PROCEED TO NEXT INSTR
       PXA 0,2        XRB TO ADR OF ACC
       LDQ K0+1       L +7
       CAS K0+1       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    
       TSX OK,4       
       TRA EXB        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXL
       REM            WITH XR LOW
       REM            
EXC    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       AXT 0,2        CLEAR XRB
       XEC *+4        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TXL
       TXL EXC        INSTRUCTION AND TRANSFER 
       REM            
       TRA EXD        
       REM            
*IF THE CONDITION IS MET IN A CONDITIONAL TRANSFER, PROCEED AS IN A
*TRANSFER INSTRUCTION. IF CONDITION IS NOT MET, RETURN TO EXECUTE
*INSTRUCTION PLUS 1.  
       REM            
       TXL *+3,2,1    SHOULD TRANSFER
       TSX ERROR-1,4  ERROR-DID NOT TRANSFER
       TRA EXC        
       REM            
EXD    XEC *+4        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TXL
       TXL EXC        INSTRUCTION AND TRANSFER
       REM            
       TRA EXF        GO TO NEXT TEST IF ERROR
       REM            
       TXL *+2,2,0    CONDITION MET-TRANSFER
       TSX ERROR,4    ERROR-DID NO TRANSFER
       TSX OK,4       
       TRA EXC        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXL
       REM            WITH XR HIGH
       REM            
EXF    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA NUM        CLEAR ACC
       AXT 1,2        L 1 IN XRB
       XEC *+3        
       CLS NUM        L -0
       TRA *+4        
       REM            
       TXL *+1,2,0    CONDITION NOT MET-GO
       REM            BACK TO EXECUTE PLUS 1
       REM            
       TSX ERROR-1,4  FAILED TO RETURN TO
       TXL EXF        EXECUTE INSTR PLUS 1
       REM            
       TMI *+2        SHOULD TRANSFER
       TSX ERROR,4    ERROR-ACC PLUS
       TSX OK,4       
       TRA EXF        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXH
       REM            WITH XR HIGH
       REM            
EXG    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       AXT 1,2        L 1 IN XRB
       XEC *+4        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TXH
       TXL EXG        INSTRUCTION AND TRANSFER
       REM            
       TRA EXH        GO TO NEXT TEST IF ERROR
       REM
       TXH *+2,2,0    CONDITION MET-TRANSFER
       TSX ERROR,4    
       TSX OK,4       
       TRA EXG        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXH
       REM            WITH XR LOW
       REM            
EXH    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       AXT 0,2        CLEAR XRA
       CLA NUM        CLEAR ACC
       XEC *+3        
       CLS NUM        L -0
       TRA *+4        
       REM            
       TXH *+1,2,0    CONDITION NOT MET-GO
       REM            BACK TO EXECUTE PLUS 1
       REM            
       TSX ERROR-1,4  FAILED TO RETURN TO
       TXL EXH        EXECUTE INSTR PLUS
       REM            
       TMI *+2        SHOULD TRANSFER
       TSX ERROR,4    ERROR-ACC PLUS
       TSX OK,4       
       TRA EXH        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE WITH TIX
       REM            
EXI    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       AXT 1,2        L 1 IN XRB
       XEC *+4        
       TSX ERROR-1,4  ERROR-SHULD GO TO TIX
       TXL EXI        INSTRUCTION AND TRANSFER
       REM            
       TRA EXJ        GO TO NEXT TEST IF ERROR
       REM            
       TIX *+3,2,0    NO ADDER X CARRY-TRANSFER
       REM            AND REDUCE XRB TO ZERO
       REM            
       TSX ERROR-1,4  ERROR-DID NOT TRANSFER
       TRA EXI        
       REM            
EXJ    CLA NUM        CLEAR ACC
       XEC *+3        
       CLS NUM        L -0
       TRA *+4        
       TIX *+1,2,1    ADDER X CARRY-RETURN
       REM            TO EXECUTE INSTR PLUS 1
       REM            
       TSX ERROR-1,4  FAILED TO RETURN TO
       TXL EXI        EXECUTE INSTR PLUS 1
       REM            
       TMI *+2        SHOULD TRANSFER
       TSX ERROR,4    ERROR-ACC PLUS
       TSX OK,4       
       TRA EXI        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE WITH TSX
       REM            
EXK    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       TRA SUB+12     
       REM            
       REM EXECUTE-TSX SUBROUTINE
       REM            
       REM CHECK 2 S COMPLEMENT OF EXECUTE
       REM INSTR AND NOT TSX INSTR IN XRB
       REM            
SUB    PXA 0,2        XRB TO ACCUMULATOR
       PAC 0,2        COMPLEMENT ACC TO XRB
       PXA 0,2        XRB TO ACC
       PAC 0,2        RECOMPLEMNET ACC TO XRB
       LDQ K1+4       L HTR EXK1 IN MQ
       CAS K1+4       
       TRA *+2        ERROR
       TRA *+4        OK-2 S COM EXK IN XRA
       TSX ERROR-1,4  
       TRA EXK        
       REM            
       TRA EXL        GO TO NEXT TEST IF ERROR
       REM            
       TRA 4,2        RETURN TO EXK PLUS 4
       REM            
*AT I 11 TIME OF PERFORMING THE INSTRUCTION THAT WAS IN THE ADDRESS OF
*EXECUTE, THE INSTRUCTION COUNTER IS NORMALLY ADVANCED. WITH A TSX
*INSTRUCTION, INSTRUCTION COUNTER ADVANCE IS BLOCKED AGAIN AT I 11 AND
*SO THE LOCATION OF THE EXECUTE INSTRCUTION IS SITTING IN THE
*INSTRUCTION COUNTER. THEREFORE THE 2-S COMPLEMENT OF THE EXECUTE
*INSTRUCTION IS OBTAINED IN THE INDEX REGISTER WHEN THE INSTRUCTION
*COUNTER IS ROUTED TO THE INDEX REGISTER AND CYCLED.
       REM            
EXK1   XEC *+5        
       TSX ERROR-1,4  ERROR-RETURNED TO
       TXL EXK        EXECUTE INSTR PLUS 1
       REM            
       TRA EXL        GO TO NEXT TEST IF ERROR
       REM            
       TRA *+6        RETURN FROM SUBROUTINE
       REM            
       TSX SUB,2      OUT TO SUBROUTINE
       REM            
       NOP            
       NOP            
       NOP            
       TSX ERROR,4    ERROR-FAILED TO RETURN
       REM            TO EXK PLUS 4
       TSX OK,4       
       TRA EXK        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE WITH CAS
       REM            
EXL    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA NUM+7      L +200777770000
       LDQ NUM+7      
       XEC *+4        
       TRA *+9        ERROR IN COMPARISON
       TRA *+9        OK
       TRA *+7        ERROR IN COMPARISON
       CAS NUM+7      
       TRA *+2        ERROR-DID NOT RETURN
       TRA *+1        TO EXECUTE INSTR PLUS 1
       TSX ERROR-1,4  2 OR 3 AFTER CAS
       TXL EXL        
       REM            
       TRA *+5        GO TO NEXT TEST IF ERROR
       REM            
       TSX ERROR,4    
       TSX OK,4       
       TRA EXL        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE INDEXABLE
       REM            
EX1    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       AXT 4,2        L 4 IN XRB
       CLS NUM        L -0
       XEC *+6,2      SHOULD GO TO EX1+6
       TRA *+8        
       CLA NUM        
       TSX ERROR-1,4  FAILED TO RETURN
       REM            TO EXECUTE PLUS 1
       TXL EX1        
       REM            
       TRA EX2        GO TO NEXT TEST IF ERROR
       REM            
       TSX ERROR-1,4  FAILED TO MODIFY ADR
       TRA EX1        
       REM            
       TRA EX2        GO TO NEXT TEST IF ERROR
       REM            
       REM TEST ACCUMULATOR SIGN
       REM            
       TPL *+2        OK-ACC SIGN PLUS
       TSX ERROR,4    
       TSX OK,4       
       TRA EX1        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE INDIRECT
       REM            ADDRESSABLE
       REM            
EX2    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       XEC* EX2A      
       REM            
*SET IA CONTROL TRIGGER AND TAKE AN E TIME-SYSTEMS 2.08.61. ACCUMULATOR
*SHOULD BE -377777737777 AFTER INSTRUCTION COUNTER IS ADVANCED TO
*RETURN TO THE FOLLOWING INSTRUCTION. IF THE IA XEC INSTRUCTION IS
*PERFORMED CORRECTLY, ACCUMLATOR AND MQ SHOULD BE THE SAME.
       REM            
       LDQ NUM+15     
       CAS NUM+15     
       TRA *+2        
       TRA EX2B+2     IF XEC OF
       TSX ERROR-1,4  IF CONTENTS EX2A IS IN ACC.
       REM            SEE IF IA CTRL TRGR WAS SET
       TRA EX2        
       REM            
       TRA EX3        GO TO NEXT INSTR IF ERROR
       REM            
EX2A   CLA EX2B       DO NOT PERFORM INSTR
       REM            USE ADR PORTION ONLY
       TSX ERROR-1,4  ERROR-PERFORMED ABOVE
       REM            INSTR AND CONTINUED
       TRA EX2        
       REM            
       TRA EX3        GO TO NEXT TEST IF ERROR
       REM            
EX2B   CLA NUM+15     PERFORM THIS INSTR AND
       REM            RETURN TO EX2+3
       TSX ERROR,4    DID NOT RETURN TO EX2+3
       TSX OK,4       
       TRA EX2        
       REM            
       REM            
       BCD 1XEC       TEST SUCCESSIVE EXECUTES
       REM            
EX3    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA NUM+1      L +1
       XEC *+1        NO IC ADVANCE
       XEC *+1        NO IC ADVANCE
       XEC *+1        NO IC ADVANCE
       XEC *+1        NO IC ADVANCE
       XEC *+1        NO IC ADVANCE
       ADD NUM+1      ADVANCE IC
       LDQ K0+1       L +7
       CAS K0+1       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    ERROR-CHECK IC ADVANCE
       REM            SYSTEMS 3.20.02 AND 3.20
       TSX OK,4       
       TRA EX3        
       REM
       REM
       BCD 1XEC       TEST EXECUTE WITH I/O
       REM            
*NOTE-IF E.C. 34719 HAS NOT BEEN INSTALLED. THERE WILL BE A DATA SELECT
*HANGUP IN THIS SECTION OF THE PROGRAM. MANUALLY INSERT A TRA 00460
*AT LOCATION 00451 UNTIL THE E.C. HAS BEEN INSTALLED.
       REM            
EX4    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       AXT 24,2       L 30 IN XRB
       STZ IM+24,2    CLEAR STORAGE
       TIX *-1,2,1    READ-IN AREA
       XEC EX4K       GO TO END OF TAPE TEST
       REM            NO IC ADVANCE
       TRA EX4K+3     END OF TAPE IND ON
       TRA EX4A+3     END OF TAPE IND OFF
       REM            
*ROUTINE FOR TESTING END OF TAPE
       REM            
EX4K   ETTA           CHECK END OF TAPE IND AND
       REM            RETURN TO EX4+5 OR EX4+7
       TSX ERROR-1,4  FAILED TO RETURN TO
       REM            EX4+6 OR EX4+7
       TXL EX4        
       REM            
       XEC EX4A       GO TO REWIND TAPE
       REM            ONLY IF AT END OF TAPE
       REM            NO IC ADVANCE
       TRA EX4A+3     PROCEED
       REM            
*ROUTINE FOR REWINDING TAPE
       REM            
EX4A   REWA 1         REWIND TAPE 1 ON CHAN A
       REM            AND RETURN TO EX4A-1
       TSX ERROR-1,4  FAILED TO RETURN TO EX4A-1
       TXL EX4        
       REM            
       XEC EX4B       GO TO SELECT TAPE
       REM            NO IC ADVANCE
       TRA EX4B+3     PROCEED
       REM            
*ROUTINE FOR SELECTING TAPE
       REM            
EX4B   WTBA 1         SELECT TAPE ON CHAN A
       TSX ERROR-1,4  FAILED TO RETURN TO EX4B-1
       TXL EX4        
       REM            
       XEC EX4C       GO FOR CONTROL WORD
       REM            NO IC ADVANCE
       TRA EX4C+3     PROCEED
       REM            
*ROUTINE FOR OBTAINING CONTROL WORD
       REM            
EX4C   RCHA WO        WRITE A 24 WORD RECORD
       TSX ERROR-1,4  FAILED TO RETURN TO EX4C-1
       TXL EX4        
       REM            
*CHECK IOT LIGHT
       REM
       IOT            IS IOT LIGHT ON
       TRA *+2        YES-ERROR
       TRA *+3        NO-PROCEED
       TSX ERROR-1,4  ERROR-LITE SHOULD BE OFF
       TXL EX4        
       REM            
       XEC EX4D       GO TO BKSP TAPE
       REM            NO IC ADVANCE
       TRA EX4D+3     PROCEED
       REM            
*ROUTINE TO BACKSPACE THE RECORD WRITTEN
       REM            
EX4D   BSRA 1         BACKSPACE TAPE 1 CHAN A
       TSX ERROR-1,4  FAILED TO RETURN TO EX4D-1
       TXL EX4        
       REM            
       XEC EX4F       GO TO READ TAPE
       REM            NO IC ADVANCE
       TRA EX4F+3     PROCEED
       REM            
*ROUTINE TO READ RECORD ON TAPE
       REM            
EX4F   RTBA 1         READ TAPE 1 CHAN A
       TSX ERROR-1,4  FAILED TO RETURN TO EX4F-1
       TXL EX4        
       REM            
       XEC EX4G       GO FOR CONTROL WORD
       REM            NO IC ADVANCE
       TRA EX4G+3     PROCEED
       REM            
*ROUTINE FOR OBTAINING CONTROL WORD
       REM            
EX4G   RCHA WO1       READ 24 WORDS FROM TAPE
       TSX ERROR-1,4  FAILED TO RETURN TO EX4G-1
       TXL EX4        
       REM            
       TCOA *         READ ENTIRE RECORD
       REM            
*CHECK IOT LIGHT      
       REM            
       IOT            IS IOT LIGHT ON
       TRA *+2        YES-ERROR
       TRA *+3        NO-PROCEED
       TSX ERROR-1,4  ERROR-LITE SHOULD BE OFF
       TXL EX4        
       REM            
       XEC EX4H       GO TO WRITE AN EOF
       REM            NO IC ADVANCE
       TRA EX4H+3     PROCEED
       REM            
*ROUTINE FOR WRITING AN END OF FILE
       REM            
EX4H   WEFA 1         WRITE EOF TAPE 1 CHAN A
       TSX ERROR-1,4  FAILED TO RETURN TO EX4H-1
       TXL EX4        
       REM            
*CHECK RECORD WRITTEN AND READ CORRECTLY
       REM            
       AXT 0,2        CLEAR XRB
       PXA 0,2        XRB TO ACC
       ADD NUM+1      ACC NOW 1
       STO RECNO      
       AXT 24,1       L 300 IN XRA
       PXA 0,1        XRA TO ACC
       ADD NUM+1      ACC NOW 31
       STO WDNO       
REC    CLA IM+24,1    WORD READ FROM TAPE
       LDQ EX+24,1    WORD THAT SHOULD HAVE
       REM            BEEN WRITTEN ON TAPE
       CAS EX+24,1    
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-2,4  ERROR IN COMPARISON
       NOP EX4        
       REM            
       TRA EX5        GO TO NEXT TEST IF ERROR
       REM            
       TIX REC,1,1    CHECK NEXT WORD IN RECORD
       TSX OK,4       
       TRA EX4        
       REM            
       REM            
       BCD 1XEC       TEST EXECUTE UNDER
       REM            SENSE SWITCH CONTROL
EX5    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       XEC EX6        
       TRA CRSL       SENSE SWITCH 6 UP
       TRA BAR        SENSE SWITCH 6 DOWN
       REM            
EX6    SWT 6          TEST SENSE SWITCH 6
       TRA *+1        FAILED TO RETURN TO
       TSX ERROR-1,4  EX5 PLUS 3 OR 4 AS PER
       TXL EX5        SENSE SWITCH 6 SETTING
       REM            
BAR    CLA TOP        COUNT OF 100 DECIMAL
       SUB NUM+1      L +1
       STO TOP        STORE IN COUNT
       TNZ AZ         REPEAT TEST TIL COUNT ZERO
       CLA TOP+1      RESET
       STO TOP        COUNTER
       REM            
       SWT 3          TEST SENSE SWITCH 3
       TRA *+2        PRINT 100 PASSES COMPLETE
       TRA AZ         RETURN TO START ADDRESS
       REM            
*ROUTINE TO PRINT 100 PROGRAM PASSES COMPLETE
       REM            
       AXT 11,2       L 13 IN XRB
       WPRA           SELECT PRINTER
       SPRA 3         SPACE PRINTER
       RCHA CWD+2     
       LCHA CWD+6     
BOY    LCHA CWD+3     
       LCHA CWD+6     
       CLA CWD+3      
       SUB NUM+2      L +2
       STA CWD+3      
       TIX BOY,2,1    
       CLA CWD+4      
       STO CWD+3      
       TRA AZ         RETURN TO START ADDRESS
       REM            
TOP    OCT 144        
       OCT 144        
       OCT 0          
       REM            
CRSL   RCDA           LOAD
       RCHA CWD+5     THE
       LCHA 0         NEXT
       TRA 1          PROGRAM
       REM            
*ROUTINE TO PRINT PROGRAM IDENTIFICATION
       REM            
TITLE  AXT 11,1       L 13 IN XRA
       WPRA           SELECT PRINTER
       SPRA 3         SPACE PRINTER
       RCHA CWD       
       LCHA CWD+6     
       LCHA CWD+1     
       LCHA CWD+6     
       CLA CWD+1      
       SUB NUM+2      L +2
       STA CWD+1      
       TIX *-5,1,1    
       TRA ADJ-3      
       REM            
*CHECK IF PROGRAM IS IN COMPATABILITY OR EXECUTE SECTION AND
*ADJUST LOCATION COR ACCORDINGLY
       REM            
MONIT  PXA            CLEAR ACCUMULATOR
       PXA 0,1        XRA TO ADR OF ACC
       SXA *+3,1      XRA TO ARD OF LOC
       CAS K1+9       COMPARE ACC WITH HTR ALT
       TRA *+8        TEST IS IN EXECUTE SECTION
       HTR            NEVER EQUAL-TRY AGAIN
       CLA K1+5       TEST IS IN COMPATABILITY
       REM            SECTION-L HTR NUM+1
       STA COR        ACC TO ADR OF LOC
       STA RECT       
       CLA NUM+1      L +1
       STO LADR+1     STORE IN LOCATION
       TRA *+5        
       REM            
*ADJUST MONITOR FOR EXECUTE ROUTINES
       REM            
       CLA K1+6       L HTR NUM+2
       STA COR        ACC TO ADR OF LOC
       STA RECT       
       STZ LADR+1     CLEAR LOCATION
       REM            
*PROGRAM MONITOR      
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        WILL NO REPEAT TEST
       TRA *+5        REPEAT TEST
       ZET LADR+1     IS TEST IN COMPATABILITY
       REM            SECTION OR EXECUTE SECTION
       TRA *+6        COMPATABILITY SECTION
       REM            DO NOT TEST SWITCH 4
       SWT 4          EXECUTE SECTION
       REM            TEST SWITCH 4
       TRA *+4        WILL NOT REPEAT TEST
       REM            50 OCTAL TIMES
       REM            
*CHECK XRA IF TEST IS TO BE REPEATED
       REM            
       PXD 0,1        XRA TO DEC OF ACC
       SUB HOLD       START ADR TEST LOC
       TZE RESET      PROGRAM SEQUENCE OK
       REM            
*CHECK PROGRAM SEQUENCE IF TEST IS NOT TO BE REPEATED
       REM            
       PXA 0,1        XRA TO ACC ADR
COR    SUB NUM+1      L +1 OR +2
       STA *+3        PUT THIS ADR BELOW
       STZ HOLD+1     CLEAR LOCATION
       SXD HOLD+1,1   XRA TO DEC OF WORD
       CLA            L LOC-1 TEST ENTERED
       ALS 18         ADR TO DEC OF ACC
       SUB HOLD       INTIAL ADR PREVIOUS TEST
       TZE RESET      PROGRAM SEQUENCE OK
       REM            
*IF PROGRAM SEQUENCE WRONG, CHECK FOR TRA INSTRUCTION ION KEYS
       REM            
       ENK            KEYS TO MQ
       XCA            MQ TO ACC
       PAX 0,1        ACC ADR TO XRA
       ARS 18         SHIFT TO ACC ADR
       SUB NUM+5      L 0200
       TNZ *+5        SHOULD BE ZERO
       PXD 0,1        XRA TO DEC OF ACC
       SUB HOLD+1     SAVED ADR
       LXD HOLD+1,1   RESTORE XRA
       TZE RESET      SHOULD BE ZERO
       REM            
       LXD HOLD+1,1   RESTORE XRA
       PXD 0,1        XRA TO DEC TO ACC
       TRA SPACE+11   
       REM            
RESET  SXD HOLD,1     SAVE XRA IN DEC OF WORD
       TXI *+1,1,2    ADD 2 TO XRA FOR RETURN
       REM            TO MAIN PROGRAM
       SXA BACK,1     PUT XRA IN ADR OF BACK
       LSNM           IF SET. RESET THE
       REM            NULLIFY TRGR TO
       STZ 16K+1      CLEAR LOCATION 40000
       LDQ NUM        CLEAR MQ
       TOV *+1        ACC INDICATOR OFF
       NOP            
       DCT            DIV CHECK IND OFF
       NOP            
       IOT            IOT LIGHT OFF
       NOP            
       TRCA *+1       REDUNDANCY LITE OFF
       CLA A20A-3     L STR
       STO            STORE IN LOC 00000
       STO 1          STORE IN LOCATION 00001
       SLT 1          TEST SENSE LIGHT 1
       TRA *+4        SENSE LIGHT 1 OFF
       REM            
*NEXT 3 INSTRUCTIONS SHOULD ONLY BE REACHED ON THE INITIAL PASS TO
*STORE STR INSTRUCTION FROM STGB THRU STGB+5
       REM            
       AXT 6,1        L 6 IN XRA
       STO STGB+6,1   
       TIX *-1,1,1    
       REM            
*STORE STR INSTRUCTION FROM LOCATIONS 00004 THRU 00015
       REM            
       AXT 10,1       L 12 IN XRA
       STO 14,1       
       TIX *-1,1,1    
       CLA K1+7       L TRA SPACE
       STO 2          RESTORE LOC 00002
       PXD            CLEAR ACCUMULATOR
       AXT 0,7        CLEAR ALL INDEX REGISTERS
BACK   TRA            
       REM            
SPACE  NZT LADR+1     IS PROGRAM IN THE
       REM            COMPATABILITY SECTION
       TRA *+7        NO
       LSNM           EXIT NULLIFY MODE
       CLA 16K+7      L CONTENTS LOC 40006
       SUB K1+8       L TTR 24
       TNZ *+3        
       CLA NUM+2      L +2
       TRA *+3        
       CAL            L CONTENTS LOCATION 00000
       SUB NUM+1      L +1
       ALS 18         SHIFT TO DEC OF ACC
       STZ HOLD+2     CLEAR LOCATION
       STD HOLD+2     SAVE IN DEC OF WORD
       LXD HOLD,1     DEC OF WORD TO XRA
       SXA HOLD+2,1   SAVE IN ADR OF WORD
       SXA RECT-1,1   XRA TO ADR OF INSTR
       SXA RECT+5,1   
       CLA HOLD+2     
       LDQ NUM        CLEAR MQ
       HPR            TRANSFER OUT OF CONTROL
       REM            
*ADR FROM WHICH CONTROL WAS RECOVERED IS IN DECREMENT AND STARTING
*ADDRESS OF TEST WHICH WAS UNDERWAY IS IN ADR OF ACCUMULATOR
       REM            
*00002 IN THE DECREMENT INDICATORS THE PROGRAM TRAPPED TO LOCATION
*40001 FOR A SENSE OR SELECT INSTRUCTION OR 40002 FOR A COPY
*INSTRUCTION BUT FAILED TO STORE THE LOCATION OF A TRAP INSTRUCTION
*PLUS 1 IN THE ADDRESS PORTION OF 40000.
       REM            
       ALS 18         ACC ADR TO DEC
       SUB K1+12      L HTR 0.0.AZ
       TZE AZ         IF IN INITIAL PROGRAM
       REM            TEST, RETURN TO IT
       CLA            L LOC OF TEST UNDERWAY
RECT   SUB NUM+1      L 1 OR 2
       STA *+1        
       CLA            
       ALS 18         SHIFT TO DECREMENT
       STD HOLD       
       TRA            RETURN TO TEST THAT 
       REM            WAS UNDERWAY
       REM            
* SENSE SWITCHES INTERROGATION AND DIAGNOSTIC
*              PRINT SUBROUTINE FOR 709
       REM            
       REM 9DEPR      
       REM            
       STZ KONST+3  INDICATE I/O TYPE PRINT
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
       REM          PUT DSC REDUNDANCY
       REM          CHECKS IN PRINT RECORD
RDNCK  STO STOR     ACC CONTENTS
       ARS 35         
       SLW STOR+3   OVFL BITS P + Q
       STQ STOR+1   MQ CONTENTS
       REM            
       CAL MASK+9   RESET RECORD IMAGE
       ANS REC4R+9  INDICATIONS
       CAL BIT2+3     
       SLW REC4R+8  FOR REDUNDANCY TAPE CK
       SLW KONST+7  PUT A BIT IN WORD
       TCOA *       CHECK CHAN IN OPERATION
       TCOB *       CHECK CHAN IN OPERATION
       TCOC *       CHECK CHAN IN OPERATION
       TCOD *       CHECK CHAN IN OPERATION
       TCOE *       CHECK CHAN IN OPERATION
       TCOF *       CHECK CHAN IN OPERATION
CHK4A  CAL BIT+10     
       ARS 1          
       TRCA CHK4B-1 REDUNDANT TAPE CK DSCA
       ORS REC4R+9  NO 
       TRA CHK4B      
       ORS REC4R+8  YES
       REM            
CHK4B  CAL BIT2+1     
       ARS 1          
       TRCB CHK4C-1 RND TAPE CK DSC-B
       ORS REC4R+9  NO 
       TRA CHK4C      
       ORS REC4R+8  YES
       REM            
CHK4C  CAL BIT+1      
       ARS 3          
       TRCC CHK4D-1 RND TAPE CK DSC-C
       ORS REC4R+9  NO 
       TRA CHK4D      
       ORS REC4R+8  YES
       REM            
CHK4D  CAL BIT+8      
       ARS 1          
       TRCD CHK4E-1 RND TAPE CK DSC-D
       ORS REC4R+9  NO 
       TRA CHK4E      
       ORS REC4R+8  YES
       REM            
CHK4E  CAL BIT+9      
       ARS 1          
       TRCE CHK4F-1 RND TAPE CK DSC-E
       ORS REC4R+9  NO 
       TRA CHK4F      
       ORS REC4R+8  YES
       REM            
CHK4F  CAL STOR+7     
       TRCF CHK4F+4 RND TAPE CK DSC-F
       ORS REC4R+9  NO 
       TRA CHK4F+5    
       ORS REC4R+8  YES
       REM            
       REM          WAS THERE A REDUNDANCY
       CLA REC4R+8  TAPE CHECK ON ANY CHAN
       SUB BIT2+3   IF NOT-RETURN TO MAIN
       TZE CONT     PROGRAM-OK
       REM            
       STZ KONST+7    
CONT   CLA STOR+3   RESET REGISTERS
       LDQ STOR       
       LLS 35         
       LDQ STOR+1     
       REM            
       ZET KONST+7    
       TRA 2,4      CONTINUE PROG
       REM          TAPE CHECK REDUNDANCY
       TRA ERROR-2  INTERROGATE SENSE
       REM          SWITCHES
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
CHK1   CLA STOR+5   L 100000
       DCT          DIV CK TEST
       ORS STOR+3   YES
       ARS 3          
       TNO CHK4-1   ACC OV FL-YES
       ORS STOR+3   NO 
       REM            
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
       TRA TRAPS    YES- INDICATES A TRAP
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
       REM            
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
       CAL STOR+7    BIT IN 35
       ORS REC3L+9,4  INDICATE DIV CK
       REM            
       TSX CH21,2     
       REM            
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
       CAL REC4R+12,4 TAPE CHECK INDICATORS
       SLW PR+25,1    
       ZET KONST+7    
       STZ PR+25,1    
       TIX *+1,4,1    
       TIX CH34+2,1,2 
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
       REM            
       REM            
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
CH49   LXA LOC+4,1   L +30
       STZ PR+24,1    
       TIX *-1,1,1    
       REM            
       CAL STOR      WORD READ
CH50   SLW PR+17      
       COM            
       SLW PR+19      
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
TRAPS  STO LOC+3      
       TRA CHK7A      
       REM            
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
REC3R  OCT 0,-400040000000,0
       OCT 5000000000,2000000000,0
       OCT -460440000000,0
       PON            
       OCT -402040000000
       OCT 4400000000,161000000000
REC4L  OCT -0,1040000,0,0
       OCT 200000100000,100000000000
       OCT 1000000,40000220000,0
       OCT 40001060000,200000200000
       OCT -500000100000
REC4R  OCT 0,400002104210
       OCT 40000000000,4
       OCT 20000000100,500002000
       OCT -604002144210,2201000000
       OCT 100020000000,-600302104210
       OCT 043000000000,124521042104
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
       OCT -777670000000
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
       REM            
       REM 9DEPR PRINT IMAGE AREA
       REM            
PR     OCT 0,0,0,0,0,0,0,0,0,0,0,0
       OCT 0,0,0,0,0,0,0,0,0,0,0,0
       REM            
       REM            
*PRINT IMAGES FOR PROGRAM IDENTIFICATION AND 100 PASSES COMPLETE
       REM            
PR1    OCT 1120402200      9 L
       OCT 440000010       9 R
       OCT 0               8 L
       OCT 0               8 R
       OCT 4004100000      7 L
       OCT 1102001000      7 R
       OCT 60600020040     6 L
       OCT 200004002       6 R
       OCT 102010040000    5 L
       OCT 100240          5 R
       OCT 41000020        4 L
       OCT 10002001        4 R
       OCT 5100            3 L
       OCT 10504           3 R
       OCT 10000           2 L
       OCT 640000          2 R
       OCT 200000          1 L
       OCT 20021000000     1 R
       OCT 20000014000     0 L
       OCT 14000640100     0 R
       OCT 145350060060    11L
       OCT 1652007403      11R
       OCT 2425703100      12L
       OCT 121110244       12R
       REM            
*PRINT IMAGE FOR CHECKING RESET BUTTON IN COMPATABILITY TEST
       REM            
RE     OCT 200010000000   9 L
       OCT 0              9 R
       OCT 0              8 L
       OCT 0              8 R
       OCT 0              7 L
       OCT 0              7 R
       OCT 100000042      6 L
       OCT 0              6 R
       OCT 120045106410   5 L
       OCT 0              5 R
       OCT 1000040120     4 L
       OCT 0              4 R
       OCT 10602000000    3 L
       OCT 0              3 R
       OCT 42000211001    2 L
       OCT 0              2 R
       OCT 400000         1 L
       OCT 0              1 R
       OCT 51600211000    0 L
       OCT 0              0 R
       OCT 200152002143   11L
       OCT 0              11R
       OCT 122005544430   12L
       OCT                12R
       REM            
*       CONSTANTS     
       REM            
K0     OCT 4          
       OCT 7          
       REM
K      TRA ID-7       
       TRA AZA-2      
       TRA AA         
       TRA AB-2       
       TRA A1A-2      
       TRA A2A-2      
       TRA A3A        
       TRA 2,2        
       HTR A7A        
       HTR A15A       
       TTR A16A       
       STR A16A-9     
       HTR A18A       
       TRA A20A       
       TRA A22A       
       TRA A23Y       
       TRA A24A       
       STR A24A-2,0,11 
       TRA A27A       
       TRA A27B       
       HTR A27B-2,0,3 
       TRA A28A       
       IOCD K+23,0,3  
       HTR            
       RTBA 1         
       TRA A28B       
       TRA A28C       
       HTR A28C-2,0,3 
       REM            
K1     STR A20A-2     
       HTR A20A-4     
       HTR AZ,0,TRAP+5 
       TRA A22-3      
       HTR EXK1       
       HTR NUM+1      
       HTR NUM+2      
       TRA SPACE      
       TTR 2          
       HTR ALT        
       TRA A6X+5      
       TRA A23M       
       HTR 0,0,AZ     
       REM            
NUM    OCT 0          
       OCT 1          
       OCT 2          
       OCT 3          
       OCT 400000000000
       OCT 2000       
       OCT 400100000000
       OCT 200777770000
       OCT 634600000000
       OCT 233400000000
       OCT 432404040404
       OCT 344440404040
       OCT 1007777777
       OCT 4004444444  
       OCT 7777777717777
       OCT 7777777737777
       OCT 7777777707777
       OCT 10000      
       OCT 20000      
       OCT 77777      
       REM            
NUM1   OCT 634400000000 
       OCT 175777777777 
       REM            
WO     IOCD EX,0,24   
WO1    IOCD IM,0,24   
CWD    IOCT PR1,0,1   
       IOCT PR1+2,0,1 
       IOCT PR1+1,0,1 
       IOCT PR1+3,0,1 
       IOCT PR1+3,0,1 
       IOCT 0,0,3     
       IOCT TOP+2,0,1 
       REM            
       REM TEMPORARY STORAGE
       REM            
SUM    OCT 0          COMPUTED CHECK SUM
HOLD   OCT 0          
       OCT 0          
       OCT 0          
LADR   OCT 0          
       OCT 0          
IM     OCT 0,0,0,0,0,0,0,0,0,0,0,0
       OCT 0,0,0,0,0,0,0,0,0,0,0,0
       REM
TOTAL  OCT 242555415161 KNOWN CHECK SUM
       REM
4K     EQU 4095       
8K     EQU 8191       
16K    EQU 16383      
32K    EQU 32767      
       REM            
       END            
