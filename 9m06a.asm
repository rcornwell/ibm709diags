                                                             9M06A
                                                             7-01-58
       REM
       FUL
       ORG  24
       REM
       REM
*  -***- DIAGNOSTIC TEST 9M06 -***-
       REM
       REM
*                   ********************************
*                   *                              *
*                   *  BASIC 709 MAIN FRAME TEST   *
*                   *    WITH NO INDEXING A MANUAL *
*                   *    LOAD MUST BE USED.        *
*                   *                              *
*                   ********************************
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       CLA END+2     POST
       STO 0         RESTART
       REM
       REM
       REM           TEST OVERFLOW IN ACC
A      TOV A+1       TURN OFF OVERFLOW  TRGR
       TOV A+3       NO GOOD, DID NOT TURN OFF
       TRA A+5       OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A7
       TRA A         REPEAT
       REM
       REM
       REM           TEST OVERFLOW ALS
A7     CLA PTW       PLACE BIT IN ACC  1
       ALS 1         SHOULD OVERFLOW.
       TOV A7+5      OK, SHOULD OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A8
       TRA A7        REPEAT
       REM
       REM
       REM           TEST OVERFLOW WITH NO
A8     CLA ZERO      CLEAR ACC
       TOV A8+3      SHOULD NOT OVFL
       TRA A8+5      OK, DID NOT OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A9
       TRA A8        REPEAT
       REM
       REM           TEST TNO WITH NO ACC
       REM             OVFL
A9     CLA ZERO      CLEAR  ACC
       TNO A9+4      TEST FOR NO OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A10
       TRA A9        REPEAT
       REM
       REM
       REM           TEST TNO WITH ACC OVFL
A10    CLA PTW       PLACE BIT IN ACC  1
       ALS 1         SHIFT TO FORCE OVERFLOW
       TNO A10+4     SHOULD NOT TRANSFER
       TRA A10+6     OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A11
       TRA A10       REPEAT
       REM
       REM
       REM           TEST WHETHER TNO TURNS
A11    TOV  A11+2       IT OFF
       TRA A11+4     OK, DID TURN IT OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A12
       TRA A11       REPEAT
       REM
       REM
       REM           TEST TZE INSTRUCTION
       REM             WITH ARS
A12    CLA ZERO      CLEAR  ACCUMULATOR
       TZE A12+4     TEST FOR ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A13
       TRA A12       REPEAT
       REM
       REM
       REM           TEST TZE, WITH CLA
A13    CLA ZERO      BRING IN  ZERO
       TZE A13+4     TEST FOR ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A14
       TRA A13       REPEAT
       REM
       REM
       REM           TEST TZE, WITH CLA
A14    CLA A14       BRING IN NO  ZERO
       TZE A14+3     SHOULD NOT TRANSFER
       TRA A14+5     OK, DID NOT TRANSFER
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A15
       TRA A14       REPEAT
       REM
       REM
       REM           TEST TNZ, ACC NOT ZERO
A15    CLA A15       BRING IN NON  ZERO
       TNZ A15+4     SHOULD TRANSFER
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A16
       TRA A15       REPEAT
       REM
       REM
A16    CLA ZERO      CLEAR  ACC
       REM           TEST TNZ, ACC IS ZERO
       TNZ A16+3     SHOULD NOT TRANSFER
       TRA A16+5
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A21
       TRA A16
       REM
       REM
       REM           TEST ALS
A21    CLA ZERO      TEST ALS BY MOVING  ZERO
       ALS 8           EIGHT LEFT
       TZE A21+5     OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A22
       TRA A21
       REM
       REM
       REM           TEST ALS, MOVE A ONE
A22    CLA ONE       PLACE ONE IN ACC  35
       TNZ A22+4     OK, ONE IS IN ACC
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TOV A22+5     TURN OFF OVFL
       ALS 1
       TNZ A22+9     OK, BIT IS STILL THERE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       TOV A22+11    MOVE ON WHEN BIT GETS TO P
       TRA A22+5     LOOP ACROSS ACC
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A23
       TRA A22
       REM
       REM
       REM           ALS TEST, TEST IN Q POS
A23    CLA PTW       PLACE BIT IN  1
       ALS 2         MOVE IT TO Q
       TNZ A23+5
       PSE 114       LOST BIT IN Q
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 1         MOVE BIT OUT OF ACC
       TZE A23+9     SHOULD BE ZERO NOW
       PSE 114       DID NOT MOVE BIT OUT OF Q
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A24
       TRA A23
       REM
       REM
       REM           ARS TEST
A24    CLA ONE       PUT BIT IN 35 OF  ACC
       TOV A24+2     TURN OFF OVFL
       TNZ A24+5     OK, BIT IS IN ACC
       PSE 114       LOST BIT IN STARTING
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 34
       TNZ A25       OK, BIT IS IN POS 1
       PSE 114       TEST SWITCH ONE TO LOOP
       HPR           ERROR STOP WITH TWO UP
       REM
       REM
       REM           ARS TEST
A25    TNO A25+3     OVFL SHOULD BE  OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 1
       ARS 1
       TNZ A26       OK, BIT STILL THERE
       PSE 114       LOST BIT FROM P TO 1
       HPR             OR 1 TO P
       REM
       REM
       REM           ARS TEST, TEST POS Q
A26    ARS 1          INDICATIONS
       TOV A26+2     TURN OFF OVFL
       ALS 1
       TNO A26+6     OVFL SHOULD BE OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       ALS 2         GO OVER TO Q
       TNZ A26+10    OK, BIT STILL THERE
       PSE 114       LOST BIT
       HPR           ERROR STOP WITH TWO UP
       TOV A26+13    OVFL SHOULD BE ON
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A27
       TRA A24
       REM
       REM
       REM           TEST LBT
A27    CLA ONE       PLACE ONE IN ACC  25
       LBT
       TRA A27+4     DID NOT SENSE ONE BIT
       TRA A27+6
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A28
       TRA A27
       REM
       REM
       REM           TEST LBT
A28    CLA ZERO      PLACE ZERO IN ACC  35
       LBT
       TRA A28+5     OK, DID NOT SENSE ONE
       PSE 114       ERROR SHOULD NOT SKIP
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A29
       TRA A28
       REM
       REM
       REM
       REM           PBT TEST
A29    CLA ZERO      PLACE ZERO IN  ACC
       ALS 18        MOVE ZERO INTO P
       PBT
       TRA A29+6     OK, SENSED ZERO
       PSE 114       DID NOT SENSE ONE BIT
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A30
       TRA A29
       REM
       REM
       REM           PBT TEST
A30    CLA ONE       PLACE ONE ZERO IN ACC  35
       ALS 35        SHIFT ONE TO P POSITION
       PBT
       TRA A30+5     DID NOT SKIP WITH ONE IN P
       TRA A30+7
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A31
       TRA A30
       REM
       REM
       REM           TPL TEST
A31    CLA PTW       BRING IN PLUS  NUMBER
       TPL A31+4     TRANSFER IF OK
       PSE 114       ERROR DID NOT TRANSFER
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A32
       TRA A31
       REM
       REM
       REM           TPL TEST
A32    CLA MTW       BRING IN MINUS  NUMBER
       TPL A32+3     SHOULD NOT TRANSFER
       TRA A32+5
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A33
       TRA A32
       REM
       REM
       REM           TMI TEST
A33    CLA MTW       BRING IN MINUS  NUMBER
       TMI A33+4     OK, SHOULD TRANSFER
       PSE 114       ERROR, DID NOT TRANSFER
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A34
       TRA A33
       REM
       REM
       REM           TMI TEST
A34    CLA PTW       BRING IN PLUS  NUMBER
       TMI A34+3     SHOULD NOT TRANSFER
       TRA A34+5     OK, DID NOT TRANSFER
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A35
       TRA A34
       REM
       REM
       REM           CLM TEST, TWO PARTS
A35    CLA ONES      BRING IN  -377777777777
       CLM
       TZE A35+5     OK, NOW SEE IF SIGN IS SAME
       PSE 114       DID NOT CLEAR POS 1-35
       HPR           ERROR STOP WITH TWO UP
       REM
       TMI A35+8     OK, DID NOT CHANGE SIGN
       PSE 114       CHANGED SIGN
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A36
       TRA A35
       REM 
       REM 
       REM           CLM TEST, TWO PARTS
A36    CLA PONES     BRING IN +377777777777
       CLM
       TZE A36+5     OK. NOW SEE IF SIGN IS SAME
       PSE 114       DID NOT CLEAR POS 1-35
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL A36+8     OK, SIGN UNCHANGED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A37
       TRA A36
       REM
       REM
       REM           CLM TEST, CHECK OF P ANDQ
A37    CLA ONES      BRING IN ONES
       ALS 6         SHIFT INTO P AND Q
       CLM
       TZE A37+6     OK, SHOULD CLEAR P AND Q
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A38
       TRA A37
       REM
       REM
       REM           SSP TEST
A38    CLA ONES      MAKE ACC SIGN MINUS
       SSP           NOW MAKE POSITIVE
       TPL A38+5     OK, SHOULD TRANSFER
       PSE 114       DID NOT CHANGE MINUS TO
       REM           PLUS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A39
       TRA A38
       REM
       REM
       REM           SSP TEST
A39    CLA PONES     BRING IN PLUS NUMBER
       SSP
       TPL A39+5     SHOULD TRANSFER
       PSE 114       DID NOT TRANSFER,
       REM             CHANGED SIGN
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A40
       TRA A39
       REM
       REM
       REM           SSM TEST
A40    CLA PONES     BRING IN PLUS NUMBER
       SSM           MAKE IT MINUS
       TMI A40+5     SHOULD TRANSFER
       PSE 114       DID NOT CHANGE SIGNS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A41
       TRA A40
       REM
       REM
       REM           SSM TEST
A41    CLA ONES      BRING IN NEGATIVE NUMBER
       SSM           SHOULD NOT CHANGE
       TMI A41+5     SHOULD TRANSFER
       PSE 114       INADVERTENTLY CHANGED SIGN
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A42
       TRA A41
       REM
       REM
       REM           CHS TEST
A42    CLA PONES     BRING IN PLUS NUMBER
       CHS           MAKE IT MINUS
       TMI A42+5     SHOULD TRANSFER
       PSE 114       DID NOT CHANGE SIGNS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A43
       TRA A42
       REM
       REM
       REM           CHS TEST
