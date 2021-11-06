Class {
	#name : #DecidableRefinement,
	#superclass : #HPred,
	#instVars : [
		'text'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
DecidableRefinement class >> text: t [
	^self basicNew 
		text: t;
		yourself 
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> evaluateIn: aBindEnv [ 
	^aBindEnv evaluate: self text
]

{ #category : #testing }
DecidableRefinement >> isTauto [
self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> predExpr: kvEnv [
	^self
]

{ #category : #printing }
DecidableRefinement >> printOn: aStream [ 
	aStream
		nextPut: $«;
		nextPutAll: self text;
		nextPut: $»
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> subst1: new for: old [
	^DelayedSubst new
		from: old;
		to: new;
		pred: self;
		yourself
]

{ #category : #accessing }
DecidableRefinement >> text [
	^ text
]

{ #category : #accessing }
DecidableRefinement >> text: anObject [
	text := anObject
]

{ #category : #'well-formedness' }
DecidableRefinement >> wfIn: gamma [
self shouldBeImplemented "true if self is a bool-(unrefined-)typed formula"
]
