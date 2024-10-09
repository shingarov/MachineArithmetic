Class {
	#name : #HCon,
	#superclass : #HThing,
	#instVars : [
		'symbol',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
HCon class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
HCon class >> symbol: sym sort: srt [
	^self basicNew
		symbol: sym;
		sort: srt;
		yourself 
]

{ #category : #construction }
HCon >> addToQuery: aHornQuery [ 
	aHornQuery qCon at: symbol put: sort
]

{ #category : #accessing }
HCon >> sort [
	^ sort
]

{ #category : #accessing }
HCon >> sort: anObject [
	sort := anObject
]

{ #category : #accessing }
HCon >> symbol [
	^ symbol
]

{ #category : #accessing }
HCon >> symbol: anObject [
	symbol := anObject
]
