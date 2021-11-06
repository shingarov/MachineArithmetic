Class {
	#name : #HCstr,
	#superclass : #HThing,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
HCstr class >> body: b [
	^self basicNew
		body: b
]

{ #category : #logic }
HCstr >> addToQuery: aNNFQuery [ 
	aNNFQuery qCstr add: self
]

{ #category : #logic }
HCstr >> boundKVars [
	self subclassResponsibility
]

{ #category : #logic }
HCstr >> flatConstraint [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HCstr >> goS1: aCollection _: anIBindEnv _: aSortedReft _: aBindEnv [ 
	self subclassResponsibility 
]

{ #category : #logic }
HCstr >> isNNF [
	"Answer whether the constraint does not contain any existential binders."
	self 
]

{ #category : #printing }
HCstr >> printMeatOn: aStream [
	self subclassResponsibility 
]

{ #category : #printing }
HCstr >> printOn: aStream [
	aStream nextPutAll: 'constraint '.
	self printMeatOn: aStream
]

{ #category : #logic }
HCstr >> simplify [
	"Cleanup Horn constraint.
	We want to simplify the Query a little bit, and make sure it is Horn,
	that is, only a kvar-free (ie concrete) predicate or a single kvar in each head."
	^ self flatConstraint pruneTauts removeDuplicateBinders
]

{ #category : #logic }
HCstr >> ↑ [ κ
	"Answer the uses of κ in the receiver."
	self shouldBeImplemented 
]

{ #category : #logic }
HCstr >> ↓ [ κ
	"Answer the definitions of κ in the receiver."
	self shouldBeImplemented 
]
