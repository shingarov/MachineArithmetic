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
