"
existentially bound ""ghost parameter"" to solve for
"
Class {
	#name : #EBindVertex,
	#superclass : #CVertex,
	#instVars : [
		'symbol'
	],
	#category : #Refinements
}

{ #category : #accessing }
EBindVertex class >> symbol: s [
	^self basicNew symbol: s; yourself
]

{ #category : #comparing }
EBindVertex >> = anObject [
	self class == anObject class ifFalse: [ ^false ].
	^symbol = anObject symbol
]

{ #category : #comparing }
EBindVertex >> hash [
	^symbol hash
]

{ #category : #accessing }
EBindVertex >> symbol [
	^ symbol
]

{ #category : #accessing }
EBindVertex >> symbol: anObject [
	symbol := anObject
]
