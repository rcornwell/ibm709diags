                                                             9A01A
                                                            12/24/58
*                    9A01A  
*DIAGNOSTIC TEST FOR SPECIAL READ TIME CONTROLS
       REM            
       REM            
       ORG 24         
       REM            
*CHECK THAT THE 16 DRUM SELECTS ON PAGE 7.04 ARE WORKING PROPERLY
       REM            
*WITH SWT 1 DOWN-SYNC ON READ SELECT 1 N08-4 AND SCOPE
*EACH LINE IN ORDER AT THE INDICATED PANEL PINS
       REM            
*OCT-7610000000 IS A DIRECT DATA DISCONNECT INSTRUCTION-5.01.08-
*WHICH BRINGS UP RESET DRUM INTERLOCK-5.09.02-AT A0-D4
       REM            
*THIS LINE COMMING UP TURNS OFF THE DRUM READ AND WRITE SELECT
*TRIGGER ON 5.01.03, THE TWO CRT SELECT TRIGGERS ON 5.01.08, AND
*THE UNIT SELECT TRIGGERS ON 7.01.
       REM            
       REM            
A1     RDR 1          N08-4
       OCT -76100000000 DIRECT DATA DISCONNECT
       WDR 1          N08-8
       OCT -76100000000 DIRECT DATA DISCONNECT
       RDR 2          P08-2
       OCT -76100000000 DIRECT DATA DISCONNECT
       WDR 2          P08-6
       OCT -76100000000 DIRECT DATA DISCONNECT
       RDR 3          Q08-3
       OCT -76100000000 DIRECT DATA DISCONNECT
       WDR 3          Q08-7
       OCT -76100000000 DIRECT DATA DISCONNECT
       RDR 4          Q08-4
       OCT -76100000000 DIRECT DATA DISCONNECT
       WDR 4          R08-5
       OCT -76100000000 DIRECT DATA DISCONNECT
       RDR 5          N10-4
       OCT -76100000000 DIRECT DATA DISCONNECT
       WDR 5          N10-8
       OCT -76100000000 DIRECT DATA DISCONNECT
       RDR 6          P10-2
       OCT -76100000000 DIRECT DATA DISCONNECT
       WDR 6          P10-6
       OCT -76100000000 DIRECT DATA DISCONNECT
       RDR 7          Q10-3
       OCT -76100000000 DIRECT DATA DISCONNECT
       WDR 7          Q10-7
       OCT -76100000000 DIRECT DATA DISCONNECT
       RDR 8          Q10-4
       OCT -76100000000 DIRECT DATA DISCONNECT
       WDR 8          R10-5
       OCT -76100000000 DIRECT DATA DISCONNECT
       REM            
       REM            
       SWT 1          LOOP THE 16 DRUM SELECTS
       TRA *+2        IF DOWN
       TRA A1         
*CHECK THAT THE CPY AND LDA INSTRUCTIONS TURN ON THE
*I-O CHECK LIGHT AND END OPERATION PAGE 5.03.01
       REM            
*TOP LEG OF 1146-D AND MIDDLE LEG OF 1146-G ARE ALWAYS UP
*SO THAT WHENEVER CPY OR LDA WHICH IS PRI. OPN. 46 ARE GIVEN
*THE LINE-I/O CHECK END OPN. CNTL.-COMES UP.
       REM            
       REM            
       OCT -76100000000 DIRECT DATA DISCONNECT
       CPY K1         OCT 0
       IOT            
       TRA *+2        
       HTR *+1        FAILED TO I-O CHECK ON CPY
       OCT -76100000000 DIRECT DATA DISCONNECT
       REM            
       LDA X          OCT 77777777777
       IOT            
       TRA *+2        
       HTR *+1        FAILED TO I-O CHECK ON LDA
       OCT -76100000000 DIRECT DATA DISCONNECT
       REM            
       WDR 1          
       CPY K1         OCT 0
       IOT            
       TRA *+2        
       HTR *+1        FAILED TO I-O CHECK ON
       REM            CPY AFTER WRITE SELECT
       REM            
       OCT -76100000000 DIRECT DATA DISCONNECT
       RDR 1          
       LDA X          OCT 77777777777
       IOT            
       TRA *+2        
       HTR *+1        FAILED TO I-O CHECK ON
       REM            LDA AFTER READ SELECT
       OCT -76100000000 DIRECT DATA DISCONNECT
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
*WITH SWT 2 DOWN CHECK CRT TRIGGERS BY SCOPING-5.01.08
       REM            
