INCLUDE "constants.asm"

SECTION "Home", ROM0

INCLUDE "home/header.asm"

_Start:
	bankswitch $01
	call DisableLCD
	di
	call WriteOAMDMACodeToHRAM
	call InitSound

	ld bc, $10
	ld hl, wcff0
	call ZeroFill

	ld a, 2
	ld [wTopScore + 2], a

Jump_000_016d:
	bankswitch BANK(unkImage_002_4000)
	ld hl, unkImage_002_4000
	ld de, vTiles0
	ld bc, $1000
	call CopyBytes

	ld hl, SolarstrikerLogoGraphics
	ld de, vTiles2
	ld bc, $630
	call CopyBytes

	bankswitch BANK(unkData_003_58b0)
	ld hl, unkData_003_58b0
	ld de, wd000
	ld bc, $80
	call CopyBytes

	ld hl, unkData_003_5930
	ld de, wd200
	ld bc, $90
	call CopyBytes

	bankswitch $01
	call ClearBGMap0

	ld bc, $ff0
	ld hl, wc000
	call ZeroFill

	ld hl, wca88
	ld a, $a2
	ld [hli], a
	ld a, $9a
	ld [hl], a
	call Call_000_13d4

	xor a
	ldh [rSCY], a
	ldh [rSB], a
	ldh [rSC], a
	ld [wcf86], a
	ld [wCurrentStage], a
	ld a, $20
	ldh [rSCX], a
	ld a, $20
	ldh [rSCY], a
	ld a, [wcffc]
	or a
	jr nz, .asm_01e7

	ld de, unkData_000_3e9b
	call Call_000_08a1
	jr .asm_01ed

.asm_01e7
	ld de, unkData_000_3ec7
	call Call_000_08a1

.asm_01ed:
	ld hl, $9a4c
	ld de, wTopScore
	ld b, 7
.copy_digit
	ld a, [de]
	or "０"
	ld [hli], a
	inc de
	dec b
	jr nz, .copy_digit

	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a
	ld a, %01000000
	ldh [rOBP1], a

	ld a, %10001000
	ldh [rLYC], a
	ld a, %01000000
	ldh [rSTAT], a
	xor a
	ldh [rTMA], a
	ldh [rIF], a
	ld de, unk_000_04f5
	call Func_000_0a3e

	ld hl, unkHeader_001_5ddb
	xor a
	call Call_001_49aa

	ld [wcf9a], a
	ld a, TACF_START + TACF_16KHZ
	ldh [rTAC], a
	ld a, %0111
	ldh [rIE], a
	ld a, %10000111
	ldh [rLCDC], a
	ei

.asm_0231
	ld a, [wcf86]
	and a
	jr z, .asm_0231

	ld a, %0111
	ldh [rIE], a
	ei
	xor a
	ld [wca18], a
	ld a, [wca1a]
	or a
	jp nz, Jump_000_054a

	call UpdateJoypad
	call Call_000_0455
	call Call_000_14c4
	xor a
	ld [wcf86], a
	inc a
	ld [wca18], a
	call TrySoftReset
	or a
	jp nz, Jump_000_02ce

	jr .asm_0231

Jump_000_0261:
.loop
	ld a, [wcf86]
	or a
	jr z, .loop

	xor a
	ld [wca18], a
	ld a, %0111
	ldh [rIE], a

	ei
	call Call_000_137a
	call UpdateJoypad
	call Call_000_0455
	call Call_000_14c4

	ld hl, wcf9b
	ld a, [hli]
	or a
	jp nz, Jump_000_05d8
	ld a, [hli]
	or a
	jp nz, Jump_000_0730
	ld a, [hli]
	or a
	jp nz, Jump_000_0381

	call TrySoftReset
	or a
	jp nz, Jump_000_02ce

	ld a, [wShakeCounter]
	or a
	call nz, ShakeScreen
	xor a
	ld [wcf86], a
	jr .loop

Jump_000_02a2:
.asm_02a2
	ld a, [wcf86]
	or a
	jr z, .asm_02a2

	ld a, %0111
	ldh [rIE], a
	ei
	call UpdateJoypad
	call Call_000_0455
	ld a, $01
	ld [wca18], a
	xor a
	ld [wcf86], a
	ld hl, wcf98
	ld a, [hl]
	or a
	jr z, .asm_02a2

	inc [hl]
	cp $04
	jr c, .asm_02a2

	ld a, [wcf9a]
	call unk_001_4bd1

Jump_000_02ce:
.asm_02ce
	ldh a, [rLY]
	cp 144
	jr c, .asm_02ce
	cp 150
	jr nc, .asm_02ce

	ldh a, [rLCDC]
	and $7f
	ldh [rLCDC], a
	ld hl, $ffff
	ld sp, hl
	jp Jump_000_016d

VBlank:
	di
	push af
	push bc
	push de
	push hl
	di
	ld a, %0011
	ldh [rIE], a
	ld a, [wca18]
	and a
	call nz, _HRAM
	ld a, $01
	ld [wcf86], a
	ldh a, [rLCDC]
	or $02
	ldh [rLCDC], a
	call Call_000_1447
	call Call_000_048d
	pop hl
	pop de
	pop bc
	pop af
	reti

LCD:
	push af
	ldh a, [rLCDC]
	and $fd
	ldh [rLCDC], a
	pop af
	reti

Timer:
	push af
	di
	ld a, %0011
	ldh [rIE], a
	ei
	call unk_001_4c97
	ld a, %0111
	ldh [rIE], a
	pop af
	reti

INCLUDE "home/softreset.asm"

Jump_000_0381:
	ld a, [wcf9a]
	call unk_001_4bd1
	ld a, $01
	ld hl, unkHeader_001_5d8a
	call Call_001_49aa
	ld [wcf9a], a
	xor a
	ld [wPaused], a
	call Call_000_0437

.asm_0399
	ld a, [wcf86]
	or a
	jr z, .asm_0399

	xor a
	ld [wca18], a
	call Call_000_048d
	call UpdateJoypad
	call Call_000_14c4
	call unk_001_4c97
	call Call_000_0c04
	or a
	jp nz, .asm_03f6

	call TrySoftReset
	or a
	jp nz, Jump_000_02ce

	ld hl, wPaused
	ld a, [hli]
	or a
	jr z, .asm_03d5
	ld a, [hli]
	or a
	jr z, .asm_03e1
	ld a, [hli]
	or a
	jr z, .asm_03ec

	ld a, [wJoypadDown]
	and $08
	jr z, .asm_03fc

	jr .asm_03f6

.asm_03d5:
	ld a, [wJoypadDown]
	and $08
	jr nz, .asm_03f6

	inc a
	dec hl
	ld [hl], a
	jr .asm_03f6

.asm_03e1:
	ld a, [wJoypadDown]
	and $08
	jr z, .asm_03f6

	dec hl
	ld [hl], a
	jr .asm_03f6

.asm_03ec:
	ld a, [wJoypadDown]
	and $08
	jr nz, .asm_03f6

	inc a
	dec hl
	ld [hl], a

.asm_03f6:
	xor a
	ld [wcf86], a
	jr .asm_0399

.asm_03fc:
	ld hl, wPaused
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wcf86], a
	ld [wcfa2], a
	call Call_000_0446

	ld a, [wBossMusicPlaying]
	or a
	jr z, .asm_041f

	ld hl, unkHeader_001_5eb0
	ld a, [wBossMusicPlaying]
	dec a
	jr z, .asm_042d

	ld hl, unkHeader_001_5f23
	jr .asm_042d

.asm_041f:
	ld a, [wCurrentStage]
	add a
	ld l, a
	ld h, 0
	ld de, MusicTable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

.asm_042d:
	xor a
	call Call_001_49aa
	ld [wcf9a], a
	jp Jump_000_0261

Call_000_0437:
	ld de, PauseText
	ld hl, wcae0
	ld b, 4
asm_043f:
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, asm_043f
	ret

Call_000_0446:
	ld hl, wcae0
	ld de, ScoreText
	ld b, 6
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, asm_043f
	ret

Call_000_0455:
	ld hl, wc700
	ld bc, wca10

Jump_000_045b:
	push hl
	ld a, [hli]
	ld e, a
	ld d, [hl]
	or d
	jp z, Jump_000_047e

	ld a, [bc]
	; Multiply 'a' by $20
	rlca
	swap a
	ld b, a
	and $0f
	ld h, a
	ld a, b
	and $f0
	ld l, a

	ld bc, wc100
	add hl, bc
	ld c, l
	ld b, h
	; Store result
	ld hl, wca12
	ld a, c
	ld [hli], a
	ld [hl], b

	ld l, e
	ld h, d
	jp hl

Jump_000_047e::
; Called once per frame
	pop hl
	inc hl
	inc hl
	ld bc, wca10
	ld a, [bc]
	inc a
	and $20 - 1
	ld [bc], a
	jp nz, Jump_000_045b
	ret

Call_000_048d:
	ld a, [wCurrentStage]
	cp 7
	jr nc, jr_000_04b3

; Copy player's score, and lives into BGMap
	ld c, 13
	ld hl, vBGMap1 + 6 ; Display after "SCORE"
	ld de, wScore

PrintNum:
.copy_digit
	ld a, [de]
	or "０" ; Convert digit into tile
	ld [hli], a
	inc de
	dec c
	jr nz, .copy_digit

; Copy "SCORE" into BGMap
	ld c, 6
	ld hl, vBGMap1
	ld de, wcae0
.copy_char
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .copy_char
	ret

jr_000_04b3:
	ld a, [wcad0]
	or a
	ret z

	ld a, [wcad6]
	ld b, a
	ld hl, wcad4
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, wcad2
	ld a, [hli]
	ld h, [hl]
	ld l, a

.asm_04c8
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_04c8

	ld a, b
	ld [wcad0], a
	ret

ShakeScreen:
	ld hl, rSCY
	ld de, wShakeAmount
	ld a, [de]
	or a
	jr nz, .original_pos

; Generate odd number between 1 and 7
	ldh a, [rDIV]
	and 7
	or %0001
	ld [de], a

; Increment [rSCY]
	inc [hl]
; Add random number to [rSCX]
	inc hl
	add [hl]
	ld [hl], a
	ret

.original_pos
; Revert scroll to original position
; Decrement [rSCY]
	dec [hl]
; Subtract random number from [rSCX]
	inc hl
	ld b, a
	xor a
	sub b
	add [hl]
	ld [hl], a
; shake amount
	xor a
	ld [de], a
; counter
	dec de
	ld [de], a
	ret

unk_000_04f5:
; Load first stage
	ld a, [wJoypadDown]
	ld b, a
	and $08
	jr z, jr_000_0516
	ld a, [wcffa]
	or a
	jp nz, Jump_000_047e

	ld a, $01
	ld [wca1a], a
	ld a, STAGE_1
	ld [wCurrentStage], a
	ld a, $0f
	ld [wca22], a
	jp Jump_000_0a67

jr_000_0516:
	ld [wcffa], a
	ld a, b
	and $04
	jp nz, Jump_000_0525

	ld [wcffb], a
	jp Jump_000_047e

Jump_000_0525:
	ld a, [wcffb]
	or a
	jp nz, Jump_000_047e
	ld a, [wcffc]
	or a
	jp z, Jump_000_047e

	ld a, $01
	ld [wca1a], a
	ld a, STAGE_1
	ld [wCurrentStage], a
	ld a, $0f
	ld [wca22], a
	ld a, $01
	ld [wca2e], a
	jp Jump_000_0a67

Jump_000_054a:
	call DisableLCD
	di
	call ClearBGMap0

	ld bc, $20
	ld hl, vBGMap1
	call ZeroFill

	ld de, unkData_000_0e81
	call Call_000_0dfb

	ld de, unkData_000_0e5d
	call Call_000_0e16

	ld hl, wca88
	ld de, $9b82
	ld a, e
	ld [hli], a
	ld [hl], d
	call Call_000_13d4

	ld de, unkData_000_3ef4
	call Call_000_08a1

	ld de, wcae0
	ld hl, ScoreText
	ld b, 5
.copyText
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copyText

	ld de, $8807
	ld hl, rWY
	ld a, d
	ld [hli], a
	ld [hl], e

	ld de, $6030
	ld hl, rSCY
	ld a, d
	ld [hli], a
	ld [hl], e
	ld de, unk_000_16b3
	call Func_000_0a3e
	ld de, unk_000_17e3
	call Func_000_0a3e
	ld de, unk_000_0c19
	call Func_000_0a3e
	ld de, unk_000_0d1c
	call Func_000_0a3e

	ld b, 3
.asm_05b2
	push bc
	ld de, unk_000_1801
	call Func_000_0a3e
	pop bc
	dec b
	jr nz, .asm_05b2

	xor a
	ld [wca23], a
	ld [wcf86], a
	ld [wca54], a

	ld a, %11100111
	ldh [rLCDC], a
	ld a, TACF_START + TACF_16KHZ
	ldh [rTAC], a
	ld a, 2
	ld [wLives], a
	ei
	jp Jump_000_06cd

Jump_000_05d8:
	ld a, [wcf9a]
	call unk_001_4bd1
	di
	xor a
	ldh [rTAC], a
	ldh [rTMA], a
	ld [wcf9b], a
	ld [wca18], a
	call DisableLCD

	ld a, [wCurrentStage]
	cp 8
	jr nz, .not_final_cutscene

	bankswitch BANK(unkImage_002_7950)
	ld hl, unkImage_002_7950
	ld de, vTiles0
	ld bc, $800
	call CopyBytes

.not_final_cutscene:
	call ClearBGMap0
	ld de, unkData_000_0e81
	call Call_000_0dfb

	ld de, unkData_000_0e5d
	call Call_000_0e16

	call ClearBGMap0
	ld hl, wca88
	ld de, $9b82
	ld a, e
	ld [hli], a
	ld [hl], d
	call Call_000_13d4

	ld hl, wca82
	xor a
	ld [hli], a
	ld [hl], a

	ld hl, wca28
	ld [hli], a
	ld [hl], a

	ld [wcf9c], a
	ld [wPlayerHP], a
	ld [wca81], a
	ld [wcf86], a
	ld [wcac5], a
	ld [wca80], a
	ld [wBossMusicPlaying], a
	ld [wcad8], a
	ld [wcad0], a
	ld [wShakeCounter], a
	ld [wShakeAmount], a

	ld a, [wCurrentStage]
	cp 7
	jr nc, .asm_067b

	ld a, $30
	ldh [rSCX], a
	ld a, $60
	ldh [rSCY], a
	ld de, $8807
	ld hl, rWY
	ld a, d
	ld [hli], a
	ld [hl], e
	ld a, %11100100
	ldh [rBGP], a

	ld de, unk_000_0d1c
	call Func_000_0a3e

	ld a, TACF_START + TACF_16KHZ
	ldh [rTAC], a
	ld a, %11100111
	ldh [rLCDC], a
	jr Jump_000_06cd

.asm_067b:
	ld a, $50
	ldh [rSCX], a
	ld a, $60
	ldh [rSCY], a

	ld d, $88
	ld a, [wCurrentStage]
	cp 7
	jr z, .cutscene_1

	call ClearBGMap1
	ld d, $68

.cutscene_1:
	ld hl, rWY
	ld a, d
	ld [hli], a
	ld a, $07
	ld [hl], a
	ld a, %11100100
	ldh [rBGP], a
	ld de, unk_000_0d1c
	call Func_000_0a3e

	ld a, [wCurrentStage]
	cp 8
	jr z, .final_cutscene

	ld de, $2d09
	call Func_000_0a3e
	jr .asm_06c2

.final_cutscene:
	xor a
	ld hl, vBGMap1
	ld b, BG_MAP_WIDTH - 1
.loop
	ld [hli], a
	dec b
	jr nz, .loop

	ld de, $2ec9
	call Func_000_0a3e

.asm_06c2:
	ld a, TACF_START + TACF_16KHZ
	ldh [rTAC], a
	ld [wca81], a
	ld a, %11100111
	ldh [rLCDC], a

