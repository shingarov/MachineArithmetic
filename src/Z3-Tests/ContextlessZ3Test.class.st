"
There are very few things in Z3 that don't require a context.
This class is separate so that it doesn't need a #setUp to create a fresh global context.
"
Class {
	#name : #ContextlessZ3Test,
	#superclass : #TestCase,
	#category : #'Z3-Tests'
}

{ #category : #tests }
ContextlessZ3Test >> testFullVersion [
	| v |
	v := Z3 get_full_version.
	self assert: v isString
]

{ #category : #tests }
ContextlessZ3Test >> testGetVersion [
	| version |
	version := Z3 getVersion.
	self assert: version size equals: 4.
	self assert: version first equals: 4.

]

{ #category : #tests }
ContextlessZ3Test >> testIsVersionGreaterThan [

	self assert: (Z3 isVersion: #( 4 8 14 0 ) greaterThan: #( 4 8 7 )).
	self assert: (Z3 isVersion: #( 4 8 14) greaterThan: #( 4 8 7 )).
	self deny: (Z3 isVersion: #( 4 8 7 0 ) greaterThan: #( 4 8 7 0)).
	self deny: (Z3 isVersion: #( 4 8 7 0 ) greaterThan: #( 4 8 7)).
	self deny: (Z3 isVersion: #( 4 8 7 0 ) greaterThan: #( 4 8 14)).
	self deny: (Z3 isVersion: #( 4 8 ) greaterThan: #( 4 8 7)).

	self assert: (Z3 isVersionGreaterThan: #( 3 1 2 3 )).
	self deny: (Z3 isVersionGreaterThan: #( 5 )).
]

{ #category : #tests }
ContextlessZ3Test >> testSimpleExample [
	| ctx |
	ctx := Z3Context fromDefault.
	self assert: ctx class equals: Z3Context.
	self deny: ctx isNull.
	ctx release.
]

{ #category : #tests }
ContextlessZ3Test >> testSymbolFromString [
	| ctx sym |
	ctx := Z3Context fromDefault.
	sym := ctx mkSymbol: 123.
	self deny:   sym isStringSymbol.
	self assert:   sym isIntSymbol.
]

{ #category : #tests }
ContextlessZ3Test >> testTwoContexts [
	"Several logical context can be used simultaneously."

	| ctx1 ctx2 x y |
	ctx1 := Z3Context fromDefault.
	ctx2 := Z3Context fromDefault.
	self deny: ctx1 getHandle asInteger = ctx2 getHandle asInteger.
	x := ctx1 mkBoolVar: 'x'.
	y := ctx2 mkBoolVar: 'y'.
	ctx1 release.
	"ctx2 can still be used"
	self assert: y astToString equals: 'y'.
	ctx2 release
]

{ #category : #tests }
ContextlessZ3Test >> testTwoContexts2 [
	"Several logical contexts can be used simultaneously."

	| global ctx1 ctx2 x y |

	global := Z3Context current.
	ctx1 := Z3Context fromDefault.
	ctx2 := Z3Context fromDefault.
	self deny: ctx1 getHandle asInteger = ctx2 getHandle asInteger.

	Z3ContextQuery answer: ctx1 do: [
		self assert: global ~~ ctx1.
		self assert: Z3Context current == ctx1.
		x := 'x' toBool.
	].
	self assert: Z3Context current == global.
	global ensureValidZ3Object.
	self assert: global ~~ ctx1.
	self assert: x ctx == ctx1.

	Z3ContextQuery answer: ctx2 do: [
		self assert: global ~~ ctx2.
		self assert: Z3Context current == ctx2.
		y := 'y' toBool.
	].
	self assert: Z3Context current == global.
	global ensureValidZ3Object.
	self assert: global ~~ ctx2.
	self assert: y ctx == ctx2.

	ctx1 release.
	"ctx2 can still be used"
	self assert: y astToString equals: 'y'.
	ctx2 release.

	global ensureValidZ3Object.
]
