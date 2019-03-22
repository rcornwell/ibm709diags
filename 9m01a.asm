                                                             9M01A          
                                                            7-01-58
***********************************************************
*                         9M01
*709 MAIN FRAME TEST EXAMINING FIXED-POINT AND LOGICAL ARITHMETIC
*OPERATIONS, WORD TRANSMISSION OPERATIONS, SHIFTING OPERATIONS,
*CONTROL OPERATIONS AND LOGICAL OPERATIONS
       ORG 24
       SWT 3         TEST SENSE SWITCH 3
       TRA ID        IDENTIFY PROGRAM
       CLA END+1     RESET
       STO 0         START
       REM           CURSORY TSX TEST
       TSX START,4
       HTR START     DID NOT TRA ON TSX
 START TRA 5,4       BEGIN TEST
       HTR A         WRONG COM IN XRC
       REM           COMMENCE TEST
       BCD 1TOV      TEST OVERFLOW IN ACC
 A     TOV A+1       TURN OFF OVERFLOW  TRGR
       TOV A+3       NO GOOD, DID NOT TURN OFF
       TRA A+4       OK
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A         REPEAT
       REM
       BCD 1TOV      TEST OVERFLOW ALS
 A7    CLA PTW       PLACE BIT IN ACC  1
       ALS 1         SHOULD OVERFLOW.
       TOV A7+4      OK, SHOULD OVFL
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A7        REPEAT
       REM
       BCD 1TOV      TEST OVFL WITH NO
 A8    CLA ZERO       OVERFLOW
       TOV A8+3      SHOULD NOT OVFL
       TRA A8+4      OK, DID NOT OVFL
       TSX ERROR,4   ERROR
       TSX OK,4
       TRA A8        REPEAT
       REM
       BCD 1TNO      TEST TNO WITH NO ACC OVF
 A9    CLA ZERO      CLEAR  ACC
       TNO A9+3      TEST FOR NO OVFL
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A9        REPEAT
       REM
       BCD 1TNO      TEST TNO WITH ACC OVFL
 A10   CLA PTW       PLACE BIT IN ACC  1
       ALS 1         SHIFT TO FORCE OVERFLOW
       TNO A10+4     SHOULD NOT TRANSFER
       TRA A10+5     OK
       TSX ERROR,4
       TSX OK,4      REPEAT
       TRA A10
       REM
       BCD 1TNO      DID TNO TURN LIGHT OFF
 A11   TOV  A11+2
       TRA A11+3     OK, DID TURN IT OFF
       TSX ERROR,4
       TSX OK,4
       TRA A11       REPEAT
       REM
       BCD 1TZE      TEST TZE INST WITH ARS
 A12   ARS 36        CLEAR  ACCUMULATOR
       TZE A12+3     TEST FOR ZERO
       TSX ERROR,4   NO GOOD, DID NOT TRANSFER
       TSX OK,4      OK
       TRA A12       REPEAT
       REM
       BCD 1TZE      TEST TZE, WITH CLA
 A13   CLA ZERO      BRING IN  ZERO
       TZE A13+3     TEST FOR ZERO
       TSX ERROR,4   NO GOOD DID NOT TRANSFER
       TSX OK,4      OK
       TRA A13       REPEAT
       REM
       BCD 1TZE      TEST TZE, WITH CLA
 A14   CLA A14       BRING IN NO  ZERO
       TZE A14+3     SHOULD NOT TRANSFER
       TRA A14+4     OK, DID NOT TRANSFER
       TSX ERROR,4   OK
       TSX OK,4
       TRA A14       REPEAT
       REM
       BCD 1TNZ      TEST TNZ, ACC NOT ZERO
 A15   CLA A15       BRING IN NON  ZERO
       TNZ A15+3     SHOULD TRANSFER
       TSX ERROR,4   NO GOOD, DID NOT TRANSFER
       TSX OK,4      OK
       TRA A15       REPEAT
       REM
       BCD 1TNZ      TEST TNZ, ACC IS ZERO
 A16   CLA ZERO      CLEAR  ACC
       TNZ A16+3     SHOULD NOT TRANSFER
       TRA A16+4
       TSX ERROR,4   GOOD, DID NOT TRANSFER
       TSX OK,4        
       TRA A16        
       REM
       BCD 1ALS      TEST ALS
 A21   CLA ZERO      TEST ALS BY MOVING  ZERO
       ALS 8         EIGHT LEFT
       TZE A21+4     OK
       TSX ERROR,4   PICK UP ONES FROM LEFT
       TSX OK,4
       TRA A21
       REM
       BCD 1ALS      TEST ALS, MOVE A ONE
 A22   CLA ONE       PLACE ONE IN ACC  35
       TNZ A22+4     OK, ONE IS IN ACC
       TSX ERROR-1,4 ERROR IN STARTING
       TRA A22
       REM
       TOV A22+5     TURN OFF OVFL
       ALS 1
       TNZ A22+9     OK, BIT IS STILL THERE
       TSX ERROR-1,4 LOST BIT IN ACC
       TRA A22
       TOV A22+12    MOVE ON WHEN BIT GETS TO P
       TRA A22+5     LOOP ACROSS ACC
       TSX ERROR,4   NEVER ENTER, WASTE INST
       TSX OK,4
       TRA A22
       REM
       BCD 1ALS      ALS TEST, TEST IN Q POS
 A23   CLA PTW       PLACE BIT IN  1
       ALS 2         MOVE IT TO Q
       TNZ A23+5
       TSX ERROR-1,4 LOST BIT IN Q
       TRA A23
       ALS 1         MOVE BIT OUT OF ACC
       TZE A23+8     SHOULD BE ZERO NOW
       TSX ERROR,4   DID NOT MOVE BIT OUT OF Q
       TSX OK,4
       TRA A23
       REM
       BCD 1ARS      ARS TEST
 A24   CLA ONE       PUT BIT IN 35 OF  ACC
       TOV A24+2     TURN OFF OVFL
       TNZ A24+5     OK, BIT IS IN ACC
       TSX ERROR-1,4 LOST BIT IN STARTING
       TRA A24
       ALS 34
       TNZ A25       OK, BIT IS IN POS 1
       TSX ERROR-1,4
       TRA A24
 A25   TNO A25+3     OVFL SHOULD BE  OFF
       TSX ERROR-1,4
       TRA A24
       ALS 1
       ARS 1
       TNZ A26       OK, BIT STILL THERE
       TSX ERROR-1,4 LOST BIT FROM P TO 1
       TRA A24
       REM
 A26   ARS 1          INDICATIONS
       TOV A26+2     TURN OFF OVFL
       ALS 1
       TNO A26+6     OVFL SHOULD BE OFF
       TSX ERROR-1,4
       TRA A24
       ALS 2         GO OVER TO Q
       TNZ A26+10    OK, BIT STILL THERE
       TSX ERROR-1,4 LOST BIT
       TRA A24
       REM
       REM
       TOV A26+12    OVFL SHOULD BE ON
       TSX ERROR,4
       TSX OK,4
       TRA A24
       REM
       REM
       BCD 1LBT      TEST LBT
 A27   CLA ONE       PLACE ONE IN ACC  25
       LBT
       TSX ERROR,4   DID NOT SENSE ONE BIT
       TSX OK,4
       TRA A27
       REM
       BCD 1LBT      TEST LBT
 A28   CLA ZERO      PLACE ZERO IN ACC  35
       LBT
       TRA A28+4     OK, DID NOT SENSE ONE
       TSX ERROR,4   ERROR SHOULD NOT SKIP
       TSX OK,4
       TRA A28
       REM
       BCD 1PBT      PBT TEST
 A29   CLA ZERO      PLACE ZERO IN  ACC
       ALS 18        MOVE ZERO INTO P
       PBT
       TRA A29+5     OK, SENSED ZERO
       TSX ERROR,4   DID NOT SENSE ONE BIT
       TSX OK,4
       TRA A29
       REM
       BCD 1PBT      PBT TEST
 A30   CLA ONE       PLACE ONE ZERO IN ACC  35
       ALS 35        SHIFT ONE TO P POSITION
       PBT
       TSX ERROR,4   DID NOT SKIP WITH ONE IN P
       TSX OK,4
       TRA A30
       REM
       BCD 1TPL      TPL TEST
 A31   CLA PTW       BRING IN PLUS  NUMBER
       TPL A31+3     TRANSFER IF OK
       TSX ERROR,4   ERROR DID NOT TRANSFER
       TSX OK,4
       TRA A31
       REM
       BCD 1TPL      TPL TEST
 A32   CLA MTW       BRING IN MINUS  NUMBER
       TPL A32+3     SHOULD NOT TRANSFER
       TRA A32+4
       TSX ERROR,4
       TSX OK,4
       TRA A32
       REM
       BCD 1TMI      TMI TEST
 A33   CLA MTW       BRING IN MINUS  NUMBER
       TMI A33+3     OK, SHOULD TRANSFER
       TSX ERROR,4   DID NOT TRANSFER
       TSX OK,4
       TRA A33
       REM
       BCD 1TMI      TMI TEST
 A34   CLA PTW       BRING IN PLUS  NUMBER
       TMI A34+3     SHOULD NOT TRANSFER
       TRA A34+4     OK, DID NOT TRANSFER
       TSX ERROR,4
       TSX OK,4
       TRA A34
       REM
       BCD 1CLM      CLM TEST, TWO PARTS
 A35   CLA ONES      BRING IN  -377777777777
       CLM
       TZE A35+5     OK, NOW SEE IF SIGN IS SAME
       TSX ERROR-1,4 DID NOT CLEAR POS 1-35
       TRA A35
       REM
       TMI A35+7     OK, DID NOT CHANGE SIGN
       TSX ERROR,4   CHANGED SIGN
       TSX OK,4      PROCEED
       TRA A35 
       REM
       BCD 1CLM      CLM TEST, TWO PARTS
 A36   CLA PONES     BRING IN +377777777777
       CLM           
       TZE A36+5     OK. NOW SEE IF SIGN IS SAME
       TSX ERROR-1,4 DID NOT CLEAR POS 1-35
       TRA A36          
       TPL A36+7     OK, SIGN UNCHANGED
       TSX ERROR,4   CHANGED SIGN
       TSX OK,4          
       TRA A36          
       REM
       BCD 1CLM      CLM TEST, CHECK OF P ANDQ
 A37   CLA ONES      BRING IN ONES
       ALS 6         SHIFT INTO P AND Q
       CLM          
       TZE A37+5     OK, SHOULD CLEAR P AND Q  
       TSX ERROR,4   DID NOT CLEAR P AND Q
       TSX OK,4          
       TRA A37          
       REM
       BCD 1SSP      SSP TEST
 A38   CLA ONES      MAKE ACC SIGN MINUS
       SSP           NOW MAKE POSITIVE
       TPL A38+4     OK, SHOULD TRANSFER
       TSX ERROR,4   DID NOT CHANGE MINUS TO 
       REM           PLUS
       TSX OK,4          
       TRA A38          
       REM
       BCD 1SSP      SSP TEST
 A39   CLA PONES     BRING IN PLUS NUMBER
       SSP          
       TPL A39+4     SHOULD TRANSFER
       TSX ERROR,4   DID NOT TRA, CHANGED SIGN
       TSX OK,4          
       TRA A39          
       REM
       BCD 1SSM      SSM TEST
 A40   CLA PONES     BRING IN PLUS NUMBER
       SSM           MAKE IT MINUS
       TMI A40+4     SHOULD TRANSFER          
       TSX ERROR,4   DID NOT CHANGE PLUS TO
       REM           MINUS
       TSX OK,4          
       TRA A40          
       REM
       BCD 1SSM      SSM TEST
 A41   CLA ONES      BRING IN NEGATIVE NUMBER
       SSM           SHOULD NOT CHANGE
       TMI A41+4     SHOULD TRANSFER
       TSX ERROR,4   INADVERTENTLY CHANGED SIGN
       TSX OK,4          
       TRA A41          
       REM
       BCD 1CHS      CHS TEST            
 A42   CLA PONES     BRING IN PLUS NUMBER
       CHS           MAKE IT MINUS
       TMI A42+4     SHOULD TRANSFER
       TSX ERROR,4   DID NOT CHANGE SIGNS
       TSX OK,4          
       TRA A42          
       REM
       BCD 1CHS      CHS TEST
 A43   CLA ONES      BRING IN NEGATIVE NUMBER
       CHS           MAKE IT POSITIVE
       TPL A43+4     SHOULD TRANFER
       TSX ERROR,4   DID NOT CHANGE MINUS TO
       REM           PLUS
       TSX OK,4          
       TRA A43          
       REM
       BCD 1LLS      LLS TEST
 A44   TOV A44+1     TURN OFF OVFL
       LDQ ZERO      BRING ZERO INTO ACC + MQ
       CLA ZERO      SEE IF PICKED UP BITS
       LLS 18        BY SHIFT
       TZE A45       SHOULD TRANFER
       TSX ERROR-1,4 PICKED UP BI
       TRA A44          
       REM
 A45   STQ TEMP      CHECK FOR MQ PICK UP
       CLA TEMP      OF BITS BY LLS
       TZE A45+4     OK, NO PICK UP
       TSX ERROR,4   PICKED UP A ONE
       TSX OK,4          
       TRA A44       REPEAT TO A44
       REM
       BCD 1LLS      LLS TEST
 A46   CLA ZERO      CLEAR ACCUMULATOR
       LDQ ONE       MOVE BIT FROM MQ 35 TO MQ 1
       LLS 34        DOES IT MOVE CORRECTLY
       TZE A47       OK, PROCEED
       TSX ERROR-1,4          
       TRA A46          
       REM
 A47   STQ TEMP      IS THE BIT STILL IN MQ
       CLA TEMP          
       SUB PTW          
       TZE A47+5     SHOULD TRANFER
       TSX ERROR,4   LOST THE BIT IN THE MQ
       TSX OK,4          
       TRA A46       GO BACK UP TO A 46
       REM
       BCD 1LLS      LLS TEST, CHECK FOR SIGNS
 A48   CLA MTW       MAKE ACC NEGATIVE
       LDQ PTW       MAKE MQ POSITIVE
       LLS          	
       TPL A48+5     OK, SHOULD TRANFER  
       TSX ERROR,4   DID NOT CHANGE ACC SIGN
       TSX OK,4         
       TRA A48          
       REM
       BCD 1LLS      LLS TEST, CHECK FOR SIGNS
 A49   CLA PTW       MAKE ACC POSITIVE
       LDQ MTW       MAKE MQ NEGATIVE
       LLS          
       TMI A49+5     OK, SHOULD TRANFER
       TSX ERROR,4   DID NOT CHANGE ACC SIGN
       TSX OK,4          
       TRA A49          
       REM
       BCD 1LLS             
 A50   CLA PTW      MAKE ACC POSITIVE         
       LDQ PTW      MAKE MQ POSITIVE         
       LLS          
       TPL A50+5    SHOULD TRANSFER
       TSX ERROR,4  CHANGED SIGNS INADVERTENTLY
       TSX OK,4          
       TRA A50          
       REM
       BCD 1LLS     LLS TEST, CHECK FOR SIGNS
 A51   CLA MTW      MAKE ACC NEGATIVE         
       LDQ MTW      MAKE MQ NEGATIVE         
       LLS          
       TMI A51+5    SHOULD TRANSFER
       TSX ERROR,4  SIGNS CHANGED INADVERTENLY
       TSX OK,4          
       TRA A51          
       REM
       BCD 1LRS     LRS TEST
 A52   CLA ONE      PLACE 1 IN ACC 35
       LDQ ZERO     CLEAR MQ         
       LRS 35       SHIFT A ONE TO MQ
       STQ TEMP     STORE MQ IN TEMP STORAGE
       CLA TEMP     BRING CONTENTS OF MQ TO ACC
       TNZ A52+7    OK, SHOULD STILL HAVE ONE
       TSX ERROR,4  LOST ONE BIT IN SHIFT
       TSX OK,4          
       TRA A52          
       REM
       BCD 1LRS             
 A53   LDQ ZERO     CLEAR MQ         
       CLA PTW      MAKE ACC POSITIVE         
       LRS 36          
       TZE A53+5          
       TSX ERROR,4          
       TSX OK,4          
       TRA A53          
       REM
       BCD 1LRS             
 A54   CLA MTW     MAKE ACC NEGATIVE         
       LRS 34          
       LBT          
       TSX ERROR,4          
       TSX OK,4          
       TRA A54          
       REM
       BCD 1LRS             
 A55   CLA PTW     MAKE ACC POSITIVE         
       LDQ MTW     MAKE MQ NEGATIVE         
       LRS           
       STQ TEMP          
       CLA TEMP          
       TPL 00603          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00574          
       REM
       BCD 1LRS             
 A56   CLA MTW     MAKE ACC NEGATIVE         
       LDQ PTW      MAKE MQ POSITIVE         
       LRS           
       STQ TEMP          
       CLA TEMP          
       TMI 00615          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00606          
       REM
       BCD 1LRS             
 A57   CLA PTW     MAKE ACC POSITIVE         
       LDQ PTW      MAKE MQ POSITIVE         
       LRS           
       STQ TEMP          
       CLA TEMP          
       TPL 00627          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00620          
       REM
       BCD 1LGL             
 A58   TOV 00633          
       CLA ZERO          
       LDQ ZERO       CLEAR MQ         
       LGL 8          
       STQ TEMP          
       CLA TEMP          
       TZE 00642          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00632          
       REM
       BCD 1LGL             
 A59   CLA ZERO          
       LDQ ONE          
       LGL 1          
       STQ TEMP          
       CLA TEMP          
       TNZ 00647          
       TMI 00655          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00645          
       REM
       BCD 1LGL             
 A60   TOV 00661          
       LDQ MZE          
       LGL 36          
       PBT 
       TRA 00666          
       TRA 00670          
       TSX ERROR-1,4          
       TRA 00660          
       TOV 00673          
       TSX ERROR-1,4          
       TRA 00660          
 A61   LGL 2          
       TZE 00676          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00660          
       REM
       BCD 1LGL             
 A61A  LDQ PTHR          
       LGL 3          
       LBT          
       TRA 00706          
       TRA 00710          
       TSX ERROR-1,4          
       TRA 00701          
       STQ TEMP          
       CLA TEMP          
       TZE 00715          
       TSX ERROR-1,4          
       TRA 00701          
       TPL 00717          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00701          
       REM
       BCD 1RQL             
 A62   LDQ MZE          
       RQL 1          
       STQ TEMP          
       CLA TEMP          
       LBT          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00722          
       REM
       BCD 1RQL             
 A62A  TOV 00734          
       CLA ZERO          
       LDQ ZERO       CLEAR MQ         
       RQL 00020          
       STQ TEMP          
       CLA TEMP          
       TZE 00743          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00733          
       REM
       BCD 1RQL             
 A63   LDQ MZE          
       RQL 1          
       STQ TEMP          
       CLA TEMP          
       TNZ 00747          
       TMI 00755          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00746          
       REM
       BCD 1RQL             
 A63A  LDQ ONE          
       RQL 256          
       STQ TEMP          
       CLA TEMP          
       LBT          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00760          
       REM
       BCD 1RQL             
 A63B  LDQ ONE          
       RQL 292          
       STQ TEMP          
       CLA TEMP          
       LBT          
       TSX ERROR,4          
       TSX OK,4          
       TRA 00771          
       REM
       BCD 1TQP             
 A64   LDQ PTW      MAKE MQ POSITIVE         
       TQP 01005          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01002          
       REM
       REM
       REM
       BCD 1TQP             
 A65   LDQ MTW     MAKE MQ NEGATIVE         
       TQP 01013          
       TRA 01014          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01010          
       REM
       BCD 1NOP             
 A66   NOP          
       TRA 01022          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01017          
       REM
       BCD 1COM             
 A67   CLA ONES          
       COM          
       ALS 2          
       TZE 01032          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01025          
       REM
       BCD 1COM             
 A68   CLA ONES          
       LDQ ONES          
       LLS 8          
       COM          
       TZE 01043          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01035          
       REM
       BCD 1COM             
 A69   CLA PONES          
       COM          
       TPL 01052          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01046          
       REM
       BCD 1COM             
 A70   CLA ONES          
       COM          
       TMI 01061          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01055          
       REM
       BCD 1ADD             
 A71   CLA ONE          
       ADD ONE          
       LBT          
       TRA A72   
       TSX ERROR-1,4          
       TRA 01064          
 A72   ARS 1          
       LBT          
       TRA 01076          
       TRA 01100          
       TSX ERROR-1,4          
       TRA 01064          
       TPL 01102          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01064          
       REM
       BCD 1ADD             
 A73   CLA MONE          
       ADD MONE          
       LBT          
       TRA 01113          
       TSX ERROR-1,4          
       TRA 01105          
 A74   ARS 1          
       LBT          
       TRA 01117          
       TRA 01121          
       TSX ERROR-1,4          
       TRA 01105          
       TMI 01123          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01105          
       REM
       BCD 1ADD             
 A75   CLA THREE          
       ADD M2          
       LBT          
       TRA 01133          
       TRA 01135          
       TSX ERROR-1,4          
       TRA 01126          
 A76   ARS 1          
       LBT          
       TRA 01142          
       TSX ERROR-1,4          
       TRA 01126          
       TPL 01144          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01126          
       REM
       BCD 1ADD             
 A77   CLA M3                 
       ADD TWO          
       LBT          
       TRA 01154          
       TRA 01156          
       TSX ERROR-1,4          
       TRA 01147          
 A78   ARS 1          
       LBT          
       TRA 01163          
       TSX ERROR-1,4          
       TRA 01147          
       TMI 01165          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01147          
       REM
       BCD 1ADD             
 A79   CLA TWO          
       ADD M3
       LBT          
       TRA 01175          
       TRA 01177          
       TSX ERROR-1,4          
       TRA 01170          
 A80   ARS 1          
       LBT          
       TRA 01204          
       TSX ERROR-1,4          
       TRA 01170          
       TMI 01206          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01170          
       REM
       BCD 1ADD             
 A81   CLA M2          
       ADD THREE          
       LBT          
       TRA 01216          
       TRA 01220          
       TSX ERROR-1,4          
       TRA 01211          
 A82   ARS 1          
       LBT          
       TRA 01225          
       TSX ERROR-1,4          
       TRA 01211          
       TPL 01227          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01211          
       REM
       BCD 1ADD             
 A82A  CLA PONES          
       ADD ONE          
       PBT
       TRA 01237          
       TRA 01241          
       TSX ERROR-1,4          
       TRA 01232          
       TOV 01243          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01232          
       REM
       BCD 1ADM             
 A83   CLA MONE          
       ADM TWO          
       LBT          
       TRA 01253          
       TRA 01255          
       TSX ERROR-1,4          
       TRA 01246          
       TPL 01257          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01246          
       REM
       BCD 1ADM             
 A83A  CLA MONE          
       ADM M2          
       LBT          
       TRA 01267          
       TRA 01271          
       TSX ERROR-1,4          
       TRA 01262          
       TPL 01273          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01262          
       REM
       BCD 1ADM             
 A84   CLA PONES          
       ADM MONE          
       PBT
       TRA 01303          
       TRA 01305          
       TSX ERROR-1,4          
       TRA 01276          
       TOV 01307          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01276          
       REM
       BCD 1SUB             
 A85   CLA ONE          
       SUB MONE          
       LBT          
       TRA 01320          
       TSX ERROR-1,4          
       TRA 01312          
       TPL 01323          
       TSX ERROR-1,4          
       TRA 01312          
 A86   ARS 1          
       LBT          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01312          
       REM
       BCD 1SUB             
 A87   CLA MONE          
       SUB ONE          
       LBT          
       TRA 01337          
       TSX ERROR-1,4          
       TRA 01331          
       TMI 01342          
       TSX ERROR-1,4          
       TRA 01331          
 A88   ARS 1          
       LBT          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01331          
       REM
       BCD 1SUB             
 A89   CLA THREE          
       SUB TWO          
       LBT          
       TRA 01355          
       TRA 01357          
       TSX ERROR-1,4          
       TRA 01350          
       TPL 01361          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01350          
       REM
       BCD 1SUB             
 A90   CLA TWO          
       SUB THREE          
       LBT          
       TRA 01371          
       TRA 01373          
       TSX ERROR-1,4          
       TRA 01364          
       TMI 01376          
       TSX ERROR-1,4          
       TRA 01364          
 A91   ARS 1          
       LBT          
       TRA 01402          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01364          
       REM
       BCD 1SUB             
       CLA M2          
 A92   SUB M3                 
       LBT          
       TRA 01412          
       TRA 01414          
       TSX ERROR-1,4          
       TRA 01405          
       TPL 01417          
       TSX ERROR-1,4          
       TRA 01405          
 A93   ARS 1          
       LBT          
       TRA 01423          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01405          
       REM
       BCD 1SUB             
 A94   CLA M3    
       SUB M2          
       LBT          
       TRA 01433          
       TRA 01435          
       TSX ERROR-1,4          
       TRA 01426          
       TMI 01440          
       TSX ERROR-1,4          
       TRA 01426          
 A95   ARS 1          
       LBT          
       TRA 01444          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01426          
       REM
       BCD 1SUB             
 A95A  CLA ONES          
       SUB ONE          
       PBT
       TRA 01454          
       TRA 01456          
       TSX ERROR-1,4          
       TRA 01447          
       TOV 01460          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01447          
       REM
       BCD 1SBM             
 A96   CLA ONE          
       SBM M2          
       LBT          
       TRA 01470          
       TRA A96+7
       TSX ERROR-1,4          
       TRA 01463          
       TMI 01474          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01463          
       REM
       BCD 1SBM             
 A97   CLA ONE          
       SBM TWO          
       LBT          
       TRA 01504          
       TRA 01506          
       TSX ERROR-1,4          
       TRA 01477          
       TMI 01510          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01477          
       REM
       BCD 1SBM             
 A97A  CLA ONES          
       SBM ONE          
       PBT
       TRA 01520          
       TRA 01522          
       TSX ERROR-1,4          
       TRA 01513          
       TOV 01524          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01513          
       REM
       BCD 1CLA             
 A98   CLA MONE          
       TMI 01532          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01527          
       REM
       BCD 1CLA             
 A99   CLA ONE          
       TPL 01540          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01535          
       REM
       BCD 1CLA             
 A100  CLA ZERO          
       TZE 01546          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01543          
       REM
       BCD 1CLA             
 B     CLA PTW     MAKE ACC POSITIVE         
       ALS 1          
       PBT
       TRA 01556          
       TRA 01560          
       TSX ERROR-1,4          
       TRA 01551          
       TOV 01562          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01551          
       REM
       BCD 1CLA             
 B1    CLA ONE          
       PBT
       TRA B1+5
       TSX ERROR-1,4          
       TRA 01565          
       ARS 1          
       PBT
       TRA 01577          
       TSX ERROR-1,4          
       TRA 01565          
       TNO 01601          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01565          
       REM
       BCD 1CLA             
 B2    CLA ONE          
       LBT          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01604          
       REM
       BCD 1CLA             
 B3    CLA PONES          
       ADD ONE          
       LBT          
       TRA 01620          
       TSX ERROR-1,4          
       TRA 01612          
       PBT
       TRA 01623          
       TRA 01625          
       TSX ERROR-1,4          
       TRA 01612          
       ALS 2          
       TZE 01630          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01612          
       REM
       BCD 1CLS             
 B4    CLS MONE          
       TPL 01636          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01633          
       REM
       BCD 1CLS             
 B5    CLS ONE          
       TMI 01644          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01641          
       REM
       BCD 1CLS             
 B6    CLS ONE          
       LBT          
       TRA 01653          
       TRA 01655          
       TSX ERROR-1,4          
       TRA 01647          
       PBT
       TRA 01661          
       TSX ERROR-1,4          
       TRA 01647          
       ARS 1          
       PBT
       TRA 01665          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01647          
       REM
       BCD 1CAL             
 B7    CAL MONE          
       PBT
       TRA 01674          
       TRA 01676          
       TSX ERROR-1,4          
       TRA 01670          
 B8    TPL 01701          
       TSX ERROR-1,4          
       TRA 01670          
       ARS 1          
       PBT
       TRA 01705          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01670          
       REM
       BCD 1CAL             
 B9    CAL ONE          
       PBT
       TRA 01715          
       TSX ERROR-1,4          
       TRA 01710          
       LBT          
       TRA 01720          
       TRA 01722          
       TSX ERROR-1,4          
       TRA 01710          
 B10   TPL 01725          
       TSX ERROR-1,4          
       TRA 01710          
       ARS 1          
       PBT
       TRA 01731          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01710          
       REM
       BCD 1ACL             
 B11   CLA ZERO          
       ACL ONE          
       PBT
       TRA 01742          
       TSX ERROR-1,4          
       TRA 01734          
       TPL 01744          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01734          
       REM
       BCD 1ACL             
 B12   CLA ZERO          
       ACL MONE          
       PBT
       TRA 01754          
       TRA 01756          
       TSX ERROR-1,4          
       TRA 01747          
       TPL 01761          
       TSX ERROR-1,4          
       TRA 01747          
       LBT          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01747          
       REM
       BCD 1ACL             
 B13   CAL MONE          
       ACL MONE          
       PBT
       TRA 01774          
       TSX ERROR-1,4          
       TRA 01766          
       LBT          
       TRA 01777          
       TRA 02001          
       TSX ERROR-1,4          
       TRA 01766          
       ARS 1          
       PBT
       TRA 02005          
       TSX ERROR,4          
       TSX OK,4          
       TRA 01766          
       REM
       BCD 1STO             
 B14   CLA ONES          
       STO TEMP          
       SUB TEMP          
       TZE 02015          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02010          
       REM
       BCD 1SLW             
 B15   CAL MONE          
       TPL 02024          
       TSX ERROR-1,4          
       TRA 02020          
       SLW TEMP          
       CLA TEMP          
       SUB MONE          
       TZE 02031          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02020          
       REM
       BCD 1SLW             
 B16   CLA MONE          
       SLW TEMP          
       CLA TEMP          
       TPL 02041          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02034          
       REM
       BCD 1STP             
 B17   CLA ZERO          
       STO TEMP          
       CLA KK33          
       STP TEMP          
       CLA TEMP          
       TPL 02054          
       TSX ERROR-1,4          
       TRA 02044          
       ALS 1          
       PBT
       TRA 02060          
       TRA 02062          
       TSX ERROR-1,4          
       TRA 02044          
       TOV 02065          
       TSX ERROR-1,4          
       TRA 02044          
       ALS 1          
       PBT
       TRA *+2
       TSX ERROR-1,4          
       TRA 02044          
       ALS 1          
       TZE 02075          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02044          
       REM
       BCD 1STP             
 B18   CLA ZERO          
       STO TEMP          
       CLA ZERO          
       STP TEMP          
       CLA TEMP          
       TPL 02110          
       TSX ERROR-1,4          
       TRA 02100          
       ALS 1          
       PBT
       TRA 02115          
       TSX ERROR-1,4          
       TRA 02100          
       TNO 02120          
       TSX ERROR-1,4          
       TRA 02100          
       ALS 1          
       PBT
       TRA 02125          
       TSX ERROR-1,4          
       TRA 02100          
       TNO 02127          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02100          
       REM
       BCD 1STP             
 B19   CLA ZERO          
       STO TEMP          
       CAL ONES          
       ALS 1          
       STP TEMP          
       ARS 1          
       PBT
       TRA 02143          
       TRA 02145          
       TSX ERROR-1,4          
       TRA 02132          
       TPL 02150          
       TSX ERROR-1,4          
       TRA 02132          
       CLA TEMP          
       TMI 02153          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02132          
       REM
       BCD 1STA             
 B20   CLA RTN          
       STO TEMP          
       CLA RTN+1          
       STA TEMP          
       TRA TEMP          
       SUB RTN+1          
       TZE 02166          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02156          
       REM
       BCD 1STA             
 B21   CLA ZERO          
       STO TEMP          
       CLA ONES          
       STA TEMP          
       CLA TEMP          
       SUB 8CF          
       TZE 02201          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02171          
       REM
       BCD 1STA             
 B22   CLA 8CF          
       STO TEMP          
       CLA ZERO          
       STA TEMP          
       CLA TEMP          
       TZE 02213          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02204          
       REM
       BCD 1STD             
 B23   CLA KK34          
       STO TEMP          
       CLA KK32          
       STD TEMP          
       CLA TEMP          
       SUB PTW          
       TZE 02226          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02216          
       REM
       BCD 1STD             
 B24   CLA K12          
       SUB K10          
       STO TEMP          
       CLA ONES          
       STD TEMP          
       ADD TEMP          
       TZE 02241          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02231          
       REM
       BCD 1CAS             
 B25   CLA THREE          
       CAS TWO          
       TRA 02251          
       TRA 02250          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02244          
       REM
       BCD 1CAS             
 B26   CLA TWO          
       CAS M3
       TRA 02261          
       TRA 02260          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02254          
       REM
       BCD 1CAS             
 B27   CLA M2          
       CAS M3
       TRA 02271          
       TRA 02270          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02264          
       REM
       BCD 1CAS             
 B28   CLA TWO          
       CAS THREE          
       TRA 02277          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02274          
       REM
       BCD 1CAS             
 B29   CLA M3    
       CAS TWO          
       TRA 02306          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02303          
       REM
       BCD 1CAS             
 B30   CLA TWO   
       CAS M2          
       TRA 02315          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02312          
       REM
       BCD 1CAS             
 B31   CLA TWO          
       CAS TWO          
       TRA 02325          
       TRA 02326          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02321          
       REM
       BCD 1CAS             
 B32   CLA ZERO          
       CAS MZE          
       TRA 02336          
       TRA 02335          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02331          
       REM
       BCD 1CAS             
 B33A  CLA ONES          
       CAS ONES          
       TRA 02345          
       TRA 02346          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02341          
       REM
       BCD 1LDQ             
 B33   CLA ZERO          
       LRS 36          
       LDQ ONES          
       LLS 0          
       TMI 02360          
       TSX ERROR-1,4          
       TRA 02351          
       LLS 35          
       TOV 02362          
       ADD MONE          
       TOV 02366          
       TSX ERROR-1,4          
       TRA 02351          
       ALS 2          
       TZE 02371          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02351          
       REM
       BCD 1STQ             
 B34   LDQ ONES          
       STQ TEMP          
       CLA TEMP          
       TMI 02402          
       TSX ERROR-1,4          
       TRA 02374          
       TOV 02403          
       ADD MONE          
       TOV 02407          
       TSX ERROR-1,4          
       TRA 02374          
       ALS 2          
       TZE 02412          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02374          
       REM
       BCD 1STQ             
 B35   LDQ ZERO       CLEAR MQ         
       STQ TEMP          
       CLA TEMP          
       TZE 02422          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02415          
       REM
       BCD 1SLQ             
 B36   CLA ZERO          
       STO TEMP          
       LDQ ONES          
       SLQ TEMP          
       CLA TEMP          
       TMI 02435          
       TSX ERROR-1,4          
       TRA 02425          
       TOV 02436          
       ALS 1          
       TOV 02436          
       TNZ 02443          
       TSX ERROR-1,4          
       TRA 02425          
       ALS 2          
       TNO 02446          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02425          
       REM
       BCD 1SLQ             
 B37   LDQ ZERO       CLEAR MQ         
       CLA ONES          
       STO TEMP          
       SLQ TEMP          
       CLA TEMP          
       ARS 00022          
       TZE 02461          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02451          
       REM
       BCD 1TLQ             
 B38   CLA TWO          
       LDQ M3
       TLQ 02470          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02464          
       REM
       BCD 1TLQ             
 B39   CLA M3    
       LDQ M2          
       TLQ 02477          
       TRA 02500          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02473          
       REM
       BCD 1TLQ             
 B40   CLA TWO          
       LDQ TWO          
       TLQ 02507          
       TRA 02510          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02503          
       REM
       BCD 1TLQ             
 B41   CLA ZERO          
       LDQ MZE          
       TLQ 02517          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02513          
       REM
       BCD 1TLQ             
 B42   CLA MZE          
       LDQ ZERO       CLEAR MQ         
       TLQ 02526          
       TRA 02527          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02522          
       REM
       BCD 1TLQ             
 B42A  CLA MZE          
       LDQ MONE          
       TLQ 02536          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02532          
       REM
       BCD 1RND             
       CLA ZERO          
       LDQ PTW      MAKE MQ POSITIVE         
       RND          
       LBT          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02541          
       REM
       BCD 1MPY             
 B44   CLA PONES          
       ALS 2          
       LDQ ZERO       CLEAR MQ         
       MPY ZERO          
       TZE 02560          
       TSX ERROR-1,4          
       TRA 02551          
       STQ TEMP          
       CLA TEMP          
       TZE 02564          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02551          
       REM
       BCD 1MPY             
 B45   LDQ ONE          
       MPY ONE          
       TZE 02574          
       TSX ERROR-1,4          
       TRA 02567          
       STQ TEMP          
       CLA TEMP          
       TNZ 02601          
       TSX ERROR-1,4          
       TRA 02567          
       ARS 2          
       TZE 02604          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02567          
       REM
       REM
       BCD 1MPY             
 B46   LDQ PONES          
       MPY ONE          
       TZE 02614          
       TSX ERROR-1,4          
       TRA 02607          
       STQ TEMP          
       CLA TEMP          
       TOV 02616          
       ADD ONE          
       TOV 02622          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02607          
       REM
       BCD 1MPY             
 B47   LDQ PONES          
       MPY PONES          
       ADD ONE          
       TOV 02631          
       ADD ONE          
       TOV 02635          
       TSX ERROR-1,4          
       TRA 02625          
       STQ TEMP          
       CLA TEMP          
       SUB ONE          
       TZE 02642          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02625          
       REM
       BCD 1MPY             
 B48   LDQ ZERO       CLEAR MQ         
       MPY ZERO          
       TPL 02652          
       TSX ERROR-1,4          
       TRA 02645          
       TQP 02654          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02645          
       REM
       BCD 1MPY             
 B49   LDQ MZE          
       MPY MZE          
       TPL 02664          
       TSX ERROR-1,4          
       TRA 02657          
       TQP 02666          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02657          
       REM
       BCD 1MPY             
 B50   LDQ MZE          
       MPY ZERO          
       TMI 02676          
       TSX ERROR-1,4          
       TRA 02671          
       TQP 02700          
       TRA 02701          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02671          
       REM
       BCD 1MPY             
 B51   LDQ ZERO       CLEAR MQ         
       MPY MZE          
       TMI 02711          
       TSX ERROR-1,4          
       TRA 02704          
       TQP 02713          
       TRA 02714          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02704          
       REM
       BCD 1MPR             
 B52   LDQ PTW      MAKE MQ POSITIVE         
       MPR ONE          
       TNZ 02724          
       TSX ERROR-1,4          
       TRA 02717          
       ARS 1          
       TZE 02727          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02717          
       REM
       BCD 1MPR             
 B53   LDQ PTW      MAKE MQ POSITIVE         
       MPR ZERO          
       TZE 02737          
       TSX ERROR-1,4          
       TRA 02732          
       TPL 02742          
       TSX ERROR-1,4          
       TRA 02732          
       TQP 02744          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02732          
       REM
       BCD 1MPR             
 B54   LDQ MTW     MAKE MQ NEGATIVE         
       MPR ZERO          
       TPL 02753          
       TRA 02755          
       TSX ERROR-1,4          
       TRA 02747          
       TQP 02757          
       TRA 02760          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02747          
       REM
       BCD 1MPR             
 B54A  TOV 02764          
       LDQ PONES          
       MPR PTW          
       SUB PTW          
       TZE B54A+7             
       TSX ERROR-1,4          
       TRA 02763          
       TNO 02774          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02763          
       REM
       BCD 1DVP             
 B55   LDQ TWO          
       CLA ZERO          
       DVP ONE          
       TPL 03005          
       TSX ERROR-1,4          
       TRA 02777          
       TZE 03010          
       TSX ERROR-1,4          
       TRA 02777          
       STQ TEMP          
       CLA TEMP          
       SUB TWO          
       TZE 03015          
       TSX ERROR,4          
       TSX OK,4          
       TRA 02777          
       REM
       BCD 1DVP             
 B56   CLA ZERO          
       LDQ ONES          
       DVP MTW          
       TPL 03026          
       TSX ERROR-1,4          
       TRA 03020          
       STO TEMP          
       STQ TEMP+1          
       TQP 03032          
       TRA 03034          
       TSX ERROR-1,4          
       TRA 03020          
       CLA TEMP+1          
       SUB TEMP          
       TOV 03037          
       ALS 1          
       TOV 03042          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03020          
       REM
       REM
       BCD 1DCT             
 B57   DCT          
       TRA 03047          
       DCT          
       TRA 03052          
       TRA 03054          
       TSX ERROR-1,4          
       TRA 03045          
       CLA ZERO          
       LDQ PTW      MAKE MQ POSITIVE         
       DVP PTW          
       DCT          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03045          
       REM
       BCD 1DCT             
 B58   CLA PTW     MAKE ACC POSITIVE         
       DVP MON          
       DCT          
       TRA 03071          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03064          
       REM
       BCD 1DCT             
 B58A  CLA ONE          
       STO TEMP          
       DVP ZERO          
       SUB TEMP          
       TZE 03103          
       TSX ERROR-1,4          
       TRA 03074          
       DCT          
       TRA 03107          
       TSX ERROR-1,4          
       TRA 03074          
       ALS 1          
       TNZ 03075          
       TSX OK,4          
       TRA 03074          
       REM
       BCD 1DVH             
 B62   LDQ PTW      MAKE MQ POSITIVE         
       CLA ZERO          
       DVH PTW          
       TPL 03122          
       TSX ERROR-1,4          
       TRA 03114          
       TOV 03123          
       TZE 03126          
       TSX ERROR-1,4          
       TRA 03114          
       STQ TEMP          
       CLA TEMP          
       TNZ 03133          
       TSX ERROR-1,4          
       TRA 03114          
       LBT          
       TRA 03136          
       TRA 03140          
       TSX ERROR-1,4          
       TRA 03114          
       ARS 1          
       TZE 03143          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03114          
       REM
       BCD 1DVH             
 B63   CLA ZERO          
       LDQ ONES          
       DVH MTW          
       TPL 03154          
       TSX ERROR-1,4          
       TRA 03146          
       STO TEMP          
       STQ TEMP+1          
       TQP 03160          
       TRA 03162          
       TSX ERROR-1,4          
       TRA 03146          
       CLA TEMP+1          
       SUB TEMP          
       TOV 03165          
       LLS 1          
       TOV 03170          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03146          
       REM
       BCD 1ANA             
 B64   CAL MZE          
       ANA ONES          
       PBT
       TRA 03200          
       TRA 03202          
       TSX ERROR-1,4          
       TRA 03173          
       ARS 1          
       PBT
       TRA 03207          
       TSX ERROR-1,4          
       TRA 03173          
       TPL 03211          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03173          
       REM
       BCD 1ANA             
 B65   CAL ONES          
       ANA ONES          
       ADD ONE          
       ALS 1          
       TZE 03222          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03214          
       REM
       BCD 1ANA             
 B66   CAL ZERO          
       ANA ONES          
       TZE 03231          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03225          
       REM
       BCD 1ANA             
 B67   CAL KK30          
       ANA KK31          
       SUB KK32          
       PBT
       TRA 03242          
       TRA 03244          
       TSX ERROR-1,4          
       TRA 03234          
       ALS 2          
       TZE 03247          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03234          
       REM
       BCD 1ANA             
 B68   CLA KK30          
       ANA KK33          
       SUB KK34          
       TZE 03257          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03252          
       REM
       BCD 1ANS             
 B69   CLA ZERO          
       STO TEMP          
       CAL ONES          
       ANS TEMP          
       CLA TEMP          
       TZE B69+8
       TSX ERROR-1,4          
       TRA 03262          
       TPL 03274          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03262          
       REM
       BCD 1ANS             
 B70   CLA ONES          
       STO TEMP          
       CAL ZERO          
       ANS TEMP          
       CLA TEMP          
       ALS 1          
       TZE 03307          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03277          
       REM
       BCD 1ANS             
 B71   CLA KK30          
       STO TEMP          
       CAL KK35          
       ANS TEMP          
       SUB KK35          
       TZE 03322          
       TSX ERROR-1,4          
       TRA 03312          
       CLA TEMP          
       SUB KK32          
       TZE 03326          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03312          
       REM
       BCD 1ORA             
 B72   CLA ZERO          
       ORA ONES          
       PBT
       TRA 03336          
       TRA 03340          
       TSX ERROR-1,4          
       TRA 03331          
       ADD ONE          
       ALS 2          
       TZE 03344          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03331          
       REM
       BCD 1ORA             
 B73   CAL ONES          
       ORA ZERO          
       PBT
       TRA 03354          
       TRA 03356          
       TSX ERROR-1,4          
       TRA 03347          
       ADD ONE          
       ALS 2          
       TZE 03362          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03347          
       REM
       BCD 1ORA             
 B74   CLA KK36          
       ORA KK33          
       SUB KK37          
       PBT
       TRA 03373          
       TRA 03375          
       TSX ERROR-1,4          
       TRA 03365          
       ALS 2          
       TZE 03400          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03365          
       REM
       BCD 1ORA             
 B75   CLA KK36          
       ORA KK35          
       SUB KK38          
       TZE 03410          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03403          
       REM
       BCD 1ORS             
 B76   CLA ONES          
       STO TEMP          
       CLA ZERO          
       ORS TEMP          
       TZE 03422          
       TSX ERROR-1,4          
       TRA 03413          
       CLA TEMP          
       ADD MONE          
       PBT
       TSX ERROR,4          
       TSX OK,4          
       TRA 03413          
       REM
       BCD 1ORS             
 B77   CLA ZERO          
       STO TEMP          
       CAL ONES          
       ORS TEMP          
       ADD ONE          
       PBT
       TRA 03442          
       TSX ERROR-1,4          
       TRA 03431          
       CLA TEMP          
       ADD MONE          
       TOV 03446          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03431          
       REM
       BCD 1ORA             
 B78   CLA KK36          
       STO TEMP          
       CLA KK33          
       ORS TEMP          
       CLA TEMP          
       SUB KK37          
       TZE 03461          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03451          
       REM
       BCD 1ORS             
 B79   CLA KK36          
       STO TEMP          
       CAL KK36          
       ORS TEMP          
       CLA TEMP          
       ADD KK38          
       TZE 03474          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03464          
       REM
       BCD 1TTR             
 B80   TOV 03500          
       TTR 03502          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03477          
       REM
       BCD 1ETM-            
 B81   ETM          
       CLA KK85          
       STO 1          
       CLA ZERO          
       TZE 03512          
       LTM          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03505          
       REM
       BCD 1ETM-            
 B82   ETM          
       TTR 03526          
       LTM          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03517          
       REM
       BCD 1ETM-            
 B83   ETM          
       CLA KK80          
       STO 1          
       CLA KK81          
       STO 0          
       TRA 03534          
       LTM          
       TSX ERROR-1,4          
       TRA 03526          
       LTM          
       CLA 0          
       SUB KK82          
       TZE 03544          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03526          
       REM
       BCD 1ETM-            
 B84   ETM          
       CLA KK83          
       STO 1          
       LDQ 8CF          
       CLM          
       STO 0          
       TNZ 03610          
       TMI 03610          
       TOV 03610          
       TLQ 03610          
       LXA ZERO,1          
       TXH  03610,1,0          
       TIX  03610,1,00010          
       CLA ONES          
       TZE 03610          
       TPL 03610          
       ALS 00014          
       TNO 03610          
       LXA 8CF,1          
       TNX  03610,1,1          
       TXL  03610,1,1          
       LDQ MZE          
       TQP 03610          
       TQP 03610          
 B84A  LTM          
       CLA 0          
       SUB KK86          
       TZE 03604          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03547          
       REM
       BCD 1ETM-            
 B84B  TRA 03615          
 B84C  LTM          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03547          
       REM
       BCD 1ETM-            
 B85   ETM          
       CLA KK85A          
       STO TEMP          
       CLA KK84          
       STO 1          
       TTR 03635          
       CLA 0          
       LDQ TEMP          
       CAS TEMP          
       TTR 03655          
       TTR 03631          
       TTR 03655          
       ADD TWO          
       STA 03634          
       STA TEMP          
       TTR 0          
       ALS 00062          
       STZ 0          
       TZE 03651          
       TTR 03651          
       TPL 03651          
       TTR 03651          
       TOV 03651          
       TTR 03651          
       TNO 03651          
       TTR 03651          
       LTM          
       TRA 03660          
 B85A  LTM          
       TSX ERROR-1,4          
       TRA 03615          
       TRA 03660          
 B85B  LTM          
       TSX ERROR-1,4          
       TRA 03615          
 B86   ETM          
       CLA KK85B          
       STO TEMP          
       CLA ONES          
       TMI B86A   
       TTR B86A  
       TNZ B86A  
       TTR B86A  
       LTM          
       TRA 03675          
 B86A  LTM          
       TSX ERROR-1,4          
       TRA 03615          
 B87   ETM          
       CLA KK85C          
       STO TEMP          
       LDQ ONE          
       TQP 03705          
       TTR 03705          
       LTM          
       TRA 03710          
 B87A  LTM          
       TSX ERROR-1,4          
       TRA 03615          
 B88   ETM          
       CLA KK85D          
       STO TEMP          
       TXI  03731,1,00011          
       TTR 03731          
       TXH  03731,1,0          
       TTR 03731          
       TXL  03731,0,0          
       TTR 03731          
       TIX  03731,1,1          
       TTR 03731          
       TNX  03731,1,77777          
       TTR 03731          
       TSX 03731,1          
       TTR 03731          
       LTM          
       TRA 03733          
 B88A  LTM          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03615          
       NOP          
       CLA 06564          
       STO 0          
       TRA 03742          
       REM
       BCD 1SLT             
 B89   SLF          
       MSE 00141          
       TRA 03747          
       TSX ERROR-1,4          
       TRA 03742          
 B90   MSE 00142          
       TRA 03753          
       TSX ERROR-1,4          
       TRA 03742          
 B91   MSE 00143          
       TRA 03757          
       TSX ERROR-1,4          
       TRA 03742          
 B92   MSE 00144          
       TRA 03762          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03742          
       REM
       BCD 1SLT 1           
 B93   SLN 1          
       MSE 00141          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03765          
       REM
       BCD 1SLT 2           
 B94   SLN 2          
       MSE 00142          
       TSX ERROR,4          
       TSX OK,4          
       TRA 03773          
       REM
       BCD 1SLT 3           
 B95   SLN 3          
       MSE 00143          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04001          
       REM
       BCD 1SLT 4           
 B96   SLN 4          
       MSE 00144          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04007          
       REM
       BCD 1SLT             
 B93A  MSE 00141          
       TRA 04021          
       TSX ERROR-1,4          
       TRA 04015          
       MSE 00142          
       TRA 04025          
       TSX ERROR-1,4          
       TRA 04015          
       MSE 00143          
       TRA 04031          
       TSX ERROR-1,4          
       TRA 04015          
       MSE 00144          
       TRA 04034          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04015          
       REM
       BCD 1NOP             
 B96A  SLF          
       NOP          
       MSE 00141          
       TRA 04044          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04037          
       REM
       BCD 1SWT             
 B98   CLA KK87          
       STO 04100          
       CLA ZERO          
       SWT 1          
       TRA 04055          
       CLA SW1          
       SWT 2          
       TRA 04060          
       ORA SW2          
       SWT 3          
       TRA 04063          
       ORA SW3          
       SWT 4          
       TRA 04066          
       ORA SW4          
       SWT 5          
       TRA 04071          
       ORA SW5          
       SWT 6          
       TRA 04074          
       ORA SW6          
       NOP          
       TRA 04100          
       TSX ERROR-1,4          
       TRA 04047          
 B98A  TRA 04101          
       STO TEMP          
       LDQ TEMP          
       CLA KK88          
       STO 04100          
       TRA 04051          
 B98B  SUB TEMP          
       TZE 04111          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04047          
       REM
       BCD 1STT             
 A1    CLM          
       SLW TEMP          
       CLA ONES          
       STT TEMP          
       LDQ ONES          
       CAS ONES          
       TRA 04124          
       TRA 04126          
       TSX ERROR-1,4          
       TRA 04114          
 A2    CLA TEMP          
       LDQ K2          
       CAS K2          
       TRA 04133          
       TRA 04134          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04114          
       REM
       BCD 1STT             
 A2A   CLA ONES          
       STO TEMP          
       CLM          
       STT TEMP          
       CLA TEMP          
       LDQ K3          
       CAS K3          
       TRA 04150          
       TRA 04151          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04137          
       REM
       BCD 1STZ             
 A3    CLA ONES          
       STO TEMP          
       LDQ 04156          
       STZ TEMP          
       STQ TEMP+1          
       LDQ ONES          
       CAS ONES          
       TRA 04165          
       TRA 04167          
       TSX ERROR-1,4          
       TRA 04154          
 A3A   CLA TEMP+1          
       LDQ 04156          
       CAS 04156          
       TRA 04174          
       TRA 04176          
       TSX ERROR-1,4          
       TRA 04154          
 A4    CLA TEMP          
       TZE 04201          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04154          
       REM
       BCD 1XCA             
 A5    CLA ONE          
       LDQ MZE          
       XCA          
       TMI 04212          
       TSX ERROR-1,4          
       TRA 04204          
 A5A   TZE 04215          
       TSX ERROR-1,4          
       TRA 04204          
 A5A1  LLS 35          
       LDQ ONE          
       CAS ONE          
       TRA 04222          
       TRA 04223          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04204          
       REM
       BCD 1XCA             
 A6    CLA K3          
       LDQ K2          
       XCA          
       STQ TEMP          
       LDQ K2          
       CAS K2          
       TRA 04236          
       TRA 04240          
       TSX ERROR-1,4          
       TRA 04226          
 A6A   CLA TEMP          
       LDQ K3          
       CAS K3          
       TRA 04245          
       TRA 04246          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04226          
       REM
       BCD 1XCA             
 A7X   CLA ONES          
       ALS 3          
       LDQ K3          
       XCA          
       STQ TEMP          
       LDQ K3          
       CAS K3          
       TRA 04262          
       TRA 04264          
       TSX ERROR-1,4          
       TRA 04251          
 A7A   CLA TEMP          
       LDQ K6          
       CAS K6          
       TRA 04271          
       TRA A7A+6 
       TSX ERROR,4          
       TSX OK,4          
       TRA 04251          
       REM
       BCD 1XCL             
 A10X  CLA ONE          
       LDQ MZE          
       XCL          
       PBT
       TRA 04303          
       TRA 04305          
       TSX ERROR-1,4          
       TRA 04275          
 A10A  ARS 2          
       STQ TEMP          
       LDQ PTHR          
       CAS PTHR          
       TRA 04313          
       TRA 04315          
       TSX ERROR-1,4          
       TRA 04275          
 A10A1 CLA TEMP          
       LDQ ONE          
       CAS ONE          
       TRA 04322          
       TRA 04323          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04275          
       REM
       BCD 1XCL             
 A12X  CAL ONES          
       LDQ ZERO       CLEAR MQ         
       XCL          
       TZE 04334          
       TSX ERROR-1,4          
       TRA 04326          
 A12A  LLS 35          
       LDQ ONES          
       CAS ONES          
       TRA 04341          
       TRA 04342          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04326          
       REM
       BCD 1XCL             
 A13X  CLA K10          
       ALS 2          
       LDQ ONES          
       XCL          
       ARS 1          
       STQ TEMP          
       LDQ PONES          
       CAS PONES          
       TRA 04357          
       TRA 04361          
       TSX ERROR-1,4          
       TRA 04345          
 A13A  CLA TEMP          
       TMI 04365          
       TSX ERROR-1,4          
       TRA 04345          
 A13A1 TZE 04367          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04345          
       REM
       BCD 1ERA             
 A14X  CAL ONES          
       SLW TEMP          
       ERA TEMP          
       TZE 04400          
       TSX ERROR-1,4          
       TRA A14X  
 A14A  CLA TEMP          
       LDQ ONES          
       CAS ONES          
       TRA 04405          
       TRA 04406          
       TSX ERROR,4          
       TSX OK,4          
       TRA A14X             
       REM
       BCD 1ERA             
 A15X  CAL ONES          
       ERA ZERO          
       SLW TEMP          
       CLA TEMP          
       LDQ ONES          
       CAS ONES          
       TRA 04421          
       TRA 04422          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04411          
       REM
       BCD 1ERA             
 A16X  CLA ZERO          
       ERA ONES          
       SLW TEMP          
       CLA TEMP          
       LDQ ONES          
       CAS ONES          
       TRA 04435          
       TRA 04436          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04425          
       REM
       BCD 1ERA             
 A17   CLA K10          
       ALS 3          
       ERA ZERO          
       TPL 04447          
       TSX ERROR-1,4          
       TRA 04441          
 A17A  TZE 04451          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04441          
       REM
       BCD 1LGR             
 A20   CLA ONE          
       LDQ ZERO       CLEAR MQ         
       LGR 1          
       TZE 04462          
       TSX ERROR-1,4          
       TRA 04454          
 A20A  LLS 35          
       TMI 04466          
       TSX ERROR-1,4          
       TRA 04454          
 A20A1 TZE 04470          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04454          
       REM
       BCD 1LGR             
 A21X  LDQ MZE          
       CLM          
       LGR 35          
       LLS 35          
       LDQ ONE          
       CAS ONE          
       TRA 04503          
       TRA 04504          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04473          
       REM
       BCD 1LGR             
 A22X  CLA ONES          
       ALS 3          
       LGR 36          
       CHS          
       STQ TEMP          
       LDQ ONE          
       CAS ONE          
       TRA 04520          
       TRA 04522          
       TSX ERROR-1,4          
       TRA 04507          
 A22A  CLA TEMP          
       LDQ K6          
       CAS K6          
       TRA 04527          
       TRA 04530          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04507          
       REM
       BCD 1ZET             
 A23X  CLA ONES          
       ZET ZERO          
       TRA 04537          
       TRA 04541          
       TSX ERROR-1,4          
       TRA 04533          
 A23A  LDQ ONES          
       CAS ONES          
       TRA 04545          
       TRA 04546          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04533          
       REM
       BCD 1ZET             
 A24X  ZET MZE          
       TRA 04554          
       TRA 04555          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04551          
       REM
       BCD 1ZET             
 A24A  CLA ONE          
       STO TEMP          
       ZET TEMP          
       TRA 04566          
       TSX ERROR-1,4          
       TRA 04560          
 A24A1 CLA TEMP          
       LDQ ONE          
       CAS ONE          
       TRA 04573          
       TRA 04574          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04560          
       REM
       BCD 1ZET             
 24A   CLM          
       CLA ONE          
       STO TEMP          
       ZET TEMP          
       TRA 04606          
       TSX ERROR-1,4          
       TRA 04577          
 24B   ALS 1          
       PBT
       TRA 04601          
       SLW TEMP          
       ZET TEMP          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04577          
       REM
       BCD 1ZET             
 24C   CLM          
       SLW TEMP          
       ZET TEMP          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04617          
       REM
       BCD 1NZT             
 A25X  CLA ONE          
       STO TEMP          
       NZT TEMP          
       TRA 04633          
       TRA 04635          
       TSX ERROR-1,4          
       TRA 04626          
 A25A  LDQ ONE          
       CAS ONE          
       TRA 04641          
       TRA 04643          
       TSX ERROR-1,4          
       TRA 04626          
 A25A1 CLA TEMP          
       CAS ONE          
       TRA 04647          
       TRA 04650          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04626          
       REM
       REM
       BCD 1NZT             
 A26X  NZT ZERO          
       TRA 04656          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04653          
       REM
       BCD 1NZT             
 26A   CLM          
       CLA ONE          
       STO TEMP          
       NZT TEMP          
       TRA 04667          
       TRA 04671          
       TSX ERROR-1,4          
       TRA 04661          
 26B   ALS 1          
       PBT
       TRA 04663          
       SLW TEMP          
       NZT TEMP          
       TRA 04700          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04661          
       REM
       BCD 1NZT             
 26C   CLM          
       SLW TEMP          
       NZT TEMP          
       TRA 04710          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04703          
       REM
       BCD 1LAS             
 A72X  CLA ONES          
       STO TEMP          
       CAL MZE          
       ALS 1          
       LAS TEMP          
       TRA 04724          
       TRA 04722          
       TSX ERROR-1,4          
       TRA 04713          
 A27A  LDQ ZERO       CLEAR MQ         
       ARS 2          
       ADD MTW          
       TZE 04732          
       TSX ERROR-1,4          
       TRA 04713          
 A27A1 CLA TEMP          
       LDQ ONES          
       CAS ONES          
       TRA 04737          
       TRA 04740          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04713          
       REM
       BCD 1LAS             
 A28X  CLA K3          
       LAS K2          
       TRA 04750          
       TRA 04747          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04743          
       REM
       BCD 1LAS             
 A29X  CLA MTW     MAKE ACC NEGATIVE         
       ALS 1          
       LAS MTW          
       TRA 04757          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04753          
       REM
       BCD 1LAS             
 A30X  CAL MZE          
       LAS MZE          
       TRA 04767          
       TRA 04770          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04763          
       REM
       BCD 1VLM             
 A31X  LDQ ONES          
       VLM ONE, 000          
       TMI 05000          
       TSX ERROR-1,4          
       TRA 04773          
 A31A  TZE 05003          
       TSX ERROR-1,4          
       TRA 04773          
 A31A1 LLS 35          
       LDQ ONES          
       CAS ONES          
       TRA 05010          
       TRA 05011          
       TSX ERROR,4          
       TSX OK,4          
       TRA 04773          
       REM
       BCD 1VLM             
 A32X  LDQ ONES          
       VLM K2, 000          
       ALS 1          
       CHS          
       LDQ K2          
       CAS K2          
       TRA 05024          
       TRA 05025          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05014          
       REM
       BCD 1VLM             
 A33X  LDQ ONES          
       CLA ONES          
       VLM K2, 000          
       CHS          
       STQ TEMP          
       LDQ K11          
       CAS K11          
       TRA 05041          
       TRA 05043          
       TSX ERROR-1,4          
       TRA 05030          
 A33A  CLA TEMP          
       CHS          
       LDQ K12          
       CAS K12          
       TRA 05051          
       TRA 05052          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05030          
       REM
       BCD 1VLM             
 A34X  LXA K37A,1          
       LDQ K6          
       VLM K25, 000,1          
       LLS 1          
       CHS          
       STQ TEMP          
       LDQ K3          
       CAS K3          
       TRA 05067          
       TRA 05071          
       TSX ERROR-1,4          
       TRA 05055          
 A34AA CLA TEMP          
       LDQ K13          
       CAS K13          
       TRA 05076          
       TRA 05077          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05055          
       REM
       BCD 1VLM             
 A34A  CLA K24          
       LDQ K24          
       VLM ONES, 000          
       STQ TEMP          
       LDQ K24          
       CAS K24          
       TRA 05112          
       TRA 05114          
       TSX ERROR-1,4          
       TRA 05102          
 A34B  CLA TEMP          
       CAS K24          
       TRA 05120          
       TRA 05121          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05102          
       REM
       BCD 1VLM             
 A34C  CLA ONES          
       LDQ ONES          
       VLM ZERO, 000          
       STQ TEMP          
       LDQ ONES          
       CAS ONES          
       TRA 05134          
       TRA 05136          
       TSX ERROR-1,4          
       TRA 05124          
 A34D  CLA TEMP          
       CAS ONES          
       TRA 05142          
       TRA 05143          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05124          
       REM
       BCD 1VLM             
 A34E  CLA ONES          
       LDQ ONES          
       VLM ZERO, 000          
       TMI 05154          
       TSX ERROR-1,4          
       TRA 05146          
 A34E1 TZE 05157          
       TSX ERROR-1,4          
       TRA 05146          
 A34F  STQ TEMP          
       CLA TEMP          
       TMI 05164          
       TSX ERROR-1,4          
       TRA 05146          
 A34F1 TZE 05166          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05146          
       REM
       BCD 1VLM             
 A34G  CLA ONES          
       LDQ ONES          
       VLM MZE, 000          
       TPL 05177          
       TSX ERROR-1,4          
       TRA 05171          
 A34G1 TZE 05202          
       TSX ERROR-1,4          
       TRA 05171          
 A34H  STQ TEMP          
       CLA TEMP          
       TPL 05207          
       TSX ERROR-1,4          
       TRA 05171          
 A34H1 TZE 05211          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05171          
       REM
       BCD 1VDP             
 A35X  LDQ ONES          
       CLA MZE          
       VDP ONE,0,35
       TMI 05222          
       TSX ERROR-1,4          
       TRA 05214          
 A35A  TZE 05225          
       TSX ERROR-1,4          
       TRA 05214          
 A35A1 LLS 35          
       LDQ ONES          
       CAS ONES          
       TRA 05232          
       TRA 05233          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05214          
       REM
       BCD 1VDP             
 A36X  LDQ K8          
       CLA K14          
       VDP K2,0,1
       TMI 05244          
       TSX ERROR-1,4          
       TRA 05236          
 A36A  TZE 05247          
       TSX ERROR-1,4          
       TRA 05236          
       LLS 35          
       LDQ ONES          
       CAS ONES          
       TRA 05254          
       TRA 05255          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05236          
       REM
       BCD 1VDP             
 A37X  LDQ K12          
       CLA K11          
       VDP K2, 000          
       TPL 05266          
       TSX ERROR-1,4          
       TRA 05260          
 A37A  TZE 05271          
       TSX ERROR-1,4          
       TRA 05260          
 A37A1 LLS 35          
       CHS          
       LDQ ONES          
       CAS ONES          
       TRA 05277          
       TRA 05300          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05260          
       REM
       BCD 1VDP             
 A40X  LXA K37A,1          
       CLS K3          
       LDQ K13          
       LRS 1          
       VDP K25,1,4          
       TPL 05313          
       TSX ERROR-1,4          
       TRA 05303          
 A40A  TZE 05316          
       TSX ERROR-1,4          
       TRA 05303          
 A40A1 LLS 35          
       LDQ K6          
       CAS K6          
       TRA 05323          
       TRA 05324          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05303          
       REM
       BCD 1VDP             
 A41X  DCT          
       NOP          
       LDQ K36          
       CLA K2          
       VDP K2,0,18
       DCT          
       TRA 05340          
       TSX ERROR-1,4          
       TRA 05327          
 A41AA STQ TEMP          
       LDQ K2          
       CAS K2          
       TRA 05345          
       TRA 05347          
       TSX ERROR-1,4          
       TRA 05327          
 A41AB CLA TEMP          
       LDQ K36          
       CAS K36          
       TRA 05354          
       TRA 05355          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05327          
       REM
       BCD 1VDP             
 A41A  CLA K11          
       DCT          
       NOP          
       LDQ K11          
       VDP K2, 000          
       STQ TEMP          
       LDQ K11          
       CAS K11          
       TRA A41A+10
       TRA 05374          
       TSX ERROR-1,4          
       TRA 05360          
 A41B  CLA TEMP          
       CAS K11          
       TRA 05400          
       TRA 05402          
       TSX ERROR-1,4          
       TRA 05360          
 A41C  DCT          
       TRA 05405          
       TRA 05406          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05360          
       REM
       BCD 1VDH             
 A42X  LDQ ONES          
       CLA MZE          
       VDH ONE, 000          
       TMI 05417          
       TSX ERROR-1,4          
       TRA 05411          
 A42A  TZE 05422          
       TSX ERROR-1,4          
       TRA 05411          
 A42A1 LLS 35          
       LDQ ONES          
       CAS ONES          
       TRA 05427          
       TRA 05430          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05411          
       REM
       BCD 1VDH             
 A43X  LDQ K8          
       CLA K14          
       VDH K2, 000          
       TMI 05441          
       TSX ERROR-1,4          
       TRA 05433          
 A43A  TZE 05444          
       TSX ERROR-1,4          
       TRA 05433          
 A43A1 LLS 35          
       LDQ ONES          
       CAS ONES          
       TRA 05451          
       TRA 05452          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05433          
       REM
       BCD 1VDH             
 A44X  LDQ K12          
       CLA K11          
       VDH K2, 000          
       TPL 05463          
       TSX ERROR-1,4          
       TRA 05455          
 A44A  TZE 05466          
       TSX ERROR-1,4          
       TRA 05455          
 A44A1 LLS 35          
       CHS          
       LDQ ONES          
       CAS ONES          
       TRA 05474          
       TRA 05475          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05455          
       REM
       BCD 1VDH             
 A45X  LXA K37A,1          
       CLS K3          
       LDQ K13          
       LRS 1          
       VDH K25, 000,1          
       TPL 05510          
       TSX ERROR-1,4          
       TRA 05500          
 A45A  TZE 05513          
       TSX ERROR-1,4          
       TRA 05500          
       LLS 35          
       LDQ K6          
       CAS K6          
       TRA 05520          
       TRA 05521          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05500          
       REM
       BCD 1CVR             
 A47X  LXA ZERO,1          
       CLA K2          
       CVR K15, 000,1          
       LDQ K2          
       CAS K2          
       TRA 05533          
       TRA 05535          
       TSX ERROR-1,4          
       TRA 05524          
       CLA 15630,1          
       LDQ K15          
       CAS K15          
       TRA 05542          
       TRA 05543          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05524          
       REM
       BCD 1CVR             
 A50X  LXA ZERO,1          
       CAL K2          
       CVR ONES, 000          
       SLW TEMP          
       ARS 1          
       PBT 
       TRA 05557          
       TSX ERROR-1,4          
       TRA 05546          
 A50A  CLA TEMP,1          
       LDQ K15+1          
       CAS K15+1          
       TRA 05564          
       TRA 05565          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05546          
       REM
       BCD 1CVR             
 A51X  LXA ZERO,1          
       CAL ONE          
       CVR ZERO, 000          
       SLW TEMP          
       ARS 1          
       PBT 
       TRA 05601          
       TSX ERROR-1,4          
       TRA 05570          
 A51A  CLA TEMP,1          
       LDQ SW1          
       CAS SW1          
       TRA 05606          
       TRA 05607          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05570          
       REM
       BCD 1CVR             
 A52X  CAL K16          
       CVR K16, 000,1          
       LDQ 15651,1          
       CAS K16B          
       TRA 05620          
       TRA 05621          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05612          
       REM
       BCD 1CVR             
 A53X  CAL K17+1          
       ALS 1          
       CVR K16+3, 000          
       LDQ K32          
       LAS K32          
       TRA 05633          
       TRA 05634          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05624          
       REM
       BCD 1CAQ             
 A54X  LDQ K16          
       CLA MZE          
       CAQ K16, 000          
       TMI 05645          
       TSX ERROR-1,4          
       TRA 05637          
 A54A  TZE 05650          
       TSX ERROR-1,4          
       TRA 05637          
 A54A1 LLS 35          
       LDQ K16          
       CAS K16          
       TRA 05655          
       TRA 05656          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05637          
       REM
       BCD 1CAQ             
 A55X  LXA ZERO,1          
       LDQ K16          
       CLA ZERO          
       CAQ K15+2, 000          
       STQ TEMP          
       LDQ K16          
       CAS K16          
       TRA *+2   
       TRA 05674          
       TSX ERROR-1,4          
       TRA 05661          
 A55A  CLA TEMP,1          
       LDQ K15+2          
       CAS K15+2          
       TRA 05701          
       TRA 05702          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05661          
       REM
       BCD 1CAQ             
 A56X  TOV 05706          
       LDQ K16          
       CLA ZERO          
       CAQ K16, 000,1          
       SLW TEMP          
       ARS 1          
       PBT
       TRA 05716          
       TRA 05720          
       TSX ERROR-1,4          
       TRA 05705          
 A56A1 STQ TEMP+1          
       CLA 15756,1          
       LDQ K16+7          
       CAS K16+7          
       TRA 05726          
       TRA 05730          
       TSX ERROR-1,4          
       TRA 05705          
       CLA TEMP+1          
       LDQ K16          
       CAS K16          
       TRA 05735          
       TRA 05736          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05705          
       REM
       BCD 1CAQ             
 A57X  CLA K14          
       LDQ K16          
       CAQ K16B, 000          
       SLW TEMP          
       ARS 1          
       PBT 
       TRA 05752          
       TSX ERROR-1,4          
       TRA 05741          
 A57A  CLA TEMP          
       LDQ K16+8          
       CAS K16+8          
       TRA 05757          
       TRA 05760          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05741          
       REM
       BCD 1CAQ             
 A60X  LXA 8CF,1          
       CLA ZERO          
       LDQ K16          
       CAQ K16, 000,6          
       LDQ K16+1          
       CAS K16+1          
       TRA 05773          
       TRA 05775          
       TSX ERROR-1,4          
       TRA 05763          
 A60A  CLA K12,1          
       LDQ K13          
       CAS K13          
       TRA 06002          
       TRA 06003          
       TSX ERROR,4          
       TSX OK,4          
       TRA 05763          
       REM
       BCD 1CAQ             
 A61X  CLA ZERO          
       LDQ K16+1          
       CAQ K15-17,1,1          
       LDQ K15          
       CAS K15          
       TRA 06015          
       TRA 06017          
       TSX ERROR-1,4          
       TRA 06006          
 A61AX CLA 12335,1          
       LDQ K20          
       CAS K20          
       TRA 06024          
       TRA 06025          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06006          
       REM
       BCD 1CRQ             
 A62X  LXA 8CF,1          
       CLA ONES          
       LDQ K16          
       CRQ K16, 000          
       STQ TEMP          
       LDQ ONES          
       CAS ONES          
       TRA 06041          
       TRA 06043          
       TSX ERROR-1,4          
       TRA 06030          
 A62AX CLA TEMP          
       LDQ K16          
       CAS K16          
       TRA 06050          
       TRA 06052          
       TSX ERROR-1,4          
       TRA 06030          
 A62B  CLA K16B,1          
       LDQ K17          
       CAS K17          
       TRA 06057          
       TRA 06060          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06030          
       REM
       BCD 1CRQ             
 A63X  CLA ZERO          
       LDQ K16          
       CRQ K16, 000,1          
       TZE 06071          
       TSX ERROR-1,4          
       TRA 06063          
 A63AX LLS 35          
       LDQ K16A          
       CAS K16A          
       TRA 06076          
       TRA 06100          
       TSX ERROR-1,4          
       TRA 06063          
 A63BX CLA 15633,1          
       LDQ K15          
       CAS K15          
       TRA 06105          
       TRA 06106          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06063          
       REM
       BCD 1CRQ             
 A64X  LXA ZERO,1          
       LDQ K16          
       CRQ K16,0,6          
       CLM          
       LLS 35          
       LDQ K16B,1          
       CAS K16B,1          
       TRA 06122          
       TRA 06123          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06111          
       REM
       BCD 1CRQ             
       LXA ZERO,1          
       LDQ SW1          
       CRQ K15-60,0,1          
       CLM          
       LLS 35          
       SUB ONE          
       TZE 06136          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06126          
       REM
       BCD 1STL             
 A65X  CLA ONES          
       STO TEMP          
       STL TEMP          
       LDQ ONES          
       CAS ONES          
       TRA 06150          
       TRA 06152          
       TSX ERROR-1,4          
       TRA 06141          
 A65A  CLA TEMP          
       LDQ K23          
       CAS K23          
       TRA 06157          
       TRA 06160          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06141          
       REM
       BCD 1STR-            
 65A   CLA ONES          
       STO 0          
       CLA K37B          
       STO 1          
       CLA K37C          
       STO 2          
       CLA K37D          
       STO 3          
       CLA K37E          
       STO 00012          
       CLA K37E1          
       STO 00013          
       CLA K37E2          
       STO 00014          
       CLA K37E2          
       STO 00015          
       LXA 1CF,7          
       STR           
       TXL  06230,7,77777          
 65A1  TSX ERROR-1,4          
       TRA 06163          
 65A2  TRA 06232          
 65A3  TSX ERROR-1,4          
       TRA 06163          
       TRA 06232          
 65A4  TSX ERROR-1,4          
       TRA 06163          
       TRA 06232          
 65A4A TSX ERROR-1,4          
       TRA 06163          
       TRA 06232          
 65A4B TSX ERROR-1,4          
       TRA 06163          
       TRA 06232          
 65A4C TSX ERROR-1,4          
       TRA 06163          
       TRA 06232          
 65A4D TSX ERROR-1,4          
       TRA 06163          
 65A5  CLA 0          
       LDQ K37G          
       CAS K37G          
       TRA 06237          
       TRA 06241          
       TSX ERROR-1,4          
       TRA 06163          
 65A6  CLA 06204          
       CHS          
       LDQ K8          
       CAS K8          
       TRA 06247          
       TRA 06251          
       TSX ERROR-1,4          
       TRA 06163          
 65A7  CLA 06205          
       LDQ K37E4          
       CAS K37E4          
       TRA 06256          
       TRA 06260          
       TSX ERROR-1,4          
       TRA 06163          
 65A8  PXA 0, 1          
       LDQ 1CF          
       CAS 1CF          
       TRA 06265          
       TRA 06267          
       TSX ERROR-1,4          
       TRA 06163          
       PXA 0, 2          
       LDQ 1CF          
       CAS 1CF          
       TRA 06274          
       TRA 06276          
       TSX ERROR-1,4          
       TRA 06163          
       PXA 0, 4          
       LDQ 1CF          
       CAS 1CF          
       TRA 06303          
       TRA 06304          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06163          
       NOP          
       CLA 06564          
       STO 0          
       TRA 06313          
       REM
       BCD 1ADD             
 M06   CLA ZERO          
       COM          
       ADD ONE          
       TZE 06321          
       TSX ERROR-1,4          
       TRA 06313          
       TOV 06323          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06313          
       REM
       BCD 1ADD             
 M07   CAL ONES          
       ACL ONES          
       SLW TEMP          
       CLA TEMP          
       SUB ONES          
       TZE 06335          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06326          
       NOP          
 AAA   SWT 5          
       TRA 06563          
       CLA PLUS+3 
       STO 06342          
       TRA 06346          
       REM
       BCD 1DVH             
 B59   CLA ONE          
       DVH ZERO          
       SUB ONE          
       TZE 06353          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06346          
       REM
       BCD 1DVH             
 B60   CLA ONE          
       DVH ONE          
       SUB ONE          
       TZE 06363          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06356          
       REM
       BCD 1DVH             
 B61   CLA PTW     MAKE ACC POSITIVE         
       ALS 2          
       DVH PTW          
       TNZ 06373          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06366          
       REM
       BCD 1VDH             
 A46X  DCT          
       TRA 06400          
       LDQ K36          
       CLA K2          
       VDH K2, 000          
       DCT          
       TRA 06407          
       TSX ERROR-1,4          
       TRA 06376          
 A46A  STQ TEMP          
       LDQ K2          
       CAS K2          
       TRA 06414          
       TRA 06416          
       TSX ERROR-1,4          
       TRA 06376          
 A46A1 CLA TEMP          
       LDQ K36          
       CAS K36          
       TRA 06423          
       TRA 06424          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06376          
       REM
       BCD 1ENK             
 KY    HTR 06430          
       ENK          
       CLM          
       LLS 35          
       LDQ ONES          
       CAS ONES          
       TRA 06437          
       TRA 06441          
       TSX ERROR-1,4          
       TRA 06427          
       HTR 06442          
 KY1   ENK          
       CLM          
       LLS 35          
       TZE 06447          
       TSX ERROR,4          
       TSX OK,4          
       TRA 06427          
       REM
       REM
       BCD 1ADD             
 ADD   LXA 1CF,2          
       CLA 4095,2          
       COM          
       ADD 4095,2          
       TOV 06457          
       TPL 06467          
       TMI 06463          
       TSX ERROR-1,4          
       TRA 06452          
 MINUS SUB ONE          
       TZE 06473          
       TSX ERROR-1,4          
       TRA 06452          
 PLUS  ADD ONE          
       TZE 06473          
       TSX ERROR-1,4          
       TRA 06452          
 OVFL  TNO 06502          
       TOV 06505          
       CLA 4095,2          
       CAS 4095,2          
       TRA 06510          
       TRA 06516          
       TRA 06513          
 SS    TSX ERROR-1,4          
       TRA 06452          
       TRA 06475          
 SS1   TSX ERROR-1,4          
       TRA 06452          
       TRA 06475          
 TT    TSX ERROR-1,4          
       TRA 06452          
       TRA 06475          
 TT1   TSX ERROR-1,4          
       TRA 06452          
       TRA 06475          
 LOOP  TIX  06453,2,1          
       TRA 06521          
       REM
       BCD 1MPY             
 MPY   LXA 1CF,2          
       LXA 06524,1          
       LDQ ONE          
       RQL 35,1          
       STQ TEMP          
       MPY 4095,2          
       LRS 35,1          
       TZE 06533          
       TSX ERROR-1,4          
       TRA 06521          
       STQ TEMP+1          
       CLA TEMP+1          
       SUB 4095,2          
       TZE 06541          
       TSX ERROR-1,4          
       TRA 06521          
       TIX  06523,1,1          
       TIX  06522,2,1          
       TRA 06545          
       BCD 1DVP
 DVP   LXA 1CF,1          
       LDQ 4095,1          
       MPY ONE          
       DVP ONE          
       TZE 06554          
       TSX ERROR-1,4          
       TRA 06545          
       STQ TEMP          
       CLA 4095,1          
       SUB TEMP          
       TZE 06562          
       TSX ERROR-1,4          
       TRA 06545          
       TIX 06546,1,1          
 END   TSX PR100,4          
       TRA START-2          
       REM
 PR100 SWT 6          
       TRA CRSL          
       SWT 3          
       TRA BAR          
       TRA 1,4          
 BAR   CLA TOP          
       SUB HAT          
       STO TOP          
       TNZ 1,4          
       CLA TOP+1          
       STO TOP          
       LXA ATTA,1          
       WPRA
       SPRA 3
       RCHA CW+2          
       LCHA CW+6          
 BOY   LCHA CW+3          
       LCHA CW+6          
       CLA CW+3          
       SUB CLUB          
       STA CW+3          
       TIX BOY,1,1          
       CLA CW+4          
       STO CW+3          
       TRA 1,4          
 TOP   OCT 144          
       OCT 144          
       OCT 0          
 CLUB  OCT 2          
 HAT   OCT 1          
 ATTA  OCT 13          
 CRSL  RCDA		LOAD
       RCHA CW+5          THE
       LCHA 0          NEXT
       TRA 1          PROGRAM
 ID    LXA ATTA,1          L 13 IN XRA
       WPRA               SELECT PRINTER
       SPRA 3         SPACE PRINTER
       RCHA CW          
       LCHA CW+6          
       LCHA CW+1          
       LCHA CW+6          
       CLA CW+1          
       SUB CLUB          
       STA CW+1          
       TIX  *-5,1,1          
       TRA START-4          
       REM
       REM PRINT IMAGE
       REM
 PI    OCT 1120402200      9 L
       OCT 440000010       9 R
       OCT 0               8 L
       OCT 0               8 R
       OCT 4004100000      7 L
       OCT 1102001000      7 R
       OCT 60600020000     6 L
       OCT 200004000       6 R
       OCT 102010040000    5 L     
       OCT 100240          5 R
       OCT 41000100        4 L
       OCT 10002004        4 R
       OCT 5000            3 L
       OCT 10500           3 R
       OCT 10000           2 L
       OCT 640000          2 R
       OCT 200020          1 L
       OCT 20021000001     1 R
       OCT 20000014040     0 L
       OCT 14000640102     0 R
       OCT 145350060100    11L     
       OCT 1652007404      11R
       OCT 2425703000      12L
       OCT 121110240       12R
       REM
       REM CONSTANTS
       REM
 PONES OCT 377777777777          
 ZERO  OCT 0        
 ONES  OCT 777777777777          
 K2    OCT +000000700000          
 K3    OCT -377777077777          
 ONE   OCT 1          
 MZE   MZE 
 K6    OCT -377777777770          
 SW1   OCT -370000000000    
 PTHR  OCT 100000000000          
 K8    OCT +177777777777          
 K10   OCT -300000000000          
 K11   OCT +000000677771          
 K12   OCT +000003777777          
 K13   OCT 37777777776
 K14   OCT -000000340000
 K15   OCT 374000003400
       OCT -370000007000
       OCT 020304050601          
 K16   OCT +010203040506          
       TIX  K16,0,4096          
       TIX  K16,0,8192          
       TIX  K16,0,12288          
       TIX  K16,0,16384          
       TIX  K16,0,20480          
       TIX  K16,0,24576          
       TNX  6*K16,0,20480          
       STR  K37+65A1+16384,3          
       TIX  K16+9,0,4096          
 K16A  OCT 20304050621      
 K16B  OCT 212223242526          
 K17   MSE K37,0,3072
       OCT -374777770304          
 K20   OCT +265577177776           
 K21   OCT 352000004262         
 K22   OCT 770000162714            
 K23   TXL A65X+3,7,32767          
       TXL 3*K16,0,10240
 K24   OCT 111111111111           
 K25   OCT 154321654321          
 TWO   OCT 2          
 THREE OCT 3          
 1CF   OCT 7777          
 8CF   OCT 77777          
 MTW   MTW                         
 PTW   PTW                         
 K32   OCT 774777177776          
 MON   MON           
 MONE  OCT -000000000001   
 M2    OCT -000000000002    
 K36   OCT 377777777776            
 K37   OCT 374000000000            
 K37A  OCT 44000043       
 K37B  TRA 65A1          
 K37C  TRA 65A2          
 K37D  TRA 65A3          
 K37E  TRA 65A4          
 K37G  TXL 65A+18,7,32767          
 K37E1 TRA 65A4A          
 K37E2 TRA 65A4B          
 K37E3 TRA 65A4C          
 K37E4 TXL 65A4D,7,32767          
 M3    OCT -000000000003          
 KK30  OCT -252525252525          
 KK31  OCT -125252252525       
 KK32  OCT +000000252525          
 KK33  OCT -252525525252          
 KK34  OCT 252525000000          
 KK35  OCT +125252252525          
 KK36  OCT +252525252525          
 KK37  OCT 252525777777          
 KK38  OCT +377777252525    
 RTN   TRA B20+7          
       TRA B20+5          
 KK80  TTR B83+9          	SEE SECTION
 KK81  HTR B84            B83 FOR USE
 KK82  HTR B83+5            OF THESE ,KK 80,81,82
 KK83  TTR B84A          
 KK84  TTR B85+6          
 KK85  TTR B82          
 KK85A HTR B85A-10          
 KK85B HTR B86+4          
 KK85C HTR B87+4          
 KK85D HTR B88+3          
 KK86  HTR B84A-1          
 KK87  TRA B98A+1          
 KK88  TRA B98B          
 SW2   OCT +007700000000          
 SW3   OCT +000077000000          
 SW4   OCT +000000770000
 SW5   OCT +000000007700          
 SW6   OCT +000000000077          
       REM  CONTROL WORDS
 CW    IOCT PI,0,1
       IOCT PI+2,0,1
       IOCT PI+1,0,1
       IOCT PI+3,0,1
       IOCT PI+3,0,1
       IOCT 0,0,3
       IOCT TOP+2,0,1
       REM
       REM TEMPORARY STORAGE
       REM
 TEMP  OCT 0
       OCT 0
       REM  
