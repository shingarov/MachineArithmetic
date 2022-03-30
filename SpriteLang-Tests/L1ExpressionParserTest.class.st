Class {
	#name : #L1ExpressionParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests'
}

{ #category : #tests }
L1ExpressionParserTest >> test42expr [
	| e |
	e := (SpriteParser new productionAt: #expr) end parse: '42'.
	self assert: e imm integer equals: 42
]

{ #category : #tests }
L1ExpressionParserTest >> testAplusB [
	| e |
	e := (SpriteParser new productionAt: #expr) end parse: 'a + b'.
	self assert: e imm imm symbol equals: 'b'
]

{ #category : #tests }
L1ExpressionParserTest >> testAppExpr [
	| f |
	f := (SpriteParser new productionAt: #appExpr) parse: 'f(x,y,z)'.
	self assert: f imm symbol equals: 'z'
]

{ #category : #tests }
L1ExpressionParserTest >> testBinder [
	| b |
	b := (SpriteParser new productionAt: #binder) end parse: 'x'.
	self assert: b id equals: 'x'
]

{ #category : #tests }
L1ExpressionParserTest >> testFun [
	| f |
	f := (SpriteParser new productionAt: #funExpr) parse: '(x) => { x + 1 }'.
	self assert: f bind id equals: 'x'
]

{ #category : #tests }
L1ExpressionParserTest >> testLet [
	| f |
	f := (SpriteParser new productionAt: #letExpr) parse: 'let tmp = inc(x); inc(tmp)'.
	self assert: (f isKindOf: ELet)
]

{ #category : #tests }
L1ExpressionParserTest >> testPlainDecl [
	| f |
	f := (SpriteParser new productionAt: #plainDecl) end parse: 'let inc = (x) => { x + 1 };'.
	self assert: (f isKindOf: Association)
]

{ #category : #tests }
L1ExpressionParserTest >> testXexpr [
	| e |
	e := (SpriteParser new productionAt: #expr) end parse: 'x'.
	self assert: e imm symbol equals: 'x'
]
