"
Z3 failed to either prove or disprove a judgement.
"
Class {
	#name : #UnknownValidity,
	#superclass : #Error,
	#instVars : [
		'model'
	],
	#category : #'Z3-Core'
}

{ #category : #accessing }
UnknownValidity class >> model: argument [
	^self new model: argument; yourself
]

{ #category : #accessing }
UnknownValidity class >> signalWithModel: argument [

	^(self model: argument) signal
]

{ #category : #accessing }
UnknownValidity >> model [
	^ model
]

{ #category : #accessing }
UnknownValidity >> model: anObject [
	model := anObject
]