A43    CLA ONES      BRING IN NEGATIVE NUMBER
       CHS           MAKE IT POSITIVE
       TPL A43+5     SHOULD TRANFER
       PSE 114       DID NOT CHANGE SIGNS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A44
       TRA A43
       REM
       REM
       REM           LLS TEST
A44    TOV A44+1     TURN OFF OVFL
       LDQ ZERO      BRING ZERO INTO ACC + MQ
       CLA ZERO      SEE IF PICKED UP BITS
       LLS 18        BY SHIFT
       TZE A45       SHOULD TRANFER
       PSE 114       PICKED UP BI
       HPR           ERROR STOP WITH TWO UP
       REM
A45    STQ TEMP      CHECK FOR MQ PICK UP
       CLA TEMP      OF BITS BY LLS
       TZE A45+5     OK, NO PICK UP
       PSE 114       PICKED UP A ONE
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A46
       TRA A44       REPEAT TO A44
       REM
       REM
       REM           LLS TEST
A46    CLA ZERO      CLEAR ACCUMULATOR
       LDQ ONE       MOVE BIT FROM MQ 35 TO MQ 1
       LLS 34        DOES IT MOVE CORRECTLY
       TZE A47       OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       REM
A47    STQ TEMP      IS THE BIT STILL IN MQ
       CLA TEMP
       SUB PTW
       TZE A47+6     SHOULD TRANFER
       PSE 114       LOST THE BIT IN THE MQ
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A48
       TRA A46       GO BACK UP TO A 46
       REM
       REM
       REM           LLS TEST, CHECK FOR SIGNS
A48    CLA MTW       MAKE ACC NEGATIVE
       LDQ PTW       MAKE MQ POSITIVE
       LLS          	
       TPL A48+6     OK, SHOULD TRANFER
       PSE 114       DID NOT CHANGE ACC SIGN
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A49
       TRA A48
       REM
       REM
       REM           LLS TEST, CHECK FOR SIGNS
A49    CLA PTW       MAKE ACC POSITIVE
       LDQ MTW       MAKE MQ NEGATIVE
       LLS
       TMI A49+6     OK, SHOULD TRANFER
       PSE 114       DID NOT CHANGE ACC SIGN
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A50
       TRA A49
       REM
       REM
       REM          LLS TEST, CHECK SIGNS
A50    CLA PTW      MAKE ACC POSITIVE
       LDQ PTW      MAKE MQ POSITIVE
       LLS
       TPL A50+6    SHOULD TRANSFER
       PSE 114      CHANGED SIGNS INADVERTENTLY
       HPR          ERROR STOP WITH TWO UP
       PSE 113      TEST SWITCH ONE TO LOOP
       TRA A51
       TRA A50
       REM
       REM
       REM          LLS TEST, CHECK FOR SIGNS
A51    CLA MTW      MAKE ACC NEGATIVE
       LDQ MTW      MAKE MQ NEGATIVE
       LLS
       TMI A51+6    SHOULD TRANSFER
       PSE 114      SIGNS CHANGED INADVERTENLY
       HPR          ERROR STOP WITH TWO UP
       PSE 113      TEST SWITCH ONE TO LOOP
       TRA A52
       TRA A51
       REM
       REM
       REM          LRS TEST
A52    CLA ONE      PLACE 1 IN ACC 35
       LDQ ZERO     CLEAR MQ
       LRS 35       SHIFT A ONE TO MQ
       STQ TEMP     STORE MQ IN TEMP STORAGE
       CLA TEMP     BRING CONTENTS OF MQ TO ACC
       TNZ A52+8    OK, SHOULD STILL HAVE ONE
       PSE 114      CHANGED SIGNS INADVERTENTLY
       HPR          ERROR STOP WITH TWO UP
       PSE 113      TEST SWITCH ONE TO LOOP
       TRA A53
       TRA A52
       REM
       REM
       REM           LRS TEST
A53    LDQ ZERO      CLEAR MQ
       CLA PTW       PLATE BIT IN ACC 1
       LRS 36        MOVE A ONE TO MQ
       TZE A53+6     OK, ACC SHOULD BE CLEAR
       PSE 114       DID NOT CLEAR ACC
       HPR          ERROR STOP WITH TWO UP
       PSE 113      TEST SWITCH ONE TO LOOP
       TRA A54
       TRA A53
       REM
       REM
       REM           LRS TEST
A54    CLA MTW       PLACE BIT IN ACC POS 1
       LRS 34        MOVE IT TO ACC POS 35
       LBT           IS IT THERE
       TRA A54+5     NO
       TRA A54+7     YES
       PSE 114       LOST THE BIT IN THE MQ
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A55
       TRA A54
       REM
       REM
       REM           LRS TEST, CHECK SIGNS
A55    CLA PTW       MAKE ACC POSITIVE
       LDQ MTW       MAKE MQ NEGATIVE
       LRS           CHANGE SIGN OF MQ
       STQ TEMP      STORE IT
       CLA TEMP      BRING IT TO ACC
       TPL A55+8     SHOULD BE PLUS
       PSE 114       DID NOT CHANGE SIGNS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A56
       TRA A55
       REM
       REM
       REM           LRS TEST, CHECK SIGNS
A56    CLA MTW       MAKE ACC NEGATIVE
       LDQ PTW       MAKE MQ POSITIVE
       LRS           CHANGE MQ SIGN
       STQ TEMP      SAVE IT
       CLA TEMP      TEST IT
       TMI A56+8     OK
       PSE 114       DID NOT CHANGE MQ SIGN
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A57
       TRA A56
       REM
       REM
       REM           LRS TEST, CHECK SIGNS
A57    CLA PTW       MAKE ACC POSITIVE
       LDQ PTW       MAKE MQ POSITIVE
       LRS           MQ SIGN SHOULD STAY
       REM           POSITIVE
       STQ TEMP      SAVE IT
       CLA TEMP      BRING TO ACC
       TPL A57+8     OK, SHOULD BE PLUS
       PSE 114       CHANGE SIGN INADVERTENTLY
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A58
       TRA A57
       REM
       REM
       REM           LGL TEST
A58    TOV A58+1     TURN OFF OVERFLOW
       CLA ZERO      PLACE ZERO IN ACC
       LDQ ZERO      PLACE ZERO IN MQ
       LGL 8
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING IT INTO ACC
       TZE A58+9     OK, SHOULD BE ZERO
       PSE 114       PICKED UP BITS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A59
       TRA A58
       REM
       REM
       REM           LGL TEST, SHIFT ACROSS
A59    CLA ZERO      PLACE ZERO IN ACC
       LDQ ONE       PLACE ONE IN MQ 35
       LGL 1         SHIFT ONE
       STQ TEMP      SAVE MQ
       CLA TEMP      TEST FOR BIT
       TNZ A59+2     OK, SWEEP ACROSS MQ
       TMI A59+9     FINISH ACC SHOULD BE MINUS
       PSE 114       FAILED TO SHIFT, LOST A BIT
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A60
       TRA A59
       REM
       REM
       REM           LGL TEST, SEEK P POSITION
A60    TOV A60+1     TURN OFF OVERFLOW
       LDQ MZE
       LGL 36        MOVE BIT FROM MQ S TO ACC P
       PBT           IS THERE A BIT IN ACC P
       TRA A60+6     ERROR
       TRA A60+8     OK, PROCEED
       PSE 114       NO BIT IN P
       HPR           ERROR STOP WITH TWO UP
       REM
       TOV A61       OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A61    LGL 2         MOVE BIT OUT OF Q
       TZE A61+4     OK, SHOULD BE ZERO
       PSE 114       DID NOT MOVE PAST Q
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A61A
       TRA A60
       REM
       REM
       REM           LGL TEST
A61A   LDQ PTHR      PLACE BIT IN MQ 2 POS
       LGL 3         MOVE BIT TO ACC 35
       LBT           CHECK ACC
       TRA A61A+5    DID NOT SHIFT TO ACC 35
       TRA A61A+7    OK, CHECK MQ
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       STQ TEMP      PLACE MQ IN TEMP STOR
       CLA TEMP      BRING IT TO ACC
       TZE A61A+12   SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       TPL A61A+15   OK, MQ IS PLUS, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A62
       TRA A61A
       REM
       REM
       REM           RQL TEST
A62    LDQ MZE       PLACE BIT IN MQC SIGN POS
       RQL 1
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING MQ TO ACC
       LBT           TEST FOR ROTATE
       TRA A62+7     DID NOT ROTATE
       TRA A62+9     OK, BIT WENT FROM MQ S TO 35
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A62A
       TRA A62
       REM
       REM
       REM           RQL TEST
A62A   TOV A62A+1    TURN OFF OVFL
       CLA ZERO      LOAD ACC WITH ZERO
       LDQ ZERO      LOAD MQ WITH ZERO
       RQL 16
       STQ TEMP      MOVE MQ TO ACC
       CLA TEMP
       TZE A62A+9    OK, SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A63
       TRA A62A
       REM
       REM
A63    LDQ MZE       START WITH BIT IN MQ S
       RQL 1         SHIFT UNTIL IT GET BACK
       STQ TEMP        AROUND
       CLA TEMP
       TNZ A63+1     LOOP 35 TIMES
       TMI A63+8     YES, IT GOT BACK TO S POS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A63A
       TRA A63
       REM
       REM
       REM           RQL MODULO TEST
A63A   LDQ ONE       PLACE ONE IN MQ 35
       RQL 256       SHOULD NOT SHIFT
       STQ TEMP      LOAD MQ INTO ACC
       CLA TEMP
       LBT           HAVE WE SHIFTED
       TRA A63A+7    YES, ERROR
       TRA A63A+9    NO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A63B
       TRA A63A
       REM
       REM
       REM           RQL MODULO TEST
A63B   LDQ ONE       PLACE ONE IN MQ 35
       RQL 292       SHOULD MAKE ONE ROTATION
       STQ TEMP      LOAD MQ INTO ACC
       CLA TEMP
       LBT           WAS MODULO INTERPRETED OK
       TRA A63B+7    NO, ERROR
       TRA A63B+9    YES, MODULO PROCESS WORKS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A64
       TRA A63B
       REM
       REM
       REM           TQP TEST
A64    LDQ PTW       PLACE PLUS NUMBER IN MQ
       TQP A64+4     SHOULD TRANSFER
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A65
       TRA A64
       REM
       REM
       REM           TQP TEST
