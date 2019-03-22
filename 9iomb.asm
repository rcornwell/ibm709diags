                                                            9 I O M B
                                                            7-01-58
       REM            
       REM            
       REM            
*                            9 I O M B
       REM            
*                 709 ROUTINE FOR MODIFICATION OF
*                        I-O INSTRUCTIONS
       REM            
       ORG 2880       
CTRL1  OCT +0       COUNT WORD FOR DS A+B
CTRL2  OCT +0       COUNT WORD FOR DS C+D
CTRL3  OCT +0       COUNT WORD FOR DS E+F
IOCT   OCT +0       I-O COUNT 
CTRA   OCT +0       NUMBER OF UNITS - CHN A
CTRB   OCT +0       NUMBER OF UNITS - CHN B
CTRC   OCT +0       NUMBER OF UNITS - CHN C
CTRD   OCT +0       NUMBER OF UNITS - CHN D
CTRE   OCT +0       NUMBER OF UNITS - CHN E
CTRF   OCT +0       NUMBER OF UNITS - CHN F
CTX    TRA CTX1     TO MODIFY PROGRAM
IOCNT  TRA IOC1     TO RELOAD I-O COUNT
       REM            
       REM            
       REM            
*     ENTER CONTROL WORDS FOTR CHANNELS AND UNITS   
       REM            
IOC    STZ CTRL1     CLEAR 
       STZ CTRL2     CONTROL
       STZ CTRL3     WORDS 
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
DSC1   RNT 0,1       TEST FOR CHAN A AND/OR B
       TRA DSC2      NO   
       STI CTRL1     CNTL WORD FOR A AND/OR B 
DSC2   RNT 0,2       TEST FOR CHAN A AND/OR B
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
       AXT 6,1       L +6 IN XRB
       AXT 2,4        
       CLA FOUR+2,4   
       STA AB+1       
AB     CAL IOCT,2    L CHANNEL CONTROL WORD
       ARS 4          
       PAI            
       ANA KON2      L + 17 - CLEAR ACC TO COUNT
       RNT  20       CHECK FOR EXCLUSIVE BIT
       TRA *+2       NO      
       CAL ONE       YES - L + 1 FOR COUNT
       STO CTX,1     SAVE CHN UNIT CONT
       ADD IOCT      
       STO IOCT      SAVE TOTAL UNIT COUNT
       TIX *+1,1,1    
       TIX AB-2,4,1   
       TIX AB-3,2,1   
       LXA ACCX,4    RELOAD XRC
       REM            
       REM            
CNT    CLA FOUR      L +4   
       STZ TEMP       
       PAX 0,2       L ACC IN XRB
       SXA *+4,2      
       AXT 3,1        
       PXD 0,0        
       LDI IOCT,1     
       RNT           CHECK NUMBER OF 
       REM           CARD MACHINES ON LINE
       TRA *+2       NO      
       ADD ONE       YES - L +1
       TIX *-4,1,1    
       CAS IOCT       
       STA IOCT       
       NOP            
       CAL IOCT,1     
       ANA FOUR+2     
       XEC CTX1,1    SHIFT 
       ORS TEMP       
       PXA 0,2       L XRB IN ACC
       ARS 1          
       TIX CNT+2,2,1   
       TRA 1,4       EXIT TO MAIN PROG
       ALS 18         
       ALS 6          
       NOP            
       REM            
       REM            
*      MODIFY I-O INSTRUCTIONS
       REM            
CTX1   STO ACCX      ACC CONTENTS
       ARS 35        SAVE P+Q
       SLW ACCX+1     
       SXA ACCX+2,1  SAVE XRA
       SXD ACCX+2,2  SAVE XRB
       STQ ACCX+3    SAVE MQ
       STI IND       SAVE INDICATORS
       CLA 1,4       L FIRST AND LAST ADDRESS
       REM           PROGRAM AREA TO BE MODIFED
       STA CTRX      SAVE FIRST ADDRESS
       ARS 18         
       STA KON2-1    SAVE LAST ADDRESS
