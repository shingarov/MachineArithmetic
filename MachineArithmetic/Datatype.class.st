Class {
	#name : #Datatype,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'as yet unclassified' }
Datatype >> toDatatype: aZ3Sort [
	self sort == aZ3Sort ifFalse: [ ^self error: 'Cannot coerce' ].
	^self
]
