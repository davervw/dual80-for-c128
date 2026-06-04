; 80dual - extended screen support for C128
;
; Copyright (c) 2026 David R. Van Wagner
; https://davevw.com
; https://github.com/davervw/dual80-for-c128
; MIT LICENSE

; as this originated as machine code and data entered in the monitor
; this source is not more than a listing at this point, no annotations

* = $1300
LDY #$00
LDX $1BC4,Y
BMI $1319
LDA $1BC5,Y
STX $D600
BIT $D600
BPL $130D
STA $D601
INY
INY
BNE $1302
LDA #$00
STA $D020
STA $D021
STA $1BFB
SEI
LDX #$14
STA $0314
STX $0315
CLI
JMP $1A7D
BRK
BRK
BRK
BRK
LDA $1B9B,Y
LDX #$12
STX $D600
BIT $D600
BPL $133D
STA $D601
LDA $1B82,Y
LDX #$13
STX $D600
BIT $D600
BPL $134D
STA $D601
TYA
PHA
LDY #$00
LDX #$1F
STX $D600
BIT $D600
BPL $135E
LDA $D601
STA $1B00,Y
INY
CPY #$28
BCC $135B
PLA
PHA
TAY
CLC
LDA $1B9B,Y
ADC #$08
LDX #$12
STX $D600
BIT $D600
BPL $137C
STA $D601
LDA $1B82,Y
LDX #$13
STX $D600
BIT $D600
BPL $138C
STA $D601
LDY #$00
LDX #$1F
STX $D600
BIT $D600
BPL $139B
LDA $D601
STA $1B28,Y
INY
CPY #$28
BCC $1398
PLA
TAY
RTS
TYA
PHA
LDA #$04
NOP
NOP
CLC
ADC $1B69,Y
STA $13D0
ADC #$D4
STA $13D9
LDA $1B50,Y
STA $13CF
STA $13D8
LDX #$00
LDA $1B00,X
STA $07C0,X
LDY $1B28,X
LDA $1BB4,Y
STA $DBC0,X
INX
CPX #$28
BCC $13CB
PLA
TAY
RTS

* = $1400
LDA $0107,X
LDX #$0F
CMP $1600,X
BEQ $1462
BCS $140F
DEX
BPL $1405
LDY $1BFB
CPY #$15
BCC $1418
LDY #$00
CLC
TYA
ADC #$05
STA $1428
NOP
JSR $1335
JSR $13AE
INY
CPY #$05
BCC $141F
STY $1BFB
LDX #$0E
STX $D600
BIT $D600
BPL $1433
LDY $D601
INX
STX $D600
BIT $D600
BPL $143F
LDA $D601
LDX #$00
CPY #$00
BNE $1451
CMP #$50
BCC $145A
INX
SBC #$50
BCS $1449
DEY
JMP $1449
STA $1BF9
STX $1BFA
CMP #$28
BCS $1496
LDA $1BFB
SEC
SBC $1BFA
CMP #$06
BCS $1496
LDA $7F
BNE $1496
LDX $1BFA
LDA $1B69,X
CLC
ADC #$04
STA $1492
STA $1495
LDA $1B50,X
STA $1491
STA $1494
LDY $1BF9
LDA #$80
EOR $0630,Y
STA $0630,Y
JMP $FA65

* = $1600
!byte $6a,$81,$82,$c4,$c5,$c6,$c7,$c8,$c9,$ca,$cb,$cc,$cd,$ce,$e1,$fc

* = $1a7d
JSR $FF7D
!byte $0d,$0d
!text "80DUAL - EXTENDED C128 SCREENS COPYRIGHT (C) 2026 DAVID VAN WAGNER     DAVEVW.COM  MIT LICENSE"
!byte 0
RTS

* = $1b00
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0

* = $1b28
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0

* = $1b50
!byte $00,$28,$50,$78,$a0
!byte $c8,$f0,$18,$40,$68
!byte $90,$b8,$e0,$08,$30
!byte $58,$80,$a8,$d0,$f8
!byte $20,$48,$70,$98,$c0

* = $1b69
!byte $00,$00,$00,$00,$00
!byte $00,$00,$01,$01,$01
!byte $01,$01,$01,$02,$02
!byte $02,$02,$02,$02,$02
!byte $03,$03,$03,$03,$03

* = $1b82
!byte $00,$50,$a0,$f0,$40
!byte $90,$e0,$30,$80,$d0
!byte $20,$70,$c0,$10,$60
!byte $b0,$00,$50,$a0,$f0
!byte $40,$90,$e0,$30,$80

* = $1b9b
!byte $00,$00,$00,$00,$01
!byte $01,$01,$02,$02,$02
!byte $03,$03,$03,$04,$04
!byte $04,$05,$05,$05,$05
!byte $06,$06,$06,$07,$07

* = $1bb4
!byte $00,$0c,$06,$0e,$05,$0d,$0b,$03,$02,$0a,$08,$04,$09,$07,$0f,$01

* = $1bc4
!byte $00,$3f
!byte $01,$28
!byte $02,$36
!byte $16,$89
!byte $19,$57
!byte $1b,$28
!byte $0c,$00
!byte $0d,$28
!byte $15,$28
!byte $ff,$ff

* = $1bff
!byte 00
