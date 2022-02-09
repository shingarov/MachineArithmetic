Extension { #name : #Integer }

{ #category : #'*MachineArithmetic-Syntax' }
Integer class >> parser [
	^ ($- asParser optional,
		#digit asParser plus)
		flatten
		==> [ :s | Integer readFrom: s ]
]
