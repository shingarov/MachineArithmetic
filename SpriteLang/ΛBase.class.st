"
Sprite's own concept of vulgar type.
"
Class {
	#name : #'ΛBase',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
ΛBase >> bTrue [
"see Z3Sort>>trueSortedReft"
	^TBase b: self r: Reft alwaysTrue
]

{ #category : #'as yet unclassified' }
ΛBase >> baseSort [
	self subclassResponsibility 
]
