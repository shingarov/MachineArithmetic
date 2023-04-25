Class {
	#name : #TCon,
	#superclass : #RType,
	#instVars : [
		'c',
		'ts',
		'ars',
		'r'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TCon class >> c: c ts: ts ars: ars r: r [
	^self basicNew
		c: c; ts: ts; ars: ars; r: r; yourself
]

{ #category : #'instance creation' }
TCon class >> c: c ts: ts r: r [
	^self basicNew
		c: c; ts: ts; r: r; yourself
]

{ #category : #accessing }
TCon >> ars [
	^ ars
]

{ #category : #accessing }
TCon >> ars: anObject [
	ars := anObject
]

{ #category : #accessing }
TCon >> c [
	^ c
]

{ #category : #accessing }
TCon >> c: anObject [
	c := anObject
]

{ #category : #'as yet unclassified' }
TCon >> collect: f [
	"deriving Functor"

	^TCon
		c: c
		ts: (ts collect: [ :t | f ⊛ t ])
		ars: (ars collect: [ :ar | f ⊛ ar ])
		r: r
]

{ #category : #'as yet unclassified' }
TCon >> freeTVarsGo [
	^Set unionAll: (ts collect: #freeTVarsGo)
]

{ #category : #'as yet unclassified' }
TCon >> fresh: Γ [
	^TCon
		c: c
		ts: (ts collect: [ :eachT | eachT fresh: Γ ])
		ars: ars
		r: (r freshR: Γ _: self sort)
]

{ #category : #'as yet unclassified' }
TCon >> goRefresh [
"
go (TCon c ts _) = TCon  c (go <$> ts) Unknown
"
	^TCon c: c ts: (ts collect: #goRefresh) ars: ars r: UnknownReft new
]

{ #category : #printing }
TCon >> printOn: aStream [
	aStream nextPutAll: 'TCon '.
	aStream nextPutAll: c.
	aStream nextPutAll: ' ...'. "TODO print the rest"
	
]

{ #category : #accessing }
TCon >> r [
	^ r
]

{ #category : #accessing }
TCon >> r: anObject [
	r := anObject
]

{ #category : #prelude }
TCon >> rebind [
	^TCon
		c: c
		ts: (ts collect: #rebind)
		ars: ars
		r: r
]

{ #category : #'as yet unclassified' }
TCon >> refactorAppR: anEvalEnv [ 
	^TCon
		c: c
		ts:  (ts collect:  [ :t | t refactorAppR: anEvalEnv ])
		ars: (ars collect: [ :t | t refactorAppR: anEvalEnv ])
		r: (r refactorAppR: anEvalEnv)
]

{ #category : #accessing }
TCon >> reft [
	^r
]

{ #category : #'synthesis constraints' }
TCon >> singleton: x [
	^TCon
		c: c
		ts: ts
		ars: ars
		r: (KnownReft
			symbol: r symbol
			expr: (HPredAnd of: {r expr . r symbol ≛ x}))
]

{ #category : #SMT }
TCon >> sort [
"
rTypeSort (TCon c ts _) = F.fAppTC (fTyCon c) (rTypeSort <$> ts)
"
	| x y |
	x := FTycon symbol: c.
	y := ts collect: #sort.
	^x fAppTC: y
]

{ #category : #'as yet unclassified' }
TCon >> sortPred: x [
"
sortPred x t@(TCon  _ _ (Known v p)) = Just (rTypeSort t, subst p v x)
"
	| v p |
	r isKnown ifFalse: [ ^super sortPred: x ].
	v := r symbol.
	p := r expr.

	^{ self sort . p subst: v with: x }
]

{ #category : #polymorphism }
TCon >> strengthenTop: r_ [ 
	^self copy
		r: r, r_;
		yourself
]

{ #category : #SubARef }
TCon >> subsAR: p ar: anARef [
"bogus, see issue 62: this should go through #collect:"
	^TCon
		c: c
		ts: (ts collect: [ :t | t subsAR: p ar: anARef ])
		ars: (ars collect: [ :ar | ar subsAR: p ar: anARef ])
		r: r
]

{ #category : #'as yet unclassified' }
TCon >> subsTy: su [
"
subsTy su (TCon c ts r)        = TCon c (subsTy su <$> ts) r
"
	| ts_ ars_ |
	ts_  := ts  collect: [ :each | each subsTy: su ].
	ars_ := ars collect: [ :each | each subsTy: su ].
	^TCon c: c ts: ts_ ars: ars_ r: r
]

{ #category : #'F.Subable' }
TCon >> subst: f [
	"subst f (TCon c ts r) = TCon c  (F.subst f <$> ts) (F.subst f r)"
	^TCon
		c: c
		ts:  (ts  collect: [ :eachT | eachT subst: f ] )
		ars: (ars collect: [ :eachT | eachT subst: f ] )
		r: (r subst: f)
]

{ #category : #'F.Subable' }
TCon >> substa: f [
	"substa f (TCon c ts r) = TCon c  (F.substa f <$> ts) (F.substa f r)"
	^TCon
		c: c
		ts:  (ts  collect: [ :eachT  | eachT  substa: f ] )
		ars: (ars collect: [ :eachAR | eachAR substa: f ] )
		r: (r substa: f)
]

{ #category : #'F.Subable' }
TCon >> substf: f [
	"substf f (TCon c ts r) = TCon c  (F.substf f <$> ts) (F.substf f r)"
	^TCon
		c: c
		ts:  (ts  collect: [ :eachT  | eachT  substf: f ] )
		ars: (ars collect: [ :eachAR | eachAR substf: f ] )
		r: (r substf: f)
]

{ #category : #'F.Subable' }
TCon >> syms [
	"syms (TCon _ ts r)   = concatMap F.syms ts ++ F.syms r"
	^(ts collectAndCat: #syms), r syms
]

{ #category : #accessing }
TCon >> ts [
	^ ts
]

{ #category : #accessing }
TCon >> ts: anObject [
	ts := anObject
]

{ #category : #polymorphism }
TCon >> tsubstGo: t tVar: a [
"
go (TCon c ts r)  = TCon c (go <$> ts) r
"
	^TCon
		c: c
		ts:  (ts  collect: [ :eachT | eachT tsubstGo: t tVar: a ])
		ars: (ars collect: [ :eachA | eachA tsubstGoA: t tVar: a ])
		r: r
]

{ #category : #polymorphism }
TCon >> unifyLL: tcon2 [
	| newTs |
	(tcon2 isKindOf: TCon) ifFalse: [ self error ].
	(c = tcon2 c) ifFalse: [ self error ].
	newTs := RType unifys: ts with: tcon2 ts.
	^TCon c: c ts: newTs ars: #() r: ΛReft new
]

{ #category : #'as yet unclassified' }
TCon >> ≺ [ tcon2
"
      G,v:int{p} |- q[w:=v]     G |- si <: ti
      ----------------------------------------- [Sub-TCon]
      G |- (C s1...)[v|p] <: (C t1...)[w|q]
"
	| c1 t1s p1s v c2 t2s p2s w q cTop cIns cARefs |
	(tcon2 isKindOf: TCon) ifFalse: [ self error ].
	r isKnown ifFalse: [ self error ].
	c1 := c.  t1s := ts. p1s := ars. v := r symbol.
	c2 := tcon2 c.  t2s := tcon2 ts. p2s := tcon2 ars. w := tcon2 r symbol.  q := tcon2 r expr.
	c1 = c2 ifFalse: [ self error ].
	cTop := self cAll: v cstr: (q subst: w with: v) cHead.
	cIns := HCstr subs: t1s _: t2s.
	cARefs := HCstr subPs: p1s _: p2s.
	^cTop & cIns & cARefs
]
