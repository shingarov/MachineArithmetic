Extension { #name : #Association }

{ #category : #'*Refinements' }
Association >> cubeSol_x: x t: t su: su preds: preds c: c [
	| bbs eqs |
	bbs := self key.
	eqs := self value.
	bbs isEmpty
		ifTrue: [
			| eqs_ preds_ newPred |
			eqs_ := eqs collect: [ :eq | HReft expr: (eq subst: su) ].
			preds_ := preds collect: [ :eq | eq subst: su].
			newPred := HPredAnd of: eqs_, preds_.
			^CstrAll bind: (HBind x: x τ: t p: newPred) p: c
	] ifFalse: [
			| b bs |
			b := bbs first.
			bs := bbs allButFirst.
			^CstrAll bind: b p: (bs->eqs cubeSol_x: x t: t su: su preds: preds c: c)
	]
]

{ #category : #'*Refinements' }
Association >> expr [
"
instance Expression (Symbol, SortedReft) where
  expr (x, RR _ (Reft (v, r))) = subst1 (expr r) (v, EVar x)
cf. Types/Substitutions.hs
"
	| x v r |
	(value isKindOf: SortedReft) ifFalse: [ self error ].
	x := self key.
	v := self value sr_reft symbol.
	r := self value sr_reft expr.
	r isNode ifFalse: [ self error: 'For now, in Smalltalk we only know how to do this for Z3 nodes' ].
	^r renameVariable: v to: x
]

{ #category : #'*Refinements' }
Association >> isRealEdge [
"
isRealEdge :: CEdge -> Bool
"
	(self key isKindOf: DKVarVertex) ifTrue: [ ^false ].
	(self value isKindOf: DKVarVertex) ifTrue: [ ^false ].
	((self key isKindOf: CstrVertex) and: [self value isKindOf: CstrVertex]) ifTrue: [ ^false ].
	^true
]

{ #category : #'*Refinements' }
Association >> pushName [
"pushName :: Maybe (Integer, [Integer]) -> Maybe (Integer, [Integer])
cf. Transformations.hs"
	^key+1 -> ({key+1}, value)
]
