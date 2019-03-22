                                                             9PACC          
                                                            20APR60        
       REM            
       REM            
       REM            
*                              9 P A C C      
       REM            
       REM            
       ORG 1          
       TSX SPACE,4    
       TSX SPACE,4    FOR
       TSX SPACE,4     MONITOR
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    FOR
       TSX SPACE,4    MONITOR
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    FOR
       TSX SPACE,4     MONITOR
       TSX SPACE,4    
       TSX SPACE,4    
       REM            
       CLA RSTRT      POST RESTART
       STO 0          AT ZERO
       REM            
       TSX PANEL,4    TEST FOR CORRECT BOARD
       REM            
       SWT 5          CHECK FOR MANUAL
       TRA HEY-1      AUTO
       TRA BUNG       MANUAL
       REM            
RSTRT  TRA 24         
       REM            
       TRA HEY        PROCEED
       REM            
HEY    TSX RESET,4    
       REM            
       TSX SPLOK,4    
       HTR 4,,24      
       BCD 49PACC CLOCK TEST BEGINS
       REM            
       RPRA           
       SPRA 1         EXTRA SPACE
       SPRA 5         RESET
       TSX SPLOK+1,4  
       HTR 7,,10      
       BCD 4TEST RESET AND TRY TO RE
       BCD 3AD BACK ZEROS.
       REM            
       SWT 2          
       TRA *+2        
       TRA HEY3       SKIP ERROR CHECK
       RPRA           
       SPRA 4         READ OUT
       REM            
       TSX SPLOK+1,4  
       HTR 7,,10      
       BCD 4READ OUT AFTER RESET AND
       BCD 3CHECK FOR ZERO.
       REM            
       CAL ECHO       
       TZE HEY2       
       SLW HEY1       PUT ERROR WORD IN IMAGE
       RPRA           
       SPRA 1         EXTRA SPACE
       REM            
       TSX SPLOK+1,4  
       HTR 10,,1      
       BCD 4READ OUT AFTER RESET SHO
       BCD 3ULD HAVE ZERO GOT
HEY1   BCD 3000000 -INSTEAD
       REM            
       WPRA           
       SPRA 2         SKIP TO ONE
       TCOA *         
       HTR HEY3       ERR IN RESET
       REM            
HEY2   TSX HECK,4     CHECK FOR 8-3, 8-4 ECHOS.
       REM            
       HPR HEY        8-3, 8-4 ECHOS
       REM            THE CLOCK
       REM            
       REM            
HEY3   SWT 1          
       TRA DADY       PROCEED OR
       TRA HEY        REPEAT
       REM            
       REM READ IN ALL ZEROS TO CLOCK
       REM            
DADY   TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1000000    
       HTR *+3        ERR IN RI
       TSX HECK,4     CHECK 8-3, 8-4 ECHOS
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA I          PROCEED OR
       TRA DADY       REPEAT
       REM            
       REM            
       REM READ IN ALL ONES TO CLOCK
       REM            
I      TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1111111    
       HTR *+3        ERR IN RI
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA WANA       PROCEED OR
       TRA I          REPEAT
       REM            
       REM            
       REM READ IN ALL 2-S TO CLOCK
       REM            
WANA   TSX CLEAR, 4   
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1222222    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHOS
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA DIA        PROCEED OR
       TRA WANA       REPEAT
       REM            
       REM            
       REM READ IN ALL 3-S TO CLOCK
       REM            
DIA    TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1333333    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA MOND       PROCEED OR
       TRA DIA        REPEAT
       REM            
       REM            
       REM READ IN ALL 4-S TO CLOCK
       REM            
MOND   TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1444444    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA RING       PROCEED OR
       TRA MOND       REPEAT
       REM            
       REM            
       REM READ IN ALL 5-S TO CLOCK
       REM            
RING   TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1555555    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA BRACE      PROCEED OR
       TRA RING       REPEAT
       REM            
       REM            
       REM READ IN ALL 6-S TO CLOCK
       REM            
BRACE  TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1666666    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA LETS       PROCEED OR
       TRA BRACE      REPEAT
       REM            
       REM            
       REM READ IN ALL 7-S TO CLOCK
       REM            
LETS   TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1777777    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA EVERY      PROCEED OR
       TRA LETS       REPEAT
       REM            
       REM            
       REM READ IN ALL 8-S TO CLOCK
       REM            
EVERY  TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1888888    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA THING      PROCEED OR
       TRA EVERY      REPEAT
       REM            
       REM            
       REM READ IN ALL 9-S TO CLOCK
       REM            
THING  TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1999999    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA YOU        PROCEED OR
       TRA THING      REPEAT
       REM            
       REM            
       REM READ IN ALL 1-6 TO CLOCK
       REM            
YOU    TSX CLEAR,4    
       REM            
       TSX DIRTY,4    PRINT CONTROL
       BCD 1123456    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA GOTA       PROCEED OR
       TRA YOU        REPEAT
       REM            
       REM READ IN ALL 9-4 TO CLOCK
       REM            
