                                                             9M02A          
                                                            7/1/58         
       REM 9M02           
       REM            
*INDICATOR TESTS,TIMING TEST FOR MPY WITH ZERO MULTIPLICAND,DISPLAY
*BUTTON TESTS AND ADDITIONAL TESTS FOR INSTRUCTIONS CHECKED IN 9M01
       REM            
       ORG 1          
       REM
*FALSE TRAP ROUTINE TO ADJUST DEPR AND RETURN TO PROGRAM
       REM
       LTM           LEAVE TRAP MODE
       SLW TEMP+2    SAVE ACCUMULATOR
       CLA TR        PUT BIT IN DEPR TO
       STO LOC+3     SHOW TRAP TRGR ON
       CLA           L CONTENTS LOC 00000
       ADD            
       STA *+1        
       TRA           RETURN TO PROGRAM
       REM            
       ORG 24         
       REM            
       SWT 3         TEST SENSE SWITCH 3
       TRA ID        IDENTIFY PROGRAM
       REM            
       TSX STORE,4   TO RESET START
       REM            
       CLA TR+1      L HTR THREE
       STA 6         ADJUST LOC 00006
       REM            
 START TRA *+2        
       REM            
       REM            
       BCD 1PAI      TEST-PLACE ACC IN IND
       REM           AND PLACE IND IN ACC
 D     CAL ONES      L ALL ONES
       TSX ENTM,2    TEST PRI OP 0,4 NO TRAP
       PAI           ALL INDICATORS ON
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM           FXIT TRAP MODE
       SLW TEMP+2    SAVE ACCUMULATOR
       CLA           L CONTENTS LOC 00000
       LDQ END+1     L TRA START-3
       CAS END+1      
       TRA *+2       ERROR
       TRA *+4       OK
       TSX ERROR-1,4  
       TRA D          
       REM            
       TSX STORE,4   TO RESTORE RESET START
       CAL TEMP+2    RESTORE ACCUMULATOR
       REM            
       CLA ZERO      CLEAR ACCUMULATOR
       PIA           BITS IN P, 1 THRU 35 IN ACC
       PBT            
       TRA *+2       ERROR
       TRA DA        OK SHOULD HAVE P BIT
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA D         REPEAT SECTION
       REM            
 DA    ARS 1         CLEAR P
       CHS           ACC NOW MINUS ALL ONES
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES       
       TRA DA+6      ERROR
       TRA DA+7      OK ALL IND ON
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA D         REPEAT TEST
       REM            
       REM            
       BCD 1PIA       
 D1    CLA ZERO      L +0
       PAI           ALL INDICATORS OFF
       TSX ENTM,2    TEST PRI OP 04 NO TRAP
       PIA            
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM           EXIT TRAP MODE
       SLW TEMP+2    SAVE ACCUMULATOR
       CLA           L CONTENTS LOC 00000
       LDQ END+1     L TRA START-3
       CAS END+1      
       TRA *+2       ERROR
       TRA *+4       OK
       TSX ERROR-1,4  
       TRA D1         
       REM            
       TSX STORE,4   TO RESTORE RESET START
       CAL TEMP+2    RESTORE ACCUMULATOR
       REM            
       TZE *+2       OK-IND OFF
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA D1        REPEAT TEST
       REM            
       REM            
       BCD 1IIA      TEST-INVERT IND FROM ACC
 D2    CAL ONES      L ALL ONES
       LXA K26,1     L +50 IN XRA
       PAI           ALL INDICATORS ON
       TSX ENTM,2    TEST PRI OP 0,4 NO TRAP
       IIA           ALTERNATE INDICATORS
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA D2         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       TIX D2+3,1,1   
       REM            
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONE TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA D2         REPEAT SECTION
       REM            
       REM            
       BCD 1IIS       
 D2A   CAL ONES       L ALL ONES
       SLW TEMP       SAVE ACCUMULATOR
       LXA K26,1      L +50 IN XRA
       PAI            ALL IN ON
       IIS TEMP       
       TIX D2A+4,1,1  ALTERNATE IND
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA D2A+13     ERROR
       TRA D2A+14     OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA D2A        REPEAT TEST
       REM            
       REM            
       BCD 1IIS       
 D2B   CAL ONES       L ALL ONES
       SLW TEMP       SAVE ACCUMMULATOR
       LXA K26,1      L +50 IN XRA
       PAI            IND ON
       IIA            IND OFF
       IIS TEMP       IND ON
       TIX D2B+4,1,1  ALTERNATE IND
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA D2B+14     ERROR
       TRA D2B+15     OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA D2B        REPEAT TEST
       REM            
       REM            
       BCD 1RIS       TEST-RESET IND FROM STG
 E     CAL ONES       L ALL ONES
       PAI            SET INDICATORS ON
       RIS ONES       RESET ALL IND OFF
       PIA            SET INDICATORS INTO ACC
       TZE E+6        OK-IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E          REPEAT TEST
       REM            
       REM            
       BCD 1RIS       
 E1    CAL ONES       L ALL ONES
       PAI            TURN ALL INDICATOR ON
       RIS ZERO       IND NOT RESET
       PIA            SET TGRS INTO ACC
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E1+10      ERROR
       TRA E1+11      OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E1         REPEAT TEST
       REM            
       REM            
       BCD 1RIA       TEST-RESET IND FROM ACC
 E2    CAL ONES       L ALL ONES
       PAI            SET INDICATOR ALL ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       RIA            RESET ALL INDICATORS OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA E2         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            CHECK INDICATORS OFF
       TZE *+2        OK-IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E2         REPEAT TEST
       REM            
       REM            
       BCD 1RIA       
 E3    CAL ONES       L ALL ONES
       PAI            TURN ON ALL INDICATORS
       CLA ZERO       L +0
       RIA            SHOULD NOT RESET
       PIA            IND TO ACC AND CHECK
       SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP       L SAVED ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E3         REPEAT TEST
       REM            
       REM            
       BCD 1STI       TEST-STORE INDICATORS
 E3A   CLA ZERO       L +0
       PAI            TURN ALL INDICATORS OFF
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       TZE E3A+6      OK-IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E3A        REPEAT TEST
       REM            
       REM            
       BCD 1STI       
 E3B   CAL ONES       L ALL ONES
       PAI            TURN ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E3B+8      ERROR
       TRA E3B+9      OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E3B        REPEAT TEST
       REM            
       REM            
       BCD 1STI       
 E3C   CLA K25        L +154321654321
       PAI            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ K25        L +154321654321
       CAS K25        
       TRA E3C+8      ERROR
       TRA E3C+9      OK-CORRECT IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E3C        REPEAT TEST
       REM            
       REM            
       BCD 1OAI       TEST-OR ACC TO INDICATORS
 E4    CAL ONES       L ALL ONES
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       OAI            TURN ALL INDICATORS ON
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA E4         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       SLW TEMP+1     SAVE ACCUMULATOR
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA E4A        OK ALL IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E4         REPEAT SECTION
       REM            
 E4A   CLA TEMP+1     CHECK SAVED ACCUMULATOR
       CAS ONES       
       TRA E4A+4      ERROR
       TRA E4A+5      OK ACC UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E4         REPEAT TEST
       REM            
       REM            
       BCD 1OAI       
 E5    CAL ONES       L ALL ONES
       OAI            TURN ALL INDICATORS ON
       CLA ZERO       L +0
       OAI            ALL INDICATORS STILL ON
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E5+11      ERROR
       TRA E5+12      OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E5         
       REM            
       REM            
       BCD 1OAI       
 E6    CAL ONES       L ALL ONES
       PAI            ALL IND ON
       RIA            TURN ALL INDICATORS OFF
       CLA K24        L +111111111111
       OAI            TURN 12 INDICATORS ON
       STO TEMP       SAVE ACCUMULATOR
       PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA E6+11      ERROR
       TRA E6A        OK-CORRECT 12 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E6         REPEAT SECTION
       REM            
 E6A   ALS 1          ACC NOW +222222222222
       OAI            IND 333333333333
       STO TEMP+1     SAVE ACCUMULATOR
       PIA            IND TO ACC AND CHECK
       LDQ K28        L +333333333333
       CAS K28        
       TRA E6A+8      ERROR
       TRA E6B        OK-CORRECT 24 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E6         REPEAT SECTION
       REM            
 E6B   CLA K24        L +111111111111
       ALS 2          ACC +P044444444444
       OAI            IND 777777777777
       SLW TEMP+2     SAVE ACCUMULATOR
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E6B+11     ERROR
       TRA E6C        OK-ALL IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E6         REPEAT SECTION
       REM            
       REM CHECK ACCS UNCHANGES
       REM            
 E6C   CLA TEMP       L +111111111111
       ADD TEMP+1     L +222222222222
       SUB TEMP+2     L -044444444444
       CHS            ACC NOW -377777777777
       CAS ONES       
       TRA E6C+7      ERROR
       TRA E6C+8      OK-ACCS UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E6         REPEAT TEST
       REM            
       REM            
       BCD 1OAI       RIPPLE TEST
 E6D   LDI ZERO       ALL INDICATORS OFF
       LXD K37A,1     L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       OAI            TURN TESTED IND ON
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA E6D        REPEAT SECTION
       REM            
       CAL TEMP       L LAST POSITION TESTED
       IIA            TURN TESTED IND OFF
       ALS 1          RIPPLE 1 POSITION
       TIX E6D+3,1,1  REPEAT FOR EVERY IND POS
       REM            
