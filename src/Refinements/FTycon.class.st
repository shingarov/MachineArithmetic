"
data FTycon   = TC LocSymbol TCInfo deriving (Ord, Show, Data, Typeable, Generic, ToJSON, FromJSON)
Cf. Types/Sorts.hs

Historically it so happened that in the present codebase,
the TCInfo information is kept in the subclass hierarchy.
"
Class {
	#name : #FTycon,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #names }
FTycon class >> conName [
	^self subclassResponsibility
]

{ #category : #'instance creation' }
FTycon class >> named: aString [
	self conName = aString ifFalse: [ ^nil ].
	^self basicNew
]

{ #category : #'instance creation' }
FTycon class >> symbolFTycon: c [
"
symbolFTycon :: LocSymbol -> FTycon
"
	(self subclasses without: TC) do: [ :eachSpecialTycon |
		(eachSpecialTycon named: c) ifNotNil: [ :instance | ^instance ] ].
	"non-special TC"
	^TC symbol: c
]

{ #category : #'type algebra' }
FTycon >> fAppTC: argSorts [
"
fAppTC :: FTycon -> [Sort] -> Sort
fAppTC = fApp . fTyconSort
"
	^self fTyconSort fApp: argSorts
]

{ #category : #hotel }
FTycon >> fTyconSort [
	^FTC new: self
]

{ #category : #accessing }
FTycon >> fTyconSymbol [
	^self class conName
]

{ #category : #testing }
FTycon >> isListTC [
	^false
]

{ #category : #bitvectors }
FTycon >> sizeBv [
"
sizeBv :: FTycon -> Maybe Int
Cf. 
Answer the X in 'SizeX', or nil if the name is not of SizeX form.
"
	| s |
	s := self fTyconSymbol.
	^self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
FTycon >> smtApply: ts originalFApp: anFApp in: γ [
	^self subclassResponsibility
]

{ #category : #Symbolic }
FTycon >> symbol [
"
instance Symbolic FTycon where
"
	^self fTyconSymbol
]
