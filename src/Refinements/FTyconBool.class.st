"
boolFTyCon = TC (dummyLoc boolLConName) defTcInfo
"
Class {
	#name : #FTyconBool,
	#superclass : #FTycon,
	#category : #Refinements
}

{ #category : #names }
FTyconBool class >> conName [
	^'bool'
]

{ #category : #'type algebra' }
FTyconBool >> fTyconSort [
	^Bool sort
]
