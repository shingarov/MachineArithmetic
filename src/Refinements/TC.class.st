Class {
	#name : #TC,
	#superclass : #FTycon,
	#instVars : [
		'symbol'
	],
	#category : #Refinements
}

{ #category : #names }
TC class >> conName [
	"Special marker that doesn't match any known conName in symbolFTycon"
	^nil
]

{ #category : #accessing }
TC class >> symbol: s [
	^self basicNew
		symbol: s;
		yourself
]

{ #category : #comparing }
TC >> = rhs [
"
instance Eq FTycon where
  (TC s _) == (TC s' _) = val s == val s'
"
	self class = rhs class ifFalse: [ ^false ].
	^symbol = rhs symbol
]

{ #category : #hotel }
TC >> apply: ts [
	| monoSymbol |
	ts isEmpty ifTrue: [ ^self ].
	monoSymbol :=
		'(',
		symbol,
		(ts inject: '' into: [ :soFar :thisArgType | ' ', thisArgType unsafeName ]),
		')'.
	^TC symbol: monoSymbol
]

{ #category : #'as yet unclassified' }
TC >> applyTo: ts in: γ [
	| instance |
	instance := (γ data at: symbol) apply: (ts collect: [ :each | each z3sort: γ ]).
	^instance monomorphicDeclIn: γ
]

{ #category : #comparing }
TC >> hash [
	^symbol hash
]

{ #category : #hotel }
TC >> isListTC [
	"Do we need this?  cf. https://github.com/ucsd-progsys/liquid-fixpoint/issues/739 "
	^symbol isListConName
]

{ #category : #printing }
TC >> printOn: aStream [
	aStream nextPutAll: 'TC '.
	aStream nextPutAll: symbol
]

{ #category : #'as yet unclassified' }
TC >> smtApply: ts originalFApp: anFApp in: γ [
	^γ data
		at: symbol
		ifPresent: [ :d |
			| instance |
			self assert: d ddVars = ts size.
			instance := d apply: (ts collect: [ :t | t z3sort: γ ]).
			instance z3sort: γ ]
		ifAbsent: [ (FObj symbol: symbol) fappSmtSort: ts originalFApp: anFApp in: γ ]
]

{ #category : #accessing }
TC >> symbol [
	^ symbol
]

{ #category : #accessing }
TC >> symbol: anObject [
	symbol := anObject
]
