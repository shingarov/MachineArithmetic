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
	(e isKindOf: ECst) ifTrue: [
		"Don't create nested casts.
		 Just check that the sorts match, and return one-layer cast."
		e sort = s ifFalse: [ self error ].
		^e
	].
	^self basicNew
		expr: e;
		sort: s;
		yourself
]

{ #category : #visiting }
ECst >> accept: aVisitor [
	^self class
		expr: (expr accept: aVisitor)
		sort: (sort accept: aVisitor)
]

{ #category : #'as yet unclassified' }
ECst >> applyExpr: θ [
"DON'T COMMIT ME YET.
This is only used in our experiments with L6maxint."
	^ECst expr: expr sort: (sort apply: θ)
]

{ #category : #'sort-checking' }
ECst >> checkExpr: f [ 
	^expr checkCst: sort inEnv: f
]

{ #category : #elaboration }
ECst >> defuncEApp: es env: env [
"
Monomorphize function applications.
defuncEApp :: SymEnv -> Expr -> [(Expr, Sort)] -> Expr
               env       e         es
"
	| finalSort_argSorts answer |
	(expr isKindOf: EVar) ifFalse: [ self error ].
	"γ := env theory.
	 e′_es′ := γ takeArgs: self es: es."
	finalSort_argSorts := es inject: sort -> #() into: [ :fTypeLeft_argsAcc :thisTime |
		| argThisTime thisArgSort fSortThisTime fSortLeft |
		fSortThisTime := fTypeLeft_argsAcc key. (fSortThisTime isKindOf: FFunc) ifFalse: [ self error ].
		argThisTime := thisTime key expr.
		thisArgSort := thisTime key sort guest. fSortThisTime from guest = thisArgSort ifFalse: [ self error ].
		fSortLeft := fSortThisTime to.
		fSortLeft -> (fTypeLeft_argsAcc value, {ECst expr: argThisTime sort: thisArgSort})
	].
	answer := env uncurriedApp: expr args: finalSort_argSorts value resultSort: finalSort_argSorts key.
	^ECst expr: answer sort:  answer resultSort
]

{ #category : #elaboration }
ECst >> elab: f [
"
elab f (ECst e t) = do
  (e', _) <- elab f e 
  return (ECst e' t, t)
"
	| e′_☐ evalEnv |
	(expr isKindOf: EIte) ifTrue: [ self shouldBeImplemented "elab f@(_,g) (ECst (EIte p e1 e2) t)" ].
	e′_☐ := expr elab: f.
	^{ ECst expr: e′_☐ first sort: sort . sort }
]

{ #category : #elaboration }
ECst >> elabApplyStep: γ [
	^ECst
		expr: (expr elabApply: γ)
		sort: sort
]

{ #category : #'term rewriting' }
ECst >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	| v |
	v := expr evaluateIn: anEvalEnv ifUndeclared: vndBlock.
	self assert: [v sort = sort ].
	^ECst
		expr: v
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

{ #category : #printing }
ECst >> printOn: aStream [
	aStream nextPut: (Character codePoint: 16r27EC).
	sort printOn: aStream.
	aStream nextPut: (Character codePoint: 16r27ED).
	expr printOn: aStream.
]

{ #category : #printing }
ECst >> printUncastOn: aStream [
	expr printUncastOn: aStream
]

{ #category : #'SMT interface' }
ECst >> smt2: γ [
	| fxyz f args |
	(sort isKindOf: FFunc) ifTrue: [
		| nt uncurriedSort |
		(expr isKindOf: EVar) ifFalse: [ self error "monkey programmer at work" ].
		nt := γ naturalTransformationFor: expr sym.
		uncurriedSort := sort uncurryIn: γ.
		^nt from: uncurriedSort dom to: uncurriedSort cod in: γ
	].

	(expr isKindOf: EApp) ifFalse: [ ^expr smt2Cast: sort in: γ ].

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
