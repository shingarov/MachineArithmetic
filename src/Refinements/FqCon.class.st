Class {
	#name : #FqCon,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FqCon class >> symbol: sym sort: srt [
	^self basicNew
		symbol: sym;
		sort: srt;
		yourself
		
]

{ #category : #accessing }
FqCon >> sort [
	^ sort
]

{ #category : #accessing }
FqCon >> sort: anObject [
	sort := anObject
]

{ #category : #accessing }
FqCon >> symbol [
	^ symbol
]

{ #category : #accessing }
FqCon >> symbol: anObject [
	symbol := anObject
]
