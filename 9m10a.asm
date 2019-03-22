    
 
*      9M10A  INSTRUCTION COUNTER TEST.
*      ONE CARD - SELF-LOADING.
       REM
       REM
       FUL
       REM
       IOCD  3,,20      BRING IN CARD
       TCOA  *          WAIT
       REM
*  GREETINGS TO D. B. H. AND ALL THE BOYS AT THE CAPE
       REM
       AXT 24,1         SET FIRST ADDRESS
       PXA ,1
       PAC ,2
       LDQ 21           L-OF-FRN
       STQ ,2
       LDQ 22           L-OF-TSX
       STQ 1,2
       STZ -1,2
       TRA ,2           GO TO THE FRN INSTRUCTION
       REM
       REM WE GO OUT TO FRN-THUS GENERATING
       REM THE LOCATION OF THE TSX IN THE ACC.
       REM THEN, STEP IC TO THE TXT AND
       REM RETURN TO 13 WHERE WE CHECK.
       REM
       SXD 13,4         XRC WAS LOADED BY TSX
       PAX ,4           ACC HAS CORRECT LOCATION
       TXI *+1,4,0      ADD TSX VALUE TO ACC VALUE.
       TXL *+2,4,0      SHOULD BE ZERO.
       REM
       HTR 3            ERROR. ADD. IN ACC DOES
       REM              NOT MATCH VALUE IN XRC-
       REM              ADD. OF ACC. IS THE LOC.
       REM              TO WHICH THE IC SHOULD
       REM              HAVE STEPPED. PRESS
       REM              START TO TRY THIS ADD. AGAIN.
       REM
       TXI *+1,1,1      INCREASE FOR NEXT LOC
       TXH 3,1,1        STOP AFTER PASSING 77777
       SWT 6
       HPR              STOP IF 6 IS UP
       TRA 2            REPEAT PROGRAM
       FRN
       TSX 11,4
       REM
       END 
