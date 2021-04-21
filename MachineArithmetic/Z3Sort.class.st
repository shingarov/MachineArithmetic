Class {
	#name : #Z3Sort,
	#superclass : #AST,
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
	^(LibZ3 uniqueInstance mkBvSort: ctx size: sz)
		ctx: ctx
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
	^AST wrap: (LibZ3 uniqueInstance mkBound: ctx index: j sort: self) in: ctx
]

{ #category : #'as yet unclassified' }
Z3Sort >> mkConst: name [
	"Make a const maned name (can be String or Int), of the reveiver sort."
	^AST var: name ofSort: self
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

{ #category : #numerals }
Z3Sort >> numeralFrom: aString [
	^AST numeral: aString ofSort: self
]

{ #category : #printing }
Z3Sort >> printOn: aStream [
	"See display_sort() in test_capi.c"
	self getASTClass printSort: self on: aStream
]
