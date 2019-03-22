                                                      
                                                             9HREW
       REM  TAPE REWINDER FOR HIGH END LOADER 9LD02
       REM            
       REM LOAD THIS PROGRAM IN FRONT OF THE
       REM LAST TRANSFER CARD OF EACH
       REM FILE OF CARDS TO GO ON SYSTEM
       REM TAPE. THIS VERSION OF THE 
       REM REWINDER IS MATCHED
       REM TO LOADER 9LD02 WITH TAPE SELECTION.
       REM BE SURE THAT LOADER AND REWINDER
       REM ARE MATCHED.
       REM            
       REM            
       ORG 32747      
       REM            
A      RTBA 1         READ TRANSFER CARD
       RCHA B         
       TCOA *         
       REWA 1         REWIND TAPE 1
       CLA B+1        
       TZE B+2        TRANSFER TO MAIN PROGRAM
       HTR -1         BAD TRANSFER CARD
       REM            
       REM            
       REM            
B      EQU -4         
       END            
