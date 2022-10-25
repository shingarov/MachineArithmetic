Class {
	#name : #SInfo5,
	#superclass : #SInfo,
	#instVars : [
		'elaboratedVars'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
SInfo5 >> elaborate [
	[
	PreSort resetHotel.
	cm elaborate.
	bs adjustElaboratedSorts.
	"asserts elaborate??? ;"
	] runReader: #SymEnv initialState: elaboratedVars
]

{ #category : #accessing }
SInfo5 >> elaboratedVars [
	^ elaboratedVars
]

{ #category : #accessing }
SInfo5 >> elaboratedVars: anObject [
	elaboratedVars := anObject
]
