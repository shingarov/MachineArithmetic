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
	^(EApp fun: e1 imm: e2) eCst: s
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

{ #category : #elaboration }
ECst >> dropECst [
"
ECst e' _ -> dropECst e'
"
	^e dropECst
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
  return (eCst e' t, t)
"
	| e′_☐ e′ |
	(e isKindOf: EIte) ifTrue: [ ^self elab_CstIte: f ].
	e′_☐ := e elab: f.  e′ := e′_☐ first.
	^{ e′ eCst: sort . sort }
]

{ #category : #elaboration }
ECst >> elabApplyStep: γ [
	^ECst
		e:   (e elabApply: γ)
		sort: sort
]

{ #category : #elaboration }
ECst >> elab_CstIte: f [
"
elab f@(!_,!g) (ECst (EIte !p !e1 !e2) !t) = do
  (!p', !_)   <- elab f p
  (!e1', !s1) <- elab f (eCst e1 t)
  (!e2', !s2) <- elab f (eCst e2 t)
  !s          <- checkIteTy g p e1' e2' s1 s2
  return (EIte p' (eCst e1' s) (eCst e2' s), t)
"
	| p e₁ e₂ t e₁′ e₂′ s₁ s₂ s p′ e₁′_s₁ e₂′_s₂ |
	p := e b. e₁ := e thenE. e₂ := e elseE. t := sort.
	p′ := (p elab: f) first.
	e₁′_s₁ := (e₁ eCst: t) elab: f. e₁′ := e₁′_s₁ first. s₁ := e₁′_s₁ second.
	e₂′_s₂ := (e₂ eCst: t) elab: f. e₂′ := e₂′_s₂ first. s₂ := e₂′_s₂ second.
	s := f env checkIteTy: p e₁: e₁′ e₂: e₂′ t₁: s₁ t₂: s₂.
	^{EIte
			if: p′
			then: (e₁′ eCst: s)
			else: (e₂′ eCst: s)
		.
		s
	}
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

	"This late in the game, elabApply: has already uncurried all EApps
	 into UncurriedApps, so no EApps are left, let alone hide in ECst"
	self assert: (e isKindOf: EApp) not.

	^e smt2Cast: sort in: γ
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
