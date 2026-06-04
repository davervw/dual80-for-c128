; 80dual - extended screen support for C128
;
; Copyright (c) 2026 David R. Van Wagner
; https://davevw.com
; https://github.com/davervw/dual80-for-c128
; MIT LICENSE

; as this originated as machine code and data entered in the monitor
; this source is not more than a listing at this point, no annotations

* = $1300
.C:1300  A0 00       LDY #$00
.C:1302  BE C4 1B    LDX $1BC4,Y
.C:1305  30 12       BMI $1319
.C:1307  B9 C5 1B    LDA $1BC5,Y
.C:130a  8E 00 D6    STX $D600
.C:130d  2C 00 D6    BIT $D600
.C:1310  10 FB       BPL $130D
.C:1312  8D 01 D6    STA $D601
.C:1315  C8          INY
.C:1316  C8          INY
.C:1317  D0 E9       BNE $1302
.C:1319  A9 00       LDA #$00
.C:131b  8D 20 D0    STA $D020
.C:131e  8D 21 D0    STA $D021
.C:1321  8D FB 1B    STA $1BFB
.C:1324  78          SEI
.C:1325  A2 14       LDX #$14
.C:1327  8D 14 03    STA $0314
.C:132a  8E 15 03    STX $0315
.C:132d  58          CLI
.C:132e  4C 7D 1A    JMP $1A7D
.C:1331  00          BRK
.C:1332  00          BRK
.C:1333  00          BRK
.C:1334  00          BRK
.C:1335  B9 9B 1B    LDA $1B9B,Y
.C:1338  A2 12       LDX #$12
.C:133a  8E 00 D6    STX $D600
.C:133d  2C 00 D6    BIT $D600
.C:1340  10 FB       BPL $133D
.C:1342  8D 01 D6    STA $D601
.C:1345  B9 82 1B    LDA $1B82,Y
.C:1348  A2 13       LDX #$13
.C:134a  8E 00 D6    STX $D600
.C:134d  2C 00 D6    BIT $D600
.C:1350  10 FB       BPL $134D
.C:1352  8D 01 D6    STA $D601
.C:1355  98          TYA
.C:1356  48          PHA
.C:1357  A0 00       LDY #$00
.C:1359  A2 1F       LDX #$1F
.C:135b  8E 00 D6    STX $D600
.C:135e  2C 00 D6    BIT $D600
.C:1361  10 FB       BPL $135E
.C:1363  AD 01 D6    LDA $D601
.C:1366  99 00 1B    STA $1B00,Y
.C:1369  C8          INY
.C:136a  C0 28       CPY #$28
.C:136c  90 ED       BCC $135B
.C:136e  68          PLA
.C:136f  48          PHA
.C:1370  A8          TAY
.C:1371  18          CLC
.C:1372  B9 9B 1B    LDA $1B9B,Y
.C:1375  69 08       ADC #$08
.C:1377  A2 12       LDX #$12
.C:1379  8E 00 D6    STX $D600
.C:137c  2C 00 D6    BIT $D600
.C:137f  10 FB       BPL $137C
.C:1381  8D 01 D6    STA $D601
.C:1384  B9 82 1B    LDA $1B82,Y
.C:1387  A2 13       LDX #$13
.C:1389  8E 00 D6    STX $D600
.C:138c  2C 00 D6    BIT $D600
.C:138f  10 FB       BPL $138C
.C:1391  8D 01 D6    STA $D601
.C:1394  A0 00       LDY #$00
.C:1396  A2 1F       LDX #$1F
.C:1398  8E 00 D6    STX $D600
.C:139b  2C 00 D6    BIT $D600
.C:139e  10 FB       BPL $139B
.C:13a0  AD 01 D6    LDA $D601
.C:13a3  99 28 1B    STA $1B28,Y
.C:13a6  C8          INY
.C:13a7  C0 28       CPY #$28
.C:13a9  90 ED       BCC $1398
.C:13ab  68          PLA
.C:13ac  A8          TAY
.C:13ad  60          RTS
.C:13ae  98          TYA
.C:13af  48          PHA
.C:13b0  A9 04       LDA #$04
.C:13b2  EA          NOP
.C:13b3  EA          NOP
.C:13b4  18          CLC
.C:13b5  79 69 1B    ADC $1B69,Y
.C:13b8  8D D0 13    STA $13D0
.C:13bb  69 D4       ADC #$D4
.C:13bd  8D D9 13    STA $13D9
.C:13c0  B9 50 1B    LDA $1B50,Y
.C:13c3  8D CF 13    STA $13CF
.C:13c6  8D D8 13    STA $13D8
.C:13c9  A2 00       LDX #$00
.C:13cb  BD 00 1B    LDA $1B00,X
.C:13ce  9D C0 07    STA $07C0,X
.C:13d1  BC 28 1B    LDY $1B28,X
.C:13d4  B9 B4 1B    LDA $1BB4,Y
.C:13d7  9D C0 DB    STA $DBC0,X
.C:13da  E8          INX
.C:13db  E0 28       CPX #$28
.C:13dd  90 EC       BCC $13CB
.C:13df  68          PLA
.C:13e0  A8          TAY
.C:13e1  60          RTS

