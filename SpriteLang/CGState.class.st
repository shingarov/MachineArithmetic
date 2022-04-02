Class {
	#name : #CGState,
	#superclass : #Object,
	#instVars : [
		'count',
		'kVars'
	],
	#classVars : [
		'current'
	],
	#category : #SpriteLang
}

{ #category : #initialization }
CGState class >> current [
	current isNil ifTrue: [ current := self new ].
	^current
]

{ #category : #initialization }
CGState class >> reset [ 
	current := nil
]

{ #category : #accessing }
CGState >> addSrcKVar: k [
	self kVars add: k
]

{ #category : #accessing }
CGState >> count [
	count isNil ifTrue: [ count := 0 ].
	^ count
]

{ #category : #accessing }
CGState >> count: anObject [
	count := anObject
]

{ #category : #generating }
CGState >> freshInt [
	| n |
	n := self count.
	self count: n+1.
	^n
]

{ #category : #generating }
CGState >> freshValueSym [
	^self freshInt vv
]

{ #category : #accessing }
CGState >> kVars [
	kVars isNil ifTrue: [ kVars := OrderedCollection new ].
	^ kVars
]

{ #category : #accessing }
CGState >> kVars: anObject [
	kVars := anObject
]
