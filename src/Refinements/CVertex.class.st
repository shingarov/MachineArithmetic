Class {
	#name : #CVertex,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
CVertex >> <= anotherVertex [ 
	^self printString, self hash printString <= (anotherVertex printString, anotherVertex hash printString)
]

{ #category : #testing }
CVertex >> isCstr [
	^false
]

{ #category : #testing }
CVertex >> isKVar [
	^false
]