A65    LDQ MTW       PLACE NEGATIVE NO IN MQ
       TQP A65+3     SHOULD NOT TRANSFER
       TRA A65+5     OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A66
       TRA A65
       REM
       REM
       REM           NOP TEST
A66    NOP A66+2     PERFORM NOP
       TRA A66+4     OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A67
       TRA A66
       REM
       REM
       REM           COM TEST
A67    CLA ONES      PLACE ONES IN ACC
       COM           SHOULD NOW BE ZERO
       ALS 2
       TZE A67+6     OK, IT IS ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A68
       TRA A67
       REM
       REM
       REM           COM TEST
A68    CLA ONES      PLACE ONES IN ACC
       LDQ ONES      PLACE ONES IN MQ
       LLS 8         SHIFT BITS TO P AND Q
       COM           MAKE IT ALL ZEROS
       TZE A68+7     OK, ALL ZEROS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A69
       TRA A68
       REM
       REM
       REM           COM TEST, CHECK SIGN
A69    CLA PONES     BRING IN PLUS NUMBER
       COM           MAKE COM
       TPL A69+5     OK, SIGN DID NOT CHANGE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A70
       TRA A69
       REM
       REM
       REM           COM TEST, CHECK SIGN
A70    CLA ONES      BRING IN NEG NUMBER
       COM           COM
       TMI A70+5     OK, SIGN DID NOT CHANGE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A71
       TRA A70
       REM
       REM
       REM           ADD TEST, SIGNS POSITIVE
A71    CLA ONE       HAVE BOTH SIGNS POSITIVE
       ADD ONE       ADD
       LBT           SHOULD HAVE ZERO IN ACC 35
       TRA A72       OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       REM
A72    ARS 1         SHIFT ONE TO CHECK ANSWER
       LBT
       TRA A72+4     DID NOT ADD CORRECTLY
       TRA A72+6     CHECK SIGN
       PSE 114       BIT ERROR
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL A72+9     OK, SIGN IS PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A73
       TRA A71
       REM
       REM
       REM           ADD TEST, SIGNS NEGATIVE
A73    CLA MONE      BRING IN MINUS ONE
       ADD MONE      ADD MINUS ONE
       LBT           TEST ANSWER
       TRA A74       OK, ACC 35 IS A ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A74    ARS 1         SHOULD GET A ONE
       LBT           TEST
       TRA A74+4     DID NOT SENSE A ONE
       TRA A74+6     CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TMI A74+9     OK, SIGN IS MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A75
       TRA A73       REPEAT SECTION
       REM
       REM
       REM           ADD TEST, ACC PLUS, MEMORY
       REM           NEGATIVE
A75    CLA THREE     MAKE ACC PLUS THREE
       ADD M2        ADD MEM MINUS TWO
       LBT           SHOULD GET A ONE
       TRA A75+5
       TRA A76       OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A76    ARS 1         SEE THAT HAVE NO CARRY
       LBT           TEST FOR ZERO
       TRA A76+5     CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL A76+8     OK, SIGN SHOULD BE PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A77
       TRA A75       REPEAT SECTION
       REM
       REM           ADD TEST, ACC MINUS
       REM             MEMORY PLUS
A77    CLA M3        MAKE ACC MINUS THREE
       ADD TWO       ADD PLUS TWO
       LBT           TEST FOR ONE
       TRA A77+5
       TRA A78       OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A78    ARS 1         SEE THAT HAVE NO CARRY
       LBT           SHOULD BE ZERO
       TRA A78+5     CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TMI A78+8     OK, SIGN IS MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A79
       TRA A77
       REM
       REM
       REM           ADD TEST
A79    CLA TWO       MAKE ACC PLUS TWO
       ADD M3        ADD MINUS THREE
       LBT           TEST FOR ONE
       TRA A79+5
       TRA A80       OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A80    ARS 1         CHECK FOR ZERO FIRST
       LBT           TEST FOR ZERO
       TRA A80+5     CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TMI A80+8     OK, SIGN IS MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A81
       TRA A79       REPEAT SECTION
       REM
       REM
       REM           ADD TEST
A81    CLA M2        MAKE ACC MINUS TWO
       ADD THREE     ADD PLUS THREE
       LBT           TEST FOR ONE
       TRA A81+5
       TRA A82       OK, GOT A ONE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A82    ARS 1         CHECK NEXT POSITION
       LBT           FOR A ZERO
       TRA A82+5     CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL A82+8     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A82A
       TRA A81
       REM
       REM
       REM           ADD TEST, WITH RIPPLE
A82A   CLA PONES     BRING IN PLUS ONES
       ADD ONE       ADD ONE TO RIPPLE
       PBT           P SHOULD HAVE BIT
       TRA A82A+5    NO P BIT
       TRA A82A+7    OK, CHECK OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TOV A82A+10   OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A83
       TRA A82A
       REM
       REM
       REM           ADD MAGNITUDE TEST
A83    CLA MONE      ACC NEGATIVE ONE
       ADM TWO       STORAGE PLUS TWO
       LBT           TEST FOR ONE.
       TRA A83+5     NO
       TRA A83+7     CHECK SIGN.
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL A83+10    OK, SIGN IS PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A84
       TRA A83
       REM
       REM
       REM           ADM TEST
A84    CLA MONE      BRING IN MINUS ONE
       ADM M2        STORAGE MINUS 2
       LBT           TEST FOR ONE
       TRA A84+5     NO
       TRA A84+7     OK, CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL A84+10    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A84A
       TRA A84
       REM
       REM
       REM           ADM TEST, WITH RIPPLE
A84A   CLA PONES     BRING IN PLUS ONES
       ADM MONE      ADM OF MINUS ONE
       PBT           SHOULD GET BIT IN P
       TRA A84A+5    NO P BIT
       TRA A84A+7    05, CHECK OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       REM
       TOV A84A+11   OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A85
       TRA A84A
       REM
       REM
       REM          SUB TEST
A85    CLA ONE      MAKE ACC PLUS ONE
       SUB MONE     SUB MINUS ONE
       LBT          TEST FOR ZERO
       TRA A85+6
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL A86       OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A86    ARS 1         IN ACC POS 34
       LBT
       TRA A86+4     ERROR, NO ONE BIT
       TRA A86+6     OK, GOT A ONE BIT
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A87
       TRA A85       REPEAT SECTION
       REM
       REM
       REM           SUB TEST
A87    CLA MONE      MAKE ACC MINUS ONE
       SUB ONE       SUB PLUS ONE
       LBT           TEST FOR ZERO
       TRA A87+6     OK, CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TMI A88       OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A88    ARS 1         CHECK FOR ONE IN POS 34
       LBT           SHOULD GET A ONE
       TRA A88+4     NO, DID NOT GET IT
       TRA A88+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A89
       TRA A87
       REM
       REM
       REM           SUB TEST, END CARRY
A89    CLA THREE     ACC PLUS THREE
       SUB TWO       SUB PLUS TWO
       LBT           SHOULD HAVE PLUS ONE
       TRA A89+5     DID NOT GET ONE
       TRA A89+7     OK, CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL A89+10    OK PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A90
       TRA A89
       REM
       REM
       REM           SUB TEST, NO END CARRY
A90    CLA TWO       ACC PLUS TWO
       SUB THREE     SUB PLUS THREE
       LBT           TEST FOR ONE
       TRA A90+5     NO GOT ERROR
       TRA A90+7     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TMI A91       OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A91    ARS 1         CHECK ACC POS 34
       LBT           SHOULD BE ZERO
       TRA A91+5     OK IT IS ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A92
       TRA A90       REPEAT SECTION
       REM
       REM
       REM           SUB TEST, NO END CARRY
A92    CLA M2        ACC MINUS TWO
       SUB M3        SUB MINUS THREE
       LBT           TEST FOR ONE
       TRA A92+5     NO GOT A ZERO
       TRA A92+7     OK CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL A93       OK PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A93    ARS 1         CHECK POSITION 34 OF ACC
       LBT           SHOULD BE ZERO
       TRA A93+5     OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A94
       TRA A92
       REM
       REM
       REM           SUB TEST, END CARRY
A94    CLA M3        ACC MINUS THREE
       SUB M2        SUB MINUS TWO
       LBT           TEST FOR ONE
       TRA A94+5     NO GOOD, GO A ZERO
       TRA A94+7     OK, CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TMI A95       OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
A95    ARS 1         CHECK POSITION 34 OF ACC
       LBT           SHOULD BE ZERO
       TRA A95+5     OK IT IS ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A95A
       TRA A94
       REM
       REM
       REM           SUB TEST, WITH RIPPLE
A95A   CLA ONES      BRING IN MINUS ONES
       SUB ONE       SUB PLUS ONE
       PBT           SHOULD GET BIT IN P
       TRA A95A+5    NO BIT IN P
       TRA A95A+7    OK, CHECK OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TOV A95A+10   OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A96
       TRA A95A
       REM
       REM
       REM           SBM TEST
A96    CLA ONE       ACC PLUS ONE
       SBM M2        SBM MINUS TWO
       LBT           TEST FOR ONE
       TRA A96+5     NO GOOD, GOT ZERO
       TRA A96+7     OK, CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TMI A96+10    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A97
       TRA A96
       REM
       REM
       REM           SBM TEST
A97    CLA ONE       ACC PLUS ONE
       SBM TWO       SBM PLUS TWO
       LBT           TEST FOR ONE
       TRA A97+5     GOT ZERO
       TRA A97+7     OK, CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TMI A97+10    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A97A
       TRA A97
       REM
       REM
       REM           SBM TEST, WITH RIPPLE
A97A   CLA ONES      BRING IN MINUS ONES
       SBM ONE       SBM OF PLUS ONE
       PBT           SHOULD BE BIT IN P
       TRA A97A+5    NO BIT IN P
       TRA A97A+7    OK, CHECK OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TOV A97A+10   OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A98
       TRA A97A
       REM
       REM
       REM           CLA TEST
A98    CLA MONE      MAKE ACC MINUS
       TMI A98+4     CHECK SIGN LOADING
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A99
       TRA A98
       REM
       REM
       REM           CLA TEST
A99    CLA ONE       MAKE ACC PLUS
       TPL A99+4     CHECK SIGN, SHOULD BE PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA A100
       TRA A99
       REM
       REM
       REM           CLA TEST
