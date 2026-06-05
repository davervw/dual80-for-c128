;============================================================================
; 80dual - extended screen support for C128
;
; Copyright (c) 2026 David R. Van Wagner
; https://davevw.com
; https://github.com/davervw/dual80-for-c128
; MIT LICENSE
;============================================================================

; Description
; 
; demo to extend VDC 80 columns across VIC-II (left) and VDC (right)
; making for a wider 80 column screen -- extending the screen across both monitors
;
; Design
;
; * initializes VDC to 40 column mode, skipping 40 characters so is right side
; * sets up IRQ
; * new irq copies next 5 lines x 40 columns from VDC RAM to VIC-II screen
;   and inverts on VIC-II screen where VDC cursor is pointing
;
; Status = ALPHA, demonstrable, testable but known bugs/limitations

vdc_register = $d600
vdc_value    = $d601

* = $1300 ; fits in an available RAM block on C128
; recommended to configure using with BOOT sector (e.g. see 1571 demo disk)

start_80dual: ;--------------------------------------------------------------
    ldy #$00
--  ldx vdc_init,y
    bmi +
    lda vdc_init+1,y
    stx vdc_register
-   bit vdc_register
    bpl -
    sta vdc_value
    iny
    iny
    bne --
+   lda #$00
    sta linenum
    sei
    lda #<newirq
    ldx #>newirq
    sta $0314 ; irq vector low
    stx $0315 ; irq vector high
    cli
    jmp display_credit

read_line: ;-----------------------------------------------------------------
    lda mult80high,y
    ldx #$12
    stx vdc_register
-   bit vdc_register
    bpl -
    sta vdc_value
    lda mult80low,y
    ldx #$13
    stx vdc_register
-   bit vdc_register
    bpl -
    sta vdc_value
    tya
    pha
    ldy #$00
    ldx #$1f
--  stx vdc_register
-   bit vdc_register
    bpl -
    lda vdc_value
    sta screen_line,y
    iny
    cpy #40 ; for 40 characters
    bcc -- ; repeat
    pla
    pha
    tay
    clc
    lda mult80high,y
    adc #$08
    ldx #$12
    stx vdc_register
-   bit vdc_register
    bpl -
    sta vdc_value
    lda mult80low,y
    ldx #$13
    stx vdc_register
-   bit vdc_register
    bpl -
    sta vdc_value
    ldy #$00
    ldx #$1f
--  stx vdc_register
-   bit vdc_register
    bpl -
    lda vdc_value
    sta attrs_line,y
    iny
    cpy #40 ; for 40 characters
    bcc -- ; repeat
    pla
    tay
    rts

write_line: ;----------------------------------------------------------------
    tya ; save y - line number
    pha
    lda #$04 ; default vicii screen page
    clc
    adc mult40high,y
    sta store_screen+2 ; self-modifying code
    adc #$d4 ; add more to get to color RAM page
    sta store_color+2 ; self-modifying code
    lda mult40low,y
    sta store_screen+1 ; self-modifying code
    sta store_color+1 ; self-modifying code
    ldx #$00
-   lda screen_line,x
store_screen: sta $0400,x ; vicii screen memory (address self-modified)
    lda attrs_line,x
    and #15
    tay
    lda vdc_to_vicii_color,y
store_color: sta $d800,x ; vicii color memory (address self-modified)
    inx
    cpx #40 ; for 40 characters
    bcc - ; repeat
    pla
    tay ; restore y - line number
    rts

newirq: ;--------------------------------------------------------------------
    ; check if rom is busy with vdc from avoid_pages lookup table
    lda $0107,x ; get high byte irq return address off stack
    ldx #$0f ; point to last one => length(avoid_pages)-1
-   cmp avoid_pages,x
    beq exit_irq_halfway
    bcs +
    dex
    bpl - ; repeat 

    ; copy 5 lines from VDC to VIC on each IRQ
+   ldy linenum
    cpy #$15
    bcc +
    ldy #$00
+   clc
    tya
    adc #$05
    sta compare_line_count+1 ; self-modifying code
-   jsr read_line ; read left-side (40 columns) of vdc screen/attrs at line y
    jsr write_line ; write to vic-ii screen/colors at line y
    iny
