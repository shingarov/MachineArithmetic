Class {
	#name : #Elims,
	#superclass : #Object,
	#instVars : [
		'depCuts',
		'depNonCuts'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #accessing }
Elims >> depCuts [
	^ depCuts
]

{ #category : #accessing }
Elims >> depCuts: anObject [
	depCuts := anObject
]

{ #category : #accessing }
Elims >> depNonCuts [
	^ depNonCuts
]

{ #category : #accessing }
Elims >> depNonCuts: anObject [
	depNonCuts := anObject
]
