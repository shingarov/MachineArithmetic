Class {
	#name : #CstrAny,
	#superclass : #CstrQuantifier,
	#category : #Refinements
}

{ #category : #logic }
CstrAny >> isNNF [ 
	^ false
]

{ #category : #printing }
CstrAny >> mathSymbol [
	^Character value: 16r2203
]
