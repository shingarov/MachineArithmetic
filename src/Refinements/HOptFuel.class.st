Class {
	#name : #HOptFuel,
	#superclass : #HOpt,
	#instVars : [
		'n'
	],
	#category : #Refinements
}

{ #category : #construction }
HOptFuel >> addToQuery: aNNFQuery [ 
	aNNFQuery options fuel: self
]

{ #category : #accessing }
HOptFuel >> n [
	^ n
]

{ #category : #accessing }
HOptFuel >> n: anObject [
	n := anObject
]
