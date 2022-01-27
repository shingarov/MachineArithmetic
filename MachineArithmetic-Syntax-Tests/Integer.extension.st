Extension { #name : #Integer }

{ #category : #'*MachineArithmetic-Syntax-Tests' }
Integer class >> parser [
	^ ($- asParser optional,
		#digit asParser plus)
		flatten
		==> [ :s | Integer readFrom: s ]
]
