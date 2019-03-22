                                                             9M21A
                                                             12/1/58
       REM           
       REM           
       REM 9M21A     
       REM
*709 MAIN FRAME TEST CHECKING FIXED-POINT AND LOGICAL ARITHMETIC
*OPERATIONS, WORD TRANSMISSION OPERATIONS, SHIFT OPERATIONS,
*CONTROL OPERATIONS, LOGICAL OPERATIONS, SENSE INDICATOR OPERATIONS
*DISPLAY BUTTONS AND TIMING FOR MPY WITH ZERO MULTIPLICAND.
       REM           
       ORG 0         
       REM           
       TRA START-3   RESET-START
       REM           
*FALSE TRAP ROUTINE TO ADJUST DEPR AND RETURN TO PROGRAM
       REM           
       LTM           LEAVE TRAP MODE
       SLW TEMP+2    SAVE ACCUMULATOR
       CLA TR        PUT BIT IN DEPR TO
       STO LOC+3     SHOW TRAP TRGR ON
       CLA           L CONTENTS LOC 00000
       ADD           
       STA *+1       
       TRA           RETURN TO PROGRAM
       REM           
       ORG 24        
       REM           
       SWT 3         TEST SENSE SWITCH 3
       TRA ID        IDENTIFY PROGRAM
       REM           
*BASIC INDEXING TEST EXAMINING INDEXING INSTRUCTIONS USED IN 9M21
       REM           
       REM           
       REM TRANFER ON TXL. ADDR X CARRY AT ER6
       REM WITH XRA LOW OR EQUAL
       REM           
 SWING AXT 3C,1      3000 TO XRA
       TXL *+2,1,3M  SHOULD TRANFER, XRA
       REM           LOW. ADDER X CARRY AT
       REM           ER5. SYSTEMS 2.07.02
       REM           
       HTR *+1       FAILED TO TRANFER ON
       REM           LOW XRA#300. DEC #3000.
       REM           
       REM TRY TXL AGAIN TO SEE IF XRA STILL HAS
       REM 300       
       REM
       TXL *+2,1,3C  SHOULD TRANFER
       REM           
       HTR *+1       FAILED TO TRANSFER. XRA
       REM           SHOULD STILL HAVE 300.
       REM           XRA MAY HAVE CHANGED.
       REM           SYSTEMS 2.08.53.
       REM           
       REM           
       REM TXL WITH XRA LOW
 LOW   AXT 2C,1      200 TO XRA
       TXL *+2,1,3C  SHOULD TRANFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           ON XRA LOW
       REM           XRA#200, DEC#300
       REM           
       AXT 2C,1      200 TO XRA
       TXL *+2,1,2C+1 SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           ON XRA ONE LESS THAN DEC.
       REM           XRA#200, DEC#201
       REM           
       AXT 1,1       1 TO XRA
       TXL *+2,1,32K SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA LOW
       REM           XRA#1, DEC#77777
       REM           
       AXT 32K-1,1   77776 TO XRA
       TXL *+2,1,32K SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA ONE LESS THEN DEC.
       REM           XRA#7776, DEC#77777
       REM           
       AXT 0,1       CLEAR XRA
       TXL *+2,1,1   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA ZERO
       REM           XRA#0, DEC#1
       REM           
       AXT 0,1       CLEAR XRA
       TXL *+2,1,40M SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA ZERO
       REM           XRA#0, DEC#40000
       REM           
       AXT 0,1       CLEAR XRA
       TXL *+2,1,0   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON 
       REM           BOTH XRA AND DEC#0
       REM           
       AXT 2M+2C+2D+3,1 02223 TO XRA
       TXL *+2,1,70M+5M+5C+5D+5 SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           WITH TWOS COMP. OF
       REM           XRA EQAUL TO DEC.
       REM           XRA#2223, DEC#75555
       REM           COMP. OF XRA#75555
       REM
       REM
       REM TXL WITH ZERO TAG
       REM           
 SWEET AXT 32K,1     ALL 7-S TO XRA
       TXL *+2,0,1   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           WITH ZERO TAG
       REM           DEC#1
       REM           
       TXL *+2,0,32K SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           WITH ZERO TAG
       REM           DEC #77777
       REM           
       REM TXL WITH ZERO TAG AND DECREMENT
       REM
       TXL *+2       
       HTR *+1       FAILED TO TRANSFER
       TXL *+2       
       HTR *+1       FAILED TO TRANSFER
       TXL *+2       
       HTR *+1       FAILED TO TRANSFER
       TXL *+2       
       HTR *+1       FAILED TO TRANSFER
       TXL *+2       
       HTR *+1       FAILED TO TRANSFER
       TXL *+2       
       HTR *+1       FAILED TO TRANSFER
       TXL *+2       
       HTR *+1       FAILED TO TRANSFER
       TXL *+2       
       HTR *+1       FAILED TO TRANSFER
       TXL *+2       
       HTR *+1       FAILED TO TRANSFER
       REM           
       REM           
       REM           
       REM TRY TXH WITH XRA HIGH
       REM           
 CHAR  AXT 2C,1      200 TO XRA
       TXH *+2,1,C   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           ON XRA HIGH
       REM           XRA#200, DEC#100
       REM           NO ADDER X CARRY AT
       REM           ER6 SHOULD CAUSE
       REM           TRANSFER. SYSTEM 2.07.02
       REM           
       AXT 1,1       1 TO XRA
       TXH *+2,1,0   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA#1, DEC#0
       REM           
       AXT 5M+5C+5D+5,1 05555 TO XRA
       TXH *+2,1,2M+2C+2D+2 SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#05555, DEC#02222
       REM           
       AXT 70M+4M,1  74000 TO XRA
       TXH *+2,1,2M  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#74000, DEC#2000
       REM           
       AXT 70M+6M,1  76000 TO XRA
       TXH *+2,1,M   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#76000, DEC #1000
       REM           
       AXT 70M+7M,1  77000 TO XRA
       TXH *+2,1,4C  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#77000, DEC#400
       REM           
       AXT 70M+7M+4C,1 77400 TO XRA
       TXH *+2,1,2C  SHOULD TRANFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#77400, DEC#200
       REM           
       AXT 70M+7M+6C,1 77600 TO XRA
       TXH *+2,1,C   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#77600, DEC#100
       REM           
       AXT 70M+7M+7C,1 77700 TO XRA
       TXH *+2,1,4D  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#77700, DEC#40
       REM           
       AXT 70M+7M+7C+4D,1 77740 TO XRA
       TXH *+2,1,2D  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#77740, DEC#20
       REM           
       AXT 70M+7M+7C+6D,1 77760 TO XRA
       TXH *+2,1,D   SHOUDL TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#77760, DEC #10
       REM           
       AXT 32K-7,1   77770 TO XRA
       TXH *+2,1,4   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#77770, DEC#4
       REM           
       AXT 32K-3,1   77774 TO XRA
       TXH *+2,1,2   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#77774, DEC#2.
       REM           
       REM           
       REM THE PROGRAM WILL NOW ASSUME THAT
       REM TXL WILL TRANSFER ON ZERO TAG AND
       REM XRA LOW, AND THAT TXH WILL TRANSFER
       REM ON XRA HIGH. WE WILL USE THESE
       REM FACTS TO SEE THAT TXL WILL NOT
       REM TRANSFER ON XRA HIGH AND THAT TXH
       REM WILL NOT TRANSFER ON XRA LOW. IF
       REM THERE HAS BEEN AN ERROR IN THE
       REM PRECEEDING TEST, THEY SHOULD BE 
       REM INVESTIGATED BEFORE WE CONTINUE.
       REM           
       REM           
       REM           
       REM NO TRANSFER WITH TXL ON XRA HIGH.
       REM           
 IOT   AXT 2C,1      200 TO XRA
       TXL *+2,1,C   SHOULD NOT TRANSFER
       TXH *+2,1,C   THIS SHOULD TRANSFER
       REM           IF XRA STILL HAS 200.
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH
       REM           XRA#200, DEC#100
       REM THIS STOP COULD INDICATE THAT THE
       REM TXH AT LOC IOT+2 DID NOT TRANSFER
       REM SINCE WE ASSUME THAT TXH WOULD WORK
       REM WITH THIS COMBINATION OF NUMBER-SEE
       REM LOC CHAR+1-WE SAY ERROR WAS
       REM CAUSED BY TXL AT IOT+1
       REM           
       REM           
       REM           
       REM           
       REM           
       AXT 1,1       1 TO XRA
       TXL *+2,1,0   SHOULD NOT TRANSFER
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH
       REM           XRA#1, DEC#0
       REM           
       AXT A5,1      ALL 5-S TO XRA
       TXL *+2,1,2M+2C+2D+2 SHOULD NOT TRANSFER
       TXH *+2,1,2M+2C+2D+2 SHOULD TRANSFER
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH
       REM           XRA#55555, DEC#02222
       REM           
       AXT 70M+4M,1  74000 TO XRA
       TXL *+2,1,2M  SHOULD NOT TRANSFER
       TXH *+2,1,2M  SHOULD TRANSFER
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH
       REM           XRA #74000, DEC#2000
       REM           
       AXT 70M+6M,1  76000 TO XRA
       TXL *+2,1,M   SHOULD NOT TRANSFER
       TXH *+2,1,M   SHOULD TRANSFER
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH.
       REM           XRA#76000, DEC#1000
       REM
       AXT 70M+7M,1  77000 TO XRA
       TXL *+2,1,4C  SHOULD NOT TRANSFER
       TXH *+2,1,4C  SHOULD TRANSFER
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH.
       REM           XRA#77000, DEC#400
       REM           
       REM           
       REM NO TRANSFER WITH TXH ON XRA EQUAL
       REM           
 COMIN AXT 3C,1      300 TO XRA
       TXH *+2,1,3C  ADDER X CARRY AT ER6
       REM           SHOULD BLOCK TRANSFER
       TXL *+2       SHOULD TRANSFER
       HTR *+1       TXH TRANSFERED ON
       REM           XRA EQUAL
       REM           XRA#300, DEC#300
       REM           
       REM IF TXL WITH ZERO TAG AND DECREMENT
       REM WORKED PREVIOUSLY,WE ASSUME
       REM IT WILL WORK HERE.
       REM           
       REM           
       AXT 0,1       CLEAR XRA
       TXH *+2,1,0   SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER
       HTR *+1       TXH TRANSFERED WITH
       REM           XRA AND DEC BOTH ZERO.
       REM           
       AXT 32K,1     77777 TO XRA
       TXH *+2,1,32K SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER
       HTR *+1       TXH TRANSFERED ON
       REM           XRA EQUAL
       REM           XRA#777777, DEC#77777
       REM           
       AXT A2,1      22222 TO XRA
       TXH *+2,1,A2  SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER
       HTR *+1       TXH TRANSFER ON
       REM           XRA EQUAL
       REM           XRA#22222, DEC#22222
       REM           
       AXT A5,1      ALL 5-S TO XRA
       TXH *+2,1,A5  SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER
       HTR *+1       TXH TRANSFER ON
       REM           XRA EQUAL
       REM           XRA#55555, DEC#55555
       REM           
       REM           
       REM           
       REM NO TRANSFER ON TXH WITH XRA LOW
       REM           
 FORTO AXT 0,1       CLEAR XRA
       TXH *+2,1,1   SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER
       HTR *+1       TXH TRANSFER ON
       REM           XRA LOW
       REM           XRA#0, DEC#1
       REM           
       AXT 32K-1,1   77776 TO XRA
       TXH *+2,1,32K SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER
       HTR *+1       TXH TRANSFER ON
       REM           XRA LOW
       REM           XRA#77776, DEC#77777
       REM           
       AXT 2M+2C+2D+3,1 02223 IN XRA
       TXH *+2,1,5M+5C+5D+5 SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER
       HTR *+1       TXH TRANSFER ON
       REM           XRA LOW
       REM           XRA#02223, DEC#05555
       REM           
       AXT A2,1      22222 TO XRA
       TXH *+2,1,A2+1 SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER
       HTR *+1       TXH TRANSFER ON
       REM           XRA LOW
       REM           XRA#22222, DEC#22223
       REM           
       REM           
       REM CHECK THAT TXL AND TXH DOES NOT
       REM CHANGE XRA.
       REM           
 CARRY AXT 0,1       CLEAR XRA
       TXH *+3,1,3C  SHOULD NOT TRANSFER
       TXL *+3,1,0   SHOULD TRANSFER ONLY
       REM           IF XRA IS STILL ZERO.
       HTR *+2       NO TXL TRANSFER, XRA
       REM           SHOULD HAVE STILL BEEN
       REM           ZERO AT CARRY+2
       REM           
       HTR *+1       TXH TRANSFER ON
       REM           XRA#0, DEC#300
       REM           
       AXT A2,1      22222 TO XRA
       TXH *+5,1,A2  SHOULD NOT TRANSFER
       TXL *+3,1,0   SHOULD NOT TRANSFER
       TXL *+4,1,A2  SHOULD TRANSFER, XRA
       REM           SHOULD STILL HAVE 22222
       REM
       HTR *+3       FAILED TO TRANSFER FROM
       REM           LOCATION CARRY+8.XRA SHOULD
       REM           HAVE BEEN#22222
       REM           
       HTR *+2       SHOULD NOT TRANSFER 
       REM           FROM CARRY+7
       REM           XRA SHOULD HAVE HAD 22222
       REM           
       HTR *+1       TXH TRANSFER ON
       REM           XRA EQUAL,LOC CARRY+6
       REM           XRA#22222, DEC#22222
       REM           
       REM           
       AXT 3C,1      300 TO XRA.
       TXH *+2,1,3C-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON XRA HIGH
       REM           XRA#300, DEC#277
       REM           
       TXL *+2,1,3C  SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER, XRA
       REM           SHOULD HAVE STILL BEEN
       REM           300.
       TXL *+2,1,3C-1 SHOULD NOT TRANSFER
       TXL *+2       OK,
       HTR *+1       SHOULD NOT TRANSFER
       REM           FROM M-3
       REM           XRA#300, DEC#277
       REM           
 ME    AXT 3,1       3 TO XRA
       TXL *+2,1,4   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXL, XRA#3, DEC#4
       TXH *+2,1,2   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXH, DEC#2, XRA SHOULD
       REM           STILL HAVE 3.
       REM           
       TXL *+2,1,4   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER 
       REM           ON TXL, DEC#4, XRA
       REM           SHOULD STILL HAVE 3
       REM           
       AXT 3C,1      300 TO XRA
       TXL *+2,1,3C  SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           XRA#300, DEC#300
       TXH *+2,1,3C-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           DEC#2777, XRA SHOULD
       REM           STILL BE 300
       TXL *+2,1,3C-2 SHOULD NOT TRANSFER
       TXL *+2,1,3C  SHOULD TRANSFER
       HTR *+1       TXL FAILED, XRA BEING 
       REM           CHANGED, XRA SHOULD
       REM           STILL HAVE 300. XRA
       REM           SHOULD NOT CYCLE THROUGH
       REM           THE ADDERS.
       REM           
       REM           
       AXT 32K-1,1   77776 TO XRA
       TXL *+2,1,32K-2M-1 SHOULD NOT TRANSFER
       TXL *+2       OK
       REM           
       HTR *+1       TXL TRANSFER ON
       REM           XRA HIGH
       REM           XRA#77776, DEC #75776
       TXH *+2,1,4M  SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER,
       REM           XRA SHOULD BE HIGH
       REM           XRA#77776, DEC#4000
       TXH *+2,1,32K-2 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           XRA SHOULD STILL BE HIGH
       REM           XRA#77776, DEC#77775
       REM           
       REM           
       REM           
       REM           
       REM WE MAY NOW PROCEED TO TIX.
       REM IF THERE HAVE BEEN ANY ERRORS UP TO
       REM THIS POINT, THEY SHOULD BE
       REM INVESTIGATED BEFORE WE CONTINUE.
       REM           
       REM           
       REM TIX WITH XRA LOW
       REM           
 HADA  AXT 0,1       CLEAR XRA
       TIX *+2,1,1   SHOULD NOT TRANSFER
       TXL *+2       OK
       HTR *+1       TRANSFER ON TIX WITH
       REM           XRA LOW
       REM           XRA#0, DEC#1
       REM           
       TXL *+2,1,0   XRA SHOULD STILL BE
       REM           ZERO
       HTR *+1       XRA NOT ZERO
       REM           
       REM           
       AXT 32K-1,1   77776 TO XRA
       TIX *+2,1,32K SHOULD NOT TRANSFER
       TXL *+2       OK
       HTR *+1       TRANSFER ON TIX WITH 
       REM           XRA LOW
       REM           XRA#77776, DEC#77777
       TXL *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       XRA SHOULD HAVE BEEN 
       REM           EQUAL, DEC#77776
       TXH *+2,1,32K-2 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 77776
       REM           
       REM           
       REM           
       REM TIX WITH XRA EQUAL
       REM           
 LITIL AXT 1,1       1 TO XRA
       TIX *+2,1,1   SHOULD NOT TRANSFER
       TXL *+2       OK
       HTR *+1       TIX TRANSFER WITH
       REM           XRA EQUAL
       REM           XRA#1, DEC#1
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA SHOULD HAVE
       REM           BEEN EQUAL
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 1
       REM           
       REM           
       AXT 0,1       CLEAR XRA
       TIX *+2,1,0   SHOULD NOT TRANSFER
       TXL *+2       OK
       HTR *+1       TIX TRANSFER WITH
       REM           XRA#DEC#ZERO
       TXL *+2,1,0   XRA SHOULD BE ZERO
       HTR *+1       XRA NOT STILL ZERO
       REM           
       REM           
       AXT 2,1       2 TO XRA
       TIX *+2,1,2   SHOULD NOT TRANSFER
       TXL *+2       OK
       HTR *+1       TIX TRANSFER ON
       REM           XRA EQUAL
       REM           XRA#2, DEC#2
       TXL *+2,1,2   SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL 
       REM           HAVE BEEN 2
       TXH *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL 
       REM           HAVE BEEN 2
       REM           
       AXT 32K,1     77777 TO XRA
       TIX *+2,1,32K SHOULD NOT TRANSFER
       TXL *+2       OK
       HTR *+1       TIX TRANSFER ON
       REM           XRA EQUAL
       REM           XRA#77777, DEC#77777
       TXL *+2,1,32K SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL
       REM           HAVE BEEN 777777
       REM           DEC#77777
       TXH *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL
       REM           HAVE BEEN 77777
       REM           DEC#77776
       REM           
       REM           
       REM TEST XRA CYCLE THROUGH THE ADDERS
       REM WITH AXC. XRA TO ADDERS AT I3,
       REM SYSTEMS 2.08.49.2. RETURN TO XRA
       REM TO XRA AT I6, SYSTEM 2.08.53.1
       REM           
       AXC 70M+7M+5C,1 00300 TO XRA
       TXL *+2,1,3C  SHOULD TRANSFER
       HTR *+1       XRA FAILED TO GET 300
       REM           
       TXH *+2,1,3C-1 SHOULD TRANSFER
       HTR *+1       XRA FAILED TO GET 300
       REM           
       AXC 32K,1     00001 TO XRA
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA FAILED TO GET A ONE
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA FAILED TO GET A ONE
       REM           
       AXC 0,1       CLEAR XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA NOT ZERO
       REM           
       REM           
       REM TIX TRANSFER AND REDUCE XRA ON
       REM NO ADDER X CARRY. THE COMPLEMENT
       REM DIFFERENCE RETURSN TO XRA AT ER6,
       REM CYCLED THROUGH THE ADDERS AND RETURNS
       REM IN TRUE FORM AT ER11.
       REM SYSTEMS 2.08.53.1.
       REM           
       REM           
 WHOSE AXT 2,1       2 TO XRA
       TIX *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TIX.
       REM           XRA#2, DEC#1
       REM           
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO DECREMENT
       REM           ON TIX. XRA SHOULD#1
       REM           
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO DECREMENT
       REM           ON TIX, XRA SHOULD#1
       REM           
       REM           
       REM           
       AXT 32K,1     77777 TO XRA
       TIX *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TIX
       REM           XRA#77777, DEC#77776
       REM           
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO DECREMENT
       REM           ON TIX, XRA SHOULD#1
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       FIALED TO DECREMENT
       REM           ON TIX, XRA SHOULD#1
       REM           
       REM           
       REM COUNT-DOWN TEST WITH TIX
       REM           
 WAS   AXT 32K,1     77777 TO XRA
       TIX *+2,1,1   SHOULD TRANSFER
       HTR *+6       FAILED TO TRANSFER
       REM           ON TIX. XRA SHOULD
       REM           ALWAYS BE HIGH
       REM           
       TXH *-2,1,2   CONTINUE COUNT-DOWN
       REM           UNTIL XRA#2
       TXL *+2,1,2   XRA SHOULS NOW#2
       HTR *+3       FAILED, XRA SHOULD
       REM           COUNT DOWN TO 2 ON
       REM           TIX.
       REM           
       TXH *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED, XRA SHOULD
       REM           BE#2.
       REM           
       REM           
       REM TEXT TXI FOR UNCONDITIONAL TRANSFER
       REM AND INCREMENTING. XR CYCLES THROUGH
       REM ADDERS AT ER3 TO OBTAIN COMPLEMENT.
       REM ADDITION TAKE PLACE AT ER7. THE SUM
       REM IS SAMPLED BACK TO XR AT ER11.
       REM THE SYSTEMS ENVOLVED ARE
       REM XR TO ADD 3-17,  ER3D9 -     2.08.49
       REM ADD 3-17 TO XR  ER5D1   
       REM AND  ER11D1                  2.08.53
       REM SR 1-35 TO ADD  ER7D5        2.08.48
       REM           
       REM           
       REM           
 AS    AXT 0,1       CLEAR XRA
       TXI *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXI
       TXL *+2,1,1   XRA SHOULD#1
       HTR *+1       FAILED TO INCREMENT
       REM           WITH TXI,
       REM           XRA SHOULD#1
       REM           
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI.
       REM           XRA SHOULD#1
       REM           
       AXT 32K-1,1   77776 TO XRA
       TXI *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXI.
       REM           
       TXH *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI.
       REM           XRA SHOULD#77777
       REM           DEC#77776
       REM           
       AXT 1,1       1 TO XRA
       TXI *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXI
       REM           
       TXH *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI.
       REM           XRA#77777, DEC#77776
       REM           
       AXT 32K,1     777777 TO XRA
       TXI *+2,1,32K SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER 
       REM           ON TXI
       REM           
       TXH *+2,1,32K-2 SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI, XRA SHOULD
       REM           HAVE 77776, DEC#77775
       REM           
       TXL *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI, XRA SHOULD
       REM           HAVE 77776, DEC#77776.
       REM           
       AXT 1,1       1 TO XRA
       TXI *+2,1,32K SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM            ON TXI.
       REM           
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXL. XRA SHOULD
       REM           HAVE ZERO.
       REM           
       REM           
       REM COUNT-DOWN TEST WITH TXI, TIX
       REM           
 SNOW  AXT 32K,1     77777 TO XRA
       TIX *+3,1,2   COUNT DOWN 2
       REM           
       TXL *+3,1,2   XRA SHOULD BE 2
       HTR *+4       FAILED TO TRANSFER
       REM           ON TIX WITH XRA HIGH
       REM           
       TXI *-3,1,1   TRANSFER AND ADD 1
       REM           UNTIL XRA#2
       REM           
       TXH *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO COUNT
       REM           CORRECTLY, XRA SHOULD
       REM           HAVE 2
       REM           
       REM           
       REM TSX, THE INSTRUCTION COUNTER IS
       REM ROUTED THROUGH THE ADDRESS SWITCHES
       REM ON SYSTEMS 3.40, AND TO THE STORAGE
       REM BUSSES, SYSTEMS 2.08.28. THE ADDRESS
       REM IS CYCLED THROUGHT THE ADDERS TO
       REM OBTAIN THE COMPLEMENT
       REM           
       REM           
 HERE  TSX *+2,1     2-S COMPLEMENT OF THIS
       REM           LOCATION TO XRA
       HTR *+1       FAILED TO TRANSFER
       REM           ON TSX
       REM           
       TXL *+2,1,32K-HERE+1 SHOULD TRANSFER
       HTR *+1       FAILED TO SET CORRECT
       REM           ADDRESS IN XRA ON TSX
       REM           
       TXH *+2,1,32K-HERE SHOULD TRANSFER
       HTR *+1       FAILED TO SET
       REM           CORRECT ADDRESS WITH TSX
       REM           
 WE    TSX *+2,1     
       HTR *+1       FAILED TO TRANSFER
       REM           ON TSX
       REM           
       TXI *+2,1,WE  XRA SHOULD ADD
       REM           TO ZERO
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXI
       REM           
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO GET
       REM           CORRECT ADDRESS ON
       REM           TSX, XRA SHOULD
       REM           HAVE GONE TO ZERO
       REM           AT WE+2.
       REM           
       REM           
