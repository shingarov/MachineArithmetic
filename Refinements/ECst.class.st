Class {
	#name : #ECst,
	#superclass : #Expr,
	#instVars : [
		'expr',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
ECst class >> eAppC: s e1: e1 e2: e2 [
"
eAppC :: Sort -> Expr -> Expr -> Expr
"
	^self expr: (EApp expr: e1 imm: e2) sort: s
]

{ #category : #'instance creation' }
ECst class >> expr: e sort: s [
	^self basicNew
		expr: e;
		sort: s;
		yourself
]

{ #category : #'as yet unclassified' }
ECst >> applyExpr: θ [
"DON'T COMMIT ME YET.
This is only used in our experiments with L6maxint."
	^ECst expr: expr sort: (sort apply: θ)
]

{ #category : #elaboration }
ECst >> defuncEApp: es env: γ [
"
Monomorphize function applications.
defuncEApp :: SymEnv -> Expr -> [(Expr, Sort)] -> Expr
               env       e         es
Unlike LH, we don't have 'apply' functions.
TODO: obviously this is not enough, we have to version the function name
for each monomorphic variant if the function is polymorphic.
"
	| finalSort_argSorts answer |
	(expr isKindOf: EVar) ifFalse: [ self error ].
	finalSort_argSorts := es inject: sort -> #() into: [ :fTypeLeft_argsAcc :thisTime |
		| argThisTime thisArgSort fSortThisTime fSortLeft |
		fSortThisTime := fTypeLeft_argsAcc key. (fSortThisTime isKindOf: FFunc) ifFalse: [ self error ].
		argThisTime := thisTime key expr.
		thisArgSort := thisTime key sort. fSortThisTime from = thisArgSort ifFalse: [ self error ].
		fSortLeft := fSortThisTime to.
		fSortLeft -> (fTypeLeft_argsAcc value, {ECst expr: argThisTime sort: thisArgSort})
	].
	answer := UncurriedApp f: expr args: finalSort_argSorts value resultSort: finalSort_argSorts key.
	γ sort note: sort elaboratedTo: answer sort.
	^answer
]

{ #category : #elaboration }
ECst >> elab: anElabEnv [
	| e′_☐ evalEnv computed |
	e′_☐ := expr elab: anElabEnv.
	^{ ECst expr: e′_☐ first sort: sort }
]

{ #category : #uncurrying }
ECst >> elabApplyStep: γ [
	^ECst
		expr: (expr elabApply: γ)
		sort: sort
]

{ #category : #accessing }
ECst >> expr [
	^ expr
]

{ #category : #accessing }
ECst >> expr: anObject [
	expr := anObject
]

{ #category : #'SMT interface' }
ECst >> smt2: γ [ 
	^expr smt2Cast: sort in: γ
]

{ #category : #accessing }
ECst >> sort [
	^ sort
]

{ #category : #accessing }
ECst >> sort: anObject [
	sort := anObject
]
