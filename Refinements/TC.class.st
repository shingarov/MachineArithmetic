Class {
	#name : #TC,
	#superclass : #FTycon,
	#instVars : [
		'sym'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
TC >> fTyconSort [
	^FTC new: self
]

{ #category : #printing }
TC >> printOn: aStream [
	aStream nextPutAll: 'TC '.
	aStream nextPutAll: sym
]

{ #category : #accessing }
TC >> sym [
	^ sym
]

{ #category : #accessing }
TC >> sym: anObject [
	sym := anObject
]
