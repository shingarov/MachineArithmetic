Extension { #name : #BitVector }

{ #category : #'*MathNotation' }
BitVector >> ⊕ [ rhs
	"Bitwise exclusive-or.
	
	We prefer the selector from Claude Shannon's
	'Symbolic Analysis of Relay and Switching Circuits' (1938);
	Boole's ≠ and Church's ≢ don't seem applicable because they
	take single-bit inputs.	"

	^ self bitXor: rhs
]
