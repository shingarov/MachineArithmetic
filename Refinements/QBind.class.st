Class {
	#name : #QBind,
	#superclass : #Object,
	#instVars : [
		'eQuals'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
QBind class >> fromEQuals: eQuals [ 
	^self basicNew eQuals: eQuals; yourself
]

{ #category : #'instance creation' }
QBind class >> new [
	self shouldNotImplement 
]

{ #category : #accessing }
QBind >> eQuals [
	^ eQuals
]

{ #category : #accessing }
QBind >> eQuals: anObject [
	eQuals := anObject
]
