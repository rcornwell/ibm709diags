                                                             9M01B          
                                                            7/15/59
       REM
       REM  9M01B
       REM
*709 MAIN FRAME TEST EXAMINING FIXED-POINT AND LOGICAL ARITHMETIC
*OPERATIONS, WORD TRANSMISSION OPERATIONS, SHIFTING OPERATIONS,
*CONTROL OPERATIONS AND LOGICAL OPERATIONS
       REM
       ORG 24
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA ID        IDENTIFY PROGRAM
       REM
       CLA END+1     RESET
       STO 0         START
       REM
       REM           CURSORY TSX TEST
       TSX START,4
       HTR START     DID NOT TRA ON TSX
 START TRA 5,4       BEGIN TEST
       HTR A         WRONG COM IN XRC
       REM
       REM
       REM COMMENCE TEST
       BCD 1TOV      TEST OVERFLOW IN ACC
 A     TOV A+1       TURN OFF OVERFLOW  TRGR
       TOV A+3       NO GOOD, DID NOT TURN OFF
       TRA A+4       OK
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A         REPEAT
       REM
       REM
       BCD 1TOV      TEST OVERFLOW ALS
 A7    CLA PTW       PLACE BIT IN ACC  1
       ALS 1         SHOULD OVERFLOW.
       TOV A7+4      OK, SHOULD OVFL
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A7        REPEAT
       REM
       REM
       BCD 1TOV      TEST OVFL WITH NO
 A8    CLA ZERO       OVERFLOW
       TOV A8+3      SHOULD NOT OVFL
       TRA A8+4      OK, DID NOT OVFL
       TSX ERROR,4   ERROR
       TSX OK,4
       TRA A8        REPEAT
       REM
       REM
       BCD 1TNO      TEST TNO WITH NO ACC OVF
 A9    CLA ZERO      CLEAR  ACC
       TNO A9+3      TEST FOR NO OVFL
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A9        REPEAT
       REM
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
       REM
       BCD 1TNO      DID TNO TURN LIGHT OFF
 A11   TOV  A11+2
       TRA A11+3     OK, DID TURN IT OFF
       TSX ERROR,4
       TSX OK,4
       TRA A11       REPEAT
       REM
       REM
       BCD 1TZE      TEST TZE INST WITH ARS
 A12   ARS 36        CLEAR  ACCUMULATOR
       TZE A12+3     TEST FOR ZERO
       TSX ERROR,4   NO GOOD, DID NOT TRANSFER
       TSX OK,4      OK
       TRA A12       REPEAT
       REM
       REM
       BCD 1TZE      TEST TZE, WITH CLA
 A13   CLA ZERO      BRING IN  ZERO
       TZE A13+3     TEST FOR ZERO
       TSX ERROR,4   NO GOOD DID NOT TRANSFER
       TSX OK,4      OK
       TRA A13       REPEAT
       REM
       REM
       BCD 1TZE      TEST TZE, WITH CLA
 A14   CLA A14       BRING IN NO  ZERO
       TZE A14+3     SHOULD NOT TRANSFER
       TRA A14+4     OK, DID NOT TRANSFER
       TSX ERROR,4   OK
       TSX OK,4
       TRA A14       REPEAT
       REM
       REM
       BCD 1TNZ      TEST TNZ, ACC NOT ZERO
 A15   CLA A15       BRING IN NON  ZERO
       TNZ A15+3     SHOULD TRANSFER
       TSX ERROR,4   NO GOOD, DID NOT TRANSFER
       TSX OK,4      OK
       TRA A15       REPEAT
       REM
       REM
       BCD 1TNZ      TEST TNZ, ACC IS ZERO
 A16   CLA ZERO      CLEAR  ACC
       TNZ A16+3     SHOULD NOT TRANSFER
       TRA A16+4
       TSX ERROR,4   GOOD, DID NOT TRANSFER
       TSX OK,4
       TRA A16
       REM
       REM
       BCD 1ALS      TEST ALS
 A21   CLA ZERO      TEST ALS BY MOVING  ZERO
       ALS 8         EIGHT LEFT
       TZE A21+4     OK
       TSX ERROR,4   PICK UP ONES FROM LEFT
       TSX OK,4
       TRA A21
       REM
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
       REM
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
       REM
       BCD 1LBT      TEST LBT
 A28   CLA ZERO      PLACE ZERO IN ACC  35
       LBT
       TRA A28+4     OK, DID NOT SENSE ONE
       TSX ERROR,4   ERROR SHOULD NOT SKIP
       TSX OK,4
       TRA A28
       REM
       REM
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
       REM
       BCD 1PBT      PBT TEST
 A30   CLA ONE       PLACE ONE ZERO IN ACC  35
       ALS 35        SHIFT ONE TO P POSITION
       PBT
       TSX ERROR,4   DID NOT SKIP WITH ONE IN P
       TSX OK,4
       TRA A30
       REM
       REM
       BCD 1TPL      TPL TEST
 A31   CLA PTW       BRING IN PLUS  NUMBER
       TPL A31+3     TRANSFER IF OK
       TSX ERROR,4   ERROR DID NOT TRANSFER
       TSX OK,4
       TRA A31
       REM
       REM
       BCD 1TPL      TPL TEST
 A32   CLA MTW       BRING IN MINUS  NUMBER
       TPL A32+3     SHOULD NOT TRANSFER
       TRA A32+4
       TSX ERROR,4
       TSX OK,4
       TRA A32
       REM
       REM
       BCD 1TMI      TMI TEST
 A33   CLA MTW       BRING IN MINUS  NUMBER
       TMI A33+3     OK, SHOULD TRANSFER
       TSX ERROR,4   DID NOT TRANSFER
       TSX OK,4
       TRA A33
       REM
       REM
       BCD 1TMI      TMI TEST
 A34   CLA PTW       BRING IN PLUS  NUMBER
       TMI A34+3     SHOULD NOT TRANSFER
       TRA A34+4     OK, DID NOT TRANSFER
       TSX ERROR,4
       TSX OK,4
       TRA A34
       REM
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
       REM
       BCD 1CLM      CLM TEST, TWO PARTS
 A36   CLA PONES     BRING IN +377777777777
       CLM
       TZE A36+5     OK. NOW SEE IF SIGN IS SAME
       TSX ERROR-1,4 DID NOT CLEAR POS 1-35
       TRA A36
       REM
       TPL A36+7     OK, SIGN UNCHANGED
       TSX ERROR,4   CHANGED SIGN
       TSX OK,4
       TRA A36
       REM
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
       REM
       BCD 1SSP      SSP TEST
 A39   CLA PONES     BRING IN PLUS NUMBER
       SSP
       TPL A39+4     SHOULD TRANSFER
       TSX ERROR,4   DID NOT TRA, CHANGED SIGN
       TSX OK,4
       TRA A39
       REM
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
       REM
       BCD 1SSM      SSM TEST
 A41   CLA ONES      BRING IN NEGATIVE NUMBER
       SSM           SHOULD NOT CHANGE
       TMI A41+4     SHOULD TRANSFER
       TSX ERROR,4   INADVERTENTLY CHANGED SIGN
       TSX OK,4
       TRA A41
       REM
       REM
       BCD 1CHS      CHS TEST
 A42   CLA PONES     BRING IN PLUS NUMBER
       CHS           MAKE IT MINUS
       TMI A42+4     SHOULD TRANSFER
       TSX ERROR,4   DID NOT CHANGE SIGNS
       TSX OK,4
       TRA A42
       REM
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
       REM
 A45   STQ TEMP      CHECK FOR MQ PICK UP
       CLA TEMP      OF BITS BY LLS
       TZE A45+4     OK, NO PICK UP
       TSX ERROR,4   PICKED UP A ONE
       TSX OK,4
       TRA A44       REPEAT TO A44
       REM
       REM
       BCD 1LLS      LLS TEST
 A46   CLA ZERO      CLEAR ACCUMULATOR
       LDQ ONE       MOVE BIT FROM MQ 35 TO MQ 1
       LLS 34        DOES IT MOVE CORRECTLY
       TZE A47       OK, PROCEED
       TSX ERROR-1,4
       TRA A46
       REM
       REM
 A47   STQ TEMP      IS THE BIT STILL IN MQ
       CLA TEMP
       SUB PTW
       TZE A47+5     SHOULD TRANFER
       TSX ERROR,4   LOST THE BIT IN THE MQ
       TSX OK,4
       TRA A46       GO BACK UP TO A 46
       REM
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
       REM
       BCD 1LRS      LRS TEST
 A53   LDQ ZERO      CLEAR MQ
       CLA PTW       PLATE BIT IN ACC 1
       LRS 36        MOVE A ONE TO MQ
       TZE A53+5     OK, ACC SHOULD BE CLEAR
       TSX ERROR,4   DID NOT CLEAR ACC
       TSX OK,4
       TRA A53
       REM
       REM
       BCD 1LRS      LRS TEST
 A54   CLA MTW       PLACE BIT IN ACC POS 1
       LRS 34        MOVE IT TO ACC POS 35
       LBT           IS IT THERE
       TSX ERROR,4   NO
       TSX OK,4      YES
       TRA A54
       REM
       REM
       BCD 1LRS      LRS TEST, CHECK SIGNS
 A55   CLA PTW       MAKE ACC POSITIVE
       LDQ MTW       MAKE MQ NEGATIVE
       LRS           CHANGE SIGN OF MQ
       STQ TEMP      STORE IT
       CLA TEMP      BRING IT TO ACC
       TPL A55+7     SHOULD BE PLUS
       TSX ERROR,4   DID NOT CHANGE SIGNS
       TSX OK,4
       TRA A55
       REM
       REM
       BCD 1LRS      LRS TEST, CHECK SIGNS
 A56   CLA MTW       MAKE ACC NEGATIVE
       LDQ PTW       MAKE MQ POSITIVE
       LRS           CHANGE MQ SIGN
       STQ TEMP      SAVE IT
       CLA TEMP      TEST IT
       TMI A56+7     OK
       TSX ERROR,4   DID NOT CHANGE MQ SIGN
       TSX OK,4
       TRA A56
       REM
       REM
       BCD 1LRS      LRS TEST, CHECK SIGNS
 A57   CLA PTW       MAKE ACC POSITIVE
       LDQ PTW       MAKE MQ POSITIVE
       LRS           MQ SIGN SHOULD STAY
       REM           POSITIVE
       STQ TEMP      SAVE IT
       CLA TEMP      BRING TO ACC
       TPL A57+7     OK, SHOULD BE PLUS
       TSX ERROR,4   CHANGE SIGN INADVERTENTLY
       TSX OK,4
       TRA A57
       REM
       REM
       BCD 1LGL      LGL TEST
 A58   TOV A58+1     TURN OFF OVERFLOW
       CLA ZERO      PLACE ZERO IN ACC
       LDQ ZERO      PLACE ZERO IN MQ
       LGL 8
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING IT INTO ACC
       TZE A58+8     OK, SHOULD BE ZERO
       TSX ERROR,4   PICKED UP BITS
       TSX OK,4
       TRA A58
       REM
       REM
       BCD 1LGL      LGL TEST, SHIFT ACROSS
 A59   CLA ZERO      PLACE ZERO IN ACC
       LDQ ONE       PLACE ONE IN MQ 35
       LGL 1         SHIFT ONE
       STQ TEMP      SAVE MQ
       CLA TEMP      TEST FOR BIT
       TNZ A59+2     OK, SWEEP ACROSS MQ
       TMI A59+8     FINISH ACC SHOULD BE MINUS
       TSX ERROR,4   FAILED TO SHIFT, LOST A BIT
       TSX OK,4
       TRA A59
       REM
       REM
       BCD 1LGL      LGL TEST, SEEK P POSITION
 A60   TOV A60+1     TURN OFF OVERFLOW
       LDQ MZE
       LGL 36        MOVE BIT FROM MQ S TO ACC P
       PBT           IS THERE A BIT IN ACC P
       TRA A60+6
       TRA A60+8
       TSX ERROR-1,4
       TRA A60
       REM
       TOV A61       OK, PROCEED
       TSX ERROR-1,4
       TRA A60
       REM
       REM
 A61   LGL 2         MOVE BIT OUT OF Q
       TZE A61+3     OK, SHOULD BE ZERO
       TSX ERROR,4   DID NOT MOVE PAST Q
       TSX OK,4
       TRA A60
       REM
       REM
       BCD 1LGL      LGL TEST
 A61A  LDQ PTHR      PLACE BIT IN MQ 2 POS
       LGL 3         MOVE BIT TO ACC 35
       LBT           CHECK ACC
       TRA A61A+5    DID NOT SHIFT TO ACC 35
       TRA A61A+7    OK, CHECK MQ
       TSX ERROR-1,4
       TRA A61A
       REM
       STQ TEMP      PLACE MQ IN TEMP STOR
       CLA TEMP      BRING IT TO ACC
       TZE A61A+12   SHOULD BE ZERO
       TSX ERROR-1,4
       TRA A61A
       REM
       TPL A61A+14   OK, MQ IS PLUS, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA A61A
       REM
       REM
       BCD 1RQL      RQL TEST
 A62   LDQ MZE       PLACE BIT IN MQC SIGN POS
       RQL 1
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING MQ TO ACC
       LBT           TEST FOR ROTATE
       TSX ERROR,4   DID NOT ROTATE
       TSX OK,4      OK, BIT WENT FROM MQ S TO
       REM             MQ 35
       TRA A62
       REM
       REM
       BCD 1RQL      RQL TEST
 A62A  TOV A62A+1    TURN OFF OVFL
       CLA ZERO      LOAD ACC WITH ZERO
       LDQ ZERO      LOAD MQ WITH ZERO
       RQL 16
       STQ TEMP      MOVE MQ TO ACC
       CLA TEMP
       TZE A62A+8    OK, SHOULD BE ZERO
       TSX ERROR,4   PICKED UP BITS
       TSX OK,4
       TRA A62A
       REM
       REM
       BCD 1RQL      RQL TEST
 A63   LDQ MZE       START WITH BIT IN MQ S
       RQL 1         SHIFT UNTIL IT GET BACK
       STQ TEMP      AROUND
       CLA TEMP
       TNZ A63+1     LOOP 35 TIMES
       TMI A63+7     YES, IT GOT BACK TO S POS
       TSX ERROR,4
       TSX OK,4
       TRA A63
       REM
       REM
       BCD 1RQL      RQL MODULO TEST
 A63A  LDQ ONE       PLACE ONE IN MQ 35
       RQL 256       SHOULD NOT SHIFT
       STQ TEMP      LOAD MQ INTO ACC
       CLA TEMP
       LBT           HAVE WE SHIFTED
       TSX ERROR,4
       TSX OK,4
       TRA A63A
       REM
       REM
       BCD 1RQL      RQL MODULO TEST
 A63B  LDQ ONE       PLACE ONE IN MQ 35
       RQL 292       SHOULD MAKE ONE ROTATION
       STQ TEMP      LOAD MQ INTO ACC
       CLA TEMP
       LBT           WAS MODULO INTERPRETED OK
       TSX ERROR,4   NO
       TSX OK,4      YES, MODULO PROCESS WORKS
       TRA A63B
       REM
       REM
       BCD 1TQP      TQP TEST
 A64   LDQ PTW       PLACE PLUS NUMBER IN MQ
       TQP A64+3     SHOULD TRANSFER
       TSX ERROR,4
       TSX OK,4
       TRA A64
       REM
       REM
       BCD 1TQP      TQP TEST
 A65   LDQ MTW       PLACE NEGATIVE NO IN MQ
       TQP A65+3     SHOULD NOT TRANSFER
       TRA A65+4     OK
       TSX ERROR,4
       TSX OK,4
       TRA A65
       REM
       REM
       BCD 1NOP      NOP TEST
 A66   NOP A66+2
       TRA A66+3     OK
       TSX ERROR,4
       TSX OK,4
       TRA A66
       REM
       REM
       BCD 1COM      COM TEST
 A67   CLA ONES      PLACE ONES IN ACC
       COM           SHOULD NOW BE ZERO
       ALS 2
       TZE A67+5     OK, IT IS ZERO
       TSX ERROR,4
       TSX OK,4
       TRA A67
       REM
       REM
       BCD 1COM      COM TEST
 A68   CLA ONES      PLACE ONES IN ACC
       LDQ ONES      PLACE ONES IN MQ
       LLS 8         SHIFT BITS TO P AND Q
       COM           MAKE IT ALL ZEROS
       TZE A68+6     OK, ALL ZEROS
       TSX ERROR,4
       TSX OK,4
       TRA A68
       REM
       REM
       BCD 1COM      COM TEST, CHECK SIGN
 A69   CLA PONES     BRING IN PLUS NUMBER
       COM           MAKE COM
       TPL A69+4     OK, SIGN DID NOT CHANGE
       TSX ERROR,4
       TSX OK,4
       TRA A69
       REM
       REM
       BCD 1COM      COM TEST, CHECK SIGN
 A70   CLA ONES      BRING IN NEG NUMBER
       COM           COM
       TMI A70+4     OK, SIGN DID NOT CHANGE
       TSX ERROR,4
       TSX OK,4
       TRA A70
       REM
       REM
       BCD 1ADD      ADD TEST, SIGNS POSITIVE
 A71   CLA ONE       HAVE BOTH SIGNS POSITIVE
       ADD ONE       ADD
       LBT           SHOULD HAVE ZERO IN ACC 35
       TRA A72       OK
       TSX ERROR-1,4
       TRA A71
       REM
       REM
 A72   ARS 1         SHIFT ONE TO CHECK ANSWER
       LBT
       TRA A72+4     DID NOT ADD CORRECTLY
       TRA A72+6     CHECK SIGN
       TSX ERROR-1,4 BIT ERROR
       TRA A71
       REM
       TPL A72+8     OK, SIGN IS PLUS
       TSX ERROR,4
       TSX OK,4
       TRA A71
       REM
       REM
       BCD 1ADD      ADD TEST, SIGNS NEGATIVE
 A73   CLA MONE      BRING IN MINUS ONE
       ADD MONE      ADD MINUS ONE
       LBT           TEST ANSWER
       TRA A74       OK, ACC 35 IS A ZERO
       TSX ERROR-1,4
       TRA A73
       REM
       REM
 A74   ARS 1         SHOULD GET A ONE
       LBT           TEST
       TRA A74+4     DID NOT SENSE A ONE
       TRA A74+6     CHECK SIGN
       TSX ERROR-1,4
       TRA A73
       REM
       TMI A74+8     OK, SIGN IS MINUS
       TSX ERROR,4
       TSX OK,4
       TRA A73       REPEAT SECTION
       REM
       REM
       BCD 1ADD      ADD TEST, ACC PLUS, MEMORY
       REM           NEGATIVE
 A75   CLA THREE     MAKE ACC PLUS THREE
       ADD M2        ADD MEM MINUS TWO
       LBT           SHOULD GET A ONE
       TRA A75+5
       TRA A76       OK
       TSX ERROR-1,4
       TRA A75
       REM
       REM
 A76   ARS 1         SEE THAT HAVE NO CARRY
       LBT           TEST FOR ZERO
       TRA A76+5     CHECK SIGN
       TSX ERROR-1,4
       TRA A75
       REM
       TPL A76+7     OK, SIGN SHOULD BE PLUS
       TSX ERROR,4
       TSX OK,4
       TRA A75       REPEAT SECTION
       REM
       REM
       BCD 1ADD      ADD TEST, ACC MINUS
       REM           MEMORY PLUS
 A77   CLA M3        MAKE ACC MINUS THREE
       ADD TWO       ADD PLUS TWO
       LBT           TEST FOR ONE
       TRA A77+5
       TRA A78       OK
       TSX ERROR-1,4
       TRA A77
       REM
 A78   ARS 1         SEE THAT HAVE NO CARRY
       LBT           SHOULD BE ZERO
       TRA A78+5     CHECK SIGN
       TSX ERROR-1,4 BIT ERROR
       TRA A77
       REM
       TMI A78+7     OK, SIGN IS MINUS
       TSX ERROR,4   DID NOT GET SIGN OR ZERO
       TSX OK,4
       TRA A77
       REM
       REM
       REM
       BCD 1ADD      ADD TEST
 A79   CLA TWO       MAKE ACC PLUS TWO
       ADD M3        ADD MINUS THREE
       LBT           TEST FOR ONE
       TRA A79+5
       TRA A80       OK
       TSX ERROR-1,4
       TRA A79
       REM
       REM
 A80   ARS 1         CHECK FOR ZERO FIRST
       LBT           TEST FOR ZERO
       TRA A80+5     CHECK SIGN
       TSX ERROR-1,4 BIT ERROR
       TRA A79
       REM
       TMI A80+7     OK, SIGN IS MINUS
       TSX ERROR,4
       TSX OK,4
       TRA A79       REPEAT SECTION
       REM
       REM
       BCD 1ADD      ADD TEST
 A81   CLA M2        MAKE ACC MINUS TWO
       ADD THREE     ADD PLUS THREE
       LBT           TEST FOR ONE
       TRA A81+5
       TRA A82       OK, GOT A ONE
       TSX ERROR-1,4
       TRA A81
       REM
       REM
 A82   ARS 1         CHECK NEXT POSITION
       LBT           FOR A ZERO
       TRA A82+5     CHECK SIGN
       TSX ERROR-1,4
       TRA A81
       REM
       TPL A82+7     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA A81
       REM
       REM
       BCD 1ADD      ADD TEST, WITH RIPPLE
 A82A  CLA PONES     BRING IN PLUS ONES
       ADD ONE       ADD ONE TO RIPPLE
       PBT           P SHOULD HAVE BIT
       TRA A82A+5    NO P BIT
       TRA A82A+7    OK, CHECK OVFL
       TSX ERROR-1,4
       TRA A82A      OK, PROCEED
       REM
       TOV A82A+9
       TSX ERROR,4
       TSX OK,4
       TRA A82A
       REM
       REM
       BCD 1ADM      ADD MAGNITUDE TEST
 A83   CLA MONE      BRING IN MINUS ONE
       ADM TWO       ADD TWO
       LBT           SHOULD BE ONE.
       TRA A83+5     NO ONE
       TRA A83+7     OK, CHECK SIGN.
       TSX ERROR-1,4 
       TRA A83       OK, PROCEED
       REM
       TPL A83+9     MAKE SURE POSITIVE
       TSX ERROR,4
       TSX OK,4
       TRA A83
       REM
       REM
       BCD 1ADM       ADD MAGNITUDE TEST
 A83A  CLA MONE       BRING IN MINUS ONE
       ADM M2         ADD MINUS 2
       LBT            SHOULD NOT BE ONE
       TRA A83A+5     OK, CHECK SIGN
       TRA A83A+7     
       TSX ERROR-1,4
       TRA A83A       OK, PROCEED
       REM
       TPL A83A+9     CHECK SIGN
       TSX ERROR,4
       TSX OK,4       OK, PROCEED
       TRA A83A
       REM
       REM
       BCD 1ADM       ADD MAGNITUDE TEST OVERFLOW
 A84   CLA PONES      GET ALL ONES
       ADM MONE       ADD MINUS ONE
       PBT            SHOULD BE PLUS
       TRA A84+5      
       TRA A84+7      
       TSX ERROR-1,4
       TRA A84        OK, PROCEED
       REM
       TOV A84+9      CHECK FOR OVERFLOW
       TSX ERROR,4
       TSX OK,4       OK, PROCEED
       TRA A84
       REM
       REM
       BCD 1SUB     CHECK SUBTRACT
 A85   CLA ONE      LOAD ONE
       SUB MONE     SUBTRACT MINUS ONE
       LBT          SHOULD NOT BE SET
       TRA A85+6
       TSX ERROR-1,4
       TRA A85
       REM
       TPL A86       OK, PROCEED
       TSX ERROR-1,4
       TRA A85
       REM
       REM
 A86   ARS 1         IN ACC POS 34
       LBT
       TSX ERROR,4   NO ONE BIT
       TSX OK,4      OK, GOT A ONE BIT
       TRA A85       REPEAT SECTION
       REM
       REM
       BCD 1SUB      SUB TEST
 A87   CLA MONE      MAKE ACC MINUS ONE
       SUB ONE       SUB PLUS ONE
       LBT           TEST FOR ZERO
       TRA A87+6     OK, CHECK SIGN
       TSX ERROR-1,4
       TRA A87
       REM
       TMI A88       OK, PROCEED
       TSX ERROR-1,4
       TRA A87
       REM
       REM
 A88   ARS 1         CHECK FOR ONE IN POS 34
       LBT           SHOULD GET A ONE
       TSX ERROR,4   NO, DID NOT GET IT
       TSX OK,4      OK, PROCEED
       TRA A87
       REM
       REM
       BCD 1SUB      SUB TEST, END CARRY
 A89   CLA THREE     ACC PLUS THREE
       SUB TWO       SUB PLUS TWO
       LBT           SHOULD HAVE PLUS ONE
       TRA A89+5     DID NOT GET ONE
       TRA A89+7     OK, CHECK SIGN
       TSX ERROR-1,4
       TRA A89
       REM
       TPL A89+9     OK PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA A89
       REM
       REM
       BCD 1SUB      SUB TEST, NO END CARRY
 A90   CLA TWO       ACC PLUS TWO
       SUB THREE     SUB PLUS THREE
       LBT           TEST FOR ONE
       TRA A90+5     NO GOT ERROR
       TRA A90+7     OK, PROCEED
       TSX ERROR-1,4
       TRA A90
       REM
       TMI A91       OK, PROCEED
       TSX ERROR-1,4
       TRA A90
       REM
       REM
 A91   ARS 1         CHECK ACC POS 34
       LBT           SHOULD BE ZERO
       TRA A91+4     OK IT IS ZERO
       TSX ERROR,4
       TSX OK,4
       TRA A90       REPEAT SECTION
       REM
       REM
       BCD 1SUB      SUB TEST, NO END CARRY
 A92   CLA M2        ACC MINUS TWO
       SUB M3        SUB MINUS THREE
       LBT           TEST FOR ONE
       TRA A92+5     NO GOT A ZERO
       TRA A92+7     OK CHECK SIGN
       TSX ERROR-1,4
       TRA A92
       REM
       TPL A93       OK PROCEED
       TSX ERROR-1,4
       TRA A92
       REM
       REM
 A93   ARS 1         CHECK POSITION 34 OF ACC
       LBT           SHOULD BE ZERO
       TRA A93+4     OK
       TSX ERROR,4   NO GOOD
       TSX OK,4
       TRA A92
       REM
       REM
       BCD 1SUB      SUB TEST, END CARRY
 A94   CLA M3        ACC MINUS THREE
       SUB M2        SUB MINUS TWO
       LBT           TEST FOR ONE
       TRA A94+5     NO GOOD, GO A ZERO
       TRA A94+7     OK, CHECK SIGN
       TSX ERROR-1,4
       TRA A94
       REM
       TMI A95       OK, PROCEED
       TSX ERROR-1,4
       TRA A94
       REM
       REM
 A95   ARS 1         CHECK POSITION 34 OF ACC
       LBT           SHOULD BE ZERO
       TRA A95+4     OK IT IS ZERO
       TSX ERROR,4   NO GOOD, GOT A ONE
       TSX OK,4
       TRA A94
       REM
       REM
       BCD 1SUB      SUB TEST, WITH RIPPLE
 A95A  CLA ONES      BRING IN MINUS ONES
       SUB ONE       SUB PLUS ONE
       PBT           SHOULD GET BIT IN P
       TRA A95A+5    NO BIT IN P
       TRA A95A+7    OK, CHECK OVFL
       TSX ERROR-1,4
       TRA A95A
       REM
       TOV A95A+9    OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA A95A
       REM
       REM
       BCD 1SBM      SBM TEST
 A96   CLA ONE       ACC PLUS ONE
       SBM M2        SBM MINUS TWO
       LBT           TEST FOR ONE
       TRA A96+5     NO GOOD, GOT ZERO
       TRA A96+7     OK, CHECK SIGN
       TSX ERROR-1,4
       TRA A96
       REM
       TMI A96+9     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA A96
       REM
       REM
       BCD 1SBM      SBM TEST
 A97   CLA ONE       ACC PLUS ONE
       SBM TWO       SBM PLUS TWO
       LBT           TEST FOR ONE
       TRA A97+5     GOT ZERO
       TRA A97+7     OK, CHECK SIGN
       TSX ERROR-1,4
       TRA A97
       REM
       TMI A97+9     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA A97
       REM
       REM
       BCD 1SBM      SBM TEST, WITH RIPPLE
 A97A  CLA ONES      BRING IN MINUS ONES
       SBM ONE       SBM OF PLUS ONE
       PBT           SHOULD BE BIT IN P
       TRA A97A+5    NO BIT IN P
       TRA A97A+7    OK, CHECK OVFL
       TSX ERROR-1,4
       TRA A97A
       REM
       TOV A97A+9    OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA A97A
       REM
       REM
       BCD 1CLA      CLA TEST
 A98   CLA MONE      MAKE ACC MINUS
       TMI A98+3     CHECK SIGN LOADING
       TSX ERROR,4   NO, DID NOT BRING IN MINUS
       TSX OK,4      OK, PROCEED
       TRA A98
       REM
       REM
       BCD 1CLA      CLA TEST
 A99   CLA ONE       MAKE ACC PLUS
       TPL A99+3     CHECK SIGN, SHOULD BE PLUS
       TSX ERROR,4   NO GOOD
       TSX OK,4
       TRA A99
       REM
       REM
       BCD 1CLA      CLA TEST
 A100  CLA ZERO      SEE IF ACC IS CLEAR
       TZE A100+3    OK, SHOULD BE ZERO
       TSX ERROR,4   NO GOOD
       TSX OK,4
       TRA A100
       REM
       REM
       BCD 1CLA      CLA TEST
 B     CLA PTW       BIT IN ACC 1
       ALS 1         SHIFT TO P POSITION
       PBT           TEST P FOR A ONE
       TRA B+5       NO, GOT A ZERO
       TRA B+7       OK, CHECK OVFL
       TSX ERROR-1,4
       TRA B
       REM
       TOV B+9       OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B
       REM
       REM
       BCD 1CLA      CLA TEST
 B1    CLA ONE       SEE IF Q AND P POS ARE
       REM              CLEAR
       PBT           P POS SHOULD BE ZERO
       TRA B1+5      OK, NOW TEST Q POS
       TSX ERROR-1,4
       TRA B1
       REM
       ARS 1         SHIFT FOR Q
       PBT           Q POS SHOULD BE ZERO
       TRA B1+10     OK, CHECK OVFL
       TSX ERROR-1,4
       TRA B1
       REM
       TNO B1+12     OK, OVFL SHOULD BE OFF
       TSX ERROR,4
       TSX OK,4
       TRA B1
       REM
       REM
       BCD 1CLA      CLA TEST
 B2    CLA ONE       SEE THAT ONE IS IN ACC 35
       LBT           IS ONE THERE
       TSX ERROR,4   NO
       TSX OK,4      YES, ONE IS THERE
       TRA B2
       REM
       REM
       BCD 1CLA      CLA TEST, WITH RIPPLE
 B3    CLA PONES     BRING IN PLUS ONES
       ADD ONE       ADD ONE
       LBT           CHECK ACC 35 FOR ZERO
       TRA B3+6      OK, IS ZERO
       TSX ERROR-1,4
       TRA B3
       REM
       PBT           TEST P POS FOR ONE
       TRA B3+9      ERROR
       TRA B3+11     OK, CHECK ACC RESULT
       TSX ERROR-1,4
       TRA B3
       REM
       ALS 2         OK, CHECK FOR ZERO IN OTHER
       TZE B3+14     POS BY MOVING BIT PAST Q
       TSX ERROR,4   NO GOOD, PICKED UP A BIT
       TSX OK,4      OK
       TRA B3
       REM
       REM
       BCD 1CLS      CLS TEST
 B4    CLS MONE      BRING IN MINUS ONE
       TPL B4+3      SHOULD BECOME PLUS
       TSX ERROR,4   DID NOT CHANGE SIGN
       TSX OK,4
       TRA B4
       REM
       REM
       BCD 1CLS      CLS TEST
 B5    CLS ONE       BRING IN ONE
       TMI B5+3      SHOULD BE MINUS
       TSX ERROR,4   DID NOT CHANGE SIGN
       TSX OK,4
       TRA B5
       REM
       REM
       BCD 1CLS      CLS TEST
 B6    CLS ONE       BRING IN ONE IN ACC 35
       LBT           CHECK, IS ONE IN ACC 35
       TRA B6+4      NO GOOD, DID NOT GET ONE
       TRA B6+6      PROCEED
       TSX ERROR-1,4
       TRA B6
       REM
       PBT           SEE IF P IS CLEAR
       TRA B6+10     OK, PROCEED
       TSX ERROR-1,4
       TRA B6
       REM
       ARS 1         SHIFT TO CHECK Q
       PBT           SHOULD BE ZERO
       TRA B6+14     OK, IT IS ZERO, PROCEED
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK, THERE WAS A ZERO THERE
       TRA B6
       REM
       REM
       BCD 1CAL      CAL TEST
 B7    CAL MONE      CHECK THAT P HAS ONE
       PBT              SHOULD HAVE ONE
       TRA B7+4
       TRA B8        OK, PROCEED
       TSX ERROR-1,4
       TRA B7
       REM
       REM
 B8    TPL B8+3      CHECK THAT SIGN DID NOT
       REM              CHANGE
       TSX ERROR-1,4
       TRA B7
       REM
       ARS 1
       PBT           CHECK Q POS
       TRA B8+7      SHOULD BE ZERO
       TSX ERROR,4   OK, PROCEED
       TSX OK,4      NO GOOD
       TRA B7
       REM
       REM
       BCD 1CAL      CAL TEST
 B9    CAL ONE       BRING IN PLUS ONE
       PBT           P SHOULD BE ZERO
       TRA B9+5      OK, PROCEED
       TSX ERROR-1,4
       TRA B9
       REM
       LBT           TEST ACC 35 FOR ONE
       TRA B9+8      DID NOT BRING IN A ONE
       TRA B10       OK, PROCEED
       TSX ERROR-1,4
       TRA B9
       REM
 B10   TPL B10+3     SIGN SHOULD BE PLUS
       TSX ERROR-1,4 ERROR CHANGE OF SIGN
       TRA B9
       REM
       REM
       ARS 1         CHECK Q POS FOR ZERO
       PBT
       TRA B10+7     OK, PROCEED
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK, PROCEED
       TRA B9
       REM
       REM
       BCD 1ACL      ACL TEST
 B11   CLA ZERO      CHECK P POSITION AND SIGN
       ACL ONE        POSITION
       PBT           SHOULD BE A ZERO IN A
       TRA B11+6     CHECK SIGN
       TSX ERROR-1,4
       TRA B11
       REM
       TPL B11+8     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B11
       REM
       REM
       BCD 1ACL      ACL TEST
 B12   CLA ZERO      BRING IN MINUS NUMBER
       ACL MONE      SHOULD GET ONE IN P POS
       PBT
       TRA B12+5     NO GOOD, GOT ZERO
       TRA B12+7     CHECK SIGN
       TSX ERROR-1,4
       TRA B12
       REM
       TPL B12+10    OK, PROCEED
       TSX ERROR-1,4 ERROR, CHANGE OF SIGN
       TRA B12
       REM
       LBT           CHECK FOR ONE IN ACL 35
       TSX ERROR,4   GOT A FALSE CARRY
       TSX OK,4
       TRA B12
       REM
       REM
       BCD 1ACL      ACL TEST
 B13   CAL MONE      ACC BIT IN POS P AND POS 35
       ACL MONE      ACL MINUS ONE
       PBT           SHOULD GET ZERO IN P
       TRA B13+6     OK, PROCEED
       TSX ERROR-1,4
       TRA B13
       REM
       LBT           TEST FOR XXX CARRY
       TRA B13+9     NO GOOD, GOT A ZERO
       TRA B13+11    OK, PROCEED
       TSX ERROR-1,4
       TRA B13
       REM
       ARS 1         OK, NOW SEE IF Q BIT
       PBT           HAS A ONE
       TRA B13+15    Q SHOULD BE CLEARED
       TSX ERROR,4   ERROR, GOT A ONE IN POS Q
       TSX OK,4
       TRA B13
       REM
       REM
       BCD 1STO      STO TEST
 B14   CLA ONES      BRING IN ALL ONES
       STO TEMP      PLACE IN TEMP STORAGE
       SUB TEMP      SUB SAME QUANTITY
       TZE B14+5     SHOULD BE ZERO
       TSX ERROR,4   ERROR DID NOT STO RIGHT
       TSX OK,4
       TRA B14
       REM
       REM
       BCD 1SLW      SLW TEST
 B15   CAL MONE      PUT BIT IN POS P AND POS 35
       TPL B15+4     OK, SIGN SHOULD BE PLUS
       TSX ERROR-1,4
       TRA B15
       REM
       SLW TEMP      SLW IN TEMP STORAGE
       CLA TEMP      BRING WORD BACK
       SUB MONE      SUB ORIGINAL
       TZE B15+9     OK, SHOULD GET ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B15
       REM
       REM
       BCD 1SLW      SLW TEST
 B16   CLA MONE      PUT BIT IN P, SIGN MINUS
       SLW TEMP      SLW IN TEMP STORAGE
       CLA TEMP      BRING IT TO ACC
       TPL B16+5     SIGN SHOULD NOW BE PLUS
       TSX ERROR,4
       TSX OK,4
       TRA B16
       REM
       REM
       BCD 1STP      STP TEST
 B17   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP
       CLA KK33      L-252525525252
       STP TEMP      STP IN TEMP STORAGE
       CLA TEMP      BRING BACK, SIGN IS PLUS
       TPL B17+8     SHOULD BE PLUS
       TSX ERROR-1,4
       TRA B17
       REM
       ALS 1         CHECK ACC POS 1
       PBT           SHOULD BE ONE
       TRA B17+12    ERROR IN ONE POS
       TRA B17+14    OK, PROCEED
       TSX ERROR-1,4
       TRA B17
       REM
       TOV B17+17    OVFL SHOULD BE ON
       TSX ERROR-1,4
       TRA B17
       REM
       ALS 1         CHECK ACC POS 2
       PBT           SHOULD BE ZERO
       TRA *+3
       TSX ERROR-1,4
       TRA B17
       ALS 1         CLEAR Q
       TZE *+2       TEMP OK
       TSX ERROR,4
       TSX OK,4
       TRA B17
       REM
       REM
       BCD 1STP      STP TEST
 B18   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP
       CLA ZERO      BRING IN PLUS ZERO
       STP TEMP      STORE P, 1, 2, ZEROS
       CLA TEMP      BRING BACK TO ACC
       TPL B18+8     OK, SHOULD BE PLUS
       TSX ERROR-1,4
       TRA B18
       REM
       ALS 1         CHECK ONE POSITION
       PBT           SHOULD BE ZERO
       TRA B18+13    OK, CHECK OVFL
       TSX ERROR-1,4
       TRA B18
       REM
       TNO B18+16    OK, OVFL SHOULD BE OFF
       TSX ERROR-1,4
       TRA B18
       REM
       ALS 1         CHECK TWO POSITION
       PBT           SHOULD BE ZERO
       TRA B18+21    OK, CHECK OVFL
       TSX ERROR-1,4
       TRA B18
       REM
       TNO B18+23    OK, OVFL SHOULD BE OFF
       TSX ERROR,4   NO GOOD
       TSX OK,4
       TRA B18
       REM
       REM
       BCD 1STP      STP TEST
 B19   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP
       CAL ONES      BRING IN ONES, CHECK POS
       ALS 1          P AND POS Q
       STP TEMP      STO IN TEMP STORAGE
       ARS 1         DID CLEAR Q POSITION
       PBT
       TRA B19+9     NO GOOD, GOT ZERO
       TRA B19+11    CHECK SIGN
       TSX ERROR-1,4
       TRA B19
       REM
       TPL B19+14
       TSX ERROR-1,4
       TRA B19
       REM
       CLA TEMP      BRING BACK CONTENTS OF
       REM           TEMP
       TMI B19+17    OK, GOT P POS IN STORAGE
       TSX ERROR,4
       TSX OK,4
       TRA B19
       REM
       REM
       BCD 1STA      STA TEST
 B20   CLA RTN       SET UP ERROR TRA B20+7
       STO TEMP      IN STORAGE IF STA FAILS
       CLA RTN+1     SET UP ERROR TRA B20+5
       STA TEMP      PLACE IT IN STORAGE
       TRA TEMP      GO THERE AND MAKE TRANSFER
       SUB RTN+1     SEE IF ACC REMAINS SAME
       TZE B20+8     OK, CHECKS OUT
       TSX ERROR,4
       TSX OK,4
       TRA B20
       REM
       REM
       BCD 1STA      STA TEST
 B21   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP      WITH ZERO
       CLA ONES      ALL ONES
       STA TEMP      PLACE ONES IN TEMP STORE
       CLA TEMP      BRING IT TO ACC
       SUB 8CF       SUB 8CF
       TZE B21+8     OK
       TSX ERROR,4
       TSX OK,4
       TRA B21
       REM
       REM
       BCD 1STA      STA TEST
 B22   CLA 8CF       INITIALIZE TEMP STORAGE
       STO TEMP      WITH ONES IN POS 21-35
       CLA ZERO      BRING ZERO INTO ACC
       STA TEMP      STA IN TEMP STORAGE
       CLA TEMP      BRING IT BACK
       TZE B22+7     OK, REPLACE ONES WITH
       REM           ZEROS
       TSX ERROR,4
       TSX OK,4
       TRA B22
       REM
       REM
       BCD 1STD      STD TEST
 B23   CLA KK34      L+252525000000
       STO TEMP      SAVE ACC
       CLA KK32      L+000000252525
       STD TEMP      SAVE DECREMENT
       CLA TEMP      L SAVED LOCATION
       SUB PTW       L+2000000000
       TZE B23+8     OK, SHOULD GET ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B23
       REM
       REM
       BCD 1STD      STD TEST
 B24   CLA K12       L+0000037777777
       SUB K10       L-300000000000
       STO TEMP      SAVE ACC
       CLA ONES      L-3777777777777
       STD TEMP      SAVE DECREMENT
       ADD TEMP      SHOULD BE L+37777777777
       TZE B24+8     OK
       TSX ERROR,4
       TSX OK,4
       TRA B24
       REM
       REM
       BCD 1CAS      CAS TEST
 B25   CLA THREE     MAKE ACC GRATER THEN
       CAS TWO       STORAGE,SIGNS PLUS
       TRA B25+5     OK, PROCEED
       TRA B25+4     SHOULD NOT BE EQUAL
       TSX ERROR,4   SHOULD NOT BE LESS
       TSX OK,4
       TRA B25
       REM
       REM
       BCD 1CAS      CAS TEST
 B26   CLA TWO       MAKE ACC GREATER THEN
       CAS M3        STORAGE, SIGNS UNLIKE
       TRA B26+5     SHOULD NOT BE EQUAL
       TRA B26+4     SHOULD NOT BE LESS
       TSX ERROR,4
       TSX OK,4
       TRA B26
       REM
       REM
       BCD 1CAS      CAS TEST
 B27   CLA M2        MAKE ACC GREATER THEN
       CAS M3        STORAGE, SIGNS MINUS
       TRA B27+5     OK, PROCEED
       TRA B27+4     SHOULD NOT BE EQUAL
       TSX ERROR,4   SHOULD NOT BE LESS
       TSX OK,4
       TRA B27
       REM
       REM
       BCD 1CAS      CAS TEST
 B28   CLA TWO       MAKE ACC LESS THAN
       CAS THREE     STORAGE, SIGNS PLUS
       TRA B28+3     SHOULD NOT BE GREATER
       TSX ERROR,4   SHOULD NOT BE EQUAL
       TSX OK,4      OK, PROCEED
       TRA B28
       REM
       REM
       BCD 1CAS      CAS TEST
 B29   CLA M3        MAKE ACC LES THAN
       CAS TWO       STORAGE, SIGNS PLUS
       TRA B29+3     SHOULD NOT BE GREATER
       TSX ERROR,4   SHOULD NOT BE EQUAL
       TSX OK,4      OK, PROCEED
       TRA B29
       REM
       REM
       BCD 1CAS      CAS TEST
 B30   CLA M3        MAKE ACC LES THAN
       CAS M2        STORAGE, SIGNS UNLIKE
       TRA B30+3     SHOULD NOT BE GREATER
       TSX ERROR,4   SHOULD NOT BE EQUAL
       TSX OK,4      OK, PROCEED
       TRA B30
       REM
       REM
       BCD 1CAS      CAS TEST
 B31   CLA TWO
       CAS TWO
       TRA B31+4     SHOULD NOT BE GREATER
       TRA B31+5     OK, PROCEED
       TSX ERROR,4   SHOULD NOT BE LESS
       TSX OK,4
       TRA B31
       REM
       REM
       BCD 1CAS      CAS TEST PLUS ZERO AND
       REM           MINUS ZERO
 B32   CLA ZERO      MAKE ACC GREATER THAN
       CAS MZE        STORAGE
       TRA B32+5     OK, PROCEED
       TRA B32+4     SHOULD NOT BE EQUAL
       TSX ERROR,4   SHOULD NOT BE LESS
       TSX OK,4
       TRA B32
       REM
       REM
       BCD 1CAS      CAS TEST  COMAPRE ALL
       REM           ONES WITH ALL ONES
       REM
 B32A  CLA ONES      L ONES
       CAS ONES
       TRA B32A+4    ERROR
       TRA B32A+5    OK-PROCEED
       TSX ERROR,4   ERROR IN CAS WITH ONES
       TSX OK,4
       TRA B32A
       REM
       REM
       BCD 1LDQ      LDQ TEST
 B33   CLA ZERO      CLEAR ACC AND MQ TO START
       LRS 36
       LDQ ONES      BRING IN ALL ONES TO MQ
       LLS 0         SHIFT SIGNS
       TMI B33+7     OK, SIGN IS MINUS
       TSX ERROR-1,4
       TRA B33
       REM
       LLS 35        SHIFT ONES TO ACC
       TOV B33+9     TURN OFF OVFL
       ADD MONE      ADD MINUS ONE TO RIPPLE
       TOV B33+13    SHOULD OVFL
       TSX ERROR-1,4
       TRA B33
       REM
       ALS 2         REMOVE P AND Q POSITION
       TZE B33+16    OK, SHOULD GET ZERO NOW
       TSX ERROR,4
       TSX OK,4
       TRA B33
       REM
       REM
       BCD 1STQ      STQ TEST
 B34   LDQ ONES      BRING ALL ONES TO MQ
       STQ TEMP      PLACE IN TEMP STORAGE
       CLA TEMP      BRING IN ACC
       TMI B34+6     OK, SIGN IS MINUS
       TSX ERROR-1,4
       TRA B34
       REM
       TOV B34+7     TURN OFF OVFL
       ADD MONE      ADD MINUS ONE TO RIPPLE
       TOV B34+11    SHOULD OVFL
       TSX ERROR-1,4
       TRA B34
       REM
       ALS 2         REMOVE P AND Q POSITION
       TZE B34+14    SHOULD GET ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B34
       REM
       REM
       BCD 1STQ      STQ TEST
 B35   LDQ ZERO      BRING IN ALL ZEROS TO MQ
       STQ TEMP      PLACE IN TEMP STORAGE
       CLA TEMP      BRING IN ACC
       TZE B35+5     OK, SHOULD BE ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B35
       REM
       REM
       BCD 1SLQ      SLQ TEST
 B36   CLA ZERO      MAKE ACC AND TEMP STORAGE
       STO TEMP      ALL ZEROS
       LDQ ONES      MAKE MQ ALL ONES
       SLQ TEMP      PLACE S, 1-17 IN TEMP STORAGE
       CLA TEMP      BRING BACK TO ACC
       TMI B36+8     SHOULD BE MINUS
       TSX ERROR-1,4
       TRA B36
       REM
       TOV B36+9     TURN OFF OVFL
       ALS 1         SHIFT TO P POS UNTIL ONLY
       TOV B36+9     BIT LEFT IN Q
       TNZ B36+14    OK, SHOULD NOT GET ZERO
       TSX ERROR-1,4
       TRA B36
       REM
       ALS 2         OK, SHOULD BE ZERO
       TNO B36+17    OK, SHOULD NOT GET EXTRA
       REM           BITS
       TSX ERROR,4
       TSX OK,4
       TRA B36
       REM
       REM
       BCD 1SLQ      SLQ TEST
 B37   LDQ ZERO      BRING ZEROS TO MQ
       CLA ONES      PLACE ONES IN TEMP STORAGE
       STO TEMP
       SLQ TEMP      PLACE ZEROS IN S, 1-17
       CLA TEMP       OF ACC
       ARS 18        SHIFT ONES OUT
       TZE B37+8     OK, RESET SHOULD BE ZEROS
       TSX ERROR,4
       TSX OK,4
       TRA B37
       REM
       REM
       BCD 1TLQ      TLQ TEST
 B38   CLA TWO       MQ LESS THAN ACC
       LDQ M3        MQ MINUS 3 ACC PLUS 2
       TLQ B38+4     OK, SHOULD TRANSFER
       TSX ERROR,4
       TSX OK,4
       TRA B38
       REM
       REM
       REM
       BCD 1TLQ      TLQ TEST
 B39   CLA M3        MQ GREATER THEN ACC
       LDQ M2        MQ MINUS 2 ACC MINUS 3
       TLQ B39+4      SHOULD NOT TRANSFER
       TRA B39+5     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B39
       REM
       REM
       BCD 1TLQ      TLQ TEST
 B40   CLA TWO       MQ EQUALS ACC
       LDQ TWO       BOTH PLUS TWO
       TLQ B40+4     SHOULD NOT TRANSFER
       TRA B40+5     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B40
       REM
       REM
       BCD 1TLQ      TLQ TEST
 B41   CLA ZERO      MQ LESS THEN ACC
       LDQ MZE       MQ MINUS 0 ACC PLUS 0
       TLQ B41+4     OK, SHOULD TRANSFER
       TSX ERROR,4
       TSX OK,4
       TRA B41
       REM
       REM
       BCD 1TLQ      TLQ TEST
 B42   CLA MZE       MQ GREATER THEN ACC
       LDQ ZERO      MQ PLUS 0 ACC MINUS 0
       TLQ B42+4     SHOULD NOT TRANSFER
       TRA B42+5     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B42
       REM
       REM
       BCD 1TLQ      TLQ TEST
 B42A  CLA MZE       ACC MINUS ZERO
       LDQ MONE      MQ MINUS ONE
       TLQ B42A+4
       TSX ERROR,4
       TSX OK,4
       TRA B42A
       REM
       REM
       BCD 1RND      RND TEST
 B43   CLA ZERO      CLEAR ACC
       LDQ PTW       PLACE BIT IN MQ 1 POS
       RND           ROUND SHOULD GO TO ACC
       LBT           POS 35, IS IT THERE
       TSX ERROR,4   NO, ERROR
       TSX OK,4      YES, OK
       TRA B43
       REM
       REM
       BCD 1MPY      MPY TEST
 B44   CLA PONES     PLACE ALL ONES IN ACC
       ALS 2         PLACE ONES IN P AND Q
       LDQ ZERO      MULTPLY ZERO BY ZERO
       MPY ZERO      CHECK ACC AND MQ FOR ZERO
       TZE B44+7     OK, SHOULD BE ZERO
       TSX ERROR-1,4
       TRA B44
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING TO ACC TO CHECK
       TZE B44+11    OK, SHOULD BE ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B44
       REM
       REM
       BCD 1MPY      MPY TEST
 B45   LDQ ONE       MULTIPLY ONE BY ONE
       MPY ONE       SHOULD GET ZERO IN ACC
       TZE B45+5
       TSX ERROR-1,4
       TRA B45
       REM
       STQ TEMP      SAVE MQ AND CHECK
       CLA TEMP      FOR ONE IN ACC 34
       TNZ B45+10    OK, PROCEED
       TSX ERROR-1,4
       TRA B45
       REM
       ARS 2         SHIFT OVER
       TZE B45+13    OK, CHECKS OUT
       TSX ERROR,4
       TSX OK,4
       TRA B45
       REM
       REM
       BCD 1MPY      MPY TEST
 B46   LDQ PONES     MULTIPLY ALL ONES
       MPY ONE       BY ONE
       TZE B46+5     OK, ACC SHOULD BE ZERO
       TSX ERROR-1,4
       TRA B46
       REM
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING IT TO ACC
       TOV B46+7     TURN OFF OVFL
       ADD ONE       ADD ONE TO TURN ON OVFL
       TOV B46+11    OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B46
       REM
       REM
       REM
       BCD 1MPY      MPY TEST
 B47   LDQ PONES     MULTIPLY ALL ONES
       MPY PONES     BY ALL ONES
       ADD ONE       ADD ONE, 2-35 HAVE ONES
       TOV B47+4     SET OVFL
       ADD ONE       RIPPLE CARRY FOR ACC
       TOV B47+8     OK, DID RIPPLE
       TSX ERROR-1,4
       TRA B47
       REM
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING IT TO ACC
       SUB ONE       SUB ONE
       TZE B47+13    SHOULD TRANSFER
       TSX ERROR,4
       TSX OK,4
       TRA B47
       REM
       REM
       BCD 1MPY      MPY TEST
 B48   LDQ ZERO      MULTIPLY PLUS NUMBER BY
       MPY ZERO      PLUS, PRODUCT IS PLUS
       TPL B48+5     OK, ACC IS PLUS
       TSX ERROR-1,4
       TRA B48
       REM
       TQP B48+7     OK, MQ IS PLUS
       TSX ERROR,4
       TSX OK,4
       TRA B48
       REM
       REM
       BCD 1MPY      MPY TEST
 B49   LDQ MZE       MULTIPLY MINUS NUMBER BY
       MPY MZE       MINUS NUMBER, CHECK SING
       TPL B49+5     OK, ACC IS PLUS
       TSX ERROR-1,4
       TRA B49
       REM
       TQP B49+7     OK, MQ IS PLUS
       TSX ERROR,4
       TSX OK,4
       TRA B49
       REM
       REM
       BCD 1MPY      MPY TEST
 B50   LDQ MZE       MULTIPLY MQ MINUS BY
       MPY ZERO      A PLUS, CHECK SIGN
       TMI B50+5     ACC SHOULD BE MINUS
       TSX ERROR-1,4
       TRA B50
       REM
       TQP B50+7     MQ SHOULD BE MINUS
       TRA B50+8     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B50
       REM
       REM
       BCD 1MPY      MPY TEST
 B51   LDQ ZERO      MULTIPLY MQ PLUS BY
       MPY MZE       MINUS
       TMI B51+5     ACC IS MINUS
       TSX ERROR-1,4
       TRA B51
       REM
       TQP B51+7
       TRA B51+8     MQ IS MINUS
       TSX ERROR,4
       TSX OK,4
       TRA B51
       REM
       REM
       BCD 1MPR      MPR TEST
 B52   LDQ PTW       MULTIPLY +200---BY ONE
       MPR ONE       SHOULD ROUND TO ACC
       TNZ B52+5     OK, DID ROUND
       TSX ERROR-1,4
       TRA B52
       REM
       ARS 1         OK, NOW MOVE BIT OUT
       TZE B52+8     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B52
       REM
       REM
       BCD 1MPR      MPR TEST
 B53   LDQ PTW       MULTIPLY PLUS TWO BY
       MPR ZERO      ZERO SHOULD NOT ROUND
       TZE B53+5     OK, IN ACC CHECK SIGN
       TSX ERROR-1,4
       TRA B53
       REM
       TPL B53+8     OK, PROCEED
       TSX ERROR-1,4
       TRA B53
       REM
       TQP B53+10    OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B53
       REM
       REM
       BCD 1MPR      MPR TEST
 B54   LDQ MTW       MULTIPLY MINUS TWO BY
       MPR ZERO      ZERO, CHECK SIGNS
       TPL B54+4     ERROR
       TRA B54+6     OK, PROCEED
       TSX ERROR-1,4
       TRA B54
       REM
       TQP B54+8     ERROR, SHOULD BE MINUS
       TRA B54+9     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B54
       REM
       REM
       BCD 1MPR      MPR TEST
 B54A  TOV B54A+1    TURN OFF OVFL
       LDQ PONES     ALL ONES IN MQ
       MPR PTW       ACC 1-35 ALL ONES
       SUB PTW       MQ 1, A ONE, FORCE ROUND
       TZE B54A+7    SHOULD BE ZERO
       TSX ERROR-1,4
       TRA B54A
       REM
       TNO B54A+9    SHOULD NOT BE OVFL
       TSX ERROR,4
       TSX OK,4
       TRA B54A
       REM
       REM
       BCD 1DVP      DVP TEST
 B55   LDQ TWO       DIVIDEND PLUS TWO
       CLA ZERO      DIVIDE BY ONE SHOULD
       DVP ONE       GET A PLUS TWO IN MQ
       TPL B55+6     OK, PROCEED
       TSX ERROR-1,4 WRONG SIGN
       TRA B55
       REM
       TZE B55+9     REMAINDER SHOULD BE ZERO
       TSX ERROR-1,4
       TRA B55
       REM
       STQ TEMP      SAVE CONTENTS OF MQ
       CLA TEMP      BRING TO ACC
       SUB TWO       SUB TWO TO GET ZERO
       TZE B55+14    OK PROCEED
       TSX ERROR,4   SHOULD NOT BE 2 IN ACC
       TSX OK,4
       TRA B55
       REM
       REM
       BCD 1DVP      DVP TEST
 B56   CLA ZERO      CLEAR ACC
       LDQ ONES      DIVIDE ALL ONES IN MQ
       DVP MTW        BY -200...
       TPL B56+6     OK, SHOULD BE PLUS
       TSX ERROR-1,4
       TRA B56
       REM
       STO TEMP      SAVE ACC AND MQ
       STQ TEMP+1
       TQP B56+10    ERROR
       TRA B56+12    MQ SHOULD BE MINUS
       TSX ERROR-1,4
       TRA B56
       REM
       CLA TEMP+1    ZEROS TO ACC
       SUB TEMP      SUB ONES FROM ACC
       TOV B56+15    TURN OFF OVFL
       ALS 1         SHOULD GET OVFL
       TOV B56+18    OK, GET OVFL
       TSX ERROR,4   ERROR
       TSX OK,4
       TRA B56
       REM
       REM
       BCD 1DCT      DCT TEST
 B57   DCT           INITIALIZE THE
       TRA B57+2     DCT INDICATOR
       DCT           TEST INDICATOR OFF
       TRA B57+5     INDICATOR NOT OFF
       TRA B57+7
       TSX ERROR-1,4
       TRA B57
       REM
       CLA ZERO      PLACE ZERO IN ACC
       LDQ PTW       MAKE MQ +200... DIVIDE
       DVP PTW       BY +200...
       DCT           TEST INDICATOR OFF
       TSX ERROR,4   IF ON, DID NOT SHOW
       TSX OK,4
       TRA B57       OK, PROCEED
       REM
       REM
       BCD 1DCT      DCT TEST
 B58   CLA PTW       DIVIDE +200... BY -100...
       DVP MON        CHECK INDICATOR SHOULD
       REM           BE ON
       DCT           TEST INDICATOR ON
       TRA B58+5     OK, PROCEED
       TSX ERROR,4   ENTERS HERE ON ERROR
       TSX OK,4
       TRA B58
       REM
       REM
       BCD 1DCT      DIVIDE A ONE IN EACH
 B58A  CLA ONE        POSITION BY ZERO
       STO TEMP
       DVP ZERO
       SUB TEMP      CHECK THAT ACC DID NOT
       TZE B58A+7    CHANGE
       TSX ERROR-1,4
       TRA B58A
       REM           CHECK DIVIDE CHECK LIGHT
       DCT           SHOULD BE ON
       TRA B58A+11   OK, PROCEED
       TSX ERROR-1,4 NO DIVIDE CHECK
       TRA B58A
       ALS 1         MOVE ACROSS ACC
       REM
       TNZ B58A+1      BY ONE
       TSX OK,4
       TRA B58A
       REM
       REM
       BCD 1DVH      DVH TEST, NO HALT
 B62   LDQ PTW       MAKE MQ POSITIVE
       CLA ZERO      MAKE ACC ZERO
       DVH PTW       DIVIDE
       TPL B62+6     OK, PROCEED
       TSX ERROR-1,4
       TRA B62
       REM
       TOV B62+7     TURN OFF OVFL
       TZE B62+10
       TSX ERROR-1,4
       TRA B62
       REM
       STQ TEMP      SAVE MQ, ADD IT TO ACC
       CLA TEMP
       TNZ B62+15    OK, PROCEED
       TSX ERROR-1,4
       TRA B62
       REM
       LBT           CHECK POS 35 FOR ONE
       TRA B62+18    ERROR, GOT A ZERO
       TRA B62+20    OK, PROCEED
       TSX ERROR-1,4
       TRA B62
       REM
       ARS 1         OK, SHIFT IT OUT
       TZE B62+23    OK, ALL SHOULD BE ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B62
       REM
       REM
       BCD 1DVH      DVH TEST, NO HALT
 B63   CLA ZERO      MAKE ACC ZERO
       LDQ ONES      MAKE MQ ALL ONES
       DVH MTW       DIVIDE BY -200...
       TPL B63+6     OK, PROCEED
       TSX ERROR-1,4
       TRA B63
       REM
       STO TEMP      SAVE AC AND MQ
       STQ TEMP+1
       TQP B63+10    ERROR IN MQ SIGN
       TRA B63+12    OK, IS MINUS, PROCEED
       TSX ERROR-1,4
       TRA B63
       REM
       CLA TEMP+1    SUB ACC FROM MQ
       SUB TEMP
       TOV B63+15    TURN OFF OVFL
       LLS 1         SHIFT ONE BIT
       TOV B63+18    OK, SHOULD BE ON
       TSX ERROR,4
       TSX OK,4
       TRA B63
       REM
       REM
       BCD 1ANA      ANA TEST
 B64   CAL MZE       MAKE ACC MINUS ZERO
       ANA ONES      /AND/ TO ALL POSITIONS
       REM           ZERO EXCEPT POS P
       PBT           P SHOULD HAVE BIT
       TRA B64+5     ERROR, NO BIT IN POS P
       TRA B64+7     OK, PROCEED
       TSX ERROR-1,4
       TRA B64
       REM
       ARS 1         OK, NOW POS Q SHOULD BE
       REM           ZERO
       PBT           SHIFT AND TEST
       TRA B64+12    OK, PROCEED
       TSX ERROR-1,4
       TRA B64
       REM
       TPL B64+14    OK, SHOULD BE PLUS
       TSX ERROR,4
       TSX OK,4
       TRA B64
       REM
       REM
       BCD 1ANA      ANA TEST
 B65   CAL ONES      PLACE ALL ONES IN ACC
       ANA ONES      /AND/ TO ALL ONES
       ADD ONE       ADD ONE, CAUSE RIPPLE
       ALS 1         MOVE OUT Q
       TZE B65+6     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B65
       REM
       REM
       BCD 1ANA      ANA TEST
 B66   CAL ZERO      PLACE ZEROS IN ACC
       ANA ONES      /AND/ TO ALL ZEROS
       TZE B66+4     OK, NO PICK UP
       REM
       TSX ERROR,4
       TSX OK,4
       TRA B66
       REM
       REM
       BCD 1ANA      ANA TEST
 B67   CAL KK30      L-252525252525
       ANA KK31      L-125252252525
       SUB KK32      L+000000252525
       PBT           TEST P FOR BIT
       TRA B67+6     ERROR
       TRA B67+8     OK, PROCEED AND MOVE IT OUT
       TSX ERROR-1,4
       TRA B67
       REM
       ALS 2         ALL RIGHT MOVE IT OUT
       TZE B67+11    OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B67
       REM
       REM
       BCD 1ANA      ANA TEST
 B68   CLA KK30      L-252525252525
       ANA KK33      L-252525525252
       SUB KK34      L+252525000000
       TZE B68+5     OK, SHOULD BE ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B68
       REM
       REM
       BCD 1ANS      ANS TEST
 B69   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP      WITH ZERO
       CAL ONES      PLACE ALL ONES IN ACC
       ANS TEMP      /AND/ TO ZERO STORAGE
       CLA TEMP      BRING RESULT TO ACC
       TZE B69+8     SHOULD BE ZERO, CHECK SIGN
       TSX ERROR-1,4
       TRA B69
       REM
       TPL B69+10    OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B69
       REM
       REM
       BCD 1ANS      ANS TEST
 B70   CLA ONES      INITIALIZE TEMP STORAGE
       STO TEMP      WITH ALL ONES
       CAL ZERO      MAKE ACC ZERO
       ANS TEMP      /AND/ TO ONES IN STORAGE
       CLA TEMP      BRING RESULT TO ACC
       ALS 1         SHIFT 0 POS OUT
       TZE B70+8     OK, ALL SHOULD BE ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B70
       REM
       REM
       BCD 1ANS      ANS TEST WITH SIGNS UNLIKE
 B71   CLA KK30      INITIALIZE STORAGE WITH
       STO TEMP      L-252525252525
       CAL KK35      MAKE ACC +1252522522525
       ANS TEMP      /AND/, THEN CHECK ACC
       SUB KK35      SUB ORIGINAL CONTENTS
       TZE B71+8     OK, PROCEED CHECK STORAGE
       TSX ERROR-1,4
       TRA B71
       CLA TEMP      CHECK STORAGE SHOULD
       SUB KK32      BE L+000000252525
       TZE B71+12    OK, IT WAS, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B71
       REM
       REM
       BCD 1ORA      ORA TEST
 B72   CLA ZERO      MAKE ACC ZERO
       ORA ONES      /OR/ WITH ONES
       PBT           CHECK P FOR ONE
       TRA B72+5     ERROR IN P
       TRA B72+7     CHECK OTHER POSITIONS
       TSX ERROR-1,4
       TRA B72
       REM
       ADD ONE       CHECK OTHER POSITIONS
       ALS 2         CLEAR P AND Q
       TZE B72+11    OK, SHOULD BE ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B72
       REM
       REM
       BCD 1ORA      ORA TEST
 B73   CAL ONES      MAKE ACC POS P-35 ONES
       ORA ZERO      /OR/ WITH ZEROS
       PBT           CHECK P FOR ONE
       TRA B73+5     ERROR IN P
       TRA B73+7     PROCEED
       TSX ERROR-1,4
       TRA B73
       REM
       ADD ONE       OK, TEST POS 1-35
       ALS 2         MOVE OUT P AND Q
       TZE B73+11    OK, SHOULD BE ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B73
       REM
       REM
       BCD 1ORA      ORA TEST, SIGNS UNLIKE
 B74   CLA KK36      MAKE ACC +252525252525
       ORA KK33          /OR/ -252525525252
       SUB KK37            SUB 252525777777
       PBT           CHECK P FOR ONE
       TRA B74+6     ERROR IN P
       TRA B74+8     OK, PROCEED
       TSX ERROR-1,4
       TRA B74
       REM
       REM
       ALS 2         MOVE OUT P AND Q
       TZE B74+11    OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B74
       REM
       REM
       BCD 1ORA      ORA TEST, SIGNS PLUS
 B75   CLA KK36      MAKE ACC 252525252525
       ORA KK35         /OR/ +125252252525
       SUB KK38           SUB 377777252525
       TZE B75+5     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B75
       REM
       REM
       BCD 1ORS      ORS TEST
 B76   CLA ONES      INITIALIZE TEMP STORAGE
       STO TEMP      WITH ONES
       CLA ZERO      MAKE ACC ZERO
       ORS TEMP      /OR/ TO ONES
       TZE B76+7     ACC SHOULD BE ZERO
       TSX ERROR-1,4 ERROR IN ACC
       TRA B76
       REM
       CLA TEMP      BRING BACK STORAGE
       ADD MONE      ADD MINUS ONE TO RIPPLE
       PBT           P SHOULD HAVE BIT
       TSX ERROR,4   ERROR, NO BIT IN POS P
       TSX OK,4      OK, PROCEED
       TRA B76
       REM
       REM
       BCD 1ORS      ORS TEST
 B77   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP      WITH ZEROS
       CAL ONES      CAL ALL ONES P-35
       ORS TEMP      /OR/ TO ZEROS
       ADD ONE       CHECK ACC, ADD ONE, SHOULD
       PBT           NOT GET A BIT IN P
       TRA B77+9     OK, NOW CHECK STORAGE
       TSX ERROR-1,4 ERROR, BIT IN P
       TRA B77
       REM
       CLA TEMP      OK, NOW CHECK STORAGE
       ADD MONE      ADD MINUS ONE TO RIPPLE
       TOV B77+13    OK, SHOULD OVERFLOW
       TSX ERROR,4   NO, NOT ZERO
       TSX OK,4      YES, PROCEED
       TRA B77
       REM
       REM
       BCD 1ORA      ORA TEST, SIGNS UNLIKE
 B78   CLA KK36      INITIALIZE TEMP STORAGE
       STO TEMP      WITH 252525252525
       CLA KK33      MAKE ACC-252525525252
       ORS TEMP      /OR/ TO TEMP STORAGE
       CLA TEMP      BRING TEMP TO ACC
       SUB KK37      SUB 252525777777
       TZE B78+8     OK, PROCEED
       TSX ERROR,4
       TSX OK,4
       TRA B78
       REM
       REM
       BCD 1ORS      ORS TEST
 B79   CLA KK36      INITIALIZE TEMP STORAGE
       STO TEMP            WITH +25252525252
       CAL KK31      MAKE P-35, -12525222525
       ORS TEMP      /OR/ TO TEMP STORAGE
       CLA TEMP      BRING IT TO ACC
       ADD KK38            ADD 3777777252525
       TZE B79+8     OK, SHOULD BE ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B79
       REM
       REM
       BCD 1TTR      TTR TEST , NOT IN TRAP MODE
 B80   TOV B80+1     TURN OFF OVFL
       REM
       TTR B80+3     SHOULD TRAP TRANSFER
       TSX ERROR,4   DID NOT TRANSFER
       TSX OK,4
       TRA B80
       REM
       BCD 1ETM-     ETM- TEST TO SEE IF GET
 B81   ETM           IN TRAP MODE
       CLA KK85      MAKE ADR AT ONE A TTR
       STO 1         TO B82
       CLA ZERO      CONDITION WILL BE MET
       TZE B81+5     AND SHOULD GO TO ONE
       LTM
       TSX ERROR,4
       TSX OK,4      PROCEED TO B82
       TRA B81
       REM
       REM
       BCD 1ETM-     TTR TEST, IN TRAP MODE
 B82   ETM
       TTR B83       SHOULD TTR TO B83
       LTM
       TSX ERROR,4   DID NOT TRAP TRANSFER
       TSX OK,4
       TRA B82
       REM
       REM
       REM
       BCD 1ETM-     YES TRA IN TRAP MODE
 B83   ETM
       CLA KK80      TTR TO B83+9, IS RETURN
       STO 1         ADDRESS AFTER TRAP.
       CLA KK81      HTR B84 IS IN ZERO, IF
       STO 0         INSTRUCTION COUNTER FAILS
       TRA B83+6     SHOULD NOT TRANSFER
       REM
       LTM
       TSX ERROR-1,4 TRAP FAILS, TRANSFERS
       TRA B83
       LTM           SHOULD TRAP AND RETURN HERE
       CLA 0         CHECK ADDRESS AT ZERO
       SUB KK82      SUB THE ADDRESS OF TRAP
       TZE B83+14    OK, SHOULD BE EQUAL
       TSX ERROR,4
       TSX OK,4
       TRA B83
       REM
       REM
       BCD 1ETM-     TEST CONDITIONAL TRANSFERS,
       REM           CONDITIONS NOT MET.
       REM           ADDRESS OF ERROR IS IN
 B84   ETM           00000 OR TRAP ON PRINTOUT
       CLA KK83      LOC 1 SET TO TTR B84A
       STO 1         SHOULD BE NO TRANSFERS
       LDQ 8CF       MAKE MQ LARGER THAN ACC
       CLM           SET ACC TO ZERO AND SET
       STO 0         LOC 0 TO ZERO
       TNZ B84C
       TMI B84C
       TOV B84C
       TLQ B84C
       LXA ZERO,1    LOAD INDEX A WITH ZERO
       TXH B84C,1
       TIX B84C,1,8
       CLA ONES      LOAD ACC WITH ONES
       TZE B84C
       TPL B84C
       ALS 12        FORCE OVFL
       TNO B84C
       LXA 8CF,1     LOAD INDEX A WITH 77777
       TNX  B84C,1,1
       TXL  B84C,1,1
       LDQ MZE       LOAD MQ WITH MINUS ZERO
       TQP B84C
       TQP B84C      RETEST TO SEE IF TEST IS
       REM           COMPLETE. IF TRAP OCCURS,
       REM           COMES BACK HERE
       REM
 B84A  LTM           LEAVES TRAP MODE
       CLA 0         CHECK ADDRESS AT ZERO
       SUB KK86      IS TEST COMPLETE
       TZE B84A+5    YES PROCEED
       TSX ERROR,4   NO, ERROR ABOVE, CHECK
       REM           ZERO ADDRESS
       TSX OK,4
       TRA B84
       REM
       REM
       BCD 1ETM-
 B84B  TRA B85
       REM
 B84C  LTM           IF TRANSFER IS WRONG,
       TSX ERROR,4   COMES HERE
       TSX OK,4
       TRA B84
       REM
       REM           TEST CONDITIONAL TRANSFERS
       REM           WITH CONDITIONALS SATISFIED
       REM
       BCD 1ETM-     THIS IS SET UP FOR
 B85   ETM           TRAP RETURN
       CLA KK85A     INITIALIZE TEMP STORAGE
       REM           WITH LOC OF FIRST COND
       REM           TRANSFER
       STO TEMP
       CLA KK84      TTR B85+6
       STO 1
       TTR B85+16    OK, START TESTS
       CLA 0         RETURN FROM LOC 1
       LDQ TEMP
       CAS TEMP      COMPARE ACC AND TEMP
       TTR B85B      IF TEMP LESS THEN ZERO
       TTR B85+12    IF TEMP EQUAL TO ZERO
       TTR B85B      IF TEMP GRATER THEN ZERO
       ADD TWO       NOW ADVANCE TWO POSITIONS
       STA B85+15    SO AS TO CONTINUE TO THE
       REM           NEXT SUBTEST
       STA TEMP      RESET ADDRESS OF TEMP
       TTR 0         GO TO RESPECTIVE SECTION
       REM
       REM
       ALS 50        CLEAR ACC
       STZ 0
       TZE B85A      TZE TEST
       TTR B85A
       TPL B85A      TPL TEST
       TTR B85A
       TOV B85A      TOV TEST
       TTR B85A
       TNO B85A
       TTR B85A      TNO TEST
       LTM           TEST IS FINISED NOW
       TRA B86       GO TO NEXT SECTION
       REM
 B85A  LTM           COMES HERE ON EROR
       TSX ERROR-1,4 ERROR, DID NOT TRAP
       TRA B85
       REM
       TRA B86       CONTINUE TEST
       REM
       REM           COMES HERE IF ADDRESS AT
       REM           ZERO IS INCORRECT
 B85B  LTM
       TSX ERROR-1,4 NOT JUMPING PROPERLY
       TRA B85
       REM
       REM
 B86   ETM
       CLA KK85B
       STO TEMP
       REM           INITIALIZE TEMP STORAGE
       REM           WITH LOC OF FIRST COND
       REM           TRANSFER
       CLA ONES      BRING IN ALL ONES
       TMI B86A      TMI TEST
       TTR B86A
       TNZ B86A      TNZ TEST
       TTR B86A
       LTM           TEST IS FINISHED NOW
       TRA B87       GO TO NEXT SECTION
       REM
 B86A  LTM           COMES HERE ON ERROR
       TSX ERROR-1,4 ERROR, DID NOT TRAP
       TRA B85
       REM
       REM
 B87   ETM           TEST TQP, CONDITION
       CLA KK85C     SATISFIED
       STO TEMP
       REM           INITIALIZE TEMP STORAGE
       REM           WITH LOC OF FIRST COND
       REM           TRANSFER
       LDQ ONE       LOAD MQ POS 35 WITH ONE
       TQP B87A      TEST TQP
       TTR B87A
       LTM           TEST IS FINISHED NOW
       TRA B88       GO TO NEXT SECTION
       REM
 B87A  LTM
       TSX ERROR-1,4 ERROR, DID NOT TRAP
       TRA B85
       REM
       REM           CHECK ADDRESS AT ZERO
       REM           FOR LOCATION OF LAST INST
 B88   ETM           PREFORMED CORRECTLY
       CLA KK85D     INITIALIZE TEMP STORAGE
       STO TEMP      WITH LOC OF FIRST COND
       REM           TRANSFER
       TXI B88A,1,9  TXI TEST
       TTR B88A
       TXH B88A,1    TXH TEST
       TTR B88A
       TXL B88A      TXL TEST
       TTR B88A
       TIX B88A,1,1  TIX TEST
       TTR B88A
       TNX B88A,1,-1 TNX TEST
       TTR B88A
       TSX B88A,1    TSX TEST
       TTR B88A
       LTM           TEST IS FINISHED
       TRA B88A+2    GO TO NEXT SECTIONS
       REM
 B88A  LTM           COMES HERE ON ERROR
       TSX ERROR,4   ERROR, DID NOT TRAP
       TSX OK,4
       TRA B85
       REM
       NOP
       REM
       CLA END+1     RESTORE
       STO 0         RESET-START
       TRA *+2
       REM
       REM
       BCD 1SLT      PSE TEST
 B89   SLF           TURN OFF ALL SENSE LIGHTS
       SLT 1         TEST LIGHT ONE
       TRA B90       OK, OFF
       TSX ERROR-1,4 ERROR, LIGHT WAS ON
       TRA B89
       REM
 B90   SLT 2         TEST LIGHT TWO
       TRA B91       OK, PROCEED
       TSX ERROR-1,4 ERROR, LIGHT WAS ON
       TRA B89
       REM
 B91   SLT 3         TEST LIGHT THREE
       TRA B92       OK, PROCEED
       TSX ERROR-1,4 ERROR, LIGHT WAS ON
       TRA B89
       REM
 B92   SLT 4         TEST LIGHT FOUR
       TRA B92+3     OK, PROCEED
       TSX ERROR,4   ERROR, LIGHT WAS ON
       TSX OK,4
       TRA B89
       REM
       REM
       BCD 1SLT 1    PSE TEST
 B93   SLN 1         TURN ON LIGHT ONE
       SLT 1         TEST LIGHT ONE
       TSX ERROR,4   ERROR, IT WAS NOT ON
       TSX OK,4      OK, PROCEED
       TRA B93
       REM
       BCD 1SLT 2    PZE TEST
 B94   SLN 2         TURN ON LIGHT TWO
       SLT 2         TEST LIGHT TWO
       TSX ERROR,4   ERROR, IT WAS NOT ON
       TSX OK,4      OK, PROCEED
       TRA B94
       REM
       REM
       BCD 1SLT 3    PZE TEST
 B95   SLN 3         TURN ON LIGHT THREE
       SLT 3         TEST LIGHT THREE
       TSX ERROR,4   ERROR, IT WAS NOT ON
       TSX OK,4      OK, PROCEED
       TRA B95
       REM
       REM
       BCD 1SLT 4    PZE TEST
 B96   SLN 4         TURN ON LIGHT FOUR
       SLT 4         TEST LIGHT FOUR
       TSX ERROR,4   ERROR, IT WAS NOT ON
       TSX OK,4      OK, PROCEED
       TRA B96
       REM
       REM
       BCD 1SLT      MSE TEST, TEST ALL LIGHTS
       REM           ARE OUT
 B93A  SLT 1         TEST LIGHT ONE
       TRA B93A+4    SHOULD BE OFF
       TSX ERROR-1,4
       TRA B93A
       REM
       SLT 2         TEST LIGHT TWO
       TRA B93A+8    SHOULD BE OFF
       TSX ERROR-1,4
       TRA B93A
       REM
       SLT 3         TEST LIGHT THREE
       TRA B93A+12   SHOULD BE OFF
       TSX ERROR-1,4
       TRA B93A
       REM
       SLT 4         TEST LIGHT FOUR
       TRA B93A+15   SHOULD BE OFF
       TSX ERROR,4
       TSX OK,4
       TRA B93A
       REM
       BCD 1NOP      NOP TEST TO SEE IF NOP IS
 B96A  SLF           INTERPRETED AS PSE 97
       NOP 97
       SLT 1         TEST LIGHT ONE
       TRA B96A+5
       TSX ERROR,4
       TSX OK,4
       TRA B96A
       REM
       REM
       BCD 1SWT      SENSE SWITCH TEST
 B98   CLA KK87      PLACE TRA B98A+1 IN B98A
       STO B98A      FOR FIRST TIME THROUGH,
       REM           CHANGES ON SECOND TIME
       REM           THROUGH, EACH SWITCH IS
       REM           REPRESENTED IN MQ AND ACC
       REM           BY GROUP OF SIX BITS
       CLA ZERO      CLEAR ACC
       SWT 1         SW 1
       TRA B98+6     DOWN L -370000000000
       CLA SW1       UP
       SWT 2         SW 2
       TRA B98+9     DOWN L+007700000000
       ORA SW2       UP
       SWT 3         SW 3
       TRA B98+12    DOWN L +000077000000
       ORA SW3       UP
       SWT 4         SW 4
       TRA B98+15    DOWN L +000000770000
       ORA SW4       UP
       SWT 5         SW 5
       TRA B98+18    DOWN L +000000007700
       ORA SW5       UP
       SWT 6         SW 6
       TRA B98+21    UP
       ORA SW6       DOWN L +000000000077
       REM
       NOP 118       TEST, SEE IF NOP INTERPRETED
       REM           AS PSE. IF SW6 UP, NOT
       REM           CONCLUSIVE
       TRA B98A      SENSE SWITCH TEST
       TSX ERROR-1,4
       TRA B98
       REM
 B98A  TRA B98A+1
       STO TEMP
       LDQ TEMP
       CLA KK88      RESET SWITCH TO COMPARE
       STO B98A      TO SEE IF AGREE SECOND
       REM           TIME
       TRA B98+2     REPEAT B98 ONCE
       REM
 B98B  SUB TEMP      SUBT FIRST RESULT FROM 2ND
       TZE B98B+3    OK, PROCEED
       TSX ERROR,4   ERROR IS SHOWN BY COMPARING
       TSX OK,4      ACC RESULTS WITH MQ. IF
       TRA B98       SWITCH WAS UP, ITS
       REM           RESPECTIVE PART OF ACC
       REM           SHOULD BE OFF. IF SWITCH
       REM           WAS DOWN, THIS PART
       REM           SHOULD BE ON
       REM
       REM
       BCD 1STT      TEST-STORE TAG
 A1    CLM
       SLW TEMP      SAVE ACC
       CLA ONES      L ALL ONES
       STT TEMP      PUT ONES IN TAG
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A1+8      ERROR
       TRA A2        OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A1        REPEAT SECTION
       REM
 A2    CLA TEMP      TEST TAG FOR ONES
       LDQ K2        L +700000 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K2
       TRA A2+5      ERROR
       TRA A2+6      OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A1        REPEAT TEST
       REM
       REM
       BCD 1STT
 A2A   CLA ONES      L ALL ONES
       STO TEMP      SAVE ACC
       CLM
       STT TEMP      PUT ZEROS IN TAG
       CLA TEMP      TEST TAG FOR ZEROS
       LDQ K3        L -377777077777 MQ,ACC
       REM           SHOULD BE THE SAME
       CAS K3
       TRA A2A+9     ERROR
       TRA A2A+10    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A2A       REPEAT TEST
       REM
       REM
       BCD 1STZ      TEST STORE ZERO AND SEE IF
       REM           ACC AND MQ CHANGE
 A3    CLA ONES      L ALL ONES
       STO TEMP      SAVE ACC
       LDQ A3+2
       STZ TEMP      BLANK TEMP
       STQ TEMP+1    SAVE MQ
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A3+9      ERROR
       TRA A3A       OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A3        REPEAT SECTION
       REM
 A3A   CLA TEMP+1    L SAVED MQ
       LDQ A3+2      MQ, ACC SHOULD BE SAME
       CAS A3+2
       TRA *+2       ERROR
       TRA A4        OK MQ UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A3        REPEAT SECTION
       REM
 A4    CLA TEMP      CHECK TEMP
       TZE A4+3      OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A3        REPEAT TEST
       REM
       REM
       BCD 1XCA      TEST-EXCHANGE ACC AND MQ
 A5    CLA ONE       L +1
       LDQ MZE       L -0 TO MQ
       XCA
       TMI A5A       ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A5        REPEAT SECTION
       REM
 A5A   TZE A5A1      OK OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A5        REPEAT SECTION
       REM
 A5A1  LLS 35        BRING MQ TO ACC
       LDQ ONE       L +1 TO MQ
       CAS ONE
       TRA A5A1+5    ERROR
       TRA A5A1+6    MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A5        REPEAT TEST
       REM
       REM
       BCD 1XCA      XCA TEST
 A6    CLA K3        L -377777077777
       LDQ K2        L +000000700000
       XCA           CHECK ALL POSITIONS
       STQ TEMP       SAVE MQ
       LDQ K2        L +7000000 MQ,ACC SHOULD
       REM           BE THE SAME
       CAS K2
       TRA A6+8      ERROR
       TRA A6A       ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A6        REPEAT SECTION
       REM
 A6A   CLA TEMP      CHECK SAVED MQ
       LDQ K3        L -377777077777 MQ,ACC
       REM           SHOULD BE THE SAME
       CAS K3
       TRA A6A+5     ERROR
       TRA A6A+6     MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A6        REPEAT TEST
       REM
       REM
       BCD 1XCA
 A7X   CLA ONES      L ALL ONES
       ALS 3         ACC NOW -11377777777770
       LDQ K3        L -377777077777
       XCA           CHECK XCA FOR
       REM           CLEARING P,Q
       STQ TEMP      SAVE MQ
       LDQ K3        L -377777077777 MQ,ACC
       REM           SHOULD BE THE SAME
       CAS K3
       TRA *+2       ERROR
       TRA A7A       ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A7X
       REM
 A7A   CLA TEMP      CHECK SAVED MQ
       LDQ K6        L -37777777770 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K6
       TRA A7A+5     ERROR
       TRA A7A+6     MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A7X
       REM
       REM
       BCD 1XCL      TEST-EXCHANGE LOGICAL
       REM           ACCUMULATOR AND MQ
 A10X  CLA ONE       L +1
       LDQ MZE       L -0 TO MQ
       XCL 0
       PBT
       TRA *+2       ERROR
       TRA A10A      OK-ACC HAS P BIT
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A10X
       REM
 A10A  ARS 2         ACC NOW +10000000000
       STQ TEMP      SAVE MQ
       LDQ PTHR      L +1000000000 TO MQ
       CAS PTHR
       TRA A10A+6    ERROR
       TRA A10A1     ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A10X
       REM
 A10A1 CLA TEMP      CHECK SAVED MQ
       LDQ ONE       L +1 TO MQ
       CAS ONE
       TRA A10A1+5   ERROR
       TRA A10A1+6   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A10X
       REM
       REM
       BCD 1XCL
 A12X  CAL ONES      L ONES
       LDQ ZERO      L +0
       XCL 0
       TZE A12A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A12X
       REM
 A12A  LLS 35        BRING MQ TO ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A12A+5    ERROR
       TRA A12A+6    MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A12X
       REM
       REM
       BCD 1XCL
 A13X  CLA K10       L -300000000000
       ALS 2         CLEAR ALL BUT S,Q,P
       LDQ ONES      L ALL ONES TO MQ
       XCL 0         TEST FOR CLEARING S,Q
       ARS 1         CLEAR P
       STQ TEMP      SAVE MQ
       LDQ PONES     L + ALL ONES
       CAS PONES
       TRA *+2       ERROR
       TRA A13A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A13X
       REM
 A13A  CLA TEMP      CHECK SAVED MQ
       TMI A13A1     MQ SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A13X
       REM
 A13A1 TZE A13A1+2   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A13X
       REM
       REM
       BCD 1ERA      TEST-EXCLUSIVE OR TO ACC
 A14X  CAL ONES      L ALL ONES
       SLW TEMP      SAVE ACC
       ERA TEMP      CHECK FOR CLEARING ACC
       TZE A14A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A14X      REPEAT SECTION
       REM
 A14A  CLA TEMP      CHECK STG UNCHANGED
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A14A+5    ERROR
       TRA A14A+6    OK-STORAGE UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A14X
       REM
       REM
       BCD 1ERA
 A15X  CAL ONES      L ALL ONES
       ERA ZERO      NO CHANGE TO ACC
       SLW TEMP      SAVE ACC
       CLA TEMP      CHECK ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A15X
       REM
       REM
       BCD 1ERA
       REM
 A16X  CLA ZERO      L +0
       ERA ONES      FILL P,1-35 WITH BITS
       SLW TEMP      SAVE ACC
       CLA TEMP      CHECK ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A16X
       REM
       REM
       BCD 1ERA
 A17   CLA K10       L -300000000000
       ALS 3         SET UP Q BIT
       ERA ZERO      CHECK S,Q CLEARED
       TPL A17A      ACC SIGN CLEARED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A17
       REM
 A17A  TZE A17A+2    ACC OK-Q CLEARED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A17       REPEAT TEST
       REM
       REM
       BCD 1LGR      TEST-LOGICAL RT SHIFT
 A20   CLA ONE       L +1
       LDQ ZERO      L +0 TO MQ
       LGR 1
       TZE A20A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A20       REPEAT SECTION
       REM
 A20A  LLS 35        BRING MQ TO ACC
       TMI A20A1     MQ SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A20       REPEAT SECTION
       REM
 A20A1 TZE A20A1+2   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A20       REPEAT TEST
       REM
       REM
       BCD 1LGR
 A21X  LDQ MZE       L -0 TO MQ
       CLM
       LGR 35        CHANGE MQ TO +1
       LLS 35        BRING MQ TO ACC
       LDQ ONE       L +1 TO MQ
       CAS ONE
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A21X
       REM
       REM
       BCD 1LGR
 A22X  CLA ONES      L ALL ONES
       ALS 3         LOAD P, Q
       LGR 36        NOW -3777777777770 IN MQ
       CHS           ACC NOW +1
       STQ TEMP      SAVE MQ
       LDQ ONE       L +1 TO MQ
       CAS ONE
       TRA *+2       ERROR
       TRA A22A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A22X
       REM
 A22A  CLA TEMP      L SAVED MQ
       LDQ K6        L -37777777770 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K6
       TRA A22A+5    ERROR
       TRA A22A+6    MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A22X
       REM
       REM
       BCD 1ZET      TEST-STORAGE ZERO TEST
 A23X  CLA ONES      L ALL ONES
       ZET ZERO      STG 1-35 ZERO
       TRA *+2       ERROR
       TRA A23A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A23X
       REM
 A23A  LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A23A+4    ERROR
       TRA A23A+5    OK-ACC UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A23X
       REM
       REM
       BCD 1ZET
 A24X  ZET MZE       STG 1-35 ZERO
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A24X
       REM
       REM
       BCD 1ZET
 A24A  CLA ONE       L +1
       STO TEMP      SAVE ACC
       ZET TEMP      STG 1-35 NOT ZERO
       TRA A24A1     OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A24A      REPEAT SECTION
       REM
 A24A1 CLA TEMP      CHECK STG UNCHANGED
       LDQ ONE       L + 1
       CAS ONE
       TRA A24A1+5   ERROR
       TRA A24A1+6   OK-STORAGE UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A24A      REPEAT TEST
       REM
       REM
       BCD 1ZET      TEST-STORAGE TEST
       REM           POSITIONS S, 1-35
 24A   CLM           CLEAR ACC
       CLA ONE       L +1
       STO TEMP      SAVE ACC
       ZET TEMP      STG 1-35 NOT ZERO
       TRA 24B       OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA 24A       REPEAT SECTION
       REM
 24B   ALS 1         MOVE BIT
       PBT           P BIT YET
       TRA 24A+2     NO
       SLW TEMP      STG 1-35 ZERO
       ZET TEMP      TEST SIGN POSITITION
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA 24A       REPEAT TEST
       REM
       REM
       BCD 1ZET
 24C   CLM
       SLW TEMP      STG 1-35 ZERO
       ZET TEMP
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA 24C       REPEAT TEST
       REM
       REM
       BCD 1NZT      TEST-STORAGE NOT ZERO TEST
 A25X  CLA ONE       L +1
       STO TEMP      SAVE ACC
       NZT TEMP      STG 1-35 NOT ZERO
       TRA *+2       ERROR
       TRA A25A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A25X
       REM
 A25A  LDQ ONE       L +1 TO MQ
       CAS ONE
       TRA A25A+4    ERROR
       TRA A25A1     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A25X
       REM
 A25A1 CLA TEMP      L +1
       CAS ONE
       TRA A25A1+4   ERROR
       TRA A25A1+5   OK-STORAGE UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A25X
       REM
       REM
       BCD 1NZT
 A26X  NZT ZERO      STG 1-35 ZERO
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A26X
       REM
       REM
       BCD 1NZT      TEST STORAGE NOT ZERO
       REM           POSITIONS S, 1 TO 35
 26A   CLM           CLEAR ACC
       CLA ONE       L +1
       STO TEMP      SAVE ACC
       NZT TEMP      STG 1-35 NOT ZERO
       TRA *+2       ERROR
       TRA 26B       OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA 26A       REPEAT SECTION
       REM
 26B   ALS 1         MOVE BIT
       PBT           P BIT YET
       TRA 26A+2     NO
       SLW TEMP      SAVE ACC
       NZT TEMP      STG 1-35 ZERO
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA 26A       REPEAT TEST
       REM
       BCD 1NZT
 26C   CLM
       SLW TEMP      SAVE ACC
       NZT TEMP      STG 1-35 ZERO
       TRA 26C+5     OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA 26C       REPEAT TEST
       REM
       REM
       BCD 1LAS      TEST-LOGICAL COMPARE
       REM           ACC WITH STORAGE
 A27X  CLA ONES      L ALL ONES
       STO TEMP      SAVE ACC
       CAL MZE       L BIT IN P
       ALS 1         SHIFT TO Q
       LAS TEMP      TEST ACC GREATER THEN STG
       TRA *+4       OK
       TRA *+1       ERROR
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A27X
       REM
 A27A  LDQ ZERO      L +0 TO MQ
       ARS 2         SHIFT TO POS 1
       ADD MTW       L -2000000000
       TZE A27A1     OK ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A27X
       REM
 A27A1 CLA TEMP      CHECK STG UNCHANGED
       LDQ ONES      L ONES TO MQ
       CAS ONES
       TRA A27A1+5   ERROR
       TRA A27A1+6   OK STORAGE UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A27X
       REM
       REM
       BCD 1LAS
 A28X  CLA K3        L -377777077777
       LAS K2        L +700000-TEST STORAGE LESS
       REM           THAN ACCUMULATOR
       TRA *+3       OK
       TRA *+1       ERROR
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A28X
       REM
       REM
       BCD 1LAS
 A29X  CLA MTW       L -2000000000
       ALS 1         SHIFT TO POS P
       LAS MTW       TEST STG GREATER THAN ACC
       TRA *+1       ERROR
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A29X
       REM
       REM
       BCD 1LAS
 A30X  CAL MZE       L P BIT
       LAS MZE       TEST STG AND ACC EQUAL
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A30X
       REM
       REM
       BCD 1VLM      TEST-VAR LENGTH MULTIPLY
 A31X  LDQ ONES      L ALL ONES TO MQ
       VLM ONE,0,35  SET 43 IN SHIFT COUNTER
       TMI A31A      ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A31X
       REM
 A31A  TZE A31A1     ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A31X
       REM
 A31A1 LLS 35        BRING MQ TO ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A31A1+5   ERROR
       TRA A31A1+6   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A31X
       REM
       REM
       BCD 1VLM
 A32X  LDQ ONES      L ALL ONES TO MQ
       VLM K2,0,1    SET 1 IN SHIFT COUNTER
       ALS 1
       CHS           ACC NOW +000000700000
       LDQ K2        L +700000 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K2
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A32X
       REM
       REM
       BCD 1VLM
 A33X  LDQ ONES      L ALL ONES TO MQ
       CLA ONES      L ALL ONES
       VLM K2,0,15   SET 17 IN SHIFT COUNTER
       CHS           ACC NOW +000000677771
       STQ TEMP      SAVE MQ
       LDQ K11       L +677771 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K11
       TRA *+2       ERROR
       TRA A33A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A33X
       REM
 A33A  CLA TEMP      CHECK SAVED ACC
       CHS           ACC NOW +0000037777777
       LDQ K12       L +37777777 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K12
       TRA A33A+6    ERROR
       TRA A33A+7    MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A33X
       REM
       REM
       BCD 1VLM      TEST-VLM WITH INDEXING
 A34X  LXA K37A,1    L 43 IN XRA
       LDQ K6        L -377777777770
       VLM K3+35,1,4 SET 4 IN SHIFT COUNTER
       LLS 1
       CHS           ACC NOW -377777077777
       STQ TEMP      SAVE MQ
       LDQ K3        L -377777077777 ACC, MQ
       REM           SHOULD BE THE SAME
       CAS K3
       TRA *+2       ERROR
       TRA A34AA     ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34X
       REM
 A34AA CLA TEMP      CHECK SAVED MQ
       LDQ K13       L +037777777776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K13
       TRA A34AA+5   ERROR
       TRA A34AA+6   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34X
       REM
       REM
       BCD 1VLM      TEST-VARIABLE LENGTH MULTIPLY
       REM           ZERO WORD COUNT
 A34A  CLA K24
       LDQ K24       L+1111111111
       VLM ONES,0,0  SHIFT COUNTER ZERO
       STQ TEMP      SAVE MQ
       LDQ K24       L+1111111111
       CAS K24       CHECK ACC UNCHANGED
       TRA A34A+8    ERROR
       TRA A34B      OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34A      REPEAT SECTION
       REM
 A34B  CLA TEMP      CHECK SAVED MQ
       CAS K24       CHECK MQ UNCHANGED
       TRA A34B+4    ERROR
       TRA A34B+5    OK MQ UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34A      REPEAT TEST
       REM
       REM
       BCD 1VLM      TEST VARIABLE LENGTH
       REM           MULTIPLY
       REM           ZERO MULTIPLICAND, ZERO
       REM           COUNT
       REM           COUNT TAKES PRECEDENT
 A34C  CLA ONES      L ALL ONES
       LDQ ONES      L ALL ONES TO MQ
       VLM ZERO,0,0  SHIFT COUNTER ZERO
       STQ TEMP      SAVE MQ
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A34C+8    ERROR
       TRA A34D      OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34C      REPEAT SECTION
       REM
 A34D  CLA TEMP      CHECK SAVE MQ
       CAS ONES
       TRA A34D+4    ERROR
       TRA A34D+5    OK MQ UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34C      REPEAT TEST
       REM
       REM
       BCD 1VLM      TEST-VARIABLE LENGHT MULTIPLY
       REM           WITH ZERO MULTIPLCAND
 A34E  CLA ONES      L ALL ONES
       LDQ ONES      L ALL ONES TO MQ
       VLM ZERO,0,5
       TMI A34E1     ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34E      REPEAT SECTION
       REM
 A34E1 TZE A34F      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34E      REPEAT SECTION
       REM
 A34F  STQ TEMP      SAVE MQ
       CLA TEMP      CHECK SAVED MQ
       TMI A34F1     MQ SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34E      REPEAT SECTION
       REM
 A34F1 TZE A34F1+2   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34E      REPEAT TEST
       REM
       REM
       BCD 1VLM      TEST-VARIABLE LENGHT
       REM           MULTIPLY-ZERO MULTIPLICAND
 A34G  CLA ONES      L ONES
       LDQ ONES      L ONES TO MQ
       VLM MZE,0,5
       TPL A34G1     ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34G      REPEAT SECTION
       REM
 A34G1 TZE A34H      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34G      REPEAT SECTION
       REM
 A34H  STQ TEMP      SAVE MQ
       CLA TEMP      CHECK SAVED MQ
       TPL A34H1     MQ SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34G      REPEAT SECTION
       REM
 A34H1 TZE A34H1+2   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34G      REPEAT TEST
       REM
       REM
       BCD 1VDP      TEST-VAR LENGTH
       REM           DIVIDE OR PROCEED
 A35X  LDQ ONES      L ALL ONES TO MQ
       CLA MZE       L -0
       VDP ONE,0,35  SET 43 IN SHIFT COUNTER
       TMI A35A
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A35X      REPEAT SECTION
       REM
 A35A  TZE A35A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A35X
       REM
 A35A1 LLS 35        CHECK QUOTIENT
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A35A1+5   ERROR
       TRA A35A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4
       TRA A35X
       REM
       REM
       BCD 1VDP      CHECK MQ SIGN CHANGE
 A36X  LDQ K8        L +177777777777 IN MQ
       CLA K14       L -340000
       VDP K2,0,1    SET 1 IN SHIFT COUNTER
       TMI A36A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A36X
       REM
 A36A  TZE A36A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A36X
       REM
 A36A1 LLS 35        CHECK QUOTIENT
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A36A1+5   ERROR
       TRA A36A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A36X
       REM
       REM
       BCD 1VDP
 A37X  LDQ K12       L +37777777 IN MQ
       CLA K11       L+677771
       VDP K2,0,15   SET 17 IN SHIFT COUNTER
       TPL A37A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A37X
       REM
 A37A  TZE A37A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A37X
       REM
 A37A1 LLS 35        CHECK QUOTIENT
       CHS           ACC NO -37777777777
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A37A1+6   ERROR
       TRA A37A1+7   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A37X
       REM
       REM
       BCD 1VDP      TEST-VDP WITH INDEXING
 A40X  LXA K37A,1    L 43 IN XRA
       CLS K3        L -377777077777
       LDQ K13       L +377777777776
       LRS 1
       VDP K3+35,1,4 SET 4 IN SHIFT COUNTER
       TPL A40A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A40X
       REM
 A40A  TZE A40A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A40X
       REM
 A40A1 LLS 35        CHECK QUOTIENT
       LDQ K6        L -377777777770 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K6
       TRA A40A1+5   ERROR
       TRA A40A1+6   QOUTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A40X
       REM
       REM
       BCD 1VDP
 A41X  DCT           TURN OFF DIV-CHECK LIGHT
       NOP
       LDQ K36       L +377777777776
       CLA K2        L +700000
       VDP K2,0,18   L +700000
       DCT           CHECK SETTING TRG
       TRA A41AA     OK DIV-CHECK LITE WAS ON
       REM           DIVISION NOT POSSIBLE
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A41X
       REM
 A41AA STQ TEMP      SAVE MQ
       LDQ K2        L +700000 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K2        CHECK ACC UNCHANGED
       TRA A41AA+5   ERROR
       TRA A41AB     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A41X
       REM
 A41AB CLA TEMP      CHECK SAVED MQ
       LDQ K36       L +377777777776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K36       CHECK MQ UNCHANGED
       TRA A41AB+5   ERROR
       TRA A41AB+6   OK-MQ UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A41X
       REM
       REM
       BCD 1VDP      TEST-VARIABLE DIVIDE OR
       REM           PROCEED WITH ZERO WORD
       REM           COUNT
 A41A  CLA K11       L +677771
       DCT           TURN OFF DIV-CHECK LITE
       NOP
       LDQ K11       L+677771
       VDP K2,0,0
       STQ TEMP      SAVE MQ
       LDQ K11       L +677771
       CAS K11       CHECK ACC UNCHANGED
       TRA A41A+10   ERROR
       TRA A41B      OK-ACC UNCHANGED
       TSX ERROR-1,4
       TRA A41A      REPEAT SECTION
       REM
 A41B  CLA TEMP      CHECK SAVED MQ
       CAS K11       CHECK MQ UNCHANGED
       TRA A41B+4    ERROR
       TRA A41C      OK-MQ UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A41A      REPEAT SECTCION
       REM
 A41C  DCT
       TRA A41C+3    NG DIV-CHECK LITE WAS ON
       TRA A41C+4    OK-DIV-CHECK LITE OFF
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A41A      REPEAT TEST
       REM
       REM
       BCD 1VDH      TEST-VAR LENGTH
       REM           DIVIDE OR HALT
 A42X  LDQ ONES      L ALL ONES TO MQ
       CLA MZE       L -0
       VDH ONE,0,35  SET 43 IN SHIFT COUNTER
       TMI A42A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A42X
       REM
 A42A  TZE A42A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A42X
       REM
 A42A1 LLS 35        CHECK QUOTIENT
       LDQ ONES
       CAS ONES
       TRA A42A1+5   ERROR
       TRA A42A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A42X
       REM
       REM
       BCD 1VDH
 A43X  LDQ K8        L +177777777777 TO MQ
       CLA K14       L -370000
       VDH K2,0,1    SET 1 IN SHIFT COUNTER
       TMI A43A
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A43X
       REM
 A43A  TZE A43A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A43X
       REM
 A43A1 LLS 35        CHECK QUOTIENT
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A43A1+5   ERROR
       TRA A43A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A43X
       REM
       BCD 1VDH
 A44X  LDQ K12       L +37777777
       CLA K11       L +677771
       VDH K2,0,15   SET 17 IN SHIFT COUNTER
       TPL A44A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A44X
       REM
 A44A  TZE A44A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A44X
       REM
 A44A1 LLS 35        CHECK QUOTIENT
       CHS           ACC NOW -377777777777
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA A44A1+6   ERROR
       TRA A44A1+7   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A44X
       REM
       REM
       BCD 1VDH      TEST-VDH WITH INDEXING
 A45X  LXA K37A,1    L +43 IN XRA
       CLS K3        L -3777770777777
       LDQ K13       L +9037777777776
       LRS 1
       VDH K3+35,1,4 SET 4 IN SHIFT COUNTER
       TPL A45A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A45X
       REM
 A45A  TZE A45A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A45X
       REM
 A45A1 LLS 35        CHECK QUOTIENT
       LDQ K6        L -377777777770 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K6
       TRA A45A1+5   ERROR
       TRA A45A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4
       TRA A45X
       REM
       REM
       REM
       BCD 1CVR      TEST-CONVERT BY REPLACEMENT
       REM           FROM ACC
 A47X  LXA ZERO,1    CLEAR XRA
       CLA K2        L +700000
       CVR K15,1     CHECK NO COUNT-NO ACTION
       LDQ K2        L +70000 MQ, ACC SHOULD
       REM             BE THE SAME
       CAS K2
       TRA *+2       ERROR
       TRA A47A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A47X
       REM
 A47A  CLA K15+K15,1 CHECK ADR PUT IN XRA
       LDQ K15       L +374000003400 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K15
       TRA A47A+5    ERROR
       TRA A47A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4
       TRA A47X
       REM
       REM
       BCD 1CVR
 A50X  LXA ZERO,1    CLEAR XRA
       CAL K2        L +700000
       CVR ONES,0,1  CHECK ONE 6 BIT CONVERSION
       REM           NO ADDITION TO ADDRESS
       SLW TEMP      SAVE ACC BEFORE SHIFT
       ARS 1         ACC NOW +374000003400
       PBT
       TRA A50A      OK Q WAS ZERO
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A50X
       REM
 A50A  CLA TEMP,1    L SAVED ACC
       LDQ K15+1     L -370000007000 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K15+1
       TRA A50A+5    ERROR
       TRA A50A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A50X
       REM
       REM
       BCD 1CVR
 A51X  LXA ZERO,1    CLEAR XRA
       CAL ONE       L +1
       CVR ZERO,0,1  CHECK ONE 6 BIT CONVERSION
       REM           ADDITION TO ADDRESS
       SLW TEMP      SAVE ACC
       ARS 1         ACC NOW +374000000000
       PBT
       TRA A51A      OK Q W S Z R0
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A51X
       REM
 A51A  CLA TEMP,1    L SAVED ACC
       LDQ SW1       L -370000000000 IN MQ
       CAS SW1
       TRA A51A+5    ERROR
       TRA A51A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A51X
       REM
       REM
       BCD 1CVR
 A52X  CAL K16       L +010203040506
       CVR K16,1,6   FULL WORD CONVERSION
       LDQ K16B+K16,1 L +212223242526
       CAS K16B
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4
       TRA A52X
       REM
       REM
       BCD 1CVR
 A53X  CAL K17+1     L -374777770304
       ALS 1         PUT BIT IN Q
       REM           MAKE ACC +11371777760610
       CVR K17-8,0,2
       LDQ K32       L -374777177776
       REM           SHOULD BE THE SAME
       LAS K32
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A53X
       REM
       REM
       BCD 1CAQ      TEST-CONVERT BY ADDITION
       REM           FROM THE MQ
 A54X  LDQ K16       L +010203040506
       CLA MZE       L -0
       CAQ K16       NO COUNT-NO ACTION
       TMI A54A      ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A54X
       REM
 A54A  TZE A54A1     ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A54X
       REM
 A54A1 LLS 35        MQ TO ACC AND CHECK
       LDQ K16       L +010203040506 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16
       TRA A54A1+5   ERROR
       TRA A54A1+6   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A54X
       REM
       REM
       BCD 1CAQ
 A55X  LXA ZERO,1    CLEAR XRA
       LDQ K16       L +010203040506
       CLA ZERO      L + 0
       CAQ K16-1,0,1 PERFORM 1 ADDITION
       STQ TEMP      SAVE MQ
       LDQ K16       L +010203040506 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16
       TRA *+2       ERROR
       TRA A55A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A55X
       REM
 A55A  CLA TEMP,1    CHECK SAVED MQ
       LDQ K16-1     L+020304050601
       CAS K16-1
       TRA A55A+5    ERROR
       TRA A55A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A55X
       REM
       REM
       BCD 1CAQ
 A56X  TOV *+1       TURN OFF ACC OVFLO LIGHT
       LDQ K16       L +010203040506
       CLA ZERO      L +0
       CAQ K16,1,6   FULL WORD CONVERSION
       SLW TEMP      SAVE ACC
       ARS 1         MOVE Q BIT TO P
       PBT
       TRA *+2       ERROR
       TRA A56A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A56X
       REM
 A56A  STQ TEMP+1    SAVE MQ
       CLA TEMP+K16,1 CHECK SAVED MQ
       LDQ K16+7     MQ, ACC SHOULD BE SAME
       CAS K16+7
       TRA A56A+6    ERROR
       TRA A56A1     OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A56X
       REM
 A56A1 CLA TEMP+1    CHECK SAVED MQ
       LDQ K16       L +010203040506 MQ, ACC
       CAS K16
       TRA A56A1+5   ERROR
       TRA A56A1+6   OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A56X
       REM
       REM
       BCD 1CAQ
 A57X  CLA K14       L -340000
       LDQ K16       L +010203040506
       CAQ K17-1,0,2 TEST SWITCHING TABLES
       SLW TEMP      SAVE ACC
       ARS 1
       PBT
       TRA A57A      OK Q WAS ZERO
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A57X
       REM
 A57A  CLA TEMP      CHECK SAVED ACC
       LDQ K16+8     MQ, ACC SHOULD BE SAME
       CAS K16+8
       TRA A57A+5    ERROR
       TRA A57A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A57X
       REM
       REM
       BCD 1CAQ      TEST CAQ FRO CORRECT INDEX
 A60X  LXA 8CF,1     L 77777 IN XRA
       CLA ZERO      L +0
       LDQ K16       L +010203040506
       CAQ K16,6,1   PERFORM ONE ADD
       LDQ K16+1     MQ, ACC SHOULD BE SAME
       CAS K16+1
       TRA *+2       ERROR
       TRA A60A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A60X
       REM
 A60A  CLA K13-1,1   CHECK XRA UNCHANGED
       LDQ K13       L +037777777776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K13
       TRA A60A+5    ERROR
       TRA A60A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A60X
       REM
       REM
       BCD 1CAQ
 A61X  CLA ZERO      L +0
       LDQ K16+1     L +2100000 ADDRESS K16
       CAQ K15-17,1,1 PREFORM 1 ADD, SAVE ADR
       LDQ K15       L +374000003400 MQ, ACC
       REM           SHOULD BE SAME
       CAS K15
       TRA *+2       ERROR
       TRA A61AX
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A61X
       REM
 A61AX CLA K20+1792,1 CHECK XRA SET TO 3400
       LDQ K20       L +265577177776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K20
       TRA *+2       ERROR
       TRA *+2
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4
       TRA A61X
       REM
       BCD 1CRQ      TEST-CONVERT BY REPLACMENT
       REM           FROM THE MQ
 A62X  LXA 8CF,1     L 77777 IN XRA
       CLA ONES      L ALL ONES
       LDQ K16       L+010203040506
       CRQ K16       CHECK NO ACTION
       REM           WITH NO COUNT
       STQ TEMP      SAVE MQ
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA *+2       ERROR
       TRA A62AX     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A62X
       REM
 A62AX CLA TEMP      CHECK SAVED MQ
       LDQ K16       L +010203040506 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16       CHECK SAVED MQ UNCHANGED
       TRA *+2       ERROR
       TRA A62B      OK-MQ UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A62X
       REM
 A62B  CLA K17-1,1   CHECK XRA UNCHANGED
       LDQ K17       MQ, ACC SHOULD BE SAME
       CAS K17
       TRA A62B+5    ERROR
       TRA A62B+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A62X
       REM
       REM
       BCD 1CRQ
 A63X  CLA ZERO      L +0
       LDQ K16       L +010203040506
       CRQ K16,1,1   CHECK 6 BIT CONVERSION
       REM           ALSO CHECK SAVING ADR
       TZE A63AX     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A63X
       REM
 A63AX LLS 35        MQ TO ACC
       LDQ K16A      L +020304050621 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16A
       TRA *+2       ERROR
       TRA A63BX     OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A63X
       REM
 A63BX CLA K15+K16,1 CHECK ADR SET IN XRA
       LDQ K15       L +374000003400 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K15
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A63X
       REM
       REM
       BCD 1CRQ
 A64X  LXA ZERO,1    CLEAR XRA
       LDQ K16       L +010203040506
       CRQ K16,0,6   CHECK FULL WORD
       REM           CONVERSION
       CLM           CLEAR ACC
       LLS 35        BRING MQ TO ACC
       LDQ K16B,1    L +212223242526 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16B,1
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A64X
       REM
       REM
       BCD 1CRQ
 A64Y  LXA ZERO,1    CLEAR XRA
       LDQ SW1       L -370000000000
       CRQ K15-60,0,1
       CLM           CLEAR ACCUMULATOR
       LLS 35        MQ TO ACCUMULATOR
       SUB ONE       L +1
       TZE *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4
       TRA A64Y
       REM
       REM
       BCD 1STL      TEST-STORE INST CTR
 A65X  CLA ONES      L ALL ONES
       STO TEMP      SAVE ACC
       STL TEMP
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA *+2       ERROR
       TRA A65A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A65X
       REM
 A65A  CLA TEMP      CHECK TEMP
       LDQ K23       L TXL A65X+3,7,32767
       CAS K23
       TRA A65A+5    ERROR
       TRA A65A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A65X
       REM
       BCD 1STR-     TEST-STORE LOC AND TRAP
       REM
 65A   CLA ONES      L ALL ONES
       STO 0
       REM
       CLA K37B      L TRA 65A1
       STO 1
       REM
       CLA K37C      L TRA 65A2
       STO 2
       REM
       CLA K37D      L TRA 65A3
       STO 3
       REM
       CLA K37E      L TRA 65A4
       STO 10
       REM
       CLA K37E1     L TRA 65A4A
       STO 11
       REM
       CLA K37E2     L TRA 65A4B
       STO 12
       REM
       CLA K37E3     L TRA 65A4C
       STO 13
       REM
       LXA 1CF,7     L 777 IN XRA,XRB,XRC
       REM
       STR  32767,7,32767
       TXL  65A4D,7,32767    LOC OF THIS INSTRUCTION
       REM                   TO ADDRESS OF LOC 00000
       REM
       REM CHECK STR INSTR EXECUTED CORRECTLY
       REM
 65A1  TSX ERROR-1,4 ERROR-TRA FROM LOC 00001
       TRA 65A
       REM
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM
 65A2  TRA 65A5
       REM
 65A3  TSX ERROR-1,4 ERROR-TRA FROM LOC 00002
       TRA 65A
       REM
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM
       TRA 65A5
       REM
 65A4  TSX ERROR-1,4 ERROR-TRA FROM LOC 00010
       TRA 65A
       REM
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM
       TRA 65A5
       REM
 65A4A TSX ERROR-1,4 ERROR-TRA FROM LOC 00011
       TRA 65A
       REM
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM
       TRA 65A5
       REM
 65A4B TSX ERROR-1,4 ERROR-TRA FROM LOC 00012
       TRA 65A
       REM
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM
       TRA 65A5
       REM
 65A4C TSX ERROR-1,4 ERROR-TRA FROM LOC 00013
       TRA 65A
       REM
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM
       TRA 65A5
       REM
 65A4D TSX ERROR-1,4 ERROR-STR DID NOT TRAP BUT
       TRA 65A       EXECUTED TXL INSTRUCTION
       REM
       REM CHECK CONTENTS OF LOCATION 00000
       REM
 65A5  CLA 0         L LOCATION 00000
       LDQ K37G      L TXL 65A+18,7,32767
       CAS K37G
       TRA 65A5+5    ERROR
       TRA 65A6      OK
       TSX ERROR-1,4 ERROR-WRONG QTY LOC 00000
       TRA 65A       REPEAT SECTION
       REM
       REM CHECK STR INSTRUCTION UNCHANGED
       REM
 65A6  CLA 65A+17    L STR INSTRUCTION
       CHS           ACC NOW +17777777777
       LDQ K8        L +177777777777
       CAS K8
       TRA 65A6+6    ERROR
       TRA 65A7      OK
       TSX ERROR-1,4 ERROR-STR INSTR CHANGED
       TRA 65A       REPEAT SECTION
       REM
       REM CHECK STR+1 INSTRUCTION UNCHANGED
       REM
 65A7  CLA 65A+18    L STR + 1 INSTRUCTION
       LDQ K37E4     L TXL 65A4D,7,32767
       CAS K37E4
       TRA 65A7+5    ERROR
       TRA 65A8
       TSX ERROR-1,4 ERROR-STR+1 INSTR CHANGED
       TRA 65A
       REM
       REM TEST INDEX REGISTERS UNCHANGED BY STR
       REM
 65A8  PXA 0,1       XRA TO ACC
       LDQ 1CF       L 7777 IN MQ
       CAS 1CF
       TRA *+2       ERROR
       TRA *+3       OK-XRA UNCHANGED
       TSX ERROR-1,4 ERROR-XRA CHANGED
       TRA 65A
       REM
       PXA 0,2       XRB TO ACC
       LDQ 1CF       L 7777 IN MQ
       CAS 1CF
       TRA *+2       ERROR
       TRA *+3       OK-XRB UNCHANGED
       TSX ERROR-1,4 ERROR-XRB CHANGED
       TRA 65A
       REM
