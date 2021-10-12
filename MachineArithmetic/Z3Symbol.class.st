Class {
	#name : #Z3Symbol,
	#superclass : #Z3ContextedObject,
	#instVars : [
		's'
	],
	#pools : [
		'Z3SymbolKind'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #private }
Z3Symbol class >> from: anObject [
	^self from: anObject on: Z3Context current

]

{ #category : #private }
Z3Symbol class >> from: anObject on: aContext [
	anObject isInteger ifTrue: [ 
		^ Z3 mk_int_symbol: aContext _: anObject
	].
	anObject isString ifTrue: [ 
		^ Z3 mk_string_symbol: aContext _: anObject
	].
	self error: 'Unsupported value type'

]

{ #category : #converting }
Z3Symbol >> asString [
	^ self getString

]

{ #category : #API }
Z3Symbol >> getInt [
	self assert: self isIntSymbol.
	^ Z3 get_symbol_int: ctx _: self

]

{ #category : #API }
Z3Symbol >> getString [
	^ Z3 get_symbol_string: ctx _: self

]

{ #category : #testing }
Z3Symbol >> isIntSymbol [
	^self kind == INT_SYMBOL

]

{ #category : #testing }
Z3Symbol >> isStringSymbol [
	^self kind == STRING_SYMBOL

]

{ #category : #accessing }
Z3Symbol >> kind [
	^ Z3 get_symbol_kind: ctx _: self.

]

{ #category : #API }
Z3Symbol >> mkFuncFrom: domainSorts to: rangeSort [
	^ Z3 mk_func_decl: ctx _: self _: domainSorts size _: domainSorts _: rangeSort.

]

{ #category : #API }
Z3Symbol >> mkUninterpretedSort [
	^ Z3 mk_uninterpreted_sort: ctx _: self

]

{ #category : #printing }
Z3Symbol >> printOn: aStream [
	self isStringSymbol
		ifTrue:  [ aStream nextPutAll: self getString ]
		ifFalse: [ self getInt printOn: aStream ]
]

{ #category : #accessing }
Z3Symbol >> s [
	^ s
]

{ #category : #accessing }
Z3Symbol >> s: anObject [
	s := anObject
]

{ #category : #converting }
Z3Symbol >> toZ3Symbol [
	^self

]
