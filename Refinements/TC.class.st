Class {
	#name : #TC,
	#superclass : #FTycon,
	#instVars : [
		'sym'
	],
	#category : #Refinements
}

{ #category : #printing }
TC >> printOn: aStream [
	aStream nextPutAll: 'TC '.
	aStream nextPutAll: sym
]

{ #category : #'type algebra' }
TC >> sort [
"
fTyconSort :: FTycon -> Sort
fTyconSort c
  | c == intFTyCon  = FInt
  | c == realFTyCon = FReal
  | c == numFTyCon  = FNum
  | otherwise       = FTC c  ← we are here
"
	^FTC new: self
]

{ #category : #accessing }
TC >> sym [
	^ sym
]

{ #category : #accessing }
TC >> sym: anObject [
	sym := anObject
]