*CURSORY INDEX REGISTER SELECTION TEST FOR XRB AND XRC
       REM           
       AXT 32K,2     77777 TO XRB
       TXH *+2,2,32K-1 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRB#77777, DEC#77776
       REM           
       AXT 0,2       CLEAR XRB
       TXL *+2,2,0   SHOULD TRANSFER
       HTR *+1       ID NOT TRANSFER ON TXL
       REM           XRB#00000, DEC#00000
       REM           
 DEX   TSX *+1,2     2-S COMPLEMENT OF THIS
       REM           LOCATION TO XRA
       TXL *+2,2,32K-DEX+1 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER
       REM           
       TXH *+2,2,32K-DEX SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER
       REM           
       AXT 32K,4     77777 TO DEC
       TXH *+2,4,32K-1 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRC#77777, DEC#77776
       REM           
       AXT 0,4       CLEAR XRC
       TXL *+2,4,0   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRB#00000, DEC#00000
       REM           
 DEX1  TSX *+1,4     2-S COMPLEMENT OF THIS
       REM           LOCATION TO XRC
       TXL *+2,4,32K-DEX1+1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           
       TXH *+3,4,32K-DEX1 SHOULD TRANSFER
       HTR *+2       FAILED TO TRANSFER
       REM           
       REM           
       REM COMMENCE TEST
       BCD 1TOV      TEST OVERFLOW IN ACC
 A     TOV A+1       TURN OFF OVERFLOW  TRGR
       TOV A+3       NO GOOD, DID NOT TURN OFF
       TRA A+4       OK
 START TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A         REPEAT
       REM           
       REM           
       BCD 1TOV      TEST OVERFLOW ALS
 A7    CLA PTW       PLACE BIT IN ACC  1
       ALS 1         SHOULD OVERFLOW.
       TOV A7+4      OK, SHOULD OVFL
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A7        REPEAT
       REM           
       REM           
       BCD 1TOV      TEST OVFL WITH NO
 A8    CLA ZERO       OVERFLOW
       TOV A8+3      SHOULD NOT OVFL
       TRA A8+4      OK, DID NOT OVFL
       TSX ERROR,4   ERROR
       TSX OK,4      
       TRA A8        REPEAT
       REM           
       REM           
       BCD 1TNO      TEST TNO WITH NO ACC OVF
 A9    CLA ZERO      CLEAR ACC
       TNO A9+3      TEST FOR NO OVFL
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A9        REPEAT
       REM           
       REM           
       BCD 1TNO      TEST TNO WITH ACC OVFL
 A10   CLA PTW       PLACE BIT IN ACC  1
       ALS 1         SHIFT TO FORCE OVERFLOW
       TNO A10+4     SHOULD NOT TRANSFER
       TRA A10+5     OK
       TSX ERROR,4   
       TSX OK,4      REPEAT
       TRA A10       
       REM           
       REM           
       BCD 1TNO      DID TNO TURN LIGHT OFF
 A11   TOV  A11+2    
       TRA A11+3     OK, DID TURN IT OFF
       TSX ERROR,4   
       TSX OK,4      OK
       TRA A11       REPEAT
       REM           
       REM           
       BCD 1TZE      TEST TZE INST WITH ARS
 A12   ARS 36        CLEAR  ACCUMULATOR
       TZE A12+3     TEST FOR ZERO
       TSX ERROR,4   NO GOOD, DID NOT TRANSFER
       TSX OK,4      OK
       TRA A12       REPEAT
       REM           
       REM           
       BCD 1TZE      TEST TZE, WITH CLA
 A13   CLA ZERO      BRING IN  ZERO
       TZE A13+3     TEST FOR ZERO
       TSX ERROR,4   NO GOOD DID NOT TRANSFER
       TSX OK,4      OK
       TRA A13       REPEAT
       REM           
       REM           
       BCD 1TZE      TEST TZE, WITH CLA
 A14   CLA A14       BRING IN NON ZERO
       TZE A14+3     SHOULD NOT TRANSFER
       TRA A14+4     OK, DID NOT TRANSFER
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK
       TRA A14       REPEAT
       REM           
       REM           
       BCD 1TNZ      TEST TNZ, ACC NOT ZERO
 A15   CLA A15       BRING IN NON ZERO
       TNZ A15+3     SHOULD TRANSFER
       TSX ERROR,4   NO GOOD, DID NOT TRANSFER
       TSX OK,4      OK
       TRA A15       REPEAT
       REM           
       REM           
       BCD 1TNZ      TEST TNZ, ACC IS ZERO
 A16   CLA ZERO      CLEAR  ACC
       TNZ A16+3     SHOULD NOT TRANSFER
       TRA A16+4     OK DID NOT TRANSFER
       TSX ERROR,4   NO GOOD
       TSX OK,4      
       TRA A16       
       REM           
       REM           
       BCD 1ALS      TEST ALS
 A21   CLA ZERO      TEST ALS BY MOVING  ZERO
       ALS 8           EIGHT LEFT
       TZE A21+4     OK
       TSX ERROR,4   PICK UP ONES FROM LEFT
       TSX OK,4      
       TRA A21       
       REM           
       REM           
       BCD 1ALS      TEST ALS, MOVE A ONE
 A22   CLA ONE       PLACE ONE IN ACC  35
       TNZ A22+4     OK, ONE IS IN ACC
       TSX ERROR-1,4 ERROR IN STARTING
       TRA A22       
       REM           
       TOV A22+5     TURN OFF OVFL
       ALS 1         
       TNZ A22+9     OK, BIT IS STILL THERE
       TSX ERROR-1,4 LOST BIT IN ACC
       TRA A22       
       TOV A22+12    MOVE ON WHEN BIT GETS TO P
       TRA A22+5     LOOP ACROSS ACC
       TSX ERROR,4   NEVER ENTER, WASTE INST
       TSX OK,4      
       TRA A22       
       REM           
       REM           
       BCD 1ALS      ALS TEST, TEST IN Q POS
 A23   CLA PTW       PLACE BIT IN  1
       ALS 2         MOVE IT TO Q
       TNZ A23+5     
       TSX ERROR-1,4 LOST BIT IN Q
       TRA A23       
       ALS 1         MOVE BIT OUT OF ACC
       TZE A23+8     SHOULD BE ZERO NOW
       TSX ERROR,4   DID NOT MOVE BIT OUT OF Q
       TSX OK,4      
       TRA A23       
       REM           
       BCD 1ARS      ARS TEST
 A24   CLA ONE       PUT BIT IN 35 OF  ACC
       TOV A24+2     TURN OFF OVFL
       TNZ A24+5     OK, BIT IS IN ACC
       TSX ERROR-1,4 LOST BIT IN STARTING
       TRA A24       
       ALS 34        
       TNZ A25       OK, BIT IS IN POS 1
       TSX ERROR-1,4 
       TRA A24       
       REM           
       REM           
 A25   TNO A25+3     OVFL SHOULD BE  OFF
       TSX ERROR-1,4 
       TRA A24       
       ALS 1         
       ARS 1         
       TNZ A26       OK, BIT STILL THERE
       TSX ERROR-1,4 LOST BIT FROM P TO 1
       TRA A24       OR 1 TO P
       REM           
       REM           
 A26   ARS 1          INDICATIONS
       TOV A26+2     TURN OFF OVFL
       ALS 1         
       TNO A26+6     OVFL SHOULD BE OFF
       TSX ERROR-1,4 
       TRA A24       
       ALS 2         GO OVER TO Q
       TNZ A26+10    OK, BIT STILL THERE
       TSX ERROR-1,4 LOST BIT
       TRA A24       
       REM           
       REM           
       TOV A26+12    OVFL SHOULD BE ON
       TSX ERROR,4   
       TSX OK,4      
       TRA A24       
       REM           
       REM           
       BCD 1LBT      TEST LBT
 A27   CLA ONE       PLACE ONE IN ACC  25
       LBT           
       TSX ERROR,4   DID NOT SENSE ONE BIT
       TSX OK,4      
       TRA A27       
       REM           
       REM           
       BCD 1LBT      TEST LBT
 A28   CLA ZERO      PLACE ZERO IN ACC  35
       LBT           
       TRA A28+4     OK, DID NOT SENSE ONE
       TSX ERROR,4   ERROR SHOULD NOT SKIP
       TSX OK,4      
       TRA A28       
       REM           
       REM           
       BCD 1PBT      PBT TEST
 A29   CLA ZERO      PLACE ZERO IN  ACC
       ALS 18        MOVE ZERO INTO P
       PBT           
       TRA A29+5     OK, SENSED ZERO
       TSX ERROR,4   DID NOT SENSE ONE BIT
       TSX OK,4      
       TRA A29       
       REM           
       REM           
       BCD 1PBT      PBT TEST
 A30   CLA ONE       PLACE ONE ZERO IN ACC  35
       ALS 35        SHIFT ONE TO P POSITION
       PBT           
       TSX ERROR,4   DID NOT SKIP WITH ONE IN P
       TSX OK,4      
       TRA A30       
       REM           
       REM           
       BCD 1TPL      TPL TEST
 A31   CLA PTW       BRING IN PLUS  NUMBER
       TPL A31+3     TRANSFER IF OK
       TSX ERROR,4   ERROR DID NOT TRANSFER
       TSX OK,4      
       TRA A31       
       REM           
       REM           
       BCD 1TPL      TPL TEST
 A32   CLA MTW       BRING IN MINUS  NUMBER
       TPL A32+3     SHOULD NOT TRANSFER
       TRA A32+4     OK, DID NOT TRANSFER
       TSX ERROR,4   
       TSX OK,4      
       TRA A32       
       REM           
       REM           
       BCD 1TMI      TMI TEST
 A33   CLA MTW       BRING IN MINUS  NUMBER
       TMI A33+3     OK, SHOULD TRANSFER
       TSX ERROR,4   DID NOT TRANSFER
       TSX OK,4      
       TRA A33       
       REM           
       REM           
       BCD 1TMI      TMI TEST
 A34   CLA PTW       BRING IN PLUS  NUMBER
       TMI A34+3     SHOULD NOT TRANSFER
       TRA A34+4     OK, DID NOT TRANSFER
       TSX ERROR,4   
       TSX OK,4      
       TRA A34       
       REM           
       REM           
       BCD 1CLM      CLM TEST, TWO PARTS
 A35   CLA ONES      BRING IN  -377777777777
       CLM           
       TZE A35+5     OK, NOW SEE IF SIGN IS SAME
       TSX ERROR-1,4 DID NOT CLEAR POS 1-35
       TRA A35       
       REM           
       TMI A35+7     OK, DID NOT CHANGE SIGN
       TSX ERROR,4   CHANGED SIGN
       TSX OK,4      PROCEED
       TRA A35       
       REM           
       REM           
       BCD 1CLM      CLM TEST, TWO PARTS
 A36   CLA PONES     BRING IN +377777777777
       CLM           
       TZE A36+5     OK. NOW SEE IF SIGN IS SAME
       TSX ERROR-1,4 DID NOT CLEAR POS 1-35
       TRA A36       
       REM           
       TPL A36+7     OK, SIGN UNCHANGED
       TSX ERROR,4   CHANGED SIGN
       TSX OK,4      
       TRA A36       
       REM           
       REM           
       BCD 1CLM      CLM TEST, CHECK OF P ANDQ
 A37   CLA ONES      BRING IN ONES
       ALS 6         SHIFT INTO P AND Q
       CLM           
       TZE A37+5     OK, SHOULD CLEAR P AND Q
       TSX ERROR,4   DID NOT CLEAR P AND Q
       TSX OK,4      
       TRA A37       
       REM           
       REM           
       BCD 1SSP      SSP TEST
 A38   CLA ONES      MAKE ACC SIGN MINUS
       SSP           NOW MAKE POSITIVE
       TPL A38+4     OK, SHOULD TRANSFER
       TSX ERROR,4   DID NOT CHANGE MINUS TO
       REM           PLUS
       TSX OK,4      
       TRA A38       
       REM           
       REM           
       BCD 1SSP      SSP TEST
 A39   CLA PONES     BRING IN PLUS NUMBER
       SSP           
       TPL A39+4     SHOULD TRANSFER
       TSX ERROR,4   DID NOT TRA, CHANGED SIGN
       TSX OK,4      
       TRA A39       
       REM           
       REM           
       BCD 1SSM      SSM TEST
 A40   CLA PONES     BRING IN PLUS NUMBER
       SSM           MAKE IT MINUS
       TMI A40+4     SHOULD TRANSFER
       TSX ERROR,4   DID NOT CHANGE PLUS TO
       REM             MINUS
       TSX OK,4      
       TRA A40       
       REM           
       REM           
       BCD 1SSM      SSM TEST
 A41   CLA ONES      BRING IN NEGATIVE NUMBER
       SSM           SHOULD NOT CHANGE
       TMI A41+4     SHOULD TRANSFER
       TSX ERROR,4   INADVERTENTLY CHANGED SIGN
       TSX OK,4      
       TRA A41       
       REM           
       REM           
       BCD 1CHS      CHS TEST
 A42   CLA PONES     BRING IN PLUS NUMBER
       CHS           MAKE IT MINUS
       TMI A42+4     SHOULD TRANSFER
       TSX ERROR,4   DID NOT CHANGE SIGNS
       TSX OK,4      
       TRA A42       
       REM           
       REM           
       BCD 1CHS      CHS TEST
 A43   CLA ONES      BRING IN NEGATIVE NUMBER
       CHS           MAKE IT POSITIVE
       TPL A43+4     SHOULD TRANFER
       TSX ERROR,4   DID NOT CHANGE MINUS TO
       REM           PLUS
       TSX OK,4      
       TRA A43       
       REM           
       REM           
       BCD 1LLS      LLS TEST
 A44   TOV A44+1     TURN OFF OVFL
       LDQ ZERO      BRING ZERO INTO ACC + MQ
       CLA ZERO      SEE IF PICKED UP BITS
       LLS 18          BY SHIFT
       TZE A45       SHOULD TRANFER
       TSX ERROR-1,4 PICKED UP BIT
       TRA A44       
       REM           
       REM           
 A45   STQ TEMP      CHECK FOR MQ PICK UP
       CLA TEMP        OF BITS BY LLS
       TZE A45+4     OK, NO PICK UP
       TSX ERROR,4   PICKED UP A ONE
       TSX OK,4      
       TRA A44       REPEAT TO A44
       REM           
       REM           
       BCD 1LLS      LLS TEST
 A46   CLA ZERO      CLEAR ACCUMULATOR
       LDQ ONE       MOVE BIT FROM MQ 35 TO MQ 1
       LLS 35        BIT FROM MQ 35 TO ACC 35
       LBT           TEST ACC POSITION 35
       TRA *+2       ERROR
       TRA A47       OK, PROCEED
       TSX ERROR-1,4 
       TRA A46       
       REM           
       REM           
 A47   STQ TEMP      IS THE BIT STILL IN MQ
       CLA TEMP      
       TZE *+2       OK-NO BIT IN MQ
       TSX ERROR,4   LOST THE BIT IN THE MQ
       TSX OK,4      
       TRA A46       GO BACK UP TO A 46
       REM           
       REM           
       BCD 1LLS      LLS TEST, CHECK FOR SIGNS
 A48   CLA MTW       MAKE ACC NEGATIVE
       LDQ PTW       MAKE MQ POSITIVE
       LLS           
       TPL A48+5     OK, SHOULD TRANFER
       TSX ERROR,4   DID NOT CHANGE ACC SIGN
       TSX OK,4      
       TRA A48       
       REM           
       REM           
       BCD 1LLS      LLS TEST, CHECK FOR SIGNS
 A49   CLA PTW       MAKE ACC POSITIVE
       LDQ MTW       MAKE MQ NEGATIVE
       LLS           
       TMI A49+5     OK, SHOULD TRANFER
       TSX ERROR,4   DID NOT CHANGE ACC SIGN
       TSX OK,4      
       TRA A49       
       REM           
       REM           
       BCD 1LLS      
 A50   CLA PTW      MAKE ACC POSITIVE
       LDQ PTW      MAKE MQ POSITIVE
       LLS           
       TPL A50+5    SHOULD TRANSFER
       TSX ERROR,4  CHANGED SIGNS INADVERTENTLY
       TSX OK,4      
       TRA A50       
       REM           
       REM           
       BCD 1LLS     LLS TEST, CHECK FOR SIGNS
 A51   CLA MTW      MAKE ACC NEGATIVE
       LDQ MTW      MAKE MQ NEGATIVE
       LLS           
       TMI A51+5    SHOULD TRANSFER
       TSX ERROR,4  SIGNS CHANGED INADVERTENLY
       TSX OK,4      
       TRA A51       
       REM           
       REM           
       BCD 1LRS     LRS TEST
 A52   CLA ONE      PLACE 1 IN ACC 35
       LDQ ZERO     CLEAR MQ
       LRS 35       SHIFT A ONE TO MQ
       STQ TEMP     STORE MQ IN TEMP STORAGE
       CLA TEMP     BRING CONTENTS OF MQ TO ACC
       TNZ A52+7    OK, SHOULD STILL HAVE ONE
       TSX ERROR,4  LOST ONE BIT IN SHIFT
       TSX OK,4      
       TRA A52       
       REM           
       REM           
       BCD 1LRS      LRS TEST
 A53   LDQ ZERO      CLEAR MQ
       CLA PTW       PLATE BIT IN ACC 1
       LRS 36        MOVE A ONE TO MQ
       TZE A53+5     OK, ACC SHOULD BE CLEAR
       TSX ERROR,4   DID NOT CLEAR ACC
       TSX OK,4      
       TRA A53       
       REM           
       REM           
       BCD 1LRS      LRS TEST
 A54   CLA MTW       PLACE BIT IN ACC POS 1
       LRS 34        MOVE IT TO ACC POS 35
       LBT           IS IT THERE
       TSX ERROR,4   NO
       TSX OK,4      YES
       TRA A54       
       REM           
       REM           
       BCD 1LRS      LRS TEST, CHECK SIGNS
 A55   CLA PTW       MAKE ACC POSITIVE
       LDQ MTW       MAKE MQ NEGATIVE
       LRS           CHANGE SIGN OF MQ
       STQ TEMP      STORE IT
       CLA TEMP      BRING IT TO ACC
       TPL A55+7     SHOULD BE PLUS
       TSX ERROR,4   DID NOT CHANGE SIGNS
       TSX OK,4      
       TRA A55       
       REM           
       REM           
       BCD 1LRS      LRS TEST, CHECK SIGNS
 A56   CLA MTW       MAKE ACC NEGATIVE
       LDQ PTW       MAKE MQ POSITIVE
       LRS           CHANGE MQ SIGN
       STQ TEMP      SAVE IT
       CLA TEMP      TEST IT
       TMI A56+7     OK
       TSX ERROR,4   DID NOT CHANGE MQ SIGN
       TSX OK,4      
       TRA A56       
       REM           
       REM           
       BCD 1LRS      LRS TEST, CHECK SIGNS
 A57   CLA PTW       MAKE ACC POSITIVE
       LDQ PTW       MAKE MQ POSITIVE
       LRS           MQ SIGN SHOULD STAY
       REM             POSITIVE
       STQ TEMP      SAVE IT
       CLA TEMP      BRING TO ACC
       TPL A57+7     OK, SHOULD BE PLUS
       TSX ERROR,4   CHANGE SIGN INADVERTENTLY
       TSX OK,4      
       TRA A57       
       REM           
       REM           
       BCD 1LGL      LGL TEST
 A58   TOV A58+1     TURN OFF OVERFLOW
       CLA ZERO      PLACE ZERO IN ACC
       LDQ ZERO      PLACE ZERO IN MQ
       LGL 8         
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING IT INTO ACC
       TZE A58+8     OK, SHOULD BE ZERO
       TSX ERROR,4   PICKED UP BITS
       TSX OK,4      
       TRA A58       
       REM           
       REM           
       BCD 1LGL      LGL TEST, SHIFT ACROSS
 A59   CLA ZERO      PLACE ZERO IN ACC
       LDQ ONE       PLACE ONE IN MQ 35
       LGL 1         SHIFT ONE
       STQ TEMP      SAVE MQ
       CLA TEMP      TEST FOR BIT
       TNZ A59+2     OK, SWEEP ACROSS MQ
       TMI A59+8     FINISH ACC SHOULD BE MINUS
       TSX ERROR,4   FAILED TO SHIFT, LOST A BIT
       TSX OK,4      
       TRA A59       
       REM           
       REM           
       BCD 1LGL      LGL TEST, SEEK P POSITION
 A60   TOV A60+1     TURN OFF OVERFLOW
       LDQ MZE       
       LGL 36        MOVE BIT FROM MQ S TO ACC P
       PBT           IS THERE A BIT IN ACC P
       TRA A60+6     ERROR
       TRA A60+8     OK, PROCEED
       TSX ERROR-1,4 NO BIT IN P
       TRA A60       
       REM           
       TOV A61       OK, PROCEED
       TSX ERROR-1,4 
       TRA A60       
       REM           
       REM           
 A61   LGL 2         MOVE BIT OUT OF Q
       TZE A61+3     OK, SHOULD BE ZERO
       TSX ERROR,4   DID NOT MOVE PAST Q
       TSX OK,4      
       TRA A60       
       REM           
       REM           
       BCD 1LGL      LGL TEST
 A61A  LDQ PTHR      PLACE BIT IN MQ 2 POS
       LGL 3         MOVE BIT TO ACC 35
       LBT           CHECK ACC
       TRA A61A+5    DID NOT SHIFT TO ACC 35
       TRA A61A+7    OK, CHECK MQ
       TSX ERROR-1,4 
       TRA A61A      
       REM           
       STQ TEMP      PLACE MQ IN TEMP STOR
       CLA TEMP      BRING IT TO ACC
       TZE A61A+12   SHOULD BE ZERO
       TSX ERROR-1,4 
       TRA A61A      
       REM           
       TPL A61A+14   OK, MQ IS PLUS, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA A61A      
       REM           
       REM           
       BCD 1RQL      RQL TEST
 A62   LDQ MZE       PLACE BIT IN MQC SIGN POS
       RQL 1         
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING MQ TO ACC
       LBT           TEST FOR ROTATE
       TSX ERROR,4   DID NOT ROTATE
       TSX OK,4      OK, BIT WENT FROM MQ S TO
       REM             MQ 35
       TRA A62       
       REM           
       REM           
       BCD 1RQL      RQL TEST
 A62A  TOV A62A+1    TURN OFF OVFL
       CLA ZERO      LOAD ACC WITH ZERO
       LDQ ZERO      LOAD MQ WITH ZERO
       RQL 16        
       STQ TEMP      MOVE MQ TO ACC
       CLA TEMP      
       TZE A62A+8    OK, SHOULD BE ZERO
       TSX ERROR,4   PICKED UP BITS
       TSX OK,4      
       TRA A62A      
       REM           
       REM           
       BCD 1RQL      RQL TEST
 A63   LDQ MZE       START WITH BIT IN MQ S
       RQL 1         SHIFT UNTIL IT GET BACK
       STQ TEMP        AROUND
       CLA TEMP      
       TNZ A63+1     LOOP 35 TIMES
       TMI A63+7     YES, IT GOT BACK TO S POS
       TSX ERROR,4   
       TSX OK,4      
       TRA A63       
       REM           
       REM           
       BCD 1RQL      RQL MODULO TEST
 A63A  LDQ ONE       PLACE ONE IN MQ 35
       RQL 256       SHOULD NOT SHIFT
       STQ TEMP      LOAD MQ INTO ACC
       CLA TEMP      
       LBT           HAVE WE SHIFTED
       TSX ERROR,4   YES, ERROR
       TSX OK,4      NO
       TRA A63A      
       REM           
       REM           
       BCD 1RQL      RQL MODULO TEST
 A63B  LDQ ONE       PLACE ONE IN MQ 35
       RQL 292       SHOULD MAKE ONE ROTATION
       STQ TEMP      LOAD MQ INTO ACC
       CLA TEMP      
       LBT           WAS MODULO INTERPRETED OK
       TSX ERROR,4   NO
       TSX OK,4      YES, MODULO PROCESS WORKS
       TRA A63B      
       REM           
       REM           
       BCD 1TQP      TQP TEST
 A64   LDQ PTW       PLACE PLUS NUMBER IN MQ
       TQP A64+3     SHOULD TRANSFER
       TSX ERROR,4   
       TSX OK,4      
       TRA A64       
       REM           
       REM           
       BCD 1TQP      TQP TEST
 A65   LDQ MTW       PLACE NEGATIVE NO IN MQ
       TQP A65+3     SHOULD NOT TRANSFER
       TRA A65+4     OK
       TSX ERROR,4   
       TSX OK,4      
       TRA A65       
       REM           
       REM           
       BCD 1NOP      NOP TEST
 A66   NOP A66+2     
       TRA A66+3     OK
       TSX ERROR,4   
       TSX OK,4      
       TRA A66       
       REM           
       REM           
       BCD 1COM      COM TEST
 A67   CLA ONES      PLACE ONES IN ACC
       COM           SHOULD NOW BE ZERO
       ALS 2         
       TZE A67+5     OK, IT IS ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA A67       
       REM           
       REM           
       BCD 1COM      COM TEST
 A68   CLA ONES      PLACE ONES IN ACC
       LDQ ONES      PLACE ONES IN MQ
       LLS 8         SHIFT BITS TO P AND Q
       COM           MAKE IT ALL ZEROS
       TZE A68+6     OK, ALL ZEROS
       TSX ERROR,4   
       TSX OK,4      
       TRA A68       
       REM           
       REM           
       BCD 1COM      COM TEST, CHECK SIGN
 A69   CLA PONES     BRING IN PLUS NUMBER
       COM           MAKE COM
       TPL A69+4     OK, SIGN DID NOT CHANGE
       TSX ERROR,4   
       TSX OK,4      
       TRA A69       
       REM           
       REM           
       BCD 1COM      COM TEST, CHECK SIGN
 A70   CLA ONES      BRING IN NEG NUMBER
       COM           COM
       TMI A70+4     OK, SIGN DID NOT CHANGE
       TSX ERROR,4   
       TSX OK,4      
       TRA A70       
       REM           
       REM           
       BCD 1ADD      ADD TEST, SIGNS POSITIVE
 A71   CLA ONE       HAVE BOTH SIGNS POSITIVE
       ADD ONE       ADD
       LBT           SHOULD HAVE ZERO IN ACC 35
       TRA A72       OK
       TSX ERROR-1,4 
       TRA A71       
       REM           
       REM           
 A72   ARS 1         SHIFT ONE TO CHECK ANSWER
       LBT           
       TRA A72+4     DID NOT ADD CORRECTLY
       TRA A72+6     CHECK SIGN
       TSX ERROR-1,4 BIT ERROR
       TRA A71       
       REM           
       TPL A72+8     OK, SIGN IS PLUS
       TSX ERROR,4   
       TSX OK,4      
       TRA A71       
       REM           
       REM           
       BCD 1ADD      ADD TEST, SIGNS NEGATIVE
 A73   CLA MONE      BRING IN MINUS ONE
       ADD MONE      ADD MINUS ONE
       LBT           TEST ANSWER
       TRA A74       OK, ACC 35 IS A ZERO
       TSX ERROR-1,4 
       TRA A73       
       REM           
       REM           
 A74   ARS 1         SHOULD GET A ONE
       LBT           TEST
       TRA A74+4     DID NOT SENSE A ONE
       TRA A74+6     CHECK SIGN
       TSX ERROR-1,4 
       TRA A73       
       REM           
       TMI A74+8     OK, SIGN IS MINUS
       TSX ERROR,4   
       TSX OK,4      
       TRA A73       REPEAT SECTION
       REM           
       REM           
       BCD 1ADD      ADD TEST, ACC PLUS, MEMORY
       REM             NEGATIVE
 A75   CLA THREE     MAKE ACC PLUS THREE
       ADD M2        ADD MEM MINUS TWO
       LBT           SHOULD GET A ONE
       TRA A75+5     
       TRA A76       OK
       TSX ERROR-1,4 
       TRA A75       
       REM           
       REM           
 A76   ARS 1         SEE THAT HAVE NO CARRY
       LBT           TEST FOR ZERO
       TRA A76+5     CHECK SIGN
       TSX ERROR-1,4 
       TRA A75       
       REM           
       TPL A76+7     OK, SIGN SHOULD BE PLUS
       TSX ERROR,4   
       TSX OK,4      
       TRA A75       REPEAT SECTION
       REM           
       REM           
       BCD 1ADD      ADD TEST, ACC MINUS
       REM             MEMORY PLUS
 A77   CLA M3        MAKE ACC MINUS THREE
       ADD TWO       ADD PLUS TWO
       LBT           TEST FOR ONE
       TRA A77+5     
       TRA A78       OK
       TSX ERROR-1,4 
       TRA A77       
       REM           
 A78   ARS 1         SEE THAT HAVE NO CARRY
       LBT           SHOULD BE ZERO
       TRA A78+5     CHECK SIGN
       TSX ERROR-1,4 BIT ERROR
       TRA A77       
       REM           
       TMI A78+7     OK, SIGN IS MINUS
       TSX ERROR,4   DID NOT GET SIGN OR ZERO
       TSX OK,4      
       TRA A77       
       REM           
       REM           
       REM           
       BCD 1ADD      ADD TEST
 A79   CLA TWO       MAKE ACC PLUS TWO
       ADD M3        ADD MINUS THREE
       LBT           TEST FOR ONE
       TRA A79+5     
       TRA A80       OK
       TSX ERROR-1,4 
       TRA A79       
       REM           
       REM           
 A80   ARS 1         CHECK FOR ZERO FIRST
       LBT           TEST FOR ZERO
       TRA A80+5     CHECK SIGN
       TSX ERROR-1,4 BIT ERROR
       TRA A79       
       REM           
       TMI A80+7     OK, SIGN IS MINUS
       TSX ERROR,4   
       TSX OK,4      
       TRA A79       REPEAT SECTION
       REM           
       REM           
       BCD 1ADD      ADD TEST
 A81   CLA M2        MAKE ACC MINUS TWO
       ADD THREE     ADD PLUS THREE
       LBT           TEST FOR ONE
       TRA A81+5     
       TRA A82       OK, GOT A ONE
       TSX ERROR-1,4 
       TRA A81       
       REM           
       REM           
 A82   ARS 1         CHECK NEXT POSITION
       LBT             FOR A ZERO
       TRA A82+5     CHECK SIGN
       TSX ERROR-1,4 
       TRA A81       
       REM           
       TPL A82+7     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA A81       
       REM           
       REM           
       BCD 1ADD      ADD TEST, WITH RIPPLE
 A82A  CLA PONES     BRING IN PLUS ONES
       ADD ONE       ADD ONE TO RIPPLE
       PBT           P SHOULD HAVE BIT
       TRA A82A+5    NO P BIT
       TRA A82A+7    OK, CHECK OVFL
       TSX ERROR-1,4 
       TRA A82A      OK, PROCEED
       REM           
       TOV A82A+9    
       TSX ERROR,4   
       TSX OK,4      
       TRA A82A      
       REM           
       REM           
       BCD 1ADM      ADM TEST
 A83   CLA MONE      ACC NEGATIVE ONE
       ADM TWO       STORAGE PLUS TWO
       LBT           TEST FOR ONE
       TRA A83+5     NO
       TRA A83+7     CHECK SIGN.
       TSX ERROR-1,4 
       TRA A83       
       REM           
       TPL A83+9     OK, SIGN IS PLUS
       TSX ERROR,4   
       TSX OK,4      
       TRA A83       
       REM           
       REM           
       BCD 1ADM       ADM TEST
 A84   CLA MONE       ACC IS MINUS ONE
       ADM M2         STORAGE MINUS TWO
       LBT            TEST FOR ONE
       TRA A84+5      NO
       TRA A84+7      OK, CHECK SIGN
       TSX ERROR-1,4 
       TRA A84       
       REM           
       TPL A84+9      OK, PROCEED
       TSX ERROR,4   
       TSX OK,4       
       TRA A84       
       REM           
       REM           
       BCD 1ADM       ADM TEST, WITH RIPPLE
 A84A  CLA PONES      BRING IN PLUS ONES
       ADM MONE       ADM OF MINUS ONE
       PBT            SHOULD GET BIT IN P
       TRA A84A+5     NO P BIT 
       TRA A84A+7     OK, CHECK OVFL
       TSX ERROR-1,4 
       TRA A84A       
       REM           
       TOV A84A+9     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4       
       TRA A84A      
       REM           
       REM           
       BCD 1SUB     SUB TEST
 A85   CLA ONE      MAKE ACC PLUS ONE
       SUB MONE     SUB MINUS ONE
       LBT          TEST FOR ZERO
       TRA A85+6    CHECK SIGN
       TSX ERROR-1,4 
       TRA A85       
       REM           
       TPL A86       OK, PROCEED
       TSX ERROR-1,4 
       TRA A85       
       REM           
       REM           
 A86   ARS 1         IN ACC POS 34
       LBT           
       TSX ERROR,4   NO ONE BIT
       TSX OK,4      OK, GOT A ONE BIT
       TRA A85       REPEAT SECTION
       REM           
       REM           
       BCD 1SUB      SUB TEST
 A87   CLA MONE      MAKE ACC MINUS ONE
       SUB ONE       SUB PLUS ONE
       LBT           TEST FOR ZERO
       TRA A87+6     OK, CHECK SIGN
       TSX ERROR-1,4 
       TRA A87       
       REM           
       TMI A88       OK, PROCEED
       TSX ERROR-1,4 
       TRA A87       
       REM           
       REM           
 A88   ARS 1         CHECK FOR ONE IN POS 34
       LBT           SHOULD GET A ONE
       TSX ERROR,4   NO, DID NOT GET IT
       TSX OK,4      OK, PROCEED
       TRA A87       
       REM           
       REM           
       BCD 1SUB      SUB TEST, END CARRY
 A89   CLA THREE     ACC PLUS THREE
       SUB TWO       SUB PLUS TWO
       LBT           SHOULD HAVE PLUS ONE
       TRA A89+5     DID NOT GET ONE
       TRA A89+7     OK, CHECK SIGN
       TSX ERROR-1,4 
       TRA A89       
       REM           
       TPL A89+9     OK PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA A89       
       REM           
       REM           
       BCD 1SUB      SUB TEST, NO END CARRY
 A90   CLA TWO       ACC PLUS TWO
       SUB THREE     SUB PLUS THREE
       LBT           TEST FOR ONE
       TRA A90+5     NO GOT ERROR
       TRA A90+7     OK, PROCEED
       TSX ERROR-1,4 
       TRA A90       
       REM           
       TMI A91       OK, PROCEED
       TSX ERROR-1,4 
       TRA A90       
       REM           
       REM           
 A91   ARS 1         CHECK ACC POS 34
       LBT           SHOULD BE ZERO
       TRA A91+4     OK IT IS ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA A90       REPEAT SECTION
       REM           
       REM           
       BCD 1SUB      SUB TEST, NO END CARRY
 A92   CLA M2        ACC MINUS TWO
       SUB M3        SUB MINUS THREE
       LBT           TEST FOR ONE
       TRA A92+5     NO, GOT A ZERO
       TRA A92+7     OK, CHECK SIGN
       TSX ERROR-1,4 
       TRA A92       
       REM           
       TPL A93       OK, PROCEED
       TSX ERROR-1,4 
       TRA A92       
       REM           
       REM           
 A93   ARS 1         CHECK POSITION 34 OF ACC
       LBT           SHOULD BE ZERO
       TRA A93+4     OK
       TSX ERROR,4   NO GOOD
       TSX OK,4      
       TRA A92       
       REM           
       REM           
       BCD 1SUB      SUB TEST, END CARRY
 A94   CLA M3        ACC MINUS THREE
       SUB M2        SUB MINUS TWO
       LBT           TEST FOR ONE
       TRA A94+5     NO GOOD, GO A ZERO
       TRA A94+7     OK, CHECK SIGN
       TSX ERROR-1,4 
       TRA A94       
       REM           
       TMI A95       OK, PROCEED
       TSX ERROR-1,4 
       TRA A94       
       REM           
       REM           
 A95   ARS 1         CHECK POSITION 34 OF ACC
       LBT           SHOULD BE ZERO
       TRA A95+4     OK IT IS ZERO
       TSX ERROR,4   NO GOOD, GOT A ONE
       TSX OK,4      
       TRA A94       
       REM           
       REM           
       BCD 1SUB      SUB TEST, WITH RIPPLE
 A95A  CLA ONES      BRING IN MINUS ONES
       SUB ONE       SUB PLUS ONE
       PBT           SHOULD GET BIT IN P
       TRA A95A+5    NO BIT IN P
       TRA A95A+7    OK, CHECK OVFL
       TSX ERROR-1,4 
       TRA A95A      
       REM           
       TOV A95A+9    OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA A95A      
       REM           
       REM           
       BCD 1SBM      SBM TEST
 A96   CLA ONE       ACC PLUS ONE
       SBM M2        SBM MINUS TWO
       LBT           TEST FOR ONE
       TRA A96+5     NO GOOD, GOT ZERO
       TRA A96+7     OK, CHECK SIGN
       TSX ERROR-1,4 
       TRA A96       
       REM           
       TMI A96+9     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA A96       
       REM           
       REM           
       BCD 1SBM      SBM TEST
 A97   CLA ONE       ACC PLUS ONE
       SBM TWO       SBM PLUS TWO
       LBT           TEST FOR ONE
       TRA A97+5     GOT ZERO
       TRA A97+7     OK, CHECK SIGN
       TSX ERROR-1,4 
       TRA A97       
       REM           
       TMI A97+9     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA A97       
       REM           
       REM           
       BCD 1SBM      SBM TEST, WITH RIPPLE
 A97A  CLA ONES      BRING IN MINUS ONES
       SBM ONE       SBM OF PLUS ONE
       PBT           SHOULD BE BIT IN P
       TRA A97A+5    NO BIT IN P
       TRA A97A+7    OK, CHECK OVFL
       TSX ERROR-1,4 
       TRA A97A      
       REM           
       TOV A97A+9    OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA A97A      
       REM           
       REM           
       BCD 1CLA      CLA TEST
 A98   CLA MONE      MAKE ACC MINUS
       TMI A98+3     CHECK SIGN LOADING
       TSX ERROR,4   NO, DID NOT BRING IN MINUS
       TSX OK,4      OK, PROCEED
       TRA A98       
       REM           
       REM           
       BCD 1CLA      CLA TEST
 A99   CLA ONE       MAKE ACC PLUS
       TPL A99+3     CHECK SIGN, SHOULD BE PLUS
       TSX ERROR,4   NO GOOD
       TSX OK,4      
       TRA A99       
       REM           
       REM           
       BCD 1CLA      CLA TEST
 A100  CLA ZERO      SEE IF ACC IS CLEAR
       TZE A100+3    OK, SHOULD BE ZERO
       TSX ERROR,4   NO GOOD
       TSX OK,4      
       TRA A100      
       REM           
       REM           
       BCD 1CLA      CLA TEST
 B     CLA PTW       BIT IN ACC 1
       ALS 1         SHIFT TO P POSITION
       PBT           TEST P FOR A ONE
       TRA B+5       NO, GOT A ZERO
       TRA B+7       OK, CHECK OVFL
       TSX ERROR-1,4 
       TRA B         
       REM           
       TOV B+9       OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B         
       REM           
       REM           
       BCD 1CLA      CLA TEST
 B1    CLA ONE       SEE IF Q AND P POS ARE
       REM              CLEAR
       PBT           P POS SHOULD BE ZERO
       TRA B1+5      OK, NOW TEST Q POS
       TSX ERROR-1,4 
       TRA B1        
       REM           
       ARS 1         SHIFT FOR Q
       PBT           Q POS SHOULD BE ZERO
       TRA B1+10     OK, CHECK OVFL
       TSX ERROR-1,4 
       TRA B1        
       REM           
       TNO B1+12     OK, OVFL SHOULD BE OFF
       TSX ERROR,4   
       TSX OK,4      
       TRA B1        
       REM           
       REM           
       BCD 1CLA      CLA TEST
 B2    CLA ONE       SEE THAT ONE IS IN ACC 35
       LBT           IS ONE THERE
       TSX ERROR,4   NO
       TSX OK,4      YES, ONE IS THERE
       TRA B2        
       REM           
       REM           
       BCD 1CLA      CLA TEST, WITH RIPPLE
 B3    CLA PONES     BRING IN PLUS ONES
       ADD ONE       ADD ONE
       LBT           CHECK ACC 35 FOR ZERO
       TRA B3+6      OK, IS ZERO
       TSX ERROR-1,4 
       TRA B3        
       REM           
       PBT           TEST P POS FOR ONE
       TRA B3+9      ERROR
       TRA B3+11     OK, CHECK ACC RESULT
       TSX ERROR-1,4 
       TRA B3        
       REM           
       ALS 2         OK, CHECK FOR ZERO IN OTHER
       TZE B3+14       POS BY MOVING BIT PAST Q
       TSX ERROR,4   NO GOOD, PICKED UP A BIT
       TSX OK,4      OK
       TRA B3        
       REM           
       REM           
       BCD 1CLS      CLS TEST
 B4    CLS MONE      BRING IN MINUS ONE
       TPL B4+3      SHOULD BECOME PLUS
       TSX ERROR,4   DID NOT CHANGE SIGN
       TSX OK,4      
       TRA B4        
       REM           
       REM           
       BCD 1CLS      CLS TEST
 B5    CLS ONE       BRING IN ONE
       TMI B5+3      SHOULD BE MINUS
       TSX ERROR,4   DID NOT CHANGE SIGN
       TSX OK,4      
       TRA B5        
       REM           
       REM           
       BCD 1CLS      CLS TEST
 B6    CLS ONE       BRING IN ONE IN ACC 35
       LBT           CHECK, IS ONE IN ACC 35
       TRA B6+4      NO GOOD, DID NOT GET ONE
       TRA B6+6      PROCEED
       TSX ERROR-1,4 
       TRA B6        
       REM           
       PBT           SEE IF P IS CLEAR
       TRA B6+10     OK, PROCEED
       TSX ERROR-1,4 
       TRA B6        
       REM           
       ARS 1         SHIFT TO CHECK Q
       PBT           SHOULD BE ZERO
       TRA B6+14     OK, IT IS ZERO, PROCEED
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK, THERE WAS A ZERO THERE
       TRA B6        
       REM           
       REM           
       BCD 1CAL      CAL TEST
 B7    CAL MONE      CHECK THAT P HAS ONE
       PBT           SHOULD HAVE ONE
       TRA B7+4      
       TRA B8        OK, PROCEED
       TSX ERROR-1,4 
       TRA B7        
       REM           
       REM           
 B8    TPL B8+3      CHECK THAT SIGN DID NOT
       REM             CHANGE
       TSX ERROR-1,4 
       TRA B7        
       REM           
       ARS 1         
       PBT           CHECK Q POS
       TRA B8+7      SHOULD BE ZERO
       TSX ERROR,4   OK, PROCEED
       TSX OK,4      NO GOOD
       TRA B7        
       REM           
       REM           
       BCD 1CAL      CAL TEST
 B9    CAL ONE       BRING IN PLUS ONE
       PBT           P SHOULD BE ZERO
       TRA B9+5      OK, PROCEED
       TSX ERROR-1,4 
       TRA B9        
       REM           
       LBT           TEST ACC 35 FOR ONE
       TRA B9+8      DID NOT BRING IN A ONE
       TRA B10       OK, PROCEED
       TSX ERROR-1,4 
       TRA B9        
       REM           
 B10   TPL B10+3     SIGN SHOULD BE PLUS
       TSX ERROR-1,4 ERROR, CHANGE OF SIGN
       TRA B9        
       REM           
       REM           
       ARS 1         CHECK Q POS FOR ZERO
       PBT           
       TRA B10+7     OK, PROCEED
       TSX ERROR,4   NO GOOD
       TSX OK,4      OK, PROCEED
       TRA B9        
       REM           
       REM           
       BCD 1ACL      ACL TEST
 B11   CLA ZERO      CHECK P POSITION AND SIGN
       ACL ONE         POSITION
       PBT           SHOULD BE A ZERO IN A
       TRA B11+6     CHECK SIGN
       TSX ERROR-1,4 
       TRA B11       
       REM           
       TPL B11+8     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B11       
       REM           
       REM           
       BCD 1ACL      ACL TEST
 B12   CLA ZERO      BRING IN MINUS NUMBER
       ACL MONE      SHOULD GET ONE IN P POS
       PBT           
       TRA B12+5     NO GOOD, GOT ZERO
       TRA B12+7     CHECK SIGN
       TSX ERROR-1,4 
       TRA B12       
       REM           
       TPL B12+10    OK, PROCEED
       TSX ERROR-1,4 ERROR, CHANGE OF SIGN
       TRA B12       
       REM           
       LBT           CHECK FOR ONE IN ACL 35
       TSX ERROR,4   GOT A FALSE CARRY
       TSX OK,4      
       TRA B12       
       REM           
       REM           
       BCD 1ACL      ACL TEST
 B13   CAL MONE      ACC BIT IN POS P AND POS 35
       ACL MONE      ACL MINUS ONE
       PBT           SHOULD GET ZERO IN P
       TRA B13+6     OK, PROCEED
       TSX ERROR-1,4 
       TRA B13       
       REM           
       LBT           TEST FOR END CARRY
       TRA B13+9     NO GOOD, GOT A ZERO
       TRA B13+11    OK, PROCEED
       TSX ERROR-1,4 
       TRA B13       
       REM           
       ARS 1         OK, NOW SEE IF Q BIT
       PBT             HAS A ONE
       TRA B13+15    Q SHOULD BE CLEARED
       TSX ERROR,4   ERROR, GOT A ONE IN POS Q
       TSX OK,4      
       TRA B13       
       REM           
       REM           
       BCD 1STO      STO TEST
 B14   CLA ONES      BRING IN ALL ONES
       STO TEMP      PLACE IN TEMP STORAGE
       SUB TEMP      SUB SAME QUANTITY
       TZE B14+5     SHOULD BE ZERO
       TSX ERROR,4   ERROR DID NOT STO RIGHT
       TSX OK,4      
       TRA B14       
       REM           
       REM           
       BCD 1SLW      SLW TEST
 B15   CAL MONE      PUT BIT IN POS P AND POS 35
       TPL B15+4     OK, SIGN SHOULD BE PLUS
       TSX ERROR-1,4 
       TRA B15       
       REM           
       SLW TEMP      SLW IN TEMP STORAGE
       CLA TEMP      BRING WORD BACK
       SUB MONE      SUB ORIGINAL
       TZE B15+9     OK, SHOULD GET ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B15       
       REM           
       REM           
       BCD 1SLW      SLW TEST
 B16   CLA MONE      PUT BIT IN P, SIGN MINUS
       SLW TEMP      SLW IN TEMP STORAGE
       CLA TEMP      BRING IT TO ACC
       TPL B16+5     SIGN SHOULD NOW BE PLUS
       TSX ERROR,4   
       TSX OK,4      
       TRA B16       
       REM           
       REM           
       BCD 1SLW      
  B16Z CAL ONES      ONES TO P,1-35
       TPL *+3       OK, SIGN PLUS
       TSX ERROR-1,4 ERROR, SIGN MINUS
       TRA B16Z      
       REM           
       SLW TEMP      SAVE ACC
       CAL TEMP      L SAVED ACC
       TPL *+3       OK-SIGN PLUS
       TSX ERROR-1,4 ERROR-SIGN MINUS
       TRA B16Z      
       REM           
       REM CHECK CONTENTS OF ACCUMULATOR
       REM           
       LBT           CHECK POSITION 35
       TRA *+2       ERROR-NO BIT IN 35
       TRA *+3       OK
       TSX ERROR-1,4 
       TRA B16Z      
       REM           
       ARS 1         CLEAR P
       CHS           MAKE SIGN MINUS
       SUB ONES      L - ONES
       TZE *+2       ACC OK
       TSX ERROR,4   ERROR
       TSX OK,4      
       TRA B16Z      
       REM           
       REM           
       BCD 1STP      STP TEST
 B17   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP      
       CLA KK33      L-252525525252
       STP TEMP      STP IN TEMP STORAGE
       CLA TEMP      BRING BACK, SIGN IS PLUS
       TPL B17+8     SHOULD BE PLUS
       TSX ERROR-1,4 
       TRA B17       
       REM           
       ALS 1         CHECK ACC POS 1
       PBT           SHOULD BE ONE
       TRA B17+12    ERROR IN ONE POS
       TRA B17+14    OK, PROCEED
       TSX ERROR-1,4 
       TRA B17       
       REM           
       TOV B17+17    OVFL SHOULD BE ON
       TSX ERROR-1,4 
       TRA B17       
       REM           
       ALS 1         CHECK ACC POS 2
       PBT           SHOULD BE ZERO
       TRA *+3       
       TSX ERROR-1,4 
       TRA B17       
       ALS 1         CLEAR Q
       TZE *+2       TEMP OK
       TSX ERROR,4   
       TSX OK,4      
       TRA B17       
       REM           
       REM           
       BCD 1STP      STP TEST
 B18   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP      
       CLA ZERO      BRING IN PLUS ZERO
       STP TEMP      STORE P, 1, 2, ZEROS
       CLA TEMP      BRING BACK TO ACC
       TPL B18+8     OK, SHOULD BE PLUS
       TSX ERROR-1,4 
       TRA B18       
       REM           
       ALS 1         CHECK ONE POSITION
       PBT           SHOULD BE ZERO
       TRA B18+13    OK, CHECK OVFL
       TSX ERROR-1,4 
       TRA B18       
       REM           
       TNO B18+16    OK, OVFL SHOULD BE OFF
       TSX ERROR-1,4 
       TRA B18       
       REM           
       ALS 1         CHECK TWO POSITION
       PBT           SHOULD BE ZERO
       TRA B18+21    OK, CHECK OVFL
       TSX ERROR-1,4 
       TRA B18       
       REM           
       TNO B18+23    OK, OVFL SHOULD BE OFF
       TSX ERROR,4   NO GOOD
       TSX OK,4      
       TRA B18       
       REM           
       REM           
       BCD 1STP      STP TEST
 B19   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP      
       CAL ONES      BRING IN ONES, CHECK POS
       ALS 1          P AND POS Q
       STP TEMP      STO IN TEMP STORAGE
       ARS 1         DID CLEAR Q POSITION
       PBT           
       TRA B19+9     NO GOOD, GOT ZERO
       TRA B19+11    CHECK SIGN
       TSX ERROR-1,4 
       TRA B19       
       REM           
       TPL B19+14    
       TSX ERROR-1,4 
       TRA B19       
       REM           
       CLA TEMP      BRING BACK CONTENTS OF
       REM           TEMP
       TMI B19+17    OK, GOT P POS IN STORAGE
       TSX ERROR,4   
       TSX OK,4      
       TRA B19       
       REM           
       REM           
       BCD 1STA      STA TEST
 B20   CLA RTN       SET UP ERROR TRA B20+7
       STO TEMP        IN STORAGE IF STA FAILS
       CLA RTN+1     SET UP ERROR TRA B20+5
       STA TEMP      PLACE IT IN STORAGE
       TRA TEMP      GO THERE AND MAKE TRANSFER
       SUB RTN+1     SEE IF ACC REMAINS SAME
       TZE B20+8     OK, CHECKS OUT
       TSX ERROR,4   
       TSX OK,4      
       TRA B20       
       REM           
       REM           
       BCD 1STA      STA TEST
 B21   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ZERO
       CLA ONES      ALL ONES
       STA TEMP      PLACE ONES IN TEMP STORE
       CLA TEMP      BRING IT TO ACC
       SUB 8CF       SUB 8CF
       TZE B21+8     OK
       TSX ERROR,4   
       TSX OK,4      
       TRA B21       
       REM           
       REM           
       BCD 1STA      STA TEST
 B22   CLA 8CF       INITIALIZE TEMP STORAGE
       STO TEMP        WITH ONES IN POS 21-35
       CLA ZERO      BRING ZERO INTO ACC
       STA TEMP      STA IN TEMP STORAGE
       CLA TEMP      BRING IT BACK
       TZE B22+7     OK, REPLACE ONES WITH
       REM             ZEROS
       TSX ERROR,4   
       TSX OK,4      
       TRA B22       
       REM           
       REM           
       BCD 1STD      STD TEST
 B23   CLA KK34      L+252525000000
       STO TEMP      SAVE ACC
       CLA KK32      L+000000252525
       STD TEMP      SAVE DECREMENT
       CLA TEMP      L SAVED LOCATION
       SUB PTW       L+2000000000
       TZE B23+8     OK, SHOULD GET ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B23       
       REM           
       REM           
       BCD 1STD      STD TEST
 B24   CLA 8CF       INITIALIZE TEMP STORAGE
       ALS 18        ALL ONES IN DECREMENT
       STO TEMP        FIELD
       CLA ZERO      BRING IN ZERO
       STD TEMP      STD WITH ZEROS.
       CLA TEMP      BRING BACK TEST FOR ZEROS
       TZE B24+8     OK
       TSX ERROR,4   
       TSX OK,4      
       TRA B24       
       REM           
       REM           
       BCD 1CAS      CAS TEST
 B25   CLA THREE     MAKE ACC GREATER THEN
       CAS TWO         STORAGE,SIGNS PLUS
       TRA B25+5     OK, PROCEED
       TRA B25+4     SHOULD NOT BE EQUAL
       TSX ERROR,4   SHOULD NOT BE LESS
       TSX OK,4      
       TRA B25       
       REM           
       REM           
       BCD 1CAS      CAS TEST
 B26   CLA TWO       MAKE ACC GREATER THEN
       CAS M3          STORAGE, SIGNS UNLIKE
       TRA B26+5     SHOULD NOT BE EQUAL
       TRA B26+4     SHOULD NOT BE LESS
       TSX ERROR,4   
       TSX OK,4      
       TRA B26       
       REM           
       REM           
       BCD 1CAS      CAS TEST
 B27   CLA M2        MAKE ACC GREATER THEN
       CAS M3          STORAGE, SIGNS MINUS
       TRA B27+5     OK, PROCEED
       TRA B27+4     SHOULD NOT BE EQUAL
       TSX ERROR,4   SHOULD NOT BE LESS
       TSX OK,4      
       TRA B27       
       REM           
       REM           
       BCD 1CAS      CAS TEST
 B28   CLA TWO       MAKE ACC LESS THAN
       CAS THREE       STORAGE, SIGNS PLUS
       TRA B28+3     SHOULD NOT BE GREATER
       TSX ERROR,4   SHOULD NOT BE EQUAL
       TSX OK,4      OK, PROCEED
       TRA B28       
       REM           
       REM           
       BCD 1CAS      CAS TEST
 B29   CLA M3        MAKE ACC LES THAN
       CAS TWO         STORAGE, SIGNS PLUS
       TRA B29+3     SHOULD NOT BE GREATER
       TSX ERROR,4   SHOULD NOT BE EQUAL
       TSX OK,4      OK, PROCEED
       TRA B29       
       REM           
       REM           
       BCD 1CAS      CAS TEST
 B30   CLA M3        MAKE ACC LES THAN
       CAS M2          STORAGE, SIGNS UNLIKE
       TRA B30+3     SHOULD NOT BE GREATER
       TSX ERROR,4   SHOULD NOT BE EQUAL
       TSX OK,4      OK, PROCEED
       TRA B30       
       REM           
       REM           
       BCD 1CAS      CAS TEST
 B31   CLA TWO       MAKE ACC EQUALS STORAGE,
       CAS TWO         SIGNS PLUS
       TRA B31+4     SHOULD NOT BE GREATER
       TRA B31+5     OK, PROCEED
       TSX ERROR,4   SHOULD NOT BE LESS
       TSX OK,4      
       TRA B31       
       REM           
       REM           
       BCD 1CAS      CAS TEST PLUS ZERO AND
       REM             MINUS ZERO
 B32   CLA ZERO      MAKE ACC GREATER THAN
       CAS MZE        STORAGE
       TRA B32+5     OK, PROCEED
       TRA B32+4     SHOULD NOT BE EQUAL
       TSX ERROR,4   SHOULD NOT BE LESS
       TSX OK,4      
       TRA B32       
       REM           
       REM           
       BCD 1CAS      CAS TEST-COMPARE ALL
       REM           ONES WITH ALL ONES
       REM           
 B32A  CLA ONES      L ONES
       CAS ONES      
       TRA B32A+4    ERROR
       TRA B32A+5    OK-PROCEED
       TSX ERROR,4   ERROR IN CAS WITH ONES
       TSX OK,4      
       TRA B32A      
       REM           
       REM           
       BCD 1LDQ      LDQ TEST
 B33   CLA ZERO      CLEAR ACC AND MQ TO START
       ARS 36        
       LDQ ONES      BRING IN ALL ONES TO MQ
       LLS           SHIFT SIGNS
       TMI B33+7     OK, SIGN IS MINUS
       TSX ERROR-1,4 
       TRA B33       
       REM           
       LLS 35        SHIFT ONES TO ACC
       TOV B33+9     TURN OFF OVFL
       ADD MONE      ADD MINUS ONE TO RIPPLE
       TOV B33+13    SHOULD OVFL
       TSX ERROR-1,4 
       TRA B33       
       REM           
       ALS 2         REMOVE P AND Q POSITION
       TZE B33+16    OK, SHOULD GET ZERO NOW
       TSX ERROR,4   
       TSX OK,4      
       TRA B33       
       REM           
       REM           
       BCD 1STQ      STQ TEST
 B34   LDQ ONES      BRING ALL ONES TO MQ
       STQ TEMP      PLACE IN TEMP STORAGE
       CLA TEMP      BRING IN ACC
       TMI B34+6     OK, SIGN IS MINUS
       TSX ERROR-1,4 
       TRA B34       
       REM           
       TOV B34+7     TURN OFF OVFL
       ADD MONE      ADD MINUS ONE TO RIPPLE
       TOV B34+11    SHOULD OVFL
       TSX ERROR-1,4 
       TRA B34       
       REM           
       ALS 2         REMOVE P AND Q POSITION
       TZE B34+14    SHOULD GET ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B34       
       REM           
       REM           
       BCD 1STQ      
 B35   LDQ ZERO      BRING IN ALL ZEROS TO MQ
       STQ TEMP      PLACE IN TEMP STORAGE
       CLA TEMP      BRING IN ACC
       TZE B35+5     OK, SHOULD BE ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B35       
       REM           
       REM           
       BCD 1SLQ      SLQ TEST
 B36   CLA ZERO      MAKE ACC AND TEMP STORAGE
       STO TEMP        ALL ZEROS
       LDQ ONES      MAKE MQ ALL ONES
       SLQ TEMP      PLACE S, 1-17 IN TEMP STORAGE
       CLA TEMP      BRING BACK TO ACC
       TMI B36+8     SHOULD BE MINUS
       TSX ERROR-1,4 
       TRA B36       
       REM           
       TOV B36+9     TURN OFF OVFL
       ALS 1         SHIFT TO P POS UNTIL ONLY
       TOV B36+9       BIT LEFT IN Q
       TNZ B36+14    OK, SHOULD NOT GET ZERO
       TSX ERROR-1,4 
       TRA B36       
       REM           
       ALS 2         OK, SHOULD BE ZERO
       TNO B36+17    OK, SHOULD NOT GET EXTRA
       REM             BITS
       TSX ERROR,4   
       TSX OK,4      
       TRA B36       
       REM           
       REM           
       BCD 1SLQ      SLQ TEST
 B37   LDQ ZERO      BRING ZEROS TO MQ
       CLA ONES      PLACE ONES IN TEMP STORAGE
       STO TEMP      
       SLQ TEMP      PLACE ZEROS IN S, 1-17
       CLA TEMP        OF ACC
       ARS 18        SHIFT ONES OUT
       TZE B37+8     OK, RESET SHOULD BE ZEROS
       TSX ERROR,4   
       TSX OK,4      
       TRA B37       
       REM           
       REM           
       BCD 1TLQ      TLQ TEST
 B38   CLA TWO       MQ LESS THAN ACC
       LDQ M3        MQ MINUS 3 ACC PLUS 2
       TLQ B38+4     OK, SHOULD TRANSFER
       TSX ERROR,4   
       TSX OK,4      
       TRA B38       
       REM           
       REM           
       REM           
       BCD 1TLQ      TLQ TEST
 B39   CLA M3        MQ GREATER THEN ACC
       LDQ M2        MQ MINUS 2 ACC MINUS 3
       TLQ B39+4     SHOULD NOT TRANSFER
       TRA B39+5     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B39       
       REM           
       REM           
       BCD 1TLQ      TLQ TEST
 B40   CLA TWO       MQ EQUALS ACC
       LDQ TWO       BOTH PLUS TWO
       TLQ B40+4     SHOULD NOT TRANSFER
       TRA B40+5     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B40       
       REM           
       REM           
       BCD 1TLQ      TLQ TEST
 B41   CLA ZERO      MQ LESS THEN ACC
       LDQ MZE       MQ MINUS 0 ACC PLUS 0
       TLQ B41+4     OK, SHOULD TRANSFER
       TSX ERROR,4   
       TSX OK,4      
       TRA B41       
       REM           
       REM           
       BCD 1TLQ      TLQ TEST
 B42   CLA MZE       MQ GREATER THEN ACC
       LDQ ZERO      MQ PLUS 0 ACC MINUS 0
       TLQ B42+4     SHOULD NOT TRANSFER
       TRA B42+5     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B42       
       REM           
       REM           
       BCD 1RND      RND TEST
 B43   CLA ZERO      CLEAR ACC
       LDQ PTW       PLACE BIT IN MQ 1 POS
       RND           ROUND SHOULD GO TO ACC
       LBT             POS 35, IS IT THERE
       TSX ERROR,4   NO, ERROR
       TSX OK,4      YES, OK
       TRA B43       
       REM           
       REM           
       BCD 1MPY      MPY TEST
 B44   CLA PONES     PLACE ALL ONES IN ACC
       ALS 2         PLACE ONES IN P AND Q
       LDQ ZERO      MULTPLY ZERO BY ZERO
       MPY ZERO      CHECK ACC AND MQ FOR ZERO
       TZE B44+7     OK, SHOULD BE ZERO
       TSX ERROR-1,4 
       TRA B44       
       REM
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING TO ACC TO CHECK
       TZE B44+11    OK, SHOULD BE ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B44       
       REM           
       REM           
       BCD 1MPY      MPY TEST
 B45   LDQ ONE       MULTIPLY ONE BY ONE
       MPY ONE       SHOULD GET ZERO IN ACC
       TZE B45+5     OK, PROCEED
       TSX ERROR-1,4 
       TRA B45       
       REM           
       STQ TEMP      SAVE MQ AND CHECK
       CLA TEMP      FOR ONE IN ACC 34
       TNZ B45+10    OK, PROCEED
       TSX ERROR-1,4 
       TRA B45       
       REM           
       ARS 2         SHIFT OVER
       TZE B45+13    OK, CHECKS OUT
       TSX ERROR,4   
       TSX OK,4      
       TRA B45       
       REM           
       REM           
       BCD 1MPY      MPY TEST
 B46   LDQ PONES     MULTIPLY ALL ONES
       MPY ONE       BY ONE
       TZE B46+5     OK, ACC SHOULD BE ZERO
       TSX ERROR-1,4 
       TRA B46       
       REM           
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING IT TO ACC
       TOV B46+7     TURN OFF OVFL
       ADD ONE       ADD ONE TO TURN ON OVFL
       TOV B46+11    OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B46       
       REM           
       REM           
       BCD 1MPY      MPY TEST
 B47   LDQ PONES     MULTIPLY ALL ONES
       MPY PONES       BY ALL ONES
       ADD ONE       ADD ONE, 2-35 HAVE ONES
       TOV B47+4     SET OVFL
       ADD ONE       RIPPLE CARRY FOR ACC
       TOV B47+8     OK, DID RIPPLE
       TSX ERROR-1,4 
       TRA B47       
       REM           
       STQ TEMP      SAVE MQ
       CLA TEMP      BRING IT TO ACC
       SUB ONE       SUB ONE
       TZE B47+13    SHOULD TRANSFER
       TSX ERROR,4   
       TSX OK,4      
       TRA B47       
       REM           
       REM           
       BCD 1MPY      MPY TEST
 B48   LDQ ZERO      MULTIPLY PLUS NUMBER BY
       MPY ZERO        PLUS, PRODUCT IS PLUS
       TPL B48+5     OK, ACC IS PLUS
       TSX ERROR-1,4 
       TRA B48       
       REM           
       TQP B48+7     OK, MQ IS PLUS
       TSX ERROR,4   
       TSX OK,4      
       TRA B48       
       REM           
       REM           
       BCD 1MPY      MPY TEST
 B49   LDQ MZE       MULTIPLY MINUS NUMBER BY
       MPY MZE         MINUS NUMBER, CHECK SING
       TPL B49+5     OK, ACC IS PLUS
       TSX ERROR-1,4 
       TRA B49       
       REM           
       TQP B49+7     OK, MQ IS PLUS
       TSX ERROR,4   
       TSX OK,4      
       TRA B49       
       REM           
       REM           
       BCD 1MPY      MPY TEST
 B50   LDQ MZE       MULTIPLY MQ MINUS BY
       MPY ZERO        A PLUS, CHECK SIGN
       TMI B50+5     ACC SHOULD BE MINUS
       TSX ERROR-1,4 
       TRA B50       
       REM           
       TQP B50+7     MQ SHOULD BE MINUS
       TRA B50+8     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B50       
       REM           
       REM           
       BCD 1MPY      MPY TEST
 B51   LDQ ZERO      MULTIPLY MQ PLUS BY
       MPY MZE         MINUS
       TMI B51+5     ACC IS MINUS
       TSX ERROR-1,4 
       TRA B51       
       REM           
       TQP B51+7     
       TRA B51+8     MQ IS MINUS
       TSX ERROR,4   
       TSX OK,4      
       TRA B51       
       REM           
       REM           
       BCD 1MPR      MPR TEST
 B52   LDQ PTW       MULTIPLY +200---BY ONE
       MPR ONE       SHOULD ROUND TO ACC
       TNZ B52+5     OK, DID ROUND
       TSX ERROR-1,4 
       TRA B52       
       REM           
       ARS 1         OK, NOW MOVE BIT OUT
       TZE B52+8     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B52       
       REM           
       REM           
       BCD 1MPR      MPR TEST
 B53   LDQ PTW       MULTIPLY PLUS TWO BY
       MPR ZERO        ZERO SHOULD NOT ROUND
       TZE B53+5     OK, IN ACC CHECK SIGN
       TSX ERROR-1,4 
       TRA B53       
       REM           
       TPL B53+8     OK, PROCEED
       TSX ERROR-1,4 
       TRA B53       
       REM           
       TQP B53+10    OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B53       
       REM           
       REM           
       BCD 1MPR      MPR TEST
 B54   LDQ MTW       MULTIPLY MINUS TWO BY
       MPR ZERO        ZERO, CHECK SIGNS
       TPL B54+4     ERROR
       TRA B54+6     OK, PROCEED
       TSX ERROR-1,4 
       TRA B54       
       REM           
       TQP B54+8     ERROR, SHOULD BE MINUS
       TRA B54+9     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B54       
       REM           
       REM           
       BCD 1MPR      MPR TEST
 B54A  TOV B54A+1    TURN OFF OVFL
       LDQ PONES     ALL ONES IN MQ
       MPR PTW       ACC 1-35 ALL ONES
       SUB PTW       MQ 1, A ONE, FORCE ROUND
       TZE B54A+7    SHOULD BE ZERO
       TSX ERROR-1,4 
       TRA B54A      
       REM           
       TNO B54A+9    SHOULD NOT BE OVFL
       TSX ERROR,4   
       TSX OK,4      
       TRA B54A      
       REM           
       REM           
       BCD 1DVP      DVP TEST
 B55   LDQ TWO       DIVIDEND PLUS TWO
       CLA ZERO      DIVIDE BY ONE SHOULD
       DVP ONE         GET A PLUS TWO IN MQ
       TPL B55+6     OK, PROCEED
       TSX ERROR-1,4 WRONG SIGN
       TRA B55       
       REM           
       TZE B55+9     REMAINDER SHOULD BE ZERO
       TSX ERROR-1,4 
       TRA B55       
       REM           
       STQ TEMP      SAVE CONTENTS OF MQ
       CLA TEMP      BRING TO ACC
       SUB TWO       SUB TWO TO GET ZERO
       TZE B55+14    OK PROCEED
       TSX ERROR,4   SHOULD NOT BE 2 IN ACC
       TSX OK,4      
       TRA B55       
       REM           
       REM           
       BCD 1DVP      DVP TEST
 B56   CLA ZERO      CLEAR ACC
       LDQ ONES      DIVIDE ALL ONES IN MQ
       DVP MTW         BY -200...
       TPL B56+6     OK, SHOULD BE PLUS
       TSX ERROR-1,4 
       TRA B56       
       REM           
       STO TEMP      SAVE ACC AND MQ
       STQ TEMP+1    
       TQP B56+10    ERROR
       TRA B56+12    MQ SHOULD BE MINUS
       TSX ERROR-1,4 
       TRA B56       
       REM           
       CLA TEMP+1    ZEROS TO ACC
       SUB TEMP      SUB ONES FROM ACC
       TOV B56+15    TURN OFF OVFL
       ALS 1         SHOULD GET OVFL
       TOV B56+18    OK, GET OVFL
       TSX ERROR,4   ERROR
       TSX OK,4      
       TRA B56       
       REM           
       REM           
       BCD 1DCT      DCT TEST
 B57   DCT           INITIALIZE THE
       TRA B57+2       DCT INDICATOR
       DCT           TEST INDICATOR OFF
       TRA B57+5     INDICATOR NOT OFF
       TRA B57+7     
       TSX ERROR-1,4 
       TRA B57       
       REM           
       CLA ZERO      PLACE ZERO IN ACC
       LDQ PTW       MAKE MQ +200... DIVIDE
       DVP PTW         BY +200...
       DCT           TEST INDICATOR OFF
       TSX ERROR,4   IF ON, DID NOT SHOW
       TSX OK,4      
       TRA B57       OK, PROCEED
       REM           
       REM           
       BCD 1DCT      DCT TEST
 B58   CLA PTW       DIVIDE +200... BY -100...
       DVP MON       CHECK INDICATOR SHOULD
       REM             BE ON
       DCT           TEST INDICATOR ON
       TRA B58+5     OK, PROCEED
       TSX ERROR,4   ENTERS HERE ON ERROR
       TSX OK,4      
       TRA B58       
       REM           
       REM           
       BCD 1DVP      DIVIDE A ONE IN EACH
 B58A  CLA ONE       POSITION BY ZERO
       STO TEMP      
       DVP ZERO      
       SUB TEMP      CHECK THAT ACC DID NOT
       TZE B58A+7    CHANGE
       TSX ERROR-1,4 
       TRA B58A      
       REM           CHECK DIVIDE CHECK LIGHT
       DCT           SHOULD BE ON
       TRA B58A+11   OK, PROCEED
       TSX ERROR-1,4  NO DIVIDE CHECK
       TRA B58A      
       REM           
       ALS 1         MOVE ACROSS ACC
       TNZ B58A+1    BY ONE
       TSX OK,4      
       TRA B58A      
       REM           
       REM           
       BCD 1DVH      DVH TEST, NO HALT
 B62   LDQ PTW       MAKE MQ POSITIVE
       CLA ZERO      MAKE ACC ZERO
       DVH PTW       DIVIDE
       TPL B62+6     OK, PROCEED
       TSX ERROR-1,4 
       TRA B62       
       REM           
       TOV B62+7     TURN OFF OVFL
       TZE B62+10    
       TSX ERROR-1,4 
       TRA B62       
       REM           
       STQ TEMP      SAVE MQ, ADD IT TO ACC
       CLA TEMP      
       TNZ B62+15    OK, PROCEED
       TSX ERROR-1,4 
       TRA B62       
       REM           
       LBT           CHECK POS 35 FOR ONE
       TRA B62+18    ERROR, GOT A ZERO
       TRA B62+20    OK, PROCEED
       TSX ERROR-1,4 
       TRA B62       
       REM           
       ARS 1         OK, SHIFT IT OUT
       TZE B62+23    OK, ALL SHOULD BE ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B62       
       REM           
       REM           
       BCD 1DVH      DVH TEST, NO HALT
 B63   CLA ZERO      MAKE ACC ZERO
       LDQ ONES      MAKE MQ ALL ONES
       DVH MTW       DIVIDE BY -200...
       TPL B63+6     OK, PROCEED
       TSX ERROR-1,4 
       TRA B63       
       REM           
       STO TEMP      SAVE AC AND MQ
       STQ TEMP+1    
       TQP B63+10    ERROR IN MQ SIGN
       TRA B63+12    OK, IS MINUS, PROCEED
       TSX ERROR-1,4 
       TRA B63       
       REM           
       CLA TEMP+1    SUB ACC FROM MQ
       SUB TEMP      
       TOV B63+15    TURN OFF OVFL
       LLS 1         SHIFT ONE BIT
       TOV B63+18    OK, SHOULD BE ON
       TSX ERROR,4   
       TSX OK,4      
       TRA B63       
       REM           
       REM           
       BCD 1ANA      ANA TEST
 B64   CAL MZE       MAKE ACC MINUS ZERO
       ANA ONES      /AND/ TO ALL POSITIONS
       REM             ZERO EXCEPT POS P
       PBT           P SHOULD HAVE BIT
       TRA B64+5     ERROR, NO BIT IN POS P
       TRA B64+7     OK, PROCEED
       TSX ERROR-1,4 
       TRA B64       
       REM           
       ARS 1         OK, NOW POS Q SHOULD BE
       REM             ZERO
       PBT           SHIFT AND TEST
       TRA B64+12    OK, PROCEED
       TSX ERROR-1,4 
       TRA B64       
       REM           
       TPL B64+14    OK, SHOULD BE PLUS
       TSX ERROR,4   
       TSX OK,4      
       TRA B64       
       REM           
       REM           
       BCD 1ANA      ANA TEST
 B65   CAL ONES      PLACE ALL ONES IN ACC
       ANA ONES      /AND/ TO ALL ONES
       ADD ONE       ADD ONE, CAUSE RIPPLE
       ALS 1         MOVE OUT Q
       TZE B65+6     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B65       
       REM           
       REM           
       BCD 1ANA      ANA TEST
 B66   CAL ZERO      PLACE ZEROS IN ACC
       ANA ONES      /AND/ TO ALL ZEROS
       TZE B66+4     OK, NO PICK UP
       REM           
       TSX ERROR,4   
       TSX OK,4      
       TRA B66       
       REM           
       REM           
       BCD 1ANA      ANA TEST
 B67   CAL KK30      L-252525252525
       ANA KK31      L-125252252525
       SUB KK32      L+000000252525
       PBT           TEST P FOR BIT
       TRA B67+6     ERROR
       TRA B67+8     OK, PROCEED AND MOVE IT OUT
       TSX ERROR-1,4 
       TRA B67       
       REM           
       ALS 2         ALL RIGHT MOVE IT OUT
       TZE B67+11    OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B67       
       REM           
       REM           
       BCD 1ANA      ANA TEST
 B68   CLA KK30      L-252525252525
       ANA KK33      L-252525525252
       SUB KK34      L+252525000000
       TZE B68+5     OK, SHOULD BE ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B68       
       REM           
       REM           
       BCD 1ANS      ANS TEST
 B69   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ZERO
       CAL ONES      PLACE ALL ONES IN ACC
       ANS TEMP      /AND/ TO ZERO STORAGE
       CLA TEMP      BRING RESULT TO ACC
       TZE B69+8     SHOULD BE ZERO, CHECK SIGN
       TSX ERROR-1,4 
       TRA B69       
       REM           
       TPL B69+10    OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B69       
       REM           
       REM           
       BCD 1ANS      ANS TEST
 B70   CLA ONES      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ALL ONES
       CAL ZERO      MAKE ACC ZERO
       ANS TEMP      /AND/ TO ONES IN STORAGE
       CLA TEMP      BRING RESULT TO ACC
       TZE *+2       OK, ALL SHOULD BE ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B70       
       REM           
       REM           
       BCD 1ANS      
  B70Z CLA ONES      L ONES IN S,1-35
       STO TEMP      
       CLA MTW       L -2000000000
       ALS 2         BIT ONLY IN S AND Q
       ANS TEMP      CLEAR TEMP STG LOCATION
       REM           
       REM CHECK Q BIT NOT LOST BY ANS
       REM           
       ARS 1         MOVE BIT TO P
       PBT           CHECK FOR BIT
       TRA *+2       ERROR-LOST Q BIT
       TRA *+3       OK
       TSX ERROR-1,4 
       TRA B70Z      
       REM           
       REM CHECK SIGN NOT LOST BY ANS
       REM           
       TMI *+3       OK-SIGN REMAINED MINUS
       TSX ERROR-1,4 
       TRA B70Z      
       REM           
       REM CHECK TEMP 
       CAL TEMP      
       TZE *+2       OK-TEMP STG LOC PLUS ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B70Z      
       REM           
       REM           
       BCD 1ANS      ANS TEST WITH SIGNS UNLIKE
 B71   CLA KK30      INITIALIZE STORAGE WITH
       STO TEMP        -252525252525
       CAL KK35      MAKE ACC +1252522522525
       ANS TEMP      /AND/, THEN CHECK ACC
       SUB KK35      SUB ORIGINAL CONTENTS
       TZE B71+8     OK, PROCEED CHECK STORAGE
       TSX ERROR-1,4 
       TRA B71       
       CLA TEMP      CHECK STORAGE SHOULD
       SUB KK32      BE L+000000252525
       TZE B71+12    OK, IT WAS, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B71       
       REM           
       REM           
       BCD 1ORA      ORA TEST
 B72   CLA ZERO      MAKE ACC ZERO
       ORA ONES      /OR/ WITH ONES
       PBT           CHECK P FOR ONE
       TRA B72+5     ERROR IN P
       TRA B72+7     CHECK OTHER POSITIONS
       TSX ERROR-1,4 
       TRA B72       
       REM           
       ADD ONE       CHECK OTHER POSITIONS
       ALS 2         CLEAR P AND Q
       TZE B72+11    OK, SHOULD BE ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B72       
       REM           
       REM           
       BCD 1ORA      
  B72X CLA ONES      L -377777777777
       ORA ZERO      SHOULD NOT CHANGE ACC
       TMI B72X1     SHOULD TRANSFER
       TSX ERROR-1,4 ERROR
       TRA B72X      
       REM           
 B72X1 ADD PONES     CHECK ACC P,1-35
       TZE *+2       OK
       TSX ERROR,4   ERROR
       TSX OK,4      
       TRA B72X      
       REM           
       REM           
       BCD 1ORA      ORA TEST
 B73   CAL ONES      MAKE ACC POS P-35 ONES
       ORA ZERO        /OR/ WITH ZEROS
       PBT           CHECK P FOR ONE
       TRA B73+5     ERROR IN P
       TRA B73+7     PROCEED
       TSX ERROR-1,4 
       TRA B73       
       REM           
       ADD ONE       OK, TEST POS 1-35
       ALS 2         MOVE OUT P AND Q
       TZE B73+11    OK, SHOULD BE ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B73       
       REM           
       REM           
       BCD 1ORA      ORA TEST, SIGNS UNLIKE
 B74   CLA KK36      MAKE ACC +252525252525
       ORA KK33      /OR/ -252525525252
       SUB KK37      SUB 252525777777
       PBT           CHECK P FOR ONE
       TRA B74+6     ERROR IN P
       TRA B74+8     OK, PROCEED
       TSX ERROR-1,4 
       TRA B74       
       REM           
       REM           
       ALS 2         MOVE OUT P AND Q
       TZE B74+11    OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B74       
       REM           
       REM           
       BCD 1ORA      ORA TEST, SIGNS PLUS
 B75   CLA KK36      MAKE ACC 252525252525
       ORA KK35      /OR/ +125252252525
       SUB KK38      SUB 377777252525
       TZE B75+5     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B75       
       REM           
       REM           
       BCD 1ORS      ORS TEST
 B76   CLA ONES      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ONES
       CLA ZERO      MAKE ACC ZERO
       ORS TEMP      /OR/ TO ONES
       TZE B76+7     ACC SHOULD BE ZERO
       TSX ERROR-1,4 ERROR IN ACC
       TRA B76       
       REM           
       CLA TEMP      BRING BACK STORAGE
       ADD MONE      ADD MINUS ONE TO RIPPLE
       PBT           P SHOULD HAVE BIT
       TSX ERROR,4   ERROR, NO BIT IN POS P
       TSX OK,4      OK, PROCEED
       TRA B76       
       REM           
       REM           
       BCD 1ORS      ORS TEST
 B77   CLA ZERO      INITIALIZE TEMP STORAGE
       STO TEMP        WITH ZEROS
       CAL ONES      CAL ALL ONES P-35
       ORS TEMP      /OR/ TO ZEROS
       ADD ONE       CHECK ACC, ADD ONE, SHOULD
       PBT             NOT GET A BIT IN P
       TRA B77+9     OK, NOW CHECK STORAGE
       TSX ERROR-1,4 ERROR, BIT IN P
       TRA B77       
       REM           
       CLA TEMP      OK, NOW CHECK STORAGE
       ADD MONE      ADD MINUS ONE TO RIPPLE
       TOV B77+13    OK, SHOULD OVERFLOW
       TSX ERROR,4   NO, NOT ZERO
       TSX OK,4      YES, PROCEED
       TRA B77       
       REM           
       REM           
       BCD 1ORS      ORA TEST, SIGNS UNLIKE
 B78   CLA KK36      INITIALIZE TEMP STORAGE
       STO TEMP        WITH 252525252525
       CLA KK33      MAKE ACC-252525525252
       ORS TEMP      /OR/ TO TEMP STORAGE
       CLA TEMP      BRING TEMP TO ACC
       SUB KK37      SUB 252525777777
       TZE B78+8     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B78       
       REM           
       REM           
       BCD 1ORS      ORS TEST
 B79   CLA KK36      INITIALIZE TEMP STORAGE
       STO TEMP        WITH +25252525252
       CAL KK31      MAKE P-35, -12525222525
       ORS TEMP      /OR/ TO TEMP STORAGE
       CLA TEMP      BRING IT TO ACC
       ADD KK38      ADD 3777777252525
       TZE B79+8     OK, SHOULD BE ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B79       
       REM           
       REM           
       BCD 1TTR      TTR TEST , NOT IN TRAP MODE
 B80   TOV B80+1     TURN OFF OVFL
       REM           
       TTR B80+3     SHOULD TRAP TRANSFER
       TSX ERROR,4   DID NOT TRANSFER
       TSX OK,4      
       TRA B80       
       REM           
       BCD 1ETM-     ETM- TEST TO SEE IF GET
 B81   ETM             IN TRAP MODE
       CLA KK85      MAKE ADR AT ONE A TTR
       STO 1           TO B82
       CLA ZERO      CONDITION WILL BE MET
       TZE B81+5       AND SHOULD GO TO ONE
       LTM           
       TSX ERROR,4   
       TSX OK,4      PROCEED TO B82
       TRA B81       
       REM           
       REM           
       BCD 1ETM-     TTR TEST, IN TRAP MODE
 B82   ETM           
       TTR B83       SHOULD TTR TO B83
       LTM           
       TSX ERROR,4   DID NOT TRAP TRANSFER
       TSX OK,4      
       TRA B82       
       REM           
       REM           
       REM           
       BCD 1ETM-     YES TRA IN TRAP MODE
 B83   ETM           
       CLA KK80      TTR TO B83+9, IS RETURN
       STO 1           ADDRESS AFTER TRAP.
       CLA KK81      HTR B84 IS IN ZERO, IF
       STO 0           INSTRUCTION COUNTER FAILS
       TRA B83+6     SHOULD NOT TRANSFER
       REM           
       LTM           
       TSX ERROR-1,4 TRAP FAILS, TRANSFERS
       TRA B83       
       LTM           SHOULD TRAP AND RETURN HERE
       CLA 0         CHECK ADDRESS AT ZERO
       SUB KK82      SUB THE ADDRESS OF TRAP
       TZE B83+14    OK, SHOULD BE EQUAL
       TSX ERROR,4   
       TSX OK,4      
       TRA B83       
       REM           
       REM           
       BCD 1ETM-     TEST CONDITIONAL TRANSFERS,
       REM             CONDITIONS NOT MET.
       REM             ADDRESS OF ERROR IS IN
 B84   ETM             00000 OR TRAP ON PRINTOUT
       CLA KK83      LOC 1 SET TO TTR B84A
       STO 1         SHOULD BE NO TRANSFERS
       LDQ 8CF       MAKE MQ LARGER THAN ACC
       CLM           SET ACC TO ZERO AND SET
       STO 0           LOC 0 TO ZERO
       TNZ B84C      
       TMI B84C      
       TOV B84C      
       TLQ B84C      
       LXA ZERO,1    LOAD INDEX A WITH ZERO
       TXH B84C,1    
       TIX B84C,1,8  
       CLA ONES      LOAD ACC WITH ONES
       TZE B84C      
       TPL B84C      
       ALS 12        FORCE OVFL
       TNO B84C      
       LXA 8CF,1     LOAD INDEX A WITH 77777
       TNX B84C,1,1  
       TXL B84C,1,1  
       LDQ MZE       LOAD MQ WITH MINUS ZERO
       TQP B84C      
       TQP B84C      RETEST TO SEE IF TEST IS
       REM             COMPLETE. IF TRAP OCCURS,
       REM             COMES BACK HERE
       REM           
 B84A  LTM           LEAVES TRAP MODE
       CLA 0         CHECK ADDRESS AT ZERO
       SUB KK86      IS TEST COMPLETE
       TZE B84A+5    YES PROCEED
       TSX ERROR,4   NO, ERROR ABOVE, CHECK
       REM             ZERO ADDRESS
       TSX OK,4      
       TRA B84       
       REM           
       REM           
       BCD 1ETM-     
 B84B  TRA B85       
       REM           
 B84C  LTM           IF TRANSFER IS WRONG,
       TSX ERROR,4     COMES HERE
       TSX OK,4      
       TRA B84       
       REM           
       REM           TEST CONDITIONAL TRANSFERS
       REM             WITH CONDITIONALS SATISFIED
       REM           
       BCD 1ETM-     THIS IS SET UP FOR
 B85   ETM             TRAP RETURN
       CLA KK85A     INITIALIZE TEMP STORAGE
       REM           WITH LOC OF FIRST COND
       REM           TRANSFER
       STO TEMP      
       CLA KK84      TTR B85+6
       STO 1         
       TTR B85+15    OK, START TESTS
       CLA 0         RETURN FROM LOC 1
       CAS TEMP      COMPARE ACC AND TEMP
       TTR B85B      IF TEMP LESS THEN ZERO
       TTR B85+11    IF TEMP EQUAL TO ZERO
       TTR B85B      IF TEMP GRATER THEN ZERO
       ADD TWO       NOW ADVANCE TWO POSITIONS
       STA B85+14      SO AS TO CONTINUE TO THE
       REM             NEXT SUBTEST
       STA TEMP      RESET ADDRESS OF TEMP
       TTR 0         GO TO RESPECTIVE SECTION
       REM           
       REM           
       ALS 50        CLEAR ACC
       TZE B85A      TZE TEST
       TTR B85A      
       TPL B85A      TPL TEST
       TTR B85A      
       TOV B85A      TOV TEST
       TTR B85A      
       TNO B85A      
       TTR B85A      TNO TEST
       LTM           TEST IS FINISED NOW
       TRA B86         GO TO NEXT SECTION
       REM           
 B85A  LTM           COMES HERE ON EROR
       TSX ERROR-1,4 ERROR, DID NOT TRAP
       TRA B85       
       REM           
       TRA B86       CONTINUE TEST
       REM           
       REM           COMES HERE IF ADDRESS AT
       REM           ZERO IS INCORRECT
 B85B  LTM           
       TSX ERROR-1,4 NOT JUMPING PROPERLY
       TRA B85       
       REM           
       REM           
 B86   ETM           
       CLA KK85B     
       STO TEMP      
       REM           INITIALIZE TEMP STORAGE
       REM           WITH LOC OF FIRST COND
       REM           TRANSFER
       CLA ONES      BRING IN ALL ONES
       TMI B86A      TMI TEST
       TTR B86A      
       TNZ B86A      TNZ TEST
       TTR B86A      
       LTM           TEST IS FINISHED NOW
       TRA B87         GO TO NEXT SECTION
       REM           
 B86A  LTM           COMES HERE ON ERROR
       TSX ERROR-1,4 ERROR, DID NOT TRAP
       TRA B85       
       REM           
       REM           
 B87   ETM           TEST TQP, CONDITION
       CLA KK85C       SATISFIED
       STO TEMP      
       REM           INITIALIZE TEMP STORAGE
       REM           WITH LOC OF FIRST COND
       REM           TRANSFER
       LDQ ONE       LOAD MQ POS 35 WITH ONE
       TQP B87A      TEST TQP
       TTR B87A      
       LTM           TEST IS FINISHED NOW
       TRA B88         GO TO NEXT SECTION
       REM           
 B87A  LTM           
       TSX ERROR-1,4 ERROR, DID NOT TRAP
       TRA B85       
       REM           
       REM           CHECK ADDRESS AT ZERO
       REM             FOR LOCATION OF LAST INST
 B88   ETM             PREFORMED CORRECTLY
       CLA KK85D     INITIALIZE TEMP STORAGE
       STO TEMP        WITH LOC OF FIRST COND
       REM             TRANSFER
       TXI B88A,1,9  TXI TEST
       TTR B88A      
       TXH B88A,1    TXH TEST
       TTR B88A      
       TXL B88A      TXL TEST
       TTR B88A      
       TIX B88A,1,1  TIX TEST
       TTR B88A      
       TNX B88A,1,-1  TNX TEST
       TTR B88A      
       TSX B88A,1    TSX TEST
       TTR B88A      
       LTM           TEST IS FINISHED
       TRA B88A+2      GO TO NEXT SECTIONS
       REM           
 B88A  LTM           COMES HERE ON ERROR
       TSX ERROR,4   ERROR, DID NOT TRAP
       TSX OK,4      
       TRA B85       
       REM           
       NOP           
       REM           
       TSX STORE,4   
       TRA *+2       
       REM           
       REM           
       BCD 1SLT      PSE TEST
 B89   SLF           TURN OFF ALL SENSE LIGHTS
       SLT 1         TEST LIGHT ONE
       TRA B90       OK, OFF
       TSX ERROR-1,4 ERROR, LIGHT WAS ON
       TRA B89       
       REM           
 B90   SLT 2         TEST LIGHT TWO
       TRA B91       OK, PROCEED
       TSX ERROR-1,4 ERROR, LIGHT WAS ON
       TRA B89       
       REM           
 B91   SLT 3         TEST LIGHT THREE
       TRA B92       OK, PROCEED
       TSX ERROR-1,4 ERROR, LIGHT WAS ON
       TRA B89       
       REM           
 B92   SLT 4         TEST LIGHT FOUR
       TRA B92+3     OK, PROCEED
       TSX ERROR,4   ERROR, LIGHT WAS ON
       TSX OK,4      
       TRA B89       
       REM           
       REM           
       BCD 1SLT 1    PSE TEST
 B93   SLN 1         TURN ON LIGHT ONE
       SLT 1         TEST LIGHT ONE
       TSX ERROR,4   ERROR, IT WAS NOT ON
       TSX OK,4      OK, PROCEED
       TRA B93       
       REM           
       BCD 1SLT 2    PZE TEST
 B94   SLN 2         TURN ON LIGHT TWO
       SLT 2         TEST LIGHT TWO
       TSX ERROR,4   ERROR, IT WAS NOT ON
       TSX OK,4      OK, PROCEED
       TRA B94       
       REM           
       REM           
       BCD 1SLT 3    PZE TEST
 B95   SLN 3         TURN ON LIGHT THREE
       SLT 3         TEST LIGHT THREE
       TSX ERROR,4   ERROR, IT WAS NOT ON
       TSX OK,4      OK, PROCEED
       TRA B95       
       REM           
       REM           
       BCD 1SLT 4    PZE TEST
 B96   SLN 4         TURN ON LIGHT FOUR
       SLT 4         TEST LIGHT FOUR
       TSX ERROR,4   ERROR, IT WAS NOT ON
       TSX OK,4      OK, PROCEED
       TRA B96       
       REM           
       REM           
       BCD 1SLT      MSE TEST, TEST ALL LIGHTS
       REM           ARE OUT
 B93A  SLT 1         TEST LIGHT ONE
       TRA B93A+4    SHOULD BE OFF
       TSX ERROR-1,4 
       TRA B93A      
       REM           
       SLT 2         TEST LIGHT TWO
       TRA B93A+8    SHOULD BE OFF
       TSX ERROR-1,4 
       TRA B93A      
       REM           
       SLT 3         TEST LIGHT THREE
       TRA B93A+12   SHOULD BE OFF
       TSX ERROR-1,4 
       TRA B93A      
       REM           
       SLT 4         TEST LIGHT FOUR
       TRA B93A+15   SHOULD BE OFF
       TSX ERROR,4   
       TSX OK,4      
       TRA B93A      
       REM           
       BCD 1NOP      NOP TEST TO SEE IF NOP IS
 B96A  SLF             INTERPRETED AS PSE 97
       NOP 97        
       SLT 1         TEST LIGHT ONE
       TRA B96A+5    
       TSX ERROR,4   
       TSX OK,4      
       TRA B96A      
       REM           
       REM           
       BCD 1SWT      SENSE SWITCH TEST
 B98   CLA KK87      PLACE TRA B98A+1 IN B98A
       STO B98A        FOR FIRST TIME THROUGH,
       REM             CHANGES ON SECOND TIME
       REM             THROUGH, EACH SWITCH IS
       REM             REPRESENTED IN MQ AND ACC
       REM             BY GROUP OF SIX BITS
       CLA ZERO      CLEAR ACC
       SWT 1         SW 1
       TRA B98+6     DOWN L -370000000000
       CLA SW1       UP
       SWT 2         SW 2
       TRA B98+9     DOWN L+007700000000
       ORA SW2       UP
       SWT 3         SW 3
       TRA B98+12    DOWN L +000077000000
       ORA SW3       UP
       SWT 4         SW 4
       TRA B98+15    DOWN L +000000770000
       ORA SW4       UP
       SWT 5         SW 5
       TRA B98+18    DOWN L +000000007700
       ORA SW5       UP
       SWT 6         SW 6
       TRA B98+21    UP
       ORA SW6       DOWN L +000000000077
       REM           
       NOP 118       TEST, SEE IF NOP INTERPRETED
       REM             AS PSE. IF SW6 UP, NOT
       REM             CONCLUSIVE
       TRA B98A      SENSE SWITCH TEST
       TSX ERROR-1,4 
       TRA B98       
       REM           
 B98A  TRA B98A+1    
       STO TEMP      
       LDQ TEMP      
       CLA KK88      RESET SWITCH TO COMPARE
       STO B98A        TO SEE IF AGREE SECOND
       REM             TIME
       TRA B98+2     REPEAT B98 ONCE
       REM           
 B98B  SUB TEMP      SUBT FIRST RESULT FROM 2ND
       TZE B98B+3    OK, PROCEED
       TSX ERROR,4   ERROR IS SHOWN BY COMPARING
       TSX OK,4        ACC RESULTS WITH MQ. IF
       TRA B98         SWITCH WAS UP, ITS
       REM             RESPECTIVE PART OF ACC
       REM             SHOULD BE OFF. IF SWITCH
       REM             WAS DOWN, THIS PART
       REM             SHOULD BE ON
       REM           
       REM           
       BCD 1STT      TEST-STORE TAG
 A1    CLM           
       SLW TEMP      SAVE ACC
       CLA ONES      L ALL ONES
       STT TEMP      PUT ONES IN TAG
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A1+8      ERROR
       TRA A2Z       OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A1        REPEAT SECTION
       REM           
 A2Z   CLA TEMP      TEST TAG FOR ONES
       LDQ K2        L +700000 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K2        
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A1        REPEAT TEST
       REM           
       REM           
       BCD 1STT      
 A2A   CLA ONES      L ALL ONES
       STO TEMP      SAVE ACC
       CLM           
       STT TEMP      PUT ZEROS IN TAG
       CLA TEMP      TEST TAG FOR ZEROS
       LDQ K3        L -377777077777 MQ,ACC
       REM           SHOULD BE THE SAME
       CAS K3        
       TRA A2A+9     ERROR
       TRA A2A+10    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A2A       REPEAT TEST
       REM           
       REM           
       BCD 1STZ      TEST STORE ZERO AND SEE IF
       REM           ACC AND MQ CHANGE
 A3    CLA ONES      L ALL ONES
       STO TEMP      SAVE ACC
       LDQ A3+2      
       STZ TEMP      BLANK TEMP
       STQ TEMP+1    SAVE MQ
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A3+9      ERROR
       TRA A3A       OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A3        REPEAT SECTION
       REM           
 A3A   CLA TEMP+1    L SAVED MQ
       LDQ A3+2      MQ, ACC SHOULD BE SAME
       CAS A3+2      
       TRA *+2       ERROR
       TRA A4        OK MQ UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A3        REPEAT SECTION
       REM           
 A4    CLA TEMP      CHECK TEMP
       TZE A4+3      OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A3        REPEAT TEST
       REM           
       REM           
       BCD 1XCA      TEST-EXCHANGE ACC AND MQ
 A5Z   CLA ONE       L +1
       LDQ MZE       L -0 TO MQ
       XCA 0         
       TMI A5A       ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A5Z       REPEAT SECTION
       REM           
 A5A   TZE A5A1      OK OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A5Z       REPEAT SECTION
       REM           
 A5A1  LLS 35        BRING MQ TO ACC
       LDQ ONE       L +1 TO MQ
       CAS ONE       
       TRA A5A1+5    ERROR
       TRA A5A1+6    MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A5Z       REPEAT TEST
       REM           
       REM           
       BCD 1XCA      XCA TEST
 A6    CLA K3        L -377777077777
       LDQ K2        L +000000700000
       XCA           CHECK ALL POSITIONS
       STQ TEMP      SAVE MQ
       LDQ K2        L +7000000 MQ,ACC SHOULD
       REM           BE THE SAME
       CAS K2        
       TRA A6+8      ERROR
       TRA A6A       ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A6        REPEAT SECTION
       REM           
 A6A   CLA TEMP      CHECK SAVED MQ
       LDQ K3        L -377777077777 MQ,ACC
       REM           SHOULD BE THE SAME
       CAS K3        
       TRA A6A+5     ERROR
       TRA A6A+6     MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A6        REPEAT TEST
       REM           
       REM           
       BCD 1XCA      
 A7X   CLA ONES      L ALL ONES
       ALS 3         ACC NOW -11377777777770
       LDQ K3        L -377777077777
       XCA           CHECK XCA FOR
       REM           CLEARING P,Q
       STQ TEMP      SAVE MQ
       LDQ K3        L -377777077777 MQ,ACC
       REM           SHOULD BE THE SAME
       CAS K3        
       TRA *+2       ERROR
       TRA A7A       ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A7X       
       REM           
 A7A   CLA TEMP      CHECK SAVED MQ
       LDQ K6        L -37777777770 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K6        
       TRA A7A+5     ERROR
       TRA A7A+6     MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A7X       
       REM           
       REM           
       BCD 1XCL      TEST-EXCHANGE LOGICAL
       REM           ACCUMULATOR AND MQ
 A10X  CLA ONE       L +1
       LDQ MZE       L -0 TO MQ
       XCL 0         
       PBT           
       TRA *+2       ERROR
       TRA A10A      OK-ACC HAS P BIT
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A10X      
       REM           
 A10A  ARS 2         ACC NOW +10000000000
       STQ TEMP      SAVE MQ
       LDQ PTHR      L +1000000000 TO MQ
       CAS PTHR      
       TRA A10A+6    ERROR
       TRA A10A1     ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A10X      
       REM           
 A10A1 CLA TEMP      CHECK SAVED MQ
       LDQ ONE       L +1 TO MQ
       CAS ONE       
       TRA A10A1+5   ERROR
       TRA A10A1+6   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A10X      
       REM           
       REM           
       BCD 1XCL      
 A12X  CAL ONES      L ONES
       LDQ ZERO      L +0
       XCL 0         
       TZE A12A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A12X      
       REM           
 A12A  LLS 35        BRING MQ TO ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A12A+5    ERROR
       TRA A12A+6    MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A12X      
       REM           
       REM           
       BCD 1XCL      
 A13X  CLA K10       L -300000000000
       ALS 2         CLEAR ALL BUT S,Q,P
       LDQ ONES      L ALL ONES TO MQ
       XCL 0         TEST FOR CLEARING S,Q
       ARS 1         CLEAR P
       STQ TEMP      SAVE MQ
       LDQ PONES     L + ALL ONES
       CAS PONES     
       TRA *+2       ERROR
       TRA A13A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A13X      
       REM           
 A13A  CLA TEMP      CHECK SAVED MQ
       TMI A13A1     MQ SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A13X      
       REM           
 A13A1 TZE A13A1+2   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A13X      
       REM           
       REM           
       BCD 1ERA      TEST-EXCLUSIVE OR TO ACC
 A14X  CAL ONES      L ALL ONES
       SLW TEMP      SAVE ACC
       ERA TEMP      CHECK FOR CLEARING ACC
       TZE A14A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A14X      REPEAT SECTION
       REM           
 A14A  CLA TEMP      CHECK STG UNCHANGED
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A14A+5    ERROR
       TRA A14A+6    OK-STORAGE UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A14X      
       REM           
       REM           
       BCD 1ERA      
 A15X  CAL ONES      L ALL ONES
       ERA ZERO      NO CHANGE TO ACC
       SLW TEMP      SAVE ACC
       CLA TEMP      CHECK ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A15X      
       REM           
       REM           
       BCD 1ERA      
       REM           
 A16X  CLA ZERO      L +0
       ERA ONES      FILL P,1-35 WITH BITS
       SLW TEMP      SAVE ACC
       CLA TEMP      CHECK ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A16X      
       REM           
       REM           
       BCD 1ERA      
 A17   CLA K10       L -300000000000
       ALS 3         SET UP Q BIT
       ERA ZERO      CHECK S,Q CLEARED
       TPL A17A      ACC SIGN CLEARED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A17       
       REM           
 A17A  TZE A17A+2    ACC OK-Q CLEARED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A17       REPEAT TEST
       REM           
       REM           
       BCD 1LGR      TEST-LOGICAL RT SHIFT
 A20   CLA ONE       L +1
       LDQ ZERO      L +0 TO MQ
       LGR 1         
       TZE A20A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A20       REPEAT SECTION
       REM           
 A20A  LLS 35        BRING MQ TO ACC
       TMI A20A1     MQ SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A20       REPEAT SECTION
       REM           
 A20A1 TZE A20A1+2   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A20       REPEAT TEST
       REM           
       REM           
       BCD 1LGR      
 A21X  LDQ MZE       L -0 TO MQ
       CLM           
       LGR 35        CHANGE MQ TO +1
       LLS 35        BRING MQ TO ACC
       LDQ ONE       L +1 TO MQ
       CAS ONE       
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A21X      
       REM           
       BCD 1LGR      
 A22X  CLA PONES     L PLUS ONES
       ALS 3         LOAD P, Q
       LGR 36        NOW -3777777777770 IN MQ
       STQ TEMP      SAVE MQ
       LDQ ONE       L +1 TO MQ
       CAS ONE       
       TRA *+2       ERROR
       TRA A22A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A22X      
       REM           
 A22A  CLA TEMP      L SAVED MQ
       LDQ K6        L -37777777770 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K6        
       TRA A22A+5    ERROR
       TRA A22A+6    MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A22X      
       REM           
       REM           
       BCD 1ZET      TEST-STORAGE ZERO TEST
 A23X  CLA ONES      L ALL ONES
       ZET ZERO      STG 1-35 ZERO
       TRA *+2       ERROR
       TRA A23A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A23X      
       REM           
 A23A  LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A23A+4    ERROR
       TRA A23A+5    OK-ACC UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A23X      
       REM           
       REM           
       BCD 1ZET      
 A24X  ZET MZE       STG 1-35 ZERO
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A24X      
       REM           
       REM           
       BCD 1ZET      
 A24A  CLA ONE       L +1
       STO TEMP      SAVE ACC
       ZET TEMP      STG 1-35 NOT ZERO
       TRA A24A1     OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A24A      REPEAT SECTION
       REM           
 A24A1 CLA TEMP      CHECK STG UNCHANGED
       LDQ ONE       L + 1
       CAS ONE       
       TRA A24A1+5   ERROR
       TRA A24A1+6   OK-STORAGE UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A24A      REPEAT TEST
       REM           
       REM           
       BCD 1ZET      TEST-STORAGE TEST
       REM           POSITIONS S, 1-35
 24A   CLM           CLEAR ACC
       CLA ONE       L +1
       STO TEMP      SAVE ACC
       ZET TEMP      STG 1-35 NOT ZERO
       TRA 24B       OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA 24A       REPEAT SECTION
       REM           
 24B   ALS 1         MOVE BIT
       PBT           P BIT YET
       TRA 24A+2     NO
       SLW TEMP      STG 1-35 ZERO
       ZET TEMP      TEST SIGN POSITITION
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA 24A       REPEAT TEST
       REM           
       REM           
       BCD 1ZET      
 24C   CLM           
       SLW TEMP      STG 1-35 ZERO
       ZET TEMP      
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA 24C       REPEAT TEST
       REM           
       REM           
       BCD 1NZT      TEST-STORAGE NOT ZERO TEST
 A25X  CLA ONE       L +1
       STO TEMP      SAVE ACC
       NZT TEMP      STG 1-35 NOT ZERO
       TRA *+2       ERROR
       TRA A25A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A25X      
       REM           
 A25A  LDQ ONE       L +1 TO MQ
       CAS ONE       
       TRA A25A+4    ERROR
       TRA A25A1     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A25X      
       REM           
 A25A1 CLA TEMP      L +1
       CAS ONE       
       TRA A25A1+4   ERROR
       TRA A25A1+5   OK-STORAGE UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A25X      
       REM           
       REM           
       BCD 1NZT      
 A26X  NZT ZERO      STG 1-35 ZERO
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A26X      
       REM           
       REM           
       BCD 1NZT      TEST STORAGE NOT ZERO
       REM           POSITIONS S, 1 TO 35
 26A   CLM           CLEAR ACC
       CLA ONE       L +1
       STO TEMP      SAVE ACC
       NZT TEMP      STG 1-35 NOT ZERO
       TRA *+2       ERROR
       TRA 26B       OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA 26A       REPEAT SECTION
       REM           
 26B   ALS 1         MOVE BIT
       PBT           P BIT YET
       TRA 26A+2     NO
       SLW TEMP      SAVE ACC
       NZT TEMP      STG 1-35 ZERO
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA 26A       REPEAT TEST
       REM           
       REM           
       BCD 1NZT      
 26C   CLM           
       SLW TEMP      SAVE ACC
       NZT TEMP      STG 1-35 ZERO
       TRA 26C+5     OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA 26C       REPEAT TEST
       REM           
       REM           
       BCD 1LAS      TEST-LOGICAL COMPARE
       REM           ACC WITH STORAGE
 A27X  CLA ONES      L ALL ONES
       STO TEMP      SAVE ACC
       CAL MZE       L BIT IN P
       ALS 1         SHIFT TO Q
       LAS TEMP      TEST ACC GREATER THEN STG
       TRA *+4       OK
       TRA *+1       ERROR
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A27X      
       REM           
 A27A  LDQ ZERO      L +0 TO MQ
       ARS 2         SHIFT TO POS 1
       ADD MTW       L -2000000000
       TZE A27A1     OK ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A27X      
       REM           
 A27A1 CLA TEMP      CHECK STG UNCHANGED
       LDQ ONES      L ONES TO MQ
       CAS ONES      
       TRA A27A1+5   ERROR
       TRA A27A1+6   OK STORAGE UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A27X      
       REM           
       REM           
       BCD 1LAS      
 A28X  CLA K3        L -377777077777
       LAS K2        L +700000-TEST STORAGE LESS
       REM           THAN ACCUMULATOR
       TRA *+3       OK
       TRA *+1       ERROR
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A28X      
       REM           
       REM           
       BCD 1LAS      
 A29X  CLA MTW       L -2000000000
       ALS 1         SHIFT TO POS P
       LAS MTW       TEST STG GREATER THAN ACC
       TRA *+1       ERROR
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A29X      
       REM           
       REM           
       BCD 1LAS      
 A30X  CAL MZE       L P BIT
       LAS MZE       TEST STG AND ACC EQUAL
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A30X      
       REM           
       REM           
       BCD 1VLM      TEST-VAR LENGTH MULTIPLY
 A31X  LDQ ONES      L ALL ONES TO MQ
       VLM ONE,0,35  SET 43 IN SHIFT COUNTER
       TMI A31A      ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A31X      
       REM           
 A31A  TZE A31A1     ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A31X      
       REM           
 A31A1 LLS 35        BRING MQ TO ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A31A1+5   ERROR
       TRA A31A1+6   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A31X      
       REM           
       REM           
       BCD 1VLM      
 A32X  LDQ ONES      L ALL ONES TO MQ
       VLM K2,0,1    SET 1 IN SHIFT COUNTER
       ALS 1         
       CHS           ACC NOW +000000700000
       LDQ K2        L +700000 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K2        
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A32X      
       REM           
       REM           
       BCD 1VLM      
 A33X  LDQ ONES      L ALL ONES TO MQ
       CLA ONES      L ALL ONES
       VLM K2,0,15   SET 17 IN SHIFT COUNTER
       CHS           ACC NOW +000000677771
       STQ TEMP      SAVE MQ
       LDQ K11       L +677771 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K11       
       TRA *+2       ERROR
       TRA A33A      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A33X      
       REM           
 A33A  CLA TEMP      CHECK SAVED ACC
       CHS           ACC NOW +0000037777777
       LDQ K12       L +37777777 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K12       
       TRA A33A+6    ERROR
       TRA A33A+7    MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A33X      
       REM           
       REM           
       BCD 1VLM      TEST-VLM WITH INDEXING
 A34X  AXT 35,1      L 43 IN XRA
       LDQ K6        L -377777777770
       VLM K3+35,1,4 SET 4 IN SHIFT COUNTER
       LLS 1         
       CHS           ACC NOW -377777077777
       STQ TEMP      SAVE MQ
       LDQ K3        L -377777077777 ACC, MQ
       REM           SHOULD BE THE SAME
       CAS K3        
       TRA *+2       ERROR
       TRA A34AA     ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34X      
       REM           
 A34AA CLA TEMP      CHECK SAVED MQ
       LDQ K13       L +037777777776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K13       
       TRA A34AA+5   ERROR
       TRA A34AA+6   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34X      
       REM           
       REM           
       BCD 1VLM      TEST-VARIABLE LENGTH MULTIPLY
       REM           ZERO WORD COUNT
 A34A  CLA K24       
       LDQ K24       L+1111111111
       VLM ONES,0,0  SHIFT COUNTER ZERO
       STQ TEMP      SAVE MQ
       LDQ K24       L+1111111111
       CAS K24       CHECK ACC UNCHANGED
       TRA A34A+8    ERROR
       TRA A34B      OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34A      REPEAT SECTION
       REM           
 A34B  CLA TEMP      CHECK SAVED MQ
       CAS K24       CHECK MQ UNCHANGED
       TRA A34B+4    ERROR
       TRA A34B+5    OK MQ UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34A      REPEAT TEST
       REM           
       REM           
       BCD 1VLM      TEST VARIABLE LENGTH
       REM           MULTIPLY
       REM           ZERO MULTIPLICAND, ZERO
       REM           COUNT
       REM           COUNT TAKES PRECEDENT
 A34C  CLA ONES      L ALL ONES
       LDQ ONES      L ALL ONES TO MQ
       VLM ZERO,0,0  SHIFT COUNTER ZERO
       STQ TEMP      SAVE MQ
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A34C+8    ERROR
       TRA A34D      OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34C      REPEAT SECTION
       REM           
 A34D  CLA TEMP      CHECK SAVE MQ
       CAS ONES      
       TRA A34D+4    ERROR
       TRA A34D+5    OK MQ UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34C      REPEAT TEST
       REM           
       REM           
       BCD 1VLM      TEST-VARIABLE LENGHT MULTIPLY
       REM           WITH ZERO MULTIPLCAND
 A34E  CLA ONES      L ALL ONES
       LDQ ONES      L ALL ONES TO MQ
       VLM ZERO,0,5  
       TMI A34E1     ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34E      REPEAT SECTION
       REM           
 A34E1 TZE A34F      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34E      REPEAT SECTION
       REM           
 A34F  STQ TEMP      SAVE MQ
       CLA TEMP      CHECK SAVED MQ
       TMI A34F1     MQ SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34E      REPEAT SECTION
       REM           
 A34F1 TZE A34F1+2   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34E      REPEAT TEST
       REM           
       REM           
       BCD 1VLM      TEST-VARIABLE LENGHT
       REM           MULTIPLY-ZERO MULTIPLICAND
 A34G  CLA ONES      L ONES
       LDQ ONES      L ONES TO MQ
       VLM MZE,0,5   
       TPL A34G1     ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34G      REPEAT SECTION
       REM           
 A34G1 TZE A34H      ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34G      REPEAT SECTION
       REM           
 A34H  STQ TEMP      SAVE MQ
       CLA TEMP      CHECK SAVED MQ
       TPL A34H1     MQ SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A34G      REPEAT SECTION
       REM           
 A34H1 TZE A34H1+2   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A34G      REPEAT TEST
       REM           
       REM           
       BCD 1VDP      TEST-VAR LENGTH
       REM           DIVIDE OR PROCEED
 A35X  LDQ ONES      L ALL ONES TO MQ
       CLA MZE       L -0
       VDP ONE,0,35  SET 43 IN SHIFT COUNTER
       TMI A35A      
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A35X      REPEAT SECTION
       REM           
 A35A  TZE A35A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A35X      
       REM           
 A35A1 LLS 35        CHECK QUOTIENT
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A35A1+5   ERROR
       TRA A35A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      
       TRA A35X      
       REM           
       REM           
       BCD 1VDP      CHECK MQ SIGN CHANGE
 A36X  LDQ K8        L +177777777777 IN MQ
       CLA K14       L -340000
       VDP K2,0,1    SET 1 IN SHIFT COUNTER
       TMI A36A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A36X      
       REM           
 A36A  TZE A36A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A36X      
       REM           
 A36A1 LLS 35        CHECK QUOTIENT
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A36A1+5   ERROR
       TRA A36A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A36X      
       REM           
       REM           
       BCD 1VDP      
 A37X  LDQ K12       L +37777777 IN MQ
       CLA K11       L+677771
       VDP K2,0,15   SET 17 IN SHIFT COUNTER
       TPL A37A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A37X      
       REM           
 A37A  TZE A37A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A37X      
       REM           
 A37A1 LLS 35        CHECK QUOTIENT
       LDQ PONES     L ALL ONES TO MQ
       CAS PONES     
       TRA *+2       ERROR
       TRA *+2       QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A37X      
       REM           
       REM           
       BCD 1VDP      TEST-VDP WITH INDEXING
 A40X  AXT 35,1      L 43 IN XRA
       CLS K3        L -377777077777
       LDQ K13       L +377777777776
       LRS 1         
       VDP K3+35,1,4 SET 4 IN SHIFT COUNTER
       TPL A40A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A40X      
       REM           
 A40A  TZE A40A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A40X      
       REM           
 A40A1 LLS 35        CHECK QUOTIENT
       LDQ K6        L -377777777770 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K6        
       TRA A40A1+5   ERROR
       TRA A40A1+6   QOUTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A40X      
       REM           
       REM           
       BCD 1VDP      
 A41X  DCT           TURN OFF DIV-CHECK LIGHT
       NOP           
       LDQ K36       L +377777777776
       CLA K2        L +700000
       VDP K2,0,18   L +700000
       DCT           CHECK SETTING TRG
       TRA A41AA     OK DIV-CHECK LITE WAS ON
       REM           DIVISION NOT POSSIBLE
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A41X      
       REM           
 A41AA STQ TEMP      SAVE MQ
       LDQ K2        L +700000 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K2        CHECK ACC UNCHANGED
       TRA A41AA+5   ERROR
       TRA A41AB     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A41X      
       REM           
 A41AB CLA TEMP      CHECK SAVED MQ
       LDQ K36       L +377777777776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K36       CHECK MQ UNCHANGED
       TRA A41AB+5   ERROR
       TRA A41AB+6   OK-MQ UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A41X      
       REM           
       REM           
       BCD 1VDP      TEST-VARIABLE DIVIDE OR
       REM           PROCEED WITH ZERO WORD
       REM           COUNT
 A41A  CLA K11       L +677771
       DCT           TURN OFF DIV-CHECK LITE
       NOP           
       LDQ K11       L+677771
       VDP K2,0,0    
       STQ TEMP      SAVE MQ
       LDQ K11       L +677771
       CAS K11       CHECK ACC UNCHANGED
       TRA A41A+10   ERROR
       TRA A41B      OK-ACC UNCHANGED
       TSX ERROR-1,4 
       TRA A41A      REPEAT SECTION
       REM           
 A41B  CLA TEMP      CHECK SAVED MQ
       CAS K11       CHECK MQ UNCHANGED
       TRA A41B+4    ERROR
       TRA A41C      OK-MQ UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A41A      REPEAT SECTCION
       REM           
 A41C  DCT           
       TRA A41C+3    NG DIV-CHECK LITE WAS ON
       TRA A41C+4    OK-DIV-CHECK LITE OFF
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A41A      REPEAT TEST
       REM           
       REM           
       BCD 1VDH      TEST-VAR LENGTH
       REM           DIVIDE OR HALT
 A42X  LDQ ONES      L ALL ONES TO MQ
       CLA MZE       L -0
       VDH ONE,0,35  SET 43 IN SHIFT COUNTER
       TMI A42A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A42X      
       REM           
 A42A  TZE A42A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A42X      
       REM           
 A42A1 LLS 35        CHECK QUOTIENT
       LDQ ONES      
       CAS ONES      
       TRA A42A1+5   ERROR
       TRA A42A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A42X      
       REM           
       REM           
       BCD 1VDH      
 A43X  LDQ K8        L +177777777777 TO MQ
       CLA K14       L -370000
       VDH K2,0,1    SET 1 IN SHIFT COUNTER
       TMI A43A      
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A43X      
       REM           
 A43A  TZE A43A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A43X      
       REM           
 A43A1 LLS 35        CHECK QUOTIENT
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA A43A1+5   ERROR
       TRA A43A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A43X      
       REM           
       BCD 1VDH      
 A44X  LDQ K12       L +37777777
       CLA K11       L +677771
       VDH K2,0,15   SET 17 IN SHIFT COUNTER
       TPL A44A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A44X      
       REM           
 A44A  TZE A44A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A44X      
       REM           
 A44A1 LLS 35        CHECK QUOTIENT
       LDQ PONES     L ALL ONES TO MQ
       CAS PONES      
       TRA *+2       ERROR
       TRA *+2       QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A44X      
       REM           
       REM           
       BCD 1VDH      TEST-VDH WITH INDEXING
 A45X  AXT 35,1      L +43 IN XRA
       CLS K3        L -3777770777777
       LDQ K13       L +9037777777776
       LRS 1         
       VDH K3+35,1,4 SET 4 IN SHIFT COUNTER
       TPL A45A      REMAINDER SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A45X      
       REM           
 A45A  TZE A45A1     REMAINDER OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A45X      
       REM           
 A45A1 LLS 35        CHECK QUOTIENT
       LDQ K6        L -377777777770 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K6        
       TRA A45A1+5   ERROR
       TRA A45A1+6   QUOTIENT OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      
       TRA A45X      
       REM           
       REM           
       REM           
       BCD 1CVR      TEST-CONVERT BY REPLACEMENT
       REM           FROM ACC
 A47X  AXT 0,1       CLEAR XRA
       CLA K2        L +700000
       CVR K15,1     CHECK NO COUNT-NO ACTION
       LDQ K2        L +70000 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K2        
       TRA *+2       ERROR
       TRA A47A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A47X      
       REM           
 A47A  CLA K15+K15,1 CHECK ADR PUT IN XRA
       LDQ K15       L +374000003400 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K15       
       TRA A47A+5    ERROR
       TRA A47A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      
       TRA A47X      
       REM           
       REM           
       BCD 1CVR      
 A50X  AXT 0,1       CLEAR XRA
       CAL K2        L +700000
       CVR ONES,0,1  CHECK ONE 6 BIT CONVERSION
       REM           NO ADDITION TO ADDRESS
       SLW TEMP      SAVE ACC BEFORE SHIFT
       ARS 1         ACC NOW +374000003400
       PBT           
       TRA A50A      OK Q WAS ZERO
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A50X      
       REM           
 A50A  CLA TEMP,1    L SAVED ACC
       LDQ K15+1     L -370000007000 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K15+1     
       TRA A50A+5    ERROR
       TRA A50A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A50X      
       REM           
       REM           
       BCD 1CVR      
 A51X  AXT 0,1       CLEAR XRA
       CAL ONE       L +1
       CVR ZERO,0,1  CHECK ONE 6 BIT CONVERSION
       REM           ADDITION TO ADDRESS
       SLW TEMP      SAVE ACC
       ARS 1         ACC NOW +374000000000
       PBT           
       TRA A51A      OK Q W S Z R0
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A51X      
       REM           
 A51A  CLA TEMP,1    L SAVED ACC
       LDQ SW1       L -370000000000 IN MQ
       CAS SW1       
       TRA A51A+5    ERROR
       TRA A51A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A51X      
       REM           
       REM           
       BCD 1CVR      
 A52X  CAL K16       L +010203040506
       CVR K16,1,6   FULL WORD CONVERSION WITH
       REM           6TH CONVERT SR ADR IN XRA
       REM           
       REM CHECK ACC AND CORRECT VALUE IN XRA
       REM           
       LDQ K16B+K16,1 L +212223242526
       CAS K16B      
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      
       TRA A52X      
       REM           
       REM           
       NOP           
       TRA A53X      
       REM           
       REM           
