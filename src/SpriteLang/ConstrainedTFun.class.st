Class {
	#name : #ConstrainedTFun,
	#superclass : #TFun,
	#instVars : [
		'tlBlock'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
ConstrainedTFun class >> useValue: v orType: t [ 
	^t
]

{ #category : #accessing }
ConstrainedTFun >> tlBlock: anObject [
	tlBlock := anObject.
	^self
]

{ #category : #'type-level application' }
ConstrainedTFun >> typeLevelApplyTo: arg ofType: argT giving: ot [
	| a |
	a := self class useValue: arg orType: argT.
	(ot isKindOf: ConstrainedTFun) ifTrue: [
		ot tlBlock: (tlBlock value: a)
	]	ifFalse: [
		| c es |
		c := TypeLevelConstraint
			block: (tlBlock value: a)
			outputRType: ot.
		es := ElabState current.
		es 	addTypeLevelConstraint: c
	]
]
