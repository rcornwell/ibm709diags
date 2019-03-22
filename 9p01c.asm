                                                             9P01C
                                                             11/16/59
************************************************************************
*                                                                      *
*                                                                      *
*                              9PC01C                                  *
*                                                                      *
*                            A DIAGNOSTIC AND                          *
*                      RELIABILITY TEST FOR THE 716                    *
*                        PRINTER AND THE 766 DATA                      *
*                     SYNCRONIZER COMPONENETS OF THE                   *
*                       709 DATA PROCESSING SYSTEM.                    *
*                                                                      *
*                                                                      *
************************************************************************
       REM          
       REM          
       REM          
       ORG 24       
       REM          
       REM          
       TSX IOC,4     LOAD KEYS AND SAVE
       REM           CONTROL CONSTANTS.
       REM
       TSX RSET,4    RESET PART ONE TO
       PZE START,,NOMOD CHANNEL -A-.
       REM          
       ZET SIZE     
       TRA *+3       4K
       REM          
       TSX RSET,4    NOT 4K-RESET PART 2
       PZE STRTB,,FRSTB TO CHANNEL -A-.
       REM          
       CLA RSTRT     POST
       STO 0         RESTART
       REM          
       CLA IOCT      INITIALIZE I/O COUNT.
       STO IOCNT    
       REM          
       LDI CTRL1     TEST I/O CONTROL FORMAT
       RFT 100002    FOR CHANNEL A.
       TRA START     CHANNEL A PRESENT.
       REM          
 ZCE   TSX CTX,4     MODIFY TO NEXT CHANNEL.
       PZE START,,NOMOD PART ONE.
       REM          
       ZET SIZE      TEST STORAGE SIZE.
       TRA START     4K.
       REM
       TSX CTX,4     MORE THEN 4K, MODIFY
       PZE STRTB,,FRSTB PART TWO.
       REM          
       REM          
       REM          
*      *** INITIALIZE COMMENT CARD IMAGES TO STATE
*      *** WHICH CHANNEL IS BEING TESTED.
       REM          
       REM          
 START TRA *+2      
       REM          
       WPRA          DUMMY INSTRUCTION TO BE
       REM           MODIFIED BY IOM.
       REM          
       AXT 3,4      
       CLA *-2      
       CAS STRTA+3,4 COMPARE CHANNEL A,C,E.
       TRA *+2      
       TRA *+3      
       TIX *-3,4,1  
       REM          
      #HTR 24        DUMMY INSTRUCTION AT
       REM           START+1 NOT CORRECTLY
       REM           INITIALIZED. PRESS START
       REM           TO RETURN TO IOM TO
       REM           RELOAD THE KEYS AND RESTART
       REM           PROGRAM.
       REM          
       CAL CDZAB+3,4 PICKUP CHANNEL INFORMATION
       SLW CDZAA+9   AND STORE IN BCD IMAGES.
       SLW CDZAC+8  
       REM          
       REM          
       REM          
*AA    *** PRINTER DISCONNECT TEST.
       REM          
*          A SERIES OF PRINTER SELECTS ARE GIVEN TO TEST
*          THE ABILITY OF THE PRINTER TO DISCONNECT
*          UNDER ALL CONDITIONS. COMMENTS ARE PRINTED
*          IN THE PROCESS AND A CURSORY TEST OF THE SENSE
*          PRINTER * INSTRUCTION IS PERFORMED.
       REM          
       REM          
 AAA   TSX RESET,4   CLEAR CONSOLE AND SET -MONIT-.
       REM          
       WPRA          TAKE AND IDLE CYCLE
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE           CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       TRA AAA+1     LOOP RETURN.
       REM          
       WPRA          FORRCE A CARRIAGE 
       SPRA 1        OVERFLOW.
       REM          
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE           CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DISCONNECT REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD          CORRECT DSC REGISTER CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA *-4       LOOP RETURN
       REM          
       WPRA          SPACE PRINTER.
       TCOA *       
       REM          
       TSX SPLAT,4   PRINT-NOW PREFORMING
       PZE CDZAA     DIAGNOSTIC TEST 9P01 ON
       TCOA *        CHANNEL X.-UNDER WPR.
       REM           IOCD WC-24.
       REM          
       WPRA          SPACE PRINTER
       TCOA *       
       REM          
       TSX SPLAT,4   PRINT-PRINTER DISCONNECT
       PZE CDAAA     TEST.
       TCOA *        IOCD WC-24.
       REM          
       REM          
 AAB   WPRA          CHECK ABILITY OF DS TO DISCONNECT
       REM           FROM ALL COMBINATIONS OF PRINTER
       REM           SELECTS.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
       WPRA          WPRA TO WPRA.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
       RPRA          WPRA TO RPRA.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
       RPRA          RPRA TO RPRA.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
       WPRA          RPRA TO WPRA.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
       WPBA          WPRA TO WPBA.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
       WPBA          WPBA TO WPBA.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
       RPRA          WPBA TO RPRA.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
       WPBA          RPRA TO WPBA.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
       WPRA          WPBA TO WPRA.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED
       SCHA *+3      DSC REGISTER CONTENTS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK
       IOCD          CORRECT DSC REGISTER CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       REM          
 AAD   TSX SPLAT,4   PRINT-MULTIPLE SELECT
       PZE CDAAB     DISCONNECT TEST COMPLETE.
       REM          
       TSX OK,4     
       TRA AAA       REPEAT SECTION.
       REM
       REM
       REM
       REM
*AB    *** CURSORY TET COLUMNS 1-72 UNDER
*      *** WRITE PRINTER WITH NO SELECTS IN
*      *** USE ON BOARD.
       REM          
 ABA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       TSX SPLTA,4   PRINT-CURSORY TEST
       PZE CDABA     COLUMNS 1-72 UNDER WPR.-
       TCOA *       
       REM          
       TSX SPLTR,4   CONVERT BCD TO HOLLERITH.
       PZE NUMBA     TEXT-UNITS POSITION OF
       REM           COLUMN NUMBERS 1-72.
 ABB   WPRA          
       RCHA CWCRD    PRINT -CARD+2-.
       TCOA *       
       IOT          
       NOP          
       SWT 1         TEST FOR TIGHT LOOOP.
       TRA *+2       UP-NO.
       TRA ABB       DN-LOOP.
       REM          
       WPRA          SPACE PRINTER.
       TSX OK,4      
       TRA ABA       REPEAT SECTION.
       REM          
       REM          
       REM          
*AC    *** CURSORY TEST COLUMNS 73-120 UNDER WRITE
*      *** PRINTER WITH SENSE PRINTER 2, 7 AND 9
*      *** USED TO PROVIDE RIGHT SIDE AND SPACE
*      *** AFTER PRINT.
       REM          
*          SENSE PRINTER 9 PROVIDES FOR PRINTING
*          COLUMNS 73-120. BECAUSE IT
*          NORMALLY WILL BEUSED WITH A DOUBLE
*          SELECT TO PRINT COLUMNS 1-120 IT
*          ALSO SUPPRESSES SPACING BEFORE PRINT.
*          THIS MAKES IT NECESSARY TO PROVIDE
*          SPACING IF COLUMNS 73-120 ARE
*          TO BE PRINTED ALONE. SENSE PRINTER
*          2 AND 7 GIVEN TO GETHER TO PROVIDE EXTRA
*          SPACE FACILITY.
       REM          
       REM          
 ACA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-CURSORY TEST COLUMNS
       PZE CDACA     73-120 UNDER WPR.
       TCOA *       
       REM          
       WPRA          SPACE PRINTER.
       REM          
       TSX SPLTR,4   CONVERT BCD TO HOLLERITH.
       PZE NUMBB     TEXT-UNITS POSITION OF
       REM           COLUMN NUMBERS 73-120.
       REM          
 ACB   WPRA          
       SPRA 9        RIGHT SIDE AND SUPPRESS SPACE.
       SPRA 7        7+2 TO GIVE
       TSX SPRA2,4   AN EXTRA SPACE
       REM
       RCHA CWCRD    PRINT -CARD+2-.
       REM          
       TCOA *       
       REM
       IOT          
       NOP          
       REM
       SWT 1         TEST FOR TIGHT LOOOP.
       TRA *+2       UP-NO.
       TRA ACB       DN-LOOP.
       REM          
       TSX OK,4      
       TRA ACA       REPEAT SECTION.
       REM          
       REM          
       REM          
*ACM   *** QUICK CHECK PRINT MAGNET ARMATURES AND
*      *** ANALYZER SETUP 120 COLUMNS UNDER RPR.
       REM          
       REM          
 ACMA  TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-CHECK ARMATURES AND
       PZE CDACM     ANALYZER SETUP 120 COLUMNS
       TCOA *        UNDER RPR
       REM          
       TSX CLEAR,4   CLEAR PRINT IMAGES.
       REM          
       CAL ONES      111111
       SLW IMAGE+16 
       SLW IMAGE+17 
       SLW IMAGA+16 
       SLW IMAGA+17 
       REM          
       TSX READB,4   PRINT PATTERN 1-120
       PZE 4         4 LINES
       WPRA          SPACE PRINTER.
       TSX CLEAR,4  
       REM
       CAL ONES      
       SLW IMAGE+12  333333
       SLW IMAGE+13 
       SLW IMAGA+12 
       SLW IMAGA+13 
       REM          
       TSX READB,4   PRINT PATTERN COLS 1-120
       PZE 4         4 LINES
       WPRA          SPACE PRINTER.
       TSX CLEAR,4  
       REM
       CAL ONES      
       SLW IMAGE+8   555555
       SLW IMAGE+9  
       SLW IMAGA+8  
       SLW IMAGA+9  
       REM          
       TSX READB,4   PRINT PATTERN COL 1-120
       PZE 4         4 LINES
       REM          
       WPRA          SPACE PRINTER.
       REM          
       TSX CLEAR,4  
       REM          
       CAL ONES      
       SLW IMAGE+6   666666
       SLW IMAGE+7  
       SLW IMAGA+6  
       SLW IMAGA+7  
       REM          
       TSX READB,4   PRINT PATTERN COLS 1-120
       PZE 4         4 LINES
       REM          
       WPRA          SPACE PRINTER.
       REM          
       TSX CLEAR,4   
       REM          
       CAL ONES      
       SLW IMAGE+4   777777
       SLW IMAGE+5  
       SLW IMAGA+4  
       SLW IMAGA+5  
       REM          
       TSX READB,4   PRINT PATTERN COLS 1-120
       PZE 4         4 LINES
       REM          
       TSX OK,4     
       TRA ACMA     
       REM          
       REM          
       REM          
*AD    *** PRINT 120 COLUMNS SPACED NUMERICS
*      *** AND ZONES UNDER READ PRINTER.
       REM          
       REM          
 ADA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-PRINT 120 COLUMNS
       PZE CDADA     SPACED NUMERICS AND ZONES
       TCOA *        UNDER RPR.
       REM          
       STZ ZONE1     SET
       STZ ZONE2     ZONING CELLS
       STZ ZONE3     TO ZERO.
       REM          
       TSX CLEAR,4   CLEAR PRINT IMAGES
       REM          
       REM          
 ADB   CAL KADA      SET NUMERIC PATTERN IN
       SLW IMAGE+1   9R
       SLW IMAGE+2   8L
       SLW IMAGA+1   9R
       SLW IMAGA+2   8L
       REM
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADB       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADC   CAL KADA      SET NUMERIC PATTERN
       SLW IMAGE+3   8R
       SLW IMAGE+4   7L
       SLW IMAGA+3   8R
       SLW IMAGA+4   7L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADC       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADD   CAL KADA      SET NUMERIC PATTERN.
       SLW IMAGE+5   7R
       SLW IMAGE+6   6L
       SLW IMAGA+5   7R
       SLW IMAGA+6   6L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADD       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADE   CAL KADA      SET NUMERIC PATTERN.
       SLW IMAGE+7   6R
       SLW IMAGE+8   5L
       SLW IMAGA+7   6R
       SLW IMAGA+8   5L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADE       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADF   CAL KADA      SET NUMERIC PATTERN.
       SLW IMAGE+9   5R
       SLW IMAGE+10  4L
       SLW IMAGA+9   5R
       SLW IMAGA+10  4L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADF       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADG   CAL KADA      SET NUMERIC PATTERN.
       SLW IMAGE+11  4R
       SLW IMAGE+12  3L
       SLW IMAGA+11  4R
       SLW IMAGA+12  3L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADG       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADH   CAL KADA      SET NUMERIC PATTERN.
       SLW IMAGE+13  3R
       SLW IMAGE+14  2L
       SLW IMAGA+13  3R
       SLW IMAGA+14  2L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADH       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADJ   CAL KADA      SET NUMERIC PATTERN.
       SLW IMAGE+15  2R
       SLW IMAGE+16  1L
       SLW IMAGA+15  2R
       SLW IMAGA+16  1L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADJ       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADK   CAL KADA      SET NUMERIC PATTERN.
       SLW IMAGE+17  1R
       SLW IMAGE+2   8L
       SLW IMAGE+10  4L
       SLW IMAGA+17  1R
       SLW IMAGA+2   8L
       SLW IMAGA+10  4L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADK       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADL   CAL KADA      SET NUMERIC PATTERN.
       SLW IMAGE+3   8R
       SLW IMAGE+11  4R
       SLW IMAGE+2   8L
       SLW IMAGE+12  3L
       SLW IMAGA+3   8R
       SLW IMAGA+11  4R
       SLW IMAGA+2   8L
       SLW IMAGA+12  3L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADL       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER AND CHECK
       RCHA CWADA    FOR PROPER DISCONNECT.
       REM          
       REM          
 ADM   CAL KADA      SET NUMERIC PATTERN.
       SLW IMAGE+3   8R
       SLW IMAGE+13  3R
       SLW IMAGE     9L
       SLW IMAGA+3   8R
       SLW IMAGA+13  3R
       SLW IMAGA     9L
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADM       LOOP RETURN.
       REM          
       WPRA          SPACE PRINTER.
       REM          
       REM          
 ADN   TSX READB,4   PRINT ZONES ONLY AND ROTATE.
       PZE 6         NUMBER OF LINES TO PRINT.
       REM          
       TSX CLEAR,4   CLEAR IMAGES.
       REM          
       TSX ZONE,4    INSTALL ZONES.
       TRA ADN       LOOP RETURN.
       REM          
       TSX OK,4
       TRA ADA       LOOP RETURN.
       REM          
       REM          
       REM          
*AE    *** PRINT 120 COLUMNS OF LIGHT RIPPLE UNDER RPR.
       REM          
       REM          
 AEA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE
       REM          
       TSX SPLTA,4   PRINT-PRINT 120 COLUMNS
       PZE CDAEA     OF LIGHT RIPPLE UNDER RPR.
       TCOA *       
       REM          
       TSX CLEAR,4   CLEAR IMAGES
       REM
       REM
       CAL KAEA      SET PATTERN.
       SLW IMAGE+2   8L
       SLW IMAGE+3   8R
       SLW IMAGE+12  3L
       SLW IMAGE+13  3R
       SLW IMAGE+22  12L
       SLW IMAGE+23  12R
       REM          
       SLW IMAGA+2   8L
       SLW IMAGA+3   8R
       SLW IMAGA+12  3L
       SLW IMAGA+13  3R
       SLW IMAGA+22  12L
       SLW IMAGA+23  12R
       REM          
       TSX READB,4   PRINT PATTERN AND ROTATE
       PZE 18        FOR 18 LINES.
       REM          
       TSX OK,4     
       TRA AEA       LOOP RETURN
       REM          
       REM          
       REM          
*AF    *** BLEACHER TEST
       REM          
*      PURPOSE-     
*          TO TEST THE ABILITY OF THE PRINTER
*          TO CORRECTLY PRINT USING CONTROL
*          WORDS WITH VARIABLE WORD COUNTS OF 1-46
*          BEFORE DISCONNECTING. CHECKS COLUMNS 1-72
       REM          
       REM          
 AFA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-BLEACHER TEST.
       PZE CDAFA    
       TCOA *       
       REM          
       AXT 46,1      SET EXECUTION COUNTER.
       REM          
 AFB   TSX READE,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM          
       TSX CLEAR,4   CLEAR IMAGE + IMAGA
       TSX CLERA,4   CLEAR ECHO COMPARE IMAGE.
       PZE BLOKA,2,18
       TSX CLARA,4   CLEAR ECHO IMAGE.
       REM          
       CLA TBAFA+46,1 SET CALLING SEQUENCES
       STD *+11      TO OBTIAN CORRECT PRINT
       ALS 18        AND ECHO IMAGES.
       STD *+6      
       STD *+2      
       TSX MOVE,4    SET UP PRINT IMAGE.
       PZE CDAFB,2,**
       PZE IMAGE,2  
       TSX MOVE,4    SET UP PRINT COMPARE IMAGE.
       PZE CDAFB,2,**
       PZE IMAGA,2  
       TSX MOVE,4    SET UP ECHO COMPARE IMAGE.
       PZE CDAFB,2,**
       PZE BLOKA,2  
       REM          
       CAL CWAFA+46,1 SET UP CONTROL WORD SEQUENCE
       STP TSAFA     SAVE IT
       CAL ZERO      SET SELECTED CONTROL WORD
       STP CWAFA+46,1 TO IOCD.
       REM          
       RCHA CWAFA    PRINT -IMAGE- AS SPECIFIED.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWAFA+47  CORRECT DSC REG LIMITS
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+5      RECORD DSC REGISTERS.
       REM          
       CLA TBAFB+46,1 CHOOSE CORRECT DSC REGISTER
       STO *+2       CONTENTS TEXT WORD FROM
       REM           TABLE.
       REM
       TSX SCHTA,4   IOT AND SCH CHECK.
       PZE **        CORRECT DSC REGISTER CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN
       REM          
       TSX IMCHK,4   CHECK IF -IMAGE- WAS MODIFIED.
       PZE IMAGE,1,24 PRINT IMAGE.
       PZE IMAGA,1,24 COMPARISON IMAGE.
       NOP           LEFT SIDE.
       NOP           LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE BLOKA+18,1 COMPARISON IMAGE.
       NOP           LEFT SIDE.
       RCHA CWIM     ERROR PRINT DATA
       TRA AFB       LOOP RETURN.
       REM          
       CAL TSAFA     RESTORE CONTROL WORD.
       STP CWAFA+46,1 TO NORMAL
       REM          
       TIX AFB,1,1   COUNT LINES.
       REM          
       TSX OK,4      
       TRA AFA       REPEAT SECTION
       REM          
       REM          
       REM          
*AG    *** LIGHT-HEAVY RIPPLE TEST.
       REM          
       REM          
 AGA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT - LIGHT-HEAVY RIPPLE
       PZE CDAGA     TEST.
       TCOA *        
       REM          
       WPRA          SPACE PRINTER.
       REM          
       TSX SPLTR,4   CONVERT BCD TO HOLLERITH.
       PZE CDAGB     SET RIPPLE PATERN IN -CARDA-.
       REM          
       TSX CLEAR,4   CLEAR -IMAGE AND -IMAGA-.
       REM          
       TSX MOVE,4    MOVE CARDA TO IMAGA.
       PZE CARDA,2,24
       PZE IMAGA,2  
       REM          
       AXT 30,1     
       REM          
 AGB   TSX SPTAR,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       SPRA 8        SUPPRESS SPACE +
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       REM          
       TSX XCHNG,4   EXCHANGE -IMAGA- AND -IMAGE-.
       PZE IMAGA,2,24
       PZE IMAGE,2  
       REM          
       TSX READ,4    PRINT 1-72 ALTERNATE LINES
       NOP           OF BLANKS AND RIPPLE.
       TRA AGB       LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX AGB,1,1   30 LINES THEN EXIT.
       REM          
       WPRA          SPACE PRINTER
       REM          
       TSX SPLTR,4   CONVERT BCD TO HOLLERITH
       PZE CDAGB     SET RIPPLE PATTERN IN -CARDA-.
       REM          
       TSX CLEAR,4   CLEAR -IMAGE AND -IMAGA-.
       REM          
       TSX MOVE,4    MOVE CARDA TO IMAGA.
       PZE CARDA,2,24
       PZE IMAGA,2  
       REM          
       AXT 30,1     
       REM          
 AGC   TSX SPTAR,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM
       SPRA 9        RIGHT SIDE AND SUPPRESS SPACE.
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       REM          
       TSX XCHNG,4   EXHANGE -IMAGA- AND -IMAGE-.
       PZE IMAGA,2,24
       PZE IMAGE,2  
       REM          
       TSX BLANK,4   BLANK 49-72 OR -IMAGE-.
       REM          
       TSX READ,4    PRINT 73-120 ALTERNATE
       NOP           LINES OF BLANKS AND RIPPLE.
       TRA AGC       LOOP RETURN
       REM          
       TSX RTATB,4   ROTATE 1-48 OF -IMAGE-.
       REM          
       TIX AGC,1,1   30 LINES AND EXIT.
       REM          
       TSX OK,4     
       TRA AGA       REPEAT SECTION.
       REM          
       REM          
*AJ    *** 12-9 MAGNET KICKBACK TEST.
       REM          
       REM          
 AJA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-SECT AJ. 12-9 MAGNET
       PZE CDAJA     KICKBACK TEST.
       TCOA *       
       REM          
       WPRA          SPACE PRINTER
       REM          
       TSX CLEAR,4   CLEAR -IMAGE AND -IMAGA-.
       REM          
       CLA THRES     SET PATTERN.
       STO IMAGE+22  12 L
       STO IMAGE+23  12 R
       REM          
       AXT 5,1      
       REM          
 AJB   TSX WRITC,4   PRINT IMAGE
       NOP           IN 1-72.
       NOP           IGNORE LOOP RETURN.
       REM          
       RPRA          SELECT.
       REM          
       TSX CLARA,4   CLEAR ECHO.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN
       REM          
       REM          
       RCHA CWRBL    PRINT BLANKS-CHECK FOR 9 PICKUP.
       REM          
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWRBL+6   CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ECHO+2,,CWRBL+6  CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOS.
       PZE IMAGA+18,1 COMPARING LOCATION.
       NOP           1-72
       RCHA CWIM     LINE TO PRINT ON ERROR.
       TRA AJB       LOOP RETURN
       REM          
       TSX RTATE,4   ROTATE IMAGE.
       REM          
       TIX AJB,1,1   5 PASSES.
       REM          
       WPRA          SPACE PRINTER.
       REM          
       TSX CLEAR,4   CLEAR -IMAGE AND -IMAGA-.
       REM          
       CLA THRES     SET PATTERN
       STO IMAGE+22  12L
       STO IMAGE+23  12R
       REM          
       AXT 5,1      
       REM          
 AJC   TSX BLANK,4   BLANK 49-72 OF -IMAGE-.
       TSX WRITC,4   PRINT PATTERN
       SPRA 9        IN 73-120.
       NOP           IGNORE LOOP RETURN.
       REM          
       RPRA         
       SPRA 9        RIGHT SIDE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       REM          
       TSX CLARA,4   CLEAR ECHO.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       RCHA CWRBL    PRINT BLANKS-CHECK FOR 9 PICKUP.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWRBL+6   CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ECHO+2,,CWRBL+6  CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOS.
       PZE IMAGA+18,1 COMPARING LOCATION.
       SPRA 9        73-120
       RCHA CWIM     LINE TO PRINT ON ERROR.
       TRA AJC       LOOP RETURN.
       REM          
       TSX RTATB,4   ROTATE -IMAGE-.
       REM          
       TIX AJC,1,1   5 PASSES
       REM          
       TSX OK,4     
       TRA AJA       REPEAT SECTION.
       REM          
       REM          
       REM          
*AK    *** NEARBY NUMERICS AND ZONES TEST.
       REM          
       REM          
 AKA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-NEARBY NUMERICS
       PZE CDAKA     AND ZONES TEST.
       TCOA *       
       REM          
       AXT 22,1      SET UP PATTERN COUNT.
       REM          
 AKB   TSX CLEAR,4   CLEAR PRINT IMAGES.
       REM          
       CAL TWFVE    
       SLW IMAGE+22,1
       SLW IMAGE+23,1
       SLW IMAGA+22,1
       SLW IMAGA+23,1
       REM          
       CAL FVETW    
       SLW IMAGE+24,1
       SLW IMAGE+25,1
       SLW IMAGA+24,1
       SLW IMAGA+25,1
       REM          
       TSX READB,4   PRINT PATTERN IN
       PZE 4         1-120 4 LINES.
       REM          
       WPRA          SPACE PRINTER.
       REM          
       TIX AKB,1,2   ELEVEN PATTERNS.
       REM          
       TSX CLEAR,4   CLEAR PRINT IMAGES.
       REM          
       CAL TWFVE     3636 PATTERN
       SLW IMAGE+12 
       SLW IMAGE+13 
       SLW IMAGA+12 
       SLW IMAGA+13 
       REM          
       CAL FVETW    
       SLW IMAGE+6  
       SLW IMAGE+7  
       SLW IMAGA+6  
       SLW IMAGA+7  
       REM          
       TSX READB,4   PRINT PATTERN
       PZE 4         1-120, 4 LINES.
       REM          
       WPRA          SPACE PRINTER
       REM          
       TSX CLEAR,4   CLEAR PRINT IMAGES.
       REM          
       CAL TWFVE     5757 PATTERN.
       SLW IMAGE+8  
       SLW IMAGE+9  
       SLW IMAGA+8  
       SLW IMAGA+9  
       REM          
       CAL FVETW    
       SLW IMAGE+4  
       SLW IMAGE+5  
       SLW IMAGA+4  
       SLW IMAGA+5  
       REM          
       TSX READB,4   PRINT PATTERN IN
       PZE 4         1-120, 4 LINES.
       REM          
       REM          
       TSX OK,4     
       TRA AKA       REPEAT SECTION.
       REM          
       REM          
       REM          
*AL    *** 120 COLUMN RANDOM CHARACTER TEST UNDER RPR.
       REM          
       REM          
 ALA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM
       TSX SPLTA,4   PRINT-120 COLUMN RANDOM
       PZE CDALA     CHARACTER TEST UNDER RPR.
       TCOA *       
       REM          
       TSX RANDN,4   GENERATE 12 BCD WORDS.
       PZE CDRNA+1,2,12 OF RANDOM CHARACTERS.
       REM          
       AXT 30,1     
       REM          
 ALB   RPRA          SELECT.
       SPTA          OVERFLOW TEST.
       TRA *+2       NO
       SPRA 1        YES
       REM          
       TSX SPLTR,4   CONVERT BCD RANDOM
       PZE CDRNA     TO HOLLERITH.
       REM          
       TSX MOVE,4    MOVE -CARDA- TO -IMAGE-.
       PZE CARDA,2,24
       PZE IMAGE,2  
       REM          
 ALC   TSX READC,4   PRINT, GENERATE RANDOM
       PZE CDRNB+1,2,8 NUMBERS FOR THE RIGHT
       NOP           SIDE AND ECHO CHECK 1-72.
       TRA *+2       LOPP RETURN.
       TRA ALD       CONTINUE RETURN.
       REM          
       RPRA          RESELECT.
       SPTA          OVERLFOW TEST.
       TRA *+2       NO.
       SPRA 1        YES.
       TRA ALC       REPEAT 1-72 SAME CHARACERS
       REM          
       REM          
 ALD   RPRA          SELECT
       SPRA 9        RIGHT SIDE
       REM          
       TSX SPLTR,4   COVERT BCD TO 
       PZE CDRNB     HOLLERITH.
       REM          
       TSX MOVE,4    MOVE -CARDA- TO -IMAGE-.
       PZE CARDA,2,24
       PZE IMAGE,2  
       REM          
 ALE   TSX READC,4   PRINT, GENERATE RANDOM
       PZE CDRNA+1,2,12 CHARACTERS FOR THE LEFT
       SPRA 9        SIDE AND ECHO CHECK 49-120.
       TRA *+2       LOOP RETURN.
       TRA ALF       CONTINUE RETURN.
       REM          
       TSX SPTAR,4   RESLECT, OFLOW AND IOCK
       REM           TEST ON LOOP RETURN.
       NOP           LOOP RETURN.
       REM          
       SPRA 9        RIGHT HALF.
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       TRA ALE      
       REM          
 ALF   TIX ALB,1,1   30 LINES.
       REM          
       TSX OK,4     
       TRA ALA       REPEAT SECTION.
       REM          
       REM          
       REM          
