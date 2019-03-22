                                                             9MLTA
                                                            11/10/58
*               SPECIAL FEATURE PROGRAM FOR EIGHT SENSE LIGHTS
       REM           
*                               RPQ E87449
       REM           
       REM           
       ORG 24        
       REM           
START  CLA SWT6+2     PORT
       STO 0          RESTART
       REM           
*****************************************************************
       REM           
*   TURN LITES OFF THEN TEST EACH LITE FOR OFF CONDITION
       REM           
*****************************************************************
       REM           
       SLF            TURN LITES OFF
       REM           
*    TEST SENSE LITE 1 FOR OFF STATUS
       REM
SLT1   SLT 1          TEST LITE 1
       TRA A          OK SHOULD BE OFF
       SWT 2          SENSE SWITCH 2
       HPR            LITE 1 ON SHOULD BE OFF
A      SWT 1          SENSE SWITCH 1
       TRA SLT2       TEST NEXT LITE
       TRA SLT1       REPEAT SLT 1
       REM           
       REM           
*    TEST SENSE LITE 2 FOR OFF STATUS
       REM
SLT2   SLT 2          TEST LITE 2
       TRA A1         OK SHOULD BE OFF
       SWT 2          SENSE SWITCH 2
       HPR            LITE 2 ON SHOULD BE OFF
A1     SWT 1          SENSE SWITCH 1
       TRA SLT3       TEST NEXT LITE
       TRA SLT2       REPEAT SLT 2
       REM           
       REM           
*    TEST SENSE LITE 3 FOR OFF STATUS
       REM
SLT3   SLT 3          TEST LITE 3
       TRA A3         OK SHOULD BE OFF
       SWT 2          SENSE SWITCH 2
       HPR            LITE 3 ON SHOULD BE OFF
A3     SWT 1          SENSE SWITCH 1
       TRA SLT4       TEST NEXT LITE
       TRA SLT3       REPEAT SLT 3
       REM           
*    TEST SENSE LITE 4 FOR OFF STATUS
       REM
SLT4   SLT 4          TEST LITE 4
       TRA A4         OK SHOULD BE OFF
       SWT 2          SENSE SWITCH 2
       HPR            LITE 4 ON SHOULD BE OFF
A4     SWT 1          SENSE SWITCH 1
       TRA SLT5       TEST NEXT LITE
       TRA SLT4       REPEAT SLT 4
       REM           
*    TEST SENSE LITE 5 FOR OFF STATUS
       REM
SLT5   SLT 5          TEST LITE 5
       TRA A5         OK SHOULD BE OFF
       SWT 2          SENSE SWITCH 2
       HPR            LITE 5 ON SHOULD BE OFF
A5     SWT 1          SENSE SWITCH 1
       TRA SLT6       TEST NEXT LITE
       TRA SLT5       REPEAT SLT 5
       REM           
*    TEST SENSE LITE 6 FOR OFF STATUS
       REM
SLT6   SLT 6          TEST LITE 6
       TRA A6         OK SHOULD BE OFF
       SWT 2          SENSE SWITCH 2
       HPR            LITE 6 ON SHOULD BE OFF
A6     SWT 1          SENSE SWITCH 1
       TRA SLT7       TEST NEXT LITE
       TRA SLT6       REPEAT SLT 6
       REM           
*    TEST SENSE LITE 7 FOR OFF STATUS
       REM
SLT7   SLT 7          TEST LITE 7
       TRA A7         OK SHOULD BE OFF
       SWT 2          SENSE SWITCH 2
       HPR            LITE 7 ON SHOULD BE OFF
A7     SWT 1          SENSE SWITCH 1
       TRA SLT8       TEST NEXT LITE
       TRA SLT7       REPEAT SLT 7
       REM           
*    TEST SENSE LITE 8 FOR OFF STATUS
       REM
SLT8   SLT 8          TEST LITE 8
       TRA A8         OK SHOULD BE OFF
       SWT 2          SENSE SWITCH 2
       HPR            LITE 7 ON SHOULD BE OFF
A8     SWT 1          SENSE SWITCH 1
       TRA SLN        TRANSFER TO NEXT ROUTINE
       TRA SLT8       REPEAT SLT 8
       REM           
*****************************************************************
       REM           
