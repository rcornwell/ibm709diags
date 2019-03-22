         7090/704 or 7094/704 compatability program          xcomc          
             for 16/16 or 8/24 nullify storage              3-15-63        
       REM            
*                      x c o m c    
       REM            
*         704/7090/7094 compatibility program
*          for 16/16 or 8/24 nullify storage
       REM
       org 4096
       REM
*          commence test
       rem
       rem
*check esnt divides storage correctly
       REM            
ay     axt *,1        this location to xra
       tra reset      initialize
       esnt *+1       turn on nullify tgr
       rem
*for 16/16 nullify division 37777 should be only location reached.
*for 8/24 nullify division 17777 should be only location reached.
       rem
       tra 32k        tra to loc 37777 on 16/16 k
       rem            tra to loc 17777 on  8/24 k
       rem
ay1    swt 2          error
       hpr            tra 37777 on 8/24k
       rem            tra 17777 on 16/16k
       rem
       tra *+3
       rem
ay2    swt 2          error
       hpr            tra 77777 on 8/24 or 16/16k
       rem
ay3    swt 1          test switch 1
       tra *+2        continue
       tra ay         repeat
       rem
       rem
*check tra instruction does not turn on memory nullification trigger
       rem
AZ     AXT *,1        LOCATION TO XRA
       TRA monit      program monitor
       CLA K+1        L TRA AXA-2
       STO 7          STORE IN LOCATION 00007
       cla *-1        save address for next
       sta cor        routine initialization
       REM            
       REM            
       REM            
       TRA *+1        is NULLIFY TGR turned on
       rem          if no, tra to location
fxm01  tra  **        20007 or 40007
       REM            
       SWT 2          ERROR
       HPR            CHECK COMPONENTS
       REM            MENTIONED ABOVE
AZA    SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA AZ         REPEAT
       REM            
       REM            
A      AXT *,1        THIS LOCATION IN XRA
       TRA MONIT      MONITOR PROGRAM
       CLA K+2        L TRA AA
       STO 9          STORE IN LOCATION 00011
       cla *-1        save address for next
       sta cor        routine initialization
       REM            
       ESNT *+1       ENTER NULLIFICATION MODE
       REM            
fxm02  tra  **      try tra to upper half of storag
       rem            location-  20011 or 40011
       rem
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM            AND ITS OUPUTS
*CHECK ABILITY TO RESET NULLIFY TRIGGER FOR FULL STORAGE USE
       REM            
AA     CLA K+3        L TRA AB-2
       STO 10         STORE IN LOCATION 00012
       cla *-1        save address for next
       sta cor+1      routine initialization
       pxd            clear accumulator
       ldq 2921       l bit in mq position 1
       rem
       REM            
       REM            
       LSNM           EXIT NULLIFICATION MODE
fxm03  TRA  **      TRA to loc  20012 or 40012.
       REM            
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       rem
*check lsnm did not condition rnd
       rem
       tzb ab         pr sign minus, no rand
       rem
       SWT 2          ERROR
       HPR            pr sign minus shouldnt rnd
       REM 
AB     SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A          REPEAT
       REM            
       REM            
*CHECK TTR +0021 HAS NO EFFECT ON NULLIFY TRIGGER
       REM            
A1     AXT *,1        THIS LOCATION IN XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       CLA K+4        L TRA A1A-2
       STO 11         STORE IN LOCATION 00013
       cla *-1        save address for next
       sta cor        routine initialization
       rem
       REM            
       REM            
       TTR *+1        
       REM            
*CHECK NULLIFY TRIGGER STILL off
       REM            
fxm04  TRA  **      TRA to loc   20013 or 40013.
       REM            
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM 
A1A    SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A1         REPEAT
       REM            
       REM            
*CHECK TEFD -0031 HAS NO EFFECT ON NULLIFY TRIGGER
       REM            
       REM            
A2     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       CLA K+5        L TRA A2A-2
       STO 12         STORE IN LOCATION 00014
       cla *-1        save address for next
       sta cor        routine initialization
       REM            
       REM            
       REM            
       TEFD *+2       
       NOP            
fxm05  TRA  **      TRA to loc   20014 or 40014.
       REM            
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM            AND ITS OUTPUTS
A2A    SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A2         REPEAT
       REM            
       REM            
*CHECK RND +0760---10 HAS NO EFFECT ON NULLIFY TRIGGER
       REM            
A3     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       CLA K+6        L TRA A3A
       STO 13         STORE IN LOCATION 00015
       cla *-1        save address for next
       sta cor        routine initialization
       ESNT *+1       ENTER NULLIFY MODE
       REM            
       REM            
       RND            
fxm06  TRA  **      SHOULD TRA TO LOC 00015
       REM            
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRIGGER
       REM            AND ITS OUTPUT
A3A    SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A3         REPEAT
       REM            
       REM            
*CHECK XR INCREMENTED IN NULLIFY MODE
       REM            
A4     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       lxa  uniq1,2   load 37777 into xrb
       ESNT *+1       SET NULLIFY TRIGGER
       TXI *+1,2,1    ADD ONE TO XRB
       REM            
       REM            
       PXA 0,2        XRB TO ACC
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        OK-XRB HIGH ORDER
       REM            POSITION BLOCKED
       SWT 2          ERROR
       HPR            CHECK HIGH ORDER POS
       REM            XRB AND ADDERS
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A4         REPEAT
       REM            
       REM            
*CHECK AN XR WITH TIX IN NULLIFY MODE
       REM            
A5     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
fxm07  AXT  **,2    set 20000 or 40000 TO XRB.
       REM            
       ESNT *+4       SET NULLIFY TRIGGER
       SWT 2          
       HPR            TIX TRANSFERRED
       TRA *+2        
fxm08  TIX *-3,2,**   NO TRA UNDER ANY CONDITION
       rem         decr set to 17777 or 37777.
       REM            
       REM            
       PXA 0,2        XRB TO ACC
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        OK-XRB ZERO
       SWT 2          ERROR
       HPR            CHECK FOR ADDER
       REM            N CARRY OUTPUT
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A5         REPEAT
       REM            
       REM            
*CHECK TSX IN AND OUT OF NULLIFICATION MODE
       REM            
A5X    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+7        L TRA 2,2
       STO 14         STO IN LOCATION 00016
       REM            
*CHECK TSX WITH NULLIFY TRIGGER SET
       REM            
       ESNT *+1       ENTER NULLIFY MODE
fxm09  TSX  **,2   HIGH ORDER ADR LINE DOWN
       rem         addr set to 20016 or 40016.
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       SWT 2          ERROR
       HPR            TRANSFERRED TO LOC 40016
       REM            
*CHECK TSX WITH NULLIFY TRIGGER RESET
       REM            
       LSNM           turn off NULLIFY TGR
       REM            
       REM            
fxm10  TSX  ** ,2   TRA to LOC 20016 or 40016.
       TRA *+3        OK-PROCEED
       SWT 2          ERROR
       HPR            TRANSFERRED TO LOC 00016
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A5X        REPEAT
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
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
A6     AXT *,1        THIS LOCATION TO XRA
       TRA MONIT      CHECK PROGRAM MONITORED
       AXT 32K,2      77777 TO XRB 
       REM            
       ESNT *+1       SET NULLIFY TRIGGER
       TIX *+1,2,1 
       PXD 0,2  
       LDQ nmbr       mq decrement value
       rem            should be in xrb
       CAS nmbr       
       TRA *+2        ERROR
       TRA *+3        XRB COUNT DOWN OK
       rem
       SWT 2          ERROR
       HPR            check if high order
       rem            positions blocked
       tix *,2,1      count down xrb
       pxa 0,2        xrb to acc
       ldq num+1      l +1
       cas num+1
       tra *+2        error
       tra *+3        xrb count down ok
       rem
       SWT 2          ERROR
       hpr            error in count down
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A6         REPEAT
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
*CHECK ESTM IS INDIRECT ADDRESSABLE
       REM            
A6X    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K1+10      L TRA A6X+5
       STO 8          STORE IN LOCATION 00010
       cla *-1        save address for next
       sto cor        routine initialization
       ESNT* *+7      SET NULLIFY AND IA TRGS
       REM            
       REM            
       REM            
a6xx   TSX  **,2   should TRA TO LOC 00016.
       rem         addr set to 20016 or 40016.
       TRA *+2        ERROR
       TRA *+7        NULLIFY + IA TRGRS OK
       rem
       SWT 2          ERROR
       HPR            WAS NULLIFY TRGR SET
       rem
       TRA *+4        
       LSNM           DO NOT EXECUTE INSTR
       REM            USE ADR PORTION ONLY
       REM            TO GET ADR FOR ESNT INSTR
       REM            TO TRANSFER TO
       rem
       SWT 2          ERROR
       HPR            WAS IA CONTROL TRGR SET
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A6X        REPEAT
       REM            
       REM            
*CHECK I/O SENSE AND TRAP MODE TRIGGER
       REM            
A7     AXT *,1        THIS LOCATION IN XRA
       sln 4          turn on sense lite 4
       TRA MONIT      CHECK PROGRAM MONITORED
       REM            
       REM            
       ESTM           SET I/O SENSE AND TRAP TRGR
       IOT            is lite on
       tra *+2        yes
       tra *+3        no
       rem
       swt 2          error
       hpr            pr sign minus-iot lite off
       rem
       ESNT *+1       turn off nullify trg
       rem            and simulate indicator
       REM            
