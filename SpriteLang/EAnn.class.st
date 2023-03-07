Class {
	#name : #EAnn,
	#superclass : #'ΛExpression',
	#instVars : [
		'expr',
		'rtype'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
EAnn class >> expr: e rtype: t [ 
	^ self basicNew
		expr: e;
		rtype: t;
		yourself
]

{ #category : #'as yet unclassified' }
EAnn >> elabS: Γ [
	| as t as___t  e_ |
	as___t := rtype bkAlls.
	as := as___t first.  t := as___t last.
	e_ := expr elabC: (Γ extEnvTVs: as) rtype: t.
	^{ EAnn expr: (e_ mkTLam: as) rtype: rtype . rtype }
]

{ #category : #accessing }
EAnn >> expr [
	^ expr
]

{ #category : #accessing }
EAnn >> expr: anObject [
	expr := anObject
]

{ #category : #'as yet unclassified' }
EAnn >> goSubsTyExpr: su [ 
	^EAnn expr: (expr goSubsTyExpr: su) rtype: rtype
]

{ #category : #GT }
EAnn >> gtChildren [
	^{ expr . rtype }
]

{ #category : #accessing }
EAnn >> rtype [
	^ rtype
]

{ #category : #accessing }
EAnn >> rtype: anObject [
	rtype := anObject
]

{ #category : #'as yet unclassified' }
EAnn >> synth: Γ [
"
     Γ ⊦ e <== t   t := fresh(s)
     --------------------------- [Syn-Ann]
     Γ ⊦ e:t => t
"
	| t c |
	t := Γ fresh: rtype.
	c := expr check: Γ rtype: t.
	^{ c . t }
]
