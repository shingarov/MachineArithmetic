"
cf. Types/Refinements.hs

data Expr =
          ...
          | EApp !Expr !Expr
          ...
"
Class {
	#name : #EApp,
	#superclass : #Expr,
	#instVars : [
		'expr',
		'imm'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EApp class >> expr: e imm: i [ 
	^ self basicNew 
		expr: e;
		imm: i;
		yourself
]

{ #category : #'instance creation' }
EApp class >> mkEApp: sym args: exprs [
"
mkEApp :: LocSymbol -> [Expr] -> Expr
cf. Refinements.hs
"
	^(EVar of: sym) eApps: exprs
]

{ #category : #'sort-checking' }
EApp >> elab: anElabEnv [
	| r e1′ s1 e2′ s2 s e θ a b |
	(expr isKindOf: EApp) ifTrue: [self shouldBeImplemented "EAPP-EAPP" ].

	r := anElabEnv elabEApp: expr _: imm.
	e1′ := r first. s1 := r second. e2′ := r third. s2 := r fourth. s := r fifth.
	e :=  ECst eAppC: s e1: (ECst expr: e1′ sort: s1) e2: (ECst expr: e2′ sort: s2).	
	"TODO: what about these
	  let θ = unifyExpr (snd f) e
	  let a = applyExpr θ e
	  let b = maybe s (`apply` s) θ
	  (a, b)
	"
	^{e . s}
]

{ #category : #accessing }
EApp >> expr [
	^ expr
]

{ #category : #accessing }
EApp >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
EApp >> imm [
	^ imm
]

{ #category : #accessing }
EApp >> imm: anObject [
	imm := anObject
]

{ #category : #printing }
EApp >> printOn: aStream [
	| f_es f es |
	f_es := self splitEApp. f := f_es key. es := f_es value.
	aStream nextPut: $(.
	{f}, es printOn: aStream delimiter: ' '.
	aStream nextPut: $).
]

{ #category : #'SMT interface' }
EApp >> smt2: γ [ 
	^(expr smt2: γ) value: (imm smt2: γ)
]

{ #category : #'as yet unclassified' }
EApp >> splitEApp [
"FIXME: Code duplication.
More generally, EApp, EVar should become Exprs."
	^Expr splitEApp: self
]

{ #category : #'F.Subable' }
EApp >> subst: θ [
	^EApp
		expr: (expr subst: θ)
		imm: (imm subst: θ)
]
