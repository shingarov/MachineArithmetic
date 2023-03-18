Extension { #name : #RefVarApp }

{ #category : #'*SpriteLang' }
RefVarApp >> subs: p ar: ar [
	| yts pr |
	"subsAR p (ARef yts (Known _ pr)) = go..."
	yts := ar arArgs.
	(ar arPred isKindOf: KnownReft) ifFalse: [ self error ].
	pr := ar arPred expr.
	var = p ifFalse: [ ^self ].
	^pr substs: (yts zip: args with: [ :y__ :x |
				| y |
				y := y__ key.
				y->x ])
]