*bring up store and trap controls, will place the location plus 1 of
*select instruction in address portion of location 40000 and trap to
*location 40001
       REM            
       RTBA 2         sec op 0,2
       rem
A7A    SWT 2          ERROR
       HPR            DID NOT TRAP-SEE COMMENT
       REM            
       REM            
*CHECK NULLIFY TRIGGER NOW RESET
       REM            
fxm11  TSX  **,2    TRA to LOC 20016 or 40016.
       TRA *+3        OK-PROCEED
       rem
       SWT 2          ERROR
       HPR            CHECK NULLIFY TRGR RESET
       REM            
*CHECK CONTENTS of location 40000
       REM            
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ K+8        L HTR A7A
       CAS K+8        
       TRA *+2        ERROR
       TRA *+3        LOC 40000 OK-PROCEED
       rem
       SWT 2          
       HPR            ERROR LOC 40000
       REM            
*CHECK I/O TRAP TRIGGER turned off and select instruction will not trap
       REM            
       RTBA 1         
       Rdca           DISCONNECT I/O UNIT
       TRA *+3        OK-NO TRAP-TRANSFER
       rem
       SWT 2          ERROR
       HPR            TRAPPED
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A7         REPEAT
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
*CHECK IOT +0760---5 HAS NO EFFECT ON I/O SENSE TRAP TRGR
       REM            
A8     AXT *,1        LOCATION TO XRA
       sln 4          turn on sense lite 4
       TRA MONIT      PROGRAM MONITOR
       REM            
       REM            
       ESNT *+1       ENTER NULLIFY MODE
       IOT            
       NOP            
       RTDA 1         DOES SELECT TRAP
       RDCA           DISCONNECT I/O UNIT
       TRA *+3        OK-NO TRAP-TRANSFER
       rem
       SWT 2          ERROR
       HPR            I/O SENSE TRAP TRGR
       REM            SHOULD BE RESET
       REM            
*CHECK NULLIFY TRIGGER STILL SET
       REM            
fxm12  TSX  **,2    SHOULD TRA LOC 00016.
       rem          addr set to 20016 or 40016.
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       rem
       SWT 2          ERROR
       HPR            IS NULLIFY TRGR RESET
       REM            
*CHECK LOWEST LOCATION 40000
       REM            
       LSNM           EXIT NULLIFY MODE
       CLA 16K+1      L LOC 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       rem
       SWT 2          ERROR
       HPR            LOC 40000 NOT ZERO
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A8         REPEAT
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
A9     AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       REM            
*WRITE SELECT INSTRUCTION-SEC OPN 0,6
       REM            
       ESTM         I/O TRAP Trigger on
       WTB 1          704 SELECT INSTR
       rem
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
*REWIND SEC OPN 1,2   
       REM            
       ESTM         I/O TRAP Trigger on
       REW 1          704 SELECT INSTR
       rem
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
*WRITE END OF FILE-SEC OPN 1.0
       REM            
       ESTM         I/O TRAP Trigger on
       WEF 1          704 SELECT INSTR
       rem
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
*BACKSPACE TAPE-SEC OPN 0,4
       REM            
       ESTM         I/O TRAP Trigger on
       BST 1          704 SELECT INSTR
       rem
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A9         REPEAT
       REM            
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
A10    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM           SET I/O SENSE TRAP TRGR
       REM            
       REM            
       PSE 225        SHOULD TRAP
       rem
       SWT 2          ERROR
       HPR            CHECK COMPONENTS
       REM            NOTED IN COMMENTS
       REM            
       ESTM         I/O TRAP TRiggers on
       SPUA 1         SHOULD TRAP
       rem
       SWT 2          ERROR
       HPR            CHECK COMPONENTS
       REM            NOTED IN COMENTS
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        PROCEED
       TRA A10        REPEAT
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
****************************************************************************
****              reference is made to 7090 service aid number 81        ***
****                                                                     ***
****                                                                     ***
****   on a program halt at location 12250, key 34 must be set           ***
****      down in order to check btt and ett in select trap mode.        ***
****                                                                     ***
****                                                                     ***
****   for proper operation of the three following test routines         ***
****      on the 7090, the machine change outlined in cem 81 must        ***
****      have been installed.                                           ***
****                                                                     ***
****                                                                     ***
****************************************************************************
       REM            
       REM            
       REM            
       REM            
*      check btta with triggers on ( no-skip condition )
       rem
       rem
*    note - this test routine will only be checked on the initial pass
*           of xcomc.  if key 34 was not down on the first pass of
*           xcomc, the test routine will not be checked.
       rem
       REM            
a10a   axt            location to xra
       tra monit      program monitor
       tra a10c
       zet pass+2     first pass
       tra a10c       no
       rewa 2         rewind tape 2
       bsra 2         turn on btt trigger
       bsra 2         hold up
       tcoa *            wait
       estm           i/o trap trg on
       btta           should trap
a10b   nop 
       tra *+2        error
       tra *+3        ok
       swt 2    
       hPr
       cla  16k+1     l contents loc 40000
       cas k1-3       l htr a10b
       tra *+2        error
       tra *+4        ok
       ldq k1-3
       swt 2
       hpr
       swt 1          test switch 1
       tra *+2
       tra a10a       repeat
       rem
*   check btta with trigger off ( skip condition )
       rem
a10c   axt *,1        location to xra
       tra monit      program monitor
       tra a10e
       btta           turn trigger off
       nop
       estm           i/o trigger on
       btta           should trap
       nop
a10d   swt 2          error
       hpr
       cla  16k+1     l contents loc 40000
       cas k1-2     l htr a10d
       tra *+2        error
       tra *+4        ok
       ldq k1-2       l htr a10d
       swt 2
       hpr
       swt 1          test switch 1
       tra *+2        continue
       tra a10c       repeat
       rem
       rem
       rem
*     check etta with trigger off ( skipp condition )
       rem
a10e   axt *,1        location to xra
       tra monit      program monitor
       tra a11
       etta           turn off if on
       nop
       estm           i/o trap tgr on
       etta           should trap
       nop
a10f   swt 2          error
       hpr
       cla  16k+1     l contents loc 40000
       cas k1-1       l htr a10f
       tra *+2        error
       tra *+4        ok
       ldq k1-1       htr a10f
       swt 2
       hpr
       swt 1          test switch 1
       tra *+2        continue
       tra a10e       repeat
       REM            
       REM            
       REM            
       REM            
       REM            
****************************************************************************
       REM            
*CHECK SENSE PRINTER  
       REM            
A11    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM         I/O TRAP TRigger on
       REM            
       REM            
       SPTA           SHOULD TRAP
       rem
       SWT 2          ERROR
       HPR            NO TRAP
       REM            
       REM            
       SPTA           SHOULD NOT TRAP
       TRA *+4        OK
       TRA *+3        OK
       rem
       SWT 2          ERROR
       HPR            CHECK TRIGGER RESET AT
       REM            15 TIME AFTER TRAP
       REM            
       Rdca           CLEAR BUFFER
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A11        REPEAT
       REM            
       REM            
*CHECK SENSE PRINTER  
       REM            
A12    AXT *,1        LOCATION TO XRA
       TRA MONIT      MONITOR PROGRAM
       ESTM         I/O TRAP on-2.10.70.1
       REM            
       REM            
       REM            
       REM            
       SPT            SHOULD TRAP
       rem
       SWT 2          ERROR-NO TRAP
       HPR            CHECK COMPONETS
       REM            NOTED IN COMMENTS
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A12        REPEAT
       REM            
       REM            
       REM            
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
A13    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM         I/O trap trigger on
       rem
       FRN            SHOULD NOT TRAP
       TRA *+4        OK-NO TRAP
       NOP
       rem            
       SWT 2          ERROR
       HPR            FRN TRAPPED
       REM            
       REM            
       cla k1-4     set trap tra in loc 10
       sto 8
       cal minon    set acc p to a one
       ldq mqnin    set mq 9 to a one
       ETT 1          SHOULD TRAP
       rem
       SWT 2          ERROR-NO TRAP
       HPR            CHECK COMPONETS
       REM            NOTED IN COMMENTS
       REM            
       REM            NOTE THAT TRIGGER IS TURNED
       REM            OFF BY THE NEXT 15 PULSE
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A13        REPEAT
       REM            
       REM            
*CHECK DCT +0760----12 AND RTT-0760---12
       REM            
A14    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM         i/o trap trigger on
       REM            
       REM            
       DCT            INDICTOR IS OFF
       NOP            NO TRAP AND
       TRA *+3        SKIP TO HERE
       rem
       SWT 2          ERROR
       HPR            SEE COMMENT ABOVE
       REM
       RTT            SHOULD TRAP
       rem
       SWT 2          ERROR
       HPR            NO RTT TRAP-SEE
       REM            COMMENT ABOVE
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A14        REPEAT
       REM            
       REM            
*CHECK TAGGED SENSE INSTRUCTION WITH COMPATABLIBLITY FEATURE
       REM            
A15    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLS NUM        L -0
       AXT 240,2      L 360 TO XRB
       ESNT *+1       ENTER NULLIFY MODE
       ESTM         i/o trap trigger on
       PSE 243,2      SHOULD NOT TRAP-ONLY
       REM            MAKE ACC SIGN PLUS
       REM
       TRA *+4        OK-PROCEED
       NOP            
       rem
       SWT 2          ERROR
       HPR            TRAPPED
       REM            
       TPL *+3        OK-ACC SIGN PLUS
       rem
       SWT 2          ERROR
       HPR            ACC SIGN MINUS
       REM            
