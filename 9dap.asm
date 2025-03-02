       REM ASSEMBLY OF 9AP1        THE TAPE WRITTING ROUTINE            9AP1 001
                                             10 OCTOBER 1958            9AP1 002
       ORG  -1000                                                       9AP1 003
 SKIP  RCDA  
       RCHA    XX10
       RCDA
       RCHA    XX10
 START RCDA                                                             9AP1 004
       RCHA    XX10                                                     9AP1 005
       LCHA    XX20                                                     9AP1 006
       CAL     XX20                                                     9AP1 007
       PDX     0,4                                                      9AP1 008
 CTRL  TXL     1A,4,0                                                   9AP1 009
       TCOA    *                                                        9AP1 010
       SCHA    XX30                                                     9AP1 011
       CLA     XX30                                                     9AP1 012
       STA     *+2                                                      9AP1 013
       CAL     XX20                                                     9AP1 014
 ACL   ACL     **,4                                                     9AP1 015
       TIX     ACL,4,1                                                  9AP1 016
       ERA     XX20+1                                                   9AP1 017
       TZE     START                                                    9AP1 018
       HTR     START                                                    9AP1 019
 XX10  IOCT    XX20,0,2                                                 9AP1 020
 XX20  PZE                                                              9AP1 021
       PZE                                                              9AP1 022
 XX30  PZE                                                              9AP1 023
 1A    CLA     L2A                                                      9AP1 024
       STA     CTRL                                                     9AP1 025
       WTBB    1                                                        9AP1 026
       RCHB    Y10                                                      9AP1 027
       TCOB    *                                                        9AP1 028
       TXI     SKIP                                                     9AP1 029
 2A    CLA     L3A                                                      9AP1 030
       STA     CTRL                                                     9AP1 031
       AXT     2962,4                                                   9AP1 032
       PXD                                                              9AP1 033
       ACL     3072,4                                                   9AP1 034
       TIX     *-1,4,1                                                  9AP1 035
       SLW     CKSUM                                                    9AP1 036
       WTBB    1                                                        9AP1 037
       RCHB    Y20                                                      9AP1 038
       TCOB    *                                                        9AP1 039
       TXI     SKIP                                                     9AP1 040
 3A    CLA     L4A                                                      9AP1 041
       STA     CTRL                                                     9AP1 042
       WTBB    1                                                        9AP1 043
       RCHB    Y30                                                      9AP1 044
       TCOB    *                                                        9AP1 045
       TXI     SKIP                                                     9AP1 046
 4A    AXT     2090,4                                                   9AP1 047
       PXD                                                              9AP1 048
       ACL     2200,4                                                   9AP1 049
       TIX     *-1,4,1                                                  9AP1 050
       SLW     CKSUM                                                    9AP1 051
       WTBB    1                                                        9AP1 052
       RCHB    Y40                                                      9AP1 053
       TCOB    *                                                        9AP1 054
       WEFB    1                                                        9AP1 055
       NOP                                                              9AP1 056
       HTR     *                                                        9AP1 057
 CKSUM PZE                                                              9AP1 058
 L2A   PZE     2A                                                       9AP1 059
 L3A   PZE     3A                                                       9AP1 060
 L4A   PZE     4A                                                       9AP1 061
 Y10   IOCD    0,0,17                                                   9AP1 062
 Y20   IOCP    CKSUM,0,1                                                9AP1 063
       IOCD    110,0,2962                                               9AP1 064
 Y30   IOCD    0,0,17                                                   9AP1 065
 Y40   IOCP    CKSUM,0,1                                                9AP1 066
       IOCD    110,0,2090                                               9AP1 067
       END  -1000                                                       9AP1 068
       REM ASSEMBLY OF 9AP2        THE CONTROL RECORD FOR THE FIRST PASS9AP2 001
                                             10 OCTOBER 1958            9AP2 002
       ORG                                                              9AP2 003
       IOCD    3,0,N                                                    9AP2 004
       TCOB    1                                                        9AP2 005
 TWO   RTBB    SYSTAP                                                   9AP2 006
       RCHB    IO                                                       9AP2 007
       TCOB    *                                                        9AP2 008
       PXD                                                              9AP2 009
       AXT     TOTAL,4                                                  9AP2 010
 LOOP  ACL     FINAL,4                                                  9AP2 011
       TIX     LOOP,4,1                                                 9AP2 012
       ERA     SUM1                                                     9AP2 013
       TZE     STARTA                                                   9AP2 014
       HPR                                                              9AP2 015
       BSRB    SYSTAP                                                   9AP2 016
       TXI     TWO                                                      9AP2 017
 SUM1  PZE                                                              9AP2 018
 IO    IOCP    SUM1,0,1                                                 9AP2 019
       IORT    110,0,-1                                                 9AP2 020
 N     EQU     14                                                       9AP2 021
 FINAL EQU     3072                                                     9AP2 022
 TOTAL EQU     2962                                                     9AP2 023
SYSTAP EQU     1                                                        9AP2 024
STARTA DEFINE  1417                                                     9AP2 025
       END                                                              9AP2 026
       REM ASSEMBLY OF 9AP3              THE FIRST PASS                 9AP3 001
                                             10 OCTOBER 1958            9AP3 002
       REM DIAGNOSTIC FORMAT.  PASS 1                                   9AP3 003
       REM                                                              9AP3 004
       ORG 110                                                          9AP3 005
       REM                                                              9AP3 006
 TERM                                                                   9AP3 007
 TEQ                                                                    9AP3 008
 CH                                                                     9AP3 009
 CHD                                                                    9AP3 010
 EQV                                                                    9AP3 011
 EQVR                                                                   9AP3 012
 SYMB                                                                   9AP3 013
 MQ                                                                     9AP3 014
 BHEAD                                                                  9AP3 015
 THEAD                                                                  9AP3 016
 LOC1  PZE     0,2,0                                                    9AP3 017
 LOC2  PZE     0,2,0                                                    9AP3 018
 M                                                                      9AP3 019
 N                                                                      9AP3 020
 RBITS PZE                                                              9AP3 021
 INDIC PZE                                                              9AP3 022
 RBIT  PZE     0,2,0                                                    9AP3 023
 LMT                                                                    9AP3 024
 LMT1      OCTAL+16,0,16                                                9AP3 025
 LMT2      OCTAL+4,0,4                                                  9AP3 026
       REM                                                              9AP3 027
 Q0        0                                                            9AP3 028
 Q1        1                                                            9AP3 029
 Q2        2                                                            9AP3 030
 Q3        3                                                            9AP3 031
 Q4        4                                                            9AP3 032
 Q5        5                                                            9AP3 033
 Q6        6                                                            9AP3 034
 Q7        7                                                            9AP3 035
 Q8        8                                                            9AP3 036
 Q9        9                                                            9AP3 037
 Q10       10                                                           9AP3 038
       REM                                                              9AP3 039
 MASK  BCD 1                                                            9AP3 040
 HED   BCD 1HED000                                                      9AP3 041
       BCI     1,FUL000                                                 9AP3 042
       BCI     1,FIN000                                                 9AP3 043
 ERROR BCD 1ERROR0                                                      9AP3 044
 EQU   BCD 1EQU000                                                      9AP3 045
 END   BCD 1END000                                                      9AP3 046
       BCI 1,DEFINE                                                     9AP3 047
 DEF   BCD 1DEF000                                                      9AP3 048
 DEC   BCD 1DEC000                                                      9AP3 049
 BSS   BCD 1BSS000                                                      9AP3 050
 BES   BCD 1BES000                                                      9AP3 051
 BEGIN BCD 1BEGIN0                                                      9AP3 052
 BCI   BCD 1BCI000                                                      9AP3 053
 BCDO  BCD 1BCD000                                                      9AP3 054
       BCI     1,ABS000                                                 9AP3 055
       BCI     1,LIB000                                                 9AP3 056
 OCT   BCD 1OCT000                                                      9AP3 057
 ORG   BCD 1ORG000                                                      9AP3 058
       BCI     1,PLR000                                                 9AP3 059
 PST   BCD 1PST000                                                      9AP3 060
       BCI     1,REL000                                                 9AP3 061
 REM   BCD 1REM000                                                      9AP3 062
 REP   BCD 1REP000                                                      9AP3 063
RETURN BCD 1RETURN                                                      9AP3 064
       BCI     1,RST000                                                 9AP3 065
       BCI     1,SKIP00                                                 9AP3 066
 SYN   BCD 1SYN000                                                      9AP3 067
 TCD   BCI     1,TCD000                                                 9AP3 068
       REM                                                              9AP3 069
 VRF       2,0,-1                                                       9AP3 070
 VRF1  PZE 0                                                            9AP3 071
 PWR       0,0,18*512                                                   9AP3 072
 PBIT  MZE                                                              9AP3 073
 1BIT  TIX                                                              9AP3 074
 2BIT  TXI                                                              9AP3 075
 ADDR      -1                                                           9AP3 076
 TAG       0,7                                                          9AP3 077
 DECR      0,0,-1                                                       9AP3 078
 COMMA     59                                                           9AP3 079
 DIVID     49                                                           9AP3 080
 BLANK     48                                                           9AP3 081
 MULT      44                                                           9AP3 082
 MINUS     32                                                           9AP3 083
 PLUS      16                                                           9AP3 084
 B         18                                                           9AP3 085
 E         21                                                           9AP3 086
 HEAD      43                                                           9AP3 087
 POINT     27                                                           9AP3 088
       REM                                                              9AP3 089
 SAVE  BSS 4                                                            9AP3 090
 OCTAL BSS 4                                                            9AP3 091
 BCD   BCI 9,                                                           9AP3 092
       BCI 9,                                                           9AP3 093
       BCI 2,                                                           9AP3 094
       REM                                                              9AP3 095
       REM                                                              9AP3 096
 WOT   SXA RX1,1                                                        9AP3 097
       AXT 20,1                                                         9AP3 098
       CLA BLANKS                                                       9AP3 099
       STO LRIMG+20,1                                                   9AP3 100
       TIX *-1,1,1                                                      9AP3 101
 WT4   CLA LMT                                                          9AP3 102
       STA WT1                                                          9AP3 103
       SXA RX2,2                                                        9AP3 104
       SXA RX4,4                                                        9AP3 105
       PDX 0,2                                                          9AP3 106
       AXC 1,1                                                          9AP3 107
 WT6   CLA LMT2                                                         9AP3 108
       STO LMT                                                          9AP3 109
 WT1   LDQ **,2                                                         9AP3 110
       STQ LRIMG+1,1                                                    9AP3 111
       TXI *+1,1,-1                                                     9AP3 112
       TIX WT1,2,1                                                      9AP3 113
       SWT 5                                                            9AP3 114
       WTDB 3                                                           9AP3 115
       SWT 5                                                            9AP3 116
       RCHB RCW20                                                       9AP3 117
       TCOB *                                                           9AP3 118
       SWT 3                                                            9AP3 119
       TRA *+2                                                          9AP3 120
       TSX BCD2H,4                                                      9AP3 121
 RX1   AXT **,1                                                         9AP3 122
 RX2   AXT **,2                                                         9AP3 123
 RX4   AXT **,4                                                         9AP3 124
       TRA 1,4                                                          9AP3 125
 RCW20 IOCP BLANKS,,1                                                   9AP3 126
       IOCD LRIMG+1,0,19                                                9AP3 127
 BCD2H SXA LRIR1,1           SAVE                                       9AP3 128
       SXA LRIR2,2           INDEX                                      9AP3 129
       SXA LRIR4,4           REGISTERS                                  9AP3 130
       AXT 9,4               TEST                                       9AP3 131
       TNX LRCRT,4,1         WHETHER                                    9AP3 132
       CLA LRIMG+20,4        LAST EIGHT                                 9AP3 133
       CAS     MASK                WORDS ARE                            9AP3 134
       TXL *+2               ALL BLANK                                  9AP3 135
       TRA *-4               AND IF NOT                                 9AP3 136
       SIR 1                 SET INDICATOR                              9AP3 137
 LRCRT AXT 21,4              COUNT IMAGE                                9AP3 138
       SXA LRCRNT,4          WORDS DURING CONVERSION                    9AP3 139
 LRCD1 AXT 32,1              CLEAR LINE IMAGE                           9AP3 140
       TCOA *                AFTER WAITING                              9AP3 141
       STZ LRCRD+7,1         FOR LAST LINE                              9AP3 142
       TIX *-1,1,1           TO FINISH PRINTING                         9AP3 143
       AXT 1,1               SET FIRSTHALF CARD IMAGE                   9AP3 144
 LRWD2 CLA LRBIT             SET COLUMN                                 9AP3 145
       STO LRNDIC            INDICATOR                                  9AP3 146
 LRWD  LXA LRCRNT,4          GET NEXT                                   9AP3 147
       TNX LRWD3,4,1         BCD WORD                                   9AP3 148
       LDQ LRIMG+20,4        INTO MQ                                    9AP3 149
       SXA LRCRNT,4          AND COUNT DOWN                             9AP3 150
 LRLP1 PXD                                                              9AP3 151
       LGL 6                 ISOLATE CHARACTER                          9AP3 152
       CAS 001LR             TEST FOR BLANK                             9AP3 153
       TRA *+2               AND IF NOT, SKIP OVER NEXT                 9AP3 154
       TRA LRSKP             TRANSFER TO LEAVE BIT OUT                  9AP3 155
       LGR 4                 ISOLATE ZONE BITS                          9AP3 156
       ERA 003LR             AND ADJUST ZONE                            9AP3 157
       ALS 1                 FOR USING TO OR                            9AP3 158
       PAC 0,4               INDICATOR BIT INTO CARD                    9AP3 159
       CLM                   IMAGE.                                     9AP3 160
       LGL 4                 ISOLATE DIGIT FOR NUMERIC                  9AP3 161
       ALS 1                 ROW AND PUT THAT IN                        9AP3 162
       PAX 0,2               INDEX REGISTER.                            9AP3 163
       CAL LRNDIC            TEST FOR PLUS AND                          9AP3 164
       TXH *+2,2,0           MINUS SIGNS WHICH                          9AP3 165
       TXH *+2,4,-6          ARE SPECIAL CASES.                         9AP3 166
       ORS LRCRD,3           PUT ZONE AND DIGIT                         9AP3 167
       ORS LRCRD,5           BITS INTO CARD IMAGE                       9AP3 168
LRSKP1 ARS 1                 MOVE COLUMN INDICATOR                      9AP3 169
       SLW LRNDIC            AND RESTORE IT.                            9AP3 170
       ANA LRMSK             TEST FOR END OF                            9AP3 171
       TNZ LRLP1             BCD WORD.                                  9AP3 172
       CAL LRNDIC            TEST FOR END OF                            9AP3 173
       TNZ LRWD              BINARY WORD.                               9AP3 174
 LRWD3 CAL LRCRD-24,1        PUT IN 8-4 ROW                             9AP3 175
       ORS LRCRD-16,1                                                   9AP3 176
       ORS LRCRD-8,1                                                    9AP3 177
       CAL LRCRD-22,1        PUT IN 8-3 ROW                             9AP3 178
       ORS LRCRD-16,1                                                   9AP3 179
       ORS LRCRD-6,1                                                    9AP3 180
       TXL LRCD2,1           IF FINISHED SECOND HALF CARD, PRINT        9AP3 181
       AXT 0,1               IF NOT GO TO PROCESS                       9AP3 182
       TXL LRWD2             SECOND HALF CARD                           9AP3 183
 LRCD2 WPDA                  SELECT PRINTER                             9AP3 184
 LRCD3 NOP                   EITHER                                     9AP3 185
       RCHA LRWTCD                                                      9AP3 186
       RNT 1                                                            9AP3 187
       TXL LROUT                                                        9AP3 188
       CLA LRSPRA                                                       9AP3 189
       STO LRCD3                                                        9AP3 190
       RIR 1                                                            9AP3 191
       TXL LRCD1                                                        9AP3 192
 LROUT CLA LRNOP                                                        9AP3 193
       STO LRCD3                                                        9AP3 194
 LRIR1 AXT 0,1                                                          9AP3 195
 LRIR2 AXT 0,2                                                          9AP3 196
 LRIR4 AXT 0,4                                                          9AP3 197
       TRA 1,4                                                          9AP3 198
 LRSKP CAL LRNDIC                                                       9AP3 199
       TXL LRSKP1                                                       9AP3 200
LRNDIC BSS 1                                                            9AP3 201
LRCRNT BSS 1                                                            9AP3 202
 LRIMG BSS 20                                                           9AP3 203
 LRCRD BES 25                                                           9AP3 204
       BSS 7                                                            9AP3 205
 LRNOP NOP                                                              9AP3 206
 001LR SYN BLANK                                                        9AP3 207
LRWTCD IOCD LRCRD-19,0,24                                               9AP3 208
LRSPRA SPRA 9                                                           9AP3 209
 LRBIT SYN PBIT                                                         9AP3 210
 LRMSK OCT 773737373737                                                 9AP3 211
 003LR OCT 3                                                            9AP3 212
 BDCRD BCI 9,       NOP             CARD HAS ILLEGAL PUNCH, THEREFO     9AP3 213
       BCI 3,RE NOT TRANSLATED                                          9AP3 214
 ABPCH CAL 1,4                                                          9AP3 215
       TCOA *                                                           9AP3 216
       STD PCH1                                                         9AP3 217
       ARS 18                                                           9AP3 218
       ADD PCH1                                                         9AP3 219
       STA PCH2                                                         9AP3 220
       STA PCH3                                                         9AP3 221
       SBM 1,4                                                          9AP3 222
       TZE 2,4                                                          9AP3 223
       TMI 2,4                                                          9AP3 224
       SXD PCH1,1                                                       9AP3 225
       SXD PCH4,2                                                       9AP3 226
       SXA PCH4,4                                                       9AP3 227
       PAX 0,1                                                          9AP3 228
       CLA 2,4                                                          9AP3 229
 PCH8  AXT 25,4                                                         9AP3 230
       STZ LRCRD,4                                                      9AP3 231
       TIX *-1,4,1                                                      9AP3 232
       AXT 0,4                                                          9AP3 233
       STA VR                                                           9AP3 234
       CLM                                                              9AP3 235
       LXA PCH1,2                                                       9AP3 236
 PCH2  ACL 0,1                                                          9AP3 237
       TXH PCH5,2,21                                                    9AP3 238
       TNX PCH5,1,1                                                     9AP3 239
       TXI PCH2,2,1                                                     9AP3 240
 PCH5  SXD PCH6,2                                                       9AP3 241
       SXD VR,2                                                         9AP3 242
       ACL VR                                                           9AP3 243
       SLW SUM                                                          9AP3 244
 PCH6  TXI PCH9,1                                                       9AP3 245
 PCH9  TXI PCH3,1,-1                                                    9AP3 246
 PCH3  LDQ 0,1                                                          9AP3 247
       STQ LRCRD-25,4                                                   9AP3 248
       TXI *+1,4,-1                                                     9AP3 249
       TIX PCH9,2,1                                                     9AP3 250
       WPUA                                                             9AP3 251
       RCHA RCWPU                                                       9AP3 252
       TCOA *                                                           9AP3 253
 PCH7  CLA VR                                                           9AP3 254
       ARS 18                                                           9AP3 255
       ADD VR                                                           9AP3 256
       TIX PCH8,1,1                                                     9AP3 257
       LXD PCH1,1                                                       9AP3 258
       LXA PCH4,4                                                       9AP3 259
       LXD PCH4,2                                                       9AP3 260
       TRA 3,4                                                          9AP3 261
 RCWPU IOCP VR,,1                                                       9AP3 262
       IOCP SUM,,1                                                      9AP3 263
       IOCD LRCRD-25,,22                                                9AP3 264
       REM                                                              9AP3 265
       REM                                                              9AP3 266
 PCH1      1                                                            9AP3 267
 PCH4                                                                   9AP3 268
 VR                                                                     9AP3 269
 SUM                                                                    9AP3 270
       REM                                                              9AP3 271
       REM                                                              9AP3 272
 RDBCD RCDA                                                             9AP3 273
       RCHA    X10                 2 WORDS TO L AND R                   9AP3 274
       LCHA    X20                 2 WORDS TO 8L AND 8R                 9AP3 275
       CAL     L                   MOVE 9 ROW TO                        9AP3 276
       SLW     LS                  LEFT AND RIGHT                       9AP3 277
       CAL     R                   SUM AREAS                            9AP3 278
       SLW     RS                  X                                    9AP3 279
       LXD     B4,1                SET DIGIT ROW COUNT                  9AP3 280
       TSX     C1,2                ENTER CONVERSION LOOP                9AP3 281
 B2    TXL     B5                  LEAVE CONVERSION LOOP                9AP3 282
       ALS     1                                                        9AP3 283
 B3    TXL     C2                  INITIALIZE BCD RECORD                9AP3 284
 B5    LCHA    X10                 BRING IN NEXT ROW                    9AP3 285
       CAL     8L                  USE 8ROW                             9AP3 286
       SLW     LS                  AS A SUM                             9AP3 287
       CAL     8R                  X                                    9AP3 288
       SLW     RS                  X                                    9AP3 289
       TSX     C1,2                ENTER CONVERSION LOOP                9AP3 290
 B4    TXL     B6,0,8              LEAVE CONVERSION LOOP                9AP3 291
       ALS     3                   ADD 8 TIMES 8 ROW                    9AP3 292
       TXL     C3                  X                                    9AP3 293
 B6    CAL     L                   USE 9 ROW AS SUM                     9AP3 294
       SLW     LS                  X                                    9AP3 295
       CAL     R                   X                                    9AP3 296
       SLW     RS                  X                                    9AP3 297
 B13   TXL     B7,1,2              TEST FOR ZERO ROW                    9AP3 298
 B14   LCHA    X10                 BRING IN ROW                         9AP3 299
 B16   CAL     L                   TEST LEFT ROW FOR                    9AP3 300
       ANA     LS                  ILLEGAL DOUBLE PUNCH                 9AP3 301
       TNZ     B17                 X                                    9AP3 302
       CAL     L                   FORM LOGICAL SUM                     9AP3 303
       ORS     LS                  OF LEFT ROWS                         9AP3 304
       CAL     R                   TEST FOR ILLEGAL                     9AP3 305
       ANA     RS                  DOUBLE PUNCH                         9AP3 306
       TNZ     B17                 IN RIGHT ROW                         9AP3 307
       CAL     R                   FORM LOGICAL SUM                     9AP3 308
       ORS     RS                  OF RIGHT ROWS                        9AP3 309
       TNX     B12,1,1             TEST FOR ZONE ROWS                   9AP3 310
       TSX     C1,2                ENTER CONVERSION LOOP                9AP3 311
       TXL     B13                 LEAVE CONVERSION LOOP                9AP3 312
       TXL     C3                  ADD TO BCD RECORD                    9AP3 313
 B7    TXL     B17A,1,1            TEST FOR ZONE OR 1 ROW               9AP3 314
       LCHA    X30                 BRING IN ZERO ROW                    9AP3 315
       TXI     B16                 PROCESS 1 ROW                        9AP3 316
 B17A  CAL     8L                  ADD 8 LEFT ROW                       9AP3 317
       ORA     LS                  TO LEFT LOGICAL SUM                  9AP3 318
       SLW     LDS                 X                                    9AP3 319
       LCHA    X10                 BRING IN 11 OR 12 ROW                9AP3 320
       ANA     LZ                  FORM INDICATOR FOR                   9AP3 321
       SLW     LS                  BOTH DIGIT AND ZERO                  9AP3 322
       CAL     8R                  ADD 8 RIGHT ROW TO                   9AP3 323
       ORA     RS                  RIGHT LOGICAL SUM                    9AP3 324
       SLW     RDS                 X                                    9AP3 325
       ANA     RZ                  FORM INDICATOR FOR                   9AP3 326
       SLW     RS                  BOTH DIGIT AND ZERO                  9AP3 327
 B12   TSX     C1,2                ENTER CONVERSION LOOP                9AP3 328
       TXL     B20                 LEAVE CONVERSION LOOP                9AP3 329
       ALS     4                   SHIFT TO ZONE POSITION               9AP3 330
       TXL     C3                  X                                    9AP3 331
 B20   LCHA    X40                 BRING IN 12 ROW                      9AP3 332
 B23   CAL     L                   TEST LEFT ROW FOR                    9AP3 333
       ANA     LS                  ILLEGAL DOUBLE PUNCH                 9AP3 334
       TNZ     B17                 X                                    9AP3 335
       CAL     L                   FORM LOGICAL SUM                     9AP3 336
       ORS     LS                  OF LEFT ZONES                        9AP3 337
       CAL     R                   TEST RIGHT ROW FOR                   9AP3 338
       ANA     RS                  ILLEGAL DOUBLE PUNCH                 9AP3 339
       TNZ     B17                 X                                    9AP3 340
       CAL     R                   FORM LOGICAL SUM                     9AP3 341
       ORS     RS                  OF RIGHT ZONES                       9AP3 342
       TSX     C1,2                ENTER CONVERSION LOOP                9AP3 343
       TXL     B21                 LEAVE CONVERSION LOOP                9AP3 344
       ALS     4                   SHIFT TO ZONE POSITION               9AP3 345
       TXL     C3                  X                                    9AP3 346
 B21   TCOA    B22                 TRANSFER IF 12 ROW NOT PROCESSED     9AP3 347
       CAL     LS                  SAVE LEFT ZONE SUM                   9AP3 348
       SLW     L                   X                                    9AP3 349
       CAL     LDS                 FORM INDICATOR FOR                   9AP3 350
       COM                         ZERO AND X AND/OR Y                  9AP3 351
       ANA     LZ                  IN LEFT ROWS                         9AP3 352
       ANS     LS                  X                                    9AP3 353
       CAL     RS                  SAVE RIGHT ZONE SUM                  9AP3 354
       SLW     R                   X                                    9AP3 355
       CAL     RDS                 FORM INDICATOR FOR                   9AP3 356
       COM                         ZERO AND X AND / OR Y                9AP3 357
       ANA     RZ                  IN RIGHT ROWS                        9AP3 358
       ANS     RS                  X                                    9AP3 359
       TSX     C1,2                ENTER CONVERSION LOOP                9AP3 360
       TXL     B15                 LEAVE CONVERSION LOOP                9AP3 361
       SLW     T                   MULTIPLY INDICATOR                   9AP3 362
       ALS     2                   BITS BY TEN                          9AP3 363
       ACL     T                   X                                    9AP3 364
       ALS     1                   X                                    9AP3 365
       TXL     C3                  X                                    9AP3 366
 B15   CAL     LDS                 FORM INDICATOR                       9AP3 367
       ORA     LZ                  FOR BLANK COLUMNS                    9AP3 368
       ORA     L                   IN LEFT HALF OF CARD                 9AP3 369
       COM                         X                                    9AP3 370
       SLW     LS                  X                                    9AP3 371
       CAL     RDS                 FORM INDICATOR FOR                   9AP3 372
       ORA     RZ                  BLANK COLUMNS                        9AP3 373
       ORA     R                   IN RIGHT HALF OF CARD                9AP3 374
       COM                         X                                    9AP3 375
       SLW     RS                  X                                    9AP3 376
       TSX     C1,2                ENTER CONVERSION LOOP                9AP3 377
       TRA     B24                 LEAVE CONVERSION LOOP                9AP3 378
       SLW     T                   MULTIPLY INDICATOR                   9AP3 379
       ALS     1                   BITS BY 3 AND                        9AP3 380
       ACL     T                   SHIFT TO ZONE POSITION               9AP3 381
       ALS     4                   X                                    9AP3 382
       TXL     C3                  X                                    9AP3 383
 B22   TCOA    B22                 WAIT FOR 12 ROW                      9AP3 384
       TXI     B23                 AND PROCESS 12 ROW                   9AP3 385
 B24   CAL     BLANKS                                                   9AP3 386
       SLW     BCD+12                                                   9AP3 387
       SLW     BCD+13                                                   9AP3 388
       TEFA    B25                                                      9AP3 389
       TRA     3,4                                                      9AP3 390
 B17   AXT     12,1                GET NOTE ABOUT ILLEGAL PUNCH         9AP3 391
       CAL     BDCRD+12,1          AND STORE IT IN THE BCD AREA         9AP3 392
       SLW     BCD+12,1            X                                    9AP3 393
       TIX     B17+1,1,1                                                9AP3 394
       TEFA    B25                                                      9AP3 395
       TRA     3,4                                                      9AP3 396
 B25   TRA     2,4                                                      9AP3 397
 C1    SXD     C4,1                SAVE ROW COUNT                       9AP3 398
       SLN     1                   INDICATE LEFT ROW                    9AP3 399
       CAL     1,4                 INITIALIZE ADDRESS                   9AP3 400
       ADD     SIX                 (SIX IS 6)                           9AP3 401
       LDQ     LS                  OBTAIN LEFT SUM                      9AP3 402
 C8    STA     C2                  SET BCD RECORD ADDRESS               9AP3 403
       STA     C3                  X                                    9AP3 404
       TXH     C5,1,1              SKIP TEST IF DIGIT ROW               9AP3 405
       STQ     T                   TEST FOR NO SUM                      9AP3 406
       CAL     T                   X                                    9AP3 407
       TZE     C6                  X                                    9AP3 408
 C5    LXA     SIX,1               SET WORD COUNT                       9AP3 409
 C7    PXD     12                                                       9AP3 410
       LGL     1                   X                                    9AP3 411
       ALS     5                   X                                    9AP3 412
       LGL     1                   X                                    9AP3 413
       ALS     5                   X                                    9AP3 414
       LGL     1                   X                                    9AP3 415
       ALS     5                   X                                    9AP3 416
       LGL     1                   X                                    9AP3 417
       ALS     5                   X                                    9AP3 418
       LGL     1                   X                                    9AP3 419
       ALS     5                   X                                    9AP3 420
       LGL     1                   X                                    9AP3 421
       TRA     2,2                 EXIT FOR ROW PROCEDURE               9AP3 422
 C3    ACL     **,1                ADD TO BCD RECORD                    9AP3 423
 C2    SLW     **,1                STORE IN BCD RECORD                  9AP3 424
       TIX     C7,1,1              COUNT WORDS                          9AP3 425
       LXD     C4,1                RESTORE ROW COUNT                    9AP3 426
 C6    SLT     1                   TEST FOR RIGHT ROW                   9AP3 427
       TRA     1,2                 RETURN                               9AP3 428
       LDQ     RS                  SET UP RIGHT ROW                     9AP3 429
       CAL     1,4                 X                                    9AP3 430
       ADM     C7                  ADD 12 TO BCD RECORD ADDRESS         9AP3 431
 C4    TXL     C8                  X                                    9AP3 432
