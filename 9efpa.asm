     709 EXTENDED FLOATING POINT SPECIAL FEATURE             9EFPA          
                                                            1-1-60
       REM
       REM
******************************************************************
*                                                                *
*                 B/M  580043       EC  298817                   *
*                                                                *
******************************************************************
       REM            
******************************************************************
*                                                                *
*         ******   ******   ******   *******       *********     *
*         *        *        *           *            *   *       *
*         *        *        *           *            *   *       *
*         *        *        *           *            *   *       *
*         ******   ****     *           *            *   *       *
*              *   *        *           *            *   *       *
*              *   *        *           *            *   *       *
*              *   *        *           *      **    *   *       *
*         ******   ******   ******      *      **  *********     *
*                                                                *
******************************************************************
       REM            
*LOW END FOR COTNROL OF FP TRAP AND MANUAL RESTART.
       REM            
       ORG            
       STR            FOR MANUAL RESTART
       TSX SPACE,4    
       TTR RESTR      
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TSX SPACE,4    
       TTR TRAP+1     FOR F. P. TRAP.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       TSX SPACE,4      FOR MONITOR.
       REM            
       REM PROGRAM STARTS AT 30.
       REM            
*SHORT TEST OF EST AND ELD
       REM            
* EST, -0673, ELD, +0670.
       REM            
       REM SHORT LOOP FOR SCOPE.
       REM            
       ORG 24         
9EFP   TRA *+2        
       BCD 1EST       
EST    TSX RESET,4    CLEAR, SET MONITOR.
       STZ SHOP       
       STZ SHOP+1     CLEAR
       PXD            
       LRS 35         
       EST SHOP       ***
       SWT 1          * *
       TRA *+4          *
       TRA *-3        *** REPEAT FOR SCOPING
       BSS 2              FOR FUTURE USE
       TSX OK,4        PROCEED
       TRA EST        
       REM            
       REM CHECK EST STORES ALL BITS
       REM EXCEPT ACC 18-35
       REM            
       BCD 1EST       
ESTA   TSX CLEAR,4    MONITOR
       CLA AONES      LOAD S,1-35
       LDQ AONES      
       STZ SHOP       
       STZ SHOP+1     CLEAR.
       EST SHOP       SET ALL ONES TO STORAGE
       REM EXCEPT FROM ACC 18-35
       NOP            
       TSX CHECK,4    SEE THAT ACC S,1-17, AND
       REM            MQ S,1-35 ARE UNCHANGED.
       OCT 0          
       OCT -377777000000 CORRECT ACC CONTENTS.
       OCT -377777777777 CORRECT MQ CONTENTS
       TRA *+2        PROCEED
       NOP ESTA       
       NOP            
       CLA SHOP       
       LDQ SHOP+1     CHECK STORAGE
       TSX CHECK,4    
       OCT            
       OCT -377777000000 CORRECT ACC CONTENTS
       OCT -377777777777 CORRECT MQ CONTENTS
       TSX OK,4       
       TRA ESTA       
       REM            
       REM CHECK EST, DOES NOT STORE INTO 18-35.
       REM            
       BCD 1EST       
ESTB   TSX CLEAR,4    MONITOR
       NOP            
       CLA AONES      ALL ONES
       STO SHOP       
       NOP            
       PXD            CLEAR ACC
       EST SHOP       SHOULD NOT CLEAR 18-35
       CLA SHOP       
       LDQ SHOP+1     
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 000000777777 CORRECT ACC
       OCT 0          MQ
       TSX OK,4       PROCEED OR
       TRA ESTB       REPEAT
       REM            
       REM SHORT ROUTINE FOR SCOPE
       REM            
       BCD 1ELD       
ELD    TSX CLEAR,4    MONITOR
       PXD            CLEAR
       LRS 35         
       STZ SHOP       
       STZ SHOP+1     
       ELD SHOP       ***
       SWT 1          * *
       TRA *+4          *
       TRA *-1        *** REPEAT FOR SCOPING
       BSS 2          
       TSX OK,4       PROCEED OR
       TRA ELD             REPEAT
       REM            
       REM            
       REM CHECK ELD ALTERNATE ONES, UNLIKE SIGNS
       BCD 1ELD       
ELDA   TSX CLEAR,4    MONITOR
       CLA ALTON      ALTERNATE ONES MINUS
       STO SHOP       
       CLA ALTNP      ALTERNATE ONES PLUS
       STO SHOP+1     
       NOP            
       NOP            FUTURE USE.
       ELD SHOP       
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT -125252525252 CORRECT ACC CONTENTS
       OCT 252525252525 CORRECT MQ CONTENTS
       TSX OK,4       
       TRA ELDA       
*****************************************************************
       REM            
       REM            
       REM            
*SINCE THE EMP INSTRUCTION IS ORED TO PRI OP 2,0 IN IT EXECUTRION,
*A BREIF TEST OF MPY IS PERFORMED BEFORE TESTING THE EMP INST.
       REM            
       REM            
       REM            
       REM            
*       *** BEGINNING MPY TEST****
       REM            
*       ROUTINE FOR SCOPING MPY INSTRUCTION OPERATIONS
       REM            
       BCD 1MPYS      
MPYS   TSX CLEAR,4    
       LDQ BS135      L  -377777777777
       MPY BS135      
       SWT 1          
       TRA MPYA       GO ON
       TRA MPYS+1     REPEAT
       NOP            
       NOP            
       NOP MPYS       
       REM            
       REM            
       REM            
       REM            
*CHECKING FOR ENDING OPERATION IN E TIME WITH ZERO MULTIPLICAND
       REM            
       BCD 1MPY       
       REM  MULT S+   MCND S+
MPYA   TSX CLEAR,4    
       CLA P52S       PUTTING SET PATTERN IN ACC
       LDQ B135       L +377777777777 35 BIT MULT
       MPY K1+1       L +000000000000 35 BIT MCND
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT 000000000000 CONTENTS OF ACC
       OCT 000000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA MPYA       
       REM            
*THE ZERO MULTIPLICAN SHOULD CLEAR ACC AND MQ AND END OP IN E TIME.
*THE OV TRGS SHOULD BE OFF AND COL P AND Q ZERO.
       REM            
       REM  MULT S-   MCND S+
       BCD 1MPY       
MPYB   TSX CLEAR,4    
       LDQ BS135      L -377777777777 MULT S-
       MPY K1+1       L +000000000000 MCAND S+
       TSX CHECK,4    
       OCT 000000000000
       OCT 400000000000 CONTENTS OF ACC
       OCT 400000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA MPYB       
       REM            
*A CHECK IS MADE WITH SIGNS UNLIKE. SINCE A ZERO MULTIPLICAND IS USED
*THE OPERATION SHOULD END IN E TIME WITH BITS IN THE SIGN COLUM
*OF BOTH THE ACC AND MQ. THE OV TRGS SHOULD BE OFF AND COL P AND Q ZERO.
       REM            
       REM            
       REM MULT S+    MCND S-
       BCD 1MPY       
MPYC   TSX CLEAR,4    
       LDQ B135       L +377777777777 MULT S+
       MPY K3+1       L -000000000000 MCAND S-
       TSX CHECK,4    
       OCT 000000000000
       OCT -0         CONT OF ACC
       OCT -0         CONT OF MQ
       TSX OK,4       
       TRA MPYC       
       REM            
* CHECK IS MADE WITH SIGNS UNLIKE AND TRVERSED FROM TEST MPY B.
*THE MACHINE SHOULD END OPN IN E TIME-ZERO MULTIPLICAND-WITH
*BITS IN THE SIGN POSITION OF ACC AND MQ. THE OV TRGS SHOULD BE
*OFF AND COL P AND Q ZERO.
       REM            
       REM            
       REM MULT S-    MCND S-
       BCD 1MPY       
MPYCA  TSX CLEAR,4    
       LDQ D11        L -37777777777 MULT S+
       MPY D10        L -00000000000 MCAND S-
       TSX CHECK,4    
       OCT +0         NO OV, NO P+Q, NO TRAP
       OCT +0         CONT OF ACC
       OCT +0         CONT OF MQ
       TSX OK,4       
       TRA MPYCA      
       REM            
*CHECK IS MADE WITH BOTH SIGNS MINUS. MACHINE SHOULD END OPN IN
*E TIME, ZERO MULTIPLICAND. OV TRGS OFF, COL P+Q ZERO.
*THE FOLLOWING ROUTINES GIVE A GENERAL CHECK OF THE MPY INST.
*THE SHIFT COUNTER IS CHECKED TO SEE IF IT IS SET TO 35, BASE 10.
       REM            
       BCD 1MPY       
MPYD   TSX CLEAR,4    
       LDQ B1235      L +3000000001
       MPY K5+1       L +3000000000
       TSX CHECK,4    
       OCT 000000000000
       OCT 220000000000 CONT OF ACC
       OCT 300000000000 CONT OF MQ
       TSX OK,4       
       TRA MPYD       
       REM            
*THIS ROUTINE CHECKS TO SEE IF SHIFT COUNTER WAS SET TO 35. THIS
*IS INDICATED BY THE PRESENCE OF A BIT IN COL 1 AND 4 OF ACC AND
*COL 1 AND 2 OF MQ IF 35 SHIFTS TOOK PLACE IN OPERATION.
*OV TRG SHOULD BE OFF AND COL P + Q ZERO.
       REM            
       REM            
       REM            
       REM            
       BCD 1MPY       
MPYE   TSX CLEAR,4    
       NOP
       LDQ B135       L +3777777777 35 BIT MULT
       MPY B135                     35 BIT MCND
       NOP            
       TSX CHECK,4    
       OCT 000000000000
       OCT 377777777776 CONTENTS OF ACC
       OCT 000000000001 CONTENTS OF MQ
       TSX OK,4       
       TRA MPYE       
       REM            
*THIS ROUTINE GIVES A GENERAL CHECK OF THE MPY OPERATION, BY USING A
*MULTIPLIER OF ALL ONES AND MULTIPLCAND OF ALL ONES.
       REM            
       REM            
*      *** BEGINNING EMP TEST - 2.07.90 AND 2.07.94 ***
       REM            
       REM            
*      CLOSED ROTUINE FOR SCOPING EMP
       REM            
       BCD 1EMP       
EMPS   TSX CLEAR,4    
       CLA EMPSA      
       LDQ EMPSA+1    
       EMP EMPSA      
       SWT 1          
       TRA EMPA       GO ON
       TRA EMPS+1     REPEAT
EMPSA  OCT 040000000000
       OCT 477777777777
       NOP            
       NOP            
       NOP EMPS       FOR DEPR
       REM            
       REM            
       REM            
       REM            
*CHECKING FOR ENDING OPERATION IN E TIME WITH ZERO MULTIPLICAN
*CHECKING SIGN CONTROLS, SIGNS ALIKE.
       REM            
       REM  MULT S+   MCND S+
       BCD 1EMP       
EMPA   TSX CLEAR,4    
       NOP            
       CLA K4         L+040000000000 CH MULT 3-17
       LDQ K4+1       L-07777777777 FR MULT 1-35
       EMP K1         L+040000000000 CH MCND 3-17.
       REM            L+000000000000 FR MCND 1-35
       NOP            
       TSX CHECK,4    PROGRAM CHECK ROUTINE
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT 000000000000 CONTENTS OF ACC
       OCT 000000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPA       
*WITH ZERO MULTIPLICAND THE MACHINE SHOULD END OPN IN E TIME. THIS
*CHECK IS MADE BY ORING INTO PRI OP 2,0-MPY. 2.07.94.
*CHECKING SIGN CONTROLS, SIGNS UNLIKE.
       REM  MULT S-   MCND S+
       BCD 1EMP       
EMPB   TSX CLEAR,4    MONITOR AND RESET
       NOP            
       CLA K2         L-040000000000 CH MULT 3-17
       LDQ K2+1       L+000000000000 FR MULT 1-35
       EMP K1         L+040000000000 CH MCND 3-37
       REM            L+000000000000 FP MCND 1-35
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT 400000000000 CONTENTS OF ACC
       OCT 400000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPB       
*THE SIGNS WERE UNLIKE SO THAT SIGN OF QUOTIENT SHOULD BE MINUS
       REM            
       REM            
*CHECK SIGN CONTROL, SIGNS UNLIKE.
       REM MULT S+    MCND S-
       BCD 1EMP
EMPC   TSX CLEAR,4    MONITOR AND RESET
       NOP            
       CLA K3         L+040000000000 CH MULT 3-17
       LDQ K3+1       L-000000000000 FR MULT 1-35
       EMP K2         L-040000000000 CH MCND 3-17
       REM            L+000000000000 FP MCND 1-35
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT -0         CONT ACC
       OCT -0         CONT MQ
       TSX OK,4       
       TRA EMPC       
       REM            
       REM            
*CHECK SIGN CONTROLS, SIGNS ALIKE
       REM MULT S-    MCND S-
       BCD 1EMP
EMPC1  TSX CLEAR,4    MONITOR AND RESET
       NOP            
       CLA K2         L-040000000000 CH MULT 3-17
       LDQ K2+1       L+000000000000 FR MULT 1-35
       EMP K2         L-040000000000 CH MCND 3-17
       REM            L+000000000000 FP MCND 1-35
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT 000000000000 CONTENTS OF ACC
       OCT 000000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPC1      
       REM            
       REM            
*CHECKING EMP WITH BIT IN COL 1 OF ACC AFTER MULTIPLY OPERATION.
*NO TRAPPING OR OVERFLOW.
       REM            
       BCD 1EMP       
EMPD   TSX CLEAR,4    
       NOP            
       CLA K5         L+040000000000 CH MULT 3-17
       LDQ K5+1       L+300000000000 FR MULT 1-35
       EMP K5         MULTIPLICAND
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT 040000000000 CONTENTS OF ACC
       OCT +220000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPD       
       REM            
*WITH A BIT IN COL 1 OF ACC AFTER MPY OPERATION, THE
*FRACTION WOULD NOT HAVE TO BE SHIFTED LEFT AND CHAR REDUCED
*BY ONE.              
       REM            
       REM            
*CHECKING EMP WITH NO BIT IN COL 1 OF ACC AFTER MULTIPLY OPERATION.
*NO TRAPPING OR OVERFLOWS.
       REM            
       BCD 1EMP       
EMPE   TSX CLEAR,4    
       NOP            
       CLA K6         L+040000000000 CH MULT 3-17
       LDQ K6+1       L+200000000000 FR MULT 1-35
       EMP K6         MULTIPLICAND
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +037777000000 CONTENTS OF ACC
       OCT 200000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPE       
       REM            
*WITH NO BIT IN COL 1 OF ACC AFTER MULTIPLY OPERATION,
*THE FRACTION WOULD HAVE TO BE SHIFTED LEFT AND CHARACTERISTIC
*REDUCED BY ONE.      
       REM            
       REM            
*CHECKING TO SEE IF EMP WILL END OPERATION WITH FRACTION
*OF PRODUCT ZERO. NO TRAPPING OR OVERFLOWS.
       REM            
       BCD 1EMP       
EMPF   TSX CLEAR,4    
       NOP            
       CLA K9         L+040000000000 CH MULT 3-17
       LDQ K9+1       L+000000000001 FR MULT 1-35
       EMP K9         
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT 000000000000 CONTENTS OF ACC
       OCT 000000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPF       
       REM            
*WITH THE FRACTION OF THE PRODUCT ZERO, THE
*ACC IS CLEARED TO GIVE A ZERO CHARACTERISTIC
       REM            
       REM            
       REM            
       REM            
       REM            
*CHECKING EMP USING AN UNNORMALIZED FRACTIONS. NO TRAPPING OR OVERFLOWS.
       REM            
       BCD 1EMP       
EMP1   TSX CLEAR,4    MONITOR
       NOP            
       ELD UEP4       CH +40,002 FR .1 DEC4
       EMP UEP16      CH +40,004 FR .1 DEC16
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040005000000 CONT ACC
       OCT +040000000000 CONT MQ
       TSX OK,4       CONTINUE TEST
       TRA EMP1       REPEAT TEST
       REM            
*AFTER MPY OPER, THE CH RED BY ONE AND FR LT SHIFTED. FINAL RESULT
*IS STILL UNNORMAILIZED.
       REM            
       REM            
*CHECK EMP FOR OPERATION. ONE FACTORE UNNORMALIZED.
*MULT E6 TIME E6 TO GIVE E12.
       BCD 1EMP       
EMP2   TSX CLEAR,4    
       NOP            
       ELD UEPE6      CH +40,025 FR .172044
       EMP EPE6       CH +40,024 FR .364110
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040050000000 CONT ACC
       OCT +350651224200 CONT MQ
       TSX OK,4       
       TRA EMP2       
       REM            
*CHECK EMP FOR OPERATION
       REM            
       BCD 1EMP       
EMP3   TSX CLEAR,4    MONITOR
       NOP            
       ELD EPE8       CH +40,033 FR +.2765702
       EMP EPE6       CH +40,024 FR +.3641100
       EMP EPE1       CH +40,004 FR +.24
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040062000000 CONT ACC
       OCT +343277244615 CONT MQ
       TSX OK,4       
       TRA EMP3       
       REM            
*CHECK EMP WITH CONDITION OF OVERFLOW UNTIL CH IS REDUCED BY ONE.
       REM            
       BCD 1EMP       
EMP6   TSX CLEAR,4    MONITOR
       NOP            
       CLA B135       CH +77,777 MULT
       LDQ K6+1       FR + .2 MULT
       EMP EPE0       CH +40,001 FR .2 MCND
       NOP             
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +077777000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EMP6       
       REM            
*CHECK EMP FOR CONDITION OF UNDERFLOW AFTER CHAR RED BY ONE.
*MAHCINE WILL BE IN 704 MODE. BITS IN P AND Q SHOULD SET
*ACC AND MQ OV TRGS.  
       REM            
       BCD 1EMP       
EMP7   TSX CLEAR,4    MONITOR
       NOP            
       LFTM           LEAVE 709 FP TRAP MODE.
       CLA K1+1       CH +00,000 MULT
       LDQ K6+1       FR +.2    MULT
       EMP K6         CH +40,000  FR .2 MCND
       NOP            
       TSX CHECK,4    
       OCT -200003000000 AC + MQ OV, P+Q BITS
       REM            NO TRAP.
       OCT +377777000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EMP7       
       REM            
*CHECKING EMP WITH OVERFLOW WITHOUT TRAPPING. BIT IN COL 2
*SHOULD SET ACC OV TRG. P AND Q SHOULD BE ZERO.
       REM            
       REM *704 TRAPPING MODE*
       BCD 1EMP       
EMPG   TSX CLEAR,4    
       NOP            
       LFTM           LEAVE 709 FP TRAP MODE.
       CLA K7         L+070000000000 CH MULT 3-17
       LDQ K7+1       L+200000000000 FR MULT 1-35
       EMP K7         MULTIPLICAND
       NOP            
       TSX CHECK,4    
       OCT 400000000000 AC OV TRG ON
       OCT +117777000000 CONTENTS OF ACC
       OCT +200000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPG       
       REM            
*THE CHARACTERISTICS OF THE FLOATING POINT NUMBERS USED ARE SUCH THAT
*THEY SHOULD CAUSE AN OVERFLOW WITH A BIT IN COL 2 OF ACC. THE
*AC OV TRG SHOULD BE TURNED ON. COL P AND Q OF ACC SHOULD BE ZERO.
*BIT IN COL 2 OF ACC AFTER MPY OPER - ACC LT SHIFT 1 - CH RED BY 1.
       REM            
*CHECKING EMP WITH UNDERFLOW WITHOUT TRAPPING. BITS IN COL
*P AND Q SHOULD SET AC AND MQ OV TRG
       REM            
       BCD 1EMP       
EMPH   TSX CLEAR,4    
       NOP            
       LFTM           LEAVE 709 FP TRAP MODE.
       CLA K8         L+010000000000 CH MULT 3-17
       LDQ K8+1       L+200000000000 FR MULT 1-35
       EMP K8         MULTIPLICAND
       NOP            
       TSX CHECK,4    
       OCT -200003000000 ACC + MQ OV, P+Q ON,
       REM            NO TRAP
       OCT +357777000000 CONTENTS OF ACC
       OCT +200000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPH       
       REM            
