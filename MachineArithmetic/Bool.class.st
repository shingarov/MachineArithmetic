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
Bool class >> initialize [
	self registerPythonDeserializer
]

{ #category : #private }
Bool class >> pythonClassName [ 
	^'Bool'
]

{ #category : #'logical operations' }
Bool >> & another [ 
	| ref |
	ref := 'angr.state_plugins.solver.SimSolver().simplify(claripy.And( ', self ref, ' , ', another ref, '))'.
	^P fetchVar: (P evalAndAssign: ref)

]

{ #category : #controlling }
Bool >> ifTrue: aBlock [
"
Bool new ifTrue: 1

"

	^'yes!'
]

{ #category : #'logical operations' }
Bool >> not [
	| ref |
	ref := 'claripy.Not( ', self ref,  ' )'.
	^P fetchVar: (P evalAndAssign: ref)

]

{ #category : #'logical operations' }
Bool >> | another [ 
	| ref |
	ref := 'angr.state_plugins.solver.SimSolver().simplify(claripy.Or( ', self ref, ' , ', another ref, '))'.
	^P fetchVar: (P evalAndAssign: ref)

]
