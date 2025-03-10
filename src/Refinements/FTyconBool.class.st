"
boolFTyCon = TC (dummyLoc boolLConName) defTcInfo
"
Class {
	#name : #FTyconBool,
	#superclass : #SingletonFTycon,
	#category : #'Refinements-Sorts'
}

{ #category : #names }
FTyconBool class >> conName [
	^'bool'
]

{ #category : #'type algebra' }
FTyconBool >> fTyconSort [
	^Bool sort
]
