                                                            9SY1A
                                                            3-1-59
       REM                           9SY1 SYSTEM CHECK
       REM
       REM
       ORG 24         
       REM
*THIS SECTION WILL BE READ IN, AND ANY DRUMS, CRT, AND BUFFER
*INSTRUCTIONS WILL BE TESTED. IF SWITCH 6 IS NOT DOWN
*THIS SECTION WILL READ IN THE SECOND SECTION, WHICH TEST ALL
*MAIN FRAME INSTRUCTIONS, WHILE PERFORMING COMBINATIONS
*OF READING AND WRITING ALL I/O UNITS SELECTED.
       REM            
       REM            
BEGIN  CLA RSET       
       STO 0          
       REM            
       AXT 15,1       CLEAR
       STZ CRCHA+15,1 SWITCH
       TIX *-1,1,1    CONSTANTS
       REM            
       TSX IOC,4      TO ENTER I/O SELECTION
       REM            
       AXT 5,1        
       CLA CTRA       COUNT FOR CHAN A
       CAS CTRA+6,1   COMPARE TO NEXT COUNT
       TRA *+3        ACC GREATER
       TRA *+2        ACC EQUAL
       TRA *+3        ACC LESS
       TIX *-4,1,1    ENTRY HERE NO CHANGE
       TRA *+3        
       CLA CTRA+6,1   ENTRY HERE BRINGS IN
       TIX *-7,1,1    NEXT HIGHEST COUNT
       STO TPCNT      THIS SHOULD STORE HIGEST
       REM            COUNT
       STO STPCT      SAVE COUNT
       REM            
 TCW1  CLA CTRL1      BRING IN 1ST CONTROL
       TPL CTAPE      
       TZE TCW2       IS IT ZERO
       PAI            NO-PLACE INTO INDICATORS
       REM            
       CLA ONES       L-ALL ONES
       RNT 1          TEST FOR CR CHAN. A
       TRA *+2        NO
       STO CRCHA      YES
       REM            
       RNT 2          TEST FOR PR CHAN. A
       TRA *+2        NO
       STO PRCHA      YES
       REM            
       RNT 4          TEST FOR PU CHAN A
       TRA *+2        NO
       STO PUCHA      YES
       RNT 10         TEST FOR TAPE CHAN A
       TRA *+2        NO
       STO TPCHA      YES
       REM
       RNT 1000       TEST FOR TAPE CHAN B
       TRA *+2        NO
       STO TPCHB      YES
       REM            
 TCW2  CLA CTRL2      BRING IN 2ND CNTROL
       TZE TCW3       IS IT ZERO
       PAI            NO-PLACE INTO INDICATORS
       REM            
       CLA ONES       L-ALL ONES
       RNT 1          TEST FOR CR CHAN. C
       TRA *+2        NO
       STO CRCHC      YES
       REM            
       RNT 2          TEST FOR PR CHAN. C
       TRA *+2        NO
       STO PRCHC      YES
       REM            
       RNT 4          TEST FOR PU CHAN C
       TRA *+2        NO
       STO PUCHC      YES
       REM
       RNT 10         TEST FOR TAPE CHAN C
       TRA *+2        NO
       STO TPCHC      YES
       REM
       RNT 1000       TEST FOR TAPE CHAN D
       TRA *+2        NO
       STO TPCHD      YES
       REM            
 TCW3  CLA CTRL3      BRING IN 3ND CNTROL
       TZE BEGN       IS IT ZERO
       PAI            
       REM            
       CLA ONES       L-ALL ONES
       RNT 1          TEST FOR CR CHAN. E
       TRA *+2        NO
       STO CRCHE      YES
       REM            
       RNT 2          TEST FOR PR CHAN. E
       TRA *+2        NO
       STO PRCHE      YES
       REM            
       RNT 4          TEST FOR PU CHAN E
       TRA *+2        NO
       STO PUCHE      YES
       REM            
       RNT 10         TEST FOR TAPE CHAN E
       TRA *+2        NO
       STO TPCHE      YES
       REM            
       RNT 1000       TEST FOR TAPE CHAN F
       TRA *+2        NO
       STO TPCHF      YES
       REM            
 BEGN  CAL CMOUT      TO MASK OUT CARD MACHINES
       ANS CTRL1      
       ANS CTRL2      
       ANS CTRL3      
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
       ORG BEGN+4     
       REM            
       TSX CTX,4      
       HTR BCDTA,0,BCDF+2
       REM            
       REM            
       REM            
*TEST THAT DEPRESSING START KEY DOES NOT RESET BUFFER
       REM            
       SWT 3          TEST SWITCH 3
       TRA *+2        UP-TEST START KEY
       TRA TPA-6      DN-IGNORE ST KEY TEST
       REM            
       CLA COUNT      IF ZERO
       TZE TPA-6      
       REM            
STKY   TCOA *         
       SCHA SAVE      AT THIS LOCATION
       TRA *+2        
       REM            
       BCD 1SRTKEY    
       CLA SAVE       WORD FROM DSC
       LDQ SCHTR      CORRECT WORD
       CAS SCHTR      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  IF ERROR OCCURS HERE
       REM            THERE IS QUITE POSSIBLY
       REM            AN OPEN DIODE IN
       REM            OR CIRCUIT 1223-A
       REM            SYSTEMS PAGE 4.08
       NOP *-6        
       TSX OK,4       IF SWITCH 4 IS DOWN HERE
       TRA STKY       TRA BACK WILL BE TO TCOA
       NOP            TAPE.
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000   START KEY RESET-SECTION 1 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN     
       REM            
TPA    NZT TPCHA      
       TRA HENRY-10   NO-CHECK CHAN B
       TSX CTX,4      
       HTR ABLE-9,0,HENRY-10
       REM            
       BSRA           MACHINE MAY HANG UP
       WTBA           IN ONE OR BOTH OF THESE
       RCHA ZERO      ROUTINES. IF A HANG UP
       REM            CONDITION OCCURS THE TAPE
       REM            UNIT SELECT NEON ON DS
       REM            WILL PROBABLY BE UP, AND
       REM            THE RESET OF DS, RESET.
       REM            THE CAUSE OF THE TROUBLE
       REM            MAY BE THAT A ZERO CONTROL
       REM            WORD DID NOT RESET THE
       REM            TAPE UNIT TGR.
       REM            
       ETTA           
       REWA           
       TRA *+2        
       REM            
       BCD 1TCOA      TEST TRANS CHANNEL A IN OPN
       REM            
ABLE   WTBA           
       TCOA *+3       CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL ABLE       
       REM            
       RCHA CNTL      NO TGRS ON-WORD. CNT. 1
       TCOA *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL ABLE       
       REM            
       TCOA *         IF UNIT RUNS AWAY, OR
       REM            MACHINE HANGS ON THIS
       REM            OR ANY PREVIOUS TCOA
       REM            OPN.,BUFFER MAY NOT BE 
       REM            RECEIVING END OPER. FROM
       REM            SYNC.
       TCOA *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  TRANS. IN ERROR-TCOA
       TXL ABLE       
       REM            
       TRA *+2        
       REM            
       BCD 1TCNA      TEST TRANS. CHAN NOT IN OPN
       REM            
BAKER  TCNA *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS.
       TXL BAKER      
       REM            
       WTBA           
       TCNA *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL BAKER      
       REM            
       RCHA CNTL+1    NO TGRS. ON-WRD. CNT. 1
       TCNA *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL BAKER      
       REM            
       TCOA *         
       TCNA *+3       SHOULD TRANS.
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL BAKER      
       REM            
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA ABLE       REPEAT
       REM            
       BCD 1BTTA      TEST BEGIN. TAPE
       REM            
CHUCK  REWA           
       BSRA           BACKSPACE TO LOAD PT.
       REWA           SHOULD ACT AS NOP
       BSRA           TRY TO BCKSP OVER LD. PT.
       TCOA *         DELAY
       REM            BEGIN. TAPE TGR. SHOULD
       REM            BE TURNED ON HERE
       BTTA           
       TRA *+3        OK-SHOULD BE ON
       TSX ERROR-1,4  SHLD NOT SKIP TO ENTER HERE
       TXL CHUCK      
       REM            
       BTTA           
       TRA *+2        ERROR-BTT SHOULD BE OFF
       TRA *+3        OK-OFF
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL CHUCK      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA CHUCK      
       REM            
       BCD 1IOT       TEST I/O CHECK TGR.
       REM            
DOG    WTBA           
       RCHA CNTL      NO TGRS. ON-WRD. CNT. 1
       TCOA *         
       LCHA CNTL+1    SHOULD TURN ON IOT
       IOT            
       TRA *+3        SHOULD ENTER HERE-OK
       TSX ERROR-1,4  ERROR-SHOULD NOT SKIP
       TXL DOG        
       REM            
       IOT            
       TRA *+2        ERROR-TGR WAS NOT TURNED
       REM            OFF BY PREVIOUS SEQUENCE
       TRA *+3        OK-TGR SHOULD BE OFF
       TSX ERROR-1,4  
       TXL DOG        
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA DOG        
       REM            
       BCD 1WEFA      TEST WEF BINARY AND BCD
       REM            
       WTDA           
       RCHA CNTL      NO TGRS. ON-WRD. CNT. 1
       WEFA           
       WTBA           
       RCHA CNTL+1    NO. TGRS ON-WRD. CNT. 1
       WEFA 16        BINARY EOF
       TRA *+2        
       REM            
       BCD 1BSRA      
       REM            
EASY   BSRA 16        
       BSRA           
       RTBA           
       RCHA CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOA *         
       REM            
       CLA READ       WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP EASY       DO NOT REPEAT
       TSX RDNCK,4    
       TRA EASY       
       REM            
       TEFA *+3       SHOULD TTRANS
       TSX ERROR-1,4  EOF DID NOT COME UP
       TXL GEORG      
       TRA *+2        
       REM            
       BCD 1BSFA      
       REM            
FOX    BSFA           BKSP OVER EOF
       BSFA           BKSP OVER EOF AND 1 REC
       BSRA           BKSP OVER 1 REC
       RTDA           
       RCHA CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOA *         TO READ OEN WD AND BCD EOF
       TRA *+2        CONTINUE
       REM            
       BCD 1TEFA      TEST EOF TGR + INDICATOR
       REM            
GEORG  TEFA *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL GEORG,4,0  DO NOT REPEAT
       REM            
       TEFA *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  ERROR-TGR SHOULD BE OFF
       TXL GEORG,4,0  DO NOT REPEAT
       REM            
       RTBA           
       RCHA CNTLR+2   NO TGRS ON-WRD CNT 2
       REM            TO READ ONE WD AND BIN EOF
       TCOA *         DELAY
       TRA *+2        
       REM            
       BCD 1 TEFA     TEST EOF TGR + INDICATOR
       REM            
       TEFA *+3       
       TSX ERROR-1,4  
       TXL *-2,4,0    DO NOT REPEAT
       REM            
       CLA READ       WORD READ
       LDQ ONES       WORD WRITTEN
       CAS ONES       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP FOX        
       TSX RDNCK,4    TEST RDNCY
       TRA FOX        
       REM            
       CLA READ+2     WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP FOX        
       TSX OK,4       OUT TO TEST SWITCHES
       TRA EASY       REPEAT
       NOP            
       REM            
*TEST INSTRUCTIONS CHAN B SYNC
       REM            
       NZT TPCHB      
       TRA CHANC      NO-CHECK CHAN C
       TSX CTX,4      
       HTR *+1,0,CHANC 
       TRA *+2        
       REM            
       BCD 1TCOB      TEST TRANS. CHANNEL BIN OPN
       REM            
       BSRA           MACHINE MAY HANG UP
       WTBA           IN ONE OR BOTH OF THESE
       RCHA ZERO      ROUTINES. IF A HANG UP
       REM            CONDITION OCCURS THE TAPE
       REM            UNIT SELECT NEON ON DS
       REM            WILL PROBABLY BE UP, AND
       REM            THE RESET OF DS, RESET.
       REM            THE CAUSE OF THE TROUBLE
       REM            MAY BE THAT A ZERO CONTROL
       REM            WORD DID NOT RESET THE
       REM            TAPE UNIT TGR.
       REM            
       ETTB           
       REWB           
       REM            
HENRY  WTBB           
       TCOB *+3       CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL HENRY-5    
       REM            
       TCOB *         IF UNIT RUNS AWAY, OR
       REM            MACHINE HANGS ON THIS
       REM            OR ANY PREVIOUS TCOA
       REM            OPN.,BUFFER MAY NOT BE 
       REM            RECEIVING END OPER. FROM
       REM            SYNC.
       TCOB *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  TRANS. IN ERROR-TCOA
       TXL HENRY-5    
       REM            
       TSX OK,4       OUT TO CHECK SWITCHS
       TXL HENRY-5    REPEAT
       REM            
       BCD 1TCNB      TEST TRANS. CHAN NOT IN OPN
       REM            
INDIA  TCNB *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS.
       TXL INDIA      
       REM            
       WTBB           
       TCNB *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL INDIA      
       REM            
       RCHB CNTL+1    NO TGRS. ON-WRD. CNT. 1
       TCNB *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL INDIA      
       REM            
       TCOB *         
       TCNB *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL INDIA      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA INDIA      
       REM            
       BCD 1BTTB      TEST BEGIN. TAPE
       REM            
JULIA  REWB           
       BSRB           BACKSPACE TO LOAD PT.
       REWB           SHOULD ACT AS NOP
       BSRB           TRY TO BCKSP OVER LD. PT.
       TCOB *         DELAY
       REM            BEGIN. TAPE TGR. SHOULD
       REM            BE TURNED ON HERE
       BTTB           
       TRA *+3        OK-SHOULD BE ON
       TSX ERROR-1,4  SHLD NOT SKIP TO ENTER HERE
       TXL JULIA      
       REM            
       BTTB           
       TRA *+2        ERROR-BTT SHOULD BE OFF
       TRA *+3        OK-OFF
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL JULIA      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA JULIA      
       REM            
       BCD 1IOT       TEST I/O CHECK TGR.
       REM            
KILO   WTBB           
       RCHB CNTL      NO TGRS. ON-WRD. CNT. 1
       TCOB *         
       LCHB CNTL+1    SHOULD TURN ON IOT
       IOT            
       TRA *+3        SHOULD ENTER HERE-OK
       TSX ERROR-1,4  ERROR-SHOULD NOT SKIP
       TXL KILO       
       REM            
       IOT            
       TRA *+2        ERROR-TGR WAS NOT TURNED
       REM            OFF BY PREVIOUS SEQUENCE
       TRA *+3        OK-TGR SHOULD BE OFF
       TSX ERROR-1,4  
       TXL KILO       
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA KILO       
       REM            
       BCD 1WEFB      TEST WEF BINARY AND BCD
       REM            
       WTDB           
       RCHB CNTL      NO TGRS. ON-WRD. CNT. 1
       WEFB           
       WTBB           
       RCHB CNTL+1    NO. TGRS ON-WRD. CNT. 1
       WEFB 16        BINARY EOF
       TRA *+2        
       REM            
       BCD 1BSRB      
       REM            
LIMA   BSRB 16        
       BSRB           
       RTBB           
       RCHB CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOB *         
       REM            
       CLA READ       WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP LIMA       DO NOT REPEAT
       TSX RDNCK,4    
       TRA LIMA       
       REM            
       TEFB *+3       
       TSX ERROR-1,4  
       TXL NOV        
       TRA *+2        
       REM            
       BCD 1BSRB      
       REM            
MIKE   BSFB           BKSP OVER EOF
       BSFB           BKSP OVER EOF AND 1 REC
       BSRB           BKSP OVER 1 REC
       RTDB           
       RCHB CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOB *         TO READ OEN WD AND BCD EOF
       TRA *+2        CONTINUE
       REM            
       BCD 1TEFB      TEST EOF TGR + INDICATOR
       REM            
NOV    TEFB *+3       SHOULD TRANS.
       TSX ERROR-1,4  ERROR TGR SHOULD BE OFF
       TXL NOV,4,0    DO NOT REPEAT
       REM            
       REM            
       TEFB *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  ERROR-TGR SHOULD BE OFF
       TXL NOV,4,0    DO NOT REPEAT
       REM            
       RTBB           
       RCHB CNTLR+2   NO TGRS ON-WRD CNT 2
       REM            TO READ ONE WD AND BIN EOF
       TCOB *         DELAY
       TRA *+2        
       REM            
       BCD 1 TEFB     TEST EOF TGR + INDICATOR
       REM            
       TEFB *+3       
       TSX ERROR-1,4  
       TXL *-2,4,0    DO NOT REPEAT
       REM            
       CLA READ       WORD READ
       LDQ ONES       WORD WRITTEN
       CAS ONES       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP MIKE       
       TSX RDNCK,4    TEST RDNCY
       TRA MIKE       
       REM            
       CLA READ+2     WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP NOV        
       TSX OK,4       OUT TO TEST SWITCHES
       TRA LIMA       REPEAT
       NOP            
       REM            
 CHANC NZT TPCHC      TEST FOR TAPE CHAN C
       TRA CHAND      NO-CHECK CHAN D
       TSX CTX,4      
       HTR *+1,0,CHAND 
       REM            
       REM            
       REWC           MACHINE MAY HANG UP
       BSRC           IN ONE OR BOTH OF THESE
       WTBC           ROUTINES. IF A HANG UP
       RCHC ZERO      CONDITION OCCURS THE TAPE
       REM            UNIT SELECT NEON ON 
       REM            THE DSC WILL PROBABLY
       REM            BE ON, AND THE RESET OF
       REM            DSC RESET.
       REM            THE CAUSE IS PROBABLY
       REM            DUE TO THE FACT THAT
       REM            RESETTING CHANNEL WITH 
       REM            ZERO CONTROL DID NOT RESET
       REM            THE UNIT SELECT TRIGGER
       ETTC           
       REWC           
       TRA *+2        
       REM            
       BCD 1TCOC      TEST TRANS CHAN. C IN OPN.
       REM            
 STCC  WTBC           
       TCOC *+3       CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL STCC       
       REM            
       RCHC CNTL      NO INDS ON-WORD CNT. 1
       TCOC *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL STCC       
       REM            
       TCOC *         
       REM            
       TCOC *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  TRANS. IN ERROR-TCOA
       TXL STCC       
       TRA *+2        
       REM            
       BCD 1TCNC      
       REM            
 STCC1 TCNC *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS.
       TXL STCC1      
       REM            
       WTBC           
       TCNC *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STCC1      
       REM            
       RCHC CNTL+1    NO TGRS. ON-WRD. CNT. 1
       TCNC *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STCC1      
       REM            
       TCOC *         
       TCNC *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL STCC1      
       REM
       TSX OK,4       
       TRA STCC1      
       REM            
       BCD 1BTTC      
       REM            
 STCC2 REWC           REWIND
       BSRC           BACKSPACE TO LD. PT.
       REWC           SHOULD ACT AS NOP
       BSRC           TRY TO BCKSP OVER LD. PT.
       REM            BEGIN TAPE IND. SHOULD
       REM            BE TURNED ON HERE
       TCOC *         
       REM            
       BTTC           
       TRA *+3        OK-SHOULD BE ON
       TSX ERROR-1,4  SHLD NOT SKIP TO ENTER HERE
       TXL STCC2      
       REM            
       BTTC           
       TRA *+2        ERROR-BTT SHOULD BE OFF
       TRA *+3        OK-OFF
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STCC2      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA STCC2      
       REM            
       BCD 1IOT       TEST I/O CHECK TGR.
       REM            
 STTC3 WTBC           
       RCHC CNTL      NO TGRS. ON-WRD. CNT. 1
       TCOC *         
       LCHC CNTL+1    SHOULD TURN ON IOT
       IOT            
       TRA *+3        SHOULD ENTER HERE-OK
       TSX ERROR-1,4  ERROR-SHOULD NOT SKIP
       TXL STTC3      
       REM            
       IOT            
       TRA *+2        ERROR-TGR WAS NOT TURNED
       REM            OFF BY PREVIOUS SEQUENCE
       TRA *+3        OK-TGR SHOULD BE OFF
       TSX ERROR-1,4  
       TXL STTC3      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA STTC3      
       REM            
       BCD 1WEFC      TEST WEF BINARY AND BCD
       REM            BCD TO MAKE CERTAIN 
       REM            THEY BOTH WORK IN BCD
       REM            MODE
       REM            
       REM            
       WTDC           
       RCHC CNTL      NO TGRS. ON-WRD. CNT. 1
       WEFC           
       WTBC           
       RCHC CNTL+1    NO. TGRS ON-WRD. CNT. 1
       WEFC 16        BINARY EOF
       TRA *+2        
       REM            
       BCD 1BSRC      
       REM            
 STTC4 BSRC 16        
       BSRC           
       RTBC           
       RCHC CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOC *         
       REM            
       CLA READ       WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTC4      DO NOT REPEAT
       TSX RDNCK,4    
       TRA STTC4      
       REM            
       TEFC *+3       
       TSX ERROR-1,4  
       TXL STTC4      
       TRA *+2        
       REM            
       BCD 1BSFC      
       REM            
 STTC5 BSFC           BKSP OVER EOF
       BSFC           BKSP OVER EOF AND 1 REC
       BSRC           BKSP OVER 1 REC
       RTDC           
       RCHC CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOC *         TO READ OEN WD AND BCD EOF
       TRA *+2        CONTINUE
       REM            
       BCD 1TEFC      TEST EOF TGR + INDICATOR
       REM            
 STTC6 TEFC *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL STTC6,4    
       REM            
       TEFC *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  
       TXL STTC6,4    
       RTBC           
       RCHC CNTLR+2   NO TGRS ON-WRD CNT 2
       REM            TO READ ONE WD AND BIN EOF
       TCOC *         DELAY
       REM            
       TEFC *+3       
       TSX ERROR-1,4  
       TXL STTC6,4    
       REM            
       CLA READ       WORD READ
       LDQ ONES       WORD WRITTEN
       CAS ONES       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTC5      
       TSX RDNCK,4    TEST RDNCY
       TRA STTC5      
       REM            
       CLA READ+2     WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTC5      
       TSX OK,4       OUT TO TEST SWITCHES
       TRA STTC4      REPEAT
       NOP            
       REM            
 CHAND NZT TPCHD      TEST FOR TAPE CHAN D
       TRA CHANE      NO
       TSX CTX,4      
       HTR *+1,0,CHANE 
       REM            
       REM            
       REWD           MACHINE MAY HANG UP
       BSRD           IN ONE OR BOTH OF THESE
       WTBD           ROUTINES. IF A HANG UP
       RCHD ZERO      CONDITION OCCURS THE TAPE
       REM            UNIT SELECT NEON ON 
       REM            THE DSC WILL PROBABLY
       REM            BE ON, AND THE RESET OF
       REM            DSC RESET.
       REM            THE CAUSE IS PROBABLY
       REM            DUE TO THE FACT THAT      
       REM            RESETTING CHANNEL WITH
       REM            ZERO CONTROL DID NOT RESET
       REM            THE UNIT SELECT TRIGGER
       ETTD           
       REWD           
       TRA *+2        
       REM            
       BCD 1TCOD      TEST TRANS CHAN. D IN OPN.
       REM            
 STDC  WTBD           
       TCOD *+3       CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL STDC       
       REM            
       RCHD CNTL      NO INDS ON-WORD CNT. 1
       TCOD *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL STDC       
       REM            
       TCOD *         
       REM            
       TCOD *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  TRANS. IN ERROR-TCOA
       TXL STDC       
       TRA *+2        
       REM            
       BCD 1TCND      
       REM            
 STDC1 TCND *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS.
       TXL STDC1      
       REM            
       WTBD           
       TCND *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STDC1      
       REM            
       RCHD CNTL+1    NO TGRS. ON-WRD. CNT. 1
       TCND *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STDC1      
       REM            
       TCOD *         
       TCND *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL STDC1      
       REM
       TSX OK,4       
       TRA STDC1      
       REM            
       BCD 1BTTD      
       REM            
 STDC2 REWD           REWIND
       BSRD           BACKSPACE TO LD. PT.
       REWD           SHOULD ACT AS NOP
       BSRD           TRY TO BCKSP OVER LD. PT.
       REM            BEGIN TAPE IND. SHOULD
       REM            BE TURNED ON HERE
       TCOD *         
       REM            
       BTTD           
       TRA *+3        OK-SHOULD BE ON
       TSX ERROR-1,4  SHLD NOT SKIP TO ENTER HERE
       TXL STDC2      
       REM            
       BTTC           
       TRA *+2        ERROR-BTT SHOULD BE OFF
       TRA *+3        OK-OFF
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STDC2      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA STDC2      
       REM            
       BCD 1IOT       TEST I/O CHECK TGR.
       REM            
 STTD3 WTBD           
       RCHD CNTL      NO TGRS. ON-WRD. CNT. 1
       TCOD *         
       LCHD CNTL+1    SHOULD TURN ON IOT
       IOT            
       TRA *+3        SHOULD ENTER HERE-OK
       TSX ERROR-1,4  ERROR-SHOULD NOT SKIP
       TXL STTD3      
       REM            
       IOT            
       TRA *+2        ERROR-TGR WAS NOT TURNED
       REM            OFF BY PREVIOUS SEQUENCE
       TRA *+3        OK-TGR SHOULD BE OFF
       TSX ERROR-1,4  
       TXL STTD3      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA STTD3      
       REM            
       BCD 1WEFD      TEST WEF BINARY AND
       REM            BCD TO MAKE CERTAIN 
       REM            THEY BOTH WORK IN BCD
       REM            MODE
       REM            
       WTDD           
       RCHD CNTL      NO TGRS. ON-WRD. CNT. 1
       WEFD           
       WTBD           
       RCHD CNTL+1    NO. TGRS ON-WRD. CNT. 1
       WEFD 16        BINARY EOF
       TRA *+2        
       REM            
       BCD 1BSRD      
       REM            
 STTD4 BSRD 16        
       BSRD           
       RTBD           
       RCHD CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOD *         
       REM            
       CLA READ       WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTD4      DO NOT REPEAT
       TSX RDNCK,4    
       TRA STTD4      
       REM            
       TEFD *+3       
       TSX ERROR-1,4  
       TXL STTD4      
       TRA *+2        
       REM            
       BCD 1BSFD      
       REM            
 STTD5 BSFD           BKSP OVER EOF
       BSFD           BKSP OVER EOF AND 1 REC
       BSRD           BKSP OVER 1 REC
       RTDD           
       RCHD CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOD *         TO READ OEN WD AND BCD EOF
       TRA *+2        CONTINUE
       REM            
       BCD 1TEFD      TEST EOF TGR + INDICATOR
       REM            
 STTD6 TEFD *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL STTD6,4    
       REM            
       TEFD *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  
       TXL STTD6,4    
       REM            
       RTBD           
       RCHD CNTLR+2   NO TGRS ON-WRD CNT 2
       REM            TO READ ONE WD AND BIN EOF
       TCOD *         DELAY
       REM            
       TEFD *+3       
       TSX ERROR-1,4  
       TXL STTD6,4    
       REM            
       CLA READ       WORD READ
       LDQ ONES       WORD WRITTEN
       CAS ONES       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTD5      
       TSX RDNCK,4    TEST RDNCY
       TRA STTD5      
       REM            
       CLA READ+2     WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTD5      
       TSX OK,4       OUT TO TEST SWITCHES
       TRA STTD4      REPEAT
       NOP            
       REM            
 CHANE NZT TPCHE      TEST FOR TAPE CHAN E
       TRA CHANF      NO-CHECK CHAN F
       TSX CTX,4      
       HTR *+1,0,CHANF 
       REM            
       REWE           MACHINE MAY HANG UP
       BSRE           IN ONE OR BOTH OF THESE
       WTBE           ROUTINES. IF A HANG UP
       RCHE ZERO      CONDITION OCCURS THE TAPE
       REM            UNIT SELECT NEON ON 
       REM            THE DSCWILL PROBABLY
       REM            BE UP, AND THE REST OF
       REM            DSC, RESET.
       REM            THE CAUSE IS PROBABLY
       REM            DUE TO THE FACT THAT
       REM            RESETTING CHANNEL WITH
       REM            ZERO CONTROL DID NOT RESET
       REM            THE UNIT SELECT TRIGGER.
       ETTE           
       REWE           
       TRA *+2        
       REM            
       BCD 1TCOE      TEST TRANS CHAN. E IN OPN.
       REM            
 STEC  WTBE           
       TCOE *+3       CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL STEC       
       REM            
       RCHE CNTL      NO INDS ON-WORD CNT. 1
       TCOE *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL STEC       
       REM            
       TCOE *         
       REM            
       TCOE *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  TRANS. IN ERROR-TCOA
       TXL STEC       
       TRA *+2        
       REM            
       BCD 1TCNE      
       REM            
 STEC1 TCNE *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS.
       TXL STEC1      
       REM            
       WTBE           
       TCNE *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STEC1      
       REM            
       RCHE CNTL+1    NO TGRS. ON-WRD. CNT. 1
       TCNE *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STEC1      
       REM            
       TCOE *         
       TCNE *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL STEC1      
       TSX OK,4       
       TRA STEC1      
       REM            
       BCD 1BTTE      
       REM            
 STEC2 REWE           REWIND
       BSRE           BACKSPACE TO LD. PT.
       REWE           SHOULD ACT AS NOP
       BSRE           TRY TO BCKSP OVER LD. PT.
       REM            BEGIN TAPE IND. SHOULD
       REM            BE TURNED ON HERE
       TCOE *         
       REM            
       BTTE           
       TRA *+3        OK-SHOULD BE ON
       TSX ERROR-1,4  SHLD NOT SKIP TO ENTER HERE
       TXL STEC2      
       REM            
       BTTE           
       TRA *+2        ERROR-BTT SHOULD BE OFF
       TRA *+3        OK-OFF
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STEC2      
       REM            
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA STEC2      
       REM            
       BCD 1IOT       TEST I/O CHECK TGR.
       REM            
 STTE3 WTBE           
       RCHE CNTL      NO TGRS. ON-WRD. CNT. 1
       TCOE *         
       LCHE CNTL+1    SHOULD TURN ON IOT
       IOT            
       TRA *+3        SHOULD ENTER HERE-OK
       TSX ERROR-1,4  ERROR-SHOULD NOT SKIP
       TXL STTE3      
       REM            
       IOT            
       TRA *+2        ERROR-TGR WAS NOT TURNED
       REM            OFF BY PREVIOUS SEQUENCE
       TRA *+3        OK-TGR SHOULD BE OFF
       TSX ERROR-1,4  
       TXL STTE3      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA STTE3      
       REM            
       BCD 1WEFE      TEST WEF BINARY AND
       REM            BCD TO MAKE CERTAIN
       REM            THEY BOTH WORK IN BCD
       REM            MODE
       REM            
       WTDE           
       RCHE CNTL      NO TGRS. ON-WRD. CNT. 1
       WEFE           
       WTBE           
       RCHE CNTL+1    NO. TGRS ON-WRD. CNT. 1
       WEFE 16        BINARY EOF
       TRA *+2        
       REM            
       BCD 1BSRE      
       REM            
 STTE4 BSRE 16        
       BSRE           
       RTBE           
       RCHE CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOE *         
       REM            
       CLA READ       WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTE4      DO NOT REPEAT
       TSX RDNCK,4    
       TRA STTE4      
       REM            
       TEFC *+3       
       TSX ERROR-1,4  
       TXL STTE4      
       TRA *+2        
       REM            
       BCD 1BSFE      
       REM            
 STTE5 BSFE           BKSP OVER EOF
       BSFE           BKSP OVER EOF AND 1 REC
       BSRE           BKSP OVER 1 REC
       RTDE           
       RCHE CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOE *         TO READ OEN WD AND BCD EOF
       TRA *+2        CONTINUE
       REM            
       BCD 1TEFE      TEST EOF TGR + INDICATOR
       REM            
 STTE6 TEFE *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL STTE6,4    
       REM            
       TEFE *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  
       TXL STTE6,4    
       REM            
       RTBE           
       RCHE CNTLR+2   NO TGRS ON-WRD CNT 2
       REM            TO READ ONE WD AND BIN EOF
       TCOE *         DELAY
       REM            
       TEFE *+3       
       TSX ERROR-1,4  
       TXL STTE6,4    
       REM            
       CLA READ       WORD READ
       LDQ ONES       WORD WRITTEN
       CAS ONES       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTE5      
       TSX RDNCK,4    TEST RDNCY
       TRA STTE5      
       REM            
       CLA READ+2     WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTE5      
       TSX OK,4       OUT TO TEST SWITCHES
       TRA STTE4      REPEAT
       NOP            
       REM            
 CHANF NZT TPCHF      TEST FOR TAPE CHAN F
       TRA CRAZY-6    
       TSX CTX,4      
       HTR *+1,0,CRAZY 
       REM            
       REM            
       REWF           MACHINE MAY HANG UP
       BSRF           IN ONE OR BOTH OF THESE
       WTBF           ROUTINES. IF A HANG UP
       RCHF ZERO      CONDITION OCCURS THE TAPE
       REM            UNIT SELECT NEON ON DS
       REM            WILL PROBABLY BE UP, AND
       REM            THE RESET OF DS, RESET.
       REM            THE CAUSE OF THE TROUBLE
       REM            MAY BE THAT A ZERO CONTROL
       REM            WORD DID NOT RESET THE
       REM            TAPE UNIT TGR.
       REM            
       ETTF           
       REWF           
       TRA *+2        
       REM            
       BCD 1TCOF      TEST TRANS CHAN. F IN OPN.
       REM            
 STFC  WTBF           
       TCOF *+3       CHAN. SHOULD BE IN OPN.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL STFC       
       REM            
       RCHF CNTL      NO INDS ON-WORD CNT. 1
       TCOF *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS. IN OPN.
       TXL STFC       
       REM            
       TCOF *         
       REM            
       TCOF *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  TRANS. IN ERROR-TCOA
       TXL STFC       
       TRA *+2        
       REM            
       BCD 1TCNF      
       REM            
 STFC1 TCNF *+3       SHOULD TRANS.
       TSX ERROR-1,4  FAILED TO TRANS.
       TXL STFC1      
       REM            
       WTBF           
       TCNF *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STFC1      
       REM            
       RCHF CNTL+1    NO TGRS. ON-WRD. CNT. 1
       TCNF *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STFC1      
       REM            
       TCOF *         
       TCNF *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL STFC1      
       TSX OK,4       
       TRA STFC1      
       REM            
       BCD 1BTTF      
       REM            
 STFC2 REWF           REWIND
       BSRF           BACKSPACE TO LD. PT.
       REWF           SHOULD ACT AS NOP
       BSRF           TRY TO BCKSP OVER LD. PT.
       REM            BEGIN TAPE IND. SHOULD
       REM            BE TURNED ON HERE
       TCOF *         
       REM            
       REM            
       BTTF           
       TRA *+3        OK-SHOULD BE ON
       TSX ERROR-1,4  SHLD NOT SKIP TO ENTER HERE
       TXL STFC2      
       REM            
       BTTF           
       TRA *+2        ERROR-BTT SHOULD BE OFF
       TRA *+3        OK-OFF
       TSX ERROR-1,4  SHOULD NOT ENTER HERE
       TXL STFC2      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA STFC2      
       REM            
       BCD 1IOT       TEST I/O CHECK TGR.
       REM            
 STTF3 WTBF           
       RCHF CNTL      NO TGRS. ON-WRD. CNT. 1
       TCOF *         
       LCHF CNTL+1    SHOULD TURN ON IOT
       IOT            
       TRA *+3        SHOULD ENTER HERE-OK
       TSX ERROR-1,4  ERROR-SHOULD NOT SKIP
       TXL STTF3      
       REM            
       IOT            
       TRA *+2        ERROR-TGR WAS NOT TURNED
       REM            OFF BY PREVIOUS SEQUENCE
       TRA *+3        OK-TGR SHOULD BE OFF
       TSX ERROR-1,4  
       TXL STTF3      
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA STTF3      
       REM            
       BCD 1WEFF      TEST WEF BINARY AND
       REM            BCD TO MAKE CERTAIN 
       REM            THEY BOTH WORK IN BCD
       REM            MODE
       REM            
       WTDF           
       RCHF CNTL      NO TGRS. ON-WRD. CNT. 1
       WEFF           
       WTBF           
       RCHF CNTL+1    NO. TGRS ON-WRD. CNT. 1
       WEFF 16        BINARY EOF
       TRA *+2        
       REM            
       BCD 1BSRF      
       REM            
 STTF4 BSRF 16        
       BSRF           
       RTBF           
       RCHF CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOF *         
       REM            
       CLA READ       WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTF4      DO NOT REPEAT
       TSX RDNCK,4    
       TRA STTF4      
       REM            
       TEFF *+3       
       TSX ERROR-1,4  
       TXL STTF4      
       TRA *+2        
       REM            
       BCD 1BSFF      
       REM            
 STTF5 BSFF           BKSP OVER EOF
       BSFF           BKSP OVER EOF AND 1 REC
       BSRF           BKSP OVER 1 REC
       RTDF           
       RCHF CNTLR+1   NO TGRS ON-WRD CNT 2
       TCOF *         TO READ OEN WD AND BCD EOF
       TRA *+2        CONTINUE
       REM            
       BCD 1TEFF      TEST EOF TGR + INDICATOR
       REM            
 STTF6 TEFF *+3       SHOULD TRANS.
       TSX ERROR-1,4  
       TXL STTF6,4    
       REM            
       TEFF *+2       SHOULD NOT TRANS.
       TRA *+3        OK
       TSX ERROR-1,4  
       TXL STTF6,4    
       REM            
       RTBF           
       RCHF CNTLR+2   NO TGRS ON-WRD CNT 2
       REM            TO READ ONE WD AND BIN EOF
       TCOF *         DELAY
       REM            
       TEFF *+3       
       TSX ERROR-1,4  
       TXL STTF6,4    
       REM            
       CLA READ       WORD READ
       LDQ ONES       WORD WRITTEN
       CAS ONES       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTF5      
       TSX RDNCK,4    TEST RDNCY
       TRA STTF5      
       REM            
       CLA READ+2     WORD READ
       LDQ ZEROS      WORD WRITTEN
       CAS ZEROS      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP STTF5      
       TSX OK,4       OUT TO TEST SWITCHES
       TRA STTF4      REPEAT
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000   INITAL 755 AND 766-SECTION 2 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+1   
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
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
*TEST PRINT AND PUNCH 
*WRITE ONE LINE AND READ ONE LINE-PRINTER
*PUNCH ONE CARD-PUNCH 
       REM            
       REM            
