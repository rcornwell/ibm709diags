                                                             9M05B
                                                             8/15/59
* 9M05,    709 FLOATING POINT.
       REM           
*9M05,  FLOATING POINT FUNCTION INTERROGATION
*PROGRAMME FOR THE IBM TYPE 709 COMPUTING ENGINE.
       REM           
       REM           
       REM           
       REM           
       ORG 1         
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TTR SEQ       FOR F.P. TRAP
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TRA L31       
       ORG 23        
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
*BEGIN PART 1 OF 9M05.
*SECTION 1, NO FLOATING POINT TRAP.
       REM           TEST UFA FOR NOT CLEAR-
       REM           ING CHAR ON FR EQUAL 0
       BCD 1UFA      
 L31   TSX RESET,4   
       CLA K34       CH 233 FR-707070707
       UFA K34+1     CH 233 HR +707070707
       TZE *+4       NG
       LLS 35        
       ADD K34+2     L +2000000000
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L31       
       REM           
       REM           ACC, MQ SIGNS UNLIKE IN
       REM           ANS, NO NORMALIZING NEEDED
       BCD 1FAD      
 L33   TSX CLEAR,4   
       CLA K35       CH 234 FR-60000000000
       FAD K36       CH 233 FR +4000000000
       ADD K35+1     CH 234 FR +400000000
       TZE *+2       
       TSX ERROR,4   
       TSX OK,4      
       TRA L33       
       REM           
       REM           
*             TEST - FLOATING SUBTRACT
       REM           
       BCD 1FSB      
 L32   TSX CLEAR,4   
       CLA K34+1     CH 233 FR +707070707
       FSB K34+1     CHECK CLEARING ON 0 FR
       TZE *+2       
       TSX ERROR,4   
       TSX OK,4      
       TRA L32       
       REM           
       REM           TEST FSB SIGN EXCHANGE
       BCD 1FSB      
 L34   TSX CLEAR,4   
       CLA K37       CH 204 FR +600000000
       FSB K37+1     CH 201 FR +40000000
       TMI *+3       NG
       SUB K37+2     L +204540000000
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L34       
       REM           
       REM           TEST UFS FOR NOT
       REM           CLEARING ON 0 FR
       BCD 1UFS      
 L35A  TSX CLEAR,4   
       CLA K34+1     CH 233 FR + 707070707
       UFS K34+1     
       SUB K46       L +  233000000000
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L35A      
       REM           
       REM           
*             TEST - FLOATING MULTIPLY
       REM           
       REM           TEST UFM FOR CHAR. ADJUST.
       REM           WITCH CH MORE THEN 128
       BCD 1UFM      
 L35   TSX CLEAR,4   
       LDQ K40       CH 211 FR +000000001
       UFM K40+1     CH 222 FR +00000001
       SUB K40+2     L +233000000000
       TNZ *+4       NG
       LLS 8         MQ CH TO ACC
       SUB K41       L +0200
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L35       
       REM           
       REM           TEST UFM FOR CHAR. ADJUST.
       REM           WITH CH LESS THEN 128
       BCD 1UFM      
 L36   TSX CLEAR,4   
       LDQ K42       CH 174 FR +000000001
       UFM K42+1     CH 170 FR +000000001
       SUB K42+2     L +164000000000
       TNZ *+4       NG
       LLS 8         MQ CH TO ACC
       SUB K42+3     L + 131
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L36       
       REM           
       REM           TEST UFM FOR SIGN ADJUST
       REM           BOTH SIGNS +
       BCD 1UFM      
 L37   TSX CLEAR,4   
       LDQ K34+1     L + 233707070707
       SSM           ACC SIGN -
       UFM K34+1     MULT. BY NO.
       TMI *+3       ACC 5 NG
       LLS           MG S TO ACC S
       TPL *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L37       
       REM           
       REM           TEST UFM FOR SIGN ADJUST
       REM           BOTH SIGNS -
       BCD 1UFM      
 L40   TSX CLEAR,4   
       LDQ K34       L -233707070707
       SSM           ACC SIGN -
       UFM K34       MULT. BY - NO.
       TMI *+3       ACC S NG
       LLS           MQ S TO ACC S
       TPL *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L40       
       REM           
       REM           TEST UFM FOR SIGN ADJUST
       REM           MQ -, STG +
       BCD 1UFM      
 L41   TSX CLEAR,4   
       LDQ K34       L -233707070707
       CLA K0        L + 0
       UFM K34+1     MULT. BY + SAME NO.
       TPL *+3       ACC SIGN NG
       LLS           MQ S TO ACC S
       TMI *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L41       
       REM           
       REM           TEST UFM FOR SIGN ADJUST
       REM           MQ +, STG -
       BCD 1UFM      
 L42   TSX CLEAR,4   
       LDQ K34+1     L + 2337070707
       CLA K0        L + 0
       UFM K34       MULT BY - SAME NO.
       TPL *+3       ACC S NG
       LLS           MQ S TO ACC S
       TMI *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L42       
       REM           
       REM           TEST UFM FOR FR. VALUE
       BCD 1UFM      
 L43   TSX CLEAR,4   
       LDQ K43       CH 200 FR + 0007777777
       UFM K43       
       SUB K43+1     L + 200000000777
       TNZ *+4       ACC NG
       LLS 35        PEPARE TO CHECK MQ
       SUB K43+2     L + 145776000001
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L43       
       REM           
       REM           TEST UFM FOR NOT CLEARING
       REM           CH ON MULT. BY 0
       BCD 1UFM      
 L44   TSX CLEAR,4   
       LDQ K43+3     CH 200 FR + 777777777
       UFM K40+2     CH 233 FR + 0
       SUB K40+2     
       TNZ *+4       ACC NG
       LLS 35        PREPARE TO CHECK MQ
       SUB K34+2     L + 2000000000
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L44       
       REM           
       REM           TEST FMP, NORMALIZEING NOT
       REM           NEEDED
       BCD 1FMP      
 L45   TSX CLEAR,4   
       LDQ K44       CH 200 FR + 777770000
       FMP K44       
       SUB K44+1     L + 200777760000
       TNZ *+4       ACC NG
       LLS 35        PREPARE TO CHECK MQ
       SUB K44+2     L + 145100000000
       TZE *+2       
       TSX ERROR,4   
       TSX OK,4      
       TRA L45       
       REM           
       REM           TEST FMP FOR NORMALIZING
       REM           WITH 0 IN ACC 9
       BCD 1FMP      
 L46   TSX CLEAR,4   
       LDQ K44       CH 200 FR + 777770000
       FMP K44+3     CH 200 FR + 333330000
       SUB K45       L + 177666651111
       TNZ *+4       ACC NG
       LLS 35        PREPARE TO CHECK MQ
       SUB K45+1     L + 144200000000
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L46       
       REM           
       REM           TEST FMP FOR CLEARING
       REM           CH ON MULT. BY 0
       BCD 1FMP      
 L47   TSX CLEAR,4   
       LDQ K43+3     CH 200 FR + 7777777777
       FMP K40+2     CH 233 FR TO
       TNZ *+3       ACC TO 0
       LLS 35        PREPARE TO CHECK MQ
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L47       
       REM           
       REM           
*             TEST - FLOATING DIVIDE
       REM           
       REM           TEST FDP FOR DIV. OF FP.
       REM           STG. EQUALS ACC CH
       REM           QUOT. WOULD BE LESS THAN 1
       BCD 1FDP      
 L50   TSX CLEAR,4   
       LDQ K0        L + 0
       CLA K47       CH 200 FR +070707070
       FDP K47+1     CH 200 FR + 7070707
       ANA KK        BLANK ACC CH
       SUB K47+2     L + 7070707
       TNZ *+5       ACC FR NG
       LLS 35        QUOT. TO ACC
       ANA KK        BLANK MQ CH
       SUB K47+3     L + 77777777
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L50       
       REM           
       REM           TEST FDP FOR CLEARING MQ
       BCD 1FDP      
 L51   TSX CLEAR,4   
       LDQ K47       
       CLA K47       CH 200 FR + 070707070
       FDP K47+1     CH 200 FR + 707070707
       ANA KK        BLANK ACC CH
       SUB K47+2     L + 7070707
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L51       PROBABLY NOT CLEARED
       REM           
       REM           TEST FDP FOR DIV. OF FR
       REM           QUOT. IS BETWEEN 1 AND 2
       BCD 1FDP      
 L52   TSX CLEAR,4   
       CLA K50       CH 200 FR + 760000000
       FDP K50+1     CH 200 FR +70000000
       ANA KK        BLANK ACC CH
       SUB K50+2     L + 300000000
       TNZ *+5       ACC FR NG
       LLS 35        QUOT TO ACC
       ANA KK        BLANK MQ CH
       SUB K50+3     L + 433333333
       TZE *+2       
       TSX ERROR,4   
       TSX OK,4      
       TRA L52       
       REM           
       REM           TEST FDP FOR CHAR. ADJUST
       REM           QUOT. FR LESS THAN 1
       BCD 1FDP      
 L53   TSX CLEAR,4   
       CLA K51       CH 377 FR + 070000000
       FDP K51+1     CH 344 FR + 700000000
       ANA KK1       BLANK ACC FR
       SUB K51+2     CH 344 FR + 0
       TNZ *+5       ACC CH
       LLS 35        QUOT TO ACC
       ANA KK1       BLANK MQ FR
       SUB K51+3     CH 233 FR + 0
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L53       
       REM           
       REM           TEST FDP FOR CHAR ADJUST
       REM           QUOT FR BETWEEN 1 AND 2
       BCD 1FDP      
 L54   TSX CLEAR,4   
       CLA K52       CH 376 FR +760000000
       FDP K51+1     CH 344 FR + 70000000
       ANA KK1       BLANK ACC FR
       SUB K51+2     CH 344
       TNZ *+5       ACC CH NG
       LLS 35        QUOT TO ACC
       ANA KK1       BLANK MQ FR
       SUB K51+3     CH 233 FR TO
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L54       
       REM           
       REM           TEST FDP FOR CHAR ADJUST
       REM           CH ACC LESS THAN CH STG
       BCD 1FDP      
 L55   TSX CLEAR,4   
       CLA K52+1     CH 344 FR + 0700000000
       FDP K52+2     CH 377 FR + 7000000000
       ANA KK1       BLANK ACC FR
       SUB K52+3     CH 311 FR + 0
       TNZ *+5       ACC CH NG
       LLS 35        QUOT TO ACC
       ANA KK1       BLANK MQ FR
       SUB K52+4     CH 145 FR + 0
       TZE *+2       
       TSX ERROR,4   
       TSX OK,4      
       TRA L55       
       REM           
       REM           TEST FDP FOR SIGN ADJUST
       REM           ACC. +, STG +
       BCD 1FDP      
 L56   TSX CLEAR,4   
       CLA K54+1     CH 233 FR + 0700000000
       FDP K54+1     CH 230 FR + 7000000000
       TMI *+2       ACC SIGN NG
       TQP *+2       MQ SIGN OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L56       
       REM           
       REM           TEST FDP FOR SIGN ADJUST
       REM           ACC. +, STG -
       BCD 1FDP      
 L57   TSX CLEAR,4   
       CLA K54+1     CH 233 FR + 070000000
       FDP K34       CH 230 FR -707070707
       TMI *+3 ACC SIGN NG
       TQP *+2       MQ SIGN NQ
       TRA *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L57       
       REM           
       REM           TEST FDP FOR SIGN ADJUST
       REM           ACC -, STG +
       BCD 1FDP      
 L60   TSX CLEAR,4   
       CLA K54       CH 233 FR - 007777777
       FDP K54+1     CH 233 FR + 070000000
       TPL *+3       ACC SIGN NG
       TQP *+2       MQ SIGN NG
       TRA *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L60       
       REM           
       REM           TEST FDP FOR SIGN ADJUST
       REM           ACC -, STG -
       BCD 1FDP      
 L61   TSX CLEAR,4   
       CLA K54       CH 233 FR - 0077777777
       FDP K34       CH 233 FR -707070707
       TPL *+2       ACC SIGN NG
       TQP *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L61       
       REM           
       REM           TEST FDP FOR XFER OF BITS
       REM           MQ 9 TO ACC 35
       BCD 1FDP      
 L62A  TSX CLEAR,4   
       CLA K67       CH 173 FR + 516274051
       FDP K67+1     CH 176 FR + 44444445
       SUB K67+6     L 141202471361
       TNZ *+4       NG
       LLS 35        PREPARE TO CHECK MQ
       SUB K67+2     L + 176444444443
       TZE *+2       
       TSX ERROR,4   
       TSX OK,4      
       TRA L62A      
       REM           
       REM           TEST FDP FOR CLEARING MQ
       REM           AND ACC IF DIVIDEND FR IS 0
       BCD 1FDP      
 L62   TSX CLEAR,4   
       CLA K55       CH 377 FR + 0
       FDP K47       CH 200 FR + 070707070
       TNZ *+3       NG - ACC NOT CLEARED
       LLS 35        QUOT TO ACC
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L62       
       REM           
       REM           TEST FDP FOR DIVIDE
       REM           CHECK ON DIVISION BY 0
       REM           CHECK ACC UNCHANGED.
       BCD 1FDP      
 L63   TSX CLEAR,4   CLEAR PANEL
       CLA K51+1     344.7
       FDP K51+2     344.0
       DCT           SHOULD NOT SKIP
       TRA *+3       OK
       TSX ERROR-1,4 DIVIDE CHECK TRIG
       TRA L63       SHOULD HAVE BEEN ON
       REM           
       REM           CHECK ACC UNCHANGED
       SUB K51+1     -344.700000000
       TZE L63E      OK IF ZERO.
       ADD K51+1     REPLACE ACC
       LDQ K51+1     CORRECT ANS IN MQ
       TSX ERROR,4   ACC ERR,SHOULD NOT
       REM           HAVE BEEN CHANGED
       REM           BY DIVIDE BY ZERO
       REM           CORRECT ANS IN MQ,
       REM           ORIG ANS IN ACC.
 L63E  TSX OK,4      PROCEED OR
       TRA L63       REPEAT
       REM           
       REM           TEST FDP FOR
       REM           DIVIDE CHECK WITH
       REM           DIVISOR TO SMALL,
       REM           AND CHECK THAT ACC
       REM           IS NOT CHANGED.
       REM           
       BCD 1FDP      
 L64   TSX CLEAR,4   CLEAR PANEL
       CLA K51+1     344.7
       FDP K47       BY 200.070707070.
       DCT           SHOULD NOT SKIP
       TRA *+3       OK
       TSX ERROR-1,4 DIVIDE CHECK TRIG
       TRA L64       SHOULD BE BEEN ON
       SUB K51+1     -344.7000000
       TZE L64E      OF IF ZERO HERE
       ADD K51+1     RESTORE ACC
       LDQ K51+1     CORRECT ANS TO MQ
       TSX ERROR,4   ACC CHANGED ON
       REM           DIVIDE CHECK,CORRECT
       REM           ANS IN MQ
 L64E  TSX OK,4      PROCEED OR
       TRA L64       REPEAT
       REM           
       REM           CRAZY
       REM           
       REM TEST FOR FALSE DIV CHECK
       BCD 1FDP      
 L65   TSX CLEAR,4   
       CLA K50       CH 200 FR + 760000000
       FDP K50+1     CH 200 FR + 700000000
       DCT           TEST INDICATOR
       TRA *+2       NG-DIVIDE CHECK
       TRA *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L65       
       REM           
       REM           TEST FDH FOR NO HALT ON
       REM           NO DIVIDE CHECK
       BCD 1FDH      
 L66   TSX CLEAR,4   
       CLA K50       CH 200 FR + 760000000
       FDH K50+1     CH 200 FR + 700000000
       NOP           ERROR COULD CAUSE HALT
       SUB K67+4     CH 146 FR 30000000
       TNZ *+4       NG - WRONG REM
       LLS 35        QUOT TO ACC
       SUB K67+5     CH 201 FR 43333333
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA L66       
       REM           
       REM           TEST FDH FOR HALT
       REM           IF SWITCH 5 IS DOWN
       BCD 1FDH      
 L67   TSX CLEAR,4   CLEAR
       SWT 5         TEST SWITCH 5
       TRA L67E      IF 5 IS UP,DO NOT
       REM           PERFORM FDH WITH HALT
       REM           
       CLA *-1       IF 5 IS DOWN,PERFORM
       STO L67+1     FDH WITH HALT. BUT
       REM           DO NOT REPEAT UNLESS
       REM           SWITCH 1 IS DOWN
       REM           AND 4 IS UP. DO NOT
       REM           DO THIS TEST AGAIN
       REM           UPON REPITITION OF
       REM           PROGRAM BY SWITCH
       REM           6 CONTROL
       REM           
 L67A  DCT           MAKE SURE DIVIDE 
       REM           CHECK TRIG IS 
       REM           OFF.
       NOP           
       CLA K51+1     L 344.7
       FDH K47       BY 200.07070707070
       REM           NO 9 CARRY ON FIRST
       REM           STEP AT ER5 TIME.
       REM           T1 REMAINS ON. SHOULD
       REM           HALT ON DIVIDE CHECK.
       DCT           HALT OK,PRESS START
       TRA *+3       DCT OK,EXIT
       TSX ERROR-1,4 SKIP ON DCT,THE
       REM           DIVIDE CHECK TRIG
       REM           SHOULD HAVE BEEN ON
       REM           
       NOP L67       TEST SWITCHES BEFORE
       REM           ALLOWING REPEAT
       SWT 4         IF 4 IS DOWN
       SWT 1         OR 1 IS UP
       TRA *+2       DO NO REPEAT
       TRA L67A      4 UP,1 DOWN,REPEAT
 L67E  TSX OK,4      STEP DOWN REPEAT
       TRA L67       COUNTER IF 4 IS
       REM           DOWN,BUT DO NOT
       REM           REPEAT TEST
       REM           
       REM           
       REM           
*             TEST - UNNORMALIZED ADD MAGNITUDE
       REM           
       REM           SIGN ++, CHAR EQUAL
       REM           
       BCD 1UAM      
 F1    TSX CLEAR,4   
       CLA K0+1      L 33.101010101
       UAM K0+2      L 33.404040404
       SUB K0+3      L+033505050505
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F1        
       REM           
       REM           
       REM           SIGNS-+, CHAR EQUAL
       BCD 1UAM      
 F1A   TSX CLEAR,4   
       CLA K0+4      L-33.505050505
       UAM K0+1      CH 033 FR 101010101
       ADD K0+2      L 033404040404
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F1A       
       REM           
       REM           
       REM           SIGNS +-, CHAR EQUAL
       BCD 1UAM      
 F2    TSX CLEAR,4   
       CLA K0+1      L 33.101010101
       UAM K0+4      L-33.505050505
       SUB K0+5      L 033606060606
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F2        
       REM           
       REM           CHECK NOT NORMALIZING
       BCD 1UAM      
 F2A   TSX CLEAR,4   
       CLA K0+4      L-33.505050505
       UAM K0+4      SAME
       ADD K0+6      L033000000000
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F2A       
       REM           
       REM           CHECK NOT NORMALIZING
       BCD 1UAM      
 F3    TSX CLEAR,4   
       CLA K0+7      L-33.303030303
       UAM K0+2      L 33.404040404
       SUB K0+1      L 033101010101
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F3        
       REM           
       REM           
*             TEST - FLOATING ADD MAGNITUDE
       REM           
       REM           SIGNS ++, CHAR EQUAL
       BCD 1FAM      
 F4    TSX CLEAR,4   
       CLA K1        L 344.01010101010
       FAM K1+1      L 344.440404040
       SUB K1+2      L3445050505050
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F4        
       REM           
       REM           SIGNS-+, CHAR EQUAL
       BCD 1FAM      
 F5    TSX CLEAR,4   
       CLA K1+3      L-344.010101010
       FAM K1+2      L 344.450505050
       SUB K1+1      L 344440404040
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F5        
       REM           
       REM           SIGN +-, CHAR EQUAL
       BCD 1FAM      
 F6    TSX CLEAR,4   
       CLA K1+1      L 344.440404040
       FAM K1+3      L-344.010101010
       SUB K1+2      L 34450505050
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F6        
       REM           
       REM           CHECK FOR NORMALIZING
       BCD 1FAM      
 F7    TSX CLEAR,4   
       CLA K1+4      L-344.347474747
       FAM K1+2      L 344.450505050
       SUB K1+5      L342404040404
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F7        
       REM           
       REM           CHECK FOR NORMALIZING
       BCD 1FAM      
 F10   TSX CLEAR,4   
       CLA K1+3      L-344.010101010
       FAM K1        L 344.010101010
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F10       
       REM           
       REM           
*             TEST - FLOATING SUBTRACT MAG
       REM           
       REM           SIGNS ++, CHAR EQUAL
       BCD 1FSM      
 F11   TSX CLEAR,4   
       CLA K1+2      L 344.450505050
       FSM K1        L 344.010101010
       SUB K1+1      L 344440404040
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F11       
       REM           
       REM           SIGN +-, CHAR EQUAL
       BCD 1FSM      
 F12   TSX CLEAR,4   
       CLA K1+2      L 344.450505050
       FSM K1+3      L-344.010101010
       SUB K1+1      L 344440404040
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F12       
       REM           
       REM           SIGNS -+, CHAR EQUAL
       BCD 1FSM      
 F13   TSX CLEAR,4   
       CLA K1+3      L-344.010101010
       FSM K1+1      L 344.440404040
       ADD K1+2      L 344450505050
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F13       
       REM           
       REM           CHECK FOR NORMALIZING
       BCD 1FSM      
 F14   TSX CLEAR,4   
       CLA K1+2      L 344.450505050
       FSM K1+4      L-344.347474747
       SUB K1+5      L 342404040404
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F14       
       REM           
       REM           CHECK FOR NORMALIZING
       BCD 1FSM      
 F15   TSX CLEAR,4   
       CLA K1+2      L 344.450505050
       FSM K1+2      
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F15       
       REM           
       REM           
*             TEST - UNNORMALIZED SUB MAG
       REM           
       REM           SIGNS ++, CHAR EQUAL
       BCD 1USM      
 F16   TSX CLEAR,4   
       CLA K0+3      L 033.50505050
       USM K0+1      L 033.10101010
       SUB K0+2      L 03340040404
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F16       
       REM           
       REM           SIGNS -+, CHAR EQUAL
       BCD 1USM      
 F17   TSX CLEAR,4   
       CLS K0+1      L 033.101010101
       USM K0+2      L 033.404040404
       ADD K0+3      L 033505050505
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F17       
       REM           
       REM           SIGNS +-, CHAR EQUAL
       BCD 1USM      
 F20   TSX CLEAR,4   
       CLA K0+1      L 033.101010101
       USM K0+4      L-035.505050505
       ADD K0+2      L 033404040404
       TZE *+2       OK
       REM           
       REM           
       TSX ERROR,4   
       TSX OK,4      
       TRA F20       
       REM           
       REM           CHECK NOT NORMALIZING
       BCD 1USM      
 F21   TSX CLEAR,4   
       CLA K0+3      L 033.505050505
       USM K0+3      
       SUB K0+6      L 033000000000
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F21       
       REM           
       REM           CHECK NOT NORMALIZING
       BCD 1USM      
 F22   TSX CLEAR,4   
       CLA K0+2      L 033.404040404
       USM K0+7      L-033.303030303
       SUB K0+1      L 033101010101
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA F22       
       REM           
       REM           
       REM           
*THE WIESS-LAYDEN SPECIAL... OR,EARLY TO RISE
       REM           
