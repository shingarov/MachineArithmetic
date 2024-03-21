Class {
	#name : #FormulaCoercionTest,
	#superclass : #TestCase,
	#category : #'CardanoTartaglia-Tests'
}

{ #category : #'mock objects' }
FormulaCoercionTest >> fx [
	"f(x) where we know nothing about f nor x"
	
	| f x |
	f := Cosa named: 'f'.
	x := DummyArg named: 'x'.
	^f value: x "or x∘f also works"
	
]

{ #category : #tests }
FormulaCoercionTest >> testCoerceToInteger [
	" 2 * f(x) where we know nothing about f nor x "
	
	| formula twice |
	formula := 2 * self fx.
	"
	One can't really do anything with it;
	at the time of writing, PureFormulae are only used in
	refactorAppP/refactorAppR, 	i.e. to work around a glitch
	in Sprite concrete syntax; we should get rid of the whole thing.
	In this test we just verify that coercing doesn't crash.
	"
	twice := formula * 2.
	self assert: (twice isKindOf: PureFormula)
]
