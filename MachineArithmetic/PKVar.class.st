Class {
	#name : #PKVar,
	#superclass : #Object,
	#instVars : [
		'var',
		's'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
PKVar class >> var: v subst: s [
	^self basicNew
		var: v;
		s: s;
		yourself
]

{ #category : #printing }
PKVar >> printOn: aStream [ 
	aStream nextPut: $$.
	aStream nextPutAll: var.
	s printOn: aStream
]

{ #category : #accessing }
PKVar >> s [
	^ s
]

{ #category : #accessing }
PKVar >> s: anObject [
	s := anObject
]

{ #category : #'term rewriting' }
PKVar >> subst1: new for: old [
	"cf. Substitutions.hs:163"
	^self subst: (Dictionary newFromAssociations: {new->old.})
]

{ #category : #'term rewriting' }
PKVar >> subst: su [
	| su1 |
	su1 := s.
self halt.
	^PKVar
		var: var
		subst: (su1 catSubst: su)
]

{ #category : #accessing }
PKVar >> var [
	^ var
]

{ #category : #accessing }
PKVar >> var: anObject [
	var := anObject
]