*THE CHARACTERISTICS OF THE FLOATING POINT NUMBERS USED ARE SUCH 
*THAT THEY SHOUKLD CAUSE AN UNDERFLOW WITH BITS IN COL P AND Q OF ACC.
*BOTH THE AC AND MQ OV TRG SHOULD BE TURNED ON.
*CHECKING EMP WITH OERFLOW WITH TRAPPING.
       REM            
       BCD 1EMP-      
EMPJ   TSX CLEAR,4    
       AXT EMPJA,2    
       SXA TRAP,2     
       NOP            
       CLA K7         L+070000000000 CH MULT 3-17
       LDQ K7+1       L+200000000000 FR MULT 1-35
       EMP K7         MULTIPLICAND
       NOP            
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
EMPJA  TSX CHECK,4    
       PZE EMPJA-3,1 NO OV, NO PQ, ADDRESS
       REM            AND COL 15 OF ZERO.
       OCT +117777000000 CONTENTS OF ACC
       OCT +200000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPJ       
       REM            
*THE CHARACTERISTICS OF THE FLOATING POINT NUMBERS USED ARE SUCH THAT
*WILL CAUSE AN OVERFLOW WITH A BIT IN COL 2 OF ACC. THE MACHINE
*WILL STORE THE LOCATION OF EMP+1 INTO LOCATION 00000 AND TRAP TO
*LOCATION 00010. COL P AND Q OF ACC SHOULD BE ZERO. THIS OV
*CONDITION SHOULD SET A BIT IN COL 15 OF L 00000.
       REM            
*CHECKING EMP WITH UNDERFLOW WITH TRAPPING. 
       REM            
       BCD 1EMP-      
EMPK   TSX CLEAR,4    
       AXT EMPKA,2    
       SXA TRAP,2     
       NOP            
       CLA K8         L+010000000000 CH MULT 3-17
       LDQ K8+1       L+200000000000 FR MULT 1-35
       EMP K8         MULTIPLICAND
       NOP            
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
EMPKA  TSX CHECK,4    
       PZE EMPKA-3,3,3 NO OV, PQ BITS, ADDR
       REM            + COLS 14+15 OF ZERO.
       OCT +357777000000 CONTENTS OF ACC
       OCT +200000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPK       
       REM            
*CHECKING EMP WITH INDEXING, NO TRAPPING
       REM            
       BCD 1EMP       
EMPL   TSX CLEAR,4    
       NOP            
       CLA K5         K5  +040000000000 CH 3-17
       LDQ K5+1       K5+1 +3000000000000 FR 1-35
       AXT -3,1       
       EMP K5-3,1     
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040000000000  CONT ACC
       OCT +220000000000 CONT MQ
       TSX OK,4       
       TRA EMPL       
       REM            
*CHECKING EMP WITH INDEXING, TRAPPING ON OVERFLOW.
       REM            
       BCD 1EMP-      
EMPM   TSX CLEAR,4    
       AXT EMPMA,2    
       SXA TRAP,2     
       NOP            
       AXT 3,1        
       CLA K7         L+070000000000 CH MULT 3-17
       LDQ K7+1       L+200000000000 FR MULT 1-35
       EMP K7+3,1     MULTIPLICAND
       NOP            
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
EMPMA  TSX CHECK,4    
       PZE EMPMA-3,1 NO OV, NO PQ, ADDRESS
       REM            AND COL 15 OF ZERO.
       OCT +117777000000 CONTENTS OF ACC
       OCT +200000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPM       
       REM            
*CHECKING EMP WITH INDIRECT ADDRESSING, NO TRAPPING.
       REM            
       BCD 1EMP       
EMPN   TSX CLEAR,4    
       NOP            
       CLA K5         K5  +040000000000 CH 3-17
       LDQ K5+1       K5+1 +3000000000000 FR 1-35
       EMP* *-2       
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040000000000  CONT ACC
       OCT +220000000000 CONT MQ
       TSX OK,4       
       TRA EMPN       
       REM            
*CHECKING EMP WITH INDIRECT ADDRESSING, TRAPPING ON OVERFLOW.
       REM            
       BCD 1EMP-      
EMPO   TSX CLEAR,4    
       AXT EMPOA,2    
       SXA TRAP,2     
       NOP            
       CLA K7         L+070000000000 CH MULT 3-17
       LDQ K7+1       L+200000000000 FR MULT 1-35
       EMP* *-2,1     MULTIPLICAND
       NOP            
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
EMPOA  TSX CHECK,4    
       PZE EMPOA-3,1 NO OV, NO PQ, ADDRESS
       REM            AND COL 15 OF ZERO.
       OCT +117777000000 CONTENTS OF ACC
       OCT +200000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPO       
       REM            
*CHECKING EMP WITH INDEXING, INDIRECT ADDRESSING , AND USING EXECUTE.
*          TRAPPING ON OVERFLOW.
       REM            
       BCD 1EMP-      
EMPP   TSX CLEAR,4    
       AXT EMPPT,2    
       SXA TRAP,2     
       NOP            
       AXT 3,1        
       CLA K7         L+070000000000 CH MCNDT 3-17
       LDQ K7+1       L+200000000000 FR MULT 1-35
EMPPA  XEC EMPPX      MULTIPLICAND
       NOP            
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
       TRA EMPPT      
       NOP            
       NOP K7         SAVE ADDRESS.
EMPPX  EMP* *+2,1     
       NOP            
       NOP            
EMPPT  TSX CHECK,4    
       PZE EMPPA+1,1 NO OV, NO P+Q, ADDRESS
       REM            AND COL 15 OF ZERO.
       OCT +117777000000 CONTENTS OF ACC
       OCT +200000000000 CONTENTS OF MQ
       TSX OK,4       
       TRA EMPP       
       REM            
*CHECKING NORMALIZING CONTROLS. FRACTION ZERO UNTIL ACC AND MQ
*ARE LEFT SHIFTED ONE COLUMN.
       REM            
       BCD 1EMP       
EMP5   TSX CLEAR,4    MONITOR
       NOP            
       ELD EPE0       CH+40,001 FR .2
       EMP UEP1       CH+40,043 FR .000000000001
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040043000000 CONT ACC
       OCT +000000000001 CONT MQ
       TSX OK,4       CONTINUE TEST
       TRA EMP5       REPEAT TEST
       REM            
*CHECKING CONTINIOUS EMP OPERATION. SIGNS ALIKE.
       REM            
       BCD 1EMP       
EMP4   TSX CLEAR,4    MONITOR
       NOP            
       ELD EPE1       CH +40,004 FR .24
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       CHS            
       NOP            
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       CHS            
       NOP            
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       EMP EPE1       
       NOP            
       TSX CHECK,4
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040071000000 CONT ACC
       OCT +261505360566 CONT MQ
       TSX OK,4       
       TRA EMP4       
       REM            
*THE SOLUTION TO EACH EMP OPER CAN BE OBTAINED FROM CONSTANT AREA BY
*ADDING THE NUMBER OF E1S AND LOOKING AT CORRESPONDING EPE-- CONST.
       REM            
**************************************************************************
       REM            
*                *************BEGINNING EDP TEST**********
       REM            
**************************************************************************
       REM            
*SINCE THE EDP IS ORED TO PRI OPN 2,2 IN ITS EXECUTION, A BRIEF TEST
*OF DVP IS PREFORMED BEFORE THE TESTING OF EDP.
*EDP IS ORED TO THE PRI OPN 2,2 DURING-
*          1- 2ND E TIME OF EDP            E TIME OF DVP
*          2- STEP 1, ER TIME OF EDP       CYCLE 1, ER TUME OF DVP
*          3- STEP 2, ER TIME OF EDP       CYCLE 2-18, ER TIME OF DVP
       REM            
*                        ***TESTING DVP***
       REM            
*          *** CLOSED ROUTINE FOR SCOPING THE DVP INSTRUCTION ***
       REM            
       BCD 1DVP       
DVPS   TSX CLEAR,4    
       CLA DVPSA      
       LDQ DVPSA+1    
       DVP DVPSA+2    
       SWT 1          
       TRA DVPA       UP-GO ON
       TRA DVPS+1     DN-RETURN
DVPSA  OCT +052525252525 ACC  72 BIT
       OCT +252525252525 MQ  DIVIDEND.
       OCT -000000000002 SR  DIVISOR
       OCT +000000000000 ACC  REMAINDER
       OCT -125252525252 MQ  QUOTIENT
       NOP DVPS       FOR DEPR
       REM            
* **CHECKING OPERATION OF DIV CK TO FUNCTION TO CAUSE END OPERATION
       REM IN THE 1ST ER CYCLE.
       REM  SIGNS ALIKE ACC S+ SR S+
       BCD 1DVP       
DVPA   TSX CLEAR,4    MONITOR AND RESET
       NOP            
       CLA D1         L+200000000000 70 BIT
       LDQ D2         L+252525252525 DIVIDEND.
       DVP D1             35 BIT DIVISOR.
       NOP            
       DCT            
       TRA DVPAA      LITE ON - OK - CHECK RESULT
       TSX ERROR-1,4  LITE OFF - FAILED TO
       NOP DCTER      TURN ON DIV CK TRG.
DVPAA  TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +200000000000  CONT ACC
       OCT +252525252525  CONT MQ
       TSX OK,4       PROCEED
       TRA DVPA       REPEAT
       REM            
* SINCE THE ACC PORTION OF THE DIVIDENT IS EQUAL TO THE DIVISOR, THE
*OPERATION SHOULD NOT TURN ON THE Q CARRY TRG. WITH T1 ON THE
*DIV CHECK TRG SHOULD BE TURNED ON AT ER5 D1. AN ERROR IS
*INDICATED BY TWO PRINTOUTS IF THE DIV CHECK TRG DID NOT COME ON
*AND CONTENTS OF ACC AND MQ DID NOT CHECK CORRECTLY.
       REM            
       REM            
*FOLLOWING THREE ROUTINES CHECK THE SIGN CONTROLS FOR OPERATION.
*THE VALUES FOR THE DIVISO AND DIVIDEND WERE CHOSEN TO TURN ON
* THE DIV CK TRG, TO END OPER IN 1ST ER TIME.
       REM            
       REM SIGNS ALIKE  ACC S-  SR S-
       BCD 1DVP       
DVPB   TSX CLEAR,4    MONITOR AND RESET
       NOP            
       CLA D3         L-2000000000000  70 BIT DVD.
       LDQ D3         L-2000000000000
       DVP D3         L-2000000000000  DIVISOR
       NOP            
       DCT            
       TRA DVPBA      LITE ON- OK - CHECK RESULTS
       TSX ERROR-1,4  LITE OFF - FAILED TO 
       NOP DCTER      TURN ON DIV CK TGR.
DVPBA  TSX CHECK,4    PROG CHECK ROUTINE.
       OCT +0         NO OV, NO P+Q, NO TRAP.
       OCT -200000000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       PROCEED
       TRA DVPB       REPEAT
       REM            
*SINCE THE ACC AND SR SIGNS ARE BOTH MINUS, THE MQ S IS CLEARED.
       REM            
* CHECKING SIGN CONTROLS. DIV CK TGR IS TURNED ON AND CHECKED.
* ACC PORTION OF DVD GREATER THEN DIV - CONT OF SR.
       REM SIGNS UNLIKE  ACC S+    SR S-
       BCD 1DVP       
DVPC   TSX CLEAR,4    MONITOR AND RESET
       NOP            
       CLA D2         L+252525252525  70 BIT
       LDQ D4         L+000000000000   DVD.
       DVP D3         L-200000000000  DIV
       NOP            
       DCT            
       TRA DVPCA      LITE ON- OK - CHECK RESULTS
       TSX ERROR-1,4  LITE OFF- FAILED TO
       NOP DCTER      TURN ON DIV CK TRG.
DVPCA  TSX CHECK,4    PROG CHECK ROUTINE.
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +252525252525  CONT ACC
       OCT -0             CONT MQ
       TSX OK,4       PROCEED
       TRA DVPC       
       REM            
*SINCE THE ACC S + AND SR S -, THE MQ S IS CLEARD AND
*MINUS TO MQ S.       
       REM            
* CHECKING SIGN CONTROLS. DIV CK TRG IS TURNED ON AND CHECKED.
* ACC PORTION OF DVD GREATER THEN DIV - CONT OF SR.
       REM SIGNS UNLIKE    ACC S-   SR S+
       BCD 1DVP       
DVPD   TSX CLEAR,4    
       NOP            
       CLA D3         L-200000000000   70 BIT DVD
       LDQ D2         L+252525252525  MQ DVD
       DVP D29+1      L+100000000001   DIVISOR
       NOP            
       DCT            
       TRA DVPDA      LITE ON- OK - CHECK RESULTS
       TSX ERROR-1,4  LITE OFF-  FAILED TO
       NOP DCTER      TURN ON DIV CK TRG.
DVPDA  TSX CHECK,4    PROG CHECK ROUTINE.
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT -200000000000  CONT ACC
       OCT -252525252525  CONT MQ
       TSX OK,4       PROCEED
       TRA DVPD       REPEAT
       REM            
*WITH THE ACCS - AND SR+, THE MQ S IS CLEARED AND THE MQ S IS
*MADE MINUS.          
       REM            
*CHECKING OPERATION OF DIVISION DURING ITS REDUCTION CYCLES.
       REM            
       BCD 1DVP       
DVPE   TSX CLEAR,4    
       NOP            
       CLA D4         L+000000000000 ACC DVD
       LDQ D1         L+200000000000 MQ DVD
       DVP D5         L+000000000002  SR DIV
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +0              CONT ACC
       OCT +100000000000 CONT MQ
       TSX OK,4       PROCEED
       TRA DVPE       
       REM            
*CHECKING REDUCTION CYCLES.
       REM            
       BCD 1DVP       
DVPF   TSX CLEAR,4    
       NOP            
       CLA D4           L+000000000000 ACC DVD S+
       LDQ D2         L+252525252525 MQ DVD
       DVP D5         L+000000000002 SR DIV
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +1              CONT ACC
       OCT +125252525252 CONT MQ
       TSX OK,4       PROCEED
       TRA DVPF       
       REM            
*CHECKING REDUCTION CYCLES.
       REM            
       BCD 1DVP       
DVPG   TSX CLEAR,4    
       NOP            
       CLA D10          L-000000000000 ACC DVD S-
       LDQ D11        L+377777777777 MQ DVD S+
       DVP D9         L+000000000001 SR DIV S+
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT -000000000000 CONT ACC
       OCT -377777777777 CONT MQ
       TSX OK,4       PROCEED
       TRA DVPG       
       REM            
*CHECKING REDUCTION CYCLES WITH A REMAINDER, QUOTIENT ZERO.
       REM            
       BCD 1DVP       
DVPH   TSX CLEAR,4    
       NOP            
       CLA D4           L+000000000000 ACC DVD S+
       LDQ D8         L-125252525252 MQ DVD S-
       DVP D1         L+200000000000
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +125252525252 CONT ACC
       OCT +0                CONT MQ
       TSX OK,4       PROCEED
       TRA DVPH       
       REM            
***********************************************************************
       REM            
*ASSUMING FIXED POINT DIVISION IS FUNCTIONAL, THE TEST FOR THE
*EDP INSTRUCTION WILL BEGIN. SYSTEMS 2.07.95 AND 2.07.96.
*EDP --- +0672        
       REM            
***********************               *********************************
       REM            
*      CLOSED ROUTINE FOR SCOPING EDP INSTRUCTION.
       REM            
       BCD 1EDP       
EDPS   TSX CLEAR,4    
       CLA EDPSA      
       LDQ EDPSA+1    
       EDP EDPSA+2    
       SWT 1          
       TRA EDPA       UP PROCEED
       TRA EDPS+1     DN REPEAT
EDPSA  OCT +040000000000 CH DVD 3-17
       OCT -200000000000 FR DVD 1-35
       OCT -040000000000 CH DIV 3-17
       OCT +200000000000 FR DIV 1-35
       NOP EDPS       FOR DEPR
       REM            
*TESTING FOR ZERO MQ, DIVIDEND FRACTION. WILL RESET ACC S-35
*AND MQ S-35 TO ZERO AND END OPN AT E10. 2.07.95 EDP T10FF.
       REM            
       BCD 1EDP       
EDPA   TSX CLEAR,4    
       CLA D12        L+347777777777 CH DVD 3-17
       LDQ D10        L-000000000000  FR DVD 1-35
       EDP D13        L+030000000000  CH DIV 3-17
       REM            L-200000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +0         CONT ACC
       OCT +0         CONT MQ
       TSX OK,4       
       TRA EDPA       
       REM            
*TESTING EDP FOR DIV CK.  COL 1,2 OF ACC WORD CLEARED, COL 18-35 OF ACC
* WORD SET TO ALL ONES.  A DIV CK WILL BE MADE.
       REM            
       BCD 1EDP       
EDPB   TSX CLEAR,4    
       CLA D12        L+347777777777 CH DVD 3-17
       LDQ D16        L+377777777777 FR DVD 1-35
       EDP D17        L+040000000000 CH DIV 3-17
       REM            L+100000000000 FR DIV 1-35
       DCT            
       TRA EDPBA      ON-CHECK RESULTS
       TSX ERROR-1,4  OFF-FAILED TO TURN
       NOP DCTER        ON DIV CK TGR
EDPBA  TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +047777777777  CONT ACC
       OCT +377777777777 CONT MQ
       TSX OK,4       
       TRA EDPB       
       REM            
*TESTING EDP FOR DIV CK.  COL 1,2 OF ACC WORD CLEARED, COL 18-35 OF ACC
* WORD SET TO ALL ONES.  A DIV CK WILL BE MADE.
* A CHECK OF THE SIGN CONTROLS IS MADE.
       REM SIGNS ALIKE  ACC S+   SR S-
       BCD 1EDP       
EDPC   TSX CLEAR,4    
       CLA D14        L+040000000000 CH DVD 3-17
       LDQ D11        L-377777777777 FR DVD 1-35
       EDP D18        L+040000000000 CH DIV 3-17
       REM            L-100000000000 FR DIV 1-35
       DCT            
       TRA EDPCA      ON CK RESULTS
       TSX ERROR-1,4  OFF-FAILED TO TURN
       NOP DCTER        ON DIV CK TGR
EDPCA  TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040000777777  CONT ACC
       OCT +377777777777 CONT MQ
       TSX OK,4       
       TRA EDPC       
       REM            
*CHECKING DCT. THE DIV CK TGR SHOULD NOT COME ON. THE
*ADDERS HAVE TO RIPPLE DOWN BEFORE Q CARRY TRG TURNS ON.
*A CHECK WILL BE MADE OF THE COND OF DIV CK TRG.
*NO TRAPPING OR OVER OR UNDERFLOWS.
       REM            
       BCD 1EDP       
EDP1   TSX CLEAR,4    MONITOR AND RESET
       NOP            
       CLA D29        L+243210323232 CH DVD 3-17
       LDQ D1         L+200000000000 FR DVD 1-35
       EDP D29        L+243210323232 CH DIV 3-17
       REM            L+100000000001 FR DIV 1-35
       NOP            
       DCT            TGR SHOULD BE OFF
       TSX ERROR-1,4  ON-  IN ERROR
       NOP DCTER        OFF- OK -GO ON.
EDP1A  TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040001000000 CONT ACC
       OCT +377777777774 CONT MQ
       TSX OK,4       
       TRA EDP1       
       REM            
*CHECKING EDP ON DIVIDE CHECK.
       REM            
       BCD 1EDP       
EDPC1  TSX CLEAR,4    MONITOR AND RESET
       CLA D30        L+112345232323 CH DVD 3-17
       LDQ D16        L+377777777777 FR DVD 1-35
       EDP D30        L+112345232323 CH DIV 3-17
       REM            L+100000000000 FR DIV 1-35
       DCT            TGR SHOULD BE ON-
       TRA EDPC2      ON- CK RESULTS
       TSX ERROR-1,4  OFF- FAILED TO TURN
       NOP DCTER      ON DIV CK TRG.
EDPC2  TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +012345777777 CONT ACC
       OCT +377777777777 CONT MQ
       TSX OK,4       
       TRA EDPC1      
       REM            