A100   CLA ZERO      SEE IF ACC IS CLEAR
       TZE A100+4    OK, SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B
       TRA A100
       REM
       REM
       REM           CLA TEST
B      CLA PTW       BIT IN ACC 1
       ALS 1         SHIFT TO P POSITION
       PBT           TEST P FOR A ONE
       TRA B+5       NO, GOT A ZERO
       TRA B+7       OK, CHECK OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TOV B+10      OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B1
       TRA B
       REM
       REM
       REM           CLA TEST
B1     CLA ONE       SEE IF Q AND P POS ARE
       REM              CLEAR
       PBT           P POS SHOULD BE ZERO
       TRA B1+5      OK, NOW TEST Q POS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ARS 1         SHIFT FOR Q
       PBT           Q POS SHOULD BE ZERO
       TRA B1+10     OK, CHECK OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TNO B1+13     OK, OVFL SHOULD BE OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B2
       TRA B1
       REM
       REM
       REM           CLA TEST
B2     CLA ONE       SEE THAT ONE IS IN ACC 35
       LBT           IS ONE THERE
       TRA B2+4      NO
       TRA B2+6      YES, ONE IS THERE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B3
       TRA B2
       REM
       REM
       REM           CLA TEST, WITH RIPPLE
B3     CLA PONES     BRING IN PLUS ONES
       ADD ONE       ADD ONE
       LBT           CHECK ACC 35 FOR ZERO
       TRA B3+6      OK, IS ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       PBT           TEST P POS FOR ONE
       TRA B3+9      ERROR
       TRA B3+11     OK, CHECK ACC RESULT
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 2         OK, CHECK FOR ZERO IN OTHER
       TZE B3+15       POS BY MOVING BIT PAST Q
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B4
       TRA B3
       REM
       REM
       REM           CLS TEST
B4     CLS MONE      BRING IN MINUS ONE
       TPL B4+4      SHOULD BECOME PLUS
       PSE 114       DID NOT CHANGE SIGN
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B5
       TRA B4
       REM
       REM
       REM           CLS TEST
B5     CLS ONE       BRING IN ONE
       TMI B5+4      SHOULD BE MINUS
       PSE 114       DID NOT CHANGE SIGN
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B6
       TRA B5
       REM
       REM
       REM           CLS TEST
B6     CLS ONE       BRING IN ONE IN ACC 35
       LBT           CHECK, IS ONE IN ACC 35
       TRA B6+4      NO GOOD, DID NOT GET ONE
       TRA B6+6      PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       PBT           SEE IF P IS CLEAR
       TRA B6+10     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ARS 1         SHIFT TO CHECK Q
       PBT           SHOULD BE ZERO
       TRA B6+15     OK, IT IS ZERO, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B7
       TRA B6
       REM
       REM
       REM           CAL TEST
B7     CAL MONE      CHECK THAT P HAS ONE
       PBT              SHOULD HAVE ONE
       TRA B7+4
       TRA B8        OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
B8     TPL B8+3      CHECK THAT SIGN DID NOT
       REM              CHANGE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ARS 1         CHECK Q POS
       PBT           SHOULD BE ZERO
       TRA B8+8      OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B9
       TRA B7
       REM
       REM
       REM           CAL TEST
B9     CAL ONE       BRING IN PLUS ONE
       PBT           P SHOULD BE ZERO
       TRA B9+5      OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       LBT           TEST ACC 35 FOR ONE
       TRA B9+8      DID NOT BRING IN A ONE
       TRA B10       OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
B10    TPL B10+3     SIGN SHOULD BE PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ARS 1         CHECK Q POS FOR ZERO
       PBT
       TRA B10+8     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B11
       TRA B9
       REM
       REM
       REM           ACL TEST
B11    CLA ZERO      CHECK P POSITION AND SIGN
       ACL ONE        POSITION
       PBT           SHOULD BE A ZERO IN A
       TRA B11+6     CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL B11+9     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B12
       TRA B11
       REM
       REM
       REM           ACL TEST
B12    CLA ZERO      BRING IN MINUS NUMBER
       ACL MONE      SHOULD GET ONE IN P POS
       PBT
       TRA B12+5     NO GOOD, GOT ZERO
       TRA B12+7     CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL B12+10    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       LBT           CHECK FOR ONE IN ACL 35
       TRA B12+13    GOT A FALSE CARRY
       TRA B12+15    OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B13
       TRA B12
       REM
       REM
       REM           ACL TEST
B13    CAL MONE      ACC BIT IN POS P AND POS 35
       ACL MONE      ACL MINUS ONE
       PBT           SHOULD GET ZERO IN P
       TRA B13+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       LBT           TEST FOR XXX CARRY
       TRA B13+9     NO GOOD, GOT A ZERO
       TRA B13+11    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ARS 1         OK, NOW SEE IF Q BIT
       PBT           HAS A ONE
       TRA B13+16    Q SHOULD BE CLEARED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B14
       TRA B13
       REM
       REM
       REM           STO TEST
B14    CLA ONES      BRING IN ALL ONES
       STO TEMP      PLACE IN TEMP STORAGE
       SUB TEMP      SUB SAME QUANTITY
       TZE B14+6     SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B15
       TRA B14
       REM
       REM
       REM           SLW TEST
B15    CAL MONE      PUT BIT IN POS P AND POS 35
       TPL B15+4     OK, SIGN SHOULD BE PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       SLW TEMP      SLW IN TEMP STORAGE
       CLA TEMP      BRING WORD BACK
       SUB MONE      SUB ORIGINAL
       TZE B15+10    OK, SHOULD GET ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B16
       TRA B15
       REM
       REM
       REM           SLW TEST
B16    CLA MONE      PUT BIT IN P, SIGN MINUS
       SLW TEMP      SLW IN TEMP STORAGE
       CLA TEMP      BRING IT TO ACC
       TPL B16+6     SIGN SHOULD NOW BE PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B17
       TRA B16
       REM
       REM
       REM           STP TEST
B17    CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP
       CLA ONES      BRING IN ALL ONES
       STP TEMP      STP IN TEMP STORAGE
       CLA TEMP      BRING BACK, SIGN IS PLUS
       TPL B17+8     SHOULD BE PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 1         CHECK ACC POS 1
       PBT           SHOULD BE ONE
       TRA B17+12    ERROR IN ONE POS
       TRA B17+14    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TOV B17+17    OVFL SHOULD BE ON
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 1         CHECK ACC POS 2
       PBT           SHOULD BE ZERO
       TRA B17+21    ERROR IN TWO POSITION
       TRA B17+23
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       TOV B17+26    OVFL SHOULD BE ON
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B18
       TRA B17
       REM
       REM
       REM           STP TEST
B18    CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP
       CLA ZERO      BRING IN PLUS ZERO
       STP TEMP      STORE P, 1, 2, ZEROS
       CLA TEMP      BRING BACK TO ACC
       TPL B18+8     OK, SHOULD BE PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 1         CHECK ONE POSITION
       PBT           SHOULD BE ZERO
       TRA B18+13    OK, CHECK OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TNO B18+16    OK, OVFL SHOULD BE OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 1         CHECK TWO POSITION
       PBT           SHOULD BE ZERO
       TRA B18+21    OK, CHECK OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TNO B18+24    OK, OVFL SHOULD BE OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B19
       TRA B18
       REM
       REM
       REM           STP TEST
B19    CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP
       CAL ONES      BRING IN ONES, CHECK POS
       ALS 1          P AND POS Q
       STP TEMP      STO IN TEMP STORAGE
       ARS 1         DID CLEAR Q POSITION
       PBT
       TRA B19+9     NO GOOD, GOT ZERO
       TRA B19+11    CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL B19+14
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       CLA TEMP      BRING BACK CONTENTS OF TEMP
       REM
       TMI B19+18    OK, GOT P POS IN STORAGE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B20
       TRA B19
       REM
       REM
       REM           STA TEST
B20    CLA RTN       SET UP ERROR TRA B20+7
       STO TEMP        IN STORAGE IF STA FAILS
       CLA RTN+1     SET UP ERROR TRA B20+5
       STA TEMP      PLACE IT IN STORAGE
       TRA TEMP      GO THERE AND MAKE TRANSFER
       SUB RTN+1     SEE IF ACC REMAINS SAME
       TZE B20+9     OK, CHECKS OUT
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B21
       TRA B20
       REM
       REM
       REM           STA TEST
B21    CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ZERO
       CLA 8CF       ALL ONES 21-35
       STA TEMP      PLACE ONES IN TEMP STORE
       CLA TEMP      BRING IT TO ACC
       SUB 8CF       SUB 8CF
       TZE B21+9     OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B22
       TRA B21
       REM
       REM
       REM           STA TEST
B22    CLA 8CF       INITIALIZE TEMP STORAGE
       STO TEMP        WITH ONES IN POS 21-35
       CLA ZERO      BRING ZERO INTO ACC
       STA TEMP      STA IN TEMP STORAGE
       CLA TEMP      BRING IT BACK
       TZE B22+8     OK, REPLACE ONES WITH
       REM             ZEROS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B23
       TRA B22
       REM
       REM
       REM           STD TEST
B23    CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ALL ZERO
       CLA 8CF       BRING IN 15 ONES
       ALS 18        MOVE TO DECREMENT
       STD TEMP      PUT ONES IN TEMP STORE
       SUB TEMP      SUB TEMP STORE FROM ACC
       TZE B23+9     OK, SHOULD GET ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B24
       TRA B23
       REM
       REM
       REM           STD TEST
B24    CLA 8CF       INITIALIZE TEMP STORAGE
       ALS 18          WITH ALL ONES IN
       STO TEMP        DECREMENT FIELD
       CLA ZERO      BRING IN ZERO
       STD TEMP      STD WITH ZEROS
       CLA TEMP      BRING BACK TEST FOR ZEROS
       TZE B24+9     OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B25
       TRA B24
       REM
       REM
       REM           CAS TEST
B25    CLA THREE     MAKE ACC GRATER THEN
       CAS TWO       STORAGE,SIGNS PLUS
       TRA B25+6     OK, PROCEED
       TRA B25+4     SHOULD NOT BE EQUAL
       PSE 114       SHOULD NOT BE LESS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B26
       TRA B25
       REM
       REM
       REM           CAS TEST