X10    IOCT    L,0,2                                                    9AP3 433
 X20   IOCT    8L,0,2                                                   9AP3 434
 X30   IOCT    LZ,0,2                                                   9AP3 435
 X40   IOCD    L,0,2                                                    9AP3 436
 L     SYN     LRIMG                                                    9AP3 437
 R     SYN     LRIMG+1                                                  9AP3 438
 8L    SYN     LRIMG+2                                                  9AP3 439
 8R    SYN     LRIMG+3                                                  9AP3 440
 LZ    SYN     LRIMG+4                                                  9AP3 441
 RZ    SYN     LRIMG+5                                                  9AP3 442
 LDS   SYN     LRIMG+6                                                  9AP3 443
 RDS   SYN     LRIMG+7                                                  9AP3 444
 T     SYN     LRIMG+8                                                  9AP3 445
 LS    SYN     LRIMG+9                                                  9AP3 446
 RS    SYN     LRIMG+10                                                 9AP3 447
 SIX   SYN     Q6                                                       9AP3 448
 NOTE  SYN     BDCRD+1                                                  9AP3 449
 SCAN7 LXA     CH,4                                                     9AP3 450
       TXL     SCAN6,4,47                                               9AP3 451
       TXL     EQL,4,48            BLANK TRANSFER                       9AP3 452
       TXL     SCAN6,4,58                                               9AP3 453
       TXL     EQL,4,59            COMMA TRANSFER                       9AP3 454
       TXI     SCAN6                                                    9AP3 455
       REM                                                              9AP3 456
 SCAN  SXD     SCAN1,4             SAVE IR4 FOR RETURN                  9AP3 457
       STZ     RBITS               CLEAR WORKING LOCATIONS              9AP3 458
       STZ     TERM                X                                    9AP3 459
       STZ     TEQ                 X                                    9AP3 460
       CLA     CH                  TEST FOR A BLANK                     9AP3 461
       SUB     BLANK               X                                    9AP3 462
       TZE     1,4                 FIELD IS BLANK. RETURN WITH ZERO     9AP3 463
       CLA     ADD1                SET TRANSFER SWITCH FOR FIRST SYMBOL 9AP3 464
       STD     OP1                 IN EXPRESSION                        9AP3 465
 SCAN6 CLA     BHEAD               SET CURRENT HEADING CHARACTER        9AP3 466
       STO     THEAD               X                                    9AP3 467
       LDQ     MQ                  PICK UP WORD OF EXPRESSION           9AP3 468
 SCAN9 STZ     EQV                 RESET MORE WORKING SPACE             9AP3 469
       STZ     EQVR                X                                    9AP3 470
       STZ     SYMB                X                                    9AP3 471
 SCAN1 TXI     SCAN8+1             NORMAL START OF SCAN                 9AP3 472
       REM                                                              9AP3 473
 EQL   CLA     TERM                COMPLETE VALUE OF EXPRESSION         9AP3 474
       ADD     TEQ                 X                                    9AP3 475
       STO     TEQ                 X                                    9AP3 476
       TZE     EQL3                SUPPLY COMPLEMENT INDICATOR IF TEQ MI9AP3 477
       TPL     EQL3                NUS                                  9AP3 478
       CLS     RBITS               SET RBITS MINUS ON TEQ MINUS         9AP3 479
       STO     RBITS                                                    9AP3 480
 EQL3  CLA     Q2                  TEST FOR RELOCATABLE FIELD           9AP3 481
       SBM     RBITS               X                                    9AP3 482
       TZE     EQL1                RELOCATABLE                          9AP3 483
       STZ     RBITS                                                    9AP3 484
 EQL1  CLA     RBITS                                                    9AP3 485
       TZE     EQL2                                                     9AP3 486
       TPL     EQL2                INSERT COMPLEMENT INDICATOR ON RBITS 9AP3 487
       ORA     Q1                  MINUS                                9AP3 488
       SLW     RBITS               X                                    9AP3 489
 EQL2  CAL     PBIT                IF TEQ MINUS PROVIDE COMPLEMENT      9AP3 490
       ADD     TEQ                 X                                    9AP3 491
       ANA     ADDR                SAVE ADDRESS ONLY                    9AP3 492
       STO     TEQ                 X                                    9AP3 493
       LXD     SCAN1,4                                                  9AP3 494
       TRA     1,4                 NORMAL EXIT                          9AP3 495
       REM                                                              9AP3 496
 SCAN4 PXD                         CLEAR AC                             9AP3 497
       LGL     6                   BRING IN CHAR. FROM VAR. FIELD       9AP3 498
       STO     CH                  SAVE SAME                            9AP3 499
       CAS     COMMA                                                    9AP3 500
       TXI     SCAN3                                                    9AP3 501
       TXI     EQ                                                       9AP3 502
       CAS     DIVID                                                    9AP3 503
       TXI     SCAN3                                                    9AP3 504
       TXI     DIV                                                      9AP3 505
       CAS     BLANK                                                    9AP3 506
       TXI     SCAN3                                                    9AP3 507
       TXI     EQ                                                       9AP3 508
       CAS     MULT                                                     9AP3 509
       TXI     SCAN3                                                    9AP3 510
       TXI     MPY                                                      9AP3 511
       CAS     HEAD                                                     9AP3 512
       TXI     SCAN3                                                    9AP3 513
       TXI     HEAD1                                                    9AP3 514
       CAS     MINUS                                                    9AP3 515
       TXI     SCAN3                                                    9AP3 516
       TXI     SUB                                                      9AP3 517
       CAS     PLUS                                                     9AP3 518
       TXI     SCAN3                                                    9AP3 519
       TXI     ADD                                                      9AP3 520
       REM                                                              9AP3 521
 SCAN3 CAL     SYMB                                                     9AP3 522
       ALS     6                                                        9AP3 523
       ADD     CH                                                       9AP3 524
 SCAN8 SLW     SYMB                                                     9AP3 525
 SCAN2 TIX     SCAN4,1,1                                                9AP3 526
       TXI     SCAN5,2,-1                                               9AP3 527
 SCAN5 LDQ     BCD,2                                                    9AP3 528
       TXI     SCAN4,1,5                                                9AP3 529
       REM                                                              9AP3 530
 EQ1   SXD     SCAN-1,4                                                 9AP3 531
 EQ    STQ     MQ                                                       9AP3 532
       CAL     SYMB                                                     9AP3 533
       CAS     MULT                                                     9AP3 534
       TRA     EQ+5                                                     9AP3 535
       TRA     SAME                                                     9AP3 536
       ANA     MASK                                                     9AP3 537
       TZE     EQ5                                                      9AP3 538
       LDQ     SYMB                                                     9AP3 539
 EQ7   PXD     -EQ2-3              CLEAR AC                             9AP3 540
       LGL     6                                                        9AP3 541
       TNZ     EQ2                                                      9AP3 542
       CAL     THEAD               INSERT CURRENT HEADING CHARACTER     9AP3 543
 EQ2   LGL     30                  BRING REST OF SYMBOL INTO AC         9AP3 544
       SLW     SYMB                SAVE THE SYMBOL                      9AP3 545
       TSX     SRCH,4              SEARCH THE SYMBOL TABLE              9AP3 546
       STA     EQV                                                      9AP3 547
       LXD     OP1,4                                                    9AP3 548
       ARS     15                                                       9AP3 549
       ORS     RBITS                                                    9AP3 550
       CAL     SCAN-1                                                   9AP3 551
       STD     OP1                                                      9AP3 552
       TRA     1,4                                                      9AP3 553
       REM                                                              9AP3 554
 EQ5   LXA     EQ7,4               BCD TO BINARY                        9AP3 555
 INT   SXD     INT1,4              X                                    9AP3 556
       PXD                         X                                    9AP3 557
       LXA     Q6,4                X                                    9AP3 558
       LDQ     SYMB                X                                    9AP3 559
 INT4  LGL     6                                                        9AP3 560
       TNZ     INT3                                                     9AP3 561
       TIX     INT4,4,1                                                 9AP3 562
 INT1  TXL     INT3                                                     9AP3 563
       REM                                                              9AP3 564
 INT2  PXD                                                              9AP3 565
       LGL     6                                                        9AP3 566
       SLW     CHD                                                      9AP3 567
       CLA     EQV                                                      9AP3 568
       ALS     2                                                        9AP3 569
       ADD     EQV                                                      9AP3 570
       ALS     1                                                        9AP3 571
       ADD     CHD                                                      9AP3 572
 INT3  STO     EQV                                                      9AP3 573
       TIX     INT2,4,1                                                 9AP3 574
       LXD     INT1,4                                                   9AP3 575
       TRA     1,4                                                      9AP3 576
       REM                                                              9AP3 577
 ADD   TSX     EQ1,4                                                    9AP3 578
       CLA     TERM                                                     9AP3 579
       ADD     TEQ                                                      9AP3 580
       STO     TEQ                                                      9AP3 581
       CLA     EQV                                                      9AP3 582
       STO     TERM                                                     9AP3 583
 ADD1  TXL     SCAN7,0,-ADD                                             9AP3 584
       REM                                                              9AP3 585
 SUB   TSX     EQ1,4                                                    9AP3 586
       CLA     TERM                                                     9AP3 587
       ADD     TEQ                                                      9AP3 588
       STO     TEQ                                                      9AP3 589
       CLS     EQV                                                      9AP3 590
       STO     TERM                                                     9AP3 591
       TXL     SCAN7                                                    9AP3 592
       REM                                                              9AP3 593
 MPY   CLA     SYMB                                                     9AP3 594
       TZE     SCAN3+2                                                  9AP3 595
       TSX     EQ1,4                                                    9AP3 596
       LDQ     TERM                                                     9AP3 597
       MPY     EQV                                                      9AP3 598
       STQ     TERM                                                     9AP3 599
 OP1   TXL     SCAN7                                                    9AP3 600
       REM                                                              9AP3 601
 DIV   TSX     EQ1,4                                                    9AP3 602
       CLA     TERM                                                     9AP3 603
       LRS     35                                                       9AP3 604
       DVP     EQV                                                      9AP3 605
       TRA     MPY+5                                                    9AP3 606
       REM                                                              9AP3 607
 HEAD1 CAL     SYMB                                                     9AP3 608
       STO     THEAD                                                    9AP3 609
       TXL     SCAN9                                                    9AP3 610
       REM                                                              9AP3 611
 SAME  CLA     LOC2                                                     9AP3 612
       TRA     EQ2+3                                                    9AP3 613
       REM                                                              9AP3 614
 SRCH  CAL SIZE                                                         9AP3 615
       SXD SRCH1,4                                                      9AP3 616
       ARS 18                                                           9AP3 617
       COM                                                              9AP3 618
       ANA ADDR                                                         9AP3 619
       ADD Q3                                                           9AP3 620
       PAX 0,4                                                          9AP3 621
       ADD SML                                                          9AP3 622
       STA EQ3                                                          9AP3 623
       ADD Q1                                                           9AP3 624
       STA EQ4                                                          9AP3 625
       CLA SYMB                                                         9AP3 626
 EQ3   CAS 0,4            SEARCH TABLE FOR                              9AP3 627
       TIX EQ3,4,2        EQUIVALENCE                                   9AP3 628
       TXH EQ4,4,2                                                      9AP3 629
       TIX EQ3,4,2                                                      9AP3 630
       PXD                                                              9AP3 631
 SRCH1 TXL ERR                                                          9AP3 632
       REM                                                              9AP3 633
 EQ4   CLA 0,4            STORE EQUIVALENCE                             9AP3 634
 ERR   LXD SRCH1,4                                                      9AP3 635
       SLN     1                                                        9AP3 636
       TRA 1,4                                                          9AP3 637
       REM                                                              9AP3 638
 STRTA CLA INPUT                                                        9AP3 639
       STA ARTD                                                         9AP3 640
       STA RTTC                                                         9AP3 641
       STA RTD                                                          9AP3 642
       STA RTTB                                                         9AP3 643
       REWB    2                                                        9AP3 644
       REM                                                              9AP3 645
       CLA INTER                                                        9AP3 646
       STA RTDB                                                         9AP3 647
       STA RTD4                                                         9AP3 648
       STA ENDOP                                                        9AP3 649
       STA ENDOP+1                                                      9AP3 650
       REM                                                              9AP3 651
       CLA OUTPUT                                                       9AP3 652
       STA EJECT                                                        9AP3 653
       REM           AND HEADING                                        9AP3 654
       LXD DECR2,2                                                      9AP3 655
 READA TCOB    *                                                        9AP3 656
       TCOA    *                                                        9AP3 657
       SWT     1                   TEST FOR CARD INPUT                  9AP3 658
 DECR2 TXL ARTDA,0,2                                                    9AP3 659
       SXD     READB+1,2                                                9AP3 660
       TSX RDBCD,4   COPY AS FIRST TWO BCD                              9AP3 661
 READB HTR BCD,0,12  RECORDS ON TAPE 3.                                 9AP3 662
       TXL EOFA      EOF                                                9AP3 663
       LXD     READB+1,2                                                9AP3 664
 READD TXL WTDA,0,14                                                    9AP3 665
       REM                                                              9AP3 666
 ARTDA CLA BLANKS                  INITIALIZE                           9AP3 667
       AXT 14,1                                                         9AP3 668
       AXT 0,4                                                          9AP3 669
       STO BCD+14,1                LINE IMAGE                           9AP3 670
       TIX *-1,1,1                 TO BLANKS                            9AP3 671
 ARTD  RTDA **                     BEFORE READ-IN                       9AP3 672
       RCHA RCW4                   READ ONE RECORD                      9AP3 673
       TCOA *                                                           9AP3 674
       TRCA RTTA                   REDUNDANCY                           9AP3 675
       TEFA EOFA                   END OF INPUT FILE                    9AP3 676
       TRA RTDB                    NORMAL EXIT                          9AP3 677
 RTTC  BSRA **                     ON REDUNDANCY                        9AP3 678
       TXI ARTD,4,1                REREAD FIVE TIMES                    9AP3 679
 RTTA  TXL RTTC,4,5                AND IF STILL BAD                     9AP3 680
       HPR 29127                   SHALL WE GO AHEAD                    9AP3 681
 RTDB  WTDB **                     YES.WRITE OUTPUT RECORD.             9AP3 682
       RCHB RCW4                                                        9AP3 683
       AXT     20,1               CLEAR                                 9AP3 684
       CAL     BLANKS             LINE                                  9AP3 685
       SLW     LRIMG+20,1         IMAGE                                 9AP3 686
       TIX     *-1,1,1            X                                     9AP3 687
       AXT     14,1               MOVE FIRST                            9AP3 688
       CAL     BCD+14,1           TWO RECORDS                           9AP3 689
       SLW     LRIMG+14,1         TO PRINT                              9AP3 690
       TIX     *-2,1,1            BUFFER                                9AP3 691
       TSX     BCD2H,4             PRINT                                9AP3 692
       TIX READA,2,1               GO FOR SECOND CARD                   9AP3 693
       SWT     3                                                        9AP3 694
       TXI     *+2                 IF NO ON-LINE LISTING EJECT PAGE     9AP3 695
       TXI     REDA                IF LISTING ON-LINE DONT EJECT        9AP3 696
       WPRA                                                             9AP3 697
       SPRA    1                                                        9AP3 698
 REDA  TRCA *+1                                                         9AP3 699
       TRCB *+1                    TURN OFF BOTH REDUNDANCY CHECKS      9AP3 700
 READ1 SLF                                                              9AP3 701
       TCOB    *                                                        9AP3 702
       SWT     1                                                        9AP3 703
       TXL RTDA                                                         9AP3 704
 READ2 SWT 1                                                            9AP3 705
       TXL RTDA                                                         9AP3 706
 CRD   TSX RDBCD,4                                                      9AP3 707
       HTR BCD,0,12                                                     9AP3 708
       TXL EOFA                                                         9AP3 709
       CAL BLANKS                                                       9AP3 710
       SLW BCD+12                                                       9AP3 711
       SLW BCD+13                                                       9AP3 712
       TXL RTD4                                                         9AP3 713
 RTDA  AXT 14,1                                                         9AP3 714
       AXT 0,4                                                          9AP3 715
       CLA BLANKS                                                       9AP3 716
       STO BCD+14,1                                                     9AP3 717
       TIX *-1,1,1                                                      9AP3 718
 RTD   RTDA **                                                          9AP3 719
       RCHA RCW4                                                        9AP3 720
       TCOA *                                                           9AP3 721
       TRCA RTTR                                                        9AP3 722
       TEFA EOFA                                                        9AP3 723
 DCR14 TXL RTD4,0,14                                                    9AP3 724
 RTTB  BSRA **                                                          9AP3 725
       TXI RTD,4,1                                                      9AP3 726
 RTTR  TXL RTTB,4,5                                                     9AP3 727
       HPR 29127                                                        9AP3 728
 RTD4  WTDB **                                                          9AP3 729
 WTD1  RCHB RCW4                                                        9AP3 730
 CTRL  LDQ     BCD                                                      9AP3 731
       CLA Q0                                                           9AP3 732
       LGL 6                                                            9AP3 733
       SUB MULT                                                         9AP3 734
       TZE READ1                                                        9AP3 735
       REM                                                              9AP3 736
 CTRL1 LXA PKJ,1                                                        9AP3 737
       CAL BCD+1                                                        9AP3 738
       LDQ BCD+2                                                        9AP3 739
       LGL 6                                                            9AP3 740
       SLW SAVE                                                         9AP3 741
       LGL 18                                                           9AP3 742
       SLW SAVE+1                                                       9AP3 743
       LDQ SAVE+1                                                       9AP3 744
 PKB   CLA Q0                                                           9AP3 745
       LGL 6                                                            9AP3 746
       SUB MULT                                                         9AP3 747
       TZE PKA                                                          9AP3 748
       SUB Q4                                                           9AP3 749
       TZE PKA                                                          9AP3 750
       TXH JONES,1,0                                                    9AP3 751
       BSRB    2                                                        9AP3 752
       LDQ     BLANKS                                                   9AP3 753
       STQ     BCD+1                                                    9AP3 754
       WTDB    2                                                        9AP3 755
       RCHB    STARS                                                    9AP3 756
       TRA     RTD4                                                     9AP3 757
 STARS IOCD 12ST,,12                                                    9AP3 758
 12ST  BCI 6,************************************                       9AP3 759
       BCI 6,************************************                       9AP3 760
       REM                                                              9AP3 761
 JONES TXI PKB,1,-6                                                     9AP3 762
 PKA   SXD SAVE+1,1                                                     9AP3 763
       CLA Q0                                                           9AP3 764
       LGL 6                                                            9AP3 765
       SUB BLANK                                                        9AP3 766
       TNZ PKC                                                          9AP3 767
       TXL PKC,1,0                                                      9AP3 768
       TXI PKA+2,1,-6                                                   9AP3 769
       REM                                                              9AP3 770
 PKC   ADD BLANK                                                        9AP3 771
       STO CH                                                           9AP3 772
       SXD SAVE+2,1                                                     9AP3 773
       TXL PKJ,1,18                                                     9AP3 774
       CLA Q2                                                           9AP3 775
       TRA PKD-4                                                        9AP3 776
       REM                                                              9AP3 777
 PKJ   PXD 24,1                                                         9AP3 778
       LRS 53                                                           9AP3 779
       DVH Q6                                                           9AP3 780
       LLS 35                                                           9AP3 781
       ADD Q4                                                           9AP3 782
       STA VRF1                                                         9AP3 783
       LXD VRF,2                                                        9AP3 784
       TXH PKD,1,18                                                     9AP3 785
       TXI PKD,2,-1                                                     9AP3 786
 PKD   SXD VRF1,2                                                       9AP3 787
       LXD SAVE+1,6                                                     9AP3 788
       CAL BCD+1                                                        9AP3 789
       LDQ BCD+2                                                        9AP3 790
       LGL 54,1                                                         9AP3 791
       SLW MQ                                                           9AP3 792
       LDQ SAVE                                                         9AP3 793
       TXI PKE,2,-6                                                     9AP3 794
 PKE   PXD 30,2                                                         9AP3 795
       ARS 18                                                           9AP3 796
       STA PKE+5                                                        9AP3 797
       CLM                                                              9AP3 798
       LGL 42,4                                                         9AP3 799
       ALS 0                                                            9AP3 800
       SLW SAVE+1                                                       9AP3 801
       LXD VRF1,2                                                       9AP3 802
       LXA VRF1,1                                                       9AP3 803
       LXD CTRL2,4                                                      9AP3 804
       CLA SAVE+1                                                       9AP3 805
       LDQ MQ                                                           9AP3 806
 CTRL3 CAS TCD+1,4                                                      9AP3 807
 CTRL2 TXL     INSTR,0,TCD+1-HED                                        9AP3 808
       TRA INSTR,4                                                      9AP3 809
       TIX CTRL3,4,1                                                    9AP3 810
       REM                                                              9AP3 811
       TXL INSTR                                                        9AP3 812
       TXL HEDOP                                                        9AP3 813
       TXL     READ1                                                    9AP3 814
       TXL     EOFA                                                     9AP3 815
       TXL ERROP                                                        9AP3 816
       TXL     EQUOP                                                    9AP3 817
 ENDT  TXL ENDOP                                                        9AP3 818
       TXL DAFOP                                                        9AP3 819
       TXL READ1                                                        9AP3 820
       TXL DECOP                                                        9AP3 821
       TXL BSSOP                                                        9AP3 822
       TXL BESOP                                                        9AP3 823
       TXL BGNOP                                                        9AP3 824
       TXL BCIOP                                                        9AP3 825
       TXL BCDOP                                                        9AP3 826
       TXL     READ1                                                    9AP3 827
 LIBT  TXL     LIBOP                                                    9AP3 828
       TXL OCTOP                                                        9AP3 829
       TXL ORGOP                                                        9AP3 830
       TXL     PLROP                                                    9AP3 831
       TXL PSTOP                                                        9AP3 832
       TXL     READ1                                                    9AP3 833
       TXL READ1                                                        9AP3 834
       TXL REPOP                                                        9AP3 835
       TXL RETOP                                                        9AP3 836
       TXL     RSTOP                                                    9AP3 837
       TXI READ1                                                        9AP3 838
       TXL SYNOP                                                        9AP3 839
       TXI     READ1                                                    9AP3 840
       REM                                                              9AP3 841
 INSTR CLA LOC1           ADVANCE LOCATION                              9AP3 842
       STO LOC2           COUNTERS                                      9AP3 843
       ADD Q1                                                           9AP3 844
       STO LOC1                                                         9AP3 845
 SMR   SWT 1              IF CARD INPUT                                 9AP3 846
       TXL SM8                                                          9AP3 847
 SM8   CLA BCD            TEST FOR SYMBOL IN                            9AP3 848
       SUB MASK           LOCATION FIELD                                9AP3 849
       TZE     READ1                                                    9AP3 850
 SM7   PXD                                                              9AP3 851
       STO SYMB                                                         9AP3 852
       LXA Q6,4                                                         9AP3 853
       LDQ BCD                                                          9AP3 854
 SM3   PXD                BUILD UNIFORM                                 9AP3 855
       LGL 6              SYMBOL                                        9AP3 856
       CAS BLANK                                                        9AP3 857
       TXL SM1                                                          9AP3 858
       TXL SM2                                                          9AP3 859
       REM                                                              9AP3 860
 SM1   STO CH                                                           9AP3 861
       CAL SYMB                                                         9AP3 862
       ALS 6                                                            9AP3 863
       ADD CH                                                           9AP3 864
       SLW SYMB                                                         9AP3 865
 SM2   TIX SM3,4,1                                                      9AP3 866
       CAL SYMB                                                         9AP3 867
       ANA MASK                                                         9AP3 868
       TNZ SM4            TEST FOR INTEGER                              9AP3 869
       TSX INT,4          OBTAIN INTEGER                                9AP3 870
       STA     LOC2                                                     9AP3 871
       ADD Q1             ADVANCE LOCATION                              9AP3 872
       STA     LOC1                                                     9AP3 873
       TXI     READ1                                                    9AP3 874
       REM                                                              9AP3 875
 SM4   LDQ SYMB           MAKE ENTRY                                    9AP3 876
       PXD                                                              9AP3 877
       LGL 6                                                            9AP3 878
       TNZ SM9                                                          9AP3 879
       CAL BHEAD          TO SYMBOL AND                                 9AP3 880
 SM9   LGL 30             EQUIVALENCE TABLE                             9AP3 881
       LXD SIZE,4                                                       9AP3 882
 SML   SLW STBL,4                                                       9AP3 883
       ACL LOC2                                                         9AP3 884
       ACL CKSUM                                                        9AP3 885
       SLW CKSUM                                                        9AP3 886
       CLA LOC2                                                         9AP3 887
       STO ETBL,4                                                       9AP3 888
       TXI SM5,4,-2                                                     9AP3 889
 SM5   TXL SM6,4,STBL                                                   9AP3 890
       SXD SIZE,4         STORE SIZE INDICATION                         9AP3 891
       TXI     READ1                                                    9AP3 892
       REM                                                              9AP3 893
 SM6   HTR     READ1                                                    9AP3 894
       REM                                                              9AP3 895
 PSTOP CLA NOP                                                          9AP3 896
       STO TPCH2-2                                                      9AP3 897
       TXL READ1                                                        9AP3 898
       REM                                                              9AP3 899
 EQUOP SLN     2                                                        9AP3 900
 SYNOP TSX     SCAN,4                                                   9AP3 901
       SLT     2                                                        9AP3 902
       ORA     RBIT                                                     9AP3 903
       STO     LOC2                                                     9AP3 904
       TXL     SMR                                                      9AP3 905
       REM                                                              9AP3 906
 ORGOP TSX     SCAN,4                                                   9AP3 907
       CLM                                                              9AP3 908
 ORG1  ADD     TEQ                                                      9AP3 909
       STA     LOC1                                                     9AP3 910
       STA     LOC2                                                     9AP3 911
       TXL     SMR                                                      9AP3 912
       REM                                                              9AP3 913
 RSTOP RCDA                                                             9AP3 914
       RCHA    RST1                                                     9AP3 915
       LCHA    RST1+1                                                   9AP3 916
       CAL     RST1+1                                                   9AP3 917
       PDX     0,4                 PICK UP WORD COUNT                   9AP3 918
       TXL     READ1,4,0           EXIT ON BLANK CARD                   9AP3 919
       TCOA    *                                                        9AP3 920
       SCHA    RST1+3                                                   9AP3 921
       CLA     RST1+3                                                   9AP3 922
       STA     *+2                                                      9AP3 923
       CAL     RST1+1                                                   9AP3 924
 RST2  ACL     **,4                                                     9AP3 925
       TIX     RST2,4,1                                                 9AP3 926
       ERA     RST1+2                                                   9AP3 927
       TZE     RSTOP                                                    9AP3 928
       HTR     RSTOP                                                    9AP3 929
 RST1  IOCT    RST1+1,0,2                                               9AP3 930
       PZE                                                              9AP3 931
       PZE                                                              9AP3 932
       PZE                                                              9AP3 933
       REM                                                              9AP3 934
 DAFOP TSX DAFA,4                GET FIELD                              9AP3 935
       CLA     EQV               X                                      9AP3 936
       TPL DAFB                  COMPLEMENT ON                          9AP3 937
       CAL PBIT                  EQU MINUS                              9AP3 938
       ADD     EQV               X                                      9AP3 939
 DAFB  ANA ADDR                  SAVE                                   9AP3 940
       STO LOC2                  ADDRESS                                9AP3 941
       TXI SMR                   ENTER SYMBOL                           9AP3 942
       REM                                                              9AP3 943
 DAFA  SXA DAFC,4                INITIALIZE                             9AP3 944
       LDQ MQ                    X                                      9AP3 945
       PXD                       X                                      9AP3 946
       SLW     EQV               X                                      9AP3 947
       SLW TEQ                   X                                      9AP3 948
       TXI DAFD                  X                                      9AP3 949
       REM                                                              9AP3 950
 DAFE  PXD                       CLEAR AC                               9AP3 951
       LGL 3                     TEST FOR                               9AP3 952
       TNZ DAFF                  ZONE PUNCHES                           9AP3 953
       CLA TEQ                   ADD OCTAL                              9AP3 954
       LGL 3                     BITS                                   9AP3 955
 DAFD  STO TEQ                   SAVE                                   9AP3 956
       TIX DAFE,1,1              GO BACK                                9AP3 957
       TXI *+1,2,-1              MOVE MQ MARKER                         9AP3 958
       LDQ BCD,2                 PICK UP NEXT BCD                       9AP3 959
       TXI DAFE,1,5              WORD AND RESET IR1                     9AP3 960
       REM                                                              9AP3 961
 DAFF  LGL 3                     TEST FOR BCD                           9AP3 962
       PAX 0,4                   CHARACTER                              9AP3 963
       TXL *+2,4,31                                                     9AP3 964
       TXL DAFG,4,32             IT IS A MINUS                          9AP3 965
       TXL *+2,4,15                                                     9AP3 966
       TXL DAFH,4,16             IT IS A PLUS                           9AP3 967
 DAFC  AXT **,4                                                         9AP3 968
       CLA TEQ                   EXIT                                   9AP3 969
       ADD     EQV               X                                      9AP3 970
       STO     EQV                                                      9AP3 971
       TRA 1,4                   X                                      9AP3 972
       REM                                                              9AP3 973
 DAFG  CLA TEQ                                                          9AP3 974
       ADD     EQV                                                      9AP3 975
       STO     EQV                                                      9AP3 976
       CLA PBIT                                                         9AP3 977
       TXI DAFD                                                         9AP3 978
       REM                                                              9AP3 979
 DAFH  CLA TEQ                                                          9AP3 980
       ADD     EQV                                                      9AP3 981
       STO     EQV                                                      9AP3 982
       PXD                         CLEAR THE AC                         9AP3 983
       TXI DAFD                                                         9AP3 984
       REM                                                              9AP3 985
 LIBOP CLA     BCD                 STORE INITIAL SUBROUTINE             9AP3 986
       STO     CALL                CALL IDENTIFICATION                  9AP3 987
       SLN     4                   TWO ATTEMPT SWITCH                   9AP3 988
       TSX     SCAN,4              CHECK FOR STANDARD LIBRARY TAPE      9AP3 989
       SLT     1                   TAPE                                 9AP3 990
       TXI     *+2                                                      9AP3 991
       TXI     UNLBA                                                    9AP3 992
       TZE     STLIB               GO TO STANDARD LIB. RIUTINE          9AP3 993
       ADM     TAPEC               FORM TAPE ADDRESS                    9AP3 994
       CAS     TAPEC+1             CHECK FOR STANDARD LIB. TAPE         9AP3 995
       TXI     LIB32                                                    9AP3 996
       TXI     STLIB                                                    9AP3 997
 LIB32 CAS     LIBTS                                                    9AP3 998
       TXI     LIB35               NOT THE SAME TAPE AS LAST USED       9AP3 999
       TXI     LIB16               SAME AS LAST USED                    9AP31000
 LIB35 LDQ     LIBTS                                                    9AP31001
       SLQ     LIB18               SAVE INSTRUCTION PART                9AP31002
 LIB30 TXH                         THIS IS A SWITCH                     9AP31003
       STO     LIB30                                                    9AP31004
       STO     LIBRW                                                    9AP31005
       STA     LIB18                                                    9AP31006
       STA     LIB5                                                     9AP31007
       STA     LIB11                                                    9AP31008
       STA     LIB17+1                                                  9AP31009
       STA     LIB10                                                    9AP31010
       STA     LIB14                                                    9AP31011
       STA     LIBTS                                                    9AP31012
 LIB18 REWA    **                                                       9AP31013
       STZ     LTBL+1              CLEAR RUNNING RECORD COUNT           9AP31014
       SXD     LIBC1,0             TABLE OF CONTENTS FOR                9AP31015
       SXD     LIBC2,0             LIBRARY                              9AP31016
 LIB5  RTDA    **                                                       9AP31017
       TSX     RTX,4                                                    9AP31018
       TXI     LIB19                                                    9AP31019
       CAL     BCD+1                                                    9AP31020
       ALS     7                                                        9AP31021
       ARS     19                                                       9AP31022
       CAS     TBL                 TEST FOR TABLE RECORD                9AP31023
       TXL     LIB20                                                    9AP31024
       TXL     LIB3                                                     9AP31025
 LIB20 LXD     LIBC1,4                                                  9AP31026
       TXI     LIB21,4,STBL                                             9AP31027
 LIB21 SXD     SM5,4                                                    9AP31028
       TXL     LIB2                                                     9AP31029
 LIB3  LXA     ADDR,2              SET BEGINNING OF                     9AP31030
       LXA     Q2,1                VARIABLE FIELD                       9AP31031
       LDQ     BCD,2                                                    9AP31032
       LGL     30                                                       9AP31033
       STQ     MQ                                                       9AP31034
       PXD                                                              9AP31035
       LGL     6                                                        9AP31036
       SLW     CH                                                       9AP31037
       TSX     SCAN,4              BUILD INTERNAL TABLE                 9AP31038
       TZE     UNLIB               EXIT ON NO CARD COUNT IN TABLE CARD  9AP31039
       LXD     LIBC1,4             OF CONTENTS AS                       9AP31040
       ADD     Q1                  IDENTIFICATION AND                   9AP31041
       ADD     LTBL+1,4            COMPUTE TOTAL RECORD COUNT           9AP31042
       TXI     LIB4,4,2                                                 9AP31043
 LIB4  STO     LTBL+1,4            STORE TOTAL RECORD COUNT FOR THIS    9AP31044
       CLA     BCD                                                      9AP31045
       STO     LTBL+2,4                                                 9AP31046
       SXD     LIBC1,4                                                  9AP31047
       TXL     LIB5                                                     9AP31048
 LIB2  LXD     LIBC2,4             TEST FOR NEED TO                     9AP31049
 LIB16 SYN     LIB2                                                     9AP31050
       TXI     LIB6,4,2            POSITION TAPE                        9AP31051
 LIB6  SXD     LIBC2,4                                                  9AP31052
       CLA     CALL                                                     9AP31053
       CAS     LTBL+2,4                                                 9AP31054
       TXL     LIB7                                                     9AP31055
       TXL     LIB17                                                    9AP31056
 LIB7  LXD     LIBC1,2             SEARCH TABLE OF                      9AP31057
 LIB8  CAS     LTBL+2,2            CONTENTS TO DETERMINE                9AP31058
       TRA     *+2                 POSITION OF DESIRED                  9AP31059
       TRA     LIB9                SUBROUTINE                           9AP31060
       TIX     *-3,2,2                                                  9AP31061
 LIB19 SLT     4                   TEST FOR DOUBLE LIB FAITURE          9AP31062
       TXI     UNLIB               DOUBLE LIB FAILURE                   9AP31063
       CLA     TAPEC+1                                                  9AP31064
       CAS     LIB30                                                    9AP31065
       TRA     LIB18                                                    9AP31066
       TRA     LIB38                                                    9AP31067
       TRA     LIB18                                                    9AP31068