* TEST SENSE LITES ON AND SENSE OFF
       REM           
*****************************************************************
       REM           
*   TEST SENSE LITE 1 
       REM           
SLN    SLT            BE SURE ALL LITES ARE OFF
       REM           
SLN1   SLN 1          TURN SENSE LITE 1 ON
       SLT 1          TURN SENSE LITE 1 OFF
       TRA A10        ERROR-LITE NOT ON
       TRA A11        OK LITE ON
A10    SWT 2          SSW 2
       HPR            LITE OFF SHOULD BE ON
A11    SWT 1          SSW 1
       TRA SLN2       TEST NEXT LITE
       TRA SLN1       REPEAT SLN 
       REM           
*   TEST SENSE LITE 2 
       REM           
SLN2   SLN 2          TURN SENSE LITE 2 ON
       SLT 2          TURN SENSE LITE 2 OFF
       TRA A12        ERROR-LITE NOT ON
       TRA A13        OK LITE ON
A12    SWT 2          SSW 2
       HPR            LITE OFF SHOULD BE ON
A13    SWT 1          SSW 1
       TRA SLN3       TEST NEXT LITE
       TRA SLN2       REPEAT SLN 2
       REM           
*   TEST SENSE LITE 3 
       REM           
SLN3   SLN 3          TURN SENSE LITE 2 ON
       SLT 3          TURN SENSE LITE 3 OFF
       TRA A14        ERROR-LITE NOT ON
       TRA A15        OK LITE ON
A14    SWT 2          SSW 2
       HPR            LITE OFF SHOULD BE ON
A15    SWT 1          SSW 1
       TRA SLN4       TEST NEXT LITE
       TRA SLN3       REPEAT SLN 3
       REM           
*   TEST SENSE LITE 4 
       REM           
SLN4   SLN 4          TURN SENSE LITE 4 ON
       SLT 4          TURN SENSE LITE 4 OFF
       TRA A16        ERROR-LITE NOT ON
       TRA A17        OK LITE ON
A16    SWT 2          SSW 2
       HPR            LITE OFF SHOULD BE ON
A17    SWT 1          SSW 1
       TRA SLN5       TEST NEXT LITE
       TRA SLN4       REPEAT SLN 4
       REM           
*   TEST SENSE LITE 5 
       REM           
SLN5   SLN 5          TURN SENSE LITE 5 ON
       SLT 5          TURN SENSE LITE 5 OFF
       TRA A18        ERROR-LITE NOT ON
       TRA A19        OK LITE ON
A18    SWT 2          SSW 2
       HPR            LITE OFF SHOULD BE ON
A19    SWT 1          SSW 1
       TRA SLN6       TEST NEXT LITE
       TRA SLN5       REPEAT SLN 5
       REM           
*   TEST SENSE LITE 6 
       REM           
SLN6   SLN 6          TURN SENSE LITE 6 ON
       SLT 6          TURN SENSE LITE 6 OFF
       TRA A20        ERROR-LITE NOT ON
       TRA A21        OK LITE ON
A20    SWT 2          SSW 2
       HPR            LITE OFF SHOULD BE ON
A21    SWT 1          SSW 1
       TRA SLN7       TEST NEXT LITE
       TRA SLN6       REPEAT SLN 6
       REM           
*   TEST SENSE LITE 7 
       REM           
SLN7   SLN 7          TURN SENSE LITE 7 ON
       SLT 7          TURN SENSE LITE 7 OFF
       TRA A22        ERROR-LITE NOT ON
       TRA A23        OK LITE ON
A22    SWT 2          SSW 2
       HPR            LITE OFF SHOULD BE ON
A23    SWT 1          SSW 1
       TRA SLN8       TEST NEXT LITE
       TRA SLN7       REPEAT SLN 7
       REM           
*   TEST SENSE LITE 8 
       REM           
SLN8   SLN 8          TURN SENSE LITE 8 ON
       SLT 8          TURN SENSE LITE 8 OFF
       TRA A24        ERROR-LITE NOT ON
       TRA A25        OK LITE ON
A24    SWT 2          SSW 2
       HPR            LITE OFF SHOULD BE ON
A25    SWT 1          SSW 1
       TRA SLTA1      TRANFER TO NEXT ROUTINE
       TRA SLN8       REPEAT SLN 8
       REM           