Jump_000_06cd:
	ei
	ld b, 0

	ld a, [wCurrentStage]
	cp 7
	jp z, Jump_000_0261
	jr c, .asm_06db
	inc b

.asm_06db:
	add a
	ld l, a
	ld h, 0
	ld de, MusicTable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, b
	call Call_001_49aa
	ld [wcf9a], a
	ei
	jp Jump_000_0261

unk_000_06f1:
	ld hl, wFadeoutCounter
	ld a, [hl]
	inc [hl]
	cp $20
	jr nc, .asm_0705

	ld a, $90
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	jp Jump_000_047e

.asm_0705:
	cp $30
	jr nc, .asm_0714
	ld a, %01000000
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	jp Jump_000_047e

.asm_0714:
	cp $40
	jr nc, .asm_0722
	xor a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	jp Jump_000_047e

.asm_0722:
	ld a, %11100100
	ldh [rOBP0], a
	ldh [rOBP1], a
	ld a, $01
	ld [wcf9c], a
	jp Jump_000_0a67

Jump_000_0730:
	ld a, [wcf9a]
	call unk_001_4bd1

	di
	xor a
	ldh [rTAC], a
	ldh [rTMA], a
	ld [wca18], a
	call DisableLCD

	bankswitch BANK(unkData_002_6230)
	ld hl, unkData_002_6230
	ld de, vTiles2
	ld bc, $360
	call CopyBytes

	bankswitch BANK(unkData_003_59c0)
	ld hl, unkData_003_59c0
	ld de, wd000
	ld bc, $200
	call CopyBytes

	ld hl, unkData_003_5a20
	ld de, wd200
	ld bc, $90
	call CopyBytes

	bankswitch $01
	call ClearBGMap0

	ld hl, wc000
	ld bc, $c00
	call ZeroFill

	ld hl, wca88
	ld a, $82
	ld [hli], a
	ld a, $9b
	ld [hl], a
	call Call_000_13d4

	ld de, $2c9b
	call Call_000_08a1
	ld de, $2ca8
	call Call_000_08a1
	ld de, $2cb5
	call Call_000_08a1
	call Call_000_2c79

; Copy TopScore and Score into 
	ld c, 7
	ld hl, $9a30 ; 16, 17
	ld de, wTopScore
	call PrintNum
	ld c, 7
	ld hl, $9a90 ; 16, 20
	ld de, wScore
	call PrintNum

; Clear first 20 tiles in BGMap1
	ld hl, vBGMap1
	xor a
	ld c, 20
.loop
	ld [hli], a
	dec c
	jr nz, .loop

	ld a, $50
	ldh [rSCY], a
	ld a, $50
	ldh [rSCX], a
	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a

	ld de, unk_000_2c63
	call Func_000_0a3e

	xor a
	ld [wcf98], a
	ld [wcf86], a
	ld hl, unkData_001_5541
	call Call_001_49aa
	ld [wcf9a], a

	ld a, TACF_START + TACF_16KHZ
	ldh [rTAC], a
	ld a, %0101
	ldh [rIE], a
	ld a, %11000111
	ldh [rLCDC], a
	ei
	jp Jump_000_02a2

MusicTable:
	dw unkData_001_6210 ; stage 0
	dw unkData_001_6210 ; stage 1
	dw unkData_001_6210 ; stage 2
	dw unkData_001_6b60 ; stage 3
	dw unkData_001_651d ; stage 4
	dw unkData_001_6fcf ; stage 5
	dw unkData_001_70f8 ; stage 6

	dw unkData_001_5603
	dw unkData_001_5603
	dw unkData_001_5541
	dw unkHeader_001_5eb0

PauseText:
	db "PAUSE", $bf

ScoreText:
	db "SCORE", $bf

INCLUDE "home/joypad.asm"
INCLUDE "home/oam_dma.asm"

DisableLCD:
.wait
	ldh a, [rLY]
	cp 145
	jr c, .wait
	cp 150
	jr nc, .wait

	ldh a, [rLCDC]
	and LOW(~LCDCF_ON) ; could use "res 7, a" or "xor a"
	ldh [rLCDC], a
	ret

ClearBGMap0:
	ld hl, vBGMap0 + $3ff
	ld bc, $400
.zerofill
	ld a, 0
	ld [hld], a
	dec bc
	ld a, b
	or c
	jr nz, .zerofill
	ret

ClearBGMap1:
	ld hl, vBGMap1 + $3ff
	ld bc, $400
	jr ClearBGMap0.zerofill

CopyBytes:
; copy bc bytes from hl to de
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

Func_0897:
	inc de
	ld h, a
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	inc de
	call Call_000_08a7

Call_000_08a1:
	ld a, [de]
	cp 0
	jr nz, Func_0897
	ret

Call_000_08a7:
	push af
	and $3f
	ld b, a
	pop af
	rlca
	rlca
	and 3
	jr z, .asm_08ba
	dec a
	jr z, .asm_08c1
	dec a
	jr z, .asm_08c8
	jr .asm_08d5

.asm_08ba:
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, .asm_08ba
	ret

.asm_08c1:
	ld a, [de]
	inc de
.asm_08c3
	ld [hli], a
	dec b
	jr nz, .asm_08c3
	ret

.asm_08c8:
	ld a, [de]
	ld [hl], a
	inc de
	ld a, b
	ld bc, $20
	add hl, bc
	ld b, a
	dec b
	jr nz, .asm_08c8
	ret

.asm_08d5:
	ld a, [de]
	ld [hl], a
	ld a, b
	ld bc, $20
	add hl, bc
	ld b, a
	dec b
	jr nz, .asm_08d5
	inc de
	ret

Call_000_08e2:
	ld hl, wc780 + 1
	ld a, [hli]
	ld c, [hl]
	ld b, a
	ld a, [de]
	ld h, a
	inc de
	ld a, [de]
	ld d, h
	ld e, a
	add $18
	sub c
	jr c, .asm_0902
	ld a, e
	sub $18
	sub c
	jr nc, .asm_0917
	ld a, d
	sub b
	jr c, .asm_08ff
	xor a
	ret

.asm_08ff
	ld a, $04
	ret

.asm_0902:
	ld a, d
	add $18
	sub b
	jr c, .asm_0911

	ld a, d
	sub $18
	sub b
	jr nc, .asm_0914
	ld a, $02
	ret

.asm_0911
	ld a, $03
	ret

.asm_0914
	ld a, $01
	ret

.asm_0917:
	ld a, d
	add $18
	sub b
	jr c, .asm_0926

	ld a, d
	sub $18
	sub b
	jr nc, .asm_0929

	ld a, $06
	ret

.asm_0926
	ld a, $05
	ret

.asm_0929
	ld a, $07
	ret

Call_000_092c:
	ld hl, $11
	add hl, bc
	ld a, [hl]
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a

Call_000_0939::
	ld hl, $000a
	add hl, bc
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	ret

Call_000_0947::
; Spawn enemy?
	ld a, [wcab5]
	ld hl, unkData_000_0f19
	call Call_000_0f0f

	xor a
	ld [wcaa4], a
	call Call_000_0aa7
	jp c, .asm_097b

	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wca11]
	ld [hl], a
	push hl
	call Call_000_0faa
	pop hl
	ld de, $10
	add hl, de
	ld b, 4
	ld de, wcab6

.asm_0972
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, .asm_0972

	ld a, b
	dec a
	ret

.asm_097b
	xor a
	ret

Call_000_097d:
	ld a, [bc]
	call Call_000_0b4a
	ld a, $04
	call Call_000_0b61
	call Call_000_0ce4
	ld a, [wca16]
	add d
	ld d, a
	call Call_000_0b1e
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $0c
	add hl, de
	ld a, [hli]
	ret

Call_000_099d:
	ld a, [bc]
	call Call_000_0b4a
	call Call_000_09b8
	or a
	ret nz

	ld de, wca60
	ld a, [de]
	or a
	ret nz

	ld bc, $0804
	call Call_000_0a2e
	ld de, unk_000_1083
	jp Func_000_0a3e

Call_000_09b8::
	ld hl, $0007
	add hl, bc
	inc [hl]
	ld a, [hli]
	cp [hl]
	jr z, .asm_09cb
	ret c

	inc hl
	cp [hl]
	ret nz

	dec hl
	dec hl
	xor a
	ld [hl], a
	dec a
	ret

.asm_09cb
	xor a
	ret

Call_000_09cd::
; Regular enemy collision
; Called every frame an enemy is on-screen
	ld a, [bc]
	call Call_000_0b4a
	ld de, 6
	add hl, de
	ld de, wca30
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, wc780 + 8
	call CheckCollision
	ld a, c
	or a
	ret z

	ld a, 1
	ld [wPlayerHP], a
	ret

Call_000_09ec::
; Boss collision
	ld a, [bc]
	call Call_000_0b4a
	ld bc, wc780 + 6
	ld de, wca30
	ld a, [bc]
	ld [de], a
	inc de
	inc bc
	ld a, [bc]
	ld [de], a
	ld de, 8
	add hl, de
	call CheckCollision
	ld a, c
	or a
	ret z

	ld a, 1
	ld [wPlayerHP], a
	ret

Call_000_0a0c::
	ld a, [bc]
	call Call_000_0b4a
	ld de, $0d
	add hl, de
	ld d, [hl]
	ld hl, $0016
	add hl, bc
	ld a, [hl]
	ld [hl], d
	xor d
	or a
	ret z

	ld a, [wcfa0]
	or a
	ret nz

	ld hl, unkData_001_7311
	ld a, $01
	call Call_001_49aa
	ld a, $01
	ret

Call_000_0a2e::
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hli]
	add b
	ld [de], a
	inc de
	ld a, [hl]
	add c
	ld [de], a
	inc de
	ret

Func_000_0a3e::
	ld b, 0
	ld hl, wc700
.empty_slot
	inc b
	ld a, $20 - 1
	cp b
	ret c
; Check if 2 bytes are zero
	ld a, [hli]
	ld c, a
	ld a, [hli]
	or c
	jr nz, .empty_slot
; Store them into slot
	dec hl
	ld a, d
	ld [hld], a
	ld [hl], e
	ret

Jump_000_0a53::
	ld a, [wca10]
	rlca
	ld h, 0
	ld l, a
	ld bc, wc700
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	jp Jump_000_047e

Jump_000_0a64::
	call Call_000_0b10

Jump_000_0a67::
	ld a, [wca10]
	rlca
	ld l, a
	ld h, 0
	ld de, wc700
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a
	call .asm_0a7b
	jp Jump_000_047e

.asm_0a7b:
	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, $20
	jp ZeroFill

ZeroFill:
; fill bc bytes with 0, starting at hl
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

Call_000_0a8f:
	ld [wca11], a
	push de
	push bc
	ld c, a
	swap a
	ld l, a
	ld h, 0
	ld de, wc780
	add hl, de
	ld a, [hli]
	or [hl]
	jp z, Jump_000_0add

	pop bc
	pop de
	scf
	ret

Call_000_0aa7:
	ld hl, wc7c0
	push de
	push bc
	ld c, $04

.asm_0aae:
	ld a, [hli]
	or [hl]
	jr z, jr_000_0ad9

	ld de, $0f
	add hl, de
	inc c
	ld a, $10
	cp c
	jr nz, .asm_0aae

	pop bc
	pop de
	scf
	ret

Call_000_0ac0:
	ld hl, wc880
	push de
	push bc
	ld c, $10
.asm_0ac7:
	ld a, [hli]
	or [hl]
	jr z, jr_000_0ad9
	ld de, $0f
	add hl, de
	inc c
	ld a, $26
	cp c
	jr nz, .asm_0ac7

	pop bc
	pop de
	scf
	ret

jr_000_0ad9:
	ld a, c
	ld [wca11], a

Jump_000_0add:
	dec hl
	pop bc
	ld a, [bc]
	inc bc
	ld [hli], a
	pop de
	ld a, d
	ld [hli], a
	ld a, e
	ld [hli], a
	inc hl
	inc hl
	ld a, [wcaa4]
	ld [hli], a

Jump_000_0aed:
	call .asm_0afa
	call .asm_0afa
	call .asm_0afa
	ld a, [bc]
	ld [hl], a
	xor a
	ret

.asm_0afa:
	ld a, [bc]
	add d
	ld [hli], a
	inc bc
	ld a, [bc]
	add e
	ld [hli], a
	inc bc
	ret

Call_000_0b03::
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
	inc hl
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

Call_000_0b10:
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, $10
	xor a
.clear
	ld [hli], a
	dec b
	jr nz, .clear
	ret

Call_000_0b1e::
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	call .asm_0b31
	inc hl
	inc hl
	inc hl
	call .asm_0b31
	call .asm_0b31

.asm_0b31:
	ld a, d
	add [hl]
	ld [hli], a
	ld a, e
	add [hl]
	ld [hli], a
	ret

Call_000_0b38::
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, d
	ld [hli], a
	ld a, e
	ld [hli], a
	inc hl
	inc hl
	inc hl
	inc bc
	jp Jump_000_0aed

Call_000_0b4a::
; Multiply 'a' by $10
	swap a
	ld l, a
	and $0f
	ld h, a
	ld a, l
	and $f0
	ld l, a
	ld de, wc780
	add hl, de
; Save pointer
	ld de, wca14
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ret

Call_000_0b61:
	bit 7, a
	jr z, .asm_0b72

	ld hl, $0003
	add hl, bc
	cpl
	inc a
	call Call_000_0b99
	cpl
	inc a
	jr .asm_0b79

.asm_0b72:
	ld hl, $0004
	add hl, bc
	call Call_000_0b99

.asm_0b79:
	ld [wca16], a
	ret

Call_000_0b7d:
	bit 7, a
	jr z, .asm_0b8e

	ld hl, $0005
	add hl, bc
	cpl
	inc a
	call Call_000_0b99
	cpl
	inc a
	jr .asm_0b95

.asm_0b8e:
	ld hl, $0006
	add hl, bc
	call Call_000_0b99

.asm_0b95:
	ld [wca17], a
	ret

Call_000_0b99:
	add [hl]
	ld d, a
	and $0f
	ld [hl], a
	swap d
	ld a, d
	and $0f
	ret

CheckCollision:
; c = Collision status (0 = No hit, $ff = hit)
	ld c, 0
	ld a, [wca30]
	cp [hl]
	ret c

	inc hl
	inc hl
	cp [hl]
	ret nc

	dec hl
	ld a, [wca31]
	cp [hl]
	ret c

	inc hl
	inc hl
	cp [hl]
	ret nc

	dec c
	ret

Jump_000_0bbb::
	ld a, d
	call Call_000_0c57
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $05
	add hl, de
	inc [hl]
	ld a, [wcfa0]
	or a
	jr nz, .asm_0bed

	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $12
	add hl, de
	ld a, [hl]
	and $03
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_0c11
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, $01
	call Call_001_49aa

.asm_0bed:
	ld de, $1019
	jp Jump_000_0a53

Call_000_0bf3:
	ld a, d
	call Call_000_0b61
	ld a, e
	call Call_000_0b7d
	ld hl, wca16
	ld a, [hli]
	ld e, [hl]
	ld d, a
	jp Call_000_0b1e

Call_000_0c04:
	ld a, [wcf9a]
	dec a
	ld l, a
	ld h, 0
	ld de, wcc04
	add hl, de
	ld a, [hl]
	ret

unkData_000_0c11:
	dw unkData_001_732d
	dw $73d8
	dw $7400
	dw $744a

unk_000_0c19:
	call Call_000_0c75
	ld hl, wcfa0
	ld a, [hl]
	or a
	jr z, jr_000_0c27

	inc a
	and $3f
	ld [hl], a

jr_000_0c27:
	ld a, [wca2a]
	or a
	jr z, jr_000_0c33

	ld [wca69], a
	jp Jump_000_047e

jr_000_0c33:
	ld hl, wca68
	ld de, wPlayerHP
	ld a, [hl]
	or a
	jr nz, jr_000_0c4b

	dec hl
	ld a, [de]
	or a
	jr z, jr_000_0c46

	ld [hl], a
	jp Jump_000_047e

jr_000_0c46:
	ld a, [hli]
	or a
	jp z, Jump_000_047e