LIB9   CLA     LTBL+3,2                                                 9AP31069
       SUB     LTBL+3,4                                                 9AP31070
       SXD     LIBC2,2             TAPE MUST BE MOVED                   9AP31071
       TPL     LIB1A               DETERMINE DIRECTION                  9AP31072
 LIB11 BSRA    **                                                       9AP31073
       ADD     Q1                                                       9AP31074
       TNZ     LIB11                                                    9AP31075
 LIB17 PXD                                                              9AP31076
       BSRA    **                                                       9AP31077
 LIB10 RTDA    **                                                       9AP31078
       TSX     RTX,4                                                    9AP31079
       TXI     LIB19               END OF FILE EXIT                     9AP31080
 LIB1A SUB     Q1                                                       9AP31081
       TPL     LIB10                                                    9AP31082
       CLA     BCD                 CHECK POSITIONING                    9AP31083
       SUB     CALL                                                     9AP31084
       TNZ     LIB19                                                    9AP31085
       CLA     LIBC1               SET LIB AND END                      9AP31086
       STA     LIBT                CONTROL TRANSFERS                    9AP31087
       STA     ENDT                                                     9AP31088
       CLA     LIBC4                                                    9AP31089
       STO     READ1+2                                                  9AP31090
       STO     READ2                                                    9AP31091
       STP     SMR                                                      9AP31092
 PLR1  TXL     LIB14                                                    9AP31093
       BSRB    2                                                        9AP31094
 LIB14 RTDA    **                                                       9AP31095
       TSX     RTX,4                                                    9AP31096
       HTR     *-2                                                      9AP31097
       TRA     RTD4                RETURN TO FIRST PESS                 9AP31098
 LIB36 BSRB    2                                                        9AP31099
 PLR2  TXL     PLR4,,12                                                 9AP31100
 LIB15 CLA     LIBC3               RESTORE END CONTROL                  9AP31101
       STA     ENDT                TRANSFER                             9AP31102
       CLA     LIBC2                                                    9AP31103
       STA     LIBT                AT CONTROL TRANSFER                  9AP31104
       STP     SMR                                                      9AP31105
       CLA     SMR                                                      9AP31106
       STO     READ1+2                                                  9AP31107
       STO     READ2                                                    9AP31108
 LIB37 TXL     READ1                                                    9AP31109
       STA     LIBTS               START FRESH AFTER ERROR              9AP31110
       CLS     LIB37               RESET UNLIB SWITCH                   9AP31111
       STO     LIB37                                                    9AP31112
       TXI     READ1                                                    9AP31113
 UNLIB CLS     LIB37               SET UNLIB SWITCH                     9AP31114
       STO     LIB37                                                    9AP31115
       BSRB    2                                                        9AP31116
       TXI     LIB15                                                    9AP31117
 UNLBA BSRB    2                                                        9AP31118
 LIBTC TXI     READ1,0,11                                               9AP31119
 LIB40 CLA     TAPEC+1                                                  9AP31120
       CAS     LIBTS               SAME TAPE AS LAST USED QUEST.        9AP31121
       TRA     *+2                                                      9AP31122
       TRA     LIB16                                                    9AP31123
 LIB38 LXD     BINRD,2                                                  9AP31124
       TXH     LIB35,2,0                                                9AP31125
       LXD     LIB41,2                                                  9AP31126
 LIB41 TXH     LIB42+1,,BINR+4                                          9AP31127
       CAL     BINRD                                                    9AP31128
       STP     *-2                                                      9AP31129
       STO     BINRD                                                    9AP31130
 LIB42 TXI     *+2,2,-BINRD-1                                           9AP31131
       REWA    LIBTP                                                    9AP31132
       CLA     TAPEC+1                                                  9AP31133
       LDQ     NOP                                                      9AP31134
       SLQ     LIB18                                                    9AP31135
       TNX     LIB30+1,2,1                                              9AP31136
       RTDA    LIBTP                                                    9AP31137
       TRA     *-2                                                      9AP31138
 PLR4  WTDB    2                                                        9AP31139
       LXD     PLR2,4                                                   9AP31140
       RCHB    PLR7                                                     9AP31141
       TCOB    *                                                        9AP31142
       TXI     LIB15                                                    9AP31143
 LIBC  BCD 1 LIB                                                        9AP31144
 TAPEC REWA    **                                                       9AP31145
       REWA    LIBTP                                                    9AP31146
 LIBTS REWA    **                                                       9AP31147
 LIBC1         LIB36                                                    9AP31148
 LIBC2         LIBOP                                                    9AP31149
 LIBC3 TXL     ENDOP                                                    9AP31150
 LIBC4 TXL     LIB14                                                    9AP31151
 PLR7  IOCP    BLANKS,0,1                                               9AP31152
       IOCP    LIBC,0,1                                                 9AP31153
       IOCD    BLANKS,0,12                                              9AP31154
 CALL  PZE                         STORAGE FOR LIBRARY SUBROUTINE NAME  9AP31155
 BINRD TXL     0,0,1                                                    9AP31156
 LIBTP EQU     9                                                        9AP31157
 LTBL  EQU     -1                                                       9AP31158
 BINR  EQU     5                                                        9AP31159
 STLIB SYN     LIB40                                                    9AP31160
       REM                                                              9AP31161
 RTX   TEFA    RTX+1               RESET END OF FILE INDICATOR IF ON    9AP31162
       STO     TEQ                 SAVE AC FOR LIB. RECORD COUNT        9AP31163
       CLA     -1,4                PICK UP SELECT ADDRESS               9AP31164
       STA     RTX5                INSERT ADDRESS IN BACKSPACE AND READ 9AP31165
       STA     RTX6                INSTRUCTIONS                         9AP31166
       STZ     RTX4                RESET REDUNDENCY ERROR COUNTER       9AP31167
 RTX7  RCHA    RTX1                                                     9AP31168
       CLA     TEQ                 RESTORE AC FOR LIB. RECORD COUNT     9AP31169
       TCOA    *                   WAIT                                 9AP31170
       TEFA    RTX2                END OF FILE EXIT                     9AP31171
       TRCA    RTX3                REDUNDENCY ERROR ROUTINE             9AP31172
       TRA     2,4                 NORMAL EXIT                          9AP31173
 RTX1  IORT    BCD,0,14                                                 9AP31174
 RTX4  PZE                         COUNTER FOR REDUNDENCY ERRORS        9AP31175
 RTX2  TRA     1,4                 END OF FILE EXIT                     9AP31176
 RTX3  CLA     RTX4                COUNT REDUNDENCY ERRORS THIS RECORD  9AP31177
       ADD     Q1                  X                                    9AP31178
       STO     RTX4                X                                    9AP31179
       SUB     Q4                  TEST FOR FIFTH ERROR                 9AP31180
       TNZ     RTX5                GO ON AND REREAD THE RECORD          9AP31181
       HPR                         STOP AND ACCEPT FIFTH READING        9AP31182
       CLA     TEQ                 RESTORE AC FOR LIB. RECORD COUNT     9AP31183
       TRA     2,4                                                      9AP31184
 RTX5  BSRA    **                                                       9AP31185
 RTX6  RTDA    **                                                       9AP31186
       TXI     RTX7                                                     9AP31187
       REM                                                              9AP31188
 PLROP CLS     PLR1                                                     9AP31189
       STO     PLR1                                                     9AP31190
       CLS     PLR2                                                     9AP31191
       STO     PLR2                                                     9AP31192
       TXI     READ1                                                    9AP31193
       REM                                                              9AP31194
 BSSOP TSX SCAN,4         INCREMENT LOCATION                            9AP31195
       CLA LOC1           COUNTER AND                                   9AP31196
       STO LOC2           MAKE ENTRY IN                                 9AP31197
       ADD TEQ                                                          9AP31198
       STO LOC1                                                         9AP31199
       TXL SMR                                                          9AP31200
       REM                                                              9AP31201
 BESOP TSX SCAN,4         INCREMENT LOCATION                            9AP31202
       CLA LOC1           COUNTER AND MAKE                              9AP31203
       TXL ORG1                                                         9AP31204
       REM                                                              9AP31205
 HEDOP CLM                ESTABLISH BLOCK                               9AP31206
       LDQ BCD            HEADING                                       9AP31207
       LGL 6                                                            9AP31208
       SLW BHEAD                                                        9AP31209
       TXL READ1                                                        9AP31210
       REM                                                              9AP31211
 OCTOP LXA Q1,4                                                         9AP31212
       TNX OCT6,1,1                                                     9AP31213
 OCT1  PXD                                                              9AP31214
       LGL 6                                                            9AP31215
       CAS Q8                                                           9AP31216
       TXL OCT2                                                         9AP31217
       TXL OCT3                                                         9AP31218
 OCT5  TIX OCT1,1,1                                                     9AP31219
 OCT6  TXI OCT4,2,-1                                                    9AP31220
 OCT4  LDQ BCD,2                                                        9AP31221
       TXI OCT1,1,5                                                     9AP31222
       REM                                                              9AP31223
 OCT2  CAS COMMA          COUNT NUMBER OF                               9AP31224
       TXL OCT3           OCTAL DATA WORDS                              9AP31225
       TXI OCT5,4,1                                                     9AP31226
       CAS MINUS                                                        9AP31227
       TXL OCT3                                                         9AP31228
       TXL OCT5                                                         9AP31229
       CAS PLUS                                                         9AP31230
       TXL OCT3                                                         9AP31231
       TXL OCT5                                                         9AP31232
 OCT3  CLA LOC1           SET LOCATION                                  9AP31233
       STO LOC2           COUNTER 2                                     9AP31234
       PXD 0,4            ADVANCE LOCATION                              9AP31235
       ARS 18             COUNTER AND                                   9AP31236
       ADD LOC1           MAKE ENTRY IN                                 9AP31237
       STO LOC1           SYMBOL TABLE IF                               9AP31238
       TXL SMR            NECESSARY                                     9AP31239
       REM                                                              9AP31240
 BCIOP CLA LOC1                                                         9AP31241
       STO LOC2                                                         9AP31242
       ADM CH                                                           9AP31243
       STO LOC1                                                         9AP31244
       TXL SMR                                                          9AP31245
       REM                                                              9AP31246
 BCDOP CLA LOC1           STORE LOCATION                                9AP31247
       STO LOC2           COUNTER                                       9AP31248
       CAL BCD+1                                                        9AP31249
       LRS 6                                                            9AP31250
       CLM                                                              9AP31251
       LLS 6                                                            9AP31252
       CAS Q10                                                          9AP31253
       TXL BCD1                                                         9AP31254
       TXH                                                              9AP31255
 BCD2  ADD LOC1           ADVANCE LOCATION COUNTER                      9AP31256
       STO LOC1           AND ENTER SYMBOL                              9AP31257
       TXL SMR            IN TABLE IF NECESSARY                         9AP31258
       REM                                                              9AP31259
 BCD1  CLA Q10            ASSUME WORD COUNT OF                          9AP31260
       TXL BCD2           10 IF NONE GIVEN                              9AP31261
       REM                                                              9AP31262
 REPOP TSX SCAN,4         OBTAIN M                                      9AP31263
       STO M                                                            9AP31264
       TSX SCAN,4         OBTAIN N                                      9AP31265
       STO N                                                            9AP31266
       LDQ M                                                            9AP31267
       MPY N              COMPUTE NUMBER OF                             9AP31268
       STQ TEQ            LOCATIONS USED                                9AP31269
       CLA LOC1           AND MODIFY                                    9AP31270
       STO LOC2           LOCATION COUNTER                              9AP31271
       ADD TEQ                                                          9AP31272
       STO LOC1                                                         9AP31273
       TXL SMR            ENTER SYMBOL                                  9AP31274
       REM                                                              9AP31275
 BGNOP TSX SCAN,4                                                       9AP31276
       TSX SCAN,4                                                       9AP31277
       LRS 3                                                            9AP31278
       CLA Q0                                                           9AP31279
       LXA Q3,4                                                         9AP31280
       RND                                                              9AP31281
       RQL 1                                                            9AP31282
       TIX BGNOP+5,4,1                                                  9AP31283
       ALS 1                                                            9AP31284
       STO SAVE                                                         9AP31285
       TSX SCAN,4                                                       9AP31286
       STO SAVE+1                                                       9AP31287
       ALS 1                                                            9AP31288
       ADD SAVE+1                                                       9AP31289
       ADD SAVE                                                         9AP31290
       ADD Q2                                                           9AP31291
       STO TEQ                                                          9AP31292
       CLA LOC1                                                         9AP31293
       STO LOC2                                                         9AP31294
       ADD TEQ                                                          9AP31295
       STO LOC1                                                         9AP31296
       CLA SAVE+1                                                       9AP31297
       ADD Q1                                                           9AP31298
       ALS 15                                                           9AP31299
       ADD LOC2                                                         9AP31300
       STO LOC2                                                         9AP31301
       TXL SMR                                                          9AP31302
       REM                                                              9AP31303
 ERROP CLA LOC1                                                         9AP31304
       STO LOC2                                                         9AP31305
       ADD Q1                                                           9AP31306
       STO LOC1                                                         9AP31307
       TSX SCAN,4                                                       9AP31308
       CLA CH                                                           9AP31309
       SUB BLANK                                                        9AP31310
       TZE SMR                                                          9AP31311
       TSX SCAN,4                                                       9AP31312
       CAL SYMB                                                         9AP31313
       TZE SMR                                                          9AP31314
       CLA LOC1                                                         9AP31315
       ADD Q1                                                           9AP31316
       STO LOC1                                                         9AP31317
       TXL SMR                                                          9AP31318
       REM                                                              9AP31319
 RETOP CLA LOC1                                                         9AP31320
       STO LOC2                                                         9AP31321
       ADD Q1                                                           9AP31322
       STO LOC1                                                         9AP31323
       TSX SCAN,4                                                       9AP31324
       CLA CH                                                           9AP31325
       SUB BLANK                                                        9AP31326
       TZE SMR                                                          9AP31327
       TSX SCAN,4                                                       9AP31328
       CAL SYMB                                                         9AP31329
       TZE SMR                                                          9AP31330
       LXD SIZE,4                                                       9AP31331
       SLW STBL,4                                                       9AP31332
       ACL LOC1                                                         9AP31333
       ACL CKSUM                                                        9AP31334
       SLW CKSUM                                                        9AP31335
       CLA LOC1                                                         9AP31336
       STO ETBL,4                                                       9AP31337
       TXI RET1,4,-2                                                    9AP31338
 RET1  TXL SM6,4,STBL                                                   9AP31339
       SXD SIZE,4                                                       9AP31340
       CLA LOC1                                                         9AP31341
       ADD Q3                                                           9AP31342
       STO LOC1                                                         9AP31343
       TXL SMR                                                          9AP31344
       REM                                                              9AP31345
 DECOP CLA LOC1           SAVE CURRENT LOCATION                         9AP31346
       STO LOC2                                                         9AP31347
       LDQ MQ                                                           9AP31348
 DEC4  CLA LOC1           COMPUTE NEXT LOCATION                         9AP31349
       ADD Q1                                                           9AP31350
       STO LOC1                                                         9AP31351
       TIX DEC1,1,1       TEST CHARACTER COUNT                          9AP31352
       TXI DEC2,2,-1      OBTAIN NEXT GROUP                             9AP31353
 DEC1  PXD                OBTAIN NEXT CHARACTER                         9AP31354
       LGL 6                                                            9AP31355
       CAS TEN            TEST FOR DIGIT                                9AP31356
       TXL DEC3                                                         9AP31357
       TXL SMR                                                          9AP31358
 DEC5  TIX DEC1,1,1       TEST CHARACTER COUNT                          9AP31359
       TXI DEC2,2,-1      OBTAIN NEXT GROUP                             9AP31360
 DEC2  LDQ BCD,2                                                        9AP31361
       TXI DEC1,1,5                                                     9AP31362
       REM                                                              9AP31363
 DEC3  CAS COMMA          TEST FOR ,                                    9AP31364
       TXL SMR                                                          9AP31365
       TXL DEC4                                                         9AP31366
       CAS MINUS          TEST FOR -                                    9AP31367
       TXL SMR                                                          9AP31368
       TXL DEC5                                                         9AP31369
       CAS POINT          TEST FOR .                                    9AP31370
       TXL SMR                                                          9AP31371
       TXL DEC5                                                         9AP31372
       CAS E              TEST FOR E                                    9AP31373
       TXL SMR                                                          9AP31374
       TXL DEC5                                                         9AP31375
       CAS B              TEST FOR B                                    9AP31376
       TXL SMR                                                          9AP31377
       TXL DEC5                                                         9AP31378
       CAS PLUS           TEST FOR +                                    9AP31379
       TXL SMR                                                          9AP31380
       TXL DEC5                                                         9AP31381
       TXL SMR                                                          9AP31382
       REM                                                              9AP31383
 ENDOP WEFB **                                                          9AP31384
       REWB **                                                          9AP31385
 LIBRW NOP                                                              9AP31386
       SWT 5                                                            9AP31387
       TXL EJECT                                                        9AP31388
       TXL RETRA                                                        9AP31389
       REM                                                              9AP31390
 BCD1R BCD 11                                                           9AP31391
       REM                                                              9AP31392
 EJECT WTDB 3                                                           9AP31393
       RCHB RCW5                                                        9AP31394
       TCOB *                                                           9AP31395
 RETRA SWT 3                                                            9AP31396
       TXL END2                                                         9AP31397
       REM                                                              9AP31398
 BOARD WPRA                                                             9AP31399
       LXD BRD1,4                                                       9AP31400
 BRD3  TXH BRD2,4                                                       9AP31401
       HTR BOARD     WRONG BOARD                                        9AP31402
       REM                                                              9AP31403
 BRD2  SPRA 7                                                           9AP31404
       SPTA                                                             9AP31405
 BRD1  NOP            TXI BRD3,4,-1                                     9AP31406
       SPRA 1                                                           9AP31407
 END2  LXD SIZE,4                                                       9AP31408
       PXD 0,4                                                          9AP31409
       TZE LOAD                                                         9AP31410
       COM                                                              9AP31411
       PDX 0,4                                                          9AP31412
       PXD 0,4                                                          9AP31413
       ARS 18                                                           9AP31414
       LXA Q1,4                                                         9AP31415
 END3  ARS 1                                                            9AP31416
       TZE END3+3                                                       9AP31417
       TXI END3,4,1                                                     9AP31418
       PXD 0,4                                                          9AP31419
       ARS 17                                                           9AP31420
       STA SIZE                                                         9AP31421
       REM                                                              9AP31422
 SORT  CLA SIZE           SETUP SORTING                                 9AP31423
       STD SORT3                                                        9AP31424
       LXD SORT5,4                                                      9AP31425
       SXD SORT1,4                                                      9AP31426
 SORT8 LXD SORT1,4        SET FIRST ELEMENT                             9AP31427
       SXD SORT2,4                                                      9AP31428
 SORT6 CLA STBL,4         FORWARD PASS                                  9AP31429
       LDQ STBL-2,4       COMPARISON                                    9AP31430
       TLQ SORT5                                                        9AP31431
       STO STBL-2,4       INTERCHANGE SYMBOLS                           9AP31432
       STQ STBL,4                                                       9AP31433
       CLA ETBL,4                                                       9AP31434
       LDQ ETBL-2,4       EQUIVALENCES                                  9AP31435
       STO ETBL-2,4                                                     9AP31436
       STQ ETBL,4                                                       9AP31437
       SXD SORT2,4        NOTE LOCATION                                 9AP31438
 SORT5 TXI SORT3,4,-2     INCREASE LOCATION                             9AP31439
 SORT3 TXH SORT6,4                                                      9AP31440
       CLA SORT1          TEST FOR END                                  9AP31441
       CAS SORT2          OF SORT                                       9AP31442
 SORT1 TXL SORT7                                                        9AP31443
 SORT2 TXL SORT7                                                        9AP31444
       SUB SORT0                                                        9AP31445
       STD SORT4                                                        9AP31446
       LXD SORT2,4                                                      9AP31447
       SXD SORT3,4        SET LAST ELEMENT                              9AP31448
 SORT4 TXH SORT8,4                                                      9AP31449
       CLA STBL-2,4       REVERSE PASS                                  9AP31450
       LDQ STBL-4,4       COMPARISON                                    9AP31451
       TLQ SORT9                                                        9AP31452
       STO STBL-4,4       INTERCHANGE                                   9AP31453
       STQ STBL-2,4       SYMBOLS                                       9AP31454
       CLA ETBL-2,4       INTERCHANGE                                   9AP31455
       LDQ ETBL-4,4       EQUIVALENCES                                  9AP31456
       STO ETBL-4,4                                                     9AP31457
       STQ ETBL-2,4                                                     9AP31458
       SXD SORT1,4                                                      9AP31459
 SORT9 TXI SORT4,4,2      DECREASE LOCATION                             9AP31460
       REM                                                              9AP31461
 SORT7 LXD SIZE,4         COMPUTE LIMITS                                9AP31462
       SXD SUMEX,4                                                      9AP31463
       PXD                                                              9AP31464
       PDX 0,2                                                          9AP31465
 SUMTB ACL STBL,2                                                       9AP31466
       ACL ETBL,2                                                       9AP31467
       TXI SUMEX,2,-2                                                   9AP31468
 SUMEX TXH SUMTB,2                                                      9AP31469
       SLW EQV                                                          9AP31470
       CLA EQV                                                          9AP31471
       CAS CKSUM                                                        9AP31472
       TXL SUMST                                                        9AP31473
       TXI TPCH1,4,-SIZE-2                                              9AP31474
 SUMST HTR LOAD                                                         9AP31475
       REM                                                              9AP31476
*                                                                       9AP31477
 TPCH1 PXD 0,4            TABLE                                         9AP31478
       COM                                                              9AP31479
       PDX 0,4                                                          9AP31480
       SXD TPCH2,4                                                      9AP31481
       TRA TPCH3                                                        9AP31482
       TSX ABPCH,4        PUNCH TABLE                                   9AP31483
 TPCH2 HTR SIZE                                                         9AP31484
       HPR SIZE                                                         9AP31485
       WPUA                                                             9AP31486
       WPUA                                                             9AP31487
 TPCH3 CLA SIZE                                                         9AP31488
       STD DUP1           SET TABLE LIMIT                               9AP31489
       STD DUP2                                                         9AP31490
       LXD DUP13,1                                                      9AP31491
 DUP1  TXL LOAD,1         TEST FOR END OF TABLE                         9AP31492
       CLA STBL,1         LOOK FOR DUPLICATE                            9AP31493
       CAS STBL-2,1       SYMBOLS                                       9AP31494
       TXI DUP1,1,-2                                                    9AP31495
       TXL DUP3                                                         9AP31496
 DUP13 TXI DUP1,1,-2                                                    9AP31497
       REM                                                              9AP31498
 DUP3  LXA Q5,4                                                         9AP31499
       LDQ STBL,1         OBTAIN SYMBOL                                 9AP31500
       PXD                AND SHIFT HEADING                             9AP31501
       LGL 6              CHARACTER                                     9AP31502
       TNZ DUP5                                                         9AP31503
       CLA BLANK                                                        9AP31504
 DUP5  LGL 6                                                            9AP31505
       SLW OCTAL          STORE PARTIAL SYMBOL                          9AP31506
       ANA DUPM                                                         9AP31507
       TNZ DUP4                                                         9AP31508
       CLA BLANK          REPLACE LEADING                               9AP31509
       ORA OCTAL          ZERLES BY BLANKS                              9AP31510
       TIX DUP5,4,1                                                     9AP31511
       TXL DUP6                                                         9AP31512
       REM                                                              9AP31513
 DUP4  TNX DUP6,4,1                                                     9AP31514
       CAL OCTAL                                                        9AP31515
 DUP7  LGL 6              SYMBOL                                        9AP31516
       TIX DUP7,4,1                                                     9AP31517
 DUP6  SLW OCTAL                                                        9AP31518
       CLA LMT1                                                         9AP31519
       STO LMT            AND PROVIDE BLANK                             9AP31520
       LXD DUP14,2        BETWEEN SYMBOL AND                            9AP31521
       CAL BLANK          FIRST EQUIVALENCE                             9AP31522
 DUP12 LDQ ETBL-2,1                                                     9AP31523
       RQL 21                                                           9AP31524
       LXA Q5,4           PUT EQUIVALENCE IN                            9AP31525
 DUP8  ALS 3              6 BIT CODE                                    9AP31526
       LGL 3                                                            9AP31527
       TIX DUP8,4,1                                                     9AP31528
 DUP11 SLW OCTAL+16,2                                                   9AP31529
 DUP2  TXL DUP9,1         TEST FOR END OF TABLE                         9AP31530
       CLA STBL,1         SEARCH FOR FURTHER                            9AP31531
       CAS STBL-2,1       DUPLICATION OF THIS                           9AP31532
       TXI DUP9,2,-1                                                    9AP31533
       TXI DUP10,1,-2                                                   9AP31534
       TXI DUP9,2,-1                                                    9AP31535
 DUP9  PXD 0,2            PRINT DUPLICATIONS                            9AP31536
       STO EQV            FOR THIS SYMBOL                               9AP31537
       ARS 18                                                           9AP31538
       ADD EQV                                                          9AP31539
       SBM LMT                                                          9AP31540
       STO LMT                                                          9AP31541
       TSX WOT,4                                                        9AP31542
       TXI DUP1,1,-2                                                    9AP31543
       REM                                                              9AP31544
 DUP10 CAL COMMA          PROVIDE COMMA                                 9AP31545
       TIX DUP12,2,1      BETWEEN EQUIVALENCES                          9AP31546
       TSX WOT,4          PRINTIF MORE THAN                             9AP31547
 DUP14 TXL DUP6,0,15      15 EQUIVALENCES                               9AP31548
       REM                                                              9AP31549
 DUPM      63                                                           9AP31550
       REM                                                              9AP31551
 LOAD  RTBB    1                                                        9AP31552
       RCHB    LOAD+4                                                   9AP31553
       LCHB    0                                                        9AP31554
       TXI     1                                                        9AP31555
       IOCT    0,0,3                                                    9AP31556
       REM                                                              9AP31557
 SORT0 TXL 0,0,2                                                        9AP31558
 NOP   NOP                                                              9AP31559
       REM                                                              9AP31560
       REM                                                              9AP31561
 EOFA  SWT     3                                                        9AP31562
       TXL     *+3                                                      9AP31563
       WPRA                                                             9AP31564
       SPRA    1                                                        9AP31565
       REWB    1                                                        9AP31566
       SWT     2                                                        9AP31567
       TXL     *+3                                                      9AP31568
       HPR     -1                                                       9AP31569
       TXL     *-1                                                      9AP31570
       SWT     5                                                        9AP31571
       WEFB    3                                                        9AP31572
       TXL     *-4                                                      9AP31573
       REM                                                              9AP31574
       REM                                                              9AP31575
 RCW4  IOCT    BCD,0,14                                                 9AP31576
 RCW5  IORT BCD1R,0,1                                                   9AP31577
 WTDA  EQU RTDB                                                         9AP31578
BLANKS SYN MASK                                                         9AP31579
 TEN   SYN Q10                                                          9AP31580
 TBL   BCI     1,000TBL                                                 9AP31581
       REM                                                              9AP31582
       REM                                                              9AP31583
       REM                                                              9AP31584
 INPUT RTDA 1                      ARTD,RTTC,RTTB,RTD INITIALIZED       9AP31585
 INTER RTDB 2                      B15+2,START,RTDB,RTD4,ENDOP,ENDOP+1  9AP31586
