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

{ #category : #'as yet unclassified' }
QBind >> evaluateIn: evalEnv [
	^QBind fromEQuals: (eQuals collect: [ :eQual | eQual evaluateIn: evalEnv  ])
]

{ #category : #'as yet unclassified' }
QBind >> qbSize [
	^eQuals size
]

{ #category : #'as yet unclassified' }
QBind >> select: aPredicate [
"cf. qbFilter :: (EQual -> Bool) -> QBind -> QBind"
	^QBind fromEQuals: (eQuals select: aPredicate)
]
