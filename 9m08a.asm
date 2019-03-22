                                                             9M08A
                                                            12-12-58
       REM            
       REM            
       REM            
       REM            
*      TRAP ENTRY     
       REM            
       ORG 8          
       REM            
T10    STO ERRAC      SAVE S, 1-35 ON TRAP
       ARS 2          
       ANA PTH        
       STO ERRQP      
       PAI            QP TO SI 1 AND 2
       SLN 4          TRAP FLAG ON
       CAL            
       ADD W1         
       STA *+1        REENTRY
       TRA            
       REM            
       ORG 24         
       REM            
       STZ            
       REM            
*      READ IN PRINT IMAGE HEADINGS
       REM            
E      RCDA           
       RCHA PRHD      
       TCOA *         WAIT
       REM            
*      ADJUST TO FILL REMAINING STORAGE WITH RANDOM NUMBERS
       REM            
       CLA RA1        L 7767
       SUB RA         L
       STO R          
       TRA E2A        TO GENERAT R.N.
       REM            
*      NORMAL RETURN FOR NEXT SET OF DATA
*      TURN ALL SENSE LIGHTS OFF
       REM            
E3     SLF            
       CLA F16        L STO ERRAC
       STO T10        RESTORE AFTER SCOPE LOOP
       REM            
*      ADJUST COUNT   
       REM            
       CLA COUNT      
       ADD W1         
       STO COUNT      L 1
       REM            
*      USE PROGRAMMED DATA OR ENTER MANUALLY DESIRED DATA
*      TEST SSW 3 FOR DESIRED TEST DATA
       REM            
       SWT 3          
       TRA R3         USE RANDOM NUMBERS
       REM            
*      WHEN SSW 3 IS DOWN, PROGRAM STOPS TO ALLOW ENTRY
*      OF ANY DESIRED PROBLEM.  FIRST STOP AT LOCATION 47
*      TO ENTER ACC LOAD INTO MQ.  PUSH START.  NEXT
*      STOP AT 55 TO ENTER SR LOAD INTO MQ.
       REM            
       HPR            LOAD ACC NUMBER INTO MQ
       ENK            
       STQ ACC        
       STQ TN1A       
       REM            
       HPR            LOAD SR NUMBER INTO MQ
       ENK            
       STQ SR         
       STQ TN2A       
       TRA E4         
       REM            
*      ADJUST RANDOM NUMBER PRIMES
       REM            
E2     LDQ RN+7       L RANDOM NUMBER
       RQL 5          
       STO RN+7       
       REM            
       LDQ RN         L RANDOM NUMBER
       RQL 15         
       STQ RN         
       REM            
       LDQ RN+3       L RANDOM NUMBER
       RQL 7          
       STQ RN+3       
       REM            
       CLA R2A        ADJUST INSTRUCTION
       STA R3A        AT L R3A
       REM            
*      GENERATE RANDOM NUMBERS TO FILL REMAINING STORAGE
       REM            
E2A    CAL RN+7       L RANDOM NUMBER PRIME
       LXA R,4        
R2     ADM 4087,4     
R2A    SLW 4095,4     
       TIX R2,4,1     
       STZ ACC        
       LXA R,4        
       STZ TN1A       
       STZ SR         
       STZ TN2A       
       TRA E4         
       REM            
*      SAVE ACC AND SR LOAD FR0 PROBLEM UNDER TEST
       REM            
R3     CLA 4087,4     
       STO TN1A       ACC LOAD SAVE
       STO ACC        ACC LOAD SAVE
       CLA R3A        
       SUB W1         L 1
       STA R3A        ADJUST ADDRESS
       REM            
R3A    CLA 4095       
       STO TN2A       SR LOAD SAVE
       STO SR         SR LOAD SAVE
       TIX E4,4,1     
       REM            
*      ADJUST RANDOM NUMBER PRIMES FOR NEW TEST DATA
       REM            
       TRA E2         
       REM            
*      SELECT THE CORRECT INSTRUCTION TO BE TESTED
*      FAD, FSB, UFA, OR UFS
*      RETURN HERE WHEN KEEPING SAME DATA
*      SSW 4 DOWN AND NO ERRORS
       REM            
E4     SWT 1          TEST SSW 1
       TRA E5         FAD OR UFA
       SLN 2          FSB TURN SL 2 ON
       REM            
E5     SWT 2          TEST SSW 2
       TRA E6         FAD OR FSB
       SLN 3          UFA OR UFS SL 3 ON
       REM            
*      ADJUST CONSTANTS FOR I TIME ON ENTERING TEST
       REM            
*      ENTER HERE FROM SSW 6 INTERROGATION FOR FORCED PRINT-OUT
       REM            
E6     CLA W1111      L ALL ONES
       STO MQ         
       REM            
       CLA FOR        L-ALL ZEROS
       STO NOV1       -ALL ZEROS
       STO Q1         -ALL ZEROS
       STO T33        
       STO T22        
       REM            
       STZ T11        
       STZ CACC       
       STZ NIN1       
       REM            
*      TEST SL ONE-ON FOR ERROR AND FORCE PRINT OUT
       REM            
       SLT 1          
       TRA A1         OFF-GO TO E TIME
       SLN 1          ON-TURN BACK ON
       TRA P1         AND GO TO PRINT
       REM            
*      BEGIN E TIME   
       REM            
*      IS THIS ADDITION OR SUBTRACTION
       REM            
A1     SLT 2          
       TRA A2A        ADD
       REM            
       SLN 2          SUB TURN SL 2 ON AGAIN
       REM            
*      SET SR MINUS FOR SUB
       REM            
       CLA SR         
       CHS            CHANGE SIGN
       STO SR         
       REM            
*      TRANSFER CONTROL AT LOCATION C1 FOR CORRECT RETURN AFTER PRINT
       REM            
A2A    CLA K15        L TRA A3
       STA C1         
       REM            
*      E TO MASTER IMAGE
       REM            
       CLA K9         L +1000000000000
       ORS M+8        
       ORS M+22       
       ALS 1          +2000000000000
       ORS M+14       
       REM            
       CLA TC         L 2
       ORS M+16       
       REM            
       CLA FOR        L-ALL ZEROS
       STO NIN1       
       STZ T33        
       REM            
*      TEST SL ONE-ONE FOR ERROR AND FORCE PRINT OUT
       REM            
       SLT 1          
       TRA A3         OFF-OK
       SLN 1          ON-TURN BACK ON
       TRA P3         AND GO TO PRINT
       REM            
*      ER TIME STEP 1 
       REM            
*      COMPARE ACC TO SR
       REM            
A3     CLA SR         
       SSP            SET SIGN PLUS
       ARS 27         SAVE
       STO WV1        CHARACTERISTIC
       REM            
       CLA ACC        
       SSP            SET SIGN PLUS
       ARS 27         SHIFT CHAR TO RIGHT
       REM            
       CAS WV1        
       TRA A4         SR LESS THAN ACC
       REM            
       NOP            SR EQUAL ACC
       CLA W0         SR MORE THAN ACC
       STO Q1         Q CARRY
       TRA A5         
       REM            
*      EXCHANGE CONTENTS OF SR AND ACC
       REM            
A4     CLA SR         SR TO
       STO ACC        ACC AND
       CLA TN1A       ACC TO
       STO SR         SR
       REM            
*      PART 2 AND 3 OF STEP 1 ER TIME
       REM            
*      COMPUTE DIFFERENCE OF THE CHARACTERISTICS
       REM            
A5     CLA ACC        
       SSP            
       COM            SET FOR SUBTRACTION
       ARS 27         SHIFT CHAR TO RIGHT
       STO WV1        SAVE CHAR
       REM            
       CLA SR         
       SSP            
       ARS 27         SHIFT CHAR TO RIGHT
       ADD WV1        SUB ACC CHAR FROM SR
       ADD W1         L 1
       STO WV1        SAVE DIFFERENCE
       REM            