OUTPUT RTDB 3                      WOT+1,EJECT HERE INITIALIZED         9AP31587
       REM                                                              9AP31588
       REM                                                              9AP31589
       REM                                                              9AP31590
       ORG     2200              THE NEW DAP OP TABLE                   9AP31591
 OPSIZ PZE     20,0,-866   -716                                         9AP31592
                                                                        9AP31593
       REM                                                              9AP31594
 OPTBL BCD 1ZET000        STORAGE ZERO TEST                             9AP31595
       OCT +052000000000  ZET                                           9AP31596
       BCD 1XEC000        EXECUTE                                       9AP31597
       OCT +052200000000  XEC                                           9AP31598
       BCD 1XCL000        EXCHANGE LOGICAL ACCUMULATOR AND MQ           9AP31599
       OCT -013000000000  XCL                                           9AP31600
       BCD 1XCA000        EXCHANGE ACCUMULATOR AND MQ                   9AP31601
       OCT +013100000000  XCA                                           9AP31602
       BCD 1WTV000        WRITE CATHODE RAY TUBE                        9AP31603
       OCT +076600000030  WTV                                           9AP31604
       BCD 1WTS000        WRITE TAPE SIMULTANEOUS 704                   9AP31605
       OCT 76600000320    WTS 704 INSTRUCTION                           9AP31606
       BCD 1WTDH00        WRITE TAPE DECIMAL, CHANNEL H                 9AP31607
       OCT +076600010200  WTDH                                          9AP31608
       BCD 1WTDG00        WRITE TAPE DECIMAL, CHANNEL G                 9AP31607
       OCT +076600007200  WTDG                                          9AP31608
       BCD 1WTDF00        WRITE TAPE DECIMAL, CHANNEL F                 9AP31607
       OCT +076600006200  WTDF                                          9AP31608
       BCD 1WTDE00        WRITE TAPE DECIMAL, CHANNEL E                 9AP31609
       OCT +076600005200  WTDE                                          9AP31610
       BCD 1WTDD00        WRITE TAPE DECIMAL, CHANNEL D                 9AP31611
       OCT +076600004200  WTDD                                          9AP31612
       BCD 1WTDC00        WRITE TAPE DECIMAL, CHANNEL C                 9AP31613
       OCT +076600003200  WTDC                                          9AP31614
       BCD 1WTDB00        WRITE TAPE DECIMAL, CHANNEL B                 9AP31615
       OCT +076600002200  WTDB                                          9AP31616
       BCD 1WTDA00        WRITE TAPE DECIMAL, CHANNEL A                 9AP31617
       OCT +076600001200  WTDA                                          9AP31618
       BCD 1WTD000        WRITE TAPE DECIMAL 704                        9AP31619
       OCT 76600000200    WTD 704 INSTRUCTION                           9AP31620
       BCD 1WTBH00        WRITE TAPE BINARY, CHANNEL H                  9AP31621
       OCT +076600010220  WTBF                                          9AP31622
       BCD 1WTBG00        WRITE TAPE BINARY, CHANNEL G                  9AP31621
       OCT +076600007220  WTBF                                          9AP31622
       BCD 1WTBF00        WRITE TAPE BINARY, CHANNEL F                  9AP31621
       OCT +076600006220  WTBF                                          9AP31622
       BCD 1WTBE00        WRITE TAPE BINARY, CHANNEL E                  9AP31623
       OCT +076600005220  WTBE                                          9AP31624
       BCD 1WTBD00        WRITE TAPE BINARY, CHANNEL D                  9AP31625
       OCT +076600004220  WTBD                                          9AP31626
       BCD 1WTBC00        WRITE TAPE BINARY, CHANNEL C                  9AP31627
       OCT +076600003220  WTBC                                          9AP31628
       BCD 1WTBB00        WRITE TAPE BINARY, CHANNEL B                  9AP31629
       OCT +076600002220  WTBB                                          9AP31630
       BCD 1WTBA00        WRITE TAPE BINARY, CHANNEL A                  9AP31631
       OCT +076600001220  WTBA                                          9AP31632
       BCD 1WTB000        WRITE TAPE BINARY 704                         9AP31633
       OCT 76600000220    WTB 704 INSTRUCTION                           9AP31634
       BCD 1WRS000        WRITE SELECT                                  9AP31635
       OCT +076600000000  WRS                                           9AP31636
       BCD 1WPUE00        WRITE PUNCH, CHANNEL E                        9AP31637
       OCT +076600005341  WPUE                                          9AP31638
       BCD 1WPUC00        WRITE PUNCH, CHANNEL C                        9AP31639
       OCT +076600003341  WPUC                                          9AP31640
       BCD 1WPUA00        WRITE PUNCH, CHANNEL A                        9AP31641
       OCT +076600001341  WPUA                                          9AP31642
       BCD 1WPU000   WRITE PUNCH 704                                    9AP31643
       OCT 76600000341 WPU 704 INSTRUCTION                              9AP31644
       BCD 1WPRE00        WRITE PRINTER, CHANNEL E                      9AP31645
       OCT +076600005361  WPRE                                          9AP31646
       BCD 1WPRC00        WRITE PRINTER, CHANNEL C                      9AP31647
       OCT +076600003361  WPRC                                          9AP31648
       BCD 1WPRA00        WRITE PRINTER, CHANNEL A                      9AP31649
       OCT +076600001361  WPRA                                          9AP31650
       BCD 1WPR000   WRITE PRINTER 704                                  9AP31651
       OCT 76600000361 WPR 704 INSTRUCTION                              9AP31652
       BCD 1WPDE00   WRITE PRNTR DEC, CHAN E                            9AP31653
       OCT 076600005361 WPDE                                            9AP31654
       BCD 1WPDC00   WRITE PRNTR DEC, CHAN C                            9AP31655
       OCT 076600003361 WPDC                                            9AP31656
       BCD 1WPDA00   WRITE PRNTR DEC. CHAN A                            9AP31657
       OCT 076600001361 WPDA                                            9AP31658
       BCD 1WPBE00   WRITE PRNTR BIN, CHAN E                            9AP31659
       OCT +076600005362 WPBE                                           9AP31660
       BCD 1WPBC00   WRITE PRNTR BIN, CHAN C                            9AP31661
       OCT +076600003362 WPBC                                           9AP31662
       BCD 1WPBA00   WRITE PRNTR BIN, CHAN A                            9AP31663
       OCT +076600001362 WPBA                                           9AP31664
       BCD 1WFDH00   WRITE EOF DEC, CHAN H                              9AP31665
       OCT +077000010200 WFDH                                           9AP31666
       BCD 1WFDG00   WRITE EOF DEC, CHAN G                              9AP31665
       OCT +077000007200 WFDG                                           9AP31666
       BCD 1WFDF00   WRITE EOF DEC, CHAN F                              9AP31665
       OCT +077000006200 WFDF                                           9AP31666
       BCD 1WFDE00   WRITE EOF DEC, CHAN E                              9AP31667
       OCT +077000005200 WFDE                                           9AP31668
       BCD 1WFDD00   WRITE EOF DEC, CHAN D                              9AP31669
       OCT +077000004200 WFDD                                           9AP31670
       BCD 1WFDC00   WRITE EOF DEC, CHAN C                              9AP31671
       OCT +077000003200 WFDC                                           9AP31672
       BCD 1WFDB00   WRITE EOF DEC, CHAN B                              9AP31673
       OCT +077000002200 WFDB                                           9AP31674
       BCD 1WFDA00   WRITE EOF DEC, CHAN A                              9AP31675
       OCT +077000001200 WFDA                                           9AP31676
       BCD 1WFBH00   WRITE EOF BIN, CHAN H                              9AP31677
       OCT +077000010220 WFBG                                           9AP31678
       BCD 1WFBG00   WRITE EOF BIN, CHAN G                              9AP31677
       OCT +077000007220 WFBF                                           9AP31678
       BCD 1WFBF00   WRITE EOF BIN, CHAN F                              9AP31677
       OCT +077000006220 WFBF                                           9AP31678
       BCD 1WFBE00   WRITE EOF BIN, CHAN E                              9AP31679
       OCT +077000005220 WFBE                                           9AP31680
       BCD 1WFBD00   WRITE EOF BIN, CHAN D                              9AP31681
       OCT +077000004220 WFBD                                           9AP31682
       BCD 1WFBC00   WRITE EOF BIN, CHAN C                              9AP31683
       OCT +077000003220 WFBC                                           9AP31684
       BCD 1WFBB00   WRITE EOF BIN, CHAN B                              9AP31685
       OCT +077000002220 WFBB                                           9AP31686
       BCD 1WFBA00   WRITE EOF BIN, CHAN A                              9AP31687
       OCT +077000001220 WFBA                                           9AP31688
       BCD 1WEFF00   WRITE EOF CHAN F                                   9AP31689
       OCT 77000006200 WEFF OBSOLETE 709                                9AP31690
       BCD 1WEFE00   WRITE EOF CHAN E                                   9AP31691
       OCT 77000005200 WEFE OBSOLETE 709                                9AP31692
       BCD 1WEFD00   WRITE EOF CHAN D                                   9AP31693
       OCT 77000004200 WEFD OBSOLETE 709                                9AP31694
       BCD 1WEFC00   WRITE EOF CHAN C                                   9AP31695
       OCT 77000003200 WEFC OBSOLETE 709                                9AP31696
       BCD 1WEFB00   WRITE EOF CHAN B                                   9AP31697
       OCT 77000002200 WEFB OBSOLETE 709                                9AP31698
       BCD 1WEFA00   WRITE EOF CHAN A                                   9AP31699
       OCT 77000001200 WEFA OBSOLETE 709                                9AP31700
       BCD 1WEF000   WRITE END OF FILE 704                              9AP31701
       OCT 77000000200 WEF 704 INSTRUCTION                              9AP31702
       BCD 1WDR000        WRITE DRUM                                    9AP31703
       OCT +076600000300  WDR                                           9AP31704
       BCD 1WDDB00        WRITE DIRECT CHANNEL B                        9AP31703
       OCT +076600002240  WDDB                                          9AP31704
       BCD 1VLM000        VARIABLE LENGTH MULTIPLY                      9AP31705
       OCT +020400000000  VLM                                           9AP31706
       BCD 1VDP000        VARIABLE LENGTH DIVIDE OR PROCEED             9AP31707
       OCT +022500000000  VDP                                           9AP31708
       BCD 1VDH000        VARIABLE LENGTH DIVIDE OR HALT                9AP31709
       OCT +022400000000  VDH                                           9AP31710
       BCD 1USM000        UNNORMALIZED FLOATING SUBTRACT MAGNITUDE      9AP31711
       OCT -030600000000  USM                                           9AP31712
       BCD 1UFS000        UNNORMALIZED FLOATING SUBTRACT                9AP31713
       OCT -030200000000  UFS                                           9AP31714
       BCD 1UFM000        UNNORMALIZED FLOATING MULTIPLY                9AP31715
       OCT -026000000000  UFM                                           9AP31716
       BCD 1UFA000        UNNORMALIZED FLOATING ADD                     9AP31717
       OCT -030000000000  UFA                                           9AP31718
       BCD 1UAM000        UNNORMALIZED ADD MAGNITUDE                    9AP31719
       OCT -030400000000  UAM                                           9AP31720
       BCD 1TZE000        TRANSFER ON ZERO                              9AP31721
       OCT +010000000000  TZE                                           9AP31722
       BCD 1TXL000        TRANSFER ON INDEX LOW                         9AP31723
       OCT -300000000000  TXL                                           9AP31724
       BCD 1TXI000        TRANSFER WITH INDEX INCREMENTED               9AP31725
       OCT +100000000000  TXI                                           9AP31726
       BCD 1TXH000        TRANSFER ON INDEX HIGH                        9AP31727
       OCT +300000000000  TXH                                           9AP31728
       BCD 1TTR000        TRAP TRANSFER                                 9AP31729
       OCT +002100000000  TTR                                           9AP31730
       BCD 1TSX000        TRANSFER AND SET INDEX                        9AP31731
       OCT +007400000000  TSX                                           9AP31732
       BCD 1TRSH00        TEST READY STATUS CHANNEL H     
       OCT -077500010200  TRSH
       BCD 1TRSG00        TEST READY STATUS CHANNEL G     
       OCT -077500007200  TRSG
       BCD 1TRSF00        TEST READY STATUS CHANNEL F     
       OCT -077500006200  TRSF
       BCD 1TRSE00        TEST READY STATUS CHANNEL E
       OCT -077500005200  TRSE
       BCD 1TRSD00        TEST READY STATUS CHANNEL D     
       OCT -077500004200  TRSD
       BCD 1TRSC00        TEST READY STATUS CHANNEL C     
       OCT -077500003200  TRSC
       BCD 1TRSB00        TEST READY STATUS CHANNEL B     
       OCT -077500002200  TRSB
       BCD 1TRSA00        TEST READY STATUS CHANNEL A
       OCT -077500001200  TRSA
       BCD 1TRCH00        TRANSFER ON REDUNDANCY CHECK, CHANNEL H       9AP31733
       OCT -003000000000  TRCH                                          9AP31734
       BCD 1TRCG00        TRANSFER ON REDUNDANCY CHECK, CHANNEL G       9AP31733
       OCT +003000000000  TRCG                                          9AP31734
       BCD 1TRCF00        TRANSFER ON REDUNDANCY CHECK, CHANNEL F       9AP31733
       OCT -002600000000  TRCF                                          9AP31734
       BCD 1TRCE00        TRANSFER ON REDUNDANCY CHECK, CHANNEL E       9AP31735
       OCT +002600000000  TRCE                                          9AP31736
       BCD 1TRCD00        TRANSFER ON REDUNDANCY CHECK, CHANNEL D       9AP31737
       OCT -002400000000  TRCD                                          9AP31738
       BCD 1TRCC00        TRANSFER ON REDUNDANCY CHECK, CHANNEL C       9AP31739
       OCT +002400000000  TRCC                                          9AP31740
       BCD 1TRCB00        TRANSFER ON REDUNDANCY CHECK, CHANNEL B       9AP31741
       OCT -002200000000  TRCB                                          9AP31742
       BCD 1TRCA00        TRANSFER ON REDUNDANCY CHECK, CHANNEL A       9AP31743
       OCT +002200000000  TRCA                                          9AP31744
       BCD 1TRA000        TRANSFER                                      9AP31745
       OCT +002000000000  TRA                                           9AP31746
       BCD 1TQP000        TRANSFER ON MQ PLUS                           9AP31747
       OCT +016200000000  TQP                                           9AP31748
       BCD 1TQO000        TRANSFER MQ OVERFLOW 704                      9AP31749
       OCT +016100000000  TQO 704 INSTRUCTION                           9AP31750
       BCD 1TPL000        TRANSFER ON PLUS                              9AP31751
       OCT +012000000000  TPL                                           9AP31752
       BCD 1TOV000        TRANSFER ON OVERFLOW                          9AP31753
       OCT +014000000000  TOV                                           9AP31754
       BCD 1TNZ000        TRANSFER ON NO ZERO                           9AP31755
       OCT -010000000000  TNZ                                           9AP31756
       BCD 1TNX000        TRANSFER ON NO INDEX                          9AP31757
       OCT -200000000000  TNX                                           9AP31758
       BCD 1TNO000        TRANSFER ON NO OVERFLOW                       9AP31759
       OCT -014000000000  TNO                                           9AP31760
       BCD 1TMI000        TRANSFER ON MINUS                             9AP31761
       OCT -012000000000  TMI                                           9AP31762
       BCD 1TLQ000        TRANSFER ON LOW MQ                            9AP31763
       OCT +004000000000  TLQ                                           9AP31764
       BCD 1TLD000        LOAD XR FROM INDIRECT DECR 704 SF             9AP31765
       OCT 453200000000   TLD 704 SPECIAL FEATURE                       9AP31766
       BCD 1TLA000        LOAD XR FROM INDIRECT ADR  704 SF             9AP31767
       OCT 053200000000   TLA 704 SPECIAL FEATURE                       9AP31768
       BCD 1TIX000        TRANSFER ON INDEX                             9AP31769
       OCT +200000000000  TIX                                           9AP31770
       BCD 1TIO000        TRANSFER IF INDICATORS ON                     9AP31771
       OCT +004200000000  TIO                                           9AP31772
       BCD 1TIF000        TRANSFER IF INDICATORS OFF                    9AP31773
       OCT +004600000000  TIF                                           9AP31774
       BCD 1TEFH00        TRANSFER ON END OF FILE, CHANNEL H            9AP31775
       OCT -003300000000  TEFH                                          9AP31776
       BCD 1TEFG00        TRANSFER ON END OF FILE, CHANNEL G            9AP31775
       OCT +003300000000  TEFG                                          9AP31776
       BCD 1TEFF00        TRANSFER ON END OF FILE, CHANNEL F            9AP31775
       OCT -003200000000  TEFF                                          9AP31776
       BCD 1TEFE00        TRANSFER ON END OF FILE, CHANNEL E            9AP31777
       OCT +003200000000  TEFE                                          9AP31778
       BCD 1TEFD00        TRANSFER ON END OF FILE, CHANNEL D            9AP31779
       OCT -003100000000  TEFD                                          9AP31780
       BCD 1TEFC00        TRANSFER ON END OF FILE, CHANNEL C            9AP31781
       OCT +003100000000  TEFC                                          9AP31782
       BCD 1TEFB00        TRANSFER ON END OF FILE, CHANNEL B            9AP31783
       OCT -003000000000  TEFB                                          9AP31784
       BCD 1TEFA00        TRANSFER ON END OF FILE, CHANNEL A            9AP31785
       OCT +003000000000  TEFA                                          9AP31786
       BCD 1TCOH00        TRANSFER ON CHANNEL H IN OPERATION            9AP31787
       OCT +006700000000  TCOH                                          9AP31788
       BCD 1TCOG00        TRANSFER ON CHANNEL G IN OPERATION            9AP31787
       OCT +006600000000  TCOG                                          9AP31788
       BCD 1TCOF00        TRANSFER ON CHANNEL F IN OPERATION            9AP31787
       OCT +006500000000  TCOF                                          9AP31788
       BCD 1TCOE00        TRANSFER ON CHANNEL E IN OPERATION            9AP31789
       OCT +006400000000  TCOE                                          9AP31790
       BCD 1TCOD00        TRANSFER ON CHANNEL D IN OPERATION            9AP31791
       OCT +006300000000  TCOD                                          9AP31792
       BCD 1TCOC00        TRANSFER ON CHANNEL C IN OPERATION            9AP31793
       OCT +006200000000  TCOC                                          9AP31794
       BCD 1TCOB00        TRANSFER ON CHANNEL B IN OPERATION            9AP31795
       OCT +006100000000  TCOB                                          9AP31796
       BCD 1TCOA00        TRANSFER ON CHANNEL A IN OPERATION            9AP31797
       OCT +006000000000  TCOA                                          9AP31798
       BCD 1TCNH00        TRANSFER ON CHANNEL H NOT IN OPERATION        9AP31799
       OCT -006700000000  TCNH                                          9AP31800
       BCD 1TCNG00        TRANSFER ON CHANNEL G NOT IN OPERATION        9AP31799
       OCT -006600000000  TCNG                                          9AP31800
       BCD 1TCNF00        TRANSFER ON CHANNEL F NOT IN OPERATION        9AP31799
       OCT -006500000000  TCNF                                          9AP31800
       BCD 1TCNE00        TRANSFER ON CHANNEL E NOT IN OPERATION        9AP31801
       OCT -006400000000  TCNE                                          9AP31802
       BCD 1TCND00        TRANSFER ON CHANNEL D NOT IN OPERATION        9AP31803
       OCT -006300000000  TCND                                          9AP31804
       BCD 1TCNC00        TRANSFER ON CHANNEL C NOT IN OPERATION        9AP31805
       OCT -006200000000  TCNC                                          9AP31806
       BCD 1TCNB00        TRANSFER ON CHANNEL B NOT IN OPERATION        9AP31807
       OCT -006100000000  TCNB                                          9AP31808
       BCD 1TCNA00        TRANSFER ON CHANNEL A NOT IN OPERATIO N       9AP31809
       OCT -006000000000  TCNA                                          9AP31810
       BCD 1TCH000        TRANSFER IN CHAN-IND. ADDR                    9AP31811
       OCT +100000000000  TCH                                           9AP31812
       BCD 1SXD000        STORE INDEX IN DECREMENT                      9AP31813
       OCT -063400000000  SXD                                           9AP31814
       BCD 1SXA000        STORE INDEX IN ADDRESS                        9AP31815
       OCT +063400000000  SXA                                           9AP31816
       BCD 1SWT000        SENSE SWITCH TEST                             9AP31817
       OCT +076000000160  SWT                                           9AP31818
       BCD 1SVN000        SEVEN                                         9AP31819
       OCT -300000000000  SVN                                           9AP31820
       BCD 1SUB000        SUBTRACT                                      9AP31821
       OCT +040200000000  SUB                                           9AP31822
       BCD 1STZ000        STORE ZERO                                    9AP31823
       OCT +060000000000  STZ                                           9AP31824
       BCD 1STT000        STORE TAG                                     9AP31825
       OCT +062500000000  STT                                           9AP31826
       BCD 1STR000        STORE LOCATION AND TRAP                       9AP31827
       OCT -100000000000  STR                                           9AP31828
       BCD 1STQ000        STORE MQ                                      9AP31829
       OCT -060000000000  STQ                                           9AP31830
       BCD 1STP000        STORE PREFIX                                  9AP31831
       OCT +063000000000  STP                                           9AP31832
       BCD 1STO000        STORE                                         9AP31833
       OCT +060100000000  STO                                           9AP31834
       BCD 1STL000        STORE INSTRUCTION LOCATION COUNTER            9AP31835
       OCT -062500000000  STL                                           9AP31836
       BCD 1STI000        STORE INDICATORS                              9AP31837
       OCT +060400000000  STI                                           9AP31838
       BCD 1STD000        STORE DECREMENT                               9AP31839
       OCT +062200000000  STD                                           9AP31840
       BCD 1STA000        STORE ADDRESS                                 9AP31841
       OCT +062100000000  STA                                           9AP31842
       BCD 1SSP000        SET SIGN PLUS                                 9AP31843
       OCT +076000000003  SSP                                           9AP31844
       BCD 1SSM000        SET SIGN MINUS                                9AP31845
       OCT -076000000003  SSM                                           9AP31846
       BCD 1SSLB00        STORE SENSE LINES B                           9AP31845
       OCT -066000000000  SSLB                                          9AP31846
       BCD 1SPUE00        SENSE PUNCH, CHANNEL E                        9AP31847
       OCT +076000005340  SPUE                                          9AP31848
       BCD 1SPUC00        SENSE PUNCH, CHANNEL C                        9AP31849
       OCT +076000003340  SPUC                                          9AP31850
       BCD 1SPUA00        SENSE PUNCH, CHANNEL A                        9AP31851
       OCT +076000001340  SPUA                                          9AP31852
       BCD 1SPU000        SENSE PUNCH EXIT 704                          9AP31853
       OCT 76000000340    SPU 704 INSTRUCTION                           9AP31854
       BCD 1SPTE00        SENSE PRINTER TEST, CHANNEL E                 9AP31855
       OCT +076000005360  SPTE                                          9AP31856
       BCD 1SPTC00        SENSE PRINTER TEST, CHANNEL C                 9AP31857
       OCT +076000003360  SPTC                                          9AP31858
       BCD 1SPTA00        SENSE PRINTER TEST, CHANNEL A                 9AP31859
       OCT +076000001360  SPTA                                          9AP31860
       BCD 1SPT000        SENSE PRINTER TEST 704                        9AP31861
       OCT 76000000360    SPT 704 INSTRUCTION                           9AP31862
       BCD 1SPRE00        SENSE PRINTER, CHANNEL E                      9AP31863
       OCT +076000005360  SPRE                                          9AP31864
       BCD 1SPRC00        SENSE PRINTER, CHANNEL C                      9AP31865
       OCT +076000003360  SPRC                                          9AP31866
       BCD 1SPRA00        SENSE PRINTER, CHANNEL A                      9AP31867
       OCT +076000001360  SPRA                                          9AP31868
       BCD 1SPR000        SENSE PRINTER EXIT 704                        9AP31869
       OCT 76000000360    SPR 704 INSTRUCTION                           9AP31870
       BCD 1SLW000        STORE LOGICAL WORD                            9AP31871
       OCT +060200000000  SLW                                           9AP31872
       BCD 1SLT000        SENSE LIGHT TEST                              9AP31873
       OCT -076000000140  SLT                                           9AP31874
       BCD 1SLQ000        STORE LEFT HALF MQ                            9AP31875
       OCT -062000000000  SLQ                                           9AP31876
       BCD 1SLN000        SENSE LIGHTS ON                               9AP31877
       OCT +076000000140  SLN                                           9AP31878
       BCD 1SLF000        SENSE LIGHTS OFF                              9AP31879
       OCT +076000000140  SLF                                           9AP31880
       BCD 1SIX000        SIX                                           9AP31881
       OCT -200000000000  SIX                                           9AP31882
       BCD 1SIR000   SET INDICATORS OF RIGHT HALF                       9AP31883
       OCT +005500100000 SIR                                            9AP31884
       BCD 1SIL000   SET INDICATORS OF LEFT HALF                        9AP31885
       OCT -005500100000 SIL                                            9AP31886
       BCD 1SCHH00        STORE CHANNEL H                               9AP31887
       OCT -064300000000  SCHH                                          9AP31888
       BCD 1SCHG00        STORE CHANNEL G                               9AP31887
       OCT +064300000000  SCHG                                          9AP31888
       BCD 1SCHF00        STORE CHANNEL F                               9AP31887
       OCT -064200000000  SCHF                                          9AP31888
       BCD 1SCHE00        STORE CHANNEL E                               9AP31889
       OCT +064200000000  SCHE                                          9AP31890
       BCD 1SCHD00        STORE CHANNEL D                               9AP31891
       OCT -064100000000  SCHD                                          9AP31892
       BCD 1SCHC00        STORE CHANNEL C                               9AP31893
       OCT +064100000000  SCHC                                          9AP31894
       BCD 1SCHB00        STORE CHANNEL B                               9AP31895
       OCT -064000000000  SCHB                                          9AP31896
       BCD 1SCHA00        STORE CHANNEL A                               9AP31897
       OCT +064000000000  SCHA                                          9AP31898
       BCD 1SBM000        SUBTRACT MAGNITUDE                            9AP31899
       OCT -040000000000  SBM                                           9AP31900
       BCD 1   000        BLANK                                         9AP31901
       OCT +000000000000  BLANK                                         9AP31902
       BCD 1RTT000   REDUNDANCY TAPE TEST 704                           9AP31903
       OCT -76000000012 RTT 704 INSTRUCTION                             9AP31904
       BCD 1RTDH00        READ TAPE DECIMAL, CHANNEL H                  9AP31905
       OCT +076200010200  RTDH                                          9AP31906
       BCD 1RTDG00        READ TAPE DECIMAL, CHANNEL G                  9AP31905
       OCT +076200007200  RTDG                                          9AP31906
       BCD 1RTDF00        READ TAPE DECIMAL, CHANNEL F                  9AP31905
       OCT +076200006200  RTDF                                          9AP31906
       BCD 1RTDE00        READ TAPE DECIMAL, CHANNEL E                  9AP31907
       OCT +076200005200  RTDE                                          9AP31908
       BCD 1RTDD00        READ TAPE DECIMAL, CHANNEL D                  9AP31909
       OCT +076200004200  RTDD                                          9AP31910
       BCD 1RTDC00        READ TAPE DECIMAL, CHANNEL C                  9AP31911
       OCT +076200003200  RTDC                                          9AP31912
       BCD 1RTDB00        READ TAPE DECIMAL, CHANNEL B                  9AP31913
       OCT +076200002200  RTDB                                          9AP31914
       BCD 1RTDA00        READ TAPE DECIMAL, CHANNEL A                  9AP31915
       OCT +076200001200  RTDA                                          9AP31916
       BCD 1RTD000   READ TAPE DECIMAL 704                              9AP31917
       OCT 76200000200 RTD 704 INSTRUCTION                              9AP31918
       BCD 1RTBH00        READ TAPE BINARY, CHANNEL H                   9AP31919
       OCT +076200010220  RTBH                                          9AP31920
       BCD 1RTBG00        READ TAPE BINARY, CHANNEL G                   9AP31919
       OCT +076200007220  RTBG                                          9AP31920
       BCD 1RTBF00        READ TAPE BINARY, CHANNEL F                   9AP31919
       OCT +076200006220  RTBF                                          9AP31920
       BCD 1RTBE00        READ TAPE BINARY, CHANNEL E                   9AP31921
       OCT +076200005220  RTBE                                          9AP31922
       BCD 1RTBD00        READ TAPE BINARY, CHANNEL D                   9AP31923
       OCT +076200004220  RTBD                                          9AP31924
       BCD 1RTBC00        READ TAPE BINARY, CHANNEL C                   9AP31925
       OCT +076200003220  RTBC                                          9AP31926
       BCD 1RTBB00        READ TAPE BINARY, CHANNEL B                   9AP31927
       OCT +076200002220  RTBB                                          9AP31928
       BCD 1RTBA00        READ TAPE BINARY, CHANNEL A                   9AP31929
       OCT +076200001220  RTBA                                          9AP31930
       BCD 1RTB000        READ TAPE BINARY 704                          9AP31931
       OCT 76200000220    RTB 704 INSTRUCTION                           9AP31932
       BCD 1RQL000        ROTATE MQ LEFT                                9AP31933
       OCT -077300000000  RQL                                           9AP31934
       BCD 1RPRE00        READ PRINTER, CHANNEL E                       9AP31935
       OCT +076200005361  RPRE                                          9AP31936
       BCD 1RPRC00        READ PRINTER, CHANNEL C                       9AP31937
       OCT +076200003361  RPRC                                          9AP31938
       BCD 1RPRA00        READ PRINTER, CHANNEL A                       9AP31939
       OCT +076200001361  RPRA                                          9AP31940
       BCD 1RPR000        READ PRINTER-704 INSTR                        9AP31941
       OCT 76200000361    RPR 704 INSTRUCTION                           9AP31942
       BCD 1RNT000        RIGHT HALF INDICATORS ON TEST                 9AP31943
       OCT +005600100000  RNT                                           9AP31944
       BCD 1RND000        ROUND                                         9AP31945
       OCT +076000000010  RND                                           9AP31946
       BCD 1RIS000        RESET INDICATORS FROM STORAGE                 9AP31947
       OCT +044500000000  RIS                                           9AP31948
       BCD 1RIR000        RESET INDICATORS OF RIGHT HALF                9AP31949
       OCT +005700100000  RIR                                           9AP31950
       BCD 1RIL000        RESET INDICATORS OF LEFT HALF                 9AP31951
       OCT -005700100000  RIL                                           9AP31952
       BCD 1RIA000        RESET INDICATORS FROM ACCUMULATOR             9AP31953
       OCT -004200000000  RIA                                           9AP31954
       BCD 1RFT000        RIGHT HALF INDICATORS OFF TEST                9AP31955
       OCT +005400100000  RFT                                           9AP31956
       BCD 1REWH00        REWIND TAPE CHANNEL H                         9AP31957
       OCT +077200010200  REWH                                          9AP31958
       BCD 1REWG00        REWIND TAPE CHANNEL G                         9AP31957
       OCT +077200007200  REWG                                          9AP31958
       BCD 1REWF00        REWIND TAPE CHANNEL F                         9AP31957
       OCT +077200006200  REWF                                          9AP31958
       BCD 1REWE00        REWIND TAPE CHANNEL E                         9AP31959
       OCT +077200005200  REWE                                          9AP31960
       BCD 1REWD00        REWIND TAPE CHANNEL D                         9AP31961
       OCT +077200004200  REWD                                          9AP31962
       BCD 1REWC00        REWIND TAPE CHANNEL C                         9AP31963
       OCT +077200003200  REWC                                          9AP31964
       BCD 1REWB00        REWIND TAPE CHANNEL B                         9AP31965
       OCT +077200002200  REWB                                          9AP31966
       BCD 1REWA00        REWIND TAPE CHANNEL A                         9AP31967
       OCT +077200001200  REWA                                          9AP31968
       BCD 1REW000        REWIND TAPE 704                               9AP31969
       OCT 77200000200    REW 704 INSTRUCTION                           9AP31970
       BCD 1RDS000        READ SELECT                                   9AP31971
       OCT +076200000000  RDS                                           9AP31972
       BCD 1RDR000        READ DRUM                                     9AP31973
       OCT +076200000300  RDR                                           9AP31974
       BCD 1RDDB00        READ DIRECT CHANNEL B                         9AP31973
       OCT +076200002240  RDDB                                          9AP31974
       BCD 1RDCH00        RESET DATA CHANNEL H                          F0D76090
       OCT +076000010352  RDCH                                          F0D76100
       BCD 1RDCG00        RESET DATA CHANNEL G                          F0D76070
       OCT +076000007352  RDCG                                          F0D76080
       BCD 1RDCF00        RESET DATA CHANNEL F                          F0D76050
       OCT +076000006352  RDCF                                          F0D76060
       BCD 1RDCE00        RESET DATA CHANNEL E                          F0D76030
       OCT +076000005352  RDCE                                          F0D76040
       BCD 1RDCD00        RESET DATA CHANNEL D                          F0D76010
       OCT +076000004352  RDCD                                          F0D76020
       BCD 1RDCC00        RESET DATA CHANNEL C                          F0D75990
       OCT +076000003352  RDCC                                          F0D76000
       BCD 1RDCB00        RESET DATA CHANNEL B                          F0D75970
       OCT +076000002352  RDCB                                          F0D75980
       BCD 1RDCA00        RESET DATA CHANNEL A                          F0D75950
       OCT +076000001352  RDCA                                          F0D75960
       BCD 1RCT000        RESTORE INTERRUPTS
       OCT +076000000014  RCT 
       BCD 1RCHH00        RESET AND LOAD CHANNEL H                      9AP31975
       OCT -054300000000  RCHH                                          9AP31976
       BCD 1RCHG00        RESET AND LOAD CHANNEL G                      9AP31975
       OCT +054300000000  RCHG                                          9AP31976
       BCD 1RCHF00        RESET AND LOAD CHANNEL F                      9AP31975
       OCT -054200000000  RCHF                                          9AP31976
       BCD 1RCHE00        RESET AND LOAD CHANNEL E                      9AP31977
       OCT +054200000000  RCHE                                          9AP31978
       BCD 1RCHD00        RESET AND LOAD CHANNEL D                      9AP31979
       OCT -054100000000  RCHD                                          9AP31980
       BCD 1RCHC00        RESET AND LOAD CHANNEL C                      9AP31981
       OCT +054100000000  RCHC                                          9AP31982
       BCD 1RCHB00        RESET AND LOAD CHANNEL B                      9AP31983
       OCT -054000000000  RCHB                                          9AP31984
       BCD 1RCHA00        RESET AND LOAD CHANNEL A                      9AP31985
       OCT +054000000000  RCHA                                          9AP31986
       BCD 1RCDE00        READ CARDS, CHANNEL E                         9AP31987
       OCT +076200005321  RCDE                                          9AP31988
       BCD 1RCDC00        READ CARDS CHANNEL C                          9AP31989
       OCT +076200003321  RCDC                                          9AP31990
       BCD 1RCDA00        READ CARDS, CHANNEL A                         9AP31991
       OCT +076200001321  RCDA                                          9AP31992
       BCD 1RCD000   READ CARD READER 704                               9AP31993
       OCT 76200000321 RCD 704 INSTRUCTION                              9AP31994
       BCD 1PZE000        PLUS ZERO                                     9AP31995
       OCT +000000000000  PZE                                           9AP31996
       BCD 1PXD000        PLACE INDEX IN DECREMENT                      9AP31997
       OCT -075400000000  PXD                                           9AP31998
       BCD 1PXA000        PLACE INDEX IN ADDRESS                        9AP31999
       OCT +075400000000  PAX                                           9AP32000
       BCD 1PTW000        PLUS TWO                                      9AP32001
       OCT +200000000000  PTW                                           9AP32002
       BCD 1PTH000        PLUS THREE                                    9AP32003
       OCT +300000000000  PTH                                           9AP32004
       BCD 1PSLB00        PULSE SENSE LINES CHANNEL B                   9AP32003
       OCT -066400000000  PSLB                                          9AP32004
       BCD 1PSE000        PLUS SENSE                                    9AP32005
       OCT +076000000000  PSE                                           9AP32006
       BCD 1PON000        PLUS ONE                                      9AP32007
       OCT +100000000000  PON                                           9AP32008
       BCD 1PIT000        PLUS INTERVAL TIMER 704 SF                    9AP32009
       OCT 76000000013    PIT 704 SPECIAL FEATURE                       9AP32010
       BCD 1PIA000        PLACE INDICATORS IN ACCUMULATOR               9AP32011
       OCT -004600000000  PIA                                           9AP32012
       BCD 1PDX000        PLACE DECREMENT IN INDEX                      9AP32013
       OCT -073400000000  PDX                                           9AP32014
       BCD 1PDC000        PLACE DECREMENT IN INDEX COMPLEMENTED         9AP32015
       OCT -073700000000  PDC                                           9AP32016
       BCD 1PBT000        P BIT TEST                                    9AP32017
       OCT -076000000001  PBT                                           9AP32018
       BCD 1PAX000        PLACE ADDRESS IN INDEX                        9AP32019
       OCT +073400000000  PAX                                           9AP32020
       BCD 1PAI000        PLACE ADDRESS IN INDICATORS                   9AP32021
       OCT +004400000000  PAI                                           9AP32022
       BCD 1PAC000        PLACE ADDRESS IN INDEX, COMPLEMENTED          9AP32023
       OCT +073700000000  PAC                                           9AP32024
       BCD 1OSI000        OR STORAGE TO INDICATORS                      9AP32025
       OCT +044200000000  OSI                                           9AP32026
       BCD 1ORS000        OR TO STORAGE                                 9AP32027
       OCT -060200000000  ORS                                           9AP32028
       BCD 1ORA000        OR TO ACCUMULATOR                             9AP32029
       OCT -050100000000  ORA                                           9AP32030
       BCD 1ONT000        ON TEST FOR INDICATORS                        9AP32031
       OCT +044600000000  ONT                                           9AP32032
       BCD 1OFT000        OFF TEST FOR INDICATORS                       9AP32033
       OCT +044400000000  OFT                                           9AP32034
       BCD 1OAI000        OR ACCUMULATOR TO INDICATORS                  9AP32035
       OCT +004300000000  OAI                                           9AP32036
       BCD 1NZT000        STORAGE NON-ZERO TEST                         9AP32037
       OCT -052000000000  NZT                                           9AP32038
       BCD 1NOP000        NO OPERATION                                  9AP32039
       OCT +076100000000  NOP                                           9AP32040
       BCD 1MZE000        MINUS ZERO                                    9AP32041
       OCT -000000000000  MZE                                           9AP32042
       BCD 1MTW000        MINUS TWO                                     9AP32043
       OCT -200000000000  MTW                                           9AP32044
       BCD 1MTH000        MINUS THREE                                   9AP32045
       OCT -300000000000  MTH                                           9AP32046
       BCD 1MSE000        MINUS SENSE                                   9AP32047
       OCT -076000000000  MSE                                           9AP32048
       BCD 1MPY000        MULTIPLY                                      9AP32049
       OCT +020000000000  MPY                                           9AP32050
       BCD 1MPR000        MULTIPLY AND ROUND                            9AP32051
       OCT -020000000000  MPR                                           9AP32052
       BCD 1MON000        MINUS ONE                                     9AP32053
       OCT -100000000000  MON                                           9AP32054
       BCD 1MIT000        MINUS INTERVAL TIMER 704 SF                   9AP32055
       OCT -76000000013   MIT 704 SPECIAL FEATURE                       9AP32056
       BCD 1LXD000        LOAD INDEX FROM DECREMENT                     9AP32057
       OCT -053400000000  LXD                                           9AP32058
       BCD 1LXA000        LOAD INDEX FROM ADDRESS                       9AP32059
       OCT +053400000000  LXA                                           9AP32060
       BCD 1LTM000        LEAVE TRAPPING MODE                           9AP32061
       OCT -076000000007  LTM                                           9AP32062
       BCD 1LSNM00        LEAVE STORAGE NULL. MODE                      9AP32063
       OCT -076000000010  LSNM                                          9AP32064
       BCD 1LRS000        LONG RIGHT SHIFT                              9AP32065
       OCT +076500000000  LRS                                           9AP32066
       BCD 1LNT000   LEFT HALF INDICATORS ON TEST                       9AP32067
       OCT -005600100000 LNT                                            9AP32068
       BCD 1LLS000        LONG LEFT SHIFT                               9AP32069
       OCT +076300000000  LLS                                           9AP32070
       BCD 1LGR000        LOGICAL RIGHT SHIFT                           9AP32071
       OCT -076500000000  LGR                                           9AP32072
       BCD 1LGL000        LOGICAL LEFT SHIFT                            9AP32073
       OCT -076300000000  LGL                                           9AP32074
       BCD 1LFTM00   LEAVE 709 FLOATING TRAP MODE                       9AP32075
       OCT -076000000004 LFTM                                           9AP32076
       BCD 1LFT000   LEFT HALF INDS, OFF TEST                           9AP32077
       OCT -005400100000 LFT                                            9AP32078
       BCD 1LDQ000        LOAD MQ                                       9AP32079
       OCT +056000000000  LDQ                                           9AP32080
       BCD 1LDI000        LOAD INDICATORS                               9AP32081
       OCT +044100000000  LDI                                           9AP32082
       BCD 1LDC000        LOAD INDEX FROM DECREMENT, COMPLEMENTED       9AP32083
       OCT -053500000000  LDC                                           9AP32084
       BCD 1LDA000        LOCATE DRUM ADDRESS                           9AP32085
       OCT +046000000000  LDA                                           9AP32086
       BCD 1LCHH00        LOAD CHANNEL H                                9AP32087
       OCT -054700000000  LCHH                                          9AP32088
       BCD 1LCHG00        LOAD CHANNEL G                                9AP32087
       OCT +054700000000  LCHG                                          9AP32088
       BCD 1LCHF00        LOAD CHANNEL F                                9AP32087
       OCT -054600000000  LCHF                                          9AP32088
       BCD 1LCHE00        LOAD CHANNEL E                                9AP32089
       OCT +054600000000  LCHE                                          9AP32090
       BCD 1LCHD00        LOAD CHANNEL D                                9AP32091
       OCT -054500000000  LCHD                                          9AP32092
       BCD 1LCHC00        LOAD CHANNEL C                                9AP32093
       OCT +054500000000  LCHC                                          9AP32094
       BCD 1LCHB00        LOAD CHANNEL B                                9AP32095
       OCT -054400000000  LCHB                                          9AP32096
       BCD 1LCHA00        LOAD CHANNEL A                                9AP32097
       OCT 54400000000 LCHA                                             9AP32098
       BCD 1LBT000        LOW ORDER BIT TEST                            9AP32099
       OCT +076000000001  LBT                                           9AP32100
       BCD 1LAS000        LOGICAL COMPARE ACCUMULATOR WITH STORAGE      9AP32101
       OCT -34000000000 LAS                                             9AP32102
       BCD 1LAC000        LOAD INDEX FROM ADDRESS, COMPLEMENTED         9AP32103
       OCT +053500000000  LAC                                           9AP32104
       REM                                                              9AP32105
       REM                                                              9AP32106
       BCD 1ACL000        ADD AND CARRY LOGICAL WORD                    9AP32107
       OCT +036100000000  ACL                                           9AP32108
       BCD 1ADD000        ADD                                           9AP32109
       OCT +040000000000  ADD                                           9AP32110
       BCD 1ADM000        ADD MAGNITUDE                                 9AP32111
       OCT +040100000000  ADM                                           9AP32112
       BCD 1ALS000        ACCUMULATOR LEFT SHIFT                        9AP32113
       OCT +076700000000  ALS                                           9AP32114
       BCD 1ANA000        AND TO ACCUMULATOR                            9AP32115
       OCT -032000000000  ANA                                           9AP32116
       BCD 1ANS000        AND TO STORAGE                                9AP32117
       OCT +032000000000  ANS                                           9AP32118
       BCD 1ARS000        ACCUMULATOR RIGHT SHIFT                       9AP32119
       OCT +077100000000  ARS                                           9AP32120
       BCD 1AXC000        ADDRESS TO INDEX, COMPLEMENTED                9AP32121
       OCT -077400000000  AXC                                           9AP32122
       BCD 1AXT000        ADDRESS TO INDEX, TRUE                        9AP32123
       OCT +077400000000  AXT                                           9AP32124
       BCD 1BRBA00   BACKSPACE REC. BIN. CHAN A                         9AP32125
       OCT +076400001220 BRBA                                           9AP32126
       BCD 1BRBB00   BACKSPACE REC. BIN. CHAN B                         9AP32127
       OCT +076400002220 BRBB                                           9AP32128
       BCD 1BRBC00   BACKSPACE REC. BIN. CHAN C                         9AP32129
       OCT +076400003220 BRBC                                           9AP32130
       BCD 1BRBD00   BACKSPACE REC. BIN. CHAN D                         9AP32131
       OCT +076400004220 BRBD                                           9AP32132
       BCD 1BRBE00   BACKSPACE REC. BIN. CHAN E                         9AP32133
       OCT +076400005220 BRBE                                           9AP32134
       BCD 1BRBF00   BACKSPACE REC. BIN. CHAN F                         9AP32135
       OCT +076400006220 BRBF                                           9AP32136
       BCD 1BRBG00   BACKSPACE REC. BIN. CHAN G                         9AP32135
       OCT +076400007220 BRBG                                           9AP32136
       BCD 1BRBF00   BACKSPACE REC. BIN. CHAN H                         9AP32135
       OCT +076400010220 BRBH                                           9AP32136
       BCD 1BRDA00   BACKSPACE REC. DEC. CHAN A                         9AP32137
       OCT +076400001200 BRDA                                           9AP32138
       BCD 1BRDB00   BACKSPACE REC. DEC. CHAN B                         9AP32139
       OCT +076400002200 BRDB                                           9AP32140
       BCD 1BRDC00   BACKSPACE REC. DEC. CHAN C                         9AP32141
       OCT +076400003200 BRDC                                           9AP32142
       BCD 1BRDD00   BACKSPACE REC. DEC. CHAN D                         9AP32143
       OCT +076400004200 BRDD                                           9AP32144
       BCD 1BRDE00   BACKSPACE REC. DEC. CHAN E                         9AP32145
       OCT +076400005200 BRDE                                           9AP32146
       BCD 1BRDF00   BACKSPACE REC. DEC. CHAN F                         9AP32147
       OCT +076400006200 BRDF                                           9AP32148
       BCD 1BRDG00   BACKSPACE REC. DEC. CHAN G                         9AP32147
       OCT +076400007200 BRDG                                           9AP32148
       BCD 1BRDH00   BACKSPACE REC. DEC. CHAN H                         9AP32147
       OCT +076400010200 BRDH                                           9AP32148
       BCD 1BSFA00        BACKSPACE FILE, CHANNEL A                     9AP32149
       OCT -076400001200  BSFA                                          9AP32150
       BCD 1BSFB00        BACKSPACE FILE, CHANNEL B                     9AP32151
       OCT -076400002200  BSFB                                          9AP32152
       BCD 1BSFC00        BACKSPACE FILE, CHANNEL C                     9AP32153
       OCT -076400003200  BSFC                                          9AP32154
       BCD 1BSFD00        BACKSPACE FILE, CHANNEL D                     9AP32155
       OCT -076400004200  BSFD                                          9AP32156
       BCD 1BSFE00        BACKSPACE FILE, CHANNEL E                     9AP32157
       OCT -076400005200  BSFE                                          9AP32158
       BCD 1BSFF00        BACKSPACE FILE, CHANNEL F                     9AP32159
       OCT -076400006200  BSFF                                          9AP32160
       BCD 1BSFG00        BACKSPACE FILE, CHANNEL G                     9AP32159
       OCT -076400007200  BSFG                                          9AP32160
       BCD 1BSFH00        BACKSPACE FILE, CHANNEL H                     9AP32159
       OCT -076400010200  BSFH                                          9AP32160
       BCD 1BSRA00   BACKSPACE RECORD, CHAN A                           9AP32161
       OCT 76400001200 BSRA OBSOLETE 709                                9AP32162
       BCD 1BSRB00   BACKSPACE RECORD, CHAN B                           9AP32163
       OCT 76400002200 BSRB OBSOLETE 709                                9AP32164
       BCD 1BSRC00   BACKSPACE RECORD, CHAN C                           9AP32165
       OCT 76400003200 BSRC OBSOLETE 709                                9AP32166
       BCD 1BSRD00   BACKSPACE RECORD, CHAN D                           9AP32167
       OCT 76400004200 BSRD OBSOLETE 709                                9AP32168
       BCD 1BSRE00   BACKSPACE RECORD, CHAN E.                          9AP32169
       OCT 76400005200 BSRE OBSOLETE 709                                9AP32170
       BCD 1BSRF00   BACKSPACE RECORD, CHAN F.                          9AP32171
       OCT 76400006200 BSRF OBSOLETE 709                                9AP32172
       BCD 1BST000   BACKSPACE TAPE 704                                 9AP32173
       OCT 76400000200 BST 704 INSTRUCTION                              9AP32174
       BCD 1BTTA00        BEGINNING OF TAPE TEST, CHANNEL               9AP32175
       OCT +076000001000  BTTA                                          9AP32176
       BCD 1BTTB00        BEGINNING OF TAPE TEST, CHANNEL               9AP32177
       OCT +076000002000  BTTB                                          9AP32178
       BCD 1BTTC00        BEGINNING OF TAPE TEST, CHANNEL               9AP32179
       OCT +076000003000  BTTC                                          9AP32180
       BCD 1BTTD00        BEGINNING OF TAPE TEST, CHANNEL               9AP32181
       OCT +076000004000  BTTD                                          9AP32182
       BCD 1BTTE00        BEGINNING OF TAPE TEST, CHANNEL               9AP32183
       OCT +076000005000  BTTE                                          9AP32184
       BCD 1BTTF00        BEGINNING OF TAPE TEST, CHANNEL               9AP32185
       OCT +076000006000  BTTF                                          9AP32186
       BCD 1BTTG00        BEGINNING OF TAPE TEST, CHANNEL               9AP32185
       OCT +076000007000  BTTG                                          9AP32186
       BCD 1BTTH00        BEGINNING OF TAPE TEST, CHANNEL               9AP32185
       OCT +076000010000  BTTH                                          9AP32186
       BCD 1CAD000        COPY, ADD AND CARRY                           9AP32187
       OCT -070000000000  CAD                                           9AP32188
       BCD 1CAL000        CLEAR AND ADD LOGICAL                         9AP32189
       OCT -050000000000  CAL                                           9AP32190
       BCD 1CAQ000        CONVERT BY ADDITION FROM MQ                   9AP32191
       OCT -011400000000  CAQ                                           9AP32192
       BCD 1CAS000        COMPARE ACCUMULATOR WITH STORAGE              9AP32193
       OCT +034000000000  CAS                                           9AP32194
       BCD 1CFF000        CHANGE FILM FRAME                             9AP32195
       OCT +076000000030 CFF                                            9AP32196
       BCD 1CHS000        CHANGE SIGN                                   9AP32197
       OCT +076000000002  CHS                                           9AP32198
       BCD 1CLA000        CLEAR AND ADD                                 9AP32199
       OCT +050000000000  CLA                                           9AP32200
       BCD 1CLM000        CLEAR MAGNITUDE                               9AP32201
       OCT +076000000000  CLM                                           9AP32202
       BCD 1CLS000        CLEAR AND SUBTRACT                            9AP32203
       OCT +050200000000  CLS                                           9AP32204
       BCD 1COM000        COMPLEMENT MAGNITUDE                          9AP32205
       OCT +076000000006  COM                                           9AP32206
       BCD 1CPY000        COPY OR SKIP                                  9AP32207
       OCT +070000000000  CPY                                           9AP32208
       BCD 1CRQ000        CONVERT BY REPLACEMENT FROM MQ                9AP32209
       OCT -015400000000  CRQ                                           9AP32210
       BCD 1CVR000        CONVERT BY REPLACEMENT FROM AC                9AP32211
       OCT +011400000000  CRV                                           9AP32212
       BCD 1DCT000        DIVIDE CHECK TEST                             9AP32213
       OCT +076000000012  DCT                                           9AP32214
       BCD 1DRSA00        DROP READY STATUS CHANNEL A     
       OCT +077500001200  DRSA
       BCD 1DRSB00        DROP READY STATUS CHANNEL B     
       OCT +077500002200  DRSB
       BCD 1DRSC00        DROP READY STATUS CHANNEL C     
       OCT +077500003200  DRSC
       BCD 1DRSD00        DROP READY STATUS CHANNEL D     
       OCT +077500004200  DRSD
       BCD 1DRSE00        DROP READY STATUS CHANNEL E     
       OCT +077500005200  DRSE
       BCD 1DRSF00        DROP READY STATUS CHANNEL F     
       OCT +077500006200  DRSF
       BCD 1DRSG00        DROP READY STATUS CHANNEL G     
       OCT +077500007200  DRSG
       BCD 1DRSH00        DROP READY STATUS CHANNEL H     
       OCT +077500010200  DRSH
       BCD 1DVH000        DIVIDE OR HALT                                9AP32215
       OCT +022000000000  DVH                                           9AP32216
       BCD 1DVP000        DIVIDE OR PROCEED                             9AP32217
       OCT +022100000000  DVP                                           9AP32218
       BCD 1EAD000   EXTENDED FLOATING ADD
       OCT +067100000000
       BCD 1ECTM00   ENTER COPY TRAP MODE                               9AP32219
       OCT -076000000006 ECTM                                           9AP32220
       BCD 1EDP000   EXTENDED FLOATING DIVIDE
       OCT +067200000000
       BCD 1EFTM00   ENTER 709 FLOATING TRAP MODE                       9AP32221
       OCT -076000000002 EFTM                                           9AP32222
       BCD 1ELD000   EXTENDED FLOATING LOAD
       OCT +067000000000
       BCD 1EMP000   EXTENDED FLOATING MULTIPLY
       OCT +067300000000
       BCD 1ENB000   ENABLE INTERUPTS                            
       OCT +056400000000 ENB                                    
       BCD 1ENK000        ENTER KEYS                                    9AP32223
       OCT +076000000004  ENK                                           9AP32224
       BCD 1ERA000        EXCLUSIVE OR TO ACCUMULATOR                   9AP32225
       OCT +032200000000  ERA                                           9AP32226
       BCD 1ESB000   EXTENDED FLOATING SUBTRACT
       OCT -067100000000
       BCD 1ESNT00   ENTER STORAGE NULL. MODE                           9AP32227
       OCT -002100000000 ESNT                                           9AP32228
       BCD 1EST000   EXTENDED FLOATING STORE
       OCT -067300000000
       BCD 1ESTM00   ENTER SENSE TRAP MODE                              9AP32229
       OCT -076000000005 ESTM                                           9AP32230
       BCD 1ETM000        ENTER TRAPPING MODE                           9AP32231
       OCT +076000000007  ETM                                           9AP32232
       BCD 1ETT000   END OF TAPE TEST 704SF                             9AP32233
       OCT -76000000011 ETT 704 SPECIAL FEATURE                         9AP32234
       BCD 1ETTA00        END OF TAPE TEST, CHANNEL A                   9AP32235
       OCT -076000001000  ETTA                                          9AP32236
       BCD 1ETTB00        END OF TAPE TEST, CHANNEL B                   9AP32237
       OCT -076000002000  ETTB                                          9AP32238
       BCD 1ETTC00        END OF TAPE TEST, CHANNEL C                   9AP32239
       OCT -076000003000  ETTC                                          9AP32240
       BCD 1ETTD00        END OF TAPE TEST, CHANNEL D                   9AP32241
       OCT -076000004000  ETTD                                          9AP32242
       BCD 1ETTE00        END OF TAPE TEST, CHANNEL E                   9AP32243
       OCT -076000005000  ETTE                                          9AP32244
       BCD 1ETTF00        END OF TAPE TEST, CHANNEL F                   9AP32245
       OCT -076000006000  ETTF                                          9AP32246
       BCD 1ETTG00        END OF TAPE TEST, CHANNEL G                   9AP32245
       OCT -076000007000  ETTG                                          9AP32246
       BCD 1ETTH00        END OF TAPE TEST, CHANNEL H                   9AP32245
       OCT -076000010000  ETTH                                          9AP32246
       BCD 1EUA000   EXTENDED FLOATING UNNORMALIZE ADD
       OCT -067200000000
       BCD 1FAD000        FLOATING ADD                                  9AP32247
       OCT +030000000000  FAD                                           9AP32248
       BCD 1FAM000        FLOATING ADD MAGNITUDE                        9AP32249
       OCT +030400000000  FAM                                           9AP32250
       BCD 1FDH000        FLOATING DIVIDE OR HALT                       9AP32251
       OCT +024000000000  FDH                                           9AP32252
       BCD 1FDP000        FLOATING DIVIDE OR PROCEED                    9AP32253
       OCT +024100000000  FDP                                           9AP32254
       BCD 1FMP000        FLOATING MULTIPLY                             9AP32255
       OCT +026000000000  FMP                                           9AP32256
       BCD 1FOR000        FOUR                                          9AP32257
       OCT -000000000000  FOR                                           9AP32258
       BCD 1FRN000        FLOATING ROUND                                9AP32259
       OCT +076000000011  FRN                                           9AP32260
       BCD 1FSB000        FLOATING SUBTRACT                             9AP32261
       OCT +030200000000  FSB                                           9AP32262
       BCD 1FSM000        FLOATING SUBTRACT MAGNITUDE                   9AP32263
       OCT +030600000000  FSM                                           9AP32264
       BCD 1FVE000        FIVE                                          9AP32265
       OCT -100000000000  FVE                                           9AP32266
       BCD 1HIT000   HALT INTERVAL TIMER 704 SF                         9AP32267
       OCT 76000000014 HIT 704 SPECIAL FEATURE                          9AP32268
       BCD 1HPR000        HALT AND PROCEED                              9AP32269
       OCT +042000000000  HPR                                           9AP32270
       BCD 1HTR000        HALT AND TRANSFER                             9AP32271
       OCT +000000000000  HTR                                           9AP32272
       BCD 1IIA000        INVERT INDICATORS FROM ACCUMULATOR            9AP32273
       OCT +004100000000  IIA                                           9AP32274
       BCD 1IIL000   INVERT INDICATORS OF LEFT HALF                     9AP32275
       OCT -005100100000 IIL                                            9AP32276
       BCD 1IIR000   INVERT INDICATORS OF RIGHT HALF                    9AP32277
       OCT +005100100000  IIR                                           9AP32278
       BCD 1IIS000        INVERT INDICATORS FROM STORAGE                9AP32279
       OCT +044000000000  IIS                                           9AP32280
       BCD 1IOCD00   I/O COUNT CONTROL + DISCONNECT                     9AP32281
       OCT 000000000000 IOCD                                            9AP32282
       BCD 1IOCDN0   I/O COUNT CTRL + DISC NON-XMIT                     9AP32283
       OCT 000000200000 IOCDN                                           9AP32284
       BCD 1IOCP00   I/O COUNT CONTR AND PROCEED                        9AP32285
       OCT -000000000000 IOCP                                           9AP32286
       BCD 1IOCPN0   I/O COUNT CTRL + PROC NON-XMIT                     9AP32287
       OCT 400000200000 IOCPN                                           9AP32288
       BCD 1IOCT00   I/O COUNT CONTR AND TRANS                          9AP32289
       OCT -100000000000 IOCT                                           9AP32290
       BCD 1IOCTN0   I/O COUNT CTRL + XFER NON-XMIT                     9AP32291
       OCT 500000200000 IOCTN                                           9AP32292
       BCD 1IOD000   I/O DELAY 704                                      9AP32293
       OCT 76600000333 IOD 704 INSTRUCTION                              9AP32294
       BCD 1IORP00   I/O REC. AND PROCEED                               9AP32295
       OCT +200000000000 IORP                                           9AP32296
       BCD 1IORPN0   U/O RECORD + PROC.  NON-XMIT                       9AP32297
       OCT 200000200000 IORPN                                           9AP32298
       BCD 1IORT00   I/O REC. AND TRANSFER                              9AP32299
       OCT +300000000000 IORT                                           9AP32300
       BCD 1IORTN0   I/O RECORD + XFER  NON XMIT                        9AP32301
       OCT 300000200000 IORTN                                           9AP32302
       BCD 1IOSP00   I/O SIGNAL AND PROCEED                             9AP32303
       OCT -200000000000 IOSP                                           9AP32304
       BCD 1IOSPN0   I/O SIGNAL + PROC.  NON XMIT                       9AP32305
       OCT 600000200000 IOSPN                                           9AP32306
       BCD 1IOST00   I/O SIGNAL AND TRANSFER                            9AP32307
       OCT -300000000000 IOST                                           9AP32308
       BCD 1IOSTN0   I/O SIGNAL + XFER  NON XMIT                        9AP32309
       OCT 700000200000 IOSTN                                           9AP32310
       BCD 1IOT000        INPUT OUTPUT CHECK TEST                       9AP32311
       OCT +076000000005  IOT                                           9AP32312
       REM                                                              9AP32313
       ORG     3072                                                     9AP32314
 SIZE      2                                                            9AP32315
 CKSUM                                                                  9AP32316
 STBL                                                                   9AP32317
 ETBL                                                                   9AP32318
       END STRTA                                                        9AP32319
       REM ASSEMBLY OF 9AP4 THE CONTROL RECORD FOR THE SECOND PASS      9AP4 001
                                             10 OCTOBER 1958            9AP4 002
       ORG                                                              9AP4 003
       IOCD    3,0,M                                                    9AP4 004
       TCOB    1                                                        9AP4 005
 TWOT  RTBB    SYSTAP                                                   9AP4 006
       RCHB    IOT                                                      9AP4 007
       TCOB    *                                                        9AP4 008
       PXD                                                              9AP4 009
       AXT     TOT,4                                                    9AP4 010
 LOOPA ACL     FIN,4                                                    9AP4 011
       TIX     LOOPA,4,1                                                9AP4 012
       ERA     SUM2                                                     9AP4 013
       TZE     STARTB                                                   9AP4 014
       HPR                                                              9AP4 015
       BSRB    SYSTAP                                                   9AP4 016
       TXI     TWOT                                                     9AP4 017
 SUM2  PZE                                                              9AP4 018
 IOT   IOCP    SUM2,0,1                                                 9AP4 019
       IORT    110,0,-1                                                 9AP4 020
 M     EQU     14                                                       9AP4 021
 FIN   EQU     2200                                                     9AP4 022
 TOT   EQU     2090                                                     9AP4 023
