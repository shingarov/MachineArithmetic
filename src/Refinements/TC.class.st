Class {
	#name : #TC,
	#superclass : #FTycon,
	#instVars : [
		'sym'
	],
	#category : #Refinements
}

{ #category : #comparing }
TC >> = rhs [
"
instance Eq FTycon where
  (TC s _) == (TC s' _) = val s == val s'
"
	self class = rhs class ifFalse: [ ^false ].
	^sym = rhs sym
]

{ #category : #'as yet unclassified' }
TC >> fTyconSort [
	^FTC new: self
]

{ #category : #comparing }
TC >> hash [
	^sym hash
]

{ #category : #'as yet unclassified' }
TC >> isListTC [
	^sym isListConName
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
