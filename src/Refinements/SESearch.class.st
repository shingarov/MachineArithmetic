Class {
	#name : #SESearch,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #'case switching' }
SESearch >> ifFound: foundBlock alts: altsBlock [
	self subclassResponsibility
]
