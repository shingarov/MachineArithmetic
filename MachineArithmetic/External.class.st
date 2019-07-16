"
I am the base superclass of all things mocked via Python libraries.
"
Class {
	#name : #External,
	#superclass : #Object,
	#instVars : [
		'var'
	],
	#category : #'MachineArithmetic-PythonEngine'
}

{ #category : #'instance creation' }
External class >> construct: aPythonExpressionString [
	| var |
	var := P evalAndAssign: aPythonExpressionString.
	^self var: var
]

{ #category : #'instance creation' }
External class >> fromExternalID: anExternalID [ 
	^self var: anExternalID 
]

{ #category : #private }
External class >> var: v [
	^self new 
		var: v;
		yourself
]

{ #category : #printing }
External >> printOn: aStream [
	aStream nextPutAll: self var pythonStr
]

{ #category : #private }
External >> ref [ 
	^self var ref
]

{ #category : #private }
External >> var [
	^ var
]

{ #category : #private }
External >> var: anExternalID [
	var := anExternalID
]
