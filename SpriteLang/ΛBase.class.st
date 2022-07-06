"
Sprite's own concept of vulgar type.
"
Class {
	#name : #'ΛBase',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ΛBase class >> new [
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
ΛBase >> bFalse [
"see Z3Sort>>trueSortedReft"
	^TBase b: self r: Reft alwaysFalse
]

{ #category : #'as yet unclassified' }
ΛBase >> bTrue [
"see Z3Sort>>trueSortedReft"
	^TBase b: self r: KnownReft alwaysTrue
]

{ #category : #'as yet unclassified' }
ΛBase >> baseSort [
	self subclassResponsibility 
]

{ #category : #polymorphism }
ΛBase >> bsubst: t tVar: a reft: r [
	^TBase b: self r: r
]

{ #category : #'as yet unclassified' }
ΛBase >> freeTVarsGoB [
	^Set new
]