jr_000_0c4b:
	inc [hl]
	ld a, [hli]
	and $7f
	ld [hld], a
	ld [hld], a
	ld [hld], a
	xor a
	ld [de], a
	jp Jump_000_047e

Call_000_0c57::
	ld b, a
	and $0f
	ld hl, wcf8f
	dec hl
.asm_0c5e
	dec hl
	dec a
	jr nz, .asm_0c5e

	swap b
	ld a, b
	and $0f

jr_000_0c67:
	add [hl]
	cp $0a
	jr nc, jr_000_0c6e
	ld [hl], a
	ret

jr_000_0c6e:
	sub $0a
	ld [hld], a
	ld a, $01
	jr jr_000_0c67

Call_000_0c75:
	call Call_000_0c92
	ld hl, wcf8f
	ld a, $0b
	ld [hli], a
	ld [hli], a
	dec a
	ld [hli], a
	ld a, [wLives]
	ld b, a
	swap a
	and $0f
	ld [hli], a
	ld a, b
	and $0f
	ld [hli], a
	ld a, $0b
	ld [hl], a
	ret

Call_000_0c92:
	ld hl, wcf87
	ld de, 3
	add hl, de
	ld a, [hl]
	or a
	jr z, jr_000_0ca7

	cp 5
	jr z, jr_000_0ca7

	ld a, 1
	ld [wcf96], a
	ret

jr_000_0ca7:
	ld a, [wcf96]
	or a
	ret z

	call Call_000_0cbe
	xor a
	ld [wcf96], a
	inc a
	ld hl, unkData_001_5d41
	call Call_001_49aa
	ld [wcfa0], a
	ret

; Life stuff
Call_000_0cbe:
	ld hl, wLives
	ld a, [hl]
	cp $99
	ret z

	inc [hl]
	ld a, [hl]
	and $0f
	cp $0a
	ret c

	ld a, [hl]
	and $f0
	add $10
	ld [hl], a
	ret

Call_000_0cd3:
	ld hl, wLives
	dec [hl]
	ld a, [hl]
	and $0f
	cp $0a
	ret c

	ld a, [hl]
	and $f0
	add 9
	ld [hl], a
	ret

Call_000_0ce4::
	ld hl, $000c
	add hl, bc
	ld a, [hli]
	ld b, [hl]
	ld c, a
	ld a, [bc]
	inc bc
	ld de, $0000
	rlca
	jr nc, jr_000_0cf5
	ld d, $fd

jr_000_0cf5:
	rlca
	jr nc, jr_000_0cfa
	ld d, $03

jr_000_0cfa:
	rlca
	jr nc, jr_000_0cff
	ld e, $fd

jr_000_0cff:
	rlca
	jr nc, jr_000_0d04
	ld e, $03

jr_000_0d04:
	rlca
	jr c, jr_000_0d0b
	ld a, b
	ld [hld], a
	ld [hl], c
	ret

jr_000_0d0b:
	dec hl
	dec hl
	ld a, [hld]
	ld c, [hl]
	ld b, a
	inc bc
	inc bc
	ld a, c
	ld [hli], a
	ld [hl], b
	inc hl
	ld a, [bc]
	ld [hli], a
	inc bc
	ld a, [bc]
	ld [hli], a
	ret

unk_000_0d1c:
	xor a
	ld hl, wcab2
	ld [hli], a
	ld a, $d8
	ld [hl], a
	ld de, unk_000_0d2a
	jp Jump_000_0a53

unk_000_0d2a:
	ld hl, wcab2
	ld a, [hli]
	ld b, [hl]
	ld c, a
	ld hl, wca82
	ld a, [bc]
	cp [hl]
	jp nz, Jump_000_047e

	inc hl
	inc bc
	ld a, [bc]
	cp [hl]
	jp nz, Jump_000_047e

	inc bc
	ld a, [bc]
	or a
	jp z, Jump_000_0a67
	dec a
	jp z, NextStage

	inc a
	push bc
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_0eb7
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Func_000_0a3e

	pop bc
	ld hl, wcab5
	inc bc
	ld e, $02
.asm_0d60:
	ld a, [bc]
	ld d, a
	swap a
	and $0f
	ld [hli], a
	ld a, d
	and $0f
	ld [hli], a
	inc bc
	dec e
	jr nz, .asm_0d60

	ld hl, wcab2
	ld a, c
	ld [hli], a
	ld [hl], b
	ld hl, wcab6
	ld b, [hl]
	ld a, [wca22]
	and b
	ld [hl], a
	jp Jump_000_047e

unk_000_0d81:
	ld a, [wcac1]
	or a
	jp nz, Jump_000_0a67

	ld hl, rSCY
	dec [hl]
	jp Jump_000_047e

unk_000_0d8f:
	ld a, $01
	ld [wca81], a
	jp Jump_000_0a67

unk_000_0d97:
	xor a
	ld [wca81], a
	jp Jump_000_0a67

unk_000_0d9e:
	ld a, $01
	ld [wcac8], a
	jp Jump_000_0a67

unk_000_0da6:
	ld a, $01
	ld [wcaca], a
	jp Jump_000_0a67

unk_000_0dae:
	ld a, $01
	ld [wcac9], a
	xor a
	ld [wcac1], a
	jp Jump_000_0a67

unk_000_0dba:
	ld hl, wBossMusicPlaying
	inc [hl]
	ld hl, unkHeader_001_5f23
	xor a
	call Call_001_49aa
	ld [wcf9a], a
	jp Jump_000_0a67

unk_000_0dcb:
	ld hl, unkHeader_001_5eb0
	xor a
	call Call_001_49aa
	ld [wcf9a], a
	ld a, $01
	ld [wBossMusicPlaying], a
	jp Jump_000_0a67

unk_000_0ddd:
	ld a, [wcf9a]
	call unk_001_4bd1
	jp Jump_000_0a67

NextStage:
	ld a, $01
	ld [wcf9b], a
	ld hl, wCurrentStage
	inc [hl]
	ld hl, wcc40
	ld bc, $200
	call ZeroFill
	jp Jump_000_0a67

Call_000_0dfb:
	bankswitch BANK("bank2")
	ld a, [wCurrentStage]
	add a
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, vTiles2
	jp CopyBytes

Call_000_0e16:
	bankswitch BANK("bank3")
	ld a, [wCurrentStage]
	add a
	add a
	ld l, a
	ld h, 0
	add hl, de
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wd000
	ld bc, $200
	call CopyBytes

	pop hl
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wd200
	ld bc, $550
	call CopyBytes

	ld a, [wCurrentStage]
	ld de, unkData_000_0ea5
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wd800
	ld bc, $400
	call CopyBytes

	bankswitch $01
	ret

unkData_000_0e5d:
; Stage 0
	dw unkData_003_4000
	dw unkData_003_41b0
; Stage 1
	dw unkData_003_4000
	dw unkData_003_42a0
; Stage 2
	dw unkData_003_4000
	dw unkData_003_4390
; Stage 3
	dw unkData_003_4480
	dw unkData_003_4530
; Stage 4
	dw unkData_003_4480
	dw unkData_003_4620
; Stage 5
	dw unkData_003_4b70
	dw unkData_003_4d50
; Stage 6
	dw unkData_003_4b70
	dw unkData_003_52a0
; Stage 7
	dw $5ad0
	dw $5b50
; Stage 8
	dw $57f0
	dw $5820

unkData_000_0e81:
; Length, Address
; Stage 0
	dw $350
	dw unkImage_002_5000
; Stage 1
	dw $350
	dw unkImage_002_5000
; Stage 2
	dw $350
	dw unkImage_002_5000
; Stage 3
	dw $640
	dw unkImage_002_5400
; Stage 4
	dw $640
	dw unkImage_002_5400
; Stage 5
	dw $6b0
	dw unkImage_002_5a40
; Stage 6
	dw $6b0
	dw unkImage_002_5a40
; Stage 7
	dw $510
	dw unkImage_002_6d70
; Stage 8
	dw $1a0
	dw unkImage_002_6590

unkData_000_0ea5:
; Stage 0
	dw unkData_003_6000
; Stage 1
	dw unkData_003_6020
; Stage 2
	dw unkData_003_6420
; Stage 3
	dw unkData_003_6820
; Stage 4
	dw unkData_003_6c20
; Stage 5
	dw unkData_003_7020
; Stage 6
	dw unkData_003_7420
; Stage 7
	dw unkData_003_7820
; Stage 8
	dw unkData_003_7840

unkData_000_0eb7:
	dw Jump_000_0a67
	dw NextStage
	dw unk_000_0d8f
	dw unk_000_0d9e
	dw unk_000_29f2
	dw $19db
	dw $1a47
	dw $1a77
	dw $1b48
	dw $1c1e
	dw $1d34
	dw $1e1a
	dw $4000
	db $c7, $20, $e0, $41
	db $b5, $42, $cf, $43, $e6, $44, $a6, $0d, $ae, $0d, $2e, $20, $97, $0d, $f7, $20
	db $22, $23, $57, $24, $ff, $24, $09, $2d, $67, $0a, $cb, $0d, $dd, $0d, $ba, $0d
	db $c9, $2e, $18, $1b, $78, $1b, $a8, $1b, $a9, $1c, $a6, $1f, $81, $0d, $23, $21
	db $4f, $21, $7f, $21, $b2, $21, $45, $22, $fd, $40

Call_000_0f0f::
	ld e, a
	ld d, 0
	add hl, de
	ld a, [wca29]
	add [hl]
	ld e, a
	ret

unkData_000_0f19:
	db $08, $18, $20, $28, $30, $38, $48, $50, $58, $68, $70
	db $78, $80, $88, $98, $a0, $48, $50, $58, $60, $48, $58

Call_000_0f2f::
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld d, a
	ld a, [wca29]
	add [hl]
	ld e, a
	ret

unkData_000_0f3c:
	db $10, $50, $20, $50, $10, $40, $10, $60, $00, $50, $20, $48, $18, $38, $18, $58
	db $30, $50, $38, $48, $28, $38, $28, $58, $38, $18, $38, $68, $60, $40, $60, $58
	db $58, $30, $58, $68, $50, $18, $50, $80, $48, $08, $48, $90, $30, $08, $30, $90
	db $28, $18, $28, $80, $20, $30, $20, $68, $18, $40, $18, $58, $18, $50, $28, $1c
	db $40, $54, $28, $8c, $1c, $08, $1c, $10, $34, $30, $2c, $40, $2c, $48, $2c, $60
	db $2c, $68, $34, $78, $1c, $98, $1c, $a0, $34, $30, $2c, $40, $2c, $48, $2c, $60
	db $2c, $68, $34, $78, $18, $50, $38, $2c, $38, $7c, $88, $1c, $88, $8c

Call_000_0faa:
	ld de, $08
	add hl, de
	push hl
	ld a, [wcab6]
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_0fd5
	add hl, de
	pop de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, [wca2e]
	or a
	ret z

	ldh a, [rDIV]
	and $3f
	or $0f
	ld [de], a
	dec de
	ldh a, [rDIV]
	and $07
	or $01
	ld [de], a
	ret

unkData_000_0fd5:
	db $e0, $f0
	db $1c, $40, $1c, $38, $18, $38, $18, $30, $16, $30, $16, $2c, $14, $2c
	db $14, $28, $12, $28, $10, $24, $0c, $24, $0a, $20, $08, $1c, $04, $18, $04, $10

unk_000_0ff5::
	ld bc, unkData_000_1072
	ld hl, wca34
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld a, $01
	ld [wcaa4], a
	call Call_000_0aa7
	jp c, Jump_000_0a67

	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wca11]
	ld [hl], a
	ld de, $1019
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld a, $12
	ld [hl], a
	ld de, $1077
	call Call_000_0b03
	ld a, [bc]
	call Call_000_0b4a
	ld a, $08
	call Call_000_0b61
	ld d, a
	ld e, 0
	call Call_000_0b1e
	ld de, $103b
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc bc
	ld a, [bc]
	xor $01
	ld [bc], a
	jr nz, jr_000_105e

	inc bc
	ld a, [bc]
	add a
	ld e, a
	ld d, 0
	ld hl, unkData_000_106a
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Call_000_0b03
	ld a, [bc]
	inc a
	and $03
	ld [bc], a
	jp z, Jump_000_0a64

jr_000_105e:
	ld de, unk_000_1064
	jp Jump_000_0a53

unk_000_1064:
	ld de, $1026
	jp Jump_000_0a53

unkData_000_106a:
	db $77, $10
	db $7b, $10
	db $7f, $10
	db $77, $10

unkData_000_1072:
	db $12, $00, $00, $00, $00

	db $22, $00, $24, $00
	db $26, $00, $28, $00
	db $2a, $00, $2c, $00

unk_000_1083:
	ld bc, unkData_000_1244
	ld hl, wca60
	ld a, [hli]
	ld e, [hl]
	ld d, a
	call Call_000_0ac0
	jp c, Jump_000_1138

	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wca11]
	ld [hl], a
	ld de, $10a2
	jp Jump_000_0a53


	push bc
	ld de, wca60
	call Call_000_08e2
	pop bc
	ld hl, $000e
	add hl, bc
	ld [hl], a
	xor a
	ld hl, wca60
	ld [hli], a
	ld [hli], a
	ld de, $10bb
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $133e
	ld a, [wca2f]
	or a
	jr nz, jr_000_10de

	ld a, [wca2c]
	ld l, a
	ld h, 0
	ld de, $1256
	add hl, de
	ld a, [hl]
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_125e
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a

Jump_000_10de:
jr_000_10de:
	ld hl, $000e
	add hl, bc
	ld a, [hl]
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hli]
	ld e, [hl]
	ld hl, $0008
	add hl, bc
	ld [hli], a
	ld [hl], e
	ld de, $124b
	call Call_000_0b03
	ld a, [wca10]
	or a
	jr z, jr_000_1102

	ld de, $1108
	jp Jump_000_0a53


jr_000_1102:
	ld de, $1128
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $0008
	add hl, bc
	ld a, [hli]
	ld e, [hl]
	call Call_000_0b61
	ld a, e
	call Call_000_0b7d
	ld hl, wca16
	ld a, [hli]
	ld e, [hl]
	ld d, a
	call Call_000_0b1e
	ld de, $1128
	jp Jump_000_0a53


	call Call_000_1841
	or a
	jp nz, Jump_000_0a64

	call Call_000_09cd
	ld de, $1108
	jp Jump_000_0a53

Jump_000_1138:
	ld hl, wca63
	xor a
	ld [hli], a
	ld [hl], a
	jp Jump_000_0a67


	ld bc, $124d
	ld hl, wca60
	ld a, [hli]
	ld e, [hl]
	ld d, a
	call Call_000_0ac0
	jp c, Jump_000_1138

	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wca11]
	ld [hl], a
	xor a
	ld hl, wca60
	ld [hli], a
	ld [hli], a
	ld de, $1166
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1254
	call Call_000_0b03
	ld de, $1176
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld d, $05
	ld e, $00
	call Call_000_0b1e
	ld de, $1187
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hl]
	cp $98
	jp nc, Jump_000_0a64

	ld de, $1198
	jp Jump_000_0a53


	call Call_000_09cd
	ld de, $1176
	jp Jump_000_0a53


	ld hl, wca6a
	inc [hl]
	ld a, [hl]
	and $01
	jp nz, Jump_000_047e

	ld [hl], a
	ld de, $11cd
	call Func_000_0a3e
	ld a, [wca65]
	ld e, a
	ld d, 0
	ld hl, unkData_000_126e
	add hl, de
	ld b, [hl]
	ld hl, wca6b
	inc [hl]
	ld a, [hl]
	cp b
	jp nz, Jump_000_047e

	xor a
	ld [wca6b], a
	jp Jump_000_0a67


	ld bc, unkData_000_1244
	ld hl, wca63
	ld a, [hli]
	ld e, [hl]
	ld d, a
	call Call_000_0ac0
	jp c, Jump_000_1138

	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wca11]
	ld [hl], a
	ld de, $11ec
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $000e
	add hl, bc
	push hl
	ld bc, wca65
	ld a, [bc]
	ld h, 0
	ld l, a
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, $127e
	add hl, de
	inc bc
	ld a, [bc]
	ld e, a
	ld d, 0
	add hl, de
	pop de
	ld a, [hl]
	ld [de], a
	ld a, [bc]
	inc a
	and $0f
	ld [bc], a
	ld de, unk_000_1217
	jp Jump_000_0a53