CRAZY  LXD SHAKE+2,2  L+30
       CAL RANOS      INITIAL RAND. NO.
       ADM RANOS      
       SLW IRAN+24,2  FORM 30 RANDOM NUMBERS
       TIX CRAZY+2,2,1 
       TRA *+2        CONTINUE
       REM            
       REM            
       BCD 1WPUA      PUNCH ONE BINARY RECORD
       REM            
       TSX RELO,2     TO SHIFT PRINT IMAGE
       REM            
       CLA COUNT      
       TZE QUIP-9     
       SUB ONE        
       STO COUNT      
       REM            
       NZT PUCHA      TEST FOR PUNCH-CHAN A.
       TRA PAPA+9     NO
       REM            
OSCAR  WPUA           
       RCHA CNTLW     TGRS S AND 2 ON-WRITE 9L-9R
       REM            
       LCHA CNTLW+1   TGRS S AND 2 ON-WRITE 8L-8R
       REM            
       LCHA CNTLW+2   TGR S ON-WRITE 7L-7R
       REM            
       TCOA *         
       SCHA SAVE      STORE CONTENTS LR AND AR
       TRA *+2        
       REM            
       BCD 1SCHA      
       REM            
PAPA   CLA SAVE       RESULTS STORE CHAN.
       LDQ SCHA       CORRECT CONTENTS CHAN
       CAS SCHA       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP PAPA       REPEAT SW 1 DOWN
       TRA *+2        
       REM            
       BCD 1WPRA      TEST WRITE PRINTER
       REM            
       NZT PRCHA      TEST FOR PRINTER-CHAN A.
       TRA OSCCR-2    NO
       WPRA           
       RCHA SHAKE     ALL TGRS ON-WRD. CNT. 2
       LCHA SHAKE+1   
       TCOA *         DELAY
       SCHA SAVE      
       TRA *+2        
       REM            
       BCD 1SCHA      
       REM            
QUIP   CLA SAVE       RESULTS STO. CHAN.
       LDQ SCH1       CORRECT CONTENTS CHAN.
       CAS SCH1       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP QUIP       
       TSX OK,4       OUT TO TEST SWITCHES
       TRA OSCAR-2    REPEAT
       NOP            
       TSX SHIFT,2    
       TRA *+2        
       REM            
       BCD 1RPRA      TEST READ PRINTER
       REM            
ROMEO  RPRA           
       RCHA SHAKE+5   ALL TGRS ON-WRD CNT 16
       LCHA SHAKE+7   TGR 2 ON-WRD CNT 2
       LCHA SHAKE+13   S TGR ON-WRD CNT 2
       LCHA SCH1-8      S+1 TGRS ON-WRD CNT 2
       LCHA SCH1-5    S TGR ON-WRD CNT 14
       TCOA *         WAIT FOR CHAN TO END OPN
       TRA *+2        
       REM            
       BCD 1SCHA      
       REM            
SIERA  SCHA SAVE      STO. CHANNEL A
       CLA SAVE       RESULT SCHA
       LDQ SCH2       CORRECT CONTENTS
       CAS SCH2       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP SIERA      
       TRA *+2        CONTINUE
       REM            
       BCD 1IOT       TEST I/O TGR
       REM            
       IOT            
       TRA *+2        
       TRA *+3        OK-SHOULD BE OFF
       TSX ERROR-1,4  ERROR
       TXL *-4,4,0    
       REM            
       TSX ECHOS,2    
       REM            
       AXT 0,2        
       LXA TWTWO,1    L+24
       PXA 0,1        
       ADD ONE        L+1
       STA WDNO       SET WDNO CONSTANT
       CLA ONE        L+1
       STA RECNO      SET REC. NO. CONSTANT
       REM            
TANGO  CLA ECHO+18,1  WORD READ
       LDQ WRIT2+18,1 WORD WRITTEN
       CAS WRIT2+18,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP ROMEO      
       TIX TANGO,1,1  CHECK ALL WORDS
       TSX OK,4       
       TRA ROMEO      REPEAT SW 1 DOWN
       REM            
       REM            
       BCD 1WPUC      
       REM            
       NZT PUCHC      TEST FOR PUNCH-CHAN C.
       TRA PAPC+9     NO
       REM            
OSCCR  WPUC           
       RCHC CNTLW     TGRS S AND 2 ON-WRITE 9L-9R
       REM            
       LCHC CNTLW+1   TGRS S AND 2 ON-WRITE 8L-8R
       REM            
       LCHC CNTLW+2   TGR S ON-WRITE 7L-7R
       REM            
       TCOC *         
       SCHC SAVE      STORE CONTENTS LR AND AR
       TRA *+2        
       REM            
       BCD 1SCHC      
       REM            
PAPC   CLA SAVE       RESULTS STORE CHAN.
       LDQ SCHA       CORRECT CONTENTS CHAN
       CAS SCHA       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP PAPC       
       TRA *+2        
       REM            
       BCD 1WPRC      WRITE PRINTER-CHAN C
       REM            
       NZT PRCHC      TEST FOR PRINTER-CHAN C.
       TRA OSCER-2    NO-GO TO TEST FOR CHAN.
       REM            
       WPRC           
       RCHC SHAKE     ALL TGRS ON-WRD. CNT. 2
       LCHC SHAKE+1   
       TCOC *         DELAY
       SCHC SAVE      
       TRA *+2        
       REM            
       BCD 1SCHC      
       REM            
QUCP   CLA SAVE       RESULTS STO. CHAN.
       LDQ SCH1       CORRECT CONTENTS CHAN.
       CAS SCH1       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP QUCP       
       TSX OK,4       
       TRA QUCP-7     
       REM            
       BCD 1RPRC      TEST READ PRINTER
       REM            
ROMEC  RPRC           
       RCHC SHAKE+5   ALL TGRS ON-WRD CNT 16
       LCHC SHAKE+7   TGR 2 ON-WRD CNT 2
       LCHC SHAKE+13   S TGR ON-WRD CNT 2
       LCHC SCH1-8      S+1 TGRS ON-WRD CNT 2
       LCHC SCH1-5    S TGR ON-WRD CNT 14
       TCOC *         WAIT FOR CHAN TO END OPN
       TRA *+2        
       REM            
       BCD 1SCHC      
       REM            
SIERC  SCHC SAVE      STO CONTENTS CHAN
       CLA SAVE       RESULT SCH OPN.
       LDQ SCH2       CORRECT CONTENTS
       CAS SCH2       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP SIERC      
       TRA *+2        
       REM            
       BCD 1IOT       TEST I/O TGR
       REM            
       IOT            
       TRA *+2        
       TRA *+3        OK-SHOULD BE OFF
       TSX ERROR-1,4  ERROR
       TXL *-4,4,0    
       TSX ECHOS,2    
       REM            
       AXT 0,2        
       LXA TWTWO,1    L+24
       PXA 0,1        
       ADD ONE        L+1
       STA WDNO       SET WDNO CONSTANT
       CLA ONE        L+1
       STA RECNO      SET REC. NO. CONSTANT
       REM            
TCNGO  CLA ECHO+18,1  WORD READ
       LDQ WRIT2+18,1 WORD WRITTEN
       CAS WRIT2+18,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP ROMEC      
       TIX TCNGO,1,1  CHECK ALL WORDS
       TSX OK,4       
       TRA ROMEC      REPEAT SW 1 DOWN
       REM            
       BCD 1WPUE      
       REM            
       NZT PUCHE      TEST FOR PUNCH-CHAN E.
       TRA PEPE+9     NO
       REM            
OSCER  WPUE           
       RCHE CNTLW     TGRS S AND 2 ON-WRITE 9L-9R
       REM            
       LCHE CNTLW+1   TGRS S AND 2 ON-WRITE 8L-8R
       REM            
       LCHE CNTLW+2   TGR S ON-WRITE 7L-7R
       REM            
       TCOE *         
       SCHE SAVE      STORE CONTENTS LR AND AR
       TRA *+2        
       REM            
       BCD 1SCHE      
       REM            
PEPE   CLA SAVE       RESULTS STORE CHAN.
       LDQ SCHA       CORRECT CONTENTS CHAN
       CAS SCHA       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP PEPE       
       TRA *+2        
       REM            
       BCD 1WPRE      WRITE PRINTER-CHAN C
       REM            
       NZT PRCHE      TEST FOR PRINTER-CHAN C.
       TRA TENGE+11   NO-GO TO TEST FOR CHAN.
       REM            
       WPRE           
       RCHE SHAKE     ALL TGRS ON-WRD. CNT. 2
       LCHE SHAKE+1   
       TCOE *         DELAY
       SCHE SAVE      
       TRA *+2        
       REM            
       BCD 1SCHE      
       REM            
QUEP   CLA SAVE       RESULTS STO. CHAN.
       LDQ SCH1       CORRECT CONTENTS CHAN.
       CAS SCH1       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP QUEP       
       TSX OK,4       
       TRA QUEP-7     
       REM            
       BCD 1RPRE      TEST READ PRINTER
       REM            
ROMEE  RPRE           
       RCHE SHAKE+5   ALL TGRS ON-WRD CNT 16
       LCHE SHAKE+7   TGR 2 ON-WRD CNT 2
       LCHE SHAKE+13   S TGR ON-WRD CNT 2
       LCHE SCH1-8      S+1 TGRS ON-WRD CNT 2
       LCHE SCH1-5    S TGR ON-WRD CNT 14
       TCOE *         WAIT FOR CHAN TO END OPN
       TRA *+2        
       REM            
       BCD 1SCHE      
       REM            
SIERE  SCHE SAVE      STO CONTENTS CHAN
       CLA SAVE       RESULT SCH OPN.
       LDQ SCH2       CORRECT CONTENTS
       CAS SCH2       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP SIERE      
       TRA *+2        
       REM            
       BCD 1IOT       TEST I/O TGR
       REM            
       IOT            
       TRA *+2        
       TRA *+3        OK-SHOULD BE OFF
       TSX ERROR-1,4  ERROR
       TXL *-4,4,0    
       TSX ECHOS,2    
       REM            
       AXT 0,2        
       LXA TWTWO,1    L+24
       PXA 0,1        
       ADD ONE        L+1
       STA WDNO       SET WDNO CONSTANT
       CLA ONE        L+1
       STA RECNO      SET REC. NO. CONSTANT
       REM            
TENGE  CLA ECHO+18,1  WORD READ
       LDQ WRIT2+18,1 WORD WRITTEN
       CAS WRIT2+18,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP ROMEE      
       TIX TENGE,1,1  CHECK ALL WORDS
       TSX OK,4       
       TRA ROMEE      REPEAT SW 1 DOWN
       NOP
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM
*  PRINT --
**  00000   INITIAL CARD MACHINES-SECTION 3 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+2   
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
       LDI CTRL1      DRUMS SELECTED
       STZ Z20        RESET COUNT
       AXT 16,1       L +20
       SXA Z20,1      
       SXA DC,1       SET COUNT
       STZ DC1+16,1   CLEAR DRUM
       TIX *-1,1,1    CONTROL IMAGE
       REM            
       AXT 0,3        
HUNT   LNT 200000     TEST FOR INDICATORS
       TRA *+4        IF NO BIT GO TO DECR. ADDR.
       CLA K301,1     CORRECT DRUM SELECTED
       STO DC1,2      PLACE IN CONTROL IMAGE
       TXI *+1,2,-1   DECREMENT CONTROL IMAGE
       TXI *+1,1,-1   DECREMENT CORRECT DRUM
       CLA Z20        L+20
       SUB ONE        L+1 - FOR COUNT OF SHIFTS
       STO Z20        SAVE COUNT
       TZE DAD        ALL DRUMS HAVE BEEN
       REM            RECOGNIZED
       CLA HUNT       L LNT INSTRUCTION
       ARS 1          SHIFT TO TEST NEXT IND.
       STA HUNT       STORE NEW ADDR
       STT HUNT       STORE NEW TAG
       TRA HUNT       
       REM            
DAD    CLA RESTR      L LNT INSTR
       STO HUNT       RESTORE HUNT
       REM            
       LXA DC,1       
       CLA DC1+16,1   
       STA DRUM       SAVE DRUM SELECTED
       TZE IOSEL-18   
       REM            TEST FOR CRT
       TIX *+1,1,1    ADJUST FOR NECT DRUM
       SXA DC,1       SAVE COUNT
       REM            
*STORE SELECTED DRUM ADDRESS IN ALL RDS AND WRS INSTRUCTIONS
       REM            
       CLA DRUM       
       STA LDAA       
       STA LDAB-2     
       STA 1LDA       
       STA LDA5+2     
       STA LDA7+4     
       STA R          
       STA R3         
       STA R4         
       STA R10        
       STA R13        
       STA R14        
       STA BEGEN+4    
       STA BUG        
       STA AGAIN+1    
       REM            
       STA AGAIN+8    
       STA INDEX+10   
       STA BUGS       
       STA BUGS+19    
       STA BUGS+22    
       STA IOSEL+2    
       STA IOSEL+13   
       STA RDWTB      
       STA RDWTB-10   
       REM            
*STORE SELECTED ADDRESS IN DUMMY BCD INSTRUCTIONS
       REM            
       CLA DRUM      L ADDRESS OF SELECTED DRUM
       SUB K300      L 300
       PAX 0,1        
       CAL TBLE2+16,1 
       STA LDAA-1     
       STA LDAB-3     
       STA 1LDA-1     
       STA LDA5-1     
       STA R-1        
       STA R4-1       
       STA R10-1      
       STA R15-1      
       CLA LDAA       SET RANDOM NUMBER
       STA RN+63      CONSTANT
       TRA *+2        
       REM            
*                  ENTER LDA TEST                                 *
       REM            
       BCD 1WDR       
LDAA   WRS            
       LXA K4000,1   L 4000
       CLA ZERO      L 0
       STO X,1       LOAD STORAGE WITH INFOR
       ADD K6        L+2000001
       TIX LDAA+3,1,1 
       REM            
*     WRITE DRUM ADDRESSES IN THE ADDRESS ON THE DRUM
*     THE DECREMENT CONTAINS THE POCKET AND THE ADDRESS THE ADDRESS
       REM            
       LXA K4000,1   L+4000
LDA1   CPY X,1        
       TIX LDA1,1,1  LOAD DRUM
       TSX OK,4       
       TRA LDAA      LOOP IN WRITE ROUTINE
       REM            
*         CLEAR STORAGE   
       REM            
       NOP            
       LXA K4000,1   L 4000
LDA1A  STZ X,1        
       TIX LDA1A,1,1  
       TRA LDAB-2     
       REM            
*         READ ENTIRE DRUM INTO STORAGE
       REM            
       BCD 1RDR       
       RDS            
       LXA K4000,1   L 4000
LDAB   CPY X,1        
       TIX LDAB,1,1   
       REM            
*    COMPARE THE WORD READ TO THE WORD WRITTEN
       REM            
       LXA K4000,1   L 4000
       CLA ZERO      L 0
LDAC   CAS X,1        
       TRA LDAC+3    ERROR
       TRA LDAD      OK
       LDQ X,1       ERROR WORD
       XCA           ERROR WORD TO ACC
       REM           CORRECT WORD TO MQ
       TSX ERROR-2,4  
       TRA LDAB-2     
       XCA           RESTORE ACC AND MQ
       REM            
LDAD   ADD K6        L+2000001
       TIX LDAC,1,1   
       TRA *+2        
       REM            
*****  TEST LDA TRANSMISSION TO MQ  *****
       REM            
       BCD 1LDA       
1LDA   RDS            
       LDA K3777    L 3777
       STQ LDA10      
       CPY X-1      IF I/O COMES UP
       REM          HERE,CHECK THE DRUM COUNTER
       REM          ON PAGE 7.02.01
       REM            
       CLA LDA10      
       SUB K7776    L 7775
       TZE 1LDA+8     
       TSX ERROR,4    
       TSX OK,4       
       TRA 1LDA       
       REM            
       BCD 1IOT       
       REM            
       IOT            
       TRA *+2      ERROR-SHBE OFF
       TRA *+3        
       TSX ERROR-1,4  
       TXL *-4,4      
       REM            
       REM            
*    ADJUST CONSTANTS FOR NON-SEQUENTIAL LDA TEST
       REM            
NSEQ   CLA K+3      L DEC 200, ADR 20
       STO K          
       CLA K+4      L DEC 40, ADR 20
       STO K+1        
       CLA K+5      L DEC 10036, ADR 4017
       STO K+2        
       CLA K+3      L DEC 200, ADR 20
       ALS 18         
       STD LDA8-5     
       CLA K+6      L DEC 3377, ADR 3757
       ALS 18         
       STD LDA8-2     
       TRA LDA5       
       REM            
*      LOCATE ALL DRUM ADDRESSES IN THE DRUM COUNTER SEQUENCE AND CHECK
       REM            
       BCD 1LDA       
LDA5   CLA ZERO     L 0
       STO CSC      CLEAR CHECK SUM COUNTER
       RDS            
       CLA K6       L +2000001
       STA LDA10    SET LDA COUNTER TO ONE
       LXA K6+3,1   L+37877 ADJUST XRA FOR
       REM          PRINT PROGRAM
       REM            
       LXA K,2        
       LXD K,4        
LDA6   LDA LDA10      
       CPY T2       TEMP STORAGE
       CAS T2         
       TRA LDA6+5   ERROR
       TRA LDA7     OK 
       LDQ T2       WORD READ IN MQ
       XCA          CORRECT WORD TO MQ
       REM          ERROR WORD TO ACC
       SXD T1,4     SAVE INDEX COUNT
       SXA T1,2     SAVE XRB
       AXT 0,2      CLEAR XRB
       TSX ERROR-2,4 MQ CONTAINS POCKET NUMBER
       REM           IN ITS DEC, AND DRUM
       REM           ADDRESS IN ITS ADDRESS
       TRA LDA5       
       XCA           RESTORE ACC AND MQ
       LXA T1,2      RESTORE XRB
       REM            
       REM            
       REM            
       LXD T1,4      RESTORE INDEX COUNT
LDA7   STO T1        SAVE ACCUMULATOR
       CLA T2        WORD READ
       ACL CSC        
       STO CSC       INCREASE CHECK SUM COUNTER
       REM            
       REM            
       RDS            
       CLA T1        RESTORE ACCUMULATOR
       ADD K+1       INCREATE THE PKT AND ADR
       CAS K+2        
       REM            
*       THE APPROACH OF ADDRESS ZERO
       REM            
       HTR LDA7+10   SHOULD NEVER ENTER HERE
       TRA LDA8      THE NEXT ADDRESS IS ZERO
       STA LDA10      
       TIX LDA7+12,1,0 ADJUST XRA FOR PRINT
       TIX LDA6,4,1   
       REM            
       REM            
       SUB K6+3      L+7776003777-INCREAESE
       REM           SECTOR BY A COUNT OF ONE
       TXI LDA8-1,1,0  ADJUST FOR PRINT PROG
       TRA LDA8+2     
       REM            
LDA8   CLA ZERO      L 0
       LXA K4000,1   ADJUST FOR PRINT PROGRAM
       STA LDA10      
       TIX LDA6-1,2,1 
       REM            
       CPY X-1       DRUM DISCONNECT
       CLA CS        GENERATE CHECK SUM
       CAS CSC        
       TRA LDA8+9    ERROR IN CHECK SUM
       TRA LDA9      CHECK SUM
       AXT 0,2       CLEAR XRB
       LDQ CSC       CORRECT CHECK SUM
       XCA            
       TSX ERROR-2,4 ERROR IN CHECK SUM
       TRA LDA5       
LDA9   TSX OK,4       
       TRA LDA5       
       NOP            
***************************************************************
*                                                             *
*     THIS IS A RIPPLE LDA SWITCHING PHYSICAL DRUMS TEST      *
*                                                             *
***************************************************************
       REM            
*      SELECT CORRECT FRAME
       REM            
       REM            
DAS    CLA DRUM      L DRUM ADDRESS
       SUB K311      L 311
       TMI DL01      DRUM 1 OR 2
       REM            
DHI    SUB K4        L 4
       TMI DH1       DRUM FRAME 3
       REM            
DH2    CLA K315      L 315 F4
       STA DA        SAVE
       STA DST       L WRS INST
       CLA D13B      L 0103
       ORA LDA        
       SLW LCP1-1     
       REM            
       CLA D14B      L 0104
       ORA LDA        
       SLW LCP2-1     
       REM            
       CLA D15B      L 0105
       ORA LDA        
       SLW LCP3-1     
       REM            
       CLA D16B      L 0106
       ORA LDA        
       SLW LCP4-1     
       REM            
       TRA DST-1     START
       REM            
DH1    CLA K311      L 311 F3
       STA DA        SAVE
       STA DST       L WRS INST
       REM            
       CLA D9B       L 0011
       ORA LDA        
       SLW LCP1-1     
       REM            
       CLA D10B      L 0100
       ORA LDA        
       SLW LCP2-1     
       REM            
       CLA D11B      L 0101
       ORA LDA        
       SLW LCP3-1     
       REM            
       CLA D12B      L 0102
       ORA LDA        
       SLW LCP4-1     
       REM            
       TRA DST-1     START
       REM            
DL01   CLA DRUM       
       SUB K305      L 305
       TMI DL1       DRUM FRAME 1
       REM            
DL02   CLA K305      L 305 F2
       STA DA        SAVE
       STA DST       L WRS INST
       REM            
       CLA D5B       L 0005
       ORA LDA        
       SLW LCP1-1     
       REM            
       CLA D6B       L 0006
       ORA LDA        
       SLW LCP2-1     
       REM            
       CLA D7B       L 0007
       ORA LDA        
       SLW LCP3-1     
       REM            
       CLA D8B       L 0010
       ORA LDA        
       SLW LCP4-1     
       REM            
       TRA DST-1     START
       REM            
DL1    CLA K301      L 301 F1
       STA DA        SAVE
       STA DST       L WRS INST
       REM            
       CLA D1B       L 0001
       ORA LDA        
       SLW LCP1-1     
       REM            
       CLA D2B       L 0002
       ORA LDA        
       SLW LCP2-1     
       REM            
       CLA D3B       L 0003
       ORA LDA        
       SLW LCP3-1     
       REM            
       CLA D4B       L 0004
       ORA LDA        
       SLW LCP4-1     
       REM            
*      LOAD ALL DRUMS COMPLETE WITH 25 PATTERN
       REM            
       LXA K4,4     L 4
DST    WRS            
       LXA K4000,1  L 4000
       CPY TEST3    L 25 PATTERN
       TIX DST+2,1,1  
       REM            
       CLA DST        
       ADD ONE      L ONE
       STA DST        
       TIX DST,4,1  LOAD ALL DRUMS
       REM            
*      ENTER LDA RIPPLE SWITCHING PHYSICAL DRUM
       REM            
DST0   CLA DA         
       STA DST      RESTORE
       STA LWD1     DRUM ONE OF SELECTED FR
       STA LRD1       
       ADD ONE      L ONE
       STA LWD2     DRUM TWO OF SELECTED FR
       STA LRD2       
       ADD ONE      L ONE
       STA LWD3       
       STA LRD3     DRUM THREE OF SELECTED FR
       ADD ONE      L ONE
       STA LWD4     DRUM FOUR OF SELECTED FR
       STA LRD4       
       REM            
*      WRITE SINGLE WORDS ON ALL DRUMSWITH ASCENDING LDA ADDRESS
       REM            
       REM            
LWD1   WRS            
       LDA D02      L 4000002
       CPY D02        
       REM            
LWD3   WRS            
       LDA D52      L 124000252
       CPY D52        
       REM            
LWD2   WRS            
       LDA D252     L 524000252
       CPY D252       
       REM            
       REM            
LWD4   WRS            
       LDA D1252    L 2524001252
       CPY D1252      
       REM            
*      READ SINGLE WORDS FROM LDA S JUST WRITTEN
       REM            
LRD1   RDS            
       LDA D02      L 4000002
       CPY D111     L 0
       REM            
LRD3   RDS            
       LDA D52      L 124000252
       CPY D333     L 0
       REM            
LRD2   RDS            
       LDA D252     L 524000252
       CPY D222     L 0
       REM            
LRD4   RDS            
       LDA D1252    L 2524001252
       CPY D444     L 0
       TRA LCP1       
       REM            
*      CHECK FOR CORRECT LDA EXECUTION FOR DRUM 1
       REM            
       BCD 1LDA       
LCP1   CLA D02      L 40000002
       CAS D111       
       TRA LCP1+4   ERROR
       TRA LCP2     OK 
       LDQ D111     ERROR
       XCA            
       TSX ERROR-2,4  
       TRA LCP1       
       TRA LCP2       
       REM            
*      CHECK FOR CORRECT LDA EXECUTION FOR DRUM 2
       REM            
       BCD 1LDA       
LCP2   CLA D252     L 124000252
       CAS D222       
       TRA LCP2+4   ERROR
       TRA LCP3     OK 
       LDQ D222     ERROR
       XCA            
       TSX ERROR-2,4  
       TRA LCP2       
       TRA LCP3       
       REM            
*      CHECK FOR CORRECT LDA EXECUTION FOR DRUM 3
       REM            
       BCD 1LDA       
LCP3   CLA D52     L 524000252
       CAS D333       
       TRA LCP3+4   ERROR
       TRA LCP4     OK 
       LDQ D333     ERROR
       XCA            
       TSX ERROR-2,4  
       TRA LCP3       
       TRA LCP4       
       REM            
*      CHECK FOR CORRECT LDA EXECUTION FOR DRUM 4
       REM            
       BCD 1LDA       
LCP4   CLA D1252    L 2524001252
       CAS D444       
       TRA LCP4+4   ERROR
       TRA LEND     OK 
       LDQ D444     ERROR
       XCA            
       TSX ERROR-2,4  
       TRA LCP4       
       REM            
LEND   TSX OK,4       
       TRA DAS        
       REM            
       REM            
*      ENTER RANDOM NUMBERS TEST                                *
       REM            
*      ZERO SELECTED DRUM
       REM            
       BCD 1WDR       
R      WRS            
       LXA K4000,1    L 4000
       CPY TEST1      L ZERO
       TIX R+2,1,1    
       CLA THREE      L 3
       STO CT6        
       REM            
*      GENERATE 100 OCTAL RANDOM NUMBERS
       REM            
R1     CLA RN+63      
       STO PRNG       
       LXA K100,1     L 100
       LDQ RN+63      
       RQL 1          
       MPY RR         L 357642357563
       STQ RN+64,1    
       TIX R1+4,1,1   
       REM            
*      CREATE RANDOM LDA ADDRESS
       REM            
R2     CAL RN+63      
       ANA K3777      L 3777
       STA RN7        
       PXD            CLEAR ACC
       REM            
*      SELECT RANDOM LDA AND WRITE 100 OCTAL LOCATIONS
*      WITH RANDOM NUMBERS
       REM            
*      FINISH LOADING ENTIRE DRUM -3700 OCTAL LOCATIONS-
*      WITH ZERO WORDS 
       REM            
R3     WRS            
       LXA K100,1     L 100
       LXA K3700,2    L 3700
       LDA RN7        
       CAD RN+64,1    
       TIX R3+4,1,1   
       CAD TEST1      
       TIX R3+6,2,1   
       SLW CAD        
       AXT 0,2        CLEAR XRB
       TRA R4         
       REM            
*      READ ENTIRE DRUM INTO STORAGE
       REM            
       BCD 1LDA       
R4     RDS            
       PXD            CLEAR ACC
       LXA K4000,1    L 4000
       CAD X,1        
       TIX R4+3,1,1   
       SLW Z20        SAVE CHECK SUM
       REM            
*      COMPATE RANDOM NUMBER WRITTEN AT RANDOM LDA
*      WITH WORD GENERATED FOR THAT POSITION
       REM            
*      CHECK FIRST RANDOM ADDRESS
       REM            
       CLA K4000      ADJUST WORD NUMBER
       SUB RN7        FOR PRINT ROUTINE
       PAX 0,1        
       REM            
R5     CLA RN7        RANDOM LDA
       ADD K2377      
       STA R5+5       TO CAS CORRECT ADDRESS
       STA R5+8       TO LOAD CORRECT WORD IN MQ
       CLA RN         
       CAS 0          N WORDS
       TRA R5+8       
       TRA R6         OK
       LDQ 0          CORRECT WORD
       TSX ERROR-2,4  LDA ERROR FIRST WORD
       TRA R4         
       REM            
*      CHECK DRUM ADDRESS ZERO
       REM            
R6     CLA RN7        RANDOM LDA
       SUB K3700      L 3700
       TMI R7         K 3700 GREATER THEN RN7
       TZE R7         K 3700 EQUAL TO RN7
       STA WDNO       
       PAX 0,1        RN7 GREATER THEN K 3700
       CLA RN+64,1    WORD READ
       CAS X-2048     
       TRA R6+10      
       TRA *+4        
       LDQ X-2048     CORRECT WORD
       TSX ERROR-2,4  
       TRA R4         
       CLA K4000      
       STO WDNO       
       REM            
*      CHECK ADDRESS OF LAST RANDOM WORD WRITTEN
       REM            
R7     CLA RN7        
       ADD K100       
       ANA K3777      
       ADD K3777      
       ANA K3777      
       REM            
       STA T21        ADJUST WORD NUMBER
       CLA K4000      FOR PRINT ROUTINE
       SUB T21        
       PAX 0,1        
       REM            
       CLA T21        
       ADD K2377      
       STA R7+14      
       STA R7+17      
       CLA RN+63      WORD READ
       CAS 0          
       TRA R7+17      
       TRA R8         
       LDQ 0          CORRECT WORD
       TSX ERROR-2,4  
       TRA R4         
       REM            
*      CHECK SUM TEST WRITE DRUM AGAINST MEMORY
       REM            
R8     PXD            CLEAR AC
       LXA K4000,1    
       ACL X,1        
       TIX R8+2,1,1   
       SLW T6         CHECK SUM DRUM-WRITE
       TRA *+2        
       REM            
       BCD 1CAD       
       REM            
       CAL Z20        COMPUTED SUM
       LDQ T6         CORRECT CHECK SUM
       LAS T6         TEST CHECK SUM
       TRA *+2        ERROR
       TRA *+3        
       TSX ERROR-2,4  
       NOP *-6        
       REM            
R9     PXD            CLEAR AC
       LXA K100,1     
       ACL RN+64,1    
       TIX R9+2,1,1   
       SLW T7         CHECK SUM MEMORY
       TRA *+2        
       REM            
       BCD 1CAD       
       REM            
       CAL CAD        COMPUTED SUM
       LDQ T7         CORRECT SUM
       LAS T7         FORMED FROM 100 NOS IN MEM.
       TRA *+2        ERROR
       TRA *+3        
       TSX ERROR-2,4  
       NOP *-6        
       REM            
       CLA T6         
       CAS T7         
       TRA *+2        
       TRA R10        
       LDQ T7         
       TSX ERROR-2,4  LDA CHECK SUM ERROR
       TRA R4         
       TSX OK,4       
       TRA R          
       REM            
*      CHECK SUM TEST READ LDA CHECK SUM
       REM            
       BCD 1LDA       
R10    RDS            
       LXA K100,1     
       LDA RN7        
       CPY X-1984,1   
       TIX R10+3,1,1  
       REM            
R11    PXD            CLEAR AC
       LXA K100,1     
       ACL X-1984,1   
       TIX R11+2,1,1  
       SLW T7         
       CLA T6         
       CAS T7         
       TRA R11+9      ERROR
       TRA R12-2      OK
       LDQ T7         
       TSX ERROR-2,4  READ LDA ERROR-CK SUM
       TRA R10        
       REM            
*      GENERATE 4000 OCTAL RANDOM NUMBERS
       REM            
       AXT 3,2        LOAD XRB-3
       AXT 2,4        LOAD XRC-2
R12    LXA K4000,1    
       LDQ RN+63      
       RQL 1          
       MPY RR         L 357642357563
       STQ X,1        
       TIX R12+2,1,1  
       REM            
*      LOAD FULL RANDOM DRUM THREE TIMES WITH SAME RANDOM PATTERN
       REM            
R13    WRS            
       LXA K4000,1  LOAD XRA-4000
       CPY X,1        
       TIX *-1,1,1  COPY FULL DRUM FROM ZERO
       TIX *-3,2,1  RETURN TO WRITE DRUM
       REM          THREE TIMES WITHOUT
       REM          RE-SELECTING. THIS ROUTINE
       REM          TAKES ADVANTAGE OF THE 
       REM          INDEX GAP.
       TIX R13A,4,1 DECREMENT TO RE-WRITE 
       REM          WITH NEW PATTERN
       TRA *+2        
       REM            
       BCD 1IOT       
       REM            
       IOT          CHECK IOT LIGHT
       TRA *+2      ERROR-SHOULD NOT BE ON
       TRA *+3      OK-LIGHT IS OFF
       TSX ERROR-1,4 IF I/O CHECK COMES UP AT
       TXL *-4,4,0   THIS POINT. THE DRUM
       REM           DISCONNECTED. 72 US WERE
       REM           USED IN THE INDEX GAP.
       REM           AS THE GAP SHOULD BE 
       REM           150-350 US. THE GAP IS
       REM           MUCH TO SHORT, AND DRUM
       REM           SHOULD BE RE-WRITTEN
       TRA R14       DRUM HAS BEEN RE-WRITTEN
       REM           WITH NEW PATTERN. GO TO
       REM           READ NEW PATTERN.
       REM            
*      GENERATE 4000 OCTAL RANDOM NUMBERS
*      WRITE NEW RANDOM PATTERN ONCE
       REM            
R13A   LXA K4000,1   L 4000
       CLA X,1        
       STO RN+63      
       TRA R12+1      
       REM            
*      READ ENTIRE DRUM BACK INTO MEMORY
       REM            
R14    RDS            
       LXA K4000,1    
       CPY X,1        
       TIX R14+2,1,1  
       TRA R15        
       REM            
*      COMPARE WORD WRITTEN TO WORD READ
       REM            
       BCD 1RDR       
R15    LXA K4000,1    
       LDQ RN+63      
       RQL 1          
       MPY RR         
       STQ T10        
       CLA X,1       WORD READ
       CAS T10       CORRECT WORD
       TRA R15+9      
       TRA R16       OK
       LDQ T10       CORRECT WORD
       TSX ERROR-2,4  
       TRA R15        
       REM            
R16    LDQ T10        
       TIX R15+2,1,1  
       CLA RR        MODIFY RN GENERATOR
       ADD K7        L 010776004377
       STO RR         
       TSX OK,4       
       TRA R          
       NOP            
       REM            
*********************************************************************
* TEST LDA-IND. ADDR., LDA-INDEXED, AND NO HANG UP ON COPY          *
*********************************************************************
       REM            
       REM            
BEGEN  LXA THREE,1   L+3
       PXA 0,1        
       ADD ONE       L+1
       STO WDNO      SET WDNO CONSTANT
       WDR            
       LDA* WRDR-2   L ADDR K1000
       CPY TEST3     L+2525252525225
       TIX *,1,1      
       CPY TEST4     HANG UP CONDITION MY OCCUR
       REM           AT THIS POINT. IF SO DRUM
       REM           MAY NOT HAVE DISCONNECTED
       REM           AFTER DELAY. LOOK AT SYSTEM
       REM           PAGE 5.03.01.
       TRA *+2        
       REM            
       BCD 1IOT      TEST I/O TGR AND INDICATOR
       REM            
       IOT           IS INDICATOR ON
       TRA *+5       YES-OK
       REM            
       TSX ERROR-1,4 INDICATOR SHOULD HAVE BEEN
       REM           TURNED ON WHEN CPY WAS 
       REM           GIVEN AFTER DELAY OF OVER
       REM           36US. LOOK AT SYSTEMS
       REM           PAGE 5.03.01
       TXL *-3,4,0    
       REM            
       TRA *+2       CONTINUE
       REM            
       BCD 1LDA IA   TEST LDA IND. ADDRESSED
       REM            
BUG    RDR            
       LDA K1000     CORRECT LDA
       CPY HECK      READ ONE WORD
       CPY HECK+1    READ LOC. OF DUMMY COPY
       REM            
       CLA HECK      WORD READ
       LDQ TEST3     WORD WRITTEN
       CAS TEST3      
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4 ERROR COULD HAVE BEEN A
       NOP BUG       OR WRITE ERROR
       TIX *+2,1,1   CONTINUE
       TRA *+2        
       REM            
       BCD 1CPY      TEST THAT COPY AFTER
       REM           DISCONNECT DOES NOT
       REM           TRANSMIT
       REM            
       CLA HECK+1    WORD READ
       CAS TEST4     WORD WAS WRITTEN BUT
       REM           IT SHOULD NOT HAVE BEEN
       TRA *+5       OK
       TRA *+2       ERROR-WORD SHOULD NOT
       REM           HAVE BEEN TRANSMITTED
       TRA *+3       OK
       TSX ERROR-1,4 COPY AFTER LAPSE OF MORE
       TXL *-6,4,0   THEN 36US WAS COMPLETED
       REM           COPY SHOULD HAVE ACTED AS
       REM           A NOP
       REM            
       TSX OK,4      OUT TO TEST SWITCHES
       TRA BEGIN     REPEAT WITH SW=1 DOWN
       REM            
       NOP            
AGAIN  LXA THREE,1   L+3
       WDR            
       LDA K,1       EFFECTED ADDR K1000
       CPY TEST2+3,1 COPY THREE WORDS
       TIX *-1,1,1    
       REM            
       CLA D4B       L+4
       STO WDNO      SET WD NO CONSTANT
       LXA THREE,1   L+3
       RDR            
       LDA K1000     L ADDR. 1000
       CPY HECK+3,1  READ THREE WORDS
       TIX *-1,1,1    
       TRA *+2        
       REM            
       BCD 1LDA IX   TEST LDA INDEXED
       REM            
