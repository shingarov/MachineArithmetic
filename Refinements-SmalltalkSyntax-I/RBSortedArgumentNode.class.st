Class {
	#name : #RBSortedArgumentNode,
	#superclass : #BoundArgumentNode,
	#instVars : [
		'sort',
		'reft'
	],
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'instance creation' }
RBSortedArgumentNode class >> named: v sort: s reft: r [
	^(self named: v)
		sort: s;
		reft: r;
		yourself
]

{ #category : #grammar }
RBSortedArgumentNode class >> parseBoundVariableNode: x parser: anRBParser [
	| sortNode |
	(anRBParser currentToken isBinary and: [anRBParser currentToken value = '∈']) ifFalse: [self error]. anRBParser step.
	sortNode := anRBParser parseQuantificationSort.
	^self
		named: x name
		sort: sortNode
		reft: anRBParser parseQuantificationRefinement
]

{ #category : #'constraint generation' }
RBSortedArgumentNode >> forceCorrectClassOf: aBlockNode [
	reft isNil ifFalse: [
		reft arguments add: aBlockNode arguments first.
		reft colons: aBlockNode colons
	].
	^aBlockNode as: self quantificationBlockClass
]

{ #category : #accessing }
RBSortedArgumentNode >> parent: aRBProgramNode [ 
	parent := aRBProgramNode.
	sort parent: aRBProgramNode.
	reft isNil ifFalse: [ reft parent: aRBProgramNode ]
]

{ #category : #'constraint generation' }
RBSortedArgumentNode >> quantificationBlockClass [
	self subclassResponsibility
]

{ #category : #accessing }
RBSortedArgumentNode >> reft [
	^ reft
]

{ #category : #accessing }
RBSortedArgumentNode >> reft: anObject [
	reft := anObject
]

{ #category : #accessing }
RBSortedArgumentNode >> sort [
	^ sort
]

{ #category : #accessing }
RBSortedArgumentNode >> sort: anObject [
	sort := anObject
]