*CHECK NULLIFY TRIGGER REMAINED SET
       REM            
fxm13  TSX  **,2    SHOULD TRA to LOC 00016.
       rem          addr set to 20016 or 40016.
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       rem
       SWT 2          ERROR
       HPR            IS NULLIFY TRIGGER RESET
       REM            
*CHECK COMPATABILITY FEATURE WITH XRB ZERO
       REM
       AXT 0,2        CLEAR XRB
       PSE 243,2      
       rem
A15A   SWT 2          ERROR
       HPR            NO TRAP
       REM            
*CHECK NULLIFY TRIGGER NOW RESET
       REM            
fxm14  TSX  **,2    TRA to LOC 20016 or 40016.
       TRA *+3        OK-NULLIFY TRIGGER RESET
       rem
       SWT 2          ERROR
       HPR            NULLIFY TRIGGER NOT RESET
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ K+9        L HTR A15A
       CAS K+9        
       TRA *+2        ERROR
       TRA *+3        OK-PROCEED
       rem
       SWT 2          ERROR
       HPR            ADR IN LOC 40000 NOT A15A
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A15        REPEAT
       REM            
       REM            
*cHeck select instruction at last location in lower half of storage
       rem
a15x   axt *,1        location to xra
       tra monit      program monitor
       cla a9+3       wtb 1 stored in the last
fxm15  sto  **      store in 17777 or 37777.
       cla num2+5     l tra a15y
       sto 16k+2      and store
       estm           i/o trap tgr on
       rem
fxm16  tra  **      tra to loc 17777 or 37777.
       rem          trap on i/o.
a15y   cla 16k+1      l contents 40000
       cas num1+16    20000 or 40000 in loc 40000
       tra *+2        error
       tra *+4        loc 40000 ok
       ldq num1+16    20000 or 40000 to mq
       REM
       swt 2          error
       hpr            loc 40000 wrong
       rem
       cla            l contents location 00000
       ldq num2+7     l str 17777
       cas num2+7     compare
       tra *+2        error
       tra *+3        contents location 00000 ok
       rem
       swt 2          error
       hpr            contents location 00000 ng
       rem
       cla 16k+3      restore correct
       sto 16k+2      instruction
       rem
       swt 1          test switch 1
       tra *+2        continue
       tra a15x       repeat
       rem
*CHECK COMPATABILITY FEATURE IN TRAPPING MODE
       REM            
A16    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       LTM            LEAVE TRAP MODE
       CLA K+10       L TTR A16A
       STO 1          STORE IN LOCATION 000001
       cla *-1        save address for next
       sta cor        ROUTINE initialization
       ESNT *+1       ENTER NULLIFY MODE
       ESTM           ENTER I/O SENSE TRAP MODE
       ETM            ENTER TRAP MODE
       LDQ NUM        L +0 TO MQ
       REM            
       REM            
       TQP *+1        
       LTM            LEAVE TRAP MODE
       TRA *+5        ERROR
       REM            
       LTM            LEAVE TRAP MODE
       SWT 2          ERROR
       HPR            TRAPPED TO LCOC 40001
       TRA *+3        PROCEED
       REM            
       SWT 2          ERROR
       HPR            TQP DIDNOT TRAP TO 00001
       REM            
*CHECK CONTENTS LOCATION 00000
       REM            
A16A   LTM            LEAVE TRAP MODE
       CLA            L CONTENTS LOC 00000
       LDQ K+11       L STR A16A-9
       CAS K+11       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OK
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 00000 WRONG
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
       LSNM           RESET NULLIFY TRIGGER
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       rem
       WRS 219        CONTENTS LOC 40000 OK
       REM            SELECT INSTR TO RESET
       REM            I/O SENSE TRAP TRGR-TRAP
       REM            AND TRANSFER TO A17-3
       REM            
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A16        REPEAT
       REM            
       REM            
       REM            
A17    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       rem
       CPY            TURN ON IOT LIGHT
       TRA *+4        AND NO TRAP
       NOP            
       rem
       SWT 2          ERROR
       HPR            TRAPPED
       REM            
       IOT            CHECK IOT LITE
       TRA *+3        OK-LIGHT WAS ON
       rem
       SWT 2          ERROR
       HPR            LIGHT WAS OFF
       REM            
*CHECK LOCATION 40000 
       REM            
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        
       TRA *+3        CONTENTS LOC 40000 OK
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       REM            
       rem
       rem
       rem
       rem
       rem
       rem
       rem
*CHECK COPY AND AND LOGICAL WORD
       REM            
       CAD            
       TRA *+4        OK
       NOP            
       rem
       SWT 2          ERROR
       HPR            TRAPPED
       REM            
       IOT            CHECK IOT LIGHT
       TRA *+3        OK-LIGHT WAS ON
       rem
       SWT 2          ERROR
       HPR            LIGHT WAS OFF
       REM            
*CHECK CONTENTS LOCATION 40000
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOCATION 40000 OK
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOCATION 40000 WRONG
       REM            
       REM            
*CHECK LDA
       REM            
       LDA 1          
       TRA *+4        OK-NO TRAP
       NOP            
       rem 
       SWT 2          ERROR
       HPR            TRAPPED
       REM            
       IOT            CHECK IOT LIGHT
       TRA *+3        OK-LIGHT WAS ON
       rem 
       SWT 2          ERROR
       HPR            LIGHT WAS OFF
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 40000 OK
       rem 
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A17        REPEAT
       REM            
       REM            
*CHECK OPERATION WITH COPY TRAP TRIGGER SET
       REM            
A18    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESNT *+1       ENTER NULLIFY MODE
       REM            
       REM            
       ECTM           
       REM            
*check ectm does not condition com
       rem
       tze *+3        acc should be zero
       rem
       swt 2          error
       hpr            pr sign minus shouldnt com
       rem
       rem
       REM            
       CPY            
A18A   SWT 2          ERROR
       HPR            NO TRAP
       REM            
*CHECK NULLIFY TRIGGER NOW off
       REM            
fxm17  TSX  **,2    TRA to LOC 20016 or 40016.
       TRA *+3        OK-NULLIFY TRIGGER RESET
       rem
       SWT 2          ERROR
       HPR            CHECK NULLIFY TGR turned
       rem            off by output from +0r
       rem
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ K+12       L HTR A17A
       CAS K+12       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 40000 OK
       rem
       SWT 2          ERROR
       HPR            CHECK ADR LOC 40000
       REM            
*CHECK IOT LIGHT      
       REM            
       IOT            CHECK IOT LITE
       TRA *+2        ERROR
       TRA *+3        OK-LIGHT WAS OFF
       rem
       SWT 2          ERROR
       HPR            IOT LIGHT WAS ON
       REM            
*CHECK COPY TRAP TRIGGER NOW Off
       REM            
       CPY            
       TRA *+4        OK-PROCEED
       NOP            
       rem
       SWT 2          ERROR
       HPR            CPY TRAP TRGR NOT RESET-SEE
       REM            AND CIR, MF3 J04 D 2.07.76
       REM            RESETS CPY TRAP TRIGGER
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A18        REPEAT
       REM            
       REM            
*CHECK CAD AND LDA TRAPS
       REM            
A18X   AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ECTM           SET CPY TRAP TRIGGER
       CAD            SHOULD TRAP LIKE CPY
       REM 
       SWT 2          ERROR
       HPR            SEE COMENTS FOR A CPY
       REM            TRAP IN SECTION A17
       REM            
       ECTM           SET CPY TRAP TRIGGER
       LDA 1          
       rem
       SWT 2          ERROR
       HPR            NO TRAP-see input e to
       REM            logic block 5i systems
       REM            2.10.71.1
       REM
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A18X       REPEAT
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
*CHECK COMPLEMENT +0760--06 HAS NO EFFECT ON CPY TRAP MODE TRIGGER
       REM            
A19    AXT *,1        LOCATION TO XRA
       TRA MONIT      
       REM            
       REM            
       COM            SHOULD NOT turn
       rem            on cpy trap trigger
       REM            
       REM            
*CHECK CPY TRAP TRG REMAIN off
       CPY            
       TRA *+4        OK-NO TRAP
       NOP            
       SWT 2          ERROR
       HPR            CPY Tgr SHOULD stay
       REM            off with pr sign plus
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A19        REPEAT
       REM            
       REM            
*check cpy instruction at last location in lower half of storage
a20x   axt *,1        location to xra
       tra monit      program monitor
       cla a19+3      cpy stored in the last
fxm18  sto  **      store in loc 17777 or 37777.
       cla num2+6     l tra a20y
       sto 16k+3      and store
       ectm           cpy trap tgr on
       rem
fxm19  tra  **      tra to loc 17777 or 37777.
       rem          trap on copy.
a20y   cla 16k+1      l contents 40000
       cas num1+16    20000 or 40000 in loc 40000
       tra *+2        error
       tra *+4        loc 40000 ok
       ldq num1+16    20000 or 40000 to mq
       rem
       swt 2          error
       hpr            loc 40000 wrong
       rem
       cla            l contents location 000000
       ldq num2+7     l str 17777
       cas num2+7     compare
       tra *+2        error
       tra *+3        contents location 00000 ok
       swt 2          error
       hpr            contents location 00000 ng
       rem
       cla 16k+2      restore correct
       sto 16k+3      instruction
       rem
       swt 1          test switch 1
       tra *+2        continue
       tra a20x       repeat
       rem
