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
	| var construct |
	construct := 'claripy.BoolS(', sym printString, ', explicit_name=True)'.
	var := P evalAndAssign: construct.
	^self var: var
]

{ #category : #testing }
BoolSymbol >> isLeaf [ 
	^true
]

{ #category : #access }
BoolSymbol >> sym [
	^P eval: self ref, '.args[0]'
]
