unkData_001_5541::
; game over music data?
	db $06, $00
	dwb unkData_001_554e, $00
	dwb unkData_001_5585, $01
	dwb unkData_001_55e2, $02
	db $00, $00

unkData_001_554e:
	db $fe, $0a, $f5
	db $08, $fc, $00, $fb, $05, $f4, $80, $fd, $03, $f0, $01, $50, $04, $44, $04, $50
	db $04, $4b, $08, $42, $04, $47, $04, $4b, $04, $49, $20, $50, $04, $44, $04, $50
	db $04, $4b, $08, $42, $04, $47, $04, $4b, $04, $49, $20, $a1, $f0, $f0, $00, $50
	db $40, $a0
	db $ff, $ff

unkData_001_5585:
	dr $5585, $55e2

unkData_001_55e2:
	dr $55e2, $5603

; ###################################################################################

unkData_001_5603::
; Credits song header
	db $04, $00
	dwb unkData_001_5611, $00
	dwb unkData_001_57b2, $01
	dwb unkData_001_5931, $02
	dwb unkData_001_5b44, $03

unkData_001_5611:
	dr $5611, $57b2

unkData_001_57b2:
	dr $57b2, $5931

unkData_001_5931:
	dr $5931, $5b44

unkData_001_5b44:
	dr $5b44, $5d41

; ###################################################################################

unkData_001_5d41::
; Increase life tune?
	db $03, $02
	dwb unkData_001_5d4e, $04
	dwb unkData_001_5d6d, $05
	dwb $0000, $00
	dw $0000

unkData_001_5d4e:
	db $fe, $0f, $f5
	db $08, $f4, $40, $fc, $0e, $fa, $03, $f8, $01, $fd, $01, $f0, $01, $44, $02, $40
	db $02, $47, $02, $4b, $02, $50, $02, $52, $02, $57, $0c
	db $ff

unkData_001_5d6d:
	db $fe, $0f, $f4, $40
	db $fc, $0e, $fa, $03, $f8, $01, $fd, $01, $f0, $02, $40, $02, $37, $02, $44, $02
	db $47, $02, $47, $02, $4b, $02, $50, $0c
	db $ff

; ###################################################################################

unkData_001_5d8a:
	db $02, $02
	dwb unkData_001_5d97, $00
	dwb unkData_001_5dba, $01
	dwb $0000, $02
	dw $0000

unkData_001_5d97:
	db $fe, $0f, $f5, $08, $f4, $80, $fc, $0c, $fa, $06
	db $f8, $01, $fd, $03, $f0, $01, $30, $02, $34, $02, $37, $02, $37, $02, $40, $08
	db $00, $08, $fd, $01, $00, $08, $f0, $00
	db $ff

unkData_001_5dba:
	db $fe, $0f, $f4, $80, $fc, $0c, $fa
	db $06, $f8, $01, $fd, $03, $f0, $02, $37, $02, $40, $02, $44, $02, $44, $02, $47
	db $06, $00, $08, $fd, $01, $00, $08, $f0, $00
	db $ff

; ###################################################################################

unkData_001_5ddb:
	db $03, $00
	db $e8, $5d, $00
	db $23, $5e, $01
	db $3c, $5e, $02
	db $00, $00

	db $fe, $06, $f4, $00, $fc, $0f, $fa, $02, $f7
	db $01, $ef, $03, $f6, $08, $f8, $01, $fd, $02, $f0, $01, $fe, $0a, $50, $01, $fe
	db $06, $50, $01, $f0, $02, $fe, $03, $50, $01, $fe, $01, $50, $01, $fe, $0a, $50
	db $01, $fe, $06, $50, $01, $f0, $01, $fe, $03, $50, $01, $fe, $01, $50, $01, $a0
	db $ed
	db $ff

unkData_001_5e23:
	db $fe, $08, $f4, $00, $fc, $0f, $fa, $02, $f8, $01, $fd, $02, $f0, $03, $32, $20
	db $33, $20, $34, $20, $35, $20, $a0, $fc
	db $ff

unkData_001_5e3c:
	db $fe, $0f, $f2, $01, $fc, $0c, $fa, $04, $f8, $01, $fd, $01, $f0, $03, $20, $08
	db $20, $08, $20, $08, $20, $02, $20, $02, $20, $02, $00, $02, $a0, $f9
	db $ff