*      TEST FOR Q CARRY
       REM            
       ALS 25         Q CARRY INTO P BIT
       PBT            
       TRA A5L        NO Q CARRY
       CLA W0         L ZERO
       STO Q1         SAVE Q CARRY CONDITION
       REM            
*      PLACE DIFFERENCE IN SHIFT COUNTER
       REM            
A5L    CLA WV1        SHIFT OUT Q CARRY
       ALS 29         Q AND P BITS OUT
       ARS 29         SHIFT COUNTER VALUE
       STO SC         SAVE
       REM            
*      IS DIFFERENCE IN CHARACTERISTICS GREATER THAN 77 OCTAL
       REM            
       CAS K77        L 77
       TRA GTR        CHAR GREATER THAN 77
       TRA CLMQ       CHAR EQUAL TO 77
       TRA CLMQ       CHAR LESS THAN 77
       REM            
*      RESET ACC AND SHIFT COUNTER TO ZERO
       REM            
GTR    CLA W0         L 0
       STO SC         RESET SHIFT COUNTER
       STZ ACC        
       CLA SR         
       TPL CLMQ       
       CLA FOR        
       STO ACC        RESET ACC
       REM            
*      CLEAR MQ       
       REM            
CLMQ   STZ MQ         
       REM
       CLA ACC        
       ANA FMASK      
       ARS 2          
       STO CACC       
       REM            
*      STEP TALLY COUNTER
       REM            
       CLA TC         STEP
       ORS M+14       TALLY COUNTER
       REM            
*      GIVE MQ THE SAME SIGN AS THE ACC
       REM            
       CLA ACC        MQ
       LDQ MQ         SIGN
       LRS            LIKE
       STQ MQ         ACC
       REM            
*      TRANSFER CONTROL AT LOCATION C1 FOR CORRECT RETURN AFTER PRINT
       REM            
       CLA K29        L TRA A8
       STA C1         
       REM            
*      TEST SL ONE-ON FOR ERROR AND FORCE PRINT OUT
       REM            
       SLT 1          
       TRA A8         OFF-OK
       SLN 1          ON-TURN BACK ON
       TRA P3A        AND GO TO PRINT
       REM            
*      ER TIME, SECOND STEP
*      USED TO EQUALIZE CHARACTERISTIC IN PREPARATION FOR
*      ADDITION AND A CHECK FOR A NON-ZERO MQ
       REM            
       REM            
*      SHIFT 12 PLACES TO COINCIDE WITH 12 MICRO-SECOND
*      MACHINE CYCLE  
       REM            
A8     CLA SC         SHIFT COUNTER VALUE
       STO TEMP       
       SUB W12        L DEC 12
       TMI A9         SC LESS THAN 12
       STO SC         SAVE DIFFERENCE WHEN
       REM            SC 12 OR MORE
       REM            
*      SHIFT F ACC AND MQ RT N PLACES
       REM            
A11    CLA MQ         PLACE MQ FRACTION
       LRS 27         INTO SHIFT POSITION
       STO K19        SAVE
       REM            
       CLA ACC        PLACE ACC FRACTION
       ALS 10         INTO SHIFT POSITION
       ARS 10         
       REM            
A10    LRS 12         SHIFT ACC AND
       STO WV2        MQ RT 12 PLACES
       REM            AND SAVE
       REM            
       CLA ACC        CLEAR ACC
       ARS 27         OF FRACTION
       ALS 27         SHIFT CHAR BACK
       STO ACC        9-35 CLEARED
       CLA WV2        
       REM            
*      ADJUST ACC WITH CORRECT FRACTION AFTER
*      EACH FULL 12 MICROSECOND MACHINE CYCLE
*      AND SHIFT OF 12 PLACES WHEN NEEDED
       REM            
       ORS ACC        ADJUST ACC
       CLM            CLEAR ACC SAVE SIGN
       REM            
*      ADJUST MQ AFTER EACH 12 MICROSECOND MACHINE CYCLE
*      AND SHIFT OF 12 PLACES WHEN NEEDED
       REM            
       LRS 8          CORRECTLY POSITION MQ
       STQ MQ         
       CLA MQ         
       ANA CMASK      
       TZE *+2        
       REM            
*      MQ 9 INPUT TURN T2 ON
       REM            
       STZ T22        SAVE T2 STATUS
       REM            
       REM            
*      ADJUST ADDRESSES OF SHIFT INSTRUCTIONS
       REM            
       CLA W12        DEC 12 OCT 14
       STA A10        
       STA K37        
       REM            
*      TRANSFER CONTROL AT LOC C1 FOR CORRECT RETURN AFTER PRINT
*      ADJUST ADDRESS AT A12A FOR CORRECT TRANSFER WHEN SL 1 OFF
       REM            
       CLA K29        L TRA A8
       STA C1         
       STA A12A       
       REM            
*      TRANSFER TO A9B IS MADE WHEN SC VALUE IS MORE THAN 12
*      WHEN SC IS LESS THAN 12 THE INSTRUCTION AT A9A
*      IS ADJUSTED TO A NOP INSTRUCTION
       REM            
A9A    TRA A9B        
       REM            
*      TRANSFER CONTROL AT LOC C1 FOR CORRECT RETURN AFTER PRINT
       REM            
*      IF EVEN, PRINT ANOTHER CYCLE FOR ALL
*      FP INSTRUCTION TESTS
       REM            
       CLA TEMP       
       TZE ODD        
       COM            SWITCH POLARITY
       LBT            NO LOW BIT TEST
ODD1   TRA ODD        
EVEN   CLA ODD1       
       STA C1         
       STA A12A       
       TRA A9B        
       REM            
ODD    CLA K8         L TRA A13
       STA C1         TRA CNTRL AT C1
       STA A12A       TRA CNTRL AT A12A
       REM            
*      STEP TALLY COUNTER
       REM            
       CLA TC         
       ORS M+12       STEP TC
       REM            
A9B    TRA A12        TO TEST SL 1
       REM            
*      ENTER HERE WHEN SHIFT COUNTER VALUE IS LESS THAN 12
       REM            
       REM            
*      ADJUST ADDRESSES OF SHIFT INSTRUCTIONS WHEN SC LESS THAN 12
       REM            
A9     CLA SC         L OF NUMBER OF SHIFTS
       STA A10        
       STA K37        ADJUSTMENT FOR SHIFT
       REM            WHEN LESS THAN 12
       CLA WV2        
       REM            
*      RESET SHIFT COUNTER VALUE
       REM            
       CLA W0         L 0
       STO SC         
       REM            
*      SHIFT COUNTER VALUE LESS THAN 12 PLACE NOP INST IN A9A
       REM            
       CLA W101       L NOP INST
       STO A9A        STO NOP
       TRA A11        MAKE PASS SC LESS THAN 12
       REM            
*      TEST SL 1 - ON FOR ERROR AND FORCE PRINT OUT
       REM            
A12    SLT 1          TEST SL 1
A12A   TRA A13        OFF
       SLN 1          WAS ON TURN BACK ON
       TRA P3A        AND GO TO PRINT
       REM            
*      RESTORE TRA INSTRUCTION AT LOCATION A9A
       REM            
A13    CLA W100       L TRA A9B
       STO A9A        
       REM            
       REM            
*      ER TIME THIRD STEP
       REM            
*      MQ ZERO TEST   
       CLA MQ         
       TNZ A14        MQ NOT ZERO
       REM            
*      TURN T2 OFF MQ ZERO
       REM            
       CLA FOR        L -ALL ZEROS
       STO T22        SAVE T2 STATUS
       REM            
       REM            
