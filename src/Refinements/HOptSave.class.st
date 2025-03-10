Class {
	#name : #HOptSave,
	#superclass : #HOpt,
	#category : #'Refinements-Horn'
}

{ #category : #construction }
HOptSave >> addToOptions: options [
	options save: self
]
