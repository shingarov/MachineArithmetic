Class {
	#name : #'ΛInfixOp',
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
ΛInfixOp class >> concreteParser [
	^self operator asParser ==> [ :_x | self new ]
]

{ #category : #syntax }
ΛInfixOp class >> operator [
	self subclassResponsibility
]

{ #category : #syntax }
ΛInfixOp class >> parser [
	^PPChoiceParser withAll: ((self subclasses
		asSortedCollection: [ :a :b | a operator size > b operator size ])
			collect: [ :eachKeyword | eachKeyword concreteParser ])
]
