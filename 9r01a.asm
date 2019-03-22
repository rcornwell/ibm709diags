                                                            9R01A
                                                           10/15/58
*                        9R01A
       REM            
*****************************************************************
*                                                               *
*                    721 CARD PUNCH TEST                        *
*                           USING                               *
*    SPECIAL RIPPLES AND SPECIAL RANDOM NUMBERS PATTERNS        *
*                                                               *
*****************************************************************
       REM            
       ORG 24         
       REM            
       TRA WPRA       PRINT IDENTIFICATION
TEST   TSX IOC,4      TO ENTER I/O SELECTION
       REM            
*ENTER INTO KEYS ON HALT AT 5517-KEY 20 FOR CHANNEL A
*KEY 19 FOR CHANNEL C, AND KEY 18 FOR CHANNEL E.
*ALSO ENTER KEY 33 FOR PUNCH-CHANNEL A,
*AND/OR KEY 35 FOR CARD READER
       REM            
*IF CHANNEL C WAS SELECTED IN TAG KEYS AT FIRST STOP,
*SECOND STOP WILL OCCUR AT 5533. ENTER KEY 33
*TO SIGNIFY PUNCH ON CHANNEL C,
*AND/OR KEY 35 FOR CARD READ
       REM            
*IF CHANNEL E WAS SELECTED IN TAG KEYS AT FIRST STOP,
*THIRD STOP WILL OCCUR AT 5540. ENTER KEY 33
*TO SIGNIFY PUNCH ON CHANNEL E,
*AND/OR KEY 35 FOR CARD READ
       REM            
*IF NO TAG KEYS WERE THROWN DOWN ON FIRST HALT
*AN ADDITIONAL HALT WILL OCCUR AT 5525, TO INDICATE THIS.
       REM            
       LDI CTRL1      1ST CONTROL WORD FROM KEYS
       RNT 0,1        TEST FOR CHAN A
       TRA TCHC       NO-CHECK FOR CHAN. C
       AXT TCHC,2     YES
       SXA COUNT,2    
       TRA PRST       START TEST
       REM            
       REM            
       REM            
*A CARD READER ON ONLY ONE CHANNEL IS NECESSARY,
*HOWEVER, AT LEAST ONE CARD READER MUST BE SELECTED
*IF CARDS ARE TO BE CHECKED.
       REM            
TCHC   LDI CTRL2      2ND CONTROL WORD FROM KEYS
       RNT 0,2        TEST FOR CHANNEL C
       TRA TCHE       NO-TEST FOR CHANNEL E
       AXT TCHE,2     
       SXA COUNT,2    
       TRA CHANC      TEST CHANNEL C
       REM            
TCHE   LDI CTRL3      3RD CONTROL WORD FROM KEYS
       RNT 0,4        TEST FOR CHANNEL E
       TRA RESET      NO-RESET TO CHANNEL A
       AXT RESET,2    
       SXA COUNT,2    
       TRA CHANE      TEST CHANNEL E
       REM            
CHANC  LDI CTRL2      
       TRA TSX        
       REM            
CHANE  LDI CTRL3      
       TRA TSX        
       REM            
TSX    TSX CTX,4      
       HTR A5E-2,0,BB3+3
       TRA PRST       
       REM            
RESET  LDI RST        TO RESET TO CHAN A
       STI CTRL1      
       STZ CTRL2      
       STZ CTRL3      
       TSX CTX,4      
       HTR A5E,0,BB3+3 
       TRA SW6        
       REM            
*      POST RESTART AND AJUST FOR PRINT ROUTINE
       REM            
PRST   CLA T30        L TRA TO PRST
       STO 0          
       REM            
       CLA K31        L 31
       STO WDNO       
       CLA K455       L 455
       STO RECNO      
       REM            
*      TEST SSW 5     
       REM            
SW5    SWT 5          
       TRA A5C-1      PUNCH REG GEN PATTERNS
       TRA BIAS       96 CARD BIAS TEST
       REM            
*****************************************************************
*                                                               *
*          PUNCH SPECIAL 12 CARDS HEAVY SIMI-RIPPLE             *
*                                                               *
*****************************************************************
       REM            
*      ZERO PUNCH IMAGE
       REM            
       SLF            TURN ALL SENSE LIGHTS OFF
A5C    LXA K30,1      L 30
       STZ PE+24,1    
       TIX A5C+1,1,1  
       CLA K2         L 2
       STO CT3        SET PASS COUNT
       REM            
*      GENERATE SPECIAL HEAVY RIPPLE IMAGE
       REM            
A5D    CLA K37        L 377 777 777 777
       STO SAV1       
       LXA K6,4       L 6
       LXA K30,1      L 30
       CLA ONES       
       LDQ SAV1       
       RQL 1          
A5D1   STO PE+24,1    
A5D2   STQ PE+25,1    
       TIX A5D+6,1,4  
       STQ SAV1       
       REM            
       SLT 3          
       TRA A5E        PUNCH CARDS
       TRA A5K        READ CARDS
       REM            
*      PUNCH SPECIAL HEAVY RIPPLE IMAGE
       REM            
A5E    WPUA           
       RCHA PUCTR     CONTROL TO PUNCH ONE CARD
       TCOA *         FROM PE
       TIX A5D+3,4,1  
       REM            
*      HAS LEFT HALF BEEN DONE
       REM            
A5F    SLT 2          
       TRA A5G        NO
       TRA A5H        
       REM            
*      SWITCH STORE INSTRUCTIONS FOR LEFT HALF
       REM            
A5G    CLA A5D1       
       ADD ONE        
       STO A5D1       
       CLA A5D2       
       ADD ONE        
       STO A5D2       
       SLN 2          TURN ON SENSE LIGHT 2
       TRA A5D        
       REM            
*      RESTORE ORIGINAL STORE INSTRUCTIONS
       REM            
A5H    CLA A5D1       
       SUB ONE        
       STO A5D1       
       CLA A5D2       
       SUB ONE        
       STO A5D2       
       REM            
*****************************************************************
*                                                               *
*      PUNCH SPECIAL 72 CARDS LIGHT RIPPLE PATTERN              *
*                                                               *
*****************************************************************
       REM            
*      MOVE ORIGINAL IMAGE TO SHIFTING IMAGE LOCATION
       REM            
A      LXA K30,1      L30
       CLA PAA,1      
       STO PBB,1      
       TIX A+1,1,1    
       REM            
*      PUNCH FIRST CARD OF 72
       REM            
A1     LXA K110,2     
       WPUA           
       RCHA PUCTR+1   CONTROL TO PUNCH ONE CARD
       REM            FROM PB
       TIX A2,2,1     
       REM            
*      PUNCH LOOP FOR NEXT 61 CARDS
       REM            
