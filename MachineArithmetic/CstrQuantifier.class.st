Class {
	#name : #CstrQuantifier,
	#superclass : #HCstr,
	#instVars : [
		'bind',
		'p'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
CstrQuantifier class >> bind: b p: p [
	^self basicNew 
		bind: b;
		p: p;
		yourself 
]

{ #category : #accessing }
CstrQuantifier >> bind [
	^ bind
]

{ #category : #accessing }
CstrQuantifier >> bind: anObject [
	bind := anObject
]

{ #category : #logic }
CstrQuantifier >> boundKVars [
	^ self bind p pKVars, self p boundKVars
]

{ #category : #GT }
CstrQuantifier >> children [ 
	^Array with: p
]

{ #category : #accessing }
CstrQuantifier >> flatConstraint [ 
	^self class 
		bind: (HBind x: bind x τ: bind τ p: bind p flatConstraint)
		p: p flatConstraint
]

{ #category : #printing }
CstrQuantifier >> mathSymbol [
	self subclassResponsibility
]

{ #category : #accessing }
CstrQuantifier >> p [
	^ p
]

{ #category : #accessing }
CstrQuantifier >> p: anObject [
	p := anObject
]

{ #category : #printing }
CstrQuantifier >> printMeatOn: aStream [
	aStream nextPut: self mathSymbol.
	self bind printOn: aStream.
	aStream nextPutAll: ' : ...'
]