*****************************************************************
       REM           
*TEST SLT TO SEE THAT LAST ROUTINE TURNED
*OFF EACH SENSE LITE 
       REM           
*****************************************************************
       REM           
*    TEST SENSE LITE 1
       REM           
SLTA1  SLT 1          TEST LITE 1
       TRA A26        OK SHOULD BE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A26    SWT 1          SSW 1
       TRA SLTA2      TEST NEXT LITE
       TRA SLTA1      REPEAT SLT 1
       REM           
*    TEST SENSE LITE 2
       REM           
SLTA2  SLT 2          TEST LITE 2
       TRA A27        OK SHOULD BE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A27    SWT 1          SSW 1
       TRA SLTA3      TEST NEXT LITE
       TRA SLTA2      REPEAT SLT 2
       REM           
*    TEST SENSE LITE 3
       REM           
SLTA3  SLT 3          TEST LITE 3
       TRA A28        OK SHOULD BE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A28    SWT 1          SSW 1
       TRA SLTA4      TEST NEXT LITE
       TRA SLTA3      REPEAT SLT 3
       REM           
*    TEST SENSE LITE 4
       REM           
SLTA4  SLT 41         TEST LITE 4
       TRA A29        OK SHOULD BE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A29    SWT 1          SSW 1
       TRA SLTA5      TEST NEXT LITE
       TRA SLTA4      REPEAT SLT 4
       REM           
*    TEST SENSE LITE 5
       REM           
SLTA5  SLT 5          TEST LITE 5
       TRA A30        OK SHOULD BE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A30    SWT 1          SSW 1
       TRA SLTA6      TEST NEXT LITE
       TRA SLTA5      REPEAT SLT 5
       REM           
*    TEST SENSE LITE 6
       REM           
SLTA6  SLT 6          TEST LITE 6
       TRA A31        OK SHOULD BE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A31    SWT 1          SSW 1
       TRA SLTA7      TEST NEXT LITE
       TRA SLTA6      REPEAT SLT 6
       REM           
*    TEST SENSE LITE 7
       REM           
SLTA7  SLT 7          TEST LITE 7
       TRA A32        OK SHOULD BE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A32    SWT 1          SSW 1
       TRA SLTA8      TEST NEXT LITE
       TRA SLTA7      REPEAT SLT 7
       REM           
*    TEST SENSE LITE 8
       REM           
SLTA8  SLT 8          TEST LITE 8
       TRA A33        OK SHOULD BE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A33    SWT 1          SSW 1
       TRA SLF1       PROCEED TO NEXT ROUTINE
       TRA SLTA8      REPEAT SLT 8
       REM           
*****************************************************************
       REM           
*TEST SLF TO TURN OFF ALL SENSE LITES
       REM           
*****************************************************************
       REM           
*TEST SENSE LITE 1   
       REM           
SLF1   SLN 1          TURN LITE 1 ON
       SLF            TURN LITE 1 OFF
       SLT 1          TEST LITE 1
       TRA A34        OK LITE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A34    SWT 1          SSW 1
       TRA SLF2       TEST NEXT LITE
       TRA SLF1       REPEAT SLF 1
       REM           
*TEST SENSE LITE 2   
       REM           
SLF2   SLN 2          TURN LITE 2 ON
       SLF            TURN LITE 2 OFF
       SLT 2          TEST LITE 2
       TRA A35        OK LITE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A35    SWT 1          SSW 1
       TRA SLF3       TEST NEXT LITE
       TRA SLF2       REPEAT SLF 2
       REM           
*TEST SENSE LITE 3   
       REM           
SLF3   SLN 3          TURN LITE 3 ON
       SLF            TURN LITE 3 OFF
       SLT 3          TEST LITE 3
       TRA A36        OK LITE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A36    SWT 1          SSW 1
       TRA SLF4       TEST NEXT LITE
       TRA SLF3       REPEAT SLF 3
       REM           
*TEST SENSE LITE 4   
       REM           
SLF4   SLN 4          TURN LITE 4 ON
       SLF            TURN LITE 4 OFF
       SLT 4          TEST LITE 4
       TRA A37        OK LITE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A37    SWT 1          SSW 1
       TRA SLF5       TEST NEXT LITE
       TRA SLF4       REPEAT SLF 4
       REM           
