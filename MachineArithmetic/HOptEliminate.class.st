Class {
	#name : #HOptEliminate,
	#superclass : #HOpt,
	#instVars : [
		'what'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
HOptEliminate >> addToQuery: aNNFQuery [ 
	aNNFQuery optionEliminate: self
]

{ #category : #'as yet unclassified' }
HOptEliminate >> eliminate: q [ 
	what = 'existentials' ifTrue: [ self shouldBeImplemented ].
	what = 'horn' ifTrue: [ q elimKVars ].
	^q
]

{ #category : #accessing }
HOptEliminate >> what [
	^ what
]

{ #category : #accessing }
HOptEliminate >> what: anObject [
	what := anObject
]
