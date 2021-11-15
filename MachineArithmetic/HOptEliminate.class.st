Class {
	#name : #HOptEliminate,
	#superclass : #HOpt,
	#instVars : [
		'what'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #construction }
HOptEliminate >> addToQuery: aNNFQuery [ 
	aNNFQuery options eliminate: self
]

{ #category : #logic }
HOptEliminate >> eliminate: q [ 
	what = 'existentials' ifTrue: [ self shouldBeImplemented ].
	what = 'horn' ifTrue: [ ^q elimKVars ].
	^q
]

{ #category : #accessing }
HOptEliminate >> useElim [
	^what notNil
]

{ #category : #accessing }
HOptEliminate >> what [
	^ what
]

{ #category : #accessing }
HOptEliminate >> what: anObject [
	what := anObject
]
