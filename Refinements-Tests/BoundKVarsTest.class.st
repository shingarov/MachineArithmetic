Class {
	#name : #BoundKVarsTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
BoundKVarsTest >> simpleElim [
	"Cf. example in Transformations.hs"
^'
(constraint
  (forall ((z Int) ($k0 z)) ((z = x))))
'
]

{ #category : #tests }
BoundKVarsTest >> testKVarsEbind01 [
	| q |
	q := 1
]

{ #category : #tests }
BoundKVarsTest >> testSimpleElim [
	"Cf. example in Transformations.hs"
	| q c bs1 bs2 binds bss result |
	q := NNFParser parse: self simpleElim.
	c := q qCstr first.
	bs1 := HBind x: 'v' τ: Bool sort p: (DecidableRefinement text: 'v').
	bs2 := HBind x: 'w' τ: Bool sort p: (DecidableRefinement text: 'donkey').
	binds := { bs1. bs2. }.
	bss := { binds -> #(). }.
	c := c doElim: bss var: 'k0'.
	result := c simplify.
	self error.
 "
  -- (forall ((v bool) (v)) (forall ((z int) (donkey)) ((z === x))))
	"
]