*AM    *** WRITE PRINTER BINARY TEST.
       REM          
       REM          
 AMA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-WRITE PRINTER
       PZE CDAMA     BINARY TEST.
       TCOA *       
       REM          
       TSX CLEAR,4   CLEAR IMAGE.
       REM          
       CLA TWFVE     SET PATTERN.
       STO IMAGE    
       STO IMAGE+1  
       REM          
       AXT 5,1       PRINT 5 LINES.
       REM          
 AMB   WPBA         
       SPTA          OVERFLOW TEST.
       TRA *+2       NO.
       SPRA 1        YES
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       RCHA CWBM     PRINT 2 WORDS OF IMAGE IN
       REM           BINARY IN COLUMNS 1-72.
       REM          
       SCHA *+9      RECORD DSC REGISTERS
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+2,,CWBM+1   CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+7      RECORD DSC REGISTERS
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD IMAGE+1,,CWBM+1 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD IMAGE+2,,CWBM+1 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA AMB       LOOP RETURN
       REM          
       TSX RTATE,4   ROTATE-IMAGE-.
       REM          
       TIX AMB,1,1   COUNT LINES.
       REM          
       TSX OK,4      
       TRA AMA       REPEAT SECTION.
       REM          
       REM          
*ANA   *** WRITE PRINTER BINARY MULTIPLE LINES
*      *** WITH ONE SELECT.
       REM          
       REM          
 ANA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-WRITE PRINTER
       PZE CDANA     BINARY MULTIPLE LINES
       TCOA *        WITH ONE SELECT.
       REM          
       TSX CLEAR,4   CLEAR IMAGE.
       REM          
       AXT 8,4       SET PATTERN.
       CAL TWFVE    
       SLW IMAGE+8,4 
       SLW IMAGE+9,4 
       CAL FVETW    
       SLW IMAGE+10,4
       SLW IMAGE+11,4
       TIX *-6,4,4  
       REM          
 ANB   WPBA         
       SPTA          OVERFLOW TEST.
       TRA *+2       NO.
       SPRA 1        YES
       REM          
       SCHA *+3      RECORD D.S.C. REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       RCHA CWCM     PRINT 4 LINES OF 
       REM           ALTERNATE 1S ON
       REM           ONE SELECT.
       REM          
       SCHA *+9      RECORD DSC REGISTERS
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY
       REM           UNTIL DISCONNECT.
       PZE IMAGE+8,,CWCM+1   CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+7      RECORD DSC REGISTERS
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD IMAGE+1,,CWCM+1 GOOD DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD IMAGE+8,,CWCM+1 GOOD DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA ANB       LOOP RETURN
       REM          
       TSX OK,4      
       TRA ANA       REPEAT SECTION.
       REM          
       REM          
       REM          
*AP    *** OCTAL SPACE RIGHT SIDE ALTERNATE LINES
*      *** UNDER WPR.
       REM          
       REM          
 APA   TSX CHCKR,4   CHECK PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-OCTAL SPACE RIGHT SIDE
       PZE CDAPA     ALTERNATE LINES UNDER WPR.
       TCOA *       
       REM          
       WPRA          SPACE PRINTER.
       REM          
       TSX SPLTR,4   CONVERT BCD TO HOLLERITH.
       PZE NUMBA    
       REM          
       TSX MOVE,4    MOVE -CARDA- TO -IMAGE-.
       PZE CARDA,2,24
       PZE IMAGE,2  
       REM          
       AXT 5,1       PRINT 10 LINES
       REM          
 APB   TSX WRITC,4   PRINT IMAGE OCTAL
       SPRA 4        SPACED RIGHT SIDE
       NOP           IGNORE LOOP RETURN.
       REM          
       TSX WRITC,4   PRINT IMAGE REGULAR
       NOP           COLUMNS 1-72.
       TRA APB       LOOP RETURN
       REM          
       TSX RTATE,4   ROTATE IMAGE.
       REM          
       TIX APB,1,1   COUNT LINES.
       REM          
       TSX OK,4      
       TRA APA       REPEAT SECTION.
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM          
       REM          
*      *** SECTION B. PRINTER CONTROL WORD TESTS.
       REM          
*          THE PURPOSE OF THIS SECTION OF THE PRINTER
*          TEST IS TO PROVIDE A THOROUGH EXERCISE OF
*          THE VARIOUS CONTROL WORD CONFIGURATIONS IN BOTH
*          WRITE AND READ PRINTER WITH EXTENSIVE
*          ERROR DETECTION AND INDICATION. THE RIPPLE
*          IMAGE IS USED THROUGHOUT.
       REM          
       REM          
*BA    *** WPR RIPPLE TESTS SETUP.
       REM          
       REM          
 BAA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-WPR RIPPLE.
       PZE CDBAA    
       TCOA *       
       REM          
       TSX SPLTR,4   SET RIPPLE TO IMAGE
       PZE CDAGB    
       REM          
       TSX MOVE,4    MOVE - CARDA- TO -IMAGE-.
       PZE CARDA,2,24
       PZE IMAGE,2  
       TRA *+2      
       REM          
       TRA BAA       DUMMY FOR MONITOR.
       REM          
       REM          
*BB    *** WPR RIPPLE-SIMPLE CONTROL WORD.
       REM          
       REM          
 BBA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOCD, WC 24.
       PZE CDBBA    
       TCOA *        
       WPRA          SPACE PRINTER.
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX WRITC,4   PRINT RIPPLE IMAGE WITH
       NOP           SIMPLE IOCD. 1-72.
       TRA *-2       LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BBA+6,2,1 COUNT LINES.
       TSX OK,4     
       TRA BBA      
       REM          
       REM          
       REM          
*BC    *** WPR RIPPLE-COMPLEX CONTROL WORDS.
       REM          
       REM          
 BCA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOST, LCHA.
       PZE CDBCA    
       TCOA *       
       REM          
       AXT 2,2       PRINT 2 LINES
       REM          
       TSX WRITD,4   WPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       REM          
       CAL CWBCA+2   RESTORE CONTROL WORD.
       SLW CWBCA+1  
       REM          
       RCHA CWBCA    FIRST WORD.
       REM          
       AXT 23,1     
       LCHA CWBCA+1  23 SUBSEQUENT WORDS.
       CAL CWBCA+1   MODIFY CONTROL WORD
       ADD Q1        23 TIMES.
       SLW CWBCA+1  
       TIX *-4,1,1  
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWBCA+2 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOST IMAGE+24,,CWBCA+2 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BCA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BCA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4     
       TRA BCA       SECTION REPEAT.
       REM          
       REM          
       REM          
       REM          
*BD    *** WPR RIPPLE - COMPLEX CONTROL WORDS.
       REM          
       REM          
 BDA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOCT, LCHA.
       PZE CDBDA    
       TCOA *       
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX WRITD,4   WPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       REM          
       CAL CWBDA+2   RESTORE CONTROL WORD.
       SLW CWBDA+1   
       REM          
       RCHA CWBDA    FIRST WORD
       REM          
       AXT 23,1      
       LCHA CWBDA+1  23 SUBSEQUENT WORDS
       CAL CWBDA+1   MODIFY CONTROL WORD
       ADD Q1        23 TIMES
       SLW CWBDA+1  
       TIX *-4,1,1  
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWBDA+2 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCT IMAGE+24,,CWBDA+2 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BDA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BDA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4     
       TRA BDA       SECTION REPEAT.
       REM          
       REM          
       REM          
*BE    *** WPR RIPPLE - COMPLEX CONTROL WORDS, TCH TEST.
       REM          
       REM          
 BEA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOCT, LCHA.
       PZE CDBEA    
       TCOA *       
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX WRITD,4   WPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       REM          
       CAL CWBEA+5   RESTORE CONTROL WORD.
       SLW CWBEA+2   
       CAL CWBEA+6   RESTORE TCH.
       SLW CWBEA+4   
       REM          
       RCHA CWBEA    FIRST WORD
       REM          
       AXT 23,1      
       LCHA CWBEA+4  SUBSEQUENT WORDS
       CAL CWBEA+2   MODIFY CONTROL WORD
       ADD Q1       
       SLW CWBEA+2  
       CLA CWBEA+4   MODIFY TCH DECREMENT.
       ALS 1        
       STD CWBEA+4  
       TIX *-7,1,1  
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWBEA+3 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOST IMAGE+24,,CWBEA+3 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BEA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BEA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4     
       TRA BEA       SECTION REPEAT.
       REM          
       REM          
       REM          
*BF    *** WPR RIPPLE - COMPLEX CONTROL WORDS-IOCP, IOST.
       REM          
       REM          
 BFA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOCT, LCHA.
       PZE CDBFA    
       TCOA *       
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX WRITD,4   WPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       REM          
       CAL CWBFA+3   RESTORE CONTROL WORD.
       SLW CWBFA+1   
       REM          
       RCHA CWBFA    FIRST WORD
       REM          
       AXT 23,1      
       LCHA CWBFA+1  SUBSEQUENT WORDS
       CAL CWBFA+1   MODIFY CONTROL WORD
       ADD Q1        23 TIMES
       SLW CWBFA+1  
       TIX *-4,1,1  
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWBFA+3 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOST IMAGE+2,,CWBFA+3 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BFA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BFA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4     
       TRA BFA       SECTION REPEAT.
       REM          
       REM          
       REM          
*BG    *** WPR RIPPLE - COMPLEX CONTROL WORDS-IOSP, IOCT.
       REM          
       REM          
BGA    TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOSP, IOCT, LCHA.
       PZE CDBGA    
       TCOA *       
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX WRITD,4   WPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       REM          
       CAL CWBGA+3   RESTORE CONTROL WORD.
       SLW CWBGA+1   
       REM          
       RCHA CWBGA    FIRST WORD
       REM          
       AXT 23,1      
       LCHA CWBGA+1  23 SUBSEQUENT WORDS
       CAL CWBGA+1   MODIFY CONTROL WORD
       ADD Q1       
       SLW CWBGA+1  
       TIX *-4,1,1  
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWBGA+3 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCT IMAGE+2,,CWBGA+3 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BGA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BGA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4     
       TRA BGA       SECTION REPEAT.
       REM          
       REM          
       REM          
*BH    *** WPR RIPPLE - COMPLEX CONTROL WORDS-2 LINES PER SELECT.
       REM          
       REM          
 BHA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOST, IORP, IOST.
       PZE CDBHA     WC-48.
       TCOA *       
       REM          
       AXT 2,2       PRINT FOUR LINES-
       REM           2 PER SELECT.
       REM          
       TSX WRITD,4   WPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       REM          
       RCHA CWBHA    FIRST 23 WORD
       REM          
       LCHA CWBHA+1  23 SUBSEQUENT WORDS
       REM          
       AXT 100,1     DELAY 2.4 MILLISECONDS
       TIX *,1,1     FOR 24TH WORD THEN
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWBHA+4 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOST IMAGE+24,,CWBHA+4 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BHA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE- AFTER
       REM           SECOND LINE.
       REM          
       TIX BHA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4     
       TRA BHA       SECTION REPEAT.
       REM          
       REM          
       REM          
*BJ    *** WPR RIPPLE - COMPLEX CONTROL WORDS-2 LINES PER SELECT.
       REM          
       REM          
 BJA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOST, IORT, RCHA
       PZE CDBJA     BLAST OUT, IORT, WC-24.
       TCOA *       
       REM          
       AXT 2,2       PRINT 4 LINES-
       REM           2 PER SELECT.
       REM          
       TSX WRITD,4   WPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       REM          
       RCHA CWBJA    FIRST 23 WORD.
       LCHA CWBJA+1  24TH WORD.
       LCHA CWBJB    LINE TO BE BLASTED AFTER
       REM           IMAGE ROTATION BEFORE
       REM           9 TIME.
       REM          
       TSX RTATE,4   ROTATE IMAGE FOR SECOND LINE.
       RCHA CWBJA+2  BLAST OUT LCHA TO GET
       REM           CORRECT DATA PRINTED.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWBJA+3 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOST IMAGE+24,,CWBJA+3 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BJA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE- AFTER
       REM           SECOND LINE.
       REM          
       TIX BJA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4     
       TRA BJA       SECTION REPEAT.
       REM          
       REM          
*BK    *** WPR RIPPLE - COMPLEX CONTROL WORDS.
       REM          
       REM          
 BKA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOSP, IOCP, IOST,
       PZE CDBKA     TCH, IOST, IOCT, IOCP, TCH,
       TCOA *        IORT.
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX WRITD,4   WPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       REM          
       RCHA CWBKA    FIRST FIVE WORDS.
       LCHA CWBKA+4  TCH + NEXT 3 WORDS.
       LCHA CWBKA+5  NEXT 3 WORDS.
       LCHA CWBKA+6  LAST 10 WORDS.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWBKA+10 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IORT IMAGE+24,,CWBKA+10 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BKA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE- AFTER
       REM           SECOND LINE.
       REM          
       TIX BKA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4     
       TRA BKA       SECTION REPEAT.
       REM          
       REM          
*BL    *** WPR RIPPLE - COMPLEX CONTROL WORDS- RCHA BLAST OUT.
       REM          
       REM          
 BLA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOST, IOCD, BLAST OUT
       PZE CDBLA     WITH IORT.
       TCOA *       
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX WRITD,4   WPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN
       REM          
       RCHA CWBLA    FIRST WORD.
       REM          
       LCHA CWBLB    PRINT ERROR LINE
       REM           IF FOLLOWING BLAST OUT FAILS.
       REM          
       AXT 6,1       168 MICOSECOND DELAY
       TIX *,1,1     
       REM          
       RCHA CWBLA+1  BLAST OUT LAST LCHA AND
       REM           WRITE NEXT 23 WORDS.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWBLA+2 GOOD DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IORT IMAGE+24,,CWBLA+2 GOOD DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BLA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE- AFTER
       REM           SECOND LINE.
       REM          
       TIX BLA+5,2,1 COUNT LINES.
       REM          
       WPRA          SPACE PRINTER
       TSX OK,4     
       TRA BLA       SECTION REPEAT.
       REM          
       REM          
       REM          
*BM    *** WPR RIPPLE - 3 LINES DOUBLE SPACE ON ONE SELECT
*      *** AND SENSE EXIT HOLD OVER.
       REM          
 BMA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-WPR DBL SPCE RIPPLE,
       PZE CDBMA     3 LINES 1 SELECT SENSE.
       REM           EXIT HOLDOVER.
       REM          
       WPRA          SELECT
       SPRA 3        DOUBLE SPACE.
       REM          
       SCHA *+3      RECORD CHANNEL DATA.
       TSX SCHT,4    SCH CHECK
       IOCD          CORRECT CHANNEL DATA.
       PZE **        CHANNEL DATA STORAGE.
       NOP           LOOP RETURN
       REM          
       AXT 3,2       PRINT 3 LINES.
       REM          
 BMB   RCHA CWBMA    
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IORT IMAGE+1,,CWBMA+1 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       LCHA CWBJB    SET UP ERROR PRINT LINE
       REM           WHICH ALLOWS TIME TO IOT,
       REM           SCH TEST AND ROTATE IMAGE 
       REM           WITHOUT ALLOWING THE PRINTER
       REM           TO DISCONNECT. IT WILL
       REM           BE BLASTED OUT BY THE
       REM           RCHA BEFORE 9 LEFT
       REM           TIME.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD BLWST+1,,CWBJB+1 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA BMB       LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE- AFTER
       REM           SECOND LINE.
       REM          
       TIX BMB,2,1   COUNT LINES.
       REM          
       RCHA CWBVC    DISCONNECT PRINTER.
       REM          
       TSX OK,4     
       TRA BMA       SECTION REPEAT.
       REM          
       REM          
       REM          
*BN    *** RPR RIPPLE TESTS SETUP.
       REM          
       REM          
 BNA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-RPRA RIPPLE -
       PZE CDBNA     CONTROL WORD TESTS.
       TCOA *       
       REM          
       TSX SPLTR,4   SET UP RIPPLE IMAGE.
       PZE CDAGB    
       REM          
       TSX MOVE,4    MOVE TO -IMAGE-.
       PZE CARDA,2,24
       PZE IMAGE,2  
       TRA *+2      
       REM          
       TRA BNA       DUMMY FOR CHCKR.
       REM          
       REM          
       REM          
*BP    *** RPR RIPPLE - COMPLEXT CONTROL WORDS.
       REM          
       REM          
 BPA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOCT, IOST. WC-46.
       PZE CDBPA    
       TCOA *       
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX READE,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM          
       CAL CWBPA+2   RESTORE CONTROL WORD.
       SLW CWBPA+1  
       REM          
       CAL CWBPA+16  RESTORE
       SLW CWBPA+15  CONTROL WORD.
       REM          
       RCHA CWBPA    FIRST WORD.
       REM          
       AXT 17,1     
       LCHA CWBPA+1  NEXT 17 WORDS.
       CAL CWBPA+1   MODIFY
       ADD Q1        CONTROL
       SLW CWBPA+1   WORD.
       TIX *-4,1,1   COUNT WORDS.
       REM          
       AXT 12,1     
       LCHA CWBPA+15,1 NEXT 12 WORDS
       TIX *-1,1,1   COUNT WORDS.
       REM          
       AXT 16,1     
       LCHA CWBPA+15 NEXT 16 WORDS.
       CAL CWBPA+15  MODIFY
       ADD Q1        CONTROL
       SLW CWBPA+15  WORD.
       TIX *-4,1,1   COUNT WORDS.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWBPA+16 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCT ECHO+18,,CWBPA+16 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARE IMAGE.
       NOP           LEFT SIDE.
       RCHA CWIM     IMAGE TO BE PRINTED ON ERROR.
       TRA BPA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BPA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4      
       TRA BPA       SECTION REPEAT.
       REM          
       REM          
       REM           
*BQ    *** RPR RIPPLE - COMPLEXT CONTROL WORDS.
       REM          
       REM          
 BQA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-TCH, IOSP, IOST, IOCT,
       PZE CDBQA     IOCT, IOSP, IOST.
       TCOA *       
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX READE,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM          
       CAL CWBQA+8   RESTORE
       SLW CWBQA     CONTROL
       CAL CWBQA+9   WORDS.
       SLW CWBQA+1  
       CAL CWBQA+10 
       SLW CWBQA+2  
       REM          
       CAL CWBQA+29  RESTORE
       SLW CWBQA+26  CONTROL
       CAL CWBQA+30  WORD.
       SLW CWBQA+27 
       REM          
       RCHA CWBQA+3  FIRST 2 WORD.
       REM          
       AXT 5,1      
       LCHA CWBQA+2  NEXT 15 WORDS.
       CAL CWBQA    
       ADD Q3       
       SLW CWBQA    
       ADD Q1       
       STA CWBQA+1  
       ADD Q1       
       STA CWBQA+2  
       TIX *-8,1,1  
       REM          
       LCHA CWBQA+4  NEXT 2 WORDS.
       LCHA CWBQA+6  NEXT WORD.
       LCHA CWBQA+12 TCH, NEXT 2 WORDS.
       REM          
       LCHA CWBQA+13 NEXT 3 WORDS.
       LCHA CWBQA+19 NEXT WORD.
       LCHA CWBQA+20 NEXT 4 WORDS.
       LCHA CWBQA+27 NEXT WORD.
       REM          
       AXT 7,1      
       LCHA CWBQA+26 NEXT 14 WORDS.
       CAL CWBQA+26   MODIFY
       ADD Q1        CONTROL
       STA CWBQA+27  WORDS.
       ADD Q1       
       STA CWBQA+26 
       TIX *-6,1,1   COUNT WORD PAIRS.
       REM          
       LCHA CWBQA+28 LAST WORD.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWBQA+29 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOST ECHO+18,,CWBQA+29 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARE IMAGE.
       NOP           LEFT SIDE.
       RCHA CWIM     IMAGE TO BE PRINTED ON ERROR.
       TRA BQA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BQA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4      
       TRA BQA       SECTION REPEAT.
       REM          
       REM          
       REM           
*BR    *** RPR RIPPLE - COMPLEXT CONTROL WORDS.
       REM          
       REM          
 BRA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-TCH, IOCP, IOCT,
       PZE CDBRA     IOST, IOCP,IOCT. WC-46
       TCOA *       
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX READE,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM          
       CAL CWBRA+8   RESTORE CONTROL WORD.
       SLW CWBRA    
       CAL CWBRA+9  
       SLW CWBRA+1  
       CAL CWBRA+10 
       SLW CWBRA+2  
       REM          
       CAL CWBRA+29  RESTORE CONTROL WORD.
       SLW CWBRA+26 
       CAL CWBRA+30 
       SLW CWBRA+27 
       REM          
       RCHA CWBRA+3  TH THE FIRST TWO WORDS.
       REM          
       AXT 5,1      
       LCHA CWBRA+2  NEXT 3 WORDS.
       CAL CWBRA     MODIFY CONTROL WORDS
       ADD Q3        FIVE TIMES.
       STA CWBRA    
       ADD Q1       
       STA CWBRA+1  
       ADD Q1       
       STA CWBRA+2  
       TIX *-8,1,1  
       REM          
       LCHA CWBRA+4  PRINT 1R, 8-4L ECHO.
       LCHA CWBRA+7  8-4R ECHO.
       LCHA CWBRA+12 TCH, PRINT 0 ROW.
       REM          
       LCHA CWBRA+13 8-13 ECHO, 11L PRINT.
       LCHA CWBRA+19 11R PRINT
       LCHA CWBRA+20 9 ECHO, 12 PRINT.
       LCHA CWBRA+27 8 LEFT ECHO
       REM          
       AXT 7,1      
       LCHA CWBRA+26 8R TO 1L ECHO
       CAL CWBRA+26  MODIFY CONTROL WORDS
       ADD Q1        SEVEN TIMES.
       STA CWBRA+27 
       ADD Q1       
       STA CWBRA+26 
       TIX *-6,1,1  
       REM          
       LCHA CWBRA+28 1R ECHO.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWBRA+29 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCT ECHO+18,,CWBRA+29 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARE IMAGE.
       NOP           LEFT SIDE.
       RCHA CWIM     IMAGE TO BE PRINTED ON ERROR.
       TRA BRA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BRA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4      
       TRA BRA       SECTION REPEAT.
       REM          
       REM          
       REM           
*BS    *** RPR RIPPLE - COMPLEXT CONTROL WORDS.
       REM          
       REM          
 BSA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOCP, IOSP, TCH,
       PZE CDBSA     TCH, IOSP, IOCP, TCH
       TCOA *        IOSP, IORT. WC-46.
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX READE,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM          
       RCHA CWBSA    PRINT LINE.
       REM          
       LCHA CWBSA+19 OBTIAN DISCONNECT.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWBSA+20 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ,,CWBSA+20 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARE IMAGE.
       NOP           LEFT SIDE.
       RCHA CWIM     IMAGE TO BE PRINTED ON ERROR.
       TRA BSA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BSA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4      
       TRA BSA       SECTION REPEAT.
       REM          
       REM          
       REM           
*BT    *** RPR RIPPLE - COMPLEXT CONTROL WORDS.
       REM          
       REM          
 BTA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-IOST, IOCT, IOCT,
       PZE CDBTA     IOST, IOCT, IORP, TCH,
       TCOA *        IOCD, WC-46.
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX READE,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM          
       RCHA CWBTA    9L-5L PRINT.
       AXT 9,1       SETUP LCHA.
       LCHA CWBTA+10,1 NEXT 9 CONTROL WORDS.
       TIX *-1,1,1   5L PRINT TO 1R ECHO.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ERBIT+2,,CWBTA+12 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ERBIT+2,,CWBTA+12 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARE IMAGE.
       NOP           LEFT SIDE.
       RCHA CWIM     IMAGE TO BE PRINTED ON ERROR.
       TRA BTA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BTA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4      
       TRA BTA       SECTION REPEAT.
       REM          
       REM          
       REM          
       REM           
*BU    *** RPR RIPPLE - COMPLEXT CONTROL WORDS - RCHA BLAST OUT.
       REM          
       REM          
 BUA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-RCHA BLAST OUT
       PZE CDBUA     USING CONTROL WORDS FROM
       TCOA *        SECTION BT.
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX READE,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM          
       RCHA CWBTA   
       AXT 9,1       SETUP LOAD CHANNEL
       REM           AND BLAST OUT.
       LCHA CWLST    PRINT ERROR LINE IF
       REM           FOLLOWING BLAST OUT FAILS.
       REM
       AXT 6,4      
       TIX *,4,1     144 MICRO SECOND DELAY.
       REM          
       RCHA CWBTA+10,1 BLAST OUT LCHA + PREFORM
       REM           CORRECT CONTROL WORDS.
       TIX *-4,1,1   GET 9 CONTROL WORDS.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ERBIT+2,,CWBTA+12 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ERBIT+2,,CWBTA+12 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARE IMAGE.
       NOP           LEFT SIDE.
       RCHA CWIM     IMAGE TO BE PRINTED
       REM           ON ERROR.
       TRA BUA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BUA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4      
       TRA BUA       SECTION REPEAT.
       REM          
       REM          
       REM           
*BV    *** RPR RIPPLE - 3 LINES DOUBLE SPACE ON ONE SELECT
*      *** AND SENSE EXIT HOLDOVER.
       REM          
       REM          
 BVA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-READ PRINTER DOUBLE
       PZE CDBVA     SPACE 3 LINES ON 1 SELECT.
       TCOA *        SENSE EXIT HOLD OVER.
       REM          
       AXT 3,2       PRINT 3 LINES.
       REM          
       TSX READE,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM          
       SPRA 3       
       REM          
       RCHA CWBVA+9  PRINT LINE OF RIPPLE.
       LCHA CWLST    SET UP ERROR PRINT LINE
       REM           WHICH ALLOWS TIME TO 
       REM           IOT, SCH TEST, ECHO
       REM           CHECK AND ROTATE WITHOUT
       REM           ALLOWING PRINTER TO
       REM           DISCONNECT. IT WILL
       REM           BE BLASTED OUT BY
       REM           THE RCHA BEFORE
       REM           9 LEFT TIME
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCDN BLAST,,CWLST+1 GOOD DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARE IMAGE.
       NOP           LEFT SIDE.
       RCHA CWIM     IMAGE TO BE PRINTED ON ERROR.
       TRA BVA+7     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BVA+7,2,1 COUNT LINES.
       REM          
       RCHA CWBVC    DISCONNECT PRINTER.
       REM          
       TSX OK,4      
       TRA BVA       SECTION REPEAT.
       REM          
       REM          
       REM           
