Extension { #name : #'ΛEApp' }

{ #category : #'*Metalanguage' }
ΛEApp >> mifApp: f [
	| tempVarNoCell freshTempName |
	tempVarNoCell := Context readState: #tempVarNo.
	freshTempName := 'anf_temp_var' intSymbol: tempVarNoCell first.
	tempVarNoCell at: 1 put: tempVarNoCell first + 1.
	^ELet
		decl: (SpriteDecl
			bind: (SpriteBind id: freshTempName)
			expr: self toMIF)
		expr: (ΛEApp expr: f imm: (EVar of: freshTempName))
]

{ #category : #'*Metalanguage' }
ΛEApp >> toANF [
	^ΛEApp
		expr: expr toANF
		imm: imm toANF
]

{ #category : #'*Metalanguage' }
ΛEApp >> toMIF [
	^imm mifApp: expr
]
