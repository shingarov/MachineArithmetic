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
		'fun',
		'imm'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
EApp class >> fun: e imm: i [ 
	^ self basicNew 
		fun: e;
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
		fun: (fun accept: aVisitor)
		imm: (imm accept: aVisitor)
]

{ #category : #'sort-checking' }
EApp >> checkANF [
	"Any application (f x) has f in ANF.
	 #elab: wraps it in cast."
	fun checkANF

]

{ #category : #'sort-checking' }
EApp >> checkExpr: f [
"
checkExpr f (EApp g e)     = checkApp f Nothing g e
"
	^f checkApp: nil g: fun es: imm
]

{ #category : #'sort-checking' }
EApp >> elab: anElabEnv [
	"elab f (EApp e₁ e₂).
	 So here e₁=expr, e₂=imm.
	
	Caveat programmator:
	On superficial look, it may seem as if this code misses
	the 'elab f (EApp e1@(EApp _ _) e2)' case; 	however in fact
	it is correct: the paths taken by 	EApp vs EApp-on-EApp
	only differ in the eAppC, therefore we factor the common
	parts out, the resulting code being more readable than the
	upstream Haskell code."
	| r e₁′ s₁ e₂′ s₂ s e θ a b |
	self checkANF.
	r := anElabEnv elabEApp: fun _: imm.
	e₁′ := r first. s₁ := r second. e₂′ := r third. s₂ := r fourth. s := r fifth.
	e := ECst
		eAppC: s
		e1: ((fun isKindOf: EApp) ifTrue: [e₁′] ifFalse: [ anElabEnv note: e₁′ functorName instantiatedTo: s₁. ECst e: e₁′ sort: s₁])
		e2: (ECst e: e₂′ sort: s₂).
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

{ #category : #'sort-checking' }
EApp >> elabAs: t inElabEnv: f [
"
go (EApp e1 e2)   = elabAppAs f t e1 e2
"
	^f elabApp: fun to: imm as: t
]

{ #category : #'term rewriting' }
EApp >> evaluateIn: γ ifUndeclared: vndBlock [
	| fxyz f args |
	fxyz := self splitEApp.
	f := fxyz key evaluateIn: γ ifUndeclared: vndBlock.
	args := fxyz value collect: [ :eachArg | eachArg evaluateIn: γ ifUndeclared: vndBlock ].
	^f valueWithArguments: args
]

{ #category : #accessing }
EApp >> fun [
	^ fun
]

{ #category : #accessing }
EApp >> fun: anObject [
	fun := anObject
]

{ #category : #accessing }
EApp >> functorName [
	^fun functorName
]

{ #category : #GT }
EApp >> gtInspectorSplitIn: composite [
	<gtInspectorPresentationOrder: 0>
	(fun isKindOf: EApp) ifFalse: [ ^nil ].
	composite text
		title: 'Split args';
		display: [ | s |
			s := WriteStream on: String new.
			self printSplitOn: s.
			s contents ]
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

{ #category : #printing }
EApp >> printSplitOn: aStream [
	| f_es f es |
	f_es := self splitEApp. f := f_es key. es := f_es value.
	aStream nextPutAll: '(EApp '.
	{f}, es printOn: aStream delimiter: ' '.
	aStream nextPutAll: ')'.
]

{ #category : #printing }
EApp >> printUncastOn: aStream [ 
	aStream nextPutAll: '(EApp '.
	fun printUncastOn: aStream.
	aStream nextPut: $ .
	imm printUncastOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #'F.Subable' }
EApp >> subst: θ [
	^EApp
		fun: (fun subst: θ)
		imm: (imm subst: θ)
]
