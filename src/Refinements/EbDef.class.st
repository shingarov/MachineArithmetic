Class {
	#name : #EbDef,
	#superclass : #EbindSol,
	#instVars : [
		'cs',
		'sym'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EbDef class >> cs: aSet sym: sym [
	^self basicNew
		cs: aSet; sym: sym; yourself 
]

{ #category : #accessing }
EbDef >> cs [
	^ cs
]

{ #category : #accessing }
EbDef >> cs: anObject [
	cs := anObject
]

{ #category : #accessing }
EbDef >> sym [
	^ sym
]

{ #category : #accessing }
EbDef >> sym: anObject [
	sym := anObject
]
