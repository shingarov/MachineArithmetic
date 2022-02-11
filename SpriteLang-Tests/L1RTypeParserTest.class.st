Class {
	#name : #L1RTypeParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests'
}

{ #category : #tests }
L1RTypeParserTest >> testAnn [
	| ann |
	ann := (RTypeParser new productionAt: #ann) end parse: '/*@ val inc: x:int=>int[v|v = x + 1] */'.
	self assert: ann key = 'inc'.
	self assert: ann value s b == SpriteTInt instance.
	self assert: ann value t b == SpriteTInt instance.
]

{ #category : #tests }
L1RTypeParserTest >> testFunArg [
	"parseWith funArg '' 'x:int'
	 --> ('x',TBase TInt true)"
	| funArg |
	funArg := (RTypeParser new productionAt: #funArg) parse: 'x:int'.
	self assert: funArg key equals: 'x'.
	self assert: funArg value b == SpriteTInt instance.
	self assert: funArg value r isNil
]

{ #category : #tests }
L1RTypeParserTest >> testFunArgAnon [
	| funArg |
	funArg := (RTypeParser new productionAt: #funArg) parse: 'int'.
	self assert: funArg key equals: '_'.
	self assert: funArg value b == SpriteTInt instance.
	self assert: funArg value r isNil
]

{ #category : #tests }
L1RTypeParserTest >> testRBase [
	| rbase |
	rbase := (RTypeParser new productionAt: #rbase) end parse: 'int[v|v = 3]'.
	self assert: rbase b == SpriteTInt instance.
	self assert: rbase r symbol equals: 'v'
]

{ #category : #tests }
L1RTypeParserTest >> testRFun1 [
	| rfun |
	rfun := (RTypeParser new productionAt: #rfun) end parse: 'int=>int'.
	self assert: rfun s b == SpriteTInt instance.
	self assert: rfun t b == SpriteTInt instance.
	self assert: rfun x equals: '_'.
]

{ #category : #tests }
L1RTypeParserTest >> testRFun2 [
	| rfun |
	rfun := (RTypeParser new productionAt: #rfun) end parse: 'x:int=>int'.
	self assert: rfun s b == SpriteTInt instance.
	self assert: rfun t b == SpriteTInt instance.
	self assert: rfun x equals: 'x'.
'
-- >>> parseWith rfun "" "x:int => int"
-- TFun "x" (TBase TInt true) (TBase TInt true)

-- >>> parseWith rfun "" "x:int => int{v|0 < v}"
-- TFun "x" (TBase TInt true) (TBase TInt (0 < v))

-- >>> parseWith rfun "" "x:int => int{v|0 <= v}"
-- TFun "x" (TBase TInt true) (TBase TInt (0 <= v))

-- >>> parseWith rfun "" "x:int{v|0 <= v} => int{v|0 <= v}"
-- TFun "x" (TBase TInt (0 <= v)) (TBase TInt (0 <= v))

-- >>> parseWith ann "" "/*@ val inc: x:int => int[v|v = x + 1] */"
'
]

{ #category : #tests }
L1RTypeParserTest >> testRFun3 [
	| rfun |
	rfun := (RTypeParser new productionAt: #rfun) end parse: 'x:int=>int[v|0 < v]'.
	self assert: rfun s b == SpriteTInt instance.
	self assert: rfun t b == SpriteTInt instance.
	self assert: rfun x equals: 'x'.
]

{ #category : #tests }
L1RTypeParserTest >> testRFun4 [
	| rfun |
	rfun := (RTypeParser new productionAt: #rfun) end parse: 'x:int[v|0 <= v]=>int[v|0 < v]'.
	self assert: rfun s b == SpriteTInt instance.
	self assert: rfun t b == SpriteTInt instance.
	self assert: rfun x equals: 'x'.
'

-- >>> parseWith ann "" "/*@ val inc: x:int => int[v|v = x + 1] */"
'
]

{ #category : #tests }
L1RTypeParserTest >> testRefTop [
	| reftb |
	reftb := (RTypeParser new productionAt: #refTop) end parse: '[v|v = 3]'.
	self assert: reftb symbol equals: 'v'
]

{ #category : #tests }
L1RTypeParserTest >> testReftB [
	| reftb |
	reftb := (RTypeParser new productionAt: #reftB) end parse: 'v|v = 3'.
	self assert: reftb symbol equals: 'v'
]

{ #category : #tests }
L1RTypeParserTest >> testTInt [
	| int |
	int := (RTypeParser new productionAt: #tbase) parse: 'int'.
	self assert: int == SpriteTInt instance
]

{ #category : #tests }
L1RTypeParserTest >> testTrivialRBase [
	| rbase |
	rbase := (RTypeParser new productionAt: #rbase) end parse: 'int'.
	self assert: rbase b == SpriteTInt instance.
	self assert: rbase r isNil
]