*      CHECK SIGNS OF ACC AND SR, ARE THEY ALIKE
       REM            
A14    CLA ACC        
       LDQ SR         
       TMI F1A        ACC- CHECK SR
       REM            
       TQP F2         ACC+ AND SR+
       TRA F1B        ACC+ AND SR-
F1A    TQP F1B        ACC- AND SR+
       TRA F2         ACC- AND SR-
       REM            
*      SIGNS UNLIKE. SUBTRACT SR AND ACC FRACTIONS
       REM            
F1B    CLA SR         
       ALS 10         Q,P,1-8 OUT
       ARS 10         9-35 BACK TO POSITION
       SLW K16        SAVE FRACTION
       REM            
       CLA ACC        
       LDQ ACC        
       ALS 10         Q,P,1-8 OUT
       COM            COM 9-35
       ARS 10         9-35 COMP BACK TO POS
       SSP            SET SIGN OF ACC PLUS
       ADD K16        SR FRACTION
       REM            
*      CHECK FOR 9 CARRY
       REM            
       ALS 8          SHIFT 8 TO P
       PBT            P BIT TEST FOR 9 CARRY
       TRA F1BB       NO 9 CARRY
       ALS 2          THERE WAS A 9 CARRY
       ARS 10         
       LLS            
       REM            MOVE IT OUT, P AND Q
       STO ACC        
       REM            
       CLA T22        L T2 FLAG
       TPL F11B       TRA WHEN T2 ON
       STZ MQ         
       CLA ACC        T2 OFF
       SSP            
       ADD W1         L 1
       LLS            
       STO ACC        9 CARRY TO 35
       REM
       REM
F11B   CLA SR         
       ANA FMASK      MASK OUT FR ACC
       ORS ACC        
       ARS 2          
       STO CACC       
       REM            
       REM            
*      T2 ON, MOVE MQ TO SR, HOLD SR S
       REM            
       CLA W0         L 0
       STO NOV1       9 CARRY
       REM            
       CLA NIN        L 10
       ORS M+3        
       ORS M+11       
       CLA T22        
       TMI T2FF       T2 OFF
       REM            
       REM            
*      T2 ON WITH 9 CARRY F SR GREATER F ACC
*      MOVE MQ TO ACC FOR COMPLEMENTING
*      SAVE ACC IN SR. 
       REM            
*      ORIGINAL ACC AND SR SIGNS SAVED
       REM            
       CLA ACC        S-35
       STO TEMP       SAVE
       REM            
       CLA SR         S-35
       TMI SRM        CHECK SIGN
       CLA ACC        
       SSP            SAVE SR SIGN
       STO SR         
       TRA ACCK       
       REM            
SRM    CLA ACC        
       SSM            SAVE SR SIGN
       STO SR         
       REM            
ACCK   CLA TEMP       L ACC
       TMI ACCM       
       CLA MQ         
       SSP            SAVE ACC SIGN
       STO ACC        
       TRA 3MG        
       REM            
ACCM   CLA MQ         
       SSM            SAVE ACC SIGN
       STO ACC        
       REM            
*      READY TO STEP TALLY COUNTER
       REM            
       TRA 3MG        MERGE FOR TC STEP
       REM            
       REM            
*      9CARRY WITH T2 OFF F SR GREATER THAN F ACC
*      TRUE FORM, MQ EQUAL ZERO, SIGNS INCORRECT
*      INVERT ACC AND MQ SIGNS
       REM            
T2FF   CLA ACC        S-35
       TMI *+7        
       SSM            PLUS TO MINUS
       STO ACC        STORE WITH NEW SIGN
       CLA MQ         
       SSM            
       STO MQ         
       TRA INST       
       REM            
       SSP            ACC AND MQ
       STO ACC        MINUS TO PLUS
       LDQ W0         
       STQ MQ         
       REM            
*      TEST INST. IF UFA/UFS END OP
*      SENSE LIGHT 3 ON IF UFA/UFS
       REM            
INST   SLT 3          TEST SL 3
       TRA 3MG        MERGE TO STEP TC
       SLN 3          
       TRA NNMG       UFA/UFS
       REM            
*      NO 9 CARRY SIGNS UNLIKE
*      RECOMPLEMENT ACC
       REM            
F1BB   ARS 8          SHIFT ACC BACK
       COM            RECOMPLEMENT
       ANA CMASK      
       LLS            
       STO ACC        AND SAVE
       REM            
       CLA SR         
       ANA FMASK      
       ORS ACC        
       ARS 2          
       STO CACC       
       TRA INST       TEST INST
       REM            
       REM            
*      SIGNS WERE ALIKE
*      ADD SR AND ACC FRACTIONS
       REM            
F2     ALS 10         SHIFT CHAR. OUT
       ARS 2          BAC TO 1 FROM Q
       SLW K16        
       LDQ ACC        
       CLA ACC        
       LRS            
       ANA CMASK      
       ADM SR         
       ARS 2          
       STO CACC       
       REM
       CAL SR         
       ALS 10         SHIFT CHAR. OUT
       ARS 2          BACK TO 1 FROM Q
       ADD K16        
       REM            
*      TEST FOR 9 CARRY INTO P BIT
       REM            
       PBT            DID 9 CARRY OCCUR
       TRA F2A        NO
       ARS 8          YES. SHIFT INTO F POS.
       LLS            
       STO K16        SAVE
       REM            
*      SHIFT FRACTION ACC AND MQ RIGHT ONE
       REM            
       LDQ MQ         
       LRS 1          SHIFT RIGHT ONE
       STO K17        SAVE
       REM            
       LDQ MQ         
       LLS            
       ARS 27         SHIFT ACC 9-35 RT
       ALS 27         SHIFT CHAR BACK
       STO K17        
       REM            
       CLA MQ         
       LRS 27         
       CLA K16        
       LRS 1          ACC 35 TO MQ
       STO ACC        F ACC AND SIGN
       REM            
       CLA W0         
       LLS 27         
       ORS K17        
       REM            
       CLA K17        
       STO MQ         
       CLM            
       LDQ SR         
       LLS 8          
       SSP            
       ADD W1         ONE TO ACC 9
       REM            
       ALS 27         
       STO K17        
       REM            
F2AB   ANA FMASK      
       ORS ACC        
       CLA NOV        
       ORS M+3        
       ORS M+11       
       CLA NIN        L 10
       ORS M+3        
       ORS M+11       
       TRA F3         TEST FOR UFA/UFS
       REM            
*      NO 9 CARRY. SHIFT INTO FRACTION POSITION
       REM            
F2A    ARS 8          SHIFT INTO FR POS
       LLS            
       STO ACC        
       CLM            
       LDQ SR         
       LLS 8          
       ALS 27         
       ORS ACC        CONTENTS ACC
       REM            
*      TEST SL 3 TO SEE IF WE ARE WORKING WITH
*      NORMALIZED OR UNNORMALIZED INSTRUCTIONS
       REM            
F3     SLT 3          TEST SL 3
       TRA 3MG        OFF. ON TO FAD/FSB
       SLN 3          ON. TURN BACK ON
       TRA NNMG       NOT NORMALIZING.
       REM            
*      STEP TC        
       REM            
NNMG   CLA TC         
       ORS M+10       
       REM            
*      TRANSFER CONTROL AT C1 FOR CORRECT RETURN AFTER PRINT
       REM            
       CLA K38        L TRA G
       STA C1         
       REM            
*      TEST SL 1 FOR ERROR
       REM            
       SLT 1          
       TRA G          OFF
       SLN 1          ON, TURN BACK ON
       TRA P3A        AND GO TO PRINT
       REM            
*      MERGE TO STEP TC
       REM            
3MG    CLA TC         
       ORS M+10       
       REM            
