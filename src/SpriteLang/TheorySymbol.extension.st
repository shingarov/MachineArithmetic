Extension { #name : #TheorySymbol }

{ #category : #'*SpriteLang' }
TheorySymbol >> constTy [
	(tsInterp = SemTheory) ifFalse: [ self error ].
	[^tsSort constTyApp: (EVar of: tsSym)] runReader: #argNumber initialState: {1}
]
