Class {
	#name : #ExprInfo,
	#superclass : #Object,
	#instVars : [
		'expr',
		'kInfo'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
ExprInfo class >> expr: expr kInfo: kInfo [
	^self basicNew expr: expr; kInfo: kInfo; yourself 
]

{ #category : #'instance creation' }
ExprInfo class >> new [
	^self
		expr: Bool false
		kInfo: KInfo new
]

{ #category : #accessing }
ExprInfo >> expr [
	^ expr
]

{ #category : #accessing }
ExprInfo >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
ExprInfo >> kInfo [
	^ kInfo
]

{ #category : #accessing }
ExprInfo >> kInfo: anObject [
	kInfo := anObject
]

{ #category : #'as yet unclassified' }
ExprInfo >> ⊕ [ anotherEI
	^ExprInfo
		expr: expr | anotherEI expr
		kInfo: kInfo, anotherEI kInfo
]
