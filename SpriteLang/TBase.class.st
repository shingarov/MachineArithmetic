Class {
	#name : #TBase,
	#superclass : #RType,
	#instVars : [
		'b',
		'r'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TBase class >> b: b r: r [
	^self basicNew
		b: b; r: r; yourself
]

{ #category : #accessing }
TBase >> b [
	^ b
]

{ #category : #accessing }
TBase >> b: anObject [
	b := anObject
]

{ #category : #'as yet unclassified' }
TBase >> collect: aBlock [
	^TBase b: b r: (aBlock value: r)
]

{ #category : #polymorphism }
TBase >> dispatchUnify: t1 [
"
unify l t (TBase (TVar a) _) =
  unifyV l a t

See L5 test_tail01 for an example going through this path.
"
	(b isKindOf: TVar) ifTrue: [ ^b unifyV: t1 ].
	^super dispatchUnify: t1
]

{ #category : #'as yet unclassified' }
TBase >> freeTVarsGo [
	^b freeTVarsGoB
]

{ #category : #'as yet unclassified' }
TBase >> fresh: Γ [
	^TBase
		b: b
		r: (r freshR: Γ _: self sort)
]

{ #category : #'as yet unclassified' }
TBase >> goRefresh [
	^TBase b: b r: UnknownReft new
]

{ #category : #GT }
TBase >> gtChildren [
	^#()
]

{ #category : #printing }
TBase >> printOn: aStream [
	aStream nextPutAll: 'TBase '.
	b printOn: aStream.
	aStream nextPutAll: ' ('.
	r printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #accessing }
TBase >> r [
	^ r
]

{ #category : #accessing }
TBase >> r: aΛReft [
	r := aΛReft
]

{ #category : #prelude }
TBase >> rebind [
	^self
]

{ #category : #accessing }
TBase >> reft [
	^r
]

{ #category : #'synthesis constraints' }
TBase >> singleton: x [
	| v p v_eq_x |
	v := r symbol.
	p := r expr.
	v_eq_x := DecidableRefinement text: v, '===', x.
	^TBase
		b: b
		r: (Reft symbol: v expr: p & v_eq_x) known
]

{ #category : #SMT }
TBase >> sort [
"
rTypeSort (TBase b _)   = baseSort b
"
	^b baseSort
]

{ #category : #'as yet unclassified' }
TBase >> sortPred: x [
"
sortPred :: F.Symbol -> RType -> Maybe (F.Sort, H.Pred)
sortPred x t@(TBase _   (Known v p)) = Just (rTypeSort t, subst p v x)
cf. Constraints.hs
"
	| v p newPred |
	r isKnown ifFalse: [ ^nil ].
	r isKnown ifFalse: [ ^super sortPred: x ].
	v := r symbol.
	p := r expr.

	newPred := p subst: v with: x.
	^{ self sort . Reft symbol: x expr: newPred }
]

{ #category : #polymorphism }
TBase >> strengthenTop: r_ [
	^TBase b: b r: r, r_
]

{ #category : #'as yet unclassified' }
TBase >> subsTy: su [
	(b isKindOf: TVar) ifTrue: [ ^su at: b symbol  ifAbsent: [ self ] ].
	^self
]

{ #category : #'F.Subable' }
TBase >> subst: f [
	"subst f (TBase b r)   = TBase b (F.subst f r)"
	^TBase b: b r: (r subst: f)
]

{ #category : #'F.Subable' }
TBase >> substa: f [
	"substa f (TBase b r)   = TBase b (F.substa f r)"
	^TBase b: b r: (r substa: f)
]

{ #category : #'F.Subable' }
TBase >> substf: f [
	"substa f (TBase b r)   = TBase b (F.substf f r)"
	^TBase b: b r: (r substf: f)
]

{ #category : #'F.Subable' }
TBase >> syms [
	"syms (TBase _ r)     = F.syms r"
	^r syms
]

{ #category : #polymorphism }
TBase >> tsubstGo: t tVar: a [ 
	^b bsubst: t tVar: a reft: r
]

{ #category : #polymorphism }
TBase >> unifyLL: t [
	(b isKindOf: TVar) ifTrue: [ ^b unifyV: t ].
	((t isKindOf: TBase) and: [ t b isKindOf: TVar ]) ifTrue: [ ^t b unifyV: self ].
	((t isKindOf: TBase) and: [ b = t b ]) ifTrue: [ ^self ].
	self error: 'Cant unify'
]

{ #category : #'as yet unclassified' }
TBase >> ≺ [ t
"
       (v::t) => q[w := v]
       ------------------- [Sub-Base]  
       b{v:p} <= b{w:q}
"
	| q v w headCstr |
	(t isKindOf: TBase) ifFalse: [ self error: 'Invalid Subtyping' ].
	b = t b ifFalse: [ self error ].
	v := r symbol.
	w := t r symbol.
	q := t r expr.
	headCstr := (q subst1: w->(FxEVar of: v)) cHead.
	^self cAll: v cstr: headCstr
]