*CHECK STR TRAPS TO LOCATION 00002 WITH COMPATABILUITY FEATURE
       rem
A20    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+13       L TRA A20A
       STO 2          STORE IN LOCATION 00002
       cla k1+1       l htr a20a-4
       STA 16K+1      STORE IN ADR LOC 40000
       ECTM           SET CPY TRAP TRIGGER
       REM            
       REM            
       STR            
       rem
       SWT 2          ERROR
       HPR            TRAPPED TO LOC 40002
       REM            
*CHECK CONTENTS LOCATION 00000
       REM            
A20A   CLA            L CONTENTS LOCATION 00000
       LDQ K1         L STR A20A-2
       CAS K1         
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OK
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 0000 WRONG
       REM            
*CHECK CONTENTS LOCATION 40000
       REM            
       CLA 16K+1      L CONTENTS LOC 40000
       LDQ K1+1       L HTR A20A-4
       CAS K1+1       
       TRA *+2        ERROR
       CPY            CONTENTS LOCATION 40000 OK
       REM            turn off cpy trap tgr
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A20        REPEAT
       REM            
       REM            
       REM            
*PREVIOUSLY, IT WAS SHOWN turning off I/O TRAP tgr or cpy trap tgr
*turned off nullify tgr. now check turning off the first 2 mentioned
*triggers by each other.
       REM            
A21    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       ESTM           turn on I/O TRAP TRG
       ECTM           turn on CPY TRAP TRG
       rem
       rem
       WDR 1          turn i/o trap and
       rem            cpy trap tgrs off
       REM            
       REM            
       SWT 2          ERROR
       HPR            FAILED TO TRAP
       REM            
       REM            
       CPY            HAS CPY TRAP TRGR
       REM            BEEN turned off
       iot            yes and lite
       TRA *+3        should be on
       NOP            
       SWT 2          ERROR
       HPR            CPY TRAP TGR not turned off
       REM            SEE COMMENTs of routine
       REM            
       REM            
*CHECK CPY TRAP TGR turned off ALSO turns off I/O TRAP TGR
       REM            
       ESTM           turn on i/o trap tgr
       ECTM           turn on cpy trap tgr
       CPY            
       rem
       SWT 2          ERROR
       HPR            FAILED TO TRAP
       REM            
       REM            
       REM            
A21X   RDR 1          HAS I/O SENSE TRAP
       REM            TGR BEEN turned off
       iot            yes and lite
       TRA *+3        should be on
       rem            
       SWT 2          ERROR
       HPR            i/o trap tgr not turned off
       REM            see comments of routine
       REM            
       REM            
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A21        REPEAT
       REM            
       REM            
*check select crt instruction
       rem
a21a   axt *,1        location to xra
       tra monit      program monitor
       estm           turn on i/o trap tgr
       rem
       rem
       wtv            trap and turn off
       rem            i/o trap trigger
       rem
       swt 2          error
       hpr            failed to trap
       rem
       rem
       wtv            was i/o trap tgr turned off
       iot            yes and lite
       tra *+3        should be on
       rem
       swt 2          error
       hpr            check i/o trap tgr
       rem            not turned off
       rem
       swt 1          test switch 1
       tra *+2        continue
       tra a21a       repeat
       rem
       rem
*CHECK FLOATING POINT 704 MODE-NO FP TRAP,ACCUMULATOR AND MQ INDICATOR
*OPERATIVE AND TQO IS EXECUTED
       REM            
A22    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+14       L TRA A22A
       STO 8          STORE IN LOCATION 00010
       cla *-1        save address for next
       sta cor        routine initialization
       REM            
       REM            
       LFTM           turn off fp tmode TGR
       rem
       rem
       TQO *+1        MQ INDICATOR OFF
       CLS NUM+7      l -001007777777
       REM            
*BEFORE PROCEEDING, CHECK CHS +0760---02 HAS NO EFFECT ON F.P. TRAP
*TRGR                 
       REM            
       CHS            
       REM            
       REM            
       FAD NUM+8      l +004004444444
       REM            
*CHECK ACCUMULATOR INDICATOR
       REM            
       TOV *+3        OK-ACC IND WAS TURNED ON
       REM            TURN OFF AND TRANSFER
       rem
       SWT 2          ERROR
       HPR            ACC INDICATOR OFF
       REM            
       TQO *+3        should transfer
       REM  
       SWT 2          ERROR
       HPR            mq should be plus
       REM            
       REM            
       REM            
       tqo *+3        tqo should execute-mq ind
       rem            was turned on-turn off
       rem            and transfer
       rem
       swt 2          error
       hpr            mq ovflo ind off
       rem
       tqo *+2        should not transfer
       rem
       tra *+5        ok no tqo tra
       swt 2          error
       htr *+3        tqo transfer
       rem
a22a   swt 2          error
       hpr            trapped to loc 00010
       rem
       REM            
*CHECK CONTENTS LOCATION 00000
       REM            
       CLA            L CONTENTS LOCATION 00000
       LDQ num2+7     L STR 177777
       CAS num2+7     compare
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 000000 OK
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 000000 WRONG
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A22        REPEAT
       REM            
       REM            
*TEST FLOATING POINT 709 MODE WITH TRAP AND ACCUMULATOR INDICATOR OFF
       REM            
A24    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+16       L TRA A24A
       STO 8          STORE IN LOCATION 00010
       cla *-1        save address for next
       sta cor        routine initialization
       REM            
       REM            
       EFTM           turn on fp tmode tgr
       REM            
*BEFORE PROCEEDING CHECK ENK +0760---04 DOES NOT turn off FP tmode tgr
       REM            
       ENK            TRGR REMAIN RESET
       rem
       CLM            CLEAR ACCUMULATOR
       LDQ NUM+5      l -032404040404
       LLS 35         NO ACC OVERFLOW
       FDP NUM+6      l +344440404040
       rem
       SWT 2          ERROR
       HPR            FAILED TO TRAP-see comment
       REM            
       REM            
*CHECK ACCUMULATOR INDICATOR OFF
       REM            
A24A   TNO *+3        OK-ACC IND OFF
       rem
       SWT 2          ERROR
       HPR            ACC IND ON-note above
       rem            comment
       REM            
*CHECK CONTENTS LOCATION 00000
       REM            
       CLA            L CONTENTS LOCATION 00000
       LDQ K+17       L FP LOC +1 IN ADR AND
       REM            BITS IN DECREMENT POSITIONS
       REM            14,16,17 WITH OP CODE -1
       CAS K+17       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OF
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 00000 WRONG
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A24        REPEAT
       REM            
       REM            
*CHECK EXECUTION TQO AND OPERATION MQ INDICATOR IN 709 MODE
       REM            
A26    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       cla k+28       l tra a26a
       sto 8          store in location 00010
       cla *-1        save address for next
       sta cor        routine initialization
       LFTM           turn off fp tmode tgr
       TQO *+1        MQ INDICATOR OFF
       CLA NUM+4      l -000100000000
       rem
*execute a floating point instruction to turn on mq ovflo indicator
       rem
       ufa NUM+4      l -000100000000
       EFTM           turn on fp tmode tgr
       rem
       rem
       nop            turn off mq ovflo tgr
       rem
*check fp trap mode resets mq overflow indicator
       rem
       LFTM           turn off fp tmode tgr
       TQO *+2        indicator should be off
       tra *+6        ok, indicator off
       rem
       SWT 2          ERROR
       HPR            mq indicator on
       tra *+3  
       REM            
a26a   swt 2          error
       hpr            check fp tmode tgr on
       rem
       swt 1          test switch 1
       tra *+2        continue
       tra a26        repeat
       rem
       rem
       zet pass+1     load and/or reset button
       rem            tests on each initial pass
       tra m05        skip reset and load
       rem            button tests
       swt 3          is printer on line
       tra *+4
       rewa 1         rewind tape
       tra a28x       test load button only
       rem
       tra a26        dummy inst for monitor
       rem
       REM            
*CHECK RESET BUTTON RESTORES MACHINE TO 709 MODE
       REM            
A27    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA K+18       L TRA AS27A
       STO            STORE IN LOCATION 00000
       cla  num1+3      fix
       sto re+12      print 
       ars 8          image
       ors re+16      locations
       REM            
       REM            
       ESNT *+1       turn on nullify tgr
       ESTM           turn on i/o trap tgr
       ECTM           turn on cpy trap tgr
       LFTM           turn off fp tmode tgr
       rem
*turn on mq overflow indicator
       rem
       cla num+4      l -000100000000
       ufa num+4      mq ovflo ind on
       stz 15         clear location 00017
       cla *-1        save address for next
       sto cor        routine initialization
       HPR            
       REM            
****************************************************************************
*                                                                          *
*      push reset button to reset program counter to 00000                 *
*                and then push start button                                *
*                                                                          *
****************************************************************************
       rem
*check i/o trap trigger was turned off
       REM            
A27A   WPRA           SELECT PRINTER
       TRA *+4        OK-PROCEED
       NOP            
       rem
       SWT 2          ERROR
       HPR            CHECK I/O trap tgr off
       REM            
       SPRA 3         
       TRA *+4        OK-PROCEED
       NOP            
       rem
       SWT 2          ERROR
       HPR 
       REM            