INDEX  LXA THREE,1   L+3
       CLA HECK+3,1  WORD READ
       LDQ TEST2+3,1 WORD WRITTEN
       CAS TEST2+3,1  
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4 ERROR COULD HAVE BEEN READ
       NOP INDEX     OR WRITE ERROR
       TIX INDEX+1,1,1 
       LXA TWO,1     L+2
       WDR            
       LDA* WRDR,1   EFFECTIVE ADDR, K1000
       CPY TEST2+2,1 WRITE TWO WORDS
       TIX *-1,1,1    
       TRA *+2       CONTINUE
       REM            
       BCD 1LDX XI   TEST LDA INDEXED + INDIRECT
       REM            
BUGS   RDR            
       LDA K1000     L 1000 IN ADDR
       LXA TWO,1     L+2
       CPY HECK+2,1  READ TWO WORDS
       TIX *-1,1,1    
       REM            
       LXA TWO,1     L+2
       CLA THREE     L+3
       STO WDNO      SET WORD NO CONSTANT
       REM            
       CLA HECK+2,1  WORD READ
       LDQ TEST2+2,1 WORD WRITTEN
       CAS TEST2+2,1  
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-2,4 ERROR COULD HAVE BEEN A
       REM           READ OR WRITE ERROR
       REM           IF NO ERROR INDICATION IN
       REM           READ AND WRITE SECTION OF
       REM           THIS TEST, LDA IND. ADDR.
       REM           OR LDA INDEXED, IT MUST BE
       REM           ASSUMED THAT THE ERROR
       REM           CAME ABOUT THROUGH THE USE
       REM           OF THE COMBINED INDEXING
       REM           AND IND. ADDRESSING OF LDA
       NOP BUGS       
       TIX *-7,1,1   CHECK ALL WORDS
       TSX OK,4      OUT TO TEST SWITCHES
       TRA INDEX      
       NOP            
       REM            
       RDR            
       LDA WRDR       
       CPY CHEC       
       RDR            
       LDA WRDR-2     
       CPY CHEC+1     
       CLA CHEC       
       CAS TEST2      
       TRA *+5        OK
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ERROR HERE WOULD INDICATE
       TXL INDEX,4,0  LDA INDEXING FAILURE
       REM           THIS ERROR WOULD BE TIED IN
       REM           WITH AN ERROR IN ROUTINE
       REM           AT BUGS
       REM            
       TIX *+1,1,1    
       CLA CHEC+1     
       CAS TEST2      
       TRA *+5        OK
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ERROR HERE WOULD INDICATE
       TXL BUG,4,0   LDA IND. ADDRESS FAILURE
       REM           THIS ERROR WOULD BE TIED IN
       REM           WITH AN ERROR IN
       REM           ROUTINE AT BUGS
       TSX OK,4      OUT TO TEST SWITCHES
       TRA AGAIN     REPEAT SW=1 DOWN
       NOP            
       TRA DAD+2      
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*   PRINT --          
**    00000   ALL DRUMS TESTED-SECTION 4 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+3   
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
*ROUTINE TO TEST FOR A CONDITION OF I/O SELECTION
*AND DRUM SELECTION, SIMILTANEOUSLY.
       REM            
       REM            
       REM            
       CLA DRUM       
       TZE CRT-6      
       REM            
       NZT TPCHA      TAPE CHANNEL A
       TRA CRT-6      NO
       NZT TPCHB      TAPE CHANNEL B
       TRA CRT-6      NO
       REM            
       TSX CTX,4      
       HTR *,0,RDWTB+4 
       REM            
       STZ SAVE       
       STZ SAVE1      
       REM            
       TRA *+2        
       REM            
       BCD 1WT WDR    
       REM            
IOSEL  WTBB           SELECT I/O UNIT-WRITE
       RCHB WTB1      WRITE 400 WORDS
       WDR 1          SELECT DRUM
       TCOB *+2       ERROR
       TRA *+4        OK
       CPY            DISCONNECT
       TSX ERROR-2,4  ERROR HERE WILL INDICATE
       TXL IOSEL,     THAT IT WAS POSSIBLE TO
       REM            SELECT DRUM WITH AN I/O
       REM            UNIT PREVIOUSLY SELECTED.
       REM            LOOK AT SYSTEMS PAGE 5.01.03
       REM            DRUM WRITE SEL SHOULD
       REM            NOT HAVE GOTTEN THROUGH
       REM            OR CIRCUIT 1183-D.
       CPY            DISCONNECT
       TRA *+2        
       REM            
       BCD 1WT RDR    
       REM            
       WTBA           SELECT I/O UNIT
       RCHA WTB1      WRITE 400 WORDS.
       RDR 1          SELECT DRUM
       TCOA *+2       ERROR
       TRA *+4        OK
       CPY            DISCONNECT
       TSX ERROR-2,4  ERROR HERE WILL INDICATE
       REM            ERROR HERE WILL INDICATE
       REM            SAME CIRCUIT AS ABOVE
       REM            ERROR INDICATED WITH
       REM            THE EXCEPTION THAT THE
       REM            OPPOSITE SIDE OF THE
       REM            CIRCUIT IS AFFECTED. IF
       REM            ONE OF THESE TWO LOOPS
       REM            FAILED AND THE OTHER WORKED
       REM            CORRECTLY WE CAN ASSUME
       REM            THAT INVERTER 1183-058
       REM            WORKED CORRECTLY.
       TXL *-7        
       CPY            DISCONNECT
       TRA *+2        CONTINUE
       REM            
       BCD 1WDR RT    
       REM            
       IOT            TURN OFF I/O INDICATOR
       NOP            
       REM            
       WDR 1          SELECT DRUM
       CPY ZERO       COPY ZERO WORD INTO DRUM
       REM            ADDRESS ZERO
       RTBA           SELECT TAPE
       CPY ONES       L ALL ONES
       REM            
       IOT            
       TRA *+5        OK
       TSX ERROR-1,4  ERROR AT THIS POINT
       TXL *-7        WILL INDICATE THAT IT
       REM            WAS POSSIBLE TO SELECT
       REM            THE TAPE AFTER THE
       REM            DRUM HAD BEEN SELECTED.
       REM            LOOK AT SYSTEMS PAGE
       REM            5.01.07., AND CIRCUIT
       REM            1036-S.
       TRA *+2        
       REM            
       BCD 1RDR WT    
       REM            
RDWTB  RDR 1          
       CPY SAVE       
       WTBB           
       CPY SAVE1      
       REM            
       IOT            
       TRA *+3        OK
       TSX ERROR-1,4  ERROR AT THIS POINT
       TXL *-7        WILL INDICATE SAME
       REM            TROUBLE AS ROUTINE
       REM            ABOVE EXCEPT THAT
       REM            THE OPPOSITE SIDE OF
       REM            THE AND CIRUIT IS
       REM            AFFECTED.
       CLA SAVE       WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR HERE INDICATES
       NOP RDWTB      THAT WORD WHICH SOULD
       REM            HAVE BEEN PLACED ON
       REM            DRUM AT LOCATION ZERO
       REM            WAS WRITTEN OR READ
       REM            INCORRECTLY.
       REM            
       CLA SAVE1      WORD READ
       LDQ ZERO       NO INFORMATION SHOULD
       CAS ZERO       HAVE BEEN TRANSMITTED
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ERROR INDICATES WORD
       NOP RDWTB      WAS TRANSMITTED AFTER
       REM            DRUM SHOULD HAVE
       REM            DISCONNECT6ED.
       TSX OK,4       
       TRA IOSEL-4    REPEAT
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000   DRUM AND I/O SELECTION INTERLOCK-SECTION 5 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+4   
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
       REM            
*TEST ABILITY OF 709 TO DISPLAY CRT WHILE WRITING
*TAPE, AND READ TAPE WHILE CRT IS BEING DISPLAYED
       REM            
       REM            
CRT    LDI CTRL1      
       LNT 1          TEST FOR CRT
       TRA EFP-16     
       TSX CTX,4      OUT TO MODIFY TAPE INSTR
       HTR JACK,0,BIG 
       REM            
       REM            
*      UNIONJACK ROUTINE
       REM            
       AXT 512,2      REPEAT 1000 TIMES
JACK   WTV            
       NZT TPCHA      TEST FOR TAPE-CHAN A
       TRA *+5        
       TRA *+2        
       REM            
       BCD 1RTBA      
       WTBA           
       RCHA RCDA-2    
       LXA KK1,1      LI2
       CPY KK1,1      
       TIX *-1,1,1    
       TIX *-3,2,1    
       TSX OK,4       
       TRA JACK       
       NOP            
       REM            
       REM            
*DOT CHECKERBOARD TEST 
       REM            
       CLA CNT2       
       STO CNT1       
       REM            
DOT    WTV            
       STZ D1S        
       LXA QQ,4       L2000
ROW    LXA QQ,2       L2000
NEXT   PXD 0,2        
       SUB Q1         L 002000 000000
       SSP            
       STD D1S        
       CPY D1S        
       TIX NEXT,2,64  
       REM            
       CLA D1S        
       ADD KON2       L 77
       STD D1S        
       CPY D1S        
       PXD 0,4        
       ARS 18         
       SUB Q2         L 000000 002100
       SSP            
       STA D1S        
       TIX ROW,4,64   
       REM            
       LXA QQ,1       L2000
LAST   PXD 0,1        
       SUB Q1         L 002000 000000
       SSP            
       STD SIN        
       CPY SIN        
       TIX LAST,1,64  
       REM            
       CLA SIN        
       ADD KON2       L 77
       STD SIN        
       CPY SIN        
       REM            
       CLA CNT1       
       TZE LIGHT      
       SUB ONE        
       STO CNT1       
       TRA DOT+1      
       REM            
       REM            
*INTENSITY TEST       
       REM            
       REM            
LIGHT  WTV            
       AXT 10,4       
       LXD P,2        L 2
BOAT   LXA W,1        L 400
APT    CPY Z,2        
       CLA Z,2        
       ADD W,2        
       STO Z,2        
       TIX APT,1,1    
       REM            
       TIX BOAT,2,1   
       CLA Z          
       STA XX         
       STD Y          
       TIX LIGHT+2,4,1 
       REM            
       REM            
*START DOT INTENSITY TEST
       REM            
       NZT TPCHA      TEST FOR TAPE-CHAN A
       TRA *+4        
       REM            
       BSRA           
       RTBA           
       RCHA SHIMG+6   NO IND ON-WC 400
       REM            READ 1 RECORD
       AXT 512,1      REPEAT 1000 TIMES
BIG    WTV            
       LXA N,4        L 10
F      CLA CPY        
       SSM            
       ADD M          L-000100 000100
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
       TIX BIG+1,1,1  
       TSX OK,4       
       TRA BIG-4      
       REM            
       BCD 1IOT       
       IOT            TEST I/O CHECK TGR
       TRA *+2        ON-ERROR
       TRA *+3        OK-OFF
       TSX ERROR-1,4  
       TXL *-4,4      
       NZT TPCHA      
       TRA EFP-16     
       TRA *+2        
       REM            
       BCD 1TEFA      
       REM            
       TCOA *         
       TEFA *+2       SHOULD NOT BE ON
       TRA *+2        OK
       TSX ERROR-1,4  
       TXL *-3,4      
       REM            
       AXT 256,1      
       AXT 0,2        
       CLA ONE        
       STO RECNO      SET RECNO CONSTAN
       PXA 0,1        
       ADD ONE        
       STO WDNO       SET WORD NO CONSTANT
       REM            
       CLA RDFLD+256,1 WORD READ
       LDQ WRFLD+256,1 CORRECT WORD
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP JACK+5     
       TIX *-7,1,1    
       REM            
       TSX OK,4       
       TRA CRT+3      
       NOP            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000  CRT-ALL DISPLAYS-SECTION 6 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+5   
       REM            
       CLA TPCNT      
       SUB ONE        
       TNZ *+6        
       REM            
       TSX IORST,4    
       HTR BCDTA,0,BCDF+2
       TSX IORST,4    
       HTR STKY,0,BIG 
       TRA *+3        
       STO TPCNT      
       TSX SBCNT,4    TO REDUCE COUNT
       REM            
EFP    SWT 6          
       TRA *+4        
       TSX CTX,4      
       HTR BCDTA,0,BCDF+2
       TRA STKY-5     
       TSX IORST,4    
       HTR STKY,0,EFP 
       REM            
       RCDA           
       RCHA OMY       
       LCHA 0         
       TRA 1          
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
       ORG BEGN+6     
*TEST MULTI-CHANNEL INCLUDING MAIN FRAME,TAPE
*AND CARD MACHINES    
       REM            
       TRA *+2        
       REM            
       BCD 1TOV       TEST TRANSFER ON ACC OVFL
       REM            
TOV    TOV *+1        TURN OFF OVERFLOW TGR.
       TOV *+2        ERROR-TGR DID NOT TURN OFF
       TRA *+3        OK
       TSX ERROR-1,4  
       NOP TOV        
       REM            
       CLA ONES       L ALL ONES
       ALS 3          SHOULD OVFL
       TOV *+5        OK-OVFL. TGR. ON
       TSX ERROR-1,4  
       NOP TOV        
       TRA *+2        
       REM            
       BCD 1TZE       TEST TRANSFER ON ZERO
       REM            
TZE    CLA ZERO       L 0
       TZE *+3        SHOULD TRANSFER
       TSX ERROR-1,4  
       NOP TZE        
       REM            
       CLA TOV        ANY NON-ZERO LOCATION
       TZE *+2        
       TRA *+3        OK SHOULD NOT TRANSFER
       TSX ERROR-1,4  
       NOP TZE        
       REM            
       CLA RSET       POST
       STO 0          RESTART
       REM            
       REM            
*WRITE PRINTER AND WRITE TAPE DURING MF OPERATION
       REM            
       REM            
TX     TSX CTX,4      
       HTR TX,0,TXA   
       REM            
       NZT TPCHB      TEST FOR TAPE CHANNEL B
       TRA *+4        NO
       REM            
       ETTB           
       REWB           
       WTBB           
       REM            
       NZT TPCHD      TEST FOR TAPE CHANNEL D
       TRA *+4        NO
       REM            
       ETTD           
       REWD           
       WTBD           
       NZT TPCHF      TEST FOR TAPE CHANNEL F
       TRA *+4        NO
       REM            
       ETTF           
       REWF           
       WTBF           
       REM            
       REM            THE APPROX.
       REM               TIME BETWEEN SELECT
       REM            AND RCH IS 6 MS
       REM            
       TSX SHIFT,2    TO SHIFT PRINT IMAGE
       REM            
       NZT TPCHB      TEST FOR TAPE CHANNEL B
       TRA *+2        NO
       REM
       RCHB SHIMG+3   S TGR ON-WRD CNT 400
       NZT TPCHD      TEST FOR TAPE-CHAN. D
       TRA *+2        
       REM            
       RCHD SHIMG+3   S TGR ON-WRD CNT 400
       NZT TPCHF      TEST FOR TAPE-CHAN. F
       TRA *+2        
       REM            
       RCHF SHIMG+3   S TGR ON-WRD CNT 400
       TRA *+2        
       REM            
       BCD 1IOT       
       REM            
       IOT            
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       TXL *-4        
       REM            
       NZT PRCHA      TEST FOR PRINTER-CHAN. A
       TRA *+2        NO
       REM            
       WPRA           
       NZT PRCHC      TEST FOR PRINTER-CHAN. C
       TRA *+2        NO
       REM            
       WPRC           
       NZT PRCHE      TEST FOR PRINTER-CHAN. E
       TRA *+2        NO
       REM            
       WPRE           
       TRA *+2        
       REM            
       BCD 1ALS       TEST ACC LEFT SHIFT
       REM            
       AXT 2097,1     THE APPROX.
       TIX *,1,1      TIME BETWEEN SELECT
       REM            AND RCH IS 58MS
       REM            
       REM            
ALS    LXA THSVN,1    L ADDR 37
       CLA ONES       L ALL ONES
       ALS 1          
       TOV *+3        SHOULD TRANSFER
       TSX ERROR-1,4  OVFL TGR WAS NOT TURNED ON
       NOP ALS-2      LK AT SYSMTES PAGE 2.06.01
       TZE *+2        
       TRA *+3        OK-
       TSX ERROR-1,4  ERROR-ACC WAS CLEARED
       NOP ALS-2      
       PBT            
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ENTRY HERE MEANS A BIT
       NOP ALS-2      WAS NOT SHIFTED INTO P
       TIX ALS+2,1,1  LOOP 37 TIMES
       REM            
       NZT PRCHA      TEST FOR CHAN A
       TRA *+2        NO
       REM            
       RCHA SHIMG     S TGR ON-WRD CNT 30
       NZT PRCHC      TEST FOR CHAN C
       TRA *+2        NO
       REM            
       RCHC SHIMG     S TGR ON-WRD CNT 30
       NZT PRCHE      TEST FOR CHAN E
       TRA *+2        NO
       REM            
       RCHE SHIMG     S TGR ON-WRD CNT 30
       TRA *+2        NO
       REM            
       BCD 1IOT       
       REM            
       IOT            TEST IOT TGR
       TRA *+2        ERROR-HERE MIGHT INDICATE
       REM            THAT THE TIMING BETWEEN
       REM            SELECT AND RESET CHANNEL
       REM            IS TOO SHORT
       TRA *+3        
       TSX ERROR-1,4  
       TXL *-4,4,0    
       TRA *+2        
       REM            
       BCD 1ADD       LONG ADDER TEST
       REM            
ADD    LXD DELAY,2    L7777
       CLA 4095,2     
       COM            
       ADD 4095,2     
       TOV *+1        TURN OFF OVFL TGR
       TPL PLUS       
       TMI *+3        
       TSX ERROR-1,4  MAY ENTER HERE IF COMB. OF
       TRA ADD        TPL AND TMI FOULS UP
       REM            
       SUB ONE        SIGN MINUS-RESULT SHBE ZERO
       TZE OVFL       
       TSX ERROR-1,4  ERROR HERE MAY INDICATE
       TRA ADD        FIALURE TO RE-COMPLEMENT
       REM            AFTER Q CARRY
PLUS   ADD ONE        
       TZE OVFL       
       TSX ERROR-1,4  ERROR HERE MAY INDICATE
       TRA ADD        FAILURE TO RECOMPLEMENT
       REM            AFTER Q CARRY
       REM            
OVFL   TNO *+7        
       TOV *+0        
       CLA 4095,2     
       CAS 4095,2     
       TRA *+9        ERROR-MEMORY LESS
       TRA LOOP       OK
       TRA *+10       ERROR-MEMORY HIGH
       REM            
       TSX ERROR-1,4  ERROR HERE MAY MEAN OVFL
       TRA ADD        TGR WAS NOT TURNED ON.
       TRA OVFL+2     
       REM            
       TSX ERROR-1,4  TNO DID NOT TURN TRIGGER
       TRA ADD        OFF
       TRA OVFL+2     
       REM            
       TSX ERROR-1,4  
       TRA ADD        
       TRA OVFL+2     
       REM            
       TSX ERROR-1,4  
       TRA ADD        
       TRA OVFL+2     
       REM            
LOOP   TIX ADD+1,2,1  
       REM            
       TSX RDNCK,4    TEST FOR RDNCY-WRITING
       NOP RDCKT      
       REM            
       TSX SHIFT,2    SHIFT PRINT IMAGE
       REM            
       TSX OK,4       
       TRA TX+2       
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
       REM            
*  PRINT --           
**   00000  WRITE TAPE AND WRITE PRINTER-SECTION 7 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+6   
       TRA *+2        
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
*READ TAPE AND READ PRINTER DURING MF OPERATION
       REM            
       REM            
       BCD 1RTB       
       REM            
       NZT TPCHB      TEST FOR TAPE CHAN. B
       TRA *+2        NO
       REM            
UGO    BSRB           BACKSPACE OVER 400 WRD REC
       NZT TPCHD      TEST FOR TAPE CHAN. D
       TRA *+2        NO
       REM            
       BSRD           BACKSPACE OVER 400 WRD REC
       NZT TPCHF      TEST FOR TAPE CHAN. F
       TRA *+2        NO
       REM            
       BSRF           BACKSPACE OVER 400 WRD REC
       NZT TPCHB      TEST FOR TAPE CHAN. B
       TRA *+3        NO
       REM            
       RTBB           
       RCHB SHIMG+6   NO TGRS ON-WRD CNT 400
       REM            
       NZT TPCHD      TEST FOR TAPE CHAN. D
       TRA *+3        NO
       REM            
       RTBD           
       RCHD SHI-1     NO INDS ON-WC 400
       REM            
       NZT TPCHF      TEST FOR TAPE CHAN. F
       TRA *+3        NO
       REM            
       RTBF           
       RCHF SHI       NO INDS ON-WC 400
       REM            
       NZT PRCHA      TEST FOR PRINTER CHAN A
       TRA *+3        NO
       REM            
       RPRA           SELECT PRINTER FOR READ
       RCHA LOST      S IND ON
       REM            
       NZT PRCHC      TEST FOR PRINTER CHAN C
       TRA *+3        NO
       REM            
       RPRC           
       RCHC CAUSE     S IND ON
       REM            
       NZT PRCHE      TEST FOR PRINTER CHAN E
       TRA *+3        NO
       REM            
       RPRE           
       RCHE XCEL      S IND ON
       REM            
       TRA *+2        
       REM            
       BCD 1IIA       TEST-INVERT INDICATORS
       REM            FROM ADDRESS
       CAL ONES       L ALL ONES
       PAI            ALL ONES IN INDICATORS
       IIA            INVERT
       PIA            SHOULD BE ZERO HERE
       TZE *+2        OK.
       TSX ERROR,4    INDICATORS DID NOT INVERT
       NOP *-6        
       TRA *+2        
       REM            
       BCD 1IIR       RIPPLE TEST
       REM            
       CLA IIR        L IIR INSTRUCTION
       ORA BIT35      L ONE IN POSITION 35
       STO *+5        
       LXD CO22,1     L +22
       CLA BIT35      L+1
       STO SAVE1      SAVE ACC
       LDI SAVE1      TURN ON IND. BEING TESTED
       IIR 1          TURN OFF IND. BEING TESTED
       PIA            PLACE IND. IN ACC.
       TZE *+3        AND TEST
       TSX ERROR-1,4  
       TRA *-11       REPEAT SW #1 DOWN
       REM            
       CLA SAVE1      BRING IN BIT PREV. TESTED
       ALS 1          
       ORA IIR        PLACE BIT IN IIR INSTR.
       STO *-8        
       ANA ADDR       L+777777
       TIX *-12,1,1   RETURN TO TEST ALL RT
       REM            HALF IND. POSITIONS
       TRA *+2        
       REM            
       BCD 1IIL       RIPPLE TEST LEFT HALF
       REM            
       CLA IIL        L IIL INSTRUCTION
       ORA BIT35      L 1 IN POSITION 35
       STO *+8        
       CLA BIT35      L+1
       STO SAVE1      SAVE ACC
       REM            
       LXD CO22,1     L+22
       CLA 400K       
       ALS 1          
       SLW SAVE2      
       PAI            
       IIL 1          
       PIA            BRING IN IND TO BE TESTED
       REM            AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  
       TRA *-14       
       REM            
       REM            
       CLA SAVE1      ADJUST
       ALS 1          F
       STO SAVE1      FIELD
       ORA IIL        IIL INSTRUCTION
       SLW *-9        ADJUST IIL INSTRUCTION
       CAL SAVE2      
       TIX *-14,1,1   RETURN OT TEST ALL POS.
       REM            LEFT HALF INDS.
       REM            
       TSX RDNCK,4    TEST RDNCY-READING
       NOP UGO-2      
       TRA *+2        CONTINUE
       REM            
       BCD 1IOT       
       REM            
       IOT            
       TRA *+2        ERROR HERE MIGHT INDICATE
       REM            THAT THE PRINTER DROPPED
       REM            OUT OF SELECT, OR THE
       REM            CONTROL WORD INDS DID NOT
       REM            OPERATE CORRECTLY
       TRA *+3        OK
       TSX ERROR-1,4  
       TXL *-4,4,0    DO NOT REPEAT
       TSX OK,4       
       TRA UGO-2      
       NOP            
       REM            
       REM            
*WRITE TAPE ALL CHANNELS DURING MF OPERATION
       REM            
       REM            
HOPE   NZT TPCHA      TEST FOR TAPE CHAN A
       TRA *+5        NO
       REM            
       ETTA           
       REWA           
       WTBA           
       RCHA WTB1      TGR 1 ON-WRD CNT 40
       REM            
       NZT TPCHB      TEST FOR TAPE CHAN B
       TRA *+5        NO
       REM            
       ETTB           
       REWB           
       WTBB           
       RCHB WTB1      TGR 1 ON-WRD CNT 40
       REM            
       NZT TPCHC      TEST FOR TAPE CHAN B
       TRA *+5        NO
       REM            
       ETTC           
       REWC           
       WTBC           
       RCHC WTB1      TGR 1 ON-WRD CNT 40
       REM            
       NZT TPCHD      TEST FOR TAPE CHAN C
       TRA *+5        NO
       REM            
       ETTD           
       REWD           
       WTBD           
       RCHD WTB1      TGR 1 ON-WRD CNT 40
       REM            
       NZT TPCHE      TEST FOR TAPE CHAN E
       TRA *+5        NO
       REM            
       ETTE           
       REWE           
       WTBE           
       RCHE WTB1      TGR 1 ON-WRD CNT 40
       REM            
       NZT TPCHF      TEST FOR TAPE CHAN F
       TRA *+5        NO
       REM            
       ETTF           
       REWF           
       WTBF           
       RCHF WTB1      TGR 1 ON-WRD CNT 40
       REM            
VILE   AXT 256,1      L +400
       LXA ZERO,2     L+0
       CLA BIT35      L+1
       STO RECNO      SET REC NO CONSTANT
       PXA 0,1        
       ADD BIT35      L+1
       STO WDNO       SET WORD NO CONSTANT
       REM            
       REM            
*COMPARISION-READ TAPE AND READ PRINTER SECTION
       REM            
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+9        NO
       REM            
       CLA RDFLD+256,1 WORD READ
       LDQ WRFLD+256,1 CORRECT WORD
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK-EQUAL
       TSX ERROR-2,4  
       NOP BCDTB+1    
       TIX *-7,1,1    WORDS HAVE BEEN CHECKED
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+10       NO
       REM            
       AXT 256,1      
       CLA RFCD+256,1 WORD READ
       LDQ WRFLD+256,1 CORRECT WORD
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK-EQUAL
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    WORDS HAVE BEEN CHECKED
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+10       NO
       REM            
       AXT 256,1      
       CLA RFEF+256,1 WORD READ
       LDQ WRFLD+256,1 CORRECT WORD
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK-EQUAL
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    WORDS HAVE BEEN CHECKED
       REM            
       TSX ECHOS,2    OUT TO FORM ECHO IMAGE
       TSX ECHCS,2    
       TSX ECHES,2    
       REM            
       LXA ZERO       L+0
       LXD CO22,1     L+22
       CLA ONE        L+1
       STO RECNO      SET RECNO CONSTANT
       PXA 0,1        
       ADD BIT35      L+1
       STO WDNO       SET WD NO CONSTANT
       REM            
       NZT PRCHA      TEST FOR PRINTER A
       TRA *+9        
       REM            
WASTE  CLA ECHO+18,1  WORD READ
       LDQ WRIT2+18,1 CORRECT WORD
       CAS WRIT2+18,1 
       TRA *+2        ERROR
       TRA *+3        OK-EQUAL
       TSX ERROR-2,4  COMPARISON ERROR
       NOP PREA+1      
       TIX WASTE,1,1  RETURN TO CHECK ALL WORDS
       REM            
       NZT PRCHC      TEST FOR PRINTER C
       TRA *+10       
       REM            
       AXT 18,1       
       CLA ECHOC+18,1 WORD READ
       LDQ WRIT2+18,1 CORRECT WORD
       CAS WRIT2+18,1 
       TRA *+2        ERROR
       TRA *+3        OK-EQUAL
       TSX ERROR-2,4  COMPARISON ERROR
       NOP PREC+1      
       TIX *-7,1,1    RETURN TO CHECK ALL WORDS
       REM            
       NZT PRCHE      TEST FOR PRINTER E
       TRA *+10       
       REM            
       AXT 18,1       
       CLA ECHOE+18,1 WORD READ
       LDQ WRIT2+18,1 CORRECT WORD
       CAS WRIT2+18,1 
       TRA *+2        ERROR
       TRA *+3        OK-EQUAL
       TSX ERROR-2,4  COMPARISON ERROR
       NOP PREC+1      
       TIX *-7,1,1    RETURN TO CHECK ALL WORDS
       TRA *+2        CONTINUE
       REM            
       BCD 1WTB       
       REM            
RDCKT  TSX RDNCK,4    CHECK RDNCY-WRITING
       NOP *-1        
       TSX OK,4       
       TRA HOPE       
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
       REM            
*  PRINT --           
**   00000   READ TAPE AND READ PRINTER-SECTION 8 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+7   
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
XTRA   AXT 6,1        6 INTO XRA
       NZT TPCHB      TEST FOR TAPE-CHAN B
       TRA *+2        NO
       REM            
       BSRB           BACKSPACE OVER
       REM            
       NZT TPCHA      TEST FOR TAPE-CHAN A
       TRA *+2        NO
       REM            
       BSRA           BACKSPACE OVER
       REM            
       NZT TPCHC      TEST FOR TAPE-CHAN C
       TRA *+2        NO
       REM            
       BSRC
       REM
       NZT TPCHD      TEST FOR TAPE-CHAN D
       TRA *+2        NO
       REM            
       BSRD           BACKSPACE OVER
       REM            
       NZT TPCHE      TEST FOR TAPE-CHAN E
       TRA *+2        NO
       REM            
       BSRE           BACKSPACE OVER
       REM            
       NZT TPCHF      TEST FOR TAPE-CHAN F
       TRA *+2        NO
       REM            
       BSRF           BACKSPACE OVER
       TIX XTRA+1,1,1 
       REM            
       REM            
*CLEAR FIRST RECORD AREAS
       REM            
       REM            
       AXT 32,1       40 INTO XRA
       STZ RDFLD+32,1 CLEAR RDFLD
       STZ RFCD+32,1  
       STZ RFEF+32,1  
       TIX *-3,1,1    FIRST REC AREA
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*   PRINT --          
**    00000   WRITE TAPE ALL CHANNELS-SECTION 9 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+8   
       REM            
       REM            
       REM            
       REM            
*READ TAPE AND WRITE PUNCH DURING MF OPERATION
       REM            
       REM            
       NZT TPCHB      TEST FOR TAPE-CHAN B
       TRA *+3        NO
       REM            
       RTBB           
       RCHB RDTP      TGR 1 ON-SHOULD NOT
       REM            TRANSMIT FIRST RECORD
       REM            
       NZT TPCHD      TEST FOR TAPE-CHAN D
       TRA *+3        NO
       REM            
       RTBD           
       RCHD RDTP1     IND 1 ON-SHOULD NOT
       REM            TRANSMIT FIRST RECORD
       REM            
       NZT TPCHF      TEST FOR TAPE-CHAN F
       TRA *+3        NO
       REM            
       RTBF           
       RCHF RDTP2     IND 1 ON-SHOULD NOT
       REM            TRANSMIT FIRST RECORD
       REM            
       TSX SHIFT,2    
       REM            
       NZT PUCHA      TEST FOR PUNCH CHAN A
       TRA *+3        NO
       REM            
       WPUA           
LACE   RCHA SHIM      1 AND 2 TGRS ON-WRD CNT 30
       REM            NO LCH FOLLOWS SHOULD
       REM            DISCONNECT AFTER ONE
       REM            CARD HAS BEEN PUNCHED
       REM            
       NZT PUCHC      TEST FOR PUNCH CHAN C
       TRA *+3        NO
       REM            
       WPUC           
       RCHC SHIM      1 AND 2 INDS ON-WRD CNT 30
       REM            NO LCH FOLLOWS SHOULD
       REM            DISCONNECT AFTER ONE
       REM            CARD HAS BEEN PUNCHED
       REM            
       NZT PUCHE      TEST FOR PUNCH CHAN E
       TRA *+3        NO
       REM            
       WPUE           
       RCHE SHIM      1 AND 2 INDS ON-WRD CNT 30
       REM            NO LCH FOLLOWS SHOULD
       REM            DISCONNECT AFTER ONE
       REM            CARD HAS BEEN PUNCHED
       REM            
       LXD SHIMG+3,2  L 400
       REM            
       REM            
       TIX *,2,1      DELAY
       TRA *+2
       REM            
       BCD 1TZE IA    TEST TZE DOUBLY INDIRECT
       REM            ADDRESSED
       CLA ONES       L ALL ONES
       SUB ONES       L ALL ONES
       TZE* *+3       SHOULD TRANSFER
       TSX ERROR,4    FAILED TO TRANSFER
       TRA *-4        REPEAT
       REM            
       TZE* *+3       SHOULD TRANSFER
       TSX ERROR,4    FAILED TO TRANSFER
       TRA *-7        ON SECOND IND. ADDR.
       REM            
       CLA SUB        L IND ADDR. CLA
       SUB 0          LOC IF INDEXING FAILED
       STO RSLT       
       REM            
       CLA SUB        L IND ADDR CLA
       SUB NOP        LOC IF IND. ADDR. FAILED
       STO RSLT1      
       TRA *+3        
       REM            
       BCD 1CLA IA    TEST CLA AND SUB INDLY
       REM            
CLA    BCD 1SUB IA    ADDRESS AND INDEXED
       REM            
SUB    CLA* NOP+1,2   SHOULD BRING IN THIS LOC.
       SUB* NOP+1,2   
       TZE SUIN1+2    OK
       TRA *+3        ERROR-GO TO PIN POINT
       REM            TROUBLE
NOP    NOP SUB        DUMMY FOR IND. ADDR.
       OCT 0          
       REM            
       CLA* NOP+1,2   
       LDQ SUB        
       CAS 0          
       TRA *+2        OK
       TRA CLIND      ERROR
       CAS NOP         
       TRA *+2        OK
       TRA CLIN1      ERROR
       SUB* NOP+1,2   
       LDQ ZERO       CORRECT RESULT
       CAS RSLT       
       TRA *+2        OK
       TRA SUIND      ERROR
       CAS RSLT1      
       TRA *+2        OK
       TRA SUIN1      ERROR
       TRA SUIN1+2    CONTINUE
RSLT1  OCT 0          
RSLT   OCT 0          
CLIND  TSX ERROR-1,4  ENTRY HERE WOULD MEAN
       REM            INDEXING FAILURE DURING
       REM            CLA INSTRUCTION
       NOP CLA        
       TRA SUIN1+2    
CLIN1  TSX ERROR-1,4  ENTRY HERE WOULD MEAN
       NOP CLA        IND. ADDRING FAILURE
       TRA SUIN1+2    DURING CLA INSTRUCTION
       REM            
SUIND  TSX ERROR-1,4  ENTRY HERE WOULD MEAN
       REM            INDEXING FAILURE DURING
       REM            SUB INSTRUCTION
       NOP SUB        
       TRA SUIN1+2    
SUIN1  TSX ERROR-1,4  ENTRY HERE WOULD MEAN
       NOP SUB        IND. ADDRESSING FAILURE
       REM            DURING SUB INSTRUCTION
       REM            
       TSX RDNCK,4    TEST RDNCY AFTER TAPE READ
       NOP UGO-2      
       TRA *+2        
       REM            
       BCD 1IOT       TEST IOT FOR WPUA
       REM            
       IOT            
       TRA *+2        ERROR-SHOULD BE OFF
       TRA *+3        OK
       TSX ERROR-1,4  
       TXL *-4,4,0    
       REM            
       REM            
*COMPARISON FOR TAPE READ-READ TAPE AND WRITE PUNCH
*SECTION-FIRST RECORD 
       REM            
       REM            
A      CLA XTRA       L ADDR 6
       ADD ONE        L+1
       STA RECNO      SET REC NO CONSTANT
       CLA *+4        L ADDR 32
       ADD ONE        L+1
       STA WDNO       SET WORD NO CONSTANT
       REM            
       AXT 6,2        NO OF RECS
       AXT 32,1       NO OF WORDS
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+9        NO
       REM            
       CLA RDFLD+32,1 WORD READ
       LDQ ZERO       SHOULD HAVE READ ALL ZEROS
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTB+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+10       NO
       REM            
       AXT 32,1       NO OF WORDS
       CLA RFCD+32,1  WORD READ
       LDQ ZERO       SHOULD HAVE READ ALL ZEROS
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+10       NO
       REM            
       AXT 32,1       NO OF WORDS
       CLA RFEF+32,1  WORD READ
       LDQ ZERO       SHOULD HAVE READ ALL ZEROS
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    
       TIX *+1,2,1    
       TSX OK,4       
       TRA XTRA       
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
       REM            
*   PRINT --          
**    00000  READ TAPE AND WRITE PUNCH-SECTION 10 COMPLETE
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+9   
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
       NZT TPCHB      TEST FOR TAPE CHAN B
       TRA *+5        NO
       REM            
D      ETTB           
       REWB           
       WTBB           
       RCHB TPCTL     NO TGRS ON-WRD CNT 400
       REM            
       NZT TPCHD      TEST FOR TAPE CHAN D
       TRA *+5        NO
       REM            
       ETTD           
       REWD           
       WTBD           
       RCHD TPCTL     NO INDS ON-WRD CNT 400
       REM            
       NZT TPCHF      TEST FOR TAPE CHAN F
       TRA *+5        NO
       REM            
       ETTF           
       REWF           
       WTBF           
       RCHF TPCTL     NO INDS ON-WRD CNT 400
       REM            
TAB    NZT TPCHA      TEST FOR TAPE ON CHAN A
       TRA *+3        NO
       REM            
       RTBA           
       RCHA RDTP      IND1 ON-SHD NOT TRANSMIT 
       REM            FIRST RECORD
       REM            
       NZT TPCHC      TEST FOR TAPE ON CHAN C
       TRA *+3        NO
       REM            
       RTBC           
       RCHC RDTP1     IND 1 ON SHOULD NOT
       REM            TRANSMIT FIRST RECORD
       REM            
       NZT TPCHE      TEST FOR TAPE ON CHAN E
       TRA *+3        NO
       REM            
       RTBE           
       RCHE RDTP2     IND 1 ON SHOULD NOT
       REM            TRANSMIT FIRST RECORD
       REM            
       REM            
