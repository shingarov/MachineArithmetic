Extension { #name : #'ΛEApp' }

{ #category : #'*Metalanguage' }
ΛEApp >> macroExpandEVar: f to: aΛExpr [
	| arityOrFalse appThisTime args argNames argValues body |
	arityOrFalse := self isApplicationOf: f.
	arityOrFalse isNil ifTrue: [
		"Not me.  Pass along..."
		^ΛEApp
			expr: (expr macroExpandEVar: f to: aΛExpr)
			imm: (imm macroExpandEVar: f to: aΛExpr)
	].

	appThisTime := self.
	args := OrderedCollection new.
	body := aΛExpr.
	arityOrFalse timesRepeat: [ 
		args add: body bind id -> appThisTime imm.
		body := body expr.
		appThisTime := appThisTime expr.
	].
	argNames := args collect: #key.
	argValues := (args collect: #value) reversed.
	^(argNames zip: argValues) inject: body into: [ :accum :thisArg | accum macroExpandEVar: thisArg key to: thisArg value ]
]

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