*      TEST SL 1 FOR ERROR
       REM            
       SLT 1          
       TRA F5         OFF GO TO STEP 4
       SLN 1          ON. TURN BACK ON
       CLA K20        L TRA TO F5
       STA C1         
       TRA P3A        GO TO PRINT
       REM            
       REM            
*      ER TIME 4TH STEP
       REM            
       REM            
*      ER TIME STEP 4 
*      USED TO ZERO-TEST THE ACC OR TO COMPLEMNT THE MQ
       REM            
F5     CLA T22        TEST T2
       TPL F8         T2 ON
       REM            
*      T2 OFF, MQ EQUAL ZERO. ZERO TEST ACC
       REM            
       CLA FOR        L -ALL ZEROS
       STO T33        
       CLA ACC        
       ALS 10         
       TZE F7         ACC ZERO
       TRA F8         ACC NOT ZERO
       REM            
*      TURN T1 OFF    
       REM            
F7     CLA FOR        L -ALL ZEROS
       STO T11        
       REM            
       CLA NIN        
       ORS M+3        ADJUST
       ORS M+11       PRINT
       CLA ACC        
       REM            
*      RESET ACC Q-35 
       REM            
       CLM            
       STO ACC        
       REM            
       CLA MQ         CLEAR
       ALS 10         1-8
       ARS 10         
       STO MQ         
       CLA K26        L TRA G
       STA C1         
       REM            
*      TEST SL 1 FOR ERROR
       REM            
       SLT 1          
       TRA G          OK
       SLN 1          ON, TURN BACK ON
       TRA P3A        AND GO TO PRINT
       REM            
       REM            
*      CHECK SIGNS OF ACC AND SR. ARE THEY ALIKE
       REM            
F8     CLA TC         ADJUST
       ORS M+8        FOR PRINT
       REM            
       CLA ACC        
       LDQ SR         
       TMI F8A        ACC -
       TQP F88B       ACC + MQ + LIKE
       TRA F8C        ACC + MQ - UNLIKE
F8A    TQP F8C        ACC - MQ + UNLIKE
       TRA F88B       ACC - MQ - LIKE
       REM            
F8C    CLA NOV1       
       TPL *+2        
       TRA F88B       OFF
       REM            
       CLA ACC        PORTION OF SUM IN MQ
       ALS 10         MQ SHIFTED TO ACC
       COM            ACC CONTENTS IN SR
       ARS 10         CARRY OUT OF ADD 9
       LRS            
       SSP            
       ADD W1         MUST BE ADDED TO MQ 35
       LLS            
       STO ACC        ACC NORMALIZED
       REM            
*      EXCHANGE ACC AND SR
       REM            
       CLA SR         S-35
       STO TEMP       SAVE
       TMI SRMS       CHECK SIGN
       CLA ACC        ACC
       SSP            TO
       STO SR         SR
       TRA ACX        
       REM            
SRMS   CLA ACC        ACC
       SSM            TO
       STO SR         SR
       REM            
ACX    CLA ACC        
       TMI ACMS       CHECK SIGN
       CLA TEMP       
       SSP            SR
       STO ACC        TO
       TRA SRMQ       
       REM            ACC
ACMS   CLA TEMP       SR
       SSM            
       STO ACC        ACC
       REM            
*      RETURN MQ AND ADJUST ACC SIGN
       REM            
SRMQ   CLA SR         
       STO MQ         
       REM            
       CLA ACC        
       CHS            
       STO ACC        
       REM            
F88B   CLA K377       L 377
       STO SC         SET SC TO ALL ONES
       REM            
       CLA FOR        TURN
       STO T22        T2 OFF
       REM            
*      TEST ACC 9, ZERO OR ONE
       REM            
       CLA ACC        S-35
       ALS 9          9 TO P
       PBT            P BIT TEST
       TRA F8D        NO BIT IN 9
       REM            
*      TURN T3 ON     
       REM            
       TRA F8E        BIT IN 9
F8D    CLA FOR        L - ALL ZEROS
       STO T33        
       TRA F8B        
F8E    STZ T33        T3 ON
       STZ T22        
       REM            
F8B    CLA TC         STEP
       ORS M+8        TALLY COUNTER
       REM            
*      TRANSFER CONTROL AT C1
       REM            
       CLA K22        L TRA F9
       STA C1         
       REM            
       STA N4+1       
       SLT 3          
       TRA N4         
       SLN 3          
       CLA K38        L TRA G
       STA C1         
       STA N4+1       
       REM            
*      TEST SL 1 FOR ERROR
       REM            
N4     SLT 1          
       TRA F9         OFF
       SLN 1          ON, TURN BACK ON
       TRA P3A        AND GO TO PRINT
       REM            
       REM            
*      ER TIME STEP 5 
*      ADJUST SUM IN ACC AND MQ
       REM            
       REM            
*      TEST T3, ON OR OFF
       REM            
F9     CLA T33        
       TPL F9K        T3 ON
       REM            
F9A    AXT 12,1       
       CLA MQ         
       ANA CMASK      MASK OUT CHAR
       ALS 8          ACC 9 TO 1
       XCA            EXCHANGE MQ AND ACC
       CLA ACC        
       ANA CMASK      MASK OUT CHAR
       REM            
F9B    LLS 1          
       STO TEMP       SHIFTED ACC FR
       PAI            
       REM            
       CLA MQ         
       ALS 1          
       STO MQ         
       REM            
       LFT 400        TEST FOR 9 OFF
       TRA F9D        THRU  ACC 9 EQUAL 1
       REM            
       CLA SC         L SHIFT COUNTER
       SUB W1         L 1  REDUCE SC
       STO SC         
       REM            
       CLA TEMP       ACC FR SHIFTED
       TIX F9B,1,1    FINISH 12 SHIFTS
       REM            
       CLA W101       L NOP
       STO F9H        XFER CONTROL
       TRA F9D+5      
       REM            
F9D    CLA SC         
       SUB W1         L 1
       STO SC         
       CLA KTRA       L TRA F9J
       STO F9H        XFER CONTROL
       REM            
       CLA ACC        
       LRS            SAVE SIGN
       ANA FMASK      SAVE CHAR AC
       LLS            GET SIGN
       STO ACC        CHAR ACC + SIGN
       REM            
       CLA TEMP       FRAC ACC SHIFTED
       ORS ACC        PUT WITH CHAR
       CLA MQ         
       LRS            SAVE SIGN
       ANA FMASK      SAVE CHAR
       LLS            GET SIGN
       STO MQ         STORE CHAR + SIGN
       REM            
       XCA            MQ TO ACC
       ARS 8          POSITION TO FRAC
       ORS MQ         PUT WITH CHAR
F9H    NOP            CONTROL POINT
       REM            
       CLA KF9A       L PZE F9A
       STA C1         XFER CONTROL
       STA GA         XFER CONTROL
       TRA F9G        
       REM            
F9J    CLA W0         
       STO T33        SET T3 FLAG ON
       CLA SC         
       SUB K377       L 377  GET NO SHIFTS
       LBT            TEST FOR ODD NUMBER
       TRA F9E        EVEN NUMBER
       REM            
F9F    CLA ACC        
       LRS            SAVE SIGN
       ANA CMASK      SAVE FRAC
       LLS            GET SIGN
       STO ACC        SAVE FRAC + SIGN
       CLA SC         
       ANA K177       L 177   MASK SC 11
       ALS 25         POSITION
       ADM CACC       
       ADD QP18       L BITS IN QP18
       STO CACC       SC + CACC+ QP18
       ALS 2          
       ANA FMASK      
       ORS ACC        PUT CHAR WITH FRAC
       STZ T22        
       REM            
F9K    CLA K26        L PZE G
       STA C1         XFER CONTROL
       STA GA         XFER CONTROL
       TRA F9G        
       REM            