*                    BIT IN MQ 35, 5TH STEP
       BCD 1FAD      
 FIF   TSX CLEAR,4   
       CLA BOOZE     233.00000001
       FAD BOOZE+1   266.0
       REM           NORMALIZE FROM
       REM           MQ 35
       REM           
       REM           TONIC OR GINGER...
       REM           
       STQ Q         SAVE MQ
       CAS COEF      SHOULD BE 201.4
       TXI *+2       ERROR
       TRA *+4       OK
       LDQ COEF      CORRECT TO MQ
       TSX ERROR-1,4 ACC ERR. CORRECT
       TRA FIF       ANS. IN MQ.
       REM           
       REM           
       CLA Q         CHECK MQ FACTOR
       CAS BOOZE+2   146.0
       TXI *+2       ERR
       TRA *+4       
       LDQ BOOZE+2   
       TSX ERROR-1,4 MQ ERROR,CORRECT
       TRA FIF       ANS IN MQ.
       REM           
       TSX OK,4      PROCEED OR
       TRA FIF       REPEAT
       REM           
       REM           
       REM           BIT IN ACC 9
       BCD 1FAD      
 TEEN  TSX CLEAR,4   
       FAD COEF      +201.4
       SUB COEF      -201.4#0
       TZE *+2       OK IF ZERO
       TSX ERROR,4   NO GOOD
       TSX OK,4      YUMMY
       TRA TEEN      
       REM           
       REM           
       REM           
*BIT IN MQ 35 AND ACC 9. EXCHANGE
       REM           
       BCD 1FAD      
 MEN   TSX CLEAR,4   
       CLA BOOZE+3   266.4
       FAD BOOZE     233.000000001
       REM           
       REM           MIXING DRINKS AGAIN...
       REM           
       STQ Q         
       CAS BOOZE+3   266.4
       TXI *+2       NO GOOD
       TRA *+4       
       LDQ BOOZE+3   CORRECT TO MQ
       TSX ERROR-1,4 ACC ERR,CORRECT
       TRA MEN       ANS IN MQ.
       REM           
       CLA Q         CHECK MQ
       CAS BOOZE     233.00000001
       TXI *+2       
       TRA *+3       
       LDQ BOOZE     CORRECT TO MQ
       TSX ERROR,4   MQ ERR,CORRECT
       TSX OK,4      ANS IN MQ
       TRA MEN       
       REM           
       REM           
*BIT IN ACC 10 AND MQ 34,5TH STEP
       REM           
       BCD 1FAD      
 ONA   TSX CLEAR,4   
       CLA BOOZE     233.000000001
       FAD BOOZE+4   265.377777777
       REM           
       REM           HIC
       REM           
       STQ Q         SAVE MQ
       CAS BOOZE+5   264.777777776
       TXI *+2       WRONG
       TRA *+4       
       LDQ BOOZE+5   CORRECT TO MQ
       TSX ERROR-1,4 ACC ERR,CORRECT
       TRA ONA       ANS IN MQ
       REM           
       CLA Q         CHECK MQ
       CAS BOOZE+6   231.000000004
       TXI *+2       
       TRA *+3       OK
       REM           
       LDQ BOOZE+6   CORRECT TO MQ
       TSX ERROR,4   MQ ERR,CORRECT
       TSX OK,4      ANS IN MQ
       TRA ONA       
       REM           
       REM           
       REM           
*BIT IN ACC 9 AND 10 
       BCD 1FSB      
 DEAD  TSX CLEAR,4   
       CLS BOOZE+7   -202.4
       FSB COEF      -201.4#-202.6
       REM           
       REM           
       STQ Q         
       CAS BOOZE+8   -202.6
       TXI *+2       
       TRA *+4       OK
       LDQ BOOZE+8   CORRECT TO MQ
       TSX ERROR-1,4 ACC ERR,CORRECT
       TRA DEAD      ANS IN MQ
       REM           
       REM           
       CLA Q         
       CAS BOOZE+9   -147.0
       TXI *+2       
       TRA *+3       OK
       LDQ BOOZE+9   CORRECT TO MQ
       TSX ERROR,4   MQ ERR,CORRECT
       TSX OK,4      ANS IN MQ
       TRA DEAD      
       REM           
       REM           
       REM           THE HONEY DIPPER
       REM           
*BIT IN ACC 16,5TH STEP
       BCD 1FAD      
 MANS  TSX CLEAR,4   
       CLA BOOZE+10  233.0017777777
       FAD BOOZE     233.0000000001
       REM           
       REM           
       STQ Q         
       CAS BOOZE+11  224.4
       TXI *+2       
       TRA *+4       OK
       LDQ BOOZE+11  CORRECT TO MQ
       TSX ERROR-1,4 ACC ERR,CORRECT
       TRA MANS      ANS. IN MQ
       REM           
       CLA Q         CHECK MQ FACTOR
       CAS BOOZE+12  171.0
       TXI *+2       
       TRA *+3       OK
       LDQ BOOZE+12  MQ ERR,CORRECT
       TSX ERROR,4   ANS. IN MQ
       TSX OK,4      
       TRA MANS      
       REM           
       REM           
       REM           
*BIT IN ACC 17,5TH STEP
       BCD 1FSB      
 CHEST TSX CLEAR,4   
       FSB BOOZE+10  -233.001777777
       REM           
       STQ Q         
       CAS BOOZE+13  -223.777777740
       TXI *+2       
       TRA *+4       
       REM           
       LDQ BOOZE+13  CORRECT TO MQ
       TSX ERROR-1,4 ACC ERR,CORRECT
       TRA CHEST     ANS IN MQ
       REM           
       CLA Q         CHECK MQ FACTOR
       CAS BOOZE+14  -170.0
       TXI *+2       
       TRA *+3       OK
       LDQ BOOZE+14  CORRECT TO MQ
       TSX ERROR,4   MQ ERR,CORRECT
       TSX OK,4      ANS IN MQ
       TRA CHEST     
       REM           
       REM           
       REM           
*BITS IN ACC 9 AND 11,5TH STEP,SIGNS PLUS
       BCD 1FAD      
 YOHO  TSX CLEAR,4   
       CLA BOOZE+15  201.52525252525
       FAD BOOZE+16  234.52525252525
       REM           
       REM           
       STQ Q         
       CAS BOOZE+16  CHECK ACC
       TXI *+2       
       TRA *+4       OK
       LDQ BOOZE+16  CORRECT TO MQ
       TSX ERROR-1,4 ACC ERR,CORRECT
       TRA YOHO      ANS IN MQ
       REM           
       CLA Q         
       CAS BOOZE+15  201.52525252525
       TXI *+2       
       TRA *+3       OK
       LDQ BOOZE+15  CORRECT TO MQ
       TSX ERROR,4   MQ ERR,CORRECT
       TSX OK,4      ANS IN MQ
       TRA YOHO      
       REM           
       REM           
       REM           
*BITS IN ACC 9 AND 11,5TH STEP,SIGNS MINUS
       BCD 1FSB      
 HO    TSX CLEAR,4   
       CLS BOOZE+15  -201.52525252525
       FSB BOOZE+16  -234.52525252525
       REM           
       REM           
       STQ Q         
       CAS BOOZE+17  -234.52525252525
       TXI *+2       
       TRA *+4       OK
       LDQ BOOZE+17  CORRECT TO MQ
       TSX ERROR-1,4 ACC ERR,CORRECT
       TRA HO        ANS. IN MQ
       REM           
       REM           
       CLA Q         CHECK MQ
       CAS BOOZE+18  -201.52525252525
       TXI *+2       
       TRA *+3       OK
       LDQ BOOZE+18  CORRECT TO MQ
       TSX ERROR,4   MQ ERR,CORRECT
       TSX OK,4      ANS IN MQ
       TRA HO        
       REM           
       REM           
       REM           
*ACC AND MQ ZERO,5TH STEP.
       BCD 1FAD      
 ANDA  TSX CLEAR,4   
       CLA BOOZE+16  234.525252525
       FAD BOOZE+17  -234.525252525
       STZ Q+1       
       STQ Q         
       LDQ Q+1       CORRECT TO MQ
       STO Q+1       
       CAL Q+1       SIGN TO P.
       TZE *+3       ACC SHOULD#+0
       TSX ERROR-1,4 ACC ERR,SHOULD
       TRA ANDA      HAVE BEEN+ZERO.
       REM           
       REM           
       REM           
       CAL Q         SHOULD B ZERO
       TZE *+2       
       TSX ERROR,4   MQ ERR. MQ SHOULD
       TSX OK,4      HAVE BEEN+ZERO
       TRA ANDA      
       REM           
       REM           
       REM           
*SHIFT ACC AND MQ TO ZERO.
       BCD 1FAD      
 BOTLE TSX CLEAR,4   
       CLA BOOZE+19  -201.4
       FAD BOOZE+20  267.0,WATCH THAT
       STQ Q         FIRST STEP,ITS
       REM           A LULU
       TNZ *+2       ACC SHOULD
       TMI *+3       BE#-0
       TSX ERROR-1,4 ACC ERR,ACC SHOULD
       TRA BOTLE     BE #-0
       REM           
       CLA Q         CHECK MQ
       TNZ *+2       
       TMI *+2       
       TSX ERROR,4   MQ ERR. SHOULD
       TSX OK,4      HAVE BEEN#-0
       TRA BOTLE     
       REM           
       REM           
       REM           
       REM           
       REM           
*CHECK F.P. ROUND.   
       REM           
*NO BIT IN MQ COL 9. 
       REM           
       BCD 1FRN      
 RND   TSX CLEAR,4   CLEAR.
       CLA K1+1      +344.44040404040
       LDQ K1        +344.010101010
       FRN           SHOULD NOT ROUND
       SUB K1+1      CHECK ACC UNCHANGED
       STQ Q         SAVE MQ.
       TZE *+5       IF NOT ZERO,ACC ERR.
       ADD K1+1      RESTOR ACC.
       LDQ K1+1      CORRECT VALUE TO MQ
       TSX ERROR-1,4 ACC ERR. ON FRN WITH
       TRA RND       NO BIT IN MQ COL9.
       REM           CORRECT ANS IN MQ,
       REM           ORIG. ANS. IN ACC.
       REM           
       CLA Q         CHECK MQ UNCHANGED
       SUB K1        
       TZE *+4       OK IF ZERO
       ADD K1        ERR. RESTORE ANS.
       LDQ K1        CORRECT VALUE TO MQ.
       TSX ERROR,4   ERR IN MQ FACTOR ON
       REM           FRN WITH NO BIT IN
       REM           MQ COL 9. CORRECT ANS.
       REM           IS IN MQ,ORIG. ANS.
       REM           IN ACC.
       TSX OK,4      PROCEED OR
       TRA RND       REPEAT
       REM           
       REM           
       REM           
*FRN WITH A BIT IN MQ COL 9.
       REM           
       BCD 1FRN      
 FRNA  TSX CLEAR,4   CLEAR.
       LDQ K1+1      344.440404040 TO MQ.
       CLA K41       +000.00000200 TO ACC
       FRN           SHOULD RND.
       STQ Q         SAVE MQ.
       SUB K61       -201
       TZE *+5       OK IF ZERO.
       LDQ K61       CORRECT VALUE TO MQ.
       ADD K61       RESTORE ACC.
       TSX ERROR-1,4 ERR IN ACC ON FRN WITH
       TRA FRNA      A BIT IN MQ COL 9.
       REM           CORRECT ANS. IN MQ,
       REM           ORIG. ANS. IN ACC.
       REM           
       CLA Q         CHECK MQ UNCHANGED
       SUB K1+1      
       TZE *+4       OK IF ZERO.
       ADD K1+1      RESTORE ORIG. ANS.
       LDQ K1+1      CORRECT VALUE TO MQ.
       TSX ERROR,4   ERR IN MQ ON FRN WITH
       REM           A BIT IN MQ COL 9.
       REM           CORRECT ANS. IN MQ,
       REM           ORIG. ANS. IN ACC.
       TSX OK,4      PROCEED OR
       TRA FRNA      REPEAT.
       REM           
       REM           
       REM           
*NON-LINEAR PROGRAMMING FOLLOWS, SUB ROUTINES USED TO
*CHECK RESULTS, SUBROUTINES START AT...UONLY..SYMBOLIC.
       REM           
*RIPPLE OUT OF P INTO Q,SHOULD NOT TRAP.
       REM           
       BCD 1FRN      
 FRP   TSX CLEAR,4   CLEAR.
       COM           ALL ONES IN ACC.
       ARS 1         VACATE Q.
       LDQ FRP+12    001.4,NO BIT IN ONE
       FRN           CARRY TO Q,SHOULD
       REM           NOT TRAP.
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     
       HTR 4         ERR. ACC S,Q,P, AND 35.
       REM           SHOULD
       TRA FRP       HAVE Q. ITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35.
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 000400000000    ERR. ACC 1 TO 34.
       REM           CORRECT
       TRA FRP       ANS. IN MQ,ORIG ANS. IN AC
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 001400000000 MQ ERR. CORRECT ANS.
       REM           IN
       TRA FRP       MQ,ORIG ANS. IN ACC.
       REM           
       TSX OK,4      PROCEED OR
       TRA FRP       REPEAT.
       REM           
       REM           
       REM           
*FRN,WORST CASE RIPPLE CARRY,SHOULD NOT TRAP.
*RIPPLE OUT OF Q,SHOULD NOT TRAP.
       REM           
       BCD 1FRN      
 FRQ   TSX CLEAR,4   CLEAR
       COM           ALL ONES IN ACC.
       LDQ COEF      201.4
       FRN           CARRY OUT OF Q,
       REM           SHOULD NOT TRAP.
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4
       HTR           ERR. ACC S,Q,P, AND 35
       REM           SHOULD
       TRA FRQ       BE ZERO. BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35.
       REM
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 000400000000    ERR. ACC 1 TO 34.
       REM           CORRECT
       TRA FRQ       ANS. IN MQ,ORIG. ANS.
       REM           IN ACC
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 201400000000    MQ ERR. CORRECT ANS.
       TRA FRQ       IN MQ,ORIG. ANS. IN ACC.
       REM           
       TSX OK,4      PROCEED OR
       TRA FRQ       REPEAT.
       REM           
       REM           
       REM           
*FRN WITH BITS IN ACC 1 TO 34. NO BIT IN MQ 1.
       REM           
       BCD 1FRN      
 DON   TSX PART2,4   LITE 4 ON,CLEAR
       AXT WIESS,1   SET RETURN IN 
       SXA SECT2,1   CASE OF TRAP
       REM           
       CAL *+7       FILL ACC 1 TO 34
       LDQ FRP+12    001.4
       FRN           SHOULD NOT TRAP
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       REM           
       TSX ACB,4     
       HTR 1         ERR IN ACC S,Q,P,AND 35
       TRA DON       SHOULD HAVE 35
       REM           BITS IN ERR IN IND.
       REM           REG AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34
       REM           
       TSX ACCF,4    
       OCT 377777777776 ERR IN ACC 1 TO 34
       TRA DON       CORRECT ANS IN MQ.
       REM           
       REM           
*CHECK MQ COLS S TO 35
       REM           
       TSX MQF,4     
       OCT 001400000000 ERR IN MQ RESULT
       TRA DON       CORRECT ANS IN MQ
       REM           ORIG ANS IN ACC
       REM           
       TRA *+4       
 WIESS LXA 0,1       TRAP ADDRESS TO XRA
       TXI *+1,1,-1  *RA-1
       TSX ERROR,4   TRAP ERR. ADDRESS OF
       REM           INSTR. THAT CAUSED TRAP
       REM           IS IN XRA
       REM           
       TSX OK,4      PROCEED OR
       TRA DON       REPEAT
       REM           
       REM           
       REM           
       REM           
       REM           
*PLACE BIT IN Q,FRN TO P,SHOULD NOT TRAP
       REM           
       BCD 1FRN      
 JOE   TSX PART2,4   LITE 4 ON,CLEAR
       AXT BROWN,1   SET RETURN IN
       SXA SECT2,1   CASE OF TRAP.
       SSM           GET BITS IN
       STO FREE       ACC Q,AND 1 TO 35
       CAL FREE        BUT NO BIT
       COM              IN COL. P
       LDQ FRP+12    001.4
       FRN           SHOULD NOT TRAP
       REM           
       REM           
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     ERR IN ACC S,Q,P,AND 35
       HTR 4+2       SHOULD HAVE Q AND P,BITS
       TRA JOE       IN ERR IN IND.REG. AS
       REM           OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34
       REM           
       TSX ACCF,4    ERR IN ACC 1 TO 34
       OCT 000400000000 CORRECT ANS IN MQ
       TRA JOE       
       REM           
       REM           
*CHECK MQ COLS S TO 35
       REM           
       TSX MQF,4     ERR IN MQ RESULT
       OCT 001400000000 CORRECT ANS IN MQ.
       TRA JOE       ORIG ANS IN ACC
       TRA BROWN+3   
       REM           
 BROWN LXA 0,1       TRAP ADDRESS IN XRA
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERR. ADD. OF INSTR
       TSX OK,4      THAT CAUSED TRAP
       TRA JOE       IS IN XRA
       REM           
       REM           
       REM           
*BEGIN SECTION 2 OF FIRST PART 9M05
*FLOATING POINT WITH OVERFLOW AND UNDERFLOW
       REM           
       REM           
       REM           
       REM           
*WILL F.P. TRAP WORK ON FIRST TRAP CONDITION.
       REM           
       BCD 1FPTRP-   
 TR    TSX PART2,4   CLEAR
       AXT TRT,1     
       SXA SECT2,1   SET RETURN
       CLA RTC+3     376.4
       FAD RTC+3     ACC NOW 377.4
       FAD RTC+4     SHOULD TRAP HERE
       FAD RTC+4     AND GET THIS ADDRESS
       FAD RTC+4     
       FAD RTC+4     
       TSX ERROR-1,4 FAILED TO TRAP
       TRA TR        
       TRA TRT+3     
*CHECK TRAP ADDRESS IF TRAP OCCURS
 TRT   TSX ZERO,4    ERR IN TRAP ADDRESS
       HTR TR+6      CORRECT ADDRESS IN MQ
       TRA TR        ADDRESS WRITTEN IN ACC
       REM           
       TSX OK,4      PROCEED OR
       TRA TR        REPEAT.
       REM           
       REM           
*DOES TRAP MODE EFFECT F.P. TRAP.
       REM           
       BCD 1FPTRP-   
 TR1   TSX PART2,4   
       AXT TR1T,1    
       SXA SECT2,1   
       CLA RTC+5     L. TTR TR1E
       STO 1         
       ETM           
       CLA RTC+4     +377.4
       FAD RTC+4     FORCE OVERFLOW
       LTM           
       TSX ERROR-1,4 FAILED TO TRAP
       TRA TR1       
       TRA TR1T      CHECK ZERO ANYWAY
 TR1E  LTM           
       TSX ERROR-1,4 TRAP TO 1 INSTEAD
       TRA TR1       OF TO 10
       REM           
       REM           
*CHECK TRAP ADDRESS AT ZERO
 TR1T  TSX ZERO,4    ERR IN TRAP ADDRESS
       HTR TR1+8     CORRECT ADDRESS IN MQ
       TRA TR1       ADDRESS WRITTEN IN AC
       REM           
       CLA TMODE+6   CONTINUE TO
       STO 1         MONITOR 1
       REM           
       TSX OK,4      PROCEED OR
       TRA TR1       REPEAT
       REM           
*MAKE SURE THAT F.P. TRAP DOES NOT CAUSE 709 TO
*ENTER TRAPPING MODE. 
       REM           
       REM           
       BCD 1FPTRP-   
 T     TSX PART2,4   LITE 4 ON,CLEAR
       LDQ LTTR      PUT TTR INST. AT LOC.1
       STQ 1         INCASE WE ENTER
       REM           TRAPPING MODE.
       AXT TFP,1     SET RETURN ADDRESS
       SXA SECT2,1   FOR F.P. TRAP.
       COM           
       SLW FREE      AL ONES.
       CLS FREE      MAKE SIGN PLUS.
       FAM FREE      SHOULD OVERFLOW
       TSX ERROR-1,4 FAILED TO F.P. TRAP.
       TRA T         
 TFP   TRA LTTR+4    OK,DID NOT ETM
       REM           
 LTTR  TTR LTTR+1    INST. AT LOC 1.
       LTM           
       TSX ERROR-1,4 ENTERED TRAPPING MODE
       REM
       TRA T         ON F.P. TRAP.
       REM           
       CLA TMODE+6   MONITOR 1
       STO 1         
       TSX OK,4      PROCEED OR
       TRA T         REPEAT.
       REM           
       REM           
       REM           
*CHECK THAT TRAP WRITES ONLY DEC AND ADD.
*CHECK WITH ONES AT ZERO.
       REM           
       BCD 1FPOV-    
 TW    TSX PART2,4   CLEAR,LIGHT 4 ON.
       AXT TWT,1     SET RETURN
       SXA SECT2,1   ADDRESS.
       COM           
       SLW           ALL ONES AT ZERO.
       CLS           
       FAM           FORCE OVERFLOW.
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA TW        
       REM           
 TWT   CAL           CHECK PREFIX AND TAG.
       ANA FERM+6    PREFIX AND TAG REMAIN.
       REM           
*CHECK ACC COLS S,Q,P,AND 35.
       TSX ACB,4     ERROR IN WIRTING ZERO FOR
       HTR 2         F.P. TRAP. SHOULD HAVE
       TRA TW        P BIT. BITS IN ERROR
       REM           IN IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1@#35
       REM           
*CHECK ACC COLS 1 TO 34
       TSX ACCF,4    ERR. IN WRITING ZERO FOR
       OCT 300000700000     F.P. TRAP. CORRECT BI
       REM           TS INM,
       TRA TW        BITS WRITTEN IN AC
       REM           PREFIX AND TAG.
       REM           
*CHECK ADDRESS AT ZERO
       TSX ZERO,4    
       HTR TW+7      ERR. IN WRITING ADDRESS
       TRA TW        IN ZERO FOR F.P. TRAP.
       TSX OK,4      CORRECT ADD. IN MQ,
       TRA TW        ADDRESS WRITTEN IN ACC.
       REM           
       REM           
       REM           
*CHECK TRAP WRITTING WITH ALL ZEROS AT ZERO.
       REM           
       BCD 1FPOV-    
 TWA   TSX PART2,4   CLEAR,LIGHT 4 ON,ALL OS
       AXT TWAT,1    AT ZERO-
       SXA SECT2,1   SET RETURN ADDRESS.
       CLA SALON+6   
       FAD SALON+6   FORCE OVERFLOW.
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA TWA       
       REM           
*CHECK PREFIX AND TAG AT ZERO,SHOULD BE 0.
 TWAT  CAL           
       ANA FERM+6    DROP DEC. AND ADD.
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     S,Q,P,AND 35 SHOULD BE 0.
       HTR           ERROR IN WRITING ZERO IN
       TRA TWA       S,Q,P,AND 35. BITS IN ERROR
       REM           IN IND. REG. AS OCTAL NOS.
       REM           10#2,4#Q,2#P,1#35
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    CHECK PREF. AND TAG.
       HTR           ERROR IN WRITING ZERO
       TRA TWA       PREF. AND TAG FOR F.P.
       REM           CORRECT BITS IN MQ
       REM           BITS WRITTEN IN ACC.
       REM           
*CHECK ADDRESS WRITTEN AT ZERO.
       TSX ZERO,4    
       HTR TWA+5     ERR. IN WRITING TRAP ADDRES
       TRA TWA       CORRECT ADDRESS IN
       TSX OK,4      MQ,ADDRESS WRITTEN IN ACC.
       TRA TWA       
       REM           
       REM           
