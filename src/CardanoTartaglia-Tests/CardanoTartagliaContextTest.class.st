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
	| context |
	
	context := self abc.
	self assert: (context evaluate: 'a, b') equals: 'AB'
]

{ #category : #tests }
CardanoTartagliaContextTest >> testUndeclaredVar [
	| context | 
	
	context := self abc.
	self should: [context evaluate: 'x+1'] raise: VariableNotDeclared.
	self should: [context evaluate: '1+x'] raise: VariableNotDeclared.
]