*BW    *** RPR RIPPLE - TRIGGER 19 TEST.
       REM          
*      NORMAL ECHO CHECKING IS PERFORMED
*      EXCEPT THAT THE 8-3 AND 8-4
*      ECHO RETURNS ARE BLOCKED BY
*      TRIGGER 19 CONTROL WORD CONFIGURATIONS.
*      A SPECIAL COMPARING IMAGE IS MODIFED
*      FROM THE PRINT IMAGE WHICH REMOVES
*      ALL 8-3 AND 8-4 CHARACTER CONFIGURATIONS
*      AND THIS IMAGE IS USED TO CHECK THE
*      ECHO RETURNS. 
       REM          
       REM          
 BWA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       TSX SPLTA,4   PRINT-TEST TRIGGER 19 ON
       PZE CDBWA     READ PRINTER.
       TCOA *       
       REM          
       AXT 2,2       PRINT 2 LINES.
       REM          
       TSX READE,4   RPRA, OFLOW TEST AND IOCK.
       NOP           LOOP RETURN.
       REM          
       TSX MOVE,4    MOVE -IMAGE- TO -IMAGA-.
       PZE IMAGE,2,24
       PZE IMAGA,2  
       REM          
       TSX CLARA,4   CLEAR ECHO IMAGE.
       REM          
       AXT 2,1       MODIFY COMPARING IMAGE TO
 BWB   CAL IMAGA+4,1 REMOVE 8-3 + 8-4 CHARACTERS.
       ANA IMAGA+14,1   8-3
       COM          
       ANS IMAGA+4,1 
       ANS IMAGA+14,1
       CAL IMAGA+4,1 8-4.
       ANA IMAGA+12,1
       COM          
       ANS IMAGA+4,1 
       ANS IMAGA+12,1
       TIX BWB,1,1   GO BACK FOR RIGHT SIDE.
       REM          
       RCHA CWBWA    PRINT AND ECHO -IMAGE-.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWBWA+8 CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ECHO+18,,CWBWA+8 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGA+18,1 COMPARE IMAGE.
       NOP           LEFT SIDE.
       RCHA CWIM     IMAGE TO BE PRINTED ON ERROR.
       TRA BWA+5     LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE -IMAGE-.
       REM          
       TIX BWA+5,2,1 COUNT LINES.
       REM          
       TSX OK,4      
       TRA BWA       SECTION REPEAT.
       REM          
       REM          
       REM          
*ZA    *** 9P01 END OF PART ONE.
 ZAA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM          
       WPRA          SPACE PRINTER.
       REM          
       TSX SPLTA,4   PRINT-9P01 PART ONE
       PZE CDZAC     PASS COMPLETE ON CHANNEL X.
       TCOA *        
       NZT SIZE      TEST SIZE OF STORAGE.
       TRA STRTB     MOVE THEN 4K, GO TO
       REM           PART TWO.
       CLA IOCNT     4K. STEP UNIT COUNT DOWN
       SUB Q1        BY 1.
       TZE ZAB       COUNT ZERO - DONE.
       REM          
       STO IOCNT     SAVE UNIT COUNTER.
       TRA ZCE       DO PART 1 NEXT CHANNEL.
       REM          
 ZAB   SWT 6         TEST FOR PROGRAM REPEAT.
       TRA PLCB      UP - READ IN PART TWO.
       TRA 25        RESET UNIT COUNT AND
       REM           REPEAT PART ONE.
       REM          
       REM          
       REM          
 FRSTA BSS 0        
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
*      *** SUBROUTINE PACKAGE.
       REM          
*      ALL SUBROUTINES USED IN 9P01 ARE GROUPED
*      BELOW. EACH SUBROUTINE IS HEADED BY 
*      A SPECIFICATION LIST AND ITS CALLING
*      SEQUENCE OF SEQUENCES. THE DEPENDENT OF EACH
*      OTHER AND MOST OF THEM WILL USE COMMON
*      CONTANTS AND STORAGE AREAS.
       REM          
       REM          
       REM          
       REM          
*SPACE *** PROGRAM SEQUENCE ERROR INDICATOR.
       REM          
*      SPECIFICATIONS-
*       1. PROVIDE ERROR DETECTION AND INDICATION
*          OF WILD TRANSFERS TO UNUSED PORTIONS
*          OF CORE STORAGE.
*       2. PROVIDE ERROR INDICATION FOR ALL
*          IMPROPER PROGRAM SEQUENCING.
       REM          
*      ERROR INDICATION FORMAT-
*          THE STORAGE REGISTER CONTAINS AN
*          -HPR- WITH AND ADDRESS OF -SPACE+6-
*          AT LOCATION -SPACE+6-.
*          THE ACCUMULATOR ADDRESS CONTAINS 
*          THE STARTING LOCATION OF THE TEST
*          UNDERWAY AT THE TIME OF THE
*          SEQUENCING FAILURE.
*          THE ACCUMULATOR DECREMENT
*          CONTAINS THE ADDRESS FROM WHICH WE
*          RECOVERED CONTROL OF THE SEQUENCE
*          FAILURE. 
       REM          
*      CALLING SEQUENCE-
*          THIS PROGRAM IS A SERVICE SUBROUTINE
*          OF -CHCHK- AND THE WILD TRAP RECOVERY ROUTINES AND
*          ITS CALLING SEQUENCE IS CONTROLLED BY THEM.
       REM          
       REM          
       ORG 1797     
       REM          
 LASTA BSS 0        
       REM          
 SPACE#SXD BIN,4    SPACE ADDRESS
      #LDC BIN,4    COMPLEMENT IT
      #SXD BIN,4    
      #LDC MONIT,4  
      #SXA BIN,4   
      #CLA BIN      
       REM          
      #HPR *         ERROR-PROGRAM TRANSFERRED
       REM           OUT OF CONTROL. THE ADDRESS
       REM           FROM WHICH WE RECOVERED.
       REM           CONTROL IS IN THE DECR.
       REM           OF THE ACCUMULATOR, THE
       REM           STARTING ADDRESS OF THE
       REM           TEST WHICH WAS UNDERWAY
       REM           IS IN THE ADDRESS OF
       REM           THE ACCUMULATOR
       REM          
      #LXD MONIT,4   RESET-MONIT- AND
      #CLA -1,4      RETURN TO PROPER
      #PAC ,2        SEQUENCE.
      #SXD  MONIT,2 
      #TRA 0,4      
       REM          
       REM          
       REM          
*CHCKR *** PROGRAM SEQUENCE MONITOR.
       REM          
*      SPECIFICATIONS-
*      1. SEQUENCE CHECK THE ORDER OF PROGRAM
*         EXECUTE OF 9P01.
*      2. RESET THE CONSOLE. -NOTE- CONSOLE IS NOT
*         RESET ON A PROGRAM SEQUENCE ERROR.
*      3. PROVIDE FOR PROGRAM SEQUENCE ERROR
*         INDICATION BY USE OF THE -SPACE- SUBROUTINE.
       REM          
*      CALLING SEQUENCE.
*         A            TSX CHCKR,4
*         A+1          RETURN.
       REM          
       REM          
 CHCKR SWT 1         TEST FOR REPEAT
       TRA *+2       UP-SWT 4.
       TRA *+3       DN-CHECK FOR SAME SECT.
       REM          
       SWT 4         TEST REPEAT.
       TRA *+4       UP-CHECK SEQUENCE
       REM          
       PXD ,4        DN-TEST REPEATED OR
       SUB MONIT     WILL BE REPEATED
       TZE *+21      IF ZERO, PROGRAM IN SEQUENCE.
       REM          
       STZ FREE     
       SXD FREE,4    SAVE TEST ADDRESS.
       CLA -1,4      PRECEEDING TEST ADDRESS.
       PAC ,4        COMPLEMENT IT.
       PXD ,4       
       SUB MONIT     SHOULD BE ZERO.
       LXD FREE,4    RESTORE XRC
       TZE *+13      IF ZERO, PROGRAM IN SEQUENCE.
       REM          
       ENK           CHECK FOR MANUAL TRANSFER.
       XCA          
       PAC ,4        COMPLEMENT KEYS ADDRESS.
       LRS 21        CHECK TRA ONLY.
       SUB LTRA      L 0200
       TNZ *+5       NO SEQUENCE IF NOT ZERO.
       REM          
       PXD ,4        OK, CHECK ADDRESS.
       SUB FREE      
       LXD FREE,4    RESTORE XRC
       TZE *+3       IF ZERO, PROGRAM IN SEQUENCE.
       REM          
      #LXD FREE,4    PROGRAM OUT OF SEQUENCE.
       TTR SPACE     INDICATE ERROR.
       REM          
 RESET SLF           START CLEAR CONSOLE.
       SXD MONIT,4   SET MONIT.
       LDC MONIT,4   SET RETURN
       TXI *+1,4,1  
       SXA *+12,4   
       STZ IOTA     
       PXD          
       XCL          
       PXD          
       TOV *+1      
       DCT          
       NOP          
       IOT          
       NOP          
       PAI          
       AXT 0,7      
       TRA **       
       REM          
       REM          
       REM          
*OK    *** SECTION REPEAT SUBROUTINE.
*      SPECIFICATIONS-
*       1. PROVIDE UNCONDITIONAL LOOP USING
*          SENSE SWITCH 1
*       2. PROVIDE PASS COUNTER FUNCTION UNDER
*          CONTROL OF SENSE SWITCH 4. NUMBER
*          OF PASSES IS CONTROLLED BY THE
*          VALUE STORED IN -KONST-.
       REM          
*      CALLING SEQUENCE
*          A         TSX OK,4
*          A+1       LOOP RETURN.
*          A+2       CONTINUE RETURN.
       REM          
       REM          
 OK    SWT 1        
       TRA *+2      
       TRA 1,4      
       REM          
       SWT 4        
       TRA 2,4      
       REM          
       CLA KOUNT    
       SUB Q1       
       STO KOUNT    
       TNZ 1,4      
       REM
       CLA KONST    
       STO KOUNT    
       TRA 2,4      
       REM          
       REM          
       REM          
*IODSC *** CHECK DATA SYNCHRONIZER CHANNEL RUNAWAY.
       REM          
*      SPECIFICATION-
*       1. CONTINUOUSLY MAKE DSC REGISTER CONTENTS
*          COMPARISONS WITH DSC REGISTER LIMITS STORED IN THE
*          CALLING SEQUENCE TO DETECT DSU
*          CHANNEL RUNAWAY UNTIL CHANNEL DROPS OUT
*          OF OPERATION.
*       3. PROVIDE A LOOP EXIT CONTROLLED BY SENSE SW -1-.
*       4. PROVIDE IGNORE ERROR INDICATION CONTROLLED BY SENSE SW -2-.
*       5. PROVIDE HALT OR PRINT ERROR CONTROLLED BY SENSE SW -3-.
*       2. ON ERROR BLAST OUT CHANNEL TO STOP RUNAWAY.
       REM          
*      ERROR INDICATION FORMATS
*      HALT-        
*       1. THE STORAGE REGISTER CONTAINS AN -HPR- WITH THE
*          LOCATION FROM WHICH -IODSC- ROUTINE WAS ENTERED
*          IN ITS ADDRESS.
*       2. THE -ACCUMULATOR- CONTAINS THE DSC CONTENTS
*          IN ERROR. 
*       3. THE -MQ- REGISTER CONTAINS THE CORRECT DSC REGISTER LIMITS.
       REM          
*      PRINT-       
*      1. -THE DSU CHANNEL LOST CONTROL.-
*      2. -PROGRAM EXIT AT - AAAA. SECTION STARTS AT - BBBBB.-
*                  AAAAA - LOCATION FROM WHICH -IODSC- WAS ENTERED.
*                  BBBBB - START OF MAIN PROGRAM SECTION EXECUTED.
*      3. -CORRECT DSC LIMITS XXXXXXXXXX.-
*         -ERROR DSC REG CONTS YYYYYYYYYY.
*                    XXXXXXXXXXX - DSC REG LIMITS FROM CALLING SEQUENCE.
*                    YYYYYYYYYYY - DSC REG CONTS STORED BY TEST.
       REM          
*      CALLING SEQUENCE-
*          A         TSX IODSC,4
*          A+1       CHANNEL LIMIT DATA TEST WORD.
*          A+2       LOOP RETURN
*          A+3       CONTINUE RETURN.
       REM          
       REM          
 IODSC SXA IRDSC,2  
       SXA IRDSC+1,4 
       REM          
       CLA 1,4       GET CHECKING DATA.
       STD *+7      
       ALS 18       
       STD *+3      
       REM          
       SCHA HOLDA    STORE CHANNEL
       LXA HOLDA,2   SET AR CHECK
       TXH *+9,2,**  ERROR-DSU AR OUT OF CONTROL
       LXD HOLDA,2  
       TXH *+7,2,**  ERROR-DSU LR OUT OF CONTROL
       TCOA *-5      KEEP CHECKING UNTIL DISCONNECT.
       REM          
 IRDSC AXT **,2     
       AXT **,4     
       REM          
       SWT 1         TEST FOR LOOP EXIT
       TRA 3,4       UP-NO.
       TRA 2,4       DN-YES.
       REM          
      #RCHA CWBVC    BLAST OUT BUFFER.
       REM          
      #LAC IRDSC+1,2 XRC TO XRB COMPLEMENTED.
       REM          
      #SWT 2         TEST TO IGNORE ERROR IND.
      #TRA *+2       UP-INDICATE ERROR.
      #TRA IRDSC     DN-IGNORE ERROR INDICATION.
       REM          
      #SWT 3         TEST PRINT OR HALT.
      #TRA *+6       UP-PRINT DSC AR ERROR
      #LDQ 1,4       DN-LOAD MQ WITH CORRECT
       REM           DSC LIMITS.
      #CLA HOLDA     ERROR DSC REG CONTENTS.
      #SXA *+1,2     TRUE EXIT LOCATION.
       REM          
      #HPR **        A DSU RUNAWAY OCCURED.
       REM           THE -SR- ADDRESS CONTAINS
       REM           THE TRUE EXIT LOCATION.
       REM           THE -ACC- CONTAINS THE
       REM           DSC REG CONTS IN ERROR.
       REM           THE -MQ- CONTAINS THE
       REM           CORRECT DSC LIMITS.
       REM          
      #TRA IRDSC     GO TO SWT 1.
       REM          
      #TSX SPLTA,4   PRINT-THE DSU CHANNEL
      #PZE CDDSU     RAN AWAY.
       REM          
      #PXD ,2        OBTAIN TRUE EXIT LOCATION.
      #STL LOCAT     PRINT PROGRAM EXIT AND
      #TRA ERLOC     SECTION START LOCATION.
       REM          
      #LXA IRDSC+1,4 
       CLA 1,4       GET CORRECT DSC LIMITS.
       TSX CNVWD,4   CONVERT IT TO BCD.
       SLW CDDSV+4   STORE
       STQ CDDSV+5   IT.
       REM          
       CLA HOLDA     GET ERROR DSC REG CONTS.
       TSX CNVWD,4   CONVERT IT TO BCD.
       SLW CDDSV+10  STORE
       STQ CDDSV+11  IT.
       REM          
       TSX SPLTB,4   PRINT DSC LIMITS AND DSC
       PZE CDDSV     REG CONTS ON ERROR.
       REM          
       WPRA          DOUBLE SPACE
       SPRA 3        PRINTER.
       TRA IRDSC     GO TO SWT1
       REM          
       REM          
       REM          
*SCHTA *** I/O CHECK THEN
*SCHT  *** CHECK DSC REGISTER CONTENTS AND INDICATE ERRORS.
       REM          
*      SPECIFICATION - SCHTA-
*       1. CHECK LOCATION -IOTA- FOR NON ZERO
*          WHICH WOULD INDICATE A PREVIOUS I/O
*          CHECK.   
*       2. INDICATE ANY I/O CHECK BY HALT OR
*          PRINT    
*       3. ENTER THE -SCHT- ROUTINE.
       REM          
*      SPECIFICATIONS - SCHT-
*       1. COMPARE DSC REGISTER CONTENTS STORED IN
*          THE CALLING SEQUENCE FOR EQUALITY.
*       2. INDICATE ANY ERROR BY HALT OR
*          PRINT UNDER SENSE SW 3 CONTROL.
*       3. PROVIDE ERROR IGNORE UNDER SENSE SW 2.
*       4. PROVIDE LOPP RETURN UNDER SENSE SW 1.
       REM          
*      CALLING SEQUENCE
*       1. SCHTA-   
*          A-X       IOT
*          A-X+1     STL IOTA
*          A-X+2     SCHA A+2
*          A-X+3     CONTINUE
*          .        
*          .        
*          .        
*          A         TSX SCHTA,4
*          A+1       CORRECT DSC REG CONTENTS
*          A+2       PZE**     DSC REG CONTS STORED
*                    FOR COMPARISON.
*          A+3       LOOP RETURN.
*          A+4       CONTINUE RETURN.
       REM          
*       2. SCHT-    
*          B-Y      SCHA B+2
*          B-Y+1    CONTINUE.
*          .        
*          .        
*          .        
*          B         TSX SCHT,4
*          B+1       CORRECT DSC REG CONTENTS.
*          B+2       PZE**     DSC REG CONTS STORED
*                     FOR COMPARISON.
*           B+3       LOOP RETURN.
*           B+4       CONTINUE RETURN.
       REM          
       REM          
 SCHTA NZT IOTA      TEST FOR I/O CHECK.
       TRA SCHT      NO-CHECK SCH.
       REM          
      #SWT 2         TEST TO IGNORE ERROR IND.
      #TRA *+2       UP-INDICATE ERROR
      #TRA SRHT+2    DN-IGNORE ERROR INDICATION
       REM           AND GO TO SWT 1
       REM          
       SWT 3         TEST PRINT OR HALT
       TRA *+12      UP-PRINT IOT ERROR
       REM          
      #CPY *         TURN ON THE I/O CHECK LITE.
      #CLA IOTA      PUT I/O CHECK ADDRESS
      #SUB Q2        IN HPR ADDRESS.
      #STA *+3      
      #LDQ ZERO      CLEAR MQ
      #PXD           CLEAR ACCUMULATOR
       REM          
      #HPR **        I/O CHECK ERROR.
       REM           LOCATION THAT I/O CHECK
       REM           OCCURRED IS IN THE
       REM           -SR- ADDRESS
       REM          
      #IOT           TURN OFF THE I/O
      #NOP           CHECK LITE.
      #STZ           RESET I/O CHECK STORAGE
      #TRA SCHT      GO TO SCH TEST
       REM          
       WPRA          SPACE PRINTER
      #SXA SRHT,2    PREPARE TO PRINT IOT ERROR.
      #SXA SRHT+1,4 
       REM          
      #CLA IOTA      GET I/O CHECK ADDRESS
      #SUB Q2       
      #ALS 18        PUT IT IN DECREMENT
      #TSX CNVTD,4   CONVERT IT TO BCD
      #SLW CDIOT+8  
       REM          
      #TSX SPLTA,4   PRINT-AN I/O CHECK WAS
      #PZE CDIOT     DETECTED AT LOCATION XXXXX.
       REM          
      #LAC SRHT+1,4  COMPUTE TRUE PROGRAM
      #PXD ,4        EXIT LOCATION.
      #STL LOCAT     PRINT-TRUE EXIT LOCATION
      #TRA ERLOC     AND SECTION START LOCATION.
       REM          
      #STZ IOTA      RESET I/O CHECK CELL
       WPRA          SPACE PRINTER
       SPRA 3        DOUBLE SPACE.
      #TRA SCHT+2    CONTINUE AND CHECK CHANNEL DATA.
       REM          
       REM          
 SCHT  SXA SRHT,2    SAVE XRS
       SXA SRHT+1,4 
       REM          
       LAC SRHT+1,2  XRC TO XRB COMPLEMENTED.
       SWT 2         TEST TO IGNORE ERROR DETECTION.
       TRA *+2       UP-ERROR DETECT.
       TRA SRHT      DN-GO TO EXIT.
       REM          
       LXA SRHT+1,4  RESTORE XRC
       LDQ 1,4       DATA COMPARISION
       CLA 2,4      
       CAS 1,4      
      #TRA *+2       COMPARISON ERROR.
       REM          
       TRA SRHT      OK-GO TO EXIT.
       REM          
      #SWT 3         TEST FOR ERROR PRINT.
      #TRA SRHT+5    UP-PRINT ERROR.
      #SXA *+1,2     STORE PROGRAM EXIT LOCATION
       REM           IN THE -HPR- ADDRESS.
       REM          
      #HPR **        STORE CHANNEL ERROR OCCURRED
       REM           ON LAST LINE OF PRINT-OUT.
       REM           CORRECT DSC REGITER CONTENTS
       REM           IS IN THE MQ.
       REM           DSC REGISTER CONTENTS STORED
       REM           IS IN THE ACCUMULATOR.
       REM          
 SRHT  AXT **,2      RESTORE XRS.
       AXT **,4     
       REM          
       SWT 1         TEST FOR LOOP EXIT.
       TRA 4,4       UP-LOOP RETURN
       TRA 3,4       DN-CONTINUE RETURN
       REM          
       WPRA          SPACE PRINTER.
      #TSX SPLTA,4   PRINT-SCH ERROR OCCURED
      #PZE CDSCH     DURING THE PREVIOUS LINE
       REM           OF TEST PRINTOUT.
       REM          
      #PXD ,2        GET TRUE EXIT LOCATION.
      #STL LOCAT     PRINT-PROGRAM EXIT AND
      #TRA ERLOC     SECTION START LOCATION
       REM          
      #LXA SRHT+1,4  RESTORE XRC
      #LDQ 2,4       GET DSC REG CONTENTS
      #STQ HOLDA     AND PUT IN HOLDA.
      #CLA 1,4       GET CORRECT DSC REG CONTENTS.
      #STL LOCAT     PRINT DSC REG CONTENTS ON
      #TRA ERSCH     ERROR.
       REM          
      #WPRA          SPACE PRINTER
      #SPRA 3       
      #TRA SRHT      GO TO EXIT.
       REM          
       REM          
       REM          
*ECHK  *** PERFORM CHECKING FOR READ PRINTER OPERATIONS.
       REM          
*      SPECIFICATIONS-
*      1. COMPARE ECHO RETURN DATA TO
*         THE PRINT IMAGE SPECIFIED IN
*         THE CALLING SEQUENCE AND PROVIDE
*         ERROR INDICATION.
*      2. PROVIDE LOOP EXIT UNDER CONTROL
*         OF SENSE SWITCH -1-.
*      3. PROVIDE IGNORE ERROR INDICATION FACILITY
*         UNDER CONTROL OF SENSE SWITCH -2-.
*      4. PROVIDE CHOICE OF HALT OR PRINTING OF
*         ERROR INDICATIONS UNDER CONTROL
*         OF SENSE SWITCH -3-.
       REM          
*      ERROR INDICATION FORMATS-
*       ECHO ERROR-HALT-
*       1. THE STORAGE REGISTER CONTAINS AN -HPR-
*          WITH THE LOCATION FROM WHICH THE -ECHK-
*          ROUTINE WAS ENTERED IN ITS ADDRESS.
*       2. THE -ACCUMULATOR- WILL CONTAIN THE
*          ECHO IMAGE WORD IN ERROR.
*       3. THE -MQ- REGISTER WILL CONTAIN THE
*          PRINT IMAGE WORD CORRESPONDING TO
*          THE ECHO IMAGE WORD.
*       4. THE -SENSE INDICATORS- WILL CONTAIN
*          A NUMBER, 11-1 OCTAL, IN THE LEFT
*          OR RIGHT HALF CORRESPONDING TO THE
*          CARD IMAGE POSITION IN ERROR.
       REM          
*      ECHO ERROR -PRINT-
*      1. -AN ECHO ERROR OCCURRED ON THE PREVIOUS
*         LINE OF TEST PATTERN PRINTOUT.-
*      2. -PROGRAM EXIT AT -AAAAA. SECGTION STARTS
*         AT-BBBBB.- 
*      3. -A LINE OF NUMERALS CORESPONDING
*         TO THE UNITS POSITION OF THE TYPE
*         WHEELS PRINTED.
*      4. -THE LINE OF TEST PATTERN IN ERROR
*         PRINTED USIGN -WPR- INSTEAD OF -RPR-.
*      5. -A LINE OF PRINT REPRESENTING THE
*         ECHO IMAGE OF THE ERROR LINE.
*      6. -A LINE OF PRINT REPRESENTING THE
*         ERROR BIT PATTERN PRODUCED BY
*         AN EXCLUSIVE -OR- OF THE PRINT
*         IMAGE WITH THE ECHO IMAGE.
       REM          
       REM          
