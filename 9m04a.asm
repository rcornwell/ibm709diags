                                                             9M04A
                                                             7-01-58
       REM           
       REM           
       REM           9M04
       REM           TEST INDIRECT ADDRESSING
       REM           
       REM           
       ORG 24        
       REM           
       CLA TX2A      POST
       STO 0         RESTART
       TRA *+2       
       REM           
       REM           TURN TRIGGER ON
       BCD 1CLA      TEST INSTRUCTION
 A1A   CLA K20       L+00444 NORMAL MODE
       REM           TURN TRG OFF
       CLA* K0       L +00444 -- K20
       LDQ K20       L +00444 IN MQ
       CAS K20       
       TRA A1A1      
       TRA TX2       
 A1A1  CAS K0        
       TRA A1A2      
       TRA TX1       
 A1A2  TSX ERROR-1,4 FAILED TO IA CORRECTLY
 TX2A  TRA A1A       
       TRA A1B       
 TX1   TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX2   TSX OK,4      
       TRA A1A       
       REM           
       REM           
       REM           
       REM           ATTEMP INDIRECT ADDR
       REM           WITH A BIT IN 12
       BCD 1CLA      TEST INSTRUCTION
 A1B   CLA K0,0,32   L NOP K20 -- K0
       LDQ K0        L NOP K20
       CAS K0        
       TRA A1B1      
       TRA TX4       
 A1B1  CAS K20       
       TRA A1B2      
       TRA TX3       
 A1B2  TSX ERROR-1,4 FAILED TO ADR NORMAL MODE
       TRA A1B       
       TRA A1C       
 TX3   TSX ERROR,4   FALSE INDIRECT ADDRESSING
 TX4   TSX OK,4      
       TRA A1B       
       REM           
       REM           
       REM           EXECUTE IN NORMAL MODE
       REM           WITHA BIT IN 13
       REM           
       BCD 1CLA      TEST INSTRUCTION
 A1C   CLA K3,0,16   L NOP K23+3 -- K3
       LDQ K3        L NOP K23+3 IN MQ
       CAS K3        
       TRA A1C1      
       TRA TX6       
 A1C1  CAS K23+3     
       TRA A1C2      
       TRA TX5       
 A1C2  TSX ERROR-1,4 FAILED TO ADR NORMAL MODE
       TRA A1C       
       TRA A1        
 TX5   TSX ERROR,4   FALSE INDIRECT ADDRESSING
 TX6   TSX OK,4      
       TRA A1C       
       REM           
       REM           
       REM           INDEXABLE INSTRUCTIONS
       REM           WITH REF TO STORAGE
       REM           
       BCD 1CLA      TEST INSTRUCTION
 A1    CLA* K0       L +00444 -- K20
       LDQ K20       L +00444 IN MQ
       CAS K20       
       TRA A1AA      
       TRA TX8       
 A1AA  CAS K0        
       TRA A1AB      
       TRA TX7       
 A1AB  TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA A1        
       TRA A2        
 TX7   TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX8   TSX OK,4      
       TRA A1        
       REM           
       REM           
       BCD 1SUB      TEST INSTRUCTION
 A2    CLA K0+1      L NOP K20+1
       ADD K20+1     L +00555
       SUB* K0+1     L +00555 -- K20+1
       LDQ K0+1      L NOP K20+1 IN MQ
       CAS K0+1      
       TRA A2A       
       TRA TX10      
 A2A   CAS K20+1     
       TRA A2B       
       TRA TX9       
 A2B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA A2        
       TRA A3        
 TX9   TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX10  TSX OK,4      
       TRA A2        
       REM           
       REM           
       BCD 1CLS      TEST INSTRUCTION
 A3    CLS* K0       L +00444 -- K20
       ADD K20       L +00444 
       ADD K0        L NOP K20
       LDQ K0        L NOP K20 IN MQ
       CAS K0        
       TRA A3A       
       TRA TX12      
 A3A   CAS K20       
       TRA A3B       
       TRA TX11      
 A3B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA A3        
       TRA A4        
 TX11  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX12  TSX OK,4      
       TRA A3        
       REM           
       REM           
       BCD 1ADD      TEST INSTRUCTION
 A4    CLM           CLEAR
       SSP 3         ACCUMULATOR
       ADD* K0+1     L +00555 -- K20+1
       LDQ K20+1     L +00555 IN MQ
       CAS K20+1     
       TRA A4A       
       TRA TX14      
 A4A   CAS K0+1      
       TRA A4B       
       TRA TX13      
 A4B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA A4        
       TRA A5        
 TX13  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX14  TSX OK,4      
       TRA A4        
       REM           
       REM           
       BCD 1ADM      TEST INSTRUCTION
 A5    CLM           CLEAR ACC
       ADM* K0+2     L222222 -- K20+4
       CHS           SET SIGN MINUS
       LDQ K20+4     L -222222 IN MQ
       CAS K20+4     
       TRA A5A       
       TRA TX16      
 A5A   CHS           CHANGE SIGN BIT IN ACC
       CAS K0+2      
       TRA A5B       
       TRA TX15      
 A5B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA A5        
       TRA A6        
 TX15  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX16  TSX OK,4      
       TRA A5        
       REM           
       REM           
       BCD 1SBM      TEST INSTRUCTION
 A6    CLA K20+5     L +333333
       SUB K20+3     L +111111
       ADD K0+2      L NOP K20+4
       SBM* K0+2     L0222222 -- K20+4
       LDQ K0+2      L NOP K20+4 IN MQ
       CAS K0+2      
       TRA A6A       
       TRA TX18      
 A6A   CHS           CHANGE SIGN BIT IN ACC
       TRA A6B       
       TRA TX17      
 A6B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA A6        
       TRA A7        
 TX17  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX18  TSX OK,4      
       TRA A6        
       REM           
       REM           
       BCD 1MPY      TEST INSTRUCTION
 A7    CLA K20+2     L +0
       LDQ K20+6     L +50
       MPY K0+3      
       STQ T1        
       CLA K20+2     L +0
       LDQ K20+6     L +50 IN MQ
       MPY* K0+3     MPY +50 -- K20+6
       LLS 35        
       LDQ K20+7     L +3100 IN MQ
       CAS K20+7     
       TRA A7A       
       TRA TX20      
 A7A   CAS T1        
       TRA A7B       
       TRA TX19      
 A7B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA A7        
       TRA A8        
 TX19  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX20  TSX OK,4      
       TRA A7        
       REM           
       REM           
       BCD 1DVP      TEST INSTRUCTION
 A8    CLA K20+2     L +0
       LDQ K20+7     L +3100 IN MQ
       LLS 24        
       DVP K0+3      DVP BY NO K20+6
       STQ T1        
       CLA K20+2     L +0
       LDQ K20+7     L +3100 IN MQ
       LLS 24        
       DVP* K0+3     DVP BY +50 -- K20+6
       STQ T1+1      
       LDQ K20+6     L +50 IN MQ
       LLS 24        
       CLA T1+1      
       ARS 24        
       CAS K20+6      
       TRA A8A       
       TRA TX22      
 A8A   CLA T1+1      
       CAS T1        
       TRA A8B       
       TRA TX21      
 A8B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA A8        
       TRA A9        
 TX21  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX22  TSX OK,4      
       TRA A8        
       REM           
       REM           
       BCD 1MPR      TEST INSTRUCTION
 A9    CLA K20+2     L +0
       LDQ K20+8     L +200000000000
       MPR K0+4      MPR BY NOP K20+8
       STQ T1        
       CLA K20+2     L +0
       LDQ K20+8     L +200000000000 IN MQ
       REM           -- K20+8
       MPR* K0+4     MPR BY +200000000000 
       LDQ K23+7     L +100000000000 
       CAS K23+7     
       TRA A9A       
       TRA TX24      
 A9A   CAS T1        
       TRA A9B       
       TRA TX23      
 A9B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA A9        
       TRA B1        
 TX23  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX24  TSX OK,4      
       TRA A9        
       REM           
       REM           
       REM           
       REM           WORD TRANSMISSION
       REM           INSTRUCTIONS
       REM           
       BCD 1LDQ      TEST INSTRUCTION
 B1    CLA K20+2     L +0
       LDQ* K0       L +00444 -- K20
       LLS 35        
       LDQ K20       L +444 IN MQ
       CAS K20       
       TRA B1A       
       TRA TX26      
 B1A   CAS K0        
       TRA B1B       
       TRA TX25      
 B1B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B1        
       TRA B2        
 TX25  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX26  TSX OK,4      
       TRA B1        
       REM           
       REM           
       BCD 1STQ      TEST INSTRUCTION
 B2    STZ T1        RESET T1 TO ZERO
       CLA T1+2      L NOP T1
       STO K0+5      
       CLA K20+2     L +0
       LDQ K20+1     L +00555
       STQ* K0+5     STORE +00555 IN T1 EFF ADR
       CLA T1        TEMP STOR L +00555
       CAS K20+1     
       TRA B2A       
       TRA TX28      
 B2A   CLA K0+5      L NOP T1
       CAS K20+1     
       TRA B2B       
       TRA TX27      
 B2B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B2        
       TRA B3        
 TX27  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX28  TSX OK,4      
       TRA B2        
       REM           
       REM           
       BCD 1SLQ      TEST INSTRUCTION
 B3    STZ T1        RESET T1 TO ZEROS
       CLA T1+2      L NOP T1
       STO K0+5      RESET
       LDQ K20+9     L +266777000000 IN MQ
       SLQ* K0+5     EFFECTIVE ADDR T1
       CLA T1        
       CAS K20+9     
       TRA B3A       
       TRA TX30      
 B3A   CLA K0+5      
       CAS K20+9     
       TRA B3B       
       TRA TX29      
 B3B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B3        
       TRA B4        
 TX29  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX30  TSX OK,4      
       TRA B3        
       REM           
       REM           
       BCD 1STO      TEST INSTRUCTION
 B4    STZ T1+1      RESET T1+1 TO ZEROS
       CLA T1+3      L NOP T1+1
       STO K0+6      RESET
       CLA K21+1     L +377777777777
       STO* K0+6     EFFECTIVE ADR T1+1
       LDQ K21+1     
       CLA T1+1      
       CAS K21+1     
       TRA B4A       
       TRA TX32      
 B4A   CLA K0+6      
       CAS K21+1     
       TRA B4B       
       TRA TX31      
 B4B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B4        
       TRA B5        
 TX31  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX32  TSX OK,4      
       TRA B4        
       REM           
       REM           
       BCD 1STP      TEST INSTRUCTION
 B5    STZ T1        RESET T1 TO ZEROS
       CLA T1+2      L NOP T1
       STO K0+5      RESET
       CLA K21+3     L +300000000000
       ALS 1         PLACE A 1 BIT IN P OF ACC
       STP* K0+5     STORE PREFIX EFF ADR T1
       TOV B5C       TURN OFF AC OVERFLOW IND
 B5C   LDQ K21+8     L -20000000000 IN MQ
       CLA T1        
       CAS K21+8     
       TRA B5A       
       TRA TX34      
 B5A   CLA K0+5      
       CAS K21+8     
       TRA B5B       
       TRA TX33      
 B5B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B5        
       TRA B6        
 TX33  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX34  TSX OK,4      
       TRA B5        
       REM           
       REM           
       BCD 1STD       TEST INSTRUCTION
 B6    STZ T1+1      RESET T1+1 TO ZEROS
       CLA T1+3      L NOP T1+1
       STO K0+6      RESET
       CLA K21+4     L +0777777000000
       STD* K0+6     STORE +077777000000 IN T1+1
       LDQ K21+4     L +0777777000000
       CLA T1+1      
       CAS K21+4     
       TRA B6A       
       TRA TX36      
 B6A   CLA K0+6      
       CAS K21+4     
       TRA B6B       
       TRA TX35      
 B6B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B6        
       TRA B7        
 TX35  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX36  TSX OK,4      
       TRA B6        
       REM           
       REM           
       BCD 1STA      TEST INSTRUCTION
 B7    STZ T1        RESET T1 TO ZEROS
       CLA T1+2      L NOP T1
       STO K0+5      RESET
       CLA K21+5     L +77777
       STA* K0+5     STORE +077777 IN T1
       LDQ K21+5     L +77777 IN MQ
       CLA T1        
       CAS K21+5     
       TRA B7A       
       TRA TX38      
 B7A   CLA K0+5      
       CAS K21+5     
       TRA B7B       
       TRA TX37      
 B7B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B7        
       TRA B8        
 TX37  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX38  TSX OK,4      
       TRA B7        
       REM           
       REM           
       REM           
       REM           LOGICAL OPERATIONS
       REM           
       BCD 1CAL      TEST INSTRUCTION
 B8    CAL* K0+7     L -37777777777 -- K21+6
       LDQ K21+6     L -37777777777 IN MQ
       PBT           
       TRA B8A       ZERO IN P BIT OF AC
       ARS 1         
       CAS K21+1     
       TRA B8A       
       TRA TX40      
 B8A   CAS K0+7      
       TRA B8B       
       TRA TX39      
 B8B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B8        
       TRA B9        
 TX39  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX40  TSX OK,4      
       TRA B8        
       REM           
       REM           
       BCD 1ACL      TEST INSTRUCTION
 B9    STZ T1        RESET T1 TO ZEROS
       CLA T1+2      L NOP T1
       STO K0+5      RESET
       CLA K21+7     L +377000000000
       ACL K0+8      ACL NOP K21+8
       SLW T1        
       CLA K21+7     L +377000000000
       ACL* K0+8     ACL -200000000000 -- K21+8
       LDQ K21+9     L +177000000001 IN MQ
       CAS K21+9     
       TRA B9A       
       TRA TX42      
 B9A   LAS T1        
       TRA B9B       
       TRA TX41      
 B9B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B9        
       TRA B10       
 TX41  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX42  TSX OK,4      
       TRA B9        
       REM           
       REM           
       BCD 1SLW      TEST INSTRUCTION
 B10   STZ T1        RESET T1 TO ZEROS
       CLA T1+2      L NOP T1
       STO K0+5      RESET
       CLA K21+1     L +377777777777
       ALS 1         PLACE 1 BIT IN P OF ACC
       TOV *+1       TURN OFF OVFL INDICATOR
       ADD K26+5     L +12
       SLW* K0+5     STORE -377777777777 IN T1
       LDQ K21+6     L -377777777777 IN MQ
       CLA T1        
       CAS K21+6     
       TRA B10A      
       TRA TX44      
 B10A  CLA K0+5      
       CAS K21+6     
       TRA B10B      
       TRA TX43      
 B10B  TSX ERROR-1,4 FAILED TO IA CORRECTY
       TRA B10       
       TRA B11       
 TX43  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX44  TSX OK,4      
       TRA B10       
       REM           
       REM           
       BCD 1ANA      TEST INSTRUCTION
 B11   CLA K21+1     L +377777777777
       ANA* K0+7     ANA -37777777777 -- K21+6
       LDQ K21+1     
       CAS K21+1     
       TRA B11A      
       TRA TX46      
 B11A  CAS K0+7      
       TRA B11B      
       TRA TX45      
 B11B  TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B11       
       TRA B12       
 TX45  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX46  TSX OK,4      
       TRA B11       
       REM           
       REM           
       BCD 1ANA      TEST INSTRUCTION
 B12   CLA K21+1     L +377777777777
       ALS 1         
       TOV *+1       TURN OFF OVFL INDICATOR
       ADD K26+5     L +1
       ANA* K0+8     ANA -2000000000000 -- K21+8
       LDQ K21+8     L -2000000000000 IN MQ
       LAS K21+8     
       TRA B12A      
       TRA TX48      
 B12A  LAS K0+8      
       TRA B12B      
       TRA TX47      
 B12B  TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B12       
       TRA B13       
 TX47  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX48  TSX OK,4      
       TRA B12       
       REM           
       REM           
       BCD 1ANS      TEST INSRUCTION
 B13   STZ T1+1      RESET T1+1 TO ZEROS
       CLA T1+3      L NOP T1+1
       STO K0+6      RESET
       CLA K21+6     L -377777777777
       STO T1+1      
       CLA K21       L +77777
       ANS* K0+6     ANS +077777 TO T1+1 EFF
       LDQ K21       
       CLA T1+1      
       CAS K21       
       TRA B13A      
       TRA TX50      
 B13A  CLA K0+6      
       CAS K21       
       TRA B13B      
       TRA TX49      
 B13B  TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B13       
       TRA B14       
 TX49  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX50  TSX OK,4      
       TRA B13       
       REM           
       REM           
       BCD 1ORA      TEST INSTRUCTION
 B14   STZ T1        RESET T1 TO ZEROS
       CLA K24+7     L +377740000000
       ORA K3+5      ORA NOP K24+3
       STO T1        
       CLA K24+7     L +377740000000
       ORA* K3+5     ORA +777777777 -- K24+3
       LDQ K21+1     L +377777777777 IN MQ
       CAS K21+1     
       TRA B14A      
       TRA TX52      
 B14A  CAS T1        
       TRA B14B      
       TRA TX51      
 B14B  TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B14       
       TRA B15       
 TX51  TSX ERROR,4   FALSE DIRECT ADDERSSING
 TX52  TSX OK,4      
       TRA B14       
       REM           
       REM           
       BCD 1ORS      TEST INSTRUCTION
 B15   STZ T1        RESET T1 TO ZEROS
       CLA T1+2      L NOP T1
       STO K0+5      RESET
       CLA K21+8     L -2000000000000
       STO T1        
       CLA K21+1     L +3777777777777
       ORS* K0+5     ORS +3777777777777 TO T1 EFF
       LDQ K21+6     L -3777777777777 IN MQ
       CLA T1        L -7777777777777
       CAS K21+6     
       TRA B15A      
       TRA TX54      
 B15A  CLA K0+5      L NOP T1
       CAS K21+1     
       TRA B15B      
       TRA TX53      
 B15B  TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA B15       
       TRA C1        
 TX53  TSX ERROR,4   FALSE DIRECT ADDERSSING
 TX54  TSX OK,4      
       TRA B15       
       REM           
       REM           
       REM           TEST - INDEXABLE TRANSFERS
       REM           
       BCD 1TRA      TEST INSTRUCTION
 C1    TRA* C2A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C1        
 C2    TRA C3        
 C2A   NOP TX55      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX55  TSX OK,4      
       TRA C1        
       REM           
       REM           
       BCD 1TZE      TEST INSTRUCTION
 C3    CLA K20+2     L +0
       TZE* C3A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C3        
       TRA C4        
 C3A   NOP TX56      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX56  TSX OK,4      
       TRA C3        
       REM           
       REM           
       BCD 1TPL      TEST INSTRUCTION
 C4    CLA K20       L +00444
       TPL* C4A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C4        
       TRA C5        
 C4A   NOP TX57      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX57  TSX OK,4      
       TRA C4        
       REM           
       REM           
       BCD 1TMI      TEST INSTRUCTION
 C5    CLA K21+6     L -377777777777
       TMI* C5A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C5        
       TRA C6        
 C5A   NOP TX58      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX58  TSX OK,4      
       TRA C5        
       REM           
       REM           
       BCD 1TOV      TEST INSTRUCTION
 C6    TOV C6+1      TURN OFF OVFLOW IND
       CLA K21+3     L +300000000000
       ALS 2         ACC LEFT SHIFT 2
       TOV* C6A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C6        
       TRA C7        
 C6A   NOP TX59      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX59  TSX OK,4      
       TRA C6        
       REM           
       REM           
       BCD 1TNO      TEST INSTRUCTION
 C7    TOV C7+1      TURN OFF OVFLOW IND
       TNO* C7A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C7        
       TRA C8        
 C7A   NOP TX60      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX60  TSX OK,4      
       TRA C8        
       REM           
       REM           
       BCD 1TQP      TEST INSTRUCTION
 C8    LDQ K20+1     L +00555 IN MQ
       TQP* C8A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C8        
       TRA C9        
 C8A   NOP TX61      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX61  TSX OK,4      
       TRA C8        
       REM           
       REM           
       BCD 1TQP      TEST INSTRUCTION
       REM           WITH MQ NOT PLUS
 C9    LDQ K21+6     L -377777777777 IN MQ
       TQP* C9A      SHOULD NOT XFER
       TRA TX62      
 C9A   NOP C9B       
       TSX ERROR-1,4 FALUSE XFER TO DIRECT ADR
       TRA C9        
       TRA C10       
 C9B   TSX ERROR,4   FALSE XFER TO TO INDIRECT ADR
 TX62  TSX OK,4      
       TRA C9        
       REM           
       REM           
       BCD 1TLQ      TEST INSTRUCTION
 C10   CLA K21+4     L +077777000000
       LDQ K21+5     L +000000077777 IN MQ
       TLQ* C10A     SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C10       
       TRA C11       
 C10A  NOP TX63      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX63  TSX OK,4      
       TRA C10       
       REM           
       REM           
       BCD 1TLQ      TEST INSTRUCTION
       REM           WITH MQ NOT LOW
 C11   CLA K21+8     L -200000000000
       LDQ K20+8     L +200000000000
       TLQ* C11A     SHOULD NOT XFER
       TRA TX64      
 C11A  NOP C11B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C11       
       TRA C12       
 C11B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX64  TSX OK,4      
       TRA C11       
       REM           
       REM           
       BCD 1TTR      TEST INSTRUCTION
       REM            IN NORMAL MODE
 C12   TTR* C12A     SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C12       
       TRA C13       
 C12A  NOP TX65      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX65  TSX OK,4      
       TRA C12       
       REM           
       REM           
       BCD 1CAS      TEST INSTRUCTION
       REM           WITH ACC HIGH
 C13   CLA K0        L NOP K20
       LDQ C13A      L TRA TX66 IN MQ
       CAS* K0       
 C13A  TRA TX66      
       TRA C13B      
       TSX ERROR-1,4 FAILED TO IA CORRECTLY
       REM           ACC SHOULD NOT BE LOW
       TRA C13       
       TRA C14       
 C13B  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX66  TSX OK,4      
       TRA C13       
       REM           
       REM           
       BCD 1CAS      TEST INSTRUCTION
       REM           WITH ACC LOW
 C14   CLA K2+1      L NOP K21+1
       LDQ C14A      L TRA TO TX68 IN MQ
       CAS* K2+1     
       TRA C14B      
       TRA TX67      
 C14A  TRA TX68      
 C14B  TSX ERROR-1,4 FAILED TO IA CORRECTLY
       REM           ACC SHOULD NOT BE HIGH
       TRA C14       
       TRA C15       
 TX67  TSX ERROR,4   FALSE DIRECT ADDRESSING
