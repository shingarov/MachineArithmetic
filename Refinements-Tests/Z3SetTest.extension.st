Extension { #name : #Z3SetTest }

{ #category : #'*Refinements-Tests' }
Z3SetTest >> testSetIU [
	| onetwo threefour |
	onetwo    := (Int sort mkEmptySet add: 1) add: 2.
	threefour := (Int sort mkEmptySet add: 3) add: 4.

	self assert: (onetwo ∪ threefour includes: 1) simplify.
	self assert: (onetwo ∪ threefour includes: 2) simplify.
	self assert: (onetwo ∪ threefour includes: 3) simplify.
	self assert: (onetwo ∪ threefour includes: 4) simplify.
	self deny:   (onetwo ∪ threefour includes: 5) simplify.

	self deny:   (onetwo ∩ threefour includes: 1) simplify.
	self deny:   (onetwo ∩ threefour includes: 2) simplify.
	self deny:   (onetwo ∩ threefour includes: 3) simplify.
	self deny:   (onetwo ∩ threefour includes: 4) simplify.
]

{ #category : #'*Refinements-Tests' }
Z3SetTest >> testSetIU2 [
	| onetwo threefour solver |
	onetwo    := (Int sort mkEmptySet add: 1) add: 2.
	threefour := (Int sort mkEmptySet add: 3) add: 4.
	
	solver := Z3Solver new.
	solver proveValid: ((onetwo ∪ threefour includes: 'x') exists: 'x' toInt).
	solver proveValid: ((onetwo ∩ threefour includes: 'x') exists: 'x' toInt) not.
	solver del
]