unk_000_1217:
	ld a, [bc]
	call Call_000_0b4a
	ld a, [wca2c]
	ld l, a
	ld h, 0
	ld de, unkData_000_1256
	add hl, de
	ld a, [hl]
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_125e
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	jp Jump_000_10de


	ld de, $1364
	ld a, [wca2f]
	or a
	jp nz, Jump_000_10de

	ld de, $134e
	jp Jump_000_10de

unkData_000_1244:
	db $11, $08, $04, $06, $02, $0a, $06, $0a, $00, $11, $08, $04, $00, $00, $10, $08
	db $10, $00

unkData_000_1256:
	db $00, $01, $01, $02, $02, $03, $03, $03

unkData_000_125e:
	dw $12de
	dw $12ee
	dw $12fe
	dw $130e
	dw $131e
	dw $131e
	dw $131e
	dw $131e

unkData_000_126e:
	dr $126e, $137a

Call_000_137a:
; Map scroll?
	ld hl, wca80
	inc [hl]
	ld a, [hl]
	cp 6
	ret nz

	xor a
	ld [hl], a
	ld hl, wca82
	inc [hl]
	ld a, [hli]
	or a
	jr nz, .asm_138d
	inc [hl]

.asm_138d:
	ld a, $01
	ld [wca87], a
	ld a, [wca81]
	or a
	ret nz

	ld hl, rSCY
	dec [hl]
	ld de, wca84
	ld a, [de]
	cp $ff
	ret z

	inc de
	inc de
	ld a, [hl]
	and $0f
	jr nz, .asm_13ba

	ld [de], a
	ld hl, wca8a
	ld bc, wca90
	ld a, [hli]
	and $f0
	or $02
	ld [bc], a
	inc bc
	ld a, [hli]
	ld [bc], a
	ret

.asm_13ba:
	ld a, [de]
	or a
	ret nz

	ld a, [wca87]
	or a
	ret z

	call Call_000_141e
	ld hl, wca85
	inc [hl]
	ld a, [hli]
	cp $0e
	ret nz

	inc a
	ld [hld], a
	xor a
	ld [hl], a
	jp Jump_000_1472

Call_000_13d4:
	ld de, wca88
	ld hl, wca8a
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a

	ld hl, wca8e
	xor a
	ld [hli], a
	ld a, $d2
	ld [hl], a
	ld b, $0b

.asm_13e9:
	ld hl, wca8a
	ld de, wca90
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld c, $0e

.asm_13f6:
	push bc
	call Call_000_141e
	call Call_000_1447
	pop bc
	dec c
	jr nz, .asm_13f6

	push bc
	call Call_000_1472
	pop bc
	dec b
	jr nz, .asm_13e9

	ld hl, wca8a
	ld de, wca90
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, $01
	ld [wca87], a
	xor a
	ld [wca85], a
	ret

Call_000_141e:
	ld hl, wca8e
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	ld bc, wca84
	ld a, [de]
	ld [bc], a
	cp $ff
	ret z

	inc de
	ld a, e
	ld [hli], a
	ld [hl], d
	ld a, [bc]
	ld h, 0
	ld l, a
	ld de, wd000
	add hl, hl
	add hl, hl
	add hl, de
	ld d, h
	ld a, l
	ld hl, wca8c
	ld [hli], a
	ld [hl], d
	xor a
	ld [wca87], a
	ret

Call_000_1447:
	ld a, [wca87]
	or a
	ret nz

	ld hl, wca8c
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, wca90
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ld bc, $001e
	add hl, bc
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	ld hl, wca90
	inc [hl]
	inc [hl]
	ld a, $01
	ld [wca87], a
	ret

Call_000_1472:
Jump_000_1472:
	ld hl, wca88
	ld d, h
	ld e, l
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, $ffc0
	add hl, bc
	ld a, l
	ld b, a
	ld [de], a
	ld a, h
	cp $97
	jr nz, .asm_1488
	ld a, $9b

.asm_1488:
	ld hl, wca8b
	inc de
	ld [de], a
	ld [hld], a
	ld [hl], b
	ret

Jump_000_1490:
	ld a, [wca28]
	or a
	ret z

	ld c, a
	ld hl, wc790
	ld b, $27
.asm_149b:
	ld a, [hli]
	or a
	jr z, .asm_14b4

	inc hl
	ld a, [hl]
	add c
	ld [hli], a
	ld de, $04
	add hl, de
	ld a, [hl]
	add c
	ld [hli], a
	inc hl
	ld a, [hl]
	add c
	ld [hli], a
	inc hl
	ld a, [hl]
	add c
	ld [hli], a
	jr .asm_14b8

.asm_14b4:
	ld de, $0b
	add hl, de

.asm_14b8:
	ld de, $04
	add hl, de
	dec b
	jr nz, .asm_149b

	ld a, b
	ld [wca28], a
	ret

Call_000_14c4:
	ld a, [wca7b]
	swap a
	ld l, a
	and $0f
	ld h, a
	ld a, l
	and $f0
	ld l, a
	ld de, wc780
	add hl, de
	xor a
	ld [wca70], a
	ld [wca71], a

Jump_000_14dc:
	push hl
	ld a, [hl]
	or a
	jp z, Jump_000_154c

	ld de, wca72
	ld bc, $0005
	call CopyBytes
	ld hl, wca75
	ld a, [hli]
	or [hl]
	jp z, Jump_000_154c

	ld de, wca77
	ld hl, wca73
	ld bc, 4
	call CopyBytes
	ld a, [wca72]
	ld c, a
	and $0f
	ld b, a
	swap c
	ld a, c
	and $0f
	ld c, a
	ld a, [wca70]
	ld e, a
	ld d, $c0

Jump_000_1512:
	push bc
	ld hl, wca77
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld a, [bc]
	ld [de], a
	inc bc
	inc de
	ld a, [bc]
	ld [de], a
	inc bc
	inc de
	ld a, b
	ld [hld], a
	ld [hl], c
	ld hl, wca78
	ld a, [hl]
	add $08
	ld [hld], a
	pop bc
	dec b
	jp nz, Jump_000_1512

	ld a, [hl]
	add $10
	ld [hli], a
	ld a, [wca74]
	ld [hl], a
	ld a, [wca72]
	and $0f
	ld b, a
	dec c
	jp nz, Jump_000_1512

	ld a, e
	ld [wca70], a

Jump_000_154c:
	ld hl, wca71
	ld a, [hl]
	inc a
	ld [hl], a
	cp $28
	jr z, jr_000_1567

	pop hl
	ld de, $10
	add hl, de
	ld a, h
	cp $ca
	jp nz, Jump_000_14dc

	ld hl, wc780
	jp Jump_000_14dc


jr_000_1567:
	pop hl
	ld a, [wca70]
	ld l, a
	ld h, $c0

jr_000_156e:
	xor a
	ld [hli], a
	ld a, l
	cp $f0
	jr c, jr_000_156e

	ld hl, wca7b
	ld a, [hl]
	inc a
	ld [hl], a
	cp $27
	jr nz, jr_000_1581

	xor a
	ld [hl], a

jr_000_1581:
	ld a, $01
	ld [wca18], a
	ret

Call_000_1587:
	ld a, [hl]
	and $03
	ret z

	ld a, [hli]
	cp $04
	jr c, jr_000_15a4

	ld a, [wca17]
	cpl
	inc a
	add [hl]
	ld b, a
	and $03
	ld [hli], a
	srl b
	srl b
	xor a
	sub b
	ld b, a
	inc hl
	jr jr_000_15b1

jr_000_15a4:
	inc hl
	ld a, [wca17]
	add [hl]
	ld b, a
	and $03
	ld [hli], a
	srl b
	srl b

jr_000_15b1:
	ldh a, [rSCX]
	add b
	ldh [rSCX], a
	xor a
	sub b
	ld [hli], a
	add [hl]
	ld [hl], a
	jp Jump_000_1490

Call_000_15be:
	ld hl, wc780 + 1
; Check if player's y-coord is above minimum
	ld a, [hli]
	cp 21
	jr nc, .check_y_max
	res D_UP_F, b
	jr .check_x_max

.check_y_max
	cp 133
	jr c, .check_x_max
	res D_DOWN_F, b

.check_x_max
; Check if player's x-coord is below maximum
	ld a, [hl]
	cp 148
	jr c, .check_x_min
	res D_RIGHT_F, b
	jr .asm_15df

.check_x_min
	cp 13
	jr nc, .asm_15df
	res D_LEFT_F, b
.asm_15df:
	ld hl, wca23
	ld a, [hl]
	and BUTTONS
	or b
	ld [hl], a
	ret

Jump_000_15e8:
	ld hl, unkData_001_739b
	ld a, $01
	call Call_001_49aa
	xor a
	ld [wca24], a
	ld de, unk_000_15fa
	jp Jump_000_0a53

unk_000_15fa:
	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld b, [hl]
	ld a, $c0
	ld [hli], a
	ld c, [hl]
	ld hl, wca34
	ld [hl], b
	inc hl
	ld [hl], c
	ld de, unk_000_0ff5
	call Func_000_0a3e
	ld de, unk_000_1616
	jp Jump_000_0a53

unk_000_1616:
	ld hl, $000e
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	jp nz, Jump_000_047e

	xor a
	ld [hl], a
	ld a, [bc]
	call Call_000_0b4a
	inc hl
	inc hl
	ld e, [hl]
	ld d, $a0
	ld bc, $1694
	call Call_000_0b38
	ld de, $169b
	call Call_000_0b03

	ld a, [wPowerLevel]
	ld l, a
	ld h, 0
	ld de, unkData_000_168c
	add hl, de
	ld a, [hl]
	ld [wPowerLevel], a
	ld [wca2c], a

	ld a, [wLives]
	or a
	jr z, jr_000_1658

	call Call_000_0cd3
	ld de, unk_000_165e
	jp Jump_000_0a53

jr_000_1658:
	ld de, unk_000_2c49
	jp Jump_000_0a53

unk_000_165e:
	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hl]
	cp $60
	jp c, Jump_000_1672

	ld de, $ff00
	call Call_000_0b1e
	jp Jump_000_047e

Jump_000_1672:
	xor a
	ld [wPlayerHP], a
	ld de, unk_000_16ce
	jp Jump_000_0a53

unkData_000_167c:
	db $ff, $02, $06, $ff
	db $00, $01, $07, $ff
	db $04, $03, $05, $ff
	db $ff, $ff, $ff, $ff

unkData_000_168c:
	db $00, $00, $00

	db $01

	db $01, $03

	inc bc
	inc bc

	db $12, $08, $08, $02, $02, $0e, $0e, $02, $00, $02, $20, $00, $00, $00, $00

unkData_000_16a3:
	db $d0, $00, $de, $22, $00, $30, $22, $22, $30, $00, $22, $de, $00, $d0, $de, $de

unk_000_16b3:
	ld bc, $1694
	ld de, $603a
	xor a
	call Call_000_0a8f
	jp c, Jump_000_0a67

	ld hl, wca12
	ld a, [hli]
	ld d, [hl]
	ld e, a
	xor a
	ld [de], a
	ld de, $293a
	jp Jump_000_0a53

unk_000_16ce:
	ld a, [bc]
	call Call_000_0b4a
	ld a, [wJoypadDown]
	ld [wca23], a
	and D_PAD
	jp z, Jump_000_1717

	push bc
	ld b, a
	call Call_000_15be
	swap a
	and $0f
	ld l, a
	ld h, 0
	ld de, unkData_000_167c
	add hl, de
	ld a, [hl]
	ld [wca25], a
	pop bc
	cp $ff
	jr z, Jump_000_1717

	add a
	ld e, a
	ld d, 0
	ld hl, unkData_000_16a3
	add hl, de
	ld a, [hli]
	push hl
	call Call_000_0b61

	pop hl
	ld a, [hl]
	call Call_000_0b7d

	ld hl, wca25
	call Call_000_1587

	ld hl, wca16
	ld a, [hli]
	ld e, [hl]
	ld d, a
	call Call_000_0b1e

Jump_000_1717:
	ld de, unk_000_171d
	jp Jump_000_0a53

unk_000_171d:
	ld a, [bc]
	call Call_000_0b4a
	ld a, [wcac5]
	or a
	jr nz, .asm_1774

	ld a, [wca69]
	or a
	jr nz, .asm_1734

	ld a, [wPlayerHP]
	or a
	jp nz, Jump_000_15e8

.asm_1734:
	ld bc, wca23
	ld a, [bc]
	and START
	ld [wPaused], a
	ld hl, wca24
	ld a, [bc]
	and $03
	jr z, .asm_174b

	ld a, [hl]
	or a
	jr nz, .asm_174b

	inc a
	ld [hl], a

.asm_174b:
	ld a, [wca69]
	or a
	jr z, .asm_1768

	ld hl, wcfa3
	ld a, [hl]
	xor $01
	ld [hl], a
	jr nz, .asm_1768

	ld a, [wPaused]
	or a
	jr nz, .asm_1768

	ld de, $169f
	call Call_000_0b03
	jr .asm_176e

.asm_1768:
	ld de, $169b
	call Call_000_0b03

.asm_176e:
	ld de, $16ce
	jp Jump_000_0a53

.asm_1774:
	ld de, $169b
	call Call_000_0b03
	ld de, unk_000_1780
	jp Jump_000_0a53

unk_000_1780:
	ld a, [wCurrentStage]
	cp $06
	jr z, .asm_1792

	ld hl, unkData_001_600e
	ld a, $01
	call Call_001_49aa
	ld [wcf9a], a

.asm_1792:
	ld de, $1798
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $0000
	inc hl
	ld a, [hli]
	cp $80
	jr z, jr_000_17ab

	ld d, $08
	jr c, jr_000_17ab

	ld d, $f8

jr_000_17ab:
	ld a, [hl]
	cp $28
	jr z, jr_000_17b6

	ld e, $08
	jr c, jr_000_17b6

	ld e, $f8

jr_000_17b6:
	ld a, d
	or e
	jr z, jr_000_17c0

	call Call_000_0bf3
	jp Jump_000_047e


jr_000_17c0:
	ld a, $01
	ld [wcac7], a
	ld de, $17cb
	jp Jump_000_0a53


	ld a, [wcacb]
	or a
	jp z, Jump_000_047e

	ld a, [bc]
	ld hl, $000f
	add hl, bc
	xor a
	ld [hli], a
	ld [hl], a
	ld [wca69], a
	ld de, $28f0
	jp Jump_000_0a53

unk_000_17e3:
	ld bc, wca24
	ld a, [bc]
	or a
	jp z, Jump_000_047e

	cp $01
	jr z, jr_000_17f6

	inc a
	and $07
	ld [bc], a
	jp Jump_000_047e

jr_000_17f6:
	inc a
	ld [bc], a
	ld a, [wPowerLevel]
	ld de, unk_000_18f9
	jp Jump_000_0a53

unk_000_1801:
	ld bc, unkData_000_18cb
	ld de, $0000
	ld a, [wca54]
	inc a
	ld [wca54], a
	call Call_000_0a8f
	jp c, Jump_000_0a67

	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wca11]
	ld [hl], a
	ld de, unk_000_1930
	jp Jump_000_0a53

Call_000_1824:
	ld a, [wPowerLevel]
	or a
	jr z, .asm_1835

	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld a, 18
	ld [bc], a
	ld bc, unkData_000_18d2
	jr .asm_183e

.asm_1835:
	ld a, [hli]
	ld d, a
	ld a, [hl]
	add 6
	ld e, a
	ld bc, unkData_000_18cb

.asm_183e:
	jp Call_000_0b38

Call_000_1841:
	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hli]
	cp $90
	jr nc, .asm_1854

	ld a, [hl]
	add $20
	cp $d0
	jr nc, .asm_1854

	xor a
	ret

