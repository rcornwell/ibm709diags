                                                             9M03A
                                                             6/2/56
       REM           
*          9M03A     INDEXING TEST
       REM           
       REM           
       REM           
       HTR *+1       HALT OK, PRESS START,,
       REM           
       REM           
       REM           
       REM TEST XRA FIRST
       REM TRANSFER ON TXL. ADDER X CARRY AT ER6
       REM WITH XRA LOW OF EQUAL.
       REM           
       REM           
       REM           
 SWING AXT 3C,1      300 TO XRA
       TXL *+2,1,3M  SHOULD TRANSFER, XRA
       REM           LOW, ADDER X CARRY AT
       REM           ER6. SYSTEMS 2.07.02
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           LOW XRA=300. DEC=3000.
       REM           
       REM TRY TXL AGAIN TO SEE IF XRA STILL HAS
       REM 300       
       REM           
       TXL *+2,1,3C  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER. XRA
       REM           SHOULD STILL HAVE 300.
       REM           IF THERE WAS NO STOP AT
       REM           LOC 2. THEN XRA MAY HAVE
       REM           BEEN CHANGED.
       REM           SYSTEMS 2.08.53
       REM           
       REM           
       REM TXL WITH XRA LOW
       REM           
 LOW   AXT 2C,1      200 TO XRA
       TXL *+2,1,3C  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           ON XRA LOW
       REM           XRA=200, DEC=300
       REM           
       AXT 2C,1      200 TO XRA
       TXL *+2,1,2C+1 SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           ON XRA ONE LESS THEN DEC.
       REM           XRA=200, DEC=201
       REM           
       AXT 1,1       1 TO XRA
       TXL *+2,1,32K SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANFER ON
       REM           XRA LOW
       REM           XRA=1, DEC=77777
       REM           
       AXT 32K-1,1   77776 TO XRA
       TXL *+2,1,32K SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA ONE LESS THEN DEC.
       REM           XRA=7776, DEC=77777
       REM           
       AXT 0,1       CLEAR XRA
       TXL *+2,1,1   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA ZERO
       REM           XRA=0, DEC=1
       REM           
       AXT 0,1       CLEAR XRA
       TXL *+2,1,40M SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA ZERO
       REM           XRA=0, DEC=40000
       REM           
       AXT 0,1       CLEAR XRA
       TXL *+2,1,0   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON 
       REM           BOTH XRA AND DEC=0
       REM           
       AXT A2+1,1    22223 TO XRA
       TXL *+2,1,50M+5M+5C+5D+5 SHOULD TRANSFER
       REM           EXCEPT ON
       REM           16K MACHINES
       HTR *+1       FAILED TO TRANSFER
       REM           WITH TWOS COMP. OF
       REM           XRA EQAUL TO DEC.
       REM           XRA=2223, DEC=55555
       REM           COMP. OF XRA=55555
       REM           
       REM           
       REM TXL WITH ZERO TAG
       REM           
 SWEET AXT 32K,1     ALL 7-S TO XRA
       TXL *+2,0,1   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           WITH ZERO TAG
       REM           DEC=1
       REM           
       TXL *+2,0,32K SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           WITH ZERO TAG
       REM           DEC =77777
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
       REM           XRA=200, DEC=100
       REM           NO ADDER X CARRY AT
       REM           ER6 SHOULD CAUSE
       REM           TRANSFER. SYSTEM 2.07.02
       REM           
       AXT 1,1       1 TO XRA
       TXH *+2,1,0   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA=1, DEC=0
       REM           
       AXT 50M+5M+5C+5D+5,1 ALL 5-S TO XRA
       TXH *+2,1,A2  SHOULD TRANSFER,EXCEPT
       REM           ON 16K MACHINES.
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=55555, DEC=22222
       REM           
       AXT 70M+4M,1  74000 TO XRA
       TXH *+2,1,2M  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=74000, DEC=2000
       REM           
       AXT 70M+6M,1  76000 TO XRA
       TXH *+2,1,M   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=76000, DEC =1000
       REM           
       AXT 70M+7M,1  77000 TO XRA
       TXH *+2,1,4C  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=77000, DEC=400
       REM           
       AXT 70M+7M+4C,1 77400 TO XRA
       TXH *+2,1,2C  SHOULD TRANFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=77400, DEC=200
       REM           
       AXT 70M+7M+6C,1 77600 TO XRA
       TXH *+2,1,C   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=77600, DEC=100
       REM           
       AXT 70M+7M+7C,1 77700 TO XRA
       TXH *+2,1,4D  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=77700, DEC=40
       REM           
       AXT 70M+7M+7C+4D,1 77740 TO XRA
       TXH *+2,1,2D  SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=77740, DEC=20
       REM           
       AXT 70M+7M+7C+6D,1 77760 TO XRA
       TXH *+2,1,D   SHOUDL TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=77760, DEC =10
       REM           
       AXT 32K-7,1   77770 TO XRA
       TXH *+2,1,4   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=77770, DEC=4
       REM           
       AXT 32K-3,1   77774 TO XRA
       TXH *+2,1,2   SHOULD TRANSFER
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=77774, DEC=2.
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
       REM           SEE LOC 70
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH
       REM           XRA=200, DEC=100
       REM THIS STOP COULD INDICATE THAT THE
       REM TXH AT LOC 140 DID NOT TRANSFER. BUT
       REM SINCE WE ASSUME THAT TXH WOULD WORK
       REM WITH THIS COMBINATION OF NUMBER-SEE
       REM LOC 70-WE SAY THAT THE ERROR WAS
       REM CAUSED BY TXL AT 137.
       REM           
       REM           
       REM           
       REM           
       REM           
       AXT 1,1       1 TO XRA
       TXL *+2,1,0   SHOULD NOT TRANSFER
       TXH *+2,1,0   SHOULD TRANSFER, SEE
       REM           LOC 73.
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH
       REM           XRA=1, DEC=0
       REM           
       AXT 50M+5M+5C+5D+5,1 ALL 5-S TO XRA
       TXL *+2,1,A2 SHOULD NOT TRANSFER
       REM           ON 4K,8K, AND 32 MACHINES
       TXH *+2,1,A2 SHOULD TRANSFER ON 4K,
       REM           8K, AND 32K MACHINES.
       REM           SEE LOC 76.
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH
       REM           XRA=55555, DEC=22222
       REM           
       AXT 70M+4M,1  74000 TO XRA
       TXL *+2,1,2M  SHOULD NOT TRANSFER
       TXH *+2,1,2M  SHOULD TRANSFER. SEE
       REM           LOC 101.
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH
       REM           XRA =74000, DEC=2000
       REM           
       AXT 70M+6M,1  76000 TO XRA
       TXL *+2,1,M   SHOULD NOT TRANSFER
       TXH *+2,1,M   SHOULD TRANSFER,
       REM           SEE LOC 104
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH.
       REM           XRA=76000, DEC=1000
       REM           
       AXT 70M+7M,1  77000 TO XRA
       TXL *+2,1,4C  SHOULD NOT TRANSFER
       TXH *+2,1,4C  SHOULD TRANSFER, SEE
       REM           LOC 107
       HTR *+1       TXL TRANSFERED ON
       REM           XRA HIGH.
       REM           XRA=77000, DEC=400
       REM           
       REM           
       REM NO TRANSFER WITH TXH ON XRA EQUAL
       REM           
 COMIN AXT 3C,1      300 TO XRA
       TXH *+2,1,3C  ADDER X CARRY AT ER6
       REM           SHOULD BLOCK TRANSFER
       TXL *+2       SHOULD TRANSFER, SEE
       REM           LOC 43
       HTR *+1       TXH TRANSFERED ON
       REM           XRA EQUAL
       REM           XRA=300, DEC=300
       REM           
       REM IF TXL WITH ZERO TAG AND DECREMENT
       REM WORKED OK AT LOC 43,WE ASSUME
       REM IT WILL WORK HERE.
       REM           
       REM           
       AXT 0,1       CLEAR XRA
       TXH *+2,1,0   SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER, SEE
       REM           LOC 43
       HTR *+1       TXH TRANSFERED WITH
       REM           XRA AND DEC BOTH ZERO.
       REM           
       AXT 32K,1     77777 TO XRA
       TXH *+2,1,32K SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER, SEE
       REM           LOC 43
       HTR *+1       TXH TRANSFERED ON
       REM           XRA EQUAL
       REM           XRA=777777, DEC=77777
       REM           
       AXT A2,1      22222 TO XRA
       TXH *+2,1,A2  SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER, SEE
       REM           LOC 43
       HTR *+1       TXH TRANSFER ON
       REM           XRA EQUAL
       REM           XRA=22222, DEC=22222
       REM           
       AXT 5M+5C+5D+5,1 55555 TO XRA
       TXH *+2,1,5M+5C+5D+5 SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER, SEE
       REM           LOC 43
       HTR *+1       TXH TRANSFER ON
       REM           XRA EQUAL
       REM           XRA=55555, DEC=55555
       REM           
       REM           
       REM           
       REM NO TRANSFER ON TXH WITH XRA LOW
       REM           
 FORTO AXT 0,1       CLEAR XRA
       TXH *+2,1,1   SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER, SEE
       REM           LOC 43
       HTR *+1       TXH TRANSFER ON
       REM           XRA LOW
       REM           XRA=0, DEC=1
       REM           
       AXT 32K-1,1   77776 TO XRA
       TXH *+2,1,32K SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER, SEE
       REM           LOC 43
       HTR *+1       TXH TRANSFER ON
       REM           XRA LOW
       REM           XRA=77776, DEC=77777
       REM           
       AXT A2+1,1 02223 IN XRA
       TXH *+2,1,50M+5M+5C+5D+5 SHOULD NOT TRANS
       REM           ON 4K,8K, OR 32K MACHINES
       TXL *+2       SHOULD TRANSFER, SEE
       REM           LOC 43
       HTR *+1       TXH TRANSFER ON
       REM           XRA LOW
       REM           XRA=22223, DEC=55555
       REM           
       AXT A2,1      22222 TO XRA
       TXH *+2,1,A2+1 SHOULD NOT TRANSFER
       TXL *+2       SHOULD TRANSFER, SEE
       REM           LOC 43
       HTR *+1       TXH TRANSFER ON
       REM           XRA LOW
       REM           XRA=22222, DEC=22223
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
       REM           ZERO AT LOC 234
       REM           
       HTR *+1       TXH TRANSFER ON
       REM           XRA=0, DEC=300
       REM           
       AXT A2,1      22222 TO XRA
       TXH *+5,1,A2  SHOULD NOT TRANSFER
       TXL *+3,1,0   SHOULD NOT TRANSFER
       TXL *+4,1,A2  SHOULD TRANSFER, XRA
       REM           SHOULD STILL HAVE 22222
       REM           
       HTR *+3       FAILED TO TRANSFER FROM
       REM           LOC 242, XRA SHOULD
       REM           HAVE BEEN=22222
       REM           
       HTR *+2       SHOULD NOT HAVER 
       REM           TRANSFER FROM LOC 241
       REM           XRA SHOULD HAVE HAD 22222
       REM           
       HTR *+1       TXH TRANSFER ON
       REM           XRA EQUAL, LOC 240
       REM           XRA=22222, DEC=22222
       REM           
       REM           
       AXT 3C,1      300 TO XRA
       TXH *+2,1,3C-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON XRA HIGH
       REM           XRA=300, DEC=277
       REM           
       TXL *+2,1,3C  SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER, XRA
       REM           SHOULD HAVE STILL BEEN 
       REM           300.
       TXL *+2,1,3C-1 SHOULD NOT TRANSFER
       TXL *+2       OK,
       HTR *+1       SHOULD NOT HAVER
       REM           TRANSFERRED AT LOC 253
       REM           XRA=300, DEC=277
       REM           
 ME    AXT 3,1       3 TO XRA
       TXL *+2,1,4   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXL, XRA=3, DEC=4
       TXH *+2,1,2   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXH, DEC=2, XRA SHOULD
       REM           STILL HAVE 3.
       REM           
       TXL *+2,1,4   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER 
       REM           ON TXL, DEC=4, XRA
       REM           SHOULD STILL HAVE 3
       REM           
       AXT 3C,1      300 TO XRA
       TXL *+2,1,3C  SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           XRA=300, DEC=300
       TXH *+2,1,3C-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           DEC=2777, XRA SHOULD
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
       REM           XRA HIGH, LOC 306
       REM           XRA=77776, DEC =75776
       TXH *+2,1,4M  SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER,
       REM           XRA SHOULD BE HIGH
       REM           XRA=77776, DEC=4000
       TXH *+2,1,32K-2 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           XRA SHOULD STILL BE HIGH
       REM           XRA=77776, DEC=77775
       REM           
       REM           
       REM           
       REM           
       REM WE MAY NOW PROCEED TO TNX AND TIX,
       REM IF THERE HAVE BEEN ANY ERRORS UP TO
       REM THIS POINT, THEY SHOULD BE
       REM INVESTIGATED BEFORE WE CONTINUE.
       REM           
       REM           
       REM TNX WITH XRA LOW. ADDER X CARRY
       REM ON AT ER6 SHOULD CAUSE TRANSFER.
       REM           
 HOME  AXT 3C,1      300 TO XRA
       TNX *+2,1,3M  SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON XRA LOW
       REM           XRA=300, DEC=3000
       TXL *+2,1,3C  SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXL, XRA SHOULD
       REM           HAVESTILL BEEN 300.
       REM           
       TXH *+2,1,3C-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXH, XRA SHOULD
       REM           STILL HAVE BEEN 300.
       REM           
       REM           
       AXT 0,1       CLEAR XRA
       TNX *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON XRA=0, DEC=1
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER,
       REM           XRA SHOULD HAVE BEEN
       REM           ZERO.
       REM           
       REM TNX WITH XRA EQUAL
       REM           
 MARY  AXT 32K,1     77777 TO XRA
       TNX *+2,1,32K SHOULD TRANSFER
       REM           XRA=77777, DEC=77777
       REM           
       HTR *+1       FAILED TO TRANSFER
       REM           WITH XRA EQUAL
       TXL *+2,1,32K SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER,
       REM           XRA SHOULD HAVE STILL
       REM           HAD 77777
       TXH *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           XRA SHOULD HAVE STILL
       REM           BEEN 77777
       REM           
       AXT 0,1       CLEAR XRA
       TNX *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER ON
       REM           XRA=DEC=ZERO
       REM           
       REM           
       REM TIX WITH XRA LOW
       REM           
 HADA  AXT 0,1       CLEAR XRA
       TIX *+2,1,1   SHOULD NOT TRANSFER
       TXL *+2       OK
       HTR *+1       TRANSFER ON TIX WITH
       REM           XRA LOW
       REM           XRA=0, DEC=1
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
       REM           XRA=77776, DEC=77777
       TXL *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       XRA SHOULD HAVE BEEN 
       REM           EQUAL, DEC=77776
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
       REM           XRA=1, DEC=1
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
       REM           XRA=DEC=ZERO
       TXL *+2,1,0   XRA SHOULD BE ZERO
       HTR *+1       XRA NOT STILL ZERO
       REM           
       REM           
       AXT 2,1       2 TO XRA
       TIX *+2,1,2   SHOULD NOT TRANSFER
       TXL *+2       OK
       HTR *+1       TIX TRANSFER ON
       REM           XRA EQUAL
       REM           XRA=2, DEC=2
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
       REM           XRA=77777, DEC=77777
       TXL *+2,1,32K SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL
       REM           HAVE BEEN 777777
       REM           DEC=77777
       TXH *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL
       REM           HAVE BEEN 77777
       REM           DEC=77776
       REM           
       REM           
       REM           
       REM           
       REM WE MAY NOW TEST XRA CYCLE THROUGH
       REM THE ADDERS. TEST WITH AXC. XRA
       REM TO ADDERS AT I3, SYSTEMS 2.08.49.2.
       REM RETURN TO XRA AT I6,
       REM SYSTEMS 2.08.53.1.
       REM           
       REM           
 LAMB  AXC 70M+7M+5C,1 00300 TO XRA
       TXL *+2,1,3C  SHOULD TRANSFER
       HTR *+1       XRA FAILED TO
       REM           GET 300
       REM           
       TXH *+2,1,3C-1 SHOULD TRANSFER
       HTR *+1       XRA FAILED TO
       REM           GET 300
       REM           
       REM           
       AXC 32K,1     00001 TO XRA
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA FAILED TO 
       REM           GET ONE
       REM
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA FAILED TO 
       REM           GET ONE.
       REM           
       REM           
       AXC 0,1       CLEAR XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA NOT ZERO
       REM           
       REM           
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
       REM           XRA=2, DEC=1
       REM           
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO DECREMENT
       REM           ON TIX. XRA SHOULD=1
       REM           
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO DECREMENT
       REM           ON TIX, XRA SHOULD=1
       REM           
       REM           
       REM           
       AXT 32K,1     77777 TO XRA
       TIX *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TIX
       REM           XRA=77777, DEC=77776
       REM           
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO DECREMENT
       REM           ON TIX, XRA SHOULD=1
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       FIALED TO DECREMENT
       REM           ON TIX, XRA SHOULD=1
       REM           
       REM           
       REM NO TRANSFER AND DECREMENT WITH TNX
       REM           
 FLEAS AXT 2,1       2 TO XRA
       TNX *+2,1,1   SHOULD NOT TRANSFER
       TXL *+2       OK
       HTR *+1       TRANSFER ON TNX WITH
       REM           XRA LOW
       REM           
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO DECREMENT
       REM           ON TNX. XRA SHOULD=1
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO DECREMENT 
       REM           ON TNX, XRA SHOULD=1
       REM           
       REM           
       REM           
       REM COUNT-DOWN TEST WITH TIX
       REM           
 WAS   AXT 32K,1     77777 TO XRA
       TIX *+2,1,1   SHOULD TRANSFER
       HTR *+6       FIALED TO TRANSFER
       REM           ON TIX. XRA SHOULD
       REM           ALWAYS BE HIGH
       REM           
       TXH *-2,1,2   CONTINUE COUNT-DOWN
       REM           UNTIL XRA=2
       TXL *+2,1,2   XRA SHOULS NOW=2
       HTR *+3       FAILED, XRA SHOULD
       REM           COUNT DOWN TO 2 ON
       REM           TIX.
       REM           
       TXH *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED, XRA SHOULD
       REM           BE=2.
       REM           
       REM           
       REM COUNT-DOWN WITH TNX
       REM           
 WHITE AXT 32K,1     
       TXL *+5,1,2   TRANSFER WHEN XRA=2
       TNX *+3,1,1   SHOULD NOT TRANSFER
       TXH *-2,1,1   SHOULD ALWAYS TRANSFER
       REM           
       HTR *+4       FAILED TO TXH, XRA
       REM           SHOULD COUNT DOWN TO 
       REM           2 AND SKIP OUT
       REM           AT LOC 463
       REM
       HTR *+3       TRANSFERRED HERE
       REM           FROM 464, XRA SHOULD
       REM           COUNT DOWN TO 2 ONLY,
       REM           SHOULD NEVER TRANSFER
       REM           AT LOC 464
       REM           
       TXH *+2,1,1   XRA SHOULD=2
       HTR *+1       FAILED, XRA SHOULD
       REM           COUNT DOWN TO 2
       REM           AND TRANSFER ON
       REM           XRA EQUAL AT LOC 463
       REM           
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
       TXL *+2,1,1   XRA SHOULD=1
       HTR *+1       FAILED TO INCREMENT
       REM           WITH TXI,
       REM           XRA SHOULD=1
       REM           
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI.
       REM           XRA SHOULD=1
       REM           
       AXT 32K-1,1   77776 TO XRA
       TXI *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXI.
       REM           
       TXH *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI.
       REM           XRA SHOULD=77777
       REM           DEC=77776
       REM           
       AXT 1,1       1 TO XRA
       TXI *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXI
       REM           
       TXH *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI.
       REM           XRA=77777, DEC=77776
       REM           
       AXT 32K,1     777777 TO XRA
       TXI *+2,1,32K SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER 
       REM           ON TXI
       REM           
       TXH *+2,1,32K-2 SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI, XRA SHOULD
       REM           HAVE 77776, DEC=77775
       REM           
       TXL *+2,1,32K-1 SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXI, XRA SHOULD
       REM           HAVE 77776, DEC=77776.
       REM           
       AXT 1,1       1 TO XRA
       TXI *+2,1,32K SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER
       REM           ON TXI.
       REM           
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       FAILED TO INCREMENT
       REM           ON TXL. XRA SHOULD
       REM           HAVE ZERO.
       REM           
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
       REM           UNTIL XRA=2
       REM           
       TXH *+2,1,1   SHOULD TRANSFER
       HTR *+1       FAILED TO COUNT
       REM           CORRECTLY, XRA SHOULD
       REM           HAVE 2
       REM           
       REM           
       AXT 32K,1     77777 TO XRA
       TNX *+3,1,2   SHOULD COUNT-DOWN
       REM           TO 2 AND TRANSFER
       TXI *-1,1,1   SHOUDL TRANSFER
       REM           AND ADD 1
       REM           
       HTR *+5       FAILED TO TRANSFER
       REM           TXI
       REM           
       TXH *+2,1,1   XRA SHOULD BE=2
       HTR *+3       FAILED TO COUNT
       REM           CORRECTLY
       REM           
       TXL *+2,1,2   SHOULD TRANSFER
       HTR *+1       FAILED TO COUNT
       REM           CORRECTLY, XRA SHOULD
       REM           HAVE 2.
       REM           
       REM           
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
 HERE  TSX *+2,1     77232 TO XRA
       HTR *+1       FAILED TO TRANSFER
       REM           ON TSX
       REM           
       TXL *+2,1,32K-HERE+1 DEC=77232
       HTR *+1       FAILED TO SET CORRECT
       REM           ADDRESS IN XRA ON TSX
       REM           XRA SHOULD HAVE 77232
       REM           
       TXH *+2,1,32K-HERE DEC=77231
       HTR *+1       FAILED TO SET
       REM           CORRECT ADDRESS WITH
       REM           TSX. XRA SHOUDL
       REM           HAVE 77232
       REM           
       REM           
 WE    TSX *+2,1     77224 TO XRA
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
       REM           
       REM           
