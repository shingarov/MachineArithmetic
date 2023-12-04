Class {
	#name : #SumConstructorDecoder,
	#superclass : #SumDecoder,
	#instVars : [
		'sumClass'
	],
	#category : #MathNotation
}

{ #category : #'instance creation' }
SumConstructorDecoder class >> jsonReader: jsonReader sumClass: c [
	^self basicNew
		jsonReader: jsonReader;
		sumClass: c;
		yourself
]

{ #category : #API }
SumConstructorDecoder >> next [
	| constructorName concreteSubclass argumentClasses ivarTyping orderedIvarTyping |
	constructorName := jsonReader next.
	concreteSubclass := sumClass subclasses detect: [ :sub | sub name = constructorName ].
	^SumArgumentDecoder
		jsonReader: jsonReader
		concreteSubclass: concreteSubclass
		stillLeft: concreteSubclass allInstVarsWithMaybeTyping
]

{ #category : #accessing }
SumConstructorDecoder >> sumClass [
	^ sumClass
]

{ #category : #accessing }
SumConstructorDecoder >> sumClass: anObject [
	sumClass := anObject
]
