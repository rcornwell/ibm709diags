             7090/704 OR 7094/704 COMPATABILITY PROGRAM      XCOMC
                 FOR 16/16 OR 8/24 NULLIFY STORAGE           3-15-63
*                          X C O M C
       REM           
*              704/7090/7094 COMPATIBILITY PROGRAM
*               FOR 16/16 OR 8/24 NULLIFY STORAGE
       REM           
       ORG 4096      
       REM           
*                           COMMENCE TEST
       REM           
       REM           
*CHECK ESNT DIVIDES STORAGE CORRECTLY
       REM           
 AY    AXT *,1       THIS LOCATION TO XRA
       TRA RESET     INITIALIZE
       ESNT *+1      TURN ON NULLIFY TGR
       REM           
*FOR 16/16 NULLIFY DIVISION, 37777 SHOULD BE ONLY LOCATION REACHED.
*FOR 8/24 NULLIFY DIVISION, 17777 SHOULD BE ONLY LOCATION REACHED.
       REM           
       TRA 32K       TRA TO LOC 37777 ON 16/16 K
       REM           TRA TO LOC 17777 ON  8/24 K
       REM           
 AY1   SWT 2         ERROR
       HPR           TRA 37777 ON 8/24K
       REM           TRA 17777 ON 16/16K
       TRA *+3       
       REM           
 AY2   SWT 2         ERROR
       HPR           TRA 77777 ON 8/24 OR 16/16K
       REM           
 AY3   SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA AY        REPEAT
       REM           
       REM           
*CHECK TRA INSTRUCTION DOES NOT TURN ON MEMORY NULLIFICATION TRIGGER
       REM           
 AZ    AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA K+1       L TRA AZA-2
       STO 7         STORE IN LOCATION 00007
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALIZATION
       REM           
       REM           
       TRA *+1       IS NULLIFY TRG TURNED ON
       REM         IF NO, TRA TO LOCATION
 FXM01 TRA **        20007 OR 40007
       REM           
       SWT 2         ERROR
       HPR           CHECK COMPONENTS
       REM           MENTIONED ABOVE
 AZA   SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA AZ        REPEAT
       REM          
       REM           
 A     AXT *,1       THIS LOCATION IN XRA
       TRA MONIT     MONITOR PROGRAM
       CLA K+2       L TRA AA
       STO 9         STORE IN LOCATION 00011
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALIZATION
       REM           
       ESNT *+1      ENTER NULLIFICATION MODE
       REM           
 FXM02 TRA **      TRY TRA TO UPPER HALF OF STORAGE
       REM           LOCATION- 20011 OR 40011.
       REM           
       SWT 2         ERROR
       HPR           CHECK NULLIFY TRIGGER
       REM           
*CHECK ABILITY TO TURN OFF NULLIFY TRIGGER FOR FULL STORAGE USE
       REM           
 AA    CLA K+3       L TRA AB-5
       STO 10        STORE IN LOCATION 00012
       CLA *-1       SAVE ADDRESS FOR NEXT
       STO COR+1     ROUTINE INITIALIZATION
       PXD           CLEAR ACCUMULATOR
       LDQ 2921      L BIT IN MQ POSITION 1
       REM           
       REM           
       LSNM          EXIT NULLIFICATION MODE
 FXM03 TRA  **     TRA TO LOC  20012 OR 40012.
       REM           
       SWT 2         ERROR
       HPR           CHECK NULLIFY TRIGGER
       REM           
*CHECK LSNM DID NOT CONDITION RND
       REM           
       TZE AB        PR SIGN MINUS, NO RND
       REM           
       SWT 2         ERROR
       HPR           PR SIGN MINUS SHOULDNT RND
       REM           
 AB    SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A         REPEAT
       REM           
       REM           
*CHECK TTR +0021 HAS NO EFFECT ON NULLIFY TRIGGER
       REM           
 A1    AXT *,1       THIS LOCATION IN XRA
       TRA MONIT     CHECK PROGRAM MONITORED
       CLA K+4       L TRA A1A-2
       STO 11        STORE IN LOCATION 00013
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALIZATION
       REM           
       REM           
       TTR *+1       
       REM           
*CHECK NULLIFY TRIGGER STILL OFF
       REM           
 FXM04 TRA  **     TRA TO LOC  20013 OR 40013.
       REM           
       SWT 2         ERROR
       HPR           CHECK NULLIFY TRIGGER
       REM           
 A1A   SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A1        REPEAT
       REM           
       REM           
*CHECK TEFD -0031 HAS NO EFFECT ON NULLIFY TRIGGER
       REM           
 A2    AXT *,1       THIS LOCATION TO XRA
       TRA MONIT     CHECK PROGRAM MONITORED
       CLA K+5       L TRA A2A-2
       STO 12        STORE IN LOCATION 00014
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALIZATION
       REM           
       REM           
       TEFD *+2      
       NOP           
 FXM05 TRA  **     TRA TO LOC  20014 OR 40014
       REM           
       SWT 2         ERROR
       HPR           CHECK NULLIFY TRIGGER
       REM           
 A2A   SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A2        REPEAT
       REM           
       REM           
*CHECK RND +0760---10 HAS NO EFFECT ON NULLIFY TRIGGER
       REM           
 A3    AXT *,1       THIS LOCATION TO XRA
       TRA MONIT     CHECK PROGRAM MONITORED
       CLA K+6       L TRA A3A
       STO 13        STORE IN LOCATION 00015
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALIZATION
       ESNT *+1      ENTER NULLIFY MODE
       REM           
       RND           
 FXM06 TRA  **     SHOULD TRA TO LOC 00015.
       REM           
       SWT 2         ERROR
       HPR           CHECK NULLIFY TRIGGER
       REM           
 A3A   SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A3        REPEAT
       REM
       REM
       REM           
*CHECK XR INCREMENTED IN NULLIFY MODE
       REM           
 A4    AXT *,1       THIS LOCATION TO XRA
       TRA MONIT     CHECK PROGRAM MONITORED
       LXA  UNIQ1,2  LOAD 37777 INTO XRB
       ESNT *+1      TURN ON NULLIFIY TGR
       TXI *+1,2,1   ADD ON TO XRB
       REM           
       REM           
       PXD 0,2       XRB TO ACC
       LDQ NUM       L +0
       CAS NUM       
       TRA *+2       ERROR
       TRA *+3       OK-XRB HIGH ORDER
       REM           POSITION BLOCKED
       SWT 2         ERROR
       HPR           CHECK HIGH ORDER POS
       REM           XRB AND ADDERS
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A4        REPEAT
       REM           
       REM           
*CHECK AN XR WITH TIX IN NULLIFY MODE
       REM           
 A5    AXT *,1       THIS LOCATION TO XRA
       TRA MONIT     CHECK PROGRAM MONITORED
 FXM07 AXT  **,2   SET 20000 OR 40000 TO XRB.
       REM           
       ESNT *+4      TURN ON NULLIFY TGR
       REM           
       SWT 2         
       HPR           TIX TRANSFERRED
       REM           
       TRA *+2       
 FXM08 TIX  *-3,2,**  NO TRA UNDER ANY CONDITION
       REM         DECR SET TO 17777 OR 37777
       REM           
       PXA 0,2       XRB TO ACC
       LDQ NUM       L +0
       CAS NUM       
       TRA *+2       ERROR
       TRA *+3       OK-XRB ZERO
       REM           
       SWT 2         ERROR
       HPR           CHECK FOR ADDER
       REM           AND XRB COL 3 OUTPUT
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A5        REPEAT
       REM           
       REM           
       REM           
       REM           
       REM           
*CHECK TSX IN AND OUT OF NULLIFICATION MODE
       REM           
 A5X   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA K+7       L TRA 2,2
       STO 14        STO IN LOCATION 00016
       REM           
*CHECK TSX WITH NULLIFY TRIGGER ON
       REM           
       ESNT *+1      TURN ON NULLIFY TGR
       REM           
       REM           
 FXM09 TSX  **,2   HIGH ORDER ADDR LINE DOWN.
       REM         ADDR SET TO 20016 OR 40016.
       TRA *+2       ERROR
       TRA *+3       OK-PROCEED
       REM           
       SWT 2         ERROR
       HPR           TRANSFERRED TO LOC 40016
       REM           
*CHECK TSX WITH NULLIFY TRIGGER OFF
       REM           
       LSNM          TURN OFF NULLIFY TGR
       REM           
       REM           
 FXM10 TSX  **,2   TRA TO LOC 20016 OR 40016.
       TRA *+3       OK-PROCEED
       REM           
       SWT 2         ERROR
       HPR           TRANSFERRED TO LOC 00016
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A5X       REPEAT
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
*CHECK AN XR COUNT DOWN WITH TIX IN NULLIFY MODE
       REM           
 A6    AXT *,1       THIS LOCATION TO XRA
       TRA MONIT     CHECK PROGRAM MONITORED
       AXT 32K,2     L 77777 TO XRB
       REM           
       ESNT *+1      TURN ON NULLIFY TGR
       TIX *+1,2,1   
       PXD 0,2       
       LDQ NMBR      MQ DECREMENT VALUE
       REM           SHOULD BE IN XRB
       CAS NMBR      
       TRA *+2       ERROR
       TRA *+3       XRB REDUCTION OK
       REM           
       SWT 2         ERROR
       HPR           CHECK IF HIGH ORDER
       REM           POSITIONS BLOCKED
       TIX *,2,1     COUNT DOWN XRB
       PXA 0,2       XRB TO ACC
       LDQ NUM+1     L +1
       CAS NUM+1     
       TRA *+2       ERROR
       TRA *+3       XRB COUNT DOWN OK
       REM           
       SWT 2         ERROR
       HPR           ERROR IN COUNT DOWN
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A6        REPEAT
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
*CHECK ESNT IS INDIRECT ADDRESSABLE
       REM           
 A6X   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA K1+2      L TRA A6XX
       STO 8         STORE IN LOCATION 00010
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALIZATION
       ESNT* *+7     TURN ON NULLIFY AND IA TRGS
       REM           
       REM           
 A6XX  TSX  **,2   SHOULD TRA TO LOC 20016.
       REM         ADDR SET TO 20016 OR 40016.
       TRA *+2       ERROR
       TRA *+7       NULLIFY + IA TRGRS OK
       REM           
       SWT 2         ERROR
       HPR           WAS NULLIFY TGR ON
       REM           
       TRA *+4       
       REM           
       LSNM          DO NOT EXECUTE INSTR
       REM           USE ADR PORTION ONLY
       REM           TO GET ADR FOR ESNTINSTR
       REM           TO TRANFER TO
       REM           
       SWT 2         ERROR
       HPR           WAS IA CONTROL TRGR ON
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A6X       REPEAT
       REM           
       REM           
*CHECK I/O SENSE AND TRAP MODE TRIGGER
       REM           
 A7    AXT *,1       THIS LOCATION TO XRA
       SLN 4         TURN ON SENSE LITE 4
       TRA MONIT     CHECK PROGRAM MONITORED
       REM           
       REM           
       ESTM          TURN ON I/O TRAP TGR
       IOT           IS LITE ON
       TRA *+2       YES
       TRA *+3       NO
       REM           
       SWT 2         ERROR
       HPR           PR SING MINUS-IOT LITE OFF
       REM           
       ESNT *+1      TURN ON NULLIFY TGR
       REM           AND SIMULATE INDICATOR
       REM           
       REM           
       REM           
       REM           
       REM           
*BRINGING UP STORE AND TRAP CONTROLS, WILL PLACE THE LOCATION PLUS 1 OF
*SELECT INSTRUCTION IN ADDRESS PORTION LOCATION 40000 AND TRAP TO
*LOCATION 40001.     
       REM           
       RTBA 2        SEC OP 0,2
       REM           
 A7A   SWT 2         ERROR
       HPR           DID NOT TRAP-SEE COMMENT
       REM           
       REM           
*CHECK MEMORY NULLIFICATION TRIGGER TURNED OFF
       REM           
 FXM11 TSX  **,2   TRA TO LOC 20016 OR 40016.
       TRA *+3       OK-PROCEED
       REM           
       SWT 2         ERROR
       HPR           CHECK IF NULLIFY TGR OFF
       REM           