B26    CLA TWO       MAKE ACC GREATER THEN
       CAS M3          STORAGE, SIGNS UNLIKE
       TRA B26+6     OK, PROCEED
       TRA B26+4     SHOULD NOT BE EQUAL
       PSE 114       SHOULD NOT BE LESS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B27
       TRA B26
       REM
       REM
       REM           CAS TEST
B27    CLA M2        MAKE ACC GREATER THEN
       CAS M3        STORAGE, SIGNS MINUS
       TRA B27+6     OK, PROCEED
       TRA B27+4     SHOULD NOT BE EQUAL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B28
       TRA B27
       REM
       REM
       REM           CAS TEST
B28    CLA TWO       MAKE ACC LESS THAN
       CAS THREE     STORAGE, SIGNS PLUS
       TRA B28+5     SHOULD NOT BE GREATER
       TRA B28+5     SHOULD NOT BE EQUAL
       TRA B28+7     SHOULD BE LESS
       PSE 114       SHOULD NOT BE LESS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B29
       TRA B28
       REM
       REM
       REM           CAS TEST
B29    CLA M3        MAKE ACC LES THAN
       CAS TWO       STORAGE, SIGNS PLUS
       TRA B29+5     SHOULD NOT BE GREATER
       TRA B29+5     SHOULD NOT BE EQUAL
       TRA B29+7     SHOULD BE LESS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B30
       TRA B29
       REM
       REM
       REM           CAS TEST
B30    CLA M3        MAKE ACC LES THAN
       CAS M2        STORAGE, SIGNS UNLIKE
       TRA B30+5     SHOULD NOT BE GREATER
       TRA B30+5     SHOULD NOT BE EQUAL
       TRA B30+7     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B31
       TRA B30
       REM
       REM
       REM           CAS TEST
B31    CLA TWO
       CAS TWO
       TRA B31+4     SHOULD NOT BE GREATER
       TRA B31+6     OK, PROCEED
       PSE 114       SHOULD NOT BE LESS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B32
       TRA B31
       REM
       REM
       REM           CAS TEST PLUS ZERO AND
       REM           MINUS ZERO
B32    CLA ZERO      MAKE ACC GREATER THAN
       CAS MZE        STORAGE
       TRA B32+6     OK, PROCEED
       TRA B32+4     SHOULD NOT BE EQUAL
       PSE 114       SHOULD NOT BE LESS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B33
       TRA B32
       REM
       REM
       REM           LDQ TEST
B33    CLA ZERO      CLEAR ACC AND MQ TO START
       ARS 36
       LDQ ONES      BRING IN ALL ONES TO MQ
       LLS 0         SHIFT SIGNS
       TMI B33+7     OK, SIGN IS MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       LLS 35        SHIFT ONES TO ACC
       TOV B33+9     TURN OFF OVFL
       ADD MONE      ADD MINUS ONE TO RIPPLE
       TOV B33+13    SHOULD OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 2         REMOVE P AND Q POSITION
       TZE B33+17    OK, SHOULD GET ZERO NOW
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B34
       TRA B33
       REM
       REM
       REM           STQ TEST
B34    LDQ ONES      BRING ALL ONES TO MQ
       STQ TEMP      PLACE IN TEMP STORAGE
       CLA TEMP      BRING IN ACC
       TMI B34+6     OK, SIGN IS MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TOV B34+7     TURN OFF OVFL
       ADD MONE      ADD MINUS ONE TO RIPPLE
       TOV B34+11    SHOULD OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 2         REMOVE P AND Q POSITION
       TZE B34+15    SHOULD GET ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B35
       TRA B34
       REM
       REM
       REM           LDQ TEST
B35    LDQ ZERO      BRING IN ALL ZEROS TO MQ
       STQ TEMP      PLACE IN TEMP STORAGE
       CLA TEMP      BRING IN ACC
       TZE B35+6     OK, SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B36
       TRA B35
       REM
       REM
       REM           SLQ TEST
B36    CLA ZERO      MAKE ACC AND TEMP STORAGE
       STO TEMP      ALL ZEROS
       LDQ ONES      MAKE MQ ALL ONES
       SLQ TEMP      PLACE S, 1-17 IN TEMP STORAGE
       CLA TEMP      BRING BACK TO ACC
       TMI B36+8     SHOULD BE MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       SSP           MAKE SIGN PLUS
       TOV B36+10    TURN OFF OVFL
       ALS 1         SHIFT TO P POS UNTIL ONLY
       TOV B36+10    BIT LEFT IN Q
       TNZ B36+15    OK, SHOULD NOT GET ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 2         OK, SHOULD BE ZERO
       TNO B36+19    OK, SHOULD NOT GET EXTRA
       REM             BITS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B37
       TRA B36
       REM
       REM
       REM           SLQ TEST
B37    LDQ ZERO      BRING ZEROS TO MQ
       CLA ONES      PLACE ONES IN TEMP STORAGE
       STO TEMP
       SLQ TEMP      PLACE ZEROS IN S, 1-17
       CLA TEMP       OF ACC
       ARS 18        SHIFT ONES OUT
       TZE B37+9     OK, RESET SHOULD BE ZEROS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B38
       TRA B37
       REM
       REM           TLQ TEST
B38    CLA TWO       MQ LESS THAN ACC
       LDQ M3        MQ MINUS 3 ACC PLUS 2
       TLQ B38+5     OK, SHOULD TRANSFER
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B39
       TRA B38
       REM
       REM
       REM
       REM           TLQ TEST
B39    CLA M3        MQ GREATER THEN ACC
       LDQ M2        MQ MINUS 2 ACC MINUS 3
       TLQ B39+4     SHOULD NOT TRANSFER
       TRA B39+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B40
       TRA B39
       REM
       REM
       REM           TLQ TEST
B40    CLA TWO       MQ EQUALS ACC
       LDQ TWO       BOTH PLUS TWO
       TLQ B40+4     SHOULD NOT TRANSFER
       TRA B40+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B41
       TRA B40
       REM
       REM
       REM           TLQ TEST
B41    CLA ZERO      MQ LESS THEN ACC
       LDQ MZE       MQ MINUS 0 ACC PLUS 0
       TLQ B41+5     OK, SHOULD TRANSFER
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B42
       TRA B41
       REM
       REM
       REM           TLQ TEST
B42    CLA MZE       MQ GREATER THEN ACC
       LDQ ZERO      MQ PLUS 0 ACC MINUS 0
       TLQ B42+4     SHOULD NOT TRANSFER
       TRA B42+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B43
       TRA B42
       REM
       REM
       REM           RND TEST
B43    CLA ZERO      CLEAR ACC
       LDQ PTW       PLACE BIT IN MQ 1 POS
       RND           ROUND SHOULD GO TO ACC
       LBT             POS 35, IS IT THERE
       TRA B43+6     NO, ERROR
       TRA B43+8     YES, OK
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B44
       TRA B43
       REM
       REM
       REM           MPY TEST
B44    CLA PONES     PLACE ALL ONES IN ACC
       ALS 2         PLACE ONES IN P AND Q
       LDQ ZERO      MULTPLY ZERO BY ZERO
       MPY ZERO      CHECK ACC AND MQ FOR ZERO
       TZE B44+7     OK, SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING TO ACC TO CHECK
       TZE B44+12    OK, SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B45
       TRA B44
       REM
       REM
       REM           MPY TEST
B45    LDQ ONE       MULTIPLY ONE BY ONE
       MPY ONE       SHOULD GET ZERO IN ACC
       TZE B45+5     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       STQ TEMP      SAVE MQ AND CHECK
       CLA TEMP        FOR ONE IN ACC 34
       TNZ B45+10    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ARS 2         SHIFT OVER
       TZE B45+14    OK, CHECKS OUT
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B46
       TRA B45
       REM
       REM
       REM           MPY TEST
B46    LDQ PONES     MULTIPLY ALL ONES
       MPY ONE       BY ONE
       TZE B46+5     OK, ACC SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING IT TO ACC
       TOV B46+7     TURN OFF OVFL
       ADD ONE       ADD ONE TO TURN ON OVFL
       TOV B46+12    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B47
       TRA B46
       REM
       REM
       REM           MPY TEST
B47    LDQ PONES     MULTIPLY ALL ONES
       MPY PONES     BY ALL ONES
       ADD ONE       ADD ONE, 2-35 HAVE ONES
       TOV B47+4     SET OVFL
       ADD ONE       RIPPLE CARRY FOR ACC
       TOV B47+8     OK, DID RIPPLE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING IT TO ACC
       SUB ONE       SUB ONE
       TZE B47+14    SHOULD TRANSFER
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B48
       TRA B47
       REM
       REM
       REM           MPY TEST
B48    LDQ ZERO      MULTIPLY PLUS NUMBER BY
       MPY ZERO      PLUS, PRODUCT IS PLUS
       TPL B48+5     OK, ACC IS PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TQP B48+8     OK, MQ IS PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B49
       TRA B48
       REM
       REM
       REM           MPY TEST
B49    LDQ MZE       MULTIPLY MINUS NUMBER BY
       MPY MZE       MINUS NUMBER, CHECK SING
       TPL B49+5     OK, ACC IS PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TQP B49+8     OK, MQ IS PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B50
       TRA B49
       REM
       REM
       REM           MPY TEST
B50    LDQ MZE       MULTIPLY MQ MINUS BY
       MPY ZERO      A PLUS, CHECK SIGN
       TMI B50+5     ACC SHOULD BE MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TQP B50+7     MQ SHOULD BE MINUS
       TRA B50+9     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B51
       TRA B50
       REM
       REM
       REM           MPY TEST
B51    LDQ ZERO      MULTIPLY MQ PLUS BY
       MPY MZE       MINUS
       TMI B51+5     ACC IS MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TQP B51+7
       TRA B51+9     MQ IS MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B52
       TRA B51
       REM
       REM
       REM           MPR TEST
B52    LDQ PTW       MULTIPLY +200---BY ONE
       MPR ONE       SHOULD ROUND TO ACC
       TNZ B52+5     OK, DID ROUND
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ARS 1         OK, NOW MOVE BIT OUT
       TZE B52+9     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B53
       TRA B52
       REM
       REM
       REM           MPR TEST
B53    LDQ PTW       MULTIPLY PLUS TWO BY
       MPR ZERO        ZERO SHOULD NOT ROUND
       TZE B53+5     OK, IN ACC CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL B53+8     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TQP B53+11    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B54
       TRA B53
       REM
       REM
       REM           MPR TEST
