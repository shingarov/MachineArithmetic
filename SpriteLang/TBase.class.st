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
TBase >> fresh: Γ [ 
	^TBase b: b r: (r freshR: Γ base: b)
]

{ #category : #accessing }
TBase >> r [
	^ r
]

{ #category : #accessing }
TBase >> r: anObject [
	r := anObject
]

{ #category : #'synthesis constraints' }
TBase >> singleton: x [
	| v p v_eq_x |
	v := r symbol.
	p := r expr.
	v_eq_x := DecidableRefinement text: v, '===', x.
	^TBase
		b: b
		r: (Reft symbol: v expr: p & v_eq_x)
]

{ #category : #'as yet unclassified' }
TBase >> sortPred: x [
	| v p newPred |
	v := r symbol.
	p := r expr.
	newPred := p subst1: (FxEVar of: x) for: v.
	^{ b baseSort . Reft symbol: x expr: newPred }
	
]

{ #category : #'as yet unclassified' }
TBase >> subst1: toExpr for: fromVarName [ 
	^TBase
		b: b
		r: (r subst1: toExpr for: fromVarName)
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
