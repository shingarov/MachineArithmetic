Class {
	#name : #L1ExpressionParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests'
}

{ #category : #tests }
L1ExpressionParserTest >> testBinder [
	| b |
	b := (SpriteParser1 new productionAt: #binder) end parse: 'x'.
	self assert: b id equals: 'x'
]

{ #category : #tests }
L1ExpressionParserTest >> testFun [
	| f |
	f := (SpriteParser1 new productionAt: #funExpr) parse: '(x)=>body'.
	self assert: f s b == SpriteTInt instance.
]
