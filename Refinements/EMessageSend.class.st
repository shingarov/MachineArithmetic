Class {
	#name : #EMessageSend,
	#superclass : #Expr,
	#instVars : [
		'messageSend'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EMessageSend class >> of: aMessageSend [
	^self basicNew
		messageSend: aMessageSend;
		yourself
]

{ #category : #accessing }
EMessageSend >> messageSend [
	^ messageSend
]

{ #category : #accessing }
EMessageSend >> messageSend: anObject [
	messageSend := anObject
]
