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

{ #category : #elaboration }
EMessageSend >> elab: anElabEnv [
	^messageSend elab: anElabEnv
]

{ #category : #elaboration }
EMessageSend >> elabApply: γ [
	^self class of: (messageSend elabApply: γ)
]

{ #category : #uncurrying }
EMessageSend >> elabApplyStep: γ [ 
	^EMessageSend of: (messageSend elabApplyStep: γ)
]

{ #category : #accessing }
EMessageSend >> messageSend [
	^ messageSend
]

{ #category : #accessing }
EMessageSend >> messageSend: anObject [
	messageSend := anObject
]

{ #category : #'SMT interface' }
EMessageSend >> smt2: γ [
	^(messageSend receiver smt2: γ)
		perform: messageSend selector
		withArguments: (messageSend arguments collect: [ :arg | arg smt2: γ ])
]
