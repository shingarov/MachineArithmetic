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

{ #category : #'α-renaming' }
EAnn >> uniq2: α [
	| α′sig α′expr |

	"We want (need) to rename variables so that names
	 in function signature are the same as names in
	 function declaration. For example:

		⟦val sum : x:int => int[v|0 <= v] / [x]⟧
	   let rec sum = (n) => { ...

	Needs to become

		⟦val sum : x__001:int => int[v|0 <= v] / [x__001]⟧
	   let rec sum = (x__001) => { ...

	So we have to first collect all arguments (both in signature
	and decl and create α′ accordignly), but only if expr is actually
	a function declaration (EFun). For example:

		⟦val add2 : n:int => int[a | a === (n + 2)]⟧
		let add2 = compose(cha0, incr, incr);

	"

	α′sig := α.
	α′expr := α.

	expr isFun ifTrue:[
		| sig fun |

		sig := ann rtype.
		fun := expr.

		[ sig isFun ] whileTrue:[
			| x′ |

			x′ := α at: sig x ifAbsent:[sig x uniq].
			α′sig := α′sig extMap: sig x to: x′.
			α′expr := α′expr extMap: fun bind id to: x′.

			sig := sig t.
			fun := fun expr.
		].
	].

	^self class
		expr: (expr uniq2: α′expr)
		ann:  (ann uniq2: α′sig)


]
