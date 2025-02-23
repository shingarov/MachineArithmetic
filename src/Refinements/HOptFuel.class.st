Class {
	#name : #HOptFuel,
	#superclass : #HOpt,
	#instVars : [
		'n'
	],
	#category : #Refinements
}

{ #category : #construction }
HOptFuel >> addToOptions: options [
	options fuel: self
]

{ #category : #accessing }
HOptFuel >> n [
	^ n
]

{ #category : #accessing }
HOptFuel >> n: anObject [
	n := anObject
]