A2     WPUA           
       LXA K30,1      L 30
       CAL PB+24,1    9L, 8L, ETC.
       LDQ PB+25,1    9R, 8R, ETC.
       LGL 1          MOVE LEFT
       SLW PB+24,1    9L, 8L, ETC.
       STQ PB+25,1    9R, 8R, ETC.
       TIX A2+2,1,2   
       REM            
       RCHA PUCTR+1   CONTROL TO PUNCH ONE CARD
       REM            FROM PB
       REM            
       CAL PB         P BIT TEST
       PBT            
       TIX A2,2,1     PUNCH NEXT CARD
       TIX A3,2,1     PUNCH NEXT CARD
       REM            
*      PUNCH LOOP FOR LAST TEN CARDS
       REM            
A3     WPUA           
       LXA K30,1      L 30
       CAL PB+24,1    9L, 8L, ETC.
       LDQ PB+25,1    9R, 8R, ETC.
       LGL 1          
       SLW PB+24,1    9L, 8L, ETC.
       STQ PB+25,1    9R, 8R, ETC.
       TIX A3+2,1,2   
       REM            
       CLA ONE        
       STO PB+1       
A4     RCHA PUCTR+1   CONTROL TO PUNCH ONE CARD
       REM            FROM PB
       CLA A4-1       
       ADD TWO        L2
       STO A4-1       
       TIX A3,2,1     
       TCOA *         
       REM            
       CLA K9R        RESET FOR LOWER
       STO A4-1       RIGHT CORNER
       REM            
*****************************************************************
*                                                               *
*      PUNCH SPECIAL 72 CARDS HEAVY RIPPLE PATTERN              *
*                                                               *
*****************************************************************
       REM            
*      MOVE ORIGINAL IMAGE TO SHIFTING IMAGE LOCATION
       REM            
B      LXA K30,1      L 30
       CAL PAA,1      
       COM            
       SLW PBB,1      
       TIX B+1,1,1    
       REM            
*      ZERO ALL ROWS EXCEPT 9,6,3, AND 0
       REM            
BZ     LXA K26,1      L 26
       STZ PB+24,1    ZERO LEFT HALF ROW
       STZ PB+25,1    ZERO RIGHT HALF ROW
       STZ PB+26,1    ZERO LEFT HALF ROW
       STZ PB+27,1    ZERO RIGHT HALF ROW
       TIX BZ+1,1,6   FINISH CARD
       REM            
*      PUNCH FIRST CARD OF 72
       REM            
       LXA K110,2     L 110
       WPUA           
       RCHA PUCTR+1   CONTROL TO PUNCH ONE CARD
       TCOA *         FROM PB
       TIX B1A,2,1    
       REM            
*      RESTORE SHIFTING IMAGE
       REM            
B1A    LXA K30,1      L 30
       CAL PAA,1      
       SLW PBB,1      
       TIX B1A+1,1,1  
       REM            
*      PUNCH LOOP FOR NEXT 61 CARDS
       REM            
B2     WPUA           
       LXA K30,1      L 30
       CAL PB+24,1    9L, 8L, ETC.
       LDQ PB+25,1    9R, 8R, ETC.
       LGL 1          
       SLW PB+24,1    9L, 8L, ETC.
       STQ PB+25,1    9R, 8R, ETC.
       COM            
       SLW PD+24,1    9L, 8L, ETC.
       STQ TEMP       
       CAL TEMP       
       COM            
       SLW PD+25,1    9R, 8R, ETC.
       TIX B2+2,1,2   
       REM            
*      ZERO ALL ROWS EXCEPT 9,6,3, AND 0
       REM            
BZ1    LXA K26,1      L 26
       STZ PD+24,1    LEFT
       STZ PD+25,1    RIGHT
       STZ PD+26,1    LEFT
       STZ PD+27,1    RIGHT
       TIX BZ1+1,1,6  FINISH CARD
       REM            
       RCHA PUCTR+2   CONTROL TO PUNCH ONE CARD
       REM            FROM PD
       REM            
       CAL PB         
       PBT            
       TIX B2,2,1     PUNCH NEXT CARD
       TIX B3,2,1     PUNCH NEXT CARD
       REM            
*      PUNCH LOOP FOR LAST TEN CARDS
       REM            
B3     WPUA           
       LXA K30,1      L 30
       CAL PB+24,1    9L, 8L, ETC.
       LDQ PB+25,1    9R, 8R, ETC.
       LGL 1          
       SLW PB+24,1    9L, 8L, ETC.
       STQ PB+25,1    
       COM            
       SLW PD+24,1    9L, 8L, ETC.
       STQ TEMP       
       CAL TEMP       
       COM            
       SLW PD+25,1    9R, 8R, ETC.
       TIX B3+2,1,2   
       REM            
B3A    CAL ONE        
       SLW PB+1       
       COM            
       SLW PD+1       
       REM            
*      ZERO ALL ROWS EXCEPT 9,6,3, AND 0
       REM            
BZ2    LXA K26,1      L 26
       STZ PD+24,1    LEFT
       STZ PD+25,1    RIGHT
       STZ PD+26,1    LEFT
       STZ PD+27,1    RIGHT
       TIX BZ2+1,1,6  FINISH CARD
       REM            
       RCHA PUCTR+2   CONTROL TO PUNCH ONE CARD
       REM            FROM PD
       REM            
       CLA B3A+1      
       ADD TWO        
       STO B3A+1      
       CLA B3A+3      
       ADD TWO        
       STO B3A+3      
       TIX B3,2,1     
       TCOA *         
       REM            
       CLA K9R        RESTORE FOR LOWER
       STO B3A+1      RIGHT CORNER
       CLA K9S        
       STO B3A+3      
       REM            
*****************************************************************
*                                                               *
*      PUNCH SPECIAL RANDOM NUMBERS PATTERN                     *
*                                                               *
*****************************************************************
       REM            
       CLA TWO        L 2
       STO CT2        
       SLF            TURN OFF SENSE LIGHTS
       LXA K30,2      L 30
       CLA PRM        L245716312345
       STO PRM1       
       REM            
*      GENERATE RANDOM NUMBER CARD PUNCH IMAGE
       REM            
AA     WPUA           
       LXA K65,1      L 65
       LDQ PRM1       INITIAL RN LOAD
       RQL 1          
       MPY PR         L357642357563
       STQ PDD,1      
       TIX AA+3,1,1   
       REM            
*      DECREASE MAGNITUDE OF ODD ROWS
       REM            
AA1    LXA K30,1      L 30
       LXA AA2,4      L 0
       CAL PD+24,1    9 L
       ANA PD+52,4    
       ANA PD+51,4    
       ANA PD+50,4    
       ANA PD+49,4    
       SLW PD+24,1    9L
       CAL PD+25,1    9R
       ANA PD+48,4    
       ANA PD+47,4    
       ANA PD+46,4    
       ANA PD+45,4    
       SLW PD+25,1    9R
       TXI AA1A,4,4   
AA1A   TIX AA1+2,1,4  
       REM            
*      INCREASE MAGNITUDE OF EVEN ROWS
       REM            