*UFM WITH UNDERFLOW. 
       REM           
       BCD 1UFM-     
 P6    TSX PART2,4   LITE 4 ON,CLEAR.
       AXT P6T,1     
       SXA SECT2,1   RETURN ADDRESS
       LDQ K20       10.4
       UFM K20       UNDERFLOW.
       TSX ERROR-1,4 FAILED TO TRAP
       TRA P6        
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
 P6T   TSX ACB,4     
       HTR 4+2       ERR. ACC S,Q,P, AND 35. SHOULD
       TRA P6        HAVE Q AND P. BITS IN
       REM           ERR IN IND. REG. AS OCTAL NOS.
       REM              10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 220200000000 ERR IN ACC 1 TO 34.
       REM           CORRECT
       TRA P6        ANS. IN MQ,ORIG ANS. IN AC
       REM           
       TSX OK,4      PROCEED OR
       TRA P6        REPEAT.
       REM           
       REM           
       REM           
*FLOATING POINT UNDERFLOW WITH FAD.
       REM           
       BCD 1FAD-     
 P3    TSX PART2,4   LITE 4 ON,CLEAR.
       AXT P3T,1     
       SXA SECT2,1   SET RETURN ADDRESS
       CLA K8        +007.1
       FAD K8        FORCE UNDERFLOW. MQ.
       TSX ERROR-1,4 FAILED TO TRAP
       TRA P3        
       TRA *+5       CANT TEST TRIGS.
       REM           
*CHECK OVERFLOW TRIGS.
 P3T   TSX UONLY,4   ACC OV. ON
       TRA P3        
       TRA *+2       DIVIDE CHECK ON
       TRA P3        
       REM           
*CHECK ACC COLS S,Q,P, AND 35
       TSX ACB,4     
       HTR           ERR. ACC S,Q,P, AND 35.
       REM           SHOULD
       TRA P3        BE ZERO. BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35.
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 006400000000    ERR ACC 1 TO 34.
       REM           CORRECT
       TRA P3        ANS. IN MQ,ORIG. ANS. IN
       REM           ACC.
       REM           
*CHECK MQ COLS S TO 35
       TSX MQF,4     
       OCT 353000000000    MQ ERR. CORRECT ANS.
       REM           IN
       TRA P3        MQ,ORIG. ANS. IN ACC.
       REM           
*CHECK TRAP ADDRESS AT ZERO.
       TSX ZERO,4    
       HTR P3+5      ERR. IN TRAP ADDRESS,
       TRA P3        CORRECT ADDRESS IN MQ,
       REM           ADDRESS WRITTEN IN ACC.
       TSX OK,4      PROCEED OR
       TRA P3        REPEAT.
       REM           
       REM           
       REM           
*FLOATING POINT TRAP ON UNDERFLOW WITH FDP.
       REM           
       BCD 1FDP-     
 F27   TSX PART2,4   LITE 4 ON,CLEAR.
       AXT F27T,1    
       SXA SECT2,1   SET RETURN ADDRESS
       CLA K0+2      033.404040440
       FDP K1+1      BY 344.440404040. UND.
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA F27       
       TRA *+5       CANT TEST TRIGS.
       REM           
*CHECK OVERFLOW TRIGGERS.
 F27T  TSX UONLY,4   ACC OV. ON
       TRA F27       
       TRA *+2       DIVIDE CHECK ON
       TRA F27       
       REM           
       REM           
*CHECK ACC COLS S,Q,P, AND 35. 
       TSX ACB,4     
       HTR           ERR. ACC S,Q,P, AND 35
       REM           SHOULD
       TRA F27       BE 0. BITS IN ERR IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 000423035700 ERR. ACC 1 TO 34.
       REM           CORRECT
       TRA F27       ANS. IN MQ,ORIG. ANS.
       REM           IN ACC
       REM           
*CHECK MQ COLS S TO 35
       TSX MQF,4     
       OCT 267715412642    ERR IN MQ. CORRECT
       REM           ANS.
       TRA F27       IN MQ,ORIG. ANS. IN ACC.
       TSX OK,4      PROCEED OR
       TRA F27       REPEAT.
       REM           
       REM           
       REM           
*F.P. OVERFLOW WITH UFM.
       REM           
       BCD 1UFM-     
 P5    TSX PART2,4   LITE 4 ON,CLEAR
       AXT P5T,1     
       SXA SECT2,1   SET RETURN ADDRESS
       LDQ K2        377.4
       UFM K13       233.4,OVERFLOW
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA P5        
*CHECK ACC COLS S,Q,P, AND 35.
 P5T   TSX ACB,4
       HTR 2         ERR. ACC S,Q,P, AND 35.
       REM           SHOULD
       TRA P5        HAVE P. BITS IN ERROR IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35.
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 032200000000   ERR. ACC 1 TO 34.
       REM           CORRECT
       TRA P5        ANS IN MQ,ORIG ANS. IN ACC.
       REM           
       TSX OK,4      PROCEED OR
       TRA P5        REPEAT.
       REM           
       REM           
       REM           
*CHECK F.P. TRAP ON OVERFLOW WITH FAD.
       REM           
       BCD 1FAD-     
 F26   TSX PART2,4   LITE 4 ON,CLEAR.
       AXT F26T,1    
       SXA SECT2,1   SET RETURN ADDRESS
       CLA K2        +377.4
       FAD K2        FORCE OVERFLOW.
       TSX ERROR-1,4 FAILED TO TRAP
       TRA F26       
       TRA *+5       CANT TEST TRIGS.
       REM           
 F26T  TSX OONLY,4   ACC OV ON
       TRA F26       
       TRA *+2       DIVIDE CHECK ON
       TRA F26       
       REM           
*CHECK ACC COLS S,Q,P, AND 35
       TSX ACB,4     
       HTR 2         ERR. ACC S,Q,P, AND 35.
       REM           SHOULD
       TRA F26       HAVE P. BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35.
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 000400000000    ERR. ACC 1 TO 34.
       REM           CORRECT
       TRA F26       ANS. IN MQ,ORIG. ANS. IN
       REM           ACC.
       REM           
       TSX OK,4      PROCEED OR
       TRA F26       REPEAT.
       REM           
       REM           
       REM           
*FLOATING POINT OVERFLOW AND TRAP WITH FSM.
       REM           
       BCD 1FSM-     
 P2    TSX PART2,4   LITE 4 ON,CLEAR.
       AXT P2T,1     
       SXA SECT2,1   SET RETURN ADDRESS.
       CLS K3        -377.77777777
       FSM K3        FORCE OVERFLOW
       TSX ERROR-1,4 FAILED TO TRAP
       TRA P2        
       TRA *+5       CANT TEST TRIGGERS.
       REM           
*CHECK OVERFLOW TRIGGERS.
 P2T   TSX OONLY,4   ACC OV. ON
       TRA P2        
       TRA *+2       DIVIDE CHECK ON
       TRA P2        
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     
       HTR 1+2+8     ERR. ACC S,Q,P AND 35.
       REM           SHOULD
       TRA P2        HAVE S,P, AND 35. BITS IN
       REM           ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 000777777776    ERR ACC 1 TO 34.
       REM           CORRECT
       TRA P2        ANS IN MQ,ORIG ANS IN ACC.
       REM           
*CHECK MQ COLS S TO 35
       TSX MQF,4     
       OCT -345000000000    MQ ERR. CORRECT ANS.
       TRA P2        IN MQ,ORIG. ANS. IN ACC
       REM           
*CHECK TRAP ADDRESS AT ZERO.
       TSX ZERO,4    
       HTR P2+5      ERR IN TRAP ADDRESS.
       TRA P2        CORRECT ADDRESS IN MQ,
       REM           ADDRESS WRITTEN IN ACC.
       TSX OK,4      PROCEED OR
       TRA P2        REPEAT.
       REM           
       REM           
       REM           
*FLOATING POINT OVERFLOW WITH FDP. UNLIKE SIGNS.
       REM           
       BCD 1FDP-     
 P11   TSX PART2,4   LITE 4 ON,CLEAR
       AXT P11T,1   
       SXA SECT2,1   SET RETURN ADDRESS.
       CLS K2        -377.4
       FDP K20       10.4
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA P11       
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
 P11T  TSX ACB,4     
       HTR 8         ERR. ACC S,Q,P, AND 35. SHOULD
       TRA P11       HAVE S. BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35.
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 345000000000   ERR ACC 1 TO 34.
       REM           CORRECT
       TRA P11       ANS. IN MQ,ORIG. ANS. 
       REM           IN ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT -170400000000 MQ ERR. CORRECT ANS.
       TRA P11       IN MQ,ORIG. ANS. IN ACC.
       REM           
       REM           
       TSX OK,4      PROCEED OR
       TRA P11       REPEAT.
       REM           
       REM           
       REM           
*F.P. TRAP ON OVERFLOW WITH FRN.
       BCD 1FRN-     
 F31   TSX PART2,4   LITE 4 ON,CLEAR.
       AXT F31T,1    
       SXA SECT2,1   SET RETURN ADDRESSS.
       CLA K3        +3777.77777777
       LDQ K1+1      +344.440404040
       FRN           
*WORST CASE,RIPPLE CARRY THROUGH FRACTION TO
*ACC COL 9,CARRY THROUGH CHARACTERISTIC TO P, AND TRAP.
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA F31       
       TRA *+5       CANT TEST TRIG.
       REM           
*CHECK OV TRIGGERS.  
 F31T  TSX OONLY,4   ACC OV ON
       TRA F31       
       TRA *+2       DIVIDE CHECK ON
       TRA F31       
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     
       HTR 2         ERR. ACC S,Q,P AND 35.
       REM           SHOULD
       TRA F31       HAVE P. BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#2,4#Q,2#P,1#35.
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 000400000000    ERR ACC 1 TO 34.
       REM           CORRECT
       TRA F31       ANS. IN MQ,ORIG ANS. IN ACC
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 344440404040    ERR IN MQ. CORRECT
       REM           ANS.
       TRA F31       IN MQ,ORIG. ANS IN ACC.
       REM           
*CHECK TRAP ADDRESS AT ZERO.
       TSX ZERO,4    
       HTR F31+6     ERR IN TRAP ADDRESS.
       TRA F31       CORRECT ADDRESS IN MQ,
       REM           ADDRESS WRITTEN IN ACC.
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO.
       TSX BITS,4    CHECK BITS F31
       HTR 0,0,6     SHOULD HAVE 15 AND 16.
       TSX ERROR,4   CORRECT BITS IN MQ,
       TSX OK,4      ORIG. BITS IN ACC.
       TRA F31       PROCEED OR REPEAT.
       REM           
       REM           
       REM           
*END PART 1 OF 9M05. GO ON TO PART 2, SECTION 1
       REM           
       REM           
       REM           
*THERE ARE TWO SECTIOSN OF PART 2, THEY ARE
*SECTION 1, THE INDICATOR TEST, AND
*SECTION 2, RELIABILITY TEST.
       REM           
       REM           
       REM           
*BEGIN PART 2 OF 9M05, 709 FLOATING POINT  TRAP DIAGNOSTIC,
*CHECKING THE WRITING OF THE INDICATOR BITS IN THE 
*DECREMENT FIELD OF LOCATION ZERO. EVERY POSSIBLE BIT
*COMBINATION IS PROVIDED FOR. THE BITS INVOLVED ARE
*IN COLS 14, 15, 16, AND 17.
*NON-LINEAR PROGRAMMING MODE CONTINUES.
       REM           
*UFA WITH OVER FLOW, BITS 15 AND 16
       REM           
       BCD 1UFA-     
 IT1   TSX PART2,4   LIGHT 4 ON,CLEAR
       AXT *+7,1     
       SXA SECT2,1        SET RETURN ADDRESS
       CLA K3             +377.777777777
       UFA K3             SHOULD OVER FLOW
       TSX ERROR-1,4      FAILED TO TRAP
       TRA IT1       
       TRA *+5       CANT TEST TRIGGERS
       REM           
       TSX OONLY,4   ACC OV ON
       TRA IT1       
       TRA *+2       DIVIDE CHECK ON
       TRA IT1       
       REM           
*CHECK ACC BITS S,P,Q,35. BITS IN ERROR PUT
*IN INDICATOR REG AS OCTAL NUMBERS AS FOLLOWS
*10#S, 4#Q, 2#P, 1#35.
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4          SHOULD HAVE P AND 35
       HTR 2+1            BITS IN ERROR IN IND REG
       REM           10#2,4#Q,2#P,1#35.
       TRA IT1       
       REM           
*CHECK ACC COLS 1 TO 34
       REM           
       TSX ACCF,4         IF ERROR,
       OCT 000777777776   CORRECT ANS WILL BE
       TRA IT1            IN MQ, ORIG ANS IN ACC
       REM           
*CHECK MQ COLS S TO 35.
       REM           
       TSX MQF,4          IF ERROR, CORRECT ANS.
       OCT 345000000000   WILL BE IN MQ, ORIG
       TRA IT1            ANS IN ACC
       REM           
*CHECK ADDRESS AT ZERO.
       REM           
       TSX ZERO,4         CORRECT ADDRESS
       HTR IT1+5          WILL BE IN MQ,
       TRA IT1            ORIG ADDRESS IN AC
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO
       REM           
       TSX BITS,4    CHECK BITS IT1
       HTR 0,0,6          CORRECT BITS PUT IN
       TSX ERROR,4        MQ, ORIG BITS IN ACC
       TSX OK,4           PROCEED OR
       TRA IT1            REPEAT.
       REM           
       REM           
*TRAP RELIABILITY, UFA, BITS 15 AND 16. 50 PASSES
       REM           
       BCD 1UFA-     
 IT2   TSX PART2,4        CLEAR, TURN ON LITE 4
       AXT *+3,1     SET RETURN ADDRESS
       SXA SECT2,1   
       AXT 52,1           REPEAT 50 TIMES
       TNX *+6,1,1   REPEAT IT2 AFTER TRAP.
       CLA K3        377.777777777
       UFA K3             FORCE OVER FLOW.
       TSX ERROR-1,4      FAILED TO TRAP
       TRA IT2            REPEAT.
       TRA *+5       CANT TEST TRIGS
       REM           
       TSX OONLY,4   ACC OV. ON
       TRA IT2       
       TRA *+2       DIVIDE CHECK ON
       TRA IT2       
       REM           
*CHECK ACC COLS S,Q,P, AND 35
       TSX ACB,4     
       HTR 2+1            BITS WRONG IN IND. REG
       TRA IT2            AS OCTAL NUMBERS
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34
       TSX ACCF,4         CHECK ACC 1 TO 34
       OCT 000777777776   CORRECT ANS IN MQ, ORIG
       TRA IT2            ANS IN ACC. S,P,Q,35 DRO
       REM           
       TSX MQF,4          CHECK MQ S TO 35
       OCT 345000000000   CORRECT ANS IN MQ, ORIG
       TRA IT2            ANS IN ACC.
       REM           
       TSX ZERO,4         CHECK TRAP ADDRESS
       HTR IT2+7          CORRECT ADD. IN MQ,
       TRA IT2            ORIG ADD. IN ACC.
       REM           
       TSX BITS,4    CHECK BITS IT2
       HTR 0,0,6          CORRECT BITS PUT IN
       TSX ERROR,4        MQ, ORIG BITS IN ACC.
       TSX OK,4           PROCEED OR
       TRA IT2            REPEAT.
       REM           
       REM           
*FLOATING POINT UNDER FLOW, BIT 17
       REM           
       BCD 1UFA-     
 IT3   TSX PART2,4        CLEAR, LIGHT 4 ON
       AXT *+7,1     
       SXA SECT2,1        SET RETURN ADDRESS
       CLA K8             +007.1
       UFA K8             UNDERFLOW
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA IT3            REPEAT
       TRA *+5       CANT TEST TRIGGERS
       REM           
       TSX UONLY,4   ACC OV. ON
       TRA IT3       
       TRA *+2       DIVIDE CHECK ON
       TRA IT3       
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 0              SHOULD ALL BE OF, WRONG
       TRA IT3            BITS IN IND-REG IN OCTAL
       REM           10#S,4#Q,2#P,1#35
       REM           
       TSX ACCF,4         CHECK AC 1 TO 34
       OCT 007200000000   CORRECT ANS IN MQ, ORIG
       TRA IT3            ANS IN ACC
       REM           
       TSX MQF,4          CHECK MQ S TO 35,
       OCT 354000000000   CORRECT ANS. IN MQ
       TRA IT3            ORIG ANS IN ACC
       REM           
       TSX ZERO,4         CHECK TRAP ADDRESS
       HTR IT3+5          CORRECT ADD IN MQ
       TRA IT3            ORIG ADD IN ACC
       REM           
       TSX BITS,4    CHECK BITS IT3
       HTR 0,0,1          CORRECT BITS IN MQ
       TSX ERROR,4        ORIG BITS IN ACC
       TSX OK,4           PROCEED OR
       TRA IT3            REPEAT.
       REM           
       REM           
       REM           
*FAD UNDERFLOW, SIGNS ALIKE, NO EXHCANGE, NO 9 CARRY, BITS 16,17.
       REM           
       BCD 1FAD-     
 IT4   TSX PART2,4        MAKE SURE AC OV OFF
       NOP                LIGHT 4 ON
       AXT *+7,1     SET RETURN
       SXA SECT2,1        ADDRESS
       CLA SALON+9        1.007777777
       FAD SALON+8        4.004444444
       TSX ERROR-1,4      FAILED TO TRAP
       TRA IT4            REPEAT TEST
       TRA *+5       DO NOT TEST OV TRIGGERS
       REM           
       TSX UONLY,4   ACC OV. ON
       TRA IT4       
       TRA *+2       DIVIDE CHECK ON
       TRA IT4       
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 2+4            SHOULD HAVE P+Q ONLY
       TRA IT4            BITS IN ERROR IN IND
       REM           REG AS OCTAL NUMBERS
       REM           10#S,4#Q,2#P,1#35
       REM           
       TSX ACCF,4         CHECK ACC COLS. 1 TO 34
       OCT 376544444370 CORRECT ANS.
       TRA IT4            IF ERROR, CORRECT ANS.
       REM                WILL BE IN MQ, ORIG ANS.
       REM           
       TSX MQF,4          CHECK MQ COLS. S TO 35
       OCT 343000000000   CORRECT ANS.
       TRA IT4            IF ERROR, CORRECT ANS-
       REM           WILL BE IN MQ,
       REM           ORIG ANS. IN ACC
       REM           
       TSX ZERO,4         CHECK ADDRESS AT ZERO
       HTR IT4+6          CORRECT ADDRESS, WILL
       TRA IT4            BE IN MQ IF ERROR, ORIG
       REM                WILL BE IN ACC
       REM           
       TSX BITS,4    CHECK BITS IT4
       HTR 0,0,3          BITS 16 AND 17 ONLY
       TSX ERROR,4        WRONG ANS IN ACC, MQ COR
       TSX OK,4           PROCEED TO NEXT TEST
       TRA IT4            REPEAT TEST.
       REM           
       REM           
       REM           
*SIGNS UNLIKE, NO EXCHANGE, 9 CARRY, BITS 16 AND 17
       REM           
       BCD 1FSB-     SAME AS FAD EXCEPT SR SIGN
 IT5   TSX PART2,4        MAKE SURE ACC OV LIGHT 0
       NOP                LIGHT 4 ON
       AXT *+7,1     SET RETURN ADDRESS
       SXA SECT2,1   
       CLA SALON+9        1.007777777
       FSB SALON+8   4.004444444. MQ AND ACC ARE
       REM           EXHCANGED ON STEP 3 TO COMP.
       REM           
       TSX ERROR-1,4      FAILED TO TRAP
       TRA IT5       
       TRA *+5       CAN NOT TEST TRIGGERS
       REM           
       TSX UONLY,4   ACC OV. ON
       TRA IT5       
       TRA *+2       DIVIDE CHECK ON
       TRA IT5       
       REM           
* CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     
       HTR 2+4+8     SHOULD HAVE S,Q,P ONLY
       TRA IT5            WRONG BITS IN IND. REG.
       REM           AS OCTAL NUMBERS.
       REM           10#S,4#Q,2#P,1#35
       REM           
       TSX ACCF,4         CHECK ACC COLS 1-34 ONLY
       OCT 375711111020 CORRECT ANS WILL BEIN MQ
       TRA IT5            IF ERROR, ORIG ANS. IN A
       REM           
       TSX MQF,4          CHECK MQ, CORRECT ANS WI
       OCT -342000000000 BE IN MQ. ORIG ANS. IN
       TRA IT5            ACC IF ERROR.
       REM           
       TSX ZERO,4         CHECK ADDRESS AT ZERO.
       HTR IT5+6          CORRECT ADD. WILL BE IN
       TRA IT5            ORIG ADD. IN ACC IF ERRO
       REM           
       TSX BITS,4    CHECK BITS IT5
       HTR 0,0,3          SHOULD HAVE 16 AND 17 ON
       TSX ERROR,4        CORRECT BITS IN MQ
       TSX OK,4           ORIG. BITS IN ACC.
       TRA IT5       
       REM           
       REM           
       REM           
*UFM WITH OVERFLOW, BITS 15,16,17. 26 ZEROS IN MULTIPLYER
       REM           
       BCD 1UFM-     
 IT6   TSX PART2,4        MAKE SURE ACC OV OFF
       NOP                LIGHT 4 ON
       AXT *+7,1     SET RETURN ADDRESS
       SXA SECT2,1   
       LDQ K2             377.4
       UFM SALON+10       277.4
       TSX ERROR-1,4      FAILED TO TRAP
       TRA IT6            REPEAT
       TRA *+5       CAN NOT TEST TRIGGERS
       REM           
       TSX OONLY,4   ACC OV ON.
       TRA IT6       
       TRA *+2       DIVIDE CHECK ON
       TRA IT6       
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 2              SHOULD ONLY HAVE P
       TRA IT6            BITS IN ERROR IN IND. RE
       REM           10#S,4#Q,2#P,1#35
       REM           OCTAL
       REM           
       TSX ACCF,4         CHECK ACC COLS 1 TO 34
       OCT 076200000000 CORRECT ANS. WILL BEIN
       TRA IT6            MQ, ORIG ANS IN ACC ON E
       REM           
       TSX MQF,4          CHECK MQ
       OCT 043000000000 CORRECT,WILL BE IN MQ,
       TRA IT6            ORIG ANS. IN ACC
       REM           
       TSX ZERO,4         CHECK TRAP ADDRESS
       HTR IT6+6          CORRECT WILL BE IN MQ,
       TRA IT6            ORIG. ADDRESS IN ACC
       REM           
       TSX BITS,4    CHECK BITS IT6
       HTR 0,0,7          SHOULD HAVE 15,16,17
       TSX ERROR,4        CORRECT BITS IN MQ,
       TSX OK,4           ORIG BITS IN ACC.
       TRA IT6            REPEAT OR PROCEED
       REM           
       REM           
       REM           
*FDP TO CHECK REMAINING BIT COMBINATIONS
       REM           
*FDP UNDERFLOW, BITS 14, 17.
       REM           
       BCD 1FDP-     
 IT7   TSX PART2,4   MAKE SURE ACC OV OFF
       NOP           LIGHT 4 ON
       AXT *+7,1     SET RETURN
       SXA SECT2,1   ADDRESS
       CLA K26            144.07
       FDP K27            345.7, UNDERFLOW
       TSX ERROR-1,4      FAILED TO TRAP
       TRA IT7       
       TRA *+5       CAN NOT TEST TRIGGERS
       REM           
       TSX UONLY,4   ACC OV. ON
       TRA IT7       
       TRA *+2       DIVIDE CHECK ON
       TRA IT7       
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR                SHOULD NOT HAVE ANY ONES
       TRA IT7            WRONG BITS IN IND. REG.
       REM                10#S, 4#Q, 2#P, 1#35
       REM           
       TSX ACCF,4         CHECK ACC COLS 1-34
       OCT 111000000000   CORRECT ANS. IN MQ, ORIG
       TRA IT7            ANS. IN ACC
       REM           
       TSX MQF,4          CHECK MQ S TO 35
       OCT 377100000000   CORRECT ANS. IN MQ, ORIG
       TRA IT7            ANS. IN ACC
       REM           
       TSX ZERO,4         CHECK TRAP ADDRESS
       HTR IT7+6          CORRECT ADD IN MQ, ORIG
       TRA IT7            ADD. IN ACC
       REM           
       TSX BITS,4    CHECK BITS IT7
       HTR 0,0,9          CORRECT BITS IN MQ, ORIG
       TSX ERROR,4        BITS IN ACC.
       TSX OK,4           PROCEED OR
       TRA IT7            REPEAT
       REM           
       REM           
       REM           
       REM           