*COMPARISON-TAPE READ-READ TAPE AND
*WRITE PUNCH SECTION-REMAINING RECORDS
       REM            
       REM            
TXA    NZT TPCHB      TEST FOR TAPE CHAN B
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RDFLD+64,1 WORD READ
       LDQ WRFLD+64,1 WORD GENERATED
       CAS WRFLD+64,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTB+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       NZT TPCHD      TEST FOR TAPE CHAN D
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFCD+64,1  WORD READ
       LDQ WRFLD+64,1 WORD GENERATED
       CAS WRFLD+64,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       REM            
       NZT TPCHF      TEST FOR TAPE CHAN F
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFEF+64,1  WORD READ
       LDQ WRFLD+64,1 WORD GENERATED
       CAS WRFLD+64,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO
       REM            
TPA1   NZT TPCHB      TEST FOR TAPE CHAN B
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RDFLD+96,1 WORD READ
       LDQ WRFLD+96,1 WORD GENERATED
       CAS WRFLD+96,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTB+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       REM            
       NZT TPCHD      TEST FOR TAPE CHAN D
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFCD+96,1  WORD READ
       LDQ WRFLD+96,1 WORD GENERATED
       CAS WRFLD+96,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       NZT TPCHF      TEST FOR TAPE CHAN F
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFEF+96,1  WORD READ
       LDQ WRFLD+96,1 WORD GENERATED
       CAS WRFLD+96,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO.
       REM            
       AXT 96,1       140 INTO XRA
       PXA 0,1        
       ADD ONE        L+1
       STO WDNO       SET WORD NO CONSTANT
       REM            
TPA2   NZT TPCHB      TEST FOR TAPE CHAN B
       TRA *+9        NO
       REM            
       CLA RDFLD+192,1 WORD READ
       LDQ WRFLD+192,1 WORD GENERATED
       CAS WRFLD+192,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTB+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       NZT TPCHD      TEST FOR TAPE CHAN D
       TRA *+10       NO
       REM            
       AXT 96,1       
       CLA RFCD+192,1 WORD READ
       LDQ WRFLD+192,1 WORD GENERATED
       CAS WRFLD+192,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       NZT TPCHF      TEST FOR TAPE CHAN F
       TRA *+10       NO
       REM            
       AXT 96,1       
       CLA RFEF+192,1 WORD READ
       LDQ WRFLD+192,1 WORD GENERATED
       CAS WRFLD+192,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO.
       REM            
       AXT 32,1       40 INTO XRA
       PXA 0,1        
       ADD ONE        L+1
       STO WDNO       SET WORD NO CONSTANT
       REM            
TPA3   NZT TPCHB      TEST FOR TAPE CHAN B
       TRA *+9        NO
       REM            
       CLA RDFLD+224,1 WORD READ
       LDQ WRFLD+224,1 WORD GENERATED
       CAS WRFLD+224,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTB+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       NZT TPCHD      TEST FOR TAPE CHAN D
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFCD+224,1 WORD READ
       LDQ WRFLD+224,1 WORD GENERATED
       CAS WRFLD+224,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       NZT TPCHF      TEST FOR TAPE CHAN F
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFEF+224,1 WORD READ
       LDQ WRFLD+224,1 WORD GENERATED
       CAS WRFLD+224,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO.
       REM            
TPA4   NZT TPCHB      TEST FOR TAPE CHAN B
       TRA *+9        NO
       REM            
       AXT 32,1       
       CLA RDFLD+256,1 WORD READ
       LDQ WRFLD+256,1 WORD GENERATED
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTB+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       NZT TPCHD      TEST FOR TAPE CHAN D
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFCD+256,1 WORD READ
       LDQ WRFLD+256,1 WORD GENERATED
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    RETURN TO TEST ALL WORDS
       REM            
       NZT TPCHF      TEST FOR TAPE CHAN F
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFEF+256,1 WORD READ
       LDQ WRFLD+256,1 WORD GENERATED
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    
       TRA *+2        
       REM            
       BCD 1TP R/W    DUMMY FOR RD AND WRITE TAPE
       REM            
       TSX RDNCK,4    
       NOP *-1        
       REM            
       REM            
*INITIALIZE TO USE ROUTINE ABOVE TO TEST READING
*TAPE FROM CHANNEL A,C+D. THIS WILL BE THEN CHANGED
*BACK TO ORIGINAL STATE, AFTER TESTING.
       REM            
       REM            
B      CLA D-8        L SWT 3
       STO SAVE1      
       CLA BCD1       L TRA YALE-4
       STO D-8        
       CLA B          L CLA A-1
       STO SAVE2      
       CLA BCD2       L TRA C
       STO B          
       REM            
       CLA TAB        
       STO A+8        
       STO TXA        
       STO TPA1       
       STO TPA2       
       STO TPA3       
       STO TPA4       
       CLA TAB+4      
       STO A+18       
       STO TXA+11     
       STO TPA1+11    
       STO TPA2+10    
       STO TPA3+10    
       STO TPA4+11    
       CLA TAB+8      
       STO D-22       
       STO TPA1-12    
       STO TPA2-16    
       STO TPA3-16    
       STO TPA4-12    
       STO B-15       
       REM            
       CLA BCDTD      
       LDQ BCDTC      
       STO BCDTC      
       STQ BCDTD      
       REM            
       CLA BCDTF      
       LDQ BCDTE      
       STO BCDTE      
       STQ BCDTF      
       REM            
       CLA BCDTA      
       LDQ BCDTB      
       STO BCDTB      
       STQ BCDTA      
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000   WRITE TAPE AND READ TAPE-SECTION 11 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+10  
       TRA A+6        
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
*READ TAPE AND WRITE PRINTER DURING MF OPERATION
       REM            
       REM            
       TSX CTX,4      
       HTR YALE-2,0,BEGFP
       REM            
       NZT TPCHB      TEST FOR TAPE-CHAN B
       TRA *+2        NO
       REM            
YALE   BSRB           
       REM            
       NZT TPCHD      TEST FOR TAPE-CHAN D
       TRA *+2        NO
       REM            
       BSRD           
       REM            
       NZT TPCHF      TEST FOR TAPE-CHAN F
       TRA *+2        NO
       REM            
       BSRF           
       REM            
       NZT TPCHB      TEST FOR TAPE-CHAN B
       TRA *+3        NO
       REM            
       RTBB           
       RCHB SHIMG+6   NO TGRS ON-WRD CNT 400
       REM            
       NZT TPCHD      TEST FOR TAPE-CHAN D
       TRA *+3        NO
       REM            
       RTBD           
       RCHD SHI-1     NO INDS ON-WC 400
       REM            
       NZT TPCHF      TEST FOR TAPE-CHAN F
       TRA *+3        NO
       REM            
       RTBF           
       RCHF SHI       NO INDS ON-WC 400
       REM            
       NZT PRCHA      TEST FOR PRINTER-CHAN A
       TRA *+3        NO
       REM            
       WPRA           
       RCHA SHIM      1 AND 2 TGRS ON-WRD CNT 30
       REM            MAY ACT AS IND ADD CNTL WRD
       REM            IF SO A SECOND LINE OR PART
       REM            OF A 2ND LINE MAY BE PRINTED
       NZT PRCHC      TEST FOR PRINTER-CHAN C
       TRA *+3        NO
       REM            
       WPRC           
       RCHC SHIM      1 AND 2 TGRS ON-WRD CNT 30
       REM            MAY ACT AS IND ADD CNTL WRD
       REM            IF SO A SECOND LINE OR PART
       REM            OF A 2ND LINE MAY BE PRINTED
       NZT PRCHE      TEST FOR PRINTER-CHAN E
       TRA *+3        NO
       REM            
       WPRE           
       RCHE SHIM      1 AND 2 TGRS ON-WRD CNT 30
       REM            MAY ACT AS IND ADD CNTL WRD
       REM            IF SO A SECOND LINE OR PART
       REM            OF A 2ND LINE MAY BE PRINTED
       REM            
       TRA TXA        
       REM            
       REM            
*ROUTINE TO RESTORE INITIAL INSTRUCTUIONS
       REM            
       REM            
C      CLA SAVE1      RESTORE SWT 3
       STO D-8        
       CLA SAVE2      RESTORE CLA D-2
       STO B          
       REM
       CLA BCDTC      
       LDQ BCDTD      
       STO BCDTD      
       STQ BCDTC      
       REM            
       CLA BCDTE      
       LDQ BCDTF      
       STO BCDTF      
       STQ BCDTE      
       REM            
       CLA TBA        
       STO A+8        
       STO TXA        
       STO TPA1       
       STO TPA2       
       STO TPA3       
       STO TPA4       
       CLA TBA1       
       STO A+18       
       STO TXA+11     
       STO TPA1+11    
       STO TPA2+10    
       STO TPA3+10    
       STO TPA4+11    
       CLA TBA2       
       STO D-22       
       STO TPA1-12    
       STO TPA2-16    
       STO TPA3-16    
       STO TPA4-12    
       STO B-15       
       REM            
       CLA BCDTA      
       LDQ BCDTB      
       STO BCDTB      
       STQ BCDTA      
       AXT 256,1      400 INTO XRA
       AXT 0,2        ZERO INTO XRB
       CLA ONE        L+1
       STO RECNO      SET RECNO CONSTANT
       PAX 0,1        
       ADD ONE        L+1
       STA WDNO       SET WDNO CONSTANT
       REM            
       TSX RDNCK,4    RDNCY CHECK-RD TAPE CHAN B
       NOP UGO-2      
       REM            
       REM            
*COMPARISON FOR READ TAPE AND WRITE PRINTER SECTION
       REM            
       REM            
TBA    NZT TPCHB      TEST FOR TAPE CHAN B
       TRA *+9        NO
       REM            
       CLA RDFLD+256,1 WORD READ
       LDQ WRFLD+256,1 WORD GENERATED
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTB+1    
       TIX *-7,1,1    RETURN TO TEST A WORDS
       REM            
       REM            
TBA1   NZT TPCHD      TEST FOR TAPE CHAN D
       TRA *+10       NO
       REM            
       AXT 256,1      
       CLA RFCD+256,1 WORD READ
       LDQ WRFLD+256,1 CORRECT WORD
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    
       REM            
TBA2   NZT TPCHF      TEST FOR TAPE CHAN F
       TRA *+10       NO
       REM            
       AXT 256,1      
       CLA RFEF+256,1 WORD READ
       LDQ WRFLD+256,1 CORRECT WORD
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    
       REM            
       REM            
       TSX OK,4       
       TRA D-2        
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
       REM            
*  PRINT --           
**   00000  READ TAPE AND WRITE PRINTER-SECTION 12 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+11  
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
YUK    TSX SHIFT,2    SHIFT PRINT IMAGE
       REM            
       REM            
*WRITE TAPE AND WRITE PUNCH DURING MF OPERATIONS
       REM            
       REM            
WTWPU  NZT TPCHB      
       TRA *+3        NO
       REM            
       ETTB           
       REWB           
       NZT TPCHD      TEST FOR TAPE-CHAN D
       TRA *+3        NO
       REM            
       ETTD           
       REWD           
       NZT TPCHF      TEST FOR TAPE-CHAN F
       TRA *+3        NO
       REM            
       ETTF           
       REWF           
       REM            
       NZT PUCHA      TEST FOR PUNCH-CHAN A
       TRA *+3        NO
       REM            
       WPUA           
       RCHA WPUA      TGRS S AND 1 ON-WRD CNT 10
       NZT PUCHC      TEST FOR PUNCH-CHAN C
       TRA *+3        NO
       REM            
       WPUC           
LACE1  RCHA WPUA      TGRS S AND 1 ON-WRD CNT 10
       REM            
       NZT PUCHE      TEST FOR PUNCH-CHAN E
       TRA *+3        NO
       REM            
       WPUE           
       RCHE WPUA      TGRS S AND 1 ON-WRD CNT 10
       REM            
       NZT TPCHB      TEST FOR TAPE-CHAN B
       TRA *+3        NO
       REM            
       WTBB           
       RCHB SHIMG+5   NO TGRS ON-WRD CNT 400
       REM            
       NZT TPCHD      TEST FOR TAPE-CHAN D
       TRA *+3        NO
       REM            
       WTBD           
       RCHD SHIMG+5   NO INDS ON-WRD CNT 400
       REM            
       NZT TPCHF      TEST FOR TAPE-CHAN F
       TRA *+3        NO
       REM            
       WTBF           
       RCHF SHIMG+5   NO INDS ON-WRD CNT 400
       REM            
       TRA *+2        CONTINUE
       REM            
*FLOATING-TO-FIXED, FIXED-TO-FLAOTING INTEGER
*TRANSLATION, AUTOMATIC MODE
       REM            
       BCD 1UFA       
       REM            
BEGFP  TSX PART2,4    
       AXT SECFP,1    SET RETURN ADDRESS
       SXA SECT2,1    IN CASE OF TRAP
       CLA FPCON      L 202.402
       UFA FPCON+1    L 233.0
       ANA KK         FIXED POINT 2 NOW IN ACC
       REM            
       CAS TWO        
       TXI *+2        ERROR IN FIXING
       TRA *+6        OK
       STQ Q          
       LDQ TWO        CORRECT ANS IN MQ
       TSX ERROR-1,4  ERROR IN ACC
       TRA BEGFP      
       LDQ Q          RESTORE QUOTIENT
       XCA            
       CAS CCH        L 200.0
       TXI *+2        ERROR
       TRA *+4        OK
       LDQ CCH        CORRECT ANS IN MQ
       TSX ERROR-1,4  ERROR IN MQ FACTOR,
       TRA BEGFP      CORRECT ANS IN MQ
       REM            ORIG ANS. IN ACC
       REM            
*TRY TO FLOAT A 2 AND RECOVER ORIG. NUMBER
       REM            
       CLA TWO        L+2
       ORA FPCON+1    L 233.0
       FAD FPCON+1    L 233.0
       CAS FPCON      SHOULD EQUAL 202.4
       TXI *+2        ERROR
       TRA *+6        OK
       REM            
       STQ Q          SAVE MQ
       LDQ FPCON      L 202.4-CORRECT ANS
       TSX ERROR-1,4  ERROR IN FLOATING A2
       TRA BEGFP      
       REM            
       LDQ Q          RESTORE QUOTIENT
       XCA            CHECK MQ FACTOR
       CAS CCH1       L 147.0
       TXI *+2        ERROR
       TRA *+9        OK
       REM            
       LDQ CCH1       L 147.0
       TSX ERROR-1,4  MQ ERROR
       TRA BEGFP      ANSWER IN MQ,ORIG ANSWER
       TRA *+5        IN ACCUMULATOR
       REM            
SECFP  LXA 0,1        TRAP ADDRESS TO XRA
       TXI *+1,1,-1   XRA-1
       TSX ERROR-1,4  TRAP ERROR, ADDRESS
       TRA BEGFP      OF INSTRUCTION
       REM            WHICH CASUSED TRAP
       REM            IS IN XRA
       TRA *+3        CONTINUE
       TRA BEGFP      
       REM            
*SQUARE ROOT-SHOULD NOT TRAP. USED FAD AND FDP
       REM            
       BCD 1FDPFAD    
       REM            
AT2    TSX PART2,4    TURN TRIGS OFF,CLEAR
       NOP            LITE 4 ON
       AXT *+12,1     SET RETURN ADDRESS
       SXA SECT2,1    IN CASE OF TRAP
       CLA FPCON+2    DEC 16+205.4
       TSX SQRT,4     SQ ROOT SUB ROUTINE
       TTR *+5        
       SUB FPCON+3    DEC 4+203.4
       TZE *+10       
       ADD FPCON+3    ERROR, REPLACE ACC
       LDQ FPCON+3    CORRECT ANS IN MQ
       TSX ERROR-1,4  SQUARE ROOT ERROR
       TRA AT2        
       TRA *+5        CONTINUE
       REM            
       LXA 0,1        TRAP ADDRESS TO XRA
       TXI *+1,1,-1   XRA-1
       TSX ERROR-1,4  TRAP ERROR, ADDRESS OF 
       REM            INST. THAT CAUSED TRAP
       REM            IS IN XRA
       REM            
       TRA AT2        REPEAT
       TRA *+3        CONTINUE
       TRA AT2        
       REM            
*THE QUADRATIC FORMULA, 3 PASSES. 2 ANSWERS EACH PASS.
*IN CASE NA ERROR IS DETECTED, THE CORRECT ANS. WILL
*BE PLACED IN MQ, ORIGINAL ANS. REMAINS IN ACC.
       REM            
       BCD 1FPOPS     
       REM            
AT3    TSX PART2,4    LIGHT 4 ON,CLEAR
       CAL AT3+23     SET RETURN ADDRESS
       STA SECT2      IN CASE OF TRAP
       LXD AT3+13,1   21 XRA
       LDQ COEF,1     A
       FMP COEF+2,1   AXC
       ACL SAY        X4
       STO FREE       4AC
       LDQ COEF+1,1   B
       FMP COEF+1,1   B SQUARED
       FSB FREE       -4AC
       CAS COEF+3,1   CHECK RADICAND
       TXI *+2        ERROR
       TXI *+5,0,21   OK
       LDQ COEF+3,1   CORRECT ANS IN MQ
       TSX ERROR-1,4  ERR. IN B SQRD -4AC
       TRA AT3        
       CLA COEF+3,1   GO ON WITH CORRECT RADICAND
       REM            R+SQUARE ROOT OF
       TSX SQRT,4     B SQUARED MINUS 4AC
       TTR *+5        ERROR IN RADICAND
       CAS COEF+4,1   CHECK SQUARE ROOT
       TTR *+2        ERROR
       TXI *+6        OK
       NOP AT3A       
       LDQ COEF+4,1   CORRECT ANS. IN MQ
       TSX ERROR-1,4  ERROR IN SQUARE ROOT
       TRA AT3        
       CLA COEF+4,1   GO ON WITH CORRECT RAD.
       REM            
       DCT            TURN OFF DC TRIG
       NOP            
       STO FREE       
       LDQ COEF,1     A+201.4
       FMP FPCON      2A+202.4
       STO FREE+1     
       CLS COEF+1,1   -B
       FAD FREE       -B+R
       FDP FREE+1     -B+R/2A
       DCT            SHOULD DIVIDE
       TTR *+2        ERROR
       TXI *+4        OK
       LDQ COEF+5,1   CORRECT QUOTIENT
       TSX ERROR-1,4  DCT ERROR ON FDP
       TRA AT3        REPEAT
       REM            
       XCA            
       CAS COEF+5,1   CHECK FIRST ANS.
       TTR *+2        ERROR
       TXI *+4        OK
       LDQ COEF+5,1   CORRECT ANS IN MQ
       TSX ERROR-1,4  FIRST ANS WRONG
       TRA AT3        
       REM            
       CLS COEF+1,1   -B
       FSB FREE       -B-R
       FDP FREE+1     -B-R/2A
       DCT            SHOULD DIVIDE
       TTR *+2        ERROR
       TXI *+4        OK
       LDQ COEF+6,1   CORRECT QUOTIENT
       TSX ERROR-1,4  DCT ERROR ON FDP
       TRA AT3        
       REM            
       XCA            
       CAS COEF+6,1   CHECK SECOND ANS
       TTR *+2        ERROR
       TXI *+4        
       LDQ COEF+6,1   CORRECT ANS IN MQ
       TSX ERROR-1,4  SECOND ANS WRONG
       TRA AT3        
       REM            
       TIX AT3+4,1,7  NEXT PASS
       TRA *+6        FINISHED
       REM            
AT3A   LXA 0,2        TRAP ADDRESS XRB
       TXI *+1,2,-1   XRB-1
       TSX ERROR-1,4  TRAP ERROR-ADDRESS OF
       TRA AT3        INST. THAT CAUSE TRAP
       TRA *-6        IS IN XRB
       REM            
       TSX RDNCK,4    CHECK RDNCY-WRITE TAPE
       NOP RDCKT      
       TRA *+2        
       REM            
       BCD 1IOT       TEST I/O TGR-WRITE PUNCH
       REM            
       IOT            TEST I/O TGR-WR PUNCH
       TRA *+2        ERROR
       TRA *+3        OK-SHOULD BE OFF
       TSX ERROR-1,4  
       TXL *-4,4,0    
       TSX OK,4       
       TRA YUK        
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
       REM            
*  PRINT --           
**   00000  WRITE TAPE AND WRITE PUNCH-SECTION 13 COMPLETE
       REM            
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+12  
       REM            
       CLA RSET       
       STO 0          
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
*WRITE TAPE READ PRINTER DURING MF OPERATION
       REM            
AAH    TSX CTX,4      
       HTR *,,WHOOP   
       REM            
       NZT PRCHA      PRINTER-CHAN A
       TRA *+3        NO
       REM            
       RPRA           
       RCHA SHOOK     
       REM            
       NZT PRCHC      PRINTER-CHAN C
       TRA *+3        NO
       REM            
       RPRC           
       RCHC SHOK      
       REM            
       NZT PRCHE      PRINTER-CHAN E
       TRA *+3        NO
       REM            
       RPRE           
       RCHE SHOK1     
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+3        NO
       REM            
       ETTB           
       REWB           
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+3        NO
       REM            
       ETTD           
       REWD           
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+3        NO
       REM            
       ETTF           
       REWF           
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+3        NO
       REM            
       WTBB           
       RCHB GO        
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+3        NO
       REM            
       WTBD           
       RCHD GO        
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+3        NO
       REM            
       WTBF           
       RCHF GO        
       REM            
       TRA *+3        CONTINUE
       TRA AT3        
       REM            
*REPEAT AT3 WITH INDIRECT ADDRESSING. THE
*SQUARE ROOT SUB-ROUTINE WITH INDIRECT
*ADDRESSING IS USED.  
       REM            
*THE QUADRATIC FORMULA, 3 PASSES, 2 ANSWERS EACH PASS
       REM            
       BCD 1FPOPS     
       REM            
IDA2   TSX PART3,4    LITES 3 AND 4 ON-CLEAR
       CAL IDA2+23    SET RETURN ADDRESS
       STA SECT2      IN CASE OF TRAP
       LXD IDA2+13,1  21 INTO XRA
       LDQ* AT3+4     A
       FMP* AT3+5     AXC
       ACL* AT3+6     X4
       STO* AT3+7     4AC
       LDQ* AT3+8     B
       FMP* AT3+9     B SQUARED
       FSB* AT3+10    -4AC
       CAS* AT3+11    CHECK RADICAND
       TXI *+2        ERROR
       TXI *+5,0,21   OK
       REM            
       LDQ* AT3+14    CORRECT ANS IN MQ
       TSX ERROR-1,4  ERR. IN B SQRD -4AC
       TRA IDA2       
       REM            PLACE CORRECT RADICAND
       CLA* AT3+17    IN ACC AND CONTINUE
       REM            
       TSX SQRI,4     GET R, WHERE R+SQUARE-
       REM            ROOT OF B SQRD-4AC.
       TTR *+5        ERROR, RADICAND SHOULD
       REM            HAVE BEEN PLUS.
       CAS* AT3+20    CHECK SQUARE ROOT
       TTR *+2        ERROR
       TXI *+6        OK
       NOP IDA2+24    
       LDQ* AT3+24    CORRECT ANS TO MQ
       TSX ERROR-1,4  ERROR IN SQUARE ROOT
       TRA IDA2       
       CLA* AT3+27
       REM            
       DCT            TURN OFF DC TRIG.
       NOP            
       STO* AT3+30    
       LDQ* AT3+31    A+201.4
       FMP* AT3+32    2A+202.4
       STO* AT3+33    
       CLS* AT3+34    -B
       FAD* AT3+35    +R
       FDP* AT3+36    /2A
       DCT            SHOULD DIVIDE
       TTR *+2        ERROR
       TXI *+4        OK
       REM            
       LDQ* AT3+40    CORRECT QUOTIENT TO MQ
       TSX ERROR-1,4  DC ON,ERROR
       TRA IDA2       
       REM            
       XCA            
       CAS* AT3+44    CHECK FIRST ANS
       TTR *+2        ERROR
       TXI *+4        OK
       LDQ* AT3+47    CORRECT ANS TO MQ
       TSX ERROR-1,4  FIRST ANS WRONG
       TRA IDA2       
       CLS* AT3+50    -B
       FSB* AT3+51    -R
       FDP* AT3+52    /2A
       DCT            SHOULD DIVIDE
       TTR *+2        ERROR
       TXI *+4        OK
       LDQ* AT3+56    CORRECT QUOTIENT TO MQ
       TSX ERROR-1,4  DC ON-ERROR
       TRA IDA2       
       REM            
       XCA            
       CAS* AT3+60    CHECK SECOND ANS
       TTR *+2        ERROR
       TXI *+4        OK
       LDQ* AT3+63    CORRECT ANS IN MQ
       TSX ERROR-1,4  SECOND ANS WRONG
       TRA IDA2       
       REM            
       TIX IDA2+4,1,7 NEXT PASS
       TRA *+6        
       REM            
IDA2T  LXA 0,2        TRAP ADDRESS TO XRB
       TXI *+1,2,-1   XRB-1
       TSX ERROR-1,4  TRAP ERROR-ADDR OF INST.
       TRA IDA2       THAT CAUSED TRAP IN XRB
       TRA *-6        GO NO TO NEXT PASS
       REM            
       TSX RDNCK,4    TEST RDNCY-TAPE READ
       NOP UGO-2      
       CLA RSET       
       STO 0          
       TRA *+2        CONTINUE
       REM            
       BCD 1IOT       
       REM            
       IOT            
       TRA *+2        ERROR-SHOULD BE OFF
       TRA *+3        OK
       TSX ERROR-1,4  
       TXL *-4,4,0    
       TSX OK,4       
       TRA AAH+2      
       NOP            
       REM            
       NZT TPCHB      TEST FOR TAPE-CHAN B
       TRA *+2        NO
       REM            
OKK    BSRB           
       NZT TPCHD      TEST FOR TAPE-CHAN D
       TRA *+2        NO
       REM            
       BSRD           
       NZT TPCHF      TEST FOR TAPE-CHAN F
       TRA *+2        NO
       REM            
       BSRF           
       REM            
       AXT 256,1      CLEAR
       STZ RDFLD+256,1 READ
       STZ RFCD+256,1 
       STZ RFEF+256,1 
       TIX *-3,1,1    IN AREA
       REM            
*TEST WRITE PRINTER BINARY AND READ TAPE WITH IND 19
       REM            
       NZT PRCHA      TEST FOR PRINTER-CHAN A
       TRA *+4        NO
       REM            
       WPBA           WRITE PRINTER BINARY
       SPRA 3         
       RCHA RCDA+2    S TRG ON-WRD CNT 2
       REM            
       NZT PRCHC      TEST FOR PRINTER-CHAN C
       TRA *+4        NO
       REM            
       WPBC           
       SPRC 3         
       RCHC RCDA+2    S IND ON-WRD CNT 2
       REM            
       NZT PRCHE      TEST FOR PRINTER-CHAN E
       TRA *+4        NO
       REM            
       WPBE           
       SPRE 3         
       RCHE RCDA+2    S IND ON-WRD CNT 2
       REM            
*ABOVE CONTROL WORD SHOULD PRINT ONES ONLY
*THREE LINES AS FOLLOWS
       REM            
*   11111111       1        1       1         1       1         1
* 1         111111111            1111                           1  1
*1111 11111 11111 11111 11111 11111 111111 11111 11111 11111 11111 11111111
       REM            
       NZT TPCHB      TEST FOR TAPE B
       TRA *+4        NO
       REM            
       RTBB           
       RCHB IND19     S AND 1 TRG ON + IND19
       LCHB IND19+1   IND 2 ON-IND ADDR
       REM            
       NZT TPCHD      TEST FOR TAPE D
       TRA *+4        NO
       REM            
       RTBD           
       RCHD ID19      S AND 1 INDS ON + IND19
       LCHD ID19+1    IND 2 ON-IND ADDR
       REM            
       NZT TPCHF      TEST FOR TAPE F
       TRA *+4        NO
       REM            
       RTBF           
       RCHF ID191     S AND 1 INDS ON+IND19
       LCHF ID191+1   IND 2 ON-IND ADDR
       REM            
       TRA *+2        
       REM            THIS SECTION TEST ALL MF 
       BCD 1MF OPS    INSTRUCTIONS PREVIOUSLY
       REM            MISSED.IT IS A RELIABILITY
       REM            TYPE TEST, BROKEN UP BY
       REM            ERR EXITS, IN ORDER TO PIN
       REM            THE ERROR DOWN TO AS FEW
       REM            INSTRUCTIONS AS POSSIBLE
       AXT 128,1      
       AXT SKIP-3,4   ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
WHOOP  CLM            
       CHS            
       SSP            MAKE ACC + ZERO
       STL ADDR1      THIS LOC. +1-IN ADDR 1
       TNZ GOOF       ERRO ACC NOT CLEAR OR TNZ
       STL ADDR1      NOT WORKING
       TMI GOOF       ERROR SSP NOT WORKING
       REM            
       LDQ FIX+2      L 030303030303
       RQL 3          MQ SHBE 303030303030
       STQ SAVE       
       SLQ SAVE1      SHOULD STORE 303030 IN DECR
       STL ADDR1      
       TLQ GOOF       ERROR IN RQL,SLQ OR TLQ
       REM            
       TQP *+3        MQ SHOULD BE PLUS
       STL ADDR1      
       TRA GOOF       ERROR TQP NOT WORKING
       XCL            MQ ZERO-ACC 303030303030
       LBT            
       TRA *+3        OK-NO BIT
       STL ADDR1      
       TRA GOOF       ERROR-HAS BIT-LBT OR XCL
       REM            NOT WORKING
       TIX WHOOP,1,1  REPEAT 200 TIMES
       REM            FOR RELIABILITY
       REM            
       AXT 128,1      
       AXT REP-3,4    ADDRES OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
SKIP   CLA FIX+23     L 303030303030
       STZ SAVE2      CLEAR SAVE2
       NZT SAVE2      TEST FOR ZERO
       ZET SAVE2      
       TRA *+2        ERROR
       TRA *+3        OK
       STL ADDR1      
       TRA GOOF       ERROR-STZ,NZT OR ZET
       REM            NOT WORKING
       STT SAVE2      BUILD UP
       STP SAVE2      WORD IN STORAGE
       STD SAVE2      FROM ACC, USING
       STA SAVE2      STO INSTRUCTIONS
       REM            SAVE2 SH CONTAIN CNTS ACC
       SLT 3          TURN OFF LIGHT 3
       NOP            
       SLT 4          TURN OFF LIGHT 4
       NOP            
       LAS SAVE2      STORAGE SHBE SAME AS ACC
       TRA *+2        ERROR
       TRA *+3        
       STL ADDR1      ERROR-STT,STP,STD,
       TRA GOOF       STA OR LOG COMP NOT WORKING
       REM            
       ADM FIX        L 010101010101
       LAS FIX+24     L 313131313131
       TRA *+2        ERROR
       TRA *+3        
       STL ADDR1      ERROR-ADM NOT WORKING
       TRA GOOF       
       REM            
       SLT 3          TEST LITE 3-SHBE OFF
       TRA *+2        OK
       TRA *+3        ERROR
       SLT 4          TEST LITE 4 SHBE OFF
       TRA *+3        
       STL ADDR1      ERROR-EITHER LITE 3 OR 4
       TRA GOOF       WERE NOT TURNED OFF
       TIX SKIP,1,1   REPEAT 200 TIMES
       REM            
       AXT 128,1      
       AXT REPT-3,4   ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
REP    CLA FIX+24     L 313131313131
       LGR 36         SHIFT
       LLS 35         
       ALS 1          
       ARS 1          
       LAS FIX+24     L 313131313131
       TRA *+2        ERROR
       TRA *+3        OK
       STL ADDR1      
       TRA GOOF       ERROR-LGR,LLS,ALS
       REM            ARS OR LAS DID NOT WORK
       REM            
       PDC 0,4        LOAD XRC 4647
       PAC 0,2        LOAD XRB 4647
       STZ SAVE2      
       SXD SAVE2,4    BUILD UP WORD
       STP SAVE2      IN SAVE2
       SXA SAVE2,2    SAVE2#304647004647-NOW
       CLA CHECK      
       TRA *+2        
CHECK  OCT 304647004647 CORRECT CONSTANT
       CAS SAVE2      SH HOLD SAME INFO AS CHECK
       TRA *+2        ERROR
       TRA *+3        
       STL ADDR1      
       TRA GOOF       ERROR-PDC, OR PAC
       REM            NOT WORKING
       TIX REP,1,1    REPEAT 200 TIMES
       REM            
       AXT 128,1      
       AXT OHOH-3,4   ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
REPT   CLS CHECK      SH BRING IN 704647004647
       STL ADDR1      
       TPL GOOF       ACC SHBE MINUS
       SSP            
       RND            ACC SHOULD NOT CHANGE
       CAS SAVE2      L 304647004647
       TRA *+2        ERROR
       TRA *+3        OK
       STL ADDR1      
       TRA GOOF       ERROR-CLS,SSP, OR RND
       REM            NOT WORKING
       COM            ACC SHBE 4731310773130
       ANS *+4        
       ALS 2          
       ARS 2          
       TRA *+2        
       OCT 77777777777 
       REM            EXCEPT FOR A BIT IN SGN POS
       SBM *-1        
       STL ADDR1      
       TNZ GOOF       ACC SHOULD NOW BE ZERO
       TIX REPT,1,1   REPEAR 200 TIMES
       REM            
       AXT 128,1      
       AXT NICE-3,4   ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
OHOH   CLA ZERO       L +0
       SSM            
       TMI *+3        OK-ACC SHBE-0
       STL ADDR1      
       TRA GOOF       ERROR-SSM NOT WORKING
       REM            
       CLA ONES       L ALL ONES
       PAX 0,4        L 7777
       PDX 0,2        L 7777
       SXD *+2,4      
       TRA *+2        
       OCT 0          
       PXD 0,2        ACC SH HAVE 7777 IN DECR
       SUB *-2        
       STL ADDR1      
       TNZ GOOF       ERROR-PDX,OR PXD NOT WORKNG
       REM            
       PXD 0,4        L 7777
       SUB *-6        
       STL ADDR1      
       TNZ GOOF       ERROR PAX NOT WORKING
       REM            
       AXC 3575,2     L 01011
       PXA 0,2        
       SUB *+2        
       TRA *+2        
SIZE   OCT 1011       
       STL ADDR1       
       TNZ GOOF       ERROR AXC NOT WORKING
       TIX OHOH,1,1   REPEAT 200 TIMES
       REM            
       AXT 128,1      
       AXT CRCTS-12,4 ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
NICE   LDQ FIX+62     L 37777777777
       ALS 2          CLEAR P,Q IN CASE
       ARS 2          OF BITS
       CLA ZERO       L+0
       DVP FIX        L 010101010101
       SUB *+2        
       TRA *+2        
       OCT 4040404040 
       STL ADDR1      
       TNZ GOOF       ERROR-ACC DOES NOT HOLD
       REM            CORRECT REMAINDER
       XCA            
       SUB *+2        
       TRA *+2        
       OCT 37         
       STL ADDR1      ERROR-MQ DID NOT 
       TNZ GOOF       HOLD CORRECT RESULT,DIV.
       REM            
       CLA ZERO       L+0
       LDQ FIX+62     L 377777777777
       MPY FIX+1      L 020202020202
       ADD *+2        
       TRA *+2        
       OCT 020202020201
       STL ADDR1      
       TNZ GOOF       ERROR-HIGH ORDER BITS
       REM            IN ACC NOT CORRECT
       XCA            
       ADD *+2        
       TRA *+2        
       OCT 357575757576
       STL ADDR1      
       TNZ GOOF       ERROR-LOW ORDER BITS
       REM            IN MQ NOT CORRECT
       CLA ZERO       
       LDQ ONES       L 77777777777
       MPR TWO        L+2
       SSP            
       CAS TWO        L+2
       TRA *+2        ERROR
       TRA *+3        OK
       STL ADDR1      ACC SHOULD HOLD 2
       TRA GOOF       ERROR-MPR FAILED TO HAVE 
       XCA            CORRECTS CONTENTS IN ACC
       SSP            
       ADD ONE        L+1
       SSM            
       SUB ONES       L ALL ONES
       STL ADDR1      
       TNZ GOOF       ERROR-MPR FAILED TO HAVE
       REM            CORRECT CONTENTS IN MQ
       TIX NICE,1,1   REPEAT 200 TIMES
       REM            
       AXT 128,2      
       AXT HELP-12,4  ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
       CLA 1ST        L+010304051011
       ADD 2ND        L+061101051103
       CVR TABLE-12,1,6 ACC SH HOLD 202020202020
       SUB FIX+15     L 202020202020
       STL ADDR1      
       TNZ GOOF       CVR INST. NOT WORKING
       REM            
       PXA 0,1        
       SUB *+2        
       TRA *+2        
CRCTS  HTR TABLE-2    
       STL ADDR1      ERROR-XRA DID NOT
       TNZ GOOF       CONTAIN ADDR-TABLES+5
       REM            
       CLA 1ST        L+010304051011
       ADD 2ND L+061101051103
       XCA            
       CRQ TBLE1-7,1,6 MQ SH HOLD 202020202020
       XCA            
       SUB *+4        L 000005070070
       STL ADDR1      
       TNZ GOOF       CRQ INST. NOT WORKING
       TRA *+2        
       OCT 202020202020
       REM            
       PXA 0,1        
       SUB *+4        
       STL ADDR1      ERROR-XRA DID NOT
       TNZ GOOF       CONTAIN ADDR-TABLE+5
       TRA *+2        
