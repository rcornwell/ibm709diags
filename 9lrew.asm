                                                     
                                                             9LREW
       REM  TAPE REWINDER FOR LOW END LOADER 9LD01
       REM            
       REM LOAD THIS PROGRAM IN FRONT OF THE
       REM LAST TRANSFER CARD OF EACH
       REM FILE OF CARDS TO GO ON SYSTEM
       REM TAPE. THIS VERSION OF THE 
       REM REWINDER IS MATCHED
       REM TO LOADER 9LD01 WITH TAPE SELECTION.
       REM BE SURE THAT LOADER AND REWINDER
       REM ARE MATCHED.
       REM            
       REM            
       ORG 4          
       REM            
A      RTBA 1         READ TRANSFER CARD
       RCHA B         
       TCOA *         
       REWA 1         REWIND TAPE 1
       CLA B+1        
       TZE B+2        TRANSFER TO MAIN PROGRAM
       HTR *          BAD TRANSFER CARD
       REM            
B      EQU 21         
       REM            
       REM            
       END            

