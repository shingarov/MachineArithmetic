"
These tests correspond to L8uniqueVoid.smt2 on our experiment-z3datatypes
branch of liquid-fixpoint, see dbd390e:
https://github.com/shingarov/liquid-fixpoint/commit/dbd390e323a96f5c973c5bd6285a10b066340b0b
at the lowest (SMT) level of the test-ladder, cf:
https://github.com/shingarov/sprite-lang/commit/248f59b7758befa7a812b1981b43999a8c45adb6

"
Class {
	#name : #Z3DatatypeTest,
	#superclass : #TestCase,
	#category : #'Z3-Tests-ADT'
}

{ #category : #'mock objects' }
Z3DatatypeTest >> D [
	"Create a datatype D:
		| A of int
		| B of int
	"
	| constrA constrB D |
	constrA := Z3Constructor name: 'A' recognizer: 'is_A' fields: {'argA'->Int sort} referencing: #(0).
	constrB := Z3Constructor name: 'B' recognizer: 'is_B' fields: {'argB'->Int sort} referencing: #(0).
	D := Z3DatatypeSort name: 'D' constructors: { constrA. constrB }.
	constrA delete.
	constrB delete.
	^D
]

{ #category : #tests }
Z3DatatypeTest >> testIs_always [
	| D d |
	D := self D.
	d := (D constructorNamed: 'A') value: 'd'.
	self assert: (d is: 'A') isValid.
]

{ #category : #tests }
Z3DatatypeTest >> testIs_malformed [
	| D x |
	"Asking a D (which is A|B) whether it's a C is ill form"
	D := self D.
	x := (D constructorNamed: 'A') value: 'x'.
	self should: [x is: 'C'] raise: Error
]

{ #category : #tests }
Z3DatatypeTest >> testIs_never [
	| D d |
	D := self D.
	d := (D constructorNamed: 'A') value: 'd'.
	self assert: (d is: 'B') not isValid.
]

{ #category : #tests }
Z3DatatypeTest >> testIs_sometimes [
	| D a b expr theorem solver model |

	"Construct a D which is an A if x>=0, B otherwise"
	D := self D.
	a := (D constructorNamed: 'A') value: 'a'.
	b := (D constructorNamed: 'B') value: 'b'.
	expr := 'x' toInt >=0 ifThen: a else: b.
	"Find a counterexample showing d is not always an A"
	theorem := expr is: 'A'.
	solver := theorem ctx mkSolver.
	model := solver findCounterexample: theorem.
	solver release.
	self assert: (model constants at: 'x') < 0
]

{ #category : #tests }
Z3DatatypeTest >> testReferenceExistingDatatype [
	| nilCon void void2 |
	self skip. "BOGUS"
	nilCon := Z3Constructor name: 'nil' recognizer: 'is_nil' fields: #() referencing: #().
	void := Z3DatatypeSort name: 'void' constructors: {nilCon}.
	nilCon delete.
	void2 := void ctx mkDatatypeSort: 'void'.
	self assert: void2 == void
]

{ #category : #tests }
Z3DatatypeTest >> testUniqueIntegerNeg [
	"ℤ has more than one element, therefore two arbitrary
	 integers aren't necessarily equal."
	| V x y |
	V := Int sort.
	x := V mkConst: 'x'.
	y := V mkConst: 'y'.
	self deny: (x===y) isValid
]

{ #category : #tests }
Z3DatatypeTest >> testUniqueVoid [
	"The datatype 'void', being the terminal object,
	 speaking set-theoretically has only one element.
	 Therefore any inhabitants of 'void' are the same."
	| nilCon void x y |
	nilCon := Z3Constructor name: 'nil' recognizer: 'is_nil' fields: #() referencing: #().
	void := Z3DatatypeSort name: 'void' constructors: {nilCon}.
	nilCon delete.
	x := void mkConst: 'x'.
	y := void mkConst: 'y'.
	self assert: (x===y) isValid
]

{ #category : #tests }
Z3DatatypeTest >> testUniqueVoidNeg [
	"If void had more than one constructor, then we
	 could no longer prove all inhabitants to be the same."
	| aCon bCon void x y |
	aCon := Z3Constructor name: 'a' recognizer: 'is_a' fields: #() referencing: #().
	bCon := Z3Constructor name: 'b' recognizer: 'is_b' fields: #() referencing: #().
	void := Z3DatatypeSort name: 'void' constructors: {aCon.bCon}.
	aCon delete.
	bCon delete.
	x := void mkConst: 'x'.
	y := void mkConst: 'y'.
	self deny: (x===y) isValid
]

{ #category : #tests }
Z3DatatypeTest >> testUniqueVoidNeg2 [
	"If void's constructor took an argument, then we
	 could no longer prove all inhabitants to be the same."
	| nilCon void x y |
	nilCon := Z3Constructor name: 'nil' recognizer: 'is_nil' fields: {'arg'->Int sort} referencing: #(0).
	void := Z3DatatypeSort name: 'void' constructors: {nilCon}.
	nilCon delete.
	x := void mkConst: 'x'.
	y := void mkConst: 'y'.
	self deny: (x===y) isValid
]
