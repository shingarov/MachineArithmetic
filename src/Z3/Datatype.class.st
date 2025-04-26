Class {
	#name : #Datatype,
	#superclass : #Z3Node,
	#category : #'Z3-Core'
}

{ #category : #converting }
Datatype >> toDatatype: aZ3Sort [
	self sort == aZ3Sort ifFalse: [ ^self error: 'Cannot coerce' ].
	^self
]