*TEST SENSE LITE 5   
       REM           
SLF5   SLN 5          TURN LITE 5 ON
       SLF            TURN LITE 5 OFF
       SLT 5          TEST LITE 5
       TRA A38        OK LITE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A38    SWT 1          SSW 1
       TRA SLF6       TEST NEXT LITE
       TRA SLF5       REPEAT SLF 5
       REM           
*TEST SENSE LITE 6   
       REM           
SLF6   SLN 6          TURN LITE 6 ON
       SLF            TURN LITE 6 OFF
       SLT 6          TEST LITE 6
       TRA A39        OK LITE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A39    SWT 1          SSW 1
       TRA SLF7       TEST NEXT LITE
       TRA SLF6       REPEAT SLF6
       REM           
*TEST SENSE LITE 7   
       REM           
SLF7   SLN 7          TURN LITE 7 ON
       SLF            TURN LITE 7 OFF
       SLT 7          TEST LITE 7
       TRA A40        OK LITE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A40    SWT 1          SSW 1
       TRA SLF8       TEST NEXT LITE
       TRA SLF7       REPEAT SLF7
       REM           
*TEST SENSE LITE 8   
       REM           
SLF8   SLN 8          TURN LITE 8 ON
       SLF            TURN LITE 8 OFF
       SLT 8          TEST LITE 8
       TRA A41        OK LITE OFF
       SWT 2          SSW 2
       HPR            LITE ON SHOULD BE OFF
A41    SWT 1          SSW 1
       TRA SLNA       GO TO NEXT ROUTINE
       TRA SLF8       REPEAT SLF8
       REM           
*****************************************************************
       REM           
*TEST SLN TO SEE THAT TURNING ON ONE LITE
*DOES NOT TURN ON ANY OTHER LITE
       REM           
*****************************************************************
       REM           
SLNA   SLF            TURN ALL OFF IF ANY ON
       REM           
*TEST SENSE LITE 1   
       REM           
SLNA1  SLF            TURN LITE 1 OFF
       SLN 2          TURN LITE 2 ON
       SLT 1          TEST LITE 1
       TRA A42        OK LITE 1 OFF
       SWT 2          SSW 2
       HPR            LITE 1 TURNED ON BY SLN 2
A42    SWT 1          SSW 1
       TRA SLNA2      TEST NEXT LITE
       TRA SLNA1      REPEAT SLNA1
       REM           
*TEST SENSE LITE 2   
       REM           
SLNA2  SLF            TURN LITE 2 OFF
       SLN 1          TURN LITE 1 ON
       SLT 2          TEST LITE 2
       TRA A43        OK LITE OFF
       SWT 2          SSW 2
       HPR            LITE 2 TURNED ON BY SLN 1
A43    SWT 1          SSW 1
       TRA SLNA3      TEST NEXT LITE
       TRA SLNA2      REPEAT SLNA2
       REM           
*TEST SENSE LITE 3   
       REM           
SLNA3  SLF            TURN LITE 3 OFF
       SLN 1          TURN LITE 1 ON
       SLT 3          TEST LITE 3
       TRA A44        OK LITE 3 OFF
       SWT 2          SSW 2
       HPR            LITE 3 TURNED ON BY SLN 1
A44    SWT 1          SSW 1
       TRA SLNA4      TEST NEXT LITE
       TRA SLNA3      REPEAT SLNA3
       REM           
*TEST SENSE LITE 4   
       REM           
SLNA4  SLF            TURN LITE 4 OFF
       SLN 1          TURN LITE 1 ON
       SLT 4          TEST LITE 4
       TRA A45        OK LITE 1 OFF
       SWT 2          SSW 2
       HPR            LITE 4 TURNED ON BY SLN 1
A45    SWT 1          SSW 1
       TRA SLNA5      TEST NEXT LITE
       TRA SLNA4      REPEAT SLNA4
       REM           
*TEST SENSE LITE 5   
       REM           
SLNA5  SLF            TURN LITE 5 OFF
       SLN 6          TURN LITE 6 ON
       SLT 5          TEST LITE 6
       TRA A46        OK LITE 5 OFF
       SWT 2          SSW 2
       HPR            LITE 5 TURNED ON BY SLN 6
