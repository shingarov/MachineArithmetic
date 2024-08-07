Class {
	#name : #Datatype,
	#superclass : #Z3Node,
	#category : #'Z3-Core'
}

{ #category : #'function application' }
Datatype >> doesNotUnderstand: aMessage [
	| fn |
	fn := self sort attrs at: aMessage selector ifAbsent: [ ^super doesNotUnderstand: aMessage ].
	^fn value: self
]

{ #category : #testing }
Datatype >> is: datatypeComponent [
	self sort == datatypeComponent sort ifTrue:[ 
		^datatypeComponent recognizer value: self
	] ifFalse:[
		^Bool false.
	]
]
{ #category : #converting }
Datatype >> toDatatype: aZ3Sort [
	self sort == aZ3Sort ifFalse: [ ^self error: 'Cannot coerce' ].
	^self
]