*CHECK CONTENTS OF LOCATION 40000
       REM           
       CLA 16K+1     L CONTENTS LOC 40000
       LDQ K+8       L HTR A7A
       CAS K+8       
       TRA *+2       ERROR
       TRA *+3       LOC 40000 OK-PROCEED
       REM           
       SWT 2         
       HPR           ERROR LOC 40000
       REM           
*CHECK I/O TRAP TRIGGER TURNED OFF AND SELECT INSTRUCTION WILL NOT TRAP
       REM           
       RTBA 2        
       RDCA          DISCONNECT I/O UNIT
       TRA *+3       OK-NO TRAP-TRANSFER
       REM           
       SWT 2         ERROR
       HPR           TRAPPED
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A7        REPEAT
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
*CHECK IOT +0760---5 HAS NO EFFECT ON I/O SENSE TRAP TRGR
       REM           
 A8    AXT *,1       LOCATION TO XRA
       SLN 4         TURN ON SENSE LITE 4
       TRA MONIT     PROGRAM MONITOR
       REM           
       REM           
       ESNT *+1      ENTER NULLIFY MODE
       IOT           
       NOP           
       RTDA 2        DOES SELECT TRAP
       RDCA          DISCONNECT I/O UNIT
       TRA *+3       OK-NO TRAP-TRANSFER
       REM           
       SWT 2         ERROR
       HPR           IS I/O TRAP TGR ON
       REM           WITH IOT INSTR
       REM           
*CHECK NULLIFY TRIGGER STILL ON
       REM           
 FXM12 TSX  **,2   SHOULD TRA TO LOC 00016
       REM         ADDR SET TO 20016 OR 40016.
       TRA *+2       ERROR
       TRA *+3       OK-PROCEED
       REM           
       SWT 2         ERROR
       HPR           IS NULLIFY TGR OFF
       REM           
*CHECK CONTENTS LOCATION 40000
       REM           
       LSNM          EXIT NULLIFY MODE
       CLA 16K+1     L LOC 40000
       LDQ NUM       L +0
       CAS NUM       
       TRA *+2       ERROR
       TRA *+3       OK-PROCEED
       REM           
       SWT 2         ERROR
       HPR           LOC 40000 NOT ZERO
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A8        REPEAT
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
 A9    AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       REM           
*WRITE SELECT INSTRUCTION-SEC OPN 0,6
       REM           
       ESTM        I/O TRAP TRIGGER ON
       WTB 1         704 SELECT INSTR
       REM           
       SWT 2         ERROR
       HPR           NO TRAP
       REM           
*REWIND SEC OPN 1,2  
       REM           
       ESTM        I/O TRAP TRIGGER ON
       REW 1         704 SELECT INSTR
       REM           
       SWT 2         ERROR
       HPR           NO TRAP
       REM           
*-WRITE END OF FILE-SEC OPN 1,0
       REM           
       ESTM        I/O TRAP TRIGGER ON
       WEF 1         704 SELECT INSTR
       REM           
       SWT 2         ERROR
       HPR           NO TRAP
       REM           
*BACKSPACE TAPE-SEC OPN 0,4
       REM           
       ESTM        I/O TRAP TRIGGER ON
       BST 1         704 SELECT INSTR
       REM           
       SWT 2         ERROR
       HPR           NO TRAP
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A9        REPEAT
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK SENSE PUNCH INSTRUCTION
       REM           
 A10   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       ESTM        I/O TRAP TRIGGER ON
       REM           
       REM           
       PSE 225       SHOULD TRAP
       REM           
       SWT 2         ERROR
       HPR           CHECK COMPONENTS
       REM           NOTED IN COMMENTS
       REM           
       ESTM        I/O TRAP TRIGGER ON
       SPUA 1        SHOULD TRAP
       REM           
       SWT 2         ERROR
       HPR           CHECK COMPONENTS
       REM           NOTED IN COMMENTS
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       PROCEED
       TRA A10       REPEAT
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
***********************************************************************
***         REFERENCE IS MADE TO 7090 SERVICE AID NUMBER 81         ***
***                                                                 ***
***                                                                 ***
***   ON A PROGRAM HALT AT LOCATION 12250, KEY 34 MUST BE SET       ***
***        DOWN IN ORDER TO CHECK BTT AND ETT IN SELCT TRAP MODE.   ***
***                                                                 ***
***                                                                 ***
***   FOR PROPER OPERATION OF THE THREE FOLLOWING TEST ROUTINES     ***
***      ON THE 7090, THE MACHINE CHNAGE OUTLINED IN CEM 81 MUST    ***
***      HAVE BEEN INSTALLED.                                       ***
***                                                                 ***
***                                                                 ***
***********************************************************************
       REM           
       REM           
       REM           
       REM           
*     CHECK BTTA WITH TRIGGER ON ( NO-SKIP CONDITIONS )
       REM           
       REM           
*  NOTE - THIS TEST ROUTINE WILL ONLY BE CHECKED ON THE INITIAL PASS
*         OF XCOMC.  IF KEY 34 WAS NOT DOWN ON THE FIRST PASS OF
*         XCOMC, THE TEST ROUTINE WILL NOT BE CHECKED.
       REM           
       REM           
 A10A  AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       TRA A10C      
       ZET PASS+2    FIRST PASS
       TRA A10C      NO
       REWA 2        REWIND TAPE 2
       BSRA 2        TURN ON BTT TRIGGER
       BSRA 2        HOLD UP
       TCOA *           WAIT
       ESTM          I/O TRAP TRG ON
       BTTA          SHOULD TRAP
 A10B  NOP           
       TRA *+2       ERROR
       TRA *+3       OK
       SWT 2         
       HPR           
       CLA 16K+1     L CONTENTS LOC 40000
       CAS K1-3      L HTR A10B
       TRA *+2       ERROR
       TRA *+4       OK
       LDQ K1-3      
       SWT 2         
       HPR           
       SWT 1         TEST SWITCH 1
       TRA *+2       
       TRA A10A      REPEAT
       REM
       REM
       REM
       REM
* CHECK BTTA WITH TRIGGER OFF ( SKIP CONDITION )
       REM           
 A10C  AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       TRA A10E      
       BTTA          TURN TRIGGER OFF
       NOP           
       ESTM          I/O TRIGGER ON
       BTTA          SHOULD TRAP
       NOP           
 A10D  SWT 2         ERROR
       HPR           
       CLA 16K+1     L CONTENTS LOC 40000
       CAS K1-2      L HTR A10D
       TRA *+2       ERROR
       TRA *+4       OK
       LDQ K1-2      L HTR A10D
       SWT 2         
       HPR           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A10C      REPEAT
       REM           
       REM           
       REM           
*CHECK ETTA WITH TRIGGER OFF ( SKIP CONDITION )
       REM           
 A10E  AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       TRA A11       
       ETTA          TURN OFF IF ON
       NOP           
       ESTM          I/O TRAP TGR ON
       ETTA          SHOULD TRAP
       NOP           
 A10F  SWT 2         ERROR
       HPR           
       CLA 16K+1     L CONTENTS LOC 40000
       CAS K1-1      L HTR A10F
       TRA *+2       ERROR
       TRA *+4       OK
       LDQ K1-1      HTR A10F
       SWT 2         
       HPR           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A10E      REPEAT
       REM           
       REM           
       REM           
***********************************************************************
       REM           
       REM           
       REM           
       REM           
       REM           
*CHECK SENSE PRINTER 
       REM           
 A11   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       ESTM        I/O TRAP TRIGGER ON
       REM           
       REM           
       SPTA          SHOULD TRAP
       REM           
       SWT 2         ERROR
       HPR           NO TRAP
       REM           
       REM           
       SPTA          SHOULD NOT TRAP
       TRA *+4       OK
       TRA *+3       OK
       REM           
       SWT 2         ERROR
       HPR           CHECK TRIGGER TURNED OFF
       REM           IS TIME AFTER TRAP
       REM           
       RDCA          CLEAR BUFFER
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A11       REPEAT
       REM           
       REM           
*CHECK SENSE PRINTER 
       REM           
 A12   AXT *,1       LOCATION TO XRA
       TRA MONIT     MONITOR PROGRAM
       ESTM          I/O TRAP ON-2.10.70.1
       REM           
       REM           
       SPT           SHOULD TRAP
       REM           
       SWT 2         ERROR-NO TRAP
       HPR           CHECK COMPONENTS
       REM           NOTED IN COMMENTS
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A12       REPEAT
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK FRN +0760---11 AND 704 ETT -0760---11
       REM           
 A13   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       ESTM        I/O TRAP TRIGGER ON
       REM           
       FRN           SHOULD NOT TRAP
       TRA *+4       OK-NO TRAP
       NOP           
       REM           
       SWT 2         ERROR
       HPR           FRN TRAPPED
       REM           
       REM           
       CLA K1-4    SET TRAP TRA IN LOC 10
       STO 8         
       CAL MINON   SET ACC P TO A ONE
       LDQ MQNIN   SET MQ 9 TO A ONE
       ETT 1         SHOULD TRAP
       REM           
       SWT 2         ERROR-NO TRAP
       HPR           CHECK COMPONENTS
       REM           NOTED IN COMMENT
       REM           
       REM           NOTE THAT TRIGGER IS TURNED 
       REM           OFF BY THE NEXT I5 PULSE
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A13       REPEAT
       REM           
       REM           
*CHECK DCT +0760---12 AND RTT-0760---12
       REM           
 A14   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       ESTM        I/O TRAP TRIGGER ON
       REM           
       REM           
       DCT           INDICATOR IS OFF
       NOP           NO TRAP AND
       TRA *+3       SKIP TO HERE
       REM           
       SWT 2         ERROR
       HPR           SEE COMMENT ABOVE
       REM           
       RTT           SHOULD TRAP
       REM           
       SWT 2         ERROR
       HPR           NO RTT TRAP-SEE
       REM           COMMENT ABOVE
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A14       REPEAT
       REM           
       REM           
*CHECK TAGGED SENSE INSTRUCTION WITH COMPATABILITY FEATURE
       REM           
 A15   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLS NUM       L -0
       AXT 240,2     L 360 TO XRB
       ESNT *+1      TURN ON NULLIFY TGR
       ESTM        I/O TRAP TRIGGER ON
       PSE 243,2     SHOULD NOT TRAP-ONLY
       REM           MAKE ACC SIGN PLUS
       REM           
       TRA *+4       OK-PROCEED
       NOP           
       REM           
       SWT 2         ERROR
       HPR           TRAPPED
       REM           
       TPL *+3       OK-ACC SIGN PLUS
       REM           
       SWT 2         ERROR
       HPR           ACC SIGN MINUS
       REM           
*CHECK NULLIFY TRIGGER REMAINED ON
       REM           
 FXM13 TSX  **,2   SHOULD TRA TO LOC 00016.
       REM         ADDR SET TO 20016 OR 40016.
       TRA *+2       ERROR
       TRA *+3       OK-PROCEED
       REM           
       SWT 2         ERROR
       HPR           IS NULLIFY TGR OFF
       REM           
*CHECK COMPATABILITY FEATURE WITH XRB ZERO
       REM           
       AXT 0,2       CLEAR XRB
       PSE 243,2     
       REM           
 A15A  SWT 2         ERROR
       HPR           NO TRAP
       REM           
*CHECK NULLIFY TRIGGER TURNED OFF
       REM           
 FXM14 TSX  **,2   TRA TO LOC 20016OR 40016.
       TRA *+3       OK-NULLIFY TRIGGER OFF
       REM           
       SWT 2         ERROR
       HPR           IS NULLIFY TRIGGER ON
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
*CHECK CONTENTS LOCATIN 40000
       REM           
       CLA 16K+1     L CONTENTS LOC 40000
       LDQ K+9       L HTR A15A
       CAS K+9       
       TRA *+2       ERROR
       TRA *+3       OK-PROCEED
       REM           
       SWT 2         ERROR
       HPR           ADR IN LOC 40000 NOT A15A
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A15       REPEAT
       REM           
       REM           
