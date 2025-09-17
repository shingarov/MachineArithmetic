Extension { #name : #Float }

{ #category : #'*Z3' }
Float >> toBitVector: length [
	"Return the receiver as IEEE 754 bits"

	^ ((self basicAt: 1) bitShift: 32) + (self basicAt: 2)
				toBitVector: length.
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
