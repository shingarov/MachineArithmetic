Class {
	#name : #DataTypeParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Parser'
}

{ #category : #tests }
DataTypeParserTest >> testCtor0 [
	| ctor |
	ctor := (DataTypeParser new ctorP) end parse: 'Nil
'.
	self deny: ctor isPetitFailure.
	self assert: ctor dc id equals: 'Nil'.
	self assert: ctor xts isEmpty.
	self assert: ctor r isNil.
]

{ #category : #tests }
DataTypeParserTest >> testCtor1 [
	| ctor |
	ctor := (DataTypeParser new ctorP) end parse: 'Nil     => [v| len v = 0]
'.
	self deny: ctor isPetitFailure.
	self assert: ctor dc id equals: 'Nil'.
	self assert: ctor xts isEmpty.
	self assert: ctor r isKnown.
]

{ #category : #tests }
DataTypeParserTest >> testCtor2 [
	| ctor |
	ctor := (DataTypeParser new ctorP) end parse: 'Cons(''a, ''b)
'.
	self deny: ctor isPetitFailure.
	self assert: ctor dc id equals: 'Cons'.
	self assert: ctor xts size equals: 2.
	self assert: ctor r isNil.
]

{ #category : #tests }
DataTypeParserTest >> testCtor3 [
	| ctor |
	ctor := (DataTypeParser new ctorP) end parse: 'Cons(''a, list(''a))
'.
	self deny: ctor isPetitFailure.
	self assert: ctor dc id equals: 'Cons'.
	self assert: ctor xts size equals: 2.
	self assert: ctor r isNil.
]

{ #category : #tests }
DataTypeParserTest >> testOlist01 [
	| typ |
	typ := DataTypeParser new end parse: 'type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x < v]))
  ;
'.
	self deny: typ isPetitFailure
]

{ #category : #tests }
DataTypeParserTest >> testXXXX [
	| typ |
	typ := DataTypeParser new end parse: 'type list(''a) =
  | Cons(''a, ''b)
  ;
'.
	self deny: typ isPetitFailure
]
