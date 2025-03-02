"
intFTyCon  = TC (dummyLoc ""int""       ) numTcInfo
"
Class {
	#name : #FTyconInt,
	#superclass : #FTycon,
	#category : #Refinements
}

{ #category : #names }
FTyconInt class >> conName [
	^'int'
]

{ #category : #'type algebra' }
FTyconInt >> fTyconSort [
	^Int sort
]