*EACH TRIGGER IS TURNED ON BY ITS OWN CRT WRITE SELECT AND BOTH ARE
*TURNED OFF BY-RESET DRUM INTERLOCK-WHICH IS CONDITIONED BY THE 
*-DIRECT DATA DISCONNECT INSTRUCTION-5.09.02
       REM            
       OCT -76100000000 DIRECT DATA DISCONNECT
C      WTV            Q28-4
       OCT -76100000000 DIRECT DATA DISCONNECT
       WTV 1          Q28-6
       OCT -76100000000 DIRECT DATA DISCONNECT
       WTV            
       WTV 1          
       OCT -76100000000 DIRECT DATA DISCONNECT
       WTV 1          
       WTV            
       OCT -76100000000 DIRECT DATA DISCONNECT
       REM            
       REM            
       SWT 2          
       TRA *+2        
       TRA C          
       REM            
       REM            
*CHECK THAT IF EITHER OR BOTH CRT TRIGGERS ARE SLECTED A
*DRUM READ OR WRITE SELECT MAY BE GIVEN WITHOUT HANGUP.
       REM            
       WTV            
       WDR 1          
       OCT -76100000000 DIRECT DATA DISCONNECT
       WTV 1          
       RDR 1          
       OCT -76100000000 DIRECT DATA DISCONNECT
       WTV            
       WTV 1          
       WDR 1          
       OCT -76100000000 DIRECT DATA DISCONNECT
       WTV            
       WTV 1          
       RDR 1          
       OCT -76100000000 DIRECT DATA DISCONNECT
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
*WITH SWT 3 DOWN CHECK THAT WHEN MORE THAN ONE DRUM SELECT
*IS GIVEN WITHOUT A DISCONNECT THE MACHINE WILL HANGUP.
       REM            
*THIS IS CAUSED BY THE SECOND DRUM SELECT FAILING TO END OPERATION
*SINCE CKT. 1197-8 IS BLOCKED BY-NOT DRUM READ OR WRITE SELECT-5.02
       REM            
       REM            
       SWT 3          
       TRA CHA        
       REM            
       REM            
       REM            
       OCT -76100000000
       CLA B          TRA B1
       STO 0          
       WDR 1          
       WDR 2          
       NOP            RESET AND START ON HANGUP
       NOP            
       HTR *+1        FAILED TO HANGUP
       REM            
B1     OCT -76100000000
       CLA B2         TRA B3
       STO 0          
       WDR 1          
       RDR 1          
       NOP            RESET AND START ON HANGUP
       NOP            
       HTR *+1        FAILED TO HANGUP
       REM            
B3     OCT -76100000000
       CLA B4         TRA B5
       STO 0          
       RDR 1          
       RDR 2          
       NOP            RESET AND START ON HANGUP
       NOP            
       HTR *+1        FAILED TO HANGUP
       REM            
B5     OCT -76100000000
       CLA B6         TRA B7
       STO 0          
       RDR 1          
       WDR 1          
       NOP            RESET AND START ON HANGUP
       NOP            
       HTR *+1        FAILED TO HANGUP
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
*CHECK THAT THE NOP INSTRUCTION DOES NOT GIVE A DIRECT DATA
*DISCONNECT-CKT 1039-G PAGE 5.01.08
       REM            
       NOP            
