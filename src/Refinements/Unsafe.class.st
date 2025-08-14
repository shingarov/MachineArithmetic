Class {
	#name : #Unsafe,
	#superclass : #FixResult,
	#instVars : [
		'bads'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Unsafe class >> bads: aCollection [
	^self basicNew
		bads: aCollection;
		yourself
]

{ #category : #'instance creation' }
Unsafe class >> new [
	self shouldNotImplement
]

{ #category : #accessing }
Unsafe >> bads [
	^ bads
]

{ #category : #accessing }
Unsafe >> bads: anObject [
	bads := anObject
]

{ #category : #GT }
Unsafe >> gtInspectorCounterexampleIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite text
		title: 'Counterexample';
		display: [ self bads size = 1
			ifTrue: [ self bads first value value toString ]
			ifFalse: [ self bads size printString, ' bads?' ] ]

]

{ #category : #testing }
Unsafe >> isSafe [
	^false
]
