Class {
	#name : #TC,
	#superclass : #FTycon,
	#instVars : [
		'symbol'
	],
	#category : #Refinements
}

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

{ #category : #hotel }
TC >> fTyconSort [
	^FTC new: self
]

{ #category : #comparing }
TC >> hash [
	^symbol hash
]

{ #category : #hotel }
TC >> isListTC [
	^symbol isListConName
]

{ #category : #printing }
TC >> printOn: aStream [
	aStream nextPutAll: 'TC '.
	aStream nextPutAll: symbol
]

{ #category : #accessing }
TC >> symbol [
	^ symbol
]

{ #category : #accessing }
TC >> symbol: anObject [
	symbol := anObject
]