*      CHECK NO EFFECT WITH Q BIT
       REM            
       OAI            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK-NO EFFECT WITH Q BIT
       TSX ERROR,4    ERROR
       TSX OK,4       CONTINUE TEST
       TRA E6D        REPEAT TEST
       REM            
       REM            
       BCD 1OAI       TEST-OAI WITH SIGN BIT
 E6D1  LDI ZERO       ALL INDICATORS OFF
       CLA MZE        L -0
       OAI            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK
       TSX ERROR,4    ERROR
       TSX OK,4       CONTINUE TEST
       TRA E6D1       REPEAT TEST
       REM            
       REM            
       BCD 1OSI       TEST OR STORAGE TO IND
 E7    OSI ONES       ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E7+7       ERROR
       TRA E7+8       OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E7         TEST
       REM            
       REM            
       BCD 1OSI       
 E8    CAL ONES       L ALL ONES
       OAI            TURN ALL INDICATORS ON
       OSI ZERO       ALL INDICATORS STILL ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E8+9       ERROR
       TRA E8+10      OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E8         REPEAT TEST
       REM            
       REM            
       BCD 1OSI       
 E9    CAL ONES       L ALL ONES
       PAI            ALL IND ON
       RIA            TURN ALL INDICATORS OFF
       OSI K24        IND 111111111111
       PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA E9+9       ERROR
       TRA E9A        OK-CORRECT 12 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E9         REPEAT SECTION
       REM            
 E9A   OSI K27        IND 333333333333
       PIA            IND TO ACC AND CHECK
       LDQ K28        L +333333333333
       CAS K28        
       TRA E9A+6      ERROR
       TRA E9B        OK-CORRECT 24 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E9         REPEAT SECTION
       REM            
 E9B   OSI K29        ALL IND ON
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E9B+8      ERROR
       TRA E9C        OK-ALL IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E9         REPEAT SECTION
       REM            
       REM CHECK STORAGES UNCHANGED
       REM            
 E9C   CLA K24        L +111111111111
       ADD K27        L +222222222222
       SUB K29        L -044444444444
       CHS            ACC NOW MINUS ALL ONES
       CAS ONES       
       TRA E9C+7      ERROR
       TRA E9C+8      OK-STORAGES UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E9         REPEAT TEST
       REM            
       REM            
       BCD 1OSI       RIPPLE TEST
 E9D   LDI ZERO       ALL INDICATORS OFF
       LXD K37A,1     L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       OSI TEMP       TURN TESTED IND ON
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA E9D        REPEAT SECTION
       REM            
       CAL TEMP       L LAST POSITION TESTED
       IIA            TURN TESTED IND OFF
       ALS 1          RIPPLE 1 POSITION
       TIX E9D+3,1,1  REPEAT FOR EVERY IND POS
       TSX OK,4       
       TRA E9D        
       REM            
       REM            
       BCD 1PAI       TEST PLACE ACC IN IND
 E10   CAL ONES       L ALL ONES
       PAI            TURN ALL INDICATORS ON
       SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP       CHECK ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E10+8      ERROR
       TRA E10A       OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E10        REPEAT SECTION
       REM            
 E10A  STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       CAS ONES       
       TRA E10A+5     ERROR
       TRA E10A+6     OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E10        REPEAT TEST
       REM            
       REM            
       BCD 1PAI       
 E11   CLA ZERO       L +0
       PAI            ALL INDICATORS OFF
       TZE E11A       OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E11        REPEAT SECTION
       REM            
 E11A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       TZE E11A+4     OK-IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E11        REPEAT TEST
       REM            
       BCD 1PAI       RIPPLE TEST
 E11B  LXD K37A,1     L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       PAI            
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA E11B       REPEAT SECTION
       REM            
       CAL TEMP       L LAST POSITION TESTED
       IIA            TURN OFF IND TESTED
       ALS 1          RIPPLE 1 POSITION
       TIX E11B+2,1,1 REPEAT FOR EACH IND POS
       REM            
*      CHECK NO EFFECT WITH Q BIT
       REM            
       PAI            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK-NO EFFECT WITH Q BIT
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E11B       REPEAT TEST
       REM            
       REM            
       BCD 1PAI       TEST-PAI WITH SIGN BIT
 E11B1 CLA ONES       L ALL ONES
       PAI            IND 37777777777
       PIA            IND TO ACC AND CHECK
       CHS            ACC NOW MINUS ALL ONES
       CAS ONES       
       TRA *+2        ERROR
       TRA *+3        OK
       LDQ ONES       L ALL ONES TO MQ
       TSX ERROR,4    ERROR
       TSX OK,4       CONTINUE TEST
       TRA E11B1      REPEAT TEST
       REM            
       REM            
       BCD 1LDI       TEST-LOAD INDICATORS
 E12   LDI ONES       ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E12+7      ERROR
       TRA E12+8      OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E12        REPEAT TEST
       REM            
       REM            
       BCD 1LDI       
 E13   LDI ZERO       ALL INDICATORS OFF
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       TZE E13+5      OK IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E13        REPEAT TEST
       REM            
       REM            
       BCD 1PIA       TEST-PLACE IND IN ACC
 E14   CLA ZERO       L +0
       PAI            TURN ALL INDICATORS OFF
       TZE E14A       OK ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E14        REPEAT SECTION
       REM            
 E14A  PIA            IND TO ACC AND CHECK
       TZE E14A+3     OK IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E14        REPEAT TEST
       REM            
       REM            
       BCD 1PIA       
 E15   LDI ONES       ALL INDICATORS ON
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW -377777777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E15+8      ERROR
       TRA E15+9      OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E15        REPEAT TEST
       REM            
       REM            
       BCD 1PIA       
 E16   CLA K3         L-377777077777
       PAI            IND 377777077777
       PIA            ACC +377777077777
       CHS            ACC NOW -377777077777
       LDQ K3         L -377777077777
       CAS K3         
       TRA E16+8      ERROR
       TRA E16+9      OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E16        REPEAT TEST
       REM            
       REM            
       BCD 1IIA       TEST-INVERT INDICATORS
       REM            
 E20   CAL ONES       L ALL ONES
       PAI            ALL INDICATORS ON
       IIA            ALL INDICATORS OFF
       PIA            IND TO ACC AND CHECK
       TZE E20+6      OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E20        REPEAT TEST
       REM            
       REM            
       BCD 1IIA       
 E21   LDI ZERO       ALL INDICATORS OFF
       CAL ONES       L ALL ONES
       IIA            ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       SLW TEMP+1     SAVE ACCUMULATOR
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E21+10     ERROR
       TRA E21A       OK-ALL IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E21        REPEAT SECTION
       REM            
 E21A  CLA TEMP+1     CHECK SAVED ACCUMULATOR
       CAS ONES       
       TRA E21A+4     ERROR
       TRA E21A+5     OK-ACC UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E21        REPEAT TEST
       REM            
       REM            
       BCD 1IIA       
 E22   CAL ONES       L ALL ONES
       LDI ZERO       ALL INDICATORS OFF
       IIA            ALL INDICATORS ON
       IIA            ALL INDICATORS OFF
       IIA            ALL INDICATORS ON
       IIA            ALL INDICATORS OFF
       PIA            IND TO ACC AND CHECK
       TZE E22+9      OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E22        REPEAT TEST
       REM            
       REM            
       BCD 1IIA       RIPPLE TEST
 E22A  LXD K37A,1     L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       LDI TEMP       TURN ON IND TESTING
       IIA TEMP       TURN OFF IND TESTING
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA E22A       REPEAT SECTION
       REM            
       CAL TEMP       L LAST TESTED POSITION
       ALS 1          RIPPLE 1 POSITION
       TIX E22A+2,1,1 CHECK EACH IND POS
       REM            