*SAVE 50 DECIMAL LOCATIONS FOR ANY ADDITIONAL INSTRUCTIONS
*OR ROUTINES INSERTED PRIOR TO THE ERROR PRINT SUBROUTINE
       REM           
*DIAGNOSTIC ERROR PRINT SUBROUTINE IN LOCATIONS 06500-07712
*9M21 CONTINUES COMMENCING AT LOCATION 07713
       REM           
       REM           
       BSS 701       
       REM           
       REM           
       BCD 1CVR      
 A53X  CAL K17+1     L -374777770304
       ALS 1         PUT BIT IN Q
       REM           MAKE ACC +11371777760610
       CVR K17-8,0,2 
       LDQ K32       L -374777177776
       REM           SHOULD BE THE SAME
       LAS K32       
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A53X      
       REM           
       REM           
       BCD 1CAQ      TEST-CONVERT BY ADDITION
       REM           FROM THE MQ
 A54X  LDQ K16       L +010203040506
       CLA MZE       L -0
       CAQ K16       NO COUNT-NO ACTION
       TMI A54A      ACC SIGN OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A54X      
       REM           
 A54A  TZE A54A1     ACC OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A54X      
       REM           
 A54A1 LLS 35        MQ TO ACC AND CHECK
       LDQ K16       L +010203040506 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16       
       TRA A54A1+5   ERROR
       TRA A54A1+6   MQ OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A54X      
       REM           
       REM           
       BCD 1CAQ      
 A55X  AXT 0,1       CLEAR XRA
       LDQ K16       L +010203040506
       CLA ZERO      L + 0
       CAQ K16-1,0,1 PERFORM 1 ADDITION
       STQ TEMP      SAVE MQ
       LDQ K16       L +010203040506 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16       
       TRA *+2       ERROR
       TRA A55A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A55X      
       REM           
 A55A  CLA TEMP,1    CHECK SAVED MQ
       LDQ K16-1     L+020304050601
       CAS K16-1     
       TRA A55A+5    ERROR
       TRA A55A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A55X      
       REM           
       REM           
       BCD 1CAQ      
 A56X  TOV *+1       TURN OFF ACC OVFLO LIGHT
       LDQ K16       L +010203040506
       CLA ZERO      L +0
       CAQ K16,1,6   FULL WORD CONVERSION WITH
       REM           6TH CONVERT SR ADR IN XRA
       SLW TEMP      SAVE ACC
       ARS 1         MOVE Q BIT TO P
       PBT           
       TRA *+2       ERROR
       TRA A56A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A56X      
       REM           
       REM CHECK ACC AND CORRECT VALUE IN XRA
       REM           
 A56A  STQ TEMP+1    SAVE MQ
       CLA TEMP+K16,1 CHECK SAVED MQ
       LDQ K16+7     MQ, ACC SHOULD BE SAME
       CAS K16+7     
       TRA A56A+6    ERROR
       TRA A56A1     OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A56X      
       REM           
 A56A1 CLA TEMP+1    CHECK SAVED MQ
       LDQ K16       L +010203040506 MQ, ACC
       CAS K16       
       TRA A56A1+5   ERROR
       TRA A56A1+6   OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A56X      
       REM           
       REM           
       BCD 1CAQ      
 A57X  CLA K14       L -340000
       LDQ K16       L +010203040506
       CAQ K17-1,0,2 TEST SWITCHING TABLES
       SLW TEMP      SAVE ACC
       ARS 1         
       PBT           
       TRA A57A      OK Q WAS ZERO
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A57X      
       REM           
 A57A  CLA TEMP      CHECK SAVED ACC
       LDQ K16+8     MQ, ACC SHOULD BE SAME
       CAS K16+8     
       TRA A57A+5    ERROR
       TRA A57A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A57X      
       REM           
       REM           
       BCD 1CAQ      TEST CAQ FRO CORRECT INDEX
 A60X  AXT 32K,1     L 77777 IN XRA
       CLA ZERO      L +0
       LDQ K16       L +010203040506
       CAQ K16,6,1   PERFORM ONE ADD
       LDQ K16+1     MQ, ACC SHOULD BE SAME
       CAS K16+1     
       TRA *+2       ERROR
       TRA A60A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A60X      
       REM           
 A60A  CLA K13-1,1   CHECK XRA UNCHANGED
       LDQ K13       L +037777777776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K13       
       TRA A60A+5    ERROR
       TRA A60A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A60X      
       REM           
       REM           
       BCD 1CAQ      
 A61X  CLA ZERO      L +0
       LDQ K16+1     L +2100000 ADDRESS K16
       CAQ K15-17,1,1 PREFORM 1 ADD, SAVE ADR
       LDQ K15       L +374000003400 MQ, ACC
       REM           SHOULD BE SAME
       CAS K15       
       TRA *+2       ERROR
       TRA A61AX     
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A61X      
       REM           
 A61AX CLA K20+1792,1 CHECK XRA SET TO 3400
       LDQ K20       L +265577177776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K20       
       TRA *+2       ERROR
       TRA *+2       
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      
       TRA A61X      
       REM           
       BCD 1CRQ      TEST-CONVERT BY REPLACMENT
       REM           FROM THE MQ
 A62X  AXT 32K,1     L 77777 IN XRA
       CLA ONES      L ALL ONES
       LDQ K16       L+010203040506
       CRQ K16       CHECK NO ACTION
       REM           WITH NO COUNT
       STQ TEMP      SAVE MQ
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA *+2       ERROR
       TRA A62AX     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A62X      
       REM           
 A62AX CLA TEMP      CHECK SAVED MQ
       LDQ K16       L +010203040506 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16       CHECK SAVED MQ UNCHANGED
       TRA *+2       ERROR
       TRA A62B      OK-MQ UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A62X      
       REM           
 A62B  CLA K17-1,1   CHECK XRA UNCHANGED
       LDQ K17       MQ, ACC SHOULD BE SAME
       CAS K17       
       TRA A62B+5    ERROR
       TRA A62B+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A62X      
       REM           
       REM           
       BCD 1CRQ      
 A63X  CLA ZERO      L +0
       LDQ K16       L +010203040506
       CRQ K16,1,1   CHECK 6 BIT CONVERSION
       REM           ALSO CHECK SAVING ADR
       TZE A63AX     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A63X      
       REM           
 A63AX LLS 35        MQ TO ACC
       LDQ K16A      L +020304050621 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16A      
       TRA *+2       ERROR
       TRA A63BX     OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A63X      
       REM           
 A63BX CLA K15+K16,1 CHECK ADR SET IN XRA
       LDQ K15       L +374000003400 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K15       
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A63X      
       REM           
       REM           
       BCD 1CRQ      
 A64X  AXT 0,1       CLEAR XRA
       LDQ K16       L +010203040506
       CRQ K16,0,6   CHECK FULL WORD
       REM           CONVERSION
       CLM           CLEAR ACC
       LLS 35        BRING MQ TO ACC
       LDQ K16B,1    L +212223242526 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K16B,1    
       TRA *+2       ERROR
       TRA *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A64X      
       REM           
       REM           
       BCD 1CRQ      
 A64Y  AXT 0,1       CLEAR XRA
       LDQ SW1       L -370000000000
       CRQ K15-60,0,1 
       CLM           CLEAR ACCUMULATOR
       LLS 35        MQ TO ACCUMULATOR
       SUB ONE       L +1
       TZE *+2       OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      
       TRA A64Y      
       REM           
       REM           
       BCD 1STL      TEST-STORE INST CTR
 A65X  CLA ONES      L ALL ONES
       STO TEMP      SAVE ACC
       STL TEMP      
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA *+2       ERROR
       TRA A65A      OK
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A65X      
       REM           
 A65A  CLA TEMP      CHECK TEMP
       LDQ K23       L TXL A65X+3,7,32767
       CAS K23       
       TRA A65A+5    ERROR
       TRA A65A+6    OK
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A65X      
       REM           
       BCD 1STR-     TEST-STORE LOC AND TRAP
       REM           
 65A   CLA ONES      L ALL ONES
       STO 0         
       REM           
       CLA K37B      L TRA 65A1
       STO 1         
       REM           
       CLA K37C      L TRA 65A2
       STO 2         
       REM           
       CLA K37D      L TRA 65A3
       STO 3         
       REM           
       CLA K37E      L TRA 65A4
       STO 10        
       REM           
       CLA K37E1     L TRA 65A4A
       STO 11        
       REM           
       CLA K37E2     L TRA 65A4B
       STO 12        
       REM           
       CLA K37E3     L TRA 65A4C
       STO 13        
       REM           
       AXT 4K,3      L 777 IN XRA AND XRB
       REM           
       STR 65A4D,3,1 SHOULD TRAP TO LOC 00002
       REM           WITH LOC. OF NEXT INSTR
       REM           IN ADR PORTION OF 0000
       REM           
       REM CHECK STR INSTR EXECUTED CORRECTLY
       REM           
 65A1X TSX ERROR-1,4 ERROR-DID NOT TRAP
       TRA 65A       
       REM           
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM           
       TRA 65A5      
       REM           
 65A1  TSX ERROR-1,4 ERROR-TRA FROM LOC 00001
       TRA 65A       
       REM           
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM           
 65A2  TRA 65A5      OK-TRA FROM LOC 00002
       REM           
 65A3  TSX ERROR-1,4 ERROR-TRA FROM LOC 00003
       TRA 65A       
       REM           
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM           
       TRA 65A5      
       REM           
 65A4  TSX ERROR-1,4 ERROR-TRA FROM LOC 00010
       TRA 65A       
       REM           
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM           
       TRA 65A5      
       REM           
 65A4A TSX ERROR-1,4 ERROR-TRA FROM LOC 00011
       TRA 65A       
       REM           
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM           
       TRA 65A5      
       REM           
 65A4B TSX ERROR-1,4 ERROR-TRA FROM LOC 00012
       TRA 65A       
       REM           
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM           
       TRA 65A5      
       REM           
 65A4C TSX ERROR-1,4 ERROR-TRA FROM LOC 00013
       TRA 65A       
       REM           
       REM IF ERROR,GO TO NEXT INSTR TO CONTINUE
       REM           
       TRA 65A5      
       REM           
 65A4D TSX ERROR-1,4 ERROR-TRANSFERRED
       TRA 65A       AS IF TXI INSTR
       REM           
       REM CHECK CONTENTS OF LOCATION 00000
       REM           
 65A5  CLA 0         L LOCATION 00000
       LDQ K37G      L TXL 65A+18,7,32767
       CAS K37G      
       TRA 65A5+5    ERROR
       TRA 65A6      OK
       TSX ERROR-1,4 ERROR-WRONG QTY LOC 00000
       TRA 65A       REPEAT SECTION
       REM           
       REM CHECK STR INSTRUCTION UNCHANGED
       REM           
 65A6  CLA 65A+17    L STR INSTRUCTION
       LDQ FOUR-1    L STR 65A4D,3,1
       CAS FOUR-1    
       TRA *+2       ERROR
       TRA 65A7      OK
       TSX ERROR-1,4 ERROR-STR INSTR CHANGED
       TRA 65A       REPEAT SECTION
       REM           
       REM CHECK STR+1 INSTRUCTION UNCHANGED
       REM           
 65A7  CLA 65A+18    L STR + 1 INSTRUCTION
       LDQ K37E4     L TSX ERROR-1,4
       CAS K37E4     
       TRA 65A7+5    ERROR
       TRA 65A8      
       TSX ERROR-1,4 ERROR-STR+1 INSTR CHANGED
       TRA 65A       
       REM           
       REM TEST XRA AND XRB UNCHANGED BY STR
       REM           
 65A8  TXH *+2,1,4095 SHOULD NOT TRANSFER
       TXH *+5,1,4094 SHOULD TRANSFER
       CLA ZERO      CLEAR ACCUMULATOR
       LDQ 1CF       L +7777 IN MQ
       TSX ERROR-1,4 ERROR-XRA CHANGED
       REM           MQ AND XRA SHOULD EQUAL
       TRA 65A       
       REM           
       TXH *+2,2,4095 SHOULD NOT TRANSFER
       TXH *+4,2,4094 SHOULD TRANSFER
       CLA ZERO      CLEAR ACCUMULATOR
       LDQ 1CF       L +7777 IN MQ
       TSX ERROR,4   ERROR-XRB CHANGED
       REM           MQ AND XRB SHOULD EQUAL
       TSX OK,4
       TRA 65A       
       REM           
       REM           
       NOP           
       REM           
