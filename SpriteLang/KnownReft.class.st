Class {
	#name : #KnownReft,
	#superclass : #'ΛReft',
	#instVars : [
		'symbol',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
KnownReft class >> alwaysTrue [
	^Reft alwaysTrue known
	
]

{ #category : #'instance creation' }
KnownReft class >> new [
	^Reft new known
]

{ #category : #'instance creation' }
KnownReft class >> symbol: s expr: p [
	^self basicNew 
		symbol: s;
		expr: p;
		yourself
]

{ #category : #semigroup }
KnownReft >> , anotherReft [
	"instance Semigroup Reft where"
	
	anotherReft isKnown ifFalse: [ ^self "r<>Unknown = r" ].
	expr isTauto ifTrue: [ ^anotherReft ].
	
	"
	Known v p <> Known v' p'
	"
	symbol = anotherReft symbol "v == v'"
		ifTrue: [ ^KnownReft symbol: symbol expr: expr, anotherReft expr ]. "Known v  (p  <> p')"
	
	"symbol dummySymbol  ."  "| v == F.dummySymbol = Known v' (p' <> (p `F.subst1`  (v , F.EVar v')))"  "<- BOGUS, should be implemented"
	
	
	^KnownReft
		symbol: symbol
		expr: expr, (anotherReft expr subst1: anotherReft symbol->(FxEVar of: symbol))
		
]

{ #category : #accessing }
KnownReft >> expr [
	^ expr
]

{ #category : #accessing }
KnownReft >> expr: anObject [
	expr := anObject
]

{ #category : #'fresh monad' }
KnownReft >> freshR: Γ _: _t [
"
freshR _ _ _ r@(Known {}) = pure r
"
	^self
]

{ #category : #testing }
KnownReft >> isKnown [
	^true
]

{ #category : #printing }
KnownReft >> printOn: aStream [
	aStream nextPutAll: 'Known "';
		nextPutAll: symbol;
		nextPutAll: '" '.
	expr printOn: aStream
]

{ #category : #accessing }
KnownReft >> reft [
	"The inverse of #known."
	^Reft symbol: symbol expr: expr
]

{ #category : #'F.Subable' }
KnownReft >> subst1: su [
	^KnownReft symbol: symbol expr: (Subst subst1Except: {symbol} _: expr _: su)
]

{ #category : #'F.Subable' }
KnownReft >> subst: su [
	^KnownReft symbol: symbol expr: (expr subst: (su except: {symbol}))
]

{ #category : #'F.Subable' }
KnownReft >> substa: f [
	^KnownReft symbol: (f value: symbol) expr: (expr substa: f)
]

{ #category : #'F.Subable' }
KnownReft >> substf: f [
	^KnownReft symbol: symbol expr: (expr substf: (Subst substfExcept: f _: {symbol}))
]

{ #category : #accessing }
KnownReft >> symbol [
	^ symbol
]

{ #category : #accessing }
KnownReft >> symbol: anObject [
	symbol := anObject
]

{ #category : #'F.Subable' }
KnownReft >> syms [
	^{symbol}, expr syms
]
