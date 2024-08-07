Class {
	#name : #Z3TreeDatatypeTest,
	#superclass : #TestCaseWithZ3Context,
	#instVars : [
		'cell',
		'nilCon',
		'consCon'
	],
	#category : #'Z3-Tests-ADT'
}

{ #category : #tests }
Z3TreeDatatypeTest >> setUp [
	super setUp.
	cell := Z3Datatype named: 'cell'.
	cell declare: 'nil'.
	cell declare: 'cons' accessors: { 'car'->cell. 'cdr'->cell }.
	cell := cell create.
	self assert: cell numConstructors equals: 2.
	nilCon  := cell constructor: 0.
	consCon := cell constructor: 1.
]

{ #category : #tests }
Z3TreeDatatypeTest >> testAlwaysSomething [
	| u isNil isCons |
	"is_nil(u) or is_cons(u)"
	u := cell mkConst: 'u'.
	isNil  := cell is_nil: u.
	isCons := cell is_cons: u.
	self assert: (Z3Solver isValid: isNil | isCons)
]

{ #category : #tests }
Z3TreeDatatypeTest >> testCongruence [
	"cons(x,u) = cons(x, v) => u = v"
	| l1 l2 x y u v |
	x := cell mkConst: 'x'.  y := cell mkConst: 'y'.
	u := cell mkConst: 'u'.  v := cell mkConst: 'v'.
	l1 := cell cons: x _: u.
	l2 := cell cons: y _: v.
	self assert: (Z3Solver isValid: (l1===l2) ==> (x===y)).
	self assert: (Z3Solver isValid: (l1===l2) ==> (u===v)).
]

{ #category : #tests }
Z3TreeDatatypeTest >> testDestructors [
	"destructors: is_cons(u) => u = cons(car(u),cdr(u))"
	| u fml1 fml |
	u := cell mkConst: 'u'.
	fml1 := u === (cell cons: (cell car: u) _: (cell cdr: u)).
	self deny: (Z3Solver isValid: fml1). "by itself, fml1 does not always hold"
	fml := (cell is_cons: u) ==> fml1.
	self assert: (Z3Solver isValid: fml). "but for cells that are cons cells, it's valid"
]

{ #category : #tests }
Z3TreeDatatypeTest >> testNilNotCons [
	"nil != cons(nil, nil)"
	| nilCell l1 |
	nilCell := cell nil new.
	l1 := cell cons with: nilCell with: nilCell.
	self assert: (Z3Solver isValid: (nilCell===l1) not).

]

{ #category : #tests }
Z3TreeDatatypeTest >> testOccursCheck [
	"occurs check u != cons(x,u)"
	| x u l1 |
	x := cell mkConst: 'x'.
	u := cell mkConst: 'u'.
	l1 := cell cons: x _: u.
	self assert: (Z3Solver isValid: (u===l1) not)
]
