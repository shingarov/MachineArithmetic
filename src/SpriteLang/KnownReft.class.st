Class {
	#name : #KnownReft,
	#superclass : #'ΛReft',
	#instVars : [
		'symbol',
		'expr'
	],
	#category : #SpriteLang
}

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
	
	"
	Known v p <> Known v' p'
	"
	symbol = anotherReft symbol "v == v'"
		ifTrue: [ ^KnownReft symbol: symbol expr: expr, anotherReft expr ]. "Known v  (p  <> p')"
	
	"symbol dummySymbol  ."  "| v == F.dummySymbol = Known v' (p' <> (p `F.subst1`  (v , F.EVar v')))"  "<- BOGUS, should be implemented"
	
	
	^KnownReft
		symbol: symbol
		expr: expr, (anotherReft expr subst1: anotherReft symbol->(EVar of: symbol))
		
]

{ #category : #accessing }
KnownReft >> expr [
	^ expr
]

{ #category : #accessing }
KnownReft >> expr: anObject [
(anObject isKindOf: HPred) ifFalse: [ self error ].
	expr := anObject
]

{ #category : #'fresh monad' }
KnownReft >> freshR: Γ _: _t [
"
freshR _ _ _ r@(Known {}) = pure r
"
	^self
]

{ #category : #'as yet unclassified' }
KnownReft >> hvarPred: f [
"
hvarPred :: F.Symbol -> Reft -> Reft
Cf. Check.hs
"
	"Convert all occurrences of `H.Var f xs` in `r` to `H.Reft (EApp f xs)`.
	
	[bgs] NB: Here predApp comes from Sprite/Common.hs,
            nevertheless by EApp we mean the FX Expr.
	"
	| go |
	go := [ :r |
		(r isKindOf: HPred) ifFalse: [ self error ]. "go :: H.Pred -> H.Pred"
		((r isKindOf: RefVarApp) and: [ r var = f ])
			ifTrue: [ HReft expr: (f predApp: r args) ]
			ifFalse: [ (r isKindOf: HPredAnd)
				ifTrue: [ HPredAnd of: (r ps collect: go) ]
				ifFalse: [ r ] ]
	].
	^KnownReft symbol: symbol expr: (go value: expr)
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

{ #category : #'as yet unclassified' }
KnownReft >> refactorAppR: anEvalEnv [
"
refactorAppR :: (F.Symbol -> Bool) -> Reft -> Reft
refactorAppR isRV (Known v p) = Known v (refactorAppP isRV p)

In Smalltalk, we pass an environment of all outer names so we
can determine whether a DecidableRefinement is an RVar-application.
"
	| amendedEnv |
	amendedEnv := anEvalEnv,
		(EvalEnv constants: {symbol -> (DummyArg named: symbol)} asDictionary).
	^KnownReft symbol: symbol expr: (expr refactorAppP: amendedEnv)
]

{ #category : #'α-renaming' }
KnownReft >> rename: a to: b [
	^self class
		symbol: symbol
		expr: (expr rename: a to: b)
]

{ #category : #SubsARef }
KnownReft >> subs: p ar: ar [
"
instance SubsARef Reft where
  subsAR p ar (Known v pr) = Known v (subsAR p ar pr)
"
	^KnownReft
		symbol: symbol
		expr: (expr subs: p ar: ar)
]

{ #category : #SubARef }
KnownReft >> subsAR: p ar: ar [
	^KnownReft
		symbol: symbol
		expr: (expr subsAR: p ar: ar)
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