fxm20  RCHA  **     load form loc 20017 or 40017.
       rem          print a line
       REM            
       REM            
*CHECK CPY TRAP TRIGGER was turned off 
       REM            
       CPY            SHOULD NOT TRAP
       TRA *+4        OK-PROCEED
       NOP            
       rem
       SWT 2          ERROR
       HPR
       REM            
*CHECK LOCATION 40000 
       REM            
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 40000 OK
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       REM            
*CHECK FP TMODE TRIGGER turned on
       REM            
       CLA K+19       L TRA A27B
       STO 8          STORE IN LOCATION 00010
       cla *-1        save address for next
       sta cor+1      routine initialization
       CLA NUM+7      l +00100777777
       FAD NUM+8      l +00400444444
       rem
       SWT 2          ERROR
       HPR            check input e to logic
       rem            block 38 systems 2.10.71.1
       REM            
A27B   CLA            L CONTENTS LOCATION 00000
       LDQ K+20       L FP LOC + 1 WITH BITS IN
       REM            DEC POSITIONS 16,17 AND
       REM            OP CODE 0000
       CAS K+20       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OK
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 00000 WRONG
       rem
       tcoa *         wait if channel in use
       cla num+3      fix
       ars 1          the
       sto re+16      print
       ars 3          image
       ors re+12      location
       iot            turn off
       nop            iop light
       rem
*check next sequence of instruction which have been known to fail
       rem
a27c   wpra           print
fxm21  rcha **      load from loc 20017 or 40017.
       estm           i/o trap tgr on
       pse 241        trap on i/o
       rem
       swt 2          error
       hpr            no i/o trap
       rem
       iot            check iot light
       tra *+2        error
       tra *+3        ok, iot light off
       rem
       swt 2          error
       hpr            iot light on
       rem
       cla 16k+1      l contents location 40000
       ldq num2+9     l htr a27c+4
       cas num2+9     compare
       tra *+2        error
       tra *+3        location is ok
       rem
       SWT 1          TEST SWITCH 1
       TRA A28        CONTINUE
       TRA A27        REPEAT
       REM            
       TRA A26        DUMMY INSTR FOR MONITOR
       REM            
A28X   AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       LXA *+3,1      L XRA WITH ADR OF INSTR
       SXD HOLD,1     PUT IN DEC OF LOC
       TRA A28        PROCEED
       REM            
       TRA A27        DUMMY INSTR FOR MONITOR
       REM            
       REM            
*CHECK LOAD TAPE BUTTON RESTORES MACHINE TO 709 MODE
       REM            
A28    AXT *,1        LOCATION TO XRA
       TRA MONIT      PROGRAM MONITOR
       CLA A27A+2     L NOP
       STO 3          STORE IN LOCATION 00003
       CLA K+21       L TRA A28A
       STO 4          STORE IN LOCATION 00004
       REM            
*WRITE 3 WORDS ON TAPE 
       REM            
       WTBA 1         SELECT TAPE CHAN A
       RCHA K+22      
       BSRA 1         BACKSPACE TAPE
       TCOA *         
       REM            
       ESNT *+1       turn on nullify tgr
       ESTM           turn on i/o trap tgr
       ECTM           turn on cpy trap tgr
       LFTM           turn off fp tmode tgr
       HPR            
       REM            
*when load tape button is pushed, read 3 words from tape into the 3 
*initial locations of storage.the 1st 5 storage locations should contain
       REM            
****************************************************************************
*                                                                          *
*                            00000     HTR                                 *
*                            00001     RTBA 1                              *
*                            00002     TRA A28B                            *
*                            00003     NOP                                 *
*                            00004     TRA A28A                            *
*                                                                          *
****************************************************************************
       REM            
A28A   SWT 2          ERROR
       HPR            
       REM            
*CHECK NULLIFY TRIGGER turned off
       REM            
A28B   TSX  **,2    tra to loc 20016 or 40016.
       TRA *+3        TRANSFERED OK
       rem
       SWT 2          ERROR
       HPR            ISNULLIFY TRGR RESET
       REM            
*CHECK CPY trap TRIGGER turned off
       REM            
       CPY            
       TRA *+4        OK-PROCEED
       NOP            
       rem
       SWT 2          ERROR
       HPR            IS CPY TRAP TRGR RESET
       REM            
*CHECK LOCATION 40000 
       REM            
       CLA 16K+1      L LOCATION 40000
       LDQ NUM        L +0
       CAS NUM        
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 40000 OK
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 40000 WRONG
       REM            
*CHECK FP Tmode TRIGGER turned on
       REM            
       CLA K+26       L TRA A28C
       STO 8          STORE IN LOCATION 00010
       CLA NUM+7      l +00100777777
       FAD NUM+8      l +00400444444
       rem
       SWT 2          ERROR
       HPR 
       REM            
A28C   CLA            L CONTENTS LOC 00000
       LDQ K+27       L FP LOC+1 WITH BITS IN
       REM            DEC POSITIONS 16,17 AND
       REM            OP CODE 0000
       CAS K+27       
       TRA *+2        ERROR
       TRA *+3        CONTENTS LOC 00000 OK
       rem
       SWT 2          ERROR
       HPR            CONTENTS LOC 00000 WRONG
       rem
       SWT 1          TEST SWITCH 1
       TRA *+2        CONTINUE
       TRA A28        REPEAT
       REM            
*adjust program to prevent performing reset and load button
*routines after 1 pass thru
       rem
       rew 1          rewind tape
       cla a27-6      bypass reset and
       sto a27-5      load button routines
       rem
*modify and alter instructions prior to executing 9m05 with i/o trap
*cpy trap and storage nullify triggers on
       rem
m05    axt error-4-e5-1,1 fill
       cla 3151
       sto error-4,1
       tix *-1,1,1
       rem
       axt 16k-total,1    these
       sto 16384,1  
       tix *-1,1,1        locations
       rem
       axt ay-konst-3,1   with 9m05
       sto ay,1
       tix *-1,1,1
       rem
       axt 16178,1  tsx space,4
       sto 22,1
       tix *-1,1,1
       rem
       axt 6,1        l 6 in xra
       cla trap+8,1   trap routine
       sto 16k+8,1    to locations
       tix *-2,1,1    40001-40006
       rem
       cla 33         tra 00030 to
       sto 22         location 00026
       rem
       cla num2+8     9m05 ttr seq to
       sto 8          location 00010
       rem
       iot            turn off
       nop            light if on
       rem
       slf            sense lights off
       rem
       axt *+6,1      set return
       sxa 2644,1     from 9m05
       rem
       eftm           turn
       estm           on
       ectm           triggers
       esnt 24        start executing 9m05
       rem
more   runa 2         reset triggers
       rem
       swt 2          error
       hpr            no rewind-unload wanted
       rem
*check pass counter and sense switches 3 and 6 after each program pass
       rem
count  cla pass+1     add one to total pass
       add num+1      counter for each pass
       sto pass+1     and save count
       cla pass+2     increment this
       add num+1      counter on
       sto pass+2     every pass
       rem
       swt 6          test sense switch 6
       tra atsal      total the passes executed
       rem            and load next diagnostic
       lxa pass,1     add one to 100
       tix *+1,1,1    decimal pass counter
       sxa pass,1     and save counter
       txh *+2,1,99   repeat diagnostic
       tra ss5        100 decimal times
       rem            if sense switch 5 up
       stz pass       clear 100 pass counter
       rem
*test sense switch 3 to print total passes every 100 passes
       rem
       swt 3          test sense switch 3
       tra *+2        go to print total passes
       tra ss5
       rem
*translate total pass count to bcd for printing
       rem
       cla pass+1      total  passes
       tsx bten,4      translate to bcd
       nop
       stq *+9         insert bcd word inimage
       tsx splt1+6,4   to bcd print routine
       mtw 11,0,3      splat control word
       rem
ovre   bcd 6100 passes complete xcomc with
       bcd 5      total passes completed
       rem
*check sense switch 5 to determine test of alternate storage division
       rem
*if alternating testing 2 nullify storage divisions, sense switch 5 down
       rem
ss5    swt 5            test sense switch 5
       tra stg          switch up-repeat
       rem
*with sense switch 5 down, print total passes completed on storage
*division testing and alter program form alternate storage divsion
       rem
       swt 3            test sense switch 3
       tra *+2          print passes made
       tra go+2         to routines to alter locs
       cla pass+1       l passes made
       tsx bten,4       translate to bcd
       nop
       stq *+8          put bcd word in image
       tsx splt1+6,4    to bcd print routine
       mtw 10,0,6       splate control word
       rem
out    bcd 5xcomc test complete with
       bcd 5       total passes completed
       rem
       tra go+2          to routines to alter locs
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
*with sense switch 3 up, total the passes completed before loading next
*diagnostic
       rem
atsal  rewa 2         compatability thru
       rem            rewind tape drive
       swt 3          test sense switch 3
       tra *+2        print and load
       tra crsl       just load
       cla pass+2     l total passes
       tsx bten,4     translate to bcd
       nop
       stq *+3        put bcd word in image
       tsx splt1+6,4  to bcd print completed.
       mtw 11,0,3
       rem
       bcd 5       total passes completed.
       bcd 6xcomc finished, load next diagnostic
       rem
CRSL   RCDA           LOAD
       RCHA CWD+5     THE
       LCHA 0         NEXT
       TRA 1          PROGRAM
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
*PROGRAM MONITOR      
       REM            
