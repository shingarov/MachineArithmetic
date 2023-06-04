Class {
	#name : #Z3SetTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
Z3SetTest >> testEmptySet [
	| set |
	set := Z3Sort int mkEmptySet.
	self assert: set sort domain equals: Int sort.
	self assert: set sort class equals: Z3ArraySort.
	self assert: set sort nodeClass equals: McCarthyArray.
	
	"Prove that no element belongs to the empty set.
	 We don't even need a Solver for that: #simplify is enough."
	self deny: (set includes: 'x') simplify
]

{ #category : #tests }
Z3SetTest >> testFullSet [
	| set |
	set := Z3Sort int mkFullSet.
	self assert: set sort domain equals: Int sort.
	self assert: set sort class equals: Z3ArraySort.
	self assert: set sort nodeClass equals: McCarthyArray.
	
	"Prove that every int element belongs to the full set.
	 We don't even need a Solver for that: #simplify is enough."
	self assert: (set includes: 'x') simplify
]

{ #category : #tests }
Z3SetTest >> testSetAdd [
	| emp s solver |
	emp := Int sort mkEmptySet.
	s := emp add: 42.
	self assert: (s includes: 42) simplify.
	self deny: (emp includes: 42) simplify.
	self deny: (s includes: 43) simplify.
	
	"Try to prove that ∀x.x∉{42}"
	solver := Z3Solver new.
	[ solver proveValid: ((s includes: 'x' toInt) not forall: 'x' toInt) ]
		on: NotValid 
		do: [ :ex |
			"but the model doesn't contain an interesting x"
			^solver del
	].
	self assert: false
]

{ #category : #tests }
Z3SetTest >> testSetComplement [
	| s |
	s := (Z3Sort int mkEmptySet add: 1) complement. "ℤ\{1}"
	self assert: (s includes: 2).
	self deny:   (s includes: 1).
]

{ #category : #tests }
Z3SetTest >> testSetRemove [
	| set removed |
	set := Z3Sort int mkEmptySet add: 1.
	self assert: (set includes: 1).
	removed := set remove: 1.
	self deny: (removed includes: 1).
	self assert: (set includes: 1).	
]