CRCT1  HTR TABLE-6    
       REM            
       PXD            
       LDQ K16        L 010203040506
       CAQ K16,1,6    CONVERT FULL WORD
       SLW SAVE       SAVE ACC
       ARS 1          SHIFT Q TO P
       PBT            
       TRA *+2        
       TRA *+3        YES-P BIT-OK
       STL ADDR1      ERROR HERE INDICATES
       TRA GOOF       NO Q BIT
       REM            
       CLA SAVE       BRING BACK TO ACC
       SUB *+4        
       STL ADDR1      
       TNZ GOOF       ERROR WRONG ANSWER IN
       REM            ACCUMULATOR
       TRA *+2        
       TNX 6*K16,5,20480
       REM            
       XCA            
       SUB K16        
       STL ADDR1      
       TNZ GOOF       ERROR MQ NOT CORRECT
       REM            
       PXA 0,1        
       SUB *+4        CORRECT CNTS XRA
       STL ADDR1      
       TNZ GOOF       ERROR-XRA DID NOT HOLD
       REM            CORRECT INFO
       TRA *+2        
       HTR K16        CORRECT CONTENTS XRA
       TIX CRCTS-9,2,1 REPEAT 200 TIMES
       REM            
       TSX ECHOS,2    OUT TO FROM ECHO IMAGE
       TSX ECHCS,2    
       TSX ECHES,2    
       AXT 0,2        
       LXA TWTWO,1    L+22
       PXA 0,1        
       ADD ONE        L+1
       STA WDNO       SET WDNO CONSTANT
       CLA ONE        L+1
       STA RECNO      SET REC NO CONSTANT
       REM            
*COMPARISON-FOR READ PRINTER-WRITE TAPE AND
*READ PRINTER SECTION 
       REM            
       REM            
       NZT PRCHA      TEST FOR PRINTER A
       TRA *+9        
       REM            
HELP   CLA ECHO+18,1  WORD READ
       LDQ WRIT2+18,1 WORD WRITTEN
       CAS WRIT2+18,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP PREA     
       TIX HELP,1,1   
       REM            
       NZT PRCHC      TEST FOR PRINTER C
       TRA *+10       
       REM            
       AXT 18,1       
       CLA ECHOC+18,1 WORD READ
       LDQ WRIT2+18,1 WORD WRITTEN
       CAS WRIT2+18,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP PREC     
       TIX *-7,1,1    
       REM            
       NZT PRCHE      TEST FOR PRINTER E
       TRA *+10       
       REM            
       AXT 18,1       
       CLA ECHOE+18,1 WORD READ
       LDQ WRIT2+18,1 WORD WRITTEN
       CAS WRIT2+18,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP PREE     
       TIX *-7,1,1    
       TSX OK,4       
       TRA OKK-2      
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000   WRITE TAPE AND READ PRINTER-SECTION 14 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+13  
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
*COMPARISON FOR READ TAPE-WRITE PRINTER
*BINARY AND READ TAPE SECTION
       REM            
       REM            
       AXT 0,1        L +0
       AXT 7,2        L +7
       CLA ONE        L +1
       STO WDNO       SET WDNO CONST
       PXA 0,2        WORD COUNT
       ADD ONE        L +1
       STO RECNO      SET RECNO CONST
       TRA *+2        
       REM            
       BCD 1IND 19    
       REM            
       NZT TPCHB      TEST FOR TAPE-CHAN B
       TRA *+8        
       REM            
FUN    CLA RDFLD      WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WITH
       NOP TP19B+1    IND 19 ON AND S AND 2
       REM            INDS ON
       REM            
       NZT TPCHD      TEST FOR TAPE-CHAN D
       TRA *+8        NO
       REM            
       CLA RFCD       WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19D+1    
       REM            
       NZT TPCHF      TEST FOR TAPE-CHAN F
       TRA *+8        NO
       REM            
       CLA RFEF       WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19F+1    
       TIX *+1,2,1    DECR REC NO
       REM            
       AXT 42,1       L 52
       PXA 0,1        
       ADD ONE        L +1
       STO WDNO       SET WDNO CONSTANT
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+9        NO
       REM            
       CLA RDFLD+43,1 WORD READ
       LDQ WRFLD+43,1 CORRECT WORD
       CAS WRFLD+43,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WITH S
       NOP TP19B+1    TGR ON-AFTER TCH+IND 19
       TIX *-7,1,1    RETURN TO CHECK ALL WORDS
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+10       NO
       REM            
       AXT 42,1       
       CLA RFCD+43,1  WORD READ
       LDQ WRFLD+43,1 CORRECT WORD
       CAS WRFLD+43,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19D+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+10       NO
       REM            
       AXT 42,1       
       CLA RFEF+43,1  WORD READ
       LDQ WRFLD+43,1 CORRECT WORD
       CAS WRFLD+43,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19F+1    
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+10       NO
       REM            
       AXT 42,1       L 52
       CLA RDFLD+85,1 WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WITH
       NOP TP19B+1    S IND AND IND 19 ON
       TIX *-7,1,1    RETURN TO CHECK ALL WORDS
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+10       NO
       REM            
       AXT 42,1       
       CLA RFCD+85,1  WORD READ
       LDQ ZERO       
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19D+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+10       NO
       REM            
       AXT 42,1       
       CLA RFEF+85,1  WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19F+1    
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+10       NO
       REM            
       AXT 42,1       
       CLA RDFLD+127,1 WORD READ
       LDQ WRFLD+127,1 CORRECT WORD
       CAS WRFLD+127,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WITH
       NOP TP19B+1    INDS S AND 1 ON
       TIX *-7,1,1    RETURN TO CHECK ALL WORDS
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+10       NO
       REM            
       AXT 42,1       
       CLA RFCD+127,1 WORD READ
       LDQ WRFLD+127,1 CORRECT WORD
       CAS WRFLD+127,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19D+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+10       NO
       REM            
       AXT 42,1       
       CLA RFEF+127,1 WORD READ
       LDQ WRFLD+127,1 CORRECT WORD
       CAS WRFLD+127,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19F+1    
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+10       NO
       REM
       AXT 42,1       L 52
       CLA RDFLD+169,1 WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WITH
       NOP TP19B+1    INDS S AND 1 ON+IND 19
       TIX *-7,1,1    RETURN TO CHECK ALL WORDS
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+10       NO
       REM
       AXT 42,1      
       CLA RFCD+169,1 WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WITH
       NOP TP19D+1    
       TIX *-7,1,1   
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+10       NO
       REM
       AXT 42,1      
       CLA RFEF+169,1 WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WITH
       NOP TP19F+1    
       TIX *-7,1,1   
       TIX *+1,2,1    DECREMENT RECORD NO
       REM
       NZT TPCHB      TAPE-CHAN B
       TRA *+10       NO
       REM            
       AXT 42,1       L 52
       CLA RDFLD+211,1 WORD READ
       LDQ WRFLD+211,1 CORRECT WORD
       CAS WRFLD+211,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19B+1    
       TIX *-7,1,1    
       REM
       NZT TPCHD      TAPE-CHAN D
       TRA *+10       NO
       REM            
       AXT 42,1       
       CLA RFCD+211,1 WORD READ
       LDQ WRFLD+211,1 CORRECT WORD
       CAS WRFLD+211,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19D+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+10       NO
       REM            
       AXT 42,1       
       CLA RFEF+211,1 WORD READ
       LDQ WRFLD+211,1 CORRECT WORD
       CAS WRFLD+211,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19F+1    
       TIX *-7,1,1    
       TIX *+1,1,1    DECREMENT RECORD NO
       REM            
       AXT 45,1       L 55
       PXA 0,1        
       ADD ONE        
       STA WDNO       
       NZT TPCHB      TEST FOR TAPE CHAN B
       TRA *+9        NO
       REM            
       CLA RDFLD+256,1 WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WITH
       NOP TP19B+1    NO INDS ON+IND 19
       TIX *-7,1,1    REUTRN TO CHECK ALL WORDS
       REM            
       NZT TPCHD      TEST FOR TAPE CHAN D
       TRA *+10       NO
       REM            
       AXT 45,1       
       CLA RFCD+256,1 WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19D+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHF      TEST FOR TAPE CHAN F
       TRA *+10       NO
       REM            
       AXT 45,1       
       CLA RFEF+256,1 WORD READ
       LDQ ZERO       CORRECT WORD
       CAS ZERO       
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP TP19F+1    
       TIX *-7,1,1    
       REM            
       TSX RDNCK,4    TEST REDUNDANCY-
       NOP FUN-2      READ TAPE WITH IND 19
       TRA *+2        
       REM            
       BCD 1IOT       
       REM            
       IOT            TEST I/O TGR
       TRA *+2        ERROR-SH BE OFF
       TRA *+3        
       TSX ERROR-1,4  
       TXL *-4,4,0    
       TSX OK,4       
       TRA FUN-11     
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000   WRITE PR BINARY AND READ TAPE-IND 19-SECTION 15 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+14  
       REM            
       TSX CTX,4      
       HTR *,0,NOISE  
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
*READ TAPE-ALL CHANNELS
       REM            
       REM            
       NZT TPCHA      TAPE-CHAN A
       TRA *+3        NO
       REM            
OOK    BSRA           
       BSRA           PREPARE TO READ
       NZT TPCHB      TAPE-CHAN B 
       TRA *+2        NO
       REM            
       BSRB           
       REM            
       NZT TPCHC      TAPE-CHAN C
       TRA *+3        NO
       REM            
       BSRC           
       BSRC           
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+2        NO
       REM            
       BSRD           
       NZT TPCHE      TAPE-CHAN E
       TRA *+3        NO
       REM            
       BSRE           
       BSRE           
       NZT TPCHF      TAPE-CHAN F
       TRA *+2        
       REM            
       BSRF           
       REM            
       NZT TPCHA      TAPE-CHAN A
       TRA *+3        NO
       REM            
       RTBA           READ 2-40 WORD REC
       RCHA SRD1      
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+3        NO
       REM            
       RTBB           READ 1-300 WORD REC
       RCHB SRD       
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+3        NO
       REM            
       RTBD           
       RCHD SRD2      READ 1-300 WORD REC
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+3        NO
       REM            
       RTBF           
       RCHF SRD3      READ 1-300 WORD REC.
       REM            
       NZT TPCHC      TAPE-CHAN C
       TRA *+3        NO
       REM            
       RTBC           
       RCHC SRD4      READ 2-40 WORD REC
       REM            
       NZT TPCHE      TAPE-CHAN E
       TRA *+3        NO
       REM            
       RTBE           
       RCHE SRD5      READ 2-40 WORD REC
       REM            
       TRA *+2        
       BCD 1MF IA     MF OPS IND ADDR-
       REM            SAME AS PREVIOUS MF
       REM            EXCEPT INSTRUCTIONS
       REM            ARE IND ADDR
       REM            
       AXT 128,1      
       AXT SOUND-3,4  ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
NOISE  CLM            
       CHS            
       SSP            MAKE ACC +ZERO
       STL* WHOOP+3   THIS LOC+1-IN ADDR1
       TNZ* WHOOP+4   ERROR ACC NOT CLEAR OR TNZ
       REM            IND ADDR NOT WORKING
       STL* WHOOP+3   SSP OR TMI IND
       TMI* WHOOP+4   ADDR NOT WORKING
       REM            
       LDQ* WHOOP+7   EFF ADDR FIX+2
       RQL 3          MQ SHBE 303030303030
       STQ* WHOOP+9   
       SLQ* WHOOP+10  DECR 303030 IN DECR SAVE1
       STL* WHOOP+3   
       TLQ* WHOOP+4   ERROR IN RQL-OR SLQ OR TLQ
       REM            IND ADDR
       TQP* SRD1+1    
       STL* WHOOP+3   ERROR TQP IND ADDR
       TRA* WHOOP+4   NOT WORKING 
       XCL            MQ ZERO-ACC 30303030303030
       LBT            
       TRA *+3        OK-NO BIT
       STL* WHOOP+3   ERROR-HAS BIT-LBTOR
       TRA* WHOOP+4   XCL NOT WORKING
       REM            
       TIX NOISE,1,1  REPEAT 200 TIMES
       REM            
       AXT 128,1      
       AXT BAY-3,4    ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            
       REM            IF ERROR
SOUND  CAL* SKIP      
       STZ* SKIP+1    CLEAR SAVE2
       NZT* SKIP+2    TEST FOR ZERO
       ZET* SKIP+3    
       TRA *+2        ERROR
       TRA *+3        OK
       STL* WHOOP+3   ERROR-STZ,NZT OR ZET
       TRA* WHOOP+4   IND ADDR NOT WORKING
       REM            
       STT* SKIP+8    BUILD UP
       STP* SKIP+9    WORD IN STORAGE
       STD* SKIP+10   FROM ACC, USING
       STA* SKIP+11   STO INSTRUCTIONS
       REM            SAVE2 SH CONTAIN CNTS ACC
       SLT 3          TURN OFF LIGHT 3
       NOP            
       SLT 4          TURN OFF LIGHT 4
       NOP            
       LAS* SKIP+16   STORAGE SHBE SAME AS ACC
       TRA *+2        ERROR
       TRA *+3        
       STL* WHOOP+3   ERROR-STT,STP,STD,STA
       TRA* WHOOP+4   OR LOG COMP,IND ADDR
       REM            NOT WORKING
       REM            
       ADM* SKIP+21   L010101010101
       LAS* SKIP+22   L313131313131
       TRA *+2        ERROR
       TRA *+3        OK
       STL* WHOOP+3   ERROR-ADM,IND ADDR
       TRA* WHOOP+4   NOT WORKING
       REM            
       SLT 3          TEST LITE 3-SHBE OFF
       TRA *+2        OK
       TRA *+3        ERROR-LITE 3 NOT TURNED OFF
       SLT 4          TEST LITE 4-SHBE OFF
       TRA *+3        OK
       STL* WHOOP+3   ERROR-EITHER LITE 3 OR 4
       TRA* WHOOP+4   WERE NOT TURNED OFF
       TIX SOUND,1,1  REPEAT 200 TIMES
       REM            
       AXT 128,1      
       AXT COVE-3,4   ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
BAY    CAL* REP       
       LGR 36         SHIFT
       LLS 35         
       ALS 1          
       ARS 1          
       LAS* REP+5     L313131313131
       TRA *+2        ERROR
       TRA *+3        OK
       STL* WHOOP+3   ERROR-LGT,LLS,ALS,ARS
       TRA* WHOOP+4   OR LAS,IND ADDR
       REM            
       REM            NOT WORKING
       PDC 0,4        LOAD XRC 4647
       PAC 0,2        LOAD XRB 4647
       STZ* REP+12    
       SXD SAVE2,4    BIULD UP WORD
       STP* REP+14    IN SAVE 2
       SXA SAVE2,2    SAVE 2#304647004647-NOW
       CLA* CHECK-2   
       CAS* CHECK+1   SH HOLD SAME INFO AS CHECK
       TRA *+2        ERROR
       TRA *+3        OK
       STL* WHOOP+3   ERROR-PDC, OR PAX
       TRA* WHOOP+4   NOT WORKING
       REM            
       TIX BAY,1,1    REPEAT 200 TIMES
       REM            
       AXT 128,1      
       AXT INLET-3,4  ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
COVE   CLS* REPT      SH BRING IN 704647004647
       STL* WHOOP+3   
       TPL* WHOOP+4   ACC SHBE MINUS
       SSP            
       RND            ACC SHOULD NOT CHANGE
       CAS* REPT+5    
       TRA *+2        ERROR
       TRA *+3        OK
       STL* WHOOP+3   
       TRA* WHOOP+4   ERROR-SSP,RND OR
       REM            CLS IND ADDR NOT WORKING
       COM            ACC SHBD 473130773130
       ANS* REPT+11   CONST LOC AT 0H 0H-6
       ALS 2          
       ARS 2          
       SBM* OHOH-7    
       STL* WHOOP+3   ERROR-SBM,ANS IND ADDR
       TNZ* WHOOP+4   NOT WORKING-ACC SHBE ZERO
       TIX COVE,1,1   REPEAT 200 TIMES
       REM            
       AXT 128,1      
       AXT FIORD-3,4  ADDRESS OF NEXT SECTION
       SXA ADDR2,4    SAVE ADDRESS FOR RETURN
       REM            IF ERROR
INLET  CLA* OHOH      L+0
       SSM            
       TMI *+3        OK-ACC SHBE 0
       STL* WHOOP+3   
       TRA* WHOOP+4   ERROR-SSM NOT WORKING
       REM            
       CLA* OHOH+5    L ALL ONES
       PAX 0,4        L7777
       PDX 0,2        L 7777
       SXD OHOH+10,4  
       PXD 0,2        ACC SH HAVE 7777 IN DECR
       SUB* OHOH+12   
       STL* WHOOP+3   ERROR-PDX,PXD, OR CLA,
       TNZ* WHOOP+4   SUB IND ADDR NOT WORKING
       REM            
       PXD 0,4        L7777
       SUB* OHOH+12   
       STL* WHOOP+3   
       TNZ* WHOOP+4   ERROR-PAX NOT WORKING
       REM            
       AXC 3575,2     L 01011
       PXA 0,2        
       SUB* SIZE-2    
       STL* WHOOP+3   ERROR-AXC OR
       TNZ* WHOOP+4   SUB IND ADDR NOT WORKING
       TIX INLET,1,1  REPEAT 200 TIMES
       REM            
       AXT 128,1      
       AXT RCWTP-5,4  
       SXA ADDR2,4    
FIORD  LDQ* NICE      L 377777777777
       ALS 2          CLEAR P,Q IN CASE
       ARS 2          OF BITES
       CLA* NICE+3    L+0
       DVP* NICE+4    L 010101010101
       SUB* NICE+5    
       STL* WHOOP+3   
       TNZ* WHOOP+4   ERROR-ACC DOES NOT HOLD
       REM            CORRECT REMAINDER
       XCA            
       SUB* NICE+11   
       STL* WHOOP+3   ERROR-MQ DID NOT HOLD
       TNZ* WHOOP+4   CORRECT RESULT,DIV.
       REM            
       CLA* NICE+16   L+0
       LDQ* NICE+17   L 377777777777
       MPY* NICE+18   L 020202020202
       ADD* NICE+19   
       STL* WHOOP+3   ERROR-HIGH ORDER BITS
       TNZ* WHOOP+4   IN ACC NOT CORRECT
       REM            
       XCA            
       ADD* NICE+25   
       STL* WHOOP+3   ERROR-LOW ORDER BITS
       TNZ* WHOOP+3   IN MQ NOT CORRECT
       REM            
       CLA* NICE+30   
       LDQ* NICE+31   L 7777777777777
       MPR* NICE+32   L+2
       SSP            
       CAS* NICE+34   L+2
       TRA *+2        ERROR
       TRA *+3        OK
       STL* WHOOP+3   ERROR-ACC SH HOLD 2
       TRA* WHOOP+4   MPR-FAILED TO LEAVE CORRECT 
       REM            CONTENTS IN ACC
       XCA            
       SSP            
       ADD* CRCTS-18  L +1-MQ SH HOLD 77777777776
       SSM            
       SUB* CRCTS-16 L ALL ONES
       STL* WHOOP+3   ERROR-MPR FAILED TO HAVE
       TNZ* WHOOP+4   CORRECT CONTENTS IN MQ
       TIX FIORD,1,1  REPEAT 200 TIMES
       TSX OK,4       
       TRA OOK-2      
       NOP            
       REM            
       REM            
*    READ CARDS AND WRITE TAPE
       REM            
       REM            
       TSX CTX,4      
       HTR *,0,DBLR   
       REM            
       NZT COUNT      SKIP CARD
       TRA *+2        READER AFTER
       TRA *+13       FIRST PASS
       REM            
RCWTP  NZT CRCHA      TEST FOR CR-CHAN A
       TRA *+3        NO
       REM            
       RCDA           
       RCHA RCWT      READ ONE CARD WITH
       REM            SEVERAL TRG SETTINGS
       REM            
       NZT CRCHC      TEST FOR CR-CHAN C
       TRA *+3        NO
       REM            
       RCDC           
       RCHC RCWT1     READ ONE CARD-SEVERAL
       REM            INDICATOR SETTINGS
       REM            
       NZT CRCHE      TEST FOR CR-CHAN E
       TRA *+3        NO
       REM            
       RCDE           
       RCHE RCWT2     READ ONE CARD-SEVERAL
       REM            INDICATOR SETTINGS
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+3        NO
       REM            
       WTBB           
       RCHB WTB1      WRITE 6 RECS
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+3        NO
       REM            
       WTBD           
       RCHD WTB1      WRITE 6 RECS
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+3        NO
       REM            
       WTBF           
       RCHF WTB1      WRITE 6 RECS
       REM            
       REM            
*COMPARISON-READ TAPE ALL CHANNELS
       REM            
       REM            
DBLR   AXT 192,1      L +300
       PXA 0,1        
       ADD ONE        
       STO WDNO       SET WDNO CONSTANT
       AXT 0,2        
       CLA ONE        
       STO RECNO      SET RECNO CONSTANT
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+9        NO
       REM            
       CLA RDFLD+192,1 WORD READ
       LDQ WRFLD+192,1 CORRECT WORD
       CAS WRFLD+192,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WHILE
       NOP BCDTB+1    READING ALL CHANNELS
       TIX DBLR+7,1,1 RETURN TO CHECK ALL WORDS
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+10       NO
       REM            
       AXT 192,1      
       CLA RFCD+192,1 WORD READ
       LDQ WRFLD+192,1 CORRECT WORD
       CAS WRFLD+192,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+10       NO
       REM            
       AXT 192,1      
       CLA RFEF+192,1 WORD READ
       LDQ WRFLD+192,1 CORRECT WORD
       CAS WRFLD+192,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    
       REM            
DBLR1  AXT 2,2        
       AXT 32,1       
       PXA 0,2        
       ADD ONE        
       STO RECNO      SET RECORD NO. CONSTANT
       PXA 0,1        
       ADD ONE        
       STO WDNO       SET WORD NO. CONSTANT
       NZT TPCHA      TAPE-CHAN A
       TRA *+9        NO
       REM            
       CLA RDFLD+224,1 WORD READ
       LDQ WRFLD+224,1 CORRECT WORD
       CAS WRFLD+224,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WHILE
       NOP BCDTA+1    READING ALL CHANNELS
       REM            SIMILTANEOUSLY
       TIX *-7,1,1    RETURN TO CHECK ALL 
       REM            WORDS IN RECORD
       REM            
       NZT TPCHC      TAPE CHAN C
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFCD+224,1 WORD READ
       LDQ WRFLD+224,1 CORRECT WORD
       CAS WRFLD+224,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTC+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHE      TAPE-CHAN E
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFEF+224,1 WORD READ
       LDQ WRFLD+224,1 CORRECT WORD
       CAS WRFLD+224,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTE+1    
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO.
       REM            
       NZT TPCHA      TAPE-CHAN A
       TRA *+10       NO
       AXT 32,1       
       CLA RDFLD+256,1 WORD READ
       LDQ WRFLD+256,1 CORRECT WORD
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WHILE
       NOP BCDTA+1    READING ALL CHANNELS
       REM            SIMILTANEOUSLY
       TIX *-7,1,1    
       REM            
       NZT TPCHC      TAPE-CHAN C
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFCD+256,1 WORD READ
       LDQ WRFLD+256,1 CORRECT WORD
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTC+1    
       TIX *+-7,1,1   
       REM            
       NZT TPCHE      TAPE-CHAN E
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFEF+256,1 WORD READ
       LDQ WRFLD+256,1 CORRECT WORD
       CAS WRFLD+256,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTE+1    
       TIX *-7,1,1    
       REM            
       TSX RDNCK,4    
       NOP RDCKT      
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000   READ TAPE CONCURRENTLY-SECTION 16 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+15  
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
*COMPARISON FOR READ CARDS AND WRITE TAPE SECTION
       REM            
       REM            
       NZT COUNT      SKIP CARD
       TRA *+2        READER AFTER
       TRA YUP-8      FIRST PASS
       REM            
TOO    AXT 24,1       
       AXT 3,2        
       PXA 0,1        
       ADD ONE        
       STO WDNO       SET WDNO CONSTANT
       PXA 0,2        
       ADD ONE        
       STO RECNO      SET RECNO CONSTANT
       REM            
       NZT CRCHA      CR-CHAN A
       TRA *+9        NO
       REM            
       CLA RDINA+24,1 WORD READ
       LDQ IRAN+24,1  CORRECT WORD
       CAS IRAN+24,1  
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP CRCA+1     READING CARDS
       TIX *-7,1,1    RETURN TO CHECK ALL WORDS
       REM            
       NZT CRCHC      CR-CHAN C
       TRA *+10       NO
       REM            
       AXT 24,1       
       CLA RDNA+24,1  WORD READ
       LDQ IRAN+24,1  CORRECT WORD
       CAS IRAN+24,1  
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP CRCC+1     READING CARDS 
       TIX *-7,1,1    
       REM            
       NZT CRCHE      CR-CHAN E
       TRA *+10       NO
       REM            
       AXT 24,1       
       CLA RDNA1+24,1 WORD READ
       LDQ IRAN+24,1  CORRECT WORD
       CAS IRAN+24,1  
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP CRCE+1     READING CARDS
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO.
       REM            
       TSX OK,4       
       TRA RCWTP-3    
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
       REM            
*  PRINT --           
**   00000  READ CARDS AND WRITE TAPE-SECTION 17 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+16  
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
*    READ TAPE AND READ CARDS
       REM            
       REM            
       TSX CTX,4 
       HTR *,0,YUP+25
       REM            
YUP    NZT TPCHB      TAPE-CHAN B
       TRA *+2        NO
       REM
       BSRB           BACKSPACE OVER ONE
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+2        NO
       REM            
       BSRD           
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+2        NO
       REM            
       BSRF           
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+3        NO
       REM            
       RTBB           40 WORD RECORD
       RCHB RCRT      
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+3        NO
       REM            
       RTBD           
       RCHD RCRT1     READ ONE-40 WORD REC
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+3        NO
       REM            
       RTBF           
       RCHF RCRT2     READ ONE 40 WORD REC
       REM            
       NZT COUNT      SKIP CARD
       TRA *+2        READER AFTER
       TRA *+13       FIRST PASS
       REM            
       NZT CRCHA      CR-CHAN A
       TRA *+3        NO
       REM            
       RCDA           
       RCHA RCWT      READ ONE CARD
       REM            
       NZT CRCHC      CR-CHAR C
       TRA *+3        
       REM            
       RCDC           
       RCHC RCWT1     READ ONE CARD
       REM            
       NZT CRCHE      CR-CHAN E
       TRA *+3        NO
       REM            
       RCDE           
       RCHE RCWT2     READ ONE CARD
       REM            
       TRA *+2        
       REM            
       BCD 1MFIAIZ    
       REM            
       SXD SAVE,2     
       AXT 128,4      
H1     AXT 5,1        5 INTO XRA
       AXT 8,2        10 INTO XRB
       CLA* K1+5,1    L -210440000000-COEF-5
       SUB* K1+8,2    L -210440000000-COEF-5
       TZE *+3        OK
       TSX ERROR-1,4  ERROR IN CLA OR SUB
       NOP H1-2       IND. ADDR. AND INDEXED
       REM            
       AXT 4,2        
       TRA* *+8,2     
       TSX ERROR-1,4  FAILED TO TRANSFER
        NOP H1-2      
       TRA H3         
       NOP H3         
       TSX ERROR-1,4  FAILED TO IND. ADDR
        NOP H1-2      
       TRA H3         
       TSX ERROR-1,4  FAILED TO INDEX OR IND ADDR
        NOP H1-2      
       REM            
H3     AXT 4,2        4 INTO XRA
       CLS* K1+5,2    L +2014000000000-FPCON+4
       ADD* K1+5,2    L +2014000000000-FPCON+4
       TZE* *+8,2     
       TSX ERROR-1,4  FAILED TO TRANSFER
        NOP H1-2      
       TRA H4         
       NOP H4         TO HERE-CORRECT
       TSX ERROR-1,4  FAILED TO IND. ADDR
        NOP H1-2      
       TRA H4         
       TSX ERROR-1,4  FAILED TO INDEX
        NOP H1-2      
       REM            
H4     AXT 4,2        
       CLA* K1+5,2    L +201400000000-FPCON+4
       TPL* *+8,2     
       TSX ERROR-1,4  FAILED TO TRANSFER
        NOP H1-2      
       TRA H5         
       NOP H5         SHOULD TRA TO HERE
       TSX ERROR-1,4  FAILED TO IND. ADDR.
        NOP H1-2      
       TRA H5         
       TSX ERROR-1,4  FAILED TO INDEX OR IND ADDR
        NOP H1-2      
H5     TIX H1,4,1     REPEAT 100 TIMES FOR
       REM            RELIABILITY
       TSX RDNCK,4    
       NOP UGO-2      
       REM            
       REM            
*COMPARISON FOR READ TAPE AND READ CARDS SECTION
       REM            
       REM            
       NZT COUNT      SKIP CARD
       TRA *+2        READER AFTER
       TRA RCDTP-17   FIRST PASS
       REM            
       LXD SAVE,2     RESTORE XRB
       NZT CRCHA      CR-CHAN A
       TRA *+10       NO
       REM            
       AXT 24,1       
       CLA RDINA+24,1 WORD READ --- COMPARE
       LDQ RDINC+24,1 CORRECT WORD -- 2ND CARD
       CAS RDINC+24,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WHILE
       NOP CRCA+1     READING CARDS
       TIX *-7,1,1    CHECK ALL WORDS
       REM            
       NZT CRCHC      CR-CHAN C
       TRA *+10       NO
       REM            
       AXT 24,1       
       CLA RDNA+24,1  WORD READ
       LDQ RDINC+24,1 CORRECT WORD
       CAS RDINC+24,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP CRCC+1     READING CARDS
       TIX *-7,1,1    
       REM             
       NZT CRCHE      CR-CHAN E
       TRA *+10       NO
       REM            
       AXT 24,1       
       CLA RDNA1+24,1 WORD READ
       LDQ RDINC+24,1 CORRECT WORD
       CAS RDINC+24,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP CRCE+1     READING CARDS
       TIX *-7,1,1    
       TIX *+1,2,1    DECREMENT RECORD NO
       TSX OK,4       
       TRA YUP        
       NOP            
       SXD SAVE,2     
       REM            
       REM            
*READ CARDS AND WRITE TAPE
       REM            
       REM            
       TSX CTX,4      
       HTR RCDTP,0,RCDTP+20
       REM            
       NZT COUNT      SKIP CARD
       TRA *+2        READER AFTER
       TRA RCDTP+4    FIRST PASS
       REM            
       NZT CRCHA      CR-CHAN A
       TRA *+3        NO
       REM            
       RCDA           
       RCHA RCWT      CONTROL TO READ THIRD CARD
       REM            
       NZT CRCHC      CR-CHAN C
       TRA *+3        NO
       REM            
       RCDC           
       RCHC RCWT1     
       REM            
RCDTP  NZT CRCHE      CR-CHAN E
       TRA *+3        NO
       REM            
       RCDE           
       RCHE RCWT2     
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+3        NO
       WTBB           
       RCHB WTB1      
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+3        NO
       REM            
       WTBD           
       RCHD WTB1      
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+3        NO
       REM            
       WTBF           
       RCHF WTB1      
       TRA *+2        
       REM            
       REM            
       REM            EXECUTE INSTRUCTION TEST
       REM            
       BCD 1XEC       TEST EXECUTE CAUSES 709
       REM            
       REM            TO TAKE NEXT INSTR FROM
       REM            EXECUTE ADR, PERFORM THAT
       REM            INSTR AND RETURN TO EXE-
       REM            CUTE INSTRUCTION PLUS 1
EX     CLA ZERO       CLEAR ACC
       XEC *+2        
       TRA *+4        
       CLA MINUS      L -0
       TSX ERROR-1,4  FAILED TO RETURN TO 
       REM            EXECUTE INSTR PLUS 1
       REM            
       TXL EX         
       REM            
       REM TEST FOR MINUS SIGN IN ACC
       REM            
       TMI *+3        OK-ACC SIGN MINUS
       TSX ERROR-1,4  ERROR-ACC SIGN PLUS
       TRA EX         
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE TO TRANSFER 
       REM            DOES NOT RETURN TO
       REM            EXECUTE PLUS 1
EXA    XEC *+3        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TRA
       REM            INSTR AND PROCEED
       REM            
       TXL EXA        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXI
       REM            
EXB    AXT 6,1        L 6 IN XRA
       XEC *+4        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TXI
       TXL EXB        INSTRUCTION AND PROCEED
       TRA EXC        GO TO NEXT TEST IF ERROR
       REM            
       TXI *+1,1,1    
       PXA 0,1        XRA TO ADR OF ACC
       LDQ SEVEN      L +7 TO MQ
       CAS SEVEN      
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  
       TRA EXB        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXL
       REM            WITH XR LOW
       REM            
EXC    AXT 0,1        CLEAR XRA
       XEC *+4        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TXL
       TXL EXC        INSTRUCTIION AND PROCEED
       TRA EXD        
       TXL *+3,1,1    SHOULD TRANSFER
       TSX ERROR-1,4  ERROR-DID NOT TRANSFER
       TRA EXC        
       REM            
EXD    XEC *+4        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TXL
       TXL EXC        INSTRUCTION AND PROCEED
       TRA EXF        GO TO NEXT TEST IF ERROR
       REM            
       TXL *+3,1,0    SHOULD TRANSFER
       TSX ERROR-1,4  ERROR-DID NOT TRANSFER
       TRA EXC        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXL
       REM            WITH XR HIGH
       REM            
EXF    CLA ZERO       CLEAR ACC
       AXT 1,1        L 1 IN XRA
       XEC *+3        
       CLA MINUS      L-0
       TRA *+4        
       TXL *+1,1,0    SHOULD NOT TRANSFER,GO
       REM            BACK TO EXECUTE PLUS 1
       TSX ERROR-1,4  FAILED TO RETURN TO
       TXL EXF        EXECUTE INSTR PLUS 1
       REM            
       TMI *+3        SHOULD TRANSFER
       TSX ERROR,4    ERROR-ACC PLUS
       TRA EXF        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXH
       REM            WITH XR HIGH
       REM            
EXG    AXT 1,1        L 1 IN XRA
       XEC *+4        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TXH
       TXL EXG        INSTRUCTION AND PROCEED
       TRA EXH        GO TO NEXT TEST IF ERROR
       REM            
       TXH *+3,1,0    SHOULD TRANSFER
       TSX ERROR-1,4  
       TRA EXG        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE WITH TXH
       REM            WITH XR LOW
       REM            
EXH    AXT 0,1        CLEAR XRA
       CLA ZERO       CLEAR ACC
       XEC *+3        
       CLA MINUS      L -0
       TRA *+4        
       REM
       REM
       TXH *+1,1,0    SHOULD NOT TRANSFER, GO
       REM            BACK TO EXECUTE PLUS 1
       TSX ERROR-1,4  FAILED TO RETURN TO
       TXL EXH        EXECUTE INSTR PLUS 1
       REM            
       TMI *+3        SHOULD TRANSFER
       TSX ERROR-1,4  ERROR-ACC PLUS
       TRA EXH        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE WITH TIX
       REM            
EXI    AXT 1,1        L 1 IN XRA
       XEC *+3        
       TSX ERROR-1,4  ERROR-SHOULD GO TO TIX
       TXL EXI        INSTRUCTION AND PROCEED
       TRA EXJ        GO TO NEXT TEST IF ERROR
       REM            
       TIX *+3,1,0    SHOULD TRANSFER
       TSX ERROR-1,4  ERROR-DID NOT TRANSFER
       TRA EXI        
       REM            
EXJ    CLA ZERO       CLEAR ACC
       XEC *+3        
       CLA MINUS      L -0
       TRA *+4        
       REM            
       TIX *+1,1,1    SHOULD NOT TRANSFER
       TSX ERROR-1,4  FAILED TO RETURN TO
       TXL EXI        EXECUTE INSTR PLUS 1
       REM            
       TMI *+3        SHOULD TRANSFER
       TSX ERROR-1,4  ERROR-ACC PLUS
       TRA EXI        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE WITH TSX
       REM            
EXK    XEC *+5        
       TSX ERROR-1,4  ERROR-RETURNED TO
       TXL EXK        EXECUTE INSTR PLUS 1
       TRA EXL        GO TO NEXT TEST IF ERROR
       REM            
       TRA *+7        RETURN FROM SUBROUTINE
       REM            
       TSX HUH,1      OUT TO SUBROUTINE
       NOP            
       NOP            
       NOP            
       TSX ERROR-1,4  ERROR-FAILED TO RETURN
       REM            TO EXK PLUS 4
       TRA EXK        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE WITH CAS
       REM            
EXL    CLA K2A        L 200777760000 IN AC
       LDQ K2A        L 200777760000 IN MQ
       XEC *+4        
       TRA *+9        ERROR IN COMPARISON
       TRA *+10       OK
       TRA *+7        ERROR IN COMPARISON
       REM            
       CAS K2A        
       TRA *+2        ERROR-DID NOT RETURN
       TRA *+1        TO EXECUTE INSTR PLUS 1,
       TSX ERROR-1,4  2,S AFTER CAS INSTR
       TXL EXL        
       REM            
       TRA *+5        GO TO NEXT TEST IF ERROR
       TXS ERROR-1,4  
       TRA EXL        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE INDEXABLE
       REM            
EX1    AXT 4,1        L 4 IN XRA
       CLA MINUS      L -0
       XEC *+6,1      SHOULD GO TO EX1 PLUS 4
       TRA *+8        
       CLA ZERO       L +0
       TSX ERROR-1,4  FAILED TO RETURN
       REM            TO EXECUTE PLUS 1
       TXL EX1        
       REM            
       TRA EX2        GO TO NEXT TEST IF ERROR
       TSX ERROR-1,4  FAILED TO MODIFY ADR
       TRA EX1        
       TRA EX2        GO TO NEXT TEST IF ERROR
       REM            
       REM TEST ACCUMULATOR SIGN
       REM            
       TPL *+3        OK ACC SIGN PLUS
       TSX ERROR-1,4  
       TRA EX1        
       TRA *+2        
       REM            
       BCD 1XEC       TEST EXECUTE INDIRECT
       REM            ADDRESSABLE
       REM            
EX2    XEC* TCW3+1    ACC 777777777770
       LDQ CMOUT      L 77777777770
       LAS CMOUT      
       TRA *+2        
       TRA *+9        OK
       LAS TCW3+1     
       TRA *+2        
       TRA *+4        
       TSX ERROR-1,4  FAILED TO IA CORRECTLU
       TRA EX2        
       TRA EX3        
       REM            
       TSX ERROR-1,4  FALSE INDIRECT ADDRESS
       TRA EX2        
       TRA *+2        
       REM            
       BCD 1XEC       TEST SUCCESSIVE EXECUTES
       REM            
