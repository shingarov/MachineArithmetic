Class {
	#name : #Env,
	#superclass : #BlockClosure,
	#type : #variable,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
Env >> checkSym: x [ 
	^(self value: x)
		ifFound: [ :s | s instantiate ]
		alts: [ :xs | self error ]
]
