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
	self assert: (anObject isKindOf: ΛBase).
	b := anObject
]

{ #category : #Functor }
TBase >> collect: aBlock [
	r isNil ifTrue: [ ^self ].
	^TBase b: b r: aBlock ⊛ r
]

{ #category : #'α-renaming' }
TBase >> collectαRenames: α [
	^α
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

{ #category : #testing }
TBase >> isBase [
	^true
]

{ #category : #testing }
TBase >> isRSort [
	^r isNil
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

{ #category : #'as yet unclassified' }
TBase >> rSortToRType [
	self isRSort ifFalse: [ self error ].
	^self copy
		r: ΛReft new;
		yourself
]

{ #category : #'as yet unclassified' }
TBase >> rTypeToRSort [
	^self copy
		r: nil;
		yourself
]

{ #category : #prelude }
TBase >> rebind [
	^self
]

{ #category : #'as yet unclassified' }
TBase >> refactorAppR: anEvalEnv [ 
	^TBase
		b: b
		r: (r refactorAppR: anEvalEnv)
]

{ #category : #accessing }
TBase >> reft [
	^r
]

{ #category : #'as yet unclassified' }
TBase >> rtypeSort [
	^b baseSort
]

{ #category : #'synthesis constraints' }
TBase >> singleton: x [
	^TBase
		b: b
		r: (KnownReft symbol: r symbol expr: (HPredAnd of: {r expr . r symbol ≛ x}))
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
	r isKnown ifFalse: [ ^super sortPred: x ].
	v := r symbol.
	p := r expr.
	^{ self sort . p subst: v with: x }
]

{ #category : #polymorphism }
TBase >> strengthenTop: r_ [
	^TBase b: b r: r, r_
]

{ #category : #SubARef }
TBase >> subsAR: p ar: ar [
	r isNil ifTrue: [ ^self ].
	^TBase b: b r: (r subsAR: p ar: ar)
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

{ #category : #'α-renaming' }
TBase >> uniq2: α [
	^self class b: (b uniq2: α) r: (r uniq2: α)

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
	headCstr := (q subst1: w->(EVar of: v)) cHead.
	^self cAll: v cstr: headCstr
]
