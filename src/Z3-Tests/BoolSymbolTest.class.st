Class {
	#name : #BoolSymbolTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Z3-Tests'
}

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
BoolSymbolTest >> testFalseIsNotSymbolic [
	| f |
	f := Bool false.
	self deny: f isSymbolic

]

{ #category : #tests }
BoolSymbolTest >> testIsSymbolic [
	| x y a b term |
	x := Bool var: 'x'.
	y := Bool var: 'y'.
	a := Bool var: 'a'.
	b := Bool var: 'b'.
	term := (x & y) | (a & b).
	self assert: term isSymbolic

]

{ #category : #tests }
BoolSymbolTest >> testTautology [
	| x y |
	x := Bool var: 'x'.
	y := x | x not.
	self assert: y value

]

{ #category : #tests }
BoolSymbolTest >> testUnsat [
	| x y |
	x := Bool var: 'x'.
	y := x & x not.
	self deny: y value

]