*THE CH OF THE DVD IS EQUAL TO CH DIV *ACC EQUAL SR*.
*NO Q CARRY. AFTER DIVISION MQ COL 1 EQUAL 1.
*THE CHAR SHOULD BE INCR BY ONE. NO MQ LT SHIFT.
       REM            
       BCD 1EDP       
EDPD   TSX CLEAR,4    
       CLA D20        L+0400000000 CH DVD 3-17
       LDQ D20+1      L+2000000000 FR DVD 1-35
       EDP D20        L+0400000000 CH DIV 3-17
       REM            L+2000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040001000000  CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPD       
       REM            
*THE CH OF THE DVD IS EQUAL TO CH DIV *ACC EQUAL SR*.
*NO Q CARRY. AFTER DIVISION MQ COL 1 EQUAL 0.
*MQ FR SHOULD BE LT SHIFTED ONE. NO INCR IN CHAR.
       REM            
       BCD 1EDP       
EDPE   TSX CLEAR,4    
       CLA D20        L+0400000000 CH DVD 3-17
       LDQ D20+1      L+2000000000 FR DVD 1-35
       EDP D21        L+0400000000 CH DIV 3-17
       REM            L+3000000000 FT DIV 1-35
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040000777777 CONT ACC
       OCT +252525252524  CONT MQ
       TSX OK,4       
       TRA EDPE       
       REM            
*THE CH OF THE DVD IS LESS THEN CH DIV*ACC LESS THEN SR*.
*Q CARRY. AFTER DIVISION MQ COL 1 EQUAL 1.
*THE CHAR SHOULD BE INCR BY ONE. NO MQ LT SHIFT.
       REM            
       BCD 1EDP       
EDPF   TSX CLEAR,4    
       CLA D13        L+03000000000 CH 3-17 DVD
       LDQ D1         L+20000000000 FR 1-35 DVD
       EDP D20        L+04000000000 CH 3-17 DIV
       REM            L+20000000000 FR 1-35 DIV
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +030001000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,5       
       TRA EDPF       
       REM            
*THE CH OF THE DVD IS LESS THEN CH DIV*ACC LESS THAN SR.
*Q CARRY. AFTER DIVISION MQ COL 1 EQUAL 0.
*MQ FR SHOULD BE LT SHIFTED ONE. NO INCR IN CHAR.
       REM            
       BCD 1EDP       
EDPG   TSX CLEAR,4    
       CLA D13        L+030000000000 CH DVD 3-17
       LDQ D1         L+200000000000 FR DVD 1-35
       EDP D21        L+040000000000 CH DIV 3-17
       REM            L+300000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +030000777777 CONT ACC
       OCT +252525252524  CONT MQ
       TSX OK,4       
       TRA EDPG       
       REM            
*CHECKING SIGN CONTROLS. SIGNS UNLIKE.
       REM   ACC  DVD S-     SR DIV S+
       BCD 1EDP       
EDPH   TSX CLEAR,4    
       CLA D19        L-0400000000 CH DVD 3-17
       LDQ D20+1      L+2000000000 FR DVD 1-35
       EDP D22        L+0400000000 CH DIV 3-17
       REM            L-2000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT -040001000000  CONT ACC
       OCT -200000000000  CONT MQ
       TSX OK,4       
       TRA EDPH       
       REM            
*CHECKING SIGN CONTROLS. SIGNS UNLIKE.
       REM   ACC  DVD S+     SR DIV S-
       BCD 1EDP       
EDPI   TSX CLEAR,4    
       CLA D20        L+0400000000 CH DVD 3-17
       LDQ D20+1      L+2000000000 FR DVD 1-35
       EDP D23        L-0400000000 CH DIV 3-17
       REM            L-2000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT -040001000000  CONT ACC
       OCT -200000000000  CONT MQ
       TSX OK,4       
       TRA EDPI       
       REM            
*CHECKING SIGN CONTROLS. SIGNS ALIKE.
       REM   ACC  DVD S-     SR DIV S-
       BCD 1EDP       
EDPJ   TSX CLEAR,4    
       CLA D19        L-0400000000 CH DVD 3-17
       LDQ D20+1      L+2000000000 FR DVD 1-35
       EDP D24        L-0400000000 CH DIV 3-17
       REM            L+2000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040001000000  CONT ACC
       OCT +200000000000  CONT MQ
       TSX OK,4       
       TRA EDPJ       
       REM            
*CHECKING SIGN CONTROLS. SIGNS ALIKE.
       REM   ACC  DVD S+     SR DIV S+
       BCD 1EDP       
EDPK   TSX CLEAR,4    
       CLA D22        L+0400000000 CH DVD 3-17
       LDQ D22+1      L-2000000000 FR DVD 1-35
       EDP D22        L+0400000000 CH DIV 3-17
       REM            L-2000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040001000000  CONT ACC
       OCT +200000000000  CONT MQ
       TSX OK,4       
       TRA EDPK       
       REM            
*CHECKING OVERFLOW WITHOUT TRAPPING. *704 TRAPPING MODE*
*ACC OV LITE SHOULD COME ON. NO P OR Q.
       REM            
       BCD 1EDP       
EDPL   TSX CLEAR,4    
       LFTM           LEAVE 709 FP TRAP MODE
       CLA D26        L+077777000000 CH DVD 3-17
       LDQ D25+1      L+200000000000 FR DVD 1-35
       EDP D25        L+007000000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT 400000000000 AC OV TRG ON
       OCT +131000000000  CONT ACC CH QUOT
       OCT +200000000000 CONT MQ FR QUOT
       TSX OK,4       
       TRA EDPL       
       REM            
*CHECKING UNDERFLOW WITHOUT TRAPPING. *704 TRAPPING MODE*
*ACC OV AND MQ OV LITES SHOULD COME ON. P OR Q.
       REM            
       BCD 1EDP       
EDPM   TSX CLEAR,4    
       LFTM           LEAVE 709 FP TRAP MODE
       CLA D25        L+070000000000 CH DVD 3-17
       LDQ D25+1      L+200000000000 FR DVD 1-35
       EDP D26        L+077777000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT 600003000000 AC AND MQ OV, P AND Q ON
       OCT +347002000000 CONT ACC CH QUOT
       OCT +200000000000 CONT MQ FR QUOT
       TSX OK,4       
       TRA EDPM       
       REM            
*CHECKING OVERFLOW WITHOUT TRAPPING. *704 TRAPPING MODE*
*OVERFLOW SHOULD NOT OCCUR UNTIL CHAR IS INCREASED.
*ACC OV LITE SHOULD COME ON. NO P OR Q.
       REM            
       BCD 1EDP       
EDPN   TSX CLEAR,4    
       LFTM           LEAVE 709 FP TRAP MODE
       CLA D26        L+077777000000 CH DVD 3-17
       LDQ D26+1      L+200000000000 FR DVD 1-35
       EDP D20        L+040000000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT -0         AC OV ON
       OCT +100000000000 CONT ACC CH QUOT
       OCT +200000000000 CONT MQ FR QUOT
       TSX OK,4       
       TRA EDPN       
       REM            
*CHECKING OVERFLOW TRAPPING. *709 MODE*
*NO OV LITES. NO P OR Q.
*A BIT IN COL 15 AND INST CTR SHOULD BE STORED IN LOC 00000.
       REM            
       BCD 1EDP       
EDPO   TSX CLEAR,4    
       AXT EDPOT,2    
       SXA TRAP,2     
       CLA D26        L+077777000000 CH DVD 3-17
       LDQ D25+1      L+200000000000 FR DVD 1-35
       EDP D25        L+007000000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
EDPOT  TSX CHECK,4    
       PZE EDPOT-2,1  NO OV, NO P+Q, ADDRESS
       REM             AND COL 15 ON LOC ZERO.
       OCT +131000000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPO       
       REM            
*CHECKING UNDERFLOW TRAPPING. *709 MODE*
*NO OV LITES. P OR Q. 
*BITS IN COL 14 AND 15, AND INST CTR SHOULD BE STORED IN LOC 00000.
       REM            
       BCD 1EDP       
EDPP   TSX CLEAR,4    
       AXT EDPPT,2    
       SXA TRAP,2     
       CLA D25        L+007000000000 CH DVD 3-17
       LDQ D25+1      L+200000000000 FR DVD 1-35
       EDP D26        L+077777000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON UNDERFLOW
EDPPT  TSX CHECK,4    
       PZE EDPPT-2,3,3 NO OV, P+Q ON, ADDRESS
       REM             AND COL 14+15 ON LOC 0.
       OCT +347002000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPP       
       REM            
*CHECKING OVERFLOW TRAPPING. *709 MODE*
*OVERFLOW SHOULD NOT OCCUR UNTIL CHAR IS INCREASED.
*NO OV LITES. NO P OR Q.
*A BIT IN COL 15 AND INST CTR SHOULD BE STORED IN LOC 00000.
       REM            
       BCD 1EDP       
EDPQ   TSX CLEAR,4    
       AXT EDPQT,2    
       SXA TRAP,2     
       CLA D26        L+077777000000 CH DVD 3-17
       LDQ D26+1      L+200000000000 FR DVD 1-35
       EDP D20        L+040000000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON UNDERFLOW
EDPQT  TSX CHECK,4    
       PZE EDPQT-2,1  NO OV, NO P+Q, ADDRESS
       REM             AND COL 15 ON LOC ZERO.
       OCT +100000000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPQ       
       REM            
*CHECKING EDP WITH INDEXING. NO TRAPPING OR OVERFLOWS.
       REM            
       BCD 1EDP       
EDPR   TSX CLEAR,4    
       AXT 2,1        
       CLA D22        L+040000000000 CH DVD 3-17
       LDQ D22+1      L-200000000000 FR DVD 1-35
       EDP D23,1      L+040000000000 CH DIV 3-17
       REM            L-200000000000 FR DIV 1-35
       TSX CHECK,4    
       PZE +0         NO OV, NO PQ, NO TRAP
       OCT +040001000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPR       
       REM            
*CHECKING EDP WITH INDEXING. TRAPPING ON OVERFLOWS.
*SAME AS TEST EDPO EXCEPT INDEXING.
       BCD 1EDP       
EDPT   TSX CLEAR,4    
       AXT EDPTT,2    
       SXA TRAP,2     
       AXT 4,1        
       CLA D26        L+077777000000 CH DVD 3-17
       LDQ D25+1      L+200000000000 FR DVD 1-35
       EDP D25+4,1    L+007000000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
EDPTT  TSX CHECK,4    
       PZE EDPTT-2,1  NO OV, NO P+Q, ADDRESS
       REM             AND COL 15 ON LOC ZERO.
       OCT +131000000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPT       
       REM            
*CHECKING EDP WITH IND ADDR. NO TRAPPING OR OVERFLOWS.
       REM            
       BCD 1EDP       
EDPU   TSX CLEAR,4    
       CLA D28        L+050101000000 CH DVD 3-17
       LDQ D28+1      L+300000000000 FR DVD 1-35
       EDP* *-2       L+050101000000 CH DIV 3-17
       REM            L+300000000000 FR DIV 1-35
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040001000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPU       
       REM            
*CHECKING EDP WITH IND ADDR. TRAPPING WITH UNDERFLOWS.
       REM            
       BCD 1EDP       
EDPV   TSX CLEAR,4    
       NOP D26        SAVE ADDRESS
       AXT EDPVT,2    
       SXA TRAP,2     
       CLA D25        L+007000000000 CH DVD 3-17
       LDQ D25+1      L+200000000000 FR DVD 1-35
       EDP* EDPV+1    L+077777000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON UNDERFLOW
EDPVT  TSX CHECK,4    
       PZE EDPVT-2,3,3 NO OV, P+Q ON, ADDR AND
       REM            COLS 14+15 OF LOC ZERO.
       OCT +347002000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPV       
       REM            
*CHECKING EDP WITH INDEXING AND IA. TRAPPING WITH OVERFLOW.
*OVERFLOW SHOULD NOT OCCUR UNTIL CHAR IS INCREASED.
*SAME AS TEST EDPQ EXCEPT FOR INDEXING AND IA.
       REM            
       BCD 1EDP       
EDPW   TSX CLEAR,4    
       NOP D20        CH 40,000   FR .2 SAVE ADDR
       AXT EDPWT,2    
       SXA TRAP,2     
       CLA D26        L+077777000000 CH DVD 3-17
       LDQ D26+1      L+200000000000 FR DVD 1-35
       AXT 3,1        
EDPWC  EDP* *-3,1     L+040000000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON UNDERFLOW
EDPWT  TSX CHECK,4    
       PZE EDPWT-2,1  NO OV, NO P+Q, ADDRESS
       REM             AND COL 15 ON LOC ZERO.
       OCT +100000000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPW       
       REM            
*CHECKING EDP WITH INDEXING, IA, AND USING EXECUTE.
*TRAPPING WITH OVERFLOW SAME AS PREV TEST EXCEPT FOR EXECUTE.
       REM            
       BCD 1EDP       
EDPX   TSX CLEAR,4    
       AXT EDPXT,2    
       SXA TRAP,2     
       AXT 3,1        
       CLA D26        L+077777000000 CH DVD 3-17
       LDQ D26+1      L+20000000000 FR DVD 1-35
EDPXA  XEC EDPXC      
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON UNDERFLOW
       TRA EDPXT      JUMP AREA FOR XEC.
       NOP            
       NOP            
       NOP D20        SAVE ADDR, CH 40,000 FR .2
EDPXC  EDP* *+2,1     
       NOP            
       NOP            
       NOP            
EDPXT  TSX CHECK,4    
       PZE EDPXA+1,1  NO OV, NO P+Q, ADDRESS
       REM             AND COL 15 ON LOC ZERO.
       OCT +100000000000 CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       
       TRA EDPX       
       REM            
*CHECKING CONDITION OF UNDERFLOW UNTIL CHAR IS INCREASED BY ONE.
*AFTER DIV MQ COL 1 EQUAL 1.
*NO MQ LEFT SHIFT REQD.
       REM            
       BCD 1EDP       
EDP11  TSX CLEAR,4    
       NOP            
       CLA D31        L+000001000000 CH DVD 3-17
       LDQ D3         L+200000000000 FR DVD 1-35
       EDP D32        L+040002000000 CH DIV 3-17
       REM            L+200000000000 FR DIV 1-35
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP.
       OCT +0             CONT ACC
       OCT +200000000000 CONT MQ
       TSX OK,4       CONTINUE TEST
       TRA EDP11      REPEAT TEST
       REM            
*CHECKING EDP FOR OPERATION.
       REM            
       BCD 1EDP       
EDP21  TSX CLEAR,4    MONITOR
       NOP            
       ELD EPE16      CH 40,066 FR .216067446771
       EDP EPE15      CH 40,062 FR .343277244615
       NOP            
       DCT            TRIGGER SHOULD BE OFF
       TSX ERROR-1,4  ON- IN ERROR.
       NOP DCTER      OFF-OK - GO ON.
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040004777777 CONT ACC
       OCT +237777777776 CONT MQ
       TSX OK,4       CONTINUE TEST
       TRA EDP21      REPEAT TEST
       REM            
*CHECKING EDP BY GIVING CONTINIOUS EDP.
       REM            
       BCD 1EDP       
EDP2   TSX CLEAR,4    MONITOR
       ELD EPE16      CH 40,066 FR .21606067446770
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       EDP EPE1       CH 40,004 FR .24
       DCT            TGR SHOULD BE OFF
       TSX ERROR-1,4  ON- IN ERROR
       NOP DCTER      OFF- OK -GO ON.
EDP2A  TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP.
       OCT +040000777777 CONT ACC
       OCT +377777777764 CONT MQ
       TSX OK,4       CONTINUE TEST
       TRA EDP2       REPEAT TEST
       REM            
*CHECKING EDP AND EMP. 
       REM            
       BCD 1EDPEMP    
EDEM   TSX CLEAR,4    MONITOR
       ELD EPE5       CH 40,021 FR .30324
       EMP EPE12      CH 40,050 FR .350651224200
       EDP EPE13      CH 40,054 FR .221411634520
       EMP EPE12      CH 40,050 FR .350651224200
       EDP EPE13      CH 40,054 FR .221411634520
       EMP EPE12      CH 40,050 FR .350651224200
       EDP EPE13      CH 40,054 FR .221411634520
       EMP EPE12      CH 40,050 FR .350651224200
       EDP EPE13      CH 40,054 FR .221411634520
       EMP EPE12      CH 40,050 FR .350651224200
       EDP EPE13      CH 40,054 FR .221411634520
       DCT            TGT SHOULD BE OFF
       TSX ERROR-1,4  ON- IN ERROR
       NOP DCTER
EDEM1  TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040000777777 CONT ACC
       OCT +377777777774 CONT MQ
       TSX OK,4       CONTINUE TEST
       TRA EDEM       REPEAT TEST
       REM            
*CHECKING EDP AND EMP FOR RELIABILTY.
       REM            
*PERFORMING THE OPERATION OF MULTIPLYING N TIMES N AND
*THEN DIVIDING BY N. THE END RESULT SHOULD EQUAL N, EXCEPT
*FOR AN INITIAL CONDITION OF UNNORMALIZED NUMBERS.
*IN THIS ROUTINE, A ZERO COL WILL BE ROTATED FROM COL 35 TO COL 1 OF MQ.
*DUE TO PRECISION OF THE EX PREC OPER, THE BIT IN COL 35 IS LOST.
       REM            
       BCD 1EMPEDP    
WUST   TSX CLEAR,4    MONITOR
       NOP            
       CLS EONE       GET -040001   -CHAR
       LDQ B135       L+37777777777 -FRACT
       STO SHOP       INITIAL
       STQ SHOP+1        VALUES.
       AXT 35,1       FOR ROTATING ZERO COL.
       REM            
WUSTA  ELD SHOP       
       RQL 1          ROT ZERO LEFT
       LRS 0          MQ S MADE SAME AS ACC S
       EST SHOP       
       NOP            
       TXH *+3,1,1    ALTER ANS DUE TO NORM
       CLA ALTMD      
       LDQ ALTMD+1    
       EST WUSTC      
       REM ALTER ANS FOR FIRST COND
       TXL *+3,1,34   
       CAL MSK34      L-377777777774
       ANS WUSTC+1    
       CAL BS134      L-377777777776
       ANS WUSTC+1    DROP BIT IN COL 35
       NOP            
       REM            
WUSTB  ELD SHOP       NOW PREFORMING
       EMP SHOP          N TIMES N
       EDP SHOP             DIV BY N.
       NOP            
       DCT            TRIGGER SHOULD BE OFF.
       TSX ERROR-1,4  ON- IN ERROR.
       NOP DCTER      OFF- OK - GO ON.
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
WUSTC  OCT +000000777777 CORR ACC VAL STO HERE.
       OCT +0            CORR MQ VAL STO HERE.
       NOP            
       NOP WUST       
       SWT 1          WANT A CLOSED LOOP...
       TRA *+2        UP- NO
       TRA WUSTB      DN- YES-REPEAT SAME VALUE
       TIX WUSTA,1,1  LOOP 35 TIMES
       TSX OK,4       CONTINUE TEST
       TRA WUST       REPEAT TEST
       REM            
*CHECKING EDP AND EMP WITH USE OF ELD AND EST.
       REM            
       BCD 1EMED      
EDEMA  TSX CLEAR,4    MONITOR
       AXT 25,1       
       ELD EPE1       CH 40,004 FR .24
       EST SHOP       
       NOP            
       ELD SHOP       
       EMP EPE7       CH 40,030 FR .230455
       EST SHOP+2     
       ELD SHOP+2     
       EDP EPE4       
       EMP EPE1       CH 40,004 FR .24
       EST SHOP+4     
       ELD SHOP+4     
       EMP EPE8       CH 40,033 FR .2765702
       EDP EPE12      CH 40,050 FR .3506512242
       EST SHOP       
       TIX EDEMA+5,1,1 
       NOP            
       DCT            TRG SHOULD BE OFF
       TSX ERROR-1,3  ERROR
       NOP DCTER      
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +040004000000 CONT ACC
       OCT +240000000000 CONT MQ
       TSX OK,4       CONTINUE TEST
       TRA EDEMA      REPEAT TEST
       REM            