SYSTAP EQU     1                                                        9AP4 024
STARTB DEFINE  4034                                                     9AP4 025
       END                                                              9AP4 026
       REM ASSEMBLY OF 9AP5 THE SECOND PASS                             9AP5 001
                                             10 OCTOBER 1958            9AP5 002
       ORG 110                                                          9AP5 003
 TERM                                                                   9AP5 004
 TEQ                                                                    9AP5 005
 CH                                                                     9AP5 006
 CHD                                                                    9AP5 007
 EQV                                                                    9AP5 008
 EQVR                                                                   9AP5 009
 SYMB                                                                   9AP5 010
 MQ                                                                     9AP5 011
 BHEAD                                                                  9AP5 012
 THEAD                                                                  9AP5 013
 LOC1  PZE     0,2,0                                                    9AP5 014
 LOC2  PZE     0,2,0                                                    9AP5 015
 M                                                                      9AP5 016
 N                                                                      9AP5 017
 RBITS PZE                                                              9AP5 018
 INDIC PZE                                                              9AP5 019
 RBIT  PZE     0,2,0                                                    9AP5 020
 LMT                                                                    9AP5 021
 LMT1      OCTAL+18,0,18                                                9AP5 022
 LMT2      OCTAL+4,0,4                                                  9AP5 023
       REM                                                              9AP5 024
 Q0        0                                                            9AP5 025
 Q1        1                                                            9AP5 026
 Q2        2                                                            9AP5 027
 Q3        3                                                            9AP5 028
 Q4        4                                                            9AP5 029
 Q5        5                                                            9AP5 030
 Q6        6                                                            9AP5 031
 Q7        7                                                            9AP5 032
 Q8        8                                                            9AP5 033
 Q9        9                                                            9AP5 034
 Q10       10                                                           9AP5 035
       REM                                                              9AP5 036
 MASK  BCD 1                                                            9AP5 037
 HED   BCD 1HED000                                                      9AP5 038
       BCI     1,FUL000                                                 9AP5 039
       BCI     1,FIN000                                                 9AP5 040
 ERROR BCD 1ERROR0                                                      9AP5 041
 EQU   BCD 1EQU000                                                      9AP5 042
 END   BCD 1END000                                                      9AP5 043
       BCI 1,DEFINE                                                     9AP5 044
 DEF   BCD 1DEF000                                                      9AP5 045
 DEC   BCD 1DEC000                                                      9AP5 046
 BSS   BCD 1BSS000                                                      9AP5 047
 BES   BCD 1BES000                                                      9AP5 048
 BEGIN BCD 1BEGIN0                                                      9AP5 049
 BCI   BCD 1BCI000                                                      9AP5 050
 BCDO  BCD 1BCD000                                                      9AP5 051
       BCI     1,ABS000                                                 9AP5 052
       BCI     1,LIB000                                                 9AP5 053
 OCT   BCD 1OCT000                                                      9AP5 054
 ORG   BCD 1ORG000                                                      9AP5 055
       BCI     1,PLR000                                                 9AP5 056
 PST   BCD 1PST000                                                      9AP5 057
       BCI     1,REL000                                                 9AP5 058
 REM   BCD 1REM000                                                      9AP5 059
 REP   BCD 1REP000                                                      9AP5 060
RETURN BCD 1RETURN                                                      9AP5 061
       BCI     1,RST000                                                 9AP5 062
       BCI     1,SKIP00                                                 9AP5 063
 SYN   BCD 1SYN000                                                      9AP5 064
 TCD   BCI     1,TCD000                                                 9AP5 065
       REM                                                              9AP5 066
 VRF       2,0,-1                                                       9AP5 067
 VRF1  PZE 0                                                            9AP5 068
 PWR       0,0,18*512                                                   9AP5 069
 PBIT  MZE                                                              9AP5 070
 1BIT  TIX                                                              9AP5 071
 2BIT  TXI                                                              9AP5 072
 ADDR      -1                                                           9AP5 073
 TAG       0,7                                                          9AP5 074
 DECR      0,0,-1                                                       9AP5 075
 COMMA     59                                                           9AP5 076
 DIVID     49                                                           9AP5 077
 BLANK     48                                                           9AP5 078
 MULT      44                                                           9AP5 079
 MINUS     32                                                           9AP5 080
 PLUS      16                                                           9AP5 081
 B         18                                                           9AP5 082
 E         21                                                           9AP5 083
 HEAD      43                                                           9AP5 084
 POINT     27                                                           9AP5 085
       REM                                                              9AP5 086
 SAVE  BSS 4                                                            9AP5 087
 OCTAL BSS 4                                                            9AP5 088
 BCD   BCI 9,                                                           9AP5 089
       BCI 9,                                                           9AP5 090
       BCI 2,                                                           9AP5 091
       REM                                                              9AP5 092
 LISTM     63                                                           9AP5 093
 LMT3      BCD+1,0,5                                                    9AP5 094
 EXC1  HTR 0,0,+35*512                                                  9AP5 095
 EXC2  TXH 0,0,-35*512                                                  9AP5 096
 DATUM                                                                  9AP5 097
 RESID                                                                  9AP5 098
 DEFIN                                                                  9AP5 099
 BN                                                                     9AP5 100
 EXPN                                                                   9AP5 101
 FL1   TIX 0,0,155*512                                                  9AP5 102
 FL2   TIX 0,0,170*512                                                  9AP5 103
       REM                                                              9AP5 104
 Q128  DEC 128                                                          9AP5 105
       OCT 141500000000,144620000000,147764000000,153470400000          9AP5 106
       OCT 156606500000,161750220000,165461132000,170575360400          9AP5 107
       OCT 173734654500,177452013710,202564416672,205721522451          9AP5 108
       OCT 211443023471,214553630410,217706576512,223434157116          9AP5 109
       OCT 226543212741,231674055532,235425434430,240532743536          9AP5 110
       OCT 243661534466,247417031702,252522640262,255647410336          9AP5 111
       OCT 261410545213,264512676456,267635456171,273402374714          9AP5 112
       OCT 276503074077,301623713116,304770675742,310473426555          9AP5 113
       OCT 313612334311,316755023373,322464114135,325601137164          9AP5 114
       OCT 330741367021,334454732313,337570120775,342726145174          9AP5 115
       OCT 346445677216,351557257061,354713132676,360436770626          9AP5 116
       OCT 363546566774,366700324573,372430204755,375536246150          9AP5 117
       REM                                                              9AP5 118
       REM                                                              9AP5 119
 WOUT  SXA RX1,1                                                        9AP5 120
       SWT     3                   TEST FOR ON LINE PRINT               9AP5 121
       TXI     *+2                 DONT WAIT ON CHANNEL A               9AP5 122
       TCOA    *                                                        9AP5 123
       AXT 20,1                                                         9AP5 124
       CLA BLANKS                                                       9AP5 125
       STO LRIMG+20,1                                                   9AP5 126
       TIX *-1,1,1                                                      9AP5 127
 WT4   CLA LMT                                                          9AP5 128
       STA WT1                                                          9AP5 129
       SXA RX2,2                                                        9AP5 130
       SXA RX4,4                                                        9AP5 131
       PDX 0,2                                                          9AP5 132
       AXC 1,1                                                          9AP5 133
 WT6   CLA LMT2                                                         9AP5 134
       STO LMT                                                          9AP5 135
 WT1   LDQ **,2                                                         9AP5 136
       STQ LRIMG+1,1                                                    9AP5 137
       TXI *+1,1,-1                                                     9AP5 138
       TIX WT1,2,1                                                      9AP5 139
       SWT 5                                                            9AP5 140
       WTDB 3                                                           9AP5 141
       SWT 5                                                            9AP5 142
       RCHB RCW20                                                       9AP5 143
       SWT     3                                                        9AP5 144
       TXI     *+2                                                      9AP5 145
       TXI     *+2                                                      9AP5 146
       TCOB *                                                           9AP5 147
       SWT 3                                                            9AP5 148
       TRA *+2                                                          9AP5 149
       TSX BCD2H,4                                                      9AP5 150
 RX1   AXT **,1                                                         9AP5 151
 RX2   AXT **,2                                                         9AP5 152
 RX4   AXT **,4                                                         9AP5 153
       TRA 1,4                                                          9AP5 154
 RCW20 IOCP    RCW21,0,1         WRITE FIRST WORD                       9AP5 155
       IOCD LRIMG+1,0,19                                                9AP5 156
 BCD2H SXA LRIR1,1           SAVE                                       9AP5 157
       SXA LRIR2,2           INDEX                                      9AP5 158
       SXA LRIR4,4           REGISTERS                                  9AP5 159
       AXT 9,4               TEST                                       9AP5 160
       TNX LRCRT,4,1         WHETHER                                    9AP5 161
       CLA LRIMG+20,4        LAST EIGHT                                 9AP5 162
       CAS     MASK                WORDS ARE                            9AP5 163
       TXL *+2               ALL BLANK                                  9AP5 164
       TRA *-4               AND IF NOT                                 9AP5 165
       SIR 1                 SET INDICATOR                              9AP5 166
 LRCRT AXT 21,4              COUNT IMAGE                                9AP5 167
       SXA LRCRNT,4          WORDS DURING CONVERSION                    9AP5 168
 LRCD1 AXT 32,1              CLEAR LINE IMAGE                           9AP5 169
       TCOA *                AFTER WAITING                              9AP5 170
       STZ LRCRD+7,1         FOR LAST LINE                              9AP5 171
       TIX *-1,1,1           TO FINISH PRINTING                         9AP5 172
       AXT 1,1               SET FIRSTHALF CARD IMAGE                   9AP5 173
 LRWD2 CLA LRBIT             SET COLUMN                                 9AP5 174
       STO LRNDIC            INDICATOR                                  9AP5 175
 LRWD  LXA LRCRNT,4          GET NEXT                                   9AP5 176
       TNX LRWD3,4,1         BCD WORD                                   9AP5 177
       LDQ LRIMG+20,4        INTO MQ                                    9AP5 178
       SXA LRCRNT,4          AND COUNT DOWN                             9AP5 179
 LRLP1 PXD                                                              9AP5 180
       LGL 6                 ISOLATE CHARACTER                          9AP5 181
       CAS 001LR             TEST FOR BLANK                             9AP5 182
       TRA *+2               AND IF NOT, SKIP OVER NEXT                 9AP5 183
       TRA LRSKP             TRANSFER TO LEAVE BIT OUT                  9AP5 184
       LGR 4                 ISOLATE ZONE BITS                          9AP5 185
       ERA 003LR             AND ADJUST ZONE                            9AP5 186
       ALS 1                 FOR USING TO OR                            9AP5 187
       PAC 0,4               INDICATOR BIT INTO CARD                    9AP5 188
       CLM                   IMAGE.                                     9AP5 189
       LGL 4                 ISOLATE DIGIT FOR NUMERIC                  9AP5 190
       ALS 1                 ROW AND PUT THAT IN                        9AP5 191
       PAX 0,2               INDEX REGISTER.                            9AP5 192
       CAL LRNDIC            TEST FOR PLUS AND                          9AP5 193
       TXH *+2,2,0           MINUS SIGNS WHICH                          9AP5 194
       TXH *+2,4,-6          ARE SPECIAL CASES.                         9AP5 195
       ORS LRCRD,3           PUT ZONE AND DIGIT                         9AP5 196
       ORS LRCRD,5           BITS INTO CARD IMAGE                       9AP5 197
