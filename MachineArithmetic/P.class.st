"
TCP client to the Python server
"
Class {
	#name : #P,
	#superclass : #Object,
	#instVars : [
		'socket'
	],
	#classInstVars : [
		'current'
	],
	#category : #'MachineArithmetic-PythonEngine'
}

{ #category : #connection }
P class >> current [
	"Make sure we are connected."
	current isNil ifTrue: [ current := self new ].
	current isConnected ifFalse: [ current connect ].
	^current
	
]

{ #category : #'wire protocol' }
P class >> deserialize: aString [
	aString first = $J ifTrue: [ ^self deserializeJSON: aString allButFirst ].
	aString first = $+ ifTrue: [ ^self deserializeCustom: aString allButFirst ].
	self shouldBeImplemented  
]

{ #category : #'wire protocol' }
P class >> deserializeBV: aString var: anExternalID [ 
	self shouldBeImplemented.
]

{ #category : #'wire protocol' }
P class >> deserializeCustom: aString [ 
	| className str |
	className := aString copyUpTo: $:.
	str := aString copyFrom: className size + 2 to: aString size.
	self shouldBeImplemented 
]

{ #category : #'wire protocol' }
P class >> deserializeCustom: aString var: var [
	| className str |
	className := aString copyUpTo: $:.
	str := aString copyFrom: className size + 2 to: aString size.
	
	"Different cases, should be split off"
	className = 'BV' ifTrue: [ ^self deserializeBV: aString var: var ].
	
	"Don't know how to do others yet"
	self shouldBeImplemented 
]

{ #category : #'wire protocol' }
P class >> deserializeCustomVar: var [ 
	| pythonClassName |
	pythonClassName := var pythonClassName.
	pythonClassName = 'BV' ifFalse: [ ^self error: 'dont know this yet' ].
	^Int fromExternalID: var
]

{ #category : #'wire protocol' }
P class >> deserializeJSON: aString [
	^NeoJSONReader fromString: aString 

]

{ #category : #'wire protocol' }
P class >> env: varName [
	^'e["', varName, '"]'.
]

{ #category : #'wire protocol' }
P class >> eval: aString [
	| answer |
	answer := self rawEval: aString.
	answer first = $J
		ifTrue: [ ^self deserializeJSON: answer allButFirst ]
		ifFalse: [ self error: 'cant deserialize' ]

]

{ #category : #'wire protocol' }
P class >> evalAndAssign: aPythonExpressionString [
	| var |
	var := ExternalID new.
	P rawExec: var ref, ' = ', aPythonExpressionString.
	^var
]

{ #category : #'wire protocol' }
P class >> fetchVar: var [
	| answer |
	answer := self rawEval: var ref.
	answer first = $J
		ifTrue: [ ^self deserializeJSON: answer allButFirst ]
		ifFalse: [ ^self deserializeCustomVar: var ]

]

{ #category : #'wire protocol' }
P class >> rawEval: aString [
	^P send: aString
]

{ #category : #'wire protocol' }
P class >> rawExec: aString [
	| answer |
	answer := P send: '.', aString.
	answer = '+' ifFalse: [ self error ]
]

{ #category : #connection }
P class >> send: aString [
	^self current send: aString
	
]

{ #category : #connection }
P >> connect [
	socket := SocketStream openConnectionToHost: #[ 127 0 0 1 ] port: 7000
]

{ #category : #connection }
P >> isConnected [ 
	^socket notNil and: [ ^socket isConnected ]
]

{ #category : #connection }
P >> send: aString [
	socket nextPutAllFlush: aString, String crlf.
	^socket upToAll: String crlf 
	
]