.asm_1854:
	ld a, $ff
	ret

Call_000_1857:
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, 6
	add hl, bc
	ld bc, wca30
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	ld [bc], a
	jr jr_000_1895

Call_000_186b:
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, 6
	add hl, bc
	ld bc, wca30
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	sub 4
	ld [bc], a
	jr jr_000_1895

Call_000_1881:
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, 6
	add hl, bc
	ld bc, wca30
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	add 4
	ld [bc], a

jr_000_1895:
	ld hl, wc7c0
	ld b, 12

Jump_000_189a:
	push hl
	ld a, [hl]
	or a
	jp z, .asm_18c0

	ld de, $05
	add hl, de
	ld a, [hli]
	or a
	jr nz, .asm_18c0

	inc hl
	inc hl
	push hl
	call CheckCollision
	pop hl
	ld a, c
	or a
	jr z, .asm_18c0

	ld de, $05
	add hl, de
	ld a, [wca33]
	add [hl]
	ld [hl], a
	pop hl
	ld a, 1
	ret

.asm_18c0:
	pop hl
	ld de, $10
	add hl, de
	dec b
	jp nz, Jump_000_189a
	ld a, b
	ret

unkData_000_18cb:
	db $11, $08, $04, $00, $01, $10, $07

unkData_000_18d2:
	db $12, $08, $08, $00, $fe, $10, $12

	db $01, $02, $02, $03, $03, $04, $eb, $18, $ed, $18, $ed, $18, $f1, $18, $f1, $18
	db $f5, $18, $0c, $00, $0c, $00, $0c, $20, $0e, $00, $0e, $20, $1c, $00, $1e, $00

unk_000_18f9:
	ld bc, wca51
	ld a, [bc]
	or a
	jr z, .asm_190c

	inc bc
	ld a, [bc]
	or a
	jr z, .asm_190c

	inc bc
	ld a, [bc]
	or a
	jr z, .asm_190c
	jr .asm_1918

.asm_190c
	ld a, [wPowerLevel]
	inc a
	ld [bc], a
	ld a, [wcfa0]
	or a
	call z, Call_000_191e

.asm_1918
	ld de, unk_000_17e3
	jp Jump_000_0a53

Call_000_191e:
	ld hl, unkData_001_72d1
	ld a, [wPowerLevel]
	cp 5
	jr nz, .asm_192b

	ld hl, unkData_001_72ef
.asm_192b:
	ld a, $01
	jp Call_001_49aa

unk_000_1930:
	ld a, [bc]
	ld l, a
	ld h, 0
	ld de, wca50
	add hl, de
	ld a, [hl]
	or a
	jp z, Jump_000_047e

	ld de, $1943
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld b, h
	ld c, l
	ld hl, wc780 + 1
	call Call_000_1824
	ld a, [wPowerLevel]
	add a
	ld l, a
	ld h, 0
	ld de, $18df
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Call_000_0b03
	ld de, $1966
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hli]
	cp $e0
	jr nc, jr_000_1984

	ld a, [hl]
	add $20
	cp $d0
	jr nc, jr_000_1984

	ld d, $f8
	ld e, $00
	call Call_000_0b1e
	ld de, $198a
	jp Jump_000_0a53

jr_000_1984:
	ld de, $19c1
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld a, [wPowerLevel]
	ld l, a
	ld h, 0
	ld de, $18d9
	add hl, de
	ld a, [hl]
	ld [wca33], a
	ld a, [wPowerLevel]
	or a
	jr z, jr_000_19af

	call Call_000_186b
	or a
	jr nz, jr_000_19b5

	call Call_000_1881
	jr z, jr_000_19bb

	jr jr_000_19b5

jr_000_19af:
	call Call_000_1857
	or a
	jr z, jr_000_19bb

jr_000_19b5:
	ld de, $19c1
	jp Jump_000_0a53


jr_000_19bb:
	ld de, $1966
	jp Jump_000_0a53


	ld a, [bc]
	ld l, a
	ld h, 0
	ld de, wca50
	add hl, de
	xor a
	ld [hl], a
	ld a, [bc]
	call Call_000_0b4a
	ld a, $11
	ld [hl], a
	inc hl
	xor a
	ld [hl], a
	ld de, unk_000_1930
	jp Jump_000_0a53


	ld bc, $1a3b
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $19eb
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1a37
	call Call_000_092c
	ld de, $1a43
	jp Jump_000_19fb


Jump_000_19fb:
	call Call_000_0b03
	ld de, $1a0f
	ld a, [wca10]
	and $01
	jp nz, Jump_000_0a53

	ld de, $1a2e
	jp Jump_000_0a53


	call Call_000_1841
	or a
	jp nz, Jump_000_0a64

	call Call_000_097d
	ld d, $22
	cp [hl]
	jp c, Jump_000_0bbb

	ld de, $1a25
	jp Jump_000_0a53


	call Call_000_099d
	ld de, $1a2e
	jp Jump_000_0a53


	call Call_000_09cd
	ld de, $1a0f
	jp Jump_000_0a53


	db $31, $35, $29, $35, $12, $08, $08, $00, $fe, $10, $12, $00, $2e, $00, $2e, $20

	ld bc, $1a6b
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1a57
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1a67
	call Call_000_092c
	ld de, $1a73
	jp Jump_000_19fb


	db $4f, $35, $61, $35, $12, $08, $08, $00, $fe, $10, $12, $00, $30, $00, $30, $20

	ld bc, $1b00
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1a87
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1af4
	call Call_000_092c
	ld de, $1b08
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_1aa4

	ld de, $1acf
	jp Jump_000_0a53


jr_000_1aa4:
	ld de, $1aaa
	jp Jump_000_0a53


	call Call_000_097d
	ld d, $22
	cp [hl]
	jp c, Jump_000_0bbb

	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hl]
	cp $90
	jp nc, Jump_000_0a64

	ld de, $1ac6
	jp Jump_000_0a53


	call Call_000_099d
	ld de, $1acf
	jp Jump_000_0a53


	call Call_000_09cd
	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, 20
	add hl, bc
	inc [hl]
	ld a, [hl]
	and 3
	add a
	ld e, a
	ld d, 0
	ld hl, $1af8
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Call_000_0b03
	ld de, $1aaa
	jp Jump_000_0a53


	db $73, $35, $7f, $35, $08, $1b, $10, $1b, $0c, $1b, $14, $1b, $12, $08, $08, $00
	db $fe, $10, $12, $00, $32, $00, $32, $20, $34, $00, $34, $20, $36, $60, $36, $00
	db $36, $20, $36, $40

	ld bc, $1b3c
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1b28
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1b38
	call Call_000_092c
	ld de, $1b44
	jp Jump_000_19fb


	db $8b, $35

	sub l
	dec [hl]

	db $12, $08, $08, $00, $fe, $10, $12, $01, $42, $00, $42, $20

	ld bc, $1b6c
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1b58
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1b68
	call Call_000_092c
	ld de, $1b74
	jp Jump_000_19fb


	db $9f, $35, $c3, $35, $12, $08, $08, $00, $fe, $10, $12, $01, $38, $00, $38, $20

	ld bc, $1b9c
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1b88
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1b98
	call Call_000_092c
	ld de, $1ba4
	jp Jump_000_19fb


	db $e7, $35, $e9, $35, $12, $08, $08, $00, $fe, $10, $12, $01, $4a, $00, $4a, $20

	ld bc, $1c12
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1bb8
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, wc780 + 2
	ld e, [hl]
	ld d, 0
	ld bc, $1c12
	call Call_000_0b38
	ld de, $1c1a
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_1bdb

	ld de, $1c04
	jp Jump_000_0a53


jr_000_1bdb:
	ld de, $1be1
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hli]
	cp $90
	jp nc, Jump_000_0a64

	ld de, $0a
	add hl, de
	ld d, $53
	ld a, [hli]
	cp [hl]
	jp c, Jump_000_0bbb

	ld d, $06
	ld e, $00
	call Call_000_0b1e
	ld de, $1c04
	jp Jump_000_0a53


	push bc
	call Call_000_099d
	pop bc
	call Call_000_09cd
	ld de, $1be1
	jp Jump_000_0a53


	ld [de], a
	ld [$0008], sp
	cp $10
	ld [de], a
	ld [de], a
	ld b, h
	nop
	ld b, h
	db $20

	ld bc, $1c9d
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1c2e
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $0010
	add hl, bc
	ld a, $20
	ld [hl], a
	ld de, $1ca5
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_1c4c

	ld de, $1c94
	jp Jump_000_0a53


jr_000_1c4c:
	ld de, $1c52
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hl]
	ld hl, $0010
	add hl, bc
	cp $90
	jp nc, Jump_000_0a64

	cp $30
	jr c, jr_000_1c67

	inc [hl]
	inc [hl]

jr_000_1c67:
	ld a, [hl]
	call Call_000_0b61
	ld a, [wca16]
	ld d, a
	ld e, 0
	call Call_000_0b1e
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $0c
	add hl, de
	ld d, $22
	ld a, [hli]
	cp [hl]
	jp c, Jump_000_0bbb

	ld de, $1c8b
	jp Jump_000_0a53


	call Call_000_099d
	ld de, $1c94
	jp Jump_000_0a53


	call Call_000_09cd
	ld de, $1c52
	jp Jump_000_0a53


	db $12, $08, $08, $00, $fe, $14, $12, $00, $3a, $00, $3a, $20

	ld bc, $1d28
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1cb9
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1d24
	call Call_000_092c
	ld de, $1d30
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_1cd6

	ld de, $1d1b
	jp Jump_000_0a53


Jump_000_1cd6:
jr_000_1cd6:
	ld de, $1cdc
	jp Jump_000_0a53


	call Call_000_097d
	ld d, $32
	cp [hl]
	jp c, Jump_000_0bbb

	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hl]
	cp $e0
	jp nc, Jump_000_0a64

	ld de, $1cf8
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	call Call_000_09b8
	or a
	jr nz, jr_000_1d15

	ld de, wca60
	ld a, [de]
	or a
	jr nz, jr_000_1d15

	ld bc, $0806
	call Call_000_0a2e
	ld de, $1141
	call Func_000_0a3e

jr_000_1d15:
	ld de, $1d1b
	jp Jump_000_0a53


	call Call_000_09cd
	ld de, $1cdc
	jp Jump_000_0a53


	db $fd
	dec [hl]
	inc de
	ld [hl], $12
	ld [$0008], sp
	cp $10
	ld [de], a
	ld [bc], a
	ld c, b
	nop
	ld c, b
	db $20

	ld bc, $1e0e
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1d44
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1e16
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_1d5b

	ld de, $1df1
	jp Jump_000_0a53


jr_000_1d5b:
	ld de, $1d61
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $0c
	add hl, de
	ld d, $32
	ld a, [hli]
	cp [hl]
	jp c, Jump_000_0bbb

	ld a, $28
	call Call_000_0b61
	ld a, [wca16]
	ld d, a
	ld e, 0
	call Call_000_0b1e
	ld de, wc780 + 1
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [de]
	sub $04
	cp [hl]
	jr nc, jr_000_1d9f

	inc de
	inc hl
	ld a, [de]
	cp [hl]
	jr c, jr_000_1d95

	xor a

jr_000_1d95:
	ld hl, $000f
	add hl, bc
	inc [hl]
	ld hl, $0011
	add hl, bc
	ld [hl], a

jr_000_1d9f:
	ld de, $1dd3
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $0c
	add hl, de
	ld d, $22
	ld a, [hli]
	cp [hl]
	jp c, Jump_000_0bbb

	ld d, $60
	ld hl, $0011
	add hl, bc
	ld a, [hl]
	or a
	jr z, jr_000_1dc0

	ld d, $a0

jr_000_1dc0:
	ld a, d
	call Call_000_0b7d
	ld a, [wca17]
	ld e, a
	ld d, 0
	call Call_000_0b1e
	ld de, $1dd3
	jp Jump_000_0a53


	call Call_000_099d
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hli]
	cp $a0
	jp nc, Jump_000_0a64

	ld a, [hl]
	add $20
	cp $d0
	jp nc, Jump_000_0a64

	ld de, $1df1
	jp Jump_000_0a53


	call Call_000_09cd
	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $0f
	add hl, de
	ld a, [hl]
	or a
	jr z, jr_000_1e08

	ld de, $1da5
	jp Jump_000_0a53


jr_000_1e08:
	ld de, $1d61
	jp Jump_000_0a53


	db $12, $08, $08, $00, $fe, $10, $12, $00, $3c, $00, $3c, $20

	ld bc, $1f8e
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1e2a
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $1f96
	call Call_000_0b03
	ld de, $1e3a
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld d, $02
	ld e, $00
	call Call_000_0b1e
	ld de, $1e4b
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hli]
	cp $a0
	jp nc, Jump_000_0a64

	ld de, $0b
	add hl, de
	ld a, [hl]
	or a
	jr nz, jr_000_1e64

	ld de, $1e6a
	jp Jump_000_0a53

jr_000_1e64:
	ld de, $1e73
	jp Jump_000_0a53


	call Call_000_09cd
	ld de, $1e3a
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld de, wca34
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld de, $03
	add hl, de
	inc [hl]
	ld de, unk_000_0ff5
	call Func_000_0a3e

	ld a, $22
	call Call_000_0c57

	ld hl, unkData_001_732d
	ld a, $01
	call Call_001_49aa

	ld de, $1f9a
	call Call_000_0b03

	ld de, unk_000_1ea4
	jp Jump_000_0a53

unk_000_1ea4:
	ld a, [bc]
	call Call_000_0b4a
	ld hl, $000e
	add hl, bc
	xor a
	ld [hli], a
	ld [hl], a
	ld de, $1f9a
	call Call_000_0b03
	ld de, unk_000_1ebb
	jp Jump_000_0a53

unk_000_1ebb:
	ld a, [bc]
	call Call_000_0b4a
	ld hl, wc780 + 6
	ld de, wca30
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, 8
	add hl, de
	call CheckCollision
	ld a, c
	or a
	jr nz, .asm_1ee1

	ld de, $1ee7
	jp Jump_000_0a53

.asm_1ee1:
	ld de, unk_000_1f43
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hl]
	cp $a0
	jp nc, Jump_000_0a64

	ld hl, $000e
	add hl, bc
	ld a, [hli]
	or a
	jr nz, .asm_1f08

	inc [hl]
	ld a, [hl]
	and $03
	jr nz, .asm_1f08

	dec hl
	inc [hl]
	ld de, $1f9e
	call Call_000_0b03

.asm_1f08:
	ld de, $1f0e
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld a, $08
	call Call_000_0b61
	ld a, [wca16]
	ld d, a
	ld e, 0
	call Call_000_0b1e
	ld hl, $001e
	add hl, bc
	ld a, [hl]
	inc a
	and $0f
	ld [hl], a
	jr z, .asm_1f37

	cp $08
	jr nz, .asm_1f3d

	ld de, $1fa2
	call Call_000_0b03
	jr .asm_1f3d

.asm_1f37
	ld de, $1f9e
	call Call_000_0b03

.asm_1f3d
	ld de, $1ebb
	jp Jump_000_0a53

unk_000_1f43:
	ld a, $22
	call Call_000_0c57
	ld hl, $5e5b
	ld a, $01
	call Call_001_49aa
	ld [wcfa0], a
	ld hl, wca12
	ld a, [hli]
	ld b, [hl]
	ld c, a
	ld a, [bc]
	call Call_000_0b4a
	ld hl, $0013
	add hl, bc
	ld bc, wPowerLevel
	ld a, [bc]
	cp $05
	jr z, jr_000_1f71

	inc a
	ld [bc], a
	ld [wca2c], a
	jp Jump_000_0a64