B7     OCT -76100000000
       CLA B8         TRA B9
       STO 0          
       WDR 1          
       NOP            
       NOP            
       NOP            
       RDR 1          
       NOP            RESET AND START ON HANGUP
       NOP            
       HTR *+1        FAILED TO HANGUP
       REM            
*ALSO WITH SWT 3 DOWN CHECK THAT IF EITHER DRUM READ OR WRITE
*SELECT TRIGGERS ARE ON EITHER CRT INSTRUCTION WILL HANGUP THE MACHINE.
       REM            
*THIS IS CAUSED BY THE CRT SELECT INSTRUCTION FAILING TO END OPERATION
*WITH A DRUM SELECTED, CKT. 1039-D-PAGE 5.01.08
       REM            
B9     CLA C1         TRA C3
       STO 0          
       WDR 1          
       WTV            
       NOP            RESET AND START ON HANGUP
       NOP            
       HTR *+1        FAILED TO HANGUP
       REM            
C2     OCT -76100000000
       CLA C3         TRA C4
       STO 0          
       RDR 1          
       WTV            
       NOP            RESET AND START ON HANGUP
       NOP            
       HTR *+1        FAILED TO HANGUP
       REM            
C4     OCT -76100000000
       CLA C5         TRA C6
       STO 0          
       RDR 1          
       WTV 1          
       NOP            RESET AND START ON HANGUP
       NOP            
       HTR *+1        FAILED TO HANGUP
       REM            
C6     OCT -76100000000
       CLA C7         TRA A6
       STO 0          
       RDR 1          
       WTV 1          
       NOP            RESET AND START ON HANGUP
       NOP            
       HTR *+1        FAILED TO HANGUP
*CHECK THAT A CHANNEL CAN BE PUT INTO OPERATION AFTER A DRUM
*HAS BEEN SELECTED.   
       REM            
*THIS IS POSSIBLE BECAUSE THE LINE-NOT DRUM READ OR WRITE SELECT-
*IS NOT BROUGHT INTO CKTS. 1036 R AND 1036 S ON PAGE 5.01.07
       REM            
CHA    WDR 1          
       WTBA 1         
       RCHA CNTL      WRITE ONE WORD OF 
       REM            ALL ONES ON TAPE
       TCOA *         
       OCT -76100000000 DRUM DISCONNECT
       REM            
       REM            
       RDR 1          
       WTBA 1         
       RCHA CNTL      WRITE ONE WORD OF 
       REM            ALL ONES ON TAPE
       TCOA *         
       OCT -76100000000 DRUM DISCONNECT
       REM            
       REM            
       REM            
*WITH SWT 4 DOWN CHECK THAT A DRUM MAY BE SELECTED
*WITH A CHANNEL IN USE.
       REM            
*THIS IS POSSIBLE BECAUSE THE LINE-NOT READ OR WRITE SELECT-IS
*NOT USED TO TURN ON THE RD OR WR TRIGGER ON 5.02. INSTEAD THIS
*LINE HAS BEEN CHANGED TO-NOT DRUM READ OR WRITE SELECT-GOING
*TO CKT. 1197-B WHICH WILL ALLOW DRUM TO BE SELECTED WHEN A
*CHANNEL IS IN USE AND NO OTHER DRUM SELECT LINE UP.
       REM            
       SWT 4           SCOPE DRUM 1 READ AND
       REM            WRITE SELECTS IF DOWN
       TRA SW5        
       REM            
       REM            
       HTR *+1        1. TAKE TAPE UNIT 1-CHAN A
       REM            OUT OF READY STATUS
       REM            IN ORDER TO KEEP
       REM            CHANNEL A SELECTED
       REM            2. PRESS START BUTTON
       REM            
       REM            