*RESTORE LOC 00001, 00002, 00010 OF FALSE TRAP ROUTINE
       REM           
       CLA B85B      L LTM
       STO 1         
       REM           
       CLA TR+7      L SLW TEMP+2
       STO 2         
       REM           
       CLA TR+8      L CLA TR
       STO 3         
       REM           
       CLA TR+9      L TRA
       STO 8         
       REM           
       TSX STORE,4   TO RESTORE RESET-START
       TRA *+2       
       REM           
       REM EXCUTE INSTRUCTION TEST
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE CAUSES 709
       REM           TO TAKE NEXT INSTR FROM
       REM           EXECUTE ADR,PERFORM THAT
       REM           INSTR AND RETURN TO EXE-
       REM           CUTE INSTRUCTION PLUS 1
 EX    CLA ZERO      L+0
       XEC *+2       
       TRA *+4       
       CLA MZE       L -0
       TSX ERROR-1,4 FAILED TO RETURN TO
       REM           EXECUTE INSTR PLUS 1
       TRA EX        
       REM           
       REM TEST FOR MINUS SIGN IN ACC
       REM           
       TMI *+2       OK-ACC SIGN MINUS
       TSX ERROR,4   ERROR-ACC SIGN PLUS
       TSX OK,4      
       TRA EX        
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE TO A TRA
       REM           DOES NOT RETURN TO
       REM           EXECUTE PLUS 1
 EXA   XEC *+4       
       TSX ERROR-1,4 ERROR-SHOULD GO TO TRA
       REM           INSTR AND PROCEED
       TRA EXA       
       REM           
       TRA EXB       GO TO NEXT TEST IF ERROR
       REM           
       TRA *+1       CAME FROM EXECUTE
       TSX OK,4      OK AND CONTINUED
       TRA EXA       
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE WITH TXI
 EXB   AXT 6,1       L 6 IN XRA
       XEC *+4       
       TSX ERROR-1,4 ERROR-SHOULD GO TO TXI
       TRA EXB       INSTRUCTION AND PROCEED
       REM           
       TRA EXC       GO TO NEXT TEST IF ERROR
       REM           
       TXI *+1,1,1   MAKE XRA 7
       TXH *+2,1,7   SHOULD NOT TRANSFER
       TXH *+4,1,6   SHOULD TRANSFER
       CLA ZERO      CLEAR ACCUMULATOR
       LDQ SEVEN     MQ,XRA SHOULD EQUAL
       TSX ERROR,4   
       TSX OK,4      
       TRA EXB       
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE WITH TXL
       REM           WITH XR LOW
 EXC   AXT 0,1       CLEAR XRA
       XEC *+4       
       TSX ERROR-1,4 ERROR-SHOULD GO TO TXL
       TRA EXC       INSTRUCTION AND PROCEED
       REM           
       TRA EXD       
       REM           
       TXL *+3,1,1   SHOULD TRANSFER
       TSX ERROR-1,4 ERROR-DID NOT TRANSFER
       TRA EXC       
       REM           
 EXD   XEC *+4       
       TSX ERROR-1,4 ERROR-SHOULD GO TO TXL
       TRA EXD       INSTRUCTION AND PROCEED
       REM
       TRA EXF       GO TO NEXT TEST IF ERROR
       REM           
       TXL *+2,1,0   SHOULD TRANSFER
       TSX ERROR,4   ERROR-DID NOT TRANSFER
       TSX OK,4      
       TRA EXC       
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE WITH TXL
       REM           WITH XR HIGH
 EXF   CLA ZERO      CLEAR ACCUMULATOR
       AXT 1,1       L 1 IN XRA
       XEC *+3       
       CLA MZE       L -0
       TRA *+4       
       REM           
       TXL *+1,1,0   SHOULD NOT TRANSFER,GO
       REM           BACK TO EXECUTE PLUS 1
       REM           
       TSX ERROR-1,4 FAILED TO RETURN TO
       TRA EXF       EXECUTE INSTR PLUS 1
       REM           
       TMI *+2       SHOULD TRANSFER
       TSX ERROR,4   ERROR-ACC PLUS
       TSX OK,4      
       TRA EXF       
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE WITH TXH
       REM           WITH XR HIGH
 EXG   AXT 1,1       L 1 IN XRA
       XEC *+4       
       TSX ERROR-1,4 ERROR-SHOULD GO TO TXH
       TRA EXG       INSTRUCTION AND PROCEED
       REM           
       TRA EXH       GO TO NEXT TEST IF ERROR
       REM           
       TXH *+2,1,0   SHOULD TRANSFER
       TSX ERROR,4   
       TSX OK,4      
       TRA EXG       
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE WITH TXH
       REM           WITH XR LOW
 EXH   AXT 0,1       CLEAR XRA
       CLA ZERO      CLEAR ACCUMULATOR
       XEC *+3       
       CLA MZE       L -0
       TRA *+4       
       REM           
       TXH *+1,1,0   SHOULD NOT TRANSFER,GO
       REM           BACK TO EXECUTE PLUS 1
       REM           
       TSX ERROR-1,4 FAILED TO RETURN TO
       TRA EXH       EXECUTE INSTR PLUS 1
       REM           
       TMI *+2       SHOULD TRANSFER
       TSX ERROR,4   ERROR-ACC PLUS
       TSX OK,4      
       TRA EXH       
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE WITH TIX
 EXI   AXT 1,1       L 1 IN XRA
       XEC *+4       
       TSX ERROR-1,4 ERROR-SHOULD GO TO TIX
       TRA EXI       INSTRUCTION AND PROCEED
       REM           
       TRA EXJ       GO TO NEXT TEST IF ERROR
       REM           
       TIX *+3,1,0   SHOULD TRANSFER
       TSX ERROR-1,4 ERROR-DID NOT TRANSFER
       TRA EXI       
       REM           
 EXJ   CLA ZERO      CLEAR ACCUMULATOR
       XEC *+3       
       CLA MZE       L -0
       TRA *+4       
       REM           
       TIX *+1,1,1   SHOULD NOT TRANSFER
       TSX ERROR-1,4 FAILED TO RETURN TO
       TRA EXI       EXECUTE INSTR PLUS 1
       REM           
       TMI *+2       SHOULD TRANSFER
       TSX ERROR,4   ERROR-ACC PLUS
       TSX OK,4      
       TRA EXI       
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE WITH TSX
 EXK   AXC *+1,2     2-S COMPLEMENT OF EXECUTE
       REM           INSTRUCTION TO XRB
       XEC *+5       
       TSX ERROR-1,4 ERROR-RETURNED TO
       TRA EXK       EXECUTE INSTR PLUS 1
       REM           
       TRA EXL       GO TO NEXT TEST IF ERROR
       REM           
       TRA *+8       RETURN FROM SUBROUTINE
       TSX SUB,1     OUT TO SUBROUTINE
       REM           
       NOP           
       NOP           
       NOP           
       CLA ZERO      CLEAR ACCUMULATOR
       LDQ ZERO      CLEAR MQ
       REM           
