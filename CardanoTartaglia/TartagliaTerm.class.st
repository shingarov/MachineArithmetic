Class {
	#name : #TartagliaTerm,
	#superclass : #Object,
	#category : #CardanoTartaglia
}

{ #category : #forwarding }
TartagliaTerm >> at: index [
	^KeywordTerm
		representing: (Message selector: #at: argument: index)
		sentTo: self
]

{ #category : #forwarding }
TartagliaTerm >> doesNotUnderstand: aMessage [
	aMessage selector isBinary ifTrue: [ ^BinaryTerm representing: aMessage sentTo: self ].
	aMessage selector isKeyword  ifTrue: [ ^KeywordTerm representing: aMessage sentTo: self ].
	self shouldBeImplemented 
]

{ #category : #accessing }
TartagliaTerm >> variables [ 	
	self subclassResponsibility 
]