A46    SWT 1          SSW 1
       TRA SLNA6      TEST NEXT LITE
       TRA SLNA5      REPEAT SLNA5
       REM           
*TEST SENSE LITE 6   
       REM           
SLNA6  SLF            TURN LITE 6 OFF
       SLN 2          TURN LITE 5 ON
       SLT 1          TEST LITE 6
       TRA A47        OK LITE 6 OFF
       SWT 2          SSW 2
       HPR            LITE 6 TURNED ON BY SLN 5
A47    SWT 1          SSW 1
       TRA SLNA7      TEST NEXT LITE
       TRA SLNA6      REPEAT SLNA6
       REM           
*TEST SENSE LITE 7   
       REM           
SLNA7  SLF            TURN LITE 7 OFF
       SLN 5          TURN LITE 5 ON
       SLT 7          TEST LITE 7
       TRA A48        OK LITE 7 OFF
       SWT 2          SSW 2
       HPR            LITE 7 TURNED ON BY SLN 5
A48    SWT 1          SSW 1
       TRA SLNA8      TEST NEXT LITE
       TRA SLNA7      REPEAT SLNA7
       REM           
*TEST SENSE LITE 8   
       REM           
SLNA8  SLF            TURN LITE 8 OFF
       SLN 5          TURN LITE 5 ON
       SLT 8          TEST LITE 8
       TRA A49        OK LITE 8 OFF
       SWT 2          SSW 2
       HPR            LITE 8 TURNED ON BY SLN 5
A49    SWT 1          SSW 1
       TRA SLTB1      GO TO NEXT ROUTINE
       TRA SLNA8      REPEAT SLNA8
       REM           
*****************************************************************
       REM           
*TEST SLT TO SEE THAT TURNING OFF ONE LITE
*DOES NOT TURN OFF ANY OTHER LITE
       REM           
*****************************************************************
       REM           
*TEST SENSE LITE 1   
       REM           
SLTB1  SLF            TURN ALL OFF IF ANY ON
       SLN 1          TURN LITE 1 ON
       SLT 2          TEST LITE 2
       SLT 1          TEST LITE 1
       TRA A50        ERROR LITE 1 OFF
       TRA A51        OK LITE 1 ON
A50    SWT 2          SSW 2
       HPR            LITE 1 TURNED OFF BY SLT 2
A51    SWT 1          SSW 1
       TRA SLTB2      TEST NEXT LITE
       TRA SLTB1      REPEAT SLTB1
       REM           
*TEST SENSE LITE 2   
       REM           
SLTB2  SLF            TURN ALL OFF IF ANY ON
       SLN 2          TURN LITE 2 ON
       SLT 1          TEST LITE 1
       SLT 2          TEST LITE 2
       TRA A52        ERROR LITE 2 OFF
       TRA A53        OK LITE 1 ON
A52    SWT 2          SSW 2
       HPR            LITE 2 TURNED OFF BY SLT 1
A53    SWT 1          SSW 1
       TRA SLTB3      TEST NEXT LITE
       TRA SLTB2      REPEAT SLTB2
       REM           
*TEST SENSE LITE 3   
       REM           
SLTB3  SLF            TURN ALL OFF IF ANY ON
       SLN 3          TURN LITE 3 ON
       SLT 1          TEST LITE 1
       SLT 3          TEST LITE 3
       TRA A54        ERROR LITE 3 OFF
       TRA A55        OK LITE 1 ON
A54    SWT 2          SSW 2
       HPR            LITE 3TURNED OFF BY SLT 1
A55    SWT 1          SSW 1
       TRA SLTB4      TEST NEXT LITE
       TRA SLTB3      REPEAT SLTB3
       REM           
*TEST SENSE LITE 4   
       REM           
SLTB4  SLF            TURN ALL OFF IF ANY ON
       SLN 4          TURN LITE 4 ON
       SLT 1          TEST LITE 1
       SLT 4          TEST LITE 4
       TRA A56        ERROR LITE 4 OFF
       TRA A57        OK LITE 1 ON
A56    SWT 2          SSW 2
       HPR            LITE 1 TURNED OFF BY SLT 1
