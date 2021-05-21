Class {
	#name : #SimpleZ3Test,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests'
}

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
SimpleZ3Test >> testFuncDeclArity [
	| f |
	f := 'f' functionFrom: { Z3Sort int . Z3Sort int } to: Z3Sort int.
	self assert: f arity equals: 2
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
SimpleZ3Test >> testNonBVSortSize [
	| nonbvSort |
	nonbvSort := Z3Sort bool.
	self should: [nonbvSort length] raise: Error

]

{ #category : #tests }
SimpleZ3Test >> testParameterSet [
	| p sym |
	p := Z3ParameterSet on: Z3Context current.
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
	fxyz := f app: { 'x' toInt. 'y' toInt. 'z' toInt }.
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
