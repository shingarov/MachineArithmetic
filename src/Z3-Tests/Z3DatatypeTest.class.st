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

{ #category : #running }
Z3DatatypeTest >> testUniqueIntegerNeg [
	"ℤ has more than one element, therefore two arbitrary
	 integers aren't necessarily equal."
	| V x y |
	V := Int sort.
	x := V mkConst: 'x'.
	y := V mkConst: 'y'.
	self deny: (x===y) isValid
]

{ #category : #running }
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

{ #category : #running }
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

{ #category : #running }
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
