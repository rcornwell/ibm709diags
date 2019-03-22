                                                             9SWA
                                                            7-10-58
       REM            
       REM 9SWA       
       REM            
*SPECIAL FEATURE-SIX ADDITIONAL SENSE SWITCHES
       REM            
       ORG 24         
       REM            
*TEST TWELVE SENSE SWITCHES IN UP POSITION
       REM            
       LXA RPEAT,1    L +100
START  HTR *+1        THROW ALL 12 SWITCHES UP
       PXD            CLEAR ACCUMULATOR
       SWT 1          TEST SWITCH 1
       TRA *+3        UP-OK
       ORA ONE        7 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 2          TEST SWITCH 2
       TRA *+3        UP-OK
       ORA TWO        77 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 3          TEST SWITCH 3
       TRA *+3        UP-OK
       ORA THREE      777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 4          TEST SWITCH 4
       TRA *+3        UP-OK
       ORA FOUR       7777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 5          TEST SWITCH 5
       TRA *+3        UP-OK
       ORA FIVE       77777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 6          TEST SWITCH 6
       TRA *+3        UP-OK
       ORA SIX        777777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 7          TEST SWITCH 7
       TRA *+3        UP-OK
       ORA SVN        7777777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 8          TEST SWITCH 8
       TRA *+3        UP-OK
       ORA EIGHT      77777777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 9          TEST SWITCH 9
       TRA *+3        UP-OK
       ORA NINE       777777777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       SWT 10         TEST SWITCH 10
       TRA *+3        UP-OK
       ORA TEN        7777777777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 11         TEST SWITCH 11
       TRA *+3        UP-OK
       ORA ELVN       77777777777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       REM            
       SWT 12         TEST SWITCH 2
       TRA *+3        UP-OK
       ORA TWELV      777777777777 IN ACC
       HTR *+1        ERROR-ACTED IN DOWN CONDN.
       TIX START+1,1,1 
       REM            
*TEST TWELVE SENSE SWITCHES IN DOWN POSITION
       REM            
       LXA RPEAT,1    L +100
STRT1  HTR *+1        THROW ALL SWITCHES UP
       PXD            
       SWT 1          TEST SWITCH 1
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA ONE        7 IN ACC
       HTR *+1        ERROR-SWITCH 1-DOWN CONDN
       REM            
       SWT 2          TEST SWITCH 2
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA TWO        77 IN ACC
       HTR *+1        ERROR-SWITCH 2-DOWN CONDN
       REM            
       SWT 3          TEST SWITCH 3
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA THREE      777 IN ACC
       HTR *+1        ERROR-SWITCH 3-DOWN CONDN
       REM            
       SWT 4          TEST SWITCH 4
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA FOUR       7777 IN ACC
       HTR *+1        ERROR-SWITCH 4-DOWN CONDN
       REM            
       SWT 5          TEST SWITCH 5
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA FIVE       77777 IN ACC
       HTR *+1        ERROR-SWITCH 5-DOWN CONDN
       REM            
       SWT 6          TEST SWITCH 6
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA SIX        777777 IN ACC
       HTR *+1        ERROR-SWITCH 6-DOWN CONDN
       REM            
       SWT 7          TEST SWITCH 7
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA SVN        7777777 IN ACC
       HTR *+1        ERROR-SWITCH 7-DOWN CONDN
       REM            
       SWT 8          TEST SWITCH 8
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA EIGHT      77777777 IN ACC
       HTR *+1        ERROR-SWITCH 8-DOWN CONDN
       REM            
       SWT 9          TEST SWITCH 9
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA NINE       777777777 IN ACC
       HTR *+1        ERROR-SWITCH 9-DOWN CONDN
       REM            
       SWT 10         TEST SWITCH 10
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA TEN        7777777777 IN ACC
       HTR *+1        ERROR-SWITCH 10-DOWN CONDN
       REM            
       SWT 11         TEST SWITCH 11
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA ELVN       77777777777 IN ACC
       HTR *+1        ERROR-SWITCH 11-DOWN CONDN
       REM            
       SWT 12         TEST SWITCH 12
       TRA *+2        UP-ERROR-SHBE DOWN
       TRA *+3        OK-DOWN
       ORA TWELV      777777777777 IN ACC
       HTR *+1        ERROR-SWITCH 12-DOWN CONDN
       REM            
