Class {
	#name : #DefineFun,
	#superclass : #Object,
	#instVars : [
		'j',
		'bindingsInSmt'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
DefineFun class >> of: j in: bindingsInSmt [
	^self basicNew j: j; bindingsInSmt: bindingsInSmt; yourself 
]

{ #category : #accessing }
DefineFun >> bindingsInSmt [
	^ bindingsInSmt
]

{ #category : #accessing }
DefineFun >> bindingsInSmt: anObject [
	bindingsInSmt := anObject
]

{ #category : #'as yet unclassified' }
DefineFun >> isKVar [
	^false
]

{ #category : #accessing }
DefineFun >> j [
	^ j
]

{ #category : #accessing }
DefineFun >> j: anObject [
	j := anObject
]

{ #category : #'as yet unclassified' }
DefineFun >> refaConjuncts [
	^{self}
]

{ #category : #'as yet unclassified' }
DefineFun >> subst1: newZ3AST for: varName [
	^self z3ast subst1: newZ3AST for: varName
]

{ #category : #'as yet unclassified' }
DefineFun >> z3ast [
	^bindingsInSmt at: j
	
]