jr_000_1f71:
	ld a, $82
	call Call_000_0c57
	jp Jump_000_0a64


	ld a, [bc]
	call Call_000_0b4a
	ld a, $06
	call Call_000_0b61
	ld a, [wca16]
	ld d, a
	ld e, 0
	call Call_000_0b1e
	jp Jump_000_047e


	db $12, $08, $08, $00, $fe, $10, $12, $00, $3e, $00, $3e, $20, $00, $00, $00, $00
	db $04, $00, $06, $00, $16, $00, $18, $00

	ld bc, $2022
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $1fb6
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $201e
	call Call_000_092c
	ld de, $202a
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_1fd3

	ld de, $2015
	jp Jump_000_0a53


jr_000_1fd3:
	ld de, $1fd9
	jp Jump_000_0a53


	call Call_000_097d
	ld d, $52
	cp [hl]
	jp c, Jump_000_0bbb

	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hl]
	cp $e0
	jp nc, Jump_000_0a64

	ld de, $1ff5
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	call Call_000_09b8
	or a
	jr nz, jr_000_200f

	ld de, wca60
	ld a, [de]
	or a
	jr nz, jr_000_200f

	ld bc, $0800
	call Call_000_0a2e
	call $2288

jr_000_200f:
	ld de, $2015
	jp Jump_000_0a53


	call Call_000_09cd
	ld de, $1fd9
	jp Jump_000_0a53


	add hl, hl
	ld [hl], $3f
	ld [hl], $12
	ld [$0008], sp
	cp $10
	ld [de], a
	ld bc, $0046
	ld b, [hl]
	db $20

	ld bc, $20bb
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $203e
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $20c3
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_2055

	ld de, $209f
	jp Jump_000_0a53


jr_000_2055:
	ld de, $205b
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld a, [wca81]
	or a
	jr nz, jr_000_206f

	ld a, $08
	call Call_000_0b61
	ld a, [wca16]
	jr jr_000_2070

jr_000_206f:
	xor a

jr_000_2070:
	ld d, a
	ld e, 0
	call Call_000_0b1e
	ld de, $207c
	jp Jump_000_0a53

unk_000_207c:
	ld a, [bc]
	call Call_000_0b4a
	call Call_000_09b8
	or a
	jr nz, jr_000_2099

	ld de, wca60
	ld a, [de]
	or a
	jr nz, jr_000_2099

	ld bc, $0804
	call Call_000_0a2e
	ld de, unk_000_1083
	call Func_000_0a3e

jr_000_2099:
	ld de, $209f
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hli]
	cp $90
	jp nc, Jump_000_0a64

	ld de, $0a
	add hl, de
	ld d, $13
	ld a, [hli]
	cp [hl]
	jp c, Jump_000_0bbb

	ld de, $205b
	jp Jump_000_0a53


	db $12, $08, $08, $00, $fe, $10, $12, $18, $50, $00, $50, $20

	ld bc, $20eb
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $20d7
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $20e7
	call Call_000_092c
	ld de, $20f3
	jp Jump_000_19fb


	ld d, l
	ld [hl], $69
	ld [hl], $12
	ld [$0008], sp
	cp $10
	ld [de], a
	ld bc, $0052
	ld d, d
	db $20

	ld bc, $2117
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $2107
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $367d
	call Call_000_0939
	ld de, $211f
	jp Jump_000_19fb


	db $12, $08, $08, $00, $fe, $10, $12, $01, $54, $00, $54, $20

	ld bc, $2143
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $2133
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $3687
	call Call_000_0939
	ld de, $214b
	jp Jump_000_19fb


	ld [de], a
	ld [$0008], sp
	cp $10
	ld [de], a
	ld bc, $0040
	ld b, b
	jr nz, jr_000_2151

	ld [hl], e

jr_000_2151:
	ld hl, $47cd
	add hl, bc
	or a
	jp z, Jump_000_0a67

	ld de, $215f
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $216f
	call Call_000_092c
	ld de, $217b
	jp Jump_000_19fb


	and l
	ld [hl], $bd
	ld [hl], $12
	ld [$0008], sp
	cp $10
	ld [de], a
	ld bc, $004c
	ld c, h
	db $20

	ld bc, $21a2
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $218f
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $36d5
	call Call_000_0939
	ld de, $21aa
	call Call_000_0b03
	jp Jump_000_1cd6


	db $22, $10, $08, $00, $fe, $20, $12, $04, $4e, $00, $4e, $20, $62, $00, $62, $20

	ld bc, $2239
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $21c2
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $2235
	call Call_000_092c
	ld de, $2241
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_21df

	ld de, $222c
	jp Jump_000_0a53


jr_000_21df:
	ld de, $21e5
	jp Jump_000_0a53


	call Call_000_097d
	ld d, $32
	cp [hl]
	jp c, Jump_000_0bbb

	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hl]
	cp $90
	jp nc, Jump_000_0a64

	ld de, $2201
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	call Call_000_09b8
	or a
	jr nz, jr_000_2226

	ld a, [wca6b]
	or a
	jr nz, jr_000_2226

	ld de, wca63
	ld bc, $0804
	call Call_000_0a2e
	ld a, $03
	ld [de], a
	inc de
	xor a
	ld [de], a
	ld de, $11a1
	call Func_000_0a3e

jr_000_2226:
	ld de, $222c
	jp Jump_000_0a53


	call Call_000_09cd
	ld de, $21e5
	jp Jump_000_0a53


	db $ed, $36, $fd, $36, $12, $08, $08, $00, $fe, $10, $12, $02, $56, $00, $56, $20

	ld bc, $227c
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $2255
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $2278
	call Call_000_092c
	ld de, $2284
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_2272

	ld de, $1d1b
	jp Jump_000_0a53


jr_000_2272:
	ld de, $1cdc
	jp Jump_000_0a53


	dec c
	scf
	dec h
	scf
	ld [de], a
	ld [$0008], sp
	cp $10
	ld [de], a
	ld [bc], a
	ld e, b
	nop
	ld e, b
	jr nz, @+$13

	adc a
	ld [hli], a
	call Func_000_0a3e
	ret


	ld bc, $2316
	ld hl, wca60
	ld a, [hli]
	ld e, [hl]
	ld d, a
	xor a
	ld [wcaa4], a
	call Call_000_0aa7
	jp c, Jump_000_0a67

	ld hl, wca12
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld a, [wca11]
	ld [de], a
	xor a
	ld hl, wca60
	ld [hli], a
	ld [hli], a
	ld de, $22b8
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $231e
	call Call_000_0b03
	ld a, [wca10]
	and $01
	jr z, jr_000_22cf

	ld de, $230d
	jp Jump_000_0a53


jr_000_22cf:
	ld de, $22d5

jr_000_22d2:
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	push hl
	ld d, 8
	ld e, 0
	call Call_000_0b1e
	pop hl
	ld de, $0c
	add hl, de
	ld d, $52
	ld a, [hli]
	cp [hl]
	jp c, Jump_000_0bbb

	ld de, $22f3
	jp Jump_000_0a53


	call Call_000_1841
	or a
	jp nz, Jump_000_0a64

	ld de, $2300
	jp Jump_000_0a53


	call Call_000_099d
	or a
	jp z, Jump_000_0a64

	ld de, $230d
	jp Jump_000_0a53


	call Call_000_09cd
	ld de, $22d5
	jp Jump_000_0a53


	ld [de], a
	ld [$0008], sp
	nop
	db $10
	db $10
	ld [bc], a
	ld [de], a
	nop
	ld [de], a
	jr nz, jr_000_22d2

	ld hl, wcac0
	ld b, $10
.asm_2328:
	ld [hli], a
	dec b
	jr nz, .asm_2328

	ld de, $2352
	call Func_000_0a3e
	ld b, $02

jr_000_2334:
	push bc
	ld de, $235e
	call Func_000_0a3e
	pop bc
	dec b
	jr nz, jr_000_2334

	ld b, $02

jr_000_2341:
	push bc
	ld de, $236a
	call Func_000_0a3e
	pop bc
	dec b
	jr nz, jr_000_2341

	ld de, $2700
	jp Jump_000_0a53


	ld bc, $2431
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	jr jr_000_2374

	ld bc, $2439
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	jr jr_000_2374

	ld bc, $2441
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

jr_000_2374:
	call $4690
	ld de, $237d
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $0011
	add hl, bc
	ld a, [hl]
	push af
	ld hl, $0f4e
	call Call_000_0f2f
	pop af
	ld bc, $2431
	or a
	jr z, jr_000_239e

	ld bc, $2439
	cp $03
	jr c, jr_000_239e

	ld bc, $2441

jr_000_239e:
	call Call_000_0b38
	ld de, $23a7
	jp Jump_000_0a53


	ld a, [wcaca]
	or a
	jp z, Jump_000_047e

	ld a, [bc]
	call Call_000_0b4a
	ld de, $0d
	add hl, de
	xor a
	ld [hl], a
	ld hl, $0011
	add hl, bc
	ld a, [hl]
	or a
	jr nz, jr_000_23c6

	ld de, $23cc
	jp Jump_000_0a53

jr_000_23c6:
	ld de, unk_001_46ad
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $0c
	add hl, de
	ld a, [hli]
	cp [hl]
	jr c, jr_000_23e4

	ld de, $0000
	call Call_000_0b1e
	ld de, $23fd
	jp Jump_000_0a53

Jump_000_23e4:
jr_000_23e4:
	ld a, $01
	ld [wcac1], a
	ld [wca69], a
	ld de, $46d7
	call Func_000_0a3e
	ld a, $14
	call Call_000_0c57
	ld de, unk_000_2415
	jp Jump_000_0a53


	call Call_000_09ec
	ld de, $2406
	jp Jump_000_0a53


	call Call_000_0a0c
	or a
	jr z, .asm_240f

	ld [wShakeCounter], a

.asm_240f:
	ld de, $23cc
	jp Jump_000_0a53

unk_000_2415:
	ld hl, $18
	add hl, bc
	ld a, [hl]
	inc [hl]
	and $07
	jp nz, Jump_000_047e

	call unk_001_46a2
	cp $07
	jp z, Jump_001_46ea

	ld hl, $2449
	call Call_001_465d
	jp Jump_000_047e


	ld [de], a
	ld [$fe08], sp
	cp $12
	inc d
	ld h, b

jr_000_2439:
	ld [hld], a
	jr @+$0a

	nop
	nop
	jr nc, jr_000_2450

	ldh a, [rNR14]
	ld [$0010], sp
	nop
	db $10
	jr nz, jr_000_2439

	nop
	nop
	db $10
	db $10
	db $10
	ldh a, [$f0]

jr_000_2450:
	db $10
	ldh a, [$f0]
	nop
	jr nz, jr_000_2456

jr_000_2456:
	ldh [$af], a
	ld hl, wcac0
	ld b, $10

jr_000_245d:
	ld [hli], a
	dec b
	jr nz, jr_000_245d

	ld de, $2473
	call Func_000_0a3e
	ld de, $2700
	call Func_000_0a3e
	ld de, $27ad
	jp Jump_000_0a53


	ld bc, unk_000_24f7
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	call $4690
	ld de, $2486
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	xor a
	ld hl, $0f78
	call Call_000_0f2f
	ld bc, unk_000_24f7
	call Call_000_0b38
	ld de, $249d
	jp Jump_000_0a53


	ld a, [wcaca]
	or a
	jp z, Jump_000_047e

	ld a, [bc]
	call Call_000_0b4a
	ld de, $0d
	add hl, de
	xor a
	ld [hl], a
	ld de, $24b4
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $0c
	add hl, de
	ld a, [hli]
	cp [hl]
	jp c, Jump_000_23e4

	ld de, $0000
	call Call_000_0b1e
	ld a, $05
	ld [wca2c], a
	ld de, $24d2
	jp Jump_000_0a53


	call Call_000_09ec
	ld de, $24db
	jp Jump_000_0a53


	call Call_000_0a0c
	or a
	jr z, jr_000_24e4

	ld [wShakeCounter], a

jr_000_24e4:
	ld hl, wc780 + 1
	ld a, [hl]
	cp $34
	jr nc, jr_000_24f1

	ld a, 1
	ld [wPlayerHP], a

jr_000_24f1:
	ld de, $24b4
	jp Jump_000_0a53

unk_000_24f7:
	ld [de], a
	ld [$0008], sp
	nop
	db $10
	db $10
	ld [hl], b

unk_000_24ff:
	xor a
	ld hl, wcac0
	ld b, $10
.asm_2505
	ld [hli], a
	dec b
	jr nz, .asm_2505

	ld [wcf99], a
	ld de, unk_000_251b
	call Func_000_0a3e
	ld de, $281c
	call Func_000_0a3e
	jp Jump_000_0a67

unk_000_251b:
	ld bc, unkData_000_25c9
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	call $4690
	ld de, unk_000_252e
	jp Jump_000_0a53

unk_000_252e:
	ld a, [bc]
	call Call_000_0b4a
	xor a
	ld hl, $0fa0
	call Call_000_0f2f
	ld bc, unkData_000_25c9
	call Call_000_0b38
	ld de, $2545
	jp Jump_000_0a53


	ld a, [wcaca]
	or a
	jp z, Jump_000_047e

	ld a, [bc]
	call Call_000_0b4a
	ld de, $0d
	add hl, de
	xor a
	ld [hl], a
	ld de, $255c
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $0c
	add hl, de
	ld a, [hli]
	cp [hl]
	jr c, jr_000_2574

	ld de, $0000
	call Call_000_0b1e
	ld de, $2590
	jp Jump_000_0a53

jr_000_2574:
	ld a, $01
	ld [wcac1], a
	ld [wca69], a
	ld de, $46d7
	call Func_000_0a3e
	ld a, $24
	call Call_000_0c57
	call Call_000_0cbe
	ld de, $2415
	jp Jump_000_0a53


	push bc
	call Call_000_09ec
	pop bc
	call Call_000_0a0c
	or a
	jr z, jr_000_259e

	ld [wShakeCounter], a

jr_000_259e:
	ld de, $25a4
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	call Call_000_09b8
	or a
	jr nz, jr_000_25c3

	ld de, wca63
	ld bc, $0804
	call Call_000_0a2e
	ld a, $06
	ld [de], a
	inc de
	xor a
	ld [de], a
	ld de, $11a1
	call Func_000_0a3e

jr_000_25c3:
	ld de, $255c
	jp Jump_000_0a53

unkData_000_25c9:
	ld [de], a
	ld [$0008], sp
	nop
	db $10
	db $10
	add b
	inc hl
	db $10
	inc c
	nop
	nop
	jr nz, $25f0

	db $e0

unk_000_25d9::
	ld a, [wcac1]
	or a
	jp nz, Jump_000_0a67

	ld a, [bc]
	ld hl, $0004
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $0f
	jp nz, Jump_000_047e

	ld [hl], a
	ld de, $25f3
	jp Jump_000_0a53


	ld a, [wcf99]
	call Call_000_0b4a
	inc hl
	inc hl
	ld a, [hl]
	add $10
	ld b, a
	ld de, wc780 + 2
	ld a, [de]
	add $10
	cp b
	jr c, jr_000_262a

	ld a, [de]
	sub $10
	cp b
	jr nc, jr_000_262a

	ld c, $18
	ld a, [de]
	add $04
	cp b
	jr nc, jr_000_2618

	ld c, $00

jr_000_2618:
	ld b, $10
	ld de, wca60
	ld a, [de]
	or a
	jr nz, jr_000_262a

	call Call_000_0a2e
	ld de, $1141
	call Func_000_0a3e

jr_000_262a:
	ld de, unk_000_25d9
	jp Jump_000_0a53


	ld a, [wcac1]
	or a
	jp nz, Jump_000_0a67

	ld hl, $0002
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $0f
	ld [hl], a
	jp nz, Jump_000_047e

	ld de, $264c
	call Func_000_0a3e
	jp Jump_000_047e


	ld bc, $26f4
	xor a
	ld d, a
	ld e, a
	ld [wcaa4], a
	call Call_000_0aa7
	jp c, Jump_000_0a67

	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wca11]
	ld [hl], a
	ld de, $266b
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $0004
	add hl, bc
	ld a, [wcace]
	ld [hl], a
	inc a
	and $03
	ld [wcace], a
	ld a, [hli]
	ld b, h
	ld c, l
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_26ec
	add hl, de
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	ld [bc], a
	ld hl, wca63
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld bc, $26f4
	call Call_000_0b38
	ld de, $26fc
	call Call_000_0b03
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $0d
	add hl, de
	xor a
	ld [hl], a
	ld de, $26b1
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $0005
	add hl, bc
	ld a, [hli]
	ld e, [hl]
	ld d, a
	call Call_000_0b1e
	ld de, $26c5
	jp Jump_000_0a53


	call Call_000_1841
	or a
	jp nz, Jump_000_0a64

	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $0c
	add hl, de
	ld d, $12
	ld a, [hli]
	cp [hl]
	jp c, Jump_000_0bbb

	ld de, $26e3
	jp Jump_000_0a53


	call Call_000_09cd
	ld de, $26b1
	jp Jump_000_0a53

