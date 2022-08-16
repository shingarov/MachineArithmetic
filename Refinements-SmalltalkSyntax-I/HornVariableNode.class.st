Class {
	#name : #HornVariableNode,
	#superclass : #BoundArgumentNode,
	#instVars : [
		'argSorts'
	],
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'instance creation' }
HornVariableNode class >> named: aString argSorts: aSequenceNode [
	^(self named: aString)
		domain: aSequenceNode;
		yourself
]

{ #category : #grammar }
HornVariableNode class >> parseBoundVariableNode: x parser: anRBParser [
	| domainNode |
	(anRBParser currentToken isSpecial and: [ anRBParser currentToken value = $( ]) ifFalse: [self error].
	anRBParser step.
	domainNode := anRBParser sequenceNodeClass new.
	(anRBParser parseStatements: false into: domainNode).
	(anRBParser currentToken isSpecial and: [ anRBParser currentToken value = $) ]) ifFalse: [self error].
	anRBParser step.
	^self named: x name argSorts: domainNode
]

{ #category : #visiting }
HornVariableNode >> acceptVisitor: v [
	(v respondsTo: #visitHornVariableNode:) ifFalse: [ ^super acceptVisitor: v ].
	^v visitHornVariableNode: self
]

{ #category : #accessing }
HornVariableNode >> argSorts [
	^ argSorts
]

{ #category : #accessing }
HornVariableNode >> argSorts: anObject [
	argSorts := anObject
]

{ #category : #quantification }
HornVariableNode >> forceCorrectClassOf: aBlockNode [
	^aBlockNode as: HornBlockNode
]

{ #category : #accessing }
HornVariableNode >> parent: aRBProgramNode [ 
	parent := aRBProgramNode.
	argSorts parent: aRBProgramNode.
]

{ #category : #printing }
HornVariableNode >> printOn: aStream [
	aStream
		nextPut: Character starOperator;
		nextPutAll: name
]