F9E    CLA KF9F       L PZE F9F
       STA C1         ZFER CONTROL
       STA GA         XFER CONTROL
F9G    SLT 1          TEST SL 1
GA     TRA G          OFF OK
       SLN 1          ON. TURN BACK ON
       TRA P3A        AND GO TO PRINT
       REM            
*      BEGIN I TIME NORMALIZED
*      -----------------------
       REM            
*      COMPUTE SPILL CODE
       REM            
G      CLA CAMASK     
       ANS CACC       
       CLA CACC       
       PAI            
       LNT 300000     
       TRA *+3        
       OSI M16        
       TRA GGA        
       LNT 100000     
       TRA GGA        
       OSI M15        
       OSI M16        
GGA    STI SIMCOD     
       REM            
*      SET CHAR OF MQ TO 27 DEC LESS THAN CHAR OF ACC
       REM            
       CLA T11        
       TMI FA11       
       REM            
       CLA MQ         
       ALS 10         SHIFT OUT CHAR
       ARS 10         SHIFT BACK
       STO MQ         SAVE MQ FRAC
       REM            
       CLA CACC       L ACC CHAR
       ADD COM32      L COMPLEMENT 32 OCT
       REM            
*      COMPUTE SPILL CODE
       REM            
       PAI            
       LNT 300000     
       TRA *+3        
       OSI M17        
       TRA GG         
       LNT 100000     
       TRA GG         
       OSI M15        
       OSI M17        
GG     ALS 2          
       ANA FMASK      SAVE CHAR ACC- 27
       ORS MQ         SET WITH FR
       PIA            
       ORS SIMCOD     
       REM            
 FA11  CLA K7         L TRA ERP
       STA C1         TRANSFER CONTROL
       REM            
       CLA K34        L 377
       STO SC         
       CLA K9         
       ORS M          
       ORS M+22       SET I TO IMAGE
       CLA K35        
       STO SR         
       REM            
       CLA TC         
       ORS M+16       
       CLA CACC       
       ANA PTH        
       STO CACC       
       STZ NIN1       9 CARRY ON
       STZ T11        T1 ON
       CLA FOR        L -ALL ZEROS
       STO NOV1       
       STO T33        
       STO Q1         
       STO T22        
       REM            
*      TEST SL 1      
       REM            
       SLT 1          
       TRA F12        GO TO FP VS NON-FP
       TRA P3B        TO PRINT
       REM            
*      COMPARE FP RESULTS WITH NON-FP RESULTS
       REM            
F12    TOV F12B       
F12B   CLA TN1A       
       LDQ W1111      
       REM            
*      TEST SLT 2 FOR ADD OR SUB
       REM            
       SLT 2          TEST SL 2
       TRA F14        ADD
       SLN 2          SUB SL 2 BACK ON
       REM            
*      TEST SLT 3 FOR FSB OR UFS
       REM            
       SLT 3          TEST SL 3
       TRA F13        FSB
       SLN 3          UFS SL 3 BACK ON
       REM            
       UFS TN2A       
       TRA F16        GO TO COMPARE
       TRA F16+1      
F13    FSB TN2A       
       TRA F16        GO TO COMPARE
       TRA F16+1      
       REM            
*      TEST FOR FAD OR UFA
       REM            
F14    SLT 3          TEST SL 3
       TRA F15        FAD
       SLN 3          UFA SL 3 BACK ON
       REM            
       UFA TN2A       
       TRA F16        GO TO COMPARE
       REM            
       TRA F16+1      
F15    FAD TN2A       
F16    STO ERRAC      ACC ERROR
       STQ ERRMQ      MQ ERROR
       REM            
*      TEST OVERFLOW FLAG
       REM            
       SLT 4          
       TRA *+3        
       SLN 4          
       TRA F16C       
       ARS 2          
       STZ            
       ANA PTH        
       PAI            Q,+ IF NO TRAP
       STO ERRQP      
       REM            
*      COMPARE ACC RESULTS
       REM            
F16C   CLA ERRAC      
       CAS ACC        
       TRA F18        ERROR TO PRINT
       TRA F17        ACC CORRECT
       TRA F18        ERROR TO PRINT
       REM            
*      COMPARE Q AND P BITS
       REM            
F17    ONT CACC       
       TRA F18        ERROR
       REM            
*      COMPARE SPILL IDENTIFICATION CODES
       REM            
       LDI            
       STZ            
       STI ERRCOD     
       CLA SPMSK      
       ANS SIMCOD     
       ONT SIMCOD     
       TRA F18        ERROR
       REM            
*      COMPARE MQ RESULTS
       REM            
       CLA ERRMQ      
       CAS MQ         COMPARE
       TRA F18        ERROR TO PRINT
       TRA FOV1       
       TRA F18        ERROR TO PRINT
       REM            
*      TEST SSW 6 FOR FORCE PRINT OUT
       REM            
FOV1   SWT 6          
       TRA F17B       UP
       TRA F18        TO PRINT
       REM            
*      TEST SSW 4 FOR CHANGE IN TEST DATA
       REM            
F17B   SWT 4          
       TRA E3         UP USE R.N. TEST DATA
       CLA TN1A       DN NO CHANGE TEST DATA
       STO ACC        RESTORE ACC
       REM            
       CLA TN2A       RESTORE SR
       STO SR         
       REM            
       TRA E4         
       REM            
*      ADJUST TO ENTER PRINT OUT
       REM            
F18    CLA TN1A       
       STO ACC        RESTORE ACC
       REM            
       CLA TN2A       
       STO SR         RESTORE SR
       REM            
*      ERROR CONDITIONS EXIST.  TURN ERROR SENSE LIGHT ON
*      REWORK FROM BEGINNING AND PRINT OUT AFTER EACH
*      MACHINE CYCLE TO LOCATE ERROR CYCLE.
       REM            
       SLN 1          ERROR SENSE
       TRA E6         REWORK AND PRINT
       REM            
*      ENTER HERE AFTER ERROR PRINT-OUT FOR CYCLE KEY USE
       REM            
F19    TOV F19B       
F19B   LDQ W1111      
       NOP            
       CLA TN1A       
       REM            
*      SELECT CORRECT INSTRUCTION UNDER TEST
       REM            
       SLT 2          TEST FOR SUB
       TRA F21        ADD
       SLT 3          TEST FOR FSB OR UFS
       TRA F20        FSB
       SLN 3          UFS 3 BACK ON
       REM            
*      HALT TO BEGIN MACHINE CYCLE KEY
       REM            
       HPR            
       REM            
       UFS TN2A       
       REM            
       HPR            
       REM            
*      TEST SWT 5 TO SCOPE OR CONTINUE
       REM            
       SWT 5          TEST SWT 5
       TRA E3         UP CONTINUE TEST
       TRA LOOP4      SCOPE LOOP FOR UFS
       REM            
F20    HPR            
       REM            
*      BEGIN MACHINE CYCLE KEY FOR FSB
       REM            
       FSB TN2A       
       REM            
       HPR            
       REM            
       SWT 5          TEST SSW 5
       TRA E3         CONTINUE TEST
       TRA LOOP3      SCOPE LOOP FOR FSB
       REM            
*      TEST SL 3 TO TEST CORRECT INSTRUCTION
       REM            
F21    SLT 3          
       TRA F22        
       REM            
       HPR            
       REM            
*      BEGIN MACHINE CYCLE KEY FOR UFA INSTRUCTION
       REM            
       UFA TN2A       
       REM            
       HPR            
       REM            
*      TEST SSW 5 TO SCOPE OR CONTINUE
       REM            
       SWT 5          
       TRA E3         CONTINUE TEST
       TRA LOOP2      SCOPE LOOP FOR UFA
       REM            
F22    HPR            
       REM            