*          TEST LXA-LOAD INDEX FROM ADDRESS
       REM           
*          PREVIOUS INSTRUCTIONS AXT, TXH, TXL MUST
*          HAVE BEEN TESTED AND WORKING CORRECTLY.
       REM           
       REM           
       REM           
       REM           
       AXT 0,1       CLEAR XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       DID NOT CLEAR XRA
       LXA KK+7,1    07777 TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOUDL TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 07777
       REM           DEC=07776
       REM           IF XRA=00000, DID NOT GET
       REM           ADDRESS PAST THE ADDERS
       REM           2.08.53.1
       REM           
       AXT 7M+7C+7D+7,107777 TO XRA
       LXA AZE,1     00000 TO XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 00000
       REM           DEC=00000
       REM           IF XRA=07777, DID NOT GET
       REM           ADDRESS PAST THE ADDERS
       REM           2.08.53.1
       REM           
       LXA KK+6,1    06666 TO XRA
       TXH *+2,1,6M+6C+6D+5 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA=06666 DEC=06665
       TXL *+2,1,6M+6C+6D+6,1 SHOUDL TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA=DEC=06666
       REM           
       LXA KK+5,1    05555 TO XRA
       TXH *+2,1,5M+5C+5D+4 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA=05555 DEC=05554
       TXL *+2,1,5M+5C+5D+5,1 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA=DEC=05555
       REM           
       LXA KK+4,1    04444 TO XRA
       TXH *+2,1,4M+4C+4D+3 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA=04444 DEC=04443
       TXL *+2,1,4M+4C+4D+4 SHOULD TRANSFER
       HTR *+1       DID NOTR TRANSFER ON TXL
       REM           XRA=DEC=04444
       REM           
       LXA KK+3,1    03333 TO XRA
       TXH *+2,1,3M+3C+3D+2 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA=03333 DEC=03332
       TXL *+2,1,3M+3C+3D+3 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA=DEC=03333
       REM           
       LXA KK+2,1    02222 TO XRA
       TXH *+2,1,2M+2C+2D+1 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA=02222 DEC=02221
       TXL *+2,1,2M+2C+2D+2 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA=DEC=02222
       REM           
       LXA KK+1,1    01111 TO XRA
       TXH *+2,1,M+C+D SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA=01111 DEC=01110
       TXL *+2,1,M+C+D+1 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA=DEC=01111
       REM           
*          TEST LXA USING A ZERO TAG
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       LXA AZE,0     00000 WITH A ZERO TAG
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 07777
       REM           DEC=07776
       REM           IF XRA=00000, THE ADDERS
       REM           TO XRA LINE IS UP ON
       REM           PAGE 2.12.03
       REM           
       REM           
*          TEST LAC-LOAD COMPLEMENT OF ADDRESS IN INDEX
       REM           
*          ASSUME DIRECT ROUTING TO INDEX FROM STORAGE IS OK
*          SINCE LXA HAS BEEN TESTED.
       REM           
       AXT 0,1       CLEAR XRA
       LAC A75,1     2-S COMP. OF 75555 TO
       REM           XRA
       TXL *+2,1,2M+2C+2D+3 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 02223
       REM           DEC=02223
       REM           IF XRA=75555,DID NOT CYCLE
       REM           THROUGH THE ADDERS FOR THE
       REM           2-S COMP. 2.08.49.2 OR
       REM           2.08.53.1
       TXH *+2,1,2M+2C+2D+2 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 02223
       REM           DEC=02222
       REM           IF XRA=02222,DID NOT GET
       REM           A CARRY TO ADDER 17 AT
       REM           I3-D7 2.08.05.2
       REM           
       LAC AL7,1     2-S COMP. 77777 TO XRA
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD HAVE 00001
       REM           DEC=00000
       REM           NO CARRY TO ADDER 17
       REM           2.08.50.2
       REM           
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 00001
       REM           DEC=00001
       REM           IF XRA IS ALL 1-S,
       REM           DID NOT CYCLE THROUGH
       REM           ADDERS FOR 2-S COMPLEMENT
       REM           2.08.49.2 OR 2.08.53.1
       REM           
       LAC A76,1     2-S COMP. OF 76666 TOXRA
       TXH *+2,1,M+C+D+1 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 01112
       REM           DEC=01111
       TXL *+2,1,M+C+D+2 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 01112
       REM           DEC=01112
       REM           
       LAC A74,1     2-S COMP. OF 74444
       REM           TO XRA
       TXH *+2,1,3M,3C+3D,+3 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 03334
       REM           DEC=03333
       REM           
       TXL *+2,1,3M+3C+3D+4 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 03334
       REM           DEC=03334
       REM           
       LAC A73,1     2-S COMP. OF 73333
       REM           TO XRA
       TXH *+2,1,4M+4C+4D+4 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSDFER ON TXH
       REM           XRA SHOULD BE 04445
       REM           DEC=04444
       TXL *+2,1,4M+4C+4D+5 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 04445
       REM           DEC=04445
       REM           
       LAC A72,1     2-S COMP. OF 72222 TO
       REM           XRA
       TXH *+2,1,5M+5C+5D+5 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 05556
       REM           DEC=05555
       TXL *+2,1,5M+5C+5D+6 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 05556
       REM           DEC=05556
       REM           
       LAC A71,1     2-S COMP. OF 71111 TO
       REM           XRA
       TXH *+2,1,6M+6D+6C+6 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 06667
       REM           DEC=06666
       TXL *+2,1,6M+6D+6C+7 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 06667
       REM           DEC=06667
       REM           
       LAC A701,1    2-S COMP. OF 70001 TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 07777
       REM           DEC=07776
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 07777
       REM           DEC=07777
       REM           
       REM           
*          TRY RIPPLING A 2-S COMPLEMENT CARRY
       REM           
       LAC A710,1    2-S COMP. OF 71000 TO XRA
       TXH *+2,1,6M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 07000
       REM           DEC=06777
       TXL *+2,1,7M SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 07000
       REM           DEC=07000
       REM           
*          CHECK THAT ZERO TAG DOES NOT ALTER XRA CONTENTS
       REM           
       AXT 0,1       CLEAR XRA
       LAC AL7,0     77777 TO IMAGINARY INDEX
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD STILL BE 00000
       REM           DEC=00000
       REM           IF XRA=00001, SR 20 IS
       REM           UP-2.12.02
       REM           
       REM           
*          TEST SXA-STORE INDEX IN ADDRESS
       REM           
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       SXA KK,1      07777 TO ADDRESS OF
       REM           TEMPORARY STORAGE
       AXT 0,1       CLEAR XRA
       LXA KK,1      BRING BACK TEMPORARY STG.
       REM           TO SEE IF WAS STORED OK
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 07777
       REM           DEC=07776
       REM           IF XRA=00000, ADDRESS WAS
       REM           NEVER STORED IN KK
       REM           OR XRA WAS NOT COMPLEMENTED
       REM           TO GET THE TRUE INDEX TO
       REM           THE ADDRESS IN STG.
       REM           PAGE 2.08.53.1
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA=DEC=07777
       REM           
       AXT 0,1       CLEAR XRA
       SXA KK,1      00000 IN TEMP. STG.
       AXT 70M+7M+7C+7D+7,1 ALL 1-S TO XRA
       LXA KK,1      BRING BACK TEMPORARY STG.
       REM           TO SEE IF IT WAS STORED OK
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 00000
       REM           DEC=00000
       REM           
*          CHECK THAT INDEX REMAINS UNCHANGED AFTER STORING
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       SXA KK,1      07777 TO TEMP. STG.
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD STILL BE 07777
       REM           DEC=07776
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD STILL BE 07777
       REM           DEC=07777
       REM           
*          TEST SXA WITH A ZERO TAG
       REM           
       AXT 5M+5C+5D+5,1 05555 TO XRA
       SXA KK,0      IMAGINARY INDEX TO KK
       LXA KK,1      SHOULD BE 00000
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 00000
       REM           DEC=00000
       REM           
       REM           
*          TEST LXD-LOAD INDEX FROM DECREMENT
       REM           
       AXT 0,1       CLEAR XRA
       LXD D7,1      07777 TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 07777
       REM           DEC=07776
       REM           IF XRA=00000, DID NOT GET
       REM           PAST THE ADDERS AT E11-D1
       REM           PAGE 2.08.53.1
       REM           IF XRA=05555, BROUGHT THE
       REM           ADR. TO THE INDEX AT E9-D3
       REM           PAGE 2.08.05.2
       REM           IF XRA=00001, GOT 2-S COMP.
       REM           AT I3-D7 OF NEXT I CYCLE
       REM           PAGE 2.08.49.2
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 07777
       REM           DEC=07777
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       LXD D0,1      00000 TO XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 00000
       REM           DEC=00000
       REM           IF XRA=07777, DID NOT GET PA
       REM           THE ADDERS AT E11-D1
       REM           PAGE 2.08.53.1
       REM           IF XRA=05555, BROUGHT THE
       REM           ADR. TO THE INDEX AT E9-D3
       REM           PAGE 2.08.05.2
       REM           
       REM           
*          CHECK LXD WITH A ZERO TAG
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       LXD D0,0      LOAD IMAGINARY INDEX
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD STILL BE 07777
       REM           DEC=07776
       REM           IF XRA=00000, ADDERS TO XRA
       REM           IS UP ON PAGE 2.12.03
       REM           
*CHECK THAT THE ADDRESS OF STORAGE 21-35 DOES NOT CHANGE WITH A LXD INSTR
       REM           
       LXD D7,1      LOAD INDEX USING LXD
       LXA D7,1      05555 TO XRA
       TXH *+2,1,5M+5C+5D+4 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           POSITIONS 21-35 DID NOT 
       REM           REMAIN UNCHANGED USING A 
       REM           LXD INSTRUCTION
       REM           XRA SHOULD BE 05555
       REM           DEC=05554
       TXL *+2,1,5M+5C+5D+5 SHOULD TRANSFER
       HTR *+1       WORD ADDRESS CHANGED
       REM           XRA SHOULD BE 05555
       REM           DEC=05555
       REM           
       REM           
       REM           
*          TEST SXD-STORE INDEX IN DECREMENT
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       SXD KK,1      STORE 07777 IN TEMP. STG.
       LXD KK,1      BRING TEMPORARY STORAGE
       REM           BACK TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 07777
       REM           DEC=07776
       REM           IF XRA=00000, DID NOT CYCLE
       REM           THROUGH THE ADDERS TO COMP.
       REM           XRA AT E4-D1, PP. 2.08.53.1
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 07777
       REM           DEC=07777
       REM           
       AXT 0,1       00000 TO XRA
       SXD KK,1      CLEAR DEC OF TEMP. STG.
       LXD KK,1      BRING DEC BACK TO XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 00000
       REM           DEC=00000
       REM           
*          CHECK THAT THE ADDRESS OF STORAGE 21-35 DID NOT
*          CHANGE USING AN SXD INSTRUCTION
       REM           
       AXT 5M+5C+5D+5,1 05555 TO XRA
       SXA KK,1      05555 TO ADR. OF TEMP. STG.
       AXT 7M+7C+7D+7,1 07777 TO XRA
       SXD KK,1      STORE 07777 IN DEC OF STG.
       LXA KK,1      BRING IN ADR. TO XRA AND SEE
       REM           IF IT IS STILL 05555
       TXH *+2,1,5M+5C+5D+4 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 05555
       REM           DEC=05554
       TXL *+2,1,5M+5C+5D+5 SHOULD TRANSFER
       HTR           DID NOT TRANSFER ON TXL
       REM           XRA SHOULD BE 05555
       REM           DEC=05555
       REM           IF XRA=0777, AS TO SB
       REM           21-35 IS UP, PP. 2.08.28
       REM           
*          TEST SXD WITH ZERO TAG
       REM           
       AXT 0,1       CLEAR XRA
       SXD KK,1      CLEAR DEC. OF TEMP. STG.
       AXT 7M+7C+7D+7,1 07777 TO XRA
       SXD KK,0      IMAGINARY INDEX TO STG.
       LXD KK,1      SHOULD STILL BE 00000
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       SXD IN ERROR WITH 
       REM           A ZERO TAG, PP. 2.12.02
       REM           
*CHECK TAHT XRA IS RE-COMPLEMENTED AND REMAINS UNCHANGED
*AFTER A SXD INSTRUCTION.
       REM           
       AXT 0,1       CLEAR XRA
       SXD KK,1      SHOULD NOT ADDECT CONTENTS
       REM            OF XRA
       TXL *+2,1,0   SHOULD TRANSFER SINCE XRA
       REM           SHOULD STILL BE 00000
       HTR *+1       CONTENTS OF XRA CHANGED,
       REM           IF XRA IS ALL 1-S
       REM           FAILED TO RE-COMPLEMENT
       REM           AT E11-D1, PAE 2.08.53.1
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       SXD KK,1      SHOULD NOT AFFECT CONTENTS
       REM           OF XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA CHANGED, SHOULD STILL
       REM           BE 07777
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       XRA=07777 DEC=07777
       REM           
       REM           
       REM           
*          TEST LDC-LOAD COMPLEMENT OF DECREMENT IN INDEX.
*          AT THIS POINT IT WILL BE ASSUMED THAT LAC HAS
*          BEEM TESTED AND IS WORKING CORRECTLY SINCE LDC
*          IS IDENTICAL EXCEPT THAT INSTEAD OF THE ADDRESS.
*          THE SR DECREMENT GOES TO THE ADDERS.
       REM           
       AXT 2M+2C+2D+2,1 02222 TO XRA
       LDC DA7,1     2-S COMP. OF 77777 TO XRA
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00001
       REM           DEC=00000
       REM           IF XRA=00000, DIDN'T GET
       REM           A CARRY TO ADDER 17
       REM           PAGE 2.08.50.2
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00001
       REM           DEC=00001
       REM           IF XRA=02222, DID NOT GET
       REM           PAST ADDERS AT E11-D1
       REM           PAGE 2.08.53.1
       REM           IF XRA=77777, DID NOT CYCLE
       REM           THROUGH ADDERS FOR 2-S
       REM           COMP AT I6-D1 PP. 2.08.53.1
       REM           IF XRA=05555, THE LOAD
       REM           INDEX FROM ADR. LINE IS UP,
       REM           PAGE 2.07.28
       REM           
       AXT 2M+2C+2D+2,1 02222 TO XRA
       LDC D0+1,1    2-S COMP. OF 70001 TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 07777
       REM           DEC=07776
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       ERROR, XRA SHOULD BE 07777
       REM           
*          TEST LDC WITH A ZERO TAG
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       LDC D7,0      2-S COMP. OF 07777 TO
       REM           IMAGINARY INDEX
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL BE
       REM           07777
       REM           IF XRA=00001, ADDERS
       REM           TO XRA LINE IS UP
       REM           PAGE 2.12.02
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       XRA=07777 DEC=07777
       REM           
*CHECK THAT THE ADDRESS PORTION OF STORAGE 21-35 REMAINS
*UNCHANGED WHEN USING A LDC INSTRUCTION.
       REM           
       SXA KK,0      CLEAR ADR. 21-35 OF STG.
       LDC KK,1      ADR. IN STG. SHOULD
       REM           NOT CHANGE
       LXA KK,1      BRING ADR. INTO INDEX TO
       REM           SEE IF IT REMAINED UNCHANGED
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00000,
       REM           ADR. 21-35 OF STG., CHANGED
       REM           USING AN LDC INSTRUCTION
       REM           
       REM           
*CHECK THAT THE DECREMENT OF STORAGE 3-17 REMAINS UNCHANGED
*AFTER AN SXA INSTRUCTION.
       REM           
       AXT 0,1       CLEAR XRA
       SXD KK,1      CLEAR DEC, OF TEMP. STG.
       AXT 7M+7C+7D+7,1 07777 TO XRA
       SXA KK,1      3-17 OF TEMP. STG. SHOULD
       REM           REMAIN UNCHANGED.
       LXD KK,1      SHOULD BE 00000
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA=DEC=00000
       REM           
       REM           
*IN TESTING THE 6 INDEXING INSTRUCTIONS INVOLVING THE ACCUMULATOR
*IT WILL BE ASSUMED THAT THE OTHER INDEXING INSTRUCTIONS HAVE
*BEEN TESTED AND ARE WORKING AND ALSO THAT CLA IS OPERATING
*CORRECTLY.          
       REM           
*          TEST PDX-PLACE DECREMENT IN INDEX
       REM           
       AXT 0,1       CLEAR XRA
       CLA D7        0077770055555 TO ACC
       PDX 0,1       077777 TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 07777
       REM           DEC=07776
       REM           IF XRA=00000,NEVER GOT
       REM           PAST THE ADDERS AT I3-D1
       REM           PAGE 2.08.53.1 OR 2.08.06
       REM           IF XRA=05555 ROUTED ADR.
       REM           TO INDEX,PP, 2.07.29
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 07777
       REM           DEC=07777
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       CLA D0        000000005555 TO XRA
       PDX 0,1       00000 TO XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00000
       REM           DEC=00000
       REM           
*          TEST PDX WITH A ZERO TAG
       REM           
       AXT 0,1       CLEAR XRA
       CLA D7        0077770055555
       PDX 0,0       PLACE DECREMENT IN AN
       REM           IMAGINARY INDEX
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD NOT HAVE
       REM           CHANGED.
       REM           
       REM           
*          TEST PDC-PLACE COMPLEMENT OF DECREMENT IN INDEX
       REM           
*ASSUME THAT SINCE PDX HAS BEEN TESTED,THE DECREMENT ROUTING
*TO THE ADDERS IS OK,AND ONLY THE COMPLEMENTING DURING THE NEXT
*ICYCLE NEEDS TO BE CHECKED.
       REM           
       AXT 2M+2C+2D+2,1 02222 TO XRA
       CLA DA7       077777005555 TO ACC
       PDC 0,1       2-S COMP. OF 77777 TO XRA
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 00001
       REM           DEC=00000
       REM           IF XRA=00000,DID NOT GET
       REM           CARRY TO ADDER I7 AT I0-D4
       REM           PAGE 2.08.50
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00001
       REM           DEC=00001
       REM           IF XRA IS ALL 1-S
       REM           DID NOT CYCLE THROUGH
       REM           THE ADDERS TO COMPLEMENT
       REM           AT I3-D1,PP.2.08.53.2
       REM           IF XRA=02222,DID NOT ROUTE
       REM           DEC. TO INDEX,PP.2.08.53.1
       REM           
       AXT 2M+2C+2D+2,1 02222 TO XRA
       CLA D0+1      070001005555 TO ACC
       PDC 0,1       2-S COMP. OF 70001 TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 07777
       REM           DEC=07776
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       XRA=DEC=07777
       REM           
       REM           
*CHECK THAT ZERO TAG DOES NOT ALTER XRA
       REM           
       AXT 0,1       CLEAR XRA
       CLA D0+1      
       PDC 0,0       XRA SHOULD STILL BE 00000
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       INDEX CHANGED WITH A 
       REM           ZERO TAG
       REM           
       REM           
*          TEST PAX-PLACE ADDRESS IN INDEX
       REM           
*SINCE THE ADDRESS MUST BE SHIFTED TO THE DECEMENT PORTION
*OF THE ADDERS,THE ACC IS ROUTED VIA THE STORAGE BUSS.
       REM           
       AXT 0,1       CLEAR XRA
       CLA D7        007777005555 TO ACC
       PAX 0,1       05555 TO XRA
       TXH *+2,1,5M+5C+5D+4 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXH
       REM           XRA SHOULD BE 05555
       REM           DEC=05554
       REM           IF XRA=00000,DID NOT GET
       REM           PAST ADDERS AT I5-D1,
       REM           PAGE 2.08.53.2
       TXL *+2,1,5M+5C+5D+5 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA=DEC=05555
       REM           IF XRA=07777,ROUTED DEC.
       REM           TO INDEX,PP.2.07.29 OR
       REM           DID NOT SHIFT SR 18-35 TO
       REM           ADD P-17,PP.2.08.48.2
       REM           
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       CLA A0        077777000000 TO ACC
       PAX 0,1       00000 TO XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00000
       REM           DEC=00000
       REM           
