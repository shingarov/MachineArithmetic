Class {
	#name : #SInfo1,
	#superclass : #SInfo,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
SInfo1 >> elaborate: senv [
	^(self as: SInfo5)
		elaboratedVars: senv;
		elaborate	
]
