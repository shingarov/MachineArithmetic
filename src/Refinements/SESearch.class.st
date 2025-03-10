"
data SESearch a = Found a | Alts [Symbol]

Cf. Types/Environments.hs
"
Class {
	#name : #SESearch,
	#superclass : #Object,
	#category : #'Refinements-Environments'
}

{ #category : #'case switching' }
SESearch >> ifFound: foundBlock alts: altsBlock [
	self subclassResponsibility
]
