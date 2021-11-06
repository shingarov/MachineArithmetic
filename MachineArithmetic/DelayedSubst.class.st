Class {
	#name : #DelayedSubst,
	#superclass : #HPred,
	#instVars : [
		'pred',
		'from',
		'to'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
DelayedSubst >> evaluateIn: aBindEnv [ 
	^(self pred evaluateIn: aBindEnv)
		substitute: (aBindEnv variableNamed: self from)
		with: (aBindEnv variableNamed: self to)
]

{ #category : #accessing }
DelayedSubst >> from [
	^ from
]

{ #category : #accessing }
DelayedSubst >> from: anObject [
	from := anObject
]

{ #category : #accessing }
DelayedSubst >> pred [
	^ pred
]

{ #category : #accessing }
DelayedSubst >> pred: anObject [
	pred := anObject
]

{ #category : #printing }
DelayedSubst >> printOn: aStream [
	self pred printOn: aStream.
	aStream nextPut: $[.
	self to printOn: aStream.
	aStream nextPut: $/.
	self from printOn: aStream.
	aStream nextPut: $].
]

{ #category : #'as yet unclassified' }
DelayedSubst >> subst1: new for: old [
	^DelayedSubst new
		from: old;
		to: new;
		pred: self;
		yourself
]

{ #category : #accessing }
DelayedSubst >> to [
	^ to
]

{ #category : #accessing }
DelayedSubst >> to: anObject [
	to := anObject
]