*TEST EUA, -0672, SYSTEMS 2.07.91, 92, 93
       REM            
       REM SHORT ROUTINE FOR SCOPING
       REM            
       BCD 1EUQ       
EUA    TSX CLEAR,4    MONITOR
       STZ SHOP       
       STZ SHOP+1     
       PXD            CLEAR
       EUA SHOP       *** DO THIS ONE,
       SWT 1          * * AND THIS ONE,
       TRA *+4   *    
       TRA *-3        *** AND THIS ONE, IF ONE IS DOWN
       BSS 2              FUTURE USE
       TSX OK,4            PROCEED
       TRA EUA        
       REM            
       REM TEST EUA WITH ACC + MQ ZERO
       REM SHOULD END OP ON EXC. CHAC. DIFFERENCE
       REM            
       BCD 1EUA       
EUAA   TSX CLEAR,4    MONITOR
       NOP            
       NOP            
       EUA EONE       CH,40001. FR, .2
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 040001000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAA          REPEAT
       REM            
       REM TEST EUA WITH STORAGE ZERO
       REM SHOULD END OP ON EXC. CHAC. DIFFERENCE
       REM            
       BCD 1EUA       
EUAB   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C,40001, FR, .2
       EUA EZERO      ZERO
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 040001000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       
       TRA EUAB       
       REM            
       REM EUA, SIGNS ALIKE, CHAC. EQUAL. 
       REM CARRY OUT OF ONE SHOULD GIVE 1 RIGHT SHIFT
       REM            
       BCD 1EUA       
EUAC   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C,40001, FR, .2
       EUA EONE       SAME
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 040002000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       
       TRA EUAC       
       REM            
       REM EUA, SIGNS UNLIKE, ACC MINUS, CHAC EQUAL.
       REM RESULT SHOULD BE PLUS.
       REM            
       BCD 1EUA       
EUAD   TSX CLEAR,4    MONITOR
       NOP            
       ELD ETWO       C,40002, FR, .2
       SSM            
       LRS 0          ACC + MQ SIGN MINUS
       EUA ETHRE      C,40002, FR, .3,
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 040002000000 CORRECT ACC CONTENTS
       OCT 100000000000 CORRECT MQ CONTENTS
       REM EUA SHOULD NOT NORMALIZE.
       TSX OK,4       
       TRA EUAD       
       REM            
       REM EUA, SIGNS UNLIKE, ACC PLUS, CHAC. EQUAL
       REM RESULT SHOULD BE MINUS.
       REM BIT IN COL 2, EUA SHOULD NOT NORMALIZE.
       REM IN STORAGE, ONLY SIGN OF CHAC IS MINUS
       REM            
       BCD 1EUA       
EUAE   TSX CLEAR,4    MONITOR
       NOP            
       ELD ETHRE      C, 40002, FR, .3
       SSM            SET C. SIGN MINUS
       EST SHOP       TEMPO
       ELD ETWO       C, 40002, FR, .2
       NOP            
       EUA SHOP       C, -40002, FR, .3
       NOP            SHOULD GET -40002.1
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT -040002000000 CORRECT ACC CONTENTS.
       OCT -100000000000 CORRECT MQ CONTENTS.
       TSX OK,4       PROCEED OR
       TRA EUAE       REPEAT
       REM            
       REM EUA, BOTH FACTORS MINUS, CHAC EQUAL
       REM RESULT SHOULD BE MINUS.
       REM ONLY SIGNS OF THE CHAC. ARE MINUS
       REM CARRY FROM COL 1 SHOULD CAUSE 1 RIGHT SHIFT.
       REM            
       BCD 1EUA       
EUAF   TSX CLEAR,4    MONITOR
       NOP            
       ELD ETHRE      C, 40002, FR, .3
       SSM            
       EST SHOP       C, SIGN MINUS, FR PLUS
       ELD ETWO       C, 40002, FR, .2
       NOP            
       SSM            ACC MINUS
       EUA SHOP       C, -40002, FR, +.3
       NOP            SHOUKLD GET -40003.24
       REM            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP.
       OCT -040003000000 CORRECT ACC CONTENTS.
       OCT -240000000000 CORRECT MQ CONTENTS.
       TSX OK,4       PROCEED OR
       TRA EUAF         REPEAT
       REM            
       REM            
       REM EUA, RESULT ZOER, ACC PLUS, CHAC. EQUAL
       REM SHOULD GET...PLUS ZERO FRACTION, CHAC +04000
       REM            
       BCD 1EUA       
EUAG   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C, 40001, FR, .2
       SSM            
       EST SHOP       C, -40001, FR, +.2
       NOP            
       ELD EONE       C, 40001, FR, .2
       NOP            
       EUA SHOP       C, -40001, FR, .2
       NOP            SHOULD GET +40001.0
       REM            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP.
       OCT 040001000000 CORRECT ACC CONTENTS
       OCT            MQ SHOULD BE + ZERO.
       TSX OK,4       PROCEED OR
       TRA EUAG          REPEAT.
       REM            
*           THE SIGNIFICANCE OF THE PLUS ZERO HERE, IS THAT THE
*       PROGRAMMER IS INFORMED THAT HE HAS APPROACHED ZERO FROM
*       ABOVE, AS OPPOSED TO APPROACHING ZERO FROM BELOW, AS IS DONE
*       IN ROUTINE * EADR *. IN MANY CALCULATIONS, THIS KNOWLEDGE IS
*       AS IMPORTANT AS THE ALGEBRAIC RESULT.
       REM            
       REM EUA, RESULT MINUS ZERO, ACC MINUS,
       REM CHAC. EQUAL.
       REM SHOULD GET...MQ, -0, CHAC. -40004
       REM            
       BCD 1EUA       
EUAH   TSX CLEAR,4    MONITOR
       NOP            
       ELD ENINE      C, 40004, FR, .22
       SSM            ACC MINUS
       NOP            
       EUA ENINE      C, 40004, FR, .22
       NOP            SHOULD GET, -40004.0
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP.
       OCT -040004000000 CORRECT ACC CONTENTS
       OCT -0         CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR 
       TRA EUAH          REPEAT
       REM            
*           THE SIGNIFICANCE OF THE MINUS ZERO HERE IS THAT THE
*       PROGRAMMER IS INFORMED THAT HE HAS APPROACHED ZERO FROM
*       BELOW, AS OPPOSED TO APPROACHING ZERO FROM ABOVE, AS IS DONE
*       IN ROUTINE * EADF *. IN MANY CALCULATIONS, THIS KNOWLEDGE IS
*       AS IMPORTANT AS THE ALGEBRAIC RESULT.
       REM            
       REM            
       REM EUA, START WITH BITS IN 
       REM ACC COLS 1 AND 2,18,19,33,34,35, AND P.
       REM THESE COLS SHOULD BE CLEARED BY EUA.
       REM SIGNS ALIKE, CHAC EQUAL.
       REM CARRY OUT OF COL 1 SHOULD GIVE 1 RIGHT SHIFT.
       REM            
       BCD 1EUA       
EUAI   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C, 40001, FR, .2
       NOP            
       ORA COL18      
       ORA COL19      
       ORA COL1       
       ORA COL2       
       ORA COLS       BIT IN P
       ORA ONE+6      COLS 33,34,35
       NOP            
       EUA EONE       C, 40001, FR, .2
       NOP            SHOULD GET 40002.2,
       REM            WITH ACC Q,P,1,2, AND 18-35 CLEAR.
       TSX CHECK,4    
       OCT            NO OV, NO Q,P, NO TRAP
       OCT 040002000000 CORRECT ACC CONTENTS.
       OCT 200000000000 CORRECT MQ CONTENTS.
       TSX OK,4       PROCEED OR REPEAT
       TRA EUAI       
       REM            
       REM EUA, CHAC UNLIKE, SMALLER CHAC IN ACC
       REM SIGNS ALIKE. BOTH PLUS
       REM            
       BCD 1EUA       
EUAJ   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C, 40001, FR, .2
       EUA EEIT       C, 40004, FR, .2
       NOP            SHOULD GET 40004.22
       TSX CHECK,4    
       OCT            NO OV, NO Q,P, NO TRAP
       OCT 040004000000 CORRECT ACC CONTENTS
       OCT 220000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAJ       REPEAT.
       REM            
       REM EUA, CHAC UNLIKE, SMALLER CHAC IN ACC.
       REM SIGNS UNLIKE. ACC SIGN MINUS
       REM RESULT SHOULD BE PLUS.
       REM            
       BCD 1EUA       
EUAK   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C, 40001, FR, .2
       NOP            
       SSM            ACC MINUS.
       EUA ENINE      C, 40004, FR, .22
       NOP            SHOULD GET 40004.2
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040004000000 CORRECT ACC CONTENTS.
       OCT 200000000000 CORRECT MQ CONTENTS.
       TSX OK,4       PROCEED OR
       TRA EUAK       REPEAT
       REM            
       REM EUA, CHAC. UNLIKE, MSALLER CHAC IN ACC.
       REM SIGNS UNLIKE, ACC SIGN PLUS.
       REM RESULT SHOULD BE MINUS.
       REM            
       BCD 1EUA       
EUAL   TSX CLEAR,4    MONITOR
       NOP            
       ELD ENINE      C, 40004, FR, .22
       SSM            
       EST SHOP       
       ELD EONE       C, 40001, FR, .2
       NOP            
       EUA SHOP       C, -40004, FR, .22
       NOP            SHOULD GET -40004.2
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040004000000 CORRECT ACC CONTENTS
       OCT -200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAL       REPEAT.
       REM            
       REM EUA, CHAC UNLIKE, SMALLER CHAC IN ACC.
       REM SIGNS ALIKE, BOTH MINUS
       REM RESULT SHOULD BE MINUS.
       REM            
       REM            
       BCD 1EUA       
EUAM   TSX CLEAR,4    MONITOR
       NOP            
       ELD ENINE      C, 40004, FR, .22
       SSM            
       EST SHOP       CHAC MINUS
       NOP            
       ELD EONE       C, 40001, FR, .2
       SSM            ACC MINUS
       NOP            
       EUA SHOP       C, -40004, FR, .22
       NOP            SHOULD GET -40004.24
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040004000000 CORRECT ACC CONTENTS
       OCT -240000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAM       REPEAT
       REM            
       REM EUA, CHAC UNLIKE, LARGER CHAC IN ACC
       REM SIGNS ALIKE, BOTH PLUS
       REM            
       BCD 1EUA       
EUAN   TSX CLEAR,4    MONITOR
       NOP            
       ELD EEIT       C, 40004, FR, .2
       NOP            
       EUA EFOUR      C, 40003, FR, .2
       NOP            SHOULD GET 40004.3
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040004000000 CORRECT ACC CONTENTS
       OCT 300000000000 CORRECT MQ CONTENTS
       TSX OK,4       
       TRA EUAN       
       REM            
       REM EUA, CHAC. UNLIKE, LARGER CHAC IN ACC.
       REM SIGNS UNLIKE, ACC MINUS
       REM RESULTS SHOULD BE MINUS. NOT NORMALIZED
       REM            
       BCD 1EUA       
EUAO   TSX CLEAR,4    MONITOR
       NOP            
       ELD EEIT       C, 40004, FR, .2
       SSM            ACC MINUS
       NOP            
       EUA EFOUR      C, 40003, FR, .2
       NOP            SHOULD GET -40004.2
       REM NOTE -Q CARRY OFF UNTIL 3RD STEP.
       REM Q CARRY ON IN 3RD STEP GIVES 1 TO ADDER 35
       REM AND PREVENTS RECOMP.
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040004000000 CORRECT ACC CONTENTS
       OCT -100000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAO       REPEAT.
       REM            
       REM EUA, CHAC UNLIKE, LARGER CHAC IN ACC
       REM SIGNS UNLIKE, ACC PLUS, BUT MQ SIGN MINUS.
       REM RESULT SHOULD BE PLUS. NO NORMALIZED
       REM            
       BCD 1EUA       
EUAP   TSX CLEAR,4    MONITOR
       NOP            
       ELD EFOUR      C, 40003, FR, .2
       SSM            
       NOP            
       EST SHOP       
       CLS EEIT+1     MAKE MQ WORD MINUS
       XCA            
       CLA EEIT       C, 40004, FR, -.2
       NOP            
       EUA SHOP       C, -40003, FR, +.2
       NOP            SHOULD GET, +40004.1
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040004000000 CORRECT ACC CONTENTS
       OCT 100000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAP       REPEAT
       REM            
       REM EUA, CHAC UNLIKE, LARGER CHAC IN ACC.
       REM SIGNS ALIKE, BOTH MINUS.
       REM RESULT SHOULD BE MINUS.
       REM            
       BCD 1EUA       
EUAQ   TSX CLEAR,4    MONITOR
       NOP            
       ELD EFOUR      C, 40003, FR, .2
       SSM            
       LRS 0          ACC AND MQ MINUS
       NOP            
       EST SHOP       
       ELD EEIT       C, 40004, FR, .2
       SSM            ACC MINUS, MQ PLUS
       NOP            
       EUA SHOP       C, -40003, FR, -.2
       NOP            SHOULD GET, -40004.3
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040004000000 CORRECT ACC CONTENTS.
       OCT -300000000000 CORRECT MQ CONTENTS.
       TSX OK,4       PROCEED OR
       TRA EUAQ       REPEAT
       REM            
       REM EUA, EXCESSIVE CHAC. DIF.
       REM LARGER CHAC IN ACC, SIGNS ALIKE.
       REM            
       BCD 1EUA       
EUAR   TSX CLEAR,4    MONITOR
       NOP            
       ELD LGC2       C, 40051, FR, .2
       NOP            
       EUA LGC1       C, 40005, FR, .01
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP.
       OCT 040051000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAR       REPEAT
       REM            
       REM EUA, EXCESSIVE CHAC DIF.
       REM SMALLER CHAC IN ACC. SIGNS ALIKE.
       REM            
       BCD 1EUA       
EUAR1  TSX CLEAR,4    
       NOP            
       ELD LGC1       C, 40005, FR, .01
       NOP            
       EUA LGC2       C, 40051, FR, .2
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP.
       OCT 040051000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAR1      REPEAT
       REM            
       REM EUA, MQ FR ZERO. SHIFT ACC FR TO ZERO
       REM SIGNS ALIKE 
       REM            
       BCD 1EUA       
EUAS   TSX CLEAR,4    MONITOR
       NOP            
       CLA ONE+1      BIT IN 34
       STO SHOP+1     
       CLA EONE       CHAC OF 40001
       STO SHOP       
       LDQ EZERO      CLEAR MQ
       CLA ETEN       CHAR OF 40004
       NOP            
       EUA SHOP       C, 40001, FR, .00000000000002
       NOP            SHOULD GET 4004.0
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040004000000 CORRECT ACC CONTENTS
       OCT               CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAS       REPEAT
       REM            
       REM EUA, MQ FR ZERO, SHIFT ACC FR TO ZERO
       REM SIGNS UNLIKE, ACC + MQ SIGNS MINUS
       REM RESULT SHOULD BE MINUS
       BCD 1EUA       
EUAT   TSX CLEAR,4    MONITOR
       NOP            
       CLA ONE+1      BIT IN 34
       STO SHOP+1     
       CLA EONE       
       STO SHOP       CHAC OF 40001
       LDQ EZERO      CLEAR MQ
       CLS ETEN       GET CHAC OF -40004
       NOP            
       LRS 0           MQ SIGN MINUS
       NOP            
       EUA SHOP       C, 40001, FR, .000000000002
       NOP            
       TSX CHECK,4    
       OCT             NO OVE, NO QP, NO TRAP
       OCT -040004000000 CORRECT ACC CONTENTS
       OCT -0            CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAT       REPEAT
       REM            
       REM EUA WITH OVERFLOW, NOT IN FP TRAP
       REM SIGNS ALIKE 
       REM            
       BCD 1EUA       
EUAU   TSX CLEAR,4    MONITOR
       NOP            
       AXT EUAU1,1    SET TRAP RETURN ADDRESS
       SXA TRAP,1     IN CASE OF TRAP.
       NOP            
       LFTM           TURN OFF F.P. TRAP
       ELD LGC2+2     C, 77777, FR, .2
       EUA LGC2+2     SHOULD GET OVERFLOW
       NOP            
EUAU1  TSX CHECK,4    
       MZE            ACC OV ON, NO PQ, NO TRAP
       OCT 100000000000 ACC CONTENTS
       OCT 200000000000 MQ CONTENTS
       TSX OK,4       
       TRA EUAU       REPEAT.
       REM            
       REM EUA WITH OVERFLOW, IN F.P. TRAP MODE.
       REM SIGNS ALIKE 
       REM            
       BCD 1EUA-      
EUAV   TSX CLEAR,4    MONITOR
       NOP            
       AXT EUAV1,1    
       SXA TRAP,1     SET TRAP RETURN.
       NOP            
       EFTM           TURN ON F.P. TRAP
       ELD LGC2+2     C, 77777, FR, .2
       EUA LGC2+2     SHOULD GET OVERFLOW
EUAVT  TSX ERROR-1,4  
       NOP TRPER      FAILED TO TRAP
       REM            
EUAV1  TSX CHECK,4    
       PZE EUAVT,1    NO OV, NO PQ, ADDRESS AND
       REM            ONE IN COL 15 OF ZERO
       OCT 100000000000 ACC CONTENTS
       OCT 200000000000 MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EUAV       REPEAT
       REM            
*      EUA WITH INDEXING, NO TRAP
       REM            
       REM            
       BCD 1EUA       
WJSV   TSX CLEAR,4    
       NOP            
       AXT 4,1        
       ELD LGC3       C, 74637, FR, .377777777777
       EUA LGC4,1     SHOULD GET SAME WORD
       REM            
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 074640000000 AC
       OCT 377777777777 MQ
       TSX OK,4       PROCEED OR
       TRA WJSV       REPEAT
       REM            
*TWENTY-SIZ MILES ACROSS THE SEA.
       REM            
*      EUA WITH INDEXING, FP TRAP.
       REM            
       REM            
       BCD 1EUA-      
WFAX   TSX CLEAR,4    
       NOP            
       AXT WFAXT,1    
       SXA TRAP,1     SET TRAP RETURN
       AXT 2,1        
       ELD LGC2+2     C, 77777, FP, .2
       EUA LGC2+4,1   SHOULD GET SAME, AND OV
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      FAILED TO TRAP
       REM            
WFAXT  TSX CHECK,4    
       PZE WFAXT-2,1  TRAP ADDRESS, AND BIT IN COL 15
       OCT 100000000000 ACC
       OCT +200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA WFAX       REPEAT
       REM            
*      EUA WITH IA, NO TRAP
       REM            
       BCD 1EUA       
WMAL   TSX CLEAR,4    
       ELD C41+1      C, 40060, FR, .2
       EUA* *-1       SAME
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 040061000000 AC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA WMAL       REPEAT
       REM            
*      EUA WITH IA, TRAP
       REM            
       BCD 1EUA-      
WGMS   TSX CLEAR,4    
       NOP            
       AXT WGMST,1    
       SXA TRAP,1     SET TRAP RETURN
       NOP            
       ELD LGC2+2     C, 77777, FR, .2
       EUA* *-1       SAME
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
       REM            
WGMST  TSX CHECK,4    
       PZE WGMST-2,1  TRAP ADDRESS, BIT IN COL 15
       OCT 100000000000 ACC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA WGMS       REPEAT
       REM            
*EAD, EXTENDED FLOATING ADD, +0671
       REM            
*ESB, EXTENDED FLOATING SUBTRACT, -0671
       REM            
       REM SHORT ROUTINE FOR SCOPING
       REM            
       BCD 1EAD       
EAD    TSX CLEAR,4    MONITOR
       NOP            
       STZ SHOP       
       STZ SHOP+1     
       PXD            CLEAR
       LRS 35         
       EAD SHOP       *** DO THIS ONE
       SWT 1          * * AND THIS ONE
       TRA *+4          *
       TRA *-3        *** AND THIS ONE IF SW 1
       BSS 2          
       TSX OK,4       
       TRA EAD        
       REM            
       REM EAD WITH STORAGE ZERO.
       REM SHOULD END OP ON ZERO SR AND MQ COL 1 A ONE
       REM            
       BCD 1EAD       
