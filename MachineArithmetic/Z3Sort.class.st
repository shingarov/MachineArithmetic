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
	^(LibZ3 uniqueInstance mkBoolSort: aZ3Context)
		ctx: aZ3Context
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

	sortKind = BOOL_SORT ifTrue: [ ^ Z3BoolSort ].
	sortKind = BV_SORT ifTrue: [ ^ Z3BitVectorSort ].
	sortKind = INT_SORT ifTrue: [ ^ Z3IntSort ].
	sortKind = REAL_SORT ifTrue: [ ^ Z3RealSort ].
	sortKind = ARRAY_SORT ifTrue: [ ^ Z3ArraySort ].
	sortKind = UNINTERPRETED_SORT ifTrue: [ ^ Z3UninterpretedSort ].

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
	^ class basicNew
		initializeWithAddress: anExternalAddress context: aZ3Context;
		yourself.

]

{ #category : #'instance creation' }
Z3Sort class >> int [
	^self intSortOn: Z3Context current
]

{ #category : #'instance creation' }
Z3Sort class >> intSortOn: aZ3Context [
	^(LibZ3 uniqueInstance mkIntSort: aZ3Context)
		ctx: aZ3Context
]

{ #category : #'instance creation' }
Z3Sort class >> real [
	^self realSortOn: Z3Context current
]

{ #category : #'instance creation' }
Z3Sort class >> realSortOn: aZ3Context [
	^(LibZ3 uniqueInstance mkRealSort: aZ3Context)
		ctx: aZ3Context
]

{ #category : #'instance creation' }
Z3Sort class >> uninterpretedSortNamed: aName [
	^(Z3Symbol from: aName) mkUninterpretedSort
]

{ #category : #'instance creation' }
Z3Sort class >> uninterpretedSortNamed: aName on: aZ3Context [
	self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
Z3Sort >> --> range [
	^(LibZ3 uniqueInstance mkArraySort: ctx domain: self range: range) ctx: ctx
]

{ #category : #'type theory' }
Z3Sort >> getASTClass [
	^ Z3SortKind astClassForSort: self

]

{ #category : #'as yet unclassified' }
Z3Sort >> getBVSortSize [
	| astClass |
	astClass := self getASTClass.
	astClass = BitVector ifFalse: [ ^self error: 'attempt to get bitvector-length of a ', astClass name ].
	^LibZ3 uniqueInstance getBVSortSize: ctx sort: self
]

{ #category : #'type theory' }
Z3Sort >> getSortKindCode [
	^LibZ3 uniqueInstance getSortKind: ctx sort: self
]

{ #category : #'as yet unclassified' }
Z3Sort >> mkBound: j [
	"Create a bound variable with de-Bruijn index j."
	^Z3AST wrap: (LibZ3 uniqueInstance mkBound: ctx index: j sort: self) in: ctx

]

{ #category : #'as yet unclassified' }
Z3Sort >> mkConst: name [
	"Make a const maned name (can be String or Int), of the reveiver sort."
	^Z3AST var: name ofSort: self

]

{ #category : #'as yet unclassified' }
Z3Sort >> mkInt: anInteger [
	"Create a Z3 integer AST-node using a C int."
	^(LibZ3 uniqueInstance mkInt: ctx int: anInteger sort: self)
		ctx: ctx
]

{ #category : #'type theory' }
Z3Sort >> name [
	^LibZ3 uniqueInstance getSortName: ctx sort: self
]

{ #category : #'type theory' }
Z3Sort >> nodeClass [
	^ self subclassResponsibility

]

{ #category : #numerals }
Z3Sort >> numeralFrom: aString [
	^Z3AST numeral: aString ofSort: self

]

{ #category : #printing }
Z3Sort >> printOn: aStream [
	"See display_sort() in test_capi.c"
	self getASTClass printSort: self on: aStream
]