*IF AN ERROR, XRB CONTAINS THE CORRECT 2-S COMLEMENT LOCATION
*OF THE EXECUTE INSTRUCTION THAT SHOULD BE IN XRA
       REM
       TSX ERROR,4   ERROR-FAILED TO RETURN
       REM           EXECUTE PLUS 4
       TSX OK,4      
       TRA EXK       
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE WITH CAS
 EXL   CLA K16B      L +212223242526
       LDQ K16B      L +212223242526
       XEC *+4       
       TRA *+9       ERROR IN COMPARISON
       TRA *+9       OK
       TRA *+7       ERROR IN COMPARISON
       CAS K16B      
       TRA *+2       ERROR-DID NOT RETURN
       TRA *+1       TO EXECUTE INSTR PLUS 1,
       TSX ERROR-1,4 2,3 AFTER CAS INSTR
       TRA EXL       
       REM           
       TRA *+5       GO TO NEXT TEST IF ERROR
       REM           
       TSX ERROR,4   
       TSX OK,4      
       TRA EXL       
       REM           
       REM           
       BCD 1EXE      TEST EXECUTE INDEXABLE
 EX1   AXT 4,1       L 4 IN XRA
       CLA MZE       L -0
       XEC *+6,1     
       TRA *+8       
       CLA ZERO      L +0
       TSX ERROR-1,4 FAILED TO RETURN
       REM           TO EXECUTE PLUS 1
       TRA EX1       
       REM           
       TRA EX3       GO TO NEXT TEST IF ERROR
       REM           
       TSX ERROR-1,4 FAILED TO MODIFY ADR
       TRA EX1       
       REM           
       TRA EX3       GO TO NEXT TEST IF ERROR
       REM           
       REM TEST ACCUMULATOR SIGN
       REM           
       TPL *+2       OK-ACC SIGN PLUS
       TSX ERROR,4   
       TSX OK,4      
       TRA EX1       
       REM           
       REM           
       BCD 1EXE      TEST SUCCESSIVE EXECUTES
 EX3   CLA ONE       L +1
       XEC *+1       
       XEC *+1       
       XEC *+1       
       XEC *+1       
       XEC *+1       
       ADD ONE       L +1
       SUB SEVEN     L +7
       TZE *+2       OK
       TSX ERROR,4   
       TSX OK,4      
       TRA EX3       
       REM           
       REM           
       BCD 1ADD      ADDER TEST
 M06   CLA ZERO      CLEAR ACCUMULATOR
       COM           
       ADD ONE       L +1  RIPPLE CARRY
       TZE M06+6     
       TSX ERROR-1,4 ON ERROR THE RIGHT MOST
       TRA M06       ONE OR LEFT MOST ZERO
       REM           IS ADDER THAT FAILED
       TOV M06+8     OVFL SHOULD BE ON
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      
       TRA M06       
       REM           
       REM           
       BCD 1ADD      ADDER TEST
 M07   CAL ONES      ONES INTO P,1-35
       ACL ONES      ONES INTO P,1-35
       SLW TEMP      
       CLA TEMP      
       SUB ONES      ONES
       TZE M07+7     
       TSX ERROR,4   THE RIGHTMOST ONE OR THE
       TSX OK,4      LEFT MOST ZERO WILL
       TRA M07       INDICATE WHICH ADDER
       REM           FAILED. SIGN POSITION
       REM           CORRESPONDS TO P ADDER
       REM           POSITION
       REM           
       REM           
       NOP           
       REM           
       REM INDICATOR TESTS
       REM           
       REM            
       CLA TR+1      L HTR THREE
       STA 6         ADJUST LOC 00006           
       TRA *+2        
       REM            
       REM            
       BCD 1PAI      TEST-PLACE ACC IN IND
       REM           AND PLACE IND IN ACC
 DZ    CAL ONES      L ALL ONES
       TSX ENTM,2    TEST PRI OP 0,4 NO TRAP
       PAI           ALL INDICATORS ON
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM           
       LTM           FXIT TRAP MODE
       SLW TEMP+2    SAVE ACCUMULATOR
       CLA           L CONTENTS LOC 00000
       LDQ END+1     L TRA START-3
       CAS END+1      
       TRA *+2       ERROR
       TRA *+4       OK
       TSX ERROR-1,4  
       TRA DZ          
       REM            
       TSX STORE,4   TO RESTORE RESET START
       CAL TEMP+2    RESTORE ACCUMULATOR
       REM            
       CLA ZERO      CLEAR ACCUMULATOR
       PIA           BITS IN P, 1 THRU 35 IN ACC
       PBT            
       TRA *+2       ERROR
       TRA DA        OK SHOULD HAVE P BIT
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA DZ        REPEAT SECTION
       REM            
 DA    ARS 1         CLEAR P
       CHS           ACC NOW MINUS ALL ONES
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES       
       TRA DA+6      ERROR
       TRA DA+7      OK ALL IND ON
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA DZ        REPEAT TEST
       REM            
       REM            
       BCD 1PIA       
 D1    CLA ZERO      L +0
       PAI           ALL INDICATORS OFF
       TSX ENTM,2    TEST PRI OP 04 NO TRAP
       PIA            
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM           EXIT TRAP MODE
       SLW TEMP+2    SAVE ACCUMULATOR
       CLA           L CONTENTS LOC 00000
       LDQ END+1     L TRA START-3
       CAS END+1      
       TRA *+2       ERROR
       TRA *+4       OK
       TSX ERROR-1,4  
       TRA D1         
       REM            
       TSX STORE,4   TO RESTORE RESET START
       CAL TEMP+2    RESTORE ACCUMULATOR
       REM            
       TZE *+2       OK-IND OFF
       TSX ERROR,4   TO ERROR ROUTINE 
       TSX OK,4      CONTINUE TEST
       TRA D1        REPEAT TEST
       REM            
       REM            
       BCD 1IIA      TEST-INVERT IND FROM ACC
 D2    CAL ONES      L ALL ONES
       AXT 40,1      L +50 IN XRA
       PAI           ALL INDICATORS ON
       TSX ENTM,2    TEST PRI OP 0,4 NO TRAP
       IIA           ALTERNATE INDICATORS
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA D2         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       TIX D2+3,1,1   
       REM            
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONE TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA D2         REPEAT SECTION
       REM            
       REM            
       BCD 1IIS       
 D2A   CAL ONES       L ALL ONES
       SLW TEMP       SAVE ACCUMULATOR
       AXT 40,1       L +50 IN XRA
       PAI            ALL IN ON
       IIS TEMP       
       TIX D2A+4,1,1  ALTERNATE IND
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA D2A+13     ERROR
       TRA D2A+14     OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA D2A        REPEAT TEST
       REM            
       REM            
       BCD 1IIS       
 D2B   CAL ONES       L ALL ONES
       SLW TEMP       SAVE ACCUMMULATOR
       AXT 40,1       L +50 IN XRA
       PAI            IND ON
       IIA            IND OFF
       IIS TEMP       IND ON
       TIX D2B+4,1,1  ALTERNATE IND
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA D2B+14     ERROR
       TRA D2B+15     OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA D2B        REPEAT TEST
       REM            
       REM            
       BCD 1RIS       TEST-RESET IND FROM STG
 E     CAL ONES       L ALL ONES
       PAI            SET INDICATORS ON
       RIS ONES       RESET ALL IND OFF
       PIA            SET INDICATORS INTO ACC
       TZE E+6        OK-IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E          REPEAT TEST
       REM            
       REM            
       BCD 1RIS       
 E1    CAL ONES       L ALL ONES
       PAI            TURN ALL INDICATOR ON
       RIS ZERO       IND NOT RESET
       PIA            SET TGRS INTO ACC
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E1+10      ERROR
       TRA E1+11      OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E1         REPEAT TEST
       REM            
       REM            
       BCD 1RIA       TEST-RESET IND FROM ACC
 E2    CAL ONES       L ALL ONES
       PAI            SET INDICATOR ALL ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       RIA            RESET ALL INDICATORS OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA E2         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            CHECK INDICATORS OFF
       TZE *+2        OK-IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E2         REPEAT TEST
       REM            
       REM            
       BCD 1RIA       
 E3    CAL ONES       L ALL ONES
       PAI            TURN ON ALL INDICATORS
       CLA ZERO       L +0
       RIA            SHOULD NOT RESET
       PIA            IND TO ACC AND CHECK
       SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP       L SAVED ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E3         REPEAT TEST
       REM            
       REM            
       BCD 1STI       TEST-STORE INDICATORS
 E3A   CLA ZERO       L +0
       PAI            TURN ALL INDICATORS OFF
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       TZE E3A+6      OK-IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E3A        REPEAT TEST
       REM            
       REM            
       BCD 1STI       
 E3B   CAL ONES       L ALL ONES
       PAI            TURN ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E3B+8      ERROR
       TRA E3B+9      OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E3B        REPEAT TEST
       REM            
       REM            
       BCD 1STI       
 E3C   CLA K25        L +154321654321
       PAI            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ K25        L +154321654321
       CAS K25        
       TRA E3C+8      ERROR
       TRA E3C+9      OK-CORRECT IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E3C        REPEAT TEST
       REM            
       REM            
       BCD 1OAI       TEST-OR ACC TO INDICATORS
 E4    CAL ONES       L ALL ONES
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       OAI            TURN ALL INDICATORS ON
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA E4         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       SLW TEMP+1     SAVE ACCUMULATOR
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA E4A        OK ALL IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E4         REPEAT SECTION
       REM            
 E4A   CLA TEMP+1     CHECK SAVED ACCUMULATOR
       CAS ONES       
       TRA E4A+4      ERROR
       TRA E4A+5      OK ACC UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E4         REPEAT TEST
       REM            
       REM            
       BCD 1OAI       
 E5    CAL ONES       L ALL ONES
       OAI            TURN ALL INDICATORS ON
       CLA ZERO       L +0
       OAI            ALL INDICATORS STILL ON
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E5+11      ERROR
       TRA E5+12      OK-IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E5         
       REM            
       REM            
       BCD 1OAI       
 E6    CAL ONES       L ALL ONES
       PAI            ALL IND ON
       RIA            TURN ALL INDICATORS OFF
       CLA K24        L +111111111111
       OAI            TURN 12 INDICATORS ON
       STO TEMP       SAVE ACCUMULATOR
       PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA E6+11      ERROR
       TRA E6A        OK-CORRECT 12 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E6         REPEAT SECTION
       REM            
 E6A   ALS 1          ACC NOW +222222222222
       OAI            IND 333333333333
       STO TEMP+1     SAVE ACCUMULATOR
       PIA            IND TO ACC AND CHECK
       LDQ K28        L +333333333333
       CAS K28        
       TRA E6A+8      ERROR
       TRA E6B        OK-CORRECT 24 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E6         REPEAT SECTION
       REM            
 E6B   CLA K24        L +111111111111
       ALS 2          ACC +P044444444444
       OAI            IND 777777777777
       SLW TEMP+2     SAVE ACCUMULATOR
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E6B+11     ERROR
       TRA E6C        OK-ALL IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E6         REPEAT SECTION
       REM            
       REM CHECK ACCS UNCHANGES
       REM            
 E6C   CLA TEMP       L +111111111111
       ADD TEMP+1     L +222222222222
       SUB TEMP+2     L -044444444444
       CHS            ACC NOW -377777777777
       CAS ONES       
       TRA E6C+7      ERROR
       TRA E6C+8      OK-ACCS UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E6         REPEAT TEST
       REM            
       REM            
       BCD 1OAI       RIPPLE TEST
 E6D   LDI ZERO       ALL INDICATORS OFF
       AXT 36,1       L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       OAI            TURN TESTED IND ON
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA E6D        REPEAT SECTION
       REM            
       CAL TEMP       L LAST POSITION TESTED
       IIA            TURN TESTED IND OFF
       ALS 1          RIPPLE 1 POSITION
       TIX E6D+3,1,1  REPEAT FOR EVERY IND POS
       REM            
