"
-- | Refinement Variables -----------------------------------------------------
data RVar = RVar
  { rvName :: F.Symbol
  , rvArgs :: ![RSort]
  }
  deriving (Eq, Show)
"
Class {
	#name : #RVar,
	#superclass : #Object,
	#instVars : [
		'rvName',
		'rvArgs'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
RVar class >> rvName: rvName rvArgs: rvArgs [
	^self basicNew
		rvName: rvName;
		rvArgs: rvArgs;
		yourself
	
]

{ #category : #'as yet unclassified' }
RVar >> freeTVarsGoP [
	^(rvArgs collectAndCat: #freeTVars) asSet
]

{ #category : #'as yet unclassified' }
RVar >> predBind [
"
predBind :: RVar -> (F.Symbol, RType)
cf. Check.hs
"
	^rvName -> (TCon
		c: 'Pred'
		ts: (rvArgs collect: #rSortToRType)
		ars: #()
		r: ΛReft new)
]

{ #category : #printing }
RVar >> printOn: aStream [
	aStream nextPutAll: 'RVar{';
		nextPutAll: rvName;
		nextPut: $(.
	rvArgs printOn: aStream delimiter: ', '.
	aStream nextPutAll: ')}'
	
		
]

{ #category : #'as yet unclassified' }
RVar >> rVarARef__Parse [
"
rVarARef :: RVar -> RARef
cf. Parse.hs
"
	| xts pred |
	xts := rvArgs collectWithIndex: [ :t :i | ('rvTmp' intSymbol: i-1) -> t ].
	pred := rvName expr eApps: (xts collect: [ :xt | xt key expr ]).
	^ARef arArgs: xts arPred: pred ΛpredReft
]

{ #category : #'as yet unclassified' }
RVar >> rVarARef__Types [
"
rVarARef :: RVar -> RARef
cf. Types.hs
"
	| xts pred |
	xts := rvArgs zip: (0 to: rvArgs size - 1) with: [ :t :i | ('kvTmp' intSymbol: i) -> t ].
	pred := RefVarApp var: rvName args: (xts collect: #key).
	^ARef
		arArgs: xts
		arPred: (KnownReft symbol: String dummySymbol expr: pred)
]

{ #category : #accessing }
RVar >> rvArgs [
	^ rvArgs
]

{ #category : #accessing }
RVar >> rvArgs: anObject [
	rvArgs := anObject
]

{ #category : #accessing }
RVar >> rvName [
	^ rvName
]

{ #category : #accessing }
RVar >> rvName: anObject [
	rvName := anObject
]

{ #category : #'as yet unclassified' }
RVar >> tsubstGoP: t′ tVar: a [
	| newRvArgs |
	newRvArgs := self rvArgs collect: [ :t | "asRType go t"
		(t rSortToRType tsubstGo: t′ tVar: a) rTypeToRSort ].
	^self copy
		rvArgs: newRvArgs;
		yourself
]
