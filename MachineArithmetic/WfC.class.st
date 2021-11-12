Class {
	#name : #WfC,
	#superclass : #Object,
	#instVars : [
		'env',
		'rft',
		'info'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
WfC class >> be: anIBindEnv sr: aSortedReft x: meta [
"Nonono. We are not calling this smartass constructor yet."
	self shouldBeImplemented.
]

{ #category : #accessing }
WfC >> env [
	^ env
]

{ #category : #accessing }
WfC >> env: anObject [
	env := anObject
]

{ #category : #accessing }
WfC >> info [
	^ info
]

{ #category : #accessing }
WfC >> info: anObject [
	info := anObject
]

{ #category : #printing }
WfC >> printOn: aStream [
	aStream nextPutAll: 'wf: ['.
	env indexes printOn: aStream delimiter: ','.
	aStream nextPutAll: '] {'.
	aStream nextPutAll: rft first.
	aStream nextPutAll: ' : '.
	rft second printOn: aStream.
	aStream nextPutAll: ' | [$'.
	aStream nextPutAll: rft third.
	aStream nextPutAll: ']}'.
]

{ #category : #accessing }
WfC >> rft [
	^ rft
]

{ #category : #accessing }
WfC >> rft: anObject [
	rft := anObject
]
