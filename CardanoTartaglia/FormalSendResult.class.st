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
