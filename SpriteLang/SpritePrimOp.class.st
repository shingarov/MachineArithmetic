Class {
	#name : #SpritePrimOp,
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
SpritePrimOp class >> op: operatorString [
	^(self subclasses detect: [ :subclass | subclass operator = operatorString ] ifNone: [ self error ]) new
]

{ #category : #syntax }
SpritePrimOp class >> operator [
	self subclassResponsibility
]

{ #category : #refinement }
SpritePrimOp class >> rType [
	^(RTypeParser new productionAt: #rtype) parse: self rTypeSrc
]

{ #category : #refinement }
SpritePrimOp class >> rTypeSrc [
	self subclassResponsibility 
]