*      CHECK NO EFFECT WITH Q BIT
       REM            
       OAI            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK-NO EFFECT WITH Q BIT
       TSX ERROR,4    ERROR
       TSX OK,4       CONTINUE TEST
       TRA E6D        REPEAT TEST
       REM            
       REM            
       BCD 1OAI       TEST-OAI WITH SIGN BIT
 E6D1  LDI ZERO       ALL INDICATORS OFF
       CLA MZE        L -0
       OAI            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK
       TSX ERROR,4    ERROR
       TSX OK,4       CONTINUE TEST
       TRA E6D1       REPEAT TEST
       REM            
       REM            
       BCD 1OSI       TEST OR STORAGE TO IND
 E7    OSI ONES       ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E7+7       ERROR
       TRA E7+8       OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E7         TEST
       REM            
       REM            
       BCD 1OSI       
 E8    CAL ONES       L ALL ONES
       OAI            TURN ALL INDICATORS ON
       OSI ZERO       ALL INDICATORS STILL ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E8+9       ERROR
       TRA E8+10      OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E8         REPEAT TEST
       REM            
       REM            
       BCD 1OSI       
 E9    CAL ONES       L ALL ONES
       PAI            ALL IND ON
       RIA            TURN ALL INDICATORS OFF
       OSI K24        IND 111111111111
       PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA E9+9       ERROR
       TRA E9A        OK-CORRECT 12 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E9         REPEAT SECTION
       REM            
 E9A   OSI K27        IND 333333333333
       PIA            IND TO ACC AND CHECK
       LDQ K28        L +333333333333
       CAS K28        
       TRA E9A+6      ERROR
       TRA E9B        OK-CORRECT 24 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E9         REPEAT SECTION
       REM            
 E9B   OSI K29        ALL IND ON
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E9B+8      ERROR
       TRA E9C        OK-ALL IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E9         REPEAT SECTION
       REM            
       REM CHECK STORAGES UNCHANGED
       REM            
 E9C   CLA K24        L +111111111111
       ADD K27        L +222222222222
       SUB K29        L -044444444444
       CHS            ACC NOW MINUS ALL ONES
       CAS ONES       
       TRA E9C+7      ERROR
       TRA E9C+8      OK-STORAGES UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E9         REPEAT TEST
       REM            
       REM            
       BCD 1OSI       RIPPLE TEST
 E9D   LDI ZERO       ALL INDICATORS OFF
       AXT 36,1       L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       OSI TEMP       TURN TESTED IND ON
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA E9D        REPEAT SECTION
       REM            
       CAL TEMP       L LAST POSITION TESTED
       IIA            TURN TESTED IND OFF
       ALS 1          RIPPLE 1 POSITION
       TIX E9D+3,1,1  REPEAT FOR EVERY IND POS
       TSX OK,4       
       TRA E9D        
       REM            
       REM            
       BCD 1PAI       TEST PLACE ACC IN IND
 E10   CAL ONES       L ALL ONES
       PAI            TURN ALL INDICATORS ON
       SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP       CHECK ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E10+8      ERROR
       TRA E10A       OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E10        REPEAT SECTION
       REM            
 E10A  STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       CAS ONES       
       TRA E10A+5     ERROR
       TRA E10A+6     OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E10        REPEAT TEST
       REM            
       REM            
       BCD 1PAI       
 E11   CLA ZERO       L +0
       PAI            ALL INDICATORS OFF
       TZE E11A       OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E11        REPEAT SECTION
       REM            
 E11A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       TZE E11A+4     OK-IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E11        REPEAT TEST
       REM            
       BCD 1PAI       RIPPLE TEST
 E11B  AXT 36,1       L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       PAI            
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA E11B       REPEAT SECTION
       REM            
       CAL TEMP       L LAST POSITION TESTED
       IIA            TURN OFF IND TESTED
       ALS 1          RIPPLE 1 POSITION
       TIX E11B+2,1,1 REPEAT FOR EACH IND POS
       REM            
*      CHECK NO EFFECT WITH Q BIT
       REM            
       PAI            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK-NO EFFECT WITH Q BIT
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E11B       REPEAT TEST
       REM            
       REM            
       BCD 1PAI       TEST-PAI WITH SIGN BIT
 E11B1 CLA ONES       L ALL ONES
       PAI            IND 37777777777
       PIA            IND TO ACC AND CHECK
       CHS            ACC NOW MINUS ALL ONES
       CAS ONES       
       TRA *+2        ERROR
       TRA *+3        OK
       LDQ ONES       L ALL ONES TO MQ
       TSX ERROR,4    ERROR
       TSX OK,4       CONTINUE TEST
       TRA E11B1      REPEAT TEST
       REM            
       REM            
       BCD 1LDI       TEST-LOAD INDICATORS
 E12   LDI ONES       ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E12+7      ERROR
       TRA E12+8      OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E12        REPEAT TEST
       REM            
       REM            
       BCD 1LDI       
 E13   LDI ZERO       ALL INDICATORS OFF
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       TZE E13+5      OK IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E13        REPEAT TEST
       REM            
       REM            
       BCD 1PIA       TEST-PLACE IND IN ACC
 E14   CLA ZERO       L +0
       PAI            TURN ALL INDICATORS OFF
       TZE E14A       OK ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E14        REPEAT SECTION
       REM            
 E14A  PIA            IND TO ACC AND CHECK
       TZE E14A+3     OK IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E14        REPEAT TEST
       REM            
       REM            
       BCD 1PIA       
 E15   LDI ONES       ALL INDICATORS ON
       PIA            IND TO ACC AND CHECK
       ARS 1          CLEAR P
       CHS            ACC NOW -377777777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E15+8      ERROR
       TRA E15+9      OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E15        REPEAT TEST
       REM            
       REM            
       BCD 1PIA       
 E16   CLA K3         L-377777077777
       PAI            IND 377777077777
       PIA            ACC +377777077777
       CHS            ACC NOW -377777077777
       LDQ K3         L -377777077777
       CAS K3         
       TRA E16+8      ERROR
       TRA E16+9      OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E16        REPEAT TEST
       REM            
       REM            
       BCD 1IIA       TEST-INVERT INDICATORS
       REM            
 E20   CAL ONES       L ALL ONES
       PAI            ALL INDICATORS ON
       IIA            ALL INDICATORS OFF
       PIA            IND TO ACC AND CHECK
       TZE E20+6      OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E20        REPEAT TEST
       REM            
       REM            
       BCD 1IIA       
 E21   LDI ZERO       ALL INDICATORS OFF
       CAL ONES       L ALL ONES
       IIA            ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       SLW TEMP+1     SAVE ACCUMULATOR
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E21+10     ERROR
       TRA E21A       OK-ALL IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E21        REPEAT SECTION
       REM            
 E21A  CLA TEMP+1     CHECK SAVED ACCUMULATOR
       CAS ONES       
       TRA E21A+4     ERROR
       TRA E21A+5     OK-ACC UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E21        REPEAT TEST
       REM            
       REM            
       BCD 1IIA       
 E22   CAL ONES       L ALL ONES
       LDI ZERO       ALL INDICATORS OFF
       IIA            ALL INDICATORS ON
       IIA            ALL INDICATORS OFF
       IIA            ALL INDICATORS ON
       IIA            ALL INDICATORS OFF
       PIA            IND TO ACC AND CHECK
       TZE E22+9      OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E22        REPEAT TEST
       REM            
       REM            
       BCD 1IIA       RIPPLE TEST
 E22A  AXT 36,1       L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       LDI TEMP       TURN ON IND TESTING
       IIA TEMP       TURN OFF IND TESTING
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA E22A       REPEAT SECTION
       REM            
       CAL TEMP       L LAST TESTED POSITION
       ALS 1          RIPPLE 1 POSITION
       TIX E22A+2,1,1 CHECK EACH IND POS
       REM            
*      CHECK NO EFFECT WITH Q BIT
       REM            
       IIA            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E22A       REPEAT TEST
       REM            
       REM            
       BCD 1IIA       TEST-IIA WITH SIGN BIT
 E22A1 LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       IIA            
       PIA            IND TO ACC AND CHECK
       ARS 2          ACC NOW +100000000000
       CAS PTHR       
       TRA *+2        ERROR
       TRA *+3        OK
       LDQ PTHR       L +100000000000
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E22A1      REPEAT TEST
       REM            
       REM            
       BCD 1IIS       TEST-INVERT INDICATORS
       REM            FROM STORAGE
 E23   LDI ONES       ALL INDICATORS ON
       IIS ONES       ALL INDICATORS OFF
       PIA            IND TO ACC ANCHE CHECK
       TZE E23+5      OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E23        REPEAT TEST
       REM            
       REM            
       BCD 1IIS       
 E24   LDI ZERO       ALL INDICATORS OFF
       IIS ONES       ALL INDICATORS ON
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E24+8      ERROR
       TRA E24+9      OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E24        REPEAT TEST
       REM            
       REM            
       BCD 1IIS       
 E25   LDI ONES       ALL INDICATORS ON
       IIS ONES       INDICATORS OFF
       IIS ONES       INDICATORS ON
       IIS ONES       INDICATORS OFF
       IIS ONES       INDICATORS ON
       IIS ONES       INDICATORS OFF
       PIA            IND TO ACC AND CHECK
       TZE E25+9      OK-ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E25        REPEAT TEST
       REM            
       REM            
       BCD 1IIS       RIPPLE TEST
 E25A  LDI ZERO       ALL INDICATORS OFF
       AXT 36,1       L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       IIS TEMP       TESTED INDICATOR ON
       IIS TEMP       TESTED INDICATOR OFF
       PIA            IND TO ACC AND CHECK
       TZE *+3        
       TSX ERROR-1,4  
       TRA E25A       REPEAT SECTION
       REM            
       CAL TEMP       L LAST POSITION TESTED
       ALS 1          RIPPLE 1 POSITION
       TIX E25A+3,1,1 CHECK EACH IND POS
       TSX OK,4       
       TRA E25A      
       REM            
       REM            
       BCD 1TIF       TEST-TRANSFER WHEN IND OFF
 E26   LDI ONES       ALL INDICATORS ON
       CAL ONES       L ALL ONES
       TIF E26+4      NG ALL IND SHOULD BE ON
       TRA E26A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E26        REPEAT SECTION
       REM            
 E26A  ARS 1          CHECK ACC-CLEAR P
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E26A+6     ERROR
       TRA E26A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E26        REPEAT SECTION
       REM            
 E26A1 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       CAS ONES       
       TRA E26A1+5    ERROR
       TRA E26A1+6    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E26        REPEAT TEST
       REM            
       REM            
       BCD 1TIF       
 E27   LDI ONES       ALL INDICATORS ON
       CLA ZERO       L +0
       TIF E27A       IND UNEXAMINED-TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E27        REPEAT SECTION
       REM            
 E27A  TZE E27A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E27        REPEAT SECTION
       REM            
 E27A1 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E27A1+6    ERROR
       TRA E27A1+7    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E27        REPEAT TEST
       REM            
       REM            
       BCD 1TIF       
 E28   LDI ZERO       ALL INDICATORS OFF
       CAL ONES       L ALL ONES
       TIF E28A       IND OFF-TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E28        REPEAT SECTION
       REM            
 E28A  SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP       CHECK ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E28A+6     ERROR
       TRA E28A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E28        REPEAT SECTION
       REM            
 E28A1 PIA            IND TO ACC AND CHECK
       TZE E28A1+3    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E28        REPEAT TEST
       REM            
       BCD 1TIF       
 E29   LDI ZERO       ALL INDICATORS OFF
       CLA ZERO       L +0
       TIF E29A       IND UNEXAMINED -TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E29        REPEAT SECTION
       REM            
 E29A  TZE E29A1      OK ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E29        REPEAT SECTION
       REM            
 E29A1 PIA            IND TO ACC AND CHECK
       TZE E29A1+3    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E29        REPEAT TEST
       REM            
       REM            
       BCD 1TIF       
 E30   LDI K24        L +111111111111
       CAL K29        L -044444444444
       TIF E30A       OK EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
 E30A  SLW TEMP       SAVE ACCUMULATOR
       CLA K28        L+333333333333
       TIF E30A+4     NG IND NOT ALL OFF
       TRA E30A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
 E30A1 STO TEMP+1     SAVE ACCUMULATOR
       CLA K27        L+222222222222
       TIF E30A2      OK EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
       REM            
 E30A2 STO TEMP+2     SAVE ACCUMULATOR
       CLA K24        L+111111111111
       TIF E30A2+4    NG EXAMINED IND ON
       TRA E30A3      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
 E30A3 PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA E30A3+5    ERROR
       TRA E30A4      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30        REPEAT SECTION
       REM            
       REM CHECK ACCS UNCHANGED
       REM            
 E30A4 ADD TEMP+2     L +222222222222
       SUB TEMP+1     L +333333333333
       ADD TEMP+1     
       SUB TEMP       L -044444444444
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E30A4+9    ERROR
       TRA E30A4+10   OK-ACCS UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E30        REPEAT TEST
       REM            
       REM            
       BCD 1TIF       TEST-TRANSFER WHEN
       REM            INDICATORS OFF-RIPPLE TEST
 E30B  LDI ONES       ALL INDICATORS ON
       TOV E30B+2     TURN OFF OVERFLOW LITE
       CAL ONES       L ALL ONES
       IIA            EXAMINED IND OFF
       TIF E30C       EXAMINED IND OFF-TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30B       REPEAT SECTION
       REM            
 E30C  IIA            PUT INDICATOR ON AGAIN
       ALS 1          RIPPLE ONE POSITION
       PBT            
       TOV E30C+5     EVERY POSITION IS TESTED
       TRA E30B+3     REPEAT FOR EACH POSITION
       REM            
       ALS 1          
       TZE E30D       OK ACC CLEAR
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30B       REPEAT SECTION
       REM            
 E30D  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES      
       TRA E30D+6     ERROR
       TRA E30D+7     OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E30B       REPEAT TEST
       REM            
       REM            
       BCD 1TIF       TEST-TRANSFER WHEN
       REM            INDICATORS OFF, RIPPLE TEST
 E30D1 LDI ZERO       ALL INDICATORS OFF
       TOV E30D1+2    TURN OFF OVERFLOW LITE
       CLA ONE        L +1
       PAI            ACC TO IND
       TIF E30D1+6    ERROR-EXAMINED IND ON
       TRA E30E       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E30D1      REPEAT SECTION
       REM            
 E30E  ALS 1          RIPPLE ONE POSITION
       PBT            
       TOV *+2        ALL POSITION TESTED
       TRA E30D1+3    REPEAT FOR EACH POSITION
       TSX OK,4       
       TRA E30D1      
       REM            
       REM            
       BCD 1TIO       TEST-TRANSFER WHEN IND ON
 E31   LDI ONES       ALL INDICATORS ON
       TOV E31+2      TURN OFF OVERFLOW LITE
       CLA ONE        L +1
       AXT 36,1       L +44 IN XRA
       TIO E31A       OK EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E31        REPEAT SECTION
       REM            
 E31A  ALS 1          RIPPLE ONE POSITION
       PBT            
       TOV E31A1      36 POSITIONS TESTED
       TIX E31+4,1,1  REPEAT FOR EACH POSITION
       REM            
 E31A1 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E31A1+6    ERROR
       TRA E31A1+7    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E31        REPEAT TEST
       REM            
       REM            
       BCD 1TIO       
 E32   LDI ONES       ALL INDICATORS ON
       CLA ZERO       L +0
       TIO E32A       IND UNEXAMINED TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E32        REPEAT SECTION
       REM            
 E32A  TZE E32A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E32        REPEAT SECTION
       REM            
 E32A1 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E32A1+6    ERROR
       TRA E32A1+7    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E32        REPEAT TEST
       REM            
       REM            
       BCD 1TIO       
 E33   LDI ZERO       ALL INDICATORS OFF
       CAL ONES       L ALL ONES
       TIO E33+4      NG ALL IND SHOULD BE OFF
       TRA E33A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E33        REPEAT SECTION
       REM            
 E33A  SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP       CHECK ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E33A+6     ERROR
       TRA E33A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E33        REPEAT SECTION
       REM            
 E33A1 PIA            IND TO ACC AND CHECK
       TZE E33A1+3    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E33        REPEAT TEST
       REM            
       REM            
       BCD 1TIO       
 E34   LDI ZERO       ALL INDICATORS OFF
       CLA ZERO       L +0
       TIO E34A       IND UNEXAMINED-TRANSFER
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34        REPEAT SECTION
       REM            
 E34A  TZE E34A1      OK-ACC UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34        REPEAT SECTION
       REM            
 E34A1 PIA            IND TO ACC AND CHECK
       TZE E34A1+3    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E34        REPEAT TEST
       REM            
       REM            
       BCD 1TIO       
 E34B  LDI K24        L +111111111111
       CAL K29        L-044444444444
       TIO E34B+4     NG EXAMINED IND OFF
       TRA E34B1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34B       REPEAT SECTION
       REM            
 E34B1 SLW TEMP       SAVE ACCUMULATOR
       CLA K27        L+222222222222
       TIO E34B1+4    NG EXAMINED IND OFF
       TRA E34B2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34B       REPEAT SECTION
       REM            
 E34B2 STO TEMP+1     SAVE ACCUMULATOR
       CLA K24        L+111111111111
       TIO E34B3      OK-EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34B       REPEAT SECTION
       REM            
       REM CHECK ACCS UNCHANGED
       REM            
 E34B3 ADD TEMP+1     L +222222222222
       SUB TEMP       L -044444444444
       CHS            ACC NOW -377777777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E34B3+7    ERROR
       TRA E34B4      OK ACCS UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E34B       REPEAT SECTION
       REM            
 E34B4 PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA E34B4+5    ERROR
       TRA E34B4+6    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E34B       REPEAT TEST
       REM            
       REM            
       BCD 1TIO       RIPPLE TEST
 E34C  LDI ZERO       ALL INDICATORS OFF
       AXT 36,1       L +44 IN XRA
       CLA ONE        L +1
       PAI            ACC TO IND
       TIO *+3        EXMINED IND ON-TRANSFER
       TSX ERROR-1,4 ERROR
       TRA E34C       REPEAT SECTION
       REM            
       ALS 1          RIPPLE 1 POSITION
       TIX E34C+3,1,1 CHECK EACH INDICATOR POS
       TSX OK,4       
       TRA E34C       
       REM            
       REM            
       BCD 1TIO       RIPPLE TEST
 E34D  LDI ONES       ALL INDICATORS ON
       AXT 36,1       L +44 IN XRA
       CLA ONE        L +1
       IIA            EXMINED IND OFF
       TIO *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ERROR
       TRA E34D       REPEAT SECTION
       REM            
       ALS 1          RIPPLE 1 POSITION
       TIX E34D+3     CHECK EACH IND POSITION
       TSX OK,4       
       TRA E34D       
       REM            