A57    SWT 1          SSW 1
       TRA SLTB5      TEST NEXT LITE
       TRA SLTB4      REPEAT SLTB4
       REM           
*TEST SENSE LITE 5   
       REM           
SLTB5  SLF            TURN ALL OFF IF ANY ON
       SLN 5          TURN LITE 5 ON
       SLT 6          TEST LITE 6
       SLT 5          TEST LITE 5
       TRA A58        ERROR LITE 5 OFF
       TRA A59        OK LITE 1 ON
A58    SWT 2          SSW 2
       HPR            LITE 5 TURNED OFF BY SLT 6
A59    SWT 1          SSW 1
       TRA SLTB6      TEST NEXT LITE
       TRA SLTB5      REPEAT SLTB5
       REM           
*TEST SENSE LITE 6   
       REM           
SLTB6  SLF            TURN ALL OFF IF ANY ON
       SLN 6          TURN LITE 6 ON
       SLT 5          TEST LITE 5
       SLT 6          TEST LITE 6
       TRA A60        ERROR LITE 6 OFF
       TRA A61        OK LITE 1 ON
A60    SWT 2          SSW 2
       HPR            LITE 6 TURNED OFF BY SLT 5
A61    SWT 1          SSW 1
       TRA SLTB7      TEST NEXT LITE
       TRA SLTB6      REPEAT SLTB6
       REM           
*TEST SENSE LITE 7   
       REM           
SLTB7  SLF            TURN ALL OFF IF ANY ON
       SLN 7          TURN LITE 7 ON
       SLT 5          TEST LITE 5
       SLT 7          TEST LITE 7
       TRA A62        ERROR LITE 7 OFF
       TRA A63        OK LITE 7 ON
A62    SWT 2          SSW 2
       HPR            LITE 7 TURNED OFF BY SLT 5
A63    SWT 1          SSW 1
       TRA SLTB8      TEST NEXT LITE
       TRA SLTB7      REPEAT SLTB7
       REM           
*TEST SENSE LITE 8   
       REM           
SLTB8  SLF            TURN ALL OFF IF ANY ON
       SLN 8          TURN LITE 8 ON
       SLT 5          TEST LITE 5
       SLT 8          TEST LITE 8
       TRA A64        ERROR LITE 2 OFF
       TRA A65        OK LITE 1 ON
A64    SWT 2          SSW 2
       HPR            LITE 8 TURNED OFF BY SLT 5
A65    SWT 1          SSW 1
       TRA NOP        GO TO NEXT ROUTINE
       TRA SLTB8      REPEAT SLTB8
       REM           
*****************************************************************
       REM           
* NOP TEST TO CHECK NOP FOR INTERPRETATION AS SLT 1
       REM           
*****************************************************************
       REM           
NOP    SLF            TURN ALL OFF IF ANY ON
       NOP 97         
       SLT 1          TEST LITE ONE
       TRA A66        OK SHOULD BE OFF
       SWT 2          SSW 2
       HPR            NOP EXECUTED AS SLT
A66    SWT 1          SSW 1
       TRA SWT5       PROCEED TO NEXT ROUTINE
       TRA NOP        REPEAT NOP TEST
       REM           
       REM           
SWT5   SWT 5          SSW 5
       TRA SWT6       PROCEED TO SSW 6
       REM           
*****************************************************************
       REM           
* TURN ALL SENSE LITES ON AND HALT
       REM           
*****************************************************************
       REM           
       SLN 1          TURN LITE 1 ON
       SLN 2          TURN LITE 2 ON
       SLN 3          TURN LITE 3 ON
       SLN 4          TURN LITE 4 ON
       SLN 5          TURN LITE 5 ON
       SLN 6          TURN LITE 6 ON
       SLN 7          TURN LITE 7 ON
       SLN 8          TURN LITE 8 ON
       HTR SWT6       HALT FOR CE TEST
       REM           
SWT6   SWT 6          SSW 6
       TRA RCD        END OF DIAGNOSTIC
       TRA START      REPEAT DIAGNOSTIC
       REM           
RCD    RCDA           READ
       RCHA Z         IN 
       LCHA 0         NEXT
       TRA 1          DIAGNOSTIC
       REM           
Z      IOCT           0,0,3
       REM           
       END START      
