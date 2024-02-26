Class {
	#name : #'αRenames',
	#superclass : #Object,
	#instVars : [
		'key',
		'value',
		'rest'
	],
	#classVars : [
		'Sentinel'
	],
	#category : #'SpriteLang-Parsing'
}

{ #category : #'instance creation' }
αRenames class >> empty [
	^Sentinel
]

{ #category : #initialization }
αRenames class >> initialize [
	Sentinel := self basicNew
]

{ #category : #'instance creation' }
αRenames class >> key: key value: value rest: rest [
	^self basicNew key: key value: value rest: rest
]

{ #category : #'instance creation' }
αRenames class >> new [
	self shouldNotImplement. "Use #empty or #key:value:rest:"
]

{ #category : #accessing }
αRenames >> at: anObject [
	^self at: anObject ifAbsent:[ KeyNotFound signalFor: anObject ].

]

{ #category : #accessing }
αRenames >> at: anObject ifAbsent: aBlock [
	self == Sentinel ifTrue:[
		^aBlock value
	].

	key = anObject ifTrue:[
		^value
	].

	^rest at: anObject ifAbsent: aBlock


]

{ #category : #accessing }
αRenames >> extMap: original to: unique [
	"Extend current α-renames with new mapping.
	 Return new α-renames."

	^self class key: original value: unique rest: self.
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
αRenames >> key: keyArg value: valueArg rest: restArg [
	key := keyArg.
	value := valueArg.
	rest := restArg

]

{ #category : #enumerating }
αRenames >> keysAndValuesDo: aBlock [
	self ~~ Sentinel ifTrue:[
		aBlock value: key value: value.
		rest keysAndValuesDo: aBlock
	]
]