compare_line_count: cpy #$05 ; for 5 lines - self-modifying code
    bcc - ; repeat
    sty linenum

    ; retrive cursor position
    ldx #$0e ; cursor high position/offset
    stx vdc_register
-   bit vdc_register
    bpl -
    ldy vdc_value
    inx ; cursor low position/offset
    stx vdc_register
-   bit vdc_register
    bpl -
    lda vdc_value

; divide cursor position by 80 to get row/col
    ldx #$00        ; initialize row 0
-   cpy #$00
    bne +           ; can subtract
    cmp #$50
    bcc divide_done ; cannot subtract
+   inx
    sbc #$50        ; one row down
    bcs -           ; no borrow, repeat
    dey             ; borrow takes out of high byte
    jmp -           ; repeat
divide_done:
    sta col
    stx row

; check if on hidden part of VDC screen
    cmp #40         ; on left?
exit_irq_halfway:   ; beq branch was too far, so branch again, bcs scenario covers eq as well
    bcs exit_irq    ; cursor not on VIC side
    lda linenum
    sec
    sbc row
    cmp #$06
    bcs exit_irq    ; cursor's line not drawn this cycle

; enforce background color
    ldx #26 ; fore/back color
    stx vdc_register
-   bit vdc_register
    bpl -
    lda vdc_value
    and #15
    tay
    lda vdc_to_vicii_color,y
    sta $d020 ; VICII background (black)
    sta $d021 ; VICII border (black)

; one more check for cursor
    lda $7f ; BASIC run flag (0x80=running, 0x40=loading, 0=READY) // TODO: need INPUT flag to display cursor
    bne exit_irq    ; do not display cursor when BASIC running

; inverse cursor on VIC-II screen to mirror hidden VDC cursor (off screen)
    ldx row
    lda mult40high,x
    clc
    adc #$04
    sta fetch_reverse+2 ; self-modifying code
    sta store_reverse+2 ; self-modifying code
    lda mult40low,x
    sta fetch_reverse+1 ; self-modifying code
    sta store_reverse+1 ; self-modifying code
    ldy col
    lda #$80 ; reverse mask
fetch_reverse:
    eor $0400,y ; fetch/reverse from screen memory (address self-modified)
store_reverse:
    sta $0400,y ; store back to screen memory (address self-modified)

exit_irq:
    jmp $fa65 ; rom irq handler (normally in $0314/5 vector)

display_credit:
    jsr $FF7D ; kernal print embedded string, nul terminated, followed by more code
        !byte $0d,$0d
        !text "80DUAL - EXTENDED C128 SCREENS",$0d
        !text "COPYRIGHT (C) 2026 DAVID VAN WAGNER     DAVEVW.COM  MIT LICENSE"
        !byte 0
    rts ; more code ... done

; DATA ----------------------------------------------------------------------

avoid_pages: 
    !byte $6a,$81,$82,$c4,$c5,$c6,$c7,$c8,$c9,$ca,$cb,$cc,$cd,$ce,$e1,$fc

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
    !byte $00,$0b,$06,$0e,$05,$0d,$0f,$03,$08,$02,$0a,$04,$09,$07,$0c,$01 ; revised mapping
    ;!byte $00,$0c,$06,$0e,$05,$0d,$0b,$03,$02,$0a,$08,$04,$09,$07,$0f,$01 ; rom mapping

vdc_init: ; // https://techwithdave.davevw.com/2023/12/commodore-128-vdc-reference.html
    !byte $00,$3f ; horizontal total (was 126/127)
    !byte $01,$28 ; horizontal displayed (was 80)
    !byte $02,$36 ; horizontal sync position (was 102)
    !byte $16,$89 ; characters displayed %10001001 (8/9, was 7/8)
    !byte $19,$57 ; graph/text/etc %01010111 (set double Pixel mode - bit 4)
    !byte $1b,$28 ; addr incr per row (40, was 0) so display skips 40 characters
    !byte $0c,$00 ; display address high (unchanged)
    !byte $0d,$28 ; display address low (+40 characters to skip left side)
    !byte $15,$28 ; atribute address low (+40 characters to skip left side)
    !byte $ff,$ff ; end of table marker

col: !byte 0
row: !byte 0
linenum: !byte 0

finish_80dual:

; ---------------------------------------------------------------------------
