Class {
	#name : #ECst,
	#superclass : #Expr,
	#instVars : [
		'e',
		'sort'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
ECst class >> e: e sort: s [
	(e isKindOf: ECst) ifTrue: [ ^e ]. "Don't create nested casts."
	^self basicNew
		e:    e;
		sort: s;
		yourself
]

{ #category : #'instance creation' }
ECst class >> eAppC: s e1: e1 e2: e2 [
"
eAppC :: Sort -> Expr -> Expr -> Expr
"
	^self e: (EApp fun: e1 imm: e2) sort: s
]

{ #category : #visiting }
ECst >> accept: aVisitor [
	^self class
		e: (e    accept: aVisitor)
		sort: (sort accept: aVisitor)
]

{ #category : #'sort-checking' }
ECst >> checkExpr: f [ 
	^e checkCst: sort inEnv: f
]

{ #category : #elaboration }
ECst >> defuncEApp: es env: env [
"
Monomorphize function applications.
defuncEApp :: SymEnv -> Expr -> [(Expr, Sort)] -> Expr
               env       e         es
"
	| finalSort_argSorts answer |
	self assert: (e isKindOf: EVar).
	finalSort_argSorts := es inject: sort -> #() into: [ :fTypeLeft_argsAcc :thisTime |
		| argThisTime thisArgSort fSortThisTime fSortLeft |
		fSortThisTime := fTypeLeft_argsAcc key.
		argThisTime := thisTime key e.
		thisArgSort := thisTime key sort guest.
		fSortLeft := fSortThisTime to.
		fSortLeft -> (fTypeLeft_argsAcc value, {ECst e: argThisTime sort: thisArgSort})
	].
	answer := UncurriedApp f: e args: finalSort_argSorts value resultSort: finalSort_argSorts key.
	^ECst e: answer sort:  answer resultSort
]

{ #category : #accessing }
ECst >> e [
	^ e
]

{ #category : #accessing }
ECst >> e: anObject [
	e := anObject
]

{ #category : #elaboration }
ECst >> elab: f [
"
elab f (ECst e t) = do
  (e', _) <- elab f e 
  return (ECst e' t, t)
"
	| e′_☐ evalEnv |
	(e isKindOf: EIte) ifTrue: [ self shouldBeImplemented "elab f@(_,g) (ECst (EIte p e1 e2) t)" ].
	e′_☐ := e elab: f.
	^{ ECst e: e′_☐ first sort: sort . sort }
]

{ #category : #elaboration }
ECst >> elabApplyStep: γ [
	^ECst
		e:   (e elabApply: γ)
		sort: sort
]

{ #category : #'term rewriting' }
ECst >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	| v |
	v := e evaluateIn: anEvalEnv ifUndeclared: vndBlock.
	self assert: [v sort = sort ].
	^ECst
		e: v
		sort: sort
]

{ #category : #'as yet unclassified' }
ECst >> exprSymbolsSet [
	^e exprSymbolsSet
]

{ #category : #GT }
ECst >> gtInspectorUncastIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite text
		title: 'Uncast';
		display: [ | s |
			s := WriteStream on: String new.
			self printUncastOn: s.
			s contents ]
]

{ #category : #visiting }
ECst >> mapExprOnExpr_case: f [
	^ECst
		e: (e mapExprOnExpr: f)
		sort: sort
]

{ #category : #printing }
ECst >> printOn: aStream [
	aStream nextPut: (Character codePoint: 16r27EC).
	sort printOn: aStream.
	aStream nextPut: (Character codePoint: 16r27ED).
	e printOn: aStream.
]

{ #category : #printing }
ECst >> printUncastOn: aStream [
	e printUncastOn: aStream
]

{ #category : #'SMT interface' }
ECst >> smt2: γ [
	| fxyz f args |
	(sort isKindOf: FFunc) ifTrue: [
		| nt uncurriedSort |
		(e isKindOf: EVar) ifFalse: [ self error "monkey programmer at work" ].
		nt := γ naturalTransformationFor: e sym.
		uncurriedSort := sort uncurryIn: γ.
		^nt from: uncurriedSort dom to: uncurriedSort cod in: γ
	].

	(e isKindOf: EApp) ifFalse: [ ^e smt2Cast: sort in: γ ].

	"TODO: Investigate why control can reach here.
	 See Issue#272."
	
	"(ECst (EApp...)):
	Possibly need to uncurry."
	fxyz := self splitArgs.
	f := fxyz key smt2: γ.
	args := fxyz value collect: [ :eachArg | eachArg key smt2: γ ].
	^f valueWithArguments: args
]

{ #category : #accessing }
ECst >> sort [
	^ sort
]

{ #category : #accessing }
ECst >> sort: anObject [
	sort := anObject
]

{ #category : #'F.Subable' }
ECst >> subst: su [
"
subst su (ECst e so)     = ECst (subst su e) so
"
	^ECst
		e:   (e subst: su)
		sort: sort
]
