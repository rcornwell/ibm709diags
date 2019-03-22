                                                            9T11A
                                                             11/1/58
* F I L E  S E A R C H  R O U T I N E
*
*
       ORG 24
*
START  RTBA 1         READ SEARCH ROUTINE
       RCHA CW3       TAPE MARK
       TCOA *
       TEFA *+2
       HTR D          DID NOT READ TAPE MARK
       HPR            HALT TO ENTER KEYS
       ENK            DEPRESS KEY DESIGNATING
       REM            FILE DESIRED
       XCL            EXCHANGE MQ TO ACC.
       REM
A      ALS 1
       SLW T          SAVE ACC. FOR SAFETY
       PBT            TEST FOR P BIT WHICH
       REM            INDICATES FILE FOUND
       TRA B          FILE SKIP
       TRA C          FILE FOUND
       REM
B      RTBA 1         SKIP FILE
       RCHA CW1       DO NOT TRANSMIT TO STG.
       TCOA *
       REM
       CAL T          BRING BACK FILE KEY
       TEFA A         EOF INDICATED
       HPR            NO EOF TRY FILE SEARCH
D      REWA 1
       REM            AGAIN. PRESS START
       REM
C      RTBA 1         SIMULATE LOAD BUTTON
       RCHA CW2
       TCOA *
       TRA 1
       REM
T      OCT 0
CW1    IOCP 0,2,-1
       TCH *-1
CW2    IOCP 0,0,3
       TCH 0
CW3    IOCD 0,2,80
       REM
       END 24
