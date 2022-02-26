Class {
	#name : #Subst,
	#superclass : #Object,
	#instVars : [
		'list'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Subst class >> mkSubst: associations [
	"Make a Subst from the argument which is a sequence of Associations of the form, varName->EVar.
	cf. Types/Substitutions.hs (not the other one)"
	| nonTrivial |
	nonTrivial := associations reject: [ :ass | ass key = ass value varName ].
	^self basicNew list: nonTrivial reversed
]

{ #category : #printing }
Subst class >> printAssociation: from_to on: aStream [
	aStream nextPut: $[.
	aStream nextPutAll: from_to key.
	aStream nextPutAll: ':='.
	from_to value printOn: aStream.
	aStream nextPut: $]
	
]

{ #category : #comparing }
Subst >> = rhs [
	rhs class == self class ifFalse: [ ^false ].
	^list = rhs list
	
]

{ #category : #copying }
Subst >> cat: θ2 [
	| s1 s2 s1_ |
	s1 := self list.
	s2 := θ2 list.
	s1_ := s1 collect: [ :ass | ass subst: θ2 ].
	^Subst mkSubst: (s1_ asSet union: s2 asSet) asArray
]

{ #category : #comparing }
Subst >> hash [
	^list hash
]

{ #category : #collection }
Subst >> isEmpty [ 
	^self list isEmpty
]

{ #category : #accessing }
Subst >> list [
	^ list
]

{ #category : #accessing }
Subst >> list: l [
	list := l.
	^self
]

{ #category : #printing }
Subst >> printOn: aStream [
	self isEmpty ifTrue: [ ^aStream nextPut: (Character value: 16r2261) ].
	list do: [ :k_v | self class printAssociation: k_v on: aStream
	]
]

{ #category : #collection }
Subst >> select: twoArgBlock [
	"The two-arg block takes a from-symbol and a to-expr and answers a Boolean."
	| filteredList |
	filteredList := list select: [ :from_to | twoArgBlock value: from_to key value: from_to value ].
	^Subst mkSubst: filteredList
]

{ #category : #collection }
Subst >> size [
	^list size
]

{ #category : #'as yet unclassified' }
Subst >> substitutionEnvironmentOver: aBindEnv [
	| substs |
	"TODO: code duplication with DelayedSubst"
	substs := list collect: [ :ass |
		(aBindEnv ctContext tempNamed: ass key) -> (aBindEnv evaluate: ass value) ].
	^Dictionary newFromAssociations: substs
]

{ #category : #collection }
Subst >> update: kx symbol: sym [
	| ksym |
	ksym := sym kArgSymbol: kx.
	list do: [ :from_to | from_to key = sym ifTrue: [ 
			"Just z case in UniqifyKVars.hs"
			| z newAss |
			z := from_to value.
			newAss := ksym->z.
			^Subst mkSubst: ((list copyWithout: from_to) copyWith: newAss) ]].
	"Nothing"
	self shouldBeImplemented 
]
