; 80dual - extended screen support for C128
;
; Copyright (c) 2026 David R. Van Wagner
; https://davevw.com
; https://github.com/davervw/dual80-for-c128
; MIT LICENSE

; as this originated as machine code and data entered in the monitor
; this source is not more than a listing at this point, no annotations

vdc_register = $d600
vdc_value    = $d601

* = $1300
ldy #$00
ldx vdc_init,y
bmi $1319
lda vdc_init+1,y
stx vdc_register
bit vdc_register
bpl $130d
sta vdc_value
iny
iny
bne $1302
lda #$00
sta $d020 ; VICII background (black)
sta $d021 ; VICII border (black)
sta linenum
sei
ldx #$14 ; new irq high
sta $0314 ; irq vector low
stx $0315 ; irq vector high
cli
jmp display_credit
brk
brk
brk
brk
lda mult80high,y
ldx #$12
stx vdc_register
bit vdc_register
bpl $133d
sta vdc_value
lda mult80low,y
ldx #$13
stx vdc_register
bit vdc_register
bpl $134d
sta vdc_value
tya
pha
ldy #$00
ldx #$1f
stx vdc_register
bit vdc_register
bpl $135e
lda vdc_value
sta screen_line,y
iny
cpy #$28
bcc $135b
pla
pha
tay
clc
lda mult80high,y
adc #$08
ldx #$12
stx vdc_register
bit vdc_register
bpl $137c
sta vdc_value
lda mult80low,y
ldx #$13
stx vdc_register
bit vdc_register
bpl $138c
sta vdc_value
ldy #$00
ldx #$1f
stx vdc_register
bit vdc_register
bpl $139b
lda vdc_value
sta attrs_line,y
iny
cpy #$28
bcc $1398
pla
tay
rts
tya
pha
lda #$04
nop
nop
clc
adc mult40high,y
sta $13d0
adc #$d4
sta $13d9
lda mult40low,y
sta $13cf
sta $13d8
ldx #$00
lda screen_line,x
sta $0400,x
ldy attrs_line,x
lda vdc_to_vicii_color,y
sta $d800,x
inx
cpx #$28
bcc $13cb
pla
tay
rts

* = $1400
lda $0107,x ; get high byte irq return address off stack
ldx #$0f
cmp avoid_pages,x
beq $1462
bcs $140f
dex
bpl $1405
ldy linenum
cpy #$15
bcc $1418
ldy #$00
clc
tya
adc #$05
sta $1428
nop
jsr $1335
jsr $13ae
iny
cpy #$05
bcc $141f
sty linenum
ldx #$0e
stx vdc_register
bit vdc_register
bpl $1433
ldy vdc_value
inx
stx vdc_register
bit vdc_register
bpl $143f
lda vdc_value
ldx #$00
cpy #$00
bne $1451
cmp #$50
bcc $145a
inx
sbc #$50
bcs $1449
dey
jmp $1449
sta col
stx row
cmp #$28
bcs $1496
lda linenum
sec
sbc row
cmp #$06
bcs $1496
lda $7f ; BASIC run flag (0x80=running, 0x40=loading, 0=READY) // TODO: need INPUT flag to display cursor
bne $1496
ldx row
lda mult40high,x
clc
adc #$04
sta $1492
sta $1495
lda mult40low,x
sta $1491
sta $1494
ldy col
lda #$80
eor $0400,y
sta $0400,y
jmp $fa65

* = $1600
avoid_pages
!byte $6a,$81,$82,$c4,$c5,$c6,$c7,$c8,$c9,$ca,$cb,$cc,$cd,$ce,$e1,$fc

* = $1a7d
display_credit:
JSR $FF7D
!byte $0d,$0d
!text "80DUAL - EXTENDED C128 SCREENS COPYRIGHT (C) 2026 DAVID VAN WAGNER     DAVEVW.COM  MIT LICENSE"
!byte 0
RTS

* = $1b00
screen_line:
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0

attrs_line:
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0
!byte 0,0,0,0,0,0,0,0,0,0

mult40low:
!byte $00,$28,$50,$78,$a0
!byte $c8,$f0,$18,$40,$68
!byte $90,$b8,$e0,$08,$30
!byte $58,$80,$a8,$d0,$f8
!byte $20,$48,$70,$98,$c0

mult40high:
!byte $00,$00,$00,$00,$00
!byte $00,$00,$01,$01,$01
!byte $01,$01,$01,$02,$02
!byte $02,$02,$02,$02,$02
!byte $03,$03,$03,$03,$03

mult80low:
!byte $00,$50,$a0,$f0,$40
!byte $90,$e0,$30,$80,$d0
!byte $20,$70,$c0,$10,$60
!byte $b0,$00,$50,$a0,$f0
!byte $40,$90,$e0,$30,$80

mult80high:
!byte $00,$00,$00,$00,$01
!byte $01,$01,$02,$02,$02
!byte $03,$03,$03,$04,$04
!byte $04,$05,$05,$05,$05
!byte $06,$06,$06,$07,$07

vdc_to_vicii_color:
!byte $00,$0c,$06,$0e,$05,$0d,$0b,$03,$02,$0a,$08,$04,$09,$07,$0f,$01

vdc_init:
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

*=$1BF9:
col: !byte 0
row: !byte 0
linenum: !byte 0

ending:
!byte 00
