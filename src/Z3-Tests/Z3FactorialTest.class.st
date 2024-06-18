Class {
	#name : #Z3FactorialTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Z3-Tests'
}

{ #category : #tests }
Z3FactorialTest class >> factorial [
	| f n |
	f := 'factorial' recursiveFunctionFrom: {Z3Sort int} to: Z3Sort int.
	n := Int sort mkFreshConst: 'n'.
	f value: n is: (
		n === 0
			ifTrue: [ 1 toInt ]
			ifFalse: [ n*(f value: n-1) ] ).
	^f
]

{ #category : #tests }
Z3FactorialTest >> testComputeFactorial0 [
	"
	This test depends on dynamic deoptimization of ifTrue:ifFalse: 
	which is only available in Pharo. So skip this test everywhere
	else.
	"
	Smalltalk isPharo 
		ifFalse: [ self skip:'Dynamic deoptimization not supported' ].
	"
	This test is known to fail on Z3 4.8.7 and known to work on 
	Z3 >= 4.8.12. 
	"		
	(Z3 isVersionGreaterThan: #(4 8 7)) 
		ifFalse:[ self skip:'This test is known to fail on Z3 4.8.7' ].

	self
		assert: (self class factorial value: 0 toInt) simplify
		equals: 1
]

{ #category : #tests }
Z3FactorialTest >> testComputeFactorial10 [
	"
	This test depends on dynamic deoptimization of ifTrue:ifFalse: 
	which is only available in Pharo. So skip this test everywhere
	else.
	"
	Smalltalk isPharo 
		ifFalse: [ self skip:'Dynamic deoptimization not supported' ].
	"
	This test is known to fail on Z3 4.8.7 and known to work on 
	Z3 >= 4.8.12. 
	"		
	(Z3 isVersionGreaterThan: #(4 8 7)) 
		ifFalse:[ self skip:'This test is known to fail on Z3 4.8.7' ].

	self
		assert: (self class factorial value: 10 toInt) simplify
		equals: 3628800
]

{ #category : #tests }
Z3FactorialTest >> testInvertFactorial [
	| x solver |

	"
	This test depends on dynamic deoptimization of ifTrue:ifFalse: 
	which is only available in Pharo. So skip this test everywhere
	else.
	"
	Smalltalk isPharo ifFalse: [ self skip:'Dynamic deoptimization not supported' ].

	x := 'x' toInt.
	solver := Z3Solver new.
	solver assert: (self class factorial value: x) === 120.
	solver check.
	x := solver getModel eval: x completion: true.
	self assert: x equals: 5.
	solver release
]