*CHECK SELECT INSTRUCTION AT LAST LOCATION IN LOWER HALF OF STORAGE
       REM           
 A15X  AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MOMITOR
       CLA A9+3      WTB 1 STORED IN THE LAST
 FXM15 STO  **     STORE IN 17777 OR 37777
       CLA NUM2+5    L TRA A15Y
       STO 16K+2     AND STORE
       ESTM          I/O TRAP TGR ON
       REM           
 FXM16 TRA  **     TRA TO LOC 17777 OR 37777.
       REM         TRAP ON I/O.
 A15Y  CLA 16K+1     L CONTENTS 40000
       CAS NUM1+16   20000 OR 40000 IN LOC 40000
       TRA *+2       ERROR
       TRA *+4       LOC 40000 OK
       LDQ NUM1+16   20000 OR 40000 TO MQ
       REM           
       SWT 2         ERROR
       HPR           LOC 40000 WRONG
       REM           
       CLA           L CONTENTS LOCATION 00000
       LDQ NUM2+7    L STR 17777
       CAS NUM2+7    COMPARE
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOCATION 00000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOCATION 00000 NG
       REM           
       CLA 16K+3     RESTORE CORRECT
       STO 16K+2     INSTRUCTION
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A15X      REPEAT
       REM           
       REM           
       REM           
*CHECK COMPATABILITY FEATURE IN TRAPPING MODE
       REM           
 A16   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       LTM           LEAVE TRAP MODE
       CLA K+10      L TTR A16A
       STO 1         STORE IN LOCATION 00001
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALIZATION
       ESNT *+1      ENTER NULLIFY MODE
       ESTM          ENTER I/O SENSE TRAP MODE
       ETM           ENTER TRAP MODE
       LDQ NUM       L +0 TO MQ
       REM           
       REM           
       TQP *+1       
       LTM           LEAVE TRAP MODE
       TRA *+5       ERROR
       REM           
       LTM           LEAVE TRAP MODE
       REM           
       SWT 2         ERROR
       HPR           TRAPPED TO LOC 40001
       REM           
       TRA *+3       PROCEED
       REM           
       SWT 2         ERROR
       HPR           TQP DID NOT TRAP TO 00001
       REM           
*CHECK CONTENTS LOCATION 00000
       REM           
 A16A  LTM           LEAVE TRAP MODE
       CLA           L CONTENTS LOC 00000
       LDQ K+11      L STR A16A-9
       CAS K+11      
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 00000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 00000 WRONG
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK CONTENTS LOCATION 40000
       REM           
       LSNM          NULLIFY TGR OFF
       CLA 16K+1     L LOCATION 40000
       LDQ NUM       L +0
       CAS NUM       
       TRA *+2       ERROR
       REM           
       WRS 219       CONTENTS LOC 40000 OK
       REM           SELECT INSTR TO TURN OFF
       REM           I/O SESNE TRAP TRGR-TRAP
       REM           AND TRANSFER TO A17-3
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 40000 WRONG
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A16       REPEAT
       REM           
       REM           
       REM           
 A17   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       REM           
       CPY           TURN ON IOT LIGHT
       TRA *+4       AND NO TRAP
       NOP           
       REM           
       SWT 2         ERROR
       HPR           TRAPPED
       REM           
       IOT           CHECK IOT LITE
       TRA *+3       OK-LIGHT WAS ON
       REM           
       SWT 2         ERROR
       HPR           LIGHT WAS OFF
       REM           
*CHECK LOCATION 40000 
       REM           
       CLA 16K+1     L LOCATION 40000
       LDQ NUM       L +0
       CAS NUM       
       TRA *+2       
       TRA *+3       CONTENTS LOC 40000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 40000 WRONG
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK COPY AND ADD LOGICAL WORD
       REM           
       CAD           
       TRA *+4       OK
       NOP           
       REM           
       SWT 2         ERROR
       HPR           TRAPPED
       REM           
       IOT           CHECK IOT LIGHT
       TRA *+3       OK-LIGHT WAS ON
       REM           
       SWT 2         ERROR
       HPR           LIGHT WAS OFF
       REM           
*CHECK CONTENTS LOCATION 40000
       CLA 16K+1     L CONTENTS LOC 40000
       LDQ NUM       L +0
       CAS NUM       
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOCATION 40000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOCATION 40000 NG
       REM           
       REM           
*CHECK LDA           
       REM           
       LDA 1         
       TRA *+4       OK-NO TRAP
       NOP           
       REM           
       SWT 2         ERROR
       HPR           TRAPPED
       REM           
       IOT           CHECK IOT LIGHT
       TRA *+3       OK-LIGHT WAS ON
       REM           
       SWT 2         ERROR
       HPR           LIGHT WAS OFF
       REM           
*CHECK CONTENTS LOCATION 40000
       REM           
       CLA 16K+1     L LOCATION 40000
       LDQ NUM       L +0
       CAS NUM       
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 40000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 40000 WRONG
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A17       REPEAT
       REM          
*CHECK OPERATION WITH COPY TRAP TRIGGER ON
       REM           
 A18   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       ESNT *+1      ENTER NULLIFY MODE
       REM           
       REM           
       ECTM          TURN ON CPY TRAP TRG
       REM           
*CHECK ECTM DOES NOT CONDITION COM
       REM           
       TZE *+3       ACC SHOULD BE ZERO
       REM           
       SWT 2         ERROR
       HPR           PR SIGN MINUS SHOULDNT COM
       REM           
       REM           
       CPY           SHOULD TRAP
       REM           
 A18A  SWT 2         ERROR
       HPR           NO TRAP
       REM           
*CHECK NULLIFY TRIGGER NOW OFF
       REM           
 FXM17 TSX  **,2   TRA T LOC 20016 OR 40016.
       TRA *+3       OK-NULLIFY TGR OFF
       REM           
       SWT 2         ERROR
       HPR           CHECK NULLIFY TGR TURNED
       REM           OFF BY OUTPUT FROM +0R
       REM           
*CHECK CONTENTS LOCATION 40000
       REM           
       CLA 16K+1     L CONTENTS LOC 40000
       LDQ K+12      L HTR A18A
       CAS K+12      
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 40000 OK
       REM           
       SWT 2         ERROR
       HPR           CHECK ADR LOC 40000
       REM           
*CHECK IOT LIGHT     
       REM           
       IOT           CHECK IOT LIGHT
       TRA *+2       ERROR
       TRA *+3       OK-LIGHT WAS OFF
       REM           
       SWT 2         ERROR
       HPR           IOT LIGHT WAS ON
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
*CHECK CPY TRAP TRIGGER NOW OFF
       REM           
       CPY           
       TRA *+4       OK-PROCEED
       NOP           
       REM           
       SWT 2         ERROR
       HPR           IS CPY TRAP TGR OFF
       REM           SEE OUTPUT FROM +0R CIRCUIT
       REM           TURNS OFF CPY TRAP TGR
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A18       REPEAT
       REM           
       REM           
*CHECK CAD AND LDA TRAPS
       REM           
 A18X  AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       ECTM          TURN ON CPY TRAP TGR
       CAD           SHOULD TRAP LIKE CPY
       REM           
       SWT 2         ERROR
       HPR           SEE COMMENTS FOR A CPY
       REM           TRAP IN SECTION A17
       REM           
       ECTM          TURN ON CPY TRAP TGR
       LDA 1         SHOULD TRAP LIKE CPY
       REM           
       SWT 2         ERROR
       HPR           NO TRAP-SEE INPUT E TO
       REM           LOGIC BLOCK 5I SYSTEMS
       REM           2.10.71.1
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A18X      REPEAT
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK COMPLEMENT +0760---06 HAS NO EFFECT ON CPY TRAP MODE TRIGGER
       REM           
 A19   AXT *,1       LOCATION TO XRA
       TRA MONIT     
       REM           
       COM           SHOULD NOT TURN
       REM           ON CPY TRAP TRIGGER
       REM           
*CHECK CPY TRAP TRG REMAINED OFF
       CPY           
       TRA *+4       OK-NO TRAP
       NOP           
       SWT 2         ERROR
       HPR           CPY TGR SHOULD STAY
       REM           OFF WITH PR SIGN PLUS
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       COTNINUE
       TRA A19       REPEAT
       REM           
       REM           
*CHECK CPY INSTRUCTION AT LAST LOCATION IN LOWER HALF OF STORAGE
 A20X  AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA A19+3     CPY STORED IN THE LAST
 FXM18 STO  **     STORE IN LOC 17777 OR 37777
       CLA NUM2+6    L TRA A20Y
       STO 16K+3     AND STORE
       ECTM          CPY TRAP TGR ON
       REM           
 FXM19 TRA  **     TRA TO LOC 17777 OR 37777.
       REM         TRAP ON COPY.
 A20Y  CLA 16K+1     L CONTENTS 40000
       CAS NUM1+16   20000 OR 40000 IN LOC 40000
       TRA *+2       ERROR
       TRA *+4       LOC 40000 OK
       LDQ NUM1+16   20000 OR 40000 TO MQ
       REM           
       SWT 2         ERROR
       HPR           LOC 40000 WRONG
       REM           
       CLA           L CONTENTS LOCATION 00000
       LDQ NUM2+7    L STR 17777
       CAS NUM2+7    COMPARE
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOCATION 00000 OK
       SWT 2         ERROR
       HPR           CONTENTS LOCATION 00000 NG
       REM           
       CLA 16K+2     RESTORE CORRECT
       STO 16K+3     INSTRUCTION
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A20X      REPEAT
       REM          
*CHECK STR TRAPS TO LOCATION 00002 WITH COMPATABLITY FEATURE
       REM           
 A20   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA K+13      L TRA A20A
       STO 2         STORE IN LOCATION 00002
       CLA K1+1      L HTR A20A-4
       STA 16K+1     STORE IN ADR LOC 40000
       ECTM          TURN ON CPY TRAP TGR
       REM           
       REM           
       STR           
       REM           
       SWT 2         ERROR
       HPR           TRAPPED TO LOC 40002
       REM           
*CHECK CONTENTS LOCATION 00000
       REM           
 A20A  CLA           L CONTENTS LOCATION 00000
       LDQ K1        L STR A20A-2
       CAS K1        
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 00000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 00000 WRONG
       REM           
*CHECK CONTENTS LOCATION 40000
       REM           
       CLA 16K+1     L CONTENTS LOC 40000
       LDQ K1+1      L HTR A20A-4
       CAS K1+1      
       TRA *+2       ERROR
       CPY           CONTENTS LOCATION 40000 OK
       REM           TURN OFF CPY TRAP TGR
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 40000 WRONG
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A20       REPEAT
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*PREVIOUSLY, IT WAS SHOWN TURNING OFF I/O TRAP TGR OR CPY TRAP TGR
*TURNED OFF NULLIFY TGR. NOW CHECK TURNING OFF THE FIRST 2 MENTIONED
*TRIGGERS BY EACH OTHER.
       REM           
 A21   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       ESTM          TURN ON I/O TRAP TGR
       ECTM          TURN ON CPY TRAP TGR
       REM           
       REM           
       WDR 1         TURN I/O TRAP AND
       REM           CPY TRAP TGRS OFF
       REM           
       SWT 2         ERROR
       HPR           FAILED TO TRAP
       REM           
       REM           
       CPY           HAS CPY TRAP TRGR
       REM           BEEN TURNED OFF
       IOT           YES AND LITE
       TRA *+3       SHOULD BE ON
       REM           
       SWT 2         ERROR
       HPR           CPY TRAP TGR NOT TURNED OFF
       REM           COMMENTS OF ROUTINE
       REM           
       REM           
