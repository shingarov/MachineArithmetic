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
TBase >> freeTVarsGo [
	^b freeTVarsGoB
]

{ #category : #'as yet unclassified' }
TBase >> fresh: Γ [ 
	^TBase b: b r: (r freshR: Γ base: b)
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

{ #category : #'as yet unclassified' }
TBase >> sortPred: x [
"sortPred :: F.Symbol -> RType -> Maybe (F.Sort, H.Pred)
cf. Constraints.hs
"
	| v p newPred |
	r isKnown ifFalse: [ ^nil ].
	v := r symbol.
	p := r expr.
	newPred := p subst1: (FxEVar of: x) for: v.
	^{ b baseSort . Reft symbol: x expr: newPred }
	
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

{ #category : #'as yet unclassified' }
TBase >> subst1: toExpr for: fromVarName [ 
	^TBase
		b: b
		r: (r subst1: toExpr for: fromVarName)
]

{ #category : #polymorphism }
TBase >> tsubst: t tVar: a [ 
	^b bsubst: t tVar: a reft: r
]

{ #category : #'as yet unclassified' }
TBase >> unify: t [
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
	(t isKindOf: TBase) ifFalse: [ self error ].
	b = t b ifFalse: [ self error ].
	v := r symbol.
	w := t r symbol.
	q := t r expr.
	headCstr := (q subst1: (FxEVar of: v) for: w) cHead.
	^self cAll: v cstr: headCstr
]
