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

{ #category : #theories }
TheorySymbol class >> interpSymbols [
	"BOGUS"
	^#()
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

{ #category : #yoneda }
TheorySymbol >> uncurriedApp: anEVar args: args resultSort: resultSort in: aSymEnv [ 
	self shouldBeImplemented.
]

{ #category : #yoneda }
TheorySymbol >> uncurriedApp: args resultSort: resultSort in: aSymEnv [ 
	^InterpretedApp ts: self args: args resultSort: resultSort env: aSymEnv 
]