EADA   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C, 40001, FR, .2
       NOP            
       EAD EZERO      NORMAL ZERO
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040001000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR 
       TRA EADA       REPEAT
       REM            
       REM EAD WITH ACC + MQ ZERO.
       REM SHOULD END OP ON ZERO FR, AND ONE IN MQ 1
       REM            
       BCD 1EAD       
EADB   TSX CLEAR,4    MONITOR
       NOP            
       PXD            
       LRS 35         CLEAR
       NOP            
       EAD EONE       C, 40001, FR .2
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040001000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EADB       REPEAT
       REM            
       REM EAD, ACC + MQ ZERO, STORAGE UN-NORMALIZED
       REM SHOULD NORMALIZE
       BCD 1EAD       
EADC   TSX CLEAR,4    MONIOTR
       NOP            
       PXD            
       LRS 35         CLEAR
       NOP            
       EAD LGC1       C, 40005, FR, .01
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040001000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EADC       REPEAT
       REM            
       REM EAD, SIGNS ALIKE, CHAC EQUAL
       REM NO NORMALIZE NEEDED, CARRY FROM
       REM COL 1 SHOULD GIVE ONE SHIFT RIGHT.
       REM            
       BCD 1EAD       
EADD   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C 40001, FR, .2
       NOP            
       EAD EONE       
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040002000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR 
       TRA EADD       REPEAT
       REM            
       REM EAD, SIGNS UNLIKE, ACC SIGN MINUS
       REM CHAC EQUAL. 
       REM SHOULD GET MINUS ZERO
       REM            
       BCD 1EAD       
EADE   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C, 40001, FR, .2
       SSM            
       NOP            
       EAD EONE       
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -0         ACC -ZERO
       OCT -0         MQ -ZERO
       TSX OK,4       PROCEED OR
       TRA EADE       REPEAT
       REM            
*          THE SIGNIFICANCE OF THE MINUS ZERO HERE IS THAT THE
*      PROGRAMMER IS INFORMED THAT HE HAS APPROACEHD ZERO FROM
*      BELOW, AS OPPOSED TO APPROACHING ZERO FROM ABOVE, AS IS DONE
*      IN ROUTINE * EADF *. IN MANY CALCULATIONS, THIS KNOWLEDGE IS
*      AS IMPORTANT AS THE ALGEBRAIC RESULT.
       REM            
       REM EAD, SIGNS UNLIKE, ACC SIGN PLUS
       REM CHAC EQUAL, MQ SIGN MINUS
       REM SHOULD GET PLUS ZERO
       BCD 1EAD       
EADF   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C, 40001, FR, .2
       SSM            
       NOP            
       EST SHOP       STORAGE MINUS
       LDQ EONE+1     FR, .2
       LRS 0          MQ MINUS
       NOP            
       CLA EONE       C, +40001
       EAD SHOP       C, -40001, FR, .2
       NOP            SHOULD GET PLUS ZERO
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT            ACC ZERO
       OCT            MQ ZERO
       TSX OK,4       PROCEED OR
       TRA EADF       REPEAT
       REM            
*          THE SIGNIFICANCE OF THE PLUS ZERO HERE, IS THAT THE
*      PROGRAMMER IS INFORMED THAT HE HAS APPROACHED ZERO FROM
*      ABOVE, AS OPPOSED TO APPROACHING ZERO FROM BELOW, AS IS DONE
*      IN ROUTINE * EADR *. IN MANY CALCULATIONS, THIS KNOWLEDGE IS
*      AS IMPORTANT AS THE ALGEBRAIC RESULT.
       REM            
       REM EAD, STORAGE ZERO.
       REM ACC CONT, BITS IN- P-2,18,19,33-35.
       REM THESE BITS SHOULD BE CLEAR IN RESULT.
       BCD 1EAD       
EADG   TSX CLEAR,4    
       NOP            
       ELD EONE       C, 40001, FR, .2
       NOP            
       ORA COLS       
       ORA COL1       INSERT BITS
       ORA COL2       TO P,1,2
       ORA COL18      18,19,
       ORA COL19      
       ORA ONE+6      33,34,35
       NOP            
       EAD EZERO      NORMAL ZERO,
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040001000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR 
       TRA EADG       REPEAT.
       REM            
       REM EAD, CHAC UNLIKE, SMALELR CHAC IN ACC
       REM SIGNS ALIKE. NO CARRY OUT OF ONE
       REM NO NORMALIZING.
       REM            
       BCD 1EAD       
EADH   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C, 40001, FR, .2
       NOP            
       EAD EFOUR      C, 40003, FR, .2
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040003000000 CORRECT ACC CONTENTS
       OCT 240000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EADH       REPEAT
       REM            
       REM EAD, CHAC UNLIKE, SMALLER CHAC IN ACC
       REM SIGNS ALIKE. CHAC DIF OF 42. A ONE IN
       REM MQ 35 ADDS TO ALL ONES IN ACC.
       REM NO NORMALIZING
       BCD 1EAD       
EADI   TSX CLEAR,4    MONITOR
       NOP            
       ELD LGC3+2     C, 74575, FR, .2
       NOP            
       EAD LGC3       C, 74637, FR, .3777777777
       NOP            
       REM SHIFT MQ1 TO MQ35- ALL ONES IN ACC.
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP.
       OCT 074640000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EADI       REPEAT
       REM            
       REM EAD, CHAC UNLIKE, LARGER CHAC IN ACC.
       REM RIPPLE TO COL 2. LEAVE BITS IN COL 34
       REM AND COL 2 BEFORE NORMALIZING
       REM            
       BCD 1EAD       
EADJ   TSX CLEAR,4    MONITOR
       NOP            
       ELD LGC4+2     C, 40100, FR, .03777777777
       NOP            
       EAD LGC4       C, 40076, FR. .20000000014
       REM            CHAC DIF OF 2-PAGE 2.07.91
       REM            RIPPLE TO ADD2-PADE 2.07.92
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040077000000 CORRECT ACC CONTENTS
       OCT 200000000004 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EADJ       REPEAT.
       REM            
       REM EAD, CHAC UNLIKE, SMALLER CHAC IN ACC
       REM SIGNS UNLIKE, ACC PLUS.
       REM RESULT MINUS, NO NORMALIZING.
       REM            
       BCD 1EAD       
EADK   TSX CLEAR,4    MONITOR
       NOP            
       ELD EFIVE      C, 40003, FR .24
       SSM            
       NOP            
       EST SHOP       STORAGE MINUS
       ELD EONE       C, 40001, FR, .2
       NOP            
       EAD SHOP       C, -40003, FR, .24
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040003000000 CORRECT ACC CONTENTS
       OCT -200000000000 CORRECT MQ CONTENTS
       TSX OK,4       
       TRA EADK       
       REM            
       REM CONTINUOUS EADS, SIGNS ALIKE
       REM            
       BCD 1EAD       
EADL   TSX CLEAR,4    MONITOR
       ELD EONE       C,40001, FR, .2
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       EAD EONE       
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040007000000 CORRECT ACC CONTENTS
       OCT 312000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EADL       REPEAT
       REM            
       REM EAD, ACC ZERO, NORMALIZE FROM COL 35
       REM            
       BCD 1EAD       
EADM   TSX CLEAR,4    MONITOR
       NOP            
       CLA C43        CHAC 40043
       LDQ ONE        1 IN COL 35
       NOP            
       EST SHOP       
       ELD EZERO      CLEAR ACC, MQ
       EAD SHOP       C, 40043, FR, .00000000001
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040001000000 CORRECT ACC CONTENTS
       OCT 200000000000 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EADM       REPEAT
       REM            
       REM            
       REM BILL BAILEY, WONT YOU PLEASE COME HOME.
       REM            
       REM            
       REM EAD, CHAC ALIKE, ALL ONES TO ALL ONES
       REM SIGNS ALIKE, CARRY OUT OF COL 1
       REM            
       BCD 1EAD       
EADN   TSX CLEAR,4    MONITOR
       NOP            
       CLA PONES      ONE, 1-35
       STO SHOP+1     
       XCA            
       CLA C43        CHAC 43
       NOP            
       STO SHOP       
       NOP            
       EAD SHOP       C, 40043, FR, .377777777777
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040044000000 CORRECT ACC CONTENTS
       OCT 377777777777 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EADN       REPEAT
       REM            
       REM EAD, CHAC UNLIKE, SMALLER CHAC IN ACC
       REM SIGNS ALIKE, ONES IN 2-35, NO NORMALIZE
       REM            
       BCD 1EAD       
EADO   TSX CLEAR,4    
       NOP            
       ELD C43+2      C, 40042, FR, .37777777777
       NOP            
       EAD C43        C, 40043, FR, .17777777777
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040043000000 CORRECT ACC CONTENTS
       OCT 377777777776 CORRECT MQ CONTENTS
       TSX OK,4       PROCEED OR
       TRA EADO       FLOAT.
       REM            
       REM EAD, CHAC UNLIKE, SMALLER CHAC IN ACC
       REM SIGNS UNLIKE, ACC S-, RESULT -ZERO.
       BCD 1EAD       
EADP   TSX CLEAR,4    MONITOR
       NOP            
       ELD C43+2      C, 40042, FR, .37777777777
       SSM            
       NOP            
       EAD C43        C, 40043, FR, .1777777777
       NOP            
       REM            NO Q CARRY ON THIRD STEP
       REM            PREVENTS CHANGE OF ACC SIGN
       REM            SYSTEM 2.07.92
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -0         CORRECT ACC
       OCT -0         CORRECT M1
       TSX OK,4       PROCEED OR
       TRA EADP       REPEAT
       REM            
*FILSTRUP, WILL YOU PLEASE STOP THAT INFERNAL DRUMMING.
       REM            
       REM EAD, CHAC UNLIKE, LARGER CHAC IN ACC
       REM SIGNS ALIKE, ONES IN 2-35, NO NORMALIZE
       REM            
       BCD 1EAD       
EADQ   TSX CLEAR,4    MONITOR
       NOP            
       ELD C43        C, 40043, FR .17777777777
       EAD C43+2      CH 40,042 FR .377777777777
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040043000000 CORRECT ACC
       OCT 377777777776 
       TSX OK,4       PROCEED OR
       TRA EADQ       REPEAT
       REM            
       REM EAD, CHAC UNLIKE, LARGER CHAC IN ACC
       REM SIGNS UNLIKE, ACC S-, RESULT -ZERO.
       REM            
       BCD 1EAD       
EADR   TSX CLEAR,4    MONITOR
       NOP            
       ELD C43        C, 40043, FR, .177777777777
       SSM            
       NOP            
       EAD C43+2      C, 40042, FR, .37777777777
       NOP            
       REM            NO Q CARRY ON THIRD STEP
       REM            PREVENTS CHANGE OF ACC SIGN
       REM            SYSTEMS 2.07.92
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -0         CORRECT ACC
       OCT -0         CORRECT MQ
       TSX OK,4       PROCEED OR
       TRA EADR       REPEAT
       REM            
*           THE SIGNIFICANCE OF THE MINUS ZERO HERE IS THAT THE
*      PROGRAMMER IS INFORMED THAT HE HAS APPROACHED ZERO FROM
*      BELOW, AS OPPOSED TO APPROACHING ZERO FROM ABOVE, AS IS DONE
*      IN ROUTINE * EADF *. IN MANY CALCULATIONS, THIS KNOWLEDGE IS
*      AS IMPORTANT AS THE ALGEBRAIC RESULT.
       REM            
       REM EAD, CHAC UNLIKE, LARGER CHAC IN ACC
       REM SIGNS UNLIKE, ACC MINUS RESULT
       REM SHOULD BE MINUS
       REM            
       BCD 1EAD       
EADS   TSX CLEAR,4    MONITOR
       NOP            
       ELD ESIX       C, 40003, FR, .3
       SSM            ACC MINUS
       NOP            
       EAD EONE       C, 40001, FR, .2
       NOP            EXCHANGE CHACS, SHIFT ACC FR
       REM            RIGHT 2, COMP ACC AND ADD,
       REM            Q CARRY ON THIRD STEP, CAUSE
       REM            CHANGE ACC S. SYSTEMS 2.07.92
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040003000000 ACC, S,1-35
       OCT -240000000000 MQ, S,1-35
       TSX OK,4       PROCEED OR
       TRA EADS       REPEAT.
       REM            
       REM EAD, CHAC UNLIKE, SMALLER CHAC IN ACC
       REM SIGNS UNLIKE, ACC PLUS, RESULT
       REM SHOULD BE MINUS
       REM            
       BCD 1EAD       
EADT   TSX CLEAR,4    MONITOR
       NOP            
       ELD ESIX       C, 40003, FR, .3
       SSM            
       EST SHOP       
       ELD EONE       C, 40001, FR, .1
       NOP            
       EAD SHOP       C, -40003, FR, .3
       NOP            
       REM            NO Q CARRY ON THIRD STEP
       REM            RECOMP ACC.
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040003000000 ACC
       OCT -240000000000 MQ
       TSX OK,4       
       TRA EADT       
       REM            
       REM EAD, CHAC EQUAL, SIGNS UNLIKE
       REM ACC PLUS, RESULT SHOULD BE MINUS.
       REM NORMALIZE FROM COL 3
       BCD 1EAD       
EADU   TSX CLEAR,4    MONITOR
       NOP            
       ELD EFIVE      C, 40003, FR, .24
       SSM            
       EST SHOP       CHAC MINUS
       ELD EFOUR      C, 40003, FR, .2
       EAD SHOP       C, -40003, FR, .24
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040001000000 ACC
       OCT -200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EADU       REPEAT
       REM            
*KEEP SMILING, PEOPLE WILL WONDER WHAT YOUR UP TO.
       REM            
       REM EAD, CHAC EQUAL, SIGNS UNLIKE.
       REM ACC MINUS, RESULT SHOULD BE MINUS
       REM NORMALIZE FROM COL 3
       REM            
       BCD 1EAD       
EADV   TSX CLEAR,4    MONITOR
       NOP            
       ELD EFIVE      C, 40003, FR, .24
       SSM            ACC MINUS
       NOP            
       EAD EFOUR      C, 40003, FR, .2
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040001000000 ACC
       OCT -200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EADV       REPEAT
       REM            
       REM EAD, SIGNS UNLIKE, ACC MINUS. RESULT MINUS
       REM CHAC EQUAL, NORMALIZE FROM COL 35.
       REM            
       BCD 1EAD       
EADW   TSX CLEAR,4    MONITOR
       NOP            
       ELD ETHRE      C, 40002, FR, .3
       XCA            
       ORA ONE        INSERT ONE IN 35
       XCA            
       SSM            NOW, C-40002, FR, .300000000001
       NOP            
       EAD ETHRE      C, 40002, FR, .3
       NOP            
       REM            END AROUND CARRY
       REM            ONE TO ACC 35, NO RECOMP
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -037740000000 CORRECT ACC
       OCT -200000000000 CORRECT MQ
       TSX OK,4       PROCEED OR
       TRA EADW       REPEAT
       REM            
       REM EAD, SIGNS UNLIKE, ACC PLUS, RESULT PLUS
       REM CHAC EQUAL, NORMALIZE FROM COL. 35
       REM            
       BCD 1EAD       
EADX   TSX CLEAR,4    MONITOR
       NOP            
       ELD ETHRE      C, 40003, FR, .3
       SSM            
       EST SHOP       
       ELD ETHRE      C, 40003, FR, .3
       XCA            
       ORA ONE        BIT IN 35
       XCA            
       NOP            
       EAD SHOP       C, -40003, FR, .3
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 037740000000 CORRECT ACC
       OCT 200000000000 CORRECT MQ
       TSX OK,4       PROCEED OR
       TRA EADX       REPEAT
       REM            
       REM EAD, SIGN OF STORAGE FRAC MINUS
       REM ACC, MQ PLUS, CHAC EQUAL
       REM            
       BCD 1EAD       
EADY   TSX CLEAR,4    MONITOR
       NOP            
       ELD EONE       C, 40001, FR, .2
       XCA            
       SSM            FR, -.2
       XCA            
       EST SHOP       
       ELD EONE       C, 40001, FR, .2
       EAD SHOP       C, 40001, FR, -.2
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040002000000 ACC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EADY       REPEAT.
       REM            
       REM EAD, SIGN OF MQ MINUS, ACC + STORAGE PLUS
       REM CHAC EQUAL. 
       REM            
       BCD 1EAD       
EADZ   TSX CLEAR,4    MONITOR
       NOP            
       ELD ETHRE      C, 40002, FR, .3
       XCA            
       SSM            
       XCA            MQ MINUS
       NOP            
       EAD ETHRE      C, 40002, FR, .3
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 040003000000 ACC
       OCT 300000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EADZ       REPEAT
       REM            
*OK, LOUIE, DROP THE GUN.
       REM            
       REM EAD WITH OVER FLOW, NO IN F.P. TRAP.
       REM SIGNS ALIKE, CHAC EQAUL
       REM            
       BCD 1,EAD-     
EFADA  TSX CLEAR,4    MONITOR
       AXT EFAD1,1    
       SXA TRAP,1     SET TRAP RETURN IN CASE OF TRAP
       LFTM           TURN OF F.P. TRAP MODE.
       ELD LGC2+2     C, 777777, FR, .2
       EAD LGC2+2     SAME
EFAD1  TSX CHECK,4    
       MZE            OV ON, NO QP, NO TRAP
       OCT 100000000000 ACC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EFADA      REPEAT
       REM            
       REM EAD WITH OVERFLOW, F.P. TRAP ON
       REM SIGNS ALIKE, CHAC EQUAL
       REM            
       BCD 1EAD-      
EFADB  TSX CLEAR,4    MONITOR
       EFTM           F.P. TRAP ON
       AXT EFAD2,1    
       SXA TRAP,1     TRAP RETURN ADD
       ELD LGC2+2     C,77777, FR, .2
       EAD LGC2+2     
       TSX ERROR-1,4  
       NOP TRPER      FAILED TO TRAP
EFAD2  TSX CHECK,4    
       PZE EFAD2-2,1  NO OV, NO QP, ADDRESS AND
       REM            COL 15 OF ZERO
       OCT 100000000000 ACC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR 
       TRA EFADB      REPEAT
       REM            
       REM EAD WITH UNDERFLOW, NO IN F.P. TRAP
       REM SIGNS ALIKE, CHAC EQUAL
       REM            
       BCD 1EAD-      
EFADD  TSX CLEAR,4    MONITOR
       AXT EFAD3,1    
       SXA TRAP,1     SET TRAP ADDRESS IN CASE OF TRAP
       LFTM           FP TRAP OF
       ELD FLOAT+2    C, 00001, FR, .02
       EAD FLOAT+2    
EFAD3  NOP            
       TSX CHECK,4    
       OCT -200003000000 ACC + MQ OV, Q+P BIT, NO TRAP
       OCT 377777000000 ACC S,1-35
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EFADD      REPEAT
       REM            
       REM EAD WITH UNDERFLOW, F.P. TRAP ON
       REM SIGNS ALIKE, CHAC EQUAL
       REM            
       BCD 1EAD-      
EFADE  TSX CLEAR,4    MONITOR
       AXT EFAD4,1    
       SXA TRAP,1     RETURN ADDRESS
       EFTM           FP TRPA ON
       ELD FLOAT+2    C, 00001, FR .02
       EAD FLOAT+2    
       TSX ERROR-1,4  
       NOP TRPER      FAILED TO TRAP
EFAD4  TSX CHECK,4    
       PZE EFAD4-2,3,3 NO OV, P+Q BITS, ADDRESS AND
       REM            COLS 14+15 OF ZERO.
       OCT 377777000000 ACC S,1-35
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EFADE      REPEAT
       REM            
       REM EAD, UNDERFLOW, SIGNS UNLIKE.
       REM ACC PLUS, RESULT PLUS
       REM NORMALIZE FROM COL 35, SPILL ON LAST SHIFT.
       REM            
       BCD 1EAD-      