AA1B   LXA K26,1      L 26
       LXA AA2,4      L 0
       CAL PD+24,1    8L
       ORA PD+52,4    
       ORA PD+51,4    
       ORA PD+50,4    
       ORA PD+49,4    
       SLW PD+24,1    8L
       CAL PD+25,1    8R
       ORA PD+48,4    
       ORA PD+47,4    
       ORA PD+46,4    
       ORA PD+45,4    
       SLW PD+25,1    8R
       TXI AA1C,4,4   
AA1C   TIX AA1B+2,1,4 
       REM            
*      GENERATE CHECK SUM FOR EACH CARD AND STORE IN 9R
       REM            
AA2    PXD            CLEAR AC
       LXA K26,1      
       CAL PD         9L
       ACL PD+24,1    
       TIX AA2+3,1,1  
       SLW PD+1       9R
       REM            
       REM            
*      TEST SL 1 TO PUNCH OF READ CARDS
       REM            
AA2A   SLT 1          
       TRA AA3        PUNCH CARDS
       TRA AA5        READ CARDS
       REM            
*      PUNCH CARDS    
       REM            
AA3    RCHA PUCTR+2   CONTROL TO PUNCH ONE CARD
       REM            FROM PD
       CLA PD+27      
       STO PRM1       
       REM            
*      SET RANDOM DELAY TO CAUSE RANDOM DISCONNECT
       REM            
AARD   ARS 33         
       ADD K1100      L 1100
       PAX 0,1        
       TIX AARD+3,1,1 
       REM            
       TIX AA,2,1     PUNCH ALL CARDS
       REM            
*      HAVE LIGHT AND HEAVY ROWS BEEN SWITCHED
       REM            
AA3A   CLA CT2        
       SUB ONE        
       TZE AA3C       
       STO CT2        
       REM            
*      ADJUST FOR HEAVY ODD ROWS AND LIGHT EVEN ROWS
       REM            
AA3B   CLA AA1        
       LDQ AA1B       
       STO AA1B       
       STQ AA1        
       TRA AA-3       
       REM            
*      RESTORE FOR READING
       REM            
AA3C   CLA AA1        
       LDQ AA1B       
       STO AA1B       
       STQ AA1        
       CLA TWO        
       STO CT2        
       REM            
*****************************************************************
*                                                               *
*           PUNCH SPECIAL RANDOM NUMBERS PATTERN                *
*                 THREE ROWS HEAVY                              *
*                  THREE ROWS LIGHT                             *
*                     SIX ROWS ZERO                             *
*           PUNCH FOUR PATTERNS OF 24 CARDS EACH                *
*                                                               *
*****************************************************************
       REM            
       SLF            TURN OFF SENSE LIGHTS
       LXA K30,2      L 30
       CLA PRM        L245716312345
       STO PRM1       
       REM            
*      GENERATE RANDOM NUMBER CARD PUNCH IMAGE
       REM            
PP     WPUA           
       LXA K65,1      L 65
       LDQ PRM1       INITIAL RN LOAD
       RQL 1          
       MPY PR         L357642357563
       STQ PDD,1      
       TIX PP+3,1,1   
       REM            
*      DECREASE MAGNITUDE OF ODD ROWS 9,5, AND 1
       REM            
PP1    LXA K30,1      L 30
       LXA PP2,4      L 0
       CAL PD+24,1    9L
       ANA PD+52,4    
       ANA PD+51,4    
       ANA PD+50,4    
       ANA PD+49,4    
       SLW PD+24,1    9L
       CAL PD+25,1    9R
       ANA PD+48,4    
       ANA PD+47,4    
       ANA PD+46,4    
       ANA PD+45,4    
       SLW PD+25,1    9R
       TXI PP1P,4,4   
PP1P   TIX PP1+2,1,8  
       REM            
*      INCREASE MAGNITUDE OF ODD ROWS 7,3, AND 11
       REM            
PP1B   LXA K24,1      L 24
       LXA PP2,4      L 0
       CAL PD+24,1    8L
       ORA PD+52,4    
       ORA PD+51,4    
       ORA PD+50,4    
       ORA PD+49,4    
       SLW PD+24,1    8L
       CAL PD+25,1    8R
       ORA PD+48,4    
       ORA PD+47,4    
       ORA PD+46,4    
       ORA PD+45,4    
       SLW PD+25,1    8R
       TXI PP1C,4,4   
PP1C   TIX PP1B+2,1,8 
       REM            
       REM            
*      ZERO EVEN ROWS 
       REM            
PP1D   LXA K26,1      L 26
       STZ PD+24,1    LEFT
       STZ PD+25,1    RIGHT
       TIX PP1D+1,1,4 
       REM            
*      GENERATE CHECK SUM FOR EACH CARD AND STORE IN 9R
       REM            
PP2    PXD            CLEAR AC
       LXA K26,1      
       CAL PD         9L
       ACL PD+24,1    
       TIX PP2+3,1,1  
       SLW PD+1       9R
       REM            
       REM            
*      TEST SL 1 TO PUNCH OR READ CARDS
       REM            
PP2P   SLT 1          TEST LITE ONE
       TRA PP3        PUNCH CARDS
       TRA PP5        READ CARDS
       REM            
*      PUNCH CARDS    
       REM            
PP3    RCHA PUCTR+2   CONTROL TO PUNCH ONE CARD
       REM            FROM PD
       CLA PD+27      
       STO PRM1       
       LXA K114,1     L 114
       TIX PP3+7,1,1  DELAY
       REM            
*      SET UP RANDOM DELAY FOR RANDOM LATCH-UP
       REM            
PPRD   ARS 33         
       ADD K1100      
       PAX 0,1        
       TIX PPRD+3,1,1 
       REM            
       TIX PP,2,1     PUNCH ALL CARDS
       REM            
*      HAVE LIGHT AND HEAVY ROWS BEEN SWITCHED
       REM            
PP3P   CLA CT2        
       SUB ONE        
       TZE PP3D       
       STO CT2        
       REM            
*      SWITCH LIGHT AND HEAVY ROWS
       REM            
PP3B   CLA PP1        
       LDQ PP1B       
       STO PP1B       
       STQ PP1        
       TRA PP-3       
       REM            
*      SWITCH COMPLETE PATTERN AND ZERO ODD ROWS
       REM            
PP3D   SLT 2          TEST LITE 2
       TRA PP3E       
       TRA PP3F       
       REM            
PP3E   SLN 2          TURN ON LITE 2
       CLA K9W        L LXA K26,1
       STO PP1        
       CLA K9X        L LXA K22,1
       STO PP1B       
       CLA K9T        L LXA K30,1
       STO PP1D       
       CLA TWO        RESTORE COUNT
       STO CT2        
       TRA PP-3       
       REM            
*      RESTORE TO ORIGINAL SETTING
       REM            
PP3F   CLA K9T        L LXA K30,1
       STO PP1        
       CLA K9Y        L LXA K24,1
       STO PP1B       
       CLA K9W        L LXA K26,1
       STO PP1D       
       REM            
       REM            
       HTR READ       READY PUNCHED CARDS IN
       REM            READER AND PRESS START, TO
       REM            COMPARE
       REM            
       REM            
