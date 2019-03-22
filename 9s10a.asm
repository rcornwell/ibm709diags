       9S10A

       REM
       REM
       FUL
START  TXL 3,0,23       IOST FOR READ CARD
ONE    TCOA *           HOLD TILL IN
       STD *-1          MAKE 00001 = 1
       CAL TEMP-1       SECURE TEST WORD
       SLW TEMP         TEMP STORAGE
XRA    AXT START-24,1   LOAD INDEX
       ZET 0,1          CHECK TEST LOCATION
       HPR 0,1          FOR ZERO - NO!
       STO 0,1          YES - STORE TEST LOC.
       ADD ONE          INCREASE ADDRESS
       SLW TEMP         SAVE AT TEMP
       XEC 0,1          EXECUTE CAQ WITH 76 "E" CYCLES
       STZ 0,1          CLEAR
       ZET 0,1          TEST ZERO
       HPR 0,1          NO - CANNOT RESTORE
       CAL TEMP         OKAY
       TIX XRA+1,1,1    NEXT TEST LOCATION
       TRA START+3      REPEAT TEST
       CAQ *+6,0,62     TEST WORD - 76 E CYCLES
TEMP   HTR 0
       END