EFADF  TSX CLEAR,4    MONITOR
       AXT EFAD5,1    
       SXA TRAP,1     TRAP RETURN ADDRESS
       LDQ ETHRE+1    FR, .3
       STQ SHOP+1     
       CLS C41        C, 00041, SET MINUS
       STO SHOP       
       SSP            ACC PLUS
       XCA            
       ORA ONE        BIT IN 35,
       XCA            NOW, C, 00041, FR, .300000000001
       EAD SHOP       C, -00041, FR, .3
       TSX ERROR-1,4  
       NOP TRPER     
EFAD5  TSX CHECK,4    
       PZE EFAD5-2,3,3 NO OV, P+Q BITS. ADDRESS
       REM            AND COLS 14+15 OF ZERO.
       OCT 377777000000 ACC S,-35
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EFADF      REPEAT
       REM            
*ASIDE FROM THAT, MRS. LINCLON, HOW DID YOU ENJOY THE PLAY---.
       REM            
*      EAD, INDEXED, IA, WITH UNDERFLOW TRAP
       REM            
       REM            
       BCD 1EAD-      
WPDW   TSX CLEAR,4    
       NOP            
       AXT WPDWT,1    
       SXA TRAP,1     SET TRAP RETURN
       AXT -3,1       
       ELD C41+3      C, 00001, FR, .02
       EAD* WPDW+2,1  SHOULD GET SAME
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON UNDERFLOW
       REM            
WPDWT  TSX CHECK,4    
       PZE WPDWT-2,3,3 TRAP ADD., BITS IN 14 AND 15
       REM            AT ZERO, AND P AND Q IN ACC
       OCT 377777000000 ACC COLS S,1-35
       OCT 200000000000 MQ COLS S,1-35
       TSX OK,4       PROCEED OR
       TRA WPDW       REPEAT
       REM            
*      EAD, INDEXED, IA, OVERFLOW TRASP, SIGNS ALIKE
       REM IA WORD HAS A MINUS SIGN.
       REM            
       BCD 1EAD-      
WCFM   TSX CLEAR,4    
       NOP            
       AXT WCFMT,1    
       SXA TRAP,1     SET TRAP RETURN
       ELD LGC2+2     C, 77777, FR, .2
       AXT 2,1        
       EST SHOP+2,1   
       EAD* *+1,1     C, 77777, FR, .2
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
       REM            
WCFMT  TSX CHECK,4    
       PZE WCFMT-2,1  TRAP ADD, BIT IN 15 AT ZERO.
       OCT 100000000000 ADD
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA WCFM       REPEAT.
       REM            
*      EAD, XEC, NO TRAP
       REM            
       BCD 1EAD       
KGS71  TSX CLEAR,4    
       NOP            
       ELD EONE       C, 40001, FR, .2
       TRA *+2        
       EAD EONE       TO BE EXECUTED
       XEC *-1        ADD. 1+1 IS 2.
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO TRAP, NO PQ
       OCT 040002000000 ACC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA KGS71      REPEAT
       REM            
*      EAD, XEC, OVERFLOW TRAP
       REM            
       BCD 1EAD-      
WCDC   TSX CLEAR,4    
       NOP            
       AXT WCDCT,1    
       SXA TRAP,1     SEET TRAP RETURN
       ELD LGC2+2     C, 77777, FR, .2
       TRA *+3        
       EAD LGC2+2     EXECUTE
       HTR *          SHOULD NEVER GET HERE
       XEC *-2        C, 777777, FR, .2
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
WCDCT  TSX CHECK,4    
       PZE WCDCT-2,1  TRAP ADD, BIT IN 15 AT ZERO.
       OCT 100000000000 ACC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA WCDC       REPEAT
       REM            
*MEANWHILE, BACK AT THE RANCH.
       REM            
*      EAD, XEC, IA, INDEXED. NO TRAP, SIGNS ALIKE
       REM            
       BCD 1EAD       
WAVI   TSX CLEAR,4    
       NOP            
       ELD C41+1      C, 40060, FR, .2
       AXT 2,1        
       EST SHOP+2,1   C, 40060, FR, .2
       TRA *+3        
       EAD* WAVI+6,1  
       HTR* WAVI+8,1  
       REM            
       XEC* WAVI+9,1  SHOULD ADD FROM SHOP
       REM            ADD 40060.2
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 040061000000 ACC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA WAVI       REPEAT
       REM            
*AND GREETINGS TO ALL THE FOLKS FROM DAYTON.
       REM            
*      EAD, IA, INDEXED, UNDERFLOW TRAP
       REM SIGNS ALIKE 
       REM            
       BCD 1EAD-      
WHO    TSX CLEAR,4    WHO INDEED.
       NOP            
       AXT IOWA,1     
       SXA TRAP,1     SET TRAP RETURN.
       CLA WHO+11     L. OF EST* SHOP+2,1
       REM            
       STO SHOP       
       AXT 2,1        2 TO XRA
       TRA WHO+17     
       EAD* WHO+13,1  
       HTR* WHO+10,1  
       REM            
       HTR* C41+5,1   
       EST* SHOP+2,1  
       ELD* WHO+12,1  
       HTR* WHO+14,1  
       HTR* WHO+13,1  
       REM            
       HTR *          
       HTR *          
       XEC* WHO+15,1  ELD, C, 000001, FR, .02
       XEC* WHO+16,1  EST SHOP
       XEC* WHO+11,1  EAD, C, 000001, FR, .02
       REM            
       REM            SHOULD UNDERFLOW AND TRAP
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON UNDERFLOW
       REM            
IOWA   TSX CHECK,4    
       PZE IOWA-2,3,3 TRAP ADD., BITS IN 14 AND 15
       REM            AT ZERO, P AND Q BITS IN ACC.
       OCT 377777000000 ACC COLS S,1-35
       OCT 200000000000 MQ COLS S,1-35
       TSX OK,4       PROCEED OR
       TRA WHO        REPEAT
       REM            
       REM HOW TO FLOAT A FIXED-POINT NUMBER
       REM WITH EAD   
       REM            
       BCD 1EAD       
EFAD   TSX CLEAR,4    MONITOR
       NOP            
       LDQ ONE+6      FIXED POINT 7.
       CLA FLOAT      CHAC OF 40043
       EAD FLOAT      C, 40043, FR, 0
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRPA
       OCT 040003000000 ACC
       OCT 340000000000 MQ
       TSX OK,4       PROCEED OR
       TRA EFAD       REPEAT.
       REM            
       REM HOW TO FIX A FLOATING NUMBER WITH EUA
       REM            
       BCD 1EUA       
EUEAD  TSX CLEAR,4    MONITOR
       NOP            
       ELD ESVN       C, 40003, FR, .34 FLOATING 7.
       EUA FLOAT      C, 00043, FR, 0
       NOP            
       REM FIXED POINT 7 NOW IN MQ
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRPA
       OCT 040043000000 ACC
       OCT 7          MOQ
       TSX OK,4       PROCEED OR
       TRA EUEAD      REPEAT
       REM            
*BASIC TEST OF ESB    
       REM            
       REM ESB, EXTENDED FLOATING POINT SUBTRACT
       REM -0671      
       REM            
       REM SHORT TEST FOR SCOPING
       REM            
       BCD 1ESB       
ESB    TSX CLEAR,4    
       NOP            
       STZ SHOP       
       STZ SHOP+1     
       ELD SHOP       CLEAR
       NOP            
       ESB SHOP       **** DO THIS ONE
       SWT 1          ** * THIS ONE
       TRA *+7           *
       TRA *-3        **** AND THIS ONE, IF SW1 DOWN
       BSS 5          
       TSX OK,4       
       TRA ESB        
       REM            
       REM ESB, ACC PLUS ZERO, SEE THE ESB
       REM WILL CHANGE INCOMING SIGN
       REM            
       BCD 1ESB       
ESB1   TSX CLEAR,4    
       NOP            
       ELD EZERO      CLEAR
       NOP            
       ESB EONE       C, 40001, FR, .2
       NOP            SHOULD GO MINUS
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT -040001000000 ACC
       OCT -200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA ESB1       REPEAT
       REM            
       REM ESB, CHAC, EQUAL, SIGNS ALIKE,
       REM RESULT SHOULD BE PLUS ZERO
       BCD 1ESB       
ESBA   TSX CLEAR,4    
       NOP            
       ELD ETEN       C, 40004, FR, .27
       NOP            
       ESB ETEN       SHOULD GET ZERO
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT 0,0        ACC AND MQ PLSU ZERO
       TSX OK,4       PROCEED OR
       TRA ESBA       REPEAT
       REM            
*           THE SIGNIFICANCE OF THE PLUS ZERO HERE, IS THAT THE
*      PROGRAMMER IS INFORMED THAT HE HAS APPROCHED ZERO FROM 
*      ABOVE, AS OPPOSED TO APPROACHING ZERO FROM BELOW, AS IS DONE
*      IN ROUTINE * EADR *. IN MANY CALCULATIONS, THIS KNOWLEDGE IS
*      AS IMPORTANT AS THE ALGEBRAIC RESULT.
       REM            
       REM ESB. CHAC EQUAL, ACC MINUS, STORAGE PLUS
       REM            
       REM            
       BCD 1ESB       
ESBB   TSX CLEAR,4    
       NOP            
       ELD EFIVE      C, 40003, FR, .24
       SSM            
       NOP            
       ESB EFIVE      SHOULD ADD.
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040004000000 ACC
       OCT -240000000000 MQ
       TSX OK,4       PROCEED OR
       TRA ESBB       REPEAT
       REM            
       REM ESB, CHAC EQUAL, ACC PLUS, STORAGE MINUS
       REM RESULT SHOULD BE PLUS
       REM            
       BCD 1ESB       
ESBC   TSX CLEAR,4    
       NOP            
       ELD EFIVE      C, 40003, FR, .24
       SSM            
       NOP            
       EST SHOP       TEMPO
       NOP            
       ELD EFIVE      ACC PLUS
       ESB SHOP       C, -40003, FR, .24
       NOP            SHOULD ADD
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 040004000000 ACC
       OCT 240000000000 MQ
       TSX OK,4       PROCEED OR
       TRA ESBC       REPEAT
       REM            
       REM ESB, CHAC EQUAL, BOTH SIGNS MINUS
       REM SHOULD GET MINUS ZERO
       REM            
       BCD 1ESB       
ESBD   TSX CLEAR,4    
       NOP            
       ELD EONE       C, 40001, FR, .2
       SSM            
       NOP            
       EST SHOP       
       ESB SHOP       C, -40001, FR, .2
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -0,-0      ACC AND MQ MINUS ZERO.
       TSX OK,4       PROCEED OR
       TRA ESBD       REPEAT.
*           THE SIGNIFICANCE OF THE MINUS ZERO HERE, IS THAT THE
*      PROGRAMMER IS INFORMED THAT HE HAS APPROCHED ZERO FROM 
*      BELOW, AS OPPOSED TO APPROACHING ZERO FROM ABOVE, AS IS DONE
*      IN ROUTINE * EADF *. IN MANY CALCULATIONS, THIS KNOWLEDGE IS
*      AS IMPORTANT AS THE ALGEBRAIC RESULT.
       REM            
       REM ESB, CHAC ALIKE, ACC PLUS, MQ MINUS
       REM STG CHAC PLUS, STG FR MINUS.
       REM            
       BCD 1ESB       
ESBE   TSX CLEAR,4    
       NOP            
       CLS EFOUR+1    
       STO SHOP+1     
       CLA EFOUR      
       STO SHOP       
       NOP            
       ELD EFIVE      C, 40003, FR, .24
       SSM            
       LRS 0          MQ SIGN MINUS
       SSP            ACC PLUS
       ESB SHOP       C, 40003, FR, -.2
       TSX CHECK,4    
       OCT             NO OV, NO PQ, NO TRAP
       OCT 040001000000 ACC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA ESBE       REPEAT
       REM            
       REM ESB, CHAC UNLIKE, SMALLER IN ACC
       REM SIGNS ALIKE, RESULT MINUS
       REM            
       BCD 1ESB       
ESBF   TSX CLEAR,4    
       NOP            
       ELD EONE       C, 40001, FR, .2
       ESB ESIX       C, 40003, FR, .3
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO QP, NO TRAP
       OCT -040003000000 ACC
       OCT -240000000000 MQ
       TSX OK,4       PROCEED OR
       TRA ESBF       REPEAT.
       REM            
       REM ESB, CHAC UNLIKE, LARGER IN ACC.
       REM SIGNS ALIKE, RESULT PLUS.
       REM            
       REM            
       BCD 1ESB       
ESBG   TSX CLEAR,4    
       NOP            
       ELD ESIX       C, 40003, FR, .3
       ESB EONE       C, 40001, FR, .2
       NOP            
       TSX CHECK,4    
       OCT            NO OV, NO PQ, NO TRAP
       OCT 040003000000 ACC
       OCT 240000000000 MQ
       TSX OK,4       PROCEED OR
       TRA ESBG       REPEAT
       REM ESB, UNDERFLOW TRAP
       REM            
       BCD 1ESB-      
ESBH   TSX CLEAR,4    
       NOP            
       AXT ESBHT,1    
       SXA TRAP,1     SET TRAP RETURN.
       ELD C41+3      C, 000001, FR, .02
       SSM            
       ESB C41+3      SHOULD ADD AND UNDERFLOW
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON UNDERFLOW
ESBHT  TSX CHECK,4    
       PZE ESBHT-2,3,3 TRAP ADD, BITS IN 14 AND 15 AT
       REM            ZERO, BITS IN P AND Q.
       OCT -377777000000 ACC COLS S,1-35
       OCT -200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA ESBH       REPEAT
       REM            
       REM ESB OVERFLOW TRAP
       REM            
       BCD 1ESB-      
ESBI   TSX CLEAR,4    
       NOP            
       AXT ESBIT,1    
       SXA TRAP,1     SET TRAP RETURN
       NOP            
       ELD LGC2+2     C 77777, FR, .2
       SSM            
       EST SHOP       
       ELD LGC2+2     
       ESB SHOP       SHOULD ADD AND OVERFLOW
       TSX ERROR-1,4  FAILED TO TRAP
       NOP TRPER      ON OVERFLOW
ESBIT  TSX CHECK,4    
       PZE ESBIT-2,1  TRAP ADD, BIT IN COL 15
       REM            AT ZERO
       OCT 100000000000 ACC
       OCT 200000000000 MQ
       TSX OK,4       PROCEED OR
       TRA ESBI       REPEAT
       REM            
*CHECKING EDP, EMP, EAD, AND ESB.
       REM            
       BCD 1EAEMED    
EASMD  TSX CLEAR,4    MONITOR
       NOP            
       ELD EZERO      NORMAL ZERO
       EAD EPE10      CH 40,042 FR.225005744
       EMP EPE5       CH 40,021 FR .30324
       ESB EPE15      CH 40,062 FR .343277244615
       EAD EPE5       CH 40,021 FR .30324
       EDP EPE4       CH 40,016 FR .2342
       EAD EPE1       CH 40,004 FR .24
       ESB EP20       CH 40,005 FR .24
       NOP            
       TSX CHECK,4    
       OCT +0         NO OV, NO PQ, NO TRAP
       OCT +0         CONT ACC
       OCT +0         CONT MQ
       TSX OK,4       CONTINUE TEST
       TRA EASMD      REPEAT TEST
       NOP            
       TRA DONE       PASS COMPLETE
       REM            
*************************PROGRAM CHECK SUBROUTINE****************************
       REM            
       REM            
*SUBROUTINE TO CHECK DATA FROM THE MAIN PROGRAM.
       REM            
*      THE CALLING SEQUENCE IS AS FOLLOWS...
       REM            
*                     A   TSX CHECK,4
*                     A+1 PZE  OV LITES IND IN PREFIX, QP IN DECR,
*                              TRAP COND IN TAG, ADDR OF ZERO IN ADDR.
*                     A+2 OCT  CONTENTS OF ACC S-35.
*                     A+3 OCT  CONTENTS OF MQ S-35.
*                     A+4 RETURN HERE IF SW 1 IS UP.
*                     A+5 RETURN HERE IF SW 1 IS DOWN.
       REM            
       REM            
*THE WORD AT A+1 CONTAINS THE EXPECTED CONDITION OF THE ACC. AND
*MQ OVERFLOW TRIGS, AS FOLLOWS.
       REM            
*                     A BIT IN COL S. IF ACC OV TRIG SHOULD HAVE BEEN ON.
*                     A BIT IN COL 1 IF MQ OV TRIG SHOULD HAVE BEEN ON.
       REM            
       REM            
*WITH SW 2 DOWN-CHECK ROUTINE IS BYPASSED AND PROG CHECKS SW 1.
       REM            
*THIS SUBROUTINE CHECKS THE OV TGRS, ACC, MQ, AND THE CONTENTS OF
*LOCATION ZERO. ALL CHECKS ARE MADE BEFORE AN ERROR INDICATION IS GIVEN.
*ON ERROR, THIS SUBROUTINE TRA TO THE ERROR ROUTINE.
       REM            
*ON ERROR, THE FOLLOWING INDICATIONS ARE GIVEN--
       REM            
*      SENSE LITES-   
*         SLT 1 ON - ERROR IN OV TRGS.
*         SLT 2 ON - ERROR IN ACC S-35.
*         SLT 3 ON - ERROR IN MQ S-35.
*         SLT 4 ON - ERROR IN DECR OR ADDR OF LOC ZERO.
       REM            
       REM            
*      SENSE INDICATOR REGISTER-
       REM            
*         BIT IN COL 0 - ERROR IN ACC OV TGR.
*         BIT IN COL 1 - ERROR IN MQ OV TGR.
*         BIT IN COL 2 - ACC OV TGR ON IN ERROR.
*         BIT IN COL 3 - MQ OV TGR ON IN ERROR.
       REM            
*         BIT IN COL 14- CORRECT INDICATION FOR ACC COL Q
*         BIT IN COL 15- CORRECT INDICATION FOR ACC COL P
*         BIT IN COL 16- ERROR IN Q BIT
*         BIT IN COL 17- ERROR IN P BIT
*         BIT IN COL 18- COL 16 OR 17 OR BOTH OF LOC ZERO
*                        WERE SET IN ERROR.
       REM            
       REM            
**********************************************************
**                                                      **
**  SI COLS 21 TO 35 SHOW THE LOCATION OF THE           **
**  TSX INSTRUCTION IN THE MAIN PROGRAM WHICH           **
**  CALLED THIS SUBROUTINE.                             **
**                                                      **
**********************************************************
       REM            
******THE OV. TRIGS ARE TURNED OFF*********
       REM THE DIVIDE CHECK TRIG IS NOT TESTED.
       REM            
*THE ACC, MQ, XRS, AND CONTENTS OF LOC. ZERO ARE UNCHANGED.
       REM            
       REM            
       REM            
CHECK  SWT 2          
       TXI *+2        PROCEED TO CHECK
       TXI CHECK+108  DO NOT CHECK, GO TO SW 1 TEST
       STZ IND        RESET ERR INDICATOR
       SXA CHECK+97,1 
*5                    
       SXA CHECK+98,2 SAVE
       SXA CHECK+99,4   ALL
       STQ MQ            REGISTERS
       STO ACC        
       ARS 35         
*10                   
       SLW PQ         
       SLF            
       LXA COUNT,2    TOTAL ERR COUNT
       LDI 1,4        1RST DATA WORD TO SI.
       PXD            CLEAR ACC
*15                   
       TOV *+2        TEST OV TRIGS
       TRA *+2        
       ORA COL18      BIT IN 18 IF ACC OV ON.
       TQO *+2        
       TRA *+2        
*20                   
       ORA COL19      BIT IN 19 IF MQ OV ON.
       STT *+1        
       IIL **         TURN OFF OK BITS.
       LFT 600000     WILL ALL BE OFF IF OK.
       TXI *+2,2,1    ERROR, COUNT AND INDICATE.
*25                   
       TRA CHECK+35   OK,
       ALS 16         
       OAI            SET OV ERR CONDITIONS IN
       REM            IN SI COL 2 AND 3.
       SXA COUNT,2    
       LXA COUNT+1,2  
*30                   
       TXI *+1,2,1    COUNT OV ERRORS.
       SXA COUNT+1,2  
       LXA COUNT,2    
       SXA IND,2      INDICATE ERR TO PROGRAM
       SLN 1          INDICATE OV. ERR TO OPERATOR.
       REM            
       REM NOW, CHECK P AND Q BITS.
       REM            
       REM            