*      CHECK NO EFFECT WITH Q BIT
       REM            
       IIA            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E22A       REPEAT TEST
       REM            
       REM            
       BCD 1IIA       TEST-IIA WITH SIGN BIT
 E22A1 LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       IIA            
       PIA            IND TO ACC AND CHECK
       ARS 2          ACC NOW +100000000000
       CAS PTHR       
       TRA *+2        ERROR
       TRA *+3        OK
       LDQ PTHR       L +100000000000
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E22A1      REPEAT TEST
       REM            
       REM            
       BCD 1IIS       TEST-INVERT INDICATORS
       REM            FROM STORAGE
 E23   LDI ONES       ALL INDICATORS ON
       IIS ONES       ALL INDICATORS OFF
       PIA            IND TO ACC ANCHE CHECK
       TZE E23+5      OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E23        REPEAT TEST
       REM            
       REM            
       BCD 1IIS       
 E24   LDI ZERO       ALL INDICATORS OFF
       IIS ONES       ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E24+8      ERROR
       TRA E24+9      OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E24        REPEAT TEST
       REM            
       REM            
       BCD 1IIS       
 E25   LDI ONES       ALL INDICATORS ON
       IIS ONES       INDICATORS OFF
       IIS ONES       INDICATORS ON
       IIS ONES       INDICATORS OFF
       IIS ONES       INDICATORS ON
       IIS ONES       INDICATORS OFF
       PIA            IND TO ACC AND CHECK
       TZE E25+9      OK-ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E25        REPEAT TEST
       REM            
       REM            
       BCD 1IIS       RIPPLE TEST
 E25A  LDI ZERO       ALL INDICATORS OFF
       LXD K37A,1     L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       IIS TEMP       TESTED INDICATOR ON
       IIS TEMP       TESTED INDICATOR OFF
       PIA            IND TO ACC AND CHECK
       TZE *+3        
       TSX ERROR-1,4  
       TRA E25A       REPEAT SECTION
       REM            
       CAL TEMP       L LAST POSITION TESTED
       ALS 1          RIPPLE 1 POSITION
       TIX E25A+3,1,1 CHECK EACH IND POS
       TSX OK,4       
       TRA E25A       
       REM            
       REM            
       BCD 1TIF       TEST-TRANSFER WHEN IND OFF
 E26   LDI ONES       ALL INDICATORS ON
       CAL ONES       L ALL ONES
       TIF E26+4      NG ALL IND SHOULD BE ON
       TRA E26A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E26        REPEAT SECTION
       REM            
 E26A  ARS 1          CHECK ACC-CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E26A+6     ERROR
       TRA E26A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E26        REPEAT SECTION
       REM            
       REM            
 E26A1 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       CAS ONES       
       TRA E26A1+5    ERROR
       TRA E26A1+6    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E26        REPEAT TEST
       REM            
       REM            
       BCD 1TIF       
 E27   LDI ONES       ALL INDICATORS ON
       CLA ZERO       L +0
       TIF E27A       IND UNEXAMINED-TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E27        REPEAT SECTION
       REM            
 E27A  TZE E27A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E27        REPEAT SECTION
       REM            
 E27A1 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E27A1+6    ERROR
       TRA E27A1+7    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E27        REPEAT TEST
       REM            
       REM            
       BCD 1TIF       
 E28   LDI ZERO       ALL INDICATORS OFF
       CAL ONES       L ALL ONES
       TIF E28A       IND OFF-TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E28        REPEAT SECTION
       REM            
 E28A  SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP       CHECK ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E28A+6     ERROR
       TRA E28A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E28        REPEAT SECTION
       REM            
 E28A1 PIA            IND TO ACC AND CHECK
       TZE E28A1+3    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E28        REPEAT TEST
       REM            
       BCD 1TIF       
 E29   LDI ZERO       ALL INDICATORS OFF
       CLA ZERO       L +0
       TIF E29A       IND UNEXAMINED -TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E29        REPEAT SECTION
       REM            
 E29A  TZE E29A1      OK ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E29        REPEAT SECTION
       REM            
 E29A1 PIA            IND TO ACC AND CHECK
       TZE E29A1+3    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E29        REPEAT TEST
       REM            
       REM            
       BCD 1TIF       
 E30   LDI K24        L +111111111111
       CAL K29        L -044444444444
       TIF E30A       OK EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
 E30A  SLW TEMP       SAVE ACCUMULATOR
       CLA K28        L+333333333333
       TIF E30A+4     NG IND NOT ALL OFF
       TRA E30A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
 E30A1 STO TEMP+1     SAVE ACCUMULATOR
       CLA K27        L+222222222222
       TIF E30A2      OK EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
 E30A2 STO TEMP+2     SAVE ACCUMULATOR
       CLA K24        L+111111111111
       TIF E30A2+4    NG EXAMINED IND ON
       TRA E30A3      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
 E30A3 PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA E30A3+5    ERROR
       TRA E30A4      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
       REM CHECK ACCS UNCHANGED
       REM            
 E30A4 ADD TEMP+2     L +222222222222
       SUB TEMP+1     L +333333333333
       ADD TEMP+1     
       SUB TEMP       L -044444444444
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E30A4+9    ERROR
       TRA E30A4+10   OK-ACCS UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E30        REPEAT TEST
       REM            
       REM            
       BCD 1TIF       TEST-TRANSFER WHEN
       REM            INDICATORS OFF-RIPPLE TEST
 E30B  LDI ONES       ALL INDICATORS ON
       TOV E30B+2     TURN OFF OVERFLOW LITE
       CAL ONES       L ALL ONES
       IIA            EXAMINED IND OFF
       TIF E30C       EXAMINED IND OFF-TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30B       REPEAT SECTION
       REM            
 E30C  IIA            PUT INDICATOR ON AGAIN
       ALS 1          RIPPLE ONE POSITION
       PBT            
       TOV E30C+5     EVERY POSITION IS TESTED
       TRA E30B+3     REPEAT FOR EACH POSITION
       REM            
       ALS 1          
       TZE E30D       OK ACC CLEAR
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30B       REPEAT SECTION
       REM            
 E30D  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E30D+6     ERROR
       TRA E30D+7     OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E30B       REPEAT TEST
       REM            
       REM            
       BCD 1TIF       TEST-TRANSFER WHEN
       REM            INDICATORS OFF, RIPPLE TEST
 E30D1 LDI ZERO       ALL INDICATORS OFF
       TOV E30D1+2    TURN OFF OVERFLOW LITE
       CLA ONE        L +1
       PAI            ACC TO IND
       TIF E30D1+6    ERROR-EXAMINED IND ON
       TRA E30E       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30D1      REPEAT SECTION
       REM            
 E30E  ALS 1          RIPPLE ONE POSITION
       PBT            
       TOV *+2        ALL POSITION TESTED
       TRA E30D1+3    REPEAT FOR EACH POSITION
       TSX OK,4       
       TRA E30D1      
       REM            
       REM            
       BCD 1TIO       TEST-TRANSFER WHEN IND ON
 E31   LDI ONES       ALL INDICATORS ON
       TOV E31+2      TURN OFF OVERFLOW LITE
       CLA ONE        L +1
       LXD K37A,1     L +44 IN XRA
       TIO E31A       OK EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E31        REPEAT SECTION
       REM            
 E31A  ALS 1          RIPPLE ONE POSITION
       PBT            
       TOV E31A1      36 POSITIONS TESTED
       TIX E31+4,1,1  REPEAT FOR EACH POSITION
       REM            
 E31A1 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E31A1+6    ERROR
       TRA E31A1+7    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E31        REPEAT TEST
       REM            
       REM            
       BCD 1TIO       
 E32   LDI ONES       ALL INDICATORS ON
       CLA ZERO       L +0
       TIO E32A       IND UNEXAMINED TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E32        REPEAT SECTION
       REM            
 E32A  TZE E32A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E32        REPEAT SECTION
       REM            
 E32A1 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E32A1+6    ERROR
       TRA E32A1+7    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E32        REPEAT TEST
       REM            
       REM            
       BCD 1TIO       
 E33   LDI ZERO       ALL INDICATORS OFF
       CAL ONES       L ALL ONES
       TIO E33+4      NG ALL IND SHOULD BE OFF
       TRA E33A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E33        REPEAT SECTION
       REM            
 E33A  SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP       CHECK ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E33A+6     ERROR
       TRA E33A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E33        REPEAT SECTION
       REM            
 E33A1 PIA            IND TO ACC AND CHECK
       TZE E33A1+3    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E33        REPEAT TEST
       REM            
       REM            
       BCD 1TIO       
 E34   LDI ZERO       ALL INDICATORS OFF
       CLA ZERO       L +0
       TIO E34A       IND UNEXAMINED-TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34        REPEAT SECTION
       REM            
 E34A  TZE E34A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34        REPEAT SECTION
       REM            
 E34A1 PIA            IND TO ACC AND CHECK
       TZE E34A1+3    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E34        REPEAT TEST
       REM            
       REM            
       BCD 1TIO       
 E34B  LDI K24        L +111111111111
       CAL K29        L-044444444444
       TIO E34B+4     NG EXAMINED IND OFF
       TRA E34B1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34B       REPEAT SECTION
       REM            
 E34B1 SLW TEMP       SAVE ACCUMULATOR
       CLA K27        L+222222222222
       TIO E34B1+4    NG EXAMINED IND OFF
       TRA E34B2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34B       REPEAT SECTION
       REM            
 E34B2 STO TEMP+1     SAVE ACCUMULATOR
       CLA K24        L+111111111111
       TIO E34B3      OK-EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34B       REPEAT SECTION
       REM            
       REM CHECK ACCS UNCHANGED
       REM            
 E34B3 ADD TEMP+1     L +222222222222
       SUB TEMP       L -044444444444
       CHS            ACC NOW -377777777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E34B3+7    ERROR
       TRA E34B4      OK ACCS UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34B       REPEAT SECTION
       REM            
 E34B4 PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA E34B4+5    ERROR
       TRA E34B4+6    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E34B       REPEAT TEST
       REM            
       REM            
       BCD 1TIO       RIPPLE TEST
 E34C  LDI ZERO       ALL INDICATORS OFF
       LXD K37A,1     L +44 IN XRA
       CLA ONE        L +1
       PAI            ACC TO IND
       TIO *+3        EXMINED IND ON-TRANSFER
       TSX ERROR-1,4 ERROR
       TRA E34C       REPEAT SECTION
       REM            
       ALS 1          RIPPLE 1 POSITION
       TIX E34C+3,1,1 CHECK EACH INDICATOR POS
       TSX OK,4       
       TRA E34C       
       REM            
       REM            
       BCD 1TIO       RIPPLE TEST
 E34D  LDI ONES       ALL INDICATORS ON
       LXD K37A,1     L +44 IN XRA
       CLA ONE        L +1
       IIA            EXMINED IND OFF
       TIO *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ERROR
       TRA E34D       REPEAT SECTION
       REM            
       ALS 1          RIPPLE 1 POSITION
       TIX E34D+3     CHECK EACH IND POSITION
       TSX OK,4       
       TRA E34D       
       REM            
