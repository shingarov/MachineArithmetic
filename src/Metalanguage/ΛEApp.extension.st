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
ΛEApp >> toANF [
	"In ANF, the f in f(x) can itself be complex;
	 but if it is, it can only be an application.
	 However, toMIF may have resulted in creating a let."
	(expr isKindOf: ELet) ifTrue: [
			"I am of the form (let t = a in b) ∘ x.
			 Pull the let from under the app:
			 let t = a in (b∘x).
			 "
			| t a b x |
			t := expr decl bind.
			a := expr decl expr toANF.
			b := expr expr.
			x := imm toANF.
			^(ELet
				decl: (SpriteDecl bind: t expr: a)
				expr: (ΛEApp expr: b imm: x)) toANF
 ].
	^ΛEApp
		expr: expr toANF
		imm: imm toANF
]

{ #category : #'*Metalanguage' }
ΛEApp >> toMIF [
	^imm mifApp: expr toMIF
]