CTRX   CAL 0         L CURRENT INSTRUCTION
       SLW INST      SAVE CURRENT INSTRUCTION
       PAI           PLACE INST IN INDICATORS
       STA ADDR      TEST INST IN I/O TABLE
       AXT 7,1       L +7 
       CLA OPTAB+7,1   
       STA *+2        
       STT *+1        
       REM            
       REM            
       LNT 0         TEST FOR I/O INSTRUCTION
       TRA *+6        
       LFT 300000     
       TRA *+4        
       LNT 077400     
       TRA OPR1       
       LNT 077500     
       TIX *-10,1,1   
       TXH OPR1,1,1   
       REM TEST FOR BCD WORD
       RNT 206000     
       TRA TRCX       
       RFT 401700     
       TRA TRCX       
       LFT 000077     
       TRA *+2        
       TRA TRCX       
       LFT 370000     
       TRA *+2        
       TRA TRCX       
       LFT 007700     
       TRA *+2        
       TRA TRCX       
       STI BCD        
       LXA CTRX,1     
       SXA BCDX,1     
FINE   CAL K+2       L +6000
       ORS WTBX+2     
       ORS WTDX       
       ORS BTTX     
       ORS WPRX+1     
       ORS WPUX       
       ORS RDCX       
       ORS WDDX     
       ORS OPXY     
       CAL KON4      MASK 6220
       ANS WTBX+2     
       ANS WTDX       
       ANS BTTX     
       CAL KON4+1     
       ANS WPRX+1     
       ANS WPUX       
       ANS RDCX       
       ANS WDDX     
       ANS OPXY     
       REM            
       CLA CTRX      L CURRENT LOCATION IN PROGRAM
       CAS KON2-1    LAST LOCATION IN PROG
       TRA *+3        
       TRA FIN        
       HTR *-1       EXIT    
       SUB ONE       L +1 
       STA CTRX       
       TRA CTRX       
       REM            
FIN    LDI IND       RESTORE REGISTERS
       CLA ACCX+1     
       LDQ ACCX       
       LLS 35         
       LDQ ACCX+3     
       LXA ACCX+2,1   
       LXD ACCX+2,2   
       TRA 2,4        
       REM            
OPR1   TRA *+8,1      
       TRA WTBX      BSFX 
       TRA WTBX      ETTX
       TRA WTBX      REWX 
       TRA WPRX       
       TRA WTBX       
       TRA WPRX      BRXX 
       LFT 701777     
       TRA FINE       
       TRA WTBX       
       REM            
WPRX   AXT 6,1       L +6 
       RNT 6360      TEST FOR PRINTER ADDR
       TRA *+2        
       TXI WPR,1,2   
       NOP            
WPUX   RNT 6340      TEST FOR PUNCH ADDR
       TRA *+2        
       TXI WPU,1,2   
       NOP            
RDCX   RNT 6320      TEST FOR READER ADDR
       TRA *+2        
       TXI RDC,1,2   
       LXA *+1,2      
WDDX   RNT 6240       
       TRA *+2        
       TRA OPXZ     
       LXA *+1,2      
OPXY   RNT 6000             
       TRA *+5     
       RFT 000776     
       TRA *+3     
OPXZ   STO BIT        
       TRA WTB        
       AXT 20,2       
       CAL OPXZ,2   
       SUB CHBIT      
       SLW OPXZ,2   
       TIX *-3,2,4    
       TIX WPRX+1,1,1   
       REM            
WTBX   AXT 6,1       L + 6 
       LXA *+1,2     PUT ADDR INTO XRB
       RNT 6220      TEST FOR BINARY ADDRESS
       TRA *+2       YES 
       TRA WTB       NO   
       LXA *+1,2      
WTDX   RNT 6200      TEST FOR BCD MODE
       TRA *+2        
       TRA WTB        
       LXA *+1,2      
BTTX   RNT 6000      CHECK BEGINNING OF TAPE
       TRA *+2        
       TRA BTT        
       AXT 12,2       
       CAL *,2        
       SUB CHBIT      
       SLW *-2,2      
       TIX *-3,2,4    
       TIX WTBX+1,1,1   
       TRA FINE       
       REM            