EX3    CLA ONE        L +1
       XEC *+1        
       XEC *+1        
       XEC *+1        
       XEC *+1        
       XEC *+1        
       ADD ONE        L +1
       SUB SEVEN      L +7
       TZE *+3        OK
       TSX ERROR-1,4  
       TRA EX3        
       REM            
       REM            
*COMPARISON FOR THIRD CARD AND READ TAPE-PREVIOUS SECTION
       REM            
       REM            
       NZT COUNT      SKIP CARD
       TRA *+2        READER AFTER
       TRA TOGO       FIRST PASS
       AXT 32,1       
       PXA 0,1        
       ADD ONE        
       STO WDNO       SET WORD NO CONSTANT
       AXT 0,2        
       CLA ONE        L +1
       STO RECNO      SET RECNO CONSTANT
       REM            
       NZT TPCHB      TAPE-CHAN B
       TRA *+9        NO
       REM            
       CLA RDFLD+32,1 WORD READ
       LDQ WRFLD+64,1 WORD READ
       CAS WRFLD+64,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WHILE
       NOP BCDTB+1    READING CARDS AND 
       REM            READING TAPE
       TIX *-7,1,1    RETURN TO CHECK ALL WORDS
       REM            
       NZT TPCHD      TAPE-CHAN D
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFCD+32,1  WORD READ
       LDQ WRFLD+64,1 CORRECT WORD
       CAS WRFLD+64,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTD+1    
       TIX *-7,1,1    
       REM            
       NZT TPCHF      TAPE-CHAN F
       TRA *+10       NO
       REM            
       AXT 32,1       
       CLA RFEF+32,1  WORD READ
       LDQ WRFLD+64,1 CORRECT WORD
       CAS WRFLD+64,1 
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP BCDTF+1    
       TIX *-7,1,1    
       REM            
       AXT 24,1       
       PXA 0,1        
       ADD ONE        
       STO WDNO       SET WORD NO. CONSTANT
       LXD SAVE,2     RESTORE XRB
       PXA 0,2        
       ADD ONE        
       STO RECNO      SET REC. NO. CONSTANT
TOGO   AXT 64,4       
       TIX *,4,1      DELAY
       REM            
       TSX RDNCK,4    
       NOP UGO-2      
       REM            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000    READ TAPE AND READ CARDS-SECTION 18 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+17  
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
       NZT COUNT      SKIP CARD
       TRA *+2        READER AFTER
       TRA GOOF-15    FIRST PASS
       REM            
       NZT CRCHA      CR-CHAN A
       TRA *+9        NO
       REM            
       CLA RDINA+24,1 WORD READ
       LDQ FIX+24,1   CORRECT WORD
       CAS FIX+24,1   
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  ERROR OCCURRED WHILE
       NOP CRCA+1     READING CARDS-WRITING TAPE
       TIX *-7,1,1    RETURN TO CHECK
       REM            ALL WORDS
       REM            
       NZT CRCHC      CR-CHAN C
       TRA *+10       NO
       REM            
       AXT 24,1       
       CLA RDNA+24,1  WORD READ
       LDQ FIX+24,1   CORRECT WORD
       CAS FIX+24,1   
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP CRCC+1     
       TIX *-7,1,1    
       REM            
       NZT CRCHE      CR-CHAN E
       TRA *+10       NO
       REM            
       AXT 24,1       
       CLA RDNA1+24,1 WORD READ
       LDQ FIX+24,1   CORRECT WORD
       CAS FIX+24,1   
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-2,4  
       NOP CRCE+1     
       TIX *-7,1,1    
       REM            
       TSX OK,4       
       TRA RCDTP-11   
       NOP            
       REM            
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
*  PRINT --           
**   00000  READ CARDS AND WRITE TAPE-SECTION 19 COMPLETE
       REM            
       WPRA           PRINT SECTION COMPLETE
       SPRA 3         
       RCHA SECTN+18  
       REM            
       CLA LACE1      PUNCH FIXED
       STA LACE       PATTERN
       STA LACE+4     AFTER
       STA LACE+8     FIRST PASS
       STL COUNT      SWITCH TO BYPASS
       REM            CARD READER
       TRA FINIS      
       REM            
       REM            
GOOF   LDI ADDR1      THE ADDRESS OF ADDR1 WILL
       TRA *+2        CONTAIN THE LOCATION OF THE
ADDR1  OCT 0          EXIT WHERE ERROR OCCURED.
       REM            THIS WOULD MEAN THE INSTRS.
       REM            BETWEEN THIS EXIT AND THE
       REM            PREVIOUS EXIT TO GOOF ARE
       REM            THE INSTRUCTIONS THAT
       REM            FAILED.
       REM            
       TSX ERROR-1,4  IN AN ERROR PRINT OUT THE
       REM            ADDR OF THE INDICATORS WILL
       REM            CONTAIN THE LOCATION OF THE 
       REM            ERROR EXIT.
       NOP WHOOP-3    IF AN ERROR OCCURS THIS
       REM            SECTION OF THE MAIN FRAME
       REM            TEST WILL NOT BE COMPLETED.
       REM            BUT WILL GO OUT TO THE NEXT
       REM            SECTION.
       CLA ADDR2      L REENTRY
       STA *+1        STA EXIT TO PROGRAM
       TRA            RETURN TO PROGRAM
       REM            
ADDR2  OCT 0          
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
       ORG ADDR2+1    
FINIS  CLA RST        
       STD MONIT      
       REM            
       CLA TPCNT      # OF TAPE UNITS SELECTED
       SUB ONE        
       TNZ *+6        
       TSX IORST,4    TO RESET I/O INSTRUCTIONS
       HTR TOV,0,EX   
       TSX IORST,4    
       HTR BCDTA,0,BCDF+2
       TRA SW5        
       REM            
       STO TPCNT      
       TSX SBCNT,4    TO REDUCE COUNT
       TRA TOV-4      
SW5    CLA STPCT      
       STO TPCNT      
       SWT 3          
       TRA *+2        
       TRA *+4        
       REM            
       WPRA           
       SPRA 3         
       RCHA ENCTL     CONTROL FOR PRINTING
       REM            PASS COMPLETE
       REM            
       SWT 5          TEST SWITCH #5
       TRA SW6        UP-TEST SWITCH 6
       TSX RELO,2     
       TRA TOV-4      
       REM            
SW6    SWT 6          
       TRA *+3        UP-NEXT PROGRAM
       TSX RELO,2     RESET CARD IMAGE
       TRA BEGIN      DOWN-BACK TO ENTER CONTROL
       REM            
       RCDA           
       RCHA OMY       
       LCHA 0         
       TRA 1          
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
       ORG SW6+8      
B      HED            
*                 709 ROUTINE FOR MODIFICATION OF
*                        I-O INSTRUCTIONS
       REM            
CTRL1  OCT +0        COUNT WORD FOR DS A+B
CTRL2  OCT +0        COUNT WORD FOR DS C+D
CTRL3  OCT +0        COUNT WORD FOR DS E+F
IOCT   OCT +0        I-O COUNT
CTRA   OCT +0        NUMBER OF UNITS - CHN A
CTRB   OCT +0        NUMBER OF UNITS - CHN B
CTRC   OCT +0        NUMBER OF UNITS - CHN C
CTRD   OCT +0        NUMBER OF UNITS - CHN D
CTRE   OCT +0        NUMBER OF UNITS - CHN E
CTRF   OCT +0        NUMBER OF UNITS - CHN F
SBCNT  TRA RDCNT      
CTX    TRA CTX1      TO MODIFY PROGRAM
IORST  STL REST       SET SWITCH WITH BITS
       TRA CTX1       
IOCNT  TRA IOC1      TO RELOAD I-O COUNT
       REM            
       REM            
       REM            
*     ENTER CONTROL WORDS FOTR CHANNELS AND UNITS
       REM            
IOC    STZ CTRL1     CLEAR
       STZ CTRL2     CONTROL
       STZ CTRL3     WORDS.
       REM            
       REM            
       REM            
       HTR *+1       ENTER KEYS WITH CONTROL
       REM           WORD FOR CHN A AND/OR B
       REM            
*     INCLUDE THE DATA SYSNC TO BE USED IN THE TAG
*     OF THE CONTROL WORD
       REM            
*   NOTE - A TAG OF 1 WILL SPECIFY CHAN A AND/OR B
*          A TAG OF 2 WILL SPECIFY CHAN C AND/OR D
*          A TAG OF 4 WILL SPECIFY CHAN E AND/OR F
       REM            
*      IF 2 OR MORE DS ARE TO BE TESTED THE 1ST CONTROL
*      WORD ENTERED IN THE KEYS SHOULD CONTIAN A MULTIPLE TAG
       REM            
       REM            
       ENK           PLACE WORD
       XCL           ENTERED ON KEYS
       PAI           IN INDICATORS
DSC    RFT 0,7       DO WE HAVE A TAG BIT
       TRA DSC1      YES
       REM            
       REM            
       HTR *-5       NO TAG BIT - RE-ENTER FIRST
       REM           CONTROL WORD SPECIFYING 
       REM           OS IN TAG OF KEYS
       REM            
DSC1   RNT 0,1       TEST FOR CHAN A AND/OR B
       TRA DSC2      NO
       STI CTRL1     CNTL WORD FOR A AND/OR B
DSC2   RNT 0,2       TEST FOR CHAN C AND/OR D
       TRA DSC3      NO
       REM            
       REM            
       HTR *+1       SET CONT WORD IN KEYS
       REM           FOR CHAN C AND/OR D
       REM            
       REM            
       ENK            
       STQ CTRL2      
DSC3   RNT 0,4       TEST FOR CHAN E AND/OR F
       TRA *+4       NO
       REM            
       REM            
       HTR *+1       SET CONT WORD IN KEYS
       REM           FOR CHAN E AND/OR F
       ENK            
       STQ CTRL3      
       REM            
       REM            
*    ESTABLISH UNIT COUNT FROM CONTROL WORDS
       REM            
       REM            
IOC1   STZ IOCT      CLEAR UNIT COUNT
       SXA ACCX,4    SAVE XRC
       AXT 3,2       L +3 IN XRB
       AXT 6,1       L +6 IN XRA
       AXT 2,4       L +2 IN XRC
       CLA FOUR+2,4   
       STA AB+1       
AB     CAL CTRL1+3,2 L CHANNEL CONTROL WORD
       ARS 4          
       PAI            
       ANA KON2      L + 17 - CLEAR ACC TO COUNT
       RNT 20        CHECK FOR EXCLUSIVE BIT
       TRA *+2       NO
       CLA KON+2     YES - L + 1 FOR COUNT
       STO CTRA+6,1  SAVE CHN UNIT CONT
       ADD IOCT       
       STO IOCT    SAVE TOTAL UNIT COUNT
       TIX *+1,1,1,   
       TIX AB-2,4,1   
       TIX AB-3,2,1   
       LXA ACCX,4    RELOAD XRC
       REM            
       REM            
CNT    CLA FOUR      L +4
       PAX 0,2       L ACC IN XRB
       SXA *+4,2     L XRB IN ADDRESS
       AXT 3,1       L +3 IN XRA
       CLM            
       REM
       REM
       LDI CTRL3+1,1  
       RNT           CHECK NUMBER OF
       REM           CARD MACHINES ON LINE
       TRA *+2       NO
       ADD KON+2     YES - L +1
       TIX *-4,1,1    
       CAS IOCT       
       STA IOCT       
       NOP            
       PXA 0,2       L XRB IN ACC
       ARS 1          
       TIX CNT+1,2,1  
       AXT 6,2        
       CLA CTRA+6,2   RELOCATE
       STO CTRA1+6,2  CHANNEL
       TIX *-2,2,1    COUNTS
       TRA 1,4       EXIT TO MAIN PROG
       REM            
       REM            
*      MODIFY I-O INSTRUCTIONS
       REM            
CTX1   STO ACCX      ACC CONTENTS
       ARS 35         
       SLW ACCX+1     P+Q BITS
       SXA ACCX+2,1   
       SXD ACCX+2,2   
       STQ ACCX+3     
       STI ACCX+4    SAVE INDICATORS
       REM            
       REM            
*    EXTABLISH PROGRAM AREA TO MODIFY
       REM            
IOC2   CLA 1,4       L FIRST AND LAST ADDRESS
       REM           PROGRAM AREA TO BE MODIFED
       SXA HALT,4     
       STA NOW        BEGINNING ADDRESS
       ARS 18         
       STA CHECK+1    
       STA RET        
       SUB NOW        # OF LOCATIONS TO CHECK
       PAX 0,1        
       REM            
       REM            
*   START MODIFICATION OF INSTUCTIONS
       REM            
       REM            
CHECK  AXT 6,2        
       CAL 0,1        N LOCATION TO BE CHECK
       SLW INSTR      SAVE INSTRUCTION
       ANA AMASK      MASK OUT ADDRESS
       LAS WRS+6,2    LOOK
       TRA *+2        FOR
       TRA SECT       SELECT
       TIX *-3,2,1    RETURN FOR NEXT SELECT
       REM            
       LDI INSTR      NOT SELECT-IS IT A BCD WORD
       RNT 6000       TEST FOR BLANK-2ND POSITION
       TRA *+2        NOT SELECT-NOT BCD WORD
       TRA CBCD       YES-COULD BE BCD WORD
       REM            
       TIX CHECK,1,1  RETURN TO CHECK NEXT CELL
       REM            
       REM            
EXIT   LXA HALT,4     RESTORE XRC
       LDI ACCX+4     RESTORE INDICATORS
       CLA ACCX+1     
       LDQ ACCX       
       LLS 35         
       LDQ ACCX+3     
       LXA ACCX+2,1   
       LXD ACCX+2,2   
       STZ SBIT       
       STZ REST       
       TRA 2,4        RETURN TO MAIN PROGRAM
       REM            
SECT   CAL INSTR      WORKING INSTRUCTION
       ANA MASK3      MASK TO LEAVE CLASS
       SUB TWHD       SUBTRACT TAPE CLASS
       TZE TRSET      YES-ITS A TAPE SELECT
       TRA RET+1      NO-NOT TAPE BRING IN
       REM            NEXT INSTRUCTION
       REM            
SECT1  CAL INSTR      WORKING INSTRUCTION
       ANA DMASK      MASK TO LEAVE CHANNEL
       CAS D          
       TRA FIVE       ACC GREATER
       TRA CHAND      ACC EQUAL-CHAN D
       REM            
       CAS B          ACC LESS
       TRA CHANC      GREATER-CHAN C
       TRA CHANB      EQUAL-CHAN B
       TRA CHANA      LESS-CHAN A
       REM            
FIVE   CAS E          
       TRA CHANF      GREATER-CHAN F
       TRA CHANE      EQUAL-CHAN E
       HTR CHECK      ERROR IN DETERMINING
       REM            WHICH CHANNEL
       REM            RETURN TO TRY AGAIN
       REM            
CHANA  LDI CTRL1      FIRST CONTROL
       RNT 10         
       TRA RET+1      
       STL CHECA      
       AXT 6,4        
       LNT 400000     CHECK FOR S KEY
       STL SBIT       NO SIGN-TAPE READ
       RNT 400        TEST FOR EX. UNIT
       TRA *+2        NO
       TRA DNBIT      YES
       TRA STEP       NO-STEP ADDRESS
       REM            
       REM            
RET    SLW 0,1        
       STZ SBIT       CLEAR SBIT SWITCH
       STZ BCD1       CLEAR BCD SWITCH
       STZ DBIT       CLEAR EXCLUSIVE BIT
       TRA EXIT-1     
       REM            
       REM            
       REM            
STEP   CAL INSTR      WORKING INSTRUCTION
       NZT BCD1       TEST FOR BCD
       TRA *+2        NO
       ANA MASK8      YES
       SLW HOLD       
       REM            
       PXD            CLEAR ACC
       CAS CTRA1+6,4  COMPARE TO UNIT COUNT
       HTR *          ERROR-COUNT IN ERROR
       TRA TSBIT      RESET + START ON HALT
       REM            
       CAL INSTR      WORKING INSTRUCTION
       ANA MASK4      CLEAR ALL BUT UNIT
       PAX 0,2        UNIT IN INDEX
       TXL TSBIT,2,0  IS IT ZERO
       REM            
       CAL HOLD       NO-NOT ZERO
       ADD ONE        STEP UNIT
       TRA RET        
       REM            
TSBIT  CAL INSTR      WORKING INSTRUCTION
       ANA MASK1      MASK OUT UNIT
       NZT BCD1       IS IT BCD
       ANA MASK8      YES
       NZT SBIT       IS S BIT BIT
       TRA TSBIT-3    NO
       ADD TWO        YES
       TRA RET        
       REM            
CHANB  AXT 5,4        
       STL CHECA+1    
       LDI CTRL1      
       RNT 1000       TEST FOR CHAN B SELECTION
       TRA RET+1      NO
       RNT 10000      TEST FOR EXCLUSIVE BIT
       TRA STEP       NO
       STL DBIT       YES-SET SWITCH
       PIA            
       ARS 10         
       TRA DNBIT+3    
       REM            
CHANC  AXT 4,4        
       STL CHECA+2    
       LDI CTRL2      
       RNT 10         TEST FOR CHAN C SELECTION
       TRA RET+1      NO
       RNT 400        TEST FOR EXCLUSIVE BIT
       TRA STEP       NO
       STL DBIT       YES-SET SWITCH
       TRA DNBIT+1    
       REM            
CHAND  AXT 3,4        
       STL CHECA+3    
       LDI CTRL2      
       TRA CHANB+3    
       REM            
CHANE  AXT 2,4        
       STL CHECA+4    
       LDI CTRL3      
       TRA CHANC+3    
       REM            
CHANF  AXT 1,4        
       STL CHECA+5    
       LDI CTRL3      
       TRA CHANB+3    
       REM            
DNBIT  STL DBIT       
       PIA            
       ARS 4          SHIFT TO ADDRESS
       ANA MASK4      SAVE EX. UNIT
       STO SAVE       
       REM            
       NZT SAVE       IS UNIT ZERO
       HTR *          UNIT SELECTED WAS ZERO
       REM            
       CAL INSTR      WORKING INSTRUCTION
       ANA MASK1      CLEAR UNIT
       REM            
       NZT BCD1       IS IT BCD
       TRA *+2        NO
       ANA MASK8      YES
       LXA SAVE,2     UNIT TO INDEX
       TXL *+3,2,1    IS UNIT ONE
       ORA SAVE       NO-OR IN UNIT
       TRA RET        
       REM            
       NZT SBIT       TEST S BIT
       TRA *-3        NO
       ADD TWO        CHANGE TO UNIT TWO
       TRA RET        
       REM            
       REM            
RSET   CAL INSTR      WORKING INSTRCUTION
       ANA MASK1      MASK TO CLEAR UNIT
       NZT BCD1       DO WE HAVE A BCD WORD
       TRA RET        NO
       CAL INSTR      BCD WORD
       ANA MASK9      MASK TO CLEAR UNIT
       ORA MASK7      OR IN TWO BLANKS
       TRA RET        RETURN
       REM            
TRSET  NZT REST       CHECK RESET CONSTANT
       TRA SECT1      NO-CONTINUE CHECK
       TRA RSET       YES, RESET
       REM            
CBCD   AXT 6,4        DEFINE BCD WORD
       CAL INSTR      WORKING INSTRUCTION
       ANA MASK5      TAKE OUTUNECCESSARY BITS
       SLW SAVE1      SAVE INSTRUCTION
       REM            
       LAS BCD2+6,4   POSSIBLE BCD WORD
       TRA *+2        
       TRA TBSET      THIS IS BCD WORD
       TIX *-3,4,1    
       TRA RET+1      NOT BCD
       REM            
BCD10  CAL INSTR      WORKING INSTRUCTION
       ARS 12         SHIFT TO LOW ORDER
       ANA MASK6      MASK TO LEAVE CHANNEL
       CAS THREE      L +3
       TRA *+6        ACC GREATER
       TRA CHANC      BCD-CHANNEL C
       CAS TWO        ACC LESS
       HTR            ERROR
       TRA CHANB      BCD-CHANNEL B
       TRA CHANA      BCD-CHANNEL A
       REM            
       CAS FVE        L +5
       TRA CHANF      BCD-CHANNEL F
       TRA CHANE      BCD-CHANNEL E
       TRA CHAND      BCD-CHANNEL D
       REM            
TBSET  STL BCD1       SET SWITCH
       NZT REST       TEST FOR RESET
       TRA BCD10      NO
       TRA RSET       YES
       REM            
RDCNT  AXT 6,2        
       ZET CHECA+6,2  TEST FOR COUNT
       TRA *+6        REDUCTION---YES
       TIX *-2,2,1    NO
       AXT 6,2        CLEAR
       STZ CHECA+6,2  COUNT
       TIX *-1,2,1    AREAS
       TRA 1,4        RETURN
       REM            
       CLA CTRA1+6,2  CHECK
       TZE *+4        
       SUB ONE        FOR
       STO CTRA1+6,2  REDUCTION
       TRA *-8        OF COUNT
       REM            
       CLA CTRA+6,2   COUNT IS ZERO
       STO CTRA1+6,2  RESTORE INITIAL
       TRA RDCNT+3    COUNT
       REM            
       REM            
HOLD   OCT 0          
FOUR   OCT 4          CHAN D
       OCT 12         
INSTR  OCT 0          
KON    HTR 6,0,8      
KON2   OCT +17        
       OCT +1         
HALT   OCT 0          
NOW    OCT 0          
AMASK  OCT 777777700000
       REM            
WRS    WRS            WRITE SELECT
       RDS            READ SELECT
       OCT 076400000000 BACKSPACE RECORD
       OCT 077200000000 REWIND
       OCT -76400000000 BACKSPACE FILE
       OCT 077000000000 WRITE EOF
       REM            
DMASK  OCT 7000       
D      OCT 4000       
B      OCT 2000       
E      OCT 5000       
SIX    OCT 6          CHAN F
FVE    OCT 5          CHAN E
THREE  OCT 3          CHAN C
TWO    OCT 2          CHAN B
ONE    OCT 1          CHAN A
MASK1  OCT 777777777760
MASK3  OCT 700        
TWHD   OCT 200        
SBIT   OCT 0          
MASK4  OCT 17         
BCD1   OCT 0          
BCD    OCT 0          
REST   OCT 0          
       REM            
BCD2   OCT 226226006000 BSF
       OCT 226251006000 BSR
       OCT 512566006000 REW
       OCT 516322006000 RTB
       OCT 662526006000 WEF
       OCT 666322006000 WTB
       REM            
ACCX   BSS 5          
SAVE   OCT            TEMP STG
SAVE1  OCT            TEMP STG
MASK5  OCT 777777007700
MASK6  OCT 7          
MASK7  OCT 6060       
MASK8  OCT 777777777717
MASK9  OCT 777777770000
DBIT   OCT 0          
CHECA  BSS 6          
CTRA1  BSS 6          
       REM            
       REM            
* SENSE SWITCHES INTERROGATION AND DIAGNOSTIC
*            PRINT SUBROUTINE FOR 709
       ORG CTRA1+6    
A      HED            
       STZ KONST+3  INDICATE I/O TYPE PRINT
       REM            OUT
       TRA ERROR      
       STZ KONST+3  SET STORAGE TO ZEROS
       REM          MODIFY INSTRUCTIONS FOR
       REM          RETURN ADDR TO MAIN PROG
       TRA MOD        
ERROR  STZ KONST    DO NOT REPEAT SECTION
       STZ KONST+1  IF SENSE SW 4 IS DOWN
       REM            
       REM            
       REM            
       PSE 114      IF SENSE SW 2 IS UP THEN-
       TRA SSW3     CHECK SSW 3
       TIX OK,4,1     
       REM            
       REM            
       REM            
       REM            
OK     SXD LOC+1,4  2'S COMPL OF PROGRAM
       REM          LOCATION LAST PREFORMED
       REM            
       REM            
       PSE 113      IF SENSE SW 1 IS UP THEN
       TRA RELY     CHECK SS 4
       TRA 1,4      IF DOWN REPEAR SECTION
       REM          OF PROG
       REM            
SSW3   PSE 115      IF SENSE SW 3 IS UP
       TRA PRINT    PRINT ON ERROR
       REM          IF SS 3 IS DOWN STOP ON
       HTR OK-1     ERROR
       REM          HTR 2'S COMPLEMENT OF
       REM          INDEX REGISTER C
       REM          CONTIANS THE ERROR ADDRESS
       REM          OF THE SECTION OF THE
       REM          PROG IN ERROR
       REM            
RELY   PSE 116      IF SENSE SWITCH 4 IS UP
       TRA 3,4      GO TO NEXT SECTION OF
       REM          THE PROG
       REM          IF DOWN REPEAR SECTION
       REM          OF THE PROGRAM N TIMES
       REM          OR THE NUMEBR OF TIMES
       REM          THAT IS SPECIFIED IN LOC
       REM          KONST+2
       REM            
       REM            
       REM            
       CLA KONST+1  COUNTER
       SUB KONST    L+1 REDUCE COUNT BY 1
       STO KONST+1    
       TNZ OK+3       
       CLA KONST+2  L+50 COUNT CONSTANT
       STO KONST+1    
       CLA STOR+7   L+1
       STO KONST      
       TRA 3,4      CONT PROG
       REM            
       REM            
       REM            
MOD    STZ KONST+4  SET STORAGE TO ZEROS
       STZ KONST+1    
       STZ KONST      
       REM            
       REM            
       REM            
ERR    PSE 114      IF SS 2 IS UP CHECK
       TRA SSW3A    SENSE SWITHC 3
       REM            
OK2    PSE 113      SSW1 UP-GO TO NEXT ROUTINE
       TRA 2,4      EXIT
       TRA 1,4      REPEAT TEST
       REM            
SSW3A  PSE 115      IS SENSE SWITCH 3 IS UP
       TRA PRINT    PRINT ERROR
       REM          2'S COMPLEMENT OF XRC
       HTR OK2      CONTIANS THE ERROR ADDR
       REM          OF SECTION OF PROG LAST
       REM          EXECUTED
       REM            
KONST  OCT 1          
       OCT 50         
       OCT 50       COUNT CONSTANT
       OCT 1          
       OCT 1          
       TRA OK-1     EXIT FROM PRINT PROG
       TRA OK2      EXIT FROM PRINT WHEN
       REM          ENTRY IS TO ERROR-1
       OCT 1          
       REM            
WDNO   OCT            
RECNO  OCT            
       REM            
       REM          PUT DSC REDUNDANCY
       REM          CHECKS IN PRINT RECORD
RDNCK  STO STOR     ACC CONTENTS
       ARS 35         
       SLW STOR+3   OVFL BITS P + Q
       STQ STOR+1   MQ CONTENTS
       REM            
       CAL MASK+9   RESET RECORD IMAGE
       ANS REC4R+9  INDICATIONS
       CAL BIT2+3     
       SLW REC4R+8  FOR REDUNDANCY TAPE CK
       SLW KONST+7  PUT A BIT IN WORD
       TCOA *       CHECK CHAN IN OPERATION
       TCOB *       CHECK CHAN IN OPERATION
       TCOC *       CHECK CHAN IN OPERATION
       TCOD *       CHECK CHAN IN OPERATION
       TCOE *       CHECK CHAN IN OPERATION
       TCOF *       CHECK CHAN IN OPERATION
CHK4A  CAL BIT+10     
       ARS 1          
       TRCA CHK4B-1 REDUNDANT TAPE CK DSCA
       ORS REC4R+9  NO 
       TRA CHK4B      
       ORS REC4R+8  YES
       REM            
CHK4B  CAL BIT2+1     
       ARS 1          
       TRCB CHK4C-1 RND TAPE CK DSC-B
       ORS REC4R+9  NO 
       TRA CHK4C      
       ORS REC4R+8  YES
       REM            
CHK4C  CAL BIT+1      
       ARS 3          
       TRCC CHK4D-1 RND TAPE CK DSC-C
       ORS REC4R+9  NO 
       TRA CHK4D      
       ORS REC4R+8  YES
       REM            
CHK4D  CAL BIT+8      
       ARS 1          
       TRCD CHK4E-1 RND TAPE CK DSC-D
       ORS REC4R+9  NO 
       TRA CHK4E      
       ORS REC4R+8  YES
       REM            
CHK4E  CAL BIT+9      
       ARS 1          
       TRCE CHK4F-1 RND TAPE CK DSC-E
       ORS REC4R+9  NO 
       TRA CHK4F      
       ORS REC4R+8  YES
       REM            
CHK4F  CAL STOR+7     
       TRCF CHK4F+4 RND TAPE CK DSC-F
       ORS REC4R+9  NO 
       TRA CHK4F+5    
       ORS REC4R+8  YES
       REM            
       REM          WAS THERE A REDUNDANCY
       CLA REC4R+8  TAPE CHECK ON ANY CHAN
       SUB BIT2+3   IF NOT-RETURN TO MAIN
       TZE CONT     PROGRAM-OK
       REM            
       STZ KONST+7    
CONT   CLA STOR+3   RESET REGISTERS
       LDQ STOR       
       LLS 35         
       LDQ STOR+1     
       REM            
       ZET KONST+7    
       TRA 2,4      CONTINUE PROG
       REM          TAPE CHECK REDUNDANCY
       TRA ERROR-2  INTERROGATE SENSE
       REM          SWITCHES
       REM            
       REM          PRINT ROUTINE
PRINT  STO STOR     ACC CONTENTS
       ARS 35         
       SLW STOR+3   OV FL BITS
       PXA 2,2        
       STA STOR+2   XRB
       SXD STOR+2,1 PLACE XRA INTO DECR
       SXD STOR+3,4 PLACE XRC INTO DECR
       STQ STOR+1   MQ CONTENTS
       REM            
       REM            
       REM            
CHK1   CLA STOR+5   L 100000
       DCT          DIV CK TEST
       ORS STOR+3   YES
       ARS 3          
       TNO CHK4-1   ACC OV FL-YES
       ORS STOR+3   NO 
       REM            
       CLM          SENSE SWITCHES
CHK4   LXA STOR+8,1 L +4
       ALS 3          
       MSE 101,1      
       TRA *+3        
       ADD STOR+7   L +1
       PSE 101,1    RESET LITES
       TIX CHK4+1,1,1 
CHK3   LXA STOR+6,1 L +6
       ALS 3          
       PSE 119,1      
       TRA CHK3+5     
       ADD STOR+7   L +1
       TIX CHK3+1,1,1 
       REM            
       REM            
       SLW STOR+4   RETAIN PSE + MSE
       REM          INDICATIONS
       REM          WAS ENTRY FROM SUB-
CHK3A  CLA KONST+4  ROUTINE AT ERROR-1
       TZE CHK3A+7  YES
       CLA PRINT+3  NO 
       STA CHK5+1   RESET ADDR
       CLA KONST+5    
       STO EXIT       
       TRA CHK5       
       REM            
       CLA STOR+7   L+1
       STO KONST+4    
       STA CHK5+1     
       CLA KONST+6    
       STO EXIT       
       REM            
       REM          OBTAIN TEST LOC
       REM          AND ERROR ADDR
CHK5   LXD STOR+3,4 XRC
       PXD 2,4        
       COM            
       ADD BIT2+2   +1 TO DECREMENT
       STD LOC      ERROR ADDR INTO DECR
       ARS 18         
       SUB CHK5+1   L +2
       STA CHK6       
CHK6   CAL 0        PLACE
       STA LOC      TEST LOC INTO ADDR
       STP LOC        
       REM            
       REM          OBTAIN OPN OF INST
       SUB STOR+7   L +1
       STA *+1        
       LDQ 0        BCD OPERATION 
       REM            
CHK7   LXA STOR+6,1 L +6
       CLM            
       LGL 2          
       PAX 0,4      ZONE BIT
       LGL 4          
       CAS BIT+2    CHECK FOR BLANK L +60
       TRA *+2        
       TRA CHK7A    YES
       CAS BIT+9    CHECK FOR HYPHEN
       TRA *+2        
       TRA TRAP     YES- INDICATES A TRAP
       REM          ROUTINE
       ANA BIT+11   MASK FOR NUMERIC
       PAX 0,2        
       TXH CHK7A,2,10 IGNORE SPECIAL CHARS
       CLA BIT+1    COL INDICATOR
       ARS 6,1        
       ORS REC1L+9,2  
       TXL *+2,4      
       ORS REC1L+12,4 
CHK7A  TIX CHK7+1,1,1 
       REM            
CHK8   LDQ 0          
       LXA BIT+3,1   L +14
       REM            
       TSX CH22,2     
       CAL BIT+10    COL IND
       ARS 12,1       
       ORS REC1R+9,4  
       TIX *-4,1,1    
       REM            
CH1    CAL LOC       PUT TEST LOC INTO IMAGE
       LRS 15         
       LXA LOC+5,1   L +5
       TSX CH21,2     
       REM            
       REM            
       CAL BIT       BIT COLUMN 10
       ARS 5,1        
       ORS REC1L+9,4  
       TIX CH1+3,1,1  
       REM            
       REM            
       REM           PUT ERROR ADDR INTO IMAGE
CH5    LXD LOC,4      
       PXD 0,4        
       LRS 33         
       LXA LOC+5,1   L +5
       TSX CH21,2     
       CAL LOC+6     -0
       ARS 6,1        
       ORS REC1R+9,4  
       TIX CH5+4,1,1  
       REM            
       REM           PUT PSE SW INTO
CH7    CAL STOR+4    IMAGE
       LRS 18         
       LXA STOR+6,1  L +6
       TSX CH21,2     
       CAL BIT+9      
       ARS 6,1        
       ORS REC1R+9,4  
       TIX CH7+3,1,1  
       REM            
CH10   LXA BIT+3,4   PUT 1ST REC IN PR IMAGE
       LXA LOC+4,1   L +30
       CAL REC1L+12,4 LEFT HALF IMAGE
       SLW PR+24,1    
       CAL REC1R+12,4 
       SLW PR+25,1    
       REM            
       TIX CH10+7,4,1 
       TIX CH10+2,1,2 
       REM            
CH11   LXA BIT+3,4   MASK IMAGE
       CAL MASK      MASK
       ANS REC1L+12,4 
       CAL MASK+1     
       ANS REC1R+12,4 
       CAL MASK+2    MASK LEFT HALF
       ANS REC2L+12,4 2ND RECORD
       CAL MASK+3    MASK RIGHT HALF
       ANS REC2R+12,4 
       CAL MASK+4    MASK 3RD RECORD
       ANS REC3L+12,4 LEFT HALF
       CAL MASK+5     
       ANS REC3R+12,4 
       CAL MASK+8    MASK IND KEYS
       ANS REC4L+12,4 PRINT REC
       REM            
       CAL MASK+6     
       ANS P92+1,4   I/O IMAGE
       CAL MASK+7    REC=, WORD =, ETC
       ANS P95+1,4    
       TIX CH11+1,4,1 
       REM            
       REM            
       REM            
CH14   WRS 753       PRINTER
       SPRA 3        DOUBLE REM
       REM           PRINT FIRST LINE
       REM           TEST LOC, ERROR ADDR
       TSX WPRA+1,1   
       CLA LOC        
       TMI CH35-6     
       REM            
CH18   CLA STOR+4    PUT MSE LITES INTO IMAGE
       LRS 30         
       LXA STOR+8,1  L +4
       TSX CH21,2     
       CAL BIT+12    BIT COL 6
       ARS 4,1        
       ORS REC2L+9,4  
       CAL BIT+6     BIT COL 5
       ARS 4,1        
       ORS P92-2,4    
       TIX CH18+3,1,1 
       REM            
       CLA KONST+3   IS THIS A MAIN FRAME
       TZE CH41      PRINT OUT -NO
       REM           FORM CARD IMAGE FOR 2ND REC
CH15   CLA STOR+2     
       LRS 33         
       LXA STOR+8,1  L +4
       TSX CH21,2     
       REM            
       CAL BIT+5     BIT COLUMN
       ARS 4,1        
       ORS REC2L+9,4  
       TIX CH15+3,1,1 
       TSX CH21,2     
       CAL LOC+6     L-0
       ORS REC2R+9,4  
CH16   TSX  CH21,2    
       LXA LOC+5,1   L +5
       TSX CH21,2     
       CAL BIT2      BIT COL 8
       ARS 5,1        
       ORS REC2R+9,4  BIT IN IMAGE
       TIX CH16+2,1,1 
       REM            
CH17   CLA STOR+3    PUT XRC INTO IMAGE
       LRS 33         
       LXA LOC+5,1   L +5
       TSX CH21,2     
       REM            
       CAL BIT2+1    BIT IN COL 19
       ARS 5,1        
       ORS REC2R+9,4 BIT IN IMAGE
       TIX CH17+3,1,1 
       REM            
CH27   LDQ STOR+1    CONTENTS OF MQ
       LXA BIT+3,1   L +14
       TSX CH22,2     
       CAL BIT+10    BIT COL 15
       ARS 12,1       
       ORS REC2L+9,4  
       TIX CH27+2,1,1 
       REM            
       CAL LOC+3     WAS ROUTINE USING TRAP
       SUB BIT+9      
       TNZ *+4       NO
       CAL STOR+7    L +1
       ORS REC2R+8    
       TRA *+3        
       CAL STOR+7    L +1
       ORS REC2R+9    
       STZ LOC+3      
       REM            
CH23   LXA BIT+3,4    
       LXA LOC+4,1   L +30
       CAL REC2L+12,4 LEFT HALF
       SLW PR+24,1    
       CAL REC2R+12,4 RIGHT HALF IMAGE
       SLW PR+25,1    
       TIX CH23+7,4,1 
       TIX CH23+2,1,2 
       REM            
       TSX WPRA,1    PRINT 2ND LINE
       REM            
       REM            
CH20   CAL STOR+3    PUT TRGS INTO
       LRS 18        IMAGE
       TSX CH21,2     
       CAL STOR+7    BIT IN 35
       ORS REC3L+9,4  INDICATE DIV CK
       REM            
       TSX CH21,2     
       REM            
       CAL BIT+4     BIT COL 12
       ARS 1          
       ORS REC3R+9,4 ACC OVFL
       REM            
       REM            
