Extension { #name : #'ΛExpression' }

{ #category : #'*Metalanguage' }
ΛExpression >> mif: innerBodyBlock [
	"Invent a new temp-var name (say e.g. t) and answer
	   let t = self in innerBody
	 where innerBody is the result of evaluation of
	 innerBodyBlock with «t».
	"
	| tempVarNoCell freshTempName |
	tempVarNoCell := Context readState: #tempVarNo.
	freshTempName := 'anf_temp_var' intSymbol: tempVarNoCell first.
	tempVarNoCell at: 1 put: tempVarNoCell first + 1.
	^ELet
		decl: (SpriteDecl
			bind: (SpriteBind id: freshTempName)
			expr: self toMIF)
		expr: (innerBodyBlock value: (EVar of: freshTempName))
]

{ #category : #'*Metalanguage' }
ΛExpression >> mifApp: f [
	^self mif: [ :t | ΛEApp expr: f imm: t ]
]

{ #category : #'*Metalanguage' }
ΛExpression >> mifCase: alts [
	^self mif: [ :t | ECase x: t sym alts: (alts collect: #toMIF)]
]

{ #category : #'*Metalanguage' }
ΛExpression >> mifIfThen: thenE else: elseE [
	^self mif: [ :t | EIf cond: t trueE: thenE falseE: elseE ]
]

{ #category : #'*Metalanguage' }
ΛExpression >> toANF [
	"Assuming the receiver has already been converted to Monadic form,
	 flatten it to Flanagan–Sabry–Felleisen Administrative Normal Form
	 ('The Essence of Compiling with Continuations', PLDI'93, see
	  https://dl.acm.org/doi/10.1145/155090.155113 "
	^self subclassResponsibility
]

{ #category : #'*Metalanguage' }
ΛExpression >> toMIF [
	"Answer the receiver normalized to MIF."
	^self subclassResponsibility
]
