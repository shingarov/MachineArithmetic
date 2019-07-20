"
Until we have in-vero implemented Gauss modular arithmetic,
computer algebra via Grobner bases (on top of Dedekind ideals),
and enough of logic, in Smalltalk, we mock the missing base 
parts by delegating to external Python libraries.
This class is the TCP client to the Python server.
To start the server, run ""python gate.py"" in .p/.
"
Class {
	#name : #P,
	#superclass : #Object,
	#instVars : [
		'socket'
	],
	#classInstVars : [
		'current',
		'deserializationRegistry'
	],
	#category : #'MachineArithmetic-PythonEngine'
}

{ #category : #'wire protocol' }
P class >> compute: aPythonExpression [
	^P fetchVar: (P evalAndAssign: aPythonExpression)
]

{ #category : #connection }
P class >> current [
	"Make sure we are connected."
	current isNil ifTrue: [ current := self new ].
	current isConnected ifFalse: [ current connect ].
	^current
	
]

{ #category : #'wire protocol' }
P class >> decodeList: var [ 
	| len items |
	len := P eval: 'len(', var ref, ')'.
	^(0 to: len - 1) collect: [ :i |
		P compute: var ref, '[', i printString, ']' ]
]

{ #category : #private }
P class >> deserializationRegistry [
	deserializationRegistry isNil ifTrue: [ deserializationRegistry := Dictionary new ].
	^deserializationRegistry 
]

{ #category : #'wire protocol' }
P class >> deserialize: aString [
	aString first = $J ifTrue: [ ^self deserializeJSON: aString allButFirst ].
	aString first = $+ ifTrue: [ ^self deserializeCustom: aString allButFirst ].
	self error 
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

	"we don't know how to do a random object"
	self shouldBeImplemented 
]

{ #category : #'wire protocol' }
P class >> deserializeCustomVar: var [ 
	| pythonClassName smalltalkClass |
	pythonClassName := var pythonClassName.
	pythonClassName = 'list' ifTrue: [ ^self decodeList: var ].
	smalltalkClass := self deserializationRegistry at: pythonClassName.
	^smalltalkClass fromExternalID: var
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
	^self deserialize: answer
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

{ #category : #private }
P class >> initDeserializationRegistry [
	" self initDeserializationRegistry "
	| reg |
	reg := self deserializationRegistry.
	reg removeAll.
	External withAllSubclassesDo: [ :anExternalClass |
		(anExternalClass class includesSelector: #pythonClassName)
			ifTrue: [ P registerClass: anExternalClass ] ]
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

{ #category : #private }
P class >> registerClass: aSmalltalkClass [
	self deserializationRegistry
		at: aSmalltalkClass pythonClassName 
		put: aSmalltalkClass 
]

{ #category : #connection }
P class >> send: aString [
	^self current send: aString
	
]

{ #category : #'wire protocol' }
P class >> sendAndAssignList: aSequenceableCollection [
	^self sendList: aSequenceableCollection andAssignTo: 0
]

{ #category : #'wire protocol' }
P class >> sendAndAssignObject: anObject [
	| var |
	var := ExternalID new.
	self sendObject: anObject andAssignTo: var name.
	^var
]

{ #category : #private }
P class >> sendList: aSequenceableCollection andAssignTo: aVariable [
	| s answer |
	s := aSequenceableCollection inject: '[ ' into: [ :soFar :item |
			soFar, item ref, ', ' ].
	s := s, ' ]'.
	^P evalAndAssign: s
]

{ #category : #private }
P class >> sendObject: anObject andAssignTo: aVariable [
	| s answer |
	s := NeoJSONWriter toString: anObject.
	answer := self current send: ':', aVariable.
	answer = ':' ifFalse: [ self error ].
	answer := self current send: s.
	answer = '+' ifFalse: [ self error ].
	^ExternalID named: aVariable 
	
]

{ #category : #connection }
P >> connect [
	P initDeserializationRegistry. "TODO: This does not belong here!"
	socket := SocketStream openConnectionToHost: self ip port: 7000
]

{ #category : #connection }
P >> ip [
	^#[ 127 0 0 1 ]
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
