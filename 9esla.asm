       709 EXTENDED FLOATING POINT SPECIAL FEATURE           9ESLA          
                      SECTION 1                             1-1-60
       REM
       REM
******************************************************************
*                                                                *
*                 B/M  580043       EC  298817                   *
*                                                                *
******************************************************************
       REM            
       REM            
******************************************************************
*                                                                *
*         ******   ******   ******   *******       *********     *
*         *        *        *           *              *         *
*         *        *        *           *              *         *
*         *        *        *           *              *         *
*         ******   ****     *           *              *         *
*              *   *        *           *              *         *
*              *   *        *           *              *         *
*              *   *        *           *      **      *         *
*         ******   ******   ******      *      **  *********     *
*                                                                *
******************************************************************
       REM            
       REM            
       REM            
*      TESTING -      
*          EST        EXTENDED STORE-0673   2.07.90
*          ELD        EXTENDED LOAD   0670   2.07.90
       REM            
       REM            
*                     PROGRAM SEQUENCE CONTROL
       REM            
*      WITH THE USE OF SENSE SWITCH 1 -
*          UP   -ROUTINE JUST COMPLETED IS REPEATED.
*          DOWN -PROGRAM WILL PROCEED TO NEXT TEST ROUTINE IN DEQ.
       REM            
* THE STL INST IS USED TO GIVE BEGINNING ADDRESSES OF EACH TEST ROUT.
* IND. ADDR. IS USED TO OBTAIN THE BEGINNING ADDR OF NEXT TEST ROUT.
       REM            
       REM            
       REM            
       REM            
       ORG 2          
REP    SWT 1          WITH SW 1 --
       TRA *+2        UP- PROCEED TO NEXT TEST.
       TRA **         DN- REPEAT SAME TEST.
       REM            
       REM OBTAIN ADDR OF NEXT TEST LOCATION
       REM FROM ADDR OF PREV LOCATION.
       CLA* *-1       NEXT ROUTINE ADDRESS
       STA *+1        
       TRA **         GO TO NEXT ROUTINE
       REM            
       REM            
       REM            
       REM            
*                    PART 1
       REM            
*      BEFORE PROCEEDING TO TEST ELD OR EST,
*      SINGLE ADDRESSING IS CHECKED FOR FUNCTION.
       REM            
*      IN THIS TEST-- 
*          THE ACC WILL CONTAIN A TXI INSTRUCTION.
*          THE MQ WILL CONTAIN ALTERNATE ONES.
*    THE ACC WILL BE STORED IN LOC ZERO. A CHECK IS MADE OF LOC ZERO
*TO SEE IF ACC WAS STORED THERE. IF NOT, ALL OF STORAGE IS SEARCHED.
*WHEN FOUND THE MACHINE HALTS ON A HTR INST WITH ERROR LOC IN XRA.
*IF NOT FOUND, THE MACHINE ALSO HALTS ON A HTR INST.
       REM            
*    IF ACC WAS STORED SUCCESSFULLY, LOCATION 00001 IS CHECKED
*TO SEE IF MQ WAS STORED THERE. MACHINE WILL HALT ON ERROR.
       REM            
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 - ERROR IN STORING ACC
*          LITE 2 - MQ STORED IN ERROR.
       REM            
       REM            
       ORG 24         
GENE   STL 4           FOR AUTO RESTART
       NOP GUS        LOC OF NEXT ROUTINE
       SLF            
       LDQ GUS-1      ALTERNATE ONES
       CLA GUS-2      STR-FOR RESTART
       SSP            BECOMES TXI
       STO            
       SWT 2          TO CHECK OR NOT
       TRA *+2        YES
       TRA REP        NO, PROCEED
       REM            
       CAS            CHECK
       TRA *+2        
       TRA ANUNZ      OK, SEE IF MQ WAS STORED
       SLN 1          SIGNAL ERR IN STO
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
*      ASSUME THAT THE ACC HAS NOT BEEN CHANGED.
       AXT -1,1       SEARCH ALL OF CORE FOR
       REM            THE MISSING WORD
       CAS ,1         
       TRA *+2        
       TRA *+3        GOT IT
       TIX *-3,1,1    TRY NEXT LOC.
       HTR REP        FAILED TO EXECUTE STO
       REM            SW 1 DOWN AND START TO TRY AGAIN.
*20                   
       PXA ,1         
       PAC ,1         SET TRUE LOC. IN XRA
       CLM            
       HTR REP        WORD WAS STORED IN WRONG PLACE.
       REM            XRA HAS THE LOC. SHOULD HAVE
       REM            STORED AT ZERO. SW 1 DOWN
       REM            AND START TO TRY AGAIN.
       REM            
ANUNZ  CLA GUS-1      SEE IF MQ WAS STORED AT 1
       REM            
       CAS 1          
       TRA *+2        
       TRA *+2        
       TRA GENE+31    OK, PROCEED.
       REM            
       SLN 2          MQ WAS STORED ALSO, SHOULD NOT
       REM            HAVE BEEN ON STO. SW 1 DOWN
       REM            AND START TO TRY AGAIN.