*          TEST PAX WITH A ZERO TAG
       REM           
       AXT 0,1       CLEAR XRA
       CLA D7        007777005555 TO ACC
       PAX 0,0       05555 TO IMAGINARY INDEX
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD REMAIN 00000
       REM           WITH A ZERO TAG
       REM           
       REM           
*          TEST PAC-PLACE COMPLEMENT OF ADDRESS IN INDEX
       REM           
*ASSUME THAT SINCE PAX HAS BEEN TESTED,ACC ADDRESS ROUTING
*TO THE INDEX IS WORKING AND ONLY COMPLEMENTING NEEDS TO BE CHECKED.
       REM           
       REM           
       AXT 0,1       CLEAR XRA
       CLA A75       0111111075555 TO ACC
       PAC 0,1       2-S COMP OF 75555 TO XRA
       TXH *+2,1,2M+2C+2D+2 SHOULD TRANSFER
       HTR *+1       FAILED TO TRANSFER ON TXH
       REM           XRA SHOULD BE 02223
       REM           IF XRA=02222,DID NOT
       REM           GET CARRY TO ADDER 17 AT
       REM           I0-D4,PP.2.08.50
       REM           IF XRA=00000,DID NOT
       REM           ROUTE ADR. TO INDEX AT
       REM           ER8-D1,PP.2.08.53.2
       TXL *+2,1,2M+2C+2D+3 SHOULD TRANSFER
       HTR *+1       DID NOT TRANSFER ON TXL
       REM           XRA=DEC=02223
       REM           IF XRA=75555,DID NOT
       REM           CYCLE THROUGH ADDERS FOR
       REM           2-S COMP.AT I3-D1,
       REM           PAGE 2.08.53.2
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       CLA A01       077777070001 TO ACC
       PAC 0,1       2-S COMP. OF 70001 TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 07777
       REM           DEC=07776
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       XRA=DEC=07777
       REM           
*          TEST PAC WITH A ZERO TAG
       REM           
       AXT 0,1       CLEAR XRA
       CLA A01       077777070001 TO ACC
       PAC 0,0       07777 TO IMAGINARY INDEX
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL BE 00000
       REM           
       REM           
*CHECK THAT PDX,PDC,PAX,AND PAC LEAVE THE DECREMENT
*AND THE ADDRESS OF THE ACCUMULATOR UNCHANGED.
       REM           
       CLA DA7       077777005555 TO ACC.
       PDX 0,1       SHOULD NOT ALTER ACC ADDRESS
       PAX 0,1       05555 TO XRA
       TXH *+2,1,5M+5C+5D+4 SHOULD TRANSFER
       HTR *+1       ACC ADR.WAS CHANGED BY PDX
       TXL *+2,1,5M+5C+5D+5 SHOULD TRANSFER
       HTR *+1       XRA=DEC=05555
       REM           
       CLA DA7       077777005555 TO ACC.
       PDC 0,1       SHOULD NOT ALTER ACC ADDRESS
       PAX 0,1       05555 TO XRA
       TXH *+2,1,5M+5C+5D+4 SHOULD TRANSFER
       HTR *+1       ACC ADR.WAS CHANGED BY PDX
       TXL *+2,1,5M+5C+5D+5 SHOULD TRANSFER
       HTR *+1       XRA=DEC=05555
       REM           
       CLA A55       000000005555 TO ACC.
       PAX 0,1       SHOULD NOT ALTER ACC ADDRESS
       PDX 0,1       00000 TO XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       ACC DEC.WAS CHANGED BY PAX
       REM           
       REM           
       CLA A55       000000005555 TO ACC.
       PAC 0,1       SHOULD NOT ALTER ACC ADDRESS
       PDX 0,1       00000 TO XRA
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       ACC DEC.WAS CHANGED BY PAC
       REM           
       REM           
       REM           
*TEST PXD-PLACE INDEX IN DECREMENT AND PXA-PLACE
*INDEX IN ADDRESSS   
       REM           
*ASSUME THAT PREVIOUS INSTRUCTIONS PDX AND PAX HAVE BEEN TESTED
*AND ARE WORKING CORRECTLY.
       REM           
       CLA AL7       ALL 1-S TO ACC
       AXT 1,1       00001 TO XRA
       PXD 0,1       00001 TO DEC OF ACC
       PDX 0,1       BRING IT BACK TO XRA TO
       REM           SEE IF PXD ROUTING IS OK
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00001
       REM           DEC=00000
       REM           IF XRA=00000,DID NOT GET
       REM           A CARRY TO ADDER 17 AT
       REM           ER4-D2 WHEN COMPLEMENTING
       REM           XRA IN ORDER TO GET THE
       REM           TRUE OUTPUT.PP.2.08.49.2
       REM           
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00001
       REM           DEC=00001
       REM           IF XRA=77776,DID NOT CYCLE
       REM           THROUGH ADDERS IN ORDER TO
       REM           GET THE TRUE OUTPUT AT
       REM           ER5-D1,PP.2.08.53.2
       REM           
       CLA AZE       ALL 0-S TO ACC
       AXT 7M+7C+7D+7,1 07777 TO XRA
       PXD 0,1       07777 TO DEC.OF ACC
       PDX 0,1       07777 TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 07777
       REM           DEC=07776
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 07777
       REM           DEC=07777
       REM           
       REM           
*CHECK TO SEE IF THE INDEX REGISTER IS RESTORED TO ITS
*ORIGINAL CONTENTS AFTER A PXD INSTRUCTION.
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       PXD 0,1       XRA SHOULD REMAIN UNCHANGED
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL BE 07777
       REM           DEC=07776
       REM           XRA CHANGED WITH A PXD
       REM           INSTRUCTION
       REM           IF XRA=70000 DID NOT
       REM           RE-CYCLE THE INDEX AT ER9-D1
       REM           PAGE 2.08.53.2
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       XRA=DEC=07777
       REM           
       AXT 1,1       00001 TO XRA
       PXD 0,1       XRA SHOULD REMAIN UNCHANGED
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00001
       REM           DEC=00000
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA=DEC=00001
       REM           IF XRA=77776, DID NOT
       REM           RE-CYCLE THE INDEX AT ER9-D1
       REM           PAGE 2.08.53.2
*CHECK THAT PXD WITH A ZERO TAG CLEARS THE ACC DECREMENT.
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       CLA D7        07777 IN ACC DECREMENT
       PXA 0,0       SHOULD CLEAR DECREMENT
       PDX 0,1       BRING DEC.TO XRA AND SEE
       REM           IF IT HAS BEEN CLEARED.
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       ZERO TAG DID NOT CLEAR DEC.
       REM           
*CHECK THAT THE ACCUMULATOR ADDRESS IS CLEARED USING A PXD INSTRUCTION
       REM           
       CLA AL7       ALL 1-S TO ACCUMULATOR
       AXT D0        05555 TO XRA
       PXD 0,1       SHOULD CLEAR ACC ADDRESS
       PAX 0,1       CHECK IF ADR.IS 00000
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00000
       REM           DEC=00000
       REM           IF XRA IS ALL 1-S,DID NOT
       REM           CLEAR ADDRESS
       REM           IF XRA=05555,BROUGH INDEX
       REM           TO ADDRESS USING THE PXD
       REM           INSTRUCTION.
       REM           
       REM           
       REM           
*          TEST PXA-PLACE INDEX IN ADDRESS
       REM           
       CLA AL7       ALL 1-S TO ACC.
       AXT 1,1       00001 TO XRA
       PXA 0,1       00001 TO ADR OF ACC
       PAX           BRING IT BACK TO XRA TO
       REM           SEE IF PXA ROUTING IS OK
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD BE 00001
       REM           DEC=00000
       REM           IF XRA=00000,MIGHT HAVE
       REM           BROUGHT INDEX TO DECREMENT
       REM           AND CLEARED ADDRESS
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA=DEC=00001
       REM           IF XRA IS ALL 1-S,NEVER
       REM           ROUTED PXA PAST THE ADDER
       REM           AT I0-D4,PP.2.08.05.2
       REM           IF XRA=7776 NEVER CYCLED
       REM           XRA TO GET THE TRUE OUTPUT
       REM           AT ER 5-D1,PP.2.08.53.2
       REM           
       REM           
       CLA AZE       ALL 0-S TO ACC
       AXT 7M+7C+7D+7,1 07777 TO XRA
       PXA 0,1       07777 TO ADR.OF ACC
       PAX 0,1       07777 TO XRA
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA=07777 DEC=07776
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       XRA=DEC=07777
       REM           
       REM           
*CHECK TO SEE IF THE INDEX REGISTER IS RESTORED TO ITS ORIGINAL 
*CONTENTS AFTER A PXA INSTRUCTION.
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       PXA 0,1       XRA SHOULD REMAIN UNCHANGED
       TXH *+2,1,7M+7C+7D+6 SHOULD TRANSFER
       HTR *+1       XRA SHOULD STILL BE 07777
       REM           DEC=07776
       REM           XRA CHANGED WITHA PXA
       REM           INSTRUCTION
       REM           IF XRA=00000, DID NOT
       REM           RE-CYCLE THE INDEX AT ER9-C
       REM           PAGE 2.08.53.2
       TXL *+2,1,7M+7C+7D+7 SHOULD TRANSFER
       HTR *+1       XRA=DEC=07777
       REM           
       AXT 1,1       00001 TO XRA
       PXA 0,1       XRA SHOULD REMAIN UNCHANGED
       TXH *+2,1,0   SHOULD TRANSFER
       HTR *+1       XRA SHOULD 00001
       REM           DEC=00000
       TXL *+2,1,1   SHOULD TRANSFER
       HTR *+1       XRA=DEC=00001
       REM           
       REM           
*CHECK THAT PXA WITH A ZERO TAG CLEARS THE ACC ADDRESS
       REM           
       AXT 7M+7C+7D+7,1 07777 TO XRA
       CLA A55       55555 TO ACC ADDRESS
       PXA 0,0       SHOULD CLEAR ADDRESS
       PAX 0,1       BRING ADR.TO XRA AND SEE
       REM           IF IT HAS BEEN CLEARED.
       TXL *+2,1,0   SHOULD TRANSFER
       HTR *+1       ZERO TAG DID NOT CLEAR ADR.
       REM           
       REM           
*CHECK THAT THE DECREMENT ADDRESS IS CLEARED USING A PXA INSTRUCION
       REM           
       CLA AL7       ALL 1-S TO ACCUMULATOR
       AXT D0        05555 TO XRA
       PXA 0,1       SHOULD CLEAR ACC DECREMENT
       PDX 0,1       CHECK IF DEC.IS 00000
       TXL *+27,1,0  SHOULD TRANSFER
       HTR *+28      XRA SHOULD BE 00000
       REM           DEC=00000
       REM           IF XRA IS ALL 1-S,DID NOT
       REM           CLEAR ADDRESS
       REM           IF XRA=05555,BROUGHT
       REM           INDEX TO DECREMENT USING
       REM           THE PXA INSTRUCTION.
       REM           
       REM           
       REM           CONSTANTS
 D7    OCT 007777005555
 D0    OCT 000000005555
       OCT 070001005555
 DA7   OCT 077777005555
 A0    OCT 077777000000
 A01   OCT 077777070001
 A55   OCT 000000055555
 A71   OCT 71111     
 A72   OCT 72222     
 A73   OCT 73333     
 A74   OCT 74444     
 A75   OCT 011111075555
 A76   OCT 76666     
 A701  OCT 70001     
 A710  OCT 71000     
 AZE   OCT 0         
 KK    OCT 0         TEMPORARY STORAGE
       OCT 01111     
       OCT 02222     
       OCT 03333     
       OCT 04444     
       OCT 05555     
       OCT 06666     
       OCT 07777     
 AL7   OCT 7777777777777
       REM           
       REM           
       REM SYMBOLIC VALUES NOT STORED
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
       REM           
       REM           
       REM           
*          TEST FOR SIZE OF STORAGE
       REM           
       REM           
       REM           
 Q     HED           
       REM           
       REM           
       REM           
 WC    CLA CST+3     ALL 0-S
       STO 32767     STORE IN 32K OR HIGHEST
       REM           POSITION OF STORAGE
       ADD L2        
       STO 16383     16K OR HIGHEST POS. OF STG.
       ADD L2        
       STO 8191      8K OR HIGHEST POS. OF STG.
       ADD L2        
       STO 4095      4K OR HIGEST POS. OF STG.
       REM           
       REM           
       REM           
       CLA 32767     BRING BACK WORD FROM
       REM           HIGHEST POSITION OF STORAGE
       TZE DW        32K CAPACITY
       REM           
       SUB L2        
       TZE DW+3      16K CAPACITY
       REM           
       SUB L2        
       TZE DW+6      8K CAPACITY
       REM           
       SUB L2        
       TZE DW+9      4K CAPACITY
       HTR L5        ERROR TESTING STG. CAPCITY
       REM           TEST FOR 4K STG. ON RESTART
       REM           
       REM           
       REM           
       REM           
 DW    CLA CST       +00007
       STO KK        STORE CONSTANT FOR 32K
       REM           CAPCITY IN TEMPORARY STG.
       TRA RF        DOUBLE CHECK 32K CAPACITY
       REM           USING INDEX REG. ROUTING
       REM
       CLA CST+1     +00003
       STO KK        CONSTANT FOR 16K CAPACITY
       TRA RF        CHECK USING XRA ROUTING
       REM           
       CLA CST+2     +00001
       STO KK        CONSTANT FOR 8K CAPACITY
       TRA RF        CHECK USING XRA ROUTING
       REM           
       CLA CST+3     +00000
       STO KK        CONSTANT FOR 4K CAPACITY
       TRA RF        CHECK FOR XRA ROUTING
       REM           
       REM           
       REM           
 RF    AXT 32767,1   BRING HIGHEST ADR. TO XRA
       PXA 0,1       XRA TO AC
       CAS CST+4     17777 COMPARE AC WITH 8K
       TRA RF+10     16 OR 32K
       TRA RF+19     8K CAPACITY
       CLA CST+3     +00000 4K CAPACITY
       REM           
       CAS KK        SEE IF WE GOT 4K FIRST TIME
       TRA ER        
       TRA LJB+27    OK PRINT OUT 4K CAPACITY
       TRA ER        
       REM           
       CAS CST+5     37777 COMPARE AC WITH 16K
       TRA RF+24     32K CAPACITY
       TRA RF+14     16K CAPACITY
       TRA ER        
       CLA CST+1     +00003
       CAS KK        SEE IF WE GOT 16K FRST TIME
       TRA ER        
       TRA LJB+10    OK PRINT OUT 16K CAPACITY
       TRA ER        
       REM           
       REM           
       CLA CST+2     +00001
       CAS KK        SEE IF WE GOT 8K FIRST TIME
       TRA ER        
       TRA LJB+20    OK PRINT OUT 8K CAPACITY
       TRA ER        
       REM           
       CLA CST       +00007
       CAS KK        SEE IF WE GOT 32K FRST TIME
       TRA ER        
       TRA LJB       OK PRINT OUT 32K CAPACITY
       REM           
 ER    HTR L5        ERROR IN ADDRESSING LINES.
       REM           CHECK ACCUMULATOR NEONS
       REM           POS.21-23 TO DETERMINE
       REM           WHICH LINE IS UP OR DOWN
       REM           IN ERROR.
       REM           TEST FOR 4K ON RESTART
       REM           
 LJB   CLA LB        PLACE THE SIZE OF STORAGE
       ADD PRIMG+12  IN THE PRINT IMAGE
       STO PRIMG+12  32K
       CLA LB+1      
       ADD PRIMG+14  
       STO PRIMG+14  
       NOP           
       TRA PRINT     
       CLA KK        ACC SHOULD BE 00007 FOR 32K
       HTR L3        SET CONSTANT FOR 32K
       REM           
       REM           
       CLA LB        16K
       ADD PRIMG+16  
       STO PRIMG+16  
       CLA LB+1      
       ADD PRIMG+6   
       STO PRIMG+6   
       NOP           
       TRA PRINT     
       CLA KK        ACC SHOULD BE 00003 FOR 16K
       HTR L10       SET CONSTANTS FOR 16K
       REM           
       REM           
       CLA LB+1      8K
       ADD PRIMG+2   
       STO PRIMG+2   
       NOP           
       TRA PRINT     
       CLA KK        ACC SHOULD BE 00001 FOR 8K
       HTR L4        SET CONSTANTS FOR 8K
       REM           
       REM           
       CLA LB+1      4K
       ADD PRIMG+10  
       STO PRIMG+10  
       NOP           
       TRA PRINT     
       CLA KK        ACC SHOULD BE 00000 FOR 4K
       HTR L5        SET CONSTANTS FOR 4K
       REM           
       REM           
       REM           
 PRINT WPRA          FIRST PASS ONLY
       SPRA 3        
       RCHA PRIM     
       TRA SC        
       REM           
 PRIM  IOCD PRIMG,0,24
       REM           
       REM           
       REM           
       REM           
 SC    CLA KK        SET CONSTANTS DEPENDING
       REM           UPON SIZE OF STORAGE
       REM           
       CAS CST+1     +00003
       TRA L3        32K
       TRA L10       16K
       TRA SC+5      8K OR 4K
       REM           
       CAS CST+3     +00000
       TRA L4        8K
       TRA L5        4K
       HTR           ERROR IN LOOKING UP STORAGE
       REM           CAPACITY
       REM           
       REM           
*          CONSTANTS     
 CST   OCT 7         32K
       OCT 3         16K
       OCT 1         8K
       OCT 0         4K
       OCT 17777     
       OCT 37777     
 LB    OCT 20        
       OCT 10        
 KK    OCT 0         TEMPORARY STORAGE
       REM           
       REM           
       REM           
 PRIMG OCT 20000100     9L
       OCT 20100000000       9R
       OCT 0            8L
       OCT 4000000000        8R
       OCT 4000000      7L
       OCT 200020000000      7R
       OCT 400600       6L
       OCT 200000000         6R
       OCT 210210000    5L
       OCT 10000000          5R
       OCT 0            4L
       OCT 0                 4R
       OCT 141044001    3L
       OCT 50400000000       3R
       OCT 400102004    2L
       OCT 1000000000        2R
       OCT 20000        1L
       OCT 500040000000      1R
       OCT 540146000    0L
       OCT 15400000000       0R
       OCT 10610304     11L
       OCT 200300000000     11R
       OCT 225020401    12L
       OCT 560070000000     12R
       REM           
       REM           
       REM SET CONSTANTS FOR 32K STORAGE
       REM           
       REM           
 L3    CLA L12D      +074000074000
       STD K7D       L 074000 IN DECR.
       CLA K0+2      ALL ONES
       STO K0+5      
       CLA K2        L 35253 00000
       STO K0+7      
       CLA K3        L 32526 00000
       STO K0+8      
       CLA K17D      L0
       STA Z         
       STA Y         
       STD X         
       STD W         
       CLA L1+8      L 77777
       TRA L6        
       REM           
       REM SET CONSTANTS FOR 16K STORAGE
       REM           
       REM           
 L10   CLA L11D      L +034000034000
       STD K7D       L 034000 IN DECR.
       CLA K0+3      L -337777737777
       STO K0+5      
       CLA K2        L 35253000000
       STO K0+7      
       CLA K3        L 32526000000
       STO K0+8      
       CLA K22D      L 30000
       ADD K20D      L 10000
       STA Z         
       STA Y         
       ALS 18        
       STD X         
       STD W         
       CLA L1+8      L 77777
       ARS 1         
       TRA L6        
       REM           
       REM           
       REM SET CONSTANTS FOR 8K STORAGE
       REM           
 L4    CLA L5D       L +014000014000
       STD K7D       L 14000
       SUB K14D      L 000001000000
       STD K10D      L 13777
       SUB K14D      L 000001000000
       STD K11D      L 13776
       CLA K22D      L 30000
       ADD K22D      L 30000
       STA Z         
       STA Y         
       ALS 18        
       STD X         
       STD W         
       REM           
       CLA K0+4      L -317777717777
       STO K0+5      
       CLA K2+1      L 15253000000
       STO K0+7      
       CLA K3+1      L 12526000000
       STO K0+8      
       CLA L1+8      L 77777
       ARS 2         
 L6    STO L1+4      
       ALS 18        
       STO K8D       
       ARS 18        
       STA J7        
       STA J7B       
       STA J7C       
       SUB L1+5      L1
       STO L1+6      
       REM           
       ADD L1+11     L 2
       STO L1+7      100000, 40000, 30000, 20000
       REM           
       SUB L1+14     L G1+1
       ALS 18        
       STO L1+3      LOAD IS DEPENDENT ON
       REM           SIZE OF STG
       REM           
       CLA L1+7      
       SUB M+4       L M+4
       ALS 18        
       STO M+3       
       REM           
       REM           
       REM ADJUST XRB CONSTANTS
       REM           
       CLA L1+7      
       SUB S2B       L G1B+1
       ALS 18        
       STO S1B       LOAD DEPENDS ON SIZE OF STG
       REM           
       CLA L1+7      
       SUB S5B       L HTR M3B
       ALS 18        
       STO S4B       
       REM           
       REM           
       REM           
       REM ADJUST XRC CONSTANTS
       REM           
       CLA L1+7      
       SUB S2C       L G1C+1
       ALS 18        
       STO S1C       LOAD DEPENDS ON SIZE OF STG
       REM           
       CLA L1+7      
       SUB S5C       L M3C
       ALS 18        
       STO S4C       
       REM           
       REM           
       REM           
       REM ADJUST MULTIPLE TAG CONSTANTS
       REM           
       CLA K7D       L DEPENDS ON SIZE OF STG.
       SUB K14D      L 000001000000
       STD K10D      L DEPENDS ON SIZE OF STG.
       SUB K14D      L 000001000000
       STD K11D      L DEPENDS ON SIZE OF STG.
       SUB CAA       L 546000000
       STD K12D      
       REM           
       REM           
       REM COMMENCE TEST
       REM           
       REM TEST XRA  
       REM           