monit  SWT 1          TEST SWITCH 1
       tra *+4        routine not locked in
       rem
       pxd 0,1        xra to dec of acc
       sub hold       start adr test loc
       tze reset      program sequence ok
       rem
*check program sequence if routine is not locked in
       rem
       pxa 0,1        xra to acc adr
       sub num+1      l +1
       sta *+3        put this adr below
       stz hold+1     clear location
       sxd hold+1,1   xra to dec of word
       cla            l loc-1 test entered
       als 18         adr to dec of acc
       sub hold       initial adr previous test
       tze reli       sequence ok, check sw 4
       rem
       rem
       rem
*if program sequence wrong, check for tra instruction in keys
       rem
       enk            keys to mq
       xca            mq to acc
       pax 0,1        acc adr to xra
       ars 18         shift to acc adr
       sub num+3      l +000000002000
       tnz *+5        should be zero
       pxd 0,1        xra to dec of acc
       sub hold+1     saved adr
       lxd hold+1,1   restore xra
       tze reli       sequence ok, check sw 4
       rem
       lxd hold+1,1   restore xra
       pxd 0,1        xra to dec of acc
       tra space+9    indicate sequence error
       rem
       rem
       rem
       rem
       rem
       rem
       rem
*test sense switch 4 for repeating routine 50 octal times
       rem
reli   SWT 4          TEST sense SWITCH 4
       tra reset      sense switch 4 up
       rem
       cla times      l routine counter
       sub num+1      l +1
       sto times      save routine counter.
       tnz *+4        repeat routine again
       cla times+1    routine repeated 50 octal
       sto times      times, reset counter
       tra reset      and proceed
       rem
*check program excuting routine a6x or a8 and sense switch 4 down
       rem
       cla k1+5       l htr 0,0,a6x
       sub hold       is program in routine a6x
       tnz *+3        no
       slf            yes, turn off sense lite 4
       tra *+5
       rem
       cla k1+4       l htr 0,0,a8
       sub hold       is program in routine a8
       tnz *+2        no
       sln 4          yes, turn on sense lite 4
       rem
       lxd hold,1     correct value in xra
       rem            to repeat
       rem
       rem
       rem
RESET  SXD HOLD,1     SAVE XRA IN DEC OF WORD
       slt 4          test sense lite 4
       TXI *+3,1,2    lite off,add 2 to xra
       tix *+1,1,3    lite on,add 3 to xra
       sln 4          turn sense lite 4 on
       SXA BACK,1     PUT XRA IN ADR OF BACK
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
*check if routine will select tape
       rem
       slt 4          is sense lite 4 on
       tra *+10       no
       cla pass+2     yes,l counter
       tnz *+3        rewind tape
       rewa 2         if first
       tra *+3        pass or
       etta           at end
       tra *-3        of tape
       rem
*write a record on tape to prevent virgin tape run-a-way
       rem
       wtba 2         write a one
       rcha w0        word record and
       bsra 2         backspace record
       rem
*                            reset and initialize
       rem
       LSNM           IF SET. RESET THE
       REM            NULLIFY TRGR TO
       STZ 16K+1      CLEAR LOCATION 40000
       cla num2+7     l str 17777
       STO            STORE IN LOC 00000
cor    sto            and in these
       sto            locations
       cla k          l tra space
       sto 2          put in location 00002
       TOV *+1        ACC INDICATOR OFF
       DCT            DIV CHECK IND OFF
       NOP            
       IOT            IOT LIGHT OFF
       NOP            
       TRCA *+1       REDUNDANCY LITE OFF
       tefa *+1       turn off if on
       pxd            clear accumulator
       lrs 35         and mq
       sta cor        clear
       sta cor+1      addresses
       axt 0,7        clear all index registers
back   tra
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
*program out-of-control routine
       rem
SPACE  lsnm           just in case 
       CLA 16K+7      L CONTENTS LOC 40006
       SUB K1+8       L TTR 24
       TNZ *+3        
       CLA NUM+2      L +2
       TRA *+3        
       CAL            L CONTENTS LOCATION 00000
       SUB NUM+1      L +1
       ALS 18         SHIFT TO DEC OF ACC
       STZ HOLD+2     CLEAR LOCATION
       STD HOLD+2     SAVE IN DEC OF WORD
       LXD HOLD,1     DEC OF WORD TO XRA
       SXA HOLD+2,1   SAVE IN ADR OF WORD
       SXA RECT-1,1   XRA TO ADR OF INSTR
       SXA RECT+5,1   
       CLA HOLD+2     
       LDQ NUM        CLEAR MQ
       HPR            TRANSFER OUT OF CONTROL
       REM            
*ADR FROM WHICH CONTROL WAS RECOVERED IS IN DECREMENT AND STARTING
*ADDRESS OF TEST WHICH WAS UNDERWAY IS IN ADR OF ACCUMULATOR
       REM            
*00002 IN THE DECREMENT INDICATORS THE PROGRAM TRAPPED TO LOCATION
*40001 FOR A SENSE OR SELECT INSTRUCTION OR 40002 FOR A COPY
*INSTRUCTION BUT FAILED TO STORE THE LOCATION OF A TRAP INSTRUCTION
*PLUS 1 IN THE ADDRESS PORTION OF 40000.
       REM            
       REM            
       REM            
       REM            
       pxd 0,1        loc of test underway
       rem            to accumulator
       SUB K1+12      L HTR 0.0.AZ
       TZE Ay         IF IN INITIAL PROGRAM
       REM            routine, RETURN TO IT
       CLA            L LOC OF TEST UNDERWAY
RECT   SUB NUM+1      L 1 OR 2
       STA *+1        
       CLA            
       ALS 18         SHIFT TO DECREMENT
       STD HOLD       
       TRA            RETURN TO TEST THAT 
       REM            WAS UNDERWAY
       REM            
*INSTRUCTIONS FOR LOWEST LOCATIONS IN UPPER division OF STORAGE
       REM            
TRAP   tra ay3    
       rem
*halt at 1st location in upper half of storage may indicate no i/o or
*cpy trap when a select or cpy is at last lower half storage location
       rem
       htr
       TTR trloc    TRA LOC 40021
       TTR trloc      
       CLA 16K+1      L CONTENTS LOC 40000
       ADD NUM+2      L +2
       STA 16K+7      ADR TO LOC 40006
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
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
       REM            
*in order to load this or any other program and store instructions at
*correct locations the i/o trap trigger and the memory nullification
*trigger must be off
       rem
go     emtm         enter multiple mode
       nop
       cla num2+2   l tra ay2
       sto 32k        store in loc 77777
       rem
*check for 16/16 or 8/24 nullify divided storage
       rem
       hpr
****************************************************************************
*                                                                          *
*                         perform next 4 steps here                        *
*                                                                          *
*  On initial pass only, sign key -- up for tape loading                   *
*                                 -- down for card loading                 *
*                                                                          *
*  set switch for 16/16 or 8/24 nullify storage                            *
*                                                                          *
*  set key 34 down to test bttx and ettx                                   *
*  set key 34 up to bypass bttx and ettx test                              *
*                                                                          *
*  if a 16/16 nullify divided storage, key 35 up                           *
*  if a 8/24 nullify divided storage, key 35 down                          *
*                                                                          *
*  if sense switch 5 i sdown, put it up before pushing start button        *
*                                                                          *
****************************************************************************
       stz pass       clear these
       stz pass+1     locations
       rem
       enk            keys to mq
       xca            mq to axx
       pai            acc to ind
       zet pass+2     has pass been made
       tra *+7        yes
       rem
*check if next diagnostic will be loaded from tape
       rem
       tmi *+6        no, check if tape load
       rem
*adjust necessary instructions if this diagnostic is loaded from tape
*in order to bypass the load tape routine
       rem
       cla num2+3     alter
       sto crsl       necessary
       cla num2+4     instructions
       sto a27-3      for tape
       sta a28x-3     load
       rem
       rnt 1          is key 35 down
       tra go1        no
       rem
*adjust program location for an 8/24 nullify divided storage
       rem
       cla num1+1     adjust all
       sto go2+2    print images
       cla num1+9     for 8/24 nullify
       sto over+5     storage
       sto out+4      division 
       tra *+6
       rem
       rem
*adjust program locations for a 16/16 nullify divided storage
       rem
go1    cla num1+7     adjust all
       sto go2+2    print images
       cla num1+8     for 16/16 nullify
       sto over+5     storage
       sto out+4      division
       rem
go1a   rnt 2        is key 34 down
       tra *+5      no
       rem
       cla a10b        get a nop
       sto a10a+2      store in
       sto a10c+2      transfer
       sto a10e+2      locations
       rem
       rem
       rem
       rem
       rem
       rem
       rem
*with sense switch 3 up, identify program
       rem
       tsx splt1+3,4  to bcd print routine
       mtw 112,0,1    splat control word
       rem
       bcd 6performing xcomc 704/7090/7094 compa
go2    bcd 6tability on      nullify storage
       rem
       rem
       rem
       rem
       rem
       rem
       rem
*adjust program as per storage division
       rem
       lxa go2+2,1    8/24k,xra 20460
       txl stg16,1,4528  16/16k, xra 10660
       rem
       rem
       rem