*      BEGIN MACHINE CYCLE KEY FOR FAD INSTRUCTION
       REM            
       FAD TN2A       
       REM            
       HPR            
       REM            
*      TEST SWT 5 FOR SCOPE OR CONTINUE
       REM            
       SWT 5          
       TRA E3         CONTINUE TEST
       TRA LOOP1      SCOPE LOOP FOR FAD
       REM            
       REM            
*      ENTER SCOPING ROUTINES FOR FAD, UFA, FSB, AND UFS
       REM            
LOOP1  CLA L11        L TRA TO LOOP1+2
       STO T10        
       SWT 5          TEST SSW 5
       TRA E3         CONTINUE TEST
       CLA TN1A       ENTER TIGHT SCOPE LOOP
       FAD TN2A       
       TRA LOOP1+2    
       REM            
LOOP2  CLA L2         L TRA LOOP2+2
       STO T10        
       SWT 5          TEST SSW 5
       TRA E3         CONTINUE TEST
       CLA TN1A       ENTER TIGHT SCOPE LOOP
       UFA TN2A       
       TRA LOOP2+2    
       REM            
LOOP3  CLA L3         L TRA LOOP3+2
       STO T10        
       SWT 5          TEST SSW 5
       TRA E3         CONTINUE TEST
       CLA TN1A       ENTER TIGHT SCOPE LOOP
       FSB TN2A       
       TRA LOOP3+2    
       REM            
LOOP4  CLA L4         L TRA LOOP4+2
       STO T10        
       SWT 5          TEST SSW 5
       TRA E3         CONTINUE TEST
       CLA TN1A       ENTER TIGHT SCOPE LOOP
       UFS TN2A       
       TRA LOOP4+2    
       REM            
*      MAKE ADJUSTMENTS FOR PRINT OUT
*      ------------------------------
       REM            
*      STEP COUNTER FOR CYCLE NUMBER
       REM            
P3A    CLA K9         L +1000000000000
       ORS M+8        ADJUST
       ORS M+22       MASTER IMAGE
       ARS 1          LOCATIONS
       ORS M          
       ORS M+20       
       REM            
P3B    CLA W101       L NOP INST
       STO A2B        
       REM            
       CLA WA2        L 2
       STO K27        
       REM            
       CLA W2         L 2
       ADD W1         L 1
       STO W2         
       STO K17        
       REM            
P3C    CLA W0         L 0
       LDQ K17        
       DVP W10        L 12
       STQ K17        
       ALS 1          
       PAX 0,1        
       REM            
       CLA PTW        L +2000000000000
A2B    NOP            
       ORS M+18,1     ADJUST IMAGE
       REM            
       CLA K18        L INST. ALS 1
       STO A2B        ADJUST INST. AT A2B, 1516
       REM            
       CLA K27        L 2
       SUB W1         L 1
       STO K27        
       TZE P3         TEST FOR ZERO
       TRA P3C        NOT ZERO
       REM            
*      ADJUST CONTROL WORDS FOR RESET
       REM            
P1     CLA FOR        
       STO Q1         RESET
       STO NOV1       
       REM            
       LXA W24,1      L 30
       CLA W0         L 0
       STO NIN1       RESET
       STO T11        RESET
P1A    STO M+24,1     ZERO MASTER IMAGE
       TIX P1A,1,1    
       CLA K34        L 377
       STO SC         RESET SHIFT COUNTER
       REM            
       CLA K6         L TRA A1
       STA C1         TRANSFER CONTROL
       REM            
       CLA TC         TC
       ORS M+16       
       REM            
       REM            
       CLA WA2        L 2
       STO W2         
       REM            
*      PRINT OUT CORRECT INSTRUCTION HEADING
*      -------------------------------------
       REM            
*      TEST SENSE LIGHTS 2 AND 3 FOR CORRECT INSTRUCTION
       REM            
*      TEST SL 2      
       REM            
       SLT 2          
       TRA B1A        UP UFA OR FAD
B1D    SLN 2          ON UFS OR FSB
       REM            
*      TEST SLT 3     
       REM            
       SLT 3          
       TRA B1F        OFF FSB
       SLN 3          ON UFS
       REM            
*      UFS HEADING PRINT OUT
       REM            
B1E    WPRA           
       SPRA 3         
       RCHA PUFS      UFS HEADING
       TCOA *         WAIT
       TRA B1C        TO COL HDG PR OUT
       REM            
*      TEST SLT 3 WHEN SLT 2 OFF
       REM            
B1A    SLT 3          
       TRA B1G        OFF FAD
       SLN 3          ON UFA
       REM            
*      UFA HEADING PRINT OUT
       REM            
B1H    WPRA           
       SPRA 3         
       RCHA PUFA      UFA HEADING
       TCOA *         WAIT
       TRA B1C        TO COL HDG PR OUT
       REM            
*      FSB HEADING PRINT OUT
       REM            
B1F    WPRA           
       SPRA 3         
       RCHA PFSB      FSB HEADING
       TCOA *         WAIT
       TRA B1C        TO COL HDG PR OUT
       REM            
*      FAD HEADING PRINT OUT
       REM            
B1G    WPRA           
       SPRA 3         
       RCHA PFAD      FAD HEADING
       TCOA *         WAIT
       REM            
*      COLUMN HEADING PRINT OUT
       REM            
B1C    WPRA           
       RCHA PCHD      COL HEADING
       TCOA *         WAIT
       REM            
*      ADJUST MASTER IMAGE
       REM            
       CLA K9         L
       ORS M          I TO MASTER IMAGE
       ORS M+22       
       ALS 1          
       ORS M+16       1 TO MASTER IMAGE
       REM            
*      TEST SLT 2     
       REM            
       SLT 2          
       TRA B2AB       OFF TO UFA OR FAD
       SLN 2          ON TURN BACK ON
       REM            
*      TEST SLT 3     
       REM            
       SLT 3          
       TRA B2AA       OFF FSB PRINT OUT
       SLN 3          ON UFS PRINT OUT
       REM            
*      UFS PRINT OUT  
       REM            
       CLA K10        L 2232
       TRA B2AD       
       REM            
*      FSB PRINT OUT  
       REM            
B2AA   CLA K11        L 2231
       TRA B2AD       
       REM            
*      TEST SLT 3 FOR FAD OR UFA
       REM            
B2AB   SLT 3          
       TRA B2AC       OFF FAD PRINT OUT
       SLN 3          ON UFA PRINT OUT
       REM            
       REM            
*      UFA PRINT OUT  
       REM            
       CLA K12        L 2230
       TRA B2AD       
       REM            
*      FAD PRINT OUT  
       REM            
B2AC   CLA K13        L 2227
       REM            
*      ENTER HERE FOR ALL PRINT OUTS
       REM            
B2AD   STA B2B        
       STA B2D        
       STA B2E        
       STA B4         
       REM            
       REM            
*      SR BINARY TO OCTAL
       REM            
P3     LXA W12,2      L 14
B2B    CLA SR         
       STO K19        SAVE
       TPL B4         SR +
       REM            
*      SR MINUS       
       REM            
B2C    CLA K4         L +010000000000
       ORS M+20       ADJUST MASTER IMAHGE
       REM            
*      SR PLUS        
       REM            
B4     CLA SR         BRING SR BACK IN
       LRS 3          3 BITS TO MQ
B2D    STO SR         
       CLM            CLEAR ACC SAVE SIGN
       LLS 3          3 BITS BACK FROM MQ
       ALS 1          SHIFT ACC AGAIN
       PAX 0,1        
       REM            
       CLA W102       L 1000000
       ORS M+18,1     
       ALS 1          
       STO W102       
       TIX B4,2,1     FINISH ADJUSTMENTS
       REM            
       CLA K19        