*    TEST THAT NO INDEX TAG LEAVE ADDR UNALTERED
       REM           
 L5    CLA L9+1      L PXD 0,1
       SUB A1+2      L PXD 0,1
       TZE L7-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR L7-3      
       SWT 1         
       TRA L7        PROCEED TO NEXT TEST
       TRA L5        REPEAT TEST
       REM           
       REM TEST THAT XR IS RESET TO ZERO IF ADR
       REM ARE BEING MODIFIED
       REM           
 L7    NOP           
 L8    LXA L1,1      L 0
       CLA L7        L NOP
       SUB L7,1      
       TZE L9-4      
       SWT 2         ERROR-TEST SWITCH 2
       HTR L9-4      
       SWT 1         
       TRA L9-1      PROCEED TO NEXT TEST
       TRA L8        REPEAT TEST
       REM           
       REM TEST PLACE XR A IN DECR
       REM           
       LXA L1,1      L 0
 L9    CLA L5        L 050000000307
       PXD 0,1       
       TZE L12-4     
       SWT 2         ERROR-TEST SWITCH 2
       HTR L12-4     
       SWT 1         
       TRA L12-1     NEXT SECTION
       TRA L9-1      REPEAT TEST
       REM           
       REM TEST-XRA, PXD AND COMP.
       REM           
       LXA K0+2,1    L 7777
 L12   CLA K0+2      
       PXD 0,1       
       COM           
       LGL 2         TO ELIMINATE P AND Q BITS
       LGR 2         
       TOV *+1       TURN OFF OVERFLOW LIGHT
       STZ M+2       CLEAR TEMP. STORAGE
       STD M+2       
       SUB W         L 370000777777
       TZE L11-3     OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR L11-3     HALT ON ERROR
       SWT 1         
       TRA L11       NEXT SECTION
       TRA L12-1     REPEAT
       REM           
       REM TEST-STD AFTER PXD COMP.
       REM           
 L11   CLA M+2       RESULTS STD
       SUB X         TEST STD
       TZE L11+5     OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR L11+5     HALT ON ERROR
       SWT 1         
       TRA A1        NEXT SECTION
       TRA L12-1     REPEAT SECTION
       REM           
       REM TEST LXD AND PXD WITH XR A
       REM           
 A1    CLA L5        L 05000000307
       LXD L1,1      LOAD XR A
       REM           WITH 1
       PXD 0,1       
       SUB L1        L DECR OF 1
       TZE A2-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR A2-3      
       SWT 1         
       TRA A2        PROCEED TO NEXT TEST
       TRA A1        REPEAT TEST
       REM           
       REM TEST LXD AND PXD WITH XR A
       REM           
 A2    CLA L5        L 050000000307
       LXD L1+1,1    LOAD XRA
       REM           WITH 2
       PXD 0,1       
       SUB L1+1      L DECR OF 2
       TZE A3-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR A3-3      
       SWT 1         
       TRA A3        PROCEED TO NEXT TEST
       TRA A2        REPEAT TEST
       REM           
       REM TEST ADR MODIFICATION USING XR A
       REM           
 A3    LXD L1,1      L 1
 A4    CLA A4,1      L A3
       SUB A3        
       TZE A5-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR A5-3      
       SWT 1         
       TRA A5        
       TRA A3        REPEAT TEST
       REM           
 A5    PXD 0,1       TEST CONTENT
       REM           OF XRA
       REM           
       SUB L1        L 1 IN DECR
       TZE A6-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR A6-3      
       SWT 1         
       TRA A6        PROCEED TO NEXT TEST
       TRA A3        REPEAT TEST
       REM           
       REM TEST TXI WITH XR A
       REM           
 A6    LXD L1,1      L 1
       TXI A9,1,1    
       TRA A8-2      
       SWT 2         ERROR-TEST SWITCH 2
       HTR A8        
 A8    SWT 1         
       TRA A9        
       TRA A6        REPEAT TEST
       REM           
       REM           
 A9    PXD 0,1       
       SUB L1+1      L 2 IN DECR
       TZE B1-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR B1-3      
       SWT 1         
       TRA B1        PROCEED TO NEXT TEST
       TRA A9        REPEAT TEST
       REM           
       REM TEST SXD WITH XR A
       REM           
 B1    LXD B2,1      L DECR 2
       SXD B3,1      
       CLA B3        
       SUB B2        
       TZE B4        
       CLA B5        TEST IF SXD
       REM           IS BEING
       REM           INDEXED
       SUB B2        
       TNZ B6        
 B6    SWT 2         ERROR-TEST SWITCH 2
       HTR B4        CHECK ACC FOR TYPE OF ERROR
       REM           
 B4    CLA L1+2      RESET TEMP. STG.
       STO B5        
       STO B3        
       SWT 1         
       TRA B7        PROCEED TO NEXT TEST
       TRA B1        REPEAT TEST
       REM           
 B5    TXI 2,1,12    CONSTANTS
 B3    TXI 2,1,12    
 B2    TXI 2,1,2     
       REM           
       REM           
       REM TEST PDX WITH XR A
       REM           
 B7    LXD L1,1      L1
       CLM           
       PDX 0,1       
       PXD 0,1       
       TZE B8-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR B8-3      
       SWT 1         
       TRA B8        PROCEED TO NEXT TEST
       TRA B7        REPEAT TEST
       REM           
       REM TEST LXA WITH XRA
       REM           
 B8    CLM           
       PDX 0,1       RESET XR A
       LXA L1+2,1    L2
       PXD 0,1       
       SUB L1+1      L2 IN DECR
       TZE B9-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR B9-3      
       SWT 1         
       TRA B9        PROCEED TO NEXT TEST
       TRA B8        REPEET TEST
       REM           
       REM TEST PAX WITH XR A
       REM           
 B9    CLA L1+2      L 2 IN ADDR
       LXD L1,1      L 1
       PAX 0,1       
       PXD 0,1       
       SUB L1+1      L 2 IN DECR
       TZE C1-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR C1-3      
       SWT 1         
       TRA C1        PROCEED TO NEXT TEST
       TRA B9        REPEAT TEST
       REM           
       REM TEST TXH WHEN XRA IS LOW
       REM           
 C1    LXD L1,1      L 1
       TXH C2-2,1,2  
       TRA C3        
       SWT 2         ERROR-TEST SWITCH 2
       HTR C2        
 C2    SWT 1         
       TRA C3        
       TRA C1        REPEAT TEST
       REM           
 C3    PXD 0,1       TEST XR A
       SUB L1        
       TZE C4-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR C4-3      
       SWT 1         
       TRA C4        PROCEED TO NEXT TEST
       TRA C3        REPEAT TEST
       REM           
       REM TEST TXH WHEN XR + DECR EQUAL
       REM           
 C4    LXD L1,1      L 1
       TXH C5-2,1,1    
       TRA C6        
       SWT 2         ERROR-TEST SWITCH 2
       HTR C5        
 C5    SWT 1         
       TRA C6        
       TRA C4        REPEAT TEST
       REM           
 C6    PXD 0,1       TEST XR
       SUB L1        L 1 IN DECR
       TZE C7-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR C7-3      
       SWT 1         
       TRA C7        PROCEED TO NEXT TEST
       TRA C6        REPEAT TEST
       REM           
       REM TEST TXH WHEN XR IS HIGH
       REM           
 C7    LXD L1,1      L 1
       TXH C8,1      
       SWT 2         ERROR-TEST SWITCH 2
       HTR C9        
 C9    SWT 1         
       TRA C8        
       TRA C7        REPEAT TEST
       REM           
 C8    PXD 0,1       TEST XR
       SUB L1        L 1 IN DECR
       TZE D1-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR D1-3      
       SWT 1         
       TRA D1        PROCEED TO NEXT TEST
       TRA C8        REPEAT TEST
       REM           
       REM TEST TXL WHEN XR IS HIGH
       REM           
 D1    LXD L1,1      L 1
       TXL D2-2,1    
       TRA D3        
       SWT 2         ERROR-TEST SWITCH 2
       HTR D2        
 D2    SWT 1         
       TRA D3        
       TRA D1        REPEAT TEST
       REM           
 D3    PXD 0,1       TEST XR
       SUB L1        L 1 IN DECR
       TZE D4-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR D4-3      
       SWT 1         
       TRA D4        PROCEED TO NEXT TEST
       TRA D3        REPEAT TEST
       REM           
       REM TEST TXL WHEN XR EQUALS DECR
       REM           
 D4    LXD L1,1      L 1
       TXL D5,1,1    
       SWT 2         ERROR-TEST SWITCH 2
       HTR D6        
       REM           
 D6    SWT 1         
       TRA D5        
       TRA D4        REPEAT TEST
       REM           MODIFIED
 D5    PXD 0,1       TEST XR A
       SUB L1        L 1 IN DECR
       TZE D7-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR D7-3      
       SWT 1         
       TRA D7        PROCEED TO NEXT TEST
       TRA D5        REPEAT TEST
       REM           
       REM TEST TXL WHEN XR IS LOW
       REM           
 D7    LXD L1,1      L 1
       TXL D8,1,2    
       SWT 2         ERROR-TEST SWITCH 2
       HTR D9        
 D9    SWT 1         
       TRA D8        
       TRA D7        REPEAT TEST
       REM           
 D8    PXD 0,1       TEST XR A
       SUB L1        L 1 IN DECR
       TZE E1-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR E1-3      
       SWT 1         
       TRA E1        PROCEED TO NEXT TEST
       TRA D8        REPEAT TEST
       REM           
       REM TEST TIX XR GREATER THEN DECR
       REM           
 E1    LXD L1+1,1    L 2
       TIX E2,1,1    
       SWT 2         ERROR-TEST SWITCH 2
       HTR E4        
 E4    SWT 1         
       TRA E2        
       TRA E1        REPEAT TEST
       REM           
 E2    PXD 0,1       TEST XR A
       SUB L1        L 1 IN DECR
       TZE E5-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR E5-3      
       SWT 1         
       TRA E5        PROCEED TO NEXT TEST
       TRA E2        REPEAT TEST
       REM           
       REM TEST TIX XR EQUALS DECR
       REM           
 E5    LXD L1+1,1    L2
       TIX E6-2,1,2  
       TRA E7        
       SWT 2         ERROR-TEST SWITCH 2
       HTR E6        
 E6    SWT 1         
       TRA E7        
       TRA E5        REPEAT TEST
       REM           
 E7    PXD 0,1       TEST XR A
       SUB L1+1      L 2 IN DECR
       TZE E8-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR E8-3      
       SWT 1         
       TRA E8        PROCEED TO NEXT TEST
       TRA E7        REPEAT TEST
       REM           
       REM TEST TIX XR LESS THEN DECR
       REM           
 E8    LXD L1,1      L 1
       TIX E9-2,1,2  
       TRA F1        
       SWT 2         ERROR-TEST SWITCH 2
       HTR E9        
 E9    SWT 1         
       TRA F1        
       TRA E8        REPEAT TEST
       REM           
 F1    PXD 0,1       TEST XR A
       SUB L1        L 1 IN DECR
       TZE F2-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR F2-3      
       SWT 1         
       TRA F2        PROCEED TO NEXT TEST
       TRA F1        REPEAT TEST
       REM           
       REM TEST TNX XR LESS THAN DECR
       REM           
 F2    LXD L1,1      L 1
       TNX F3,1,2    
       SWT 2         ERROR-TEST SWITCH 2
       HTR F2+4      
       SWT 1         
       TRA F3        
       TRA F2        REPEAT TEST
       REM           
 F3    PXD 0,1       
       SUB L1        L 1 IN DECR
       TZE F4-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR F4-3      
       SWT 1         
       TRA F4        PROCEED TO NEXT TEST
       TRA F3        REPEAT TEST
       REM           
       REM TEST TNX XR EQUALS DECR
       REM           
 F4    LXD L1,1      L 1
       TNX F5,1,1    
       SWT 2         ERROR-TEST SWITCH 2
       HTR F6        
 F6    SWT 1         
       TRA F5        
       TRA F4        REPEAT TEST
       REM           
 F5    PXD 0,1       TEST XR A
       SUB L1         L 1 IN DECR
       TZE F7-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR F7-3      
       SWT 1         
       TRA F7        PROCEED TO NEXT TEST
       TRA F5        REPEAT TEST
       REM           
       REM TEST TNX XR GREATER THAN DECR
       REM           
 F7    LXD L1+1,1    L 2
       TNX F8-2,1,1  
       TRA F9        
       SWT 2         ERROR-TEST SWITCH 2
       HTR F8        
 F8    SWT 1         
       TRA F9        
       TRA F7        REPEAT TEST
       REM           
 F9    PXD 0,1       TEST XR A
       SUB L1        L 1 IN DECR
       TZE G1-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR G1-3      
       SWT 1         
       TRA G1        PROCEED TO NEXT TEST
       TRA F9        REPEAT TEST
       REM           
       REM TEST TSX  
       REM           
 G1    LXA G1,1      L OWN ADDRESS
       TSX G2,1      
       SWT 2         ERROR-TEST SWITCH 2
       HTR G3        
 G3    SWT 1         
       TRA G2        
       TRA G1        REPEAT TEST
       REM           
 G2    PXD 0,1       L COMP TSX
       REM           LOCATION IN
       REM           DECR
       SUB L1+3      L 007017000000
       TZE G4-3      
       SWT 2         ERROR-TEST SWITCH 2
       HTR G4-3      
       SWT 1         
       TRA G4        PROCEED TO NEXT TEST
       TRA G1        REPEAT TEST
       REM           
       REM TEST TIX FOR COUNTING
       REM           
 G4    LXA L1+4,1    L 7777
       CLA L1+4      L07777
       SWT 4         
       TRA G5        
       SWT 3         
       TRA G6        
       TRA G7        
       REM           
 G5    SUB L1+5      L 00001
       TIX G5,1,1    
       TRA G8        
 G6    SUB L1+13     L 00100
       TIX G6,1,64   
       ADD L1+13     L00100
       TRA G5        
 G7    SUB L1+12     L 1000
       TIX G7,1,512  
       ADD L1+12     L 1000
       TRA G6        
 G8    TZE G9-3      TO NEXT TEST
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR G9-3      
       SWT 1         
       TRA G9        PROCEED TO NEXT TEST
       TRA G4        REPEAT TEST
       REM           
       REM TEST TNX FOR COUNTING
       REM           
 G9    LXA L1+4,1    L 7777
       CLA L1+6      L 07776
       SWT 4         
       TRA H1        
       SWT 3         
       TRA H2        
       TRA H3        
       REM           
 H1    TNX H5,1,1    
       SUB L1+5      L00001
       TRA H1        
 H2    TNX H1,1,64   
       SUB L1+13     L00100
       TRA H2        
 H3    TNX H2,1,512  
       SUB L1+12     L 1000
 H4    TRA H3        
 H5    TZE H6-3      TO NEXT TEST
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR H6-3      
       SWT 1         
       TRA H6        PROCEED TO NEXT TEST
       TRA G9        REPEAT TEST
       REM           
       REM TEST TXI FOR COUNTING
       REM           
 H6    LXA L1+9,1    L 00000
       CLA L1+7      L DEPENDS ON SIZE OF STG.
       SWT 4         
       TRA H7        
       SWT 3         
       TRA H8        
       TRA H9        
       REM           
 J2    TZE J1        
 H7    SUB L1+5      L 00001
       TXI J2,1,1    
 J3    TXH J2,1,3968 
 H8    SUB L1+13     L 00100
       TXI J3,1,64   
 H9    TXH H8,1,3072 
       SUB L1+12     L 1000
       TXI H9,1,512  
 J1    PXD 0,1       
       TZE J4-3      TO NEXT TEST
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR J4-3      
       SWT 1         
       TRA J4        PROCEED TO NEXT TEST
       TRA H6        REPEAT TEST
       REM           
       REM TEST ADR MODIFICATION FOR ALL
       REM POSITIONS IN MEMORY
       REM           
 J4    CLM           
       STA J5        
       LXA L1+4,1    L 7777
 J7    CLA 4095,1    
 J5    SUB 0         
       TNZ J6-2      
       CLA J5        
       ADD L1+5      L1
       STA J5        MODIFY ADDR.
       TIX J7,1,1    
       TRA J6        
       SWT 2         ERROR-TEST SWITCH 2
       HTR J6        
 J6    SWT 1         
       TRA M1-2      
       TRA J4        
       REM           
       REM           
       SWT 5         
       TRA N1-2      GO TO NEXT TEST
 M1    LDQ M         CLEAR MQ
       REM           SSW 5 DOWN TEST HPR
       REM           AND TSX INST
       HPR           KEY IN TSX INST. INTO 
       REM           MQ WITH ADDR OF
       REM           M4 TAG A
       TRA M2        O K
       SWT 2         ERROR-TEST SWITCH 2
       HTR M2-3      
       SWT 1         
       TRA M2        
       TRA M1        RE-LOOP
       REM           
 M2    STQ M+2       CHECK TSX INST
       CLA M+2       
       SUB M+1       L TSX
       TZE M3-3      TRANSFER ON ZERO O K
       SWT 2         ERROR-TEST SWITCH 2
       HTR M3-3      
       REM           
       SWT 1         
       TRA M3        
       TRA M1        ERROR ON TSX TEST
       REM           
 M3    HPR           EXECUTE TSX INST
       REM           TO M4 TAG A
       REM           
       TRA M4+3      DID NOT EXECUTE TSX
       TRA M4+3      ERROR
       REM           
 M4    PXD 0,1       
       SUB M+3       L 006631000000
       TZE N1-5      OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR M4+5      
       SWT 1         
       TRA N1-2      PROCEED TO NEXT TEST
       TRA M3        REPEAT TEST
       REM           
       REM TEST-PLACE INDEX IN ADDRESS
       REM           
       CLA K0+2      L-377777777777
       LXA K0,1      L +0
 N1    PXA 0,1       CHECK CLEARING ACC
       TZE N2-5      
       SWT 2         ERROR-TEST SWITCH 2
       HTR N2-5      
       SWT 1         
       TRA N2-2      
       TRA N1-2      REPEAT TEST
       REM           
       CLA K0+2      L ALL ONES
       LXA K0+1,1    L +1
 N2    PXA 0,1       CHECK CLEAR ALL BUT ADR
       SUB K0+1      L +1
       TZE N3-4      
       SWT 2         ERROR-TEST SWITCH 2
       HTR N3-4      
       SWT 1         
       TRA N3-1      
       TRA N2-2      REPEAT TEST
       REM           
       LXA K0+5,1    L DEPENDS ON SIZE OF STG
 N3    PXA 0,1       CHECK ALL POSITIONS
       SUB L1+4      L 07777, 17777, 37777, 77777
       TZE N3+5      
       SWT 2         ERROR-TEST SWITCH 2
       HTR N3+5      
       SWT 1         
       TRA AN1-2     NEXT SECTION
       TRA N3-1      REPEAT TEST
       REM           
       REM TEST-XRA, PXA AND COMP.
       REM           
       CLA K0+2      L ALL ONES
       LXA L1+4,1    L 7777
 AN1   PXA 0,1       
       COM           
       LGL 2         TO ELIMINATE P AND Q BITS
       LGR 2         
       TOV *+1       TURN OFF OVERFLOW LIGHT
       STZ M+2       CLEAR TEMP STG.
       STA M+2       
       SUB Y         L 3777777770000
       TZE AN2       OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR AN2       HALT ON ERROR
 AN2   SWT 1         
       TRA AN2+3     NEXT SECTION
       TRA AN1-2     REPEAT
       REM           
       REM TEST-STA AFTER PXA COMP.
       REM           
       CLA M+2       RESULTS STA
       SUB Z         TEST STA
       TZE AN2+8     OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR AN2+8     HALT ON ERROR
       SWT 1         
       TRA N4-2      NEXT SECTION
       TRA AN1-2     REPEAT
       REM           
       REM TEST STORE INDEX IN ADDRESS
       REM           
       LXA K0+1,1    L +1
       STZ T1        BLANK TEMP STG
 N4    SXA T1,1      PUT 1 IN ADR OF STORAGE
       CLA T1        L 0
       SUB K0+1      L +1
       TNZ N4+7      
       REM           
       PXA 0,1       CHECK IF INDEX HAS CHANGED
       SUB K0+1      L +1
       TZE N5-9      
       SWT 2         ERROR-TEST SWITCH 2
       HTR N5-9      
       SWT 1         
       TRA N5-6      
       TRA N4-2      REPEAT TEST
       REM           
       CAL K0+5      L -3077777707777
       ALS 18        CLEAR ACC. ADDR. AND TAG
       SLW T1        
       CAL K0+2      TO BRING IN TAG OF 7
       STT T1        
       LXA K0+5,1    L DEPENDS ON SIZE OF STG
 N5    SXA T1,1      CHECK ALL POSITIONS
       CLA T1        
       SUB K0+5      L DEPENDS ON SIZE OF STG
       TZE N6-5      
       SWT 2         ERROR-TEST SWITCH 2
       HTR N6-5      
       SWT 1         
       TRA N6-2      PROCEED TO NEXT TEST
       TRA N5-6      
       REM           
       REM TEST-PLACE 2S COMP OF ADR IN XR
       REM           
       CLA K0+6      L 345252742525
       LXA K0+6,1    L 42525
 N6    PAC 0,1       
       SUB K0+6      CHECK ACC UNCHANGED
       TNZ N6+6      NG
       REM           
       PXD 0,1       CHECK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE N7-5      
       SWT 2         ERROR-TEST SWITCH 2
       HTR N7-5      
       SWT 1         
       TRA N7-2      
       TRA N6-2      
       REM           
       REM TEST-PLACE 2S COMP OF DECR IN XR
       REM           
       CLA K0+6      L 345252742525
       LXD K0+6,1    L 45252
 N7    PDC 0,1       
       SUB K0+6      CHECK ACC UNCHANGED
       TNZ N7+6      NG
       REM           
       PXD 0,1       CHECK XR
       SUB K0+8      L DEPENDS ON SIZE OF STG
       TZE N10-4     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N10-4     
       SWT 1         
       TRA N10-1     PROCEED TO NEXT TEST
       TRA N7-2      REPEAT TEST
       REM           
       REM TEST-LOAD ADR 2S COMP IN INDEX
       REM           
       LXA K0+5,1    L DEPENDS ON SIZE OF STG
 N10   LAC K0+6,1    L 42525
       PXD 0,1       BRING BACK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE N11-4     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N11-4     
       SWT 1         
       TRA N11-1     PROCEED TO NEXT TEST
       TRA N10-1     REPEAT TEST
       REM           
       REM TEST-LOAD DECR 2S COMP IN INDEX
       REM           
       LXA K0+5,1    L DEPENDS ON SIZE OF STG
 N11   LDC K0+6,1    L 45252
       PXD 0,1       BRING BACK XR
       SUB K0+8      L DEPENDS ON SIZE OF STG
       TZE N12-5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N12-5     
       SWT 1         
       TRA N12-2     PROCEED TO NEXT TEST
       TRA N11-1     REPEAT TEST
       REM           
       REM TEST-LOAD OWN ADDRESS IN XR
       REM           
       CLA K0        L+0
       LXA K0+5,1    L DEPENDS ON SIZE OF STG
 N12   AXT 15019,1   PUT 35253 IN XR
       PXD 0,1       BRING BACK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE N13-5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N13-5     
       SWT 1         
       TRA N13-2     PROCEED TO NEXT TEST
       TRA N12-2     REPEAT TEST
       REM           
       REM TEST-LOAD COMP OF OWN ADDRESS
       REM           
       CLA K0        L+0
       LXA K0+5,1    L DEPENDS ON SIZE OF STG
 N13   AXC 17749,1   PUT 35253 IN XRA
       PXD 0,1       BRING BACK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE L5B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR L5B-3     
       SWT 1         
       TRA L5B       PROCEED TO NEXT TEST
       TRA N13-2     REPEAT TEST
       REM           
       REM           
