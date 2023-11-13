"
Examples from the excellent textbook by Denis Yurichev, ""SAT/SMT by Example"".
"
Class {
	#name : #YurichevBookTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Z3-Tests'
}

{ #category : #tests }
YurichevBookTest >> test2_2_1_int [
	| x y z s model |
	x := Int var: 'x'.
	y := Int var: 'y'.
	z := Int var: 'z'.
	s := Z3Solver new.
	self flag: #todo. "make eq:1 work without toInt, make negated"
	s assert: ((3*x) + (2*y) - z eq: 1 toInt ).
	s assert: ((2*x) - (2*y) + (4*z) eq: -2 toInt ).
	s assert: (( -1 * x) "negated" + (y / 2 toInt) - z eq: 0 toInt ).
	self assert: s check.
	model := s getModel constants.
	self flag: #todo. "but constantsASTs fail to compare with 1"
	self assert: (model at: 'x') equals: 1.
	self assert: (model at: 'y') equals: -2.
	self assert: (model at: 'y') equals: -2.
]

{ #category : #tests }
YurichevBookTest >> test2_2_1_intUnsat [
	| x y z s model |
	x := Int var: 'x'.
	y := Int var: 'y'.
	z := Int var: 'z'.
	s := Z3Solver new.
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
	s := Z3Solver new.
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
	s := Z3Solver new.
	self flag: #todo. "same remarks as for test2_2_1_int"
	s assert: (circle+circle eq: 10 toInt ).
	s assert: (circle * square + square eq: 12 toInt ).
	s assert: (circle*square - (triangle*circle) eq: circle).
	self assert: s check.
	model := s getModel constants.
	self assert: (model at: 'triangle') equals: 1.
	self assert: (model at: 'square') equals: 2.
	self assert: (model at: 'circle') equals: 5.
]

{ #category : #tests }
YurichevBookTest >> testDogCatMouse [
	| dogs cats mice s m |
	dogs := Int var: 'dogs'.
	cats := Int var: 'cats'.
	mice := Int var: 'mice'.
	s := Z3Solver new.
	"Total, in cents, must be 100,00"
	s assert: ((dogs*1500) + (cats*100) + (mice*25)
			eq: 10000 toInt).
	"Must buy 100 animals"
	s assert: (dogs+cats+mice eq: 100 toInt).
	"At least 1 of each"
	s assert: (dogs>0) & (cats>0) & (mice>0).

	self assert: s check.
	m := s getModel constants.
	
	self assert: (m at: 'dogs') equals: 3.
	self assert: (m at: 'cats') equals: 41.
	self assert: (m at: 'mice') equals: 56.
		
	"TODO: Use readable selectors (~=?) after merging 'equality'"
	s assert: (dogs eq: 3) not | (cats eq: 41) not | (mice eq: 56) not.
	self deny: s check.
	s del
]

{ #category : #tests }
YurichevBookTest >> testXKCD287_int [
	"See also: https://stackoverflow.com/questions/141779/solving-the-np-complete-problem-in-xkcd
	Compare with:
	item(X) :- member(X,[215, 275, 335, 355, 420, 580]).
	solution([X|Y], Z) :- item(X), plus(S, X, Z), Z >= 0, solution(Y, S).
	solution([], 0).
	"
	| a b c d e f s solutions sol1 sol2 |
	a := Int var: 'a'.
	b := Int var: 'b'.
	c := Int var: 'c'.
	d := Int var: 'd'.
	e := Int var: 'e'.
	f := Int var: 'f'.
	
	s := Z3Solver new.
	s assert: ( (a*215) + (b*275) + (c*335) + (d*355) + (e*420) + (f*580) eq: 1505 toInt ).
	s assert: (a <= 10); assert: (a >= 0).
	s assert: (b <= 10); assert: (b >= 0).
	s assert: (c <= 10); assert: (c >= 0).
	s assert: (d <= 10); assert: (d >= 0).
	s assert: (e <= 10); assert: (e >= 0).
	s assert: (f <= 10); assert: (f >= 0).

	solutions := s allSolutions.
	s del.
	self assert: solutions size equals: 2.
	
	"One solution with a=7, and the other one."
	sol1 := solutions detect: [ :aSol | (aSol constantsASTs at: 'a') = 7 ].
	sol2 := solutions detect: [ :aSol | (aSol constantsASTs at: 'a') ~= 7 ].
	

]