B2E    STO SR         RESTORE SR
       REM            
       CLA W103       L 1000000
       STO W102       RESTORE W102
       REM            
       CLA K14        L 2233, LOC SR
       STA B2B        RESTORE
       STA B4         RESTORE
       STA B2D        RESTORE
       STA B2E        RESTORE
       REM            
       CLA PB1        
       TMI B5A        PB1+
       REM            
       CLA K5         PB1 + L 200000
       ARS 1          ADJUST
       ORS M+4        MASTER
       ORS M+20       IMAGE
       REM            
*      ACC BINARY TO OCTAL
       REM            
B5A    LXA W12,2      L 14
       CLA ACC        BRING IN ACC
       STO K19        SAVE
       TPL B5         ACC +
       REM            
*      ACC MINUS      
       REM            
       CLA K5         L 200000
       ORS M+20       ADJUST MASTER IMAGE
       REM            
B5     CLA ACC        
       LRS 3          3 BITS TO MQ
       STO ACC        SAVE
       CLM            CLEAR ACC SAVE SIGN
       LLS 3          3 BITS BACK TO ACC
       ALS 1          SHIFT ACC AGAIN
       PAX 0,1        
       REM            
       CLA W104       L 10
       ORS M+18,1     ADJUST MASTER IMAGE
       ALS 1          
       STO W104       
       TIX B5,2,1     FINISH ADJUSTMENTS
       REM            
       CLA K19        RESTORE
       STO ACC        ACC
       REM            
       CLA W105       L 10
       STO W104       RESTORE W104
       REM            
B5B    NOP            
       REM            
*      MQ BINARY TO OCTAL
       REM            
       LXA W12,2      L 14
       CLA MQ         BRING IN MQ
       STO K19        SAVE
       TPL B6         MQ +
       REM            
*      MQ MINUS       
       REM            
       CLA PTW        L + 200000000000
       ALS 1          ADJUST
       ORS M+21       MASTER IMAGE
       REM            
B6     CLA MQ         
       LRS 3          3 BITS TO MQ
       STO MQ         SAVE
       CLM            CLEAR ACC SAVE SIGN
       LLS 3          3 BITS BACK FROM MQ
       ALS 1          SHIFT ACC AGAIN
       PAX 0,1        
       CLA W106       L 40000000
       ORS M+19,1     ADJUST MASTER IMAGE
       ALS 1          
       STO W106       SAVE
       TIX B6,2,1     FINISH ADJUSTMENTS
       REM            
       CLA K19        RESTORE
       STO MQ         MQ
       REM            
       CLA W107       RESTORE
       STO W106       W106
       REM            
*      SC BINARY TO OCTAL
       REM            
       LXA W3,2       L 3
       CLA SC         BRING IN SC
       STO K19        SAVE
B7     CLA SC         
       LRS 3          3 BITS TO MQ
       STO SC         SAVE
       CLM            CLEAR ACC
       LLS 3          3 BITS BACK TO ACC
       ALS 1          SHIFT ACC AGAIN
       PAX 0,1        
       CLA W110       L 2000000
       ORS M+19,1     ADJUST MASTER IMAGE
       ALS 1          
       STO W110       SAVE
       TIX B7,2,1     FINISH ADJUSTMENTS
       REM            
       CLA K19        RESTORE
       STO SC         SC
       REM            
       CLA W111       L 2000000
       STO W110       RESTORE W110
       REM            
B9     CLA Q1         
       TMI D1         
       CLA Q          L 1000 Q1 PLUS
       ORS M+23       ADJUST
       TRA D2         MASTER IMAGE
       REM            
*      CONTINUE MASTER IMAGE ADJUSTMENTS
       REM            
D1     CLA Q          L 1000
       ORS M+21       ADJUST MASTER IMAGE
       REM            
D2     CLA NIN1       
       TMI D3         NIN1 MINUS
       CLA NIN        NIN1 PLUS L 10
       ORS M+23       ADJUST MASTER IMAGE
       TRA D6         
       REM            
D3     CLA NIN        L 10
       ORS M+21       ADJUST MASTER IMAGE
       REM            
D6     CLA T11        
       TMI D7         T11 MINUS
       CLA T1         T11 PLUS L 10000
       ORS M+23       ADJUST MASTER IMAGE
       TRA D7A        
       REM            
D7     CLA T1         L 10000
       ORS M+21       ADJUST MASTER IMAGE
       REM            
D7A    CLA NOV1       
       TMI D7B        NOV1 MINUS
       CLA NOV        NOV1 PLUS L 1
       ORS M+23       ADJUST MASTER IMAGE
       TRA D77        
       REM            
D7B    CLA NOV        L 1
       ORS M+21       ADJUST MASTER IMAGE
       REM            
D77    CLA T22        
       TMI D77A       T2 MINUS
       CLA T2         T2 PLUS L 10,000
       ORS M+23       ADJUST MASTER IMAGE
       TRA D78        
       REM            
D77A   CLA T2         T2 MINUS L 10,000
       ORS M+21       ADJUST MASTER IMAGE
       REM            
D78    CLA T33        
       TMI D78A       T3 MINUS
       CLA T3         T3 PLUS L 2,000
       ORS M+23       ADJUST MASTER IMAGE
       TRA D8         
       REM            
D78A   CLA T3         T3 MINUS L 2,000
       ORS M+21       ADJUST MASTER IMAGE
       REM            
       REM            
*      PRINT OUT      
*      ---------      
       REM            
*      Q AND P STATUS IS NOW IN CACC 1 AND 2
*      SET Q P STATUS TO PRINT IMAGE
       REM            
D8     CLA CACC       
       ARS 18         
       ANA QPMASK     
       ORS M+20       SET Q P ZONE
       STO TEMP       
       ANA QMASK      
       ORS M+2        SET Q NUMERIC
       CLA TEMP       
       ANA PMASK      
       ORS M+4        SET P ZONE
       REM            
       WPRA           
       SPRA 3         
       RCHA PMGE      MASTER IMAGE
       TCOA *         WAIT
       REM            
*      ZERO MASTER IMAGE
       REM            
       LXA W24,1      L 30
       CLA W0         L 0
D10    STO M+24,1     
       TIX D10,1,1    
C1     TRA 0          ADJUSTED TRANSFER
       REM            
*      ERROR PRINT-OUT ENTRY
*      ADJUST ERROR IMAGE
       REM            
       REM            
*      ACC BINARY TO OCTAL
       REM            
ERP    LXA W12,2      L 14
       CLA ERRAC      BRING IN ACC
       STO K19        SAVE
       TPL ER         ACC PLUS
       CLA K5         L 400000
       ORS EP+20      ADJUST MASTER IMAGE
       REM            
ER     CLA ERRAC      BRING IN ACC AGAIN
       LRS 3          3 BITS TO MQ
       STO ERRAC      SAVE ACC
       CLM            CLEAR ACC SAVE SIGN
       LLS 3          3 BITS BACK TO ACC
       ALS 1          SHIFT ACC AGAIN
       PAX 0,1        
       REM            
       CLA W104       L 10
       ORS EP+18,1    ADJUST ERROR IMAGE
       ALS 1          
       STO W104       
       TIX ER,2,1     FINISH
       REM            
       CLA K19        RESTORE
       STO ERRAC      ERRAC
       REM            
       CLA W105       RESTORE
       STO W104       W104
       REM            
       REM            
*      MQ BINARY TO OCTAL
       REM            
       LXA W12,2      L 14
       CLA ERRMQ      
       STO K19        SAVE
       TPL ER1        ERR MQ PLUS
       CLA PTW        ERRMQ MINUS L 02 ZEROS
       ALS 1          
       REM
       ORS EP+21      ADJUST ERROR IMAGE
       REM            