* = $1400
.C:1400  BD 07 01    LDA $0107,X
.C:1403  A2 0F       LDX #$0F
.C:1405  DD 00 16    CMP $1600,X
.C:1408  F0 58       BEQ $1462
.C:140a  B0 03       BCS $140F
.C:140c  CA          DEX
.C:140d  10 F6       BPL $1405
.C:140f  AC FB 1B    LDY $1BFB
.C:1412  C0 15       CPY #$15
.C:1414  90 02       BCC $1418
.C:1416  A0 00       LDY #$00
.C:1418  18          CLC
.C:1419  98          TYA
.C:141a  69 05       ADC #$05
.C:141c  8D 28 14    STA $1428
.C:141f  EA          NOP
.C:1420  20 35 13    JSR $1335
.C:1423  20 AE 13    JSR $13AE
.C:1426  C8          INY
.C:1427  C0 05       CPY #$05
.C:1429  90 F4       BCC $141F
.C:142b  8C FB 1B    STY $1BFB
.C:142e  A2 0E       LDX #$0E
.C:1430  8E 00 D6    STX $D600
.C:1433  2C 00 D6    BIT $D600
.C:1436  10 FB       BPL $1433
.C:1438  AC 01 D6    LDY $D601
.C:143b  E8          INX
.C:143c  8E 00 D6    STX $D600
.C:143f  2C 00 D6    BIT $D600
.C:1442  10 FB       BPL $143F
.C:1444  AD 01 D6    LDA $D601
.C:1447  A2 00       LDX #$00
.C:1449  C0 00       CPY #$00
.C:144b  D0 04       BNE $1451
.C:144d  C9 50       CMP #$50
.C:144f  90 09       BCC $145A
.C:1451  E8          INX
.C:1452  E9 50       SBC #$50
.C:1454  B0 F3       BCS $1449
.C:1456  88          DEY
.C:1457  4C 49 14    JMP $1449
.C:145a  8D F9 1B    STA $1BF9
.C:145d  8E FA 1B    STX $1BFA
.C:1460  C9 28       CMP #$28
.C:1462  B0 32       BCS $1496
.C:1464  AD FB 1B    LDA $1BFB
.C:1467  38          SEC
.C:1468  ED FA 1B    SBC $1BFA
.C:146b  C9 06       CMP #$06
.C:146d  B0 27       BCS $1496
.C:146f  A5 7F       LDA $7F
.C:1471  D0 23       BNE $1496
.C:1473  AE FA 1B    LDX $1BFA
.C:1476  BD 69 1B    LDA $1B69,X
.C:1479  18          CLC
.C:147a  69 04       ADC #$04
.C:147c  8D 92 14    STA $1492
.C:147f  8D 95 14    STA $1495
.C:1482  BD 50 1B    LDA $1B50,X
.C:1485  8D 91 14    STA $1491
.C:1488  8D 94 14    STA $1494
.C:148b  AC F9 1B    LDY $1BF9
.C:148e  A9 80       LDA #$80
.C:1490  59 30 06    EOR $0630,Y
.C:1493  99 30 06    STA $0630,Y
.C:1496  4C 65 FA    JMP $FA65

* = $1600
>C:1600  6a 81 82 c4  c5 c6 c7 c8  c9 ca cb cc  cd ce e1 fc   j...............

* = $1a7d
.C:1a7d  20 7D FF    JSR $FF7D
>C:1a80  0d 0d 38 30  44 55 41 4c  20 2d 20 45  58 54 45 4e   ..80DUAL - EXTEN
>C:1a90  44 45 44 20  43 31 32 38  20 53 43 52  45 45 4e 53   DED C128 SCREENS
>C:1aa0  0d 43 4f 50  59 52 49 47  48 54 20 28  43 29 20 32   .COPYRIGHT (C) 2
>C:1ab0  30 32 36 20  44 41 56 49  44 20 56 41  4e 20 57 41   026 DAVID VAN WA
>C:1ac0  47 4e 45 52  20 20 20 20  20 44 41 56  45 56 57 2e   GNER     DAVEVW.
>C:1ad0  43 4f 4d 20  20 4d 49 54  20 4c 49 43  45 4e 53 45   COM  MIT LICENSE
>C:1ae0  00
.C:1ae1  60          RTS

* = $1b00
>C:1b00  20 20 20 20  20 20 20 20  20 20 20 20  20 20 20 20                   
>C:1b10  20 20 20 20  20 20 20 20  20 20 20 20  20 20 20 20                   
>C:1b20  20 20 20 20  20 20 20 20  

* = $1b28
>C:1b28  07 07 07 07  07 07 07 07  07 07 07 07  07 07 07 07   ................
>C:1b38  07 07 07 07  07 07 07 07  07 07 07 07  07 07 07 07   ................
>C:1b48  07 07 07 07  07 07 07 07                             ........

* = $1b50
>C:1b50  00 28 50 78  a0 c8 f0 18  40 68 90 b8  e0 08 30 58   .(Px....@h....0X
>C:1b60  80 a8 d0 f8  20 48 70 98  c0

* = $1b69
>C:1b69  00 00 00 00  00 00 00 01  01 01 01 01  01 02 02 02   ................
>C:1b79  02 02 02 02  03 03 03 03  03                         .........

* = $1b82
>C:1b82  00 50 a0 f0  40 90 e0 30  80 d0 20 70  c0 10 60 b0   .P..@..0.. p..`.
>C:1b92  00 50 a0 f0  40 90 e0 30  80                         .P..@..0.

* = $1b9b
>C:1b9b  00 00 00 00  01 01 01 02  02 02 03 03  03 04 04 04   ................
>C:1bab  05 05 05 05  06 06 06 07  07                         .........

* = $1bb4
>C:1bb4  00 0c 06 0e  05 0d 0b 03  02 0a 08 04  09 07 0f 01  

* = $1bc4
>C:1bc4  00 3f 01 28  02 36 16 89  19 57 1b 28  0c 00 0d 28   .?.(.6...W.(...(
>C:1bd4  15 28 ff ff