unkData_000_26ec:
	db $fc, $fc, $04, $fc, $04, $04, $fc, $04, $12, $08, $08, $00, $00, $10, $10, $01
	db $7a, $00, $7a, $20

unk_000_2700:
	ld a, [wcaca]
	or a
	jp z, Jump_000_047e

	ld hl, $0016
	add hl, bc
	xor a
	ld [hl], a
	ld de, $2713
	jp Jump_000_0a53


	ld hl, $0016
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $07
	jr z, jr_000_2723

	ld de, $275c
	jp Jump_000_0a53


jr_000_2723:
	xor a
	ld b, a
	ld a, [wCurrentStage]
	cp $05
	jr z, jr_000_272e

	ld b, $03

jr_000_272e:
	ld a, b
	ld [hl], a
	ld de, $2736
	jp Jump_000_0a53


	ld de, wca60
	ld a, [de]
	or a
	jr nz, jr_000_2756

	ld de, $278d
	ld bc, $0f58
	ld a, [wCurrentStage]
	cp $05
	jr nz, jr_000_274d

	ld bc, $0f80

jr_000_274d:
	call Call_000_2769
	ld de, unk_000_1083
	call Func_000_0a3e

jr_000_2756:
	ld de, $275c
	jp Jump_000_0a53


	ld a, [wcac1]
	or a
	jp nz, Jump_000_0a67

	ld de, $2713
	jp Jump_000_0a53


Call_000_2769:
	ld hl, wcf99
	ld a, [hl]
	and $1f
	inc [hl]
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	and $0f
	ld h, b
	ld l, c
	call Call_000_0f2f
	ld hl, wca60
	ld a, d
	ld [hli], a
	ld [hl], e
	inc hl
	ld a, [wcacc]
	ld [hl], a
	xor $01
	ld [wcacc], a
	ret


	dec b
	ld b, $03
	inc c
	ld a, [bc]
	ld [bc], a
	rrca
	rlca
	inc c
	inc b
	nop
	ld [bc], a
	ld [$0e0d], sp
	ld [bc], a
	inc bc
	ld [bc], a
	dec b
	ld bc, $0c09
	ld a, [bc]
	inc b
	dec bc
	rrca
	ld bc, $0009
	dec bc
	ld b, $0f
	ld a, [wcaca]
	or a
	jp z, Jump_000_047e

	ld hl, $0016
	add hl, bc
	xor a
	ld [hl], a
	ld [wcfa4], a
	ld de, $27c3
	jp Jump_000_0a53


	ld hl, $0016
	add hl, bc
	inc [hl]
	ld a, [hl]
	cp $0d
	jr z, jr_000_27d3

	ld de, $280b
	jp Jump_000_0a53


jr_000_27d3:
	xor a
	ld [hl], a
	ld de, $27db
	jp Jump_000_0a53


	ld de, wca60
	ld a, [de]
	or a
	jr nz, jr_000_2805

	ld hl, wcfa4
	ld a, [hl]
	and $03
	inc [hl]
	ld de, $2818
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	and $03
	ld hl, $0f7a
	call Call_000_0f2f
	ld hl, wca60
	ld a, d
	ld [hli], a
	ld [hl], e
	ld de, $1141
	call Func_000_0a3e

jr_000_2805:
	ld de, $280b
	jp Jump_000_0a53


	ld a, [wcac1]
	or a
	jp nz, Jump_000_0a67

	ld de, $27c3
	jp Jump_000_0a53


	ld bc, $0102
	nop
	ld a, [wcaca]
	or a
	jp z, Jump_000_047e

	ld hl, $0016
	add hl, bc
	xor a
	ld [hl], a
	ld [wcf99], a
	ld de, $2832
	jp Jump_000_0a53


	ld hl, $0016
	add hl, bc
	ld a, [hl]
	inc a
	and $0f
	ld [hl], a
	jr z, jr_000_2843

	ld de, $2865
	jp Jump_000_0a53


jr_000_2843:
	ld de, $2849
	jp Jump_000_0a53


	ld de, wca60
	ld a, [de]
	or a
	jr nz, jr_000_285f

	ld de, $2872
	ld bc, $0fa2
	call Call_000_2769
	ld de, unk_000_1083
	call Func_000_0a3e

jr_000_285f:
	ld de, $2865
	jp Jump_000_0a53


	ld a, [wcac1]
	or a
	jp nz, Jump_000_0a67

	ld de, $2832
	jp Jump_000_0a53


	inc bc
	ld bc, $0002
	ld bc, $0302
	nop
	inc bc
	ld [bc], a
	nop
	ld bc, $0301
	ld [bc], a
	nop
	ld [bc], a
	nop
	nop
	ld [bc], a
	inc bc
	ld bc, $0103
	ld bc, $0302
	ld [bc], a
	ld bc, $0300
	nop
	ld a, [wcac8]
	or a
	jp z, Jump_000_047e

	ld a, [bc]
	call Call_000_0b4a
	ld de, $169b
	call Call_000_0b03
	ld de, $28a9
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $f800
	call Call_000_0bf3
	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $0e
	add hl, de
	inc [hl]
	ld a, [hl]
	cp $60
	jp c, Jump_000_047e

	xor a
	ld [hl], a
	ld de, $28cc
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $08f8
	call Call_000_0bf3
	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $0e
	add hl, de
	inc [hl]
	ld a, [hli]
	cp $40
	jp c, Jump_000_047e

	xor a
	ld [hli], a
	ld [hli], a
	ld de, $28f0
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $000f
	add hl, bc
	ld a, [hl]
	xor $01
	ld [hli], a
	jr nz, jr_000_28ff

	dec [hl]

jr_000_28ff:
	ld a, [hl]
	call Call_000_0b61
	ld hl, wca16
	ld d, [hl]
	ld e, $00
	call Call_000_0b1e
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hl]
	cp $a0
	jp c, Jump_000_047e

	ld a, $01
	ld hl, wcac6
	ld [hli], a
	ld [hl], a
	ld a, [wCurrentStage]
	cp $06
	jr z, jr_000_292d

jr_000_2927:
	ld de, unk_000_293a
	jp Jump_000_0a53

jr_000_292d:
	ld a, [wca22]
	cp $0f
	jr nz, jr_000_2927

	ld de, $2983
	jp Jump_000_0a53

unk_000_293a:
	ld a, [wcac9]
	or a
	jp z, Jump_000_047e

	ld de, $2947
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $0f
	add hl, de
	xor a
	ld [hl], a
	ld bc, $1694
	ld de, $a050
	call Call_000_0b38
	ld de, $169b
	call Call_000_0b03
	ld de, $2966
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $ff00
	call Call_000_0b1e
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hl]
	cp $60
	jp nz, Jump_000_047e

	ld de, $16ce
	jp Jump_000_0a53


	ld a, [wca2d]
	or a
	jp z, Jump_000_047e

	ld de, $2990
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld de, $0f
	add hl, de
	xor a
	ld [hl], a
	ld bc, $1694
	ld de, $3c98
	call Call_000_0b38
	ld de, $2af0
	call Call_000_0b03
	ld de, $29af
	jp Jump_000_0a53


	ld a, [wcac9]
	or a
	jp z, Jump_000_047e

	ld de, $29bc
	jp Jump_000_0a53


	ldh a, [rSCX]
	cp $11
	jp nc, Jump_000_047e

	ld de, $29c9
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld a, $f8
	call Call_000_0b7d
	ld a, [wca17]
	ld e, a
	ld d, 0
	call Call_000_0b1e
	ld hl, wca14
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
	ld a, [hl]
	cp $38
	jp nc, Jump_000_047e

	ld de, $3207
	call Func_000_0a3e
	jp Jump_000_0a64

unk_000_29f2:
	ld bc, unkData_000_2a34
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $2a02
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld bc, unkData_000_2a34
	ld de, unk_000_3040
	call Call_000_0b38
	ld a, [wCurrentStage]
	dec a
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_2a3c
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Call_000_0b03
	ld de, unk_000_2a27
	jp Jump_000_0a53

unk_000_2a27:
	ld a, [wcac9]
	or a
	jp z, Jump_000_047e

	ld [wcac9], a
	jp Jump_000_0a64

unkData_000_2a34:
	db $27, $08, $08, $00, $00, $10, $10, $01

unkData_000_2a3c:
	dw unkData_000_2a48
	dw unkData_000_2a64
	dw unkData_000_2a80
	dw unkData_000_2a9c
	dw unkData_000_2ab8
	dw unkData_000_2ad4

unkData_000_2a48:
	db $d8, $00, $da, $00, $b4, $00, $c0, $00
	db $bc, $00, $00, $00, $a2, $00, $00, $00
	db $d6, $00, $bc, $00, $b4, $00, $ba, $00
	db $e4, $00, $00, $00

unkData_000_2a64:
	db $d8, $00, $da, $00, $b4, $00, $c0, $00
	db $bc, $00, $00, $00, $a4, $00, $00, $00
	db $d6, $00, $bc, $00, $b4, $00, $ba, $00
	db $e4, $00, $00, $00

unkData_000_2a80:
	db $d8, $00, $da, $00, $b4, $00, $c0, $00
	db $bc, $00, $00, $00, $a6, $00, $00, $00
	db $d6, $00, $bc, $00, $b4, $00, $ba, $00
	db $e4, $00, $00, $00

unkData_000_2a9c:
	db $d8, $00, $da, $00, $b4, $00, $c0, $00
	db $bc, $00, $00, $00, $a8, $00, $00, $00
	db $d6, $00, $bc, $00, $b4, $00, $ba, $00
	db $e4, $00, $00, $00

unkData_000_2ab8:
	dr $2ab8, $2ad4

unkData_000_2ad4:
	dr $2ad4, $2af4

unk_000_2af4::
	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc [hl]
	ld a, [hl]
	cp $40
	jp c, Jump_000_047e

	ld a, $01
	ld [wcac5], a
	ld bc, $2b6d
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld a, [wcf9a]
	call unk_001_4bd1
	ld a, [wPowerLevel]
	ld [wca2c], a
	ld de, $2b22
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld bc, $2b6d
	ld de, unk_000_3040
	call Call_000_0b38
	ld de, $2b75
	call Call_000_0b03
	ld de, $2b3b
	jp Jump_000_0a53


	ld a, [wcac7]
	or a
	jp z, Jump_000_047e

	call Call_000_0c04
	or a
	jp nz, Jump_000_047e

	inc a
	ld [wcacb], a
	ld de, $2b53
	jp Jump_000_0a53


	ld a, [wcac6]
	or a
	jp z, Jump_000_047e

	ld hl, wca12
	ld a, [hli]
	ld b, [hl]
	ld c, a
	ld a, [bc]
	call Call_000_0b4a
	ld de, NextStage
	call Func_000_0a3e
	jp Jump_000_0a64

unkData_000_2b6d:
	db $25, $08, $08, $00, $00, $10, $10, $01, $ce, $00, $bc, $00, $e2, $00, $da, $00
	db $00, $00, $d8, $00, $da, $00, $b4, $00, $c0, $00, $bc, $00

unkData_000_2b89:
	dr $2b89, $2c49

unk_000_2c49:
	ld a, [wLives]
	or a
	jr z, jr_000_2c59

	xor a
	ld [wLives], a
	ld de, unk_000_165e
	jp Jump_000_0a53

jr_000_2c59:
	xor a
	ld [wFadeoutCounter], a
	ld de, unk_000_06f1
	jp Jump_000_0a53

unk_000_2c63:
	ld a, [wJoypadDown]
	and $08
	jp z, Jump_000_047e

	ld a, $01
	ld [wcffa], a
	ld [wcffb], a
	ld [wcf98], a
	jp Jump_000_0a67

Call_000_2c79:
	ld c, 8
	ld de, wScore
	ld hl, wTopScore
jr_000_2c81:
	ld a, [de]
	cp [hl]
	ret c
	jr nz, jr_000_2c8c

	inc de
	inc hl
	dec c
	jr nz, jr_000_2c81
	ret

jr_000_2c8c:
	ld c, 8
	ld hl, wScore
	ld de, wTopScore
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

unkData_000_2c9b:
	dr $2c9b, $2cbe

unk_000_2cbe::
	ld hl, wca12
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc [hl]
	ld a, [hl]
	cp $40
	jp c, Jump_000_047e

	ld a, $01
	ld [wcac5], a
	ld a, [wcf9a]
	call unk_001_4bd1
	call Call_000_2c79
	ld de, $2cdf
	jp Jump_000_0a53


	ld a, [wcac7]
	or a
	jp z, Jump_000_047e

	ld [wcacb], a
	ld de, $2cef
	jp Jump_000_0a53


	ld a, [wcac6]
	or a
	jp z, Jump_000_047e

	ld hl, wca12
	ld a, [hli]
	ld b, [hl]
	ld c, a
	ld a, [bc]
	call Call_000_0b4a
	ld de, NextStage
	call Func_000_0a3e
	jp Jump_000_0a67


	ld bc, $2f9b
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $2d19
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld bc, $2f9b
	ld de, $6872
	call Call_000_0b38
	ld de, $2fa3
	call Call_000_0b03
	ld de, $2d32
	jp Jump_000_0a53


	ld hl, $0010
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $ff
	jp nz, Jump_000_047e

	ld de, $2d43
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $001c
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $07
	ld [hli], a
	jp nz, Jump_000_047e

	ld a, [hl]
	inc [hl]
	cp $07
	jp z, Jump_000_0a64

	push hl
	ld hl, $2fc7
	call Call_001_465d
	pop hl
	ld a, [hl]
	cp $04
	jp nz, Jump_000_047e

	ld de, $2d71
	call Func_000_0a3e
	jp Jump_000_047e


	ld bc, $2faf
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $2d81
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $0008
	add hl, bc
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, $0018
	add hl, bc
	ld bc, $2faf
	ld de, $606a
	call Call_000_0b38
	ld de, $2fb7
	call Call_000_0b03
	ld de, $2da5
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hl]
	cp $f0
	jr nc, jr_000_2dbf

	ld hl, $0008
	add hl, bc
	ld a, [hli]
	ld e, [hl]
	ld d, a
	call Call_000_0bf3
	ld de, $2dd5
	jp Jump_000_0a53


jr_000_2dbf:
	call Call_000_0b10
	ld a, [wca22]
	cp $0f
	jr nz, jr_000_2dcf

	ld de, $2ded
	jp Jump_000_0a53


jr_000_2dcf:
	ld de, $2e5b
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	inc a
	and $03
	ld [hli], a
	jr nz, jr_000_2de7

	dec [hl]
	inc hl
	dec [hl]

