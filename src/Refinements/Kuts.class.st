Class {
	#name : #Kuts,
	#superclass : #Object,
	#instVars : [
		'ksVars'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Kuts class >> new [
	^self vars: Set new
]

{ #category : #'instance creation' }
Kuts class >> vars: aSet [
	^self basicNew ksVars: aSet; yourself 
]

{ #category : #semigroup }
Kuts >> , another [
	^Kuts vars: (ksVars union: another ksVars)
]

{ #category : #testing }
Kuts >> includes: k [
	^ksVars includes: k

]

{ #category : #testing }
Kuts >> isEmpty [ 
	^ksVars isEmpty

]

{ #category : #accessing }
Kuts >> ksVars [
	^ ksVars
]

{ #category : #accessing }
Kuts >> ksVars: anObject [
	ksVars := anObject
]

{ #category : #printing }
Kuts >> printOn: aStream [
	self isEmpty ifTrue: [^aStream nextPut: Character emptySet].
	aStream nextPut: ${.
	ksVars
		do: [ :v | aStream nextPutAll: v ]
		separatedBy: [ aStream nextPutAll: ', '. ].
	aStream nextPut: $}.
]
