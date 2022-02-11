Class {
	#name : #SpritePrimOp,
	#superclass : #Object,
	#category : #SpriteLang
}

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