GOTA   TSX CLEAR,4    
       TSX DIRTY,4    PRINT CONTROL
       BCD 1987654    
       HTR *+3        ERR IN RI
       REM            
       TSX HECK,4     CHECK 8-4,8-3, ECHO
       REM            
       HPR *-5        8-3, 8-4 ECHOS
       SWT 1          
       TRA GET        PROCEED OR
       TRA GOTA       REPEAT
       REM            
       REM CHECK FOR NO READ OUT ON RESET
       REM            
GET    TSX CLEAR,4    
       REM            
       RPRA           
       SPRA 1         EXTRA SPACE
       SPRA 5         RESET
       REM            
       TSX SPLOK+1,4  
       HTR 5,,1       
       BCD 5CHECK FOR NO READ OUT ON RESET
       SWT 2          
       TRA *+2        CHECK FOR ERR
       TRA GET1       SKIP ERR CHECK
       CAL ECHO       
       TZE GET1       OK IF ZERO.
       SLW *+3        ERR WORD TO IMAGE
       REM            
       TSX SPLOK,4    
       HTR 11,1       
       BCD 5000000, READ DURING RESET. R-1
       BCD 596 SHOULD PREVENT READ OUT ON
       BCD 1RESET.    
       REM            
       WPRA           
       SPRA 2         SKIP TO ONE
       HPR GET        READ-OUT DURING RESET
       REM            
GET1   SWT 1          
       TRA THE        PROCEED OR
       TRA GET        REPEAT.
       REM            
       REM            
       REM CHECK READ OUT DURING READ IN
       REM            
THE    TSX CLEAR,4    
       REM            
       RPRA           
       SPRA 1         EXTRA SPACE
       SPRA 3         READ IN
       REM            
       TSX SPLOK+1,4  
       HTR 7,,1       
       BCD 4345678-- CHECK READ OUT
       BCD 3DURING READ IN.
       REM            
       SWT 2          
       TRA *+2        CHECK
       TRA THE1       SKIP ERR CHECK
       REM            
       CAL ECHO       
       TZE THE1       OK IF ZERO
       SLW *+3        
       REM            
       TSX SPLOK,4    
       HTR 12,,1      
       BCD 6000000, READ BACK DURING READ IN. R-
       BCD 6204 SHOULD BLOCK READ-OUT ON READ-IN
       REM            
       WPRA           
       SPRA 2         SKIP TO ONE
       HPR THE        RO DURING RI
       REM            
THE1   SWT 1          
       TRA BEST       PROCEED OR
       TRA THE        REPEAT
       REM            
       REM SIMULTANEOUS READ IN AND READ OUT
       REM PULSE. SHOULD NOT GET READ OUT EXIT.
       REM            
BEST   TSX CLEAR,4    
       REM            
       RPRA           
       SPRA 1         EXTRA SPACE
       SPRA 3         READ IN
       SPRA 4         READ OUT
       REM            
       TSX SPLOK+1,4  
       HTR 11,,1      
       BCD 5555555, READ IN AND READ OUT S
       BCD 6IMULTANEOUSLY, SHOULD NOT GET ECHOS.
       REM            
       SWT 2          
       TRA *+2        CHECK
       TRA BEST1      SKIP ERR CHECK
       REM            
       CAL ECHO       
       TZE BEST1      OK IF ZERO
       SLW *+3        
       REM            
       TSX SPLOK,4    
       HTR 11,,1      
       BCD 4000000 READ FROM CLOCK.
       BCD 5R-204 SHOULD HAVE SUPPRESSED R
       BCD 2EAD-OUT.  
       REM            
       WPRA           
       SPRA 2         SKIP TO ONE
       HPR BEST       RO DURING RI-RO SIMULTA.
       REM            
BEST1  SWT 1          
       TRA FOR        PROCEED OR
       TRA BEST       REPEAT
       REM DIRECT ADD, RI WITHOUT RESET.
FOR    TSX CLEAR,4    
       REM            
       WPRA           
       SPRA 5         RESET
       REM            
       RPRA           
       SPRA 3         READ IN
       TSX SPLOK+1,4  
       HTR 8,,1       
       BCD 4345678 TO READ IN THEN,
       BCD 4WITHOUT RESET, READ IN-
       REM            
       RPRA           
       SPRA 3         READ IN
       TSX SPLOK+1,4  
       HTR 5,,1       
       BCD 5531975,, SHOULD GET 876543
       REM            
       SWT 2          
       TRA *+2        CHECK
       TRA FOR1       SKIP ERR CHECK
       RPRA           
       SPRA 4         READ OUT
       REM            
       TSX SPLOK+1,4  
       HTR 4,,10      
       BCD 4READ OUT CLOCK TO CHECK.
       REM            
       CLA ECHO       
       CAS FOR2       
       TRA *+2        ERR
       TRA FOR1          OK
       STO *+3        ERR
       REM            
       TSX SPLOK,4    
       HTR 8,,1       
       BCD 4000000 READ FROM CLOCK,
       BCD 3SHOULD HAVE BEEN..