*TEST TIF AND TIO TRAPS IN TRAP MODE
       REM            
       REM            
       BCD 1TIF       TEST TIF IN TRAP MODE
 MODE  CLA TR+3       L TRA MODE1
       STO 2          STORE IN LOC 00002
       LDI K24        L +111111111111
       CAL K29        L -044444444444
       TSX ENTM,2     ENTER TRAP MODE
       TIF *+1        SHOULD TRAP AND
       REM            GO TO LOC 00001
       LTM            LEAVE TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT TRAP
       TRA MODE       AND GO TO LOC 00001
       REM            
       REM CHECK CONTENTS LOC 00000
       REM            
 MODE1 CLA            L CONTENTS LOC 00000
       LDQ TR+4       L TRA MODE+5
       CAS TR+4       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    
       TSX OK,4       
       TRA MODE       
       REM            
       REM            
       BCD 1TIO       TEST TIO IN TRAP MODE
 MODE2 CLA TR+5       L TRA MODE 3
       STO 2          STORE IN MOC 00002
       LDI K29        L -044444444444
       CAL K29        
       TSX ENTM,2     ENTER TRAP MODE
       TIO *+1        SHOULD TRAP AND
       REM            GO TO LOC 00001
       LTM            LEAVE TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT TRAP
       TRA MODE2      AND GO TO LOC 00001
       REM            
       REM CHECK CONTENTS LOC 00000
       REM            
 MODE3 CLA 0          L CONTENTS LOC 00000
       LDQ TR+6       L TRA MODE2+5
       CAS TR+6       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    
       TSX OK,4       
       TRA MODE2      
       REM            
       NOP            
       CLA TR+7       L SLW TEMP+2
       STO 2          STORE IN LOC 00002
       TSX STORE,4    TO RESTORE RESET START
       TRA *+2        
       REM            
       REM            
       BCD 1OFT       TEST-OFF TEST FOR IND
 E35   CLA ONES       L ALL ONES
       STO TEMP       
       LDI ONES       ALL INDICATORS ON
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       OFT TEMP       
       TRA *+3        OK-EXAMINED IND NOT ZERO
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E35        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E35A  STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       LDQ ONES       L ALL ONES IN MQ
       CAS ONES       
       TRA E35A+6     ERROR
       TRA E35A1      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E35        REPEAT SECTION
       REM            
 E35A1 CLA TEMP       CHECK STORAGE UNCHANGED
       CAS ONES       
       TRA E35A1+4    ERROR
       TRA E35A1+5    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E35        REPEAT TEST
       REM            
       REM            
       BCD 1OFT       
 E36   CLA ZERO       L +0
       STO TEMP       SAVE ACCUMULATOR
       LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTRUCTION
       OFT TEMP       IND NOT EXMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E36        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E36A  CLA TEMP       CHECK STORAGE
       TZE E36A1      OK-STORAGE UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E36        REPEAT SECTION
       REM            
 E36A1 STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E36A1+6    ERROR
       TRA E36A1+7    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E36        REPEAT TEST
       REM            
       REM            
       BCD 1OFT       
 E37   CLA ZERO       L +0
       STO TEMP       SAVE ACCUMULATOR
       LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       OFT TEMP       IND NOT EXAMINED SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E37        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E37A  PIA            IND TO ACC AND CHECK
       TZE E37A1      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E37        REPEAT SECTION
       REM            
 E37A1 CLA TEMP       CHECK STORAGE
       TZE E37A1+3    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E37        REPEAT TEST
       REM            
       REM            
       BCD 1OFT       
 E38   CLA ONES       L ALL ONES
       STO TEMP       SAVE ACCUMULATOR
       LDI ZERO       ALL INDICATORS OFF
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       OFT TEMP       IND OFF-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E38        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E38A  PIA            IND TO ACC AND CHECK
       TZE E38A1      OK ALL IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E38        REPEAT SECTION
       REM            
 E38A1 CLA TEMP       CHECK STORAGE
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E38A1+5    ERROR
       TRA E38A1+6    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E38        REPEAT TEST
       REM            
       REM            
       BCD 1OFT       
 E39   LXD K37A,1     L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       PAI            ACC TO IND.
       OFT TEMP       
       TRA E39A       OK EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E39        REPEAT SECTION
       REM            
 E39A  ALS 1          RIPPLE 1 POSITION
       TIX E39+2,1,1  REPEAT FOR EACH POSITION
       REM            
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       TMI E39A1      OK-IND HAS ZERO POS BIT
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E39        REPEAT SECTION
       REM            
 E39A1 TZE E39A2      OK IND 1 THRU 35 ARE ZERO
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E39        REPEAT SECTION
       REM            
 E39A2 CLA TEMP       CHECK STORAGE
       TMI E39A3      STORAGE SIGN OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E39        REPEAT SECTION
       REM            
 E39A3 TZE E39A3+2    STORAGE CONTENTS OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E39        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       TEST-ON TEST FOR IND
 E41   CAL ONES       L ALL ONES
       SLW TEMP       SAVE ACCUMULATOR
       LDI ONES       ALL INDICATORS ON
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LLS 1          SHIFT FOR BITS IN Q,P,1-35
       SSM            MAKE ACC SIGN MINUS
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       ONT TEMP       ALL IND ON-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E41        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E41A  STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E41A+6     ERROR
       TRA E41A1      OK IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E41        REPEAT SECTION
       REM            
 E41A1 CLA TEMP       CHECK STORAGE
       CAS ONES       
       TRA E41A1+4    ERROR
       TRA E41A1+5    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E41        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       
 E42   LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       STO TEMP       SAVE ACCUMULATOR
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       ONT TEMP       
       TRA *+3        OK-EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E42        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E42A  PIA            IND TO ACC AND CHECK
       TZE E42A1      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E42        REPEAT SECTION
       REM            
 E42A1 CLA TEMP       CHECK STORAGE
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E42A1+5    ERROR
       TRA E42A1+6    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E42        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       
 E43   LDI ONES       ALL INDICATORS ON
       CLA ZERO       L +0
       STO TEMP       
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       ONT TEMP       IND NOT EXAMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E43        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E43A  CLA TEMP       CHECK STORAGE
       TZE E43A1      OK-STORAGE UNCHANGE
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E43        REPEAT SECTION
       REM            
 E43A1 STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E43A1+6    ERROR
       TRA E43A1+7    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E43        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       
 E44   LDI ZERO       ALL INDICATORS OFF
       CLA ZERO       L +0
       STO TEMP       SAVE ACCUMULATOR
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       ONT TEMP       IND NOT EXAMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E44        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACC
       REM            
 E44A  PIA            IND TO ACC AND CHECK
       TZE E44A1      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E44        REPEAT SECTION
       REM            
 E44A1 CLA TEMP       CHECK STORAGE
       TZE E44A1+3    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E44        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       
 E45   LDI K24        L +111111111111
       ONT K29        L -044444444444
       TRA E45A       OK-EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E45        REPEAT SECTION
       REM            
 E45A  ONT K27        L +222222222222
       TRA E45A1      OK-EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E45        REPEAT SECTION
       REM            
 E45A1 ONT K24        L +111111111111
       TRA E45A1+3    ERROR
       TRA E45A2      OK-EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E45        REPEAT SECTION
       REM            
 E45A2 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ K24        L +111111111111
       CAS K24        
       TRA E45A2+6    ERROR
       TRA E45A3      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E45        REPEAT SECTION
       REM            
       REM CHECK STORAGES UNCHANGED
       REM            
 E45A3 CLA K24        L +111111111111
       ADD K27        L +222222222222
       SUB K29        L -044444444444
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E45A3+8    ERROR
       TRA E45A3+9    OK-STORAGES UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E45        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       
 E40   LXD K37A,1     L ++44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       PAI            ACC TO IND
       ONT TEMP       EXAMINED IND ON-SKIP
       TRA E40+7      ERROR
       TRA E40A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E40        REPEAT SECTION
       REM            
 E40A  ALS 1          RIPPLE 1 POSITION
       TIX E40+2,1,1  REPEAT FOR EACH POSITION
       REM            
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       TMI E40A1      OK-IND HAS ZERO POS BIT
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E40        REPEAT SECTION
       REM            
 E40A1 TZE E40A2      OK IND 1 THRU 35 ARE ZERO
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E40        REPEAT SECTION
       REM            
 E40A2 CLA TEMP       CHECK STORAGE
       TMI E40A3      STORAGE SIGN OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E40        REPEAT SECTION
       REM            
 E40A3 TZE E40A3+2    STORAGE CONTENTS OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E40        REPEAT TEST
       REM            
       REM            
       BCD 1SIR       TEST-SET IND RIGHT HALF
 F     LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS IN MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       SIR 32767,7    TURN IND 18 THRU 35 ON
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       LDQ K31        L +777777
       CAS K31        
       TRA *+2        ERROR
       TRA *+2        OK IND 18-35 ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F           REPEAT TEST
       REM            
       REM            
       BCD 1SIR       
 F1    LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       SIR 0          
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK-ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F1         REPEAT TEST
       REM            
       REM            
       BCD 1SIR       
 F2    LDI ZERO       ALL INDICATORS OFF
       TSX ENTM,2     TEST PRI 0,4 NO TRAP
       SIR 4681,1     TURN 6 RT HALF IND ON
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F2         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       LDQ K33        L +111111
       CAS K33        
       TRA *+2        ERROR
       TRA F2A        OK 6 RT HALF IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F2         REPEAT SECTION
       REM            
 F2A   SIR 9362,2     NOW 12 RT HALF IND ON
       PIA            IND TO ACC AND CHECK
       LDQ K34        L +333333
       CAS K34        
       TRA F2A+6      ERROR
       TRA F2A1       OK 12 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F2         REPEAT SECTION
       REM            
 F2A1  SIR 18724,4    NOW IND 18 THRU 35 ON
       PIA            IND TO ACC AND CHECK
       LDQ K31        L +777777
       CAS K31        
       TRA F2A1+6     ERROR
       TRA F2A1+7     OK IND 18-35 ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F2         REPEAT TEST
       REM            
       BCD 1SIR       RIPPLE TEST
 F2B   LXD K30,1      L +22 IN XRA
       CLA K38        L SIR INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+4        POSITION 35
       CLA ONE        L +1
       LDI ZERO       ALL IND OFF
       STO TEMP       SAVE ACCUMULATOR
       SIR 1          
       PIA            IND TO ACC AND CHECK
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA F2B        REPEAT SECTION
       REM            
       CLA TEMP       L LAST POSITION TESTED
       ALS 1          RIPPLE 1 POSITION
       ORA K38        ADJUST SIR
       STO F2B+7      INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F2B+5,1,1  CHECK EACH RT HALF POS
       TSX OK,4       
       TRA F2B        
       REM
       REM
       BCD 1SIL       TEST-SET IND LEFT HALF
 F3    LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS IN MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEA LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       SIL 32767,7    TURN IND 0 THRU 17ON
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       SUB K31        L +777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F3         REPEAT TEST
       REM            
       REM            
       BCD 1SIL       
 F4    LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS IN MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       SIL 0          
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F4         REPEAT TEST
       REM            
       REM            
       BCD 1SIL       
 F5    LDI ZERO       ALL INDICATORS OFF
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       SIL 4681,1     TURN 6 LEFT HALF IND ON
       REM            
