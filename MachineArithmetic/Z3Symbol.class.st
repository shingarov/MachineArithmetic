Class {
	#name : #Z3Symbol,
	#superclass : #Z3ContextedObject,
	#instVars : [
		's'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #private }
Z3Symbol class >> basicFrom: something on: aContext [
	something isString ifTrue: [ ^ LibZ3 uniqueInstance mkStringSymbol: aContext string: something ].
	something isInteger ifTrue: [ ^ LibZ3 uniqueInstance mkIntSymbol: aContext int: something ].
	self error: 'dont know what to do'
]

{ #category : #private }
Z3Symbol class >> from: something [
	^self from: something on: Z3Context current

]

{ #category : #private }
Z3Symbol class >> from: something on: aContext [
	| instance |
	instance := self basicFrom: something on: aContext.
	instance ctx: aContext; s: something.
	^instance
]

{ #category : #API }
Z3Symbol >> getInt [ 
	^ LibZ3 uniqueInstance
		getSymbolInt: self ctx
		symbol: self
]

{ #category : #API }
Z3Symbol >> getString [ 
	^ LibZ3 uniqueInstance
		getSymbolString: self ctx
		symbol: self
]

{ #category : #testing }
Z3Symbol >> isIntSymbol [
	^self symbolKindCode == 0

]

{ #category : #testing }
Z3Symbol >> isStringSymbol [
	^self symbolKindCode == 1

]

{ #category : #API }
Z3Symbol >> mkFuncFrom: domainSorts to: rangeSort [
	| ffiSorts nSorts |
	nSorts := domainSorts size.
	nSorts > 0 ifFalse: [ self error: 'use the 00 stuff' ].
	ffiSorts := self mkExternalArray: domainSorts.
	^(LibZ3 uniqueInstance
		mkFuncDecl: ctx
		symbol: self
		domainSize: nSorts
		domain: ffiSorts
		range: rangeSort) ctx: ctx
]

{ #category : #API }
Z3Symbol >> mkUninterpretedSort [
	^(LibZ3 uniqueInstance mkUninterpretedSort: ctx symbol: self)
		ctx: ctx

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

{ #category : #testing }
Z3Symbol >> symbolKindCode [ 
	^ LibZ3 uniqueInstance
		getSymbolKind: self ctx
		symbol: self
]
