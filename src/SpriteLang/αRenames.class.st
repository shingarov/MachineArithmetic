Class {
	#name : #'αRenames',
	#superclass : #Object,
	#instVars : [
		'key',
		'value',
		'seen',
		'rest'
	],
	#category : #'SpriteLang-Parsing'
}

{ #category : #'instance creation' }
αRenames class >> empty [
	^self basicNew empty
]

{ #category : #'instance creation' }
αRenames class >> key: key value: value seen: seen rest: rest [
	^self basicNew key: key value: value seen: seen rest: rest
]

{ #category : #'instance creation' }
αRenames class >> new [
	self shouldNotImplement. "Use #empty or #key:value:seen:rest:"
]

{ #category : #accessing }
αRenames >> at: anObject [
	^self at: anObject ifAbsent:[ KeyNotFound signalFor: anObject ].

]

{ #category : #accessing }
αRenames >> at: anObject ifAbsent: aBlock [
	rest == nil ifTrue:[
		^aBlock value
	].

	key = anObject ifTrue:[
		^value
	].

	^rest at: anObject ifAbsent: aBlock


]

{ #category : #initialization }
αRenames >> empty [
	seen := Set new.


]

{ #category : #accessing }
αRenames >> extMap: original to: unique [
	"Extend current α-renames with new mapping.
	 Return new α-renames."

	^self class key: original value: unique seen: seen rest: self.
]

{ #category : #GT }
αRenames >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite fastTable
		title: 'Renames';
		display: [
			| items |

			items := Dictionary new.
			self keysAndValuesDo: [ :k :v |
				items at: k ifAbsentPut: v
			].
			items associations.
		];
		column: 'Key' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ];
		yourself.
]

{ #category : #initialization }
αRenames >> key: keyArg value: valueArg seen: seenArg rest: restArg [
	self assert: keyArg notNil.
	self assert: valueArg notNil.
	self assert: seenArg isCollection.
	self assert: restArg notNil.

	key := keyArg.
	value := valueArg.
	seen := seenArg.
	rest := restArg

]

{ #category : #enumerating }
αRenames >> keysAndValuesDo: aBlock [
	rest ~~ nil ifTrue:[
		aBlock value: key value: value.
		rest keysAndValuesDo: aBlock
	]
]

{ #category : #utilities }
αRenames >> makeUnique: id [
	"Given an identifier `id`, return (possibly new) unique identifier."

	(seen includes: id) ifTrue:[
		^ VariableAlphabet uniqueVariableNameFor: id
	] ifFalse: [
		seen add: id.
		^id.
	]


]