*30                   
       HTR *+1        
       TRA REP        PROCEED OR
       REM            REPEAT
       REM            
       STR GENE       CONSTANTS.
       OCT -12525252525
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
*      CHECKING SINGLE ADDRESS CONTROL LINES.
       REM            
*      IN THIS TEST-- 
*          THE ACC WILL BE ALL ZEROS.
*          THE MQ WILL CONTAIN THE ORIGNAL CONT OR XRA.
       REM            
*    ALL LOCATIONS IN STORAGE WILL BE ADDRESSED FOR STO EXCEPT
*THE AREA OCCUPIED BY PROGRAM. THE STO INST WILL BE ALTERNATED
*SO THAT IF THE MQ IS BEING STORED ALL LOCATIONS WILL NOT BE ZERO
*WHEN STORAGE IS CHECKED.
       REM            
*      SENSE LITE INDICATION-
*          LITE 3 - ERROR IN STO INST.
       REM            
       REM            
GUS    STL 4          FOR AUTO REPEAT.
       NOP ESTSC      LOCATION OF NEXT TEST.
       SLF            
       AXT 32767-LAST,3 FAILL XRA AND XRB
       PXD ,1         
       XCA            NOT ZERO TO MQ
       PXD            CLEAR ACC
       STO 1,1        STORE ZERO ALTERNATLY THROUGH
       STO ,1         STORAGE SO WE CAN CHECK ON MQ.
       TIX *-2,1,2    PROCEED UNTIL ALL LOC ARE FILLED
*10                   
       SWT 2          
       TRA *+2        CHECK
       TRA GUS+21     DONT CHECK IF SW2 IS DOWN.
       CAL ,2         CHECK SIGN BIT ALSO.
       TNZ *+3        WRONG IF NOT ZERO.
       TIX *-2,2,1    CHECK ALL LOCATIONS
       TRA GUS+21     OK, PROCEED
       REM            
       SLN 3          SIGNAL STO ERROR
       SXA *+1,2      
       AXC **,1       GET TRUE ERR LOC TO XRA.
*20                   
       HTR *-5        THE WORD AT THE LOC SHOWN
*      IN XRA WAS NOT ZERO AFTER ZERO WAS STORED BY STO.
*      THE WORD IN ERROR IS IN THE ACC. IF ACC IS SAME AS MQ,
*      THEN STO STORED THE MQ ALSO.
*      PRESS START TO CONTINUE SEARCH AT NEXT LOCATION.
       REM            
       REM            
       CLA GUS-2      
       SLW            RESTORE ZERO IN CASE.
       TRA REP        GO ON
       REM            
       REM            
*                     PART 2
       REM            
       REM            
       REM            
*****************BEGIN CHECKING EST-   EXTENDED STORE -0673************
       REM            
       REM            
*EST EXECUTION IS ON SYSTEMS 2.07.90.
       REM
       REM
       REM
       REM        
*      CLOSED ROUTINE FOR SCOPING EST.
       REM            
       REM            
ESTSC  STL 4          FOR AUTO RESTART
       NOP MY         LOC OF NEXT ROUTINE
       REM            
       CLA YOUR      
       LDQ CHOIS      
       EST 32766      THIS IS IT
       REM            
       SWT 1          WANT A CLOSED LOOP
       TRA MY         UN- NO-GO ON.
       TRA *-3        DN- YES-REPEAT.
       REM            
       REM            
YOUR   OCT +0         TEMP STOR FOR THIS
CHOIS  OCT +0            ROUTINE ONLY.
       REM
       REM
       REM
       REM        
*      CHECKING EST FOR EXECUTION.
       REM            
*      STO INST IS ASSUMED FUNCTIONAL.
*      EST IS ASSUMED TO EXECUTE WITHOUT HANGING-UP.
***THE SEQUENTIAL ADDRESS OF THE EST INST WILL BE SET IN THE ACC
*AND MQ. A CHECK WILL BE MADE TO SEE IF BOTH WORDS WERE STORED
*CORRECTLY. IF EITHER WORD WAS NOT STORED CORRECTLY, STORAGE IS
*SEARCHED AND ERROR LOCATION PUT IN XRA IN TRUE FROM. A HTR
*TO -REP- IS GIVEN.   
***MQ IS CHECKED ONLY IF ACC WAS OK.
***IF WORDS CANNOT BE FOUND, THE MACHINE WILL HALT ON HPR 77777.
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 -ERROR IN STORING THE ACC.
*          LITE 2 -ERROR IN STORING THE MQ.
       REM            
       REM            
MY     STL 4          FOR AUTO REPEAT
       NOP MAMA       LOC FOR NEXT ROUTINE
       SLF            
       STZ LAST+1     CLEAR
       STZ LAST+2     RECEIVERS
       AXT LAST+1,1   ACC ADDRESS, IN XRA
       PXD ,1         TO ACC DECREMENT.
       XCA            
       TXI *+1,1,1    MQ ADDRESS
       PXD ,1         
*10                   
       XCA            PROPER ADDRESSES IN PROPER DECS.
       EST LAST+1     OK, TRY IT
       SWT 2          
       TRA *+2        
       TRA *+REP      DONT CHECK IF 2 IS DOWN
       CAS LAST+1     CHECK ACC WORD
       TRA *+2        
       TRA MY+29      OK, NOW CHECK MQ WORD
       SLN 1          SIGNAL ERR IN ACC WORD
       AXT 32767,2    PREPARE TO SEARCH STORAGE