*35                   
       CLA PQ         
       STA *+1        
       IIL **         TURN OFF OK BITS.
       LFT 3          WILL BE OFF IF OK
       TXI *+2,2,1    ERR, COUNT AND INDICATE
*40                   
       TRA CHECK+50   OK.
       REM            
       SXA COUNT,2    COUNT TOTAL ERRS.
       LXA COUNT+2,2  
       TXI *+1,2,1    COUNT P+Q ERRS
       SXA COUNT+2,2  
*45                   
       LXA COUNT,2    
       SXA IND,2      INDICATE ERROR TO PROGRAM
       SLN 2          INDICATE ACC ERR TO OPERATOR.
       ALS 20         
       OAI            PUT CORRECT P+Q IN SI 14 AND 15
       REM            
       REM            
       REM NOW, CHECK ACC COLS S,1-35
       REM            
*50                   
       CLA 2,4        CORRECT ACC VALUE
       CAS ACC        
       TRA *+2        NG
       TRA CHECK+62     OK
       TXI *+1,2,1    ERR, COUNT AND INDICATE
*55                   
       SXA COUNT,2    
       LXA COUNT+3,2  
       TXI *+1,2,1    COUNT ERRS IN ACC S,1-35
       SXA COUNT+3,2  
       LXA COUNT,2    
*60                   
       SXA IND,2      INDICATE ERR TO PROGRAM
       SLN 2          INDICATE ACC ERR TO OPERATOR
       REM            
       REM NOW, CHECK MQ S,1-35
       REM            
       CLA 3,4        CORRECT VALUE FOR MQ.
       CAS MQ         
       TRA *+2        NG
*65                   
       TRA CHECK+74   OK.
       REM            
       TXI *+1,2,1    ERR, COUNT AND INDICATE
       SXA COUNT,2    
       LXA COUNT+4,2  
       TXI *+1,2,1    COUNT MQ ERRS.
*70                   
       SXA COUNT+4,2  
       LXA COUNT,2    
       SXA IND,2      INDICATE ERR TO PROGRAM
       SLN 3          INDICATE MQ ERR TO OPERATOR
       REM            
       REM            
*LADY, WOULD YOU PLEASE REMOVE YOUR HAT.
       REM     
       REM AND NOW, CK LOC ZERO ADDR AND DECR.
       REM            
       REM            
       CAL            LOC ZERO TO ACC.
*75                   
       STA CHECK+82   TRAP ADDRESS.
       ARS 5          
       STT CHECK+82   OV AND UV IND BITS.
       ANA MSK2       BITS IN COL 21 AND 22.
       TZE *+3        TO INDICATE
*80                   
       CAL COL18      
       ORS CHECK+82        COL 16 AND 17.
       IIR **         
       RFT 777777     ALL SHOULD BE OFF- IF OK.
       TXI *+2,2,1    ERR, COUNT AND INDICATE
*85                   
       TRA CHECK+93   OK
       SXA COUNT,2    
       LXA COUNT+5,2  
       TXI *+1,2,1    COUNT LOC ZERO ERRS
       SXA COUNT+5,2  
*90                   
       LXA COUNT,2    
       SXA IND,2      INDICATE ERR TO PROGRAM
       SLN 4          INDICATE LOC ZERO ERR TO OPERATOR.
       REM            
       REM            
       REM PLACE TRUE ERR LOC IN SI 21-35.
       REM            
       LAC CHECK+99,4 
       PXA ,4         
*95                   
       RIR 377777     TURN OFF
       OAI            SET ERR LOC TO SI
       REM            
       REM            
       REM RESTORE REGISTERS AND EXIT.
       AXT **,1       
       AXT **,2       
       AXT **,4       
*100                  
       CLA PQ         
       LDQ ACC        
       LLS 35         RESTORE ACC.
       TOV *+1        RESTORE OV TRIG
       LDQ MQ         RESTORE MQ
*105                  
       ZET IND        WAS THERE AN ERROR
       TRA *+5        
       REM            
       REM            
       REM IF NO ERR, CHECK SW 1
       REM            
       NOP            FUTURE USE
       SWT 1          
       TRA 4,4        CONTINUE
*110                  
       TRA 5,4        REPEAT IF SW 1 DOWN.
       STZ IND        RESET INDICATOR ON ERROR AND
       TIX ERROR,4,3  GO TO 9DEPR.
       BSS 5          USE
       REM            
*      PROGRAM SEQUENCE AND CONTROL MONITOR.
       REM PART 1, CHECK PROGRAM SEQUENCE.
CLEAR  SWT 1          
       TRA *+2        TEST SW 4
       TRA *+3        TO BE REPEATED
       SWT 4          
       TRA *+4        NO REPEATED
*5                    
       PXD ,4         
       SUB MONIT      TEST FOR REPEAT
       TZE RESET      REPEAT IF ZERO
       REM            
       REM            
       STZ SHOP       
       SXD SHOP,4     SAVE TEST ADDRESS
*10                   
       CLA -2,4       PRECEEDING TEST LOC.
       PAC ,4         COMPLEMENT
       PXD ,4         
       SUB MONIT      WILL GO ZERO FOR NORMAL
       LXD SHOP,4     RESTORE XRC
*15                   
       TZE RESET      OK IF ZERO
       REM            
       REM IF NOT ZERO, CHECK FOR MANUAL TRA
       REM            
       ENK            CHECK KEYS
       XCA            
       PAC ,4         COMP. KEYS ADDRESS
       LRS 21         
*20                   
       SUB PROP2      ALLOW PRIM OP 0,2 ONLY
       TNZ *+5        N.G. IF NOT ZERO HERE
       PXD ,4         NOW CHECK ADDRESS
       SUB SHOP       
       LXD SHOP,4     RESTORE XRC
*25                   
       TZE RESET      OK IF ZERO
       REM            
       REM            
       LXD SHOP,4     N.G. PROGRAM OUT OF 
       TTR SPACE      SEQUENCE
       REM            INDICATE SPACE ERROR
       REM            AND RETURN TO ROUTINE THAT
       REM            WAS LAST STARTED IN
       REM            SEQUENCE.
       REM            
*      MONITOR, PART 2, RESET AND RETURN
       REM            
       REM            
RESET  SLF            LIGHTS OUT
       CPY            TURN ON I/O CHECK LITE
       SXD MONIT,4    
       LDC MONIT,4    
       SXA EXIT-1,4   FOR DCTERR + TRPFLR.
       TXI *+1,4,1    GET RETURN ADDRESS
*5                    
       SXA EXIT,4     
       CLA PROP2+1,   
       STO            POST RESTART
       PXD            CLEAR ACC
       XCA            AND 
*10                   
       PXD            MQ
       TOV *+1        
       TQO *+1        
       EFTM           
       LSNM           
*15                   
       PAI            
       AXT 0,7        
       STZ TRAP       
       DCT            
       NOP            
*20                   
       STZ SHOP       
       STZ SHOP+1     
       SIL **         IND FOR DCTERR + TRPFLR.
EXIT   TRA **         RETURN
MONIT  OCT +0         
       REM            
       REM            
       REM            
*      DIV CK ERROR INDICATION.
*      ON PRINTOUT, DECREMENT OF SI REG CONTAINS TEST LOC IN ERRO
       REM            
       BCD 1DCTERR    
DCTER  NOP            
       REM            
       REM            
*      TRAP FAILURE INDICATION.
*      ON PRINTOUT, DECREMENT OF SI REG CONTAINS TEST LOC IN ERROR
       BCD 1TRPFLR    
TRPER  NOP            
       REM            
       REM            
*      MONITOR, PART 3, SPACE ROUTINE.
       REM            
SPACE  SXD BIN,4      SAVE ERR ADDRESS
       LXA COUNT,4    
       TXI *+1,4,1    COUNT ERRS
       SXA COUNT,4    
       LXA COUNT+6,4  COUNT SPACE ERRS
*5                    
       TXI *+1,4,1    
       SXA COUNT+6,4  
       STI SHOP+5     SAVE SI
       TRA *+2        IND ERR AND RETURN
       REM            
*WE WILL RETURN TO THE ROUTINE THAT WAS LAST STARTED CORRECTLU.
       REM            
       BCD 1SPACE     
*10                   
       NOP            FOR FUTURE USE
       LDC BIN,4      
       SXD BIN,4      
       LDC MONIT,4    ADDRESS OF TEST THAT
       SXA BIN,4      LOST CONTROL
*15                   
       LDI BIN        
       TSX ERROR-1,4  PROGRAM SKIP OUT OF
       NOP *-7        CONTROL. THE ADDRESS
       REM            FROM WHICH WE RECOVERED
       REM            CONTROL IS IN THE
       REM            DECREMENT OF THE SI.
       REM            THE STARTING ADDRESS
       REM            OF THE TEST WHICH WAS
       REM            UNDERWAY IS IN THE
       REM            ADDRESS OF THE SI.
       LXD MONIT,4    
       CLA -2,4       
*20                   
       PAC ,2         RESET MONITOR
       SXD MONIT,2    
       LDI SHOP+5     RESTORE SI
       TRA 0,4        RETURN TO ROUTINE
BIN    HTR            THE LOST CONTROL.
       REM            
*      MONITOR, PART 4, PROGRAM START AND STOP CONTROL.
       REM            
       REM FLUID DRIVE 
       REM            
START  AXT ERROR-2-WOW,1
       CLA CATCH      TSX SPACE,4
BURMA  STO ERROR-1,1  
       TIX BURMA,1,1  
       AXT 32767-PR,1 FILL ER UP
SHAVE  STO ,1         
       TIX SHAVE,1,1  
       AXC EST,4      
       SXD MONIT,4    SET MONITOR
       AXT 9,1        CLEARING OUT PASS AND
       STZ PASS+9,1     ERROR COUNT LOCATIONS.
       TIX *-1,1,1    
       REM            
       NOP            
       SWT 3          
       TRA *+2        PRINT ID
       TRA RESET      DONT PRINT
       WPRA           EXTRA SPACE
       TSX SPLAT,4    PRINT ID.
       HTR 11,0,6     CONTROL WORD.
       BCD 69EFP SECTION 2, EXTENDED PRECISION
       BCD 5FLOATING POINT TEST BEGINS.
       WPRA           SPACE
       TCOA *         WAIT FOR DISCONNECT
       AXC EST,4      
       TRA RESET      BEGIN 9EFP
       REM            
       REM MONITOR, PART 4, CONTINUED
DONE   SWT 6          
       TRA STOP       END 9EFP IF 6 IS UP
       REM            
       REM REPEAT PROGRAM IS SW6 DOWN.
       REM PRINT N PASSES COMPLETE
       REM AND TOTAL PASSES IF 3 IS UP
       LXA PASS,1     
       LXA PASS+1,2   
       TXI *+1,1,1    
       TXI *+1,2,1    
       SXA PASS,1     SAVE
       SXA PASS+1,2   COUNT
       REM            
       TXH *+3,1,99   PRINT ON N PASSES.
       AXC EST,4      
       TRA RESET      RESTART
       REM            
       REM            
       STZ PASS       CLEAR ON EACH N PASSES
       REM            TOTAL PASS COUNTER STILL COUNTS
       SWT 3          PRINT ON N-TH PASS, ONLY
       TRA *+3        IF SW3 IS UP.
       AXC EST,4      IF SW3 IS DOWN
       TRA RESET      DONT PRINT.
       REM            
       PXA ,1         
       TSX BTEN,4     TRANSLATE TO BCD
       NOP            
       STQ NPASS+3    N-TH PASS COUNT
       PXA ,2         
       TSX BTEN,4     TRANSLATE TO BCD
       NOP            
       STQ NPASS+7    TOTAL PASS COUNT
       WPRA           EXTRA SPACE
NPASS  TSX SPLAT,4    PRINT N PASSES COMPLETE SIGNAL
       HTR 9,,7
       BCD 59EFP,        PASSES. TOTAL OF
       BCD 4       PASSES COMPLETED.
       REM            
       TCOA *         WAIT FOR DISCONNECT.
       REM NOTE..I/O CHECK LITE IS TURNED ON PURPOSEL
       AXC EST,4      
       TRA RESET      REPEAT 9EFP
       REM            
       REM MONITOR, PART 4, CONTINUED.
       REM SW6 IS UP, PRINT END OF PROG INFO AND LOAD CARD
STOP   STZ PASS       CLEAR N PASS COUNTER
       LXA PASS+1,2   COUNT LAST PASS IN
       TXI *+1,2,1    TOTAL PASS COUNTER
       SXA PASS+1,2   SAVE TOTAL PASS COUNT, BUT
       TXL WWDC,2,1    DONT PRINT IF
       SWT 3            ONLY ONE PASS
       TRA *+2           COMPLETED, OR
       TRA WWDC             IF SW3 IS DOWN.
       REM            
       WPRA           EXTRA SPACE
       PXA ,2         
       TSX BTEN,4     TRANSLATE TO BCD.
       NOP            
       STQ WTOP+7     TOTAL PASS COUNT.
WTOP   TSX SPLAT,4    PRINT
       HTR 10,,7      
       BCD 59EFP, EX. PREC. FP TEST ENDS.
       BCD 5       TOTAL PASSES COMPLETED.
       REM            
       REM MONITOR, PART 4, CONTINUED.
       REM PRINT ERROR STATISTICS, IF ANY.
       REM            
       REM            
       LXA COUNT,1    PRINT ERROR REPORT
       TXL WWDC,1,0   IF THERE WERE ANY ERRORS.
       WPRA           EXTRA SPACE
       TSX SPLAT,4    PRINT
       HTR 5,,18      
       BCD 5ERROR REPORT BY TYPE OF ERROR.
       TSX SPLAT,4    PRINT
       HTR 9,,7       
       BCD 5 TOTAL      OV     P+Q     ACC
       BCD 4      MQ    ZERO   SPACE
       REM            
       AXT 7,1        
       CLA COUNT+7,1  
       TSX BTEN,4     TRANSLATE TO BCD
       NOP            
       STQ SHOP+7,1   SPECIAL SALON FOR TRANLATED WORDS
       TIX *-4,1,1    
       REM            
       REM MONITOR, PART 4, CONTINUED
       REM MOVE TRANSLATED WORDS TO BCD IMAGE
       LDQ SHOP       
       STQ WEAM+2     
       PXD            CLEAR
       CAL BLANK      
       LDQ SHOP+1     
       LGL 6*4        
       SLW WEAM+3     
       LGL 12         
       LDQ BLANK      
       LGL 12         
       LDQ SHOP+2     
       LGL 12         
       SLW WEAM+4     
       XCL            
       ORA BLANK+1    
       SLW WEAM+5     
       LDQ SHOP+3     
       STQ WEAM+6     
       CAL BLANK      
       LDQ SHOP+4     
       LGL 6*4        
       SLW WEAM+7     
       LGL 12         
       LDQ BLANK      
       LGL 12         
       LDQ SHOP+5     
       LGL 12         
       SLW WEAM+8     
       LGL 6*4        
       LDQ BLANK      
       LGL 12         
       SLW WEAM+9     
       LDQ SHOP+6     
       STQ WEAM+10    FINAL WORD MOVED
       REM            
*      ON WITH DOWNBEAT.
       REM            
       REM MONITOR, PART 4, CONTINUED.
       REM PRINT STATISTICS, CLEAR, AND END PROGRAM
       REM BECAUSE SW6 IS UP.
WEAM   TSX SPLAT,4    PRINT
       HTR 9,,7       
       BCD 9          
       REM WORDS PLACED HERE BY PREVIOUS ROUTINE
       AXT 7,1        
       STZ SHOP+7,1   CLEAR SALON
       TIX *-1,1,1    
       REM            
       WPRA           
       SPRA 1         SKIP OUT PAGE
       REM            
       REM            
*POLTERGIESTS ARE SPONTANEOUS, ECOTPLASMIC FIGMENTS OF THE IMAGINATION.
       REM            
       REM RESET AND LOAD CARDS.
WWDC   TCOA *         WAIT FOR DISCONNECT
       TSX RESET,4    
       IOT            TURN OFF. I/O CHECK IS TURNED
       NOP            ON INTENTIONALY BY THE RESET ROUTINE
       REM            
       RCDA           PUSH LOAD BUTTON
       RCHA WOW       
       LCHA           
       TTR 1          
       REM            
       REM MONITOR, PART 5, MANUAL RESTART CONTROL.
       REM            
*AN STR INSTRUCTION IS AT ZERO. SO IF YOU HAVE PRESSED RESET
*AND START, THE I/O CHECK LITE WILL BE OFF, AND THE
*ADDRESS AT ZERO WILL BE ON.
       REM            
RESTR  LTM            
       IOT            SHOULD BE OFF
       TRA WARL       ERR, NO RESET
       REM            
       REM            
       LXA ,4         
       TXH WARL,4,1   SHOULD BE ONE
       TXL WARL,4,0   SHOULD NOT BE ZERO
       REM            
       REM OK, MANUAL RESET. IF SW1 IS DOWN, RETURN
       REM TO ROUTINE WHICH WAS INTERRUPTED. OTHERWISE
       REM            
       SWT 1          
       TRA *+3        
       REM            
       LXD MONIT,4    RETURN TO SAME ROUT. SINCE
       TRA 0,4        SW 1 IS DOWN.
       REM            
       AXC EST,4      RESTART 9EFP ON RESET WITH
       TRA RESET      SW 1 UP.
       REM            
WARL   AXC 2,4        ERROR, GOT TO LOCATION 2
       TRA SPACE       BY MISTAKE
       REM            
       REM MONITOR, PART 6, FP TRAP CONTROL
       REM            
*IF AN ADDRESS HAS BEEN SUPPLIED BY THE MAIN PROGRAM.
       REM            
*THEN THE TRAP IS OK. XRC SHOULD BE ZERO ON ALL TRAPS.
       REM            
       REM            
TRAP   HTR **         MAIN PROGRAM SUPPLIES ADDRESS
       LTM            
       NZT TRAP       
       TRA WOL        NO ADDRESS SUPPLIED
       TXH WRC,4,0    XRC SHOULD BE ZOER ON TRAP
       LXA TRAP,4     OK, GET RETURN
       STZ TRAP       RESET BEFORE NEXT TRAP
       SXA *+2,4      
       AXT ,4         CLEAR XRC
       TRA **         RETURN TO PROGRAM
       REM            
       REM            
       REM NO ADDRESS SUPPLIED BY MAIN PROGRAM.
       REM DID WE TRAP IN ERROR, OR SKIP TO 10
       REM            
WOL    SXA *+3,1      SAVE
       LXA 0,1        
       TXH *+4,1,0    IF NO ADD. AT ZERO-SPACE
       AXT **,1       RESTORE
       AXC 8,4        GOT TO 10 IN ERROR
       TRA SPACE      
       REM            
       SXA WRC-2,1    SAVE TRAP ADDRESS.
       LXA *-4,1      RESTORE
       LXA COUNT,4    COUNT
       TXI *+1,4,1      TOTAL
       SXA COUNT,4        ERRORS
       LXA COUNT+5,4  COUNT
       TXI *+1,4,1       TRAP
       SXA COUNT+5,4       ERRORS
       TRA *+2        
       BCD 1TRAP      
       TSX ERROR-1,4  TRAP TO 10 WHEN NO TRAP EXCPECTED.
       NOP *-1        WILL RETURN TO LOC
       TRA **         IN ADD. PART OF ZERO
       REM            
       REM MONITOR, PART 6, CONTINUED.
       REM            
       REM            
       REM            
       BCD 1I TIME    
WRC    STZ SHOP+10    
       SXA SHOP+10,4  
       STI SHOP+11    
       LDI SHOP+10    
       TSX ERROR-1,4  XRC WAS NOT ZERO ON TRAP.
       NOP WRC        EITHER, TRAP WAS AT WRONG TIME.
       REM            OR XRC WAS LOADED DURING THE
       REM            TRAP OPERATION. THE CONTENTS
       REM            OF XRC HAVE BEEN PLACED IN THE SI
       LXA COUNT,4    COUNT
       TXI *+1,4,1      TOTAL
       SXA COUNT,4        ERRORS
       LXA COUNT+5,4  COUNT
       TXI *+1,4,1       TRAP
       SXA COUNT+5,4       ERRORS
       LXA TRAP,4     GET RETURN
       STZ TRAP       RESET BEFORE NEXT TRAP
       SXA *+3,4      SET RETURN.
       LDI SHOP+11    RESTORE SI
       LXA SHOP+10,4  RESTORE XRC
       TRA **         RETURN TO PROGRAM
       REM            
       REM            
       REM            
       REM           INDEXABLE BCD PRINT SUBROUTINE.