*      POST NEW RESTART FOR READING
       REM            
READ   CLA TRC        TRA TO READ
       STO 0          
       SLF            TURN OFF LITES
       REM            
*****************************************************************
*                                                               *
*          READ AND CHECK 12 CARDS HEAVY SEMI-RIPPLE            *
*                                                               *
*****************************************************************
       REM            
       CLA K2         L 2
       STO CT3        
       LXA K454,2     L 454
       SLN 3          TURN ON LITE 3
       TRA A5C        
       REM            
A5K    RCDA           
       RCHA PUCTR+3   CONTROL TO READ ONE CARD
       TCOA *         INTO PB
       TRA A5L        
       REM            
       BCD 1WPUA      
       REM            
A5L    LXA K30,1      L 30
       CLA PBB,1      
       CAS PEE,1      
       TRA A5L+5      ERROR
       TRA A5M        OK
       LDQ PEE,1      ERROR
       SXD XRC,4      
       TSX ERROR-2,4  
       TRA A5L        
       LXD XRC,4      
       REM            
A5M    TIX A5L+1,1,1  
       REM            
       SLN 3          TURN ON LITE 3
       TIX A5M+3,2,1  
       TIX A5D+3,4,1  
       REM            
*      HAS LEFT HALF BEEN DONE
       REM            
A5N    CLA CT3        L COUNT
       SUB ONE        
       TZE A5P        
       STO CT3        
       REM            
*      SWITCH STORE INSTRUCTIONS
       REM            
       CLA A5D1       
       ADD ONE        
       STO A5D1       
       CLA A5D2       
       ADD ONE        
       STO A5D2       
       TRA A5D        
       REM            
*      RESTORE ORIGINAL STORE INSTRUCTIONS
       REM            
A5P    CLA A5D1       
       SUB ONE        
       STO A5D1       
       CLA A5D2       
       SUB ONE        
       STO A5D2       
       REM            
*****************************************************************
*                                                               *
*      READ AND CHECK 72 CARDS LIGHT RIPPLE PATTERN             *
*                                                               *
*****************************************************************
       REM            
*      RESTORE MOVING IMAGE TO ORIGINAL CARD IMAGE
       REM            
       LXA K440,2     L 440
A5     LXA K30,1      L30
       CLA PAA,1      
       STO PBB,1      
       TIX A5+1,1,1   
       REM            
*      COMPARE WORD PUNCHED TO GENERATED WORD
       REM            
A6     RCDA           
       RCHA PUCTR+4   CONTROL TO READ ONE CARD
       TCOA *         INTO PC
       TRA A6A        
       REM            
*      COMPARE LOOP FOR CARD 1
       REM            
       BCD 1WPUA      
       REM            
A6A    LXA K30,1      L30
       CLA PCC,1      
       CAS PBB,1      
       TRA A6A+5      ERROR
       TRA A7         OK
       LDQ PBB,1      ERROR
       TSX ERROR-2,4  
       TRA A6A        
       REM            
A7     TIX A6A+1,1,1  
       REM            
       TIX A7+2,2,1   READ NEXT CARD 
       REM            
       LXA K30,1      L 30
       CAL PB+24,1    9L, 8L, ETC.
       LDQ PB+25,1    9R, 8R, ETC.
       LGL 1          
       SLW PB+24,1    9L, 8L, ETC.
       STQ PB+25,1    9R, 8R, ETC.
       TIX A7+3,1,2   
       REM            
A8     RCDA           
       RCHA PUCTR+4   CONTROL TO READ ONE CARD
       TCOA *         INTO PC
       TRA A8A        
       REM            
*      COMPARE LOOP FOR CARDS 2-62
       REM            
       BCD 1WPUA      
       REM            
A8A    LXA K30,1      L 30
       CLA PCC,1      
       CAS PBB,1      
       TRA A8A+5      ERROR
       TRA A9         OK
       LDQ PBB,1      ERROR
       TSX ERROR-2,4  
       TRA A8A        
       REM            
       REM            
A9     TIX A8A+1,1,1  
       REM            
       CAL PB         
       PBT            
       TIX A7+2,2,1   READ NEXT CARD
       TIX A10,2,1    READ NEXT CARD
       REM            
*      SET INITIAL IMAGE FOR LAST TEN CARDS
       REM            
A10    LXA K30,1      L 30
       CAL PB+24,1    9L, 8L, ETC.
       LDQ PB+25,1    9R, 8R, ETC.
       LGL 1          
       SLW PB+24,1    9L, 8L, ETC.
       STQ PB+25,1    9R, 8R, ETC.
       TIX A10+1,1,2  
       REM            
A11    RCDA           
       CLA ONE        
       STO PB+1       
       RCHA PUCTR+4   CONTROL TO READ ONE CARD
       TCOA *         INTO PC
       TRA A11A       
       REM            
*      COMPARE LOOP FOR CARDS 63-72
       REM            
       BCD 1WPUA      
       REM            
A11A   LXA K30,1      L 30
       CLA PCC,1      
       CAS PBB,1      
       TRA A11A+5     ERROR
       TRA A12        OK
       LDQ PBB,1      ERROR
       TSX ERROR-2,4  
       TRA A11A       
       REM            
A12    TIX A11A+1,1,1 
       REM
       CLA A11+2      
       ADD TWO        
       STO A11+2      
       TIX A12+5,2,1  
       TXH A10,2,216  
       NOP            
       REM            
       CLA K9R        RESET FOR LOWER
       STO A11+2      RIGHT CORNER
       REM            
*****************************************************************
*                                                               *
*        READ AND CHECK 72 CARDS HEAVY RIPPLE PATTERNS          *
*                                                               *
*****************************************************************
       REM            
       LXA K330,2     L 330
B5     LXA K30,1      L 30
       CAL PAA,1      
       COM            
       SLW PBB,1      
       TIX B5+1,1,1   
       REM            
*      ZERO ALL ROWS EXCEPT 9,6,3, AND 0
       REM            
BZ3    LXA K26,1      L 26
       STZ PB+24,1    LEFT
       STZ PB+25,1    RIGHT
       STZ PB+26,1    LEFT
       STZ PB+27,1    RIGHT
       TIX BZ3+1,1,6  FINISH CARD
       REM            
B6     RCDA           
       RCHA PUCTR+4   CONTROL TO READ ON CARD
       TCOA *         INTO PC
       TRA B6A        
       REM            
*      COMPARE LOOP FOR CARD 1
       REM            
       BCD 1WPUA      
       REM            
B6A    LXA K30,1      L 30
       CLA PCC,1      
       CAS PBB,1      
       TRA B6A+5      ERROR
       TRA B7         OK
       LDQ PBB,1      ERROR
       TSX ERROR-2,4  
       TRA B6A        
       REM            
B7     TIX B6A+1,1,1  
       REM            
*      RESTORE SHIFTING IMAGE
       REM            