*20                   
       CAS ,2         DIVE, DIVE.
       TXI *+2        
       TXI *+4        FOUND IT, GET LOC AND STOP
       REM            
       TIX *-3,1,1    NO LUCK, TRY NEXT LOC.
       HPR 32767      ACC WAS NOT CORRECTLY STORED
*      ANYWHERE IN STORAGE. CHECK THAT WORD IN ACC HAS NOT
*      BEEN CHANGED BY EST. THE ACC DECR SHOULD HAVE THE
*      ORIGINAL VALUE PLACED IN IT AT THE BEGINNING OF ROUTINE.
*      THE ACC SHOULD CONTAIN NO OTHER BITS.
       REM            
       REM            SW1 DOWN AND PRESS START
       REM            TO TRY AGAIN
       TTR REP        GO
       SXD *-4,2      GET TRUE LOC.
       LDC *-5,1      TO XRA
       HTR REP        ACC WAS STORED AT LOC SHOWN
*      IN XRA. THE CORRECT LOCATION IS IN DECR OF ACC.
*      SW 1 DOWN AND PRESS START TO TRY AGAIN.
       REM            
       REM            
       REM            
       XCA            ACC OK, TRY MQ.
*30                   
       CAS LAST+2     MQ WORD HAS BEEN PUT INTO THE ACC
       TRA *+2        
       TRA REP        MQ OK, GO ON
       SLN 2          SIGNAL MQ ERROR
       AXT 32767,2    
       CAS ,2         HAVE AT IT
       TXI *+2        SEARCH
       TXI *+4        
       TIX *-3,2,1    SEATCH ALL LOC. EXCEPT ZERO
       HTR 32767      CANT FIND WORD THAT SHOULD HAVE
       REM            BEEN STORED FROM MQ
       REM            
*                     SW 1 DOWN AND PRESS START TO TRY AGAIN.
       REM            
*      CHECK THAT WORD IN ACC HAS NOT BEEN CHANGED BY EST.
*      THE MQ AND ACC HAVE BEEN EXCHANGED DURING TEST.
*      DECR OF ACC SHOULD HAVE THE ORIGINAL VALUE OF SYMBOLIC
*      LOCATION  -LAST+2-  . THE ACC SHOULD CONTAIN NO OTHER BITS.
*40                   
       TTR REP        
       REM            
       REM            
       REM            
       SXA *+1,2      TRUE LOC OF XRA
       AXC **,1       
       HTR REP        THE WORD THAT WAS IN MQ ON EST WAS
*      STORED AT LOC SHOWN IN XRA. CORRECT LOCATION IN DECR
*      OF THE ACC. SW 1 DOWN AND PRESS START TO TRY AGAIN.
       REM
       REM
       REM
       REM        
*      CHECKING EST FOR STORING ALL BITS FROM AC AND MQ.
*      ASSUME THE EST WILL STORE AT DESIGNATED ADDRESSES,
*      AND WILL NOT ALTER THE CONTENTS OF ACC OR MQ.
*      ONLY ACC S-17 AND MQ S-35 IS STORED BY EST.
       REM            
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 - ERROR IN STORING THE ACC.
*          LITE 2 - ERROR IN STORING THE MQ.
       REM            
       REM            
MAMA   STL 4          FOR AUTO REPEAT
       NOP DONE       LOC OF NEXT ROUTINE.
       SLF            
       STZ LAST+1     CLEAR
       STZ LAST+2     RECEIVERS.
       PXD            CLEAR ACC
       COM            ALL ONES
       LGR 36         TO MQ S,1-35
       PXD            CLEAR ACC
       COM            ALL ONES, Q-35.
*10                   
       ARS 2          LOSE Q,P
       LLS            ACC SIGN MINUS TOO.
       EST LAST+1     
       SWT 2          
       TRA *+2        
       TRA REP        DONT CHECK IF 2 IS DOWN
       REM            
       CAS LAST+1     CHECK ACC
       TRA *+2        
       TRA *+3        OK, CHECK MQ
       SLN 1          SIGNAL ACC ERR
*20                   
       HTR REP        ACC WORD NOT STORED
*      CORRECTLY. ONLY ACC S-17 SHOULD HAVE BEEN STORED.
*      ACC 18-35 IS CLEARED DURING EST OPERATION.
*      SW 1 DOWN AND PRESS START TO TRY AGAIN.
       REM
       REM
       REM
       REM        
       XCA            MQ TO ACC  *******
       CAS LAST+2                      *
       TRA *+2                         *
       TRA REP        OK, PROCEED      *
       REM            
       SLN 2          SIGNAL MQ ERR
       HTR REP        MQ STORED INCORRECTLY.
*      FOR TEST CHECK, MQ AND ACC HAVE BEEN EXCHANGED.
*      MQ SHOULD HAVE STORED ALL ONES S,1-35.
       REM            
*      SW 1 DOWN AND PRESS START TO TRY AGAIN.
       REM            