*CHECK CPY TRAP TGR TURNED OFF ALSO TURNS OFF I/O TRAP TGR
       REM           
       ESTM          TURN ON I/O TRAP TGR
       ECTM          TURN ON CPY TRAP TGR
       CPY           
       REM           
       SWT 2         ERROR
       HPR           FAILED TO TRAP
       REM           
       REM           
 A21X  RDR 1         HAS I/O SENSE TRAP
       REM           TGR BEEN TURNED OFF
       IOT           YES AND LITE
       TRA *+3       SHOULD BE ON
       REM           
       SWT 2         ERROR
       HPR           I/O TRAP TGR NOT TURNED OFF
       REM           SEE COMMENTS OF ROUTINE
       REM           
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A21       REPEAT
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK SELECT CRT INSTRUCTION
       REM           
 A21A  AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       ESTM          TURN ON I/O TRAP TGR
       REM           
       REM           
       WTV           TRAP AND TURN OFF 
       REM           I/O TRAP TRIGGER
       REM           
       SWT 2         ERROR
       HPR           FAILED TO TRAP
       REM           
       REM           
       WTV           WAS I/O TRAP TGR TURNED OFF
       IOT           YES AND LITE
       TRA *+3       SHOULD BE ON
       REM           
       SWT 2         ERROR
       HPR           CHECK I/O TRAP TGR
       REM           NOT TURNED OFF
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A21A      REPEAT
       REM           
       REM           
*CHECK FLOATING POINT 704 MODE-NO FP TRAP,ACCUMULATOR AND MQ INDICATOR
*OPERATIVE AND TQO IS EXECUTED
       REM           
 A22   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA           K+14L TRA A22A
       STO 8         STORE IN LOCATION 00010
       CLA *-1       SAVE ADDRESS FO NEXT
       STA COR       ROUTINE INITIALIZATION
       REM           
       REM           
       LFTM          TURN OFF FP TMODE TGR
       REM           
       REM           
       TQO *+1       MQ INDICATOR OFF
       CLS NUM+7     L -00100777777
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*BEFORE PROCEEDING, CHECK CHS +0760---02 HAS NO EFFECT ON F.P. TRAP
*TRGR               
       REM           
       CHS           
       REM           
       REM           
       FAD NUM+8     L +00400444444
       REM           
*CHECK ACCUMULATOR INDICATOR
       REM           
       TOV *+3       OK-ACC IND WAS TURNED ON
       REM           TURN OFF AND TRANSFER
       REM           
       SWT 2         ERROR
       HPR           ACC INDICATOR OFF
       REM           
       TQP *+3       SHOULD TRANSFER
       REM           
       SWT 2         ERROR
       HPR           MQ SHOULD BE PLUS
       REM           
       REM           
       REM           
       TQO *+3       TQO SHOULD EXECUTE-MQ IND
       REM           WAS TURNED ON-TURN OFF
       REM           AND TRANSFER
       REM           
       SWT 2         ERROR
       HPR           MQ OVFLO IND OFF
       REM           
       TQP *+2       SHOULD TRANSFER
       REM           
       SWT 2         ERROR
       HPR           MQ SHOULD BE PLUS
       TRA *+3       PROCEED
       REM           
       REM           
 A22A  SWT 2         ERROR
       HPR           TRAPPED TO LOC 00010
       REM           
*CHECK CONTENTS LOCATION 00000
       REM           
       CLA           L CONTENTS LOCATION 00000
       LDQ NUM2+7    L STR 17777
       CAS NUM2+7    COMPARE
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 00000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 00000 WRONG
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A22       REPEAT
       REM
       REM
*TEST FLOATING POINT 709 MODE WITH TRAP AND ACCUMULATOR INDICATOR OFF
       REM           
 A24   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA K+16      L TRA A24A
       STO 8         STORE IN LOCATION 00010
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALITION
       REM           
       REM           
       EFTM          TURN ON FP TMODE TGR
       REM           
*BEFORE PROCEEDING CHECK ENK +0760---04 DOES NOT TURN OFF FP TMODE TGR
       REM           
       ENK           TRGR REMAIN RESET
       REM           
       CLM           CLEAR ACCUMULATOR
       LDQ NUM+5     L -032404040404
       LLS 35        NO ACC OVERFLOW
       FDP NUM+6     L +344440404040
       REM           
       SWT 2         ERROR
       HPR           FAILED TO TRAP-SEE COMMENT
       REM           
       REM           
*CHECK ACCUMULATOR INDICATOR OFF
       REM           
 A24A  TNO *+3       OK-ACC IND OFF
       REM           
       SWT 2         ERROR
       HPR           ACC IND ON-NOTE ABOVE
       REM           COMMENT
       REM           
*CHECK CONTENTS LOCATION 00000
       REM           
       CLA           L CONTENTS LOCATION 00000
       LDQ K+17      L FP LOC + 1 IN ADR AND
       REM           BITS IN DECREMENT POSITIONS
       REM           14,16,17 WITH OP CODE -1
       CAS K+17      
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 00000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 00000 WRONG
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A24       REPEAT
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK EXECUTION TQO AND OPERATION MQ INDICATOR IN 709 MODE
       REM           
 A26   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA K+28      L TRA A26A
       STO 8         STORE IN LOCATION 00010
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALIZATION
       LFTM          TURN OFF FP TMODE TGR
       TQO *+1       MQ INDICATOR OFF
       CLA NUM+4     L -00010000000
       REM           
*EXECUTE A FLOATING POINT INSTRUCTION TO TURN ON MQ OVFLO INDICATOR
       REM           
       UFA NUM+4     L -00010000000
       EFTM          TURN ON FP TMODE TGR
       REM           
       REM           
       NOP           TURN OFF MQ OVFLO TGR
       REM           
*CHECK FP TRAP MODE RESET MQ OVERFLOW INDICATOR
       REM           
       LFTM          TURN OFF FP TMODE TGR
       TQO *+2       INDICATOR SHOULD BE OFF
       TRA *+6       OK, INDICATOR OFF
       REM           
       SWT 2         ERROR
       HPR           MQ INDICATOR ON
       TRA *+3       
       REM           
 A26A  SWT 2         ERROR
       HPR           CHECK FP TMODE TGR ON
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A26       
       REM           
       REM           
       ZET PASS+1    LOAD AND/OR RESET BUTTON
       REM           TESTS ON EACH INITIAL PASS
       TRA M05       SKIP RESET AND LOAD
       REM           BUTTON TESTS
       SWT 3         IS PRINTER ON LINE
       TRA *+4       
       REWA 1        REWIND TAPE
       TRA A28X      TEST LOAD BUTTON ONLY
       REM           
       TRA A26       DUMMY INST FOR MONITOR
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK RESET BUTTON RESTORES MACHINE TO 7090 MODE
       REM           
 A27   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA K+18      L TRA A27A
       STO           STORE IN LOCATION 00000
       CLA  NUM1+3     FIX
       STO RE+12     PRINT
       ARS 8         IMAGE
       ORS RE+16     LOCATIONS
       REM           
       ESNT *+1      TURN ON NULLIFY TGR
       ESTM          TURN ON I/O TRAP TGR
       ECTM          TURN ON CPY TGR
       LFTM          TURN OFF FP TMODE TGR
       REM           
*TURN ON MQ OVERFLOW INDICATOR
       REM           
       CLA NUM+4     L -000100000000
       UFA NUM+4     MQ OVFLO IND ON
       STZ 15        CLEAR LOCATION 00017
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR       ROUTINE INITIALIZATION
       HPR           
       REM           
       REM           
***********************************************************************
*                                                                     *
*     PUSH RESET BUTTON TO RESET PROGRAM COUNTER TO 00000             *
*                AND THEN PUSH START BUTTON                           *
*                                                                     *
***********************************************************************
       REM           
*CHECK I/O TRAP TRIGGER WAS TURNED OFF
       REM           
 A27A  WPRA          SELECT PRINTER
       TRA *+4       OK-PROCEED
       NOP           
       REM           
       SWT 2         ERROR
       HPR           CHECK I/O TRAP TGR OFF
       REM           
       SPRA 3        
       TRA *+4       OK-PROCEED
       NOP           
       REM           
       SWT 2         ERROR
       HPR           
       REM           
 FXM20 RCHA **     LOAD FROM LOC 20017 OR 40017.
       REM         PRINT A LINE
       REM
       REM
       REM
       REM
       REM
*CHECK CPY TRAP TRIGGER WAS TURNED OFF
       REM           
       CPY           SHOULD NOT TRAP
       TRA *+4       OK-PROCEED
       NOP           
       REM           
       SWT 2         ERROR
       HPR           
       REM           
*CHECK LOCATION 40000 
       REM           
       CLA 16K+1     L LOCATION 40000
       LDQ NUM       L +0
       CAS NUM       
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 40000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 40000 WRONG
       REM           
*CHECK FP TMODE TRIGGER TURNED ON
       REM           
       CLA K+19      L TRA A27B
       STO 8         STORE IN LOCATION 00010
       CLA *-1       SAVE ADDRESS FOR NEXT
       STA COR+1     ROUTINE INITIALIZATION
       CLA NUM+7     L +001007777777
       FAD NUM+8     L +004004444444
       REM           
       SWT 2         ERROR
       HPR           CHECK INPUT E TO LOGIC
       REM           BLOCK 3B SYSTEMS 2.10.71.1
       REM           
 A27B  CLA           L CONTENTS LOCATION 00000
       LDQ K+20      L FP LOC + 1 WITH BITS IN
       REM           DEC POSITIONS 16,17 AND
       REM           OPCODE 0000
       CAS K+20      
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 00000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 00000 WRONG
       REM           
       TCOA *        WAIT IF CHANNEL IN USE
       CLA NUM+3     FIX
       ARS 1         THE
       STO RE+16     PRINT
       ARS 3         IMAGE
       ORS RE+12     LOCATIONS
       IOT           TURN OFF
       NOP           IOT LIGHT
       REM
       REM
       REM
       REM
       REM
*CHECK NEXT SEQUENCE OF INSTRUCTIONS WHICH HAVE BEEN KNOWN TO FAIL
       REM           
 A27C  WPRA          PRINT
 FXM21 RCHA **     LOAD FROM LOC 20017 OR 40017.
       ESTM          I/O TRAP TGR ON
       PSE 241       TRAP ON I/O
       REM           
       SWT 2         ERROR
       HPR           NO I/O TRAP
       REM           
       IOT           CHECK IOT LIGHT
       TRA *+2       ERROR
       TRA *+3       OK, IOT LIGHT OFF
       REM           
       SWT 2         ERROR
       HPR           IOT LIGHT ON
       REM           
       CLA 16K+1     L CONTENTS LOCATION 40000
       LDQ NUM2+9    L HTR A27C+4
       CAS NUM2+9    COMPARE
       TRA *+2       ERROR
       TRA *+3       LOCATION IS OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOCATION NG
       REM           
       SWT 1         TEST SWITCH 1
       TRA A28       CONTINUE
       TRA A27       REPEAT
       REM           
       TRA A26       DUMMY INSTR FOR MONITOR
       REM           
 A28X  AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       LXA *+3,1     L XRA WITH ADR OF INSTR
       SXD HOLD,1    PUT IN DEC OF LOC
       TRA A28       PROCEED
       REM           
       TRA A27       DUMMY INSTR FOR MONITOR
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK LOAD TAPE BUTTON RESTORES MACHINE TO 7090 MODE
       REM           
 A28   AXT *,1       LOCATION TO XRA
       TRA MONIT     PROGRAM MONITOR
       CLA A27A+2    L NOP
       STO 3         STORE IN LOCATION 00003
       CLA K+21      L TRA A28A
       STO 4         STORE IN LOCATION 00004
       REM           
*WRITE 3 WORDS ON TAPE
       REM           
       WTBA 1        SELECT TAPE 1 CHAN A
       RCHA K+22     
       BSRA 1        BACKSPACE TAPE
       TCOA *        
       REM           
       ESNT *+1      TURN NULLIFY TGR
       ESTM          TURN ON I/O TRAP TGR
       ECTM          TURN ON CPY TRAP TGR
       LFTM          TURN OFF FP TMODE TGR
       HPR           
       REM           
       REM           
*WHEN LOAD TAPE BUTTON IS PUSHED, READ 3 WORDS FROM TAPE INTO THE 3
*INITIAL LOCATION OF STORAGE.THE 1ST 5 STORAGE LOCATIONS SHOULD CONTAIN
       REM           
