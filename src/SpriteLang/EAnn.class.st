"
EAnn !(Expr a)  !Ann      !Sig      a    -- ^ e:t
"
Class {
	#name : #EAnn,
	#superclass : #'ΛExpression',
	#instVars : [
		'expr',
		'ann'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
EAnn class >> expr: e ann: a [
	^ self basicNew
		expr: e;
		ann: a;
		yourself
]

{ #category : #accessing }
EAnn >> ann [
	^ ann
]

{ #category : #accessing }
EAnn >> ann: anObject [
	ann := anObject
]

{ #category : #'as yet unclassified' }
EAnn >> elabS: Γ [
	| as t as_☐_t  e′ |
	as_☐_t := ann rtype bkAlls.
	as := as_☐_t first.  t := as_☐_t last.
	e′ := expr elabC: (Γ extEnvTVs: as) rtype: t.
	^{ EAnn expr: (e′ mkTLam: as) ann: ann . ann rtype }
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
	^EAnn
		expr: (expr goSubsTyExpr: su)
		ann: (ann goSubsTyExprS: su)
]

{ #category : #GT }
EAnn >> gtChildren [
	^{ expr . ann }
]

{ #category : #inlining }
EAnn >> macroExpandEVar: f to: aΛExpr [
	^EAnn
		expr: (expr macroExpandEVar: f to: aΛExpr)
		ann: ann "BOGUS, would be much better to allow inlining in refinements"
]

{ #category : #'as yet unclassified' }
EAnn >> synth: Γ [
"
     Γ ⊦ e <== t   t := fresh(s)
     --------------------------- [Syn-Ann]
     Γ ⊦ e:t => t
"
	| t c |
	t := Γ fresh: ann rtype.
	c := expr check: Γ rtype: t.
	^{ c . t }
]