*   TEST THAT NO INDEX TAG LEAVES ADR UNALTERED
       REM           
 L5B   CLA L9B+1     L PXD 0,2
       SUB A1B+2     L PXD 0,1
       TZE L7B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR L7B-3     
       REM           
       REM           
       REM TEST XRB  
       REM           
       REM           
       SWT 1         
       TRA L7B       PROCEED TO NEXT TEST
       TRA L5B       REPEAT TEST
       REM           
       REM TEST THAT XR IS RESET TO ZERO IF ADR
       REM ARE BEING MODIFIED
       REM           
 L7B   NOP           
 L8B   LXA L1,2      L 0
       CLA L7B       
       SUB L7B,2     
       TZE L9B-4     
       SWT 2         ERROR-TEST SWITCH 2
       HTR L9B-4     
       SWT 1         
       TRA L9B-1     PROCEED TO NEXT TEST
       TRA L8B       REPEAT TEST
       REM           
       REM TEST PLACE XR B IN DECR
       REM           
       LXA L1,2      L 0
 L9B   CLA L5B       
       PXD 0,2       
       TZE A1B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A1B-3     
       SWT 1         
       TRA A1B       NEXT SECTION
       TRA L9B-1     REPEAT TEST
       REM           
       REM TEST LXD AND PXD WITH XR B
       REM           
 A1B   CLA L5B       L CLA
       LXD L1,2      LOAD XR B
       REM           WITH 1
       PXD 0,2       
       SUB L1        L DECR OF 1
       TZE A1B+7     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A1B+7     
       SWT 1         
       TRA L10B-1    PROCEED TO NEXT TEST
       TRA A1B       REPEAT TEST
       REM           
       REM TEST-XRB, PXD AND COMP.
       REM           
       LXA K0+2,2    L 7777
 L10B  CLA K0+2      
       PXD 0,2       
       COM           
       LGL 2         TO ELIMINATE P AND Q BITS
       LGR 2         
       TOV *+1       TURN OFF OVERFLOW LIGHT
       STZ M+2       CLEAR TEMP. STORAGE
       STD M+2       
       SUB W         L 370000777777
       TZE L11B-3    OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR L11B-3    HALT ON ERROR
       SWT 1         
       TRA L11B      NEXT SECTION
       TRA L10B-1    REPEAT
       REM           
       REM TEST-STD AFTER PXD COMP.
       REM           
 L11B  CLA M+2       RESULTS STD
       SUB X         TEST STD
       TZE L11B+5    OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR L11B+5    HALT ON ERROR
       SWT 1         
       TRA A2B       NEXT SECTION
       TRA L10B-1    REPEAT SECTION
       REM           
       REM TEST LXD AND PXD WITH XR B 
       REM           
 A2B   CLA L5B       L CLA
       LXD L1+1,2    LOAD XRB
       REM           WITH 2
       PXD 0,2       
       SUB L1+1      L DECR OF 2
       TZE A3B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A3B-3     
       SWT 1         
       TRA A3B       PROCEED TO NEXT TEST
       TRA A2B       REPEAT TEST
       REM           
       REM TEST ADR MODIFICATION USING XR B
       REM           
 A3B   LXD L1,2      L 1
 A4B   CLA A4B,2     
       SUB A3B       
       TZE A5B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A5B-3     
       SWT 1         
       TRA A5B       
       TRA A3B       REPEAT TEST
       REM           
 A5B   PXD 0,2       TEST CONTENT
       REM           OF XRB
       SUB L1        L 1 IN DECR
       TZE A6B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A6B-3     
       SWT 1         
       TRA A6B       PROCEED TO NEXT TEST
       TRA A3B       REPEAT TEST
       REM           
       REM TEST TXI WITH XR B
       REM           
 A6B   LXD L1,2      L 1
       TXI A9B,2,1   
       TRA A8B-2     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A8B       
 A8B   SWT 1         
       TRA A9B       
       TRA A6B       REPEAT TEST
       REM           
 A9B   PXD 0,2       
       SUB L1+1      L 2 IN DECR
       TZE B1B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR B1B-3     
       SWT 1         
       TRA B1B       PROCEED TO NEXT TEST
       TRA A9B       REPEAT TEST
       REM           
       REM TEST SXD WITH XR B
       REM           
 B1B   LXD B2B,2     L DECR 2
       SXD B3B,2     
       CLA B3B       
       SUB B2B       
       TZE B4B       
       REM           
       CLA B5B       TEST IF SXD
       REM           IS BEING
       REM           INDEXED
       SUB B2B       
       TNZ B6B       
 B6B   SWT 2         ERROR-TEST SWITCH 2
       HTR B4B       CHECK ACC FOR TYPE OF ERROR
 B4B   CLA S10B      RESET TEMP. STG.
       STO B5B       
       STO B3B       
       SWT 1         
       TRA B7B       PROCEED TO NEXT TEST
       TRA B1B       REPEAT TEST
       REM           
 B5B   TXI 2,2,12    CONSTANTS
 B3B   TXI 2,2,12    
 B2B   TXI 2,2,2     
       REM           
       REM TEST PDX WITH XR B
       REM           
 B7B   LXD L1,2      L1
       CLM           
       PDX 0,2       
       PXD 0,2       
       TZE B8B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR B8B-3     
       SWT 1         
       TRA B8B       PROCEED TO NEXT TEST
       TRA B7B       REPEAT TEST
       REM           
       REM TEST LXA WITH XRB
       REM           
 B8B   CLM           
       PDX 0,2       RESET XR B
       LXA L1+2,2    L2
       PXD 0,2       
       SUB L1+1      L2 IN DECR
       TZE B9B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR B9B-3     
       SWT 1         
       TRA B9B       PROCEED TO NEXT TEST
       TRA B8B       REPEET TEST
       REM           
       REM TEST PAX WITH XR B
       REM           
 B9B   CLA L1+2      L 2 IN ADDR
       LXD L1,2      L 1
       PAX 0,2       
       PXD 0,2       
       SUB L1+1      L 2 IN DECR
       TZE C1B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR C1B-3     
       SWT 1         
       TRA C1B       PROCEED TO NEXT TEST
       TRA B9B       REPEAT TEST
       REM           
       REM TEST TXH WHEN XRB IS LOW
       REM           
 C1B   LXD L1,2      L 1
       TXH C2B-2,2,2 
       TRA C3B       
       SWT 2         ERROR-TEST SWITCH 2
       HTR C2B       
 C2B   SWT 1         
       TRA C3B       
       TRA C1B       REPEAT TEST
       REM           
 C3B   PXD 0,2       TEST XR B
       SUB L1        
       TZE C4B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR C4B-3     
       SWT 1         
       TRA C4B       PROCEED TO NEXT TEST
       TRA C3B       REPEAT TEST
       REM           
       REM TEST TXH WHEN XR + DECR EQUAL
       REM           
 C4B   LXD L1,2      L 1
       TXH C5B-2,2,1 
       TRA C6B       
       SWT 2         ERROR-TEST SWITCH 2
       HTR C5B       
 C5B   SWT 1         
       TRA C6B       
       TRA C4B       REPEAT TEST
       REM           
 C6B   PXD 0,2       TEST XR
       SUB L1        L 1 IN DECR
       TZE C7B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR C7B-3     
       SWT 1         
       TRA C7B       PROCEED TO NEXT TEST
       TRA C6B       REPEAT TEST
       REM           
       REM TEST TXH WHEN XR IS HIGH
       REM           
 C7B   LXD L1,2      L 1
       TXH C8B,2      
       SWT 2         ERROR-TEST SWITCH 2
       HTR C9B       
 C9B   SWT 1         
       TRA C8B       
       TRA C7B       REPEAT TEST
       REM           
 C8B   PXD 0,2       TEST XR
       SUB L1        L 1 IN DECR
       TZE D1B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR D1B-3     
       SWT 1         
       TRA D1B       PROCEED TO NEXT TEST
       TRA C8B       REPEAT TEST
       REM           
       REM TEST TXL WHEN XR IS HIGH
       REM           
 D1B   LXD L1,2      L 1
       TXL D2B-2,2    
       TRA D3B       
       TRA D2B-2     ERROR TRANS
       SWT 2         ERROR-TEST SWITCH 2
       HTR D2B     
 D2B   SWT 1         
       TRA D3B       
       TRA D1B       REPEAT TEST
       REM           
 D3B   PXD 0,2       TEST XR
       SUB L1        L 1 IN DECR
       TZE D4B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR D4B-3     
       SWT 1         
       TRA D4B       PROCEED TO NEXT TEST
       TRA D3B       REPEAT TEST
       REM           
       REM TEST TXL WHEN XR EQUALS DECR
       REM           
 D4B   LXD L1,2      L 1
       TXL D5B,2,1   
       SWT 2         ERROR-TEST SWITCH 2
       HTR D6B       
 D6B   SWT 1         
       TRA D5B       
       TRA D4B       REPEAT TEST
       REM           MODIFIED
 D5B   PXD 0,2       TEST XR B
       SUB L1        L 1 IN DECR
       TZE D7B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR D7B-3     
       SWT 1         
       TRA D7B       PROCEED TO NEXT TEST
       TRA D5B       REPEAT TEST
       REM           
       REM TEST TXL WHEN XR IS LOW
       REM           
 D7B   LXD L1,2      L 1
       TXL D8B,2,2   
       SWT 2         ERROR-TEST SWITCH 2
       HTR D9B       
 D9B   SWT 1         
       TRA D8B       
       TRA D7B       REPEAT TEST
       REM           
 D8B   PXD 0,2       TEST XR B
       SUB L1        L 1 IN DECR
       TZE E1B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR E1B-3     
       SWT 1         
       TRA E1B       PROCEED TO NEXT TEST
       TRA D8B       REPEAT TEST
       REM           
       REM TEST TIX XR GREATER THEN DECR
       REM           
 E1B   LXD L1+1,2    L 2
       TIX E2B,2,1    
       SWT 2         ERROR-TEST SWITCH 2
       HTR E4B       
 E4B   SWT 1         
       TRA E2B       
       TRA E1B       REPEAT TEST
       REM           
 E2B   PXD 0,2       TEST XR B
       SUB L1        L 1 IN DECR
       TZE E5B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR E5B-3     
       SWT 1         
       TRA E5B       PROCEED TO NEXT TEST
       TRA E2B       REPEAT TEST
       REM           
       REM TEST TIX XR EQUALS DECR
       REM           
 E5B   LXD L1+1,2    L2
       TIX E6B-2,2,2 
       TRA E7B       
       SWT 2         ERROR-TEST SWITCH 2
       HTR E6B       
 E6B   SWT 1         
       TRA E7B       
       TRA E5B       REPEAT TEST
       REM           
 E7B   PXD 0,2       TEST XR B
       SUB L1+1      L 2 IN DECR
       TZE E8B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR E8B-3     
       SWT 1         
       TRA E8B       PROCEED TO NEXT TEST
       TRA E7B       REPEAT TEST
       REM           
       REM TEST TIX XR LESS THEN DECR
       REM           
 E8B   LXD L1,2      L 1
       TIX E9B-2,2,2 
       TRA F1B       
       SWT 2         ERROR-TEST SWITCH 2
       HTR E9B       
 E9B   SWT 1         
       TRA F1B       
       TRA E8B       REPEAT TEST
       REM           
 F1B   PXD 0,2       TEST XR B
       SUB L1        L 1 IN DECR
       TZE F2B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR F2B-3     
       SWT 1         
       TRA F2B       PROCEED TO NEXT TEST
       TRA F1B       REPEAT TEST
       REM           
       REM TEST TNX XR LESS THAN DECR
       REM           
 F2B   LXD L1,2      L 1
       TNX F3B,2,2   
       SWT 2         ERROR-TEST SWITCH 2
       HTR F2B+4     
       SWT 1         
       TRA F3B       
       TRA F2B       REPEAT TEST
       REM           
 F3B   PXD 0,2       
       SUB L1        L 1 IN DECR
       TZE F4B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR F4B-3     
       SWT 1         
       TRA F4B       PROCEED TO NEXT TEST
       TRA F3B       REPEAT TEST
       REM           
       REM TEST TNX XR EQUALS DECR
       REM           
 F4B   LXD L1,2      L 1
       TNX F5B,2,1   
       SWT 2         ERROR-TEST SWITCH 2
       HTR F6B       
 F6B   SWT 1         
       TRA F5B       
       TRA F4B       REPEAT TEST
       REM           
 F5B   PXD 0,2       TEST XR B
       SUB L1         L 1 IN DECR
       TZE F7B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR F7B-3     
       SWT 1         
       TRA F7B       PROCEED TO NEXT TEST
       TRA F5B       REPEAT TEST
       REM           
       REM TEST TNX XR GREATER THAN DECR
       REM           
 F7B   LXD L1+1,2    L 2
       TNX F8B-2,2,1 
       TRA F9B       
       SWT 2         ERROR-TEST SWITCH 2
       HTR F8B       
 F8B   SWT 1         
       TRA F9B       
       TRA F7B       REPEAT TEST
       REM           
 F9B   PXD 0,2       TEST XR A
       SUB L1        L 1 IN DECR
       TZE G1B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR G1B-3     
       SWT 1         
       TRA G1B       PROCEED TO NEXT TEST
       TRA F9B       REPEAT TEST
       REM           
       REM TEST TSX  
       REM           
 G1B   LXA G1B,2     L OWN ADDRESS
       TSX G2B,2     
       SWT 2         ERROR-TEST SWITCH 2
       HTR G3B       
 G3B   SWT 1         
       TRA G2B       
       TRA G1B       REPEAT TEST
       REM           
 G2B   PXD 0,2       L COMP TSX
       REM           LOCATION IN
       REM           DECR
       SUB S1B       L 007017000000
       TZE G4B-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR G4B-3     
       SWT 1         
       TRA G4B       PROCEED TO NEXT TEST
       TRA G1B       REPEAT TEST
       REM           
       REM TEST TIX FOR COUNTING
       REM           
 G4B   LXA L1+4,2    L 7777
       CLA L1+4      L07777
       SWT 4         
       TRA G5B       
       SWT 3         
       TRA G6B       
       TRA G7B       
       REM           
 G5B   SUB L1+5      L 00001
       TIX G5B,2,1   
       TRA G8B       
 G6B   SUB L1+13     L 00100
       TIX G6B,2,64  
       ADD L1+13     L00100
       TRA G5B       
 G7B   SUB L1+12     L 1000
       TIX G7B,2,512 
       ADD L1+12     L 1000
       TRA G6B       
 G8B   TZE G9B-3     TO NEXT TEST
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR G9B-3     
       SWT 1         
       TRA G9B       PROCEED TO NEXT TEST
       TRA G4B       REPEAT TEST
       REM           
       REM TEST TNX FOR COUNTING
       REM           
 G9B   LXA L1+4,2    L 7777
       CLA L1+6      L 07776
       SWT 4         
       TRA H1B       
       SWT 3         
       TRA H2B       
       TRA H3B       
       REM           
 H1B   TNX H5B,2,1   
       SUB L1+5      L00001
       TRA H1B       
 H2B   TNX H1B,2,64  
       SUB L1+13     L00100
       TRA H2B       
 H3B   TNX H2B,2,512 
       SUB L1+12     L 1000
 H4B   TRA H3B       
 H5B   TZE H6B-3     TO NEXT TEST
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR H6B-3     
       SWT 1         
       TRA H6B       PROCEED TO NEXT TEST
       TRA G9B       REPEAT TEST
       REM           
       REM TEST TXI FOR COUNTING
       REM           
 H6B   LXA L1+9,2    L 00000
       CLA L1+7      L DEPENDS ON SIZE OF STG.
       SWT 4         
       TRA H7B       
       SWT 3         
       TRA H8B       
       TRA H9B       
       REM           
 J2B   TZE J1B       
 H7B   SUB L1+5      L 1
       TXI J2B,2,1   
 J3B   TXH J2B,2,3968 
 H8B   SUB L1+13     L 00100
       TXI J3B,2,64   
 H9B   TXH H8B,2,3072 
       SUB L1+12     L 1000
       TXI H9B,2,512 
       REM           
 J1B   PXD 0,2       
       TZE J4B-3     TO NEXT TEST
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR J4B-3     
       SWT 1         
       TRA J4B       PROCEED TO NEXT TEST
       TRA H6B       REPEAT TEST
       REM           
       REM TEST ADR MODIFICATION FOR ALL
       REM POSITIONS IN MEMORY
       REM           
 J4B   CLM           
       STA J5B       
       LXA L1+4,2    L 7777
 J7B   CLA 4095,2    
 J5B   SUB 0         
       TNZ J6B-2     
       CLA J5B       
       ADD L1+5      L1
       STA J5B       MODIFY ADDR.
       TIX J7B,2,1   
       TRA J6B       
       SWT 2         ERROR-TEST SWITCH 2
       HTR J6B       
 J6B   SWT 1         
       TRA M1B-2     
       TRA J4B       
       REM           
       REM           
       SWT 5         
       TRA N1B-2     GO TO NEXT TEST
 M1B   LDQ M         CLEAR MQ
       REM           SSW 5 DOWN TEST HPR
       REM           AND TSX INST
       HPR           KEY IN TSX INST. INTO 
       REM           MQ WITH ADDR OF
       REM           M4 TAG A
       TRA M2B       O K
       SWT 2         ERROR-TEST SWITCH 2
       HTR M2B-3     
       SWT 1         
       TRA M2B       
       TRA M1B       RE-LOOP
       REM           
 M2B   STQ S7B       CHECK TSX INST
       CLA S7B       
       SUB S3B       
       TZE M3B-3     TRANSFER ON ZERO O K
       SWT 2         ERROR-TEST SWITCH 2
       HTR M3B-3     
       REM           
       SWT 1         
       TRA M3B       
       TRA M1B       ERROR ON TSX TEST
       REM           
 M3B   HPR           EXECUTE TSX INST
       REM           TO M4B TAG B
       REM           
       TRA M4B+3     DID NOT EXECUTE TSX
       TRA M4B+3     ERROR
       REM           
 M4B   PXD 0,2       
       SUB S4B       
       TZE N1B-5     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR M4B+5     
       SWT 1         
       TRA N1B-2     PROCEED TO NEXT TEST
       TRA M3B       REPEAT TEST
       REM           
       REM TEST-PLACE INDEX IN ADDRESS
       REM           
       CLA K0+2      L-377777777777
       LXA K0,2      L +0
 N1B   PXA 0,2       CHECK CLEARING ACC
       TZE N2B-5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N2B-5     
       SWT 1         
       TRA N2B-2     
       TRA N1B-2     REPEAT TEST
       REM           
       CLA K0+2      L ALL ONES
       LXA K0+1,2    L +1
 N2B   PXA 0,2       CHECK CLEAR ALL BUT ADR
       SUB K0+1      L +1
       TZE N3B-4     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N3B-4     
       SWT 1         
       TRA N3B-1     
       TRA N2B-2     REPEAT TEST
       REM           
       LXA K0+5,2    L DEPENDS ON SIZE OF STG
 N3B   PXA 0,2       CHECK ALL POSITIONS
       SUB L1+4      L 07777, 17777, 37777, 77777
       TZE N3B+5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N3B+5     
       SWT 1         
       TRA M10B-2    NEXT SECTION
       TRA N3B-1     REPEAT TEST
       REM           
       REM TEST-XRB, PXA AND COMP.
       REM           
       CLA K0+2      L ALL ONES
       LXA L1+4,2    L 7777
 M10B  PXA 0,2       
       COM           
       LGL 2         TO ELIMINATE P AND Q BITS
       LGR 2         
       TOV *+1       TURN OFF OVERFLOW LIGHT
       STZ M+2       CLEAR TEMP STG.
       STA M+2       
       SUB Y         L 3777777770000
       TZE M11B      OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR M11B      HALT ON ERROR
 M11B  SWT 1         
       TRA M12B      NEXT SECTION
       TRA M10B-2    REPEAT
       REM           
       REM TEST-STA AFTER PXA COMP.
       REM           
 M12B  CLA M+2       RESULTS STA
       SUB Z         TEST STA
       TZE M12B+5    OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR M12B+5    HALT ON ERROR
       SWT 1         
       TRA N4B-2     NEXT SECTION
       TRA M10B-2    REPEAT
       REM           
       REM TEST STORE INDEX IN ADDRESS
       REM           
       LXA K0+1,2    L +1
       STZ T1        BLANK TEMP STG
 N4B   SXA T1,2      PUT 1 IN ADR OF STORAGE
       CLA T1        L 0
       SUB K0+1      L +1
       TNZ N4B+7     
       REM           
       PXA 0,2       CHECK IF INDEX HAS CHANGED
       SUB K0+1      L +1
       TZE N5B-9     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N5B-9     
       SWT 1         
       TRA N5B-6     
       TRA N4B-2     REPEAT TEST
       REM           
       CAL K0+5      L -3077777707777
       ALS 18        CLEAR ACC. ADDR. AND TAG
       SLW T1        
       CAL K0+2      TO BRING IN TAG OF 7
       STT T1        
       LXA K0+5,2    L DEPENDS ON SIZE OF STG
 N5B   SXA T1,2      CHECK ALL POSITIONS
       CLA T1        
       SUB K0+5      L DEPENDS ON SIZE OF STG
       TZE N6B-5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N6B-5     
       SWT 1         
       TRA N6B-2     PROCEED TO NEXT TEST
       TRA N5B-6     
       REM           
       REM TEST-PLACE 2S COMP OF ADR IN XR
       REM           
       CLA K0+6      L 345252742525
       LXA K0+6,2    L 42525
 N6B   PAC 0,2       
       SUB K0+6      CHECK ACC UNCHANGED
       TNZ N6B+6     NG
       REM           
       PXD 0,2       CHECK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE N7B-5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N7B-5     
       SWT 1         
       TRA N7B-2     
       TRA N6B-2     
       REM           
       REM TEST-PLACE 2S COMP OF DECR IN XR
       REM           
       CLA K0+6      L 345252742525
       LXD K0+6,2    L 45252
 N7B   PDC 0,2       
       SUB K0+6      CHECK ACC UNCHANGED
       TNZ N7B+6     NG
       REM           
       PXD 0,2       CHECK XR
       SUB K0+8      L DEPENDS ON SIZE OF STG
       TZE N10B-4    
       SWT 2         ERROR-TEST SWITCH 2
       HTR N10B-4    
       SWT 1         
       TRA N10B-1    PROCEED TO NEXT TEST
       TRA N7B-2     REPEAT TEST
       REM           
       REM TEST-LOAD ADR 2S COMP IN INDEX
       REM           
       LXA K0+5,2    L DEPENDS ON SIZE OF STG
 N10B  LAC K0+6,2    L 42525
       PXD 0,2       BRING BACK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE N11B-4    
       SWT 2         ERROR-TEST SWITCH 2
       HTR N11B-4    
       SWT 1         
       TRA N11B-1    PROCEED TO NEXT TEST
       TRA N10B-1    REPEAT TEST
       REM           
       REM TEST-LOAD DECR 2S COMP IN INDEX
       REM           
       LXA K0+5,2    L DEPENDS ON SIZE OF STG
 N11B  LDC K0+6,2    L 45252
       PXD 0,2       BRING BACK XR
       SUB K0+8      L DEPENDS ON SIZE OF STG
       TZE N12B-5    
       SWT 2         ERROR-TEST SWITCH 2
       HTR N12B-5    
       SWT 1         
       TRA N12B-2    PROCEED TO NEXT TEST
       TRA N11B-1    REPEAT TEST
       REM           
       REM TEST-LOAD OWN ADDRESS IN XR
       REM           
       CLA K0        L+0
       LXA K0+5,2    L DEPENDS ON SIZE OF STG
 N12B  AXT 15019,2   PUT 35253 IN XR
       PXD 0,2       BRING BACK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE N13B-5    
       SWT 2         ERROR-TEST SWITCH 2
       HTR N13B-5    
       SWT 1         
       TRA N13B-2    PROCEED TO NEXT TEST
       TRA N12B-2    REPEAT TEST
       REM           
       REM TEST-LOAD COMP OF OWN ADDRESS
       REM           
       CLA K0        L+0
       LXA K0+5,2    L DEPENDS ON SIZE OF STG
 N13B  AXC 17749,2   PUT 35253 IN XRA
       PXD 0,2       BRING BACK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE L5C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR L5C-3     
       SWT 1         
       TRA L5C       PROCEED TO NEXT TEST
       TRA N13B-2    REPEAT TEST
       REM           
       REM           
       REM           
       REM TEST XRC  
       REM           
       REM COMMENCE TEST
       REM           
       REM TEST THAT NO INDEX TAG LEAVES ADR 
       REM UNALTERED 
       REM           
 L5C   CLA L9C+1     L PXD 0,4
       SUB A1C+2     L PXD 0,4
       TZE L7C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR L7C-3     
       SWT 1         
       TRA L7C       PROCEED TO NEXT TEST
       TRA L5C       REPEAT TEST
       REM           
       REM TEST THAT XR IS RESET TO ZERO IF ADR
       REM ARE BEING MODIFIED
       REM           
 L7C   NOP           
 L8C   LXA L1,4      L 0
       CLA L7C       
       SUB L7C,4     
       TZE L9C-4     
       SWT 2         ERROR-TEST SWITCH 2
       HTR L9C-4     
       SWT 1         
       TRA L9C-1     PROCEED TO NEXT TEST
       TRA L8C       REPEAT TEST
       REM           
       REM TEST PLACE XR C IN DECR
       REM           
       LXA L1,4      L 0
 L9C   CLA L5C       
       PXD 0,4       
       TZE A1C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A1C-3     
       SWT 1         
       TRA A1C       NEXT SECTION
       TRA L9C-1     REPEAT TEST
       REM           
       REM TEST LXD AND PXD WITH XR B
       REM           
 A1C   CLA L5C       
       LXD L1,4      LOAD XRC
       REM           WITH 1
       PXD 0,4       
       SUB L1        L DECR OF 1
       TZE A1C+7     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A1C+7     
       SWT 1         
       TRA A10C-1    PROCEED TO NEXT TEST
       TRA A1C       REPEAT TEST
       REM           
       REM TEST-XRC, PXD AND COMP.
       REM           
       LXA K0+2,4    L 7777
 A10C  CLA K0+2      
       PXD 0,4       
       COM           
       LGL 2         TO ELIMINATE P AND Q BITS
       LGR 2         
       TOV *+1       TURN OFF OVERFLOW LIGHT
       STZ M+2       CLEAR TEMP. STORAGE
       STD M+2       
       SUB W         L 370000777777
       TZE A11C-3    OK-TEST SWITCH 1
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR A11C-3    HALT ON ERROR
       SWT 1         
       TRA A11C      NEXT SECTION
       TRA A10C-1    REPEAT
       REM           
       REM TEST-STD AFTER PXD COMP.
       REM           
 A11C  CLA M+2       RESULTS STD
       SUB X         TEST STD
       TZE A11C+5    OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR A11C+5    HALT ON ERROR
       SWT 1         
       TRA A2C       NEXT SECTION
       TRA A10C-1    REPEAT SECTION
       REM           
       REM TEST LXD AND PXD WITH XR C
       REM           
 A2C   CLA L5C       
       LXD L1+1,4    LOAD XRC
       REM           WITH 2
       PXD 0,4       
       SUB L1+1      L DECR OF 2
       TZE A3C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A3C-3     
       SWT 1         
       TRA A3C       PROCEED TO NEXT TEST
       TRA A2C       REPEAT TEST
       REM           
       REM TEST ADR MODIFICATION USING XR C
       REM           
 A3C   LXD L1,4      L 1
 A4C   CLA A4C,4     
       SUB A3C       
       TZE A5C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A5C-3     
       SWT 1         
       TRA A5C       
       TRA A3C       REPEAT TEST
       REM           
 A5C   PXD 0,4       TEST CONTENT
       REM           OF XRB
       SUB L1        L 1 IN DECR
       TZE A6C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A6C-3     
       SWT 1         
       TRA A6C       PROCEED TO NEXT TEST
       TRA A3C       REPEAT TEST
       REM           
       REM TEST TXI WITH XR C
       REM           
 A6C   LXD L1,4      L 1
       TXI A9C,4,1   
       TRA A8C-2     
       SWT 2         ERROR-TEST SWITCH 2
       HTR A8C       
 A8C   SWT 1         
       TRA A9C       
       TRA A6C       REPEAT TEST
       REM           
 A9C   PXD 0,4       
       SUB L1+1      L 2 IN DECR
       TZE B1C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR B1C-3     
       SWT 1         
       TRA B1C       PROCEED TO NEXT TEST
       TRA A9C       REPEAT TEST
       REM           
       REM TEST SXD WITH XR C
       REM           
 B1C   LXD B2C,4     L DECR 2
       SXD B3C,4     
       CLA B3C       
       SUB B2C       
       TZE B4C       
       CLA B5C       TEST IF SXD
       REM           IS BEING
       REM           INDEXED
       SUB B2C       
       TNZ B6C       
 B6C   SWT 2         ERROR-TEST SWITCH 2
       HTR B4C       CHECK ACC FOR TYPE OF ERROR
 B4C   CLA S10C      RESET TEMP. STG.
       STO B5C       
       STO B3C       
       SWT 1         
       TRA B7C       PROCEED TO NEXT TEST
       TRA B1C       REPEAT TEST
       REM           
 B5C   TXI 2,4,12    CONSTANTS
 B3C   TXI 2,4,12    
 B2C   TXI 2,4,2     
       REM           
       REM TEST PDX WITH XR C
       REM           
 B7C   LXD L1,4      L1
       CLM           
       PDX 0,4       
       PXD 0,4       
       TZE B8C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR B8C-3     
       SWT 1         
       TRA B8C       PROCEED TO NEXT TEST
       TRA B7C       REPEAT TEST
       REM           
       REM TEST LXA WITH XRC
       REM           
 B8C   CLM           
       PDX 0,4       RESET XRC
       LXA L1+2,4    L2
       PXD 0,4       
       SUB L1+1      L2 IN DECR
       TZE B9C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR B9C-3     
       SWT 1         
       TRA B9C       PROCEED TO NEXT TEST
       TRA B8C       REPEET TEST
       REM           
       REM TEST PAX WITH XR C
       REM           
 B9C   CLA L1+2      L 2 IN ADDR
       LXD L1,4      L 1
       PAX 0,4       
       PXD 0,4       
       SUB L1+1      L 2 IN DECR
       TZE C1C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR C1C-3     
       SWT 1         
       TRA C1C       PROCEED TO NEXT TEST
       TRA B9C       REPEAT TEST
       REM           
       REM TEST TXH WHEN XRC IS LOW
       REM           
 C1C   LXD L1,4      L 1
       TXH C2C-2,4,2 
       TRA C3C       
       SWT 2         ERROR-TEST SWITCH 2
       HTR C2C       
 C2C   SWT 1         
       TRA C3C       
       TRA C1C       REPEAT TEST
       REM           
 C3C   PXD 0,4       TEST XRC
       SUB L1        
       TZE C4C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR C4C-3     
       SWT 1         
       TRA C4C       PROCEED TO NEXT TEST
       TRA C3C       REPEAT TEST
       REM           
       REM TEST TXH WHEN XR + DECR EQUAL
       REM           
 C4C   LXD L1,4      L 1
       TXH C5C-2,4,1 
       TRA C6C       
       SWT 2         ERROR-TEST SWITCH 2
       HTR C5C       
 C5C   SWT 1         
       TRA C6C       
       TRA C4C       REPEAT TEST
       REM           
 C6C   PXD 0,4       TEST XR
       SUB L1        L 1 IN DECR
       TZE C7C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR C7C-3     
       SWT 1         
       TRA C7C       PROCEED TO NEXT TEST
       TRA C6C       REPEAT TEST
       REM           
       REM TEST TXH WHEN XR IS HIGH
       REM           
 C7C   LXD L1,4      L 1
       TXH C8C,4     
       SWT 2         ERROR-TEST SWITCH 2
       HTR C9C       
 C9C   SWT 1         
       TRA C8C       
       TRA C7C       REPEAT TEST
       REM           
 C8C   PXD 0,4       TEST XR
       SUB L1        L 1 IN DECR
       TZE D1C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR D1C-3     
       SWT 1         
       TRA D1C       PROCEED TO NEXT TEST
       TRA C8C       REPEAT TEST
       REM           
       REM TEST TXL WHEN XR IS HIGH
       REM           
 D1C   LXD L1,4      L 1
       TXL D2C-2,4   
       TRA D3C       
       SWT 2         ERROR-TEST SWITCH 2
       HTR D2C     
 D2C   SWT 1         
       TRA D3C       
       TRA D1C       REPEAT TEST
       REM           
 D3C   PXD 0,4       TEST XR
       SUB L1        L 1 IN DECR
       TZE D4C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR D4C-3     
       SWT 1         
       TRA D4C       PROCEED TO NEXT TEST
       TRA D3C       REPEAT TEST
       REM           
       REM TEST TXL WHEN XR EQUALS DECR
       REM           
 D4C   LXD L1,4      L 1
       TXL D5C,4,1   
       SWT 2         ERROR-TEST SWITCH 2
       HTR D6C       
 D6C   SWT 1         
       TRA D5C       
       TRA D4C       REPEAT TEST
       REM           MODIFIED
 D5C   PXD 0,4       TEST XRC
       SUB L1        L 1 IN DECR
       TZE D7C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR D7C-3     
       SWT 1         
       TRA D7C       PROCEED TO NEXT TEST
       TRA D5C       REPEAT TEST
       REM           
       REM TEST TXL WHEN XR IS LOW
       REM           
 D7C   LXD L1,4      L 1
       TXL D8C,4,2   
       SWT 2         ERROR-TEST SWITCH 2
       HTR D9C       
 D9C   SWT 1         
       TRA D8C       
       TRA D7C       REPEAT TEST
       REM           
 D8C   PXD 0,4       TEST XR B
       SUB L1        L 1 IN DECR
       TZE E1C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR E1C-3     
       SWT 1         
       TRA E1C       PROCEED TO NEXT TEST
       TRA D8C       REPEAT TEST
       REM           
       REM TEST TIX XR GREATER THEN DECR
       REM           
 E1C   LXD L1+1,4    L 2
       TIX E2C,4,1    
       SWT 2         ERROR-TEST SWITCH 2
       HTR E4C       
 E4C   SWT 1         
       TRA E2C       
       TRA E1C       REPEAT TEST
       REM           
 E2C   PXD 0,4       TEST XRC
       SUB L1        L 1 IN DECR
       TZE E5C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR E5C-3     
       SWT 1         
       TRA E5C       PROCEED TO NEXT TEST
       TRA E2C       REPEAT TEST
       REM           
       REM TEST TIX XR EQUALS DECR
       REM           
 E5C   LXD L1+1,4    L2
       TIX E6C-2,4,2 
       TRA E7C       
       SWT 2         ERROR-TEST SWITCH 2
       HTR E6C       
 E6C   SWT 1         
       TRA E7C       
       TRA E5C       REPEAT TEST
       REM           
 E7C   PXD 0,4       TEST XRC
       SUB L1+1      L 2 IN DECR
       TZE E8C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR E8C-3     
       SWT 1         
       TRA E8C       PROCEED TO NEXT TEST
       TRA E7C       REPEAT TEST
       REM           
       REM TEST TIX XR LESS THEN DECR
       REM           
 E8C   LXD L1,4      L 1
       TIX E9C-2,4,2 
       TRA F1C       
       SWT 2         ERROR-TEST SWITCH 2
       HTR E9C       
 E9C   SWT 1         
       TRA F1C       
       TRA E8C       REPEAT TEST
       REM           
 F1C   PXD 0,4       TEST XRC
       SUB L1        L 1 IN DECR
       TZE F2C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR F2C-3     
       SWT 1         
       TRA F2C       PROCEED TO NEXT TEST
       TRA F1C       REPEAT TEST
       REM           
       REM TEST TNX XR LESS THAN DECR
       REM           
 F2C   LXD L1,4      L 1
       TNX F3C,4,2   
       SWT 2         ERROR-TEST SWITCH 2
       HTR F2C+4     
       SWT 1         
       TRA F3C       
       TRA F2C       REPEAT TEST
       REM           
 F3C   PXD 0,4       
       SUB L1        L 1 IN DECR
       TZE F4C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR F4C-3     
       SWT 1         
       TRA F4C       PROCEED TO NEXT TEST
       TRA F3C       REPEAT TEST
       REM           
       REM TEST TNX XR EQUALS DECR
       REM           
 F4C   LXD L1,4      L 1
       TNX F5C,4,1   
       SWT 2         ERROR-TEST SWITCH 2
       HTR F6C       
 F6C   SWT 1         
       TRA F5C       
       TRA F4C       REPEAT TEST
       REM           
 F5C   PXD 0,4       TEST XRC
       SUB L1         L 1 IN DECR
       TZE F7C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR F7C-3     
       SWT 1         
       TRA F7C       PROCEED TO NEXT TEST
       TRA F5C       REPEAT TEST
       REM           
       REM TEST TNX XR GREATER THAN DECR
       REM           
 F7C   LXD L1+1,4    L 2
       TNX F8C-2,4,1 
       TRA F9C       
       SWT 2         ERROR-TEST SWITCH 2
       HTR F8C       
 F8C   SWT 1         
       TRA F9C       
       TRA F7C       REPEAT TEST
       REM           
 F9C   PXD 0,4       TEST XRC
       SUB L1        L 1 IN DECR
       TZE G1C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR G1C-3     
       SWT 1         
       TRA G1C       PROCEED TO NEXT TEST
       TRA F9C       REPEAT TEST
       REM           
       REM TEST TSX  
       REM           
 G1C   LXA G1C,4     L OWN ADDRESS
       TSX G2C,4     
       SWT 2         ERROR-TEST SWITCH 2
       HTR G3C       
 G3C   SWT 1         
       TRA G2C       
       TRA G1C       REPEAT TEST
       REM           
 G2C   PXD 0,4       L COMP TSX
       REM           LOCATION IN
       REM           DECR
       SUB S1C       L 007017000000
       TZE G4C-3     
       SWT 2         ERROR-TEST SWITCH 2
       HTR G4C-3     
       SWT 1         
       TRA G4C       PROCEED TO NEXT TEST
       TRA G1C       REPEAT TEST
       REM           
       REM TEST TIX FOR COUNTING
       REM           
 G4C   LXA L1+4,4    L 7777
       CLA L1+4      L07777
       SWT 4         
       TRA G5C       
       SWT 3         
       TRA G6C       
       TRA G7C       
       REM           
 G5C   SUB L1+5      L 00001
       TIX G5C,4,1   
       TRA G8C       
 G6C   SUB L1+13     L 00100
       TIX G6C,4,64  
       ADD L1+13     L00100
       TRA G5C       
 G7C   SUB L1+12     L 1000
       TIX G7C,4,512 
       ADD L1+12     L 1000
       TRA G6C       
 G8C   TZE G9C-3     TO NEXT TEST
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR G9C-3     
       SWT 1         
       TRA G9C       PROCEED TO NEXT TEST
       TRA G4C       REPEAT TEST
       REM           
       REM TEST TNX FOR COUNTING
       REM           
 G9C   LXA L1+4,4    L 7777
       CLA L1+6      L 07776
       SWT 4         
       TRA H1C       
       SWT 3         
       TRA H2C       
       TRA H3C       
       REM           
 H1C   TNX H5C,4,1   
       SUB L1+5      L00001
       TRA H1C       
 H2C   TNX H1C,4,64  
       SUB L1+13     L00100
       TRA H2C       
 H3C   TNX H2C,4,512 
       SUB L1+12     L 1000
 H4C   TRA H3C       
 H5C   TZE H6C-3     TO NEXT TEST
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR H6C-3     
       SWT 1         
       TRA H6C       PROCEED TO NEXT TEST
       TRA G9C       REPEAT TEST
       REM           
       REM TEST TXI FOR COUNTING
       REM           
 H6C   LXA L1+9,4    L 00000
       CLA L1+7      L DEPENDS ON SIZE OF STG.
       SWT 4         
       TRA H7C       
       SWT 3         
       TRA H8C       
       TRA H9C      
       REM           
 J2C   TZE J1C       
 H7C   SUB L1+5      L 1
       TXI J2C,4,1   
 J3C   TXH J2C,4,3968 
 H8C   SUB L1+13     L 100
       TXI J3C,4,64   
 H9C   TXH H8C,4,3072 
       SUB L1+12     L 1000
       TXI H9C,4,512 
 J1C   PXD 0,4       
       TZE J4C-3     TO NEXT TEST
       REM           
       SWT 2         ERROR-TEST SWITCH 2
       HTR J4C-3     
       SWT 1         
       TRA J4C       PROCEED TO NEXT TEST
       TRA H6C       REPEAT TEST
       REM           
       REM TEST ADR MODIFICATION FOR ALL
       REM POSITIONS IN MEMORY
       REM           
 J4C   CLM           
       STA J5C       
       LXA L1+4,4    L 7777
 J7C   CLA 4095,4    
 J5C   SUB 0         
       TNZ J6C-2     
       CLA J5C       
       ADD L1+5      L1
       STA J5C       MODIFY ADDR.
       TIX J7C,4,1   
       TRA J6C       
       SWT 2         ERROR-TEST SWITCH 2
       HTR J6C       
 J6C   SWT 1         
       TRA M1C-2     
       TRA J4C       
       REM           
       REM           
       SWT 5         
       TRA N1C-2     GO TO NEXT TEST
 M1C   LDQ M         CLEAR MQ
       REM           SSW 5 DOWN TEST HPR
       REM           AND TSX INST
       HPR           KEY IN TSX INST. INTO 
       REM           MQ WITH ADDR OF
       REM           M4 TAG A
       TRA M2C       O K
       SWT 2         ERROR-TEST SWITCH 2
       HTR M2C-3     
       SWT 1         
       TRA M2C       
       TRA M1C       RE-LOOP
       REM           
 M2C   STQ S7C       CHECK TSX INST
       CLA S7C       
       SUB S3C       
       TZE M3C-3     TRANSFER ON ZERO O K
       SWT 2         ERROR-TEST SWITCH 2
       HTR M3C-3     
       REM           
       SWT 1         
       TRA M3C       
       TRA M1C       ERROR ON TSX TEST
       REM           
 M3C   HPR           EXECUTE TSX INST
       REM           TO M4B TAG C
       REM           
       REM           
       TRA M4C+3     DID NOT EXECUTE TSX
       TRA M4C+3     ERROR
       REM           
 M4C   PXD 0,4       
       SUB S4C       
       TZE N1C-5     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR M4C+5     
       SWT 1         
       TRA N1C-2     PROCEED TO NEXT TEST
       TRA M3C       REPEAT TEST
       REM           
       REM TEST-PLACE INDEX IN ADDRESS
       REM           
       CLA K0+2      L-377777777777
       LXA K0,4      L +0
 N1C   PXA 0,4       CHECK CLEARING ACC
       TZE N2C-5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N2C-5     
       SWT 1         
       TRA N2C-2     
       TRA N1C-2     REPEAT TEST
       REM           
       CLA K0+2      L ALL ONES
       LXA K0+1,4    L +1
 N2C   PXA 0,4       CHECK CLEAR ALL BUT ADR
       SUB K0+1      L +1
       TZE N3C-4     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N3C-4     
       SWT 1         
       TRA N3C-1     
       TRA N2C-2     REPEAT TEST
       REM           
       LXA K0+5,4    L DEPENDS ON SIZE OF STG
 N3C   PXA 0,4       CHECK ALL POSITIONS
       SUB L1+4      L 07777, 17777, 37777, 77777
       TZE N3C+5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N3C+5     
       SWT 1         
       TRA N14C-2    NEXT SECTION
       TRA N3C-1     REPEAT TEST
       REM           
       REM TEST-XRC, PXA AND COMP.
       REM           
       CLA K0+2      L ALL ONES
       LXA L1+4,4    L 7777
 N14C  PXA 0,4       
       COM           
       LGL 2         TO ELIMINATE P AND Q BITS
       LGR 2         
       TOV *+1       TURN OFF OVERFLOW LIGHT
       STZ M+2       CLEAR TEMP STG.
       STA M+2       
       SUB Y         L 3777777770000
       TZE N15C      OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR N15C      HALT ON ERROR
 N15C  SWT 1         
       TRA N15C+3    NEXT SECTION
       TRA N14C-2    REPEAT
       REM           
       REM TEST-STA AFTER PXA COMP.
       REM           
       CLA M+2       RESULTS STA
       SUB Z         TEST STA
       TZE N15C+8    OK-TEST SWITCH 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR N15C+8    HALT ON ERROR
       SWT 1         
       TRA N4C-2     NEXT SECTION
       TRA N14C-2    REPEAT
       REM           
       REM TEST STORE INDEX IN ADDRESS
       REM           
       LXA K0+1,4    L +1
       STZ T1        BLANK TEMP STG
 N4C   SXA T1,4      PUT 1 IN ADR OF STORAGE
       CLA T1        L 0
       SUB K0+1      L +1
       REM           
       TNZ N4C+7     
       PXA 0,4       CHECK IF INDEX HAS CHANGED
       SUB K0+1      L +1
       TZE N5C-9     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N5C-9     
       SWT 1         
       TRA N5C-6     
       TRA N4C-2     REPEAT TEST
       REM           
       CAL K0+5      L -3077777707777
       ALS 18        CLEAR ACC. ADDR. AND TAG
       SLW T1        
       CAL K0+2      TO BRING IN TAG OF 7
       STT T1        
       LXA K0+5,4    L DEPENDS ON SIZE OF STG
 N5C   SXA T1,4      CHECK ALL POSITIONS
       CLA T1        
       SUB K0+5      L DEPENDS ON SIZE OF STG
       TZE N6C-5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N6C-5     
       SWT 1         
       TRA N6C-2     PROCEED TO NEXT TEST
       TRA N5C-6     
       REM           
       REM TEST-PLACE 2S COMP OF ADR IN XR
       REM           
       CLA K0+6      L 345252742525
       LXA K0+6,4    L 42525
 N6C   PAC 0,4       
       SUB K0+6      CHECK ACC UNCHANGED
       TNZ N6C+6     NG
       PXD 0,4       CHECK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE N7C-5     
       SWT 2         ERROR-TEST SWITCH 2
       HTR N7C-5     
       SWT 1         
       TRA N7C-2     
       TRA N6C-2     
       REM           
       REM TEST-PLACE 2S COMP OF DECR IN XR
       REM           
       CLA K0+6      L 345252742525
       LXD K0+6,4    L 45252
 N7C   PDC 0,4       
       SUB K0+6      CHECK ACC UNCHANGED
       TNZ N7C+6     NG
       PXD 0,4       CHECK XR
       SUB K0+8      L DEPENDS ON SIZE OF STG
       TZE N10C-4    
       SWT 2         ERROR-TEST SWITCH 2
       HTR N10C-4    
       SWT 1         
       TRA N10C-1    PROCEED TO NEXT TEST
       TRA N7C-2     REPEAT TEST
       REM           
       REM TEST-LOAD ADR 2S COMP IN INDEX
       REM           
       LXA K0+5,4    L DEPENDS ON SIZE OF STG
 N10C  LAC K0+6,4    L 42525
       PXD 0,4       BRING BACK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE N11C-4    
       SWT 2         ERROR-TEST SWITCH 2
       HTR N11C-4    
       SWT 1         
       TRA N11C-1    PROCEED TO NEXT TEST
       TRA N10C-1    REPEAT TEST
       REM           
       REM TEST-LOAD DECR 2S COMP IN INDEX
       REM           
       LXA K0+5,4    L DEPENDS ON SIZE OF STG
 N11C  LDC K0+6,4    L 45252
       PXD 0,4       BRING BACK XR
       SUB K0+8      L DEPENDS ON SIZE OF STG
       TZE N12C-5    
       SWT 2         ERROR-TEST SWITCH 2
       HTR N12C-5    
       SWT 1         
       TRA N12C-2    PROCEED TO NEXT TEST
       TRA N11C-1    REPEAT TEST
       REM           
       REM TEST-LOAD OWN ADDRESS IN XR
       REM           
       CLA K0        L+0
       LXA K0+5,4    L DEPENDS ON SIZE OF STG
 N12C  AXT 15019,4   PUT 35253 IN XR
       PXD 0,4       BRING BACK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE N13C-5    
       SWT 2         ERROR-TEST SWITCH 2
       HTR N13C-5    
       SWT 1         
       TRA N13C-2    PROCEED TO NEXT TEST
       TRA N12C-2    REPEAT TEST
       REM           
       REM TEST-LOAD COMP OF OWN ADDRESS
       REM           
       CLA K0        L+0
       LXA K0+5,4    L DEPENDS ON SIZE OF STG
 N13C  AXC 17749,4   PUT 35253 IN XRA
       PXD 0,4       BRING BACK XR
       SUB K0+7      L DEPENDS ON SIZE OF STG
       TZE C1AD-3    
       SWT 2         ERROR-TEST SWITCH 2
       HTR C1AD-3    
       SWT 1         
       TRA C1AD      PROCEED TO NEXT TEST
       TRA N13C-2    REPEAT TEST
       REM           
       REM           
       REM           
       REM           
       REM           
 C1AD  LXA K1111,1   L +1111
       LXA K2222,2   L +2222
       LXA K4444,4   L +4444
       REM           
 C2D   LDQ K06D+585,1 L DEPENDS ON SIZE OF STG.
       CLA K06D+585,1 L DEPENDS ON SIZE OF STG.
       CAS K06D      L +1111111111
       TRA C2D+5     ERROR
       TRA C2D+7     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C2D+7     ERROR ON COMPARISON
       SWT 1         
       TRA C3D       CONTINUE TEST
       TRA C2D       REPEAT TEST
       REM           
       REM           
 C3D   STQ J1D       TEMPORARY STORAGE
       CLA J1D       
       CAS K06D      L +11111111111
       TRA C3D+5     ERROR
       TRA C3D+7     OK
       SWT 2         ERROR-TEST SWITCH 2 
       HTR C3D+7     ERROR ON COMPARISON
       SWT 1         
       TRA CA2D      PROCEED TO NEXT TEST
       TRA C2D       REPEAT TEST
       REM           
       REM           
       REM TESTING TAG 2
       REM           
 CA2D  LDQ K05D+1170,2 L DEPENDS ON SIZE OF STG.
       CLA K05D+1170,2 L DEPENDS ON SIZE OF STG.
       CAS K05D      L +222222222222
       TRA CA2D+5    ERROR
       TRA CA2D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CA2D+7    ERROR ON COMPARISON
       SWT 1         
       TRA CA3D      CONTINUE TEST
       TRA CA2D      REPEAT TEST
       REM           
       REM           
 CA3D  STQ J1D       TEMPORARY STORAGE
       CLA J1D       
       CAS K05D      L +22222222222
       TRA CA3D+5    ERROR
       TRA CA3D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CA3D+7    ERROR ON COMPARISION
       TRA CB2D      PROCEED TO NEXT TEST
       TRA CA2D      REPEAT TEST
       REM           
       REM           
       REM TESTING TAG 3
       REM           
       REM           
 CB2D  LDQ K04D+1755,3 L DEPENDS ON SIZE OF STG.
       CLA K04D+1755,3 L DEPENDS ON SIZE OF STG.
       CAS K04D      L +33333333333
       TRA CB2D+5    ERROR
       TRA CB2D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CB2D+7    ERROR ON COMPARISON
       SWT 1         
       TRA CB3D      CONTINUE TEST
       TRA CB2D      REPEAT TEST
       REM           
       REM           
 CB3D  STQ J1D       TEMPORARY STORAGE
       CLA J1D       
       CAS K04D      L +3333333333333
       TRA CB3D+5    ERROR
       TRA CB3D+7    OK
       SWT 2         ERROR-TEST SWITCH 2 
       HTR CB3D+7    ERROR ON COMPARISON
       SWT 1         
       TRA CC2D      PROCEED TO NEXT TEST
       TRA CB2D      REPEAT TEST
       REM           
       REM           
       REM TESTING TAG 4
       REM           
 CC2D  LDQ K03D+2340,4 L DEPENDS ON SIZE OF STG.
       CLA K03D+2340,4 L DEPENDS ON SIZE OF STG.
       CAS K03D      L +44444444444
       TRA CC2D+5    ERROR
       TRA CC2D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CC2D+7    ERROR ON COMPARISON
       SWT 1         
       TRA CC3D      CONTINUE TEST
       TRA CC2D      REPEAT TEST
       REM           
       REM           
 CC3D  STQ J1D       TEMPORARY STORAGE
       CLA J1D       
       CAS K03D      L +4444444444444
       TRA CC3D+5    ERROR
       TRA CC3D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CC3D+7    ERROR ON COMPARISON
       SWT 1 
       TRA CD2D      PROCEED TO NEXT TEST
       TRA CC2D      REPEAT TEST
       REM           
       REM           
       REM TESTING TAG 5
       REM           
 CD2D  LDQ K02D+2925,5 L DEPENDS ON SIZE OF STG.
       CLA K02D+2925,5 L DEPENDS ON SIZE OF STG.
       CAS K02D      L +55555555555
       TRA CD2D+5    ERROR
       TRA CD2D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CD2D+7    ERROR ON COMPARISON
       SWT 1         
       TRA CD3D      CONTINUE TEST
       TRA CD2D      REPEAT TEST
       REM           
       REM           
 CD3D  STQ J1D       TEMPORARY STORAGE
       CLA J1D       
       CAS K02D      L +555555555555
       TRA CD3D+5    ERROR
       TRA CD3D+7    OK
       SWT 2         ERROR-TEST SWITCH 2 
       HTR CD3D+7    ERROR ON COMPARISON
       SWT 1         
       TRA CE2D      PROCEED TO NEXT TEST
       TRA CD2D      REPEAT TEST
       REM           
       REM           
       REM TESTING TAG 6
       REM           
 CE2D  LDQ K01D+3510,6 L DEPENDS ON SIZE OF STG.
       CLA K01D+3510,6 L DEPENDS ON SIZE OF STG.
       CAS K01D      L +6666666666666
       TRA CE2D+5    ERROR
       TRA CE2D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CE2D+7    ERROR ON COMPARISON
       SWT 1         
       TRA CE3D      CONTINUE TEST
       TRA CE2D      REPEAT TEST
       REM           
       REM           
 CE3D  STQ J1D       TEMPORARY STORAGE
       CLA J1D       
       CAS K01D      L +6666666666666
       TRA CE3D+5    ERROR
       TRA CE3D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CE3D+7    ERROR ON COMPARISON
       SWT 1
       TRA CF2D      PROCEED TO NEXT TEST
       TRA CE2D      REPEAT TEST
       REM           
       REM           
       REM TESTING TAG 7
       REM           
 CF2D  LDQ K00D+4095,7 L DEPENDS ON SIZE OF STG.
       CLA K00D+4095,7 L DEPENDS ON SIZE OF STG.
       CAS K00D      L +7777777777777
       TRA CF2D+5    ERROR
       TRA CF2D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CF2D+7    ERROR ON COMPARISON
       SWT 1         
       TRA CF3D      CONTINUE TEST
       TRA CF2D      REPEAT TEST
       REM           
       REM           
 CF3D  STQ J1D       TEMPORARY STORAGE
       CLA J1D       
       CAS K00D      L +7777777777777
       TRA CF3D+5    ERROR
       TRA CF3D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR CF3D+7    ERROR ON COMPARISON
       SWT 1
       TRA C8D       PROCEED TO NEXT TEST
       TRA CF2D      REPEAT TEST
       REM           
       REM           
       REM           
       REM TEST-XR READ IN WITH MULTIPLE TAG
       REM           
 C8D   LXA K0+5,7    L 7777
       CLA K17D      L ZEROS
       PXD 0,1       L 7777
       LDQ K8D       L DECR OF 7777
       CAS K8D       DECR OF 7777 TEST TAG 1
       TRA C8D+7     ERROR
       TRA C8D+9     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C8D+9     ERROR
       SWT 1         
       TRA C9D       PROCEED TO NEXT TEST
       TRA C8D       REPEAT TEST
       REM           
       REM           
 C9D   CLA K17D      L ZEROS
       PXD 0,2       L 7777
       LDQ K8D       L DEPENDS ON SIZE OF STO.
       CAS K8D       DECR OF 7777 TEST TAG B
       TRA C9D+6     ERROR
       TRA C9D+8     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C9D+8     ERROR
       SWT 1         
       TRA C10D      PROCEED TO NEXT TEST
       TRA C9D       REPEAT TEST
       REM           
       REM           
 C10D  CLA K17D      L ZEROS
       PXD 0,4       L 7777
       LDQ K8D       L DEPENDS ON SIZE OF STO.
       CAS K8D       DECR OF 7777 TEST TAG B
       TRA C10D+6    ERROR
       TRA C10D+8    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C10D+8    ERROR
       SWT 1         
       TRA C11D      PROCEED TO NEXT TEST
       TRA C10D      REPEAT TEST
       REM           
       REM           
       REM TEST TAG 0 
       REM           
 C11D  LXD K0+5,7    L DEPENDS ON SIZE OF STG.
       TXH C12D,1,3583 TEST TXH FOR TRA
       SWT 2         ERROR-TEST SWITCH 2
       HTR C11D+4    ERROR TXH FAILED TO TRA
       SWT 1         
       TRA C12D      PROCEED TO NEXT TEST
       TRA C11D      REPEAT TEST
       REM           
 C12D  TXH C12D+2,0,3583 TEST TXH WITH TAG 0
       TRA C13D      OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C12D+4    TXH TRANSFERED IN ERROR
       SWT 1         
       TRA C13D      CONTINUE TEST
       TRA C12D      REPEAT TEST
       REM           
 C13D  PXD 0,1       L 7777
       LDQ K8D       CORRECNT NUMBER
       CAS K8D       CHECK XRA 7777
       TRA C13D+5    ERROR
       TRA C13D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C13D+7    ERROR
       SWT 1         
       TRA C14D      PROCEED TO NEXT TEST
       TRA C12D      REPEAT TEST
       REM           
       REM           
 C14D  PXD 0,2       CHECK XRB 7777
       LDQ K8D       CORRECNT NUMBER
       CAS K8D       
       TRA C14D+5    
       TRA C14D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C14D+7    ERROR
       SWT 1         
       TRA C15D      PROCEED TO NEXT TEST
       TRA C14D      REPEAT TEST
       REM           
       REM           
 C15D  PXD 0,4       L 7777
       LDQ K8D       CORRECNT NUMBER
       CAS K8D       CHECK XRC 7777
       TRA C15D+5    
       TRA C15D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C15D+7    ERROR
       SWT 1         
       TRA C16D      PROCEED TO NEXT TEST
       TRA C15D      REPEAT TEST
       REM           
       REM TEST TIX  
       REM           
 C16D  TIX C17D,1,2047 WITH TAG 1
       SWT 2         ERROR-TEST SWITCH 2
       HTR C16D+3    TIX FAILED TO TRA
       SWT 1         
       TRA C17D      PROCEED TO NEXT TEST
       TRA C16D      REPEAT TEST
       REM           
       REM           
 C17D  TIX C17D+2,0,1 WITH TAG 0
       TRA C18D      OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C17D+4    TIX TRANSFERED IN ERROR
       SWT 1         
       TRA C18D      PROCEED TO NEXT TEST
       TRA C17D      REPEAT TEST
       REM           
       REM           
 C18D  PXD 0,1       L 4000
       LDQ K7D       CORRECT NUMBER
       CAS K7D       CHECK XRA 4000
       TRA C18D+5    
       TRA C18D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C18D+7    
       SWT 1         
       TRA C21D      PROCEED TO NEXT TEST
       TRA C17D      REPEAT TEST
       REM           
 C21D  PXD 0,2       L 4000
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRB 4000
       TRA C21D+5    ERROR
       TRA C21D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR C21D+7    ERROR
       SWT 1         
       TRA C22D      PROCEED TO NEXT TEST
       TRA C21D      REPEAT TEST
       REM           
 C22D  PXD 0,4       L 4000
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRC 4000
       TRA C22D+5    ERROR
       TRA C22D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       TRA C22D      PROCEED TO NEXT TEST
       TRA C23D      REPEAT TEST
       SWT 1         
       HTR C22D+7    ERROR
       REM           
       REM           
       REM           
       REM TEST TXL  
       REM           
 C23D  TXL C24D,1,2047 SHOULD NOT TRANSFER
       TRA C25D      OK
 C24D  SWT 2         ERROR-TEST SWITCH 2
       HTR C24D+2    TXL TRANSFERED IN ERROR
       SWT 1         
       TRA C25D      PROCEED TO NEXT TEST
       TRA C23D      REPEAT TEST
       REM           
 C25D  TXL DD,0,4095 TEST TXL TAG 0
       SWT 2         ERROR-TEST SWITCH 2
       HTR C25D+3    TXL TRANSFERED IN ERROR
       SWT 1         
       TRA DD        PROCEED TO NEXT TEST
       TRA C25D      REPEAT TEST
       REM           
       REM           
 DD    PXD 0,1       L 4000
       LDQ K7D       CORRECT NUMBER
       CAS K7D       CHECK XRA 4000
       TRA DD+5      ERROR
       TRA DD+7      OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR DD+7      ERROR
       SWT 1         
       TRA D1D       PROCEED TO NEXT TEST
       TRA DD        REPEAT TEST
       REM           
       REM           
 D1D   PXD 0,2       L 4000
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRB 4000
       TRA D1D+5     ERROR
       TRA D1D+7     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D1D+7     ERROR
       SWT 1         
       TRA D2D       PROCEED TO NEXT TEST
       TRA D1D       REPEAT TEST
       REM           
       REM           
 D2D   PXD 0,4       L 4000
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRC 4000
       TRA D2D+5     ERROR
       TRA D2D+7     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D2D+7     ERROR
       SWT 1         
       TRA D3D       PROCEED TO NEXT TEST
       TRA D2D       REPEAT TEST
       REM           
       REM           
       REM TEST TNX  
       REM           
 D3D   TNX D4D,1,1   SHOULD NOT TRANSFER
       TRA D5D       OK
 D4D   SWT 2         ERROR-TEST SWITCH 2
       HTR D4D+2     TNX TRANSFERED IN ERROR
       SWT 1         
       TRA D5D           PROCEED TO NEXT TEST
       TRA D3D       REPEAT TEST
       REM           
       REM           
 D5D   TNX D6D,0,0   TEST TNX TAG 0
       SWT 2         ERROR-TEST SWITCH 2
       HTR D5D+3     TNX TRANSFERED IN ERROR
       SWT 1         
       TRA D6D       PROCEED TO NEXT TEST
       TRA D5D       REPEAT TEST
       REM           
 D6D   PXD 0,1       L 3777
       LDQ K10D      CORRECT NUMBER
       CAS K10D      CHECK XRA 3777
       TRA D6D+5     ERROR
       TRA D6D+7     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D6D+7     ERROR
       SWT 1         
       TRA D7D       PROCEED TO NEXT TEST
       TRA D6D       REPEAT TEST
       REM           
 D7D   PXD 0,2       L 3777
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRB 3777
       TRA D7D+5     ERROR
       TRA D7D+7     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D7D+7     ERROR
       SWT 1         
       TRA D8D       PROCEED TO NEXT TEST
       TRA D7D       REPEAT TEST
       REM           
       REM           
 D8D   PXD 0,4       L 3777
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRC 3777
       TRA D8D+5     ERROR
       TRA D8D+7     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D8D+7     ERROR
       SWT 1         
       TRA D9D       PROCEED TO NEXT TEST
       TRA D8D       REPEAT TEST
       REM           
       REM           
       REM TEST TXI  
       REM           
 D9D   TXI D10D,1,2047 SHOULD TRANSFER
       SWT 2         ERROR-TEST SWITCH 2
       HTR D9D+3     TIX FAILED TO TRANSFER
       SWT 1         
       TRA D10D      PROCEED TO NEXT TEST
       TRA D9D       REPEAT TEST
       REM           
       REM           
 D10D  TXI D11D,0,4095 TEST TXI TAG 0
       SWT 2         ERROR-TEST SWITCH 2
       HTR D10D+3    DID NOT TRANSFER
       SWT 1         
       TRA D11D      PROCEED TO NEXT TEST
       TRA D10D      REPEAT TEST
       REM           
 D11D  PXA 0,1       L 7776
       LDQ L1+6      CORRECT NUMBER
       CAS L1+6      CHECK XRA 7776
       TRA D11D+5    ERROR
       TRA D11D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D11D+7    ERROR
       SWT 1         
       TRA D13D      PROCEED TO NEXT TEST
       TRA D10D      REPEAT TEST
       REM           
       REM           
       REM           
 D13D  PXD 0,2       L 7777
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRB 7777
       TRA D13D+5    ERROR
       TRA D13D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D13D+7    ERROR
       SWT 1         
       TRA D14D      PROCEED TO NEXT TEST
       TRA D13D      REPEAT TEST
       REM           
 D14D  PXD 0,4       L 7777
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRC 7777
       TRA D14D+5    ERROR
       TRA D14D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D14D+7    ERROR
       SWT 1         
       TRA D15D      PROCEED TO NEXT TEST
       TRA D14D      REPEAT TEST
       REM           
       REM           
       REM TEST TSX TAG 1
       REM           
 D15D  TSX D16D,1    SHOULD TRANSFER
       SWT 2         ERROR-TEST SWITCH 2
       HTR D15D+3    TSX FAILED TO TRANSFER
       SWT 1         
       TRA D16D      PROCEED TO NEXT TEST
       TRA D15D      REPEAT TEST
       REM           
       REM           
       REM
 D16D  PXD 0,1       
       PDC 0,1       RE-COMPLEMENT TO GET THE
       REM           ADR. OF TSX INSTRUCTION
       TXH *+2,1,D15D-1 SHOULD TRANSFER
       HTR *+1       ERROR XRA=D15D DEC.=D15D-1
       TXL *+2,1,D15D SHOULD TRANSFER
       HTR *+1       ERROR XRA=DEC=D15D
       SWT 1         
       TRA D17D      PROCEED TO NEXT TEST
       TRA D16D      REPEAT TEST
       REM           
       REM           
 D17D  PXD 0,2       L 7777
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRB 7777
       TRA D17D+5    ERROR
       TRA D17D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D17D+7    ERROR
       SWT 1         
       TRA D19D      PROCEED TO NEXT TEST
       TRA D17D      REPEAT TEST
       REM           
       REM           
 D19D  PXD 0,4       L 7777
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRC 7777
       TRA D19D+5    ERROR
       TRA D19D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D19D+7    ERROR
       SWT 1         
       TRA D20D      PROCEED TO NEXT TEST
       TRA D19D      REPEAT TEST
       REM           
       REM           
       REM TEST TSX TAG 0
       REM           
 D20D  TSX D21D,0    SHOULD TRANSFER
       REM           BUT XRA SHOULD STILL = D15D
       SWT 2         ERROR-TEST SWITCH 2
       HTR D20D+3    TSX FAILED TO TRANSFER
       SWT 1         
       TRA D21D      PROCEED TO NEXT TEST
       TRA D20D      REPEAT TEST
       REM           
       REM           
 D21D  TXH *+2,1,D15D-1 SHOULD TRANSFER
       HTR *+1       ERROR XRA=D15D DEC.=D15D-1
       TXL *+2,1,D15D SHOULD TRANSFER
       HTR *+1       ERROR XRA=DEC=D15D
       SWT 1         
       TRA D22D      PROCEED TO NEXT TEST
       TRA D21D      REPEAT TEST
       REM           
       REM
 D22D  PXD 0,2       L 7777
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRB 7777
       TRA D22D+5    ERROR
       TRA D22D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D22D+7    ERROR
       SWT 1         
       TRA D23D      PROCEED TO NEXT TEST
       TRA D22D      REPEAT TEST
       REM           
       REM           
 D23D  PXD 0,4       L 7777
       LDQ K8D       CORRECT NUMBER
       CAS K8D       CHECK XRC 7777
       TRA D23D+5    ERROR
       TRA D23D+7    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D23D+7    ERROR
       SWT 1         
       TRA D24D      PROCEED TO NEXT TEST
       TRA D23D      REPEAT TEST
       REM           
       REM           
       REM TEST LXA WITH TAG OF ZERO
       REM           
 D24D  LXA K17D,7    L ZEROS
       LXA K0+5,0    L 7777
       PXD 0,1       L ZEROS CHECK XRA
       TZE D24D+6    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D24D+6    ERROR
       REM           DECR OF ACC INDICATES
       REM           ERROR WHICH WAS LOADED
       REM           INTO XRA
       SWT 1         
       TRA D25D      PROCEED TO NEXT TEST
       TRA D24D      REPEAT TEST
       REM           
       REM           
       REM           
       REM           
 D25D  PXD 0,2       CHECK XRB
       TZE D25D+4    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR D25D+4    ERROR IN XRB
       SWT 1         
       TRA ED        PROCEED TO NEXT TEST
       TRA D25D      REPEAT TEST
       REM           
       REM           
 ED    PXD 0,4       CHECK XRB
       TZE ED+4      OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR ED+4      ERROR IN XRC
       SWT 1         
       TRA E1D       PROCEED TO NEXT TEST
       TRA ED        REPEAT TEST
       REM           
       REM           
       REM TEST LXD WITH TAG OF ZERO
       REM           
 E1D   LXA K17D,7    L ZEROS
       LXD K0+5,0    L 7777
       PXD 0,1       L ZEROS CHECK XRA
       TZE E1D+6     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E1D+6     ERROR XRA
       SWT 1         
       TRA E2D       PROCEED TO NEXT TEST
       TRA E1D       REPEAT TEST
       REM           
       REM           
 E2D   PXD 0,2       CHECK XRB
       TZE E2D+4     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E2D+4     ERROR IN XRB
       SWT 1         
       TRA E3D       PROCEED TO NEXT TEST
       TRA E2D       REPEAT TEST
       REM           
       REM           
 E3D   PXD 0,4       CHECK XRB
       TZE E3D+4     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E3D+4     ERROR IN XRC
       SWT 1         
       TRA E4D       PROCEED TO NEXT TEST
       TRA E3D       REPEAT TEST
       REM           
       REM           
       REM TEST PAX WITH TAG OF ZERO
       REM           
 E4D   CLA K0+5      L-3077777707777 FOR 4K
       LXA K17D,7    L ZEROS
       PAX K0+5,0    L 7777
       PXD 0,1       CHECK XRA
       TZE E4D+7     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E4D+7     ERROR XRA
       SWT 1         
       TRA E5D       PROCEED TO NEXT TEST
       TRA E4D       REPEAT TEST
       REM           
       REM           
 E5D   PXD 0,2       CHECK XRB
       TZE E5D+4     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E5D+4     ERROR IN XRB
       SWT 1         
       TRA E6D       PROCEED TO NEXT TEST
       TRA E5D       REPEAT TEST
       REM           
       REM           
 E6D   PXD 0,4       CHECK XRB
       TZE E6D+4     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E6D+4     ERROR IN XRC
       SWT 1         
       TRA E7D       PROCEED TO NEXT TEST
       TRA E6D       REPEAT TEST
       REM           
       REM           
       REM TEST PDX WITH TAG OF ZERO
       REM           
 E7D   CLA K0+5      L-3077777707777 FOR 4K
       LXA K17D,7    L ZEROS
       PDX K0+5,0    L 7777
       PXD 0,1       CHECK XRA
       TZE E7D+7     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E7D+7     ERROR XRA
       SWT 1         
       TRA E8D       PROCEED TO NEXT TEST
       TRA E7D       REPEAT TEST
       REM           
       REM           
 E8D   PXD 0,2       CHECK XRB
       TZE E8D+4     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E8D+4     ERROR IN XRB
       SWT 1         
       TRA E9D       PROCEED TO NEXT TEST
       TRA E8D       REPEAT TEST
       REM           
       REM           
 E9D   PXD 0,4       CHECK XRB
       TZE E9D+4     OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E9D+4     ERROR IN XRC
       SWT 1         
       TRA E10D      PROCEED TO NEXT TEST
       TRA E9D       REPEAT TEST
       REM           
       REM           
       REM TEST SXD WITH TAG OF ZERO
       REM           
 E10D  LXA K0+5,7    L ZEROS
       CLA K0+2      L ALL ONES
       STO J1D       TEMPORARY STG
       SXD J1D,0     
       CLA J1D       
       SUB K21AD     L -300000777777
       TZE E10D+9    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E10D+9    ERROR XRA
       SWT 1         
       TRA E11D      PROCEED TO NEXT TEST
       TRA E10D      REPEAT TEST
       REM           
       REM           
       REM TEST PXD WITH TAG OF ZERO
       REM           
 E11D  CLA K0+5      L-3077777707777 FOR 4K
       LXA K0+5,7    L 7777
       PXD 0,0       
       TZE E11D+6    OK
       SWT 2         ERROR-TEST SWITCH 2
       HTR E11D+6    ERROR XRA
       SWT 1         
       TRA N17C-2    PROCEED TO NEXT TEST
       TRA E11D      REPEAT TEST
       REM           
       REM           