FOR2   BCD 1876543    
       WPRA           
       SPRA 2         SKIP TO ONE
       HPR FOR        ERR IN SUCCESSIVE RI.
       REM            
FOR1   SWT 1          
       TRA ME         PROCEED OR
       TRA FOR        REPEAT
       REM            
       REM            
       REM CARRY TEST, CARRY FROM 999 TO 1000
       REM            
ME     TSX CLEAR,4    
       REM            
KEYS   ENK 4          DETERMINE TIMING OF LOOP
       XCL            
       PBT            WHICH MACHINE
       TRA NINTY      7090
       REM            
       ALS 1          709
       PBT            WHICH CLOCK
       REM            
       TRA *+7        
       AXT 63,2       709 .1 MIN CLOCK
       ALS 1          
       REM            
       PBT            CHECK FOR ILLEGALE ENTRY
       TRA TIME       
       TRA DOPE       
       TRA TIME       
       REM            
       ALS 1          
       PBT            
       TRA *+3        
       AXT 375,2      709 .01 HOUR CLOCK
       TRA TIME       
       AXT 7,2        709 .01 MIN CLOCK
       TRA TIME       
       REM            
NINTY  ALS 1          
       PBT            
       TRA *+7        
       AXT 350,2      7090 .1 MIN CLOCK
       ALS 1          
       REM            
       PBT            CHECK FOR ILLEGAL ENTRY
       TRA TIME       
       TRA DOPE       
       TRA TIME       
       REM            
       ALS 1          
       PBT            
       TRA *+3        
       AXT 2100,2     7090 .01 HOUR CLOCK
       TRA TIME       
       AXT 35,2       7090 .01 MIN CLOCK
       REM            
TIME   TOV *+1        TURN OFF LIGHT
       SXA TIME2,2    SET NEXT TIMING LOOP
       REM            
       WPRA           
       SPRA 5         RESET
       REM            
       RPRA           
       SPRA 3         READ IN
       REM            
       TSX SPLOK+1,4  
       HTR 11,,1      
       BCD 3000999 TO READ IN,
       BCD 4 NOW WAIT FOR A COUNT PU
       BCD 4LSE AND CHECK FOR CARRY.
       REM            
       AXT 4000,1     
       TIX *,1,1      WAIT FOR CLOCK PULSE
       TIX *-2,2,1    
       AXT 3440,1     EXTRA 15 MSEC DELAY TO
       TIX *,1,1      ALLOW TIME FOR CARRY
       REM            
       RPRA           
       SPRA 4         READ OUT
       REM            
       TSX SPLOK+1,4  
       HTR 6,,10      
       BCD 4READ CLOCK AND CHECK FOR
       BCD 2 CARRY.   
       REM            
       SWT 2          
       TRA *+2        CHECK
       TRA ME2        SKIP ERR CHECK
       CAL ECHO       WORD FROM CLOCK
       LAS CARY       CHECK
       TRA *+2        
       TRA ME2        OK
       REM            
       LAS CARY+1     COULD HAVE 2 COUNTS.
       TRA *+2        NG
       TRA ME2        OK
       SLW *+3        
       REM            
       TSX SPLOK,4    
       HTR 10,,1      
       BCD 4000000 READ BACK AFTER C
       BCD 4ARRY TEST. SHOULD BE 100
       BCD 20 OR 1001. 
       REM            
       WPRA           
       SPRA 2         SKIP TO ONE
       HPR ME         ERR IN CARRY TO THOUSANDS
ME2    SWT 1          
       TRA CA2        PROCEED OR
       TRA ME         REPEAT
       REM            
       REM CARRY TO ZERO FROM ALL NINES.
       REM            
CA2    TSX CLEAR,4    
       REM            
       WPRA           
       SPRA 5         RESET
       REM            
       RPRA           
       SPRA 3         READ IN
       TSX SPLOK+1,4  
       HTR 7,,1       
       BCD 4999999 TO CLOCK, ALLOW A
       BCD 3 CARRY TO ZERO.
       REM            
