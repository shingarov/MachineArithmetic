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
	(self allSubclasses \ {SingletonFTycon. FTyconUnknownBitVecSize. TC}) do: [ :eachSpecialTycon |
		(eachSpecialTycon named: c) ifNotNil: [ :instance | ^instance ] ].
	"non-special TC"
	^TC symbol: c
]

{ #category : #comparing }
FTycon >> = rhs [
	^self subclassResponsibility
]

{ #category : #visiting }
FTycon >> accept: aVisitor [ 
	^aVisitor txExpr value: self
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

{ #category : #comparing }
FTycon >> hash [
	^self subclassResponsibility
]

{ #category : #testing }
FTycon >> isListTC [
	^false
]

{ #category : #hotel }
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