*      CHECK EST FOR CLEARING ACC Q AND P.
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 - ERROR IN STORING ACC.
*          LITE 2 - ERROR IN STORING MQ.
*          LITE 3 - ERROR IN ACC Q,P.
       REM
       REM
       REM
       REM        
DONE   STL 4          FOR AUTO REPEAT
       NOP TOLE       LOC OF NEXT ROUTINE
       SLF            
       PXD            CLEAR ACC
       XCA            CLEAR MQ
       PXD            CLEAR AGAIN
       COM            ALL ONES
       SLW LAST+1     TO STORAGE
       SLW LAST+2        LOCATIONS.
       ARS 2          
*10                   
       COM            ONES TO Q AND P ONLY.
       EST LAST+1     
       SWT 2          
       TRA *+2        
       TRA REP        DON'T CHECK IF 2 IS DOWN
       TZE DONE1      Q AND P SHOULD BE CLEARED.
       SLN 3          INIDCATE ERROR IN ACC QP.
       HTR REP        WITH SW 1 DN- PRESS
       REM RESET AND START TO TRY AGAIN.
       REM            
       REM            
*20                   
DONE1  CAL LAST+1     
       ARS 18         DROP 18-35
       TZE *+3        
       SLN 1          SIGNAL ACC ERR
       HTR REP        STOR S-17 SHOULD HAVE
       REM BEEN CLEARED BY EST. ERR BITS IN
       REM ACC 18-35. 
       REM SW 1 DN-PRESS START TO TRY AGAIN
       REM            
       REM            
       CAL LAST+2     CHECK SIGN TOO.
       TZE REP        OK, PROCEED.
       SLN 2          SIGNAL MQ ERROR.
       HTR REP        STOR S-35 SHOULD HAVE
       REM BEEN CLEARED FROM MQ ON EST
       REM ERROR BITS IN ACC.
       REM SW1 DN-PRESS START TO TRY AGAIN.
       REM            
*      CHECKING EST WITH INDEXING.
       REM            
****AS BEFORE, ON ERROR THE CORE IS SEARCHED UNTIL WORDS ARE FOUND.
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 - ERROR IN STORING ACC.
*          LITE 2 - ERROR IN STORING MQ.
       REM
       REM
       REM
       REM        
TOLE   STL 4          FOR AUTO REPEAT
       NOP ME         LOC OF NEXT ROUTINE.
       SLF            
       STZ LAST+1     CLEAR RECIEVERS
       STZ LAST+2     
       AXT LAST+1,1   ADDRESS TO ACC DEC
       PXD ,1         
       XCA            
       TXI *+1,1,1    +1 YIELDS
       PXD ,1         MQ ADDRESS
*10                   
       XCA            RIGHT ADDS TO RIGHT DECS.
       AXT -3,1       XRA GETS 77775 OCTLA
       EST LAST-2,1   INDEX BY COLS 16 AND 17
       REM            SHOULD ADD 3 TO ADDR.
       SWT 2          
       TRA *+2        
       TRA REP        DONT CHECK IF 2 IS DOWN.
       REM            
       CAS LAST+1     CHECK ACC
       TRA *+2        
       TRA TOLE+31    OK, CHECK MQ
       SLN 1          SIGNAL ACC ERROR.
*20                   
       AXT 0,2        PREPARE TO SEARCH
       CAS ,2         SEARCH CORE 00000 TO 77777
       TRA *+2        
       TXI *+5        GOT IT.
       TXI *+1,2,-1   NO GOT--STOP TO NEXT ADDR.
       TXH *-4,2,0    SEARCH ALL LOCATIONS.
       REM            
       HTR 32767      WORD NOT FOUND THAT SHOULD
       TTR REP        HAVE BEEN STORED FROM MQ.
*      CHECK TO SEE IF ACC HAS BEEN ALTERED.
*      WITH SW 1 DOWN, PRESS START TO TRY AGAIN.
       REM            
       SXA *+1,2      
       AXC **,1       TRUE LOC TO XRA
*30                   
       HTR REP        ACC WAS STORED AT LOCATION
*      SHOWN IN XRA. CORRECT LOCATION IN DECREMTN
*      OF ACC. WITH SW 1 DN, PRESS START TO TRY AGAIN.
       REM
       REM
       REM
       REM        
       XCA            IF ACC OK, CHECK MQ.-******
       CAS LAST+2                               *
       TRA *+2                                  *
       TRA REP        OK, PROCEED               *
       SLN 2          SIGNAL MQ ERROR           *
       AXT 0,2                                  *
       CAS ,2         SEARCH                    *
       TRA *+2                                  *
       TXI *+5        GOT IT, GET LOC IN XRA    *
*10                                             *
       TXI *+1,2,-1   SEARCH ALL LOCATIONS      *
       TXH *-4,2,0    EVEN UNTO THE LAST.       *
       HPR 32767      WORD NOT FOUND THAT SHOULD
       TTR REP        HAVE BEEN STORED FROM MQ.
*      CHECK ACC TO SEE IF WORD FROM MQ HAS BEEN ALTERD.
       REM            
