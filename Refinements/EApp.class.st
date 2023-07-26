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

{ #category : #visiting }
EApp >> accept: aVisitor [
	^EApp
		expr: (expr accept: aVisitor)
		imm:  (imm  accept: aVisitor)
]

{ #category : #'sort-checking' }
EApp >> elab: anElabEnv [
	"elab f (EApp e₁ e₂).
	 So here e₁=expr, e₂=imm."
	| r e₁′ s₁ e₂′ s₂ s e θ a b |
	"self checkANF."
	r := anElabEnv elabEApp: expr _: imm.
	e₁′ := r first. s₁ := r second. e₂′ := r third. s₂ := r fourth. s := r fifth.
	e := ECst
		eAppC: s
		e1: ((expr isKindOf: EApp) ifTrue: [e₁′] ifFalse: [ECst expr: e₁′ sort: s₁])
		e2: (ECst expr: e₂′ sort: s₂).
	^{e . s}
]

{ #category : #uncurrying }
EApp >> elabApply: γ [
	self error
]

{ #category : #uncurrying }
EApp >> elabApplyStep: γ [
	^self elabApply: γ
]

{ #category : #'term rewriting' }
EApp >> evaluateIn: γ [
	^EApp
		expr: (expr evaluateIn: γ)
		imm: (imm evaluateIn: γ)
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
EApp >> functorName [
	^expr functorName
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
	aStream nextPutAll: '(EApp '.
	{f}, es printOn: aStream delimiter: ' '.
	aStream nextPutAll: ')'.
]

{ #category : #'SMT interface' }
EApp >> smt2: γ [ 
	^(expr smt2: γ) value: (imm smt2: γ)
]

{ #category : #uncurrying }
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