BTT    CLA CHX        
       ALS 9          
       TZE FINE       
       STA INST       
       TRA CHAN       
       REM            
WTB    SXA KON2+1,2  INITIAL ADDR TO STORE
       STL WTBBX      
       TRA WTBB       
       XEC WTBB,1     
       PAI           PUT ACC IN INDICATORS
       ANA KON2      L +17 - CLEAR TO UNIT
       ADD KON2+1    L INITIAL ADDR FOR CHN
       CAS ADDR       
       TRA *+3       OK - SET INSTRUCTION
       TXI WTBBX+1,1,1   
       TXI WTBBX+1,1,1   
       ZET BIT        
       TRA WTBBX+1   
       RNT 20         
       TRA *+2       NO - GO TO STEP UNIT
       TRA *+3       YES - GO TO SET EXLCU UNIT
       CAL INST      L CURRENT INSTRUCTION
NXTCH  ADD ONE       L +1 - SET UNIT
       TXH *+8,1,1   CHECK FOR CHANNEL A
       LDI CTRL1      
       LFT 400000    IS CHN A - CHECK FOR BIT
       REM           SIGNIFYING PROGRAM READ
       REM           FROM CARDS  
       TRA *+5       BIT - ANY UNIT OK
       PAI           NO BIT - L NEW UNIT ADDR
       RFT 000016    TO CHECK FOR UNIT 1
       REM           WHICH MUST BE BLOCKED OUT
       TRA *+2       NOT UNIT 1
       REM            
       ADD ONE       IS UNIT 1 - L + 1
       REM            
WTBC   STA INST       
       SXA CHX,1     SAVE CHANNEL COUNT
       TRA CHAN       
       REM            
       REM            
       ARS 10         
       ARS 4          
       ARS 10         
       ARS 4          
       ARS 10         
       ARS 4          
WTBB   CLA WTBBX      
       ADD ONE        
       STA WTBBX      
       CAL CTRL3      
       TXH WTBBX,1,4   
       CAL CTRL2      
       TXH WTBBX,1,2   
       CAL CTRL1      
WTBBX  TRA 0          
       TXL *+2,1,6    
       AXT 1,1        
       STL WTBBX      
       TRA WTBB       
       XEC WTBB,1     
       PAI            
       RFT 37         
       TRA *+2        
       TXI WTBBX+1,1,1   
       NZT BIT        
       TRA *+4        
       CAL INST       
       ANA ADDR+1     
       TRA *+5        
       RFT 20         
       STO BIT-1     SET CHK FOR EXCLU UNIT BIT
       PXA 0,2       L CURRENT CHANNEL ADDRESS
       ANA INST+1    L +200 - CLEAR TO CLASS
       REM           AND MODE    
       STO KON2+1     
       PXA 0,1       L CHANNEL COUNTER
       ALS 9         POSITION FOR ADDRESS
       ADD KON2+1    ADD CLASS AND MODE
       PAX 0,2       SAVE ADJUSTED CHN ADDRESS
       NZT BIT       CHECK FOR EXCLU UNIT BIT
       TRA *+3        
       STZ BIT        
       TRA WTBC       
       NZT BIT-1      
       TRA NXTCH        
       STO ADDR       
       STZ BIT-1      
       TRA WTB        
WPU    CAL FOUR      L +4   
       TRA WPR+1   
RDC    CAL ONE       L +1 
       TRA WPR+1   
       REM            
WPR    CAL TWO        
       STA *+6        
       SXA XRA,1   
MODOP  TXH *+7,1,5    
       STL WTBBX      
       TRA WTBB       
       PAI            
       RNT 0          
       TXI MODOP,1,2   
       TRA *+7        
       ZET BIT+1      
       TRA *+4        
       AXT 1,1       L +1 
       STL BIT+1      
       TRA MODOP+1   
       LXA XRA,1   
       CAL ADDR       
       ANA KON5       
       ADD CHBIT+1,1   
       STZ BIT+1      
       TRA WTBC       
       REM            
TRCX   LXA CHX,1     CHANNEL TO BE TESTED
       LNT 64000      
       TRA TRCX1      
       LFT 311000     
       TRA TRCX1      
       LNT 66000      
       TRA SCH        
       LNT 66400      
       TRA SSL     
       TRA PSL     
       REM            