TIME2  AXT 0,2        
       AXT 4000,1     
       TIX *,1,1      WAIT FOR CLOCK PULSE
       TIX *-2,2,1    
       AXT 6880,1     EXTRA 30 MSEC DELAY TO
       TIX *,1,1      ALLOW TIME FOR CARRY
       REM            
       REM            
       RPRA           
       SPRA 4         READ OUT
       TSX SPLOK+1,4  
       HTR 6,,10      
       BCD 6READ BACK CLOCK AND CHECK CARRY
       REM            
       SWT 2          
       TRA *+2        CHECK
       TRA CA21       SKIP ERR CHECK
       REM            
       CAL ECHO       WORD FROM CLOCK
       TZE CA21       OK IF ZERO
       LAS CARY-1     OR IF 000001
       TRA *+2        NG
       TRA CA21        OK
       SLW *+3        
       TSX SPLOK,4    
       HTR 9,,1       
       BCD 4000000 READ AFTER CARRY
       BCD 4TEST, SHOULD BE ZERO OR
       BCD 1000001    
       REM            
       WPRA           
       SPRA 2         SKIP TO ONE
       HPR CA2        ERR IN CARRY TO ZERO
       REM            
CA21   SWT 1          
       TRA COUNT      PROCEED OR
       TRA CA2          REPEAT
       REM            
       REM            
       REM MANUAL COUNT TEST-OPERATES
       REM AUTOMATICALLY ON FIRST PROGRAM
       REM PASS, THEREAFTER ONLY IF
       REM TRANSFERRED TO MANUALLY.
       REM            
       REM COUNTS UNTIL SWITCH 4 GOES UP.
       REM            
COUNT  TSX CLEAR,4    
       REM            
       CAL *+3        WORKS FOR
       SLW *-1         FIRST PASS
       TRA CT           ONLY
       TRA END        
       REM            
CT     WPRA           
       SPRA 1         EXTRA SPACE
       REM            
       TSX SPLAT,4    
       HTR 7,,1       
       BCD 3MANUAL COUNT TEST.
       BCD 4PRESS START TO BEGIN.
       REM            
       TSX SPLAT,4    
       HTR 8,,1       
       BCD 4COUNTING WILL BEGIN WHEN
       BCD 4 SENSE LITE 4 GOES ON.
       TSX SPLAT,4    
       HTR 8,,1       
       BCD 4AND WILL CONTINUE UNTIL
       BCD 4 SWITCH 4 IS PUT UP.
       WPRA           
       SPRA 2         SKIP TO ONE
       REM            
       HPR            
       REM PUT SWITCH 4 DOWN, AND PRESS
       REM START TO BEGIN COUNTING. COUNTING
       REM BEGINS WHEN LITE 4 GOES ON,
       REM AND CONTINUES UNTIL SSW4 IS PUT UP.
       SLF            
       WPRA           
       SPRA 5         RESET
       WPRA           WAIT FOR DISCONNECT
       TCOA *         
       SLN 4          BEGIN
       REM            
       SWT 4          
       TRA *+2        STOP
       TRA *-2        CONTINUE UNTIL SSW4 IS UP.
       REM            
       WPRA           
       SPRA 4         READ OUT
       TSX SPLAT+1,4  
       HTR 9,,1       
       BCD 4COUNT OVER, VALUE FROM
       BCD 5CLOCK APPEARS TO THE RIGHT.
       REM            
       WPRA           
       SLF            
END    WPRA           
       SPRA 1         EXTRA SPACE
       TSX SPLAT+1,4  
       PZE 6,,15      
       BCD 6*** 9PACC  PASS COMPLETE  9PACC ***
       WPRA           
       SPRA 2         SKIP TO ONE
       REM            
       SWT 6          
       TRA *+2        
       TRA HEY        REPEAT PROGRAM.
       REM            
       RCDA           LOAD
       RCHA *+3          CARDS
       LCHA 0              BUTTON
       TTR 1          
       IOCT 0,,3      
       REM            
       REM SET UP ECHO PROGRAMME
       REM            
SPLOK  RPRA           
       CAL KK         
       SLW SPLAT+60   
       TRA SPLAT+1    
       REM            
DOPE   WPRA           
       TSX SPLAT,4    
       PZE 9,,10      
       BCD 6ILLEGAL KEY ENTRY      TRY ONE OF TH
       BCD 3ESE ON S, 1 AND 2.
       WPRA           
       REM            
       TSX SPLAT,4    
       PZE 5,,25      
       BCD 5.01 MIN   .1 MIN   .01 HOUR
       REM            
       TSX SPLAT,4    
       PZE 6,,19      
       BCD 6 7090   000        010       001
       REM            
       TSX SPLAT,4    
       PZE 6,,19      
       BCD 6 709    100        110       101
       HTR ME+1       
       REM            
       REM TEST FOR PANEL
       REM            
PANEL  RPRA           
       SPRA 6         PULSE SENSE ENTRY HUB
       SPTA           
       TRA *+2        
       TRA 1,4        OK
       TCOA *-3       KEEP TRYING
       TSX SPLAT,4    
       HTR 6,,1       
       BCD 4PLEASE PUT IN PRINTER BO
       BCD 2ARD FOR 9PAC
       REM            
       HTR 24         WRONG PRINTER BOARD.
       REM            
       REM            
       REM MANUAL ENTERY PROGRAMME
       REM            
       HPR BUNG       