***********************************************************************
*                                                                     *
*                            00000      HTR                           *
*                            00001      RTBA 1                        *
*                            00002      TRA A28B                      *
*                            00003      NOP                           *
*                            00004      TRA A28A                      *
*                                                                     *
***********************************************************************
       REM           
 A28A  SWT 2         ERROR
       HPR           
       REM           
*CHECK NULLIFY TRIGGER TURNED OFF
       REM           
 A28B  TSX  **,2   TRA TO LOC 20016 OR 40016.
       TRA *+3       TRANSFERRED OK
       REM           
       SWT 2         ERROR
       HPR           
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK CPY TRAP TRIGGER TURNED OFF
       REM           
       CPY           
       TRA *+4       OK-PROCEED
       NOP           
       REM           
       SWT 2         ERROR
       HPR           
       REM           
*CHECK LOCATION 40000 
       REM           
       CLA 16K+1     L LOCATION 40000
       LDQ NUM       L +0
       CAS NUM       
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 40000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 40000 WRONG
       REM           
*CHECK FP TMODE TRIGGER TURNED ON
       REM           
       CLA K+26      L TRA A28C
       STO 8         STORE IN LOCATION 00010
       CLA NUM+7     L +001007777777
       FAD NUM+8     L +004004444444
       REM           
       SWT 2         ERROR
       HPR           
       REM           
 A28C  CLA           L CONTENTS LOC 00000
       LDA K+27      L FP LOC+1 WITH BITS IN
       REM           DEC POSITIONS 16,17 AND
       REM           OP CODE 0000
       CAS K+27      
       TRA *+2       ERROR
       TRA *+3       CONTENTS LOC 00000 OK
       REM           
       SWT 2         ERROR
       HPR           CONTENTS LOC 00000 WRONG
       REM           
       SWT 1         TEST SWITCH 1
       TRA *+2       CONTINUE
       TRA A28       REPEAT
       REM           
*ADJUST PROGRAM TO PREVENT PERFORMING RESET AND LOAD BUTTON
*ROUTINES AFTER 1 PASS THRU
       REM           
       REWA 1        REWIND TAPE
       CLA A27-6     BYPASS RESET AND
       STO A27-5     LOAD BUTTON ROUTINES
       REM
*MODIFY AND ALTER INSTRUCTIONS PRIOR TO EXECUTING 9M05 WITH I/O TRAP
*CPY TRAP AND STORAGE NULLIFY TRIGGERS ON
       REM           
 M05   AXT ERROR-4-E5-1,1 FILL
       CLA 3151      
       STO ERROR-4,1 
       TIX *-1,1,1   
       REM           
       AXT 16K-TOTAL,1    THESE
       STO 16384,1   
       TIX *-1,1,1        LOCATIONS
       REM           
       AXT AY-KONST-3,1   WITH 9M05
       STO AY,1      
       TIX *-1,1,1   
       REM           
       AXT 16178,1  TSX SPACE,4
       STO 22,1      
       TIX *-1,1,1   
       REM           
       AXT 6,1       L 6 IN XRA
       CLA TRAP+8,1  TRAP LOCATION
       STO 16K+8,1   TO LOCATIONS
       TIX *-2,1,1   40001-40006
       REM           
       CLA 33        TRA 00030 TO
       STO 22        LOCATION 00026
       REM           
       CLA NUM2+8    9M05 TTR SEQ TO
       STO 8         LOCATION 00010
       REM           
       IOT           TURN OFF
       NOP           LIGHT IF ON
       REM           
       SLF           SENSE LIGHTS OFF
       REM           
       AXT *+6,1     SET RETURN
       SXA 2644,1    FROM 9M05
       REM           
       EFTM          TURN
       ESTM          ON
       ECTM          TRIGGERS
       ESNT 24       START EXECUTING 9M05
       REM           
 MORE  RUNA 2        RESET TRIGGERS
       REM           
       SWT 2         ERROR
       HPR           NO REWIND-UNLOAD WANTED
       REM
       REM
*CHECK PASS COUNTER AND SENSE SWITCHES 3 AND 6 AFTER EACH PROGRAM PASS
       REM           
 COUNT CLA PASS+1    ADD ONE TO TOTAL PASS
       ADD NUM+1     COUNTER FOR EACH PASS
       STO PASS+1    AND SAVE COUNT
       CLA PASS+2    INCREMENT THIS
       ADD NUM+1     COUNTER ON
       STO PASS+2    EVERY PASS
       REM           
       SWT 6         TEST SENSE SWITCH 6
       TRA ATSAL     TOTAL THE PASSES EXECUTED
       REM           AND LOAD NEXT DIAGNOSTIC
       LXA PASS,1    ADD ONE TO 100
       TXI *+1,1,1   DECIMAL PASS COUNTER
       SXA PASS,1    AND SAVE COUNTER
       TXH *+2,1,99  REPEAT DIAGNOSTIC
       TRA SS5       100 DECIMAL TIMES
       REM           IF SENSE SWITCH 5 UP
       STZ PASS      CLEAR 100 PASS COUNTER
       REM           
*TEST SENSE SWITCH 3 TO PRINT TOTAL PASSES EVERY 100 PASSES
       REM           
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       GO TO PRINT TOTAL PASSES
       TRA SS5       
       REM           
*TRANSLATE TOTAL PASS COUNT TO BCD FOR PRINTING
       REM           
       CLA PASS+1    TOTAL PASSES
       TSX BTEN,4    TRANSLATE TO BCD
       NOP           
       STQ *+9       INSERT BCD WORD INIMAGE
       TSX SPLT1+6,4 TO BCD PRINT ROUTINE
       MTW 11,0,3    SPLAT CONTROL WORD
       REM           
 OVER  BCD 6100 PASSES COMPLETE XCOMC WITH
       BCD 5       TOTAL PASSES COMPLETED
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK SENSE SWITCH 5 TO DETERMINE TEST OF ALTERNATE STORAGE DIVISION
       REM           
*IF ALTERNATING TESTING 2 NULLIFY STORAGE DIVISIONS, SENSE SWITCH 5 DOWN
       REM           
 SS5   SWT 5         TEST SENSE SWITCH 5
       TRA STG       SWITCH UP-REPEAT
       REM           
*WITH SENSE SWITCH 5 DOWN, PRINT TOTAL PASSES COMPLETED ON STORAGE
*DIVISION TESTING AND ALTER PROGRAM FOR ALTERNATE STORAGE DIVISION
       REM           
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       PRINT PASSES MADE
       TRA GO+2      TO ROUTINE TO ALTER LOCS
       CLA PASS+1    L PASSES MADE
       TSX BTEN,4    TRANSLATE TO BCD
       NOP           
       STQ *+8       PUT BCD WORD IN IMAGE
       TSX SPLT1+6,4 TO BCD PRINT ROUTINE
       MTW 10,0,6    SPLAT CONTROL WORD
       REM           
 OUT   BCD 5XCOMC TEST COMPLETE WITH
       BCD 5       TOTAL PASSES COMPLETED
       TRA GO+2      TO ROUTINES TO ALTER LOCS
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*WITH SENSE SWITCH 3 UP, TOTAL THE PASSES COMPLETED BEFORE LOADING NEXT
*DIAGNOSTIC          
       REM           
 ATSAL REWA 2        COMPATABILITY THRU
       REM           REWIND TAPE DRIVE
       SWT 3         TEST SENSE SWITCH 3
       TRA *+2       PRINT AND LOAD
       TRA CRSL      JUST LOAD
       CLA PASS+2    L TOTAL PASSES
       TSX BTEN,4    TRANSLATE TO BCD
       NOP           
       STQ *+3       PUT BCD WORD IN IMAGE
       TSX SPLT1+6,4 TO BCD PRINT ROUTINE
       MTW 11,0,3    
       REM           
       BCD 5        TOTAL PASSES COMPLETED.
       BCD 6XCOMC FINISHED, LOAD NEXT DIAGNOSTIC
       REM           
 CRSL  RCDA          LOAD
       RCHA TOTAL    THE
       LCHA 0        NEXT
       TRA 1         PROGRAM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*                          PROGRAM MONITOR
       REM           
       REM           
*TEST SENSE SWITCH 1 FOR LOCKED-IN ROUTINE
       REM           
 MONIT SWT 1         TEST SENSE SWITCH 1
       TRA *+4       ROUTINE NOT LOCKED IN
       REM           
       PXD 0,1       XRA TO DEC OF ACC
       SUB HOLD      START ADR TEST LOC
       TZE RESET     PROGRAM SEQUENCE OK
       REM           
*CHECK PROGRAM SEQUENCE IF ROUTINE IS NOT LOCKED IN
       REM           
       PXA 0,1       XRA TO ACC ADR
       SUB NUM+1     L +1
       STA *+3       PUT THIS ADR BELOW
       STZ HOLD+1    CLEAR LOCATION
       SXD HOLD+1,1  XRA TO DEC OF WORD
       CLA           L LOC-1 TEST ENTERED
       ALS 18        ADR TO DEC OF ACC
       SUB HOLD      INTIIAL ADR PREVIOUS TEST
       TZE RELI      SEQUENCE OK, CHECK SW 4
       REM           
       REM           
       REM           
       REM           
*IF PROGRAM SEQUENCE WRONG, CHECK FOR TRA INSTRUCTION IN KEYS
       REM           
       ENK           KEYS TO MQ
       XCA           MQ TO ACC
       PAX 0,1       ACC ADR TO XRA
       ARS 18        SHIFT TO ACC ADR
       SUB NUM+3     L +00000002000
       TNZ *+5       SHOULD BE ZERO
       PXD 0,1       XRA TO DEC OF ACC
       SUB HOLD+1    SAVED ADR
       LXD HOLD+1,1  RESTORE XRA
       TZE RELI      SEQUENCE OK, CHECK SW 4
       REM           
       LXD HOLD+1,1  RESTORE XRA
       PXD 0,1       XRA TO DEC OF ACC
       TRA SPACE+9   INDICATE SEQUENCE ERROR
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*TEST SENSE SWITCH 4 FOR REPEATING ROUTINE 50 OCTAL TIMES
       REM           
 RELI  SWT 4         TEST SENSE SWITCH 4
       TRA RESET     SENSE SWITCH 4 UP
       REM           
       CLA TIMES     L ROUTINE COUNTER
       SUB NUM+1     L +1
       STO TIMES     SAVE ROUTINE COUNTER,
       TNZ *+4       REPEAT ROUTINE AGAIN
       CLA TIMES+1   ROUTINE REPEATED 50 OCTAL
       STO TIMES     TIMES, RESET COUNTER
       TRA RESET     AND PROCEED
       REM           
*CHECK PROGRAM EXECUTING ROUTINE A6X OR A8 AND SENSE SWITCH 4 DOWN
       REM           
       CLA K1+5      L HTR 0,0,A6X
       SUB HOLD      IS PROGRAM IN ROUTINE A6X
       TNZ *+3       NO
       SLF           YES, TURN OFF SENSE LITE 4
       TRA *+5
       REM           
       CLA K1+4      L HTR 0,0,A8
       SUB HOLD      IS PROGRAM IN ROUTINE A8
       TNZ *+2       NO
       SLN 4         YES, TURN ON SENSE LITE 4
       REM
       LXD HOLD,1    CORRECT VALUE IN XRA
       REM           TO REPEAT ROUTINE
       REM           
       REM           
       REM           
 RESET SXD HOLD,1    SAVE XRA IN DEC OF WORD
       SLT 4         TEST SENSE LITE 4
       TXI *+3,1,2   LITE OF,ADD 2 TO XRA
       TXI *+1,1,3   LITE ON,ADD 3 TO XRA
       SLN 4         TURN SENSE LITE 4 ON
       SXA BACK,1    PUT XRA IN ADR OF BACK
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*CHECK IF ROUTINE WILL SELECT TAPE
       REM           
       SLT 4         IS SENSE LITE 4 ON
       TRA *+10      NO
       CLA PASS+2    YES,L COUNTER
       TNZ *+3       REWIND TAPE
       REWA 2        IF FIRST
       TRA *+3       PASS OR
       ETTA          AT END
       TRA *-3       OF TAPE
       REM           
