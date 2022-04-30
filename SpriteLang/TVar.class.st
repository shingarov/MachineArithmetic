Class {
	#name : #TVar,
	#superclass : #'ΛBase',
	#instVars : [
		'symbol'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
TVar class >> symbol: s [
	^self basicNew symbol: s; yourself
]

{ #category : #comparing }
TVar >> = another [
	another class == self class ifFalse: [ ^false ].
	^symbol = another symbol
]

{ #category : #'as yet unclassified' }
TVar >> baseSort [
	^Z3Sort uninterpretedSortNamed: symbol
]

{ #category : #polymorphism }
TVar >> bsubst: t tVar: a reft: r [ 
	symbol = a ifTrue: [ ^t strengthenTop: r ].
	^super bsubst: t tVar: a reft: r
]

{ #category : #'as yet unclassified' }
TVar >> freeTVarsGoB [
	^Set with: symbol
]

{ #category : #comparing }
TVar >> hash [
	^symbol hash
]

{ #category : #printing }
TVar >> printOn: aStream [
	aStream nextPutAll: 'TVar "';
		nextPutAll: symbol;
		nextPutAll: '"'
]

{ #category : #accessing }
TVar >> symbol [
	^ symbol
]

{ #category : #accessing }
TVar >> symbol: anObject [
	symbol := anObject
]

{ #category : #unification }
TVar >> unifyV: t [
	"t is an RType"
	((t isKindOf: TBase) and: [ t b isKindOf: TVar ]) ifTrue: [
		| a b r |
		a := symbol.
		b := t b symbol.
		r := t r.
		a = b ifTrue: [ ^t ].
		a nonRigid ifTrue: [ t assign: self. ^t ].
		b nonRigid ifTrue: [ | t_ |
			t_ := TBase b: self "i.e. (TVar a)" r: r.
			t_ assign: self. ^t_ ]].
	
	(t freeTVars includes: symbol) ifTrue: [ self error ].
	symbol nonRigid ifTrue: [ t assign: self.  ^t ].
	self shouldBeImplemented.
]
