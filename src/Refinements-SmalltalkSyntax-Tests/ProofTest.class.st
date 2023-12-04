Class {
	#name : #ProofTest,
	#superclass : #TestCaseWithZ3Context,
	#instVars : [
		'ℤ',
		'ℝ'
	],
	#category : #'Refinements-SmalltalkSyntax-Tests'
}

{ #category : #common }
ProofTest >> proveSafe: p [
	self assert: p solve equals: #Safe
]

{ #category : #common }
ProofTest >> proveUnsafe: p [
	self assert: p solve equals: #Unsafe
]

{ #category : #'z3 context' }
ProofTest >> setUp [ 
	super setUp.
	ℤ := Int sort.
	ℝ := Real sort.
]

{ #category : #'tests - simple Horn var' }
ProofTest >> testHorn0000 [
	self assert:
	[ ⋆k0(ℤ) |
		[ ∀x ∈ ℤ [k0 value: x] | x>10 ]
	]
 solve equals: #Safe
]

{ #category : #'tests - simple Horn var' }
ProofTest >> testHorn000withClash [
	| k0 |
	k0 := HVar name: 'k0' argSorts: {ℤ}.
	self assert: (
	[ ∀x ∈ ℤ [x>100] | k0 value: x ] &
	[ ∀x ∈ ℤ [k0 value: x] | x>100 ]
 solveWithHornVars: { k0 }
	) equals: #Safe
]

{ #category : #'tests - simple Horn var' }
ProofTest >> testHornAbsurd [
	self assert:
	[ ⋆k0(ℤ) |
		[ ∀x ∈ ℤ [k0 value: x] | (x>100) & (x<0) ]
	]
 solve equals: #Safe
]

{ #category : #'tests - simple Horn var' }
ProofTest >> testHornSimple [
	self assert:
	[ ⋆k(ℤ) |
		[ ∀x ∈ ℤ [x>100] | k value: x ] &
		[ ∀z ∈ ℤ [k value: z] | z>100 ]
	]
 solve equals: #Safe
]

{ #category : #'tests - simple first-order' }
ProofTest >> testNegDependentForall1 [
	self
		assert:
			[ ∀x ∈ ℤ |
				[ ∀y ∈ ℤ [y>x] | (y*y) >= (x*x) ]	]
		solve equals: #Unsafe
]

{ #category : #'tests - simple first-order' }
ProofTest >> testNegDependentForall2 [
	self
		assert:
			[ ∀x ∈ ℤ |
				[ ∀y ∈ ℤ [y>x] | y > 0 ]	]
		solve equals: #Unsafe
]

{ #category : #'tests - LF safety' }
ProofTest >> testNegE01 [
	self proveUnsafe:
	[ ∀m ∈ ℤ |
		[ ∃x1 ∈ ℤ |
			[ ∀v ∈ ℤ [v===(m+1)]  | v===x1 ]  &
			[ ∀v ∈ ℤ [v===(x1+1)] | v===(3+m) ]
		]
	]

]

{ #category : #'tests - simple first-order' }
ProofTest >> testNegSimpleForall1 [
	self assert: [ ∀x ∈ ℤ | x*x > 0 ] solve equals: #Unsafe
]

{ #category : #'tests - simple first-order' }
ProofTest >> testNegSimpleForall2 [
	self assert: [ ∀x ∈ ℤ [x>=0] | x > 0 ] solve equals: #Unsafe
]

{ #category : #'tests - LF safety' }
ProofTest >> testNegT01 [
	"Cf. HornNegTest>>t01"
	self proveUnsafe:
	[ ∀x ∈ ℤ [x>0] |
		[ ∀y ∈ ℤ [y>x] | [ ∀v ∈ ℤ [v===(x+y)] | v>0 ] ]
		&
		[ ∀z ∈ ℤ [z>10] | [ ∀w ∈ ℤ [w===(x+z)] | w>100 ] ]
	]
]

{ #category : #'tests - simple first-order' }
ProofTest >> testPosDependentForall1 [
	self
		assert:
			[ ∀x ∈ ℤ [x>0] |
				[ ∀y ∈ ℤ [y>x] | (y*y) >= (x*x) ]	]  solve
		equals: #Safe
]

{ #category : #'tests - simple first-order' }
ProofTest >> testPosDependentForall2 [
	self
		assert:
			[ ∀x ∈ ℤ [x>=0] |
				[ ∀y ∈ ℤ [y>x] | y > 0 ]	]  solve
		equals: #Safe
]

{ #category : #'tests - LF safety' }
ProofTest >> testPosE01 [
	self assert:
	[ ∀m ∈ ℤ |
		[ ∃x1 ∈ ℤ |
			[ ∀v ∈ ℤ [v===(m+1)]  | v===x1 ]  &
			[ ∀v ∈ ℤ [v===(x1+1)] | v===(2+m) ]
	] ]
	solve equals: #Safe
]

{ #category : #'tests - LF safety' }
ProofTest >> testPosE02 [
	self proveSafe:
	[ ⋆k(ℤ) |
		[ ∀m∈ℤ |
			[ ∀z∈ℤ [z === (m-1)] |
				[ ∀v1∈ℤ [v1 === (z+2)] | k value: v1 ] &
				[ ∃x1 ∈ ℤ |
					[ ∀v2 ∈ ℤ [k value: v2]  | v2===x1 ]  &
					[ ∀v3 ∈ ℤ [v3 === (x1+1)] | v3 === (m+2) ]
				]
			]
		]
	]
]

{ #category : #'tests - LF safety' }
ProofTest >> testPosICFP17ex1 [
	self proveSafe:
	[ ⋆k(ℤ) |
		[ ∀x∈ℤ [x >= 0] |
			[ ∀v∈ℤ [v === (x-1)] | k value: x ] &
			[ ∀y∈ℤ [k value: y] |
				[ ∀w∈ℤ [w === (y+1)] | w >= 0 ]
			]
		]
	]
]

{ #category : #'tests - LF safety' }
ProofTest >> testPosICFP17ex2 [
	self proveSafe:
	[ ⋆kx(ℤ) ⋆ky(ℤ) |
		[ ∀x∈ℤ [x >= 0] |
			[ ∀n∈ℤ [n === (x-1)] |
				[ ∀p∈ℤ [p === (x+1)] |
					[ ∀v1∈ℤ [v1 === n] | kx value: v1 ] &
					[ ∀v2∈ℤ [v2 === p] | ky value: v2 ] &
					[ ∀v3∈ℤ [kx value: p] | ky value: v3 ]
				 ]
			 ] &
			[ ∀y∈ℤ [ky value: y] |
				[ ∀w∈ℤ [w === (y+1)] | w >= 0 ]
			]
		]
	]
]

{ #category : #'tests - LF safety' }
ProofTest >> testPosICFP17ex3 [
	self proveSafe:
	[ ⋆ka(ℤ) ⋆kb(ℤ) ⋆kc(ℤ) |
		[ ∀a∈ℤ [ka value: a] |
			[ ∀v∈ℤ [v === (a-1)] | kb value: v ] ] &
		[ ∀b∈ℤ [kb value: b] |
			[ ∀v1∈ℤ [v1 === (b+1)] | kc value: v1 ] ] &
		[ ∀v2∈ℤ [v2 >= 0] | ka value: v2 ] &
		[ ∀v3∈ℤ [kc value: v3] | v3 >= 0 ]
	]
]

{ #category : #'tests - simple first-order' }
ProofTest >> testPosSimpleForall1 [
	self assert: [ ∀x ∈ ℤ | x*x >= 0 ] solve equals: #Safe
]

{ #category : #'tests - simple first-order' }
ProofTest >> testPosSimpleForall2 [
	self assert: [ ∀x ∈ ℤ [x>0] | x >= 0 ] solve equals: #Safe
]

{ #category : #'tests - LF safety' }
ProofTest >> testPosT01 [
	"Cf. HornPosTest>>t01"
	self proveSafe:
	[ ∀x ∈ ℤ [x>0] |
		[ ∀y ∈ ℤ [y>x] | [ ∀v ∈ ℤ [v===(x+y)] | v>0 ] ]
		&
		[ ∀z ∈ ℤ [z>100] | [ ∀w ∈ ℤ [w===(x+z)] | w>100 ] ]
	]
]