*ERASE PRINT INSTRUCTION SO THAT THE SIZE OF STORAGE
*WILL ONLY BE PRINTED OUT ONCE.
       REM           
       REM           
       CLA CAA+1     L TRA SC
       STO PRINT     
       REM           
       REM           
       REM           
 N17C  SWT 6         
       TRA *+2       
       TRA HJW       PRINT OUT PASS COMPLETE
       REM           
       REM           
       REM           
       REM RDS       
 N16C  RCDA          READ IN NEXT PROGRAM
       RCHA CNTW     
       LCHA 0        
       TRA 1         
 CNTW  MON 0,0,3     
       REM           
       REM           
       REM CONSTANTS 
       REM           
 L1    OCT 000001000000     CONSTANTS
       OCT +000002000000
       OCT +100014100002
       HTR 0,0,4096-G1-1 THESE VARY DEPENDING
       REM              UPON SIZE OF STG
       OCT 7777      77777, 37777, 27777, 17777,
       REM           OR 7777 IN ADDRESS
       OCT +000000000001
       OCT 7776      77776, 37776, 27776, 17776,
       REM           OR 7776 IN ADDRESS
       OCT 10000     100000, 40000, 30000, 20000,
       REM           OR 10000 IN ADDRESS
       OCT +000000077777
       OCT +000000000000
       OCT +0020000030
       OCT +000000000002
       OCT +00000001000
       OCT +00000000100
       HTR G1+1      
 L2    OCT 1         
 M     OCT +00000000000
       TSX M4,1      
       OCT +00000000000  TEMP STORAGE
       HTR 0,0,4096-M3
       HTR M3        
       LXA L1,1      
 K00   OCT -327777727777
 K0    OCT 0         
       OCT 1         
       OCT -377777777777
       OCT -337777737777
       OCT -317777717777
       OCT -307777707777 FOR 4K
       REM -317777717777 FOR 8K
       REM -327777727777 FOR 12K
       REM -337777737777 FOR 16K
       REM -377777777777 FOR ALL OTHERS
       OCT 345252742525
       OCT 005253000000  FOR 4K
       REM 015253000000  FOR 8K
       REM 035253000000  FOR ALL OTHERS
       OCT 002526000000  FOR 4K
       REM 012526000000  FOR 8K
       REM 032526000000  FOR ALL OTHERS
 K2    OCT 035253000000
       OCT 015253000000
 K3    OCT 032526000000
       OCT 012526000000
 T1    OCT 0         TEMP. STORAGE
       REM           
       REM           CONSTANTS
 S1B   HTR 0,0,4096-G1B-1 THESE VARY DEPENDING
       REM           UPON SIZE OF STG
 S2B   HTR G1B+1     
 S3B   TSX M4B,2     
 S4B   HTR 0,0,4096-M3B   THESE VARY DEPENDING
       REM           UPON SIZE OF STG.
 S5B   HTR M3B       
 S6B   LXA L1,2      
 S7B   OCT 0         TEMPORARY STORAGE
 S10B  OCT +100014200002
       REM           
       REM           CONSTANTS
       REM           
 S1C   HTR 0,0,4096-G1C-1  THESE VARY DEPENDING
       REM           UPON SIZE OF STG.
 S2C   HTR G1C+1     
 S3C   TSX M4C,4     
 S4C   HTR 0,0,4096-M3C  THESE VARY DEPENDING
       REM           UPON SIZE OF STG.
 S5C   HTR M3C
 S6C   LXA L1,4      
 S7C   OCT 0         TEMPORARY STORAGE
 S10C  OCT +100014400002
       REM           
       REM           
 K2D   OCT 100000000000
 K3D   OCT 000000100000
 K4D   OCT 040000000000
 K5D   OCT 025252525252
 K6D   OCT 052525252525
 K7D   OCT 004000000000
 K8D   OCT 007777000000
 K10D  OCT 003777000000
 K11D  OCT 003776000000
 K12D  HTR 0,0,4096-D15D
 K14D  OCT 000001000000
 K17D  OCT 0         
 K20D  OCT 10000     
 K21D  OCT 20000     
 K21AD OCT 700000777777
 K22D  OCT 30000     
       REM           
 L5D   OCT 014000014000
 L7D   OCT 024000024000
 L11D  OCT 034000034000
 L12D  OCT 074000074000
 L13D  OCT 002753000000
       REM           
 J1D   OCT 0         TEST WORD STORAGE
 K00D  OCT 777777777777
 K01D  OCT 666666666666
 K02D  OCT 555555555555
 K03D  OCT 444444444444
 K04D  OCT 333333333333
 K05D  OCT 222222222222
 K06D  OCT 111111111111
 K1111 OCT 1111      
 K2222 OCT 2222      
 K4444 OCT 4444      
       REM           
 W     OCT 370000777777
 X     OCT 070000000000
 Y     OCT 377777770000
 Z     OCT 000000070000
 CAA   OCT 546000000 
       TRA SC        
       REM           
       REM           
       REM           
       REM           
       WPRA          
       SPRA 3        
       RCHA PRT      PRINT PROGRAM NAME
       TRA 0         START
 PRT   IOCD PRG,0,24 
       REM           