; ###################################################################################

unkData_001_5e5b:
	db $02, $02, $68, $5e, $05, $95, $5e, $04, $00, $00, $00, $00, $00, $fe, $0a, $f5
	db $08, $f4, $00, $fc, $0b, $fa, $06, $f8, $01, $fd, $00, $f0, $03, $44, $02, $f0
	db $02, $42, $02, $f0, $01, $40, $02, $f0, $03, $42, $02, $f0, $01, $44, $02, $f0
	db $02, $49, $02, $f0, $03, $f8, $00, $47, $0c
	db $ff

unkData_001_5e95:
	db $fe, $0a, $f4, $00, $fc, $0b
	db $fa, $06, $f8, $01, $f0, $03, $47, $02, $45, $02, $44, $02, $45, $02, $47, $02
	db $42, $02, $40, $0c
	db $ff

; ###################################################################################

unkData_001_5eb0::
; Boss music
	db $03, $00
	dwb $0000, $02
	dwb unkData_001_5ebd, $00
	dwb unkData_001_5f02, $01
	dw $0000

unkData_001_5ebd:
	db $fe, $0c, $f8, $01, $fc, $01, $fa, $03, $f4, $40, $fd, $02, $f0, $03
	db $26, $04, $26, $04, $27, $04, $27, $02, $27, $02, $29, $04, $29, $02, $29, $02
	db $2a, $02, $30, $02, $34, $02, $36, $02, $93, $f4, $24, $04, $24, $04, $26, $04
	db $26, $02, $26, $02, $27, $04, $27, $02, $27, $02, $29, $02, $2a, $02, $32, $02
	db $34, $02, $93, $f4, $a0, $e6
	db $ff

unkData_001_5f02:
	db $fe, $0f, $f8, $01, $fc, $0c, $fa, $04, $f2, $01, $fd, $02, $f0, $03, $19, $08
	db $19, $08, $00, $10, $93, $fd, $17, $08, $17, $08, $00, $10, $93, $fd, $a0, $f8
	db $ff

unkData_001_5f23:
	dr $5f23, $600e

; ###################################################################################

unkData_001_600e::
; "Next stage" music
	db $03, $03
	dwb unkData_001_601c, $00
	dwb unkData_001_6047, $01
	dwb unkData_001_6070, $02
	dwb unkData_001_60d3, $05

unkData_001_601c:
	db $fe, $08
	db $f5, $00, $f4, $40, $fc, $0e, $fa, $06, $fd, $00, $f8, $01, $f0, $03, $47, $10
	db $45, $10, $44, $10, $42, $08, $44, $04, $45, $04, $47, $04, $00, $02, $47, $04
	db $00, $02, $47, $10, $fd, $03, $00, $08, $ff

unkData_001_6047:
	db $fe, $08, $f0, $03, $f4, $40, $fc
	db $0e, $fa, $06, $fd, $00, $f8, $01, $42, $10, $40, $10, $3b, $10, $39, $08, $3b
	db $04, $40, $04, $42, $04, $00, $02, $42, $04, $00, $02, $42, $10, $fd, $03, $00
	db $08, $ff

unkData_001_6070:
	db $fe, $0f, $f0, $03, $fc, $0d, $f2, $01, $fa, $04, $f8, $01, $f0, $01
	db $17, $02, $f0, $02, $17, $02, $93, $fc, $f0, $01, $15, $02, $f0, $02, $15, $02
	db $93, $fc, $f0, $01, $14, $02, $f0, $02, $14, $02, $93, $fc, $f0, $01, $12, $02
	db $f0, $02, $12, $02, $91, $fc, $f0, $01, $14, $02, $f0, $02, $14, $02, $f0, $01
	db $15, $02, $f0, $02, $15, $02, $f0, $01, $17, $02, $f0, $02, $00, $02, $f0, $01
	db $00, $02, $f0, $02, $17, $02, $f0, $01, $00, $02, $f0, $02, $00, $02, $17, $10
	db $fd, $03, $00, $08
	db $ff

