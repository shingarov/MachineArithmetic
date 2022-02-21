Class {
	#name : #EQual,
	#superclass : #Object,
	#instVars : [
		'qual',
		'pred',
		'args'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EQual class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
EQual class >> qual: qual pred: pred args: args [
	^self basicNew qual: qual; pred: pred; args: args; yourself 
]

{ #category : #accessing }
EQual >> args [
	^ args
]

{ #category : #accessing }
EQual >> args: anObject [
	args := anObject
]

{ #category : #accessing }
EQual >> pred [
	^ pred
]

{ #category : #accessing }
EQual >> pred: anObject [
	pred := anObject
]

{ #category : #accessing }
EQual >> qual [
	^ qual
]

{ #category : #accessing }
EQual >> qual: anObject [
	qual := anObject
]
