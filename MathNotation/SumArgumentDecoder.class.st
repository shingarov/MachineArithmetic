Class {
	#name : #SumArgumentDecoder,
	#superclass : #SumDecoder,
	#instVars : [
		'concreteSubclass',
		'object',
		'stillLeft'
	],
	#category : #MathNotation
}

{ #category : #'instance creation' }
SumArgumentDecoder class >> jsonReader: r concreteSubclass: c stillLeft: aCollection [
	^self basicNew
		jsonReader: r;
		concreteSubclass: c;
		stillLeft: aCollection;
		yourself
]

{ #category : #accessing }
SumArgumentDecoder >> concreteSubclass [
	^ concreteSubclass
]

{ #category : #accessing }
SumArgumentDecoder >> concreteSubclass: anObject [
	concreteSubclass := anObject
]

{ #category : #API }
SumArgumentDecoder >> next [
	| instarVarName instVarType value |
	stillLeft isEmpty ifTrue: [ ^self ].
	instarVarName := stillLeft first key.
	instVarType   := stillLeft first value.
	value := jsonReader nextAs: (instVarType isJsonPrimitive ifTrue: [nil] ifFalse: [instVarType]).
	self object instVarNamed: instarVarName put: value.
	stillLeft := stillLeft allButFirst.
	^self
]

{ #category : #accessing }
SumArgumentDecoder >> object [
	object isNil ifTrue: [ object := concreteSubclass new ].
	^ object
]

{ #category : #accessing }
SumArgumentDecoder >> stillLeft [
	^ stillLeft
]

{ #category : #accessing }
SumArgumentDecoder >> stillLeft: anObject [
	stillLeft := anObject
]