* SENSE SWITCHES INTERROGATION AND DIAGNOSTIC
*            PRINT SUBROUTINE FOR 709
       TRA MOD
 ERROR STZ KONST    DO NOT REPEAT SECTION
       STZ KONST+1  IF SENSE SW 4 IS DOWN
       REM   
       REM   
       PSE 114      IF SENSE SW 2 IS UP THEN-
       TRA SSW3     CHECK SSW 3
       TIX OK,4,1
       REM     
       REM     
 OK    SXD LOC+1,4  2'S COMPL OF PROGRAM
       REM          LOCATION LAST PREFORMED
       REM    
       REM    
       PSE 113      IF SENSE SW 1 IS UP THEN
       TRA RELY     CHECK SS 4
       TRA 1,4      IF DOWN REPEAR SECTION
       REM          OF PROG
 SSW3  PSE 115      IF SENSE SW 3 IS UP
       TRA PRINT    PRINT ON ERROR
       REM          IF SS 3 IS DOWN STOP ON
       HTR OK-1     ERROR
       REM          HTR 2'S COMPLEMENT OF
       REM          INDEX REGISTER C
       REM          CONTIANS THE ERROR ADDRESS
       REM          OF THE SECTION OF THE
       REM          PROG IN ERROR
       REM
 RELY  PSE 116      IF SENSE SWITCH 5 IS UP
       TRA 3,4      GO TO NEXT SECTION OF
       REM          THE PROG
       REM          IF DOWN REPEAR SECTION
       REM          OF THE PROGRAM N TIMES
       REM          OR THE NUMEBR OF TIMES
       REM          THAT IS SPECIFIED IN LOC
       REM          KONST+2
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
 MOD   STZ KONST+4  SET STORAGE TO ZEROS
       STZ KONST+1
       STZ KONST
       REM    
       REM    
 ERR   PSE 114      IF SS 2 IS UP CHECK
       TRA SSW3A    SENSE SWITHC 3
       REM  
 OK2   PSE 113      SSW1 UP-GO TO NEXT ROUTINE
       TRA 2,4      EXIT
       TRA 1,4      REPEAT TEST
       REM  
 SSW3A PSE 115      IS SENSE SWITCH 3 IS UP
       TRA PRINT    PRINT ERROR
       REM          2'S COMPLEMENT OF XRC
       HTR OK2      CONTIANS THE ERROR ADDR
       REM          OF SECTION OF PROG LAST
       REM          EXECUTED
       REM   
 KONST OCT 1
       OCT 50
       OCT 50       COUNT CONSTANT
       OCT 1
       OCT 1
       TRA OK-1     EXIT FROM PRINT PROG
       TRA OK2      EXIT FROM PRINT WHEN
       REM          ENTRY IS TO ERROR-1
 PRINT STO STOR     ACC CONTENTS
       ARS 35
       SLW STOR+3   OV FL BITS
       PXA 2,2
       STA STOR+2   XRB
       SXD STOR+2,1 PLACE XRA INTO DECR
       SXD STOR+3,4 PLACE XRC INTO DECR
       STQ STOR+1   MQ CONTENTS
       REM    
       REM    
 CHK1  CLA STOR+5   L 100000
       DCT          DIV CK TEST
       ORS STOR+3   YES
       ARS 3
       TNO CHK4-1   ACC OV FL-YES
       ORS STOR+3   NO
       REM   
       CLM          SENSE SWITCHES
 CHK4  LXA STOR+8,1 L +4
       ALS 3
       MSE 101,1
       TRA *+3
       ADD STOR+7   L +1
       PSE 101,1    RESET LITES
       TIX CHK4+1,1,1
 CHK3  LXA STOR+6,1 L +6
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
 CHK3A CLA KONST+4  ROUTINE AT ERROR-1
       TZE CHK3A+7  YES
       CLA PRINT+3  NO
       STA CHK5+1   RESET ADDR
       CLA KONST+5
       STO EXIT
       TRA CHK5
       CLA STOR+7   L+1
       STO KONST+4
       STA CHK5+1
       CLA KONST+6
       STO EXIT
       REM    
       REM    
       REM          OBTAIN TEST LOC
       REM          AND ERROR ADDR
 CHK5  LXD STOR+3,4 XRC
       PXD 2,4
       COM 
       ADD BIT2+2   +1 TO DECREMENT
       STD LOC      ERROR ADDR INTO DECR
       ARS 18
       SUB CHK5+1   L +2
       STA CHK6
 CHK6  CAL 0        PLACE
       STA LOC      TEST LOC INTO ADDR
       REM
       REM          OBTAIN OPN OF INST
       SUB STOR+7   L +1
       STA *+1
       LDQ 0        BCD OPERATION 
       REM  
 CHK7  LXA STOR+6,1 L +6
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
 CHK7A TIX CHK7+1,1,1
       REM  
 CHK8  LDQ 0
       LXA BIT+3,1   L +14
       REM  
       TSX CH22,2
       CAL BIT+10    COL IND
       ARS 12,1
       ORS REC1R+9,4
       TIX *-4,1,1
       REM  
 CH1   CAL LOC       PUT TEST LOC INTO IMAGE
       LRS 15
       LXA LOC+5,1   L +5
       TSX CH21,2
       REM  
       CAL BIT       BIT COLUMN 10
       ARS 5,1
       ORS REC1L+9,4
       TIX CH1+3,1,1
       REM    
       REM           PUT ERROR ADDR INTO IMAGE
 CH5   LXD LOC,4
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
 CH7   CAL STOR+4    IMAGE
       LRS 18
       LXA STOR+6,1  L +6
       TSX CH21,2
       CAL BIT+9
       ARS 6,1
       ORS REC1R+9,4
       TIX CH7+3,1,1
       REM  
 CH10  LXA BIT+3,4   PUT 1ST REC IN PR IMAGE
       LXA LOC+4,1   L +30
       CAL REC1L+12,4 LEFT HALF IMAGE
       SLW PR+24,1
       CAL REC1R+12,4
       SLW PR+25,1
       REM  
       TIX CH10+7,4,1
       TIX CH10+2,1,2
       REM  
 CH11  LXA BIT+3,4   MASK IMAGE
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
       CAL MASK+6
       ANS REC4L+12,4 PRINT REC
       TIX CH11+1,4,1
       REM    
       REM    
       REM    
 CH14  WRS 753       PRINTER
       SPRA 3        DOUBLE SPACE
       REM           PRINT FIRST LINE
       REM           TEST LOC, ERROR ADDR
       TSX WPRA+1,1
       REM
 CH18  CLA STOR+4    PUT MSE LITES INTO IMAGE
       LRS 30
       LXA STOR+8,1  L +4
       TSX CH21,2
       CAL BIT+12    BIT COL 6
       ARS 4,1
       ORS REC2L+9,4
       TIX CH18+3,1,1
       REM   
       REM           FORM CARD IMAGE FOR 2ND REC
 CH15  CLA STOR+2
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
 CH16  TSX CH21,2
       LXA LOC+5,1   L +5
       TSX CH21,2
       CAL BIT2      BIT COL 8
       ARS 5,1
       ORS REC2R+9,4  BIT IN IMAGE
       TIX CH16+2,1,1
       REM  
 CH17  CLA STOR+3    PUT XRC INTO IMAGE
       LRS 33
       LXA LOC+5,1   L +5
       TSX CH21,2
       REM  
       CAL BIT2+1    BIT IN COL 19
       ARS 5,1
       ORS REC2R+9,4 BIT IN IMAGE
       TIX CH17+3,1,1
       REM  
 CH27  LDQ STOR+1    CONTENTS OF MQ
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
 CH23  LXA BIT+3,4
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
 CH20  CAL STOR+3    PUT TRGS INTO
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
 CH24  CLM           PUT Q + P BITS
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
 CH25  LDQ STOR
       CAL BIT+6     PUT + SIGN OF
       TQP CH25+5    ACC IN IMAGE
       ORS REC3L+10  MINUS SIGN OF ACC IN IMAGE
       TRA CH26
       ORS REC3L+11  INTO IMAGE
 CH26  LXA BIT+3,1   L +14
       TSX CH22,2
       CAL BIT+10    BIT COL 15
       ARS 12,1
       ORS REC3L+9,4
       TIX CH26+1,1,1
       REM   
 CH30  LXA BIT+3,4   PUT 3RD REC INTO
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
 CH32  STI PR        STORE INDICATORS
       LDQ PR        INDICATOR FROM STORAGE
       LXA BIT+3,1   L +14
       TSX CH22,2
       CAL BIT+6
       ARS 13,1
       ORS REC4L+9,4 INDICATORS INTO
       TIX CH32+3,1,1 PRINT RECORD
       REM   
       REM           PUT CONTENT OF KEYS IN
 CH33  ENK           PRINT RECORD
       LXA BIT+3,1   L +14
       TSX CH22,2
       CAL BIT+1
       ARS 16,1
       ORS REC4L+9,4 KEYS CONTENTS INTO
       TIX CH33+2,1,1 PRINT REC
       REM   
 CH34  LXA BIT+3,4   L+14 PUT 4TH REC
       REM           INTO PRINT IMAGE
       LXA LOC+4,1   L +30
       CAL REC4L+12,4
       SLW PR+24,1
       STZ PR+25,1
       TIX *+1,4,1
       TIX CH34+2,1,2
       REM   
       TSX WPRA,1    PRINT CONTENTS OF INDS
       REM   
       REM
       REM           RESET ACC + MQ CONTENTS
       REM
       CLA STOR+3    OVFL BITS
       LDQ STOR      ACC CONTENTS
       LLS 35
       LDQ STOR+1
       REM   
 CH35  LXA STOR+2,2  XRB
       LXD STOR+2,1  XRA
       LXD STOR+3,4  XRC
       TOV EXIT
 EXIT  TRA OK-1 
       REM   
 CH21  CLM
       LLS 3
       PAX 0,4
       TRA 1,2
       REM   
 CH22  CLM
       LGL 3
       PAX 0,4
       TRA 1,2
       REM   
 WPRA  WPRA
       RCHA CTWD
       TCOA *
       TRA 1,1      EXIT
       REM   
 TRAP  STO LOC+3
       TRA CHK7A
       REM   
 REC1L OCT 320,10001000,1000000
       OCT 4002000042,200000400400
       OCT 0,452010001005
       OCT 100000000000,0,540010001000
       OCT 14003400366,202000000401
 REC1R OCT 0,4000001000,0,100000200
       OCT 0,0,4240001000,400,0
       OCT 5000001600,000300000000
       OCT 40000000
 REC2L OCT 200000000100,440001000
       OCT 200,0,40000000000
       OCT 100000000
       OCT -500400001000,0,40
       OCT 100400001200
       OCT -400140000100
       OCT 240000000040
 REC2R OCT 20004000404
       OCT 200040010000
       OCT 40010000110,0,0,0
       OCT 200042011020
       OCT 10000000000,200
       OCT 240050011020
       OCT 20004000504,10002000210
 REC3L OCT 100,14420001000
       OCT 200000000,0,40,200
       OCT 310420001010,4,-0
       OCT 10420001040,4200000004
       OCT -700000000310
 REC3R OCT 0,-400040000000,0
       OCT 5000000000,2000000000,0
       OCT -460440000000,0
       PON
       OCT -402040000000
       OCT 4400000000,161000000000
 REC4L OCT -0,1040000,0,0
       OCT 200000100000,100000000000
       OCT 1000000,40000220000,0
       OCT 40001060000,200000200000
       OCT -500000100000
 STOR  OCT 0         ACC CONTENTS
       OCT 0         MQ CONTENTS
       OCT 0         XRA AND XRB
       OCT 0         XRC, OVRL TRGS, TAPE CK
       OCT 0         PSE + MSE VALUES
       OCT 100000
       OCT +6
       OCT +1
       OCT +4
 LOC   OCT 0         TEST LOC + ERROR ADDR
       OCT 0         DECREMENT CONTAINS 2,5
* COMPLEMENT OF LAST ROUTINE PREFORMED
       OCT 0         +0
       OCT 0         TRAP ROUTINE INDICATOR
       OCT +30
       OCT 5
       OCT -0
       OCT 7
 BIT   OCT 400000000 BIT COL 10
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
 BIT2  OCT 002000000000 BIT COL 8
       OCT 400000    BIT COL 19
       OCT 1000000
 MASK  OCT 777017601777 TEST LOC ETC
       OCT 407760001700
       OCT -760760001760 MQ ETC
       OCT 374077017776
       REM              MAKE FOR REC3
       OCT -756720001776 ACC AND TRIGGER
       OCT -777670000000
       OCT -760001760000 MASK FOR 4TH REC
 CTWD  HTR PR,0,24    CONTROL WORD FOR PRINTING
 PR    OCT            PRINT IMAGE
       END