unkData_001_60d3:
	db $f8, $01, $fe, $08, $fd, $00, $f0, $03, $fc, $00, $fe
	db $06, $fb, $01, $f9, $38, $03, $02, $03, $02, $f0, $01, $fe, $09, $fb, $02, $f9
	db $50, $02, $02, $fe, $06, $f0, $03, $fb, $01, $f9, $38, $03, $02, $f0, $02, $fe
	db $09, $fb, $02, $f9, $50, $02, $02, $fe, $06, $f0, $03, $fb, $01, $f9, $38, $03
	db $02, $03, $02, $fe, $09, $f0, $01, $fb, $02, $f9, $50, $02, $02, $f0, $03, $fe
	db $06, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $09, $f0, $02, $fb, $02, $f9
	db $50, $02, $02, $f0, $03, $fe, $06, $fb, $01, $f9, $38, $03, $02, $fe, $09, $f0
	db $01, $fb, $02, $f9, $50, $02, $02, $f0, $03, $fe, $06, $fb, $01, $f9, $38, $03
	db $02, $03, $02, $f0, $02, $fe, $09, $fb, $02, $f9, $50, $02, $02, $f0, $03, $fe
	db $06, $fb, $01, $f9, $38, $03, $02, $03, $02, $f0, $01, $fe, $09, $fb, $02, $f9
	db $50, $02, $02, $fe, $06, $f0, $03, $fb, $01, $f9, $38, $03, $02, $fe, $09, $f0
	db $02, $fb, $02, $f9, $50, $02, $02, $fe, $06, $f0, $03, $fb, $01, $f9, $38, $03
	db $02, $03, $02, $fe, $09, $f0, $01, $fb, $02, $f9, $50, $02, $02, $f0, $03, $fe
	db $06, $fb, $01, $f9, $38, $03, $02, $03, $02, $f0, $02, $fe, $09, $fb, $02, $f9
	db $50, $02, $02, $f0, $03, $fe, $06, $fb, $01, $f9, $38, $03, $02, $fe, $09, $f0
	db $01, $fb, $02, $f9, $50, $02, $02, $f0, $03, $fe, $06, $fb, $01, $f9, $38, $03
	db $02, $03, $02, $fe, $09, $f0, $02, $fb, $02, $f9, $50, $02, $02, $f0, $03, $02
	db $02, $fe, $0c, $f0, $01, $fb, $01, $f9, $38, $03, $02, $f0, $02, $03, $02, $fe
	db $09, $f0, $03, $fb, $02, $f9, $50, $02, $02, $fe, $0c, $f0, $01, $fb, $01, $f9
	db $38, $03, $02, $f0, $02, $03, $02, $fe, $0c, $f0, $03, $fb, $02, $f9, $50, $02
	db $04
	db $ff

; ###################################################################################

unkData_001_6210::
; Level 1 and 2 track
	db $02, $00
	dwb $0000, $03
	dwb unkData_001_621e, $00
	dwb unkData_001_6295, $01
	dwb unkData_001_636c, $02

unkData_001_621e:
; channel 2 tone
	db $f0, $03, $fe, $09, $f4, $80, $f8, $01, $fc, $0e, $fa, $05, $fd, $05, $fd, $00
	db $00, $40
	db $fd, $05

	db $39, $04
	db $40, $04
	db $44, $04
	db $47, $24
	db $46, $06
	db $47, $06
	db $46, $04
	db $44, $0c
	db $40, $10
	db $37, $24
	db $39, $04 ; etc. etc.
	db $40, $04, $44, $04, $47, $24
	db $46, $06, $47, $06, $49, $04, $49, $0c, $47, $0c, $46, $04, $42, $24, $39, $0c
	db $40, $0c, $45, $0c, $39, $04, $40, $04, $45, $04, $39, $04, $40, $08, $45, $04
	db $47, $0c, $42, $0c, $3b, $04, $37, $24, $50, $04, $52, $04, $00, $04, $47, $04
	db $49, $04, $00, $04, $42, $04, $44, $04, $00, $04, $40, $04, $42, $04, $00, $04
	db $37, $08
	db $38, $08
	db $a0, $cd
	db $ff

