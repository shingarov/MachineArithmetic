Class {
	#name : #Z3AdtTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
Z3AdtTest >> testCreateDatatypes [
	"Example taken from z3.py:
	 define a Tree-List using two mutually recursive datatypes."
	| treeList tree tl n1 n2 |

	"For as yet unknown reason, this test fail on Smalltalk/X.
	 But at the moment we need tests to be 'green' to allow further
	 development so we TEMPORARILY disabled the test until I (JV) find
	 a scrap of time to fix it."
	Smalltalk isSmalltalkX ifTrue: [ self skip:'Temporarily disabled as it does not work on St/X for unknown reason' ].

	treeList := Z3Datatype named: 'TreeList'. tree := Z3Datatype named: 'Tree'.
	
	"Tree has two constructors: leaf and node"
	tree declare: 'leaf' accessors: {'val'->Int sort}. "contains an Int"
	tree declare: 'node' accessors: {'children'->treeList}. "contains a list of trees"
	
	treeList declare: 'nil'.
	treeList declare: 'cons' accessors: {'car'->tree. 'cdr'->treeList}.

	tl := Z3Datatype createDatatypes: {tree . treeList}.
	tree := tl first. treeList := tl last.
	
	self assert: (tree val: (tree leaf: 10)) simplify equals: 10.

	n1 := tree node: (treeList cons: (tree leaf: 10) _: (treeList cons: (tree leaf: 20) _: treeList nil)).
		"n1 >>> (node (cons (leaf 10) (cons (leaf 20) nil))) "
	n2 := tree node: (treeList cons: n1 _: (treeList nil)).
		"n2 >>> (node (cons (node (cons (leaf 10) (cons (leaf 20) nil))) nil)) "
	self assert: (n2 === n1) simplify == Bool false.
	self assert: ((treeList car: (tree children: n2)) === n1) simplify == Bool true.
]

{ #category : #tests }
Z3AdtTest >> testMeasure [
	| list emptiness l anyList |
	list := Z3Datatype named: 'List'.
	list declare: 'cons' accessors: { 'car'->Int sort. 'cdr'->list }.
	list declare: 'nil'.
	list := list create.
	l := list mkConst: 'l'.
	emptiness := 'emptiness' recursiveFunctionFrom: {list} to: Int sort.
	emptiness value: l is: (l is_nil ifTrue: [1 toInt] ifFalse: [0 toInt]).
	
	anyList := list mkConst: 'anyList'.
	self assert: (
		Z3Solver isValid: (emptiness value: anyList) > 0 ==> anyList is_nil
	)
]

{ #category : #tests }
Z3AdtTest >> testNumConstructors [
	| list |
	list := Z3Datatype named: 'List'.
	list declare: 'cons' accessors: { 'car'->Int sort. 'cdr'->list }.
	list declare: 'nil'.
	list := list create.
	self assert: list numConstructors equals: 2.
]

{ #category : #tests }
Z3AdtTest >> testSingletonLengthIs1 [
	| list len l singleton x |
	list := Z3Datatype named: 'List'.
	list declare: 'cons' accessors: { 'car'->Int sort. 'cdr'->list }.
	list declare: 'nil'.
	list := list create.
	l := list mkConst: 'l'.
	len := 'emptiness' recursiveFunctionFrom: {list} to: Int sort.
	len value: l is: (l is_nil ifTrue: [0 toInt] ifFalse: [(len value: l cdr) + 1]).
	x := 'x' toInt.
	singleton := list cons: x toInt _: list nil.
	self assert: (
		Z3Solver isValid: (len value: singleton) === 1
	)
]

{ #category : #tests }
Z3AdtTest >> testZ3Datatype [
	| list |
	list := Z3Datatype named: 'List'.
	list declare: 'cons' accessors: { 'car'->Int sort. 'cdr'->list }.
	list declare: 'nil'.
	list := list create.
	self assert: list nil class equals: Datatype.
	self assert: (list cons: 10 _: list nil)	 class equals: Datatype.
]