B54    LDQ MTW       MULTIPLY MINUS TWO BY
       MPR             ZERO, CHECK SIGNS
       TPL B54+4     ERROR
       TRA B54+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TQP B54+8     ERROR, SHOULD BE MINUS
       TRA B54+10    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B54A
       TRA B54
       REM
       REM
       REM           MPR TEST, WORST CONDITION
B54A   TOV B54A+1    TURN OFF OVFL
       LDQ PONES     ALL ONES IN MQ
       MPR PTW       ACC 1-35 ALL ONES
       SUB PTW       MQ 1, A ONE, FORCE ROUND
       TZE B54A+7    SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TNO B54A+10   SHOULD NOT BE OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B55
       TRA B54A
       REM
       REM
       REM           DVP TEST
B55    LDQ TWO       DIVIDEND PLUS TWO
       CLA ZERO      DIVIDE BY ONE SHOULD
       DVP ONE         GET A PLUS TWO IN MQ
       TPL B55+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TZE B55+9     REMAINDER SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       STQ TEMP      SAVE CONTENTS OF MQ
       CLA TEMP      BRING TO ACC
       SUB TWO       SUB TWO TO GET ZERO
       TZE B55+15    OK PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TNO B55+18    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B56
       TRA B55
       REM
       REM
       REM           DVP TEST
B56    LDQ ONES      DIVIDE ALL ONES IN MQ
       DVP MTW        BY -200...
       TPL B56+5     OK, SHOULD BE PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       STO TEMP      SAVE ACC AND MQ
       STQ TEMP+1
       TQP B56+9     ERROR
       TRA B56+11    MQ SHOULD BE MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       CLA TEMP+1    ZEROS TO ACC
       SUB TEMP      SUB ONES FROM ACC
       TOV B56+14    TURN OFF OVFL
       ALS 1         SHOULD GET OVFL
       TOV B56+18    OK, GET OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B57
       TRA B56
       REM
       REM
       REM           DCT TEST
B57    DCT           INITIALIZE THE
       TRA B57+2     DCT INDICATOR
       DCT           TEST INDICATOR OFF
       TRA B57+5     INDICATOR NOT OFF
       TRA B57+7
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       CLA ZERO      PLACE ZERO IN ACC
       LDQ PTW       MAKE MQ +200... DIVIDE
       DVP PTW       BY +200...
       DCT           TEST INDICATOR OFF
       TRA B57+13    IF ON, DID NOT SHOW
       TRA B57+15    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B58
       TRA B57       OK, PROCEED
       REM
       REM
       REM           DCT TEST
B58    CLA PTW       DIVIDE +200... BY -100...
       DVP MON       CHECK INDICATOR SHOULD
       REM             BE ON
       DCT           TEST INDICATOR ON
       TRA B58+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B58A
       TRA B58
       REM
       REM
       REM           DIVIDE A ONE IN EACH
B58A   CLA ONE       POSITION BY ZERO
       STO TEMP
       DVP ZERO
       SUB TEMP      CHECK THAT ACC DID NOT
       TZE B58A+7    CHANGE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM           CHECK DIVIDE CHECK LIGHT
       DCT           SHOULD BE ON
       TRA B58A+11   OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       ALS 1         MOVE ACROSS ACC
       REM
       TNZ B58A+1    BY ONE
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B62
       TRA B58A
       REM
       REM
       REM           DVH TEST, NO HALT
B62    LDQ PTW       MAKE MQ POSITIVE
       CLA ZERO      MAKE ACC ZERO
       DVH PTW       DIVIDE
       TPL B62+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TOV B62+7     TURN OFF OVFL
       TZE B62+10
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       STQ TEMP      SAVE MQ, ADD IT TO ACC
       CLA TEMP
       TNZ B62+15    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       LBT           CHECK POS 35 FOR ONE
       TRA B62+18    ERROR, GOT A ZERO
       TRA B62+20    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ARS 1         OK, SHIFT IT OUT
       TZE B62+24    OK, ALL SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B63
       TRA B62
       REM
       REM           DVH TEST, NO HALT
B63    LDQ ONES      MAKE MQ ALL ONES
       DVH MTW       DIVIDE BY -200...
       TPL B63+5     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       STO TEMP      SAVE AC AND MQ
       STQ TEMP+1
       TQP B63+9     ERROR IN MQ SIGN
       TRA B63+11    OK, IS MINUS, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       CLA TEMP+1    SUB ACC FROM MQ
       SUB TEMP
       TOV B63+14    TURN OFF OVFL
       LLS 1         SHIFT ONE BIT
       TOV B63+18    OK, SHOULD BE ON
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B64
       TRA B63
       REM
       REM           ANA TEST
B64    CAL MZE       MAKE ACC MINUS ZERO
       ANA ONES      /AND/ TO ALL POSITIONS
       REM             ZERO EXCEPT POS P
       PBT           P SHOULD HAVE BIT
       TRA B64+5     ERROR, NO BIT IN POS P
       TRA B64+7     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ARS 1         OK, NOW POS Q SHOULD BE
       REM           ZERO
       PBT           SHIFT AND TEST
       TRA B64+12    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL B64+15    OK, SHOULD BE PLUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B65
       TRA B64
       REM
       REM
       REM           ANA TEST
B65    CAL ONES      PLACE ALL ONES IN ACC
       ANA ONES      /AND/ TO ALL ONES
       ADD ONE       ADD ONE, CAUSE RIPPLE
       ALS 1         MOVE OUT Q
       TZE B65+7     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B66
       TRA B65
       REM
       REM
       REM           ANA TEST
B66    CAL ZERO      PLACE ZEROS IN ACC
       ANA ONES      /AND/ TO ALL ZEROS
       TZE B66+5     OK, NO PICK UP
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B67
       TRA B66
       REM
       REM
       REM           ANA TEST
B67    CAL KK30      L-252525252525
       ANA KK31      L-125252252525
       SUB KK32      L+000000252525
       PBT           TEST P FOR BIT
       TRA B67+6     ERROR
       TRA B67+8     OK, PROCEED AND MOVE IT OUT
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 2         ALL RIGHT MOVE IT OUT
       TZE B67+12    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B68
       TRA B67
       REM
       REM
       REM           ANA TEST
B68    CLA KK30      L-252525252525
       ANA KK33      L-252525525252
       SUB KK34      L+252525000000
       TZE B68+6     OK, SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B69
       TRA B68
       REM
       REM
       REM           ANS TEST
B69    CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ZERO
       CAL ONES      PLACE ALL ONES IN ACC
       ANS TEMP      /AND/ TO ZERO STORAGE
       CLA TEMP      BRING RESULT TO ACC
       TZE B69+8     SHOULD BE ZERO, CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL B69+11    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B70
       TRA B69
       REM
       REM
       REM           ANS TEST
B70    CLA ONES      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ALL ONES
       CAL ZERO      MAKE ACC ZERO
       ANS TEMP      /AND/ TO ONES IN STORAGE
       CLA TEMP      BRING RESULT TO ACC
       ALS 1         SHIFT 0 POS OUT
       TZE B70+9     OK, ALL SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B71
       TRA B70
       REM
       REM
       REM           ANS TEST WITH SIGNS UNLIKE
B71    CLA KK30      INITIALIZE STORAGE WITH
       STO TEMP        L-252525252525
       CAL KK35      MAKE ACC +1252522522525
       ANS TEMP      /AND/, THEN CHECK ACC
       SUB KK35      SUB ORIGINAL CONTENTS
       TZE B71+8     OK, PROCEED CHECK STORAGE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       CLA TEMP      CHECK STORAGE SHOULD
       SUB KK32        BE L+000000252525
       TZE B71+13    OK, IT WAS, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B72
       TRA B71
       REM
       REM
       REM           ORA TEST
B72    CLA ZERO      MAKE ACC ZERO
       ORA ONES      /OR/ WITH ONES
       PBT           CHECK P FOR ONE
       TRA B72+5     ERROR IN P
       TRA B72+7     CHECK OTHER POSITIONS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ADD ONE       CHECK OTHER POSITIONS
       ALS 2         CLEAR P AND Q
       TZE B72+12    OK, SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B73
       TRA B72
       REM
       REM
       REM           ORA TEST
B73    CAL ONES      MAKE ACC POS P-35 ONES
       ORA ZERO      /OR/ WITH ZEROS
       PBT           CHECK P FOR ONE
       TRA B73+5     ERROR IN P
       TRA B73+7     PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ADD ONE       OK, TEST POS 1-35
       ALS 2         MOVE OUT P AND Q
       TZE B73+12    OK, SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B74
       TRA B73
       REM
       REM
       REM           ORA TEST, SIGNS UNLIKE
B74    CLA KK36      MAKE ACC +252525252525
       ORA KK33      /OR/ -252525525252
       SUB KK37      SUB 252525777777
       PBT           CHECK P FOR ONE
       TRA B74+6     ERROR IN P
       TRA B74+8     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       ALS 2         MOVE OUT P AND Q
       TZE B74+12    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B75
       TRA B74
       REM
       REM
       REM           ORA TEST, SIGNS PLUS
B75    CLA KK36      MAKE ACC 252525252525
       ORA KK35      /OR/ +125252252525
       SUB KK38      SUB 377777252525
       TZE B75+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B76
       TRA B75
       REM
       REM
       REM           ORS TEST
B76    CLA ONES      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ONES
       CLA ZERO      MAKE ACC ZERO
       ORS TEMP      /OR/ TO ONES
       TZE B76+7     ACC SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       CLA TEMP      BRING BACK STORAGE
       ADD MONE      ADD MINUS ONE TO RIPPLE
       PBT           P SHOULD HAVE BIT
       TRA B76+12    ERROR, NO BIT IN P
       TRA B76+14    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B77
       TRA B76
       REM
       REM
       REM           ORS TEST
B77    CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ZEROS
       CAL ONES      CAL ALL ONES P-35
       ORS TEMP      /OR/ TO ZEROS
       ADD ONE       CHECK ACC, ADD ONE, SHOULD
       PBT             GET A BIT IN P
       TRA B77+9     OK, NOW CHECK STORAGE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       CLA TEMP      OK, NOW CHECK STORAGE
       ADD MONE      ADD MINUS ONE TO RIPPLE
       TOV B77+14    OK, SHOULD OVERFLOW
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B78
       TRA B77
       REM
       REM
       REM           ORA TEST, SIGNS UNLIKE