*FDP UNDERFLOW, BITS 14,16,17, CALCULATE ACC FACTOR,
*SIGN UNLIKE         
       REM           
       BCD 1FDP-     
 IT8   TSX PART2,4        CLEAR, LIGHT 4 ON
       CLS K0+2           -033.404040404 IN ACC
       AXT SETIT,1        SKIP TO IT8 + 10
       SXA SECT2,1        IF TRAP ERROR. AND GO ON
       REM                WITH CORRECT ANS.
       FDP SALON+11       BY 2, SHOULD NOT TRAP
*IF TRAP OCCURS HERE,INDICATION OF TRAP ERROR
*WILL BE GIVEN FROM THE SUBROUTINE SET IT,THE
*CORRECT QUOTIENT WILL BE PLACED IN THE MQ
*WITH LDQ,AND TEST IT8 WILL CONTINUE FROM
*THIS POINT.         
       PXD                CLEAR ACC
       SLN 4         
       AXT *+7,1     
       SXA SECT2,1        SET RETURN ADDRESS
       LLS 35             -032.404040404 TO ACC
       REM           SHOULD NOT GET ACC OV.
       FDP K1+1      BY 344.440404040, UND.
       TSX ERROR-1,4      FAILED TO TRAP
       TRA IT8       
       TRA *+5       CAN NOT TEST TRIGS
       REM           
       TSX UONLY,4   ACC OV. ON
       TRA IT8       
       TRA *+2       DIVIDE CHECK ON
       TRA IT8       
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 2+4+8     SHOULD HAVE S,Q,P. BITS IN
       TRA IT8            ERROR IN IND REG AS FOLL
       REM                10#S, 4#Q, 2#P, 1#35
       REM           
       TSX ACCF,4        CHECK ACC COLS 1 TO 34
       OCT 377423035700  CORRECT, WILL BE IN MQ,
       TRA IT8           ANS. IN ACC.
       REM           
       TSX MQF,4         CHECK MQ COLS S TO 35
       OCT -266715412642 CORRECT, WILL BE IN MQ,
       TRA IT8           ANS. IN ACC.
       REM           
       TSX ZERO,4        CHECK TRAP ADDRESS
       HTR IT8+11        CORRECT, WILL BE IN MQ,
       TRA IT8           ADD. WILL BE IN ACC
       REM           
       TSX BITS,4    CHECK BITS IT8
       HTR 0,0,11        CORRECT, WILL BE IN MQ,
       TSX ERROR,4       BITS IN ACC. WANT 14,16,
       TSX OK,4          PROCEED OR
       TRA IT8           REPEAT
       REM           
       REM           
       REM           
*FDP WITH ACC UND., BITS 14,16 MQ OK.
       REM           
       BCD 1FDP-     
 IT9   TSX PART2,4       LIGHT 4 ON
       NOP               ACC OV OFF
       AXT *+7,1     SET RETURN
       SXA SECT2,1       ADDRESS
       CLA SALON+12      32.404040404
       FDP SALON+13      32.440404040
       TSX ERROR-1,4     FAILED TO TRAP
       TRA IT9           REPEAT
       TRA *+5       CAN NOT TEST TRIGGERS
       REM           
       TSX UONLY,4   ACC OV ON
       TRA IT9       
       TRA *+2       DIVIDE CHECK ON
       TRA IT9       
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 2+4       SHOULD HAVE Q,P.
       TRA IT9            WRONG BITS IN IND REG.
       REM           AS OCTAL NUMBERS.
       REM           10#S,4#Q,2#Q,1#35.
       REM           
       TSX ACCF,4         CHECK ACC COLS 1 TO 34
       OCT 377423035700   CORRECT, WILL BE IN MQ,
       TRA IT9            ORIG ANS IN ACC
       REM           
       TSX MQF,4          CHECK MQ COLS. S TO 35
       OCT 200715412642   CORRECT, WILL BE IN MQ,
       TRA IT9            ORIG ANS. IN ACC.
       REM           
       TSX ZERO,4         CHECK TRAP ADDRESS
       HTR IT9+6          CORRECT, WILL BE IN MQ
       TRA IT9            ORIG ADD. IN ACC
       REM           
       TSX BITS,4    CHECK BITS IT9
       HTR 0,0,10         CORRECT BITS IN MQ.
       TSX ERROR,4        ORIG BITS IN ACC.
       TSX OK,4           PROCEED OR
       TRA IT9            REPEAT
       REM           
       REM           
       REM           
*FDP WITH MQ OV., ACC. OK. BITS 14,15,17.
       REM           
       BCD 1FDP-     
 IT10  TSX PART2,4        LIGHT 4 ON
       NOP                MAKE SURE ACC OF OFF
       AXT *+7,1     SET RETURN
       SXA SECT2,1        ADDRESS
       CLA K2             377.4
       FDP K20            10.4 SHOULD OVERFLOW
       TSX ERROR-1,4      FAILED TO TRAP
       TRA IT10           REPEAT
       TRA *+5       CAN NOT TEST TRIGGERS
       REM           
       TSX OONLY,4   ACC OV. ON
       TRA IT10      
       TRA *+2       DIVIDE CHECK ON
       TRA IT10      
       REM           
       TSX ACB,4          CHECK ACC COLS S,Q,P,35.
       HTR                SHOULD ALL BE 0, WRONG B
       TRA IT10           IN IND REG AS FOLLOWS
       REM                10#S, 4#Q, 2#P, 1#35, OC
       REM           
       TSX ACCF,4         CHECK ACC COLS 1 TO 34
       OCT 345000000000   CORRECT ANS. PUT IN MQ,
       TRA IT10           ORIG ANS. IN ACC.
       REM           
       TSX MQF,4          CHECK MQ COLS S TO 35
       OCT 170400000000   CORRECT ANS PUT IN MQ,
       TRA IT10           ORIG ANS. IN ACC.
       REM           
       TSX ZERO,4         CHECK TRAP ADDRESS
       HTR IT10+6         CORRECT ADDERSS PUT IN M
       TRA IT10           ORIG ADD. IN ACC
       REM           
       TSX BITS,4    CHECK BITS IT10
       HTR 0,0,13         CORRECT BITS PUT IN MQ,
       TSX ERROR,4        ORIG BITS IN ACC.
       TSX OK,4           PROCEED OR
       TRA IT10           REPEAT
       REM           
       REM           
       REM           
*END SECTION 1 OF PART 2 9M05. GO ON TO SECTION 2.
       REM           
       REM           
*FLOATING POINT ACCURACY AND RELIABILITY TESTS. INCLUDING
*SIMULATED APPLICATION PROGRAMMING OF CUSTOMER-TYPE
*PROBLEMS.           
       REM           
       REM           
*FMP,23 ZEROS IN MULTIPLYER
       REM           
       BCD 1FMP      
 ED    TSX CLEAR,4   
       CLA DAVE      175.631463146
       LRS 35        SNEAKY
       FMP DAVE+1    -206.66
       REM           
       REM           
*CHECK ACC COLS S,Q,P,AND 35.
       REM           
       TSX ACB,4     ERR,ACC S,Q,P,AND 35
       HTR 8         SHOULD HAVE S. BITS
       TRA ED        IN ERR IN IND. REG
       REM           AS OCTAL NOS.
       REM           10#S,4#S,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34
       REM           
       TSX ACCF,4    ERR IN ACC 1 TO 34.
       OCT 203531463146 CORRECT ANS. IN MQ.
       TRA ED        
       REM           
       REM           
*CHECK MQ COLS S TO 35
       REM           
       TSX MQF,4     ERR IN MQ RESULT
       OCT -150040000000 CORRECT ANS IN MQ
       TRA ED        ORIG ANS IN ACC
       REM           
       REM           
       TSX OK,4      PROCEED OR
       TRA ED        REPEAT
       REM           
       REM           
*ALIGHT YOU GUYS,GET OVER AGAINST THAT WALL
       REM           
       REM           
       REM           
*FMP AND FDP AND FRN AND FAD.
       REM           
       BCD 1FDP      
 EDDY  TSX CLEAR,4   
       CLS DAVE+1    206.66
       LRS 35        
       FMP DAVE      175.631463146
       REM           ACC#203.531463146
       REM           MQ#150.04
       REM           
       FDP DAVE      175.631463146
       REM           MQ#206.65777777
       REM           ACC#150.571463146
       REM           
       XCA           QUOT. TO ACC
       FRN           ACC#206.66
       STQ SALON+5   SAVE REMAINDER
       FAD DAVE+1    -206.66
       TZE *+3       
       TSX ERROR-1,4 ACC SHOULD BE
       TRA EDDY      ZERO AFTER THE
       REM           ABOVE FAD INSTR.
       REM           
       REM           
*CHECK REMAINDER OF THE DIVISION.
       TSX ACCF,4    ERR IN REMAINDER
       OCT 150571463146  OF FDP, 7 INSTR ABOVE.
       TRA EDDY      CORRECT ANS. IN MQ
       REM           
       REM           
       TSX OK,4      PROCEED OR
       TRA EDDY      REPEAT
       REM           
       REM           
       REM           
*FDP ACC CHARACTERISTIC CARRY TO ZERO
       REM           
       BCD 1FDP      
 PHIL  TSX PART2,4   
       AXT PHILT,1   
       SXA SECT2,1   IN CASE OF TRAP
       CLA DAVE+2    033.404040404
       FDP DAVE+3    033.440404040
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       REM           
       TSX ACB,4     S,Q,P,AND 35 SHOULD#0
       HTR           BITS IN ERR,IN IND.
       TRA PHIL      REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34
       REM           
       TSX ACCF,4    ERR,ACC COLS 1 TO 34
       OCT 000423035700 CORRECT ANS. IN MQ
       TRA PHIL      ORIG. ANS. IN ACC
       REM           
*CHECK MQ COLS S TO 35
       REM           
       TSX MQF,4     ERR IN MQ RESULT
       OCT 200715412642 CORRECT ANS. IN MQ.
       TRA PHIL      ORIG ANS IN ACC.
       REM           
       TRA *+5       
 PHILT LXA 0,1       TRAP ADDRESS TO XRA
       TXI *+1,1,-1  XRA-1
       TSX ERROR-1,4 TRAP ERR,ADDRESS OF
       TRA PHIL      INSTR. WHICH CAUSED
       REM           TRAP IS IN XRA.
       REM           
       REM           
       TSX OK,4      PROCEED OR
       TRA PHIL      REPEAT.
       REM           
       REM           
       REM           
       REM           
*NORMALIZE FROM  MQ, NO EXCHANGE
       REM           
       BCD 1FAD      
 RAY   TSX PART2,4   CLEAR,LIGHT 4 ON.
       AXT RAYT,1    SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP.
       FSB COEF      -201.4
       FAD FERM+2    +263.0#-201.4
       CHS           ACC SHOULD NOW BE +.
       CAS COEF      CHECK
       TRA *+2       ERROR
       TRA RAYT+3    OK
       LDQ COEF      ACC ERROR,MQ HAS
       TSX ERROR-1,4 CORRECT ANS.,ORIG
       TRA RAY       ANS IN ACC,
       REM           SIGN INVERTED.
       TRA RAYT+3    IF ACC IS ZERO,INDICATES
       REM           NORMALIZE  FAILURE.
 RAYT  LXA 0,1       TRAP ADDRESS TO XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS OF
       TSX OK,4      INSTRUCTION THAT CAUSED
       TRA RAY       TRAP IN XRA.
       REM           
       REM           
       REM           
* NORMALIZE FROM  MQ, EXCHANGE
       REM           
       BCD 1FAD      
 RAYA  TSX PART2,4   CLEAR,LIGHT 40N.
       AXT RAYAT,1   SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP.
       CLS FERM+2    -263.0
       FAD COEF      +201.4#+201.4
       CAS COEF      CHECK
       TRA *+2       ERROR
       TRA RAYAT+3   OK
       LDQ COEF      
       TSX ERROR-1,4 ACC ERROR. CORRECTANS.
       TRA RAYA      IN MQ,ORIGANS. IN ACC,
       TRA RAYAT+3   IF ACC ZERO,INDICATES
       REM           NORMALIZE  FAILURE.
 RAYAT LXA 0,1       TRAP ADDRESS TO XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS OF
       TSX OK,4      INSTRUCTION THAT CAUSED
       TRA RAYA      TRAP IN XRA.
       REM           
       REM           
       REM           
       REM           
* NORMALIZE FROM  MQ, WITH DIFFERENT EXCHANGE SITUATIONS.
       REM           
       BCD 1FAD      
 RAYB  TSX PART2,4   CLEAR,LIGHT 4 ON.
       AXT RAYBT,1   SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP.
       REM           
       CLA FERM+2    +263.0
       FSB COEF      -201.4,EXCHANGE ACC
       REM           AND SR. ACC#-201.4
       FAD FERM+2    NO EXCHANGE,ACC#-201.4
       FAD COEF      ACC AND MQ SHOULD ZERO.
       FSB COEF      -201.4
       FAD FERM+2    NO EXCHANGE,ACC#-201.4
       REM           MQ#-146.0
*CHECK ACC COLS S,Q,P,AND 35.
       TSX ACB,4     SHOULD HAVE SIGN BIT.
       HTR 8         BITS IN ERROR IN IND.
       TRA RAYB      REG AS OCTAL NUMBERS
       REM           10#S,4#Q,2#P,1#35
       REM           
       REM           
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    ACC ERROR,CORRECT ANS.
       OCT 201400000000    IN MQ,ORIG ANS. IN
       REM           ACC.
       TRA RAYB      IF ACC ZERO,INDICATES
       REM           PROBABLE
       REM           NORMALIZE  FAILURE.
*CHECK MQ COLS S TO 35.
       TSX MQF,4     MQ ERROR,CORRECTANS
       OCT -146000000000   IN MQ,ORIG ANS IN ACC.
       TRA RAYB      
       TRA RAYBT+3   FINISHED.
       REM           
 RAYBT LXA 0,1       TRAP ADDRESS TO XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS OF
       TSX OK,4      INSTRUCTION THAT CAUSED
       TRA RAYB      TRAP IN XRA.
       REM           
       REM           
*9 OV OPERATION TEST WITH FAD,NO EXCHANGE.
       BCD 1FAD      
 RELA  TSX PART2,4   CLEAR,LIGHT 4 ON.
       AXT RELAT,1   SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP.
       PXD           MAKE SURE ACC CLEAR.
       FAD RTA       +233.00000001#201.4
       FAD RTA+1     +201.6#202.5
       FAD RTA+2     +202.6#203.54
       FAD RTA+3     +203.6#204.56
       FAD RTA+4     +204.6#205.57
       FAD RTA+5     +205.6#206.574
       FAD RTA+6     +206.6#207.576
       FAD RTA+7     +207.6#210.577
       FAD RTA+8     +210.6#211.5774
       FAD RTA+9     +211.6#212.5776
       FAD RTA+10    +212.6#213.5777
       FAD RTA+11    +213.6#214.57774
       FAD RTA+12    +214.6#215.57776
       FAD RTA+13    +215.6#216.57777
       FAD RTA+14    +216.6#217.577774
       FAD RTA+15    +217.6#220.577776
       FAD RTA+16    +220.6#221.577777
       FAD RTA+17    +221.6#222.5777774
       FAD RTA+18    +222.6#223.5777776
       FAD RTA+19    +223.6#224.5777777
       FAD RTA+20    +224.6#225.57777774
       FAD RTA+21    +225.6#226.57777776
       FAD RTA+22    +226.6#227.57777777
       FAD RTA+23    +227.6#230.577777774
       FAD RTA+24    +230.6#231.577777776
       FAD RTA+25    +231.6#232.577777777
       FAD RTA+26    +232.6#233.577777777
       REM           MQ#200.4
*CHECK ACC S,Q,P,AND 35.
       TSX ACB,4     ACC ERROR,COLS S,Q,P,AND 35
       HTR 1         SHOULD HAVE 35 ONLY.
       TRA RELA      BITS IN ERROR IN IND.
       REM           REG. AS OCTAL NUMBERS.
       REM           10#S,4#Q,2#P,1#35
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    ACC ERROR,COLS 1 TO 34.
       OCT 233577777776    CORRECT ANS. WILL BE
       REM           IN MQ,
       TRA RELA      ORIG. ANS. IN ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     MQ ERROR,COLS S,TO 35.
       OCT 200400000000    CORRECTANS WILL BE IN
       TRA RELA      MQ,ORIG ANS IN ACC.
       TRA RELAT+3   FINISHED.
 RELAT LXA 0,1       TRAP ADDRESS IN XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS OF
       REM           INSTRUCTION THAT CAUSED
       REM           TRAP IN XRA.
       TSX OK,4      PROCEED OR
       TRA RELA      REPEAT
       REM           
       REM           
       REM           
*NO 9 OV OPERATION WITH FMP.
       REM           
       BCD 1FMP      
 RELB  TSX PART2,4   CLEAR,LIGHT 4 ON.
       AXT RELBT,1   SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP.
 RELBC LDQ RTB       201.400000001
       FMP RTB       ACC 201.4000000002,
       REM           MQ 146.0000000002
       FMP RTB       ACC 146.0000000002,
       REM           MQ 113.0000000004
       FMP RTB       ACC 113.0000000004
       REM           MQ 060.0000000010
       FMP RTB       ACC 060.0000000010
       REM           MQ 025.0000000020
       FMP RTB+1     ACC 125.0000000020
       REM           MQ 072.0000000040
       FMP RTB       ACC 072.0000000040
       REM           MQ 037.0000000100
       FMP RTB+2     ACC 223.000000100
       REM           MQ 170.0000000200
       FMP RTB       ACC 170.0000000200
       REM           MQ 135.0000000400
       FMP RTB       ACC 135.0000000400
       REM           MQ 102.0000001000
       FMP RTB       ACC 102.0000001000
       REM           MQ 047.0000002000
       REM           
       REM           WHOLE LOT OF SHAKEN
       REM           GOING ON.
       REM           
       REM           
*COUNTING FROM RELBC TO THIS POINT,
*SHOULD TAKE 71 CYCLES.
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     ALL SHOULD BE ZERO
       HTR           BITS IN ERROR IN IND.
       TRA RELB      REG. AS OCTAL NUMBERS.
       REM           10#S,4#Q,2#P,1#35
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 102000001000 ERR IN ACC 1 TO 34
       REM           CORRECT
       TRA RELB      ANS. IN MQ,ORIG ANS. IN
       REM           ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 047000002000 MQ ERR. CORRECT ANS.
       REM           IN
       TRA RELB      MQ,ORIG ANS. IN ACC.
       TRA RELBT+3   FINISHED.
       REM           
 RELBT LXA 0,1       TRAP ADDRESS TO XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS
       REM           OF INSTRUCTION THAT
       REM           CAUSED TRAP IN XRA.
       TSX OK,4      PROCEED OR
       TRA RELB      REPEAT.
       REM           
       REM           
       REM           
*9 OV OPERATION WITH FMP.
       REM           
       BCD 1FMP      
 RELC  TSX PART2,4   CLEAR,LIGHT 4 ON.
       AXT RELCT,1   SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP
       LDQ RTC+2     177.600000003
       FMP RTC+1     ACC 376.440000004
       REM           MQ 343.4000000011
       FMP RTC       ACC 376.600000020
       REM           MQ 343.400000066
       FMP RTC       ACC 376.600000124
       REM           MQ 343.000000504
       FMP RTC       ACC 376.000000746
       REM           MQ 343.000003630
       FMP RTC       ACC 376.0000005544
       REM           MQ 343.000026620
       FMP RTC       ACC 376.0000022130
       REM           MQ 343.000210540
       FMP RTC       ACC 376.000315020
       REM           MQ 343.001464100
       FMP RTC       ACC 376.002316140
       REM           MQ 343.011470600
       FMP RTC       ACC 376.016325100
       REM           MQ 343.071524400
       FMP RTC       ACC 376.126376600
       REM           MQ 343.531773000
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     SHOULD ALL BE ZERO.
       HTR           ERR IN ACC S,Q,P, AND 35.
       REM           BITS IN
       TRA RELC      ERR. IN IND. REG. AS OCTAL
       REM           NOS. 10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    ACC ERROR,COLS 1 TO 34.
       OCT 376126376600 CORRECT ANS. WILL BE
       TRA RELC      IN Q,ORIG. ANS. IN ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     MQ ERROR.
       OCT 343531773000 CORRECT ANS. WILL BE
       TRA RELC      IN MQ,ORIG ANS IN ACC.
       REM           
       TRA RELCT+3   FINISHED.
       REM           
       REM           
 RELCT LXA 0,1       TRAP ADDRESS
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS
       REM           OF INSTRUCTION WHICH
       REM           CAUSED TRAP IN XRA
       TSX OK,4      PROCEED OR
       TRA RELC      REPEAT.
       REM           
       REM           
       REM           
*9 OV OPERATION WITH FRN.
       REM           
       BCD 1FRN      
 RELD  TSX CLEAR,4   CLEAR
       CLA FERM+3    200.77777777
       LDQ COEF      201.4
       FRN           ACC#MQ#201.4
       REM           SHOULD NOT TRAP.
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     ERR IN ACC S,Q,P, AND 35.
       REM           SHOULD
       HTR           ALL BE ZERO. BITS IN ERR IN
       TRA RELD      IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    ACC ERROR,COLS 1 TO 34.
       OCT 201400000000    CORRECT ANS IN MQ.
       TRA RELD      ORIG. ANS. IN ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     MQ ERROR.
       OCT 201400000000     CORRECT ANS,PUT IN MQ
       TRA RELD      ORIG. ANS. IN ACC.
       REM           
       TSX OK,4      PROCEED OR
       TRA RELD      REPEAT
       REM           
       REM           
       REM           
*9 OV OPERATION WITH FRN AFTER FDP,FMP, AND FAD.
       REM           
       BCD 1FRN      
 RELE  TSX PART2,4   CLEAR,LIGHT 4 ON.
       AXT RELET,1   SET RETURN ADDRESS
       SXA SECT2,1   INCASE OF TRAP.
       CLA FERM+3    200.777777777
       FDP FERM+3    MQ#201.4
       FMP FERM+4    ACC#177.7777777
       FAD FERM+5    ACC#200.7777777
       REM           MQ#145.4
       FRN           ACC#201.4
       FSB COEF      ACC AND MQ NOW ZERO.
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     ERR IN ACC S,Q,P, AND 35.
       REM           SHOULD
       HTR           ALL BE ZERO. BITS IN ERR.
       REM           IN
       TRA RELE      IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    ACC ERR. COLS 1 TO 34.
       HTR           CORRECT ANS. IN MQ,
       TRA RELE      ORIG ANS IN ACC.
       REM
*CHECK MQ COLS S TO 35.
       TSX MQF,4     MQ ERROR.
       HTR           CORRECT ANS IN MQ,
       TRA RELE      ORIG ANS IN ACC.
       TRA RELET+3   
       REM           
 RELET LXA 0,1       TRAP ADDRESS IN XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS OF
       TSX OK,4      INSTRUCTION THAT CAUSED
       TRA RELE      TRAP IN XRA.
       REM           
       REM           
       REM           
