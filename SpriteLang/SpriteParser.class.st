Class {
	#name : #SpriteParser,
	#superclass : #PPCompositeParser,
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
SpriteParser >> ann [
	^RTypeParser new
]

{ #category : #accessing }
SpriteParser >> appExpr [
	^ immExpr, (imm separatedBy: $, asParser ==>[:_x|nil]) parens
	==> [ :f_args |
		| f args |
		f := f_args first.
		args := f_args second reject: #isNil.
		EApp mkEApp: f args: args ]
]

{ #category : #accessing }
SpriteParser >> binExpr [
	^ imm trim, ΛPrimOp parser trim, imm trim
	==> [ :x |
		| lhs op rhs |
		lhs := x first.
		op := x second.
		rhs := x third.
		op bopL: lhs R: rhs ]
]

{ #category : #accessing }
SpriteParser >> binder [
	^identifier ==> [ :id | SpriteBind identifier: id ]
]

{ #category : #accessing }
SpriteParser >> decl [
	^ ann optional, plainDecl
	==> [ :ann_plain | ann_plain last class mkDecl: ann_plain last ann: ann_plain first ]
]

{ #category : #accessing }
SpriteParser >> expr [
	^ funExpr
	/ letExpr
	/ ifExpr
	/ expr trim braces
	/ appExpr
	/ binExpr
	/ expr0
]

{ #category : #accessing }
SpriteParser >> expr0 [
	^ expr parens
	/ immExpr
]

{ #category : #accessing }
SpriteParser >> expr1 [
	^ appExpr
	/ expr0
]

{ #category : #accessing }
SpriteParser >> funExpr [
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
SpriteParser >> identifier [
	^ (#letter asParser , #word asParser star) flatten trim
]

{ #category : #accessing }
SpriteParser >> ifExpr [
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
SpriteParser >> imm [
	^ immInt / immBool / immId
]

{ #category : #accessing }
SpriteParser >> immBool [
	^ ('true'  asParser ==> [ :_x | ECon prim: (PBool bool: true) ])
	/ ('false' asParser ==> [ :_x | ECon prim: (PBool bool: false) ])
]

{ #category : #accessing }
SpriteParser >> immExpr [
	^imm ==> [ :i | EImm imm: i ]
]

{ #category : #accessing }
SpriteParser >> immId [
	^ identifier
	==> [ :id | EVar symbol: id ]
]

{ #category : #accessing }
SpriteParser >> immInt [
	^ natural
	==> [ :nat | ECon prim: (PInt integer: nat) ]
]

{ #category : #accessing }
SpriteParser >> letExpr [
	^ decl, expr
	==> [ :d_e |
		ELet decl: d_e first expr: d_e last ]
]

{ #category : #accessing }
SpriteParser >> letKeyword [
	^( 'let rec' asParser ==> [ :_x | SpriteRDecl ] )
	/( 'let' asParser ==> [ :_x | SpriteDecl ] )

]

{ #category : #accessing }
SpriteParser >> matchedParen [
	^(nonParen / matchedParen parens) plus flatten
]

{ #category : #accessing }
SpriteParser >> natural [
	^#digit asParser plus flatten trim
	==> [ :x | x asInteger ]
]

{ #category : #accessing }
SpriteParser >> plainDecl [
	^letKeyword,
	#space asParser plus,
	binder trim,
	$= asParser trim,
	expr trim,
	$; asParser trim
	==> [ :x | x first bind: x third expr: x fifth ]
	
]

{ #category : #accessing }
SpriteParser >> prog [
	^ decl star
	==> [ :decls | ΛExpression fromDecls: decls ]
]

{ #category : #accessing }
SpriteParser >> qual [
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
SpriteParser >> qualParam [
	^ self lowerId,
		$: asParser,
		(('int' asParser ==> [ :_x | Int sort ]) / ('bool' asParser  ==> [ :_x | Bool sort ]))
	==> [ :x | QualParam symbol: x first sort: x last ]
]

{ #category : #accessing }
SpriteParser >> qualParams [
	^ (self qualParam separatedBy: $, asParser trim ==>[:_x|nil]) parens
	==> [ :parms | parms reject: #isNil ]
]

{ #category : #accessing }
SpriteParser >> quals [
	^qual annotationBrackets trim star
]

{ #category : #accessing }
SpriteParser >> start [
	^ #space asParser star, prog end
	==> [ :x | x last ]
]
