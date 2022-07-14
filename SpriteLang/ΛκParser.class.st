Class {
	#name : #'ΛκParser',
	#superclass : #RefinementParser,
	#instVars : [
		'plainDecl',
		'binder',
		'expr',
		'identifier',
		'decl',
		'ann',
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
		'quals',
		'qual',
		'qualParam',
		'qualParams',
		'nonParen',
		'matchedParen'
	],
	#classInstVars : [
		'qual'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
ΛκParser >> ann [
	^RTypeParser new
]

{ #category : #accessing }
ΛκParser >> appExpr [
	^ immExpr, (imm separatedBy: $, asParser ==>[:_x|nil]) parens
	==> [ :f_args |
		| f args |
		f := f_args first.
		args := f_args second reject: #isNil.
		EApp mkEApp: f args: args ]
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
	^identifier ==> [ :id | SpriteBind identifier: id ]
]

{ #category : #accessing }
ΛκParser >> ctorsP [

]

{ #category : #accessing }
ΛκParser >> decl [
	^ ann optional, plainDecl
	==> [ :ann_plain | ann_plain last class mkDecl: ann_plain last ann: ann_plain first ]
]

{ #category : #accessing }
ΛκParser >> expr [
	^ funExpr
	/ letExpr
	/ ifExpr
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
	^(binder separatedBy: $, asParser ==> [:x|nil]) parens trim,
	'=>' asParser trim,
	expr braces trim
	==> [ :xs_body |
		| xs body |
		xs := xs_body first reject: #isNil.
		body := xs_body third.
		EFun mkEFun: xs expr: body ]
]

{ #category : #accessing }
ΛκParser >> identifier [
	^ (#letter asParser , #word asParser star) flatten trim
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
	^ identifier
	==> [ :id | EVar symbol: id ]
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
ΛκParser >> matchedParen [
	^(nonParen / matchedParen parens) plus flatten
]

{ #category : #accessing }
ΛκParser >> natural [
	^#digit asParser plus flatten trim
	==> [ :x | x asInteger ]
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
	^ quals, self typP star, decl star
	==> [ :qs_decls |
			| qs decls |
			qs := qs_decls first.
			decls := qs_decls last.
			{ qs. ΛExpression fromDecls: decls } ]
]

{ #category : #accessing }
ΛκParser >> qual [
	^ 'qualif ' asParser,
	self upperId,
	qualParams,
	':' asParser,
	#space asParser plus,
	matchedParen parens
	==> [ :x | Qualifier
			name: x second 
			params: x third 
			body: (DecidableRefinement text: x sixth) ]
]

{ #category : #accessing }
ΛκParser >> qualParam [
	^ self lowerId,
		$: asParser,
		(('int' asParser ==> [ :_x | Int sort ]) / ('bool' asParser  ==> [ :_x | Bool sort ]))
	==> [ :x | QualParam symbol: x first sort: x last ]
]

{ #category : #accessing }
ΛκParser >> qualParams [
	^ (self qualParam separatedBy: $, asParser trim ==>[:_x|nil]) parens
	==> [ :parms | parms reject: #isNil ]
]

{ #category : #accessing }
ΛκParser >> quals [
	^qual annotationBrackets trim star
]

{ #category : #accessing }
ΛκParser >> start [
	^ #space asParser star, prog end
	==> [ :x | x last ]
]

{ #category : #accessing }
ΛκParser >> typArgs [

]

{ #category : #accessing }
ΛκParser >> typP [
	^'type ' asParser,
	self lowerId,
	self typArgs,
	' =' asParser, #newline asParser,
	self ctorsP
	==> [ :x | x halt ]
]
