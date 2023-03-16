Class {
	#name : #KVarElimTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #'tests - boundKvars' }
KVarElimTest >> boundKvarsIn: t [
	| testSource q cstr |
	testSource := (HornPosTest new perform: t).
	q := NNFParser parse: testSource.
	cstr := q qCstr first.
	^cstr boundKVars

]

{ #category : #'tests - elim' }
KVarElimTest >> elimKvarsIn: t [
	| testSource q cstr |
	testSource := (HornPosTest new perform: t).
	q := NNFParser parse: testSource.
	cstr := q qCstr first.
	^cstr elim

]

{ #category : #'tests - boundKvars' }
KVarElimTest >> testBoundKvarsE1 [
	self
		assert: (self boundKvarsIn: #ebind01)
		equals: Set new
]

{ #category : #'tests - boundKvars' }
KVarElimTest >> testBoundKvarsE2 [
	self
		assert: (self boundKvarsIn: #ebind02)
		equals: (Set with: 'k')
]

{ #category : #'tests - boundKvars' }
KVarElimTest >> testBoundKvarsT0 [
	self
		assert: (self boundKvarsIn: #t00)
		equals: Set new
]

{ #category : #'tests - boundKvars' }
KVarElimTest >> testBoundKvarsT1 [
	self
		assert: (self boundKvarsIn: #t01)
		equals: Set new
]

{ #category : #'tests - boundKvars' }
KVarElimTest >> testBoundKvarsT2 [
	self
		assert: (self boundKvarsIn: #t02)
		equals: (Set with: 'k0')
]

{ #category : #'tests - boundKvars' }
KVarElimTest >> testBoundKvarsT3 [
	self
		assert: (self boundKvarsIn: #t03)
		equals: (Set with: 'k0')
]

{ #category : #'tests - elim' }
KVarElimTest >> testElimT0 [
	| result |
	result := self elimKvarsIn: #t00.
	(result isKindOf: CstrAnd) ifTrue: [ result := result conjuncts first ].
	self
		assert: result bind x
		equals: 'x'.
	self
		assert: result p bind x
		equals: 'y'.
	self
		assert: result p p bind x
		equals: 'v'.
	self
		assert: result p p p pred expr text isString
	
	
]

{ #category : #'tests - elim' }
KVarElimTest >> testElimT1 [
	| result |
	result := self elimKvarsIn: #t01.
	(result isKindOf: CstrAnd) ifTrue: [ result := result conjuncts first ].
	self
		assert: result bind x
		equals: 'x'.
	self
		assert: result bind p expr text
		equals: 'x > 0'.
]

{ #category : #'tests - elim' }
KVarElimTest >> testElimT2 [
	| result |
	result := self elimKvarsIn: #t02.
	(result isKindOf: CstrAnd) ifTrue: [ result := result conjuncts first ].
	self
		assert: result bind x
		equals: 'x'.
	self
		assert: result bind p expr text
		equals: 'x > 0'.
]