*      CALLING SEQUENCE-
*          A         TSX ECHK,4
*          A+1       PZE PRINT IMAGE+18,1
*          A+2       NOP OR SPRA 9 DEPENDING ON
*                                  WHETHER PRINTING 1-72
*                                  OR 49-120.
*          A+3       RCHA TEST IMAGE TO BE
*                         PRINTED ON ERROR.
*          A+4       LOOPING RETURN.
*          A+5       CONTINUE RETURN.
       REM          
       REM          
 ECHK  SXA RCHK,1   
       SXA RCHK+1,2 
       SXA RCHK+2,4 
       STI TEMPA    
       REM          
       CAL ECHO+20   8-4 L TO      CORRECT
       ORS ECHO+2    8 L AND       ECHO
       ORS ECHO+10   4 L.          IMAGE
       REM          
       CAL ECHO+18   8-3 L TO      FOR
       ORS ECHO+2    8 L AND       CHECKING.
       ORS ECHO+12   3 L. 
       REM          
       CAL ECHO+21   8-4 R TO
       ORS ECHO+3    8 R AND
       ORS ECHO+11   4 R.
       REM          
       CAL ECHO+19   8-3 R TO
       ORS ECHO+3    8 R AND
       ORS ECHO+13   3 R.
       REM          
       AXT 18,1      CLEAR ERROR BIT IMAGE
       STZ ERBIT+18,1
       TIX *-1,1,1  
       REM          
       AXT 18,1      COMPARE PRINT IMAGE TO
       CLA ECHO+18,1 THE CORRECTED ECHO IMAGE
       CAS* 1,4     
      #TRA *+2       ERROR-ECHOS DID NOT COMPARE
       REM          
       TRA *+11     
       REM          
      #SWT 2         TEST TO IGNORE ECHO ERROR
      #TRA *+2       UP-INDICATE ERROR
      #TRA *+9       DN-IGNORE ERROR INDICATION.
      #LAC RCHK+2,2  GET TRUE EXIT LOCATION.
      #SWT 3         TEST PRINT OR HALT.
      #TRA RCHK+7    UP-PRINT ECHO ERROR.
      #LDQ* 1,4      DOWN-SETUP ERROR HALT.
      #LDI IND+18,1 
      #SXA *+1,2    
       REM          
      #HPR **        ECHO CHECK OCCURRED ON
       REM           LAST LINE OF TEST PRINTOUT.
       REM          
       REM           THE ACCUMULATOR CONTAINS
       REM           THE ECHO WORD IN ERROR.
       REM           
       REM           THE MQ CONTAINS THE PRINT
       REM           IMAGE WORD COMPARED TO.
       REM          
       REM           THE SENSE INDICATORS
       REM           CONTAIN THE CARD IMAGE ROW
       REM           11-1 OCTAL IN THE DECREMENT
       REM           OR ADDRESS TO INDICATE LEFT
       REM           OR RIGHT.
       REM          
       REM           THE -SR- CONTAINS THE ADDRESS
       REM           FROM WHICH THE ECHK ROUTINE
       REM           WAS ENTERED.
       REM          
       TIX *-14,1,1 
       REM          
 RCHK  AXT **,1     
       AXT **,2     
       AXT **,4     
       LDI TEMPA    
       SWT 1        
       TRA 5,4      
       TRA 4,4      
       REM          
       TSX SPLTA,4   PRINT-AN ECHO ERROR
      #PZE CDECH     OCCURRED ON THE PREVIOUS
      #TCOA *        LINE OF TEST PATTERN
       REM           PRINTOUT.
       REM          
      #PXD ,2        GET TRUE EXIT LOCATION.
      #STL LOCAT     PRINT ERROR LOCATION AND
      #TRA ERLOC     SECTION START ADDRESS.
       REM          
      #WPRA          SPACE PRINTER
       REM          
      #TSX SPTAW,4   WPRA AND OFLOW TEST.
       REM          
       LXA RCHK+2,2  SAVED XRC TO XRB.
      #XEC 2,2       NOP OR SPRA 9.
       SPRA 8        SUPPRESS SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
      #CLA 2,2      
      #SUB LNOP     
      #TZE *+4      
      #TSX SPLAT+1,4 PRINT-49-120 COLUMN
      #PZE NUMBB     INDICATORS.
      #TRA *+3      
      #TSX SPLAT+1,4 PRINT-1-72 COLUMN
      #PZE NUMBA     INDICATORS.
      #TCOA *       
       REM          
      #TSX SPTAW,4   WPRA AND OFLOW TEST.
       REM          
      #XEC 2,2       NOP OR SPRA 9.
       SPRA 8        SUPPRESS SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
      #XEC 3,2       PRINT ERROR LINE.
      #TCOA *       
       REM          
      #TSX SPTAW,4   WPRA AND OFLOW TEST.
       REM          
      #XEC 2,2       NOP OR SPRA 9.
       SPRA 8        SUPPRESS SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       REM          
      #RCHA CWECH    PRINT ECHO IMAGE.
      #TCOA *       
       REM          
       REM          
      #TSX SPTAW,4   WPRA AND OFLOW TEST.
       REM          
      #AXT 18,1      DEVELOP ERROR BIT IMAGE.
      #CAL* 1,2     
      #ERA ECHO+18,1 
      #SLW ERBIT+18,1 STORE ERROR BIT IMAGE.
      #TIX *-3,1,1  
       REM          
      #XEC 2,2       NOP OR SPRA 9.
       SPRA 8        SUPPRESS SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       REM          
      #RCHA CWERB    PRINT ERRROR BIT IMAGE.
      #TCOA *       
       REM          
      #WPRA          SPACE PRINTER
      #TRA RCHK      GO TO SWT 1
       REM          
       REM          
       REM          
*IMGCK *** IMAGE COMPARE SUBROUTINE FOR SECTION AF.
       REM          
*      SPECIFICATIONS-
*       1. COMPARE PRINT IMAGES AS SPECIFIED BY THE
*          CALLING SEQUENCE AND PROVIDE ERROR
*          DETECTION AND INDICATION.
*       2. PROVIDE LOOP EXIT UNDER CONTROL OF SENSE SWITCH 1.
*       3. PROVIDE IGNORE ERROR INDICATION FACILITY UNDER CONTROL
*          OF SENSE SWITCH 2.
*       4. PROVIDE FOR HALT OR PRINTING OF ERROR INDICATIONS
*          UNDER CONTROL OF SENSE SWITCH 3.
       REM          
*      ERROR INDICATION FORMATS-
*       COMPARISION ERROR -HALT-
*       1. THE STORAGE REGISTER CONTAINS AN -HPR- WITH THE
*          LOCATION FROM WHICH THE -IMGCK- ROUTINE WAS
*          ENTERED IN ITS ADDRESS.
*       2. THE ACCUMULATOR WILL CONTAIN THE PRINT IMAGE WORD
*          IN ERROR. 
*       3. THE MQ REGISTER WILL CONTAIN THE CORRECT
*          COMPARISION WORD.
*       4. THE SENSE INDICATOR REGISTER WILL CONTAIN
*          A NUMBER. 13-1 OCTAL, IN THE LEFT OR RIGHT
*          HALF CORRESPONDING TO THE PRINT IMAGE LOCATION
*          MODIFIED. ZERO ROW WILL BE REPRESENTED BY -1.
       REM          
*      COMPARISON ERROR -PRINT-
*      1. -THE PRINT IMAGE WAS MODIFIED DURING THE
*         PREVIOUS LINE OF PRINTOUT.-
*      2. -PROGRAM EXIT AT -AAAAA. SECTION STARTS AT -BBBBB.-
*      3. -A LINE OF NUMERALS CORRESPONDING TO THE UNITS POSITION
*         OF THE TYPE WHEELS PRINTED.-
*      4. -THE LINE OF UNMODIFIED TEST PATTERN PRINTED UNDER WPR.-
*      5. -THE LINE OF MODIFIED TEST PATTERN PRINTED UNDER WPR.-
*      6. -A LINE OF PRINT REPRESENTING THE ERROR BIT
*         PATTERN PRODUCED BY AN EXCLUSIVE -OR- OF THE 
*         TWO IMAGES.
       REM          
       REM          
*      CALLING SEQUENCE-
*          A         TSX IMGCK,4
*          A+1       PZE FIRST LOC OF PRINT IMAGE, 1, WORD COUNT
*          A+2       PZE FIRST LOC OF COMPARE IMAGE, 1, WORD COUNT
*          A+3       NOP OR SPRA9 FOR LEFT OR RIGHT PRINT.
*          A+4       LOOP RETURN.
*          A+5       CONTINUE RETURN.
       REM          
       REM          
 IMCHK SXA RMCHK,1  
       SXA RMCHK+1,2 
       SXA RMCHK+2,4 
       STI TEMPA    
       REM          
       AXT 24,1      CLEAR ERROR BIT IMAGE.
       STZ ERBIT+24,1
       TIX *-1,1,1  
       REM          
       CLA 1,4       COMPARE PRINT IMAGES.
       PDC ,1        GET WORD COUNT
       PXD ,1        CHECK WORD COUNT
       TNZ *+2       FOR ZERO
       REM          
      #HPR *         ERROR-WORD COUNT ZERO IN
       REM           CALLING SEQUENCE.
       REM          
       SXD *+17,1   
       AXT 0,1      
       CLA* 1,4      PRINT IMAGE WORD.
       CAS* 2,4      COMPARISON IMAGE WORD.
      #TRA *+2       ERROR-IMAGES DID NOT COMPARE.
       REM          
       TRA *+11      OK-CONTINUE TO CHECK
       REM
      #SWT 2         TEST TO IGNORE ERROR
      #TRA *+2       UP-INDICATE ERROR.
      #TRA *+10      DOWN-IGNORE ERROR INDICATION.
      #LAC RMCHK+2,2 GET TRUE EXIT LOCATION.
      #SWT 3         TEST PRINT OR HALT.
      #TRA RMCHK+7   UP PRINT ERROR.
      #LDQ* 2,4      DOWN-SETUP ERROR HALT.
      #LDI IND,1    
      #SXA *+1,2    
       REM          
      #HPR **        IMAGE MODIFICATION OCCURED ON
       REM           LAST LINE OF TEST PRINTOUT.
       REM          
       REM           THE ACCUMULATOR CONTAINS THE
       REM           MODIFIED WORD.
       REM          
       REM           THE MQ CONTAINS THE CORRECT
       REM           WORD.
       REM          
       REM           THE SENSE INDICATORS CONTAIN
       REM           13-1 OCTAL IN THE LEFT OR
       REM           RIGHT HALF TO INDICATE THE
       REM           PRINT IMAGE LOCATION MODIFIED.
       REM           ZERO ROW IS INDICATED BY 77777.
       REM          
       REM           THE -SR- CONTAINS THE ADDRESS
       REM           FROM WHICH THE IMGCK ROUTINE
       REM           WAS ENTERED.
       REM          
       TXI *+1,1,-1 
       TXH *-15,1,** 
       REM          
 RMCHK AXT **,1     
       AXT **,2     
       AXT **,4     
       STI TEMPA    
       SWT 1        
       TRA 5,4      
       TRA 4,4      
       REM          
      #TSX SPLTA,4   PRINT-THE PRINT IMAGE WAS
      #PZE CDIMG     MODIFIED DURING THE PREVIOUS
      #TCOA *        LINE OF PRINT OUT.
       REM          
      #PXD ,2        GET TRUE EXIT LOCATION.
      #STL LOCAT     PRINT ERROR LOCATION AND
      #TRA ERLOC     SECTION PRINT ADDRESS.
       REM          
      #WPRA          SPACE PRINTER.
       REM          
      #TSX SPTAW,4  
       REM          
       LXA RMCHK+2,2 SAVED XRC TO XRB.
       REM          
      #XEC 3,2       NOP OR SPRA 9.
       SPRA 8        SUPPRESS SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
      #CLA 3,2      
      #SUB LNOP     
      #TZE *+4      
      #TSX SPLAT+1,4 PRINT-49-120 COLUMN
      #PZE NUMBB     INDICATORS.
      #TRA *+3      
      #TSX SPLAT+1,4 PRINT-1-72 COLUMN
      #PZE NUMBA     INDICATORS.
      #TCOA *       
       REM          
      #CLA 1,2       DEVELOP ERROR BIT IMAGE.
      #PDC ,1       
      #PXD ,1       
      #TNZ *+2      
      #HTR *-37      ERROR-WORD COUNT ZERO IN
      #SXD *+6,1     CALLING SEQUENCE.
      #AXT 0,1      
      #CAL* 1,2     
      #ERA* 2,2     
      #SLW ERBIT,1  
      #TXI *+1,1,-1 
      #TXH *-4,1,** 
       REM          
      #TSX SPTAW,4   WPRA AND OFLOW TEST.
       REM          
      #XEC 3,2       NOP OR SPRA 9.
       SPRA 8        SUPPRESS SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       REM          
      #RCHA 2,2      UNMODIFIED TEST IMAGE.
       REM          
      #TCOA *       
       REM          
      #TSX SPTAW,4   WPRA AND OFLOW TEST.
       REM          
      #XEC 3,2       NOP OR SPRA 9.
       SPRA 8        SUPPRESS SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       REM          
      #RCHA 1,2      MODIFIED TEST IMAGE.
      #TCOA *       
       REM          
      #TSX SPTAW,4   WPRA AND OFLOW TEST.
       REM          
      #XEC 3,2       NOP OR SPRA 9.
       SPRA 8        SUPPRESS SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       REM          
      #RCHA CWERA    ERROR BIT IMAGE.
      #TCOA *       
      #WPRA          SPACE PRINTER
      #TRA RMCHK     GO TO SWT 1
       REM          
       REM          
       REM          
*ERLOC *** PRINT PROGRAM EXIT AND SECTION START.
       REM          
*      SPECIFICATIONS-
*       1. OBTAIN MAIN PROGRAM EXIT LOCATION
*          FROM THE DECREMENT OF THE
*          ACCUMULATOR AND PRINT IT.
*       2. OBTAIN THE SECTION START ADDRESS
*          FROM -MONIT- COMPUTE IT AND
*          PRINT IT. 
*       3. OBTAIN TRANSFER LOCATION FROM -LOCAT-
*          AND COMPUTE EXIT.
       REM          
*      CALLING SEQUENCE-
*          A         STL LOCAT
*          A+1       TRA ERLOC
*          A+2       RETURN
       REM          
       REM          
 ERLOC#TSX CNVTD,4   CONVERT PROGRAM EXIT TO BCD
      #SLW CDLOC+4   AND STORE IT IN PRINT BCD.
      #LDC MONIT,4   OBTAIN SECTION START,
      #PXD ,4       
      #TSX CNVTD,4   CONVERT IT TO BCD AND
      #SLW CDLOC+9   STORE IT IN PRINT BCD.
      #TSX SPLTB,4  
      #PZE CDLOC    
      #CLA LOCAT     COMPUTE RETURN
      #ADD Q1       
      #STA *+1      
      #TRA **        RETURN
       REM          
       REM          
       REM          
*ERSCH *** PRINT-DSC REGISTER CONTENTS ON ERROR.
       REM          
*      SPECIFICATIONS-
*       1. OBTAIN CORRECT DSC REGISTER CONTENTS FROM
*          THE ACCUMULATOR.
*       2. OBTAIN DSC REGISTER CONTENTS IN ERROR FROM -HOLDA-.
*       3. PRINT BOTH ITEMS
*       4. COMPUTE RETURN LOCATION FROM -LOCAT-
*          AND RETURN.
       REM          
*      CALLING SEQUENCE-
*          A         STL LOCAT
*          A+1       TRA ERSCH
*          A+2       RETURN
       REM          
       REM          
 ERSCH#TSX CNVWD,4   
      #SLW CDDAT+5  
      #STQ CDDAT+6  
      #CLA HOLDA    
      #TSX CNVWD,4  
      #SLW CDDAT+11 
      #STQ CDDAT+12 
      #TSX SPLTB,4  
      #PZE CDDAT    
      #CLA LOCAT    
      #ADD Q1       
      #STA *+1      
      #TRA **       
       REM          
       REM          
*BLANK *** BLANK COLUMNS 49-72 OF PRINT IMAGE.
       REM          
*      SPECIFICATIONS-
*          MASK OUT 49-72 OF THE -IMAGE- PRINT IMAGE
*          STORAGE AREA TO PREVENT DOUBLE-PRINTING
*          WHEN PRINTING 120 COLUMNS.
*          THE CONDITION OF THE ACCUMULATOR IS NOT GUARANTEED.
       REM          
*      CALLING SEQUENCE
*          A         TSX BLANK,4
*          A+1       RETURN
       REM          
       REM          
 BLANK SXA BLRNK,4  
       AXT 24,4     
       CAL MASK     
       ANS IMAGE+25,4 BLANK 49-72 OF IMAGE.
       TIX *-1,4,2  
       REM          
 BLRNK AXT **,4     
       TRA 1,4      
       REM          
       REM          
       REM          
*CLARA *** CLEAR ECHO IMAGE SUBROUTINE
       REM          
*      SPECIFICATIONS-
*          STORE ZEROS IN 22 LOCATIONS OF THE
*          -ECHO- IMAGE AREA.
       REM          
*      CALLING SEQUENCE-
*          A         TSX CLARA,4
*          A+1       RETURN.
       REM          
       REM          
 CLARA SXA CLRRA,4  
       AXT 22,4     
       STZ ECHO+22,4 CLEAR ECHO IMAGE
       TIX *-1,4,1  
 CLRRA AXT **,4     
       TRA 1,4      
       REM          
       REM          
       REM          
*CLEAR *** CLEAR PRINT IMAGES
       REM          
*      SPECIFICATIONS-
*          CLEAR -IMAGE- AND -IMAGA- PRINT
*          IMAGE STORAGE AREAS.
       REM          
*      CALLING SEQUENCE-
*          A         TSX CLEAR,4
*          A+1       RETURN
       REM          
       REM          
 CLEAR SXA CLRAR,4  
       AXT 24,4     
       STZ IMAGE+24,4
       STZ IMAGA+24,4
       TIX *-2,4,1  
       REM          
 CLRAR AXT **,4     
       TRA 1,4      
       REM          
       REM          
       REM          
*CLERA *** CLEAR CORE STORAGE AS SPECIFIED BY CALLING SEQUENCE.
       REM          
*      CALLING SEQUENCE
*          A         TSX CLERA,4
*          A+1       PZE FIRST,2,N
*          A+2       RETURN
       REM          
*      FIRST - FIRST LOCATION OF BLOCK TO BE
*                CLEARED.
*      N    - NUMBER OF CELLS TO BE CLEARED.
       REM          
       REM          
 CLERA SXA CLERR,2  
       REM          
       CLA 1,4      
       PDC ,2        GET -N-.
       PXD ,2        CHECK -N-.
       TZE *+6       -N- EQUALS ZERO.
       SXD *+4,2     SET -N- IN LIMIT.
       AXT 0,2      
       STZ* 1,4      CLEAR.
       TXI *+1,2,-1  STEP COUNT.
       TXH *-2,2,**  TEST LIMIT.
       REM          
 CLERR AXT **,2     
       TRA 2,4      
       REM          
       REM          
       REM          
*CNVTD *** CONVERT BINARY DECREMENT TO BCD OCTAL
       REM          
*      SPECIFICATIONS-
*          CONVERT THE BINARY INTEGER VALUE IN
*          THE ACCUMULATOR DECREMENT TO
*          FIVE BCD OCTAL CHARACTERS
*          AND LEAVE THEM IN THE LOGICAL ACCUMULATOR
*          AS ONE BCD WORD, THE FIRST CHARACTER
*          OF THE WORD WILL BE A BLANK
       REM          
*      CALLING SEQUENCE
*          A         TSX CNVTD,4 BINARY IN ACC DECR.
*          A+1       RETURN       BCD IN LOGICAL ACC.
       REM          
       REM          
       REM          
 CNVTD SXA CNRTD,4  
       STQ TEMP      SAVE MQ.
       XCL           ACC TO MQ
       LGL 3         DELETE PREFIX
       CAL CNRTD+2   BLANK FIRST CHARACTER.
       AXT 5,4      
       ALS 3         CONVERT BINARY TO
       LGL 3         5 CHARACTERS OF BCD
       TIX *-2,4,1   OCTAL.
       LDQ TEMP      RESTORE M.Q.
       REM          
 CNRTD AXT **,4     
       TRA 1,4      
       REM          
       OCT 60        BCD BLANK
       REM          
       REM          
       REM          
*CNVWD ***CONVERT BINARY WORD TO BCD OCTAL.
       REM          
*      SPECIFICATIONS-
*          CONVERT THE CONTENTS OF THE ACCUMULATOR
*          S,1-35 TO TWO WORDS OF BCD OCTAL AND
*          LEAVE IN THE ACCUMULATOR AND M.Q. THE
*          HIGH ORDER WORD IS IN THE ACCUMULATOR.
       REM          
*      CALLING SEQUENCE-
*          A         TSX  CNVWD BINARY IN ACC S,1-35
*          A+1       RETURN        BCD IN ACC AND MQ.
       REM          
       REM          
 CNVWD SXA CNRWD,4  
       XCA          
       AXT 2,2       CONVERT 6 DIGITS PER LOOP
       SLW TEMP      SAVE ACC FOR FINAL EXIT.
       PXD           CLEAR ACCUMULATOR
       AXT 6,4       CONVERT 1 DIGIT PER LOOP.
       ALS 3        
       LGL 3        
       TIX *-2,4,1   GO BACK FOR NEXT DIGIT
       TIX *-6,2,1   GO BACK FOR LAST 6 DIGITS
       XCL           PREPARED TO EXIT
       CAL TEMP     
       REM          
 CNRWD AXT **,4     
       TRA 1,4      
       REM          
       REM          
       REM          
*MOVE  *** MOVE INFORMATION IN CORE STORAGE.
       REM          
*      SPECIFICATIONS-
*          MOVE INFORMATION IN CORE STORAGE AS
*          SPECIFIED BY THE CALLING SEQUENCE.
       REM          
*      CALLING SEQUENCE-
*          A         TSX MOVE,4
*          A+1       PZE FROM,2,N
*          A+2       PZE TO,2
*          A+3       RETURN.
       REM          
*      FROM - FIRST LOCATION FROM WHICH INFORMATION IS
*                TO BE MOVED.
*      N    -    NUMBER OF WORDS TO MOVE.
*      TO   -    FIRST LOCATION TO WHICH THE
*                INFORMATION IS TO BE MOVED.
       REM          
       REM          
 MOVE  SXA MRVE,2   
       REM          
       CLA 1,4       
       PDC ,2        GET -N-.
       PXD ,2        CHECK -N-.
       TZE *+7       -N- EQUALS ZERO
       SXD *+5,2     SET -N- IN LIMIT.
       AXT 0,2       
       CLA* 1,4      MOVE A TO B
       STO* 2,4     
       TXI *+1,2,-1  STEP COUNT.
       TXH *-3,2,**  TEST LIMIT.
       REM          
 MRVE  AXT **,2     
       TRA 3,4      
       REM          
       REM          
       REM          
*XCHNG *** INTERCHANGE INFORMATION IN CORE STORAGE
       REM          
*      CALLING SEQUENCE-
*          A         TSX XCHNGE,4
*          A+1       PZE FIRST,2,N
*          A+2       PZE SECOND,2
*          A+3       RETURN.
       REM          
*      FROM - FIRST LOCATION FROM WHICH INFORMATION IS
*                TO BE INTERCHANGED.
*      N    -    NUMBER OF WORDS IN BLOCK.
*      TO   -    FIRST LOCATION OF SECOND BLOCK
*                TO BE INTERCHANGED
       REM          
       REM          
 XCHNG SXA XCRNG,2  
       REM          
       CLA 1,4      
       PDC ,2        GET -N-.
       PXD ,2        CHECK -N-.
       TZE *+9       -N- EQUALS ZERO.
       SXD *+7,2    
       AXT 0,2      
       CLA* 1,4      EXCHANGE.
       LDQ* 2,4     
       STO* 2,4     
       STQ* 1,4     
       TXI *+1,2,-1  STEP COUNT.
       TXH *-5,2,** 
       REM          
 XCRNG AXT **,2     
       TRA 3,4      
       REM          
       REM          
       REM          
*RTATE *** PRINT IMAGE ROTATION SUBROUTINE.
       REM          
*      SPECIFICATIONS-
*          ROTATE THE -IMAGE- PRINT IMAGE ONE
*          PRINT POSITION TO THE LEFT AS 72 COLUMNS.
*          STATUS OF MQ, ACC, AND ACC OVFL NOT GUARANTEED.
       REM          
*      CALLING SEQUENCE-
*          A         TSX RTATE,4
*          A+1       RETURN.
       REM          
       REM          
 RTATE SXA RTRTE,4  
       AXT 24,4     
       CAL IMAGE+24,4 LEFT WORD.
       LDQ IMAGE+25,4 RIGHT WORD.
       LGL 1         SHIFT ROW LEFT 1 COL.
       SLW IMAGE+24,4 LEFT WORD SHIFTED.
       STQ IMAGE+25,4 RIGHT WORD SHIFED EXCEPT
       REM           COLUMN 72.
       ARS 36        COLUMN 1 TO COLUMN 72.
       ORS IMAGE+25,4 STORE COLUMN 72.
       TIX *-7,4,2  
 RTRTE AXT **,4     
       TRA 1,4      
       REM          
       REM          
       REM          
*RTATA *** PRINT IMAGE ROTATION SUBROUTINE.
       REM          
*      SPECIFICATIONS-
*          ROTATE THE -IMAGA- PRINT IMAGE ONE
*          PRINT POSITION TO THE LEFT AS 72 COLUMNS.
*          STATUS OF MQ, ACC, AND ACC OVFL NOT GUARANTEED.
       REM          
*      CALLING SEQUENCE-
*          A         TSX RTATA,4
*          A+1       RETURN.
       REM          
       REM          
 RTATA SXA RTRTA,4  
       AXT 24,4     
       CAL IMAGA+24,4 LEFT WORD.
       LDQ IMAGA+25,4 RIGHT WORD.
       LGL 1         SHIFT ROW LEFT 1 COL.
       SLW IMAGA+24,4 LEFT WORD SHIFTED.
       STO IMAGA+25,4 RIGHT WORD SHIFED EXCEPT
       REM           COLUMN 72.
       ARS 36        COLUMN 1 TO COLUMN 72.
       ORS IMAGA+25,4 STORE COLUMN 72.
       TIX *-7,4,2  
 RTRTA AXT **,4     
       TRA 1,4      
       REM          
       REM          
*RTATB *** PRINT IMAGE ROTATION SUBROUTINE.
*      SPECIFICATIONS-
*          ROTATE THE -IMAGE- PRINT IMAGE ONE
*          PRINT POSITION TO THE LEFT AS 48 COLUMNS.
*          STATUS OF MQ, ACC, AND ACC OVFL NOT GUARANTEED.
       REM          
*      CALLING SEQUENCE-
*          A         TSX RTATB,4
*          A+1       RETURN.
       REM          
       REM          
 RTATB SXA RTRTB,4  
       AXT 24,4     
       CAL IMAGE+24,4 LEFT WORD.
       LDQ IMAGE+25,4 RIGHT WORD.
       LGL 1         SHIFT ROW LEFT 1 COL.
       SLW IMAGE+24,4 LEFT WORD SHIFTED.
       STQ IMAGE+25,4 RIGHT WORD SHIFED
       REM           EXCEPT COLUMN 48.
       ARS 12        COLUMN 1 TO COLUMN 48.
       ORS IMAGE+25,4 COLUMN 48 AND GARBAGE
       CAL MASK      BLANK OUT
       ANS IMAGE+25,4 GARBAGE.
       TIX *-9,4,2  
 RTRTB AXT **,4     
       TRA 1,4      
       REM          
       REM          
       REM          
*SPRA2 *** DELAY PROGRAM 2 MILLISCONDS, THEN SPRA 2.
       REM          
*      CALLING SEQUENCE
*          A         TSX SPRA2,4
*          A+1       RETURN
       REM          
       REM          
 SPRA2 SXA SPRR2,4  
       AXT 84,4      2 MILLISECONDS DELAY
       TIX *,4,1     FOR SELECTOR PICKUP.
       SPRA 2       
       REM          
 SPRR2 AXT **,4     
       TRA 1,4      
       REM          
       REM          
       REM          
*READE *** RPRA, OVERFLOW TEST, IOT AND SCH TEST.
       REM          
*      CALLING SEQUENCE-
*          A         TSX READE,4
*          A+1       LOOP RETURN
*          A+2       CONTINUE RETURN.
       REM          
       REM          
 READE SXA RRADE,4  
       REM          
       RPRA          SELECT.
       SPTA          TEST OVERFLOW.
       TRA *+2       NO
       SPRA 1        YES.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REGISTER CONTENTS
       PZE **        DSC REGISTER STORAGE.
       TRA *+3       LOOP RETURN
       REM          
 RRADE AXT **,4      EXIT LINKAGE.
       TRA 2,4      
       REM          
       LXA *-2,4    
       TRA 1,4      
       REM          
       REM          
       REM          
*SPTAR *** RPRA AND OVERFLOW TEST.
       REM          
*      SPECIFICATIONS-
*       1. READ SELECT PRINTER
*       2. TEST FOR OVERFLOW.
*       3. IF OVERFLOW IS INDICATED-SKIP TO 1,
*          TCOA, IOT AND SCH TEST AND RESLECT
*          READ PRINTER.
*       4. PROVIDE LOOPING FACILITY UNDER CONTROL
*          OF SENSE SWITCH 1.
       REM          
