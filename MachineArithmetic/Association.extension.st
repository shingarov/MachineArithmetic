Extension { #name : #Association }

{ #category : #'*MachineArithmetic' }
Association >> cubeSol_x: x t: t su: su preds: preds c: c [
	| bbs eqs |
	bbs := self key.
	eqs := self value.
	bbs isEmpty
		ifTrue: [
			| eqs_ preds_ newPred |
			eqs_ := eqs collect: [ :eq | "Reft expr: (" eq subst: su ")" ]. "???"
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

{ #category : #'*MachineArithmetic' }
Association >> reverse [
	^self value -> self key
]

{ #category : #'*MachineArithmetic' }
Association >> subst: θ [
	^self key -> (self value subst: θ)
]
