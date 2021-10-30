Class {
	#name : #SimpleZ3Test,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-SMT'
}

{ #category : #tests }
SimpleZ3Test >> shapesBV: mod [
	| c t s q a solver model hasOtherSolutions |
	c := 'circle'    ///mod.
	t := 'triangle'  ///mod.
	s := 'star'      ///mod.
	q := 'square'    ///mod.
	a := '?'         ///mod.
	solver := Z3Solver new.
	solver 
    assert: ( c + t eq: 8);
    assert: ( s - q eq: q);
    assert: ( c - t eq: 4);
    assert: ( q + s eq: 12);
    assert: ( t + c + s + q eq: a);

	 assert: (a eq: 20) not.
	
	hasOtherSolutions := solver check.
	model := hasOtherSolutions ifTrue: [ solver getModel constants ] ifFalse: [ nil ].
	solver del.
	^model
]

{ #category : #tests }
SimpleZ3Test >> test0lt1 [
	| solver bvSort zero one thm |
	solver := Z3Solver new.
	bvSort := Z3Sort bv: 32.
	zero := Z3AST numeral: '0' ofSort: bvSort.
	one := Z3AST numeral: '1' ofSort: bvSort.
	thm := zero <= one.
	solver prove: thm isValid: true.
	solver del.
]

{ #category : #tests }
SimpleZ3Test >> testAllBoolSortHandlesAreSame [
	| boolSort1 boolSort2 |
	boolSort1 := Z3Sort bool.
	boolSort2 := Z3Sort bool.
	self assert: boolSort1 handle value equals: boolSort2 handle value
]

{ #category : #tests }
SimpleZ3Test >> testAllBoolSortsAreSame [
	| boolSort1 boolSort2 |
	boolSort1 := Z3Sort bool.
	boolSort2 := Z3Sort bool.
	self assert: boolSort1 == boolSort2
]

{ #category : #tests }
SimpleZ3Test >> testAllIntSortsAreSame [
	| s t |
	s := Z3Sort int.
	t := Z3Sort int.
	self assert: s = t.
	self assert: s == t.

]

{ #category : #tests }
SimpleZ3Test >> testAllSolutions [
	| x s models xs |
	x := 'x' toInt.
	s := Z3Solver new.
	s assert: x > 0.
	s assert: x < 3.
	models := s allSolutions.
	xs := models collect: [ :m | (m constantsASTs at: 'x') value ].
	self assert: xs asSet equals: { 1. 2. } asSet
]

{ #category : #tests }
SimpleZ3Test >> testAnyArray [
	| regbankSort |
	regbankSort := BitVector///5 --> (BitVector///32).
	self assert: regbankSort anyOne sort == regbankSort 
	

]

{ #category : #tests }
SimpleZ3Test >> testArrayUpdate [
	| a i v newArray updatedV solver j |
	a := McCarthyArray name: 'a' domain: Z3Sort int range: Z3Sort int.
	i := Int const: 'i'.
	v := Int const: 'v'.
	self assert: a sort astToString equals: '(Array Int Int)'.
	newArray := a arrayStore: i put: v.
	self assert: newArray sort astToString equals: '(Array Int Int)'.
	self assert: newArray astToString equals: '(store a i v)'.
	
	"the element at index updated correctly"
	updatedV := newArray arraySelect: i.
	solver := Z3Solver new.
	solver proveValid: (updatedV eq: v).
	solver del.
	
	"all other elements sit where they were"
	j := Int const: 'j'.
	solver := Z3Solver new.
	solver proveValid:
		(i eq: j) not 
		==>
		((newArray arraySelect: j) eq: (a arraySelect: j)).
	solver del
	
	

]

{ #category : #tests }
SimpleZ3Test >> testBVSortSize [
	| bvSort |
	bvSort := Z3Sort bv: 32.
	self assert: bvSort length equals: 32.
	self assert: bvSort printString equals: 'Z3Sort bv:32'

]

{ #category : #tests }
SimpleZ3Test >> testBVSplusBVStypeTheory [
	| bvSort x y sum |
	bvSort := Z3Sort bv: 32.
	x := Z3AST var: 'x' ofSort: bvSort.
	y := Z3AST var: 'y' ofSort: bvSort.
	sum := x - y.
	self assert: sum isBitVector.
	self assert: sum length = 32.
	self assert: sum sort length = 32.
	self assert: sum functorName equals: 'bvsub'.

]

{ #category : #tests }
SimpleZ3Test >> testBitvectorCounterexample [
	| solver bvSort x zero ten thm result model |
	solver := Z3Solver new.
	bvSort := Z3Sort bv: 32.
	x := Z3AST var: 'x' ofSort: bvSort.
	zero := Z3AST numeral: '0' ofSort: bvSort.
	ten := Z3AST numeral: '10' ofSort: bvSort.
	thm := x <= ten iff: x - ten < zero.
	result := solver assert: (thm not); check.
	self assert: result.
	model := solver getModel.
	"Just check that it gives us *some* counter example"
	self assert: (model toString beginsWith: 'x -> #').
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testBitvectorVariable [
	| bvSort x |
	bvSort := Z3Sort bv: 32.
	x := Z3AST var: 'x' ofSort: bvSort.
	self assert: x isConstant.
	self assert: x functorName equals: 'x'

]

{ #category : #tests }
SimpleZ3Test >> testBlockModel [
	| x s oneX anotherX |
	x := 'x' toInt.
	s := Z3Solver new.
	s assert: x > 0.
	s assert: x < 3.
	self assert: s check.
	oneX := s getModel eval: x completion: true.
	s blockModel.
	self assert: s check.
	anotherX := s getModel eval: x completion: true.
	s blockModel.
	self deny: s check.
	self assert: { oneX value. anotherX value } asSet
			equals: { 1. 2. } asSet
]

{ #category : #tests }
SimpleZ3Test >> testBoundVar [
	| x |
	x := Z3Sort int mkBound: 100.
	self assert: x astToString equals: '(:var 100)'
]

{ #category : #tests }
SimpleZ3Test >> testCreateArray [
	| a |
	a := Z3Sort int --> Z3Sort bool.
	self assert: a astToString equals: '(Array Int Bool)'
]

{ #category : #tests }
SimpleZ3Test >> testEmptySet [
	| set elementSort x solver |
	elementSort := Z3Sort int.
	set := McCarthyArray emptySetOf: elementSort.
	self assert: set canBeSet.
	self assert: set sort domain equals: elementSort.
	self assert: set sort class equals: Z3ArraySort.
	self assert: set sort nodeClass equals: McCarthyArray.
	
	"Now the interesting part:
	prove that no element belongs to the empty set"
	x := 'x' toInt.
	solver := Z3Solver new.
	solver proveValid: ((set includes: x) not forall: x).
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testEvenOdd [
	| x solver |
	x := 'x' toInt.
	solver := Z3Solver new.
	solver proveValid: x even ==> (x+1) odd.
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testForAll [
	| a x prop solver |
	a := 'a' toInt.
	x := 'x' toInt.
	prop := (a+x eq: x) forall: x.
	solver := Z3Solver new.
	[solver proveValid: prop] on: NotValid do: [ :ex | self deny: (ex counterexample constantsASTs at: 'a') value = 0. ^solver del ].
	self error
]

{ #category : #tests }
SimpleZ3Test >> testFullSet [
	| set elementSort |
	elementSort := Z3Sort int.
	set := McCarthyArray fullSetOf: elementSort.
	self assert: set canBeSet.
	self assert: set sort domain equals: elementSort.
	self assert: set sort class equals: Z3ArraySort.
	self assert: set sort nodeClass equals: McCarthyArray.
]

{ #category : #tests }
SimpleZ3Test >> testFuncDeclArity [
	| f |
	f := 'f' functionFrom: { Z3Sort int . Z3Sort int } to: Z3Sort int.
	self assert: f arity equals: 2
]

{ #category : #tests }
SimpleZ3Test >> testFunctionality [
	| f x y fml solver |
	f := 'f' functionFrom: {Z3Sort int} to: Z3Sort int.
	x := 'x' toInt.
	y := 'y' toInt.
	fml := (x eq: y) ==> ((f value: x) eq: (f value: y)).
	solver := Z3Solver new.
	solver proveValid: fml.
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testFuntionArgs [
	| x y sum |
	x := Int var: 'x'.
	y := Int var: 'y'.
	sum := x + y.
	self assert: sum isInt.
	self assert: sum isApp.
	self assert: sum arity equals: 2.
	self assert: sum functorName equals: '+'.
	self deny: sum isConstant.
	self assert: (sum argAt: 1) equals: x.
	self assert: (sum argAt: 2) equals: y

]

{ #category : #tests }
SimpleZ3Test >> testIntPlusIntTypeTheory [
	| x y sum |
	x := Int var: 'x'.
	y := Int var: 'y'.
	sum := x + y.
	self assert: sum isInt.
	self assert: sum isApp.
	self assert: sum arity equals: 2.
	self assert: sum functorName equals: '+'.
	self deny: sum isConstant.
	self assert: (sum argAt: 1) equals: x.
	self assert: (sum argAt: 2) equals: y

]

{ #category : #tests }
SimpleZ3Test >> testIntVector [
	| ints |
	ints := Int create: 3 constantsPrefix: 'x'.
	self assert: ints first sym equals: 'x__1'
]

{ #category : #tests }
SimpleZ3Test >> testIsValid [
	| x solver |
	x := 'x' toInt.
	solver := Z3Solver new.
	self assert: (solver isValid: x even | x odd).
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testMixedTheories [
	"A not-totally-trivial mix of Z, uninterpreted functions, and McCarty arrays,
	 given in Bjorner's 'Programming Z3'.
	"
	| f x y z A fml solver |
	f := 'f' functionFrom: {Z3Sort int} to: Z3Sort int.
	x := 'x' toInt.
	y := 'y' toInt.
	z := 'z' toInt.
	A := Z3Sort int --> Z3Sort int mkConst: 'A'.
	fml := (x+2 eq: y) ==>
		(  (f value: ((A arrayStore: x put: 3 toInt) arraySelect: x))
		     eq:
		   (f value: y-x+1)
		).
	solver := Z3Solver new.
	solver proveValid: fml.
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testNonBVSortSize [
	| nonbvSort |
	nonbvSort := Z3Sort bool.
	self should: [nonbvSort length] raise: Error

]

{ #category : #tests }
SimpleZ3Test >> testParameterSet [
	| p sym |
	p := Z3ParameterSet new.
	sym := Z3Symbol from: 'DoReMi'.
	p at: sym putUint: 42.
	p paramsToString.
	self flag: #todo "not sure why paramsToString doesnt reflect DoReMi"
]

{ #category : #tests }
SimpleZ3Test >> testProveNotValid [
	| solver p thm counterexample |
	solver := Z3Solver new.
	p := Bool var: 'p'.
	thm := p.
	counterexample := solver proveNotValid: thm.
	self assert: (counterexample constants at: 'p') equals: 'false'.
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testProveNotValidFail [
	| solver p thm |
	solver := Z3Solver new.
	p := Bool var: 'p'.
	thm := p | p not.
	self should: [ solver proveNotValid: thm ]
		raise: NotInvalid.
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testSelect [
	| solver a x assumption propositions selected |
	a := 'a' toInt.
	x := 'x' toInt.
	solver := Z3Solver new.
	assumption := a > 0.
	propositions := {
		a+1 > 0.  "this follows from the assumption"
		x > 0.  "this doesn't follow from the assumption"
	}.
	selected := propositions selectAssuming: assumption in: solver.
	self assert: (selected includes: propositions first).
	self deny:   (selected includes: propositions second).	
	
]

{ #category : #tests }
SimpleZ3Test >> testSelectFromDictionary [
	| solver a x assumption propositions selected |
	a := 'a' toInt.
	x := 'x' toInt.
	solver := Z3Solver new.
	assumption := a > 0.
	propositions := Dictionary new
		at: #good put: (a+1 > 0);  "this follows from the assumption"
		at: #bad  put: (x > 0);  "this doesn't follow from the assumption"
		yourself.

	selected := propositions selectAssuming: assumption in: solver.
	self assert: selected keys equals: #(good)
]

{ #category : #tests }
SimpleZ3Test >> testSendMoreMoney [
	| solver vars s e n d m o r y model |
	solver := Z3Solver new.
	vars := #(s e n d m o r y) collect: [ :x |
		Int var: x asString ].

	s := vars at: 1.  	e := vars at: 2.
	n := vars at: 3.  	d := vars at: 4.
	m := vars at: 5.  	o := vars at: 6.
	r := vars at: 7.  	y := vars at: 8.
	
	vars do: [ :x | 	solver assert: (x >= 0); assert: (x <= 9) ].
	solver assert: (m eq: 0) not.
	solver assert: (solver ctx mkDistinct: vars).
	solver assert: (
		d + (n*10) + (e*100) + (s*1000) "SEND"
		+ e + (r*10) + (o*100) + (m*1000) "MORE"
		eq:
		y + (e*10) + (n*100) + (o*1000) + (m*10000) "MONEY"
		).
	self assert: solver check.
	model := solver getModel constants.
	self assert: (model at: 'y')	 equals: '2'.	
	self assert: (model at: 'd')	 equals: '7'.
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testSetAdd [
	| set newSet elementSort x solver |
	elementSort := Z3Sort int.
	set := McCarthyArray emptySetOf: elementSort.
	self assert: set canBeSet.
	newSet := set add: 1.

	self deny: (set includes: 1).
	self assert: (newSet includes: 1).
	self deny: (newSet includes: 2).
	
	"Now the interesting part:
	fail to prove that no element belongs to {1}."
	x := 'x' toInt.
	solver := Z3Solver new.
	[ solver proveValid: ((newSet includes: x) not forall: x) ]
		on: NotValid 
		do: [ :ex |
			"but the model doesn't contain an interesting x"
			^solver del
	].
	self assert: false



]

{ #category : #tests }
SimpleZ3Test >> testSetComplement [
	| set elementSort |
	elementSort := Z3Sort int.
	set := McCarthyArray emptySetOf: elementSort.
	self assert: set canBeSet.
	set := set add: 1.
	self assert: (set complement includes: 2).
	self deny: (set complement includes: 1).
]

{ #category : #tests }
SimpleZ3Test >> testSetRemove [
	| set elementSort |
	elementSort := Z3Sort int.
	set := McCarthyArray emptySetOf: elementSort.
	self assert: set canBeSet.
	set := set add: 1.
	self assert: (set includes: 1).
	set := set remove: 1.
	self deny: (set includes: 1).
]

{ #category : #tests }
SimpleZ3Test >> testShapesBV [
	| mod |
	mod := (1 to: 64) detect: [ :modulus | (self shapesBV: modulus) notNil ] ifNone: [ ^self ].
	self assert: false
]

{ #category : #tests }
SimpleZ3Test >> testShapesN [
	| c t s q a solver model |
	c := 'circle' toInt.
	t := 'triangle' toInt.
	s := 'star' toInt.
	q := 'square' toInt.
	a := '?' toInt.
	solver := Z3Solver new.
	solver 
    assert: ( c + t eq: 8);
    assert: ( s - q eq: q);
    assert: ( c - t eq: 4);
    assert: ( q + s eq: 12);
    assert: ( t + c + s + q eq: a).
	self assert: solver check.
	model := solver getModel constants.
	self assert: (model at: '?')	 equals: '20'.	
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testSimplifyContradiction [
	| x expr f |
	x := Z3Context current mkBoolVar: 'x'.
	expr := x & x not.
	f := expr simplify.
	self assert: f astToString equals: 'false'.
]

{ #category : #tests }
SimpleZ3Test >> testSimplifyInt [
	| x two expr zero |
	x := Z3Context current mkIntVar: 'x'.
	two := Z3Context current mkInt: 2.
	expr := x * two - x - x.
	zero := expr simplify.
	self assert: zero astToString equals: '0'
]

{ #category : #tests }
SimpleZ3Test >> testSimplifyTautology [
	| x expr f |
	x := Z3Context current mkBoolVar: 'x'.
	expr := x | x not.
	f := expr simplify.
	self assert: f astToString equals: 'true'
]

{ #category : #tests }
SimpleZ3Test >> testSmallExample [
	"Trivial sanity check, borrowed from the top of z3.py"
	| x y s m one |
	x := Int const: 'x'.
	y := Int const: 'y'.
	s := Z3Solver new.
	s assert: x > 0.
	s assert: x < 2.
	s assert: (y eq: x + 1).
	self assert: s check.
	m := s getModel.
	one := m at: x.
	self assert: one isInt.
	self assert: one value = 1.
	s del
]

{ #category : #tests }
SimpleZ3Test >> testSolverForLogic [
	| solver |
	solver := Z3Solver for: 'QF_LIA'.
	self assert: solver assertions contents isEmpty
]

{ #category : #tests }
SimpleZ3Test >> testSplitNoOverlap [
	| x y solver m |
	x := 'x'///16.
	y := 'y'///16.
	solver := Z3Solver new.
	solver assert: (x,y eq: 16r12345678).
	self assert: solver check.
	m := solver getModel constantsASTs.
	self assert: (m at: 'x') equals: 16r1234.
	self assert: (m at: 'y') equals: 16r5678.
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testTernaryApp [
	| f fxyz |
	f := 'f' functionFrom: { Int sort. Int sort. Int sort } to: Int sort.
	fxyz := f value: 'x' toInt value: 'y' toInt value: 'z' toInt.
	self assert: fxyz astToString equals: '(f x y z)'.

	self assert: fxyz isApp.
	self assert: fxyz arity equals: 3.
	self assert: fxyz args size equals: 3.
	self assert: fxyz args first isInt.
	self assert: fxyz functorName equals: 'f'.

]

{ #category : #tests }
SimpleZ3Test >> testZ3IntSymbol [
	| sym |
	sym := Z3Symbol from: 42.
	self assert: sym getInt equals: 42
]