*FLOATING-TO-FIXED, FIXED-TO-FLOATING INTEGER
*TRANSLATION, AUTOMATIC MODE.
       BCD 1UFA      
 FXFLA TSX PART2,4   CLEAR,LITE 4 ON.
       AXT FXAT,1    SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP.
       CLA A         L202.4#2
       UFA K40+2     L233.0
       ANA KK        FIXED POINT 2 NOW IN ACC.
       REM           
       CAS FERM      CHECK.
       TXI *+2       ERROR IN FIXING.
       TRA *+6       OK
       STQ Q         SAVE MQ.
       LDQ FERM      CORRECT ANS IN MQ.
       TSX ERROR-1,4 ACC WRONG,MQ RIGHT.
       TRA FXFLA     
       LDQ Q         RESTORE MQ
       XCA           CHECK MQ FACTOR
       CAS K34+2     L200.0
       TXI *+2       ERROR
       TRA *+4       OK
       LDQ K34+2     CORRECT ANS IN MQ
       TSX ERROR-1,4 ERROR IN MQ FACTOR,
       TRA FXFLA     CORRECT ANS IN MQ,
       REM           ORIG ANS. IN ACC
       REM           
*TRY TO FLOAT A 2 AND RECOVER ORIG. NUMBER.
       CLA FERM      L2
       ORA K40+2     L233.0
       FAD K40+2     L233.0
       CAS A         CHECK,SHOULD#202.4
       TXI *+2       ERROR
       TRA *+6       OK
       REM           
       STQ Q         SAVE MQ.
       LDQ A         
       TSX ERROR-1,4 ERROR IN FLOATING A 2
       TRA FXFLA     CORRECT ANS IN MQ,
       REM           ORIG ANS IN ACC
       LDQ Q         RESTORE MQ.
       XCA           CHECK MQ FACTOR
       CAS FERM+1    L147.0
       TXI *+2       WRONG
       TRA *+8       OK
       REM           
       LDQ FERM+1    L147.0
       TSX ERROR-1,4 MQ ERROR,CORRECT
       TRA FXFLA     ANS IN MQ,ORIG ANS
       TRA FXAT+3    IN ACC.
       REM           
 FXAT  LXA 0,1       TRAP ADDRESS TO XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS
       REM           OF INSTRUCTION
       REM           WHICH CAUSED TRAP
       REM           IS IN XRA.
       TSX OK,4      PROCEED OR
       TRA FXFLA     REPEAT
       REM           
       REM           
       REM           
*FLOATING-TO-FIXED,FIXED-TO-FLOATING INTEGER TRANSLATION,
*MANUAL MODE. THE VALUE IN THE KEYS WILL BE ENTERED IF,
*S IS DOWN,AND THE NUMBER IS A FLOATING-POINT INTEGER
*WITH CHARACTERISTIC GREATER THEN 200 AND LESS
*THAN 233 OCTAL. S IS NOT ENTERED.
       REM           
       BCD 1UFA      
 FXFLM TSX PART2,4   CLEAR,LIGHT 4 ON.
       AXT FXMT,1    SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP.
       TSX ENK,4     CHECK FOR MANUAL
       REM           ENTERY.
       TRA FXMT+3    NO MANUAL ENTERY.
       REM           
       CLA SALON     MANUAL ENTERY IN SALON.
       UFA K40+2     L233.0
       ANA KK        FIXED NO. NOW IN ACC.
       REM           TRY TO RECOVER ORIG
       REM           NUMBER AND CHECK.
       ORA K40+2     L233.0
       FAD K40+2     FLOAT.
       CAS SALON     CHECK.
       TXI *+2       ERROR
       TRA FXMT+3    OK
       REM           
       LDQ SALON     CORRECT TO MQ
       TSX ERROR-1,4 TRANSLATION ERROR.
       TRA FXFLM     CORRECT ANS IN MQ,
       TRA FXMT+3    ERROR IN ACC.
       REM           
 FXMT  LXA 0,1       TRAP ADDRESS TO XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS
       REM           OF INSTRUCTION WHICH
       REM           CAUSED TRAP IN XRA.
       TSX OK,4      PROCEED OR
       TRA FXFLM     REPEAT.
       REM           
       REM           
       REM           
*SOLUT ION OF, A EQUALS R+LQB+QB, WHERE
*Q#A/B, AND R# REMAINDER
*LQB IS THE LOW ORDER PART OF THE F.P. PRODUCT QB.
*THE LOW ORDER PART OF THE SUM HAS A ZERO FRACTION.
       REM           
       REM           
       BCD 1FPOPS    AT1
 AT1   TSX PART2,4   CLEAR,LITE 4 ON
       NOP AT1A      
       LXA *-1,1     SET RETURN ADDRESS
       SXA SECT2,1        IN CASE OF TRAP
       NOP           
       AXT 10,1           LOAD XRA WITH OCTAL 12
       REM           
*LOOP NOW INITIALIZED, FIRST SOLVE FOR Q, THEN FOR A.
       REM           
       CLA A+10,1    
       FDP B+10,1          Q IN MQ, R IN ACC
       DCT           
       TRA AT1A+5          SHOULD HAVE DIVIDED
       STO FREE            SAVE R
       FMP B+10,1    QB
       STO SALON+5         SAVE QB
       PXD                CLEAR ACC
       LLS 35             LQB TO ACC
       FAD FREE           +R
       FAD SALON+5        +QB
       SUB A+10,1         CHECK CACLULATIONS
       TNZ AT1A+8         ACC SHOULD BE ZERO
       RQL 9         
       LGL 27               FMQ TO ACC
       TNZ AT1A+11       ACC SHOULD BE ZERO.
       TIX AT1+6,1,1 NEXT FACTOS.
       TRA AT1A+14       FINISHED
       REM           
*ERROR CHECK ROUTINES FOLLOW, PROGRAM TAKES 10 PASSES,
*PASS ON WHICH ERROR OCCURED, IN OCTAL, INFERRED AS
*FOLLOWS, P#12-XRA+1. DIFFERENT FACTOS ON EACH PASS.
       REM           
       REM           
 AT1A  LXA 0,2            TRAP IN ERROR,
       TXI *+1,2,-1  TRAP ADD. IN XRB.
       TSX ERROR-1,4 PASS ON WHICH TRAP OCCURED,
       TRA AT1            IN OCTAL, P#12-XRA+1.
       TRA AT1+22         GO ON TO NEXT PASS
       REM           
       TSX ERROR-1,4      DCT ON, SHOULD HAVE DIVI
       TRA AT1       AT AT1+7
       TRA AT1+22         GO ON TO NEXT PASS
       TSX ERROR-1,4      CALCULATION IN ERROR, AC
       TRA AT1       WAS NOT ZERO AT AT1+18.
       TRA AT1+22         GO ON TO NEXT PASS
       TSX ERROR-1,4      FMQ WAS NOT ZERO.
       TRA AT1       AT AT1+21
       TRA AT1+22         GO ON TO NEXT PASS
       TSX OK,4           FINISHED, PROCEED OR
       TRA AT1            REPEAT.
       REM           
       REM           
       REM           
*SQUARE ROOT,SHOULD NOT TRAP. USES FAD AND FDP
       REM           
       BCD 1FDPFAD   
 AT2   TSX PART2,4   TURN OFF TRIG,CLEAR
       NOP           LIGHT 4 ON.
       AXT *+12,1    SET RETURN ADDRESS
       SXA SECT2,1      IN CASE OF TRAP
       CLA B+2       16 DECIMAL#205.4
       TSX SQRT,4    
       TTR *+5       
       SUB SALON+14  4 DECIMAL EQUALS 203.4
       TZE *+9       
       ADD SALON+14       ERROR, REPLACE ACC
       LDQ SALON+14       CORRECT ANS. IN MQ
       TSX ERROR-1,4      SQUARE ROOT ERROR
       TRA AT2       
       TRA *+4       GO ON
       REM           
       LXA 0,1       TRAP ADDRESS TO XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR. ADDRESS OF
       REM           INST. THAT CASUED TRAP
       REM           IS IN XRA
       REM           
       TSX OK,4           PROCEED OR
       TRA AT2            REPEAT
       REM           
       REM           
       REM           
*THE QUADRATIC FORMULA, 3 PASSES, 2 ANSWERS EACH PASS.
*IN CASE AN ERROR IS DECTECTED, THE CORRECT ANS. WILL
*BE PL ACE D IN MQ, ORIGINAL ANS. REMAINS IN AC.
       REM           
       BCD 1FPOPS    
 AT3   TSX PART2,4   LIGHT 4 ON, CLEAR
       CAL AT3+23         SET RETURN ADDRESS
       STA SECT2          IN CASE OF TRAP
       LXD AT3+13,1       21 TO XRA
       LDQ COEF,1         A
       FMP COEF+2,1       AXC
       ACL SALON+15       X4
       STO FREE           4AC
       LDQ COEF+1,1       B
       FMP COEF+1,1       B SQUARED
       FSB FREE           -4AC
       CAS COEF+3,1       CHECK RADICAN
       TXI *+2       ERROR
       TXI *+5,0,21  OK
       LDQ COEF+3,1       CORRECT ANS IN MQ
       TSX ERROR-1,4 ERR. IN B SQRD-4AC
       TRA AT3            REPEAT
       CLA COEF+3,1       GO ON WITH CORRECT
       REM                RADICAN
       REM                R#SQUARE ROOT OF
       TSX SQRT,4         B SQUARE ROOT OF
       TTR *+5       ERROR IN RADICAN
       CAS COEF+4,1       CHECK SQUARE ROOT
       TTR *+2       ERROR
       TXI *+6       OK
       NOP AT3A      
       LDQ COEF+4,1       CORRECT ANS. IN MQ
       TSX ERROR-1,4      ERROR IN SQUARE ROOT
       TRA AT3            REPEAT
       CLA COEF+4,1       GO ON WITH CORRECT R
       REM                
       DCT                TURN OFF DC TRIG
       NOP                
       STO FREE           
       LDQ COEF,1         A#201.4
       FMP SALON+11       2A#202.4
       STO FREE+1         
       CLS COEF+1,1       -B
       FAD FREE           -B+R
       FDP FREE+1         -B+R/2A
       DCT                SHOULD DIVIDE
       TTR *+2       ERROR
       TXI *+4       OK
       LDQ COEF+5,1       CORRECT QUOTIENT
       TSX ERROR-1,4      DCT ERROR ON FDP
       TRA AT3            REPEAT
       REM           
       XCA           
       CAS COEF+5,1       CHECK FIRST ANS.
       TTR *+2       ERROR
       TXI *+4       OK
       LDQ COEF+5,1       CORRECT ANS. IN MQ
       TSX ERROR-1,4      FIRST ANS. WRONG
       TRA AT3            REPEAT
       REM           
       CLS COEF+1,1       -B
       FSB FREE           -B-R
       FDP FREE+1         -B-R/2A
       DCT                SHOULD DIVIDE
       TTR *+2       ERROR
       TXI *+4       OK
       LDQ COEF+6,1       CORRECT QUOTIENT
       TSX ERROR-1,4      DCT ERROR ON FDP
       TRA AT3            REPEAT
       REM                
       XCA                
       CAS COEF+6,1       CHECK SECOND ANS
       TTR *+2       ERROR
       TXI *+4       
       LDQ COEF+6,1       CORRECT ANS IN MQ
       TSX ERROR-1,4      SECOND ANS WRONG
       TRA AT3            REPEAT
       REM                
       TIX AT3+4,1,7      NEXT PASS
       TRA *+6       FINISHED
       REM           
 AT3A  LXA 0,2       TRAP ADDRESS IN XRB.
       TXI *+1,2,-1  XRB-1.
       TSX ERROR-1,4 TRAP ERROR,ADDRESS OF
       TRA AT3       INST. THAT CAUSED TRAP
       TRA *-6       IS IN XRB.
       REM           
       TSX OK,4      PROCEED OR
       TRA AT3       REPEAT.
       REM           
       REM           
*THEOREM OF FERMAT. GIVEN A PRIME NUMBER P,
*FIND SMALLEST PRIME A LESS THAN P,NOT COUNTING
*ONE,SUCH THAT THE P-1 POWER OF A IS THE
*FIRST POWER OF A TO YEILD UNITY MODULO P.
*A IS CALLED THE PRIMITIVE ROOT OF P.
       REM           
       BCD 1FPOPS    
 AT4A  TSX PART2,4   CLEAR,LIGHT 4 ON
       SLN 1         ONE ON TO SIGNAL
       REM           PRIMITIVE ROOT PROG. ON.
       AXT 8,1       4 PASSES
       AXT AT4AT,2   SET RETURN ADDRESS
       SXA SECT2,2   IN CASE OF TRAP.
       CLA FERM,1    PRIME TO ACC.
       TSX PRIRT,4   GET PRIMITIVE ROOT.
       TXI RATS      ERROR,PRIMES SHOULD
       REM           BE WITHIN RANGE.
       TXI RATS+4    ERROR,THESE VALUES
       REM           ARE PRIMES.
       TXI MACH      ERROR,DIVIDEND SHOULD BE 
       REM           GREATER THAN QUOT. TIMES
       REM           DIV.
       STQ FREE+5    SUCCESFUL RETURN HERE.
       CAS FERM+1,1  CHECK ROOT.
       TXI *+2       ERROR.
       TRA *+4       OK
       REM           
       LDQ FERM+1,1  CORRECT ROOT IN MQ.
       TSX ERROR-1,4 WRONG ROOT IN ACC.
       TRA AT4A      
*ON ERROR,PRIME USED IN SALON,VALUES
*ARE STORED STARTING AT PRIMS UP TO PRIMS+8
*IN THIS ORDER,PRIME,ITS ROOT,PRIME,ITS ROOT, ETC.
       REM           
*THE PRIME NUMBERS USED ANS THE RESPECTIVE
*ROOTS THAT SHOULD BE CALCULATED ARE GIVEN
*BELOW IN THE ORDER OF THEIR APPEARENCE...
       REM           
*         PRIME    ROOT      XRA WILL
*                            HAVE *
       REM           
*         OCTAL    OCTAL     OCTAL
       REM           
*         202.6    202.4       10
       REM           
*         203.7    202.6        6
       REM           
*         207.604  203.5        4
       REM           
*         212.7624 203.7        2
       REM           
*        DECIMAL  DECIMAL      OCTAL
       REM           
*           3        2         10
       REM           
*           7        3          6
       REM           
*          97        5          4
       REM           
*         997        7          2
       REM           
*                            *. EXCEPT AT MACH
*                            OR FOR TRAP ERROR.
       REM           
       REM           
       REM           
       CLA FREE+5    CHECK MQ FACTOR.
       FAD COEF      MQ FACTOR +1 SHOULD
       CAS FERM,1    BE # ORIG. PRIME.
       TXI *+2       ERROR.
       TRA AT4AR     OK.
       CLA FERM,1    ORIG. PRIME
       FSB COEF      -1
       XCA           CORRECT ANS TO MQ
       CLA FREE+5    RESTORE ACC.
       TSX ERROR-1,4 ERROR IN MQ FACTOR,
       TRA AT4A      CORRECT ANS IN MQ,ORIG.
       REM           ANS IN ACC.
       TRA AT4AR     
       REM
       REM
 RATS  LDQ FERM+1,1  CORRECT ROOT IN MQ.
       TSX ERROR-1,4 ERROR,ALL THESE PRIMES
       TRA AT4A      ARE WITHIN RANGE,ACC
       REM           HAS PRIME,MQ THE ROOT.
       TRA AT4AR     
       LDQ FERM+1,1  CORRECT ROOT IN MQ.
       TSX ERROR-1,4 ERROR,ALL THESE NOS.
       TRA AT4A      ARE PRIME NOS. AND
       REM           SHOULD NEVER YEILD
       REM           ZERO AT PRIRT+29.
       TRA AT4AR     
       REM           
 MACH  TSX ERROR-1,4 MACHINE ERROR
*THE MACHINE SAYS THAT,ON DIVISION WITH REMAINDER,THE DIVIDEND DOES NOT
*EXCEED THE PRODUCT OF THE INTEGRAL PART OF THE QUOTIENT X DIVISOR
*BY ONE OR MORE. THIS SITUATION IS NOT POSSIBLE
*WITH POSITIVE NOS. OCCURED AT PRIRT+30,OR PRIRT+33.
*WITH PRIME NOS,THIS PRODUCT IS ALWAYS AT LEAST
*ONE LESS THAN THE DIVIDEN OR IS EXACTLY EQUAL TO
*THE DIVIDEND. IN THIS CALCULATIONS,HOWEVER,WE SHOULD
*NEVER HAVE AN EQUALS CONDITION,THSI HAS BEEN
*PROVIDED FOR AT RATS+4. SEE ALSO MACHE.
       TRA AT4A      
       REM           
       LXA PRIRT+46,1    RESTORE XRA
       TRA AT4AR     NEXT PASS
       REM           
 AT4AT LXA 0,2       TRAP ADDRESS IN XRB
       TXI *+1,2,-1  XRB-1
       TSX ERROR-1,4 TRAPERROR,ADDRESS OF
       REM           INSTRUCTION THAT
       TRA AT4A      CAUSED TRAP IN XRB.
       REM           
       LXA PRIRT+46,1    RESTORE XRA.
 AT4AR TIX AT4A+5,1,2 NEXT PASS
       TSX OK,4      FINISHED
       TRA AT4A      REPEAT OR PROCEED
       REM           
       REM           
       REM           
       REM           
*END PART OF 9M05, GO ON TO PART 3.
       REM           
       REM           
       REM           
       REM           
       REM           
*PART 3 OF 9M05, FLOATING POINT WITH INDIRECTION ADDRESSING.
*PART 3 DUPLICATES PART 2 WITH THE ADDITION OF INDIRECT ADDRESSING.
*THERE ARE 2 SECTIONS OF PART 3, THEY ARE
*SECTION 1, TESTING F. P. TRAP AND THE INDICATOR BITS AT ZERO, AND
*SECTION 2, FLOATING POINT RELIABILITY WITH INDIRECT ADDRESSING.
       REM
       REM
*CURSORY CHECK.      
*F.P. OPNS. WITH INDIRECT ADDRESSING.
       REM           
       BCD 1FAD      
 IND   TSX CLEAR,4   CLEAR.
       SLN 3         LITE 3 ON TO SIGNAL
       REM           IND. ADD. TEST.
       CLA COEF      201.4
       FAD* *-1      #202.4
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     S,Q,P, AND 35 SHOULD#0.
       HTR           BITS IN ERROR IN
       TRA IND       IND REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    ACC ERROR,COLS 1 TO 34.
       OCT 202400000000     CORRECT ANS. WILL BE
       TRA IND       IN MQ,ORIG ANS IN ACC.
       REM           
*CHECK MQ  COLS S TO 35.
       TSX MQF,4     MQ ERROR.
       OCT 147000000000     CORRECT ANS. WILL BE
       TRA IND       IN MQ,ORIG ANS IN ACC.
       TSX OK,4      PROCEED OR
       TRA IND       REPEAT
       REM           
       REM           
       REM           
*FMP WITH INDIRECT ADDRESSING.
       REM           
       BCD 1FMP      
 INDA  TSX CLEAR,4   CLEAR.
       SLN 3         SIGNAL IND. ADD. TEST.
       LDQ SALON+14  203.4
       FMP* *-1      #205.4
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     S,Q,P, AND 35 SHOULD BE 0.
       HTR           BITS IN ERROR IN IND. REG.
       TRA INDA      10#S,4#Q,2#P,1#35,OCTAL.
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    ERR IN ACC 1 TO 34.
       OCT 205400000000    CORRECT ANS. IN MQ,
       TRA INDA      ORIG. ANS. IN ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     ERR. IN MQ RESULT.
       OCT 152000000000    CORRECT ANS IN MQ,
       TRA INDA      ORIG, ANS. IN ACC.
       TSX OK,4      PROCEED OR
       TRA INDA      REPEAT.
       REM           
       REM           
       REM           
*FDP WITH INDIRECT ADDRESSING.
       REM           
       BCD 1FDP      
 INDB  TSX CLEAR,4   CLEAR.
       SLN 3         SIGNAL IND. ADD. TEST.
       CLA B+2       205.4
       FDP* INDA+2   BY 203.4#203.4
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     S,Q,P, AND 35 SHOULD BE 0.
       HTR           BITS IN ERROR IN IND. REG.
       TRA INDB      10#S,4#Q,2#P,1#35, OCTAL.
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    ERR. IN ACC 1 TO 34.
       OCT 153000000000 CORRECT ANS. IN MQ
       TRA INDB      ORIG. ANS. IN ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     ERR. IN MQ.
       OCT 203400000000    CORRECT ANS. IN MQ,
       TRA INDB      ORIG. ANS. IN ACC.
       TSX OK,4      PROCEED OR
       TRA INDB      REPEAT
       REM           
       REM           
       REM           
*REPEAT IT1 THROUGH IT10 CHECKING INDICATOR BITS
*IN DECREMENT OF ZERO,BITS 14,15,16, AND 17,
*FOR FLOATING POINT TRAP,WITH INDIRECT ADDRESING.
       REM           
*UFA WITH OVERFLOW,BITS 15 AND 16,INDIRECT ADDRESSING.
       REM           
       BCD 1UFA-     
 IDIA  TSX PART3,4   CLEAR,LITES 3 AND 4 ON.
       AXT IDIAT,1   
       SXA SECT2,1   SET RETURN ADDRESS
       CLA* IT1+3    +377.77777777
       UFA* IT1+3    SHOULD OVER FLOW
       TSX ERROR-1,4 FAILED TO TRAP
       TRA IDIA      
       TRA *+5       CANT TEST TRIGGERS
       REM           
*CHECK OVERFLOW TRIGS.
 IDIAT TSX OONLY,4   ACC OV ON
       TRA IDIA      
       TRA *+2       DIVIDE CHECK ON
       TRA IDIA      
       REM           
*CHECK ACC BITS S,P,Q,AND 35.BITS IN ERROR PUT
*IN INDICATOR REG. AS OCATL NUMBERS AS FOLLOWS,
*10#S, 4#Q, 2#P, 1#35.
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     SHOULD HAVE P AND 35
       HTR 2+1       BITS IN ERROR IN IND REG
       TRA IDIA      INDICATOR REG.
       REM           
*CHECK ACC COLS 1 TO 34
       REM           
       TSX ACCF,4    ERR ACC COLS 1 TO 34
       OCT 000777777776    CORRECT ANS WILL BE
       TRA IDIA      IN MQ, ORIG ANS IN ACC
       REM           
*CHECK MQ COLS S TO 35.
       REM           
       TSX MQF,4     
       OCT 345000000000    MQ ERROR,CORRECT ANS.
       REM           IN
       TRA IDIA      MQ,ORIG ANS IN ACC.
       REM           
*CHECK ADDRESS AT ZERO.
       REM           
       TSX ZERO,4    
       HTR IDIA+5    ERROR IN TRAP ADDRESS,
       TRA IDIA      CORRECT ADDRESS IN MQ,ORIG
       REM           ADDRESS IN AC.
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO
       REM           SHOULD HAVE BITS 15,16.
       TSX BITS,4    CHECK BITS IT1
       HTR 0,0,6     CORRECT BITS PUT IN
       TSX ERROR,4   MQ, ORIG BITS IN ACC
       TSX OK,4      PROCEED OR
       TRA IDIA      REPEAT.
       REM           
       REM           
*TRAP RELIABILITY,UFA,BITS 15 AND 16,50 PASSES
*WITH INDIRECT ADDRESSING
       REM           
       BCD 1UFA-     
 IDIB  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       AXT IDIBT,1  
       SXA SECT2,1   SET RETURN ADDRESS
       AXT 52,1      REPEAT 50 TIMES
       TNX *+6,1,1   
       CLA* IT2+5    377.77777777
       UFA* IT2+5    FORCE OVERFLOW.
       TSX ERROR-1,4 FAILED TO TRAP
       TRA IDIB      
       TRA *+5       CANT TEST TRIGS.
       REM           
*CHECK OVERFLOW TRIGGERS.
 IDIBT TSX OONLY,4   ACC OV. ON
       TRA IDIB      
       TRA *+2       DIVIDE CHECK ON
       TRA IDIB      
       REM           
