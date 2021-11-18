Extension { #name : #UnsortedQuantifier }

{ #category : #'*MachineArithmetic-MathNotation-Pharo' }
UnsortedQuantifier >> ∈ [ sort
	^SortedQuantifier basicNew 
		sort: sort;
		quantifier: self;
		yourself
]