BUNG   TSX RESET,4    
       HPR BUNG       ENTER BCD WORD IN KEYS
       ENK            
       STQ BANG       
       STQ BONG       
       WPRA           
       SPRA 5         RESET
       REM            
       TSX SPLAT+1,4  
       HTR 12,,1      
       BCD 3YOU HAVE ASKED ..
BANG   BCD 6000000 BE READ IN TO CLOCK-IT
       BCD 3SHALL BE DONE.
       REM
       TSX DIRTY,4    
BONG   BCD 1000000   WORD FROM KEYS
       HTR *+3        ERR IN RI
       TSX HECK,4     
       HPR BONG       8-3, 8-4 ECHOS.
       REM            
       REM            
       SWT 1          
       HTR BUNG+1     SET AND WAIT.
       TRA BONG-1     CONTINUE
       REM            
       REM SUBROUTINE TO READ-IN TO CLOCK
       REM AND THEN READ BACK TO CHECK.
       REM            
DIRTY  WPRA           
       SPRA 5         RESET
       SXA FEET,4     
       CAL 1,4        WORD TO READ IN
       SLW SOX        PLACE IN IMAGE
       SLW BARE+4     
       RPRA           
       SPRA 3         READ IN
       REM            
       TSX SPLOK+1,4  
       HTR 5,,1       
SOX    BCD 5000000 TO READ IN TO CLOCK.
       REM            
       SWT 2          
       TRA *+3        CHECK
       LXA FEET,4     SKIP
       TRA 5,4          ERR CHECK
       REM            
       RPRA           
       SPRA 4         READ OUT
       TSX SPLOK+1,4  
       HTR 5,,10      
       BCD 4READ BACK FROM CLOCK TO
       BCD 1CHECK.    
       REM            
       CAL ECHO       WORD FROM CLOCK
       LAS SOX        CHECK
       TRA *+2        
       TRA FEET       OK
       SLW BARE       ERR WORD TO IMAGE
       REM            
       TSX SPLOK,4    
       HTR 8,,10      
       BCD 2READ BACK...
BARE   BCD 1000000    
       BCD 3 SHOULD HAVE BEEN
       BCD 2000000.   
       WPRA           
       SPRA 2         SKIP TO ONE
       LXA FEET,4     
       TRA 2,4        ERROR RETURN
       REM            
       REM            
FEET   AXT 0,4        
       TRA 3,4        EXIT
       REM            
STRIP  RCHA IPR       PRINT DIGITS
       AXT 6,2        
       STZ COL6+1,2   CLEAR ECHO IMAGE
       REM            
       TIX *-1,2,1    
       REM            
       LCHA GO-2      GET + AND - ECHO
       AXT 4,1        
       PXD 0,0        CLEAR ACCUMULATOR
       ORA 84E+4,1    
       TIX *-1,1,1    
       ANA 6COLS      6 COLS ONLY
       TZE *+2        
       SLN 1          ERR SHOULD NOT GET +/- ECHO.
       AXT 9,2        SET UP FOR TRANSLATION
       REM            
       REM            
       LCHA GO+9,2    SYNCHRONIZE, MAN.
       REM            
       AXT 6,1        6 COLS
       LDQ E          9 ROW ECHO, ETC.
       PXD 0,0        CLEAR ACCUMULATOR
       LGL 1          1 COL.
       LBT            
       TRA *+3        SKIP FOR NO BIT
       CAL NINE+9,2   BCD CHARACTER FOR THIS ROW
       SLW COL6+1,1   ECHO IMAGE
       TIX *-6,1,1    NEXT COL
       TIX *-10,2,1   NEXT ROW
       REM            
       AXT 6,1        MAKE ECHO WORD
       PXD 0,0        CLEAR ACCUMULATOR
       ALS 6          MOVE IT ON OVER
       ORA COL6+1,1   LITTLE DAWG.
       TIX *-2,1,1    
       SLW ECHO       
       REM            
       REM            
       CAL KK+1       RESTORE
       SLW SPLAT+60       SPLAT
       TRA SPLAT+61   EXIT
       REM            
NINE   BCD 1000009    
       BCD 1000008    
       BCD 1000007    
       BCD 1000006    
       BCD 1000005    
       BCD 1000004    
       BCD 1000003    
       BCD 1000002    
       BCD 1000001    
       REM            
CARY   BCD 1001000    
       BCD 1001001    
       REM            
IPR    IOCP 9RL,,18   
       IOCP 84E,,2    
       IOCP ORL,,2    
       IOCT 83E,,2    
       IOCP 11RL,,2   
       IOCT E,,2      9 ROW ECHO
       REM            
GO     TCH COL1-2     GET 12RL COMMAND
       IOCT E,,2      7 ROW
       IOCT E,,2      6 ROW
       IOCT E,,2      5 ROW
       IOCT E,,2      4 ROW
       IOCT E,,2      3 ROW
       IOCT E,,2      2 ROW
       IOCT E,,2      1 ROW
       IOCD           ROW
       IOCP 12RL,,2   WRITE 12 ROW, THEN
       IOCT E,,2      GET 8 ROW-ECHO
       REM            