*      CALLING SEQUENCE-
*          A         TSX SPTAR,4
*          A+1       LOOP RETURN
*          A+2       CONTINUE RETURN.
       REM          
       REM          
 SPTAR SXA SPTRR,4  
       REM          
       RPRA          SELECT.
       SPTA          OVERFLOW TEST.
       TRA *+13      NO
       SPRA 1        YES.
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE                    CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHEC OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   SCH CHECK.
       IOCD          CORRECT DSC REGISTER CONTENTS
       PZE **        DSC REGISTER STORAGE.
       TRA *+4       LOOP RETURN.
       RPRA          RESELECT AFTER OVERFLOW.
 SPTRR AXT **,4     
       TRA 2,4      
       RPRA         
       LXA SPTRR,4  
       TRA 1,4      
       REM          
       REM          
       REM          
*SPTAW *** WPRA AND OVERFLOW TEST
       REM          
*      SPECIFICATIONS-
*       1. SELECT WRITE PRINTER DECIMAL.
*       2. TEST FOR OVERFLOW
*       3. IF OVERFLOW IS INDICATED-SKIP TO
*          ONE, TCOA AND RESELECT WRITE PRINTER.
       REM          
*      CALLING SEQUENCE-
*          A         TSX SPTAW,4
*          A+1       RETURN.
       REM          
       REM          
 SPTAW WPRA         
       SPTA          TEST OVERFLOW.
       TRA *+4       NO
       SPRA 1        YES.
       TCOA *       
       WPRA          RESELECT
       TRA 1,4      
       REM          
       REM          
       REM          
*WRITD *** START PRINTER, OVERFLOW TEST AND IOT + SCH TEST.
       REM          
*      CALLING SEQUENCE-
*          A         TSX WRITD,4
*          A+1       LOOP RETURN
*          A+2       CONTINUE RETURN.
       REM          
       REM          
 WRITD SXA WRRTD,4   SAVE XRC.
       WPRA          SELECT.
       SPTA          OVERFLOW TEST.
       TRA *+2       NO.
       SPRA 1        YES.
       REM
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       TRA *+3       LOOP RETURN.
       REM          
 WRRTD AXT **,4      NORMAL RETURN.
       TRA 2,4       
       REM          
       LXA *-2,4     LOOP RETURN.
       TRA 1,4      
       REM          
       REM          
       REM          
       REM          
*ZONE  *** ALTERNATE ZONES FOR SECTION AD.
       REM          
*      SPECIFICATIONS-
*      INSTALL A ZONE BIT PATTERN IN THE -IMAGE-
*      AND -IMAGA- PRINT IMAGES. THE ZONE
*      ROWS TO BE STORED IS CONTROLLED BY THE
*      STATUS OF SWITCH CELLS ZONE 1, ZONE 2 AND ZONE 3.
       REM          
*      THIS SUBROUTINE IS DESIGNED TO BE ENTERED A TOTAL OF
*      FOUR TIMES PER TEST SECTION.
*      THREE TIMES IT RETURNS CONTROL
*      TO A LOOPING EXIT AND THE FOURTH
*      TIME IT RETURNS TO A CONTINUE NEXT
*      SECTION EXIT. TO OBTAIN CORRECT OPERATION
*      OF THE SUBROUTINE THE SWITCH CELLS SHOULD BE 
*      RESET TO ZERO UPON ENTRY TO THE
*      TEST SECTION THAT THIS SUBROUTINE IS TO
*      BE USED. SWITCH CELLS WILL BE SET AS FOLLOWS-
*        1ST ENTRY-TEST ZONE 1, SET ZONE 1, ZONE 12L, 11R.
*        2ND ENTRY-TEST ZONE 1+2, SET ZONE 2, ZONE 11L, OR.
*        3RD ENTRY-TEST ZONE 1,2+3, SET ZONE 3, ZONE 0L, 12R.
*        4TH ENTRY-TEST ZONE 1,2,3 RESET CELLS, EXIT NEXT SECTION.
       REM          
*      CALLING SEQUENCE-
*          A         TSX ZONE,4
*          A+1       REPEAT SECTION RETURN.
*          A+2       NEXT SECTION RETURN.
       REM          
       REM          
 ZONE  ZET ZONE1     CHECK IF CELL IS ZERO
       TRA *+8       NO-CONTINUE CELL CHECK
       CAL KADA      YES-SET 11R AND 12L.
       SLW IMAGE+21  11R IMAGE
       SLW IMAGE+22  12L IMAGE.
       SLW IMAGA+21  11R IMAGA.
       SLW IMAGA+22  12L IMAGA.
       STL ZONE1     SET CELL WITH BITS
       TRA 1,4       LOOP EXIT.
       REM          
       ZET ZONE2     CHECK IF CELL IS ZERO.
       TRA *+8       NO-CONTINUE CELL CHECK
       CAL KADA      YES-SET 0R AND 11L.
       SLW IMAGE+19  0R IMAGE.
       SLW IMAGE+20  11L IMAGE.
       SLW IMAGA+19  0R IMAGA.
       SLW IMAGA+20  11L IMAGA.
       STL ZONE2     SET CELL WITH BITS.
       TRA 1,4       LOOP EXIT.
       REM          
       ZET ZONE3     CHECK IF CELL IS ZERO
       TRA *+8       NO-GO TO NEXT SECTION EXIT
       CAL KADA      YES-SET 12R AND 0L.
       SLW IMAGE+18  0L IMAGE.
       SLW IMAGE+23  12R IMAGE.
       SLW IMAGA+18  0L IMAGA.
       SLW IMAGA+23  12R IMAGA.
       STL ZONE3     SET CELL WITH BITS.
       TRA 1,4       LOOP EXIT.
       REM          
       STZ ZONE1     NEXT SECTION EXIT.
       STZ ZONE2    
       STZ ZONE3    
       TRA 2,4      
       REM          
       REM          
       REM          
*WRITC *** PRINT -IMAGE- IN 72 COLUMNS AS SPECIFIED IN THE
*      *** CALLING SEQUENCE UNDER WPR.
       REM          
*      SPECIFICATIONS-
*       1. CHECK FOR AN OVERFLOW SIGNAL TO CAUSE A
*          CARRAGE OVERFLOW.
*       2. PRINT WHAT IS SET UP IN THE -IMAGE- PRINT
*          IMAGE AS SPECIFIED BY THE CALLING SEQUENCE.
*       3. PROVIDE FOR I/O CHECK AND CHANNEL DATA TESTS.
       REM          
*      CALLING SEQUENCE-
*          A         TSX WRITC,4
*          A+1       NOP OR SPRA 9 DEPENDING ON
*                    WHETHER PRINTING
*                    1-72 OR 49-120.
*          A+2       LOOP RETURN.
*          A+3       CONTINUE RETURN.
       REM          
       REM          
 WRITC SXA WRRTC,4   SAVE XRC.
       WPRA          SELECT
       SPTA          OVERFLOW TEST.
       TRA *+13      NO.
       SPRA 1        YES
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE                   CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN
       WPRA          RESELECT
       REM          
       LXA WRRTC,4   RESTORE XRC.
       XEC 1,4       NOP OR SPRA 9
       SPRA 8        SUPPRESS SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       RCHA CWIM     PRINT -IMAGE-.
       REM          
       SCHA *+9      RECORD DSC REGISTERS
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE IMAGE+24,,CWIM+1   CORRECT DSC REGISTER LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+7      RECORD DSC REGISTER
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD IMAGE+1,,CWIM+1  CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD IMAGE+24,,CWIM+1 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       TRA *+3       LOOP RETURN.
       REM          
 WRRTC AXT **,4      NORMAL RETURN.
       TRA 3,4      
       REM          
       LXA *-2,4     LOOP RETURN
       TRA 2,4      
       REM          
       REM          
       REM          
*READ  *** PRINT -IMAGE- AS SPECIFIED BY THE CALLING
       REM          
*      SPECIFICATIONS-
*       1. PRINT WHAT IS SET UP IN THE -IMAGE-
*          AS SPECIFIED BY THE CALLING SEQUENCE.
*       2. PROVIDE FOR I/O CHECK AND DSC REGISTER CONTENTS
*          TESTS WHEREVER POSSIBLE.
*       3. PROVIDE FOR ECHO CHECKING.
       REM          
*      CALLING SEQUENCE-
*          A         TSX READ,4
*          A+1       NOP OR SPRA 9, 1-72 OR 73-120
*          A+2       LOOP RETURN.
*          A+3       NORMAL RETURN.
       REM          
       REM          
 READ  SXA RRAD,4    SAVE XRS.
       REM          
       TSX CLARA,4   CLEAR ECHO IMAGE.
       REM          
       SCHA *+3 RECORD DSC REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       RCHA CWRM     PRINT -IMAGE-.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWRM+8    CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ECHO+18,,CWRM+8 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN
       REM          
       LXA RRAD,4    RESTORE XRC.
       CLA 1,4       SET UP FOR-ECHK-.
       STO *+3       FOR LEFT OR RIGHT SIDE.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARE LOCATION.
       PZE **        NOP OR SPRA 9.
       RCHA CWIM     LINE TO PRINT ON ERROR.
       TRA *+3       LOOP RETURN
       REM          
 RRAD  AXT **,4      NORMAL EXIT.
       TRA 3,4      
       REM          
       LXA RRAD,4    LOOP EXIT.
       TRA 2,4      
       REM          
       REM          
       REM          
       REM          
*READB *** PRINT -IMAGE- AND -IMAGA- IN COLUMNS 1-120 UNDER RPRA.
       REM          
*      SPECIFICATIOMS
*       1. CHECK FOR OVERFLOW SIGNAL TO CAUSE A CARRIAGE OVERFLOW.
*       2. PRINT WHAT IS SET UP IN THE -IMAGE- PRINT IMAGE IN COLUMNS
*          1-72, BLANK COLUMNS 49-72 IN THE -IMAGA- PRINT
*          IMAGE, AND PRINT COLUMNS 1-48 OF THE -IMAGA- PRINT IMAGE
*          AS COLUMNS 73-120 OF THE PRINTOUT UNDER RPRA.
*       3. PROVIDE FOR I/O CHECK AND CHANNEL DATA TESTS.
*       4. PROVIDE FOR EACH CHECKING.
*       5. PROVIDE FOR -IMAGE- AND -IMAGA- ROTATION.
*       6. PREFORM A LINE COUNT AS SPECIFIED BY THE CALLING SEQUENCE.
       REM          
*      CALLING SEQUENCE-
*          A         TSX READB,4
*          A+1       PZE NUMBER OF LINES TO PRINT.
*          A+2       RETURN
       REM          
       REM          
 READB SXA RRADB,4  
       REM          
       CLA 1,4      
       STO LINES     STORE LINE COUNT.
       REM          
       TSX READE,4   RPRA, OFLOW AND IOCK TEST.
       NOP           LOOP RETURN.
       REM          
       TSX CLARA,4   CLEAR IMAGE.
       REM          
       RCHA CWRM     PRINT -IMAGE-.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWRM+8    CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ECHO+18,,CWRM+8 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       TSX ECHK,4    CHECK ECHOES
       PZE IMAGE+18,1 COMPARE LOCATION.
       NOP           PRINTING 1-72.
       RCHA CWIM     LINE TO PRINT ON ERROR.
       NOP           LOOP RETURN.
       REM          
       RPRA          RESELECT FOR RIGHT HALF.
       SPRA 9       
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       AXT 24,4     
       CAL MASK      BLANK 49-72 OF -IMAGA-.
       ANS IMAGA+25,4 MASK OUT 12-35 OF
       REM           THE RIGHT HALF PRINT
       TIX *-1,4,2   IMAGE.
       REM          
       TSX CLARA,4   CLEAR ECHO IMAGE.
       REM          
       RCHA CWRMA    PRINT -IMAGA- IN 73-120.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWRMA+8    CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ECHO+18,,CWRMA+8 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       TSX ECHK,4    ECHO CHECK.
       PZE IMAGA+18,1 COMPARE LOCATION.
       SPRA 9        PRINTING 73-120.
       RCHA CWIMA    LINE TO PRINT ON ERROR.
       TRA READB+3   LOOP RETURN.
       REM          
       TSX RTATE,4   ROTATE IMAGE.
       REM          
       AXT 24,4      ROTATE IMAGA.
       CAL IMAGA+24,4 LEFT WORD.
       LDQ IMAGA+25,4 RIGHT WORD.
       LGL 1         SHIFT ROW LEFT 1 COL.
       SLW IMAGA+24,4 LEFT WORD SHIFTED.
       STQ IMAGA+25,4 RIGHT WORD SHIFTED.
       REM           EXECPT COLUMN 48.
       ARS 12        COLUMN 1 TO COL 48.
       ORS IMAGA+25,4 COLUMN 48 AND GARBAGE.
       CAL MASK      BLANK OUT
       ANS IMAGA+25,4 GARBAGE.
       TIX *-9,4,2  
       REM          
       CLA LINES     COUNT LINES
       SUB Q1       
       TZE *+2       GO TO EXIT.
       TRA READB+2   PRINT NEXT LINE.
       REM          
 RRADB AXT **,4      EXIT LINK.
       TRA 2,4      
       REM          
       REM          
       REM          
*READC *** PROVIDE RANDOM CHARACTERS, PRINTING AND CHECKING
*      *** FOR SECTION AL.
       REM          
*      SPECIFICATIONS-
*       1. PROVIDE FOR RANDOM CHARACTER GENERATION USING
*          -RANDN- AS SPECIFIED BY THE CALLING SEQUENCE.
*       2. PRINT WHAT IS SET UP IN THE -IMAGE- PRINT
*          IMAGE AS SPECIFIED BY THE CALLING SEQUENCE.
*       3. PROVIDE FOR I/O CHECK AND CHANNEL DATA TESTS.
*       4. PROVIDE FOR ECHO CHECKING.
       REM          
*      CALLING SEQUENCE-
*          A         TSX READC,4
*          A+1       FIRST RANDOM BCD WORD STG,,NO OF BCD WORDS
*          A+2       NOP OR SPRA 9 DEPENDING ON
*                                  WHETHER PRINTING
*                                  1-72 OR 49-120.
*          A+3       LOOP RETURN
*          A+4       CONTINUE RETURN.
       REM          
*          SELECTION OF THE PRINTER MUST BE ACCOMPLISHED
*          IN THE MAIN BODY OF THE PROGRAM.
       REM          
       REM          
 READC SXA RRADC,4  
       REM          
       TSX CLARA,4   CLEAR ECHO IMAGE
       REM          
       SCHA *+3      RECORD DSC REGISTERS.
       REM          
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           LOOP RETURN.
       REM          
       RCHA CWRM     PRINT -IMAGE-.
       REM          
       LXA RRADC,4   RESTORE XRC.
       CLA 1,4       GET RANDOM CHARACTER
       STO *+2       SPECIFICATION.
       TSX RANDN,4   GENERATE RANDOM CHARACTERS
       PZE **        AS SPECIFIED.
       REM          
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWRM+8   CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM          
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM          
       SCHA *+3      IOT AND DSC REGISTERS.
       REM          
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ECHO+18,,CWRM+8 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM          
       LXA RRADC,4   RESTORE XRC.
       CLA 2,4       GET LEFT OR RIGHT
       STO *+3       SIDE.
       REM          
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARE LOCATION
       PZE **        NOP OR SPRA 9.
       RCHA CWIM     LINE TO PRINT ON ERROR.
       TRA *+3       LOOP RETURN
       REM          
 RRADC AXT **,4      EXIT LINK.
       TRA 4,4      
       REM          
       LXA *-2,4    
       TRA 3,4      
       REM          
       REM          
       REM          
*RANDN *** RANDOM NUMBER BCD RECORD GENERATOR.
       REM          
*      SPECIFICATIONS-
*          GENERATE RANDOM BCD CHARACTERS AND
*          STORE AS SPECIFIED BY CALLING SEQUENCE.
       REM          
*      CALLING SEQUENCE
*          A         TSX RANDN,4
*          A+1       PZE FIRST,2,N
*          A+2       RETURN.
       REM          
*          FIRST   - FIRST LOCATION OF CORE STORAGE BLOCK
*                    TO CONTAIN RANDOM BCD CHARACTERS.
*          N       - NUMBER OF STORAGE CELLS TO BE
*                    FILLED BY RANDOM BCD CHARACTERS.
       REM          
       REM          
 RANDN SXA RRNDN,1  
       SXA RRNDN+1,2 
       SXA RRNDN+2,4 
       REM          
       CLA 1,4       GET STORAGE LOCATION
       STO *+6       AND NUMBER OF WORDS.
       STD *+2       COMPUTE LAST LOCATION+1.
       PAX ,1       
       TXI *+1,1,** 
       SXA *+34,1   
       REM          
       TSX CLERA,4   CLEAR STORAGE BLOCK.
       PZE **        BLOCK INFORMATION.
       REM          
       AXT 0,2       INITIALIZE CHARACTER COUNTER.
       LXD *-2,4     INITIALIZE WORD COUNTER.
       TRA *+3      
       REM          
       AXT **,1      MQ EMPTY COUNTER
       TXH *+11,1,1  MQ NOT EMPTY.
       REM          
       AXT 6,1       MQ EMPTY-RESET AND
       LDQ *+7       GENERATE NEW
       MPR *+7       RANDOM WORD IN
       ACL *+6       THE MQ.
       SLW *+5       X
       RQL 1         X
       STQ *+2       X
       TRA *+3       X
       REM          
       OCT 753175317531 PROTOTYPE 1.
       OCT 242624262426 PROTOTYPE 2.
       REM          
       PXD          
       LGL 6         GET RANDOM CHARACTER
       TXI *+1,1,-1  STEP MQ EMPTY COUNTER.
       SXA *-15,1    SAVE IT.
       REM          
       PAX ,1        CHECK FOR ILLEGAL CHARACTER
       TXL *+6,1,28 
       TXL *-18,1,31 NG
       TXL *+8,1,44  OK
       TXL *-20,1,47 NG.
       TXL *+6,1,60  NG
       TRA *-22      NG.
       REM          
       TXH *+4,1,15  OK.
       TXH *-24,1,12 NG.
       TXH *+2,1,10  OK
       TXH *-26,1,9  NG
       REM          
       ALS 30,2      SHIFT GOOD CHARACTER AND
       ORS **,4      STORE IT IN OUTPUT BLOCK.
       TXI *+1,2,6   STEP CHARACTER COUNTER.
       TXL *-30,2,30 GET NEXT CHARACTER.
       REM          
       AXT 0,2       RESTET CHARACTER COUNTER.
       TIX *-32,4,1  COUNT WORDS FILLED.
       REM          
 RRNDN AXT **,1      EXIT LINK.
       AXT **,2     
       AXT **,4     
       TRA 2,4      
       REM          
       REM          
       REM          
*SPLAT *** 72 COLUMN BCD PRINT ROUTINE USING-SPLTR-.
*      CALLING SEQUENCE-
*          A         TSX SPLAT,4 INCLUDES WPRA
*          A+1       PZE CW NOTE ZERO DECREMENT
       REM          
*          SEE -SPLTR FOR EXPLANATION OF -CW-.
       REM          
*          THERE IS NO TCOA INSTRUCTION IN
*          THE SUBROUTINE.
       REM          
*          THIS CALLING SEQUENCE
*          MAY BE MODIFIED BY USING TSX SPLAT+1,4
*          INSTEAD OF TSX SPLAT,4 IF IT IS DESIRED
*          TO SELECT THE PRINTER EXTERNALLY TO
*          THE SUBROUTINE. THIS WILL ENABLE
*          THE USE OF THE SENSE PRINTER INSTRUCTIONS.
       REM          
       REM          
 SPLAT WPRA          SELECT
       SXA SPRAT,4  
       CLA 1,4       SET CONTROL WORD.
       STO *+2      
       TSX SPLTR,4   BCD TO PRINT IMAGE.
       PZE **       
       RCHA CWCRD    PRINT -CARDA-.
       REM          
 SPRAT AXT **,4     
       TRA 2,4      
       REM          
       REM          
       REM          
       REM          
 SPLTA WPRA          CHECK FOR OVERFLOW
       SPTA          AND DOUBLE
       TRA *+2       SPACE BEFORE
       SPRA 1        ENTERING SPLAT.
       SPRA 3       
       TRA SPLAT+1  
       REM          
       REM          
       REM          
 SPLTB WPRA          CHECK FOR OVERFLOW
       SPTA          BEFORE ENTERING SPLAT.
       TRA SPLAT+1  
       SPRA 1       
       TRA SPLAT+1  
       REM          
       REM          
       REM          
*SPLTR *** 72 COLUMN BCD PRINT ROUTINE.
       REM          
       REM          
*      CALLING SEQUENCE-
*      1. THIS SEQUENCE PUTS THE TEXT IN THE BODY OF THE PROGRAM
       REM          
*         A         TSX SPLTR,4
*         A+1       PZE WC,,COL
*         A+2       BCD XTEXT TO BE PRINTED-
*          .        1-12 BCD WORDS, TOTAL WORD
*          .        COUNT EQUALS WC.
*         A+WC+2    RETURN TO MAIN PROGRAM
       REM          
*         WC  --    BCD WORD COUNT 1-12, OF TEXT LINE.
*         COL --    FIRST COLUMN 1-72, TEXT IS TO BE 
*                   PRINTED IN.
*         X   --    STANDARD SHARE BCD FORMAT WORD
*                   COUNT. NO MORE THAN 6 WORDS
*                   PER CARD DUE TO PUBLICATION
*                   RESTRICTIONS ON LISTING PAGE
*                   WIDTH.
       REM          
*         IF THE TEXT IS PLACED IN THE BODY OF THE PROGRAM IT
*         MAY BE MODIFIED BY IOM.
       REM          
       REM          
*      2. THIS SEQUENCE PERMITS THE SAME TEXT TO BE PRINTED
*         BY SEVERAL PRINT ROUTINE ENTRIES.
       REM          
*         A         TSX SPLTR,4
*         A+1       PZE CW        NOTE ZERO DECREMENT.
*         A+2       RETURN TO MAIN PROGRAM.
       REM          
*         CW        PZE WC,,CO
*         CW+1      BCD XTEXT TO BE PRINTED.
*          .        
*          .        
*          .        
       REM          
*         CW MAY BE LOCATED AT ANY DESIRED PLACE IN
*         THE PROGRAM.
       REM          
       REM          
*         3. THIS SEQUENCE PERMITS A CHOICE OF SEVERAL
*            TEXTS TO BE PRINTED BY ONE PRINT
*            SUBROUTINE ENTRY.
       REM          
*         A            TSX SPLTR,4
*         A+1          PZE CW,T     NOTE ZERO DECREMENT.
*         A+2          RETURN TO MAIN PROGRAM.
       REM          
*         T   - AN INDEX REGISTER CONTAINING A VALUE
*                   TO MODIFY THE CW LOCATION TO
*                   OBTAIN ANOTHER TEXT CONTROL WORD
*                   AND ITS ACCOMPANYING TEXT.
       REM          
       REM          
*      NOTES -      
       REM
       REM
*      RESULTS OF THE CONVERSION ARE LEFT
*      IN THE -CARDA- PRINT IMAGE.
       REM          
*      THE BCD TEXT MUST ALWAYS BE PRECEEDED
*      BY AN APPROPRIATE TEXT CONTROL WORD.
*      AN APPROPRIATE CONTROL WORD MUST ALWAYS
*      CONSIST OF A BCD WORD COUNT OF 1-12 IN
*      ITS ADDRESS, A NUMBER 1-72 EQUAL
*      TO THE COLUMN NUMBER AT WHICH THE TEXT
*      IS TO BEGIN IN ITS DECREMENT, AND
*      A PREFIX AND TAG OF ZERO.
       REM          
*      IF THE COLUMN NUMBER + THE NUMBER
*      OF CHARACTERS TO BE PRINTED - 1 EXCEEDS
*      72 THE REMAINING BCD CHARACTERS WILL
*      BE IGNORED.  
       REM          
*CONDITION OF THE ACC, MQ, AND ACC OVERFLOW
*TRIGGER IS NOT GUARANTEED ON EXIT FROM THIS ROUTINE.
       REM          
       REM          
 SPLTR NOP          GET GOING
       SXA SPLTR+61,1
       SXA SPLTR+62,2
       NOP          
       NZT 1,4       IF CONTROL WORD ZERO.
       REM          
*5                  
       TRA 2,4       RETURN
       REM          
       CAL 1,4       GET NON-ZERO WORD
       SLW SPLTR+85  SAVE CONTROL WORD
       PDX 0,1       TYPE WHEEL NO.
       TXL SPLTR+65,1,0 IF DECR. ZERO, GET
       REM           NEW CONTROL WORD
       REM          
*10                 
       SXD *+2,4     GET EXIT ADDRESS
       PAC 0,2       BY ADDING TWOS COMP.
       TXI *+1,2,0   OF N TO XRC.
       SXA SPLTR+63,2 EXIT VALUE.
       REM          
       REM SET BIT INDEX TO STARTING WHEEL
       REM          
       SXA *+3,1     FOR SHIFTING
       REM          
*15                 
       AXT 1,3       1 TO XRA AND XRB
       CAL SPLTR+82  BIT INDEX TO P
       LGR 0,1       SHIFT TO STARTING POINT
       TNZ *+3       IF ACC IS ZERO, SET FOR
       STQ SPLTR+83  RIGHT ROW, AND MAKE
       REM          
*20                 
       TXI *+2,2,1   XRB A DUECE
       SLW SPLTR+83  OTHERWISE, LEFT ROW.
       AXT 26,1     
       STZ CARD+26,1 CLEAR CARD IMAGE
       TIX *-1,1,1  
       REM          
       REM FORM CARD IMAGE.
       REM          
*25                 
       TIX *+1,4,1   ADDRESS OF FIRST WORD.
       AXT 6,1       CHARACTER COUNT.
       LDQ 1,4       GET THE WORD.
       SXA SPLTR+54,1 SAVE CHARACTER COUNT.
       PXD           CLEAR ACC
       REM          
*30                 
       LGL 2         ZONE
       ALS 1         TIMES 2
       PAX 0,1      
       SXA SPLTR+45,1 FOR FUTURE REFERENCE.
       CLM          
       REM          
*35                 
       LGL 4         DIGIT
       ALS 1         TIMES 2
       SLW CARD      TEMP0
       CAL SPLTR+83  BIT INDEX
       NZT CARD      IS DIGIT ZERO.
       REM          
*40                 
       TXH SPLTR+80,1,0 IS ZERO ZONE TOO.
       LXA CARD,1    OK, PROCEED
       TXH SPLTR+48,1,24 CHECK FOR ILLEGAL
       TXH SPLTR+78,1,20 SPECIAL CHARACTER.
       ORS* SPLTR+92,2 XRB PICKS LEFT OR RIGHT.
       REM          
*45                 
       AXT 0,1       ZONE AGAIN.
       TXL *+2,1,0   NOTHING FOR ZERO ZONE
       ORS* SPLTR+90,2 PLACE ZONE BIT.
       REM          
       REM  COLUMN SET.
       REM          
       ARS 1         SET BIT INDEX TO 
       TNZ *+4       NEXT COLUMN, IF ANY.
       REM          
*50                 
       TXH SPLTR+60,2,1 IF BX ZERO,+XRB 1, STOP
       REM          
       CAL SPLTR+82  IF NOT, SET TO RIGHT
       TXI *+1,2,1   ROW AND PROCEED.
       SLW SPLTR+83  BX READY FOR NEXT COLUMN.
       AXT 0,1       MORE CHARACTERS.
       REM          