LRSKP1 ARS 1                 MOVE COLUMN INDICATOR                      9AP5 198
       SLW LRNDIC            AND RESTORE IT.                            9AP5 199
       ANA LRMSK             TEST FOR END OF                            9AP5 200
       TNZ LRLP1             BCD WORD.                                  9AP5 201
       CAL LRNDIC            TEST FOR END OF                            9AP5 202
       TNZ LRWD              BINARY WORD.                               9AP5 203
 LRWD3 CAL LRCRD-24,1        PUT IN 8-4 ROW                             9AP5 204
       ORS LRCRD-16,1                                                   9AP5 205
       ORS LRCRD-8,1                                                    9AP5 206
       CAL LRCRD-22,1        PUT IN 8-3 ROW                             9AP5 207
       ORS LRCRD-16,1                                                   9AP5 208
       ORS LRCRD-6,1                                                    9AP5 209
       TXL LRCD2,1           IF FINISHED SECOND HALF CARD, PRINT        9AP5 210
       AXT 0,1               IF NOT GO TO PROCESS                       9AP5 211
       TXL LRWD2             SECOND HALF CARD                           9AP5 212
 LRCD2 WPDA                  SELECT PRINTER                             9AP5 213
 LRCD3 NOP                   EITHER                                     9AP5 214
       RCHA LRWTCD                                                      9AP5 215
       RNT 1                                                            9AP5 216
       TXL LROUT                                                        9AP5 217
       CLA LRSPRA                                                       9AP5 218
       STO LRCD3                                                        9AP5 219
       RIR 1                                                            9AP5 220
       TXL LRCD1                                                        9AP5 221
 LROUT CLA LRNOP                                                        9AP5 222
       STO LRCD3                                                        9AP5 223
 LRIR1 AXT 0,1                                                          9AP5 224
 LRIR2 AXT 0,2                                                          9AP5 225
 LRIR4 AXT 0,4                                                          9AP5 226
       TRA 1,4                                                          9AP5 227
 LRSKP CAL LRNDIC                                                       9AP5 228
       TXL LRSKP1                                                       9AP5 229
LRNDIC BSS 1                                                            9AP5 230
LRCRNT BSS 1                                                            9AP5 231
 LRIMG BSS 20                                                           9AP5 232
 LRCRD BES 25                                                           9AP5 233
       BSS 7                                                            9AP5 234
 001LR SYN BLANK                                                        9AP5 235
LRWTCD IOCD LRCRD-19,0,24                                               9AP5 236
LRSPRA SPRA 9                                                           9AP5 237
 LRMSK OCT 773737373737                                                 9AP5 238
 ABPCH CAL     1,4                 PICK UP CONTROL WORD                 9AP5 239
       TCOA    *                   WAIT IF BUFFER NOT EMPTY             9AP5 240
       STD     PCH1                SAVE WORD COUNT                      9AP5 241
       ARS     18                  FORM LAST                            9AP5 242
       ADD     PCH1                WORD PLUS                            9AP5 243
       STA     PCH2                ONE ADDRESS                          9AP5 244
       STA     PCH3                X                                    9AP5 245
       SBM     1,4                 TEST FOR NEGATIVE PUNCH              9AP5 246
       TZE     2,4                 RANGE. EXIT IF NEGATIVE              9AP5 247
       TMI     2,4                 OR ZERO                              9AP5 248
       SXD     PCH1,1              SAVE THE INDEX REGISTERS             9AP5 249
       SXD     PCH4,2              X                                    9AP5 250
       SXA     PCH4,4              X                                    9AP5 251
       PAX     0,1                 WORD COUNT TO IR1                    9AP5 252
       CLA     2,4                 PICK UP STARTING POINT               9AP5 253
       AXT     0,4                 RESET IR4                            9AP5 254
 PCH8  STA     VR                  FORM PART OF 9ROWL                   9AP5 255
       CLM                         X                                    9AP5 256
       LXA     PCH1,2              ONE TO IR2                           9AP5 257
 PCH2  ACL     **,1                FORM THE CHECKSUM                    9AP5 258
       TXH     PCH5,2,21           FOR THE CARD.  TEST FOR THE END OF   9AP5 259
       TNX     PCH5,1,1            THE CARD OR THE END OF THE BLOCK     9AP5 260
       TXI     PCH2,2,1            X                                    9AP5 261
 PCH5  SXD     PCH6,2              SAVE THE COUNT                       9AP5 262
       SXD     VR,2                PUT THE WORD COUNT INTO THE CARD     9AP5 263
       ACL     VR                  FINISH THE CHECKSUM                  9AP5 264
       LDQ     VR                  AND MOVE 9ROW TO                     9AP5 265
       STQ     BUFFER,4            THE BUFFER AREA                      9AP5 266
       SLW     BUFFER+1,4          X                                    9AP5 267
       TXI     PCH6,4,-2           X                                    9AP5 268
 PCH6  TXI     PCH9,1,**           RESET IR1 TO THE START OF THE CARD   9AP5 269
 PCH9  TXI     PCH3,1,-1           X                                    9AP5 270
 PCH3  LDQ     **,1                MOVE THE REST OF THE CARD IMAGE      9AP5 271
       STQ     BUFFER,4            TO THE BUFFER AREA                   9AP5 272
       TXI     PCH11,4,-1          X                                    9AP5 273
 PCH11 TIX     PCH9,2,1            X                                    9AP5 274
 PCH7  CLA     VR                  FORM NEXT 9 ROW LEFT                 9AP5 275
       ARS     18                  ADDRESS                              9AP5 276
       ADD     VR                  X                                    9AP5 277
       TIX     PCH8,1,1            GO FOR NEXT CARD                     9AP5 278
       PXD     0,4                 FORM COUNT FOR THE IO COMMAND        9AP5 279
       PDC     0,4                                                      9AP5 280
       SXD     PCH20,4                                                  9AP5 281
       WPUA                                                             9AP5 282
       LXD     PCH1,1              RESTORE THE INDEX REGISTERS          9AP5 283
       LXD     PCH4,2              X                                    9AP5 284
       LXA     PCH4,4              X                                    9AP5 285
       RCHA    PCH20                                                    9AP5 286
       TRA     3,4                                                      9AP5 287
 PCH20 IOCD    BUFFER,0,**                                              9AP5 288
BUFFER BSS     120                                                      9AP5 289
       REM                                                              9AP5 290
       REM                                                              9AP5 291
 PCH1      1                                                            9AP5 292
 PCH4                                                                   9AP5 293
 VR                                                                     9AP5 294
 SUM                                                                    9AP5 295
       REM                                                              9AP5 296
 SCAN7 LXA     CH,4                                                     9AP5 297
       TXL     SCAN6,4,47                                               9AP5 298
       TXL     EQL,4,48            BLANK TRANSFER                       9AP5 299
       TXL     SCAN6,4,58                                               9AP5 300
       TXL     EQL,4,59            COMMA TRANSFER                       9AP5 301
       TXI     SCAN6                                                    9AP5 302
       REM                                                              9AP5 303
 SCAN  SXD     SCAN1,4             SAVE IR4 FOR RETURN                  9AP5 304
       STZ     RBITS               CLEAR WORKING LOCATIONS              9AP5 305
       STZ     TERM                X                                    9AP5 306
       STZ     TEQ                 X                                    9AP5 307
       CLA     CH                  TEST FOR A BLANK                     9AP5 308
       SUB     BLANK               X                                    9AP5 309
       TZE     1,4                 FIELD IS BLANK. RETURN WITH ZERO     9AP5 310
       CLA     ADD1                SET TRANSFER SWITCH FOR FIRST SYMBOL 9AP5 311
       STD     OP1                 IN EXPRESSION                        9AP5 312
 SCAN6 CLA     BHEAD               SET CURRENT HEADING CHARACTER        9AP5 313
       STO     THEAD               X                                    9AP5 314
       LDQ     MQ                  PICK UP WORD OF EXPRESSION           9AP5 315
 SCAN9 STZ     EQV                 RESET MORE WORKING SPACE             9AP5 316
       STZ     EQVR                X                                    9AP5 317
       STZ     SYMB                X                                    9AP5 318
 SCAN1 TXI     SCAN8+1             NORMAL START OF SCAN                 9AP5 319
       REM                                                              9AP5 320
 EQL   CLA     TERM                COMPLETE VALUE OF EXPRESSION         9AP5 321
       ADD     TEQ                 X                                    9AP5 322
       STO     TEQ                 X                                    9AP5 323
       TZE     EQL3                SUPPLY COMPLEMENT INDICATOR IF TEQ MI9AP5 324
       TPL     EQL3                NUS                                  9AP5 325
       CLS     RBITS               SET RBITS MINUS ON TEQ MINUS         9AP5 326
       STO     RBITS                                                    9AP5 327
 EQL3  CLA     Q2                  TEST FOR RELOCATABLE FIELD           9AP5 328
       SBM     RBITS               X                                    9AP5 329
       TZE     EQL1                RELOCATABLE                          9AP5 330
       STZ     RBITS                                                    9AP5 331
 EQL1  CLA     RBITS                                                    9AP5 332
       TZE     EQL2                                                     9AP5 333
       TPL     EQL2                INSERT COMPLEMENT INDICATOR ON RBITS 9AP5 334
       ORA     Q1                  MINUS                                9AP5 335
       SLW     RBITS               X                                    9AP5 336
 EQL2  CAL     PBIT                IF TEQ MINUS PROVIDE COMPLEMENT      9AP5 337
       ADD     TEQ                 X                                    9AP5 338
       ANA     ADDR                SAVE ADDRESS ONLY                    9AP5 339
       STO     TEQ                 X                                    9AP5 340
       LXD     SCAN1,4                                                  9AP5 341
       TRA     1,4                 NORMAL EXIT                          9AP5 342
       REM                                                              9AP5 343
 SCAN4 PXD                         CLEAR AC                             9AP5 344
       LGL     6                   BRING IN CHAR. FROM VAR. FIELD       9AP5 345
       STO     CH                  SAVE SAME                            9AP5 346
       CAS     COMMA                                                    9AP5 347
       TXI     SCAN3                                                    9AP5 348
       TXI     EQ                                                       9AP5 349
       CAS     DIVID                                                    9AP5 350
       TXI     SCAN3                                                    9AP5 351
       TXI     DIV                                                      9AP5 352
       CAS     BLANK                                                    9AP5 353
       TXI     SCAN3                                                    9AP5 354
       TXI     EQ                                                       9AP5 355
       CAS     MULT                                                     9AP5 356
       TXI     SCAN3                                                    9AP5 357
       TXI     MPY                                                      9AP5 358
       CAS     HEAD                                                     9AP5 359
       TXI     SCAN3                                                    9AP5 360
       TXI     HEAD1                                                    9AP5 361
       CAS     MINUS                                                    9AP5 362
       TXI     SCAN3                                                    9AP5 363
       TXI     SUB                                                      9AP5 364
       CAS     PLUS                                                     9AP5 365
       TXI     SCAN3                                                    9AP5 366
       TXI     ADD                                                      9AP5 367
       REM                                                              9AP5 368
 SCAN3 CAL     SYMB                                                     9AP5 369
       ALS     6                                                        9AP5 370
       ADD     CH                                                       9AP5 371
 SCAN8 SLW     SYMB                                                     9AP5 372
 SCAN2 TIX     SCAN4,1,1                                                9AP5 373
       TXI     SCAN5,2,-1                                               9AP5 374
 SCAN5 LDQ     BCD,2                                                    9AP5 375
       TXI     SCAN4,1,5                                                9AP5 376
       REM                                                              9AP5 377
 EQ1   SXD     SCAN-1,4                                                 9AP5 378
 EQ    STQ     MQ                                                       9AP5 379
       CAL     SYMB                                                     9AP5 380
       CAS     MULT                                                     9AP5 381
       TRA     EQ+5                                                     9AP5 382
       TRA     SAME                                                     9AP5 383
       ANA     MASK                                                     9AP5 384
       TZE     EQ5                                                      9AP5 385
       LDQ     SYMB                                                     9AP5 386
 EQ7   PXD     -EQ2-3              CLEAR AC                             9AP5 387
       LGL     6                                                        9AP5 388
       TNZ     EQ2                                                      9AP5 389
       CAL     THEAD               INSERT CURRENT HEADING CHARACTER     9AP5 390
 EQ2   LGL     30                  BRING REST OF SYMBOL INTO AC         9AP5 391
       SLW     SYMB                SAVE THE SYMBOL                      9AP5 392
       TSX     SRCH,4              SEARCH THE SYMBOL TABLE              9AP5 393
       STA     EQV                                                      9AP5 394
       LXD     OP1,4                                                    9AP5 395
       ARS     15                                                       9AP5 396
       ORS     RBITS                                                    9AP5 397
       CAL     SCAN-1                                                   9AP5 398
       STD     OP1                                                      9AP5 399
       TRA     1,4                                                      9AP5 400
       REM                                                              9AP5 401
 EQ5   LXA     EQ7,4               BCD TO BINARY                        9AP5 402
 INT   SXD     INT1,4              X                                    9AP5 403
       PXD                         X                                    9AP5 404
       LXA     Q6,4                X                                    9AP5 405
       LDQ     SYMB                X                                    9AP5 406
 INT4  LGL     6                                                        9AP5 407
       TNZ     INT3                                                     9AP5 408
       TIX     INT4,4,1                                                 9AP5 409
 INT1  TXL     INT3                                                     9AP5 410
       REM                                                              9AP5 411
 INT2  PXD                                                              9AP5 412
       LGL     6                                                        9AP5 413
       SLW     CHD                                                      9AP5 414
       CLA     EQV                                                      9AP5 415
       ALS     2                                                        9AP5 416
       ADD     EQV                                                      9AP5 417
       ALS     1                                                        9AP5 418
       ADD     CHD                                                      9AP5 419
 INT3  STO     EQV                                                      9AP5 420
       TIX     INT2,4,1                                                 9AP5 421
       LXD     INT1,4                                                   9AP5 422
       TRA     1,4                                                      9AP5 423
       REM                                                              9AP5 424
 ADD   TSX     EQ1,4                                                    9AP5 425
       CLA     TERM                                                     9AP5 426
       ADD     TEQ                                                      9AP5 427
       STO     TEQ                                                      9AP5 428
       CLA     EQV                                                      9AP5 429
       STO     TERM                                                     9AP5 430
 ADD1  TXL     SCAN7,0,-ADD                                             9AP5 431
       REM                                                              9AP5 432
 SUB   TSX     EQ1,4                                                    9AP5 433
       CLA     TERM                                                     9AP5 434
       ADD     TEQ                                                      9AP5 435
       STO     TEQ                                                      9AP5 436
       CLS     EQV                                                      9AP5 437
       STO     TERM                                                     9AP5 438
       TXL     SCAN7                                                    9AP5 439
       REM                                                              9AP5 440
 MPY   CLA     SYMB                                                     9AP5 441
       TZE     SCAN3+2                                                  9AP5 442
       TSX     EQ1,4                                                    9AP5 443
       LDQ     TERM                                                     9AP5 444
       MPY     EQV                                                      9AP5 445
       STQ     TERM                                                     9AP5 446
 OP1   TXL     SCAN7                                                    9AP5 447
       REM                                                              9AP5 448
 DIV   TSX     EQ1,4                                                    9AP5 449
       CLA     TERM                                                     9AP5 450
       LRS     35                                                       9AP5 451
       DVP     EQV                                                      9AP5 452
       TRA     MPY+5                                                    9AP5 453
       REM                                                              9AP5 454
 HEAD1 CAL     SYMB                                                     9AP5 455
       STO     THEAD                                                    9AP5 456
       TXL     SCAN9                                                    9AP5 457
       REM                                                              9AP5 458
 SAME  CLA     LOC2                                                     9AP5 459
       TRA     EQ2+3                                                    9AP5 460
       REM                                                              9AP5 461
 ORGOP TSX SCAN,4         ESTABLISH NEW                                 9AP5 462
       CLA Q0                                                           9AP5 463
 ORG1  ADD TEQ                                                          9AP5 464
       STA     LOC2                                                     9AP5 465
 ORG2  STA     LOC1                                                     9AP5 466
       TSX PUNCH,4                                                      9AP5 467
       TSX PRNTC,4                                                      9AP5 468
       TXL RTD                                                          9AP5 469
       REM                                                              9AP5 470
 BESOP TSX SCAN,4         INCREMENT LOCATION                            9AP5 471
       CLA LOC1           COUNTER AND MAKE                              9AP5 472
       TXL ORG1                                                         9AP5 473
       REM                                                              9AP5 474
 BSSOP TSX SCAN,4         INCREMENT LOCATION                            9AP5 475
       CLA LOC1           COUNTER AND                                   9AP5 476
       ADD TEQ                                                          9AP5 477
       TXL ORG2                                                         9AP5 478
       REM                                                              9AP5 479
 PRNTC LDQ LOC2                                                         9AP5 480
       PXD                                                              9AP5 481
       SLW OCTAL+3                                                      9AP5 482
       LGL 21                                                           9AP5 483
       CAL BLANKS                                                       9AP5 484
       SLW OCTAL                                                        9AP5 485
       SLW OCTAL+1                                                      9AP5 486
       ALS 6                                                            9AP5 487
       SLW OCTAL+2                                                      9AP5 488
       TXL PRI3-4                                                       9AP5 489
       REM                                                              9AP5 490
PRINTD LDQ DATUM                                                        9AP5 491
       CLA PLUS                                                         9AP5 492
       TQP PRD2                                                         9AP5 493
       CLA MINUS                                                        9AP5 494
       LRS                                                              9AP5 495
 PRD2  SXD XM,4                                                         9AP5 496
       LXA Q5,4                                                         9AP5 497
 PRD3  ALS 3                                                            9AP5 498
       LGL 3                                                            9AP5 499
       TIX PRD3,4,1                                                     9AP5 500
       SLW OCTAL+1                                                      9AP5 501
       LXA Q6,4                                                         9AP5 502
 PRD4  ALS 3                                                            9AP5 503
       LGL 3                                                            9AP5 504
       TIX PRD4,4,1                                                     9AP5 505
       SLW OCTAL+2                                                      9AP5 506
       PXD                                                              9AP5 507
       LGL 3                                                            9AP5 508
       LDQ MASK                                                         9AP5 509
       LGL 30                                                           9AP5 510
       SLW OCTAL+3                                                      9AP5 511
 XM    TXL PRINTL                                                       9AP5 512
       REM                                                              9AP5 513
PRINTW LDQ DATUM                                                        9AP5 514
       CLA BLANK                                                        9AP5 515
       TXL PRD2                                                         9AP5 516
       REM                                                              9AP5 517
PRINTI SXD XM,4                                                         9AP5 518
       LDQ WORD                                                         9AP5 519
       CLA BLANK                                                        9AP5 520
       TQP PRI1                                                         9AP5 521
       CLA MINUS                                                        9AP5 522
       LRS                                                              9AP5 523
 PRI1  STO SAVE                                                         9AP5 524
       CLA WORD                                                         9AP5 525
       ANA THREE                                                        9AP5 526
       TNZ TYPEA                                                        9AP5 527
       LXA Q4,4                                                         9AP5 528
       CLA SAVE+1                                                       9AP5 529
       CAS BL+1,4                                                       9AP5 530
       TRA TYPEB                                                        9AP5 531
       TRA TYPEA                                                        9AP5 532
       TIX PRI1+6,4,1                                                   9AP5 533
       REM                                                              9AP5 534
 TYPEB CLA SAVE                                                         9AP5 535
       LXA Q4,4                                                         9AP5 536
       ALS 3                                                            9AP5 537
       LGL 3                                                            9AP5 538
       TIX TYPEB+2,4,1                                                  9AP5 539
       ALS 6                                                            9AP5 540
       ORA BLANK                                                        9AP5 541
       TRA PRI2+3                                                       9AP5 542
       REM                                                              9AP5 543
 TYPEA CLA SAVE                                                         9AP5 544
       ALS 3                                                            9AP5 545
       LGL 3                                                            9AP5 546
       ALS 6                                                            9AP5 547
       ORA BLANK                                                        9AP5 548
       LXA Q3,4                                                         9AP5 549
 PRI2  ALS 3                                                            9AP5 550
       LGL 3                                                            9AP5 551
       TIX PRI2,4,1                                                     9AP5 552
       ORS OCTAL+1                                                      9AP5 553
       PXD                                                              9AP5 554
       LGL 3                                                            9AP5 555
       ALS 3                                                            9AP5 556
       LGL 3                                                            9AP5 557
       ALS 6                                                            9AP5 558
       ORA BLANK                                                        9AP5 559
       SLT 4                                                            9AP5 560
       TRA PRI4                                                         9AP5 561
       ALS 6                                                            9AP5 562
       ORA BLANK                                                        9AP5 563
       ALS 3                                                            9AP5 564
       LGL 3                                                            9AP5 565
       TXL PRI5                                                         9AP5 566
       REM                                                              9AP5 567
 PRI4  ALS 3                                                            9AP5 568
       LGL 3                                                            9AP5 569
       ALS 6                                                            9AP5 570
       ORA BLANK                                                        9AP5 571
 PRI5  SLN     4                                                        9AP5 572
       ALS     3                                                        9AP5 573
       LGL     3                                                        9AP5 574
       ORS OCTAL+2                                                      9AP5 575
       LXA Q4,2                                                         9AP5 576
 PRI3  ALS 3                                                            9AP5 577
       LGL 3                                                            9AP5 578
       TIX PRI3,2,1                                                     9AP5 579
       LDQ MASK                                                         9AP5 580
       LGL 12                                                           9AP5 581
       ORS OCTAL+3                                                      9AP5 582
       SLT 4                                                            9AP5 583
       TXL WOT                                                          9AP5 584
       REM                                                              9AP5 585