*CHECK ACC COLS S,Q,P, AND 35
       TSX ACB,4     
       HTR 2+1       SHOULD HAVE P AND 35,BITS
       TRA IDIB      IN ERROR IN IND. REG.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34
       REM
       TSX ACCF,4    
       OCT 000777777776    ERR ACC 1 TO 34.
       REM           CORRECT
       TRA IDIB      ANS IN MQ,ORIG. ANS IN ACC.
       REM           
*CHECK MQ S TO 35.   
       TSX MQF,4     
       OCT 345000000000    ERR IN MQ,CORRECT ANS
       TRA IDIB      IN MQ,ORIG ANS IN ACC.
       REM           
*CHECK ADDRESS AT ZERO
       TSX ZERO,4    
       HTR IDIB+7    ERR IN TRAP ADDRESS,CORRECT
       TRA IDIB      ADDRESS IN MQ,ADDRESS
       REM           WRITTEN IN ACC.
*CHECK INDICATOR BITS IN DECREMENT OF ZERO.
       TSX BITS,4    CHECK BITS IDIB
       HTR 0,0,6     CORRECT BITS IN MQ
       TSX ERROR,4   ORIG BITS IN ACC
       TSX OK,4      PROCEED OR
       TRA IDIB      REPEAT.
       REM           
       REM           
       REM           
*FLOATING POINT UNDER FLOW, BIT 17,INDIRECT ADDRESSING.
       REM           
       BCD 1UFA-     
 IDIC  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       AXT IDICT,1   
       SXA SECT2,1   SET RETURN ADDRESS
       CLA* IT3+3    +007.1
       UFA* IT3+3    UNDERFLOW
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA IDIC      REPEAT
       TRA *+5       CANT TEST TRIGGERS
       REM           
*CHECK OVERFLOW TRIGGERS.
 IDICT TSX UONLY,4   ACC OV. ON
       TRA IDIC      
       TRA *+2       DIVIDE CHECK ON
       TRA IDIC      
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 0         S,Q,P, AND 35 SHOULD BE
       REM           ZERO.
       TRA IDIC      BITS IN ERR IN IND. REG.
       REM           10#S,4#Q,2#P,1#35,OCTAL
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 007200000000   ERR IN ACC 1 TO 34,
       REM           CORRECT
       TRA IDIC      ANS. IN MQ,ORIG ANS. IN ACC
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 354000000000  ERR IN MQ,CORRECT ANS
       TRA IDIC      IN MQ,ORIG ANS IN ACC.
       REM           
*CHECK TRAP ADDRESS AT ZERO
       TSX ZERO,4    
       HTR IDIC+5    ERR IN TRAP ADDRESS,
       TRA IDIC      CORRECT ADD. IN MQ,ADDRESS
       REM           WRITTEN IN ACC.
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO
       TSX BITS,4    CHECK BITS IDIC
       HTR 0,0,1     CORRECT BITS IN MQ
       TSX ERROR,4   ORIG BITS IN ACC
       TSX OK,4      PROCEED OR
       TRA IDIC      REPEAT.
       REM           
       REM           
       REM           
*FAD UNDERFLOW,SIGNS ALIKE,NO EXHCANGE,NO 9 CARRY,
*BITS 16 AND 17. INDIRECT ADDRESSING.
       REM           
       BCD 1FAD-     
 IDID  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       AXT IDIDT,1   
       SXA SECT2,1   SET RETURN ADDRESS
       CLA* IT4+4    1.007777777
       FAD* IT4+5    4.004444444,UNDERFLOW
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA IDID      
       TRA *+5       CANT TEST TRIGGERS
       REM           
*CHECK OVERFLOW TRIGGER.
 IDIDT TSX UONLY,4   ACC OV. ON
       TRA IDID      
       TRA *+2       DIVIDE CHECK ON
       TRA IDID      
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 2+4       ERR. S,Q,P AND 35 SHOULD
       REM           HAVE
       TRA IDID      P AND Q. BITS IN ERR IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 376544444370 ERR IN ACC 1 TO 34,
       REM           CORRECT
       TRA IDID      ANS. IN MQ,ORIG. ANS. IN
       REM           ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 343000000000 CORRECT ANS.
       TRA IDID      IN MQ,ORIG ANS IN ACC.
       REM           
*CHECK TRAP ADDRESS AT ZERO.
       TSX ZERO,4    
       HTR IDID+5    ERR. IN TRAP ADDRESS.
       TRA IDID      CORRECT ADD. IN MQ,
       REM           ADDRESS WRITTEN IN ACC.
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO
       TSX BITS,4    CHECK BITS IDID
       HTR 0,0,3     SHOULD HAVE BITS 16 AND 17
       TSX ERROR,4   CORRECT BITS IN MQ,
       TSX OK,4      ORIG BITS IN ACC
       TRA IDID      PROCEED OR REPEAT
       REM           
       REM           
       REM           
*SIGNS UNLIKE,NO EXCHANGE,9 CARRY,BITS 16 AND 17
*INDIRECT ADDRESSING 
       REM           
       BCD 1FSB-     SAME AS FAD EXCEPT SR SIGN
 IDIE  TSX PART3,4   LITE 3 AND 4 ON,CLEAR.
       AXT IDIET,1   
       SXA SECT2,1   SET RETURN ADDRESS
       CLA* IT5+4    1.007777777
       FSB* IT5+5    4.004444444 UNDERFLOW.
       REM           MQ AND ACC EXCHANGE ON
       REM           STEP 3 TO COMP. MQ.
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA IDIE      
       TRA *+5       CANT TEST TRIGGERS
       REM           
*CHECK OVERFLOW TRIGGERS.
 IDIET TSX UONLY,4   ACC OV. ON
       TRA IDIE      
       TRA *+2       DIVIDE CHECK ON
       TRA IDIE      
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     
       HTR 2+4+8     ERR IN S,Q,P, AND 35,BITS
       REM           IN
       TRA IDIE      ERR IN IND. REG. IN OCTAL.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 375711111020 ERR IN ACC 1 TO 34,
       TRA IDIE      CORRECT ANS. IN MQ, ORIG.
       REM           ANS. IN ACC.
       REM           
*CHECK TRAP ADDRESS AT ZERO.
       TSX ZERO,4    
       HTR IDIE+5    ERR IN TRAP ADDRESS,CORRECT
       TRA IDIE      ADDRESS IN MQ,ADDRESS
       REM           WRITTEN IN ACC.
       REM           
*CHECK UNDICATOR BITS IN DECREMENT OF ZERO.
       TSX BITS,4    CHECK BITS IDIE
       HTR 0,0,3     SHOULD HAVE 16 AND 17,
       REM           CORRECT
       TSX ERROR,4   BITS IN MQ,ORIG BITS IN ACC
       TSX OK,4      PROCEED OR
       TRA IDIE      REPEAT
       REM           
       REM           
       REM           
*UFM WITH OVERFLOW,BITS 15,16,17.26 ZEROS IN
*MULTIPLYER. INDIRECT ADDRESSING.
       REM           
       BCD 1UFM-     
 IDIF  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       AXT *+7,1     
       SXA SECT2,1   SET RETURN ADDRESS
       LDQ* IT6+4    377.4
       UFM* IT6+5    BY 277.4,OVERFLOW.
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA IDIF      
       TRA *+5       CANT TEST TRIGGERS
       REM           
*CHECK OVERFLOW TRIGGERS.
       TSX OONLY,4   ACC OV ON.
       TRA IDIF      
       TRA *+2       DIVIDE CHECK ON
       TRA IDIF      
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 2         ERR. ACC S,Q,P, AND 35.
       REM           SHOULD 
       TRA IDIF      HAVE P. BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 076200000000    ERR IN ACC COLS 1 TO
       REM           34.
       TRA IDIF      CORRECT ANS IN MQ,ORIG.
       REM           ANS IN ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 043000000000 MQ ERR,CORRECT ANS IN
       TRA IDIF      MQ,ORIG ANS IN ACC
       REM           
*CHECK TRAP ADDRESS AT ZERO
       TSX ZERO,4    
       HTR IDIF+5    ERR. IN TRAP ADDRESS.
       REM           CORRECT
       TRA IDIF      ADDERSS IN MQ,ADDRESS
       REM           WRITTEN IN ACC.
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO.
       REM           
       TSX BITS,4    CHECK BITS IDIF
       HTR 0,0,7     SHOULD HAVE 15,16,17
       REM           CORRECT
       TSX ERROR,4   BITS IN MQ, ORIG BITS IN ACC
       TSX OK,4      PROCEED OR
       TRA IDIF      REPEAT
       REM           
       REM           
*FDP TO CHECK REMAINING BIT COMBINATIONS.
       REM           
*FDP UNDERFLOW,BITS 14, 17. INDIRECT ADDRESSING.
       REM           
       BCD 1FDP-     
 IDIG  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       AXT IDIGT,1   
       SXA SECT2,1   SET RETURN ADDRESS
       CLA* IT7+4    144.07
       FDP* IT7+5    BY 345.7 UNDERFLOW.
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA IDIG      
       TRA *+5       CANT TEST TRIGGERS,
       REM           
*CHECK OVERFLOW TRIGGERS.
 IDIGT TSX UONLY,4   ACC OV. ON
       TRA IDIG      
       TRA *+2       DIVIDE CHECK ON
       TRA IDIG      
       REM           
*CHECK ACC COLS S,Q,P,AND 35.
       TSX ACB,4     
       HTR           ERR. ACC S,Q,P, AND 35,
       REM           SHOULD BE
       TRA IDIG      ZERO,BITS IN ERR IN IND.
       REM           REG. AS OCTAL NUMBERS.
       REM           10#S, 4#Q, 2#P, 1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 111000000000   ERR IN ACC 1 TO 34,
       REM           CORRECT
       TRA IDIG      ANS IN MQ,ORIG ANS IN ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 377100000000   ERR IN MQ,CORRECT ANS
       TRA IDIG      IN MQ,ORIG ANS IN ACC.
       REM           
*CHECK TRAP ADDRESS AT ZERO.
       TSX ZERO,4    
       HTR IDIG+5    ERR IN TRAP ADDRESS,CORRECT
       TRA IDIG      ADDRESS IN MQ,ADDRESS
       REM           WRITTEN IN ACC.
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO.
       TSX BITS,4    CHECK BITS IDIG
       HTR 0,0,9     SHOULD HAVE14,17. CORRECT
       TSX ERROR,4   BITS IN MQ,ORIG BITS IN ACC
       TSX OK,4      PROCEED OR
       TRA IDIG      REPEAT
       REM           
       REM           
       REM           
*FDP UNDERFLOW, BITS 14,16,17, CALCULATE ACC. FACTOR,
*SIGN UNLIKE. INDIRECT ADDRESSING.
       REM           
       BCD 1FDP-     
 IDIH  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       AXT SETID,1   SKIP TO IDIH+5 IF TRAP
       SXA SECT2,1   ERROR,AND CONTINUE WITH
       REM           CORRECT ACC FACTOR.
       CLS* IT8+1    -033.404040404 IN ACC.
       FDP* IT8+4    BY 202.4,SHOULD NOT TRAP.
*IF TRAP OCCURS HERE,INDICATION OF TRAP ERROR
*WILL BE GIVEN FROM THE SUBROUTINE SETID,THE
*CORRECT QUOTIENT WILL BE PLACED IN THE MQ
*WITH LDQ INDIRECTLY ADDRESSED,AND TEST WILL
*CONTINUE FROM THIS POINT.
       AXT IDIHT,1   
       SXA SECT2,1   SET RETURN ADDRESS
       PXD           CLEAR ACC.
       LLS 35        -032.404040404 TO ACC
       REM           SHOULD NOT GET ACC OV.
       FDP* IT8+10   BY 344.440404040,UNDERFLOW.
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA IDIH      
       TRA *+5       CANT TEST TRIGS
       REM           
*CHECK OVERFLOW TRIGGERS.
 IDIHT TSX UONLY,4   ACC OV. ON
       TRA IDIH      
       TRA *+2       DIVIDE CHECK ON
       TRA IDIH      
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 2+4+8     ERR,ACC S,Q,P, AND 35
       REM           SHOULD
       TRA IDIH      HAVE S,Q,P. BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NUMBERS.
       REM                10#S, 4#Q, 2#P, 1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 377423035700    ERR IN ACC 1 TO 34,
       REM           CORRECT
       TRA IDIH      ANS. IN MQ, ORIG. ANS. IN
       REM           ACC.
       REM           
*CHECK MQ COLS S TO 35
       TSX MQF,4     
       OCT -266715412642  ERR. IN MQ,CORRECT
       REM           ANS.
       TRA IDIH      IN MQ,ORIG. ANS. IN ACC.
       REM           
*CHECK TRAP ADDRESS AT ZERO.
       TSX ZERO,4    
       HTR IDIH+10   ERR. IN TRAP ADDRESS,
       REM           CORRECT
       TRA IDIH      ADDRESS IN MQ,ADDRESS
       REM           WRITTEN IN ACC.
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO.
       TSX BITS,4    CHECK BITS IDIH
       HTR 0,0,11    
       TSX ERROR,4   SHOULD HAVE 14,16,17.
       REM           CORRECT
       TSX OK,4      BITS IN MQ,ORIG. BITS IN
       REM           ACC.
       TRA IDIH      PROCEED OR REPEAT
       REM           
       REM           
       REM           
*FDP WITH ACC UND,BITS 14,16 MQ OK.
*INDIRECT ADDRESSING. 
       REM           
       BCD 1FDP-     
 IDIK  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       AXT IDIKT,1   
       SXA SECT2,1   SET RETURN ADDRESS
       CLA* IT9+4    32.404040404
       FDP* IT9+5    BY 32.440404040 UND.FLOW.
       TSX ERROR-1,4 FAILED TO TRAP
       TRA IDIK      
       TRA *+5       CANT TEST TRIGGERS.
       REM           
*CHECK OVERFLOW TRIGGERS.
 IDIKT TSX UONLY,4   ACC OV ON
       TRA IDIK      
       TRA *+2       DIVIDE CHECK ON
       TRA IDIK      
       REM           
*CHECK ACC COLS S,Q,P,AND 35
       TSX ACB,4     
       HTR 2+4       ERR,ACC S,Q,P, AND 35,
       REM           SHOULD
       TRA IDIK      HAVE Q,P. BITS IN ERR IN
       REM           IND. REG. AS OCTAL NUMBERS.
       REM           10#S,4#Q,2#Q,1#35.
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 377423035700    ERR IN ACC 1 TO 34,
       REM           CORRECT
       TRA IDIK      ANS. IN MQ,ORIG ANS. IN AC
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 200715412642    ERR IN MQ,CORRECT ANS
       TRA IDIK      IN MQ,ORIG. ANS. IN ACC.
       REM           
*CHECK TRAP ADDRESS AT ZERO
       TSX ZERO,4    
       HTR IDIK+5    ERR IN TRAP ADDRESS,CORRECT
       TRA IDIK      ADDRESS IN MQ,ADDRESS
       REM           WRITTEN IN ACC.
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO
       TSX BITS,4    CHECK BITS IDIK
       HTR 0,0,10    SHOULD HAVE 14,15. CORRECT
       TSX ERROR,4   BITS IN MQ,ORIG. BITS IN
       REM           ACC.
       TSX OK,4      PROCEED OR
       TRA IDIK      REPEAT
       REM           
       REM           
       REM           
*FDP WITH MQ OV., ACC. OK. BITS 14,15,17.
*INDIRECT ADDRESSING 
       REM           
       BCD 1FDP-     
 IDIL  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       AXT IDILT,1    
       SXA SECT2,1   SET RETURN ADDRESS
       CLA* IT10+4   377.4
       FDP* IT10+5   BY 10.4,OVERFLOW.
       TSX ERROR-1,4 FAILED TO TRAP.
       TRA IDIL      
       TRA *+5       CANT TEST TRIGGERS
       REM           
*CHECK OVERFLOW TRIGGERS
 IDILT TSX OONLY,4   ACC OV. ON
       TRA IDIL      
       TRA *+2       DIVIDE CHECK ON
       TRA IDIL      
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     
       HTR           ERR,ACC S,Q,P, AND 35
       REM           SHOULD
       TRA IDIL      ALL#0,BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S, 4#Q, 2#P, 1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 345000000000     ERR IN ACC 1 TO 34,
       REM           CORRECT
       TRA IDIL      ANS. IN MQ,ORIG. ANS. IN
       REM           ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 170400000000    ERR IN MQ,CORRECT ANS
       TRA IDIL      IN MQ,ORIG. ANS. IN ACC.
       REM           
*CHECK TRAP ADDRESS AT ZERO.
       TSX ZERO,4    
       HTR IDIL+5    ERR IN TRAP ADDRESS.
       TRA IDIL      CORRECT ADD. IN MQ,ADDRESS
       REM           WRITTEN IN ACC.
       REM           
*CHECK INDICATOR BITS IN DECREMENT OF ZERO.
       TSX BITS,4    CHECK BITS IDIL
       HTR 0,0,13    SHOULD HAVE 14,15,17.
       REM           CORRECT
       TSX ERROR,4   BITS IN MQ,ORIG BITS IN ACC
       TSX OK,4      PROCEED OR
       TRA IDIL      REPEAT
       REM           
       REM           
       REM           
       REM           
*END SECTION 1 OF PART 3, GO ON TO SECTION 2.
       REM           
       REM           
       REM           
       REM           
*SECTION 2 OF PART 3  OF 9M05, FLOATING POINT
*RELIABILITY, REPEAT SECTION 2 OF PART 2 WITH THE ADDITION
*OF INDIRECT ADDRESSING.
       REM           
*9 OV OPERATION TEST WITH FAD,NO EXCHANGE.
       REM
       BCD 1FAD      
 IDRA  TSX PART3,4   LITES 3 AND 4 ON,CLEAR
       AXT IDRAT,1   SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP.
       PXD           CLEAR ACC.
       FAD* RELA+4   +233.000000001#201.4
       REM           WORST CASE NORMALIZE.
       FAD* RELA+5   +201.6#202.5
       FAD* RELA+6   +202.6#203.54
       FAD* RELA+7   +203.6#204.56
       FAD* RELA+8   +204.6#205.57
       FAD* RELA+9   +205.6#206.574
       FAD* RELA+10  +206.6#207.576
       FAD* RELA+11  +207.6#210.577
       FAD* RELA+12  +210.6#211.5774
       FAD* RELA+13  +211.6#212.5776
       FAD* RELA+14  +212.6#213.5777
       FAD* RELA+15  +213.6#214.57774
       FAD* RELA+16  +214.6#215.57776
       FAD* RELA+17  +215.6#216.57777
       FAD* RELA+18  +216.6#217.577774
       FAD* RELA+19  +217.6#220.577776
       FAD* RELA+20  +220.6#221.577777
       FAD* RELA+21  +221.6#222.5777774
       FAD* RELA+22  +222.6#223.5777776
       FAD* RELA+23  +223.6#224.5777777
       FAD* RELA+24  +224.6#225.57777774
       FAD* RELA+25  +225.6#226.57777776
       FAD* RELA+26  +226.6#227.57777777
       FAD* RELA+27  +227.6#230.577777774
       FAD* RELA+28  +230.6#231.577777776
       FAD* RELA+29  +231.6#232.577777777
       FAD* RELA+30  +232.6#233.577777777
       REM           MQ#200.4
*CHECK ACC S,Q,P,AND 35.
       TSX ACB,4     
       HTR 1         ERR. ACC S,Q,P, AND 35.
       REM           SHOULD AHVE
       TRA IDRA      35. BITS IN ERR. IN IND.
       REM           REG.
       REM           10#S,4#Q,2#P,1#35
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 233577777776    ACC ERR,COLS 1 TO 34.
       REM           CORRECT
       TRA IDRA      ANS. IN MQ.ORIG. ANS. IN
       REM           ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 200400000000    MQ ERR. CORRECT ANS.
       TRA IDRA      IN MQ,ORIG ANS. IN ACC.
       TRA IDRAT+3   FINISHED
       REM           
       REM           
 IDRAT LXA 0,1       TRAP ADDRESS IN XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS OF
       REM           INST. THAT CAUSED TRAP
       REM           IN XRA.
       TSX OK,4      FINISHED,PROCEED
       TRA IDRA      OR REPEAT
       REM           
       REM           
       REM           
*REPEAT RELC WITH INDIRECT ADDRESSING
       REM           
*NO 9 OV OPERATION WITH FMP.
       REM           
       BCD 1FMP      
 IDRB  TSX PART3,4   LITES 3 AND 4 ON.CLEAR.
       AXT IDRBT,1   SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP
       LDQ* RELC+3   177.600000003
       FMP* RELC+4   ACC 376.440000004
       REM           MQ 343.4000000011
       FMP* RELC+5   ACC 376.600000020
       REM           MQ 343.400000066
       FMP* RELC+6   ACC 376.600000124
       REM           MQ 343.000000504
       FMP* RELC+7   ACC 376.000000746
       REM           MQ 343.000003630
       FMP* RELC+8   ACC 376.0000005544
       REM           MQ 343.000026620
       FMP* RELC+9 ACC 376.0000022130
       REM           MQ 343.000210540
       FMP* RELC+10  ACC 376.000315020
       REM           MQ 343.001464100
       FMP* RELC+11  ACC 376.002316140
       REM           MQ 343.011470600
       FMP* RELC+12  ACC 376.016325100
       REM           MQ 343.071524400
       FMP* RELC+13  ACC 376.126376600
       REM           MQ 343.531773000
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     
       HTR           ERR. ACC S,Q,P, AND 35.
       REM           SHOULD
       TRA IDRB      ALL BE 0. BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM           
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       OCT 376126376600 ERRIN ACC 1 TO 34,
       REM           CORRECT
       TRA IDRB      ANS. IN MQ,ORIG. ANS. IN
       REM           ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       OCT 343531773000 MQ ERR. CORRECT ANS.
       REM           IN
       TRA IDRB      MQ,ORIG. ANS. IN ACC.
       REM           
       TRA IDRBT+3   FINISHED
       REM           
 IDRBT LXA 0,1       TRAP ADDRESS TO XRA
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR,ADDRESS OF
       REM           INST. THAT CAUSED
       REM           TRAP IN XRA.
       TSX OK,4      FINISHED. PROCEED
       TRA IDRB      OR REPEAT.
       REM           
       REM           
       REM           
*REPEAT RELE WITH INDIRECT ADDRESSING.
       REM           
*9 OV OPERATION WITH FRN AFTER FDP,FMP, AND FAD.
       REM           
       BCD 1FRN      
 IDRC  TSX PART3,4   LITES 3 AND 3 ON,CLEAR.
       AXT IDRCT,1   SET RETURN ADDRESS
       SXA SECT2,1   INCASE OF TRAP.
       CLA* RELE+3   200.777777777
       FDP* RELE+4   MQ#201.4
       FMP* RELE+5   ACC#177.7777777
       FAD* RELE+6   ACC#200.7777777
       REM           MQ#145.4
       FRN           ACC#201.4
       FSB* RELE+8   ACC AND MQ NOW ZERO.
       REM           
*CHECK ACC COLS S,Q,P, AND 35.
       TSX ACB,4     
       HTR           ERR. ACC S,Q,P, AND 35
       REM           SHOULD
       TRA IDRC      BE ZERO. BITS IN ERR. IN
       REM           IND. REG. AS OCTAL NOS.
       REM           10#S,4#Q,2#P,1#35
       REM
*CHECK ACC COLS 1 TO 34.
       TSX ACCF,4    
       HTR           ERR IN ACC 1 TO 34. CORRECT
       TRA IDRC      ANS. IN MQ,ORIG. ANS. IN
       REM           ACC.
       REM           