B7A    LXA K30,1      L 30
       CAL PAA,1      
       SLW PBB,1      
       TIX B7A+1,1,1  
       REM            
       TIX B7B,2,1    READ NEXT CARD
       REM            
B7B    LXA K30,1      L 30
       CAL PB+24,1    9L, 8L, ETC.
       LDQ PB+25,1    9R, 8R, ETC.
       LGL 1          
       SLW PB+24,1    9L, 8L, ETC.
       STQ PB+25,1    9R, 8R, ETC.
       COM            
       SLW PD+24,1    9L, 8L, ETC.
       STQ TEMP       
       CAL TEMP       
       COM            
       SLW PD+25,1    9L, 8L, ETC.
       TIX B7B+1,1,2  
       REM            
*      ZERO ALL ROWS EXCEPT 9,6,3, AND 0
       REM            
BZ4    LXA K26,1      L 26
       STZ PD+24,1    LEFT
       STZ PD+25,1    RIGHT
       STZ PD+26,1    LEFT
       STZ PD+27,1    RIGHT
       TIX BZ4+1,1,6  FINISH CARD
       REM            
B8     RCDA           
       RCHA PUCTR+4   CONTROL TO READ ONE CARD
       TCOA *         INTO PC
       TRA B8A        
       REM            
*      COMPARE LOOP FOR CARDS 2-62
       REM            
       BCD 1WPUA      
       REM            
B8A    LXA K30,1      L 30
       CLA PCC,1      
       CAS PD+24,1    
       TRA B8A+5      ERROR
       TRA B9         OK
       LDQ PD+24,1    ERROR
       TSX ERROR-2,4  
       TRA B8A        
       REM            
B9     TIX B8A+1,1,1  
       REM            
       CAL PB         
       PBT            
       TIX B7B,2,1    READ NEXT CARD
       TIX B10,2,1    READ NEXT CARD
       REM            
*      SET INITIAL IMAGE FOR LAST TEN CARDS
       REM            
B10    LXA K30,1      L 30
       CAL PB+24,1    9L, 8L, ETC.
       LDQ PB+25,1    9R, 8R, ETC.
       LGL 1          
       SLW PB+24,1    9L, 8L, ETC.
       STQ PB+25,1    9L, 8L, ETC.
       COM            
       SLW PD+24,1    9L, 8L, ETC.
       STQ TEMP       
       CAL TEMP       
       COM            
       SLW PD+25,1    9L, 8L, ETC.
       TIX B10+1,1,2  
       REM            
B11    RCDA           
       CAL ONE        
       SLW PB+1       
       COM            
       SLW PD+1       
       REM            
*      ZERO ALL ROWS EXCEPT 9,6,3, AND 0
       REM            
BZ5    LXA K26,1      L 26
       STZ PD+24,1    LEFT
       STZ PD+25,1    RIGHT
       STZ PD+26,1    LEFT
       STZ PD+27,1    RIGHT
       TIX BZ5+1,1,6  FINISH CARD
       RCHA PUCTR+4   CONTROL TO READ ONE CARD
       TCOA *         INTO PC
       TRA B11A       
       REM            
*      COMPARE LOOP FOR CARDS 63-72
       REM            
       BCD 1WPUA      
       REM            
B11A   LXA K30,1      L 30
       CLA PCC,1      
       CAS PD+24,1    
       TRA B11A+5     ERROR
       TRA B12        OK
       LDQ PD+24,1    ERROR
       TSX ERROR-2,4  
       TRA B11A       
       REM            
B12    TIX B11A+1,1,1 FINISH CARD
       REM            
       CLA B11+2      
       ADD TWO        
       STO B11+2      
       CLA B11+4      
       ADD TWO        
       STO B11+4      
       TIX B12+8,2,1  
       TXH B10,2,144  
       REM
       CLA K9R        RESTORE FOR LOWER
       STO B11+2      RIGHT CORNER
       CLA K9S        
       STO B11+4      
       REM            
*****************************************************************
*                                                               *
*      READ AND CHECK SPECIAL RANDOM NUMBERS PATTERN            *
*                                                               *
*****************************************************************
       REM            
*      REGENERATE SPECIAL RANDOM NUMBER IMAGE
       REM            
       LXA K220,2     L 220
       CLA TWO        L 2
       STO CT2        
       SLN 1          TURN ON LITE
       CLA PRM        L 245716312345
       STO PRM1       
       TRA AA+1       
       REM            
*      READ CARDS     
       REM            
AA5    RCDA           
       RCHA PUCTR+5   CONTROL TO READ ON CARD
       TCOA *         INTO PE
       LXA K26,1      L26
       CAL PE         9L
       ACL PE+24,1    
       TIX *-1,1,1    
       SLW PEE        9R CHECK SUM
       TRA AA6        
       REM            
*      COMPARE CARDS  
       REM            
       BCD 1WPUA      
       REM            
AA6    LXA K30,1      L30
       CLA PE+24,1    
       CAS PD+24,1    
       TRA AA6+5      ERROR
       TRA AA6A-2     OK
       LDQ PD+24,1    ERROR
       TSX ERROR-2,4  
       TRA AA6        
       TIX AA6+1,1,1  FINISH CARD
       REM            
       LXA K31,1      L 31
       REM            
AA6A   CLA PEE        CHECK SUM TEST
       CAS PD+1       
       TRA AA6A+4     ERROR
       TRA AA6B       OK
       LDQ PD+1       
       TSX ERROR-2,4  
       TRA AA6        
       REM            
AA6B   CLA PD+27      
       STO PRM1       
       SLN 1          TURN ON LITE ONE
       TIX AA7,2,1    
AA7    TXH AA+1,2,120 GENERATE NEXT IMAGE
       TXL AA9,2,96   
       REM            
*      SWITCH TO READ HEAVY ODD ROWS AND LIGHT EVEN ROWS
       REM            
AA8    CLA AA1        
       LDQ AA1B       
       STO AA1B       
       STQ AA1        
       CLA K9A        L TXH AA,2,96
       STO AA7        
       CLA PRM        
       STO PRM1       
       TRA AA+1       
       REM            
*      RESTORE TO PUNCH OR READ HEAVY EVEN AND LIGHT ODD
       REM            
AA9    CLA AA1        
       LDQ AA1B       
       STO AA1B       
       STQ AA1        
       CLA K9B        L TXH,2,120
       STO AA7        
       REM            
*****************************************************************
*                                                               *
*           READ AND CHECK SPECIAL RANDOM NUMBERS               *
*                  THREE ROWS HEAVY                             *
*                   THREE ROWS LIGHT                            *
*                      SIX ROWS ZERO                            *
*             READ FOUR PATTERNS OF 24 CARDS EACH               *
*                                                               *
*****************************************************************
       REM            
       SLF            TURN OFF SENSE LITES
       CLA TWO        
       STO CT2        
       LXA K140,2     L 140
       REM            
