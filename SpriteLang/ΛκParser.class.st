Class {
	#name : #'ΛκParser',
	#superclass : #RefinementParser,
	#instVars : [
		'plainDecl',
		'binder',
		'expr',
		'decl',
		'natural',
		'imm',
		'funExpr',
		'letExpr',
		'immExpr',
		'appExpr',
		'expr0',
		'expr1',
		'prog',
		'binExpr',
		'ifExpr',
		'letKeyword',
		'immInt',
		'immBool',
		'immId',
		'switchExpr',
		'alt'
	],
	#classInstVars : [
		'qual'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
ΛκParser >> alt [
	^'|' asParser trim,
	self upperId,
	binder commaList trim optional,
	'=>' asParser trim,
	expr trim
	==> [ :x | Alt
		daCon: x second
		binds: (x third ifNil: [#()])
		expr: x fifth ]
]

{ #category : #accessing }
ΛκParser >> ann [
	^RTypeParser new
]

{ #category : #accessing }
ΛκParser >> appExpr [
	^ immExpr, imm commaList
	==> [ :f_args |
		ΛEApp mkEApp: f_args first args: f_args second ]
]

{ #category : #accessing }
ΛκParser >> binExpr [
	^ imm trim, ΛPrimOp parser trim, imm trim
	==> [ :x |
		| lhs op rhs |
		lhs := x first.
		op := x second.
		rhs := x third.
		op bopL: lhs R: rhs ]
]

{ #category : #accessing }
ΛκParser >> binder [
	^ self identifier
	==> [ :id | SpriteBind identifier: id ]
]

{ #category : #accessing }
ΛκParser >> decl [
	"Annotated declaration"
	^self ann optional, plainDecl
	==> [ :ann_plain | ann_plain last class mkDecl: ann_plain last ann: ann_plain first ]
]

{ #category : #accessing }
ΛκParser >> expr [
	^ funExpr
	/ letExpr
	/ ifExpr
	/ switchExpr
	/ expr trim braces
	/ appExpr
	/ binExpr
	/ expr0
]

{ #category : #accessing }
ΛκParser >> expr0 [
	^ expr parens
	/ immExpr
]

{ #category : #accessing }
ΛκParser >> expr1 [
	^ appExpr
	/ expr0
]

{ #category : #accessing }
ΛκParser >> funExpr [
	^binder commaList trim,
	'=>' asParser trim,
	expr braces trim
	==> [ :xs_body |
		EFun mkEFun: xs_body first expr: xs_body third ]
]

{ #category : #accessing }
ΛκParser >> ifExpr [
	^ 'if' asParser trim,
	imm parens trim,
	expr,
	'else' asParser trim,
	expr
	==> [ :x |
		| v e1 e2 |
		v := x second.
		e1 := x third.
		e2 := x fifth.
		EIf cond: v trueE: e1 falseE: e2 ]
]

{ #category : #accessing }
ΛκParser >> imm [
	^ immInt / immBool / immId
]

{ #category : #accessing }
ΛκParser >> immBool [
	^ ('true'  asParser ==> [ :_x | ECon prim: (PBool bool: true) ])
	/ ('false' asParser ==> [ :_x | ECon prim: (PBool bool: false) ])
]

{ #category : #accessing }
ΛκParser >> immExpr [
	^imm ==> [ :i | EImm imm: i ]
]

{ #category : #accessing }
ΛκParser >> immId [
	^ self identifier
	==> [ :id | EVar of: id ]
]

{ #category : #accessing }
ΛκParser >> immInt [
	^ natural
	==> [ :nat | ECon prim: (PInt integer: nat) ]
]

{ #category : #accessing }
ΛκParser >> letExpr [
	^ decl, expr
	==> [ :d_e |
		ELet decl: d_e first expr: d_e last ]
]

{ #category : #accessing }
ΛκParser >> letKeyword [
	^( 'let rec' asParser ==> [ :_x | SpriteRDecl ] )
	/( 'let' asParser ==> [ :_x | SpriteDecl ] )

]

{ #category : #accessing }
ΛκParser >> measures [
	^MeasureParser new annotationBrackets trim star
]

{ #category : #accessing }
ΛκParser >> natural [
	^#digit asParser plus flatten trim
	==> [ :x | x asInteger ]
]

{ #category : #accessing }
ΛκParser >> options [
	^ '[--check-termination]' asParser trim optional
	==> [ :x | x ifNil: [Set new] ifNotNil: [Set with: #'check-termination'] ]
]

{ #category : #accessing }
ΛκParser >> plainDecl [
	^letKeyword,
	#space asParser plus,
	binder trim,
	$= asParser trim,
	expr trim,
	$; asParser trim
	==> [ :x | x first bind: x third expr: x fifth ]
	
]

{ #category : #accessing }
ΛκParser >> prog [
	^ self options, self quals, self measures, self typs, decl star
	==> [ :x |
			Prog
				quals: x second
				meas: x third
				expr: (ΛExpression fromDecls: x last)
				data: x fourth
				options: x first ]
]

{ #category : #accessing }
ΛκParser >> quals [
	^QualifParser new annotationBrackets trim star
]

{ #category : #accessing }
ΛκParser >> start [
	^ #space asParser star, prog end
	==> [ :x | x last ]
]

{ #category : #accessing }
ΛκParser >> switchExpr [
	^'switch' asParser trim,
	self lowerId parens trim,
	alt plus braces
	==> [ :x | ECase x: x second alts: x third ]
]

{ #category : #accessing }
ΛκParser >> typs [
	^DataTypeParser new star
]
