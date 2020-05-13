Class {
	#name : #SimpleZ3Test,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-Z3'
}

{ #category : #tests }
SimpleZ3Test >> test0lt1 [
	| solver bvSort zero one thm |
	solver := Solver new.
	bvSort := Z3Sort bv: 32.
	zero := AST numeral: '0' ofSort: bvSort.
	one := AST numeral: '1' ofSort: bvSort.
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
	self assert: s == t
]

{ #category : #tests }
SimpleZ3Test >> testBVSortSize [
	| bvSort |
	bvSort := Z3Sort bv: 32.
	self assert: bvSort getBVSortSize equals: 32.
	self assert: bvSort printString equals: 'BV32'
]

{ #category : #tests }
SimpleZ3Test >> testBVSplusBVStypeTheory [
	| bvSort x y sum |
	bvSort := Z3Sort bv: 32.
	x := AST var: 'x' ofSort: bvSort.
	y := AST var: 'y' ofSort: bvSort.
	sum := x - y.
	self assert: sum sort printString equals: 'BV32'.
	self assert: sum term functorName equals: 'bvsub'.

]

{ #category : #tests }
SimpleZ3Test >> testBitvectorCounterexample [
	| solver bvSort x zero ten thm result model |
	solver := Solver new.
	bvSort := Z3Sort bv: 32.
	x := AST var: 'x' ofSort: bvSort.
	zero := AST numeral: '0' ofSort: bvSort.
	ten := AST numeral: '10' ofSort: bvSort.
	thm := x <= ten iff: x - ten < zero.
	result := solver assert: (thm not); check.
	self assert: result.
	model := solver getModel.
	self assert: (model toString beginsWith: 'x -> #x0000000a').
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testBitvectorVariable [
	| bvSort x xKind |
	bvSort := Z3Sort bv: 32.
	x := AST var: 'x' ofSort: bvSort.
	xKind := x term. "function application"
	self assert: xKind isConstant.
	self assert: xKind functorName equals: 'x'
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
SimpleZ3Test >> testFuntionArgs [
	| x y sum sumAPP |
	x := Int var: 'x'.
	y := Int var: 'y'.
	sum := x + y.
	self assert: sum sort getASTClass equals: Int.
	sumAPP := sum term.
	self assert: sumAPP arity equals: 2.
	self assert: sumAPP functorName equals: '+'.
	self deny: sumAPP isConstant.
	self assert: (sumAPP argAt: 1) equals: x.
	self assert: (sumAPP argAt: 2) equals: y

]

{ #category : #tests }
SimpleZ3Test >> testIntPlusIntTypeTheory [
	| x y sum sumAPP |
	x := Int var: 'x'.
	y := Int var: 'y'.
	sum := x + y.
	self assert: sum sort getASTClass equals: Int.
	sumAPP := sum term.
	self assert: sumAPP arity equals: 2.
	self assert: sumAPP functorName equals: '+'.
	self deny: sumAPP isConstant.
	self assert: (sumAPP argAt: 1) equals: x.
	self assert: (sumAPP argAt: 2) equals: y

]

{ #category : #tests }
SimpleZ3Test >> testNonBVSortSize [
	| nonbvSort |
	nonbvSort := Z3Sort bool.
	self should: [nonbvSort getBVSortSize] raise: Error
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
	solver := Solver new.
	p := Bool var: 'p'.
	thm := p.
	counterexample := solver proveNotValid: thm.
	self assert: (counterexample constants at: 'p') equals: 'false'.
	solver del
]

{ #category : #tests }
SimpleZ3Test >> testProveNotValidFail [
	| solver p thm |
	solver := Solver new.
	p := Bool var: 'p'.
	thm := p | p not.
	self should: [ solver proveNotValid: thm ]
		raise: NotInvalid.
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