*      REGENERATE PUNCHED IMAGES
       REM            
       SLN 1          TURN LITE 1 ON
       CLA PRM        L 245716312345
       STO PRM1       
       TRA PP+1       
       REM            
*      READ CARDS     
       REM            
PP5    RCDA           
       RCHA PUCTR+5   CONTROL TO READ ONE CARD
       LXA K26,1      INTO PE
       TCOA *         
       CAL PE         9L
       ACL PE+24,1    8L-12R
       TIX *-1,1,1    
       SLW PEE        9R CHECK SUM
       TRA PP6        
       REM            
*      COMPARE CARDS  
       REM            
       BCD 1WPUA      
       REM            
PP6    LXA K30,1      L30
       CLA PE+24,1    
       CAS PD+24,1    
       TRA PP6+5      ERROR
       TRA PP6P-2     OK
       LDQ PD+24,1    ERROR
       TSX ERROR-2,4  
       TRA PP6        
       TIX PP6+1,1,1  FINISH CARD
       REM            
       LXA K31,1      L 31
PP6P   CLA PEE        CHECK SUM TEST
       CAS PD+1       
       TRA PP6P+4     ERROR
       TRA PP6P+7     OK
       LDQ PD+1       
       TSX ERROR-2,4  
       TRA PP6        
       REM            
       CLA PD+27      
       STO PRM1       
       SLN 1          TURN ON LITE ONE
       TIX PP7,2,1    
PP7    TXH PP+1,2,72  
       TXL LCC,2,1    
       REM            
*      HAVE LIGHT AND HEAVY ROWS BEEN SWITCHED
       REM            
PP7P   CLA CT2        
       SUB ONE        
       TZE PP8B       
       STO CT2        
       REM            
*      SWITCH LIGHT AND HEAVY ROWS
       REM            
PP8    CLA PP1        
       LDQ PP1B       
       STO PP1B       
       STQ PP1        
PP8A   CLA K9D        L TXH PP,2,48
       STO PP7        
       CLA PRM        L 245716312345
       STO PRM1       
       TRA PP+1       
       REM            
*      SWITCH COMPLETE PATTERN AND ZERO ODD ROWS
       REM            
       REM            
PP8B   CLA K9W        L LXA K26,1
       STO PP1        
       CLA K9X        L LXA K22,1
       STO PP1B       
       CLA K9T        L LXA K30,1
       STO PP1D       
       CLA TWO        
       STO CT2        
       CLA K9E        L TXH PP,2,24
       STO PP7        
       CLA K9F        L CLA K9G
       STO PP8A       
       CLA PRM        L 245716312345
       STO PRM1       
       TRA PP+1       
       TRA PP-2       
       REM            
*      RESTORE TO ORIGINAL SETTING
       REM            
PP8C   CLA K9T        L LXA K30,1
       STO PP1        
       CLA K9Y        L LXA K24,1
       STO PP1B       
       CLA K9W        L LXA K26,1
       STO PP1D       
       CLA K9C        L TXH PP,2,72
       STO PP7        
       CLA K9J        L CLA K9D
       STO PP8A       
       CLA KTXL1      L TXL LCC,2,1
       STO PP7+1      
       REM            
       HTR CHECK      CARDS HAVE BEEN READ AND
       REM            COMPARED. PRESSING START
       REM            WILL TEST PUNCH-NEXT CHAN.
       REM            
LCC    CLA KTRA1      L TRA PP8C
       STO PP7+1      
       TRA PP+1       
       REM            
*****************************************************************
*                                                               *
*                  PUNCH SPECIAL CARD PATTERN                   *
*                                                               *
*****************************************************************
       REM            
CARD   RCDA           READ SPECIAL PUNCH
       RCHA PUCTR+1   IMAGE INTO PB
       TCOA *         
       REM            
WPU    LXA K30,2      L 30
       WPUA           PUNCH CARDS
       RCHA PUCTR+1   CONTROL TO PUNCH
       REM           FROM PB
       TIX WPU+1,2,1  PUNCH NEXT CARD
       REM            
       HTR RD         READY PUNCHED CARDS IN
       REM            READER AND PRESS START, TO
       REM            COMPARE
       REM            
*****************************************************************
*                                                               *
*                  READ SPECIAL CARD PATTERN                    *
*                                                               *
*****************************************************************
       REM            
RD     CLA K31        L 31
       STO WDNO       
       STO RECNO      
       LXA K30,2      L 30
       RCDA           
       RCHA PUCTR+4   CONTROL TO READ
       TCOA *         SPECIAL IMAGE
       TRA CAS        
       REM            
*      COMPARE LOOP SPECIAL CARD IMAGE
       REM            
       BCD 1WPUA      
       REM            
CAS    LXA K30,1      L 30
       CLA PCC,1      
       CAS PBB,1      
       TRA CAS+5      ERROR
       TRA NEXT       OK
       LDQ PBB,1      ERROR
       TSX ERROR-2,4  
       TRA CAS        
       REM            
NEXT   TIX CAS+1,1,1  FINISH CARD
       TIX RD+4,2,1  NEXT CARD
       REM            
       HTR CHECK      CARDS HAVE BEEN READ AND
       REM            COMPARED. PRESSING START
       REM            WILL TEST PUNCH-NEXT CHAN.
       REM            
*****************************************************************
*                                                               *
*            PUNCH SPECIAL RANDOM NUMBERS PATTERN               *
*                  THREE ROWS HEAVY                             *
*                   THREE ROWS LIGHT                            *
*                      SIX ROWS ZERO                            *
*            PUNCH FOUR PATTERNS OF 25 CARDS EACH               *
*                                                               *
*****************************************************************
       REM            
*      ADJUST CONSTANTS FOR BIASING
       REM            
BIAS   CLA K141       L141
       STO RECNO      
       CLA TWO        L2
       STO CT2        
       CLA K31        L31
       STO WDNO       
       SLF            TURN OFF ALL LIGHTS
       LXA K30,2      L 30
       REM            
       CLA PRM        L245716312345
       STO PRM1       
       REM            
*      GENERATE RANDOM NUMBER CARD PUNCH IMAGE
       REM            
BB     WPUA           
       LXA K65,1      L 65
       LDQ PRM1       INITIAL RN LOAD
       RQL 1          
       MPY PR         L357642357563
       STQ PDD,1      
       TIX BB+3,1,1   
       REM            
*      DECREASE MAGNITUDE OF ODD ROWS 9,5, AND 1
       REM            
BB1    LXA K30,1      L 30
       LXA BB2,4      L 0
       CAL PD+24,1    
       ANA PD+52,4    
       ANA PD+51,4    
       ANA PD+50,4    
       ANA PD+49,4    
       SLW PD+24,1    9L
       CAL PD+25,1    9R
       ANA PD+48,4    
       ANA PD+47,4    
       ANA PD+46,4    
       ANA PD+45,4    
       SLW PD+25,1    9R
       TXI BB1A,4,4   
BB1A   TIX BB1+2,1,8  
       REM            