*WRITE A RECORD ON TAPE TO PREVENT VIRGIN TAPE RUN-A-WAY
       REM           
       WTBA 2        WRITE A ONE
       RCHA W0       WORD RECORD AND
       BSRA 2        BACKSPACE RECORD
       REM           
*                            RESET AND INITIALIZE
       REM           
       LSNM          IF SET, RESET THE
       REM           NULLIFY TRGR TO
       STZ 16K+1     CLEAR LOCATION 40000
       CLA NUM2+7    L STR 17777
       STO           STORE IN LOC 00000
 COR   STO           AND IN THESE
       STO           LOCATIONS
       CLA K         L TRA SPACE
       STO 2         PUT IN LOCATION 00002
       TOV *+1       ACC INDICATOR OFF
       DCT           DIV CHECK IND OFF
       NOP           
       IOT           IOT LIGHT OFF
       NOP           
       TRCA *+1      REDUNDANCY LITE OFF
       TEFA *+1      TURN OFF IF ON
       PXD           CLEAR ACCUMULATOR
       LRS 35        AND MQ
       STA COR       CLEAR
       STA COR+1     ADDRESSES
       AXT 0,7       CLEAR ALL INDEX REGISTERS
 BACK  TRA           
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*PROGRAM OUT-OF-CONTROL ROUTINE
       REM           
 SPACE LSNM          JUST IN CASE
       CLA 16K+7     L CONTENTS LOC 40006
       SUB K+15      L TTR 2
       TNZ *+3       
       CLA NUM+2     L +2
       TRA *+3       
       CAL           L CONTENTS LOCATION 00000
       SUB NUM+1     L +1
       ALS 18        SHIFT TO DEC OF ACC
       STZ HOLD+2    CLEAR LOCATION
       STD HOLD+2    SAVE IN DEC OF WORD
       LXD HOLD,1    DEC OF WORD TO XRA
       SXA HOLD+2,1  SAVE IN ADR OF WORD
       SXA RECT-1,1  XRA TO ADR OF INSTR
       SXA RECT+5,1  
       CLA HOLD+2    
       LDQ NUM       CLEAR MQ
       HPR           TRANSFERRED OUT OF CONTROL
       REM           
*ADR FROM WHICH CONTROL WAS RECOVERED IS IN DECREMENT AND STARTING
*ADDRESS OF TEST WHICH WAS UNDERWAY IS IN ADR OF ACCUMULATOR
       REM           
*00002 IS THE DECREMENT INDICATES THE PROGRAM TRAPPED TO LOCATION
*40001 FOR A SENSE OR SELECT INSTRUCTION OF 40002 FOR A COPY
*INSTRUCTION BUT FAILED TO STORE THE LOCATION OF A TRAP INSTRUCTION
*PLUS 1 IN THE ADDRESS PORTION OF 40000
       REM           
       REM           
       REM           
       PXD 0,1       LOC OF TEST UNDERWAY
       REM           TO ACCUMULATOR
       SUB K1+3      L HTR 0,0,AY
       TZE AY        IF IN INITIAL PROGRAM
       REM           ROUTINE, RETURN TO IT
       CLA           L LOC OF TEST UNDERWAY
 RECT  SUB NUM+1     L +1
       STA *+1       
       CLA           
       ALS 18        SHIFT TO DECREMENT
       STD HOLD      
       TRA           RETURN TO TEST THAT
       REM           WAS UNDERWAY
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*INSTRUCTIONS FOR LOWEST LOCATIONS IN UPPER DIVISION OF STORAGE
       REM           
 TRAP  TRA AY3       
       REM           
*HALT AT 1ST LOCATION IN UPPER HALF OF STORAGE MAY INDICATE NO I/O OR
*CPY TRAP WHEN A SELECT OR CPY IS AT LAST LOWER HALF STORAGE LOCATION
       REM           
       HTR           
       TTR TRLOC     TRA LOC 40021
       TTR TRLOC     
       CLA 16K+1     L CONTENTS LOC 40000
       ADD NUM+2     L +2
       STA 16K+7     ADR TO LOC 40006
       TTR           
       TRA AZA       
       STR 8191      
       TRA AA-2      
       TRA AB-3      
       TRA A1A       
       TRA A2A       
       TRA A3A-2     
       TRA 1,2       
       IOCD RE,0,24  
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*IN ORDER TO LOAD THIS OR ANY OTHER PROGRAM AND STORE INSTRUCTIONS AT
*CORRECT LOCATIONS THE I/O TRAP TRIGGER AND TEH MEMORY NULLIFICATION
*TRIGGER MUST BE OFF 
       REM           
 GO    EMTM        ENTER MULTIPLE MODE
       NOP           
       CLA NUM2+2   L TRA AY2
       STO 32K       STORE IN LOC 77777
       REM           
*CHECK FOR 16/16 OR 8/24 NULLIFY DIVIDED STORAGE
       REM           
       HPR           
****************************************************************************
*                                                                          *
*                          PERFORM NEXT 4 STEPS HERE                       *
*                                                                          *
*   ON INITIAL PASS ONLY, SIGN KEY -- UP FOR TAPE LOADING                  *
*                                  -- DOWN FOR CARD LOADING                *
*                                                                          *
*   SET SWITCH FOR 16/16 OR 8/24 NULLIFY STORAGE                           *
*                                                                          *
*   SET KEY 34 DOWN TO TEST BTTX AND ETTX                                  *
*   SET KEY 34 UP TO BYPASS BTTX AND ETTX TEST                             *
*                                                                          *
*   IF A 16/16 NULLIFY DIVIDED STORAGE, KEY 35 UP                          *
*   IF A 8/24 NULLIFY DIVIDED STORAGE, KEY 35 DOWN                         *
*                                                                          *
*   IF SENSE SWITCH 5 IS DOWN, PUT IT UP BEFORE PUSHING START BUTTON       *
*                                                                          *
****************************************************************************
       STZ PASS      CLEAR THESE
       STZ PASS+1    LOCATIONS
       REM           
       ENK           KEYS TO MQ
       XCA           MQ TO ACC
       PAI           ACC TO IND
       ZET PASS+2    HAS PASS BEEN MADE
       TRA *+7       YES
       REM           
*CHECK IF NEXT DIAGNOSTIC WILL BE LOADED FROM TAPE
       REM           
       TMI *+6       NO, CHECK IF TAPE LOAD
       REM           
*ADJUST NECESSARY INSTRUCTIONS IF THIS DIAGNOSTIC IS LOADED FROM TAPE
*IN ORDER TO BYPASS THE LOAD TAPE ROUTINE
       REM           
       CLA NUM2+3    ALTER
       STO CRSL      NECESSARY
       CLA NUM2+4    INSTRUCTIONS
       STO A27-3     FOR TAPE
       STO A28X-3    LOAD
       REM           
       RNT 1         IS KEY 35 DOWN
       TRA GO1       NO
       REM
       REM
*ADJUST PROGRAM LOCATIONS FOR AN 8/24 NULLIFY DIVIDED STORAGE
       REM           
       CLA NUM1+1    ADJUST ALL
       STO GO2+2   PRINT IMAGES
       CLA NUM1+9    FOR 8/24 NULLIFY
       STO OVER+5    STORAGE
       STO OUT+4     DIVISION
       TRA *+6       
       REM           
       REM           
*ADJUST PROGRA LOCATIONS FOR A 16/16 NULLIFY DIVIDED STORAGE
       REM           
 GO1   CLA NUM1+7    ADJUST ALL
       STO GO2+2   PRINT IMAGES
       CLA NUM1+8    FOR 16/16 NULLIFY
       STO OVER+5    STORAGE
       STO OUT+4     DIVISION
       REM           
 GO1A  RNT 2       IS KEY 34 DOWN
       TRA *+5     NO
       REM           
       CLA A10B    GET A NOP
       STO A10A+2  STORE IN 
       STO A10C+2  TRANSFER
       STO A10E+2  LOCATIONS
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
*WITH SENSE SWITCH 3 UP, IDENTIFY PROGRAM
       REM           
       TSX SPLT1+3,4 TO BCD PRINT ROUTINE
       MTW 12,0,1    SPLAT CONTROL WORD
       REM           
       BCD 6PERFORMING XCOMC 704/7090/7094 COMPA
 GO2   BCD 6TABILITY ON       NULLIFY STORAGE
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
*ADJUST PROGRAM AS PER STORAGE DIVISION
       REM           
       LXA GO2+2,1   8/24K,XRA 20460
       TXL STG16,1,4528  16/16K, XRA 10660
       REM           
       REM           
       REM           
*   SET  PROGRAM FOR CORRECT VALUES FOR AN 8/24K STORAGE.
       REM           
       AXT 9,4       
       SXA STG,4     
       REM           
       AXT 8K-TOTAL-1,4
       SXA STG+4,4   
       REM           
       ZET NUL8    HAS A PASS BEEN MADE IN THE
       REM           8/24K NULLIFY STORAGE MODE.
       TRA *+4      YES- OMIT RESET, LOAD TESTS.
       REM           
       CLA NUM1+19   
       STO A27-5     
       STO NUL8      
       REM           
       REM           
       AXT 8K-1,4    
       TRA BOTH      
       REM           
       REM           
       REM           
*  SET  PROGRAM FOR CORRECT VALUES FOR 16/16K STORAGE.
       REM           
 STG16 AXT 17,4      
       SXA STG,4     
       REM           
       AXT 16K-TOTAL-1,4
       SXA STG+4,4   
       REM           
       REM           
       ZET NUL16   HAS A PASS BEEN MADE IN THE
       REM           16/16K NULLIFY STORAGE MODE.
       TRA *+4      YES- OMIT RESET, LOAD TESTS.
       REM           
       CLA NUM1+19   
       STO A27-5     
       STO NUL16     
       REM           
       REM           
       AXT 16K-1,4   
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
*  XRC  CONTAINS EITHER 17776 OR 37776
       REM           
 BOTH  SXD NMBR,4    
       REM           
       TXI *+1,4,1   XRC CONT-  17777 OR 37777.
       SXA 3259,4    
       SXA STG+6,4   
       SXD FXM08,4   
       SXA FXM15,4   
       SXA FXM16,4   
       SXA FXM18,4   
       SXA FXM19,4   
       REM           
       TXI *+1,4,1   XRC CONT-  20000 OR 40000.
       SXA NUM1+16,4 
       SXA FXM07,4   
       REM           
       TXI *+1,4,7   XRA CONT-  20007 OR 40007.
       SXA FXM01,4   
       REM           
       TXI *+1,4,2   XRC CONT-  20011 OR 40011.
       SXA FXM02,4   
       REM           
       TXI *+1,4,1   XRC CONT-  20012 OR 40012.
       SXA FXM03,4   
       REM           
       TXI *+1,4,1   XRC CONT-  20013 OR 40013.
       SXA FXM04,4   
       REM           
       TXI *+1,4,1   XRC CONT-  20014 OR 40014.
       SXA FXM05,4   
       REM           
       TXI *+1,4,1   XRC CONT-  20015 OR 40015.
       SXA FXM06,4   
       REM           
       TXI *+1,4,1   XRC CONT-  20016 OR 40016.
       SXA FXM09,4   
       SXA FXM10,4   
       SXA A6XX,4    
       SXA FXM11,4   
       SXA FXM12,4   
       SXA FXM13,4   
       SXA FXM14,4   
       SXA FXM17,4   
       SXA A28B,4    
       REM           
       TXI *+1,4,1   XRC CONT-  20017 OR 40017.
       SXA FXM20,4   
       SXA FXM21,4   
       REM           
       TXI *+1,4,1   XRC CONT-  20020 OR 40020.
       SXA STG+2,4   
       REM
       REM
       REM
       REM
*INSERT INSTRUCTIONS IN LOCATIONS AS PER NULLIFY DIVIDED STORAGE
       REM           
*PUT GROUP OF INSTR IN LOWER LOCATIONS OF UPPER DIVISION OF STORAGE
 STG   AXT 17,4      L 21 IN XRC
       CLA TRAP+17,4 INSERT IN LOCATIONS
       STO 16K+17,4  STORE STR INSTRUCTION
       TIX *-2,4,1   AS PER DIVIDED STORAGE
       REM           
