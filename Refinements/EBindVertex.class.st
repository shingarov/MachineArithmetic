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

{ #category : #accessing }
EBindVertex >> symbol [
	^ symbol
]

{ #category : #accessing }
EBindVertex >> symbol: anObject [
	symbol := anObject
]