*CHECK CONTENTS OF LOCATION 000000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F5         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       ADD K33        L +111111
       LDQ K24        L +111111111111
       CAS K24        
       TRA *+2        ERROR
       TRA F5A        OK 6 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F5         REPEAT SECTION
       REM            
 F5A   SIL 9362,2     NOW 12 LEFT HALF IND ON
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       ADD K34        L +333333
       LDQ K28        L +333333333333
       CAS K28        
       TRA F5A+8      ERROR
       TRA F5A1       OK 12 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F5         REPEAT SECTION
       REM            
 F5A1  SIL 18724,4    NOW IND 0 THRU 17 ON
       STI TEMP+2     STORE INDICATORS
       CLA TEMP+2     CHECK INDICATORS
       SUB K31        L +777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F5A1+8     ERROR
       TRA F5A1+9     OK IND 0 THRU 17 ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F5         REPEAT TEST
       REM            
       REM            
       BCD 1SIL       RIPPLE TEST
 F5B   LDI ZERO       ALL INDICATORS OFF
       CLA ONE        L +1
       STO TEMP+1     SAVE ACCUMULATOR
       CLA K38+1      L SIL INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+5        POSITION 35
       LXD K30,1      L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       SLW TEMP       SAVE ACCUMULATOR
       SIL 1          
       STI TEMP+2     
       CLA TEMP+2     
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA F5B        REPEAT SECTION
       REM            
       CLA TEMP+1     ADJUST
       ALS 1          F
       STO TEMP+1     FIELD
       ORA K38+1      ADJUST SIL
       SLW F5B+10     INSTRUCTION
       CAL TEMP       RESTORE SAVED ACC
       IIA            TURN TESTED IND OFF
       TIX F5B+8,1,1  CHECK EACH LEFT HALF POS
       TSX OK,4       
       TRA F5B        
       REM            
       REM            
       BCD 1RIR       TEST-RESET IND RIGHT HALF
 F6    LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS IN MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RIR 0          RT HALF IND UNCHANGED
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F6         REPEAT TEST
       REM            
       REM            
       BCD 1RIR       
 F7    LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RIR 32767,7    TURN IND 18 THRU 35 OFF
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       SUB K31        L +777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F7         REPEAT TEST
       REM            
       REM            
       BCD 1RIR       
 F8    LDI ZERO       ALL IND OFF
       SIR 32767,7    IND 18 THRU 35 ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       RIR 18724,4    TURN 6 RT HALF IND OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F8         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       LDQ K34        L +333333
       CAS K34        
       TRA *+2        ERROR
       TRA F8A        OK-6 IND TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F8         REPEAT SECTION
       REM            
 F8A   RIR 9362,2     NOW 12 RT HALF IND OFF
       PIA            IND TO ACC AND CHECK
       LDQ K33        L +111111
       CAS K33        
       TRA F8A+6      ERROR
       TRA F8A1       OK 12 RT HALF IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F8         REPEAT SECTION
       REM            
 F8A1  RIR 4681,1     NOW ALL IND OFF
       PIA            IND TO ACC AND CHECK
       TZE F8A1+4     OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F8         REPEAT TEST
       REM            
       REM            
       BCD 1RIR       RIPPLE TEST
 F8B   CLA K38+2      L RIR INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+5        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       LXD K30,1      L +22 IN XRA
       PAI            ACC TO IND
       RIR 1          
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F8B        REPEAT SECTION
       REM            
       CLA TEMP       L LAST POSITION TESTED
       ALS 1          RIPPLE 1 POSITION
       STO TEMP       SAVE ACCUMULATOR
       ORA K38+2      ADJUST RIR
       STO F8B+7      INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F8B+6,1,1  CHECK EACH RT HALF POS
       TSX OK,4       
       TRA F8B        
       REM            
       REM            
       BCD 1RIL       TEST-RESET IND LEFT HALF
 F9    LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RIL 0          IND UNCHANGED
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F9         REPEAT TEST
       REM            
       REM            
       BCD 1RIL       
 F10   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RIL 32767,7    TURN IND 0 THRU 17 OFF
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ K31        L +777777
       CAS K31        
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F10        REPEAT TEST
       REM            
       REM            
       BCD 1RIL       
 F11   LDI ZERO       ALL INDICATORS OFF
       SIL 32767,7    IND 0-17 ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       RIL 18724,4    TURN 6 LEFT HALF IND OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F11        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       ADD K34        L +333333
       LDQ K28        L +333333333333
       CAS K28        
       TRA *+2        ERROR
       TRA F11A       OK-6 IND TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F11        REPEAT SECTION
       REM            
 F11A  RIL 9362,2     NOW 12 LEFT HALF IND OFF
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       ADD K33        L +111111
       LDQ K24        L +111111111111
       CAS K24        
       TRA F11A+8     ERROR
       TRA F11A1      OK-NOW 12 IND TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F11        REPEAT SECTION
       REM            
 F11A1 RIL 4681,1     NOW ALL IND OFF
       PIA            IND TO ACC AND CHECK
       TZE F11A1+4    OK-IND 0-17 TURNED OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F11        REPEAT TEST
       REM            
       REM            
       BCD 1RIL       RIPPLE TEST
 F11B  CLA K38+3      L RIL INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+8        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       LXD K30,1      L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POS
       SLW TEMP+1     SAVE ACCUMULATOR
       PAI            ACC TO IND
       RIL 1          
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F11B       REPEAT SECTION
       REM            
       CLA TEMP       ADJUST
       ALS 1          F
       STO TEMP       FIELD
       ORA K38+3      ADJUST RIL
       SLW F11B+10    INSTRUCTION
       CAL TEMP+1     RESTORE SAVED ACCUMULATOR
       TIX F11B+7,1,1 CHECK EACH LEFT HALF POS
       TSX OK,4       
       TRA F11B       
       REM            
       REM            
       BCD 1IIR       TEST INVERT INDICATORS OF
       REM            RIGHT HALF
 F12   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       IIR 32767,7    IND 18 THRU 35 OFF
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       SUB K31        L +777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F12        REPEAT TEST
       REM            
       REM            
       BCD 1IIR       
 F13   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOCATION OF TEST INSTR
       IIR 0          IND UNCHANGED
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F13        REPEAT TEST
       REM            
       REM            
       BCD 1IIR       
 F14   LDI ZERO       ALL INDICATORS OFF
       SIR 32767,7    IND 18-35 ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       IIR 18724,4    6 RT HALF IND OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F14        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       LDQ K34        L +333333
       CAS K34        
       TRA *+2        ERROR
       TRA F14A       OK-6 IND TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F14        REPEAT SECTION
       REM            
 F14A  IIR 9362,2     NOW 12 RT HALF IND OFF
       PIA            IND TO ACC AND CHECK
       LDQ K33        L +111111
       CAS K33        
       TRA F14A+6     ERROR
       TRA F14A1      OK-12 IND NOW TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F14        
       REM            
 F14A1 IIR 4681,1     NOW ALL IND OFF
       PIA            IND TO ACC AND CHECK
       TZE F14A2      OK-IND 18-35 TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F14        REPEAT SECTION
       REM            
 F14A2 IIR 18724,4    6 RIGHT HALF IND ON
       IIR 9362,2     12 RIGHT HALF IND ON
       IIR 4681,1     IND 18-35 ON
       IIR 32767,7    IND 18-35 OFF
       IIR 32767,7    IND 18-35 ON
       PIA            IND TO ACC AND CHECK
       LDQ K31        L +777777
       CAS K31        
       TRA F14A2+10   ERROR
       TRA F14A2+11   OK IND 18-35 ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F14        REPEAT TEST
       REM            
       REM            
       BCD 1IIR       RIPPLE TEST
 F14B  CLA K38+4      L IIR INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+5        POSITION 35
       LXD K30,1      L +22 IN XRA
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       LDI TEMP       TURN ON IND TESTING
       IIR 1          TURN OFF IND TESTING
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F14B       REPEAT SECTION
       REM            
       CLA TEMP       L LAST TESTED POSITION
       ALS 1          RIPPLE 1 POSITION
       ORA K38+4      ADJUST IIR
       STO F14B+7     INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F14B+5,1,1 CHECK EACH RT HALF POS
       TSX OK,4       
       TRA F14B       
       REM            
       REM            
       BCD 1IIL       TEST-INVERT INDICATORS OF
       REM            LEFT HALF
 F15   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       IIL 32767,7    IND 0 THRU 17 OFF
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ K31        L +777777
       CAS K31        
       TRA *+2        ERROR
       TRA *+2        OK IND 0-17 OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F15        REPEAT TEST
       REM            
       REM            
       BCD 1IIL       
 F16   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       IIL 0          IND UNCHANGED
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK IND 0-17 OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F16        REPEAT TEST
       REM            
       REM            
       BCD 1IIL       
 F17   LDI ZERO       ALL INDICATORS OFF
       SIL 32767,7    IND 0-17 ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       IIL 18724,4    6 LEFT HALF IND OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F17        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       ADD K34        L +333333
       LDQ K28        L +333333333333
       CAS K28        
       TRA *+2        ERROR
       TRA F17A       OK-6 IND TURNED OFF
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA F17        REPEAT SECTION
       REM            
 F17A  IIL 9362,2     NOW 12 LEFT HALF IND OFF
       PIA            IND TO ACC AND CHECK
       ADD K33        L +111111
       LDQ K24        L +111111111111
       CAS K24        
       TRA F17A+7     ERROR
       TRA F17A1      OK-12 IND NOW TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F17        REPEAT SECTION
       REM            
 F17A1 IIL 4681,1     NOW ALL IND OFF
       PIA            IND TO ACC AND CHECK
       TZE F17A2      OK ALL IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F17        REPEAT SECTION
       REM            
 F17A2 IIL 18724,4    6 LEFT IND ON
       IIL 9362,2     12 LEFT IND ON
       IIL 4681,1     IND 0-17 ON
       IIL 32767,7    IND 0-17 OFF
       PIA            IND TO ACC AND CHECK
       TZE F17A2+7    OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F17        REPEAT TEST
       REM            
       REM            
       BCD 1IIL       
 F17B  CLA K38+5      L IIL INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+8        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       LXD K30,1      L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       SLW TEMP+1     SAVE ACCUMULATOR
       PAI            ACC TO IND
       IIL 1          
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F17B       REPEAT SECTION
       REM            
       CLA TEMP       ADJUST
       ALS 1          F
       STO TEMP       FIELD
       ORA K38+5      ADJUST IIL
       SLW F17B+10    INSTRUCTION
       CAL TEMP+1     L SAVED ACCUMULATOR
       TIX F17B+7,1,1 CHECK EACH IND POS
       TSX OK,4       
       TRA F17B       
       REM            
       REM            
       BCD 1RFT       TEST-RIGHT HALF IND OFF SET
 F18   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RFT 32767,7    L +777777
       TRA *+3        OK-RT HALF IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F18        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F18A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F18A+6     ERROR
       TRA F18A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F18        REPEAT TEST
       REM            
       REM            
       BCD 1RFT       
 F19   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RFT 0          IND NOT EXAMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F19        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F19A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F19A+6     ERROR
       TRA F19A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F19        REPEAT TEST
       REM            
       REM            
       NOP            
       CLA TR+2       L HTR FOUR
       STA 6          ADJUST LOC 00006
       TRA *+2        
       REM            
       REM            
       BCD 1RFT       
 F20   LDI ZERO       ALL INDICATORS OFF
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       RFT 0          IND NOT EXAMINED SKIP
       TTR *+13       ERROR-SHOULD SKIP
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F20        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       TRA F20AA      OK
       REM            
       LTM            
       TSX ERROR-1,4  ERROR-DID NOT SKIP
       TRA F20        REPEAT SECTION
       REM            
 F20AA PIA            IND TO ACC AND CHECK
       TZE F20AA+3    OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F20        REPEAT TEST
       REM            
       REM            
       BCD 1RFT       RFT RIPPLE TEST
 F20A  LXD K30,1      L +22 IN XRA
       CLA K38+6      L RFT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO F20A+6     POSITION 35
       CLA ONE        L +1
       PAI            LOAD INDICATORS WITH THE
       REM            ONE BIT BEING TESTED
       RFT 1          
       TRA F20B       OK EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F20A       REPEAT SECTION
       REM            
 F20B  ALS 1          RIPPLE 1 POSITION
       ORA K38+6      ADJUST RFT
       STO F20A+6     INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F20A+5,1,1 REPEAT FOR ALL RT HALF
       TSX OK,4       
       TRA F20A       
       REM            
       REM            
       BCD 1RFT       RFT RIPPLE TEST
 F20B1 LDI ONES       ALL INDICATORS ON
       CLA K38+6      L RFT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO F20B1+7    POSITION 35
       LXD K30,1      L +22 IN XRA
       CLA ONE        L +1
       IIA            TURN INDICATOR OFF THAT
       REM            IS BEING CHECKED
       RFT 1          
       TRA F20B1+10   ERROR
       TRA F20C       OK EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F20B1      REPEAT SECTION
       REM            
 F20C  IIA            RESET INDICATOR THAT
       REM            WAS JUST TESTED
       ALS 1          RIPPLE 1 POSITION
       ORA K38+6      ADJUST RFT
       STO F20B1+7    INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F20B1+6,1,1 REPEAT FOR RT HALF
       TSX OK,4       
       TRA F20B1      
       REM            
       REM            
       BCD 1RFT       
 F21   LDI K24        L +111111111111
       IIR 4681,1     TURN RT HALF IND OFF
       RFT 18724,4    EXAMINED IND OFF-SKIP
       TRA F21+5      ERROR
       TRA F21A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F21        REPEAT SECTION
       REM            
 F21A  RFT 9362,2     EXAMINED IND OFF-SKIP
       TRA F21A+3     ERROR
       TRA F21A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F21        REPEAT SECTION
       REM            
 F21A1 RFT 4681,1     EXAMINED IND OFF-SKIP
       TRA F21A1+3    ERROR
       TRA F21A1+4    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F21        REPEAT TEST
       REM            
       REM            
       BCD 1RFT       
 F22   LDI ZERO       ALL INDICATORS OFF
       SIR 4681,1     TURN 6 IND ON
       RFT 18724,4    EXAMINED IND OFF-SKIP
       TRA F22+5      ERROR
       TRA F22A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F22        REPEAT SECTION
       REM            
 F22A  RFT 9362,2     EXAMINED IND OFF-SKIP
       TRA F22A+3     ERROR
       TRA F22A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F22        REPEAT SECTION
       REM            
 F22A1 RFT 14043,3    EXAMINED IND NOT OFF
       TRA F22A2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F22        REPEAT SECTION
       REM            
 F22A2 PIA            IND TO ACC AND CHECK
       LDQ K33        L +111111
       CAS K33        
       TRA F22A2+5    ERROR
       TRA F22A2+6    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F22        REPEAT TEST
       REM            
       REM            
       BCD 1LFT       TEST-LEFT HALF INDICATOR
       REM            OFF TEST
 F23   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITA TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       LFT 32767,7    EXMINED IND ON
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F23        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F23A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F23A+6     ERROR
       TRA F23A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F23        REPEAT TEST
       REM            
       REM            
       BCD 1LFT       
 F24   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       LFT 0          IND NOT EXAMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F24        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F24A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F24A+6     ERROR
       TRA F24A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F24        REPEAT TEST
       REM
       REM
       BCD 1LFT       
 F25   LDI K24        L +111111111111
       IIL 4681,1     TURN OFF LEFT HALF IND
       TSX ENTM,2     TEST PRI OP 0,4 NOT TRAP
       LFT 18724,4    EXAMINED IND OFF-SKIP
       TTR *+13       ERROR-SHOULD SKIP
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F25        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       TRA F25A       OK
       REM            
       LTM            EXIT TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT SKIP
       TRA F25        REPEAT SECTION
       REM            
 F25A  LFT 9362,2     EXAMINED IND OFF-SKIP
       TRA F25A+3     ERROR
       TRA F25A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F25        REPEAT SECTION
       REM            
 F25A1 LFT 4681,1     EXAMINED IND OFF-SKIP
       TRA F25A1+3    ERROR
       TRA F25A1+4    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F25        REPEAT TEST
       REM            
       REM            
       REM            
       BCD 1LFT       
 F26   LDI ZERO       ALL INDICATORS OFF
       SIL 4681,1     TURN ON 6 LEFT HALF IND
       LFT 18724,4    EXAMINED IND OFF-SKIP
       TRA F26+5      ERROR
       TRA F26A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F26        REPEAT SECTION
       REM            
 F26A  LFT 9362,2     EXAMINED IND OFF-SKIP
       TRA F26A+3     ERROR
       TRA F26A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F26        REPEAT SECTION
       REM            
 F26A1 LFT 14043,3    EXAMINED IND ON
       TRA F26A2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F26        REPEAT SECTION
       REM            
 F26A2 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       ADD K33        L +111111
       LDQ K24        L +111111111111
       CAS K24        
       TRA F26A2+7    ERROR
       TRA F26A2+8    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F26        REPEAT TEST
       REM            
       REM            
       BCD 1LFT       RIPPLE TEST
 F26B  CLA K38+7      L LFT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+9        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       LDI ONES       ALL INDICATORS ON
       LXD K30,1      L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       SLW TEMP+1     SAVE ACCUMULATOR
       IIA            TURN TESTED IND OFF
       LFT 1          
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F26B       REPEAT SECTION
       REM            
       IIA            RESET TESTED IND
       CLA TEMP       L SAVED ACCUMULATOR
       ALS 1          RIPPLE 1 POSITION
       STO TEMP       SAVE ACCUMULATOR
       ORA K38+7      ADJUST LFT
       SLW F26B+11    INSTRUCTION
       CAL TEMP+1     L SAVED ACCUMULATOR
       TIX F26B+8,1,1 CHECK EACH IND POSITION
       TSX OK,4       
       TRA F26B       
       REM            
       BCD 1LFT       RIPPLE TEST
 F26C  CLA K38+7      L LFT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+9        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       LDI ZERO       ALL INDICATORS OFF
       LXD K30,1      L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       SLW TEMP+1     SAVE ACCUMULATOR
       IIA            TURN TESTED IND ON
       LFT 1          
       TRA *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F26C       
       REM            
       IIA            TURN TEST IND OFF
       CLA TEMP       L SAVED ACCUMULATOR
       ALS 1          RIPPLE 1 POSITION
       STO TEMP       SAVE ACCUMULATOR
       ORA K38+7      ADJUST LFT
       SLW F26C+11    INSTRUCTION
       CAL TEMP+1     L SAVED ACCUMULATOR
       TIX F26C+8,1,1 CHECK EACH IND POS
       TSX OK,4       
       TRA F26C       
       REM            
       REM            
       BCD 1RNT       TEST-RIGHT HALF IND ON TEST
 F28   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RNT 32767,7    EXAMINED IND ON SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F28        REPEAT SECTION
       REM            
       TSX ACC,2      TO TEST ACCUMULATOR
       REM            
 F28A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F28A+6     ERROR
       TRA F28A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F28        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F29   LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RNT 32767,7    EXAMINED IND OFF
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F29        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F29A  PIA            IND TO ACC AND CHECK
       TZE F29A+3     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F29        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F30   LDI ONES       ALL INDICATORS ON
       TSX ENTM,2     TEST PRI 0,4 NO TRAP
       RNT 0          IND NOT EXAMINED-SKIP
       TTR *+13       ERROR-SHOULD SKIP
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F30        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       TRA F30A       OK
       REM            
       LTM            EXIT TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT SKIP
       TRA F30        REPEAT SECTION
       REM            
 F30A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F30A+6     ERROR
       TRA F30A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F30        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F31   LDI ZERO       ALL INDICATORS OFF
       RNT 0          IND NOT EXAMINED-SKIP
       TRA F31+4      ERROR
       TRA F31A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F31        
       REM            
 F31A  PIA            IND TO ACC AND CHECK
       TZE F31A+3     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F31        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F32   LDI K24        L +111111111111
       RNT 18724,4    EXAMINED IND OFF
       TRA F32A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F32        REPEAT SECTION
       REM            
 F32A  RNT 9362,2     EXAMINED IND OFF
       TRA F32A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F32        REPEAT SECTION
       REM            
 F32A1 RNT 4681,1     EXAMINED IND ON-SKIP
       TRA F32A1+3    ERROR
       TRA F32A2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F32        REPEAT SECTION
       REM            
 F32A2 PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA F32A2+5    ERROR
       TRA F32A2+6    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F32        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F27   LXD K30,1      L +22 IN XRA
       CLA K38+8      L RNT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO F27+6      POSITION 35
       CLA ONE        L +1
       PAI            ACC TO IND
       RNT 1          EXAMINED IND ON-SKIP
       TRA F27+9      ERROR
       TRA F27A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F27        REPEAT SECTION
       REM            
 F27A  ALS 1          RIPPLE 1 POSITION
       ORA K38+8      ADJUST RNT
       STO F27+6      INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F27+5,1,1  REPEAT EACH RT HALF POS
       REM            
 F27A1 LDQ K35        L +400000
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       CAS K35        POS TESTED
       TRA F27A1+6    ERROR
       TRA F27A1+7    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F27        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       TEST-LEFT HALF IND ON TEST
 F34   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       LNT 32767,7    EXAMINED IND ON SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F34        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F34A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F34A+6     ERROR
       TRA F34A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F34        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F35   LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       LNT 32767,7    EXAMINED IND OFF
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F35        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F35A  PIA            IND TO ACC AND CHECK
       TZE F35A+3     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F35        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F36   LDI ONES       ALL INDICATORS ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       LNT 0          IND UNEXAMINED SKIP
       TTR *+13       ERROR-SHOULD SKIP
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F36        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       TRA F36A       OK
       REM            
       LTM            EXIT TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT SKIP
       TRA F36        REPEAT SECTION
       REM            
 F36A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F36A+6     ERROR
       TRA F36A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F36        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F37   LDI ZERO       ALL INDICATORS OFF
       LNT 0          IND NOT EXAMINED-SKIP
       TRA F37+4      ERROR
       TRA F37A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F37        REPEAT SECTION
       REM            
 F37A  PIA            IND TO ACC AND CHECK
       TZE F37A+3     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F37        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F38   LDI K24        L +111111111111
       LNT 18724,4    EXAMINED IND OFF
       TRA F38A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F38        REPEAT SECTION
       REM            
 F38A  LNT 9362,2     EXAMINED IND OFF
       TRA F38A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F38        REPEAT SECTION
       REM            
 F38A1 LNT 4681,1     EXAMINED IND ON SKIP
       TRA F38A1+3    ERROR
       TRA F38A2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F38        REPEAT SECTION
       REM            
 F38A2 PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA F38A2+5    ERROR
       TRA F38A2+6    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F38        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F33   CLA ONE        L +1
       STO TEMP+1     SAVE ACCUMULATOR
       CLA K38+9      L LNT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO F33+9      POSITION 35
       LXD K30,1      L 22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       PAI            ACC TO IND
       LNT 1          
       TRA F33+12     ERROR
       TRA F33A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F33        REPEAT SECTION
       REM            
 F33A  SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP+1     ADJUST
       ALS 1          F
       STO TEMP+1     FIELD
       ORA K38+9      ADJUST LNT
       SLW F33+9      INSTRUCTION
       CAL TEMP       RESTORE SAVED ACC
       TIX F33+7,1,1  REPEAT EACH LEFT HALF POS
       REM            
       STI TEMP+2     STORE INDICATORS
       CLA TEMP+2     CHECK INDICATORS
       TMI F33A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F33        REPEAT SECTION
       REM            
 F33A1 TZE F33A1+2    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F33        REPEAT TEST
       REM            
