Class {
	#name : #BitRelevanceTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Z3-Tests'
}

{ #category : #tests }
BitRelevanceTest >> test1KStores [
	"Create an array of 1024 ints.
	Fill all even slots with zeros, and all odd slots with ones.
	Prove that if the content of a slot is 0, then that slot's index has LSB=0."
	| width s arraySort A thm k |
	width := 10.
	arraySort := (Z3Sort bv: width) --> Z3Sort int.
	A := arraySort mkConst: 'a'.
	s := Z3Solver new.
	0 to: 1024 do: [ :i |
		s assert: ((A arraySelect: (BitVector value: i length: width))
			eq: (Int value: i\\2)) ].
	
	k := 'k' toBitVector: width.
	thm := ((A arraySelect: k) eq: (Int value: 0)) ==>
		((k copyFrom: 0 to: 0) eq: 0).
	s proveValid: thm.
	s release
]

{ #category : #tests }
BitRelevanceTest >> test1KStoresExceptOne [
	"Like test1KStores, but this time leave the 101th slot unconstrained.
	Now the proof fails, because the 101th slot could contain either 1 or 0,
	in which latter case there exists an odd-numbered slot with 0 in it."
	| width s arraySort A thm k |
	width := 10.
	arraySort := (Z3Sort bv: width) --> Z3Sort int.
	A := arraySort mkConst: 'a'.
	s := Z3Solver new.
	0 to: 1024-1 do: [ :i |
		i = 101 ifFalse: [
			s assert: ((A arraySelect: (BitVector value: i length: width))
				eq: (Int value: i\\2)) ]].
	
	k := 'k' toBitVector: width.
	thm := ((A arraySelect: k) eq: (Int value: 0)) ==>
		((k copyFrom: 0 to: 0) eq: 0).
	[s proveValid: thm] on: NotValid do: [ :ex |
		self assert: (ex counterexample constantsASTs at: 'k') value equals: 101.
		s release.
		^self ].
	self assert: false
]
