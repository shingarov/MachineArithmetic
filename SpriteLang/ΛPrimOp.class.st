Class {
	#name : #'ΛPrimOp',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
ΛPrimOp class >> op: operatorString [
	^(self subclasses detect: [ :subclass | subclass operator = operatorString ] ifNone: [ self error ]) new
]

{ #category : #syntax }
ΛPrimOp class >> operator [
	self subclassResponsibility
]

{ #category : #refinement }
ΛPrimOp class >> rType [
	^(RTypeParser new productionAt: #rtype) parse: self rTypeSrc
]

{ #category : #refinement }
ΛPrimOp class >> rTypeSrc [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
ΛPrimOp >> binOpTy [
	^(RTypeParser new productionAt: #rtype) parse: self class rTypeSrc
]

{ #category : #printing }
ΛPrimOp >> printOn: aStream [
	self printStructOn: aStream
]
