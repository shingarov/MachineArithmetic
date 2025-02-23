Class {
	#name : #HOptSave,
	#superclass : #HOpt,
	#category : #Refinements
}

{ #category : #construction }
HOptSave >> addToOptions: options [
	options save: self
]
