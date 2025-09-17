Extension { #name : #Float }

{ #category : #'*Z3' }
Float >> toBitVector: length [
	"Return the receiver as IEEE 754 bits"

	| bits |

	length = 64 ifFalse: [ self error: 'bit length mismatch' ].

	"Following code is arguably ugly - but that's the cost of supporting 
	 multiple Pharo versions and Smalltalk/X."

	((Smalltalk respondsTo: #isSmalltalkX) and: [ Smalltalk isSmalltalkX ]) ifTrue: [ 
		"This is Smalltalk/X:"
		bits := 0.
		UninterpretedBytes isBigEndian ifTrue: [ 
			1 to: (length // 8) do: [:i | bits := (bits << 8) | (self basicAt: i) ]
		] ifFalse: [ 
			(length // 8) downTo: 1 do: [:i | bits := (bits << 8) | (self basicAt: i) ]
		].
	] ifFalse: [
		"Assuming some version of Pharo:"
		bits := ((self basicAt: 1) bitShift: 32) + (self basicAt: 2)
	].

	^ bits toBitVector: length

	"Created: / 17-09-2025 / 12:21:38 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #'*Z3' }
Float >> toFloatingPoint: length [

	| bits ctxt sort |
	length = 64 ifFalse: [ self error: 'bit length mismatch' ].

	bits := self toBitVector: length.  

	ctxt := Z3Context current.
	sort := ctxt mkFloatingPointSort64.

	^ (Z3 mk_fpa_to_fp_bv: ctxt _: bits _: sort) simplify
]
