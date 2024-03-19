Class {
	#name : #GaussBvTestTest,
	#superclass : #TestCaseWithZ3Context,
	#instVars : [
		'xlen'
	],
	#category : #'Z3-Tests'
}

{ #category : #tests }
GaussBvTestTest >> checkGauss: n [
	"1+...+n = n*(n+1)/2"
	self
		assert: (self sum: n)*2
		equals: n*(n+1)
]

{ #category : #'z3 context' }
GaussBvTestTest >> setUp [
	xlen := 8
]

{ #category : #tests }
GaussBvTestTest >> sum: n [
	^(1 to: n)
		inject: (0 toBitVector: xlen)
		into: [ :acc :thisSummand | (acc+thisSummand) simplify ]
]

{ #category : #tests }
GaussBvTestTest >> test10 [
	"1+...+10 = 55"
	self checkGauss: 10
]

{ #category : #tests }
GaussBvTestTest >> test100 [
	"1+...+100 = 5050;
	 this will overflow 8-bit many times but even
	 this is still ok, because everything is mod 256."
	self checkGauss: 100
]

{ #category : #tests }
GaussBvTestTest >> test20 [
	"1+...+20 = 210;
	 this will overflow 8-bit signed into negative
	 but this doesn't matter because everything is
	 defined in two's-complement-neutral way."
	self checkGauss: 20
]

{ #category : #tests }
GaussBvTestTest >> testInductionStep [
	| sum n bv |
	"fast with 8, a few seconds with 16, hopeless with 32
	(with both Z3 v4.8.12.0 and v4.13.0.0)"
	bv := BitVector///8.
	sum := 'sum' functionFrom: {bv} to: bv.
	n := bv mkConst: 'n'.
	self assert: (Z3Solver isValid:
		"recursive definition of sun"	
		(sum value: n) === ((sum value: n-1)+n)
		&
		"induction hypothesis"
		( 2*(sum value: n-1) === (n*(n-1)) )
		
		==>
		
		( 2*(sum value: n) === (n*(n+1)) )
	)
]