ER1    CLA ERRMQ      
       LRS 3          3 BITS TO MQ
       STO ERRMQ      SAVE ACC
       CLM            CLEAR ACC SAVE SIGN
       LLS 3          3 BITS TO ACC FROM MQ
       ALS 1          SHIFT ACC AGAIN
       PAX 0,1        
       CLA W106       L 40000000
       ORS EP+19,1    ADJUST ERROR IMAGE
       ALS 1          
       STO W106       SAVE
       TIX ER1,2,1    FINISH ADJUSTMENTS
       REM            
*      RESTORE        
       REM            
       CLA K19        RESTORE
       STO ERRMQ      ERRMQ
       REM            
       CLA W107       L 40000000
       STO W106       RESTORE
       REM            
*      PRINT OUT ON ERROR
       REM            
ERA6   CLA ERRQP      
       ARS 18         
       ANA QPMASK     
       ORS EP+20      
       STO TEMP       
       ANA QMASK      
       ORS EP+2       
       CLA TEMP       
       ANA PMASK      
       ORS EP+4       
       REM            
       WPRA           
       SPRA 3         
       RCHA PERR      PRINT OUT ON ERROR
       TCOA *         
       REM            
       LXA W24,1      
ER8    CLA EP+24,1    
       ARS 18         SHIFT RT HALF OUT
       ALS 18         SHIFT LF HALF BACK
       STO EP+24,1    ADJUST ERROR IMAGE
       TNX ER7,1,1    
       REM            
*      ZERO ERROR IMAGE
       REM            
ER7    CLA W0         L 0
       STO EP+24,1    
       TIX ER8,1,1    
       REM            
       CLA SIMCOD     
       ARS 18         
       ANA W7         
       ALS 1          
       PAX 0,1        
       CLA W4000      
       ORS TRAP+18,1  
       REM            
       CLA ERRCOD     
       ARS 18         
       ANA W7         
       ALS 1          
       PAX 0,1        
       CLA W4000      BIT IN 24
       ORS TRAP+19,1  
       REM            
*      PRINT SPILL CONDITIONS
       REM            
       WPRA           
       SPRA 3         
       RCHA PTRP      
       TCOA *         
       REM            
       WPRA           SPACE PRINTER
       SPRA 1         SKIP TO ONE
       REM            
       AXT 24,1       
       CLA W0         
ER10   STA TRAP+24,1  
       TIX ER10,1,1   
       REM            
       SLT 4          
       NOP            
       REM            
       TRA F19        
       REM            
*      CONSTANTS AND IMAGES FOLLOW
       REM            
       REM            
***********************************************************************
***********************************************************************
       REM            
PRHD   IOCD M1,0,168  
 TEMP  OCT 0          
 TEMP1 OCT 0          
 TEMP2 OCT 0          
       REM            
 PUFS  IOCD NA1,0,24  UFS HEADING
 PUFA  IOCD LA1,0,24  UFA HEADING
 PFSB  IOCD L1,0,24   FSB HEADING
 PFAD  IOCD M1,0,24   FAD HEADING
 PCHD  IOCD N1,0,24   COL HEADING
 PMGE  IOCD M,0,24    MASTER IMAGE
 PERR  IOCD EP,0,24   ERROR PRINT
 PTRP  IOCD TRAP,0,24 PRINT SPILL
 A5B   OCT 0          
 E33   TRA E3         
 FOR   FOR            
 PB1   FOR            
 PTW   PTW            
PTH    PTH            
 TN1A  PZE            ACC TEST NUMBER
 TN2A  PZE            SR TEST NUMBER
 FAD   FAD TN2A       
 UFA   UFA TN2A       
 FSB   FSB TN2A       
 UFS   UFS TN2A       
 SR    OCT 0          
 ACC   OCT 0          
 MQ    OCT 0          
 TC    OCT 2          
 SC    OCT 0          
 Q     OCT 400        
 Q1    FOR            
 MQV   OCT 200000     
 ERRAC PZE            
ERRCOD PZE            
SIMCOD PZE            
 ERRQP PZE            
 ERRMQ PZE            
 NIN   OCT 10         
 NIN1  FOR            
 T1    OCT 40000      
 T2    OCT 10000      
 T3    OCT 2000       
 T22   OCT 0          
 T33   OCT 0          
 T11   FOR            
 NOV   OCT 1          
 NOV1  FOR            
 K3    FOR            
 K4    OCT 10000000000 
K5     OCT 400000     
 K6    TRA A1          
 K7    TRA ERP        
 K8    TRA A13        
 K9    OCT 100000000000 I AND E BIT.
 K10   PZE UFS        
 K11   PZE FSB        
 K12   PZE UFA        
 K13   PZE FAD        
 K14   PZE SR         
 K15   TRA A3         
 K16   PZE            TEMP STORAGE
 K17   PZE            TEMP STORAGE
 K18   ALS 1          
 K19   OCT 0          
 K20   TRA F5         
 K21   PZE E2         
 K22   TRA F9         
 K23   OCT 0          
 K24   OCT 0          
 K25   COM            
 K26   TRA G          
 K27   OCT 2          
 K28   OCT 6          
 K29   TRA A8         
 K31   PZE K35        
 K32   COM            
 K33   PZE F9E        
 K34   OCT 377        
 K35   HPR            
 K36   DEC 35         
 K37   DEC 12         
 K38   TRA G
 K39   PZE            TEMP STORAGE
 K77   OCT 77         
 K177  OCT 177        
 K377  OCT 377        
 KF9A  PZE F9A        
 KF9F  PZE F9F        
 KTRA  TRA F9J        
 L11   TRA LOOP1+2    
L2     TRA LOOP2+2    
L3     TRA LOOP3+2    
L4     TRA LOOP4+2    
 CACC  OCT 0          
 QP18  OCT 340200000000
OVF    OCT 100000     
UVF    OCT 300000     
M17    OCT 1000000    
M16    OCT 2000000    
M15    OCT 4000000    
QMASK  OCT 200000     
PMASK  OCT 100000     
CAMASK OCT 377600000000
QPMASK OCT 300000     
SPMSK  OCT 7000000    
 FMASK OCT 377000000000
 CMASK OCT 777777777  
 COM32 OCT 371200000000
 COUNT PZE            
 W0    OCT 0          
 W1    OCT 1          
 W2    OCT 2          
 WA2   OCT 2          
 W3    OCT 3          
 W7    OCT 7          
 W4    OCT 4          
 W10   DEC 10         
 W12   DEC 12         
 W24   DEC 24         
 W27   DEC 27         
 W100  TRA A9B        
 W101  NOP            
 W102  OCT 1000000    
 W103  OCT 1000000    
 W104  OCT 10         
 W105  OCT 10         
 W106  OCT 40000000   
 W107  OCT 40000000   
 W110  OCT 2000000    
 W111  OCT 2000000    
 W1111 OCT 777777777777
W4000  OCT 4000       
 WV1   PZE            TEMP STORAGE
 WV2   PZE            TEMP STORAGE
 M     PZE            MASTER IMAGE
       BES 23         
 M1    OCT 0          FAD HEADING
       BES 23         
 L1    OCT 0          FSB HEADING
       BES 23         
 N1    OCT 0          COLUMN HEADING
       BES 23         
 LA1   OCT 0          UFA HEADING
       BES 23         
 NA1   OCT 0          UFS HEADING
       BES 23         
 EP    OCT 0          ERROR HEADING
       BES 23         
TRAP   OCT 0          
       BES 23         
 RA    PZE RN         
 RA1   OCT 7767       
 R     PZE            
 RN    OCT 526044765051
       OCT 134703564071
       OCT 517162721736
       OCT 062037467555
       OCT 364271003657
       OCT 731011416132
       OCT 705552746526
       OCT 033420275432
       END            
