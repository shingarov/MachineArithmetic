"
Cf. Types/Theories.hs
--------------------------------------------------------------------------------
-- | 'TheorySymbol' represents the information about each interpreted 'Symbol'
--------------------------------------------------------------------------------
data TheorySymbol  = Thy
  { tsSym    :: !Symbol          -- ^ name
  , tsRaw    :: !Raw             -- ^ serialized SMTLIB2 name
  , tsSort   :: !Sort            -- ^ sort
  , tsInterp :: !Sem             -- ^ TRUE = defined (interpreted), FALSE = declared (uninterpreted)
  }
  deriving (Eq, Ord, Show, Data, Typeable, Generic)


"
Class {
	#name : #TheorySymbol,
	#superclass : #Object,
	#instVars : [
		'tsSym',
		'tsRaw',
		'tsSort',
		'tsInterp'
	],
	#category : #Refinements
}

{ #category : #'known theories' }
TheorySymbol class >> interpSymbols [
"
interpSymbols :: [(Symbol, TheorySymbol)]
Cf. Smt/Theories.hs
"
	^{
		'setAdd' interpSym: [ :args | args first add: args second ] sort: TheorySymbol setAddSort
	}
]

{ #category : #'known theories' }
TheorySymbol class >> setAddSort [
"
setAddSort = FAbs 0 $ FFunc (setSort $ FVar 0) $ FFunc (FVar 0)           (setSort $ FVar 0)
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (FVar new: 0) mkSetSort
			to: (FFunc from: (FVar new: 0) to: (FVar new: 0) mkSetSort))
]

{ #category : #'instance creation' }
TheorySymbol class >> tsSym: tsSym tsRaw: tsRaw tsSort: tsSort tsInterp: tsInterp [
	^self basicNew
		tsSym: tsSym;
		tsRaw: tsRaw;
		tsSort: tsSort;
		tsInterp: tsInterp;
		yourself


]

{ #category : #printing }
TheorySymbol >> printOn: aStream [
"
instance Fixpoint TheorySymbol where
  toFix (Thy x _ t d) = text 'TheorySymbol' <+> pprint (x, t) <+> parens (pprint d)
"
	aStream
		nextPutAll: 'TheorySymbol ';
		nextPutAll: tsSym;
		nextPutAll: ' : '.
	tsSort printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: tsInterp name;
		nextPutAll: ')'.
]

{ #category : #accessing }
TheorySymbol >> thyAppInfo [
"
thyAppInfo :: TheorySymbol -> Maybe Int
"
	^tsInterp = SemField
		ifTrue: [ 1 ]
		ifFalse:  [ tsSort sortAppInfo ]
]

{ #category : #accessing }
TheorySymbol >> tsInterp [
	^ tsInterp
]

{ #category : #accessing }
TheorySymbol >> tsInterp: anObject [
	tsInterp := anObject
]

{ #category : #accessing }
TheorySymbol >> tsRaw [
	^ tsRaw
]

{ #category : #accessing }
TheorySymbol >> tsRaw: anObject [
	tsRaw := anObject
]

{ #category : #accessing }
TheorySymbol >> tsSort [
	^ tsSort
]

{ #category : #accessing }
TheorySymbol >> tsSort: anObject [
	tsSort := anObject
]

{ #category : #accessing }
TheorySymbol >> tsSym [
	^ tsSym
]

{ #category : #accessing }
TheorySymbol >> tsSym: anObject [
	tsSym := anObject
]