*TEST TIF AND TIO TRAPS IN TRAP MODE
       REM            
       REM            
       BCD 1TIF       TEST TIF IN TRAP MODE
 MODE  CLA TR+3       L TRA MODE1
       STO 2          STORE IN LOC 00002
       LDI K24        L +111111111111
       CAL K29        L -044444444444
       TSX ENTM,2     ENTER TRAP MODE
       TIF *+1        SHOULD TRAP AND
       REM            GO TO LOC 00001
       LTM            LEAVE TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT TRAP
       TRA MODE       AND GO TO LOC 00001
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
 MODE1 CLA            L CONTENTS LOC 00000
       LDQ TR+4       L TRA MODE+5
       CAS TR+4       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    
       TSX OK,4       
       TRA MODE       
       REM            
       REM            
       BCD 1TIO       TEST TIO IN TRAP MODE
 MODE2 CLA TR+5       L TRA MODE 3
       STO 2          STORE IN MOC 00002
       LDI K29        L -044444444444
       CAL K29        
       TSX ENTM,2     ENTER TRAP MODE
       TIO *+1        SHOULD TRAP AND
       REM            GO TO LOC 00001
       LTM            LEAVE TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT TRAP
       TRA MODE2     
       REM            
*CHECK CONTENTS LOCATION 00000
       REM            
 MODE3 CLA 0          L CONTENTS LOC 00000
       LDQ TR+6       L TRA MODE2+5
       CAS TR+6       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    
       TSX OK,4       
       TRA MODE2      
       REM            
       NOP            
       CLA TR+7       L SLW TEMP+2
       STO 2          STORE IN LOC 00002
       TSX STORE,4    TO RESTORE RESET START
       TRA *+2        
       REM            
       REM            
       BCD 1OFT       TEST-OFF TEST FOR IND
 E35   CLA ONES       L ALL ONES
       STO TEMP       
       LDI ONES       ALL INDICATORS ON
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       OFT TEMP       
       TRA *+3        OK-EXAMINED IND NOT ZERO
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E35        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E35A  STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       LDQ ONES       L ALL ONES IN MQ
       CAS ONES       
       TRA E35A+6     ERROR
       TRA E35A1      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E35        REPEAT SECTION
       REM            
 E35A1 CLA TEMP       CHECK STORAGE UNCHANGED
       CAS ONES       
       TRA E35A1+4    ERROR
       TRA E35A1+5    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E35        REPEAT TEST
       REM            
       REM            
       BCD 1OFT       
 E36   CLA ZERO       L +0 
       STO TEMP       SAVE ACCUMULATOR
       LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTRUCTION
       OFT TEMP       IND NOT EXMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E36        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E36A  CLA TEMP       CHECK STORAGE
       TZE E36A1      OK-STORAGE UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E36        REPEAT SECTION
       REM            
 E36A1 STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E36A1+6    ERROR
       TRA E36A1+7    OK-IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E36        REPEAT TEST
       REM            
       REM            
       BCD 1OFT       
 E37   CLA ZERO       L +0
       STO TEMP       SAVE ACCUMULATOR
       LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       OFT TEMP       IND NOT EXAMINED SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E37        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E37A  PIA            IND TO ACC AND CHECK
       TZE E37A1      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E37        REPEAT SECTION
       REM            
 E37A1 CLA TEMP       CHECK STORAGE
       TZE E37A1+3    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E37        REPEAT TEST
       REM            
       REM            
       BCD 1OFT       
 E38   CLA ONES       L ALL ONES
       STO TEMP       SAVE ACCUMULATOR
       LDI ZERO       ALL INDICATORS OFF
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       OFT TEMP       IND OFF-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E38        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E38A  PIA            IND TO ACC AND CHECK
       TZE E38A1      OK ALL IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E38        REPEAT SECTION
       REM            
 E38A1 CLA TEMP       CHECK STORAGE
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E38A1+5    ERROR
       TRA E38A1+6    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E38        REPEAT TEST
       REM            
       REM            
       BCD 1OFT       
 E39   AXT 36,1       L +44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       PAI            ACC TO IND.
       OFT TEMP       
       TRA E39A       OK EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E39        REPEAT SECTION
       REM            
 E39A  ALS 1          RIPPLE 1 POSITION
       TIX E39+2,1,1  REPEAT FOR EACH POSITION
       REM            
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       TMI E39A1      OK-IND HAS ZERO POS BIT
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E39        REPEAT SECTION
       REM            
 E39A1 TZE E39A2      OK IND 1 THRU 35 ARE ZERO
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E39        REPEAT SECTION
       REM            
 E39A2 CLA TEMP       CHECK STORAGE
       TMI E39A3      STORAGE SIGN OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E39        REPEAT SECTION
       REM            
 E39A3 TZE E39A3+2    STORAGE CONTENTS OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E39        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       TEST-ON TEST FOR IND
 E41   CAL ONES       L ALL ONES
       SLW TEMP       SAVE ACCUMULATOR
       LDI ONES       ALL INDICATORS ON
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LLS 1          SHIFT FOR BITS IN Q,P,1-35
       SSM            MAKE ACC SIGN MINUS
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       ONT TEMP       ALL IND ON-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E41        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E41A  STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E41A+6     ERROR
       TRA E41A1      OK IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E41        REPEAT SECTION
       REM            
 E41A1 CLA TEMP       CHECK STORAGE
       CAS ONES       
       TRA E41A1+4    ERROR
       TRA E41A1+5    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E41        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       
 E42   LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       STO TEMP       SAVE ACCUMULATOR
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       ONT TEMP       
       TRA *+3        OK-EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E42        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E42A  PIA            IND TO ACC AND CHECK
       TZE E42A1      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E42        REPEAT SECTION
       REM            
 E42A1 CLA TEMP       CHECK STORAGE
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E42A1+5    ERROR
       TRA E42A1+6    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E42        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       
 E43   LDI ONES       ALL INDICATORS ON
       CLA ZERO       L +0
       STO TEMP       
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       ONT TEMP       IND NOT EXAMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E43        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 E43A  CLA TEMP       CHECK STORAGE
       TZE E43A1      OK-STORAGE UNCHANGE
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E43        REPEAT SECTION
       REM            
 E43A1 STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E43A1+6    ERROR
       TRA E43A1+7    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E43        REPEAT TEST
       REM            
       REM            
       BCD 1ONT      
 E44   LDI ZERO       ALL INDICATORS OFF
       CLA ZERO       L +0
       STO TEMP       SAVE ACCUMULATOR
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       ONT TEMP       IND NOT EXAMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E44        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACC
       REM            
 E44A  PIA            IND TO ACC AND CHECK
       TZE E44A1      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E44        REPEAT SECTION
       REM            
 E44A1 CLA TEMP       CHECK STORAGE
       TZE E44A1+3    OK-STORAGE UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E44        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       
 E45   LDI K24        L +111111111111
       ONT K29        L -044444444444
       TRA E45A       OK-EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E45        REPEAT SECTION
       REM            
 E45A  ONT K27        L +222222222222
       TRA E45A1      OK-EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E45        REPEAT SECTION
       REM            
 E45A1 ONT K24        L +111111111111
       TRA E45A1+3    ERROR
       TRA E45A2      OK-EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E45        REPEAT SECTION
       REM            
 E45A2 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ K24        L +111111111111
       CAS K24        
       TRA E45A2+6    ERROR
       TRA E45A3      OK-IND UNCHANGED
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E45        REPEAT SECTION
       REM            
       REM CHECK STORAGES UNCHANGED
       REM            
 E45A3 CLA K24        L +111111111111
       ADD K27        L +222222222222
       SUB K29        L -044444444444
       CHS            ACC NOW MINUS ALL ONES
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA E45A3+8    ERROR
       TRA E45A3+9    OK-STORAGES UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E45        REPEAT TEST
       REM            
       REM            
       BCD 1ONT       
 E40   AXT 36,1       L ++44 IN XRA
       CLA ONE        L +1
       SLW TEMP       SAVE ACCUMULATOR
       PAI            ACC TO IND
       ONT TEMP       EXAMINED IND ON-SKIP
       TRA E40+7      ERROR
       TRA E40A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E40        REPEAT SECTION
       REM            
 E40A  ALS 1          RIPPLE 1 POSITION
       TIX E40+2,1,1  REPEAT FOR EACH POSITION
       REM            
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       TMI E40A1      OK-IND HAS ZERO POS BIT
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E40        REPEAT SECTION
       REM            
 E40A1 TZE E40A2      OK IND 1 THRU 35 ARE ZERO
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E40        REPEAT SECTION
       REM            
 E40A2 CLA TEMP       CHECK STORAGE
       TMI E40A3      STORAGE SIGN OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA E40        REPEAT SECTION
       REM            
 E40A3 TZE E40A3+2    STORAGE CONTENTS OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA E40        REPEAT TEST
       REM            
       REM            
       BCD 1SIR       TEST-SET IND RIGHT HALF
 F     LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS IN MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       SIR 32767,7    TURN IND 18 THRU 35 ON
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       LDQ K31        L +777777
       CAS K31        
       TRA *+2        ERROR
       TRA *+2        OK IND 18-35 ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F           REPEAT TEST
       REM            
       REM            
       BCD 1SIR       
 F1    LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       SIR 0          
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK-ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F1         REPEAT TEST
       REM            
       REM            
       BCD 1SIR       
 F2    LDI ZERO       ALL INDICATORS OFF
       TSX ENTM,2     TEST PRI 0,4 NO TRAP
       SIR 4681,1     TURN 6 RT HALF IND ON
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F2         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       LDQ K33        L +111111
       CAS K33        
       TRA *+2        ERROR      
       TRA F2A        OK 6 RT HALF IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F2         REPEAT SECTION
       REM            
 F2A   SIR 9362,2     NOW 12 RT HALF IND ON
       PIA            IND TO ACC AND CHECK
       LDQ K34        L +333333
       CAS K34        
       TRA F2A+6      ERROR
       TRA F2A1       OK 12 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F2         REPEAT SECTION
       REM            
 F2A1  SIR 18724,4    NOW IND 18 THRU 35 ON
       PIA            IND TO ACC AND CHECK
       LDQ K31        L +777777
       CAS K31        
       TRA F2A1+6     ERROR
       TRA F2A1+7     OK IND 18-35 ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F2         REPEAT TEST
       REM            
       REM            
       BCD 1SIR       RIPPLE TEST
 F2B   AXT 18,1       L +22 IN XRA
       CLA K38        L SIR INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+4        POSITION 35
       CLA ONE        L +1
       LDI ZERO       ALL IND OFF
       STO TEMP       SAVE ACCUMULATOR
       SIR 1          
       PIA            IND TO ACC AND CHECK
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA F2B        REPEAT SECTION
       REM            
       CLA TEMP       L LAST POSITION TESTED
       ALS 1          RIPPLE 1 POSITION
       ORA K38        ADJUST SIR
       STO F2B+7      INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F2B+5,1,1  CHECK EACH RT HALF POS
       TSX OK,4       
       TRA F2B        
       REM           
       REM           
       BCD 1SIL       TEST-SET IND LEFT HALF
 F3    LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS IN MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEA LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       SIL 32767,7    TURN IND 0 THRU 17ON
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       SUB K31        L +777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F3         REPEAT TEST
       REM            
       REM            
       BCD 1SIL       
 F4    LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS IN MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       SIL 0          
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       TZE *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F4         REPEAT TEST
       REM            
       REM            
       BCD 1SIL       
 F5    LDI ZERO       ALL INDICATORS OFF
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       SIL 4681,1     TURN 6 LEFT HALF IND ON
       REM            
*CHECK CONTENTS OF LOCATION 000000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F5         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       ADD K33        L +111111
       LDQ K24        L +111111111111
       CAS K24        
       TRA *+2        ERROR
       TRA F5A        OK 6 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F5         REPEAT SECTION
       REM            
 F5A   SIL 9362,2     NOW 12 LEFT HALF IND ON
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       ADD K34        L +333333
       LDQ K28        L +333333333333
       CAS K28        
       TRA F5A+8      ERROR
       TRA F5A1       OK 12 IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F5         REPEAT SECTION
       REM            
 F5A1  SIL 18724,4    NOW IND 0 THRU 17 ON
       STI TEMP+2     STORE INDICATORS
       CLA TEMP+2     CHECK INDICATORS
       SUB K31        L +777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F5A1+8     ERROR
       TRA F5A1+9     OK IND 0 THRU 17 ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F5         REPEAT TEST
       REM            
       REM            
       BCD 1SIL       RIPPLE TEST
 F5B   LDI ZERO       ALL INDICATORS OFF
       CLA ONE        L +1
       STO TEMP+1     SAVE ACCUMULATOR
       CLA K38+1      L SIL INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+5        POSITION 35
       AXT 18,1       L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       SLW TEMP       SAVE ACCUMULATOR
       SIL 1          
       STI TEMP+2     
       CLA TEMP+2     
       CAS TEMP       
       TRA *+2        ERROR
       TRA *+4        OK
       LDQ TEMP       L POSITION TESTING
       TSX ERROR-1,4  ERROR
       TRA F5B        REPEAT SECTION
       REM            
       CLA TEMP+1     ADJUST 
       ALS 1          F
       STO TEMP+1     FIELD
       ORA K38+1      ADJUST SIL
       SLW F5B+10     INSTRUCTION
       CAL TEMP       RESTORE SAVED ACC
       IIA            TURN TESTED IND OFF
       TIX F5B+8,1,1  CHECK EACH LEFT HALF POS
       TSX OK,4       
       TRA F5B        
       REM            
       REM            
       BCD 1RIR       TEST-RESET IND RIGHT HALF
 F6    LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS IN MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RIR 0          RT HALF IND UNCHANGED
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK-ALL IND ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F6         REPEAT TEST
       REM            
       REM            
       BCD 1RIR       
 F7    LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS IN S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RIR 32767,7    TURN IND 18 THRU 35 OFF
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       SUB K31        L +777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F7         REPEAT TEST
       REM           
       REM            
       BCD 1RIR       
 F8    LDI ZERO       ALL IND OFF
       SIR 32767,7    IND 18 THRU 35 ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       RIR 18724,4    TURN 6 RT HALF IND OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F8         
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       LDQ K34        L +333333
       CAS K34        
       TRA *+2        ERROR
       TRA F8A        OK-6 IND TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F8         REPEAT SECTION
       REM            
 F8A   RIR 9362,2     NOW 12 RT HALF IND OFF
       PIA            IND TO ACC AND CHECK
       LDQ K33        L +111111
       CAS K33        
       TRA F8A+6      ERROR
       TRA F8A1       OK 12 RT HALF IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F8         REPEAT SECTION
       REM            
 F8A1  RIR 4681,1     NOW ALL IND OFF
       PIA            IND TO ACC AND CHECK
       TZE F8A1+4     OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F8         REPEAT TEST
       REM            
       REM            
       BCD 1RIR       RIPPLE TEST
 F8B   CLA K38+2      L RIR INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+5        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       AXT 18,1       L +22 IN XRA
       PAI            ACC TO IND
       RIR 1          
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F8B        REPEAT SECTION
       REM            
       CLA TEMP       L LAST POSITION TESTED
       ALS 1          RIPPLE 1 POSITION
       STO TEMP       SAVE ACCUMULATOR
       ORA K38+2      ADJUST RIR
       STO F8B+7      INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F8B+6,1,1  CHECK EACH RT HALF POS
       TSX OK,4       
       TRA F8B        
       REM            
       REM            
       BCD 1RIL       TEST-RESET IND LEFT HALF
 F9    LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RIL 0          IND UNCHANGED
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F9         REPEAT TEST
       REM            
       REM            
       BCD 1RIL       
 F10   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RIL 32767,7    TURN IND 0 THRU 17 OFF
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ K31        L +777777
       CAS K31        
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST   
       TRA F10        REPEAT TEST
       REM            
       REM            
       BCD 1RIL       
 F11   LDI ZERO       ALL INDICATORS OFF
       SIL 32767,7    IND 0-17 ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       RIL 18724,4    TURN 6 LEFT HALF IND OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F11        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       ADD K34        L +333333
       LDQ K28        L +333333333333
       CAS K28        
       TRA *+2        ERROR
       TRA F11A       OK-6 IND TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F11        REPEAT SECTION
       REM            
 F11A  RIL 9362,2     NOW 12 LEFT HALF IND OFF
       STI TEMP+1     STORE INDICATORS
       CLA TEMP+1     CHECK INDICATORS
       ADD K33        L +111111
       LDQ K24        L +111111111111
       CAS K24        
       TRA F11A+8     ERROR
       TRA F11A1      OK-NOW 12 IND TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F11        REPEAT SECTION
       REM            
 F11A1 RIL 4681,1     NOW ALL IND OFF
       PIA            IND TO ACC AND CHECK
       TZE F11A1+4    OK-IND 0-17 TURNED OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F11        REPEAT TEST
       REM            
       REM            
       BCD 1RIL       RIPPLE TEST
 F11B  CLA K38+3      L RIL INSTRUCTION
       ORA ONE        WITH BIT IN  
       STO *+8        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       AXT 18,1       L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POS
       SLW TEMP+1     SAVE ACCUMULATOR
       PAI            ACC TO IND
       RIL 1          
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F11B       REPEAT SECTION
       REM            
       CLA TEMP       ADJUST
       ALS 1          F
       STO TEMP       FIELD
       ORA K38+3      ADJUST RIL
       SLW F11B+10    INSTRUCTION
       CAL TEMP+1     RESTORE SAVED ACCUMULATOR
       TIX F11B+7,1,1 CHECK EACH LEFT HALF POS
       TSX OK,4       
       TRA F11B       
       REM            
       REM            
       BCD 1IIR       TEST INVERT INDICATORS OF
       REM            RIGHT HALF
 F12   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       IIR 32767,7    IND 18 THRU 35 OFF
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       SUB K31        L +777777
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F12        REPEAT TEST
       REM            
       REM            
       BCD 1IIR       
 F13   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOCATION OF TEST INSTR
       IIR 0          IND UNCHANGED
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F13        REPEAT TEST
       REM            
       REM            
       BCD 1IIR       
 F14   LDI ZERO       ALL INDICATORS OFF
       SIR 32767,7    IND 18-35 ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       IIR 18724,4    6 RT HALF IND OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F14        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       LDQ K34        L +333333
       CAS K34        
       TRA *+2        ERROR
       TRA F14A       OK-6 IND TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F14        REPEAT SECTION
       REM            
 F14A  IIR 9362,2     NOW 12 RT HALF IND OFF
       PIA            IND TO ACC AND CHECK
       LDQ K33        L +111111
       CAS K33        
       TRA F14A+6     ERROR
       TRA F14A1      OK-12 IND NOW TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F14        
       REM            
 F14A1 IIR 4681,1     NOW ALL IND OFF
       PIA            IND TO ACC AND CHECK
       TZE F14A2      OK-IND 18-35 TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F14        REPEAT SECTION
       REM            
 F14A2 IIR 18724,4    6 RIGHT HALF IND ON
       IIR 9362,2     12 RIGHT HALF IND ON
       IIR 4681,1     IND 18-35 ON
       IIR 32767,7    IND 18-35 OFF
       IIR 32767,7    IND 18-35 ON
       PIA            IND TO ACC AND CHECK
       LDQ K31        L +777777
       CAS K31        
       TRA F14A2+10   ERROR
       TRA F14A2+11   OK IND 18-35 ON
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F14        REPEAT TEST
       REM            
       REM            
       BCD 1IIR       RIPPLE TEST
 F14B  CLA K38+4      L IIR INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+5        POSITION 35
       AXT 18,1       L +22 IN XRA
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       LDI TEMP       TURN ON IND TESTING
       IIR 1          TURN OFF IND TESTING
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F14B       REPEAT SECTION
       REM            
       CLA TEMP       L LAST TESTED POSITION
       ALS 1          RIPPLE 1 POSITION
       ORA K38+4      ADJUST IIR
       STO F14B+7     INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F14B+5,1,1 CHECK EACH RT HALF POS
       TSX OK,4       
       TRA F14B       
       REM            
       REM            
       BCD 1IIL       TEST-INVERT INDICATORS OF
       REM            LEFT HALF
 F15   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       IIL 32767,7    IND 0 THRU 17 OFF
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ K31        L +777777
       CAS K31        
       TRA *+2        ERROR
       TRA *+2        OK IND 0-17 OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F15        REPEAT TEST
       REM            
       REM            
       BCD 1IIL       
 F16   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       IIL 0          IND UNCHANGED
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR
       TRA *+2        OK IND 0-17 OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F16        REPEAT TEST
       REM            
       REM            
       BCD 1IIL       
 F17   LDI ZERO       ALL INDICATORS OFF
       SIL 32767,7    IND 0-17 ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       IIL 18724,4    6 LEFT HALF IND OFF
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F17        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       REM            
       PIA            IND TO ACC AND CHECK
       ADD K34        L +333333
       LDQ K28        L +333333333333
       CAS K28         
       TRA *+2        ERROR
       TRA F17A       OK-6 IND TURNED OFF
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA F17        REPEAT SECTION
       REM            
 F17A  IIL 9362,2     NOW 12 LEFT HALF IND OFF
       PIA            IND TO ACC AND CHECK
       ADD K33        L +111111
       LDQ K24        L +111111111111
       CAS K24        
       TRA F17A+7     ERROR
       TRA F17A1      OK-12 IND NOW TURNED OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F17        REPEAT SECTION
       REM            
 F17A1 IIL 4681,1     NOW ALL IND OFF
       PIA            IND TO ACC AND CHECK
       TZE F17A2      OK ALL IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F17        REPEAT SECTION
       REM            
 F17A2 IIL 18724,4    6 LEFT IND ON
       IIL 9362,2     12 LEFT IND ON
       IIL 4681,1     IND 0-17 ON
       IIL 32767,7    IND 0-17 OFF
       PIA            IND TO ACC AND CHECK
       TZE F17A2+7    OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F17        REPEAT TEST
       REM            
       REM            
       BCD 1IIL       
 F17B  CLA K38+5      L IIL INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+8        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       AXT 18,1       L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       SLW TEMP+1     SAVE ACCUMULATOR
       PAI            ACC TO IND
       IIL 1          
       PIA            IND TO ACC AND CHECK
       TZE *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F17B       REPEAT SECTION
       REM            
       CLA TEMP       ADJUST
       ALS 1          F
       STO TEMP       FIELD
       ORA K38+5      ADJUST IIL
       SLW F17B+10    INSTRUCTION
       CAL TEMP+1     L SAVED ACCUMULATOR
       TIX F17B+7,1,1 CHECK EACH IND POS
       TSX OK,4       
       TRA F17B       
       REM            
       REM            
       BCD 1RFT       TEST-RIGHT HALF IND OFF SET
 F18   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RFT 32767,7    L +777777
       TRA *+3        OK-RT HALF IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F18        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F18A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F18A+6     ERROR
       TRA F18A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F18        REPEAT TEST
       REM            
       REM            
       BCD 1RFT       
 F19   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RFT 0          IND NOT EXAMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F19        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F19A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F19A+6     ERROR
       TRA F19A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F19        REPEAT TEST
       REM            
       REM            
       NOP           
       CLA TR+2       L HTR FOUR
       STA 6          ADJUST LOC 00006
       TRA *+2        
       REM            
       REM            
       BCD 1RFT       
 F20   LDI ZERO       ALL INDICATORS OFF
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       RFT 0          IND NOT EXAMINED SKIP
       TTR *+13       ERROR-SHOULD SKIP
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F20        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       TRA F20AA      OK
       REM            
       LTM            
       TSX ERROR-1,4  ERROR-DID NOT SKIP
       TRA F20        REPEAT SECTION
       REM            
 F20AA PIA            IND TO ACC AND CHECK
       TZE F20AA+3    OK ALL IND OFF
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F20        REPEAT TEST
       REM            
       REM            
       BCD 1RFT       RFT RIPPLE TEST
 F20A  AXT 18,1       L +22 IN XRA
       CLA K38+6      L RFT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO F20A+6     POSITION 35
       CLA ONE        L +1
       PAI            LOAD INDICATORS WITH THE
       REM            ONE BIT BEING TESTED
       RFT 1          
       TRA F20B       OK EXAMINED IND ON
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F20A       REPEAT SECTION
       REM            
 F20B  ALS 1          RIPPLE 1 POSITION
       ORA K38+6      ADJUST RFT
       STO F20A+6     INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F20A+5,1,1 REPEAT FOR ALL RT HALF
       TSX OK,4       
       TRA F20A       
       REM            
       REM            
       BCD 1RFT       RFT RIPPLE TEST
 F20B1 LDI ONES       ALL INDICATORS ON
       CLA K38+6      L RFT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO F20B1+7    POSITION 35
       AXT 18,1       L +22 IN XRA
       CLA ONE        L +1
       IIA            TURN INDICATOR OFF THAT
       REM            IS BEING CHECKED
       RFT 1          
       TRA F20B1+10   ERROR
       TRA F20C       OK EXAMINED IND OFF
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F20B1      REPEAT SECTION
       REM            
 F20C  IIA            RESET INDICATOR THAT
       REM            WAS JUST TESTED
       ALS 1          RIPPLE 1 POSITION
       ORA K38+6      ADJUST RFT
       STO F20B1+7    INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F20B1+6,1,1 REPEAT FOR RT HALF
       TSX OK,4       
       TRA F20B1      
       REM            
       REM            
       BCD 1RFT       
 F21   LDI K24        L +111111111111
       IIR 4681,1     TURN RT HALF IND OFF
       RFT 18724,4    EXAMINED IND OFF-SKIP
       TRA F21+5      ERROR
       TRA F21A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F21        REPEAT SECTION
       REM            
 F21A  RFT 9362,2     EXAMINED IND OFF-SKIP
       TRA F21A+3     ERROR
       TRA F21A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F21        REPEAT SECTION
       REM            
 F21A1 RFT 4681,1     EXAMINED IND OFF-SKIP
       TRA F21A1+3    ERROR
       TRA F21A1+4    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F21        REPEAT TEST
       REM            
       REM            
       BCD 1RFT       
 F22   LDI ZERO       ALL INDICATORS OFF
       SIR 4681,1     TURN 6 IND ON
       RFT 18724,4    EXAMINED IND OFF-SKIP
       TRA F22+5      ERROR
       TRA F22A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F22        REPEAT SECTION
       REM            
 F22A  RFT 9362,2     EXAMINED IND OFF-SKIP
       TRA F22A+3     ERROR
       TRA F22A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F22        REPEAT SECTION
       REM            
 F22A1 RFT 14043,3    EXAMINED IND NOT OFF
       TRA F22A2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F22        REPEAT SECTION
       REM            
 F22A2 PIA            IND TO ACC AND CHECK
       LDQ K33        L +111111
       CAS K33        
       TRA F22A2+5    ERROR
       TRA F22A2+6    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F22        REPEAT TEST
       REM            
       REM            
       BCD 1LFT       TEST-LEFT HALF INDICATOR
       REM            OFF TEST
 F23   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITA TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       LFT 32767,7    EXMINED IND ON
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F23        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F23A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F23A+6     ERROR
       TRA F23A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F23        REPEAT TEST
       REM            
       REM            
       BCD 1LFT       
 F24   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       LFT 0          IND NOT EXAMINED-SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F24        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F24A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F24A+6     ERROR
       TRA F24A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F24        REPEAT TEST
       REM           
       REM           
       BCD 1LFT       
 F25   LDI K24        L +111111111111
       IIL 4681,1     TURN OFF LEFT HALF IND
       TSX ENTM,2     TEST PRI OP 0,4 NOT TRAP
       LFT 18724,4    EXAMINED IND OFF-SKIP
       TTR *+13       ERROR-SHOULD SKIP
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F25        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       TRA F25A       OK
       REM            
       LTM            EXIT TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT SKIP
       TRA F25        REPEAT SECTION
       REM            
 F25A  LFT 9362,2     EXAMINED IND OFF-SKIP
       TRA F25A+3     ERROR
       TRA F25A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F25        REPEAT SECTION
       REM            
 F25A1 LFT 4681,1     EXAMINED IND OFF-SKIP
       TRA F25A1+3    ERROR
       TRA F25A1+4    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F25        REPEAT TEST
       REM            
       REM            
       BCD 1LFT       
 F26   LDI ZERO       ALL INDICATORS OFF
       SIL 4681,1     TURN ON 6 LEFT HALF IND
       LFT 18724,4    EXAMINED IND OFF-SKIP
       TRA F26+5      ERROR
       TRA F26A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F26        REPEAT SECTION
       REM            
 F26A  LFT 9362,2     EXAMINED IND OFF-SKIP
       TRA F26A+3     ERROR
       TRA F26A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F26        REPEAT SECTION
       REM            
 F26A1 LFT 14043,3    EXAMINED IND ON
       TRA F26A2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F26        REPEAT SECTION
       REM            
 F26A2 STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       ADD K33        L +111111
       LDQ K24        L +111111111111
       CAS K24        
       TRA F26A2+7    ERROR
       TRA F26A2+8    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F26        REPEAT TEST
       REM            
       REM            
       BCD 1LFT       RIPPLE TEST
 F26B  CLA K38+7      L LFT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+9        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       LDI ONES       ALL INDICATORS ON
       AXT 18,1       L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       SLW TEMP+1     SAVE ACCUMULATOR
       IIA            TURN TESTED IND OFF
       LFT 1          
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F26B       REPEAT SECTION
       REM            
       IIA            RESET TESTED IND
       CLA TEMP       L SAVED ACCUMULATOR
       ALS 1          RIPPLE 1 POSITION
       STO TEMP       SAVE ACCUMULATOR
       ORA K38+7      ADJUST LFT
       SLW F26B+11    INSTRUCTION
       CAL TEMP+1     L SAVED ACCUMULATOR
       TIX F26B+8,1,1 CHECK EACH IND POSITION
       TSX OK,4       
       TRA F26B       
       REM            
       BCD 1LFT       RIPPLE TEST
 F26C  CLA K38+7      L LFT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO *+9        POSITION 35
       CLA ONE        L +1
       STO TEMP       SAVE ACCUMULATOR
       LDI ZERO       ALL INDICATORS OFF
       AXT 18,1       L +22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       SLW TEMP+1     SAVE ACCUMULATOR
       IIA            TURN TESTED IND ON
       LFT 1          
       TRA *+3        OK
       TSX ERROR-1,4  ERROR
       TRA F26C       
       REM            
       IIA            TURN TEST IND OFF
       CLA TEMP       L SAVED ACCUMULATOR
       ALS 1          RIPPLE 1 POSITION
       STO TEMP       SAVE ACCUMULATOR
       ORA K38+7      ADJUST LFT
       SLW F26C+11    INSTRUCTION
       CAL TEMP+1     L SAVED ACCUMULATOR
       TIX F26C+8,1,1 CHECK EACH IND POS
       TSX OK,4       
       TRA F26C       
       REM            
       REM            
       BCD 1RNT       TEST-RIGHT HALF IND ON TEST
 F28   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RNT 32767,7    EXAMINED IND ON SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F28        REPEAT SECTION
       REM            
       TSX ACC,2      TO TEST ACCUMULATOR
       REM            
 F28A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F28A+6     ERROR
       TRA F28A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F28        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F29   LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       RNT 32767,7    EXAMINED IND OFF
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F29        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F29A  PIA            IND TO ACC AND CHECK
       TZE F29A+3     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F29        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F30   LDI ONES       ALL INDICATORS ON
       TSX ENTM,2     TEST PRI 0,4 NO TRAP
       RNT 0          IND NOT EXAMINED-SKIP
       TTR *+13       ERROR-SHOULD SKIP
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F30        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       TRA F30A       OK
       REM            
       LTM            EXIT TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT SKIP
       TRA F30        REPEAT SECTION
       REM            
 F30A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F30A+6     ERROR
       TRA F30A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F30        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F31   LDI ZERO       ALL INDICATORS OFF
       RNT 0          IND NOT EXAMINED-SKIP
       TRA F31+4      ERROR
       TRA F31A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F31        
       REM            
 F31A  PIA            IND TO ACC AND CHECK
       TZE F31A+3     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F31        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F32   LDI K24        L +111111111111
       RNT 18724,4    EXAMINED IND OFF
       TRA F32A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F32        REPEAT SECTION
       REM            
 F32A  RNT 9362,2     EXAMINED IND OFF
       TRA F32A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F32        REPEAT SECTION
       REM            
 F32A1 RNT 4681,1     EXAMINED IND ON-SKIP
       TRA F32A1+3    ERROR
       TRA F32A2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F32        REPEAT SECTION
       REM            
 F32A2 PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA F32A2+5    ERROR
       TRA F32A2+6    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F32        REPEAT TEST
       REM            
       REM            
       BCD 1RNT       
 F27   AXT 18,1       L +22 IN XRA
       CLA K38+8      L RNT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO F27+6      POSITION 35
       CLA ONE        L +1
       PAI            ACC TO IND
       RNT 1          EXAMINED IND ON-SKIP
       TRA F27+9      ERROR
       TRA F27A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F27        REPEAT SECTION
       REM            
 F27A  ALS 1          RIPPLE 1 POSITION
       ORA K38+8      ADJUST RNT
       STO F27+6      INSTRUCTION
       ANA K31        L +777777-ADJUST ACC
       TIX F27+5,1,1  REPEAT EACH RT HALF POS
       REM            
 F27A1 LDQ K35        L +400000
       STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       CAS K35        POS TESTED
       TRA F27A1+6    ERROR
       TRA F27A1+7    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F27        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       TEST-LEFT HALF IND ON TEST
 F34   LDI ONES       ALL INDICATORS ON
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       LNT 32767,7    EXAMINED IND ON SKIP
       TRA *+2        ERROR
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F34        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F34A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F34A+6     ERROR
       TRA F34A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F34        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F35   LDI ZERO       ALL INDICATORS OFF
       CLA ONES       L ALL ONES
       LDQ MTW        BITS TO MQ POSITIONS S,1
       LGL 2          BITS TO ACC S,Q,P,1-35
       STZ TEMP+2     CLEAR LOCATION
       STL TEMP+2     LOC OF TEST INSTR
       LNT 32767,7    EXAMINED IND OFF
       TRA *+3        OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F35        REPEAT SECTION
       REM            
       TSX ACC,2      TO CHECK ACCUMULATOR
       REM            
 F35A  PIA            IND TO ACC AND CHECK
       TZE F35A+3     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F35        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F36   LDI ONES       ALL INDICATORS ON
       TSX ENTM,2     TEST PRI OP 0,4 NO TRAP
       LNT 0          IND UNEXAMINED SKIP
       TTR *+13       ERROR-SHOULD SKIP
       REM            