*  set   program for correct values for an  8/24k storage.
       rem
       axt  9,4
       sxa  stg,4
       rem
       axt  8k-total-1,4
       sxa  stg+4,4
       rem
       zet  nul8   has a pass been made in the
       rem           8/24k nullify storage mode.
       tra *+4      yes- omit reset, load tests.
       rem
       cla  num1+19
       sto  a27-5
       sto  nul8
       rem
       rem
       axt  8k-1,4
       tra  both
       rem 
       rem
       rem
       rem
*  set   program for correct values for an 16/16k storage.
       rem
stg16  axt  17,4
       sxa  stg,4
       rem
       axt  16k-total-1,4
       sxa  stg+4,4
       rem
       zet  nul16  has a pass been made in the
       rem           16/16k nullify storage mode.
       tra *+4      yes- omit reset, load tests.
       rem
       cla  num1+19
       sto  a27-5
       sto  nul16
       rem
       rem
       axt  16k-1,4
       rem 
       rem
*  xrc  contains either 17776 or 37776.
       rem
both   sxd  nmbr,4
       rem
       txi *+1,4,1    xrc cont-  17777 or 37777.
       sxa 3259,4
       sxa stg+6,4
       sxd fxm08,4
       sxa fxm15,4
       sxa fxm16,4
       sxa fxm18,4
       sxa fxm19,4
       rem
       txi *+1,4,1    xrc cont-  20000 or 40000.
       sxa num1+16,4
       sxa fxm07,4
       rem
       txi *+1,4,7    xrc cont-  20007 or 40007.
       sxa fxm01,4
       rem
       txi *+1,4,2    xrc cont-  20011 or 40011.
       sxa fxm02,4
       rem
       txi *+1,4,1    xrc cont-  20012 or 40012.
       sxa fxm03,4
       rem
       txi *+1,4,1    xrc cont-  20013 or 40013.
       sxa fxm04,4
       rem
       txi *+1,4,1    xrc cont-  20014 or 40014.
       sxa fxm05,4
       rem
       txi *+1,4,1    xrc cont-  20015 or 40015.
       sxa fxm06,4
       rem
       txi *+1,4,1    xrc cont-  20016 or 40016.
       sxa fxm09,4
       sxa fxm10,4
       sxa a6xx,4
       sxa fxm11,4
       sxa fxm12,4
       sxa fxm13,4
       sxa fxm14,4
       sxa fxm17,4
       sxa a28b,4
       rem
       txi *+1,4,1    xrc cont-  20017 or 40017.
       sxa fxm20,4
       sxa fxm21,4
       rem
       txi *+1,4,1    xrc cont-  20020 or 40020.
       sxa stg+2,4
       rem
*insert instructions in locations as per nullify divided storage
       rem
*put group of instr in lower locations of upper division of storage
stg    axt 17,4      l 21 in xra
       cla trap+17,4 insert in locations
       sto 16k+17,4  store str instruction
       tix *-2,4,1   as per divided storaGE
       rem
*   for 16/16 nullify storage, fill locations 13171 thru 37776 with str.
*   for  8/24 nullify storage, fill locations 13171 thru 31776 with str.
       axt 16k-total-1,4 no of location to xrc
       cla num2+7        l str 17777
       sto 16k,4         store in location as 
       tix *-1,4,1       per nullify storage
       rem
*   in either mode, fill locations from symbolic location (uniq)
*      to location 77776 with str.
       rem
       axt  32k-uniq,4   no of loc to xrc.
       sto 32k,4         store str in locations
       tix *-1,4,1       as per nullify storage
       rem
       axt error-4-e5-1,4 store in locations
       sto error-4,4      between 9m05
       tix *-1,4,1        and 9depr
       rem
       axt ay-konst-3,4   fill locations
       sto ay,4           between 9depr
       tix *-1,4,1        and xcom
       rem 
*fill locations 20000-20006 and 20020-37777 with str
       axt 7,4          no of locations to xrc
       sto 8k+8,4       store str in locations
       tix *-1,4,1      20000-20006
       rem
       axt 16k-8k-17,4  no of locations to xrc
       sto 16k,4        store str in locations
       tix *-1,4,1      20020-37776
       rem
       axt  9,4      no of locations to xrc.
       sto  16k+17,4  store str in locations
       tix  *-1,4,1     40007 to 40017.
       rem
*insert select, sense and cpy trap routine in locations 40000-40006
       axt 7,4        7 now in xrc
       cla trap+8,4   trap routine
       sto 16k+8,4    to locations
       tix *-2,4,1    40000-40006
       rem
       cla trap       l tra ay3
       sto 8k         in loc 17777
       rem
*insert error detecting instruction in location 37777
       rem
       cla num2+1     l tra ay1
uniq1  sto  16k       store in loc 37777
       tra *+3
       rem
*insert error detecting instruction in location 17777
       rem
       cla num2+1     l tra ay1
       sto 8k         store in loc 17777
       rem
stgb   cla num2+7     l str 17777
       axt 23,4       l 27 in xrc
       sto 23,4       fill locations
       tix *-1,4,1    00000-00026
       rem
       cla k          l tra space
       sto 2          store in location 00002
       rem
       slf            sense lights off
       tra ay         commence test
       rem
       rem
       rem
*print image for checking reset button in compatability test
       rem
re     oct 420004             9 l
       oct 142101000000       9 r
       oct                    8 l
       oct                    8 r
       oct 201                7 l
       oct 200000200000       7 r
       oct 200000             6 l
       oct 600000000          6 r
       oct 14002              5 l
       oct 24010400000        5 r
       oct 100020             4 l
       oct                    4 r
       oct 40000              3 l
       oct 10022000000        3 r
       oct 410                2 l
       oct 4000000            2 r
       oct 1100               1 l
       oct                    1 r
       oct 140030             0 l
       oct 10026000000        0 r
       oct 610002             11l
       oct 322300400000       11r
       oct 25105              12l
       oct 44411210000        12r
       rem
       rem
       rem indexable bcd print subroutine.
       rem
       rem
splat  tra splt1     check for sense printer
       sxa splat+61,1
       sxa splat+62,2
       sxa subet,4   save original xrc.
       nzt 1,4       if control word zero.
       rem
       tra 2,4       return
       rem
       cal 1,4       get non-zero word
       slw splat+85  save control word
       pdx 0,1       type wheel no.
       txl splat+65,1,0 if decr. zero, get
       rem           new control word
       rem
       sxd *+2,4     get exit address
       pac 0,2       by adding twos comp.
       txi *+1,2,0   of n to xrc.
       sxa splat+63,2 exit value.
       rem
       rem set bit index to starting wheel
       rem
       sxa *+3,1     for shifting
       rem
       axt 1,3       1 to xra and xrb
       cal splat+82  bit index to p
       lgr 0,1       shift to starting point
       tnz *+3       if acc is zero, set for
       stq splat+83  right row, and make
       rem
       txi *+2,2,1   xrb a duece
       slw splat+83  otherwise, left row.
       axt 26,1 
       stz ci+26,1   clear card image
       tix *-1,1,1
       rem
       rem
       rem form card image.
       rem
       tix *+1,4,1   address of first word.
       axt 6,1       character count.
       ldq 1,4       get the word.
       rem
       sxa splat+54,1 save character count.
       pxd           clear acc.
       rem
       lgl 2         zone
       als 1         times 2
       pax 0,1
       sxa splat+45,1 for future reference.
       clm
       rem
       lgl 4         digit
       als 1         times 2
       slw ci        tempo
       cal splat+83  bit index
       nzt ci        is digit zero.
       rem
       txh splat+80,1,0 is zone zero too.
       lxa ci,1      ok proceed
       txh splat+48,1,24 check for illegal
       txh splat+78,1,20 special character.
       ors* splat+92,2 xrb picks left or right.
       rem
       axt 0,1       zone again.
       txl *+2,1,0   nothing for zero zone
       ors* splat+90,2 place zone bit.
       rem
       rem column set.
       rem
       ars 1         set bit index to
       tnz *+4       next column, if any.
       rem
       txh splat+60,2,1 if bx zero,+xrb 1, stop
       rem
       cal splat+82  if not, set to right
       txi *+1,2,1   row and proceed.
       slw splat+83  bx ready for next column.
       axt 0,1       more characters.
       rem
       tix splat+28,1,1 next column
       lxa splat+85,1 more words maybe.
       tnx *+3,1,1  if not, stop.  
       sxa splat+85,1 yummy, go get em.
       txi splat+25
       rem
       rcha splat+84 let her rip
       axt 0,1
       axt 0,2
       axt 0,4
       tra 2,4       exit
       rem
       rem
       rem get new control word form somplace
       rem
       rem
       sxa splat+63,4 for exit
       lxa splat+61,1 resetore xra
       nzt* splat+85 if control word zero
       tra splat+61  return.
       cal splat+85  old control word
       rem
       stt *+1       bring out index
       sxd *+2,0     register, if one is taged.
       pac 0,4
       txi *+1,4,0   get effective address.
       cal 0,4       new control word.
       rem
       pdx 0,1       type wheel id.
       slw splat+85
       txi splat+14,4,1 proceed
       rem
       ors* splat+88,2 put eight in, take
       tix splat+44,1,16 16 out, - good business
       rem
       txl splat+47,1,4 if not blank, set zone.
       tra splat+48  blank
       rem
       mze           for bit index.
       htr           dynamic bit index.
       iocd ci+2,,24 buffer command
       rem
       htr           special salon for
       rem           the control word
       htr ci+5      
       htr ci+4      8row addresses
       htr ci+27,1 
       htr ci+26,1   zone row addresses
       rem
       htr ci+21,1
       htr ci+20,1   digit row addresses
       rem