*55                 
       TIX SPLTR+28,1,1 NEXT COLUMN
       LXA SPLTR+85,1 MORE WORDS MAYBE.
       TNX *+3,1,1    IF NOT, STOP.
       SXA SPLTR+85,1 YUMMY, GO GET EM.
       TXI SPLTR+25 
       REM          
*60                 
       NOP          
       AXT 0,1      
       AXT 0,2      
       AXT 0,4      
       TRA 2,4         EXIT
       REM          
       REM          
       REM  GET NEW CONTROL WORD FROM SOMPLACE
       REM          
       REM          
*65                 
       SXA SPLTR+63,4 FOR EXIT
       LXA SPLTR+61,1 RESTORE XRA
       NZT* SPLTR+85 IF CONTROL WORD ZERO
       TRA SPLTR+61  RETURN.
       CAL SPLTR+85  OLD CONTROL WORD
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
       SLW SPLTR+85 
       TXI SPLTR+14,4,1 PROCEED
       ORS* SPLTR+88,2 PUT EIGTH IN, TAKE
       TIX SPLTR+44,1,16 16 OUT, - GOOD BUSINESS
       REM          
*80                 
       TXL SPLTR+47,1,4 IF NOT BLANK, SET ZONE.
       TRA SPLTR+48    BLANK.
       REM          
       MZE             FOR BIT INDEX.
       HTR             DYNAMIC BIT INDEX.
       NOP          
       REM          
*85                 
       HTR             SPECIAL SALON FOR
       REM             THE CONTROL WORD
       HTR CARD+5   
       HTR CARD+4      BROW ADDRESSES
       HTR CARD+27,1 
       HTR CARD+26,1   ZONE ROW ADDRESSES
       REM          
*90                 
       HTR CARD+21,1 
       HTR CARD+20,1   DIGIT ROW ADDRESSES
       REM          
       REM
       REM
       REM
 NOMOD BSS           DUMMY INSTRUCTION.
       REM          
*      STORAGE FROM HERE TO 77777 IS NOT MODIFIED BY 9IOM.
       REM          
*      *** CONSTANTS AND STORAGE
       REM          
       REM          
 ZERO  PZE          
 KADA  OCT 373737373737
 KAEA  PZE 1,,1     
 KAFA  IOCP         
 ONES  OCT 777777777777
 SEVNS OCT 707070707070
 TWFVE OCT 252525252525
 FVETW OCT 525252525252
 THRES OCT 030303030303
 Q1    DEC 1        
 Q2    DEC 2        
 Q3    DEC 3        
 Q4    DEC 4        
 Q18   DEC 18       
 MASK  OCT 777700000000
       REM          
       REM          
 CATCH TSX SPACE,4  
 LTRA  OCT 200      
 LNOP  NOP          
       REM          
 RSTRT TRA 24       
 RCDA  RCDA         
 RTBA  RTBA 1       
 STRTA WPRA         
       WPRC         
       WPRE         
       REM          
       REM          
 IND   PZE ,,9      
       PZE 9        
       PZE ,,8      
       PZE 8        
       PZE ,,7      
       PZE 7        
       PZE ,,6      
       PZE 6        
       PZE ,,5      
       PZE 5        
       PZE ,,4      
       PZE 4        
       PZE ,,3      
       PZE 3        
       PZE ,,2      
       PZE 2        
       PZE ,,1      
       PZE 1        
       PZE ,,-1          0L
       PZE -1            0R
       PZE ,,11         11L
       PZE 11           11R
       PZE ,,12         12L
       PZE 12           12R
       REM          
       REM          
 TBAFA PZE 1     WORD COUNT   1
       PZE 2                  2
       PZE 3                  3
       PZE 4                  4
       PZE 5                  5
       PZE 6                  6
       PZE 7                  7
       PZE 8                  8
       PZE 9                  9
       PZE 10                10
       PZE 11                11
       PZE 12                12
       PZE 13                13
       PZE 14                14
       PZE 15                15
       PZE 16              16
       PZE 17                17
       PZE 18                18
       PZE 18                19
       PZE 18                20
       PZE 19                21
       PZE 20                22
       PZE 20                23
       PZE 20                24
       PZE 21                25
       PZE 22                26
       PZE 22,,1             27
       PZE 22,,2             28
       PZE 23,,2             29
       PZE 24,,2             30
       PZE 24,,3             31
       PZE 24,,4             32
       PZE 24,,5             33
       PZE 24,,6             34
       PZE 24,,7             35
       PZE 24,,8             36
       PZE 24,,9             37
       PZE 24,,10            38
       PZE 24,,11            39
       PZE 24,,12            40
       PZE 24,,13            41
       PZE 24,,14            42
       PZE 24,,15            43
       PZE 24,,16            44
       PZE 24,,17            45
       PZE 24,,18            46
       REM          
       REM
 TBAFB IOCD IMAGE+1,,CWAFA+1  CORRECT CHANNEL
       IOCD IMAGE+2,,CWAFA+2  DATA TABLE
       IOCD IMAGE+3,,CWAFA+3  FOR SECTION AF,
       IOCD IMAGE+4,,CWAFA+4
       IOCD IMAGE+5,,CWAFA+5
       IOCD IMAGE+6,,CWAFA+6
       IOCD IMAGE+7,,CWAFA+7
       IOCD IMAGE+8,,CWAFA+8
       IOCD IMAGE+9,,CWAFA+9
       IOCD IMAGE+10,,CWAFA+10
       IOCD IMAGE+11,,CWAFA+11
       IOCD IMAGE+12,,CWAFA+12
       IOCD IMAGE+13,,CWAFA+13
       IOCD IMAGE+14,,CWAFA+14
       IOCD IMAGE+15,,CWAFA+15
       IOCD IMAGE+16,,CWAFA+16
       IOCD IMAGE+17,,CWAFA+17
       IOCD IMAGE+18,,CWAFA+18
       IOCD ECHO+21,,CWAFA+19
       IOCD ECHO+22,,CWAFA+20
       IOCD IMAGE+19,,CWAFA+21
       IOCD IMAGE+20,,CWAFA+22
       IOCD ECHO+19,,CWAFA+23
       IOCD ECHO+20,,CWAFA+24
       IOCD IMAGE+21,,CWAFA+25
       IOCD IMAGE+22,,CWAFA+26
       IOCD ECHO+1,,CWAFA+27
       IOCD ECHO+2,,CWAFA+28
       IOCD IMAGE+23,,CWAFA+29
       IOCD IMAGE+24,,CWAFA+30
       IOCD ECHO+3,,CWAFA+31
       IOCD ECHO+4,,CWAFA+32
       IOCD ECHO+5,,CWAFA+33
       IOCD ECHO+6,,CWAFA+34
       IOCD ECHO+7,,CWAFA+35
       IOCD ECHO+8,,CWAFA+36
       IOCD ECHO+9,,CWAFA+37
       IOCD ECHO+10,,CWAFA+38
       IOCD ECHO+11,,CWAFA+39
       IOCD ECHO+12,,CWAFA+40
       IOCD ECHO+13,,CWAFA+41
       IOCD ECHO+14,,CWAFA+42
       IOCD ECHO+15,,CWAFA+43
       IOCD ECHO+16,,CWAFA+44
       IOCD ECHO+17,,CWAFA+45
       IOCD ECHO+18,,CWAFA+46
       REM          
       REM          
       REM          
 BIN   PZE          
 FREE  PZE          
 HOLDA PZE           CHANNEL DATA STORAGE.
 IOCNT PZE          
 IOTA  PZE          
 LINES BSS 1         PRINT LINE COUNTER STORAGE
       REM
 LOCAT PZE           STL STORAGE FOR SUBROUTINES
 MONIT PZE           SECTION START STORAGE
 SIZE  PZE           STORAGE SIZE CELL.
 TEMP  PZE          
 TEMPA PZE          
 TSAFA PZE          
       REM          
 ZONE1 PZE          
 ZONE2 PZE          
 ZONE3 PZE          
       REM          
 KOUNT DEC 40        PASS COUNTER FOR SWT 4.
 KONST DEC 40        PASS COUNTER CONTANT.
       REM          
       REM          
       REM          
