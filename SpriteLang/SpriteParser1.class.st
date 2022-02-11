Class {
	#name : #SpriteParser1,
	#superclass : #SpriteParser,
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
		'immExpr'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
SpriteParser1 >> ann [
	^RTypeParser new
]

{ #category : #accessing }
SpriteParser1 >> binder [
	^identifier ==> [ :id | SpriteBind identifier: id ]
]

{ #category : #accessing }
SpriteParser1 >> decl [
	^ann trim, plainDecl trim
	==> [ :ann_plain | #mkDecl shouldBeImplemented  ]
]

{ #category : #accessing }
SpriteParser1 >> expr [
	^'{}' asParser
]

{ #category : #accessing }
SpriteParser1 >> expr0 [
	^ funExpr
	| letExpr
	| expr parens
	| expr braces
	| immExpr
]

{ #category : #accessing }
SpriteParser1 >> funExpr [
	^(binder, ($, asParser, binder) star) parens trim,
	'=>' asParser trim,
	'body' asParser
	==> [ :x |
  'body  <- expr
  return $ mkEFun xs body' shouldBeImplemented ]
]

{ #category : #accessing }
SpriteParser1 >> identifier [
	^ (#letter asParser , #word asParser star) flatten trim
]

{ #category : #accessing }
SpriteParser1 >> imm [
	^ (identifier ==> [ :id | SpriteEVar symbol: id ])
	| (natural    ==> [ :nat | SpritePInt integer: nat ])
]

{ #category : #accessing }
SpriteParser1 >> immExpr [
	^imm ==> [ :i | L1EImm imm: i ]
]

{ #category : #accessing }
SpriteParser1 >> letExpr [
	^'shouldBeImplemented' asParser
]

{ #category : #accessing }
SpriteParser1 >> natural [
	^#digit asParser plus flatten trim
	==> [ :x | x asInteger ]
]

{ #category : #accessing }
SpriteParser1 >> plainDecl [
	^'let' asParser,
	#space asParser plus,
	binder,
	$= asParser trim,
	expr trim,
	$; asParser
	==> [ :x | x third -> x fifth ]
	
]

{ #category : #accessing }
SpriteParser1 >> prog [
	^decl star
]

{ #category : #accessing }
SpriteParser1 >> start [
	^decl
]
