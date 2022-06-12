Class {
	#name : #Z3FactorialTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests'
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
	self
		assert: (self class factorial value: 0 toInt) simplify
		equals: 1
]

{ #category : #tests }
Z3FactorialTest >> testComputeFactorial10 [
	self
		assert: (self class factorial value: 10 toInt) simplify
		equals: 3628800
]

{ #category : #tests }
Z3FactorialTest >> testInvertFactorial [
	| x solver |
	x := 'x' toInt.
	solver := Z3Solver new.
	solver assert: (self class factorial value: x) === 120.
	solver check.
	x := solver getModel eval: x completion: true.
	self assert: x equals: 5.
	solver del
]