*  FOR 16/16 NULLIFY STORAGE, FILL LOCATIONS 13171 THRU 37776 WITH STR.
*  FOR  8/24 NULLIFY STORAGE, FILL LOCATIONS 13171 THRU 31776 WITH STR.
       AXT 16K-TOTAL-1,4 NO OF LOCATIONS TO XRC
       CLA NUM2+7        L STR 17777
       STO 16K,4         STORE IN LOCATIONS AS
       TIX *-1,4,1       PER NULLIFY STORAGE
       REM           
* IN EITHER MODE, FILL LOCATIONS FROM SYMBOLIC LOCATION (UNIQ)
*    TO LOCATION 77776 WITH STR.
       REM           
       AXT  32K-UNIQ,4   NO OF LOC TO XRC.
       STO 32K,4         STORE STR IN LOCATIONS
       TIX *-1,4,1       AS PER NULLIFY STORAGE
       REM           
       AXT ERROR-4-E5-1,4 STORE IN LOCATIONS
       STO ERROR-4,4      BETWEEN 9M05
       TIX *-1,4,1        AND 9DEPR
       REM           
       AXT AY-KONST-3,4   FILL LOCATIONS
       STO AY,4           BETWEEN 9DEPR
       TIX *-1,4,1        AND XCOM
       REM           
       LXA  GO2+2,4        FOR  8/24   XRC 20460
       TXL STGB-2,4,4528   FOR 16/16   XRC 10660
       REM           
*FILL LOCATIONS 20000-20006 AND 20020-37777 WITH STR
       AXT 7,4           NO OF LOCATIONS TO XRC
       STO 8K+8,4        STORE STR IN LOCATIONS
       TIX *-1,4,1       20000-20006
       REM           
       AXT 16K-8K-17,4   NO OF LOCATIONS TO XRC
       STO 16K,4         STORE STR IN LOCATIONS
       TIX *-1,4,1       20020-37776
       REM           
       AXT  9,4      NO OF LOCATIONS TO XRC.
       STO 16K+17,4    STORE STR IN LOCATIONS
       TIX *-1,4,1       40007 TO 40017.
       REM           
*INSERT SELCT, SENSE AND CPY TRAP ROUTINE IN LOCATIONS 40000-40006
       AXT 7,4       7 NOW IN XRC
       CLA TRAP+8,4  TRAP ROUTINE
       STO 16K+8,4   TO LOCATIONS
       TIX *-2,4,1   40000-40006
       REM           
       CLA TRAP      L TRA AY3
       STO 8K        IN LOC 17777
       REM
       REM
*INSERT ERROR DETECTING INSTRUCTION IN LOCATION 37777
       REM           
       CLA NUM2+1    L TRA AY1
 UNIQ1 STO  16K      STORE IN LOC 37777
       TRA *+3       
       REM           
*INSERT ERROR DETECTING INSTRUCTION IN LOCATION 17777
       REM           
       CLA NUM2+1    L TRA AY1
       STO 8K        STORE IN LOC 177777
       REM           
 STGB  CLA NUM2+7    L STR 17777
       AXT 23,4      L 27 IN XRC
       STO 23,4      FILL LOCATIONS
       TIX *-1,4,1   00000-00026
       REM           
       CLA K         L TRA SPACE
       STO 2         STORE IN LOCATION 00002
       REM           
       SLF           SENSE LIGHTS OFF
       TRA AY        COMMENCE TEST
       REM           
       REM           
       REM           
       REM           
*PRINT IMAGE FOR CHECKING RESET BUTTON IN COMPATABILITY TEST
       REM           
 RE    OCT 420004             9 L
       OCT 142101000000       9 R
       OCT                    8 L
       OCT                    8 R
       OCT 201                7 L
       OCT 200000200000       7 R
       OCT 200000             6 L
       OCT 600000000          6 R
       OCT 14002              5 L
       OCT 24010400000        5 R
       OCT 100020             4 L
       OCT                    4 R
       OCT 40000              3 L
       OCT 10022000000        3 R
       OCT 410                2 L
       OCT 4000000            2 R
       OCT 1100               1 L
       OCT                    1 R
       OCT 140030             0 L
       OCT 10026000000        0 R
       OCT 610002             11L
       OCT 322300400000       11R
       OCT 25105              12L
       OCT 45511200000        12R
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM INDEXABLE BCD PRINT SUBROUTINE.
       REM           
 SPLAT TRA SPLT1     CHECK FOR SENSE PRINTER
       SXA SPLAT+61,1 
       SXA SPLAT+62,2 
       SXA SUBET,4   SAVE ORIGINAL XRC.
       NZT 1,4       IF CONTROL WORD ZERO.
       REM           
       TRA 2,4       RETURN
       REM           
       CAL 1,4       GET NON-ZERO WORD
       SLW SPLAT+85  SAVE CONTROL WORD
       PDX 0,1       TYPE WHEEL NO.
       TXL SPLAT+65,1,0 IF DECR. ZERO, GET
       REM           NEW CONTROL WORD
       REM           
       SXD *+2,4     GET EXIT ADDRESS
       PAC 0,2       BY ADDING TWOS COMP.
       TXI *+1,2,0   OF N TO XRC.
       SXA SPLAT+63,2 EXIT VALUE.
       REM           
       REM SET BIT INDEX TO STARTING WHEEL
       REM           
       SXA *+3,1     FOR SHIFTING
       REM           
       AXT 1,3       1 TO XRA AND XRB
       CAL SPLAT+82  BIT INDEX TO P
       LGR 0,1       SHIFT TO STARTING POINT
       TNZ *+3       IF ACC IS ZERO, SET FOR
       STQ SPLAT+83  RIGHT ROW, AND MAKE
       REM           
       TXI *+2,2,1   XRB A DUECE
       SLW SPLAT+83  OTHERWISE, LEFT ROW.
       AXT 26,1      
       STZ CI+26,1   CLEAR CARD IMAGE
       TIX *-1,1,1   
       REM           
       REM           
       REM FORM CARD IMAGE.
       REM           
       TIX *+1,4,1   ADDRESS OF FIRST WORD.
       AXT 6,1       CHARACTER COUNT.
       LDQ 1,4       GET THE WORD.
       REM           
       SXA SPLAT+54,1 SAVE CHARACTER COUNT.
       PXD           CLEAR ACC.
       REM           
       LGL 2         ZONE
       ALS 1         TIMES 2
       PAX 0,1       
       SXA SPLAT+45,1 FOR FUTURE REFERENCE.
       CLM           
       REM           
       LGL 4         DIGIT
       ALS 1         TIMES 2
       SLW CI        TEMPO
       CAL SPLAT+83  BIT INDEX
       NZT CI        IS DIGIT ZERO.
       REM           
       TXH SPLAT+80,1,0 IS ZERO TOO.
       LXA CI,1      OK, PROCEED
       TXH SPLAT+48,1,24 CHECK FOR ILLEGAL
       TXH SPLAT+78,1,20 SPECIAL CHARACTER.
       ORS* SPLAT+92,2 XRB PICKS LEFT OR RIGHT.
       REM           
       AXT 0,1       ZONE AGAIN.
       TXL *+2,1,0   NOTHING FOR ZERO ZONE
       ORS* SPLAT+90,2 PLACE ZONE BIT.
       REM           
       REM COLUMN SET.
       REM           
       ARS 1         SET BIT INDEX TO
       TNZ *+4       NEXT COLUMN, IF ANY.
       REM           
       TXH SPLAT+60,2,1 IF BX ZERO,+XRB 1, STOP
       REM           
       CAL SPLAT+82  IF NOT, SET TO RIGHT
       TXI *+1,2,1   ROW AND PROCEED.
       SLW SPLAT+83  BX READY FOR NEXT COLUMN.
       AXT 0,1       MORE CHARACTERS.
       REM           
       TIX SPLAT+28,1,1 NEXT COLUMN
       LXA SPLAT+85,1 MORE WORDS MAYBE.
       TNX *+3,1,1   IF NOT, STOP
       SXA SPLAT+85,1 YUMMY, GO GET EM.
       TXI SPLAT+25  
       REM           
       RCHA SPLAT+84 LEFT HER RIP
       AXT 0,1       
       AXT 0,2       
       AXT 0,4       
       TRA 2,4       EXIT
       REM           
       REM           
       REM GET NEW CONTROL WORD FROM SOMPLACE
       REM           
       REM           
       SXA SPLAT+63,4 FOR EXIT
       LXA SPLAT+61,1 RESETORE XRA
       NZT* SPLAT+85 IF CONTROL WORD ZERO
       TRA SPLAT+61  RETURN.
       CAL SPLAT+85  OLD CONTROL WORD
       REM           
       STT *+1       BRING OUT INDEX
       SXD *+2,0     REGISTER, IF ONE IS TAGED.
       PAC 0,4       
       TXI *+1,4,0   GET EFFECTIVE ADDRESS.
       CAL 0,4       NEW CONTROL WORD.
       REM           
       PDX 0,1       TYPE WHEEL ID.
       REM
       REM
       SLW SPLAT+85  
       TXI SPLAT+15,4,1 PROCEED
       REM           
       ORS* SPLAT+88,2 PUT EIGHT IN, TAKE
       TIX SPLAT+44,1,16 16 OUT, - GOOD BUSINESS
       REM           
       TXL SPLAT+47,1,4 IF NOT BLANK, SET ZONE.
       TRA SPLAT+48  BLANK.
       REM           
       MZE           FOR BIT INDEX.
       HTR           DYNAMIC BIT INDEX.
       IOCD CI+2,,24 BUFFER COMMAND
       REM           
       HTR           SPECIAL SALON FOR
       REM           THE CONTROL WORD
       HTR CI+5      
       HTR CI+4      8ROW ADDRESSES
       HTR CI+27,1   
       HTR CI+26,1   ZONE ROW ADDRESSES
       REM           
       HTR CI+21,1   
       HTR CI+20,1   DIGIT ROW ADDRESSES
       REM           
 CI    BSS 26        
 SUBET BSS 1         
       REM           
 SPLT1 SWT 2         AND SWITCHES
       TRA *+2       CHECK SWITCH 3
       TRA SPLIT     IGNORE ERROR
       REM           
       SWT 3         TEST THREE
       TRA *+2       UP-PRINT
       TRA SPLIT     DOWN-RETURN
       REM           
       CAL 1,4       L CONTROL WORD
       WPRA          SELECT PRINTER
       PBT           P BIT IN CNTRL WORD
       TRA SPLAT+1   NO
       SPRA 3        YES-TAKE A CYCLE
       ALS 1         MOVE 1 TO LEFT
       PBT           P BIT
       TRA SPLAT+1   NO
       WPRA          YES-DOUBLE
       SPRA 3        SPACE
       TOV SPLAT+1   
       REM           
 SPLIT CLA 1,4       CONTROL WORD
       STA *+2       STORE NO. OR WORDS
       TIX *+1,4,2   DECREMENT XRC BY 2
       TRA 0,4       
       REM
       REM
       REM
       REM
*FIXED BINARY TO FIXED BCD. BINARY WORD IN THE ACC ON
*ENTRY, BCD WORDS IN ACC AND MQ ON EXIT.
       REM LEADING BLANKS FOR LEADING ZEROS.
       REM BLANKS FOR PLUS, - FOR MINUS.