COL1   PZE 0          
COL2   PZE 0          
COL3   PZE 0          
COL4   PZE 0          
COL5   PZE 0          
COL6   PZE 0          
       REM            
6COLS  OCT 770000000000
ECHO   PZE 0          
HECK   SLT 1          
       TRA 2,4        
       REM            
       SXA HECK1,4    
       LAC HECK1,4    
       PXA ,4         
       TSX PX,4       
       NOP            
       NOP            
       LGL 2          
       COM            
       LGL 34         
       SLW *+13       
       REM            
       TSX SPLAT,4    
       HTR 11,,1      CONTROL WORD
       BCD 4RECEIVED 8-4, 8-3 ECHOS
       BCD 4FROM THE CLOCK. PROGRAM
       BCD 2ADDRESS ...
       BCD 1000000    
       REM            
       WPRA           
       SPRA 2         SKIP TO ONE
HECK1  AXT 0,4        
       TRA 1,4        
       REM            
       REM            
*         PROGRAMME SEQUENCE AND CONTROL MONITOR.
       REM            
       REM            
CLEAR  SLF            LIGHTS OUT
       SWT 1          
       TRA *+4        NOT REPEATED
       PXD ,4         TEST REPEATED OR
       SUB MONIT      WILL BE REPEATED
       TZE RESET+1    IF ZERO, PROGRAMME
       REM            SEQUENCE OK.
       REM            
       REM            
       REM            
       STZ FREE       
       SXD FREE,4     SAVE ADDRESS
       CLA -1,4       PRECEEDING TEST ADDRESS
       PAC ,4         
       PXD ,4         COMPLEMENT
       SUB MONIT      SHOULD ZERO
       LXD FREE,4     RESTORE XRC
       TZE RESET+1    OK IF ZERO.
       REM            
       REM            
       REM            
       ENK            CHECK FOR MANUAL TRANSFER
       XCA            
       PAC ,4         COMPLEMENT KEYS ADDRESS
       LRS 21         CHECK TRA ONLY
       SUB K41        SUB 0200
       TNZ *+5        SEQUENCE SHOT IF NOT ZERO.
       PXD ,4         OK, CHECK ADDRESS
       SUB FREE       
       LXD FREE,4     RESTORE
       TZE RESET+1    OK IF ZERO
       REM            
       LXD FREE,4     PROGRAM OUT OF SEQUENCE
       TTR SPACE      
       REM            
       REM            
RESET  SLF            LIGHTS OUT
       SXD MONIT,4    MONITOR
       LDC MONIT,4    
       TXI *+1,4,1    
       SXA EXIT,4     FOR RETURN
       PXD 0,0        CLEAR ACCUMULATOR
       LRS 35         
       TOV *+1        
       TQO *+1        OUT
       IOT            OUT-DAMMED SPOT.
       NOP            
       DCT            
       NOP            
       PAI            
       AXT ,7         
EXIT   TRA **         
       REM            
       REM            
SPACE  SXD BIN,4      
       LDC BIN,4      
       PXA ,4         
       TSX PX,4       
       NOP            
       NOP            
       STQ POT        
       LDC MONIT,4    
       PXA ,4         
       TSX PX,4       
       NOP            
       NOP            
       STQ PAT        
       REM            
       TSX SPLAT,4    
       HTR 9,,1       
       BCD 5MONITOR. PROGRAMME SKIP TO..
POT    BCD 3000000, RETURN TO..
PAT    BCD 1000000    
       SXA *+5,2      SAVE.
       LXD MONIT,4    
       CLA -1,4       RESET
       PAC ,2          MONITOR
       SXD MONIT,2    
       AXT ,2         RESTORE XRB
       TRA ,4         RETURN
       REM            
START  AXT SPLAT-2-WOW,1
       CLA CATCH      
BURMA  STO SPLAT,1    
       TIX BURMA,1,1  
       AXT 32767-PR,1 FILL-ER UP
SHAVE  STO ,1         
       TIX SHAVE,1,1  
       TRA 24         COMMENCE
       REM            
KK     TRA STRIP      
       RCHA SPLAT+84  
       REM            
CATCH  TSX SPACE,4    
K41    OCT 200        
       REM            
84E    BSS 2          
83E    BSS 2          
E      BSS 2          
MONIT  BSS 1          
BIN    BSS 1          
WOW    BSS 1          
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
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM           INDEXABLE BCD PRINT SUBROUTINE.
       REM
*THIS  SUBROUTINE USES THREE SYMBOLS, THEY ARE...
       REM
       REM           SPLAT, THE FIRST WORD OF THE ROUTINE
       REM
       REM           CI, USED FOR CARD IMAGE, 26 LOCATION
       REM
       REM           SUBET, THE CONTENTS OF XRC ARE STORED
       REM                     IN THE ADDRESS OF SUBET.
       REM
