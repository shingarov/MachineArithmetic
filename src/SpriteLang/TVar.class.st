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
"
bsubst :: TVar -> RType -> Base -> Reft -> RType
"
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
	((t isKindOf: TBase) and: [ t b isKindOf: TVar ]) ifTrue: [ "unifyV _ a t@(TBase (TVar b) r)"
		| a b r |
		a := symbol.
		b := t b symbol.
		r := t r.
		a = b ifTrue: [ ^t ].
		a nonRigid ifTrue: [ t assign: self. ^t ].
		b nonRigid ifTrue: [ | t_ |
			t_ := TBase b: (TVar symbol: a) r: r.
			t_ assign: t b. ^t_ ]].
	
	(t freeTVars includes: symbol) ifTrue: [ self error: 'type error: occurs check: ', symbol printString, ' occurs in ', t freeTVars printString ].
	symbol nonRigid ifTrue: [ t assign: self.  ^t ].
	self error: 'type error: cannot assign rigid ', t printString, '', self printString
]

{ #category : #'α-renaming' }
TVar >> uniq2: α [
	| symbol′ |

	symbol′ := α at: symbol ifAbsent:[ ^self ].
	^self class symbol: symbol′

]