*ADDITIONAL TESTS OF INSTRUCTIONS CHECKED IN 9M01
       REM            
       REM            
       BCD 1LLS       LLS TEST
 A46   CLA ZERO       CLEAR ACCUMULATOR
       LDQ ONE        MOVE BIT FROM MQ 35 TO MQ 1
       LLS 35         BIT FROM MQ 35 TO ACC 35
       LBT            TEST ACC POSITION 35
       TRA *+2        ERROR
       TRA A47        OK-PROCEED
       TSX ERROR-1,4  
       TRA A46        
       REM            
 A47   STQ TEMP       IS THE BIT STILL IN MQ
       CLA TEMP       
       TZE *+2        OK-NO BIT IN MQ
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA A46        GO BACK UP TO A 46
       REM            
       REM            
       BCD 1ANS       
 B70Z  CLA ONES       L ONES IN S,1-35
       STO TEMP       
       CLA MTW        L -200000000000
       ALS 2          BIT ONLY IN S AND Q
       ANS TEMP       CLEAR TEMP SIG LOCATION
       REM            
*      CHECK Q BIT NOT LOST BY ANS
       REM            
       ARS 1          MOVE BIT TO P
       PBT            CHECK FOR BIT
       TRA *+2        ERROR-LOST Q BIT
       TRA *+3        OK
       TSX ERROR-1,4  
       TRA B70Z       
       REM            
