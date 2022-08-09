Class {
	#name : #ProofTest,
	#superclass : #TestCaseWithZ3Context,
	#instVars : [
		'ℤ',
		'ℝ'
	],
	#category : #'Refinements-SmalltalkSyntax-Tests'
}

{ #category : #tests }
ProofTest >> nestedLambda [
	^[ :x |
			[ :y | x + y ] ]
]

{ #category : #'z3 context' }
ProofTest >> setUp [ 
	super setUp.
	ℤ := Int sort.
	ℝ := Real sort.
]

{ #category : #tests }
ProofTest >> testNegDependentForall1 [
	self
		assert:
			[ ∀x ∈ ℤ |
				[ ∀y ∈ ℤ [y>x] | (y*y) >= (x*x) ]	]  solve
		equals: #Unsafe
]

{ #category : #tests }
ProofTest >> testNegDependentForall2 [
	self
		assert:
			[ ∀x ∈ ℤ |
				[ ∀y ∈ ℤ [y>x] | y > 0 ]	]  solve
		equals: #Unsafe
]

{ #category : #tests }
ProofTest >> testNegE01 [
	self assert:
	[ ∀m ∈ ℤ |
		[ ∃x1 ∈ ℤ |
			[ ∀v ∈ ℤ [v===(m+1)]  | v===x1 ]  &
			[ ∀v ∈ ℤ [v===(x1+1)] | v===(3+m) ]
	] ]
	solve equals: #Unsafe
]

{ #category : #tests }
ProofTest >> testNegICFP17ex1 [
	"Simple example with Horn variables"

]

{ #category : #tests }
ProofTest >> testNegSimpleForall1 [
	self assert: [ ∀x ∈ ℤ | x*x > 0 ] solve equals: #Unsafe
]

{ #category : #tests }
ProofTest >> testNegSimpleForall2 [
	self assert: [ ∀x ∈ ℤ [x>=0] | x > 0 ] solve equals: #Unsafe
]

{ #category : #tests }
ProofTest >> testNegT01 [
	"Cf. HornNegTest>>t01"
	self assert:
	[ ∀x ∈ ℤ [x>0] |
		[ ∀y ∈ ℤ [y>x] | [ ∀v ∈ ℤ [v===(x+y)] | v>0 ] ]
		&
		[ ∀z ∈ ℤ [z>10] | [ ∀w ∈ ℤ [w===(x+z)] | w>100 ] ]
	]
 solve equals: #Unsafe
]

{ #category : #tests }
ProofTest >> testPosDependentForall1 [
	self
		assert:
			[ ∀x ∈ ℤ [x>0] |
				[ ∀y ∈ ℤ [y>x] | (y*y) >= (x*x) ]	]  solve
		equals: #Safe
]

{ #category : #tests }
ProofTest >> testPosDependentForall2 [
	self
		assert:
			[ ∀x ∈ ℤ [x>=0] |
				[ ∀y ∈ ℤ [y>x] | y > 0 ]	]  solve
		equals: #Safe
]

{ #category : #tests }
ProofTest >> testPosE01 [
	self assert:
	[ ∀m ∈ ℤ |
		[ ∃x1 ∈ ℤ |
			[ ∀v ∈ ℤ [v===(m+1)]  | v===x1 ]  &
			[ ∀v ∈ ℤ [v===(x1+1)] | v===(2+m) ]
	] ]
	solve equals: #Safe
]

{ #category : #tests }
ProofTest >> testPosICFP17ex1 [
	"Simple example with Horn variables"

]

{ #category : #tests }
ProofTest >> testPosSimpleForall1 [
	self assert: [ ∀x ∈ ℤ | x*x >= 0 ] solve equals: #Safe
]

{ #category : #tests }
ProofTest >> testPosSimpleForall2 [
	self assert: [ ∀x ∈ ℤ [x>0] | x >= 0 ] solve equals: #Safe
]

{ #category : #tests }
ProofTest >> testPosT01 [
	"Cf. HornPosTest>>t01"
	self assert:
	[ ∀x ∈ ℤ [x>0] |
		[ ∀y ∈ ℤ [y>x] | [ ∀v ∈ ℤ [v===(x+y)] | v>0 ] ]
		&
		[ ∀z ∈ ℤ [z>100] | [ ∀w ∈ ℤ [w===(x+z)] | w>100 ] ]
	]
 solve equals: #Safe
]
