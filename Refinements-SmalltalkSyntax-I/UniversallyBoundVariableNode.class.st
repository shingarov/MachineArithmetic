Class {
	#name : #UniversallyBoundVariableNode,
	#superclass : #RBSortedArgumentNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'constraint generation' }
UniversallyBoundVariableNode >> quantificationBlockClass [
	^UniversalQuantificationNode
]
