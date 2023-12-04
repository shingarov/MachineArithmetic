Class {
	#name : #PureFormula,
	#superclass : #Object,
	#category : #CardanoTartaglia
}

{ #category : #'reflective operations' }
PureFormula >> doesNotUnderstand: aMessage [
	^FormalSendResult
		message: aMessage
		sentTo: self
]
