Class {
	#name : #Worklist,
	#superclass : #Object,
	#instVars : [
		'cs',
		'pend',
		'deps',
		'cm',
		'rankm',
		'last',
		'ranks',
		'time',
		'concCs'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
Worklist >> initializeFrom: sI [
	| cd |
	cm := sI query cm.
	cd := sI deps.
	"BOGUS"
	"self shouldBeImplemented."
]

{ #category : #'as yet unclassified' }
Worklist >> push: aSimpC [
self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
Worklist >> unsatCandidates [
	"Candidate Constraints to be checked AFTER computing Fixpoint.
	Answer a collection of SimpC's"
	
	"BOGUS -- should partition List etc etc."
	^cm values
]
