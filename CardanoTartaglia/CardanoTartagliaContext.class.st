Class {
	#name : #CardanoTartagliaContext,
	#superclass : #Object,
	#instVars : [
		'env'
	],
	#category : #CardanoTartaglia
}

{ #category : #'instance creation' }
CardanoTartagliaContext class >> ofVariables: aDictionary [
	^self basicNew
		env: aDictionary;
		yourself
]

{ #category : #'smalltalk context' }
CardanoTartagliaContext >> dummyMethod [
]

{ #category : #accessing }
CardanoTartagliaContext >> env [
	^env
]

{ #category : #accessing }
CardanoTartagliaContext >> env: aDictionary [
	env := aDictionary
]

{ #category : #evaluating }
CardanoTartagliaContext >> evaluate: source [
	"Evaluate given smalltalk source with receiver 
	 as context (providing variable values). Return the result.
	
	 If the code contains a variable not defined in the receiver,
	 throw `VariableNotDeclared` exception.
	"
	
	| compiler |
	
	compiler := self class compilerClass new.
	compiler context: self.
	[ 
		^compiler evaluate: source 
	] on: OCUndeclaredVariableWarning do: [ :warning |
		VariableNotDeclared new
			variableNode: warning node;
			signal.
	]
]

{ #category : #GT }
CardanoTartagliaContext >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite fastTable
		title: 'Variables';
		display: [ env associations ];
		"children: [ :each | 
			(each value isDictionary) 
				ifTrue: [ each value associations ] 
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [:x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];"
			column: 'Name' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ];
		selectionAct: [ :table | 
			table rawSelection do: [ :assoc | self removeKey: assoc key ].
			table update
			]
			entitled: 'Remove item(s)';
		selectionPopulate: #selection
			entitled: 'Open key'
			with: [ :table | ( table rawSelection collect: #key ) gtInspectorInterestingObject ];
		beMultiple;
		send: [ :selection | 
			"withSmalltalkSearch;
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'"
			selection
				ifNil: [ nil ]
				ifNotNil: [ selection size = 1
						ifTrue: [ selection anyOne value ]
						ifFalse: [ selection collect: #value ]
					]
			]
]

{ #category : #'smalltalk context' }
CardanoTartagliaContext >> method [
	^CardanoTartagliaContext >> #dummyMethod
]

{ #category : #'smalltalk context' }
CardanoTartagliaContext >> receiver [
	^nil
]

{ #category : #accessing }
CardanoTartagliaContext >> tempNamed: aString [
	^self env at: aString
]

{ #category : #accessing }
CardanoTartagliaContext >> tempNamed: aString put: value [
	self env at: aString put: value 
]

{ #category : #accessing }
CardanoTartagliaContext >> tempNames [
	^env keys
]