*IF THE HIGH ORDER 6 CHARACTERS ARE BLANK, RETURN IS
*MADE TO X+2, OTHERWISE TO X+1.
       REM XRC IS STORED AT SUBET, WHICH MUST
       REM BE SUPPLIED BY THE PROGRAM.
       REM           
 BTEN  SXA BTEN+23,1 
       SXA BTEN+24,2 
       SXA SUBET,4   SAVE XRC
       SLW FREE      DROP SIGN
       CLM           
       STO FREE+3    SAVE SIGN
       STZ FREE+1    
       STZ FREE+2    
       AXT 2,2       
       AXT 36,1      
       REM           
       PXD           CLEAR ACC.
       LDQ FREE      
       NZT FREE      WHEN ZERO-
       TRA BTEN+26   FINISHED.
       DVP BTEN+38   BY 10 DECIMAL.
       STQ FREE      
       ALS 36,1      SHIFT TO POSITION,
       ACL FREE+3,2  TACK ON LOW ORDER-
       SLW FREE+3,2  SAVE PARTIAL RESULT.
       TIX BTEN+10,1,6 GET NEXT DIGIT, OR
       REM           
       TIX BTEN+9,2,1 SECOND WORD.
       CAL FREE+2    IF XRB RUNS OUT BEFORE
       REM           QUOT. IS ZERO, NO
       REM           ROOM FOR SIGN.
       LDQ FREE+1    LOW ORDER TO MQ.
       AXT 0,1       
       AXT 0,2       
       TRA 1,4       EXIT-TO X+1 FOR 2 WORDS.
       REM           
       CLA FREE+3  BRING IN SIGN
       ORA BTEN+36  BLANK-MINUS
       TMI *+2     WAS WORD MINUS
       CAL BTEN+37  NO GET BLANKS
       ALS 36,1    BUMBSIE DAISY
       ACL FREE+3,2  NON-ZERO DIGITS
       TXL BTEN+22,2,1  OUT ON HIGH ORDER
       XCL           
       CAL BTEN+37   HIGH ORDER BLANK.
       TXI BTEN+24,4,-1 RETURN TO X+2
       OCT -406060606040 BLANK MINUS.
       OCT 606060606060  BLANK PLUS
       HTR 10        DIVISOR
       REM           
 FREE  BSS 10        
       REM
*          CONSTANTS     
       REM           
       REM           
 K     TRA SPACE     
       TRA AZA-2     
       TRA AA        
       TRA AB-5      
       TRA A1A-2     
       TRA A2A-2     
       TRA A3A       
       TRA 2,2       
       HTR A7A       
       HTR A15A      
       TTR A16A      
       STR A16A-9    
       HTR A18A      
       TRA A20A      
       TRA A22A      
       TTR 2         
       TRA A24A      
       STR A24A-2,0,11
       TRA A27A      
       TRA A27B      
       HTR A27B-2,0,3 
       TRA A28A      
       IOCD K+23,0,3 
       HTR           
       RTBA 1        
       TRA A28B      
       TRA A28C      
       HTR A28C-2,0,3 
       TRA A26A      
       TRA A14-5     
       HTR A10B      
       HTR A10D      
       HTR A10F      
       REM           
 K1    STR A20A-2    
       HTR A20A-4    
       TRA A6XX      
       HTR 0,0,AY    
       HTR 0,0,A8    
       HTR 0,0,A6X   
       REM           
 NUM   OCT 0         
       OCT 1         
       OCT 2         
       OCT 2000      
       OCT 400100000000
       OCT 432404040404
       OCT 344440404040
       OCT 1007777777 
       OCT 4004444444 
       REM
       REM
       REM
 NUM1  HTR AZ,0,A28B+1
       OCT 601061020460
       OCT 777777707777
       OCT 40000     
       OCT 777777717777
       OCT 17777     
       OCT 40007     
       OCT 010661010660
       OCT 010661010642
       OCT 601061020442
       OCT 30000     
       HTR NUM1+3    
       HTR NUM1+4    
       OCT 20007     
       OCT 17000     
       HTR NUM1+16   
       OCT 40000
       HTR  **       
       HTR  **       
       SWT 3         
       HTR NUM1+6    
       HTR NUM1+13   
       REM           
 NUM2  HTR A6+2      
       TRA AY1       
       TRA AY2       
       RTBA 1        
       TRA M05-2     
       TRA A15Y      
       TRA A20Y      
       STR 8191      
       OCT 2100006121 
       HTR A27C+4    
 MINON OCT 400000000000
 MQNIN OCT 000400000000
 HOLD  OCT  +0       
       OCT           
       OCT           
 LADR  OCT           
 NMBR  OCT           
 PASS  OCT           
       OCT           
       OCT           
 NUL16 OCT           
 NUL8  OCT           
 TGR   OCT           
 TIMES OCT 50        
       OCT 50        
       REM           
 W0    IOCD AZ,0,1   
 TOTAL IOCT 0,0,3    
       REM           
 8K    EQU 8191      
 16K   EQU 16383     
 32K   EQU 32767     
       REM
       REM           
       ORG 3259      
       REM           
*                    CHECK NULLIFY TRIGGER STILL ON
       REM           
       AXT 16K,1     37777 OR 17777 IN XRA
       TXI *+1,1,1   XRA SHOULD BE ZERO
       PXA 0,1       XRA TO ADR OF ACC
       TZE *+2       WAS XRA ZERO
       TSX NOCOM+2,4 NO, INDICATE ERROR
       REM           
*           CHECK CPY OR SELECT TRIGGER STILL ON
       REM           
 CKTGR CPY           IS TRIGGER STILL ON
       NOP           
       TSX NOCOM,4   NO, INDICATE ERROR
       REM           
       NZT TGR       IS LOCATION CLEAR
       TRA *+5       YES
       STZ TGR       NO,CLEAR LOCATION
       CLA A19+3     L COPY
       STO CKTGR     AND STORE
       TRA *+4       PROCEED
       STL TGR       STORE LOCATION
       CLA MORE      L RUNA 2
       STO CKTGR     AND STORE
       REM           
       ESNT *+1      TURN ON TRIGGER
       ESTM          TURN ON TRIGGER
       IOT           IS LIGHT ON
       TSX NOCOM+2,4 YES, ERROR
       REM           
       PXD           CLEAR ACCUMULATOR
       EFTM          FP TRAP TRG ON
       TPL *+2       WAS SIGN CHANGED
       TSX NOCOM+2,5 YES, INDICATE ERROR
       REM           
       ECTM          TURN ON TRIGGER
       TRA 3244      PROCEED
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       BCD 1LV COM   
       REM           
 NOCOM IOT           TURN OFF THE
       NOP           THE LIGHT IF ON
       STZ 3150      CLEAR LOCATION
       PXD 0,4       GET TRUE
       PDC 0,4       FAILURE
       SXD 3150,4    LOCATION
       LXD 3152,4    ROUTINE THAT
       CLA -2,4      MIGHT
       STA 3150      HAVE
       CLA 3150      FAILED
       TSX ERROR-1,4 TO ERROR
       NOP NOCOM     ROUTINE
       REM           
       REM           
       REM           
       REM           
       REM           
* DECREMENT OF ACCUMULATOR CONTAINS TRUE LOCATION OF TRIGGER TESTED
* AND ADDRESS OF ACCUMULATOR CONTAINS INITIAL ADDRESS OF ROUTINE THAT
* MIGHT HAVE CAUSED FAILURE. RETURN IS TO ROUTINE THAT MIGHT HAVE CAUSED
* FAILURE. IF STORAGE NULLIFY TRIGGER IS FAILURE, XRA HAS ERROR VALUE.
       REM           
       PAC 0,4       SET MONITOR
       EFTM          AND ALL
       ESTM          TRIGGERS
       ECTM          AND RETURN
 E5    ESNT 3205     TO 9M05
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       ORG 3392      
       REM           
*MODIFY VERSION OF 9DEPR FOR USE WITH 9M05 FOR RELIABILITY
       REM           
       BSS 2         
       OCT 1         
       TRA ERR       
 ERROR STZ KONST     DO NOT REPEAT SECTION
       STZ KONST+1   IF SW 4 IS DOWN
       REM           
       SWT 2         IF SENSE SW 2 IS UP, THEN
       TRA SSW3      CHECK SSW3
       TIX OK,4,1    
 OK    SXD ERROR-3,4 2-S COMPL OF PROGRAM
       REM           LOCATION LAST PERFORMED
       SWT 1         IF SENSE SW 1 IS UP, THEN
       TRA RELY      CHECK SS4
       TRA 1,4       IF DOWN REPEAT SECTION
       REM           
 SSW3  SXA ERROR-4,4 SAVE XRC TO GET
       LAC ERROR-4,4 TRUE ERROR LOCATION
       HPR           REFER TO LOCATION IN XRC
       SXA ERROR-4,4 RESTORE
       LAC ERROR-4,4 ORIGINAL XRC
       TRA OK-1      FOR RETURN
       REM           
 RELY  SWT 4         IF SWT 4 IS UP, GO TO NEXT
       TRA 3,4       SECTION OF PROGRAM. IF IT
       REM           IS DOWN, REPEAT SECTION
       REM           50 OCTAL TIMES
       CLA KONST+1   COUNTER
       SUB KONST     REDUCE COUNT BY 1
       STO KONST+1   
       TNZ OK+3      
       CLA KONST+2   RESTORE
       STO KONST+1   THE
       CLA ERROR-2   COUNTER
       STO KONST     VALUES
       TRA 3,4       RETURN
       REM           
 ERR   SWT 2         IF SWT 2 IS UP, CHECK
       TRA SSW3A     SENSE SWITCH 3
 OK2   SWT 1         SSW1 UP, GO TO NEXT ROUTINE
       TRA 2,4       EXIT
       TRA 1,4       REPEAT
       REM           
 SSW3A SXA ERROR-4,4 SAVE XRC TO GET
       LAC ERROR-4,4 TRUE ERROR LOCATION
       HPR           REFER TO LOCATION IN XRC
       SXA ERROR-4,4 RESTORE
       LAC ERROR-4,4 ORIGINAL XRC
       TRA OK2       FOR RETURN
       REM           
       REM           
       REM           
       REM           
       REM           
 KONST OCT 1         
       OCT 50        
       OCT 50        
       REM           
       ORG 16400     
       REM           
 UXTRP HTR SHAVE     TO 9M05
 TRLOC CLA 16384     GET TRAP STORE LOC
       CAS UXTRP     COMPARE TO 9M05 ADDR.
       TRA 16387     HIGH
       TRA 16387     EQUAL
       CLA ABCDX     GET STI INSTR.
       CAS 0         COMPARE TO ZERO
       TRA XYZAB     
       TRA *+3       OK
       TRA XYZAB     
       STZ **        CLEAR ZERO
       ECTM 0        COPY TRAP
       ESTM 0        SELECT TRAP
       ESNT 0        STRG. NULL AND TRANSFER
       REM           
 XYZAB CLA 16384     GET STORE TRAP LOC.
       STA ZEBRA     STORE INTO STORE INSTR.
       STA ZEBRA-1    STORE IN IND INSTR.
       STA ABCDX     
       CLA ABCDX     GET STO INSTR.
       STO 0         STORE IN ZERO
       REM           
       CLA XRAYA     GET TRAP MODE TRA
       STO 1         STORE IN LOC 1
       CLA EXIT      GET 9M05 ADDR.
       STA XYZAB-1    STORE IN ESNT ADDR.
       LDI **        LOAD IND WITH STORE TRAP LOC.
 ZEBRA STO **        STORE 9M05 ADDR.
       TRA *+2       SKIP
       REM           
 ABCDX STI **        STORE TRAP LOC)
       LDQ 16384     GET LOC 40000
       RQL 18        ROTATE
       AXT 6,4       SET XRC
       ALS 3         SET INTO BCD
       LGL 3         
       TIX *-2,4,1   
       REM           
       STO XRAYB+6   STORE INTO PRINT IMAGE
       TSX SPLAT,4   TO PRINT ROUT.
       PZE XRAYB     
       TSX SPLAT,4   PRINT
       PZE XRAYC     
       TSX SPLAT,4     ERROR
       PZE XRAYD     
       HTR XYZAB-3        ROUTINE
       REM
       REM
       REM
 XRAYA TRA TRLOC+9   
 XRAYB PZE 6,,1      
       BCD 6ILLEGAL TRAP FROM 9M05 LOC+1
 XRAYC PZE 9,,1      
       BCD 6PRESS START PROG. WILL LOOP IN AREA
       BCD 3CAUSING FAILURE.
 XRAYD PZE 9,,1      
       BCD 6TO RESTORE PROG. AND CONTINUE PUSH R
       BCD 3ESET AND START.
 UNIQ  OCT  +0       
 SHAVE DEFINE 06300  
 EXIT  DEFINE 06264  
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       END GO        
