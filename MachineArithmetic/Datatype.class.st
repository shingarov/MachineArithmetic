Class {
	#name : #Datatype,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'function application' }
Datatype >> doesNotUnderstand: aMessage [
	| fn |
	fn := self sort attrs at: aMessage selector ifAbsent: [ ^super doesNotUnderstand: aMessage ].
	^fn value: self
]

{ #category : #converting }
Datatype >> toDatatype: aZ3Sort [
	self sort == aZ3Sort ifFalse: [ ^self error: 'Cannot coerce' ].
	^self
]