*      CHECK SIGN NOT LOST BY ANS
       REM            
       TMI *+3        OK-SIGN REMAINED MINUS
       TSX ERROR-1,4  
       TRA B70Z       
       REM            
*      CHECK TEMP     
       REM            
       CAL TEMP       
       TZE *+2        OK-TEMP STG LOC PLUS ZERO
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA B70Z       REPEAT TEST
       REM            
       REM            
       BCD 1ORA       
 B72X  CLA ONES       L -3777777777777
       ORA ZERO       SHOULD NOT CHANGE ACC
       TMI B72X1      SHOULD TRANSFER
       TSX ERROR-1,4  ERROR
       TRA B72X       
       REM            
 B72X1 SUB ONES       CHECK ACC P,1-35
       TZE *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA B72X       REPEAT TEST
       REM            
       REM            
       BCD 1CVR       
 CONV  CAL K16        L +010203040506
       CVR K16,1,6    FULL WORD CONVERSION WITH
       REM            6TH CONVERT SR ADR IN XRA
       REM            
       REM CHECK ACC AND CORRECT VALUE IN XRA
       REM            
       LDQ K16B+K16,1 L +212223242526
       CAS K16B       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA CONV       REPEAT TEST
       REM            
       REM            
       BCD 1CAQ       
 CONV1 TOV *+1        TURN OFF ACC OVFLO LIGHT
       LDQ K16        L +010203040506
       CLA ZERO       L +0
       CAQ K16,1,6    FULL WORD CONVERSION WITH
       REM            6TH CONVERT SR ADR IN XRA
       SLW TEMP       SAVE ACC
       ARS 1          MOVE Q BIT TO P
       PBT            
       TRA *+2        ERROR
       TRA CONV2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA CONV1      
       REM            
*          CHECK ACC AND CORRECT VALUE IN XRA
       REM            
 CONV2 STQ TEMP+1     SAVE MQ
       CLA TEMP+K16,1 CHECK SAVED ACC
       LDQ K16+7      MQ, ACC SHOULD BE SAME
       CAS K16+7      
       TRA CONV2+6    ERROR
       TRA CONV3      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA CONV1      
       REM            
 CONV3 CLA TEMP+1     CHECK SAVED MQ
       LDQ K16        L +010203040506 MQ,ACC
       CAS K16        
       TRA CONV3+5    ERROR
       TRA CONV3+6    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA CONV1      
       REM            
       NOP            
       REM            
       SWT 5          TEST SENSE SWITCH 5
       TRA END        BYPASS DISPLAY BUTTONS AND
       REM            MPY TIMING TESTS
       TRA *+2        
       REM            
*TEST CONSOLE DISPLAY BUTTONS WITH HTR AND HPR
       REM            
       BCD 1BUTTON    DISPLAY IND BUTTON WITH HTR
 BUT   CLA DIS        L TRA BUT+6
       STO 32K        PUT IN LAST STORAGE LOC
       CLA DIS+1      L HTR BUT+7
       STO 0          PUT IN LOC 00000
       LDI 8CF        INDICATORS 21-35 ON
       HTR            
       REM            
*PUT MACHINE IN MANUAL-HIT DISPLAY IND BUTTON-PUT MACHINE IN AUTOMATIC
*HIT START TWICE AND PROGRAM SHOULD CONTINUE.
*IF PROGRAM TRANSFERRED TO INDICATOR ADR DIPLSAYED IN SR,
*YOU WILL GET AN ERROR STOP AT THE NEXT HPR
       REM            
       HTR *+4        ERROR STOP
       TSX OK,4       
       TRA BUT        
       REM            
       REM            
       BCD 1BUTTON    DISPLAY STG BUTTON WITH HTR
 BUT1  CLA DIS+2      L TRA BUT1+5
       STO 32K        PUT IN LAST STORAGE LOC
       CLA DIS+3      L TRA BUT1+6
       STO 0          PUT IN LOC 00000
       HTR
       REM
*PUT MACHINE IN MANUAL-PUT ADDRESS05411IN KEYS AND HIT
*DISPLAY STG BUTTON-NOW PUT MACHINE IN AUTOMATIC
*HIT START TWICE AND PROGRAM SHOULD CONTINUE.
*IF PROGRAQM TRANSFERRED TO ADDRESS DISPLAYED IN SR,
*YOU WILL GET AN ERROR STOP AT THE FOLLOWING HTR
       REM
       HTR *+4        ERROR STOP
       TSX OK,4
       TRA BUT1
       REM
       BCD 1BUTTON    DISPLAY EFFECTIVE ARD
       REM            BUTTON WITH HTR
 BUT4  CLA DIS+6      L TRA BUT4+6
       STO 32K        PUT IN LAST STORAGE LOC
       CLA DIS+7      L TRA BUT4+7
       STO 0          PUT IN LOCATION 000000
       AXT 32K,1      L 77777 IN XRA
       HTR 32K,1
       REM
*PUT MACHINE IN MANUL-HIT DISPLAY EFFECTIVE ADR BUTTON-
*PUT MACHINE IN AUTOMATIC-HIT START TWICE AND PROGRAM SHOULD CONTINUE
*IF PROGRAM TRANSFERRED TO ADDRESS 77777,
*YOU WILL GET AN ERROR STOP AT THE FOLLOWING HTR
       REM
       HTR *+4        ERROR STOP
       TSX OK,4
       TRA BUT4
       REM
       REM
       BCD 1BUTTON    DISPLAY IND BUTTON WITH HPR
 BUT2  CLA DIS+4      L TRA BUT2+5
       STO 32K        PUT IN LAST STORAGE LOC
       LDI 8CF        INDICATORS 21-35 ON
       HPR
       REM
*PUT MACHINE IN MANUAL, HIT DISPLAY IND BUTTON-PUT MACHINE IN AUTOMATIC
*AND HIT START BUTTON-SHOULD CONTINUE PROGRAM
*IF PROGRAM TRANSFERRED TO INDICATOR ADR DISPLAYED IN SR.
*YOU WILL GET AN ERROR STOP AT NEXT HPR
       REM
       TRA *+3        HPR WORKED OK
       HPR            ERROR STOP
       TRA *+4
       TSX OK,4
       TRA BUT2
       REM
       REM
       BCD 1BUTTON    DISPLAY STG BUTTON WITH HPR
 BUT3  CLA DIS+5      L TRA BUT3+4
       STO 32K        PUT IN LAST STORAGE LOC
       HPR
       REM
*PUT MACHINE IN MANUAL-PUT ADDRESS05411 IN KEYS AND HIT
*DISPLAY STG BUTTON-NOW PUTMACHINE IN AUTOMATIC
*AND HIT START BUTTON-SHOULD CONTINUE PROGRAM
*IF PROGRAM TRANSFERRED TO ADDRESS DISPLAYED IN SR,
*YOU WILL GET AN ERROR STOP AT THE NEXT HPR
       REM
       TRA *+3        HPR WORKED OK
       HPR            ERROR STOP
       TRA *+4    
       TSX OK,4
       TRA BUT3
       REM
       REM
       REM
       BCD 1BUTTON    DISPLAY EFFECTIVE ADR
       REM            BUTTON WITH HPR
 BUT5  CLA DIS+8      L TRA BUT5+5
       STO            
       AXT 32K,1      L 77777 IN XRA
       HPR 32K,1      
       REM            
*PUT MACHINE IN MANUAL-HIT DISPLAY EFFECTIVE ADR BUTTON
*PUT MACHINE IN AUTOMATIC-HIT START AND PROGRAM SHOULD CONTINUE
*IF PROGRAM TRANSFERRED TO MODIFIED ADDRESS,
*YOU WILL GET AN ERROR STOP AT THE FOLLOWING HPR
       REM            
       TRA *+3        HPR WORKED OK
       HPR            ERROR STOP
       TRA *+4        
       TSX OK,4       
       TRA BUT5       
       REM            
       NOP            
       TSX STORE,4    TO RESTORE RESET START
       TRA *+2        
       REM            
       REM            
       BCD 1MPY       TEST ZERO MULTIPLICAND
       REM            EXECUTED IN AN I,E CYCLE
 TI    HPR            MPY TEST CARD IN CARD
       REM            READER AND READY READER
       REM            
*SET UP PREVIOUS INSTRUCTION TO BYPASS THIS TEST AFTER THE FIRST PASS
*WITH SENSE SWITCH 5 DOWN
       REM            
       CLA TI1+7      L TRA END
       STO TI         
       STZ TEMP       CLEAR LOCATION
       AXT 611,1      L 1143 IN XRA
       RCDA           SELECT CARD READER
       RCHA CW+7      
       REM            
