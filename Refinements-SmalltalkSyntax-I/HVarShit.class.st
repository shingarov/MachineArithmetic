Class {
	#name : #HVarShit,
	#superclass : #Object,
	#instVars : [
		'hvar',
		'block'
	],
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'as yet unclassified' }
HVarShit class >> hvar: hvar block: aBlock [
	^self basicNew
		hvar: hvar;
		block: aBlock;
		yourself
]

{ #category : #accessing }
HVarShit >> block [
	^ block
]

{ #category : #accessing }
HVarShit >> block: anObject [
	block := anObject
]

{ #category : #accessing }
HVarShit >> hvar [
	^ hvar
]

{ #category : #accessing }
HVarShit >> hvar: anObject [
	hvar := anObject
]