*      *** BCD TEXTS.
       REM          
       REM          
 CDAAA PZE 7,,1     
       BCD 6SECTION AA. PRINTER DISCONNECT TEST
       BCD 1.       
       REM          
 CDAAB PZE 6,,1     
       BCD 6PRINTER DISCONNECT TEST COMPLETE.
       REM          
 CDABA PZE 8,,1     
       BCD 2SECTION AB.
       BCD 6CURSORY TEST COLUMNS 1-72 UNDER WPR.
       REM          
 CDACA PZE 9,,1     
       BCD 6SECTION AC. CURSORY TEST COLUMNS 73-
       BCD 3120 UNDER WPR.
       REM          
 CDACM PZE 12,,1    
       BCD 6SECTION ACM. QUICK CHECK ARMATURES A
       BCD 6ND ANALYZER SETUP, COLS 1-120, RPR.
       REM          
 CDADA PZE 11,,1    
       BCD 2SECTION AD.
       BCD 6PRINT 120 COLUMNS SPACED NUMERICS AN
       BCD 3D ZONES UNDER RPR.
       REM          
 CDAEA PZE 9,,1     
       BCD 6SECTION AE. PRINT 120 COLUMNS LIGHT
       BCD 3RIPPLE UNDER RPR.
       REM          
 CDAFA PZE 5,,1     
       BCD 5SECTION AF. BLEACHER TEST.
       REM          
 CDAFB SVN                   9L PRINT IMAGE
       SVN                   9R MASTER FOR
       PZE ,,28672           8L BLEACHER TEST.
       PZE ,,28672           8R
       PZE ,,3584            7L
       PZE ,,3584            7R
       PZE ,,448             6L
       PZE ,,448             6R
       PZE ,,56              5L
       PZE ,,56              5R
       PZE ,,7               4L
       PZE ,,7               4R
       PZE ,7                3L
       PZE ,7                3R
       PZE 28672             2L
       PZE 28672             2R
       PZE 3584              1L
       PZE 3584              1R
       PZE 448               0L
       PZE 448               0R
       PZE 56               11L
       PZE 56               11R
       PZE 7                12L
       PZE 7                12R
       REM          
 CDAGA PZE 6,,11    
       BCD 6SECTION AG. LIGHT-HEAVY RIPPLE TEST.
       REM          
 CDAGB PZE 12,,1    
       BCD 6ABCDEFGHIJKLMNOPQRSTUVWXYZ+-01234567
       BCD 689 .)$*,(=' ABCDEFGHIJKLMNOPQRSTUVW
       REM          
 CDAJA PZE 7,,1     
       BCD 6SECTION AJ. 12-9 MAGNET KICKBACK TES
       BCD 1T.      
       REM          
 CDAKA PZE 8,,1     
       BCD 6SECTION AK. NEARBY NUMERICS AND ZONE
       BCD 2S TEST. 
       REM          
 CDALA PZE 10,,1    
       BCD 6SECTION AL. 120 COLUMN RANDOM CHARAC
       BCD 4TER TEST UNDER RPR.
       REM          
 CDAMA PZE 7,,1     
       BCD 6SECTION AM. WRITE PRINTER BINARY TES
       BCD 1T.      
       REM          
 CDANA PZE 11,,1    
       BCD 6SECTION AN. WRITE PRINTER BINARY MUL
       BCD 5TIPLE LINES WITH ONE SELECT.
       REM          
 CDAPA PZE 11,,1    
       BCD 6SECTION AP. OCTAL SPACE RIGHT SIDE A
       BCD 6LTERNATE LINES UNDER WPR.
       REM          
 CDBAA PZE 7,,1     
       BCD 6SECTION B. WPR RIPPLE - CONTROL WORD
       BCD 1 TESTS. 
       REM          
 CDBBA PZE 4,,1     
       BCD 2SECTION BB.
       BCD 2IOCD, WC 24.
       REM          
 CDBCA PZE 4,,1     
       BCD 2SECTION BC.
       BCD 2IOST, LCHA.
       REM          
 CDBDA PZE 4,,1     
       BCD 2SECTION BD.
       BCD 2IOCT, LCHA.
       REM          
 CDBEA PZE 5,,1     
       BCD 2SECTION BE.
       BCD 3TCH, IOST, LCHA.
       REM          
 CDBFA PZE 5,,1     
       BCD 2SECTION BF.
       BCD 3IOCP, IOST, LCHA.
       REM          
 CDBGA PZE 5,,1     
       BCD 2SECTION BG.
       BCD 3IOSP, IOCT, LCHA.
       REM          
 CDBHA PZE 7,,1     
       BCD 2SECTION BH.
       BCD 5IOST, IORP, IOCP, IOST. WC 48.
       REM          
 CDBJA PZE 9,,1     
       BCD 6SECTION BJ. IOST, IORT, RCHA BLAST O
       BCD 3UT, IORT. WC-24.
       REM          
 CDBKA PZE 11,,1    
       BCD 2SECTION BK.
       BCD 6IOSP, IOCP, IOST, TCH, IOST, IOCT, I
       BCD 3OCP, TCH, IORT.
       REM          
 CDBLA PZE 8,,1     
       BCD 2SECTION BL.
       BCD 6IOST, IOCD, BLAST OUT WITH IORT.
       REM          
 CDBMA PZE 12,,1    
       BCD 6SECTION BM. WPR DBL SPACE RIPPLE, 3
       BCD 6LINES 1 SELECT SENSE EXIT HOLDOVER.
       REM          
 CDBNA PZE 7,,1     
       BCD 6SECTION B. RPR RIPPLE - CONTROL WORD
       BCD 1 TESTS. 
       REM          
 CDBPA PZE 5,,1     
       BCD 2SECTION BP.
       BCD 3IOCT, IOST. WC-46.
       REM          
 CDBQA PZE 9,,1     
       BCD 2SECTION BQ.
       BCD 6TCH, IOSP, IOST, IOCT, IOSP, IOST.
       BCD 1WC-46.  
       REM          
 CDBRA PZE 9,,1     
       BCD 2SECTION BR.
       BCD 6TCH, IOCP, IOCT, IOST, IOCP, IOCT.
       BCD 1WC-46.  
       REM          
 CDBSA PZE 12,,1    
       BCD 2SECTION BS.
       BCD 6IOCP, IOSP, TCH, TCH, IOSP, IOCP, TC
       BCD 4H, IOSP, IORT, WC-46.
       REM          
 CDBTA PZE 11,,1    
       BCD 2SECTION BT.
       BCD 6IOST, IOCT, IOCT, IOST, IOCT, IORP,
       BCD 3TCH, IOCD. WC-46.
       REM          
 CDBUA PZE 11,,1    
       BCD 6SECTION BU. RCHA BLAST OUT USING CON
       BCD 5TROL WORDS FROM SECTION BT.
       REM          
 CDBVA PZE 12,,1    
       BCD 6SECTION BV. READ PRINTER DBL SPACE,
       BCD 63 LINES 1 SEL, SENSE EXIT HOLDOVER
       REM          
 CDBWA PZE 8,,1     
       BCD 2SECTION BW.
       BCD 6TEST TRIGGER 19 ON READ PRINTER.
       REM          
 CDDSU PZE 5,,1     
       BCD 6THE DSU CHANNEL LOST CONTROL.
       REM          
 CDDSV PZE 12,,1    
       BCD 5DSC REG LIMIT
       BCD 6.  DSC REG CONTS STORED
       BCD 1.       
       REM          
 CDRNA PZE 12,,1    
       BSS 12       
       REM          
 CDRNB PZE 8,,1     
       BSS 8        
       REM          
 NUMBA PZE 12,,1    
       BCD 61234567890123456789012345678901234567890123456
       BCD 67890123456789012345678901234567890123456789012
       REM          
 NUMBB PZE 8,,1     
       BCD 63456789012345678901234567890123456789012345678
       BCD 2901234567890
       REM          
 CDIMG PZE 12,,1    
       BCD 6THE PRINT IMAGE WAS MODIFIED DURING
       BCD 6THE PREVIOUS LINE OF PRINT OUT.
       REM          
 CDIOT PZE 9,,1     
       BCD 6AN I/O CHECK WAS DETECTED AT LOCATIO
       BCD 3N -         .
       REM          
 CDSCH PZE 12,,1    
       BCD 6A STORE CHANNEL ERROR OCCURRED IN TH
       BCD 6E PREVIOUS LINE OF TEST PRINTOUT.
       REM          
 CDLOC PZE 10,,1    
       BCD 4PROGRAM EXIT AT-
       BCD 6.  SECTION STARTS AT-             .
       REM          
 CDDAT PZE 12,,1    
       BCD 6CORRECT DSC REG CONTS
       BCD 6.  DSC REG CONTS STORED
       REM          
 CDECH PZE 12,,1    
       BCD 6AN ECHO ERROR OCCURRED ON THE PREVIO
       BCD 6US LINE OF TEST PATTERN PRINTOUT.
       REM          
 CDCAR PZE 10,,1    
       BCD 6A CARRIAGE OVERFLOW HAS OCCURRED WHE
       BCD 4RE IT SHOULD NOT OCCUR.
       REM          
 CDCNR PZE 12,,1    
       BCD 6A CARRIAGE OVERFLOW INDICATION HAS N
       BCD 6OT OCCURRRED WHERE IT SHOULD OCCUR.
       REM          
 CDZAA PZE 9,,1     
       BCD 6NOW PERFORMING DIAGNOSTIC TEST 9P01
       BCD 3ON CHANNEL
       REM          
 CDZAB BCD 1A.      
       BCD 1C.      
       BCD 1E.      
       REM          
 CDZAC PZE 8,,1     
       BCD 5 9P01 PART ONE, PASS COMPLETE
       BCD 3ON CHANNEL
       REM          
       REM          
       REM          
 BLAST OCT 0                  9L
       OCT 64000000000        9R
       OCT 777777777000       8L
       OCT 1777777777         8R
       OCT 0                  7L
       OCT 0                  7R
       OCT 2                  6L
       OCT 10000000000        6R
       OCT 0                  5L
       PON                    5R
       OCT 777777777001
       OCT 1777777777
       OCT 110      
       MZE                   3R
       OCT 220               2L
       OCT                   2R
       OCT 40                
       OCT                   1R
       OCT                   8-4LE
       OCT                   8-4RE
       OCT 31                0L
       MZE                   0R
       OCT                   8-3LE
       OCT                   8-3RE
       OCT 777777777102     11L
       OCT 75777777777      12R
       OCT                   9LE
       OCT                   9RE
       OCT 240              12L
       PON                  12R
       REM          
       REM          
 BLWST OCT 0              9L PRINT-
       OCT 64000000000    9R BLAST
       OCT 777777777000   8L OUT
       OCT 1777777777     8R ERROR.
       OCT 0              7L
       OCT 0              7R
       OCT 2              LL
       OCT 10000000000    6R
       OCT 0              5L
       OCT 100000000000   5R
       OCT 777777777001   4L
       OCT 1777777777     4R
       OCT 110            3L
       OCT -0             3R
       OCT 220            2L
       OCT 0              2R
       OCT 40             1L
       OCT 0              1R
       OCT 31             0L
       OCT -0             0R
       OCT 777777777102   11L
       OCT 75777777777    11R
       OCT 240            12L
       OCT 100000000000   12R
       REM          
       REM          
       REM          
*      *** CONTROL WORDS.
       REM          
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWADA IOCD *+1,,2  
       PZE          
       PZE          
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWAFA IOCP IMAGE,,1         9L WRITE
       IOCP IMAGE+1,,1       9R X
       IOCP IMAGE+2,,1       8L X
       IOCP IMAGE+3,,1       8R X
       IOCP IMAGE+4,,1       7L X
       IOCP IMAGE+5,,1       7R X
       IOCP IMAGE+6,,1       6L X
       IOCP IMAGE+7,,1  6R X
       IOCP IMAGE+8,,1       5L X
       IOCP IMAGE+9,,1       5R X
       IOCP IMAGE+10,,1      4L X
       IOCP IMAGE+11,,1      4R X
       IOCP IMAGE+12,,1      3L X
       IOCP IMAGE+13,,1      3R X
       IOCP IMAGE+14,,1      2L X
       IOCP IMAGE+15,,1      2R X
       IOCP IMAGE+16,,1      1L X
       IOCP IMAGE+17,,1      1R X
       IOCP ECHO+20,,1     8-4L READ
       IOCP ECHO+21,,1     8-4R X
       IOCP IMAGE+18,,1      0L WRITE
       IOCP IMAGE+19,,1      0R X
       IOCP ECHO+18,,1     8-3L READ
       IOCP ECHO+19,,1     8-3R X
       IOCP IMAGE+20,,1     11L WRITE
       IOCP IMAGE+21,,1     11R X
       IOCP ECHO,,1          9L READ
       IOCP ECHO+1,,1        9R X
       IOCP IMAGE+22,,1     12L WRITE
       IOCP IMAGE+23,,1     12R X
       IOCP ECHO+2,,1        8L READ
       IOCP ECHO+3,,1        8R X
       IOCP ECHO+4,,1        7L X
       IOCP ECHO+5,,1        7R X
       IOCP ECHO+6,,1        6L X
       IOCP ECHO+7,,1        6R X
       IOCP ECHO+8,,1        5L X
       IOCP ECHO+9,,1        5R X
       IOCP ECHO+10,,1       4L X
       IOCP ECHO+11,,1       4R X
       IOCP ECHO+12,,1       3L X
       IOCP ECHO+13,,1       3R X
       IOCP ECHO+14,,1       2L X
       IOCP ECHO+15,,1       2R X
       IOCP ECHO+16,,1       1L X
       IOCP ECHO+17,,1       1R X
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWAFC IOCD IMAGA,,24
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBCA IOST IMAGE,,1 
       IOST IMAGE+1,,1 ADDRESS MODIFIED
       IOST IMAGE+1,,1 RESTORING CONSTANT.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBDA IOCT IMAGE,,1 
       IOCT IMAGE+1,,1 ADDRESS MODIFIED
       IOCT IMAGE+1,,1 RESTORING CONSTANT
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBEA TCH CWBEA+3,3,-1
       IOCD         
       IOST IMAGE+1,,1 ADDRESS IS MODIFIED
       IOST IMAGE,,1 
       TCH CWBEA+2,,1 DECREMENT IS MODIFIED.
       IOST IMAGE+1,,1 RESTORING CONSTANT
       TCH CWBEA+2,,1 RESTORING CONSTANT
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBFA IOST IMAGE,,1 
       IOCP IMAGE+1,,1 ADDRESS IS MODIFIED.
       IOST IMAGE+2 
       IOCP IMAGE+1,,1 RESTORING CONSTANT.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBGA IOCT IMAGE,,1 
       IOSP IMAGE+1,,1 ADDRESS IS MODIFIED
       IOCT IMAGE+2,,0
       IOSP IMAGE+1,,1 RESTORING CONSTANT
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBHA IOST IMAGE,,23
       IORP IMAGE+23,,1
       IOCP IMAGE,,23
       IOST IMAGE+23,,1
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBJA IOST IMAGE,,23
       IORT IMAGE+23,,1
       IOST IMAGE,,24
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBJB IOCD BLWST,,24
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBKA IOSP IMAGE,,1 
       IOCP IMAGE+1,,1
       IOST IMAGE+2,,3
       IOST IMAGE+5,,3
       TCH CWBKA+3,,1
       IOCT IMAGE+8,,3
       IOCP IMAGE+11,,3
       TCH CWBKA+9  
       IOCD         
       IORT IMAGE+14,,10
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBLA IOST IMAGE,,1 
       IORT IMAGE+1,,23 USE THIS FOR BLAST OUT.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBLB IOCD BLWST,,23
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBMA IORT IMAGE,,24
       IOCD         
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBPA IOCT IMAGE,,1 
       IOST IMAGE+1,,1 MODIFIED WORD.
       IOST IMAGE+1,,1 RESTORE WORD.
       IOCT ECHO+20,,1
       IOST ECHO+21,,1
       IOCT IMAGE+18,,1
       IOST IMAGE+19,,1
       IOST ECHO+18,,1
       IOCT ECHO+19,,1
       IOST IMAGE+20,,1
       IOCT IMAGE+21,,1
       IOCT ECHO,,1 
       IOST ECHO+1,,1
       IOCT IMAGE+22,,1
       IOST IMAGE+23,,1
       IOCT ECHO+2,,1 MODIFIED WORD.
       IOCT ECHO+2,,1 RESTORE WORD.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBQA IOSP IMAGE,,1 MODIFIED WORD.
       IOST IMAGE+1,,1 MODIFIED WORD.
       IOSP IMAGE+2,,1 MODIFIED WORD.
       TCH *-3,,-1  
       IOSP IMAGE+17,,1
       IOST ECHO+20,,1
       IOCT ECHO+21,,1
       TCH *-1,,25  
       IOSP IMAGE,,1 RESTORING WORD
       IOST IMAGE+1,,1 RESTORING WORD
       IOSP IMAGE+2,,1 RESTORING WORD.
       IOCT IMAGE+18,,2
       TCH *-1,,3   
       IOSP ECHO+18,,1
       TCH *+2,,10  
       IOCD         
       IOSP ECHO+19,,1
       IOST IMAGE+20,,1
       IOST IMAGE+21,,1
       TCH *-1,,64  
       IOSP ECHO,,1 
       TCH *+2,,1   
       IOCD         
       IOSP ECHO+1,,1
       IOSP IMAGE+22,,1
       IOST IMAGE+23,,1
       IOSP ECHO+3,,1      3,5,7,9,11,13,15
       IOST ECHO+2,,1    2,4,6,8,10,12,14,16
       IOST ECHO+17,,1   LAST WORD.
       IOSP ECHO+3,,1    RESTORING WORD.
       IOST ECHO+2,,1    RESTORING WORD.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBRA IOCP IMAGE,,1     1,4,6,10,13,16
       IOCT IMAGE+1,,1   2,5,8,11,14,17
       IOCP IMAGE+2,,1     3,6,9,12,15
       TCH *-3,,622 
       IOCP IMAGE+17,,1  18
       IOCT ECHO+20,,1   19
       IOST ECHO+21,,1   20
       TCH *-1,,263 
       IOCP IMAGE,,1     RESTORING WORD.
       IOCT IMAGE+1,,1   X
       IOCP IMAGE+2,,1   X
       IOST IMAGE+18,,2  21,22
       TCH *-1,,3359 
       IOCP ECHO+18,,1   23
       TCH *+2,,-1  
       IOCD         
       IOCP ECHO+19,,1   24
       IOCT IMAGE+20,,1  25
       IOCT IMAGE+21,,1  26
       TCH *-1,,256
       IOCP ECHO,,1      27
       TCH *+2,,-65 
       IOCD         
       IOCP ECHO+1,,1   28
       IOCP IMAGE+22,,1  29
       IOCT IMAGE+23,,1  30
       IOCP ECHO+3,,1      32,34,36,38,40,42,44
       IOCT ECHO+2,,1    31,33,35,37,39,41,43,45
       IOCT ECHO+17,,1 46
       IOCP ECHO+3,,1    RESTORING WORD
       IOCT ECHO+2,,1    X
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBSA IOCP IMAGE,,3       9L TO 8L PRINT.
       IOSP IMAGE+3,,3     8R TO 7R PRINT.
       IOCP IMAGE+6,,3     6L TO 5L PRINT.
       IOSP IMAGE+9,,3     5R TO 4R PRINT.
       IOCP IMAGE+12,,3    3L TO 2L PRINT.
       TCH *+2,,1   
       TCH *+3,,1   
       TCH *-1,,1   
       IOCD         
       IOSP IMAGE+15,,3    2R TO 1R PRINT.
       IOCP ECHO+20,,2     8-4 ECHO
       IOSP IMAGE+18,,2    0 PRINT.
       IOCP ECHO+18,,2     8-3 ECHO.
       IOSP IMAGE+20,,2    11 PRINT.
       IOCP ECHO,,2        9 ECHO.
       IOSP IMAGE+22,,2    12 PRINT.
       TCH *+1,,-1  
       IOSP ECHO+2,,5      8L TO 6L ECHO.
       IORT ECHO+7,,11     6R TO 1R ECHO.
       IOCD                DISCONNECT.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBTA IOST IMAGE,,9       9L TO 5R PRINT.
       IOCT IMAGE+9,,9     5R TO 1R PRINT.
       IOST ECHO+20,,2     8-4 ECHO.
       IOCT IMAGE+18,,2    0 PRINT.
       IOST ECHO+18,,2     8-3 ECHO.
       IOCT IMAGE+20,,2    11 PRINT.
       IOCT ECHO,,2        9 ECHO.
       IOST IMAGE+22,,2    12 PRINT.
       IOCT ECHO+2,,13     8L-3L ECHO.
       IORP ECHO+15,,3     3R-1R ECHO.
       TCH *+1,,-1  
       IOCD ERBIT+2        DISCONNECT.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBVA IOCP IMAGE,,18      9-1 PRINT.
       IOCP ECHO+20,,2     8-4 ECHO.
       IOCP IMAGE+18,,2    0   PRINT.
       IOSP ECHO+18,,2     8-3 ECHO.
       IOSP IMAGE+20,,2    11 PRINT.
       IOSP ECHO,,2        9 ECHO.
       IOSP IMAGE+22,,2    12 PRINT.
       IOSP ECHO+2,,15 8L TO 1L ECHO
       IORT ECHO+17,,1 1R ECHO.
       TCH CWBVA,,6 
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBVC IOCD         
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWBWA IOCP IMAGE,,18   9-1 PRINT.
       IOCPN ECHO+20,,2 8-4 ECHO-SUPPRESSED.
       IOCP IMAGE+18,,2 0 PRINT.
       IOCPN ECHO+18,,2 8-3 ECHO-SUPPRESSED.
       IOCP IMAGE+20,,2 11 PRINT.
       IOCP ECHO,,2     9 ECHO.
       IOCP IMAGE+22,,2 12 PRINT.
       IOCD ECHO+2,,16       8-1 ECHO.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
       REM          
 CWBM  IOCD IMAGE,,2 
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWCM  IOCD IMAGE,,8 
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWCRD IOCD CARDA,,24
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWERA IOCD ERBIT,,24
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWIM  IOCD IMAGE,,24
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWIMA IOCD IMAGA,,24
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWECH IOCD ECHO,,18 
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWERB IOCD ERBIT,,18
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWLST IOCDN BLAST,,30
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWRBL IOCP IMAGA,,18 9-1 WRITE.
       IOCP ECHO+20,,2      8-4 ECHO.
       IOCP IMAGA+18,,2 0 WRITE.
       IOCP ECHO+18,,2      8-3 ECHO.
       IOCP IMAGA+20,,2 11 WRITE.
       IOCD ECHO,,2         9ECHO.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWRM  IOCP IMAGE,,18        9-1 WRITE.
       IOCP ECHO+20,,2       8-4 ECHO.
       IOCP IMAGE+18,,2      0 WRITE.
       IOCP ECHO+18,,2       8-3 ECHO.
       IOCP IMAGE+20,,2      11 WRITE.
       IOCP ECHO,,2          9 ECHO.
       IOCP IMAGE+22,,2      12 WRITE.
       IOCD ECHO+2,,16       8-1 ECHO.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
 CWRMA IOCP IMAGA,,18        9-1 WRITE.
       IOCP ECHO+20,,2       8-4 ECHO.
       IOCP IMAGA+18,,2      0 WRITE.
       IOCP ECHO+18,,2       8-3 ECHO.
       IOCP IMAGA+20,,2      11 WRITE.
       IOCP ECHO,,2          9 ECHO.
       IOCP IMAGA+22,,2      12 WRITE.
       IOCD ECHO+2,,16       8-1 ECHO.
       REM          
       IOCD          PROGRAM PROTECT - I/O DISC.
       REM          
       REM          
       REM          
*      *** PRINT IMAGE STORAGES.
       REM          
       REM          
 BLOKA BSS 18       
       REM          
 CARD  BSS 2        
       REM          
 CARDA BSS 24       
       REM          
 IMAGE BSS 1         9 L COLUMN 1-72 PRINT
       BSS 1         9 R IMAGE STORAGE.
       BSS 1         8 L
       BSS 1         8 R
       BSS 1         7 L
       BSS 1         7 R
       BSS 1         6 L
       BSS 1         6 R
       BSS 1         5 L
       BSS 1         5 R
       BSS 1         4 L
       BSS 1         4 R
       BSS 1         3 L
       BSS 1         3 R
       BSS 1         2 L
       BSS 1         2 R
       BSS 1         1 L
       BSS 1         1 R
       BSS 1         0 L
       BSS 1         0 R
       BSS 1         11 L
       BSS 1         11 R
       BSS 1         12 L
       BSS 1         12 R
       REM          
 IMAGA BSS 1         9 L COLUMN 49-120 PRINT
       BSS 1         9 R IMAGE STORAGE.
       BSS 1         8 L
       BSS 1         8 R
       BSS 1         7 L
       BSS 1         7 R
       BSS 1         6 L
       BSS 1         6 R
       BSS 1         5 L
       BSS 1         5 R
       BSS 1         4 L
       BSS 1         4 R
       BSS 1         3 L
       BSS 1         3 R
       BSS 1         2 L
       BSS 1         2 R
       BSS 1         1 L
       BSS 1         1 R
       BSS 1                0 L
       BSS 1                0 R
       BSS 1         11 L
       BSS 1         11 R
       BSS 1         12 L
       BSS 1         12 R
       REM          
 ECHO  BSS 1         9 L ECHO IMAGE
       BSS 1         9 R STORAGE.
       BSS 1         8 L
       BSS 1         8 R
       BSS 1         7 L
       BSS 1         7 R
       BSS 1         6 L
       BSS 1         6 R
       BSS 1         5 L
       BSS 1         5 R
       BSS 1         4 L
       BSS 1         4 R
       BSS 1         3 L
       BSS 1         3 R
       BSS 1         2 L
       BSS 1         2 R
       BSS 1         1 L
       BSS 1         1 R
       BSS 1         8-3 L
       BSS 1         8-3 R
       BSS 1         8-4 L
       BSS 1         8-4 R
       REM          
 ERBIT BSS 1         9 L ERROR BIT STORAGE.
       BSS 1         9 R 
       BSS 1         8 L
       BSS 1         8 R
       BSS 1         7 L
       BSS 1         7 R
       BSS 1         6 L
       BSS 1         6 R
       BSS 1         5 L
       BSS 1         5 R
       BSS 1         4 L
       BSS 1         4 R
       BSS 1         3 L
       BSS 1         3 R
       BSS 1         2 L
       BSS 1         2 R
       BSS 1         1 L
       BSS 1         1 R
       BSS 1                0 L
       BSS 1                0 R
       BSS 1         11 L
       BSS 1               11 R
       BSS 1               12 L
       BSS 1               12 R
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
       REM          
*      *** 709 ROUTINE FOR MODIFICATION OF
*      *** I-O INSTRUCTIONS
       REM          
 CTRL1               COUNT WORD FOR DS A+B
 CTRL2               COUNT WORD FOR DS C+D
 CTRL3               COUNT WORD FOR DS E+F
 IOCT  BSS 1         I-O COUNT
       REM          
       REM          
       REM          
*ENTER CONTROL WORDS FOTR CHANNELS AND UNITS
       REM          
 IOC   STZ CTRL1     CLEAR
       STZ CTRL2     CONTROL
       STZ CTRL3     WORDS.
       REM          
       REM          
       REM          
       HTR *+1       ENTER KEYS WITH CONTROL
       REM           FOR DS A
       REM          
*NOTE - A TAG OF 1 WILL SPECIFY CHAN A
*       A TAG OF 2 WILL SPECIFY CHAN C
*       A TAG OF 4 WILL SPECIFY CHAN E
       REM          
*IF 2 OR MORE DS ARE TO BE TESTED THE 1ST CONTROL
*WORD ENTERED IN THE KEYS SHOULD CONTIAN A MULTIPLE TAG
       REM          
       REM          
       ENK           PLACE WORD
       XCL           ENTERED IN KEYS
       PAI           INTO INDICATORS
       REM          
 DSC   RFT 0,7       DO WE HAVE A TAG BIT
       TRA DSC1      YES
       HTR *-5       NO TAG BIT - RE-ENTER FIRST
       REM           CONTROL WORD SPECIFYING 
       REM           DS IN TAG OF KEYS
       REM          
       REM          
 DSC1  RNT 0,1       TEST FOR CHAN A
       TRA DSC2      NO
       STI CTRL1     CONTROL WORD FOR CHAN A
       REM          
 DSC2  RNT 0,2       TEST FOR CHAN C
       TRA DSC3      NO
       REM          
       REM          
       HTR *+1       SET CONTROL WORD IN KEYS
       REM           FOR CHAN C 
       REM          
       ENK          
       STQ CTRL2    
       REM          
 DSC3  RNT 0,4       TEST FOR CHAN E
       TRA *+4       NO
       REM          
       HTR *+1       SET CONTROL IN KEYS
       REM           FOR CHANNEL E
       REM          
       ENK          
       STQ CTRL3    
       REM          
       REM          
*ESTABLISH UNIT COUNT FROM CONTROL WORDS
       REM          
       REM          
       STZ IOCT      CLEAR UNIT COUNT
       AXT 3,2       
       LDI CTRL1+3,2 BRING IN CONTROL WORDS
       RFT 2         TEST FOR PRINTER
       TRA *+3       YES
       TIX *-3,2,1   NO-GET NEXT CONTROL
       TRA 1,4       RETURN
       REM          
       CLA IOCT      BRING IN COUNT
       ADD Q1        ADD ONE
       STO IOCT      RESTORE COUNT
       TRA *-5       GO GET NEXT CONTROL
       REM          
       REM          
       REM          
*MODIFY PRINTER INSTRUCTIONS
       REM          
       REM          
 RSET  STL REST      SET RESET SWITCH.
       REM          
 CTX   CLA 1,4       STARTING ADDRESS IN ADDRESS
       REM           ENDING ADDRESS IN DECREMENT
       SXA EXIT,4    SAVE XRC
       STA NOW       BEGINNING ADDRESS
       ARS 18       
       STA CHECK+1  
       STA RET      
       SUB NOW       # OF LOCATIONS TO CHECK
       PAX 0,1      
       REM          
*START MODIFICATION OF INSTRUCTIONS
       REM          
       REM          
 CHECK AXT 7,2      
       CAL 0,1       N LOCATION TO BE CHECKED
       SLW INSTR     SAVE INSTRUCTION
       ANA MASK1     SAVE OPERATION CODE
       LAS OPR1+7,2  
       TRA *+2      
       TRA SELCT     YES-IT IS A SELECT
       TIX *+1,2,1  
       TXH *-4,2,4   HAVE ALL SELECTS BEEN TESTED
       REM          
       ANA MASK2     NOT A SELECT, IS IT A CHANNEL
       LAS OPR2+4,2  INSTRUCTION
       TRA *+2      
       TRA RCH       YES-ITS A CHANNEL INSTR.
       TIX *-3,2,1  
       REM          
       CAL INSTR    
       ANA MASK5     CHECK TO TCOE
       SUB OPR2     
       TZE FOUND    
       TIX CHECK,1,1 NOT AN INSTRUCTION WE
       REM           WANT TO MODIFY. BRING
       REM           IN NEXT INSTRUCTION
       REM          
       REM          
 EXIT  AXT **,4      
       STZ REST      STATUS
       TRA 2,4       RETURN TO MAIN PROGRAM
       REM          
       REM          
       REM          
 SELCT CAL INSTR     WORKING INSTRUCTION
       TSX TRSET,4   CHECK RESET SWITCH
       ADD K2000     STEP TO NEXT CHANNEL
       TRA RET       RETURN TO RESTORE WORD
       REM          
       NOP          
       ADD K4000    
       TRA RET      
       REM          
       REM          
 FOUND AXT 4,2      
 RCH   CAL INSTR     WORKING INSTRUCTION
       TSX TRSET,4   CHECK FOR RESET
       TXH *+8,2,3   IS IT A TCO
       ADD K1000     STEP TO NEXT CHANNEL
       TRA RET       RETURN TO RESTORE WORD
       REM          
       TXH *+3,2,3   WILL COME HERE IF CHANNEL
       ADD K2200     C IS NOT SELECTED-NOT TCO
       TRA RET      
       REM          
       ADD K4200     NOT CHAN C-TCO
       TRA RET      
       REM          
       ADD K2200     CHAN C-TCO
       TRA RET      
       REM          
       REM          
       REM          
 TRSET NZT REST      TEST FOR RESET
       TRA *+2       NO
       TRA SET       YES
       REM          
       LDI CTRL2    
       RNT 200000    IS CHANNEL C SELECTED
       TRA 4,4       NO
       TRA 1,4       YES
       REM          
       REM          
 SET   TXH OUT,2,4   IS IT A SELECT.
       REM          
       ANA MASK3     SAVE ALL BUT OPERATION CODE
       ORA OPR1+7,2  OR IN CHANNEL A.
       TRA RET       RESTORE
       REM          
 OUT   ANA MASK4     SAVE ALL BUT CHANNEL.
       ORA K1001     OR IN CHAN. A
       REM          
 RET   SLW 0,1       RESTORE WORD
       TRA EXIT-1    NEXT WORD TO CHECK
       REM          
       REM          
 MASK1 OCT 777777770700
 MASK2 OCT 777477000000
 MASK3 OCT 77777777 
 MASK4 OCT 777777770777
 MASK5 OCT 777377000000
       REM          
 OPR1  OCT 076600000300      WRITE PRINTER
       OCT 076200000300      READ PRINTER
       OCT 076000000300      SENSE PRINTER
       REM              
 OPR2  OCT 006000000000      TCO
       OCT 064000000000      SCH
       OCT 054000000000      RCH
       OCT 054400000000      LCH
       REM                   
 K1000 OCT 000100000000      NEXT CHANNEL-CHANNEL INSTR
 K2000 OCT 2000              NEXT CHANNEL ON SELECT
 K2200 OCT 000200000000      NEXT-TCO, STEP 2-CHANNEL I
 K1001 OCT 1000             
 K4000 OCT 4000              STEP 2-SELECT
 K4200 OCT 000400000000      STEP 2-TCO
       REM          
 NOW   OCT 0        
 INSTR OCT 0        
 REST  OCT 0        
       REM          
       REM          
       REM          
 PLCB  RCDA          PUSH LOAD CARDS BUTTON.
       RCHA *+3     
       LCHA 0       
       TRA 1        
       REM          
       IOCT 0,0,3   
       REM          
       REM          
       REM          
 BEGNA TSX IOC,4     LOAD KEYS AND SAVE
       REM           CONTROL CONSTANTS
       REM          
       ENK           SET CORRECT LOAD
       TQP *+3       BUTTON SEQUENCE.
       CLA RCDA     
       TRA *-2      
       CLA RTBA     
       STO PLCB     
       REM          
       AXT -1,1      TEST SIZE OF STORAGE
       TXH MORE,1,4095 IF GREATER THAN 4K.
       REM          
       STL SIZE      4K STORAGE. SET
       REM           STORAGE SIZE SWITCH ON.
       REM          
*      *** SET UNUSED CORE STORAGE TO TSX SPACE,4.
       REM          
 SETRA AXT LASTA-FRSTA,4
       CLA CATCH    
       STO LASTA,4  
       TIX *-1,4,1  
       AXT 23,4     
       STO 24,4     
       TIX *-1,4,1  
       TRA 25       
       REM          
 MORE  STZ SIZE      MORE THAN 4K STORAGE.
       REM           SET STORAGE SIZE SWITCH OFF
       TRA PLCB      BRING IN REST OF PROGRAM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       REM
       TCD BEGNA
       REM
       REM
       REM
       REM
*      *** 9P01   PRINTER DIAGNOSTIC - PART TWO.
*      *** THE PROGRAMMED CARRIAGE CONTROL TEST.
       REM           
       REM           
       ORG 4096+24   
       REM           
       REM           
       TSX IOC,4     LOAD KEYS AND SAVE
       REM           CONTROL CONSTANTS
       REM           
       TSX RSET,4    RESET PART TWO TO
       PZE STRTB,,FRSTB CHANNEL A.
       REM           
       TSX RSET,4    RESET SUBROUTINE PACKAGE.
       PZE LASTA,,NOMOD TO CHANNEL -A-.
       REM           
       CLA RSTRT     POST
       STO 0         RESTART.
       REM           
       CLA IOCT      INITIALIZE THE
       STO IOCNT     UNIT COUNT.
       REM           
       LDI CTRL1     TEST I/O CONTROL FORMAT
       RFT 100002    FOR CHANNEL A.
       TRA STRTB     YES.
       REM           
 STRTC TSX CTX,4     NO CHANNEL A IN KEYS. GET
       PZE STRTB,,FRSTB NEXT CHANNEL.
       REM           
       TSX CTX,4     
       PZE LASTA,,NOMOD
       REM           
       REM           
 STRTB TRA *+2       
       REM           
       REM           
       WPRA          DUMMY INSTRUCTION TO BE
       REM           MODIFIED BY IOM.
       REM           
       AXT 3,4       
       CLA *-2       
       CAS STRTA+3,4 COMPARE A,C,E.
       TRA *+2       
       TRA *+3       
       TIX *-3,4,1   
       REM           
      #HTR 24        DUMMY INSTRUCTION AT
       REM           STRTB+1 NOT CORRECTLY
       REM           INITIALIZED. PRESS START
       REM           TO RETURN TO IOM TO
       REM           RELOAD THE KEYS AND RESTART
       REM           PROGRAM.
       REM           
       CAL CDZAB+3,4 
       SLW CDZAD+9   
       SLW CDZAE+8   
       REM           
       REM           
       REM           
*      *** CARRIAGE CONTROL TEST.
       REM           
       REM           
 AQA   TSX RESET,4   CLEAR CONSOLE AND SET -MONIT-.
       REM           
       WPRA          
       SPRA 3        DOUBLE SPACE.
       TSX SPLTA,4   PRINT-NOW PERFORMING
       REM           
       PZE CDZAD     9P01  PART TWO ON CHANNEL X.
       REM           
       AXT 5,1       
       WPRA          SPACE FIVE LINES
       TIX *-1,1,1   
       REM           
       AXT 52,1      PRINT-THIS IS A 709 OPERATED
       TSX SPLTB,4   AUTOMATIC CARRIAGE CONTROL
       PZE CDAQA+52,1 PROGRAM. INSURE THAT THE
       TCOA *        DIAGNOSTIC PRINTER BOARD AND
       TIX *-3,1,13  CARRAGE TAPE AER IN USE
       REM           AND OBSERVE THAT THE
       REM           SUCCEEDING LINES OF PRINTED
       REM           INFORMATION CONFORM WITH
       REM           THE ACTUAL OPERATION OF THE
       REM           CARRIAGE AND WRITE-UP
       REM           PROVIDED.
       REM           
       REM           
 AQB   RPRA          SELECT
       SPRA 1        SKIP TO 1.
       TSX CARR,4    PRINT-CARRIAGE SKIP TO 1.
       PZE CDAQB     PRINT ON LINE 1.
       PZE           NO OVERFLOW INDICATION EXPECTED.
       TRA AQB       LOOP RETURN
       REM           
 AQC   RPRA          SELECT
       SPRA 6        SKIP TO 5.
       SPRA 8        X
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 5, TAKE IDLE
       PZE CDAQX     CYCLE. MOVE TO 5 HOLD AND
       REM           PRINT ON LINE 25.
       PZE           NO OVERFLOW.
       TRA AQC       LOOP RETURN.
       REM           
 AQD   RPRA          SELECT 
       SPRA 7        SKIP TO 9.
       SPRA 8        X
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 9. TAKE IDLE
       PZE CDARB     CYCLE, MOVE TO 9 HOLD AND
       REM           PRINT ON LINE 49.
       PZE           NO OVERFLOW.
       TRA AQD       LOOP RETURN.
       REM           
 AQE   RPRA          
       SPRA 6        SKIP TO 2
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 2. TAKE IDLE
       PZE CDAQU     CYCLE, MOVE TO 2 HOLD AND
       REM           PRINT ON LINE 7.
       PZE           NO OVERFLOW.
       TRA AQE       LOOP RETURN.
       REM           
 AQF   RPRA          
       SPRA 10       SKIP TO 6.
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 6. TAKE IDLE
       PZE CDAQY     CYCLE, MOVE TO 6 HOLD AND
       REM           PRINT ON LINE 31.
       PZE           NO OVERFLOW.
       TRA AQF       LOOP RETURN.
       REM           
 AQG   RPRA          
       SPRA 6        SKIP TO 10.
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 10. TAKE IDLE
       PZE CDARC     CYCLE, MOVE TO 10 HOLD AND
       REM           PRINT ON LINE 55.
       PZE           NO OVERFLOW.
       TRA AQG       LOOP RETURN.
       REM           
 AQH   RPRA          
       SPRA 6        SKIP TO 3.
       SPRA 7        X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 3. TAKE IDLE
       PZE CDAQV     CYCLE, MOVE TO 3 HOLD AND
       REM           PRINT ON LINE 13.
       PZE           NO OVERFLOW.
       TRA AQH       LOOP RETURN.
       REM           
 AQJ   RPRA          
       SPRA 7        SKIP TO 7.
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 7. TAKE IDLE
       PZE CDAQZ     CYCLE, MOVE TO 7 HOLD AND
       REM           PRINT ON LINE 37.
       PZE           NO OVERFLOW.
       TRA AQJ       LOOP RETURN.
       REM           
 AQK   RPRA          
       SPRA 6        SKIP TO 4.
       SPRA 8        X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 4. TAKE IDLE
       PZE CDAQW     CYCLE, MOVE TO 4 HOLD AND
       REM           PRINT ON LINE 19.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 8        SKIP TO 8.
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 8. TAKE IDLE
       PZE CDARA     CYCLE, MOVE TO 8 HOLD AND
       REM           FROM LAST LINE
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       SPRA 3        DOUBLE SPACE.
       TSX CARR,4    PRINT-DOUBLE SPACE WITH EXTRA
       PZE CDAQM     SPACE, SHOULD BE 2 SPACES
       REM           FROM LAST LINE
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 3        DOUBLE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       TSX CARR,4    PRINT-DOUBLE SPACE WITH EXTRA
       PZE CDAQN     SPACE, SHOULD BE 4 SPACES
       REM           FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 7        SINGLE WITH
       TSX SPRA2,4   EXTRA SPACE.
       TSX CARR,4    PRINT-SINGLE SPACE WITH EXTRA
       PZE CDAQP     SPACE, SHOULD BE 2 SPACES
       REM           FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 3        DOUBLE
       TSX CARR,4    PRINT-DOUBLE SPACE. SHOULD
       PZE CDAQQ     SPACE, SHOULD BE 4 SPACES
       REM           FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 3        DOUBLE SPACE WITH
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       TSX CARR,4    PRINT-DOUBLE SPACE WITH EXTRA
       PZE CDAQM     SPACE, SHOULD BE 2 SPACES
       REM           FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       TSX CARR,4    PRINT - SINGLE SPACE. SHOULD
       PZE CDAQK     PRINT 2 SPACES FROM LAST
       REM           LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       TSX CARR,4    PRINT-SIGNLE SPACE SHOULD
       PZE CDAQR     PRINT 1 SPACE FROM LAST
       REM           LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       TSX CARR,4    PRINT-SIGNLE SPACE SHOULD
       PZE CDAQS     FIND 12 HOLE IN CARRIAGE TAPE.
       PON           OVERFLOW INDICATOR.
       TRA AQK       LOOP RETURN.
       REM           
 AQT   RPRA          
       SPRA 1        SKIP TO 1.
       TSX CARR,4    PRINT-SKIP TO 1. START
       PZE CDAQT     SYMETRICLA SHIFING - 6 SPACES
       REM           APART.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SKIP TO 2.
       TSX SPRA2,4   SPACE.
       TSX CARR,4    PRINT-SKIP TO 2. TAKE IDLE
       PZE CDAQU     CYCLE, MOVE TO 2 HOLD AND
       REM           PRINT ON LINE 7.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SKIP TO 3
       SPRA 7        X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 3. TAKE IDLE
       PZE CDAQV     CYCLE, MOVE TO 3 HOLD AND
       REM           PRINT ON LINE 13.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SKIP TO 4.
       SPRA 8        X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 4. TAKE IDLE
       PZE CDAQW     CYCLE, MOVE TO 4 HOLD AND
       REM           PRINT ON LINE 19.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SKIP TO 5.
       SPRA 8        X
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 5. TAKE IDLE
       PZE CDAQX     CYCLE, MOVE TO 5 HOLD AND
       REM           PRINT ON LINE 25.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 10       SKIP TO 6.
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 6. TAKE IDLE
       PZE CDAQY     CYCLE, MOVE TO 6 HOLD AND
       REM           PRINT ON LINE 31.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 7        SKIP TO 7.
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 7. TAKE IDLE
       PZE CDAQZ     CYCLE, MOVE TO 7 HOLD AND
       REM           PRINT ON LINE 37.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 8        SKIP TO 8.
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 8. TAKE IDLE
       PZE CDARA     CYCLE, MOVE TO 8 HOLD AND
       REM           PRINT ON LINE 43.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 7        SKIP TO 9.
       SPRA 8        X
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 9. TAKE IDLE
       PZE CDARB     CYCLE, MOVE TO 9 HOLD AND
       REM           PRINT ON LINE 49.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SKIP TO 10.
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 10. TAKE IDLE
       PZE CDARC     CYCLE, MOVE TO 10 HOLD AND
       REM           PRINT ON LINE 55.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 3        DOUBLE SPACE.
       TSX CARR,4    PRINT-DOUBLE SPACE. SHOULD
       PZE CDAQV     PRINT 2 SPACES FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SELECTIVE
       SPRA 7        SPACE.
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SELECTIVE SPACE. NO
       PZE CDARD     IDLE CYCLE, MOVE TO 11 HOLD
       REM           AND PRINT ON LINE 59.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       TSX CARR,4    PRINT-SINGLE SPACE. SHOULD
       PZE CDAQR     FIND 12 HOLD IN CARRIAGE
       REM           TAPE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       TSX CARR,4    PRINT-SINGLE SPACE. SHOULD
       PZE CDAQS     FIND 12 HOLD IN CARRIAGE
       REM           TAPE.
       PZE           NO OVERFLOW.
       TRA AQT       LOOP RETURN.
       REM           
 ARE   RPRA          
       SPRA 5        SHORT SKIP TO 1
       SPRA 1        X
       TSX CARR,4    PRINT-SHORT SKIP TO 1. NO
       PZE CDARE     IDLE CYCLE, MOVE TO 1 HOLD
       REM           AND PRINT ON LINE 1.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 5        SHORT SKIP
       SPRA 6        TO
       TSX SPRA2,4   2
       TSX CARR,4    PRINT-SHORT SKIP TO 2. NO
       PZE CDARF     IDLE CYCLE, MOVE TO 2 HOLD
       REM           AND PRINT ON LINE 7.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 5        SHORT
       SPRA 6        SKIP
       SPRA 7        TO
       TSX SPRA2,4   3
       TSX CARR,4    PRINT-SHORT SKIP TO 3. NO
       PZE CDARG     IDLE CYCLE, MOVE TO 3 HOLD
       REM           AND PRINT ON LINE 13.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 5        SHORT
       SPRA 6        SKIP
       SPRA 7        TO
       TSX SPRA2,4   4
       TSX CARR,4    PRINT-SHORT SKIP TO 4, NO
       PZE CDARH     IDLE CYCLE, MOVE TO 4 HOLD
       REM           AND PRINT ON LINE 19.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 5        SHORT SKIP TO ONE-
       SPRA 1        TOO FAR.
       TSX CARR,4    PRINT LINE ON FLY-
       PZE CDARJ     1111AAAAJJJJSSSS.
       PZE           NO OVERFLOW.
       TRA ARE       LOOP RETURN.
       REM           
 ARK   RPRA          
       SPRA 6        SUPRESS SPACE
       SPRA 7        X
       SPRA 8        X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SUPPRESS SPACE. LAST
       PZE CDARK     LINE ON FLY 4 INCHES BACK.
       REM           PRINT THIS ON LINE 1.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SKIP TO 2.
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SKIP TO 2. TAKE IDLE
       PZE CDAQU     CYCLE, MOVE TO 2 HOLD AND
       REM           PRINT ON LINE 7.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SELECTIVE
       SPRA 7        SPACE
       SPRA 10       LESS THAN
       TSX SPRA2,4   4SPACES.
       TSX CARR,4    PRINT-SLECTIVE SPACE. MOVE
       PZE CDARL     1 SPACE AND PRINT ON
       REM           LINE 8.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SELECTIVE
       SPRA 7        SPACE
       SPRA 10       LESS THEN
       TSX SPRA2,4   4SPACES.
       TSX CARR,4    PRINT-SELECTIVE SPACE. MOVE
       PZE CDARM     2 SPACES AND PRINT
       REM           ON LINE 10.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SELECTIVE
       SPRA 7        SPACE
       SPRA 10       LESS THAN
       TSX SPRA2,4   4SPACES
       TSX CARR,4    PRINT-SELECTIVE SPACE. MOVE
       PZE CDARN     3 SPACES AND PRINT
       REM           ON LINE 13.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 8        SELECTIVE SPACE + EXTRA SPACE.
       REM           IF THIS LINE PRINTS ON THE
       REM           FLY, THE CARRIAGE IS
       REM           TOO SLOW TO MEET
       TSX SPRA2,4   PROGRAMMERS MANUAL SPECS.
       TSX CARR,4    PRINT-SELECTIVE SPACE. MOVE
       PZE CDARP     4 SPACES AND PRINT ON
       REM           LINE 17.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 8        SELECTIVE SPACE + EXTRA SPACE.
       TSX SPRA2,4   LESS THAN 7 SPACES.
       TSX CARR,4    PRINT-SELECTIVE SPACE. MOVE
       PZE CDARQ     5 SPACES AND PRINT ON
       REM           LINE 22.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 8        SELECTIVE SPACE + EXTRA SPACE.
       TSX SPRA2,4   LESS THAN 7 SPACES.
       TSX CARR,4    PRINT-SELECTIVE SPACE. MOVE
       PZE CDARQ     6 SPACES AND PRINT ON
       REM           LINE 28.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SELECTIVE
       SPRA 7        SPACE
       SPRA 10       X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SELECTIVE SPACE. MOVE
       PZE CDARS     7 LINES AND PRINT ON
       REM           LINE 35.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       SPRA 3        DOUBLE SPACE.
       TSX CARR,4    PRINT-DOUBLE SPACE WITH EXTRA
       PZE CDAQM     SPACE. SHOULD BE 2 SPACES
       REM           FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 3        DOUBLE SPACE WITH
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       TSX CARR,4    PRINT-DOUBLE SPACE WITH EXTRA
       PZE CDAQN     SPACE. SHOULD BE 4 SPACES
       REM           FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SUPRESS SPACE
       SPRA 7        X
       SPRA 8        X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT-SUPPRESS SPACE. SHOULD
       PZE CDARQ     PRINT 1 SPCE FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 7        SINGLE SPACE WITH
       TSX SPRA2,4   EXTRA SPACE.
       TSX CARR,4    PRINT-SINGLE SPACW WITH EXTRA
       PZE CDARU     SPACE. SHOULD BE 1 SPACE
       REM           FORM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 7        SINGLE SPACE WITH
       TSX SPRA2,4   EXTRA SPACE.
       TSX CARR,4    PRINT-SINGLE SPACE WITH EXTRA
       PZE CDAQP     SPACE. SHOULD BE 2 SPACES
       REM           FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SUPRESS SPACE
       SPRA 7        X
       SPRA 8        X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT ALTERNATE CHARACTERS
       PZE CDARY     OF-SUPPRESS SPACE. SHOULD
       REM           PRINT ON VERY NEXT LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 6        SUPRESS SPACE
       SPRA 7        X
       SPRA 8        X
       TSX SPRA2,4   X
       TSX CARR,4    PRINT REST OF-SUPPRESS SPACE.
       PZE CDARZ     SHOULD PRINT ON VERY NEXT.
       REM           LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          SINGLE SPACE.
       TSX CARR,4    PRINT-SINGLE SPACE. SHOULD
       PZE CDAQR     PRINT 1 SPACE FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 3        DOUBLE SPACE.
       TSX CARR,4    PRINT-DOUBLE SPACE. SHOULD
       PZE CDARV     PRINT 2 SPACES FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 3        DOUBLE SPACE WITH
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       TSX CARR,4    PRINT-DOUBLE SPACE WITH EXTRA
       PZE CDAQM     SPACE. SHOULD BE 2 SPACES
       REM           FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          SINGLE SPACE WITH
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       TSX CARR,4    PRINT-SINGLE SPACE WITH EXTRA
       PZE CDAQP     SPACE. SHOULD BE 2 SPACES
       REM           FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          SINGLE SPACE,
       SPRA 8        SUPPRESS SPACE +
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       TSX CARR,4    PRINT-SINGLE SPACE, SUPPRESS
       PZE CDARW     SPACE AND EXTRA SPACE. PRINT
       REM           1 SPACE FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          SINGLE SPACE,
       SPRA 8        SUPPRESS SPACE +
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       TSX CARR,4    PRINT-SINGLE SPACE, SUPPRESS
       PZE CDARW     SPACE AND EXTRA SPACE. PRINT
       REM           1 SPACE FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       AXT 2,1       PRINT 2 LINES.
 ARX   RPRA          
       SPRA 8        SUPPRESS SPACE +
       SPRA 3        DOUBLE SPACE AND
       SPRA 7        EXTRA
       TSX SPRA2,4   SPACE.
       TSX CARR,4    PRINT-DOUBLE SPACE, SUPPRESS
       PZE CDARX     SPACE AND EXTRA SPACE. PRINT
       REM           2 SPACES FROM LAST LINE.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       TIX ARX,1,1   PRINT 2 LINES.
       REM           
       RPRA          SINGLE SPACE AND
       SPRA 5        NON
       SPRA 10       PRINT.
       TSX CARR,4    PRINT-NON-PRINT HUB. SHOULD
       PZE CDARW     NOT SPACE OR PRINT THIS.
       REM           NO GOOD.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          
       SPRA 5        DOUBLE SPACE AND
       SPRA 5        NON
       SPRA 10       PRINT.
       TSX CARR,4    PRINT-DOUBLE SPACE AND NON-
       PZE CDASC     PRINT. SHOULD NOT SPACE
       REM           OR PRINT THIS.
       PZE           NO OVERFLOW.
       NOP           LOOP RETURN.
       REM           
       RPRA          SINGLE SPACE,
       TSX CARR,4    PRINT-SINGLE SPACE, SHOULD
       PZE CDAQS     FIND 12 HOLE IN CARRIAGE TAPE.
       PON           OVERFLOW INDICATOR.
       TRA ARK       LOOP RETURN.
       REM           
       TSX SPLTA,4   PRINT-PROGRAMMED CARRIAGE
       PZE CDASB     CONTROL TEST COMPLETE.
       TCOA *        
       REM           
       TSX OK,4      
       TRA AQA       REPEAT SECTION.
       REM           
       REM           
       REM           
*ZC    *** 9P01 END OF PART TWO
       REM           
       REM           
 ZCA   TSX CHCKR,4   TEST PROGRAM SEQUENCE.
       REM           
       TSX SPLTA,4   PRINT - 9P01  PART TWO
       PZE CDZAE     PASS COMPLETE ON CHANNEL X.
       TCOA *        
       REM           
       CLA IOCNT     STEP UNIT COUNTER DOWN
       SUB Q1        BY 1
       TZE ZCB       COUNT ZERO-DONE.
       REM           
       STO IOCNT     NOT DONE
       NZT SIZE      TEST SIZE OF STORAGE.
       TRA ZCD       NOT 4K.
       TRA STRTC     REPEAT PART 2 ON
       REM           NEXT CHANNEL
       REM           
 ZCD   TSX CTX,4     NOT 4K. MODIFY I/O
       PZE STRTB,,FRSTB INSTRUCTIONS IN PART TWO
       TSX CTX,4     MODIFY I/O INSTRUCTIONS
       PZE START,,NOMOD IN PART ONE.
       TRA START     REPEAT ENTIRE PROGRAM ON
       REM           NEXT CHANNEL
       REM           
 ZCB   TSX SPLTA,4   PRINT - 9P01  PASS COMPLETE
       PZE CDZAF     ON ALL CHANNELS.
       REM           
       SWT 6         TEST SW 6
       TRA PLCB      UP-READ IN NEXT PROGRAM
       TRA 25        RESET I/O TO CHANNEL A
       REM           AND REPEAT PROGRAM.
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
*CARR  *** PRINT BCD TEXT UNDER RPRA FOR CARRIAGE TEST.
       REM           
*      SPECIFICATIONS-
*       1. CHECK FOR OVERFLOW AS SPECIFIED BY THE CALLING SEQUENCE.
*       2. CONVERT BCD TEXT AND PRINT IT AS SPECIFIED
*       3. PROVIDE FOR I/O CHECK AND CHANNEL DATA TESTS.
*       4. PROVIDE FOR ECHO CHECKING.
       REM           
*      ERROR INDICATION FORMATS-
*          IOT, SCH AND ECHO ERRORS CAUSE THEIR REGULAR
*          INDICATIONS UNDER SENSE SWITCH 3 CONTROL.
       REM           
*       CARRIAGE OVERFLOW ERROR - HALT.
*          THE STORAGE REGISTER CONTAINS AN -HPR- WITH THE LOCATION
*          FROM WHICH THE -CARR- ROUTINE WAS ENTER IN THIS ADDRESS.
*          IF THE ERROR IS A FAILURE TO INDICATE AN OVERFLOW
*          WHEN THE INDICATION SHOULD BE PRESENT, THE CONTENTS
*          OF THE ACCUMULATOR WILL BE ALL ONES.
*          IF THE ERROR IS A FALSE OVERFLOW INDICATION WHEN
*          NO OVERFLOW INDICATION SHOULD BE PRESENT, TEH
*          ACCUMULATOR WILL CONTAIN 707070707070.
       REM           
*      CARRIAGE OVERFLOW ERROR - PRINT -
*      1. ONE OR THE OTHER OF THE FOLLOWING TEXTS
*         WILL BE PRINTED-
       REM           
*         -THE CARRIAGE OVERFLOW INDICATION HAS NOT 
*         OCCURRED WHERE IT SHOULD.
       REM           
*         -A CARRIAGE OVERFLOW INDICATION HAS OCCURRED
*         WHERE IT SHOULD NOT.
       REM           
*      2. -PROGRAM EXIT AT AAAAA. SECTION STARTS
*         AT BBBBB.- 
       REM           
*      CALLING SEQUENCE-
*          A PREVIOUS RPRA AND ALL DESIRED
*          SENSE PRINTER INSTRUCTIONS MUST BE GIVEN BEFORE ENTRY
*          TO THIS SUBROUTINE.-
*          A         TSX CARR,4
*          A+1       PZE LOCATION OF BCD TEXT.
*          A+2       PZE OR MZE.
*                    PZE-IF NO OVERFLOW SHOULD OCCUR.
*                    MZE-IF OVERFLOW SHOULD OCCUR.
*          A+3             LOOP RETURN.
*          A+4             CONTINUE RETURN.
       REM           
       REM           
 CARR  SXA CRRR,2    
       SXA CRRR+1,4  
       REM           
       CLA 1,4       SET BCD TEXT TO
       STO *+2       CONVERT.
       REM           
       TSX SPLTR,4   CONVERT BCD TEXT.
           **        
       REM           
       TSX MOVE,4    MOVE -CARDA- TO -IMAGE-.
       PZE CARDA,2,24 
       PZE IMAGE,2   
       REM           
       TSX CLARA,4   CLEAAR ECHO IMAGE.
       REM           
       SCHA *+3      RECORD DSC REGISTERS.
       REM           
       TSX SCHT,4    SCH CHECK.
       IOCD          CORRECT DSC REG CONTENTS
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM           
       RCHA CWRM     PRINT TEXT.
       REM           
       TSX IODSC,4   TEST CHANNEL RUNAWAY UNTIL
       REM           DISCONNECT.
       PZE ECHO+22,,CWRM+8   CORRECT DSC REG LIMITS.
       NOP           LOOP RETURN.
       REM           
       IOT           TEST FOR I/O CHECK.
       STL IOTA      I/O CHECK OCCURRED.
       REM           
       SCHA *+3      RECORD DSC REGISTERS.
       REM           
       TSX SCHTA,4   IOT AND SCH CHECK.
       IOCD ECHO+18,,CWRM+8 CORRECT DSC REG CONTS.
       PZE **        DSC REGISTER STORAGE.
       NOP           IGNORE LOOP RETURN.
       REM           
       TSX ECHK,4    CHECK ECHOES.
       PZE IMAGE+18,1 COMPARISON LOCATION.
       NOP           CHECK 1-72
       RCHA CWIM     LINE TO PRINT ON ERROR.
       NOP           IGNORE LOOP RETURN.
       REM           
       LXA CRRR+1,4  RESTORE XRC
       LAC CRRR+1,2  SAVE TRUE EXIT LOCATION.
       SPTA          TEST FOR OVERFLOW INDICATION.
       TRA *+12      NO OVERFLOW INDICATION
       ZET 2,4       TEST OVERFLOW INDICATION
       REM           FOR ERROR.
       REM           
       TRA *+20      OK-PROGRAM MATCHES
       REM           OVERFLOW INDICATION.
       REM           
      #SWT 2         ERROR-TEST TO IGNORE
      #TRA *+2       UP-INDICATE ERROR
      #TRA *+17      DOWN-IGNORE INDICATION.
       REM           
      #SWT 3         TEST ERROR PRINT OR HALT.
      #TRA *+20      UP-PRINT ERROR
      #CAL SEVNS     DOWN-HALT ON ERROR
      #SXA *+1,2     
       REM           
      #HPR **        ERROR-OVERFLOW INDICATION
       REM           WHERE PROGRAM DOES NOT
       REM           ALLOW IT.
       REM           
      #TRA *+11      GO TO SWT ONE
       REM           
       NZT 2,4       TEST NO OVERFLOW INDICATION
       REM           FOR ERROR.
       REM           
       TRA *+9       OK-PROGRAM MATCHES THE
       REM           NO OVERFLOW INDICATION.
       REM           
      #SWT 2         ERROR-TEST TO IGNORE.
      #TRA *+2       UP-INDICATE ERROR
      #TRA *+6       DOWN-IGNORE ERROR INDICATION.
       REM           
      #SWT 3         TEST HALT OR PRINT ERROR.
      #TRA *+16      UP-PRINT ERROR
       REM           
      #CAL ONES      DOWN-HALT ON ERROR.
      #SXA *+1,2     
       REM           
      #HPR **        ERROR-NO OVERFLOW INDICATION
       REM           WHERE PROGRAM REQUIRES
       REM           AN OVERFLOW.
       REM           
 CRRR  AXT **,2      EXIT LINK.
       AXT **,4      
       REM           
       SWT 1         TEST FOR LOOP
       TRA 4,4       UP-CONTINUE.
       TRA 3,4       DN-LOOP.
       REM           
       TSX SPLTA,4   PRINT-A CARRIAGE OVERFLOW
      #PZE CDCAR     INDICATION HAS OCCURRED
      #TCOA *        WHERE IT SHOULD NOT.
       REM           
      #PXD ,2        OBTAIN PROGRAM EXIT
      #STL LOCAT     PRINT PROGRAM LOCATION AND
      #TRA ERLOC     SECTION START ADDRESS
      #TRA *-11      GO TO SWT 1
       REM           
      #TSX SPLTA,4   PRINT-A CARRIAGE OVERFLOW
      #PZE CDCNR     INDICATION HAS NOT OCCURRED
      #TCOA *        WHERE IT SHOULD OCCUR.
      #TRA *-7       PRINT ERROR LOCATION.
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
 CDAQA PZE 12,,1     
       BCD 6SECTION AQ. THIS IS A 709 OPERATED A
       BCD 6UTOMATIC CARRIAGE CONTROL PROGRAM.
       REM           
       PZE 12,,1     
       BCD 6INSURE THAT THE DIAGNOSTIC PRINTER B
       BCD 6OARD AND CARRIAGE TAPE ARE IN USE
       REM           
       PZE 12,,1     
       BCD 6AND THAT THE LINES OF PRINTED INFORM
       BCD 6ATION CONFORM WITH THE ACTUAL
       REM           
       PZE 12,,1     
       BCD 6OPERATION OF THE CARRIAGE AND WRITE-
       BCD 6UP PROVIDED.
       REM           
 CDAQB PZE 6,,1      
       BCD 6CARRIAGE SKIP TO 1. PRINT ON LINE 1
       REM           
 CDAQK PZE 9,,1      
       BCD 6SINGLE SPACE. SHOULD PRINT 2 SPACES
       BCD 3FROM LAST LINE
       REM           
 CDAQM PZE 11,,1     
       BCD 6DOUBLE SPACE WITH EXTRA SPACE. SHOUL
       BCD 5D BE 2 SPACES FROM LAST LINE.
       REM           
 CDAQN PZE 11,,1     
       BCD 6DOUBLE SPACE WITH EXTRA SPACE. SHOUL
       BCD 5D BE 4 SPACES FROM LAST LINE.
       REM           
 CDAQP PZE 11,,1     
       BCD 6SINGLE SPACE WITH EXTRA SPACE. SHOUL
       BCD 5D BE 2 SPACES FROM LAST LINE.
       REM           
 CDAQQ PZE 9,,1      
       BCD 6DOUBLE SPACE. SHOULD PRINT 4 SPACES
       BCD 3FROM LAST LINE.
       REM           
 CDAQR PZE 9,,1      
       BCD 6SINGLE SPACE. SHOULD PRINT 1 SPACE
       BCD 3FROM LAST LINE.
       REM           
 CDAQS PZE 9,,1      
       BCD 6SINGLE SPCE. SHOULD FIND 12 HOLE IN
       BCD 3 CARRIAGE TAPE.
       REM           
 CDAQT PZE 9,,1      
       BCD 6SKIP TO 1, START SYMETRICAL SHIFING
       BCD 3 - 6 SPACES APART.
       REM           
 CDAQU PZE 11,,1     
       BCD 6SKIP TO 2, TAKE IDLE CYCLE, MOVE
       BCD 52 HOLE AND PRINT ON LINE 7.
       REM           
 CDAQV PZE 11,,1     
       BCD 6SKIP TO 3, TAKE IDLE CYCLE, MOVE TO
       BCD 53 HOLE AND PRINT ON LINE 13.
       REM           
 CDAQW PZE 11,,1     
       BCD 6SKIP TO 4, TAKE IDLE CYCLE, MOVE TO
       BCD 54 HOLE AND PRINT ON LINE 19.
       REM           
 CDAQX PZE 11,,1     
       BCD 6SKIP TO 5, TAKE IDLE CYCLE, MOVE TO
       BCD 55 HOLE AND PRINT ON LINE 25.
       REM           
 CDAQY PZE 11,,1     
       BCD 6SKIP TO 6, TAKE IDLE CYCLE, MOVE TO
       BCD 56 HOLE AND PRINT ON LINE 31.
       REM           
 CDAQZ PZE 11,,1     
       BCD 6SKIP TO 7, TAKE IDLE CYCLE, MOVE TO
       BCD 57 HOLE AND PRINT ON LINE 37.
       REM           
 CDARA PZE 11,,1     
       BCD 6SKIP TO 8, TAKE IDLE CYCLE, MOVE TO
       BCD 58 HOLE AND PRINT ON LINE 43.
       REM           
 CDARB PZE 11,,1     
       BCD 6SKIP TO 9, TAKE IDLE CYCLE, MOVE TO
       BCD 59 HOLE AND PRINT ON LINE 49.
       REM           
 CDARC PZE 11,,1     
       BCD 6SKIP TO 10, TAKE IDLE CYCLE, MOVE TO
       BCD 5 10 HOLE AND PRINT ON LINE 55
       REM           
 CDARD PZE 12,,1     
       BCD 6SELECTIVE SPACE. NO IDLE CYCLE, MOVE
       BCD 6TO 100 HOLE AND PRINT ON LINE 59.
       REM           
 CDARE PZE 12,,1     
       BCD 6SHORT SKIP TO 1. NO IDLE CYCLE, MOVE
       BCD 6 TO 1 HOLE AND PRINT ON LINE1.
       REM           
 CDARF PZE 12,,1     
       BCD 6SHORT SKIP TO 2. NO IDLE CYCLE, MOVE
       BCD 6 TO 2 HOLE AND PRINT ON LINE 7.
       REM           
 CDARG PZE 12,,1     
       BCD 6SHORT SKIP TO 3. NO IDLE CYCLE, MOVE
       BCD 6 TO 3 HOLE AND PRINT ON LINE 13.
       REM           
 CDARH PZE 12,,1     
       BCD 6SHORT SKIP TO 4. NO IDLE CYCLE, MOVE
       BCD 6 TO HOLE AND PRINT ON LINE 19.
       REM           
 CDARJ PZE 12,,1     
       BCD 6111111111111111111AAAAAAAAAAAAAAAAAA
       BCD 6JJJJJJJJJJJJJJJJJJSSSSSSSSSSSSSSSSSS
       REM           
 CDARK PZE 12,,1     
       BCD 6SUPPRESS SPACE. LAST LINE ON FLY 4 I
       BCD 6NCHES BACK. PRINT THIS ON LINE 1.
       REM           
 CDARL PZE 9,,1      
       BCD 6SELECTIVE SPACE. MOVE 1 SPACE AND PR
       BCD 3INT ONE LINE 8.
       REM           
 CDARM PZE 9,,1      
       BCD 6SELECTIVE SPACE. MOVE 2 SPACES AND P
       BCD 3RINT ON LINE 10.
       REM           
 CDARN PZE 9,,1      
       BCD 6SELECTIVE SPACE. MOVE 3 SPACES AND P
       BCD 3RINT ON LINE 13.
       REM           
 CDARP PZE 11,,1     
       BCD 6SELECTIVE SPACE + EXTRA SPACE. MOVE
       BCD 64 SPACES AND PRINT ON LINE 17.
       REM           
 CDARQ PZE 11,,1     
       BCD 6SELECTIVE SPACE + EXTRA SPACE. MOVE
       BCD 65 SPACES AND PRINT ON LINE 22.
       REM           
 CDARR PZE 11,,1     
       BCD 6SELECTIVE SPACE + EXTRA SPACE. MOVE
       BCD 66 SPACES AND PRINT ON LINE 28.
       REM           
 CDARS PZE 9,,1      
       BCD 6SELECTIVE SPACE. MOVE 7 SPACES AND P
       BCD 3RINT ON LINE 35.
       REM           
 CDART PZE 9,,1      
       BCD 6SUPPRESS SPACE. SHOULD PRINT 1 SPACE
       BCD 3 FROM LAST LINE.
       REM           
 CDARU PZE 11,,1     
       BCD 6SINGLE SPACE WITH EXTRA SPACE. SHOUL
       BCD 5D BE 1 SPACE FROM LAST LINE.
       REM           
 CDARV PZE 9,,1      
       BCD 6DOUBLE SPACE. SHOULD PRINT 2 SPACES
       BCD 3FROM LAST LINE.
       REM           
 CDARW PZE 12,,1     
       BCD 6SINGLE SPACE. SUPPRESS SPACE, EXTRA
       BCD 6SPCE. PRINT 1 SPACE FROM LAST LINE.
       REM           
 CDARX PZE 12,,1     
       BCD 6DOUBLE SPACE. SUPPRESS SPACE, EXTRA
       BCD 6SPACE. PRINT 2 SPACES FROM LAST LINE
       REM           
 CDARY PZE 9,,1      
       BCD 6S P R S   P C     H U D P I T O   H
       BCD 3  E Y N X   I E
       REM           
 CDARZ PZE 9,,1      
       BCD 6 U P E S S A E - S O L   R N   N T E
       BCD 3 V R   E T L N .
       REM           
 CDASA PZE 10,,1     
       BCD 6NON-PRINT HUB. SHOULD NOT SPACE OR P
       BCD 4PRINT THIS. NO GOOD.
       REM           
 CDASB PZE 7,,1      
       BCD 6PROGRAMMED CARRIAGE CONTROL TEST COM
       BCD 1PLETE.   
       REM           
 CDASC PZE 12,,1     
       BCD 6DOUBLE SPACE AND NON-PRINT. SHOULD N
       BCD 6OT SPACE OR PRINT THIS. NO GOOD.
       REM           
 CDZAD PZE 9,,1      
       BCD 6  NOW PERFORMING -9P01-, PART TWO,
       BCD 3ON CHANNEL
       REM           
 CDZAE PZE 8,,1      
       BCD 5 9P01 PART TWO, PASS COMPLETE
       BCD 3ON CHANNEL
       REM           
 CDZAF PZE 6,,1      
       BCD 6 9P01 PASS COMPLETE ON ALL CHANNELS.
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
       REM           
 BEGNB NZT SIZE      
       TRA SETRB     MORE THEN 4K.
       REM           
       AXT LASTA+4096-FRSTB,4 4K.
       CLA CATCH     
       STO LASTA,4   
       TIX *-1,4,1   
       REM           
       AXT 23,4      
       STO 24,4      
       TIX *-1,4,1   
       TRA 25        
       REM           
 SETRB AXT 32767-FRSTB+1,4 MORE THAN 4K.
       CLA CATCH     
       STO 0,4       
       TIX *-1,4,1   
       TRA SETRA     
       REM           
       REM           
       REM           
       REM           
       REM           
 FRSTB BSS 0         
       REM           
       REM           
       END BEGNB     