B78    CLA KK36      INITIALIZE TEMP STORAGE
       STO TEMP        WITH 252525252525
       CLA KK33      MAKE ACC-252525525252
       ORS TEMP      /OR/ TO TEMP STORAGE
       CLA TEMP      BRING TEMP TO ACC
       SUB KK37      SUB 252525777777
       TZE B78+9     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B79
       TRA B78
       REM
       REM
       REM           ORS TEST
B79    CLA KK36      INITIALIZE TEMP STORAGE
       STO TEMP        WITH +25252525252
       CAL KK31      MAKE P-35, -12525222525
       ORS TEMP      /OR/ TO TEMP STORAGE
       CLA TEMP      BRING IT TO ACC
       ADD KK38      ADD 3777777252525
       TZE B79+9     OK, SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B80
       TRA B79
       REM
       REM
       REM           TTR TEST , NOT IN TRAP MODE
B80    TOV B80+1     TURN OFF OVFL
       REM
       TTR B80+4     SHOULD TRAP TRANSFER
       PSE 114       DID NOT TRAP TRANSFER
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B81
       TRA B80
       REM
       REM           ETM- TEST TO SEE IF GET
B81    ETM             IN TRAP MODE
       CLA KK85      MAKE ADR AT ONE A TTR
       STO 1           TO B82
       CLA ZERO      CONDITION WILL BE MET
       TZE B81+5       AND SHOULD GO TO ONE
       LTM
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B82
       TRA B81
       REM
       REM
       REM           TTR TEST, IN TRAP MODE
B82    ETM
       TTR B83       SHOULD TTR TO B83
       LTM
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B83
       TRA B82
       REM
       REM
       REM
       REM           YES TRA IN TRAP MODE
B83    ETM
       CLA KK80      TTR TO B83+9, IS RETURN
       STO 1         ADDRESS AFTER TRAP.
       CLA KK81      HTR B84 IS IN ZERO, IF
       STO 0         INSTRUCTION COUNTER FAILS
       TRA B83+6     SHOULD NOT TRANSFER
       LTM
       PSE 114       TRAP FAILS, TRANSFERS
       HPR           ERROR STOP WITH TWO UP
       LTM           SHOULD TRAP AND RETURN HERE
       CLA 0         CHECK ADDRESS AT ZERO
       SUB KK82      SUB THE ADDRESS OF TRAP
       TZE B83+15    OK, SHOULD BE EQUAL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B84
       TRA B83
       REM
       REM
       REM           TEST CONDITIONAL TRANSFERS,
       REM             CONDITIONS NOT MET.
       REM             ADDRESS OF ERROR IS IN
B84    ETM             00000 OR TRAP ON PRINTOUT
       CLA KK83      LOC 1 SET TO TTR B84A
       STO 1         SHOULD BE NO TRANSFERS
       LDQ 8CF       MAKE MQ LARGER THAN ACC
       CLM           SET ACC TO ZERO AND SET
       STO 0           LOC 0 TO ZERO
       TNZ B84C
       TMI B84C
       TOV B84C
       TLQ B84C
       REM
       LXA ZERO,1    LOAD INDEX A WITH ZERO
       TXH B84C,1
       TIX B84C,1,8
       CLA ONES      LOAD ACC WITH ONES
       TZE B84C
       TPL B84C
       ALS 12        FORCE OVFL
       TNO B84C
       LXA 8CF,1     LOAD INDEX A WITH 77777
       TNX B84C,1,1
       TXL B84C,1,1
       LDQ MZE       LOAD MQ WITH MINUS ZERO
       TQP B84C
       TQP B84C      RETEST TO SEE IF TEST IS
       REM             COMPLETE. IF TRAP OCCURS,
       REM             COMES BACK HERE
       REM
B84A   LTM           LEAVES TRAP MODE
       CLA 0         CHECK ADDRESS AT ZERO
       SUB KK86      IS TEST COMPLETE
       TZE B84A+6    YES PROCEED
       PSE 114       NO, ERROR ABOVE, CHECK
       REM             ZERO ADDRESS
       HPR           ERROR STOP WITH TWO UP
       REM           CHECK ZERO ADDRESS
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B84B
       TRA B84
       REM
       REM
B84B   TRA B85
       REM
B84C   LTM           IF TRANSFER IS WRONG,
       REM             COMES HERE
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B85
       TRA B84
       REM
       REM           TEST CONDITIONAL TRANSFERS
       REM             WITH CONDITIONALS SATISFIED
       REM           THIS IS SET UP FOR
B85    ETM             TRAP RETURN
       CLA KK85A     INITIALIZE TEMP STORAGE
       STO TEMP        WITH LOC OF FIRST COND
       REM             TRANSFER
       CLA KK84      TTR B85+6
       STO 1
       TTR B85+15    OK, START TESTS
       CLA 0         RETURN FROM LOC 1
       CAS TEMP      COMPARE ACC AND TEMP
       TTR B85B      IF TEMP LESS THEN ZERO
       TTR B85+11    IF TEMP EQUAL TO ZERO
       TTR B85B      IF TEMP GRATER THEN ZERO
       ADD TWO       NOW ADVANCE TWO POSITIONS
       STA B85+14      SO AS TO CONTINUE TO THE
       REM             NEXT SUBTEST
       STA TEMP      RESET ADDRESS OF TEMP
       TTR 0
       REM
       REM
       ALS 50        CLEAR ACC
       TZE B85A      TZE TEST
       TTR B85A
       TPL B85A      TPL TEST
       TTR B85A
       TOV B85A      TOV TEST
       TTR B85A
       TNO B85A
       TTR B85A      TNO TEST
       LTM           TEST IS FINISED NOW
       TRA B86         GO TO NEXT SECTION
       REM
B85A   LTM           COMES HERE ON EROR
       PSE 114       ERROR, DID NOT TRAP
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B86
       TRA B85
       REM
       REM           COMES HERE IF ADDRESS AT
       REM           ZERO IS INCORRECT
       REM
B85B   LTM
       PSE 114       NOT JUMPING PROPERLY
       HPR           ERROR STOP WITH TWO UP
       REM
       REM
B86    ETM
       CLA KK85B     INITIALIZE TEMP STORAGE
       STO TEMP        WITH LOC OF FIRST COND
       REM             TRANSFER
       CLA ONES      BRING IN ALL ONES
       TMI B86A      TMI TEST
       TTR B86A
       TNZ B86A      TNZ TEST
       TTR B86A
       LTM           TEST IS FINISHED NOW
       TRA B87         GO TO NEXT SECTION
       REM
B86A   LTM           COMES HERE ON ERROR
       PSE 114       ERROR, DID NOT TRAP
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B87
       TRA B86
       REM
       REM
B87    ETM           TEST TQP, CONDITION
       REM             SATISFIED
       CLA KK85C     INITIALIZE TEMP STORAGE
       STO TEMP        WITH LOC OF FIRST COND
       REM             TRANSFER
       LDQ           LOAD MQ POS 35 WITH ONE
       TQP B87A      TEST TQP
       TTR B87A
       LTM           TEST IS FINISHED NOW
       TRA B88       GO TO NEXT SECTION
       REM
B87A   LTM
       PSE 114       ERROR, DID NOT TRAP
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B88
       TRA B87
       REM
       REM           CHECK ADDRESS AT ZERO
       REM             FOR LOCATION OF LAST INST
B88    ETM             PREFORMED CORRECTLY
       CLA KK85D     INITIALIZE TEMP STORAGE
       STO TEMP        WITH LOC OF FIRST COND
       REM             TRANSFER
       TXI B88A,1,9  TXI TEST
       TTR B88A
       TXH B88A,1    TXH TEST
       TTR B88A
       TXL B88A      TXL TEST
       TTR B88A
       TIX B88A,1,1  TIX TEST
       TTR B88A
       TNX B88A,1,-1  TNX TEST
       TTR B88A
       TSX B88A,1    TSX TEST
       TTR B88A
       LTM           TEST IS FINISHED
       TRA B88A+3    GO TO NEXT SECTIONS
       REM
B88A   LTM           COMES HERE ON ERROR
       PSE 114       ERROR, DID NOT TRAP
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B89
       TRA B88
       REM
       REM
       REM           PSE TEST
B89    CLA END+2     RESET POST RESTART
       STO 0
       PSE 96        TURN OFF ALL SENSE LIGHTS
       MSE 97        TEST LIGHT ONE
       TRA B89+7     OK, OFF
       PSE 114       ERROR, LIGHT WAS ON
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B90
       TRA B89
       REM
       REM           PSE TEST
B90    MSE 98        TEST LIGHT TWO
       TRA B90+4     OK, PROCEED
       PSE 114       ERROR, LIGHT WAS ON
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B91
       TRA B90
       REM
       REM           PSE TEST
B91    MSE 99        TEST LIGHT THREE
       TRA B91+4     OK, PROCEED
       PSE 114       ERROR, LIGHT WAS ON
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B92
       TRA B91
       REM
       REM           PSE TEST
B92    MSE 100       TEST LIGHT FOUR
       TRA B92+4     OK, PROCEED
       PSE 114       ERROR, LIGHT WAS ON
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B93
       TRA B92
       REM
       REM
       REM           PSE TEST
B93    PSE 97        TURN ON LIGHT ONE
       MSE 97        TEST LIGHT ONE
       TRA B93+4     ERROR, IT WAS NOT ON
       TRA B93+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B94
       TRA B93
       REM
B94    PSE 98        TURN ON LIGHT TWO
       MSE 98        TEST LIGHT TWO
       TRA B94+4     ERROR, IT WAS NOT ON
       TRA B94+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B95
       TRA B94
       REM
       REM
B95    PSE 99        TURN ON LIGHT THREE
       MSE 99        TEST LIGHT THREE
       TRA B95+4     ERROR, IT WAS NOT ON
       TRA B95+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B96
       TRA B95
       REM
       REM
B96    PSE 100       TURN ON LIGHT FOUR
       MSE 100       TEST LIGHT FOUR
       TRA B96+4     ERROR, IT WAS NOT ON
       TRA B96+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B93A
       TRA B96
       REM
       REM
       REM           MSE TEST, TEST ALL LIGHTS
       REM           ARE OUT