*      DOWN SW 1 DOWN, PRESS START TO TRY AGAIN.
       REM                                       *
       REM                                       *
       REM                                       *
       SXA *+1,2                                 *
       AXC **,1       TRUE LOC TO XRA            *
       HTR REP        MQ WAS STORED AT LOCATION
*      SHOWN IN XRA. CORRECT LOCATION IN DECREMENT
*      OF ACC. WITH SW 1 DN, PRESS START TO TRY AGAIN.
       REM
       REM
       REM
       REM        
*      CHECKING EST WITH INDIRECT ADDRESSING.
       REM            
*AS BEFORE, ON ERROR THE CORE IS SEARCHED UNTIL WORDS ARE FOUND.
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 - ERROR IN STORING ACC.
*          LITE 2 - ERROR IN STORING MQ.
       REM            
       REM            
       REM            
ME     STL 4          AUTO REPEAT
       NOP WHEN       LOC OF NEXT ROUTINE
       SLF            
       STZ LAST+1     CLEAR RECIEVERS
       STZ LAST+2     
       AXT LAST+1,1   
       PXD ,1         GENERATE WORDS TO BE STORED
       XCA            
       TXI *+1,1,1    
       PXD ,1         
*10                   
       XCA            ACC AND MQ DECREMENTS
       TRA *+2          WITH PROPER LOCATIONS.
       NOP LAST+1     ADDRESS FOR EST WITH IA
       EST* *-1       EST IN*LAST+1*
       SWT 2          
       TRA REP        DONE CHECK IF 2 DOWN
       CAS LAST+1     CHECK ACC WORD.
       TRA *+2        
       TRA ME+32      OK, CHECK MQ
*20                   
       SLN 1          SIGNAL ACC ERROR
       AXT 0,2        
       CAS 0,2        SEARCH STORAGE FROM 
       TRA *+2                00000 TO 77777.
       TXI *+5        
       TXI *+1,2,-1   
       TXH *-4,2,0    SEARCH ALL LOCATIONS.
       HPR 32767      CANT FINDF WORD THAT SHOULD
       TTR REP        HAVE BEEN STORED FROM ACC.
       REM SWT 1 DN- PUSH START TO TRY AGAIN.
       REM            
       REM            
       SXD *-5,2      
*30                   
       LDC *-6,1      TRUE LOC TO XRA
       HTR REP        ACC STOR AT LOC SHOWN
*      IN XRA. CORR LOC IN DECREMTN OF ACC.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       XCA            IF ACC OK, CHECK MQ.
       CAS LAST+2     
       TRA *+2        
       TRA REP        OK, PROCEED
       SLN 2          SIGNAL MQ ERROR.
       AXT 0,2        
       CAS ,2         SEARCH
       TRA *+2        
*40                   
       TXI *+5        
       TXI *+1,2,-1   
       TXH *-4,2,0    SEARCH ALL LOCS.
       HPR 32767      CANT FIND WORH THAT SHOULD
       TTR REP        HAVE BEEN STORED FROM MQ.
       REM SW 1 DN- PUSH START TO TRY AGAIN.
       REM            
       REM            
       SXD *-5,2      
       LDC *-6,1      TRUE LOC TO XRA
       HTR REP        MQ STORED AT LOCA SHOWN
*      IN XRA. CORR LOC IN DECREMTN OF MQ.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       REM            
*      CHECKING EST FOR ADDRESSING TO ALL OF STORAGE.
       REM            
*ALL STORED LOCATIONS WILL BE CHECKED.
*STORING WILL INCLUDE LOCATION 77777 AND 00000.
*      ACC STORED IN ODD LOCATIONS.
*      MQ STORED IN EVEN LOCATIONS.
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 2 - ERROR IN STORING MQ AT LOC ZERO.
*          LITE 3 -  ERROR IN STORING ACC OR MQ.
       REM            
       REM            
WHEN   STL 4          FOR AUTO RESTART.
       NOP ELDSC      
       SLF            
       AXT 32767-LAST,6 GET NO. OF REMAINING LOCS.
       PXA ,6         
       LBT            START WITH ODD ADDRESS
       TXI *+1,6,1    IF EVEN, MAKE ODD
       PXA ,6         IF OK, OK
       PAC ,1         TRUE LOC TO XRA
       PXD 0,1        GENERATE ADDRESSES.
*10                   
       XCA            
       TXI *+1,1,1    
       PXA ,1         
       XCA            ACC ODD, MQ EVEN
       EST 0,2        FILL CORE WITH ADDRESSES
       TXI *+1,1,1    NEXT LOC.   AT ADDRESSES.
       TIX *-7,2,2    STORE AROUND THE CORNER.
       REM            
       SWT 2          
       TRA *+2        
       TRA REP        DONT CHECK IF 2 IS DOWN.
*20                   
       CAL            CHECK LOC ZERO FIRST
       TZE *+3        SHOULD BE ZERO, INCL SIGN.
       SLN 2          ERROR IN MQ STORE ON EST
       HTR REP        LOC ZERO WAS NOT MADE ZERO,
       REM WHEN EST STORED AROUND THE CORNER.
       REM SW 1 DN- PUSH START TO TRY AGAIN.
       REM            
       REM            
       CLA GUS-2      RESTORE
       SLW            POST RESTART
       STZ REP-1      AT LOC 1.
       REM            
       REM            
       REM            
       PXA ,4         NEW, SEARCH REST OF CORE
       PAC ,1         FIRST LOC TRUE
