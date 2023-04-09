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

	" used to be called from #value: like this
	
	| appSort f_x f x |
	appSort := EApp expr: sort instantiate imm: arg sort.
	f_x := appSort elab: Context currentElabEnv .
	f := f_x first withName: name.
	Context currentElabEnv senv sort note: sort elaboratedTo: f.
	x := arg toZ3Node.
	^f value: x"



	| elabResults f x |
	(expr isKindOf: EApp) ifTrue: [self shouldBeImplemented "EAPP-EAPP" ].

	elabResults := anElabEnv elabEApp: expr _: imm.
	f := elabResults second z3sort.
	x := elabResults fourth z3sort.
	
	anElabEnv senv sort note: imm  elaboratedTo: x.
	anElabEnv senv sort note: expr elaboratedTo: f.
	
	^{f.x}
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
