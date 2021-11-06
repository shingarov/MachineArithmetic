Class {
	#name : #QualParam,
	#superclass : #HThing,
	#instVars : [
		'symbol',
		'pattern',
		'sort'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
QualParam class >> symbol: sym sort: srt [
	^self basicNew 
		symbol: sym;
		sort: srt;
		yourself
]

{ #category : #accessing }
QualParam >> pattern [
	^ pattern
]

{ #category : #accessing }
QualParam >> pattern: anObject [
	pattern := anObject
]

{ #category : #accessing }
QualParam >> sort [
	^ sort
]

{ #category : #accessing }
QualParam >> sort: anObject [
	sort := anObject
]

{ #category : #accessing }
QualParam >> symbol [
	^ symbol
]

{ #category : #accessing }
QualParam >> symbol: anObject [
	symbol := anObject
]