*CHECK MQ COLS S TO 35.
       TSX MQF,4     
       HTR           ERR. IN MQ. CORRECT ANS.
       TRA IDRC      IN MQ,ORIG. ANS. IN ACC.
       REM           
       TRA IDRCT+3   FINISHED
       REM           
       REM           
 IDRCT LXA 0,1       TRAP ADDRESS IN XRA.
       TXI *+1,1,-1  XRA-1
       TSX ERROR,4   TRAP ERROR. ADDRESS OF
       REM           INST. THAT CAUSED TRAP
       REM           IS IN XRA.
       TSX OK,4      FINISHED. PROCEEED
       TRA IDRC      OR REPEAT
       REM           
       REM           
       REM           
*FLOATING POINT ACCURACY ANDRELIABILITY TESTS
*WITH INDIRECT ADDRESSING.
       REM           
*REPEAT AT1 WITH INDIRECT ADDRESSING.
       REM           
*SOLUTION OF, A#R+LQB+QB,WHERE
*Q#A/B, AND R#REMAINDER.
*LQB IS THE LOW ORDER PART OF THE F.P. PRODUCT QB.
*THE LOW ORDER PART OF THE SUM HAS A ZERO FRACTION.
       REM           
       BCD 1FPOPS    
 IDA1  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       AXT IDA1T,1   SET RETURN ADDRESS
       SXA SECT2,1   IN CASE OF TRAP
       AXT 10,1      LOAD XRA. 10 PASSES.
       CLA* AT1+6    
       FDP* AT1+7    Q IN MQ, R IN ACC
       DCT           
       TRA IDA1+27   SHOULD HAVE DIVIDED
       STO* AT1+10   SAVE R
       FMP* AT1+11   QB
       STO* AT1+12   SAVE QB
       PXD           CLEAR ACC
       LLS 35        LQB TO ACC,SHOULD NOT OV.
       FAD* AT1+15   +R
       FAD* AT1+16   +QB
       SUB* AT1+17   CHECK CACLULATIONS.
       TNZ IDA1+30   ACC SHOULD BE ZERO.
       RQL 9         
       LGL 27        F.MQ. TO ACC.
       TNZ IDA1+33   ACC SHOULD BE ZERO.
       TIX IDA1+4,1,1    NEXT FACTOS.
       TRA IDA1+36   FINISHED.
       REM           
*CHECK ROUTINES FOLLOW, PROGRAM TAKES 10 PASSES,
*PASS ON WHICH ERROR OCCURED, IN OCTAL, INFERRED AS
*FOLLOWS, P#12-XRA+1. DIFFERENT FACTOS ON EACH PASS.
       REM           
       REM           
 IDA1T LXA 0,2       TRAP ADDRESS TO XRB.
       TXI *+1,2,-1  XRB-1
       TSX ERROR-1,4 TRAP ERROR,ADDRESS OF
       TRA IDA1      INST. THAT CAUSED TRAP IN
       REM           XRB.
       TRA IDA1+20   GO ON TO NEXT PASS
       REM           
       TSX ERROR-1,4 DIV. CHECK ON,SHOULD
       TRA IDA1      HAVE DIVIDED. AT IDA1+5.
       TRA IDA1+20   GO ON TO NEXT PASS.
       REM           
       REM           
       TSX ERROR-1,4 CALCULATION IN ERROR,ACC
       TRA IDA1      WAS NOT ZERO AT IDA1+16.
       TRA IDA1+20   GO ON TO NEXT PASS.
       REM           
       TSX ERROR-1,4 F. MQ. WAS NOT ZERO AT
       TRA IDA1      IDA+19.
       TRA IDA1+20   GO ON TO NEXT PASS.
       REM           
       TSX OK,4      FINISHED,PROCEED
       TRA IDA1      OR REPEAT.
       REM           
       REM           
       REM           
*REPEAT AT3 WITH INDIRECT ADDRESSING. THE
*SQUARE ROOT SUB-ROUTINE WITH INDIRECT ADDRESSING
*IS USED.            
       REM           
*THE QUADRATIC FORMULA,3 PASSES,2 ANSWERS EACH PASS.
       BCD 1FPOPS    
 IDA2  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       CAL IDA2+23   SET RETURN ADDRESS
       STA SECT2     IN CASE OF TRAP.
       LXD IDA2+13,1 21 TO XRA
       LDQ* AT3+4     A
       FMP* AT3+5      AXC
       ACL* AT3+6        X4
       STO* AT3+7    4AC
       LDQ* AT3+8    B
       FMP* AT3+9      B SQUARED
       FSB* AT3+10          -4AC
       CAS* AT3+11   CHECK RADICAN
       TXI *+2       ERROR.
       TXI *+5,0,21  OK.
       REM           
       LDQ* AT3+14   CORRECT ANS IN MQ.
       TSX ERROR-1,4 ERR. IN B SQRD-4AC
       TRA IDA2      
       REM           PLACE CORRECT RADICAND.
       CLA* AT3+17   IN ACC AND CONTINUE.
       REM           
       TSX SQRI,4    GET R,WHERE R#SQUARE-
       REM           ROOT OF B SQRD-4AC.
       TTR *+5       ERROR,RADICAN SHOULD
       REM           HAVE BEEN PLUS.
       CAS* AT3+20   CHECK SQUARE ROOT
       TTR *+2       ERROR.
       TXI *+6       OK
       NOP IDA2T     
       LDQ* AT3+24   CORRECT ANS. IN MQ
       TSX ERROR-1,4 ERROR IN SQUARE ROOT.
       TRA IDA2      
       CLA* AT3+27   GO ON WITH CORRECT R.
       REM           
       DCT           TURN OFF DC TRIG.
       NOP           
       STO* AT3+30   
       LDQ* AT3+31   A#201.4
       FMP* AT3+32   2A#202.4
       STO* AT3+33   
       CLS* AT3+34   -B
       FAD* AT3+35     +R
       FDP* AT3+36        /2A
       DCT           SHOULD DIVIDE
       TTR *+2       ERROR
       TXI *+4       OK
       REM           
       LDQ* AT3+40   CORRECT QUOTIENT TO MQ.
       TSX ERROR-1,4 DC ON,ERROR.
       TRA IDA2      
       REM           
       XCA           
       CAS* AT3+44   CHECK FIRST ANS.
       TTR *+2       ERROR
       TXI *+4       OK
       LDQ* AT3+47   CORRECT ANS. TO MQ.
       TSX ERROR-1,4 FIRST ANS. WRONG.
       TRA IDA2      
       REM           
       CLS* AT3+50   -B
       FSB* AT3+51     -R
       FDP* AT3+52         /2A
       DCT           SHOULD DIVIDE.
       TTR *+2       ERROR.
       TXI *+4       OK
       LDQ* AT3+56   CORRECT QUOTIENT TO MQ.
       TSX ERROR-1,4 DC ON,ERROR.
       TRA IDA2      
       REM           
       XCA           
       CAS* AT3+60   CHECK SECOND ANS.
       TTR *+2       ERROR
       TXI *+4       
       LDQ* AT3+63   CORRECT ANS. IN MQ.
       TSX ERROR-1,4 SECOND ANS. WRONG
       TRA IDA2      
       REM           
       TIX IDA2+4,1,7    NEXT PASS
       TRA *+6    
       REM           
 IDA2T LXA 0,2       TRAP ADDRESS TO XRB.
       TXI *+1,2,-1  XRB-1.
       TSX ERROR-1,4 TRAP ERROR,ADD. OF INST.
       TRA IDA2      THAT CAUSED TRAP IN XRB.
       TRA *-6       GO ON TO NEXT PASS.
       REM           
       TSX OK,4      FINISHED. PROCEED OR
       TRA IDA2      REPEAT.
       REM           
       REM           
       REM           
*REPEAT AT4A WITH INDIRECT ADDRESSING. THE
*PRIMITIVE ROOT SUB-ROUTINE WITH INDIRECT
*ADDRESSING IS USED. 
       REM           
       BCD 1FPOPS    
 IDA3  TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       SLN 1         1 ON TO SIGNAL
       REM           PRIMITIVE ROOT PROG. ON.
       AXT 8,1       4 PASSES
       AXT IDA3T,2   SET RETURN ADDRESS
       SXA SECT2,2   IN CASE OF TRAP.
       CLA* AT4A+5   PRIME TO ACC.
       TSX PRID,4    GET PRIMITIVE ROOT.
       TXI CATS      ERROR,PRIMES SHOULD
       REM           BE WITHIN RANGE.
       TXI CATS+4    ERROR,THESE VALUES
       REM           ARE PRIMES.
       TXI MACHE     ERROR,DIVIDEND SHOULD BE 
       REM           GREATER THAN QUOT. TIMES
       REM           DIV.
       STQ* AT4A+10  SUCCESFUL RETURN HERE.
       CAS* AT4A+11  CHECK ROOT.
       TXI *+2       ERROR.
       TRA *+4       OK
       REM           
       LDQ* AT4A+14  
       TSX ERROR-1,4 WRONG ROOT IN ACC.
       TRA IDA3      
       REM           
*ON ERROR,PRIME USED IN SALON,VALUES
*ARE STORED STARTING AT PRIMS UP TO PRIMS+8
*IN THIS ORDER,PRIME,ITS ROOT,PRIME,ITS ROOT, ETC.
       REM           
*THE PRIME NUMBERS USED ANS THE RESPECTIVE
*ROOTS THAT SHOULD BE CALCULATED ARE GIVEN
*BELOW IN THE ORDER OF THEIR APPEARENCE...
       REM           
*         PRIME    ROOT      XRA WILL
*                            HAVE *
       REM           
*         OCTAL    OCTAL     OCTAL
       REM           
*         202.6    202.4       10
       REM           
*         203.7    202.6        6
       REM           
*         207.604  203.5        4
       REM           
*         212.7624 203.7        2
       REM           
*        DECIMAL  DECIMAL      OCTAL
       REM           
*           3        2         10
       REM           
*           7        3          6
       REM           
*          97        5          4
       REM           
*         997        7          2
       REM           
*                            *. EXCEPT AT MACH
*                            OR FOR TRAP ERROR.
       REM           
       REM           
       REM           
       CLA* AT4A+17  CHECK MQ FACTOR.
       FAD* AT4A+18  MQ FACTOR +1 SHOULD
       CAS* AT4A+19  BE # ORIG. PRIME.
       TXI *+2       ERROR.
       TRA IDA3R     OK.
       CLA* AT4A+22  ORIG. PRIME
       FSB* AT4A+23  -1
       XCA           CORRECT ANS TO MQ
       CLA* AT4A+25  RESTORE ACC.
       TSX ERROR-1,4 ERROR IN MQ FACTOR,
       TRA IDA3      CORRECT ANS IN MQ,ORIG.
       REM           ANS IN ACC.
       TRA IDA3R     
       REM
 CATS  LDQ* RATS     CORRECT ROOT IN MQ.
       TSX ERROR-1,4 ERROR,ALL THESE PRIMES
       TRA IDA3      ARE WITHIN RANGE,
       REM           ACC HAS PRIME,MQ THE ROOT.
       TRA IDA3R     
       LDQ* AT4A+33  
       TSX ERROR-1,4 CORRECT ROOT IN MQ
       TRA IDA3      ERR,ALL THESE NOS. ARE
       REM           PRIME AND SHOULD
       REM           NEVER YEILD ZERO
       TRA IDA3R     AT PRID+29.
       REM           
 MACHE TSX ERROR-1,4 MACHINE ERROR
*THE PRODUCT OF THE INTEGRAL PART OF THE QUOTIENT
*TIMES THE DIVISOR IS ALWAYS AT LEAST ONE LESS THAN
*THE DIVIDENT WHEN USIGN PRIME NUMBERS.
*ERR OCCURED AT PRID+30, OR PRID+33. SEE ALSO MACH.
       TRA IDA3      
       REM           
       LXA PRID+46,1    RESTORE XRA.
       TRA IDA3R     
       REM           
 IDA3T LXA 0,2       TRAP ADDRESS IN XRB
       TXI *+1,2,-1  XRB-1
       TSX ERROR-1,4 TRAP ERR,ADDRESS OF INST.
       TRA IDA3      THAT CAUSED TRAP IN XRB.
       REM           
       LXA PRID+46,1 RESTORE XRA
 IDA3R TIX IDA3+5,1,2    NEXT PASS.
       TSX OK,4      FINISHED,PROCEED
       TRA IDA3      OR REPEAT.
       REM           
       REM           
       REM           
       TSX SPACE,4   COOL, MAN- 1 MEAN LIKE-
       TRA DONE      THE END.
       REM           
       REM           
       REM           
       REM           
*SERVICE AREA FOR PARTS 2 AND 3 OF 9M05.
*CHECKING AND SERVICE SUB-ROUTINE.
*CONSTANTS AND FREE AREAS FOR TEMPORARY STORAGE.
       REM           
       REM           
       REM           
       REM           
*SUBROUTINE TO CHECK THAT ACC OV AND DIVIDE-CHECK
*      TRIGGGERS ARE OFF.
       REM           
 UONLY TNO *+2       WAS ACC OV. ON,
       TRA ERROR-1   YES. ERROR LOCATION
       REM           ALREADY IN XRC
       DCT           
       TIX ERROR-1,4,2 DIVIDE CHECK ON.
       REM           ERROR LOC. IS IN XRC
       REM           
       TRA 4,4       TRIGS OK.
       REM           
 OONLY EQU UONLY     
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       TSX SPACE,4   
       REM           
       REM           
       REM           
*SUBROUTINE TO TEST ACC COLS. S,Q,P, AND 35.
*CORRECT BITS IN INDICATOR REGESTER,COLS 32 TO 35,
*AS FOLLOWS. 1#35,2#P,4#Q,10#S. ALL IN
*OCTAL. EXAMPLE... 11 OCTAL IN THE INDICATOR
*REGESTER MEANS WE SHOULD HAVE ONLY A BIT IN S, AND IW 35.
 ACB   SLW SALON+5   SAVE ACC P TO 35.
       STQ Q         SAVE MQ.
       LDI 1,4       CORRECT BIT CODE TO IND.
       REM           REG.
       LBT           
       TRA *+2       FOR NO LOW BIT,GO ON.
       IIR 1         INVERT IND. REG. COL 35 ON
       REM           L BIT
       PBT           
       TRA *+2       GO ON. NO P BIT.
       IIR 2         INVERT IND. REG. COL 34 ON
       REM           P BIT.
       LRS 1         TO GET Q BIT
       PBT           
       TRA *+2       NO Q BIT,GO ON.
       IIR 4         INVERT IND. REG. COL 33 ON
       REM           Q BIT.
       TPL *+2       
       IIR 10        INVERT IND. REG. COL 32 ON
       REM           S BIT.
       REM           
       REM           ALL IND. TRIGS. WILL BE
       REM           OF IF ACC BITS WERE OK.
       REM           
*IF RIGHT HALF OF INDICATOR REGESTER IS NOT ZERO,
*THEN ONE OR MORE OF THE ACC COLS S,Q,P, AND /OR 35
*IS IN ERROR,AND THE CODE FOR THE BITS THAT
*ARE WRONG IS NOW IN THE RIGHT HALF OF THE
*INDICATOR REGESTER AS AN OCTAL NUMBER. THE
*POSSIBLE OCTAL BIT CODES,AND THE CORRESPONDING
*COLS OF THE ACC WHICH ARE WRONG,ARE AS FOLLOWS.
       REM           
*    BIT CODE      ACC COLS
*     OCTAL         WRONG
*       1             35
       REM             
*       2             P
       REM             
*       3             P AND 35
       REM             
*       4             Q
       REM             
*       5             Q AND 35
       REM             
*       6             Q AND P
       REM             
*       7             Q,P,AND 35
       REM             
*      10             S
       REM             
*      11             S AND 35
       REM             
*      12             S AND P
       REM             
*      13             S,P,AND 35
       REM             
*      14             S AND Q
       REM             
*      15             S,Q,AND 35
       REM             
*      16             S,Q,AND P
       REM             
*      17             S,Q,P,AND 35
       REM           
       REM           
       REM           
       REM           
       LLS 1         RESTORE ACC TO ORIG. VALUE.
       TNO *+1       TURN OFF ACC OV. IN CASE IT
       REM           WAS TURNED ON BY THEY
       REM           PRECEEDING INSTRUCTION.
       REM           
       LDQ Q         RESTORE MQ.
       REM           
       RFT 17        SEE IF RIGHT HALF IND.
       REM           REG. IS ZERO.
       REM           
       TIX ERROR-1,4,1   NO,ERROR IN ACC S,Q,P,
       REM           AND 35.
       REM           TEST LOCATION -1 IS ALREADY
       REM           IN XRC,IN COMP. FORM. ADD 1
       REM           TO XRC AND GO TO ERROR -1,
       REM           THEN
       REM           CONTINUE PROGRAM.
       REM           
       TRA 3,4       OK,IND. ARE ZERO,RETURN TO
       REM           PROGRAM.
       REM           
       REM           
*CHECKING ACC COLS 1 TO 34. OTHER BITS ALREADY CHECKED
       REM           
 ACCF  PXD           CLEAR ACC.
       ADM SALON+5   DROP S+O.
       ANA SALON+6   KNOCK OFF LOW BIT.
       LDQ 1,4       CORRECT ANS. IN MQ.
       SUB 1,4       
       TZE 3,4       SHOULD TRANSFER
       ADD 1,4       REPLACE ORIG ANS.
       TIX ERROR-1,4,1    TEST LOC IN XRC.
       REM           
       REM           
*CHECK RESULTS IN MQ. COLS STO 35.
       REM           
 MQF   LDQ 1,4       CORRECT ANS. IN MQ.
       CLA Q         ORIG. MQ RESULTS.
       TRA ACCF+4    
       REM           
       REM           
*CHECK ADDRESS PORTION OF LOC. ZERO AFTER TRAP.
       REM           
 ZERO  LDQ 1,4       CORRECT ADD. IN MQ.
       LXA 0,1       
       PXA 0,1       ADD. TO ACC THROUGH XRA.
       TRA ACCF+4    
       REM           
       REM           
*CHECK F.P. TRAP INDICATOR BITS IN DEC OF ZERO.
       REM           
 BITS  LDQ 1,4       CORRECT BITS TO MQ.
       LXD 0,1       
       PXD 0,1       BITS TO ACC THROUGH XRA.
       CAS 1,4       
       TRA 2,4       WRONG BITS
       TRA 3,4       BITS OK
       TRA 2,4       WRONG BITS
       REM           
       REM           
 SETIT TSX ERROR-1,4 TRAP ERROR AT IT8+4.
       TRA IT8       
       TSX PART2,4   CLEAR,LIGHT 4 ON.
       LDQ SALON+4   -32.404040404
       TRA IT8+7     CONTINUE IT8.
       REM           
 SETID TSX ERROR-1,4 TRAP ERROR AT IDIH+4.
       TRA IDIH      
       TSX PART3,4   LITES 3 AND 4 ON,CLEAR.
       LDQ* *-5      CORRECT VALUE TO MQ.
       TRA IDIH+5    CONTINUE IDIH.
       REM           
       REM           
*SQUARE ROOT SUBROUTINE. ROOT EXACT TO 9 OCTAL DIGITS.
       REM           
 SQRT  TMI 1,4       ERROR.
       TZE 2,4       OUT ON ZERO.
       SXA *+12,1    SAVE XRA.
       AXT 13,1      13 ITERATIONS
       STO FREE      N # RADICAND.
       SUB *+11      N/2
       FAD *+11      +1
       STO FREE+1    FIRST GUESS # X
       CLA FREE      N
       FDP FREE+1    N/X
       XCA           
       FAD FREE+1    +X
       SUB *+4       DIV. BY 2
       TIX *-6,1,1   REPEAT
       AXT 0,1       REPLACE XRA.
       TRA 2,4       EXIT.
       OCT 001000000000
       DEC 1.0       
       REM           
       REM           
       REM           
*SQUARE ROOT SUB-ROUTINE WITH INDIRECT ADDRESSING.
       REM           
 SQRI  TMI 1,4       ERROR
       TZE 2,4       FINISHED IF ZERO
       SXA SQRI+14,1 SAVE XRA.
       AXT 13,1      13 ITERATIONS
       STO* SQRT+4   N # RADICAND.
       SUB* SQRT+5   N/2
       FAD* SQRT+6   +1
       STO* SQRT+7   FIRST GUESS # X
       CLA* SQRT+8   N
       FDP* SQRT+9   N/X
       XCA           
       FAD* SQRT+11  +X
       SUB* SQRT+12  DIV BY 2
       TIX *-6,1,1   REPEAT.
       AXT 0,1       REPLACE XRA.
       TRA 2,4       EXIT.
       REM           
       REM           
       REM           
*TO ENTER KEYS,WILL ENTER ONLY IF
*S IS DOWN,AND THE VALUE IS A FLOATING POINT
*INTEGER WITH CHAR. GREATER THAN 200,LESS THEN 234.
*S IS NOT ENTERED.   
       REM           SUB-ROUTINE.
 ENK   ENK           
       XCA           KEYS TO ACC
       TPL 1,4       NO ENTRY IF PLUS
       SLW SALON     DONT USE SIGN
       SSP           
       LRS 27        CHAR. TO ADDRESS
       CAS L233      CHECK CHAR.
       TRA 1,4       TO HIGH.
       NOP           
       CAS K61       L201
       NOP           
       TRA *+2       OK
       TRA 1,4       TOO LOW.
       LRS 8         SET MQ PLUS.
       XCA           
       UFA K40+2     CHECK FOR INTEGER.
       PXD           CLEAR ACC.
       RQL 9         IF FMQ IS ZERO,THEN.
       LGL 27        NUMBER IS AN INTEGER.
       TNZ 1,4       NOT INTEGER
       TRA 2,4       OK.
       REM           
       REM           
       REM           
*PRIMATIVE ROOT SUBROUTINE. PRIME IN ACC ON ENTERY.
*ROOT IN ACC, P-1 IN MQ ON EXIT.
       REM           
 PRIRT STO SALON     
       FSB COEF-19   -3
       TPL *+3       
       CLA SALON     
       TRA 1,4       OUT OF RANGE
       FAD COEF      +1
       UFA K40+2     233.0
       ANA KK        FIX
       STO SALON+1   TALLY COUNT.
       ARS 12        CHECK SIZE.
       LBT           4095 MAX
       TRA *+2       OK.
       TRA PRIRT+3   TOO HIGH.
       SXA PRIRT+46,1    SAVE XRA.
       SXA PRIRT+47,2    SAVE XRB.
       AXT 10,1      10 TRIAL ROOTS.
       LXA SALON+1,2 SET TALLY COUNT
       REM           AND GO.
       CLA PRIMS,1   TRIAL ROOT.
       SLW FREE      DROP SIGN.
       LDQ PRIMS,1   
       FMP FREE      GET DIVIDEND.
       STO FREE+1    SAVE DIVIDEND.
       FDP SALON     RE/P
       XCA           
       UFA K40+2     GET INTEGRAL
       FAD K40+2     PART OF QUOTIENT.
       XCA           INTEGRAL PART OF
       FMP SALON     QUOTIENT TIMES DIVISOR.
       FSB FREE+1    SHOULD GO ZERO OR MINUS.
       TZE *+11      NOT PRIME.
       TPL 3,4       ERROR IF NOT ZERO
       REM           AND NOT MINUS.
       FAD COEF      IS THIS UNITY MOD P.
       TZE *+9       IF ZERO,ROOT FOUND
       REM           IF TALLY CTR#1.
       REM           
       TPL 3,4       IF NOT ZERO,MUST BE NEG.
       FSB COEF      RESTOR REMAINDER.
       TIX PRIRT+18,2,1  STEP TALLY CTR,TRY
       REM           AGAIN.
       REM           IF TALLY CTR #1 TRY
       REM           ANOTHER ROOT
       TIX PRIRT+16,1,1
       LXA PRIRT+46,1     OUT OF ROOTS
       LXA PRIRT+47,2     RESTORE XRA AND XRB.
       TRA PRIRT+3   PRIME OUT OF RANGE
       TIX *-3,4,1   NOT A PRIME NUMBER
       REM           
       TIX *-5,2,1   IF TALLY CTR IS NOT #1,
       REM           ROOT FOUND NO GOOD.
       CLA SALON     TALLY CTR #1,ROOT OK.
       FSB COEF      -1
       XCA           POWER TO MQ
       CLA PRIMS,1   ROOT TO ACC.
       AXT 0,1       RESTORE XRA.
       AXT 0,2       AND XRB.
       TRA 4,4       EXIT.
       REM           
       REM           
       REM           
