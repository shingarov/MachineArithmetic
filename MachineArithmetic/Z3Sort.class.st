Class {
	#name : #Z3Sort,
	#superclass : #Z3AST,
	#pools : [
		'Z3ASTKind',
		'Z3SortKind'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3Sort class >> bool [
	^self boolSortOn: Z3Context current 
]

{ #category : #'instance creation' }
Z3Sort class >> boolSortOn: aZ3Context [
	^Z3 mk_bool_sort: aZ3Context

]

{ #category : #'instance creation' }
Z3Sort class >> bv: sz [
	^self bvSort: sz on: Z3Context current
]

{ #category : #'instance creation' }
Z3Sort class >> bvSort: sz on: ctx [
	^ Z3 mk_bv_sort: ctx _: sz

]

{ #category : #private }
Z3Sort class >> classForSortKind: sortKind [

	sortKind = UNINTERPRETED_SORT ifTrue: [ ^ Z3UninterpretedSort ].
	sortKind = BOOL_SORT ifTrue: [ ^ Z3BoolSort ].
	sortKind = INT_SORT ifTrue: [ ^ Z3IntSort ].
	sortKind = REAL_SORT ifTrue: [ ^ Z3RealSort ].
	sortKind = BV_SORT ifTrue: [ ^ Z3BitVectorSort ].
	sortKind = ARRAY_SORT ifTrue: [ ^ Z3ArraySort ].
	sortKind = DATATYPE_SORT ifTrue: [ ^ Z3DatatypeSort ].

	self error: '(Yet) unsupported sort kind: ' , sortKind printString             

]

{ #category : #'instance creation' }
Z3Sort class >> fromExternalAddress: anExternalAddress inContext: aZ3Context [
	| class |

	self assert: self == Z3Sort 
		 description: 'Attempting to instantiate sort subclass directly'.
	self assert: (Z3 get_ast_kind: aZ3Context _: anExternalAddress) == SORT_AST
		 description: 'Attempting to instantiate sort for something that is not a sort'.

	class := self classForSortKind: (Z3 get_sort_kind: aZ3Context _: anExternalAddress).
	^ aZ3Context internAST: class address: anExternalAddress.

]

{ #category : #'instance creation' }
Z3Sort class >> int [
	^self intSortOn: Z3Context current
]

{ #category : #'instance creation' }
Z3Sort class >> intSortOn: aZ3Context [
	^Z3 mk_int_sort: aZ3Context

]

{ #category : #'instance creation' }
Z3Sort class >> real [
	^self realSortOn: Z3Context current
]

{ #category : #'instance creation' }
Z3Sort class >> realSortOn: aZ3Context [
	^Z3 mk_real_sort: aZ3Context

]

{ #category : #'instance creation' }
Z3Sort class >> uninterpretedSortNamed: aName [
	^(Z3Symbol from: aName) mkUninterpretedSort
]

{ #category : #'instance creation' }
Z3Sort class >> uninterpretedSortNamed: aName on: aZ3Context [
	self shouldBeImplemented 
]

{ #category : #'type theory' }
Z3Sort >> --> range [
	^ Z3 mk_array_sort: ctx _: self _: range

]

{ #category : #'type theory' }
Z3Sort >> ==> rangeSort [
	^Z3Symbol new mkFuncFrom: {self} to: rangeSort

]

{ #category : #inhabitation }
Z3Sort >> anyOne [
	self subclassResponsibility
]

{ #category : #accessing }
Z3Sort >> kind [
	^ SORT_AST

]

{ #category : #'instance creation' }
Z3Sort >> mkBound: j [
	^ Z3 mk_bound: ctx _: j _: self

]

{ #category : #'instance creation' }
Z3Sort >> mkConst: name [
	"Make a const named name (can be String or Int), of the receiver sort."
	^Z3AST var: name ofSort: self

]

{ #category : #sets }
Z3Sort >> mkEmptySet [
	^Z3 mk_empty_set: ctx _: self
]

{ #category : #'instance creation' }
Z3Sort >> mkFreshConst: prefix [
	"Declare and create a fresh constant of the receiver sort.
	If prefix is nil, then it is assumed to be the empty string"
	^Z3 mk_fresh_const: self ctx _: prefix _: self
]

{ #category : #sets }
Z3Sort >> mkFullSet [
	^Z3 mk_full_set: ctx _: self
]

{ #category : #'instance creation' }
Z3Sort >> mkInt: anInteger [
	"Create a Z3 integer AST-node using a C int."
	^Z3 mk_int: ctx _: anInteger _: self

]

{ #category : #'special relations' }
Z3Sort >> mkLinearOrder: id [ 
	^Z3 mk_linear_order: ctx _: self _: id
]

{ #category : #sets }
Z3Sort >> mkSetSort [
	^Z3 mk_set_sort: ctx _: self
]

{ #category : #accessing }
Z3Sort >> name [
	^Z3 get_sort_name: ctx _:self

]

{ #category : #'type theory' }
Z3Sort >> nodeClass [
	^ self subclassResponsibility

]

{ #category : #numerals }
Z3Sort >> numeralFrom: aString [
	^Z3AST numeral: aString ofSort: self

]

{ #category : #'type theory' }
Z3Sort >> raisedTo: B [
	^B ==> self
]

{ #category : #accessing }
Z3Sort >> sort_reft: knownDatatypes [ 
	^{self . 0}
]
