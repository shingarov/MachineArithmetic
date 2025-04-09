Extension { #name : #Z3Sort }

{ #category : #'*SpriteLang' }
Z3Sort >> canBeTerminationMetric [
	^false
]

{ #category : #'*SpriteLang' }
Z3Sort >> constTyApp: value [
	| v |
	v := 'theoryFunctionV'.
	^TBase
		b: self λBase
		r: (Reft
			symbol: v
			expr: (PAtom brel: #=== x: (EVar of: v) y: value)) known
]

{ #category : #'*SpriteLang' }
Z3Sort >> sort2bTrue [
	^self λBase bTrue
]
