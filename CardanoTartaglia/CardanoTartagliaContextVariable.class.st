Class {
	#name : #CardanoTartagliaContextVariable,
	#superclass : #TemporaryVariable,
	#instVars : [
		'context'
	],
	#category : #CardanoTartaglia
}

{ #category : #'instance creation' }
CardanoTartagliaContextVariable class >> named: tempName [
	self shouldNotImplement. "Use named:in: instead!" 
]

{ #category : #'instance creation' }
CardanoTartagliaContextVariable class >> named: tempName in: context [
	^ (super named: tempName)
			context: context;
			yourself.
]

{ #category : #initialization }
CardanoTartagliaContextVariable >> context: aCardanoTartagliaContext [
	self assert: (aCardanoTartagliaContext isKindOf: CardanoTartagliaContext).
	context := aCardanoTartagliaContext 
]

{ #category : #'reading-writing' }
CardanoTartagliaContextVariable >> readInContext: contextGiven [
	self assert: (contextGiven == context).
	^context tempNamed: name
]
