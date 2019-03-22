                                                             9LD02A          
                                                            7-01-58
*                              9LD02A
       FUL
       REM
       ORG 32741
       FUL
A      IOCD A+3,0,21 CONTROL TO READ REMAINDER
       REM           OF LOADER
       TCOA 1        DELAY TILL COMPLETE
       REM           LOADER IS IN
       TRA A+3       TRA TO UPPER SECTION
       REM           OF LOADER
       RCDA
       RCHA B        CONTROL HAS S TGR ON
       REM           AND WILL READ 9L AND 9R
       REM           OF EACH CARD INTO B+1
       REM           AND B+2 RESPECTIVELY. 
       TCOA *        WAIT FOR COMPLETE CARD
       CLA B+1       9L WORD WHICH WILL
       REM           CONTAIN THE INITIAL ADDRESS
       REM           OF THE CARD AND THE 
       REM           NUMBER OF WORDS ON THE CARD
       REM
       TZE B+2       IF ZERO-EITHER TRA CARD
       REM           OR BLANK CARD.
       REM
       STO TEMP      IF NOT ZERO-SAVE. 9L TO BE
       REM           ADDED INTO CHECK SUM.
       rEM
       STA *+5       ADDRESS OF 8L WORD IN
       REM           STORAGE
       SUB CONST     L 777777. SUBTRACTING
       REM           THIS CONSTANT WILL
       REM           INCREASE THE ADDRESS
       REM           AND DECREASE THE WORD NO.
       REM
       TMI CONST-4   WHEN ACC BECOMES MINUS
       REM           THE LAST WORD HAS BEEN
       REM           ADDED INTO CHECK SUM.
       REM
       STO B+1       IF NOT MINUS-SAVE.
       CAL TEMP      INCOMPLETE CHECK SUM.
       ACL           8L ADDRESS-INITIALLY.
       SLW TEMP      SAVE INCOMPLETE SUM.
       CLA B+1
       TRA *-8       RETURN TO STORE ADDRESS.
       REM
       CLA TEMP      COMPLETE CHECK SUM.
       SUB B+2       B+2 WILL HOLD CORRECT CHECK
       REM           SUM FROM CARD, UNLESS A
       REM           TRA CARD. IF A TRA CARD
       REM           B+2 WILL HOLD THE TRANSFER.
       TZE A+3       IF ZERO BACK TO RCDA
       HTR A+3       IF NOT ZERO-HALT
CONST  OCT 777777
B      IOCP B+1,0,2  CONTROL TO READ 9L AND
       REM           9R OF EACH CARD INTO
       REM           B+1 AND B+2 RESPECTIVELY
       REM
       OCT 0         LOCATION FOR 9L OF EACH
       REM           CARD WHICH WILL BE USED
       REM           AS A CONTROL WORD AFTER
       REM           EXECUTION OF WORD AT B,
       REM           ALSO AS TEMPORARY STORAGE
       REM           FOR CONSECUTIVE ADDRESSES
       REM           AND WORD COUNT AFTER
       REM           SUBTRACTING COSNT.
       OCT 0         9R WORD OF EACH CARD WILL
       REM           READ INTO THIS LOCATION, AND
       REM           WILL CONTAIN THE CHECK
       REM           SUM FROM EACH CARD, UNLESS
       REM           A TRA CARD. IN THIS CASE
       REM           9R WILL CONTAIN A STRAIGHT
       REM           TRANSFER TO THE START
       REM           OF THE PROGRAM.
TEMP   OCT  0        TEMPORARY STORAGE FOR
       REM           IN COMPLETE CHECK SUM.
       END