EXTRA  PXD 0,1        TO ACC
*30                   
       CAS ,4         CHECK EACH LOC
       TRA *+2        
       TRA *+2        OK
       TRA XTRA       
       TXI *+1,1,1    GET NEXT LOC IN XRA
       TNX REP,4,1    TO STOP CKING AT ZERO.
       CLS REP-1      ALTERNATE THE
       STO REP-1        SIGN CONDITION.
       TPL EXTRA      ALTERNATLY CHECKING
*40                   
       PXA 0,1        THE CONT STORED BY
       TRA EXTRA+1    ACC AND MQ
XTRA   SLN 3          ACC OR MQ ERROR
       XCA            PUT CORRECT CONTENTS TO MQ
       CLA ,4         ERROR WORD TO ACC
       HTR REP        THE LOCATION SHOWN
*      IN XRA WAS NOT STORED CORRECTLY ON EST.
*      THE ERROR WORD IS IN THE ACCUMULATOR.
*      THE CORRECT WORD IS IN THE MQ.
*      IF WORDS IN-  ADDR- MQ STORING ERROR.
*                    DECR- ACC STORING ERROR.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       REM            
       REM            
****************BEGIN CHECKING ELD-   EXTENDED LOAD 0670**********
       REM
       REM
       REM
       REM        
*      CLOED LOOP FOR SCOPING ELD
       REM            
       REM            
ELDSC  STL 4          FOR AUTO REPEAT
       NOP I          
       PXD            CLEAR ACC
       LRS 35         CLEAR MQ
       ELD *+4        SPECIAL DUMP.
       REM            
       SWT 1          WANT A CLOSED LOOP
       TRA I          UP- NO -GO ON.
       TRA *-3        DN- YES- REPEAT.
       REM            
       OCT +0         ANY DATA DESIRED CAN BE
       OCT +0           STORED FOR SCOPING.
       REM            
       REM            
*      CHECKING ELD TO LAOD FROM SEQUENTIAL LOCATIONS.
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 - ERROR IN LOADING ACC.
*          LITE 2 - ERROR IN LOADING MQ.
       REM            
       REM            
       REM            
I      STL 4          FOR AUTO REPEAT
       NOP WAS        
       SLF            
       AXT LAST,1     MAKE SURE WE HAVE
       PXD ,1         ADDRESS AT ADDRESS.
       SLW LAST       ACC NORM GETS DECR ON ELD.
       TXI *+1,1,1    WHEN DOING EXTENDED FL. PT.
       PXA ,1         IN ADDRESS FIELD FOR
       SLW LAST+1     MQ WORD.
       PXD            CLEAR ACC
*10                   
       LRS 35         CLEAR MQ
       ELD LAST       LOAD ACC DECR, MQ ADDR...
       SWT 2          
       TRA *+2        
       TRA REP        DONT TEST IF 2 DOWN
       CAS LAST       CHECK ACC
       TRA *+2        
       TRA *+3        OK, CHECK MQ
       SLN 1          SIGNAL ACC WRONG
       HTR REP        ERROR IN LOADING ACC ON
*      ELD. SHOULD HAVE LOC -LAST- STORED IN DECREMENT.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       REM            
*20                   
       XCA            IF ACC OK, CHECK MQ.******
       CAS LAST+1                              *
       TRA *+2                                 *
       TRA REP        OK, PROCEED              *
       SLN 2          SIGNAL MQ ERROR          *
       HTR REP        ERROR IN LOADING MQ ON        
*      ELD. SHOULD HAVE LOC -LAST+1- IN ADDRESS.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       REM            
*      CHECKING ELD TO LOAD ALL 36 BITS.
       REM            
*      SENSE LITES INDICATIONS-
*          LITE 1 - ERROR IN LOADING ACC.
*          LITE 2 - ERROR IN LOADING MQ.
       REM            
       REM            
       REM            
WAS    STL 4          FOR AUTO RESTART.
       NOP IN         
       SLF            LIGHTS OUT
       PXD            CLEAR ACC
       COM            ALL ONES
       SLW LAST       FILL S,1-35
       SLW LAST+1     
       PXD            CLEAR ACC
       LRS 35         CLEAR MQ
       ELD LAST       LOAD ALL ONES- MQ AND ACC.
*10                   
       SWT 2          
       TRA *+2        
       TRA REP        DONT CHECK IF 2 DOWN.
       REM            
       CAS LAST       CHECK ACC
       TRA *+2        
       TRA *+3        OK, CHECK MQ.
       SLN 1          SIGNAL ACC ERROR
       HTR REP        ERROR IN LOADING ALL ONES
       REM TO ACC ON ELD.
*      WITH SW 1 DOWN- PUSH START AND TRY AGIAN.
       REM            
       REM            
       XCA            IF ACC OK, CHECK MQ********
       CAS LAST+1     SHOULD HAVE ALL ONES.     *
