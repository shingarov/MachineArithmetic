"
cf. Types/Refinements.hs

data Expr =
          ...
          | EApp !Expr !Expr
          ...
"
Class {
	#name : #FxEApp,
	#superclass : #Object,
	#instVars : [
		'expr',
		'imm'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FxEApp class >> expr: e imm: i [ 
	^ self basicNew 
		expr: e;
		imm: i;
		yourself
]

{ #category : #'instance creation' }
FxEApp class >> mkEApp: sym args: exprs [
"
mkEApp :: LocSymbol -> [Expr] -> Expr
cf. Refinements.hs
"
	^(FxEVar of: sym) eApps: exprs
]

{ #category : #'sort-checking' }
FxEApp >> elab: anElabEnv [
	| elabResults f x |
	(expr isKindOf: FxEApp) ifTrue: [self shouldBeImplemented "EAPP-EAPP" ].

	elabResults := anElabEnv elabEApp: expr _: imm.
	f := elabResults second z3sort.
	x := elabResults fourth z3sort.
	
	anElabEnv senv sort note: imm  elaboratedTo: x.
	anElabEnv senv sort note: expr elaboratedTo: f.
	
	^{f.x}
]

{ #category : #accessing }
FxEApp >> expr [
	^ expr
]

{ #category : #accessing }
FxEApp >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
FxEApp >> imm [
	^ imm
]

{ #category : #accessing }
FxEApp >> imm: anObject [
	imm := anObject
]

{ #category : #printing }
FxEApp >> printOn: aStream [
	| f_es f es |
	f_es := self splitEApp. f := f_es key. es := f_es value.
	aStream nextPut: $(.
	{f}, es printOn: aStream delimiter: ' '.
	aStream nextPut: $).
]

{ #category : #'as yet unclassified' }
FxEApp >> splitEApp [
"FIXME: Code duplication.
More generally, EApp, EVar should become Exprs."
	^Expr splitEApp: self
]
