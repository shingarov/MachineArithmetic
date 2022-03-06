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
		'expr1'
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
		L1EApp mkEApp: f args: args ]
]

{ #category : #accessing }
SpriteParser >> binder [
	^identifier ==> [ :id | SpriteBind identifier: id ]
]

{ #category : #accessing }
SpriteParser >> decl [
	^ ann, plainDecl
	==> [ :ann_plain | SpriteDecl mkDecl: ann_plain last ann: ann_plain first ]
]

{ #category : #accessing }
SpriteParser >> expr [
	"we don't have Megaparsec's makeExprParser, so for now build by hand."
	^ (expr1 trim, '+' asParser trim, expr1 trim
	==> [ :x |
		| lhs op rhs |
		lhs := x first.
		op := x second.
		rhs := x third.
		L1EApp mkEApp: (L1EImm imm: (SpriteECon prim: (SpritePrimOp op: op))) args: { lhs immYourself . rhs immYourself } ])
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
		L1EFun mkEFun: xs expr: body ]
]

{ #category : #accessing }
SpriteParser >> identifier [
	^ (#letter asParser , #word asParser star) flatten trim
]

{ #category : #accessing }
SpriteParser >> imm [
	^ (identifier ==> [ :id | SpriteEVar symbol: id ])
	/ (natural    ==> [ :nat | SpritePInt integer: nat ])
]

{ #category : #accessing }
SpriteParser >> immExpr [
	^imm ==> [ :i | L1EImm imm: i ]
]

{ #category : #accessing }
SpriteParser >> letExpr [
	^'shouldBeImplemented' asParser
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
	^decl star
]

{ #category : #accessing }
SpriteParser >> start [
	^ #space asParser star, decl star end
	==> [ :x | x last ]
]
