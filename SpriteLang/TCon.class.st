Class {
	#name : #TCon,
	#superclass : #RType,
	#instVars : [
		'c',
		'ts',
		'r'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TCon class >> c: c ts: ts r: r [
	^self basicNew
		c: c; ts: ts; r: r; yourself
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
TCon >> freeTVarsGo [
	^Set unionAll: (ts collect: #freeTVarsGo)
]

{ #category : #'as yet unclassified' }
TCon >> fresh: Γ [
	^TCon
		c: c
		ts: (ts collect: [ :eachT | eachT fresh: Γ ])
		r: (r freshR: Γ _: self sort)
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
		r: r
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
		r: (KnownReft symbol: r symbol expr: r expr & (DecidableRefinement text: r symbol, ' === ', x))
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
	| v p newPred |
	r isKnown ifFalse: [ ^super sortPred: x ].
	v := r symbol.
	p := r expr.
	
	newPred := p subst: v with: x.
	^{ self sort . Reft symbol: x expr: newPred }
]

{ #category : #polymorphism }
TCon >> strengthenTop: r_ [ 
	^self copy
		r: r, r_;
		yourself
]

{ #category : #'as yet unclassified' }
TCon >> subsTy: su [
"
subsTy su (TCon c ts r)        = TCon c (subsTy su <$> ts) r
"
	| ts_ |
	ts_ := ts collect: [ :each | each subsTy: su ].
	^TCon c: c ts: ts_ r: r
]

{ #category : #'F.Subable' }
TCon >> subst: f [
	"subst f (TCon c ts r) = TCon c  (F.subst f <$> ts) (F.subst f r)"
	^TCon c: c ts: (ts collect: [ :eachT | eachT subst: f ] ) r: (r subst: f)
]

{ #category : #'F.Subable' }
TCon >> substa: f [
	"substa f (TCon c ts r) = TCon c  (F.substa f <$> ts) (F.substa f r)"
	^TCon c: c ts: (ts collect: [ :eachT | eachT substa: f ] ) r: (r substa: f)
]

{ #category : #'F.Subable' }
TCon >> substf: f [
	"substf f (TCon c ts r) = TCon c  (F.substf f <$> ts) (F.substf f r)"
	^TCon c: c ts: (ts collect: [ :eachT | eachT substf: f ] ) r: (r substf: f)
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
		ts: (ts collect: [ :each | each tsubstGo: t tVar: a ])
		r: r
]

{ #category : #'as yet unclassified' }
TCon >> unify: tcon2 [
	| newTs |
	(tcon2 isKindOf: TCon) ifFalse: [ self error ].
	(c = tcon2 c) ifFalse: [ self error ].
	newTs := RType unifys: ts with: tcon2 ts.
	^TCon c: c ts: newTs r: ΛReft new
]

{ #category : #'as yet unclassified' }
TCon >> ≺ [ tcon2
	| c1 t1s v c2 t2s w q cTop cIns |
	(tcon2 isKindOf: TCon) ifFalse: [ self error ].
	r isKnown ifFalse: [ self error ].
	c1 := c.  t1s := ts. v := r symbol.
	c2 := tcon2 c.  t2s := tcon2 ts.  w := tcon2 r symbol.  q := tcon2 r expr.
	c1 = c2 ifFalse: [ self error ].
	cTop := self cAll: v cstr: (q subst: w with: v) cHead.
	cIns := HCstr subs: t1s _: t2s.
	^cTop & cIns
]
