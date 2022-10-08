Class {
	#name : #DataTypeParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Parser'
}

{ #category : #'tests - constructors' }
DataTypeParserTest >> ctorParser [
	^DataTypeParser new ctorP end
]

{ #category : #'tests - constructors' }
DataTypeParserTest >> testCtor0 [
	| ctor |
	ctor := self ctorParser parse: 'Nil
'.
	self deny: ctor isPetitFailure.
	self assert: ctor dc id equals: 'Nil'.
	self assert: ctor xts isEmpty.
	self assert: ctor r isNil.
]

{ #category : #'tests - constructors' }
DataTypeParserTest >> testCtor1 [
	| ctor |
	ctor := self ctorParser parse: 'Nil     => [v| len v = 0]
'.
	self deny: ctor isPetitFailure.
	self assert: ctor dc id equals: 'Nil'.
	self assert: ctor xts isEmpty.
	self assert: ctor r isKnown.
]

{ #category : #'tests - constructors' }
DataTypeParserTest >> testCtor2 [
	| ctor |
	ctor := self ctorParser parse: 'Cons(''a, ''b)
'.
	self deny: ctor isPetitFailure.
	self assert: ctor dc id equals: 'Cons'.
	self assert: ctor xts size equals: 2.
	self assert: ctor r isNil.
]

{ #category : #'tests - constructors' }
DataTypeParserTest >> testCtor3 [
	| ctor xts |
	ctor := self ctorParser parse: 'Cons(''a, list(''a))
'.
	self deny: ctor isPetitFailure.
	self assert: ctor dc id equals: 'Cons'.
	self assert: ctor r isNil.
	xts := ctor xts.
	self assert: xts size equals: 2.
	self assert: xts first key equals: String junkSymbol.
	self assert: xts second key equals: String junkSymbol.
	self assert: xts second value c equals: 'list'.
	self assert: xts second value ts size equals: 1.
	self assert: xts second value r expr isTauto.
	self assert: xts second value ts first b symbol equals: 'a'.
	self assert: xts second value ts first r expr isTauto.
]

{ #category : #'tests - datatypes' }
DataTypeParserTest >> testList1 [
	| typ |
	typ := DataTypeParser new end parse: 'type list(''a) =
  | Nil                      => [v| len v = 0]
  | Cons (x:''a, xs:list(''a)) => [v| len v = 1 + len(xs)]
  ;
'.
	self deny: typ isPetitFailure.
	self assert: typ name  equals: 'list'.
	self assert: typ vars  size equals: 1.
	self assert: typ ctors size equals: 2.
]