unkData_001_6295:
; channel 3 wave
	db $f0, $03, $f2, $01, $fe, $0f, $f8, $01, $fc, $0d, $fa, $05, $fd, $05, $30, $04
	db $32, $04, $00, $04, $27, $04, $29, $04, $00, $04, $22, $04, $24, $04, $00, $04
	db $20, $04, $22, $04, $00, $04, $17, $08, $18, $08, $19, $04, $19, $04, $19, $04
	db $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $91, $f8, $19, $04, $19, $04
	db $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $17, $14, $17, $08, $18, $08
	db $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04
	db $91, $f8, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04
	db $17, $14, $17, $04, $1b, $08, $15, $04, $15, $04, $15, $04, $15, $04, $15, $04
	db $15, $04, $15, $04, $15, $04, $15, $04, $15, $04, $15, $04, $15, $04, $15, $04
	db $14, $04, $15, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04
	db $17, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04
	db $17, $08, $18, $08, $30, $04, $32, $04, $00, $04, $27, $04, $29, $04, $00, $04
	db $22, $04, $24, $04, $00, $04, $20, $04, $22, $04, $00, $04, $17, $08, $18, $08
	db $a0, $02, $a0, $9e, $a0, $ff
	db $ff

unkData_001_636c:
; channel 4 percussion track
	db $f0, $03, $fe, $07, $f8, $01, $fd, $00, $fc, $00, $fb, $02, $f9, $30, $02, $04
	db $02, $04, $fb, $01, $f9, $38, $03, $04, $fb, $02, $f9, $30, $02, $04, $02, $04
	db $fb, $01, $f9, $38, $03, $04, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01
	db $f9, $38, $03, $04, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38
	db $03, $04, $fb, $02, $f9, $30, $02, $04, $fb, $01, $f9, $38, $03, $04, $fb, $02
	db $f9, $30, $02, $04, $fb, $01, $f9, $38, $03, $04, $03, $02, $03, $02, $03, $02
	db $03, $02, $fb, $02, $f9, $30, $02, $04, $fb, $01, $f9, $38, $03, $02, $03, $02
	db $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $04
	db $fb, $01, $f9, $38, $03, $02, $a0, $02, $a0, $c1, $03, $02, $03, $02, $03, $02
	db $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02
	db $03, $02, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38
	db $03, $02, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38
	db $03, $02, $93, $cc, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02
	db $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02
	db $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02, $fb, $02, $f9, $30
	db $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02
	db $fb, $01, $f9, $38, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38
	db $03, $02, $fb, $02, $f9, $30, $02, $02, $a0, $02, $a0, $b7, $02, $02, $fb, $01
	db $f9, $38, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38
	db $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $02, $02, $fb, $01, $f9, $38
	db $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02
	db $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02
	db $91, $b2, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38, $03, $02
	db $00, $02, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38, $03, $02
	db $00, $02, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38, $03, $02
	db $00, $02, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38, $03, $02
	db $00, $02, $fb, $02, $f9, $30, $02, $04, $00, $04, $02, $04, $00, $04, $a0, $b6
	db $ff

; ###################################################################################

unkData_001_651d::
	db $04, $00
	dwb $0000, $03
	dwb unkData_001_652b, $00
	dwb unkData_001_65c0, $01
	dwb unkData_001_6703, $02

unkData_001_652b:
	dr $652b, $65c0

unkData_001_65c0:
	dr $65c0, $6703

unkData_001_6703:
	dr $6703, $6997

unkData_001_6997:
	dr $6997, $6b60

; ###################################################################################

unkData_001_6b60::
	db $03, $00
	dwb $0000, $03
	dwb unkData_001_6b6e, $00
	dwb unkData_001_6bdd, $01
	dwb unkData_001_6cee, $02

unkData_001_6b6e:
	db $f0, $03
	db $f4, $80, $fc, $0e, $fa, $07, $fd, $03, $fe, $0a, $00, $20, $fd, $00, $00, $20
	db $fd, $05, $39, $1c, $3b, $04, $40, $1c, $44, $04, $42, $18, $3b, $08, $37, $20
	db $39, $1c, $3b, $04, $40, $1c, $44, $04, $42, $18, $3b, $08, $37, $1c, $3b, $04
	db $42, $04, $00, $02, $40, $04, $00, $02, $44, $06, $42, $06, $3b, $04, $37, $04
	db $42, $04, $00, $02, $40, $04, $00, $02, $44, $06, $42, $06, $3b, $04, $40, $02
	db $42, $02, $42, $04, $00, $02, $40, $04, $00, $02, $44, $06, $42, $06, $3b, $04
	db $40, $04, $42, $04, $44, $04, $47, $04, $49, $20, $a0, $d1
	db $ff

