Class {
	#name : #BoolSymbolTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #running }
BoolSymbolTest >> setUp [
	Z3Context createGlobalContext 
]

{ #category : #running }
BoolSymbolTest >> tearDown [
	Z3Context current del
]

{ #category : #tests }
BoolSymbolTest >> testBasicCreation [
	| x |
	x := Bool var: 'x'.
	self assert: x sym equals: 'x'.
	self assert: x isLeaf.
	self assert: (x variableNames includes: 'x')

]

{ #category : #tests }
BoolSymbolTest >> testConjunct [
	| x y z |
	x := Bool var: 'x'.
	y := Bool var: 'y'.
	z := x & y.  "debug here to look at things"
	self assert: x isLeaf.
	self deny: z isLeaf

]

{ #category : #tests }
BoolSymbolTest >> testTautology [
	| x y |
	x := Bool var: 'x'.
	y := x | x not.
	self assert: y simplify value

]

{ #category : #tests }
BoolSymbolTest >> testUnsat [
	| x y |
	x := Bool var: 'x'.
	y := x & x not.
	self deny: y value

]