*PRINT IMAGE FOR NOW RUNNING 9M03A- INDEXING TEST
       REM           
 PRG   OCT 421004       9L
       OCT 100000000000 9R
       OCT 0            8L
       OCT 0            8R
       OCT 4000         7L
       OCT 220000000000 7R
       OCT 6000000      6L
       OCT 0            6R
       OCT 10150002     5L
       OCT 442000000000 5R
       OCT 200401       4L
       OCT 0            4R
       OCT 100          3L
       OCT 4400000000   3R
       OCT 0            2L
       OCT 1000000000   2R
       OCT 40           1L
       OCT 0            1R
       OCT 2200200      0L
       OCT 205400000000 0R
       OCT 14550412     11L
       OCT 40000000000  11R
       OCT 24045        12L
       OCT 522000000000 12R
       REM           
       REM           
       REM           
       REM           
       REM           
 HJW   WPRA          
       SPRA 3        
       RCHA PR       PRINT PASS COMPLETE
       TRA 1         REPEAT TEST
 PR    IOCD PG,0,24  
       REM           
       REM           
*PRINT IMAGE FOR PASS COMPLETE - 9M03A
 PG    OCT 0            9L
       OCT 1000000000   9R
       OCT 0            8L
       OCT 0            8R
       OCT 200          7L
       OCT 400000000000 7R
       OCT 2            6L
       OCT 0            6R
       OCT 0            5L
       OCT 120000000000 5R
       OCT 1            4L
       OCT 400000000    4R
       OCT 4            3L
       OCT 240100000000 3R
       OCT 60           2L
       OCT 0            2R
       OCT 100          1L
       OCT 40000000     1R
       OCT 60           0L
       OCT 40200000000  0R
       OCT 203          11L
       OCT 604400000000 11R
       OCT 104          12L
       OCT 120040000000 12R
       REM           
       REM           
       END           
