Extension { #name : #UnsortedQuantifier }

{ #category : #'*MachineArithmetic-MathNotation' }
UnsortedQuantifier >> ∈ [ sort
	^SortedQuantifier basicNew 
		sort: sort;
		quantifier: self;
		yourself
]
