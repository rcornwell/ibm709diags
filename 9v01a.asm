                                                             9V01A
                                                            7-01-58
                      
       REM                      9V01A
       REM            
       ORG 24         
       CLA TRA        POST
       STO 0            RESTART
BEGIN  SLF            TURN OFF SENSE LIGHTS
       REM            
SS1    SWT 1          TEST SENSE SWITCH ONE
       TRA SS2         UP- TEST SSW2
       TRA JACK       DWN- PERFORM UNIONJACK
       REM            
SS2    SWT 2          TEST SENSE SWTICH TWO
       TRA SS3        UP- TEST SSW3
       TRA DOT        DWN- PERFORM DOT
       REM                  CHECKERBOARD
       REM            
SS3    SWT 3          TEST SENSE SWITCH THREE
       TRA SS4        UP- TEST SSW4
       TRA LIGHT      DWN- PERFORM INTENSITY
       REM                           TEST
       REM            
SS4    SWT 4          TEST SENSE SWITCH FOUR
       TRA SS5        UP- TEST SSW5
       TRA BIG        DWN-PERFORM DOT INTENSITY 
       REM                       TEST
       REM            
SS5    SWT 5          TEST SENSE SWITCH FIVE
       TRA SS6        UP- TEST SSW6
       TRA BRAKE      DWN- PERFORM FILM CREEP
       REM                      TEST
       REM            
SS6    SWT 6          
       TRA BEGIN      REPEAT PROGRAM
       PSE 24         ADVANCE FILM ONE FRAME
       HTR BEGIN      STOP AFTER FILM ADVANCE
       REM            
       REM            
*    UNION JACK ROUTINE
JACK   LXA KK1,1       L 12
       WTV            
       SLN 1          SET LIGHT ONE ON
       CPY KK1,1      
       TIX *-1,1,1    
       SLF            TURN OFF LIGHTS
       TRA SS2         GO TEST SSW
       REM            
       REM            
       REM            
*DOT CHECKERBOARD TEST 
       REM            
DOT    WTV            
       SLN 2          TURN ON SENSE LIGHT TWO
       STZ DIS        
       LXA Q,4        L 2000
ROW    LXA Q,2        L 2000
NEXT   PXD 0,2        
       SUB Q1         L 002000 000000
       SSP            
       STO DIS        
       CPY DIS        
       TIX NEXT,2,64  
       REM            
       CLA DIS        
       ADD KON2       L 77
       STO DIS        
       CPY DIS        
       PXD 0,4        
       ARS 18         
       SUB Q2         L 000000 002100
       SSP            
       STA DIS        
       TIX ROW,4,64   
       REM            
       LXA Q,1        L 2000
LAST   PXD 0,1        
       SUB Q1         L 002000 000000
       SSP            
       STO SIN        
       CPY SIN        
       TIX LAST,1,64  
       REM            
       CLA SIN        
       ADD KON2       L 77
       STO SIN        
       CPY SIN        
       SLF              TURN OFF SENSE LIGHT
       TRA SS3        RETURN TO SENSE SWITCH
       REM            
       REM            
       REM            
*INTENSITY TEST       
       REM            
       REM            
LIGHT  WTV            
       SLN 3          TURN LIGHT THREE ON
       LXD P,2        L 2
B      LXA W,1        L 400
A      CPY Z,2        
       CLA Z,2        
       ADD W,2        
       STO Z,2        
       TIX A,1,1      
       REM            
       TIX B,2,1      
       CLA Z          
       STA X          
       STD Y          
       SLF            TURN OFF SENSE LIGHT
       TRA SS4         RETURN TO SENSE SWITCH
       REM            
       REM
       REM            
*START DOT INTENSITY TEST
       REM            
BIG    WTV            
       SLN 4          TURN LIGHT FOUR ON
       LXA N,4        
F      CLA CPY        
       SSM            
       ADD M L-000100 000100
       STO CPY        
       CPY CPY        
       CLA CPY        
       ADD M          L-000100 000100
       SSP            
       STO CPY        
       CPY CPY        
       TIX F,4,1      
       REM            
       CLA G          L-377677 777677
       STO CPY        
       SLF            TURN OFF SENSE LIGHT
       TRA SS5        
       REM            
       REM            
*START FILM CREEP     
       REM            
       REM            
BRAKE  WTV            
       SLN 1          TURN ON SENSE LIGHTS
       SLN 4             ONE AND FOUR
       PSE 24         
       CPY POINT      
       HPR            
       CPY V          
       CPY H          
       SLF            
       HTR SS6        
       REM            
       REM            
       REM            
*CONSTANTS FOR PROGRAM 
       REM            
       REM            
*UNIONJACK CONSTANTS  
       REM            
       REM            
       OCT 200000000000  LEFT VERTICAL
       OCT 101777000000  TOP HORIZONTAL
       OCT 100000000000  BOTTOM HORIZONTAL
       OCT 200000001777  EXTREME RIGHT VERITCAL
       OCT 300000000000  DIAGONAL
       OCT 101000000000  CENTER HORIZONTAL
       OCT -000000000000 LOWER LEFT HIGH
       REM                  INTENSITY SPOT
       OCT -001777000000 LOWER RIGHT HIGH
       REM                  INTENSITY SPOT
       REM            
       OCT -000000001777 UPPER LEFT HIGH
       REM                 INTENSITY SPOT
       OCT -001777001777 UPPER RIGHT HIGH
       REM                  INTENSITY SPOT
       OCT -001000001000 CENTER HIGH 
       REM                  INTENSTIY SPOT
       OCT 200000001000 CENTER VERITAL
       REM            
KK1    OCT 14         
       REM            
       REM            
       REM            
*DOT CHECKERBOARD CONSTANTS
K      OCT 2000007    
Q      OCT 2000       
Q1     OCT 2000000000 
Q2     OCT 2100       
DIS    OCT            
KON1   OCT 000000000000
KON2   OCT 77000000   
SIN    OCT 1777       
TRA    TRA BEGIN      RESET TRANSFER
       REM            
       REM            
       REM            
*INTENSITY TEST CONSTANTS
       REM            
T      OCT 4          
U      OCT 4000000  
W      OCT 400        
X      OCT 200000000000 
Y      OCT 100000000000 
Z      OCT 000000000000 
P      OCT 2000000    
       REM            
       REM            
       REM            
*DOT INTENSITY CONSTANTS
       REM            
CPY    OCT -3776777777677
M      OCT -0001000000100
N      OCT 10         
G      OCT -3776777777677
       REM            
       REM            
       REM            
*FILM CREEP CONSTANTS 
       REM            
POINT  OCT 1000001000 
V      OCT 101000001020
H      OCT 201020001000
       END            
