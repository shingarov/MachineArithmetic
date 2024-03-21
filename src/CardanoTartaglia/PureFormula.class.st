Class {
	#name : #PureFormula,
	#superclass : #Object,
	#category : #CardanoTartaglia
}

{ #category : #adapting }
PureFormula >> adaptToBitVector: receiver length: length andSend: selector [
	"Prevent eager adaptatToBitVector from happening."
	^FormalSendResult
		message: (Message selector: #adaptToBitVector:length:andSend: arguments: {receiver . length . selector})
		sentTo: self
]

{ #category : #adapting }
PureFormula >> adaptToBool: receiver andSend: selector [
	"Prevent eager adaptatToBool from happening."
	^FormalSendResult
		message: (Message selector: #adaptToBool:andSend: arguments: {receiver . selector})
		sentTo: self
]

{ #category : #adapting }
PureFormula >> adaptToInt: receiver andSend: selector [
	"Prevent eager adaptatToInt from happening."
	^FormalSendResult
		message: (Message selector: #adaptToInt:andSend: arguments: {receiver . selector})
		sentTo: self
]

{ #category : #adapting }
PureFormula >> adaptToReal: receiver andSend: selector [
	"Prevent eager adaptatToReal from happening."
	^FormalSendResult
		message: (Message selector: #adaptToReal:andSend: arguments: {receiver . selector})
		sentTo: self
]

{ #category : #'reflective operations' }
PureFormula >> doesNotUnderstand: aMessage [
	^FormalSendResult
		message: aMessage
		sentTo: self
]