*CONDTION  OF THE ACC, MQ, AND ACC OVERFLOW
*TRIGGER  IS NOT GUARANTEED ON EXIT FROM THIS ROUTINE.
       REM
       REM           THE PRINTER ON CHANNEL A IS USED
       REM           YOU MAY ENTER SPLAT+1 IF YOU HAVE
       REM           ALREADY GIVEN WRIT SELECT.
       REM
       REM           THE RCHA INSTRUCTION IS AT SPLAT+60.
       REM
       REM           THERE IS NO CHANNEL DELAY IN THE
       REM           SUBROUTINE, THEREFORE TAKE CARE NOT
       REM           TO USE CI UNTIL AFTER 12 ROW-RIGTH
       REM           HAS BEEN WRITTEN. FOR THIS REASON,
       REM           YOU MUST GIVE WRS FOR EACH ENTRY
       REM           OR ENTER AT SPLAT.
       REM
       REM
       ORG 3392       
SPLAT  WPRA          GET GOING
       SXA SPLAT+61,1 
       SXA SPLAT+62,2 
       SXA SUBET,4   SAVE ORGINAL XRC.
       NZT 1,4       IF CONTROL WORD ZERO.
       REM            
*5                    
       TRA 2,4       RETURN
       REM
       CAL 1,4       GET NON-ZERO WORD
       SLW SPLAT+85  SAVE CONTROL WORD
       PDX 0,1       TYPE WHEEL NO.
       TXL SPLAT+65,1,0 IF DECR. ZERO, GET
       REM           NEW CONTROL WORD
       REM            
*10                   
       SXD *+2,4     GET EXIT ADDRESS
       PAC 0,2       BY ADDING TWOS COMP.
       TXI *+1,2,0   OF N TO XRC.
       SXA SPLAT+63,2 EXIT VALUE.
       REM
       REM SET BIT INDEX TO STARTING WHEEL
       REM
       SXA *+3,1     FOR SHIFTING
       REM            
*15                   
       AXT 1,3       1 TO XRA AND XRB
       CAL SPLAT+82  BIT INDEX TO P
       LGR 0,1       SHIFT TO STARTING POINT
       TNZ *+3       IF ACC IS ZERO, SET FOR
       STQ SPLAT+83  RIGHT ROW, AND MAKE
       REM            
*20                   
       TXI *+2,2,1   XRB A DUECE
       SLW SPLAT+83  OTHERWISE, LEFT ROW.
       AXT 26,1       
       STZ CI+26,1   CLEAR CARD IMAGE
       TIX *-1,1,1    
       REM
       REM            
       REM FORM CARD IMAGE.
       REM            
*25                   
       TIX *+1,4,1   ADDRESS OF FIRST WORD.
       AXT 6,1       CHARACTER COUNT.
       LDQ 1,4       GET THE WORD.
       REM           SOME PEOPLE NEVER
       REM           DO, YOU KNOW
       REM
       SXA SPLAT+54,1 SAVE CHARACTER COUNT.
       PXD           CLEAR ACC
       REM            
*30                   
       LGL 2         ZONE
       ALS 1         TIMES 2
       PAX 0,1        
       SXA SPLAT+45,1 FOR FUTURE REFERENCE.
       CLM            
       REM            
*35                   
       LGL 4         DIGIT
       ALS 1         TIMES 2
       SLW CI        TEMP0
       CAL SPLAT+83  BIT INDEX
       NZT CI        IS DIGIT ZERO.
       REM            
*40                   
       TXH SPLAT+80,1,0 IS ZERO ZONE TOO.
       LXA CI,1      OK, PROCEED
       TXH SPLAT+48,1,24 CHECK FOR ILLEGAL
       TXH SPLAT+78,1,20 SPECIAL CHARACTER.
       ORS* SPLAT+92,2 XRB PICKS LEFT OR RIGHT.
       REM            
*45                   
       AXT 0,1       ZONE AGAIN.
       TXL *+2,1,0   NOTHING FOR ZERO ZONE
       ORS* SPLAT+90,2 PLACE ZONE BIT.
       REM            
       REM  COLUMN SET.
       REM            
       ARS 1         SET BIT INDEX TO 
       TNZ *+4       NEXT COLUMN, IF ANY.
       REM            
*50                   
       TXH SPLAT+60,2,1 IF BX ZERO,+XRB 1, STOP
       REM            
       CAL SPLAT+82  IF NOT, SET TO RIGHT
       TXI *+1,2,1   ROW AND PROCEED.
       SLW SPLAT+83  BX READY FOR NEXT COLUMN.
       AXT 0,1       MORE CHARACTERS.
       REM            