PRINTL CLA LOC1                                                         9AP5 586
       STO LOC2                                                         9AP5 587
       ADD Q1                                                           9AP5 588
       STO LOC1                                                         9AP5 589
       LDQ LOC2                                                         9AP5 590
       LGL 21                                                           9AP5 591
       LXA Q5,4                                                         9AP5 592
 PRL1  ALS 3                                                            9AP5 593
       LGL 3                                                            9AP5 594
       TIX PRL1,4,1                                                     9AP5 595
       ALS 6                                                            9AP5 596
       ORA BLANK                                                        9AP5 597
       SLW OCTAL                                                        9AP5 598
       TSX STORE,4                                                      9AP5 599
       LXD XM,4                                                         9AP5 600
       TXL WOT                                                          9AP5 601
       REM                                                              9AP5 602
 BCIOP CLA CH                                                           9AP5 603
       PAX BCD+3,2                                                      9AP5 604
       ADD BCIOP+1                                                      9AP5 605
       STA BCI2                                                         9AP5 606
       TCOB    *                                                        9AP5 607
       STZ     INDIC                                                    9AP5 608
       LDQ BCD+2                                                        9AP5 609
       LXD SAVE+2,1                                                     9AP5 610
       PXD 0,1                                                          9AP5 611
       ARS 18                                                           9AP5 612
       ADD Q6                                                           9AP5 613
       STA BCI2-1                                                       9AP5 614
       RQL 30,1                                                         9AP5 615
       LGL 0                                                            9AP5 616
 BCI2  LDQ 0,2                                                          9AP5 617
       LGL 30,1                                                         9AP5 618
       STQ MQ                                                           9AP5 619
       SLW WORD                                                         9AP5 620
       TSX PRINTW,4                                                     9AP5 621
       LDQ MQ                                                           9AP5 622
       TIX BCI2-1,2,1                                                   9AP5 623
       TXL RTD                                                          9AP5 624
       REM                                                              9AP5 625
 SRCH  SXD SRCH6,1                                                      9AP5 626
       SXD SRCH7,2                                                      9AP5 627
       LXD SIZE,1         SETUP SEARCH                                  9AP5 628
       LXA SIZE,2                                                       9AP5 629
       SXD SRCH1,1                                                      9AP5 630
       LXA Q0,1                                                         9AP5 631
       CLA SYMB                                                         9AP5 632
       CAS STBL                                                         9AP5 633
       TRA SRCH5,2                                                      9AP5 634
       TXL SRCH4                                                        9AP5 635
       TXL UNDEF                                                        9AP5 636
       REM                                                              9AP5 637
 SRCH1 TXL SRCH2,1        ASSURE RANGE                                  9AP5 638
       CAS STBL,1         TEST LIVE INDICATED                           9AP5 639
       TXI SRCH5,2,-2     TRY LARGER SYMBOL                             9AP5 640
       TXL SRCH4          SYMBOL FOUND                                  9AP5 641
 SRCH2 TXI SRCH3,2,-2     TRY SMALLER SYMBOL                            9AP5 642
       TXI SRCH1,1,+16384                                               9AP5 643
       TXI SRCH1,1,-16384                                               9AP5 644
       TXI SRCH1,1,+8192                                                9AP5 645
       TXI SRCH1,1,-8192                                                9AP5 646
       TXI SRCH1,1,+4096                                                9AP5 647
       TXI SRCH1,1,-4096                                                9AP5 648
       TXI SRCH1,1,+2048                                                9AP5 649
       TXI SRCH1,1,-2048                                                9AP5 650
       TXI SRCH1,1,+1024                                                9AP5 651
       TXI SRCH1,1,-1024                                                9AP5 652
       TXI SRCH1,1,+512                                                 9AP5 653
       TXI SRCH1,1,-512                                                 9AP5 654
       TXI SRCH1,1,+256                                                 9AP5 655
       TXI SRCH1,1,-256                                                 9AP5 656
       TXI SRCH1,1,+128                                                 9AP5 657
       TXI SRCH1,1,-128                                                 9AP5 658
       TXI SRCH1,1,+64                                                  9AP5 659
       TXI SRCH1,1,-64                                                  9AP5 660
       TXI SRCH1,1,+32                                                  9AP5 661
       TXI SRCH1,1,-32                                                  9AP5 662
       TXI SRCH1,1,+16                                                  9AP5 663
       TXI SRCH1,1,-16                                                  9AP5 664
       TXI SRCH1,1,+8                                                   9AP5 665
       TXI SRCH1,1,-8                                                   9AP5 666
       TXI SRCH1,1,+4                                                   9AP5 667
       TXI SRCH1,1,-4                                                   9AP5 668
       TXI SRCH1,1,+2                                                   9AP5 669
       TXI SRCH1,1,-2                                                   9AP5 670
 SRCH6 TXL UNDEF          EXIT IF UNSUCCESSFUL                          9AP5 671
 SRCH7 TXL UNDEF          SEARCH                                        9AP5 672
       REM                                                              9AP5 673
 SRCH3 TRA SRCH3,2        INCREASE INDEX BY 2 TO K                      9AP5 674
 SRCH5 TRA SRCH5,2        DECREASE INDEX BY 2 TO K                      9AP5 675
       REM                                                              9AP5 676
 UNDEF SLN 1                   LITE IF NO DEF                           9AP5 677
       LXD SIZE,1                                                       9AP5 678
 DEF2  TXL DEF1,1              SEARCH LIST OF                           9AP5 679
       CAS STBL,1              UNDEFINED SYMBOLS                        9AP5 680
       TXI DEF2,1,-2                                                    9AP5 681
       TXL SRCH4               RETURN IF FOUND                          9AP5 682
       TXI DEF2,1,-2                                                    9AP5 683
       REM                                                              9AP5 684
 DEF1  STO STBL,1              STORE NEW UNDEFINED                      9AP5 685
       CLA DEFIN               SYMBOL AND ITS                           9AP5 686
       STO ETBL,1              EQUIVALENCE                              9AP5 687
       ADD Q1                  STEP EQUIVALENCE                         9AP5 688
       STO DEFIN               DEFINITION                               9AP5 689
       TXI DEF3,1,-2           STEP STBL LOC                            9AP5 690
 DEF3  TXL FULLT,1,STBL                                                 9AP5 691
       SXD DEF2,1                                                       9AP5 692
       TXI SRCH4,1,2                                                    9AP5 693
       REM                                                              9AP5 694
 FULLT SLN 1                                                            9AP5 695
 SRCH4 CLA ETBL,1                                                       9AP5 696
       STO EQVR                                                         9AP5 697
       LXD SRCH6,1                                                      9AP5 698
       LXD SRCH7,2                                                      9AP5 699
       TRA 1,4                                                          9AP5 700
       REM                                                              9AP5 701
 START CLA SIZE                                                         9AP5 702
       STD DEF2                                                         9AP5 703
 RTD   LXA Q0,1                                                         9AP5 704
 RTDA  AXT 14,4                                                         9AP5 705
       CLA BLANKS                                                       9AP5 706
       STO BCD+14,4                                                     9AP5 707
       TIX *-1,4,1                                                      9AP5 708
       STO     RCW21               RESET THE UNDEFINED FLAGS            9AP5 709
       RTDB 2                                                           9AP5 710
       RCHB RCW7                                                        9AP5 711
       LCHB    RCW26                                                    9AP5 712
       TRCB RTTD                                                        9AP5 713
       TXL *+5                                                          9AP5 714
       REM                                                              9AP5 715
 RTTE  BSRB 2                                                           9AP5 716
       TXI RTDA,1,1                                                     9AP5 717
 RTTD  TXL RTTE,1,5                                                     9AP5 718
       HPR 29127     PUSH START TO CONTINUE                             9AP5 719
       REM           AND ACCEPT FIFTH READING                           9AP5 720
 CTRL  NOP                                                              9AP5 721
       SLF                                                              9AP5 722
       STZ     INDIC                                                    9AP5 723
       CLA     LOC1                                                     9AP5 724
       STO     LOC2                                                     9AP5 725
       LDQ     BCD                                                      9AP5 726
       CLA     Q0                                                       9AP5 727
       LGL     6                                                        9AP5 728
       SUB     MULT                                                     9AP5 729
       TNZ     CTRLA                                                    9AP5 730
       TCOB *
 RMKA  LXD RMK,4                                                        9AP5 731
       CAL BCD+14,4                                                     9AP5 732
       SLW OCTAL+14,4                                                   9AP5 733
       TIX RMKA+1,4,1                                                   9AP5 734
       TXI RMKB,4,3                                                     9AP5 735
 RMKB  CAL BLANKS                                                       9AP5 736
       SLW BCD+14,4                                                     9AP5 737
       TIX RMKB+1,4,1                                                   9AP5 738
       CLA LMT1                                                         9AP5 739
       STO LMT                                                          9AP5 740
       TSX WOT,4                                                        9AP5 741
 RMK   TXL RTD,,14                                                      9AP5 742
       REM                                                              9AP5 743
 RELOP TSX     PUNCH,4                                                  9AP5 744
       CAL     THREE                                                    9AP5 745
       STP     ENDOP+5                                                  9AP5 746
       CLA     RELB                                                     9AP5 747
       STO     PCH5+1                                                   9AP5 748
       CLA     REL1                                                     9AP5 749
       STO     STORE+1                                                  9AP5 750
       CLA     1BIT                                                     9AP5 751
       STO     VR                                                       9AP5 752
       CLA     ABS1                                                     9AP5 753
       STD     ST2                                                      9AP5 754
       CLA     REL1                                                     9AP5 755
       STD     PCH5-3                                                   9AP5 756
 ABS1  TXL     RTD,0,-110                                               9AP5 757
 REL1  TXI     RLCPU,0,21                                               9AP5 758
 RELB  TXI     RLC10,2,-2                                               9AP5 759
       REM                                                              9AP5 760
 RLCPU LXD     RLC1,4              COUNT 20 WORDS FOR                   9AP5 761
       TIX     RLC2,4,1            RELOCATABLE CARDS                    9AP5 762
       CLA     RLC3                RESET COUNT TO TWENTY                9AP5 763
       STD     RLC1                X                                    9AP5 764
       LXD     WCT,4               CLEAR RELOCATION                     9AP5 765
       SXD     RLC8,4                                                   9AP5 766
       SXD     RLC6,0              INDICATOR BITS                       9AP5 767
       STZ     0,4                 AND ADJUST TOTAL WORD COUNT          9AP5 768
       STZ     1,4                                                      9AP5 769
       TXI     RLC4,4,-2                                                9AP5 770
 RLC2  SXD     RLC1,4              STORE CARD WORD COUNT                9AP5 771
       LXD     WCT,4               LOAD TOTAL WORD COUNT                9AP5 772
 RLC4  CLA     WORD                                                     9AP5 773
       STO     0,4                                                      9AP5 774
       TXI     RLC5,4,-1                                                9AP5 775
 RLC5  SXD     WCT,4                                                    9AP5 776
       SLN     1                                                        9AP5 777
       LXD     INDIC,4                                                  9AP5 778
 RLCE  PXD     0,4                                                      9AP5 779
       LXD     RLC6,4                                                   9AP5 780
       TXI     RLC7,4,1                                                 9AP5 781
 RLC7  SXD     RLC6,4                                                   9AP5 782
       TZE     RLCA                                                     9AP5 783
       TXI     RLCB,4,1                                                 9AP5 784
 RLCB  SXD     RLC6,4                                                   9AP5 785
       LRS     53                                                       9AP5 786
       LGL     72,4                                                     9AP5 787
       LXD     RLC8,4                                                   9AP5 788
       ORS     0,4                                                      9AP5 789
       LGL     36                                                       9AP5 790
       ORS     1,4                                                      9AP5 791
 RLCA  SLT     1                                                        9AP5 792
 RLC1  TXL     RLCC                                                     9AP5 793
       LXA     INDIC,4                                                  9AP5 794
 RLC6  TXL     RLCE                                                     9AP5 795
 RLCC  LXD     RLC6,4                                                   9AP5 796
       TXH     ST8,4,68                                                 9AP5 797
       LXD     WCT,4                                                    9AP5 798
 RLC3  TXL     ST2,0,20                                                 9AP5 799
 RLC10 SXD     VR,2                                                     9AP5 800
       TXI     PCH5+2,2,2                                               9AP5 801
       REM                                                              9AP5 802
 FULOP TSX     PUNCH,4               PUNCH WAITING OUTPUT               9AP5 803
       CAL L24WD     SET 24 WDS/CARD                                    9AP5 804
       SLW PCH5-3    OUTPUT FORMAT                                      9AP5 805
       CAL L24WD+1                                                      9AP5 806
       SLW PCH5+1                                                       9AP5 807
       CAL L24WD+2                                                      9AP5 808
       SLW ST2                                                          9AP5 809
       TXL     ABSOP+7                                                  9AP5 810
       REM                                                              9AP5 811
 ABSOP TSX     PUNCH,4               PUNCH WAITING OUTPUT               9AP5 812
       CAL LABS      SET ABSOLUTE FORMAT                                9AP5 813
       SLW PCH5-3                                                       9AP5 814
       CAL LABS+1                                                       9AP5 815
       SLW PCH5+1                                                       9AP5 816
       CAL LABS+2                                                       9AP5 817
       SLW ST2                                                          9AP5 818
       CAL     XYZ10                                                    9AP5 819
       SLW     STORE+1                                                  9AP5 820
       STZ     VR                                                       9AP5 821
       CAL     CTRLA-1                                                  9AP5 822
       STP     ENDOP+5                                                  9AP5 823
       TXL RTD                                                          9AP5 824
       REM                                                              9AP5 825
 CTRLA CLA BCD                                                          9AP5 826
       SUB BLANKS                                                       9AP5 827
       TZE CTRL1                                                        9AP5 828
       LDQ BCD                                                          9AP5 829
       PXD                SYMBOL                                        9AP5 830
       SLW SYMB                                                         9AP5 831
       LXA Q6,4                                                         9AP5 832
 ABLC2 LGL 6                                                            9AP5 833
       SLW CH                                                           9AP5 834
       SUB BLANK                                                        9AP5 835
       TZE ABLC1                                                        9AP5 836
       CAL SYMB                                                         9AP5 837
       ALS 6                                                            9AP5 838
       ADM CH                                                           9AP5 839
       SLW SYMB                                                         9AP5 840
       PXD                                                              9AP5 841
 ABLC1 TIX ABLC2,4,1                                                    9AP5 842
       CAL SYMB           TEST CONDENSED                                9AP5 843
       ANA MASK           SYMBOL FOR                                    9AP5 844
       TNZ CTRL1          DECIMAL INTEGER                               9AP5 845
       TSX INT,4          OBTAIN BINARY INTEGER                         9AP5 846
       STA LOC2                                                         9AP5 847
       CLA LOC1           TEST FOR CONSECUTIVE                          9AP5 848
       SUB LOC2           ADDRESSES                                     9AP5 849
       TZE CTRL1                                                        9AP5 850
       CLA EQV                                                          9AP5 851
       STO LOC1           COUNTER AND                                   9AP5 852
       TSX PUNCH,4        PUNCH PREVIOUS BLOCK                          9AP5 853
 CTRL1 LXA PKJ,1                                                        9AP5 854
       CAL BCD+1                                                        9AP5 855
       LDQ BCD+2                                                        9AP5 856
       LGL 6                                                            9AP5 857
       SLW SAVE                                                         9AP5 858
       LGL 18                                                           9AP5 859
       SLW SAVE+1                                                       9AP5 860
       LDQ SAVE+1                                                       9AP5 861
 PKB   CLA Q0                                                           9AP5 862
       LGL 6                                                            9AP5 863
       SUB MULT                                                         9AP5 864
       TZE PKA                                                          9AP5 865
       SUB Q4                                                           9AP5 866
       TZE PKA+1                                                        9AP5 867
       TXI PKB,1,-6                                                     9AP5 868
       REM                                                              9AP5 869
 PKA   SLN 2                                                            9AP5 870
       SXD SAVE+1,1                                                     9AP5 871
       CLM                                                              9AP5 872
       LGL 6                                                            9AP5 873
       SUB BLANK                                                        9AP5 874
       TNZ PKC                                                          9AP5 875
       TXL PKC,1,0                                                      9AP5 876
       TXI PKA+2,1,-6                                                   9AP5 877
       REM                                                              9AP5 878
 PKC   ADD BLANK                                                        9AP5 879
       STO CH                                                           9AP5 880
       SXD SAVE+2,1                                                     9AP5 881
       TXL PKJ,1,18                                                     9AP5 882
       CLA Q2                                                           9AP5 883
       TRA PKD-4                                                        9AP5 884
       REM                                                              9AP5 885
 PKJ   PXD 24,1                                                         9AP5 886
       LRS 53                                                           9AP5 887
       DVH Q6                                                           9AP5 888
       LLS 35                                                           9AP5 889
       ADD Q4                                                           9AP5 890
       STA VRF1                                                         9AP5 891
       LXD VRF,2                                                        9AP5 892
       TXH PKD,1,18                                                     9AP5 893
       TXI PKD,2,-1                                                     9AP5 894
 PKD   SXD VRF1,2                                                       9AP5 895
       LXD SAVE+1,6                                                     9AP5 896
       CAL BCD+1                                                        9AP5 897
       LDQ BCD+2                                                        9AP5 898
       LGL 54,1                                                         9AP5 899
       SLW MQ                                                           9AP5 900
       LDQ SAVE                                                         9AP5 901
       TXI PKE,2,-6                                                     9AP5 902
 PKE   PXD 30,2                                                         9AP5 903
       ARS 18                                                           9AP5 904
       STA PKE+5                                                        9AP5 905
       CLM                                                              9AP5 906
       LGL 42,4                                                         9AP5 907
       ALS 0                                                            9AP5 908
       SLW SAVE+1                                                       9AP5 909
       LXD VRF1,2                                                       9AP5 910
       LXA VRF1,1                                                       9AP5 911
       CLA LMT1                                                         9AP5 912
       STO LMT                                                          9AP5 913
       CLA SAVE+1                                                       9AP5 914
       LDQ MQ                                                           9AP5 915
       LXD CTRL2,4                                                      9AP5 916
 CTRL3 CAS TCD+1,4                                                      9AP5 917
 CTRL2 TXL     INSTR,0,TCD+1-HED                                        9AP5 918
       TRA INSTR,4                                                      9AP5 919
       TIX CTRL3,4,1                                                    9AP5 920
       REM                                                              9AP5 921
       TXL INSTR                                                        9AP5 922
       TXL HEDOP                                                        9AP5 923
       TXL     FULOP                                                    9AP5 924
       TXL     FINOP                                                    9AP5 925
       TXL ERROP                                                        9AP5 926
       TXL     SYNOP                                                    9AP5 927
 ENDT  TXL ENDOP                                                        9AP5 928
       TXL DAFOP                                                        9AP5 929
       TXL DEFOP                                                        9AP5 930
       TXL DECOP                                                        9AP5 931
       TXL BSSOP                                                        9AP5 932
       TXL BESOP                                                        9AP5 933
       TXL BGNOP                                                        9AP5 934
       TXL BCIOP                                                        9AP5 935
       TXL BCDOP                                                        9AP5 936
       TXL     ABSOP                                                    9AP5 937
 LIBT  TXL     LIBOP                                                    9AP5 938
       TXL OCTOP                                                        9AP5 939
       TXL ORGOP                                                        9AP5 940
       TXL     RTD                                                      9AP5 941
       TXL RTD                                                          9AP5 942
       TXL     RELOP                                                    9AP5 943
       TXL REMOP                                                        9AP5 944
 REPTR TXL REPOP                                                        9AP5 945
       TXL RETOP                                                        9AP5 946
       TXL     RTD                                                      9AP5 947
       TXI SKPOP                                                        9AP5 948
       TXL SYNOP                                                        9AP5 949
       TXI     TCDOP                                                    9AP5 950
       REM                                                              9AP5 951
 INSTR CAS SWT                                                          9AP5 952
       TXL NSWT                                                         9AP5 953
       TXL SWTX                                                         9AP5 954
       REM                                                              9AP5 955
 NSWT  LXD OPSIZ,2                                                      9AP5 956
       SXD OPR,2                                                        9AP5 957
       LXA OPSIZ,2                                                      9AP5 958
       LXD Q0,1                                                         9AP5 959
       CAS OPTBL                                                        9AP5 960
       TRA OPR3,2                                                       9AP5 961
       TXL OPRF                                                         9AP5 962
       TXL ERR                                                          9AP5 963
       REM                                                              9AP5 964
 OPR   TXL OPR1,1,0                                                     9AP5 965
       CAS OPTBL,1                                                      9AP5 966
       TXI OPR3,2,-2                                                    9AP5 967
       TXL OPRF                                                         9AP5 968
 OPR1  TXI OPR2,2,-2                                                    9AP5 969
       TXI OPR,1,+512                                                   9AP5 970
       TXI OPR,1,-512                                                   9AP5 971
       TXI OPR,1,+256                                                   9AP5 972
       TXI OPR,1,-256                                                   9AP5 973
       TXI OPR,1,+128                                                   9AP5 974
       TXI OPR,1,-128                                                   9AP5 975
       TXI OPR,1,+64                                                    9AP5 976
       TXI OPR,1,-64                                                    9AP5 977
       TXI OPR,1,+32                                                    9AP5 978
       TXI OPR,1,-32                                                    9AP5 979
       TXI OPR,1,+16                                                    9AP5 980
       TXI OPR,1,-16                                                    9AP5 981
       TXI OPR,1,+8                                                     9AP5 982
       TXI OPR,1,-8                                                     9AP5 983
       TXI OPR,1,+4                                                     9AP5 984
       TXI OPR,1,-4                                                     9AP5 985
       TXI OPR,1,+2                                                     9AP5 986
       TXI OPR,1,-2                                                     9AP5 987
       TXL ERR                                                          9AP5 988
       TXL ERR                                                          9AP5 989
 OPR2  TRA OPR2,2                                                       9AP5 990
 OPR3  TRA OPR3,2                                                       9AP5 991
       REM                                                              9AP5 992
 ERR   CLA BLANKS              IF OP NOT FOUND                          9AP5 993
       ALS 24                  PUT BLANKS IN SIGN                       9AP5 994
       SLW OCTAL+1             AND PREFIX PARTS                         9AP5 995
       PXD                     OF INSTRUCTION                           9AP5 996
       SLW WORD                                                         9AP5 997
       TXL OPRNF                                                        9AP5 998
 SWTX  TSX SCAN,4         OBTAIN SENSE                                  9AP5 999
       CLA Q6             SWITCH ADDRESS                                9AP51000
       SUB TEQ            AND CONVERT                                   9AP51001
       TPL SWTL           SWT 7 TO 12 TO                                9AP51002
       STO TEQ            -SWT 1 TO 6                                   9AP51003
 SWTL  CAL SWT+1                                                        9AP51004
       ORA TEQ                                                          9AP51005
       SLW WORD                                                         9AP51006
       PXD                                                              9AP51007
       SLW OCTAL+1                                                      9AP51008
       SLW OCTAL+2                                                      9AP51009
       SLW OCTAL+3                                                      9AP51010
       TXL INST2                                                        9AP51011
       REM                                                              9AP51012
 OPRF  CAL OPTBL+1,1      OBTAIN OPERATION AND                          9AP51013
       SLW WORD           INSTRUCTION                                   9AP51014
       PXD                                                              9AP51015
       SLW OCTAL+1                                                      9AP51016
 OPRNF SLW OCTAL+2                                                      9AP51017
       SLW OCTAL+3                                                      9AP51018
       CLA WORD                                                         9AP51019
       LRS 15                                                           9AP51020
       LBT                                                              9AP51021
       TRA OPRFA                                                        9AP51022
       STZ     INDIC                                                    9AP51023
       LXD VRF1,2                                                       9AP51024
       LXA VRF1,1                                                       9AP51025
       SLN 4                                                            9AP51026
       ARS 1                                                            9AP51027
       ALS 1                                                            9AP51028
       LLS 15                                                           9AP51029
       STO SAVE+3                                                       9AP51030
       TSX OCTV+1,4                                                     9AP51031
       TRA SENS1                                                        9AP51032
       CLA SAVE+3                                                       9AP51033
       STO WORD                                                         9AP51034
 OPRFA LXD VRF1,2                                                       9AP51035
       LXA VRF1,1                                                       9AP51036
       TSX SCAN,4              OBTAIN ADDRESS                           9AP51037
       SLT 1                   TEST FOR ERROR                           9AP51038
       TXL INST1                                                        9AP51039
       CAL BLANK               PUT BLANKS IN                            9AP51040
       ORS OCTAL+2             ADDRESS PART OF                          9AP51041
       CAL BLANKS              BCD RECORD                               9AP51042
       ORS OCTAL+3                                                      9AP51043
       CAL     RCW23             UNDEFINED FLAG                         9AP51044
       SLW     RCW21             X                                      9AP51045
       TXL INST2                                                        9AP51046
       REM                                                              9AP51047
 SENS1 SUB BLANK                                                        9AP51048
       TNZ OPRFA-2                                                      9AP51049
       CAL SAVE+3                                                       9AP51050
       TRA INST7-1                                                      9AP51051
       REM                                                              9AP51052
 INST1 ORS WORD                                                         9AP51053
       CLA     RBITS                                                    9AP51054
       STO     INDIC                                                    9AP51055
 INST2 TSX SCAN,4              OBTAIN TAG                               9AP51056
       SLT 1                   TEST FOR ERROR                           9AP51057
       TXL INST3                                                        9AP51058
       CLA BLANK               PUT BLANK IN                             9AP51059
       ALS 12                  TAG PART OF                              9AP51060
       SLT 4                                                            9AP51061
       TRA INST2+9                                                      9AP51062
       ARS 6                                                            9AP51063
       SLN 4                                                            9AP51064
       ORS OCTAL+2             BCD RECORD                               9AP51065
       CAL     RCW23             PICK UP UNFEFINED FLAG                 9AP51066
       SLW     RCW21             X                                      9AP51067
       TXL INST4                                                        9AP51068
       REM                                                              9AP51069
 INST3 ALS 15                                                           9AP51070
       ANA TAG                                                          9AP51071
       ORS WORD                                                         9AP51072
 INST4 TSX SCAN,4              OBTAIN DECREMENT                         9AP51073
       SLT 1                   TEST FOR ERROR                           9AP51074
       TXL INST5                                                        9AP51075
       CLA WORD                IF TYPE B INSTRUCTION                    9AP51076
       ANA DECR                CONSIDER DECREMENT TO                    9AP51077
       TNZ INST6               BE BITS 21-26                            9AP51078
       CAL BLANKS              PUT BLANKS IN                            9AP51079
       ARS 18                  DECREMENT PART                           9AP51080
       ORS OCTAL+1             OF BCD RECORD                            9AP51081
 INST6 CAL BLANKS                                                       9AP51082
       ALS 24                                                           9AP51083
       ORS OCTAL+2                                                      9AP51084
       CAL     RCW23             UNDEFINED FLAG                         9AP51085
       SLW     RCW21             X                                      9AP51086
       TXL INST7                                                        9AP51087
       REM                                                              9AP51088
 INST5 SLT 2                                                            9AP51089
       TRA INST5+3                                                      9AP51090
       ORA BLANK                                                        9AP51091
       ALS 18                  INSTRUCTION                              9AP51092
       LXA     RBITS,4                                                  9AP51093
       SXD     INDIC,4                                                  9AP51094
       ORS WORD                                                         9AP51095
 INST7 TSX PRINTI,4            PRINT , STORE AND                        9AP51096
       TXL RTD                                                          9AP51097
       REM                                                              9AP51098
 DAFOP TSX DAFA,4                GET FIELD                              9AP51099
       CLA     EQV               X                                      9AP51100
       TPL DAFB                  COMPLEMENT ON                          9AP51101
       CAL PBIT                  EQU MINUS                              9AP51102
       ADD     EQV               X                                      9AP51103
 DAFB  ANA ADDR                  SAVE                                   9AP51104
       STO LOC2                  ADDRESS                                9AP51105
       TXI SYN2                                                         9AP51106
       REM                                                              9AP51107
 DAFA  SXA DAFC,4                INITIALIZE                             9AP51108
       LDQ MQ                    X                                      9AP51109
       PXD                       X                                      9AP51110
       SLW     EQV               X                                      9AP51111
       SLW TEQ                   X                                      9AP51112
       TXI DAFD                  X                                      9AP51113
       REM                                                              9AP51114
 DAFE  PXD                       CLEAR AC                               9AP51115
       LGL 3                     TEST FOR                               9AP51116
       TNZ DAFF                  ZONE PUNCHES                           9AP51117
       CLA TEQ                   ADD OCTAL                              9AP51118
       LGL 3                     BITS                                   9AP51119
 DAFD  STO TEQ                   SAVE                                   9AP51120
       TIX DAFE,1,1              GO BACK                                9AP51121
       TXI *+1,2,-1              MOVE MQ MARKER                         9AP51122
       LDQ BCD,2                 PICK UP NEXT BCD                       9AP51123
       TXI DAFE,1,5              WORD AND RESET IR1                     9AP51124
       REM                                                              9AP51125
 DAFF  LGL 3                     TEST FOR BCD                           9AP51126
       PAX 0,4                   CHARACTER                              9AP51127
       TXL *+2,4,31                                                     9AP51128
       TXL DAFG,4,32             IT IS A MINUS                          9AP51129
       TXL *+2,4,15                                                     9AP51130
       TXL DAFH,4,16             IT IS A PLUS                           9AP51131
 DAFC  AXT **,4                                                         9AP51132
       CLA TEQ                   EXIT                                   9AP51133
       ADD     EQV               X                                      9AP51134
       STO     EQV                                                      9AP51135
       TRA 1,4                   X                                      9AP51136
       REM                                                              9AP51137
 DAFG  CLA TEQ                                                          9AP51138
       ADD     EQV                                                      9AP51139
       STO     EQV                                                      9AP51140
       CLA PBIT                                                         9AP51141
       TXI DAFD                                                         9AP51142
       REM                                                              9AP51143
 DAFH  CLA TEQ                                                          9AP51144
       ADD     EQV                                                      9AP51145
       STO     EQV                                                      9AP51146
       PXD                         CLEAR THE AC                         9AP51147
       TXI DAFD                                                         9AP51148
       REM                                                              9AP51149
 TCDOP TSX     SCAN,4              GET TRANSFER ADDRESS                 9AP51150
       CLA     TCD2                MODIFY ENDOP TO PUNCH TRANSFER CARD  9AP51151
       STO     LIST1-3             X                                    9AP51152
       CLA     NOP                 X                                    9AP51153
       STO     ENDOP+9             X                                    9AP51154
       STO     ENDOP+10            X                                    9AP51155
       TXI     ENDOP+1             GO AND PUNCH TRANSFER CARD           9AP51156
 TCD1  CLA     TCD3                RESTORE ENDOP TO                     9AP51157
       STO     LIST1-3             PUNCH FINAL TRANSFER CARD            9AP51158
       CLA     ENDOP+4             X                                    9AP51159
       STO     ENDOP+9             X                                    9AP51160
       STO     ENDOP+10            X                                    9AP51161
       TXI     RTD                 EXIT FROM TCDOP                      9AP51162
 TCD2  TXI     TCD1                CONTROL TRANSFERS                    9AP51163
 TCD3  CLA     DEF2                AND RESTORING INSTRUCTIONS           9AP51164
       REM                                                              9AP51165
 SKPOP TSX SCAN,4                                                       9AP51166
       LDQ BLANKS                                                       9AP51167
       CAL TEQ                                                          9AP51168
       LGL 30                                                           9AP51169
       SLW RCW21                                                        9AP51170
       CAL SKPX                                                         9AP51171
       SLW     RTDA+4                                                   9AP51172
       CAL     TEQ                                                      9AP51173
       LGR     6                                                        9AP51174
       PXD                                                              9AP51175
       LGL     6                                                        9AP51176
       ORS     SKPD                                                     9AP51177
       SWT     3                                                        9AP51178
       TXI     SKPG                                                     9AP51179
       WPRA                                                             9AP51180
 SKPD  SPRA    **                                                       9AP51181
       TCOA    *                                                        9AP51182
       CAL     SKPH                                                     9AP51183
       SLW     SKPD                                                     9AP51184
 SKPG  TXI     RTD                                                      9AP51185
 SKPH  SPRA    **                                                       9AP51186
 SKPX  TXI SKPY                                                         9AP51187
 SKPY  CAL SKPZ                                                         9AP51188
       SLW     RTDA+4                                                   9AP51189
       TXI     RTDA+5                                                   9AP51190
 SKPZ  STO     RCW21                                                    9AP51191
       REM                                                              9AP51192
       REM                                                              9AP51193
 LIBOP CLS     LIB1                                                     9AP51194
       STO     LIB1                                                     9AP51195
 LIB1  TXL     LIB2                                                     9AP51196
       TSX     PRNTC,4                                                  9AP51197
 LIB2  CLS     WOT+1                                                    9AP51198
       STO     WOT+1                                                    9AP51199
       TXI     RTD                                                      9AP51200
 BGNOP TSX SCAN,4                                                       9AP51201
       STA CODE1                                                        9AP51202
       TSX SCAN,4                                                       9AP51203
       LRS 3                                                            9AP51204
       STQ SAVE                                                         9AP51205
       TSX SCAN,4                                                       9AP51206
       STA CODE                                                         9AP51207
       ALS 1                                                            9AP51208
       STO SAVE+2                                                       9AP51209
       CLA LOC1                                                         9AP51210
       ADM CODE                                                         9AP51211
       STA CODE1-1                                                      9AP51212
       STA CODE1+1                                                      9AP51213
       LXA Q0,1                                                         9AP51214
       LDQ SAVE                                                         9AP51215
       RND                                                              9AP51216
       STA CODE1+4,1                                                    9AP51217
       RQL 1                                                            9AP51218
       TXI BGN1,1,1                                                     9AP51219
 BGN1  TXL BGN1-4,1,2                                                   9AP51220
       ADM CODE                                                         9AP51221
       ADD Q2                                                           9AP51222
       STA CODE                                                         9AP51223
       TSX PRNTC,4                                                      9AP51224
       TXI BGN1+6,1,8                                                   9AP51225
       CLA Q4                                                           9AP51226
       ORA SAVE+2                                                       9AP51227
       ARS 1                                                            9AP51228
       LDQ SAVE                                                         9AP51229
       LLS 3                                                            9AP51230
       ALS 2                                                            9AP51231
       ORA SAVE+2                                                       9AP51232
       ORA Q1                                                           9AP51233
       ALS 2                                                            9AP51234
       ORA SAVE+2                                                       9AP51235
       ARS 1                                                            9AP51236
       LDQ SAVE                                                         9AP51237
       RQL 2                                                            9AP51238
       LLS 1                                                            9AP51239
       LGL 1                                                            9AP51240
       RQL 32                                                           9AP51241
       LRS 10                                                           9AP51242
       STQ SAVE+2                                                       9AP51243
 BGN2  LDQ SAVE+2                                                       9AP51244
       RQL 1                                                            9AP51245
       STQ SAVE+2                                                       9AP51246
       TQP BGN3                                                         9AP51247
       CLA Q0                                                           9AP51248
       STO OCTAL+1                                                      9AP51249
       STO OCTAL+2                                                      9AP51250
       STO OCTAL+3                                                      9AP51251
       CLA CODE+11,1                                                    9AP51252
       STO WORD                                                         9AP51253
       TSX PRINTI,4                                                     9AP51254
 BGN3  TIX BGN2,1,1                                                     9AP51255
       TXL RTD                                                          9AP51256
       REM                                                              9AP51257
 CODE  OCT -300000000000                                                9AP51258
       OCT 000000000000                                                 9AP51259
       OCT 077400400000                                                 9AP51260
       OCT 077400200000                                                 9AP51261
       OCT 077400100000                                                 9AP51262
       OCT 044100000000                                                 9AP51263
 CODE1 OCT 002000400000                                                 9AP51264
       OCT 060400000000                                                 9AP51265
       OCT 063400100000                                                 9AP51266
       OCT 063400200000                                                 9AP51267
       OCT 063400400000                                                 9AP51268
       REM                                                              9AP51269
 RETOP TSX SCAN,4                                                       9AP51270
       SLT 1                                                            9AP51271
       TRA RET1                                                         9AP51272
       CLA BLANK                                                        9AP51273
       STO SAVE+2                                                       9AP51274
       CLA BLANKS                                                       9AP51275
       STO SAVE+3                                                       9AP51276
       CLM                                                              9AP51277
       LXA Q4,4                                                         9AP51278
       STA CODEA+4,4                                                    9AP51279
       TIX RET1-3,4,1                                                   9AP51280
       TXL RET2,,-1                                                     9AP51281
 RET1  STA CODEA+1                                                      9AP51282
       CLA EQVR                                                         9AP51283
       ARS 15                                                           9AP51284
       ADD TEQ                                                          9AP51285
       STA CODEA                                                        9AP51286
       STA CODEA+2                                                      9AP51287
       ADD Q1                                                           9AP51288
       STA CODEA+3                                                      9AP51289
       CLM                                                              9AP51290
       SLW SAVE+2                                                       9AP51291
       SLW SAVE+3                                                       9AP51292
 RET2  TSX SCAN,4                                                       9AP51293
       LXD RET1-1,1                                                     9AP51294
       TZE RET2+4                                                       9AP51295
       TXI RET2+4,1,-3                                                  9AP51296
       SXD RET3,1                                                       9AP51297
       TSX PRNTC,4                                                      9AP51298
       LXA Q0,1                                                         9AP51299
 RET4  CLA Q0                                                           9AP51300
       STO OCTAL+1                                                      9AP51301
       CLA SAVE+2                                                       9AP51302
       STO OCTAL+2                                                      9AP51303
       CLA SAVE+3                                                       9AP51304
       STO OCTAL+3                                                      9AP51305
       CLA CODEA,1                                                      9AP51306
       STO WORD                                                         9AP51307
       TSX PRINTI,4                                                     9AP51308
       TXI RET3,1,-1                                                    9AP51309
 RET3  TXH RET4,1,0                                                     9AP51310
       TXL RTD                                                          9AP51311
       REM                                                              9AP51312
 CODEA OCT 002000000000                                                 9AP51313
       OCT 463400400000                                                 9AP51314
       OCT 053400400000                                                 9AP51315
       OCT 100001400000                                                 9AP51316
       REM                                                              9AP51317
 ERROP TSX PRNTC,4                                                      9AP51318
       LXD VRF1,2                                                       9AP51319
       CLM                                                              9AP51320
       STA CODEB                                                        9AP51321
       STA CODEB+1                                                      9AP51322
       TSX SCAN,4                                                       9AP51323
       SLT 1                                                            9AP51324
       TRA ERR1                                                         9AP51325
       CLA BLANK                                                        9AP51326
       STO SAVE+2                                                       9AP51327
       CLA BLANKS                                                       9AP51328
       STO SAVE+3                                                       9AP51329
       TXL ERR2                                                         9AP51330
 ERR1  STA CODEB+1                                                      9AP51331
       CLM                                                              9AP51332
       SLW SAVE+2                                                       9AP51333
       SLW SAVE+3                                                       9AP51334
 ERR2  TSX SCAN,4                                                       9AP51335
       SLT 1                                                            9AP51336
       TRA ERR8                                                         9AP51337
       CLA BLANK                                                        9AP51338
       STO OCTAL+2                                                      9AP51339
       CLA BLANKS                                                       9AP51340
       STO OCTAL+3                                                      9AP51341
       TRA ERR5                                                         9AP51342
 ERR8  TZE ERR3                                                         9AP51343
 ERR4  STA CODEB                                                        9AP51344
       CLM                                                              9AP51345
       SLW OCTAL+2                                                      9AP51346
       SLW OCTAL+3                                                      9AP51347
 ERR5  CLM                                                              9AP51348
       SLW OCTAL+1                                                      9AP51349
       CLA CODEB                                                        9AP51350
       STO WORD                                                         9AP51351
       TSX PRINTI,4                                                     9AP51352
 ERR3  CLA SAVE+2                                                       9AP51353
       STO OCTAL+2                                                      9AP51354
       CLA SAVE+3                                                       9AP51355
       STO OCTAL+3                                                      9AP51356
       CLM                                                              9AP51357
       SLW OCTAL+1                                                      9AP51358
       CLA CODEB+1                                                      9AP51359
       STO WORD                                                         9AP51360
       TSX PRINTI,4                                                     9AP51361
       TXL RTD                                                          9AP51362
       REM                                                              9AP51363
 CODEB OCT 077400400000                                                 9AP51364
       OCT 002000000000                                                 9AP51365
       REM                                                              9AP51366
 SYNOP TSX     SCAN,4                                                   9AP51367
       CLA     TEQ                                                      9AP51368
       STA     LOC2                                                     9AP51369
 SYN2  TSX     PRNTC,4                                                  9AP51370
       TXL     RTD                                                      9AP51371
       REM                                                              9AP51372
 HEDOP CLM                ESTABLISH BLOCK                               9AP51373
       LDQ BCD            HEADING                                       9AP51374
       LGL 6                                                            9AP51375
       SLW BHEAD                                                        9AP51376
       TXL SYN2                                                         9AP51377
       REM                                                              9AP51378
 REPOP TSX SCAN,4         OBTAIN M                                      9AP51379
       CLA TEQ                                                          9AP51380
       STO M                                                            9AP51381
       TSX SCAN,4         OBTAIN N                                      9AP51382
       CLA TEQ                                                          9AP51383
       PAX 0,4            PUT N IN INDEX REGISTER                       9AP51384
       CLA REP1           CHANGE REPEAT TRANSFER                        9AP51385
       STA REPTR                                                        9AP51386
 REP4  SXD REP2,4         STORE N                                       9AP51387
       BSRB    2                                                        9AP51388
       LXA M,4            TO BEGINNING OF BLOCK                         9AP51389
 REP3  BSRB 2                                                           9AP51390
       TIX REP3,4,1                                                     9AP51391
       TXL RTD                                                          9AP51392
 REP5  LXD REP2,4         COUNT REPEATS                                 9AP51393
       TIX REP4,4,1                                                     9AP51394
       CLA REP2           RESTORE REPEAT                                9AP51395
       STA REPTR          TRANSFER                                      9AP51396
       TXL RTD                                                          9AP51397
 REP1  TXL REP5           CONSTANTS FOR REPOP                           9AP51398
 REP2  TXL REPOP                                                        9AP51399
       REM                                                              9AP51400
 REMOP CAL BLANKS         REMOVE REM FROM                               9AP51401
       LXA Q4,4                                                         9AP51402
       SLW OCTAL+4,4                                                    9AP51403
       TIX REMOP+2,4,1                                                  9AP51404
       LDQ BCD+1                                                        9AP51405
       RQL 30                                                           9AP51406
       LGL 6                                                            9AP51407
       SLW BCD+1                                                        9AP51408
       TSX WOT,4                                                        9AP51409
       TXL RTD                                                          9AP51410
       REM                                                              9AP51411
 BCDOP CAL BCD+1                                                        9AP51412
       LRS 6                                                            9AP51413
       STZ     INDIC                                                    9AP51414
       TCOB    *                                                        9AP51415
       CLM                                                              9AP51416
       LLS 6                                                            9AP51417
       CAS Q10            OF BCD WORDS                                  9AP51418
       CLA Q10                                                          9AP51419
 BCD1  TXH BCD+2                                                        9AP51420
       PAX 0,2                                                          9AP51421
       ADD BCD1                                                         9AP51422
       STA BCD2                                                         9AP51423
 BCD2  CAL 0,2            OBTAIN BCD WORD                               9AP51424
       SLW DATUM                                                        9AP51425
       TSX PRINTW,4                                                     9AP51426
       TIX BCD2,2,1                                                     9AP51427
       TXL RTD                                                          9AP51428
       REM                                                              9AP51429
 OCTOP STZ     INDIC               CLEAR INDICATOR BITS                 9AP51430
       TCOB    *                                                        9AP51431
       TSX     OCTV,4              OBTAIN BINARY EQUIVALENCE            9AP51432
       SLN     4                   LITE ON IF END OF FIELD              9AP51433
       STQ     MQ                  SAVE MQ FOR NEXT WORD                9AP51434
       TSX     PRINTD,4            PRINT AND STORE OCTAL WORD           9AP51435
       SLT     4                   TEST FOR END OF CARD                 9AP51436
       TXL     OCTOP               NO. GO ON TO NEXT WORD               9AP51437
       TXL     RTD                 YES. GO ON TO NEXT CARD              9AP51438
 OCTV  SLF                                                              9AP51439
       LDQ MQ                                                           9AP51440
       PXD                                                              9AP51441
       TXL OCT9                                                         9AP51442
 OCT1  PXD                                                              9AP51443
       LGL 3                                                            9AP51444
       TNZ OCT8                                                         9AP51445
       CLA DATUM                                                        9AP51446
       LGL 3                                                            9AP51447
       SLW DATUM                                                        9AP51448
       PBT                                                              9AP51449
 OCT9  STO DATUM                                                        9AP51450
 OCT6  TIX OCT1,1,1                                                     9AP51451
       TXI OCT2,2,-1                                                    9AP51452
 OCT2  LDQ BCD,2                                                        9AP51453
       TXI OCT1,1,5                                                     9AP51454
 OCT8  LGL 3                                                            9AP51455
       CAS COMMA                                                        9AP51456
       TRA 1,4                                                          9AP51457
       TRA 2,4                                                          9AP51458
       CAS MINUS                                                        9AP51459
       TRA 1,4                                                          9AP51460
       TXL OCT5                                                         9AP51461
       CAS PLUS                                                         9AP51462
       TRA 1,4                                                          9AP51463
       TRA OCT6                                                         9AP51464
       TRA 1,4                                                          9AP51465
 OCT5  CLA PBIT                                                         9AP51466
       TXL OCT9                                                         9AP51467
       REM                                                              9AP51468
 DEFOP TSX SCAN,4              FIND EQUIVALENCE                         9AP51469
       CLA TEQ                 FOR DEFINING                             9AP51470
       STA LOC2           THOSE                                         9AP51471
       STO DEFIN               SYMBOLS NOT IN                           9AP51472
       CLA NOP            TABLE                                         9AP51473
       STO UNDEF                                                        9AP51474
       TSX PRNTC,4                                                      9AP51475
       TXL RTD                                                          9AP51476
       REM                                                              9AP51477
 NOP   NOP                                                              9AP51478
       REM                                                              9AP51479
 DECOP PXD                CLEAR CONVERSION                              9AP51480
       TCOB    *                                                        9AP51481
       STZ     INDIC                                                    9AP51482
 BN2   SLW BN             REGISTERS                                     9AP51483
 EX2   SLW EXPN                                                         9AP51484
 INTN  SLW N                                                            9AP51485
       LXD Q0,4           SET DECIMAL COUNT TO ZERO                     9AP51486
       CAL INTN           INITIALIZE CONVERSION                         9AP51487
       SLF                                                              9AP51488
       TXL BN3                                                          9AP51489
 PT1   SLN 1              INDICATE DECIMAL POINT                        9AP51490
       CAL PT2            SET UP CONVERSION                             9AP51491
       STA CV5            ROUTINE TO COUNT                              9AP51492
       STA CV6            DECIMAL PLACES                                9AP51493
       TXI CV5,4,1                                                      9AP51494
 PT2   TXH PT3                                                          9AP51495
 PT3   TXI CV3,4,-1       COUNT DECIMAL PLACES                          9AP51496
 EX1   SLN 2              INDICATE EXPONENT                             9AP51497
       CAL EX2            SET UP EXPONENT CONVERSION                    9AP51498
 BN3   STA CV7            STORE CONVERSION                              9AP51499
       STA CV8            ADDRESS                                       9AP51500
       STA CV9                                                          9AP51501
       CAL PT3            INITIAL CONVERSION                            9AP51502
       STA CV5            WITHOUT DECIMAL COUNT                         9AP51503
       STA CV6                                                          9AP51504
 PL1   CAL CV8                                                          9AP51505
 MN3   STD CV10                                                         9AP51506
       TOV CV5                                                          9AP51507
       TXL CV5                                                          9AP51508
 BN1   SLN 3              INDICATE FIXED POINT                          9AP51509
       CAL BN2            SET UP B CONVERSION                           9AP51510
       TXL BN3                                                          9AP51511
 MN1   CAL MN2                                                          9AP51512
 MN2   TXL MN3,0,258*64                                                 9AP51513
 CV3   PXD                OBTAIN CHARACTER                              9AP51514
       LGL 6                                                            9AP51515
       CAS TEN            TEST FOR DIGIT                                9AP51516
       TXL CM                                                           9AP51517
       TXL CV2                                                          9AP51518
       SLW CH             PERFORM CODED                                 9AP51519
 CV7   CLA N              MULTIPLICATION                                9AP51520
       ALS 2              BY TEN AND ADD                                9AP51521
 CV8   ADD N              CURRENT DIGIT                                 9AP51522
       ALS 1                                                            9AP51523
 CV10  ADD CH                                                           9AP51524
       TOV OVF            TEST FOR OVERFLOW                             9AP51525
 CV9   STO N                                                            9AP51526
 CV5   TIX CV3,1,1        COUNT CHARACTERS                              9AP51527
       TXI CV4,2,-1       OBTAIN NEXT BCD                               9AP51528
 CV4   LDQ BCD,2          WORD AND RESTORE                              9AP51529
 CV6   TXI CV3,1,5        CHARACTER COUNT                               9AP51530
 OVF   TXI CV5,4,1        COUNT DECIMAL OVERFLOWS                       9AP51531
 CM    CAS COMMA                                                        9AP51532
       TXL CV2                                                          9AP51533
       TXL CM1                                                          9AP51534
       CAS MINUS                                                        9AP51535
       TXL CV2                                                          9AP51536
       TXL MN1                                                          9AP51537
       CAS POINT                                                        9AP51538
       TXL CV2                                                          9AP51539
       TXL PT1                                                          9AP51540
       CAS E                                                            9AP51541
       TXL CV2                                                          9AP51542
       TXL EX1                                                          9AP51543
       CAS B                                                            9AP51544
       TXL CV2                                                          9AP51545
       TXL BN1                                                          9AP51546
       CAS PLUS                                                         9AP51547
       TXL CV2                                                          9AP51548
       TXL PL1                                                          9AP51549
 CV2   SLN 4                                                            9AP51550
 CM1   STQ MQ                                                           9AP51551
       CLA N                                                            9AP51552
       TZE STOR                                                         9AP51553
       SLT 2                                                            9AP51554
       TXL CM2            GO TO B TEST                                  9AP51555
       CAL PBIT           PREPARE TRUE                                  9AP51556
       ADD EXPN           DECIMAL EXPONENT                              9AP51557
       ALS 18                                                           9AP51558
       STD CM4                                                          9AP51559
       CLA N                                                            9AP51560
 CM4   TXI CM5,4          FLOAT CONVERTED                               9AP51561
 CM2   SLT 3              TEST FOR FIXED BINARY                         9AP51562
       TXL CM3                                                          9AP51563
       SLN 3              RESTORE FIXED BINARY                          9AP51564
       TXL CM5            INDICATOR AND FLOAT N                         9AP51565
 CM3   SLT 1              TEST FOR DECIMAL POINT                        9AP51566
       TXL STOR                                                         9AP51567
 CM5   STA FL1            35 BIT INTEGER                                9AP51568
       ARS 15                                                           9AP51569
       ORA FL2                                                          9AP51570
       FAD FL2                                                          9AP51571
       TPL CMF1                                                         9AP51572
       FSB FL1                                                          9AP51573
       TXL CMF2                                                         9AP51574
 CMF1  FAD FL1                                                          9AP51575
 CMF2  STQ RESID                                                        9AP51576
       TXL CM6,4                                                        9AP51577
       TXH CM7,4,38       TEST FOR NEGATIVE EXP                         9AP51578
 CM11  TXI CM9,4,-1       COMPUTE ABSOLUTE                              9AP51579
 CM9   SXD CM10,4         VALUE OF EXPONENT                             9AP51580
       LXD CM11,4                                                       9AP51581
 CM10  TNX CM8,4                                                        9AP51582
       STO DATUM                                                        9AP51583
       LDQ ONE,4          COMPUTE FLOATING                              9AP51584
       FMP DATUM          BINARY REPRESENTATION                         9AP51585
       STO T              OF INTEGER TIMES THE                          9AP51586
       STQ T+1            POWER OF TEN GIVEN                            9AP51587
       LDQ ONE,4          BY THE TRUE EXPONENT                          9AP51588
       FMP RESID                                                        9AP51589
       FAD T+1                                                          9AP51590
       FAD T                                                            9AP51591
       ACL EXC1                                                         9AP51592
       PBT                                                              9AP51593
       TXL CM6                                                          9AP51594
       TXL CM8                                                          9AP51595
 CM7   TXL CM8,4,-49      TEST FOR ILLEGAL EXP                          9AP51596
       FDP ONE,4          COMPUTE FLOATING                              9AP51597
       STQ T              BINARY EQUIVALENT                             9AP51598
       FAD RESID          OF INTEGER TIMES                              9AP51599
       FDP ONE,4          POWER OF TEN GIVEN                            9AP51600
       STQ T+1            BY TRUE EXPONENT                              9AP51601
       CLA T+1                                                          9AP51602
       FAD T                                                            9AP51603
       ACL EXC2                                                         9AP51604
       PBT                                                              9AP51605
       TXL CM8                                                          9AP51606
 CM6   SLT 3              TEST FOR FIXED POINT                          9AP51607
       TXL STOR                                                         9AP51608
       STO T                                                            9AP51609
       ALS 2                                                            9AP51610
       SSM                DETERMINE SHIFT                               9AP51611
       ARS 29             NECESSARY TO POSITION                         9AP51612
       ADD Q128           NUMBER AS INDICATED                           9AP51613
       ADD BN             BY B                                          9AP51614
       TPL SHIFT                                                        9AP51615
       TNZ CM8                                                          9AP51616
 SHIFT STA CM12                                                         9AP51617
       CLA T              REMOVE CHARACTERISTICS                        9AP51618
       LLS 8              FROM FLOATING NUMBER                          9AP51619
       ALS 2                                                            9AP51620
       ARS 10                                                           9AP51621
       LLS 8                                                            9AP51622
 CM12  LRS                POSITION FIXED NUMBER                         9AP51623
 STOR  STO DATUM          STORE CONVERTED                               9AP51624
 DECPR TSX PRINTD,4                                                     9AP51625
       LDQ MQ                                                           9AP51626
       SLT 4                                                            9AP51627
       TXL DECOP                                                        9AP51628
       TXL RTD                                                          9AP51629
 CM8   PXD -DECPR         SUBSTTUTE ZERO FOR                            9AP51630
       STO DATUM          ILLEGAL DATUM AND                             9AP51631
       CAL BLANKS                                                       9AP51632
       SLW OCTAL+1                                                      9AP51633
       SLW OCTAL+2                                                      9AP51634
       SLW OCTAL+3                                                      9AP51635
       LXA CM8,4                                                        9AP51636
       SXD XM,4                                                         9AP51637
       TXL PRINTL                                                       9AP51638
       REM                                                              9AP51639
 ENDOP TSX SCAN,4         OBTAIN CONTROL                                9AP51640
       CLA TEQ            EQUIVALENCE                                   9AP51641
       STO LOC2                                                         9AP51642
       TSX PUNCH,4        PUNCH LAST BLOCK                              9AP51643
       WPUA                                                             9AP51644
       TXL     ENDOP+8                                                  9AP51645
       CAL     1BIT                                                     9AP51646
       ORS     TEQ                                                      9AP51647
       RCHA RCW8                                                        9AP51648
       WPUA                                                             9AP51649
       WPUA                                                             9AP51650
       TSX PRNTC,4                                                      9AP51651
       CLA DEF2                                                         9AP51652
       STD LIST1                                                        9AP51653
       LXD SIZE,1              PRINT LIST OF                            9AP51654
 LIST1 TXL EJRW,1         UNDEFINED SYMBOLS                             9AP51655
       LDQ STBL,1                                                       9AP51656
       LXA Q5,4                                                         9AP51657
       CLA Q0                                                           9AP51658
       LGL 6                                                            9AP51659
       TNZ LIST2                                                        9AP51660
       CLA BLANK                                                        9AP51661
 LIST2 LGL 6                   REPLACE LEADING                          9AP51662
       SLW BCD                 ZEROS BY BLANKS                          9AP51663
       ANA LISTM               AND STORE SYMBOL                         9AP51664
       TNZ LIST5          IN BCD RECORD                                 9AP51665
       CAL BLANK                                                        9AP51666
       ORA BCD                                                          9AP51667
       TIX LIST2,4,1                                                    9AP51668
 LIST5 CAL BCD                                                          9AP51669
       TNX LIST3,4,1                                                    9AP51670
 LIST4 LGL 6                                                            9AP51671
       TIX LIST4,4,1                                                    9AP51672
 LIST3 SLW BCD                                                          9AP51673
       CLA ETBL,1              EQUIVALENCE AS SET                       9AP51674
       STO LOC2                OR NUMBERED                              9AP51675
       CLA LMT3                                                         9AP51676
       STO LMT                 PROVIDE PRINT LIMIT                      9AP51677
       TSX PRNTC,4                                                      9AP51678
       TXI LIST1,1,-2     RETRN FOR NEXT LINE                           9AP51679
       REM                                                              9AP51680
 EJRW  SWT 5                                                            9AP51681
       TXL RSTR                                                         9AP51682
       TXL RSTRA                                                        9AP51683
 RSTR  WTDB 3                                                           9AP51684
       RCHB RCW11                                                       9AP51685
       TCOB *                                                           9AP51686
 RSTRA REWB 2                                                           9AP51687
       SWT 3                                                            9AP51688
       TXL *+3                                                          9AP51689
       WPRA                                                             9AP51690
       SPRA 1                                                           9AP51691
       NOP     2                                                        9AP51692
       TXL RRR                                                          9AP51693
       RCDA                                                             9AP51694
       RCHA RCW13                                                       9AP51695
       LCHA 0                                                           9AP51696
       TRA 1                                                            9AP51697
 RRR   AXT     4,4                                                      9AP51698
       BSRB    1                                                        9AP51699
       TIX     RRR+1,4,1                                                9AP51700
       RTBB    1                                                        9AP51701
       RCHB RCW13                                                       9AP51702
       LCHB 0                                                           9AP51703
       TRA 1                                                            9AP51704
 STORE SXD ST1,4          STORE PROGRAM SORD                            9AP51705
 RLC8  LXD WCT,4           TXL RLCPU  FOR RELOCATABLE PUNCHING          9AP51706
       CLA WORD                                                         9AP51707
       STO 0,4                                                          9AP51708
       TXI ST2,4,-1       ADVANCE COUNT AND                             9AP51709
 ST2   TXL ST3,4,-110     TEST FOR FULL BLOCK                           9AP51710
       SXD WCT,4          STORE COUNT AND                               9AP51711
 ST7   LXD ST1,4          RETURN                                        9AP51712
 LIBC7 TRA 1,4                                                          9AP51713
 PUNCH SXD ST1,4                                                        9AP51714
 ST8   LXD WCT,4                                                        9AP51715
       TXL ST4,4          TEST FOR BLOCK                                9AP51716
 ST3   PXD 0,4            COMPUTE LAST                                  9AP51717
       COM                ADDRESS IN BLOCK                              9AP51718
       PDX 0,4                                                          9AP51719
       SXD ST5,4                                                        9AP51720
       TSX ABPCH,4        PUNCH BLOCK                                   9AP51721
 ST5   HTR                                                              9AP51722
 ST6   HPR                                                              9AP51723
 ST4   CLA LOC1           SET LOADING ADDRESS                           9AP51724
       STA ST6            FOR NEXT BLOCK                                9AP51725
       SXD     RLC1,0                                                   9AP51726
       SXD     WCT,0                                                    9AP51727
 ST1   TXL ST7                                                          9AP51728
       REM                                                              9AP51729
       REM                                                              9AP51730
 WOT   TCOB    WOT                                                      9AP51731
       TXH     NPRT+4,0,0                                               9AP51732
       SXD     TSA,1               REPLACE DTART OF                     9AP51733
       SXD TSB,2     NORMAL WOT IN                                      9AP51734
       SXD TSC,4     PASS 2 OF ASSEMBLER.                               9AP51735
       LXD STGC,4    COUNT LINES PER PAGE                               9AP51736
       TNX HEADA,4,1 RESTORE AND ADD HEADING.                           9AP51737
       SXD STGC,4                                                       9AP51738
 NPRT  TSX WOUT,4    NORMAL WRITE ROUTINE.                              9AP51739
       LXD TSA,1                                                        9AP51740
       LXD TSB,2                                                        9AP51741
       LXD TSC,4                                                        9AP51742
       TRA 1,4       NORMAL WOT RETURN                                  9AP51743
       REM                                                              9AP51744
 HEADA SWT 3                                                            9AP51745
       TRA *+3                                                          9AP51746
       WPRA                        REPLACE HEADA +2                     9AP51747
       SPRA 1                                                           9AP51748
       LXD L56,4                                                        9AP51749
       SXD STGC,4                                                       9AP51750
       CLA LCWE      PREVENT LMT                                        9AP51751
       STO WT6       MODIFICATION.                                      9AP51752
       CLA LCWA      STORE HEADING CONTROL WORD.                        9AP51753
       STA WT4                                                          9AP51754
       CLA LBCD1     STORE RESTORE CARRIAGE                             9AP51755
       STA WT5       CONTROL WORD.                                      9AP51756
       TSX WOUT,4    WRITE HEADING.                                     9AP51757
       CLA LCWB      STORE DATE CONTROL WORD.                           9AP51758
       STA WT4                                                          9AP51759
       CLA     RCW25                                                    9AP51760
       STA WT5       CONTROL WORD.                                      9AP51761
       TSX WOUT,4    WRITE DATE.                                        9AP51762
       CLA STGD      ADVANCE PAGE NUMBER.                               9AP51763
       ADD Q1                                                           9AP51764
       STO STGD                                                         9AP51765
       LDQ STGD      BINARY TO BCD.                                     9AP51766
       PXD                                                              9AP51767
       DVH Q10                                                          9AP51768
       STO TSD       LOW ORDER DIGIT.                                   9AP51769
       PXD                                                              9AP51770
       DVH Q10                                                          9AP51771
       STO TSE       SECOND DIGIT.                                      9AP51772
       PXD                                                              9AP51773
       LGL 36                                                           9AP51774
       TNZ CVTA      TEST HIGH ORDER DIGIT.                             9AP51775
       CLA TSE                                                          9AP51776
       TNZ CVTB      TEST SECOND DIGIT.                                 9AP51777
       CLA TSD       SETUP ONE DIGIT PAGE                               9AP51778
       LDQ BLANKS    NUMBER AND FILL REST OF                            9AP51779
       LGL 30        WORD WITH BLANKS.                                  9AP51780
       TXL CVTC      EXIT.                                              9AP51781
 CVTB  CLA TSD       TWO DIGIT CASE.                                    9AP51782
       TZE CVTD      TEST LOW ORDER DIGIT.                              9AP51783
       CLA TSE       SETUP TWO DIGIT                                    9AP51784
       LDQ TSD       PAGE NUMBER AND                                    9AP51785
       RQL 30        FILL REST OF WORD                                  9AP51786
 CVTE  LGL 6         WITH BLANKS.                                       9AP51787
       LDQ BLANKS                                                       9AP51788
       LGL 24                                                           9AP51789
       TXL CVTC      EXIT.                                              9AP51790
 CVTD  CLA TSE       PUT ZERO IN                                        9AP51791
       LDQ BCD0      LOW ORDER DIGIT.                                   9AP51792
       TXL CVTE                                                         9AP51793
 CVTA  STO TSF       THREE DIGIT CASE.                                  9AP51794
       CLA TSE       TEST SECOND DIGIT                                  9AP51795
       TZE CVTF      FOR ZERO.                                          9AP51796
       CLA TSF       SETUP HIGH AND SECOND                              9AP51797
       LDQ TSE       DIGIT AND SAVE.                                    9AP51798
       RQL 30                                                           9AP51799
 CVTG  LGL 6                                                            9AP51800
       SLW TSF                                                          9AP51801
       CLA TSD       TEST LOW ORDER DIGIT                               9AP51802
       TZE CVTH      FOR ZERO.                                          9AP51803
       CAL TSF       SETUP THREE DIGIT                                  9AP51804
       LDQ TSD       PAGE NUMBER AND                                    9AP51805
       RQL 30        FILL REST OF WORD                                  9AP51806
 CVTJ  LGL 6         WITH BLANKS.                                       9AP51807
       LDQ BLANKS                                                       9AP51808
       LGL 18                                                           9AP51809
       TXL CVTC      EXIT.                                              9AP51810
 CVTF  CLA TSF       PUT ZERO IN SECOND                                 9AP51811
       LDQ BCD0      DIGIT.                                             9AP51812
       TXL CVTG                                                         9AP51813
 CVTH  CAL TSF       PUT ZERO IN                                        9AP51814
       LDQ BCD0      LOW ORDER DIGIT.                                   9AP51815
       TXL CVTJ                                                         9AP51816
 CVTC  SLW STGE+11   STORE BCD PAGE NUMBER.                             9AP51817
       CLA LCWC      STORE PAGE NUMBER                                  9AP51818
       STA WT4       CONTROL WORD LOCATION.                             9AP51819
       TSX WOUT,4    WRITE PAGE NUMBER.                                 9AP51820
       SWT 5                                                            9AP51821
       TXL *+2                                                          9AP51822
       TXL *+4                                                          9AP51823
       WTDB 3                      CVTC+7                               9AP51824
       RCHB RCWBL                                                       9AP51825
       TCOB *                                                           9AP51826
       SWT 3                                                            9AP51827
       TXL *+2                                                          9AP51828
       WPRA                                                             9AP51829
       CLA LCWD      RESTORE NURMAL                                     9AP51830
       STO WT4       CONTROL WORD ADDRESS.                              9AP51831
       CLA LCWF      RESTORE NURMAL LMT                                 9AP51832
       STO WT6       MODIFICATION.                                      9AP51833
       TXL NPRT      WRITE FIRST ASSEMBLY                               9AP51834
       REM           LINE ON PAGE.                                      9AP51835
       REM                                                              9AP51836
       REM                                                              9AP51837
 STRTG CLA INTER                                                        9AP51838
       STA     RTDA+5                                                   9AP51839
       STA RTTE                                                         9AP51840
       STA REP4+1                                                       9AP51841
       STA REP3                                                         9AP51842
       STA RSTRA                                                        9AP51843
       STA STRTB                                                        9AP51844
       STA     STRTB+1                                                  9AP51845
       REM                                                              9AP51846
       CLA OUTPUT                                                       9AP51847
       STA RSTR                                                         9AP51848
       STA CVTC+7                                                       9AP51849
       REM                                                              9AP51850
 STRTB REWB 2                                                           9AP51851
       REM           AND HEADING.                                       9AP51852
       RTDB 2                       REPLACES STRTB+4                    9AP51853
       LXD L12,3     OF TAPE 3 INTO                                     9AP51854
       RCHB RCW6                                                        9AP51855
       TCOB *                                                           9AP51856
       STZ STGC      REFRESH PAGE NUMBER.                               9AP51857
 STRTF STZ STGD      REFRESH LINE NUMBER                                9AP51858
       TXL START     ENTER ASSEMBLY PASS 2.                             9AP51859
       REM                                                              9AP51860
       REM                                                              9AP51861
       REM STORAGE AND CONSTANTS                                        9AP51862
       REM                                                              9AP51863
 WCT                                                                    9AP51864
 SWT   BCD 1SWT000                                                      9AP51865
       OCT +076000000160                                                9AP51866
 FOR   BCD 1FOR000                                                      9AP51867
 MZE   BCD 1MZE000                                                      9AP51868
 PZE   BCD 1PZE000                                                      9AP51869
 BL    BCD 1   000                                                      9AP51870
 THREE TXH 0                                                            9AP51871
       REM                                                              9AP51872
 STGA  BSS 12                                                           9AP51873
 STGB  BSS 12                                                           9AP51874
 STGC  BSS 1                                                            9AP51875
 STGD  HTR 0                                                            9AP51876
 STGE  BCD                                                              9AP51877
       BCD 2 PAGE                                                       9AP51878
 BCD0  BCD 10                                                           9AP51879
 BCD1R BCD 11                                                           9AP51880
 LBLNK PZE BLANKS                                                       9AP51881
 LBCD0 PZE BCD0                                                         9AP51882
 LBCD1 PZE BCD1R                                                        9AP51883
 L12   PZE 0,0,12                                                       9AP51884
 L56   PZE 0,0,56                                                       9AP51885
 CWA   PZE STGA+12,0,12                                                 9AP51886
 CWB   PZE STGB+12,0,12                                                 9AP51887
 CWC   PZE STGE+12,0,12                                                 9AP51888
 LCWA  CLA CWA                                                          9AP51889
 LCWB  CLA CWB                                                          9AP51890
 LCWC  CLA CWC                                                          9AP51891
 LCWD  CLA LMT                                                          9AP51892
 LCWE  TXL WT7                                                          9AP51893
 LCWF  CLA LMT2                                                         9AP51894
 L24WD TXH PCH5,2,23                                                    9AP51895
       TXL PCH6                                                         9AP51896
       TXL ST3,4,-96                                                    9AP51897
 LABS  TXH PCH5,2,21                                                    9AP51898
       SXD VR,2                                                         9AP51899
       TXL ST3,4,-110                                                   9AP51900
 LD1   RTBB 1                                                           9AP51901
 LD2   RCDA                                                             9AP51902
 LTRA  OCT -002000000000                                                9AP51903
 LTRB  TRA                                                              9AP51904
 TSA                                                                    9AP51905
 TSB                                                                    9AP51906
 TSC                                                                    9AP51907
 TSD                                                                    9AP51908
 TSE                                                                    9AP51909
 TSF                                                                    9AP51910
 RCW21 PZE                                                              9AP51911
 RCW23 BCI     1, U                                                     9AP51912
 RCW25 PZE     RCW21                                                    9AP51913
       REM                                                              9AP51914
       REM                                                              9AP51915
