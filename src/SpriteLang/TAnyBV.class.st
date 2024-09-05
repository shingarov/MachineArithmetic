Class {
	#name : #TAnyBV,
	#superclass : #'ΛBase',
	#instVars : [
		'symbol'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TAnyBV class >> fresh [
	^self basicNew
		obtainFreshSymbol;
		yourself
]

{ #category : #'instance creation' }
TAnyBV class >> symbol: s [
	^self basicNew
		symbol: s;
		yourself
]

{ #category : #comparing }
TAnyBV >> = another [
	another class == self class ifFalse: [ ^false ].
	^symbol = another symbol
]

{ #category : #'refinement typing' }
TAnyBV >> baseSort [
	^Z3Sort uninterpretedSortNamed: 'ANYBV'
]

{ #category : #comparing }
TAnyBV >> hash [
	^symbol hash
]

{ #category : #'as yet unclassified' }
TAnyBV >> obtainFreshSymbol [
	symbol := ElabState current freshBvId
]

{ #category : #printing }
TAnyBV >> printOn: aStream [
	aStream nextPutAll: 'TAnyBV['.
	symbol isNil ifFalse: [ aStream nextPutAll: symbol ].
	aStream nextPutAll: ']'.
		
]

{ #category : #'as yet unclassified' }
TAnyBV >> symbol [
	^symbol
]

{ #category : #'as yet unclassified' }
TAnyBV >> symbol: s [
	symbol := s
]

{ #category : #'as yet unclassified' }
TAnyBV >> unifyBV: t [
	"t is an RType"
	(t isKindOf: TBase) ifFalse: [ self shouldBeImplemented ].
	(t b isKindOf: TBitVector) ifTrue: [ t assignBV: self. self halt. ^t ].
	(t b isKindOf: TAnyBV) ifFalse: [ Incompatible signal ].
	
	"AnyBV vs AnyBV; there are 4 cases"
	symbol isNil
		ifTrue:  [
			t b symbol isNil
				ifTrue:  [ ^self shouldBeImplemented ]
				ifFalse: [ ^self shouldBeImplemented ]
		] ifFalse: [
			t b symbol isNil
				ifTrue:  [ | t′ |
					t′ := TBase b: (TAnyBV symbol: symbol) r: t r.
					t′ assignBV: t b.
					^t′
				] ifFalse: [ ^self shouldBeImplemented ]
		]
]

{ #category : #'α-renaming' }
TAnyBV >> uniq2: α [
	"Nothing to do"
]