*PRIMITIVE ROOT SUB-ROUTINE WITH INDIRECT ADDRESSING.
       REM           
 PRID  STO* PRIRT    
       FSB* PRIRT+1  -3
       TPL *+3       
       CLA* PRIRT+3  TO LOW
       TRA 1,4       PRIME OUT OF RANGE.
       FAD* PRIRT+5  +1
       UFA* PRIRT+6  233.0
       ANA* PRIRT+7  FIX
       STO* PRIRT+8  TALLY COUNT.
       ARS 12        CHECK SIZE.
       LBT           4095 MAX
       TRA *+2       OK.
       TRA PRID+3    TOO HIGH.
       SXA PRID+46,1 SAVE XRA.
       SXA PRID+47,2 SAVE XRB.
       AXT 10,1      10 TRIAL ROOTS.
       LXA SALON+1,2 SET TALLY COUNT
       REM           AND GO.
       CLA* PRIRT+17 TRIAL ROOT.
       SLW* PRIRT+18 DROP SIGN.
       LDQ* PRIRT+19 
       FMP* PRIRT+20 GET DIVIDEND.
       STO* PRIRT+21 SAVE DIVIDEND.
       FDP* PRIRT+22 RE/P
       XCA           
       UFA* PRIRT+24 GET INTEGRAL
       FAD* PRIRT+25 PART OF QUOTIENT.
       XCA           INTEGRAL PART OF
       FMP* PRIRT+27 QUOTIENT TIMES DIVISOR.
       FSB* PRIRT+28 SHOULD GO ZERO OR MINUS.
       TZE *+11      NOT PRIME.
       TPL 3,4       MACH ERROR IF NOT
       REM           ZERO AND NOT MINUS.
       FAD* PRIRT+31 IS THIS UNITY MOD P.
       TZE *+9       IF ZERO,AND IF TALLY
       REM           COUNT#1,ROOT FOUND.
       REM           
       TPL 3,4       IF NOT ZERO,MUST BE-.
       FSB* PRIRT+34 RESTOR REMAINDER.
       TIX PRID+18,2,1  STEP TALLY CTR,TRY
       REM           AGAIN,OR TRY
       REM           ANOTHER ROOT
       TIX PRID+16,1,1
       LXA PRID+46,1 RESTORE XRA AND 
       LXA PRID+47,2 XRB.
       TRA PRID+3    PRIME OUT OF RANGE
       TIX *-3,4,1   NOT A PRIME NUMBER
       REM           
       TIX *-5,2,1   IF TALLY CTR IS NOT
       REM           ONE,ROOT FOUND NO GOOD.
       CLA* PRIRT+42 IF TALLY COUNT IS ONE,
       FSB* PRIRT+43 ROOT OK.
       XCA           POWER TO MQ.
       CLA* PRIRT+45 ROOT TO ACC.
       AXT 0,1       RESTORE XRA.
       AXT 0,2       AND XRB.
       TRA 4,4       EXIT.
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM  CONSTANTS 
 BOOZE OCT 233000000001
       OCT 266000000000
       OCT 146000000000
       OCT 266400000000
       OCT 265377777777
       OCT 264777777776
       OCT 231000000004
       DEC 2.0,-3.0  
       OCT -147000000000
       OCT 233001777777
       OCT 224400000000
       OCT 171000000000
       OCT -223777777400
       OCT -170000000000
       OCT 201525252525
       OCT 234525252525
       OCT -234525252525
       OCT -201525252525
       OCT -201400000000
       OCT 267000000000
 DAVE  OCT 175631463146
       OCT -206660000000
       OCT 033404040404
       OCT 033440404040
       REM           GOODIES
 K0    OCT 0         
       OCT 33101010101
       OCT 33404040404
       OCT 33505050505
       OCT -33505050505
       OCT 33606060606
       OCT 33000000000
       OCT -33303030303
 K1    OCT 344010101010
       OCT 344440404040
       OCT 344450505050
       OCT -344010101010
       OCT -344347474747
       OCT 342404040404
 K2    OCT +377400000000
       OCT 200200000000
       OCT 267715412642
 K3    OCT 377777777777
 K5    OCT 200377777777
 K8    OCT 7100000000 
 K9    OCT 6400000000 
 K11   OCT 7200000000 
 K13   OCT 233400000000
 K14   OCT 215100000000
 K16   OCT 214600000000
 K20   OCT 10400000000
 K21   OCT 344040000000
 K23   OCT 343700000000
 K25   OCT 345000000000
 K26   OCT 144070000000
 K27   OCT 345700000000
 K30   OCT 111000000000
 K32   OCT 344700000000
 K34   OCT 633707070707
       OCT 233707070707
       OCT 200000000000
 K35   OCT 634600000000
       OCT 234400000000
 K36   OCT 233400000000
 K37   OCT 204600000000
       OCT 201400000000
       OCT 204540000000
 K40   OCT 211000000001
       OCT 222000000001
       OCT 233000000000
 K41   OCT 200       
 K42   OCT 174000000001
       OCT 170000000001
       OCT 164000000000,131,+0
 K43   OCT 200000777777
       OCT 200000000777
       OCT 145776000001
       OCT 200777777777
 K44   OCT 200777770000
       OCT 200777760000
       OCT 145100000000
       OCT 200333330000
 K45   OCT 177666651111
       OCT 144200000000
 K46   OCT 233000000000
 K47   OCT 200070707070
       OCT 200707070707
       OCT 7070707,77777777
       REM           
*IN CERTAIN TAENIOGLOSSA AND IN THE STENGLOSSA, AMONG THE
*STREPTONEURA, AND IN THE NUDIBRANCHIA AND THE PULMONATA, THE
*COMMISSURES AER SHORTENED AND THE GANGLIA ARE CONCENTRATED IN THE
*HEAD.               
       REM           
 K50   OCT 200760000000
       OCT 200700000000
       OCT 300000000,433333333
 K51   OCT 377070000000
       OCT 344700000000
       OCT 344000000000
       OCT 233000000000
 K52   OCT 376760000000
       OCT 344070000000
       OCT 377700000000
       OCT 311000000000
       OCT 145000000000
 K53   OCT 777777777 
       OCT 377000000000
 K54   OCT 633007777777
       OCT 233070000000
       OCT 230700000000
 K55   OCT 377000000000
       OCT 144070000000
       OCT 345700000000
       OCT 32070000000
 K56   OCT 377252525253
       OCT 377525242525,777770000
       OCT 202100000000
 K57   OCT 204100000000
       OCT 204120000000
       OCT 202400000000
       OCT 204700000000
 K60   OCT 205400000000
       OCT 202500000000
       OCT 233200000000
 K61   OCT 201,233000400000
       OCT 201777700000
       OCT 200777600000
 K62   OCT 233000400001
       OCT 222400001777
       OCT 167600000000
       OCT 224777777777
 K63   OCT 633777777777
       OCT 633774000000
       OCT 200774000000
       OCT 233077777777
 K64   OCT 633777777776
       OCT 233777777777
       OCT 201400000000
 K65   OCT 377777777777,7100000000
       OCT 353000000000
       OCT 354000000000
 K66   OCT 377400000000
       OCT 200400000000
       OCT 10400000000
 K67   OCT 173516274051
       OCT 176444444445
       OCT 176444444443
       OCT -435241753062
       OCT 146300000000
       OCT 201433333333
       OCT 141202471361
 K70   OCT 141202471361
 KK    OCT 000777777777    BLANK CH
 KK1   OCT 777000000000  BLANK FR
 T1    OCT 000000000000 TEMP STORAGE
 SALON HTR           
       HTR           
       HTR           
       HTR           
       OCT -032404040404
       HTR           TEMPO FRO ACC P-35
       OCT 377777777776    ALL 75,+,MASK
       OCT 000777777776
       OCT 004004444444
       OCT 001007777777
       OCT 277400000000
       DEC 2.0       
       OCT 032404040404
       OCT 032440404040
       DEC 4.0       
       OCT 002000000000
       OCT 001000000000
 A     DEC 2.0,8.0,-12.0,4.095E3,6.324E-19
       DEC 2.99764E5,-6.4E1,1.0,7.05
       OCT 201404040404
 B     DEC 1.0,7.0,16.0,-4.095E3,6.282
       DEC 2.87647E5,-3.2E1,3.0,7.04
       OCT 203440404040
 FREE  BSS 10        
       DEC 1.0,4.0,3.0,4.0,2.0,-1.0,-3.0
       DEC 1.0,6.0,-40.0,196.0,14.0,4.0,-10.0
       DEC 1.0,10.0,-144.0,676.0,26.0,8.0,-18.0
 COEF  DEC 1.0       
 L233  OCT 233       
       DEC 2.0,3.0,5.0,7.0 PRIME NOS
       DEC 11.0,13.0,17.0,19.0,23.0,29.0
 PRIMS DEC 3.0,2.0,7.0,3.0,97.0,5.0
       DEC 997.0,7.0 
 FERM  HTR 2         
       OCT 147000000000
       OCT 263000000000
       OCT 200777777777
       OCT 177777777777
       OCT 200400000000
       OCT -300000700000
 RTA   OCT 233000000001      UNORMALIZED 1
       OCT 201600000000
       OCT 202600000000
       OCT 203600000000
       OCT 204600000000
       OCT 205600000000
       OCT 206600000000
       OCT 207600000000
       OCT 210600000000
       OCT 211600000000
       OCT 212600000000
       OCT 213600000000
       OCT 214600000000
       OCT 215600000000
       OCT 216600000000
       OCT 217600000000
       OCT 220600000000
       OCT 221600000000
       OCT 222600000000
       OCT 223600000000
       OCT 224600000000
       OCT 225600000000
       OCT 226600000000
       OCT 227600000000
       OCT 230600000000
       OCT 231600000000
       OCT 232600000000
 RTB   OCT 201400000001
       OCT 301400000001
       OCT 365400000001
 RTC   OCT 234600000003
       OCT 377600000003
 TMODE OCT 177600000003
       OCT 376400000000
       OCT 377400000000
       TTR TR1E      
 Q     HTR           TEMPO FROM MQ
 BIN   HTR           
 CATCH TSX SPACE,4   
 MONIT HTR           ADDRESS OF TEST
       REM           THAT LAST ENTERED
       REM           CLEAR GOES IN
       REM           DECREMENT OF
       REM           MONIT IN TWOS
       REM           COMP. FORM.
       REM           
       REM           
*THE U.S. PRODUCTION OF COMPLETELY DENATURED INDUSTRIAL
*ALCHOHOL IN 37 PLANTS IN A. D. 1936, WAS .....
*           36,522,358
* IN WINE GALLONS.   
       REM           
*THIS IS MONITOR.    
       REM           
       REM           
*F.P. TRAP SEQUENCE  
       REM           
 SEQ   LTM           JUST IN CASE
       SLT 4         WAS TRAP EXPECTED
       TXI WHAT,0,32767  NO,ERROR
       SLN 4         YES,TRAP EXPECTED
       TXH XRCE,4,0  IF XRC STILL ZERO
       LXA 0,4       OK
       SXD COMP+2,4  SAVE TRAP ADDRESS
       LXD SECT2,4   CLEAR XRC
 SECT2 TXI 0         RETURN
       REM           
 WHAT  SXD TRAP-2,1  LIT4 WAS OFF,WHA HAPON
       LXA 0,1       WAS AN ADDRESS PUT AT 0
       TXL OUTER,1,0 IF NOT,ERROR
 COMP  SXD FREE,1    IS SO,IS IT#LAST
       LDC FREE,1    TRAP ADDRESS
       TXI *+1,1,0   
       TXL OUTER,1,0 IF ZERO,NO TRAP
       REM           BUT SKIPED TO SPACE
       REM           
       LXA 0,1       
       SXD COMP+2,1  SAVE TRAP ADDRESS
       LXD TRAP-2,1  RESTORE XRA
       TXI FADED TRAP ERROR
       REM           
       BCD 1FP TRP   
 TRAP  LXA 0,4       RETURN OT PROG
       SXA *+2,4     
       LXD *+1,4     RESTORE XRC
       TXI           RETURN
       REM           
 FADED SXD *-1,4     SAVE XRD
       TSX ERROR-1,4 TRAP IN ERROR,OR
       TRA TRAP      TRAP TO 10 IS ILLEGAL
       TRA TRAP      SEE ADDRESS AT ZERO.
       REM           
       REM           
       REM           
       REM           
 XRCE  SXD FREE,2    SAVE XRB
       SXD FREE+1,4  AND XRC
       LXD FREE+1,2  MOVE XRC TO XRB
       TXI *+2       
       BCD 1ITIME-   
       TSX ERROR-1,4 XRC WAS NOT ZERO,
       REM           IN 9M05,ALL LEGAL
       REM           TRAPS OCCURE WHEN
       REM           XRC#0, IF XRC IS
       REM           NOT#0,THEN EITHER,
       REM           TRAP OCCURED WHEN
       REM           IT SHOULD NOT HAVE,
       REM           OR XRC WAS CHANGED
       REM           BY TRAP OPERATION.
       REM           THE VALUE WHICH WAS
       REM           LOADED INTO XRC HAS
       REM           BEEN MOVED TO XRB.
       REM           ZERO HAS THE ERROR
       REM           LOCATION +1.
       NOP XRCE+5    
       LXA 0,4       SAVE TRAP
       SXD COMP+2,4  ADDRESS
       LXD FREE,2    RESTORE XRB
       TRA SECT2-1   RETURN OT TRAP PROG.
 OUTER LXD TRAP-2,1  RESTORE XRA
       TSX SPACE,4   GOT TO 10 BY MISTAKE
       BCD 1SPACE    
 SPACE SXD BIN,4     SPACE ADDRESS
       LDC BIN,4     TRUE DECREMENT
       SXD BIN,4     OF BIN
       LDC MONIT,4   ADDRESS OF TEST
       SXA BIN,4     THAT LOST CONTROL
       REM           TO ADDRESS
       LDI BIN       BIN TO IND.
       TSX ERROR-1,4 TRANSFERRED OUT OF
       REM           CONTROL. THE ADDRESS
       REM           FROM WHICH WE
       REM           RECOVERD CONTROL IS
       REM           IN DEC. OF THE
       REM           INDICATORS,STARTING
       REM           ADDRESS OF TEST WHICH
       REM           WAS UNDERWAY IS IN
       REM           THE ADDRESS OF THE
       REM           INDICATORS.
       REM           
       NOP SPACE     
       LXD MONIT,4   
       CLA -2,4      RESET MONIT
       PAC 0,2       AND
       SXD MONIT,2   RETURN TO
       TRA 0,4       PROPER SEQUENCE
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
*      PROGRAM SEQUENCE AND CONTROL MONITOR
       REM           IN CASE
       REM           9M05 TRIES TO 
       REM           SKIP-TO-MY-LOU.
       REM           
 CLEAR SLF           LIGHTS OUT
       SWT 1         
       TRA *+2       TEST 4
       TRA *+3       
       SWT 4         
       TRA *+4       NOT REPEATED
       PXD 0,4       TEST REPEATED OR
       SUB MONIT     WILL BE REPEATED
       TZE RESET+1   IF ZERO,PROGRAM
       REM           SEQUENCE OK
       REM           
       REM           
       STZ FREE      
       SXD FREE,4    SAVE TEST ADDRESS
       CLA -2,4      PRECEEDING TEST ADDRESS
       PAC 0,4       COMPLEMENT
       PXD 0,4       
       SUB MONIT     SHOULD BE ZERO
       LXD FREE,4    RESTORE XRC
       TZE RESET+1   IF ZERO,NORMAL
       REM           PROGRAM SEQUENCE OK.
       REM           
       REM           
       ENK           CHECK FOR MANUAL TRANSFER
       XCA           
       PAC 0,4       COMPLEMENT KEYS ADDRESS
       LRS 21        CHECK TRA ONLY
       SUB K41       -0200
       TNZ *+5       SEQUENCE SHORT IF NOT 0
       PXD 0,4       OK,CHECK ADDRESS
       SUB FREE      
       LXD FREE,4    RESTORE
       TZE RESET+1   OK IF ZERO
       REM           
       REM           
       REM           
       LXD FREE,4    PROGRAM OUT OF 
       TTR SPACE     SEQUENCE.
       REM           
       REM           
 RESET SLF           LIGHTS OUT
       SXD MONIT,4   MONITOR
       LDC MONIT,4   
       TXI *+1,4,1   FOR RETURN
       SXA EXIT,4    
       PXD           CLEAR ACC
       STO           CLEAR ZERO
       LDQ           CLEAR MQ
       TOV *+1       TURN OFF 
       NOP           
       DCT           
       NOP           
       PAI           RESET
       LXD 0,7       CLEAR XRA,XRB,XRC
 EXIT  TRA           RETURN TO PROG.
 PART2 SLF           LIGHTS OUT
       SLN 4         4 ON
       TRA CLEAR+1   CLEAR
 PART3 SLF           LIGHTS OUT
       SLN 3         LIGHT 3 ON
       TRA PART2+1   4 ON AND CLEAR
       REM           
       REM           
       REM           SET MONITOR
 START AXT ERROR-2-WOW,1
       CLA CATCH     L TSX SPACE,4
 BURMA STO ERROR-1,1 
       TIX BURMA,1,1 
       AXT 32767-JJJ,1 FILL UP
 SHAVE STO 0,1       UPPER STORAGE
       TIX SHAVE,1,1 
       TRA 24        BEGIN 9M05A
 DONE  SWT 6         TEST 6
       TRA BBB       FINISHED
       TRA FFF       GO TO TEST SENSE SWITCH 3
       REM           
       REM           
       REM           
       REM           
 BBB   TSX RESET,4   CLEARN UP AND GO
       CLA *-2       POST RESTART
       STO           AT ZERO.
       RCDA          SELECT CARD READER
       RCHA WOW      PUSH LOAD
       LCHA          BUTTON
       TTR 1         
       REM           
 PRINT SWT 3         TEST SENSE SWITCH 3
       TRA *+2       IDENTIFY PROGRAM
       TRA START     
       AXT 11,1      L13 IN XRA
       WPRA          SELECT PRINTER
       SPRA 3        SPACE PRINTER
       RCHA MMM      PRINT NOW PERFORMING
       LCHA MMM+1    
       LCHA MMM+2    
       LCHA MMM+1    
       CLA MMM+2     
       SUB HHH       L+2
       STA MMM+2     
       TIX *-5,1,1   
       TRA START     
       REM           
 MMM   IOCT TTT,0,1  
       IOCT K0,0,1   
       IOCT TTT+2,0,1 
       IOCT TTT+3,0,1 
       REM           
       REM           
 WOW   OCT -100003000000 S AND 2 ON,WC#3
       REM           
       REM           
       REM           
       REM           
*TRACING ROUTINE FOR 9M05
       REM           
       REM           
       ORG WOW+1     
 TRACE CLA OK        INTERCPET
       STO MOVE      EACH
       CLA MODE-1    
       STO OK        
       CLA SHAKE     
       STO DONE      
       TXI SHAVE+2   
       TTR SAVE      
       REM           
 MODE  SXD *-2,4     
       LDC *-3,4     
       SXA GUTS,4    
       LDC MONIT,4   
       SXD GUTS,4    
       AXT 20,4      CLEAR CARD
       STZ PTR+16,4  IMAGE
       TIX *-1,4,1   
       STZ BIX       CLEAR BIT INDEX
       LDQ GUTS      
       WPRA          
       AXT 5,2       
       AXT 2,1       
       CLA MODE-2    
       STP BIX       
       PXD           
       LGL 3         
 1RST  PXD           
       LGL 3         
       ALS 1         
       SUB ZL        
       STA *+2       
       CLA BIX       
       ORS PTR       
       ARS 1         
       STO BIX       
       TIX 1RST,2,1  
       TNX BLOOD-1,1,1
       ARS 7         
       STO BIX       
       AXT 5,2       
       TRA 1RST-2    
       REM           
       RCHA LINE     
 BLOOD AXT 0,1       
       AXT 0,2       
       AXT 0,4       
       CLA PREF      
       LDQ PREF+1    
       LLS 35        
       LDQ PREF+2    
       TOV *+1       
       TCOA *        
 MOVE  HTR           
       TTR OK+1      EXIT
       REM           
 SAVE  SXA BLOOD,1   ENTRY
       SXA BLOOD+1,2 
       SXA BLOOD+2,4 
       STQ PREF+2    
       LRS 35        
       STQ PREF+1    
       STA PREF      
       TTR MODE      PRINT
 SHAKE TRA SHAKE+1   
       CLA MOVE      RESTORE OK
       STO OK        
       CLA RATLE     RESTORE DONE
       STO DONE      
       TTR START     RESTART 9M05 AND
 RATLE SWT 6         ERASE TRACE
       REM           
       REM           CONSTANTS
 PREF  BSS 3         
 GUTS  HTR           
 BIX   HTR           
 LINE  HTR NO,0,20   CONTROL WORD
 ZL    HTR PTR+14    
 NO    BSS 4         
 PTR   BSS 16        CARD IMAGE
       REM           
 ERROR EQU 3396      6504 OCTAL
 OK    EQU 3401      6511 OCTAL
 PR    EQU 4032      7700
 M     EQU 4         
       REM           
       REM           
       ORG 4043      
 FFF   SWT 3         TEST SENSE SWITCH 3
       TRA *+2       COUNT PASSES
 RRR   TRA 24        REPEAT PROGRAM
       CLA HHH+1     COUNT OF 10 DECIMAL
       SUB HHH+2     L+1
       STO HHH+1     STORE IN COUNT
       TNZ RRR       REPEAT TEST TILL ZERO
       CLA HHH+3     RESET
       STO HHH+1     COUNTER
       REM           
       AXT 11,1      
       WPRA          SELECT PRINTER
       SPRA 3        SPACE PRINTER
       RCHA MMM+1    PRINT NOW PERFORMING
       LCHA GGG      
       LCHA MMM+1    
       LCHA GGG+1    
       CLA GGG+1     
       SUB HHH       L+2
       STA GGG+1     
       TIX *-5,1,1   
       CLA MMM+3     RESTORE CONTROL WORD
       STO GGG+1     
       TRA 24        REPEAT PROGRAM
       REM           
 GGG   IOCT TTT+1,0,1 
       IOCT TTT+3,0,1 
       REM           
*      PRINT IMAGE   
       REM           
 TTT   OCT 450201100        9L
       OCT 01100000020      9R
       OCT 0                8L
       OCT 0                8R
       OCT 2002040000       7L
       OCT 2204002000       7R
       OCT 30300010000      6L
       OCT 400010000        6R
       OCT 41004020010      5L
       OCT 200502           5R
       OCT 20400040         4L
       OCT 20004010         4R
       OCT 2400             3L
       OCT 21200            3R
       OCT 4000             2L
       OCT 1500000          2R
       OCT 100000           1L
       OCT 20042000000      1R
       OCT 10000006020      0L
       OCT 10001500204      0R
       OCT 62564030040     11L
       OCT 3524017010      11R
       OCT 1212741400      12L
       OCT 242220500       12R
       REM           
 HHH   OCT 2         
       OCT 12        
       OCT 1         
 JJJ   OCT 12        
       END PRINT     
