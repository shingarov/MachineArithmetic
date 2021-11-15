Class {
	#name : #QueryOptions,
	#superclass : #Object,
	#instVars : [
		'eliminate',
		'fuel',
		'save'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #accessing }
QueryOptions >> eliminate [
	eliminate isNil ifTrue: [ eliminate := HOptEliminate new ].
	^ eliminate
]

{ #category : #accessing }
QueryOptions >> eliminate: aHOptEliminate [
	eliminate isNil ifFalse: [ self error: 'Duplicate --eliminate' ].
	eliminate := aHOptEliminate
]

{ #category : #accessing }
QueryOptions >> fuel: aHOptFuel [
	fuel isNil ifFalse: [ self error: 'Duplicate --fuel' ].
	fuel := aHOptFuel
]

{ #category : #accessing }
QueryOptions >> save: aHOptSave [
	save isNil ifFalse: [ self error: 'Duplicate --save' ].
	save := aHOptSave
]
