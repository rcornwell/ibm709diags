                                                            9CNPA          
                                                           9-15-58
       REM
       REM       9CNPA
       REM
*CONSECUTIVE NUMBERING PUNCH TEST
       REM
       REM
       ORG 24
       CLA REST      POST RESTART
       STO 0
       REM  
       AXT 3599,1
WPU    WPUA          PUNCH 150 CARDS ALL
       RCHA PCNT     PUNCHES CONSECUTIVE
       LCHA PCNT+1   NUMBERING
       TIX *-1,1,1   REPEAT FOR 150 CARDS
       REM  
       HTR *+1       ENTER INTO KEYS ANY
       REM           OCTALNUMBER FROM 00000
       REM           TO 23417 AND PRESS START
       ENK           ENTER INTO MQ
       REM  
START  AXT 24,1
       STZ IMAGE+24,1 CLEAR IMAGE
       TIX *-1,1,1   AREA
       REM  
       STQ SAVE
DEC    CLA SAVE      BINARY TO DECIMAL
       TZE RESET     CONVERTER TO SET CARD
       XCA           IMAGE OF NUMBER TO BE
       REM           PUNCHED
       PXD           CLEAR ACC.
       DVP TEN       L 12
       STQ SAVE
       ALS 1
       SUB CONST     L 1022
       STA *+2
       CLA ONE       L 1
       ORS 0         NUMBER ENTERED INTO
       ALS 1         KEYS IS CONVERTED
       STO ONE       FROM OCTAL TO DECIMAL
       TRA DEC
       REM  
       REM  
RESET  CLA CNTR      L 1 - RESTORE
       STO ONE       COUNTER
       REM  
WPU1   WPUA          PASS 1 BLANK CARD
       SPUA 2        RESET COUNTER
       REM  
WPU2   WPUA
       SWT 5
       TSX DELAY,4   IF UP GO TO DELAY ROUTINE
       SPUA 1
       RCHA PCNT1    PUNCH CARD FROM
       REM           SYMBOLIC LOCATION-IMAGE
       AXT 10,2      LOAD TO PUNCH 10 CARDS
       AXT 22,1      LOAD TO PUNCH 1 CARD
WPU4   WPUA          PUNCH 10 CARDS-ALL PUNCHES
       REM           SHOULD NUMBER FROM N-N+10
       RCHA PCNT     S TRG ON WC-1
       LCHA PCNT+1   S AND 1 TRGS ON WC-1
       TIX *-1,1,1   REPEAT FOR ONE CARD
       TIX WPU4-1,2,1 REPEAT FOR 10 CARDS
       REM           WILL RE-SELECT AT EOR
       WPUA          SELECT PUNCH
       SWT 5         CHECK SW5 FOR DELAY
       TSX DELAY,4 
       SPUA 2        NO
       REM           PASS BLANK CARD
       AXT 240,1
       CLA D
       STO IMAGE+264,1 SET 10 CARD IMAGES
       TIX *-1,1,1   TO ALL ONES
       REM  
WPU3   WPUA
       RCHA PCNT2    PUNCH 10 CARDS-ALL PUNCHES
       TCOA *        WAIT FOR ALL CARDS
       REM  
       SWT 6         TEST FOR NEXT PROGRAM
       TRA *+2       UP-READ
       TRA START-2   DOWN-REPEAT TEST
       REM  
       RCDA          READ
       RCHA *+3      NEXT
       LCHA 0        PROGRAM
       TRA 1
       IOCT 0,0,3
       REM  
DELAY  AXT 833,1     20 MILLISECOND
       TIX *,1,1     DELAY
       TRA 1,4       EXIT
REST   TRA START-2   RESTART
PCNT   IOCP D,0,1    PUNCH ONE WORD + CONTINUE
       IOCT D,0,1    PUNCH ONE WORD AND WAIT
       REM           LCH FROM MF
SAVE   OCT 0         TEMPORARY STORAGE
TEN    DEC 10
D      OCT 777777777777
ONE    OCT 1
CNTR   OCT 1
CONST  OCT 1022
PCNT1  IOCD IMAGE,0,24
PCNT2  IOCD IMAGE+24,0,240 PUNCH 10 CARDS
       ORG 512
IMAGE  BSS 24         CARD IMAGE
       END