A5     WTBA 1         
       RDR 1          N08-4
       OCT -76100000000 DRUM DISCONNECT
       WDR 1          N08-8
       OCT -76100000000 DRUM DISCONNECT
       SWT 4          
       TRA *+2        
       TRA A5+1       
       REM            
       HTR *+1         1. PUT TAPE UNIT 1-CHAN A
       REM            BACK INTO READY STATUS
       REM            2. PRESS START BUTTON
*CHECK INTERRUPT WITH SWT 5 DOWN
       REM            
SW5    SWT 5          
       TRA A6         
       HTR *+1        1. REMOVE DRUM SHOE
       REM            2. ADD JUMPER FROM MF4-AD TO
       REM               MF4-37J
       REM               THIS ALLOWS THE UNIT ADR 1
       REM               LINE-5.01.02-TO CONDITION
       REM               INTERRUPT-2.07.75
       REM            3. PRESS START
*CHECK INTERRUPT WHEN A DRUM IS SELECTED.
       REM            
*WITH THIS CONDITION WE SHOULD NOT BE ABLE TO INTERRUPT
*DUE TO THE LINE-NOT DRUM RD OR WR SELECT-COMMING INTO
*CKT. 1173-D ON PAGE 2.07.75
       REM            
TR     CLA TRAP       HTR TO TR1
       STO 4          
TR1    OCT -76100000000 
       WDR 2          DE-CONDITION CKT. 1173-D ON
       REM            2.07.75
       NOP 1          TURNS ON INTERRUPT DEMAND
       REM            TRIGGER-2.07.75-BUT SHOULD
       REM            NOT INTERRUPT
       REM            IF THE INTERRUPT LINE DOES
       REM            COME UP THE MACHINE WILL
       REM            HTR AT 00004 TO TR1
       REM            
*CHECK INTERRUPT WHEN A DRUM IS NOT SELECTED.
*WITH THIS CONDITION WE SHOULD BE ABLE TO INTERRUPT AND
*TRAP TO 00004 WHENEVER A DISCONNECT INSTRUCTION IS GIVEN SINCE THE
*INTERRUPT DEMAND TRIGGER IS ALREADY ON AND CANNOT BE TURNED OFF
*UNTIL THE INTERRUPT LINE COMES UP. PAGE 2.07.75
       REM            
       CLA TRAP1      TRA TO TR2
       STO 4          
       OCT -76100000000 SHOULD INTERRUPT
       HTR *-3        FAILED TO INTERRUPT + TRAP
       REM            TO 00004-2.0.75
       REM            1. CHECK THAT JUMPER IS
       REM               INSTALLED PROPERLY
       REM            2. CHECK THAT-NOT DRUM
       REM               READ OR WRITE SELECT-IS
       REM               UP-2.07.75
       REM            
TR2    SWT 5          
       TRA *+2        
       TRA TR         LOOP TO SCOPE INTERRUPT TEST
       REM            
       REM            
       STZ 4          CLEAR TRAP LOCATION
       HTR *+1        1. REMOVE JUMPER MF4-AD TO
       REM               MF4-37 J
       REM            2. PRESS START
       REM            
A6     SWT 6          
       TRA *+2        BRING IN NEXT PROGRAM
       TRA A1         REPEAT PROGRAM
       REM            
       REM            
       REM            
       REM            
       OCT -76100000000 DIRECT DATA DISCONNECT
       RCDA           
       RCHA Z         
       LCHA 0         
       TRA 1          
       REM            
       REM            
       REM            
       REM            
Z      IOCT 0,0,3     
K1     OCT 0          
CNTL   IOCD X,0,1     
X      OCT 777777777777
B      TRA B1         
B2     TRA B3         
B4     TRA B5         
B6     TRA B7         
B8     TRA B9         
C1     TRA C2         
C3     TRA C4         
C5     TRA C6         
C7     TRA A6         
TRAP   HTR TR1        
TRAP1  TRA TR2        
       REM            
       REM            
       END            
