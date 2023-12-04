Class {
	#name : #FormulaTest,
	#superclass : #TestCase,
	#category : #'CardanoTartaglia-Tests'
}

{ #category : #tests }
FormulaTest >> testAplusOne [
	| a ctContext compiler formula |
	a := Cosa named: 'a'.
	ctContext := CardanoTartagliaContext ofVariables: (Dictionary newFromAssociations: {'a'->a}).
	compiler := self class compiler class new.
	compiler context: ctContext.
	formula := compiler evaluate: 'a+1'.
	self assert: formula message selector equals: #+
]
