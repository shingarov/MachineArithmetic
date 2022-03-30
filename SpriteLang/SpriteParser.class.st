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
		'binExpr'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
SpriteParser >> ann [
	^RTypeParser new
]

{ #category : #accessing }
SpriteParser >> appExpr [
	^ expr0, (imm separatedBy: $, asParser ==>[:_x|nil]) parens
	==> [ :f_args |
		| f args |
		f := f_args first.
		args := f_args second reject: #isNil.
		EApp mkEApp: f args: args ]
]

{ #category : #accessing }
SpriteParser >> binExpr [
	^ (self binExprFor: '+') / (self binExprFor: '-') / (self binExprFor: '*')
]

{ #category : #accessing }
SpriteParser >> binExprFor: selector [
	
	^ (expr1 trim, selector asParser trim, expr1 trim
	==> [ :x | "we don't have Megaparsec's makeExprParser, so for now build by hand."
		| lhs op rhs |
		lhs := x first.
		op := x second.
		rhs := x third.
		EApp
			mkEApp: (EImm
				imm: (ECon
					prim: (PBin
						primOp: (ΛPrimOp op: op))))
			args: { lhs imm . rhs imm } ])
]

{ #category : #accessing }
SpriteParser >> binder [
	^identifier ==> [ :id | SpriteBind identifier: id ]
]

{ #category : #accessing }
SpriteParser >> decl [
	^ ann optional, plainDecl
	==> [ :ann_plain | SpriteDecl mkDecl: ann_plain last ann: ann_plain first ]
]

{ #category : #accessing }
SpriteParser >> expr [
	^ binExpr
	/ expr1 trim
]

{ #category : #accessing }
SpriteParser >> expr0 [
	^ funExpr
	/ letExpr
	/ expr parens
	/ expr braces
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
	expr
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
SpriteParser >> imm [
	^ (identifier ==> [ :id | EVar symbol: id ])
	/ (natural    ==> [ :nat | ECon prim: (PInt integer: nat) ])
]

{ #category : #accessing }
SpriteParser >> immExpr [
	^imm ==> [ :i | EImm imm: i ]
]

{ #category : #accessing }
SpriteParser >> letExpr [
	^ decl, expr
	==> [ :d_e |
		ELet decl: d_e first expr: d_e last ]
]

{ #category : #accessing }
SpriteParser >> natural [
	^#digit asParser plus flatten trim
	==> [ :x | x asInteger ]
]

{ #category : #accessing }
SpriteParser >> plainDecl [
	^'let' asParser,
	#space asParser plus,
	binder trim,
	$= asParser trim,
	expr trim,
	$; asParser trim
	==> [ :x | SpriteDecl bind: x third expr: x fifth ]
	
]

{ #category : #accessing }
SpriteParser >> prog [
	^ decl star
	==> [ :decls | ΛExpression fromDecls: decls ]
]

{ #category : #accessing }
SpriteParser >> start [
	^ #space asParser star, prog end
	==> [ :x | x last ]
]
