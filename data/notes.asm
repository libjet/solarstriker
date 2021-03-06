FrequencyTable_Octave2:
	dw $02c ; C2
	dw $09d ; C#2
	dw $107 ; D2
	dw $16b ; D#2
	dw $1c9 ; E2
	dw $223 ; F2
	dw $277 ; F#2
	dw $2c7 ; G2
	dw $312 ; G#2
	dw $358 ; A2
	dw $39b ; A#2
	dw $3da ; B2

FrequencyTable_Octave3:
	dw $416 ; C3
	dw $44e ; C#3
	dw $483 ; etc.
	dw $4b5
	dw $4e5
	dw $511
	dw $53b
	dw $563
	dw $589
	dw $5ac
	dw $5ce
	dw $5ed

FrequencyTable_Octave4:
	dw $60b
	dw $627
	dw $642
	dw $65b
	dw $672
	dw $689
	dw $69e
	dw $6b2
	dw $6c4
	dw $6d6
	dw $6e7
	dw $6f7

FrequencyTable_Octave5:
	dw $706
	dw $714
	dw $721
	dw $72d
	dw $739
	dw $744
	dw $74f
	dw $759
	dw $762
	dw $76b
	dw $773
	dw $77b

FrequencyTable_Octave6:
	dw $783
	dw $78a
	dw $790
	dw $797
	dw $79d
	dw $7a2
	dw $7a7
	dw $7ac
	dw $7b1
	dw $7b6
	dw $7ba
	dw $7be

FrequencyTable_Octave7:
	dw $7c1
	dw $7c5
	dw $7c8
	dw $7cb
	dw $7ce
	dw $7d1
	dw $7d4
	dw $7d6
	dw $7d9
	dw $7db
	dw $7dd
	dw $7df

FrequencyTable_Octave8:
	dw $7e1
	dw $7e2
	dw $7e4
	dw $7e6
	dw $7e7
	dw $7e9
	dw $7ea
	dw $7eb
	dw $7ec
	dw $7ed
	dw $7ee
	dw $7ef

FrequencyTable_Octave9:
	dw $7f0
	dw $7f1
	dw $7f2
	dw $7f3
	dw $7f4

OctaveTable:
	dw FrequencyTable_Octave2
	dw FrequencyTable_Octave3
	dw FrequencyTable_Octave4
	dw FrequencyTable_Octave5
	dw FrequencyTable_Octave6
	dw FrequencyTable_Octave7
	dw FrequencyTable_Octave8
	dw FrequencyTable_Octave9
