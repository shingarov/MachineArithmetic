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

{ #category : #'*SpriteLang' }
RefVarApp >> subsAR: p ar: anARef [
"
go (H.Var k xs) | k == p ...
"
	| pr xs yts θ |
	var = p ifFalse: [ ^self ].
	xs := args.
	pr := anARef arPred expr.
	yts := anARef arArgs.
	θ := yts zip: xs with: [ :y_☐ :x | y_☐ key -> x ].
	^pr substs: θ
]