TRCX1  LNT 07400      
       TRA *+2        
       TRA FINE       
       REM            
       LNT 054000    RESET LOAD INST
       TRA *+6        
       LFT 023000     
       TRA FINE       
       LNT 054400     
       TRA RCH        
       TRA LCH        
       REM            
       LNT 006000    CHANNEL OPERATION
       TRA *+6        
       LFT 371000     
       TRA *+4        
       LNT 400000     
       TRA TCN        
       TRA TCO        
       LFT 375700     
       LNT 002000    IS THIS A CONTROL
       TRA FINE       
       LFT 374000     
       TRA FINE       
       LNT 003000     
       TRA OPR        
       CAL TEFOP      
       TRA TEF        
SCH    CAL SCHOP      
       TRA TEF        
SSL    CAL SSLOP     
       TRA TEF        
PSL    CAL PSLOP     
       TRA TEF        
RCH    CAL RCHOP      
       TRA TEF        
LCH    CAL LCHOP      
       TRA TEF        
OPR    CAL OPTAB,1    
TEF    ACL TEFOP,1    
       TRA TRAN       
TCN    CAL TCNOP      
       TRA *+2        
TCO    CAL TCOOP      
       ACL OPMOD,1   
       ACL TEFOP,1    
TRAN   LNT  000060    
       TRA *+2        
       ORA K         L HTR 0,0,60
       STD INST       
       STP INST       
CHAN   CLA CTRX       
       STA *+2        
       CLA INST      INSTRUCTION
       STO 0          
       NZT BCD       CHECK BCD WORD
       TRA FINE      CHECK NEXT WORD
       LDI INST      PLACE CURRENT INSTR IN INDS
       LNT 70000      
       TRA FINE       
       CAL BCD+1      
       ANS BCD       MASK 
       CLA CHX        
       ALS 12         
       ORS BCD       BCD WORD
       CLA INST      PRESENT I/O WORD
       ANA KON2      L +17
       TZE FINE       
       ORA BCD       OBTAIN UNIT NUMBER
BCDX   SLW 0          
       STZ BCD        
       TRA FINE       
       REM            
       OCT 000300000000
       OCT -000200000000
       OCT 000200000000
       OCT -000100000000
       OCT 000100000000
       OCT -000000000000
OPMOD  HTR 0          
TEFOP  TEFA 0          
SCHOP  SCHA 0          
PSLOP  OCT 066400000000
SSLOP  OCT 066000000000
LCHOP  LCHA 0          
RCHOP  RCHA 0          
TCNOP  TCNA 0          
TCOOP  TCOA 0          
TRCOP  TRCC 0          
       TRCC 0          
       OCT 02300000000
       OCT 02300000000
       TRCA 0          
       TRCA 0          
OPTAB  OCT 000000075500
       OCT 000000077200    REWIND
       OCT 000000077000    WRITE END OF FILE
       OCT 000000076600    WRITE SELECT
       OCT 000000076400    BACKSPACE RECORD
       OCT 000000076200    READ SELECT
       OCT 000000076000    BEGINNING OF TAPE TEST
XRA    OCT 000000000000
ONE    OCT +1         
TWO    OCT +2         
FOUR   OCT +4         
TEN    OCT +12        
       OCT 7          
TEMP   OCT 000000000000
       CAL 0          
KON2   OCT 17         
       OCT 0          
KON4   RNT 6220       
       RNT 6367       
ADDR   OCT 0          
       OCT 777        
INST   OCT 0          
       OCT 220        
KON5   OCT 367        
CHX    OCT 0          
IND    OCT 0          
BCD    PZE 0          
       OCT 777777707700
       OCT 0          
BIT    OCT 0          
       OCT 0          
ACCX   OCT 0          
       OCT 0          
       OCT 0          
       OCT 0          
K      HTR 0,0,48     
       OCT 001111101111
       OCT 000000006000
       OCT 000000005000
       OCT 000000004000
       OCT 000000003000
       OCT 000000002000
CHBIT  OCT 000000001000
       END            
