Class {
	#name : #BoolSymbol,
	#superclass : #Bool,
	#category : #'MachineArithmetic-Logic'
}

{ #category : #private }
BoolSymbol class >> fromExternalID: anExternalID [ 
	self shouldBeImplemented 
]

{ #category : #'instance creation' }
BoolSymbol class >> sym: sym [
	^self construct: 'claripy.BoolS(', sym printString, ', explicit_name=True)'
]

{ #category : #testing }
BoolSymbol >> isLeaf [ 
	^true
]

{ #category : #access }
BoolSymbol >> sym [
	^P eval: self ref, '.args[0]'
]
