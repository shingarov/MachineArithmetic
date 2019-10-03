Class {
	#name : #Bool,
	#superclass : #AST,
	#category : #'MachineArithmetic-Logic'
}

{ #category : #private }
Bool class >> fromExternalID: anExternalID [ 
	| op |
	op := self opOf: anExternalID.
	op = 'BoolV' ifTrue: [ ^BoolValue fromExternalID: anExternalID ].
	op = 'BoolS' ifTrue: [ ^BoolSymbol  fromExternalID: anExternalID ].
	^Bool var: anExternalID
]

{ #category : #private }
Bool class >> pythonClassName [ 
	^'Bool'
]

{ #category : #'logical operations' }
Bool >> & another [ 
	| ref |
	ref := 'claripy.And( ', self ref, ' , ', another ref, ' )'.
	^self class simplify: ref
]

{ #category : #controlling }
Bool >> ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock [
	self shouldBeImplemented 
]

{ #category : #'logical operations' }
Bool >> not [
	| ref |
	ref := 'claripy.Not( ', self ref,  ' )'.
	^self class simplify: ref
]

{ #category : #'logical operations' }
Bool >> | another [ 
	| ref |
	ref := 'claripy.Or( ', self ref, ' , ', another ref, ')'.
	^self class simplify: ref
]