*ANY ERROR IN THE STR TEST PRIOR TO THE FOLLOWING ROUTINE OF
*CHECKING XRC,WILL ALTER THE CONTENTS OF XRC.ANY ERROR INDICATIONS FOR
*THE FOLLOWING ROUTINE SHOULD BE EXAMINED FOR THIS.
       REM
       PXA 0,4       XRC TO ACC
       LDQ 1CF       L 7777 IN MQ
       CAS 1CF
       TRA *+2       ERROR
       TRA *+2       OK-XRC UNCHANGED
       TSX ERROR,4   ERROR-XRC CHANGED
       TSX OK,4
       TRA 65A
       REM
       REM
       NOP
       CLA END+1     RESTORE
       STO 0         RESET-START
       TRA *+2
       REM
       REM
       BCD 1ADD      ADDER TEST
 M06   CLA ZERO      CLEAR ACCUMULATOR
       COM
       ADD ONE       L +1  RIPPLE CARRY
       TZE M06+6
       TSX ERROR-1,4 ON ERROR THE RIGHT MOST
       TRA M06       ONE OR LEFT MOST ZERO
       REM           IS ADDER THAT FAILED
       TOV M06+8     OVFL SHOULD BE ON
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4
       TRA M06
       REM
       REM
       BCD 1ADD      ADDER TEST
 M07   CAL ONES      ONES INTO P,1-35
       ACL ONES      ONES INTO P,1-35
       SLW TEMP
       CLA TEMP
       SUB ONES      ONES
       TZE M07+7
       TSX ERROR,4   THE RIGHTMOST ONE OR THE
       TSX OK,4      LEFT MOST ZERO WILL
       TRA M07       INDICATE WHICH ADDER
       REM           FAILED. SIGN POSITION
       REM           CORRESPONDS TO P ADDER
       REM           POSITION
       REM
       NOP
       REM
 AAA   SWT 5         TEST SENSE SWITCH 5
       TRA END       BYPASS ALL HALT
       REM           TESTS AND ADDER TESTS
       REM
       CLA PLUS+3    INSERT BYPASS HALTS
       STO AAA+2     ON THE NEXT PASS
       TRA B59
       REM
       REM HALT TESTS
       REM
       REM
       BCD 1DVH      DVH TEST
 B59   CLA ONE       BRING ONE IN ACC
       DVH ZERO      DIVIDE BY ZERO, SHOULD
       SUB ONE       HALT WITH DCT ON
       TZE B59+5     RESULT SHOULD BE ZERO
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4
       TRA B59
       REM
       REM
       BCD 1DVH      DVH TEST WITH HALT
 B60   CLA ONE       DIVIDE ACC BY EQUAL AND
       DVH ONE       STORE, SHOULD HALT
       SUB ONE       TEST ACC SHOULD BE ONE
       TZE B60+5     OK, PROCEED
       REM
       TSX ERROR,4
       TSX OK,4
       TRA B60
       REM
       REM
       BCD 1DVH      DVH TEST WITH HALT
 B61   CLA PTW       PLACE BIT IN Q POSITION
       ALS 2         SO ACC GREATER THEN STO
       DVH PTW       SHOULD HALT
       TNZ B61+5     OK, SHOULD NOT BE ZERO
       TSX ERROR,4
       TSX OK,4
       TRA B61
       REM
       REM
       BCD 1VDH
 A46X  DCT           TURN OFF DIV-CHECK LIGHT
       TRA *+1
       LDQ K36       L +377777777776
       CLA K2        L +700000
       VDH K2,0,18   L +700000
       DCT           CHECK SETTING TRG
       TRA A46A      OK-DIV-CHECK LITE WAS ON
       REM           DIVISION DID NOT TAKE PLACE
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A46X
       REM
 A46A  STQ TEMP      SAVE MQ
       LDQ K2        L +700000 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K2        CHECK ACC UNCHANGED
       TRA A46A+5    ERROR
       TRA A46A1     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A46X
       REM
 A46A1 CLA TEMP      CHECK SAVED MQ
       LDQ K36       L +37777777776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K36       CHECK MQ UNCHANGED
       TRA A46A1+5   ERROR
       TRA A46A1+6   OK-MQ UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A46X
       REM
       REM
       BCD 1ENK      TEST-ENTER KEYS
 KY    HTR *+1       STOP-PUT ONES IN KEYS
       ENK           ONES IN MQ FROM KEYS
       CLM           CLEAR ACC
       LLS 35        MOVE MQ TO ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4 ERROR
       TRA KY        REPEAT SECTION
       REM
       HTR KY1       STOP-PUT ZEROS IN KEYS
 KY1   ENK           ZEROS IN MQ FROM KEYS
       CLM           CLEAR ACC
       LLS 35        MOVE MQ TO ACC
       TZE *+2       OK
       TSX ERROR,4   ERROR
       TSX OK,4
       TRA KY
       REM
       REM           ADDER TEST
       REM
       REM
       BCD 1ADD
 ADD   LXA 1CF,2     L 7777
       CLA 4095,2    BRING IN LOC STORAGE
       COM
       ADD 4095,2    MAKE ALL ONES
       TOV ADD+5     TURN OFF OVFL
       TPL PLUS
       TMI MINUS
       TSX ERROR-1,4 SIGN ERROR
       TRA ADD
       REM
 MINUS SUB ONE       FORCE RIPPLE
       TZE OVFL
       TSX ERROR-1,4
       TRA ADD
 PLUS  ADD ONE       FORCE RIPPLE
       TZE OVFL
       TSX ERROR-1,4 FAILURE IN TZE INSTRUCTION
       TRA ADD
       REM
       REM
 OVFL  TNO SS        TEST OVFL SHOULD BE ON
       TOV SS1       SHOULD BE OFF NOW
       CLA 4095,2    BRING IN LOC
       CAS 4095,2    COMPARE TO STORAGE
       TRA TT        MEMORY LESS
       TRA LOOP      OK
       TRA TT1       MEMORY HIGH
       REM
 SS    TSX ERROR-1,4 OVFL SHOULD BE ON
       TRA ADD
       TRA OVFL+2
       REM
 SS1   TSX ERROR-1,4 TNO DID NOT TURN OFF OVFL
       TRA ADD
       TRA OVFL+2
 TT    TSX ERROR-1,4 MEMORY LESS
       TRA ADD
       TRA OVFL+2
       REM
 TT1   TSX ERROR-1,4 MEMORY HIGH
       TRA ADD
       TRA OVFL+2
       REM
 LOOP  TIX ADD+1,2,1
       TRA MPY
       REM
       REM
       REM           MPY TEST
       BCD 1MPY
 MPY   LXA 1CF,2     L 7777
       LXA MPY+3,1   L 35
       LDQ ONE
       RQL 35,1
       STQ TEMP      SAVE BIT
       MPY 4095,2    MPY BY LOC
       LRS 35,1
       TZE MPY+10
       TSX ERROR-1,4 HIGH ORDER PRODUCT ERROR
       TRA MPY
       REM
       STQ TEMP+1
       CLA TEMP+1
       SUB 4095,2    SUB LOC
       TZE MPY+16
       TSX ERROR-1,4 LOW ORDER PRODUCT ERROR
       TRA MPY
       REM
       TIX MPY+2,1,1
       TIX MPY+1,2,1
       TRA DVP
       REM
       REM
       REM
       REM           MPY AND DVP ALL ONES
       BCD 1DVP
 DVP   LXA 1CF,1     L 7777
       LDQ 4095,1    LDQ WITH LOC
       MPY ONE
       DVP ONE
       TZE DVP+7
       TSX ERROR-1,4 HIGH ORDER ERROR
       TRA DVP
       REM
       STQ TEMP
       CLA 4095,1    BRING IN LOC TO ACC
       SUB TEMP
       TZE DVP+13
       TSX ERROR-1,4 LOW ORDER ERROR
       TRA DVP
       REM
       TIX DVP+1,1,1 LOOP
       REM
 END   TSX PR100,4
       TRA START-2   START ADDRESS
       REM
       REM THIS ROUTINE IS USED TO PRINT
       REM UPON COMPLETION OF 100 PROGRAM
       REM PASSES.IT ALSO SERVES AS A SENSE
       REM SWITCH 6 TEST
       REM
 PR100 SWT 6         TEST SENSE SWITCH 6
       TRA CRSL
       REM
       SWT 3         TEST SENSE SWITCH 3
       TRA BAR       BEGIN CT FOR 100 PASSES
       TRA 1,4       RETURN TO START ADDRESS
       REM
 BAR   CLA TOP       COUNT OF 100 DECIMAL
       SUB HAT       L +1
       STO TOP       STORE IN COUNT
       TNZ 1,4       REPEAT TEST TILL ZERO
       CLA TOP+1     RESET
       STO TOP       COUNTER
       REM
       LXA ATTA,1    L 13 IN XRA
       WPRA
       SPRA 3        SPACE PRINTER
       RCHA CW+2
       LCHA CW+6
 BOY   LCHA CW+3
       LCHA CW+6
       CLA CW+3
       SUB CLUB      L +2
       STA CW+3
       TIX BOY,1,1
       CLA CW+4      RESTORE CONTROL WORD
       STO CW+3
       TRA 1,4       EXIT TO START ADDRESS
       REM
 TOP   OCT 144
       OCT 144
       OCT 0
 CLUB  OCT 2
 HAT   OCT 1
 ATTA  OCT 13
       REM
 CRSL  RCDA	     LOAD
       RCHA CW+5     THE
       LCHA 0        NEXT
       TRA 1         PROGRAM
       REM
 ID    LXA ATTA,1    L 13 IN XRA
       WPRA          SELECT PRINTER
       SPRA 3        SPACE PRINTER
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
 KK80  TTR B83+9     SEE SECTION
 KK81  HTR B84       B83 FOR USE
 KK82  HTR B83+5     OF THESE ,KK 80,81,82
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
       REM
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
       REM 
       TRA MOD
 ERROR STZ KONST    DO NOT REPEAT SECTION
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
 OK    SXD LOC+1,4  2'S COMPL OF PROGRAM
       REM          LOCATION LAST PREFORMED
       REM
       REM 
       REM
       PSE 113      IF SENSE SW 1 IS UP THEN
       TRA RELY     CHECK SS 4
       TRA 1,4      IF DOWN REPEAR SECTION
       REM          OF PROG
       REM 
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
       REM 
 MOD   STZ KONST+4  SET STORAGE TO ZEROS
       STZ KONST+1
       STZ KONST
       REM
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
       REM 
 KONST OCT 1
       OCT 50
       OCT 50       COUNT CONSTANT
       OCT 1
       OCT 1
       TRA OK-1     EXIT FROM PRINT PROG
       TRA OK2      EXIT FROM PRINT WHEN
       REM          ENTRY IS TO ERROR-1
       REM 
       REM 
       REM          PRINT ROUTINE
       REM
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
       REM 
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
       REM 
       TSX WPRA,1    PRINT CONTENTS OF INDS
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
       REM
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
       REM
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
