Class {
	#name : #MonomorphizedDataDeclTest,
	#superclass : #TestCaseWithZ3Context,
	#instVars : [
		'listType'
	],
	#category : #'Z3-Tests-ADT'
}

{ #category : #running }
MonomorphizedDataDeclTest >> emptiness [
	"Emptiness is the characteristic function of empty lists:
	 it is 1 if the given argument is empty,
	 0 if the given argument is non-empty."
	| l emptiness ite |
	l := listType mkConst: 'l'.
	emptiness := 'emptiness' recursiveFunctionFrom: {listType} to: Int sort.
	ite := ((listType recognizerFor: 'nil') value: l) ifTrue: [1 toInt] ifFalse: [0 toInt].
	emptiness value: l is: ite.
	^emptiness
]

{ #category : #running }
MonomorphizedDataDeclTest >> len [
	| len l |
	l := listType mkConst: 'l'.
	len := 'len' recursiveFunctionFrom: {listType} to: Int sort.
	len value: l is: (((listType recognizerFor: 'nil') value: l)
		ifTrue: [0 toInt]
		ifFalse: [ (len value: ((listType accessorNamed: 'cdr') value: l)) + 1 ]).
	^len
]

{ #category : #running }
MonomorphizedDataDeclTest >> setUp [
	listType := MonomorphizedDataDecl named: 'List'.
	listType
		declare: 'cons'
		accessors:
			{('car' -> Int sort).
			 ('cdr' -> listType)}.
	listType declare: 'nil' accessors: #().
	listType := listType create
]

{ #category : #tests }
MonomorphizedDataDeclTest >> testAllNilsAreEqual [
	| nilConstructor nil1 nil2 |
	nil1 := (listType constructorNamed: 'nil') value.
	self assert: nil1 sort equals: listType.
	nil2 := (listType constructorNamed: 'nil') value.
	
	self assert: nil2 sort equals: listType.
	self assert: (nil1 === nil2) isValid
]

{ #category : #tests }
MonomorphizedDataDeclTest >> testListCreation [
	| l ll |
	l := listType mkConst: 'l'.
	ll := listType mkConst: 'll'.
	
	self assert: l  sort  equals: listType.
	self assert: ll sort  equals: listType
]

{ #category : #tests }
MonomorphizedDataDeclTest >> testMeasure [
	| l ite emptiness |
	Smalltalk isSmalltalkX ifTrue: [ self skip:'Not supported on Smalltalk/X because of lack of dynamic deoptimization' ].

	l := listType mkConst: 'll'.
	self assert: (
		"The only list whose length is 0, is Nil."
		Z3Solver isValid: (self emptiness value: l) > 0 ==> ((listType recognizerFor: 'nil') value: l)
	)
]

{ #category : #tests }
MonomorphizedDataDeclTest >> testNilHasLength0 [
	| nil1 |
	Smalltalk isSmalltalkX
		ifTrue: [ self
				skip:
					'Not supported on Smalltalk/X because of lack of dynamic deoptimization' ].
	nil1 := (listType constructorNamed: 'nil') value.
	self assert: (self len value: nil1) equals: 0
]

{ #category : #tests }
MonomorphizedDataDeclTest >> testNotAllListsEqual [
	| l ll |
	l := listType mkConst: 'l'.
	ll := listType mkConst: 'll'.
	self deny: (l === ll) isValid
]

{ #category : #tests }
MonomorphizedDataDeclTest >> testNumConstructors [
	self assert: listType numConstructors equals: 2
]

{ #category : #tests }
MonomorphizedDataDeclTest >> testSingletonLengthIs1 [
	| singleton |
	Smalltalk isSmalltalkX
		ifTrue: [ self
				skip:
					'Not supported on Smalltalk/X because of lack of dynamic deoptimization' ].
	singleton := (listType constructorNamed: 'cons')
		value: 'head' toInt
		value: (listType constructorNamed: 'nil') value.
	self assert: ((self len value: singleton) === 1) isValid
]