*LOOP IN THE NEXT 2 INSTRUCTIONS UNTIL 9L ROW IS READ INTO STORAGE
       REM            
       NZT TEMP       HAS 9L ROW BEEN READ
       TRA *-1        NO
       LDQ ONES       YES, -377777777777 TO MQ
       MPY ZERO       MULTIPLICAND ALL ZEROS
       TIX *-2,1,1    LOOP 611 DECIMAL TIMES
       RCHA ZERO      CLOBBER BUFFER
       REM            
*IF MPY WITH ZERO MULTIPLICAND IS OPERATING CORRECTLY IN 2 CYCLES,
*CARD READER SHOULD READ APPROXIMATELY 8 WORDS INTO A STORAGE LOCATION
*WITHIN THE TIME ALLOTTED.COMPUTING FOR CARD READER AND A SAFETY FACTOR
*TIMINGS, THE PROGRAM WILL USE THE INFORMATION IN 5R ROW FOR A
*COMPARISON. WORDS READ THRU THE 5R ROW INDICATE MPY WITH ZERO
*MULTIPLICAND IS EXECUTING IN 2 CYCLES. IF MPY IS EXECUTING IN 20
*CYCLES IN ERROR, ENTIRE CARD WILL HAVE BEEN READ.
       REM            
       REM            
       CLA TEMP       L LAST WORD READ
       LDQ K35+1      COMPARE ACC
       CAS K35+1      WITH 5R ROW
       TRA *+3        ERROR-MORE THAN 5R READ
       TRA *+5        OK-5R READ
       TRA *+4        OK-LESS THAN 5R READ
       SWT 3          ERROR-IS PRINTER ON LINE
       TRA TI1        YES, PRINT ERROR INDICATION
       HTR END        NO-ACC CONTAINS LAST WORD
       REM            READ-MQ CONTAINS 5R ROW
       TSX OK,4       
       TRA TI         
       REM            
       REM            
       NOP            
 END   TSX PR100,2    
       TRA START-3    START ADDRESS
       REM            
       REM THIS ROUTINE IS USED TO PRINT OUT
       REM UPON COMPLETION OF 100 PROGRAM
       REM PASSES.    
       REM            
 PR100 SWT 6          TEST SENSE SWITCH 6
       TRA CRSL       
       REM            
       SWT 3          TEST SENSE SWITCH 3
       TRA BAR        BEGIN CT FOR 100 PASSES
       TRA 1,2        RETURN TO START ADDRESS
       REM            
 BAR   CLA TOP        COUNT OF 100 DECIMAL
       SUB HAT        L +1
       STO TOP        STORE IN COUNT
       TNZ 1,2        REPEAT TILL COUNT ZERO
       CLA TOP+1      RESET
       STO TOP        COUNTER
       REM            
       LXA ATTA,1     L 13 IN XRA
       WPRA           
       SPRA 3         SPACE PRINTER
       RCHA CW+2      
       LCHA CW+6      
 BOY   LCHA CW+3      
       LCHA CW+6      
       CLA CW+3       
       SUB CLUB       L +2
       STA CW+3       
       TIX BOY,1,1    
       CLA CW+4       RESTORE CONTROL WORD
       STO CW+3       
       TRA 1,2        RETURN TO START ADDRESS
       REM            
 TOP   OCT 144        
       OCT 144        
       OCT 0          
 CLUB  OCT 2          
 HAT   OCT 1          
 ATTA  OCT 13         
       REM            
 CRSL  RCDA           LOAD
       RCHA CW+5      THE
       LCHA 0         NEXT
       TRA 1          PROGRAM
       REM            
 ID    LXA ATTA,1     L 13 IN XRA
       WPRA           SELECT PRINTER
       SPRA 3         SPACE PRINTER
       RCHA CW        
       LCHA CW+6      
       LCHA CW+1      
       LCHA CW+6      
       CLA CW+1       
       SUB CLUB       L +2
       STA CW+1       
       TIX *-5,1,1    
       TRA START-3    
       REM            
*BEFORE SELECTING,THE PRINTER TO PRINT FAST MPY ERROR INDICATION,
*DELAY ABOUT 1 CARD READER CYCLE TO INSURE CARD READER DISCONNECTED
       REM            
 TI1   AXT 3,1        L 3 IN XRA
       AXT 3330,2     L 6402 IN XRB
       TIX *,2,1      
       TIX *-2,1,1    
       REM            
       WPRA           SELECT PRINTER
       SPRA 3         SPACE PRINTER
       RCHA CW+9      
       TRA END        
       REM            
*RESTORE RESET START ROUTINE
       REM            
 STORE CLA END+1      
       STO 0          
       TRA 1,4        
       REM            
*          ENTER TRAP MODE SUBROUTINE
       REM            
 ENTM  ETM            ENTER TRAP MODE
       TTR 1,2        RETURN TO TEST
       REM            
*CHECK ACCUMULATOR UNCHANGED BY EXECUTING INDICATOR INSTRUCTIONS
       REM            
       BCD 1ACCU      
 ACC   TMI *+4        OK-SIGN UNCHANGED
       LDQ TEMP+2     LOC OF INSTR TESTING
       TSX ERROR-1,4  
       TRA ACC        
       REM            
       LBT            TEST POSITION 35
       TRA *+2        ERROR-LOST POSITION 35
       TRA ACC1       OK
       LDQ TEMP+2     LOC OF INSTR TESTING
       TSX ERROR-1,4  
       TRA ACC        
       REM            
 ACC1  ARS 1          SHIFT BIT OUT OF Q
       SLW TEMP+1     SAVE ACCUMULATOR
       CLA TEMP+1     L SAVED ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR-LOST A POS Q,P,1-34
       TRA ACC2       OK-
       LDQ TEMP+2     LOC OF INSTR TESTING
       TSX ERROR-1,4  
       REM            
*NO BIT IN ACC SIGN POS,Q WAS LOST-NO BIT IN ACC 1 POS,P WAS LOST
*NO BIT IN ACC 2 POS,1 WAS LOST-NO BIT IN ACC 3 POS, 2 WAS LOST ETC.
       REM            
       TRA ACC        
       REM            
 ACC2  TOV *+1        TURN OFF OVFLO LUGHT
       TRA 1,2        
       REM            
       REM PRINT IMAGES
       REM            
 PI    OCT 1120402200         9 L
       OCT 440000010          9 R
       OCT 0                  8 L
       OCT 0                  8 R
       OCT 4004100000         7 L
       OCT 1102001000         7 R
       OCT 60600020000        6 L
       OCT 200004000          6 R
       OCT 102010040000       5 L
       OCT 100240             5 R
       OCT 41000100           4 L
       OCT 10002004           4 R
       OCT 5000               3 L
       OCT 10500              3 R
       OCT 10020              2 L
       OCT 640001             2 R
       OCT 200000             1 L
       OCT 20021000000        1 R
       OCT 20000014040        0 L
       OCT 14000640102        0 R
       OCT 145350060100       11L
       OCT 1652007404         11R
       OCT 2425703000         12L
       OCT 121110240          12R
       REM            
*ERROR PRINT IMAGE FOR MPY TIMING TEST
       REM            
 PI1   OCT 404240220          9 L
       OCT 2102000000         9 R
       OCT 41000000           8 L
       OCT 100400             8 R
       OCT 200000100          7 L
       OCT 100400000000       7 R
       OCT 10020000           6 L
       OCT 4000000            6 R
       OCT 100002             5 L
       OCT 241041020040       5 R
       OCT 14000006001        4 L
       OCT 10010000000        4 R
       OCT 3102001450         3 L
       OCT 24000201300        3 R
       OCT 0                  2 L
       OCT 4020               2 R
       OCT 4                  1 L
       OCT 40000              1 R
       OCT 5052202400         0 L
       OCT 114000200420       0 R
       OCT 12300065142        11L
       OCT 1056020100         11R
       OCT 405100235          12L
       OCT 262501141240       12R
       REM            
       REM CONSTANTS  
       REM            
 ZERO  OCT 0          
 MZE   MZE            
 ONE   OCT 1          
 TWO   OCT 2          
 MTW   MTW            
 THREE OCT 3          
 FOUR  OCT 4          
 PTHR  OCT 100000000000
 8CF   OCT 77777
 ONES  OCT 777777777777
 K3    OCT 777777077777
 K24   OCT 111111111111
 K25   OCT 154321654321
 K26   OCT 50         
 K27   OCT 222222222222
 K28   OCT 333333333333
 K29   OCT -044444444444
 K30   OCT 22000035   
 K31   OCT 777777     
 K33   OCT 111111     
 K34   OCT 333333     
 K35   OCT 400000     
       OCT 12000012   
 K37A  OCT 44000043   
 K38   SIR 0          
       SIL 0          
       RIR 0          
       RIL 0          
       IIR 0          
       IIL 0          
       RFT 0          
       LFT 0          
       RNT 0          
       LNT 0          
 TR    OCT 40         
       HTR THREE      
       HTR FOUR       
       TRA MODE1      
       TRA MODE+5     
       TRA MODE3      
       TRA MODE2+5    
       SLW TEMP+2     
 DIS   TRA BUT+6      
       TRA BUT+7      
       TRA BUT1+5     
       TRA BUT1+6     
       TRA BUT2+5     
       TRA BUT3+4     
       TRA BUT4+6     
       TRA BUT4+7     
       TRA BUT5+5     
 K16   OCT 010203040506
       TIX K16,0,4096 
       TIX K16,0,8192 
       TIX K16,0,12288 
       TIX K16,0,16384 
       TIX K16,0,20480 
       TIX K16,0,24576 
       TNX 6*K16,0,20480
 K16B  OCT 212223242526
       REM            
       REM CONTROL WORDS
       REM            
 CW    IOCT PI,0,1    
       IOCT PI+2,0,1  
       IOCT PI+1,0,1  
       IOCT PI+3,0,1  
       IOCT PI+3,0,1  
       IOCT 0,0,3     
       IOCT TOP+2,0,1 
       IOCP TEMP,0,1  
       TCH CW+7       
       IOCD PI1,0,24  
       REM            
       REM  TEMPORARY STORAGE
       REM            
 TEMP  OCT 0          
       OCT 0          
       OCT 0          
       REM            
 32K   EQU 32767      
 ERROR EQU 3396       
 OK    EQU 3401       
 LOC   EQU 3959       
       END            