*CHECK CONTENTS OF LOCATION 00000
       REM            
       LTM            EXIT TRAP MODE
       SLW TEMP+2     SAVE ACCUMULATOR
       CLA            L CONTENTS LOC 00000
       LDQ END+1      L TRA START-3
       CAS END+1      
       TRA *+2        ERROR
       TRA *+4        OK
       TSX ERROR-1,4  
       TRA F36        
       REM            
       TSX STORE,4    TO RESTORE RESET START
       CAL TEMP+2     RESTORE ACCUMULATOR
       TRA F36A       OK
       REM            
       LTM            EXIT TRAP MODE
       TSX ERROR-1,4  ERROR-DID NOT SKIP
       TRA F36        REPEAT SECTION
       REM            
 F36A  STI TEMP       STORE INDICATORS
       CLA TEMP       CHECK INDICATORS
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA F36A+6     ERROR
       TRA F36A+7     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F36        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F37   LDI ZERO       ALL INDICATORS OFF
       LNT 0          IND NOT EXAMINED-SKIP
       TRA F37+4      ERROR
       TRA F37A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F37        REPEAT SECTION
       REM            
 F37A  PIA            IND TO ACC AND CHECK
       TZE F37A+3     OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F37        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F38   LDI K24        L +111111111111
       LNT 18724,4    EXAMINED IND OFF
       TRA F38A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F38        REPEAT SECTION
       REM            
 F38A  LNT 9362,2     EXAMINED IND OFF
       TRA F38A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F38        REPEAT SECTION
       REM            
 F38A1 LNT 4681,1     EXAMINED IND ON SKIP
       TRA F38A1+3    ERROR
       TRA F38A2      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F38        REPEAT SECTION
       REM            
 F38A2 PIA            IND TO ACC AND CHECK
       LDQ K24        L +111111111111
       CAS K24        
       TRA F38A2+5    ERROR
       TRA F38A2+6    OK IND UNCHANGED
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F38        REPEAT TEST
       REM            
       REM            
       BCD 1LNT       
 F33   CLA ONE        L +1
       STO TEMP+1     SAVE ACCUMULATOR
       CLA K38+9      L LNT INSTRUCTION
       ORA ONE        WITH BIT IN
       STO F33+9      POSITION 35
       AXT 18,1       L 22 IN XRA
       CLA K35        L +400000
       ALS 1          RIPPLE 1 POSITION
       PAI            ACC TO IND 
       LNT 1          
       TRA F33+12     ERROR
       TRA F33A       OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F33        REPEAT SECTION
       REM            
 F33A  SLW TEMP       SAVE ACCUMULATOR
       CLA TEMP+1     ADJUST
       ALS 1          F
       STO TEMP+1     FIELD
       ORA K38+9      ADJUST LNT
       SLW F33+9      INSTRUCTION
       CAL TEMP       RESTORE SAVED ACC
       TIX F33+7,1,1  REPEAT EACH LEFT HALF POS
       REM            
       STI TEMP+2     STORE INDICATORS
       CLA TEMP+2     CHECK INDICATORS
       TMI F33A1      OK
       TSX ERROR-1,4  TO ERROR ROUTINE
       TRA F33        REPEAT SECTION
       REM            
 F33A1 TZE F33A1+2    OK
       TSX ERROR,4    TO ERROR ROUTINE
       TSX OK,4       CONTINUE TEST
       TRA F33        REPEAT TEST
       REM           
       NOP           
       REM           
       REM           
 AAA   SWT 5         TEST SENSE SWITCH 5
       TRA END       BYPASS ALL HALT
       REM           TESTS AND ADDER TESTS
       REM           
       CLA PLUS+3    INSERT BYPASS HALTS
       STO AAA+2     ON THE NEXT PASS
       TRA SLSW      
       REM           
       REM HALT TESTS 
       REM           
       REM           
       BCD 1SL-SW    CHECK SENSE SWITCHES INSTR
       REM           WITH SENSE LIGHTS
 SLSW  SLF           ALL SENSE LIGHTS OFF
       AXT 4,1       L 4 IN XRA
       SLN 5,1       TURN ON FOUR
       TIX *-1,1,1   SENSE LIGHTS
       REM           
       SWT 1         TEST SWITCH 1
       NOP           
       SLT 1         IS SENSE LIGHT 1 ON
       HTR *+1       NO-ERROR
       SWT 2         TEST SWITCH 2
       NOP           
       SLT 2         IS SENSE LIGHT 2 ON
       HTR *+1       NO-ERROR
       SWT 3         TEST SWITCH 3
       NOP           
       SLT 3         IS SENSE LIGHT 3 ON
       HTR *+1       NO-ERROR
       SWT 4         TEST SWITCH 4
       NOP           
       SLT 4         IS SENSE LIGHT 4 ON
       HTR *+4       NO-ERROR
       TSX OK,4      
       TRA SLSW      
       REM           
       REM           
       BCD 1DVH      DVH TEST
 B59   CLA ONE       BRING ONE IN ACC
       DVH ZERO      DIVIDE BY ZERO, SHOULD
       SUB ONE       HALT WITH DCT ON
       TZE B59+5     RESULT SHOULD BE ZERO
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      
       TRA B59       
       REM           
       REM           
       BCD 1DVH      DVH TEST WITH HALT
 B60   CLA ONE       DIVIDE ACC BY EQUAL AND
       DVH ONE       STORE, SHOULD HALT
       SUB ONE       TEST ACC SHOULD BE ONE
       TZE B60+5     OK, PROCEED
       TSX ERROR,4   
       TSX OK,4      
       TRA B60       
       REM           
       REM           
       BCD 1DVH      DVH TEST WITH HALT
 B61   CLA PTW       PLACE BIT IN Q POSITION
       ALS 2         SO ACC GREATER THEN STO
       DVH PTW       SHOULD HALT
       TNZ B61+5     OK, SHOULD NOT BE ZERO
       TSX ERROR,4   
       TSX OK,4      
       TRA B61       
       REM           
       REM           
       BCD 1VDH      
 A46X  DCT           TURN OFF DIV-CHECK LIGHT
       TRA *+1       
       LDQ K36       L +377777777776
       CLA K2        L +700000
       VDH K2,0,18   L +700000
       DCT           CHECK SETTING TRG
       TRA A46A      OK-DIV-CHECK LITE WAS ON
       REM           DIVISION DID NOT TAKE PLACE
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A46X      
       REM           
 A46A  STQ TEMP      SAVE MQ
       LDQ K2        L +700000 MQ, ACC SHOULD
       REM           BE THE SAME
       CAS K2        CHECK ACC UNCHANGED
       TRA A46A+5    ERROR
       TRA A46A1     OK-ACC UNCHANGED
       TSX ERROR-1,4 TO ERROR ROUTINE
       TRA A46X      
       REM           
 A46A1 CLA TEMP      CHECK SAVED MQ
       LDQ K36       L +37777777776 MQ, ACC
       REM           SHOULD BE THE SAME
       CAS K36       CHECK MQ UNCHANGED
       TRA A46A1+5   ERROR
       TRA A46A1+6   OK-MQ UNCHANGED
       TSX ERROR,4   TO ERROR ROUTINE
       TSX OK,4      CONTINUE TEST
       TRA A46X      
       REM           
       REM           
       BCD 1ENK      TEST-ENTER KEYS
 KY    HTR *+1       STOP-PUT ONES IN KEYS
       ENK           ONES IN MQ FROM KEYS
       CLM           CLEAR ACC
       LLS 35        MOVE MQ TO ACC
       LDQ ONES      L ALL ONES TO MQ
       CAS ONES      
       TRA *+2       ERROR
       TRA *+3       OK
       TSX ERROR-1,4 ERROR
       TRA KY        REPEAT SECTION
       REM           
       HTR KY1       STOP-PUT ZEROS IN KEYS
 KY1   ENK           ZEROS IN MQ FROM KEYS
       CLM           CLEAR ACC
       LLS 35        MOVE MQ TO ACC
       TZE *+2       OK
       TSX ERROR,4   ERROR
       TSX OK,4      
       TRA KY        
       REM           
       REM            
*TEST CONSOLE DISPLAY BUTTONS WITH HTR AND HPR
       REM            
       REM            
       BCD 1BUTTON    DISPLAY IND BUTTON WITH HTR
BUT    CLA DIS        L TRA BUT+6
       STO 32K        PUT IN LAST STORAGE LOC
       CLA DIS+1      L HTR BUT+7
       STO 0          PUT IN LOC 00000
       LDI 8CF        INDICATORS 21-35 ON
       HTR            
       REM            
*PUT MACHINE IN MANUAL-HIT DISPLAY IND BUTTON-PUT MACHINE IN AUTOMATIC
*HIT START TWICE AND PROGRAM SHOULD CONTINUE.
*IF PROGRAM TRANSFERRED TO INDICATOR ADR DIPLSAYED IN SR,
*YOU WILL GET AN ERROR STOP AT THE NEXT HPR
       REM            
       HTR *+4        ERROR STOP
       TSX OK,4       
       TRA BUT        
       REM            
       REM            
       BCD 1BUTTON    DISPLAY STG BUTTON WITH HTR
 BUT1  CLA DIS+2      L TRA BUT1+5
       STO 32K        PUT IN LAST STORAGE LOC
       CLA DIS+3      L TRA BUT1+6
       STO 0          PUT IN LOC 00000
       HTR           
       REM           
*PUT MACHINE IN MANUAL-PUT ADDRESS16433IN KEYS AND HIT
*DISPLAY STG BUTTON-NOW PUT MACHINE IN AUTOMATIC
*HIT START TWICE AND PROGRAM SHOULD CONTINUE.
*IF PROGRAQM TRANSFERRED TO ADDRESS DISPLAYED IN SR,
*YOU WILL GET AN ERROR STOP AT THE FOLLOWING HTR
       REM           
       HTR *+4        ERROR STOP
       TSX OK,4      
       TRA BUT1      
       REM           
       REM           
       BCD 1BUTTON    DISPLAY EFFECTIVE ARD
       REM            BUTTON WITH HTR
 BUT4  CLA DIS+6      L TRA BUT4+6
       STO 32K        PUT IN LAST STORAGE LOC
       CLA DIS+7      L TRA BUT4+7
       STO 0          PUT IN LOCATION 000000
       AXT 32K,1      L 77777 IN XRA
       HTR 32K,1     
       REM           
*PUT MACHINE IN MANUL-HIT DISPLAY EFFECTIVE ADR BUTTON-
*PUT MACHINE IN AUTOMATIC-HIT START TWICE AND PROGRAM SHOULD CONTINUE
*IF PROGRAM TRANSFERRED TO ADDRESS 77777,
*YOU WILL GET AN ERROR STOP AT THE FOLLOWING HTR
       REM           
       HTR *+4        ERROR STOP
       TSX OK,4      
       TRA BUT4      
       REM           
       REM           
       BCD 1BUTTON    DISPLAY IND BUTTON WITH HPR
 BUT2  CLA DIS+4      L TRA BUT2+5
       STO 32K        PUT IN LAST STORAGE LOC
       LDI 8CF        INDICATORS 21-35 ON
       HPR           
       REM           
*PUT MACHINE IN MANUAL, HIT DISPLAY IND BUTTON-PUT MACHINE IN AUTOMATIC
*AND HIT START BUTTON-SHOULD CONTINUE PROGRAM
*IF PROGRAM TRANSFERRED TO INDICATOR ADR DISPLAYED IN SR.
*YOU WILL GET AN ERROR STOP AT NEXT HPR
       REM           
       TRA *+3        HPR WORKED OK
       HPR            ERROR STOP
       TRA *+4       
       TSX OK,4      
       TRA BUT2      
       REM           
       REM           
       BCD 1BUTTON    DISPLAY STG BUTTON WITH HPR
 BUT3  CLA DIS+5      L TRA BUT3+4
       STO 32K        PUT IN LAST STORAGE LOC
       HPR           
       REM           
*PUT MACHINE IN MANUAL-PUT ADDRESS16433IN KEYS AND HIT
*DISPLAY STG BUTTON-NOW PUTMACHINE IN AUTOMATIC
*AND HIT START BUTTON-SHOULD CONTINUE PROGRAM
*IF PROGRAM TRANSFERRED TO ADDRESS DISPLAYED IN SR,
*YOU WILL GET AN ERROR STOP AT THE NEXT HPR
       REM           
       TRA *+3        HPR WORKED OK
       HPR            ERROR STOP
       TRA *+4       
       TSX OK,4      
       TRA BUT3      
       REM           
       REM           
       BCD 1BUTTON    DISPLAY EFFECTIVE ADR
       REM            BUTTON WITH HPR
 BUT5  CLA DIS+8      L TRA BUT5+5
       STO            
       AXT 32K,1      L 77777 IN XRA
       HPR 32K,1      
       REM            
*PUT MACHINE IN MANUAL-HIT DISPLAY EFFECTIVE ADR BUTTON
*PUT MACHINE IN AUTOMATIC-HIT START AND PROGRAM SHOULD CONTINUE
*IF PROGRAM TRANSFERRED TO MODIFIED ADDRESS,
*YOU WILL GET AN ERROR STOP AT THE FOLLOWING HPR
       REM            
       TRA *+3        HPR WORKED OK
       HPR            ERROR STOP
       TRA *+4        
       TSX OK,4       
       TRA BUT5       
       REM            
       NOP            
       TSX STORE,4    TO RESTORE RESET START
       TRA *+2        
       REM            
       REM            
       BCD 1MPY       TEST ZERO MULTIPLICAND
       REM            EXECUTED IN AN I,E CYCLE
 TI    HPR            MPY TEST CARD IN CARD
       REM            READER AND READY READER
       STZ TEMP       CLEAR LOCATION
       AXT 611,1      L 1143 IN XRA
       RCDA           SELECT CARD READER
       RCHA CW+7      
       REM            
*LOOP IN THE NEXT 2 INSTRUCTIONS UNTIL 9L ROW IS READ INTO STORAGE
       REM            
       NZT TEMP       HAS 9L ROW BEEN READ
       TRA *-1        NO
       LDQ ONES       YES, -377777777777 TO MQ
       MPY ZERO       MULTIPLICAND ALL ZEROS
       TIX *-2,1,1    LOOP 611 DECIMAL TIMES
       SCHA TEMP+1    STORE BUFFER REGISTERS
       REM            
*IF MPY WITH ZERO MULTIPLICAND IS OPERATING CORRECTLY IN 2 CYCLES,
*THE ADDRESS RESISTER IN THE BUFFER SHOULD HAVE BEEN INCREASED TO
*INDICATE 8 DECIMAL WORDS READ WITHIN THE TIME ALLOTTED. COMPUTING
*FOR CARD READER AND SAFTY FACTOR TIMINGS, THE PROGRAM WILL
*USE THE CONTENTS OF THE ADDRESS REGISTER AS IF 10 DECIMAL WORDS
*WERE READ FOR A COMPARISON. IF THE ADDRESS REGISTER
*INDICATES 10 OR LESS DECIMAL WORDS READ, MPY WITH ZERO
*MULTIPLICAN IS EXECUTING IN 2 CYCLES. IF MPY IS EXECUTING
*IN 20 CYCLES IN ERROR, THE ADDRESS REGISTER WILL HAVE BEEN
*STEPPED TO INDICAET 24 DECIMAL WORDS READ.
       REM            
       CLA TEMP+1     L CONTENTS BUFFER REGISTERS
       LDQ K35+1      
       CAS K35+1      
       TRA *+3        ERROR-ADDRESS REGISTER
       REM            STEPPED TOO HIGH
       TRA *+5        OK
       TRA *+4        OK
       SWT 3          ERROR-IS PRINTER ON LINE
       TRA TI1        YES, PRINT ERROR INDICATION
       HTR ADD        NO-MQ POS. 21-35 CONTAIN
       REM            HIGHEST ADDRESS BUFFER AR
       REM            SHOULD HAVE BEEN STEPPED
       REM            COMPARE WITH ACC POS 21-35
       TSX OK,4       
       TRA TI         
       REM           
       REM           
       REM           ADDER TEST
       REM           
       REM           
       BCD 1ADD      
 ADD   AXT 4K,2      L 7777
       CLA 4095,2    BRING IN LOC STORAGE
       COM           
       ADD 4095,2    MAKE ALL ONES
       TOV ADD+5     TURN OFF OVFL
       TPL PLUS      
       TMI MINUS     
       TSX ERROR-1,4 SIGN ERROR
       TRA ADD       
       REM           
 MINUS SUB ONE       FORCE RIPPLE
       TZE OVFL      
       TSX ERROR-1,4 
       TRA ADD       
 PLUS  ADD ONE       FORCE RIPPLE
       TZE OVFL      
       TSX ERROR-1,4 FAILURE IN TZE INSTRUCTION
       TRA ADD       
       REM           
       REM           
       REM           
       REM           
 OVFL  TNO SS        TEST OVFL SHOULD BE ON
       TOV SS1       SHOULD BE OFF NOW
       CLA 4095,2    BRING IN LOC
       CAS 4095,2    COMPARE TO STORAGE
       TRA TT        MEMORY LESS
       TRA LOOP     OK
       TRA TT1       MEMORY HIGH
       REM           
 SS    TSX ERROR-1,4 OVFL SHOULD BE ON
       TRA ADD       
       TRA OVFL+2    
       REM           
 SS1   TSX ERROR-1,4 TNO DID NOT TURN OFF OVFL
       TRA ADD       
       TRA OVFL+2    
 TT    TSX ERROR-1,4 MEMORY LESS
       TRA ADD       
       TRA OVFL+2    
       REM           
 TT1   TSX ERROR-1,4 MEMORY HIGH
       TRA ADD       
       TRA OVFL+2    
       REM           
 LOOP  TIX ADD+1,2,1 
       TRA MPY       
       REM           
       REM           
       REM           MPY TEST
       BCD 1MPY      
 MPY   AXT 4K,2      L 7777
       AXT 35,1      L 35
       LDQ ONE       
       RQL 35,1      
       STQ TEMP      SAVE BIT
       MPY 4095,2    MPY BY LOC
       LRS 35,1      
       TZE MPY+10    
       TSX ERROR-1,4 HIGH ORDER PRODUCT ERROR
       TRA MPY       
       REM           
       STQ TEMP+1    
       CLA TEMP+1    
       SUB 4095,2    SUB LOC
       TZE MPY+16    
       TSX ERROR-1,4 LOW ORDER PRODUCT ERROR
       TRA MPY       
       REM           
       TIX MPY+2,1,1 
       TIX MPY+1,2,1 
       TRA DVP       
       REM           
       REM           
       REM           
       REM           MPY AND DVP ALL ONES
       BCD 1DVP      
 DVP   AXT 4K,1      L 7777
       LDQ 4095,1    LDQ WITH LOC
       MPY ONE       
       DVP ONE       
       TZE DVP+7     
       TSX ERROR-1,4 HIGH ORDER ERROR
       TRA DVP       
       REM           
       STQ TEMP      
       CLA 4095,1    BRING IN LOC TO ACC
       SUB TEMP      
       TZE DVP+13    
       TSX ERROR-1,4 LOW ORDER ERROR
       TRA DVP       
       REM           
       TIX DVP+1,1,1 LOOP
       REM           
 END   TSX PR100,4   
       TRA START-3   START ADDRESS
       REM           
       REM THIS ROUTINE IS USED TO PRINT
       REM UPON COMPLETION OF 100 PROGRAM
       REM PASSES.IT ALSO SERVES AS A SENSE
       REM SWITCH 6 TEST
       REM           
 PR100 SWT 6         TEST SENSE SWITCH 6
       TRA CRSL      
       REM           
       SWT 3         TEST SENSE SWITCH 3
       TRA BAR       BEGIN CT FOR 100 PASSES
       TRA 1,4       RETURN TO START ADDRESS
       REM           
 BAR   CLA TOP       COUNT OF 100 DECIMAL
       SUB HAT       L +1
       STO TOP       STORE IN COUNT
       TNZ 1,4       REPEAT TEST TILL ZERO
       CLA TOP+1     RESET
       STO TOP       COUNTER
       REM           
       AXT 11,1      L 13 IN XRA
       WPRA          
       SPRA 3        SPACE PRINTER
       RCHA CW+2     
       LCHA CW+6     
 BOY   LCHA CW+3     
       LCHA CW+6     
       CLA CW+3      
       SUB CLUB      L +2
       STA CW+3      
       TIX BOY,1,1   
       CLA CW+4      RESTORE CONTROL WORD
       STO CW+3      
       TRA 1,4       EXIT TO START ADDRESS
       REM           
 TOP   OCT 144       
       OCT 144       
       OCT 0         
 CLUB  OCT 2         
 HAT   OCT 1         
       REM           
 CRSL  RCDA     LOAD 
       RCHA CW+5     THE
       LCHA 0        NEXT
       TRA 1         PROGRAM
       REM           
 ID    AXT 11,1      L 13 IN XRA
       WPRA          SELECT PRINTER
       SPRA 3        SPACE PRINTER
       RCHA CW       
       LCHA CW+6     
       LCHA CW+1     
       LCHA CW+6     
       CLA CW+1      
       SUB CLUB      L +2  
       STA CW+1      
       TIX *-5,1,1  
       TRA SWING     
       REM            
       REM PRINT IMAGES
       REM            
 PI    OCT 1120402200         9 L
       OCT 440000010          9 R
       OCT 0                  8 L
       OCT 0                  8 R
       OCT 4004100000         7 L
       OCT 1102001000         7 R
       OCT 60600020000        6 L
       OCT 200004000          6 R
       OCT 102010040000       5 L
       OCT 100240             5 R
       OCT 41000100           4 L
       OCT 10002004           4 R
       OCT 5000               3 L
       OCT 10500              3 R
       OCT 10040              2 L
       OCT 640002             2 R
       OCT 200020             1 L
       OCT 20021000001        1 R
       OCT 20000014000        0 L
       OCT 14000640100        0 R
       OCT 145350060100       11L
       OCT 1652007404         11R
       OCT 2425703000         12L
       OCT 121110240          12R
       REM            
*ERROR PRINT IMAGE FOR MPY TIMING TEST
       REM            
 PI1   OCT 404240220          9 L
       OCT 2102000000         9 R
       OCT 41000000           8 L
       OCT 100400             8 R
       OCT 200000100          7 L
       OCT 100400000000       7 R
       OCT 10020000           6 L
       OCT 4000000            6 R
       OCT 100002             5 L
       OCT 241041020040       5 R
       OCT 14000006001        4 L
       OCT 10010000000        4 R
       OCT 3102001450         3 L
       OCT 24000201300        3 R
       OCT 0                  2 L
       OCT 4020               2 R
       OCT 4                  1 L
       OCT 40000              1 R
       OCT 5052202400         0 L
       OCT 114000200420       0 R
       OCT 12300065142        11L
       OCT 1056020100         11R
       OCT 405100235          12L
       OCT 262501141240       12R
       REM             
       REM ENTER TRAP MODE SUBROUTINE
       REM            
 ENTM  ETM            ENTER TRAP MODE
       TTR 1,2        RETURN TO TEST
       REM            
*CHECK ACCUMULATOR UNCHANGED BY EXECUTING INDICATOR INSTRUCTIONS
       REM            
       BCD 1ACCU      
 ACC   TMI *+4        OK-SIGN UNCHANGED
       LDQ TEMP+2     LOC OF INSTR TESTING
       TSX ERROR-1,4  
       TRA ACC        
       REM            
       LBT            TEST POSITION 35
       TRA *+2        ERROR-LOST POSITION 35
       TRA ACC1       OK
       LDQ TEMP+2     LOC OF INSTR TESTING
       TSX ERROR-1,4  
       TRA ACC        
       REM            
 ACC1  ARS 1          SHIFT BIT OUT OF Q
       SLW TEMP+1     SAVE ACCUMULATOR
       CLA TEMP+1     L SAVED ACCUMULATOR
       LDQ ONES       L ALL ONES TO MQ
       CAS ONES       
       TRA *+2        ERROR-LOST A POS Q,P,1-34
       TRA ACC2       OK-
       LDQ TEMP+2     LOC OF INSTR TESTING
       TSX ERROR-1,4  
       REM            
*NO BIT IN ACC SIGN POS,Q WAS LOST-NO BIT IN ACC 1 POS,P WAS LOST
*NO BIT IN ACC 2 POS,1 WAS LOST-NO BIT IN ACC 3 POS, 2 WAS LOST ETC.
       REM            
       TRA ACC        
       REM            
 ACC2  TOV *+1        TURN OFF OVFLO LUGHT
       TRA 1,2       
       REM           
       REM EXECUTE-TSX SUBROUTINE
       REM           
  SUB  TRA 4,1       
       REM           
 STORE CLA END+1      
       STO 0          
       TRA 1,4       
       REM           
       REM PRINT FAST MPY ERROR INDICATION     
       REM            
 TI1   WPRA           SELECT PRINTER
       SPRA 3         SPACE PRINTER
       RCHA CW+9      
       TRA ADD        
       REM            
       REM CONSTANTS 
       REM           
 PONES OCT 377777777777
 ZERO  OCT 0         
 ONES  OCT 777777777777
 K2    OCT +000000700000
 K3    OCT -377777077777
 ONE   OCT 1         
 MZE   MZE           
 K6    OCT -377777777770
 SW1   OCT -370000000000
 PTHR  OCT 100000000000
 K8    OCT +177777777777
 K10   OCT -300000000000
 K11   OCT +000000677771
 K12   OCT +000003777777
 K13   OCT 37777777776
 K14   OCT -000000340000
 K15   OCT 374000003400
       OCT -370000007000
       OCT 020304050601
 K16   OCT +010203040506
       TIX  K16,0,4096
       TIX  K16,0,8192
       TIX  K16,0,12288
       TIX  K16,0,16384
       TIX  K16,0,20480
       TIX  K16,0,24576
       TNX  6*K16,1,20480
       STR  K37+65A1+16384,3
       TIX  K16+9,0,4096
 K16A  OCT 20304050621
 K16B  OCT 212223242526
 K17   MSE K37,0,3072 
       OCT -374777770304
 K20   OCT +265577177776
 K21   OCT 352000004262
 K22   OCT 770000162714
 K23   TXL A65X+3,7,32767
       TXL 3*K16,0,10240
 K24   OCT 111111111111
 K25   OCT 154321654321
 TWO   OCT 2         
 THREE OCT 3         
 1CF   OCT 7777      
 8CF   OCT 77777     
 MTW   MTW           
 PTW   PTW           
 K32   OCT 774777177776
 MON   MON           
 MONE  OCT -000000000001
 M2    OCT -000000000002
 K36   OCT 377777777776
 K37   OCT 374000000000
 K37A  OCT 44000043  
 K37B  TRA 65A1      
 K37C  TRA 65A2      
 K37D  TRA 65A3      
 K37E  TRA 65A4      
 K37G  TXL 65A+18,7,32767
 K37E1 TRA 65A4A     
 K37E2 TRA 65A4B     
 K37E3 TRA 65A4C     
 K37E4 TSX ERROR-1,4 
 M3    OCT -000000000003
 KK30  OCT -252525252525
 KK31  OCT -125252252525
 KK32  OCT +000000252525
 KK33  OCT -252525525252
 KK34  OCT 252525000000
 KK35  OCT +125252252525
 KK36  OCT +252525252525
 KK37  OCT 252525777777
 KK38  OCT +377777252525
 RTN   TRA B20+7     
       TRA B20+5     
 KK80  TTR B83+9     SEE SECTION
 KK81  HTR B84       B83 FOR USE
 KK82  HTR B83+5     OF THESE ,KK 80,81,82
 KK83  TTR B84A      
 KK84  TTR B85+6     
 KK85  TTR B82       
 KK85A HTR B85A-10   
 KK85B HTR B86+4     
 KK85C HTR B87+4     
 KK85D HTR B88+3     
 KK86  HTR B84A-1    
 KK87  TRA B98A+1    
 KK88  TRA B98B      
 SW2   OCT +007700000000
 SW3   OCT +000077000000
 SW4   OCT +000000770000
 SW5   OCT +000000007700
 SW6   OCT +000000000077
       STR 65A4D,3,1 
 FOUR  OCT 4          
 SEVEN OCT 7         
 K27   OCT 222222222222
 K28   OCT 333333333333
 K29   OCT -044444444444
 K31   OCT 777777     
 K33   OCT 111111     
 K34   OCT 333333     
 K35   OCT 400000     
       IOCDN TEMP+11,0,CW+9
 K38   SIR 0          
       SIL 0          
       RIR 0          
       RIL 0          
       IIR 0          
       IIL 0          
       RFT 0          
       LFT 0          
       RNT 0          
       LNT 0          
 TR    OCT 40         
       HTR THREE      
       HTR FOUR       
       TRA MODE1      
       TRA MODE+5     
       TRA MODE3      
       TRA MODE2+5    
       SLW TEMP+2    
       CLA TR        
       TRA           
       REM           
 DIS   TRA BUT+6      
       TRA BUT+7      
       TRA BUT1+5     
       TRA BUT1+6     
       TRA BUT2+5     
       TRA BUT3+4     
       TRA BUT4+6     
       TRA BUT4+7     
       TRA BUT5+5     
       REM            
       REM CONTROL WORDS           
 CW    IOCT PI,0,1    
       IOCT PI+2,0,1  
       IOCT PI+1,0,1  
       IOCT PI+3,0,1  
       IOCT PI+3,0,1  
       IOCT 0,0,3     
       IOCT TOP+2,0,1 
       IOCP TEMP,0,1 
       IOCDN TEMP+3,0,23       
       IOCD PI1,0,24  
       REM            
       REM  TEMPORARY STORAGE
       REM            
 TEMP  OCT 0          
       OCT 0          
       OCT 0          
       REM           
       REM           
       REM           
 D     EQU 8         10 OCTAL
 2D    EQU 2*8       20 OCTAL
 3D    EQU 3*8       30 OCTAL
 4D    EQU 4*8       40 OCTAL
 5D    EQU 5*8       50 OCTAL
 6D    EQU 6*8       60 OCTAL
 7D    EQU 7*8       70 OCTAL
 C     EQU 64        100 OCTAL
 2C    EQU 2*64      200 OCTAL
 3C    EQU 3*64      300 OCTAL
 4C    EQU 4*64      400 OCTAL
 5C    EQU 5*64      500 OCTAL
 6C    EQU 6*64      600 OCTAL
 7C    EQU 7*64      700 OCTAL                       
 M     EQU 512       1000 OCTAL
 2M    EQU 2*512     2000 OCTAL
 3M    EQU 3*512     3000 OCTAL
 4M    EQU 4*512     4000 OCTAL
 5M    EQU 5*512     5000 OCTAL
 6M    EQU 6*512     6000 OCTAL
 7M    EQU 7*512     7000 OCTAL
 10M   EQU 4096      10,000 OCTAL
 20M   EQU 2*10M     20,000 OCTAL
 30M   EQU 3*10M     30,000 OCTAL
 40M   EQU 4*10M     40,000 OCTAL
 50M   EQU 5*10M     50,000 OCTAL
 60M   EQU 6*10M     60,000 OCTAL
 70M   EQU 7*10M     70,000 OCTAL
 4K    EQU 4095      7777 OCTAL
 32K   EQU 32767     77,777 OCTAL
 A2    EQU 20M+2M+2C+2D+2 22222 OCTAL
 A5    EQU 50M+5M+5C+5D+5 55555 OCTAL
 ERROR EQU 3396      
 OK    EQU 3401      
 LOC   EQU 3959      
       REM           
       END           
