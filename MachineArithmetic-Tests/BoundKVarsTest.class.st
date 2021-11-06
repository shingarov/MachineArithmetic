Class {
	#name : #BoundKVarsTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-Fixpoint'
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
	| q c bs1 bs2 bss |
	q := NNFParser parse: self simpleElim.
	c := q qCstr first.
	bs1 := HBind x: 'v' τ: Bool sort p: (DecidableRefinement text: 'v').
	bs2 := HBind x: 'w' τ: Bool sort p: (DecidableRefinement text: 'donkey').
	bss := {
		#() -> bs1.
		#() -> bs2.
	}.
	c := c doElim: bss var: 'k0'.
	
 ' 

  -- (forall ((v bool) (v)) (forall ((z int) (donkey)) ((z == x))))
	
'
]
