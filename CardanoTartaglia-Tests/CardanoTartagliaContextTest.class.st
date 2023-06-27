Class {
	#name : #CardanoTartagliaContextTest,
	#superclass : #TestCase,
	#category : #'CardanoTartaglia-Tests'
}

{ #category : #tests }
CardanoTartagliaContextTest >> abc [
	^CardanoTartagliaContext ofVariables: (Dictionary newFromAssociations: {
		'a' -> 'A'.
		'b' -> 'B'.
		'c' -> 'C'.		
	} )
]

{ #category : #tests }
CardanoTartagliaContextTest >> testCompileInCTContext [
	| compiler |
	compiler := self class compiler class new.
	compiler context: self abc.
	self assert: (compiler evaluate: 'a, b') equals: 'AB'
]

{ #category : #tests }
CardanoTartagliaContextTest >> testUndeclaredVar [
	| compiler |
	compiler := self class compiler class new.
	compiler context: self abc.
	self should: [compiler evaluate: 'x+1'] raise: VariableNotDeclared
]
