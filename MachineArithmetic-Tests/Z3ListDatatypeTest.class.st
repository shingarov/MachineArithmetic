Class {
	#name : #Z3ListDatatypeTest,
	#superclass : #TestCaseWithZ3Context,
	#instVars : [
		'listType',
		'l',
		'll'
	],
	#category : #'MachineArithmetic-Tests-ADT'
}

{ #category : #running }
Z3ListDatatypeTest >> setUp [
	listType := Z3Datatype named: 'List'.
	listType declare: 'cons' accessors: { 'car'->Int sort. 'cdr'->listType }.
	listType declare: 'nil'.
	listType := listType create.
	l := listType mkConst: 'l'.
	ll := listType mkConst: 'll'.
]

{ #category : #tests }
Z3ListDatatypeTest >> testAppendAddsLengths [
	| len append xs ys |
	self skip. "The solver will diverge."
	
	len := 'len' recursiveFunctionFrom: {listType} to: Int sort.
	len value: l is: (l is_nil ifTrue: [0 toInt] ifFalse: [(len value: l cdr) + 1]).
	append := 'append' recursiveFunctionFrom: {listType.listType} to: listType.
	append valueWithArguments: {l.ll} is: (l is_nil
		ifTrue: [ll]
		ifFalse: [ | h t rest |
			h := l car.
			t := l cdr.
			rest := append value: t value: ll.
			listType cons: h _: rest ]).
	
	xs := listType mkConst: 'xs'.
	ys := listType mkConst: 'ys'.
	self assert: (
		Z3Solver isValid: 
			(len value: xs) + (len value: ys) "|xs|+|ys|"
				===
			(len value: (append value: xs value: ys)) "|xs,ys|"
	)
]

{ #category : #tests }
Z3ListDatatypeTest >> testListDatatype [
	self assert: listType nil class equals: Datatype.
	self assert: (listType cons: 10 _: listType nil) class equals: Datatype.
]

{ #category : #tests }
Z3ListDatatypeTest >> testMeasure [
	| emptiness anyList |

	"
	This test depends on dynamic deoptimization of ifTrue:ifFalse: 
	which is only available in Pharo. So skip this test everywhere
	else.
	"
	Smalltalk isPharo ifFalse: [ self skip:'Dynamic deoptimization not supported' ].

	"Emptyness is the characteristic function of empty lists:
	 it is 1 if the given argument is empty,
	 0 if the given argument is non-empty."
	emptiness := 'emptiness' recursiveFunctionFrom: {listType} to: Int sort.
	emptiness value: l is: (l is_nil ifTrue: [1 toInt] ifFalse: [0 toInt]).
	
	anyList := listType mkConst: 'anyList'.
	self assert: (
		"The only list whose length is 0, is Nil."
		Z3Solver isValid: (emptiness value: anyList) > 0 ==> anyList is_nil
	)
]

{ #category : #tests }
Z3ListDatatypeTest >> testNilHasLength0 [
	| len |
	self skip. "This test passes on Z3 4.8.12 but fails on 4.7.8 (which is what CI uses)"

	len := 'len' recursiveFunctionFrom: {listType} to: Int sort.
	len value: l is: (l is_nil ifTrue: [0 toInt] ifFalse: [(len value: l cdr) + 1]).
	self assert: (len value: listType nil) simplify equals: 0
]

{ #category : #tests }
Z3ListDatatypeTest >> testNumConstructors [
	self assert: listType numConstructors equals: 2.
]

{ #category : #tests }
Z3ListDatatypeTest >> testSingletonLengthIs1 [
	| len singleton x |

	"
	This test depends on dynamic deoptimization of ifTrue:ifFalse: 
	which is only available in Pharo. So skip this test everywhere
	else.
	"
	Smalltalk isPharo ifFalse: [ self skip:'Dynamic deoptimization not supported' ].

	len := 'emptiness' recursiveFunctionFrom: {listType} to: Int sort.
	len value: l is: (l is_nil ifTrue: [0 toInt] ifFalse: [(len value: l cdr) + 1]).
	x := 'x' toInt.
	singleton := listType cons: x toInt _: listType nil.
	self assert: (
		Z3Solver isValid: (len value: singleton) === 1
	)
]