*TEST INSTRUCTIONS WITH SIMILAR OPERATION CODES
       REM            
       NOP 113        TEST
       TRA *+2        FOR
       HTR *+1        NOP
       REM            INSTRUCTIONS
       NOP 114        WITH
       TRA *+2        ADDRESSESS
       HTR *+1        OF
       REM            FIRST
       NOP 115        SIX
       TRA *+2        SWITCHES
       HTR *+1        WILL
       REM            NOT
       NOP 116        CONFLICT
       TRA *+2        WITH
       HTR *+1        SENSE 
       REM            SWITCHES
       NOP 117        ADDRESSESS
       TRA *+2        
       HTR *+1        NOP
       REM            TESTED
       NOP 118        WITH
       TRA *+2        SWITCHES
       HTR *+1        DOWN
       REM            
*TEST PBT, SSP, SSM, LBT, CLM, CHS, COM, ETM, LTM# RND, DCT
       REM            
       CAL PBIT       L-0
       PBT            
       HTR *+1        ERROR-SHBE P BIT
       ALS 1          CLEAR P
       PBT            
       TRA *+3        OK-NO BIT
       HTR *+1        ERROR-INDICATED P BIT
       REM            
       SSM            
       TRA *+2        OK
       HTR *+1        ERROR-SKIPPED
       REM            
       SSP            
       TRA *+2        OK
       HTR *+1        ERROR-SKIPPED
       REM            
       CLA LBIT       L +1
       LBT            
       HTR *+1        ERROR-SHBE LOW BIT
       ARS 1          CLEAR LOW BIT
       LBT            
       TRA *+2        OK-NO BIT
       HTR *+1        ERROR-INDICATED LOW BIT
       REM            
       CAL TWELV      ALL ONES
       CLM            
       TRA *+2        OK
       HTR *+1        ERROR-SKIPPED
       TZE *+2        OK-ZERO
       HTR *+1        CLM DID NOT OPERATE
       REM            
       PXD            CLEAR ACC
       CHS            
       TRA *+2        OK
       HTR *+1        ERROR-SKIPPED
       TMI *+2        OK-MINUS
       HTR *+1        ERROR-DID NOT CHANGE SIGN
       REM            
       PXD            
       COM            
       TRA *+2        OK
       HTR *+1        ERROR-SKIPPED
       ARS 2          CLEAR P AND Q
       SUB TEST L 377777777777
       TZE *+2        OK
       HTR *+1        DID NOT COM CORRECTLY
       REM 
       ETM            CHECK ENTER TRAP MODE
       TTR *+2        OK
       HTR *+1        ERROR-SKIPPED-MAY NOT GET
       REM            BACK TO PROGRAM FROM HERE,
       REM            IF ERROR.
       REM            
       LTM            CHECK LEAVE TRAP MODE
       TRA *+2        OK
       HTR *+1        ERROR-SKIPPED
       REM            
       RND            CHECK RND INSTRUCTION
       TRA *+2        OK
       HTR *+1        ERROR-SKIPPED
       REM            
       DCT            TEST DIVIDE CHECK
       HTR *+1        ERROR-SHOULD BE OFF
       REM            
       CAL PBIT       BIT INTO P
       DVP TWELV      DIVISION SHOULD NOT TAKE
       REM            PLACE. DIVIDE CHECK SHOULD
       REM            COME ON.
       DCT            
       TRA *+2        OK-SHOULD BE ON
       HTR *+1        ERROR-SKIPPED
       REM            
       TIX STRT1+1,1,1 REPEAT 100 TIMES
       TRA START-1    PROGRAM WILL REPEAT
       REM            INDEFINATELY. TO CALL NEXT
       REM            PROGRAM, RESET AND HIT LOAD
       REM            CARDS BUTTON
TEST   OCT 377777777777
ONE    OCT 7          
TWO    OCT 77         
THREE  OCT 777        
FOUR   OCT 7777       
FIVE   OCT 77777      
SIX    OCT 777777     
SVN    OCT 7777777    
EIGHT  OCT 77777777   
NINE   OCT 777777777  
TEN    OCT 7777777777 
ELVN   OCT 77777777777 
TWELV  OCT 777777777777
PBIT   OCT -0         
LBIT   OCT 1          
RPEAT  OCT 100        
       END            