*55                   
       TIX SPLAT+28,1,1 NEXT COLUMN
       LXA SPLAT+85,1 MORE WORDS MAYBE.
       TNX *+3,1,1    IF NOT, STOP.
       SXA SPLAT+85,1 YUMMY, GO GET EM.
       TXI SPLAT+25   
       REM            
       REM FIFTEEN MEN ON A DEAD MANS CHEST.
       REM            
*60                   
       RCHA SPLAT+84  LET HER RIP
       AXT 0,1        
       AXT 0,2        
       AXT 0,4        
       TRA 2,4         EXIT
       REM          
       REM          
       REM  GET NEW CONTROL WORD FROM SOMPLACE
       REM            
       REM            
*65                   
       SXA SPLAT+63,4 FOR EXIT
       LXA SPLAT+61,1 RESTORE XRA
       NZT* SPLAT+85 IF CONTROL WORD ZERO
       TRA SPLAT+61  RETURN.
       CAL SPLAT+85  OLD CONTROL WORD
       REM            
*70                   
       STT *+1       BRING OUT INDEX
       SXD *+2,0     REGISTER, IF ONE IS TAGED.
       PAC 0,4        
       TXI *+1,4,0   GET EFFECTIVE ADDRESS.
       CAL 0,4       NEW CONTROL WORD.
       REM            
*75                   
       PDX 0,1       TYPE WHEEL ID.
       SLW SPLAT+85   
       TXI SPLAT+14,4,1 PROCEED
       REM            
       REM YOUR AN OLD SMOOOTHY.
       REM            
       ORS* SPLAT+88,2 PUT EIGTH IN, TAKE
       TIX SPLAT+44,1,16 16 OUTM, - GOOD BUSINESS
       REM            
*80                   
       TXL SPLAT+47,1,4 IF NOT BLANK, SET ZONE.
       TRA SPLAT+48    BLANK.
       REM            
       REM
       MZE             FOR BIT INDEX.
       HTR             DYNAMIC BIT INDEX.
       IOCD CI+2,,24   BUFFER COMMAND
       REM            
*85                   
       HTR             SPECIAL SALON FOR
       REM             THE CONTROL WORD
       HTR CI+5       
       HTR CI+4        BROW ADDRESSES
       HTR CI+27,1    
       HTR CI+26,1     ZONE ROW ADDRESSES
       REM            
*90                   
       HTR CI+21,1    
       HTR CI+20,1     DIGIG ROW ADDRESSES
       REM            
CI     BSS 26         
SUBET  BSS 1          
       REM            
       REM   TO WRITE PUNCH, USE TSX CRNCH,4.
       REM            
CRNCH  WPUA           
       TRA SPLAT+1    
       REM
       REM            
       REM            
*TRANSFORM THE CONTENTS OF ACC 1-35 TO OCTAL IN BCD FORMAT.
*A SIGN CHARACTER FOR MINUX, AND THE Q AND P BITS
*ARE STORED IN THE ADDRESS OF X+1. IF THERE ARE 6
*CHARACTERS OR LESS, RETURN IS MADE TO X+3, OTHER
*WISE, TO X+2. TRANSFORMED WORDS IN MQ AND ACC.
*THIS SUBROUTINE STORES XRC IN SUBET, WHICH MUST BE
*SUPPLIED BY THE PROGRAM. NO BLANKS ARE INSERTED
       REM            
       REM            
PX     SXA PX+24,1    
       SXA PX+25,2    
       SXA SUBET,4    SAVE XRC
       STO FREE       
       ARS 35         P AND Q
       REM            
*5                    
       STA 1,4        P AND Q TO X+1
       LDQ FREE       
       PXD 0,0        CLEAR ACCUMULATOR
       LGL 1          
       ALS 11         SIGN IF MINUS
       REM            
*10                   
       ORS 1,4        SIGN TO X+1
       LGR 1          DROP SIGN
       AXT 6,3        
       PXD 0,0        CLEAR ACCUMULATOR
       ALS 3          ZONE
       REM            
*15                   
       LGL 3          DIGIT
       TIX *-2,1,1    6 TIMES.
       SLW FREE+1     
       PXD 0,0        CLEAR ACCUMULATOR
       ALS 3          ZONE
       REM            
*20                   
       LGL 3          DIGIT
       TIX *-2,2,1    6 TIMES
       XCL            SECOND WORD TO MQ,
       CAL FREE+1     FIRST TO ACC
       AXT 0,1        
       REM            
*25                   
       AXT 0,2        
       TZE 3,4        X+3 FOR 1 WORD.
       TRA 2,4        X+2 FOR 2 WORDS.
       REM            
FREE   BSS 10         
       REM            
       REM CONSTANTS AND STUFF
       REM            
9RL    EQU CI+2       
ORL    EQU CI+2+18    
11RL   EQU ORL+2      
12RL   EQU 11RL+2     
PR     DEC 0          
       REM            
       END START      
                      
