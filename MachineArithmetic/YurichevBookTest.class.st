"
Examples from the excellent textbook by Denis Yurichev, ""SAT/SMT by Example"".
"
Class {
	#name : #YurichevBookTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-Z3'
}

{ #category : #tests }
YurichevBookTest >> test2_2_1_int [
	| x y z s model |
	x := Int var: 'x'.
	y := Int var: 'y'.
	z := Int var: 'z'.
	s := Solver new.
	self flag: #todo. "make eq:1 work without toInt, make negated"
	s assert: ((3*x) + (2*y) - z eq: 1 toInt ).
	s assert: ((2*x) - (2*y) + (4*z) eq: -2 toInt ).
	s assert: (( -1 * x) "negated" + (y / 2 toInt) - z eq: 0 toInt ).
	self assert: s check.
	model := s getModel constants.
	self flag: #todo. "but constantsASTs fail to compare with 1"
	self assert: (model at: 'x') equals: '1'.
	self assert: (model at: 'y') equals: '(- 2)'.
	self assert: (model at: 'y') equals: '(- 2)'.

]

{ #category : #tests }
YurichevBookTest >> test2_2_1_intUnsat [
	| x y z s model |
	x := Int var: 'x'.
	y := Int var: 'y'.
	z := Int var: 'z'.
	s := Solver new.
	self flag: #todo. "make eq:1 work without toInt, make negated"
	s assert: ((3*x) + (2*y) - z eq: 1 toInt ).
	s assert: ((2*x) - (2*y) + (5*z) eq: -2 toInt ).
	s assert: (( -1 * x) "negated" + (y / 2 toInt) - z eq: 0 toInt ).
	self deny: s check.

]

{ #category : #tests }
YurichevBookTest >> test2_2_1_real [
	| x y z s model |
	true ifTrue: [^self flag: #todo]. "None of the Reals have been implemented yet."
	
	x := Real var: 'x'.
	y := Real var: 'y'.
	z := Real var: 'z'.
	s := Solver new.
	self flag: #todo. "make eq:1 work without toInt, make negated"
	s assert: ((3*x) + (2*y) - z eq: 1).
	s assert: ((2*x) - (2*y) + (4*z) eq: -2).
	s assert: (x negated + (0.5 * y) - z eq: 0).
	self assert: s check.
	model := s getModel constants.
	self flag: #todo. "but constantsASTs fail to compare with 1"
	self assert: (model at: 'x') equals: '1'.
	self assert: (model at: 'y') equals: '(- 2)'.
	self assert: (model at: 'y') equals: '(- 2)'.

]

{ #category : #tests }
YurichevBookTest >> test2_2_2 [
	| circle square triangle s model |
	circle := Int var: 'circle'.
	square := Int var: 'square'.
	triangle := Int var: 'triangle'.
	s := Solver new.
	self flag: #todo. "same remarks as for test2_2_1_int"
	s assert: (circle+circle eq: 10 toInt ).
	s assert: (circle * square + square eq: 12 toInt ).
	s assert: (circle*square - (triangle*circle) eq: circle).
	self assert: s check.
	model := s getModel constants.
	self assert: (model at: 'triangle') equals: '1'.
	self assert: (model at: 'square') equals: '2'.
	self assert: (model at: 'circle') equals: '5'.

]

{ #category : #tests }
YurichevBookTest >> testXKCD287_bv [
	| a b c d e f s model |
	true ifTrue: [^self flag: #todo].
	a := Int var: 'a'.
	b := Int var: 'b'.
	c := Int var: 'c'.
	d := Int var: 'd'.
	e := Int var: 'e'.
	f := Int var: 'f'.
	
	s := Solver new.
	s assert: ( (a*215) + (b*275) + (c*335) + (d*355) + (e*420) + (f*580) eq: 1505 toInt ).
	s assert: (a <= 10); assert: (a >= 0).
	s assert: (b <= 10); assert: (b >= 0).
	s assert: (c <= 10); assert: (c >= 0).
	s assert: (d <= 10); assert: (d >= 0).
	s assert: (e <= 10); assert: (e >= 0).
	s assert: (f <= 10); assert: (f >= 0).

	s assert: (a eq: 7 toInt).
	self assert: s check.
	
	model := s getModel constants.
	self assert: (model at: 'a') equals: '7'.
	self assert: (model at: 'b') equals: '0'.
	self assert: (model at: 'c') equals: '0'.
	self assert: (model at: 'd') equals: '0'.
	self assert: (model at: 'e') equals: '0'.
	self assert: (model at: 'f') equals: '0'.
"TODO: somehow, push/pop kills the VM here"
]

{ #category : #tests }
YurichevBookTest >> testXKCD287_int [
	"See also: https://stackoverflow.com/questions/141779/solving-the-np-complete-problem-in-xkcd
	Compare with:
	item(X) :- member(X,[215, 275, 335, 355, 420, 580]).
	solution([X|Y], Z) :- item(X), plus(S, X, Z), Z >= 0, solution(Y, S).
	solution([], 0).
	"
	| a b c d e f s model |
	a := Int var: 'a'.
	b := Int var: 'b'.
	c := Int var: 'c'.
	d := Int var: 'd'.
	e := Int var: 'e'.
	f := Int var: 'f'.
	
	s := Solver new.
	s assert: ( (a*215) + (b*275) + (c*335) + (d*355) + (e*420) + (f*580) eq: 1505 toInt ).
	s assert: (a <= 10); assert: (a >= 0).
	s assert: (b <= 10); assert: (b >= 0).
	s assert: (c <= 10); assert: (c >= 0).
	s assert: (d <= 10); assert: (d >= 0).
	s assert: (e <= 10); assert: (e >= 0).
	s assert: (f <= 10); assert: (f >= 0).

	s assert: (a eq: 7 toInt).
	self assert: s check.
	
	model := s getModel constants.
	self assert: (model at: 'a') equals: '7'.
	self assert: (model at: 'b') equals: '0'.
	self assert: (model at: 'c') equals: '0'.
	self assert: (model at: 'd') equals: '0'.
	self assert: (model at: 'e') equals: '0'.
	self assert: (model at: 'f') equals: '0'.
"TODO: somehow, push/pop kills the VM here"
]
