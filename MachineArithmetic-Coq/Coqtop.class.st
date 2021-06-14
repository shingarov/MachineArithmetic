"
See
https://github.com/coq/coq/blob/master/dev/doc/xml-protocol.md
https://github.com/jscoq/jscoq/blob/v8.10/etc/notes/coq-notes.md
https://github.com/whonore/Coqtail.git
"
Class {
	#name : #Coqtop,
	#superclass : #Object,
	#instVars : [
		'coqtop',
		'stateId',
		'currentGoals',
		'backgroundGoals',
		'shelvedGoals',
		'abandonedGoals'
	],
	#category : #'MachineArithmetic-Coq'
}

{ #category : #'as yet unclassified' }
Coqtop >> about [
	| response |
	response := self call: 'About' guts: '<unit/>'.
	^(response valueElement findXPath: 'coq_info/string') collect: #contentText 
]

{ #category : #'as yet unclassified' }
Coqtop >> add: cmd editId: anInteger stateId: s verbose: v [ 
	| response |
	response := self call: 'Add' guts: '<pair><pair><string>', cmd, '</string><int>-1</int></pair><pair><state_id val="',
		s asString, '"/><bool val="true"/></pair></pair>'.
	stateId := ((response valueElement findXPath: '/pair/state_id') attributeAt: 'val') asInteger.
	
]

{ #category : #'as yet unclassified' }
Coqtop >> advance: cmd [
	^self add: cmd editId: -1 stateId: stateId verbose: false
]

{ #category : #'as yet unclassified' }
Coqtop >> call: cmd guts: aString [
	| response |
	coqtop stdinStream nextPutAll: '<call val="', cmd, '">', aString, '</call>'; flush.
	[ response := self readElement.
		response name localName = 'value' ifTrue: [ ^CoqValue fromXml: response ] ] repeat

]

{ #category : #'as yet unclassified' }
Coqtop >> coqtopArgs [
	^#('-main-channel' 'stdfds'
	   '-async-proofs' 'on'
	   '-async-proofs-command-error-resilience' 'off'
	   '-async-proofs-tactic-error-resilience'  'off'
	   '-topfile'  '/home/boris/q/X.v'
	)
]

{ #category : #'as yet unclassified' }
Coqtop >> goal [
	| response option lists |
	response := self call: 'Goal' guts: '<unit/>'. self halt.
	option := OptionElement of: response valueElement.
	option isNil ifTrue: [ ^nil ].
	lists := option findXPath: '/goals/list'.
	
	currentGoals := lists first children collect: #asCoqGoal.
	backgroundGoals := lists second children collect: #asCoqGoal.
	shelvedGoals := lists third children collect: #asCoqGoal.
	abandonedGoals := lists fourth children collect: #asCoqGoal.

]

{ #category : #'as yet unclassified' }
Coqtop >> init [
	"Init Coq.  Answer the Initial State ID."
	| response |
	response := self call: 'Init' guts: '<option val="none"/>'.
	^((response valueElement findXPath: 'state_id') attributeAt: 'val') asInteger
]

{ #category : #'as yet unclassified' }
Coqtop >> readElement [
	| response parser |
	parser := PPXmlParser new productionAt: #element.
	response := ''.
	[ | element |
		response := response, (coqtop stdoutStream next: 1).
		element := parser parse: response.
		element isPetitFailure ifFalse: [ ^element ] ] repeat
]

{ #category : #'as yet unclassified' }
Coqtop >> start [
	coqtop := OSSUnixSubprocess new.
	coqtop
		command: '/usr/bin/coqidetop';
		arguments: (self coqtopArgs);
		redirectStdin;
		redirectStdout;
		run.
	stateId := self init.
	
]