TX68   TSX OK,4      
       TRA C14       
       REM           
       REM           
       BCD 1LAS      TEST INSTRUCTION
       REM           WITH ACC HIGH
 C15   CLA K0        L NOP K20
       LDQ C15A      L TRA TX69 IN MQ
       LAS* K0       
 C15A  TRA TX69      
       TRA C15B      
       TSX ERROR-1,4 FAILED TO IA CORRECTLY
       REM           ACC SHOULD NOT BE LOW
       TRA C15       
       TRA C16       
 C15B  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX69  TSX OK,4      
       TRA C15       
       REM           
       REM           
       BCD 1LAS      TEST INSTRUCTION
       REM           WITH ACC LOW
 C16   CLA K2+1      L NOP K21+1
       LDQ C16A      L TRA TX71 IN MQ
       LAS* K2+1     
       TRA C16B      
       TRA TX70      
 C16A  TRA TX71      
 C16B  TSX ERROR-1,4 FAILED TO IA CORRECTLY
       REM           ACC SHOULD NOT BE HIGH
       TRA C16       
       TRA C17       
 TX70  TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX71  TSX OK,4      
       TRA C16       
       REM           
       REM           
       BCD 1TNZ      TEST INSTRUCTION
 C17   CLA K20       L +00444
       LDQ K20       L +00444 IN MQ
       TNZ* C17A     SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA C17       
       TRA C18       
 C17A  NOP TX72      
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX72  TSX OK,4      
       TRA C17       
       REM           
       REM           
       BCD 1ZET      TEST INSTRUCTION
 C18   LDQ K20+2     L +0 IN MQ
       CLA K2+2      L NOP K20+2
       ZET K2+2      SHOULD NOT SKIP
       TRA C18A      
       TSX ERROR-1,4 FALSE XFER ON NON ZERO
       TRA C18       
       TRA C19       
 C18A  CLA K20+2     L +0
       ZET*K2+2      SHOULD XFER
       TSX ERROR,4   FAILED TO IA CORRECTLY
       TSX OK,4      
       TRA C18       
       REM           
       REM           
       BCD 1NZT      TEST
 C19   LDQ K20+2     L +0 IN MQ
       CLA K2+2      L NOP K20+2
       NZT K2+2      
       TRA C19A      
       TRA C19B      
 C19A  TSX ERROR-1,4 FAILED TO XFER ON NON ZERO
       TRA C19       
       TRA C20       
 C19B  CLA K20+2     L +0
       NZT* K2+2     
       TRA TX73      
       TSX ERROR,4   FAILED TO IA CORRECTLY
 TX73  TSX OK,4      
       TRA C19       
       REM           
       REM           
       BCD 1TCOA     TEST INSTRUCTION
 C20   LDQ C20+3     L TRA TX74 IN MQ
       CLM           
       TCOA* C20A    SHOULD NOT TRANSFER
       TRA TX74      
 C20A  NOP C20B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C20       
       TRA C21       
 C20B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX74  TSX OK,4      
       TRA C20       
       REM           
       REM           
       BCD 1TCOB     TEST INSTRUCTION
 C21   LDQ C21+3     L TRA TX75 IN MQ
       CLM           
       TCOB* C21A    SHOULD NOT TRANSFER
       TRA TX75      
 C21A  NOP C21B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C21       
       TRA C22       
 C21B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX75  TSX OK,4      
       TRA C21       
       REM           
       REM           
       BCD 1TCOC     TEST INSTRUCTION
 C22   LDQ C22+3     L TRA TX76 IN MQ
       CLM           
       TCOC* C22A    SHOULD NOT TRANSFER
       TRA TX76      
 C22A  NOP C22B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C22       
       TRA C23       
 C22B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX76  TSX OK,4      
       TRA C22       
       REM           
       REM           
       BCD 1TCOD     TEST INSTRUCTION
 C23   LDQ C23+3     L TRA TX77 IN MQ
       CLM           
       TCOD* C23A    SHOULD NOT TRANSFER
       TRA TX77      
 C23A  NOP C23B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C23       
       TRA C24       
 C23B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX77  TSX OK,4      
       TRA C23       
       REM           
       REM           
       BCD 1TCOE     TEST INSTRUCTION
 C24   LDQ C24+3     L TRA TX78 IN MQ
       CLM           
       TCOE* C24A    SHOULD NOT TRANSFER
       TRA TX78      
 C24A  NOP C24B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C24       
       TRA C25       
 C24B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX78  TSX OK,4      
       TRA C24       
       REM           
       REM           
       BCD 1TCOF     TEST INSTRUCTION
 C25   LDQ C25+3     L TRA TX79 IN MQ
       CLM           
       TCOF* C25A    SHOULD NOT TRANSFER
       TRA TX79      
 C25A  NOP C24B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C25       
       TRA C26       
 C25B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX79  TSX OK,4      
       TRA C25       
       REM           
       REM           
       BCD 1TCNA     TEST INSTRUCTION
 C26   LDQ C26+2     L TAN C26A,0,48 IN MQ
       CLM           
       TCNA* C26A    SHOULD NOT TRANSFER
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C26       
       TRA C27       
 C26A  NOP TX80      
       TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX80  TSX OK,4      
       TRA C26       
       REM           
       REM           
       BCD 1TCNB     TEST INSTRUCTION
 C27   LDQ C27+2     L TBN C27A,0,48 IN MQ
       CLM           
       TCNB* C27A    SHOULD NOT TRANSFER
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C27       
       TRA C28       
 C27A  NOP TX81      
       TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX81  TSX OK,4      
       TRA C27       
       REM           
       REM           
       BCD 1TCNC     TEST INSTRUCTION
 C28   LDQ C28+2     L TCN C28A,0,48 IN MQ
       CLM           
       TCNC* C28A    SHOULD NOT TRANSFER
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C28       
       TRA C29       
 C28A  NOP TX82      
       TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX82  TSX OK,4      
       TRA C28       
       REM           
       REM           
       BCD 1TCND     TEST INSTRUCTION
 C29   LDQ C29+2     L TDN C269,0,48 IN MQ
       CLM           
       TCND* C29A    SHOULD NOT TRANSFER
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C29       
       TRA C30       
 C29A  NOP TX83      
       TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX83  TSX OK,4      
       TRA C29       
       REM           
       REM           
       BCD 1TCNE     TEST INSTRUCTION
 C30   LDQ C30+2     L TEN C30A,0,48 IN MQ
       CLM           
       TCNE* C30A    SHOULD NOT TRANSFER
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C30       
       TRA C31       
 C30A  NOP TX84      
       TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX84  TSX OK,4      
       TRA C30       
       REM           
       REM           
       BCD 1TCNF     TEST INSTRUCTION
 C31   LDQ C31+2     L TFN C31A,0,48 IN MQ
       CLM           
       TCNF* C31A    SHOULD NOT TRANSFER
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C31       
       TRA C32       
 C31A  NOP TX85      
       TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX85  TSX OK,4      
       TRA C31       
       REM           
       REM           
       BCD 1TRCA     TEST INSTRUCTION
 C32   LDQ C32+3     L TRA TX86 IN MQ
       CLM           
       TRCA* C32A    SHOULD NOT TRANSFER
       TRA TX86      
 C32A  NOP C32B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C32       
       TRA C33       
 C32B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX86  TSX OK,4      
       TRA C32       
       REM           
       REM           
       BCD 1TRCB     TEST INSTRUCTION
 C33   LDQ C33+3     L TRA TX87 IN MQ
       CLM           
       TRCB* C33A    SHOULD NOT TRANSFER
       TRA TX87      
 C33A  NOP C33B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C33       
       TRA C34       
 C33B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX87  TSX OK,4      
       TRA C33       
       REM           
       REM           
       BCD 1TRCC     TEST INSTRUCTION
 C34   LDQ C34+3     L TRA TX88 IN MQ
       CLM           
       TRCC* C34A    SHOULD NOT TRANSFER
       TRA TX88      
 C34A  NOP C34B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C34       
       TRA C35       
 C34B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX88  TSX OK,4      
       TRA C34       
       REM           
       REM           
       BCD 1TRCD     TEST INSTRUCTION
 C35   LDQ C35+3     L TRA TX89 IN MQ
       CLM           
       TRCD* C35A    SHOULD NOT TRANSFER
       TRA TX89      
 C35A  NOP C35B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C35       
       TRA C36       
 C35B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX89  TSX OK,4      
       TRA C35       
       REM           
       REM           
       BCD 1TRCE     TEST INSTRUCTION
 C36   LDQ C36+3     L TRA TX90 IN MQ
       CLM           
       TRCE* C36A    SHOULD NOT TRANSFER
       TRA TX90      
 C36A  NOP C36B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C36       
       TRA C37       
 C36B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX90  TSX OK,4      
       TRA C36       
       REM           
       REM           
       BCD 1TRCF     TEST INSTRUCTION
 C37   LDQ C37+3     L TRA TX91 IN MQ
       CLM           
       TRCF* C37A    SHOULD NOT TRANSFER
       TRA TX91      
 C37A  NOP C37B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C37       
       TRA C38       
 C37B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX91  TSX OK,4      
       TRA C37       
       REM           
       REM           
       BCD 1TEFA     TEST INSTRUCTION
 C38   LDQ C38+3     L TRA TX92 IN MQ
       CLM           
       TEFA* C38A    SHOULD NOT TRANSFER
       TRA TX92      
 C38A  NOP C38B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C38       
       TRA C39       
 C38B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX92  TSX OK,4      
       TRA C38       
       REM           
       REM           
       BCD 1TEFB     TEST INSTRUCTION
 C39   LDQ C39+3     L TRA TX93 IN MQ
       CLM           
       TEFB* C39A    SHOULD NOT TRANSFER
       TRA TX93      
 C39A  NOP C39B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C39       
       TRA C40       
 C39B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX93  TSX OK,4      
       TRA C39       
       REM           
       REM           
       BCD 1TEFC     TEST INSTRUCTION
 C40   LDQ C40+3     L TRA TX94 IN MQ
       CLM           
       TEFC* C40A    SHOULD NOT TRANSFER
       TRA TX94      
 C40A  NOP C40B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C40       
       TRA C41       
 C40B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX94  TSX OK,4      
       TRA C40       
       REM           
       REM           
       BCD 1TEFD     TEST INSTRUCTION
 C41   LDQ C41+3     L TRA TX95 IN MQ
       CLM           
       TEFD* C41A    SHOULD NOT TRANSFER
       TRA TX95      
 C41A  NOP C41B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C41       
       TRA C42       
 C41B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX95  TSX OK,4      
       TRA C41       
       REM           
       REM           
       BCD 1TEFE     TEST INSTRUCTION
 C42   LDQ C42+3     L TRA TX96 IN MQ
       CLM           
       TEFE* C42A    SHOULD NOT TRANSFER
       TRA TX96      
 C42A  NOP C42B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C42       
       TRA C43       
 C42B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX96  TSX OK,4      
       TRA C42       
       REM           
       REM           
       BCD 1TEFF     TEST INSTRUCTION
 C43   LDQ C43+3     L TRA TX97 IN MQ
       CLM           
       TEFF* C43A    SHOULD NOT TRANSFER
       TRA TX97      
 C43A  NOP C43B      
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA C43       
       TRA CT        
 C43B  TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX97  TSX OK,4      
       TRA C43       
       REM           
       REM           
       REM           TEST - INDEXABLE TRANSFERS
       REM           IN TRAPPING MODE
       REM           
       REM           SET TRAP RETURN
       NOP           
 CT    CLA K28+4     L TRA 0
       STO 0         
       STO 5         
       CLA K28       L CLA 0
       STO 1         
       CLA K28+1     L ADD 10 DEC
       STO 2         
       CLA K28+2     L STO 5
       STO 3         
       CLA K28+3     L LTM
       STO 4         
       TRA CT1       
       REM           
       REM           
       REM           
       BCD 1TRA-     TEST INSTRUCTION
 CT1   ETM           ENTER TRAPPING MODE
       TRA* CT1A     SHOULD TRAP
 CT1A  NOP CT1B      
       LTM           LEAVING TRAPPNG MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE DIRECT ADDRESSING
       TRA CT1       
       NOP           
       TRA CT3       
 CT1B  LTM           LEAVING TRAPPING MODE
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE IA IN TRAPPING MODE
 TX130 TSX OK,4      
       TRA CT1       
       REM           
       REM           
       BCD 1TZE-     TEST INSTRUCTION
 CT3   ETM           ENTER TRAPPING MODE
       CLA K20+2     L +0
       TZE* CT3A     SHOULD TRAP
 CT3A  NOP CT3B      
       LTM           LEAVING TRAPPNG MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE DIRECT ADDRESSING
       TRA CT3       
       TRA CT4       
 CT3B  LTM           LEAVING TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE IA IN TRAPPING MODE
 TX131 TSX OK,4      
       TRA CT3       
       REM           
       REM           
       BCD 1TPL-     TEST INSTRUCTION
 CT4   ETM           ENTER TRAPPING MODE
       CLA K20       L +00444
       TPL* CT4A     SHOULD TRAP
 CT4A  NOP CT4B      
       LTM           LEAVING TRAPPNG MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE DIRECT ADDRESSING
       TRA CT4       
       TRA CT5       
 CT4B  LTM           LEAVING TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE IA IN TRAPPING MODE
 TX132 TSX OK,4      
       TRA CT4       
       REM           
       REM           
       BCD 1TMI-     TEST INSTRUCTION
 CT5   ETM           ENTER TRAPPING MODE
       CLA K21+6     L -377777777777
       TMI* CT5A     SHOULD TRAP
 CT5A  NOP CT5B      
       LTM           LEAVING TRAPPNG MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE DIRECT ADDRESSING
       TRA CT5       
       TRA CT6       
 CT5B  LTM           LEAVING TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE IA IN TRAPPING MODE
 TX133 TSX OK,4      
       TRA CT5       
       REM           
       BCD 1TOV-     TEST INSTRUCTION
 CT6   TOV CT6+1     TURN OFF OVERFLOW IND
       ETM           ENTER TRAPPING MODE
       CLA K21+3     L +300000000000
       ALS 2         ACC LEFT SHIFT
       TOV* CT6A     SHOULD TRAP
 CT6A  NOP CT6B      
       LTM           LEAVING TRAPPNG MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE DIRECT ADDRESSING
       TRA CT6       
       TRA CT7       
 CT6B  LTM           LEAVING TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE IA IN TRAPPING MODE
 TX134 TSX OK,4      
       TRA CT6       
       REM           
       REM           
       BCD 1TNO-     TEST INSTRUCTION
 CT7   TOV CT7+1     TURN OFF OVERFLOW IND
       ETM           ENTER TRAPPING MODE
       TNO* CT7A     SHOULD TRAP
 CT7A  NOP CT7B      
       LTM           LEAVING TRAPPNG MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE DIRECT ADDRESSING
       TRA CT7       
       TRA CT8       
 CT7B  LTM           LEAVING TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE IA IN TRAPPING MODE
 TX135 TSX OK,4      
       TRA CT7       
       REM           
       REM           
       BCD 1TQP-     TEST INSTRUCTION
 CT8   LDQ K20+1     L +00555 IN MQ
       ETM           ENTER TRAPPING MODE
       TQP* CT8A     SHOULD TRAP
 CT8A  NOP CT8B      
       LTM           LEAVING TRAPPNG MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE DIRECT ADDRESSING
       TRA CT8       
       TRA CTA       
 CT8B  LTM           LEAVING TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE IA IN TRAPPING MODE
 TX136 TSX OK,4      
       TRA CT8       
       REM           
       REM           
       REM           SET TRAP RETURN
       REM           
       NOP           
 CTA   CLA K28+7     L ADD 15 DECIMAL
       STO 2         
       TRA CT9       
       REM           
       REM           
       BCD 1TQP      TEST INSTRUCTION
       REM           WITH MQ NOT PLUS
 CT9   LDQ K21+6     L -377777777777 IN MQ
       ETM           ENTER TRAPPING MODE
       TQP* CT9A     SHOULD NOT TRAP OR XFER
       LTM           LEAVE TRAPPING MODE
       TRA TX137     
 CT9A  NOP CT9B      
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT9       
       TRA CT10      
 CT9B  LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT9
       TRA CT10
       NOP           
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FALSE TRAP
 TX137 TSX OK,4      
       TRA CT9       
       REM           
       REM           
       BCD 1TLQ-     TEST INSTRUCTION
 CT10  CLA K21+4     L +077777000000
       LDQ K21+5     L +000000077777 IN MQ
       ETM           ENTER TRAPPING MODE
       TLQ* CT10A    SHOULD TRAP
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP OR XFER
       TRA CT10      
       TRA CT11      
 CT10A NOP CT10B     
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP 
       REM           FALSE DIRECT ADDRESSING
       TRA CT10      
       TRA CT11      
 CT10B LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FALSE TRAP
 TX138 TSX OK,4      
       TRA CT10      
       REM           
       REM           
       BCD 1TLQ      TEST INSTRUCTION
       REM           WITH MQ NOT LOW
       REM
 CT11  CLA K21+8     L -200000000000
       LDQ K20+8     L +200000000000 IN MQ
       ETM           ENTER TRAPPING MODE
       TLQ* CT11A    SHOULD NOT TRAP OR XFER
       LTM           LEAVE TRAPPING MODE
 CT11C TRA TX139     
 CT11A NOP CT11B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT11C     L TRA TX19 IN MQ
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT11      
       TRA CT12      
 CT11B LTM           LEAVE TRAPPING MODE
       LDQ CT11C     L TRA TX139 IN MQ
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT11      
       TRA CT12      
       NOP           
       LDQ CT11C     L TRA TX139 IN MQ
       TSX ERROR,4   FALSE TRAP
 TX139 TSX OK,4      
       TRA CT11      
       REM           
       BCD 1TTR      TEST INSTRUCTION
       REM            IN TRAPPING MODE
 CT12  ETM           ENTER TRAPPING MODE
       TTR* CT12A    SHOULD XFER IN NORMAL MODE
       LTM           LEAVE TRAPPING MODE
       LDQ CT12A,0,48 L TTR CT12A,0,48 IN MQ
       TSX ERROR-1,4 FAILED TO XFER
       TRA CT12      
       TRA CT17      
 CT12A NOP CT12B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT12+1    L TTR CT12A* IN MQ
       TSX ERROR-1,4 FALSE DIRECT ADDRESSING
       TRA CT12      
       TRA CT17      
 CT12B LTM           LEAVE TRAPPING MODE
       TRA TX140     
       NOP           
       LDQ CT12+1    L TTR CT12A* IN MQ
       TSX ERROR,4   FALSE TRAP
 TX140 TSX OK,4      
       TRA CT12      
       REM           
       REM           
       BCD 1TNZ-     TEST INSTRUCTION
 CT17  CLA K20       L +00444
       ETM           ENTER TRAPPING MODE
       TNZ* CT17A    SHOULD TRAP
       LTM           LEAVE TRAPPING MODE
       TSX ERROR-1,4 FAILED TO TRAP OR XFER
       TRA CT17      
       TRA CT20      
       NOP           
 CT17A NOP CT17B     
       LTM           LEAVE TRAPPING MODE
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE DIRECT ADDRESSING
       TRA CT17      
       TRA CT20      
       NOP           
       NOP           
 CT17B LTM           LEAVE TRAPPING MODE
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE IA IN TRAPPING MODE
 TX145 TSX OK,4      
       TRA CT17      
       REM           
       REM           
       BCD 1TCOA     TEST INSTRUCTION
 CT20  ETM           ENTER TRAPPING MODE
       CLM           
       TCOA* CT20A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT20C TRA TX148     
 CT20A NOP CT20B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT20C     L TRA TX148
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT20      
       TRA CT21      
       NOP           
 CT20B LTM           LEAVE TRAPPING MODE
       LDQ CT20C     L TRA TX148
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT20      
       TRA CT21      
       LDQ CT20C     L TRA TX148
       TSX ERROR,4   FALSE TRAP
 TX148 TSX OK,4      
       TRA CT20      
       REM           
       REM           
       BCD 1TCOB     TEST INSTRUCTION
 CT21  ETM           ENTER TRAPPING MODE
       TCOB* CT21A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT21C TRA TX149     
 CT21A NOP CT21B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT21C     L TRA TX149
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT21      
       TRA CT22      
       NOP           
 CT21B LTM           LEAVE TRAPPING MODE
       LDQ CT21C     L TRA TX149
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT21      
       TRA CT22      
       LDQ CT21C     L TRA TX149
       TSX ERROR,4   FALSE TRAP
 TX149 TSX OK,4      
       TRA CT21      
       REM           
       REM           
       BCD 1TCOC     TEST INSTRUCTION
 CT22  ETM           ENTER TRAPPING MODE
       TCOC* CT22A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT22C TRA TX150     
 CT22A NOP CT22B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT22C     L TRA TX150
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT22      
       TRA CT23      
       NOP           
 CT22B LTM           LEAVE TRAPPING MODE
       LDQ CT22C     L TRA TX150
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT22      
       TRA CT23      
       LDQ CT22C     L TRA TX150
       TSX ERROR,4   FALSE TRAP
 TX150 TSX OK,4      
       TRA CT22      
       REM           
       REM           
       BCD 1TCOD     TEST INSTRUCTION
 CT23  ETM           ENTER TRAPPING MODE
       TCOD* CT23A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT23C TRA TX151     
 CT23A NOP CT23B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT23C     L TRA TX151
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT23      
       TRA CT24      
       NOP           
 CT23B LTM           LEAVE TRAPPING MODE
       LDQ CT23C     L TRA TX151
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT23      
       TRA CT24      
       LDQ CT23C     L TRA TX151
       TSX ERROR,4   FALSE TRAP
 TX151 TSX OK,4      
       TRA CT23      
       REM           
       REM           
       BCD 1TCOE     TEST INSTRUCTION
 CT24  ETM           ENTER TRAPPING MODE
       TCOE* CT24A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT24C TRA TX152     
 CT24A NOP CT24B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT24C     L TRA TX152
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT24      
       TRA CT25      
       NOP           
 CT24B LTM           LEAVE TRAPPING MODE
       LDQ CT24C     L TRA TX152
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT24      
       TRA CT25      
       LDQ CT24C     L TRA TX152
       TSX ERROR,4   FALSE TRAP
 TX152 TSX OK,4      
       TRA CT24      
       REM           
       REM           
       BCD 1TCOF     TEST INSTRUCTION
 CT25  ETM           ENTER TRAPPING MODE
       TCOF* CT25A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT25C TRA TX153     
 CT25A NOP CT25B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT25C     L TRA TX153
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT25      
       TRA CT26      
       NOP           
 CT25B LTM           LEAVE TRAPPING MODE
       LDQ CT25C     L TRA TX153
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT25      
       TRA CT26      
       LDQ CT25C     L TRA TX153
       TSX ERROR,4   FALSE TRAP
 TX153 TSX OK,4      
       TRA CT25      
       REM           
       REM           
       BCD 1TCNA-    TEST INSTRUCTION
 CT26  ETM           ENTER TRAPPING MODE
       TCNA* CT26A   SHOULD TRAP
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP OR XFER
       TRA CT26      
       TRA CT27      
 CT26A NOP CT26B     
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE XFER TO IND ADR
       TRA CT26      
       TRA CT27      
 CT26B LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE XFER TO DIRECT ADR
 TX154 TSX OK,4      
       TRA CT26      
       REM           
       REM           
       BCD 1TCNB-    TEST INSTRUCTION
 CT27  ETM           ENTER TRAPPING MODE
       TCNB* CT27A   SHOULD TRAP
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP OR XFER
       TRA CT27      
       TRA CT28      
 CT27A NOP CT27B     
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE XFER TO IND ADR
       TRA CT27      
       TRA CT28      
 CT27B LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE XFER TO DIRECT ADR
 TX155 TSX OK,4      
       TRA CT27      
       REM           
       REM           
       BCD 1TCNC-    TEST INSTRUCTION
 CT28  ETM           ENTER TRAPPING MODE
       TCNC* CT28A   SHOULD TRAP
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP OR XFER
       TRA CT28      
       TRA CT29      
 CT28A NOP CT28B     
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE XFER TO IND ADR
       TRA CT28      
       TRA CT29      
 CT28B LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE XFER TO DIRECT ADR
 TX156 TSX OK,4      
       TRA CT28      
       REM           
       REM           
       BCD 1TCND-    TEST INSTRUCTION
 CT29  ETM           ENTER TRAPPING MODE
       TCND* CT29A   SHOULD TRAP
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP OR XFER
       TRA CT29      
       TRA CT30      
 CT29A NOP CT29B     
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE XFER TO IND ADR
       TRA CT29      
       TRA CT30      
 CT29B LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE XFER TO DIRECT ADR
 TX157 TSX OK,4      
       TRA CT30      
       REM           
       REM           
       BCD 1TCNE-    TEST INSTRUCTION
 CT30  ETM           ENTER TRAPPING MODE
       TCNE* CT30A   SHOULD TRAP
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP OR XFER
       TRA CT30      
       TRA CT31      
 CT30A NOP CT30B     
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE XFER TO IND ADR
       TRA CT30      
       TRA CT31      
 CT30B LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE XFER TO DIRECT ADR
 TX158 TSX OK,4      
       TRA CT30      
       REM           
       REM           
       BCD 1TCNF-    TEST INSTRUCTION
 CT31  ETM           ENTER TRAPPING MODE
       TCNF* CT31A   SHOULD TRAP
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP OR XFER
       TRA CT31      
       TRA CT32      
 CT31A NOP CT31B     
       LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR-1,4 FAILED TO TRAP
       REM           FALSE XFER TO IND ADR
       TRA CT31      
       TRA CT32      
 CT31B LTM           LEAVE TRAPPING MODE
       LDQ K28+6     L TRA 1 IN MQ
       TSX ERROR,4   FAILED TO TRAP
       REM           FALSE XFER TO DIRECT ADR
 TX159 TSX OK,4      
       TRA CT31      
       REM           
       REM           
       BCD 1TRCA     TEST INSTRUCTION
 CT32  ETM           ENTER TRAPPING MODE
       TRCA* CT32A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT32C TRA TX160     
 CT32A NOP CT32B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT32C     L TRA TX160
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT32      
       TRA CT33      
       NOP           
 CT32B LTM           LEAVE TRAPPING MODE
       LDQ CT32C     L TRA TX160
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT32      
       TRA CT33      
       LDQ CT32C     L TRA TX160
       TSX ERROR,4   FALSE TRAP
 TX160 TSX OK,4      
       TRA CT32      
       REM           
       REM           
       BCD 1TRCB     TEST INSTRUCTION
 CT33  ETM           ENTER TRAPPING MODE
       TRCB* CT33A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT33C TRA TX161     
 CT33A NOP CT33B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT33C     L TRA TX161
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT33      
       TRA CT34      
       NOP           
 CT34B LTM           LEAVE TRAPPING MODE
       LDQ CT33C     L TRA TX161
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT33      
       TRA CT34      
       LDQ CT33C     L TRA TX161
       TSX ERROR,4   FALSE TRAP
 TX161 TSX OK,4      
       TRA CT33      
       REM           
       REM           
       BCD 1TRCC     TEST INSTRUCTION
 CT34  ETM           ENTER TRAPPING MODE
       TRCC* CT34A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT34C TRA TX162     
 CT34A NOP CT34B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT34C     L TRA TX162
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT34      
       TRA CT35      
       NOP           
 CT33B LTM           LEAVE TRAPPING MODE
       LDQ CT34C     L TRA TX162
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT34      
       TRA CT35      
       LDQ CT34C     L TRA TX162
       TSX ERROR,4   FALSE TRAP
 TX162 TSX OK,4      
       TRA CT34      
       REM           
       REM           
       BCD 1TRCD     TEST INSTRUCTION
 CT35  ETM           ENTER TRAPPING MODE
       TRCD* CT35A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT35C TRA TX163     
 CT35A NOP CT35B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT35C     L TRA TX163
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT35      
       TRA CT36      
       NOP           
 CT35B LTM           LEAVE TRAPPING MODE
       LDQ CT35C     L TRA TX163
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT35      
       TRA CT36      
       LDQ CT35C     L TRA TX163
       TSX ERROR,4   FALSE TRAP
 TX163 TSX OK,4      
       TRA CT35      
       REM           
       REM           
       BCD 1TRCE     TEST INSTRUCTION
 CT36  ETM           ENTER TRAPPING MODE
       TRCE* CT36A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT36C TRA TX164     
 CT36A NOP CT36B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT36C     L TRA TX164
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT36      
       TRA CT37      
       NOP           
 CT36B LTM           LEAVE TRAPPING MODE
       LDQ CT36C     L TRA TX164
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT36      
       TRA CT37      
       LDQ CT36C     L TRA TX164
       TSX ERROR,4   FALSE TRAP
 TX164 TSX OK,4      
       TRA CT36      
       REM           
       REM           
       BCD 1TRCF     TEST INSTRUCTION
 CT37  ETM           ENTER TRAPPING MODE
       TRCF* CT37A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT37C TRA TX165     
 CT37A NOP CT37B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT37C     L TRA TX165
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT37      
       TRA CT38      
       NOP           
 CT37B LTM           LEAVE TRAPPING MODE
       LDQ CT37C     L TRA TX165
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT37      
       TRA CT38      
       LDQ CT37C     L TRA TX165
       TSX ERROR,4   FALSE TRAP
 TX165 TSX OK,4      
       TRA CT37      
       REM           
       REM           
       BCD 1TEFA     TEST INSTRUCTION
 CT38  ETM           ENTER TRAPPING MODE
       TEFA* CT38A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT38C TRA TX166     
 CT38A NOP CT38B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT38C     L TRA TX166
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT38      
       TRA CT39      
       NOP           
 CT38B LTM           LEAVE TRAPPING MODE
       LDQ CT38C     L TRA TX166
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT38      
       TRA CT39      
       LDQ CT38C     L TRA TX166
       TSX ERROR,4   FALSE TRAP
 TX166 TSX OK,4      
       TRA CT38      
       REM           
       REM           
       BCD 1TEFB     TEST INSTRUCTION
 CT39  ETM           ENTER TRAPPING MODE
       TEFB* CT39A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT39C TRA TX167     
 CT39A NOP CT39B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT39C     L TRA TX167
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT39      
       TRA CT40      
       NOP           
 CT39B LTM           LEAVE TRAPPING MODE
       LDQ CT39C     L TRA TX167
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT39      
       TRA CT40      
       LDQ CT39C     L TRA TX167
       TSX ERROR,4   FALSE TRAP
 TX167 TSX OK,4      
       TRA CT39      
       REM           
       REM           
       BCD 1TEFC     TEST INSTRUCTION
 CT40  ETM           ENTER TRAPPING MODE
       TEFC* CT40A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT40C TRA TX168     
 CT40A NOP CT40B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT40C     L TRA TX168
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT40      
       TRA CT41      
       NOP           
 CT40B LTM           LEAVE TRAPPING MODE
       LDQ CT40C     L TRA TX168
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT40      
       TRA CT41      
       LDQ CT40C     L TRA TX168
       TSX ERROR,4   FALSE TRAP
 TX168 TSX OK,4      
       TRA CT40      
       REM           
       REM           
       BCD 1TEFD     TEST INSTRUCTION
 CT41  ETM           ENTER TRAPPING MODE
       TEFD* CT41A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT41C TRA TX169     
 CT41A NOP CT41B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT41C     L TRA TX169
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT41      
       TRA CT42      
       NOP           
 CT41B LTM           LEAVE TRAPPING MODE
       LDQ CT41C     L TRA TX169
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT41      
       TRA CT42      
       LDQ CT41C     L TRA TX169
       TSX ERROR,4   FALSE TRAP
 TX169 TSX OK,4      
       TRA CT41      
       REM           
       REM           
       BCD 1TEFE     TEST INSTRUCTION
 CT42  ETM           ENTER TRAPPING MODE
       TEFE* CT42A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT42C TRA TX170     
 CT42A NOP CT42B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT42C     L TRA TX170
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT42      
       TRA CT43      
       NOP           
 CT42B LTM           LEAVE TRAPPING MODE
       LDQ CT42C     L TRA TX170
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT42      
       TRA CT43      
       LDQ CT42C     L TRA TX170
       TSX ERROR,4   FALSE TRAP
 TX170 TSX OK,4      
       TRA CT42      
       REM           
       REM           
       BCD 1TEFF     TEST INSTRUCTION
 CT43  ETM           ENTER TRAPPING MODE
       TEFF* CT43A   SHOULD NOT TRAP OR TRANSFER
       LTM           LEAVE TRAPPING MODE
 CT43C TRA TX171     
 CT43A NOP CT43B     
       LTM           LEAVE TRAPPING MODE
       LDQ CT43C     L TRA TX171
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA CT43      
       TRA EA      
       NOP           
 CT43B LTM           LEAVE TRAPPING MODE
       LDQ CT43C     L TRA TX171
       TSX ERROR-1,4 FALSE XFER TO IND ADR
       TRA CT43      
       TRA EA        
       LDQ CT43C     L TRA TX171
       TSX ERROR,4   FALSE TRAP
 TX171 TSX OK,4      
       TRA CT43      
       REM           
       REM           
       NOP           
 EA    CLA TX2A      POST
       STO 0         RESTART
       TRA E1        
       REM           
       REM           SENSE INDICATOR INSTRUCTIONS
       REM           WITH REFERENCE TO STORAGE
       REM           
       BCD 1LDI      TEST INSTRUCTION
 E1    LDI* K2+1     L 377777777777 -- K21+1
       PIA           
       LAS K21+1     
       TRA E1A       
       TRA TX230     
 E1A   LAS K2+1      
       TRA E1B       
       TRA E1C       
 E1B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA E1        
       TRA E2        
 E1C   TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX230 TSX OK,4      
       TRA E1        
       REM           
       REM           
       BCD 1OSI      TEST INSTRUCTION
 E2    STZ T1        RESET T1
       LDI K24+7     L 377740000000 IN INDS
       OSI K3+5      L 0761000K24+3
       STI T1        
       LDI K24+7     L 377740000000
       OSI* K3+5     L 000777777777 -- K24+3
       PIA           
       LAS K21+1     
       TRA E2A       
       TRA TX231     
 E2A   LAS T1        
       TRA E2B       
       TRA E2C       
 E2B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA E2        
       TRA E3        
 E2C   TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX231 TSX OK,4      
       TRA E2        
       REM           
       REM           
       BCD 1RIS      TEST INSTRUCTION
 E3    STZ T1        RESET T1
       LDI K21+1     L 377777777777 IN INDS
       RIS K3+5      
       STI T1        
       LDI K21+1     L 377777777777 IN INDS
       RIS* K3+5     RIS 000777777777 --K24+3
       PIA           
       LAS K21+7     
       TRA E3A       
       TRA TX232     
 E3A   LAS T1        
       TRA E3B       
       TRA E3C       
 E3B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA E3        
       TRA E4        
 E3C   TSX ERROR,4   
 TX232 TSX OK,4      
       TRA E3        
       REM           
       REM           
       BCD 1IIS      TEST INSTRUCTION
 E4    STZ T1        RESET T1
       LDI K21+1     L 377777777777 IN INDS
       IIS K3+5      
       STI T1        
       LDI K21+1     L 377777777777 IN INDS
       IIS* K3+5     IIS 000777777777 -- K24+3
       PIA           
       LAS K21+7     
       TRA E4A       
       TRA TX233     
 E4A   LAS T1        
       TRA E4B       
       TRA E4C       
 E4B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA E4        
       TRA E6        
 E4C   TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX233 TSX OK,4      
       TRA E4        
       REM           
       REM           
       BCD 1STI      TEST INSTRUCTION
 E5    STZ T1        RESET
       CLA T1+2      L NOP T1
       STO K0+5      
       LDI K21+1     L 3777777777777 IN INDS
       STI* K0+5     
       CLA K21+1     L 3777777777777
       CAS T1        
       TRA E5A       
       TRA TX234     
 E5A   CAS K0+5      
       TRA E5B       
       TRA E5C       
 E5B   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA E5        
       TRA E6        
 E5C   TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX234 TSX OK,4      
       TRA E5        
       REM           
       REM           
       REM           
       REM           SENSE INDICATOR
       REM           TRANSFER INSTRUCTIONS
       REM           
       BCD 1TIO      TEST INSTRUCTION
 E6    CLA K24+2     L 000007070707
       LDI K24+2     L 000007070707 IN INDS
       TIO* E6A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA E6        
       TRA E7        
 E6A   NOP TX235     
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX235 TSX OK,4      
       TRA E6        
       REM           
       REM           
       BCD 1TIF      TEST INSTRUCTION
 E7    CLA K24       L 200000707070
       LDI K24+2     L 0000007070707 IN INDS
       TIF* E7A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA E7        
       TRA E8        
 E7A   NOP TX236     
       TSX ERROR,4   FALSE DIRECT ADDRESSING
 TX236 TSX OK,4      
       TRA E7        
       REM           
       REM           
       BCD 1ONT      TEST INSTRUCTION
 E8    LDI K24+2     L 000007070707 IN INDS
       ONT* K3+6     SHOULD SKIP
       TRA E8A       FAILED TO SKIP
       TRA TX237     
 E8A   LDI K3+6      
       ONT* K3+6     
       TRA E8B       
       TSX ERROR-1,4 FALSE DIRECT ADDRESSING
       TRA E8        
       TRA E9        
 E8B   TSX ERROR,4   FAILED TO IA CORRECTLY
 TX237 TSX OK,4      
       TRA E8        
       REM           
       REM           
       BCD 1OFT      TEST INSTRUCTION
 E9    LDI K24+2     L 000007070707 IN INDS
       OFT* K3+4     SHOULD SKIP
       TRA E9A       FAILED TO SKIP
       TRA TX238     
 E9A   LDI K3+4      
       IIS K3+4      
       OFT* K3+4     
       TRA E9B       
       TSX ERROR-1,4 FALSE DIRECT ADDRESSING
       TRA E9        
       TRA F1        
 E9B   TSX ERROR,4   FAILED TO IA CORRECTLY
 TX238 TSX OK,4      
       TRA E9        
       REM           
       REM           
       REM           TEST-COMPREHENSIVE
       REM           INDIRECT ADDRESSING
       REM           
       NOP           
 F1    CLA* K0       L +00444 -- K20
       ADD* K0+1     L +00555 -- K20+1
       SUB* K0       L +00444 -- K20
       STO* K0+5     T1 EFF
       TPL* F1A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA F1        
       TRA F2        
 F1A   NOP TX250     
       TSX ERROR,4   FALSE XFER TO DIRECT ADR
 TX250 TSX OK,4      
       TRA F1        
       REM           
       REM           
       REM           
       NOP           
 F2    CLS* K0+5     L NEG OF T1 EFF
       TMI* F2A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA F2        
       TRA F3        
 F2A   NOP TX251     
       TSX ERROR,4   FALSE XFER TO DIRECT ADR
 TX251 TSX OK,4      
       TRA F2        
       REM           
       REM           
       NOP           
 F3    STZ* K0+5     RESET T1 EFF
       CLM           CLEAR ACC
       ADM* K0+5     
       TZE* F3A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA F3        
       TRA F4        
 F3A   NOP TX252     
       TSX ERROR,4   FALSE XFER TO DIRECT ADR
 TX252 TSX OK,4      
       TRA F3        
       REM           
       REM           
       NOP           
 F4    CLS* K0+2     L -222222 --K20+4
       SBM* K0+2     L -222222 --K20+4
       TNZ* F4A      SHOULD NOT XFER
       TRA TX253     
 F4A   NOP F4B       
       TSX ERROR-1,4 FALSE XFER TO DIRECT ADR
       TRA F4        
       TRA F5        
 F4B   TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX253 TSX OK,4      
       TRA F4        
       REM           
       REM           
       NOP           
 F5    LDQ* K0+3     L +50 --K20+6
       MPY* K0+3     L +50 --K20+6
       CLA* K2+2     L +0 -- K20+2
       DVP* K0+3     L +50 -- K20+6
       LLS 35        
       SUB* K0+3     L +50 -- K20+6
       TZE* F5A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA F5        
       TRA F6        
 F5A   NOP TX254     
       TSX ERROR,4   FALSE XFER TO DIRECT ADR
 TX254 TSX OK,4      
       TRA F5        
       REM           
       REM           
       NOP           
 F6    LDQ* K2+1     L +37777777777 -- K21+1
       STQ* K0+5     T1 EFF
       CLA* K0+5     L +37777777777 -- T1
       STZ* K0+5     RESET T1 EFF
       STT* K0+5     
       STP* K0+5     
       STD* K0+5     
       STA* K0+5     
       SUB* K0+5     L +37777777777 -- T1
       TZE* F6A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA F6        
       TRA F7        
 F6A   NOP TX255     
       TSX ERROR,4   FALSE XFER TO DIRECT ADR
 TX255 TSX OK,4      
       TRA F6        
       REM           
       REM           
       NOP           
 F7    CAL* K2+1     L +377777777777 --K21+1
       ACL* K2+2     L +0
       SLW* K0+6     T1+1 EFF
       ANA* K0+6     
       ANS* K0+6     
       SUB* K0+6     L +377777777777 -- T1+1
       TZE* F7A      SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA F7        
       TRA F8        
 F7A   NOP TX256     
       TSX ERROR,4   FALSE XFER TO DIRECT ADR
 TX256 TSX OK,4      
       TRA F7        
       REM           
       REM           
       NOP           
 F8    CLA* K2+1     L +377777777777 -- K21+1
       STZ* K0+5     RESET T1
       ORS* K0+5     
       COM           REPLACE ALL ONES BY ZEROS
       ALS 2         
       ORA* K0+5     L +377777777777 -- T1
       SUB* K0+5     L +377777777777 -- T1
       TZE* F8A      SHOULD XFER
       TZE ERROR-1,4 FAILED TO XFER
       TRA F8        
       TRA F9        
 F8A   NOP TX257     
       TSX ERROR,4   FALSE XFER TO DIRECT ADR
 TX257 TSX OK,4      
       TRA F8        
       REM           
       REM           
       NOP           
 F9    OSI* K0+7     L -3777777777777 IN INDS
       ONT* K0+7     SHOULD SKIP
       TRA F9A       
       IIS* K0+7     
       STI* K0+5     
       LDI* K0+5     L +0 IN INDS
       OFT* K0+7     SHOULD SKIP
       TRA F9B       
       TRA TX258     
 F9A   TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA F9        
       TRA F10       
 F9B   TSX ERROR,4   FAILED TO IA CORRECTLY
 TX258 TSX OK,4      
       TRA F9        
       REM           
       REM           
       NOP           
 F10   RIS* K0+7     L +0 IN INDS -- K21+6
       ONT* K0+7     SHOULD NOT SKIP
       TRA TX259     
       TSX ERROR,4   FAILED TO IA CORRECTLY
 TX259 TSX OK,4      
       TRA F10       
       REM           
       REM           
       NOP           
 F11   CLA* K2+2     L +0 -- K20+2
       STO* K0+5     T1 EFF
       ZET* K0+5     SHOULD SKIP
       TRA F11A      
       NZT* K0+5     SHOULD NOT SKIP
       TRA TX260     
       TSX ERROR-1,4 FAILED TO IA CORRECTLY
       TRA F11       
       TRA H1        
 F11A  TSX ERROR,4   FAILED TO IA CORRECTLY
 TX260 TSX OK,4      
       TRA F11       
       REM           
       REM           
       REM           TEST-INDIRECT
       REM           ADDRESSING WITH
       REM           INDEXABLE TRANSFERS
       REM           AND INSTRUCTIONS
       REM           
       NOP           
 H1    LXA K26,1     L +5 IN XRA
       LXA K26+1,2   L +10 IN XRB
       CLA* K2,1     L -200700000000 -- K22+2
       SUB* K3,2     L -200700000000 -- K22+2
       TZE TX280     
       TSX ERROR,4   
 TX280 TSX OK,4      
       TRA H1        
       REM           
       REM           
       BCD 1TRA      TEST INSTRUCTION
 H2    LXA K26+2,4   L +2 IN XRC
       TRA* H2A,4    
       TSX ERROR-1,4 FAILED TO XFER
       TRA H2        
       TRA H3        
       NOP TX281     
       TRA H2C       
 H2A   NOP H2B       
       TSX ERROR-1,4 FAILED TO INDEX OR IA
       TRA H2        
       TRA H3        
 H2B   TSX ERROR-1,4 FAILED TO INDEX
       TRA H2        
       TRA H3        
 H2C   TSX ERROR,4   INDEXED, FAILED TO IA
 TX281 TSX OK,4      
       TRA H2        
       REM           
       REM           
       BCD 1TZE      TEST INSTRUCTION
 H3    LXA K26+3,1   L +4 IN XRA
       CLS* K5,1     L +201400000000 -- K22+1
       ADD K22+1     L +201400000000
       TZE* H3A,1    
       TSX ERROR-1,4 FAILED TO XFER
       TRA H3        
       TRA H4        
       NOP TX282     
       TSX ERROR-1,4 INDEXED, FAILED TO IA
       TRA H3        
       TRA H4        
 H3A   NOP H3B       
       TSX ERROR-1,4 FAILED TO INDEX OR IA
       TRA H3        
       TRA H4        
 H3B   TSX ERROR,4   FAILED TO INDEX
 TX282 TSX OK,4      
       TRA H3        
       REM           
       REM           
       BCD 1TPL      TEST INSTRUCTION
 H4    LXA K26+3,2   L +4 IN XRB
       CLA K20       L +00444
       TPL* H4A,2    
       TSX ERROR-1,4 FAILED TO XFER
       TRA H4        
       TRA H5        
       NOP TX283     
       TSX ERROR-1,4 INDEXED, FAILED TO IA
       TRA H4        
       TRA H5        
 H4A   NOP H4B       
       TSX ERROR-1,4 FAILED TO INDEX OR IA
       TRA H4        
       TRA H5        
 H4B   TSX ERROR,4   FAILED TO INDEX
 TX283 TSX OK,4      
       TRA H4        
       REM           
       REM           
       NOP           
 H5    LXA K26,1     L +5 IN XRA
       LXA K26+1,2   L +10 IN XRB
       CLA* K20+4,1  L +233000000000 -- K23+3
       SUB K23+3     L +233000000000
       TZE TX284     
       TSX ERROR,4   FAILED TO IA CORRECTLY
 TX284 TSX OK,4      
       TRA H5        
       REM           
       REM           
       NOP           
 H6    LXA K26,1     L +5 IN XRA
       LXA K26+2,2   L +2 IN XRB
       LXA K26+1,4   L +10 IN XRC
       CLS* K27+2,2  L -200700000000 -- K22+2
       ADD* K27+6,1  L -200700000000 -- K22+2
       TZE* H6A,1    
       TSX ERROR-1,4 FAILED TO XFER
       TRA H6        
       TRA J1        
       NOP TX285     
       TSX ERROR-1,4 INDEX, FAILED TO IA
       TRA H6        
       TRA J1        
       NOP           
 H6A   NOP H6B       
       TSX ERROR-1,4 FAILED TO INDEX OR IA
       TRA H6        
       TRA J1        
 H6B   TSX ERROR,4   FAILED TO INDEX
 TX285 TSX OK,4      
       TRA H6        
       REM           
       REM           
       REM           
       REM           TEST-INDIRECT ADDRESSING
       REM           WITH NONINDEXABLE
       REM           INSTRUCTIONS
       REM           
       BCD 1TNX      TEST INSTRUCTION
 J1    LXA K26+2,1   L +2 IN XRA
       TNX* J1A,1    SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA J1        
       TRA J2        
 J1A   NOP J1B       
       TRA TX300     
 J1B   TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX300 TSX OK,4      
       TRA J1        
       REM           
       REM           
       BCD 1TXH      TEST INSTRUCTION
 J2    LXA K21+5,1   L +777777 IN XRA
       TXH* J2A,1    SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA J2        
       TRA J3        
 J2A   NOP J2B       
       TRA TX301     
 J2B   TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX301 TSX OK,4      
       TRA J2        
       REM           
       REM           
       BCD 1TXI      TEST INSTRUCTION
 J3    LXA K25+5,1   L +00777 IN XRA
       TXI* J3A,1,1  SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA J3        
       TRA J4        
 J3A   NOP J3C       
       PXA 0,1       
       SUB K25+5     L +00777
       TZE J3B       
       SUB K26+4     L +61 OCT
       TZE TX302     
 J3B   TSX ERROR-1,4 FAILED TO INCREMENT
       REM           INDEX CORRECTLY
       TRA J3        
       TRA J4        
 J3C   TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX302 TSX OK,4      
       TRA J3        
       REM           
       REM           
       BCD 1TXL      TEST INSTRUCTION
 J4    LXA K26+2,1   L +2 IN XRA
       TXL* J4A,1,3  SHOULD XFER
       TSX ERROR-1,4 FAILED TO XFER
       TRA J4        
       TRA J5        
 J4A   NOP J4B       
       TRA TX303     
 J4B   TSX ERROR,4   
 TX303 TSX OK,4      
       TRA J4        
       REM           
       REM           
       BCD 1TSX      TEST INSTRUCTION
 J5    STZ T1        RESET T1
       STL T1        
       TSX* J5A,1    SHOULD XFER TO DIRECT ADR
       TSX ERROR-1,4 FAILED TO XFER
       TRA J5        
       TRA FIN       
 J5A   NOP J5B       
       CLA T1        
       PAC 0,2       PLACE ADR PART ACC IN XRB
       SXA T1,1      SAVE XRA IN T1
       PXA 0,2       PLACE XRB IN ACC
       SUB T1        
       TZE TX304     SHOULD XFER
       TSX ERROR-1,4 FAILED TO SET INDEX
       TRA J5        
       TRA FIN       
 J5B   TSX ERROR,4   FALSE XFER TO INDIRECT ADR
 TX304 TSX OK,4      
       TRA J5        
       REM           
       REM           
       REM           
       REM           
       NOP           
 FIN   PSE 118       IF UP, READ IN NEXT PROG
       TRA *+2       
       TRA A1A       TO REPEAT PROGRAM
       RCDA          SELECT CARD READER
       RCHA FINX     READ IN
       LCHA 0        NEXT
       TRA 1         PROGRAM
       REM           
 FINX  MON 0,0,3     
       REM           
       REM           
 K0    NOP K20       EFFECTIVE ADDRESSES
       NOP K20+1     
       NOP K20+4     
       NOP K20+6     
       NOP K20+8     
       NOP T1        
       NOP T1+1      
       NOP K21+6     
       NOP K21+8     
       REM           
 K1    NOP K22+2     
       NOP K22+6     
       NOP K22+4     
       NOP K23+2     
       NOP K23+5     
       REM           
 K2    NOP K24+1     
       NOP K21+1     
       NOP K20+2     
       REM           
 K3    NOP K23+3     
       NOP K23+1     
       NOP K23+4     
       NOP K23+6     
       NOP K24       
       NOP K24+3     
       NOP K24+2     
       REM           
 K4    NOP K22+1     
       NOP K24+5     
       NOP K25       
       NOP K25+3     
       REM           
 K5    NOP K24+2,2   
       REM           
       REM           
 K20   OCT +00444    CONSTANTS
       OCT +00555    
       OCT 0000000000000
       OCT +111111    
       OCT -222222    
       OCT +333333    
       OCT +50       
       OCT +3100     
       OCT +200000000000
       OCT 266777000000
       REM           
 K21   OCT 000000777777
       OCT 377777777777
       OCT +340000000000
       OCT +300000000000
       OCT 077777000000
       OCT 000000077777
       OCT -377777777777
       OCT +377000000000
       OCT -200000000000
       OCT +177000000001
       REM           
 K22   OCT +600000000000
       OCT +201400000000
       OCT -200700000000
       OCT +176400000000
       OCT +201040000000
       OCT +204600000000
       OCT +201400000000
       OCT +204540000000
       OCT -201040000000
       OCT +200400000000
       OCT +177777777777
       REM           
 K23   OCT +201000000000
       OCT 211000000001
       OCT 222000000001
       OCT 233000000000
       OCT 200777770000
       OCT 200333330000
       OCT 177666651111
       OCT +100000000000
       OCT 000077777777
       REM           
 K24   OCT 200070707070
       OCT 200707070707
       OCT 000007070707
       OCT 000777777777
       OCT 202770000000
       OCT 201340000000
       OCT 201740000000
       OCT 377740000000
       OCT 376400000000
       OCT -201340000000
       REM           
 K25   OCT 201500000000
       OCT 002000000032
       OCT           
       OCT 201340000000
       OCT 000400000000
       OCT 000000000777
       REM           
 K26   OCT +5        +5
       OCT +10       +10
       OCT +2        +2
       OCT +4        +4
       OCT +61       
       OCT +1        
       REM           
 K27   NOP K22+7,1   
       NOP K22+10,4  
       REM           
 K28   CLA 0         
       ADD K28+9     
       STA 5         
       LTM           
       TRA 0         
       STA 4         
       TRA 1         
       ADD K28+8     
       OCT 17        
       OCT 12        
       REM           
 T1    OCT +0        TEMPORARY STORAGE
       OCT +0        
       NOP T1        
       NOP T1+1      
       REM           
       REM           
 ERROR EQU 3396      
 OK    EQU 3401      
       REM           
       END           