BLANKS SYN MASK                                                         9AP51916
 TEN   SYN Q10                                                          9AP51917
 T     SYN SAVE                                                         9AP51918
 WORD  SYN DATUM                                                        9AP51919
 ONE   SYN Q128                                                         9AP51920
 OPSIZ EQU     2200                                                     9AP51921
 OPTBL SYN OPSIZ+2                                                      9AP51922
 SIZE  EQU     3072                                                     9AP51923
 CKSUM SYN SIZE+1                                                       9AP51924
 STBL  SYN SIZE+2                                                       9AP51925
 ETBL  SYN SIZE+3                                                       9AP51926
 WT5   EQU RCW20                                                        9AP51927
       REM                                                              9AP51928
 RCW6  IORP STGA,,12                                                    9AP51929
       IORT STGB,,12                                                    9AP51930
 RCW7  IOCT    BCD,0,7                                                  9AP51931
 RCW26 IOCD    BCD+7,0,7                                                9AP51932
 RCW8  IOCD TEQ,,1                                                      9AP51933
 RCW11 IOCD BCD1R,,1                                                    9AP51934
 CW12  IOCD BCD1R,,1                                                    9AP51935
 RCW13 IOCT 0,,3                                                        9AP51936
 RCWBL IOCD BLANKS,,1                                                   9AP51937
 LOAD                                                                   9AP51938
 WT7   SYN WT1                                                          9AP51939
 FINOP SYN     LOAD                                                     9AP51940
 XYZ10 LXD     WCT,4                                                    9AP51941
 LRBIT SYN     PBIT                                                     9AP51942
 003LR SYN     Q3                                                       9AP51943
 LRNOP SYN     NOP                                                      9AP51944
 INTER RTDB    2                                                        9AP51945
OUTPUT RTDB    3                                                        9AP51946
       END  STRTG                                                       9AP51947
       REM  THE CALL CARD FOR THE ASSEMBLER         9AP6                9AP6  01
                                             10 OCTOBER 1958            9AP6  02
       ORG     0                                                        9AP6  03
       FUL                                                              9AP6  04
       IOCD    3,0,21                                                   9AP6  05
       TCOA    *                                                        9AP6  06
       LXA     *+1,4                                                    9AP6  07
       NOP     COUNT                                                    9AP6  08
       REWB    TAPE                                                     9AP6  09
 READ  RTBB    TAPE                                                     9AP6  10
       TXL     LOAD,4,0                                                 9AP6  11
       TXI     READ,4,-1                                                9AP6  12
 LOAD  RCHB    IO                                                       9AP6  13
       LCHB    ZERO                                                     9AP6  14
       TTR     ONE                                                      9AP6  15
 IO    IOCT    0,0,3                                                    9AP6  16
 ONE   EQU     1                                                        9AP6  17
 ZERO  EQU     0                                                        9AP6  18
 TAPE  EQU     1                                                        9AP6  19
 COUNT EQU                       THE NUMBER OF RECORDS PRECEDING 9AP ON 9AP6  20
       REM                       THE SYSTEM TAPE                        9AP6  21
       END                                                              9AP6  22
                                                                                
