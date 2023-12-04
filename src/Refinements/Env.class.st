Class {
	#name : #Env,
	#superclass : #BlockClosure,
	#type : #variable,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
Env >> checkSym: x [
	^x∘self
		ifFound: #instantiate
		alts: #error
]
