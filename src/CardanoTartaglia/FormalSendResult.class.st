Class {
	#name : #FormalSendResult,
	#superclass : #PureFormula,
	#instVars : [
		'receiver',
		'message'
	],
	#category : #CardanoTartaglia
}

{ #category : #'instance creation' }
FormalSendResult class >> message: m sentTo: r [ 
	^self basicNew
		receiver: r;
		message: m;
		yourself
]

{ #category : #converting }
FormalSendResult >> adaptToBitVector: rec length: len andSend: sel [
	^FormalSendResult
		message: (Message selector: #adaptToBitVector:length:andSend: arguments:{rec . len. sel })
		sentTo: self

]

{ #category : #converting }
FormalSendResult >> adaptToBool: rec andSend: sel [
	^FormalSendResult
		message: (Message selector: #adaptToBool:andSend: arguments:{rec . sel })
		sentTo: self

]

{ #category : #converting }
FormalSendResult >> adaptToInt: rec andSend: sel [
	^FormalSendResult
		message: (Message selector: #adaptToInt:andSend: arguments:{rec . sel })
		sentTo: self

]

{ #category : #accessing }
FormalSendResult >> message [
	^ message
]

{ #category : #accessing }
FormalSendResult >> message: anObject [
	message := anObject
]

{ #category : #accessing }
FormalSendResult >> receiver [
	^ receiver
]

{ #category : #accessing }
FormalSendResult >> receiver: anObject [
	receiver := anObject
]
