Class {
	#name : #UnsafeZ3NameTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MathNotation-Tests'
}

{ #category : #tests }
UnsafeZ3NameTest >> testIntName [
	| Z |
	Z := Int sort.
	self assert: Z name isZ3Symbol.
	self assert: Z name isStringSymbol.
	self deny:   Z name isIntSymbol.
	self assert: Z name getString equals: 'Int' "NB: NOT 'ℤ'!!!"
	
]

{ #category : #tests }
UnsafeZ3NameTest >> testUnsafeEnum [
	| fruit consts testers |
	consts  := Cell new.
	testers := Cell new.
	fruit := Z3DatatypeSort
		mkEnumerationSort: 'rotten#fruit' encodeUnsafe
		elements: { 'apple'. 'banana'. 'orange' }
		consts: consts
		testers: testers.
	self assert: fruit name isZ3Symbol.
	self assert: fruit name isStringSymbol.
	self deny:   fruit name isIntSymbol.
	self assert: fruit name getString equals: 'rottenß35ßfruit'.
	self assert: fruit unsafeName equals: 'rotten#fruit'
	
]

{ #category : #tests }
UnsafeZ3NameTest >> testUnsafeUninterpreted [
	| s |
	s := Z3Sort uninterpretedSortNamed: '(a b)' encodeUnsafe.
	self assert: s name isZ3Symbol.
	self assert: s name isStringSymbol.
	self deny:   s name isIntSymbol.
	self assert: s name getString equals: 'ß40ßaß32ßbß41ß'.
	self assert: s unsafeName equals: '(a b)'
	
]

{ #category : #tests }
UnsafeZ3NameTest >> testZahlenForInt [
	| Z |
	Z := Int sort.
	self assert: Z unsafeName equals: 'ℤ'
	
]