CH24   CLM           PUT Q + P BITS
       LLS 11        INTO IMAGE
       PAX 0,4        
       CAL BIT+4     BIT IN COL 4
       ALS 2          
       ORS REC3L+9,4 Q BIT
       CLM           GET P BIT
       LLS 1          
       PAX 0,4        
       CAL BIT+4      
       ARS 2         BIT IN COL 13
       ORS REC3L+9,4  
CH25   LDQ STOR       
       CAL BIT+6     PUT + SIGN OF
       TQP CH25+5    ACC IN IMAGE
       ORS REC3L+10  MINUS SIGN OF ACC IN IMAGE
       TRA CH26       
       ORS REC3L+11  INTO IMAGE
CH26   LXA BIT+3,1   L +14
       TSX CH22,2     
       CAL BIT+10    BIT COL 15
       ARS 12,1       
       ORS REC3L+9,4  
       TIX CH26+1,1,1 
       REM            
CH30   LXA BIT+3,4   PUT 3RD REC INTO
       LXA LOC+4,1   PRINT IMAGE
       CAL REC3L+12,4 LEFT HALF
       SLW PR+24,1    
       CAL REC3R+12,4 RIGHT HALF
       SLW PR+25,1    
       TIX CH30+7,4,1 
       TIX CH30+2,1,2 
       REM            
       TSX WPRA,1    PRINT 3RD LINE
       REM            
       REM           PUT INDICATORS IN REC
CH32   STI PR        STORE INDICATORS
       LDQ PR        INDICATOR FROM STORAGE
       LXA BIT+3,1   L +14
       TSX CH22,2     
       CAL BIT+6      
       ARS 13,1       
       ORS REC4L+9,4 INDICATORS INTO
       TIX CH32+3,1,1 PRINT RECORD
       REM            
       REM           PUT CONTENT OF KEYS IN
CH33   ENK           PRINT RECORD
       LXA BIT+3,1   L +14
       TSX CH22,2     
       CAL BIT+1      
       ARS 16,1       
       ORS REC4L+9,4 KEYS CONTENTS INTO
       TIX CH33+2,1,1 PRINT REC
       REM            
CH34   LXA BIT+3,4   L+14 PUT 4TH REC
       REM           INTO PRINT IMAGE
       LXA LOC+4,1   L +30
       CAL REC4L+12,4 
       SLW PR+24,1    
       CAL REC4R+12,4 TAPE CHECK INDICATORS
       SLW PR+25,1    
       ZET KONST+7    
       STZ PR+25,1    
       TIX *+1,4,1    
       TIX CH34+2,1,2 
       REM            
       TSX WPRA,1    PRINT CONTENTS OF INDS
       REM            
       CLA STOR+7    L+1
       STO KONST+3    
       REM           RESET ACC + MQ CONTENTS
       STO KONST+7    
       CLA STOR+3    OVFL BITS
       LDQ STOR      ACC CONTENTS
       LLS 35         
       LDQ STOR+1     
       REM            
CH35   LXA STOR+2,2  XRB
       LXD STOR+2,1  XRA
       LXD STOR+3,4  XRC
       TOV EXIT       
EXIT   TRA OK-1       
       REM            
       REM            
       REM            
CH41   CLA KONST+7   IS THIS A REDUNDANCY
       REM           TAPE CK PRINT-OUT
       TZE CH32      YES
       REM            
       REM           CLEAR RECORD IMAGE
       LXA LOC+4,1   LOC +30
       STZ PR+24,1    
       TIX *-1,1,1    
       REM            
       CAL STOR+1    WORD GENERATED
CH43   SLW PR+17      
       REM            
       COM            
       SLW PR+19     PRINT IMAGE
       LXA BIT+3,1   L +14
       LXA LOC+4,2   LOC +30
       CAL P92+1,1    
       SLW PR+24,2    
       TIX CH43+8,1,1 
       TIX CH43+5,2,2 
       REM            
       TSX WPR,1     PRINT WORD GENERATED
       REM            
CH45   CLA STOR+2     
       ARS 18         
       SUB WDNO      WORD NUMBER
       LRS 15         
       LXA LOC+5,1    L+5
CH46   TSX CH21,2     
       CAL BIT+7     BIT COL 17
       ARS 5,1        
       ORS P93,4     WORD NUMBER INTO
       TIX CH46,1,1  IMAGE
       REM            
CH47   LXA STOR+2,2  XRB
       CLM            
       PXA 0,2        
       SUB RECNO     RECORD NUMBER
       LRS 15         
       LXA LOC+5,1   L+5
CH48   TSX CH21,2     
       CAL BIT+6     BIT COL 5
       ARS 5,1        
       ORS P93,4      
       TIX CH48,1,1   
       REM            
       REM            
CH49   LXA LOC+4,1   L +30
       STZ PR+24,1    
       TIX *-1,1,1    
       REM            
       CAL STOR      WORD READ
CH50   SLW PR+17      
       COM            
       SLW PR+19      
       REM            
CH51   LXA BIT+3,1   L +14
       LXA LOC+4,2   L +30
       CAL P95+1,1    
       SLW PR+24,2    
       TIX CH51+5,1,1 
       TIX CH51+2,2,2 
       REM            
       TSX WPR,1     PRINT WORD WRITTEN
       REM            
       TRA CH32      PRINT INDICATORS AND KEYS
       REM            
CH21   CLM            
       LLS 3          
       PAX 0,4        
       TRA 1,2        
       REM            
CH22   CLM            
       LGL 3          
       PAX 0,4        
       TRA 1,2        
       REM            
WPRA   WPRA           
       RCHA CTWD      
       TCOA *         
       TRA 1,1      EXIT
WPR    WPRA           
       SPRA 4         
       TRA WPRA+1     
       REM            
TRAP   STO LOC+3      
       TRA CHK7A      
       REM            
REC1L  OCT 320,10001000,1000000
       OCT 4002000042,200000400400
       OCT 0,452010001005
       OCT 100000000000,0,540010001000
       OCT 14003400366,202000000401
REC1R  OCT 0,4000001000,0,100000200
       OCT 0,0,4240001000,400,0
       OCT 5000001600,000300000000
       OCT 40000000   
REC2L  OCT 200000000100,440001000
       OCT 200,0,40000000000
       OCT 100000000  
       OCT -500400001000,0,40
       OCT 100400001200
       OCT -400140000100
       OCT 240000000040
REC2R  OCT 20004000404 
       OCT 200040010000
       OCT 40010000110,0,0,0
       OCT 200042011020
       OCT 10000000000,200
       OCT 240050011020
       OCT 20004000504,10002000210
REC3L  OCT 100,14420001000
       OCT 200000000,0,40,200
       OCT 310420001010,4,-0
       OCT 10420001040,4200000004
       OCT -700000000310
       REM
REC3R  OCT 0,-400040000000,0
       OCT 5000000000,2000000000,0
       OCT -460440000000,0
       PON            
       OCT -402040000000
       OCT 4400000000,161000000000
REC4L  OCT -0,1040000,0,0
       OCT 200000100000,100000000000
       OCT 1000000,40000220000,0
       OCT 40001060000,200000200000
       OCT -500000100000
REC4R  OCT 0,400002104210
       OCT 40000000000,4
       OCT 20000000100,500002000
       OCT -604002144210,2201000000
       OCT 100020000000,-600302104210
       OCT 043000000000,124521042104
STOR   OCT 0         ACC CONTENTS
       OCT 0         MQ CONTENTS
       OCT 0         XRA AND XRB
       OCT 0         XRC, OVRL TRGS, TAPE CK
       OCT 0         PSE + MSE VALUES
       OCT 100000     
       OCT +6         
       OCT +1         
       OCT +4         
LOC    OCT 0         TEST LOC + ERROR ADDR
       OCT 0         DECREMENT CONTAINS 2,5
* COMPLEMENT OF LAST ROUTINE PREFORMED
       OCT 0         +0
       OCT 0         TRAP ROUTINE INDICATOR
       OCT +30        
       OCT 5          
       OCT -0         
       OCT 7          
BIT    OCT 400000000 BIT COL 10
       OCT 100000    BIT COL 21
       OCT 60         
       OCT 14         
       OCT 200000000 BIT COL 11
       OCT 10        BIT COL 33
       OCT 020000000000 BIT COL 5
       OCT 2000000   BIT COL 17
       OCT 1000      BIT COL 27
       OCT 40        BIT COL 31
       OCT 10000000  BIT COL 15
       OCT 17         
       OCT 010000000000
BIT2   OCT 002000000000 BIT COL 8
       OCT 400000    BIT COL 19
       OCT 1000000    
       OCT 100020000000
MASK   OCT 777017601777 TEST LOC ETC
       OCT 407760001700
       OCT -760760001760 MQ ETC
       OCT 374077017776
       REM              MAKE FOR REC3
       OCT -756720001776 ACC AND TRIGGER
       OCT -777670000000
       OCT -741777777777 I/O ETC
       OCT -740774077777
       OCT -760001760000 MASK FOR 4TH REC
       OCT -777773567356 MASK
       REM            
       OCT 000003204020
       OCT 1000100000,20000400
       OCT 00100430000 
       OCT 100004000342,-400040002001
       OCT 1200100004,200000000000
       OCT 10         
       OCT 201000120004
       OCT -400163614120
P92    OCT 100204002653
       OCT -400020000220,400040000
       OCT 0,140001400 
       OCT 200000000010,10000102
       OCT 100400040000,0,4
P93    OCT 500041000  
       OCT -400060000620
P95    OCT 300010000116
CTWD   HTR PR,0,24    CONTROL WORD FOR PRINTING
PR     OCT            PRINT IMAGE
       REM
       REM
       REM
       BSS 23
       ORG PR+24
0A     HED         
OCTTH  OCT 0
CBIT   OCT 0
OCTAD  BSS 19
*
*  IMAGE --           
**   00000   START KEY RESET-SECTION 1 COMPLETE
       REM            
SECN1  OCT 000004020010  9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 400000100000  8 L
       OCT 000000000000  8 R
       OCT 000000000000  7 L
       OCT 010000000000  7 R
       OCT 000000000004  6 L
       OCT 040000000000  6 R
       OCT 000000212102  5 L
       OCT 002400000000  5 R
       OCT 400000000000  4 L
       OCT 020000000000  4 R
       OCT 000022001060  3 L
       OCT 105000000000  3 R
       OCT 000040404200  2 L
       OCT 000000000000  2 R
       OCT 000010000000  1 L
       OCT 400000000000  1 R
       OCT 000062105220  0L
       OCT 001000000000  0 R
       OCT 400004420006  11 L
       OCT 074000000000  11 R
       OCT 000010212150  12 L
       OCT 102400000000  12 R
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
*  IMAGE --           
**   00000   INITAL 755 AND 766-SECTION 2 COMPLETE
       REM            
       REM            
       REM            
SECN2  OCT 000052000000  9 ROW LEFT
       OCT 400000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000000000000  8 R
       OCT 000000100200  7 L
       OCT 000400000000  7 R
       OCT 000000000140  6 L
       OCT 202000000000  6 R
       OCT 000020062004  5 L
       OCT 100120000000  5 R
       OCT 400000001000  4 L
       OCT 001000000000  4 R
       OCT 000004400003  3 L
       OCT 004240000000  3 R
       OCT 000000000010  2 L
       OCT 020000000000  2 R
       OCT 000001004000  1 L
       OCT 000000000000  1 R
       OCT 000004000011  0L
       OCT 000040000000  0 R
       OCT 400020402020  11 L
       OCT 303600000000  11 R
       OCT 000053005006  12 L
       OCT 404120000000  12 R
       REM            
*  IMAGE --           
**   00000   INITIAL CARD MACHINES-SECTION 3 COMPLETE
       REM            
SECN3  OCT 000052020100  9 ROW LEFT
       OCT 100000000000  9 ROW RIGHT
       OCT 400000000200  8 L
       OCT 000000000000  8 R
       OCT 000000000000  7 L
       OCT 000100000000  7 R
       OCT 000000000000  6 L
       OCT 040400000000  6 R
       OCT 000020000061  5 L
       OCT 020024000000  5 R
       OCT 400000012000  4 L
       OCT 000200000000  4 R
       OCT 000004500400  3 L
       OCT 605050000000  3 R
       OCT 000000000012  2 L
       OCT 000000000000  2 R
       OCT 000001041000  1 L
       OCT 000000000000  1 R
       OCT 00004000012   0L
       OCT 200010000000  0 R
       OCT 400020422044  11 L
       OCT 060740000000  11 R
       OCT 000053151721  12 L
       OCT 501024000000  12 R
       REM            
*  IMAGE --           
**   00000   ALL DRUMS TESTED-SECTION 4 COMPLETE 
       REM            
SECN4  OCT 000001000004  9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000000000000  8 R
       OCT 000000000000  7 L
       OCT 004000000000  7 R
       OCT 000000000002  6 L
       OCT 020000000000  6 R
       OCT 000000011041  5 L
       OCT 001200000000  5 R
       OCT 400002600400  4 L
       OCT 210000000000  4 R
       OCT 000030022030  3 L
       OCT 042400000000  3 R
       OCT 000000104100  2 L
       OCT 000000000000  2 R
       OCT 000040000000  1 L
       OCT 000000000000  1 R
       OCT 000000526110  0L
       OCT 000400000000  0 R
       OCT 400031200203  11 L
       OCT 036000000000  11 R
       OCT 000042011464  12 L
       OCT 041200000000  12 R
       REM            
*  IMAGE --           
**   00000   DRUM AND I/O SELECTION INTERLOCK-SECTION 5 COMPLETE
       REM            
SECN5  OCT 000020040021  9 ROW LEFT
       OCT 040020000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000000000000  8 R
       OCT 000000000000  7 L
       OCT 000000020000  7 R
       OCT 000000010010  6 L
       OCT 010010100000  6 R
       OCT 000000401204  5 L
       OCT 500205005000  5 R
       OCT 400054200000  4 L
       OCT 000000040000  4 R
       OCT 000000000540  3 L
       OCT 224140212000  3 R
       OCT 000000002000  2 L
       OCT 002400000000  2 R
       OCT 000001020000  1 L
       OCT 000000000000  1 R
       OCT 000010022040  0L
       OCT 200440002000  0 R
       OCT 400024410414  11 L
       OCT 473014170000  11 R
       OCT 000041241321  12 L
       OCT 104320205000  12 R
       REM            
*  IMAGE --           
**   00000   CRT-ALL DISPLAYS-SECTION 6 COMPLETE 
       REM            
SECN6  OCT 000020040004  9 ROW LEFT
       OCT 000000000000  9 ROW RIGHT
       OCT 400000001000  8 L
       OCT 000000000000  8 R
       OCT 000000010000  7 L
       OCT 004000000000  7 R
       OCT 000000000002  6 L
       OCT 220000000000  6 R
       OCT 000000000041  5 L
       OCT 001200000000  5 R
       OCT 400000100000  4 L
       OCT 010000000000  4 R
       OCT 000051404030  3 L
       OCT 042400000000  3 R
       OCT 000000020500  2 L
       OCT 000000000000  2 R
       OCT 000002002000  1 L
       OCT 000000000000  1 R
       OCT 000010021510  0L
       OCT 000400000000  0 R
       OCT 400025414203  11 L
       OCT 036000000000  11 R
       OCT 000042142064  12 L
       OCT 041200000000  12 R
       REM            
*  IMAGE --           
**   00000   WRITE TAPE AND WTITE PRINTER-SECTION 7 COMPLETE
       REM            
SECN7  OCT 000030000303  9 ROW LEFT
       OCT 040400000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000000000000  8 R
       OCT 000000100004  7 L
       OCT 000020400000  7 R
       OCT 000040000400  6 L
       OCT 000202000000  6 R
       OCT 000002044020  5 L
       OCT 504100120000  5 R
       OCT 400000002000  4 L
       OCT 000001000000  4 R
       OCT 000004400040  3 L
       OCT 203004240000  3 R
       OCT 000000000000  2 L
       OCT 010000000000  2 R
       OCT 000000210000  1 L
       OCT 000000000000  1 R
       OCT 000044400440  0L
       OCT 211000040000  0 R
       OCT 400020104206  11 L
       OCT 460303600000  11 R
       OCT 000012252121  12 L
       OCT 106404120000  12 R
       REM            
*  IMAGE --           
**   00000   READ TAPE AND READ PRINTER-SECTION 8 COMPLETE
       REM            
SECN8  OCT 000040001014  9 ROW LEFT
       OCT 202000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000100000000  8 R
       OCT 000000200020  7 L
       OCT 000002000000  7 R
       OCT 000000000000  6 L
       OCT 001010000000  6 R
       OCT 000020110402  5 L
       OCT 420400500000  5 R
       OCT 400004004100  4 L
       OCT 000004000000  4 R
       OCT 000001000001  3 L
       OCT 014021200000  3 R
       OCT 000000000000  2 L
       OCT 040000000000  2 R
       OCT 000010420200  1 L
       OCT 000000000000  1 R
       OCT 00001000001   0L
       OCT 044000200000  0 R
       OCT 400040211032  11 L
       OCT 301417000000  11 R
       OCT 000034524704  12 L
       OCT 432020500000  12 R
       REM            
*  IMAGE --           
**   00000   WRITE TAPE ALL CHANNELS-SECTION 9 COMPLETE
       REM            
SECN9  OCT 000030000000  9 ROW LEFT
       OCT 021000000000  9 ROW RIGHT
       OCT 400000000200  8 L
       OCT 000000000000  8 R
       OCT 000000100000  7 L
       OCT 000020000000  7 R
       OCT 000040000000  6 L
       OCT 010100000000  6 R
       OCT 000002040070  5 L
       OCT 204005000000  5 R
       OCT 400000000000  4 L
       OCT 000040000000  4 R
       OCT 000004406404  3 L
       OCT 140212000000  3 R
       OCT 000000000002  2 L
       OCT 400000000000  2 R
       OCT 000000210100  1 L
       OCT 000000000000  1 R
       OCT 000044400002  0L
       OCT 440002000000  0 R
       OCT 400020106065  11 L
       OCT 014170000000  11 R
       OCT 000012250710  12 L
       OCT 320205000000  12 R
       REM            
*  IMAGE --           
**   00000   READ TAPE AND READ PUNCH-SECTION 10 COMPLETE
       REM            
SEC10  OCT 000040000600  9 ROW LEFT
       OCT 004000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 400000000000  8 R
       OCT 000000200010  7 L
       OCT 000002000000  7 R
       OCT 000000001000  6 L
       OCT 002010000000  6 R
       OCT 000020110042  5 L
       OCT 041000500000  5 R
       OCT 400004004004  4 L
       OCT 000004000000  4 R
       OCT 000001000101  3 L
       OCT 030021200000  3 R
       OCT 000000000000  2 L
       OCT 100000000000  2 R
       OCT 000010420000  1 L
       OCT 000200000000  1 R
       OCT 000001001104  0L
       OCT 110100200000  0 R
       OCT 400040210412  11 L
       OCT 203017000000  11 R
       OCT 000034524241  12 L
       OCT 464020500000  12 R
       REM            
*  IMAGE --           
**   00000   WRITE TAPE AND READ TAPE-SECTION 11 COMPLETE
       REM            
SEC11  OCT 000030000400  9 ROW LEFT
       OCT 010000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000000000000  8 R
       OCT 000000100002  7 L
       OCT 000004000000  7 R
       OCT 000040000000  6 L
       OCT 004020000000  6 R
       OCT 000002044201  5 L
       OCT 102001200000  5 R
       OCT 400000002040  4 L
       OCT 000010000000  4 R
       OCT 000004400010  3 L
       OCT 060042400000  3 R
       OCT 000000000000  2 L
       OCT 200000000000  2 R
       OCT 000000210104  1 L
       OCT 000600000000  1 R
       OCT 000044400010  0L
       OCT 220000400000  0 R
       OCT 400020104402  11 L
       OCT 406036000000  11 R
       OCT 000012252345  12 L
       OCT 150041200000  12 R
       REM            
*  IMAGE --           
**   00000   READ TAPE AND WRITE PRINTER-SECTION 12 COMPLETE
       REM            
SEC12  OCT 000040000606  9 ROW LEFT
       OCT 101000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000000000000  8 R
       OCT 000000200010  7 L
       OCT 000000400000  7 R
       OCT 000000001000  6 L
       OCT 000402000000  6 R
       OCT 000020110041  5 L
       OCT 210200120000  5 R
       OCT 400004004000  4 L
       OCT 000001000000  4 R
       OCT 000001000100  3 L
       OCT 406004240000  3 R
       OCT 000000000000  2 L
       OCT 020020000000  2 R
       OCT 000010420000  1 L
       OCT 000040000000  1 R
       OCT 000001001100  0L
       OCT 422000040000  0 R
       OCT 400040210415  11 L
       OCT 140603600000  11 R
       OCT 000034524242  12 L
       OCT 215004120000  12 R
       REM            
*  IMAGE --           
**   00000   WRITE TAPE AND WRITE PUNCH-SECTION 13 COMPLETE
       REM            
SEC13  OCT 000030000300  9 ROW LEFT
       OCT 002000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 200000000000  8 R
       OCT 000000100004  7 L
       OCT 000001000000  7 R
       OCT 000040000400  6 L
       OCT 001004000000  6 R
       OCT 000002044021  5 L
       OCT 020400240000  5 R
       OCT 400000002002  4 L
       OCT 000002000000  4 R
       OCT 000004400040  3 L
       OCT 414050500000  3 R
       OCT 000000000000  2 L
       OCT 040000000000  2 R
       OCT 000000210000  1 L
       OCT 000100000000  1 R
       OCT 000044400442  0L
       OCT 044000100000  0 R
       OCT 400020104205  11 L
       OCT 101407400000  11 R
       OCT 000012252120  12 L
       OCT 632010240000  12 R
       REM            
*  IMAGE --           
**   00000   WRITE TAPE AND READ PRINTER-SECTION 14 COMPLETE
       REM            
SEC14  OCT 000030000406  9 ROW LEFT
       OCT 101000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000000000000  8 R
       OCT 000000100010  7 L
       OCT 000000400000  7 R
       OCT 000040000000  6 L
       OCT 000402000000  6 R
       OCT 000002044201  5 L
       OCT 210200120000  5 R
       OCT 400000002040  4 L
       OCT 000021000000  4 R
       OCT 000004400000  3 L
       OCT 406004240000  3 R
       OCT 000000000000  2 L
       OCT 020000000000  2 R
       OCT 000000210100  1 L
       OCT 000040000000  1 R
       OCT 000044400000  0L
       OCT 422000040000  0 R
       OCT 400020104415  11 L
       OCT 140603600000  11 R
       OCT 000012252342  12 L
       OCT 215004120000  12 R
       REM            
*  IMAGE --           
**   00000   WRITE PR BINARY AND READ TAPE-IND 19-SECTION 15 COMPLETE
       REM            
SEC15  OCT 000030222010  9 ROW LEFT
       OCT 004101000000  9 ROW RIGHT
       OCT 400000001000  8 L
       OCT 000000000000  8 R
       OCT 000000400000  7 L
       OCT 040000000400  7 R
       OCT 000040000000  6 L
       OCT 000000402000  6 R
       OCT 000002010104  5 L
       OCT 022010220120  5 R
       OCT 400000000041  4 L
       OCT 001000001000  4 R
       OCT 000004000000  3 L
       OCT 200006004240  3 R
       OCT 000000040000  2 L
       OCT 000020000000  2 R
       OCT 000000004202  1 L
       OCT 100200040000  1 R
       OCT 000044001000  0L
       OCT 200022000040  0 R
       OCT 400020612110  11 L
       OCT 052040603600  11 R
       OCT 000012064247  12 L
       OCT 125015004120  12 R
       REM            
*  IMAGE --           
**   00000   READ TAPE CONCURRENTLY-SECTION 16 COMPLETE
       REM            
SEC16  OCT 000040000600  9 ROW LEFT
       OCT 040000000000  9 ROW RIGHT
       OCT 400000000004  8 L
       OCT 000000000000  8 R
       OCT 000000200000  7 L
       OCT 000020000000  7 R
       OCT 000000010000  6 L
       OCT 021100000000  6 R
       OCT 000020104140  5 L
       OCT 410005000000  5 R
       OCT 400004001000  4 L
       OCT 000040000000  4 R
       OCT 000001022030  3 L
       OCT 300212000000  3 R
       OCT 000000000001  2 L
       OCT 000000000000  2 R
       OCT 000010400000  1 L
       OCT 002000000000  1 R
       OCT 000001001025  0L
       OCT 100002000000  0 R
       OCT 400040214652  11 L
       OCT 030170000000  11 R
       OCT 000034522100  12 L
       OCT 640205000000  12 R
       REM            
*  IMAGE --           
**   00000   READ CARDS AND WRITE TAPE-SECTION 17 COMPLETE
       REM            
SEC17  OCT 000040200300  9 ROW LEFT
       OCT 004000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000000000000  8 R
       OCT 000000000001  7 L
       OCT 000102000000  7 R
       OCT 000000000400  6 L
       OCT 002010000000  6 R
       OCT 000020004020  5 L
       OCT 441000500000  5 R
       OCT 400004102000  4 L
       OCT 000004000000  4 R
       OCT 000001000044  3 L
       OCT 030021200000  3 R
       OCT 000000040000  2 L
       OCT 100000000000  2 R
       OCT 000010410002  1 L
       OCT 000200000000  1 R
       OCT 000000040444  0L
       OCT 110000200000  0 R
       OCT 400040204201  11 L
       OCT 203017000000  11 R
       OCT 000035512122  12 L
       OCT 464020500000  12 R
       REM            
*  IMAGE --           
**   00000   READ TAPE AND READ CARDS-SECTION 18 COMPLETE
       REM            
SEC18  OCT 000040001004  9 ROW LEFT
       OCT 010000000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000200000000  8 R
       OCT 000000200000  7 L
       OCT 000004000000  7 R
       OCT 000000000000  6 L
       OCT 004020000000  6 R
       OCT 000020110400  5 L
       OCT 102001200000  5 R
       OCT 400004004102  4 L
       OCT 000010000000  4 R
       OCT 000001000020  3 L
       OCT 060042400000  3 R
       OCT 000000000001  2 L
       OCT 200000000000  2 R
       OCT 000010420210  1 L
       OCT 000400000000  1 R
       OCT 000001000001  0L
       OCT 220000400000  0 R
       OCT 400040211004  11 L
       OCT 406036000000  11 R
       OCT 000034524732  12 L
       OCT 150041200000  12 R
       REM            
*  IMAGE --           
**   00000   READ CARDS AND WRITE TAPE-SECTION 19 COMPLETE
       REM            
SEC19  OCT 000040200300  9 ROW LEFT
       OCT 004100000000  9 ROW RIGHT
       OCT 400000000000  8 L
       OCT 000000000000  8 R
       OCT 000000000001  7 L
       OCT 000002000000  7 R
       OCT 000000000400  6 L
       OCT 002010000000  6 R
       OCT 000020004020  5 L
       OCT 441000500000  5 R
       OCT 400004102000  4 L
       OCT 000004000000  4 R
       OCT 000001000044  3 L
       OCT 030021200000  3 R
       OCT 000000040000  2 L
       OCT 100000000000  2 R
       OCT 000010410002  1 L
       OCT 000200000000  1 R
       OCT 000000040444  0L
       OCT 110000200000  0 R
       OCT 400040204201  11 L
       OCT 203017000000  11 R
       OCT 000035512122  12 L
       OCT 464020500000  12 R
       REM            
END    OCT 0            9L
       OCT 200000000000 9R
       OCT 0            8L
       OCT 40201000000  8R
       OCT 40100        7L
       OCT 0            7R
       OCT 400          6L
       OCT 0            6R
       OCT 24           5L
       OCT 20400000     5R
       OCT 200          4L
       OCT 10000000     4R
       OCT 1050         3L
       OCT 42200000     3R
       OCT 14000        2L
       OCT 100500100000 2R
       OCT 20000        1L
       OCT 30000000000  1R
       OCT 14010        0L
       OCT 140740000000 0R
       OCT 40741        11L
       OCT 2010100000   11R
       OCT 21024        12L
       OCT 10023600000  12R
       REM            
       REM            
SHOOK  IOCP WRIT2,0,18 WRITE 9L-1R
       IOCP E84,0,2   8-4L-8-4R ECHO
       IOCP WRIT2+18,0,2 WRITE 0R-0L
       IOCP E83,0,2   8-3L-8-3R ECHO
       IOCP WRIT2+20,0,2 WRITE 11L-11R
       IOCP ECHO,0,2  9L-9R ECHO
       IOCP WRIT2+22,0,2 WRITE 12L-12R
       IOCP ECHO+2,0,2 8L-8R ECHO
       IOCD ECHO+4,0,14 7L-1R ECHO
       REM            
ECHOS  CAL ECHO+2     8L
       ACL E83        8-3L
       ACL E84        8-4L
       SLW ECHO+2     8L
       REM            
       CAL ECHO+3     8R
       ACL E83+1      8-3R
       ACL E84-+1     8-4R
       SLW ECHO+3     8R
       REM            
       CAL ECHO+12    3L
       ACL E83        8-3L
       SLW ECHO+12    3L
       REM            
       CAL ECHO+13    3R
       ACL E83+1      8-3R
       SLW ECHO+13    3R
       REM            
       CAL ECHO+10    4L
       ACL E84        8-4L
       SLW ECHO+10    4L
       REM            
       CAL ECHO+11    4R
       ACL E84+1      8-4R
       SLW ECHO+11    4R
       TRA 1,2        EXIT
       REM            
       REM            
ECHCS  CAL ECHOC+2    8L
       ACL EC83       8-3L
       ACL EC84       8-4L
       SLW ECHOC+2    8L
       REM            
       CAL ECHOC+3    8R
       ACL EC83+1     8-3R
       ACL EC84+1     8-4R
       SLW ECHOC+3    8R
       REM            
       CAL ECHOC+12   3L
       ACL EC83       8-3L
       SLW ECHOC+12   3L
       REM            
       CAL ECHOC+13   3R
       ACL EC83+1     8-3R
       SLW ECHOC+13   3R
       REM            
       CAL ECHOC+10   4L
       ACL EC84       8-4L
       SLW ECHOC+10   4L
       REM            
       CAL ECHOC+11   4R
       ACL EC84+1     8-4R
       SLW ECHOC+11   4R
       TRA 1,2        EXIT
       REM            
       REM            
ECHES  CAL ECHOE+2    8L
       ACL EE83       8-3L
       ACL EE84       8-4L
       SLW ECHOE+2    8L
       REM            
       CAL ECHOE+3    8R
       ACL EE83+1     8-3R
       ACL EE84+1     8-4R
       SLW ECHOE+3    8R
       REM            
       CAL ECHOE+12   3L
       ACL EE83       8-3L
       SLW ECHOE+12   3L
       REM            
       CAL ECHOE+13   3R
       ACL EE83+1     8-3R
       SLW ECHOE+13   3R
       REM            
       CAL ECHOE+10   4L
       ACL EE84       8-4L
       SLW ECHOE+10   4L
       REM            
       CAL ECHOE+11   4R
       ACL EE84+1     8-4R
       SLW ECHOE+11   4R
       TRA 1,2        EXIT
       REM            
       REM            
BCDTA  BCD 1RTBA      
       WTBA           
BCDTB  BCD 1RTBB      
       WTBB           
BCDTC  BCD 1RTBC      
       WTBC           
BCDTD  BCD 1RTBD      
       WTBD           
BCDTE  BCD 1RTBE      
       WTBE           
BCDTF  BCD 1RTBF      
       WTBF           
BCDD   BCD 1WTBD      
       WTBD           
BCDF   BCD 1WTBF      
       WTBF           
       REM            
OMY    MON 0,0,3      
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
       REM            
       ORG 32767-3377 
BCD1   TRA YALE-4     
BCD2   TRA C          
SAVE   OCT 0          
SAVE1  OCT 0          
SAVE2  OCT 0          
IIL    IIL            
ADDR   OCT 7777777    
IIR    IIR            
CO22   OCT 22000000   
BIT35  OCT 1          
DELAY  OCT 7777004673 CONSTANT FOR DELAY
FIX    OCT 010101010101
       OCT 020202020202
       OCT 030303030303
       OCT 040404040404
       OCT 050505050505
       OCT 060606060606
       OCT 070707070707
       OCT 101010101010
       OCT 111111111111
       OCT 121212121212
       OCT 131313131313
       OCT 141414141414
       OCT 151515151515
       OCT 161616161616
       OCT 171717171717
       OCT 202020202020
       OCT 212121212121
       OCT 222222222222
       OCT 232323232323
       OCT 242424242424
       OCT 252525252525
       OCT 262626262626
       OCT 272727272727
       OCT 303030303030
       OCT 313131313131
       OCT 323232323232
       OCT 333333333333
       OCT 343434343434
       OCT 353535353535
       OCT 363636363636
       OCT 373737373737
       OCT 404040404040
       OCT 414141414141
       OCT 424242424242
       OCT 434343434343
       OCT 444444444444
       OCT 454545454545
       OCT 464646464646
       OCT 474747474747
       OCT 505050505050
       OCT 515151515151
       OCT 525252525252
       OCT 535353535353
       OCT 545454545454
       OCT 555555555555
       OCT 565656565656
       OCT 575757575757
       OCT 606060606060
       OCT 616161616161
       OCT 626262626262
       OCT 636363636363
       OCT 646464646464
       OCT 656565656565
       OCT 666666666666
       OCT 676767676767
       OCT 707070707070
       OCT 717171717171
       OCT 727272727272
       OCT 737373737373
       OCT 747474747474
       OCT 757575757575
       OCT 767676767676
       OCT 777777777777
       OCT 010101010100
       REM            
CTAPE  CLA TPSEL      CHANNEL A, UNIT 1, SELECT
       STO EFP+5      CHANGE CARD
       STO SW6+4      SELECT AT SWITCH 6
       CLA CTRL1      RESTORE CONTROL 1
       TRA TCW1+2     
       REM            
TPSEL  RTBA 1         
       REM            
THSVN  OCT 400000037  
TEN    OCT 100000004  
RDTP   IORP RDFLD,0,0 SHOULD NOT TRANSMIT ON
       REM            THIS CONTROL WORD
       IOCD RDFLD+32,0,224 SHLD RD TWO 40 WD REC
       REM            ONE 200 WRD REC AND
       REM            TWO 40 WRD RECS
*CONTROL FOR WRITING PRINTER DURING LONG ADDER TEST
       REM            
SHIMG  IOCP WRIT2,0,24 PRINT FIRST LINE
       IOCP WRIT2,0,24 PRINT SECOND LINE
       IOCD WRIT2,0,24 PRINT THIRD LINE
       REM            
*CONTROL FOR WRITING TAPE DURING LONG ADDER TEST
       REM            
       IORP WRFLD,0,256 WRITE FIRST RECORD
       IORP WRFLD,0,256 WRITE SECOND RECORD
       IOCD WRFLD,0,256 WRITE THIRD RECORD
       REM            
*CONTROL FOR READING TAPE AT LOCATION - UGO
       REM            
       IOCD RDFLD,0,256 READ 400 FIXED NOS
       REM            
RCDA   IOCP RCD,0,24  
       IOCD RCD,0,24  
       REM            
*WRITE PRITER BINARY CONTROL
       IOCP WRIT2+3,0,2
       IOCP WRIT2+21,0,2
       IOCD FIX+60,0,2 
       REM            
*CONTROLS FOR WRITING TAPE AT LOCATION - VILE 3
       REM            
WTB1   IORP WRFLD,0,32 WRITE 1ST-40 WORD REC
       IORP WRFLD+32,0,32 WRITE 2ND-40 WORD REC
       IORP WRFLD+64,0,32 WRITE 3RD-40 WORD REC
       IORP WRFLD+96,0,956 WRITE 4TH-140 WORD REC
       IORP WRFLD+192,0,32 WRITE 5TH-40 WORD REC
       IOCD WRFLD+224,0,32 WRITE 6TH-40 WORD REC
WRIT2  OCT 0,0,0,0,0,0,0,0,0,0,0,0 SHIFTING
       OCT 0,0,0,0,0,0,0,0,0,0,0,0 IMAGE
       REM            
*CONTROLS FOR READ PRINTER
       REM            
SHAKE  IOST WRIT2,0,2 PRINT 9L-9R
       IOSP WRIT2+2,0,2 8L-8R
       TCH INDA,0,24  INDIRECT ADDRESS
       IORT WRIT2+4,0,20 7L-12R
       IOCD 0         
       IOST WRIT2,0,16 WRITE 9L-2R
       IOCD 0         
       TCH *+2        INDIRECT ADDRESS
       IOCD 0         
       IOCP WRIT2+16,0,2 WIRTE 1L-1R
       IOCP E84,0,2   8-4L - 8-4R ECHO
       IOCT WRIT2+18,0,2 WRITE 0L-0R
       IOCD 0         
       IOCP E83,0,2   8-3L - 8 - 3R ECHO
       IOCT WRIT2+20,0,2 WRITE 11L-11R
       IOCP ECHO,0,1  9L ECHO
       IOCP ECHO+1,0,1 9R ECHO
       IOST WRIT2+22,0,2 WRITE 12L-12R
       IOSP ECHO+2,0,2 8L-8R ECHO
       IOCP ECHO+4,0,14 7L-1R ECHO
       TCH *+2        IND. ADDR. TO SCH1-1
       IOCD 0         
       IOCD 0         
       REM            
*CORRECT CONTENTS SCH TEST
       REM            
SCH1   IORT WRIT2+24,0,SHAKE+4
SCH2   IOCD 0,0,SCH1  
INDA   TCH SHAKE+3,0,24 DOUBLE IND ADDR
CNTL   IOCD ONES,0,1  WRITE ONE WORD-ONES
       IOCD ZEROS,0,1 WRITE ONE WORD-ZEROS
CNTLR  IOCD READ,0,1  READ ONE WORD
       IOCD READ,0,2  READ ONE REC AND BCD EOF
       IOCD READ+2,0,2 READ ONE REC AND BIN EOF
       REM            
*CONTROL FOR WRITE PUNCH AT LOCATION-CRAZY+8
       REM            