B93A   MSE 97        TEST LIGHT ONE
       TRA B93A+4    SHOULD BE OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       MSE 98        TEST LIGHT TWO
       TRA B93A+8    SHOULD BE OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       MSE 99        TEST LIGHT THREE
       TRA B93A+12   SHOULD BE OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       MSE 100       TEST LIGHT FOUR
       TRA B93A+16   SHOULD BE OFF
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B96A
       TRA B93A
       REM
       REM
       REM           NOP TEST TO SEE IF NOP IS
B96A   PSE 96          INTERPRETED AS PSE
       NOP 97
       MSE 97
       TRA B96A+6    GO ON TO NEXT SECTION
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B97
       TRA B96A
       REM
       REM
       REM           STZ TEST
B97    CLA ONES      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ONES
       LDQ ONES      IN CASE OF FAULTY STO INST,
       REM           HAVE ONES IN MQ AND ACC
       STZ TEMP      STORE ZEROS IN TEMP
       CLA TEMP      SEE IF IT IS NOW ZERO
       TZE B97+8     OK, CHECK SIGN
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
       TPL B97+11    OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B98
       TRA B97
       REM
       REM
       REM           SENSE SWITCH TEST
B98    CLA KK87      PLACE TRA B98A+1 IN B98A
       STO B98A        FOR FIRST TIME THROUGH,
       REM             CHANGES ON SECOND TIME
       REM             THROUGH, EACH SWITCH IS
       REM             REPRESENTED IN MQ AND ACC
       REM             BY GROUP OF SIX BITS
       CLA ZERO      CLEAR ACC
       PSE 113       SW 1
       TRA B98+6     DOWN L -370000000000
       CLA SW1       UP
       PSE 114       SW 2
       TRA B98+9     DOWN L+007700000000
       ORA SW2       UP
       PSE 115       SW 3
       TRA B98+12    DOWN L +000077000000
       ORA SW3       UP
       PSE 116       SW 4
       TRA B98+15    DOWN L +000000770000
       ORA SW4       UP
       PSE 117       SW 5
       TRA B98+18    DOWN L +000000007700
       ORA SW5       UP
       PSE 118       SW 6
       TRA B98+21    UP
       ORA SW6       DOWN L +000000000077
       REM
       NOP 118       TEST, SEE IF NOP INTERPRETED
       REM             AS PSE. IF SW6 UP, NOT
       REM             CONCLUSIVE
       TRA B98A      SENSE SWITCH TEST
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM
B98A   TRA B98A+1
       STO TEMP
       LDQ TEMP
       CLA KK88      RESET SWITCH TO COMPARE
       STO B98A        TO SEE IF AGREE SECOND
       REM             TIME
       TRA B98+2     REPEAT B98 ONCE
       REM
B98B   SUB TEMP      SUBT FIRST RESULT FROM 2ND
       TZE B98B+4    OK, PROCEED
       PSE 114       ERROR IS SHOWN BY COMPARING
       HPR             ACC RESULTS WITH MQ. IF
       PSE 113         SWITCH WAS UP, ITS
       TRA M06       RESPECTIVE PART OF ACC
       TRA B98         SHOULD BE OFF. IF SWITCH
       REM             WAS DOWN, THIS PART
       REM             SHOULD BE ON
       REM           ADDER TEST
M06    CLA ZERO      CLEAR ACCUMULATOR
       COM
       ADD ONE       L +1  RIPPLE CARRY
       TZE M06+6
       PSE 114       ON ERROR THE RIGHT MOST
       HPR           ONE OR LEFT MOST ZERO
       REM           IS ADDER THAT FAILED
       PSE 113
       TRA M06+9
       TRA M07
       TOV M06+12    OVFL SHOULD BE ON
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA M07
       TRA M06
       REM
       REM
       REM           ADDER TEST
M07    CAL ONES      ONES INTO P,1-35
       ACL ONES      ONES INTO P,1-35
       SLW TEMP
       CLA TEMP
       SUB ONES      ONES
       TZE M07+8
       PSE 114       THE RIGHTMOST ONE OR THE
       HPR           LEFTMOST ZERO WILL
       PSE 113       INDICATE WHICH ADDER
       TRA AAA       FAILED. SIGN POSITION
       TRA M07       CORRESPONDS TO P ADDER
       REM           POSITION
       REM
AAA    SWT 5         PERFORM OR BYPASS ADDER
       REM           TEST AND DVH, BYPASS
       REM           HALTS NEXT PASS
       TRA END       BYPASS ALL HALT
       CLA PLUS+6    INSERT TRA TO BY PASS
       STO AAA+2     HALTS ON NEXT PASS
       REM           DVH TEST WITH HALT
B59    CLA ONE       BRING ONE IN ACC
       DVH ZERO      DIVIDE BY ZERO, SHOULD
       SUB ONE         HALT WITH DCT ON
       TZE B59+6     RESULT SHOULD BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B60
       TRA B59
       REM
       REM
       REM           DVH TEST, WITH HALT
B60    CLA ONE       DIVIDE ACC BY EQUAL AND
       DVH ONE         STORE, SHOULD HALT
       SUB ONE       TEST ACC SHOULD BE ONE
       TZE B60+6     OK, PROCEED
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA B61
       TRA B60
       REM
       REM
       REM           DVH TEST, WITH HALT
B61    CLA PTW       PLACE BIT IN Q POSITION
       ALS 2           SO ACC GREATER THEN STO
       DVH PTW       SHOULD HALT
       TNZ B61+6     OK, SHOULD NOT BE ZERO
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA ADD
       TRA B61
       REM
       REM
       REM
       REM           ADDER TEST
ADD    LXA 1CF,2     L 7777
       CLA 4095,2    BRING IN LOC STORAGE
       COM
       ADD 4095,2    MAKE ALL ONES
       TOV ADD+5     TURN OFF OVFL
       TPL PLUS
       TMI MINUS
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM           SIGN ERROR
       REM
MINUS  SUB ONE       FORCE RIPPLE
       TZE OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA OVFL
       TRA ADD
PLUS   ADD ONE       FORCE RIPPLE
       TZE OVFL
       PSE 114       TEST SENSE SWITCH TWO
       HPR           ERROR STOP WITH TWO UP
       REM           FAILURE ON TZE INST.
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA OVFL
       TRA ADD
       REM
       REM
OVFL   TNO SS        TEST OVFL SHOULD BE ON
       TOV SS1       SHOULD BE OFF NOW
       CLA 4095,2    BRING IN LOC
       CAS 4095,2    COMPARE TO STORAGE
       TRA TT        MEMORY LESS
       TRA LOOP     OK
       TRA TT1       MEMORY HIGH
       REM
SS     PSE 114       OVFL SHOULD BE ON
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA OVFL+2
       TRA ADD
       REM
SS1    PSE 114       TNO DID NOT TURN OFF OVFL
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA OVFL+2
       TRA ADD
TT     PSE 114       MEMORY LESS
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA LOOP
       TRA ADD
       REM
TT1    PSE 114       MEMORY HIGH
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA LOOP
       TRA ADD
       REM
LOOP   TIX ADD+1,2,1
       TRA MPY
       REM
       REM
       REM           MPY TEST
MPY    LXA 1CF,2     L 7777
       LXA MPY+3,1   L 35
       LDQ ONE
       RQL 35,1
       STQ TEMP      SAVE BIT
       MPY 4095,2    MPY BY LOC
       LRS 35,1
       TZE MPY+10
       PSE 114       HIGH ORDER PRODUCT ERROR
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA MPY+13
       TRA MPY
       REM
       STQ TEMP+1
       CLA TEMP+1
       SUB 4095,2    SUB LOC
       TZE MPY+19
       PSE 114       LOW ORDER PRODUCT ERROR
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA MPY+22
       TRA MPY
       REM
       TIX MPY+2,1,1
       TIX MPY+1,2,1
       TRA DVP
       REM
       REM
       REM
       REM           MPY AND DVP ALL ONES
       REM
DVP    LXA 1CF,1     L 7777
       LDQ 4095,1    LDQ WITH LOC
       MPY ONE
       DVP ONE
       TZE DVP+7
       PSE 114       HIGH ORDER ERROR
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA DVP+10
       TRA DVP
       REM
       STQ TEMP
       CLA 4095,1    BRING IN LOC TO ACC
       SUB TEMP
       TZE DVP+16
       PSE 114       LOW ORDER ERROR
       HPR           ERROR STOP WITH TWO UP
       PSE 113       TEST SWITCH ONE TO LOOP
       TRA DVP+19
       TRA DVP
       REM
       TIX DVP+1,1,1 LOOP
       TRA END
       REM
       REM
       REM
       REM           END OF TEST
       REM
       REM
END    SWT 6         SENSE SW 6 UP
       TRA *+2       READ IN NEXT PROGRAM
       TRA 24        REPEAT PROGRAM
       REM
       REM
C      RCDA          SELECT CARD READER
       RCHA *+3
       LCHA 0
       TRA 1
       MON 0,0,3     S AND 2 ON, COUNT 3
       REM
       REM
       REM
       REM CONSTANTS
       REM
ZERO   OCT 0
ONE    OCT 1
TWO    OCT 2
THREE  OCT 3
FOUR   OCT 4
FIVE   OCT 5
ONES   OCT 777777777777
1CF    OCT 7777
8CF    OCT 77777
MTW    MTW
PTW    PTW
TEMP   OCT 0
       OCT 0
PONES  OCT 377777777777
MON    MON
MZE    MZE
PTHR   OCT 100000000000
MONE   OCT -000000000001
M2     OCT -000000000002
M3     OCT -000000000003
KK30   OCT -252525252525
KK31   OCT -125252252525
KK32   OCT +000000252525
KK33   OCT -252525525252
KK34   OCT 252525000000
KK35   OCT +125252252525
KK36   OCT +252525252525
KK37   OCT 252525777777
KK38   OCT +377777252525
RTN    TRA B20+7
       TRA B20+5
KK80   TTR B83+9     SEE SECTION
KK81   HTR B84       B83 FOR USE
KK82   HTR B83+5     OF THESE ,KK 80,81,82
KK83   TTR B84A
KK84   TTR B85+6
KK85   TTR B82
KK85A  HTR B85A-10
KK85B  HTR B86+4
KK85C  HTR B87+4
KK85D  HTR B88+3
KK86   HTR B84A-1
KK87   TRA B98A+1
KK88   TRA B98B
SW1    OCT -370000000000
SW2    OCT +007700000000
SW3    OCT +000077000000
SW4    OCT +000000770000
SW5    OCT +000000007700
SW6    OCT +000000000077
       END
