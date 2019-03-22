                                                             9LD01A          
                                                            7-01-58
*                              9LD01A
       FUL
       REM
TEMP   IOCD 3,0,21    THIS LOCATION IS USED
       REM            FOR CONTROL TO READ
       REM            THE REMAINDER OF
       REM            THE LOADER, AND ALSO
       REM            AS STORAGE FRO THE
       REM            INCOMPLETE CHECK SUM
       RCDA
       RCHA B         CONTROL HAS S TGR ON
       REM            AND WILL READ 9L AND 
       REM            9R WORDS INTO B+1 AND
       REM            B+2.
       TCOA *
       CLA B+1        9L WORD-WORD COUNT ON CARD
       REM            AND INITIAL ADDRESS, ALSO
       REM            USED AS CONTROL WORD
       REM            TO READ REMAINDER OF
       REM            CARD AFTER CONTROL AT
       REM            B HAS BEEN EXECUTED.
       REM
       TZE B+2        IF ZERO-EITHER TRA CARD
       REM            OR BLANK CARD.
       REM
       STO TEMP       IF NOT ZERO-SAVE. 9L TO BE
       REM            ADDED INTO CHECK SUM.
       REM
       STA *+5        ADDRESS OF 8L WORD IN
       REM            STORAGE
       SUB CONST      L 777777. SUBTRACTING
       REM            THIS CONSTANT WILL
       REM            INCREASE THE ADDRESS
       REM            AND DECREASE THE WORD NO.
       REM
       TMI CONST-4    WHEN ACC BECOMES MINUS
       REM            THE LAST WORD HAS BEEN
       REM            ADDED INTO CHECK SUM.
       STO B+1        IF NOT MINUS-SAVE.
       CAL TEMP       INCOMPLETE CHECK SUM.
       ACL            8L ADDRESS-INITIALLY.
       SLW TEMP       SAVE INCOMPLETE SUM.
       CLA B+1
       TRA *-8        RETURN TO STORE ADDRESS.
       REM
       CLA TEMP       COMPLETE CHECK SUM.
       SUB B+2        B+2 WILL HOLD CORRECT CHECK
       REM            SUM FROM CARD, UNLESS A
       REM            TRA CARD. IF A TRA CARD
       REM            B+2 WILL HOLD THE TRANSFER.
       TZE 1          IF ZERO BACK TO RCDA
       HTR 1          IF NOT ZERO-HALT
CONST  OCT 777777
B      IOCP B+1,0,2   CONTROL TO READ 9L AND
       REM            9R OF EACH CARD INTO
       REM            B+1 AND B+2 RESPECTIVELY
       REM
       OCT 0          LOCATION FOR 9L OF EACH
       REM            CARD WHICH WILL BE USED
       REM            AS A CONTROL WORD AFTER
       REM            EXECUTION OF WORD AT B,
       REM            ALSO AS TEMPORARY STORAGE
       REM            FOR CONSECUTIVE ADDRESSES
       REM            AND WORD COUNT AFTER
       REM            SUBTRACTING COSNT.
       REM
       OCT 0          9R WORD OF EACH CARD WILL
       REM            READ INTO THIS LOCATION, AND
       REM            WILL CONTAIN THE CHECK
       REM            SUM FROM EACH CARD, UNLESS
       REM            A TRA CARD. IN THIS CASE
       REM            9R WILL CONTAIN A STRAIGHT
       REM            TRANSFER TO THE START
       REM            OF THE PROGRAM.
       END