*THIS  SUBROUTINE USES THREE SYMBOLS, THEY ARE...
       REM           SPLAT, THE FIRST WORD OF THE ROUTINE
       REM           CI, USED FOR CARD IMAGE, 26 LOCATION
       REM           SUBET, THE CONTENTS OF XRC ARE STORED
       REM                     IN THE ADDRESS OF SUBET.
*CONDTION  OF THE ACC, MQ, AND ACC OVERFLOW
*TRIGGER  IS NOT GUARANTEED ON EXIT FROM THIS ROUTINE.
       REM           THE PRINTER ON CHANNEL A IS USED
       REM           YOU MAY ENTER SPLAT+1 IF YOU HAVE
       REM           ALREADY GIVEN WRIT SELECT.
       REM           THE RCHA INSTRUCTION IS AT SPLAT+60.
       REM           THERE IS NO CHANNEL DELAY IN THE
       REM           SUBROUTINE, THEREFORE TAKE CARE NOT
       REM           TO USE CI UNTIL AFTER 12 ROW-RIGTH
       REM           HAS BEEN WRITTEN. FOR THIS REASON,
       REM           YOU MUST GIVE WRS FOR EACH ENTRY
       REM           OR ENTER AT SPLAT.
CRNCH  WPUA          FOR PUNCHING ENTRY.
       TRA *+2        
SPLAT  WPRA          FOR PRINTING ENTRY.
       SXA SPLAT+61,1   SAVE XRA
       SXA SPLAT+62,2   SAVE XRB
       SXA SUBET,4   SAVE ORGINAL XRC.
       NZT 1,4       IF CONTROL WORD ZERO.
       REM            
*5                    
       TRA 2,4       RETURN TO MAIN PROGRAM.
       REM            
       CAL 1,4       GET NON-ZERO WORD
       SLW SPLAT+85  SAVE CONTROL WORD
       PDX **,1      TYPE WHEEL NO. OR COL NO.
       TXL SPLAT+65,1,0 IF DECR. ZERO, GET
       REM              SECOND CONTROL WORD
       REM            
*10    EVALUATION EXIT ADDRESS.
       SXD *+2,4     TSX LOCATION.
       PAC 0,2       2S COMPL OF NO. BCD WORDS.
       TXI *+1,2,**   
       SXA SPLAT+63,2 EXIT VALUE.
       REM            
*      SETTING START COL FOR FILLING CARD IMAGE.
       SXA *+3,1     FOR SHIFTING
       REM            
*15                   
       AXT 1,3       1 TO XRA AND XRB
       CAL SPLAT+82  BIT INDEX TO P
       LGR **,1      SHIFT TO STARTING POINT
       TNZ *+3       IF ACC IS ZERO, SET FOR
       STQ SPLAT+83  RIGHT ROW, AND MAKE
       REM            
*20                   
       TXI *+2,2,1   XRB A DUECE
       SLW SPLAT+83  OTHERWISE, LEFT ROW.
       AXT 26,1       
       STZ CI+26,1   CLEAR CARD IMAGE
       TIX *-1,1,1    
       REM            
       REM FORM CARD IMAGE.
       REM            
*25                   
       TIX *+1,4,1   ADDRESS OF FIRST WORD.
       AXT 6,1       CHARACTER COUNT.
       LDQ 1,4       GET THE WORD.
       SXA SPLAT+54,1 SAVE CHARACTER COUNT.
       PXD           CLEAR ACC
       REM            
*30                   
       LGL 2         ZONE
       ALS 1         TIMES 2
       PAX 0,1        
       SXA SPLAT+45,1 FOR FUTURE REFERENCE.
       CLM            
       REM            
*35                   
       LGL 4         DIGIT
       ALS 1         TIMES 2
       SLW CI        TEMP0
       CAL SPLAT+83  BIT INDEX
       NZT CI        IS DIGIT ZERO.
       REM            
*40                   
       TXH SPLAT+80,1,0 IS ZERO ZONE TOO.
       LXA CI,1      OK, PROCEED
       TXH SPLAT+48,1,24 CHECK FOR ILLEGAL
       TXH SPLAT+78,1,20 SPECIAL CHARACTER.
       ORS* SPLAT+92,2 XRB PICKS LEFT OR RIGHT.
       REM            
*45                   
       AXT **,1      ZONE AGAIN.
       TXL *+2,1,0   NOTHING FOR ZERO ZONE
       ORS* SPLAT+90,2 PLACE ZONE BIT.
       REM            
       REM  COLUMN SET.
       REM            
       ARS 1         SET BIT INDEX TO 
       TNZ *+4       NEXT COLUMN, IF ANY.
       REM            
*50                   
       TXH SPLAT+60,2,1 IF BX ZERO,+XRB 1, STOP
       REM            
       CAL SPLAT+82  IF NOT, SET TO RIGHT
       TXI *+1,2,1   ROW AND PROCEED.
       SLW SPLAT+83  BX READY FOR NEXT COLUMN.
       AXT **,1      MORE CHARACTERS.
       REM            
*55                   
       TIX SPLAT+28,1,1 NEXT COLUMN
       LXA SPLAT+85,1 MORE WORDS MAYBE.
       TNX *+3,1,1    IF NOT, STOP.
       SXA SPLAT+85,1 YUMMY, GO GET EM.
       TXI SPLAT+25   
       REM            
*60                   
       RCHA SPLAT+84  LET HER RIP
       AXT **,1       
       AXT **,2       
       AXT **,4       
       TRA 2,4         EXIT
       REM            
       REM  GET NEW CONTROL WORD FROM SOMPLACE
       REM            
*65                   
       SXA SPLAT+63,4 FOR EXIT
       LXA SPLAT+61,1 RESTORE XRA
       NZT* SPLAT+85 IF CONTROL WORD ZERO
       TRA SPLAT+61  RETURN.
       CAL SPLAT+85  OLD CONTROL WORD
       REM            
*70                   
       STT *+1       BRING OUT INDEX
       SXD *+2,0     REGISTER, IF ONE IS TAGED.
       PAC 0,4        
       TXI *+1,4,0   GET EFFECTIVE ADDRESS.
       CAL 0,4       NEW CONTROL WORD.
       REM            
*75                   
       PDX 0,1       TYPE WHEEL ID.
       SLW SPLAT+85   
       TXI SPLAT+14,4,1 PROCEED
       REM            
       REM YOUR AN OLD SMOOOTHY.
       REM            
       ORS* SPLAT+88,2 PUT EIGTH IN, TAKE
       TIX SPLAT+44,1,16 16 OUTM, - GOOD BUSINESS
       REM            
*80                   
       TXL SPLAT+47,1,4 IF NOT BLANK, SET ZONE.
       TRA SPLAT+48    BLANK.
       REM            
       MZE             FOR BIT INDEX.
       HTR             DYNAMIC BIT INDEX.
       IOCD CI+2,,24   BUFFER COMMAND
       REM            
*85                   
       HTR             SPECIAL SALON FOR
       REM             THE CONTROL WORD
       HTR CI+5       
       HTR CI+4        BROW ADDRESSES
       HTR CI+27,1    
       HTR CI+26,1     ZONE ROW ADDRESSES
       REM            
*90                   
       HTR CI+21,1    
       HTR CI+20,1     DIGIG ROW ADDRESSES
       REM            
CI     BSS 26         
SUBET  BSS 1          
*             BINARY TO OCTAL BCD SUBROUTINE
       REM            
       REM            
*      TRANSFORMS THE CONTENTS OF ACC 1-35 TO OCTAL IN BCD FORMAT.
*      TRANSFORMED WORD IN MQ AND ACC, WITH LOW ORDER IN MQ.
       REM            
*      CALLING SEQUENCE-
*        A   TSX PX,4 
*        A+1 PZE   COL 21-  STORAGE FOR SIGN BIT, NOT TRANSFORMED.
*                  COL 34-35-- STOREAGE FOR Q AND P, NO TRANSFORMED.
*        A+2       RETURN HERE WHEN MORE THAN SIX CHARACTERS.
*         A+3    RETURN HERE WHEN SIX OR LESS CHARACTERS.
       REM            
*      NO BLANKS ARE INSERTED FOR LEADING ZEROS.
       REM            
       REM            
PX     SXA PX+24,1    
       SXA PX+25,2    
       SXA PX+28,4    SAVE XRC
       STO FREER      
       ARS 35         P AND Q
       STA 1,4        P AND Q TO X+1
       LDQ FREER      
       PXD            CLEAR ACC
       LGL 1          
       ALS 11         SIGN IF MINUS
       REM            
*10                   
       ORS 1,4        SIGN TO X+1
       LGR 1          DROP SIGN
       AXT 6,3        
       PXD            CLEAR ACC
       ALS 3          ZONE
       REM            
       LGL 3          DIGIT
       TIX *-2,1,1    6 TIMES.
       SLW FREER+1    
       PXD            CLEAR ACC
       ALS 3          ZONE
       REM            
*20                   
       LGL 3          DIGIT
       TIX *-2,2,1    6 TIMES
       XCL            SECOND WORD TO MQ,
       CAL FREER+1    FIRST TO ACC
       AXT **,1       RESTORE XRA
       AXT **,2       RESOTRE XRB
       TZE 3,4        X+3 FOR 1 WORD.
       TRA 2,4        X+2 FOR 2 WORDS.
       OCT +0         TEMP FOR XRC.
       REM            
       REM            
FREER  BSS 3          
       REM            
*                FIXED BINARY TO FIXED DECIMAL BCD
       REM            
       REM            
       REM            
*      TRANSFORMS THE CONTENTS OF ACC P-35 TO DECIMAL BCD.
*      TRANSFORMS WORD IN MQ AND ACC WITH LOW ORDER DIGITS IN MQ.
       REM            
*      CALLING SEQUENCE
*        A   TSX BTEN,4
*        A+1       RETURN HERE WHEN MORE THEN SIX DECIMAL DIGITS.
*        A+2       RETURN HERE WHEN SIX OR LESS DECIMAL DIGITS.
       REM            
       REM            
*      BLANKS ARE INSERTED FOR LEADING ZEROES-
*      THE SIGN OF NUMBER IS ATTACHED, IF NO. IS LESS THAN 12 DEC DIGITS.
*           BLANK FOR PLUS
*           MINUS FOR MINUS
       REM            
       REM            
BTEN   SXA BTEN+23,1  
       SXA BTEN+24,2  
       SXA BTEN+39    SAVE XRC.
       SLW FREE       DROP SIGN
       CLM            
       STO FREE+3     SAVE SIGN
       STZ FREE+1     
       STZ FREE+2     
       AXT 2,2        
       AXT 36,1       
       REM            
*10                   
       PXD            CLEAR ACC.
       LDQ FREE       
       NZT FREE       WHEN ZERO-
       TRA BTEN+26    FINISHED.
       DVP BTEN+38    BY 10 DECIMAL.
       STQ FREE       
       ALS 36,1       SHIFT TO POSITION,
       ACL FREE+3,2   TACK ON LOW ORDER-
       SLW FREE+3,2   SAVE PARTIAL RESULT.
       TIX BTEN+10,1,6 GET NEXT DIGIT, OR
       REM            
*20                   
       TIX BTEN+9,2,1 SECOND WORD.
       CLA FREE+2     IF XRB RUNS OUT BEFORE
       REM            QUOT. IS ZOER, NO
       REM            ROOM FOR SIGN.
       LDQ FREE+1     LOW ORDER TO MQ.
       AXT **,1       RESTORE XRA
       AXT **,2       RESTORE XRB
       REM            
       TRA 1,4        EXIT-TO X+1 FOR 2 WORDS.
       CLA FREE+3     BRING IN SIGN.
       ORA BTEN+36    BLANK-MINUS.
       TMI *+2        WAS WORD MINUS.
       CAL BTEN+37    NO, GET BLANKS
       REM            
*30                   
       ALS 36,1       
       ACL FREE+3,2   NON-ZERO DIGITS.
       TXL BTEN+22,2,1 OUT ON HIGH ORDER
       XCL            
       CAL BTEN+37    HIGH ORDER BLANK.
       REM            
       TXI BTEN+23,4,-1 RETURN TO X+2
       OCT -406060606040 BLANK MINUS.
       OCT 606060606060  BLANK PLUS
       HTR 10         DIVISOR
       REM            
FREE   BSS 4          
       REM            
******************************************************************
       REM            
****   CONSTANT USED FOR MPY AND EMP.
       REM            
******************************************************************
       REM            
       REM            
P52S   OCT 525252525252
BS134  OCT -377777777776
BS135  OCT -377777777777
B135   OCT +377777777777
B1235  OCT 300000000001
ALTMD  OCT -040000777777,-377777777774
MSK34  OCT -377777777774  MSK FRO EDPEMP TEST.
MSK2   OCT +000000060000
K1     OCT 040000000000
       OCT 000000000000
K2     OCT 440000000000
       OCT 000000000000
K3     OCT 040000000000
       OCT 400000000000
K4     OCT 040000000000
       OCT 477777777777
K5     OCT 040000000000
       OCT 300000000000
K6     OCT 040000000000
       OCT 200000000000
K7     OCT 070000000000
       OCT 200000000000
K8     OCT 010000000000
       OCT 200000000000
K9     OCT 040000000000
       OCT 000000000001
       NOP            
       NOP            
EP20   OCT +040005000000,+240000000000
       REM SOME UNNORMALIZED EXT PREC NUMBERS.
UEP1   OCT +040043000000,+000000000001
UEP4   OCT +040002000000,+100000000000
UEP16  OCT +040004000000,+100000000000
UEPE6  OCT +040025000000,+172044000000
       REM            
****   CONSTANTS USED FOR EDP AND DVP
       REM            
D1     OCT +200000000000
D2     OCT +252525252525
D3     OCT -200000000000
D4     OCT +0         
D5     OCT +2         
D6     OCT +125252525252
D7     OCT +104210204041
D8     OCT -125252525252
D9     OCT +1         
D10    OCT -0         
D11    OCT -377777777777
D12    OCT +347777777777
D13    OCT +030000000000
       OCT -200000000000
D14    OCT +040000000000
D15    OCT +340000000000
D16    OCT +377777777777
D17    OCT +040000000000
       OCT +100000000000
D18    OCT +040000000000
       OCT -100000000000
D19    OCT -040000000000
       OCT +100000000000
D20    OCT +040000000000
       OCT +200000000000
D21    OCT +040000000000
       OCT +300000000000
D22    OCT +040000000000
       OCT -200000000000
D23    OCT -040000000000
       OCT -200000000000
D24    OCT -040000000000
       OCT +200000000000
D25    OCT +007000000000
       OCT +200000000000
D26    OCT 077777000000
       OCT 200000000000
D27    OCT 010000000000
       OCT 200000000000
D28    OCT 050101000000
       OCT 300000000000
D29    OCT +243210323232
       OCT +100000000001
D30    OCT +12345232323
       OCT +100000000000
D31    OCT +000001000000
D32    OCT +040002000000,+200000000000
       REM            
*      EXTENDED PRECISION FLOATING POINT EQUIVALENTS OF THE
*POWERS OF TEN UP TO AND INCLUDING THE 20TH POWER.
       REM            
EPE0   OCT +040001000000,+200000000000
EPE1   OCT +040004000000,+240000000000
EPE2   OCT +040007000000,+310000000000
EPE3   OCT +040012000000,+372000000000
EPE4   OCT +040016000000,+234200000000
EPE5   OCT +040021000000,+303240000000
EPE6   OCT +040024000000,+364110000000
EPE7   OCT +040030000000,+230455000000
EPE8   OCT +040033000000,+276570200000
EPE9   OCT +040036000000,+356326240000
EPE10  OCT +040042000000,+225005744000
EPE11  OCT +040045000000,+272207335000
EPE12  OCT +040050000000,+350651224200
EPE13  OCT +040054000000,+221411634520
EPE14  OCT +040057000000,+265714203644
EPE15  OCT +040062000000,+343277244615
EPE16  OCT +040066000000,+216067446770
EPE17  OCT +040071000000,+261505360566
EPE18  OCT +040074000000,+336026654723
EPE19  OCT +040100000000,+212616214043
EPE20  OCT +040103000000,+255361657053
       REM            
********************CONSTANTS*************************************
       REM            
       REM USED FOR ADD/SUB, AND SUBROUTINES.
       REM            
LGC1   OCT 040005000000
       OCT 010000000000
LGC2   OCT 040051000000
       OCT 200000000000
       OCT 077777000000
       OCT 200000000000
LGC3   OCT 074637000000 *
       OCT 377777777777 *
       OCT 074575000000 *
       OCT 200000000000 *
LGC4   OCT 040076000000 *
       OCT 200000000014
       OCT 040100000000
       OCT 037777777777
C43    OCT 040043000000
       OCT 177777777777
       OCT 040042000000
       OCT 377777777777
C41    OCT 000041000000
       OCT 040060000000
       OCT 200000000000
       PZE ,,1        
       PZE ,,20M      
       REM            
IND    BSS 1          ERROR INDICATOR
COL18  OCT 400000     BIT IN COL 18
COL19  OCT 200000     BIT IN COL 19
MQ                    TEMPOS
ACC                   
PQ                    
ZERO                  
ONE    DEC 1,2,3,4,5  
       DEC 6,7,8,9,10 
COLS   MZE            BIT IN COL S.
COL1   PTW            BIT IN COL 1
COL2   PON            BIT IN COL 2
COL3   PZE ,,4096*4   BIT IN COL 3
COL4   PZE ,,4096*2   BIT IN COL 4
COL5   PZE ,,4096     BIT IN COL 5
PROP2  OCT 200        
       STR            
CATCH  TSX SPACE,4    
PASS   BSS 2          PASS COUNTERS
COUNT  BSS 7          COUNT ERRS, TOTAL, OV,
       REM            PQ, ACC, MQ, LOC ZERO,
       REM            AND SPACE ERRS
EONE   PZE ,,40M+1    EXTENDED ONE
       PTW            40001.2
ETWO   PZE ,,40M+2    EXTENDED TWO
       PTW            40002.2
ETHRE  PZE ,,40M+2    EXTENDED 3
       PTH            40002.2
EFOUR  PZE ,,40M+3    EXTENDED 4
       PTW            40003.2
EFIVE  PZE ,,40M+3    EXTENDED 5
       PTW ,,40M      40003.24
ESIX   PZE ,,40M+3    EXTENDED 6
       PTH            40003.3
ESVN   PZE ,,40M+3    EXTENDED 7
       PTH ,,40M      40003.34
EEIT   PZE ,,40M+4    EXTENDED 8
       PTW            40004.2
ENINE  PZE ,,40M+4    EXTENDED 9
       PTW ,,4096*2   40004.22
ETEN   PZE ,,40M+4    EXTENDED 10
       PTW ,,40M      40004.24
EZERO  OCT 0,0        NORMAL EXTENDED ZERO.
FLOAT  OCT 040043000000,0
       OCT 000001000000
       OCT 020000000000
AONES  MTH -1,7,-1    ALL ONES S-35
PONES  PTH -1,7,-1    ALL ONES 1-35
ALTON  OCT -125252525252 ALTERNATE ONES-MINUS
ALTNP  OCT 252525252525 ALTERNATE ONES-PLUS
       REM            
BLANK  BCD 1          
       BCD 10000      
C      EQU 64         100 OCTAL
M      EQU 512        1000 OCTAL
10M    EQU 4096 10,000 OCTAL
40M    EQU 4096*4     40,000 OCTAL
20M    EQU 4096*2     20,000 OCTAL
WOW    IOCT ,,3       
SHOP   BSS 14         WORKING STORAGE
ERROR  EQU 3396       
OK     EQU 3401       
PR     EQU 4032       
       END START      