*      INCREASE MAGNITUDE OF ODD ROWS 7,3, AND 11
       REM            
BB1B   LXA K24,1      L 24
       LXA BB2,4      L 0
       CAL PD+24,1    8L
       ORA PD+52,4    
       ORA PD+51,4    
       ORA PD+50,4    
       ORA PD+49,4    
       SLW PD+24,1    8L
       CAL PD+25,1    8R
       ORA PD+48,4    
       ORA PD+47,4    
       ORA PD+46,4    
       ORA PD+45,4    
       SLW PD+25,1    8R
       TXI BB1C,4,4   
BB1C   TIX BB1B+2,1,8 
       REM            
       REM            
*      ZERO EVEN ROWS 
       REM            
BB1D   LXA K26,1      L 26
       STZ PD+24,1,4  ZERO LEFT HALF EVEN ROWS
       STZ PD+25,1,4  ZERO RIGHT HALF EVEN ROWS
       TIX BB1D+1,1,4 
       REM            
*      GENERATE CHECK SUM FOR EACH CARD AND STORE IN 9R
       REM            
BB2    PXD            CLEAR AC
       LXA K26,1      
       CAL PD         9L
       ACL PD+24,1    
       TIX BB2+3,1,1  
       SLW PD+1       9R
       REM            
*      TEST SL 1 TO PUNCH OR READ CARDS
       REM            
BB2B   SLT 1          TEST LITE ONE
       TRA BB3        PUNCH CARDS
       TRA BB5        READ CARDS
       REM            
*      PUNCH CARDS    
       REM            
BB3    RCHA PUCTR+2   CONTROL TO PUNCH ONE CARD
       REM            FROM PD
       CLA PD+27      
       STO PRM1       
       REM            
       TIX BB,2,1     PUNCH ALL CARDS
       REM            
*      HAVE LIGHT AND HEAVY ROWS BEEN SWITCHED
       REM            
BB3A   CLA CT2        
       SUB ONE        
       TZE BB3D       
       STO CT2        
       REM            
*      SWITCH LIGHT AND HEAVY ROWS
       REM            
BB3B   CLA BB1        
       LDQ BB1B       
       STO BB1B       
       STQ BB1        
       TRA BB-3       
       REM            
*      SWITCH COMPLETE PATTERN AND ZERO ODD ROWS
       REM            
BB3D   SLT 2          TURN ON LITE TWO
       TRA BB3E       
       TRA BB3F       
       REM            
BB3E   SLN 2          TURN ON LIGHT TWO
       CLA K9W        L LXA K26,1
       STO BB1        
       CLA K9X        L LXA K22,1
       STO BB1B       
       CLA K9T        L LXA K30,1
       STO BB1D       
       CLA TWO        RESTORE COUNT
       STO CT2        
       TRA BB-3       
       REM            
*      RESTORE TO ORIGINAL SETTING
       REM            
BB3F   CLA K9T        L LXA K30,1
       STO BB1        
       CLA K9Y        L LXA K24,1
       STO BB1B       
       CLA K9W        L LXA K26,1
       STO BB1D       
       REM            
BB4    HTR BB4+1      READY PUNCHED CARDS IN READER
       REM            AND PRESS START TO COMPARE
       REM            
*****************************************************************
*                                                               *
*           READ AND CHECK SPECIAL RANDOM NUMBERS               *
*                  THREE ROWS HEAVY                             *
*                   THREE ROWS LIGHT                            *
*                      SIX ROWS ZERO                            *
*            READ FOUR PATTERN OF 24 CARDS EACH                 *
*                                                               *
*****************************************************************
       REM            
       SLF            TURN OFF SENSE LIGHTS
       CLA TWO        
       STO CT2        
       LXA K140,2     L 140
       REM            
*      REGENERATE PUNCHED IMAGES
       REM            
       SLN 1          TURN ON LITE ONE
       CLA PRM        L 245716312345
       STO PRM1       
       TRA BB+1       
       REM            
*      READ CARDS     
       REM            
BB5    RCDA           
       RCHA PUCTR+5   CONTROL TO READ ONE CARD
       LXA K26,1      INTO PE
       TCOA *         
       CAL PE         9L
       ACL PE+24,1    8L-12R
       TIX *-1,1,1    
       SLW PEE        9R CHECK SUM
       TRA BB6        
       REM            
*      COMPARE CARDS  
       REM            
       BCD 1WPUA      
       REM            
BB6    LXA K30,1      L30
       CLA PE+24,1    
       CAS PD+24,1    
       TRA BB6+5      ERROR
       TRA BB6B-2     OK
       LDQ PD+24,1    
       TSX ERROR-2,4  
       TRA BB6        
       TIX BB6+1,1,1  FINISH CARD
       REM            
       LXA K31,1      L 31
BB6B   CLA PEE        
       CAS PD+1       
       TRA BB6B+4     ERROR
       TRA BB7-4      OK
       LDQ PD+1       
       TSX ERROR-2,4  
       TRA BB6        
       REM            
       CLA PD+27      
       STO PRM1       
       SLN 1          TURN ON LITE ONE
       TIX BB7,2,1    
BB7    TXH BB+1,2,72  
       TXL LC,2,1     
       REM            
*      HEAVY LIGHT AND HEAVY ROWS BEEN SWITCHED
       REM            
BB7B   CLA CT2        
       SUB ONE        
       TZE BB8B       
       STO CT2        
       REM            
*      SWITCH LIGHT AND HEAVY ROWS
       REM            
BB8    CLA BB1        
       LDQ BB1B       
       STO BB1B       
       STQ BB1        
BB8A   CLA K9L        L TXH BB,2,48
       STO BB7        
       CLA PRM        L 245716312345
       STO PRM1       
       TRA BB+1       
       REM            
*      SWITCH COMPLETE PATTERN AND ZERO ODD ROWS
       REM            
BB8B   CLA K9W        L LXA K26,1
       STO BB1        
       CLA K9X        L LXA K22,1
       STO BB1B       
       CLA K9T        L LXA K30,1
       STO BB1D       
       CLA TWO        
       STO CT2        
       CLA K9M        L TXH BB,2,24
       STO BB7        
       CLA K9N        L CLA K9O
       STO BB8A       
       CLA PRM        L 245716312345
       STO PRM1       
       TRA BB+1       
       REM            
*      RESTORE TO ORIGINAL SETTING
       REM            
BB8C   CLA K9T        L LXA K30,1
       STO BB1        
       CLA K9Y        L LXA K24,1
       STO BB1B       
       CLA K9W        L LXA K26,1
       STO BB1D       
       CLA K9P        TXH BB,2,72
       STO BB7        
       CLA K9Q        L CLA K9L
       STO BB8A       
       REM            
       CLA KTXL       L TXL LC,2,1
       STO BB7+1      
       REM            
       HTR CHECK      CARDS HAVE BEEN READ AND
       REM            COMPARED. PRESSING START
       REM            WILL TEST PUNCH-NEXT CHAN.
       REM            