*20                   
       TRA *+2        NG                        *
       TRA REP        OK, PROCEED               *
       SLN 2          SIGNAL MQ ERROR           *
       HTR REP        ERROR IN LOADING ALL ONES
       REM TO MQ ON ELD.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       REM            
*      CHECKING ELD WITH INDEXING
       REM            
       REM SIGNS UNLIKE ACC S- S+
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 - ERROR IN LOADING ACC.
*          LITE 2 - ERROR IN LOADING MQ.
       REM            
       REM            
       REM            
IN     STL 4          FOR AUTO RESTART
       NOP KNEE       
       SLF            
       AXT LAST,1     
       PXD ,1         GENERATE ACC WORD.
       SSM            ACC WORD MINUS
       STO LAST       
       PXD            CLEAR ACC
       COM            ALL ONES, SIGN PLUS
       STO LAST+1     MQ WORD- ONES 1-35, S+.
*10                   
       AXT -3,1       XRA GETS 77775. INDEX BY
       REM COLS 16 AND 17 TO ADD 3.
       ELD LAST-3,1   LOAD FROM -LAST-.
       SWT 2          
       TRA *+2        
       TRA REP        DONT CHECK IF 2 IS DOWN
       CAS LAST       CHECK ACC
       TRA *+2        
       TRA *+3        OK, CHECK MQ
       REM            
       SLN 1          SIGNAL ACC ERR
       HTR REP        ERROR IN LOADING ACC ON
*      ELD INDEXED. SHOULD HAVE LOC -LAST- STORED IN DECR.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
*20                   
       REM            
       XCA            IF AC OK, CHECK MQ.******
       CAS LAST+1                             *
       TRA *+2        
       TRA REP        OK, PROCEED             *
       SLN 2          SIGNASL MQ ERROR        *
       HTR REP        ERROR IN LOADING ONES TO
       REM MQ 1-35 ON ELD.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       REM            
*      CHECKING ELD WITH INDIRECT ADDRESSING.
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 - ERROR IN LOADING ACC.
*          LITE 2 - ERROR IN LOADING MQ.
       REM            
       REM            
KNEE   STL 4          FOR AUTO REPEAT.
       NOP PANTS      
       SLF            
       PXD            CLEAR ACC
       STO LAST       ACC WORD ZERO
       COM            
       SLW LAST+1     MQ WORD ALL ONES.
       TRA *+2        
       NOP LAST       
       ELD* *-1       LOAD FROM -LAST-
*10                   
       SWT 2          
       TRA *+2        
       TRA REP        DONT CHECK IF 2 IS DOWN
       TNZ *+2        SHOULD BE ZERO
       TPL *+3        SHOULD BE PLUS
       SLN 1          SIGNAL ACC ERROR.
       HTR REP        ERROR IN LOADING ALL
       REM ZEROSS TO ACC ON ELD IA.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       REM            
       XCA            IF ACC OK, CHECK MQ.********
       CAS LAST+1     SHOULD HAVE ALL ONES       *
       TRA *+2        
*20                   
       TRA REP        OK, PROCEED.               *
       SLN 2          SIGNAL MQ ERROR            *
       HTR REP        ERROR IN LOADING ALL ONES
       REM TO MQ ON ELD IA.
*      WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       REM            
       REM            
*      CHECKING ELD FOR LOADING FROM ALL UNUSED PORTIONS OF STOR.
       REM            
*      SENSE LITE INDICATIONS-
*          LITE 1 - ERROR IN LOADING ACC.
*          LITE 2 - ERROR IN LOADING MQ.
       REM            
       REM            
PANTS  STL 4          FOR AUTO RESTART
       NOP GET        
       SLF            
       AXT 32767-LAST,6 LOAD XRB AND XRC.
       PXA ,2         GENERATE ADDRESSES.
       PAC ,1         GET TRUE FORM
       PXA ,1         FIRST ADDRESS
       STO 0,2        FILLING UP UNUSED STOR.
       REM            LOC ADDR IN WORD ADDR.
       ACL PANTS+29   ADD 1 FOR NEXT LOC
       TIX *-2,2,1    STEP XRB TO NEXT LOC
*10                   
       ELD 0,4        NOW RD BACK BYT ELD AND CK.
       SWT 2          THAT ELD GETS CORRECT WORDS.
       TRA *+2        
       TRA PANTS+24   DONT CHECK IF 2 IS DOWN
       CAS ,4         CHECK ACC
       TRA *+2        ERR
       TRA *+3        OK, CHECK MQ
       SLN 1          SIGNAL ACC ERROR.
       HTR REP        ERROR IN LOADING ADDR
*      TO ACC ON ELD. CORR ADDR IN XR.
*                WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       TXI *+1,1,1    STEP TO MQ ADDRESS
*20                   
       TNX REP,4,1    NEXT LOC, OR FINISHED
       REM            
       XCA            **CHECK MQ
       CAS ,4         *
       TRA *+2        *
       TXI *+3,1,1    *    OK, PROCEED
       SLN 2          *   SIGNAL MQ ERROR.
       HTR REP         ERROR IN LOADING ADDR