CNTLW  IOCT IRAN,0,2  WRITE PUNCH-9L-9R
       IOCT IRAN+2,0,2 8L-8R
       IOCP IRAN+4,0,2 7L-7R
       TCH CNTLW+4    IND. ADDR. TO NEXT LOC.
       IOSP IRAN+6,0,2 6L-6R
       IORT IRAN+8,0,16 5L-12R
TPCTL  IOCD WRFLD,0,256 WRITE 400 FIXED NOS
       REM            
*CONTROL FOR WRITING PUNCH WHILE READING TAPE
       REM            
WPUA   IOSP WRFLD,0,10 PUNCH 12 WORDS
       IORP WRFLD+10,0,16 WRITE EOR
       IOCD           
ONES   OCT 777777777777
ZEROS  OCT 0          
READ   OCT 0          
       OCT 0          
       OCT 0          
       OCT 0          
FPCON  DEC 2.0        
       OCT 233000000000
       DEC 16.0       
       DEC 4.0        
       DEC 1.0,4.0,3.0,4.0,2.0,-1.0,-3.0
       DEC 1.0,6.0,-40.0,196.0,14.0,4.0,-10.0
       DEC 1.0,10.0,-144.0,676.0,26.0,8.0,-18.0
COEF   DEC 1.0        
SAY    OCT 002000000000
       REM            
*ADDRESS OF TEST THAT LAST ENTERED CLEAR GOES IN
*DECREMENT OF MONIT IN TWOS COMP. FORM
       REM            
MONIT  OCT 0          
       REM            
K41    OCT 200        
KK     OCT 000777777777BLANK CHAR
TWO    HTR 2          
Q      OCT 0          
CCH    OCT 200000000000
CCH1   OCT 147000000000
BIN    OCT 0          
       REM            
PREA   BCD 1RPRA      
PREC   BCD 1RPRC      
PREE   BCD 1RPRE      
CRCA   BCD 1RCDA      
CRCC   BCD 1RCDC      
CRCE   BCD 1RCDE      
TP19B  BCD 1IN19 B    
TP19D  BCD 1IN19 D    
TP19F  BCD 1IN19 F    
CNT1   OCT 0          
CNT2   OCT 100        
STPCT  OCT 0          
       REM            
RDNA   BSS 24         
RDNA1  BSS 24         
       REM            
RANOS  OCT -152347011427 INITIAL RAND. NO.
SCHA   IORT IRAN+24,0,CNTLW+6
RST    OCT 0          TEMPORARY STORAGE
       REM            
*CONTROL FOR WRITE PUNCH ATLOCATION-XTRA+11
       REM            
SHIM   IORT WRIT2,0,24 PUNCH ONE BCD CARD
       REM            
WRITE  OCT 1001002001   9L
       OCT 200200       9R
       OCT 2002004002   8L
       OCT 077600400401 8R
       OCT 4004010004   7L
       OCT 1001002      7R
       OCT 10010020010  6L
       OCT 2002004      6R
       OCT 20020040020  5L
       OCT 4004010      4R
       OCT 40040100040  4L
       OCT 74010010020  4R
       OCT 100100200100 3L
       OCT 3620020040   3R
       OCT 200200400200 2L
       OCT 40040100     2R
       OCT 400400000400 1L
       OCT 100100100000 1R
       OCT 777000       0L
       OCT 111000000177 0R
       OCT 777000000    11L
       OCT 220400177600 11R
       OCT 777000000000 12L
       OCT 440377600000 12R
ECHO   OCT 0,0,0,0,0,0,0,0,0,0,0,0
       OCT 0,0,0,0,0,0
E83    OCT 0,0        
E84    OCT 0,0        
TWTWO  OCT 22         
ZERO   OCT 0          
ONE    OCT 1          
       REM            
GO     IOCD WRFLD,0,256 WRITE 400 WORD REC
       REM            
*READ TAPE CONTROL-INDICATOR 19
       REM            
IND19  IOCT RDFLD,2,1 SKIP ONE WORD
       TCH IND19+3,2,2 TEST IND 19 WITH IND ADDR
       IOCD           
       IOCP RDFLD+1,0,42 READ 42 WORDS
       IOCP RDFLD+43,2,42 SKIP 42 WORDS
       IOSP RDFLD+85,0,42 READ 42 WORDS
       IOSP RDFLD+127,2,42 SKIP 42 WORDS
       IOSP RDFLD+169,0,42 READ 42 WORDS
       IORT RDFLD+211,2,100 SKIP REMNDR OF REC
       REM
SRD    IOCD RDFLD,0,192 READ TAPE
SRD1   IOCD RDFLD+192,0,64 READ TAPE
       NOP NOISE+16   
       REM            
1ST    OCT 010304051011
2ND    OCT 061101051103
TABLE  TIX TABLE-16,0,25 TABLE
       TIX TABLE-8,0,30 FOR
       TIX TABLE-2,0,36 CONVERT
       TIX TABLE-8,0,50 BY REPLACEMENT
       TIX TABLE-2,0,100 FROM
       TIX TABLE-2,0,1000 ACCUMULATOR
       REM            
TBLE1  TIX TBLE1-11,0,40 TABLE
       TIX TBLE1-3,0,11 FOR
       TIX TBLE1-7,0,20 USE
       TIX TBLE1-13,0,60 BY
       TIX TBLE1-7,0,30 CRQ
       TIX TBLE1-12,0,40 INSTRUCTION
       REM            
K16    OCT 010203040506
       TIX K16,0,4096 TABLE
       TIX K16,0,8192 FOR
       TIX K16,0,12288 USE
       TIX K16,0,16384 BY
       TIX K16,0,20480 CAQ
       TIX K16,0,24576 INSTRUCTION
       REM            
CATCH  TSX SPACE,4    
       TTR SEQ        
       REM            
STCTL  IOCD START,0,24 
       REM            
ENCTL  IOCD END,0,24  
       REM            
ITS    CAL CATCH      L TSX SPACE,4
       AXT 32767-OMY,1 FILL UPPER
       STO 0,1        STORAGE
       TIX *+1,1,1    
       TXH ITS+2,1,32768-BCD1+2
       REM            
       AXT 23,1       FILL STORAGE
       STO 24,1       OVER LOADER
       TIX *-1,1,1    
       CLA CATCH+1    L TTR SEQ
       STO 8          
       REM            
       CLA STPCT      RESTORE
       STO TPCNT      TAPE COUNT
       REM            
       CLA RSET       
       STO 0          
       STZ 1          
       TRA TOV-4      
       REM            
       REM            
*F.P. TRAP SEQUENCE-MONITOR
       REM            
SEQ    LTM            JUST IN CASE
       SLT 4          WAS TRAP EXPECTED
       TXI WHAT,0,32767 NO,ERROR
       SLN 4          YES-TRAP EXPECTED
       TXH XRCE,4,0   IF XRC STILL ZERO
       LXA 0,4        OK
       SXD SAVE4+2,4  SAVE TRAP ADDRESS
       LXD SECT2,4    CLEA XRC
SECT2  TXI 0          RETURN
       REM            
WHAT   SXD TRAP-2,1   LITE 4 WAS OFF
       LXA 0,1        WAS AN ADDRESS PUT AT 0
       TXL OUTER,1,0  IF NOT-ERROR
SAVE4  SXD FREE,1     IS SO,IS IT#LAST
       LDC FREE,1     TRAP ADDRESS
       TXI *+1,1,0    
       TXL OUTER,1,0  IF ZERO,NO TRAP
       REM            BUT SKIPPED TO SPACE
       REM            
       LXA 0,1        
       SXD SAVE4+2,1  SAVE TRAP ADDRESS
       LXD TRAP-2,1   RESTORE XRA
       TXI FADED      TRAP ERROR
       REM            
       BCD 1FP TRP    
       REM            
TRAP   LXA 0,4        RETURN TO PROG
       SXA *+2,4      
       LXD *+1,4      RESTORE XRC
       TXI            RETURN
       REM            
FADED  SXD *-1,4      SAVE XRC
       TSX ERROR-1,4  TRAP IN ERROR
       TRA TRAP       TRA TO 10 IS ILLEGAL
       TRA TRAP       SEE ADDRESS AT ZERO
       REM            
XRCE   SXD FREE,2     SAVE XRB
       SXD FREE+1,4   AND XRC
       LXD FREE+1,2   MOVE XRC TO XRB
       TXI *+2        
       REM            
       BCD 1ITIME-    
       REM            
       TSX ERROR-1,4  XRC WAS NOT ZERO
       REM            
*ALL LEGAL TRAPS OCCUR WHEN XRC#0. IF XRC IS NOT#0,
*THEN EITHER TRAP OCCURED WHEN IT SHOULD NOT HAVE,
*OR XRC WAS CHANGED BY THE TRAP OPERATION. THE
*VALUE WHICH WAS LOADED INTO XRC HAS BEEN MOVED
*TO XRB. ZERO HAS THE ERROR LOCATION +1.
       REM            
       NOP XRCE+5     
       LXA 0,4        SAVE TRAP
       SXD SAVE4+2,4  ADDRESS
       LXD FREE,2     RESTORE XRB
       TRA SECT2-1    RETURN TO TRAP PROG
OUTER  LXD TRAP-2,1   RESTORE XRA
       TSX SPACE,4    GOT TO 10 BY MISTAKE
       REM            
       BCD 1SPACE     
       REM            
SPACE  SXD BIN,4      SPACE ADDRESS
       LDC BIN,4      TRUE TO DECREMENT
       SXD BIN,4      OF BIN
       LDC MONIT,4    ADDRESS OF TEST
       SXA BIN,4      THAT LOST CONTROL
       REM            TO ADDRESS
       LDI BIN        BIN TO IND.
       TSX ERROR-1,4  TRANS OUT OF CONTROL.
*THE ADDRESS FROM WHICH CONTROL WAS RECOVERED
*IS IN DECR. OF THE INDICATORS, THE STARTING
*ADDRESS OF TEST WHICH WAS UNDERWAY IS IN THE
*ADDRESS OF THE INDICATORS
       REM            
       NOP SPACE      
       LXD MONIT,4    
       CLA -2,4       RESET MONIT
       PAX 0,2        AND
       SXD MONIT,2    RETURN TO
       TRA 0,4        PROPER SEQUENCE
       REM            
       REM            
*PROGRAM SEQUENCE AND COTNROL MONITOR
*IN CASE PROGRAM TRANSFER OUT OF CONTROL
       REM            
CLEAR  SLF            
       SWT 1          
       TRA *+2        TEST SWITCH 4
       TRA *+3        
       SWT 4          
       TRA *+4        NOT REPEATED
       PXD 0,4        
       SUB MONIT      
       TZE RESET+1    IF ZERO-SEQUENCE OK
       REM            
       STZ FREE       
       SXD FREE,4     SAVE TEST ADDRESS
       CLA -2,4       PRECEDIN TEST ADDRESS
       PAC 0,4        COMPLEMENT
       PXD 0,4        
       SUB MONIT      SHOULD BE ZERO
       LXD FREE,4     RESTORE XRC
       TZE RESET+1    IF ZERO,NORMAL PROGRAM
       REM            SEQUENCE IS OK
       REM            
       ENK            CHECK FOR MANUAL TRANFER
       XCA            
       PAC 0,4        COMPLEMENT ADDRESS IN KEYS
       LRS 21         CHECK TRA ONLY
       SUB K41        L0200
       TNZ *+5        SEQUENCE BAD IF NOT 0
       PXD 0,4        OK,CHECK ADDRESS
       SUB FREE       
       LXD FREE,4     RESTORE
       TZE RESET+1    OK IF ZERO
       REM            
       LXD FREE,4     PROGRAM OUT OF SEQUENCE
       TTR SPACE      
       REM            
RESET  SLF            
       SXD MONIT,4    
       LDC MONIT,4    
       TXI *+1,4,1    FOR RETURN
       SXA EXIT,4    
       PXD            CLEAR ACC
       STO            CLEAR ZERO
       LDQ            CLEAR MQ
       TOV *+1        TURN OFF 
       NOP            
       DCT            
       NOP            
       PAI            RESET
       LXD 0,7        CLEAR XRS
EXIT   TRA            RETURN TO PROG
PART2  SLF            LIGHTS OUT
       SLN 4          4 ON
       TRA CLEAR+1    CLEAR
PART3  SLF            
       SLN 3          3 ON
       TRA PART2+1    
       REM            
*SQUARE ROOT SUBROUTINE. ROOT EXACT TO 9 OCTAL DIGITS
       REM            
SQRT   TMI 1,4        ERROR
       TZE 2,4        OUT OF ZERO
       SXA *+12,1     SAVE XRA
       AXT 13,1       13 ITERATIONS
       STO FREE       N#RADICAN
       SUB *+11       N/2
       FAD *+11       +1
       STO FREE+1     FIRST GUESS#X
       CLA FREE       N
       FDP FREE+1     N/X
       XCA            
       FAD FREE+1     +X
       SUB *+4        DIV BY 2
       TIX *-6,1,1    REPEAT 
       AXT 0,1        REPLACE XRA
       TRA 2,4        EXIT
       OCT 001000000000
       DEC 1.0        
       REM            
*SQUARE ROOT SUBROUTINE WITH INDIRECT ADDRESSING
       REM            
SQRI   TMI 1,4        ERROR
       TZE 2,4        OUT OF ZERO
       SXA SQRI+14,1  SAVE XRA
       AXT 13,1       13 ITERATIONS
       STO* SQRT+4    N#RADICAN
       SUB* SQRT+5    N/2
       FAD* SQRT+6    +1
       STO* SQRT+7    FIRST GUESS#X
       CLA* SQRT+8    N
       FDP* SQRT+9    N/X
       XCA            
       FAD* SQRT+11   +X
       SUB* SQRT+12   DIV BY 2
       TIX *-6,1,1    REPEAT 
       AXT 0,1        REPLACE XRA
       TRA 2,4        EXIT
       REM            
RELO   LXD SHIMG,1    L+30
       CAL WRITE+24,1 TO RELOCATE
       SLW WRIT2+24,1 RECORD
       TIX RELO+1,1,1 IMAGE
       TRA 1,2        
       REM            
SHIFT  LXD SHIMG,1    L+30
       CAL WRIT2+24,1 
       LDQ WRIT2+25,1 ROUTINE
       PBT            
       TRA *+2        TO
       TRA *+7        
       LGL 1          SHIFT
       SLW WRIT2+24,1 
       LGL 36         PRINT
       SLW WRIT2+25,1 
       TIX *-9,1,2    
       TRA *+6        IMAGE
       REM            
       LGL 1          
       SLW WRIT2+24,1 
       LGL 36         
       ADD ONE        L+1
       TRA *-7        
       TRA 1,2        
       REM            
K1     NOP COEF-5     
       NOP FPCON+4    
       NOP K22        
       NOP K23        
       REM            
K22    OCT +201040000000
K23    OCT +222000000001
SCHTR  IOCD 16KAB,0,STCTL+1
RCWT   IOSP RDINA,0,8 READ FIRST 10 WORDS
       IOCP RDINA+8,0,8 READ NEXT 10 WORDS
       TCH *+2,0,30   
       IOCD           
       IOST RDINA+16,0,8 READ LAST 10 WORDS
       REM            NO LCH-SHOULD DISCONNECT
RCRT   IORT RDFLD,0,60 READ ONE 40 WORD RECORD
RSET   TRA RSET1      
       REM            
RSET1  TSX IORST,4    RESET
       HTR TOV,0,EX   COMPETE
       TSX IORST,4    PROGRAM
       HTR BCDTA,0,BCDF+2 TO INITIAL
       TRA BEGIN      STATE
       REM            
COUNT  OCT 1          
       REM            
TPCNT  OCT            COUNT FOR HIGHEST NUMBER
       REM            OF TAPE UNITS PER CHAN
       REM            
CMOUT  OCT 777777777770 
       REM            
WC1    IOCT WRFLD,0,1 CNTRL FOR STRT BUTTON TEST
RDINA  BSS 24         
       REM            
RDINC  OCT 20020040020    9L IMAGE
       OCT 4004000        9R
       OCT 40040100041    8L
       OCT 774010010020   8R WHICH
       OCT 100100200100   7L
       OCT 20020040       7R
       OCT 200200400200   6L SECOND
       OCT 40040100       6R
       OCT 400401000400
       OCT 100100200      5R CARD
       OCT 1002001001     4L
       OCT 700200200401   4R
       OCT 2004002000     3L READ
       OCT 74400401002    3R
       OCT 4010004000      2L
       OCT 1001002004     2R SHOULD
       OCT 10000010002    1L
       OCT 2002000010     1R
       OCT 17760002       0L COMPARE
       OCT 220000003760   0R
       OCT 17760000004    11L
       OCT 410003774000   11R WITH
       OCT 760000000011   12L
       OCT 7774000017     12R
       REM            
IRAN   BSS 24         BLOCK FOR RAND. NO.
RCD    BSS 24         
FREE   BSS 10         
       REM            
LOST   IOCP WRIT2,0,16 9L-2R
       IOCP WRIT2+16,0,2 1L-1R
       IOCP E84,0,2   8-4L - 8-4R ECHO
       IOCP WRIT2+18,0,2 WRITE 0L-0R
       IOCP E83,0,2   8-3L - 8-3R ECHO
       IOCP WRIT2+20,0,2 WRITE 11L-11R
       IOCP ECHO,0,2  9L-9R ECHO
       IOCP WRIT2+22,0,2 WRITE 12L-12R
       IOCP ECHO+2,0,2 8L-8R ECHO
       IOCD ECHO+4,0,14 7L-1R ECHO
       REM            
CAUSE  IOCP WRIT2,0,16 WRITE 9L-2R
       IOCP WRIT2+16,0,2 1L-1R
       IOCP EC84,0,2  8-4L - 8-4R ECHO
       IOCP WRIT2+18,0,2 WRITE 0L-0R
       IOCP EC83,0,2  8-3L
       IOCP WRIT2+20,0,2 WRITE 11L-11R
       IOCP ECHOC,0,2 9L-9R ECHO
       IOCP WRIT2+22,0,2 WRITE 12L-12R
       IOCP ECHOC+2,0,2 8L-8R ECHO
       IOCD ECHOC+4,0,14 7L-1R ECHO
       REM            
XCEL   IOCP WRIT2,0,16 WRITE 9L-2R
       IOCP WRIT2+16,0,2 1L-1R
       IOCP EE84,0,2  8-4L - 8-4R ECHO
       IOCP WRIT2+18,0,2 WRITE 0L-0R
       IOCP EE83,0,2  8-3L
       IOCP WRIT2+20,0,2 WRITE 11L-11R
       IOCP ECHOE,0,2 9L-9R ECHO
       IOCP WRIT2+22,0,2 WRITE 12L-12R
       IOCP ECHOE+2,0,2 8L-8R ECHO
       IOCD ECHOE+4,0,14 7L-1R ECHO
       REM            CONSTANTS
       REM            
DC1    OCT            STORAGE
DC2    OCT            
DC3    OCT            LOCATIONS
DC4    OCT            
DC5    OCT            FOR
DC6    OCT            
DC7    OCT            DRUM
DC8    OCT            
DC9    OCT            ADDRESS
DC10   OCT            
DC11   OCT            AS
DC12   OCT            
DC13   OCT            SELECTED
DC14   OCT            
DC15   OCT            
DC16   OCT            
       REM            
K301   OCT 301        OCTAL
K302   OCT 302        
K303   OCT 303        
K304   OCT 304        DRUM
K305   OCT 305        
K306   OCT 306        
K307   OCT 307        
K310   OCT 310        
K311   OCT 311        
K312   OCT 312        
K313   OCT 313        
K314   OCT 314        
K315   OCT 315        
K316   OCT 316        
K317   OCT 317        
K320   OCT 320        
       REM            
Z20    OCT 0          
RESTR  LNT 200000     
DC     OCT 0          
DRUM   OCT 0          
K300   OCT 300        
TBLE2  OCT 00106      
       OCT 00105      
       OCT 00104      
       OCT 00103      
       OCT 00102      
       OCT 00101      
       OCT 00100      
       OCT 06009      
       OCT 06008      
       OCT 06007      
       OCT 06006      
       OCT 06005      
       OCT 06004      
       OCT 06003      
       OCT 06002      
       OCT 06001      
K4000  OCT 4000       
K1000  OCT 1000       
LDA10  OCT 0          
K7776  OCT 7776       
K      OCT 0          
       OCT 0          
       OCT 0          
       OCT 200000020  
       OCT 40000020   
       OCT 10036004017 
       OCT 3377003757 
CSC    OCT 0          
T2     OCT 0          
T1     OCT 0          
K6     OCT 2000001    
       OCT 10000400   
       OCT 1000000400 
       OCT 7776003777 
CS     OCT 374007776000
400K   OCT 400000     
T7     OCT 0          
DA     OCT 0          
K4     OCT 4          
D13B   OCT 103        
D14B   OCT 104        
D15B   OCT 105        
D16B   OCT 106        
D9B    OCT 11         
D10B   OCT 100        
D11B   OCT 101        
D12B   OCT 102        
LDA    OCT 432421600000
D5B    OCT 5          
D6B    OCT 6          
D7B    OCT 7          
D8B    OCT 10         
D1B    OCT 1          
D2B    OCT 2          
D3B    OCT 3          
D4B    OCT 4          
TEST3  OCT 252525252525
D02    OCT 4000002    
D52    OCT 124000052  
D252   OCT 524000252  
D1252  OCT 2524001252 
D111                  
D222                  
D333                  
D444                  
TEST1                 
THREE  OCT 3          
CT6                   
PRNG                  
K100   OCT 100        
RR     OCT 357642357563
K3777  OCT 3777       
RN7                   
CAD                   
K3700  OCT 3700       
T21                   
T6                    
T10                   
K7     OCT 010776004377
       NOP K1000      
       OCT 7777       
WRDR   OCT 7775       
HECK   OCT 0          
       OCT 0          
       OCT 0          
CHEC   OCT 0          
       OCT 0          
TEST4  OCT 525252525252
TEST2  OCT 777777777777
       REM            
CRCHA  OCT            
PRCHA  OCT            
PUCHA  OCT            
TPCHA  OCT            
       REM            
CRCHC  OCT            
PRCHC  OCT            
PUCHC  OCT            
TPCHC  OCT            
       REM            
CRCHE  OCT            
PRCHE  OCT            
PUCHE  OCT            
TPCHE  OCT            
       REM            
TPCHB  OCT            
TPCHD  OCT            
TPCHF  OCT            
       REM            
       IOCD RFCD,0,256 READ 400 FIXED NOS
SHI    IOCD RFEF,0,256 READ 400 FIXED NOS
       REM            
RDTP1  IORP RFCD,0,0  SHOULD NOT TRANSMIT ON
       REM            THIS CONTROL WORD
       REM            
       IOCD RFCD+32,0,224 SHLD READ TWO 40 WRD RECS
       REM            ONE 200 WRD REC AND
       REM            TWO 40 WRD RECS
RDTP2  IORP RFEF,0,0  
       REM            
       IOCD RFEF+32,0,224 SHLD READ TWO 40 WRD RECS
       REM            ONE 200 WRD REC AND
       REM            TWO 40 WRD RECS
       REM            
SHOK   IOCP WRIT2,0,18 WRITE 9L-1R
       IOCP EC84,0,2  8-4L - 8-4R ECHO
       IOCP WRIT2+18,0,2 WRITE 0L-0R
       IOCP EC83,0,2  8-3L - 8-3R ECHO
       IOCP WRIT2+20,0,2 WRITE 11L-11R
       IOCP ECHOC,0,2 9L-9R ECHO
       IOCP WRIT2+22,0,2 WRITE 12L-12R
       IOCP ECHOC+2,0,2 8L-8R ECHO
       IOCD ECHOC+4,0,14 7L-1R ECHO
       REM            
SHOK1  IOCP           
       IOCP WRIT2,0,18 WRITE 9L-1R
       IOCP EC84,0,2  8-4L - 8-4R ECHO
       IOCP WRIT2+18,0,2 WRITE 0L-0R
       IOCP EC83,0,2  8-3L - 8-3R ECHO
       IOCP WRIT2+20,0,2 WRITE 11L-11R
       IOCP ECHOC,0,2 9L-9R ECHO
       IOCP WRIT2+22,0,2 WRITE 12L-12R
       IOCP ECHOC+2,0,2 8L-8R ECHO
       IOCD ECHOC+4,0,14 7L-1R ECHO
       REM            
ID19   IOCT RFCD,2,1  SKIP ONE WORD
       TCH ID19+3,2,2 TEST IND 19 WITH IND 2
       IOCD           
       IOCP RFCD+1,0,42 READ 42 WORDS
       IOCP RFCD+43,2,42 SKIP 42 WORDS
       IOSP RFCD+85,0,42 READ 42 WORDS
       IOSP RFCD+127,2,42 SKIP 42 WORDS
       IOSP RFCD+169,0,42 READ 42 WORDS
       IORT RFCD+211,2,100 SKIP REMNDER OF REC
       REM            
ID191  IOCT RFEF,2,1  SKIP ONE WORD
       TCH ID191+3,2,2 TEST IND 19 WITH IND 2
       IOCD           
       IOCP RFEF+1,0,42 READ 42 WORDS
       IOCP RFEF+43,2,42 SKIP 42 WORDS
       IOCP RFEF+85,0,42 READ 42 WORDS
       IOSP RFEF+127,2,42 SKIP 42 WORDS
       IOSP RFEF+169,0,42 READ 42 WORDS
       IORT RFEF+211,2,100 SKIP REMNDER OF REC
       REM            
SRD2   IOCD RFCD,0,192 READ TAPE-CHAN D
SRD4   IOCD RFCD+192,0,64 READ TAPE-CHAN C
SRD3   IOCD RFEF,0,192 READ TAPE-CHAN F
SRD5   IOCD RFEF+192,0,64 READ TAPE-CHAN E
       REM            
RCWT1  IOSP RDNA,0,8  READ 10 WORDS
       IOCP RDNA+8,0,8 READ NEXT 10
       TCH *+2,0,30   
       IOCD           
       IOST RDNA+16,0,8 READ LAST 10
       REM            NO LCH SHOULD DISCONNECT
RCWT2  IOSP RDNA1,0,8 READ 10 WORDS
       IOCP RDNA1+8,0,8 READ NEXT 10
       TCH *+2,0,30   
       IOCD           
       IOST RDNA1+16,0,8 READ LAST 10
       REM            NO LCH SHOULD DISCONNECT
RCRT1  IORT RFCD,0,60 READ ONE 40 WRD REC
RCRT2  IORT RFEF,0,60 READ OEN 40 WRD REC
ECHOC  OCT 0,0,0,0,0,0,0,0,0,0,0,0
       OCT 0,0,0,0,0,0 
EC83   OCT 0,0        
EC84   OCT 0,0        
       REM
ECHOE  OCT 0,0,0,0,0,0,0,0,0,0,0,0
       OCT 0,0,0,0,0,0 
EE83   OCT 0,0        
EE84   OCT 0,0        
       REM            
*UNIONJACK CONSTANTS  
       REM            
J      OCT 200000000000  LEFT VERTICAL
       OCT 101777000000  TOP HORIZONTAL
       OCT 100000000000  BOTTOM HORIZONTAL
       OCT 200000001777  EXTREME RIGHT VERTICAL
       OCT 300000000000  DIAGONAL
       OCT 101000000000  CENTER HORIZONTAL
       OCT -000000000000 LOWER LEFT HIGH
       REM                INTENSITY SPOT
       OCT -001777000000 LOWER RIGHT HIGH
       REM                INTENSITY SPOT
       OCT -000000001777  UPPER LEFT HIGH
       REM                INTENSITY SPOT
       OCT -001777001777  UPPER RIGHT HIGH
       REM                INTENSITY SPOT
       OCT -001000001000  CENTER HIGH
       REM                INTENSITY SPOT
       OCT 200000001000  CENTER VERTIAL
       REM            
KK1    OCT 14         
       REM            
       REM            
*DOT CHECKERBOARD CONSTANTS
QQ     OCT 2000       
Q1     OCT 2000000000 
Q2     OCT 2100       
D1S    OCT            
KON1   OCT 0000000000000
KON2   OCT 770000000  
SIN    OCT 1777       
       REM            
       REM            
       REM            
       REM            
*INTENSITY TEST CONSTANTS
       REM            
T      OCT 4          
U      OCT 4000000    
W      OCT 400        
XX     OCT 200000000000
Y      OCT 100000000000
Z      OCT 000000000000
P      OCT 20000000   
       REM            
       REM            
*DOT INTENSITY CONSTANTS
       REM            
       REM            
CPY    OCT -377677777677
M      OCT -000100000100
N      OCT 10         
G      OCT -377677777677
       REM            
MINUS  OCT -0         
K2A    OCT 200777760000
YIPE   HTR EXK        
SEVEN  OCT 7          
       REM            
HUH    PXA 0,1        XRA TO ACC
       PAC 0,1        
       PXA 0,1        
       PAC 0,1        
       LDQ YIPE       L HTR EXK IN MQ
       CAS YIPE       
       TRA *+2        
       TRA *+4        
       TSX ERROR-1,4  
       TRA EXK        
       TRA EXL        
       TRA 4,1        RETURN TO EXK+4
       REM            
RN     BSS 64         
       REM            
WRFLD  BSS 256        
       REM            
RDFLD  BSS 2048       BLOCK FOR TAPE RD-CHAN A+B
       REM            
RFCD   EQU RDFLD+256  BLOCK FOR TAPE RD-CHAN C+D
       REM            
RFEF   EQU RDFLD+512  BLOCK FOR TAPE RD-CHAN E+F
       REM            
K2377  HTR RDFLD      
       REM            
SECTN  IOCD SECN1,0,24 
       IOCD SECN2,0,24 
       IOCD SECN3,0,24 
       IOCD SECN4,0,24 
       IOCD SECN5,0,24 
       IOCD SECN6,0,24 
       IOCD SECN7,0,24 
       IOCD SECN8,0,24 
       IOCD SECN9,0,24 
       IOCD SEC10,0,24 
       IOCD SEC11,0,24 
       IOCD SEC12,0,24 
       IOCD SEC13,0,24 
       IOCD SEC14,0,24 
       IOCD SEC15,0,24 
       IOCD SEC16,0,24 
       IOCD SEC17,0,24 
       IOCD SEC18,0,24 
       IOCD SEC19,0,24 
       REM            
       ORG RDFLD+9   
       REM            
*ADJUSTMENT FOR SIZE OF STORAGE-SECOND HALF
*      TEST FOR SIZE OF STORAGE
       REM            
NOW    CLA ZERO       
       STO 32767      32K
       ADD ONE        L +1
       STO 16383      16K
       ADD ONE        
       STO 8191       8K
       REM            
       CLA 32767      
       TZE 32K        32K
       SUB ONE        
       TZE 16K        16K
       SUB ONE        
       TZE 8K         8K
       HTR 8K         ERROR IN TESTING SIZE
       REM            OF STORAGE PRESSING
       REM            START WILL TEST 8K
32K    CLA COTS       L 364647064647
       STO CHECK      
       CLA COTS+1     L 71011
       STO SIZE       
       TRA HOT        
       REM            
16K    CLA COTS+2     L 344657044647
       STO CHECK      
       CLA COTS+3     L 31011
       STO SIZE       
       REM            
       CLA CRCTS      
       SUB 16KA       L 40000
       STO CRCTS      
       REM            
       CLA CRCT1+26   
       SUB 16KA       
       STO CRCT1+26   
       REM            
       CLA CRCT1      
       SUB 16KA       L 40000
       STO CRCT1      
       TRA HOT        
       REM            
8K     CLA COTS+4     L 11011
       STO SIZE       
       REM            
       CLA CRCT1+26   
       SUB 8KA        
       STO CRCT1+26   
       REM            
       CLA CRCTS      
       SUB 8KA        L 60000
       STO CRCTS      
       REM            
       CLA CRCT1      
       SUB 8KA        L 60000
       STO CRCT1      
       REM            
HOT    CLA COTS+5     ADDR OF MONIT
       PAC 0,4        COMP OF ADDR INTO XRC
       SXD MONIT,4    
       SXD RST,4      
       TRA ITS        
COTS   OCT 364647064647
       OCT 71011      
       OCT 344647044647
       OCT 31011      
       OCT 11011      
       HTR BEGFP      
8KA    OCT 60000      
16KA   OCT 40000      
       REM            
       REM            
       REM            
       REM            
       REM            
       ORG RDFLD+9   
*ADJUSTMENT FOR SIZE OF STORAGE-FIRST HALF
       REM            
NOW1   CLA ZERO       
       STO 32767      32K
       ADD ONE        
       STO 16383      16K
       ADD ONE        
       STO 8191       8K
       REM            
       CLA 32767      
       TZE SETBT      32K
       SUB ONE        
       TZE 16KB       16K
       SUB ONE        
       TZE 8KB        8K
       HTR 8KB        ERROR IN TESTING
       REM            SIZE OF STORAGE
       REM            
16KB   CAL SCHTR      STORE CHANNEL
       SUB 16KAB      
       LGR 18         
       SUB 16KAB      
       LGL 18         
       SLW SCHTR      
       CAL SCH1       STORE CHANNEL
       SUB 16KAB      
       LGR 18         
       SUB 16KAB      
       LGL 18         
       SLW SCH1       
       REM            
       CAL SCH2       STORE CHANNEL
       LGR 18         
       SUB 16KAB      
       LGL 18         
       SLW SCH2       
       REM            
       CAL SCHA       STORE CHANNEL
       SUB 16KAB      
       LGR 18         
       SUB 16KAB      
       LGL 18         
       SLW SCHA       
       TRA SETBT      
       REM            
8KB    CAL SCHTR      STORE CHANNEL
       SUB 8KAB       
       LGR 18         
       SUB 8KAB       
       LGL 18         
       SLW SCHTR      
       CAL SCH1       STORE CHANNEL
       SUB 8KAB       
       LGR 18         
       SUB 8KAB       
       LGL 18         
       SLW SCH1
       REM            
       CAL SCH2       STORE CHANNEL
       LGR 18         
       SUB 8KAB       
       LGL 18         
       SLW SCH2       
       REM            
       CAL SCHA       STORE CHANNEL
       SUB 8KAB       
       LGR 18         
       SUB 8KAB       
       LGL 18         
       SLW SCHA       
       REM            
       TRA SETBT      
       REM            
SETBT  SWT 3          
       TRA *+2        
       TRA *+3        
       REM            
       WPRA           
       RCHA STCTL     CONTROL FOR PRINTING
       REM            STARTING HEADING
       REM            
       AXT 19,1       
       AXT 5,4        
       CLA CBIT       BIT TO START ADDRESS
       STO SAVE       
       LDQ OCTAD+19,1 # TO BE CONVERTED
       RQL 3          SHIFT OUT PREFIX
       PXD            CLEAR ACC
       LGL 3          
       ALS 1          DOUBLE IT
       PAX 0,2        PLACE IN XRB
       CLA SAVE       COLUMN TO START ADDRESS
       ORS SECN1+18,2 STORE BITS IN IMAGE
       ARS 1          SHIFT TO NEXT COLUMN
       STO SAVE       
       TIX *-8,4,1    
       CAL *-4        ORS INSTRUCTION
       ADD OCTTH      INCREASE ADDR TO NEXT IMAGE
       SLW *-6        RESTORE
       TIX *-17,1,1   RETURN FOR 19 IMAGES
       REM            
*FORM FIXED PATTERN FOR WRITING TAPE
*AND COMPARE TO INSURE NO MAIN FRAME ERROR
       REM            
       REM            
       REM            
       LXD THSVN,4    L 400-FORM
       LXA TEN,1      L 4-FIXED BINARY
       LXD TEN,2      L 100-NUMBERS FOR
       CLA FIX+64,2   WRITE TAPE
       STO WRFLD+256,4 
       TIX *+1,4,1    
       TIX *-3,2,1    
       TIX *-5,1,1    
       TRA *+2        
       REM            
*COMPARISON           
       REM            
       BCD 1COMP      COMPARISON MEMORY
       REM            
UNFOR  LXD THSVN,4    L 400-COMPARE NOS TO
       LXA TEN,1      L 4-CHECK
       LXD TEN,2      L 100-MAIN FRAME
       CLA WRFLD+256,4 OPERATION
       LDQ FIX+64,2   
       CAS FIX+64,2   
       TRA *+2        ERROR
       TRA *+5        OK
       SXA SAVE,4     SAVE XR IN CASE OF ERROR
       TSX ERROR-2,4  PATTERN WAS NOT FORMED
       REM            CORRECTLY. MAIN FRAME ERROR
       NOP UNFOR      
       LXA SAVE,4     RESTORE XR AFTER ERROR
       TIX *+1,4,1    
       TIX *-10,2,1   
       TIX *-12,1,1   
       TSX OK,4       OUT TO CHECK SWITCHES
       TRA UNFOR-10   
       NOP            
       REM            
       REM            
       TRA BEGIN      
       REM            
START  OCT 450          9L
       OCT 100000000000 9R
       OCT 0            8L
       OCT 20100400000  8R
       OCT 2002         7L
       OCT 0            7R
       OCT 30300        6L
       OCT 0            6R
       OCT 41004        5L
       OCT 10200000     5R
       OCT 20           4L
       OCT 4000000      4R
       OCT 0            3L
       OCT 21100000     3R
       OCT 0            2L
       OCT 40240040000  2R
       OCT 0            1L
       OCT 14000000000  1R
       OCT 10000        0L
       OCT 60360000000  0R
       OCT 62564        11L
       OCT 401004040000 11R
       OCT 1212         12L
       OCT 4011700000   12R
16KAB  OCT 40000      
8KAB   OCT 60000      
       REM            
X      EQU RDFLD+2048 BLOCK FOR DRUM READ
WPA    EQU X-2040     
ERROR  EQU A$ERROR    
OK     EQU A$OK       
RDNCK  EQU A$RDNCK    
WDNO   EQU A$WDNO     
RECNO  EQU A$RECNO    
CTRL1  EQU B$CTRL1    
CTRL2  EQU B$CTRL2    
CTRL3  EQU B$CTRL3    
CTX    EQU B$CTX      
IOC    EQU B$IOC      
IOCT   EQU B$IOCT     
CTRA   EQU B$CTRA     
IORST  EQU B$IORST    
SBCNT  EQU B$SBCNT    
       END NOW1
                      
