Class {
	#name : #HOptSave,
	#superclass : #HOpt,
	#category : #Refinements
}

{ #category : #construction }
HOptSave >> addToQuery: aNNFQuery [ 
	aNNFQuery options save: self
]
