"
data Expr = ESym !SymConst
  ...
  | EIte !Expr !Expr !Expr
"
Class {
	#name : #EIte,
	#superclass : #Expr,
	#instVars : [
		'b',
		'thenE',
		'elseE'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EIte class >> if: b then: e₁ else: e₂ [
	^self basicNew
		b: b;
		thenE: e₁;
		elseE: e₂;
		yourself
]

{ #category : #'instance creation' }
EIte class >> new [
	self shouldNotImplement
]

{ #category : #visiting }
EIte >> accept: aVisitor [
	b accept: aVisitor.
	thenE accept: aVisitor.
	elseE accept: aVisitor.
]

{ #category : #accessing }
EIte >> b [
	^ b
]

{ #category : #accessing }
EIte >> b: anObject [
	b := anObject
]

{ #category : #'sort-checking' }
EIte >> checkExpr: f [
"
checkExpr f (EIte p e1 e2) = checkIte f p e1 e2
"
	^f checkIte: b e₁: thenE e₂: elseE
]

{ #category : #elaboration }
EIte >> elab: f [
"
elab f@(_,g) (EIte p e1 e2) = do
"
	| g t b′ e1′_s1 e1′ s1 e2′_s2 e2′ s2 s |
	g := f env.
	t := g getIte_e1: thenE e2: elseE.
	b′ := (b elab: f) first. "(p', _)   <- elab f p"
	e1′_s1 := (ECst e: thenE sort: t) elab: f.
	e1′ := e1′_s1 first. s1 := e1′_s1 second.
	e2′_s2 := (ECst e: elseE sort: t) elab: f.
	e2′ := e2′_s2 first. s2 := e2′_s2 second.
	s := g checkIteTy: b e₁: e1′ e₂: e2′ t₁: s1 t₂: s2.
	
	^{ (EIte
		if: b′
		then: (ECst e: e1′ sort: s) "cast taken care of inside #expr:sort:"
		else: (ECst e: e2′ sort: s) ) .
		s
	}
]

{ #category : #elaboration }
EIte >> elabApplyStep: γ [
"
step (EIte e1 e2 e3)  = EIte (go e1) (go e2) (go e3)
"
	^EIte
		if: (b elabApply: γ)
		then: (thenE elabApply: γ)
		else: (elseE elabApply: γ)
]

{ #category : #accessing }
EIte >> elseE [
	^ elseE
]

{ #category : #accessing }
EIte >> elseE: anObject [
	elseE := anObject
]

{ #category : #'term rewriting' }
EIte >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^EIte
		if: (b evaluateIn: anEvalEnv ifUndeclared: vndBlock)
		then: (thenE evaluateIn: anEvalEnv ifUndeclared: vndBlock)
		else: (elseE evaluateIn: anEvalEnv ifUndeclared: vndBlock)
]

{ #category : #'SMT interface' }
EIte >> smt2: γ [
	^((b smt2: γ)
		ifThen: (thenE smt2: γ)
		else:   (elseE smt2: γ)
		) simplify
]

{ #category : #accessing }
EIte >> thenE [
	^ thenE
]

{ #category : #accessing }
EIte >> thenE: anObject [
	thenE := anObject
]
