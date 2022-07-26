Class {
	#name : #QueryOptions,
	#superclass : #Object,
	#instVars : [
		'eliminate',
		'fuel',
		'save'
	],
	#category : #Refinements
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

{ #category : #'as yet unclassified' }
QueryOptions >> rewrite: aHOptRewrite [ 
	"allow axiom instantiation via rewriting"
	self flag: #todo
]

{ #category : #accessing }
QueryOptions >> save: aHOptSave [
	save isNil ifFalse: [ self error: 'Duplicate --save' ].
	save := aHOptSave
]