*      TO MQ ON ELD. CORR ADDR IN XRA.
*                 WITH SW 1 DOWN- PUSH START TO TRY AGAIN.
       REM            
       TIX PANTS+10,4,1 NEXT LOC.
       TRA REP        OK, PROCEED
       OCT 1          
       REM            
       REM            
*******************PROGRAM COMPLETE AND STOP ROUTINE***************
       REM            
       REM REPEAT PROGRAM IF SW 6 DOWN
       REM            
GET    STL 4          FORCE OF HABIT.
       NOP LOST       
       REM            
       SWT 6          
       TRA *+2        FINISHED IF SW 6 IS UP
       TRA LOST       REPEAT PROG. IF 6 IS DOWN
       REM            
       RCDA           PUSH
       RCHA *+3         LOAD
       LCHA               CARDS
       TTR 1                BUTTON.
       IOCT 0,,3      
       REM            
*      REPEAT PROGRAM AFTER PROG COMPLETE SIGNAL GIVEN.
LOST   STL 4          
       NOP GENE       
       TOV *+1        SHOULD BE OFF, BUT MAKE SURE
       PXD            CLEAR
       COM            ALL ONES
       ALS 1          ACC OV TURNED ON AND MQ
       LRS 22         LOADED TO SIGNAL PASS COMP
       SLN 4          SAME SPEACH.
       SUB GET-1      MINUS ONE
       TPL *-1        DELAY FOR VISUAL SIGNALS.
*10                   
       TOV *+1        TURN OFF
       PXD            CLEAR AC
       XCA            AND
       PXD              MQ
       SLF            LIGHTS OUT.
       REM            
       REM            
       SWT 6          STILL DOWN
       TRA GET+5      CHANGED YOU MIND.
       LXA PSCTR,1    STEP PASS
       TXI *+1,1,1        COUNTER.
       SXA PSCTR,1    
       REM            
*      PRINT ON EVERY 100 PASSES.
       TXL BEGIN,1,99 SIGNAL FOR 100 PASSES.
       REM            
       REM            
*      ADJUSTING THE CONTROL FOR PRINTING 100 PASSES COMPLETE.
       AXT PI2,1      TO ADJUST THE I/O
       SXA CTWD,1         COMMAND WORD.
       STZ PSCTR      CLEAR PASS CTR ON
       TRA PRNT       EACH 100 PASSES.
       REM            
       REM            
BEGIN  CLA *+3        INITIALIZEING
       STO            LOCATION ZERO.
       TRA *+2        
       TRA GENE       
       CLA *+1        ALTERING THE TRA INST
       NOP            TO A NOP AFTER
       STO *-4          INITIAL PASS.
       WPRA           SPACE PRINTER.
       REM            
       REM            
       REM            
PRNT   SWT 3          WANT TO PRINT...
       TRA *+2        UP  - YES - PRINT.
       TRA BEGIN      DN  -NO -START PROGRAM
       REM                AFTER INITIALIZING..
       REM            
       WPRA           
       RCHA CTWD      
       TCOA *         
       REM            
       TRA BEGIN      TO INITIALIZE
       HTR            
CTWD   IOCD PI1,0,24  
PSCTR  OCT +0         
       REM            
       REM            
*      9EFP SECTION 1-  100 PASSES COMPLETE.
PI2    OCT 010010000000   9 ROW LEFT
       OCT 000000000000   9 ROW RIGHT
       OCT 000000000000   8 L
       OCT 010000000000   8 R
       OCT 001000001000   7 L
       OCT 400000000000   7 R
       OCT 002004000002   6 L
       OCT 000000000000   6 R
       OCT 004102000040   5 L
       OCT 120000000000   5 R
       OCT 000000000001   4 L
       OCT 000000000000   4 R
       OCT 000060000004   3 L
       OCT 250000000000   3 R
       OCT 000200000320   2 L
       OCT 000000000000   2 R
       OCT 000000420400   1 L
       OCT 000000000000   1 R
       OCT 000220014320   0 L
       OCT 040000000000   0 R
       OCT 001006201003   11 L
       OCT 600000000000   11 R
       OCT 006150000444   12 L
       OCT 130000000000   12 R
       NOP            
       NOP            
LAST   HTR            
       REM            
*      9EFP SECTION 1, EXTENDED PRECISION FLOATING POINT TEST BEGINS.
PI1    OCT 010010000011   9 ROW LEFT
       OCT 200202000200   9 ROW RIGHT
       OCT 000000200000   8 L
       OCT 000000000020   8 R
       OCT 001000010020   7 L
       OCT 000050000400   7 R
       OCT 002004000000   6 L
       OCT 112004000000   6 R
       OCT 004102023204   5 L
       OCT 040101041100   5 R
       OCT 000000000500   4 L
       OCT 000000000000   4 R
       OCT 000060204002   3 L
       OCT 004400510020   3 R
       OCT 000200000000   2 L
       OCT 400000022040   2 R
       OCT 000000400000   1 L
       OCT 001000000000   1 R
       OCT 000220214000   0 L
       OCT 400400530040   0 R
       OCT 001006001030   11 L
       OCT 146115000100   11 R
       OCT 006150022707   12 L
       OCT 211242043620   12 R
       REM            
       END BEGIN      