LC     CLA KTRA       L TRA BB8C
       STO BB7+1      
       TRA BB+1       
       REM            
*****************************************************************
*                                                               *
*        TEST SSW6 TO REPEAT OR BRING IN NEXT TEST              *
*                                                               *
*****************************************************************
       REM            
*      TEST SSW6      
       REM            
WPRA   SWT 3          
       TRA *+2        
       TRA TEST       
       REM            
       WPRA           TO
       SPRA 3         PRINT
       RCHA NPER      IDENTIFICATION
       TRA TEST       
       REM            
SW6    SWT 3          
       TRA *+2        
       TRA *+4        
       REM
       WPRA           
       SPRA 3         
       RCHA PPCOM     
       REM            
       SWT 6          
       TRA *+2        SELECT CARD READER
       TRA TEST       REPEAT TEST
       REM            
       RCDA           CALL
       RCHA *+3       NEXT
       LCHA 0         PROGRAM
       TRA 1          
       IOCT 0,0,3     
       REM            
CHECK  CLA COUNT      
       STA *+1        
       TRA            
       REM            
       REM            
*****************************************************************
*                                                               *
*                   CONSTANTS AND IMAGES                        *
*                                                               *
*****************************************************************
       REM            
RST    HTR 5,1        
COUNT  OCT 0          
       REM            
NPER   IOCD CRIM,0,24 TO PRINT IDENTIFICATION
PPCOM  IOCD CRIM1,0,24 TO PRINT PASS COMPLETE
       REM            
CT2    OCT 0          
CT3    OCT 0          
K2     OCT 2          
K6     OCT 6          
K9A    TXH AA+1,2,96  
K9B    TXH AA+1,2,120 
K9C    TXH PP+1,2,72  
K9D    TXH PP+1,2,48  
K9E    TXH PP+1,2,24  
K9F    CLA K9G        
K9G    TXH PP+1,2,1   
K9J    CLA K9D        
K9L    TXH BB+1,2,48  
K9M    TXH BB+1,2,24  
K9N    CLA K9O        
K9O    TXH BB+1,2,1   
K9P    TXH BB+1,2,72  
K9Q    CLA K9L        
K9R    SLW PB+1       
K9S    SLW PD+1       
K9T    LXA K30,1      L 30
K9U    TIX AA,2,1     
K9V    TIX AA7,2,1    
K9W    LXA K26,1      
K9X    LXA K22,1      
K9Y    LXA K24,1      
K12    OCT 12         
K22    OCT 22         
K24    OCT 24         
K26    OCT 26         
K30    OCT 30         
K31    OCT 31         
K37    OCT 377777777777
K65    OCT 65         
K110   OCT 110        
K111   OCT 111        
K114   OCT 114        
K140   OCT 140        
K141   OCT 141        
K220   OCT 220        
K330   OCT 330        
K440   OCT 440        
K454   OCT 454        
K455   OCT 455        
K1100  OCT 1100       
KTRA1  TRA PP8C       
KTXL1  TXL LCC,2,1    
KTRA   TRA BB8C       
KTXL   TXL LC,2,1     
       REM            
ONE    OCT 1          
ONES   OCT 777777777777
SAV1   OCT 0          
TEMP   OCT 0          
TB5    TRA B5         
TWO    OCT 2          
T30    TRA PRST       
TRC    TRA READ       
XRC    OCT 0          
       REM            
*      INITIAL CARD PUNCH IMAGE
       REM            
PA     OCT 0          9L
       OCT 2000       9R
       OCT 0          8L
       OCT 1000       8R
       OCT 0          7L
       OCT 400        7R
       OCT 0          6L
       OCT 200        6R
       OCT 0          5L
       OCT 100        5R
       OCT 0          4L
       OCT 40         4R
       OCT 0          3L
       OCT 20         3R
       OCT 0          2L
       OCT 10         2R
       OCT 0          1L
       OCT 4          1R
       OCT 0          0L
       OCT 2          0R
       OCT 0          11L
       OCT 1          11R
       OCT 0          12L
       OCT 0          12R
PAA    OCT 0          
       REM            
*      SHIFTING CARD PUNCH IMAGE
       REM            
PB     BSS 24         
PBB    OCT 0          
       REM            
*      READ IMAGE     
       REM            
PC     BSS 24         
PCC    OCT 0          
       REM            
PD     BSS 53         
PDD    OCT 0          
       REM            
PE     BSS 24         
PEE    OCT 0          
       REM            
PR     OCT 357642357563
PRM    OCT 245716312345
PRM1   OCT 0          
       REM            
PUCTR  IOCD PE,0,24   PUNCH HEAVY SEMI-RIPPLE
       IOCD PB,0,24   PUNCH LIGHT RIPPLE
       IOCD PD,0,24   PUNCH RANDOM PATTERN
       REM            
       IOCD PB,0,24   READ HEAVY SEMI-RIPPLE
       IOCD PC,0,24   STANDARD READ IMAGE
       IOCD PE,0,24   READ RANDOM PATTERN
       REM            
*IMAGE-NOW PERFORMING DIAGNOSTIC -9R01-PUNCH TEST
       REM            
CRIM   OCT 112040230           9L
       OCT 0                   9R
       OCT 0                   8L
       OCT 20000000000         8R
       OCT 400410000           7L
       OCT 400000000000        7R
       OCT 6060002000          6L
       OCT 0                   6R
       OCT 10201004000         5L
       OCT 102000000000        5R
       OCT 4100000             4L
       OCT 200000000000        4R
       OCT 500                 3L
       OCT 44400000000         3R
       OCT 1000                2L
       OCT 1000000000          2R
       OCT 20002               1L
       OCT 0                   1R
       OCT 2000001404          0L
       OCT 205400000000        0R
       OCT 14535006051         11L
       OCT 500000000000        11R
       OCT 242570300           12L
       OCT 062000000000        12R
       REM            
*IMAGE-PASS COMPLETE-9R01-ALL PUNCHES TESTED
       REM            
CRIM1  OCT 3000                9L
       OCT 0                   9R
       OCT 0                   8L
       OCT 100000000000        8R
       OCT 100200002           7L
       OCT 0                   7R
       OCT 1000000             6L
       OCT 0                   6R
       OCT 50000               5L
       OCT 442200000000        5R
       OCT 400001              4L
       OCT 100000000           4R
       OCT 2120030             3L
       OCT 204400000000        3R
       OCT 30000000            2L
       OCT 21000000000         2R
       OCT 40000240            1L
       OCT 0                   1R
       OCT 30020401            0L
       OCT 25400000000         0R
       OCT 101705132           11L
       OCT 400000000000        11R
       OCT 42050040            12L
       OCT 342300000000        12R
ERROR  EQU 3396       
OK     EQU 3401       
WDNO   EQU 3438       
RECNO  EQU 3439       
IOC    EQU 2892       
CTRL1  EQU 2880       
CTRL2  EQU 2881       
CTRL3  EQU 2882       
CTX    EQU 2890       
       END            
                      