ci     bss 26
subet  bss 1
       rem
splt1  swt 2         and switches
       tra *+2       check switch 3
       tra split     ignore error
       rem
       swt 3         test three
       tra *+2       up-print
       tra split     down-return
       rem
       cal 1,4       l control word
       wpra          select printer
       pbt           p bit in cntrl word
       tra splat+1   no
       spra 3        yes-take a cycle
       als 1         move 1 to left
       pbt           p bit
       tra splat+1   no
       wpra          yes-double
       spra 3        space
       tov splat+1
       rem
split  cla 1,4       control word
       sta *+2       store no. of words
       tix *+1,4,2   decrement xrc by 2
       tra 0,4
       rem
*fixed binary to fixed bcd. binary word in the acc on
*entry, bcd words in acc and mq on exit.
       rem leading blanks for leading zeros.
       rem blank for plus, - for minus.
*if the high order 6 characters are blanks, return is
*made to x+2, otherwise to x+1.
       rem xrc is stored at subet, which must
       rem be supplied by the program.
       rem
bten   sxa bten+23,1
       sxa bten+24,2
       sxa subet,4   save xrc
       slw free      drop sign
       clm
       sto free+3    save sign
       stz free+1
       stz free+2
       axt 2,2
       axt 36,1
       rem
       pxd           clear acc.
       ldq free
       nzt free      when zero-
       tra bten+26   finished.
       dvp bten+38   by 10 decimal.
       stq free
       als 36,1      shift to position.
       acl free+3,2  tack on low order-
       slw free+3,2  save parial result.
       tix bten+10,1,6 get next digit, or
       rem
       tix bten+9,2,1 second word.
       cal free+2    if xrb runs out before
       rem           quot. is zero, no
       rem           room for sign.
       ldq free+1    low order to mq.
       axt 0,1
       axt 0,2
       tra 1,4       exit-to x+1 for 2 words.
       rem
       cla free+3  bring in sign
       ora bten+36  blnak-minus
       tmi *+2     was word minus
       cal bten+37  no get blanks
       als 36,1    bumbsie daisy
       acl free+3,2  non-zero digits
       txl bten+22,2,1  out on high order
       xcl
       cal bten+37   high order blank.
       txi bten+23,4,-1 return to x+2
       oct -406060606040 blank minus.
       oct 606060606060  blank plus
       htr 10        divisor
       rem
free   bss 10
       REM            
*       CONSTANTS     
       REM
K      tra space
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
       ttr 2
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
       tra a26a
       tra a14-5
       htr a10b
       htr a10d
       htr a10f
       REM            
K1     STR A20A-2     
       HTR A20A-4     
       tra a6xx
       htr 0,0,ay
       htr 0,0,a8
       htr 0,0,a6x
       rem
NUM    OCT 0          
       OCT 1          
       OCT 2          
       OCT 2000       
       OCT 400100000000
       OCT 432404040404
       OCT 344440404040
       OCT 1007777777
       OCT 4004444444  
       rem
num1   htr az,0,a28b_1
       oct 601061020460
       OCT 777777707777
       oct 40000
       OCT 777777717777
       oct 17777
       oct 40007
       oct 010661010660
       oct 010661010642
       oct 601061020442
       oct 30000
       htr num1+3
       htr num1+4
       oct 20007
       oct 17000
       htr num1+16
       oct 40000
       htr  **
       htr  **
       swt 3
       htr num1+6
       htr num1+13
       rem
num2   htr a6+2
       tra ay1
       tra ay2
       rtba 1
       tra m05-2
       tra a15y
       tra a20y
       str 8191
       oct 2100006121
       htr a27c+4
minon  oct 40000000000
mqnin  oct 00040000000
hold   oct  +0
       oct
       oct
ladr   oct
nmbr   oct
pass   oct
       oct
       oct
nul16  oct
nul8   oct
tgr    oct
times  oct 50
       oct 50
       rem
wo     iocd az,0,1
total  ioct 0,0,3
       REM
4K     EQU 4095       
8K     EQU 8191       
16K    EQU 16383      
32K    EQU 32767      
       rem
       org 3259
       rem
*        check nullify trigger still on
       rem
       axt 16k,1     37777 or 17777 in xra
       txi *+1,1,1   xra should be zero
       pxa 0,1       xra to adr of acc
       tze *+2       was xra zero
       tsx nocom+2,4 no, indicate error
       rem
*      check cpy or select trigger still on
       rem
cktgr  cpy           is trigger still on
       nop
       tsx nocom,4   no, indicate error
       rem
       nzt tgr       is location clear
       tra *+5       yes
       stz tgr       no, clear location
       cla a19+3     l copy
       sto cktgr     and store
       tra *+4       proceed
       stl tgr       store location
       cla more      l runa 2
       sto cktgr     and store
       rem
       esnt *+1      turn on trigger
       estm          turn on trigger
       iot           is light on
       tsx nocom+2,4 yes, error
       rem
       pxd           clear accumulator
       eftm          fp trap tgr on
       tpl *+2       was sign changed
       tsx nocom+2,4 yes, indicate error
       rem
       ectm          turn on trigger
       tra 3244      proceed
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       bcd 1lv com
       rem
nocom  iot           turn off the
       nop           the light if on
       stz 3150      clear location
       pxd 0,4       get true
       pdc 0,4       failure
       sxd 3150,4    location
       lxd 3152,4    routine that
       cla -2,4      might
       sta 3150      have
       cla 3150      failed
       tsx error-1,4 to error
       nop nocom     routine
       rem
       rem
       rem
       rem
       rem
       rem
       rem
*decrement of accumulator contains true location of trigger tested
*and address of accumulator contains initial address of routine that
*might have caused failure. return is to routine that might have caused
*failure. if storage nullify trigger is failure, xra has error value.
       rem
       pac 0,4       set monitor
       eftm          and all
       estm          triggers
       ectm          and return
e5     esnt 3205     to 9m05
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       org 3392
       rem
*modified version of 9depr for use with 9m05 for reliability
       rem
       bss 2
       oct 1
       tra err
error  stz konst     do not repeat section
       stz konst+1   if sw 4 is down
       rem
       swt 2         if sense sw 2 is up, then
       tra ssw3      check ssw3
       tix ok,4,1
ok     sxd error-3,4 2-s compl of prograqm
       rem           location last performed
       swt 1         if sense sw 1 is up, then
       tra rely      check ss4
       tra 1,4       if down repeat section
       rem
ssw3   sxa error-4,4 save xrc to get
       lac error-4,4 true error location
       hpr           refer to location in xrc
       sxa error-4,4 restore
       lac error-4,4 original xrc
       tra ok-1      for return
       rem
rely   swt 4         if swt 4 is up, go to next
       tra 3,4       section of program. if it
       rem           is down, repeat section
       rem           50 octal times
       cla konst+1   counter
       sub konst     reduce count by 1
       sto konst+1
       tnz ok+3
       cla konst+2   restore
       sto konst+1   the
       cla error-2   counter
       sto konst     values
       tra 3,4       return
       rem
err    swt 2         if swt 2 is up, check
       tra ssw3a     sense switch 3
ok2    swt 1         ssw 1 up, go to next routine
       tra 2,4       exit
       tra 1,4       repeat
       rem
ssw3a  sxa error-4,4 save xrc to get
       lac error-4,4 true error location
       hpr           refer to location in xrc
       sxa error-4,4 restore
       lac error-4,4 original xrc
       tra ok2       for return
       rem
konst  oct 1
       oct 50
       oct 50
       rem
       org 16400
       rem
uxtrp  htr shave    to 9m05
trloc  cla 16384    get trap store loc
       cas uxtrp    compare to 9m05 addr.
       tra 16387    high
       tra 16387    equal
       cla abcdx    get sti instr.
       cas 0        compare to zero
       tra xyzab
       tra *+3      ok
       tra xyzab
       stz **       clear zero
       ectm 0       copy trap
       estm 0       select trap
       esnt 0       strg. null and transfer
       re
xyzab  cla 16384    get store trap loc.
       sta zebra    store into store instr.
       sta zebra-1   store in ind instr.
       sta abcdx
       cla abcdx    get sti instr.
       sto 0        store in zero
       rem
       cla xraya    get trap mode tra
       sto 1        store in loc 1
       cla exit     get 9m05 addr.
       sta xyzab-1   store in esnt addr.
       ldi **       load ind with store trap loc.
zebra  sto **       store 9m05 addr.
       tra *+2      skip
       rem
abcdx  sti **       store trap loc)
       ldq 16384    get loc 40000
       rql 18       rotate
       axt 6,4      set xrc
       als 3        set into bcd
       lgl 3
       tix *-2,4,1
       rem
       sto xrayb+6  store into print image
       tsx splat,4  to print rout.
       pze xrayb
       tsx splat,4  print
       pze xrayc
       tsx splay,4    error
       pze xrayd
       htr xyzab-3      routine
       rem
xraya  tra trloc+9
xrayb  pze 6,,1
       bcd 6illegal trap form 9m05 loc+1
xrayc  pze 9,,1
       bcd 6press start prog. will loop in area
       bcd 3causing failure.
xrayd  pze 9,,1
       bcd 6to restore prog. and continue push r
       bcd 3eset and start.
uniq   oct +0
shave  define 06300
exit   define 06264
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       rem
       end
       END            