unkData_001_6bdd:
	db $f0, $03, $fe, $0f, $f2, $01, $fc, $0d, $fa, $05, $f8, $01, $fd, $05, $19, $02
	db $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $93, $f1
	db $19, $02, $19, $02, $19, $02, $00, $02, $19, $02, $19, $02, $19, $02, $00, $02
	db $19, $02, $19, $02, $00, $02, $19, $02, $19, $02, $19, $02, $19, $02, $00, $02
	db $17, $02, $17, $02, $17, $02, $00, $02, $17, $02, $17, $02, $17, $02, $00, $02
	db $17, $02, $17, $02, $00, $02, $17, $02, $17, $02, $17, $02, $17, $02, $00, $02
	db $15, $02, $15, $02, $00, $02, $00, $02, $15, $02, $15, $02, $00, $02, $15, $02
	db $15, $02, $15, $02, $15, $02, $15, $02, $00, $02, $00, $02, $15, $02, $15, $02
	db $17, $02, $17, $02, $17, $02, $00, $02, $17, $02, $17, $02, $17, $02, $00, $02
	db $17, $02, $17, $02, $17, $02, $17, $02, $00, $02, $17, $02, $17, $02, $00, $02
	db $91, $c0, $22, $02, $22, $02, $22, $02, $20, $02, $20, $02, $20, $02, $24, $02
	db $24, $02, $24, $02, $22, $02, $22, $02, $22, $02, $1b, $02, $1b, $02, $17, $02
	db $17, $02, $22, $02, $22, $02, $22, $02, $20, $02, $20, $02, $20, $02, $24, $02
	db $24, $02, $24, $02, $22, $02, $22, $02, $22, $02, $1b, $02, $1b, $02, $20, $02
	db $22, $02, $22, $02, $22, $02, $00, $02, $20, $02, $20, $02, $00, $02, $24, $02
	db $24, $02, $00, $02, $22, $02, $22, $02, $00, $02, $1b, $02, $1b, $02, $20, $02
	db $20, $02, $22, $02, $22, $02, $24, $02, $24, $02, $27, $02, $27, $02, $a0, $80
	db $ff

unkData_001_6cee:
	db $f0, $03, $f8, $01, $fe, $06, $fd, $00, $fc, $00, $00, $1c, $fb, $02, $f9, $30
	db $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02
	db $fe, $08, $fb, $02, $f9, $30, $02, $04, $00, $04, $fe, $05, $fb, $01, $f9, $38
	db $03, $02, $00, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04
	db $00, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02
	db $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02
	db $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08
	db $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02
	db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01
	db $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02
	db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $a0, $02, $a0, $b3, $fe, $05
	db $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02
	db $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05
	db $03, $02, $03, $02, $00, $04, $fe, $05, $03, $02, $03, $02, $03, $02, $00, $02
	db $fe, $05, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
	db $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05, $03, $02
	db $03, $02, $00, $04, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01
	db $f9, $38, $03, $02, $03, $02, $fe, $05, $03, $02, $03, $02, $03, $02, $03, $02
	db $fe, $08, $fb, $02, $f9, $30, $02, $04, $02, $04, $fe, $05, $fb, $01, $f9, $38
	db $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04
	db $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02
	db $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05
	db $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02
	db $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02
	db $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
	db $02, $04, $a0, $02, $a0, $8c, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02
	db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01
	db $f9, $38, $03, $02, $03, $02, $fe, $05, $03, $02, $03, $02, $00, $04, $fe, $05
	db $03, $02, $03, $02, $03, $02, $00, $02, $fe, $05, $03, $02, $03, $02, $03, $02
	db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38
	db $03, $02, $03, $02, $fe, $05, $03, $02, $03, $02, $00, $04, $fe, $08, $fb, $02
	db $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05
	db $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04
	db $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02
	db $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02
	db $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08
	db $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02
	db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01
	db $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02
	db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $a0, $02, $a0, $8c, $fe, $05
	db $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02
	db $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05
	db $03, $02, $03, $02, $00, $04, $fe, $05, $03, $02, $03, $02, $03, $02, $00, $02
	db $fe, $05, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
	db $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05, $03, $02
	db $03, $02, $00, $04, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $a0, $cf
	db $ff

; ###################################################################################

unkData_001_6fcf::
	dr $6fcf, $70f8

unkData_001_70f8::
	dr $70f8, $72d1