jr_000_2de7:
	ld de, $2da5
	jp Jump_000_0a53


	ld hl, $0018
	add hl, bc
	xor a
	ld [hl], a
	ld a, $0e
	ld [wcad6], a
	ld de, $2fdb
	ld hl, wcad2
	ld a, e
	ld [hli], a
	ld [hl], d
	ld de, $9a2e
	ld a, e
	ld hl, wcad4
	ld [hli], a
	ld [hl], d
	ld a, $01
	ld [wcad0], a
	ld [wcad8], a
	ld de, $2e18
	jp Jump_000_0a53


	ld a, [wcad0]
	or a
	jp nz, Jump_000_047e

	ld a, $0e
	ld [wcad6], a
	ld de, $2fe9
	ld hl, wcad2
	ld a, e
	ld [hli], a
	ld [hl], d
	ld de, $9a4e
	ld a, e
	ld hl, wcad4
	ld [hli], a
	ld [hl], d
	ld a, $01
	ld [wcad0], a
	ld [wcad8], a
	ld de, $2e44
	jp Jump_000_0a53


	ld a, [wcad0]
	or a
	jp nz, Jump_000_047e

	ld hl, $0018
	add hl, bc
	inc [hl]
	ld a, [hl]
	or a
	jp nz, Jump_000_047e

	ld de, NextStage
	jp Jump_000_0a53


	ld hl, $0018
	add hl, bc
	xor a
	ld [hl], a
	ld a, $0e
	ld [wcad6], a
	ld de, $2ff7
	ld hl, wcad2
	ld a, e
	ld [hli], a
	ld [hl], d
	ld de, $9a2e
	ld a, e
	ld hl, wcad4
	ld [hli], a
	ld [hl], d
	ld a, $01
	ld [wcad0], a
	ld [wcad8], a
	ld de, $2e86
	jp Jump_000_0a53


	ld a, [wcad0]
	or a
	jp nz, Jump_000_047e

	ld a, $0e
	ld [wcad6], a
	ld de, $3005
	ld hl, wcad2
	ld a, e
	ld [hli], a
	ld [hl], d
	ld de, $9a4e
	ld a, e
	ld hl, wcad4
	ld [hli], a
	ld [hl], d
	ld a, $01
	ld [wcad0], a
	ld [wcad8], a
	ld de, $2eb2
	jp Jump_000_0a53


	ld a, [wcad0]
	or a
	jp nz, Jump_000_047e

	ld hl, $0018
	add hl, bc
	inc [hl]
	ld a, [hl]
	or a
	jp nz, Jump_000_047e

	ld de, NextStage
	jp Jump_000_0a53


	ld de, unk_000_3019
	call Func_000_0a3e
	ld de, $2ed5
	jp Jump_000_0a53


	ld a, [wcac9]
	or a
	jp z, Jump_000_047e

	ld hl, wca80
	ld a, [hl]
	or a
	jp nz, Jump_000_047e

	ld hl, rSCX
	dec [hl]
	ld a, [hl]
	cp $11
	jp nc, Jump_000_047e

	jp Jump_000_0a67


	ld bc, unkData_000_2f8d
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $2f01
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld bc, unkData_000_2f8d
	ld de, $a048
	call Call_000_0b38
	ld de, $2f95
	call Call_000_0b03
	ld de, $2f1a
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	ld a, [hl]
	cp $30
	jr c, jr_000_2f37

	ld d, b
	ld e, c
	ld a, $fc
	call Call_000_0b61
	ld a, [wca16]
	ld d, a
	ld e, 0
	call Call_000_0b1e
	jp Jump_000_047e

jr_000_2f37:
	ld de, unk_000_2f3d
	jp Jump_000_0a53

unk_000_2f3d:
	ld hl, wcaf0
	ld de, unkText_000_3013
	ld b, 6
.asm_2f45
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, .asm_2f45

	ld hl, wcaf6
	ld de, wScore
	ld b, 7
.copy_digit
	ld a, [de]
	or $f0
	ld [hli], a
	inc de
	dec b
	jr nz, .copy_digit

	ld a, $0e
	ld [wcad6], a
	ld de, wcaf0
	ld hl, wcad2
	ld a, e
	ld [hli], a
	ld [hl], d

	ld de, $9a25
	ld a, e
	ld hl, wcad4
	ld [hli], a
	ld [hl], d

	ld a, $01
	ld [wcad0], a
	ld [wcad8], a
	ld [wcffc], a
	ld [wEndScreen], a

	ld a, [wca2e]
	or a
	jp z, Jump_000_0a67

	ld [wca2f], a
	jp Jump_000_0a67

unkData_000_2f8d:
	db $13, $08, $08, $00, $00, $10, $10, $01, $bc, $00, $ce, $00, $ba, $00, $13, $08
	db $08, $00, $00, $10, $10, $01, $80, $00, $82, $00, $84, $00, $00, $00, $00, $00
	db $00, $00, $24, $08, $08, $00, $00, $10, $10, $01, $5a, $00, $5c, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $5e, $00, $60, $00, $04, $04, $00, $04, $04, $00
	db $00, $fc, $fc, $00, $00, $00, $fc, $fc, $fc, $04, $00, $04, $04, $fc, $be, $c4
	db $ce, $b4, $ca, $bf, $cc, $c4, $d8, $d8, $c4, $d0, $ce, $bf, $bf, $bf, $bf, $c4
	db $d8, $bf, $d0, $de, $bc, $d6, $bf, $bf, $bf, $bf, $be, $c4, $ce, $b4, $ca, $bf
	db $cc, $c4, $d8, $d8, $c4, $d0, $ce, $bf, $c4, $d8, $bf, $d0, $de, $bc, $d6, $bf
	db $bf, $bf, $bf, $bf, $bf, $bf

unkText_000_3013:
	db $d8, $b8, $d0, $d6, $bc, $bf

unk_000_3019:
	ld de, unk_000_3040
	call Func_000_0a3e
	ld de, unk_000_30d9
	call Func_000_0a3e
	ld a, $01
	ld [wca2d], a
	ld de, unk_000_3030
	jp Jump_000_0a53

unk_000_3030:
	ld bc, unkData_000_31ba
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, unk_000_3050
	jp Jump_000_0a53

unk_000_3040:
	ld bc, $31bb
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, unk_000_3069
	jp Jump_000_0a53

unk_000_3050:
	ld a, [bc]
	call Call_000_0b4a
	ld bc, unkData_000_31ba
	ld de, $30e1
	call Call_000_0b38
	ld de, unkData_000_31bc
	call Call_000_0b03

	ld de, unk_000_3082
	jp Jump_000_0a53

unk_000_3069:
	ld a, [bc]
	call Call_000_0b4a
	ld bc, $31bb
	ld de, $4000
	call Call_000_0b38
	ld de, $31d4
	call Call_000_0b03
	ld de, $3082
	jp Jump_000_0a53

unk_000_3082:
	ld hl, wca80
	ld a, [hl]
	or a
	jp nz, Jump_000_047e

	ldh a, [rSCX]
	cp $12
	jp c, Jump_000_309e

	ld a, [bc]
	call Call_000_0b4a
	ld de, $01
	call Call_000_0b1e
	jp Jump_000_047e

Jump_000_309e:
	ld de, $30a4
	jp Jump_000_0a53

unk_000_30a4:
	ld a, [wca1c]
	or a
	jp z, Jump_000_047e

	ld de, $30b1
	jp Jump_000_0a53

unk_000_30b1:
	ld a, [bc]
	call Call_000_0b4a
	inc hl
	inc hl
	ld a, [hl]
	cp $c0
	jp nc, Jump_000_0a64

	ld hl, $0004
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc hl
	and $07
	jr nz, jr_000_30c9

	inc [hl]

jr_000_30c9:
	ld a, [hl]
	call Call_000_0b7d
	ld a, [wca17]
	ld e, a
	ld d, 0
	call Call_000_0b1e
	jp Jump_000_047e

unk_000_30d9:
	ld a, [wca1b]
	or a
	jp z, Jump_000_047e

	ld bc, $31dc
	call Call_000_0947
	or a
	jp z, Jump_000_0a67

	ld de, $30f0
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	ld bc, $31dc
	ld de, $4012
	call Call_000_0b38
	ld de, $3103
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc bc
	ld a, [bc]
	inc a
	and $03
	ld [bc], a
	jp nz, Jump_000_047e

	inc bc
	ld l, c
	ld h, b
	ld a, [hl]
	inc [hl]
	cp $04
	jr z, jr_000_312c

	and $01
	add a
	ld l, a
	ld h, 0
	ld de, $31dd
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Call_000_0b03
	jp Jump_000_047e

jr_000_312c:
	xor a
	ld [bc], a
	ld de, $3134
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc bc
	ld a, [bc]
	inc a
	and $03
	ld [bc], a
	jp nz, Jump_000_047e

	inc bc
	ld l, c
	ld h, b
	ld a, [hl]
	inc [hl]
	cp $03
	jr z, jr_000_315b

	add a
	ld l, a
	ld h, 0
	ld de, $31e1
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Call_000_0b03
	jp Jump_000_047e


jr_000_315b:
	xor a
	ld [bc], a
	inc a
	ld [wca1c], a
	ld de, $3167
	jp Jump_000_0a53


	ld a, [bc]
	call Call_000_0b4a
	inc hl
	inc hl
	ld a, [hl]
	cp $c0
	jp nc, Jump_000_31ad

	ld hl, $0004
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc hl
	and $07
	jr nz, jr_000_317f

	inc [hl]

jr_000_317f:
	ld a, [hl]
	call Call_000_0b7d
	ld a, [wca17]
	ld e, a
	ld d, 0
	call Call_000_0b1e
	inc bc
	ld a, [bc]
	inc a
	and $03
	ld [bc], a
	jp nz, Jump_000_047e

	inc bc
	ld l, c
	ld h, b
	ld a, [hl]
	xor $01
	ld [hl], a
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_31e7
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Call_000_0b03
	jp Jump_000_047e

Jump_000_31ad:
	ld a, [bc]
	call Call_000_0b4a
	ld de, $2ef1
	call Func_000_0a3e
	jp Jump_000_0a64

unkData_000_31ba:
	db $34, $14

unkData_000_31bc:
	db $06, $00, $08, $00, $0a, $00, $0c, $00, $0e, $00, $10, $00, $12, $00
	db $14, $00, $16, $00, $18, $00, $1a, $00, $1c, $00, $1e, $00, $20, $00, $22, $00
	db $24, $00, $12, $eb, $31, $ef, $31, $f3, $31, $f7, $31, $fb, $31

unkData_000_31e7:
	db $ff, $31, $03
	db $32, $00, $00, $26, $00, $00, $00, $28, $00, $00, $00, $2a, $00, $00, $00, $2c
	db $00, $2e, $00, $30, $00
	db $32, $00
	db $34, $00
	db $36, $00
	db $38, $00

unk_000_3207:
	ld hl, 4
	add hl, bc
	inc [hl]
	ld a, [hl]
	or a
	jp nz, Jump_000_047e

	xor a
	ld [wcad8], a
	ld de, unk_000_321b
	jp Jump_000_0a53

unk_000_321b:
	call Call_000_32ab
	ld a, $90
	ldh [rWX], a
	ld de, unk_000_3228
	jp Jump_000_0a53

unk_000_3228:
	ld a, [wcad0]
	or a
	jp nz, Jump_000_047e

	call Call_000_32ab
	ld a, [wcad8]
	cp 2 ; +2
	jr z, .asm_3264
	cp 5 ; +3
	jr z, .asm_3264
	cp 8 ; +3
	jr z, .asm_3264
	cp 10 ; +2
	jr z, .asm_3264
	cp 13 ; +3
	jr z, .asm_3264
	cp 15 ; +2
	jr z, .asm_3264
	cp 18 ; +3
	jr z, .asm_3264
	cp 20 ; +2
	jr z, .asm_3264
	cp 22 ; +2
	jr z, .asm_3264
	cp 24 ; +2
	jr z, .asm_3264
	cp 28 ; +4
	jr z, .asm_3264

	jp Jump_000_047e

.asm_3264
	ld de, unk_000_326a
	jp Jump_000_0a53

unk_000_326a:
	ld a, [wcad0]
	or a
	jp nz, Jump_000_047e

	ld hl, wcad1
	ld a, [hl]
	inc a
	ld [hl], a
	and $03
	jp nz, Jump_000_047e

	ld hl, rWX
	dec [hl]
	ld a, [hl]
	cp $08
	jp nc, Jump_000_047e

	ld de, $328c
	jp Jump_000_0a53


	ld hl, wcad8
	ld a, [hli]
	cp $1c
	jr nz, jr_000_329c

	ld a, $01
	ld [wca1b], a
	jp Jump_000_0a67


jr_000_329c:
	inc [hl]
	ld a, [hl]
	cp $e0
	jp nz, Jump_000_047e

	xor a
	ld [hl], a
	ld de, $321b
	jp Jump_000_0a53

Call_000_32ab:
	ld a, [wcad8]
	ld b, a
	ld a, $11
	ld [wcad6], a
	ld a, b
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_3315
	add hl, de
	ld a, [hli]
	ld e, [hl]
	ld hl, wcad2
	ld [hli], a
	ld [hl], e
	ld a, b
	add a
	ld l, a
	ld h, 0
	ld de, unkData_000_32dd
	add hl, de
	ld a, [hli]
	ld e, [hl]
	ld hl, wcad4
	ld [hli], a
	ld [hl], e
	ld a, b
	inc a
	ld [wcad0], a
	ld [wcad8], a
	ret

INCLUDE "data/credits.asm"

unkData_000_3529:
	dr $3529, $373d

unkData_000_373d::
	dr $373d, $37bf

unkData_000_37bf::
	dr $37bf, $38c9

unkData_000_38c9:
	db $4d, $3d, $89, $3c, $a1, $3c, $89, $3c, $91, $3c, $91, $3c, $89, $3c, $a1, $3c
	db $a1, $3c, $89, $3c, $91, $3c, $91, $3c, $89, $3c, $a1, $3c, $a1, $3c, $89, $3c
	db $91, $3c, $91, $3c, $89, $3c, $a1, $3c, $a1, $3c, $89, $3c

unkData_000_38f5:
	dr $38f5, $3c89

unkData_000_3c89:
	db $00, $00, $00, $00, $00, $00, $00, $08, $10, $10, $10, $10, $10, $10, $10, $10
	db $10, $10, $10, $10, $10, $10, $10, $18, $20, $20, $20, $20, $20, $20, $20, $20
	db $20, $20, $20, $20, $20, $20, $20, $28, $40, $40, $40, $40, $40, $40, $40, $40
	db $40, $40, $40, $40, $40, $40, $40, $48, $80, $80, $80, $80, $80, $80, $80, $80
	db $80, $80, $80, $80, $80, $80, $80, $88, $50, $50, $50, $50, $50, $50, $50, $50
	db $50, $50, $50, $50, $50, $50, $50, $58, $60, $60, $60, $60, $60, $60, $60, $60
	db $60, $60, $60, $60, $60, $60, $60, $68

unkData_000_3cf1:
	dr $3cf1, $3d3d

unkData_000_3d3d:
	dr $3d3d, $3e43

unkData_000_3e43:
	db $10, $10, $50, $10, $50, $50, $50, $40, $50, $40, $48, $40, $40, $60, $40, $60
	db $60, $60, $20, $60, $20, $28, $20, $20, $a0, $20, $a0, $a0, $a0, $80, $a0, $80
	db $88, $80, $80, $90, $80, $90, $90, $90, $10, $90, $10, $18, $20, $20, $60, $20
	db $60, $60, $60, $40, $60, $40, $48, $40, $40, $50, $40, $50, $50, $50, $10, $50
	db $10, $18, $10, $10, $90, $10, $90, $90, $90, $80, $90, $80, $88, $80, $80, $a0
	db $80, $a0, $a0, $a0, $20, $a0, $20, $28

unkData_000_3e9b:
	db $99, $eb, $04, $d2, $dc, $d8, $c2, $9a
	db $08, $0c, $d8, $da, $b4, $d6, $da, $ff, $b6, $dc, $da, $da, $d0, $ce, $9a, $48
	db $03, $da, $d0, $d2, $9a, $88, $0c, $fc, $a2, $b2, $b0, $b2, $ff, $ea, $eb, $ec
	db $ed, $ee, $ef, $00

unkData_000_3ec7:
	db $99, $eb, $04, $d2, $dc, $d8, $c2, $9a, $07, $0d, $d8, $bc, $ca, $bc, $b8, $da
	db $bf, $b6, $dc, $da, $da, $d0, $ce, $9a, $48, $03, $da, $d0, $d2, $9a, $88, $0c
	db $fc, $a2, $b2, $b0, $b2, $ff, $ea, $eb, $ec, $ed, $ee, $ef, $00

unkData_000_3ef4:
	dr $3ef4, $4000
